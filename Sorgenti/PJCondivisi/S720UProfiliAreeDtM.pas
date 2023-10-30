unit S720UProfiliAreeDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData,
  C180FunzioniGenerali, A000UCostanti, A000USessione, A000UInterfaccia, Oracle, S720UProfiliAreeMW;

type
  TS720FProfiliAreeDtM = class(TR004FGestStoricoDtM)
    selSG720: TOracleDataSet;
    selSG720DECORRENZA: TDateTimeField;
    selSG720DECORRENZA_FINE: TDateTimeField;
    selSG720DATO1: TStringField;
    selSG720DATO2: TStringField;
    selSG720DATO3: TStringField;
    selSG720COD_AREA: TStringField;
    selSG720DESC_DATO1: TStringField;
    selSG720DESC_DATO2: TStringField;
    selSG720DESC_DATO3: TStringField;
    selSG720DESCRIZIONE: TStringField;
    selSG720DATO4: TStringField;
    selSG720DESC_DATO4: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure BeforePost(DataSet: TDataSet); override;
    procedure OnNewRecord(DataSet: TDataSet); override;
  private
    { Private declarations }
  public
    S720FProfiliAreeMW: TS720FProfiliAreeMW;
  end;

var
  S720FProfiliAreeDtM: TS720FProfiliAreeDtM;

implementation

{$R *.dfm}

uses
  S720UProfiliAree;

procedure TS720FProfiliAreeDtM.BeforePost(DataSet: TDataSet); 
begin
  S720FProfiliAreeMW.BeforePost;
  inherited;
end;

