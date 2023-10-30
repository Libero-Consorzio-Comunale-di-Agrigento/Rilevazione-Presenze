unit W049UAutocertificazioneDatiGiuridici;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R012UWebAnagrafico, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, OracleData, Math, StrUtils, A000UMessaggi, W000UMessaggi,
  A000UInterfaccia, IWCompListbox, meIWComboBox, IWCompEdit,
  meIWEdit, IWApplication, Data.DB, C180FunzioniGenerali, IWCompGrids, meIWGrid,
  IWDBGrids, medpIWDBGrid, C190FunzioniGeneraliWeb, meIWImageFile,
  W049UAutocertificazioneDatiGiuridiciDM, W049UCaricamentoFM, W049UCaricamentoAspettativaFM,
  Datasnap.Win.MConnect, Datasnap.DBClient, A000UCostanti, Winapi.ActiveX, IWCompExtCtrls, medpIWImageButton, System.JSON;

type
  TW049FAutocertificazioneDatiGiuridici = class(TR012FWebAnagrafico)
    grdDatiGiuridici: TmedpIWDBGrid;
    grdRapportiEnte: TmedpIWDBGrid;
    grdPeriodiAspettativa: TmedpIWDBGrid;
    grdRiepilogo: TmeIWGrid;
    DCOMConnection1: TDCOMConnection;
    btnStampa: TmeIWButton;
    lblDataI: TmeIWLabel;
    lblDataF: TmeIWLabel;
    edtDataI: TmeIWEdit;
    edtDataF: TmeIWEdit;
    grdPeriodiAspettativaArchivio: TmedpIWDBGrid;
    procedure IWAppFormCreate(Sender: TObject);
    procedure grdDatiGiuridiciAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure grdPeriodiAspettativaAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure btnStampaClick(Sender: TObject);
  private
    { Private declarations }
    W049DM:TW049FAutocertificazioneDatiGiuridiciDM;
    W049Car:TW049FCaricamentoFM;
    W049CarAsp:TW049FCaricamentoAspettativaFM;
    procedure AggiornaGrdDatiGiuridici;
    procedure AggiornaGrdPeriodiAspettativa;
    procedure CallDCOMPrinter;
    procedure CreaFrame(Griglia:TmedpIWDBGrid;Operazione,FN:String);
    procedure CreaFramePeriodoAspettativa(Griglia:TmedpIWDBGrid;Operazione,FN:String);
    procedure imgAccediAspettativaClick(Sender: TObject);
    procedure imgAccediDatoClick(Sender: TObject);
    procedure imgInserisciAspettativaClick(Sender: TObject);
    procedure imgInserisciDatoClick(Sender: TObject);
    procedure GetDatiGiuridici;
    procedure GetPeriodiAspettativa;
    procedure GetRapportiEnte;
    procedure GetRiepilogoPeriodi;
    procedure PreparaComponenti(Griglia:TmedpIWDBGrid);
    procedure PreparaGriglia(Griglia:TmedpIWDBGrid;DataSet:TOracleDataSet);
    function ControllaIntersezione(Sender: TObject): Boolean;
    function CreateJSonString: String;
  protected
    procedure VisualizzaDipendenteCorrente; override;
  public
    { Public declarations }
    function InizializzaAccesso:Boolean; override;
    procedure EseguiStampa;
  end;

var
  W049FAutocertificazioneDatiGiuridici: TW049FAutocertificazioneDatiGiuridici;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TW049FAutocertificazioneDatiGiuridici.EseguiStampa;
begin
  CallDCOMPrinter;
end;

function TW049FAutocertificazioneDatiGiuridici.CreateJSonString: String;
var json: TJSONObject;
begin
  json:=TJSONObject.Create;
  try
    //Popolo il json con i valori necessari al B028 per creare il PDF per la stampa
    json.AddPair('StandardPrinter',IfThen(Pos(INI_PAR_USE_STANDARD_PRINTER,W000ParConfig.ParametriAvanzati) > 0,'S','N'));
    json.AddPair('StampaDal', edtDataI.Text); //DateToStr(DATE_MIN));
    json.AddPair('StampaAl', edtDataF.Text); //DateToStr(DATE_MAX));
    Result:=json.ToString;
  finally
    FreeAndNil(json);
  end;
end;

procedure TW049FAutocertificazioneDatiGiuridici.CallDCOMPrinter;
var DettaglioLog:OleVariant;
    DatiUtente: String;
