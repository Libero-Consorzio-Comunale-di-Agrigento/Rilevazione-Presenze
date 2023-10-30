unit WA124UInvioPermessiFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR200UBaseFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, OracleData,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompEdit, meIWEdit,
  IWCompLabel, meIWLabel, medpIWMultiColumnComboBox, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWCompGrids, IWDBGrids,
  medpIWDBGrid, IWCompExtCtrls, meIWImageFile, medpIWImageButton, A000UInterfaccia,
  IWCompButton, meIWButton, IWApplication, C190FunzioniGeneraliWeb;

type
  TWA124FInvioPermessiFM = class(TWR200FBaseFM)
    dgrdNoGEDAP: TmedpIWDBGrid;
    cmbSindacato: TMedpIWMultiColumnComboBox;
    cmbOrganismo: TMedpIWMultiColumnComboBox;
    lblDataA: TmeIWLabel;
    edtDataA: TmeIWEdit;
    lblDataDa: TmeIWLabel;
    edtDataDa: TmeIWEdit;
    lblSindacato: TmeIWLabel;
    lblOrganismo: TmeIWLabel;
    btnEsegui: TmedpIWImageButton;
    btnAnomalie: TmedpIWImageButton;
    btnFiltri: TmeIWButton;
    btnImpostaPermessiVisInviati: TmedpIWImageButton;
    procedure edtDataDaAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure edtDataAAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure cmbSindacatoAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure btnFiltriClick(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure dgrdNoGEDAPAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure dgrdNoGEDAPRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure btnImpostaPermessiVisInviatiClick(Sender: TObject);
  private
    { Private declarations }
    AccessoSolaLettura:Boolean;
    procedure AbilitaComponenti;
    procedure AggiornaGriglia;
    procedure imgConfermaClick(Sender: TObject);
  public
    { Public declarations }
    procedure CaricaDatiIniziali;
  end;

var
  WA124FInvioPermessiFM: TWA124FInvioPermessiFM;

implementation

uses WA124UPermessiSindacaliDM, WA124UPermessiSindacali;

{$R *.dfm}

procedure TWA124FInvioPermessiFM.CaricaDatiIniziali;
begin
  AccessoSolaLettura:=(Self.Owner as TWA124FPermessiSindacali).SolaLettura;
  with (WR302DM as TWA124FPermessiSindacaliDM).A124MW do
  begin
    //Date
    edtDataDa.Text:=DateToStr(EncodeDate(1900,1,1));
    edtDataA.Text:=DateToStr(EncodeDate(3999,12,31));
    //Organismi
    cmbOrganismo.Items.Clear;
    selT245NoGEDAP.Open;
    selT245NoGEDAP.First;
    while not selT245NoGEDAP.Eof do
    begin
      cmbOrganismo.AddRow(selT245NoGEDAP.FieldByName('CODICE').AsString + ';' + selT245NoGEDAP.FieldByName('DESCRIZIONE').AsString);
      selT245NoGEDAP.Next;
    end;
    selT245NoGEDAP.First;
    cmbOrganismo.Text:='';
    //Sindacati
    cmbSindacato.Items.Clear;
    selT240NoGEDAP.Open;
    selT240NoGEDAP.First;
    while not selT240NoGEDAP.Eof do
    begin
      cmbSindacato.AddRow(selT240NoGEDAP.FieldByName('CODICE').AsString + ';' + selT240NoGEDAP.FieldByName('DESCRIZIONE').AsString);
      selT240NoGEDAP.Next;
    end;
    selT240NoGEDAP.First;
    cmbSindacato.Text:='';
    //Griglia
    AggiornaGriglia;
    dgrdNoGEDAP.medpComandiCustom:=not AccessoSolaLettura;
    dgrdNoGEDAP.medpAttivaGrid(selT248NoGEDAP,False,False,False);
    if not AccessoSolaLettura then
      dgrdNoGEDAP.medpPreparaComponenteGenerico('WR102-R',dgrdNoGEDAP.medpIndexColonna('DBG_COMANDI'),0,DBG_IMG,'','CONFERMA','','','');
    dgrdNoGEDAP.medpCaricaCDS;
    AbilitaComponenti;
    btnAnomalie.Enabled:=False;
  end;
end;

procedure TWA124FInvioPermessiFM.AggiornaGriglia;
begin
  (WR302DM as TWA124FPermessiSindacaliDM).A124MW.RecuperaNoGEDAP(StrToDate(edtDataDa.Text),
                                                                 StrToDate(edtDataA.Text),
                                                                 Trim(cmbOrganismo.Text),
                                                                 Trim(cmbSindacato.Text));
  if dgrdNoGEDAP.DataSource <> nil then
    dgrdNoGEDAP.medpAggiornaCDS;
end;

procedure TWA124FInvioPermessiFM.AbilitaComponenti;
begin
  btnImpostaPermessiVisInviati.Enabled:=not AccessoSolaLettura and ((WR302DM as TWA124FPermessiSindacaliDM).A124MW.selT248NoGEDAP.RecordCount > 0);
  btnEsegui.Enabled:=not AccessoSolaLettura and (Parametri.CampiRiferimento.C40_InvioGedap = 'S') and ((WR302DM as TWA124FPermessiSindacaliDM).A124MW.selT248NoGEDAP.RecordCount > 0);
end;

procedure TWA124FInvioPermessiFM.edtDataDaAsyncChange(Sender: TObject; EventParams: TStringList);
var dData:TDateTime;
begin
  if (edtDataDa.Text = '') or not TryStrToDate(edtDataDa.Text,dData) then
    edtDataDa.Text:=DateToStr(EncodeDate(1900,1,1));
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[btnFiltri.HTMLName]));
end;

