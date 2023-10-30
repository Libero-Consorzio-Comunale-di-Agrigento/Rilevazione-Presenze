unit WA183UFiltroAnagrafeDettFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR205UDettTabellaFM, IWVCLComponent, IWApplication,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWDBExtCtrls, IWCompEdit,
  IWDBStdCtrls, meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompLabel, meIWDBRadioGroup, IWCompListbox, meIWDBLookupComboBox,
  meIWDBComboBox, meIWDBLabel,
  meIWLabel, IWCompCheckbox, meIWDBCheckBox, A000UInterfaccia, Menus,
  meIWCheckBox, C180FunzioniGenerali,
  C190FunzioniGeneraliWeb, IWCompButton, meIWButton,
  IWDBGrids, medpIWDBGrid, DB, DBClient, StdCtrls, WC011UListboxFM,
  WC013UCheckListFM, IWCompMemo, meIWMemo, Oracle, OracleData,
  A000UCostanti, A000USessione, medpIWMessageDlg, IWCompExtCtrls, IWCompJQueryWidget,
  meIWImageFile,A000UMessaggi, IWCompGrids, meIWEdit;

type
  TWA183FFiltroAnagrafeDettFM = class(TWR205FDettTabellaFM)
    lblPermesso: TmeIWLabel;
    dedtPermesso: TmeIWDBEdit;
    lblAzienda: TmeIWLabel;
    dcmbAzienda: TmeIWDBLookupComboBox;
    memFiltroAnagrafe: TmeIWMemo;
    imgVerifica: TmeIWImageFile;
    grdFAnag: TmedpIWDBGrid;
    btnAnteprima: TmeIWButton;
    pmnGrd: TPopupMenu;
    actScaricaInExcelDett: TMenuItem;
    imgC700SelezioneAnagrafe: TmeIWImageFile;
    edtNomeUtente: TmeIWEdit;
    edtUtenteAutenticato: TmeIWEdit;
    chkSelezioneRichiestaPortale: TmeIWCheckBox;
    actScaricaInCSVDett: TMenuItem;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdFAnagRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure btnAnteprimaClick(Sender: TObject);
    procedure actScaricaInExcelDettClick(Sender: TObject);
    procedure imgC700SelezioneAnagrafeClick(Sender: TObject);
    procedure actScaricaInCSVDettClick(Sender: TObject);
  private
    procedure ResultSelAnagrafe(Sender: TObject; Result: Boolean);
  public
    procedure AbilitaComponenti; override;
    procedure DataSet2Componenti; override;
  end;

implementation

uses WA183UFiltroAnagrafeDM, WA183UFiltroAnagrafe, WR100UBase, WR102UGestTabella;

{$R *.dfm}

procedure TWA183FFiltroAnagrafeDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  dcmbAzienda.ListSource:=TWA183FFiltroAnagrafeDM(TWA183FFiltroAnagrafe(Self.Owner).WR302DM).D090;
  inherited;
  dcmbAzienda.DataSource:=TWA183FFiltroAnagrafeDM(TWA183FFiltroAnagrafe(Self.Owner).WR302DM).dsrI072;
  dedtPermesso.DataSource:=TWA183FFiltroAnagrafeDM(TWA183FFiltroAnagrafe(Self.Owner).WR302DM).dsrI072;
end;

procedure TWA183FFiltroAnagrafeDettFM.AbilitaComponenti;
begin
  inherited;
  imgVerifica.Enabled:=True;
  imgC700SelezioneAnagrafe.Enabled:=True;
  btnAnteprima.Enabled:=True;
end;

