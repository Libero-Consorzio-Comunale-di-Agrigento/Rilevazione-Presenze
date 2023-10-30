unit P289UPensioneUnjspf;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, Menus, Buttons, StrUtils, ToolbarFiglio,
  ExtCtrls, ComCtrls, StdCtrls, DBCtrls,  Mask, ImgList, ToolWin, ActnList,
  C180FunzioniGenerali, C700USelezioneAnagrafe, A000UCostanti, A000USessione, A000UInterfaccia, A002UInterfacciaSt,
  C001UFiltroTabelle, C001UFiltroTabelleDtM, C001UScegliCampi,
  C005UDatiAnagrafici, Grids, DBGrids, OracleData, Db, SelAnagrafe, Variants, C013UCheckList,
  Spin, Oracle, Printers, A003UDataLavoroBis, System.Actions;

type
  TElencoProg = record
    Prog:String;
    Colorato:Boolean;
  end;

  TP289FPensioneUnjspf = class(TR001FGestTab)
    pnlTestata: TPanel;
    dchkChiuso: TDBCheckBox;
    frmSelAnagrafe: TfrmSelAnagrafe;
    rgpTipoDati: TRadioGroup;
    mnuCopia: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    MenuItem2: TMenuItem;
    Copia2: TMenuItem;
    CopiaInExcel: TMenuItem;
    pgcPrincipale: TPageControl;
    TabStaffMember: TTabSheet;
    TabLanguage: TTabSheet;
    TabPartTime: TTabSheet;
    TabDutyStation: TTabSheet;
    TabSalary: TTabSheet;
    dgrdStaffMember: TDBGrid;
    dgrdLanguage: TDBGrid;
    dgrdParttime: TDBGrid;
    dgrdDutyStation: TDBGrid;
    dgrdSalary: TDBGrid;
    tabContract: TTabSheet;
    tabSeparation: TTabSheet;
    tabDependent: TTabSheet;
    tabChild: TTabSheet;
    tabLeaveWithoutPay: TTabSheet;
    tabAddress: TTabSheet;
    tabPhone: TTabSheet;
    tabEmail: TTabSheet;
    lblDataFinePeriodo: TLabel;
    dedtdataFinePeriodo: TDBEdit;
    lblDataChiusura: TLabel;
    dedtDataChiusura: TDBEdit;
    dedtIdINPDAPMM: TDBEdit;
    lblIdINPDAPMM: TLabel;
    frmToolbarFiglio: TfrmToolbarFiglio;
    dgrdContract: TDBGrid;
    dgrdSeparation: TDBGrid;
    dgrdDependent: TDBGrid;
    dgrdChild: TDBGrid;
    dgrdLeaveWithoutPay: TDBGrid;
    dgrdAddress: TDBGrid;
    dgrdPhone: TDBGrid;
    dgrdEMail: TDBGrid;
    tabPayment: TTabSheet;
    dgrdPayment: TDBGrid;
    lblDataElaborazione: TLabel;
    dedtDataElaborazione: TDBEdit;
    dedtDataEsportazione: TDBEdit;
    lblDataEsportazione: TLabel;
    procedure CopiaInExcelClick(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure Deselezionatutto1Click(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rgpTipoDatiClick(Sender: TObject);
    procedure pgcPrincipaleChange(Sender: TObject);
    procedure dgrdLanguageDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DButtonStateChange(Sender: TObject);
    procedure pgcPrincipaleChanging(Sender: TObject; var AllowChange: Boolean);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure Stampa1Click(Sender: TObject);
  private
    { Private declarations }
    ElencoProg:array of TElencoProg;
    TipoFlusso:String;
    procedure CaricaElencoProg;
    procedure CambiaProgressivo;
  public
    { Public declarations }
    procedure Aggiorna;
    procedure Differenze;
    procedure AbilitazioniComponenti;
  end;

var
  P289FPensioneUnjspf: TP289FPensioneUnjspf;

procedure OpenP289PensioneUnjspf(Prog:LongInt);

implementation

uses P289UPensioneUnjspfDtM;

{$R *.DFM}

procedure OpenP289PensioneUnjspf(Prog:LongInt);
var sTipo:String;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  sTipo:=IfThen(Parametri.Applicazione = 'STAGIU','HR','FIN');
  case A000GetInibizioni('Funzione','OpenP289PensioneUnjspf' + sTipo) of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Screen.Cursor:=crHourglass;
  Application.CreateForm(TP289FPensioneUnjspf, P289FPensioneUnjspf);
  C700Progressivo:=Prog;
  Application.CreateForm(TP289FPensioneUnjspfDtM, P289FPensioneUnjspfDtM);
  try
    Screen.Cursor:=crDefault;
    P289FPensioneUnjspf.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    P289FPensioneUnjspf.Free;
    P289FPensioneUnjspfDtM.Free;
  end;
end;

procedure TP289FPensioneUnjspf.FormShow(Sender: TObject);
begin
  inherited;
  P289FPensioneUnjspf.WindowState:=wsMaximized;
  R001LinkC700:=False;
//  Parametri.Applicazione:='PAGHE'; //PER TEST
  TipoFlusso:=IfThen(Parametri.Applicazione = 'STAGIU','HR','FIN');
  with P289FPensioneUnjspfDtM do
  begin
    selU100.AfterScroll:=nil;
    selU100.Close;
    selU100.SetVariable('TipoFlusso',TipoFlusso);
    selU100.Open;
    selU100.Last;
    selU100.AfterScroll:=selU100AfterScroll;
  end;
  rgpTipoDati.ItemIndex:=0;
  TabStaffMember.TabVisible:=TipoFlusso = 'HR';
  TabLanguage.TabVisible:=TipoFlusso = 'HR';
  TabPartTime.TabVisible:=TipoFlusso = 'HR';
  TabDutyStation.TabVisible:=TipoFlusso = 'HR';
  TabSalary.TabVisible:=TipoFlusso = 'HR';
  TabContract.TabVisible:=TipoFlusso = 'HR';
  TabSeparation.TabVisible:=TipoFlusso = 'HR';
  TabDependent.TabVisible:=TipoFlusso = 'HR';
  TabChild.TabVisible:=TipoFlusso = 'HR';
  TabLeaveWithoutPay.TabVisible:=TipoFlusso = 'HR';
  TabAddress.TabVisible:=TipoFlusso = 'HR';
  TabPhone.TabVisible:=TipoFlusso = 'HR';
  TabEmail.TabVisible:=TipoFlusso = 'HR';
  tabPayment.TabVisible:=TipoFlusso = 'FIN';
  if TipoFlusso = 'HR' then
    pgcPrincipale.ActivePage:=TabStaffMember
  else
    pgcPrincipale.ActivePage:=TabPayment;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase + ',T430UN_EXTRACT,DATANAS,SESSO,T430COD_UNJSPF,T430UN_ENTRY_DATE,T430NATIONALITY,T430CIVIL_STATUS,T430D_UN_REAPP';
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle, StatusBar,2,True);
  pgcPrincipaleChange(nil);
  if TipoFlusso = 'HR' then
  begin
    frmToolbarFiglio.TFDButton:=P289FPensioneUnjspfDtM.dsrU120;
    frmToolbarFiglio.TFDBGrid:=dgrdStaffMember;
  end
  else
  begin
    frmToolbarFiglio.TFDButton:=P289FPensioneUnjspfDtM.dsrU190;
    frmToolbarFiglio.TFDBGrid:=dgrdPayment;
  end;
  frmToolbarFiglio.RefreshDopoPost:=True;
  SetLength(frmToolbarFiglio.lstLock,5);
  frmToolbarFiglio.lstLock[0]:=Panel1;
  frmToolbarFiglio.lstLock[1]:=File1;
  frmToolbarFiglio.lstLock[2]:=Strumenti1;
  frmToolbarFiglio.lstLock[3]:=frmSelAnagrafe;
  frmToolbarFiglio.lstLock[4]:=pnlTestata;
  frmToolbarFiglio.AbilitaAzioniTF(nil);
  //Abilitazioni di base
  actInserisci.Visible:=False;
  actModifica.Visible:=False;
  actCancella.Visible:=False;
  actConferma.Visible:=False;
  actAnnulla.Visible:=False;
end;

procedure TP289FPensioneUnjspf.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  inherited;
  try
    C700DataLavoro:=StrToDate(dedtDataFinePeriodo.Text);
  except
    C700DataLavoro:=Parametri.DataLavoro;
  end;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TP289FPensioneUnjspf.pgcPrincipaleChange(Sender: TObject);
var OldID:String;
begin
  inherited;
  OldID:='';
  if frmToolbarFiglio.TFDButton <> nil then
    OldID:=TOracleDataSet(frmToolbarFiglio.TFDButton.DataSet).FieldByName('EMPLOYEE_NUMBER').AsString;
  case pgcPrincipale.ActivePageIndex of
    0: begin
         if rgpTipoDati.ItemIndex = 2 then
           frmToolbarFiglio.TFDButton:=P289FPensioneUnjspfDtM.dsrU120Diff
         else
           frmToolbarFiglio.TFDButton:=P289FPensioneUnjspfDtM.dsrU120;
         dgrdStaffMember.DataSource:=frmToolbarFiglio.TFDButton;
         frmToolbarFiglio.TFDBGrid:=dgrdStaffMember;
       end;
    1: begin
         if rgpTipoDati.ItemIndex = 2 then
           frmToolbarFiglio.TFDButton:=P289FPensioneUnjspfDtM.dsrU125Diff
         else
           frmToolbarFiglio.TFDButton:=P289FPensioneUnjspfDtM.dsrU125;
         dgrdLanguage.DataSource:=frmToolbarFiglio.TFDButton;
         frmToolbarFiglio.TFDBGrid:=dgrdLanguage;
       end;
    2: begin
         if rgpTipoDati.ItemIndex = 2 then
           frmToolbarFiglio.TFDButton:=P289FPensioneUnjspfDtM.dsrU130Diff
         else
           frmToolbarFiglio.TFDButton:=P289FPensioneUnjspfDtM.dsrU130;
         dgrdPartTime.DataSource:=frmToolbarFiglio.TFDButton;
         frmToolbarFiglio.TFDBGrid:=dgrdParttime;
       end;
    3: begin
         if rgpTipoDati.ItemIndex = 2 then
           frmToolbarFiglio.TFDButton:=P289FPensioneUnjspfDtM.dsrU135Diff
         else
           frmToolbarFiglio.TFDButton:=P289FPensioneUnjspfDtM.dsrU135;
         dgrdDutyStation.DataSource:=frmToolbarFiglio.TFDButton;
         frmToolbarFiglio.TFDBGrid:=dgrdDutyStation;
       end;
    4: begin
         if rgpTipoDati.ItemIndex = 2 then
           frmToolbarFiglio.TFDButton:=P289FPensioneUnjspfDtM.dsrU140Diff
         else
           frmToolbarFiglio.TFDButton:=P289FPensioneUnjspfDtM.dsrU140;
         dgrdSalary.DataSource:=frmToolbarFiglio.TFDButton;
         frmToolbarFiglio.TFDBGrid:=dgrdSalary;
       end;
    5: begin
         if rgpTipoDati.ItemIndex = 2 then
           frmToolbarFiglio.TFDButton:=P289FPensioneUnjspfDtM.dsrU145Diff
         else
           frmToolbarFiglio.TFDButton:=P289FPensioneUnjspfDtM.dsrU145;
         dgrdContract.DataSource:=frmToolbarFiglio.TFDButton;
         frmToolbarFiglio.TFDBGrid:=dgrdContract;
       end;
    6: begin
         if rgpTipoDati.ItemIndex = 2 then
           frmToolbarFiglio.TFDButton:=P289FPensioneUnjspfDtM.dsrU150Diff
         else
           frmToolbarFiglio.TFDButton:=P289FPensioneUnjspfDtM.dsrU150;
         dgrdSeparation.DataSource:=frmToolbarFiglio.TFDButton;
         frmToolbarFiglio.TFDBGrid:=dgrdSeparation;
       end;
    7: begin
         if rgpTipoDati.ItemIndex = 2 then
           frmToolbarFiglio.TFDButton:=P289FPensioneUnjspfDtM.dsrU155Diff
         else
           frmToolbarFiglio.TFDButton:=P289FPensioneUnjspfDtM.dsrU155;
         dgrdDependent.DataSource:=frmToolbarFiglio.TFDButton;
         frmToolbarFiglio.TFDBGrid:=dgrdDependent;
       end;
    8: begin
         if rgpTipoDati.ItemIndex = 2 then
           frmToolbarFiglio.TFDButton:=P289FPensioneUnjspfDtM.dsrU160Diff
         else
           frmToolbarFiglio.TFDButton:=P289FPensioneUnjspfDtM.dsrU160;
         dgrdChild.DataSource:=frmToolbarFiglio.TFDButton;
         frmToolbarFiglio.TFDBGrid:=dgrdChild;
       end;
    9: begin
         if rgpTipoDati.ItemIndex = 2 then
           frmToolbarFiglio.TFDButton:=P289FPensioneUnjspfDtM.dsrU165Diff
         else
           frmToolbarFiglio.TFDButton:=P289FPensioneUnjspfDtM.dsrU165;
         dgrdLeaveWithoutPay.DataSource:=frmToolbarFiglio.TFDButton;
         frmToolbarFiglio.TFDBGrid:=dgrdLeaveWithoutPay;
       end;
   10: begin
         if rgpTipoDati.ItemIndex = 2 then
           frmToolbarFiglio.TFDButton:=P289FPensioneUnjspfDtM.dsrU170Diff
         else
           frmToolbarFiglio.TFDButton:=P289FPensioneUnjspfDtM.dsrU170;
         dgrdAddress.DataSource:=frmToolbarFiglio.TFDButton;
         frmToolbarFiglio.TFDBGrid:=dgrdAddress;
       end;
   11: begin
         if rgpTipoDati.ItemIndex = 2 then
           frmToolbarFiglio.TFDButton:=P289FPensioneUnjspfDtM.dsrU175Diff
         else
           frmToolbarFiglio.TFDButton:=P289FPensioneUnjspfDtM.dsrU175;
         dgrdPhone.DataSource:=frmToolbarFiglio.TFDButton;
         frmToolbarFiglio.TFDBGrid:=dgrdPhone;
       end;
   12: begin
         if rgpTipoDati.ItemIndex = 2 then
           frmToolbarFiglio.TFDButton:=P289FPensioneUnjspfDtM.dsrU180Diff
         else
           frmToolbarFiglio.TFDButton:=P289FPensioneUnjspfDtM.dsrU180;
         dgrdEmail.DataSource:=frmToolbarFiglio.TFDButton;
         frmToolbarFiglio.TFDBGrid:=dgrdEmail;
       end;
   13: begin
         if rgpTipoDati.ItemIndex = 2 then
           frmToolbarFiglio.TFDButton:=P289FPensioneUnjspfDtM.dsrU190Diff
         else
           frmToolbarFiglio.TFDButton:=P289FPensioneUnjspfDtM.dsrU190;
         dgrdPayment.DataSource:=frmToolbarFiglio.TFDButton;
         frmToolbarFiglio.TFDBGrid:=dgrdPayment;
       end;
  end;
  if rgpTipoDati.ItemIndex <> 2 then
    Aggiorna
  else
    Differenze;
  if TOracleDataSet(frmToolbarFiglio.TFDButton.DataSet).Active then
    TOracleDataSet(frmToolbarFiglio.TFDButton.DataSet).SearchRecord('EMPLOYEE_NUMBER',OldID,[srFromBeginning]);
end;

procedure TP289FPensioneUnjspf.pgcPrincipaleChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  inherited;
  AllowChange:=DButton.State = dsBrowse;
end;

procedure TP289FPensioneUnjspf.CambiaProgressivo;
begin
  C700Progressivo:=C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
  Aggiorna;
end;

procedure TP289FPensioneUnjspf.FormDestroy(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TP289FPensioneUnjspf.AbilitazioniComponenti;
var Abilita: Boolean;
begin
  Abilita:=(not SolaLettura) and (rgpTipoDati.ItemIndex = 0) and (P289FPensioneUnjspfDtM.selU100.FieldByName('CHIUSO').AsString <> 'S');
  frmToolbarFiglio.actTFInserisci.Enabled:=Abilita;
  frmToolbarFiglio.actTFModifica.Enabled:=Abilita;
  frmToolbarFiglio.actTFCancella.Enabled:=Abilita;
  frmSelAnagrafe.Visible:=rgpTipoDati.ItemIndex = 0;
end;

procedure TP289FPensioneUnjspf.rgpTipoDatiClick(Sender: TObject);
begin
  pgcPrincipaleChange(nil);
end;

procedure TP289FPensioneUnjspf.Aggiorna;
begin
  if frmToolbarFiglio.TFDButton = nil then
    Exit;
  TOracleDataSet(frmToolbarFiglio.TFDButton.DataSet).Close;
  if rgpTipoDati.ItemIndex = 0 then
    TOracleDataSet(frmToolbarFiglio.TFDButton.DataSet).SetVariable('PROG',' AND T.PROGRESSIVO = ' + IntToStr(C700Progressivo))
  else
    TOracleDataSet(frmToolbarFiglio.TFDButton.DataSet).SetVariable('PROG',' ');
  TOracleDataSet(frmToolbarFiglio.TFDButton.DataSet).SetVariable('ID',P289FPensioneUnjspfDtM.selU100.FieldByName('ID_UNJSPF').AsInteger);
  TOracleDataSet(frmToolbarFiglio.TFDButton.DataSet).Open;
  AbilitazioniComponenti;
  if rgpTipoDati.ItemIndex = 1 then
    CaricaElencoProg;
end;

procedure TP289FPensioneUnjspf.Differenze;
begin
  with P289FPensioneUnjspfDtM do
  begin
    TOracleDataSet(frmToolbarFiglio.TFDButton.DataSet).Close;
    selDataPrec.SetVariable('Tipo',TipoFlusso);
    selDataPrec.SetVariable('DataRif',selU100.FieldByName('DATA_FINE_PERIODO').AsDateTime);
    selDataPrec.Execute;
    if Trim(selDataPrec.FieldAsString(0)) <> '' then
    begin
      TOracleDataSet(frmToolbarFiglio.TFDButton.DataSet).SetVariable('Tipo',TipoFlusso);
      TOracleDataSet(frmToolbarFiglio.TFDButton.DataSet).SetVariable('DataCorr',selU100.FieldByName('DATA_FINE_PERIODO').AsDateTime);
      TOracleDataSet(frmToolbarFiglio.TFDButton.DataSet).SetVariable('DataPrec',selDataPrec.FieldAsDate(0));
      TOracleDataSet(frmToolbarFiglio.TFDButton.DataSet).Open;
    end;
  end;
  AbilitazioniComponenti;
  CaricaElencoProg;
end;

procedure TP289FPensioneUnjspf.Selezionatutto1Click(Sender: TObject);
begin
  case pgcPrincipale.ActivePageIndex of
    0: R180DBGridSelezionaRighe(dgrdStaffMember,'S');
    1: R180DBGridSelezionaRighe(dgrdLanguage,'S');
    2: R180DBGridSelezionaRighe(dgrdPartTime,'S');
    3: R180DBGridSelezionaRighe(dgrdDutyStation,'S');
    4: R180DBGridSelezionaRighe(dgrdSalary,'S');
    5: R180DBGridSelezionaRighe(dgrdContract,'S');
    6: R180DBGridSelezionaRighe(dgrdSeparation,'S');
    7: R180DBGridSelezionaRighe(dgrdDependent,'S');
    8: R180DBGridSelezionaRighe(dgrdChild,'S');
    9: R180DBGridSelezionaRighe(dgrdLeaveWithoutPay,'S');
   10: R180DBGridSelezionaRighe(dgrdAddress,'S');
   11: R180DBGridSelezionaRighe(dgrdPhone,'S');
   12: R180DBGridSelezionaRighe(dgrdEmail,'S');
   13: R180DBGridSelezionaRighe(dgrdPayment,'S');
  end;
end;

procedure TP289FPensioneUnjspf.Stampa1Click(Sender: TObject);
begin
  QueryStampa.Clear;
  QueryStampa.Add('SELECT T1.* FROM U100_UNJSPF_TESTATE T1');
  NomiCampiR001.Clear;
  NomiCampiR001.Add('T1.TIPO_FLUSSO');
  NomiCampiR001.Add('T1.DATA_FINE_PERIODO');
  NomiCampiR001.Add('T1.ID_UNJSPF');
  NomiCampiR001.Add('T1.DATA_ESPORTAZIONE');
  NomiCampiR001.Add('T1.CHIUSO');
  NomiCampiR001.Add('T1.DATA_CHIUSURA');
  inherited;
end;

procedure TP289FPensioneUnjspf.DButtonStateChange(Sender: TObject);
begin
  inherited;
  pnlTestata.Enabled:=DButton.State = dsBrowse;
end;

procedure TP289FPensioneUnjspf.Deselezionatutto1Click(Sender: TObject);
begin
  case pgcPrincipale.ActivePageIndex of
    0: R180DBGridSelezionaRighe(dgrdStaffMember,'N');
    1: R180DBGridSelezionaRighe(dgrdLanguage,'N');
    2: R180DBGridSelezionaRighe(dgrdPartTime,'N');
    3: R180DBGridSelezionaRighe(dgrdDutyStation,'N');
    4: R180DBGridSelezionaRighe(dgrdSalary,'N');
    5: R180DBGridSelezionaRighe(dgrdContract,'N');
    6: R180DBGridSelezionaRighe(dgrdSeparation,'N');
    7: R180DBGridSelezionaRighe(dgrdDependent,'N');
    8: R180DBGridSelezionaRighe(dgrdChild,'N');
    9: R180DBGridSelezionaRighe(dgrdLeaveWithoutPay,'N');
   10: R180DBGridSelezionaRighe(dgrdAddress,'N');
   11: R180DBGridSelezionaRighe(dgrdPhone,'N');
   12: R180DBGridSelezionaRighe(dgrdEmail,'N');
   13: R180DBGridSelezionaRighe(dgrdPayment,'N');
  end;
end;

procedure TP289FPensioneUnjspf.dgrdLanguageDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var i:Integer;
begin
  inherited;
  if gdFixed in State then exit;
  //Ciclo su tabella
  for i:=0 to High(ElencoProg) do
    if (ElencoProg[i].Colorato) and
       (((rgpTipoDati.ItemIndex = 1) and (ElencoProg[i].Prog = TOracleDataSet(frmToolbarFiglio.TFDButton.DataSet).FieldByName('EMPLOYEE_NUMBER').AsString)) or
        ((rgpTipoDati.ItemIndex = 2) and (ElencoProg[i].Prog = TOracleDataSet(frmToolbarFiglio.TFDButton.DataSet).FieldByName('DATA').AsString))) then
    begin
      if gdSelected in State then
      begin
        TDBGrid(Sender).Canvas.Brush.Color:=clHighLight;
        TDBGrid(Sender).Canvas.Font.Color:=clWhite;
      end
      else
      begin
        TDBGrid(Sender).Canvas.Brush.Color:=$00FFFF80;
        TDBGrid(Sender).Canvas.Font.Color:=clWindowText;
      end;
      TDBGrid(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);
      Break;
    end;
end;

procedure TP289FPensioneUnjspf.Invertiselezione1Click(Sender: TObject);
begin
  case pgcPrincipale.ActivePageIndex of
    0: R180DBGridSelezionaRighe(dgrdStaffMember,'C');
    1: R180DBGridSelezionaRighe(dgrdLanguage,'C');
    2: R180DBGridSelezionaRighe(dgrdPartTime,'C');
    3: R180DBGridSelezionaRighe(dgrdDutyStation,'C');
    4: R180DBGridSelezionaRighe(dgrdSalary,'C');
    5: R180DBGridSelezionaRighe(dgrdContract,'C');
    6: R180DBGridSelezionaRighe(dgrdSeparation,'C');
    7: R180DBGridSelezionaRighe(dgrdDependent,'C');
    8: R180DBGridSelezionaRighe(dgrdChild,'C');
    9: R180DBGridSelezionaRighe(dgrdLeaveWithoutPay,'C');
   10: R180DBGridSelezionaRighe(dgrdAddress,'C');
   11: R180DBGridSelezionaRighe(dgrdPhone,'C');
   12: R180DBGridSelezionaRighe(dgrdEmail,'C');
   13: R180DBGridSelezionaRighe(dgrdPayment,'C');
  end;
end;

procedure TP289FPensioneUnjspf.CopiaInExcelClick(Sender: TObject);
begin
  case pgcPrincipale.ActivePageIndex of
    0: R180DBGridCopyToClipboard(dgrdStaffMember,Sender = CopiaInExcel);
    1: R180DBGridCopyToClipboard(dgrdLanguage,Sender = CopiaInExcel);
    2: R180DBGridCopyToClipboard(dgrdPartTime,Sender = CopiaInExcel);
    3: R180DBGridCopyToClipboard(dgrdDutyStation,Sender = CopiaInExcel);
    4: R180DBGridCopyToClipboard(dgrdSalary,Sender = CopiaInExcel);
    5: R180DBGridCopyToClipboard(dgrdContract,Sender = CopiaInExcel);
    6: R180DBGridCopyToClipboard(dgrdSeparation,Sender = CopiaInExcel);
    7: R180DBGridCopyToClipboard(dgrdDependent,Sender = CopiaInExcel);
    8: R180DBGridCopyToClipboard(dgrdChild,Sender = CopiaInExcel);
    9: R180DBGridCopyToClipboard(dgrdLeaveWithoutPay,Sender = CopiaInExcel);
   10: R180DBGridCopyToClipboard(dgrdAddress,Sender = CopiaInExcel);
   11: R180DBGridCopyToClipboard(dgrdPhone,Sender = CopiaInExcel);
   12: R180DBGridCopyToClipboard(dgrdEmail,Sender = CopiaInExcel);
   13: R180DBGridCopyToClipboard(dgrdPayment,Sender = CopiaInExcel);
  end;
end;

procedure TP289FPensioneUnjspf.CaricaElencoProg;
var i:integer;
    Puntatore:TBookmark;
begin
  SetLength(ElencoProg,0);
  if not TOracleDataSet(frmToolbarFiglio.TFDButton.DataSet).Active then
    Exit;
  with TOracleDataSet(frmToolbarFiglio.TFDButton.DataSet) do
  begin
    DisableControls;
    Puntatore:=GetBookmark;
    First;
    i:=-1;
    while not Eof do
    begin
      if rgpTipoDati.ItemIndex = 2 then
      begin
        if Length(ElencoProg) = 0 then
        begin
          inc(i);
          SetLength(ElencoProg,i + 1);
          ElencoProg[i].Prog:=FieldByName('DATA').AsString;
          ElencoProg[i].Colorato:=False;
        end
        else if ElencoProg[i].Prog <> FieldByName('DATA').AsString then
        begin
          inc(i);
          SetLength(ElencoProg,i + 1);
          ElencoProg[i].Prog:=FieldByName('DATA').AsString;
          ElencoProg[i].Colorato:=not ElencoProg[i - 1].Colorato;
        end;
      end
      else
      begin
        if Length(ElencoProg) = 0 then
        begin
          inc(i);
          SetLength(ElencoProg,i + 1);
          ElencoProg[i].Prog:=FieldByName('EMPLOYEE_NUMBER').AsString;
          ElencoProg[i].Colorato:=False;
        end
        else if ElencoProg[i].Prog <> FieldByName('EMPLOYEE_NUMBER').AsString then
        begin
          inc(i);
          SetLength(ElencoProg,i + 1);
          ElencoProg[i].Prog:=FieldByName('EMPLOYEE_NUMBER').AsString;
          ElencoProg[i].Colorato:=not ElencoProg[i - 1].Colorato;
        end;
      end;
      Next;
    end;
    GotoBookmark(Puntatore);
    FreeBookmark(Puntatore);
    EnableControls;
  end;
end;

end.

