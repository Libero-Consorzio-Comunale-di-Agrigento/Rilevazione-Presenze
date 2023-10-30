unit C018UInfoRichiesta;

interface

uses
  A000UCostanti,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids, C018UIterAutDM,
  Vcl.Menus, Vcl.DBGrids, A023UTimbratureDtm1, IOUtils, C021UDocumentiManagerDM,
  shellAPI, Data.DB, Datasnap.DBClient, FunzioniGenerali;

type
  TC018FInfoRichiesta = class(TForm)
    pMnuDocumenti: TPopupMenu;
    Apri1: TMenuItem;
    Salva1: TMenuItem;
    dlgFileSave: TSaveDialog;
    dgrdDocumenti: TDBGrid;
    grpInfoRichiedente: TGroupBox;
    grpInfoAutorizzatore: TGroupBox;
    lblIDRichiesta: TLabel;
    lblDataRichiesta: TLabel;
    lblCodiceIter: TLabel;
    lblRichiedente: TLabel;
    lblNoteRichiedente: TLabel;
    lblDataAutorizzazione: TLabel;
    lblAutorizzatore: TLabel;
    lblNoteAutorizzatore: TLabel;
    grpInfoRevoca: TGroupBox;
    lblIDRevoca: TLabel;
    lblDataRevoca: TLabel;
    lblNoteRevoca: TLabel;
    lblIDRichiestaValue: TLabel;
    lblDataRichiestaValue: TLabel;
    lblCodiceIterValue: TLabel;
    lblRichiedenteValue: TLabel;
    lblNoteRichiedenteValue: TLabel;
    lblDataAutorizzazioneValue: TLabel;
    lblAutorizzatoreValue: TLabel;
    lblNoteAutorizzatoreValue: TLabel;
    lblIDRevocaValue: TLabel;
    lblDataRevocaValue: TLabel;
    lblNoteRevocaValue: TLabel;
    dsrDocumentiInfo: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure Salva1Click(Sender: TObject);
    procedure Apri1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure MostraInfoRichiesta(IDRichiesta:integer);
  end;

implementation

uses
  C180FunzioniGenerali;

{$R *.dfm}

procedure TC018FInfoRichiesta.FormShow(Sender: TObject);
begin
  dgrdDocumenti.DataSource:=dsrDocumentiInfo;
end;

procedure TC018FInfoRichiesta.MostraInfoRichiesta(IDRichiesta:integer);
var
  //Info iter
  C018IterInfo:TC018IterInfo;
begin
  C018IterInfo:=TC018IterInfo.Create;
  try
    C018IterInfo.IDRichiesta:=IDRichiesta;
    //Informazioni richiedente
    lblIDRichiestaValue.Caption:=C018IterInfo.IDRichiesta.ToString;
    lblDataRichiestaValue.Caption:=C018IterInfo.DataRichiesta.toString;
    lblCodiceIterValue.Caption:=C018IterInfo.CodIter;
    lblRichiedenteValue.Caption:=C018IterInfo.Richiedente;
    lblNoteRichiedenteValue.Caption:=C018IterInfo.NoteRichiesta;
    //Informazioni autorizzatore
    lblDataAutorizzazioneValue.Caption:=C018IterInfo.DataAutorizzazione.toString;
    lblAutorizzatoreValue.Caption:=C018IterInfo.Autorizzatore;
    lblNoteAutorizzatoreValue.Caption:=C018IterInfo.NoteAutorizzatore;
    //Informazioni revoca
    grpInfoRevoca.Visible:=C018IterInfo.IDRevoca > 0;
    //Se grpInfoRevoca non è visibile, scalo alla form la sua altezza
    if not grpInfoRevoca.Visible then
    begin
      Self.Height:=Self.Height - grpInfoRevoca.Height;
    end;
    lblIDRevocaValue.Caption:=C018IterInfo.IDRevoca.ToString;
    lblDataRevocaValue.Caption:=C018IterInfo.DataRevoca.ToString;
    lblNoteRevocaValue.Caption:=C018IterInfo.NoteRevoca;
    //Eventuali allegati relativi all'iter richiesta
    Self.dsrDocumentiInfo.DataSet:=C018IterInfo.Allegati;
    dgrdDocumenti.Visible:=C018IterInfo.Allegati.RecordCount > 0;
    //Se dgrdDocumenti non è visibile, scalo alla form la sua altezza
    if C018IterInfo.Allegati.RecordCount <= 0 then
    begin
      Self.Height:=Self.Height - dgrdDocumenti.Height;
    end;
    Self.ShowModal;
  finally
    FreeAndNil(C018IterInfo);
  end;
