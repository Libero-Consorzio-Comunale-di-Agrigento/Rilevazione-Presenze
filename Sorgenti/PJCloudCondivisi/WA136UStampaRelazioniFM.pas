unit WA136UStampaRelazioniFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR200UBaseFM, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompLabel, meIWLabel, IWCompEdit, meIWEdit,
  A000UInterfaccia,WR100UBase, IWApplication,
  IWCompCheckbox, meIWCheckBox, IWCompGrids, IWDBGrids,
  meIWDBGrid,C190FunzioniGeneraliWeb, IWCompExtCtrls, meIWImageFile,
  medpIWDBGrid,A000UMessaggi,medpIWMessageDlg,StrUtils,DB, medpIWImageButton,
  medpIWMultiColumnComboBox, Vcl.Menus, WR010UBase;

type
  TWA136FStampaRelazioniFM = class(TWR200FBaseFM)
    lblDataStampa: TmeIWLabel;
    edtDataStampa: TmeIWEdit;
    lblStruttura: TmeIWLabel;
    lblTabella: TmeIWLabel;
    lblColonnaPartenza: TmeIWLabel;
    lblColonnaArrivo: TmeIWLabel;
    lblLivelli: TmeIWLabel;
    edtLivelliDaEstrarre: TmeIWEdit;
    lblTipoRelazione: TmeIWLabel;
    chkTipoRelS: TmeIWCheckBox;
    chkTipoRelL: TmeIWCheckBox;
    lblColonne: TmeIWLabel;
    chkDecorrenza: TmeIWCheckBox;
    chkNomeCampo: TmeIWCheckBox;
    chkCodice: TmeIWCheckBox;
    chkDescrizione: TmeIWCheckBox;
    imgEsegui: TmeIWImageFile;
    grdStampaRelazioni: TmedpIWDBGrid;
    lblEstrazioneRelazioni: TmeIWLabel;
    imbEsegui: TmedpIWImageButton;
    cmbTabella: TMedpIWMultiColumnComboBox;
    cmbColonnaPartenza: TMedpIWMultiColumnComboBox;
    cmbColonnaArrivo: TMedpIWMultiColumnComboBox;
    pmnGrdStampaRelazioni: TPopupMenu;
    actScaricaInExcel1: TMenuItem;
    actScaricainCSV1: TMenuItem;
    procedure cmbTabellaAsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure cmbColonnaPartenzaAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure imgEseguiClick(Sender: TObject);
    procedure grdStampaRelazioniRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure actScaricaInExcel1Click(Sender: TObject);
    procedure actScaricainCSV1Click(Sender: TObject);
  private
    ColonnePilotate: String;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
  public
    procedure CaricaDatiIniziali;
    procedure ReleaseOggetti; override;
  end;

implementation
  uses WA136URelazioniAnagrafeDM,WA136URelazioniAnagrafe;

{$R *.dfm}
procedure TWA136FStampaRelazioniFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdStampaRelazioni.medpRowSelect:=False;
end;

procedure TWA136FStampaRelazioniFM.actScaricainCSV1Click(Sender: TObject);
begin
  if not Assigned(Sender) then
    (Self.Owner as TWR010FBase).csvDownload:=grdStampaRelazioni.ToCsv
  else
    (Self.Owner as TWR010FBase).InviaFile('relazioni.xls',(Self.Owner as TWR010FBase).csvDownload);
end;

procedure TWA136FStampaRelazioniFM.actScaricaInExcel1Click(Sender: TObject);
begin
  if not Assigned(Sender) then
    (Self.Owner as TWR010FBase).streamDownload:=grdStampaRelazioni.ToXlsx
  else
    (Self.Owner as TWR010FBase).InviaFile('relazioni.xlsx',(Self.Owner as TWR010FBase).streamDownload);
end;

procedure TWA136FStampaRelazioniFM.CaricaDatiIniziali;
var
  ListTabelle: TStringList;
  i: Integer;
