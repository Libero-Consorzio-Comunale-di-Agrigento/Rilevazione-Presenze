unit WA207UProfiliStampeRepDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData, A040UPianifRepMW;

type
  TWA207FProfiliStampeRepDM = class(TWR302FGestTabellaDM)
    selTabellaCODICE: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaTIPO: TStringField;
    selTabellaORIENTAMENTO: TStringField;
    selTabellaFONTNAME: TStringField;
    selTabellaFONTSIZE: TIntegerField;
    selTabellaTITOLO: TStringField;
    selTabellaTITOLO_SIZE: TIntegerField;
    selTabellaTITOLO_BOLD: TStringField;
    selTabellaTITOLO_UNDERLINE: TStringField;
    selTabellaCAMPO_RAGGRUPPAMENTO: TStringField;
    selTabellaSALTO_PAGINA: TStringField;
    selTabellaSELEZIONE: TStringField;
    selTabellaTURNI: TStringField;
    selTabellaCAMPO_NOMINATIVO: TStringField;
    selTabellaNOME_COMPLETO: TStringField;
    selTabellaCAMPO_DETTAGLIO: TStringField;
    selTabellaDIP_NP: TStringField;
    selTabellaLEGENDA: TStringField;
    selTabellaDETT_CODICE: TStringField;
    selTabellaDETT_SIGLA: TStringField;
    selTabellaDETT_PRIORITA: TStringField;
    selTabellaDETT_ORARIO: TStringField;
    selTabellaDETT_ORARIO_RIGA: TStringField;
    selTabellaDETT_DATI_AGG: TStringField;
    selTabellaDETT_DATI_AGG_RIGA: TStringField;
    selTabellaDETT_DATO_LIBERO: TStringField;
    selTabellaDETT_ASSENZA: TStringField;
    selTabellaDETT_SIGLA_ASSENZA: TStringField;
    selTabellaFORMATO: TStringField;
    selTabellaDETTAGLIO: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure dsrTabellaStateChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    A040MW: TA040FPianifRepMW;
  end;

implementation

uses WA207UProfiliStampeRep, WA207UProfiliStampeRepDettFM;

{$R *.dfm}

procedure TWA207FProfiliStampeRepDM.dsrTabellaStateChange(Sender: TObject);
begin
  inherited;
  if Assigned(TWA207FProfiliStampeRepDettFM(TWA207FProfiliStampeRep(Self.Owner).WDettaglioFM)) then
    TWA207FProfiliStampeRepDettFM(TWA207FProfiliStampeRep(Self.Owner).WDettaglioFM).Abilitazioni;
end;

procedure TWA207FProfiliStampeRepDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  inherited;
  A040MW:=TA040FPianifRepMW.Create(Self);
end;

end.
