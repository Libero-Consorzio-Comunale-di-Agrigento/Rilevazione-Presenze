unit A059UContSquadre;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, ExtCtrls, DBCtrls, QRPDFFilt, Variants, ComCtrls,
  A000UCostanti, A000USessione, A000UInterfaccia, A000UMessaggi,
  A003UDataLavoroBis, C001StampaLib, C180FunzioniGenerali;

type
  TA059FContSquadre = class(TForm)
    lblSquadraDa: TLabel;
    lblSquadraA: TLabel;
    btnStampa: TBitBtn;
    btnStampante: TBitBtn;
    btnChiudi: TBitBtn;
    rgpModalita: TRadioGroup;
    cmbCodSquadraDa: TDBLookupComboBox;
    cmbCodSquadraA: TDBLookupComboBox;
    dlblDescSquadraDa: TDBText;
    dlblDescSquadraA: TDBText;
    btnAnteprima: TBitBtn;
    PrinterSetupDialog1: TPrinterSetupDialog;
    rgpTipo: TRadioGroup;
    edtDataDa: TMaskEdit;
    btnDataDa: TBitBtn;
    lblDataDa: TLabel;
    lblDataA: TLabel;
    edtDataA: TMaskEdit;
    btnDataA: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtDataDaExit(Sender: TObject);
    procedure edtDataAExit(Sender: TObject);
    procedure btnDataDaClick(Sender: TObject);
    procedure btnDataAClick(Sender: TObject);
    procedure cmbCodSquadraDaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cmbCodSquadraDaCloseUp(Sender: TObject);
    procedure rgpModalitaClick(Sender: TObject);
    procedure btnStampanteClick(Sender: TObject);
    procedure btnStampaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    Operativa:boolean;
  public
    TipoModulo, DocumentoPDF: String;
    DataInizio,DataFine:TDateTime;
  end;

var
  A059FContSquadre: TA059FContSquadre;

procedure OpenA059ContSquadre;

implementation

uses A059UContSquadreDtM1, A059UContSquadraMW, A059UStampa;

{$R *.DFM}

procedure OpenA059ContSquadre;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA059ContSquadre') of
    'N':
        begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A059FContSquadre:=TA059FContSquadre.Create(nil);
  with A059FContSquadre do
    try
      A059FContSquadreDtM1:=TA059FContSquadreDtM1.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A059FContSquadreDtM1.Free;
      Free;
    end;
end;

procedure TA059FContSquadre.FormCreate(Sender: TObject);
begin
  TipoModulo:='CS';
  A059FStampa:=TA059FStampa.Create(nil);
  rgpModalitaClick(nil);
end;

procedure TA059FContSquadre.FormShow(Sender: TObject);
begin
  rgpTipo.Visible:=Parametri.CampiRiferimento.C11_PianifOrariProg = 'S';
  cmbCodSquadraDaCloseUp(cmbCodSquadraDa);
  cmbCodSquadraDaCloseUp(cmbCodSquadraA);
end;

procedure TA059FContSquadre.edtDataDaExit(Sender: TObject);
begin
  try
    DataInizio:=StrToDate(edtDataDa.Text);
  except
  end;
  A059FContSquadreDtM1.A059MW.RefreshDataSet(DataInizio,DataFine);
  cmbCodSquadraDaCloseUp(cmbCodSquadraDa);
end;

procedure TA059FContSquadre.edtDataAExit(Sender: TObject);
begin
  try
    DataFine:=StrToDate(edtDataA.Text);
  except
  end;
  A059FContSquadreDtM1.A059MW.RefreshDataSet(DataInizio,DataFine);
  cmbCodSquadraDaCloseUp(cmbCodSquadraA);
end;

procedure TA059FContSquadre.btnDataDaClick(Sender: TObject);
begin
  try
    DataInizio:=DataOut(StrToDate(edtDataDa.Text),'Da data','G');
  except
    DataInizio:=DataOut(DataInizio,'Da data','G');
  end;
  edtDataDa.Text:=DateToStr(DataInizio);
  edtDataDaExit(nil);
end;

procedure TA059FContSquadre.btnDataAClick(Sender: TObject);
begin
  try
    DataFine:=DataOut(StrToDate(edtDataA.Text),'A data','G');
  except
    DataFine:=DataOut(DataFine,'A data','G');
  end;
  edtDataA.Text:=DateToStr(DataFine);
  edtDataAExit(nil);
end;

procedure TA059FContSquadre.cmbCodSquadraDaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      (Sender as TDBLookupComboBox).Field.Clear;
  end;
  cmbCodSquadraDaCloseUp(Sender);
end;

procedure TA059FContSquadre.cmbCodSquadraDaCloseUp(Sender: TObject);
begin
  cmbCodSquadraDa.KeyValue:=A059FContSquadreDtM1.A059MW.selT603a.FieldByName('Codice').AsString;
  cmbCodSquadraA.KeyValue:=A059FContSquadreDtM1.A059MW.selT603b.FieldByName('Codice').AsString;
  if Sender = cmbCodSquadraDa then
    dlblDescSquadraDa.Visible:=cmbCodSquadraDa.KeyValue <> Null
  else
    dlblDescSquadraA.Visible:=cmbCodSquadraA.KeyValue <> Null;
end;

