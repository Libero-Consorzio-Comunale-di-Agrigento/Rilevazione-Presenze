unit P501UCudSetupMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R005UDataModuleMW, DB, USelI010, A000UInterfaccia, A000UMessaggi, OracleData,
  C180FunzioniGenerali;

type
  TP501ActivePage = procedure (Nometab: String) of Object;

  TP501FCudSetupMW = class(TR005FDataModuleMW)
    selP030: TOracleDataSet;
    selP030COD_VALUTA: TStringField;
    selP030DESCRIZIONE: TStringField;
    dsrI010: TDataSource;
    selT440: TOracleDataSet;
    dsrT440: TDataSource;
    selT440CODICE: TStringField;
    selT440DESCRIZIONE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    selP500: TOracleDataSet;
    selI010: TselI010;
    VisualizzaTab: TP501ActivePage;
    function MeseSuccessivo(MeseRif:Integer):TDateTime;
    procedure CambiaAnno;
    procedure ImpostaAnno;
    procedure BeforePost;
    const
      tabFamiliari = 'tabFamiliari';
      tabCedolino  = 'tabCedolino';
      tabCU  = 'tshDatiCud';
  end;

implementation

{$R *.dfm}

procedure TP501FCudSetupMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selP030.Close;
  selP030.SetVariable('DECORRENZA',Parametri.DataLavoro);
  selP030.Open;
  selT440.SetVariable('DESCRIZIONE_BASE',Parametri.RagioneSociale);
  selT440.Open;
  selI010:=TselI010.Create(Self);
  selI010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO,POSIZIONE','','NOME_LOGICO');
  dsrI010.DataSet:=selI010;
end;

procedure TP501FCudSetupMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(selI010);
end;

function TP501FCudSetupMW.MeseSuccessivo(MeseRif:Integer):TDateTime;
begin
  Result:=Date;
  case MeseRif of
    1: Result:=StrToDate('15/02/' + selP500.FieldByName('ANNO').AsString);
    2: Result:=StrToDate('15/03/' + selP500.FieldByName('ANNO').AsString);
    3: Result:=StrToDate('15/04/' + selP500.FieldByName('ANNO').AsString);
    4: Result:=StrToDate('15/05/' + selP500.FieldByName('ANNO').AsString);
    5: Result:=StrToDate('15/06/' + selP500.FieldByName('ANNO').AsString);
    6: Result:=StrToDate('15/07/' + selP500.FieldByName('ANNO').AsString);
    7: Result:=StrToDate('15/08/' + selP500.FieldByName('ANNO').AsString);
    8: Result:=StrToDate('15/09/' + selP500.FieldByName('ANNO').AsString);
    9: Result:=StrToDate('15/10/' + selP500.FieldByName('ANNO').AsString);
    10: Result:=StrToDate('15/11/' + selP500.FieldByName('ANNO').AsString);
    11: Result:=StrToDate('15/12/' + selP500.FieldByName('ANNO').AsString);
    12: Result:=StrToDate('15/01/' + IntToStr(selP500.FieldByName('ANNO').AsInteger + 1));
  end;
end;