end;

procedure TC018FInfoRichiesta.Apri1Click(Sender: TObject);
// apre il documento allegato utilizzando la shellexecute
var
  LId: Integer;
  LC021DM:TC021FDocumentiManagerDM;
  LDoc: TDocumento;
  LResCtrl: TResCtrl;
begin
  // estrae id allegato
  LId:=dgrdDocumenti.DataSource.DataSet.FieldByName('ID_ALLEGATO').AsInteger;

  // se l'id non è valido esce immediatamente
  if LId <= 0 then
    Exit;

  // estrae info documento da db
  Screen.Cursor:=crHourGlass;
  LC021DM:=TC021FDocumentiManagerDM.Create(nil);
  try
    try
      // estrae il file con i metadati associati
      LResCtrl:=LC021DM.GetById(LId,True,LDoc);

      if not LResCtrl.Ok then
      begin
        R180MessageBox(LResCtrl.Messaggio,ESCLAMA);
        Exit;
      end;

      // apre il documento con il visualizzatore associato
      ShellExecute(0,'open',PChar(LDoc.FilePath),nil,nil,SW_SHOWNORMAL);
    except
      on E: Exception do
      begin
        R180MessageBox(Format('Errore durante l''apertura dell''allegato: %s',[E.Message]),ESCLAMA);
        Exit;
      end;
    end;
  finally
    FreeAndNil(LDoc);
    FreeAndNil(LC021DM);
    Screen.Cursor:=crDefault;
  end;
end;

procedure TC018FInfoRichiesta.Salva1Click(Sender: TObject);
// effettua il download dell'allegato
var
  LId: Integer;
  LC021DM:TC021FDocumentiManagerDM;
  LDoc: TDocumento;
  LFileName: String;
  LResCtrl: TResCtrl;
begin
  // estrae id allegato
  LId:=dgrdDocumenti.DataSource.DataSet.FieldByName('ID_ALLEGATO').AsInteger;

  // se l'id non è valido esce immediatamente
  if LId <= 0 then
    Exit;

  // estrae info documento da db
  Screen.Cursor:=crHourGlass;
  LC021DM:=TC021FDocumentiManagerDM.Create(nil);
  try
    try
      // estrae il file con i metadati associati
      LResCtrl:=LC021DM.GetById(LId,True,LDoc);

      if not LResCtrl.Ok then
      begin
        R180MessageBox(LResCtrl.Messaggio,ESCLAMA);
        Exit;
      end;

      // dialog per richiesta destinazione file
      {$WARN SYMBOL_PLATFORM OFF}
      dlgFileSave.Title:='Selezionare destinazione';
      //dlgFileSave.DefaultFolder:=edtHome.Text;
      dlgFileSave.FileName:=LDoc.GetNomeFileCompleto;
      if dlgFileSave.Execute then
      begin
        // il file è stato selezionato
        LFileName:=dlgFileSave.FileName;
        // cancella eventuale file già esistente
        if TFile.Exists(LFileName) then
          TFile.Delete(LFileName);
        TFile.Move(LDoc.FilePath,LFileName);
      end;
      {$WARN SYMBOL_PLATFORM ON}
    except
      on E: Exception do
      begin
        R180MessageBox(Format('Errore durante il salvataggio dell''allegato: %s',[E.Message]),ESCLAMA);
        Exit;
      end;
    end;
  finally
    FreeAndNil(LDoc);
    FreeAndNil(LC021DM);
    Screen.Cursor:=crDefault;
  end;
end;

end.
