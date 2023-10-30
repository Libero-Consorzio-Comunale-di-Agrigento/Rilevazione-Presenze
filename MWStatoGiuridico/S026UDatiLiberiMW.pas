unit S026UDatiLiberiMW;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R005UDataModuleMW, Oracle, Data.DB, USelI010,
  OracleData, A000UInterfaccia;

type
  TAddCmbItem = procedure(Valore:string) of object;

  TRiepiloghiMensili = record
    Codice:String;
    Descrizione:String;
  end;

  TS026FDatiLiberiMW = class(TR005FDataModuleMW)
    QCols: TOracleDataSet;
    OperSQL: TOracleQuery;
    selSG500Segnalibri: TOracleDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    selSG500SegnalibriFORMATO_DATA: TStringField;
    selSG500SegnalibriDECODIFICA_VALORE: TStringField;
    selSG500SegnalibriDECORRENZA: TDateTimeField;
    dsrSG500Segnalibri: TDataSource;
    selDual: TOracleDataSet;
    selDualDATO_STORICO: TStringField;
    selDualCAUSALE_ASSENZA: TStringField;
    dsrDual: TDataSource;
    dsrI010: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    selI010:TselI010;
    procedure CaricaCmbNomeTabella(lstTabelle:TStrings);
    procedure CaricaCmbDato(CaricaItem:TAddCmbItem; NomeTabella:string);
    procedure CaricaFormatoData(CaricaItem:TAddCmbItem);
    function TestOperSQL(Select, From:string):string;
    function FiltraSelSG500(myDataSet:TOracleDataSet; tFiltro:string):string;
  end;

