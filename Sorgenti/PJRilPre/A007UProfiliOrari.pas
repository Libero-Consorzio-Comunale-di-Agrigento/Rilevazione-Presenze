unit A007UProfiliOrari;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGestStorico, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin,
  StdCtrls, Mask, DBCtrls, Buttons, ExtCtrls, OracleData,
  Grids, A000UCostanti, A000USessione,A000UInterfaccia, RegistrazioneLog, A006UModelliOrario,
  DBGrids, ToolbarFiglio, System.Actions, System.ImageList;

type
  TA007FProfiliOrari = class(TR004FGestStorico)
    ScrollBox1: TScrollBox;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label12: TLabel;
    NumSettimane: TLabel;
    ECodice: TDBEdit;
    EDescrizione: TDBEdit;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    EAntUsc: TDBEdit;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    DBEdit1: TDBEdit;
    DBGrid1: TDBGrid;
    PopupMenu1: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    frmToolbarFiglio: TfrmToolbarFiglio;
    drgpPriTimSc: TDBRadioGroup;
    dchkIgnoraTimbNonInSeq: TDBCheckBox;
    dchkPrioritaDomFest: TDBCheckBox;
    dchkPrioritaDomNonLav: TDBCheckBox;
    GroupBox2: TGroupBox;
    lblPesoSCOSTENTRATA_S: TLabel;
    dedtPesoSCOSTENTRATA_S: TDBEdit;
    lblPesoTIMBESTERNE: TLabel;
    dedtPesoTIMBESTERNE: TDBEdit;
    lblPesoTIMBNONAPPOGGIATE_S: TLabel;
    dedtPesoTIMBNONAPPOGGIATE_S: TDBEdit;
    lblPesoTIMBNONAPPOGGIATE_N: TLabel;
    dedtPesoTIMBNONAPPOGGIATE_N: TDBEdit;
    lblPesoRITARDO_ENTRATA: TLabel;
    dedtPesoRITARDO_ENTRATA: TDBEdit;
    lblPesoMINANTSCELTA: TLabel;
    dedtPesoMINANTSCELTA: TDBEdit;
    lblPesoPRITIMSC_A: TLabel;
    dedtPesoPRITIMSC_A: TDBEdit;
    lblPesoPRITIMSC_S: TLabel;
    dedtPesoPRITIMSC_S: TDBEdit;
    dchkIgnoraStaccoPMT: TDBCheckBox;
    procedure FormShow(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure TCancClick(Sender: TObject);
    procedure TModifClick(Sender: TObject);
    procedure btnStoricizzaClick(Sender: TObject);
    procedure TRegisClick(Sender: TObject);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure DBGrid1EditButtonClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBLookupComboBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Stampa1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure frmToolbarFiglioactTFConfermaExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A007FProfiliOrari: TA007FProfiliOrari;

procedure OpenA007ProfiliOrari(Cod:String);

implementation

uses A007UProfiliOrariDtM1, A007USelezOrari;

{$R *.dfm}

procedure OpenA007ProfiliOrari(Cod:String);
{Gestione Profili Orari}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA007ProfiliOrari') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A007FProfiliOrari:=TA007FProfiliOrari.Create(nil);
  with A007FProfiliOrari do
    try
    A007FProfiliOrariDtM1:=TA007FProfiliOrariDtM1.Create(nil);
    A007FProfiliOrariDtM1.Q220.Locate('Codice',Cod,[]);
    ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A007FProfiliOrariDtM1.Free;
      Release;
    end;
end;

procedure TA007FProfiliOrari.FormCreate(Sender: TObject);
begin
  inherited;
  DBGrid1.ReadOnly:=SolaLettura;
end;

procedure TA007FProfiliOrari.FormShow(Sender: TObject);
begin
  DButton.DataSet:=A007FProfiliOrariDtM1.Q220;
  frmToolbarFiglio.TFDButton:=A007FProfiliOrariDtM1.D221;
  frmToolbarFiglio.TFDBGrid:=DBGrid1;
  SetLength(frmToolbarFiglio.lstLock,4);
  frmToolbarFiglio.lstLock[0]:=ToolBar1;
  frmToolbarFiglio.lstLock[1]:=grbDecorrenza;
  frmToolbarFiglio.lstLock[2]:=File1;
  frmToolbarFiglio.lstLock[3]:=Strumenti1;
  frmToolbarFiglio.AbilitaAzioniTF(nil);
  inherited;
  SetTabelleRelazionate([A007FProfiliOrariDtM1.Q220,A007FProfiliOrariDtM1.Q221]);
  NumSettimane.Caption:=IntToStr(A007FProfiliOrariDtM1.Q221.RecordCount);
  CercaStoricoCorrente;
end;

procedure TA007FProfiliOrari.frmToolbarFiglioactTFConfermaExecute(
  Sender: TObject);
var cod:String;
    dec:TDateTime;
begin
  inherited;
  with A007FProfiliOrariDtM1 do
  begin
    if OrarioOk then
    begin
      RegistraLog.SettaProprieta('I','T221_PROFILISETTIMANA',Copy(Self.Name,1,4),Q221,True);
      RegistraLog.SettaProprieta('M','T221_PROFILISETTIMANA',Copy(Self.Name,1,4),nil,False);
      RegistraLog.RegistraOperazione;
      if D221.State <> dsBrowse then
        Q221.Post;
      if Q221.UpdatesPending then
        SessioneOracle.ApplyUpdates([Q221],True);
      frmToolbarFiglio.AbilitaAzioniTF(nil);
      Q221.Refresh;
      Q221.ReadOnly:=True;
      //Richiamo l'evento AfterPost del Q220 dove, se il DS è Q221, deve solo fare l'inherited
      A007FProfiliOrariDtM1.AfterPost(Q221);
      cod:=Q220.FieldByName('CODICE').AsString;
      dec:=Q220.FieldByName('DECORRENZA').AsDateTime;
      Q220.Refresh;
      if not Q220.SearchRecord('CODICE;DECORRENZA',VarArrayOf([cod,dec]),[srFromBeginning]) then
        Q220.SearchRecord('CODICE',cod,[srFromBeginning]);
    end;
  end;
end;

procedure TA007FProfiliOrari.DBLookupComboBox1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
{Il tasto Alt-H annulla l'orario}
begin
  inherited;
  if (Key = Ord('H')) and (Shift = [ssAlt]) and
     (A007FProfiliOrariDtM1.Q221.State in [dsInsert,dsEdit]) then
    A007FProfiliOrariDtM1.Q221.Fields[(Sender as TComponent).Tag].Clear;
end;

procedure TA007FProfiliOrari.Stampa1Click(Sender: TObject);
begin
  QueryStampa.Clear;
  QueryStampa.Add('SELECT');
  QueryStampa.Add('  Q220.Codice,Q220.Decorrenza,Q220.DESCRIZIONE,T1.Progressivo,');
  QueryStampa.Add('  T1.Lunedi,T1.Martedi,T1.Mercoledi,T1.Giovedi,T1.Venerdi,T1.Sabato,T1.Domenica,T1.NonLav,T1.Festivo,');
  QueryStampa.Add('  T020F_GETDATO(T1.Lunedi,   Q220.DECORRENZA,''DESCRIZIONE'') D_Lunedi,');
  QueryStampa.Add('  T020F_GETDATO(T1.Martedi,  Q220.DECORRENZA,''DESCRIZIONE'') D_Martedi,');
  QueryStampa.Add('  T020F_GETDATO(T1.Mercoledi,Q220.DECORRENZA,''DESCRIZIONE'') D_Mercoledi,');
  QueryStampa.Add('  T020F_GETDATO(T1.Giovedi,  Q220.DECORRENZA,''DESCRIZIONE'') D_Giovedi,');
  QueryStampa.Add('  T020F_GETDATO(T1.Venerdi,  Q220.DECORRENZA,''DESCRIZIONE'') D_Venerdi,');
  QueryStampa.Add('  T020F_GETDATO(T1.Sabato,   Q220.DECORRENZA,''DESCRIZIONE'') D_Sabato,');
  QueryStampa.Add('  T020F_GETDATO(T1.Domenica, Q220.DECORRENZA,''DESCRIZIONE'') D_Domenica,');
  QueryStampa.Add('  T020F_GETDATO(T1.NonLav,   Q220.DECORRENZA,''DESCRIZIONE'') D_NonLav,');
  QueryStampa.Add('  T020F_GETDATO(T1.Festivo,  Q220.DECORRENZA,''DESCRIZIONE'') D_Festivo');
  QueryStampa.Add('FROM');
  QueryStampa.Add('  T221_PROFILISETTIMANA T1, T220_PROFILIORARI Q220');
  QueryStampa.Add('WHERE');
  QueryStampa.Add('T1.Codice (+) = Q220.Codice AND');
  QueryStampa.Add('T1.Decorrenza = Q220.Decorrenza');
  NomiCampiR001.Clear;
  NomiCampiR001.Add('T1.Codice');
  NomiCampiR001.Add('Q220.Decorrenza');
  NomiCampiR001.Add('Q220.Descrizione');
  NomiCampiR001.Add('T1.Progressivo');
  NomiCampiR001.Add('T1.Lunedi');
  NomiCampiR001.Add('T1.Martedi');
  NomiCampiR001.Add('T1.Mercoledi');
  NomiCampiR001.Add('T1.Giovedi');
  NomiCampiR001.Add('T1.Venerdi');
  NomiCampiR001.Add('T1.Sabato');
  NomiCampiR001.Add('T1.Domenica');
  NomiCampiR001.Add('T1.NonLav');
  NomiCampiR001.Add('T1.Festivo');
  NomiCampiR001.Add('T020F_GETDATO(T1.Lunedi,   Q220.DECORRENZA,''DESCRIZIONE'')');
  NomiCampiR001.Add('T020F_GETDATO(T1.Martedi,  Q220.DECORRENZA,''DESCRIZIONE'')');
  NomiCampiR001.Add('T020F_GETDATO(T1.Mercoledi,Q220.DECORRENZA,''DESCRIZIONE'')');
  NomiCampiR001.Add('T020F_GETDATO(T1.Giovedi,  Q220.DECORRENZA,''DESCRIZIONE'')');
  NomiCampiR001.Add('T020F_GETDATO(T1.Venerdi,  Q220.DECORRENZA,''DESCRIZIONE'')');
  NomiCampiR001.Add('T020F_GETDATO(T1.Sabato,   Q220.DECORRENZA,''DESCRIZIONE'')');
  NomiCampiR001.Add('T020F_GETDATO(T1.Domenica, Q220.DECORRENZA,''DESCRIZIONE'')');
  NomiCampiR001.Add('T020F_GETDATO(T1.NonLav,   Q220.DECORRENZA,''DESCRIZIONE'')');
  NomiCampiR001.Add('T020F_GETDATO(T1.Festivo,  Q220.DECORRENZA,''DESCRIZIONE'')');
  inherited;
end;

procedure TA007FProfiliOrari.DBGrid1CellClick(Column: TColumn);
begin
  inherited;
  DbGrid1.Hint:=VarToStr(A007FProfiliOrariDtM1.Q020.Lookup('Codice',DbGrid1.SelectedField.AsString,'Descrizione'));
end;

procedure TA007FProfiliOrari.DBGrid1EditButtonClick(Sender: TObject);
begin
  inherited;
  if SolaLettura then exit;
  A007FSelezOrari:=TA007FSelezOrari.Create(nil);
  with A007FSelezOrari do
    try
      if (ShowModal = mrOK) and (not A007FProfiliOrariDtM1.Q221.ReadOnly) then
        begin
        if A007FProfiliOrariDtM1.Q221.State = dsBrowse then
          A007FProfiliOrariDtM1.Q221.Edit;
        DbGrid1.SelectedField.AsString:=A007FProfiliOrariDtM1.Q020.FieldByName('Codice').AsString;
        end;
    finally
      Release;
    end;
end;

procedure TA007FProfiliOrari.Nuovoelemento1Click(Sender: TObject);
begin
  inherited;
  OpenA006ModelliOrario(DbGrid1.SelectedField.AsString);
  A007FProfiliOrariDtM1.Q020.Refresh;
end;

procedure TA007FProfiliOrari.TRegisClick(Sender: TObject);
begin
  inherited;
  A007FProfiliOrariDtM1.Q220AfterScroll(nil);
end;

procedure TA007FProfiliOrari.btnStoricizzaClick(Sender: TObject);
begin
  if A007FProfiliOrariDtM1.Q220.FieldByName('CODICE').AsString = '*' then
    raise Exception.Create('Attenzione! Impossibile storicizzare questo codice.');
  inherited;
end;

procedure TA007FProfiliOrari.TModifClick(Sender: TObject);
begin
  if A007FProfiliOrariDtM1.Q220.FieldByName('CODICE').AsString = '*' then
    raise Exception.Create('Attenzione! Impossibile modificare questo codice.');
  inherited;
end;

procedure TA007FProfiliOrari.TCancClick(Sender: TObject);
begin
  if A007FProfiliOrariDtM1.Q220.FieldByName('CODICE').AsString = '*' then
    raise Exception.Create('Attenzione! Impossibile cancellare questo codice.');
  inherited;
end;

procedure TA007FProfiliOrari.DButtonDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  frmToolbarFiglio.Enabled:=(not (A007FProfiliOrariDtM1.Q220.FieldByName('CODICE').AsString = '*')) and (DButton.State = dsBrowse);
end;

end.
