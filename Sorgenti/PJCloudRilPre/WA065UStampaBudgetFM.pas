unit WA065UStampaBudgetFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR200UBaseFM, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  meIWCheckBox, IWCompEdit, meIWEdit, IWCompLabel, meIWLabel, meTIWAdvCheckGroup, meIWRadioGroup,
  meIWButton, meIWComboBox, medpIWMultiColumnComboBox, medpIWImageButton, IWCompExtCtrls, meIWImageFile,
  IWCompListbox, IWCompButton, IWControl, IWAdvCheckGroup, IWCompCheckbox, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, A065UStampaBudgetMW, C004UParamForm, StrUtils, Vcl.Menus,
  Data.DB, Datasnap.DBClient, Datasnap.Win.MConnect, ActiveX,
  OracleData, IWApplication, System.JSON,
  A000UCostanti, A000UInterfaccia, A000UMessaggi, C180FunzioniGenerali, C190FunzioniGeneraliWeb,
  WR010UBase;

type
  T065StmGenProc = procedure of object;
  TFilterRecordProc = procedure (DataSet: TDataSet; var Accept: Boolean) of object;

  TWA065FStampaBudgetFM = class(TWR200FBaseFM)
    lblAnno: TmeIWLabel;
    sedtAnno: TmeIWEdit;
    lblDaMese: TmeIWLabel;
    lblAMese: TmeIWLabel;
    chkSaltoPagina: TmeIWCheckBox;
    lblGruppi: TmeIWLabel;
    clbGruppi: TmeTIWAdvCheckGroup;
    chkAggiornaFruito: TmeIWCheckBox;
    chkDettaglioDipendenti: TmeIWCheckBox;
    chkTotMese: TmeIWCheckBox;
    chkTotGruppo: TmeIWCheckBox;
    chkTotGenerale: TmeIWCheckBox;
    chkCostoInMoneta: TmeIWCheckBox;
    dcmbTipo: TMedpIWMultiColumnComboBox;
    lblTipo: TmeIWLabel;
    btnCambioData: TmeIWButton;
    cmbDaMese: TmeIWComboBox;
    cmbAMese: TmeIWComboBox;
    lblDescTipo: TmeIWLabel;
    rgpTipoBudget: TmeIWRadioGroup;
    btnGeneraPDF: TmedpIWImageButton;
    pmnAzioni: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    DCOMConnection: TDCOMConnection;
    procedure sedtAnnoAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure btnCambioDataClick(Sender: TObject);
    procedure chkDettaglioDipendentiClick(Sender: TObject);
    procedure dcmbTipoChange(Sender: TObject; Index: Integer);
    procedure btnGeneraPDFClick(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
  private
    { Private declarations }
    wCodGruppo,wTipo:String;
    wDecorrenza:TDateTime;
    procedure AbilitaComponenti;
    procedure ControlloPeriodo;
    procedure GetParametriFunzione;
    procedure GetParametriFunzione2;
    procedure PutParametriFunzione;
    procedure RicaricaClbGruppi;
    procedure RicaricaListaGruppiSel;
  public
    { Public declarations }
    A065MW:TA065FStampaBudgetMW;
    Anno, DaMese, AMese: Integer;
    SolaLettura: Boolean;
    C004DMStm: TC004FParamForm;
    evtEseguiStampa: T065StmGenProc;
    evtT713FilterRecord: TFilterRecordProc;
    function CreateJSonString: String;
    function InizializzaFrame(pTipo, pCodGruppo, pDecorrenza: string): Boolean;
    procedure ElaborazioneServer;
  end;

implementation

{$R *.dfm}

{ TWA065FStampaBudgetFM }

procedure TWA065FStampaBudgetFM.AbilitaComponenti;
begin
  cmbDaMese.Enabled:=(dcmbTipo.Text <> '#ECC#');
  chkAggiornaFruito.Enabled:=not SolaLettura;
  if not chkAggiornaFruito.Enabled then
    chkAggiornaFruito.Checked:=False;
  chkAggiornaFruito.Caption:='Aggiornamento del fruito' + IfThen(dcmbTipo.Text = '#ECC#',' e riporto del residuo');
  if not chkDettaglioDipendenti.Enabled then
    chkDettaglioDipendenti.Checked:=False;
  chkTotMese.Enabled:=(cmbDaMese.ItemIndex <> cmbAMese.ItemIndex) and chkDettaglioDipendenti.Checked;
  if not chkTotMese.Enabled then
    chkTotMese.Checked:=False;
  chkCostoInMoneta.Enabled:=(dcmbTipo.Text = '#LIQ#') and chkDettaglioDipendenti.Checked;
  if not chkCostoInMoneta.Enabled then
    chkCostoInMoneta.Checked:=False;
end;

procedure TWA065FStampaBudgetFM.btnCambioDataClick(Sender: TObject);
begin
  inherited;
  ControlloPeriodo;
  RicaricaListaGruppiSel;
  A065MW.EseguiFiltroAnagrafeUtente(Anno,DaMese,AMese);
  A065MW.StruttureDisponibili(Anno,DaMese,AMese,dcmbTipo.Text);
  RicaricaClbGruppi;
  AbilitaComponenti;
end;

procedure TWA065FStampaBudgetFM.btnGeneraPDFClick(Sender: TObject);
begin
  inherited;
  ControlloPeriodo;
  RicaricaListaGruppiSel;
  if A065MW.ListaGruppiSel.Count = 0 then
    raise exception.create(A000MSG_A065_NO_GRUPPI);
  if Assigned(evtEseguiStampa) then
    evtEseguiStampa;
  PutParametriFunzione;
end;

procedure TWA065FStampaBudgetFM.ElaborazioneServer;
var DettaglioLog:OleVariant;
    DatiUtente: String;
begin
  //Chiamo Servizio COM B028 per creare il pdf su server
  (Self.Parent as TWR010FBase).DCOMNomeFile:=(Self.Parent as TWR010FBase).GetNomeFile('pdf');
  ForceDirectories(ExtractFileDir((Self.Parent as TWR010FBase).DCOMNomeFile));
  DatiUtente:=CreateJSonString;
  if (not IsLibrary) and
     (Pos(INI_PAR_NO_COINITIALIZE,W000ParConfig.ParametriAvanzati) = 0) then // gestione parametri di configurazione su file
    CoInitialize(nil);
  if not DCOMConnection.Connected then
    DCOMConnection.Connected:=True;
  try
    DCOMConnection.AppServer.PrintA065('',
                                       (Self.Parent as TWR010FBase).DCOMNomeFile,
                                       Parametri.Operatore,
                                       Parametri.Azienda,
                                       WR000DM.selAnagrafe.Session.LogonDataBase,
                                       DatiUtente,
                                       DettaglioLog);
  finally
    DCOMConnection.Connected:=False;
  end;
end;

procedure TWA065FStampaBudgetFM.chkDettaglioDipendentiClick(Sender: TObject);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TWA065FStampaBudgetFM.ControlloPeriodo;
var dData:TDateTime;
begin
  try
    dData:=StrToDate('01/01/' + sedtAnno.Text);
    Anno:=StrToInt(sedtAnno.Text);
  except
    raise exception.Create(A000MSG_A065_ERR_PERIODO);
  end;
  DaMese:=cmbDaMese.ItemIndex + 1;
  AMese:=cmbAMese.ItemIndex + 1;
  if cmbDaMese.ItemIndex > cmbAMese.ItemIndex then
    raise exception.Create(A000MSG_A065_ERR_PERIODO);
end;

function TWA065FStampaBudgetFM.CreateJSonString: String;
var
  json: TJSONObject;
  i: Integer;
begin
  json:=TJSONObject.Create;
  try
    //Popolo il json con i valori necessari al B028 per creare il PDF per la stampa
    json.AddPair('StandardPrinter',IfThen(Pos(INI_PAR_USE_STANDARD_PRINTER,W000ParConfig.ParametriAvanzati) > 0,'S','N'));
    C190Comp2JsonString(sedtAnno,json);
    C190Comp2JsonString(cmbDaMese,json);
    C190Comp2JsonString(cmbAMese,json);
    C190Comp2JsonString(dcmbTipo,json);

    C190Comp2JsonString(rgpTipoBudget,json);

    C190Comp2JsonString(chkSaltoPagina,json);
    C190Comp2JsonString(chkAggiornaFruito,json);
    C190Comp2JsonString(chkDettaglioDipendenti,json);
    C190Comp2JsonString(chkTotMese,json);
    C190Comp2JsonString(chkCostoInMoneta,json);
    C190Comp2JsonString(chkTotGruppo,json);
    C190Comp2JsonString(chkTotGenerale,json);

    json.AddPair('clbGruppi',TJSONString.Create(C190GetCheckList(22,clbGruppi)));

    Result:=json.ToString;
  finally
    FreeAndNil(json);
  end;
end;

procedure TWA065FStampaBudgetFM.dcmbTipoChange(Sender: TObject; Index: Integer);
begin
  inherited;
  if A065MW.selT275.Active then
    lblDescTipo.Caption:=VarToStr(A065MW.selT275.Lookup('CODICE',dcmbTipo.Text,'DESCRIZIONE'));
  if (dcmbTipo.Text = '#ECC#') and (cmbDaMese.ItemIndex <> 0) then
  begin
    cmbDaMese.ItemIndex:=0;
    btnCambioDataClick(nil);
  end
  else
  begin
    RicaricaListaGruppiSel;
    A065MW.StruttureDisponibili(Anno,DaMese,AMese,dcmbTipo.Text);
    RicaricaClbGruppi;
    AbilitaComponenti;
  end;
end;

procedure TWA065FStampaBudgetFM.GetParametriFunzione;
{Leggo i parametri della form}
begin
  if C004DMStm = nil then
    exit;
  dcmbTipo.Text:=C004DMStm.GetParametro('dcmbTipo','#LIQ#');
  chkSaltoPagina.Checked:=C004DMStm.GetParametro('SALTOPAGINA','N') = 'S';
  chkDettaglioDipendenti.Checked:=C004DMStm.GetParametro('DIPENDENTI','N') = 'S';
  chkTotMese.Checked:=C004DMStm.GetParametro('TOTMESE','N') = 'S';
  chkCostoInMoneta.Checked:=C004DMStm.GetParametro('COSTO','N') = 'S';
  chkTotGruppo.Checked:=C004DMStm.GetParametro('TOTREPARTO','N') = 'S';
  chkTotGenerale.Checked:=C004DMStm.GetParametro('TOTGENERALE','N') = 'S';
  rgpTipoBudget.ItemIndex:=StrToInt(C004DMStm.GetParametro('rgpTipoBudget','0'));
end;

procedure TWA065FStampaBudgetFM.GetParametriFunzione2;
{Leggo i parametri della form}
var x,y,i:integer;
    e: boolean;
    sValore,sNome,sElemento:string;
begin
  //lettura gruppi-tipi-mesi selezionati
  x:=0; //contatore di paramento
  sNome:='clbGruppi';
  repeat
    //ciclo sui parametri clbGruppi0,clbGruppi1,ecc.
    sValore:=C004DMStm.GetParametro(sNome + IntToStr(x),'');
    y:=0; //contatore di elementi nel parametro
    if sValore <> '' then
    begin
      repeat
        //ciclo sugli elementi nel parametro
        sElemento:=Copy(sValore,(y * 22) + 1,22);
        if sElemento <> '' then
        begin
          i:=0;
          e:=true;
          while (i < clbGruppi.Items.Count) and (e) do
          begin
            if Copy(clbGruppi.Items[i],1,22) = sElemento then
            begin
              clbGruppi.IsChecked[i]:=true;
              e:=false;
            end
            else if Copy(clbGruppi.Items[i],1,22) > sElemento then
              e:=false;
            inc(i);
          end;
          inc(y);
        end;
      until sElemento = '';
      inc(x);
    end;
  until sValore = '';
end;

function TWA065FStampaBudgetFM.InizializzaFrame(pTipo, pCodGruppo, pDecorrenza: string): Boolean;
var D,M,Y:Word;
    i:Integer;
begin
  Result:=False;
  A065MW:=TA065FStampaBudgetMW.Create(Self);
  if Assigned(evtT713FilterRecord) then
  begin
    A065MW.selT713.Filtered:=True;
    A065MW.selT713.OnFilterRecord:=evtT713FilterRecord;
  end;
  wCodGruppo:=pCodGruppo;
  wTipo:=pTipo;
  try
    wDecorrenza:=StrToDateTime(pDecorrenza);
    Anno:=R180Anno(wDecorrenza);
  except
    wDecorrenza:=0;
  end;
  if Anno = 0 then
    Anno:=R180Anno(Parametri.DataLavoro);
  sedtAnno.Text:=IntToStr(Anno);
  DecodeDate(Parametri.DataLavoro,Y,M,D);
  cmbDaMese.ItemIndex:=0;
  DaMese:=1;
  cmbAMese.ItemIndex:=M - 1;
  AMese:=M;
  chkCostoInMoneta.Visible:=Parametri.CampiRiferimento.C2_Livello <> '';
  if not chkCostoInMoneta.Visible then
    chkCostoInMoneta.Checked:=False;
  with A065MW.selT275 do
  begin
    while not Eof do
    begin
      dcmbTipo.AddRow(FieldByName('CODICE').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
    First;
    dcmbTipo.Text:=FieldByName('CODICE').AsString;
    lblDescTipo.Caption:=FieldByName('DESCRIZIONE').AsString;
  end;
  GetParametriFunzione;
  if wTipo <> '' then
    dcmbTipo.Text:=wTipo;
  //Recupero i gruppi abilitati all'utente corrente
  A065MW.EseguiFiltroAnagrafeUtente(Anno,DaMese,AMese);
  A065MW.StruttureDisponibili(Anno,DaMese,AMese,VarToStr(dcmbTipo.Text));
  //Carico in clbGruppi l'elenco dei gruppi appena recuperato, eventualmente selezionandoli
  RicaricaClbGruppi;
  //Seleziono i gruppi di clbGruppi in base al salvataggio precedente
  GetParametriFunzione2;
  //Allineo la lista dei gruppi selezionati in base al clbGruppi
  RicaricaListaGruppiSel;
  //Se sono richiamato dall'esterno...
  if wCodGruppo <> '' then
  begin
    //Cancello la lista dei gruppi selezionati
    for i:=0 to clbGruppi.Items.Count - 1 do
      clbGruppi.IsChecked[i]:=False;
    //Seleziono il gruppo richiamato
    if A065MW.selT713.SearchRecord('CODGRUPPO;TIPO;DECORRENZA',VarArrayOf([wCodGruppo,wTipo,wDecorrenza]),[srFromBeginning]) then
      clbGruppi.IsChecked[A065MW.selT713.RecNo - 1]:=True;
    //Allineo la lista dei gruppi selezionati in base al clbGruppi
    RicaricaListaGruppiSel;
  end;
  AbilitaComponenti;
  Result:=True;
end;

procedure TWA065FStampaBudgetFM.PutParametriFunzione;
{Scrivo i parametri della form}
var i,x,y:integer;
    sValore,sNome:string;
begin
  C004DMStm.Cancella001;
  C004DMStm.PutParametro('dcmbTipo',VarToStr(dcmbTipo.Text));
  C004DMStm.PutParametro('SALTOPAGINA',IfThen(chkSaltoPagina.Checked,'S','N'));
  C004DMStm.PutParametro('DIPENDENTI',IfThen(chkDettaglioDipendenti.Checked,'S','N'));
  C004DMStm.PutParametro('TOTMESE',IfThen(chkTotMese.Checked,'S','N'));
  C004DMStm.PutParametro('COSTO',IfThen(chkCostoInMoneta.Checked,'S','N'));
  C004DMStm.PutParametro('TOTREPARTO',IfThen(chkTotGruppo.Checked,'S','N'));
  C004DMStm.PutParametro('TOTGENERALE',IfThen(chkTotGenerale.Checked,'S','N'));
  C004DMStm.PutParametro('rgpTipoBudget',IntToStr(rgpTipoBudget.ItemIndex));
  //salvo l'elenco dei gruppi-tipi-mesi selezionati
  x:=0; //contatore parametri gruppi-tipi-decorrenze
  y:=0; //contatore elementi per parametro
  sValore:='';
  sNome:='clbGruppi';
  for i:=1 to clbGruppi.Items.Count do
    if clbGruppi.IsChecked[i-1] then
    begin
       sValore:=sValore + Copy(clbGruppi.Items[i-1],1,22);
       inc(y);
       if y = 90 then
       begin
          C004DMStm.PutParametro(sNome + IntToStr(x),sValore);
          inc(x);
          y:=0;
          sValore:='';
       end;
    end;
  C004DMStm.PutParametro(sNome + IntToStr(x),sValore);
  try SessioneOracle.Commit; except end;
end;

procedure TWA065FStampaBudgetFM.RicaricaClbGruppi;
var i:Integer;
begin
  //Carico in clbGruppi l'elenco dei gruppi appena recuperato
  clbGruppi.Items.Clear;
  for i:=0 to A065MW.ListaGruppi.Count - 1 do
    clbGruppi.Items.Add(A065MW.ListaGruppi[i]);
  //Seleziono i gruppi in clbGruppi
  for i:=0 to clbGruppi.Items.Count - 1 do
    clbGruppi.IsChecked[i]:=A065MW.ListaGruppiSel.IndexOf(clbGruppi.Items[i]) >= 0;
end;

procedure TWA065FStampaBudgetFM.RicaricaListaGruppiSel;
var i:Integer;
begin
  A065MW.ListaGruppiSel.Clear;
  for i:=0 to clbGruppi.Items.Count - 1 do
    if clbGruppi.IsChecked[i] then
      A065MW.ListaGruppiSel.Add(clbGruppi.Items[i]);
end;

procedure TWA065FStampaBudgetFM.sedtAnnoAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[btnCambioData.HTMLName]));
end;

procedure TWA065FStampaBudgetFM.Selezionatutto1Click(Sender: TObject);
var i:Integer;
begin
  for i:=0 to clbGruppi.Items.Count - 1 do
    if Sender = Selezionatutto1 then
      clbGruppi.IsChecked[i]:=True
    else if Sender = Deselezionatutto1 then
      clbGruppi.IsChecked[i]:=False
    else if Sender = Invertiselezione1 then
      clbGruppi.IsChecked[i]:=not clbGruppi.IsChecked[i];
  clbGruppi.AsyncUpdate;
end;

end.
