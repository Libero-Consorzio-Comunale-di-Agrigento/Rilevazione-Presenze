unit WA196UTipiPagamentoDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData, A000UInterfaccia,
  A000UMessaggi,medpIWMessageDlg;

type
  TWA196FTipiPagamentoDM = class(TWR302FGestTabellaDM)
    selTabellaCODICE: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaSOMMA: TStringField;
    procedure selTabellaBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TWA196FTipiPagamentoDM.selTabellaBeforePost(DataSet: TDataSet);
begin
  inherited;
  if selTabella.FieldByName('CODICE').AsString = '' then
  begin
    Msgbox.WebMessageDlg(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_MSG_CODICE]),mtError,[mbOk],nil,'');
    Abort;
  end;

  if selTabella.FieldByName('DESCRIZIONE').AsString = '' then
  begin
    Msgbox.WebMessageDlg(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_MSG_DESCRIZIONE]),mtError,[mbOk],nil,'');
    Abort;
  end;

  if (selTabella.FieldByName('SOMMA').AsString <> 'S') and (selTabella.FieldByName('SOMMA').AsString <> 'N') then
    raise Exception.Create(A000MSG_A100_ERR_RIMBORSA);

end;

end.
