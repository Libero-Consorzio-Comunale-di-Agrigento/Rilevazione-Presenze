unit WA086UMotivazioniRichiesteBrowseFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  WR204UBrowseTabellaFM, Vcl.Menus, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompGrids, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, IWCompLabel,
  meIWLabel, IWCompListbox, meIWComboBox, C190FunzioniGeneraliWeb,
  meIWImageFile, meIWEdit, WC013UCheckListFM, C180FunzioniGenerali;

type
  TWA086FMotivazioniRichiesteBrowseFM = class(TWR204FBrowseTabellaFM)
    cmbTipo: TmeIWComboBox;
    lblTipo: TmeIWLabel;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure cmbTipoChange(Sender: TObject);
    procedure grdTabellamedpStatoChange;
    procedure grdTabellaComponenti2DataSet(Row: Integer);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
  private
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#3.ini
    WC013: TWC013FCheckListFM;
    procedure imgCausaliClick(Sender: TObject);
    procedure OnCausaliSelezionate(Sender: TObject; Result: Boolean);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#3.fine
  end;

implementation

{$R *.dfm}

uses WA086UMotivazioniRichieste,
     WA086UMotivazioniRichiesteDM,
     A086UMotivazioniRichiesteMW;

procedure TWA086FMotivazioniRichiesteBrowseFM.IWFrameRegionCreate(Sender: TObject);
var
  LA086MW: TA086FMotivazioniRichiesteMW;
begin
  inherited;
  cmbTipo.Items.Clear;

  // popola combobox dei tipi
  LA086MW:=(WR302DM as TWA086FMotivazioniRichiesteDM).A086MW;
  LA086MW.cdsTipologie.First;
  while not LA086MW.cdsTipologie.Eof do
  begin
    cmbTipo.Items.Add(Format('%s=%s',[LA086MW.cdsTipologie.FieldByName('DESCRIZIONE').AsString,LA086MW.cdsTipologie.FieldByName('CODICE').AsString]));
    LA086MW.cdsTipologie.Next;
  end;
  cmbTipo.ItemIndex:=0;
  cmbTipoChange(nil);

  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#3.ini
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('CAUSALI'),1,DBG_IMG,'','PUNTINI','','','');
  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#3.fine
end;

// EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#3.ini
procedure TWA086FMotivazioniRichiesteBrowseFM.grdTabellaComponenti2DataSet(Row: Integer);
begin
  inherited;
  if R180In(WR302DM.selTabella.FieldByName('TIPO').AsString,['T105C','T050']) then
    WR302DM.selTabella.FieldByName('CAUSALI').AsString:=(grdTabella.medpCompCella(Row,'CAUSALI',0) as TmeIWEdit).Text;
end;

procedure TWA086FMotivazioniRichiesteBrowseFM.grdTabellaDataSet2Componenti(Row: Integer);
begin
  inherited;
  if R180In(WR302DM.selTabella.FieldByName('TIPO').AsString,['T105C','T050']) then
  begin
    (grdTabella.medpCompCella(Row,'CAUSALI',0) as TmeIWEdit).Text:=WR302DM.selTabella.FieldByName('CAUSALI').AsString;
    (grdTabella.medpCompCella(Row,'CAUSALI',0) as TmeIWEdit).ReadOnly:=True;
    (grdTabella.medpCompCella(Row,'CAUSALI',1) as TmeIWImageFile).OnClick:=imgCausaliClick;
  end;
end;

procedure TWA086FMotivazioniRichiesteBrowseFM.imgCausaliClick(Sender: TObject);
var
  LName,LScript: String;
begin
  WC013:=TWC013FCheckListFM.Create(Self.Parent);
  WC013.ckList.Items.Clear;
  // causali di assenza
  WC013.ckList.Items.Add('Causali di assenza');
  WC013.ckList.IsEnabled[WC013.ckList.Items.Count - 1]:=False;
  LName:=Format('%s_CHK_%d',[WC013.ckList.HTMLName,WC013.ckList.Items.Count]);
  LScript:=Format('$("#%s").hide(); $("#%s").parent().addClass("wa086_td_header");',[LName,LName]);
  WC013.ckList.Items.AddStrings((WR302DM as TWA086FMotivazioniRichiesteDM).A086MW.ListaCausaliAss);
  // causali di presenza
  WC013.ckList.Items.Add('Causali di presenza');
  WC013.ckList.IsEnabled[WC013.ckList.Items.Count - 1]:=False;
  LName:=Format('%s_CHK_%d',[WC013.ckList.HTMLName,WC013.ckList.Items.Count]);
  LScript:=LScript + #13#10 + Format('$("#%s").hide(); $("#%s").parent().addClass("wa086_td_header");',[LName,LName]);
  WC013.ckList.Items.AddStrings((WR302DM as TWA086FMotivazioniRichiesteDM).A086MW.ListaCausaliPres);
  // seleziona causali
  C190PutCheckList(WR302DM.selTabella.FieldByName('CAUSALI').AsString,5,WC013.ckList);
  WC013.ResultEvent:=OnCausaliSelezionate;
  WC013.Visualizza(0,0,'Scelta causali');
  (Self.Owner as TWA086FMotivazioniRichieste).AddToInitProc(LScript);
end;

procedure TWA086FMotivazioniRichiesteBrowseFM.OnCausaliSelezionate(Sender: TObject; Result: Boolean);
var
  LElencoCausali: String;
begin
  if Result then
  begin
    LElencoCausali:=C190GetCheckList(5,WC013.ckList);
    (grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo - 1,'CAUSALI',0) as TmeIWEdit).Text:=LElencoCausali;
    WR302DM.selTabella.FieldByName('CAUSALI').AsString:=LElencoCausali;
  end;
end;
// EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#3.ini

procedure TWA086FMotivazioniRichiesteBrowseFM.grdTabellamedpStatoChange;
begin
  inherited;
  cmbTipo.Enabled:=(grdTabella.medpStato = msBrowse);
end;

procedure TWA086FMotivazioniRichiesteBrowseFM.cmbTipoChange(Sender: TObject);
var
  LDM: TWA086FMotivazioniRichiesteDM;
  Codice: String;
begin
  // filtra dataset delle motivazioni
  LDM:=(WR302DM as TWA086FMotivazioniRichiesteDM);
  Codice:='';
  if cmbTipo.ItemIndex <> -1 then
    Codice:=cmbTipo.Items.ValueFromIndex[cmbTipo.ItemIndex];
  LDM.A086MW.FiltraSelT106(Codice);

  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#3.ini
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('CAUSALI'),1,DBG_IMG,'','PUNTINI','Scelta causali','','');
  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#3.fine

  // aggiorna tabella visualizzazione
  grdTabella.medpAttivaGrid(WR302DM.selTabella,False,False);
end;

end.
