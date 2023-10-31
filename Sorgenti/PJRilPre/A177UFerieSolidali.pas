unit A177UFerieSolidali;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R001UGESTTAB, System.Actions, C700USelezioneAnagrafe,
  Vcl.ActnList, System.ImageList, Vcl.ImgList, Data.DB, Vcl.Menus, Vcl.ComCtrls,
  Vcl.ToolWin, SelAnagrafe, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Mask,
  Vcl.Buttons, Math, C015UElencoValori, Oracle, OracleData, StrUtils,
  A000USessione, A000UInterfaccia, A000UMessaggi, A003UDataLavoroBis, C180FunzioniGenerali,
  Vcl.Grids, Vcl.DBGrids, A083UMsgElaborazioni;

type
  TA177FFerieSolidali = class(TR001FGestTab)
    frmSelAnagrafe: TfrmSelAnagrafe;
    pnlAzioni: TPanel;
    btnEsegui: TBitBtn;
    btnAnomalie: TBitBtn;
    chkAggiornaQuantita: TCheckBox;
    chkAggiornaProfili: TCheckBox;
    Panel2: TPanel;
    chkAzzeraQuantita: TCheckBox;
    dgrdFerieSolidali: TDBGrid;
    pnlStato: TPanel;
    lblTermine: TLabel;
    lblQuantitaRestituita: TLabel;
    dedtTermine: TDBEdit;
    drdgStato: TDBRadioGroup;
    dedtQuantitaRestituita: TDBEdit;
    pnlDati: TPanel;
    lblAnno: TLabel;
    lblRaggruppamento: TLabel;
    lblDecorrenza: TLabel;
    lblScadenza: TLabel;
    lblIDRichiesta: TLabel;
    lblDescrizione: TLabel;
    lblQuantitaRichiesta: TLabel;
    lblQuantitaOttenuta: TLabel;
    lblQuantitaOfferta: TLabel;
    lblQuantitaAccettata: TLabel;
    lblDescRaggruppamento: TLabel;
    lblCausale: TLabel;
    lblDescCausale: TLabel;
    lblTotOfferte: TLabel;
    drdgTipo: TDBRadioGroup;
    dedtAnno: TDBEdit;
    dcmbRaggruppamento: TDBLookupComboBox;
    dRdgUMisura: TDBRadioGroup;
    dedtDecorrenza: TDBEdit;
    dedtScadenza: TDBEdit;
    dedtIDRichiesta: TDBEdit;
    dedtDescrizione: TDBEdit;
    dedtQuantitaRichiesta: TDBEdit;
    btnDecorrenza: TButton;
    btnScadenza: TButton;
    dedtQuantitaOttenuta: TDBEdit;
    dedtQuantitaOfferta: TDBEdit;
    dedtQuantitaAccettata: TDBEdit;
    btnIDRichiesta: TButton;
    dcmbCausale: TDBLookupComboBox;
    btnVisOfferte: TBitBtn;
    edtTotOfferte: TEdit;
    MnuCopia: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Annullatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    N9: TMenuItem;
    Copia1: TMenuItem;
    CopiaInExcel: TMenuItem;
    chkImpostaTermine: TCheckBox;
    btnTermine: TButton;
    edtTermine: TMaskEdit;
    procedure FormShow(Sender: TObject);
    procedure btnDecorrenzaClick(Sender: TObject);
    procedure btnScadenzaClick(Sender: TObject);
    procedure btnTermineClick(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure drdgTipoClick(Sender: TObject);
    procedure dcmbRaggruppamentoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dedtAnnoExit(Sender: TObject);
    procedure dcmbRaggruppamentoCloseUp(Sender: TObject);
    procedure dcmbRaggruppamentoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnIDRichiestaClick(Sender: TObject);
    procedure chkAggiornaQuantitaClick(Sender: TObject);
    procedure dRdgUMisuraClick(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure chkAzzeraQuantitaClick(Sender: TObject);
    procedure chkAggiornaProfiliClick(Sender: TObject);
    procedure dcmbCausaleCloseUp(Sender: TObject);
    procedure dcmbCausaleKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnVisOfferteClick(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Annullatutto1Click(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure Copia1Click(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure chkImpostaTermineClick(Sender: TObject);
    procedure TRegisClick(Sender: TObject);
    procedure TCancClick(Sender: TObject);
  private
    { Private declarations }
    procedure CambiaProgressivo;
  public
    { Public declarations }
    procedure Abilitazioni;
  end;


var
  A177FFerieSolidali: TA177FFerieSolidali;

procedure OpenA177FerieSolidali;

implementation

{$R *.dfm}

uses A177UFerieSolidaliDM;

procedure OpenA177FerieSolidali;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA177FerieSolidali') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A177FFerieSolidaliDM:=TA177FFerieSolidaliDM.Create(nil);
  try
    A177FFerieSolidali:=TA177FFerieSolidali.Create(nil);
    A177FFerieSolidali.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    Screen.Cursor:=crDefault;
    FreeAndNil(A177FFerieSolidali);
    FreeAndNil(A177FFerieSolidaliDM);
  end;
end;

procedure TA177FFerieSolidali.FormShow(Sender: TObject);
begin
  inherited;
  DButton.DataSet:=A177FFerieSolidaliDM.selT254;
  A177FFerieSolidali.dcmbRaggruppamento.ListSource:=A177FFerieSolidaliDM.A177MW.dsrT260;
  A177FFerieSolidali.dcmbCausale.ListSource:=A177FFerieSolidaliDM.A177MW.dsrT265;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,StatusBar,2,True);
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  A177FFerieSolidaliDM.A177MW.SelAnagrafe:=C700SelAnagrafe;
  CambiaProgressivo;
  A177FFerieSolidaliDM.selT254.First;
end;

procedure TA177FFerieSolidali.Invertiselezione1Click(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(dgrdFerieSolidali,'C');
end;

procedure TA177FFerieSolidali.Selezionatutto1Click(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(dgrdFerieSolidali,'S');
end;

procedure TA177FFerieSolidali.TCancClick(Sender: TObject);
begin
  inherited;
  A177FFerieSolidaliDM.selT254Vis.Refresh;
end;

procedure TA177FFerieSolidali.TRegisClick(Sender: TObject);
begin
  inherited;
  A177FFerieSolidaliDM.selT254Vis.Refresh;
end;

procedure TA177FFerieSolidali.Annullatutto1Click(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(dgrdFerieSolidali,'N');
end;

procedure TA177FFerieSolidali.btnAnomalieClick(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A177','');
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe;
end;

procedure TA177FFerieSolidali.btnDecorrenzaClick(Sender: TObject);
begin
  if DButton.DataSet.FieldByName('DECORRENZA').IsNull then
    DButton.DataSet.FieldByName('DECORRENZA').AsDateTime:=DataOut(Parametri.DataLavoro,'Decorrenza','G')
  else
    DButton.DataSet.FieldByName('DECORRENZA').AsDateTime:=DataOut(DButton.DataSet.FieldByName('DECORRENZA').AsDateTime,'Decorrenza','G');
end;

procedure TA177FFerieSolidali.btnScadenzaClick(Sender: TObject);
begin
  inherited;
  if DButton.DataSet.FieldByName('DECORRENZA_FINE').IsNull then
    DButton.DataSet.FieldByName('DECORRENZA_FINE').AsDateTime:=DataOut(Parametri.DataLavoro,'Scadenza','G')
  else
    DButton.DataSet.FieldByName('DECORRENZA_FINE').AsDateTime:=DataOut(DButton.DataSet.FieldByName('DECORRENZA_FINE').AsDateTime,'Scadenza','G');
end;

procedure TA177FFerieSolidali.btnTermineClick(Sender: TObject);
var d:TDateTime;
begin
  inherited;
  if not TryStrToDate(edtTermine.Text,d) then
    d:=Parametri.DataLavoro;
  edtTermine.Text:=DateToStr(DataOut(d,'Termine diritto','G'));
end;

procedure TA177FFerieSolidali.btnVisOfferteClick(Sender: TObject);
var vCodice:Variant;
begin
  inherited;
  with A177FFerieSolidaliDM.A177MW do
  begin
    //Visualizzo elenco di tutte le offerte legate a questa richiesta
    R180SetVariable(selT254a,'ID_RICHIESTA',selT254.FieldByName('ID_RICHIESTA').AsInteger);
    R180SetVariable(selT254a,'ORDINAMENTO','T030.COGNOME, T030.NOME, T030.MATRICOLA, T254.DECORRENZA, T254.CODRAGGR');
    R180SetVariable(selT254a,'DATI','');
    selT254a.Open;
    selT254a.Refresh;
    vCodice:=VarArrayOf([selT254a.FieldByName('ID_RICHIESTA').AsInteger]);
    OpenC015FElencoValori('T254_FERIESOLIDALI','Elenco offerte','','ID_RICHIESTA',vCodice,selT254a,800,400,False);
  end;
end;

procedure TA177FFerieSolidali.CambiaProgressivo;
begin
  with A177FFerieSolidaliDM do
  begin
    selT254.Close;
    selT254.SetVariable('PROGRESSIVO',C700Progressivo);
    selT254.Open;
    selT254Vis.Close;
    selT254Vis.SetVariable('PROGRESSIVO',C700Progressivo);
    selT254Vis.Open;
  end;
end;

procedure TA177FFerieSolidali.dcmbCausaleCloseUp(Sender: TObject);
begin
  inherited;
  lblDescCausale.Caption:='';
  if A177FFerieSolidaliDM.A177MW.selT265.Active and A177FFerieSolidaliDM.A177MW.selT265.SearchRecord('CODICE',dcmbCausale.Text,[srFromBeginning]) then
    lblDescCausale.Caption:=A177FFerieSolidaliDM.A177MW.selT265.FieldByName('DESCRIZIONE').AsString;
end;

procedure TA177FFerieSolidali.dcmbCausaleKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  dcmbCausaleCloseUp(nil);
end;

procedure TA177FFerieSolidali.dcmbRaggruppamentoCloseUp(Sender: TObject);
begin
  inherited;
  with A177FFerieSolidaliDM.A177MW do
  begin
    lblDescRaggruppamento.Caption:='';
    lblDescCausale.Caption:='';
    if drdgTipo.ItemIndex = 0 then  //Richiesta
    begin
      if selT260.SearchRecord('CODICE',dcmbRaggruppamento.Text,[srFromBeginning]) then
        lblDescRaggruppamento.Caption:=selT260.FieldByName('DESCRIZIONE').AsString;
      ImpostaCausale(dcmbRaggruppamento.Text,selT254.FieldByName('UMISURA').AsString);
    end
    else if drdgTipo.ItemIndex = 1 then //Offerta
    begin
      if selT262.SearchRecord('CODICE',dcmbRaggruppamento.Text,[srFromBeginning]) then
        lblDescRaggruppamento.Caption:=selT262.FieldByName('DESCRIZIONE').AsString;
      if DButton.State in [dsInsert] then
      begin
        selT254.FieldByName('UMISURA').AsString:=selT262.FieldByName('UMISURA').AsString;
        dRdgUMisuraClick(nil);
      end;
      ImpostaCausale(dcmbRaggruppamento.Text,'');
    end;
  end;
end;

procedure TA177FFerieSolidali.dcmbRaggruppamentoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA177FFerieSolidali.dcmbRaggruppamentoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  dcmbRaggruppamentoCloseUp(nil);
end;

procedure TA177FFerieSolidali.dedtAnnoExit(Sender: TObject);
begin
  inherited;
  with A177FFerieSolidaliDM.A177MW do
  begin
    if Trim(selT254.FieldByName('ANNO').AsString) <> '' then
    begin
      R180SetVariable(selT262,'ANNO',selT254.FieldByName('ANNO').AsString);
      R180SetVariable(selT262,'PROGRESSIVO',selT254.FieldByName('PROGRESSIVO').AsInteger);
      selT262.Open;
    end;
  end;
end;

procedure TA177FFerieSolidali.btnIDRichiestaClick(Sender: TObject);
var vCodice:Variant;
begin
  inherited;
  with A177FFerieSolidaliDM.A177MW do
  begin
    //Proporre elenco di tutte le richieste valide (decorrenza offerta between decorrenza-scadenza richiesta) che non sono ancora state caricate sul dip.corrente
    //Proporre opzione 'TUTTE' di modo che si possa indicare che l'offerta è valida per tutte le richieste (ID_RICHIESTA sarà -1)
    R180SetVariable(selT254Rich,'DEC_OFFERTA',selT254.FieldByName('DECORRENZA').AsDateTime);
    R180SetVariable(selT254Rich,'PROGRESSIVO',selT254.FieldByName('PROGRESSIVO').AsInteger);
    R180SetVariable(selT254Rich,'UMISURA',selT254.FieldByName('UMISURA').AsString);
    selT254Rich.Open;
    selT254Rich.Refresh;
    if selT254Rich.RecordCount <= 1 then   //1 record c'è per id_richiesta -1 (tutte) quindi deve essercene almeno un'altra
    begin
      selT254.FieldByName('UMISURA').FocusControl;
      raise Exception.Create(A000MSG_A177_ERR_OFF_UMISURA);  //Alla decorrenza specificata, non sono presenti richieste aperte valide con questa unità di misura!
    end;
    selT254Rich.First;
    vCodice:=VarArrayOf([selT254.FieldByName('ID_RICHIESTA').AsInteger]);
    OpenC015FElencoValori('T254_FERIESOLIDALI','Scelta richiesta ferie solidali','','ID_RICHIESTA',vCodice,selT254Rich,500,300);
    if not VarIsClear(vCodice) then
      DButton.DataSet.FieldByName('ID_RICHIESTA').AsInteger:=StrToIntDef(VarToStr(vCodice[0]),0);
    lblDescrizione.Caption:='';
    if selT254Rich.SearchRecord('ID_RICHIESTA',DButton.DataSet.FieldByName('ID_RICHIESTA').AsInteger,[srFromBeginning]) then
      lblDescrizione.Caption:=selT254Rich.FieldByName('DESCRIZIONE').AsString;
  end;
end;

procedure TA177FFerieSolidali.drdgTipoClick(Sender: TObject);
begin
  inherited;
  if DButton.State in [dsInsert] then
    A177FFerieSolidaliDM.A177MW.selT254NewRecord(IfThen(drdgTipo.ItemIndex=0,'R','O'));
  Abilitazioni;
end;

procedure TA177FFerieSolidali.DButtonStateChange(Sender: TObject);
begin
  inherited;
  Abilitazioni;
end;

procedure TA177FFerieSolidali.Abilitazioni;
var TotOfferte:Real;
begin
  actModifica.Enabled:=(not SolaLettura) and (DButton.State = dsBrowse) and (A177FFerieSolidaliDM.selT254.FieldByName('ID_RICHIESTA').AsInteger <> -1) and (DButton.DataSet.FieldByName('STATO').AsString = 'A');
  actCancella.Enabled:=(not SolaLettura) and (DButton.State = dsBrowse) and (DButton.DataSet.FieldByName('STATO').AsString = 'A');
  lblDescCausale.Caption:='';
  lblDescRaggruppamento.Caption:='';
  lblDescrizione.Caption:='';

  drdgTipo.Enabled:=DButton.State = dsInsert;
  dedtAnno.Enabled:=DButton.State = dsInsert;
  dedtDecorrenza.Enabled:=DButton.State = dsInsert;
  btnDecorrenza.Enabled:=DButton.State = dsInsert;
  dcmbRaggruppamento.Enabled:=DButton.State = dsInsert;
  dcmbCausale.Enabled:=DButton.State = dsInsert;
  dRdgUMisura.Enabled:=DButton.State = dsInsert;

  lblScadenza.Visible:=drdgTipo.ItemIndex=0; //Richiesta
  dedtScadenza.Visible:=drdgTipo.ItemIndex=0; //Richiesta
  btnScadenza.Visible:=drdgTipo.ItemIndex=0; //Richiesta
  btnScadenza.Enabled:=(DButton.State in [dsEdit,dsInsert]);
  dedtDescrizione.Visible:=drdgTipo.ItemIndex=0; //Richiesta
  lblQuantitaRichiesta.Visible:=drdgTipo.ItemIndex=0; //Richiesta
  dedtQuantitaRichiesta.Visible:=drdgTipo.ItemIndex=0; //Richiesta
  lblQuantitaOttenuta.Visible:=drdgTipo.ItemIndex=0; //Richiesta
  dedtQuantitaOttenuta.Visible:=drdgTipo.ItemIndex=0; //Richiesta
  lblTotOfferte.Visible:=drdgTipo.ItemIndex=0; //Richiesta
  edtTotOfferte.Visible:=drdgTipo.ItemIndex=0; //Richiesta
  btnVisOfferte.Visible:=drdgTipo.ItemIndex=0; //Richiesta
  btnVisOfferte.Enabled:=DButton.State = dsBrowse;

  btnIDRichiesta.Visible:=drdgTipo.ItemIndex=1; //Offerta
  btnIDRichiesta.Enabled:=DButton.State = dsInsert;
  lblQuantitaOfferta.Visible:=drdgTipo.ItemIndex=1; //Offerta
  dedtQuantitaOfferta.Visible:=drdgTipo.ItemIndex=1; //Offerta
  lblQuantitaAccettata.Visible:=drdgTipo.ItemIndex=1; //Offerta
  dedtQuantitaAccettata.Visible:=drdgTipo.ItemIndex=1; //Offerta

  with A177FFerieSolidaliDM.A177MW do
  begin
    if drdgTipo.ItemIndex = 0 then  //Se richiesta propongo raggruppamenti 'Ferie solidali'
    begin
      lblDescrizione.Font.Color:=clBlue;
      lblDescrizione.Caption:='Descrizione';
      dcmbRaggruppamento.ListSource:=dsrT260;
      //Conteggio il totale delle offerte legate a questo ID_Richiesta
      TotOfferte:=0;
      R180SetVariable(selT254a,'ID_RICHIESTA',selT254.FieldByName('ID_RICHIESTA').AsInteger);
      R180SetVariable(selT254a,'ORDINAMENTO','T030.COGNOME, T030.NOME, T030.MATRICOLA, T254.DECORRENZA, T254.CODRAGGR');
      R180SetVariable(selT254a,'DATI','');
      selT254a.Open;
      selT254a.Refresh;
      selT254a.First;
      while not selT254a.Eof do
      begin
        if selT254a.FieldByName('UMISURA').AsString = 'G' then
          TotOfferte:=TotOfferte + StrToFloat(selT254a.FieldByName('QUANTITA_OFFERTA').AsString)
        else
          TotOfferte:=TotOfferte + R180OreMinutiExt(selT254a.FieldByName('QUANTITA_OFFERTA').AsString);
        selT254a.Next;
      end;
      edtTotOfferte.Text:=IfThen(selT254.FieldByName('UMISURA').AsString = 'G',FloatToStr(TotOfferte),R180MinutiOre(Trunc(TotOfferte)));
    end
    else if drdgTipo.ItemIndex = 1 then //Se offerta propongo raggruppamenti 'Congedo ordinario' e 'Festività soppresse'
    begin
      lblDescrizione.Font.Color:=clBlack;
      lblDescrizione.Caption:=selT254.FieldByName('DESCR_OFFERTA').AsString;
      dcmbRaggruppamento.ListSource:=dsrT262;
    end;
  end;
  dedtAnnoExit(nil);
  dRdgUMisuraClick(nil);
  dcmbRaggruppamentoCloseUp(nil);
  dcmbCausaleCloseUp(nil);

  chkAggiornaQuantita.Enabled:=(not SolaLettura) and (drdgTipo.ItemIndex=0) and (DButton.State = dsBrowse) and (DButton.DataSet.FieldByName('STATO').AsString = 'A'); //Richiesta-Aperta
  if not chkAggiornaQuantita.Enabled then
    chkAggiornaQuantita.Checked:=False;
  chkAzzeraQuantita.Enabled:=(not SolaLettura) and (drdgTipo.ItemIndex=0) and (DButton.State = dsBrowse) and (DButton.DataSet.FieldByName('STATO').AsString = 'C'); //Richiesta-Chiusa
  if not chkAzzeraQuantita.Enabled then
    chkAzzeraQuantita.Checked:=False;
  chkAggiornaProfili.Enabled:=(not SolaLettura) and (drdgTipo.ItemIndex=0) and (DButton.State = dsBrowse) and (DButton.DataSet.FieldByName('STATO').AsString = 'C'); //Richiesta-Chiusa
  if not chkAggiornaProfili.Enabled then
    chkAggiornaProfili.Checked:=False;
  chkImpostaTermine.Enabled:=(not SolaLettura) and (drdgTipo.ItemIndex=0) and (DButton.State = dsBrowse) and (DButton.DataSet.FieldByName('STATO').AsString = 'F') and (DButton.DataSet.FieldByName('TERMINE_DIRITTO').IsNull); //Richiesta-Fruibile
  if not chkImpostaTermine.Enabled then
    chkImpostaTermine.Checked:=False;
end;

procedure TA177FFerieSolidali.dRdgUMisuraClick(Sender: TObject);
begin
  inherited;
  with A177FFerieSolidaliDM.A177MW do
  begin
    if dRdgUMisura.ItemIndex = 1 then  //Ore
    begin
      selT254.FieldByName('QUANTITA_RICHIESTA').EditMask:='!9990.00;1;_';
      selT254.FieldByName('QUANTITA_OFFERTA').EditMask:='!9990.00;1;_';
      selT254.FieldByName('QUANTITA_OTTENUTA').EditMask:='!9990.00;1;_';
      selT254.FieldByName('QUANTITA_ACCETTATA').EditMask:='!9990.00;1;_';
      selT254.FieldByName('QUANTITA_RESTITUITA').EditMask:='!9990.00;1;_';

    end
    else  //Giorni
    begin
      selT254.FieldByName('QUANTITA_RICHIESTA').EditMask:='!990,9;1;_';
      selT254.FieldByName('QUANTITA_OFFERTA').EditMask:='!990,9;1;_';
      selT254.FieldByName('QUANTITA_OTTENUTA').EditMask:='!990,9;1;_';
      selT254.FieldByName('QUANTITA_ACCETTATA').EditMask:='!990,9;1;_';
      selT254.FieldByName('QUANTITA_RESTITUITA').EditMask:='!990,9;1;_';
    end;
    if (DButton.State in [dsInsert]) and (drdgTipo.ItemIndex = 0) then
    begin
      edtTotOfferte.Text:='0'; //Forzo sempre zero anche in caso di ore
      selT254.FieldByName('QUANTITA_RICHIESTA').AsString:=IfThen(dRdgUMisura.ItemIndex = 1, R180MinutiOre(ValenzaGiornata * 30),'30');
      ImpostaCausale(dcmbRaggruppamento.Text,IfThen(dRdgUMisura.ItemIndex = 1,'O','G'));
      dcmbCausaleCloseUp(nil);
    end;
  end;
end;

procedure TA177FFerieSolidali.Copia1Click(Sender: TObject);
begin
  inherited;
  R180DBGridCopyToClipboard(dgrdFerieSolidali,Sender = CopiaInExcel);
end;

procedure TA177FFerieSolidali.chkAggiornaQuantitaClick(Sender: TObject);
begin
  inherited;
  //Richiesta Aperta
  btnEsegui.Enabled:=chkAggiornaQuantita.Checked or chkAzzeraQuantita.Checked or chkAggiornaProfili.Checked or chkImpostaTermine.Checked;
end;

procedure TA177FFerieSolidali.chkAzzeraQuantitaClick(Sender: TObject);
begin
  inherited;
  //Richiesta Chiusa
  chkAggiornaProfili.Enabled:=not chkAzzeraQuantita.Checked;
  if not chkAggiornaProfili.Enabled then
    chkAggiornaProfili.Checked:=False;
  btnEsegui.Enabled:=chkAggiornaQuantita.Checked or chkAzzeraQuantita.Checked or chkAggiornaProfili.Checked or chkImpostaTermine.Checked;
end;

procedure TA177FFerieSolidali.chkAggiornaProfiliClick(Sender: TObject);
begin
  inherited;
  //Richiesta Chiusa
  chkAzzeraQuantita.Enabled:=not chkAggiornaProfili.Checked;
  if not chkAzzeraQuantita.Enabled then
    chkAzzeraQuantita.Checked:=False;
  btnEsegui.Enabled:=chkAggiornaQuantita.Checked or chkAzzeraQuantita.Checked or chkAggiornaProfili.Checked or chkImpostaTermine.Checked;
end;

procedure TA177FFerieSolidali.chkImpostaTermineClick(Sender: TObject);
begin
  inherited;
  //Richiesta Fruibile
  edtTermine.Visible:=chkImpostaTermine.Checked;
  btnTermine.Visible:=chkImpostaTermine.Checked;
  btnEsegui.Enabled:=chkAggiornaQuantita.Checked or chkAzzeraQuantita.Checked or chkAggiornaProfili.Checked or chkImpostaTermine.Checked;
end;

procedure TA177FFerieSolidali.btnEseguiClick(Sender: TObject);
begin
  inherited;
  //NOTA: L'UNITA' DI MISURA DELLA RICHIESTA E' UGUALE ALL'UNITA' DI MISURA DELLE OFFERTE
  btnAnomalie.Enabled:=False;
  RegistraMsg.IniziaMessaggio('A177');
  with A177FFerieSolidaliDM.A177MW do
  begin
    ParametriElaborazione.bAggiornaQuantita:=chkAggiornaQuantita.Checked;
    ParametriElaborazione.bAggiornaProfili:=chkAggiornaProfili.Checked;
    ParametriElaborazione.bAzzeraQuantita:=chkAzzeraQuantita.Checked;
    ParametriElaborazione.bImpostaTermine:=chkImpostaTermine.Checked;
    ParametriElaborazione.sDataTermine:=edtTermine.Text;

    if chkAggiornaQuantita.Checked then
    begin
      //Prima di chiudere è necessario specificare la scadenza!
      if selT254.FieldByName('DECORRENZA_FINE').IsNull then
      begin
        selT254.FieldByName('DECORRENZA_FINE').FocusControl;
        raise Exception.Create(A000MSG_A177_ERR_SCADENZA_NULLA);
      end;
    end
    //Attenzione: riportando lo stato richiesta ad Aperta, verranno azzerate tutte le quantità ottenute e accettate. Continuare comunque?
    else if chkAzzeraQuantita.Checked then
    begin
      if R180MessageBox(A000MSG_A177_DLG_STATO_APERTA,'DOMANDA') <> mrYes then
        Exit;
    end
    else if chkImpostaTermine.Checked then
    begin
      ControllaTermineDiritto;
      if ((selT254.FieldByName('UMISURA').AsString = 'G') and (ResiduoRichiesta <= 0)) or
         ((selT254.FieldByName('UMISURA').AsString = 'O') and (ResiduoRichiestaHH <= 0)) then
      begin
        if R180MessageBox(A000MSG_A177_DLG_QUANTITA_TERMINE,'DOMANDA') <> mrYes then      //Attenzione: la quantità ottenuta di ferie solidali è stata interamente fruita, l''impostazione della data termine diritto non avrà alcun effetto sulle quantità restituite. Continuare comunque?
          Abort;
      end;
      if ((selT254.FieldByName('UMISURA').AsString = 'G') and (ResiduoRichiesta > StrToFloat(selT254.FieldByName('QUANTITA_OTTENUTA').AsString))) or
         ((selT254.FieldByName('UMISURA').AsString = 'O') and (ResiduoRichiestaHH > R180OreMinutiExt(selT254.FieldByName('QUANTITA_OTTENUTA').AsString))) then
      begin
        if R180MessageBox(A000MSG_A177_DLG_QUANTITA_RESTITUITA,'DOMANDA') <> mrYes then      //Attenzione: la quantità residua di ferie solidali %s è maggiore della quantità ottenuta, verrà restituita la sola quantità ottenuta. Continuare comunque?';
          Abort;
      end;
    end;

    Elaborazione;
  end;
  actRefresh.Execute;
  A177FFerieSolidaliDM.selT254Vis.Refresh;
  btnAnomalie.Enabled:=RegistraMsg.ContieneTipoA;
  if RegistraMsg.ContieneTipoA then
  begin
    if R180MessageBox(A000MSG_DLG_ELAB_ANOMALIE_VIS,DOMANDA) = mrYes then
      btnAnomalieClick(nil);
  end
  else
    R180MessageBox(A000MSG_MSG_ELABORAZIONE_TERMINATA,INFORMA);
end;

end.
