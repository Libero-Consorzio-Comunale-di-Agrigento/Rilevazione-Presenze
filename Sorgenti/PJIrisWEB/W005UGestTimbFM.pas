unit W005UGestTimbFM;

interface

uses
  SysUtils, Classes, Controls, Forms,
  IWVCLBaseContainer, IWColor, IWContainer, IWRegion, IWHTMLContainer,
  IWHTML40Container, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  R010UPaginaWeb, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWAdvRadioGroup, meTIWAdvRadioGroup, medpIWMultiColumnComboBox,
  IWCompExtCtrls, IWDBExtCtrls, meIWDBRadioGroup, IWDBStdCtrls, meIWDBEdit,
  IWCompEdit, meIWEdit, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  C190FunzioniGeneraliWeb, meIWRadioGroup, OracleData, A000UInterfaccia, W005UCartellino,
  C180FunzioniGenerali, W005UCartellinoDtm, A000USessione;

type
  TW005GestTimbratura = record
    Ora:string;
    Verso:string;
    Rilevatore:string;
    Causale:string;
  end;

  TInfoTimbratura = record
    TxtTimbratura:string;
    Operazione:string;
    DataTimbratura:TDateTime;
    GiornoTimbratura:integer;
    NumeroTimbratura:integer;
  end;

  TW005FGestTimbFM = class(TFrame)
    IWFrameRegion: TIWRegion;
    IWTemplateProcessorFrame: TIWTemplateProcessorHTML;
    jQVisFrame: TIWJQueryWidget;
    rgpTipoCausale: TmeTIWAdvRadioGroup;
    btnConferma: TmeIWButton;
    btnChiudi: TmeIWButton;
    lblData: TmeIWLabel;
    edtData: TmeIWEdit;
    lblDescData: TmeIWLabel;
    lblOra: TmeIWLabel;
    lblVerso: TmeIWLabel;
    lblRilevatore: TmeIWLabel;
    lblDescOrologio: TmeIWLabel;
    lblCausale: TmeIWLabel;
    lblDescCausale: TmeIWLabel;
    cmbRilevatore: TMedpIWMultiColumnComboBox;
    cmbCausale: TMedpIWMultiColumnComboBox;
    edtOra: TmeIWEdit;
    rgpVerso: TmeIWRadioGroup;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure btnChiudiClick(Sender: TObject);
    procedure btnConfermaClick(Sender: TObject);
    procedure rgpTipoCausaleClick(Sender: TObject);
    procedure cmbRilevatoreChange(Sender: TObject; Index: Integer);
    procedure cmbCausaleChange(Sender: TObject; Index: Integer);
  private
    { Private declarations }
    WFormParent: TR010FPaginaWeb;
    TimbAA,TimbMM,TimbGG:Word;
    GestTimbInfoTimb:TInfoTimbratura;
    function ScompattaTimbratura:TW005GestTimbratura;
    function CompattaTimbratura:string;
    procedure CaricaCmbRilevatore;
    procedure CaricaCmbCausale(Tipo:string);
  public
    { Public declarations }
    procedure Visualizza(InfoTimb:TInfoTimbratura);
  end;

implementation

uses
  IWAppForm;

{$R *.dfm}

procedure TW005FGestTimbFM.btnChiudiClick(Sender: TObject);
begin
  FreeAndNil(Self);
end;

function TW005FGestTimbFM.CompattaTimbratura;
begin
  Result:='';
  if rgpVerso.ItemIndex = 0 then
  begin
    Result:='E';
  end
  else
  begin
    Result:='U';
  end;
  if Not Trim(edtOra.Text).IsEmpty then
  begin
    Result:=Result + Trim(edtOra.Text);
  end;
  if Not Trim(cmbCausale.Text).IsEmpty then
  begin
    Result:=Result + '/' + Trim(cmbCausale.Text);
  end;
  if Not Trim(cmbRilevatore.Text).IsEmpty then
  begin
    Result:=Result + '(' + Trim(cmbRilevatore.Text) + ')';
  end;
