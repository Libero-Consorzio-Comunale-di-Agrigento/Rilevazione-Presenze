unit A205USquadre;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, Menus, Buttons, ExtCtrls, ComCtrls, StdCtrls, Grids, DBGrids, Mask,
  DBCtrls, ActnList, ImgList, ToolWin, Variants, Spin, StrUtils,
  System.Actions, Oracle, System.ImageList, R001UGESTTAB,
  A000UCostanti, A000UInterfaccia, A000UMessaggi, A000USessione,
  A003UDataLavoroBis, A016UCausAssenze, A055UTurnazioni, A138UAreeTurni,
  C013UCheckList, C180FunzioniGenerali, ToolbarFiglio;

type
  TA205FSquadre = class(TR001FGestTab)
    Panel2: TPanel;
    lblCodice: TLabel;
    dedtCodice: TDBEdit;
    lblDescrizione: TLabel;
    dedtDescrizione: TDBEdit;
    dedtDescrizioneLunga: TDBEdit;
    lblCausRiposo: TLabel;
    dcmbCausRiposo: TDBLookupComboBox;
    gpbDettaglio: TGroupBox;
    dgrdAree: TDBGrid;
    pnlDettaglio: TPanel;
    frmToolbarFiglio: TfrmToolbarFiglio;
    lblDescrizioneLunga: TLabel;
    lblCodiciTurnazione: TLabel;
    dedtCodiciTurnazione: TDBEdit;
    btnCodiciTurnazione: TButton;
    lblInizioValidita: TLabel;
    dedtInizioValidita: TDBEdit;
    btnInizioValidita: TButton;
    lblFineValidita: TLabel;
    dedtFineValidita: TDBEdit;
    btnFineValidita: TButton;
    PopupMenu1: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure btnInizioValiditaClick(Sender: TObject);
    procedure btnCodiciTurnazioneClick(Sender: TObject);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Stampa1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A205FSquadre: TA205FSquadre;

procedure OpenA205Squadre(CodSquadra:string);

implementation

uses A205USquadreDM;

{$R *.DFM}

procedure OpenA205Squadre(CodSquadra:string);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA205Squadre') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A205FSquadre:=TA205FSquadre.Create(nil);
  with A205FSquadre do
    try
      A205FSquadreDM:=TA205FSquadreDM.Create(nil);
      A205FSquadreDM.selT603.Locate('Codice',CodSquadra,[]);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A205FSquadreDM.Free;
      Free;
    end;
end;

procedure TA205FSquadre.FormActivate(Sender: TObject);
begin
  DButton.DataSet:=A205FSquadreDM.selT603;
  inherited;
end;

procedure TA205FSquadre.FormShow(Sender: TObject);
begin
  inherited;
  frmToolbarFiglio.TFDButton:=A205FSquadreDM.A205MW.dsrT651;
  frmToolbarFiglio.TFDBGrid:=dgrdAree;
  SetLength(frmToolbarFiglio.lstLock,4);
  frmToolbarFiglio.lstLock[0]:=Panel1;
  frmToolbarFiglio.lstLock[1]:=Panel2;
  frmToolbarFiglio.lstLock[2]:=File1;
  frmToolbarFiglio.lstLock[3]:=Strumenti1;
  frmToolbarFiglio.AbilitaAzioniTF(nil);
end;

procedure TA205FSquadre.DButtonStateChange(Sender: TObject);
begin
  inherited;
  btnInizioValidita.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnFineValidita.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnCodiciTurnazione.Enabled:=DButton.State in [dsEdit,dsInsert];
end;