procedure TWA183FFiltroAnagrafeDettFM.actScaricaInCSVDettClick(Sender: TObject);
var NomeFile:String;
begin
  if not Assigned(Sender) then
    (Self.Owner as TWR100FBase).csvDownload:=grdFAnag.ToCsv
  else
  begin
    NomeFile:=TWR102FGestTabella(Self.Parent).Title + '.xls';
    NomeFile:=NomeFile.Replace(' ','_').Replace('(','').Replace(')','').Replace('/','').Replace('\','');
    (Self.Owner as TWR100FBase).InviaFile(NomeFile,(Self.Owner as TWR100FBase).csvDownload);
  end;
end;

procedure TWA183FFiltroAnagrafeDettFM.actScaricaInExcelDettClick(Sender: TObject);
var NomeFile:String;
begin
  if not Assigned(Sender) then
    (Self.Owner as TWR100FBase).streamDownload:=grdFAnag.ToXlsx
  else
  begin
    NomeFile:=TWR102FGestTabella(Self.Parent).Title + '.xlsx';
    NomeFile:=NomeFile.Replace(' ','_').Replace('(','').Replace(')','').Replace('/','').Replace('\','');
    (Self.Owner as TWR100FBase).InviaFile(NomeFile,(Self.Owner as TWR100FBase).streamDownload);
  end;
end;

procedure TWA183FFiltroAnagrafeDettFM.btnAnteprimaClick(Sender: TObject);
var
  i:Integer;
  Riga,NomeUtente,NomeDelegato: String;
begin
  with TWA183FFiltroAnagrafeDM(WR302DM) do
  begin
    testFiltroAnagrafe.SQL.Text:=QVistaOracle;
    testFiltroAnagrafe.SQL.Insert(0,'SELECT MATRICOLA, COGNOME, NOME, T430INIZIO, T430FINE FROM');
    if Trim(memFiltroAnagrafe.Lines.Text) <> '' then
    begin
      //Gestione variabili.ini
      if Pos(':NOME_UTENTE',UpperCase(memFiltroAnagrafe.Text)) > 0 then
        NomeUtente:=edtNomeUtente.Text;
      if Pos(':UTENTE_AUTENTICATO',UpperCase(memFiltroAnagrafe.Text)) > 0 then
        NomeDelegato:=edtUtenteAutenticato.Text;
      if NomeUtente = '' then
        NomeUtente:='1';
      if NomeDelegato = '' then
        NomeDelegato:='1';
      //Gestione variabili.fine
      testFiltroAnagrafe.Sql.Add('AND (');
      for i:=0 to memFiltroAnagrafe.Lines.Count - 1 do
      begin
        Riga:=memFiltroAnagrafe.Lines[i];
        if Trim(Riga) <> '' then
        begin
          Riga:=StringReplace(Riga,':NOME_UTENTE','''' + NomeUtente + '''',[rfReplaceAll,rfIgnoreCase]);
          Riga:=StringReplace(Riga,':UTENTE_AUTENTICATO','''' + NomeDelegato + '''',[rfReplaceAll,rfIgnoreCase]);
          testFiltroAnagrafe.Sql.Add(Riga);
        end;
      end;
      testFiltroAnagrafe.Sql.Add(')');
    end;
    //Imposto la data di lavoro per i dati storici
    testFiltroAnagrafe.DeclareVariable('DataLavoro',otDate);
    testFiltroAnagrafe.SetVariable('DataLavoro',Parametri.DataLavoro);
    testFiltroAnagrafe.Close;
    if Sender = imgVerifica then
      testFiltroAnagrafe.ExecSQL
    else if Sender = btnAnteprima then
    begin
      testFiltroAnagrafe.Open;
      grdFAnag.medpAttivaGrid(TWA183FFiltroAnagrafeDM(WR302DM).testFiltroAnagrafe,False,False,False);
    end;
    if (Sender <> nil) and (Sender <> btnAnteprima) then
      MsgBox.WebMessageDlg(A000MSG_A183_MSG_FILTRO_CORRETTO,mtInformation,[mbOK],nil,'')
  end;
end;

procedure TWA183FFiltroAnagrafeDettFM.DataSet2Componenti;
begin
  with TWA183FFiltroAnagrafeDM(WR302DM) do
  begin
    memFiltroAnagrafe.Lines.Clear;
    selI072.First;
    chkSelezioneRichiestaPortale.Checked:=selI072.FieldByName('SELEZIONE_RICHIESTA_PORTALE').AsString = 'S';
    while not selI072.Eof do
    begin
      memFiltroAnagrafe.Lines.Add(selI072.FieldByName('FILTRO').AsString);
      selI072.Next;
    end;
  end;
end;

procedure TWA183FFiltroAnagrafeDettFM.grdFAnagRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
begin
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  NumColonna:=grdFAnag.medpNumColonna(AColumn);
  // Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(grdFAnag.medpCompGriglia) + 1) and (grdFAnag.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdFAnag.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

procedure TWA183FFiltroAnagrafeDettFM.imgC700SelezioneAnagrafeClick(Sender: TObject);
var
  dDataSelAnagrafe: TDateTime;
begin
  if (WR302DM as TWA183FFiltroAnagrafeDM).selI072.State in [dsEdit,dsInsert] then
  begin
    with (Self.Owner as TWA183FFiltroAnagrafe).grdC700 do
    begin
      dDataSelAnagrafe:=Parametri.DataLavoro;
      WC700FM.C700DataLavoro:=dDataSelAnagrafe;
      WC700FM.C700DataDal:=dDataSelAnagrafe;
      if WC700FM.C700SettaPeriodoSelAnagrafe(dDataSelAnagrafe,dDataSelAnagrafe) then
        SelAnagrafe.CloseAll;
      SelAnagrafe.Open;
      WC700FM.ResultEvent:=ResultSelAnagrafe;
      actSelezioneAnagraficheExecute(nil);
    end;
  end;
end;

procedure TWA183FFiltroAnagrafeDettFM.ResultSelAnagrafe(Sender: TObject; Result: Boolean);
var S:string;
begin
  if Result then
  begin
    S:=Trim((Self.Owner as TWA183FFiltroAnagrafe).grdC700.WC700FM.SQLCreato.Text);
    if Pos('ORDER BY',UpperCase(S)) > 0 then
      S:=Copy(S,1,Pos('ORDER BY',UpperCase(S)) - 1);
    memFiltroAnagrafe.Lines.Add(S);
  end;
end;

end.
