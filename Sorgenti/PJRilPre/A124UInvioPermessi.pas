unit A124UInvioPermessi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DBCtrls, C004UParamForm,
  A000USessione, A000UInterfaccia, Oracle, OracleData, StrUtils,
  xmldom, XMLIntf, msxmldom, XMLDoc, Vcl.Grids, Vcl.DBGrids, Vcl.Menus, Vcl.Mask,
  A000UMessaggi, A003UDataLavoroBis, A083UMsgElaborazioni, C180FunzioniGenerali, Data.DB;

  type
   TDModalita = (PermSindacali=1, //Permessi sindacali
                 PermFP           //Permessi per funzioni pubbliche elettive
                 //, AspFP        //Aspettative per funzioni pubbliche elettive (DA COMPLETARE)
                 );

type
  TA124FInvioPermessi = class(TForm)
    Panel3: TPanel;
    btnChiudi: TBitBtn;
    Panel2: TPanel;
    dgrdNoGEDAP: TDBGrid;
    pmnNoGEDAP: TPopupMenu;
    pmiImpostaPermessiVisInviati: TMenuItem;
    pmiImpostaPermessoSelInviato: TMenuItem;
    lblDataDa: TLabel;
    edtDataDa: TMaskEdit;
    btnDataDa: TButton;
    lblDataA: TLabel;
    edtDataA: TMaskEdit;
    btnDataA: TButton;
    lblSindacato: TLabel;
    cmbSindacato: TDBLookupComboBox;
    lblOrganismo: TLabel;
    cmbOrganismo: TDBLookupComboBox;
    btnEsegui: TBitBtn;
    btnAnomalie: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pmiImpostaTuttiPermessiInviatiClick(Sender: TObject);
    procedure pmnNoGEDAPPopup(Sender: TObject);
    procedure pmiImpostaPermessoSelInviatoClick(Sender: TObject);
    procedure edtDataDaExit(Sender: TObject);
    procedure edtDataAExit(Sender: TObject);
    procedure btnDataDaClick(Sender: TObject);
    procedure btnDataAClick(Sender: TObject);
    procedure cmbSindacatoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cmbSindacatoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cmbSindacatoCloseUp(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure edtDataAChange(Sender: TObject);
    procedure edtDataDaChange(Sender: TObject);
  private
    { Private declarations }
    AccessoSolaLettura:Boolean;
    Modalita: TDModalita;
    procedure AbilitaComponenti;
    procedure AggiornaGriglia;
  public
    { Public declarations }
  end;

var
  A124FInvioPermessi: TA124FInvioPermessi;

procedure OpenA124InvioPermessi(SolaLettura:Boolean);
procedure OpenA124InvioPFP(SolaLettura:Boolean);

implementation

{$R *.dfm}

uses A124UPermessiSindacaliDtM;

procedure OpenA124InvioPFP(SolaLettura:Boolean);
begin
  A124FInvioPermessi:=TA124FInvioPermessi.Create(nil);
  A124FInvioPermessi.Modalita:=PermFP;
  with A124FInvioPermessi do
  try
    AccessoSolaLettura:=SolaLettura;
    ShowModal;
  finally
    Free;
  end;
end;

procedure OpenA124InvioPermessi(SolaLettura:Boolean);
begin
  A124FInvioPermessi:=TA124FInvioPermessi.Create(nil);
  A124FInvioPermessi.Modalita:=PermSindacali;
  with A124FInvioPermessi do
  try
    AccessoSolaLettura:=SolaLettura;
    ShowModal;
  finally
    Free;
  end;
end;

procedure TA124FInvioPermessi.FormShow(Sender: TObject);
begin
  lblSindacato.Visible:=Modalita = PermSindacali;
  cmbSindacato.Visible:=Modalita = PermSindacali;
  lblOrganismo.Visible:=Modalita = PermSindacali;
  cmbOrganismo.Visible:=Modalita = PermSindacali;

  if Modalita = PermSindacali then
    dgrdNoGEDAP.PopupMenu:=pmnNoGEDAP
  else dgrdNoGEDAP.PopupMenu:=nil;

  edtDataDa.Text:=DateToStr(EncodeDate(1900,1,1));
  edtDataA.Text:=DateToStr(EncodeDate(3999,12,31));

  if Modalita = PermSindacali then
  begin
    cmbSindacato.ListSource:=A124FPermessiSindacaliDtM.A124MW.dsrT240NoGEDAP;
    cmbOrganismo.ListSource:=A124FPermessiSindacaliDtM.A124MW.dsrT245NoGEDAP;
    dgrdNoGEDAP.DataSource:=A124FPermessiSindacaliDtM.A124MW.dsrT248NoGEDAP;
    A124FPermessiSindacaliDtM.A124MW.selT240NoGEDAP.Open;
    A124FPermessiSindacaliDtM.A124MW.selT245NoGEDAP.Open;
    Self.Caption:='<A124> Invio permessi sindacali tramite WebService';
  end
  else if Modalita = PermFP then
  begin
    dgrdNoGEDAP.DataSource:=A124FPermessiSindacaliDtM.A124MW.dsrT040PFP;
    A124FPermessiSindacaliDtM.A124MW.selT040PFP.Open;
    Self.Caption:='<A124> Invio permessi per funzioni pubbliche elettive tramite WebService';
  end;

  AggiornaGriglia;
  AbilitaComponenti;
end;

procedure TA124FInvioPermessi.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  A124FPermessiSindacaliDtM.A124MW.selT248.Refresh;//Potrei aver cambiato il flag Inserito_Gedap
end;

procedure TA124FInvioPermessi.AbilitaComponenti;
begin
  btnEsegui.Enabled:=not AccessoSolaLettura and (Parametri.CampiRiferimento.C40_InvioGedap = 'S') and (dgrdNoGEDAP.DataSource.DataSet.RecordCount > 0);
end;

procedure TA124FInvioPermessi.edtDataDaChange(Sender: TObject);
begin
  if (Sender as TMaskEdit).Text = '  /  /    ' then
    (Sender as TMaskEdit).Text:=DateToStr(EncodeDate(1900,1,1));
end;

procedure TA124FInvioPermessi.edtDataDaExit(Sender: TObject);
var DataI:TDateTime;
begin
  try
    DataI:=StrToDate((Sender as TMaskEdit).Text);
    AggiornaGriglia;
    AbilitaComponenti;
  except
    (Sender as TMaskEdit).SetFocus;
    raise exception.create(A000MSG_ERR_DATA_VALIDA);
  end;
end;

procedure TA124FInvioPermessi.btnDataDaClick(Sender: TObject);
begin
  edtDataDa.Text:=FormatDateTime('dd/mm/yyyy',DataOut(StrToDate(edtDataDa.Text),'Dalla data','G'));
  AggiornaGriglia;
  AbilitaComponenti;
end;

procedure TA124FInvioPermessi.edtDataAChange(Sender: TObject);
begin
  if (Sender as TMaskEdit).Text = '  /  /    ' then
    (Sender as TMaskEdit).Text:=DateToStr(EncodeDate(3999,12,31));
end;

procedure TA124FInvioPermessi.edtDataAExit(Sender: TObject);
var DataF:TDateTime;
begin
  try
    DataF:=StrToDate((Sender as TMaskEdit).Text);
    AggiornaGriglia;
    AbilitaComponenti;
  except
    (Sender as TMaskEdit).SetFocus;
    raise exception.create(A000MSG_ERR_DATA_VALIDA);
  end;
end;

procedure TA124FInvioPermessi.btnDataAClick(Sender: TObject);
begin
  edtDataA.Text:=FormatDateTime('dd/mm/yyyy',DataOut(StrToDate(edtDataA.Text),'Alla data','G'));
  AggiornaGriglia;
  AbilitaComponenti;
end;

procedure TA124FInvioPermessi.cmbSindacatoCloseUp(Sender: TObject);
begin
  AggiornaGriglia;
  AbilitaComponenti;
end;

procedure TA124FInvioPermessi.cmbSindacatoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Delete then
    (Sender as TDBLookupComboBox).KeyValue:=null;
end;

procedure TA124FInvioPermessi.cmbSindacatoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  AggiornaGriglia;
  AbilitaComponenti;
end;

procedure TA124FInvioPermessi.AggiornaGriglia;
begin
  if Modalita = PermSindacali then
    A124FPermessiSindacaliDtM.A124MW.RecuperaNoGEDAP(StrToDate(edtDataDa.Text),
                                                     StrToDate(edtDataA.Text),
                                                     Trim(cmbOrganismo.Text),
                                                     Trim(cmbSindacato.Text))
  else if Modalita = PermFP then
    A124FPermessiSindacaliDtM.A124MW.RecuperaPFP(StrToDate(edtDataDa.Text),
                                                     StrToDate(edtDataA.Text));
end;

procedure TA124FInvioPermessi.pmnNoGEDAPPopup(Sender: TObject);
begin
  pmiImpostaPermessoSelInviato.Enabled:=not AccessoSolaLettura and (dgrdNoGEDAP.DataSource.DataSet.RecordCount > 0);
  pmiImpostaPermessiVisInviati.Enabled:=not AccessoSolaLettura and (dgrdNoGEDAP.DataSource.DataSet.RecordCount > 0);
end;

procedure TA124FInvioPermessi.pmiImpostaPermessoSelInviatoClick(Sender: TObject);
begin
  A124FPermessiSindacaliDtM.A124MW.ImpostaPermessoSelInviato;
end;

procedure TA124FInvioPermessi.pmiImpostaTuttiPermessiInviatiClick(Sender: TObject);
begin
  A124FPermessiSindacaliDtM.A124MW.ImpostaTuttiPermessiInviati;
end;

procedure TA124FInvioPermessi.btnEseguiClick(Sender: TObject);
begin
  btnAnomalie.Enabled:=False;
  with A124FPermessiSindacaliDtM.A124MW do
  begin
    ControlliGeneraXmlGEDAP;
    dgrdNoGEDAP.Datasource.DataSet.First;
    Screen.Cursor:=crHourGlass;
    try
      RegistraMsg.IniziaMessaggio('A124');
      try
        WSGEDAP(TOracleDataSet(dgrdNoGEDAP.Datasource.DataSet),True);
      finally
        SessioneOracle.Commit;
        dgrdNoGEDAP.Datasource.DataSet.Refresh;
        dgrdNoGEDAP.Datasource.DataSet.First;
        Screen.Cursor:=crDefault;
      end;
    finally //gestito in caso di abort in WSGEDAP
      btnAnomalie.Enabled:=RegistraMsg.ContieneTipoA;
      if RegistraMsg.ContieneTipoA then
      begin
        if R180MessageBox(A000MSG_DLG_ELAB_ANOMALIE_VIS,DOMANDA) = mrYes then
          btnAnomalieClick(nil);
      end
      else
        R180MessageBox(A000MSG_MSG_ELABORAZIONE_TERMINATA,INFORMA);
    end;
  end;
end;

procedure TA124FInvioPermessi.btnAnomalieClick(Sender: TObject);
begin
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A124','');
end;

end.
