unit WA080USoglieStraordinarioDM;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR303UGestMasterDetailDM, DB, OracleData,A000UInterfaccia, C180FunzioniGenerali, WR302UGestTabellaDM;

type
  TWA080FSoglieStraordinarioDM = class(TWR303FGestMasterDetailDM)
    selTabellaID: TFloatField;
    selTabellaTIPOCARTELLINO: TStringField;
    selTabellaDECORRENZA: TDateTimeField;
    selTabellaDECORRENZA_FINE: TDateTimeField;
    selTabellaSELEZIONE_ANAGRAFE: TStringField;
    selTabellaCAUSALI_GGLAV: TStringField;
    selTabellaCAUSALI_GGNONLAV: TStringField;
    selT028: TOracleDataSet;
    selT028ID: TFloatField;
    selT028SOGLIA: TStringField;
    selT028ESPRESSIONE: TStringField;
    selT028CAUSALE_GGLAV: TStringField;
    selT028D_CAUSALE_GGLAV: TStringField;
    selT028CAUSALE_GGNONLAV: TStringField;
    selT028D_CAUSALE_GGNONLAV: TStringField;
    selT275: TOracleDataSet;
    dsrT028: TDataSource;
    procedure AfterScroll(DataSet: TDataSet);
    procedure RelazionaTabelleFiglie;override;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure selTabellaAfterPost(DataSet: TDataSet);
    procedure selTabellaNewRecord(DataSet: TDataSet);
    procedure selT028BeforePost(DataSet: TDataSet);
    procedure selT028NewRecord(DataSet: TDataSet);
    procedure BeforeEdit(DataSet: TDataSet); override;
    procedure BeforePost(DataSet: TDataSet); override;
    procedure AfterCancel(DataSet: TDataSet); override;
  private
    FTipoCartellino:String;
    procedure VerificaOreNormali(Campo:String);
    procedure VerificaOreNormaliT028(Campo: String);
  public
    procedure PutTipoCartellino(Valore:String);
    property TipoCartellino:String read FTipoCartellino write PutTipoCartellino;
  end;

implementation

{$R *.dfm}


procedure TWA080FSoglieStraordinarioDM.AfterCancel(DataSet: TDataSet);
begin
  inherited;
  if selT028.UpdatesPending then
    selT028.CancelUpdates;
end;

procedure TWA080FSoglieStraordinarioDM.AfterScroll(DataSet: TDataSet);
begin
  inherited;
  selT028.SetVariable('ID',selTabella.FieldByName('ID').AsInteger);
  selT028.Open;
  selT028.ReadOnly:=True;
end;

procedure TWA080FSoglieStraordinarioDM.BeforeEdit(DataSet: TDataSet);
begin
  if selT028.UpdatesPending then
    selT028.CancelUpdates;
  selT028.Refresh;
end;

procedure TWA080FSoglieStraordinarioDM.BeforePost(DataSet: TDataSet);
var i:Integer;
begin
  inherited;
  if not selTabella.FieldByName('CAUSALI_GGNONLAV').IsNull then
    with TStringList.Create do
    try
      CommaText:=selTabella.FieldByName('CAUSALI_GGNONLAV').AsString;
      for i:=0 to Count - 1 do
        if R180CercaParolaIntera(Strings[i],selTabella.FieldByName('CAUSALI_GGLAV').AsString,',') > 0 then
          raise Exception.Create(Format('Causale %s già utilizzata per i giorni lavorativi!',[Strings[i]]));
    finally
      Free;
    end;
  if selT028.State in [dsEdit,dsInsert] then
    selT028.Post;
  VerificaOreNormali('CAUSALI_GGLAV');
  VerificaOreNormali('CAUSALI_GGNONLAV');
end;

procedure TWA080FSoglieStraordinarioDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  inherited;
  SelTabella.Open;
  selT275.Open;
  SetTabelleRelazionate([selTabella,selT028]);
end;

procedure TWA080FSoglieStraordinarioDM.PutTipoCartellino(Valore: String);
begin
  FTipoCartellino:=Valore;
  R180SetVariable(selTabella,'TIPOCARTELLINO',FTipoCartellino);
  selTabella.Open;
end;

procedure TWA080FSoglieStraordinarioDM.RelazionaTabelleFiglie;
begin
  inherited;
  selT028.DisableControls;
  selT028.Close;
  selT028.SetVariable('ID',selTabella.FieldByName('ID').AsInteger);
  selT028.Open;
  selT028.EnableControls;
end;

procedure TWA080FSoglieStraordinarioDM.selT028BeforePost(DataSet: TDataSet);
var S,CaptionCampo:String;
    N:Extended;
    OreNormali1,OreNormali2:Boolean;
begin
  if (not selT028.FieldByName('CAUSALE_GGLAV').IsNull) and
     (selT028.FieldByName('CAUSALE_GGLAV').AsString = selT028.FieldByName('CAUSALE_GGNONLAV').AsString) then
    raise Exception.Create('Le causali devono dei gg. lav e gg. non lav. essere diverse!');

  if selT028.FieldByName('SOGLIA').IsNull then
    selT028.FieldByName('SOGLIA').AsString:='*';
  S:=selT028.FieldByName('SOGLIA').AsString;
  if S <> '*' then
    if Pos('%',S) > 0 then
    begin
      if not TryStrToFloat(StringReplace(S,'%','',[]),N) then
        raise Exception.Create('La Soglia non è indicata correttamente!');
    end
    else
    try
      selT028.FieldByName('SOGLIA').AsString:=R180MinutiOre(R180OreMinutiExt(S));
    except
      raise Exception.Create('La Soglia non è indicata correttamente!');
    end;

  //Massimo 29/01/2013
  //Su IrisWin selT027 e selT028 sono legati dalla stessa toolbar; nel beforePost della T027 viene
  //richiamata la funzione 'VerificaOreNormali';
  VerificaOreNormaliT028('CAUSALI_GGLAV');
  VerificaOreNormaliT028('CAUSALI_GGNONLAV');
