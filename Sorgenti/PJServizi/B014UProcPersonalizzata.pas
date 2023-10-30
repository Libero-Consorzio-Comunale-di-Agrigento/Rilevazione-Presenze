unit B014UProcPersonalizzata;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, ExtCtrls, A000UInterfaccia, C180FunzioniGenerali;

type
  TB014FProcPersonalizzata = class(TForm)
    Panel1: TPanel;
    dcmbAzienda: TDBLookupComboBox;
    Button1: TButton;
    Memo1: TMemo;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  B014FProcPersonalizzata: TB014FProcPersonalizzata;

implementation

{$R *.dfm}

uses B014UMonitorIntegrazioneDtM;

procedure TB014FProcPersonalizzata.Button1Click(Sender: TObject);
var Carica:Boolean;
begin
  if dcmbAzienda.Text = '' then
    raise Exception.Create('Specificare l''Azienda!');
  with B014FMonitorIntegrazioneDtM do
  begin
    SessioneAzienda.Logoff;
    SessioneAzienda.LogonDatabase:=SessioneOracle.LogonDatabase;
    SessioneAzienda.LogonUserName:=VarToStr(selI090.Lookup('AZIENDA',dcmbAzienda.Text,'UTENTE'));
    SessioneAzienda.LogonPassword:=R180Decripta(VarToStr(selI090.Lookup('AZIENDA',dcmbAzienda.Text,'PAROLACHIAVE')),21041974);
    SessioneAzienda.Logon;
    selSourceB014Personalizzata.Close;
    selSourceB014Personalizzata.Open;
    Memo1.Lines.Clear;
    Carica:=False;
    while not selSourceB014Personalizzata.Eof do
    begin
      if (not Carica) and (Pos('B014PERSONALIZZATA',UpperCase(selSourceB014Personalizzata.FieldByName('TEXT').AsString)) > 0) then
        Carica:=True;
      if Carica then
        Memo1.Lines.Add(TrimRight(selSourceB014Personalizzata.FieldByName('TEXT').AsString));
      selSourceB014Personalizzata.Next;
    end;
    selSourceB014Personalizzata.Close;
    SessioneAzienda.Logoff;
  end;
end;

end.
