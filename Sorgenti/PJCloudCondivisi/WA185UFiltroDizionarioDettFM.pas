unit WA185UFiltroDizionarioDettFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR205UDettTabellaFM, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWDBExtCtrls, IWCompEdit,
  IWDBStdCtrls, meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompLabel, meIWDBRadioGroup, IWCompListbox, meIWDBLookupComboBox,
  meIWDBComboBox, meIWDBLabel,
  meIWLabel, IWCompCheckbox, meIWDBCheckBox, A000UInterfaccia, Menus,
  IWAdvCheckGroup, meTIWAdvCheckGroup, meIWCheckBox, C180FunzioniGenerali,
  C190FunzioniGeneraliWeb, IWCompButton, meIWButton,
  IWDBGrids, medpIWDBGrid, DB, DBClient, StdCtrls,
  IWCompMemo, meIWMemo, Oracle, OracleData, StrUtils,
  A000UCostanti, A000USessione, medpIWMessageDlg, meIWComboBox, IWAdvRadioGroup,
  meTIWAdvRadioGroup, R500Lin, IWCompExtCtrls, IWCompJQueryWidget, meIWImageFile;

type
  TWA185FFiltroDizionarioDettFM = class(TWR205FDettTabellaFM)
    lblPermesso: TmeIWLabel;
    dedtPermesso: TmeIWDBEdit;
    lblAzienda: TmeIWLabel;
    dcmbAzienda: TmeIWDBLookupComboBox;
    lblTabella: TmeIWLabel;
    cmbDizionario: TmeIWComboBox;
    cgpDizionario: TmeTIWAdvCheckGroup;
    imgSelezionaTutto: TmeIWImageFile;
    imgDeselezionaTutto: TmeIWImageFile;
    imgInvertiSelezione: TmeIWImageFile;
    rgpModalitaFiltro: TmeTIWAdvRadioGroup;
    pmnAzioni: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure imgSelezionaTuttoAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure imgDeselezionaTuttoAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure imgInvertiSelezioneAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure cmbDizionarioChange(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Deselezionatutto1Click(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
  private
  public
    procedure DataSet2Componenti; override;
    procedure AbilitaComponenti; override;
  end;

implementation

uses WA185UFiltroDizionarioDM, WA185UFiltroDizionario, WR100UBase;

{$R *.dfm}

procedure TWA185FFiltroDizionarioDettFM.Invertiselezione1Click(Sender: TObject);
begin
  inherited;
  imgInvertiSelezioneAsyncClick(Sender,nil);
end;

procedure TWA185FFiltroDizionarioDettFM.IWFrameRegionCreate(Sender: TObject);
var T:TTabelleDizionario;
begin
  dcmbAzienda.ListSource:=TWA185FFiltroDizionarioDM(TWA185FFiltroDizionario(Self.Owner).WR302DM).D090;
  inherited;
  dcmbAzienda.DataSource:=TWA185FFiltroDizionarioDM(TWA185FFiltroDizionario(Self.Owner).WR302DM).dsrI074;
  dedtPermesso.DataSource:=TWA185FFiltroDizionarioDM(TWA185FFiltroDizionario(Self.Owner).WR302DM).dsrI074;
  cmbDizionario.Items.Clear;
  for T in TabelleDizionario do
    cmbDizionario.Items.Add(T.DescTabella);
  cmbDizionario.Sorted:=True;
end;

procedure TWA185FFiltroDizionarioDettFM.Selezionatutto1Click(Sender: TObject);
begin
  inherited;
  imgSelezionaTuttoAsyncClick(Sender,nil);
end;

procedure TWA185FFiltroDizionarioDettFM.DataSet2Componenti;
var
  i : Integer;
begin
  cgpDizionario.Items.Clear;
  with TWA185FFiltroDizionarioDM(WR302DM) do
  begin
    if cmbDizionario.Text <> 'ANOMALIE DEI CONTEGGI' then
      begin
        if selDizionario.Active then
        begin
          selDizionario.Filtered:=False;
          selDizionario.Filter:='TABELLA = ''' + cmbDizionario.Text + '''';
          selDizionario.Filtered:=True;
          selDizionario.First;
          while not selDizionario.Eof do
          begin
            cgpDizionario.Items.Add(IfThen(cmbDizionario.Text = 'ITER AUTORIZZATIVI',
                                           A000GetDescIter(selDizionario.FieldByName('CODICE').AsString),
                                           selDizionario.FieldByName('CODICE').AsString));
            selDizionario.Next;
          end;
        end;
      end
    else
    begin
      for i:=low(tdescanom2) to High(tdescanom2) do
        cgpDizionario.Items.Add(R180DimLung('A2_' + IntToStr(tdescanom2[i].N),6) + ' ' + tdescanom2[i].D);
      for i:=low(tdescanom3) to High(tdescanom3) do
        cgpDizionario.Items.Add(R180DimLung('A3_' + IntToStr(tdescanom3[i].N),6) + ' ' + tdescanom3[i].D);
    end;

    for i:=0 to cgpDizionario.Items.Count - 1 do
      if cmbDizionario.Text <> 'ANOMALIE DEI CONTEGGI' then
        cgpDizionario.IsChecked[i]:=selI074.SearchRecord('TABELLA;CODICE',VarArrayOf([cmbDizionario.Text,IfThen(cmbDizionario.Text = 'ITER AUTORIZZATIVI',
                                                                                                                      A000GetCodIter(cgpDizionario.Items[i]),
                                                                                                                      cgpDizionario.Items[i])]),[srFromBeginning])
      else
        cgpDizionario.IsChecked[i]:=selI074.SearchRecord('TABELLA;CODICE',VarArrayOf([cmbDizionario.Text,Trim(copy(cgpDizionario.Items[i],1,5))]),[srFromBeginning]);

    if selI074.Lookup('TABELLA',cmbDizionario.Text,'ABILITATO') = 'S' then
      rgpModalitaFiltro.ItemIndex:=0
    else
      rgpModalitaFiltro.ItemIndex:=1;
  end;
end;

procedure TWA185FFiltroDizionarioDettFM.Deselezionatutto1Click(Sender: TObject);
begin
  inherited;
  imgDeselezionaTuttoAsyncClick(Sender,nil);
end;

procedure TWA185FFiltroDizionarioDettFM.AbilitaComponenti;
begin
  //la combo dizionario deve essere abilitata in browse e disabilita in insert e edit
  cmbDizionario.Enabled:=TWA185FFiltroDizionarioDM(WR302DM).selI074.State = dsBrowse;
end;

procedure TWA185FFiltroDizionarioDettFM.cmbDizionarioChange(Sender: TObject);
begin
  DataSet2Componenti;
end;

procedure TWA185FFiltroDizionarioDettFM.imgDeselezionaTuttoAsyncClick(
  Sender: TObject; EventParams: TStringList);
var
  i:Integer;
begin
  inherited;
  for i:=0 to cgpDizionario.Items.Count - 1 do
    cgpDizionario.IsChecked[i]:=False;
  cgpDizionario.AsyncUpdate;
end;

procedure TWA185FFiltroDizionarioDettFM.imgInvertiSelezioneAsyncClick(
  Sender: TObject; EventParams: TStringList);
var
  i:Integer;
begin
  inherited;
  for i:=0 to cgpDizionario.Items.Count - 1 do
    cgpDizionario.IsChecked[i]:=not cgpDizionario.IsChecked[i];
  cgpDizionario.AsyncUpdate;
end;

procedure TWA185FFiltroDizionarioDettFM.imgSelezionaTuttoAsyncClick(
  Sender: TObject; EventParams: TStringList);
var
 i:Integer;
begin
  inherited;
  for i:=0 to cgpDizionario.Items.Count - 1 do
    cgpDizionario.IsChecked[i]:=True;
  cgpDizionario.AsyncUpdate;
end;

end.
