unit A065UStampaBudgetMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, DBClient, Oracle, OracleData, CheckLst,
  Math, StrUtils, A000UCostanti, A000USessione, A000UInterfaccia, C180FunzioniGenerali,
  R005UDataModuleMW, A029UBudgetDtM1;

type
  TA065dsrAppDataChange = procedure of object;

  TA065FStampaBudgetMW = class(TR005FDataModuleMW)
    selT275: TOracleDataSet;
    selT275CODICE: TStringField;
    selT275DESCRIZIONE: TStringField;
    selT275ORDINE: TStringField;
    selT071: TOracleDataSet;
    Q730: TOracleDataSet;
    selT713: TOracleDataSet;
    selT714: TOracleDataSet;
    dsrT275: TDataSource;
    cdsApp: TClientDataSet;
    dsrApp: TDataSource;
    selV430: TOracleDataSet;
    selaV430: TOracleDataSet;
    cdsStampa: TClientDataSet;
    selbV430: TOracleDataSet;
    selT074: TOracleDataSet;
    updT714: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure dsrAppDataChange(Sender: TObject; Field: TField);
    procedure selT275BeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    IgnoraInibizioni: Boolean; //Ignora Parametri.Inibizioni (per chiamata da W051)
    ListaGruppi,ListaGruppiSel:TStringList;
    A029FBudgetDtM1: TA029FBudgetDtM1;
    evtdsrAppDataChange:TA065dsrAppDataChange;
    procedure EseguiFiltroAnagrafeUtente(pAnno,pDaMese,pAMese:Integer);
    procedure StruttureDisponibili(pAnno,pDaMese,pAMese:Integer;TipoBS:String);
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA065FStampaBudgetMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  IgnoraInibizioni:=False;
  cdsApp.CreateDataSet;
  cdsStampa.CreateDataSet;
  ListaGruppi:=TStringList.Create;
  ListaGruppiSel:=TStringList.Create;
  A029FBudgetDtM1:=TA029FBudgetDtM1.Create(nil);
  selT275.Open;
end;

procedure TA065FStampaBudgetMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(A029FBudgetDtM1);//.Free;
  FreeAndNil(ListaGruppiSel);//.Free;
  FreeAndNil(ListaGruppi);//.Free;
end;

