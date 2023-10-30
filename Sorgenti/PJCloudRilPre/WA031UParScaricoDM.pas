unit WA031UParScaricoDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData, Oracle,
  A000UInterfaccia, WR302UGestTabellaDM, WR300UBaseDM, DBClient,
  A000UCostanti, A000USessione, ControlloVociPaghe, medpIWMessageDlg, C180FunzioniGenerali,A000UMessaggi;

type
  TWA031FParScaricoDM = class(TWR302FGestTabellaDM)
    selTabellaSCARICO: TStringField;
    selTabellaNOMEFILE: TStringField;
    selTabellaTCP: TStringField;
    selTabellaIPADDRESS: TStringField;
    selTabellaCORRENTE: TStringField;
    selTabellaBADGE: TStringField;
    selTabellaEDBADGE: TStringField;
    selTabellaANNO: TStringField;
    selTabellaMESE: TStringField;
    selTabellaGIORNO: TStringField;
    selTabellaORE: TStringField;
    selTabellaMINUTI: TStringField;
    selTabellaSECONDI: TStringField;
    selTabellaVERSO: TStringField;
    selTabellaRILEVATORE: TStringField;
    selTabellaCAUSALE: TStringField;
    selTabellaENTRATA: TStringField;
    selTabellaUSCITA: TStringField;
    selTabellaTIPOSCARICO: TStringField;
    selTabellaTRIGGER_BEFORE: TStringField;
    selTabellaTRIGGER_AFTER: TStringField;
    selTabellaAZIENDE: TStringField;
    selTabellaFUNZIONE: TStringField;
    selTabellaTIMB_NONTOLL_GGPREC: TIntegerField;
    selTabellaTIMB_NONTOLL_GGSUCC: TIntegerField;
    selTabellaTIMB_NONTOLL_LOG: TStringField;
    selTabellaTIMB_NONTOLL_REG: TStringField;
    selTabellaOFFSET_ANNO: TIntegerField;
    selI090: TOracleDataSet;
    selTabellaEXPR_CHIAVE: TStringField;
    selTabellaCHIAVE: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure OnNewRecord(DataSet: TDataSet);
  private
    function CtrlExprChiave(const PExpr: String; var Err: String): Boolean;
  public
    const ColonneGrdMappaturaDati: array[0..11] of String = ( 'BADGE',
                                                              'EDBADGE',
                                                              'ANNO',
                                                              'MESE',
                                                              'GIORNO',
                                                              'ORE',
                                                              'MINUTI',
                                                              'SECONDI',
                                                              'VERSO',
                                                              'RILEVATORE',
                                                              'CAUSALE',
                                                              'CHIAVE' );
  end;

implementation

uses WA031UParScarico, WA031UParScaricoDettFM, WR100UBase;

{$R *.dfm}

procedure TWA031FParScaricoDM.IWUserSessionBaseCreate(Sender: TObject);
var where:String;
begin
  NonAprireSelTabella:=True;
  inherited;
  selTabella.ClearVariables;
  selTabella.SetVariable('ORDERBY','ORDER BY SCARICO');
  if (Parametri.Azienda <> 'AZIN') then
  begin
    Where:='WHERE INSTR('',''||I100.AZIENDE||'','','',' + Parametri.Azienda + ','') > 0';
    Where:=Where + ' OR I100.AZIENDE IS NULL';
    selTabella.SetVariable('WHERE',where);
  end;
  selTabella.Open;
  selI090.Open;
end;

procedure TWA031FParScaricoDM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  SelTabella.FieldByName('Corrente').AsString:='N';
  SelTabella.FieldByName('TCP').AsString:='N';
  SelTabella.FieldByName('Badge').AsString:='0,0';
  SelTabella.FieldByName('EdBadge').AsString:='0,0';
  SelTabella.FieldByName('Anno').AsString:='0,0';
  SelTabella.FieldByName('Mese').AsString:='0,0';
  SelTabella.FieldByName('Giorno').AsString:='0,0';
  SelTabella.FieldByName('Ore').AsString:='0,0';
  SelTabella.FieldByName('Minuti').AsString:='0,0';
  SelTabella.FieldByName('Secondi').AsString:='0,0';
  SelTabella.FieldByName('Verso').AsString:='0,0';
  SelTabella.FieldByName('Rilevatore').AsString:='0,0';
  SelTabella.FieldByName('Causale').AsString:='0,0';
  SelTabella.FieldByName('Entrata').AsString:='1';
  SelTabella.FieldByName('Uscita').AsString:='0';
  SelTabella.FieldByName('TipoScarico').AsString:='0';
end;

procedure TWA031FParScaricoDM.BeforePostNoStorico(DataSet: TDataSet);
var
  s : String;
  Errore: String;
