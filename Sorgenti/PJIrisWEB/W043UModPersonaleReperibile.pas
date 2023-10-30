unit W043UModPersonaleReperibile;

interface

uses
  A000UCostanti,
  A000UInterfaccia,
  A000USessione,
  C180FunzioniGenerali,
  C190FunzioniGeneraliWeb,
  FunzioniGenerali,
  R012UWebAnagrafico,
  W000UMessaggi,
  W001UIrisWebDtM,
  W004UModificaRecapitiFM,
  W043UModPersonaleReperibileDM,
  System.SysUtils, System.Classes, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompLabel, meIWLabel, IWCompEdit, meIWEdit,
  IWCompGrids, meIWGrid, IWCompButton, meIWButton, Vcl.Controls,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, IWApplication, IWCompJQueryWidget, IWCompListbox,
  meIWComboBox, System.StrUtils, IWDBGrids, medpIWDBGrid, medpIWMessageDlg,
  Data.DB, Datasnap.DBClient, IWCompExtCtrls, meIWImageFile,
  medpIWMultiColumnComboBox;

type
  TW043TipoOperazione = (toSpostaDaDip1ADip2, toSpostaDaDip2ADip1);

  TW043FModPersonaleReperibile = class(TR012FWebAnagrafico)
    lblDataPianificazione: TmeIWLabel;
    edtDataPianificazione: TmeIWEdit;
    lblFiltroDato1: TmeIWLabel;
    lblLegendaFiltri: TmeIWLabel;
    lblFiltroDato2: TmeIWLabel;
    lblDipendente1: TmeIWLabel;
    lblDipendente2: TmeIWLabel;
    cmbDipendente1: TmeIWComboBox;
    cmbDipendente2: TmeIWComboBox;
    grdTurniDip1: TmedpIWDBGrid;
    grdTurniDip2: TmedpIWDBGrid;
    cdsTurniDipDa: TClientDataSet;
    dsrTurniDipDa: TDataSource;
    cdsTurniDipA: TClientDataSet;
    dsrTurniDipA: TDataSource;
    lblInfoLimitiData: TmeIWLabel;
    lblIndicareData: TmeIWLabel;
    btnHdnLeggiPianif: TmeIWButton;
    cmbFiltroDato1: TMedpIWMultiColumnComboBox;
    cmbFiltroDato2: TMedpIWMultiColumnComboBox;
    lblFiltroDato1Desc: TmeIWLabel;
    lblFiltroDato2Desc: TmeIWLabel;
    lblFiltroAreaSquadra: TmeIWLabel;
    cmbFiltroAreaSquadra: TMedpIWMultiColumnComboBox;
    lblFiltroAreaSquadraDesc: TmeIWLabel;
    procedure IWAppFormCreate(Sender: TObject);
    procedure grdTurniDip1AfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure cmbDipendente1Change(Sender: TObject);
    procedure cmbDipendente2Change(Sender: TObject);
    procedure grdTurniDip2AfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure edtDataPianificazioneAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure btnHdnLeggiPianifClick(Sender: TObject);
    procedure cmbFiltroDato1Change(Sender: TObject; Index: Integer);
    procedure cmbFiltroDato2Change(Sender: TObject; Index: Integer);
    procedure cmbFiltroAreaSquadraChange(Sender: TObject; Index: Integer);
  private
    bPrimaLetturaTurni:Boolean;
    jqInterno:TIWJQueryWidget;
    FDatoFiltro1: TDatoFiltro;
    FDatoFiltro2: TDatoFiltro;

    // Usati per l'operazione di spostamento
    FProgDipDa,FProgDipA:Integer;
    FDataTurno:TDateTime;
    FCodiceTurno,FPriorita,FRecapito,FRecapitoAdd,FDatoAgg1,FDatoAgg2:String;
    // Solo per visualizzazione, se il turno ha la sigla equivale alla sigla, se no al codice del turno
    FCodiceSiglaTurno:String;
    FDescrizioneTurno:String;
    FNomeDipDa,FNomeDipA:String;

    W004FModificaRecapitiFM:TW004FModificaRecapitiFM;
    // Usati nella modifica del recapito alternativo
    FProgDipModRecapito:Integer;
    FDataTurnoModRecapito:TDateTime;
    FNumTurnoModRecapito:Integer;

    DatoRecapito: String; //Campo recapito alternativo

    // Lettura dipendenti / pianificazione
    procedure OttieniControllaData(const DataInStr:String;
                                   var DataOut:TDateTime);
    procedure LeggiPianificazioneTurni;
    // Handler pulsanti tabella
    procedure imgSpostaTurnoDip1Dip2Click(Sender: TObject);
    procedure imgModificaRecapitiDip1Click(Sender: TObject);
    procedure imgSpostaTurnoDip2Dip1Click(Sender: TObject);
    procedure imgModificaRecapitiDip2Click(Sender: TObject);
    // Spostamento turni
    procedure PreparaSpostamento(IDRiga:Integer;
                                 TipoOperazione:TW043TipoOperazione);
    procedure OnConfermaSpostamento(Sender: TObject; ModalResult: TmeIWModalResult; KeyID: String);
    procedure SpostaTurno;
    // Modifica recapito alternativo
    procedure ApriModificaRecapito(Progressivo:Integer;DataPianif:TDateTime;NumeroTurno:Integer;Recapito:String);
  public
    Dati:String;
    NumGiorniModificabili:Integer;
    DataMinima,DataMassima:TDateTime;
    W043DM:TW043FModPersonaleReperibileDM;
    function InizializzaAccesso:Boolean; override;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure RefreshPage; override;
    procedure DistruggiOggetti; override;
  end;

implementation

{$R *.dfm}

procedure TW043FModPersonaleReperibile.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  bPrimaLetturaTurni:=True;
  // Creazione DM principale
  W043DM:=TW043FModPersonaleReperibileDM.Create(Self);

  // JQuery Widget
  jqInterno:=TIWJQueryWidget.Create(Self);

  // imposta i dati liberi per filtrare i dipendenti (1 e 2)
  lblFiltroDato1.Visible:=Parametri.CampiRiferimento.C29_ChiamateRepFiltro1 <> '';
  lblFiltroDato1.Caption:=R180Capitalize(Parametri.CampiRiferimento.C29_ChiamateRepFiltro1);
  cmbFiltroDato1.Visible:=lblFiltroDato1.Visible;
  cmbFiltroDato1.ColumnSeparator:=NAME_VALUE_SEPARATOR;
  lblFiltroDato1Desc.Visible:=lblFiltroDato1.Visible;
  lblFiltroDato1Desc.Caption:='';

  lblFiltroDato2.Visible:=Parametri.CampiRiferimento.C29_ChiamateRepFiltro2 <> '';
  lblFiltroDato2.Caption:=R180Capitalize(Parametri.CampiRiferimento.C29_ChiamateRepFiltro2);
  cmbFiltroDato2.Visible:=lblFiltroDato2.Visible;
  cmbFiltroDato2.ColumnSeparator:=NAME_VALUE_SEPARATOR;
  lblFiltroDato2Desc.Visible:=lblFiltroDato2.Visible;
  lblFiltroDato2Desc.Caption:='';

  lblFiltroAreaSquadra.Visible:=W043DM.selT651.RecordCount > 0;
  lblFiltroAreaSquadra.Caption:='Area afferenza';
  cmbFiltroAreaSquadra.Visible:=lblFiltroAreaSquadra.Visible;
  cmbFiltroAreaSquadra.ColumnSeparator:=NAME_VALUE_SEPARATOR;
  lblFiltroAreaSquadra.Visible:=lblFiltroAreaSquadra.Visible;
  lblFiltroAreaSquadraDesc.Caption:='';

  WR000DM.SetDatoLibero(Parametri.CampiRiferimento.C29_ChiamateRepFiltro1,FDatoFiltro1, True);
  WR000DM.SetDatoLibero(Parametri.CampiRiferimento.C29_ChiamateRepFiltro2,FDatoFiltro2);

  // dato recapito
  if Parametri.CampiRiferimento.C29_ChiamateRepDatoMod <> '' then
    DatoRecapito:=Format('T430%s',[Parametri.CampiRiferimento.C29_ChiamateRepDatoMod]);

  // Combo dipendenti
  cmbDipendente1.ItemsHaveValues:=True; // Già a design time
  cmbDipendente1.Items.NameValueSeparator:=NAME_VALUE_SEPARATOR;
  cmbDipendente2.ItemsHaveValues:=True; // Già a design time
  cmbDipendente2.Items.NameValueSeparator:=NAME_VALUE_SEPARATOR;

  // nasconde il groupbox del filtro dati se non sono presenti
  if not (lblFiltroDato1.Visible or lblFiltroDato2.Visible) then
    JavascriptBottom.Add('document.getElementById("filtroDati").className = "invisibile";');
