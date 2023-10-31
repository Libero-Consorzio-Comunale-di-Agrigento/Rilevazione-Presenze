unit A178UPianifPersConv;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, Menus, StdCtrls, Mask, DBCtrls, Buttons, ExtCtrls, ComCtrls,
  R004UGestStorico, R004UGestStoricoDtM, ImgList, ToolWin, ActnList,
  A000UCostanti, A000USessione, A000UInterfaccia, A003UDataLavoroBis, C180FUNZIONIGENERALI,
  C700USelezioneAnagrafe, C013UCheckList,
  Variants, Grids, DBGrids, System.Actions, System.ImageList, SelAnagrafe,
  ToolbarFiglio;

type
  TA178FPianifPersConv = class(TR004FGestStorico)
    dgrdTestata: TDBGrid;
    pmnNuovaVoceAggiuntiva: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    frmSelAnagrafe: TfrmSelAnagrafe;
    frmToolbarFiglio: TfrmToolbarFiglio;
    dgrdDettaglio: TDBGrid;
    Splitter1: TSplitter;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnStoricizzaClick(Sender: TObject);
    procedure dgrdDettaglioEditButtonClick(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure actBrowseExecute(Sender: TObject);
  private
    {Private declarations}
    procedure CambiaProgressivo;
  public
    { Public declarations }
  end;

var
  A178FPianifPersConv: TA178FPianifPersConv;

procedure OpenA178PianifPersConv(Prog:LongInt);

implementation

uses A178UPianifPersConvDtM;

{$R *.DFM}

procedure OpenA178PianifPersConv(Prog:LongInt);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA178PianifPersConv') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Application.CreateForm(TA178FPianifPersConv, A178FPianifPersConv);
  C700Progressivo:=Prog;
  Application.CreateForm(TA178FPianifPersConvDtM, A178FPianifPersConvDtM);
  try
    A178FPianifPersConv.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A178FPianifPersConv.Free;
    A178FPianifPersConvDtM.Free;
  end;
end;

procedure TA178FPianifPersConv.actBrowseExecute(Sender: TObject);
begin
  inherited;
  if Sender = actPrimo then
    DButton.DataSet.First
  else if Sender = actPrecedente then
    DButton.DataSet.Prior
  else if Sender = actSuccessivo then
    DButton.DataSet.Next
  else if Sender = actUltimo then
    DButton.DataSet.Last;
end;

procedure TA178FPianifPersConv.btnStoricizzaClick(Sender: TObject);
begin
  A178FPianifPersConvDtM.A178MW.IDStoricizzato:=A178FPianifPersConvDtM.selT420.FieldByName('ID').AsInteger;
  inherited;
  A178FPianifPersConvDtM.selT420.FieldByName('ID').Clear;
end;

procedure TA178FPianifPersConv.CambiaProgressivo;
begin
  with A178FPianifPersConvDtM.selT420 do
  try
    DisableControls;
    Close;
    SetVariable('Progressivo',C700Progressivo);
    Open;
    while not Eof do
    try
      if Parametri.DataLavoro < FieldByName('DECORRENZA').AsDateTime then
        Break;
      if R180Between(Parametri.DataLavoro,FieldByName('DECORRENZA').AsDateTime,FieldByName('DECORRENZA_FINE').AsDateTime) then
        Break;
    finally
      Next;
    end;
  finally
    EnableControls;
  end;
end;

procedure TA178FPianifPersConv.DButtonStateChange(Sender: TObject);
begin
  inherited;
  A178FPianifPersConvDtM.dsrT421.AutoEdit:=DButton.State = dsBrowse;
  A178FPianifPersConvDtM.selT421.ReadOnly:=DButton.State in [dsEdit,dsInsert];
end;

procedure TA178FPianifPersConv.dgrdDettaglioEditButtonClick(Sender: TObject);
begin
  inherited;
  if A178FPianifPersConvDtM.selT421.State in [dsBrowse] then
    A178FPianifPersConvDtM.selT421.Edit;
  C013FCheckList:=TC013FCheckList.Create(nil);
  C013FCheckList.Caption:='Elenco responsabili';
  with A178FPianifPersConvDtM.A178MW do
  begin
    selI095.First;
    try
      while not selI095.Eof do
      begin
        C013FCheckList.clbListaDati.Items.Add(selI095.FieldByName('COD_ITER').AsString);
        selI095.Next;
      end;
      R180PutCheckList(A178FPianifPersConvDtM.selT421.FieldByName('RESPONSABILI_CC').AsString,30,C013FCheckList.clbListaDati);
      if C013FCheckList.ShowModal = mrOK then
        A178FPianifPersConvDtM.selT421.FieldByName('RESPONSABILI_CC').AsString:=R180GetCheckList(30,C013FCheckList.clbListaDati);
    finally
      FreeAndNil(C013FCheckList);
    end;
  end;
end;

procedure TA178FPianifPersConv.FormDestroy(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA178FPianifPersConv.FormShow(Sender: TObject);
begin
  inherited;
  frmToolbarFiglio.TFDButton:=A178FPianifPersConvDtM.dsrT421;
  frmToolbarFiglio.TFDBGrid:=dgrdDettaglio;
  frmToolbarFiglio.RefreshDopoPost:=True;
  SetLength(frmToolbarFiglio.lstLock,5);
  frmToolbarFiglio.lstLock[0]:=ToolBar1;
  frmToolbarFiglio.lstLock[1]:=grbDecorrenza;
  frmToolbarFiglio.lstLock[2]:=File1;
  frmToolbarFiglio.lstLock[3]:=Strumenti1;
  frmToolbarFiglio.lstLock[4]:=frmSelAnagrafe;
  frmToolbarFiglio.AbilitaAzioniTF(nil);

  DButton.DataSet:=A178FPianifPersConvDtM.selT420;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(A178FPianifPersConvDtM.A178MW,SessioneOracle,StatusBar,3,True);
  frmSelAnagrafe.NumRecords;

  dgrdDettaglio.Columns.Items[7].PickList.Clear;
  with A178FPianifPersConvDtM.A178MW do
  begin
    selI095.First;
    while not selI095.Eof do
    begin
      dgrdDettaglio.Columns.Items[7].PickList.Add(selI095.FieldByName('COD_ITER').AsString);
      selI095.Next;
    end;
  end;

  dgrdDettaglio.Columns.Items[6].PickList.Clear;
  with A178FPianifPersConvDtM.A178MW do
  begin
    if selCdcPersConv.Active then
    begin
      selT421.FieldByName('STRUTTURA').DisplayLabel:=R180Capitalize(Parametri.CampiRiferimento.C13_CdcPersConv);
      selCdcPersConv.First;
      while not selCdcPersConv.Eof do
      begin
        dgrdDettaglio.Columns.Items[6].PickList.Add(selCdcPersConv.FieldByName('CODICE').AsString);
        selCdcPersConv.Next;
      end;
    end;
  end;

end;

end.
