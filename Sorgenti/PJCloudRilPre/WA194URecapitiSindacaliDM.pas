unit WA194URecapitiSindacaliDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData,
  A121URecapitiSindacaliMW;

type
  TWA194FRecapitiSindacaliDM = class(TWR302FGestTabellaDM)
    selTabellaCODICE: TStringField;
    selTabellaDECORRENZA: TDateTimeField;
    selTabellaTIPO_RECAPITO: TStringField;
    selTabellaPROG_RECAPITO: TIntegerField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaINDIRIZZO: TStringField;
    selTabellaCitta: TStringField;
    selTabellaProvincia: TStringField;
    selTabellaCOMUNE: TStringField;
    selTabellaCAP: TStringField;
    selTabellaTELEFONO: TStringField;
    selTabellaFAX: TStringField;
    selTabellaCOGNOME: TStringField;
    selTabellaNOME: TStringField;
    selTabellaTELEFONO_CASA: TStringField;
    selTabellaTELEFONO_UFFICIO: TStringField;
    selTabellaCELLULARE: TStringField;
    selTabellaEMAIL: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure selTabellaCOMUNEChange(Sender: TField);
    procedure BeforePost(DataSet: TDataSet);override;
    procedure OnNewRecord(DataSet: TDataSet);override;
  private
    { Private declarations }
  public
    Sindacato: String;
    A121MW: TA121FRecapitiSindacaliMW;
  end;

implementation

{$R *.dfm}

procedure TWA194FRecapitiSindacaliDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  SelTabella.SetVariable('ORDERBY','ORDER BY CODICE, TIPO_RECAPITO, PROG_RECAPITO, DECORRENZA');
  SelTabella.SetVariable('CODICE',Sindacato);
  NonAprireSelTabella:=True;
  inherited;
  A121MW:=TA121FRecapitiSindacaliMW.Create(Self);
  SelTabella.FieldByName('CITTA').LookupDataSet:=A121MW.selT480;
  SelTabella.FieldByName('PROVINCIA').LookupDataSet:=A121MW.selT480;
  SelTabella.Open;
end;

procedure TWA194FRecapitiSindacaliDM.BeforePost(DataSet: TDataSet);
begin
  inherited;
  A121MW.SelT241BeforePost;
end;

procedure TWA194FRecapitiSindacaliDM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  selTabella.FieldByName('CODICE').AsString:=Sindacato;
  selTabella.FieldByName('PROG_RECAPITO').AsInteger:=0;
end;

procedure TWA194FRecapitiSindacaliDM.selTabellaCOMUNEChange(Sender: TField);
begin
  inherited;
  try
    SelTabella.FieldByName('CAP').AsString:=VarToStr(A121MW.selT480.Lookup('CODICE',SelTabella.FieldByName('COMUNE').AsString,'CAP'));
  except
  end;
end;

end.