begin
  inherited;
  if QueryPK1.EsisteChiave('MONDOEDP.I100_PARSCARICO',SelTabella.RowId,SelTabella.State,['SCARICO'],[SelTabellaScarico.AsString]) then
    raise Exception.Create('Codice già esistente!');

  // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.ini
  // trim dell'espressione per la chiave
  SelTabella.FieldByName('EXPR_CHIAVE').AsString:=Trim(SelTabella.FieldByName('EXPR_CHIAVE').AsString);
  // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.fine

  s:=selTabella.FieldByName('RILEVATORE').AsString;
  if StrTointDef(Copy(s,pos(',',s)+1,MaxInt),0) > 10 then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_LUNG_MAX,['rilevatore',10]),mtError,[mbOk],nil,'');
    Abort;
  end;

  // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.ini
  // controllo indicazione chiave in alternativa al badge
  if (SelTabella.FieldByName('BADGE').AsString <> '0,0') and
     (SelTabella.FieldByName('CHIAVE').AsString <> '0,0') then
    raise Exception.Create('La parametrizzazione del dato Chiave è ammessa solo in alternativa al Badge!');

  s:=selTabella.FieldByName('CHIAVE').AsString;
  if StrTointDef(Copy(s,pos(',',s)+1,MaxInt),0) > 20 then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_LUNG_MAX,['Chiave',20]),mtError,[mbOk],nil,'');
    Abort;
  end;

  // controllo indicazione espressione chiave
  if SelTabella.FieldByName('EXPR_CHIAVE').AsString <> '' then
  begin
    // l'espressione è ammessa solo se è parametrizzato il dato Chiave
    if SelTabella.FieldByName('CHIAVE').AsString = '0,0' then
      raise Exception.Create('L''espressione per la chiave è da indicare solo se è parametrizzato il corrispondente dato!');

    // controlli sull'espressione SQL per la chiave
    if not CtrlExprChiave(SelTabella.FieldByName('EXPR_CHIAVE').AsString,Errore) then
      raise Exception.Create(Errore);
  end;
end;

function TWA031FParScaricoDM.CtrlExprChiave(const PExpr: String; var Err: String): Boolean;
var
  Lst: TStringList;
  i: Integer;
  NomeVar: String;
  OQ: TOracleQuery;
  EsisteVarChiave: Boolean;
begin
  Result:=True;
  Err:='';

  Lst:=TStringList.Create;
  OQ:=TOracleQuery.Create(Self);
  try
    // 1. l'espressione deve contenere la variabile :CHIAVE (tipo alfanumerico)
    //    e opzionalmente la variabile :DATA (tipo date)
    OQ.Session:=SessioneOracle;
    OQ.SQL.Text:=PExpr;

    Lst:=FindVariables(PExpr,False); // non considera i duplicati
    Lst.CaseSensitive:=False;

    // controllo presenza obbligatoria della variabile "chiave"
    if Lst.IndexOf('CHIAVE') = -1  then
    begin
      Result:=False;
      Err:='L''espressione per la chiave deve necessariamente contenere una variabile denominata ":CHIAVE"!';
      Exit;
    end;

    for i:=0 to Lst.Count - 1 do
    begin
      NomeVar:=UpperCase(Lst[i]);
      if NomeVar = 'CHIAVE' then
      begin
        OQ.DeclareAndSet(NomeVar,otString,'1');
      end
      else if NomeVar = 'DATA' then
      begin
        OQ.DeclareAndSet(NomeVar,otDate,DATE_NULL);
      end
      else
      begin
        Result:=False;
        Err:=Format('L''espressione per la chiave non ammette l''utilizzo della variabile "%s"!',[NomeVar]);
        Exit;
      end;
    end;

    // 2. l'espressione deve essere formalmente corretta
    try
      OQ.Execute;
    except
      on E: Exception do
      begin
        Result:=False;
        Err:=Format('L''espressione per la chiave non è corretta:'#13#10'%s',[E.Message]);
        Exit;
      end;
    end;

    // 3. l'espressione deve estrarre una sola colonna di tipo number (il progressivo)
    if OQ.FieldCount > 1 then
    begin
      Result:=False;
      Err:='L''espressione per la chiave deve selezionare unicamente il progressivo del dipendente!';
      Exit;
    end;
    if (OQ.FieldType(0) <> otInteger) and
       (OQ.FieldType(0) <> otFloat) then
    begin
      Result:=False;
      Err:=Format('L''espressione per la chiave deve selezionare il progressivo del dipendente: ' +
                  'il dato selezionato "%s" non è di tipo numerico!',[OQ.FieldName(0)]);
      Exit;
    end;
  finally
    FreeAndNil(Lst);
    FreeAndNil(OQ);
  end;
end;

end.
