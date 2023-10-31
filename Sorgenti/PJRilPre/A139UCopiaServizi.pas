unit A139UCopiaServizi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ExtCtrls, StdCtrls, Buttons, Mask, DBCtrls,
  C180FunzioniGenerali, C700USelezioneAnagrafe;

type
  TA139FCopiaServizi = class(TForm)
    DBGrid1: TDBGrid;
    PnlTop: TPanel;
    btnConferma: TSpeedButton;
    btnEsci1: TSpeedButton;
    Data: TLabel;
    LblTTurno: TLabel;
    LblComandato: TLabel;
    LblNome: TLabel;
    edtComandato: TEdit;
    edtNome: TEdit;
    EdtDataOrigine: TDBEdit;
    PnlBottom: TPanel;
    btnCancella: TSpeedButton;
    btnEsci2: TSpeedButton;
    LblData2: TLabel;
    EdtData: TMaskEdit;
    btnDuplica: TButton;
    EdtTTurno: TDBEdit;
    chkServizi: TCheckBox;
    chkNoteServizi: TCheckBox;
    chkApparati: TCheckBox;
    chkOrari: TCheckBox;
    chkPattuglie: TCheckBox;
    chkNominativi: TCheckBox;
    chkServiziStraordinari: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure btnEsci1Click(Sender: TObject);
    procedure btnConfermaClick(Sender: TObject);
    procedure btnDuplicaClick(Sender: TObject);
    procedure btnCancellaClick(Sender: TObject);
    procedure chkNoteServiziClick(Sender: TObject);
    procedure chkServiziClick(Sender: TObject);
    procedure chkNominativiClick(Sender: TObject);
    procedure chkPattuglieClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Azione:String;
  end;

var
  A139FCopiaServizi: TA139FCopiaServizi;

implementation

uses A139UPianifServiziDtm, A139UPianifServizi;

{$R *.dfm}

procedure TA139FCopiaServizi.btnCancellaClick(Sender: TObject);
begin
  if R180MessageBox('Confermi la cancellazione del modello?',DOMANDA) = mrYes then
    A139FPianifServiziDtm.selT520.Delete;
end;

procedure TA139FCopiaServizi.btnConfermaClick(Sender: TObject);
begin
  if EdtNome.Text = '' then
    Exit;
  with A139FPianifServiziDtm do
  begin
    InsT520.SetVariable('DATA',selT500.FieldByName('DATA').AsDateTime);
    InsT520.SetVariable('TIPO_TURNO',selT500.FieldByName('TIPO_TURNO').AsString);
    InsT520.SetVariable('NOME',UpperCase(EdtNome.Text));
    InsT520.SetVariable('COMANDATO',EdtComandato.Text);
    InsT520.Execute;
    InsT520.Session.Commit;
  end;
  A139FCopiaServizi.Close;
end;

procedure TA139FCopiaServizi.btnDuplicaClick(Sender: TObject);
var Msg:String;
    TempPattuglia:Integer;