end;

function TW043FModPersonaleReperibile.InizializzaAccesso:Boolean;
var
  MinDataJS,MaxDataJS:String;
  i: integer;
  Valore: string;
begin
  // controlli sui parametri
  Result:=False;
  if (Parametri.CampiRiferimento.C29_ChiamateRepFiltro1 = '') and
     (Parametri.CampiRiferimento.C29_ChiamateRepFiltro2 <> '') then
  begin
    GGetWebApplicationThreadVar.ShowMessage(Format(A000MSG_W043_ERR_FMT_FILTRO2_NOFILTRO1,[medpNomeFunzione]));
    Exit;
  end
  else if (Parametri.CampiRiferimento.C29_ChiamateRepFiltro1 <> '') and
          (Parametri.CampiRiferimento.C29_ChiamateRepFiltro1 = Parametri.CampiRiferimento.C29_ChiamateRepFiltro2) then
  begin
    GGetWebApplicationThreadVar.ShowMessage(Format(A000MSG_W043_ERR_FMT_FILTRI_UGUALI,[medpNomeFunzione]));
    Exit;
  end;

  NumGiorniModificabili:=-1;
  if Trim(Parametri.CampiRiferimento.C29_W043_ModReperNumGiorni) <> '' then
  begin
    try
      NumGiorniModificabili:=StrToInt(Parametri.CampiRiferimento.C29_W043_ModReperNumGiorni);
    except
      on Exc:EConvertError do
        NumGiorniModificabili:=-1;
    end;
  end;
  if NumGiorniModificabili < 0 then
  begin
    GGetWebApplicationThreadVar.ShowMessage(Format(A000MSG_W043_ERR_FTM_NUMGIORNI_NON_VALIDO,[medpNomeFunzione]));
    Exit;
  end;

  GetDipendentiDisponibili(Parametri.DataLavoro);

  // Intervallo di date selezionabili
  DataMinima:=Trunc(Now);
  DataMassima:=DataMinima + NumGiorniModificabili;
  lblInfoLimitiData.Text:=Format('E'' possibile impostare una data pianificazione compresa tra %s e %s',
                                 [DateToStr(DataMinima),DateToStr(DataMassima)]);
  edtDataPianificazione.Text:=DateToStr(DataMinima);
  MinDataJS:='new Date(' + IntToStr(DataMinima.Year) + ',' + IntToStr(DataMinima.Month - 1) + ',' + IntToStr(DataMinima.Day) + ')';
  MaxDataJS:='new Date(' + IntToStr(DataMassima.Year) + ',' + IntToStr(DataMassima.Month - 1) + ',' + IntToStr(DataMassima.Day) + ')';
  jqInterno.OnReady.Add(Format('$("#%s").datepicker("option",{minDate:%s, maxDate:%s});',[edtDataPianificazione.HTMLName,MinDataJS,MaxDataJS]));

  //imposto il dataset di recupero dei dati anagrafici del dipendente che ha effettuato l'accesso
  if W043DM.AccessoDaDipendente then
    begin
    if FDatoFiltro1.NomeDato <> '' then
      W043DM.QSDatiDip.GetDatiStorici(FDatoFiltro1.NomeCampo + IfThen(FDatoFiltro2.NomeCampo <> '',',' + FDatoFiltro2.NomeCampo),GetProgressivo,DataMinima,DataMassima);
      for i := FDatoFiltro1.ListaValoriAnag.Count - 1 downto 0 do
      begin
        Valore:=Copy(FDatoFiltro1.ListaValoriAnag[i],0, Pos(NAME_VALUE_SEPARATOR,FDatoFiltro1.ListaValoriAnag[i])-1);
        if (not A000FiltroDizionario('CAMBIO TURNI REPERIBILITA', Valore)) and
           (Valore <> W043DM.QSDatiDip.FieldByName(FDatoFiltro1.NomeCampo).AsString) then
          FDatoFiltro1.ListaValoriAnag.Delete(i);
      end;
    end;
  // inzializzazione griglie
  // turni dipendente 1
  grdTurniDip1.medpDataSet:=W043DM.cdsTurniDip1;
  grdTurniDip1.medpCreaCDS;
  grdTurniDip1.medpEliminaColonne;
  grdTurniDip1.medpAggiungiColonna('DBG_COMANDI','','',nil);
  grdTurniDip1.medpColonna('DBG_COMANDI').Width:='5%';
  grdTurniDip1.medpAggiungiColonna('DATA','Data','',nil);
  grdTurniDip1.medpColonna('DATA').Width:='8%';
  grdTurniDip1.medpAggiungiColonna('PROGRESSIVO','Progressivo','',nil);
  grdTurniDip1.medpColonna('PROGRESSIVO').Visible:=False;
  grdTurniDip1.medpAggiungiColonna('D_TURNO','Turno','',nil);
  grdTurniDip1.medpColonna('D_TURNO').RawText:=True;
  grdTurniDip1.medpColonna('D_TURNO').Width:='32%';
  grdTurniDip1.medpAggiungiColonna('RECAPITO_EXTRA','Recapito alternativo','',nil);
  grdTurniDip1.medpColonna('RECAPITO_EXTRA').Width:='50%';
  grdTurniDip1.medpAggiungiColonna('D_MODIFICA_RECAPITO','','',nil);
  grdTurniDip1.medpColonna('D_MODIFICA_RECAPITO').Width:='5%';
  grdTurniDip1.medpAggiungiColonna('DATOAGG1',R180Capitalize(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1),'',nil);
  grdTurniDip1.medpColonna('DATOAGG1').Width:='8%';
  grdTurniDip1.medpAggiungiColonna('D_DATOAGG1','Descrizione','',nil);
  grdTurniDip1.medpColonna('D_DATOAGG1').Width:='20%';
  grdTurniDip1.medpAggiungiColonna('DATOAGG2',R180Capitalize(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2),'',nil);
  grdTurniDip1.medpColonna('DATOAGG2').Width:='8%';
  grdTurniDip1.medpAggiungiColonna('D_DATOAGG2','Descrizione','',nil);
  grdTurniDip1.medpColonna('D_DATOAGG2').Width:='20%';

  grdTurniDip1.medpColonna('RECAPITO_EXTRA').Visible:=not W043DM.AccessoDaDipendente;
  grdTurniDip1.medpColonna('D_MODIFICA_RECAPITO').Visible:=not W043DM.AccessoDaDipendente;
  grdTurniDip1.medpColonna('DATOAGG1').Visible:=W043DM.AccessoDaDipendente and (Trim(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1) <> '');
  grdTurniDip1.medpColonna('D_DATOAGG1').Visible:=grdTurniDip1.medpColonna('DATOAGG1').Visible;
  grdTurniDip1.medpColonna('DATOAGG2').Visible:=W043DM.AccessoDaDipendente and (Trim(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2) <> '');
  grdTurniDip1.medpColonna('D_DATOAGG2').Visible:=grdTurniDip1.medpColonna('DATOAGG2').Visible;

  grdTurniDip1.medpInizializzaCompGriglia;

  if not SolaLettura then
  begin
    // Preparo i tasti per lo spostamento dei turni e la modifica dei recapiti alternativi
    grdTurniDip1.medpPreparaComponenteGenerico('R',grdTurniDip1.medpIndexColonna('DBG_COMANDI'),0,DBG_IMG,'','','Sposta turno','');
    grdTurniDip1.medpPreparaComponenteGenerico('R',grdTurniDip1.medpIndexColonna('D_MODIFICA_RECAPITO'),0,DBG_IMG,'','','Modifica recapito alternativo','');
  end;

  // turni dipendente 2
  grdTurniDip2.medpDataSet:=W043DM.cdsTurniDip2;
  grdTurniDip2.medpCreaCDS;
  grdTurniDip2.medpEliminaColonne;
  grdTurniDip2.medpAggiungiColonna('DBG_COMANDI','','',nil);
  grdTurniDip2.medpColonna('DBG_COMANDI').Width:='5%';
  grdTurniDip2.medpAggiungiColonna('DATA','Data','',nil);
  grdTurniDip2.medpColonna('DATA').Width:='8%';
  grdTurniDip2.medpAggiungiColonna('PROGRESSIVO','Progressivo','',nil);
  grdTurniDip2.medpColonna('PROGRESSIVO').Visible:=False;
  grdTurniDip2.medpAggiungiColonna('D_TURNO','Turno','',nil);
  grdTurniDip2.medpColonna('D_TURNO').RawText:=True;
  grdTurniDip2.medpColonna('D_TURNO').Width:='32%';
  grdTurniDip2.medpAggiungiColonna('RECAPITO_EXTRA','Recapito alternativo','',nil);
  grdTurniDip2.medpColonna('RECAPITO_EXTRA').Width:='50%';
  grdTurniDip2.medpAggiungiColonna('D_MODIFICA_RECAPITO','','',nil);
  grdTurniDip2.medpColonna('D_MODIFICA_RECAPITO').Width:='5%';
  grdTurniDip2.medpAggiungiColonna('DATOAGG1',R180Capitalize(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1),'',nil);
  grdTurniDip2.medpColonna('DATOAGG1').Width:='8%';
  grdTurniDip2.medpAggiungiColonna('D_DATOAGG1','Descrizione','',nil);
  grdTurniDip2.medpColonna('D_DATOAGG1').Width:='20%';
  grdTurniDip2.medpAggiungiColonna('DATOAGG2',R180Capitalize(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2),'',nil);
  grdTurniDip2.medpColonna('DATOAGG2').Width:='8%';
  grdTurniDip2.medpAggiungiColonna('D_DATOAGG2','Descrizione','',nil);
  grdTurniDip2.medpColonna('D_DATOAGG2').Width:='20%';

  grdTurniDip2.medpColonna('RECAPITO_EXTRA').Visible:=not W043DM.AccessoDaDipendente;
  grdTurniDip2.medpColonna('D_MODIFICA_RECAPITO').Visible:=not W043DM.AccessoDaDipendente;
  grdTurniDip2.medpColonna('DATOAGG1').Visible:=W043DM.AccessoDaDipendente and (Trim(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1) <> '');
  grdTurniDip2.medpColonna('D_DATOAGG1').Visible:=grdTurniDip2.medpColonna('DATOAGG1').Visible;
  grdTurniDip2.medpColonna('DATOAGG2').Visible:=W043DM.AccessoDaDipendente and (Trim(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2) <> '');
  grdTurniDip2.medpColonna('D_DATOAGG2').Visible:=grdTurniDip2.medpColonna('DATOAGG2').Visible;

  grdTurniDip2.medpInizializzaCompGriglia;

  if not SolaLettura then
  begin
    // Preparo i tasti per lo spostamento dei turni e la modifica dei recapiti alternativi
    grdTurniDip2.medpPreparaComponenteGenerico('R',grdTurniDip2.medpIndexColonna('DBG_COMANDI'),0,DBG_IMG,'','',IfThen(W043DM.AccessoDaDipendente,'Restituisci','Sposta') + ' turno','');
    grdTurniDip2.medpPreparaComponenteGenerico('R',grdTurniDip2.medpIndexColonna('D_MODIFICA_RECAPITO'),0,DBG_IMG,'','','Modifica recapito alternativo','');
  end;

  LeggiPianificazioneTurni;

  Result:=True;
