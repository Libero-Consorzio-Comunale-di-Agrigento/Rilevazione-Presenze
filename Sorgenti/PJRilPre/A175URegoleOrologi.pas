unit A175URegoleOrologi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R004UGestStorico, System.Actions, Vcl.ActnList, Vcl.ImgList,
  Data.DB, Vcl.Menus, Vcl.StdCtrls,Vcl.ComCtrls, Vcl.ToolWin, Vcl.Mask, Vcl.DBCtrls, Vcl.Buttons,
  A175URegoleOrologiDM, A175URegoleOrologiMW, Vcl.Grids, Vcl.DBGrids, C600USelAnagrafe, A000UInterfaccia,
  C013UCheckList, C180FunzioniGenerali, Vcl.ExtCtrls, ToolbarFiglio, A000USessione;

type
  TA175FRegoleOrologi = class(TR004FGestStorico)
    dbgT362: TDBGrid;
    dbgT363: TDBGrid;
    Splitter1: TSplitter;
    frmToolbarFiglio: TfrmToolbarFiglio;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbgT362EditButtonClick(Sender: TObject);
    procedure dbgT363EditButtonClick(Sender: TObject);
  private
    C600frmSelAnagrafe: TC600frmSelAnagrafe;
  public
    { Public declarations }
  end;

const
  LUNGHEZZA = 5;
  IDX_COLONNA_RILEVATORE = 0;
  IDX_COLONNA_GG = 1;

var
  A175FRegoleOrologi: TA175FRegoleOrologi;

procedure OpenA175RegoleOrologi;

implementation

{$R *.dfm}

procedure OpenA175RegoleOrologi;
begin
  SolaLettura:=False;
  SolaLetturaOriginale:=SolaLettura;
  case A000GetInibizioni('Funzione','OpenA175RegoleOrologi') of
    'N':begin
          ShowMessage('Funzione non abilitata!');
          Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Screen.Cursor:=crHourglass;
  Application.CreateForm(TA175FRegoleOrologi, A175FRegoleOrologi);
  Application.CreateForm(TA175FRegoleOrologiDM, A175FRegoleOrologiDM);
  try
    Screen.Cursor:=crDefault;
    A175FRegoleOrologi.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A175FRegoleOrologi.Free;
    A175FRegoleOrologiDM.Free;
  end;
end;

procedure TA175FRegoleOrologi.FormShow(Sender: TObject);
begin
  inherited;
  //inizializzazione ToolbarFiglio
  frmToolbarFiglio.TFDButton:=A175FRegoleOrologiDM.dsrSelT363;
  frmToolbarFiglio.TFDBGrid:=dbgT363;
  frmToolbarFiglio.tlbarFiglio.HandleNeeded;  //necessario per XE3
  frmToolbarFiglio.ConfermaCancella:=False; //frmToolbarFiglio.TFDButton.OnStateChange:=frmToolbarFiglio.DButtonStateChange;  //Per gestire i pulsanti quando CachedUpdate:=False; (si considera lo state della singola riga invece che tutta l'operazione di inserimento/modifica)
  SetLength(frmToolbarFiglio.lstLock,LUNGHEZZA);
  //frmToolbarFiglio.lstLock[0]:=Panel1;  //frmToolbarFiglio.lstLock[3]:=frmSelAnagrafe;
  frmToolbarFiglio.lstLock[0]:=File1;
  frmToolbarFiglio.lstLock[1]:=Strumenti1;
  frmToolbarFiglio.lstLock[2]:=ToolBar1;
  frmToolbarFiglio.lstLock[3]:=grbDecorrenza;
  frmToolbarFiglio.lstLock[4]:=dbgT362;
  frmToolbarFiglio.AbilitaAzioniTF(nil);
  //inizializzazione C600
  C600frmSelAnagrafe:=TC600frmSelAnagrafe.Create(nil);
  C600frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,nil,0,False);
  C600frmSelAnagrafe.C600DataLavoro:=Parametri.DataLavoro;
  C600frmSelAnagrafe.C600Progressivo:=0;
  //creazione picklist per colonna 'RILEVATORE' T362
  A175FRegoleOrologiDM.A175MW.selT361.First;
  while not A175FRegoleOrologiDM.A175MW.selT361.Eof do
  begin
    dbgT362.Columns[IDX_COLONNA_RILEVATORE].PickList.Add(A175FRegoleOrologiDM.A175MW.selT361.FieldByName('CODICE').AsString);
    A175FRegoleOrologiDM.A175MW.selT361.Next;
  end;
  //creazione picklist per colonna 'GG' T363
  dbgT363.Columns[IDX_COLONNA_GG].PickList.CommaText:=Giorni;
end;

procedure TA175FRegoleOrologi.FormDestroy(Sender: TObject);
begin
  inherited;
  C600frmSelAnagrafe.DistruggiSelAnagrafe;
  FreeAndNil(C600frmSelAnagrafe);
end;

procedure TA175FRegoleOrologi.dbgT362EditButtonClick(Sender: TObject);
var
  S: String;
