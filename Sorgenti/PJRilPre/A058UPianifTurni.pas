unit A058UPianifTurni;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Buttons, Mask, ExtCtrls, A000UCostanti, A000USessione,A000UInterfaccia,
  C700USelezioneAnagrafe, DBCtrls, C180FunzioniGenerali, Spin,
  C004UParamForm, OracleData, SelAnagrafe, Menus, UITypes,
  C005UDatiAnagrafici, A003UDataLavoroBis, Variants, DB, StrUtils, A174UParPianifTurni,
  Math, R500Lin, Printers, C001StampaLib, QuickRpt, QRPDFFilt, A058UStampaRiepNote,
  InputPeriodo;

type
  TSquadre = record
    Squadra,DSquadra,Oper,
    S1,S2:String;
  end;

  TA058FPianifTurni = class(TForm)
    btnEsegui: TBitBtn;
    StatusBar: TStatusBar;
    ProgressBar1: TProgressBar;
    btnVisualizza: TBitBtn;
    btnAnteprima: TBitBtn;
    frmSelAnagrafe: TfrmSelAnagrafe;
    RgpTipo: TRadioGroup;
    lblCopiaAss: TLabel;
    lblProfilo: TLabel;
    dCmbProfili: TDBLookupComboBox;
    dLblDescProfilo: TDBText;
    ppMnuAccedi: TPopupMenu;
    Accedi1: TMenuItem;
    dCmbSquadra: TDBLookupComboBox;
    dLblSquadra: TDBText;
    lblSquadra: TLabel;
    btnStampa: TSpeedButton;
    btnStampante: TBitBtn;
    PrinterSetupDialog1: TPrinterSetupDialog;
    MyCompRep: TQRCompositeReport;
    chkIniCorr: TCheckBox;
    frmInputPeriodo: TfrmInputPeriodo;
    chkIncludiDipCS: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure frmInputPeriodoedtInizioExit(Sender: TObject);
    procedure frmInputPeriodobtnDataInizioClick(Sender: TObject);
    procedure frmInputPeriodoedtFineExit(Sender: TObject);
    procedure frmInputPeriodobtnDataFineClick(Sender: TObject);
    procedure frmInputPeriodobtnIndietroClick(Sender: TObject);
    procedure frmInputPeriodobtnAvantiClick(Sender: TObject);
    procedure dCmbSquadraKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dCmbProfiliCloseUp(Sender: TObject);
    procedure dCmbProfiliKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Accedi1Click(Sender: TObject);
    procedure RgpTipoClick(Sender: TObject);
    procedure btnStampanteClick(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure MyOnAddReports(Sender: TObject);
  private
    { Private declarations }
    QRepSetting:TQuickRep;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure SetPeriodoDate(Sender: TObject);
    function _GetDataI: TDateTime;
    procedure _PutDataI(const Value: TDateTime);
    function _GetDataF: TDateTime;
    procedure _PutDataF(const Value: TDateTime);
    procedure Abilitazioni;
    procedure VisualizzaGriglia;
    procedure RiempiGriglia;
   public
    { Public declarations }
    TipoModulo, DocumentoPDF: String;
    bVisualizzaCopertura, bVisualizzaCompetenze, bVisualizzaTurni, bVisualizzaAssenze,
    bVisualizzaRiposiFestivi, bVisualizzaMatricola, bVisualizzaSintetica, bVisualizzaAssenzeMezzaGiornata,
    bVisualizzaAssenzeAdOre:Boolean;
    procedure Anteprima_Stampa(SoloAnteprima:Boolean);
    property DataI:TDateTime read _GetDataI write _PutDataI;
    property DataF:TDateTime read _GetDataF write _PutDataF;
  end;

var A058FPianifTurni: TA058FPianifTurni;

procedure OpenA058PianifTurni(Prog:LongInt);
procedure OpenA058VisualizzaTabellone(Prog:String; Dal,Al:TDateTime);

implementation

uses A058UPianifTurniDtM1, A058UGrigliaPianif, A058UTabellone, A058UStampaRiepTimb;

{$R *.DFM}

procedure OpenA058PianifTurni(Prog:LongInt);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA058PianifTurni') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A058FPianifTurni:=TA058FPianifTurni.Create(nil);
  with A058FPianifTurni do
    try
      C700Progressivo:=Prog;
      A058FPianifTurniDtM1:=TA058FPianifTurniDtM1.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A058FPianifTurniDtM1.Free;
      Free;
    end;
end;

procedure OpenA058VisualizzaTabellone(Prog:String; Dal,Al:TDateTime); //Utilizzata solo da A139 che è obsoleta, quindi non considerare
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA058PianifTurni') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A058FPianifTurni:=TA058FPianifTurni.Create(nil);
  with A058FPianifTurni do
    try
      //C700Progressivo:=Prog;
      A058FPianifTurniDtM1:=TA058FPianifTurniDtM1.Create(nil);
      FormShow(A058FPianifTurni);
      A058FPianifTurniDtm1.DataInizio:=Dal;
      A058FPianifTurniDtm1.DataFine:=Al;
      dcmbSquadra.KeyValue:=null;
      try
        Screen.Cursor:=crHourGlass;
        if Prog = '' then
          frmSelAnagrafe.btnEreditaSelezioneClick(nil)
        else
        begin
          frmSelAnagrafe.OldSQLCreato.Text:='(T030.PROGRESSIVO IN (' + Prog + ')) ORDER BY T030.COGNOME,T030.NOME,T030.MATRICOLA';
          C700Progressivo:=-1;
          C700FSelezioneAnagrafe.SQLCreato.Assign(frmSelAnagrafe.OldSQLCreato);
          C700FSelezioneAnagrafe.WhereSql:=C700FSelezioneAnagrafe.SQLCreato.Text;
          frmSelAnagrafe.SelezionePeriodica:=False;
          frmSelAnagrafe.SoloPersonaleInterno:=True;
          C700FSelezioneAnagrafe.PulisciVecchiaSelezione:=False;
          C700FSelezioneAnagrafe.actConfermaExecute(C700FSelezioneAnagrafe.actConferma);
        end;
        btnEseguiClick(btnVisualizza);
      finally
        Screen.Cursor:=crDefault;
      end;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A058FPianifTurniDtM1.Free;
      Free;
    end;
end;

procedure TA058FPianifTurni.FormCreate(Sender: TObject);
begin
  TipoModulo:='CS';
  btnEsegui.Enabled:=Not SolaLettura and ((Parametri.A058_PianifOperativa = 'S') or (Parametri.A058_PianifNonOperativa = 'S'));
end;

procedure TA058FPianifTurni.FormShow(Sender: TObject);
begin
  A058FPianifTurniDtm1.DataInizio:=R180InizioMese(Parametri.DataLavoro);
  A058FPianifTurniDtm1.DataFine:=R180FineMese(Parametri.DataLavoro);
  QRepSetting:=TQuickRep.Create(Self);
  QRepSetting.useQR5Justification:=True;
  CreaC004(SessioneOracle,'A058',Parametri.ProgOper);
  GetParametriFunzione;
  C004FParamForm.Free;
  (*Test.INI
  C700Progressivo:=22894;
  Parametri.DataLavoro:=EncodeDate(2018,1,1);
  A058FPianifTurniDtm1.DataInizio:=EncodeDate(2018,1,1);
  A058FPianifTurniDtm1.DataFine:=EncodeDate(2018,1,1);
  edtDataDa.Text:=DateToStr(A058FPianifTurniDtm1.DataInizio);
  edtDataA.Text:=DateToStr(A058FPianifTurniDtm1.DataFine);
  A058FPianifTurniDtm1.RefreshSquadre;
  //Test.FINE*)
  C700DatiVisualizzati:='MATRICOLA,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataDal:=A058FPianifTurniDtm1.DataInizio;
  C700DataLavoro:=A058FPianifTurniDtm1.DataFine;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,StatusBar,0,False);
  frmSelAnagrafe.SelezionePeriodica:=True;
  C700SelAnagrafe.OnFilterRecord:=A058FPianifTurniDtM1.SelAnagrafeFilterRecord;
  C700SelAnagrafe.Filtered:=True;
  A058FPianifTurniDtM1.selAnagrafeA058:=C700SelAnagrafe;
  dCmbSquadra.KeyValue:=A058FPianifTurniDtM1.GetSquadraPiuAssegnata(dCmbSquadra.KeyValue);
  (*Impostazione di dCmbSquadra.KeyValue:
  1) inizia Null
  2) GetParametriFunzione imposta il valore precedentemente registrato (FormShow è richiamato sia da A002 che da B028)
  3) GetSquadraPiuAssegnata sovrascrive con il valore non nullo più assegnato in anagrafica ai dipendenti selezionati (se nessuno selezionato, considera tutti i dipendenti), se presente nell'elenco in base alle date di validità
  4) B028 sovrascrive con il valore scelto in Web/Cloud
  5) PutParametriFunzione registra il valore per futuri utilizzi (FormClose non è richiamato da B028) (utile solo se si riaccede da A002 e se GetSquadraPiuAssegnata non restituisce nulla)*)
end;