procedure TA059FContSquadre.rgpModalitaClick(Sender: TObject);
begin
  Operativa:=rgpModalita.ItemIndex = 0;
  //Applico le abilitazioni previste nel tab Permessi della form <A008> Profilo utenti
  if not SolaLettura then
  begin
    //PIANIFICAZIONE PROGRESSIVA
    if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
      rgpTipo.Enabled:=not Operativa
    else
      rgpTipo.Enabled:=False;
  end;
end;

procedure TA059FContSquadre.btnStampanteClick(Sender: TObject);
begin
  if PrinterSetupDialog1.Execute then
    C001SettaQuickReport(A059FStampa.QRep);
end;

procedure TA059FContSquadre.btnStampaClick(Sender: TObject);
begin
  if (Trim(cmbCodSquadraDa.KeyValue) = '') or (Trim(cmbCodSquadraA.KeyValue) = '') then
    raise Exception.Create(A000MSG_A059_ERR_SQUADRA_MANCANTE);
  if cmbCodSquadraA.KeyValue < cmbCodSquadraDa.KeyValue then
    raise Exception.Create(A000MSG_A059_ERR_SQUADRE);
  with A059FStampa.QRTitolo do
  begin
    A059FStampa.QRTitolo.Caption:='Riepilogo pianificazione ';
    if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
      Caption:=Caption + 'progressiva ';
    if rgpModalita.ItemIndex = 0 then
      Caption:=Caption + 'operativa'
    else
    begin
      if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
      begin
        if rgpTipo.ItemIndex = 0 then
          Caption:=Caption + 'iniziale '
        else
          Caption:=Caption + 'corrente '
      end;
      Caption:=Caption + 'non operativa';
    end;
    Caption:=Caption + ' squadre turnisti';
  end;
  A059FStampa.QRep.PrinterSettings.UseStandardPrinter:=(TipoModulo = 'COM') and Parametri.UseStandardPrinter;
  A059FStampa.QRRange.Caption:=Format('dalla squadra %s alla squadra %s',[cmbCodSquadraDa.KeyValue,cmbCodSquadraA.KeyValue]);
  A059FStampa.QRData.Caption:=Format('dal %s al %s',[FormatDateTime('dd/mm/yyyy',DataInizio),FormatDateTime('dd/mm/yyyy',DataFine)]);
  A059FStampa.REGiorni.Lines.Clear;
  A059FStampa.REGiorni.Lines.Add(R180ElencoGiorni(DataInizio,DataFine,'dd '));
  A059FStampa.REMesi.Lines.Clear;
  A059FStampa.REMesi.Lines.Add(R180ElencoMesi(DataInizio,DataFine,'dd '));
  //Dimensiono i QRRichText
  A059FStampa.QRGiorni.Width:=A059FStampa.ColumnHeaderBand1.Width - A059FStampa.QRGiorni.Left;
  A059FStampa.QRMesi.Width:=A059FStampa.ColumnHeaderBand1.Width - A059FStampa.QRMesi.Left;
  A059FStampa.QRTurno1.Width:=A059FStampa.QRSubDetail1.Width - A059FStampa.QRTurno1.Left;
  A059FStampa.QRTurno2.Width:=A059FStampa.QRSubDetail1.Width - A059FStampa.QRTurno2.Left;
  A059FStampa.QRTurno3.Width:=A059FStampa.QRSubDetail1.Width - A059FStampa.QRTurno3.Left;
  A059FStampa.QRTurno4.Width:=A059FStampa.QRSubDetail1.Width - A059FStampa.QRTurno4.Left;
  A059FStampa.QRSquadra1.Width:=A059FStampa.QRBand1.Width - A059FStampa.QRSquadra1.Left;
  A059FStampa.QRSquadra2.Width:=A059FStampa.QRBand1.Width - A059FStampa.QRSquadra2.Left;
  A059FStampa.QRSquadra3.Width:=A059FStampa.QRBand1.Width - A059FStampa.QRSquadra3.Left;
  A059FStampa.QRSquadra4.Width:=A059FStampa.QRBand1.Width - A059FStampa.QRSquadra4.Left;
  with A059FContSquadreDtM1.selT603 do
  begin
    Close;
    SetVariable('Codice1',cmbCodSquadraDa.KeyValue);
    SetVariable('Codice2',cmbCodSquadraA.KeyValue);
    SetVariable('DataDa',DataInizio);
    SetVariable('DataA',DataFine);
    SetVariable('Progressivo',-1); //Non individuale
    SetVariable('Cod_Orario','*'); //Tutti gli orari
    SetVariable('Cod_Condizione','00001'); //Numero teste
    SetVariable('Data',A059FContSquadre.DataInizio);
    SetVariable('Cod_Giorno','*'); //Qualsiasi giorno
    Open;
  end;
  if (TipoModulo = 'COM') and (Trim(DocumentoPDF) <> '') and (Trim(DocumentoPDF) <> '<VUOTO>') then
  begin
    A059FStampa.QRep.ShowProgress:=False;
    A059FStampa.QRep.ExportToFilter(TQRPDFDocumentFilter.Create(DocumentoPDF));
  end
  else if Sender = btnAnteprima then
    A059FStampa.QRep.PreView
  else
    A059FStampa.QRep.Print;
end;

procedure TA059FContSquadre.FormDestroy(Sender: TObject);
begin
  FreeAndNil(A059FStampa);
end;

end.
