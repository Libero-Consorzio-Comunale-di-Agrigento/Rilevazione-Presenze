unit WA136URelazioniAnagrafeDettFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompListbox, IWDBStdCtrls, meIWDBComboBox,
  IWCompLabel, meIWLabel,WA136URelazioniAnagrafeDM, IWCompMemo, meIWMemo,
  meIWDBLookupComboBox, IWCompEdit, meIWDBEdit, WR102UGestTabella,
  DB, IWCompExtCtrls, meIWImageFile, medpIWMessageDlg,A000UInterfaccia,
  medpIWMultiColumnComboBox;

type
  TWA136FRelazioniAnagrafeDettFM = class(TWR205FDettTabellaFM)
    lblTabella: TmeIWLabel;
    memoRelazione: TmeIWMemo;
    lblColonna: TmeIWLabel;
    lblOrdine: TmeIWLabel;
    dedtOrdine: TmeIWDBEdit;
    lblTipo: TmeIWLabel;
    lblDescTipo: TmeIWLabel;
    lblTabOrigine: TmeIWLabel;
    lblRelazione: TmeIWLabel;
    imgVerifica: TmeIWImageFile;
    cmbTabella: TMedpIWMultiColumnComboBox;
    cmbColonna: TMedpIWMultiColumnComboBox;
    cmbTipo: TMedpIWMultiColumnComboBox;
    cmbTabOrigine: TMedpIWMultiColumnComboBox;
    lblColOrigine: TmeIWLabel;
    edtColOrigine: TmeIWDBEdit;
    procedure cmbTabellaAsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure cmbColonnaAsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure cmbTabOrigineAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure cmbTipoAsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure imgVerificaClick(Sender: TObject);
  private
    { Private declarations }
    procedure CaricaComboColonna;
  public
    procedure Dataset2Componenti; override;
    procedure Componenti2Dataset; override;
    procedure AbilitaComponenti; override;
    procedure CaricaMultiColumnCombobox; override;
  end;

implementation uses WA136URelazioniAnagrafe;

{$R *.dfm}

{ TWA136FRelazioniAnagrafeDettFM }

procedure TWA136FRelazioniAnagrafeDettFM.IWFrameRegionCreate(Sender: TObject);
var
  i: Integer;
begin
  //items sempre presenti.
  cmbTabella.medpAutoResetItems:=False;
  cmbTipo.medpAutoResetItems:=False;
  cmbTabOrigine.medpAutoResetItems:=False;
  inherited;
  with TWA136FRelazioniAnagrafeDM(WR302DM).A136FRelazioniAnagrafeMW do
    for i:=0 to Length(TipiRelazione) - 1 do
      cmbTipo.AddRow(TipiRelazione[i] +';'+ DescrizioneTipo(TipiRelazione[i]));
end;
procedure TWA136FRelazioniAnagrafeDettFM.Dataset2Componenti;
begin
  inherited;
  with TWA136FRelazioniAnagrafeDM(WR302DM) do
  begin
    cmbTabella.ItemIndex:=-1;
    cmbTabella.Text:=selTabella.FieldByName('TABELLA').AsString;
    cmbTabella.Enabled:=(selTabella.State = dsInsert) and not (Self.Owner as TWR102FGestTabella).InterfacciaWR102.StoricizzazioneInCorso;
    cmbColonna.ItemIndex:=-1;
    cmbColonna.Text:=selTabella.FieldByName('COLONNA').AsString;
    cmbColonna.Enabled:=(selTabella.State = dsInsert) and not (Self.Owner as TWR102FGestTabella).InterfacciaWR102.StoricizzazioneInCorso;
    cmbTipo.ItemIndex:=-1;
    cmbTipo.Text:=selTabella.FieldByName('TIPO').AsString;
    lblDescTipo.Caption:=selTabella.FieldByName('D_TIPO').AsString;
    cmbTabOrigine.ItemIndex:=-1;
    cmbTabOrigine.Text:=selTabella.FieldByName('TAB_ORIGINE').AsString;

    memoRelazione.Clear;
    if (selTabella.State <> dsInsert) or (Self.Owner as TWR102FGestTabella).InterfacciaWR102.StoricizzazioneInCorso then
      memoRelazione.Lines.Assign(DettaglioRelazione);
    //Esegue abilita componenti per abilitare/disabilitare tab di componi relazione
    AbilitaComponenti;
  end;
end;

procedure TWA136FRelazioniAnagrafeDettFM.imgVerificaClick(Sender: TObject);
var
  msg: String;
begin
  msg:=TWA136FRelazioniAnagrafeDM(WR302DM).A136FRelazioniAnagrafeMW.VerificaSQLRelazione(memoRelazione.Text);
  MsgBox.WebMessageDlg(msg,mtInformation,[mbOK],nil,'');
end;

procedure TWA136FRelazioniAnagrafeDettFM.AbilitaComponenti;
var
  ColOri,MemRel: String;
  CamAbi,bBrowse,bModifica,bStoricizza: Boolean;