end;

procedure TW043FModPersonaleReperibile.OttieniControllaData(const DataInStr:String;
                                                            var DataOut:TDateTime);
var
  LDataOut:TDateTime;
begin
  DataOut:=DATE_NULL;
  try
    LDataOut:=StrToDate(DataInStr);
  except
    on E:EConvertError do
      raise Exception.Create('Data non valida'); //TODO
  end;

  // Verifico che le date siano nel range consentito
  if LDataOut < DataMinima then                                                // TODO
    raise Exception.Create(Format('Data pianificazione inferiore al limite consentito (%s)',
                                  [FormatDateTime('dd/mm/yyyy',DataMinima)]));
  if LDataOut > DataMassima then
    raise Exception.Create(Format('Data pianificazione superiore al limite consentito (%s)',
                                  [FormatDateTime('dd/mm/yyyy',DataMassima)]));

  DataOut:=LDataOut;
end;

procedure TW043FModPersonaleReperibile.cmbDipendente2Change(Sender: TObject);
var
  ValoreCombo:String;
  ProgDip:Integer;
  DataPianif:TDateTime;
begin
  W043DM.cdsTurniDip2.EmptyDataSet;
  grdTurniDip2.medpCaricaCDS;
  if (cmbDipendente2.Text <> '') and (cmbDipendente2.ItemIndex > -1) then
  begin
    ValoreCombo:=cmbDipendente2.Items.ValueFromIndex[cmbDipendente2.ItemIndex];
    if ValoreCombo <> '' then
    begin
       // Se non riesco a parsificare il progressivo c'è qualcosa di grosso che non va
      ProgDip:=StrToInt(ValoreCombo);
      OttieniControllaData(edtDataPianificazione.Text,DataPianif);
      W043DM.LeggiPianificazioneDip2(ProgDip,DataPianif);
      grdTurniDip2.medpCaricaCDS;
    end;
  end;
