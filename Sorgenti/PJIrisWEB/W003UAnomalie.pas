unit W003UAnomalie;

interface

uses
  Classes, IWTemplateProcessorHTML, IWForm, IWAppForm, C004UParamForm,
  IWCompLabel, IWHTMLControls, Controls, IWControl, IWApplication,
  SysUtils, IWCompEdit, IWCompButton, IWCompCheckbox,
  IWBaseHTMLControl, meIWLink,
  OracleData, Graphics, meIWGrid, WC012UVisualizzaFileFM,
  C180FunzioniGenerali, R010UPaginaWeb, Rp502Pro, R500Lin, A000UInterfaccia,
  A000USessione, Variants, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWVCLBaseControl, IWBaseControl,
  Forms, IWVCLBaseContainer, IWContainer, meIWCheckBox, meIWButton,
  meIWEdit, meIWLabel, IWVCLComponent, StrUtils,
  medpIWMessageDlg, IWCompGrids, IWCompExtCtrls, meIWImageFile;

type
  TVettAnomalie = record
    Progressivo:String;
    Matricola:String;
    Badge:String;
    Nome:String;
    Livello:String;
    Data:String;
    Anomalia:String;
  end;

  TW003FAnomalie = class(TR010FPaginaWeb)
    chkLivello1: TmeIWCheckBox;
    chkLivello2: TmeIWCheckBox;
    chkLivello3: TmeIWCheckBox;
    btnEsegui: TmeIWButton;
    edtPeriodoDal: TmeIWEdit;
    edtPeriodoAl: TmeIWEdit;
    grdAnomalie: TmeIWGrid;
    lblPeriodo: TmeIWLabel;
    lblAnomalie: TmeIWLabel;
    btnEsportaInExcel: TmeIWButton;
    imgPeriodoPrec: TmeIWImageFile;
    imgPeriodoSucc: TmeIWImageFile;
    chkConsideraRichiesteIter: TmeIWCheckBox;
    btnEsportaInCSV: TmeIWButton;
    procedure btnEseguiClick(Sender: TObject);
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure grdAnomalieRenderCell(ACell: TIWGridCell; const ARow,AColumn: Integer);
    procedure grdAnomalieCellClick(ASender: TObject; const ARow, AColumn: Integer);
    procedure btnEsportaInExcelClick(Sender: TObject);
    procedure btnEsportaInCSVClick(Sender: TObject);
  private
    Lista:TStringList;
    Anom1,Anom2,Anom3:String;
    C004: TC004FParamForm;
    Dal,Al:TDateTime;
    selAnagrafe:TOracleDataSet;
    R502ProDtM1:TR502ProDtM1;
    CartellinoAbilitato:Boolean;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
  protected
    procedure RefreshPage; override;
    procedure DistruggiOggetti; override;
  public
  end;

implementation

uses W005UCartellino;

{$R *.dfm}

procedure TW003FAnomalie.IWAppFormCreate(Sender: TObject);
//var
//  i:Integer;
begin
  inherited;
  btnEsportaInExcel.Enabled:=False;
  btnEsportaInCSV.Enabled:=False;
  Dal:=R180InizioMese(Parametri.DataLavoro);
  Al:=R180FineMese(Parametri.DataLavoro);
  edtPeriodoDal.Text:=FormatDateTime('dd/mm/yyyy',Dal);
  edtPeriodoAl.Text:=FormatDateTime('dd/mm/yyyy',Al);
  grdAnomalie.Visible:=False;
  selAnagrafe:=TOracleDataSet.Create(Self);
  selAnagrafe.Session:=WR000DM.selAnagrafe.Session;
  selAnagrafe.SQL.Assign(WR000DM.selAnagrafe.SQL);
  selAnagrafe.SQL[0]:='SELECT T030.*,T480.CITTA,T480.PROVINCIA,V430.T430BADGE FROM';
  selAnagrafe.Variables.Assign(WR000DM.selAnagrafe.Variables);
  CartellinoAbilitato:=A000GetInibizioni('Funzione','OpenW005Cartellino') <> 'N';
  Anom1:='SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS';
  Anom2:='SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS';
  Anom3:='SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS';
  Lista:=TStringList.Create;

  // imposta la gestione automatica degli spostamenti di periodo
  AssegnaGestPeriodo(edtPeriodoDal,edtPeriodoAl,imgPeriodoPrec,imgPeriodoSucc);

  // gestione parametri operatore
  C004:=CreaC004(SessioneOracle,'W003',Parametri.Operatore,False);
  GetParametriFunzione;
end;

procedure TW003FAnomalie.GetParametriFunzione;
var
  SelLiv2, AbilLiv2, SelLiv3, AbilLiv3: Boolean;
  i: Integer;
