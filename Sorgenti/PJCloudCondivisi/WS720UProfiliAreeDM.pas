unit WS720UProfiliAreeDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData, S720UProfiliAreeMW,
  A000USessione, A000UInterfaccia, C180FunzioniGenerali;

type
  TWS720FProfiliAreeDM = class(TWR302FGestTabellaDM)
    selTabellaDECORRENZA: TDateTimeField;
    selTabellaDECORRENZA_FINE: TDateTimeField;
    selTabellaDATO1: TStringField;
    selTabellaDATO2: TStringField;
    selTabellaDATO3: TStringField;
    selTabellaDATO4: TStringField;
    selTabellaCOD_AREA: TStringField;
    selTabellaDESC_DATO1: TStringField;
    selTabellaDESC_DATO2: TStringField;
    selTabellaDESC_DATO3: TStringField;
    selTabellaDESC_DATO4: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure BeforePost(DataSet: TDataSet); override;
    procedure OnNewRecord(DataSet: TDataSet); override;
  private
    { Private declarations }
  public
    S720FProfiliAreeMW: TS720FProfiliAreeMW;
  end;

implementation

{$R *.dfm}
uses
WR102UGestTabella, WS720UProfiliAreeDettFM;

procedure TWS720FProfiliAreeDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','order by DATO1, DATO2, DATO3, DATO4, COD_AREA, DECORRENZA');
  S720FProfiliAreeMW:=TS720FProfiliAreeMW.Create(Self);
  S720FProfiliAreeMW.SG720_Funzioni:=selTabella;
  selTabella.FieldByName('DESC_DATO1').LookupDataSet:=S720FProfiliAreeMW.selDato1;
  selTabella.FieldByName('DESC_DATO2').LookupDataSet:=S720FProfiliAreeMW.selDato2;
  selTabella.FieldByName('DESC_DATO3').LookupDataSet:=S720FProfiliAreeMW.selDato3;
  selTabella.FieldByName('DESC_DATO4').LookupDataSet:=S720FProfiliAreeMW.selDato4;
  selTabella.FieldByName('DESCRIZIONE').LookupDataSet:=S720FProfiliAreeMW.selArea;

  InterfacciaWR102.OttimizzaDecorrenzaFine:=False;
  InterfacciaWR102.AllineaSoloDecorrenzeIntersecanti:=True;

  //IN
  if A000LookupTabella(Parametri.CampiRiferimento.C21_ValutazioniLiv1,S720FProfiliAreeMW.selDato1) then
  begin
    if S720FProfiliAreeMW.selDato1.VariableIndex('DECORRENZA') >= 0 then
      S720FProfiliAreeMW.selDato1.SetVariable('DECORRENZA',EncodeDate(3999,12,31));
    S720FProfiliAreeMW.selDato1.Open;
    seltabella.FieldByName('DESC_DATO1').DisplayLabel:=R180Capitalize(Parametri.CampiRiferimento.C21_ValutazioniLiv1);
  end
  else
  begin
    //Nascondo le colonne e imposto di tipo fkData il campo CODICE per non eseguire la select di lookup
    selTabella.FieldByName('DATO1').Visible:=False; //modificare gli altri come questo (ex: selSG720DATO1.Visible:=False;)
    selTabella.FieldByName('DESC_DATO1').Visible:=False;
    selTabella.FieldByName('DESC_DATO1').FieldKind:=fkCalculated;
    selTabella.FieldByName('DESC_DATO1').LookupDataSet:=nil;
    selTabella.FieldByName('DESC_DATO1').KeyFields:='';
    selTabella.FieldByName('DESC_DATO1').LookupResultField:='';
  end;
  //FI
  //IN
  if A000LookupTabella(Parametri.CampiRiferimento.C21_ValutazioniLiv2,S720FProfiliAreeMW.selDato2) then
  begin
    if S720FProfiliAreeMW.selDato2.VariableIndex('DECORRENZA') >= 0 then
      S720FProfiliAreeMW.selDato2.SetVariable('DECORRENZA',EncodeDate(3999,12,31));
    S720FProfiliAreeMW.selDato2.Open;
    selTabella.FieldByName('DESC_DATO2').DisplayLabel:=R180Capitalize(Parametri.CampiRiferimento.C21_ValutazioniLiv2);
    end
  else
  begin
    //Nascondo le colonne e imposto di tipo fkData il campo CODICE per non eseguire la select di lookup
    selTabella.FieldByName('DATO2').Visible:=False; //modificare gli altri come questo (ex: selSG720DATO1.Visible:=False;)
    selTabella.FieldByName('DESC_DATO2').Visible:=False;
    selTabella.FieldByName('DESC_DATO2').FieldKind:=fkCalculated;
    selTabella.FieldByName('DESC_DATO2').LookupDataSet:=nil;
    selTabella.FieldByName('DESC_DATO2').KeyFields:='';
    selTabella.FieldByName('DESC_DATO2').LookupResultField:='';
  end;
  //FI
  //IN
  if A000LookupTabella(Parametri.CampiRiferimento.C21_ValutazioniLiv3,S720FProfiliAreeMW.selDato3) then
  begin
    if S720FProfiliAreeMW.selDato3.VariableIndex('DECORRENZA') >= 0 then
      S720FProfiliAreeMW.selDato3.SetVariable('DECORRENZA',EncodeDate(3999,12,31));
    S720FProfiliAreeMW.selDato3.Open;
    selTabella.FieldByName('DESC_DATO3').DisplayLabel:=R180Capitalize(Parametri.CampiRiferimento.C21_ValutazioniLiv3);
  end
  else
  begin
    //Nascondo le colonne e imposto di tipo fkData il campo CODICE per non eseguire la select di lookup
    selTabella.FieldByName('DATO3').Visible:=False; //modificare gli altri come questo (ex: selSG720DATO3.Visible:=False;)
    selTabella.FieldByName('DESC_DATO3').Visible:=False;
    selTabella.FieldByName('DESC_DATO3').FieldKind:=fkCalculated;
    selTabella.FieldByName('DESC_DATO3').LookupDataSet:=nil;
    selTabella.FieldByName('DESC_DATO3').KeyFields:='';
    selTabella.FieldByName('DESC_DATO3').LookupResultField:='';
  end;
  //FI
  //IN
  if A000LookupTabella(Parametri.CampiRiferimento.C21_ValutazioniLiv4,S720FProfiliAreeMW.selDato4) then
  begin
    if S720FProfiliAreeMW.selDato4.VariableIndex('DECORRENZA') >= 0 then
      S720FProfiliAreeMW.selDato4.SetVariable('DECORRENZA',EncodeDate(3999,12,31));
    S720FProfiliAreeMW.selDato4.Open;
    selTabella.FieldByName('DESC_DATO4').DisplayLabel:=R180Capitalize(Parametri.CampiRiferimento.C21_ValutazioniLiv4);
  end
  else
  begin
    //Nascondo le colonne e imposto di tipo fkData il campo CODICE per non eseguire la select di lookup
    selTabella.FieldByName('DATO4').Visible:=False; //modificare gli altri come questo (ex: selSG720DATO4.Visible:=False;)
    selTabella.FieldByName('DESC_DATO4').Visible:=False;
    selTabella.FieldByName('DESC_DATO4').FieldKind:=fkCalculated;
    selTabella.FieldByName('DESC_DATO4').LookupDataSet:=nil;
    selTabella.FieldByName('DESC_DATO4').KeyFields:='';
    selTabella.FieldByName('DESC_DATO4').LookupResultField:='';
  end;
  //FI
  inherited;
end;

procedure TWS720FProfiliAreeDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(S720FProfiliAreeMW);
  inherited;
end;

procedure TWS720FProfiliAreeDM.OnNewRecord(DataSet: TDataSet);
begin
  S720FProfiliAreeMW.onNewRecord;
  inherited;
end;

procedure TWS720FProfiliAreeDM.BeforePost;
begin
  inherited;
  S720FProfiliAreeMW.BeforePost;
end;
end.