const
 CFormatoData: array[0..6] of string =
 ('ddmmyyyy',
  'dd/mm/yyyy',
  'mmyyyy',
  'mm/yyyy',
  'mmmyyyy',
  'mmmmyyyy',
  'yyyymm');

 CArchivi: array[0..7] of string =
 ('T030_ANAGRAFICO',
  'V430_STORICO',
  'DATI_INPUT',
  'RIEPILOGHI_MENSILI',
  'SEGNALIBRI',
  'VSG651_CORSI',
  'VSG402_RISCHIPRESCRIZIONI',
  'VSG303_INCARICHI');

 CSegnaLib: array[0..16] of String =
 ('AInizioPeriodo',
  'BFinePeriodo',
  'CPeriodiAssenzaPer',
  'DPeriodiAssenzaTot',
  'EInizioCorsi',
  'FFineCorsi',
  'GPeriodiCorsiPer',
  'HInizioProvvedimenti',
  'IFineProvvedimenti',
  'LInizioProvvAssenza',
  'MFineProvvAssenza',
  'NInizioIncarichi',
  'OFineIncarichi',
  'PPeriodiIncaricoTot',
  'QPeriodiRischioTot',
  'RInizioRischi',
  'SFineRischi');

  //Dati mensili stampabili
  RiepiloghiMensili:array[0..36] of TRiepiloghiMensili =
  (*001*)  ((Codice:'ANNORIEPILOGOMENSILE';   Descrizione:'Anno_riep_mensile'),
  (*002*)  ( Codice:'MESERIEPILOGOMENSILE';   Descrizione:'Mese_riep_mensile'),
  (*003*)  ( Codice:'DEBITOTOTALEMESE';       Descrizione:'Debito_totale_mese'),
  (*004*)  ( Codice:'ORERESETOTALI';          Descrizione:'Ore_rese_totali'),
  (*005*)  ( Codice:'SALDOMESENETTO';         Descrizione:'Saldo_mese_netto'),
  (*006*)  ( Codice:'SALDOANNOTOTALE';        Descrizione:'Saldo_anno_totale'),
  (*007*)  ( Codice:'ORERESEDAPRESENZA';      Descrizione:'Ore_rese_da_presenza'),
  (*008*)  ( Codice:'ORERESEDAASSENZA';       Descrizione:'Ore_rese_da_assenza'),
  (*009*)  ( Codice:'SALDOMESELORDO';         Descrizione:'Saldo_mese_lordo'),
  (*010*)  ( Codice:'SALDOMESELIQUIDATO';     Descrizione:'Saldo_mese_liquid'),
  (*011*)  ( Codice:'SALDOALMESEPRECEDENTE';  Descrizione:'Saldo_mese_preced'),
  (*012*)  ( Codice:'SALDOANNOPRECEDENTE';    Descrizione:'Saldo_anno_preced'),
  (*013*)  ( Codice:'SALDOANNOCORRENTE';      Descrizione:'Saldo_anno_corrente'),
  (*014*)  ( Codice:'SALDOCOMPLESSIVONETTO';  Descrizione:'Saldo_compl_netto'),
  (*015*)  ( Codice:'COMPANNOPRECEDENTE';     Descrizione:'Comp_anno_preced'),
  (*016*)  ( Codice:'LIQANNOPRECEDENTE';      Descrizione:'Liquid_anno_preced'),
  (*017*)  ( Codice:'COMPANNOCORRENTE';       Descrizione:'Comp_anno_corrente'),
  (*018*)  ( Codice:'LIQANNOCORRENTE';        Descrizione:'Liquid_anno_corrente'),
  (*019*)  ( Codice:'COMPLIQANNOPREC';        Descrizione:'Comp_Liq_anno_prec'),
  (*020*)  ( Codice:'COMPLIQANNOCORR';        Descrizione:'Comp_Liq_anno_corr'),
  (*021*)  ( Codice:'COMPENSABILECOMPLESSIVO';Descrizione:'Compensabile_compl'),
  (*022*)  ( Codice:'RECUPEROANNOPRECEDENTE'; Descrizione:'Rec_ore_anno_prec'),
  (*023*)  ( Codice:'RECUPEROANNOCORRENTE';   Descrizione:'Rec_ore_anno_corr'),
  (*024*)  ( Codice:'STRFATTOMESETOTALE';     Descrizione:'Straord_fatto_mese'),
  (*025*)  ( Codice:'LIQUIDNELMESETOTALE';    Descrizione:'Liquidato_mese'),
  (*026*)  ( Codice:'STRFATTOANNOTOTALE';     Descrizione:'Straord_fatto_anno'),
  (*027*)  ( Codice:'LIQUIDNELLANNOTOTALE';   Descrizione:'Liquidato_anno'),
  (*028*)  ( Codice:'STRDALIQUIDARETOTALE';   Descrizione:'Straord_da_liquidare'),
  (*029*)  ( Codice:'GIORNIDIPRESENZA';       Descrizione:'Giorni_di_presenza'),
  (*030*)  ( Codice:'GIORNIVUOTI';            Descrizione:'Giorni_vuoti'),
  (*031*)  ( Codice:'INDFESTIVEINTERE';       Descrizione:'Ind_festive_intere'),
  (*032*)  ( Codice:'INDFESTIVERIDOTTE';      Descrizione:'Ind_festive_ridotte'),
  (*033*)  ( Codice:'INDNOTTURNAGG';          Descrizione:'Ind_notturna_numero'),
  (*034*)  ( Codice:'INDNOTTURNAORE';         Descrizione:'Ind_notturna_ore'),
  (*035*)  ( Codice:'OREADDEBITATEALLEPAGHE'; Descrizione:'Ore_addebitate_paghe'),
  (*036*)  ( Codice:'OREPERSEPERIODICAMENTE'; Descrizione:'Ore_perse_periodic'),
  (*037*)  ( Codice:'ORECOMPENSABILITRONCATE';Descrizione:'Ore_comp_troncate'));

implementation

{$R *.dfm}

procedure TS026FDatiLiberiMW.CaricaFormatoData(CaricaItem:TAddCmbItem);
var
  i:integer;
begin
  for i:=Low(CFormatoData) to High(CFormatoData) do
    CaricaItem(CFormatoData[i]);
end;

procedure TS026FDatiLiberiMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selSG500Segnalibri.Open;

  selDual.Open;
  selI010:=TselI010.Create(Self);
  selI010.Apri(SessioneOracle,'',Parametri.Applicazione,
      'REPLACE(NOME_CAMPO,''T430'','''') CODICE, ' +
        'NOME_LOGICO DESCRIZIONE, PROVVEDIMENTO',
      'TABLE_NAME = ''V430_STORICO'' AND SUBSTR(NOME_CAMPO,5,2) <> ''D_'' AND SUBSTR(NOME_CAMPO,1,4) = ''T430''' +
        ' AND REPLACE(NOME_CAMPO,''T430'','''') <> ''PROGRESSIVO'' AND PROVVEDIMENTO = ''S''',
      'NOME_CAMPO');
  dsrI010.DataSet:=selI010;

