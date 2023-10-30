unit WA136UComponiRelazioneFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR200UBaseFM, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWCompEdit, IWDBStdCtrls, IWApplication,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompLabel,A000UCostanti, A000USessione,
  OracleData, meIWDBEdit,meIWLabel,medpIWMessageDlg,WR010UBase,A000UMessaggi, IWCompGrids, IWDBGrids,
  medpIWDBGrid,C180FunzioniGenerali,C190FunzioniGeneraliWeb,DB,
  meIWEdit, IWCompButton, meIWButton,StrUtils,A000UInterfaccia,MedpIWMultiColumnComboBox,
  IWCompExtCtrls, meIWImageFile, medpIWImageButton, Vcl.Menus;

type
  TWA136FComponiRelazioneFM = class(TWR200FBaseFM)
    lblTabellaPilotata: TmeIWLabel;
    lblTabellaPilota: TmeIWLabel;
    lblColonnaPilotata: TmeIWLabel;
    grdRelazioniCampi: TmedpIWDBGrid;
    lblColonnaPilota: TmeIWLabel;
    edtTabellaPilotata: TmeIWEdit;
    edtColonnaPilotata: TmeIWEdit;
    edtTabellaPilota: TmeIWEdit;
    cmbColonnaPilota: TMedpIWMultiColumnComboBox;
    lblTipo: TmeIWLabel;
    edtTipo: TmeIWEdit;
    lblDTipo: TmeIWLabel;
    lblDecorrenza: TmeIWLabel;
    edtDecorrenza: TmeIWEdit;
    btnConferma: TmedpIWImageButton;
    btnAnnulla: TmedpIWImageButton;
    pmnGrdRelazioniCampi: TPopupMenu;
    actScaricaInExcel: TMenuItem;
    btnModifica: TmedpIWImageButton;
    btnChiudi: TmedpIWImageButton;
    actScaricaInCSV: TMenuItem;
    procedure grdRelazioniCampiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure grdRelazioniCampiDataSet2Componenti(Row: Integer);
    procedure cmbColonnaPilotaChange(Sender: TObject; Index: Integer);
    procedure btnConfermaClick(Sender: TObject);
    procedure grdRelazioniCampiComponenti2DataSet(Row: Integer);
    procedure btnAnnullaClick(Sender: TObject);
    procedure actScaricaInExcelClick(Sender: TObject);
    procedure btnModificaClick(Sender: TObject);
    procedure btnChiudiClick(Sender: TObject);
    procedure actScaricaInCSVClick(Sender: TObject);
  private
    FSQLRelazione: String;
    FAbbinaValori: String;
    FSaveColonnaPilota: String;
    procedure CaricaListComboColonnaPilota;
    procedure cmbValorePilotaAsyncChange(Sender: TObject;EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbValorePilotatoAsyncChange(Sender: TObject;EventParams: TStringList; Index: Integer; Value: string);
    procedure ConfermaAbbinamenti;
    procedure SetInModifica(const PModificaAttiva: Boolean);
  public
    function CaricaDatiIniziali: Boolean;
    procedure ResultRelNonStandard(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure ResultValoriDuplicati(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure ResultNoPilota(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure ResultNoAction(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure ImpostaStato;
  end;

implementation 
 
uses
  WA136URelazioniAnagrafe, 
  WA136URelazioniAnagrafeDettFM, 
  WA136URelazioniAnagrafeDM,
  A136URelazioniAnagrafeMW;

{$R *.dfm}

{ TWA136FComponiRelazioneFM }

(* !!! ATTENZIONE !!!
  Questa funzione si scatena anche all'apertura del form in inizializzaAccesso.
  Se la maschera è richiamata da un'altra form (es WA002, WP430) la funzione Msgbox farà comparire il messaggio
  sul form chiamante e non sul WA136 perchè l'activeForm risulta ancora essere il chiamante.
  Pertanto uso FMsgBox al posto della funzione MsgBox!
*)

function TWA136FComponiRelazioneFM.CaricaDatiIniziali: boolean;
var
  CampoPilota,
  S,
  ValorePilota,
  ValorePilotato: String;
  bUnion,bElementiNonStandard: Boolean;
begin
  with TWA136FRelazioniAnagrafeDM(WR302DM) do
  begin
    //Inizializzazione
    Result:=True;
    A136FRelazioniAnagrafeMW.cdsCampiRelazioni.FieldByName('VALOREPILOTA').ReadOnly:=False;
    A136FRelazioniAnagrafeMW.cdsCampiRelazioni.FieldByName('VALOREPILOTATO').ReadOnly:=False;

    edtTabellaPilotata.Text:=selTabella.FieldByName('TABELLA').AsString;
    edtColonnaPilotata.Text:=selTabella.FieldByName('COLONNA').AsString;
    edtTabellaPilota.Text:=selTabella.FieldByName('TAB_ORIGINE').AsString;
    cmbColonnaPilota.Text:='';

    edtDecorrenza.Text:=selTabella.FieldByName('DECORRENZA').AsString;
    edtTipo.Text:=selTabella.FieldByName('TIPO').AsString;
    lblDTipo.Caption:=selTabella.FieldByName('D_TIPO').AsString;
    A136FRelazioniAnagrafeMW.cdsCampiRelazioni.EmptyDataSet;
    A136FRelazioniAnagrafeMW.cdsCampiRelazioni.FieldByName('VALOREPILOTATO').DisplayLabel:=selTabella.FieldByName('COLONNA').AsString;
    if selTabella.FieldByName('COL_ORIGINE').IsNull then
      A136FRelazioniAnagrafeMW.cdsCampiRelazioni.FieldByName('VALOREPILOTA').DisplayLabel:='Valore colonna pilota'
    else
      A136FRelazioniAnagrafeMW.cdsCampiRelazioni.FieldByName('VALOREPILOTA').DisplayLabel:=selTabella.FieldByName('COL_ORIGINE').AsString;
    //Deve prendere dalla memo di dettaglio perchè potrei essere in modifica e aver modificato il dato
    FSQLRelazione:=TWA136FRelazioniAnagrafeDettFM(TWA136FRelazioniAnagrafe(Self.Owner).WDettaglioFM).MemoRelazione.Text;
    //Estraggo i dati dalla tabella di riferimento della colonna pilotata
    Result:=A136FRelazioniAnagrafeMW.ImpostaQuerySelezione(selTabella.FieldByName('TABELLA').AsString,selTabella.FieldByName('COLONNA').AsString,A136FRelazioniAnagrafeMW.selPilotato);
    if Result then
    begin
      //Imposto la colonna Descrizione in base alla tabella di provenienza
      try
        A136FRelazioniAnagrafeMW.selPilotato.Open;
        FAbbinaValori:='';
        bElementiNonStandard:=R180CercaParolaIntera('SUBSTR',FSQLRelazione,',(') > 0;
        //Se la relazione è di tipo Filtro...
        if selTabella.FieldByName('TIPO').AsString = 'F' then
        begin
          //Controllo se l'inizio della relazione è standard
          if (Copy(FSQLRelazione,1,15) = 'SELECT DISTINCT')
          and not bElementiNonStandard then
          begin
            A136FRelazioniAnagrafeMW.ListaValoriSQL.Clear;

            if not A136FRelazioniAnagrafeMW.EstraiCampoPilota(FSQLRelazione,CampoPilota) then
            begin
              (Self.Owner as TWA136FRelazioniAnagrafe).FMsgBox.WebMessageDlg(A000MSG_A136_DLG_RELAZ_NO_STANDARD,mtConfirmation,[mbYes,mbNo],ResultRelNonStandard,'');
              Result:=False;
              Exit;
            end;
            cmbColonnaPilota.ItemIndex:=-1;
            cmbColonnaPilota.Text:=CampoPilota;

            if not A136FRelazioniAnagrafeMW.RecuperaValoriPilota(selTabella.FieldByName('TAB_ORIGINE').AsString,CampoPilota) then
            begin
              if (not (Self.Owner as TWA136FRelazioniAnagrafe).FMsgBox.KeyExists('NOPILOTA')) then
              begin
                (Self.Owner as TWA136FRelazioniAnagrafe).FMsgBox.WebMessageDlg(A000MSG_A136_DLG_RELAZ_NO_PILOTA,mtConfirmation,[mbYes,mbNo],ResultNoPilota,'NOPILOTA');
                Result:=False;
                Exit;
              end;
            end;

            S:=FSQLRelazione;
            S:=Copy(S,Pos('FROM',S));
            //Cerco tutti i valori pilotati specificati nella relazione
            while (Pos('(',S) > 0) or (Pos('NULL',S) > 0) do
            begin
              if not A136FRelazioniAnagrafeMW.EstraiValoriDaSQLRelazione(S,ValorePilota, ValorePilotato) then
              begin
                (Self.Owner as TWA136FRelazioniAnagrafe).FMsgBox.WebMessageDlg(A000MSG_A136_DLG_RELAZ_NO_STANDARD,mtConfirmation,[mbYes,mbNo],ResultRelNonStandard,'');
                Result:=False;
                Exit;
              end;

              //Gestisco il caricamento dei valori pilota/pilotato nella lista
              A136FRelazioniAnagrafeMW.CaricaAbbinaValori(FAbbinaValori,ValorePilota,ValorePilotato);

              //Cerco l'eventuale Union
              bUnion:=Pos('UNION',S) > 0;
              //Mi posiziono sulla FROM per evitare l'eventuale NULL della Descrizione
              S:=Copy(S,Pos('FROM',S));
              //Se trovo altri valori pilotati ma non la Union o viceversa...
              if (((Pos('(',S) > 0) or  (Pos('NULL',S) > 0)) and not bUnion) or
                 (((Pos('(',S) = 0) and (Pos('NULL',S) = 0)) and bUnion) then
              begin
                (Self.Owner as TWA136FRelazioniAnagrafe).FMsgBox.WebMessageDlg(A000MSG_A136_DLG_RELAZ_NO_STANDARD,mtConfirmation,[mbYes,mbNo],ResultRelNonStandard,'');
                Result:=False;
                Exit;
              end;
            end;
          end
          else if (Trim(FSQLRelazione) <> '') then
          begin
            (Self.Owner as TWA136FRelazioniAnagrafe).FMsgBox.WebMessageDlg(A000MSG_A136_DLG_RELAZ_NO_STANDARD,mtConfirmation,[mbYes,mbNo],ResultRelNonStandard,'');
            Result:=False;
            Exit;
          end
          else
          begin
            //Provo a caricare i valori pilotati senza abbinare i valori pilota
            A136FRelazioniAnagrafeMW.CaricaValoriPilotati('');
            Result:=True;
            Exit;
          end;
          //Carico la lista degli abbinamenti
          if (A136FRelazioniAnagrafeMW.AbbinaValoriDuplicati(FAbbinaValori)) then
          begin
            (Self.Owner as TWA136FRelazioniAnagrafe).FMsgBox.WebMessageDlg(A000MSG_A136_DLG_VALORI_DUPLICATI,mtConfirmation,[mbYes,mbNo],ResultValoriDuplicati,'');
            Result:=False;
            Exit;
          end
          else //Provo a caricare i valori pilotati abbinando i valori pilota
            A136FRelazioniAnagrafeMW.CaricaValoriPilotati(FAbbinaValori);
        end
        //Se la relazione è di tipo Vincolato o Libero...
        else if (selTabella.FieldByName('TIPO').AsString = 'S') or (selTabella.FieldByName('TIPO').AsString = 'L') then
        begin

          A136FRelazioniAnagrafeMW.cdsCampiRelazioni.IndexName:='IND_PILOTA';
          //Controllo se l'SQL contiene gli elementi standard
          if ((Copy(FSQLRelazione,1,10) = 'DECODE(<#>') and
             (Pos('<#>D<#>',FSQLRelazione) > 0) and
             (Pos('<#>;<#>',FSQLRelazione) > 0))
          and not bElementiNonStandard then
          begin
            FAbbinaValori:=A136FRelazioniAnagrafeMW.EstraiAbbinaValori(FSQLRelazione);
            //Carico la lista degli abbinamenti
            A136FRelazioniAnagrafeMW.ListaValoriSQL.Clear;
            A136FRelazioniAnagrafeMW.ListaValoriSQL.QuoteChar:='''';
            A136FRelazioniAnagrafeMW.ListaValoriSQL.Delimiter:=',';
            A136FRelazioniAnagrafeMW.ListaValoriSQL.StrictDelimiter:=True;
            A136FRelazioniAnagrafeMW.ListaValoriSQL.DelimitedText:=FAbbinaValori;
            //Recupero la colonna pilota
            if not A136FRelazioniAnagrafeMW.EstraiCampoPilota(FSQLRelazione,CampoPilota) then
            begin
              (Self.Owner as TWA136FRelazioniAnagrafe).FMsgBox.WebMessageDlg(A000MSG_A136_DLG_RELAZ_NO_STANDARD,mtConfirmation,[mbYes,mbNo],ResultRelNonStandard,'');
              Result:=False;
              Exit;
            end;
            cmbColonnaPilota.ItemIndex:=-1;
            cmbColonnaPilota.Text:=CampoPilota;
              //
            if cmbColonnaPilota.Text <> '' then
            begin
              //Recupero i valori pilota provando ad abbinare i valori pilotati
              if not A136FRelazioniAnagrafeMW.RecuperaValoriPilota(selTabella.FieldByName('TAB_ORIGINE').AsString,cmbColonnaPilota.Text) then
              begin
                (Self.Owner as TWA136FRelazioniAnagrafe).FMsgBox.WebMessageDlg(A000MSG_A136_DLG_RELAZ_NO_PILOTA,mtConfirmation,[mbYes,mbNo],ResultNoAction,'');
                Result:=False;
                Exit;
              end;
            end;
          end
          else if (Trim(FSQLRelazione) <> '') then
          begin
            (Self.Owner as TWA136FRelazioniAnagrafe).FMsgBox.WebMessageDlg(A000MSG_A136_DLG_RELAZ_NO_STANDARD,mtConfirmation,[mbYes,mbNo],ResultNoAction,'');
            Result:=False;
            Exit;
          end;
        end;
      except
        Result:=False;
      end;
    end;
  end;
end;

procedure TWA136FComponiRelazioneFM.ImpostaStato;
var
  LModificaAbilitata: Boolean;
  LA136MW: TA136FRelazioniAnagrafeMW;
begin
  LModificaAbilitata:=WR302DM.selTabella.State in [dsEdit,dsInsert];

  LA136MW:=TWA136FRelazioniAnagrafeDM(WR302DM).A136FRelazioniAnagrafeMW;
  LA136MW.cdsCampiRelazioni.FieldByName('VALOREPILOTA').ReadOnly:=WR302DM.selTabella.FieldByName('TIPO').AsString <> 'F';
  LA136MW.cdsCampiRelazioni.FieldByName('VALOREPILOTATO').ReadOnly:=WR302DM.selTabella.FieldByName('TIPO').AsString = 'F';

  grdRelazioniCampi.medpPaginazione:=True;
  grdRelazioniCampi.medpRighePagina:=50;

  grdRelazioniCampi.medpAttivaGrid(LA136MW.cdsCampiRelazioni,False,False,False);
  //devo resettare i componenti creati in precedenza, perchè non sempre uguali
  grdRelazioniCampi.medpCancellaRigaWR102;
  grdRelazioniCampi.medpPreparaComponentiDefault;
  grdRelazioniCampi.medpPreparaComponenteGenerico('WR102',grdRelazioniCampi.medpIndexColonna('D_DESC_PILOTA'),0,DBG_LBL,'20','1','null','','S');
  grdRelazioniCampi.medpPreparaComponenteGenerico('WR102',grdRelazioniCampi.medpIndexColonna('D_DESC_PILOTATO'),0,DBG_LBL,'20','1','null','','S');
  if WR302DM.selTabella.FieldByName('TIPO').AsString = 'F' then
  begin
    if (not grdRelazioniCampi.medpDataSet.FieldByName('VALOREPILOTA').ReadOnly) then
      grdRelazioniCampi.medpPreparaComponenteGenerico('WR102',grdRelazioniCampi.medpIndexColonna('VALOREPILOTA'),0,DBG_MECMB,'10','1','null','','S');
  end
  else
  begin
    if (not grdRelazioniCampi.medpDataSet.FieldByName('VALOREPILOTATO').ReadOnly) then
      grdRelazioniCampi.medpPreparaComponenteGenerico('WR102',grdRelazioniCampi.medpIndexColonna('VALOREPILOTATO'),0,DBG_MECMB,'10','1','null','','S');
  end;

  cmbColonnaPilota.Enabled:=LModificaAbilitata;
  if cmbColonnaPilota.Enabled then
    CaricaListComboColonnaPilota;

  // attiva modifica dati
  btnModifica.Enabled:=LModificaAbilitata and (grdRelazioniCampi.medpDataSet.RecordCount > 0) ;
  btnConferma.Enabled:=False;
  btnAnnulla.Enabled:=False;
  btnChiudi.Enabled:=btnModifica.Enabled;

  FSaveColonnaPilota:=cmbColonnaPilota.Text;
end;

procedure TWA136FComponiRelazioneFM.CaricaListComboColonnaPilota;
var
  NomeTabella: String;
begin
  NomeTabella:=TWA136FRelazioniAnagrafeDM(WR302DM).selTabella.FieldByName('TAB_ORIGINE').AsString;
  with TWA136FRelazioniAnagrafeDM(WR302DM).A136FRelazioniAnagrafeMW do
  begin
    selCols.Close;
    selCols.setVariable('TABELLA',NomeTabella);
    selCols.setVariable('PILOTA','S');
    selCols.Open;
    selCols.First;
    cmbColonnaPilota.Items.clear;
    while not selCols.Eof do
    begin
      cmbColonnaPilota.addRow(selCols.FieldByName('COLUMN_NAME').AsString);
      selCols.Next;
    end;
    selCols.Close;
  end;
end;

procedure TWA136FComponiRelazioneFM.cmbColonnaPilotaChange(Sender: TObject; Index: Integer);
var
  LSaveReadOnly,
  LAbilitato: Boolean;
begin
  if edtTabellaPilota.Text = 'T430_STORICO' then
  begin
    if not TWA136FRelazioniAnagrafeDM(WR302DM).A136FRelazioniAnagrafeMW.selT033.SearchRecord('CAMPODB',cmbColonnaPilota.Text,[srFromBeginning]) then
    begin
      cmbColonnaPilota.ItemIndex:=-1;
      cmbColonnaPilota.Text:=FSaveColonnaPilota;
      MsgBox.WebMessageDlg(A000MSG_A136_ERR_UTENTE_NO_CAMPO,mtConfirmation,[mbOK],nil,'');
      Exit;
    end;
  end
  else if edtTabellaPilota.Text = 'P430_ANAGRAFICO' then
  begin
    LAbilitato:=A000GetInibizioni('Funzione','OpenP430FAnagrafico') = 'S';
    if not LAbilitato then
    begin
      cmbColonnaPilota.ItemIndex:=-1;
      cmbColonnaPilota.Text:=FSaveColonnaPilota;
      MsgBox.WebMessageDlg(A000MSG_A136_ERR_UTENTE_NO_CAMPO,mtConfirmation,[mbOK],nil,'');
      Exit;
    end;
  end;

  FSaveColonnaPilota:=cmbColonnaPilota.Text;
  //Per ricaricare il dataset il campo non può essere readOnly.
  //Lo sblocco e dopo reimposto il valore iniziale
  LSaveReadOnly:=TWA136FRelazioniAnagrafeDM(WR302DM).A136FRelazioniAnagrafeMW.cdsCampiRelazioni.FieldByName('VALOREPILOTA').ReadOnly;
  TWA136FRelazioniAnagrafeDM(WR302DM).A136FRelazioniAnagrafeMW.cdsCampiRelazioni.FieldByName('VALOREPILOTA').ReadOnly:=False;

  TWA136FRelazioniAnagrafeDM(WR302DM).A136FRelazioniAnagrafeMW.RecuperaValoriPilota(edtTabellaPilota.Text,cmbColonnaPilota.Text);
  grdRelazioniCampi.medpCreaColonne;
  TWA136FRelazioniAnagrafeDM(WR302DM).A136FRelazioniAnagrafeMW.cdsCampiRelazioni.FieldByName('VALOREPILOTA').ReadOnly:=LSaveReadOnly;
  //Devo riportare la grid in modifica
  grdRelazioniCampi.medpDataSet.First; // necessario
  grdRelazioniCampi.medpAggiornaCDS(True);

  // attiva modifica dati
  btnModifica.Enabled:=grdRelazioniCampi.medpDataSet.RecordCount > 0;
  btnConferma.Enabled:=False;
  btnAnnulla.Enabled:=False;
  btnChiudi.Enabled:=btnModifica.Enabled;
end;

procedure TWA136FComponiRelazioneFM.cmbValorePilotaAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
var
  cmb: TMedpIWMultiColumnComboBox;
begin
  cmb:=(Sender as TMedpIWMultiColumnComboBox);
  with TWA136FRelazioniAnagrafeDM(WR302DM).A136FRelazioniAnagrafeMW do
  begin
    cdsCampiRelazioni.FieldByName('VALOREPILOTA').AsString:=cmb.Text;
    TmeIWLabel(grdRelazioniCampi.medpCompCella(cmb.Tag,grdRelazioniCampi.medpIndexColonna('D_DESC_PILOTA'),0)).Caption:=cdsCampiRelazioni.FieldByName('D_DESC_PILOTA').AsString;
  end;
end;

procedure TWA136FComponiRelazioneFM.cmbValorePilotatoAsyncChange(
  Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
var
  cmb: TMedpIWMultiColumnComboBox;
begin
  cmb:=(Sender as TMedpIWMultiColumnComboBox);
  with TWA136FRelazioniAnagrafeDM(WR302DM).A136FRelazioniAnagrafeMW do
  begin
    cdsCampiRelazioni.FieldByName('VALOREPILOTATO').AsString:=cmb.Text;
    TmeIWLabel(grdRelazioniCampi.medpCompCella(cmb.Tag,grdRelazioniCampi.medpIndexColonna('D_DESC_PILOTATO'),0)).Caption:=cdsCampiRelazioni.FieldByName('D_DESC_PILOTATO').AsString;
  end;
end;

procedure TWA136FComponiRelazioneFM.grdRelazioniCampiDataSet2Componenti(
  Row: Integer);
var
  i: Integer;
  cmb: TMedpIWMultiColumnComboBox;
begin
  inherited;
  with TWA136FRelazioniAnagrafeDM(WR302DM).A136FRelazioniAnagrafeMW do
  begin
    TmeIWLabel(grdRelazioniCampi.medpCompCella(Row,grdRelazioniCampi.medpIndexColonna('D_DESC_PILOTA'),0)).Caption:=grdRelazioniCampi.medpValoreColonna(Row, 'D_DESC_PILOTA');
    TmeIWLabel(grdRelazioniCampi.medpCompCella(Row,grdRelazioniCampi.medpIndexColonna('D_DESC_PILOTATO'),0)).Caption:=grdRelazioniCampi.medpValoreColonna(Row, 'D_DESC_PILOTATO');
    if TWA136FRelazioniAnagrafeDM(WR302DM).selTabella.FieldByName('TIPO').AsString = 'F' then
    begin
      if (not grdRelazioniCampi.medpDataSet.FieldByName('VALOREPILOTA').ReadOnly) then
      begin
        cmb:=(grdRelazioniCampi.medpCompCella(Row,grdRelazioniCampi.medpIndexColonna('VALOREPILOTA'),0) as TMedpIWMultiColumnComboBox);
        cmb.Tag:=Row;
        cmb.PopUpHeight:=10;
        cmb.PopUpWidth:=20;
        cmb.Items.Clear;
        //Carico i valori pilota nella PickList della colonna pilota
        for i:=0 to ListaPilota.Count - 1 do
          cmb.AddRow(ListaPilota[i]);
        cmb.Text:=grdRelazioniCampi.medpValoreColonna(Row, 'VALOREPILOTA');
        cmb.OnAsyncChange:=cmbValorePilotaAsyncChange;
      end;
    end
    else
    begin
      if (not grdRelazioniCampi.medpDataSet.FieldByName('VALOREPILOTATO').ReadOnly) then
      begin
        cmb:=(grdRelazioniCampi.medpCompCella(Row,grdRelazioniCampi.medpIndexColonna('VALOREPILOTATO'),0) as TMedpIWMultiColumnComboBox);
        cmb.Tag:=Row;
        cmb.PopUpHeight:=10;
        cmb.PopUpWidth:=20;
        cmb.Items.Clear;
        selPilotato.First;
        while not selPilotato.Eof do
        begin
          cmb.addRow(selPilotato.FieldByName('CODICE').AsString);
          selPilotato.Next;
        end;
        cmb.Text:=grdRelazioniCampi.medpValoreColonna(Row, 'VALOREPILOTATO');
        cmb.OnAsyncChange:=cmbValorePilotatoAsyncChange;
      end;
    end;
  end;
end;

procedure TWA136FComponiRelazioneFM.grdRelazioniCampiComponenti2DataSet(
  Row: Integer);
begin
  inherited;
  with TWA136FRelazioniAnagrafeDM(WR302DM).A136FRelazioniAnagrafeMW do
  begin
    if grdRelazioniCampi.medpCompCella(Row,grdRelazioniCampi.medpIndexColonna('VALOREPILOTA'),0) is TMedpIWMultiColumnComboBox then
      grdRelazioniCampi.medpDataSet.FieldByName('VALOREPILOTA').AsString:=TMedpIWMultiColumnComboBox(grdRelazioniCampi.medpCompCella(Row,grdRelazioniCampi.medpIndexColonna('VALOREPILOTA'),0)).Text;

    if grdRelazioniCampi.medpCompCella(Row,grdRelazioniCampi.medpIndexColonna('VALOREPILOTATO'),0) is TMedpIWMultiColumnComboBox then
      grdRelazioniCampi.medpDataSet.FieldByName('VALOREPILOTATO').AsString:=TMedpIWMultiColumnComboBox(grdRelazioniCampi.medpCompCella(Row,grdRelazioniCampi.medpIndexColonna('VALOREPILOTATO'),0)).Text
    else if grdRelazioniCampi.medpCompCella(Row,grdRelazioniCampi.medpIndexColonna('VALOREPILOTATO'),0) is TmeIWEdit  then
      grdRelazioniCampi.medpDataSet.FieldByName('VALOREPILOTATO').AsString:=TmeIWEdit(grdRelazioniCampi.medpCompCella(Row,grdRelazioniCampi.medpIndexColonna('VALOREPILOTATO'),0)).Text;
  end;
end;

procedure TWA136FComponiRelazioneFM.grdRelazioniCampiRenderCell(
  ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;

begin
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  NumColonna:=grdRelazioniCampi.medpNumColonna(AColumn);

  // Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(grdRelazioniCampi.medpCompGriglia) + 1) and (grdRelazioniCampi.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdRelazioniCampi.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

procedure TWA136FComponiRelazioneFM.actScaricaInCSVClick(Sender: TObject);
begin
  if not Assigned(Sender) then
    (Self.Owner as TWR010FBase).csvDownload:=grdRelazioniCampi.ToCsv
  else
    (Self.Owner as TWR010FBase).InviaFile('abbinamenti.xls',(Self.Owner as TWR010FBase).csvDownload);
end;

procedure TWA136FComponiRelazioneFM.actScaricaInExcelClick(Sender: TObject);
begin
  if not Assigned(Sender) then
    (Self.Owner as TWR010FBase).streamDownload:=grdRelazioniCampi.ToXlsx
  else
    (Self.Owner as TWR010FBase).InviaFile('abbinamenti.xlsx',(Self.Owner as TWR010FBase).streamDownload);
end;

procedure TWA136FComponiRelazioneFM.btnAnnullaClick(Sender: TObject);
var
  i: Integer;
begin
  // annulla le modifiche apportate
  for i:=0 to High(grdRelazioniCampi.medpCompGriglia) do
  begin
    grdRelazioniCampi.medpAnnulla(i);
  end;

  SetInModifica(False);
end;

procedure TWA136FComponiRelazioneFM.btnChiudiClick(Sender: TObject);
begin
  // seleziona il tab di dettaglio
  TWA136FRelazioniAnagrafe(Self.Owner).AbilitaDettaglio(True);
  TWA136FRelazioniAnagrafe(Self.Owner).grdTabControl.ActiveTab:=TWA136FRelazioniAnagrafe(Self.Owner).WDettaglioFM;
end;

procedure TWA136FComponiRelazioneFM.btnConfermaClick(Sender: TObject);
begin
  ConfermaAbbinamenti;
end;

procedure TWA136FComponiRelazioneFM.SetInModifica(const PModificaAttiva: Boolean);
begin
  if PModificaAttiva then
    grdRelazioniCampi.medpDisabilitaNavBar
  else
    grdRelazioniCampi.medpAbilitaNavBar;

  btnModifica.Enabled:=not PModificaAttiva;
  btnConferma.Enabled:=PModificaAttiva;
  btnAnnulla.Enabled:=PModificaAttiva;
  btnChiudi.Enabled:=not PModificaAttiva;
end;

procedure TWA136FComponiRelazioneFM.btnModificaClick(Sender: TObject);
begin
  grdRelazioniCampi.medpModifica(True);

  SetInModifica(True);
end;

procedure TWA136FComponiRelazioneFM.ResultNoAction(Sender: TObject;
  R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
  begin
    //Attiva il pannello Componi relazione senza eseguire più caricaDatiIniziali
    //perciò non scatena eventi di tabChange
    TWA136FRelazioniAnagrafe(Self.Owner).AttivaComponiRelazione;
  end;
end;

procedure TWA136FComponiRelazioneFM.ResultNoPilota(Sender: TObject;
  R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
  begin
    //scateno tabChange per rieseguire caricaDatiIniziali
    TWA136FRelazioniAnagrafe(Self.Owner).grdTabControl.ActiveTab:=TWA136FRelazioniAnagrafe(Self.Owner).WComponiRelazioneFM;
  end;
end;

procedure TWA136FComponiRelazioneFM.ResultRelNonStandard(Sender: TObject;
  R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
  begin
    TWA136FRelazioniAnagrafeDM(WR302DM).A136FRelazioniAnagrafeMW.CaricaValoriPilotati('');
    //Attiva il pannello Componi relazione senza eseguire più caricaDatiIniziali
    //perciò non scatena eventi di tabChange
    TWA136FRelazioniAnagrafe(Self.Owner).AttivaComponiRelazione;
  end;
end;

procedure TWA136FComponiRelazioneFM.ResultValoriDuplicati(Sender: TObject;
  R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
  begin
    TWA136FRelazioniAnagrafeDM(WR302DM).A136FRelazioniAnagrafeMW.CaricaValoriPilotati(FAbbinaValori);
    //Attiva il pannello Componi relazione senza eseguire più caricaDatiIniziali
    //perciò non scatena eventi di tabChange
    TWA136FRelazioniAnagrafe(Self.Owner).AttivaComponiRelazione;
  end;
end;

procedure TWA136FComponiRelazioneFM.ConfermaAbbinamenti;
var
  i: Integer;
  LDS: TDataSet;
begin
  // salva i dati della grid nel dataset
  LDS:=grdRelazioniCampi.medpDataSet;
  LDS.Cancel;
  LDS.RecNo:=grdRelazioniCampi.medpOffset + 1;
  for i:=0 to High(grdRelazioniCampi.medpCompGriglia) do
  begin
    LDS.Edit;
    grdRelazioniCampi.medpConferma(i);
    LDS.Next;
  end;

  // riposizionamento sul primo record della pagina
  LDS.RecNo:=grdRelazioniCampi.medpOffset + 1;

  // riporta la grid in visualizzazione
  grdRelazioniCampi.medpAggiornaCDS(True);

  // crea sql della relazione
  TWA136FRelazioniAnagrafeDM(WR302DM).A136FRelazioniAnagrafeMW.ComponiSQLRelazione(FSQLRelazione,cmbColonnaPilota.Text);
  TWA136FRelazioniAnagrafeDettFM(TWA136FRelazioniAnagrafe(Self.Owner).WDettaglioFM).MemoRelazione.Lines.Assign(TWA136FRelazioniAnagrafeDM(WR302DM).A136FRelazioniAnagrafeMW.ListaSQLRelazione);

  // disattiva modalità di modifica
  SetInModifica(False);
end;

end.