procedure TP501FCudSetupMW.BeforePost;
begin
  inherited;
  if (    (selP500.FieldByName('FAM_DATA_DA').AsString = '')
      and (selP500.FieldByName('FAM_DATA_A').AsString <> ''))
  or (    (selP500.FieldByName('FAM_DATA_A').AsString = '')
      and (selP500.FieldByName('FAM_DATA_DA').AsString <> '')) then
  begin
    VisualizzaTab(tabFamiliari);
    raise exception.Create(A000MSG_P501_ERR_DATE_INCONGRUENTI);
  end;
  if selP500.FieldByName('FAM_DATA_DA').AsDateTime > selP500.FieldByName('FAM_DATA_A').AsDateTime then
  begin
    VisualizzaTab(tabFamiliari);
    raise exception.Create(A000MSG_P501_ERR_DATE_ORDINATE);
  end;
  if ((selP500.FieldByName('FAM_DATA_DA').AsString <> '') and (R180Anno(selP500.FieldByName('FAM_DATA_DA').AsDateTime) <> selP500.FieldByName('ANNO').AsInteger))
  or ((selP500.FieldByName('FAM_DATA_A').AsString <> '') and (R180Anno(selP500.FieldByName('FAM_DATA_A').AsDateTime) <> selP500.FieldByName('ANNO').AsInteger)) then
  begin
    VisualizzaTab(tabFamiliari);
    raise exception.Create(Format(A000MSG_P501_ERR_FMT_DATE_RANGE,[selP500.FieldByName('ANNO').AsString]));
  end;
  //Controllo la data firma CU
  if (selP500.FieldByName('WEB_STAMPA').AsString = 'S') and (selP500.FieldByName('WEB_DATA_STAMPA').AsString = '') then
  begin
    VisualizzaTab(tabCU);
    raise exception.Create(A000MSG_P501_ERR_DATA_FIRMA_CU);
  end;
  //Gestisco il percorso archivio PDF per i cedolini
  selP500.FieldByName('PATH_FILEPDF_CED').AsString:=Trim(selP500.FieldByName('PATH_FILEPDF_CED').AsString);
  if Copy(selP500.FieldByName('PATH_FILEPDF_CED').AsString,Length(selP500.FieldByName('PATH_FILEPDF_CED').AsString),1) = '\' then
    selP500.FieldByName('PATH_FILEPDF_CED').AsString:=Copy(selP500.FieldByName('PATH_FILEPDF_CED').AsString,1,Length(selP500.FieldByName('PATH_FILEPDF_CED').AsString) - 1);
  if not selP500.FieldByName('PATH_FILEPDF_CED').IsNull and not DirectoryExists(selP500.FieldByName('PATH_FILEPDF_CED').AsString) then
  begin
    VisualizzaTab(tabCedolino);
    raise exception.Create(A000MSG_P501_ERR_FILEPDF_INESISTENTE);
  end;
  //Gestisco il nome file di esportazione della stampa massiva dei cedolini in formato PDF
  selP500.FieldByName('NOME_FILEPDF_CED').AsString:=Trim(selP500.FieldByName('NOME_FILEPDF_CED').AsString);
  if not selP500.FieldByName('NOME_FILEPDF_CED').IsNull then
  begin
    if UpperCase(ExtractFileExt(selP500.FieldByName('NOME_FILEPDF_CED').AsString)) <> '.PDF' then
    begin
      VisualizzaTab(tabCedolino);
      raise exception.Create(A000MSG_P501_ERR_FORMATO_FILE_MASSIVO);
    end;
    if not DirectoryExists(R180GetFilePath(selP500.FieldByName('NOME_FILEPDF_CED').AsString)) then
    begin
      VisualizzaTab(tabCedolino);
      raise exception.Create(A000MSG_P501_ERR_PATH_FILE_MASSIVO);
    end;
  end;
end;

procedure TP501FCudSetupMW.ImpostaAnno;
var
  Anno,Mese,Giorno: Word;
begin
  if selP500.FieldByName('ANNO').AsInteger = 0 then
  begin
    DecodeDate(Parametri.DataLavoro,Anno,Mese,Giorno);
    selP500.FieldByName('ANNO').AsInteger:=Anno;
  end;
end;

procedure TP501FCudSetupMW.CambiaAnno;
var
  DataFineAnno: TDateTime;
begin
  DataFineAnno:=EncodeDate(selP500.FieldByName('ANNO').AsInteger,12,31);
  if selP030.GetVariable('DECORRENZA') <> DataFineAnno then
  begin
    selP030.Close;
    selP030.SetVariable('DECORRENZA',EncodeDate(selP500.FieldByName('ANNO').AsInteger,12,31));
    selP030.Open;
  end;
end;

end.
