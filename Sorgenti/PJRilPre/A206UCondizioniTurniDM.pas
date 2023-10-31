unit A206UCondizioniTurniDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, Math, C700USelezioneAnagrafe,
  C180FunzioniGenerali, A000UCostanti, A000USessione, A000UInterfaccia, Oracle, A206UCondizioniTurniMW;

type
  TA206FCondizioniTurniDM = class(TR004FGestStoricoDtM)
    selT606: TOracleDataSet;
    selT606DECORRENZA: TDateTimeField;
    selT606DECORRENZA_FINE: TDateTimeField;
    selT606DESC_GIORNO: TStringField;
    selT606DESC_CONDIZIONE: TStringField;
    selT606COD_SQUADRA: TStringField;
    selT606COD_TIPOOPE: TStringField;
    selT606COD_GIORNO: TStringField;
    selT606COD_ORARIO: TStringField;
    selT606SIGLA_TURNO: TStringField;
    selT606COD_CONDIZIONE: TStringField;
    selT606PRIORITA: TIntegerField;
    selT606LIVELLO_ANOMALIA: TIntegerField;
    selT606MINIMO: TIntegerField;
    selT606MASSIMO: TIntegerField;
    selT606OTTIMALE: TIntegerField;
    selT606VALORE: TStringField;
    selT606PROGRESSIVO: TFloatField;
    selT606DESC_SQUADRA: TStringField;
    selT606DESC_ORARIO: TStringField;
    selT606COGNOME: TStringField;
    selT606NOME: TStringField;
    selT606MATRICOLA: TStringField;
    selT606DESC_TIPOOPE: TStringField;
    selT606DESC_SIGLATURNO: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT606AfterScroll(DataSet: TDataSet);
    procedure selT606CalcFields(DataSet: TDataSet);
    procedure selT606FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure BeforePost(DataSet: TDataSet); override;
    procedure selT606DECORRENZAValidate(Sender: TField);
  private
    { Private declarations }
  public
    A206MW: TA206FCondizioniTurniMW;
  end;

var
  A206FCondizioniTurniDM: TA206FCondizioniTurniDM;

implementation

{$R *.dfm}

uses
  A206UCondizioniTurni;

procedure TA206FCondizioniTurniDM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InterfacciaR004:=A206FCondizioniTurni.InterfacciaR004;
  InterfacciaR004.AllineaSoloDecorrenzeIntersecanti:=True;
  InizializzaDataSet(selT606,[evBeforeEdit,
                              evBeforeInsert,
                              evBeforePost,
                              evBeforeDelete,
                              evAfterPost,
                              evOnNewRecord,
                              evOnTranslateMessage]);
  A206MW:=TA206FCondizioniTurniMW.Create(Self);
  selT606DESC_GIORNO.LookupDataSet:=A206MW.selGiorni;
  selT606DESC_CONDIZIONE.LookupDataSet:=A206MW.selT605;
  selT606.SetVariable('PROGRESSIVO',-1);
  selT606.Open;
  A206FCondizioniTurni.DButton.DataSet:=selT606;
  A206MW.selT606:=selT606;
  selT606.Filtered:=True;
end;

procedure TA206FCondizioniTurniDM.selT606AfterScroll(DataSet: TDataSet);
begin
  inherited;
  A206MW.selT606AfterScroll;
  A206FCondizioniTurni.AbilitaComponenti;
end;

procedure TA206FCondizioniTurniDM.selT606CalcFields(DataSet: TDataSet);
begin
  inherited;
  A206MW.selT606OnCalcFields;
end;

procedure TA206FCondizioniTurniDM.selT606FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
  Accept:=Accept and A206MW.selT606FilterRecord;
end;

procedure TA206FCondizioniTurniDM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  A206MW.selT606OnNewRecord(IfThen(A206MW.TipoCond = 'I',C700Progressivo,-1));
end;

procedure TA206FCondizioniTurniDM.BeforePost(DataSet: TDataSet);
begin
  A206MW.selT606BeforePost;
  inherited;
end;

procedure TA206FCondizioniTurniDM.selT606DECORRENZAValidate(Sender: TField);
begin
  inherited;
  if not InterfacciaR004.StoricizzazioneInCorso then
  begin
    A206MW.RefreshDataSet;
    A206MW.PulisciValori;
  end;
end;

end.