procedure TA065FStampaBudgetMW.EseguiFiltroAnagrafeUtente(pAnno,pDaMese,pAMese:Integer);
var S:String;
begin
  if Trim(Parametri.Inibizioni.Text) <> '' then
  begin
    if (pAnno > 0) and (pDaMese > 0) and (pAMese > 0) and
       (   (selV430.GetVariable('C700DATADAL') <> EncodeDate(pAnno,pDaMese,1))
        or (selV430.GetVariable('DATALAVORO') <> R180FineMese(EncodeDate(pAnno,pAMese,1)))) then
    begin
      selV430.Close;
      S:=StringReplace(QVistaOracle,
                       ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine',
                       ':DATALAVORO >= T430DATADECORRENZA AND :C700DATADAL <= T430DATAFINE',
                       [rfIgnoreCase]);
      S:=StringReplace(S,
                       ':DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)',
                       ':DATALAVORO >= NVL(P430DECORRENZA,:DATALAVORO) AND :C700DATADAL <= NVL(P430DECORRENZA_FINE,:C700DATADAL)',
                       [rfIgnoreCase]);
      selV430.SetVariable('QVISTAORACLE',S + #10#13 + QVistaInServizioPeriodica);
      selV430.SetVariable('C700DATADAL',EncodeDate(pAnno,pDaMese,1));
      selV430.SetVariable('DATALAVORO',R180FineMese(EncodeDate(pAnno,pAMese,1)));
      selV430.SetVariable('FILTRO',Parametri.Inibizioni.Text);
      if Pos(':NOME_UTENTE',Parametri.Inibizioni.Text) > 0  then
      begin
        try
          selV430.DeleteVariable('NOME_UTENTE');
        except
        end;
        selV430.DeclareVariable('NOME_UTENTE',otString);
        selV430.SetVariable('NOME_UTENTE',Parametri.Operatore);
      end;
      selV430.Open;
    end;
  end;
end;

procedure TA065FStampaBudgetMW.selT275BeforeOpen(DataSet: TDataSet);
begin
  inherited;
  R180SetReadBuffer(TOracleDataSet(DataSet));
end;

procedure TA065FStampaBudgetMW.StruttureDisponibili(pAnno,pDaMese,pAMese:Integer;TipoBS:String);
//Estrazione delle strutture disponibili per l'operatore (FiltroAnagrafe e anno)
var
  i: Integer;
  FiltroOk: Boolean;
  s,s2,FiltroOld: String;
begin
  if (pAnno > 0) and (pDaMese > 0) and (pAMese > 0) and
     (   (selT713.GetVariable('TIPO') <> TipoBS)
      or (selT713.GetVariable('DADATA') <> EncodeDate(pAnno,pDaMese,1))
      or (selT713.GetVariable('ADATA') <> R180FineMese(EncodeDate(pAnno,pAMese,1)))) then
  begin
    for i:=0 to ListaGruppiSel.Count - 1 do
      s2:=s2 + IfThen(s2 <> '',',') + Copy(ListaGruppiSel[i],1,22);
    s2:=',' + s2 + ',';
    selT713.Close;
    selT713.SetVariable('ANNO',pAnno);
    selT713.SetVariable('TIPO',TipoBS);
    selT713.SetVariable('DADATA',EncodeDate(pAnno,pDaMese,1));
    selT713.SetVariable('ADATA',R180FineMese(EncodeDate(pAnno,pAMese,1)));
    selT713.Open;
    ListaGruppi.Clear;
    FiltroOld:='*';
    while not selT713.Eof do
    begin
      FiltroOk:=False;
      if (Trim(Parametri.Inibizioni.Text) <> '') and not IgnoraInibizioni
      and (selT713.FieldByName('FILTRO_ANAGRAFE').AsString <> FiltroOld) then
      begin
        if selV430.Active and (selV430.RecordCount > 0) then
        begin
          selaV430.Close;
          S:=StringReplace(QVistaOracle,
                           ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine',
                           ':DATALAVORO >= T430DATADECORRENZA AND :C700DATADAL <= T430DATAFINE',
                           [rfIgnoreCase]);
          S:=StringReplace(S,
                           ':DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)',
                           ':DATALAVORO >= NVL(P430DECORRENZA,:DATALAVORO) AND :C700DATADAL <= NVL(P430DECORRENZA_FINE,:C700DATADAL)',
                           [rfIgnoreCase]);
          selaV430.SetVariable('QVISTAORACLE',S + #10#13 + QVistaInServizioPeriodica);
          selaV430.SetVariable('C700DATADAL',EncodeDate(pAnno,pDaMese,1));
          selaV430.SetVariable('DATALAVORO',R180FineMese(EncodeDate(pAnno,pAMese,1)));
          selaV430.SetVariable('FILTRO',selT713.FieldByName('FILTRO_ANAGRAFE').AsString);
          selaV430.Open;
          while not selaV430.Eof do
          begin
            if selV430.SearchRecord('PROGRESSIVO',selaV430.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]) then
            begin
              FiltroOk:=True;
              Break;
            end;
            selaV430.Next;
          end;
        end;
        FiltroOld:=selT713.FieldByName('FILTRO_ANAGRAFE').AsString;
      end
      else
        FiltroOk:=True;
      if FiltroOk then
        ListaGruppi.Add(Trim(Format('%-10s %-5s %10s %-100s',[selT713.FieldByName('CODGRUPPO').AsString, selT713.FieldByName('TIPO').AsString, FormatDateTime('mm',selT713.FieldByName('DECORRENZA').AsDateTime) + '-' + FormatDateTime('mm/yyyy',selT713.FieldByName('DECORRENZA_FINE').AsDateTime), selT713.FieldByName('DESCRIZIONE').AsString])));
      selT713.Next;
    end;
    ListaGruppiSel.Clear;
    for i:=0 to ListaGruppi.Count - 1 do
      if Pos(',' + Copy(ListaGruppi[i],1,22) + ',',s2) > 0 then
        ListaGruppiSel.Add(ListaGruppi[i]);
  end;
end;

procedure TA065FStampaBudgetMW.dsrAppDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  if Assigned(evtdsrAppDataChange) then
    evtdsrAppDataChange;
end;

end.
