unit C020UVisualizzaDataSet;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, StrUtils, System.Classes,
  {$IFDEF MSWINDOWS} Winapi.ShellAPI, {$ENDIF MSWINDOWS} Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient, Data.DB, Vcl.Menus, System.Actions,
  Vcl.ActnList, C180FunzioniGenerali, OracleData, A000UInterfaccia;

type
  TC020FVisualizzaDataSet = class(TForm)
    pnlBotttom: TPanel;
    btnChiudi: TBitBtn;
    dGrdVisualizzazione: TDBGrid;
    dsrGenerico: TDataSource;
    ppMnu: TPopupMenu;
    ActionList1: TActionList;
    actRicercaTestoContenuto: TAction;
    actSuccessivo: TAction;
    actRicercaTestoContenuto1: TMenuItem;
    actSuccessivo1: TMenuItem;
    N1: TMenuItem;
    actSelezionaTutto: TAction;
    actDeselezionaTutto: TAction;
    actInvertiSelezione: TAction;
    actCopia: TAction;
    actCopiaInExcel: TAction;
    Deselezionatatutto1: TMenuItem;
    Deselezionatatutto2: TMenuItem;
    Invertiselezione1: TMenuItem;
    N2: TMenuItem;
    Copia1: TMenuItem;
    CopiaInExcel1: TMenuItem;
    SalvaSuFile1: TMenuItem;
    SaveDialog1: TSaveDialog;
    SalvainExcel1: TMenuItem;
    actSalvaInCsv: TAction;
    SalvainCSV1: TMenuItem;
    N3: TMenuItem;
    actSalvaInExcel: TAction;
    procedure actRicercaTestoContenutoExecute(Sender: TObject);
    procedure btnChiudiClick(Sender: TObject);
    procedure actSelezionaTuttoExecute(Sender: TObject);
    procedure actDeselezionaTuttoExecute(Sender: TObject);
    procedure actInvertiSelezioneExecute(Sender: TObject);
    procedure actCopiaExecute(Sender: TObject);
    procedure actCopiaInExcelExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dGrdVisualizzazioneTitleClick(Column: TColumn);
    procedure actSalvaSuFileExecute(Sender: TObject);
    procedure ppMnuPopup(Sender: TObject);
  private
    { Private declarations }
    TestoContenuto, UltimaColonna:string;
    procedure SalvaSuFile(Formato: String; Estensione: String);
  public
    { Public declarations }
  end;

var
  C020FVisualizzaDataSet: TC020FVisualizzaDataSet;

procedure OpenC020VisualizzaDataSet(inCaption:string; inDts:TDataSet; inW:integer; inH:integer); overload;

implementation

{$R *.dfm}

procedure OpenC020VisualizzaDataSet(inCaption:string; inDts:TDataSet; inW:integer; inH:integer);
begin
  C020FVisualizzaDataSet:=TC020FVisualizzaDataSet.Create(nil);
  try
    C020FVisualizzaDataSet.Height:=inH;
    C020FVisualizzaDataSet.Width:=inW;
    C020FVisualizzaDataSet.Caption:=inCaption;
    C020FVisualizzaDataSet.dsrGenerico.DataSet:=inDts;
    C020FVisualizzaDataSet.ShowModal;
  finally
    FreeAndNil(C020FVisualizzaDataSet);
  end;
end;

procedure TC020FVisualizzaDataSet.actCopiaExecute(Sender: TObject);
begin
  R180DBGridCopyToClipboard(dGrdVisualizzazione,Sender = actCopiaInExcel);
end;

procedure TC020FVisualizzaDataSet.actCopiaInExcelExecute(Sender: TObject);
begin
  R180DBGridCopyToClipboard(dGrdVisualizzazione,Sender = actCopiaInExcel);
end;

procedure TC020FVisualizzaDataSet.actDeselezionaTuttoExecute(Sender: TObject);
begin
  R180DBGridSelezionaRighe(dGrdVisualizzazione,'N');
end;

procedure TC020FVisualizzaDataSet.actInvertiSelezioneExecute(Sender: TObject);
begin
  R180DBGridSelezionaRighe(dGrdVisualizzazione,'C');
end;

procedure TC020FVisualizzaDataSet.actRicercaTestoContenutoExecute(Sender: TObject);
var
  Trovato:integer;
begin
  if (Sender = actRicercaTestoContenuto) or (TestoContenuto = '') then
  begin
    TestoContenuto:=UpperCase(dsrGenerico.DataSet.FieldByName(dGrdVisualizzazione.Columns[dGrdVisualizzazione.SelectedIndex].FieldName).AsString);
    if InputQuery('Ricerca per testo contenuto',dGrdVisualizzazione.Columns[dGrdVisualizzazione.SelectedIndex].FieldName,TestoContenuto) then
    begin
      Trovato:=0;
      dsrGenerico.DataSet.DisableControls;
      while (not dsrGenerico.DataSet.Eof) and (Trovato = 0) do
      begin
        Trovato:=Pos(UpperCase(TestoContenuto),UpperCase(dsrGenerico.DataSet.FieldByName(dGrdVisualizzazione.Columns[dGrdVisualizzazione.SelectedIndex].FieldName).AsString));
        if Trovato = 0 then
          dsrGenerico.DataSet.Next;
      end;
      if Trovato = 0 then
      begin
        ShowMessage('Il testo "' + UpperCase(TestoContenuto) + '" non è contenuto in nessun elemento della colonna "' +
          dGrdVisualizzazione.Columns[dGrdVisualizzazione.SelectedIndex].FieldName +'"');
        dsrGenerico.DataSet.First;
      end;
      dsrGenerico.DataSet.EnableControls;
    end;
  end
  else
  begin
    Trovato:=0;
    dsrGenerico.DataSet.DisableControls;
    while (not dsrGenerico.DataSet.Eof) and (Trovato = 0) do
    begin
      if Trovato = 0 then
        dsrGenerico.DataSet.Next;
      Trovato:=Pos(UpperCase(TestoContenuto),UpperCase(dsrGenerico.DataSet.FieldByName(dGrdVisualizzazione.Columns[dGrdVisualizzazione.SelectedIndex].FieldName).AsString));
    end;
    if Trovato = 0 then
    begin
      ShowMessage('Il testo "' + UpperCase(TestoContenuto) + '" non è contenuto in nessun altro elemento della colonna "' +
        dGrdVisualizzazione.Columns[dGrdVisualizzazione.SelectedIndex].FieldName +'"');
      dsrGenerico.DataSet.First;
    end;
    dsrGenerico.DataSet.EnableControls;
  end;