begin
  // anomalie livello 1
  chkLivello1.Checked:=C004.GetParametro('chkLivello1','S') = 'S';

  // anomalie livello 2
  SelLiv2:=C004.GetParametro('chkLivello2','N') = 'S';
  if SelLiv2 then
  begin
    AbilLiv2:=False;
    for i:=1 to High(tdescanom2) do
    begin
      if A000FiltroDizionario('ANOMALIE DEI CONTEGGI','A2_' + IntToStr(i)) then
      begin
        AbilLiv2:=True;
        Break;
      end;
    end;
    SelLiv2:=SelLiv2 and AbilLiv2;
  end;
  chkLivello2.Checked:=SelLiv2;

  // anomalie livello 3
  SelLiv3:=C004.GetParametro('chkLivello3','N') = 'S';
  if SelLiv3 then
  begin
    AbilLiv3:=False;
    for i:=1 to High(tdescanom3) do
    begin
      if A000FiltroDizionario('ANOMALIE DEI CONTEGGI','A3_' + IntToStr(i)) then
      begin
        AbilLiv3:=True;
        Break;
      end;
    end;
    SelLiv3:=SelLiv3 and AbilLiv3;
  end;
  chkLivello3.Checked:=SelLiv3;
end;

procedure TW003FAnomalie.PutParametriFunzione;
begin
  C004.Cancella001;
  C004.PutParametro('chkLivello1',IfThen(chkLivello1.Checked,'S','N'));
  C004.PutParametro('chkLivello2',IfThen(chkLivello2.Checked,'S','N'));
  C004.PutParametro('chkLivello3',IfThen(chkLivello3.Checked,'S','N'));
  SessioneOracle.Commit;
end;

procedure TW003FAnomalie.RefreshPage;
begin
  if btnEsportaInExcel.Enabled then
    btnEseguiClick(nil);
end;

procedure TW003FAnomalie.btnEseguiClick(Sender: TObject);
var DataCorr:TDateTime;
    VettAnomalie:array of TVettAnomalie;
    na,j:Integer;
    S:String;
  procedure PutAnomalia(Livello:String; N:Word; Anomalia:String);
  var i:Integer;
  begin
    if (Livello = '1') and (R180CarattereDef(Anom1,N,'N') = 'N') then exit
    else if (Livello = '2') and (R180CarattereDef(Anom2,N,'N') = 'N') then exit
    else if (Livello = '3') and (R180CarattereDef(Anom3,N,'N') = 'N') then exit;
    i:=Length(VettAnomalie);
    SetLength(VettAnomalie,i + 1);
    VettAnomalie[i].Progressivo:=selAnagrafe.FieldByName('Progressivo').AsString;
    VettAnomalie[i].Matricola:=selAnagrafe.FieldByName('Matricola').AsString;
    VettAnomalie[i].Badge:=selAnagrafe.FieldByName('T430BADGE').AsString;
    VettAnomalie[i].Nome:=selAnagrafe.FieldByName('COGNOME').AsString + ' ' + selAnagrafe.FieldByName('NOME').AsString;
    VettAnomalie[i].Livello:=Livello;
    VettAnomalie[i].Data:=DateToStr(Datacorr);
    VettAnomalie[i].Anomalia:=Anomalia;
  end;
