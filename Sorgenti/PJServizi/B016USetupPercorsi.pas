unit B016USetupPercorsi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, FileCtrl;

type
  TB016FSetupPercorsi = class(TForm)
    Panel1: TPanel;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    memPercorsi: TMemo;
    btnAdd: TBitBtn;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
  private
    function GetPercorsi: String;
    procedure SetPercorsi(const Value: String);
    { Private declarations }
  public
    { Public declarations }
    property Percorsi: String read GetPercorsi write SetPercorsi;
  end;

implementation

{$R *.dfm}

procedure TB016FSetupPercorsi.btnOkClick(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TB016FSetupPercorsi.FormCreate(Sender: TObject);
begin
  memPercorsi.Lines.Delimiter:=';';
end;

function TB016FSetupPercorsi.GetPercorsi: String;
var str: string;
begin
  str:=memPercorsi.Lines.CommaText;
  str:=str.Replace('"','',[rfReplaceAll]);
  str:=str.Replace(',',';',[rfReplaceAll]);
  Result:=str;
end;

procedure TB016FSetupPercorsi.SetPercorsi(const Value: String);
begin
  memPercorsi.Lines.CommaText:=Value.Replace(';',',',[rfReplaceAll]);
end;

procedure TB016FSetupPercorsi.btnAddClick(Sender: TObject);
var FDir: string;
begin
  if SelectDirectory('Selezione cartella', ExtractFileDrive(FDir), FDir,
             [sdNewUI, sdNewFolder,
              sdShowEdit, sdShowShares, sdValidateDir]) then
  memPercorsi.Lines.Add(FDir);
end;

procedure TB016FSetupPercorsi.btnCancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

end.
