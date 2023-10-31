unit A204UModelliCertificazione;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R001UGESTTAB, System.Actions, Vcl.ActnList, System.ImageList, Vcl.ImgList, Data.DB, Vcl.Menus, Vcl.ComCtrls, Vcl.ToolWin, ToolbarFiglio, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls,
  A204UModelliCertificazioneDtM, C012UVisualizzaTesto, C600USelAnagrafe,
  A000USessione, A000UInterfaccia, A000UMessaggi, Vcl.StdCtrls;

type
  TA204FModelliCertificazione = class(TR001FGestTab)
    pnlMasterModelli: TPanel;
    dgrdModelli: TDBGrid;
    pnlCategorie: TPanel;
    dgrdCategorie: TDBGrid;
    frmToolbarCategoria: TfrmToolbarFiglio;
    pnlDati: TPanel;
    dgrdDati: TDBGrid;
    frmToolbarDati: TfrmToolbarFiglio;
    splModelliCategorie: TSplitter;
    splCategorieDati: TSplitter;
    lblCategorie: TLabel;
    lblDati: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dgrdDatiKeyPress(Sender: TObject; var Key: Char);
    procedure dgrdDatiButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    A204DM: TA204FModelliCertificazioneDtM;
    C600frmSelAnagrafe: TC600frmSelAnagrafe;
  public
    { Public declarations }
  end;

var
  A204FModelliCertificazione: TA204FModelliCertificazione;

procedure OpenA204ModelliCertificazione;

implementation

{$R *.dfm}

procedure OpenA204ModelliCertificazione;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA204ModelliCertificazione') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  if (not SolaLettura) and (Parametri.Applicazione = 'PAGHE')  then
    SolaLettura:=True;

  A204FModelliCertificazione:=TA204FModelliCertificazione.Create(nil);
  //A204FModelliCertificazione.HelpContext:=204000;
  try
    A204FModelliCertificazione.ShowModal;
  finally
    FreeAndNil(A204FModelliCertificazione);
  end;
end;


procedure TA204FModelliCertificazione.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  If Action <> caNone then
    C600frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA204FModelliCertificazione.FormDestroy(Sender: TObject);
begin
  if A204DM <> nil then
    FreeAndNil(A204DM);
  inherited;
end;

procedure TA204FModelliCertificazione.FormShow(Sender: TObject);
begin
  inherited;

  A204DM:=TA204FModelliCertificazioneDtM.Create(nil);
  DButton.DataSet:=A204DM.selSG235;

  with frmToolbarCategoria do
  begin
    TFDButton:=A204DM.dsrSG236;
    TFDBGrid:=dgrdCategorie;
    tlbarFiglio.HandleNeeded;//necessario per XE3
    SetLength(lstLock,6);
    lstLock[0]:=Panel1;
    lstLock[1]:=File1;
    lstLock[2]:=Strumenti1;
    lstLock[3]:=frmToolbarDati.tlbarFiglio;
    lstLock[4]:=dgrdModelli;
    lstLock[5]:=dgrdDati;
    AbilitaAzioniTF(nil);
  end;

  with frmToolbarDati do
  begin
    TFDButton:=A204DM.dsrSG237;
    TFDBGrid:=dgrdDati;
    tlbarFiglio.HandleNeeded;//necessario per XE3
    SetLength(lstLock,6);
    lstLock[0]:=Panel1;
    lstLock[1]:=File1;
    lstLock[2]:=Strumenti1;
    lstLock[3]:=frmToolbarCategoria.tlbarFiglio;
    lstLock[4]:=dgrdModelli;
    lstLock[5]:=dgrdCategorie;
    AbilitaAzioniTF(nil);
  end;

  A204DM.PopolaListeValori;

  C600frmSelAnagrafe:=TC600frmSelAnagrafe.Create(Self);
  C600frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,nil,0,False);
  C600frmSelAnagrafe.C600DataLavoro:=Parametri.DataLavoro;
  C600frmSelAnagrafe.C600Progressivo:=0;

end;

procedure TA204FModelliCertificazione.dgrdDatiButtonClick(Sender: TObject);
var
  myGrd: TDBGrid;
  StrLst: TStringList;
  Str:String;
begin
  inherited;
  myGrd:=TDBGrid(Sender);
  if not (myGrd.DataSource.State in [dsEdit,dsInsert]) then
    exit;
  try
    if myGrd.SelectedField.FieldName = 'SELEZIONE_ANAGRAFE' then
    begin
      C600frmSelAnagrafe.C600DataLavoro:=Parametri.DataLavoro;
      C600frmSelAnagrafe.C600DatiVisualizzati:='';
      C600frmSelAnagrafe.btnSelezioneClick(Sender);
      if C600frmSelAnagrafe.C600ModalResult = mrOK then
      begin
        Str:=C600frmSelAnagrafe.C600FSelezioneAnagrafe.SQLCreato.Text.Trim;
        if pos('ORDER BY',UpperCase(Str)) > 0 then
          Str:=Copy(Str,1,Pos('ORDER BY',Str.ToUpper) - 1).Trim;
        myGrd.DataSource.DataSet.FieldByName('SELEZIONE_ANAGRAFE').AsString:=Str;
      end;
    end
    else
    begin
      StrLst:=TStringList.Create;
      StrLst.Text:=myGrd.SelectedField.AsString;
      OpenC012VisualizzaTesto(myGrd.SelectedField.DisplayLabel,'',StrLst,'',[mbOK,mbCancel]);
      myGrd.SelectedField.AsString:=Trim(StrLst.Text);
    end;
  finally
    FreeAndNil(StrLst);
  end;
end;

procedure TA204FModelliCertificazione.dgrdDatiKeyPress(Sender: TObject; var Key: Char);
var
  myGrd: TDBGrid;
begin
  inherited;
  myGrd:=TDBGrid(Sender);
  with myGrd do
  begin
    if (SelectedField.FieldName.ToUpper = 'OBBLIGATORIO') or
       (SelectedField.FieldName.ToUpper = 'FORMATO') or
       (SelectedField.FieldName.ToUpper = 'ELENCO_FISSO') or
       (SelectedField.FieldName.ToUpper = 'AUTOCERTIFICAZIONE') or
       (SelectedField.FieldName.ToUpper = 'UM') then
      Key:=UpCase(Key);
  end;
end;

end.