end;

function TW005FGestTimbFM.ScompattaTimbratura:TW005GestTimbratura;
var
  IndCausale, IndRilavatoreStart, IndRilavatoreEnd:Integer;
  Timbratura:string;
begin
  Timbratura:=GestTimbInfoTimb.TxtTimbratura;
  Result.Verso:=Timbratura.Substring(0,1).ToUpper;
  Result.Ora:=Timbratura.Substring(1,5).Trim;
  IndCausale:=Timbratura.IndexOf('/') + 1;
  IndRilavatoreStart:=Timbratura.IndexOf('(') + 1;
  IndRilavatoreEnd:=Timbratura.IndexOf(')') - 1;
  Result.Rilevatore:=Timbratura.Substring(IndRilavatoreStart,IndRilavatoreEnd - IndRilavatoreStart + 1);
  if IndCausale > 0 then
  begin
    if IndRilavatoreStart > 0 then
    begin
      Result.Causale:=Timbratura.Substring(IndCausale, IndRilavatoreStart - IndCausale - 1);
    end
    else
    begin
      Result.Causale:=Timbratura.Substring(IndCausale, Timbratura.Length);
    end;
  end;
end;

procedure TW005FGestTimbFM.btnConfermaClick(Sender: TObject);
var
  Msg:string;
begin
  if GestTimbInfoTimb.Operazione = 'I' then
  begin
    Msg:=(Self.Parent as TW005FCartellino).ElaboraTimbratura(CompattaTimbratura,'I',0,0,EncodeDate(TimbAA,TimbMM,Trim(edtData.Text).ToInteger));
  end
  else
  begin
    Msg:=(Self.Parent as TW005FCartellino).ElaboraTimbratura(CompattaTimbratura,'M',GestTimbInfoTimb.GiornoTimbratura,GestTimbInfoTimb.NumeroTimbratura,EncodeDate(TimbAA,TimbMM,Trim(edtData.Text).ToInteger));
  end;
  SessioneOracle.Commit;
  if Msg.IsEmpty then
  begin
    (Self.Parent as TW005FCartellino).PublicRefresh;
    FreeAndNil(Self)
  end
  else
  begin
    raise Exception.Create(Msg);
  end;
end;

procedure TW005FGestTimbFM.IWFrameRegionCreate(Sender: TObject);
begin
  Self.Parent:=(Self.Owner as TIWAppForm);
  WFormParent:=(Self.Parent as TR010FPaginaWeb);
end;

procedure TW005FGestTimbFM.rgpTipoCausaleClick(Sender: TObject);
begin
  if rgpTipoCausale.ItemIndex = 0 then
  begin
    CaricaCmbCausale('P')
  end
  else if rgpTipoCausale.ItemIndex = 1 then
  begin
    CaricaCmbCausale('G');
  end;
end;

procedure TW005FGestTimbFM.CaricaCmbRilevatore;
var
  selT361:TOracleDataSet;
begin
  selT361:=TOracleDataSet.Create(nil);
  try
    selT361.Session:=SessioneOracle;
    selT361.SQL.Add('select T361.CODICE, T361.DESCRIZIONE');
    selT361.SQL.Add('  from T361_OROLOGI T361');
    selT361.SQL.Add('order by T361.CODICE');
    selT361.Open;
    C190CaricaMepdMulticolumnComboBox(cmbRilevatore,selT361,'CODICE','DESCRIZIONE');
  finally
    FreeAndNil(selT361);
  end;
end;

procedure TW005FGestTimbFM.cmbCausaleChange(Sender: TObject; Index: Integer);
begin
  if cmbCausale.ItemIndex >= 0 then
  begin
    lblDescCausale.Text:=cmbCausale.Items[cmbCausale.ItemIndex].RowData[1];
  end
  else
  begin
    lblDescCausale.Text:='';
  end;
end;