end;

procedure TC020FVisualizzaDataSet.actSalvaSuFileExecute(Sender: TObject);
begin
    if Sender = actSalvaInExcel then
      SalvaSuFile('File Excel', '.xlsx')
    else if Sender = actSalvaInCsv then
      SalvaSuFile('File CSV', '.csv');
end;

procedure TC020FVisualizzaDataSet.SalvaSuFile(Formato: String; Estensione: String);
var
  Preference: Integer;
  NomeFile: String;
begin
  SaveDialog1.Filter:=Formato + '|*' + Estensione;
  SaveDialog1.DefaultExt:=Estensione;
  SaveDialog1.InitialDir:=ExtractFilePath(Application.ExeName) + 'Archivi\Temp';
  DateTimeToString(NomeFile, 'dd-mm-yy_hh-nn-ss', Now);
  SaveDialog1.FileName:='Esportazione_' + NomeFile;
  if not SaveDialog1.Execute then
    Exit;
  if ContainsText(LowerCase(SaveDialog1.Filter), 'xlsx') then
  begin
    if ExtractFileExt(SaveDialog1.FileName) <> '.xlsx' then
      SaveDialog1.FileName:=ChangeFileExt(SaveDialog1.FileName, '.xlsx');
    R180DBGridToXlsx(SessioneOracle,dGrdVisualizzazione,SaveDialog1.FileName);
  end
  else if ContainsText(LowerCase(SaveDialog1.Filter), 'csv') then
  begin
    if ExtractFileExt(SaveDialog1.FileName) <> '.csv' then
      SaveDialog1.FileName:=ChangeFileExt(SaveDialog1.FileName, '.csv');
    R180DBGridToCsv(dGrdVisualizzazione,SaveDialog1.FileName);
  end;
  {$IFDEF MSWINDOWS}
  if FileExists(SaveDialog1.FileName) then
  begin
    Preference:=MessageDlg('Desideri aprire il file esportato?',mtConfirmation, [mbYes, mbNo], 0);
    if Preference = mrYes then
      ShellExecute(0, 'OPEN', PChar(SaveDialog1.FileName), '', '', SW_SHOWNORMAL);
  end;
  {$ENDIF MSWINDOWS}
end;

procedure TC020FVisualizzaDataSet.actSelezionaTuttoExecute(Sender: TObject);
begin
  R180DBGridSelezionaRighe(dGrdVisualizzazione,'S');
end;

procedure TC020FVisualizzaDataSet.btnChiudiClick(Sender: TObject);
begin
  Close;
end;

procedure TC020FVisualizzaDataSet.dGrdVisualizzazioneTitleClick(Column: TColumn);
var
  i:integer;
begin
  with dGrdVisualizzazione.DataSource do
    if DataSet is TClientDataSet then
    begin
      for i:=0 to dGrdVisualizzazione.Columns.Count - 1 do
        dGrdVisualizzazione.Columns[i].Title.Font.Color:=clBlue;
      Column.Title.Font.Color:=clRed;
      (DataSet as TClientDataSet).IndexDefs.Clear;
      if UltimaColonna = Column.Field.FieldName then
      begin
        (DataSet as TClientDataSet).IndexDefs.Add('INDD' + Column.Index.ToString,Column.Field.FieldName,[ixDescending]);
        (DataSet as TClientDataSet).IndexName:='INDD' + Column.Index.ToString;
        UltimaColonna:='';
      end
      else
      begin
        (DataSet as TClientDataSet).IndexDefs.Add('INDC' + Column.Index.ToString,Column.Field.FieldName,[]);
        (DataSet as TClientDataSet).IndexName:='INDC' + Column.Index.ToString;
        UltimaColonna:=Column.Field.FieldName;
      end;
    end;
end;

procedure TC020FVisualizzaDataSet.FormShow(Sender: TObject);
begin
  dGrdVisualizzazione.ReadOnly:=dGrdVisualizzazione.DataSource.DataSet is TClientDataSet;
end;

procedure TC020FVisualizzaDataSet.ppMnuPopup(Sender: TObject);
var
  State:Boolean;
  i:Integer;
begin
  State:=dGrdVisualizzazione.DataSource.DataSet.RecordCount > 0;
  for i:=0 to ActionList1.ActionCount - 1 do
  begin
    ActionList1.Actions[i].Enabled:=State;
  end;
end;

end.
