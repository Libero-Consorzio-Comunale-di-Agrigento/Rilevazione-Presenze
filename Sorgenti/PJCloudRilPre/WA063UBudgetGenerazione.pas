unit WA063UBudgetGenerazione;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR100UBase, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton,
  meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWHTMLControls, meIWLink, IWCompListbox, meIWComboBox, IWCompCheckbox,
  meIWCheckBox, medpIWMultiColumnComboBox,
  Vcl.Menus, IWCompEdit, meIWEdit, IWCompLabel, meIWLabel, meIWRadioGroup,
  meIWImageFile, medpIWImageButton, OracleData, StrUtils,
  IWApplication, A000UInterfaccia, A000UCostanti, A000UMessaggi,
  C180FunzioniGenerali, A063UBudgetGenerazioneMW,
  medpIWMessageDlg, IWAdvCheckGroup, meTIWAdvCheckGroup;

type
  TWA063FBudgetGenerazione = class(TWR100FBase)
    lblAnno: TmeIWLabel;
    edtAnno: TmeIWEdit;
    pmnAzioni: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    dcmbTipo: TMedpIWMultiColumnComboBox;
    chkAssegnaBudget: TmeIWCheckBox;
    chkCalcolaFruito: TmeIWCheckBox;
    chkRiportaResiduo: TmeIWCheckBox;
    chkControlloFiltriAnagrafe: TmeIWCheckBox;
    chkDuplicaGruppi: TmeIWCheckBox;
    cmbAMeseBudget: TmeIWComboBox;
    lblAlMeseBudget: TmeIWLabel;
    lblDalMeseFruito: TmeIWLabel;
    cmbDaMeseFruito: TmeIWComboBox;
    lblAlMeseFruito: TmeIWLabel;
    cmbAMeseFruito: TmeIWComboBox;
    lblDalMeseResiduo: TmeIWLabel;
    cmbDaMeseResiduo: TmeIWComboBox;
    lblAlMeseResiduo: TmeIWLabel;
    cmbAMeseResiduo: TmeIWComboBox;
    lblMesiSuccResiduo: TmeIWLabel;
    lblDuplicaSuAnno: TmeIWLabel;
    edtDuplicaSuAnno: TmeIWEdit;
    rgpOreImporti: TmeIWRadioGroup;
    lblOreImporti: TmeIWLabel;
    lblTipo: TmeIWLabel;
    imgEsegui: TmedpIWImageButton;
    imgAnomalie: TmedpIWImageButton;
    lblAssegnaBudget: TmeIWLabel;
    lblCalcolaFruito: TmeIWLabel;
    lblRiportaResiduo: TmeIWLabel;
    lblControlloFiltriAnagrafe: TmeIWLabel;
    lblDuplicaGruppi: TmeIWLabel;
    lblDescTipo: TmeIWLabel;
    btnCambioData: TmeIWButton;
    clbGruppi: TmeTIWAdvCheckGroup;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure edtAnnoAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure btnCambioDataClick(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure chkAssegnaBudgetClick(Sender: TObject);
    procedure imgEseguiClick(Sender: TObject);
    procedure imgAnomalieClick(Sender: TObject);
    procedure dcmbTipoChange(Sender: TObject; Index: Integer);
  private
    { Private declarations }
    wCodGruppo,wTipo:String;
    wDecorrenza:TDateTime;
    MGen,nRec:Integer;
    Data,DataMin,DataMax:TDateTime;
    A063MW: TA063FBudgetGenerazioneMW;
    procedure GetParametriFunzione;
    procedure GetParametriFunzione2;
    procedure PutParametriFunzione;
    procedure RicaricaListaGruppiSel;
    procedure RicaricaClbGruppi;
    procedure SelezionatuttoClick(Sender: TObject; CheckGroup: TmeTIWAdvCheckGroup);
    procedure DeselezionatuttoClick(Sender: TObject; CheckGroup: TmeTIWAdvCheckGroup);
    procedure InvertiselezioneClick(Sender: TObject;CheckGroup: TmeTIWAdvCheckGroup);
    procedure evtRichiesta(Msg,Chiave:String);
    procedure ResultEvtRichiesta(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure evtClearKeys;
  protected
    procedure InizioElaborazione; override;
    function CurrentRecordElaborazione: Integer; override;
    function TotalRecordsElaborazione: Integer; override;
    procedure ElaboraElemento; override;
    function ElementoSuccessivo: Boolean; override;
    procedure FineCicloElaborazione;override;
    function ElaborazioneTerminata:String; override;
    procedure DistruzioneOggettiElaborazione(Errore:Boolean); override;
  public
    { Public declarations }
    Anno:Integer;
    function InizializzaAccesso:Boolean; override;
    procedure AbilitaComponenti;
  end;

implementation

{$R *.dfm}

procedure TWA063FBudgetGenerazione.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  A063MW:=TA063FBudgetGenerazioneMW.Create(Self);
  A063MW.evtRichiesta:=evtRichiesta;
  A063MW.evtClearKeys:=evtClearKeys;
end;

procedure TWA063FBudgetGenerazione.IWAppFormDestroy(Sender: TObject);
begin
  PutParametriFunzione;
  FreeAndNil(A063MW);
  inherited;
end;

function TWA063FBudgetGenerazione.InizializzaAccesso: Boolean;
var i:Integer;
begin
  Result:=False;
  wCodGruppo:=GetParam('CODGRUPPO');
  wTipo:=GetParam('TIPO');
  try
    wDecorrenza:=StrToDateTime(GetParam('DECORRENZA'));
    Anno:=R180Anno(wDecorrenza);
    MGen:=R180Mese(wDecorrenza);
  except
    wDecorrenza:=0;
  end;
  if Anno = 0 then
    Anno:=R180Anno(Parametri.DataLavoro);
  if MGen = 0 then
    MGen:=R180Mese(Parametri.DataLavoro);
  edtAnno.Text:=IntToStr(Anno);
  edtDuplicaSuAnno.Text:=IntToStr(Anno + 1);
  cmbAMeseBudget.ItemIndex:=MGen - 1;
  cmbDaMeseFruito.ItemIndex:=MGen - 1;
  cmbAMeseFruito.ItemIndex:=MGen - 1;
  cmbDaMeseResiduo.ItemIndex:=MGen - 1;
  cmbAMeseResiduo.ItemIndex:=MGen - 1;
  dcmbTipo.Items.Clear;
  with A063MW.selT275 do
  begin
    while not Eof do
    begin
      dcmbTipo.AddRow(FieldByName('CODICE').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
    First;
    dcmbTipo.Text:=FieldByName('CODICE').AsString;
  end;
  imgAnomalie.Enabled:=False;
  GetParametriFunzione;
  if wTipo <> '' then
    dcmbTipo.Text:=wTipo;
  //Recupero i gruppi abilitati all'utente corrente
  A063MW.EseguiFiltroAnagrafeUtente(Anno,1,12);
  A063MW.StruttureDisponibili(Anno,1,12,VarToStr(dcmbTipo.Text));
  //Carico in clbGruppi l'elenco dei gruppi appena recuperato, eventualmente selezionandoli
  RicaricaClbGruppi;
  //Seleziono i gruppi di clbGruppi in base al salvataggio precedente
  GetParametriFunzione2;
  //Allineo la lista dei gruppi selezionati in base al clbGruppi
  RicaricaListaGruppiSel;
  //Se sono richiamato dall'esterno...
  if wCodGruppo <> '' then
  begin
    //Cancello la lista dei gruppi selezionati
    for i:=0 to clbGruppi.Items.Count - 1 do
      clbGruppi.IsChecked[i]:=False;
    //Seleziono il gruppo richiamato
    if A063MW.selT713.SearchRecord('CODGRUPPO;TIPO;DECORRENZA',VarArrayOf([wCodGruppo,wTipo,wDecorrenza]),[srFromBeginning]) then
      clbGruppi.IsChecked[A063MW.selT713.RecNo - 1]:=True;
    //Allineo la lista dei gruppi selezionati in base al clbGruppi
    RicaricaListaGruppiSel;
  end;
  AbilitaComponenti;
  Result:=True;
end;

procedure TWA063FBudgetGenerazione.GetParametriFunzione;
{Leggo i parametri della form}
begin
  rgpOreImporti.ItemIndex:=StrToInt(C004DM.GetParametro('rgpOreImporti','2'));
  dcmbTipo.Text:=C004DM.GetParametro('dcmbTipo','#LIQ#');
  chkAssegnaBudget.Checked:=C004DM.GetParametro('chkAssegnaBudget','N') = 'S';
  chkCalcolaFruito.Checked:=C004DM.GetParametro('chkCalcolaFruito','N') = 'S';
  chkRiportaResiduo.Checked:=C004DM.GetParametro('chkRiportaResiduo','N') = 'S';
  chkControlloFiltriAnagrafe.Checked:=C004DM.GetParametro('chkControlloFiltri','N') = 'S';
  chkDuplicaGruppi.Checked:=C004DM.GetParametro('chkDuplicaGruppi','N') = 'S';
end;

procedure TWA063FBudgetGenerazione.GetParametriFunzione2;
{Leggo i parametri della form}
var x,y,i:integer;
    e: boolean;
    sValore,sNome,sElemento:string;
begin
  //lettura gruppi-tipi-mesi selezionati
  x:=0; //contatore di paramento
  sNome:='clbGruppi';
  repeat
    //ciclo sui parametri clbGruppi0,clbGruppi1,ecc.
    sValore:=C004DM.GetParametro(sNome + IntToStr(x),'');
    y:=0; //contatore di elementi nel parametro
    if sValore <> '' then
    begin
      repeat
        //ciclo sugli elementi nel parametro
        sElemento:=Copy(sValore,(y * 22) + 1,22);
        if sElemento <> '' then
        begin
          i:=0;
          e:=true;
          while (i < clbGruppi.Items.Count) and (e) do
          begin
            if Copy(clbGruppi.Items[i],1,22) = sElemento then
            begin
              clbGruppi.IsChecked[i]:=true;
              e:=false;
            end
            else if Copy(clbGruppi.Items[i],1,22) > sElemento then
              e:=false;
            inc(i);
          end;
          inc(y);
        end;
      until sElemento = '';
      inc(x);
    end;
  until sValore = '';
end;

procedure TWA063FBudgetGenerazione.PutParametriFunzione;
{Scrivo i parametri della forma}
var i,x,y:integer;
    sValore,sNome:string;
begin
  C004DM.Cancella001;
  C004DM.PutParametro('rgpOreImporti',IntToStr(rgpOreImporti.ItemIndex));
  C004DM.PutParametro('dcmbTipo',VarToStr(dcmbTipo.Text));
  C004DM.PutParametro('chkAssegnaBudget',IfThen(chkAssegnaBudget.Checked,'S','N'));
  C004DM.PutParametro('chkCalcolaFruito',IfThen(chkCalcolaFruito.Checked,'S','N'));
  C004DM.PutParametro('chkRiportaResiduo',IfThen(chkRiportaResiduo.Checked,'S','N'));
  C004DM.PutParametro('chkControlloFiltri',IfThen(chkControlloFiltriAnagrafe.Checked,'S','N'));
  C004DM.PutParametro('chkDuplicaGruppi',IfThen(chkDuplicaGruppi.Checked,'S','N'));
  //salvo l'elenco dei gruppi-tipi-mesi selezionati
  x:=0; //contatore parametri gruppi-tipi-decorrenze
  y:=0; //contatore elementi per parametro
  sValore:='';
  sNome:='clbGruppi';
  for i:=1 to clbGruppi.Items.Count do
    if clbGruppi.IsChecked[i-1] then
    begin
       sValore:=sValore + Copy(clbGruppi.Items[i-1],1,22);
       inc(y);
       if y = 90 then
       begin
          C004DM.PutParametro(sNome + IntToStr(x),sValore);
          inc(x);
          y:=0;
          sValore:='';
       end;
    end;
  C004DM.PutParametro(sNome + IntToStr(x),sValore);
  try SessioneOracle.Commit; except end;
end;

procedure TWA063FBudgetGenerazione.RicaricaListaGruppiSel;
var i:Integer;
begin
  A063MW.ListaGruppiSel.Clear;
  for i:=0 to clbGruppi.Items.Count - 1 do
    if clbGruppi.IsChecked[i] then
      A063MW.ListaGruppiSel.Add(clbGruppi.Items[i]);
end;

procedure TWA063FBudgetGenerazione.RicaricaClbGruppi;
var i:Integer;
begin
  //Carico in clbGruppi l'elenco dei gruppi appena recuperato
  clbGruppi.Items.Clear;
  for i:=0 to A063MW.ListaGruppi.Count - 1 do
    clbGruppi.Items.Add(A063MW.ListaGruppi[i]);
  //Seleziono i gruppi in clbGruppi
  for i:=0 to clbGruppi.Items.Count - 1 do
    clbGruppi.IsChecked[i]:=A063MW.ListaGruppiSel.IndexOf(clbGruppi.Items[i]) >= 0;
end;

procedure TWA063FBudgetGenerazione.AbilitaComponenti;
var RiportaResiduoAbilitato:Boolean;
begin
  lblAlMeseBudget.Visible:=chkAssegnaBudget.Checked;
  cmbAMeseBudget.Visible:=chkAssegnaBudget.Checked;
  chkCalcolaFruito.Enabled:=not (chkAssegnaBudget.Checked or (chkRiportaResiduo.Checked and chkRiportaResiduo.Enabled) or chkControlloFiltriAnagrafe.Checked or chkDuplicaGruppi.Checked);
  lblCalcolaFruito.Enabled:=chkCalcolaFruito.Enabled;
  lblDalMeseFruito.Visible:=chkCalcolaFruito.Checked;
  cmbDaMeseFruito.Visible:=chkCalcolaFruito.Checked;
  cmbDaMeseFruito.Enabled:=VarToStr(dcmbTipo.Text) <> '#ECC#';
  if cmbDaMeseFruito.Visible and not cmbDaMeseFruito.Enabled then
    cmbDaMeseFruito.ItemIndex:=0;
  lblAlMeseFruito.Visible:=chkCalcolaFruito.Checked;
  cmbAMeseFruito.Visible:=chkCalcolaFruito.Checked;
  RiportaResiduoAbilitato:=chkRiportaResiduo.Enabled;
  chkRiportaResiduo.Enabled:=not (chkAssegnaBudget.Checked or chkCalcolaFruito.Checked or chkControlloFiltriAnagrafe.Checked or chkDuplicaGruppi.Checked);
  lblRiportaResiduo.Enabled:=chkRiportaResiduo.Enabled;
  if chkCalcolaFruito.Checked and (VarToStr(dcmbTipo.Text) = '#ECC#') then
    chkRiportaResiduo.Checked:=True
  else if not RiportaResiduoAbilitato then
    chkRiportaResiduo.Checked:=False;
  chkAssegnaBudget.Enabled:=not (chkCalcolaFruito.Checked or chkRiportaResiduo.Checked or chkControlloFiltriAnagrafe.Checked or chkDuplicaGruppi.Checked);//Da tenere dopo la forzatura del chkRiportaResiduo.Checked
  lblAssegnaBudget.Enabled:=chkAssegnaBudget.Enabled;
  lblDalMeseResiduo.Enabled:=not (chkCalcolaFruito.Checked and (VarToStr(dcmbTipo.Text) = '#ECC#'));
  lblDalMeseResiduo.Visible:=chkRiportaResiduo.Checked;
  cmbDaMeseResiduo.Visible:=chkRiportaResiduo.Checked;
  cmbDaMeseResiduo.Enabled:=VarToStr(dcmbTipo.Text) <> '#ECC#';
  if cmbDaMeseResiduo.Visible and not cmbDaMeseResiduo.Enabled then
    cmbDaMeseResiduo.ItemIndex:=0;
  lblAlMeseResiduo.Enabled:=not (chkCalcolaFruito.Checked and (VarToStr(dcmbTipo.Text) = '#ECC#'));
  lblAlMeseResiduo.Visible:=chkRiportaResiduo.Checked;
  cmbAMeseResiduo.Visible:=chkRiportaResiduo.Checked;
  cmbAMeseResiduo.Enabled:=VarToStr(dcmbTipo.Text) <> '#ECC#';
  if cmbAMeseResiduo.Visible and not cmbAMeseResiduo.Enabled then
    cmbAMeseResiduo.ItemIndex:=11;
  lblMesiSuccResiduo.Caption:=IfThen(VarToStr(dcmbTipo.Text) <> '#ECC#',' sul mese successivo',' sui mesi successivi');
  lblMesiSuccResiduo.Visible:=chkRiportaResiduo.Checked;
  lblMesiSuccResiduo.Enabled:=not (chkCalcolaFruito.Checked and (VarToStr(dcmbTipo.Text) = '#ECC#'));
  chkControlloFiltriAnagrafe.Enabled:=not (chkAssegnaBudget.Checked or chkCalcolaFruito.Checked or chkRiportaResiduo.Checked or chkDuplicaGruppi.Checked);
  lblControlloFiltriAnagrafe.Enabled:=chkControlloFiltriAnagrafe.Enabled;
  chkDuplicaGruppi.Enabled:=not (chkAssegnaBudget.Checked or chkCalcolaFruito.Checked or chkRiportaResiduo.Checked or chkControlloFiltriAnagrafe.Checked);
  lblDuplicaGruppi.Enabled:=chkDuplicaGruppi.Enabled;
  lblDuplicaSuAnno.Visible:=chkDuplicaGruppi.Checked;
  edtDuplicaSuAnno.Visible:=chkDuplicaGruppi.Checked;
  rgpOreImporti.Enabled:=not chkControlloFiltriAnagrafe.Checked and not chkDuplicaGruppi.Checked;
  clbGruppi.Enabled:=not chkControlloFiltriAnagrafe.Checked;
  imgEsegui.Enabled:=chkAssegnaBudget.Checked or chkCalcolaFruito.Checked or chkRiportaResiduo.Checked or chkControlloFiltriAnagrafe.Checked or chkDuplicaGruppi.Checked;
  lblDescTipo.Caption:=VarToStr(A063MW.selT275.Lookup('CODICE',dcmbTipo.Text,'DESCRIZIONE'));
end;

procedure TWA063FBudgetGenerazione.edtAnnoAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[btnCambioData.HTMLName]));
end;

procedure TWA063FBudgetGenerazione.btnCambioDataClick(Sender: TObject);
var
  dData:TDateTime;
begin
  try
    StrToInt(edtAnno.Text);
  except
    edtAnno.Text:=IntToStr(R180Anno(Parametri.DataLavoro));
  end;
  if Length(edtAnno.Text) = 4 then
  begin
    try
      dData:=StrToDate('01/01/' + edtAnno.Text);
      if Anno <> StrToInt(edtAnno.Text) then
      begin
        Anno:=StrToInt(edtAnno.Text);
        RicaricaListaGruppiSel;
        A063MW.EseguiFiltroAnagrafeUtente(Anno,1,12);
        A063MW.StruttureDisponibili(Anno,1,12,VarToStr(dcmbTipo.Text));
        RicaricaClbGruppi;
      end;
    except
      edtAnno.SetFocus;
    end;
  end;
end;

procedure TWA063FBudgetGenerazione.MenuItem1Click(Sender: TObject);
begin
  inherited;
  SelezionatuttoClick(Sender,clbGruppi);
end;

procedure TWA063FBudgetGenerazione.MenuItem2Click(Sender: TObject);
begin
  inherited;
  DeselezionatuttoClick(Sender,clbGruppi);
end;

procedure TWA063FBudgetGenerazione.MenuItem3Click(Sender: TObject);
begin
  inherited;
  InvertiSelezioneClick(Sender,clbGruppi);
end;

procedure TWA063FBudgetGenerazione.SelezionatuttoClick(Sender: TObject;CheckGroup: TmeTIWAdvCheckGroup);
var i:Integer;
begin
  inherited;
  for i:=0 to CheckGroup.Items.Count - 1 do
    CheckGroup.IsChecked[i]:=True;
  CheckGroup.AsyncUpdate;
end;

procedure TWA063FBudgetGenerazione.DeselezionatuttoClick(Sender: TObject;CheckGroup: TmeTIWAdvCheckGroup);
var i:Integer;
begin
  inherited;
  for i:=0 to CheckGroup.Items.Count - 1 do
    CheckGroup.IsChecked[i]:=False;
  CheckGroup.AsyncUpdate;
end;

procedure TWA063FBudgetGenerazione.InvertiselezioneClick(Sender: TObject;CheckGroup: TmeTIWAdvCheckGroup);
var i:Integer;
begin
  inherited;
  for i:=0 to CheckGroup.Items.Count - 1 do
    CheckGroup.IsChecked[i]:=not CheckGroup.IsChecked[i];
  CheckGroup.AsyncUpdate;
end;

procedure TWA063FBudgetGenerazione.chkAssegnaBudgetClick(Sender: TObject);
begin
  AbilitaComponenti;
end;

procedure TWA063FBudgetGenerazione.dcmbTipoChange(Sender: TObject; Index: Integer);
begin
  with A063MW do
  begin
    RicaricaListaGruppiSel;
    StruttureDisponibili(Anno,1,12,VarToStr(dcmbTipo.Text));
    RicaricaClbGruppi;
    AbilitaComponenti;
  end;
end;

procedure TWA063FBudgetGenerazione.imgEseguiClick(Sender: TObject);
begin
  inherited;
  with A063MW do
  begin
    RicaricaListaGruppiSel;
    nAnno:=Anno;
    xOreImporti:=rgpOreImporti.ItemIndex;
    bAssegnaBudget:=chkAssegnaBudget.Checked;
    bCalcolaFruito:=chkCalcolaFruito.Checked;
    bRiportaResiduo:=chkRiportaResiduo.Checked;
    bControlloFiltriAnagrafe:=chkControlloFiltriAnagrafe.Checked;
    bDuplicaGruppi:=chkDuplicaGruppi.Checked;
    AMeseBudget:=cmbAMeseBudget.ItemIndex + 1;
    DaMeseFruito:=cmbDaMeseFruito.ItemIndex + 1;
    AMeseFruito:=cmbAMeseFruito.ItemIndex + 1;
    DaMeseResiduo:=cmbDaMeseResiduo.ItemIndex + 1;
    AMeseResiduo:=cmbAMeseResiduo.ItemIndex + 1;
    nAnnoDup:=StrToInt(edtDuplicaSuAnno.Text);
    Controlli;
    Domande;
    if bControlloFiltriAnagrafe then
    begin
      cdsDip.EmptyDataSet;
      cdsAnom.EmptyDataSet;
      selaT713.Close;
      selaT713.SetVariable('ANNO',nAnno);
      selaT713.Open;
      if selaT713.RecordCount < 2 then
        exit;
    end;
  end;
  StartElaborazioneCiclo(imgEsegui.HTMLName);
end;

procedure TWA063FBudgetGenerazione.imgAnomalieClick(Sender: TObject);
var Params: String;
begin
  inherited;
  Params:='AZIENDA=' + Parametri.Azienda + ParamDelimiter +
          'OPERATORE=' + Parametri.Operatore + ParamDelimiter +
          'MASCHERA=' + medpCodiceForm + ParamDelimiter +
          'ID=' + IntToStr(RegistraMsg.ID) + ParamDelimiter +
          'TIPO=A,B';
  accediForm(201,Params,False);
end;

procedure TWA063FBudgetGenerazione.InizioElaborazione;
begin
  inherited;
  imgAnomalie.Enabled:=False;
  nRec:=0;
  with A063MW do
    if bCalcolaFruito then
    begin
      DataMin:=EncodeDate(nAnno,DaMeseFruito,1);
      DataMax:=EncodeDate(nAnno,AMeseFruito,1);
      Data:=DataMin;
    end
    else if bRiportaResiduo then
    begin
      DataMin:=EncodeDate(nAnno,DaMeseResiduo,1);
      DataMax:=EncodeDate(nAnno,AMeseResiduo,1);
      Data:=DataMin;
    end;
end;

function TWA063FBudgetGenerazione.CurrentRecordElaborazione: Integer;
begin
  with A063MW do
  begin
    if bControlloFiltriAnagrafe then
      Result:=selaT713.RecNO
    else
      Result:=nRec;
    if bCalcolaFruito or bRiportaResiduo then
      Result:=(ListaGruppiSel.Count * (R180Mese(Data) - R180Mese(DataMin))) + Result;
    WC019FProgressBarFM.MessaggioStep2:=IfThen(bAssegnaBudget,lblAssegnaBudget.Caption,
                                        IfThen(bCalcolaFruito,lblCalcolaFruito.Caption,
                                        IfThen(bRiportaResiduo,lblRiportaResiduo.Caption,
                                        IfThen(bControlloFiltriAnagrafe,lblControlloFiltriAnagrafe.Caption,
                                               lblDuplicaGruppi.Caption))));
  end;
end;

function TWA063FBudgetGenerazione.TotalRecordsElaborazione: Integer;
begin
  with A063MW do
  begin
    if bControlloFiltriAnagrafe then
      Result:=selaT713.RecordCount
    else
      Result:=ListaGruppiSel.Count;
    if bCalcolaFruito or bRiportaResiduo then
      Result:=Result * (R180Mese(DataMax) - R180Mese(DataMin) + 1);
  end;
end;

procedure TWA063FBudgetGenerazione.ElaboraElemento;
begin
  inherited;
  with A063MW do
    if bAssegnaBudget then
      AssegnazioneBudgetMensile(ListaGruppiSel[nRec])
    else if bCalcolaFruito then
      CalcoloFruitoMensile(ListaGruppiSel[nRec],Data)
    else if bRiportaResiduo then
      RiportoResiduoMensile(ListaGruppiSel[nRec],Data)
    else if bControlloFiltriAnagrafe then
      ControlloFiltriAnagrafe_1
    else if bDuplicaGruppi then
      DuplicazioneGruppi(ListaGruppiSel[nRec]);
  nRec:=nRec + 1;
  SessioneOracle.Commit;
end;

function TWA063FBudgetGenerazione.ElementoSuccessivo: Boolean;
begin
  Result:=False;
  with A063MW do
  begin
    if bControlloFiltriAnagrafe then
    begin
      selaT713.Next;
      if not selaT713.Eof then
        Result:=True;
    end
    else
    begin
      Result:=nRec < ListaGruppiSel.Count;
      if not Result
      and (bCalcolaFruito or bRiportaResiduo) then
      begin
        Data:=R180FineMese(Data) + 1;
        if Data <= DataMax then
        begin
          nRec:=0;
          Result:=True;
        end;
      end;
    end;
  end;
end;

procedure TWA063FBudgetGenerazione.FineCicloElaborazione;
begin
  inherited;
  with A063MW do
    if bControlloFiltriAnagrafe then
      ControlloFiltriAnagrafe_2;
  SessioneOracle.Commit;
  imgAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);
end;

function TWA063FBudgetGenerazione.ElaborazioneTerminata: String;
begin
  with A063MW do
    if bCalcolaFruito and bRiportaResiduo then
    begin
      Result:='';
      bCalcolaFruito:=False;
      RipartiElaborazione:=True;
    end
    else
    begin
      if imgAnomalie.Enabled then
        Result:=A000MSG_MSG_ELABORAZIONE_ANOMALIE
      else
        Result:=inherited;
    end;
end;

procedure TWA063FBudgetGenerazione.DistruzioneOggettiElaborazione(Errore: Boolean);
begin
  inherited;
  if not RipartiElaborazione then
    A063MW.PulisciVariabili;
end;

procedure TWA063FBudgetGenerazione.evtRichiesta(Msg,Chiave:String);
begin
  if not MsgBox.KeyExists(Chiave) then
  begin
    MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultEvtRichiesta,Chiave);
    Abort;
  end;
end;

procedure TWA063FBudgetGenerazione.ResultEvtRichiesta(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
    imgEseguiClick(nil)
  else
    A063MW.PulisciVariabili;
end;

procedure TWA063FBudgetGenerazione.evtClearKeys;
begin
  MsgBox.ClearKeys;
end;

end.
