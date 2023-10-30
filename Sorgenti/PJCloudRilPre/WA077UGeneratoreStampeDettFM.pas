unit WA077UGeneratoreStampeDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR003UGeneratoreStampeDettFM,
  IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWCompEdit,
  IWDBStdCtrls, meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompLabel, meIWLabel, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompListbox, meIWComboBox,
  IWCompCheckbox, meIWDBCheckBox, meIWListbox, IWCompGrids, meIWGrid,
  medpIWTabControl, meIWRegion, Vcl.Menus, IWCompExtCtrls, IWDBExtCtrls,
  meIWDBRadioGroup, meIWCheckBox, IWMultiColumnComboBox,
  medpIWMultiColumnComboBox, IWCompButton, meIWButton, meIWDBLookupComboBox,
  IWDBGrids, medpIWDBGrid, IWCompMemo, meIWMemo, meIWEdit, IWTMSCheckList,
  meTIWCheckListBox, WR003UGeneratoreStampe, WA077UGeneratoreStampeDM, Data.DB,
  C180FunzioniGenerali, A000UInterfaccia, meIWImageFile;

type
  TWA077FGeneratoreStampeDettFM = class(TWR003FGeneratoreStampeDettFM)
    chklstIndPresenza: TmeTIWCheckListBox;
    chklstPresenza: TmeTIWCheckListBox;
    chklstAssenze: TmeTIWCheckListBox;
    chklstRimborsi: TmeTIWCheckListBox;
    chklstVociPaghe: TmeTIWCheckListBox;
    chklstCorsiFormazione: TmeTIWCheckListBox;
    chklstIscrizioniSindacali: TmeTIWCheckListBox;
    chklstPartecipazioniSindacali: TmeTIWCheckListBox;
    chklstPermessiSindacali: TmeTIWCheckListBox;
    lblRecapitoSindacato: TmeIWLabel;
    cmbRecapitoSindacato11: TMedpIWMultiColumnComboBox;
    cmbRecapitoSindacato12: TMedpIWMultiColumnComboBox;
    cmbRecapitoSindacato13: TMedpIWMultiColumnComboBox;
    pmnCorsiFormazione: TPopupMenu;
    mnuElementiSelezionatiInAlto1: TMenuItem;
    mnuVisualizzaCorsiAnno: TMenuItem;
    chkConteggiGGIter: TmeIWCheckBox;
    procedure cmbSerbatoiChange(Sender: TObject);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure mnuVisualizzaCorsiAnnoClick(Sender: TObject);
    procedure mnuElementiSelezionatiInAlto1Click(Sender: TObject);
  protected
    function getControlOpzioneAvanzata(Val: String): TControl; override;
    procedure CaricaCheckListCodici(chk: TmeTIWChecklistBox); override;
  public
    procedure AbilitaComponenti; override;
    function getCheckListBoxTabellaCollegata(M: Integer): TListaCodici; override;
  end;

implementation

{$R *.dfm}

procedure TWA077FGeneratoreStampeDettFM.cmbSerbatoiChange(Sender: TObject);
begin
  inherited;
  cmbRecapitoSindacato11.Visible:=cmbSerbatoi.ItemIndex = 14;
  cmbRecapitoSindacato12.Visible:=cmbSerbatoi.ItemIndex = 15;
  cmbRecapitoSindacato13.Visible:=cmbSerbatoi.ItemIndex = 16;
  lblRecapitoSindacato.Visible:=(cmbRecapitoSindacato11.Visible) or
                                (cmbRecapitoSindacato12.Visible) or
                                (cmbRecapitoSindacato13.Visible);

  edtDalleOre.Visible:=cmbSerbatoi.ItemIndex = 6;
  edtAlleOre.Visible:=cmbSerbatoi.ItemIndex = 6;
  lblDalleOre.Visible:=cmbSerbatoi.ItemIndex = 6;
  lblAlleOre.Visible:=cmbSerbatoi.ItemIndex = 6;