begin
  inherited;
  with TWA136FRelazioniAnagrafeDM(WR302DM) do
  begin
    CamAbi:=A136FRelazioniAnagrafeMW.VerificaCampiAbilitati((Self.Owner as TWA136FRelazioniAnagrafe).SolaLettura);
    ColOri:=Trim(selTabella.FieldByName('COL_ORIGINE').AsString);
    MemRel:=memoRelazione.Text;
    memoRelazione.Editable:=WR302DM.selTabella.State = dsEdit;

    bBrowse:=dsrTabella.State = dsBrowse;
    bModifica:=(not (Self.Owner as TWA136FRelazioniAnagrafe).SolaLettura) and CamAbi and bBrowse;
    bStoricizza:=bModifica and selTabella.Active and (selTabella.RecordCount > 0);
    (Self.Owner as TWA136FRelazioniAnagrafe).actModifica.Enabled:=bModifica;
    (Self.Owner as TWA136FRelazioniAnagrafe).actElimina.Enabled:=bModifica;
    (Self.Owner as TWA136FRelazioniAnagrafe).AggiornaToolBar((Self.Owner as TWA136FRelazioniAnagrafe).grdNavigatorBar,(Self.Owner as TWA136FRelazioniAnagrafe).actlstNavigatorBar);
    (Self.Owner as TWA136FRelazioniAnagrafe).AggiornaToolBarStorico(not bBrowse, not bBrowse, not bBrowse, False, False, bStoricizza);
    {TODO condizione copiata da IrisWIN. Vedere se semplificabile }
    TWA136FRelazioniAnagrafe(Self.Owner).AbilitaComponiRelazione((TWA136FRelazioniAnagrafe(Self.Owner).SolaLettura and (ColOri <> '')) or
                                                                 ((not TWA136FRelazioniAnagrafe(Self.Owner).SolaLettura) and (dsrTabella.State <> dsBrowse) and ((ColOri <> '') or ((ColOri  = '') and (MemRel = '')))) or
                                                                 ((not TWA136FRelazioniAnagrafe(Self.Owner).SolaLettura) and (dsrTabella.State = dsBrowse) and not CamAbi));

    TWA136FRelazioniAnagrafe(Self.Owner).AbilitaStampaRelazione(WR302DM.selTabella.State = dsBrowse);
  end;
  imgVerifica.Enabled:=True;//Forzatura per lasciarlo abilitato quando si è in browse
end;

procedure TWA136FRelazioniAnagrafeDettFM.CaricaComboColonna;
var
  nomeTabella: String;
begin
  nomeTabella:=TWA136FRelazioniAnagrafeDM(WR302DM).selTabella.FieldByName('TABELLA').AsString;
  with TWA136FRelazioniAnagrafeDM(WR302DM).A136FRelazioniAnagrafeMW do
  begin
    selCols.Close;
    selCols.setVariable('TABELLA',nomeTabella);
    selCols.setVariable('PILOTA','N');
    selCols.Open;
    selCols.First;
    cmbColonna.Items.clear;
    while not selCols.Eof do
    begin
      CmbColonna.addRow(selCols.FieldByName('COLUMN_NAME').AsString);
      selCols.Next;
    end;
    selCols.Close;
  end;
end;

procedure TWA136FRelazioniAnagrafeDettFM.CaricaMultiColumnCombobox;
begin
  CaricaComboColonna;
end;

procedure TWA136FRelazioniAnagrafeDettFM.cmbTabellaAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  TWA136FRelazioniAnagrafeDM(WR302DM).selTabella.FieldByName('TABELLA').AsString:=cmbTabella.Text;
  cmbTabOrigine.Text:=cmbTabella.Text;
  TWA136FRelazioniAnagrafeDM(WR302DM).selTabella.FieldByName('TAB_ORIGINE').AsString:=cmbTabOrigine.Text;
  CaricaComboColonna;
  //RESET COMBO
  cmbColonna.ItemIndex:=-1;
  cmbColonna.Text:='';
end;

procedure TWA136FRelazioniAnagrafeDettFM.cmbColonnaAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  TWA136FRelazioniAnagrafeDM(WR302DM).selTabella.FieldByName('COLONNA').AsString:=cmbColonna.Text;
end;

procedure TWA136FRelazioniAnagrafeDettFM.cmbTabOrigineAsyncChange(
  Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  TWA136FRelazioniAnagrafeDM(WR302DM).selTabella.FieldByName('TAB_ORIGINE').AsString:=cmbTabOrigine.Text;
end;

procedure TWA136FRelazioniAnagrafeDettFM.cmbTipoAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with TWA136FRelazioniAnagrafeDM(WR302DM) do
  begin
    selTabella.FieldByName('TIPO').AsString:=cmbTipo.Text;
    lblDescTipo.Caption:=selTabella.FieldByName('D_TIPO').AsString;
  end;
end;

procedure TWA136FRelazioniAnagrafeDettFM.Componenti2Dataset;
begin
  with TWA136FRelazioniAnagrafeDM(WR302DM) do
  begin
    selTabella.FieldByName('TABELLA').AsString:=cmbTabella.Text;
    selTabella.FieldByName('COLONNA').AsString:=cmbColonna.Text;
    selTabella.FieldByName('TIPO').AsString:=cmbTipo.Text;
    selTabella.FieldByName('TAB_ORIGINE').AsString:=cmbTabOrigine.Text;
    DettaglioRelazione:=memoRelazione.Lines;
  end;
end;

end.