procedure TS720FProfiliAreeDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InterfacciaR004:=S720FProfiliAree.InterfacciaR004;
  InterfacciaR004.OttimizzaDecorrenzaFine:=False;
  InterfacciaR004.AllineaSoloDecorrenzeIntersecanti:=True;
  InizializzaDataSet(selSG720,[evBeforeEdit,
                              evBeforeInsert,
                              evBeforePost,
                              evBeforeDelete,
                              evAfterPost,
                              evOnNewRecord,
                              evOnTranslateMessage]);

  S720FProfiliAreeMW:=TS720FProfiliAreeMW.Create(Self);
  S720FProfiliAreeMW.selArea.SetVariable('DECORRENZA',Parametri.DataLavoro);
  S720FProfiliAreeMW.selArea.Open;
  //Inserisco i campi lookup della tabella
  if A000LookupTabella(Parametri.CampiRiferimento.C21_ValutazioniLiv1,S720FProfiliAreeMW.selDato1) then
  begin
    if S720FProfiliAreeMW.selDato1.VariableIndex('DECORRENZA') >= 0 then
      S720FProfiliAreeMW.selDato1.SetVariable('DECORRENZA',Parametri.DataLavoro);
    S720FProfiliAreeMW.selDato1.Open;
    selSG720DESC_DATO1.DisplayLabel:=UpperCase(Copy(Parametri.CampiRiferimento.C21_ValutazioniLiv1,1,1)) +
                                     LowerCase(Copy(Parametri.CampiRiferimento.C21_ValutazioniLiv1,2,length(Parametri.CampiRiferimento.C21_ValutazioniLiv1)));
    S720FProfiliAree.lblDato1.Caption:=UpperCase(Copy(Parametri.CampiRiferimento.C21_ValutazioniLiv1,1,1)) +
                                       LowerCase(Copy(Parametri.CampiRiferimento.C21_ValutazioniLiv1,2,length(Parametri.CampiRiferimento.C21_ValutazioniLiv1)));
  end
  else
  begin
    //Nascondo le colonne e imposto di tipo fkData il campo CODICE per non eseguire la select di lookup
    selSG720.FieldByName('DATO1').Visible:=False;
    selSG720DESC_DATO1.Visible:=False;
    selSG720DESC_DATO1.FieldKind:=fkCalculated;
    selSG720DESC_DATO1.LookupDataSet:=nil;
    selSG720DESC_DATO1.KeyFields:='';
    selSG720DESC_DATO1.LookupResultField:='';
    S720FProfiliAree.dgrdProfiliAree.Columns[2].Visible:=False;
    S720FProfiliAree.dgrdProfiliAree.Columns[3].Visible:=False;
    S720FProfiliAree.lblDato1.Caption:='Dato 1 non definito';
    S720FProfiliAree.lblDato1.Enabled:=False;
  end;
  //////
  if A000LookupTabella(Parametri.CampiRiferimento.C21_ValutazioniLiv2,S720FProfiliAreeMW.selDato2) then
  begin
    if S720FProfiliAreeMW.selDato2.VariableIndex('DECORRENZA') >= 0 then
      S720FProfiliAreeMW.selDato2.SetVariable('DECORRENZA',Parametri.DataLavoro);
    S720FProfiliAreeMW.selDato2.Open;
    selSG720DESC_DATO2.DisplayLabel:=UpperCase(Copy(Parametri.CampiRiferimento.C21_ValutazioniLiv2,1,1)) +
                                     LowerCase(Copy(Parametri.CampiRiferimento.C21_ValutazioniLiv2,2,length(Parametri.CampiRiferimento.C21_ValutazioniLiv2)));
    S720FProfiliAree.lblDato2.Caption:=UpperCase(Copy(Parametri.CampiRiferimento.C21_ValutazioniLiv2,1,1)) +
                                       LowerCase(Copy(Parametri.CampiRiferimento.C21_ValutazioniLiv2,2,length(Parametri.CampiRiferimento.C21_ValutazioniLiv2)));
  end
  else
  begin
    //Nascondo le colonne e imposto di tipo fkData il campo CODICE per non eseguire la select di lookup
    selSG720DATO2.Visible:=False;
    selSG720DESC_DATO2.Visible:=False;
    selSG720DESC_DATO2.FieldKind:=fkCalculated;
    selSG720DESC_DATO2.LookupDataSet:=nil;
    selSG720DESC_DATO2.KeyFields:='';
    selSG720DESC_DATO2.LookupResultField:='';
    S720FProfiliAree.dgrdProfiliAree.Columns[4].Visible:=False;
    S720FProfiliAree.dgrdProfiliAree.Columns[5].Visible:=False;
    S720FProfiliAree.lblDato2.Caption:='Dato 2 non definito';
    S720FProfiliAree.lblDato2.Enabled:=False;
  end;
  //////
  if A000LookupTabella(Parametri.CampiRiferimento.C21_ValutazioniLiv3,S720FProfiliAreeMW.selDato3) then
  begin
    if S720FProfiliAreeMW.selDato3.VariableIndex('DECORRENZA') >= 0 then
      S720FProfiliAreeMW.selDato3.SetVariable('DECORRENZA',Parametri.DataLavoro);
    S720FProfiliAreeMW.selDato3.Open;
    selSG720DESC_DATO3.DisplayLabel:=UpperCase(Copy(Parametri.CampiRiferimento.C21_ValutazioniLiv3,1,1)) +
                                     LowerCase(Copy(Parametri.CampiRiferimento.C21_ValutazioniLiv3,2,length(Parametri.CampiRiferimento.C21_ValutazioniLiv3)));
    S720FProfiliAree.lblDato3.Caption:=UpperCase(Copy(Parametri.CampiRiferimento.C21_ValutazioniLiv3,1,1)) +
                                       LowerCase(Copy(Parametri.CampiRiferimento.C21_ValutazioniLiv3,2,length(Parametri.CampiRiferimento.C21_ValutazioniLiv3)));
  end
  else
  begin
    //Nascondo le colonne e imposto di tipo fkData il campo CODICE per non eseguire la select di lookup
    selSG720DATO3.Visible:=False;
    selSG720DESC_DATO3.Visible:=False;
    selSG720DESC_DATO3.FieldKind:=fkCalculated;
    selSG720DESC_DATO3.LookupDataSet:=nil;
    selSG720DESC_DATO3.KeyFields:='';
    selSG720DESC_DATO3.LookupResultField:='';
    S720FProfiliAree.dgrdProfiliAree.Columns[6].Visible:=False;
    S720FProfiliAree.dgrdProfiliAree.Columns[7].Visible:=False;
    S720FProfiliAree.lblDato3.Caption:='Dato 3 non definito';
    S720FProfiliAree.lblDato3.Enabled:=False;
  end;
  //////
  if A000LookupTabella(Parametri.CampiRiferimento.C21_ValutazioniLiv4,S720FProfiliAreeMW.selDato4) then
  begin
    if S720FProfiliAreeMW.selDato4.VariableIndex('DECORRENZA') >= 0 then
      S720FProfiliAreeMW.selDato4.SetVariable('DECORRENZA',Parametri.DataLavoro);
    S720FProfiliAreeMW.selDato4.Open;
    selSG720DESC_DATO4.DisplayLabel:=UpperCase(Copy(Parametri.CampiRiferimento.C21_ValutazioniLiv4,1,1)) +
                                     LowerCase(Copy(Parametri.CampiRiferimento.C21_ValutazioniLiv4,2,length(Parametri.CampiRiferimento.C21_ValutazioniLiv4)));
    S720FProfiliAree.lblDato4.Caption:=UpperCase(Copy(Parametri.CampiRiferimento.C21_ValutazioniLiv4,1,1)) +
                                       LowerCase(Copy(Parametri.CampiRiferimento.C21_ValutazioniLiv4,2,length(Parametri.CampiRiferimento.C21_ValutazioniLiv4)));
  end
  else
  begin
    //Nascondo le colonne e imposto di tipo fkData il campo CODICE per non eseguire la select di lookup
    selSG720DATO4.Visible:=False;
    selSG720DESC_DATO4.Visible:=False;
    selSG720DESC_DATO4.FieldKind:=fkCalculated;
    selSG720DESC_DATO4.LookupDataSet:=nil;
    selSG720DESC_DATO4.KeyFields:='';
    selSG720DESC_DATO4.LookupResultField:='';
    S720FProfiliAree.dgrdProfiliAree.Columns[8].Visible:=False;
    S720FProfiliAree.dgrdProfiliAree.Columns[9].Visible:=False;
    S720FProfiliAree.lblDato4.Caption:='Dato 4 non definito';
    S720FProfiliAree.lblDato4.Enabled:=False;
  end;
  selSG720DESC_DATO1.LookupDataSet:=S720FProfiliAreeMW.selDato1;
  selSG720DESC_DATO2.LookupDataSet:=S720FProfiliAreeMW.selDato2;
  selSG720DESC_DATO3.LookupDataSet:=S720FProfiliAreeMW.selDato3;
  selSG720DESC_DATO4.LookupDataSet:=S720FProfiliAreeMW.selDato4;
  selSG720DESCRIZIONE.LookupDataSet:=S720FProfiliAreeMW.selArea;
  selSG720.Open;
  S720FProfiliAree.DButton.DataSet:=selSG720;
  S720FProfiliAreeMW.SG720_Funzioni:=selSG720;
end;

procedure TS720FProfiliAreeDtM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  S720FProfiliAreeMW.onNewRecord;
end;

end.