begin
  edtDataStampa.Text:=FormatDateTime('dd/mm/yyyy',Parametri.DataLavoro);

  with TWA136FRelazioniAnagrafeDM(WR302DM) do
  begin
    selTabella.AfterScroll:=nil;
    ListTabelle:=TStringList.Create();
    cmbTabella.Items.Clear;
    A136FRelazioniAnagrafeMW.ElencoTabelleStampa(ListTabelle);
    for i:=0 to ListTabelle.Count - 1 do
      cmbTabella.AddRow(ListTabelle[i]);
    cmbTabella.Text:='';
    FreeAndNil(ListTabelle);
    selTabella.AfterScroll:=TWA136FRelazioniAnagrafeDM(WR302DM).AfterScroll;
  end;
  cmbColonnaPartenza.Items.Clear;
  cmbColonnaPartenza.Text:='';
  cmbColonnaPartenza.Enabled:=False;
  cmbColonnaArrivo.Items.Clear;
  cmbColonnaArrivo.Text:='';
  cmbColonnaArrivo.Enabled:=False;
  GetParametriFunzione;
  //Creazione dataSet vuoto per far si che si visualizzi la grid
  with TWA136FRelazioniAnagrafeDM(WR302DM).A136FRelazioniAnagrafeMW.A136FComposizioneRelazioneMW.cdsStampa do
  begin
    Close;
    FieldDefs.Clear;
    IndexDefs.Clear;
    FieldDefs.Add('temp',ftString,10);
    CreateDataSet;
    FieldByName('temp').DisplayLabel:=' ';
    EmptyDataSet;
  end;
  grdStampaRelazioni.medpAttivaGrid(TWA136FRelazioniAnagrafeDM(WR302DM).A136FRelazioniAnagrafeMW.A136FComposizioneRelazioneMW.cdsStampa,False,False,False);
end;

procedure TWA136FStampaRelazioniFM.cmbColonnaPartenzaAsyncChange(
  Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
var
  ListColonneArrivo: TStringList;
  i: Integer;
begin
  cmbColonnaArrivo.Items.Clear;
  if ColonnePilotate <> '' then
  begin
    with TWA136FRelazioniAnagrafeDM(WR302DM) do
    begin
      selTabella.AfterScroll:=nil;
      ListColonneArrivo:=TStringList.Create();
      A136FRelazioniAnagrafeMW.ElencoColonneArrivo(cmbTabella.Text,cmbColonnaPartenza.Text,ColonnePilotate, ListColonneArrivo);
      cmbColonnaArrivo.Items.Clear;
      for i:=0 to ListColonneArrivo.Count - 1 do
        cmbColonnaArrivo.AddRow(ListColonneArrivo[i]);
      FreeAndNil(ListColonneArrivo);
      selTabella.AfterScroll:=TWA136FRelazioniAnagrafeDM(WR302DM).AfterScroll;
    end;
    cmbColonnaArrivo.Enabled:=True;
  end;
end;

procedure TWA136FStampaRelazioniFM.cmbTabellaAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
var
  ListColonne: TStringList;
  i: Integer;
begin
  cmbColonnaPartenza.Items.Clear;
  cmbColonnaArrivo.Items.Clear;
  ColonnePilotate:='';
  if cmbTabella.Text <> '' then
  begin
    with TWA136FRelazioniAnagrafeDM(WR302DM) do
    begin
      selTabella.AfterScroll:=nil;
      ListColonne:=TStringList.Create();
      A136FRelazioniAnagrafeMW.ElencoColonne(cmbTabella.Text,ListColonne,ColonnePilotate);
      cmbColonnaPartenza.Items.Clear;
      for i:=0 to ListColonne.Count - 1 do
        cmbColonnaPartenza.AddRow(ListColonne[i]);
      selTabella.AfterScroll:=TWA136FRelazioniAnagrafeDM(WR302DM).AfterScroll;
    end;
    cmbColonnaPartenza.Enabled:=True;
    cmbColonnaPartenza.Text:='';
    cmbColonnaArrivo.Text:='';
    cmbColonnaArrivo.Enabled:=False;
  end;
end;

procedure TWA136FStampaRelazioniFM.grdStampaRelazioniRenderCell(
  ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  inherited;
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;
end;

procedure TWA136FStampaRelazioniFM.imgEseguiClick(Sender: TObject);
var
  Tipo, StrutturaStampa: String;
begin
  inherited;
  //Controlli sui parametri impostati

  if (Trim(edtDataStampa.Text) = '') then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,['data riferimento']),mtError,[mbOk],nil,'');
    Abort;
  end;
  if (cmbTabella.Text = '') xor (cmbColonnaPartenza.Text ='') then
  begin
    MsgBox.WebMessageDlg(A000MSG_A136_ERR_TABELLA_COLONNA,mtError,[mbOk],nil,'');
    Abort;
  end;

  if (cmbTabella.Text <> '') and (cmbTabella.ItemIndex = -1) then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_ELEM_LISTA,['Tabella']),mtError,[mbOk],nil,'');
    Abort;
  end;

  if (cmbColonnaPartenza.Text <> '') and (cmbColonnaPartenza.ItemIndex = -1) then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_ELEM_LISTA,['Colonna partenza']),mtError,[mbOk],nil,'');
    Abort;
  end;

  if (cmbColonnaArrivo.Text <> '') and (cmbColonnaArrivo.ItemIndex = -1) then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_ELEM_LISTA,['Colonna arrivo']),mtError,[mbOk],nil,'');
    Abort;
  end;

  if  (not chkTipoRelS.Checked)
  and (not chkTipoRelL.Checked) then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,['Tipo relazione']),mtError,[mbOk],nil,'');
    Abort;
  end;

  //Recupero i tipi di relazione da stampare
  //Recupero la struttura relazionale completa, se è stata indicata
  StrutturaStampa:='';
  if (cmbColonnaPartenza.Text <> '') and (cmbColonnaArrivo.Text <> '') then
  begin
    with TWA136FRelazioniAnagrafeDM(WR302DM) do
    begin
      selTabella.AfterScroll:=nil;
      StrutturaStampa:=A136FRelazioniAnagrafeMW.CreaStrutturaStampa(cmbTabella.Text, cmbColonnaPartenza.Text , cmbColonnaArrivo.Text);
      selTabella.AfterScroll:=TWA136FRelazioniAnagrafeDM(WR302DM).AfterScroll;
    end;
  end;
  //salvo parametri per accesso futuro
  PutParametriFunzione;
  //Avvio la stampa
  Tipo:=',';
  if chkTipoRelS.Checked then
    Tipo:=Tipo + '''S'',';
  if chkTipoRelL.Checked then
    Tipo:=Tipo + '''L'',';
  Tipo:=Copy(Tipo,2,Length(Tipo)-2);

  //Recupero la data della stampa
  with TWA136FRelazioniAnagrafeDM(WR302DM).A136FRelazioniAnagrafeMW.A136FComposizioneRelazioneMW do
  begin
   GestioneStampa(Tipo,StrToDate(edtDataStampa.Text),0,chkDecorrenza.Checked,chkNomeCampo.Checked,
                  chkCodice.Checked,chkDescrizione.Checked,False,
                  cmbTabella.Text,cmbColonnaPartenza.Text,
                  StrutturaStampa,StrToIntDef(edtLivelliDaEstrarre.Text,0),0,'','');
   grdStampaRelazioni.medpAttivaGrid(cdsStampa,False,False,False);
  end;