end;

function TWA077FGeneratoreStampeDettFM.getCheckListBoxTabellaCollegata(
  M: Integer): TListaCodici;
begin
  case M of
    1:  //Ind.Presenza
      begin
        Result.chklst:=chklstIndPresenza;
        Result.Lunghezza:=5;
      end;
    2:  //Causali di presenza
      begin
        Result.chklst:=chklstPresenza;
        Result.Lunghezza:=5;
      end;
    3:  //Causali di assenza
      begin
        Result.chklst:=chklstAssenze;
        Result.Lunghezza:=5;
      end;
    7:  //Missioni:Rimborsi
      begin
        Result.chklst:=chklstRimborsi;
        Result.Lunghezza:=5;
      end;
    8:  //Voci paghe scaricate
      begin
        Result.chklst:=chklstVociPaghe;
        Result.Lunghezza:=6;
      end;
    10: //Corsi di formazione
      begin
        Result.chklst:=chklstCorsiFormazione;
        Result.Lunghezza:=20;
      end;
    11: //Iscrizioni ai sindacati (organizzazioni sindacali)
      begin
        Result.chklst:=chklstIscrizioniSindacali;
        Result.Lunghezza:=10;
      end;
    12: //Organismi sindacali
      begin
        Result.chklst:=chklstPartecipazioniSindacali;
        Result.Lunghezza:=10;
      end;
    13: //Permessi sindacali
      begin
        Result.chklst:=chklstPermessiSindacali;
        Result.Lunghezza:=10;
      end;
    else
      Result.chklst:=nil;
  end;
end;

function TWA077FGeneratoreStampeDettFM.getControlOpzioneAvanzata(
  Val: String): TControl;
begin
  Result:=nil;
  if val = 'REC_SINDACATO_11' then
    Result:=cmbRecapitoSindacato11
  else if val = 'REC_SINDACATO_12' then
    Result:=cmbRecapitoSindacato12
  else if val = 'REC_SINDACATO_13' then
    Result:=cmbRecapitoSindacato13
  else if val = 'CONTEGGI_GG_DALLE' then
    Result:=edtDalleOre
  else if val = 'CONTEGGI_GG_ALLE' then
    Result:=edtAlleOre
  else if val = 'CONTEGGI_GG_ITER' then
    Result:=chkConteggiGGIter;
end;

procedure TWA077FGeneratoreStampeDettFM.AbilitaComponenti;
begin
  inherited;
  //per corsi formazione sostituisco  il context menu con uno specifico per
  //la visione annuale.
  //Quando passo da edit a browse AbilitaComponenti ereditato da Wr003 fa già il ricaricamento
  //con tutti i corsi. Percio mi preoccupo solo di resettare il check del menuitem
  if chklstCorsiFormazione.medpContextMenu <> nil then
    chklstCorsiFormazione.medpContextMenu:=pmnCorsiFormazione;

  if WR302DM.selTabella.State = dsBrowse then
  begin
    mnuVisualizzaCorsiAnno.Checked:=False;
    mnuElementiSelezionatiInAlto1.Checked:=False;
  end;
end;

procedure TWA077FGeneratoreStampeDettFM.CaricaCheckListCodici(chk: TmeTIWChecklistBox);
var
  lst: TStringList;
  s: String;
begin
  with (WR302DM as TWA077FGeneratoreStampeDM).A077FGeneratoreStampeMW do
  begin
    if chk = chklstAssenze then
      lst:=getListAssenze
    else if chk = chklstPresenza then
      lst:=getListPresenze
    else if chk = chklstIndPresenza then
      lst:=getListIndPresenza
    else if chk = chklstRimborsi then
      lst:=getListRimborsi
    else if chk = chklstVociPaghe then
      lst:=getListVociPaghe
    else if chk = chklstIscrizioniSindacali then
      lst:=getListOrgSindacali
    else if chk = chklstPartecipazioniSindacali then
      lst:=getListOrgSindacali
    else if chk = chklstPermessiSindacali then
      lst:=getListOrgSindacali
    else if chk = chklstCorsiFormazione then
      lst:=getListCorsiFormazione(True,0);

    chk.UnCheckAll;
    chk.Items.Clear;
    try
      for s in lst do
        chk.Items.Add(s);
    finally
      FreeAndNil(lst);
    end;
  end;
