unit WA122UIscrizioniSindacatiDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData,
  A122UIscrizioniSindacaliMW, A000UMessaggi, C180FunzioniGenerali;

type
  TWA122FIscrizioniSindacatiDM = class(TWR302FGestTabellaDM)
    selTabellaPROGRESSIVO: TIntegerField;
    selTabellaNUM_PROT_ISCR: TFloatField;
    selTabellaDATA_ISCR: TDateTimeField;
    selTabellaDATA_DEC_ISCR: TDateTimeField;
    selTabellaNUM_PROT_CESS: TFloatField;
    selTabellaDATA_CESS: TDateTimeField;
    selTabellaDATA_DEC_CES: TDateTimeField;
    selTabellaCOD_SINDACATO: TStringField;
    selTabellaDESC_SINDACATO: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure BeforeInsert(DataSet: TDataSet);override;
    procedure OnNewRecord(DataSet: TDataSet);override;
    procedure BeforePostNoStorico(DataSet: TDataSet);override;
    procedure selTabellaCalcFields(DataSet: TDataSet);
    procedure selTabellaDATA_ISCRValidate(Sender: TField);
    procedure selTabellaDATA_DEC_ISCRValidate(Sender: TField);
    procedure selTabellaDATA_CESSValidate(Sender: TField);
    procedure selTabellaDATA_DEC_CESValidate(Sender: TField);
    procedure selTabellaCOD_SINDACATOChange(Sender: TField);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
  private
    procedure AssegnaSindacati(lista :TStringList);
  public
    A122MW: TA122FIscrizioniSindacaliMW;
    LstSindacati: TStrings;
  end;

implementation

{$R *.dfm}

procedure TWA122FIscrizioniSindacatiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  NonAprireSelTabella:=True;
  selTabella.SetVariable('ORDERBY','order by cod_sindacato, data_iscr');
  inherited;
  LstSindacati:=TStringList.Create;
  A122MW:=TA122FIscrizioniSindacaliMW.Create(Self);
  A122MW.selT246:=selTabella;
  A122MW.AssegnaSindacati:=AssegnaSindacati;
  selTabella.Open;
end;

procedure TWA122FIscrizioniSindacatiDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(LstSindacati);
end;

procedure TWA122FIscrizioniSindacatiDM.AssegnaSindacati(lista: TStringList);
begin
  LstSindacati.Assign(lista);
end;

procedure TWA122FIscrizioniSindacatiDM.BeforeInsert(DataSet: TDataSet);
begin
  inherited;
  A122MW.selT246BeforeInsert;
end;

procedure TWA122FIscrizioniSindacatiDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  A122MW.SelT246BeforePostStep1;
  //Controllo sul codice sindacato
  if R180IndexOf(LstSindacati,SelTabella.FieldByName('COD_SINDACATO').AsString,10) = -1 then
    raise exception.Create(A000MSG_A122_ERR_COD_SINDACATO);
  A122MW.SelT246BeforePostStep2;
end;

procedure TWA122FIscrizioniSindacatiDM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  A122MW.SelT246OnNewRecord;
end;

procedure TWA122FIscrizioniSindacatiDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  inherited;
  A122MW.selT246CalcFields;
end;

procedure TWA122FIscrizioniSindacatiDM.selTabellaCOD_SINDACATOChange(Sender: TField);
begin
  inherited;
  A122MW.selT246COD_SINDACATOChange(Sender);
end;

procedure TWA122FIscrizioniSindacatiDM.selTabellaDATA_CESSValidate(Sender: TField);
begin
  inherited;
  A122MW.selT246DATA_CESSValidate;
end;

procedure TWA122FIscrizioniSindacatiDM.selTabellaDATA_DEC_CESValidate(Sender: TField);
begin
  inherited;
  A122MW.selT246DATA_DEC_CESValidate;
end;

procedure TWA122FIscrizioniSindacatiDM.selTabellaDATA_DEC_ISCRValidate(Sender: TField);
begin
  inherited;
  A122MW.selT246DATA_DEC_ISCRValidate;
end;

procedure TWA122FIscrizioniSindacatiDM.selTabellaDATA_ISCRValidate(Sender: TField);
begin
  inherited;
  A122MW.selT246DATA_ISCRValidate;
end;

end.