begin
  Dal:=StrToDate(edtPeriodoDal.Text);
  Al:=StrToDate(edtPeriodoAl.Text);
  R502ProDtM1:=TR502ProDtM1.Create(Self);
  R502ProDtM1.FiltroDizionarioAnomalie:=True;
  R502ProDtM1.PeriodoConteggi(Dal,Al);
  R502ProDtm1.ConsideraRichiesteWeb:=chkConsideraRichiesteIter.Checked;
  SetLength(VettAnomalie,0);
  try
    with selAnagrafe do
    begin
      SetVariable('DATALAVORO',Al);
      Close;
      Open;
      while not Eof do
      begin
        DataCorr:=Dal;
        while DataCorr <= Al do
        begin
          R502ProDtm1.Conteggi('Anomalie',FieldByName('Progressivo').AsInteger,DataCorr);
          if (R502ProDtm1.Blocca <> 0) and (chkLivello1.Checked) then
            PutAnomalia('1',R502ProDtm1.Blocca,'Anom.bloccante! ' + R502ProDtM1.DescAnomaliaBloccante);
          if chkLivello2.Checked then
          begin
            for na:=0 to High(R502ProDtm1.tanom2riscontrate) do
            begin
              (*
              if tdescanom2[R502ProDtm1.tanom2riscontrate[na].ta2puntdesc].F = 1 then
                S:=R502ProDtm1.tanom2riscontrate[na].ta2caus + ':' + tdescanom2[R502ProDtm1.tanom2riscontrate[na].ta2puntdesc].D
              else
                S:=tdescanom2[R502ProDtm1.tanom2riscontrate[na].ta2puntdesc].D;
              PutAnomalia('2',R502ProDtm1.tanom2riscontrate[na].ta2puntdesc,S);
              *)
              PutAnomalia('2',R502ProDtm1.tanom2riscontrate[na].ta2puntdesc,R502ProDtm1.tanom2riscontrate[na].ta2testo);
            end;
          end;
          if chkLivello3.Checked then
          begin
            for na:=0 to High(R502ProDtm1.tanom3riscontrate) do
            begin
              (*
              S:=R180MinutiOre(R502ProDtm1.tanom3riscontrate[na].ta3timb) + ':' + tdescanom3[R502ProDtm1.tanom3riscontrate[na].ta3puntdesc].D;
              if R502ProDtm1.tanom3riscontrate[na].ta3puntdesc in [4,6] then
              begin
                Lista.Clear;
                Lista.Text:=R502ProDtm1.tanom3riscontrate[na].ta3desc;
                for j:=0 to Lista.Count - 1 do
                  S:=S + ' [' + Lista[j] + ']';
              end;
              PutAnomalia('3',R502ProDtm1.tanom3riscontrate[na].ta3puntdesc,S);
              *)
              PutAnomalia('3',R502ProDtm1.tanom3riscontrate[na].ta3puntdesc,R502ProDtm1.tanom3riscontrate[na].ta3testo);
            end;
          end;
          DataCorr:=DataCorr + 1;
        end;
        Next;
      end;
    end;
  finally
    FreeAndNil(R502ProDtM1);
  end;

  // dopo l'esecuzione salva i parametri per l'operatore
  PutParametriFunzione;

  // tabella anomalie
  grdAnomalie.RowCount:=Length(VettAnomalie) + 1;
  grdAnomalie.ColumnCount:=6;
  grdAnomalie.Cell[0,0].Text:='Matricola';
  grdAnomalie.Cell[0,1].Text:='Badge';
  grdAnomalie.Cell[0,2].Text:='Nome';
  grdAnomalie.Cell[0,3].Text:='Data';
  grdAnomalie.Cell[0,4].Text:='Liv.';
  grdAnomalie.Cell[0,5].Text:='Anomalia';
  for na:=0 to High(VettAnomalie) do
  begin
    grdAnomalie.Cell[na + 1,0].Text:=VettAnomalie[na].Matricola;
    grdAnomalie.Cell[na + 1,1].Text:=VettAnomalie[na].Badge;
    grdAnomalie.Cell[na + 1,2].Text:=VettAnomalie[na].Nome;
    grdAnomalie.Cell[na + 1,3].Text:=VettAnomalie[na].Data;
    grdAnomalie.Cell[na + 1,4].Text:=VettAnomalie[na].Livello;
    grdAnomalie.Cell[na + 1,5].Text:=VettAnomalie[na].Anomalia;
    grdAnomalie.Cell[na + 1,5].Clickable:=CartellinoAbilitato;
  end;
  grdAnomalie.Visible:=True;
  btnEsportaInExcel.Enabled:=True;
  btnEsportaInCSV.Enabled:=True;
end;

procedure TW003FAnomalie.IWAppFormRender(Sender: TObject);
begin
  inherited;
  edtPeriodoDal.Text:=DateToStr(Dal);
  edtPeriodoAl.Text:=DateToStr(Al);
end;

procedure TW003FAnomalie.grdAnomalieRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  ACell.Css:='';
  if not RenderCell(ACell,ARow,AColumn,True,True) then
    Exit;
  if (grdAnomalie.Cell[ARow,4].Text = '1') then
    ACell.Css:=ACell.Css + ' segnalazione';
end;

procedure TW003FAnomalie.btnEsportaInCSVClick(Sender: TObject);
var
  NomeFile,Err: String;
begin
  NomeFile:=GeneraFile(fdUser,'xls',grdAnomalie.ToCsv,Err);
  VisualizzaFile(NomeFile,'Elenco anomalie',nil,nil);
  if Err <> '' then
    MsgBox.MessageBox(Err,ESCLAMA,'Esportazione');
end;

procedure TW003FAnomalie.btnEsportaInExcelClick(Sender: TObject);
var
  NomeFile,Err: String;
begin
  NomeFile:=GeneraFile(fdUser,'xlsx',grdAnomalie.ToXlsx,Err);
  VisualizzaFile(NomeFile,'Elenco anomalie',nil,nil);
  if Err <> '' then
    MsgBox.MessageBox(Err,ESCLAMA,'Esportazione');
end;

procedure TW003FAnomalie.grdAnomalieCellClick(ASender: TObject; const ARow, AColumn: Integer);
var
  M:String;
  D:TDateTime;
  W005: TW005FCartellino;
begin
  try
    M:=grdAnomalie.Cell[ARow,0].Text;
    D:=StrToDate(grdAnomalie.Cell[ARow,3].Text);
  except
    Exit;
  end;
  W005:=TW005FCartellino.Create(GGetWebApplicationThreadVar);
  W005.SetParam('CHIAMANTE','W003');
  W005.SetParam('PROGRESSIVO',selAnagrafe.Lookup('MATRICOLA',M,'PROGRESSIVO'));
  W005.SetParam('DAL',D - 1);
  W005.SetParam('AL',D + 1);
  W005.SetParam('SINGOLO',True);
  W005.OpenPage;
end;

procedure TW003FAnomalie.DistruggiOggetti;
begin
  if selAnagrafe <> nil then
    FreeAndNil(selAnagrafe);
  if Lista <> nil then
    FreeAndNil(Lista);
  FreeAndNil(C004);
end;

end.