begin
  try
    StrToDate(EdtData.Text);
  except
    R180MessageBox('Data non valida.' + #13#10 + 'Copia fallita!','ERRORE');
    Exit;
  end;
  with A139FPianifServiziDtm do
  begin
    if StrToDate(EdtData.Text) = selT520.FieldByName('DATA').AsDateTime then
    begin
      R180MessageBox('La data su cui effettuare la copia deve essere diversa da quella selezionata. ' + #13#10 + 'Copia fallita!','ERRORE');
      Exit;
    end;
    //==================================================
    //CONTROLLO SE SONO PRESENTI RECORD SULLA NUOVA DATA
    //==================================================
    //Attenzione: CopiaSelT500 è filtrato sull'evento OnFiltereRecord 
    CopiaSelT500.Close;
    CopiaSelT500.SQL.Assign(selT500.SQL);
    CopiaSelT500.Variables.Assign(selT500.Variables);
    CopiaSelT500.SetVariable('DATA1',StrToDate(EdtData.Text));
    CopiaSelT500.SetVariable('DATA2',StrToDate(EdtData.Text));
    C700MergeSettaPeriodo(CopiaSelT500,StrToDate(EdtData.Text),StrToDate(EdtData.Text));
    Screen.Cursor:=crHourGlass;
    try
      CopiaSelT500.Open;
    finally
      Screen.Cursor:=crDefault;
    end;
    if CopiaSelT500.RecordCount > 0 then
      if R180MessageBox('Esistono già ' + IntToStr(CopiaSelT500.RecordCount) + ' pianificazioni con i parametri specificati: effettuare comunque la copia?','DOMANDA') = mrNo then
        Exit;
    //==================================================
    CopiaSelT500.Close;
    CopiaSelT500.SetVariable('DATA1',selT520.FieldByName('DATA').AsDateTime);
    CopiaSelT500.SetVariable('DATA2',selT520.FieldByName('DATA').AsDateTime);
    C700MergeSettaPeriodo(CopiaSelT500,selT520.FieldByName('DATA').AsDateTime,selT520.FieldByName('DATA').AsDateTime);
    Screen.Cursor:=crHourGlass;
    try
      CopiaSelT500.Open;
    finally
      Screen.Cursor:=crDefault;
    end;
    Msg:='Verrà copiata la pianificazione del giorno ' + selT520.FieldByName('DATA').AsString;
    Msg:=Msg + ' sul giorno ' + EdtData.Text + '.' + #13#10 + 'Le pianificazioni inserite saranno ';
    Msg:=Msg + IntToStr(CopiaSelT500.RecordCount) + '. Confermare?';
    if R180MessageBox(Msg,'DOMANDA') = mrNo then
      Exit;
    //selT500DATA.OnValidate:=nil;
    while not CopiaSelT500.Eof do
    begin
      if (CopiaSelT500.FieldByName('CAUSALE').AsString <> '') and (not chkServiziStraordinari.Checked) then
      begin
        CopiaSelT500.Next;
        Continue;
      end;
      TempPattuglia:=GeneraPattuglia(StrToDate(EdtData.Text));
      InsT500.SetVariable('ORDINE',CopiaSelT500.FieldByName('ORDINE').AsString);
      InsT500.SetVariable('COMANDATO',CopiaSelT500.FieldByName('COMANDATO').AsString);
      InsT500.SetVariable('TIPO_TURNO',CopiaSelT500.FieldByName('TIPO_TURNO').AsString);
      InsT500.SetVariable('PATTUGLIA',TempPattuglia);
      InsT500.SetVariable('DATA',StrToDate(EdtData.Text));
      if chkServizi.Checked then
        InsT500.SetVariable('SERVIZIO',CopiaSelT500.FieldByName('SERVIZIO').AsString);
      if chkNoteServizi.Checked then
        InsT500.SetVariable('NOTE_SERVIZIO',CopiaSelT500.FieldByName('NOTE_SERVIZIO').AsString);
      if chkOrari.Checked then
      begin
        InsT500.SetVariable('DALLE',CopiaSelT500.FieldByName('DALLE').AsString);
        InsT500.SetVariable('ALLE',CopiaSelT500.FieldByName('ALLE').AsString);
      end;
      if CopiaSelT500.FieldByName('CAUSALE').AsString <> '' then
        InsT500.SetVariable('CAUSALE',CopiaSelT500.FieldByName('CAUSALE').AsString)
      else
        InsT500.SetVariable('CAUSALE',Null);
      InsT500.Execute;
      A139FPianifServiziDtm.OpenT502(CopiaSelT500.FieldByName('PATTUGLIA').AsInteger,CopiaSelT500.FieldByName('DATA').AsDateTime);
      selT502.First;
      while Not(selT502.Eof) do
      begin
        InsT502.ClearVariables;
        InsT502.SetVariable('PATTUGLIA',TempPattuglia);
        InsT502.SetVariable('DATA',StrToDate(EdtData.Text));
        if chkPattuglie.Checked then
        begin
          InsT502.SetVariable('CAMPO1',selT502.FieldByName('CAMPO1').AsString);
          InsT502.SetVariable('CAMPO2',selT502.FieldByName('CAMPO2').AsString);
        end;
        if chkNominativi.Checked then
          InsT502.SetVariable('PROGRESSIVO',selT502.FieldByName('PROGRESSIVO').AsInteger)
        else
          InsT502.SetVariable('PROGRESSIVO',A139FPianifServiziDtm.GeneraProg(StrToDate(EdtData.Text)));
        InsT502.Execute;
        if chkPattuglie.Checked then
          selT502.Next
        else
          Break;
      end;
      if chkApparati.Checked then
      begin
        OpenT501(CopiaSelT500.Name);
        while Not selT501.Eof do
        begin
          InsT501.SetVariable('PATTUGLIA',TempPattuglia);
          InsT501.SetVariable('DATA',StrToDate(EdtData.Text));
          InsT501.SetVariable('TIPO',selT501.FieldByName('TIPO').AsString);
          InsT501.SetVariable('CODICE',selT501.FieldByName('CODICE').AsString);
          InsT501.Execute;
          selT501.Next;
        end;
      end;
      CopiaSelT500.Next;
    end;
    CopiaSelT500.Close;
    InsT500.Session.Commit;
    OpenT500;
    R180MessageBox('Copia effettuata.','INFORMA');
  end;
end;

procedure TA139FCopiaServizi.btnEsci1Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TA139FCopiaServizi.chkNominativiClick(Sender: TObject);
begin
  if chkNominativi.Checked then
    chkPattuglie.Checked:=True;
end;

procedure TA139FCopiaServizi.chkNoteServiziClick(Sender: TObject);
begin
  if chkNoteServizi.Checked then
    chkServizi.Checked:=True;
end;

procedure TA139FCopiaServizi.chkPattuglieClick(Sender: TObject);
begin
  if not chkPattuglie.Checked then
    chkNominativi.Checked:=False;
end;

procedure TA139FCopiaServizi.chkServiziClick(Sender: TObject);
begin
  if not chkServizi.Checked then
    chkNoteServizi.Checked:=False;
end;

procedure TA139FCopiaServizi.FormShow(Sender: TObject);
var Comandato:String;
begin
  if Azione = 'I' then
  begin
    //Operazioni di inserimento
    PnlBottom.Visible:=False;
    if A139FPianifServizi.btnServiziComandati.Down then
      Comandato:='S'
    else
      Comandato:='N';
    EdtComandato.Text:=Comandato;
  end
  else if Azione = 'M' then
  begin
    //Operazioni di copia
    PnlTop.Visible:=False;
    if not A139FPianifServiziDtm.selT500.FieldByName('DATA').IsNull then
      edtData.Text:=A139FPianifServiziDtm.selT500.FieldByName('DATA').AsString
    else
      edtData.Text:=A139FPianifServizi.edtDataA.Text;
  end;
  with A139FPianifServiziDtm do
  begin
    selT520.Close;
    if A139FPianifServizi.btnServiziComandati.Down then
      selT520.SetVariable('COMANDATO','S')
    else
      selT520.SetVariable('COMANDATO','N');
    selT520.Open;
    BtnDuplica.Enabled:=selT520.RecordCOunt > 0;
  end;
end;

end.
