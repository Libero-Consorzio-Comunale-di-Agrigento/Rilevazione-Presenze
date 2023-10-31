unit A157UCapitoliTrasferteDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R004UGestStoricoDTM, Data.DB, OracleData, A157UCapitoliTrasferteMW;


type
  TA157FCapitoliTrasferteDM = class(TR004FGestStoricoDtM)
    selM030: TOracleDataSet;
    selM030CODICE: TStringField;
    selM030DESCRIZIONE: TStringField;
    selM030DECORRENZA: TDateTimeField;
    selM030DECORRENZA_FINE: TDateTimeField;
    selM030FILTRO_ANAGRAFE: TStringField;
    selM030TIPO_MISSIONE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    A157MW:TA157FCapitoliTrasferteMW;
  end;

var
  A157FCapitoliTrasferteDM: TA157FCapitoliTrasferteDM;

implementation

{$R *.dfm}

uses A157UCapitoliTrasferte;

procedure TA157FCapitoliTrasferteDM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InterfacciaR004:=A157FCapitoliTrasferte.InterfacciaR004;
  InterfacciaR004.AllineaSoloDecorrenzeIntersecanti:=True;
  InizializzaDataSet(selM030,[evBeforeEdit,
                              evBeforeInsert,
                              evBeforePost,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost,
                              evOnNewRecord,
                              evOnTranslateMessage]);
  A157MW:=TA157FCapitoliTrasferteMW.Create(nil);
  selM030.Open;
end;

procedure TA157FCapitoliTrasferteDM.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(A157MW);
end;

end.