procedure TA058FPianifTurni.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CreaC004(SessioneOracle,'A058',Parametri.ProgOper);
  PutParametriFunzione;
  C004FParamForm.Free;
  A058FPianifTurniDtm1.SalvaSQLOriginale:='';
end;

procedure TA058FPianifTurni.FormDestroy(Sender: TObject);
begin
  frmSelAnagrafe.DistruggiSelAnagrafe;
  FreeAndNil(QRepSetting);
end;

procedure TA058FPianifTurni.GetParametriFunzione;
{Leggo i parametri della form}
var
  nKey:Word;
begin
  with A058FPianifTurniDtm1 do
  begin
    DataInizio:=R180InizioMese(Parametri.DataLavoro);
    DataI:=DataInizio;
    DataFine:=R180FineMese(Parametri.DataLavoro);
    DataF:=DataFine;
    RefreshSquadre;
  end;
  dCmbSquadra.KeyValue:=C004FParamForm.GetParametro('SQUADRA','');
  nKey:=0;
  dCmbSquadraKeyDown(nil,nKey,[]);
  chkIncludiDipCS.Checked:=C004FParamForm.GetParametro(UpperCase('DIP_CAMBIO_SQUADRA'),'N') = 'S';
  RgpTipo.ItemIndex:=StrToInt(C004FParamForm.GetParametro('TIPOPIANIFICAZIONE','0'));
  bVisualizzaSintetica:=C004FParamForm.GetParametro(UpperCase('VIS_SINTETICA'),'N') = 'S';
  bVisualizzaCopertura:=C004FParamForm.GetParametro('COPERTURA','N') = 'S';
  bVisualizzaCompetenze:=C004FParamForm.GetParametro('COMPETENZE','N') = 'S';
  bVisualizzaTurni:=C004FParamForm.GetParametro('TURNI','N') = 'S';
  bVisualizzaAssenze:=C004FParamForm.GetParametro('ASSENZE','N') = 'S';
  bVisualizzaRiposiFestivi:=C004FParamForm.GetParametro('RIPOSI_FESTIVI','N') = 'S';
  bVisualizzaMatricola:=C004FParamForm.GetParametro('VIS_MATRICOLA','S') = 'S';
  bVisualizzaAssenzeMezzaGiornata:=C004FParamForm.GetParametro('VIS_ASSENZE_MEZZA_GIOR','S') = 'S';
  bVisualizzaAssenzeAdOre:=C004FParamForm.GetParametro('VIS_ASSENZE_AD_ORE','S') = 'S';
  with A058FPianifTurniDtm1 do
  begin
    AusT058.Edit;
    AusT058.FieldByName('CODICE').AsString:=C004FParamForm.GetParametro('CODPROFILO','');
    AusT058.Post;
    selT082.SearchRecord('CODICE',AusT058.FieldByName('CODICE').AsString,[srFromBeginning]);
  end;
  Abilitazioni;
end;

procedure TA058FPianifTurni.PutParametriFunzione;
{Scrivo i parametri della forma}
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('SQUADRA',VarToStr(dCmbSquadra.KeyValue));
  C004FParamForm.PutParametro('DIP_CAMBIO_SQUADRA',IfThen(chkIncludiDipCS.Checked,'S','N'));
  C004FParamForm.PutParametro('TIPOPIANIFICAZIONE',IntToStr(RgpTipo.ItemIndex));
  if bVisualizzaCopertura then
    C004FParamForm.PutParametro('COPERTURA','S')
  else
    C004FParamForm.PutParametro('COPERTURA','N');
  if bVisualizzaCompetenze then
    C004FParamForm.PutParametro('COMPETENZE','S')
  else
    C004FParamForm.PutParametro('COMPETENZE','N');
  if bVisualizzaTurni then
    C004FParamForm.PutParametro('TURNI','S')
  else
    C004FParamForm.PutParametro('TURNI','N');
  if bVisualizzaAssenze then
    C004FParamForm.PutParametro('ASSENZE','S')
  else
    C004FParamForm.PutParametro('ASSENZE','N');
  if bVisualizzaRiposiFestivi then
    C004FParamForm.PutParametro('RIPOSI_FESTIVI','S')
  else
    C004FParamForm.PutParametro('RIPOSI_FESTIVI','N');
  if bVisualizzaMatricola then
    C004FParamForm.PutParametro('VIS_MATRICOLA','S')
  else
    C004FParamForm.PutParametro('VIS_MATRICOLA','N');
  if bVisualizzaAssenzeMezzaGiornata then
    C004FParamForm.PutParametro('VIS_ASSENZE_MEZZA_GIOR','S')
  else
    C004FParamForm.PutParametro('VIS_ASSENZE_MEZZA_GIOR','N');
  if bVisualizzaAssenzeAdOre then
    C004FParamForm.PutParametro('VIS_ASSENZE_AD_ORE','S')
  else
    C004FParamForm.PutParametro('VIS_ASSENZE_AD_ORE','N');
  C004FParamForm.PutParametro('CODPROFILO',A058FPianifTurniDtm1.AusT058.FieldByName('CODICE').AsString);
  C004FParamForm.PutParametro('VIS_SINTETICA',ifThen(bVisualizzaSintetica,'S','N'));
  try SessioneOracle.Commit; except end;
end;

procedure TA058FPianifTurni.frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
begin
  C005DataVisualizzazione:=A058FPianifTurniDtm1.DataFine;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA058FPianifTurni.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  C700DataDal:=A058FPianifTurniDtm1.DataInizio;
  C700DataLavoro:=A058FPianifTurniDtm1.DataFine;
  frmSelAnagrafe.btnSelezioneClick(Sender);
  with A058FPianifTurniDtM1 do
  begin
    //Se l'SQL della C700 è diverso, allora azzero la variabile di SalvaSQLOriginal
    if C700SelAnagrafe.SQL.Text <> SalvaSQLOriginale then
      SalvaSQLOriginale:='';
    dCmbSquadra.KeyValue:=GetSquadraPiuAssegnata(dCmbSquadra.KeyValue);
  end;
end;

procedure TA058FPianifTurni.frmInputPeriodoedtInizioExit(Sender: TObject);
begin
  frmInputPeriodo.edtInizioExit(Sender);
  SetPeriodoDate(Sender);
end;

procedure TA058FPianifTurni.frmInputPeriodobtnDataInizioClick(Sender: TObject);
begin
  frmInputPeriodo.btnDataInizioClick(Sender);
  SetPeriodoDate(Sender);
end;

procedure TA058FPianifTurni.frmInputPeriodoedtFineExit(Sender: TObject);
begin
  SetPeriodoDate(Sender);
end;

procedure TA058FPianifTurni.frmInputPeriodobtnDataFineClick(Sender: TObject);
begin
  frmInputPeriodo.btnDataFineClick(Sender);
  SetPeriodoDate(Sender);
end;

procedure TA058FPianifTurni.frmInputPeriodobtnIndietroClick(Sender: TObject);
begin
  frmInputPeriodo.btnIndietroClick(Sender);
  SetPeriodoDate(Sender);
end;

procedure TA058FPianifTurni.frmInputPeriodobtnAvantiClick(Sender: TObject);
begin
  frmInputPeriodo.btnAvantiClick(Sender);
  SetPeriodoDate(Sender);
end;

procedure TA058FPianifTurni.SetPeriodoDate(Sender: TObject);
{Impostazione date di riferimento}
begin
  with A058FPianifTurniDtM1 do
    if (Sender = frmInputPeriodo.edtInizio) or (Sender = frmInputPeriodo.btnDataInizio) then
    begin
      if DataI > 0 then
        DataInizio:=DataI
      else
        frmInputPeriodo.edtInizio.Clear;
    end
    else if (Sender = frmInputPeriodo.edtFine) or (Sender = frmInputPeriodo.btnDataFine) then
    begin
      if DataF > 0 then
        DataFine:=DataF
      else
        frmInputPeriodo.edtFine.Clear;
    end
    else if (Sender = frmInputPeriodo.btnAvanti) or (Sender = frmInputPeriodo.btnIndietro) then
    begin
      DataInizio:=DataI;
      DataFine:=DataF;
    end;
  A058FPianifTurniDtm1.RefreshSquadre;
end;

function TA058FPianifTurni._GetDataI: TDateTime;
begin
  Result:=frmInputPeriodo.DataInizio;
end;

procedure TA058FPianifTurni._PutDataI(const Value: TDateTime);
begin
  frmInputPeriodo.DataInizio:=Value;
end;

function TA058FPianifTurni._GetDataF: TDateTime;
begin
  Result:=frmInputPeriodo.DataFine;
end;

procedure TA058FPianifTurni._PutDataF(const Value: TDateTime);
begin
  frmInputPeriodo.DataFine:=Value;
end;

procedure TA058FPianifTurni.dCmbSquadraKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = 8) or (key = 46) then
    dCmbSquadra.KeyValue:='';
  if dCmbSquadra.KeyValue = '' then
    dLblSquadra.Field.Clear;
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA058FPianifTurni.dCmbProfiliCloseUp(Sender: TObject);
begin
  Abilitazioni;
