unit C014UImpostazioneFiltro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, StdCtrls, CheckLst, DBCtrls, Buttons, C180FunzioniGenerali,
  OracleData, A000UCostanti, A000USessione, A000UInterfaccia, Oracle, DB, USelI010;

type
  TC014FImpostazioneFiltro = class(TForm)
    Panel3: TPanel;
    Label3: TLabel;
    Label1: TLabel;
    Panel2: TPanel;
    btnOK: TBitBtn;
    BitBtn1: TBitBtn;
    Panel1: TPanel;
    Label2: TLabel;
    btnCreaEspressione: TSpeedButton;
    btnAggiornaValori: TSpeedButton;
    btnPulisciMemo: TSpeedButton;
    Label4: TLabel;
    dCmbColonne: TDBLookupComboBox;
    cmbOperatori: TComboBox;
    clbValori: TCheckListBox;
    memoEspressione: TMemo;
    Splitter1: TSplitter;
    PopupMenu1: TPopupMenu;
    Selezionatutto1: TMenuItem;
    AnnullaTutto1: TMenuItem;
    procedure dCmbColonneKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCreaEspressioneClick(Sender: TObject);
    procedure btnAggiornaValoriClick(Sender: TObject);
    procedure btnPulisciMemoClick(Sender: TObject);
    procedure dCmbColonneCloseUp(Sender: TObject);
    procedure dCmbColonneKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AnnullaTutto1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    MaxLung:Integer;
    Stato:String;
    CampoFiltro:TField;
  public
    { Public declarations }
    selI010:TselI010;
  end;

var
  C014FImpostazioneFiltro: TC014FImpostazioneFiltro;

procedure OpenC014ImpostazioneFiltro(Tipo,StatoDataset:String;Campo:TField);

implementation

uses C014UImpostazioneFiltroDtM;

{$R *.dfm}

procedure OpenC014ImpostazioneFiltro(Tipo,StatoDataset:String;Campo:TField);
begin
  Application.CreateForm(TC014FImpostazioneFiltroDtM, C014FImpostazioneFiltroDtM);
  if Tipo = 'Open' then
  begin
    Application.CreateForm(TC014FImpostazioneFiltro, C014FImpostazioneFiltro);
    C014FImpostazioneFiltro.CampoFiltro:=Campo;
    if StatoDataset = '' then
      C014FImpostazioneFiltro.Stato:='V'
    else
      C014FImpostazioneFiltro.Stato:=StatoDataset;
  end;
  try
    if Tipo = 'Open' then
      C014FImpostazioneFiltro.ShowModal;
    if Tipo = 'Test' then
      with C014FImpostazioneFiltroDtM do
      begin
        testSQL.SQL.Clear;
        testSQL.SQL.Add('SELECT * FROM T030_ANAGRAFICO T030, T430_STORICO T430, P430_ANAGRAFICO P430 WHERE T030.PROGRESSIVO = T430.PROGRESSIVO AND T430.PROGRESSIVO = P430.PROGRESSIVO AND T430.PROGRESSIVO = 0 AND ');
        testSQL.SQL.Add(Campo.AsString);
        testSQL.Describe;
      end;
  finally
    if Tipo = 'Open' then
      FreeAndNil(C014FImpostazioneFiltro);
    FreeAndNil(C014FImpostazioneFiltroDtM);
  end;
end;

procedure TC014FImpostazioneFiltro.btnCreaEspressioneClick(Sender: TObject);
var S,V:string;
    i,Conta:integer;
