unit WA156UNotificheIrisWEBBrowseFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR204UBrowseTabellaFM, Vcl.Menus,
  IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompGrids,
  IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, C190FunzioniGeneraliWeb, IWCompMemo, meIWMemo,Math,
  IWDBStdCtrls, meIWDBMemo, medpIWMultiColumnComboBox, meIWComboBox, Datasnap.DBClient;

type
  TWA156FNotificheIrisWEBBrowseFM = class(TWR204FBrowseTabellaFM)
    dmemNotificaSqlText: TmeIWDBMemo;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaComponenti2DataSet(Row: Integer);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses WA156UNotificheIrisWEBDM;

{$R *.dfm}

procedure TWA156FNotificheIrisWEBBrowseFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('NOTIFICA'),0,DBG_MECMB,'30','2','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('ATTIVO'),0,DBG_CMB,'2','','','','S');
  dmemNotificaSqlText.DataSource:=WR302DM.dsrTabella;
end;

procedure TWA156FNotificheIrisWEBBrowseFM.grdTabellaComponenti2DataSet(Row: Integer);
var
  IWCmb: TMedpIWMultiColumnComboBox;
  IWC: TmeIWComboBox;
begin
  inherited;

  IWCmb:=(grdTabella.medpCompCella(Row,'NOTIFICA',0) as TMedpIWMultiColumnComboBox);
  WR302DM.selTabella.FieldByName('NOTIFICA').AsString:=IWCmb.Text;

  IWC:=(grdTabella.medpCompCella(Row,'ATTIVO',0) as TmeIWComboBox);
  WR302DM.selTabella.FieldByName('ATTIVO').AsString:=IWC.Text;
end;

procedure TWA156FNotificheIrisWEBBrowseFM.grdTabellaDataSet2Componenti(Row: Integer);
var
  IWCmb: TMedpIWMultiColumnComboBox;
  IWC: TmeIWComboBox;
  LDS: TClientDataSet;
begin
  inherited;

  // combobox notifica
  IWCmb:=(grdTabella.medpCompCella(Row,'NOTIFICA',0) as TMedpIWMultiColumnComboBox);
  IWCmb.ColCount:=1;
  IWCmb.CustomElement:=False;
  IWCmb.PopUpHeight:=10;

  // popola elementi
  IWCmb.Items.Clear;
  LDS:=(WR302DM as TWA156FNotificheIrisWEBDM).A156MW.cdsProc;
  LDS.First;
  while not LDS.Eof do
  begin
    IWCmb.AddRow(Format('%s;%s',[LDS.FieldByName('NOME').AsString,LDS.FieldByName('NOME').AsString]));
    LDS.Next;
  end;

  // seleziona l'elemento corretto
  IWCmb.Text:=grdTabella.medpValoreColonna(Row,'NOTIFICA');

  //Attivo Si/No
  IWC:=(grdTabella.medpCompCella(Row,'ATTIVO',0) as TmeIWComboBox);
  if IWC <> nil then
  begin
    IWC.Items.Clear;
    IWC.NoSelectionText:='';
    IWC.Items.Add('S');
    IWC.Items.Add('N');
    IWC.ItemIndex:=Max(0,IWC.Items.IndexOf(grdTabella.medpValoreColonna(Row,'ATTIVO')));
  end;
end;

end.