end;

procedure TWA080FSoglieStraordinarioDM.selT028NewRecord(DataSet: TDataSet);
begin
  inherited;
  selT028.FieldByName('ID').AsInteger:=selTabella.FieldByName('ID').AsInteger;
end;

procedure TWA080FSoglieStraordinarioDM.selTabellaAfterPost(DataSet: TDataSet);
begin
  if selT028.Active and selT028.UpdatesPending then
  begin
    SessioneOracle.ApplyUpdates([selT028],False);
    selT028.Refresh;
  end;
  inherited;
end;

procedure TWA080FSoglieStraordinarioDM.selTabellaNewRecord(DataSet: TDataSet);
begin
  inherited;
  selTabella.FieldByName('TIPOCARTELLINO').AsString:=TipoCartellino;
end;

procedure TWA080FSoglieStraordinarioDM.VerificaOreNormali(Campo:String);
var OreNormali1,OreNormali2,Errore:Boolean;
    i:Integer;
    CampoT028,CaptionCampo:String;
begin
  if selTabella.FieldByName(CAMPO).IsNull then
    exit;
  Errore:=False;
  CaptionCampo:='Eccedenze gg.' + IfThen(Campo = 'CAUSALI_GGNONLAV','non') + ' lavorativi';
  with TStringList.Create do
  try
    CommaText:=selTabella.FieldByName(CAMPO).AsString;
    for i:=0 to Count - 1 do
    begin
      if i = 0 then
      begin
        if Strings[i] = '<*L>' then
          OreNormali1:=True
        else
          OreNormali1:=VarToStr(selT275.Lookup('CODICE',Strings[i],'ORENORMALI')) <> 'A';
        OreNormali2:=OreNormali1;
      end
      else
      begin
        if Strings[i] = '<*L>' then
          OreNormali2:=True
        else
          OreNormali2:=VarToStr(selT275.Lookup('CODICE',Strings[i],'ORENORMALI')) <> 'A';
      end;
      if OreNormali1 <> OreNormali2 then
        raise Exception.Create('In "'+ CaptionCampo + '" sono state specificate causali sia incluse che escluse dalle ore normali.' + #13#10 +
                               'E'' consentito usare causali solo della stessa tipologia.');
    end;
  finally
    Free;
  end;
  if Campo = 'CAUSALI_GGLAV' then
    CampoT028:='CAUSALE_GGLAV'
  else
    CampoT028:='CAUSALE_GGNONLAV';
  with selT028 do
  begin
    First;
    while not Eof do
    begin
      OreNormali2:=VarToStr(selT275.Lookup('CODICE',FieldByName(CampoT028).AsString,'ORENORMALI')) <> 'A';
      if OreNormali1 <> OreNormali2 then
        raise Exception.Create('La causale ' + FieldByName(CampoT028).AsString + ' non è della stessa tipologia delle causali indicate in "' + CaptionCampo + '"');
      Next;
    end;
  end;
end;

procedure TWA080FSoglieStraordinarioDM.VerificaOreNormaliT028(Campo:String);
var OreNormali1,OreNormali2,Errore:Boolean;
    i:Integer;
    CampoT028,CaptionCampo:String;
begin
  if selTabella.FieldByName(CAMPO).IsNull then
    exit;
  Errore:=False;
  CaptionCampo:='Eccedenze gg.' + IfThen(Campo = 'CAUSALI_GGNONLAV','non') + ' lavorativi';
  with TStringList.Create do
  try
    CommaText:=selTabella.FieldByName(CAMPO).AsString;
    for i:=0 to Count - 1 do
    begin
      if i = 0 then
      begin
        if Strings[i] = '<*L>' then
          OreNormali1:=True
        else
          OreNormali1:=VarToStr(selT275.Lookup('CODICE',Strings[i],'ORENORMALI')) <> 'A';
        OreNormali2:=OreNormali1;
      end
      else
      begin
        if Strings[i] = '<*L>' then
          OreNormali2:=True
        else
          OreNormali2:=VarToStr(selT275.Lookup('CODICE',Strings[i],'ORENORMALI')) <> 'A';
      end;
      if OreNormali1 <> OreNormali2 then
        raise Exception.Create('In "'+ CaptionCampo + '" sono state specificate causali sia incluse che escluse dalle ore normali.' + #13#10 +
                               'E'' consentito usare causali solo della stessa tipologia.');
    end;
  finally
    Free;
  end;
  CampoT028:=IfThen(Campo = 'CAUSALI_GGLAV','CAUSALE_GGLAV','CAUSALE_GGNONLAV');
  with selT028 do
  begin
    OreNormali2:=VarToStr(selT275.Lookup('CODICE',FieldByName(CampoT028).AsString,'ORENORMALI')) <> 'A';
    if OreNormali1 <> OreNormali2 then
      raise Exception.Create('La causale ' + FieldByName(CampoT028).AsString + ' non è della stessa tipologia delle causali indicate in "' + CaptionCampo + '"');
  end;
end;

end.
