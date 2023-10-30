unit A058UModPianif;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Math,
  StdCtrls, DBCtrls, Db, Buttons, ExtCtrls, Variants, A000UCostanti, A000USessione, Oracle, OracleData,
  Mask, A000UInterfaccia, Rp502Pro, StrUtils, InputPeriodo, Vcl.Menus, C004UParamForm,
  Vcl.Grids, Vcl.DBGrids, Vcl.CheckLst, USelI010, C013UCheckList, C180FunzioniGenerali;

type
  TA058FModPianif = class(TForm)
    pnlBase: TPanel;
    Label1: TLabel;
    DBText1: TDBText;
    Label6: TLabel;
    Label5: TLabel;
    lblPNT1: TLabel;
    lblPNT2: TLabel;
    lblSiglaT1: TLabel;
    lblSiglaT2: TLabel;
    dtxtArea: TDBText;
    lblArea: TLabel;
    EOrario: TDBLookupComboBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    cmbTurno1: TComboBox;
    cmbTurno1EU: TComboBox;
    cmbTurno2: TComboBox;
    cmbTurno2EU: TComboBox;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    DBText2: TDBText;
    Label3: TLabel;
    DBText3: TDBText;
    EAssenza1: TDBLookupComboBox;
    EAssenza2: TDBLookupComboBox;
    frmInputPeriodo: TfrmInputPeriodo;
    chkAntincendio: TCheckBox;
    memoNote: TMemo;
    chkReferente: TCheckBox;
    chkRichiestoDaTurnista: TCheckBox;
    dcmbArea: TDBLookupComboBox;
    D020: TDataSource;
    D265: TDataSource;
    D265B: TDataSource;
    D651: TDataSource;
    cmbTipoOpe: TDBLookupComboBox;
    lblTipoOpe: TLabel;
    dsrTipoOpe: TDataSource;
    pnlRicerca: TPanel;
    Splitter1: TSplitter;
    gpbSostituti: TGroupBox;
    dgrdSostituti: TDBGrid;
    gpbFiltri: TGroupBox;
    memFiltri: TMemo;
    pnlFiltri: TPanel;
    lblCampi: TLabel;
    lblColonne: TLabel;
    lblFiltri: TLabel;
    edtCampi: TEdit;
    btnCampi: TButton;
    btnEliminaTuttiFiltri: TButton;
    cmbColonne: TComboBox;
    gpbSostituto: TGroupBox;
    lblSostituto: TLabel;
    pmuSostituti: TPopupMenu;
    Sceglisostituto1: TMenuItem;
    N1: TMenuItem;
    CopiaInExcel1: TMenuItem;
    ImpostaFiltroColonna: TMenuItem;
    EliminaFiltroColonna: TMenuItem;
    AggiungiValoreFiltroColonna: TMenuItem;
    TogliValoreFiltroColonna: TMenuItem;
    N2: TMenuItem;
    lblOrdinamento: TLabel;
    N3: TMenuItem;
    ImpostaOrdinamentoColonna: TMenuItem;
    lstOrdinamento: TListBox;
    gpbFiltriDipendenti: TGroupBox;
    rgpPianificati: TRadioGroup;
    rgpEsuberiMin: TRadioGroup;
    rgpEsuberiMax: TRadioGroup;
    rgpDisponibili: TRadioGroup;
    gpbFiltriColonne: TGroupBox;
    btnImpostaFiltro: TButton;
    btnEliminaFiltro: TButton;
    chkValoriResidui: TCheckBox;
    chkFiltriRange: TCheckBox;
    chkFiltriRangeDa: TCheckBox;
    chkFiltriRangeA: TCheckBox;
    memFiltroObbligatorio: TMemo;
    Splitter2: TSplitter;
    btnAggiornaSostituti: TButton;
    procedure EOrarioClick(Sender: TObject);
    procedure cmbTurno1Change(Sender: TObject);
    procedure D020DataChange(Sender: TObject; Field: TField);
    procedure EOrarioKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EAssenza1CloseUp(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EOrarioExit(Sender: TObject);
    procedure dcmbAreaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure D651DataChange(Sender: TObject; Field: TField);
    procedure dcmbAreaCloseUp(Sender: TObject);
    procedure btnCampiClick(Sender: TObject);
    procedure btnAggiungiOrdinamentoClick(Sender: TObject);
    procedure lstOrdinamentoDblClick(Sender: TObject);
    procedure lstOrdinamentoDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure lstOrdinamentoDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure lstOrdinamentoMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnImpostaFiltroClick(Sender: TObject);
    procedure btnEliminaTuttiFiltriClick(Sender: TObject);
    procedure btnAggiornaSostitutiClick(Sender: TObject);
    procedure pmuSostitutiPopup(Sender: TObject);
    procedure Sceglisostituto1Click(Sender: TObject);
    procedure GestisciFiltroDaGrigliaClick(Sender: TObject);
    procedure CopiaInExcel1Click(Sender: TObject);
    procedure ImpostaOrdinamentoColonnaClick(Sender: TObject);
    procedure cmbColonneChange(Sender: TObject);
    procedure cmbColonneDblClick(Sender: TObject);
    procedure chkFiltriRangeClick(Sender: TObject);
    procedure chkFiltriRangeDaClick(Sender: TObject);
    procedure chkFiltriRangeAClick(Sender: TObject);
    procedure rgpPianificatiClick(Sender: TObject);
  private
    { Private declarations }
    C004FSost: TC004FParamForm;
    StartingPoint:TPoint;
    iPianificatiOld,iEsuberiMinOld,iEsuberiMaxOld,iDisponibiliOld:Integer;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    function _GetDataI: TDateTime;
    procedure _PutDataI(const Value: TDateTime);
    function _GetDataF: TDateTime;
    procedure _PutDataF(const Value: TDateTime);
    procedure CambioOrdinamentoSostituti;
    procedure RichiediAggiornaSostituti;
    procedure NascondiAggiornaSostituti;
    procedure selSostitutiVarAggiorna;
    procedure CaricaListaDatiFiltro;
    procedure ImpostaFiltroValoriOrigine;
    procedure CambioFiltroSostituti;
    procedure NumRecords(DataSet: TDataSet);
  public
    { Public declarations }
    MOD_T1,MOD_T2,
    MOD_T1EU,MOD_T2EU,
    MOD_Assenza1,MOD_Assenza2,
    MOD_SiglaT1, MOD_SiglaT2,
    MOD_NTurno1, MOD_NTurno2,
    MOD_Area, MOD_dArea,
    MOD_Antincendio,MOD_Note,MOD_Referente,
    MOD_RichiestoDaTurnista:String;
    ProgressivoOrigine: LongInt;
    property DataI:TDateTime read _GetDataI write _PutDataI;
    property DataF:TDateTime read _GetDataF write _PutDataF;
  end;

var
  A058FModPianif: TA058FModPianif;

implementation

uses A058UPianifTurniDtM1, A058UPianifTurni, A058UGrigliaPianif;

{$R *.DFM}

procedure TA058FModPianif.FormShow(Sender: TObject);
begin
  //Nascosto per ristrutturazione pianificazione turni. Se nessuno lo reclama, eliminare
  frmInputPeriodo.Visible:=False;
  GroupBox1.Height:=GroupBox1.Height - frmInputPeriodo.Height;
  memoNote.Top:=memoNote.Top - frmInputPeriodo.Height;
  memoNote.Height:=memoNote.Height + frmInputPeriodo.Height;
  //Nascosto per ristrutturazione pianificazione turni. Se nessuno lo reclama, eliminare

  DBText1.Visible:=EOrario.KeyValue <> '';
  DBText2.Visible:=EAssenza1.KeyValue <> '';
  DBText3.Visible:=EAssenza2.KeyValue <> '';

  with A058FPianifTurniDtM1 do
  begin
    Q020.SearchRecord('CODICE',EOrario.KeyValue,[srFromBeginning]);
    Q265.SearchRecord('CODICE',EAssenza1.KeyValue,[srFromBeginning]);
    Q265B.SearchRecord('CODICE',EAssenza2.KeyValue,[srFromBeginning]);
    selT651.SearchRecord('CODICE_AREA',dcmbArea.KeyValue,[srFromBeginning]);
  end;

  if StrToIntDef(MOD_T1,-1) >= 0 then
    CmbTurno1.Text:=MOD_T1 + ' - ' + IfThen(MOD_SiglaT1 <> '', MOD_SiglaT1, '(' + MOD_NTurno1 + ')');
  if StrToIntDef(MOD_T2,-1) >= 0 then
    CmbTurno2.Text:=MOD_T2 + ' - ' + IfThen(MOD_SiglaT2 <> '', MOD_SiglaT2, '(' + MOD_NTurno2 + ')');
  CmbTurno1EU.Text:=MOD_T1EU;
  CmbTurno2EU.Text:=MOD_T2EU;

  dcmbArea.Visible:=A058FPianifTurniDtM1.selT651.RecordCount > 0;
  lblArea.Visible:=dcmbArea.Visible;
  dtxtArea.Visible:=dcmbArea.KeyValue <> '';
  dtxtArea.Visible:=dtxtArea.Visible and dcmbArea.Visible;

  chkAntincendio.Checked:=MOD_Antincendio = 'S';
  chkReferente.Checked:=MOD_Referente = 'S';
  chkRichiestoDaTurnista.Checked:=MOD_RichiestoDaTurnista = 'S';
  memoNote.Lines.Text:=MOD_Note;

  cmbTurno1Change(cmbTurno1);
  cmbTurno1Change(cmbTurno2);

  A058FPianifTurniDtM1.PulisciDipSostituto;
  lblSostituto.Caption:='';
  if A058FPianifTurniDtM1.RicercaSostituti then
  begin
    A058FPianifTurniDtM1.procRichiediAggiornaSostituti:=RichiediAggiornaSostituti;
    A058FPianifTurniDtM1.procNumRecords:=NumRecords;
    C004FSost:=CreaC004(SessioneOracle,'A058_1',Parametri.ProgOper,False);
    GetParametriFunzione;
    CambioOrdinamentoSostituti;
    A058FPianifTurniDtM1.selSostitutiVarImposta(DataI,ProgressivoOrigine,EOrario.Text,lblPNT1.Caption,edtCampi.Text);
    btnAggiornaSostitutiClick(nil);//Apro il dataset dei sostituti
    ImpostaFiltroValoriOrigine;
    CambioFiltroSostituti;
    A058FPianifTurniDtm1.selSostitutiApplicaFiltro(True);
    NascondiAggiornaSostituti;
  end;
  Self.Width:=IfThen(A058FPianifTurniDtM1.RicercaSostituti,976,286);
  if A058FPianifTurniDtM1.RicercaSostituti then
  begin
    Self.BorderStyle:=bsSizeable;
    Self.WindowState:=wsMaximized;
  end
  else
  begin
    Self.BorderStyle:=bsDialog;
    Self.WindowState:=wsNormal;
  end;
  EOrario.Enabled:=not A058FPianifTurniDtM1.RicercaSostituti;
  Label5.Visible:=not A058FPianifTurniDtM1.RicercaSostituti;
  cmbTurno2.Visible:=not A058FPianifTurniDtM1.RicercaSostituti;
  cmbTurno2EU.Visible:=not A058FPianifTurniDtM1.RicercaSostituti;
  cmbTipoOpe.Enabled:=not A058FPianifTurniDtM1.RicercaSostituti;
  cmbTipoOpe.Visible:=A058FPianifTurniDtM1.RicercaSostituti;
  lblTipoOpe.Visible:=A058FPianifTurniDtM1.RicercaSostituti;
  EAssenza1.Enabled:=not A058FPianifTurniDtM1.RicercaSostituti;
  EAssenza2.Enabled:=not A058FPianifTurniDtM1.RicercaSostituti;
  chkFiltriRangeDa.Enabled:=False;
  chkFiltriRangeA.Enabled:=False;
end;

procedure TA058FModPianif.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if A058FPianifTurniDtM1.RicercaSostituti then
  begin
    PutParametriFunzione;
    FreeAndNil(C004FSost);
    //Resetto le impostazioni del selSostituti per non far andare in errore il vecchio filtro al nuovo accesso
    A058FPianifTurniDtM1.selSostituti.SetVariable('DATA',Null);
    A058FPianifTurniDtM1.selSostituti.Filter:='';
    A058FPianifTurniDtM1.selSostituti.Filtered:=False;
    A058FPianifTurniDtM1.selSostituti.Close;
  end;
end;

procedure TA058FModPianif.GetParametriFunzione;
var i,k:Integer;
    s,sFiltroObb,sNomeCampo,sNomeLogico,sValore:String;
begin
  //Dati anagrafici opzionali
  if A058FPianifTurniDtm1.selT082.FieldByName('SOST_DATI_INIZIO').AsString = '' then
    edtCampi.Text:=C004FSost.GetParametro('edtCampi','')
  else
  begin
    s:=A058FPianifTurniDtm1.selT082.FieldByName('SOST_DATI_INIZIO').AsString + ',';
    while Pos(',',s) > 0 do
    begin
      sNomeCampo:=Copy(s,1,Pos(',',s) - 1);
      edtCampi.Text:=edtCampi.Text + IfThen(edtCampi.Text <> '',',') + VarToStr(A058FPianifTurniDtm1.selI010.Lookup('NOME_CAMPO',sNomeCampo,'NOME_LOGICO'));
      s:=Copy(s,Pos(',',s) + 1);
    end;
  end;
  //Ordinamento
  for i:=0 to 99 do
  begin
    s:=C004FSost.GetParametro('lstOrdinamento_' + IfThen(i < 10,'0') + IntToStr(i),'');
    if s <> '' then
      lstOrdinamento.Items.Add(s);
  end;
  //Cancello i campi di ordinamento precedentemente salvati ma incompatibili con i campi iniziali del nuovo accesso
  CaricaListaDatiFiltro;
  for i:=lstOrdinamento.Items.Count - 1 downto 0 do
    if cmbColonne.Items.IndexOf(lstOrdinamento.Items[i]) < 0 then
      lstOrdinamento.Items.Delete(i);
  //Filtro obbligatorio
  if A058FPianifTurniDtm1.selT082.FieldByName('SOST_DATI_FILTRO').AsString <> '' then
  begin
    s:=A058FPianifTurniDtm1.selT082.FieldByName('SOST_DATI_FILTRO').AsString + ',';
    while Pos(',',s) > 0 do
    begin
      sNomeCampo:=Copy(s,1,Pos(',',s) - 1);
      sValore:=A058FPianifTurniDtm1.GetDatoPiuAssegnato(sNomeCampo,DataI);
      sFiltroObb:=sFiltroObb + ' AND V430.' + sNomeCampo + IfThen(sValore = '',' IS NULL',' = ''' + sValore + '''');

      sNomeLogico:='';
      for k:=Low(CAMPI_FISSI_RICERCA_SOSTITUTI) to High(CAMPI_FISSI_RICERCA_SOSTITUTI) do
        if CAMPI_FISSI_RICERCA_SOSTITUTI[k].NomeCampo = sNomeCampo then
        begin
          sNomeLogico:=CAMPI_FISSI_RICERCA_SOSTITUTI[k].Etichetta;
          Break;
        end;
      if sNomeLogico = '' then
      begin
        if Pos('430D_',sNomeCampo) > 0 then
        begin
          sNomeCampo:=StringReplace(sNomeCampo,'430D_','430',[rfReplaceAll]);
          sNomeLogico:='Descr. ';
        end;
        sNomeLogico:=sNomeLogico + VarToStr(A058FPianifTurniDtm1.selI010.Lookup('NOME_CAMPO',sNomeCampo,'NOME_LOGICO'));
      end;
      if sNomeLogico = '' then
        sNomeLogico:=sNomeCampo;
      memFiltroObbligatorio.Lines.Add(sNomeLogico + ' = ' + IfThen(sValore = '','#NULL#',sValore));

      s:=Copy(s,Pos(',',s) + 1);
    end;
  end;
  A058FPianifTurniDtm1.selSostituti.SetVariable('FILTRO_OBBLIGATORIO',sFiltroObb);
end;

procedure TA058FModPianif.PutParametriFunzione;
var i:Integer;
begin
  C004FSost.Cancella001;
  if A058FPianifTurniDtm1.selT082.FieldByName('SOST_DATI_INIZIO').AsString = '' then
    C004FSost.PutParametro('edtCampi',edtCampi.Text);
  for i:=0 to Min(99,lstOrdinamento.Items.Count - 1) do
    C004FSost.PutParametro('lstOrdinamento_' + IfThen(i < 10,'0') + IntToStr(i),lstOrdinamento.Items[i]);
  try SessioneOracle.Commit; except end;
end;

procedure TA058FModPianif.rgpPianificatiClick(Sender: TObject);
var i,k:Integer;
    SuffissoEliminaFiltro:String;
begin
  //Elimino i filtri attivi sulle colonne relative ad un filtro dipendenti deselezionato
  SuffissoEliminaFiltro:='';
  if (Sender as TRadioGroup).ItemIndex <> 0 then
  begin
    if (Sender = rgpPianificati) and (iPianificatiOld = 0) then
      SuffissoEliminaFiltro:='_PIANIF'
    else if (Sender = rgpEsuberiMin) and (iEsuberiMinOld = 0) then
      SuffissoEliminaFiltro:='_ESUBERO_MIN'
    else if (Sender = rgpEsuberiMax) and (iEsuberiMaxOld = 0) then
      SuffissoEliminaFiltro:='_ESUBERO_MAX'
    else if (Sender = rgpDisponibili) and (iDisponibiliOld = 0) then
      SuffissoEliminaFiltro:='_DISP';
    if SuffissoEliminaFiltro <> '' then
      for k:=Low(CAMPI_FISSI_RICERCA_SOSTITUTI) to High(CAMPI_FISSI_RICERCA_SOSTITUTI) do
        if Copy(CAMPI_FISSI_RICERCA_SOSTITUTI[k].NomeCampo,Length(CAMPI_FISSI_RICERCA_SOSTITUTI[k].NomeCampo) - Length(SuffissoEliminaFiltro) + 1) = SuffissoEliminaFiltro then
          for i:=memFiltri.Lines.Count - 1 downto 0 do
            if Copy(memFiltri.Lines[i],1,Pos(' = ',memFiltri.Lines[i]) - 1) = CAMPI_FISSI_RICERCA_SOSTITUTI[k].Etichetta then
            begin
              memFiltri.Lines.Delete(i);
              Break;
            end;
  end;
  //Aggiorno il filtro
  CambioFiltroSostituti;
  A058FPianifTurniDtm1.selSostitutiApplicaFiltro(True);
  //Salvataggio valori precedenti
  iPianificatiOld:=rgpPianificati.ItemIndex;
  iEsuberiMinOld:=rgpEsuberiMin.ItemIndex;
  iEsuberiMaxOld:=rgpEsuberiMax.ItemIndex;
  iDisponibiliOld:=rgpDisponibili.ItemIndex;
end;

procedure TA058FModPianif.D020DataChange(Sender: TObject; Field: TField);
begin
  if Field = nil then
    if Sender = D020 then
      DBText1.Visible:=True
    else if Sender = D265 then
      DBText2.Visible:=True
    else if Sender = D265B then
      DBText3.Visible:=True;
end;

procedure TA058FModPianif.D651DataChange(Sender: TObject; Field: TField);
begin
  dtxtArea.Visible:=VarToStr(dcmbArea.KeyValue) <> '';
end;

procedure TA058FModPianif.dcmbAreaCloseUp(Sender: TObject);
begin
  if (Sender as TDBLookupComboBox).KeyValue = Null then
    if Sender = dcmbArea then
      dtxtArea.Visible:=False;
end;

procedure TA058FModPianif.dcmbAreaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_DELETE) and (not(Sender as TDBLookupComboBox).ListVisible) then
    if Sender = dcmbArea then
      dtxtArea.Visible:=False;
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;

end;

procedure TA058FModPianif.cmbTurno1Change(Sender: TObject);
var
  bTrovato:boolean;
  nFascia:integer;
  sSigla, sPuntiNominali, MyTurno:string;
begin
  sSigla:='';
  sPuntiNominali:='';
  if VarToStr(EOrario.KeyValue) <> '' then
  begin
    with A058FPianifTurniDtM1 do
    begin
      MyTurno:=(Sender as TComboBox).Text;
      MyTurno:=Trim(Copy(MyTurno,1,pos('-',MyTurno) - 1));
      //valorizzo i dati calcolati relativi al primo turno
      if MyTurno = '0' then
      begin
        sSigla:='(0)';
        sPuntiNominali:='Riposo';
      end
      else if (MyTurno <> '') then
      begin
        bTrovato:=Q021.SearchRecord('CODICE', EOrario.KeyValue, [srFromBeginning]);
        if bTrovato then
        begin
          nFascia:=1;
          while (nFascia < StrToInt(MyTurno)) and (not Q021.Eof) do
          begin
            Q021.Next;
            nFascia:=nFascia + 1;
          end;
        end;
        bTrovato:=Q021.FieldByName('CODICE').AsString=EOrario.KeyValue;
        if bTrovato then
        begin
          sSigla:='(' + Q021.FieldByName('siglaturni').AsString + ')';
          sPuntiNominali:='E' + Q021.FieldByName('entrata').AsString + ' - U' + Q021.FieldByName('uscita').AsString;
        end;
      end;
    end;
  end;
  if Sender = cmbTurno1 then
  begin
    lblSiglaT1.Caption:=sSigla;
    lblPNT1.Caption:=sPuntiNominali;
  end
  else if Sender = cmbTurno2 then
  begin
    lblSiglaT2.Caption:=sSigla;
    lblPNT2.Caption:=sPuntiNominali;
  end;
  selSostitutiVarAggiorna;
  A058FPianifTurniDtM1.PulisciDipSostituto;
  lblSostituto.Caption:='';
end;

procedure TA058FModPianif.EOrarioClick(Sender: TObject);
begin
  cmbTurno1Change(cmbTurno1);
  cmbTurno1Change(cmbTurno2);
end;

procedure TA058FModPianif.EOrarioExit(Sender: TObject);
var
  i:Integer;
  MyTLabel:String;
begin
  selSostitutiVarAggiorna;
  if VarToStr(EOrario.KeyValue) = '' then
    exit;
  cmbTurno1.Items.Clear;
  cmbTurno1.Items.Add('0 - Riposo');
  i:=0;
  with A058FPianifTurniDtM1.Q021 do
    if SearchRecord('CODICE',VarToStr(EOrario.KeyValue),[srFromBeginning]) then
    repeat
      inc(i);
      if Not FieldByName('SIGLATURNI').IsNull then
        MyTLabel:='(' + FieldByName('SIGLATURNI').AsString + ')'
      else
        MyTLabel:='(' + FieldByName('NUMTURNO').AsString + ')';
      cmbTurno1.Items.Add(i.ToString + ' - ' + MyTLabel);
    until not SearchRecord('CODICE',VarToStr(EOrario.KeyValue),[]);
  cmbTurno2.Items.Assign(cmbTurno1.Items);
end;

procedure TA058FModPianif.EOrarioKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_DELETE) and (not(Sender as TDBLookupComboBox).ListVisible) then
    if Sender = EOrario then
      DBText1.Visible:=False
    else
      if Sender = EAssenza1 then
        DBText2.Visible:=False
      else if Sender = EAssenza2 then
        DBText3.Visible:=False;
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA058FModPianif.EAssenza1CloseUp(Sender: TObject);
begin
  if (Sender as TDBLookupComboBox).KeyValue = Null then
    if Sender = EOrario then
      DBText1.Visible:=False
    else
      if Sender = EAssenza1 then
        DBText2.Visible:=False
      else
        DbText3.Visible:=False;
end;

procedure TA058FModPianif.BitBtn1Click(Sender: TObject);
begin
  if A058FPianifTurniDtM1.RicercaSostituti then
  begin
    if VarToStr(EOrario.KeyValue) = '' then
      raise Exception.Create('E'' necessario selezionare un orario!');
    if CmbTurno1.Text = '' then
      raise Exception.Create('E'' necessario selezionare un turno!');
    if A058FPianifTurniDtM1.DipSostituto.Progressivo = -1 then
      raise Exception.Create('E'' necessario selezionare un sostituto!');
    if cmbTipoOpe.Text = '' then
      raise Exception.Create('E'' necessario selezionare un tipo operatore!');
  end;
  if VarToStr(EOrario.KeyValue) <> '' then
  begin
    if CmbTurno1.Text <> '' then
      if (StrToIntDef(Trim(Copy(CmbTurno1.Text,1,2)),-1) < 0) or (StrToIntDef(Trim(Copy(CmbTurno1.Text,1,2)),-1) > CmbTurno1.Items.Count - 1) then
        raise Exception.Create('Il primo turno non è disponibile nell''orario specificato!');
    if CmbTurno2.Text <> '' then
      if (StrToIntDef(Trim(Copy(CmbTurno2.Text,1,2)),-1) < 0) or (StrToIntDef(Trim(Copy(CmbTurno2.Text,1,2)),-1) > CmbTurno2.Items.Count - 1) then
        raise Exception.Create('Il secondo turno non è disponibile nell''orario specificato!');
  end;
  if (cmbTurno1.Text <> '') and (cmbTurno1.Text = cmbTurno2.Text) and (CmbTurno1EU.Text = CmbTurno2EU.Text) then
    //Non permetto i due turni uguali
    raise Exception.Create('Non si può pianificare 2 volte lo stesso turno!');
  if (cmbTurno1.Text = '') and (cmbTurno2.Text <> '') then
    //Non permetto di pianificare il secondo turno senza aver pianificato il primo
    raise Exception.Create('Non si può pianificare il secondo turno senza aver pianificato il primo!');
  if ((Trim(CmbTurno1EU.Text) <> '') and (CmbTurno1EU.Text <> 'E') and (CmbTurno1EU.Text <> 'U') or
      (Trim(CmbTurno2EU.Text) <> '') and (CmbTurno2EU.Text <> 'E') and (CmbTurno2EU.Text <> 'U')) then
    //Il tipo di turno può essere solo E od U
    raise Exception.Create('I valori ammessi sono solo E ed U!');
  //Controllo sul tipo cumulo se le assenze vengono registrate sulla tabella T040
  if ((A058FPianifTurniDtm1.selT082.fieldByName('MODALITA_LAVORO').AsString = 'O') or A058FPianifTurniDtm1.AssenzeOperative) and
     (MOD_Assenza1 <> EAssenza1.Text) and (A058FPianifTurniDtM1.R502ProDtM.ValStrT265[EAssenza1.Text,'TIPOCUMULO'] <> 'H') and
     (EAssenza1.Text <> '') then
    raise Exception.Create('Non è consentito specificare una causale che prevede delle regole di cumulo!');
  if ((A058FPianifTurniDtm1.selT082.fieldByName('MODALITA_LAVORO').AsString = 'O') or A058FPianifTurniDtm1.AssenzeOperative) and
     (MOD_Assenza2 <> EAssenza2.Text) and (A058FPianifTurniDtM1.R502ProDtM.ValStrT265[EAssenza2.Text,'TIPOCUMULO'] <> 'H') and
     (EAssenza2.Text <> '') then
    raise Exception.Create('Non è consentito specificare una causale che prevede delle regole di cumulo!');

  CmbTurno1EU.Text:=Trim(CmbTurno1EU.Text);
  CmbTurno2EU.Text:=Trim(CmbTurno2EU.Text);
  if cmbTurno1.Text <> '' then
    cmbTurno1.Text:=IntToStr(StrToInt(Trim(Copy(CmbTurno1.Text,1,2))));
  if cmbTurno2.Text <> '' then
    cmbTurno2.Text:=IntToStr(StrToInt(Trim(Copy(CmbTurno2.Text,1,2))));
  MOD_Area:=VarToStr(dcmbArea.KeyValue);
  MOD_dArea:=A058FPianifTurniDtm1.ReperisciDArea(MOD_Area);
  ModalResult:=mrOK;
end;

procedure TA058FModPianif.BitBtn2Click(Sender: TObject);
begin
  A058FPianifTurniDtM1.PulisciDipSostituto;
end;

procedure TA058FModPianif.btnCampiClick(Sender: TObject);
var i:Integer;
    sWhereI010,sCampiOld:String;
    TogliFiltro,TogliOrdinamento:Boolean;
    ListaCols:TStringList;
begin
  C013FCheckList:=TC013FCheckList.Create(nil);
  with C013FCheckList do
  try
    ListaCols:=TStringList.Create;
    with TSelI010.create(Self) do
      try
        //Lista dei campi visibili nel layout dell'utente, escludendo quelli di T030, le descrizioni e squadra e tipo operatore (che vengono visualizzati sempre)
        sWhereI010:='TABLE_NAME = ''V430_STORICO'' AND NOME_CAMPO NOT IN (''T430SQUADRA'',''T430TIPOOPE'') AND INSTR(NOME_CAMPO,''430D_'') = 0 AND NVL(ACCESSO,''N'') <> ''N''';
        //eventualmente ulteriormente filtrata sull'elenco indicato nel profilo di pianificazione
        if A058FPianifTurniDtm1.selT082.FieldByName('SOST_DATI_ELENCO').AsString <> '' then
          sWhereI010:=sWhereI010 + ' AND NOME_CAMPO IN (''' + StringReplace(A058FPianifTurniDtm1.selT082.FieldByName('SOST_DATI_ELENCO').AsString,',',''',''',[rfReplaceAll]) + ''')';
        Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'',sWhereI010,'NVL(POSIZIONE,999),NOME_LOGICO');
        while not Eof do
        begin
          ListaCols.Add(FieldByName('NOME_LOGICO').AsString);
          Next;
        end;
      finally
        Free;
      end;
    sCampiOld:=edtCampi.Text;
    clbListaDati.Items.Clear;
    clbListaDati.Items.Assign(ListaCols);
    R180PutCheckList(edtCampi.Text,99,C013FCheckList.clbListaDati);
    if ShowModal = mrOK then
    begin
      //Elenco dei campi da visualizzare
      edtCampi.Text:=R180GetCheckList(99,C013FCheckList.clbListaDati);
      //Elenco delle colonne della griglia
      CaricaListaDatiFiltro;
      cmbColonneChange(nil);

      //Adeguo il filtro
      TogliFiltro:=False;
      for i:=memFiltri.Lines.Count - 1 downto 0 do
      begin
        if cmbColonne.Items.IndexOf(Copy(memFiltri.Lines[i],1,Pos(' = ',memFiltri.Lines[i]) - 1)) < 0 then
        begin
          memFiltri.Lines.Delete(i);
          TogliFiltro:=True;
        end;
      end;
      if TogliFiltro then
      begin
        CambioFiltroSostituti;
        A058FPianifTurniDtm1.selSostitutiApplicaFiltro(True);
      end;

      //Adeguo l'ordinamento
      TogliOrdinamento:=False;
      for i:=lstOrdinamento.Items.Count - 1 downto 0 do
        if cmbColonne.Items.IndexOf(lstOrdinamento.Items[i]) < 0 then
        begin
          lstOrdinamento.Items.Delete(i);
          TogliOrdinamento:=True;
        end;
      if TogliOrdinamento then
        CambioOrdinamentoSostituti;

      if edtCampi.Text <> sCampiOld then
        selSostitutiVarAggiorna;
    end;
  finally
    ListaCols.Free;
    Release;
  end;
end;

procedure TA058FModPianif.chkFiltriRangeClick(Sender: TObject);
begin
  chkFiltriRangeDa.Enabled:=chkFiltriRange.Checked;
  chkFiltriRangeA.Enabled:=chkFiltriRange.Checked;
  chkFiltriRangeDa.Checked:=chkFiltriRange.Checked;
  chkFiltriRangeA.Checked:=chkFiltriRange.Checked;
  AggiungiValoreFiltroColonna.Enabled:=not chkFiltriRange.Checked;
  TogliValoreFiltroColonna.Enabled:=not chkFiltriRange.Checked;
end;

procedure TA058FModPianif.chkFiltriRangeDaClick(Sender: TObject);
begin
  if not chkFiltriRangeDa.Checked
  and chkFiltriRangeA.Enabled then
    chkFiltriRangeA.Checked:=True;
end;

procedure TA058FModPianif.chkFiltriRangeAClick(Sender: TObject);
begin
  if not chkFiltriRangeA.Checked
  and chkFiltriRangeDa.Enabled then
    chkFiltriRangeDa.Checked:=True;
end;

procedure TA058FModPianif.cmbColonneChange(Sender: TObject);
var sNomeCampo,sNomeLogico:String;
    i,k:Integer;
    Trovato,Modificabile,CampoAnni:Boolean;
begin
  sNomeLogico:=cmbColonne.Text;
  CampoAnni:=Copy(sNomeLogico,1,10) = 'Anzianità ';
  for k:=Low(CAMPI_FISSI_RICERCA_SOSTITUTI) to High(CAMPI_FISSI_RICERCA_SOSTITUTI) do
    if CAMPI_FISSI_RICERCA_SOSTITUTI[k].Etichetta = sNomeLogico then
    begin
      sNomeCampo:=CAMPI_FISSI_RICERCA_SOSTITUTI[k].NomeCampo;
      Break;
    end;
  if sNomeCampo = '' then
    sNomeCampo:=VarToStr(A058FPianifTurniDtm1.selI010.Lookup('NOME_LOGICO',IfThen(CampoAnni,Copy(sNomeLogico,11),sNomeLogico),'NOME_CAMPO')) + IfThen(CampoAnni,'_ANNI');
  //Non proseguo se è stato scelto un dato opzionale che non è ancora stato estratto dal dataset
  Trovato:=False;
  for i:=0 to A058FPianifTurniDtm1.selSostituti.FieldCount - 1 do
    if A058FPianifTurniDtm1.selSostituti.Fields[i].FieldName = sNomeCampo then
    begin
      Trovato:=True;
      Break;
    end;
  Modificabile:=not R180InConcat(sNomeCampo,A058FPianifTurniDtm1.selT082.FieldByName('SOST_DATI_FILTRO').AsString);
  btnImpostaFiltro.Enabled:=Trovato and Modificabile;
  chkValoriResidui.Enabled:=Trovato and Modificabile;
  chkFiltriRange.Enabled:=Trovato and Modificabile;
  btnEliminaFiltro.Enabled:=Trovato and Modificabile;
end;

procedure TA058FModPianif.cmbColonneDblClick(Sender: TObject);
begin
  if cmbColonne.ItemIndex < 0 then exit;
  if lstOrdinamento.Items.IndexOf(cmbColonne.Text) < 0 then
  begin
    lstOrdinamento.Items.Add(cmbColonne.Text);
    CambioOrdinamentoSostituti;
    selSostitutiVarAggiorna;
  end;
end;

procedure TA058FModPianif.btnAggiungiOrdinamentoClick(Sender: TObject);
begin
  if cmbColonne.ItemIndex < 0 then exit;
  if lstOrdinamento.Items.IndexOf(cmbColonne.Text) < 0 then
  begin
    lstOrdinamento.Items.Add(cmbColonne.Text);
    CambioOrdinamentoSostituti;
    selSostitutiVarAggiorna;
  end;
end;

procedure TA058FModPianif.lstOrdinamentoDblClick(Sender: TObject);
begin
  lstOrdinamento.Items.Delete(lstOrdinamento.ItemIndex);
  CambioOrdinamentoSostituti;
  selSostitutiVarAggiorna;
end;

procedure TA058FModPianif.lstOrdinamentoDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  DropPosition,StartPosition:Integer;
  DropPoint:TPoint;
begin
  inherited;
  DropPoint.X:=X;
  DropPoint.Y:=Y;
  with Source as TListBox do
  begin
    StartPosition:=ItemAtPos(StartingPoint,True);
    DropPosition:=ItemAtPos(DropPoint,True);
    Items.Move(StartPosition,DropPosition);
  end;
  CambioOrdinamentoSostituti;
  selSostitutiVarAggiorna;
end;

procedure TA058FModPianif.lstOrdinamentoDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept:=Source = lstOrdinamento;
end;

procedure TA058FModPianif.lstOrdinamentoMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  StartingPoint.X:=X;
  StartingPoint.Y:=Y;
end;

procedure TA058FModPianif.btnImpostaFiltroClick(Sender: TObject);
var BM:TBookmark;
    ListaVar:TStringList;
    sNomeCampo,sNomeCampoDesc,sNomeLogico,sTipoDato,sValore,sValoriSel:String;
    i,k,iFiltro,nDimensioneDato:Integer;
    FiltroRange,FiltroRangeDa,FiltroRangeA,FiltroRangeDaA,FiltroRangeOK,CampoAnni,Filtrato,AggiornaFiltro:Boolean;
begin
  if cmbColonne.ItemIndex < 0 then exit;
  FiltroRange:=((Sender = btnImpostaFiltro) or (Sender = ImpostaFiltroColonna)) and chkFiltriRange.Checked;
  FiltroRangeDa:=FiltroRange and chkFiltriRangeDa.Checked;
  FiltroRangeA:=FiltroRange and chkFiltriRangeA.Checked;
  FiltroRangeDaA:=FiltroRangeDa and FiltroRangeA;
  FiltroRangeOK:=False;

  sTipoDato:='VARCHAR2';
  sNomeLogico:=cmbColonne.Text;
  CampoAnni:=Copy(sNomeLogico,1,10) = 'Anzianità ';
  for k:=Low(CAMPI_FISSI_RICERCA_SOSTITUTI) to High(CAMPI_FISSI_RICERCA_SOSTITUTI) do
    if CAMPI_FISSI_RICERCA_SOSTITUTI[k].Etichetta = sNomeLogico then
    begin
      sNomeCampo:=CAMPI_FISSI_RICERCA_SOSTITUTI[k].NomeCampo;
      Break;
    end;
  if sNomeCampo = CAMPI_FISSI_RICERCA_SOSTITUTI[6].NomeCampo then //ultima uscita
    sTipoDato:='DATE';
  if sNomeCampo = '' then
  begin
    sNomeCampo:=VarToStr(A058FPianifTurniDtm1.selI010.Lookup('NOME_LOGICO',IfThen(CampoAnni,Copy(sNomeLogico,11),sNomeLogico),'NOME_CAMPO')) + IfThen(CampoAnni,'_ANNI');
    if not CampoAnni
    and (Pos('430D_',sNomeCampo) = 0) then
      sTipoDato:=VarToStr(A058FPianifTurniDtm1.selI010.Lookup('NOME_CAMPO',sNomeCampo,'DATA_TYPE'));
  end;
  if (Copy(sNomeCampo,Length(sNomeCampo) - 4) = '_ANNI')
  or (Copy(sNomeCampo,1,2) = 'N_') then
    sTipoDato:='NUMBER';

  ListaVar:=TStringList.Create;
  try
    with A058FPianifTurniDtm1.selSostituti do
      try
        nDimensioneDato:=Max(IfThen(FieldByName(sNomeCampo).Size = 0,999,FieldByName(sNomeCampo).Size),Length('#NULL#'));
        DisableControls;
        Filtrato:=Filtered;
        if not chkValoriResidui.Checked then
          A058FPianifTurniDtm1.selSostitutiApplicaFiltro(False);
        //Creo lista di valori
        BM:=GetBookMark;
        First;
        while not Eof do
        begin
          sValore:=FieldByName(sNomeCampo).AsString;
          //Aggiungo eventuale descrizione
          sNomeCampoDesc:='D_' + sNomeCampo;
          if A058FPianifTurniDtm1.selSostituti.FindField(sNomeCampoDesc) = nil then
            sNomeCampoDesc:=StringReplace(sNomeCampo,'430','430D_',[]);
          if (sNomeCampoDesc <> sNomeCampo)
          and (A058FPianifTurniDtm1.selSostituti.FindField(sNomeCampoDesc) <> nil)
          and (sValore <> '') then
            sValore:=Format('%-*s - %s',[nDimensioneDato,sValore,FieldByName(sNomeCampoDesc).AsString]);
          if (sNomeCampo = CAMPI_FISSI_RICERCA_SOSTITUTI[6].NomeCampo) //ultima uscita
          and (sValore = 'In servizio')
          and FiltroRange then
            sValore:='';
          if sValore <> '' then
          begin
            if sTipoDato = 'NUMBER' then
            try
              sValore:=R180LPad(R180FormattaNumero(sValore,'M=N,D=10,0=S'),21,'0');
            except
            end
            else if sTipoDato = 'DATE' then
            try
              if Pos('/',sValore) > 0 then
                sValore:=Copy(sValore,7,4) + '/' + Copy(sValore,4,2) + '/' + Copy(sValore,1,2) + Copy(sValore,11);
            except
            end;
          end;
          if (sValore = '') and not FiltroRange then
            sValore:='#NULL#';
          if (sValore <> '')
          and (ListaVar.IndexOf(sValore) < 0) then
            ListaVar.Add(sValore);
          Next;
        end;
        if BookmarkValid(BM) then
          GotoBookMark(BM);
      finally
        A058FPianifTurniDtm1.selSostitutiApplicaFiltro(Filtrato);
        FreeBookmark(BM);
        EnableControls;
      end;

    //Ordino i valori della lista
    ListaVar.Sort;
    if sTipoDato <> 'VARCHAR2' then
      for i:=0 to ListaVar.Count - 1 do
      begin
        sValore:=ListaVar.Strings[i];
        if sTipoDato = 'NUMBER' then
        try
          ListaVar.Strings[i]:=FloatToStr(StrToFloat(sValore));
        except
        end
        else if sTipoDato = 'DATE' then
        try
          if Pos('/',sValore) > 0 then
            ListaVar.Strings[i]:=Copy(sValore,9,2) + '/' + Copy(sValore,6,2) + '/' + Copy(sValore,1,4) + Copy(sValore,11);
        except
        end;
      end;

    //Cerco lista di valori precedentemente selezionati
    iFiltro:=-1;
    for i:=0 to memFiltri.Lines.Count - 1 do
      if Copy(memFiltri.Lines[i],1,Pos(' = ',memFiltri.Lines[i]) - 1) = cmbColonne.Text then
      begin
        iFiltro:=i;
        sValoriSel:=Copy(memFiltri.Lines[i],Pos(' = ',memFiltri.Lines[i]) + 3);
        sValoriSel:=StringReplace(sValoriSel,'<==>',';',[]);
      end;
    if Sender = AggiungiValoreFiltroColonna then
    begin
      sValore:=(Sender as TMenuItem).Caption;
      sValore:=Copy(sValore,Pos(' ',sValore) + 1);
      sValore:=Trim(Copy(sValore,1,Pos(' al filtro su ',sValore) - 1));
      sValoriSel:=sValoriSel + IfThen(sValoriSel <> '',';') + sValore;
    end;

    repeat
      AggiornaFiltro:=False;
      C013FCheckList:=TC013FCheckList.Create(nil);
      with C013FCheckList do
      try
        Caption:='<C013> Filtro colonna ' + sNomeLogico + IfThen(FiltroRange,' ') + IfThen(FiltroRangeDa,'da') + IfThen(FiltroRangeDaA,'-') + IfThen(FiltroRangeA,'a');
        clbListaDati.Items.Clear;
        clbListaDati.Items.Assign(ListaVar);
        R180PutCheckList(sValoriSel,nDimensioneDato,C013FCheckList.clbListaDati,';');
        if ((Sender <> btnImpostaFiltro) and (Sender <> ImpostaFiltroColonna))
        or (ShowModal = mrOK) then
        begin
          //Nuovo elenco dei valori selezionati
          if (Sender = btnEliminaFiltro) or (Sender = EliminaFiltroColonna) then
            sValoriSel:=''
          else if Sender = TogliValoreFiltroColonna then
          begin
            sValore:=(Sender as TMenuItem).Caption;
            sValore:=Copy(sValore,Pos(' ',sValore) + 1);
            sValore:=Trim(Copy(sValore,1,Pos(' dal filtro su ',sValore) - 1));
            sValoriSel:=StringReplace(';' + sValoriSel + ';',';' + sValore + ';',';',[rfReplaceAll]);
            sValoriSel:=Copy(sValoriSel,2,Length(sValoriSel) - 2);
          end
          else //(Sender = btnImpostaFiltro) or (Sender = ImpostaFiltroColonna) or (Sender = AggiungiValoreFiltroColonna)
            sValoriSel:=R180GetCheckList(nDimensioneDato,C013FCheckList.clbListaDati,';');
          if Length(sValoriSel) > 990 then
          begin
            R180PutCheckList(Copy(sValoriSel,1,990),nDimensioneDato,C013FCheckList.clbListaDati,';');
            sValoriSel:=R180GetCheckList(nDimensioneDato,C013FCheckList.clbListaDati,';');
            ShowMessage('Il filtro è stato ridotto perché supera i 990 caratteri!');
          end;
          AggiornaFiltro:=True;
          //Controllo il filtro impostato su un range di valori
          if FiltroRange then
          begin
            if sValoriSel <> '' then
            begin
              if FiltroRangeDaA
              and (   (Pos(';',sValoriSel) = 0)                                //selezionati meno di 2 valori
                   or (Pos(';',Copy(sValoriSel,Pos(';',sValoriSel) + 1)) > 0)) //selezionati più  di 2 valori
              then
                ShowMessage('Bisogna selezionare i 2 valori estremi del range da includere nel filtro!')
              else if not FiltroRangeDaA //and (FiltroRangeDa or FiltroRangeA)
              and (Pos(';',sValoriSel) > 0)                                    //selezionati più di 1 valore
              then
                ShowMessage('Bisogna selezionare il valore ' + IfThen(FiltroRangeDa,'minimo','massimo') + ' del range da includere nel filtro!')
              else
                FiltroRangeOK:=True;
            end
            else
              FiltroRangeOK:=True;
          end;
        end;
      finally
        FreeAndNil(C013FCheckList);
      end;
    until (not FiltroRange)  //filtro classico
      or FiltroRangeOK       //altrimenti filtro range valido
      or not AggiornaFiltro; //altrimenti filtro range non confermato
  finally
    ListaVar.Free;
  end;

  if AggiornaFiltro then
  begin
    //Formatto il filtro impostato su un range di valori
    if FiltroRange
    and (sValoriSel <> '') then
    begin
      if not FiltroRangeDaA then
      begin
        if FiltroRangeDa then
          sValoriSel:=sValoriSel + ';' + '...'
        else
          sValoriSel:='...' + ';' + sValoriSel;
      end;
      sValoriSel:=StringReplace(sValoriSel,';','<==>',[]);
    end;
    //Aggiorno elenco dei filtri attivi
    if iFiltro <> -1 then
    begin
      if sValoriSel = '' then
        memFiltri.Lines.Delete(iFiltro)
      else
        memFiltri.Lines[iFiltro]:=cmbColonne.Text + ' = ' + sValoriSel;
    end
    else if sValoriSel <> '' then
      memFiltri.Lines.Add(cmbColonne.Text + ' = ' + sValoriSel);
    //Applico il filtro
    CambioFiltroSostituti;
    A058FPianifTurniDtm1.selSostitutiApplicaFiltro(True);
  end;
end;

procedure TA058FModPianif.btnEliminaTuttiFiltriClick(Sender: TObject);
begin
  rgpPianificati.ItemIndex:=2;
  rgpEsuberiMin.ItemIndex:=2;
  rgpEsuberiMax.ItemIndex:=2;
  rgpDisponibili.ItemIndex:=2;
  iPianificatiOld:=rgpPianificati.ItemIndex;
  iEsuberiMinOld:=rgpEsuberiMin.ItemIndex;
  iEsuberiMaxOld:=rgpEsuberiMax.ItemIndex;
  iDisponibiliOld:=rgpDisponibili.ItemIndex;
  memFiltri.Lines.Clear;
  A058FPianifTurniDtm1.selSostitutiApplicaFiltro(False,'');
end;

procedure TA058FModPianif.btnAggiornaSostitutiClick(Sender: TObject);
begin
  try
    Screen.Cursor:=crHourGlass;
    A058FPianifTurniDtM1.AvviaRicercaSostituti;
  finally
    Screen.Cursor:=crDefault;
  end;
  NascondiAggiornaSostituti;
  cmbColonneChange(nil);
end;

procedure TA058FModPianif.pmuSostitutiPopup(Sender: TObject);
var NomeCampo,NomeLogico,ValoreCampo:String;
    CampoAnni:Boolean;
    k:Integer;
begin
  NomeCampo:=dgrdSostituti.SelectedField.FieldName;
  CampoAnni:=Copy(NomeCampo,Length(NomeCampo) - 4) = '_ANNI';
  for k:=Low(CAMPI_FISSI_RICERCA_SOSTITUTI) to High(CAMPI_FISSI_RICERCA_SOSTITUTI) do
    if CAMPI_FISSI_RICERCA_SOSTITUTI[k].NomeCampo = NomeCampo then
    begin
      NomeLogico:=CAMPI_FISSI_RICERCA_SOSTITUTI[k].Etichetta;
      Break;
    end;
  if NomeLogico = '' then
    NomeLogico:=IfThen(CampoAnni,'Anzianità ') + VarToStr(A058FPianifTurniDtm1.selI010.Lookup('NOME_CAMPO',IfThen(CampoAnni,Copy(NomeCampo,1,Length(NomeCampo) - 5),NomeCampo),'NOME_LOGICO'));
  ValoreCampo:=A058FPianifTurniDtM1.selSostituti.FieldByName(dgrdSostituti.SelectedField.FieldName).AsString;
  if ValoreCampo = '' then
    ValoreCampo:='#NULL#';
  ImpostaFiltroColonna.Caption:='Imposta filtro su ' + NomeLogico;
  EliminaFiltroColonna.Caption:='Elimina filtro su ' + NomeLogico;
  AggiungiValoreFiltroColonna.Caption:='Aggiungi ' + ValoreCampo + ' al filtro su ' + NomeLogico;
  TogliValoreFiltroColonna.Caption:='Togli ' + ValoreCampo + ' dal filtro su ' + NomeLogico;
  ImpostaOrdinamentoColonna.Caption:='Imposta ordinamento per ' + NomeLogico;
  ImpostaFiltroColonna.Enabled:=not R180InConcat(NomeCampo,A058FPianifTurniDtm1.selT082.FieldByName('SOST_DATI_FILTRO').AsString);
  EliminaFiltroColonna.Enabled:=not R180InConcat(NomeCampo,A058FPianifTurniDtm1.selT082.FieldByName('SOST_DATI_FILTRO').AsString);
  AggiungiValoreFiltroColonna.Enabled:=not R180InConcat(NomeCampo,A058FPianifTurniDtm1.selT082.FieldByName('SOST_DATI_FILTRO').AsString);
  TogliValoreFiltroColonna.Enabled:=not R180InConcat(NomeCampo,A058FPianifTurniDtm1.selT082.FieldByName('SOST_DATI_FILTRO').AsString);
end;

procedure TA058FModPianif.Sceglisostituto1Click(Sender: TObject);
var DipSostitutoApp: TDipSostituto;
    BM: TBookMark;
    nTrPianif: Integer;
begin
  with A058FPianifTurniDtM1 do
  begin
    if not selSostituti.Active then exit;
    if selSostituti.FieldByName('PROGRESSIVO_NV').AsInteger <= 0 then exit;
    //Prelevo la scelta in via temporanea per i controlli
    DipSostitutoApp.Progressivo:=selSostituti.FieldByName('PROGRESSIVO_NV').AsInteger;
    if SelAnagrafeA058.FindField('T430Badge') <> nil then //ricalca ragionamento in LeggiPianificazione
      DipSostitutoApp.Badge:=selSostituti.FieldByName('BADGE_NV').AsInteger;
    DipSostitutoApp.Matricola:=selSostituti.FieldByName('MATRICOLA').AsString;
    DipSostitutoApp.Cognome:=selSostituti.FieldByName('COGNOME').AsString;
    DipSostitutoApp.Nome:=selSostituti.FieldByName('NOME').AsString;
    DipSostitutoApp.Pianificato:=selSostituti.FieldByName('PIANIFICATO_NV').AsString = 'S';
    DipSostitutoApp.Squadra:=selSostituti.FieldByName('T430SQUADRA').AsString;
    DipSostitutoApp.TipoOpe:=selSostituti.FieldByName('T430TIPOOPE').AsString;
    //Effettuo i controlli
    if DipSostitutoApp.Progressivo = ProgressivoOrigine then
      raise exception.Create('Il dipendente selezionato (' + Format('%s %s %s',[DipSostitutoApp.Matricola,DipSostitutoApp.Cognome,DipSostitutoApp.Nome]) + ') ' +
                             'non è adatto come sostituto perché corrisponde al dipendente da sostitutire!');
    selT630.Close;
    selT630.SetVariable('DATA',DataI);
    selT630.SetVariable('PROGRESSIVO',DipSostitutoApp.Progressivo);
    selT630.Open;
    while not selT630.Eof do
    begin
      if not selT630.FieldByName('SQUADRA').IsNull
      and (selT630.FieldByName('SQUADRA').AsString <> A058FPianifTurniDtm1.SquadraRiferimento) then
        raise exception.Create('Il dipendente selezionato (' + Format('%s %s %s',[DipSostitutoApp.Matricola,DipSostitutoApp.Cognome,DipSostitutoApp.Nome]) + ') ' +
                               'non è adatto come sostituto perché è stato forzatamente assegnato alla squadra ' + selT630.FieldByName('SQUADRA').AsString + '!');
      if not selT630.FieldByName('COD_TIPOOPE').IsNull
      and (selT630.FieldByName('COD_TIPOOPE').AsString <> cmbTipoOpe.Text) then
        raise exception.Create('Il dipendente selezionato (' + Format('%s %s %s',[DipSostitutoApp.Matricola,DipSostitutoApp.Cognome,DipSostitutoApp.Nome]) + ') ' +
                               'non è adatto come sostituto perché è stato forzatamente assegnato al tipo operatore ' + selT630.FieldByName('COD_TIPOOPE').AsString + '!');
      if not selT630.FieldByName('ORARIO').IsNull
      and (selT630.FieldByName('ORARIO').AsString <> EOrario.Text) then
        raise exception.Create('Il dipendente selezionato (' + Format('%s %s %s',[DipSostitutoApp.Matricola,DipSostitutoApp.Cognome,DipSostitutoApp.Nome]) + ') ' +
                               'non è adatto come sostituto perché è stato forzatamente assegnato all''orario ' + selT630.FieldByName('ORARIO').AsString + '!');
      selT630.Next;
    end;
    selSostituti.DisableControls;
    BM:=selSostituti.GetBookmark;
    selSostituti.Filtered:=False;
    nTrPianif:=0;
    try
      selSostituti.SearchRecord('PROGRESSIVO_NV',DipSostitutoApp.Progressivo,[srFromBeginning]);
      repeat
        if not R180In(selSostituti.FieldByName('TR_PIANIF').AsString,['','0']) then
        begin
          inc(nTrPianif);
          if nTrPianif = 2 then
            raise exception.Create('Il dipendente selezionato (' + Format('%s %s %s',[DipSostitutoApp.Matricola,DipSostitutoApp.Cognome,DipSostitutoApp.Nome]) + ') ' +
                                   'non è adatto come sostituto perché ha già due turni pianificati!');
          if not selSostituti.FieldByName('SQ_PIANIF').IsNull
          and (selSostituti.FieldByName('SQ_PIANIF').AsString <> A058FPianifTurniDtm1.SquadraRiferimento) then
            raise exception.Create('Il dipendente selezionato (' + Format('%s %s %s',[DipSostitutoApp.Matricola,DipSostitutoApp.Cognome,DipSostitutoApp.Nome]) + ') ' +
                                   'non è adatto come sostituto perché ha già un turno pianificato per la squadra ' + selSostituti.FieldByName('SQ_PIANIF').AsString + '!');
          if not selSostituti.FieldByName('OP_PIANIF').IsNull
          and (selSostituti.FieldByName('OP_PIANIF').AsString <> cmbTipoOpe.Text) then
            raise exception.Create('Il dipendente selezionato (' + Format('%s %s %s',[DipSostitutoApp.Matricola,DipSostitutoApp.Cognome,DipSostitutoApp.Nome]) + ') ' +
                                   'non è adatto come sostituto perché ha già un turno pianificato per il tipo operatore ' + selSostituti.FieldByName('OP_PIANIF').AsString + '!');
        end;
      until not selSostituti.SearchRecord('PROGRESSIVO_NV',DipSostitutoApp.Progressivo,[]);
    finally
      selSostituti.Filtered:=True;
      if selSostituti.BookmarkValid(BM) then
        selSostituti.GotoBookMark(BM);
      selSostituti.EnableControls;
    end;
    //Confermo e visualizzo la scelta
    DipSostituto.Progressivo:=DipSostitutoApp.Progressivo;
    DipSostituto.Badge:=DipSostitutoApp.Badge;
    DipSostituto.Matricola:=DipSostitutoApp.Matricola;
    DipSostituto.Cognome:=DipSostitutoApp.Cognome;
    DipSostituto.Nome:=DipSostitutoApp.Nome;
    DipSostituto.Pianificato:=DipSostitutoApp.Pianificato;
    DipSostituto.Squadra:=DipSostitutoApp.Squadra;
    DipSostituto.TipoOpe:=DipSostitutoApp.TipoOpe;
    lblSostituto.Caption:=Format('%-8s %s %s',[DipSostituto.Matricola,DipSostituto.Cognome,DipSostituto.Nome]);
  end;
end;

procedure TA058FModPianif.GestisciFiltroDaGrigliaClick(Sender: TObject);
var NomeLogico:String;
begin
  NomeLogico:=Trim(Copy((Sender as TMenuItem).Caption,Pos(' su ',(Sender as TMenuItem).Caption) + 4));
  cmbColonne.Text:=NomeLogico;
  cmbColonne.ItemIndex:=cmbColonne.Items.IndexOf(NomeLogico);
  btnImpostaFiltroClick(Sender);
  cmbColonneChange(nil);
end;

procedure TA058FModPianif.ImpostaOrdinamentoColonnaClick(Sender: TObject);
var NomeLogico:String;
begin
  NomeLogico:=Trim(Copy((Sender as TMenuItem).Caption,Pos(' per ',(Sender as TMenuItem).Caption) + 5));
  cmbColonne.Text:=NomeLogico;
  cmbColonne.ItemIndex:=cmbColonne.Items.IndexOf(NomeLogico);
  cmbColonneDblClick(nil);
end;

procedure TA058FModPianif.CopiaInExcel1Click(Sender: TObject);
begin
  R180DBGridCopyToClipboard(dgrdSostituti,True,False);
end;

procedure TA058FModPianif.CambioOrdinamentoSostituti;
var sNomeCampo,sNomeLogico,sOrderBy:String;
    i,k:Integer;
    CampoAnni:Boolean;
begin
  //Imposto l'ordinamento di base
  if lstOrdinamento.Count = 0 then
  begin
    lstOrdinamento.Items.Add(CAMPI_FISSI_RICERCA_SOSTITUTI[1].Etichetta);//cognome
    lstOrdinamento.Items.Add(CAMPI_FISSI_RICERCA_SOSTITUTI[2].Etichetta);//nome
    lstOrdinamento.Items.Add(CAMPI_FISSI_RICERCA_SOSTITUTI[0].Etichetta);//matricola
  end;
  //Decodifico i campi per l'ordinamento
  for i:=0 to lstOrdinamento.Items.Count - 1 do
  begin
    sNomeLogico:=lstOrdinamento.Items[i];
    CampoAnni:=Copy(sNomeLogico,1,10) = 'Anzianità ';
    sNomeCampo:='';
    for k:=Low(CAMPI_FISSI_RICERCA_SOSTITUTI) to High(CAMPI_FISSI_RICERCA_SOSTITUTI) do
      if CAMPI_FISSI_RICERCA_SOSTITUTI[k].Etichetta = sNomeLogico then
      begin
        sNomeCampo:=CAMPI_FISSI_RICERCA_SOSTITUTI[k].NomeCampo;
        Break;
      end;
    if sNomeCampo = '' then
      sNomeCampo:=VarToStr(A058FPianifTurniDtm1.selI010.Lookup('NOME_LOGICO',IfThen(CampoAnni,Copy(sNomeLogico,11),sNomeLogico),'NOME_CAMPO')) + IfThen(CampoAnni,'_ANNI');
    if sNomeCampo = CAMPI_FISSI_RICERCA_SOSTITUTI[6].NomeCampo then //ultima uscita
      sNomeCampo:=sNomeCampo + '_NV';
    sOrderBy:=sOrderBy + IfThen(sOrderBy <> '',',') + sNomeCampo;
  end;
  //Aggiorno la variabile
  A058FPianifTurniDtM1.selSostituti.SetVariable('ORDERBY',sOrderBy);
end;

procedure TA058FModPianif.RichiediAggiornaSostituti;
begin
  dgrdSostituti.Visible:=False;
  gpbSostituti.Caption:='Lista sostituti';
  btnAggiornaSostituti.Visible:=True;
end;

procedure TA058FModPianif.NascondiAggiornaSostituti;
begin
  btnAggiornaSostituti.Visible:=False;
  dgrdSostituti.Visible:=True;
end;

procedure TA058FModPianif.selSostitutiVarAggiorna;
begin
  A058FPianifTurniDtM1.selSostitutiVarImposta(0,ProgressivoOrigine,EOrario.Text,lblPNT1.Caption,edtCampi.Text);
end;

procedure TA058FModPianif.CaricaListaDatiFiltro;
//Elenco dei campi filtrabili
var k:Integer;
    sCampi,sNomeLogico,sNomeCampo,sNomeCampoDesc,sNomeLogicoDesc:String;
begin
  cmbColonne.Items.Clear;
  //Dati fissi
  for k:=Low(CAMPI_FISSI_RICERCA_SOSTITUTI) to High(CAMPI_FISSI_RICERCA_SOSTITUTI) do
    cmbColonne.Items.Add(CAMPI_FISSI_RICERCA_SOSTITUTI[k].Etichetta);
  //Dati anagrafici opzionali
  sCampi:=edtCampi.Text + IfThen(edtCampi.Text <> '',',');
  while Pos(',',sCampi) > 0 do
  begin
    //Campo selezionato
    sNomeLogico:=Copy(sCampi,1,Pos(',',sCampi) - 1);
    cmbColonne.Items.Add(sNomeLogico);
    //Descrizione
    sNomeCampo:=VarToStr(A058FPianifTurniDtm1.selI010.Lookup('NOME_LOGICO',sNomeLogico,'NOME_CAMPO'));
    sNomeCampoDesc:=StringReplace(sNomeCampo,'430','430D_',[]);
    sNomeLogicoDesc:=VarToStr(A058FPianifTurniDtm1.selI010.Lookup('NOME_CAMPO',sNomeCampoDesc,'NOME_LOGICO'));
    if (sNomeLogicoDesc <> '') and (sNomeLogicoDesc <> sNomeLogico) then
      cmbColonne.Items.Add(sNomeLogicoDesc);
    //Anzianità
    cmbColonne.Items.Add('Anzianità ' + sNomeLogico);

    sCampi:=Copy(sCampi,Pos(',',sCampi) + 1);
  end;
  cmbColonne.ItemIndex:=cmbColonne.Items.IndexOf(cmbColonne.Text);
end;

procedure TA058FModPianif.ImpostaFiltroValoriOrigine;
var sCampi,sNomeLogico,sNomeCampo,sValore:String;
begin
  btnEliminaTuttiFiltriClick(nil);//Incompatibile con parametro memFiltri_ da C004
  //filtro dipendenti pianificati
  rgpPianificati.ItemIndex:=0;
  iPianificatiOld:=rgpPianificati.ItemIndex;
  //squadra pianificata
  AggiungiValoreFiltroColonna.Caption:='Aggiungi ' + A058FPianifTurniDtm1.SquadraRiferimento + ' al filtro su ' + CAMPI_FISSI_RICERCA_SOSTITUTI[11].Etichetta;
  GestisciFiltroDaGrigliaClick(AggiungiValoreFiltroColonna);
  //operatore pianificato
  if cmbTipoOpe.Text <> '' then
  begin
    AggiungiValoreFiltroColonna.Caption:='Aggiungi ' + cmbTipoOpe.Text + ' al filtro su ' + CAMPI_FISSI_RICERCA_SOSTITUTI[13].Etichetta;
    GestisciFiltroDaGrigliaClick(AggiungiValoreFiltroColonna);
  end;
  //Dati anagrafici opzionali
  sCampi:=edtCampi.Text + IfThen(edtCampi.Text <> '',',');
  while Pos(',',sCampi) > 0 do
  begin
    //Campo selezionato
    sNomeLogico:=Copy(sCampi,1,Pos(',',sCampi) - 1);
    sNomeCampo:=VarToStr(A058FPianifTurniDtm1.selI010.Lookup('NOME_LOGICO',sNomeLogico,'NOME_CAMPO'));
    sValore:='';
    with A058FPianifTurniDtm1 do
    try
      R180SetVariable(selV430,'DATA',DataI);
      R180SetVariable(selV430,'COLONNE',sNomeCampo);
      R180SetVariable(selV430,'PROGRESSIVO',ProgressivoOrigine);
      selV430.Open;
      sValore:=selV430.FieldByName(sNomeCampo).AsString;
    except
    end;
    if sValore <> '' then
    begin
      AggiungiValoreFiltroColonna.Caption:='Aggiungi ' + sValore + ' al filtro su ' + sNomeLogico;
      GestisciFiltroDaGrigliaClick(AggiungiValoreFiltroColonna);
    end;
    sCampi:=Copy(sCampi,Pos(',',sCampi) + 1);
  end;
  cmbColonne.Text:='';
  cmbColonne.ItemIndex:=-1;
end;

procedure TA058FModPianif.CambioFiltroSostituti;
var sNomeCampo,sNomeLogico,sTipoDato,sValori,sOr,sValore,sFiltro:String;
    i,k:Integer;
    CampoAnni:Boolean;
begin
  //Applico il filtro
  for i:=0 to memFiltri.Lines.Count - 1 do
  begin
    sNomeCampo:='';
    sTipoDato:='VARCHAR2';
    sNomeLogico:=Copy(memFiltri.Lines[i],1,Pos(' = ',memFiltri.Lines[i]) - 1);
    CampoAnni:=Copy(sNomeLogico,1,10) = 'Anzianità ';
    for k:=Low(CAMPI_FISSI_RICERCA_SOSTITUTI) to High(CAMPI_FISSI_RICERCA_SOSTITUTI) do
      if CAMPI_FISSI_RICERCA_SOSTITUTI[k].Etichetta = sNomeLogico then
      begin
        sNomeCampo:=CAMPI_FISSI_RICERCA_SOSTITUTI[k].NomeCampo;
        Break;
      end;
    if sNomeCampo = CAMPI_FISSI_RICERCA_SOSTITUTI[6].NomeCampo then //ultima uscita
      sTipoDato:='DATE';
    if sNomeCampo = '' then
    begin
      sNomeCampo:=VarToStr(A058FPianifTurniDtm1.selI010.Lookup('NOME_LOGICO',IfThen(CampoAnni,Copy(sNomeLogico,11),sNomeLogico),'NOME_CAMPO')) + IfThen(CampoAnni,'_ANNI');
      if not CampoAnni
      and (Pos('430D_',sNomeCampo) = 0) then
        sTipoDato:=VarToStr(A058FPianifTurniDtm1.selI010.Lookup('NOME_CAMPO',sNomeCampo,'DATA_TYPE'));
    end;
    if (Copy(sNomeCampo,Length(sNomeCampo) - 4) = '_ANNI')
    or (Copy(sNomeCampo,1,2) = 'N_') then
      sTipoDato:='NUMBER';

    sValori:=Copy(memFiltri.Lines[i],Pos(' = ',memFiltri.Lines[i]) + 3) + ';';
    sOr:='';
    //Gestione specifica per range di valori (cerco solo quelli compresi tra gli estremi specificati)
    if Pos('<==>',sValori) > 0 then
    begin
      if sNomeCampo = CAMPI_FISSI_RICERCA_SOSTITUTI[6].NomeCampo then //ultima uscita
        sNomeCampo:=sNomeCampo + '_NV'; //solo in caso di ricerca per range, uso il campo invisibile
      //Valore minimo
      sValore:=Copy(sValori,1,Pos('<==>',sValori) - 1);
      if sValore <> '...' then
      begin
        sOr:='(' + sNomeCampo + '>=';
        if sTipoDato = 'DATE' then
          sOr:=sOr + FloatToStr(StrToDateTime(sValore))
        else if sTipoDato = 'NUMBER' then
          sOr:=sOr + sValore
        else
          sOr:=sOr + '''' + StringReplace(sValore,'''','''''',[rfReplaceAll]) + '''';
        sOr:=sOr + ')';
      end;
      //Valore massimo
      sValore:=Copy(sValori,Pos('<==>',sValori) + 4);
      sValore:=Copy(sValore,1,Pos(';',sValore) - 1);
      if sValore <> '...' then
      begin
        sOr:=sOr + IfThen(sOr <> '',' AND ') + '(' + sNomeCampo + '<=';
        if sTipoDato = 'DATE' then
          sOr:=sOr + FloatToStr(StrToDateTime(sValore))
        else if sTipoDato = 'NUMBER' then
          sOr:=sOr + sValore
        else
          sOr:=sOr + '''' + StringReplace(sValore,'''','''''',[rfReplaceAll]) + '''';
        sOr:=sOr + ')';
      end;
      sOr:='(' + sOr + ')';//Serve a non mischiare la AND del range con le OR della gestione generica
      //Mi predispongo per la gestione generica (solo per le date)
      if sTipoDato = 'DATE' then
        sValori:=StringReplace(sValori,'<==>',';',[])
      else
        sValori:='';
    end;
    //Gestione generica (compreso range di valori, altrimenti per le date non verrebbero presi gli estremi specificati)
    while Pos(';',sValori) > 0 do
    begin
      sValore:=Copy(sValori,1,Pos(';',sValori) - 1);
      if sValore <> '...' then
        sOr:=sOr + IfThen(sOr <> '',' OR ') + '(' + sNomeCampo + '=' + IfThen(sValore = '#NULL#','NULL','''' + StringReplace(sValore,'''','''''',[rfReplaceAll]) + '''') + ')';
      sValori:=Copy(sValori,Pos(';',sValori) + 1);
    end;
    sFiltro:=sFiltro + IfThen(sFiltro <> '',' AND ') + '(' + sOr + ')';//Aggiungo al filtro la lista di condizioni finale del campo esaminato
  end;
  //Aggiungo al filtro le condizioni dei flag
  if rgpPianificati.ItemIndex <> 2 then
    sFiltro:=sFiltro + IfThen(sFiltro <> '',' AND ') + '(PIANIFICATO_NV = ''' + IfThen(rgpPianificati.ItemIndex = 0,'S','N') + ''')';
  if rgpEsuberiMin.ItemIndex <> 2 then
    sFiltro:=sFiltro + IfThen(sFiltro <> '',' AND ') + '(ESUBERO_MIN_NV = ''' + IfThen(rgpEsuberiMin.ItemIndex = 0,'S','N') + ''')';
  if rgpEsuberiMax.ItemIndex <> 2 then
    sFiltro:=sFiltro + IfThen(sFiltro <> '',' AND ') + '(ESUBERO_MAX_NV = ''' + IfThen(rgpEsuberiMax.ItemIndex = 0,'S','N') + ''')';
  if rgpDisponibili.ItemIndex <> 2 then
    sFiltro:=sFiltro + IfThen(sFiltro <> '',' AND ') + '(DISPONIBILE_NV = ''' + IfThen(rgpDisponibili.ItemIndex = 0,'S','N') + ''')';
  A058FPianifTurniDtm1.selSostitutiApplicaFiltro(False,sFiltro);//Riattivare il filtro al momento opportuno
end;

function TA058FModPianif._GetDataI: TDateTime;
begin
  Result:=frmInputPeriodo.DataInizio;
end;

procedure TA058FModPianif._PutDataI(const Value: TDateTime);
begin
  frmInputPeriodo.DataInizio:=Value;
end;

function TA058FModPianif._GetDataF: TDateTime;
begin
  Result:=frmInputPeriodo.DataFine;
end;

procedure TA058FModPianif._PutDataF(const Value: TDateTime);
begin
  frmInputPeriodo.DataFine:=Value;
end;

procedure TA058FModPianif.NumRecords(DataSet: TDataSet);
begin
  gpbSostituti.Caption:=Format('Lista sostituti (%s/%s)',[IntToStr(DataSet.RecNo),IntToStr(DataSet.RecordCount)]);
end;

end.
