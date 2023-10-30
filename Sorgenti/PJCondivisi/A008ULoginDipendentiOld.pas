unit A008ULoginDipendentiOld;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, StdCtrls, DBCtrls, ExtCtrls, Menus, Buttons, ComCtrls,
  DBLookup, Mask, DB, Grids, DBGrids, A000UCostanti, A000USessione,A000UInterfaccia,
  C180FunzioniGenerali, ActnList, ImgList, ToolWin, OracleData, Variants;

type
  TA008FLoginDipendentiOld = class(TR001FGestTab)
    pnlDatiGenerali: TPanel;
    Label1: TLabel;
    DBText1: TDBText;
    dcmbAzienda: TDBLookupComboBox;
    pnlDatiDipendente: TPanel;
    Panel4: TPanel;
    dgrdLoginDipendente: TDBGrid;
    btnInserisciLogin: TBitBtn;
    cmbFiltroFunzioni: TComboBox;
    chkAssegnaPwd: TCheckBox;
    lblFiltroFunzioni: TLabel;
    BitBtn1: TBitBtn;
    procedure Chiudi1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnInserisciLoginClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Stampa1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Inserimento:Boolean;
    spvAzienda: String;
  end;

var
  A008FLoginDipendentiOld: TA008FLoginDipendentiOld;

implementation

uses A008UOperatoriDtM1, A008UProfili;

{$R *.DFM}

procedure TA008FLoginDipendentiOld.FormCreate(Sender: TObject);
begin
  inherited;
  Inserimento:=False;
end;

procedure TA008FLoginDipendentiOld.FormActivate(Sender: TObject);
{Stabilisco i collegamenti a DButton}
begin
  DButton.DataSet:=A008FOperatoriDtM1.QI060;
  inherited;
end;

procedure TA008FLoginDipendentiOld.FormShow(Sender: TObject);
begin
  with A008FOperatoriDtM1 do
  begin
    selI090.First;
    selI090.SearchRecord('AZIENDA',QI070.FieldByName('AZIENDA').AsString,[srFromBeginning]);
    dcmbAzienda.KeyValue:=selI090.FieldByName('AZIENDA').AsString;
    cmbFiltroFunzioni.ItemIndex:=0;
  end;
end;

procedure TA008FLoginDipendentiOld.Chiudi1Click(Sender: TObject);
begin
  Close;
end;

procedure TA008FLoginDipendentiOld.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DButton.DataSet:=nil;
  inherited;
end;

procedure TA008FLoginDipendentiOld.btnInserisciLoginClick(
  Sender: TObject);
var
  S: String;
  Chiave, NLogin: integer;
begin
  NLogin:=0;
  if chkAssegnaPwd.Checked then
    Chiave:=StrToInt(InputBox('Nuova password','Chiave numerica di generazione','12345678'));
  with A008FOperatoriDTM1 do
  begin
    if cmbFiltroFunzioni.Text = '' then
    begin
      R180MessageBox('Definire un filtro funzioni: nessun login inserito',ERRORE);
      exit;
    end;
    selI090.SearchRecord('AZIENDA',spvAzienda,[srFromBeginning]);
    //Apertura del database indicato dall'Azienda
    with DbIris008B do
      if (not Connected) or
         (UpperCase(LogonUserName) <> UpperCase(selI090.FieldByName('UTENTE').AsString)) then
      begin
        Logoff;
        LogonDataBase:=Parametri.Database;
        LogonUserName:=selI090.FieldByName('UTENTE').AsString;
        LogonPassword:=R180Decripta(selI090.FieldByName('PAROLACHIAVE').AsString,21041974);
        Logon;
      end;
    selT030.Close;
    selT030.SetVariable('AZIENDA',spvAzienda);
    selT030.Open;
    while not selT030.Eof do
    begin
      insI060.SetVariable('Azienda',spvAzienda);
      insI060.SetVariable('Matricola',selT030.FieldByName('MATRICOLA').AsString);
      insI060.SetVariable('NomeUtente',selT030.FieldByName('MATRICOLA').AsString);
      insI060.SetVariable('FiltroFunzioni',cmbFiltroFunzioni.Text);
      S:='';
      if chkAssegnaPwd.Checked then
        S:=R180Cripta(selT030.FieldByName('MATRICOLA').AsString,Chiave);
      insI060.SetVariable('Password',S);
      try
        insI060.Execute;
        inc(NLogin);
      except
      end;
      selT030.Next;
    end;
    insI060.Session.Commit;
  end;
  R180MessageBox('Elaborazione terminata ' + IntToStr(NLogin) + ' login inseriti',INFORMA);
end;

procedure TA008FLoginDipendentiOld.Stampa1Click(Sender: TObject);
begin
  QueryStampa.Clear;
  QueryStampa.Add('SELECT I060.* FROM I060_LOGIN_DIPENDENTE I060 ORDER BY AZIENDA,MATRICOLA');
  NomiCampiR001.Clear;
  NomiCampiR001.Add('I060.AZIENDA');
  NomiCampiR001.Add('I060.MATRICOLA');
  NomiCampiR001.Add('I060.NOME_UTENTE');
  NomiCampiR001.Add('I060.PASSWORD');
  NomiCampiR001.Add('I060.FILTRO_FUNZIONI');
  NomiCampiR001.Add('I060.FILTRO_ANAGRAFE');
  inherited;
end;

end.