begin
  try
    //Chiamo Servizio COM B028 per creare il pdf su server
    DCOMNomeFile:=GetNomeFile('pdf');
    ForceDirectories(ExtractFileDir(DCOMNomeFile));
    DatiUtente:=CreateJSonString;
    if (not IsLibrary) and
       (Pos(INI_PAR_NO_COINITIALIZE,W000ParConfig.ParametriAvanzati) = 0) then // gestione parametri di configurazione su file
      CoInitialize(nil);
    if not DCOMConnection1.Connected then
      DCOMConnection1.Connected:=True;
    try
      A000SessioneWEB.AnnullaTimeOut;
      DCOMConnection1.AppServer.PrintA202(selAnagrafeW.SubstitutedSQL,
                                          DCOMNomeFile,
                                          Parametri.Operatore,
                                          Parametri.Azienda,
                                          WR000DM.selAnagrafe.Session.LogonDataBase,
                                          DatiUtente,
                                          DettaglioLog);
    finally
      DCOMConnection1.Connected:=False;
      A000SessioneWEB.RipristinaTimeOut;
    end;
    if FileExists(DCOMNomeFile) then
      VisualizzaFile(DCOMNomeFile,'Autocertificazione periodi giuridici',nil,nil)
    else                                            //'File pdf inesistente!'
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_W004_ERR_TAB_NON_COMPATIBILE));
  except
    on E:Exception do                                      //'File pdf inesistente!'
      raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_W004_FMT_STAMPA_NON_DISPONIB),[E.message]));
  end;
end;


function TW049FAutocertificazioneDatiGiuridici.ControllaIntersezione(Sender: TObject): Boolean;
begin
  with W049DM.A202MW.selT055 do
  begin
    First;
    while not Eof do
    begin
      if (W049DM.A202MW.selT055.FieldByName('DAL').AsDateTime >= W049DM.A202MW.selt425.fieldbyname('INIZIO').AsDateTime)
      and (W049DM.A202MW.selT055.FieldByName('AL').AsDateTime <= W049DM.A202MW.selt425.fieldbyname('FINE').AsDateTime) then
      begin
        Result:=False;
        raise exception.Create('Impossibile eliminare il periodo giuridico in quanto include il periodo di aspettativa dal ' +
          W049DM.A202MW.selT055.FieldByName('DAL').AsString + ' al ' + W049DM.A202MW.selT055.FieldByName('AL').AsString);
      end;
      Next;
    end;
  end;
  Result:=True;
end;

procedure TW049FAutocertificazioneDatiGiuridici.grdDatiGiuridiciAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var i:integer;
begin
  inherited;
  grdDatiGiuridici.OnBeforeCancella:=ControllaIntersezione;
  with grdDatiGiuridici do
  begin
    if not SolaLettura then
      (medpCompCella(0,0,0) as TmeIWImageFile).OnClick:=imgInserisciDatoClick;
    for i:=IfThen(medpComandiInsert,1,0) to High(medpCompGriglia) do
    begin
      if (medpCompGriglia[i].CompColonne[0] <> nil) then
        (medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,0].Css:='invisibile';
      //Associo l'evento OnClick alle icone dei comandi
      if not SolaLettura then
      begin
        if (medpCompGriglia[i].CompColonne[0] <> nil) then
        begin
          if R180In(medpValoreColonna(i,'VALIDAZIONE'), ['N','D','A']) then
          begin
            //Cancellazione
            (medpCompCella(i,0,1) as TmeIWImageFile).Confirmation:='Attenzione!' + CRLF +
            'Si è certi di voler proseguire con la cancellazione definitiva del dato selezionato?';
            //Modifica
            (medpCompCella(i,0,4) as TmeIWImageFile).OnClick:=imgAccediDatoClick;
          end
          else
          begin
            //Cancellazione
            (medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,1].Css:='invisibile';
            //Modifica
            (medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,2].Css:='invisibile';
            //Visualizzazione
            (medpCompCella(i,0,4) as TmeIWImageFile).OnClick:=imgAccediDatoClick;
          end;
        end
      end
      else
      begin
        //Cancellazione
        (medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,1].Css:='invisibile';
        //Modifica
        (medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,2].Css:='invisibile';
      end;
    end;
  end;
  GetRiepilogoPeriodi;
end;