begin
  // Controlli
  Conta:=0;
  for i:=0 to clbValori.Items.Count - 1 do
    if clbValori.Checked[i] then
      inc(Conta);
  if ((Copy(Trim(cmbOperatori.Text),1,7) = 'BETWEEN') or
      (Copy(Trim(cmbOperatori.Text),1,4) = 'IN (')) and (Conta < 2) then
    raise Exception.Create('Valori insufficienti!');
  if (Copy(Trim(cmbOperatori.Text),1,7) = 'BETWEEN') and (Conta > 2) then
    raise Exception.Create('Troppi valori specificati!');
  if (Copy(Trim(cmbOperatori.Text),1,7) <> 'BETWEEN') and
     (Copy(Trim(cmbOperatori.Text),1,4) <> 'IN (') and (Conta > 1) then
    raise Exception.Create('Troppi valori specificati!');
  // Valorizzazione
  if (Trim(cmbOperatori.Text) = 'AND') or (Trim(cmbOperatori.Text) = 'OR') or
     (Trim(cmbOperatori.Text) = 'NOT') then
    S:=cmbOperatori.Text
  else
  begin
    if dCmbColonne.Text <> '' then
    begin
      selI010.SearchRecord('NOME_LOGICO',VarToStr(dCmbColonne.KeyValue),[srFromBeginning]);
      S:=selI010.FieldByName('NOME_CAMPO').AsString;
    end;
    for i:=0 to clbValori.Items.Count - 1 do
      if clbValori.Checked[i] then
      begin
        if Copy(Trim(cmbOperatori.Text),1,7) = 'BETWEEN' then
        begin
          if V <> '' then
            V:=V + ' AND ';
        end
        else if Copy(Trim(cmbOperatori.Text),1,4) = 'IN (' then
        begin
          if V <> '' then
            V:=V + ' , ';
        end;
        V:=V + '''' + Trim(Copy(clbValori.Items[i],1,MaxLung)) + '''';
      end;
    if Copy(Trim(cmbOperatori.Text),1,7) = 'BETWEEN' then
      S:=S + ' BETWEEN ' + V
    else if Copy(Trim(cmbOperatori.Text),1,4) = 'IN (' then
      S:=S + ' IN (' + V + ')'
    else
      S:=S + cmbOperatori.Text + V;
  end;
  memoEspressione.Text:=memoEspressione.Text + S;
end;

procedure TC014FImpostazioneFiltro.btnAggiornaValoriClick(Sender: TObject);
var Campo,Tabella:String;
begin
  with C014FImpostazioneFiltroDtM do
  begin
    selSQL.SQL.Clear;
    selI010.SearchRecord('NOME_LOGICO',VarToStr(dCmbColonne.KeyValue),[srFromBeginning]);
    Campo:=selI010.FieldByName('NOME_CAMPO').AsString;
    Tabella:=selI010.FieldByName('TABELLA').AsString;
    if (Campo = 'COMUNE') or (Campo = 'COMUNENAS') or (Campo = 'CITTA') then
      selSQL.SQL.Add('SELECT CODICE, CITTA DESCRIZIONE FROM T480_COMUNI ORDER BY CODICE')
    else if (Campo = 'PROVINCIA') then
      selSQL.SQL.Add('SELECT COD_PROVINCIA CODICE, DESCRIZIONE FROM T481_PROVINCE ORDER BY CODICE')
    else if Tabella = 'P430_ANAGRAFICO' then
      selSQL.SQL.Add('SELECT DISTINCT ' + Campo + ' CODICE, '' '' DESCRIZIONE FROM P430_ANAGRAFICO ORDER BY CODICE')
    else if Tabella = '' then
      selSQL.SQL.Add('SELECT DISTINCT ' + Campo + ' CODICE, '' '' DESCRIZIONE FROM T030_ANAGRAFICO ORDER BY CODICE')
    else if A000LookupTabella(Campo,selSQL) then
    begin
      if selSQL.VariableIndex('DECORRENZA') >= 0 then
        selSQL.Setvariable('DECORRENZA',EncodeDate(3999,12,31));
    end
    else
      selSQL.SQL.Add('SELECT NULL CODICE, NULL DESCRIZIONE FROM DUAL');
    selSQL.Open;
    end;
  with C014FImpostazioneFiltroDtM.selSQL do
  begin
    First;
    MaxLung:=0;
    while not Eof do
    begin
      if Length(FieldByName('CODICE').AsString) > MaxLung then
        MaxLung:=Length(FieldByName('CODICE').AsString);
      Next;
    end;
    clbValori.Items.Clear;
    First;
    while not Eof do
    begin
      if FieldByName('DESCRIZIONE').AsString <> ' ' then
        clbValori.Items.Add(Format('%-*s',[MaxLung,FieldByName('CODICE').AsString])
        + ' - ' + FieldByName('DESCRIZIONE').AsString)
      else
        clbValori.Items.Add(FieldByName('CODICE').AsString);
      Next;
    end;
    Close;
  end;