procedure TWA124FInvioPermessiFM.edtDataAAsyncChange(Sender: TObject; EventParams: TStringList);
var dData:TDateTime;
begin
  if (edtDataA.Text = '') or not TryStrToDate(edtDataA.Text,dData) then
    edtDataA.Text:=DateToStr(EncodeDate(3999,12,31));
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[btnFiltri.HTMLName]));
end;

procedure TWA124FInvioPermessiFM.cmbSindacatoAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[btnFiltri.HTMLName]));
end;

procedure TWA124FInvioPermessiFM.btnFiltriClick(Sender: TObject);
begin
  AggiornaGriglia;
  AbilitaComponenti;
end;

procedure TWA124FInvioPermessiFM.dgrdNoGEDAPAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var r:Integer;
    img:TmeIWImageFile;
begin
  inherited;
  for r:=0 to High(dgrdNoGEDAP.medpCompGriglia) do
    if dgrdNoGEDAP.medpCompCella(r,dgrdNoGEDAP.medpIndexColonna('DBG_COMANDI'),0) <> nil then
    begin
      img:=(dgrdNoGEDAP.medpCompCella(r,dgrdNoGEDAP.medpIndexColonna('DBG_COMANDI'),0) as TmeIWImageFile);
      img.Enabled:=true;
      img.Hint:='Imposta permesso come inviato';
      img.OnClick:=imgConfermaClick;
    end;
end;

procedure TWA124FInvioPermessiFM.dgrdNoGEDAPRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var NumColonna: Integer;
begin
  if not dgrdNoGEDAP.medpRenderCell(ACell,ARow,AColumn,True,True,False) then
    Exit;

  NumColonna:=dgrdNoGEDAP.medpNumColonna(AColumn);
  // assegnazione componenti
  if (ARow > 0) and (ARow <= High(dgrdNoGEDAP.medpCompGriglia) + 1) and (dgrdNoGEDAP.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=dgrdNoGEDAP.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

procedure TWA124FInvioPermessiFM.imgConfermaClick(Sender: TObject);
var r: Integer;
begin
  r:=dgrdNoGEDAP.medpRigaDiCompGriglia((Sender as TmeIWImageFile).FriendlyName);
  with (WR302DM as TWA124FPermessiSindacaliDM).A124MW do
    if selT248NoGEDAP.SearchRecord('PROGRESSIVO;DATA;DALLE',VarArrayOf([StrToInt(dgrdNoGEDAP.medpValoreColonna(r,'PROGRESSIVO')),StrToDate(dgrdNoGEDAP.medpValoreColonna(r,'DATA')),dgrdNoGEDAP.medpValoreColonna(r,'DALLE')]),[srFromBeginning]) then
      ImpostaPermessoSelInviato;
  btnFiltriClick(nil);
end;

procedure TWA124FInvioPermessiFM.btnImpostaPermessiVisInviatiClick(Sender: TObject);
begin
  (WR302DM as TWA124FPermessiSindacaliDM).A124MW.ImpostaTuttiPermessiInviati;
  btnFiltriClick(nil);
end;

procedure TWA124FInvioPermessiFM.btnEseguiClick(Sender: TObject);
begin
  with (WR302DM as TWA124FPermessiSindacaliDM).A124MW do
    ControlliGeneraXmlGEDAP;
  (Self.Owner as TWA124FPermessiSindacali).StartElaborazioneServer(btnFiltri.HTMLName);
end;

procedure TWA124FInvioPermessiFM.btnAnomalieClick(Sender: TObject);
begin
  (Self.Owner as TWA124FPermessiSindacali).actAnomalieExecute(nil);
end;

end.
