unit WA035UParScaricoPagheDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData, Oracle,
  A000UInterfaccia, WR302UGestTabellaDM, WR300UBaseDM, DBClient,
  A000UCostanti, A000USessione, ControlloVociPaghe, medpIWMessageDlg, C180FunzioniGenerali,A000UMessaggi,
  USelI010;

type
  TWA035FParScaricoPagheDM = class(TWR302FGestTabellaDM)
    D192: TDataSource;
    Q192: TOracleDataSet;
    Q192CODICE: TStringField;
    Q192TIPO: TStringField;
    Q192D_TIPO: TStringField;
    Q192NOME: TStringField;
    Q192POS: TIntegerField;
    Q192LUNG: TIntegerField;
    Q192DEF: TStringField;
    Q192TIPO_PARAMETRIZZAZIONE: TStringField;
    selTabellaCODICE: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaTIPOFILE: TStringField;
    selTabellaDEFAULTENTE: TStringField;
    selTabellaTABELLAENTE: TStringField;
    selTabellaCAMPOENTE: TStringField;
    selTabellaNOMEFILE: TStringField;
    selTabellaDATAFILE: TStringField;
    selTabellaMESEANNO: TStringField;
    selTabellaFORMATOORE: TStringField;
    selTabellaPRECISIONE: TStringField;
    selTabellaUSERPAGHE: TStringField;
    selTabellaSALVATAGGIO_AUTOMATICO: TStringField;
    selTabellaSEPARATOREDECIMALI: TStringField;
    selTabellaTIPODATA_FILE: TStringField;
    selTabellaRICREAZIONE_AUTOMATICA: TStringField;
    selTabellaTIPO_PARAMETRIZZAZIONE: TStringField;
    Del192: TOracleQuery;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure AfterPost(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure Q192BeforePost(DataSet: TDataSet);
    procedure Q192NewRecord(DataSet: TDataSet);
    procedure Q192CalcFields(DataSet: TDataSet);
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
  private
    function ControllaParametriGriglia:Boolean;
  public
    selI010:TselI010;
    procedure CheckBeforePost(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
  end;

implementation

uses WA035UParScaricoPaghe, WA035UParScaricoPagheDettFM, WR100UBase;

{$R *.dfm}


procedure TWA035FParScaricoPagheDM.AfterPost(DataSet: TDataSet);
begin
  if  (TWA035FParScaricoPaghe(Self.Owner).VoceMenu = 'CONTAB')
  and (Q192.UpdatesPending)
  and (selTabella.FieldByName('TIPOFILE').AsString = 'T') then
    MsgBox.WebMessageDlg(A000MSG_A035_MSG_ALLINEA,mtInformation,[mbOk],nil,'');

  try
    SessioneOracle.ApplyUpdates([Q192],False);
    except
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_MODIFICHE_FALLITE,['Più dati con la stessa posizione']),mtError,[mbOk],nil,'');
  end;
  SessioneOracle.Commit;
  //SessioneOracle.CancelUpdates([Q192]);
  Q192.CancelUpdates;
  inherited;
end;

procedure TWA035FParScaricoPagheDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selI010:=TselI010.Create(Self);
  selI010.Apri(SessioneOracle,'',Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO','','NOME_LOGICO,NOME_CAMPO');
  selTabella.SetVariable('TIPOPAR',TWA035FParScaricoPaghe(Self.Owner).VoceMenu);
  selTabella.SetVariable('ORDERBY','ORDER BY CODICE');
  inherited;
end;

procedure TWA035FParScaricoPagheDM.OnNewRecord(DataSet: TDataSet);
begin
  selTabella.FieldByName('TIPO_PARAMETRIZZAZIONE').AsString:=TWA035FParScaricoPaghe(Self.Owner).VoceMenu;
  inherited;
end;

procedure TWA035FParScaricoPagheDM.Q192BeforePost(DataSet: TDataSet);
var ValDef, Errore:String;
    i, CVirgola:Integer;
begin
  inherited;
  if TWA035FParScaricoPaghe(Self.Owner).VoceMenu = cParPaghe then
  begin
    if (Q192.FieldByName('TIPO').AsString = 'H') and
       (not selI010.SearchRecord('NOME_LOGICO',Q192.FieldByName('DEF').AsString,[srFromBeginning])) then
    begin
      MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_NON_ESISTENTE,['Dato anagrafico']),mtError,[mbOk],nil,'');
      Abort;
    end;
    {Verifico Correttezza formula "Segno"
      Controllo presenza di una sola virgola}
    if (Q192.FieldByName('TIPO').AsString = '7') then
    begin
      Errore:='';
      ValDef:=Q192.FieldByName('DEF').AsString;
      CVirgola:=0;
      for i:=1 to Length(ValDef) do
        if ValDef[i] = ',' then
          Inc(CVirgola);

      if CVirgola >= 2 then
        Errore:=A000MSG_A035_ERR_FORMULA;
      if Errore <> '' then
      begin
        MsgBox.WebMessageDlg(Errore,mtError,[mbOk],nil,'');
        Abort;
      end;
    end;
  end;
