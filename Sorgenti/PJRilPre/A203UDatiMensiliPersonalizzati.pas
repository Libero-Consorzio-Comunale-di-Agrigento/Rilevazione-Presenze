unit A203UDatiMensiliPersonalizzati;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R004UGestStorico, System.Actions, Vcl.ActnList, System.ImageList, Vcl.ImgList, Data.DB, Vcl.Menus, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ToolWin, Vcl.Mask,
  Vcl.DBCtrls, Vcl.Buttons,
  A000UInterfaccia, A003UDataLavoroBis,
  A203UDatiMensiliPersonalizzatiDtM, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, C600USelAnagrafe;

type
  TA203FDatiMensiliPersonalizzati = class(TR004FGestStorico)
    dgrdI011: TDBGrid;
    pnlDettaglio: TPanel;
    dedtDato: TDBEdit;
    desdDesc: TDBEdit;
    dmemoEspressione: TDBMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    dedtOrdinamento: TDBEdit;
    drgpTipo: TDBRadioGroup;
    dedtVocePaghe: TDBEdit;
    Label7: TLabel;
    lblDataEnd: TLabel;
    dedtDecorrenzaFine: TDBEdit;
    btnVocePaghe: TButton;
    lblDescVocePaghe: TLabel;
    dedtSelezioneAnagrafiche: TDBEdit;
    Label5: TLabel;
    C600frmSelAnagrafe: TC600frmSelAnagrafe;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnVocePagheClick(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure dedtVocePagheChange(Sender: TObject);
    procedure dedtVocePagheExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure C600frmSelAnagrafebtnSelezioneClick(Sender: TObject);
  private
    { Private declarations }
    A203DtM: TA203FDatiMensiliPersonalizzatiDtM;
    procedure AggiornaLblVoce;
  public
    { Public declarations }
  end;

var
  A203FDatiMensiliPersonalizzati: TA203FDatiMensiliPersonalizzati;

  procedure OpenA203DatiMensiliPersonalizzati;

implementation

uses
  C016UElencoVoci; //A203UDatiMensiliPersonalizzatiMW;}

{$R *.dfm}
procedure TA203FDatiMensiliPersonalizzati.btnVocePagheClick(Sender: TObject);
begin
  inherited;
  C016FElencoVoci:=TC016FElencoVoci.Create(nil);
  C016FElencoVoci.DecorrenzaElencoVoci:=StrToDateTime('01/01/1900');
  C016FElencoVoci.TestoFiltroSql:='and COD_VOCE_SPECIALE = ''BASE''';  //--and TIPO='AS'
  C016FElencoVoci.dgrdElencoVoci.Columns[1].Visible:=False;
  C016FElencoVoci.ShowModal;
  if C016FElencoVoci.ModalResult = mrOK then
  begin
    dedtVocePaghe.Field.AsString:=C016FElencoVoci.CodVoceElencoVoci;
    lblDescVocePaghe.Caption:=C016FElencoVoci.DescrizioneVoceElencoVoci;
  end;
  FreeAndNil(C016FElencoVoci);
end;

procedure TA203FDatiMensiliPersonalizzati.C600frmSelAnagrafebtnSelezioneClick(Sender: TObject);
var S: String;
begin
  if not (DButton.State in [dsEdit,dsInsert]) then
    exit;
  C600frmSelAnagrafe.C600DataLavoro:=Date;
  C600frmSelAnagrafe.C600FSelezioneAnagrafe.SQLCreato.Text:=dedtSelezioneAnagrafiche.Field.AsString;
  C600frmSelAnagrafe.btnSelezioneClick(Sender);
  if C600frmSelAnagrafe.C600ModalResult = mrOK then
  begin
    S:=Trim(C600frmSelAnagrafe.C600FSelezioneAnagrafe.SQLCreato.Text);
    if Pos('ORDER BY',UpperCase(S)) > 0 then
      S:=Copy(S,1,Pos('ORDER BY',UpperCase(S)) - 1);
    S:=StringReplace(S,#13#10,' ',[rfReplaceAll]);
    dedtSelezioneAnagrafiche.Field.AsString:=S;
  end;
end;

procedure TA203FDatiMensiliPersonalizzati.DButtonStateChange(Sender: TObject);
begin
  inherited;
  dgrdI011.Enabled:=not (DButton.State in [dsInsert,dsEdit]);
  btnVocePaghe.Enabled:=(DButton.State in [dsInsert,dsEdit]) and (A203DtM.A203MW.selP200.RecordCount > 0);
  C600frmSelAnagrafe.Enabled:=DButton.State in [dsInsert,dsEdit];
end;

procedure TA203FDatiMensiliPersonalizzati.dedtVocePagheChange(Sender: TObject);
begin
  inherited;
  lblDescVocePaghe.Caption:='';
end;

procedure TA203FDatiMensiliPersonalizzati.dedtVocePagheExit(Sender: TObject);
begin
  inherited;
  A203DtM.selI011AfterScroll(nil);
end;

procedure TA203FDatiMensiliPersonalizzati.AggiornaLblVoce;
begin
  lblDescVocePaghe.Caption:=A203DtM.A203MW.strDescVocePaghe;
end;

procedure TA203FDatiMensiliPersonalizzati.FormCreate(Sender: TObject);
begin
  inherited;
  {lblDescVocePaghe.Caption:='';
  A203DtM:=TA203FDatiMensiliPersonalizzatiDtM.Create(nil);
  DButton.DataSet:=A203DtM.selI011;
  A203DtM.A203MW.NotificaAfterScroll:=AggiornaLblVoce;}
end;

procedure TA203FDatiMensiliPersonalizzati.FormDestroy(Sender: TObject);
begin
  inherited;
  //SessioneOracle.Commit;
  A203DtM.Free;
  C600frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA203FDatiMensiliPersonalizzati.FormShow(Sender: TObject);
begin
  inherited;
  lblDescVocePaghe.Caption:='';
  A203DtM:=TA203FDatiMensiliPersonalizzatiDtM.Create(nil);
  DButton.DataSet:=A203DtM.selI011;
  A203DtM.A203MW.NotificaAfterScroll:=AggiornaLblVoce;
  C600frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,nil,0,False);
  C600frmSelAnagrafe.C600FSelezioneAnagrafe.OpenC600SelAnagrafe:=False;
end;

procedure OpenA203DatiMensiliPersonalizzati;
begin
  A203FDatiMensiliPersonalizzati:=TA203FDatiMensiliPersonalizzati.Create(nil);
  try
    A203FDatiMensiliPersonalizzati.ShowModal;
  finally
    FreeAndNil(A203FDatiMensiliPersonalizzati);
  end;
end;

end.
