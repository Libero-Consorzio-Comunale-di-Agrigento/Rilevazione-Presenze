unit WA086UMotivazioniRichiesteDM;

interface

uses
  A086UMotivazioniRichiesteMW, A000UInterfaccia, A000UMessaggi,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  WR302UGestTabellaDM, Data.DB, OracleData, Datasnap.DBClient;

type
  TWA086FMotivazioniRichiesteDM = class(TWR302FGestTabellaDM)
    selTabellaTIPO: TStringField;
    selTabellaCODICE: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaCODICE_DEFAULT: TStringField;
    selTabellaCAUSALI: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
  public
    A086MW: TA086FMotivazioniRichiesteMW;
  end;

implementation

{$R *.dfm}

uses
  WA086UMotivazioniRichieste, WA086UMotivazioniRichiesteBrowseFM;

procedure TWA086FMotivazioniRichiesteDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY TIPO, CODICE');
  inherited;
  A086MW:=TA086FMotivazioniRichiesteMW.Create(Self);
  A086MW.selT106_Funzioni:=selTabella;
end;

procedure TWA086FMotivazioniRichiesteDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A086MW);
  inherited;
end;

procedure TWA086FMotivazioniRichiesteDM.OnNewRecord(DataSet: TDataSet);
var
  LBrowseFM: TWA086FMotivazioniRichiesteBrowseFM;
  Tipo: String;
begin
  LBrowseFM:=((Self.Owner as TWA086FMotivazioniRichieste).WBrowseFM as TWA086FMotivazioniRichiesteBrowseFM);
  Tipo:='';
  if LBrowseFM.cmbTipo.ItemIndex <> -1 then
    Tipo:=LBrowseFM.cmbTipo.Items.ValueFromIndex[LBrowseFM.cmbTipo.ItemIndex];
  if Tipo = '' then
    raise Exception.Create(A000TraduzioneStringhe(A000MSG_A086_ERR_TIPO));

  A086MW.SelT106NewRecord(Tipo);
  inherited;
end;

procedure TWA086FMotivazioniRichiesteDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  A086MW.SelT106BeforeDelete;
end;

procedure TWA086FMotivazioniRichiesteDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  // codice not null
  if (selTabella.FieldByName('CODICE').IsNull) or
     (selTabella.FieldByName('CODICE').AsString.Trim = '') then
    raise Exception.Create('Il codice non può essere nullo!');
  inherited;
  A086MW.SelT106BeforePost;
end;

end.