end;

procedure TWA035FParScaricoPagheDM.Q192CalcFields(DataSet: TDataSet);
begin
  with Q192 do
  begin
    if TWA035FParScaricoPaghe(Self.Owner).VoceMenu = cParPaghe then
    begin
      if FieldByName('TIPO').AsString = '0' then
        FieldByName('D_TIPO').AsString:='FILLER'
      else if FieldByName('TIPO').AsString = '1' then
        FieldByName('D_TIPO').AsString:='ENTE'
      else if FieldByName('TIPO').AsString = '2' then
        FieldByName('D_TIPO').AsString:='DATA'
      else if FieldByName('TIPO').AsString = '3' then
        FieldByName('D_TIPO').AsString:='MATRICOLA'
      else if FieldByName('TIPO').AsString = '4' then
        FieldByName('D_TIPO').AsString:='BADGE'
      else if FieldByName('TIPO').AsString = '5' then
        FieldByName('D_TIPO').AsString:='COD.INTERNO'
      else if FieldByName('TIPO').AsString = '6' then
        FieldByName('D_TIPO').AsString:='COD.PAGHE'
      else if FieldByName('TIPO').AsString = '7' then
        FieldByName('D_TIPO').AsString:='SEGNO'
      else if FieldByName('TIPO').AsString = '8' then
        FieldByName('D_TIPO').AsString:='VALORE'
      else if FieldByName('TIPO').AsString = '9' then
        FieldByName('D_TIPO').AsString:='MISURA'
      else if FieldByName('TIPO').AsString = 'A' then
        FieldByName('D_TIPO').AsString:='DA DATA'
      else if FieldByName('TIPO').AsString = 'B' then
        FieldByName('D_TIPO').AsString:='A DATA'
      else if FieldByName('TIPO').AsString = 'C' then
        FieldByName('D_TIPO').AsString:='RIFERIMENTO'
      else if FieldByName('TIPO').AsString = 'D' then
        FieldByName('D_TIPO').AsString:='DA ORE'
      else if FieldByName('TIPO').AsString = 'E' then
        FieldByName('D_TIPO').AsString:='A ORE'
      else if FieldByName('TIPO').AsString = 'F' then
        FieldByName('D_TIPO').AsString:='DATA DI CASSA'
      else if FieldByName('TIPO').AsString = 'G' then
        FieldByName('D_TIPO').AsString:='IMPORTO'
      else if FieldByName('TIPO').AsString = 'H' then
        FieldByName('D_TIPO').AsString:='DATO ANAGRAFICO'
      else if FieldByName('TIPO').AsString = 'I' then
        FieldByName('D_TIPO').AsString:='CAPITOLO'
      else if FieldByName('TIPO').AsString = 'L' then
        FieldByName('D_TIPO').AsString:='ARTICOLO'
      else
        FieldByName('D_TIPO').AsString:='';
    end
    else if TWA035FParScaricoPaghe(Self.Owner).VoceMenu = cParContab then
    begin
      if FieldByName('TIPO').AsString = '0' then
        FieldByName('D_TIPO').AsString:='FILLER'
      else if FieldByName('TIPO').AsString = '1' then
        FieldByName('D_TIPO').AsString:='DATA ELABORAZIONE'
      else if FieldByName('TIPO').AsString = '2' then
        FieldByName('D_TIPO').AsString:='TOTALE DARE'
      else if FieldByName('TIPO').AsString = '3' then
        FieldByName('D_TIPO').AsString:='TOTALE AVERE'
      else if FieldByName('TIPO').AsString = '4' then
        FieldByName('D_TIPO').AsString:='N. RIGHE DETT. D/A SU STESSA RIGA'
      else if FieldByName('TIPO').AsString = '5' then
        FieldByName('D_TIPO').AsString:='N. RIGHE DETT. D/A SU DUE RIGHE'
      else if FieldByName('TIPO').AsString = '6' then
        FieldByName('D_TIPO').AsString:='PROGRESSIVO RIGA'
      else if FieldByName('TIPO').AsString = '7' then
        FieldByName('D_TIPO').AsString:='ID-CONTO'
      else if FieldByName('TIPO').AsString = '8' then
        FieldByName('D_TIPO').AsString:='SEGNO IMPORTO'
      else if FieldByName('TIPO').AsString = '9' then
        FieldByName('D_TIPO').AsString:='IMPORTO'
      else if FieldByName('TIPO').AsString = 'A' then
        FieldByName('D_TIPO').AsString:='DARE_AVERE'
      else if FieldByName('TIPO').AsString = 'B' then
        FieldByName('D_TIPO').AsString:='SEGNO IMP. DARE'
      else if FieldByName('TIPO').AsString = 'C' then
        FieldByName('D_TIPO').AsString:='IMPORTO_DARE'
      else if FieldByName('TIPO').AsString = 'D' then
        FieldByName('D_TIPO').AsString:='SEGNO IMP. AVERE'
      else if FieldByName('TIPO').AsString = 'E' then
        FieldByName('D_TIPO').AsString:='IMPORTO_AVERE'
      else if FieldByName('TIPO').AsString = 'F' then
        FieldByName('D_TIPO').AsString:='DATA ESPORTAZIONE'
      else if FieldByName('TIPO').AsString = 'G' then
        FieldByName('D_TIPO').AsString:='DATA COMPETENZA'
      else if FieldByName('TIPO').AsString = 'H' then
        FieldByName('D_TIPO').AsString:='DESCRIZIONE CONTO'
      else
        FieldByName('D_TIPO').AsString:='';
    end;
  end;
