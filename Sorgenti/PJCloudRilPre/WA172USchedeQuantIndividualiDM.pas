unit WA172USchedeQuantIndividualiDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR303UGestMasterDetailDM, Data.DB,
  OracleData, A172USchedeQuantIndividualiMW, A000UInterfaccia, A000UMessaggi, medpIWMessageDlg,
  C180FunzioniGenerali;

type
  TWA172FSchedeQuantIndividualiDM = class(TWR303FGestMasterDetailDM)
    selTabellaCODGRUPPO: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaFILTRO_ANAGRAFE: TStringField;
    selTabellaCODTIPOQUOTA: TStringField;
    selTabellaNUMORE_TOTALE: TStringField;
    selTabellaIMPORTO_TOTALE: TFloatField;
    selTabellaDATARIF: TDateTimeField;
    selTabellaPAG1_PERC: TFloatField;
    selTabellaPAG1_MAX: TStringField;
    selTabellaPAG2_PERC: TFloatField;
    selTabellaPAG2_MAX: TStringField;
    selTabellaPAG3_PERC: TFloatField;
    selTabellaPAG3_MAX: TStringField;
    selTabellaPAG4_PERC: TFloatField;
    selTabellaPAG4_MAX: TStringField;
    selTabellaPAG5_PERC: TFloatField;
    selTabellaPAG5_MAX: TStringField;
    selTabellaPAG6_PERC: TFloatField;
    selTabellaPAG6_MAX: TStringField;
    selTabellaPAG7_PERC: TFloatField;
    selTabellaPAG7_MAX: TStringField;
    selTabellaPAG8_PERC: TFloatField;
    selTabellaPAG8_MAX: TStringField;
    selTabellaPAG9_PERC: TFloatField;
    selTabellaPAG9_MAX: TStringField;
    selTabellaPAG10_PERC: TFloatField;
    selTabellaPAG10_MAX: TStringField;
    selTabellaPAG11_PERC: TFloatField;
    selTabellaPAG11_MAX: TStringField;
    selTabellaPAG12_PERC: TFloatField;
    selTabellaPAG12_MAX: TStringField;
    selTabellaTOLLERANZA: TFloatField;
    selTabellaSTATO: TStringField;
    selTabellaSUPERVISIONE: TStringField;
    selTabellaPROG_SUPERVISORE: TFloatField;
    selTabellaANNO: TFloatField;
    selTabellaDESCTIPOQUOTA: TStringField;
    dsrSG715: TDataSource;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure selTabellaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure AfterPost(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure dsrSG715StateChange(Sender: TObject);
    procedure selTabellaAfterOpen(DataSet: TDataSet);
  private
    procedure ImpostazioniCampiCdsT768;
  protected
    procedure RelazionaTabelleFiglie; override;
  public
    OnSelSG715StateChange: procedure (Dataset: TDataSet) of object;
    InsT768, AggT768: Boolean;
    A172FSchedeQuantIndividualiMW: TA172FSchedeQuantIndividualiMW;
    procedure ElaborazioneInsT768;
  end;

implementation
uses WA172USchedeQuantIndividuali;

{$R *.dfm}

procedure TWA172FSchedeQuantIndividualiDM.IWUserSessionBaseCreate(
  Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','order by ANNO, CODGRUPPO, CODTIPOQUOTA');

  A172FSchedeQuantIndividualiMW:=TA172FSchedeQuantIndividualiMW.Create(Self);
  A172FSchedeQuantIndividualiMW.ImpostazioniCampiCdsT768:=ImpostazioniCampiCdsT768;
  A172FSchedeQuantIndividualiMW.SelT767_Funzioni:=selTabella;
  dsrSG715.DataSet:=A172FSchedeQuantIndividualiMW.selSG715;
  selTabella.FieldByName('DESCTIPOQUOTA').LookupDataSet:=A172FSchedeQuantIndividualiMW.selT765;
  inherited;
end;

procedure TWA172FSchedeQuantIndividualiDM.BeforeDelete(DataSet: TDataSet);
begin
  A172FSchedeQuantIndividualiMW.selT767BeforeDelete;
  inherited;
end;

procedure TWA172FSchedeQuantIndividualiDM.BeforePostNoStorico(
  DataSet: TDataSet);
begin
  inherited;
  A172FSchedeQuantIndividualiMW.selT767BeforePost(InsT768, AggT768);
end;

procedure TWA172FSchedeQuantIndividualiDM.dsrSG715StateChange(Sender: TObject);
begin
  inherited;
  if Assigned(OnSelSG715StateChange) then
    OnSelSG715StateChange(A172FSchedeQuantIndividualiMW.selSG715);
end;

procedure TWA172FSchedeQuantIndividualiDM.ImpostazioniCampiCdsT768;
begin
  with A172FSchedeQuantIndividualiMW do
  begin
    cdsT768.ReadOnly:=False;
    cdsT768.FieldByName('PROGRESSIVO').Visible:=False;
    cdsT768.FieldByName('MATRICOLA').DisplayLabel:='Matricola';
    cdsT768.FieldByName('COGNOME').DisplayLabel:='Cognome';
    cdsT768.FieldByName('NOME').DisplayLabel:='Nome';
    cdsT768.FieldByName('OBIETTIVI_POSIZ').DisplayLabel:='Ob. pos.';
    cdsT768.FieldByName('OBIETTIVI_POSIZ').DisplayWidth:=1;
    cdsT768.FieldByName('TOTQUOTAQUAL').DisplayLabel:='Qualitativo';
    cdsT768.FieldByName('PARTTIME').DisplayLabel:='% PT';
    cdsT768.FieldByName('FLESSIBILITA').DisplayLabel:='Flessibilità';
    cdsT768.FieldByName('FLESSIBILITA').DisplayWidth:=5;
    cdsT768.FieldByName('NOTE').DisplayLabel:='Casi particolari';
    cdsT768.FieldByName('NOTE').DisplayWidth:=10;
    cdsT768.FieldByName('NUMORE_ASSEGNATE').DisplayLabel:='Ore assegnate';
    cdsT768.FieldByName('NUMORE_ACCETTATE').DisplayLabel:='Ore accettate';
    cdsT768.FieldByName('IMPORTO_ORARIO').DisplayLabel:='Imp. orario';
    cdsT768.FieldByName('TOTALE_ASSEGNATO').Visible:=False;
    cdsT768.FieldByName('TOTALE_ACCETTATO').DisplayLabel:='Imp. accettato';
    cdsT768.FieldByName('INF_OBIETTIVI').DisplayLabel:='Obiettivi';
    cdsT768.FieldByName('INF_OBIETTIVI').DisplayWidth:=0;
    cdsT768.FieldByName('ACCETT_VALUTAZIONE').DisplayLabel:='Valutazione';
    cdsT768.FieldByName('ACCETT_VALUTAZIONE').DisplayWidth:=0;
    cdsT768.FieldByName('VALUTATORE').DisplayLabel:='Valutatore';
    cdsT768.FieldByName('VALUTATORE').DisplayWidth:=0;
    cdsT768.FieldByName('CONFERMATO').DisplayLabel:='Firma';
    cdsT768.FieldByName('CONFERMATO').DisplayWidth:=0;

    if Parametri.CampiRiferimento.C7_Dato1 <> '' then
      cdsT768.FieldByName('DATO1').DisplayLabel:=R180Capitalize(Parametri.CampiRiferimento.C7_Dato1)
    else
      cdsT768.FieldByName('DATO1').Visible:=False;

    if Parametri.CampiRiferimento.C7_Dato2 <> '' then
      cdsT768.FieldByName('DATO2').DisplayLabel:=R180Capitalize(Parametri.CampiRiferimento.C7_Dato2)
    else
      cdsT768.FieldByName('DATO2').Visible:=False;

    if Parametri.CampiRiferimento.C7_Dato3 <> '' then
      cdsT768.FieldByName('DATO3').DisplayLabel:=R180Capitalize(Parametri.CampiRiferimento.C7_Dato3)
    else
      cdsT768.FieldByName('DATO3').Visible:=False;

    cdsT768.FieldByName('NUMORE_EXTRA').DisplayLabel:='Ore extra budget';
    cdsT768.FieldByName('NUMORE_TOTALI').DisplayLabel:='Ore totali';
    cdsT768.FieldByName('NUMORE_PAGATE').DisplayLabel:='Ore pagate';
  end;
end;

procedure TWA172FSchedeQuantIndividualiDM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  if selTabella.RecordCount <= 0 then
    Exit;

  A172FSchedeQuantIndividualiMW.selT767AfterPost;

  if AggT768 then
  begin
    MsgBox.WebMessageDlg(A000MSG_A172_MSG_DIPENDENTI_CAMBIATI,mtInformation,[mbOk],nil,'');
  end;

  if InsT768 then
  begin
    with (Self.Owner as TWA172FSchedeQuantIndividuali) do
      addToInitProc(Format('SubmitClick("%s", "", true);',[btnInsT768.HTMLname]));
  end;
end;

procedure TWA172FSchedeQuantIndividualiDM.ElaborazioneInsT768;
var
  Tot: Real;
  TotOre: Integer;
begin
  InsT768:=False;
  A172FSchedeQuantIndividualiMW.selT767AfterPostInsT768Inizio(Tot,TotOre);
  A172FSchedeQuantIndividualiMW.selV430.First;
  while not A172FSchedeQuantIndividualiMW.selV430.Eof do
  begin
    A172FSchedeQuantIndividualiMW.selT767AfterPostInsT768ElaboraElemento(Tot,TotOre);
    A172FSchedeQuantIndividualiMW.selV430.Next;
  end;
  A172FSchedeQuantIndividualiMW.selT767AfterPostInsT768Fine(Tot,TotOre);
end;

procedure TWA172FSchedeQuantIndividualiDM.AfterScroll(DataSet: TDataSet);
begin
  A172FSchedeQuantIndividualiMW.SettaDatasetValutatori;
  inherited;
end;

procedure TWA172FSchedeQuantIndividualiDM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  A172FSchedeQuantIndividualiMW.selT767NewRecord;
end;

procedure TWA172FSchedeQuantIndividualiDM.RelazionaTabelleFiglie;
begin
  inherited;
  A172FSchedeQuantIndividualiMW.CaricaCdsT768;
end;

procedure TWA172FSchedeQuantIndividualiDM.selTabellaAfterOpen(
  DataSet: TDataSet);
begin
  inherited;
  if selTabella.RecordCount = 0 then
    AfterScroll(selTabella);
end;

procedure TWA172FSchedeQuantIndividualiDM.selTabellaFilterRecord(
  DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
  Accept:=A172FSchedeQuantIndividualiMW.selT767FilterRecord;
end;

procedure TWA172FSchedeQuantIndividualiDM.IWUserSessionBaseDestroy(
  Sender: TObject);
begin
  FreeAndNil(A172FSchedeQuantIndividualiMW);
  inherited;
end;

end.