end;

procedure TA058FPianifTurni.dCmbProfiliKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  Abilitazioni;
end;

procedure TA058FPianifTurni.Accedi1Click(Sender: TObject);
var
  Cod:String;
begin
  with A058FPianifTurniDtM1 do
  begin
    OpenA174ParPianifTurni(selT082.FieldByName('CODICE').AsString);
    Cod:=selT082.FieldByName('CODICE').AsString;
    selT082.Refresh;
    selT082.SearchRecord('CODICE',Cod,[srFromBeginning]);
    Abilitazioni;
  end;
end;

procedure TA058FPianifTurni.RgpTipoClick(Sender: TObject);
begin
  Abilitazioni;
end;

procedure TA058FPianifTurni.Abilitazioni;
begin
  with A058FPianifTurniDtm1 do
  begin
    //Applico le abilitazioni previste nel tab Permessi della form <A008> Profilo utenti
    AssenzeOperative:=selT082.FieldByName('ASSENZE_OPERATIVE').AsString = 'S';
    if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
    begin
      RgpTipo.Visible:=(selT082.FieldByName('MODALITA_LAVORO').AsString = 'N') and
                       ((selT082.FieldByName('INIZIALE').AsString = 'S') or (selT082.FieldByName('CORRENTE').AsString = 'S'));
      RgpTipo.Enabled:=(selT082.FieldByName('INIZIALE').AsString = 'S') and (selT082.FieldByName('CORRENTE').AsString = 'S');
      chkIniCorr.Visible:=(selT082.FieldByName('MODALITA_LAVORO').AsString = 'O') or (RgpTipo.ItemIndex = 0);
      if not RgpTipo.Enabled then
        if selT082.FieldByName('CORRENTE').AsString = 'S' then
          RgpTipo.ItemIndex:=1
        else if selT082.FieldByName('INIZIALE').AsString = 'S' then
          RgpTipo.ItemIndex:=0;
      if (selT082.FieldByName('MODALITA_LAVORO').AsString = 'N') and (RgpTipo.ItemIndex = 0) then
        AssenzeOperative:=False
      else if (selT082.FieldByName('MODALITA_LAVORO').AsString = 'O') then
        AssenzeOperative:=True;
    end;

    if not SolaLettura then
    begin
      if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
      begin
        //PIANIFICAZIONE PROGRESSIVA
        btnEsegui.Enabled:=(selT082.FieldByName('GENERAZIONE').AsString = 'S') and (Parametri.A058_PianifOperativa <> 'N') and
                         ((RgpTipo.ItemIndex = 0) or (selT082.FieldByName('MODALITA_LAVORO').AsString = 'O'));
        chkIniCorr.Enabled:=btnEsegui.Enabled;
      end
      else
      begin
        //PIANIFICAZIONE STANDARD - NON PROGRESSIVA
        RgpTipo.Visible:=False;
        chkIniCorr.Visible:=False;
        if selT082.fieldByName('MODALITA_LAVORO').AsString = 'O' then
          btnEsegui.Enabled:=Parametri.A058_PianifOperativa <> 'N'
        else
          btnEsegui.Enabled:=Parametri.A058_PianifNonOperativa <> 'N';
      end;
    end;
    if not chkIniCorr.Visible then
      chkIniCorr.Checked:=False;

    //Gestione Visualizzazione assenze
    lblCopiaAss.Visible:=((Parametri.CampiRiferimento.C11_PianifOrari_No_CopiaGiustif <> 'NO') or AssenzeOperative) and
                         (selT082.fieldByName('MODALITA_LAVORO').AsString = 'N');
    if A058FpianifTurniDtm1.AssenzeOperative then
      lblCopiaAss.Caption:='Gestione assenze: OPERATIVA'
    else
    begin
      lblCopiaAss.Caption:='Gestione assenze: NON OPERATIVA';
      //Specifico la copia assenze solo se la gestione è "NON OPERATIVA"
      if (Parametri.CampiRiferimento.C11_PianifOrari_No_CopiaGiustif <> 'NO') and (lblCopiaAss.Caption <> '') then
        lblCopiaAss.Caption:=lblCopiaAss.Caption + #13#10;
      if Parametri.CampiRiferimento.C11_PianifOrari_No_CopiaGiustif = 'AGGIUNGI' then
        lblCopiaAss.Caption:=lblCopiaAss.Caption + 'Aggiungi assenze da modalità operativa'
      else if Parametri.CampiRiferimento.C11_PianifOrari_No_CopiaGiustif = 'SOVRASCRIVI' then
        lblCopiaAss.Caption:=lblCopiaAss.Caption + 'Sovrascrivi assenze da modalità operativa';
    end;
    if selT082.fieldByName('MODALITA_LAVORO').AsString = 'N' then
      lblProfilo.Caption:='Profilo pianificazione - NON operativo:'
    else
      lblProfilo.Caption:='Profilo pianificazione - operativo:';
  end;
end;

procedure TA058FPianifTurni.btnStampanteClick(Sender: TObject);
{Impostazione stampante}
begin
  PrinterSetupDialog1.Execute;
end;

procedure TA058FPianifTurni.btnEseguiClick(Sender: TObject);
var
  S:String;
  x:Integer;
