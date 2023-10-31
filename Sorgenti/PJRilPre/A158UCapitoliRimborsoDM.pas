unit A158UCapitoliRimborsoDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R004UGestStoricoDTM, Data.DB, OracleData, A158UCapitoliRimborsoMW;

type
  TA158FCapitoliRimborsoDM = class(TR004FGestStoricoDtM)
    selM031: TOracleDataSet;
    selM031CAPITOLO_TRASFERTA: TStringField;
    selM031CATEG_RIMBORSO: TStringField;
    selM031DECORRENZA: TDateTimeField;
    selM031DECORRENZA_FINE: TDateTimeField;
    selM031PERCENTUALE: TFloatField;
    selM031CAPITOLO_BILANCIO: TStringField;
    selM031IMPEGNO: TStringField;
    selM031CENTRO_COSTO: TStringField;
    selM031FATTORE_PRODUTTIVO: TStringField;
    selM031dCapitolo_trasferta: TStringField;
    selM031dCateg_rimborso: TStringField;
    selM031dDescCateg_rimborso: TStringField;
    selM031IMPORTO: TFloatField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selM031CalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    procedure BeforePost(DataSet: TDataSet); override;
  public
    { Public declarations }
    A158MW:TA158FCapitoliRimborsoMW;
  end;

var
  A158FCapitoliRimborsoDM: TA158FCapitoliRimborsoDM;

implementation

uses
  A158UCapitoliRimborso;

{$R *.dfm}

procedure TA158FCapitoliRimborsoDM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InterfacciaR004:=A158FCapitoliRimborso.InterfacciaR004;
  InizializzaDataSet(selM031,[//evBeforeEdit,
                              evBeforeInsert,
                              evBeforePost,
                              evBeforeDelete,
                              EvAfterDelete,
                              evAfterPost,
                              evOnNewRecord,
                              evOnTranslateMessage]);
  InterfacciaR004.AllineaSoloDecorrenzeIntersecanti:=True;
  A158MW:=TA158FCapitoliRimborsoMW.Create(nil);
  A158MW.selM031:=selM031;
  A158MW.selM030.Open;
  A158MW.selM022.Open;
  selM031.Open;
end;

procedure TA158FCapitoliRimborsoDM.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(A158MW);
end;

procedure TA158FCapitoliRimborsoDM.selM031CalcFields(DataSet: TDataSet);
begin
  inherited;
  A158MW.OnCalcFields;
end;

procedure TA158FCapitoliRimborsoDM.BeforePost(DataSet: TDataSet);
begin
  inherited;
  A158MW.OnBeforePost;
end;


end.
