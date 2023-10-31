unit A139UNoteServizi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DBCtrls, Buttons, DB, A139UPianifServizi,
  A000UInterfaccia;

type
  TA139FNoteServizi = class(TForm)
    pnlAzioni: TPanel;
    btnConferma: TBitBtn;
    btnAnnulla: TBitBtn;
    mmNote: TDBMemo;
    dtsT503: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure btnAnnullaClick(Sender: TObject);
    procedure btnConfermaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A139FNoteServizi: TA139FNoteServizi;

implementation

uses A139UPianifServiziDtm;

{$R *.dfm}

procedure TA139FNoteServizi.btnAnnullaClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TA139FNoteServizi.btnConfermaClick(Sender: TObject);
begin
  A139FPianifServiziDtm.selT503.Post;
  Self.Close;
end;

procedure TA139FNoteServizi.FormCreate(Sender: TObject);
begin
  with A139FPianifServiziDtm, A139FPianifServizi do
  begin
    selI070.Close;
    selI070.SetVariable('AZIENDA',Parametri.Azienda);
    selI070.SetVariable('UTENTE',Parametri.Operatore);
    selI070.Open;
    
    selT503.Close;
    selT503.SetVariable('DATA',StrToDate(edtDataa.Text));
    if selI070.FieldByName('FILTRO_ANAGRAFE').IsNull then
      selT503.SetVariable('FANAGRAFE',' ')
    else
      selT503.SetVariable('FANAGRAFE',selI070.FieldByName('FILTRO_ANAGRAFE').AsString);
    selT503.Open;
    if selT503.RecordCount > 0 then
      selT503.Edit
    else
    begin
      selT503.Insert;
      selT503.FieldByName('DATA').AsDateTime:=StrToDate(edtDataa.Text);
      if selI070.FieldByName('FILTRO_ANAGRAFE').IsNull then
        selT503.FieldByName('FILTRO_ANAGRAFE').AsString:=' '
      else
        selT503.FieldByName('FILTRO_ANAGRAFE').AsString:=selI070.FieldByName('FILTRO_ANAGRAFE').AsString;
    end;
  end;
end;

procedure TA139FNoteServizi.FormDestroy(Sender: TObject);
begin
  FreeAndNil(A139FNoteServizi);
end;

end.