procedure TW049FAutocertificazioneDatiGiuridici.grdPeriodiAspettativaAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var i : integer;
begin
  inherited;
  with grdPeriodiAspettativa do
  begin
    if not SolaLettura then
      (medpCompCella(0,0,0) as TmeIWImageFile).OnClick:=imgInserisciAspettativaClick;
    for i:=IfThen(medpComandiInsert,1,0) to High(medpCompGriglia) do
    begin
      if (medpCompGriglia[i].CompColonne[0] <> nil) then
        (medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,0].Css:='invisibile';
      //Associo l'evento OnClick alle icone dei comandi
      if not SolaLettura then
      begin
        if (medpCompGriglia[i].CompColonne[0] <> nil) then
        begin
          if (medpValoreColonna(i,'VALIDAZIONE') = 'N') then
          begin
            //Cancellazione
            (medpCompCella(i,0,1) as TmeIWImageFile).Confirmation:='Attenzione!' + CRLF +
            'Si è certi di voler proseguire con la cancellazione definitiva del dato selezionato?';
            //Modifica
            (medpCompCella(i,0,4) as TmeIWImageFile).OnClick:=imgAccediAspettativaClick;
          end
          else
          begin
            //Cancellazione
            (medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,1].Css:='invisibile';
            //Modifica
            (medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,2].Css:='invisibile';
            //Visualizzazione
            (medpCompCella(i,0,4) as TmeIWImageFile).OnClick:=imgAccediAspettativaClick;
          end;
        end
      end
      else
      begin
        //Cancellazione
        (medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,1].Css:='invisibile';
        //Modifica
        (medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,2].Css:='invisibile';
      end;
    end;
  end;
end;

procedure TW049FAutocertificazioneDatiGiuridici.GetRapportiEnte;
begin
  grdRapportiEnte.medpAggiornaCDS;
  grdPeriodiAspettativaArchivio.medpAggiornaCDS;
end;

procedure TW049FAutocertificazioneDatiGiuridici.GetDatiGiuridici;
begin
  {with W049DM.A202MW do
  begin
    R180SetVariable(selT425,'PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    selT425.Open;
    selT425.First;
  end;}
  grdDatiGiuridici.medpAggiornaCDS;
end;

procedure TW049FAutocertificazioneDatiGiuridici.GetPeriodiAspettativa;
begin
  with W049DM do
  begin
    //R180SetVariable(A202MW.selT055,'PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    R180SetVariable(selT055Copy,'PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    R180SetVariable(selT040,'PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    //A202MW.selT055.Open;
    //A202MW.selT055.First;
    selT055Copy.Open;
    selT055Copy.First;
  end;
  grdPeriodiAspettativa.medpAggiornaCDS;
end;

procedure TW049FAutocertificazioneDatiGiuridici.VisualizzaDipendenteCorrente;
begin
inherited;
  ParametriForm.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  W049DM.A202MW.CambiaProgressivo(ParametriForm.Progressivo);
  GetDatiGiuridici;
  GetRapportiEnte;
  GetPeriodiAspettativa;
  GetRiepilogoPeriodi;
end;


function TW049FAutocertificazioneDatiGiuridici.InizializzaAccesso:Boolean;
begin
  Result:=True;
  GetDipendentiDisponibili(Parametri.DataLavoro);
  selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]);
  VisualizzaDipendenteCorrente;
end;

procedure TW049FAutocertificazioneDatiGiuridici.IWAppFormCreate(Sender: TObject);
var i,j: integer;
begin
  inherited;
  W049DM:=TW049FAutocertificazioneDatiGiuridiciDM.Create(nil);
  W049DM.selAnagrafeW:=selAnagrafeW;
  PreparaGriglia(grdDatiGiuridici,W049DM.A202MW.selT425);
  W049DM.A202MW.selT430.ReadOnly:=True;
  W049DM.A202MW.selT040.ReadOnly:=True;

  PreparaGriglia(grdRapportiEnte,W049DM.A202MW.selT430);
  PreparaGriglia(grdPeriodiAspettativa,W049DM.A202MW.selT055);
  PreparaGriglia(grdPeriodiAspettativaArchivio,W049DM.A202MW.selT040);

  //Grid riepilogo
  with grdRiepilogo do
  begin
    ColumnCount:=7;
    RowCount:=4;

    for i:=0 to ColumnCount-1 do
    begin
      Cell[0,i].Alignment:=taCenter;
      Cell[0,i].Css:='riga_intestazione';
      Cell[1,i].Css:='riga_colorata';
      Cell[2,i].Css:='riga_bianca';
      Cell[3,i].Css:='riga_colorata';
    end;

    for i:=1 to RowCount-1 do
    begin
      Cell[i,0].Alignment:=taLeftJustify;
      for j:=1 to ColumnCount-1 do
        Cell[i,j].Alignment:=taRightJustify;
    end;
    Cell[1,0].Text:='Servizi prestati totale';
    Cell[2,0].Text:='Servizi prestati a tempo indeterminato';
    Cell[3,0].Text:='Servizi prestati rapportati al part time';
    Cell[0,1].Text:='Complessivo (giorni)';
    Cell[0,2].Text:='Complessivo (anni)';
    Cell[0,3].Text:='Da approvare (giorni)';
    Cell[0,4].Text:='Da approvare (anni)';

    Cell[0,5].Text:='Anzianità 5 anni';
    Cell[0,6].Text:='Anzianità 15 anni';
  end;