end;

procedure TWA035FParScaricoPagheDM.Q192NewRecord(DataSet: TDataSet);
begin
  inherited;
  Q192.FieldByName('CODICE').AsString:=selTabella.FieldByName('CODICE').AsString;
  Q192.FieldByName('TIPO_PARAMETRIZZAZIONE').AsString:=TWA035FParScaricoPaghe(Self.Owner).VoceMenu;
end;

function TWA035FParScaricoPagheDM.ControllaParametriGriglia:Boolean;
var i,j,NC : Integer;
    VInizio:array [1..100] of Integer;
    VFine:array [1..100] of Integer;
    VTipo:array [1..100] of String;
    VNome:array [1..100] of String;
begin
  Result:=True;
  Q192.DisableControls;
  for i:=Low(VInizio) to High(VInizio) do
  begin
    VInizio[i]:=0;
    VFine[i]:=0;
  end;
  NC:=0;
  try
    Q192.First;
    while not Q192.Eof do
    begin
      inc(NC);
      VInizio[NC]:=Q192.FieldByName('Pos').AsInteger;
      VFine[NC]:=VInizio[NC] + Q192.FieldByName('Lung').AsInteger - 1;
      VTipo[NC]:=Q192.FieldByName('Tipo').AsString;
      VNome[NC]:=Q192.FieldByName('Nome').AsString;
      Q192.Next;
    end;
    Q192.First;
  finally
    Q192.EnableControls;
  end;
  for i:=1 to NC do
  begin
    if VInizio[i] > VFine[i] then
    begin
      Result:=False;
      Break;
    end;
    if (selTabellaTipoFile.AsString = 'T') and (Trim(VNome[i]) = '') then
    begin
      Result:=False;
      Break;
    end;
    for j:=1 to NC do
    begin
      if i = j then Continue;
      if VInizio[j] > VFine[j] then
      begin
        Result:=False;
        Break;
      end;
      (*if (VTipo[i] <> '0') and (VTipo[i] <> 'H') and (VTipo[i] = VTipo[j]) then
      begin
        Result:=False;
        Break;
      end;*)
      if (selTabellaTipoFile.AsString = 'T') and (VNome[i] = VNome[j]) then
      begin
        Result:=False;
        Break;
      end;
      if (selTabellaTipoFile.AsString <> 'T') and
         (((VInizio[j] >= VInizio[i]) and (VInizio[j] <= VFine[i])) or
          ((VFine[j] >= VInizio[i]) and (VFine[j] <= VFine[i]))) then
      begin
        Result:=False;
        Break;
      end;
    end;
    if not Result then Break;
  end;
