unit A163UTipoQuote;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGestStorico, ActnList, ImgList, DB, Menus, StdCtrls, ComCtrls,
  ToolWin, Mask, DBCtrls, Buttons, Grids, DBGrids, ExtCtrls, A000UInterfaccia,
  A000UCostanti, A000USessione, C013UCheckList, C180FunzioniGenerali,
  System.Actions, A163UTipoQuoteMW;

type
  TA163FTipoQuote = class(TR004FGestStorico)
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    dedtCodice: TDBEdit;
    dedtDescrizione: TDBEdit;
    drdgTipologia: TDBRadioGroup;
    dgrTipoQuote: TDBGrid;
    GroupBox1: TGroupBox;
    dedtVPIntera: TDBEdit;
    lblVPIntera: TLabel;
    lblCausale: TLabel;
    dedtVPProporzionata: TDBEdit;
    lblVPProporzionata: TLabel;
    dedtVPNetta: TDBEdit;
    lblVPNetta: TLabel;
    lblVPNettaRisp: TLabel;
    dedtVPNettaRisp: TDBEdit;
    dedtVPRisparmio: TDBEdit;
    lblVPRisparmio: TLabel;
    dedtVPNoRisp: TDBEdit;
    lblVPNoRisp: TLabel;
    dedtVPQuantitativa: TDBEdit;
    lblVPQuantitativa: TLabel;
    dcmbCausale: TDBLookupComboBox;
    dtxtCausale: TDBText;
    dedtAcconti: TDBEdit;
    lblAcconti: TLabel;
    btnAcconti: TBitBtn;
    dchkImpostaMeseCompMax: TDBCheckBox;
    dchkRifSaldoAnnoCorr: TDBCheckBox;
    dedtGiorniMese: TDBEdit;
    lblGiorniMese: TLabel;
    procedure FormShow(Sender: TObject);
    procedure TInserClick(Sender: TObject);
    procedure btnStoricizzaClick(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure drdgTipologiaChange(Sender: TObject);
    procedure dchkRifSaldoAnnoCorrClick(Sender: TObject);
    procedure btnAccontiClick(Sender: TObject);
    procedure dcmbCausaleCloseUp(Sender: TObject);
    procedure dcmbCausaleKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dcmbCausaleKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dedtGiorniMeseExit(Sender: TObject);
  private
    { Private declarations }
    procedure AbilitaComponenti;
  public
    { Public declarations }
  end;

var
  A163FTipoQuote: TA163FTipoQuote;

  procedure OpenA163TipoQuote;

implementation

uses A163UTipoQuoteDtM;

{$R *.dfm}

procedure OpenA163TipoQuote;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA163TipoQuote') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Application.CreateForm(TA163FTipoQuote, A163FTipoQuote);
  Application.CreateForm(TA163FTipoQuoteDtM, A163FTipoQuoteDtM);
  try
    Screen.Cursor:=crDefault;
    A163FTipoQuote.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A163FTipoQuote.Free;
    A163FTipoQuoteDtM.Free;
  end;
end;

procedure TA163FTipoQuote.FormShow(Sender: TObject);
begin
  inherited;
  DButton.DataSet:=A163FTipoQuoteDtM.selT765;
  A163FTipoQuoteDtM.selT765.Open;
  dcmbCausale.ListSource:=A163FTipoQuoteDtM.A163FTipoQuoteMW.dsrT305;
  dtxtCausale.Visible:=Trim(dcmbCausale.Text) <> '';
  dchkRifSaldoAnnoCorr.Top:=dchkImpostaMeseCompMax.Top;
  dchkRifSaldoAnnoCorr.Left:=dchkImpostaMeseCompMax.Left;
end;

procedure TA163FTipoQuote.btnStoricizzaClick(Sender: TObject);
begin
  inherited;
  dedtDecorrenza.SetFocus;
end;

procedure TA163FTipoQuote.TInserClick(Sender: TObject);
begin
  inherited;
  dedtCodice.SetFocus;
end;

procedure TA163FTipoQuote.DButtonStateChange(Sender: TObject);
begin
  inherited;
  drdgTipologia.Enabled:=not InterfacciaR004.StoricizzazioneInCorso;
  AbilitaComponenti;
end;

procedure TA163FTipoQuote.drdgTipologiaChange(Sender: TObject);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TA163FTipoQuote.dchkRifSaldoAnnoCorrClick(Sender: TObject);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TA163FTipoQuote.btnAccontiClick(Sender: TObject);
begin
  inherited;
  C013FCheckList:=TC013FCheckList.Create(nil);
  with C013FCheckList do
  try
    //with A163FTipoQuoteDtM.selT765Acc do
    with A163FTipoQuoteDtM.A163FTipoQuoteMW.selT765Acc do
    begin
      Close;
      if drdgTipologia.ItemIndex = 8 then
        SetVariable('TIPOQUOTA','''A'',''S'',''T'',''I'',''V'',''C'',''D'',''N''')
      else
        SetVariable('TIPOQUOTA','''A''');
      SetVariable('DATA',A163FTipoQuoteDtM.selT765.FieldByName('DECORRENZA').AsDateTime);
      Open;
      First;
      while not Eof do
      begin
        C013FCheckList.clbListaDati.Items.Add(Format('%-5s %s',[FieldByName('Codice').AsString,FieldByName('Descrizione').AsString]));
        Next;
      end;
    end;
    R180PutCheckList(dedtAcconti.Text,5,C013FCheckList.clbListaDati);
    if ShowModal = mrOK then
      dedtAcconti.Text:=R180GetCheckList(5,C013FCheckList.clbListaDati);
  finally
    Release;
  end;
end;

procedure TA163FTipoQuote.dcmbCausaleCloseUp(Sender: TObject);
begin
  inherited;
  dtxtCausale.Visible:=Trim(dcmbCausale.Text) <> '';
end;

procedure TA163FTipoQuote.dcmbCausaleKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TA163FTipoQuote.dcmbCausaleKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  dcmbCausaleCloseUp(nil);
end;

procedure TA163FTipoQuote.dedtGiorniMeseExit(Sender: TObject);
begin
  inherited;
  with A163FTipoQuoteDtM do
    selT765.FieldByName('GIORNI_MESE').AsFloat:=R180Arrotonda(selT765.FieldByName('GIORNI_MESE').AsFloat,0.00001,'P');
end;

procedure TA163FTipoQuote.AbilitaComponenti;
begin
  dchkImpostaMeseCompMax.Visible:=drdgTipologia.ItemIndex = 7;
  dchkRifSaldoAnnoCorr.Visible:=drdgTipologia.ItemIndex = 3;
  if DButton.State in [dsEdit,dsInsert] then
  begin
    if not dchkImpostaMeseCompMax.Visible then
      A163FTipoQuoteDtM.selT765.FieldByName('IMPOSTA_MESE_COMP_MAX').AsString:='N';
    if not dchkRifSaldoAnnoCorr.Visible then
      A163FTipoQuoteDtM.selT765.FieldByName('RIF_SALDO_ANNO_CORR').AsString:='N';
  end;

  lblAcconti.Caption:='Acconti di riferimento';
  if drdgTipologia.ItemIndex = 8 then
    lblAcconti.Caption:='Quote qual. di riferimento';
  dedtAcconti.Enabled:=(drdgTipologia.ItemIndex in [4,5,6,7,8]) or dchkRifSaldoAnnoCorr.Checked;
  lblAcconti.Enabled:=dedtAcconti.Enabled;
  btnAcconti.Enabled:=dedtAcconti.Enabled and (DButton.State in [dsEdit,dsInsert]);

  dcmbCausale.Enabled:=drdgTipologia.ItemIndex = 8;
  dcmbCausale.Visible:=dcmbCausale.Enabled;
  if DButton.State in [dsEdit,dsInsert] then
    if not dcmbCausale.Enabled then
      A163FTipoQuoteDtM.selT765.FieldByName('CAUSALE_ASSESTAMENTO').AsString:='';
  lblCausale.Enabled:=dcmbCausale.Enabled;
  lblCausale.Visible:=lblCausale.Enabled;
  dtxtCausale.Visible:=dcmbCausale.Enabled and (Trim(dcmbCausale.Text) <> '');

  dedtGiorniMese.Enabled:=drdgTipologia.ItemIndex in [0,1,2,3,4,5,8];
  lblGiorniMese.Enabled:=dedtGiorniMese.Enabled;
  if not dedtGiorniMese.Enabled then
    A163FTipoQuoteDtM.selT765.FieldByName('GIORNI_MESE').Value:=Null;

  lblVPQuantitativa.Enabled:=drdgTipologia.ItemIndex = 8;
  dedtVPQuantitativa.Enabled:=drdgTipologia.ItemIndex = 8;
  lblVPIntera.Enabled:=not (drdgTipologia.ItemIndex in [8,9]);
  dedtVPIntera.Enabled:=not (drdgTipologia.ItemIndex in [8,9]);
  lblVPProporzionata.Enabled:=not (drdgTipologia.ItemIndex in [8,9]);
  dedtVPProporzionata.Enabled:=not (drdgTipologia.ItemIndex in [8,9]);
  lblVPNetta.Enabled:=drdgTipologia.ItemIndex <> 8;
  dedtVPNetta.Enabled:=drdgTipologia.ItemIndex <> 8;
  lblVPNettaRisp.Enabled:=not (drdgTipologia.ItemIndex in [8,9]);
  dedtVPNettaRisp.Enabled:=not (drdgTipologia.ItemIndex in [8,9]);
  lblVPRisparmio.Enabled:=not (drdgTipologia.ItemIndex in [8,9]);
  dedtVPRisparmio.Enabled:=not (drdgTipologia.ItemIndex in [8,9]);
  lblVPNoRisp.Enabled:=not (drdgTipologia.ItemIndex in [8,9]);
  dedtVPNoRisp.Enabled:=not (drdgTipologia.ItemIndex in [8,9]);

  if DButton.State in [dsEdit,dsInsert] then
  begin
    if not dedtAcconti.Enabled then
      A163FTipoQuoteDtM.selT765.FieldByName('ACCONTI').AsString:='';
    if not dedtVPQuantitativa.Enabled then
      A163FTipoQuoteDtM.selT765.FieldByName('VP_QUANTITATIVA').AsString:='';
    if not dedtVPIntera.Enabled then
      A163FTipoQuoteDtM.selT765.FieldByName('VP_INTERA').AsString:='';
    if not dedtVPProporzionata.Enabled then
      A163FTipoQuoteDtM.selT765.FieldByName('VP_PROPORZIONATA').AsString:='';
    if not dedtVPNetta.Enabled then
      A163FTipoQuoteDtM.selT765.FieldByName('VP_NETTA').AsString:='';
    if not dedtVPNettaRisp.Enabled then
      A163FTipoQuoteDtM.selT765.FieldByName('VP_NETTARISP').AsString:='';
    if not dedtVPRisparmio.Enabled then
      A163FTipoQuoteDtM.selT765.FieldByName('VP_RISPARMIO').AsString:='';
    if not dedtVPNoRisp.Enabled then
      A163FTipoQuoteDtM.selT765.FieldByName('VP_NORISPARMIO').AsString:='';
  end;
end;

end.
