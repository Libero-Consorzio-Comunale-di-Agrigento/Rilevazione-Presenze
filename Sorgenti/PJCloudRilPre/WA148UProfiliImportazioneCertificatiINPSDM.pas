unit WA148UProfiliImportazioneCertificatiINPSDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData,
  A148UProfiliImportazioneCertificatiINPSMW;

type
  TWA148FProfiliImportazioneCertificatiINPSDM = class(TWR302FGestTabellaDM)
    selTabellaCODICE: TStringField;
    selTabellaFILTRO: TStringField;
    selTabelladCProvvisoria: TStringField;
    selTabelladCInserimento: TStringField;
    selTabelladCRicovero: TStringField;
    selTabelladCPostRicovero: TStringField;
    selTabelladCSalvaVita: TStringField;
    selTabelladCServizio: TStringField;
    selTabellaCAUS_PROVVISORIA: TStringField;
    selTabellaCAUS_INSERIMENTO: TStringField;
    selTabellaCAUS_RICOVERO: TStringField;
    selTabellaCAUS_POSTRICOVERO: TStringField;
    selTabellaCAUS_SALVAVITA: TStringField;
    selTabellaCAUS_SERVIZIO: TStringField;
    selTabellaPOSTRICOVERO_AUTO: TStringField;
    selTabellaFLAG_IGNORA_NUOVO_PERIODO: TStringField;
    selTabellaCAUS_INVALIDITA: TStringField;
    selTabelladCInvalidita: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet);Override;
  private
    { Private declarations }
  public
    A148MW: TA148FProfiliImportazioneCertificatiINPSMW;
  end;

implementation

{$R *.dfm}

procedure TWA148FProfiliImportazioneCertificatiINPSDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY',' order by decode(T269.FILTRO,null,1,0), T269.CODICE');
  NonAprireSelTabella:=True;
  A148MW:=TA148FProfiliImportazioneCertificatiINPSMW.Create(Self);
  with SelTabella.FieldByName('dCInserimento') do
  begin
    KeyFields:='CAUS_INSERIMENTO';
    LookupDataSet:=A148MW.selT265;
    LookupKeyFields:='CODICE';
    LookupResultField:='DESCRIZIONE';
  end;
  with SelTabella.FieldByName('dCProvvisoria') do
  begin
    KeyFields:='CAUS_PROVVISORIA';
    LookupDataSet:=A148MW.selT265_All;
    LookupKeyFields:='CODICE';
    LookupResultField:='DESCRIZIONE';
  end;
  with SelTabella.FieldByName('dCRicovero') do
  begin
    KeyFields:='CAUS_RICOVERO';
    LookupDataSet:=A148MW.selT265_All;
    LookupKeyFields:='CODICE';
    LookupResultField:='DESCRIZIONE';
  end;
  with SelTabella.FieldByName('dCPostRicovero') do
  begin
    KeyFields:='CAUS_POSTRICOVERO';
    LookupDataSet:=A148MW.selT265_All;
    LookupKeyFields:='CODICE';
    LookupResultField:='DESCRIZIONE';
  end;
  with SelTabella.FieldByName('dCSalvaVita') do
  begin
    KeyFields:='CAUS_SALVAVITA';
    LookupDataSet:=A148MW.selT265_All;
    LookupKeyFields:='CODICE';
    LookupResultField:='DESCRIZIONE';
  end;
  with SelTabella.FieldByName('dCServizio') do
  begin
    KeyFields:='CAUS_SERVIZIO';
    LookupDataSet:=A148MW.selT265_All;
    LookupKeyFields:='CODICE';
    LookupResultField:='DESCRIZIONE';
  end;
  inherited;
  SelTabella.Open;
  A148MW.selT269MW:=SelTabella;
end;

procedure TWA148FProfiliImportazioneCertificatiINPSDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  A148MW.selT290MWBeforePost;
end;

end.
