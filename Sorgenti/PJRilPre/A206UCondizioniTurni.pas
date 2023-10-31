unit A206UCondizioniTurni;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGestStorico, ActnList, ImgList, DB, Menus, StdCtrls, ComCtrls,
  ToolWin, Mask, DBCtrls, Buttons, Grids, DBGrids, ExtCtrls,
  A000UCostanti, A000USessione, A000UInterfaccia, System.Actions,
  System.ImageList, A000UMessaggi, Vcl.Samples.Spin, C180FunzioniGenerali,
  C005UDatiAnagrafici, C013UCheckList, C700USelezioneAnagrafe, SelAnagrafe,
  Math, StrUtils, C600USelAnagrafe, OracleData;

type
  TA206FCondizioniTurni = class(TR004FGestStorico)
    Panel1: TPanel;
    dgrdCondizioni: TDBGrid;
    lblCodSquadra: TLabel;
    lblCodTipoOpe: TLabel;
    lblCodGiorno: TLabel;
    lblSiglaTurno: TLabel;
    dtxtCodSquadra: TDBText;
    dcmbCodSquadra: TDBLookupComboBox;
    dcmbCodTipoOpe: TDBLookupComboBox;
    dcmbCodGiorno: TDBLookupComboBox;
    dcmbSiglaTurno: TDBLookupComboBox;
    dtxtCodGiorno: TDBText;
    lblDecorrenzaFine: TLabel;
    dedtDecorrenzaFine: TDBEdit;
    lblCodOrario: TLabel;
    dtxtCodOrario: TDBText;
    dcmbCodOrario: TDBLookupComboBox;
    lblCodCondizione: TLabel;
    dtxtCodCondizione: TDBText;
    dcmbCodCondizione: TDBLookupComboBox;
    dedtPriorita: TDBEdit;
    lblPriorita: TLabel;
    lblLivelloAnomalia: TLabel;
    dedtLivelloAnomalia: TDBEdit;
    lblMinimo: TLabel;
    dedtMinimo: TDBEdit;
    lblMassimo: TLabel;
    dedtMassimo: TDBEdit;
    lblOttimale: TLabel;
    dedtOttimale: TDBEdit;
    lblValore: TLabel;
    dedtValore: TDBEdit;
    btnPriorita: TSpinButton;
    btnLivelloAnomalia: TSpinButton;
    btnMinimo: TSpinButton;
    btnMassimo: TSpinButton;
    btnOttimale: TSpinButton;
    btnValore: TButton;
    frmSelAnagrafe: TfrmSelAnagrafe;
    rgpTipoCondizioni: TRadioGroup;
    dmemValore: TDBMemo;
    C600frmSelAnagrafe: TC600frmSelAnagrafe;
    MnuCopia: TPopupMenu;
    Copia1: TMenuItem;
    CopiaInExcel: TMenuItem;
    PopupMenu1: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    dtxtCodTipoOpe: TDBText;
    dtxtSiglaTurno: TDBText;
    procedure FormShow(Sender: TObject);
    procedure TInserClick(Sender: TObject);
    procedure btnStoricizzaClick(Sender: TObject);
    procedure btnPrioritaUpClick(Sender: TObject);
    procedure btnPrioritaDownClick(Sender: TObject);
    procedure KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DButtonStateChange(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rgpTipoCondizioniClick(Sender: TObject);
    procedure btnValoreClick(Sender: TObject);
    procedure C600frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure Copia1Click(Sender: TObject);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure CambiaProgressivo;
  public
    { Public declarations }
    procedure AbilitaComponenti;
  end;

var
  A206FCondizioniTurni: TA206FCondizioniTurni;

procedure OpenA206FCondizioniTurni(Prog:LongInt);

implementation

{$R *.dfm}

uses
  A206UCondizioniTurniDM, A206UCondizioniTurniMW, A205USquadre, A206UCodiciCondizioniTurni;

procedure OpenA206FCondizioniTurni(Prog:LongInt);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA206FCondizioniTurni') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Application.CreateForm(TA206FCondizioniTurni, A206FCondizioniTurni);
  C700Progressivo:=Prog;
  Application.CreateForm(TA206FCondizioniTurniDM, A206FCondizioniTurniDM);
  try
    Screen.Cursor:=crDefault;
    A206FCondizioniTurni.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A206FCondizioniTurni.Free;
    A206FCondizioniTurniDM.Free;
  end;
end;

procedure TA206FCondizioniTurni.FormCreate(Sender: TObject);
begin
  inherited;
  C700Progressivo:=0;
  R001LinkC700:=False;
end;

procedure TA206FCondizioniTurni.FormShow(Sender: TObject);
begin
  inherited;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(A206FCondizioniTurniDM.A206MW,SessioneOracle,StatusBar,3,True);
  frmSelAnagrafe.NumRecords;
  C600frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,nil,0,False);
  C600frmSelAnagrafe.C600FSelezioneAnagrafe.OpenC600SelAnagrafe:=False;
  dcmbCodSquadra.ListSource:=A206FCondizioniTurniDM.A206MW.dsrT603;
  dcmbCodTipoOpe.ListSource:=A206FCondizioniTurniDM.A206MW.dsrTipoOpe;
  dcmbCodOrario.ListSource:=A206FCondizioniTurniDM.A206MW.dsrT020;
  dcmbSiglaTurno.ListSource:=A206FCondizioniTurniDM.A206MW.dsrT021;
  dcmbCodGiorno.ListSource:=A206FCondizioniTurniDM.A206MW.dsrGiorni;
  dcmbCodCondizione.ListSource:=A206FCondizioniTurniDM.A206MW.dsrT605;
  //voglio vedere tutto VisioneCorrente1Click(nil);
  A206FCondizioniTurniDM.selT606.RefreshRecord;//Per descrizioni primo record
  A206FCondizioniTurniDM.A206MW.RefreshDataSet;
  AbilitaComponenti;
