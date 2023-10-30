unit WS030UProvvedimentiDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData, StrUtils, Math,
  S030UProvvedimentiMW, A000UInterfaccia, medpIWMessageDlg, Datasnap.DBClient;

type
  TWS030FProvvedimentiDM = class(TWR302FGestTabellaDM)
    selTabellaPROGRESSIVO: TFloatField;
    selTabellaTIPO_PROVV: TStringField;
    selTabellaNOMECAMPO: TStringField;
    selTabellaDATAREGISTR: TDateTimeField;
    selTabellaDATADECOR: TDateTimeField;
    selTabellaDATAFINE: TDateTimeField;
    selTabellaCAUSALE: TStringField;
    selTabellaD_CAUSALI: TStringField;
    selTabellaTIPOATTO: TStringField;
    selTabellaNUMATTO: TStringField;
    selTabellaDATAATTO: TDateTimeField;
    selTabellaDATAESEC: TDateTimeField;
    selTabellaAUTORITA: TStringField;
    selTabellaSEDE: TStringField;
    selTabellaNOTE: TStringField;
    selTabellaD_DATO: TStringField;
    selTabellaD_SEDE: TStringField;
    cdsStoriaDato: TClientDataSet;
    cdsStoriaDatoDATO: TStringField;
    cdsStoriaDatoDATADEC: TStringField;
    cdsStoriaDatoDATAFINE: TStringField;
    cdsStoriaDatoVALORE: TStringField;
    cdsStoriaDatoDESCRIZIONE: TStringField;
    cdsStoriaDatoKEY: TStringField;
    cdsStoriaDatoRIGACOLORATA: TBooleanField;
    cdsrStoriaDato: TDataSource;
    selTabellaTESTOVAR: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure selTabellaCalcFields(DataSet: TDataSet);
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure AfterPost(DataSet: TDataSet); override;
  private
    { Private declarations }
    procedure ResultEvtRichiesta(Sender: TObject; R: TmeIWModalResult; KI: String);
  public
    { Public declarations }
    S030MW: TS030FProvvedimentiMW;
    procedure evtRichiesta(Msg,Chiave:String);
  end;

implementation

uses WS030UProvvedimenti, WS030UProvvedimentiDettFM, WS030UDettaglioFM;

{$R *.dfm}

procedure TWS030FProvvedimentiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY TIPO_PROVV,DATADECOR DESC,DATAREGISTR DESC');
  NonAprireSelTabella:=True;
  inherited;
  S030MW:=TS030FProvvedimentiMW.Create(Self);
  S030MW.evtRichiesta:=evtRichiesta;
  selTabella.FieldByName('D_CAUSALI').LookupDataSet:=S030MW.selSG104;
  S030MW.ApriDataSetSede;
  if S030MW.selSede.Active then
    selTabella.FieldByName('D_SEDE').LookupDataSet:=S030MW.selSede
  else
    selTabella.FieldByName('D_SEDE').FieldKind:=fkCalculated;//rendo innocuo il campo
  S030MW.selSG100:=selTabella;
  selTabella.Open;
  cdsStoriaDato.CreateDataSet;
end;

procedure TWS030FProvvedimentiDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(S030MW);
  inherited;
end;

procedure TWS030FProvvedimentiDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  inherited;
  selTabella.FieldByName('D_DATO').AsString:=IfThen(selTabella.FieldByName('TIPO_PROVV').AsString = 'S',
                                                    VarToStr(S030MW.selI010.Lookup('CODICE',selTabella.FieldByName('NOMECAMPO').AsString,'DESCRIZIONE')),
                                                    VarToStr(S030MW.selT265.Lookup('CODICE',selTabella.FieldByName('NOMECAMPO').AsString,'DESCRIZIONE')));
end;

procedure TWS030FProvvedimentiDM.AfterScroll(DataSet: TDataSet);
begin
  inherited;
  with (Self.Owner as TWS030FProvvedimenti) do
  begin
    (WDettaglioFM as TWS030FProvvedimentiDettFM).ImpostaCodiceDato;
    S030MW.selSG100AfterScroll;
    if grdTabControl.TabByIndex(2) <> nil then
      grdTabControl.TabByIndex(2).LinkVisible:=S030MW.VisualizzaDettaglio;
    AbilitaComponenti(True);
  end;
end;

procedure TWS030FProvvedimentiDM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  S030MW.selSG100NewRecord((Self.Owner as TWS030FProvvedimenti).rgpVisualizza.ItemIndex);
  with (Self.Owner as TWS030FProvvedimenti).WDettaglioFM as TWS030FProvvedimentiDettFM do
  begin
    dRgpTipo.ItemIndex:=IfThen(selTabella.FieldByName('TIPO_PROVV').AsString = 'S',0,1);
    CaricaMultiColumnCombobox;
  end;
end;

procedure TWS030FProvvedimentiDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  S030MW.selSG100BeforePost(((Self.Owner as TWS030FProvvedimenti).WDettaglioFM as TWS030FProvvedimentiDettFM).dRgpTipo.ItemIndex);
  MsgBox.ClearKeys;
end;

procedure TWS030FProvvedimentiDM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  S030MW.selSG100AfterPost;
  with (Self.Owner as TWS030FProvvedimenti) do
  begin
    if grdTabControl.TabByIndex(2) <> nil then
      grdTabControl.TabByIndex(2).LinkVisible:=S030MW.VisualizzaDettaglio;
    WBrowseFM.grdTabella.medpAggiornaCDS;
  end;
end;

procedure TWS030FProvvedimentiDM.evtRichiesta(Msg,Chiave:String);
begin
  if not MsgBox.KeyExists(Chiave) then
  begin
    MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultEvtRichiesta,Chiave);
    Abort;
  end;
end;

procedure TWS030FProvvedimentiDM.ResultEvtRichiesta(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
  begin
    if KI = 'BeforePostNumAtto' then
      SelTabella.Post
    else if KI = 'InsColl' then
      (Self.Owner as TWS030FProvvedimenti).actConfermaExecute(nil)
    else if KI = 'DelColl' then
      (Self.Owner as TWS030FProvvedimenti).actEliminaExecute(nil)
    else if (KI = 'DelDett') or (KI = 'ElabDett') then
      ((Self.Owner as TWS030FProvvedimenti).WS030Dett as TWS030FDettaglioFM).btnElaboraClick(nil);
  end
  else
    MsgBox.ClearKeys;
end;

end.