end;

procedure TW049FAutocertificazioneDatiGiuridici.GetRiepilogoPeriodi;
begin
  if selAnagrafeW.State = dsInactive then
    Exit;

  with W049DM.A202MW do
  begin
    selRiepilogo.Close;
    R180SetVariable(selRiepilogo,'PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    selRiepilogo.Open;
    selRiepilogo.First;
  end;

  with grdRiepilogo do
  begin
    //Servizi prestati totale (approvati+non approvati) [gg];
    Cell[1,1].Text:=W049DM.A202MW.selRiepilogo.FieldByName('G_ALL').AsString;
    //Servizi prestati totale (approvati+non approvati) [anni];
    Cell[1,2].Text:=FloatToStrF(W049DM.A202MW.selRiepilogo.FieldByName('G_ALL').AsInteger / 365, ffNumber, 50, 2);

    //Servizi prestati a tempo indeterminato (approvati+non approvati) [gg];
    Cell[2,1].Text:=W049DM.A202MW.selRiepilogo.FieldByName('G_TI').AsString;
    //Servizi prestati a tempo indeterminato (approvati+non approvati) [anni];
    Cell[2,2].Text:=FloatToStrF(W049DM.A202MW.selRiepilogo.FieldByName('G_TI').AsInteger / 365, ffNumber, 50, 2);

    //Servizi prestati totale (non approvati) [gg];
    Cell[1,3].Text:=W049DM.A202MW.selRiepilogo.FieldByName('G_ALL_NA').AsString;
    //Servizi prestati totale (non approvati) [anni];
    Cell[1,4].Text:=FloatToStrF(W049DM.A202MW.selRiepilogo.FieldByName('G_ALL_NA').AsInteger / 365, ffNumber, 50, 2);

    //Servizi prestati a tempo indeterminato (non approvati) [gg];
    Cell[2,3].Text:=W049DM.A202MW.selRiepilogo.FieldByName('G_TI_NA').AsString;
    //Servizi prestati a tempo indeterminato (non approvati) [anni];
    Cell[2,4].Text:=FloatToStrF(W049DM.A202MW.selRiepilogo.FieldByName('G_TI_NA').AsInteger / 365, ffNumber, 50, 2);

    //Servizi prestati rapportati al part time totale FTE (approvati+non approvati) [gg];
    Cell[3,1].Text:=W049DM.A202MW.selRiepilogo.FieldByName('G_FTE_ALL').AsString;
    //Servizi prestati rapportati al part time totale FTE (approvati+non approvati) [anni];
    Cell[3,2].Text:=FloatToStrF(W049DM.A202MW.selRiepilogo.FieldByName('G_FTE_ALL').AsInteger / 365, ffNumber, 50, 2);

    //Servizi prestati rapportati al part time FTE (non approvati) [gg];
    Cell[3,3].Text:=W049DM.A202MW.selRiepilogo.FieldByName('G_FTE_NA').AsString;
    //Servizi prestati rapportati al part time FTE (non approvati) [anni];
    Cell[3,4].Text:=FloatToStrF(W049DM.A202MW.selRiepilogo.FieldByName('G_FTE_NA').AsInteger / 365, ffNumber, 50, 2);

    //Data maturazione anzianità 5 anni
    Cell[1,5].Text:=W049DM.A202MW.selRiepilogo.FieldByName('DT_ANZ_5').AsString;
    //Data maturazione anzianità 15 anni
    Cell[1,6].Text:=W049DM.A202MW.selRiepilogo.FieldByName('DT_ANZ_15').AsString;

    Cell[2,5].Text:='-';
    Cell[2,6].Text:='-';
    Cell[3,5].Text:='-';
    Cell[3,6].Text:='-';
  end;
end;

procedure TW049FAutocertificazioneDatiGiuridici.PreparaGriglia(Griglia:TmedpIWDBGrid; DataSet:TOracleDataSet);
begin
  Griglia.medpPaginazione:=True;
  Griglia.medpTestoNoRecord:=A000TraduzioneStringhe(A000MSG_W033_MSG_NESSUN_DATO);
  Griglia.medpDataset:=DataSet;
  DataSet.Open;
  Griglia.medpComandiCustom:=(DataSet <> W049DM.A202MW.selT430) and (DataSet <> W049DM.A202MW.selT040);//True;
  Griglia.medpAttivaGrid(DataSet,(not SolaLettura) and (not DataSet.ReadOnly),(not SolaLettura) and (not DataSet.ReadOnly),(not SolaLettura) and (not DataSet.ReadOnly));
  Griglia.medpCancellaRigaWR102;
  if Griglia.medpComandiCustom then
    PreparaComponenti(Griglia);
  Griglia.medpCaricaCDS;
end;

procedure TW049FAutocertificazioneDatiGiuridici.PreparaComponenti(Griglia:TmedpIWDBGrid);
begin
  with Griglia do
  begin
    medpPreparaComponentiDefault;
    medpPreparaComponenteGenerico('R',0,4,DBG_IMG,'','ACCEDI','Accedi','','S');
  end;
end;

procedure TW049FAutocertificazioneDatiGiuridici.imgInserisciDatoClick(Sender: TObject);
begin
  CreaFrame(grdDatiGiuridici,'I',(Sender as TmeIWImageFile).FriendlyName);
end;

procedure TW049FAutocertificazioneDatiGiuridici.imgInserisciAspettativaClick(Sender: TObject);
begin
  CreaFramePeriodoAspettativa(grdPeriodiAspettativa,'I',(Sender as TmeIWImageFile).FriendlyName);
end;

procedure TW049FAutocertificazioneDatiGiuridici.imgAccediAspettativaClick(Sender: TObject);
begin
  CreaFramePeriodoAspettativa(grdPeriodiAspettativa,'M',(Sender as TmeIWImageFile).FriendlyName);
end;

procedure TW049FAutocertificazioneDatiGiuridici.imgAccediDatoClick(Sender: TObject);
begin
  CreaFrame(grdDatiGiuridici,'M',(Sender as TmeIWImageFile).FriendlyName);
end;

procedure TW049FAutocertificazioneDatiGiuridici.AggiornaGrdDatiGiuridici;
begin
  W049DM.A202MW.selT425.Refresh;
  GetDatiGiuridici;
  GetRiepilogoPeriodi;
end;

procedure TW049FAutocertificazioneDatiGiuridici.AggiornaGrdPeriodiAspettativa;
begin
  W049DM.A202MW.selT055.Refresh;
  GetPeriodiAspettativa;
  GetRiepilogoPeriodi;
end;

procedure TW049FAutocertificazioneDatiGiuridici.btnStampaClick(Sender: TObject);
begin
  inherited;
  EseguiStampa;
end;

procedure TW049FAutocertificazioneDatiGiuridici.CreaFrame(Griglia:TmedpIWDBGrid;Operazione,FN:String);
begin
  Griglia.medpColumnClick(nil,FN);
  //Apro frame di gestione dati
  W049Car:=TW049FCaricamentoFM.Create(Self);

  if Operazione = 'M' then //MODIFICA
    if W049DM.A202MW.selt425.fieldbyname('VALIDAZIONE').AsString = 'S' then
      Operazione:='L'; //SOLA LETTURA

  W049Car.ReadOnly:=SolaLettura;
  W049Car.W049DM2:=W049DM;
  W049Car.NotificaChiusura:=AggiornaGrdDatiGiuridici;
  W049Car.AzioneRichiamo:=Operazione;
  W049Car.Apri;
  if Operazione = 'I' then
    W049Car.DataSetCar.FieldByName('PROGRESSIVO').AsInteger:=ParametriForm.Progressivo;
  W049Car.Visualizza;
end;

procedure TW049FAutocertificazioneDatiGiuridici.CreaFramePeriodoAspettativa(Griglia:TmedpIWDBGrid;Operazione,FN:String);
begin
  Griglia.medpColumnClick(nil,FN);
  //Apro frame di gestione dati
  W049CarAsp:=TW049FCaricamentoAspettativaFM.Create(Self);

  if Operazione = 'M' then //MODIFICA
    if W049DM.A202MW.selT055.fieldbyname('VALIDAZIONE').AsString = 'S' then
      Operazione:='L'; //SOLA LETTURA

  W049CarAsp.ReadOnly:=SolaLettura;
  W049CarAsp.W049DM2:=W049DM;
  W049CarAsp.NotificaChiusura:=AggiornaGrdPeriodiAspettativa;
  W049CarAsp.AzioneRichiamo:=Operazione;
  W049CarAsp.Apri;
  if Operazione = 'I' then
    W049CarAsp.DataSetCar.FieldByName('PROGRESSIVO').AsInteger:=ParametriForm.Progressivo;
  W049CarAsp.Visualizza;
end;

end.
