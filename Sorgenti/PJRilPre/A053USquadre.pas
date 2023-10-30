unit A053USquadre;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, Db, Menus, Buttons, ExtCtrls, ComCtrls, StdCtrls, Grids,
  DBGrids, Mask, DBCtrls, ActnList, ImgList, ToolWin, A000UCostanti, A000USessione,A000UInterfaccia,
  A055UTurnazioni, A070UProfiliTurni, Variants, C011UDBList, Spin,
  System.Actions, Oracle, System.ImageList;

type
  TA053FSquadre = class(TR001FGestTab)
    Panel2: TPanel;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    PopupMenu1: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    PgMaxMin: TPageControl;
    TabSheet1: TTabSheet;
    DBGrid1: TDBGrid;
    Panel3: TPanel;
    BAnnulla: TBitBtn;
    BConferma: TBitBtn;
    BModifica: TBitBtn;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    DBEdit4: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    DBEdit14: TDBEdit;
    DBEdit15: TDBEdit;
    DBEdit16: TDBEdit;
    DBEdit17: TDBEdit;
    DBEdit18: TDBEdit;
    DBEdit19: TDBEdit;
    TabSheet2: TTabSheet;
    Label17: TLabel;
    DCmbCausComp: TDBLookupComboBox;
    GroupBox2: TGroupBox;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    EdtMinInd1: TDBEdit;
    EdtMinInd2: TDBEdit;
    EdtMinInd3: TDBEdit;
    EdtMinInd4: TDBEdit;
    DBEdit20: TDBEdit;
    Label22: TLabel;
    nime: TLabel;
    EdtFestMens: TDBEdit;
    DEdtPriorTurni: TDBEdit;
    Label23: TLabel;
    lblMaxNottiMese: TLabel;
    edtMaxNottiMese: TDBEdit;
    dgrdAree: TDBGrid;
    Panel4: TPanel;
    btnConfermaAree: TBitBtn;
    btnAnnullaAree: TBitBtn;
    btnModificaAree: TBitBtn;
    procedure BModificaClick(Sender: TObject);
    procedure BAnnullaClick(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure DBGrid1EditButtonClick(Sender: TObject);
    procedure BConfermaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PgMaxMinChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnModificaAreeClick(Sender: TObject);
    procedure btnConfermaAreeClick(Sender: TObject);
    procedure btnAnnullaAreeClick(Sender: TObject);
    procedure dgrdAreeEditButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A053FSquadre: TA053FSquadre;

procedure OpenA053Squadre(cod:string);

implementation

uses A053USquadreDtM1;

{$R *.DFM}

procedure OpenA053Squadre(cod:string);
begin
  SolaLetturaOriginale:=SolaLettura;
  (*
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA053Squadre') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  *) //progetto sostituito da A205 ma accedibile in sola lettura tramite esso
  SolaLettura:=True;
  A053FSquadre:=TA053FSquadre.Create(nil);
  with A053FSquadre do
    try
      A053FSquadreDtM1:=TA053FSquadreDtM1.Create(nil);
      A053FSquadreDtM1.Q600.Locate('Codice',cod,[]);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A053FSquadreDtM1.Free;
      Free;
    end;
end;

procedure TA053FSquadre.BModificaClick(Sender: TObject);
{Abilito le modifiche ai Tipi operatore}
begin
  A053FSquadreDtM1.Q601.ReadOnly:=False;
  BModifica.Enabled:=False;
  BConferma.Enabled:=True;
  BAnnulla.Enabled:=True;
  Panel1.Enabled:=False;
  NuovoElemento1.Enabled:=true;
  DbGrid1.Columns[23].ButtonStyle:= cbsEllipsis;
  DbGrid1.Columns[24].ButtonStyle:= cbsEllipsis;
end;

procedure TA053FSquadre.btnAnnullaAreeClick(Sender: TObject);
{Annullo le modifiche alle Aree}
begin
  inherited;
  A053FSquadreDtM1.Q651.CancelUpdates;
  A053FSquadreDtM1.Q651.ReadOnly:=True;
  btnModificaAree.Enabled:=True;
  btnConfermaAree.Enabled:=False;
  btnAnnullaAree.Enabled:=False;
  Panel1.Enabled:=True;
  NuovoElemento1.Enabled:=false;
  dgrdAree.Columns[0].ButtonStyle:= cbsNone;
end;

procedure TA053FSquadre.btnConfermaAreeClick(Sender: TObject);
{Confermo le modifiche ai Tipi operatore}
begin
  inherited;
  try
    try
      SessioneOracle.ApplyUpdates([A053FSquadreDtM1.Q651],True);
      SessioneOracle.Commit;
    except
      SessioneOracle.Rollback;
      raise;
    end;
  finally
    A053FSquadreDtM1.Q651.ReadOnly:=True;
    A053FSquadreDtM1.Q651.Close;
    A053FSquadreDtM1.Q651.Open;
    btnModificaAree.Enabled:=True;
    btnConfermaAree.Enabled:=False;
    btnAnnullaAree.Enabled:=False;
    Panel1.Enabled:=True;
    NuovoElemento1.Enabled:=false;
    dgrdAree.Columns[0].ButtonStyle:= cbsNone;
//    DButton.DataSet.Refresh;
  end;
end;

procedure TA053FSquadre.btnModificaAreeClick(Sender: TObject);
begin
  inherited;
  A053FSquadreDtM1.Q651.ReadOnly:=False;
  btnModificaAree.Enabled:=False;
  btnConfermaAree.Enabled:=True;
  btnAnnullaAree.Enabled:=True;
  Panel1.Enabled:=False;
  NuovoElemento1.Enabled:=true;
  dgrdAree.Columns[0].ButtonStyle:= cbsEllipsis;
end;

procedure TA053FSquadre.BAnnullaClick(Sender: TObject);
{Annullo le modifiche ai Tipi operatore}
begin
  A053FSquadreDtM1.Q601.CancelUpdates;
  A053FSquadreDtM1.Q601.ReadOnly:=True;
  BModifica.Enabled:=True;
  BConferma.Enabled:=False;
  BAnnulla.Enabled:=False;
  Panel1.Enabled:=True;
  NuovoElemento1.Enabled:=false;
  DbGrid1.Columns[23].ButtonStyle:= cbsNone;
  DbGrid1.Columns[24].ButtonStyle:= cbsNone;
end;

procedure TA053FSquadre.BConfermaClick(Sender: TObject);
{Confermo le modifiche ai Tipi operatore}
begin
  try
    try
      SessioneOracle.ApplyUpdates([A053FSquadreDtM1.Q601],True);
      SessioneOracle.Commit;
    except
      SessioneOracle.Rollback;
      raise;
    end;
  finally
    A053FSquadreDtM1.Q601.ReadOnly:=True;
    A053FSquadreDtM1.Q601.Close;
    A053FSquadreDtM1.Q601.Open;
    BModifica.Enabled:=True;
    BConferma.Enabled:=False;
    BAnnulla.Enabled:=False;
    Panel1.Enabled:=True;
    NuovoElemento1.Enabled:=false;
    DbGrid1.Columns[23].ButtonStyle:= cbsNone;
    DbGrid1.Columns[24].ButtonStyle:= cbsNone;
//    DButton.DataSet.Refresh;
  end;
end;

procedure TA053FSquadre.DButtonStateChange(Sender: TObject);
begin
  inherited;
  BModifica.Enabled:=(DButton.State = dsBrowse) and (DButton.Dataset.RecordCount > 0) and not SolaLettura;
  btnModificaAree.Enabled:=BModifica.Enabled;
end;

procedure TA053FSquadre.FormActivate(Sender: TObject);
begin
  DButton.DataSet:=A053FSquadreDtM1.Q600;
  inherited;
end;

procedure TA053FSquadre.DButtonDataChange(Sender: TObject; Field: TField);
{Leggo i tipi operatori della squadra}
begin
  if (Field = nil) and (DButton.State = dsBrowse) then
  begin
    A053FSquadreDtM1.Q601.Close;
    A053FSquadreDtM1.Q601.SetVariable('Squadra',A053FSquadreDtM1.Q600Codice.AsString);
    A053FSquadreDtM1.Q601.Open;
    A053FSquadreDtM1.Q651.Close;
    A053FSquadreDtM1.Q651.SetVariable('Squadra',A053FSquadreDtM1.Q600Codice.AsString);
    A053FSquadreDtM1.Q651.Open;
  end;
end;

procedure TA053FSquadre.DBGrid1EditButtonClick(Sender: TObject);
{Richiamo l'elenco delle turnazioni o degli orari}
begin
  with A053FSquadreDtM1 do
  begin
    C011FDBList:=TC011FDBList.Create(nil);
    C011FDBList.Chiave:=DbGrid1.SelectedField.Text;
    try
      if UpperCase(DbGrid1.SelectedField.Name)='Q601TURNAZ' then
      begin
        C011FDBList.DataSource1.DataSet:=Q640;
        C011FDBList.Caption:='Elenco Turnazioni';
      end
      else if UpperCase(DbGrid1.SelectedField.Name)='Q601PROFILO' then
      begin
        C011FDBList.DataSource1.DataSet:=Q602;
        C011FDBList.Caption:='Elenco Profili';
      end;
      if (C011FDBList.ShowModal = mrOK) and (BModifica.Enabled = false) then
      begin
        A053FSquadreDtM1.Q601.Edit;
        DbGrid1.SelectedField.AsString:=C011FDBList.DataSource1.DataSet.FieldByName('Codice').AsString;
      end;
    finally
      C011FDBList.Release;
    end;
  end;
end;

procedure TA053FSquadre.dgrdAreeEditButtonClick(Sender: TObject);
{Richiamo l'elenco degli operatori previsti per la squadra}
begin
  with A053FSquadreDtM1 do
  begin
    inherited;
    C011FDBList:=TC011FDBList.Create(nil);
    C011FDBList.Chiave:=dgrdAree.SelectedField.Text;
    try
      if UpperCase(dgrdAree.SelectedField.Name)='Q651CODICE_OPERATORE' then
      begin
        selT601.Close;
        selT601.SetVariable('Squadra',Q600Codice.AsString);
        selT601.Open;
        C011FDBList.DataSource1.DataSet:=selT601;
        C011FDBList.Caption:='Elenco Tipi Operatori';
      end;
      if (C011FDBList.ShowModal = mrOK) and (btnModificaAree.Enabled = false) then
      begin
        A053FSquadreDtM1.Q651.Edit;
        dgrdAree.SelectedField.AsString:=C011FDBList.DataSource1.DataSet.FieldByName('Codice').AsString;
      end;
    finally
      C011FDBList.Release;
    end;
  end;
end;

procedure TA053FSquadre.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if Action <> caNone then
    if not A053FSquadreDtM1.Q601.ReadOnly then
      Action:=caNone;
end;

procedure TA053FSquadre.Nuovoelemento1Click(Sender: TObject);
{Richiamo gestione turnazioni}
begin
  if (PopupMenu1.PopupComponent as TDBGrid).SelectedField.FieldName = 'TURNAZ' then
  begin
    OpenA055Turnazioni(DbGrid1.SelectedField.AsString);
    A053FSquadreDtM1.Q602.Refresh;
  end
  else if (PopupMenu1.PopupComponent as TDBGrid).SelectedField.FieldName = 'PROFILO' then
  begin
    OpenA070ProfiliTurni(DbGrid1.SelectedField.AsString);
    A053FSquadreDtM1.Q602.Refresh;
  end;
end;

procedure TA053FSquadre.PgMaxMinChange(Sender: TObject);
begin
  inherited;
  if PgMaxMin.ActivePage is TTabSheet then
    with A053FSquadreDtM1 do
      selT265.Open;
end;

procedure TA053FSquadre.FormCreate(Sender: TObject);
begin
  inherited;
  DBGrid1.ReadOnly:=SolaLettura;
end;

procedure TA053FSquadre.FormShow(Sender: TObject);
begin
  inherited;
  PgMaxMin.ActivePage:=TabSheet1;
end;

end.
