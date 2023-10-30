unit WA162UIncentiviAssenzeDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData,
  A162UIncentiviAssenzeMW,A000UInterfaccia, C180FunzioniGenerali, WR102UGestTabella;

type
  TWA162FIncentiviAssenzeDM = class(TWR302FGestTabellaDM)
    selTabellaDECORRENZA: TDateTimeField;
    selTabellaDECORRENZA_FINE: TDateTimeField;
    selTabellaDATO1: TStringField;
    selTabellaD_DATO1: TStringField;
    selTabellaDATO2: TStringField;
    selTabellaD_DATO2: TStringField;
    selTabellaDATO3: TStringField;
    selTabellaD_DATO3: TStringField;
    selTabellaCAUSALE: TStringField;
    selTabellaCOD_TIPOACCORPCAUSALI: TStringField;
    selTabellaCOD_CODICIACCORPCAUSALI: TStringField;
    selTabellaTIPO_ABBATTIMENTO: TStringField;
    selTabellaGESTIONE_FRANCHIGIA: TStringField;
    selTabellaFRANCHIGIA_ASSENZE: TIntegerField;
    selTabellaCONTA_FRUITO_ORE: TStringField;
    selTabellaFORZA_ABB_GGINT: TStringField;
    selTabellaPERC_ABBATTIMENTO: TFloatField;
    selTabellaPERC_ABB_FRANCHIGIA: TFloatField;
    selTabellaASSENZE_AGGIUNTIVE: TStringField;
    selTabellaPROPORZIONE_FRANCHIGIA: TStringField;
    selTabellaCONTA_SOLO_GGINT: TStringField;
    selTabellaD_TIPOACCORP: TStringField;
    selTabellaD_CODICIACCORPCAUSALI: TStringField;
    selTabellaD_CAUSALE: TStringField;
    selTabellaD_TIPOABBAT: TStringField;
    selTabellaD_RISPARMIO: TStringField;
    selTabellaCODTIPOQUOTA: TStringField;
    selTabellaD_TIPOQUOTA: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure BeforePost(DataSet: TDataSet); override;
  private
    { Private declarations }
  public
    A162FIncentiviAssenzeMW: TA162FIncentiviAssenzeMW;
  end;

implementation

{$R *.dfm}

procedure TWA162FIncentiviAssenzeDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','order by dato1,dato2,dato3,codtipoquota,cod_tipoaccorpcausali,cod_codiciaccorpcausali,causale,decorrenza,decorrenza_fine');
  NonAprireSelTabella:=True;
  inherited;
  A162FIncentiviAssenzeMW:=TA162FIncentiviAssenzeMW.Create(Self);
  A162FIncentiviAssenzeMW.selT769_Funzioni:=selTabella;
  if Parametri.CampiRiferimento.C7_Dato1 <> '' then
  begin
    A162FIncentiviAssenzeMW.CaricamentoDati(A162FIncentiviAssenzeMW.selDato1,Parametri.CampiRiferimento.C7_Dato1,Parametri.DataLavoro);
    selTabella.FieldByName('DATO1').DisplayLabel:=R180Capitalize(Parametri.CampiRiferimento.C7_Dato1);
    selTabella.FieldByName('D_DATO1').DisplayLabel:='Desc. ' + selTabella.FieldByName('DATO1').DisplayLabel;
    selTabella.FieldByName('D_DATO1').LookupDataset:=A162FIncentiviAssenzeMW.selDato1;
  end
  else
  begin
    selTabella.FieldByName('D_DATO1').Free;
    selTabella.FieldByName('DATO1').Visible:=False;
  end;

  if Parametri.CampiRiferimento.C7_Dato2 <> '' then
  begin
    A162FIncentiviAssenzeMW.CaricamentoDati(A162FIncentiviAssenzeMW.selDato2,Parametri.CampiRiferimento.C7_Dato2,Parametri.DataLavoro);
    selTabella.FieldByName('DATO2').DisplayLabel:=R180Capitalize(Parametri.CampiRiferimento.C7_Dato2);
    selTabella.FieldByName('D_DATO2').DisplayLabel:='Desc. ' + selTabella.FieldByName('DATO2').DisplayLabel;
    selTabella.FieldByName('D_DATO2').LookupDataset:=A162FIncentiviAssenzeMW.selDato2;
  end
  else
  begin
    selTabella.FieldByName('D_DATO2').Free;
    selTabella.FieldByName('DATO2').Visible:=False;
  end;

  if Parametri.CampiRiferimento.C7_Dato3 <> '' then
  begin
    A162FIncentiviAssenzeMW.CaricamentoDati(A162FIncentiviAssenzeMW.selDato3,Parametri.CampiRiferimento.C7_Dato3,Parametri.DataLavoro);
    selTabella.FieldByName('DATO3').DisplayLabel:=R180Capitalize(Parametri.CampiRiferimento.C7_Dato3);
    selTabella.FieldByName('D_DATO3').DisplayLabel:='Desc. ' + selTabella.FieldByName('DATO3').DisplayLabel;
    selTabella.FieldByName('D_DATO3').LookupDataset:=A162FIncentiviAssenzeMW.selDato3;
  end
  else
  begin
    selTabella.FieldByName('D_DATO3').Free;
    selTabella.FieldByName('DATO3').Visible:=False;
  end;

  selTabella.FieldByName('D_TIPOQUOTA').LookupDataSet:=A162FIncentiviAssenzeMW.selT765;
  selTabella.FieldByName('D_TIPOACCORP').LookupDataSet:=A162FIncentiviAssenzeMW.selT255;
  selTabella.FieldByName('D_CODICIACCORPCAUSALI').LookupDataSet:=A162FIncentiviAssenzeMW.selT256;
  selTabella.FieldByName('D_CAUSALE').LookupDataSet:=A162FIncentiviAssenzeMW.selT265;
  selTabella.FieldByName('D_TIPOABBAT').LookupDataSet:=A162FIncentiviAssenzeMW.selT766;
  selTabella.FieldByName('D_RISPARMIO').LookupDataSet:=A162FIncentiviAssenzeMW.selT766;

  selTabella.Open;
end;

procedure TWA162FIncentiviAssenzeDM.BeforePost(DataSet: TDataSet);
begin
  inherited;
  A162FIncentiviAssenzeMW.SelT769BeforePost;
end;

procedure TWA162FIncentiviAssenzeDM.AfterScroll(DataSet: TDataSet);
begin
  A162FIncentiviAssenzeMW.ImpostaTipoSelT256(selTabella.FieldByName('COD_TIPOACCORPCAUSALI').AsString);
  A162FIncentiviAssenzeMW.SelT769AfterScroll;
  inherited;
  if (Self.Owner as TWR102FGestTabella).WDettaglioFM <> nil then
    (Self.Owner as TWR102FGestTabella).WDettaglioFM.AbilitaComponenti;
end;

procedure TWA162FIncentiviAssenzeDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A162FIncentiviAssenzeMW);
  inherited;
end;

end.