end;

procedure TA206FCondizioniTurni.CambiaProgressivo;
begin
  with A206FCondizioniTurniDM do
  begin
    selT606.Close;
    selT606.SetVariable('PROGRESSIVO',IfThen(A206MW.TipoCond = 'G',-1,IfThen(A206MW.TipoCond = 'I',C700Progressivo,-2)));
    selT606.Open;
    GetDateDecorrenza;
    NumRecords;
  end;
end;

procedure TA206FCondizioniTurni.rgpTipoCondizioniClick(Sender: TObject);
begin
  inherited;
  with A206FCondizioniTurniDM.A206MW do
  begin
    TipoCond:=IfThen(rgpTipoCondizioni.ItemIndex = 0,'G',IfThen(rgpTipoCondizioni.ItemIndex = 1,'I','E'));
    selT605.Refresh;
    R001LinkC700:=TipoCond = 'I';
  end;
  CambiaProgressivo;
  AbilitaComponenti;
end;

procedure TA206FCondizioniTurni.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  inherited;
  C700Datalavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA206FCondizioniTurni.frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
begin
  inherited;
  C005DataVisualizzazione:=Parametri.DataLavoro;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA206FCondizioniTurni.TInserClick(Sender: TObject);
begin
  inherited;
  dedtDecorrenza.SetFocus;
end;

procedure TA206FCondizioniTurni.btnStoricizzaClick(Sender: TObject);
begin
  inherited;
  A206FCondizioniTurniDM.selT606.FieldByName('DECORRENZA_FINE').AsDateTime:=EncodeDate(3999,12,31);
  dedtDecorrenza.SetFocus;
end;

