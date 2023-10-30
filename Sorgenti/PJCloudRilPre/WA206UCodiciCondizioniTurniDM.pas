unit WA206UCodiciCondizioniTurniDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData,
  A206UCondizioniTurniMW;

type
  TWA206FCodiciCondizioniTurniDM = class(TWR302FGestTabellaDM)
    selTabellaCODICE: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaGENERALE: TStringField;
    selTabellaINDIVIDUALE: TStringField;
    selTabellaSQUADRA_ABILITA: TStringField;
    selTabellaTIPOOPE_ABILITA: TStringField;
    selTabellaORARIO_ABILITA: TStringField;
    selTabellaTURNO_ABILITA: TStringField;
    selTabellaGIORNO_ABILITA: TStringField;
    selTabellaMINIMO_ABILITA: TStringField;
    selTabellaMINIMO_OBBLIGA: TStringField;
    selTabellaOTTIMALE_ABILITA: TStringField;
    selTabellaOTTIMALE_OBBLIGA: TStringField;
    selTabellaMASSIMO_ABILITA: TStringField;
    selTabellaMASSIMO_OBBLIGA: TStringField;
    selTabellaVALORE_ABILITA: TStringField;
    selTabellaVALORE_OBBLIGA: TStringField;
    selTabellaVALORE_TIPO: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    A206MW: TA206FCondizioniTurniMW;
  end;

implementation

{$R *.dfm}

procedure TWA206FCodiciCondizioniTurniDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY T605.CODICE');
  A206MW:=TA206FCondizioniTurniMW.Create(Self);
  inherited;
end;

end.
