unit WA093UOperazioniFiltroFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR200UBaseFM, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  IWCompListbox, meIWComboBox,meIWGrid, IWCompCheckbox, meIWCheckBox,
  IWControl, IWAdvCheckGroup, meTIWAdvCheckGroup, IWCompLabel, meIWLabel,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWCompEdit, meIWEdit,
  A000UInterfaccia, A000UCostanti, A000USessione, A000UMessaggi, C180FunzioniGenerali, L021Call,
  OracleData, Db, Oracle, meIWImageFile,
  IWCompExtCtrls, IWCompJQueryWidget, Menus, medpIWMessageDlg;

type
  TWA093FOperazioniFiltroFM = class(TWR200FBaseFM)
    edtAl: TmeIWEdit;
    lblDal: TmeIWLabel;
    edtDal: TmeIWEdit;
    lblOperatori: TmeIWLabel;
    lblFunzioni: TmeIWLabel;
    lblAl: TmeIWLabel;
    lblOrdinamento: TmeIWLabel;
    lblOperazioni: TmeIWLabel;
    cgpOperatori: TmeTIWAdvCheckGroup;
    cgpFunzioni: TmeTIWAdvCheckGroup;
    cgpOperazioni: TmeTIWAdvCheckGroup;
    cgpOrdinamento: TmeTIWAdvCheckGroup;
    lblTabelle: TmeIWLabel;
    cgpTabelle: TmeTIWAdvCheckGroup;
    lblOpzioni: TmeIWLabel;
    lblSelezioniDettaglio: TmeIWLabel;
    lblColonna: TmeIWLabel;
    lblValoreVecchio: TmeIWLabel;
    lblValoreNuovo: TmeIWLabel;
    cmbOper1: TmeIWComboBox;
    cmbOper2: TmeIWComboBox;
    cmbOper3: TmeIWComboBox;
    cmbColonna: TmeIWComboBox;
    edtValoreVecchio: TmeIWEdit;
    edtValoreNuovo: TmeIWEdit;
    chkValoriModificati: TmeIWCheckBox;
    imgSelezionaTuttoOperatori: TmeIWImageFile;
    imgDeselezionaTuttoOperatori: TmeIWImageFile;
    imgInvertiSelezioneOperatori: TmeIWImageFile;
    imgSelezionaTuttoFunzioni: TmeIWImageFile;
    imgDeselezionaTuttoFunzioni: TmeIWImageFile;
    imgInvertiSelezioneFunzioni: TmeIWImageFile;
    imgSelezionaTuttoTabelle: TmeIWImageFile;
    imgDeselezionaTuttoTabelle: TmeIWImageFile;
    imgInvertiSelezioneTabelle: TmeIWImageFile;
    imgVisualizzaRisultati: TmeIWImageFile;
    imgEliminaRegistrazioni: TmeIWImageFile;
    pmnAzioniOperatori: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    pmnAzioniFunzioni: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    pmnAzioniTabelle: TPopupMenu;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    pmnAzioniOperazioni: TPopupMenu;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    pmnAzioniOrdinamento: TPopupMenu;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    cgpOpzioni: TmeTIWAdvCheckGroup;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure imgSelezionaTuttoOperatoriAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure imgDeselezionaTuttoOperatoriAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure imgInvertiSelezioneOperatoriAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure imgSelezionaTuttoFunzioniAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure imgDeselezionaTuttoFunzioniAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure imgInvertiSelezioneFunzioniAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure imgSelezionaTuttoTabelleAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure imgDeselezionaTuttoTabelleAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure imgInvertiSelezioneTabelleAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure imgVisualizzaRisultatiClick(Sender: TObject);
    procedure imgEliminaRegistrazioniClick(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Deselezionatutto1Click(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure cgpOpzioniAsyncItemClick(Sender: TObject; EventParams: TStringList; Index: Integer);
  private
    procedure AbilitaSelezioniSulDettaglio(Abilita:Boolean);
    procedure SelezionatuttoClick(Sender: TObject; CheckGroup: TmeTIWAdvCheckGroup);
    procedure DeselezionatuttoClick(Sender: TObject; CheckGroup: TmeTIWAdvCheckGroup);
    procedure InvertiselezioneClick(Sender: TObject;CheckGroup: TmeTIWAdvCheckGroup);
    procedure OnRispostaEliminaReg(Sender: TObject; ModalResult: TmeIWModalResult; KeyID: String);
  public
    CdFnz:TStringList;
    CdOpz:String;
    procedure ReleaseOggetti; override;
  end;

implementation

{$R *.dfm}

uses WA093UOperazioni, WA093UOperazioniDM, WR100UBase, WA093UOperazioniRisultatiFM;

procedure TWA093FOperazioniFiltroFM.Invertiselezione1Click(Sender: TObject);
begin
  inherited;
  InvertiselezioneClick(Sender,cgpOperatori);
end;

procedure TWA093FOperazioniFiltroFM.IWFrameRegionCreate(Sender: TObject);
var
  i,j:integer;
begin
  inherited;
  CdFnz:=TStringList.Create;
  CdOpz:='CIM'; // se si inseriscono nuove operazioni aggiornare questa lista

  //****A093FStampa:=TA093FStampa.Create(nil);
  cmbOper1.ItemIndex:=0;
  cmbOper2.ItemIndex:=0;
  cmbOper3.ItemIndex:=0;

  edtAl.Text:=DateToStr(Parametri.DataLavoro);
  edtDal.Text:=DateToStr(Parametri.DataLavoro);
  cgpOperatori.Items.Clear;
  cgpTabelle.Items.Clear;
  cgpFunzioni.Items.Clear;
  cmbColonna.Items.Clear;
  with TWA093FOperazioniDM(TWA093FOperazioni(Self.Owner).WR300DM) do
  begin
    Q000_Operatori.First;
    while not(Q000_Operatori.Eof) do
    begin
      cgpOperatori.Items.Add(Q000_OperatoriOPERATORE.AsString);
      Q000_Operatori.Next;
    end;

    cgpFunzioni.Items.Sorted:=False;
    for i:=1 to High(FunzioniDisponibili) do
    begin
      if (L021GetMaschera(i) <> 'XXXX') and (FunzioniDisponibili[i].T <> 47) and L021VerificaApplicazione(Parametri.Applicazione,i) then
      begin
        cgpFunzioni.Items.Add(FunzioniDisponibili[i].G + ': ' + FunzioniDisponibili[i].N + ' (' + L021GetMaschera(i) + ')');
        if (L021GetMaschera(i) <> FunzioniDisponibili[i].SW) and (FunzioniDisponibili[i].SW <> '') then
          //aggiungo la funzione web
          cgpFunzioni.Items.Add(FunzioniDisponibili[i].G + ': ' + FunzioniDisponibili[i].N + ' (' + FunzioniDisponibili[i].SW + ')');
      end;
    end;
    cgpFunzioni.Items.Sorted:=True;
    CdFnz.Clear;
    for i:=0 to cgpFunzioni.Items.Count - 1 do
      for j:=1 to High(FunzioniDisponibili) do
      begin
        if (L021GetMaschera(j) <> 'XXXX') and (FunzioniDisponibili[j].T <> 47) and //Alberto 28/11/2005: escludo l'inserimento collettivo giustificativi, che ha la stessa sigla di A004
           L021VerificaApplicazione(Parametri.Applicazione,j) then
          if cgpFunzioni.Items[i] = FunzioniDisponibili[j].G + ': ' + FunzioniDisponibili[j].N + ' (' + L021GetMaschera(j) + ')' then
          begin
            CdFnz.Add(L021GetMaschera(j));
            Break;
          end
          else if cgpFunzioni.Items[i] = FunzioniDisponibili[j].G + ': ' + FunzioniDisponibili[j].N + ' (' + FunzioniDisponibili[j].SW + ')' then
          begin
            CdFnz.Add(FunzioniDisponibili[j].SW);
            Break;
          end;
      end;

    Q000_Tabelle.First;
    while not(Q000_Tabelle.Eof) do
    begin
      cgpTabelle.Items.Add(Q000_TabelleTABELLA.AsString);
      Q000_Tabelle.Next;
    end;
  end;

  AbilitaSelezioniSulDettaglio(False);

  if (Owner as TWR100FBase).SolaLettura then
  begin
    imgEliminaRegistrazioni.ImageFile.URL:='img/btnCestino_Disabled.png';
    imgEliminaRegistrazioni.Css:='';
    imgEliminaRegistrazioni.Enabled:=False;
  end;

end;

procedure TWA093FOperazioniFiltroFM.MenuItem10Click(Sender: TObject);
begin
  inherited;
  SelezionatuttoClick(Sender,cgpOrdinamento);
end;

procedure TWA093FOperazioniFiltroFM.MenuItem11Click(Sender: TObject);
begin
  inherited;
  DeselezionatuttoClick(Sender,cgpOrdinamento);
end;

procedure TWA093FOperazioniFiltroFM.MenuItem12Click(Sender: TObject);
begin
  inherited;
  InvertiselezioneClick(Sender,cgpOrdinamento);
end;

procedure TWA093FOperazioniFiltroFM.MenuItem1Click(Sender: TObject);
begin
  inherited;
  SelezionatuttoClick(Sender,cgpFunzioni);
end;

procedure TWA093FOperazioniFiltroFM.MenuItem2Click(Sender: TObject);
begin
  inherited;
  DeselezionatuttoClick(Sender,cgpFunzioni);
end;

procedure TWA093FOperazioniFiltroFM.MenuItem3Click(Sender: TObject);
begin
  inherited;
  InvertiselezioneClick(Sender,cgpFunzioni);
end;

procedure TWA093FOperazioniFiltroFM.MenuItem4Click(Sender: TObject);
begin
  inherited;
  SelezionatuttoClick(Sender,cgpTabelle);
end;

procedure TWA093FOperazioniFiltroFM.MenuItem5Click(Sender: TObject);
begin
  inherited;
  DeselezionatuttoClick(Sender,cgpTabelle);
end;

procedure TWA093FOperazioniFiltroFM.MenuItem6Click(Sender: TObject);
begin
  inherited;
  InvertiselezioneClick(Sender,cgpTabelle);
end;

procedure TWA093FOperazioniFiltroFM.MenuItem7Click(Sender: TObject);
begin
  inherited;
  SelezionatuttoClick(Sender,cgpOperazioni);
end;

procedure TWA093FOperazioniFiltroFM.MenuItem8Click(Sender: TObject);
begin
  inherited;
  DeselezionatuttoClick(Sender,cgpOperazioni);
end;

procedure TWA093FOperazioniFiltroFM.MenuItem9Click(Sender: TObject);
begin
  inherited;
  InvertiselezioneClick(Sender,cgpOperazioni);
end;

procedure TWA093FOperazioniFiltroFM.AbilitaSelezioniSulDettaglio(Abilita:Boolean);
begin
  cmbOper1.Enabled:=Abilita;
  cmbOper2.Enabled:=Abilita;
  cmbOper3.Enabled:=Abilita;
  cmbColonna.Enabled:=Abilita;
  edtValoreVecchio.Enabled:=Abilita;
  edtValoreNuovo.Enabled:=Abilita;
  chkValoriModificati.Enabled:=Abilita;
//  chkDipendentiSelezionati.Enabled:=Abilita;
//  chkRicercaDipendenti.Enabled:=Abilita;
end;

procedure TWA093FOperazioniFiltroFM.cgpOpzioniAsyncItemClick(Sender: TObject; EventParams: TStringList; Index: Integer);
var
  LAbilitaDett: Boolean;
begin
  if Index in [1,2] then
  begin
    LAbilitaDett:=cgpOpzioni.IsChecked[1] or cgpOpzioni.IsChecked[2];
    AbilitaSelezioniSulDettaglio(LAbilitaDett);

    // estrae l'elenco delle colonne da I001 per le selezioni su dettaglio
    if (LAbilitaDett) and
       (cmbColonna.Items.Count = 0) then
    begin
      with TWA093FOperazioniDM(TWA093FOperazioni(Self.Owner).WR300DM) do
      begin
        selCols.Open;
        while not selCols.Eof do
        begin
          cmbColonna.Items.Add(selCols.FieldByName('COLONNA').AsString);
          selCols.Next;
        end;
        selCols.Close;
      end;
    end;
  end;

  if (Index = 4) and cgpOpzioni.IsChecked[Index]  then
    cgpOpzioni.IsChecked[5]:=False
  else if (Index = 5) and cgpOpzioni.IsChecked[Index]  then
    cgpOpzioni.IsChecked[4]:=False;
end;

procedure TWA093FOperazioniFiltroFM.Deselezionatutto1Click(Sender: TObject);
begin
  inherited;
  DeselezionatuttoClick(Sender,cgpOperatori);
end;

procedure TWA093FOperazioniFiltroFM.imgDeselezionaTuttoFunzioniAsyncClick(Sender: TObject; EventParams: TStringList);
var
  i:Integer;
begin
  inherited;
  for i:=0 to cgpFunzioni.Items.Count - 1 do
    cgpFunzioni.IsChecked[i]:=False;
  cgpFunzioni.AsyncUpdate;
end;

procedure TWA093FOperazioniFiltroFM.imgDeselezionaTuttoOperatoriAsyncClick(Sender: TObject; EventParams: TStringList);
var
  i:Integer;
begin
  inherited;
  for i:=0 to cgpOperatori.Items.Count - 1 do
    cgpOperatori.IsChecked[i]:=False;
  cgpOperatori.AsyncUpdate;
end;

procedure TWA093FOperazioniFiltroFM.imgDeselezionaTuttoTabelleAsyncClick(
  Sender: TObject; EventParams: TStringList);
var
  i:Integer;
begin
  inherited;
  for i:=0 to cgpTabelle.Items.Count - 1 do
    cgpTabelle.IsChecked[i]:=False;
  cgpTabelle.AsyncUpdate;
end;

procedure TWA093FOperazioniFiltroFM.imgEliminaRegistrazioniClick(Sender: TObject);
begin
  if (Owner as TWR100FBase).SolaLettura then
    Exit;
  MsgBox.WebMessageDlg(Format(A000MSG_A093_DLG_FMT_ELIMINA,[edtDal.Text,edtAl.Text]),
                       mtConfirmation,[mbYes,mbNo],OnRispostaEliminaReg,'');
end;

procedure TWA093FOperazioniFiltroFM.imgInvertiSelezioneFunzioniAsyncClick(Sender: TObject; EventParams: TStringList);
var
  i:Integer;
begin
  inherited;
  for i:=0 to cgpFunzioni.Items.Count - 1 do
    cgpFunzioni.IsChecked[i]:=not cgpFunzioni.IsChecked[i];
  cgpFunzioni.AsyncUpdate;
end;

procedure TWA093FOperazioniFiltroFM.imgInvertiSelezioneOperatoriAsyncClick(Sender: TObject; EventParams: TStringList);
var
  i:Integer;
begin
  inherited;
  for i:=0 to cgpOperatori.Items.Count - 1 do
    cgpOperatori.IsChecked[i]:=not cgpOperatori.IsChecked[i];
  cgpOperatori.AsyncUpdate;
end;

procedure TWA093FOperazioniFiltroFM.imgInvertiSelezioneTabelleAsyncClick(
  Sender: TObject; EventParams: TStringList);
var
  i:Integer;
begin
  inherited;
  for i:=0 to cgpTabelle.Items.Count - 1 do
    cgpTabelle.IsChecked[i]:=not cgpTabelle.IsChecked[i];
  cgpTabelle.AsyncUpdate;
end;

procedure TWA093FOperazioniFiltroFM.imgSelezionaTuttoFunzioniAsyncClick(Sender: TObject; EventParams: TStringList);
var
 i:Integer;
begin
  inherited;
  for i:=0 to cgpFunzioni.Items.Count - 1 do
    cgpFunzioni.IsChecked[i]:=True;
  cgpFunzioni.AsyncUpdate;
end;

procedure TWA093FOperazioniFiltroFM.imgSelezionaTuttoOperatoriAsyncClick(Sender: TObject; EventParams: TStringList);
var
 i:Integer;
begin
  inherited;
  for i:=0 to cgpOperatori.Items.Count - 1 do
    cgpOperatori.IsChecked[i]:=True;
  cgpOperatori.AsyncUpdate;
end;

procedure TWA093FOperazioniFiltroFM.imgSelezionaTuttoTabelleAsyncClick(
  Sender: TObject; EventParams: TStringList);
var
 i:Integer;
begin
  inherited;
  for i:=0 to cgpTabelle.Items.Count - 1 do
    cgpTabelle.IsChecked[i]:=True;
  cgpTabelle.AsyncUpdate;
end;

procedure TWA093FOperazioniFiltroFM.imgVisualizzaRisultatiClick(Sender: TObject);
var i:Integer;
    S,SAnd:String;
    TuttiOperatori,TutteOperazioni: Boolean;
begin
  with TWA093FOperazioniDM(TWA093FOperazioni(Self.Owner).WR300DM) do
  begin
    with Q001 do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT COLONNA,VALORE_OLD,VALORE_NEW FROM I001_LOGDATI WHERE ID = :ID');
      // dettaglio filtrato sulle selezioni
      if cgpOpzioni.IsChecked[2] then
      begin
        if cmbColonna.Text <> '' then
          SQL.Add('AND COLONNA ' + cmbOper1.Text + ' ''' + cmbColonna.Text + '''');
        if edtValoreVecchio.Text <> '' then
          SQL.Add('AND VALORE_OLD ' + cmbOper2.Text + ' ''' + edtValoreVecchio.Text + '''');
        if edtValoreNuovo.Text <> '' then
          SQL.Add('AND VALORE_NEW ' + cmbOper3.Text + ' ''' + edtValoreNuovo.Text + '''');
        if chkValoriModificati.checked then
          SQL.Add('AND VALORE_OLD <> VALORE_NEW');
      end;
      SQL.Add('ORDER BY COLONNA');
    end;

    // prepara il dataset Q000
    with Q000 do
    begin
      Close;
      Filtered:=False;
      SQL.Clear;
      if cgpOpzioni.IsChecked[1] then
        SQL.Add('SELECT * FROM I000_LOGINFO T1,I001_LOGDATI T2 WHERE T1.ID = T2.ID AND DATA >= :DADATA AND DATA < :ADATA + 1')
      else
        SQL.Add('SELECT * FROM I000_LOGINFO T1 WHERE DATA >= :DADATA AND DATA < :ADATA + 1');

      // operatori
      TuttiOperatori:=True;
      S:='';
      for i:=0 to cgpOperatori.Items.Count - 1 do
        if cgpOperatori.IsChecked[i] then
        begin
          if S <> '' then
            S:=S + ',';
          S:=S + '''' + cgpOperatori.Items[i] + '''';
        end
        else
          TuttiOperatori:=False;
      if (S <> '') and (not TuttiOperatori) then
      begin
        if Pos(',',S) = 0 then
          SQL.Add('and OPERATORE = ' + S)
        else
          SQL.Add('and OPERATORE in (' + S + ')');
      end;

      // maschere
      S:='';
      for i:=0 to cgpFunzioni.Items.Count - 1 do
        if cgpFunzioni.IsChecked[i] then
        begin
          if S <> '' then
            S:=S + ',';
          S:=S + '''' + CdFnz[i] + '''';
        end;
      if S <> '' then
      begin
        if Pos(',',S) = 0 then
          SQL.Add('and MASCHERA = ' + S)
        else
          SQL.Add('and MASCHERA in (' + S + ')');
      end;

      // tabelle
      S:='';
      for i:=0 to cgpTabelle.Items.Count - 1 do
        if cgpTabelle.IsChecked[i] then
        begin
          if S <> '' then
            S:=S + ',';
          S:=S + '''' + cgpTabelle.Items[i] + '''';
        end;
      if S <> '' then
      begin
        if Pos(',',S) = 0 then
          SQL.Add('and TABELLA = ' + S)
        else
          SQL.Add('and TABELLA in (' + S + ')');
      end;

      // operazioni
      TutteOperazioni:=True;
      S:='';
      for i:=0 to cgpOperazioni.Items.Count - 1 do
        if cgpOperazioni.IsChecked[i] then
        begin
          if S <> '' then
            S:=S + ',';
          case i of
            0: S:=S + '''A''';
            1: S:=S + '''C''';
            2: S:=S + '''I''';
            3: S:=S + '''M''';
          end;
        end
        else
          TutteOperazioni:=False;
      if (S <> '') and (not TutteOperazioni) then
      begin
        if Pos(',',S) = 0 then
          SQL.Add('and OPERAZIONE = ' + S)
        else
          SQL.Add('and OPERAZIONE in (' + S + ')');
      end;

      // filtra i record per i dipendenti nella selezione anagrafica
      if cgpOpzioni.IsChecked[4] then
      begin
        // determina il filtro anagrafe per filtrare i progressivi
        S:=Copy(TWA093FOperazioni(Self.Owner).grdC700.selAnagrafe.SQL.Text,Pos(' FROM',TWA093FOperazioni(Self.Owner).grdC700.selAnagrafe.SQL.Text),Length(TWA093FOperazioni(Self.Owner).grdC700.selAnagrafe.SQL.Text));
        if Pos('ORDER BY ',S) > 0 then
          S:=Copy(S,1,Pos('ORDER BY ',S) - 1);
        SQL.Add(Format('AND PROGRESSIVO IN (SELECT DISTINCT PROGRESSIVO %s)',[S]));
      end;

      // ricerca per dipendenti
      // (è legata al dipendente correntemente selezionato in C700)
      if cgpOpzioni.IsChecked[5] then
      begin
        SQL.Add('AND PROGRESSIVO = :PROGRESSIVO');
      end;

      // selezioni su dettaglio
      if cgpOpzioni.IsChecked[1] then
      begin
        if cmbColonna.Text <> '' then
          SQL.Add('AND COLONNA ' + cmbOper1.Text + ' ''' + cmbColonna.Text + '''');
        if edtValoreVecchio.Text <> '' then
          SQL.Add('AND VALORE_OLD ' + cmbOper2.Text + ' ''' + edtValoreVecchio.Text + '''');
        if edtValoreNuovo.Text <> '' then
          SQL.Add('AND VALORE_NEW ' + cmbOper3.Text + ' ''' + edtValoreNuovo.Text + '''');
        if chkValoriModificati.checked then
          SQL.Add('AND VALORE_OLD <> VALORE_NEW');
      end;

      // ordinamento
      S:='';
      for i:=0 to cgpOrdinamento.Items.Count - 1 do
      begin
        if cgpOrdinamento.IsChecked[i] then
        begin
          if S <> '' then
            S:=S + ',';
          if UpperCase(cgpOrdinamento.Items[i]) = 'FUNZIONE' then
            S:=S + 'MASCHERA'
          else
            S:=S + cgpOrdinamento.Items[i];
        end;
      end;
      if S = '' then
        S:='order by T1.ID'
      else
        S:='order by ' + S + ',T1.ID';
      SQL.Add(S);

      // dichiarazione variabili
      DeleteVariables;
      DeclareVariable('DaData',otDate);
      DeclareVariable('AData',otDate);
      SetVariable('DaData',edtDal.Text);
      SetVariable('AData',edtAl.Text);
      if cgpOpzioni.IsChecked[5] then
      begin
        DeclareVariable('Progressivo',otString);
        SetVariable('Progressivo',0);
      end;
      if Pos(':DATALAVORO',UpperCase(SQL.Text)) > 0 then
      begin
        DeclareVariable('DataLavoro',otDate);
        SetVariable('DataLavoro',TWA093FOperazioni(Self.Owner).grdC700.selAnagrafe.GetVariable('DataLavoro'));
      end;
      //Definizione campi
      FieldDefs.Update;
      //Elimino i campi persistenti se ci sono
      for i:=FieldCount -1 downto 0 do
        Fields[i].Free;
      //Creo i campi persistenti e scrivo la descrizione della fascia
      //nell'intestazione di colonna
      for i:=0 to FieldDefs.Count - 1 do
        FieldDefs[i].CreateField(Q000);
      FieldByName('Maschera').Visible:=False;
      //Creo il Campo calcolato 'Funzione'
      with TStringField.Create(Self) do
      begin
        FieldName:='Funzione';
        Name:='Q000Funzione';
        DisplayLabel:='Funzione';
        Size:=50;
        DisplayWidth:=45;
        Calculated:=True;
        DataSet:=Q000;
      end;
      //Impostazione ordine di visualizzazione
      for i:=0 to cgpOrdinamento.Items.Count - 1 do
        FieldByName(cgpOrdinamento.Items[i]).Index:=i;
      TWA093FOperazioni(Self.Owner).grdC700.selAnagrafe.AfterScroll:=nil;
      if (cgpOpzioni.IsChecked[0]) or (cgpOpzioni.IsChecked[1]) then
        AfterScroll:=Q000AfterScroll
      else
        AfterScroll:=nil;
      Open;
      if (RecordCount = 0) and Assigned(AfterScroll) then
        Q000AfterScroll(Q000);
    end;

    if cgpOpzioni.IsChecked[5] then
    begin
      TWA093FOperazioni(Self.Owner).grdC700.selAnagrafe.AfterScroll:=QAnagraAfterScroll;
      TWA093FOperazioni(Self.Owner).grdC700.selAnagrafe.First;
    end
    else
      TWA093FOperazioni(Self.Owner).grdC700.selAnagrafe.AfterScroll:=nil;

    with TWA093FOperazioniRisultatiFM(TWA093FOperazioni(Self.Owner).WRisultatiFM) do
    begin
      if cgpOpzioni.IsChecked[5] then
      begin
        CreaGrid(grdAnagra);
        grdAnagra.Visible:=True;
      end
      else
      begin
        grdAnagra.Visible:=False;
      end;

      if cgpOpzioni.IsChecked[0] then
       begin
        CreaGrid(grdDettaglio);
        grdDettaglio.Visible:=True;
      end
      else
      begin
        grdDettaglio.Visible:=False;
      end;
      CreaGrid(grdRisultati);
      AggiornaVisualizzazioneGrid;
    end;
    TWA093FOperazioni(Self.Owner).grdTabControl.Tabs[TWA093FOperazioni(Self.Owner).WRisultatiFM].Visible:=True;
    TWA093FOperazioni(Self.Owner).grdTabControl.ActiveTab:=TWA093FOperazioni(Self.Owner).WRisultatiFM;
  end;
end;

procedure TWA093FOperazioniFiltroFM.ReleaseOggetti;
begin
  FreeAndNil(CdFnz);
end;

procedure TWA093FOperazioniFiltroFM.Selezionatutto1Click(Sender: TObject);
begin
  inherited;
  SelezionatuttoClick(Sender,cgpOperatori);
end;

procedure TWA093FOperazioniFiltroFM.SelezionatuttoClick(Sender: TObject;CheckGroup: TmeTIWAdvCheckGroup);
var
 i:Integer;
begin
  inherited;
  for i:=0 to CheckGroup.Items.Count - 1 do
    CheckGroup.IsChecked[i]:=True;
  CheckGroup.AsyncUpdate;
end;

procedure TWA093FOperazioniFiltroFM.DeselezionatuttoClick(Sender: TObject;CheckGroup: TmeTIWAdvCheckGroup);
var
  i:Integer;
begin
  inherited;
  for i:=0 to CheckGroup.Items.Count - 1 do
    CheckGroup.IsChecked[i]:=False;
  CheckGroup.AsyncUpdate;
end;

procedure TWA093FOperazioniFiltroFM.InvertiselezioneClick(Sender: TObject;CheckGroup: TmeTIWAdvCheckGroup);
var
  i:Integer;
begin
  inherited;
  for i:=0 to CheckGroup.Items.Count - 1 do
    CheckGroup.IsChecked[i]:=not CheckGroup.IsChecked[i];
  CheckGroup.AsyncUpdate;
end;

procedure TWA093FOperazioniFiltroFM.OnRispostaEliminaReg(Sender: TObject; ModalResult: TmeIWModalResult; KeyID: String);
var
  DallaData,AllaData:TDateTime;
begin
  if ModalResult = mrYes then
  begin
    try
      DallaData:=StrToDate(edtDal.Text);
      AllaData:=StrToDate(edtAl.Text);
    except
      on E:EConvertError do
      begin
        Msgbox.MessageBox(A000MSG_A093_ERR_DATA_INVALIDA,ERRORE);
        Exit;
      end;
    end;
    with ((Owner as TWA093FOperazioni).WR300DM as TWA093FOperazioniDM).delI000 do
    begin
      SetVariable('DAL',DallaData);
      SetVariable('AL',AllaData);
      SessioneOracle.Commit;
      try
        Execute;
        SessioneOracle.Commit;
      except
        on E:Exception do
        begin
          SessioneOracle.Rollback;
          raise Exception.Create(E.Message);
        end;
      end;
    end;
  end;
end;

end.


