unit WA123UPartecipazioniSindacatiDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData,
  A123UPartecipazioniSindacatiMW, A000UMessaggi, C180FunzioniGenerali;

type
  TWA123FPartecipazioniSindacatiDM = class(TWR302FGestTabellaDM)
    selTabellaPROGRESSIVO: TIntegerField;
    selTabellaDADATA: TDateTimeField;
    selTabellaADATA: TDateTimeField;
    selTabellaCOD_SINDACATO: TStringField;
    selTabellaDESC_SINDACATO: TStringField;
    selTabellaCOD_ORGANISMO: TStringField;
    selTabellaDESC_ORGANISMO: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure selTabellaDADATAValidate(Sender: TField);
    procedure selTabellaADATAValidate(Sender: TField);
    procedure selTabellaCOD_SINDACATOChange(Sender: TField);
    procedure selTabellaCOD_ORGANISMOChange(Sender: TField);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure BeforeInsert(DataSet: TDataSet); Override;
    procedure BeforePostNoStorico(DataSet: TDataSet); Override;
    procedure selTabellaCalcFields(DataSet: TDataSet);
    procedure OnNewRecord(DataSet: TDataSet); Override;
  private
    procedure CaricaListeGriglia(Lista: TStringList);
  public
    A123MW: TA123FPartecipazioniSindacatiMW;
    ListaSindacati: TStringList;
    ListaOrganismi: TStringList;
  end;

implementation

{$R *.dfm}

procedure TWA123FPartecipazioniSindacatiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  SelTabella.SetVariable('ORDERBY',' ORDER BY DADATA, COD_SINDACATO, COD_ORGANISMO ');
  NonAprireSelTabella:=True;
  inherited;
  ListaSindacati:=TStringList.Create;
  ListaOrganismi:=TStringList.Create;
  A123MW:=TA123FPartecipazioniSindacatiMW.Create(Self);
  A123MW.selT247:=SelTabella;
  A123MW.CaricaListeGriglia:=CaricaListeGriglia;
  selTabella.Open;
end;

procedure TWA123FPartecipazioniSindacatiDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(ListaSindacati);
  FreeAndNil(ListaOrganismi);
end;

procedure TWA123FPartecipazioniSindacatiDM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  A123MW.SelT247OnNewRecord;
end;

procedure TWA123FPartecipazioniSindacatiDM.BeforeInsert(DataSet: TDataSet);
begin
  inherited;
  A123MW.SelT247BeforeInsert;
end;

procedure TWA123FPartecipazioniSindacatiDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  A123MW.selT247BeforePostStep1;
  //Controllo sul codice sindacato
  if R180IndexOf(ListaSindacati,SelTabella.FieldByName('COD_SINDACATO').AsString,10) = -1 then
    raise exception.Create(A000MSG_A123_ERR_COD_SINDACATO);
  //Controllo sul codice organismo
  //if R180IndexOf(ListaOrganismi,SelTabella.FieldByName('COD_ORGANISMO').AsString,5) = -1 then
  if ListaOrganismi.Text.IndexOf(SelTabella.FieldByName('COD_ORGANISMO').AsString+';') = -1 then
    raise exception.Create(A000MSG_A123_ERR_COD_ORGANISMO);
  A123MW.selT247BeforePostStep2;
end;

procedure TWA123FPartecipazioniSindacatiDM.CaricaListeGriglia(Lista: TStringList);
begin
  ListaSindacati.Clear;
  ListaOrganismi.Clear;
  ListaSindacati.Assign(Lista);
  with A123MW.selT245 do
  begin
    First;
    while not Eof do
    begin
      ListaOrganismi.Add(FieldByName('CODICE').AsString+';'+FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
  end;
end;

procedure TWA123FPartecipazioniSindacatiDM.selTabellaADATAValidate(Sender: TField);
begin
  A123MW.SelT247ADATAValidate;
end;

procedure TWA123FPartecipazioniSindacatiDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  inherited;
  A123MW.SelT247CalcFields;
end;

procedure TWA123FPartecipazioniSindacatiDM.selTabellaCOD_ORGANISMOChange(Sender: TField);
begin
  A123MW.selT247COD_ORGANISMOChange(Sender);
end;

procedure TWA123FPartecipazioniSindacatiDM.selTabellaCOD_SINDACATOChange(Sender: TField);
begin
  A123MW.SelT247COD_SINDACATOChange(Sender);
end;

procedure TWA123FPartecipazioniSindacatiDM.selTabellaDADATAValidate(Sender: TField);
begin
  A123MW.CaricaSindacati;
end;

end.