end;

procedure TW043FModPersonaleReperibile.cmbFiltroAreaSquadraChange(Sender: TObject; Index: Integer);
begin
  // aggiorna descrizione
  if Index < 0 then
    lblFiltroAreaSquadraDesc.Caption:=''
  else
    lblFiltroAreaSquadraDesc.Caption:=cmbFiltroAreaSquadra.Items[Index].RowData[1];

  LeggiPianificazioneTurni;
end;

procedure TW043FModPersonaleReperibile.cmbFiltroDato1Change(Sender: TObject; Index: Integer);
begin
  // aggiorna descrizione
  if Index < 0 then
    lblFiltroDato1Desc.Caption:=''
  else
    lblFiltroDato1Desc.Caption:=cmbFiltroDato1.Items[Index].RowData[1];

  LeggiPianificazioneTurni;
end;

procedure TW043FModPersonaleReperibile.cmbFiltroDato2Change(Sender: TObject; Index: Integer);
begin
  // aggiorna descrizione
  if Index < 0 then
    lblFiltroDato2Desc.Caption:=''
  else
    lblFiltroDato2Desc.Caption:=cmbFiltroDato2.Items[Index].RowData[1];

  LeggiPianificazioneTurni;
end;

procedure TW043FModPersonaleReperibile.btnHdnLeggiPianifClick(Sender: TObject);
begin
  LeggiPianificazioneTurni;
end;

procedure TW043FModPersonaleReperibile.cmbDipendente1Change(Sender: TObject);
var
  ValoreCombo:String;
  ProgDip:Integer;
  DataPianif:TDateTime;
begin
  W043DM.cdsTurniDip1.EmptyDataSet;
  grdTurniDip1.medpCaricaCDS;
  if (cmbDipendente1.Text <> '') and (cmbDipendente1.ItemIndex > -1) then
  begin
    ValoreCombo:=cmbDipendente1.Items.ValueFromIndex[cmbDipendente1.ItemIndex];
    if ValoreCombo <> '' then
    begin
       // Se non riesco a parsificare il progressivo c'è qualcosa di grosso che non va
      ProgDip:=StrToInt(ValoreCombo);
      OttieniControllaData(edtDataPianificazione.Text,DataPianif);
      W043DM.LeggiPianificazioneDip1(ProgDip,DataPianif);
      grdTurniDip1.medpCaricaCDS;
    end;
  end;
end;

procedure TW043FModPersonaleReperibile.grdTurniDip1AfterCaricaCDS(
  Sender: TObject; DBG_ROWID: string);
var
  i:Integer;
  LImageFile:TmeIWImageFile;
begin
  if not SolaLettura then
  begin
    for i:=0 to High(grdTurniDip1.medpCompGriglia) do
    begin
      // Pulsante "Sposta turno giù"
      LImageFile:=((grdTurniDip1.medpCompCella(i,grdTurniDip1.medpIndexColonna('DBG_COMANDI'),0)) as TmeIWImageFile);
      LImageFile.ImageFile.URL:='img/btnFrecciaRossaGiu2.png';
      LImageFile.OnClick:=imgSpostaTurnoDip1Dip2Click;
      LImageFile.FriendlyName:=grdTurniDip1.medpValoreColonna(i,'ID');

      // Pulsante "Modifica recapito alternativo"
      LImageFile:=((grdTurniDip1.medpCompCella(i,grdTurniDip1.medpIndexColonna('D_MODIFICA_RECAPITO'),0)) as TmeIWImageFile);
      LImageFile.ImageFile.URL:='img/btnInfo.png';
      LImageFile.OnClick:=imgModificaRecapitiDip1Click;
      LImageFile.FriendlyName:=grdTurniDip1.medpValoreColonna(i,'ID');
    end;
  end;
end;

procedure TW043FModPersonaleReperibile.grdTurniDip2AfterCaricaCDS(
  Sender: TObject; DBG_ROWID: string);
var
  i:Integer;
  LImageFile:TmeIWImageFile;
begin
  if not SolaLettura then
  begin
   for i:=0 to High(grdTurniDip2.medpCompGriglia) do
    begin
      // Pulsante "Sposta turno su"
      LImageFile:=((grdTurniDip2.medpCompCella(i,grdTurniDip2.medpIndexColonna('DBG_COMANDI'),0)) as TmeIWImageFile);
      if W043DM.AccessoDaDipendente then
        LImageFile.ImageFile.URL:=fileImgCancella
      else
        LImageFile.ImageFile.URL:='img/btnFrecciaRossaSu2.png';
      LImageFile.OnClick:=imgSpostaTurnoDip2Dip1Click;
      LImageFile.FriendlyName:=grdTurniDip2.medpValoreColonna(i,'ID');
      if W043DM.GetProgDipSpostamento(grdTurniDip2.medpValoreColonna(i,'TURNO'),StrToDate(grdTurniDip2.medpValoreColonna(i,'DATA'))) = -1 then
        FreeAndNil(grdTurniDip2.medpCompGriglia[i].CompColonne[grdTurniDip2.medpIndexColonna('DBG_COMANDI')]);

      // Pulsante "Modifica recapito alternativo"
      LImageFile:=((grdTurniDip2.medpCompCella(i,grdTurniDip2.medpIndexColonna('D_MODIFICA_RECAPITO'),0)) as TmeIWImageFile);
      LImageFile.ImageFile.URL:='img/btnInfo.png';
      LImageFile.OnClick:=imgModificaRecapitiDip2Click;
      LImageFile.FriendlyName:=grdTurniDip2.medpValoreColonna(i,'ID');
    end;
  end;
end;

procedure TW043FModPersonaleReperibile.LeggiPianificazioneTurni;
var
  LListaDipendenti:TStringList;
  LParametriFiltro:TW043ParametriFiltro;
  LDataPianif,LDataMax:TDateTime;
  LOldDip1,LOldDip2:String;
  LValFiltro1,LValFiltro2:String;
  LValoreFiltro1: String;
  LValoreFiltro2: String;
  LValoreFiltroArea: String;
  LElemento: String;
  i,j: integer;
  blnAggiorna: Boolean;
