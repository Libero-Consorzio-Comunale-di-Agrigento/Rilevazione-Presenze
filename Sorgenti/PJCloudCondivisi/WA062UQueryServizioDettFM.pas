unit WA062UQueryServizioDettFM;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms,IWDBStdCtrls,
  Dialogs, WR205UDettTabellaFM, Oracle, OracleData, Db, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container,
  IWRegion, Menus, IWCompEdit, meIWEdit, IWCompButton, meIWButton,IWCompExtCtrls, meIWImageFile, medpIWImageButton,
  IWCompCheckbox, meIWCheckBox, IWCompLabel, meIWLabel, IWCompGrids, IWDBGrids, medpIWDBGrid,meIWComboBox, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWCompMemo, meIWMemo, ActnList, meIWGrid,medpIWMessageDlg, meIWDBEdit, A000UInterfaccia,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb, WA062UAccessoDB, A000UMessaggi,
  System.Diagnostics;

type
  TWA062FQueryServizioDettFM = class(TWR205FDettTabellaFM)
    memoSql: TmeIWMemo;
    grdVariabili: TmedpIWDBGrid;
    lblNome: TmeIWLabel;
    edtNome: TmeIWEdit;
    btnRefreshVariabili: TmedpIWImageButton;
    chkProtetta: TmeIWCheckBox;
    lblInfo: TmeIWLabel;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdVariabiliRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure IWFrameRegionRender(Sender: TObject);
    procedure grdVariabiliDataSet2Componenti(Row: Integer);
    procedure grdVariabiliComponenti2DataSet(Row: Integer);
    procedure btnRefreshVariabiliClick(Sender: TObject);
    procedure grdVariabiliConferma(Sender: TObject);
  private
    TmpSender:TObject;
    I090ParolaChiave:String;
    WA062FAccessoDB:TWA062FAccessoDB;
    procedure DataSet2Componenti; override;
    procedure AbilitaComponenti; override;
    procedure ReleaseOggetti; override;
    procedure ResultMessaggioT921(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure ResultMessaggioT002Esistente(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure EseguiScript(Sender: TObject; Result: Boolean);
    procedure ResultQryEsistente(Sender: TObject; R: TmeIWModalResult; KI: String);
  public
    procedure InizializzaCampi;
    procedure PulisciCampoNome;
    procedure InserisciSqlProgressivo;
    procedure InserisciSqlJoin;
    procedure InserisciSqlExist;
    procedure EseguiSql(Sender: TObject; var RTempoElab: Int64);
    function  SalvaSql:String;
  end;

implementation

uses WA062UQueryServizio,WA062UQueryServizioDM,WA062URisultatiFM;

{$R *.dfm}

procedure TWA062FQueryServizioDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  with grdVariabili do
  begin
    medpAttivaGrid(TWA062FQueryServizioDM(WR302DM).A062MW.cdsValori,True,False,False);
    medpPreparaComponentiDefault;
    if not (Self.Owner as TWA062FQueryServizio).SolaLettura then
      medpPreparaComponenteGenerico('WR102',medpIndexColonna('TIPO'),0,DBG_CMB,'20','','','','S')
    else
      medpPreparaComponenteGenerico('WR102',medpIndexColonna('TIPO'),0,DBG_LBL,'','','','','S');
  end;
end;

procedure TWA062FQueryServizioDettFM.IWFrameRegionRender(Sender: TObject);
var isBrowse:boolean;
begin
  inherited;
  isBrowse:=not (Self.Owner as TWA062FQueryServizio).actAnnulla.Enabled;
  edtNome.ReadOnly:=isBrowse or (Self.Owner as TWA062FQueryServizio).IsModificaAction;
  with (Self.Owner as TWA062FQueryServizio) do
  begin
    actModifica.Enabled:=(Parametri.ModificaDatiProtetti or not chkProtetta.Checked) and isBrowse;
    actElimina.Enabled:=(Parametri.ModificaDatiProtetti or not chkProtetta.Checked) and isBrowse and (not SolaLettura);
    AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
  end;
  memoSql.Editable:=not isBrowse;
  chkProtetta.Enabled:=not isBrowse and Parametri.ModificaDatiProtetti;
  if isBrowse then
    edtNome.Text:=(WR302DM as TWA062FQueryServizioDM).SelTabella.FieldByName('NOME').AsString;
end;

procedure TWA062FQueryServizioDettFM.DataSet2Componenti;
var D: TDateTime;
  //Legge un valore generico salvato su riga 4
  function GetVariabile(Nome:String):String;
  var Val:String;
  begin
    Nome:=UpperCase(Nome);
    Val:=Trim(VarToStr((WR302DM as TWA062FQueryServizioDM).A062MW.selT002Riga.Lookup('POSIZ',-4,'RIGA')));
    if Val = '' then
      Val:='CHKINTESTAZIONE(S)CHKNORITORNOACAPO(N)';
    Result:=Copy(Val,pos(Nome + '(',Val) + Length(Nome + '('), PosEx(')',Val,pos(Nome + '(',Val)) - (pos(Nome + '(',Val) + Length(Nome + '(')));
  end;

begin
  if (WR302DM as TWA062FQueryServizioDM).SelTabella.FieldByName('NOME').AsString = '' then
    exit;
  with (WR302DM as TWA062FQueryServizioDM) do
  begin
    A062MW.SqlNome:=(WR302DM as TWA062FQueryServizioDM).SelTabella.FieldByName('NOME').AsString;
    A062MW.SqlSelezioneList.Clear;
    A062MW.CaricaQuery;
    if (Self.Owner as TWA062FQueryServizio).grdC700 <> nil then
      (Self.Owner as TWA062FQueryServizio).grdC700.Visible:=A062MW.EsisteC700;
    memoSql.Lines.Assign(A062MW.SqlSelezioneList);
    chkProtetta.Checked:=A062MW.ChkMWProtetta;
    memoSql.Editable:=A062MW.ChkMWProtetta or Parametri.ModificaDatiProtetti;
    (Self.Owner as TWA062FQueryServizio).WA062RisultatiFM.edtNomeTab.Text:=A062MW.SqlNomeTabella;
    (Self.Owner as TWA062FQueryServizio).WA062RisultatiFM.chkIntestazione.Checked:=GetVariabile((Self.Owner as TWA062FQueryServizio).WA062RisultatiFM.chkIntestazione.Name) = 'S';
    (Self.Owner as TWA062FQueryServizio).WA062RisultatiFM.chkNoRitornoACapo.Checked:=GetVariabile((Self.Owner as TWA062FQueryServizio).WA062RisultatiFM.chkNoRitornoACapo.Name) = 'S';
  end;
  if grdVariabili.medpClientDataSet <> nil then
    grdVariabili.medpAggiornaCDS;

  //Se esiste la C700 assegna a DataLavoro e DataDal i valori delle variabili
  if (WR302DM as TWA062FQueryServizioDM).A062MW.EsisteC700 then
    with (WR302DM as TWA062FQueryServizioDM).A062MW.cdsValori do
    begin
      if (Self.Owner as TWA062FQueryServizio).grdC700 = nil then exit;      //DC - 27-07-2020 - controlli aggiunti per evitare access violation all'avvio
      if Locate('VARIABILE;TIPO',VarArrayOf(['DataLavoro','Data']),[loCaseInsensitive]) and
        (not FieldByName('VALORE').IsNull) and
        TryStrToDate(FieldByName('VALORE').AsString,D) then
        (Self.Owner as TWA062FQueryServizio).grdC700.WC700FM.C700DataLavoro:=D
      else (Self.Owner as TWA062FQueryServizio).grdC700.WC700FM.C700DataLavoro:=Parametri.DataLavoro;

      if Locate('VARIABILE;TIPO',VarArrayOf(['C700DataDal','Data']),[loCaseInsensitive]) and
        (not FieldByName('VALORE').IsNull) and
        TryStrToDate(FieldByName('VALORE').AsString,D) then
        (Self.Owner as TWA062FQueryServizio).grdC700.WC700FM.C700DataDal:=D
      else (Self.Owner as TWA062FQueryServizio).grdC700.WC700FM.C700DataDal:=Parametri.DataLavoro;
    end;

end;

procedure TWA062FQueryServizioDettFM.EseguiSql(Sender: TObject; var RTempoElab: Int64);
var
  LStopWatch: TStopWatch;
begin
  // avvio timer di precisione
  LStopWatch:=TStopwatch.StartNew;
  try
    with (WR302DM as TWA062FQueryServizioDM).A062MW do
    begin
      Q1.Close;
      SenderIsBtnCreaTab:=Sender = (Self.Owner as TWA062FQueryServizio).WA062RisultatiFM.btnCreaTab;
      SqlSelezioneList.Text:=memoSql.Lines.Text;
      SqlNomeTabella:=(Self.Owner as TWA062FQueryServizio).WA062RisultatiFM.edtNomeTab.Text;
    end;

    btnRefreshVariabiliClick(nil);//RefreshVariabili

    with (WR302DM as TWA062FQueryServizioDM).A062MW do
    begin
      ValidaQuery;
      if UpperCase(Copy(Trim(memoSql.Lines.Text) + ' ',1,5)) = 'EXEC ' then
      begin
        RegistraMsg.IniziaMessaggio('WA062');
        SqlNome:=edtNome.Text;
        PreparaScript;
        if ChiediPswAccessoDB and (selI090.RecordCount > 0) then
        begin
          // E' necessario chiedere la password per conferma all'operatore
          I090ParolaChiave:=R180Decripta(selI090.FieldByName('PAROLACHIAVE').AsString,21041974);
          WA062FAccessoDB:=TWA062FAccessoDB.Create(Self.Owner);
          WA062FAccessoDB.SetUsername(UserName);
          WA062FAccessoDB.ResultEvent:=EseguiScript;  //Esegue lo script
          WA062FAccessoDB.Visualizza;
        end
        else
        begin
          // Possiamo eseguire subito lo script
          S1.Execute;
          if Pos('ORA-',Trim(S1.Output.Text)) > 0 then
            RegistraMsg.InserisciMessaggio('A','Risultato = ' + Trim(S1.Output.Text),'',0)
          else
            RegistraMsg.InserisciMessaggio('I','Risultato = ' + Trim(S1.Output.Text),'',0);
          MsgBox.MessageBox(Trim(S1.Output.Text),INFORMA);
        end;
        Exit;
      end;

      if SenderIsBtnCreaTab then
      begin
        if EsisteTabella then
        begin
          if not MsgBox.KeyExists('T921') then
          begin
            TmpSender:=Sender;
            MsgBox.WebMessageDlg(Format(A000MSG_A062_DLG_FMT_QUERY_ESISTENTE,[SqlNomeTabella]),mtConfirmation,[mbYes,mbNo],ResultMessaggioT921,'T921');

            Abort;
          end;
          DropTableT921;  //Drop tabella
        end;
      end;

      EseguiQuery;

      if SenderIsBtnCreaTab then
      begin
        CreateTableT921(SqlNomeTabella);
        MsgBox.WebMessageDlg(Format(A000MSG_A062_MSG_FMT_DATI_REGISTRATI,[SqlNomeTabella]),mtInformation,[mbOK],nil,'');
      end;

      (Self.Owner as TWA062FQueryServizio).WA062RisultatiFM.btnCartellino.Enabled:=BtnCartellinoEnabled;
      (Self.Owner as TWA062FQueryServizio).WA062RisultatiFM.btnCartellino.Visible:=BtnCartellinoVisible;
    end;
  finally
    // stop timer di precisione
    LStopWatch.Stop;

    RTempoElab:=LStopWatch.ElapsedMilliseconds;
  end;
end;

procedure TWA062FQueryServizioDettFM.AbilitaComponenti;
begin
  inherited;
  (Self.Owner as TWA062FQueryServizio).WA062RisultatiFM.btnEsportaFile.Enabled:=True;
  (Self.Owner as TWA062FQueryServizio).WA062RisultatiFM.btnCreaTab.Enabled:=True;
  (Self.Owner as TWA062FQueryServizio).WA062RisultatiFM.btnCartellino.Enabled:=True;
  (Self.Owner as TWA062FQueryServizio).WA062RisultatiFM.edtNomeTab.ReadOnly:=False;
  (Self.Owner as TWA062FQueryServizio).WA062RisultatiFM.chkIntestazione.Enabled:=True;
  (Self.Owner as TWA062FQueryServizio).WA062RisultatiFM.chkNoRitornoACapo.Enabled:=True;
  chkProtetta.Enabled:=Parametri.ModificaDatiProtetti;
  edtNome.ReadOnly:=False;
  memoSql.Editable:=True;
  btnRefreshVariabili.Enabled:=True;
end;

procedure TWA062FQueryServizioDettFM.grdVariabiliComponenti2DataSet(Row: Integer);
var D: TDateTime;
    strVal:string;

begin
  inherited;
  if not (Self.Owner as TWA062FQueryServizio).SolaLettura then
  begin
    (WR302DM as TWA062FQueryServizioDM).A062MW.cdsValori.FieldByName('TIPO').AsString:=(grdVariabili.medpCompCella(Row,grdVariabili.medpIndexColonna('TIPO'),0) as TmeIWComboBox).Text;
    strVal:=(grdVariabili.medpCompCella(Row,grdVariabili.medpIndexColonna('VALORE'),0) as TmeIWEdit).Text; // grdVariabili.medpValoreColonna(Row, 'Valore');

    if Uppercase(grdVariabili.medpValoreColonna(Row, 'VARIABILE'))=Uppercase('DataLavoro') then
    begin
      if (strVal <> '') and (TryStrToDate(strVal,D)) then
        (Self.Owner as TWA062FQueryServizio).grdC700.WC700FM.C700DataLavoro:=D
      else
        (Self.Owner as TWA062FQueryServizio).grdC700.WC700FM.C700DataLavoro:=Parametri.DataLavoro;
    end
    else if Uppercase(grdVariabili.medpValoreColonna(Row, 'VARIABILE'))=Uppercase('C700DataDal') then
    begin
      if (strVal <> '') and (TryStrToDate(strVal,D)) then
        (Self.Owner as TWA062FQueryServizio).grdC700.WC700FM.C700DataDal:=D
      else
        (Self.Owner as TWA062FQueryServizio).grdC700.WC700FM.C700DataDal:=Parametri.DataLavoro;
    end;
  end;
end;

procedure TWA062FQueryServizioDettFM.grdVariabiliConferma(Sender: TObject);
var
  r: Integer;
  LVarModificate: Boolean;
begin
  inherited;
  with grdVariabili do
  begin
    r:=medpRigaDiCompGriglia((Sender as TmeIWImageFile).FriendlyName);
    medpConferma(r);
  end;
  (WR302DM as TWA062FQueryServizioDM).A062MW.SqlNome:=edtNome.Text;
  LVarModificate:=(WR302DM as TWA062FQueryServizioDM).A062MW.SalvaVariabili;
  (Self.Owner as TWA062FQueryServizio).RisultatiInvalidati:=LVarModificate;
end;

procedure TWA062FQueryServizioDettFM.grdVariabiliDataSet2Componenti(Row: Integer);
begin
  inherited;
  if not (Self.Owner as TWA062FQueryServizio).SolaLettura then
    with (grdVariabili.medpCompCella(Row,grdVariabili.medpIndexColonna('TIPO'),0) as TmeIWComboBox) do
    begin
      RequireSelection:=True;
      NoSelectionText:='';
      Items.Add('Stringa');
      Items.Add('Data');
      Items.Add('Numero');
      Items.Add('Sostituzione');
      ItemIndex:=Items.IndexOf(grdVariabili.medpValoreColonna(Row, 'TIPO'));
    end;
end;

procedure TWA062FQueryServizioDettFM.btnRefreshVariabiliClick(Sender: TObject);
begin
  with (WR302DM as TWA062FQueryServizioDM).A062MW do
  begin
    SqlSelezioneList.Text:=memoSql.Lines.Text;
    RefreshVariabili;
  end;
  grdVariabili.medpAggiornaCDS;
end;

function TWA062FQueryServizioDettFM.SalvaSql:String;
var i:integer;
    s,Tipo:String;
begin
  Result:=edtNome.Text;
  if edtNome.Text = '' then
    raise Exception.Create(A000MSG_A062_ERR_NOME_QUERY_MANCANTE);

  with (WR302DM as TWA062FQueryServizioDM).A062MW do
  begin
    SqlNome:=edtNome.Text;
    SqlNomeTabella:=(Self.Owner as TWA062FQueryServizio).WA062RisultatiFM.edtNomeTab.Text;
    SqlSelezioneList.Text:=memoSql.Lines.Text;
    chkIntestazioneName:=(Self.Owner as TWA062FQueryServizio).WA062RisultatiFM.chkIntestazione.Name;
    chkIntestazioneChecked:=(Self.Owner as TWA062FQueryServizio).WA062RisultatiFM.chkIntestazione.Checked;
    chkNoRitornoACapoName:=(Self.Owner as TWA062FQueryServizio).WA062RisultatiFM.chkNoRitornoACapo.Name;
    chkNoRitornoACapoChecked:=(Self.Owner as TWA062FQueryServizio).WA062RisultatiFM.chkNoRitornoACapo.Checked;
    ChkMWProtetta:=chkProtetta.Checked;
    SalvataggioIncorso:=True;
    if not SalvaSQL then
    begin
      MsgBox.MessageBox(Format(A000MSG_A062_ERR_QUERY_ESISTENTE,[SqlNome]),ERRORE);
      SalvataggioIncorso:=False;
      Abort;
    end;
    SalvataggioIncorso:=False;

    (Self.Owner as TWA062FQueryServizio).RisultatiInvalidati:=True;
    (WR302DM as TWA062FQueryServizioDM).SelTabella.FieldByName('NOME').AsString:=edtNome.Text;
  end;
end;

procedure TWA062FQueryServizioDettFM.ResultQryEsistente(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
  begin
    with (WR302DM as TWA062FQueryServizioDM).A062MW do
    begin
    delT002.Close;
    delT002.SetVariable('Nome',edtNome.Text);
    delT002.Execute;
    end;
    (Self.Owner as TWA062FQueryServizio).actConfermaExecute(Sender);
  end
  else
    MsgBox.ClearKeys;
end;

procedure TWA062FQueryServizioDettFM.InizializzaCampi;
begin
  (WR302DM as TWA062FQueryServizioDM).SelTabella.FieldByName('NOME').AsString:='';
  memoSql.Clear;
  with (WR302DM as TWA062FQueryServizioDM).A062MW do
  begin
    chkProtetta.Checked:=False;
    cdsValori.Close;
    cdsValori.CreateDataSet;
    cdsValori.Open;
    Q1.Close;
    Q1.SQL.Clear;
    (Self.Owner as TWA062FQueryServizio).WA062RisultatiFM.btnEsportaFile.Enabled:=False;
    (Self.Owner as TWA062FQueryServizio).WA062RisultatiFM.btnCartellino.Enabled:=False;
    (Self.Owner as TWA062FQueryServizio).WA062RisultatiFM.btnCartellino.Visible:=(Self.Owner as TWA062FQueryServizio).WA062RisultatiFM.btnCartellino.Enabled;
  end;
  grdVariabili.medpAggiornaCDS;
end;

procedure TWA062FQueryServizioDettFM.PulisciCampoNome;
begin
  edtNome.Text:='';
end;

procedure TWA062FQueryServizioDettFM.ResultMessaggioT921(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
  begin
   (Self.Owner as TWA062FQueryServizio).WA062RisultatiFM.btnCreaTabClick(TmpSender);
    MsgBox.ClearKeys;
  end
  else
    MsgBox.ClearKeys;
end;

procedure TWA062FQueryServizioDettFM.ReleaseOggetti;
begin
  inherited;
  if TmpSender <> nil then
    FreeAndNil(TmpSender);
end;

procedure TWA062FQueryServizioDettFM.ResultMessaggioT002Esistente(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
  begin
    (Self.Owner as TWA062FQueryServizio).actConfermaExecute(Sender);
    MsgBox.ClearKeys;
  end
  else
    MsgBox.ClearKeys;
end;

procedure TWA062FQueryServizioDettFM.InserisciSqlExist;
var Sql:String;
begin
  Sql:=memoSql.Text;
  Insert('EXISTS (SELECT ''X'' FROM :C700SelAnagrafe AND T030.PROGRESSIVO =  <tabella>.PROGRESSIVO)',Sql,Length(memoSql.Text)+1);
  memoSql.Text:=Sql;
  memoSql.SetFocus;
end;

procedure TWA062FQueryServizioDettFM.InserisciSqlJoin;
var Sql:String;
begin
  Sql:=memoSql.Text;
  Insert('SELECT * FROM TABELLA1, TABELLA2, :C700SelAnagrafe AND TABELLA1.CAMPO1 = TABELLA2.CAMPO2 AND TABELLA1.PROGRESSIVO = T030.PROGRESSIVO',Sql,Length(memoSql.Text)+1);
  memoSql.Text:=Sql;
  memoSql.SetFocus;
end;

procedure TWA062FQueryServizioDettFM.InserisciSqlProgressivo;
var Sql:String;
begin
  Sql:=memoSql.Text;
  Insert('PROGRESSIVO IN (SELECT PROGRESSIVO FROM :C700SelAnagrafe)',Sql,Length(memoSql.Text)+1);
  memoSql.Text:=Sql;
  memoSql.SetFocus;
end;

procedure TWA062FQueryServizioDettFM.EseguiScript(Sender: TObject; Result: Boolean);
var PassWord:String;
begin
  PassWord:=WA062FAccessoDB.GetPassword;
  FreeAndNil(WA062FAccessoDB);
  if Result then
  begin
    try
      if I090ParolaChiave <> PassWord then
      begin
        MsgBox.WebMessageDlg(A000MSG_A062_ERR_ACCESSO_NEGATO,mtInformation,[mbOK],nil,'');
        exit;
      end;
      with (WR302DM as TWA062FQueryServizioDM).A062MW.S1 do
      begin
        Execute;
        if Pos('ORA-',Trim(Output.Text)) > 0 then
          RegistraMsg.InserisciMessaggio('A','Risultato = ' + Trim(Output.Text),'',0)
        else
          RegistraMsg.InserisciMessaggio('I','Risultato = ' + Trim(Output.Text),'',0);
        MsgBox.WebMessageDlg(Trim(Output.Text),mtInformation,[mbOK],nil,'');
        exit;
      end;
    except
      on E:Exception do
        raise Exception.Create(A000MSG_A062_ERR_SCRIPT_INVALIDO + #1310 + E.Message);
    end;
  end
end;

procedure TWA062FQueryServizioDettFM.grdVariabiliRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
begin
  if not (ACell.Grid as TmedpIWDBGrid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;
  NumColonna:=grdVariabili.medpNumColonna(AColumn);
  if (ARow > 0) and (ARow <= High(grdVariabili.medpCompGriglia) + 1) and (grdVariabili.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdVariabili.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

end.
