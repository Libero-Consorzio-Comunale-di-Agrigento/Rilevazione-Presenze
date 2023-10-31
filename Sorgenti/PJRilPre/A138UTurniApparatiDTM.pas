unit A138UTurniApparatiDTM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, A000UInterfaccia, A000UCostanti, A000USessione,
  C180FunzioniGenerali;

type
  TA138FTurniApparatiDTM = class(TR004FGestStoricoDtM)
    selT555: TOracleDataSet;
    dsrT555: TDataSource;
    selT555CODICE: TStringField;
    selT555DESCRIZIONE: TStringField;
    selT550: TOracleDataSet;
    selT550COD_APPARATO: TStringField;
    selT550CODICE: TStringField;
    selT550DECORRENZA: TDateTimeField;
    selT550DECORRENZA_FINE: TDateTimeField;
    selT550DESCRIZIONE: TStringField;
    selT550STATO: TStringField;
    selT550DESCCOD_APPARATO: TStringField;
    selFiltro1: TOracleDataSet;
    selFiltro2: TOracleDataSet;
    selT550FILTRO1: TStringField;
    selT550FILTRO2: TStringField;
    selT550FILTRO_SERVIZI: TStringField;
    selT540: TOracleDataSet;
    SelCols: TOracleDataSet;
    selT550DOTAZ_RADIO: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure BeforePost(DataSet: TDataSet); Override;
    procedure selT550AfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    function WidthCodice(Nome:String):Integer;
  end;

var
  A138FTurniApparatiDTM: TA138FTurniApparatiDTM;

implementation

uses A138UTurniApparati;

{$R *.dfm}

procedure TA138FTurniApparatiDTM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InterfacciaR004:=A138FTurniApparati.InterfacciaR004;
  InizializzaDataSet(selT550,[//evBeforeEdit,
                             evBeforeInsert,
                             evBeforePost,
                             evBeforeDelete,
                             evAfterDelete,
                             evAfterPost,
                             evOnTranslateMessage,
                             evOnNewRecord]);
  selT555.Open;
  selT550.Open;
  if A000LookupTabella(Parametri.CampiRiferimento.C22_PianServLiv1,selFiltro1) then
  begin
    if selFiltro1.VariableIndex('DECORRENZA') >= 0 then
      selFiltro1.SetVariable('DECORRENZA',EncodeDate(3999,12,31));
    selFiltro1.Open;
  end;
  if A000LookupTabella(Parametri.CampiRiferimento.C22_PianServLiv2,selFiltro2) then
  begin
    if selFiltro2.VariableIndex('DECORRENZA') >= 0 then
      selFiltro2.SetVariable('DECORRENZA',EncodeDate(3999,12,31));
    selFiltro2.Open;
  end;
end;

function TA138FTurniApparatiDTM.WidthCodice(Nome:String):Integer;
var T,C,S:String;
begin
  Result:=20;
  if Nome <> '' then
  begin
    if Nome = 'T540_SERVIZI' then
    begin
      T:=Nome;
      C:='CODICE';
    end
    else
      A000GetTabella(Nome,T,C,S);
    SelCols.Close;
    SelCols.SetVariable('TABELLA',T);
    SelCols.SetVariable('CODICE',C);
    try
      SelCols.Open;
    except
    end;
  end;
  if (Nome <> '') and (SelCols.Active) and (SelCols.RecordCount > 0) then
    Result:=SelCols.FieldByName('DATA_LENGTH').AsInteger;
  SelCols.Close;
end;

procedure TA138FTurniApparatiDTM.selT550AfterScroll(DataSet: TDataSet);
begin
  inherited;
  with A138FTurniApparati do
  begin
    R180PutCheckList(selT550.FieldByName('FILTRO1').AsString,WidthCodice(Parametri.CampiRiferimento.C22_PianServLiv1),ChkFiltro1);
    R180PutCheckList(selT550.FieldByName('FILTRO2').AsString,WidthCodice(Parametri.CampiRiferimento.C22_PianServLiv2),ChkFiltro2);
    R180PutCheckList(selT550.FieldByName('FILTRO_SERVIZI').AsString,WidthCodice('T540_SERVIZI'),ChkFiltroServizi);
  end;
end;

procedure TA138FTurniApparatiDTM.BeforePost(DataSet: TDataSet);
begin
  inherited;
  with A138FTurniApparati do
  begin
    selT550.FieldByName('FILTRO1').AsString:=R180GetCheckList(WidthCodice(Parametri.CampiRiferimento.C22_PianServLiv1),ChkFiltro1);
    selT550.FieldByName('FILTRO2').AsString:=R180GetCheckList(WidthCodice(Parametri.CampiRiferimento.C22_PianServLiv2),ChkFiltro2);
    selT550.FieldByName('FILTRO_SERVIZI').AsString:=R180GetCheckList(WidthCodice('T540_SERVIZI'),ChkFiltroServizi);
  end;
end;

end.