begin
  //RegistraMsg.IniziaMessaggio('A058');
  A058FPianifTurniDtm1.NuovaPianif:=Sender = btnEsegui;
  A058FPianifTurniDtM1.TipoPianif:=RgpTipo.ItemIndex;
  A058FPianifTurniDtM1.SquadraRiferimento:=dCmbSquadra.Text;
  A058FPianifTurniDtM1.IncludiDipCambioSquadra:=chkIncludiDipCS.Checked;
  A058FPianifTurniDtM1.SelAnagrafeA058:=C700SelAnagrafe;

  if A058FPianifTurniDtm1.DataInizio > A058FPianifTurniDtm1.DataFine then
    raise Exception.Create('Il periodo specificato non è valido!');

  if R180FineMese(A058FPianifTurniDtm1.DataFine) > R180AddMesi(R180FineMese(A058FPianifTurniDtm1.DataInizio),11,True) then
    raise Exception.Create('Non è possibile specificare un periodo afferente a più di 12 mesi!');

  if Trim(A058FPianifTurniDtm1.SquadraRiferimento) = '' then
    raise Exception.Create('E'' necessario indicare la squadra di riferimento!');

  frmSelAnagrafe.SettaPeriodoSelAnagrafe(A058FPianifTurniDtm1.DataInizio,A058FPianifTurniDtm1.DataFine);
  C700SelAnagrafe.Close;
  //Modifico SQL C700 per l'ordinamento e l'eventuale spostamento di squadra
  with A058FPianifTurniDtM1 do
    if TipoModulo <> 'COM' then
      EditSQLC700
    else if IncludiDipCambioSquadra then
      CreateVarSpostamentoSquadra(SelAnagrafeA058); //Il richiamo da web/cloud prevede già di ereditare l'sql corretto; quindi vengono solo impostate le variabili aggiuntive.
  //C700SelAnagrafe.Debug:=DebugHook <> 0;
  C700SelAnagrafe.Open;
  if C700SelAnagrafe.RecordCount = 0 then
    raise Exception.Create('Nessun dipendente selezionato!');

  with A058FPianifTurniDtM1 do
  begin
    selT620.Close;
    selT620.SetVariable('DATAA',DataFine);
    selT620.Open;
    R502ProDtM.PeriodoConteggi(DataInizio,DataFine);
    R502ProDtM.Conteggi('APERTURA',0,DataInizio);
    ConteggiaDebito:=False;
    PulisciVista;
  end;

  if A058FPianifTurniDtM1.NuovaPianif then
  begin
    //Primo scorrimento per verificare se esiste già una pianificazione
    S:='';
    x:=0;
    C700SelAnagrafe.First;
    while not C700SelAnagrafe.Eof do
    begin
      A058FPianifTurniDtm1.LeggiPianificazione(C700SelAnagrafe.FieldByName('Progressivo').AsInteger,A058FPianifTurniDtm1.DataInizio,A058FPianifTurniDtm1.DataFine,False);
      if ((A058FPianifTurniDtM1.selT082.fieldByName('MODALITA_LAVORO').AsString = 'O') and (A058FPianifTurniDtM1.Q080Gest.RecordCount > 0)) or
         ((A058FPianifTurniDtM1.selT082.fieldByName('MODALITA_LAVORO').AsString = 'N') and (A058FPianifTurniDtM1.Q081Gest.RecordCount > 0)) then
      begin
        inc(x);
        if x > 20 then
        begin
          S:=S + 'ecc...' + #13#10;
          Break;
        end
        else
          S:=S + Format('%-8s %s %s',[C700SelAnagrafe.FieldByName('MATRICOLA').AsString,
                                      C700SelAnagrafe.FieldByName('COGNOME').AsString,
                                      C700SelAnagrafe.FieldByName('NOME').AsString]) + #13#10;
      end;
      C700SelAnagrafe.Next;
    end;
    if S <> '' then
      if MessageDlg('La pianificazione esiste già per i seguenti dipendenti:' + #13#10 + S + #13#10 +
                    'La creazione di una nuova pianificazione non eliminerà quella esistente.' + #13#10 +
                    'Continuare?',mtConfirmation,[mbYes,mbNo],0) <> mrYes then
        exit;
  end;

  ProgressBar1.Position:=0;
  ProgressBar1.Max:=C700SelAnagrafe.RecordCount;
  C700SelAnagrafe.First;
  while not C700SelAnagrafe.Eof do
  begin
    //=====================================================================
    //TRAVASO DELLE ASSENZE DALLA T040_GIUSTIFICATIVI ALLA T041_PROVVISORIO
    //=====================================================================
    if not A058FPianifTurniDtm1.AssenzeOperative then
    begin
      with A058FPianifTurniDtm1 do
      begin
        if Parametri.CampiRiferimento.C11_PianifOrari_No_CopiaGiustif = 'SOVRASCRIVI' then
        begin
          SovrascriviT041.SetVariable('PROGRESSIVO',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
          SovrascriviT041.SetVariable('DATADA',DataInizio);
          SovrascriviT041.SetVariable('DATAA',DataFine);
          SovrascriviT041.Execute;
        end
        else if Parametri.CampiRiferimento.C11_PianifOrari_No_CopiaGiustif = 'AGGIUNGI' then
        begin
          InserisciT041.SetVariable('PROGRESSIVO',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
          InserisciT041.SetVariable('DATADA',DataInizio);
          InserisciT041.SetVariable('DATAA',DataFine);
          InserisciT041.Execute;
        end;
        InserisciT041.Session.Commit;
      end;
    end;
    frmSelAnagrafe.VisualizzaDipendente;
    ProgressBar1.Position:=ProgressBar1.Position + 1;
    if A058FPIanifTurniDtm1.NuovaPianif then
    begin
      A058FPianifTurniDtM1.PianificaDipendente(C700SelAnagrafe.FieldByName('Progressivo').AsInteger)  //Nuova pianificazione
    end
    else
    begin
      A058FPianifTurniDtM1.LeggiPianificazione(C700SelAnagrafe.FieldByName('Progressivo').AsInteger,A058FPianifTurniDtm1.DataInizio,A058FPianifTurniDtm1.DataFine); //Leggo pianif.esist.      if A058FPianifTurniDtM1.Vista.Count > 0 then
    end;
    if A058FPianifTurniDtM1.Vista.Count > 0 then
    begin
      A058FPianifTurniDtM1.DebitoDipendente(A058FPianifTurniDtM1.Vista[A058FPianifTurniDtM1.Vista.Count - 1],0,
                                            Trunc(A058FPianifTurniDtm1.DataFine - A058FPianifTurniDtm1.DataInizio));
    end;
    C700SelAnagrafe.Next;
  end;
  A058FPianifTurniDtM1.Vista.Controllo_TurnoAntincendio(A058FPianifTurniDtm1.DataInizio, A058FPianifTurniDtm1.DataFine);
  A058FPianifTurniDtM1.Vista.Controllo_Referente(A058FPianifTurniDtm1.DataInizio, A058FPianifTurniDtm1.DataFine);
  ProgressBar1.Position:=0;

  if (Sender = btnVisualizza) or (Sender = btnEsegui) then
    VisualizzaGriglia
  else if Sender = btnAnteprima then {Lancio anteprima}
    Anteprima_Stampa(True)
  else if Sender = btnStampa then {Lancio stampa}
    Anteprima_Stampa(False);
end;

procedure TA058FPianifTurni.VisualizzaGriglia;
{Visualizzo la form con la griglia di pianificazione}
begin
  A058FGrigliaPianif:=TA058FGrigliaPianif.Create(nil);
  try
    A058FPianifTurniDtm1.GeneraIniCorr:=chkIniCorr.Checked;
    A058FGrigliaPianif.DatoModificato:=A058FPianifTurniDtm1.NuovaPianif;
    if A058FPianifTurniDtm1.NuovaPianif then
      A058FGrigliaPianif.Caption:='<A058> Sviluppo pianificazione '
    else
      A058FGrigliaPianif.Caption:='<A058> Visualizzazione pianificazione ';
    if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
      A058FGrigliaPianif.Caption:=A058FGrigliaPianif.Caption + 'progressiva '
    else
      A058FGrigliaPianif.Caption:=A058FGrigliaPianif.Caption + 'statica ';
    if A058FPianifTurniDtM1.selT082.fieldByName('MODALITA_LAVORO').AsString = 'O' then
      A058FGrigliaPianif.Caption:=A058FGrigliaPianif.Caption + 'operativa '
    else
    begin
      A058FGrigliaPianif.Caption:=A058FGrigliaPianif.Caption + 'non operativa ';
      if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
      begin
        if A058FPianifTurniDtm1.TipoPianif = 0 then
          A058FGrigliaPianif.Caption:=A058FGrigliaPianif.Caption + 'iniziale'
        else
          A058FGrigliaPianif.Caption:=A058FGrigliaPianif.Caption + 'corrente';
      end;
    end;
    A058FGrigliaPianif.Caption:=A058FGrigliaPianif.Caption + Format(' dal %s al %s. Squadra: %s - %s',[frmInputPeriodo.edtInizio.Text,frmInputPeriodo.edtFine.Text,A058FPianifTurniDtm1.SquadraRiferimento,dlblSquadra.Caption]);
    A058FGrigliaPianif.GVista.RowCount:=A058FPianifTurniDtm1.Vista.Count + A058FGrigliaPianif.nRigheBloccate;
    A058FGrigliaPianif.GVista.ColCount:=Trunc(A058FPianifTurniDtm1.DataFine - A058FPianifTurniDtm1.DataInizio)
                                      + 1 + A058FGrigliaPianif.nColonneBloccate;
    RiempiGriglia;
    A058FGrigliaPianif.BCancellazione.Visible:=Not A058FPianifTurniDtm1.NuovaPianif;
    A058FGrigliaPianif.ShowModal;
  finally
    A058FGrigliaPianif.Release;
  end;
end;

procedure TA058FPianifTurni.RiempiGriglia;
{Riempo le celle di GVista col contenuto di Vista}
var
  i,j:LongInt;
  DataCorr:TDateTime;
begin
  with A058FGrigliaPianif do
  begin
    //Stampa delle date sulla prima righa di intestazione
    i:=nColonneBloccate;
    DataCorr:=A058FPianifTurniDtm1.DataInizio;
    while DataCorr <= A058FPianifTurniDtm1.DataFine do
    begin
      //GVista.Cells[i,0]:=FormatDateTime('dd/mm/yy',DataCorr);
      GVista.Cells[i,0]:=FormatDateTime('dd/mm',DataCorr);
      DataCorr:=DataCorr + 1;
      Inc(i);
    end;

    for i:=0 to A058FPianifTurniDtm1.Vista.Count - 1 do
    begin
      //Inserisco la Matricola
      GVista.Cells[0,i + nRigheBloccate]:=A058FPianifTurniDtm1.Vista[i].Matricola;
      GVista.RowHeights[i + nRigheBloccate]:=GVista.DefaultRowHeight;
      for j:=0 to A058FPianifTurniDtm1.Vista[i].Giorni.Count - 1 do
      begin
        with A058FPianifTurniDtm1.Vista[i].Giorni[j] do
        begin
          GVista.Cells[j + nColonneBloccate,i + nRigheBloccate]:=
          Format('%-2s%-3s%-1s%-2s%-3s%-1s%s',[T1, SiglaT1, T1EU,
                                               T2, SiglaT2, T2EU,
                                               R180DimLung(Ora,5)]);
        end;
      end;
      ImpostaAltezzaRiga(i);
    end;
  end;
end;

procedure TA058FPianifTurni.Anteprima_Stampa(SoloAnteprima:Boolean);
{Impostazioni di Stampa}
var
  i,j,k,xx,yy,SalvaInizio,SalvaFine,
  NumSquadre,PSquadra:Integer;
  Squadre:array[1..31] of TSquadre;
  SquadraOld:string;
  {Se sono state rilevate timbrature non causalizzate nei giorni in cui è presente una timbrature che esclude il turno, le stampo}
  StampaTimbrature:Boolean;

  procedure CreaTabellaStampa;
  var i:Integer;
  begin
    with A058FPianifTurniDtM1 do
    begin
      T058Stampa.Close;
      //Creo la tabella di appoggio T058Stampa
      with T058Stampa.FieldDefs do
      begin
        Clear;
        Add('Matricola',ftString,10,False);
        Add('DataInizio',ftDate);
        Add('DataFine',ftDate);
        Add('Squadra',ftString,10,False);
        Add('Operatore',ftString,5,False);
        Add('Nome',ftString,50,False);
        Add('Badge',ftInteger,0,False);
        Add('Progressivo',ftInteger,0,False);
        Add('DSquadra',ftString,40,False);
        Add('Partenza',ftInteger,0,False);
        //=================================
        //===Creazione campi giornalieri===
        //=================================
        //Creo i campi giornalieri
        for i:=0 to Min(selT082.FieldByName('GG_PAGINA').AsInteger - 1,Trunc(DataFine - DataInizio)) do
        begin
          //Reperibilità
          Add('RepSigla1_' + i.ToString,ftString,5,False);
          {Add('RepSigla2_' + i.ToString,ftString,5,False);
          Add('RepSigla3_' + i.ToString,ftString,5,False);}
          //Orari
          Add('Orari' + IntToStr(i),ftString,5,False);
          Add('Turni' + IntToStr(i),ftString,10,False);
          Add('CodOrari' + IntToStr(i),ftString,5,False);
          Add('CodAssenze' + IntToStr(i),ftString,5,False);
          Add('Antincendio' + IntToStr(i),ftString,1,False);
          //Numero timbrature che non escludono il turno
          Add('NTimbTurno_' + IntToStr(i),ftInteger,0,False);
        end;
        //=================================
        //if selV430.Active then
        if not selT082.FieldByName('DATO_ANAGRAFICO').IsNull then
        begin
          selV430.Open;
          Add('DatoAnag',ftString,selV430.FieldByName(selT082.FieldByName('DATO_ANAGRAFICO').AsString).DataSize,False);
        end;
        Add('Debito',ftInteger,0,False);
        Add('Assegnato',ftInteger,0,False);
      end;
      T058Stampa.IndexDefs.Clear;
      T058Stampa.IndexDefs.Clear;
      {--> SQUADRA;DATAINIZIO in 1° e 2° posizione è necessaria per il corretto sviluppo della stampa <--}
      T058Stampa.IndexDefs.Add('ORDK','Squadra;DataInizio;' + OrdinamentoStampa{function},[]);
      {with T058Stampa.IndexDefs do
      begin}
        {--> DATAINIZIO;SQUADRA in 1° e 2° posizione è necessaria per il corretto sviluppo della stampa <--}
        {Clear;
        Add('TK','Squadra;DataInizio;Nome;Badge',[]);
        Add('PK','Squadra;DataInizio;Operatore;Nome;Badge',[]);
        Add('SK','Squadra;DataInizio;Partenza;Nome;Badge',[]);
        Add('NK','Squadra;DataInizio;Turni0;Nome;Badge',[])
      end;}
      T058Stampa.CreateDataSet;
      T058Stampa.LogChanges:=False;
      T058Stampa.IndexName:='ORDK';
      {if selT082.FieldByName('ORD_STAMPA').AsString = 'C' then
        T058Stampa.IndexName:='TK'//DataInizio;Squadra;Nome;Badge
      else if selT082.FieldByName('ORD_STAMPA').AsString = 'S' then
        T058Stampa.IndexName:='PK'//DataInizio;Squadra;Operatore;Nome
      else if selT082.FieldByName('ORD_STAMPA').AsString = 'T' then
        T058Stampa.IndexName:='SK'//DataInizio;Squadra;Partenza;Nome
      else if selT082.FieldByName('ORD_STAMPA').AsString = 'P' then
        T058Stampa.IndexName:='NK';//DataInizio;Squadra;Partenza;Nome}
      T058Stampa.Open;
    end;
  end;

  function GetSquadra(S:String):Integer;
  var
    i:Integer;
  begin
    Result:=0;
    for i:=1 to NumSquadre do
      if Squadre[i].Squadra = S then
      begin
        Result:=i;
        Break;
      end;
  end;

  function Turni(GiornoIn:TGiorno):String;
  {Restituisco la stringa dei 2 turni}
  var
    Giorno:TGiorno;
    T1,T2:String;
  begin
    T1:=Trim(GiornoIn.T1);
    if GiornoIn.T1EU = 'U' then
      T1:= '-8';
    T2:=Trim(GiornoIn.T2);
    Result:=Copy('      ',1,A058FPianifTurniDtm1.LungCella);
    if T1 = '0' then
    begin
      Result:=Copy('Rp    ',1,A058FPianifTurniDtm1.LungCella);
      exit;
    end;
    if T1 = '-8' then
    //Smonto notte
    begin
      Result:=Copy('Sn    ',1,A058FPianifTurniDtm1.LungCella);
      exit;
    end;
    Giorno:=TGiorno.Create;
    Giorno.ParentDipendente:=GiornoIn.ParentDipendente;
    Giorno.Ora:=GiornoIn.Ora.Trim;
    Giorno.T1:=T1;
    Giorno.T2:=T2;
    Result:=R180DimLung(Giorno.SiglaT1,3);
    if Giorno.T2 <> '' then
      Result:=Result + R180DimLung(Giorno.SiglaT2,3)
    else
      Result:=R180DimLung(Result,A058FPianifTurniDtm1.LungCella);
    FreeAndNil(Giorno);
  end;

  procedure GetGiorni(Dip:Integer);
  var
    i,j,k,iTr,xx:Integer;
    T,SiglaTurno:String;
    DataCorr:TDateTime;
    A,M,G:Word;
    {Bruno: 31/10/2017
    Giorno:TGiorno;}
    Incrementa, ConteggioNorm:Boolean;
  begin
    for xx:=Low(Squadre) to High(Squadre) do
    begin
      Squadre[xx].DSquadra:='';
      Squadre[xx].Oper:='';
      Squadre[xx].S1:='';
      Squadre[xx].S2:='';
      Squadre[xx].Squadra:='';
    end;
    NumSquadre:=0;
    SquadraOld:='';
    (*Al*)//DataCorr:=A058FPianifTurni.DataInizio;
    (*Al*)DataCorr:=A058FPianifTurniDtm1.DataInizio + SalvaInizio;
    with A058FPianifTurniDtm1.Vista[Dip] do
    begin
      if A058FPianifTurniDtM1.selT082.FieldByName('TIPO_STAMPA').AsString = 'C' then
      //Utilizzo i dati ritornati dai conteggi anzichè quelli pianificati
      begin
        //Alberto 29/12/2005: aggiorno i totali turni individuali
        SetLength(TotDip.Operatori,0);
        TotDip.Riposi:=0;
      end;
      (*Al*)//for i:=0 to Giorni.Count - 1 do
      (*Al*)for i:=SalvaInizio to Min(SalvaFine,Giorni.Count - 1) do
      begin
        if Giorni[i].Squadra = A058FPianifTurniDtm1.SquadraRiferimento then
        begin
          if SquadraOld <> Giorni[i].Squadra then
          begin
            SquadraOld:=Giorni[i].Squadra;
            PSquadra:=GetSquadra(SquadraOld);
            if PSquadra = 0 then
            begin
              inc(NumSquadre);
              PSquadra:=NumSquadre;
              Squadre[PSquadra].S1:=R180DimLung('',(i - SalvaInizio) * A058FPianifTurniDtm1.LungCella);
              Squadre[PSquadra].S2:=R180DimLung('',(i - SalvaInizio) * A058FPianifTurniDtm1.LungCella);
            end;
            Squadre[PSquadra].Squadra:=Giorni[i].Squadra;
            Squadre[PSquadra].DSquadra:=Giorni[i].DSquadra;
            Squadre[PSquadra].Oper:=Giorni[i].Oper;
          end;
          if NumSquadre = 0 then
          begin
            SquadraOld:=Giorni[i].Squadra;
            inc(NumSquadre);
            PSquadra:=NumSquadre;
            Squadre[PSquadra].Squadra:=Giorni[i].Squadra;
            Squadre[PSquadra].DSquadra:=Giorni[i].DSquadra;
            Squadre[PSquadra].Oper:=Giorni[i].Oper;
          end;
          if A058FPianifTurniDtM1.selT082.FieldByName('TIPO_STAMPA').AsString = 'C' then
          //Utilizzo i dati ritornati dai conteggi anzichè quelli pianificati
          begin
            with A058FPianifTurniDtM1 do
            begin
              InizializzaGiorno(Vista[Dip],i);
              DecodeDate(DataCorr,A,M,G);
              (*Alberto (Pescara)*)
              InizializzaConteggiGiornalieri(Vista[Dip],i,ConteggioNorm);
              {A058FPianifTurniDtM1.R502ProDtM.PianificazioneEsterna.Progressivo:=0;
              A058FPianifTurniDtM1.R502ProDtM.PianificazioneEsterna.Data:=0;
              A058FPianifTurniDtM1.R502ProDtM.Conteggi('Cartolina',Prog,DataCorr);}
              {Aggiorno contatore totale liquidabile}
              inc(TotGio[i].OreLiquid,R180SommaArray(R502ProDtM.tminstrgio));
              {-- CALCOLO TOTALE TURNI DA CONTEGGI GIORNALIERI(Stampa consuntiva) --}
              Incrementa:=False;
              if (R502ProDtM.blocca = 0) then
              begin
                {Verico la presenza di causali che escludono il turno}
                Incrementa:=True;
                if selT100.SearchRecord('DATA',DataCorr,[srFromBeginning]) then
                  repeat
                    if selT100.FieldByName('CAUSALE').IsNull or
                       (pos(',' + selT100.FieldByName('CAUSALE').AsString + ',',',' + selT082.fieldByName('CAUS_ECLUDITURNO').AsString + ',') = 0) then
                      inc(Giorni[i].NTimbTurno)
                    else
                    begin
                      Incrementa:=False;
                      StampaTimbrature:=True;
                    end;
                  until not selT100.SearchRecord('DATA',DataCorr,[srForward]);
                if Incrementa then
                  Giorni[i].NTimbTurno:=0;
              end;
            end;
            GiorniOld[i].Ora:=Giorni[i].Ora;
            GiorniOld[i].T1:=Giorni[i].T1;
            GiorniOld[i].T2:=Giorni[i].T2;
            GiorniOld[i].T1EU:=Giorni[i].T1EU;
            GiorniOld[i].T2EU:=Giorni[i].T2EU;
            GiorniOld[i].Ass1:=Giorni[i].Ass1;
            GiorniOld[i].Ass2:=Giorni[i].Ass2;
            GiorniOld[i].SiglaT1:=Giorni[i].SiglaT1;
            GiorniOld[i].SiglaT2:=Giorni[i].SiglaT2;
            GiorniOld[i].Antincendio:=Giorni[i].Antincendio;
            GiorniOld[i].Referente:=Giorni[i].Referente;
            GiorniOld[i].RichiestoDaTurnista:=Giorni[i].RichiestoDaTurnista;
            GiorniOld[i].Note:=Giorni[i].Note;

            if (A058FPianifTurniDtM1.R502ProDtM.Blocca <> 0) or
               (A058FPianifTurniDtM1.R502ProDtM.dipinser = 'no') then
            begin
              Giorni[i].T1:='';
              Giorni[i].T2:='';
              Giorni[i].T1EU:='';
              Giorni[i].T2EU:='';
              Giorni[i].Ora:='';
              Giorni[i].Ass1:='';
              Giorni[i].Ass2:='';
              Giorni[i].SiglaT1:='';
              Giorni[i].SiglaT2:='';
              Giorni[i].Antincendio:='N';
              Giorni[i].Referente:='';
              Giorni[i].RichiestoDaTurnista:='';
              Giorni[i].Note:='';
            end
            else
            begin
              //Orario
              Giorni[i].Ora:=A058FPianifTurniDtM1.R502ProDtM.c_orario;
              //1° Turno
              Giorni[i].T1:='';
              Giorni[i].SiglaT1:='';
              if A058FPianifTurniDtM1.R502ProDtM.r_turno1 > 0 then
              begin
                Giorni[i].T1:=IntToStr(A058FPianifTurniDtM1.R502ProDtM.r_turno1);
                Giorni[i].SiglaT1:=A058FPianifTurniDtM1.R502ProDtM.s_turno1;
              end;
              //2° Turno
              Giorni[i].T2:='';
              Giorni[i].SiglaT2:='';
              if A058FPianifTurniDtM1.R502ProDtM.r_turno2 > 0 then
              begin
                Giorni[i].T2:=IntToStr(A058FPianifTurniDtM1.R502ProDtM.r_turno2);
                Giorni[i].SiglaT2:=A058FPianifTurniDtM1.R502ProDtM.s_turno2;
              end;
              //Assenza
              Giorni[i].Ass1:='';
              Giorni[i].Ass2:='';
              if A058FPianifTurniDtM1.R502ProDtM.n_giusgga = 1 then
                Giorni[i].Ass1:=A058FPianifTurniDtM1.R502ProDtM.tgius_ggass[1].tcausggass
              else if A058FPianifTurniDtM1.R502ProDtM.n_giusgga > 1 then
              begin
                Giorni[i].Ass1:=A058FPianifTurniDtM1.R502ProDtM.tgius_ggass[1].tcausggass;
                Giorni[i].Ass2:=A058FPianifTurniDtM1.R502ProDtM.tgius_ggass[2].tcausggass;
                if R180In(A058FPianifTurniDtM1.R502ProDtM.ValStrT265[Giorni[i].Ass1,'CODINTERNO'],['E','H']) then
                begin
                  Giorni[i].Ass1:=A058FPianifTurniDtM1.R502ProDtM.tgius_ggass[2].tcausggass;
                  Giorni[i].Ass2:=A058FPianifTurniDtM1.R502ProDtM.tgius_ggass[1].tcausggass;
                end;
              end;
            end;
            //Aggiornamento dei totali dei turni
            if Incrementa then
              A058FPianifTurniDtm1.AggiornaTotaleTurni(A058FPianifTurniDtm1.Vista[Dip],i,False);
            //Alberto (Pescara)
            Giorni[i].Debito:=A058FPianifTurniDtM1.R502ProDtM.debitocl;
            Giorni[i].Assegnato:=0;//A058FPianifTurniDtM1.R502ProDtM.debitogg;
            if A058FPianifTurniDtM1.R502ProDtM.PianificazioneEsterna.l08_turno1 > 0 then
              inc(Giorni[i].Assegnato,
                  A058FPianifTurniDtM1.R502ProDtM.ValNumT021['ORETEOTUR',
                                                             TF_PUNTI_NOMINALI,
                                                             A058FPianifTurniDtM1.R502ProDtM.PianificazioneEsterna.l08_turno1]);
            if A058FPianifTurniDtM1.R502ProDtM.PianificazioneEsterna.l08_turno2 > 0 then
              inc(Giorni[i].Assegnato,
                  A058FPianifTurniDtM1.R502ProDtM.ValNumT021['ORETEOTUR',
                                                             TF_PUNTI_NOMINALI,
                                                             A058FPianifTurniDtM1.R502ProDtM.PianificazioneEsterna.l08_turno2]);
            if Giorni[i].Assegnato = 0 then
              Giorni[i].Assegnato:=A058FPianifTurniDtM1.R502ProDtM.debitogg;
          end
          //Alberto (Pescara)
          else if (not A058FPianifTurniDtm1.ConteggiaDebito) and (A058FPianifTurniDtm1.selT082.FieldByName('SALDI_ORE').AsString = 'S') then
          begin
            A058FPianifTurniDtm1.ConteggiaDebito:=True;
            A058FPianifTurniDtM1.ConteggiGiornalieri(DataCorr,A058FPianifTurniDtm1.Vista[Dip],i);
            A058FPianifTurniDtm1.ConteggiaDebito:=False;
          end;

          //Se assenza e stampa ridotta scrivo il codice assenza al posto del turno
          if (Giorni[i].Ass1 <> '') and (A058FPianifTurniDtM1.selT082.FieldByName('DETT_STAMPA').AsString = 'S') then
            Squadre[PSquadra].S1:=Squadre[PSquadra].S1 + R180DimLung(Giorni[i].Ass1,A058FPianifTurniDtm1.LungCella)
          else
          begin
            //Leggo la descrizione turni dall'orario
            T:=Turni(Giorni[i]);
            if (Trim(T) = '') and (A058FPianifTurniDtM1.selT082.FieldByName('DETT_STAMPA').AsString = 'S') then
              T:=R180DimLung(Giorni[i].Ora,A058FPianifTurniDtm1.LungCella);
            Squadre[PSquadra].S1:=Squadre[PSquadra].S1 + T;
          end;
          if Giorni[i].Ass1 = '' then
          begin
            if A058FPianifTurniDtM1.selT082.FieldByName('DETT_STAMPA').AsString = 'D' then
              //Scrivo codice orario
              Squadre[PSquadra].S2:=Squadre[PSquadra].S2 + R180DimLung(Giorni[i].Ora,A058FPianifTurniDtm1.LungCella)
            else
              Squadre[PSquadra].S2:=Squadre[PSquadra].S2 + R180DimLung('',A058FPianifTurniDtm1.LungCella);
          end
          else
            //Scrivo codice assenza
          begin
            if A058FPianifTurniDtM1.selT082.FieldByName('DETT_STAMPA').AsString = 'D' then
              Squadre[PSquadra].S2:=Squadre[PSquadra].S2 + R180DimLung(Giorni[i].Ass1,A058FPianifTurniDtm1.LungCella)
            else
              Squadre[PSquadra].S2:=Squadre[PSquadra].S2 + '      ';
          end;
          for j:=1 to NumSquadre do
            if j <> PSquadra then
            begin
              Squadre[j].S1:=Squadre[j].S1 + R180DimLung('',A058FPianifTurniDtm1.LungCella);
              Squadre[j].S2:=Squadre[j].S2 + R180DimLung('',A058FPianifTurniDtm1.LungCella);
            end;
          DataCorr:=DataCorr + 1;
        end;
      end;
    end;
    A058FPianifTurniDtm1.DebitoDipendente(A058FPianifTurniDtm1.Vista[Dip],SalvaInizio,Min(SalvaFine,A058FPianifTurniDtm1.Vista[Dip].Giorni.Count - 1));
  end;

  procedure CaricaTabellaStampa;
  var
    i,j,k,y,iSgOp,x,z,ggfine,Count:Integer;
    SigleSint, Nominativo:String;
  begin
    with A058FPianifTurniDtM1 do
    begin
      //Scorrimento dipendenti selezionati
      for i:=0 to Vista.Count - 1 do
      begin
        OpenSelT100(Vista[i].Prog,DataInizio,DataFine);
        NumSquadre:=1;
        GetGiorni(i);
        for j:=1 to NumSquadre do
        begin
          T058Stampa.Append;
          (*Al*)T058Stampa.FieldByName('DataInizio').AsDateTime:=A058FPianifTurniDtm1.DataInizio + SalvaInizio;
          (*Al*)T058Stampa.FieldByName('DataFine').AsDateTime:=Min(A058FPianifTurniDtm1.DataInizio + SalvaFine,A058FPianifTurniDtm1.DataFine);

          //if selV430.Active and selV430.SearchRecord('PROGRESSIVO',Vista[i].Prog,[srFromBeginning]) then
          if not selT082.FieldByName('DATO_ANAGRAFICO').IsNull then
          begin
            R180SetVariable(selV430,'PROGRESSIVO',Vista[i].Prog);
            selV430.Open;
            T058Stampa.FieldByName('DatoAnag').AsString:=selV430.FieldByName(selT082.FieldByName('DATO_ANAGRAFICO').AsString).AsString;
          end;
          T058Stampa.FieldByName('Matricola').AsString:=Vista[i].Matricola;
          T058Stampa.FieldByName('Squadra').AsString:=Squadre[j].Squadra;
          T058Stampa.FieldByName('DSquadra').AsString:=Squadre[j].DSquadra;
          T058Stampa.FieldByName('Operatore').AsString:=Vista[i].TipoOpe.Replace('(','').Replace(')','').Trim;
          T058Stampa.FieldByName('Badge').AsInteger:=Vista[i].Badge;
          //Conposizione nome
          Nominativo:=Vista[i].Cognome;
          if (selT082.FieldByName('COMPATTA_RIGHE_DIP').AsString = 'S') or (selT082.FieldByName('RIGHE_NOME').AsString = 'N') then
            Nominativo:=Nominativo + ' '
          else
            Nominativo:=Nominativo + #13#10;
          Nominativo:=Nominativo + Vista[i].Nome;
          Nominativo:=Copy(Nominativo,1,50);
          if selT082.FieldByName('COMPATTA_RIGHE_DIP').AsString = 'S' then
            Nominativo:=IfThen(Length(Nominativo) > 25,Copy(Nominativo,1,24) + '.',Nominativo);
          T058Stampa.FieldByName('Nome').AsString:=Nominativo;
          T058Stampa.FieldByName('Progressivo').AsInteger:=Vista[i].Prog;
          T058Stampa.FieldByName('Debito').AsInteger:=Vista[i].Debito;
          T058Stampa.FieldByName('Assegnato').AsInteger:=Vista[i].Assegnato;
          T058Stampa.FieldByName('Partenza').AsInteger:=Vista[i].TurnoPartenza;
          with Vista[i] do
          begin
            Count:=0;
      (*Al*)//for y:=0 to Giorni.Count - 1 do
      (*Al*)ggfine:=Min(SalvaFine,Giorni.Count - 1);
      (*Al*)for y:=SalvaInizio to ggfine do
            begin
              if Giorni[y].Squadra = A058FPianifTurniDtm1.SquadraRiferimento then
              begin
                //Reperibilità
                T058Stampa.FieldByName('RepSigla1_' + Count.ToString).AsString:=Giorni[y].TurniRep[1].Sigla;
                {T058Stampa.FieldByName('RepSigla2_' + Count.ToString).AsString:=Giorni[y].TurniRep[2].Sigla;
                T058Stampa.FieldByName('RepSigla3_' + Count.ToString).AsString:=Giorni[y].TurniRep[3].Sigla;}
                //T058Stampa.FieldByName('Reperibilita' + Count.ToString).AsString:=Giorni[y].TurniRep;
                T058Stampa.FieldByName('CodOrari' + IntToStr(Count)).AsString:=Giorni[y].Ora;
                T058Stampa.FieldByName('CodAssenze' + IntToStr(Count)).AsString:=Giorni[y].Ass1;
                //Numero timbrature che non escludono il turno
                T058Stampa.FieldByName('NTimbTurno_' + IntToStr(Count)).AsInteger:=Giorni[y].NTimbTurno;
                {Valorizzazione dei campi totali operatore}
                T058Stampa.FieldByName('Orari' + IntToStr(Count)).AsString:=Vista[i].Giorni[y].Ora;
                //TURNO #1
                if (selT082.FieldByName('ORARIO_SINTETICO').AsString = 'N') or (Vista[i].Giorni[y].T1 <> ' M') then
                  SigleSint:=Vista[i].Giorni[y].SiglaT1
                else
                  SigleSint:=Vista[i].Giorni[y].Ora;

                if (SigleSint = '') and R180In(Vista[i].Giorni[y].T1,[' A',' M']) then
                  SigleSint:='[' + Trim(Vista[i].Giorni[y].T1) + ']';
                SigleSint:=StringReplace(SigleSint,']',')',[rfReplaceAll]);
                SigleSint:=StringReplace(SigleSint,'[','(',[rfReplaceAll]);
                SigleSint:=StringReplace(SigleSint,')','',[rfReplaceAll]);
                SigleSint:=StringReplace(SigleSint,'(','',[rfReplaceAll]);
                T058Stampa.FieldByName('Turni' + IntToStr(Count)).AsString:=SigleSint;// + Vista[i].Giorni[y].T1EU;

                //TURNO #2
                //Se la stampa è predisposta per due righe dipendente rimuovo le parentesi
                if Vista[i].Giorni[y].SiglaT2 <> '' then
                begin
                  SigleSint:=Vista[i].Giorni[y].SiglaT2;
                  if (SigleSint = '') and R180In(Trim(Vista[i].Giorni[y].T2),['A','M']) then
                    SigleSint:='[' + Trim(Vista[i].Giorni[y].T2) + ']';
                  SigleSint:=StringReplace(SigleSint,')','',[rfReplaceAll]);
                  SigleSint:=StringReplace(SigleSint,'(','',[rfReplaceAll]);
                  T058Stampa.FieldByName('Turni' + IntToStr(Count)).AsString:=T058Stampa.FieldByName('Turni' + IntToStr(Count)).AsString
                    + IfThen(selT082.FieldByName('COMPATTA_RIGHE_DIP').AsString = 'N',#13#10,' ')
                    + SigleSint;// + Vista[i].Giorni[y].T2EU;
                end;

                if (selT082.FieldByName('ASSENZE').AsString = 'S') and
                   (selT082.FieldByName('DETT_STAMPA').asString = 'D') and
                   ((Vista[i].Giorni[y].Ass1 + Vista[i].Giorni[y].Ass2) <> '') then
                  T058Stampa.FieldByName('Orari' + IntToStr(Count)).AsString:=Vista[i].Giorni[y].Ass1 + ' ' + Vista[i].Giorni[y].Ass2
                else if (selT082.FieldByName('ASSENZE').AsString = 'S') and
                        (selT082.FieldByName('DETT_STAMPA').asString = 'S') and
                        ((Vista[i].Giorni[y].Ass1 + Vista[i].Giorni[y].Ass2) <> '') then
                  T058Stampa.FieldByName('Turni' + IntToStr(Count)).AsString:=Vista[i].Giorni[y].Ass1 + IfThen(Vista[i].Giorni[y].Ass2 <> '',#13#10 + Vista[i].Giorni[y].Ass2);

                T058Stampa.FieldByName('Antincendio' + IntToStr(Count)).AsString:=Vista[i].Giorni[y].Antincendio;

                inc(Count);
              end
              else
                inc(Count);
            end;
          end;
          T058Stampa.Post;
        end;
      end;
    end;
  end;

begin
  A058FTabellone:=TA058FTabellone.Create(nil);
  A058FTabellone.QRep.PrinterSettings.UseStandardPrinter:=(TipoModulo = 'COM') and Parametri.UseStandardPrinter;
  C001SettaQuickReport(A058FTabellone.QRep);
  C001SettaCompositeReport(MyCompRep);
  StampaTimbrature:=False;
  if A058FPianifTurniDtM1.selT082.FieldByName('DETT_STAMPA').AsString = 'S' then
    A058FPianifTurniDtM1.LungCella:=5
  else
    A058FPianifTurniDtM1.LungCella:=6;
  with A058FTabellone do
  begin
    LOrari.Clear;
    LAssenze.Clear;
    QRMOrari.Lines.Clear;
    QRMAssenze.Lines.Clear;
    QRTitolo.Caption:=A058FPianifTurniDtM1.selT082.FieldByName('TITOLO').AsString;
    QRNota.Caption:=A058FPianifTurniDtM1.selT082.FieldByName('NOTE_STAMPA').AsString;
    QRDesc1.Caption:=A058FPianifTurniDtM1.selT082.FieldByName('DESCRIZIONE1').AsString;
    QRDesc2.Caption:=A058FPianifTurniDtM1.selT082.FieldByName('DESCRIZIONE2').AsString;
    //Inizializzo Dataset dato angrafico
    if not A058FPianifTurniDtM1.selT082.FieldByName('DATO_ANAGRAFICO').isNull then
      A058FPianifTurniDtM1.OpenSelV430('T030.PROGRESSIVO, ' + A058FPianifTurniDtM1.selT082.FieldByName('DATO_ANAGRAFICO').AsString);
    //InizializzaStampa;
    //Ciclo sul periodo in base agli x giorni da stampare
    CreaTabellaStampa;
    A058FPianifTurniDtM1.OldInizio:=A058FPianifTurniDtm1.DataInizio;
    A058FPianifTurniDtM1.OldFine:=A058FPianifTurniDtm1.DataFine;
    Screen.Cursor:=crHourGlass;
    ProgressBar1.Position:=0;
    SalvaInizio:=0;
    if (   (A058FPianifTurniDtM1.selT082.FieldByName('GG_PAGINA').AsInteger = 0)
        or (A058FPianifTurniDtM1.selT082.FieldByName('GG_PAGINA').AsInteger >= 31))
    and (A058FPianifTurniDtm1.DataInizio = R180InizioMese(A058FPianifTurniDtm1.DataInizio))
    and (A058FPianifTurniDtm1.DataFine = R180FineMese(A058FPianifTurniDtm1.DataFine))
    then
      //Separo i mesi interi
      SalvaFine:=R180GiorniMese(A058FPianifTurniDtm1.DataInizio) - 1
    else
      SalvaFine:=A058FPianifTurniDtM1.selT082.FieldByName('GG_PAGINA').AsInteger - 1;
    with A058FPianifTurniDtM1 do
      if selT082.FieldByName('TIPO_STAMPA').AsString = 'C' then
      //Utilizzo i dati ritornati dai conteggi anzichè quelli pianificati
      begin
        SetLength(TotGio,0);
        SetLength(TotTabGio,0);
      end;
    ProgressBar1.Max:=Trunc((A058FPianifTurniDtm1.DataFine - A058FPianifTurniDtm1.DataInizio) / A058FPianifTurniDtM1.selT082.FieldByName('GG_PAGINA').AsInteger);
    repeat
      CaricaTabellaStampa;
      SalvaInizio:=SalvaFine + 1;
      if (   (A058FPianifTurniDtM1.selT082.FieldByName('GG_PAGINA').AsInteger = 0)
          or (A058FPianifTurniDtM1.selT082.FieldByName('GG_PAGINA').AsInteger >= 31))
      and (A058FPianifTurniDtm1.DataInizio = R180InizioMese(A058FPianifTurniDtm1.DataInizio))
      and (A058FPianifTurniDtm1.DataFine = R180FineMese(A058FPianifTurniDtm1.DataFine))
      then
        //Separo i mesi interi
        SalvaFine:=SalvaFine + R180GiorniMese(A058FPianifTurniDtm1.DataInizio + SalvaInizio)
      else
        SalvaFine:=SalvaFine + A058FPianifTurniDtM1.selT082.FieldByName('GG_PAGINA').AsInteger;
      ProgressBar1.StepBy(1);
    until A058FPianifTurniDtm1.DataInizio + SalvaInizio > A058FPianifTurniDtm1.DataFine;
    A058FPianifTurniDtM1.selV430.Close;

    A058FPianifTurniDtM1.T058Stampa.First;
    ProgressBar1.Position:=0;
    Screen.Cursor:=crDefault;

    if A058FPianifTurniDtM1.selT082.FieldByName('ORIENTAMENTO_PAG').asString = 'A' then
      if A058FPianifTurniDtM1.selT082.FieldByName('GG_PAGINA').AsInteger >= 15 then
        QRep.Page.Orientation:=poLandScape
      else
        QRep.Page.Orientation:=poPortrait
    else if A058FPianifTurniDtM1.selT082.FieldByName('ORIENTAMENTO_PAG').asString = 'V' then
      QRep.Page.Orientation:=poPortrait
    else if A058FPianifTurniDtM1.selT082.FieldByName('ORIENTAMENTO_PAG').asString = 'O' then
      QRep.Page.Orientation:=poLandScape;
    MyCompRep.PrinterSettings.PaperSize:=QRep.PrinterSettings.PaperSize;
    MyCompRep.PrinterSettings.Orientation:=QRep.Page.Orientation;

    if StampaTimbrature then
    begin
      (*Nascosto per ristrutturazione pianificazione turni. Se nessuno lo reclama, eliminare
      if A058FStampaRiepTimb <> nil then
        FreeAndNil(A058FStampaRiepTimb);
      A058FStampaRiepTimb:=TA058FStampaRiepTimb.Create(Self);
      C001SettaQuickReport(A058FStampaRiepTimb.QRRiepTimb);
      A058FStampaRiepTimb.StampaRiepTimb(A058FPianifTurniDtM1.Vista);*)
    end
    else if A058FStampaRiepTimb <> nil then
      FreeAndNil(A058FStampaRiepTimb);

    if A058FPianifTurniDtM1.selT082.FieldByName('RIEPILOGO_NOTE').AsString = 'S' then
    begin
      (*Nascosto per ristrutturazione pianificazione turni. Se nessuno lo reclama, eliminare
      if A058FStampaRiepNote <> nil then
        FreeAndNil(A058FStampaRiepNote);
      A058FStampaRiepNote:=TA058FStampaRiepNote.Create(Self);
      C001SettaQuickReport(A058FStampaRiepNote.QRRiepNote);
      A058FStampaRiepNote.StampaNote;*)
    end
    else if A058FStampaRiepNote <> nil then
      FreeAndNil(A058FStampaRiepNote);

    if (DocumentoPDF.Trim <> '') and (DocumentoPDF.Trim <> '<VUOTO>') and (TipoModulo.Trim = 'COM') then
    begin
      QRep.ShowProgress:=False;
      MyCompRep.ExportToFilter(TQRPDFDocumentFilter.Create(DocumentoPDF));
    end
    else if not SoloAnteprima then
    begin
      MyCompRep.Prepare;
      MyCompRep.Print;
    end
    else
    begin
      MyCompRep.Preview;
    end;
  end;
  try
    MyCompRep.Reports.Clear;
    A058FPianifTurniDtM1.T058Stampa.Close;
    if A058FStampaRiepTimb <> nil then
      FreeAndNil(A058FStampaRiepTimb);
    if A058FStampaRiepNote <> nil then
      FreeAndNil(A058FStampaRiepNote);
    FreeAndNil(A058FTabellone);
  except
    raise;
  end;

  //Per la stampa consuntiva da conteggi ho dovuto pacioccare Giorni, perciò...
  with A058FPianifTurniDtm1 do
    if selT082.FieldByName('TIPO_STAMPA').AsString = 'C' then
    begin
      SetLength(TotGio,0);
      SetLength(TotTabGio,0);
      for i:=0 to Vista.Count - 1 do
        with Vista[i] do
        begin
          SetLength(TotDip.Operatori,0);
          TotDip.Riposi:=0;
          for j:=0 to Giorni.Count - 1 do
          begin
            //...ripristino i valori originali...
            Giorni[j].T1:=GiorniOld[j].T1;
            Giorni[j].T2:=GiorniOld[j].T2;
            Giorni[j].T1EU:=GiorniOld[j].T1EU;
            Giorni[j].T2EU:=GiorniOld[j].T2EU;
            Giorni[j].Ora:=GiorniOld[j].Ora;
            Giorni[j].Ass1:=GiorniOld[j].Ass1;
            Giorni[j].Ass2:=GiorniOld[j].Ass2;
            Giorni[j].SiglaT1:=GiorniOld[j].SiglaT1;
            Giorni[j].SiglaT2:=GiorniOld[j].SiglaT2;
            Giorni[j].Antincendio:=GiorniOld[j].Antincendio;
            Giorni[j].Referente:=GiorniOld[j].Referente;
            Giorni[j].RichiestoDaTurnista:=GiorniOld[j].RichiestoDaTurnista;
            Giorni[j].Note:=GiorniOld[j].Note;
            //...e ricalcolo i totali (perché magari ho richiamato la stampa dal tabellone di pianificazione (A058UGrigliaPianif))
            AggiornaTotaleTurni(Vista[i],j,False);
          end;
        end;
    end;
  //Ricalcolo i totali del debito di ogni dipendente nel periodo complessivo
  with A058FPianifTurniDtm1 do
    for i:=0 to Vista.Count - 1 do
      DebitoDipendente(Vista[i],0,Trunc(DataFine - DataInizio));
end;

procedure TA058FPianifTurni.MyOnAddReports(Sender: TObject);
begin
  {Dalla versione 5.06 il componente TCompositeRecord è necessario settare
  manualmente la proprietà "ParentComposite" del singolo report}
  A058FTabellone.QRep.ParentComposite:=MyCompRep;
  (Sender as TQRCompositeReport).Reports.Add(A058FTabellone.QRep);
  if A058FStampaRiepTimb <> nil then
  begin
    A058FStampaRiepTimb.QRRiepTimb.ParentComposite:=MyCompRep;
    (Sender as TQRCompositeReport).Reports.Add(A058FStampaRiepTimb.QRRiepTimb);
  end;
  if A058FStampaRiepNote <> nil then
  begin
    A058FStampaRiepNote.QRRiepNote.ParentComposite:=MyCompRep;
    (Sender as TQRCompositeReport).Reports.Add(A058FStampaRiepNote.QRRiepNote);
  end;
end;

end.
