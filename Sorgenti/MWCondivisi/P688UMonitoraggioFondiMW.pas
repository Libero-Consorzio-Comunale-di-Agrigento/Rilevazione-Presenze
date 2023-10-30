unit P688UMonitoraggioFondiMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, Data.DB, OracleData,
  Datasnap.DBClient, StrUtils;

type
  TP688FMonitoraggioFondiMW = class(TR005FDataModuleMW)
    selP688: TOracleDataSet;
    cdsDati: TClientDataSet;
    dsrDati: TDataSource;
  private
    { Private declarations }
  public
    procedure LetturaFondi(DecorrenzaDa,DecorrenzaA:String; TipoTotalizzazione:Integer);
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TP688FMonitoraggioFondiMW.LetturaFondi(DecorrenzaDa,DecorrenzaA:String; TipoTotalizzazione:Integer);
begin
  selP688.Close;
  selP688.SetVariable('INIZIO',StrToDate(DecorrenzaDa));
  selP688.SetVariable('FINE',StrToDate(DecorrenzaA));
  if TipoTotalizzazione = 0 then
    selP688.SetVariable('DATI','COD_MACROCATEG,DESC_MACROCATEG,COD_FONDO,DESC_FONDO,COD_RAGGR,DESC_RAGGR')
  else if TipoTotalizzazione = 1 then
    selP688.SetVariable('DATI','COD_MACROCATEG,DESC_MACROCATEG,COD_FONDO_RAGGR,DESC_FONDO_RAGGR')
  else if TipoTotalizzazione = 2 then
    selP688.SetVariable('DATI','COD_MACROCATEG,DESC_MACROCATEG');
  selP688.Open;
  //Creo il dataset di appoggio
  cdsDati.Close;
  cdsDati.FieldDefs.Clear;
  cdsDati.FieldDefs.Add('COD_MACROCATEG',ftString,5);
  cdsDati.FieldDefs.Add('DESC_MACROCATEG',ftString,50);
  cdsDati.FieldDefs.Add('COD_RAGGR',ftString,15);
  cdsDati.FieldDefs.Add('DESC_RAGGR',ftString,500);
  cdsDati.FieldDefs.Add('COD_FONDO',ftString,15);
  cdsDati.FieldDefs.Add('DESC_FONDO',ftString,500);
  cdsDati.FieldDefs.Add('DECORRENZA_DA',ftDate);
  cdsDati.FieldDefs.Add('DECORRENZA_A',ftDate);
  cdsDati.FieldDefs.Add('DATA_ULTIMO_MONIT',ftDate);
  cdsDati.FieldDefs.Add('MM_ULTIMA_RETR',ftString,7);
  cdsDati.FieldDefs.Add('TOT_RISORSE',ftFloat);
  cdsDati.FieldDefs.Add('TOT_SPESO',ftFloat);
  cdsDati.FieldDefs.Add('TOT_RESIDUO',ftFloat);
  cdsDati.CreateDataSet;
  cdsDati.LogChanges:=False;
  cdsDati.Fields[0].DisplayWidth:=5;
  cdsDati.Fields[0].DisplayLabel:='Cod.macrocateg.';
  cdsDati.Fields[1].DisplayWidth:=30;
  cdsDati.Fields[1].DisplayLabel:='Descrizione macrocategoria';
  cdsDati.Fields[2].DisplayWidth:=15;
  cdsDati.Fields[2].DisplayLabel:=IfThen(TipoTotalizzazione = 0,'Cod.raggr.','Cod.fondo/raggr.');
  cdsDati.Fields[2].Visible:=TipoTotalizzazione <> 2;
  cdsDati.Fields[3].DisplayWidth:=50;
  cdsDati.Fields[3].DisplayLabel:=IfThen(TipoTotalizzazione = 0,'Descrizione raggruppamento','Descrizione fondo/raggruppamento');
  cdsDati.Fields[3].Visible:=TipoTotalizzazione <> 2;
  cdsDati.Fields[4].DisplayWidth:=15;
  cdsDati.Fields[4].DisplayLabel:='Cod.fondo';
  cdsDati.Fields[4].Visible:=TipoTotalizzazione = 0;
  cdsDati.Fields[5].DisplayWidth:=50;
  cdsDati.Fields[5].DisplayLabel:='Descrizione fondo';
  cdsDati.Fields[5].Visible:=TipoTotalizzazione = 0;
  cdsDati.Fields[6].DisplayLabel:='Decorrenza';
  cdsDati.Fields[6].Alignment:=taCenter;
  cdsDati.Fields[7].DisplayLabel:='Scadenza';
  cdsDati.Fields[7].Alignment:=taCenter;
  cdsDati.Fields[8].DisplayLabel:='Ultimo monit.';
  cdsDati.Fields[8].Alignment:=taCenter;
  cdsDati.Fields[9].DisplayLabel:='Ultimo mm retr.';
  cdsDati.Fields[9].Alignment:=taCenter;
  cdsDati.Fields[10].DisplayLabel:='Tot.risorse';
  TFloatField(cdsDati.Fields[10]).DisplayFormat:='###,###,###,##0';
  cdsDati.Fields[11].DisplayLabel:='Tot.speso';
  TFloatField(cdsDati.Fields[11]).DisplayFormat:='###,###,###,##0';
  cdsDati.Fields[12].DisplayLabel:='Tot.residuo';
  TFloatField(cdsDati.Fields[12]).DisplayFormat:='###,###,###,##0';
  //Carico il dataset di appoggio
  while not selP688.Eof do
  begin
    cdsDati.Append;
    cdsDati.FieldByName('COD_MACROCATEG').AsString:=selP688.FieldByName('COD_MACROCATEG').AsString;
    cdsDati.FieldByName('DESC_MACROCATEG').AsString:=selP688.FieldByName('DESC_MACROCATEG').AsString;
    if TipoTotalizzazione = 0 then
    begin
      cdsDati.FieldByName('COD_RAGGR').AsString:=selP688.FieldByName('COD_RAGGR').AsString;
      cdsDati.FieldByName('DESC_RAGGR').AsString:=selP688.FieldByName('DESC_RAGGR').AsString;
      cdsDati.FieldByName('COD_FONDO').AsString:=selP688.FieldByName('COD_FONDO').AsString;
      cdsDati.FieldByName('DESC_FONDO').AsString:=selP688.FieldByName('DESC_FONDO').AsString;
    end
    else if TipoTotalizzazione = 1 then
    begin
      cdsDati.FieldByName('COD_RAGGR').AsString:=selP688.FieldByName('COD_FONDO_RAGGR').AsString;
      cdsDati.FieldByName('DESC_RAGGR').AsString:=selP688.FieldByName('DESC_FONDO_RAGGR').AsString;
    end;
    cdsDati.FieldByName('DECORRENZA_DA').AsDateTime:=selP688.FieldByName('DECORRENZA_DA').AsDateTime;
    cdsDati.FieldByName('DECORRENZA_A').AsDateTime:=selP688.FieldByName('DECORRENZA_A').AsDateTime;
    cdsDati.FieldByName('DATA_ULTIMO_MONIT').AsDateTime:=selP688.FieldByName('DATA_ULTIMO_MONIT').AsDateTime;
    cdsDati.FieldByName('MM_ULTIMA_RETR').AsString:=selP688.FieldByName('MM_ULTIMA_RETR').AsString;
    cdsDati.FieldByName('TOT_RISORSE').AsFloat:=selP688.FieldByName('TOT_RISORSE').AsFloat;
    cdsDati.FieldByName('TOT_SPESO').AsFloat:=selP688.FieldByName('TOT_SPESO').AsFloat;
    cdsDati.FieldByName('TOT_RESIDUO').AsFloat:=selP688.FieldByName('TOT_RESIDUO').AsFloat;
    cdsDati.Post;
    selP688.Next;
  end;
  cdsDati.First;
end;

end.