begin
  inherited;
  if dbgT362.SelectedField.FieldName = 'FILTRO_ANAGRAFE' then
  //apertura della c600 per selezione anagrafe
  begin
    C600frmSelAnagrafe.C600DataLavoro:=Parametri.DataLavoro;
    C600frmSelAnagrafe.C600DatiVisualizzati:='';
    if dbgT362.DataSource.DataSet.FieldByName('FILTRO_ANAGRAFE').AsString.Trim <> '' then
    begin
      C600frmSelAnagrafe.C600FSelezioneAnagrafe.actAnnullaSelezioneExecute(nil);
      C600frmSelAnagrafe.C600FSelezioneAnagrafe.SQLCreato.Text:=dbgT362.DataSource.DataSet.FieldByName('FILTRO_ANAGRAFE').AsString.Trim;
      C600frmSelAnagrafe.C600FSelezioneAnagrafe.PulisciVecchiaSelezione:=False;
      C600frmSelAnagrafe.C600FSelezioneAnagrafe.actConfermaExecute(nil);
    end
    else
    begin
      C600frmSelAnagrafe.C600FSelezioneAnagrafe.PulisciVecchiaSelezione:=True;
      C600frmSelAnagrafe.C600FSelezioneAnagrafe.actAnnullaSelezioneExecute(C600frmSelAnagrafe.C600FSelezioneAnagrafe.actAnnullaSelezione);
    end;
    C600frmSelAnagrafe.btnSelezioneClick(Sender);
    if C600frmSelAnagrafe.C600ModalResult = mrOK then
    begin
      if (A175FRegoleOrologiDM.selT362.State in [dsInsert,dsEdit]) then
      begin
        S:=C600frmSelAnagrafe.C600FSelezioneAnagrafe.SQLCreato.Text.Trim;
        if Pos('ORDER BY',UpperCase(S)) > 0 then
          S:=Copy(S,1,Pos('ORDER BY',S.ToUpper) - 1);
        dbgT362.DataSource.DataSet.FieldByName('FILTRO_ANAGRAFE').AsString:=S.Trim;
      end;
    end;
  end
  else if dbgT362.SelectedField.FieldName = 'CAUSALI_ABILITATE' then
  begin
  //utilizzo della c013 per selezionare in una maschera apposita le causali
    if not (A175FRegoleOrologiDM.selT362.State in [dsInsert,dsEdit]) then
      Exit;
    C013FCheckList:=TC013FCheckList.Create(nil);
    C013FCheckList.clbListaDati.Items.Add(Format('%-*s %s',[LUNGHEZZA,'*','Tutte le causali']));
    C013FCheckList.clbListaDati.Items.Add(Format('%-*s %s',[LUNGHEZZA,'-','Causale nulla']));
    A175FRegoleOrologiDM.A175MW.selT275.First;
    try
      while not A175FRegoleOrologiDM.A175MW.selT275.Eof do
      begin
        C013FCheckList.clbListaDati.Items.Add(Format('%-*s %s',[LUNGHEZZA,A175FRegoleOrologiDM.A175MW.selT275.FieldByName('CODICE').AsString,A175FRegoleOrologiDM.A175MW.selT275.FieldByName('DESCRIZIONE').AsString]));
        A175FRegoleOrologiDM.A175MW.selT275.Next;
      end;
      R180PutCheckList(dbgT362.DataSource.DataSet.FieldByName('CAUSALI_ABILITATE').AsString,LUNGHEZZA,C013FCheckList.clbListaDati);
      if C013FCheckList.ShowModal = mrOK then
        dbgT362.DataSource.DataSet.FieldByName('CAUSALI_ABILITATE').AsString:=R180GetCheckList(LUNGHEZZA,C013FCheckList.clbListaDati);
    finally
      FreeAndNil(C013FCheckList);
    end;
  end;
end;

procedure TA175FRegoleOrologi.dbgT363EditButtonClick(Sender: TObject);
//per la colonna CAUSALI_ABILITATE
begin
  inherited;
  if not (A175FRegoleOrologiDM.selT363.State in [dsInsert,dsEdit]) then
    Exit;
  //utilizzo della c013 per selezionare in una maschera apposita le causali
  C013FCheckList:=TC013FCheckList.Create(nil);
  C013FCheckList.clbListaDati.Items.Add(Format('%-*s %s',[LUNGHEZZA,'*','Tutte le causali']));
  C013FCheckList.clbListaDati.Items.Add(Format('%-*s %s',[LUNGHEZZA,'-','Causale nulla']));
  A175FRegoleOrologiDM.A175MW.selT275.First;
  try
    while not A175FRegoleOrologiDM.A175MW.selT275.Eof do
    begin
      C013FCheckList.clbListaDati.Items.Add(Format('%-*s %s',[LUNGHEZZA,A175FRegoleOrologiDM.A175MW.selT275.FieldByName('CODICE').AsString,A175FRegoleOrologiDM.A175MW.selT275.FieldByName('DESCRIZIONE').AsString]));
      A175FRegoleOrologiDM.A175MW.selT275.Next;
    end;
    R180PutCheckList(dbgT363.DataSource.DataSet.FieldByName('CAUSALI_ABILITATE').AsString,LUNGHEZZA,C013FCheckList.clbListaDati);
    if C013FCheckList.ShowModal = mrOK then
      dbgT363.DataSource.DataSet.FieldByName('CAUSALI_ABILITATE').AsString:=R180GetCheckList(LUNGHEZZA,C013FCheckList.clbListaDati);
  finally
    FreeAndNil(C013FCheckList);
  end;
end;

end.