begin
  // inizializza liste dati aggiuntivi
  FDatoFiltro1.ListaValoriAgg.Clear;
  FDatoFiltro2.ListaValoriAgg.Clear;

  // filtro libero 1
  LValoreFiltro1:=cmbFiltroDato1.Text;

  // filtro libero 2
  LValoreFiltro2:=cmbFiltroDato2.Text;

  // filtro area squadra
  LValoreFiltroArea:=cmbFiltroAreaSquadra.Text;

  // Prelevo e verifico che la data di pianificazione sia valida
  OttieniControllaData(edtDataPianificazione.Text,LDataPianif);

  //Imposto il periodo in cui cercare dipendenti con pianificazioni
  if W043DM.AccessoDaDipendente and bPrimaLetturaTurni then
    LDataMax:=DataMassima
  else
    LDataMax:=LDataPianif;

  //cerco i dipendenti reperibili nel periodo
  while LDataPianif <= LDataMax do
  begin
    //blocco i filtri sui valori del dipendente
    if W043DM.AccessoDaDipendente then
    begin
      // TODO: se il dato è pianificato occorre estrarre questo e non quello in anagrafica
      if FDatoFiltro1.NomeDato <> '' then
      begin
        LValFiltro1:='';
        if W043DM.QSDatiDip.LocDatoStorico(LDataPianif) then
          LValFiltro1:=W043DM.QSDatiDip.FieldByName(FDatoFiltro1.NomeCampo).AsString;
      end;
      if FDatoFiltro2.NomeDato <> '' then
      begin
        LValFiltro2:='';
        if W043DM.QSDatiDip.LocDatoStorico(LDataPianif) then
          LValFiltro2:=W043DM.QSDatiDip.FieldByName(FDatoFiltro2.NomeCampo).AsString;
        cmbFiltroDato2.Text:=LValFiltro2;
        cmbFiltroDato2.Enabled:=LValFiltro2 = '';
      end;
    end;

    // Imposto i dati per il filtro dipendente. Il filtro è usato solo per ricavare le anagrafiche
    // disponibili
    LParametriFiltro.DataPianificazione:=LDataPianif;
    LParametriFiltro.DatoLibero1:=FDatoFiltro1.NomeCampo;
    LParametriFiltro.DatoLibero2:=FDatoFiltro2.NomeCampo;
    LParametriFiltro.ValoreDatoLibero1:=IfThen(cmbFiltroDato1.Text<>'',cmbFiltroDato1.Text,LValFiltro1); //LValFiltro1; //cmbFiltroDato1.Text; //cmbFiltroDato1.Items.ValueFromIndex[cmbFiltroDato1.ItemIndex];
    LParametriFiltro.ValoreDatoLibero2:=cmbFiltroDato2.Text; //cmbFiltroDato2.Items.ValueFromIndex[cmbFiltroDato2.ItemIndex];
    LParametriFiltro.ValoreDatoAreaSquadra:=cmbFiltroAreaSquadra.Text;

    if W043DM.AccessoDaDipendente then
      LParametriFiltro.FiltroDip:='and (T030.progressivo = ' + IntToStr(Parametri.ProgressivoOper) + W043DM.GetListaProgDipSpostamento(LDataPianif) + ' or exists (select 1 from T380_PIANIFREPERIB T380 where T380.progressivo = T030.progressivo and T380.data = to_date(''' + DateToStr(LDataPianif) + ''',''DD/MM/YYYY'') and T380.tipologia = ''R''))'
    else
      LParametriFiltro.FiltroDip:=WR000DM.FiltroRicerca;

    // Prima di proseguire mi salvo i dipendenti attualmente selezionati (testo completo)
    LOldDip1:='';
    if (cmbDipendente1.Items.Count > 0) and (cmbDipendente1.ItemIndex > -1) then
      LOldDip1:=cmbDipendente1.Items.Names[cmbDipendente1.ItemIndex];
    LOldDip2:='';
    if (cmbDipendente2.Items.Count > 0) and (cmbDipendente2.ItemIndex > -1) then
      LOldDip2:=cmbDipendente2.Items.Names[cmbDipendente2.ItemIndex];
    try
      // Leggo le anagrafiche disponibili e imposto le combo
      LListaDipendenti:=W043DM.GetDipendentiReperibili(LParametriFiltro);
      cmbDipendente1.Items.Assign(LListaDipendenti);
      if (not W043DM.AccessoDaDipendente) or (cmbDipendente2.Items.Count = 0) then
        cmbDipendente2.Items.Assign(LListaDipendenti);
      //tolgo la riga del dipendente che ha effettuato l'accesso
      if (W043DM.AccessoDaDipendente) and(R180IndexFromValue(cmbDipendente1.Items,IntToStr(Parametri.ProgressivoOper)) >= 0) then
        cmbDipendente1.Items.Delete(R180IndexFromValue(cmbDipendente1.Items,IntToStr(Parametri.ProgressivoOper)));

      if LDataPianif < LDataMax then //prima lettura con accesso da dipendente
      begin
        if cmbDipendente1.Items.Count = 0 then //nessun altro dipendente con turni pianificati
          Continue  //Passo al giorno successivo
        else
          LDataMax:=LDataPianif; //Rimango sul giorno corrente perché ha dipendenti con turni pianificati
      end;

      // Se avevo selezionato dei dipendenti e la nuova selezione li include, li preseleziono.
      // Altrimenti scelgo sempre il primo dipendente per la combo 1
      if (LOldDip1 <> '') and (cmbDipendente1.Items.IndexOfName(LOldDip1) > 0) then
        cmbDipendente1.ItemIndex:=cmbDipendente1.Items.IndexOfName(LOldDip1)
      else
        cmbDipendente1.ItemIndex:=0;
      if (LOldDip2 <> '') and (cmbDipendente2.Items.IndexOfName(LOldDip2) > 0) then
        cmbDipendente2.ItemIndex:=cmbDipendente2.Items.IndexOfName(LOldDip2)
      else
      begin
        // Per il secondo dipendente invece se non ho preselezioni, i casi sono che: o ho 0 o 1 dipendente,
        // allora, seleziono il primo elemento (vuoto oppure primo dipendente). Se invece ne ho di più, scelgo
        // il secondo dipendente.
        if LListaDipendenti.Count >= 2 then
          cmbDipendente2.ItemIndex:=1
        else
          cmbDipendente2.ItemIndex:=0;
      end;
      //blocco sulla riga del dipendente che ha effettuato l'accesso
      if W043DM.AccessoDaDipendente then
      begin
        cmbDipendente2.ItemIndex:=R180IndexFromValue(cmbDipendente2.Items,IntToStr(Parametri.ProgressivoOper));
        cmbDipendente2.Enabled:=False;
      end;

      // Questi eventi caricano la pianificazione per il giorno indicato, se le combo hanno un valore
      // selezionato valido.
      edtDataPianificazione.Text:=DateToStr(LDataPianif); //assegno testo al componente nel caso in cui avessi ciclato sul periodo
      cmbDipendente1.OnChange(nil);
      cmbDipendente2.OnChange(nil);

    finally
      LDataPianif:=LDataPianif + 1;
      LListaDipendenti.Free;
    end;
  end;

  // popola la combobox per il filtro 1
  blnAggiorna:=True;
  for i:=0 to FDatoFiltro1.GetListaValoriCompleta.Count-1 do
  begin
    if W043DM.AccessoDaDipendente then
      j:=i
    else
      j:=i+1;

    blnAggiorna:=True;
    if j > cmbFiltroDato1.Items.Count-1 then
      break;

    if cmbFiltroDato1.Items[j].RowData[0] <> Copy(FDatoFiltro1.GetListaValoriCompleta[i],0, Pos(NAME_VALUE_SEPARATOR,FDatoFiltro1.GetListaValoriCompleta[i])-1) then
      break;
    blnAggiorna:=False;
  end;

  if blnAggiorna then
  begin
    cmbFiltroDato1.Items.Clear;
    if not W043DM.AccessoDaDipendente then
      cmbFiltroDato1.AddRow(NAME_VALUE_SEPARATOR + ' ');
    for LElemento in FDatoFiltro1.GetListaValoriCompleta do
      cmbFiltroDato1.AddRow(LElemento);
    cmbFiltroDato1.Text:=LValFiltro1;
  end;

  // popola la combobox per il filtro 2
  cmbFiltroDato2.Items.Clear;
  cmbFiltroDato2.AddRow(NAME_VALUE_SEPARATOR + ' ');
  for LElemento in FDatoFiltro2.GetListaValoriCompleta do
    cmbFiltroDato2.AddRow(LElemento);
  cmbFiltroDato2.Text:=LValoreFiltro2;

  // popola la combobox per filtro area afferenza
  cmbFiltroAreaSquadra.Items.Clear;
  cmbFiltroAreaSquadra.AddRow(NAME_VALUE_SEPARATOR + ' ');
  W043DM.selT650Lookup.First;
  while not W043DM.selT650Lookup.Eof do
  begin
    cmbFiltroAreaSquadra.AddRow(W043DM.selT650Lookup.FieldByName('CODICE').AsString + NAME_VALUE_SEPARATOR + W043DM.selT650Lookup.FieldByName('DESCRIZIONE').AsString );
    W043DM.selT650Lookup.Next;
  end;
  cmbFiltroAreaSquadra.Text:=LValoreFiltroArea;

  bPrimaLetturaTurni:=False;
end;

procedure TW043FModPersonaleReperibile.imgSpostaTurnoDip1Dip2Click(Sender: TObject);
var
  FN:String;
begin
  if not SolaLettura then // Sicurezza
  begin
    FN:=(Sender as TmeIWImageFile).FriendlyName; // E' l'ID della riga del client data set
    PreparaSpostamento(StrToInt(FN),toSpostaDaDip1ADip2);
  end;
end;

procedure TW043FModPersonaleReperibile.imgSpostaTurnoDip2Dip1Click(Sender: TObject);
var
  FN:String;
begin
  if not SolaLettura then // Sicurezza
  begin
    FN:=(Sender as TmeIWImageFile).FriendlyName; // E' l'ID della riga del client data set
    PreparaSpostamento(StrToInt(FN),toSpostaDaDip2ADip1);
  end;
end;

procedure TW043FModPersonaleReperibile.imgModificaRecapitiDip1Click(Sender: TObject);
var
  FN:String;
  Progressivo,NumeroTurno:Integer;
  DataPianif:TDateTime;
  Recapito:String;
begin
  if not SolaLettura then // Sicurezza
  begin
    FN:=(Sender as TmeIWImageFile).FriendlyName; // E' l'ID della riga del client data set
    if not grdTurniDip1.DataSource.DataSet.Locate('ID',StrToInt(FN),[]) then
      raise Exception.Create('Errore interno: il client dataset della griglia delle pianificazione non contiene il record indicato.'); // TODO
    Progressivo:=grdTurniDip1.DataSource.DataSet.FieldByName('PROGRESSIVO').AsInteger;
    DataPianif:=grdTurniDip1.DataSource.DataSet.FieldByName('DATA').AsDateTime;
    NumeroTurno:=grdTurniDip1.DataSource.DataSet.FieldByName('NUMERO_TURNO').AsInteger;
    Recapito:=grdTurniDip1.DataSource.DataSet.FieldByName('RECAPITO_EXTRA').AsString;
    ApriModificaRecapito(Progressivo,DataPianif,NumeroTurno,Recapito);
  end;
end;

procedure TW043FModPersonaleReperibile.imgModificaRecapitiDip2Click(Sender: TObject);
var
  FN:String;
  Progressivo,NumeroTurno:Integer;
  DataPianif:TDateTime;
  Recapito:String;
begin
  if not SolaLettura then // Sicurezza
  begin
    FN:=(Sender as TmeIWImageFile).FriendlyName; // E' l'ID della riga del client data set
    if not grdTurniDip2.DataSource.DataSet.Locate('ID',StrToInt(FN),[]) then
      raise Exception.Create('Errore interno: il client dataset della griglia delle pianificazione non contiene il record indicato.'); // TODO
    Progressivo:=grdTurniDip2.DataSource.DataSet.FieldByName('PROGRESSIVO').AsInteger;
    DataPianif:=grdTurniDip2.DataSource.DataSet.FieldByName('DATA').AsDateTime;
    NumeroTurno:=grdTurniDip2.DataSource.DataSet.FieldByName('NUMERO_TURNO').AsInteger;
    Recapito:=grdTurniDip2.DataSource.DataSet.FieldByName('RECAPITO_EXTRA').AsString;
    ApriModificaRecapito(Progressivo,DataPianif,NumeroTurno,Recapito);
  end;
end;

procedure TW043FModPersonaleReperibile.ApriModificaRecapito(Progressivo:Integer;
                                                            DataPianif:TDateTime;
                                                            NumeroTurno:Integer;
                                                            Recapito:String);
begin
  if W004FModificaRecapitiFM <> nil then
    FreeAndNil(W004FModificaRecapitiFM);
  W004FModificaRecapitiFM:=TW004FModificaRecapitiFM.Create(Self);
  // NumeroTurno è creato da un for da 1 a 3, non può avere altri valori
  W004FModificaRecapitiFM.RecapitoT1:=IfThen(NumeroTurno = 1,Recapito,'');
  W004FModificaRecapitiFM.RecT1Attivo:=(NumeroTurno = 1);
  W004FModificaRecapitiFM.RecapitoT2:=IfThen(NumeroTurno = 2,Recapito,'');
  W004FModificaRecapitiFM.RecT2Attivo:=(NumeroTurno = 2);
  W004FModificaRecapitiFM.RecapitoT3:=IfThen(NumeroTurno = 3,Recapito,'');
  W004FModificaRecapitiFM.RecT3Attivo:=(NumeroTurno = 3);
  W004FModificaRecapitiFM.FreeNotification(Self);

  FProgDipModRecapito:=Progressivo;
  FDataTurnoModRecapito:=DataPianif;
  FNumTurnoModRecapito:=NumeroTurno;

  W004FModificaRecapitiFM.Visualizza;
end;

procedure TW043FModPersonaleReperibile.Notification(AComponent: TComponent; Operation: TOperation);
var
  NuovoRecapito:String;
begin
  inherited Notification(AComponent,Operation);
  if (AComponent = W004FModificaRecapitiFM) and (Operation = opRemove) and (not SolaLettura) then
  begin
    try
      if W004FModificaRecapitiFM.Modificato then
      begin
        if FNumTurnoModRecapito = 1 then
          NuovoRecapito:=W004FModificaRecapitiFM.RecapitoT1
        else if FNumTurnoModRecapito = 2 then
          NuovoRecapito:=W004FModificaRecapitiFM.RecapitoT2
        else
          NuovoRecapito:=W004FModificaRecapitiFM.RecapitoT3;

        // Aggiorno il recapito esistente
        W043DM.ModificaRecapitoExtra(FProgDipModRecapito,FDataTurnoModRecapito,FNumTurnoModRecapito,NuovoRecapito);
        LeggiPianificazioneTurni;
        MsgBox.MessageBox('Recapito alternativo aggiornato.',INFORMA) // TODO;
      end;
    finally
      W004FModificaRecapitiFM:=nil;
    end;
  end;
end;

procedure TW043FModPersonaleReperibile.PreparaSpostamento(IDRiga:Integer;
                                                          TipoOperazione:TW043TipoOperazione);
var
  Messaggio:String;
begin
  if SolaLettura then // Non si sa mai
    Exit;

  FCodiceTurno:='';
  FDataTurno:=DATE_NULL;
  FProgDipDa:=-1;
  FProgDipA:=-1;
  FDatoAgg1:='';
  FDatoAgg2:='';

  if (cmbDipendente1.ItemIndex = -1) or (cmbDipendente2.ItemIndex = -1) then
    raise Exception.Create('Selezionare i due dipendenti');//TODO

  // Mi posiziono sul record corretto del dataset per ottenere data e turno
  if TipoOperazione = toSpostaDaDip1ADip2 then
  begin
    if not grdTurniDip1.DataSource.DataSet.Locate('ID',IDRiga,[]) then
      raise Exception.Create('Errore interno: il client dataset della griglia delle pianificazioni non contiene il record indicato.'); // TODO

    FCodiceTurno:=grdTurniDip1.DataSource.DataSet.FieldByName('TURNO').AsString;
    FDataTurno:=grdTurniDip1.DataSource.DataSet.FieldByName('DATA').AsDateTime;
    FProgDipDa:=StrToInt(cmbDipendente1.Items.ValueFromIndex[cmbDipendente1.ItemIndex]);
    FProgDipA:=StrToInt(cmbDipendente2.Items.ValueFromIndex[cmbDipendente2.ItemIndex]);
    FNomeDipDa:=cmbDipendente1.Text;
    FNomeDipA:=cmbDipendente2.Text;
    FCodiceSiglaTurno:=IfThen(grdTurniDip1.DataSource.DataSet.FieldByName('SIGLA').AsString <> '',
                             grdTurniDip1.DataSource.DataSet.FieldByName('SIGLA').AsString,
                             FCodiceTurno);
    FDescrizioneTurno:=grdTurniDip1.DataSource.DataSet.FieldByName('D_TURNO').AsString;
    FPriorita:=grdTurniDip1.DataSource.DataSet.FieldByName('PRIORITA').AsString;

    FRecapito:='';//sempre vuoto per spostamento da Dip1 a Dip2
    FRecapitoAdd:=grdTurniDip1.DataSource.DataSet.FieldByName('RECAPITO_EXTRA').AsString; //salvo per eventuale ripristino
    if not W043DM.AccessoDaDipendente then
      FRecapito:=W043DM.GetRecapitoDipSpostamento(FProgDipA,FCodiceTurno,FDataTurno);

    //Se il recapito è nullo recupera quello di default
    if (FRecapito = '') and (DatoRecapito <> '') then
      FRecapito:=W043DM.GetRecapitoProposto(FProgDipA,DatoRecapito,FDataTurno);

    FDatoAgg1:=grdTurniDip1.DataSource.DataSet.FieldByName('DATOAGG1').AsString;
    FDatoAgg2:=grdTurniDip1.DataSource.DataSet.FieldByName('DATOAGG2').AsString;
  end
  else
  begin
    if not grdTurniDip2.DataSource.DataSet.Locate('ID',IDRiga,[]) then
      raise Exception.Create('Errore interno: il client dataset della griglia delle pianificazioni non contiene il record indicato.'); // TODO
    FCodiceTurno:=grdTurniDip2.DataSource.DataSet.FieldByName('TURNO').AsString;
    FDataTurno:=grdTurniDip2.DataSource.DataSet.FieldByName('DATA').AsDateTime;
    FProgDipDa:=StrToInt(cmbDipendente2.Items.ValueFromIndex[cmbDipendente2.ItemIndex]);
    FProgDipA:=StrToInt(cmbDipendente1.Items.ValueFromIndex[cmbDipendente1.ItemIndex]);
    FNomeDipDa:=cmbDipendente2.Text;
    FNomeDipA:=cmbDipendente1.Text;
    if W043DM.AccessoDaDipendente then
    begin
      FProgDipA:=W043DM.GetProgDipSpostamento(FCodiceTurno,FDataTurno);
      FNomeDipA:=W043DM.GetNomeDipSpostamento(FProgDipA);
    end;
    FCodiceSiglaTurno:=IfThen(grdTurniDip2.DataSource.DataSet.FieldByName('SIGLA').AsString <> '',
                             grdTurniDip2.DataSource.DataSet.FieldByName('SIGLA').AsString,
                             FCodiceTurno);
    FDescrizioneTurno:=grdTurniDip2.DataSource.DataSet.FieldByName('D_TURNO').AsString;
    FPriorita:=grdTurniDip2.DataSource.DataSet.FieldByName('PRIORITA').AsString;

    FRecapito:=W043DM.GetRecapitoDipSpostamento(FProgDipA,FCodiceTurno,FDataTurno);
    if not W043DM.AccessoDaDipendente then
      FRecapitoAdd:=grdTurniDip2.DataSource.DataSet.FieldByName('RECAPITO_EXTRA').AsString;//salvo per eventuale ripristino

    //Se il recapito è nullo recupera quello di default
    if (FRecapito = '') and (DatoRecapito <> '') then
      FRecapito:=W043DM.GetRecapitoProposto(FProgDipA,DatoRecapito,FDataTurno);


    FDatoAgg1:=grdTurniDip2.DataSource.DataSet.FieldByName('DATOAGG1').AsString;
    FDatoAgg2:=grdTurniDip2.DataSource.DataSet.FieldByName('DATOAGG2').AsString;
  end;

  if FProgDipDa = FProgDipA then
    raise Exception.Create('E'' stato indicato un solo dipendente!'); // TODO
  // TODO
  Messaggio:=Format(IfThen((TipoOperazione = toSpostaDaDip2ADip1) and W043DM.AccessoDaDipendente,'Restituire','Spostare') + ' il turno %s in data %s dal dipendente %s al dipendente %s?',
                    [FCodiceSiglaTurno,
                     FormatDateTime('dd/mm/yyyy',FDataTurno),
                     FNomeDipDa, //+ '(->' + IntToStr(FProgDipDa) + '<-)', // TODO
                     FNomeDipA //+ '(->' + IntToStr(FProgDipA) + '<-)'
                    ]);
  MsgBox.WebMessageDlg(Messaggio,mtConfirmation,[mbYes,mbNo],OnConfermaSpostamento,'','Sposta turno',mbNo);   // TODO
end;

procedure TW043FModPersonaleReperibile.OnConfermaSpostamento(Sender: TObject; ModalResult: TmeIWModalResult; KeyID: String);
begin
  if ModalResult = mrYes then
  begin
    SpostaTurno;
  end;
end;

{Non posso avere più di un record per via della PK (progressivo + data + tipo reperibilità)
    // Il nuovo turno esiste ancora su T350?              ok
      // Dato bloccato, Vedi W004UReperibilita.pas:3118   O
      // Turno ripetuto                                     O
      // actInsVar0 controllo vincoli individuali           O
      // actInsVar1 ~ actInsVar3 ,  turni intersecati  (R/G)     O
      // actInsVar4 ~ actInsVar13 (!) TurniIntersecatiTipologieDiverse      X }

procedure TW043FModPersonaleReperibile.SpostaTurno;
var CheckResString:String;
begin
  if SolaLettura then
    Exit;

  { I dati per lo spostamento sono campi di questa classe:
    FProgDipDa: progressivo dipendente sorgente
    FNomeDipDa: matricola + cognome + nome dipendente sorgente (solo per visualizzazione)
    FProgDipA: progressivo dipendente destinazione
    FNomeDipA: matricola + cognome + nome dipendente sorgente  (solo per visualizzazione)
    FDataTurno: data della pianificazione
    FCodiceTurno: codice turno da spostare da DA a A
    FCodiceSiglaTurno: sigla o codice turno da spostare (solo per visualizzazione)
    FDescrizioneTurno: descrizione del turno da spostare (solo per visualizzazione/email)
    FPriorita: priorità del turno da spostare
    FRecapito: recapito del turno da spostare (valorizzato solo quando il dipendente (non il responsabile) restituisce il turno a chi l'ha preso)
    FRecapitoAdd: recapito del turno da spostare (valorizzato solo quando il dipendente (non il responsabile) sta prendendo un turno ad un collega)
    FDatoAgg1: dato aggiuntivo 1 del turno da spostare
    FDatoAgg2: dato aggiuntivo 2 del turno da spostare
  }

  // Controllo che esista il turno in T350
  if not W043DM.CheckEsisteCodiceTurno(FCodiceTurno) then
  begin
    MsgBox.MessageBox(Format('Il turno %s non esiste più nelle regole di reperibilità.',[FCodiceSiglaTurno]),INFORMA); // TODO
    Exit;
  end;

  // Controllo dati bloccati, dipendente sorgente
  CheckResString:=W043DM.CheckDatoBloccato(FProgDipDa,FDataTurno);
  if CheckResString <> '' then
  begin
    MsgBox.MessageBox(Format('Modifica non consentita per il dipendente %s: %s',[FNomeDipDa,CheckResString]),INFORMA); // TODO
    Exit;
  end;

  // Controllo dati bloccati, dipendente destinazione
  CheckResString:=W043DM.CheckDatoBloccato(FProgDipA,FDataTurno);
  if CheckResString <> '' then
  begin
    MsgBox.MessageBox(Format('Modifica non consentita per il dipendente %s: %s',[FNomeDipA,CheckResString]),INFORMA); // TODO
    Exit;
  end;

  // Controllo vincoli individuali
  CheckResString:=W043DM.CheckVincoliIndividuali(FProgDipA,FDataTurno,FCodiceTurno);
  if CheckResString <> '' then
  begin
    MsgBox.MessageBox(CheckResString,INFORMA);
    Exit;
  end;

  // Controllo orario cut-off
  CheckResString:=W043DM.CheckOrarioCutOff(FDataTurno,FCodiceTurno);
  if CheckResString <> '' then
  begin
    MsgBox.MessageBox(CheckResString,INFORMA);
    Exit;
  end;

  // Controllo turno finito
  CheckResString:=W043DM.CheckTurnoFinito(FDataTurno,FCodiceTurno);
  if CheckResString <> '' then
  begin
    MsgBox.MessageBox(CheckResString,INFORMA);
    Exit;
  end;

  try
    // Verifichiamo se il dipendente destinatario ha già una pianificazione per quel giorno
    W043DM.ApriSelT380(FProgDipA,FDataTurno);

    if W043DM.selT380.RecordCount = 1 then
    begin
      // Controllo slot liberi (TURNO1,TURNO2,TURNO3) dipendente destinatario
      if not W043DM.CheckSlotTurniLiberi then
      begin
        MsgBox.MessageBox('Il dipendente su cui si sta cercando di spostare il turno ha già raggiunto il numero massimo di turni pianificabili',INFORMA); // TODO
        Exit;
      end;

      // Il nuovo turno si interseca con turni già esistenti?
      CheckResString:=W043DM.CheckIntersezioneTurni(FProgDipA,FDataTurno,FCodiceTurno);
      if CheckResString <> '' then
      begin
        MsgBox.MessageBox(CheckResString,INFORMA);
        Exit;
      end;
    end
    else if W043DM.selT380.RecordCount > 1 then
    begin
      // TODO
      MsgBox.MessageBox('Errore grave, base dati inconsistente!',ERRORE); // TODO
      Exit;
    end;
  finally
    W043DM.selT380.Close;
  end;

  // Tutti i controlli superati. Possiamo apportare le modifiche.
  SessioneOracle.Commit;
  try
    W043DM.AggiungiPianificazioneTurno(FProgDipA,FDataTurno,FCodiceTurno,FPriorita,FRecapito,FDatoAgg1,FDatoAgg2);
    W043DM.RimuoviPianificazioneTurno(FProgDipDa,FDataTurno,FCodiceTurno);
    if W043DM.AccessoDaDipendente then
    begin
      if FProgDipDa <> Parametri.ProgressivoOper then
        W043DM.AddSpostamento(FProgDipDa,FDataTurno,FCodiceTurno,FRecapitoAdd)
      else
        W043DM.RemSpostamento(FProgDipA,FDataTurno,FCodiceTurno);
    end
    else
    begin
      if FProgDipDa <> FProgDipA then
      begin
        W043DM.RemSpostamento(FProgDipA,FDataTurno,FCodiceTurno);
        W043DM.AddSpostamento(FProgDipDa,FDataTurno,FCodiceTurno,FRecapitoAdd);
      end;
    end;

    // Aggiungo alla T280 i record per le mail da inviare (per ora nessun invio)
    CheckResString:=W043DM.SalvaEMailsAvviso(FProgDipDa,FProgDipA,FDataTurno,FCodiceTurno);
    SessioneOracle.Commit;
  except
    on E:Exception do
    begin
      SessioneOracle.Rollback;
      MsgBox.MessageBox(Format('Errore durante la modifica delle pianificazioni: %s',[E.Message]),ERRORE);
      Exit;
    end;
  end;


  try
    WR000DM.InviaEmailT280;
  except
  on E:Exception do
    begin
     MsgBox.MessageBox('La pianificazione è stata modificata correttamente, ma si è verificato un errore durante l''invio delle email di notifica',ERRORE); // TODO
     LeggiPianificazioneTurni;
     Exit;
    end;
  end;

  // CheckResString contiene il risultato del tentativo di scrivere le mail in T280 (se siamo arrivati
  // qui non abbiamo alcun errore critico, ma le email dai dati liberi potrebbero non essere state impostate).
  MsgBox.MessageBox(Format('Pianificazioni modificate correttamente.' + CRLF + '%s',[CheckResString]),INFORMA);
  LeggiPianificazioneTurni;

  if not cmbDipendente2.Enabled
  and (FProgDipA <> StrToInt(cmbDipendente2.Items.ValueFromIndex[cmbDipendente2.ItemIndex]))
  and (FProgDipA <> StrToInt(cmbDipendente1.Items.ValueFromIndex[cmbDipendente1.ItemIndex]))
  then
  begin
    cmbDipendente1.ItemIndex:=R180IndexFromValue(cmbDipendente1.Items,IntToStr(FProgDipA));
    cmbDipendente1.OnChange(nil);
  end;
end;

procedure TW043FModPersonaleReperibile.edtDataPianificazioneAsyncChange(Sender: TObject; EventParams: TStringList);
var
  JS:String;
begin
  JS:=Format('SubmitClick("%s","",true); ',[btnhdnLeggiPianif.HTMLName]);
  gGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(JS);
end;

procedure TW043FModPersonaleReperibile.RefreshPage;
begin
  LeggiPianificazioneTurni;
end;

procedure TW043FModPersonaleReperibile.DistruggiOggetti;
begin
  if W004FModificaRecapitiFM <> nil then
    FreeAndNil(W004FModificaRecapitiFM);
end;



end.
