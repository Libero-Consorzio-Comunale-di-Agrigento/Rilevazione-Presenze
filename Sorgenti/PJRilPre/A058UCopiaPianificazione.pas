unit A058UCopiaPianificazione;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, StdCtrls, Buttons, DB, DBCtrls, C700USelezioneAnagrafe,
  DBClient, A058UPianifTurniDtM1, InputPeriodo, Vcl.Samples.Spin;

type
  TA058FCopiaPianificazione = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    btnOK: TBitBtn;
    BitBtn2: TBitBtn;
    DBLookupComboBox1: TDBLookupComboBox;
    dsrC700: TDataSource;
    DBLookupComboBox2: TDBLookupComboBox;
    dsrAnagrafiche: TDataSource;
    cdsAnagrafiche: TClientDataSet;
    cdsAnagraficheProgressivo1: TIntegerField;
    cdsAnagraficheProgressivo2: TIntegerField;
    cdsAnagraficheNominativo1: TStringField;
    cdsAnagraficheNominativo2: TStringField;
    DBText1: TDBText;
    DBText2: TDBText;
    chkRendiDefinitive: TCheckBox;
    frmInputPeriodo: TfrmInputPeriodo;
    sedtOffsetCopia: TSpinEdit;
    lblOffsetCopia: TLabel;
    lblInizio2: TLabel;
    edtInizio2: TMaskEdit;
    lblFine2: TLabel;
    edtFine2: TMaskEdit;
    procedure FormCreate(Sender: TObject);
    procedure cdsAnagraficheCalcFields(DataSet: TDataSet);
    procedure frmInputPeriodoedtInizioExit(Sender: TObject);
    procedure frmInputPeriodoedtFineExit(Sender: TObject);
    procedure frmInputPeriodobtnDataInizioClick(Sender: TObject);
    procedure frmInputPeriodobtnDataFineClick(Sender: TObject);
    procedure frmInputPeriodobtnIndietroClick(Sender: TObject);
    procedure frmInputPeriodobtnAvantiClick(Sender: TObject);
    procedure sedtOffsetCopiaChange(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure chkRendiDefinitiveClick(Sender: TObject);
  private
    { Private declarations }
    function _GetDataI: TDateTime;
    procedure _PutDataI(const Value: TDateTime);
    function _GetDataF: TDateTime;
    procedure _PutDataF(const Value: TDateTime);
  public
    { Public declarations }
    property DataI:TDateTime read _GetDataI write _PutDataI;
    property DataF:TDateTime read _GetDataF write _PutDataF;
  end;

var
  A058FCopiaPianificazione: TA058FCopiaPianificazione;

implementation

{$R *.dfm}

procedure TA058FCopiaPianificazione.FormCreate(Sender: TObject);
begin
  cdsAnagrafiche.CreateDataSet;
  dsrC700.DataSet:=C700SelAnagrafe;
end;

procedure TA058FCopiaPianificazione.cdsAnagraficheCalcFields(DataSet: TDataSet);
begin
  cdsAnagrafiche.FieldByName('Nominativo1').AsString:=
    VarToStr(C700SelAnagrafe.Lookup('PROGRESSIVO',cdsAnagrafiche.FieldByName('Progressivo1').AsInteger,'COGNOME')) + ' ' +
    VarToStr(C700SelAnagrafe.Lookup('PROGRESSIVO',cdsAnagrafiche.FieldByName('Progressivo1').AsInteger,'NOME'));
  cdsAnagrafiche.FieldByName('Nominativo2').AsString:=
    VarToStr(C700SelAnagrafe.Lookup('PROGRESSIVO',cdsAnagrafiche.FieldByName('Progressivo2').AsInteger,'COGNOME')) + ' ' +
    VarToStr(C700SelAnagrafe.Lookup('PROGRESSIVO',cdsAnagrafiche.FieldByName('Progressivo2').AsInteger,'NOME'));
end;

procedure TA058FCopiaPianificazione.chkRendiDefinitiveClick(Sender: TObject);
begin
  sedtOffsetCopia.Enabled:=not chkRendiDefinitive.Checked;
  lblOffsetCopia.Enabled:=sedtOffsetCopia.Enabled;
  if not sedtOffsetCopia.Enabled then
  begin
    sedtOffsetCopia.Value:=0;
    sedtOffsetCopiaChange(nil);
  end;
end;

procedure TA058FCopiaPianificazione.frmInputPeriodoedtInizioExit(Sender: TObject);
begin
  frmInputPeriodo.edtInizioExit(Sender);
  sedtOffsetCopiaChange(nil);
end;

procedure TA058FCopiaPianificazione.frmInputPeriodoedtFineExit(Sender: TObject);
begin
  sedtOffsetCopiaChange(nil);
end;

procedure TA058FCopiaPianificazione.frmInputPeriodobtnDataInizioClick(Sender: TObject);
begin
  frmInputPeriodo.btnDataInizioClick(Sender);
  sedtOffsetCopiaChange(nil);
end;

procedure TA058FCopiaPianificazione.frmInputPeriodobtnDataFineClick(Sender: TObject);
begin
  frmInputPeriodo.btnDataFineClick(Sender);
  sedtOffsetCopiaChange(nil);
end;

procedure TA058FCopiaPianificazione.frmInputPeriodobtnIndietroClick(Sender: TObject);
begin
  frmInputPeriodo.btnIndietroClick(Sender);
  sedtOffsetCopiaChange(nil);
end;

procedure TA058FCopiaPianificazione.frmInputPeriodobtnAvantiClick(Sender: TObject);
begin
  frmInputPeriodo.btnAvantiClick(Sender);
  sedtOffsetCopiaChange(nil);
end;

procedure TA058FCopiaPianificazione.sedtOffsetCopiaChange(Sender: TObject);
begin
  if sedtOffsetCopia.Value.ToString = '' then
    sedtOffsetCopia.Value:=0;
  edtInizio2.Text:=FormatDateTime('dd/mm/yyyy',StrToDateTime(frmInputPeriodo.edtInizio.Text) + sedtOffsetCopia.Value);
  edtFine2.Text:=FormatDateTime('dd/mm/yyyy',StrToDateTime(frmInputPeriodo.edtFine.Text) + sedtOffsetCopia.Value);
end;

procedure TA058FCopiaPianificazione.btnOKClick(Sender: TObject);
begin
  try
    if DataI > DataF then
      Abort;
  except
    raise Exception.Create('Il periodo indicato non è valido!');
  end;
  if (cdsAnagrafiche.FieldByName('Progressivo1').AsInteger = cdsAnagrafiche.FieldByName('Progressivo2').AsInteger)
  and (StrToDateTime(edtInizio2.Text) <= DataF) and (StrToDateTime(edtFine2.Text) >= DataI) then
    raise Exception.Create('I periodi non possono intersecarsi sullo stesso dipendente!');
  if chkRendiDefinitive.Checked then
  begin
    if A058FPianifTurniDtM1.A058PCKT080TURNO.SeEsisteDatoT620(cdsAnagrafiche.FieldByName('Progressivo2').AsInteger,DataI) > 0 then
      raise Exception.Create(Format('E''già stata assegnata una turnazione in data %s!',[frminputperiodo.edtInizio.Text]));
    if A058FPianifTurniDtM1.A058PCKT080TURNO.SeEsisteDatoT620(cdsAnagrafiche.FieldByName('Progressivo2').AsInteger,DataF) > 0 then
      raise Exception.Create(Format('E''già stata assegnata una turnazione in data %s!',[frminputperiodo.edtFine.Text]));
  end;
  ModalResult:=mrOK;
end;

function TA058FCopiaPianificazione._GetDataI: TDateTime;
begin
  Result:=frmInputPeriodo.DataInizio;
end;

procedure TA058FCopiaPianificazione._PutDataI(const Value: TDateTime);
begin
  frmInputPeriodo.DataInizio:=Value;
end;

function TA058FCopiaPianificazione._GetDataF: TDateTime;
begin
  Result:=frmInputPeriodo.DataFine;
end;

procedure TA058FCopiaPianificazione._PutDataF(const Value: TDateTime);
begin
  frmInputPeriodo.DataFine:=Value;
end;

end.
