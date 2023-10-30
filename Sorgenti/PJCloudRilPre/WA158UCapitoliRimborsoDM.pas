unit WA158UCapitoliRimborsoDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData, A158UCapitoliRimborsoMW;

type
  TWA158FCapitoliRimborsoDM = class(TWR302FGestTabellaDM)
    selTabellaDECORRENZA: TDateTimeField;
    selTabellaDECORRENZA_FINE: TDateTimeField;
    selTabellaCAPITOLO_TRASFERTA: TStringField;
    selTabellaPERCENTUALE: TFloatField;
    selTabellaCAPITOLO_BILANCIO: TStringField;
    selTabellaIMPEGNO: TStringField;
    selTabellaIMPORTO: TFloatField;
    selTabellaCENTRO_COSTO: TStringField;
    selTabellaFATTORE_PRODUTTIVO: TStringField;
    selTabellaCATEG_RIMBORSO: TStringField;
    selTabelladCapitolo_trasferta: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure selTabellaCalcFields(DataSet: TDataSet);
    procedure BeforePostNoStorico(DataSet: TDataSet);
    procedure BeforeEdit(DataSet: TDataSet); override;
  private
    { Private declarations }
  public
    { Public declarations }
    A158MW:TA158FCapitoliRimborsoMW;
  end;

implementation

{$R *.dfm}

procedure TWA158FCapitoliRimborsoDM.BeforeEdit(DataSet: TDataSet);
begin
  //Annullo l'evento predefinito per consentire la modifica dei campi chiave
  exit;
end;

procedure TWA158FCapitoliRimborsoDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  A158MW.OnBeforePost;
end;

procedure TWA158FCapitoliRimborsoDM.IWUserSessionBaseCreate(Sender: TObject);
var
  dDescCateg_Rimborso:TField;
begin
  NonAprireSelTabella:=True;
  A158MW:=TA158FCapitoliRimborsoMW.Create(nil);
  //Creo campo di lookup "dCateg_rimborso" in runtime
  dDescCateg_Rimborso:=TStringField.Create(selTabella);
  dDescCateg_Rimborso.FieldName:='dDescCateg_Rimborso';
  dDescCateg_Rimborso.KeyFields:='CATEG_RIMBORSO';
  dDescCateg_Rimborso.LookupDataSet:=A158MW.selM022;
  dDescCateg_Rimborso.LookupKeyFields:='CODICE';
  dDescCateg_Rimborso.LookupResultField:='DESCRIZIONE';
  dDescCateg_Rimborso.FieldKind:=fkLookup;
  dDescCateg_Rimborso.Dataset:=selTabella;
  dDescCateg_Rimborso.Index:=selTabella.FieldByName(dDescCateg_Rimborso.KeyFields).Index + 1;
  dDescCateg_Rimborso.DisplayLabel:='Desc. categoria rimborso';
  dDescCateg_Rimborso.ReadOnly:=True;
  inherited;
  A158MW.selM031:=selTabella;
  A158MW.selM030.Open;
  selTabella.Open;
end;

procedure TWA158FCapitoliRimborsoDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(A158MW);
end;

procedure TWA158FCapitoliRimborsoDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  inherited;
  A158MW.OnCalcFields;
end;

end.