end;

procedure TWA035FParScaricoPagheDM.AfterScroll(DataSet: TDataSet);
begin
  Q192.Close;
  Q192.SetVariable('CODICE',selTabella.FieldByName('CODICE').AsString);
  Q192.SetVariable('TIPOPAR',TWA035FParScaricoPaghe(Self.Owner).VoceMenu);
  Q192.Open;
  inherited;
end;

procedure TWA035FParScaricoPagheDM.BeforeDelete(DataSet: TDataSet);
begin
  //CARATTO. Quando elimino un record devo cancellare anche i figli
  with Del192 do
  begin
    SetVariable('CODICE',selTabella.FieldByName('CODICE').AsString);
    SetVariable('TIPOPAR',TWA035FParScaricoPaghe(Self.Owner).VoceMenu);
    Execute;
  end;
  inherited;
end;

procedure TWA035FParScaricoPagheDM.BeforePostNoStorico(DataSet: TDataSet);
var
  TrovImp,TrovDareAvere:Boolean;
  TrovImpDare,TrovImpAvere,TrovSegnoImpDare,TrovSegnoImpAvere:Boolean;
  TrovRigheDett1,TrovRigheDett2:Boolean;
begin
  if not MsgBox.KeyExists('PUNTO_1') then
  begin
    inherited;
    if not ControllaParametriGriglia then
    begin
      MsgBox.WebMessageDlg(A000MSG_A035_DLG_PAR_ERR,mtConfirmation,[mbYes,mbNo],CheckBeforePost,'PUNTO_1');
      Abort;
    end;
  end;

  if TWA035FParScaricoPaghe(Self.Owner).VoceMenu = cParContab then
  begin
    TrovRigheDett1:=VarToStr(Q192.Lookup('TIPO','4','TIPO'))='4';
    TrovRigheDett2:=VarToStr(Q192.Lookup('TIPO','5','TIPO'))='5';
    TrovImp:=VarToStr(Q192.Lookup('TIPO','9','TIPO'))='9';
    TrovDareAvere:=VarToStr(Q192.Lookup('TIPO','A','TIPO'))='A';
    TrovSegnoImpDare:=VarToStr(Q192.Lookup('TIPO','B','TIPO'))='B';
    TrovImpDare:=VarToStr(Q192.Lookup('TIPO','C','TIPO'))='C';
    TrovSegnoImpAvere:=VarToStr(Q192.Lookup('TIPO','D','TIPO'))='D';
    TrovImpAvere:=VarToStr(Q192.Lookup('TIPO','E','TIPO'))='E';
    if (TrovRigheDett1) and (TrovRigheDett2) then
    begin
      MsgBox.WebMessageDlg(A000MSG_A035_ERR_DATI_DARE_AVERE,mtError,[mbOk],nil,'');
      Abort;
    end;
    if (TrovImp or TrovDareAvere) and (TrovSegnoImpDare or TrovImpDare or TrovSegnoImpAvere or TrovImpAvere) then
    begin
      MsgBox.WebMessageDlg(A000MSG_A035_ERR_DATI_DARE_AVERE,mtError,[mbOk],nil,'');
      Abort;
    end;
    if TrovImp and not TrovDareAvere then
    begin
      MsgBox.WebMessageDlg(A000MSG_A035_ERR_IMPORTO_DARE_AVERE,mtError,[mbOk],nil,'');
      Abort;
    end;
  end;
end;

procedure TWA035FParScaricoPagheDM.CheckBeforePost(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  case Res of
    mrYes: selTabella.Post;
    mrNo:  MsgBox.ClearKeys;
  end;
end;

end.