procedure TW005FGestTimbFM.cmbRilevatoreChange(Sender: TObject; Index: Integer);
begin
  if cmbRilevatore.ItemIndex >= 0 then
  begin
    lblDescOrologio.Text:=cmbRilevatore.Items[cmbRilevatore.ItemIndex].RowData[1];
  end
  else
  begin
    lblDescOrologio.Text:='';
  end;
end;

procedure TW005FGestTimbFM.CaricaCmbCausale(Tipo:string);
var
  LPrevFiltered: Boolean;
  LPrevFilter: String;
begin
  if Tipo = 'P' then
  begin
    // causali di presenza
    LPrevFiltered:=(Self.Parent as TW005FCartellino).W005Dtm.selT275.Filtered;
    LPrevFilter:=(Self.Parent as TW005FCartellino).W005Dtm.selT275.Filter;
    (Self.Parent as TW005FCartellino).W005Dtm.selT275.Filter:='INSERIMENTO_TIMB = ''S''';
    (Self.Parent as TW005FCartellino).W005Dtm.selT275.Filtered:=True;
    C190CaricaMepdMulticolumnComboBox(cmbCausale,(Self.Parent as TW005FCartellino).W005Dtm.selT275,'CODICE','DESCRIZIONE');
    (Self.Parent as TW005FCartellino).W005Dtm.selT275.Filtered:=LPrevFiltered;
    (Self.Parent as TW005FCartellino).W005Dtm.selT275.Filter:=LPrevFilter;
  end
  else if Tipo = 'G' then
  begin
    // causali di giustificazione
    LPrevFiltered:=(Self.Parent as TW005FCartellino).W005Dtm.selT305.Filtered;
    (Self.Parent as TW005FCartellino).W005Dtm.selT305.Filtered:=True;
    C190CaricaMepdMulticolumnComboBox(cmbCausale,(Self.Parent as TW005FCartellino).W005Dtm.selT305,'CODICE','DESCRIZIONE');
    (Self.Parent as TW005FCartellino).W005Dtm.selT305.Filtered:=LPrevFiltered;
  end;
end;

procedure TW005FGestTimbFM.Visualizza(InfoTimb:TInfoTimbratura);
begin
  GestTimbInfoTimb:=InfoTimb;
  edtOra.Text:=ScompattaTimbratura.Ora;
  if ScompattaTimbratura.Verso = 'U' then
  begin
    rgpVerso.ItemIndex:=1;
  end
  else
  begin
    rgpVerso.ItemIndex:=0;
  end;
  CaricaCmbRilevatore;
  cmbRilevatore.Text:=ScompattaTimbratura.Rilevatore;
  if cmbRilevatore.ItemIndex > 0 then
  begin
    lblDescOrologio.Text:=cmbRilevatore.Items[cmbRilevatore.ItemIndex].RowData[1];
  end
  else
  begin
    lblDescOrologio.Text:='';
  end;
  CaricaCmbCausale('P');
  cmbCausale.Text:=ScompattaTimbratura.Causale;
  if cmbCausale.ItemIndex > 0 then
  begin
    lblDescCausale.Text:=cmbCausale.Items[cmbCausale.ItemIndex].RowData[1]
  end
  else
  begin
    lblDescCausale.Text:='';
  end;
  DecodeDate(GestTimbInfoTimb.DataTimbratura,TimbAA,TimbMM,TimbGG);
  edtData.ReadOnly:=GestTimbInfoTimb.Operazione <> 'I';
  edtData.Text:=TimbGG.ToString;
  lblDescData.Text:=FormatDateTime(' mmmm yy',GestTimbInfoTimb.DataTimbratura);
  btnConferma.Visible:=not (Self.Parent as TW005FCartellino).SolaLettura;
  edtOra.Enabled:=Parametri.T100_Ora = 'S';
  cmbRilevatore.Enabled:=Parametri.T100_Rilevatore = 'S';
  cmbCausale.Enabled:=Parametri.T100_Causale = 'S';
  WFormParent.VisualizzajQMessaggio(jQVisFrame,500,-1,-1, 200,'<W005> Gestione timbrature ','#' + Name,False,True);
end;

end.