end;

procedure TWA077FGeneratoreStampeDettFM.IWFrameRegionCreate(Sender: TObject);
var
  lst: TStringList;
  s: String;
begin
  inherited;
  CaricaCheckListCodici(chklstAssenze);
  CaricaCheckListCodici(chklstPresenza);
  CaricaCheckListCodici(chklstIndPresenza);
  CaricaCheckListCodici(chklstRimborsi);
  CaricaCheckListCodici(chklstVociPaghe);
  CaricaCheckListCodici(chklstIscrizioniSindacali);
  CaricaCheckListCodici(chklstPartecipazioniSindacali);
  CaricaCheckListCodici(chklstPermessiSindacali);
  CaricaCheckListCodici(chklstCorsiFormazione);

  with (WR302DM as TWA077FGeneratoreStampeDM).A077FGeneratoreStampeMW do
  begin
    lst:=getListRecapitoSindacato;
    try
      for s in lst do
      begin
        cmbRecapitoSindacato11.AddRow(s);
        cmbRecapitoSindacato12.AddRow(s);
        cmbRecapitoSindacato13.AddRow(s);
      end;
    finally
      FreeAndNil(lst);
    end;
  end;
end;

procedure TWA077FGeneratoreStampeDettFM.mnuElementiSelezionatiInAlto1Click(
  Sender: TObject);
begin
  inherited;
  mnuElementiSelezionatiInAltoClick(mnuElementiSelezionatiInAlto);
  mnuElementiSelezionatiInAlto1.Checked:=mnuElementiSelezionatiInAlto.Checked;
end;

procedure TWA077FGeneratoreStampeDettFM.mnuVisualizzaCorsiAnnoClick(
  Sender: TObject);
var
  Anno, i: Integer;
  Lst,lstSelected: TStringList;
  s: String;
begin
  mnuVisualizzaCorsiAnno.Checked:=not mnuVisualizzaCorsiAnno.Checked;

  //Salvo items selezionati
  lstSelected:=TStringList.Create;
  try
    for i:=0 to chklstCorsiFormazione.Items.Count - 1 do
    begin
      if chklstCorsiFormazione.Selected[i] then
        lstSelected.Add(chklstCorsiFormazione.Items[i]);
    end;
    chklstCorsiFormazione.UnCheckAll;
    chklstCorsiFormazione.Items.Clear;
    try
      Anno:=R180Anno(StrToDate((Self.Owner as TWR003FGeneratoreStampe).edtAl.Text));
    except
      Anno:=R180Anno(Parametri.DataLavoro);
    end;
    mnuVisualizzaCorsiAnno.Caption:='Visualizza solo i corsi dell''anno';
    if mnuVisualizzaCorsiAnno.Checked then
      mnuVisualizzaCorsiAnno.Caption:=mnuVisualizzaCorsiAnno.Caption + ' ' + IntToStr(Anno);

    Lst:=(WR302DM as TWA077FGeneratoreStampeDM).A077FGeneratoreStampeMW.getListCorsiFormazione(not mnuVisualizzaCorsiAnno.Checked,Anno);
    try
      for s in Lst do
        chklstCorsiFormazione.Items.Add(s);
    finally
      FreeAndNil(lst);
    end;

    for i:=0 to chklstCorsiFormazione.Items.Count - 1 do
    begin
      if lstSelected.IndexOf(chklstCorsiFormazione.Items[i])>=0 then
        chklstCorsiFormazione.Selected[i]:=True;
    end;
  finally
    FreeAndNil(lstSelected);
  end;
end;

end.