procedure TA205FSquadre.btnInizioValiditaClick(Sender: TObject);
var NomeCampo,Titolo:String;
begin
  if (Sender as TButton).Name = 'btnInizioValidita' then
    NomeCampo:='INIZIO_VALIDITA'
  else if (Sender as TButton).Name = 'btnFineValidita' then
    NomeCampo:='FINE_VALIDITA';
  Titolo:=IfThen(Pos('INIZIO_VALIDITA',NomeCampo) > 0,'Data inizio validità','Data fine validità');
  with A205FSquadreDM do
  begin
    if selT603.FieldByName(NomeCampo).IsNull then
      selT603.FieldByName(NomeCampo).AsDateTime:=Parametri.DataLavoro;
    selT603.FieldByName(NomeCampo).AsDateTime:=DataOut(selT603.FieldByName(NomeCampo).AsDateTime,Titolo,'G');
  end;
end;

procedure TA205FSquadre.btnCodiciTurnazioneClick(Sender: TObject);
begin
  C013FCheckList:=TC013FCheckList.Create(nil);
  with C013FCheckList do
    try
      clbListaDati.Items.Clear;
      with A205FSquadreDM.A205MW.selT640 do
      begin
        First;
        while not Eof do
        begin
          clbListaDati.Items.Add(Format('%-5s %s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
          Next;
        end;
      end;
      R180PutCheckList(dedtCodiciTurnazione.Text,5,clbListaDati);
      ShowModal;
    finally
      if C013FCheckList.ModalResult = mrOk then
        A205FSquadreDM.selT603.FieldByName('CODICI_TURNAZIONE').AsString:=Trim(R180GetCheckList(5,C013FCheckList.clbListaDati));
      FreeAndNil(C013FCheckList);
    end;
end;

procedure TA205FSquadre.Nuovoelemento1Click(Sender: TObject);
{Richiamo gestione turnazioni}
begin
  if PopupMenu1.PopupComponent is TDBLookupComboBox then
  begin
    OpenA016CausAssenze(VarToStr(dcmbCausRiposo.KeyValue));
    A205FSquadreDM.A205MW.selT265.Refresh;
  end
  else if PopupMenu1.PopupComponent is TDBEdit then
  begin
    OpenA055Turnazioni(Copy(dedtCodiciTurnazione.Text,1,Pos(',',dedtCodiciTurnazione.Text + ',') - 1));
    A205FSquadreDM.A205MW.selT640.Refresh;
  end
  else if PopupMenu1.PopupComponent is TDBGrid then
  begin
    if dgrdAree.SelectedField.FieldName = 'DESCRIZIONE_AREA' then
    begin
      OpenA138AreeTurni(Copy(dgrdAree.SelectedField.AsString,1,Pos(' -',dgrdAree.SelectedField.AsString + ' -') - 1));
      A205FSquadreDM.A205MW.selT650.Refresh;
    end;
  end;
end;

procedure TA205FSquadre.Stampa1Click(Sender: TObject);
begin
  QueryStampa.Clear;
  QueryStampa.Add('SELECT T1.CODICE, T1.INIZIO_VALIDITA, T1.FINE_VALIDITA, T1.DESCRIZIONE, T1.DESCRIZIONELUNGA, T1.CAUS_RIPOSO, T1.CODICI_TURNAZIONE,');
  QueryStampa.Add('T2.CODICE_OPERATORE, T2.CODICE_AREA');
  QueryStampa.Add('FROM T603_SQUADRE T1, T651_AREE_SQUADRA T2');
  QueryStampa.Add('WHERE T1.CODICE = T2.CODICE_SQUADRA (+)');
  NomiCampiR001.Clear;
  NomiCampiR001.Add('T1.CODICE');
  NomiCampiR001.Add('T1.INIZIO_VALIDITA');
  NomiCampiR001.Add('T1.FINE_VALIDITA');
  NomiCampiR001.Add('T1.DESCRIZIONE');
  NomiCampiR001.Add('T1.DESCRIZIONELUNGA');
  NomiCampiR001.Add('T1.CAUS_RIPOSO');
  NomiCampiR001.Add('T1.CODICI_TURNAZIONE');
  NomiCampiR001.Add('T2.CODICE_OPERATORE');
  NomiCampiR001.Add('T2.CODICE_AREA');
  inherited;
end;

procedure TA205FSquadre.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if not Panel1.Enabled then
    Action:=caNone;
end;

end.