procedure TA206FCondizioniTurni.btnValoreClick(Sender: TObject);
begin
  inherited;
  with A206FCondizioniTurniDM.A206MW do
    if R180In(selT605a.FieldByName('VALORE_TIPO').AsString,['T020','T265']) then
    begin
      C013FCheckList:=TC013FCheckList.Create(nil);
      if selT605a.FieldByName('VALORE_TIPO').AsString = 'T020' then
      begin
        C013FCheckList.Caption:='<A206> Modelli orario';
        with selT020 do
        begin
          First;
          while not Eof do
          begin
            if FieldByName('CODICE').AsString <> '*' then
              C013FCheckList.clbListaDati.Items.Add(Format('%-5s %s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
            Next;
          end;
        end;
      end //T265
      else
      begin
        C013FCheckList.Caption:='<A206> Causali di assenza';
        with selT265 do
        begin
          First;
          while not Eof do
          begin
            C013FCheckList.clbListaDati.Items.Add(Format('%-5s %s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
            Next;
          end;
        end;
      end;
      with C013FCheckList do
      try
        R180PutCheckList(selT606.FieldByName('VALORE').AsString,5,clbListaDati);
        if ShowModal = mrOK then
          selT606.FieldByName('VALORE').AsString:=R180GetCheckList(5,clbListaDati);
      finally
        Release;
      end;
    end;
end;

procedure TA206FCondizioniTurni.C600frmSelAnagrafebtnSelezioneClick(Sender: TObject);
var S:String;
  function TrasformaV430(X:String):String;
  var Apice:Boolean;
      i:Integer;
  begin
    Result:='';
    i:=1;
    Apice:=False;
    while i <= Length(X) do
    begin
      if X[i] = '''' then
        Apice:=not Apice;
      if (not Apice) and (Copy(X,i,5) = 'V430.') then
      begin
        X:=Copy(X,1,i - 1) + Copy(X,i + 5,4) + '.' + Copy(X,i + 9,Length(X));
        inc(i,5);
      end;
      inc(i);
    end;
    Result:=X;
  end;
begin
  C600frmSelAnagrafe.C600DataDal:=C700DataLavoro;
  C600frmSelAnagrafe.C600DataLavoro:=C600frmSelAnagrafe.C600DataDal;
  C600frmSelAnagrafe.SelezionePeriodica:=False;
  C600frmSelAnagrafe.C600FSelezioneAnagrafe.grpSelezionePeriodica.ItemIndex:=0;
  C600frmSelAnagrafe.C600FSelezioneAnagrafe.chkCessati.Enabled:=False;
  C600frmSelAnagrafe.C600FSelezioneAnagrafe.chkCessati.Checked:=True;
  C600frmSelAnagrafe.C600FSelezioneAnagrafe.actConferma.Enabled:=A206FCondizioniTurniDM.selT606.State in [dsInsert,dsEdit];
  if Trim(A206FCondizioniTurniDM.selT606.FieldByName('VALORE').AsString) <> '' then
  begin
    C600frmSelAnagrafe.C600FSelezioneAnagrafe.actAnnullaSelezioneExecute(nil);
    C600frmSelAnagrafe.C600FSelezioneAnagrafe.SQLCreato.Text:=A206FCondizioniTurniDM.selT606.FieldByName('VALORE').AsString + CRLF + 'ORDER BY 2,3,1';
    C600frmSelAnagrafe.C600FSelezioneAnagrafe.PulisciVecchiaSelezione:=False;
    C600frmSelAnagrafe.C600FSelezioneAnagrafe.actConfermaExecute(nil);
  end
  else
  begin
    C600frmSelAnagrafe.C600FSelezioneAnagrafe.PulisciVecchiaSelezione:=True;
    C600frmSelAnagrafe.C600FSelezioneAnagrafe.actAnnullaSelezioneExecute(C600frmSelAnagrafe.C600FSelezioneAnagrafe.actAnnullaSelezione);
  end;
  C600frmSelAnagrafe.btnSelezioneClick(nil);
  if C600frmSelAnagrafe.C600ModalResult = mrOK then
  begin
    S:=EliminaRitornoACapo(Trim(C600frmSelAnagrafe.C600FSelezioneAnagrafe.SQLCreato.Text));
    if Pos('ORDER BY',UpperCase(S)) > 0 then
      S:=Copy(S,1,Pos('ORDER BY',UpperCase(S)) - 1);
    A206FCondizioniTurniDM.selT606.FieldByName('VALORE').AsString:=S;
  end;
end;

procedure TA206FCondizioniTurni.DButtonStateChange(Sender: TObject);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TA206FCondizioniTurni.DButtonDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TA206FCondizioniTurni.AbilitaComponenti;
var ModificaInCorso,AbilitaBrowseC700:Boolean;
    i:Integer;
begin
  inherited;
  with A206FCondizioniTurniDM.A206MW do
  begin
    actInserisci.Enabled:=actInserisci.Enabled and (TipoCond <> 'E');
    actModifica.Enabled:=actModifica.Enabled and (TipoCond <> 'E');
    actCancella.Enabled:=actCancella.Enabled and (TipoCond <> 'E');
    actStoricizza.Enabled:=actStoricizza.Enabled and (TipoCond <> 'E');
    if TipoCond = 'G' then
      StatusBar.Panels[3].Text:=''
    else
      frmSelAnagrafe.NumRecords;
    with dgrdCondizioni do
      for i:=0 to Columns.Count - 1 do
        if R180In(Columns[i].FieldName,['MATRICOLA','COGNOME','NOME']) then
        begin
          Columns[i].Visible:=TipoCond = 'E';
          if DataSource.DataSet <> nil then
            DataSource.DataSet.FieldByName(Columns[i].FieldName).Visible:=Columns[i].Visible;
        end;

    CondOK:=selT605a.SearchRecord('CODICE',A206FCondizioniTurniDM.selT606.FieldByName('COD_CONDIZIONE').AsString,[srFromBeginning]);

    ModificaInCorso:=(A206FCondizioniTurniDM.selT606.State in [dsEdit]) or
                     ((A206FCondizioniTurniDM.selT606.State in [dsInsert]) and InterfacciaR004.StoricizzazioneInCorso);
    dcmbCodSquadra.Enabled:=CondOK and not ModificaInCorso and (selT605a.FieldByName('SQUADRA_ABILITA').AsString = 'S');
    lblCodSquadra.Enabled:=dcmbCodSquadra.Enabled;
    dcmbCodTipoOpe.Enabled:=CondOK and not ModificaInCorso and (selT605a.FieldByName('TIPOOPE_ABILITA').AsString = 'S');
    lblCodTipoOpe.Enabled:=dcmbCodTipoOpe.Enabled;
    dcmbCodOrario.Enabled:=CondOK and not ModificaInCorso and (selT605a.FieldByName('ORARIO_ABILITA').AsString = 'S');
    lblCodOrario.Enabled:=dcmbCodOrario.Enabled;
    dcmbSiglaTurno.Enabled:=CondOK and not ModificaInCorso and (selT605a.FieldByName('TURNO_ABILITA').AsString = 'S');
    lblSiglaTurno.Enabled:=dcmbSiglaTurno.Enabled;
    dcmbCodGiorno.Enabled:=CondOK and not ModificaInCorso and (selT605a.FieldByName('GIORNO_ABILITA').AsString = 'S');
    lblCodGiorno.Enabled:=dcmbCodGiorno.Enabled;
    dcmbCodCondizione.Enabled:=not ModificaInCorso;
    lblCodCondizione.Enabled:=dcmbCodCondizione.Enabled;

    ModificaInCorso:=A206FCondizioniTurniDM.selT606.State in [dsInsert,dsEdit];
    rgpTipoCondizioni.Enabled:=not ModificaInCorso;
    dedtPriorita.Enabled:=CondOK;
    btnPriorita.Enabled:=ModificaInCorso and dedtPriorita.Enabled;
    lblPriorita.Enabled:=dedtPriorita.Enabled;
    dedtLivelloAnomalia.Enabled:=CondOK;
    btnLivelloAnomalia.Enabled:=ModificaInCorso and dedtLivelloAnomalia.Enabled;
    lblLivelloAnomalia.Enabled:=dedtLivelloAnomalia.Enabled;
    dedtMinimo.Enabled:=CondOK and (selT605a.FieldByName('MINIMO_ABILITA').AsString = 'S');
    btnMinimo.Enabled:=ModificaInCorso and dedtMinimo.Enabled;
    lblMinimo.Enabled:=dedtMinimo.Enabled;
    dedtOttimale.Enabled:=CondOK and (selT605a.FieldByName('OTTIMALE_ABILITA').AsString = 'S');
    btnOttimale.Enabled:=ModificaInCorso and dedtOttimale.Enabled;
    lblOttimale.Enabled:=dedtOttimale.Enabled;
    dedtMassimo.Enabled:=CondOK and (selT605a.FieldByName('MASSIMO_ABILITA').AsString = 'S');
    btnMassimo.Enabled:=ModificaInCorso and dedtMassimo.Enabled;
    lblMassimo.Enabled:=dedtMassimo.Enabled;

    dmemValore.Visible:=CondOK and (selT605a.FieldByName('VALORE_ABILITA').AsString = 'S') and (selT605a.FieldByName('VALORE_TIPO').AsString = 'ANAG');
    C600frmSelAnagrafe.Visible:=dmemValore.Visible;
    dedtValore.Visible:=not dmemValore.Visible;
    dedtValore.Enabled:=CondOK and (selT605a.FieldByName('VALORE_ABILITA').AsString = 'S') and (selT605a.FieldByName('VALORE_TIPO').AsString = '');
    btnValore.Visible:=CondOK and (selT605a.FieldByName('VALORE_ABILITA').AsString = 'S') and R180In(selT605a.FieldByName('VALORE_TIPO').AsString,['T020','T265']);
    btnValore.Enabled:=ModificaInCorso;
    lblValore.Enabled:=CondOK and (selT605a.FieldByName('VALORE_ABILITA').AsString = 'S');

    frmSelAnagrafe.Enabled:=not ModificaInCorso;
    frmSelAnagrafe.Visible:=TipoCond <> 'G';
    AbilitaBrowseC700:=TipoCond = 'I';
    frmSelAnagrafe.btnRicerca.Visible:=AbilitaBrowseC700;
    frmSelAnagrafe.btnPrimo.Visible:=AbilitaBrowseC700;
    frmSelAnagrafe.btnPrecedente.Visible:=AbilitaBrowseC700;
    frmSelAnagrafe.btnSuccessivo.Visible:=AbilitaBrowseC700;
    frmSelAnagrafe.btnUltimo.Visible:=AbilitaBrowseC700;
    frmSelAnagrafe.R003Datianagrafici.Visible:=AbilitaBrowseC700;
    frmSelAnagrafe.lblDipendente.Visible:=AbilitaBrowseC700;
  end;
end;

procedure TA206FCondizioniTurni.btnPrioritaUpClick(Sender: TObject);
var edtComp: TDBEdit;
begin
  inherited;
  edtComp:=nil;
  if (Sender as TSpinButton).Name = btnPriorita.Name then
    edtComp:=dedtPriorita
  else if (Sender as TSpinButton).Name = btnLivelloAnomalia.Name then
    edtComp:=dedtLivelloAnomalia
  else if (Sender as TSpinButton).Name = btnMinimo.Name then
    edtComp:=dedtMinimo
  else if (Sender as TSpinButton).Name = btnOttimale.Name then
    edtComp:=dedtOttimale
  else if (Sender as TSpinButton).Name = btnMassimo.Name then
    edtComp:=dedtMassimo;
  if edtComp <> nil then
    edtComp.DataSource.DataSet.FieldByName(edtComp.DataField).AsInteger:=StrToIntDef(edtComp.Text,0) + 1;
end;

procedure TA206FCondizioniTurni.btnPrioritaDownClick(Sender: TObject);
var edtComp: TDBEdit;
begin
  inherited;
  edtComp:=nil;
  if (Sender as TSpinButton).Name = btnPriorita.Name then
    edtComp:=dedtPriorita
  else if (Sender as TSpinButton).Name = btnLivelloAnomalia.Name then
    edtComp:=dedtLivelloAnomalia
  else if (Sender as TSpinButton).Name = btnMinimo.Name then
    edtComp:=dedtMinimo
  else if (Sender as TSpinButton).Name = btnOttimale.Name then
    edtComp:=dedtOttimale
  else if (Sender as TSpinButton).Name = btnMassimo.Name then
    edtComp:=dedtMassimo;
  if edtComp <> nil then
    edtComp.DataSource.DataSet.FieldByName(edtComp.DataField).AsInteger:=StrToIntDef(edtComp.Text,0) - 1;
end;

procedure TA206FCondizioniTurni.KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
      begin
        (Sender as TDBLookupComboBox).Field.DataSet.FieldByName((Sender as TDBLookupComboBox).Field.KeyFields).Clear;
        (Sender as TDBLookupComboBox).Field.FocusControl;
      end
      else
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA206FCondizioniTurni.Nuovoelemento1Click(Sender: TObject);
begin
  inherited;
  if PopupMenu1.PopupComponent = dcmbCodSquadra then
    OpenA205Squadre(VarToStr(dcmbCodSquadra.KeyValue))
  else if PopupMenu1.PopupComponent = dcmbCodCondizione then
    OpenA206FCodiciCondizioniTurni(VarToStr(dcmbCodCondizione.KeyValue));
end;

procedure TA206FCondizioniTurni.Copia1Click(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(dgrdCondizioni,'S');
  R180DBGridCopyToClipboard(dgrdCondizioni,Sender = CopiaInExcel);
end;

procedure TA206FCondizioniTurni.FormDestroy(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

end.
