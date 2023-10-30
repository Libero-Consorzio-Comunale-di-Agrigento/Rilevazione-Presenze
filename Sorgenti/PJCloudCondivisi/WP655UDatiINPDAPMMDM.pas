unit WP655UDatiINPDAPMMDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR303UGestMasterDetailDM, Data.DB,
  OracleData, P655UDatiINPDAPMMMW;

type
  TWP655FDatiINPDAPMMDM = class(TWR303FGestMasterDetailDM)
    selTabellaDATA_FINE_PERIODO: TDateTimeField;
    selTabellaCHIUSO: TStringField;
    selTabellaDATA_CHIUSURA: TDateTimeField;
    selTabellaNOME_FLUSSO: TStringField;
    selTabellaID_FLUSSO: TFloatField;
    selTabellaDESC_CHIUSO: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure BeforeDelete(DataSet: TDataSet); override;
  private
    procedure P663NewRecord(DataSet: TDataSet);
    { Private declarations }
  protected
    procedure RelazionaTabelleFiglie; override;
  public
    P655FDatiINPDAPMMMW: TP655FDatiINPDAPMMMW;
    procedure CaricaFlussiIndividuali;
  end;

implementation

uses
  WP655UDatiINPDAPMM;

{$R *.dfm}

{ TWP655FDatiINPDAPMMDM }

procedure TWP655FDatiINPDAPMMDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  NonAprireSelTabella:=True;
  selTabella.SetVariable('NOMEFLUSSO',(Self.Owner as TWP655FDatiINPDAPMM).NomeFlusso);
  selTabella.SetVariable('ORDERBY',' ORDER BY DATA_FINE_PERIODO,DATA_CHIUSURA');
  inherited;
  P655FDatiINPDAPMMMW:=TP655FDatiINPDAPMMMW.Create(Self);
  P655FDatiINPDAPMMMW.SelP662_Funzioni:=SelTabella;
  P655FDatiINPDAPMMMW.ImpostaSelP660((Self.Owner as TWP655FDatiINPDAPMM).NomeFlusso);
  P655FDatiINPDAPMMMW.P663.ReadOnly:=False;
  P655FDatiINPDAPMMMW.P663.OnNewRecord:=P663NewRecord;
  selTabella.Open;
end;

procedure TWP655FDatiINPDAPMMDM.P663NewRecord(DataSet: TDataSet);
begin
  with (Self.Owner as TWP655FDatiINPDAPMM).Detail do
  begin
    P655FDatiINPDAPMMMW.P663NewRecord(rgpTipoDati.ItemIndex);
    if bCopiaSu then
    begin
      P655FDatiINPDAPMMMW.P663.FieldByName('PARTE').AsString:=ParteOrig;
      P655FDatiINPDAPMMMW.P663.FieldByName('NUMERO').AsString:=NumeroOrig;
      P655FDatiINPDAPMMMW.P663.FieldByName('PROGRESSIVO_NUMERO').AsString:=ProgressivoOrig;
      P655FDatiINPDAPMMMW.P663.FieldByName('VALORE').AsString:=ValoreOrig;
    end;
  end;
end;

procedure TWP655FDatiINPDAPMMDM.RelazionaTabelleFiglie;
begin
  P655FDatiINPDAPMMMW.ReimpostaDatasetCollegati((Self.Owner as TWP655FDatiINPDAPMM).NomeFlusso);
  CaricaFlussiIndividuali;
end;

procedure TWP655FDatiINPDAPMMDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  P655FDatiINPDAPMMMW.P662BeforeDelete;
end;

procedure TWP655FDatiINPDAPMMDM.CaricaFlussiIndividuali;
begin
  if P655FDatiINPDAPMMMW.SelAnagrafe = nil then Exit;

  with (Self.Owner as TWP655FDatiINPDAPMM) do
  begin
    if Detail = nil then
      Exit;
    P655FDatiINPDAPMMMW.LeggoDettaglioINPDAPMM(NomeFlusso,Detail.rgpTipoDati.ItemIndex,Detail.rgpTipoRecord.ItemIndex);
  end;
end;

procedure TWP655FDatiINPDAPMMDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(P655FDatiINPDAPMMMW);
  inherited;
end;

end.
