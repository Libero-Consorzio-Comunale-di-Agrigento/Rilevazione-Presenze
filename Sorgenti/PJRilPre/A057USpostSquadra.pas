unit A057USpostSquadra;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R001UGESTTAB, System.Actions,
  Vcl.ActnList, System.ImageList, Vcl.ImgList, Data.DB, Vcl.Menus, Vcl.ComCtrls,
  Vcl.ToolWin, SelAnagrafe, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids,
  A000UInterfaccia, A000UMessaggi, A000USessione, A003UDataLavoroBis,
  C005UDatiAnagrafici, C700USelezioneAnagrafe;

type
  TA057FSpostSquadra = class(TR001FGestTab)
    frmSelAnagrafe: TfrmSelAnagrafe;
    Panel2: TPanel;
    lblCodSquadra: TLabel;
    dcmbCodSquadra: TDBLookupComboBox;
    dlblCodSquadra: TDBText;
    lblCodOrario: TLabel;
    dcmbCodOrario: TDBLookupComboBox;
    dlblCodOrario: TDBText;
    lblSiglaTurno1: TLabel;
    dcmbSiglaTurno1: TDBLookupComboBox;
    lblSiglaTurno2: TLabel;
    dcmbSiglaTurno2: TDBLookupComboBox;
    lblData: TLabel;
    dedtData: TDBEdit;
    btnData: TButton;
    dgrdSpostamenti: TDBGrid;
    PopupMenu1: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    lblCodTipoOpe: TLabel;
    dcmbCodTipoOpe: TDBLookupComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure btnDataClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    TipoAccedi: Integer;
    procedure CambiaProgressivo;
  public
    { Public declarations }
  end;

var
  A057FSpostSquadra: TA057FSpostSquadra;

procedure OpenA057SpostSquadra(Prog:LongInt);

implementation

uses A057USpostSquadraDM, A006UModelliOrario, A205USquadre;

{$R *.dfm}

procedure OpenA057SpostSquadra(Prog:LongInt);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA057SpostSquadra') of
    'N':
        begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A057FSpostSquadra:=TA057FSpostSquadra.Create(nil);
  with A057FSpostSquadra do
    try
      C700Progressivo:=Prog;
      A057FSpostSquadraDM:=TA057FSpostSquadraDM.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A057FSpostSquadraDM.Free;
      Free;
    end;
end;

procedure TA057FSpostSquadra.FormCreate(Sender: TObject);
begin
  inherited;
  C700Progressivo:=0;
end;

procedure TA057FSpostSquadra.FormShow(Sender: TObject);
begin
  inherited;
  DButton.DataSet:=A057FSpostSquadraDM.Q630;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(A057FSpostSquadraDM.A057MW,SessioneOracle,StatusBar,0,True);
  frmSelAnagrafe.NumRecords;
  dcmbCodSquadra.ListSource:=A057FSpostSquadraDM.A057MW.dsrT603;
  dcmbCodTipoOpe.ListSource:=A057FSpostSquadraDM.A057MW.dsrT430;
  dcmbCodOrario.ListSource:=A057FSpostSquadraDM.A057MW.dsrT020;
  dcmbSiglaTurno1.ListSource:=A057FSpostSquadraDM.A057MW.dsrT021;
  dcmbSiglaTurno2.ListSource:=A057FSpostSquadraDM.A057MW.dsrT021;
  A057FSpostSquadraDM.A057MW.selT630.RefreshRecord;//Per descrizioni primo record
  A057FSpostSquadraDM.A057MW.RefreshDataSet;
end;

procedure TA057FSpostSquadra.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA057FSpostSquadra.frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
begin
  C005DataVisualizzazione:=A057FSpostSquadraDM.A057MW.selT630.FieldByName('DATA').AsDateTime;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA057FSpostSquadra.CambiaProgressivo;
begin
  if C700OldProgressivo <> C700Progressivo then
    with A057FSpostSquadraDM.Q630 do
    begin
      Close;
      SetVariable('Progressivo',C700Progressivo);
      Open;
    end;
end;

procedure TA057FSpostSquadra.DButtonStateChange(Sender: TObject);
begin
  inherited;
  btnData.Enabled:=DButton.State in [dsInsert];
  dedtData.Enabled:=not (DButton.State in [dsEdit]);
  dcmbCodSquadra.Enabled:=not (DButton.State in [dsEdit]);
end;

procedure TA057FSpostSquadra.DButtonDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  A057FSpostSquadraDM.A057MW.PulisciValori;
end;

procedure TA057FSpostSquadra.btnDataClick(Sender: TObject);
begin
  with A057FSpostSquadraDM.A057MW do
  begin
    if selT630.FieldByName('DATA').IsNull then
      selT630.FieldByName('DATA').AsDateTime:=Parametri.DataLavoro;
    selT630.FieldByName('DATA').AsDateTime:=DataOut(selT630.FieldByName('DATA').AsDateTime,'Data spostamento','G');
  end;
end;

procedure TA057FSpostSquadra.PopupMenu1Popup(Sender: TObject);
begin
  inherited;
  TipoAccedi:=0;
  if ((Sender as TPopupMenu).PopupComponent as TDBLookupComboBox).DataField = 'SQUADRA' then
    TipoAccedi:=1
  else if ((Sender as TPopupMenu).PopupComponent as TDBLookupComboBox).DataField = 'ORARIO' then
    TipoAccedi:=2;
end;

procedure TA057FSpostSquadra.Nuovoelemento1Click(Sender: TObject);
begin
  inherited;
  if TipoAccedi = 1 then
  begin
    OpenA205Squadre(VarToStr(dcmbCodSquadra.KeyValue));
    A057FSpostSquadraDM.A057MW.selT603.DisableControls;
    A057FSpostSquadraDM.A057MW.selT603.Refresh;
    A057FSpostSquadraDM.A057MW.selT603.EnableControls;
  end
  else if TipoAccedi = 2 then
  begin
    OpenA006ModelliOrario(VarToStr(dcmbCodOrario.KeyValue));
    A057FSpostSquadraDM.A057MW.selT020.DisableControls;
    A057FSpostSquadraDM.A057MW.selT020.Refresh;
    A057FSpostSquadraDM.A057MW.selT020.EnableControls;
  end;
end;

procedure TA057FSpostSquadra.KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Delete then
    if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
      if (Sender as TDBLookupComboBox).Field <> nil then
        (Sender as TDBLookupComboBox).Field.DataSet.FieldByName((Sender as TDBLookupComboBox).Field.KeyFields).Clear;
end;

procedure TA057FSpostSquadra.FormDestroy(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

end.