end;

procedure TC014FImpostazioneFiltro.btnPulisciMemoClick(Sender: TObject);
begin
  if R180MessageBox('Confermi la pulizia dell''espressione?','DOMANDA') = mrYes then
    memoEspressione.Clear;
end;

procedure TC014FImpostazioneFiltro.dCmbColonneCloseUp(Sender: TObject);
begin
  clbValori.Items.Clear;
end;

procedure TC014FImpostazioneFiltro.dCmbColonneKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  clbValori.Items.Clear;
end;

procedure TC014FImpostazioneFiltro.btnOKClick(Sender: TObject);
begin
  with C014FImpostazioneFiltroDtM do
  begin
    // test sul filtro creato
    if memoEspressione.Text <> '' then
    begin
      testSQL.SQL.Clear;
      testSQL.SQL.Add('SELECT * FROM T030_ANAGRAFICO T030, T430_STORICO T430, P430_ANAGRAFICO P430 WHERE T030.PROGRESSIVO = T430.PROGRESSIVO AND P430.PROGRESSIVO = T430.PROGRESSIVO AND T430.PROGRESSIVO = 0 AND ');
      testSQL.SQL.Add(EliminaRitornoACapo(memoEspressione.Text));
      testSQL.Describe;
    end;
    // valorizzazione campo filtro
    if (Stato = 'M') and (CampoFiltro.DataSet.State = dsBrowse) then
      CampoFiltro.DataSet.Edit;
    CampoFiltro.AsString:=EliminaRitornoACapo(memoEspressione.Text);
  end;
  Close;
end;

procedure TC014FImpostazioneFiltro.FormShow(Sender: TObject);
begin
  with C014FImpostazioneFiltroDtM do
  begin
    memoEspressione.Text:=CampoFiltro.AsString;
    memoEspressione.ReadOnly:=Stato = 'V';
    dCmbColonne.Enabled:=Stato = 'M';
    cmbOperatori.Enabled:=Stato = 'M';
    clbValori.Enabled:=Stato = 'M';
    btnAggiornaValori.Enabled:=Stato = 'M';
    btnPulisciMemo.Enabled:=Stato = 'M';
    btnCreaEspressione.Enabled:=Stato = 'M';
    btnOK.Enabled:=Stato = 'M';
    if Stato = 'M' then
    begin
      selI010:=TselI010.Create(Self);
      selI010.Apri(SessioneOracle,'',Parametri.Applicazione,
      'REPLACE(REPLACE(NOME_CAMPO,''T430'',''''),''P430'','''') NOME_CAMPO,' +
        'NOME_LOGICO,' +
        'DECODE(SUBSTR(NOME_CAMPO,1,4),''T430'',''T430_STORICO'',''P430'',''P430_ANAGRAFICO'','''') TABELLA',
      ' SUBSTR(NOME_CAMPO,5,2) <> ''D_''' +
        ' AND REPLACE(NOME_CAMPO,''T430'','''') NOT IN (''PROGRESSIVO'',''DATADECORRENZA'',''DATAFINE'')' +
        ' AND REPLACE(NOME_CAMPO,''P430'','''') NOT IN (''PROGRESSIVO'',''DECORRENZA'',''DECORRENZA_FINE'')',
      'TABELLA, NOME_LOGICO');
      dsrI010.DataSet:=selI010;
      dCmbColonne.ListSource:=C014FImpostazioneFiltroDtM.dsrI010;
    end;
  end;
end;

procedure TC014FImpostazioneFiltro.AnnullaTutto1Click(Sender: TObject);
var i:Integer;
begin
  for i:=0 to clbValori.Items.Count - 1 do
    clbValori.Checked[i]:=Sender = Selezionatutto1;
end;

procedure TC014FImpostazioneFiltro.FormDestroy(Sender: TObject);
begin
  FreeAndNil(selI010);
end;

procedure TC014FImpostazioneFiltro.dCmbColonneKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

end.