end;

procedure TWA136FStampaRelazioniFM.getParametriFunzione;
begin
  with (Self.Owner as TWR100FBase).C004DM do
  begin
    chkTipoRelS.Checked:=GetParametro('chkTipoRelS','N') = 'S';
    chkTipoRelL.Checked:=GetParametro('chkTipoRelL','N') = 'S';
    chkDecorrenza.Checked:=GetParametro('chkDecorrenza','N') = 'S';
    chkNomeCampo.Checked:=GetParametro('chkNomeCampo','N') = 'S';
    chkCodice.Checked:=GetParametro('chkCodice','N') = 'S';
    chkDescrizione.Checked:=GetParametro('chkDescrizione','N') = 'S';
  end;
end;

procedure TWA136FStampaRelazioniFM.PutParametriFunzione;
begin
  with (Self.Owner as TWR100FBase).C004DM do
  begin
    Cancella001;
    PutParametro('chkTipoRelS',IfThen(chkTipoRelS.Checked,'S','N'));
    PutParametro('chkTipoRelL',IfThen(chkTipoRelL.Checked,'S','N'));
    PutParametro('chkDecorrenza',IfThen(chkDecorrenza.Checked,'S','N'));
    PutParametro('chkNomeCampo',IfThen(chkNomeCampo.Checked,'S','N'));
    PutParametro('chkCodice',IfThen(chkCodice.Checked,'S','N'));
    PutParametro('chkDescrizione',IfThen(chkDescrizione.Checked,'S','N'));
    try SessioneOracle.Commit; except end;
  end;
end;

procedure TWA136FStampaRelazioniFM.ReleaseOggetti;
begin
  inherited;
end;

end.
