unit P684UGrigliaDett;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin, Grids,
  DBGrids, StdCtrls, Buttons, ExtCtrls, Clipbrd, C180FunzioniGenerali, C016UElencoVoci,
  A003UDataLavoroBis, C015UElencoValori, A000UCostanti, A000USessione, A000UInterfaccia,
  Oracle, OracleData, System.Actions, System.ImageList, A000UMessaggi;

type
  TP684FGrigliaDett = class(TR001FGestTab)
    Panel2: TPanel;
    btnChiudi: TBitBtn;
    dgrdDettaglio: TDBGrid;
    PopupMenu1: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    MenuItem1: TMenuItem;
    Copia2: TMenuItem;
    CopiaInExcel: TMenuItem;
    lblDecorrenza: TLabel;
    lblDescFondo: TLabel;
    lblCodFondo: TLabel;
    edtCodFondo: TEdit;
    edtDecorrenza: TEdit;
    edtCodVoceGen: TEdit;
    lblCodVoceGen: TLabel;
    edtCodVoceDet: TEdit;
    lblCodVoceDet: TLabel;
    lblDescVoceGen: TLabel;
    lblDescVoceDet: TLabel;
    Panel3: TPanel;
    gpbTipoAccorpamento: TGroupBox;
    chkMese: TCheckBox;
    chkVoce: TCheckBox;
    chkDipendente: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dgrdDettaglioEditButtonClick(Sender: TObject);
    procedure chkDipendenteClick(Sender: TObject);
    procedure chkMeseClick(Sender: TObject);
    procedure chkVoceClick(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Deselezionatutto1Click(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure Copia2Click(Sender: TObject);
    procedure Stampa1Click(Sender: TObject);
  private
    { Private declarations }
    procedure Abilitazioni;
  public
    { Public declarations }
  end;

var
  P684FGrigliaDett: TP684FGrigliaDett;

  procedure OpenP684GrigliaDett(Fondo,CodGen,CodDett:String;Dec:TDateTime);

implementation

uses P684UDefinizioneFondiDtM;

{$R *.dfm}

procedure OpenP684GrigliaDett(Fondo,CodGen,CodDett:String;Dec:TDateTime);
begin
  Application.CreateForm(TP684FGrigliaDett,P684FGrigliaDett);
  with P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW do
  try
    DataElabGrigliaDett:=Dec;
    FondoElabGrigliaDett:=Fondo;
    CodGenElabGrigliaDett:=CodGen;
    CodDetElabGrigliaDett:=CodDett;
    P684FGrigliaDett.ShowModal;
  finally
    FreeAndNil(P684FGrigliaDett);
  end;
end;

procedure TP684FGrigliaDett.FormShow(Sender: TObject);
begin
  inherited;
  with P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW do
  begin
    edtCodFondo.Text:=FondoElabGrigliaDett;
    edtDecorrenza.Text:=DateToStr(DataElabGrigliaDett);
    edtCodVoceGen.Text:=CodGenElabGrigliaDett;
    edtCodVoceDet.Text:=CodDetElabGrigliaDett;
    lblCodVoceGen.Visible:=Trim(CodGenElabGrigliaDett) <> '';
    edtCodVoceGen.Visible:=lblCodVoceGen.Visible;
    lblCodVoceDet.Visible:=Trim(CodDetElabGrigliaDett) <> '';
    edtCodVoceDet.Visible:=lblCodVoceDet.Visible;
    lblDescFondo.Caption:=VarToStr(selP684.Lookup('DECORRENZA_DA;COD_FONDO',
                               VarArrayOf([DataElabGrigliaDett,FondoElabGrigliaDett]),'DESCRIZIONE'));
    if Trim(CodGenElabGrigliaDett) <> '' then
      lblDescVoceGen.Caption:=VarToStr(selP686D.Lookup('DECORRENZA_DA;COD_FONDO;CLASS_VOCE;COD_VOCE_GEN',
                                   VarArrayOf([DataElabGrigliaDett,FondoElabGrigliaDett,'D',CodGenElabGrigliaDett]),'DESCRIZIONE'))
    else
      lblDescVoceGen.Caption:='';
    if Trim(CodDetElabGrigliaDett) <> '' then
      lblDescVoceDet.Caption:=VarToStr(selP688D.Lookup('DECORRENZA_DA;COD_FONDO;COD_VOCE_GEN;COD_VOCE_DET',
                                   VarArrayOf([DataElabGrigliaDett,FondoElabGrigliaDett,CodGenElabGrigliaDett,CodDetElabGrigliaDett]),'DESCRIZIONE'))
    else
      lblDescVoceDet.Caption:='';
    actInserisci.OnExecute:=nil;
    if Trim(CodGenElabGrigliaDett) = '' then
    begin
      actModifica.OnExecute:=nil;
      actCancella.OnExecute:=nil;
    end;
    DButton.DataSet:=selP690;
    LeggoSelP690;
    selP210.Close;
    selP210.Open;
  end;
  Abilitazioni;
end;

procedure TP684FGrigliaDett.FormActivate(Sender: TObject);
begin
  inherited;
  if dgrdDettaglio.DataSource.DataSet <> nil then
    StatusBar.Panels[1].Text:=Format('Record %d/%d',[dgrdDettaglio.DataSource.DataSet.RecNo,dgrdDettaglio.DataSource.DataSet.RecordCount]);
end;

procedure TP684FGrigliaDett.FormClose(Sender: TObject; var Action: TCloseAction);
var Imp:Real;
begin
  inherited;
  with P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW do
  begin
    if Trim(CodGenElabGrigliaDett) = '' then
      exit;
    if LetturaDettaglioImportoSpeso(selP690.FieldByName('COD_FONDO').AsString,selP690.FieldByName('DECORRENZA_DA').AsDateTime,Imp) then
      if R180MessageBox(A000MSG_P664_DLG_ALLINEA_SPESO,'DOMANDA') = mrYes then
        ImpostaImportoSpeso(Imp);
  end;
end;

procedure TP684FGrigliaDett.dgrdDettaglioEditButtonClick(Sender: TObject);
var vCodice:Variant;
begin
  inherited;
  with P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW do
  begin
    case dgrdDettaglio.SelectedIndex of
      4: //Richiesta data dal tramite calendario
      begin
        if selP690.FieldByName('DATA_RETRIBUZIONE').IsNull then
          selP690.FieldByName('DATA_RETRIBUZIONE').AsDateTime:=Parametri.DataLavoro;
        selP690.FieldByName('DATA_RETRIBUZIONE').AsDateTime:=R180FineMese(DataOut(R180InizioMese(selP690.FieldByName('DATA_RETRIBUZIONE').AsDateTime),'Mese Retribuzione','M'));
      end;
      5: //Cod.contratto
      begin
        OpenC015FElencoValori('P210_CONTRATTI','<P684> Selezione contratto',selP210.Sql.Text,'COD_CONTRATTO',vCodice,selP210);
        if not VarIsClear(vCodice) then
          selP690.FieldByName('COD_CONTRATTO').AsString:=VarToStr(vCodice[0]);
      end;
      6: //Selezione codice voce paghe da elenco
      begin
        C016FElencoVoci:=TC016FElencoVoci.Create(nil);
        C016FElencoVoci.DecorrenzaElencoVoci:=selP690.FieldByName('DECORRENZA_DA').AsDateTime;
        C016FElencoVoci.CodContrattoElencoVoci:=selP690.FieldByName('COD_CONTRATTO').AsString;
        C016FElencoVoci.CodVoceElencoVoci:=selP690.FieldByName('COD_VOCE').AsString;
        C016FElencoVoci.CodVoceSpecialeElencoVoci:='BASE';
        C016FElencoVoci.TestoFiltroSql:=' AND COD_VOCE_SPECIALE = ''BASE''';
        if C016FElencoVoci.ShowModal = mrOK then
          selP690.FieldByName('COD_VOCE').AsString:=C016FElencoVoci.CodVoceElencoVoci;
        C016FElencoVoci.Free;
      end;
    end;
  end;
end;

procedure TP684FGrigliaDett.chkDipendenteClick(Sender: TObject);
begin
  inherited;
  if (not chkMese.Checked) and (not chkVoce.Checked) and (not chkDipendente.Checked) then
  begin
    chkDipendente.Checked:=True;
    raise Exception.Create(A000MSG_P684_ERR_TIPO_ACCORPAMENTO);
  end;
  Abilitazioni;
end;

procedure TP684FGrigliaDett.chkMeseClick(Sender: TObject);
begin
  inherited;
  if (not chkMese.Checked) and (not chkVoce.Checked) and (not chkDipendente.Checked) then
  begin
    chkMese.Checked:=True;
    raise Exception.Create(A000MSG_P684_ERR_TIPO_ACCORPAMENTO);
  end;
  Abilitazioni;
end;

procedure TP684FGrigliaDett.chkVoceClick(Sender: TObject);
begin
  inherited;
  if (not chkMese.Checked) and (not chkVoce.Checked) and (not chkDipendente.Checked) then
  begin
    chkVoce.Checked:=True;
    raise Exception.Create(A000MSG_P684_ERR_TIPO_ACCORPAMENTO);
  end;
  Abilitazioni;
end;

procedure TP684FGrigliaDett.Selezionatutto1Click(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(dgrdDettaglio,'S');
end;

procedure TP684FGrigliaDett.Deselezionatutto1Click(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(dgrdDettaglio,'N');
end;

procedure TP684FGrigliaDett.Invertiselezione1Click(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(dgrdDettaglio,'C');
end;

procedure TP684FGrigliaDett.Copia2Click(Sender: TObject);
var S:String;
  i:Integer;
begin
  inherited;
  with dgrdDettaglio.DataSource.DataSet do
  begin
    if not Active then
      exit;
    S:='';
    Clipboard.Clear;
    DisableControls;
    Screen.Cursor:=crHourGlass;
    First;
    try
      if not EOF then
      begin
        for i:=0 to FieldCount - 1 do
          if Fields[i].Visible then
            S:=S + Fields[i].DisplayLabel + #9;
        S:=S + #13#10;
      end;
      while not EOF do
      begin
        if dgrdDettaglio.SelectedRows.CurrentRowSelected then
        begin
          for i:=0 to FieldCount - 1 do
            if Fields[i].Visible then
              S:=S + Fields[i].AsString + #9;
          S:=S + #13#10;
        end;
        Next;
      end;
    finally
      First;
      EnableControls;
      Screen.Cursor:=crDefault;
    end;
  end;
  Clipboard.AsText:=S;
end;

procedure TP684FGrigliaDett.Abilitazioni;
var AbilitaModifiche:Boolean;
begin
  Screen.Cursor:=crHourGlass;
  AbilitaModifiche:=chkMese.Checked and chkVoce.Checked and chkDipendente.Checked;
  Panel1.Enabled:=AbilitaModifiche;
  Strumenti1.Enabled:=AbilitaModifiche;
  actRicerca.Enabled:=AbilitaModifiche;
  actStampa.Enabled:=AbilitaModifiche;
  dgrdDettaglio.ReadOnly:=not chkDipendente.Checked;
  with P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW do
  begin
    if AbilitaModifiche then
    begin
      dgrdDettaglio.DataSource:=DButton;
      dgrdDettaglio.Columns[0].Visible:=True;
      dgrdDettaglio.Columns[1].Visible:=True;
      dgrdDettaglio.Columns[2].Visible:=True;
      dgrdDettaglio.Columns[3].Visible:=True;
      dgrdDettaglio.Columns[4].Visible:=True;
      dgrdDettaglio.Columns[5].Visible:=True;
      dgrdDettaglio.Columns[6].Visible:=True;
      dgrdDettaglio.Columns[7].Visible:=True;
      dgrdDettaglio.Columns[8].Visible:=True;
    end
    else
    begin
      LeggoSelP690A(chkDipendente.Checked,chkMese.Checked,chkVoce.Checked);
      dgrdDettaglio.DataSource:=dsrP690A;
      if chkMese.Checked then
        selP690A.FieldByName('DATA_RETRIBUZIONE').OnGetText:=P684FDefinizioneFondiDtM.selP690DATA_RETRIBUZIONEGetText;
      dgrdDettaglio.Columns[0].Visible:=chkDipendente.Checked;
      dgrdDettaglio.Columns[1].Visible:=chkDipendente.Checked;
      dgrdDettaglio.Columns[2].Visible:=chkDipendente.Checked;
      dgrdDettaglio.Columns[3].Visible:=chkDipendente.Checked;
      dgrdDettaglio.Columns[4].Visible:=chkMese.Checked;  //Mese retribuzione
      dgrdDettaglio.Columns[5].Visible:=chkVoce.Checked;  //Contratto
      dgrdDettaglio.Columns[6].Visible:=chkVoce.Checked;  //Codice voce
      dgrdDettaglio.Columns[7].Visible:=chkVoce.Checked;  //Descrizione
      if chkVoce.Checked then
        dgrdDettaglio.Columns[7].Title.Caption:='Descrizione';
      dgrdDettaglio.Columns[8].Visible:=True;  //Importo
      TFloatField(selP690A.FieldByName('IMPORTO')).DisplayFormat:='###,###,###,##0.00';  //Importo
      selP690A.FieldByName('IMPORTO').DisplayWidth:=15;  //Importo
    end;
  end;
  if dgrdDettaglio.DataSource.DataSet <> nil then
    StatusBar.Panels[1].Text:=Format('Record %d/%d',[dgrdDettaglio.DataSource.DataSet.RecNo,dgrdDettaglio.DataSource.DataSet.RecordCount]);
  Screen.Cursor:=crDefault;
end;

procedure TP684FGrigliaDett.Stampa1Click(Sender: TObject);
begin
  with P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW do
  begin
    QueryStampa.Clear;
    QueryStampa.Add('SELECT T3.MATRICOLA, T3.COGNOME, T3.NOME, T2.COD_POSIZIONE_ECONOMICA, T1.COD_FONDO, T1.DECORRENZA_DA,');
    QueryStampa.Add('T1.COD_VOCE_GEN, T1.COD_VOCE_DET, T1.DATA_RETRIBUZIONE, T1.COD_CONTRATTO, T1.COD_VOCE, T1.IMPORTO');
    QueryStampa.Add('FROM P690_FONDISPESO T1, P430_ANAGRAFICO T2, T030_ANAGRAFICO T3');
    QueryStampa.Add('WHERE T1.PROGRESSIVO = T3.PROGRESSIVO (+)');
    QueryStampa.Add('AND T1.COD_FONDO = ''' + FondoElabGrigliaDett + '''');
    QueryStampa.Add('AND T1.DECORRENZA_DA = TO_DATE(''' + DateToStr(DataElabGrigliaDett) + ''',''DD/MM/YYYY'')');
    if Trim(CodGenElabGrigliaDett) <> '' then
      QueryStampa.Add('AND T1.COD_VOCE_GEN = ''' + CodGenElabGrigliaDett + '''');
    if Trim(CodDetElabGrigliaDett) <> '' then
      QueryStampa.Add('AND T1.COD_VOCE_DET = ''' + CodDetElabGrigliaDett + '''');
    QueryStampa.Add('AND T1.CLASS_VOCE = ''D''');
    QueryStampa.Add('AND T1.PROGRESSIVO = T2.PROGRESSIVO (+) AND T1.DATA_RETRIBUZIONE BETWEEN T2.DECORRENZA (+) AND T2.DECORRENZA_FINE (+)');
    QueryStampa.Add('ORDER BY T3.COGNOME, T3.NOME, T3.MATRICOLA, T1.COD_FONDO, T1.DECORRENZA_DA,');
    QueryStampa.Add('T1.COD_VOCE_GEN, T1.COD_VOCE_DET, T1.DATA_RETRIBUZIONE, T1.COD_CONTRATTO, T1.COD_VOCE');
    NomiCampiR001.Clear;
    NomiCampiR001.Add('T3.MATRICOLA');
    NomiCampiR001.Add('T3.COGNOME');
    NomiCampiR001.Add('T3.NOME');
    NomiCampiR001.Add('T2.COD_POSIZIONE_ECONOMICA');
    NomiCampiR001.Add('T1.COD_FONDO');
    NomiCampiR001.Add('T1.DECORRENZA_DA');
    NomiCampiR001.Add('T1.COD_VOCE_GEN');
    NomiCampiR001.Add('T1.COD_VOCE_DET');
    NomiCampiR001.Add('T1.DATA_RETRIBUZIONE');
    NomiCampiR001.Add('T1.COD_CONTRATTO');
    NomiCampiR001.Add('T1.COD_VOCE');
    NomiCampiR001.Add('T1.IMPORTO');
  end;
  inherited;
end;

end.