end;

procedure TS026FDatiLiberiMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(selI010);
end;

procedure TS026FDatiLiberiMW.CaricaCmbDato(CaricaItem:TAddCmbItem; NomeTabella:string);
var
  i:integer;
begin
  if NomeTabella.ToUpper = 'SEGNALIBRI' then
  begin
    for i:=0 to Length(CSegnaLib) - 1 do
      CaricaItem(CSegnaLib[i]);
  end
  else if NomeTabella.ToUpper = 'RIEPILOGHI_MENSILI' then
  begin
    for i:=0 to Length(RiepiloghiMensili) - 1 do
      CaricaItem(RiepiloghiMensili[i].Descrizione);
  end
  else if NomeTabella.ToUpper <> 'DATI_INPUT' then
  begin
    QCols.Open;
    while not QCols.Eof do
    begin
      if NomeTabella.ToUpper = QCols.FieldByName('TABLE_NAME').AsString then
        CaricaItem(QCols.FieldByName('COLUMN_NAME').AsString);
      QCols.Next;
    end;
    QCols.Close;
  end;
end;

procedure TS026FDatiLiberiMW.CaricaCmbNomeTabella(lstTabelle:TStrings);
var
  i:integer;
begin
  lstTabelle.Clear;
  for i:=Low(CArchivi) to High(CArchivi) do
    lstTabelle.Add(CArchivi[i]);
end;

function TS026FDatiLiberiMW.FiltraSelSG500(myDataSet:TOracleDataSet; tFiltro:string):string;
begin
  Result:='';
  try
    tFiltro:=tFiltro.ToLower;
    if tFiltro = 'anagrafico' then
    begin
      myDataSet.Filter:='ARCHIVIO = ''T030_ANAGRAFICO''';
      myDataSet.Filtered:=True;
    end
    else if tFiltro = 'storico' then
    begin
      myDataSet.Filter:='ARCHIVIO = ''V430_STORICO''';
      myDataSet.Filtered:=True;
    end
    else if tFiltro = 'incarichi' then
    begin
      myDataSet.Filter:='ARCHIVIO = ''VSG303_INCARICHI''';
      myDataSet.Filtered:=True;
    end
    else if tFiltro = 'corsi' then
    begin
      myDataSet.Filter:='ARCHIVIO = ''VSG651_CORSI''';
      myDataSet.Filtered:=True;
    end
    else if tFiltro = 'rischi/prescrizioni' then
    begin
      myDataSet.Filter:='ARCHIVIO = ''VSG402_RISCHIPRESCRIZIONI''';
      myDataSet.Filtered:=True;
    end
    else if tFiltro = 'riepiloghi mensili' then
    begin
      myDataSet.Filter:='ARCHIVIO = ''RIEPILOGHI_MENSILI''';
      myDataSet.Filtered:=True;
    end
    else if tFiltro = 'dati input' then
    begin
      myDataSet.Filter:='ARCHIVIO = ''DATI_INPUT''';
      myDataSet.Filtered:=True;
    end
    else if tFiltro = 'segnalibri' then  //Lorena 19/05/2008
    begin
      myDataSet.Filter:='ARCHIVIO = ''SEGNALIBRI''';
      myDataSet.Filtered:=True;
    end
    else if tFiltro = 'tutti' then
    begin
      myDataSet.Filter:='';
      myDataSet.Filtered:=False;
    end;
  except
    on e:exception do
    begin
      Result:=e.Message;
    end;
  end;
end;

function TS026FDatiLiberiMW.TestOperSQL(Select, From:string):string;
var
  s:String;
begin
  Result:='';
  try
    OperSQL.DeleteVariables;
    OperSQL.Close;
    OperSQL.SQL.Clear;
    OperSQL.DeclareVariable('Variabile',otString);
    S:=Format('SELECT %s',[Select]);
    if (From <> 'DATI_INPUT') and
       (From <> 'RIEPILOGHI_MENSILI') and
       (From <> 'SEGNALIBRI') then
    begin
      S:=S + Format(' FROM %s',[From]);
    end
    else
    begin
      S:=S + ' FROM DUAL';
    end;
    OperSQL.SQL.Text:=S;
    OperSQL.SetVariable('Variabile','');
    OperSQL.Execute;
  except
    on E:Exception do
      Result:=e.Message;
  end;
end;

end.
