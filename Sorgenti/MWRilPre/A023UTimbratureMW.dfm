inherited A023FTimbratureMW: TA023FTimbratureMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 375
  Width = 670
  object selT100_T370: TOracleDataSet
    SQL.Strings = (
      'select FLAG '
      'from   :TABELLA'
      'where  PROGRESSIVO = :PROGRESSIVO'
      'and    DATA = :DATA'
      'and    oreminuti(to_char(ORA,'#39'HH24.MI'#39')) = oreminuti(:ORA)'
      'and    VERSO = :VERSO'
      'and    FLAG IN ('#39'I'#39','#39'O'#39')')
    Optimize = False
    Variables.Data = {
      0400000005000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000080000003A004F005200410005000000000000000000
      00000C0000003A0056004500520053004F000500000000000000000000001000
      00003A0054004100420045004C004C004100010000000000000000000000}
    Left = 24
    Top = 78
  end
  object selT105: TOracleDataSet
    SQL.Strings = (
      'select :HINTT030V430'
      
        '       T105.ROWID,T105.ID,T105.PROGRESSIVO,T105.DATA,T105.ORA,T1' +
        '05.VERSO,T105.CAUSALE,T105.OPERAZIONE,T105.ELABORATO,T105.CAUSAL' +
        'E_ORIG,T105.VERSO_ORIG,T105.MOTIVAZIONE,T105.RILEVATORE_RICH,T10' +
        '5.RILEVATORE_ORIG,'
      
        '       T850.STATO AUTORIZZAZIONE, T850.TIPO_RICHIESTA, T850.NOTE' +
        ' NOTE1, T850.COD_ITER, I060F_NOMINATIVO(:AZIENDA,T851.RESPONSABI' +
        'LE) NOMINATIVO_RESP,'
      
        '       T030.COGNOME || '#39' '#39' || T030.NOME AS NOMINATIVO, T030.MATR' +
        'ICOLA'
      'from   T105_RICHIESTETIMBRATURE T105,   '
      '       T850_ITER_RICHIESTE T850,'
      '       T851_ITER_AUTORIZZAZIONI T851,'
      '       :C700SELANAGRAFE'
      'and    T105.PROGRESSIVO = T030.PROGRESSIVO'
      'and    T850.ITER = '#39'T105'#39
      'and    T850.ID = T105.ID'
      'and    T850.STATO in ('#39'S'#39','#39'N'#39')'
      
        'and    T851.ID(+) = T850.ID and T851.LIVELLO(+) = abs(T851F_MAXL' +
        'IV_AUTORIZZATO(:AZIENDA, '#39'T105'#39', T850.ID))'
      '       :FILTRO_MODALITA'
      '       :FILTRO_PERIODO'
      '       :FILTRO_RICHIESTE'
      
        'order by T030.COGNOME, T030.NOME, T030.MATRICOLA, T105.DATA, T10' +
        '5.ORA')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000006000000200000003A004300370030003000530045004C0041004E00
      410047005200410046004500010000000000000000000000100000003A004100
      5A00490045004E00440041000500000000000000000000001A0000003A004800
      49004E0054005400300033003000560034003300300001000000000000000000
      0000220000003A00460049004C00540052004F005F0052004900430048004900
      4500530054004500010000000000000000000000200000003A00460049004C00
      540052004F005F004D004F00440041004C004900540041000100000000000000
      000000001E0000003A00460049004C00540052004F005F005000450052004900
      4F0044004F00010000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000001200000016000000500052004F004700520045005300530049005600
      4F00010000000000080000004400410054004100010000000000060000004F00
      520041000100000000000A00000056004500520053004F000100000000000E00
      0000430041005500530041004C0045000100000000000A0000004E004F005400
      450031000100000000000A0000004E004F005400450032000100000000001400
      00004F0050004500520041005A0049004F004E0045000100000000001C000000
      4100550054004F00520049005A005A0041005A0049004F004E00450001000000
      00001800000052004500530050004F004E0053004100420049004C0045000100
      000000001200000045004C00410042004F005200410054004F00010000000000
      1C00000044004100540041005F00520049004300480049004500530054004100
      0100000000002600000044004100540041005F004100550054004F0052004900
      5A005A0041005A0049004F004E00450001000000000018000000430041005500
      530041004C0045005F004F005200490047000100000000001400000056004500
      520053004F005F004F0052004900470001000000000018000000430041005500
      530041004C0045005F005200490043004800010000000000160000004D004F00
      54004900560041005A0049004F004E0045000100000000001E00000052004900
      4C0045005600410054004F00520045005F005200490043004800010000000000}
    OnCalcFields = selT105CalcFields
    Left = 24
    Top = 14
    object selT105PROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selT105NOMINATIVO: TStringField
      DisplayLabel = 'Nominativo'
      DisplayWidth = 30
      FieldName = 'NOMINATIVO'
      Size = 40
    end
    object selT105MATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selT105AUTORIZZAZIONE: TStringField
      DisplayLabel = 'Autorizzazione'
      FieldName = 'AUTORIZZAZIONE'
      Size = 1
    end
    object selT105OPERAZIONE: TStringField
      DisplayLabel = 'Operazione'
      FieldName = 'OPERAZIONE'
      Size = 1
    end
    object selT105DATA: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
    end
    object selT105VERSO: TStringField
      DisplayLabel = 'Verso'
      FieldName = 'VERSO'
      Size = 1
    end
    object selT105VERSO_ORIG: TStringField
      DisplayLabel = 'Verso orig.'
      FieldName = 'VERSO_ORIG'
      Size = 1
    end
    object selT105ORA: TStringField
      DisplayLabel = 'Ora'
      FieldName = 'ORA'
      Size = 5
    end
    object selT105CAUSALE: TStringField
      DisplayLabel = 'Causale'
      FieldName = 'CAUSALE'
      Visible = False
      Size = 5
    end
    object selT105CAUSALE_UTILE: TStringField
      DisplayLabel = 'Causale'
      FieldKind = fkCalculated
      FieldName = 'CAUSALE_UTILE'
      Size = 5
      Calculated = True
    end
    object selT105CAUSALE_ORIG: TStringField
      DisplayLabel = 'Causale orig.'
      FieldName = 'CAUSALE_ORIG'
      Size = 5
    end
    object selT105RILEVATORE_RICH: TStringField
      DisplayLabel = 'Rilevatore'
      FieldName = 'RILEVATORE_RICH'
      Size = 2
    end
    object selT105RILEVATORE_ORIG: TStringField
      DisplayLabel = 'Rilevatore orig.'
      FieldName = 'RILEVATORE_ORIG'
      Size = 2
    end
    object selT105NOTE1: TStringField
      DisplayLabel = 'Note richiesta'
      DisplayWidth = 40
      FieldName = 'NOTE1'
      Size = 2000
    end
    object selT105NOMINATIVO_RESP: TStringField
      DisplayLabel = 'Responsabile'
      DisplayWidth = 20
      FieldName = 'NOMINATIVO_RESP'
      Size = 40
    end
    object selT105ELABORATO: TStringField
      DisplayLabel = 'Elaborato'
      FieldName = 'ELABORATO'
      Visible = False
      Size = 1
    end
    object selT105COD_ITER: TStringField
      FieldName = 'COD_ITER'
      Visible = False
    end
    object selT105ID: TFloatField
      FieldName = 'ID'
      Visible = False
    end
  end
  object insUpdT100_T370: TOracleQuery
    SQL.Strings = (
      'DECLARE'
      '  COD_RIL varchar2(2);'
      '  ORA_ORIG date;'
      'BEGIN'
      
        '  /* estrae rilevatore e ora da timbratura originale: l'#39'ora serv' +
        'e per preservare i secondi non visibili nella richiesta */'
      '  BEGIN'
      '    select RILEVATORE,ORA'
      '    into   COD_RIL,ORA_ORIG'
      '    from   :TABELLA'
      '    where  PROGRESSIVO = :PROGRESSIVO'
      '    and    DATA = :DATA'
      '    and    oreminuti(to_char(ORA,'#39'HH24.MI'#39')) = oreminuti(:ORA)'
      '    and    VERSO = :VERSO_ORIG'
      '    and    FLAG = '#39'O'#39';'
      '  EXCEPTION'
      '    when NO_DATA_FOUND then'
      '      raise NO_DATA_FOUND;'
      '  END;'
      ''
      '  /* imposta flag M su timbratura modificata */'
      '  BEGIN'
      '    update :TABELLA'
      '    set    FLAG = '#39'M'#39','
      '           ID_RICHIESTA = :ID_RICHIESTA'
      '    where  PROGRESSIVO = :PROGRESSIVO'
      '    and    DATA = :DATA'
      '    and    oreminuti(to_char(ORA,'#39'HH24.MI'#39')) = oreminuti(:ORA)'
      '    and    VERSO = :VERSO_ORIG'
      '    and    FLAG = '#39'O'#39';'
      '  EXCEPTION'
      '    when OTHERS then'
      '      raise DUP_VAL_ON_INDEX;'
      '  END;'
      ''
      '  /* inserisce timbratura con nuovi dati */'
      '  insert into :TABELLA'
      
        '    (PROGRESSIVO,DATA,ORA,FLAG,VERSO,CAUSALE,RILEVATORE,ID_RICHI' +
        'ESTA)'
      '  values'
      
        '    (:PROGRESSIVO,:DATA,ORA_ORIG,'#39'I'#39',:VERSO,:CAUSALE,COD_RIL,:ID' +
        '_RICHIESTA); '
      'END;')
    Optimize = False
    Variables.Data = {
      0400000008000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000080000003A004F005200410005000000000000000000
      00000C0000003A0056004500520053004F000500000000000000000000001600
      00003A0056004500520053004F005F004F005200490047000500000000000000
      00000000100000003A00430041005500530041004C0045000500000000000000
      000000001A0000003A00490044005F0052004900430048004900450053005400
      4100040000000000000000000000100000003A0054004100420045004C004C00
      4100010000000000000000000000}
    Left = 286
    Top = 78
  end
  object updT100_T370: TOracleQuery
    SQL.Strings = (
      'update :TABELLA'
      '       :MODIFICHE'
      'where  PROGRESSIVO = :PROGRESSIVO'
      'and    DATA = :DATA'
      'and    oreminuti(to_char(ORA,'#39'HH24.MI'#39')) = oreminuti(:ORA)'
      'and    VERSO = :VERSO_ORIG'
      'and    FLAG = :FLAG')
    Optimize = False
    Variables.Data = {
      0400000007000000140000003A004D004F004400490046004900430048004500
      010000000000000000000000180000003A00500052004F004700520045005300
      5300490056004F000300000000000000000000000A0000003A00440041005400
      41000C0000000000000000000000080000003A004F0052004100050000000000
      000000000000160000003A0056004500520053004F005F004F00520049004700
      0500000000000000000000000A0000003A0046004C0041004700050000000000
      000000000000100000003A0054004100420045004C004C004100010000000000
      000000000000}
    Left = 192
    Top = 78
  end
  object insT100_T370: TOracleQuery
    SQL.Strings = (
      'DECLARE'
      '  I INTEGER;'
      'BEGIN'
      '  select count(*) '
      '  into   I'
      '  from   :TABELLA'
      '  where  PROGRESSIVO = :PROGRESSIVO '
      '  and    DATA = :DATA '
      '  and    VERSO = :VERSO '
      '  and    oreminuti(to_char(ORA,'#39'HH24.MI'#39')) = oreminuti(:ORA)'
      '  and    FLAG = '#39'O'#39';'
      ''
      '  if I = 0 then'
      '    insert into :TABELLA'
      
        '      (PROGRESSIVO,DATA,ORA,FLAG,VERSO,CAUSALE,RILEVATORE,ID_RIC' +
        'HIESTA)'
      '    values '
      
        '      (:PROGRESSIVO,:DATA,TO_DATE('#39'01/01/1900 '#39' || :ORA,'#39'DD/MM/Y' +
        'YYY HH24.MI'#39'),'#39'I'#39',:VERSO,:CAUSALE,:RILEVATORE,:ID_RICHIESTA);'
      '  else'
      '    raise DUP_VAL_ON_INDEX;'
      '  end if;'
      'END;')
    Optimize = False
    Variables.Data = {
      0400000008000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000080000003A004F005200410005000000000000000000
      00000C0000003A0056004500520053004F000500000000000000000000001000
      00003A00430041005500530041004C0045000500000000000000000000001600
      00003A00520049004C0045005600410054004F00520045000500000000000000
      000000001A0000003A00490044005F0052004900430048004900450053005400
      4100040000000000000000000000100000003A0054004100420045004C004C00
      4100010000000000000000000000}
    Left = 107
    Top = 78
  end
  object delT100_T370: TOracleQuery
    SQL.Strings = (
      'delete from :TABELLA'
      'where  PROGRESSIVO = :PROGRESSIVO'
      'and    DATA = :DATA'
      'and    oreminuti(to_char(ORA,'#39'HH24.MI'#39')) = oreminuti(:ORA)'
      'and    VERSO = :VERSO '
      'and    FLAG = :FLAG')
    Optimize = False
    Variables.Data = {
      0400000006000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000080000003A004F005200410005000000000000000000
      00000C0000003A0056004500520053004F000500000000000000000000000A00
      00003A0046004C0041004700050000000000000000000000100000003A005400
      4100420045004C004C004100010000000000000000000000}
    Left = 380
    Top = 78
  end
  object insT280: TOracleQuery
    SQL.Strings = (
      'INSERT INTO T280_MESSAGGIWEB'
      '  (progressivo, data, mittente, testo, log, flag, titolo)'
      'VALUES'
      
        '  (:PROGRESSIVO, :DATA, :MITTENTE, substr(:TESTO,1,4000), substr' +
        '(:LOG,1,4000), :FLAG, substr(:TITOLO,1,1000))'
      ''
      ''
      ''
      '')
    Optimize = False
    Variables.Data = {
      0400000007000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000120000003A004D0049005400540045004E0054004500
      0500000000000000000000000C0000003A0054004500530054004F0005000000
      00000000000000000A0000003A0046004C004100470005000000000000000000
      00000E0000003A005400490054004F004C004F00050000000000000000000000
      080000003A004C004F004700050000000000000000000000}
    Left = 450
    Top = 78
  end
  object GetCalend: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      '  GETCALENDARIO(:PROG, :D, :F, :L, :G, :MONTEORE);'
      'END;')
    Optimize = False
    Variables.Data = {
      04000000060000000A0000003A00500052004F00470003000000000000000000
      0000040000003A0044000C0000000000000000000000040000003A0046000500
      00000000000000000000040000003A004C000500000000000000000000000400
      00003A00470003000000040000000000000000000000120000003A004D004F00
      4E00540045004F0052004500050000000000000000000000}
    Left = 82
    Top = 14
  end
  object Q040: TOracleDataSet
    SQL.Strings = (
      'SELECT /*+ INDEX(T040_GIUSTIFICATIVI T040_PK)*/'
      'T040.*,T040.ROWID FROM T040_GIUSTIFICATIVI T040'
      'WHERE PROGRESSIVO = :Progressivo AND'
      '               DATA BETWEEN :DataInizio and :DataFine'
      
        'ORDER BY DATA, decode(TIPOGIUST,'#39'I'#39',1,'#39'M'#39',2,'#39'N'#39',3,'#39'D'#39',4), DAORE,' +
        ' CAUSALE, PROGRCAUSALE')
    ReadBuffer = 31
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000160000003A0044004100540041004900
      4E0049005A0049004F000C0000000000000000000000120000003A0044004100
      54004100460049004E0045000C0000000000000000000000}
    AfterPost = Q040AfterPost
    BeforeDelete = Q040BeforeDelete
    OnPostError = Q040PostError
    Left = 135
    Top = 14
  end
  object Q080: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM T080_PianifOrari'
      'WHERE  Progressivo = :Progressivo '
      'AND    Data BETWEEN :DataInizio and :DataFine'
      'ORDER BY Data')
    ReadBuffer = 31
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000160000003A0044004100540041004900
      4E0049005A0049004F000C0000000000000000000000120000003A0044004100
      54004100460049004E0045000C0000000000000000000000}
    Left = 187
    Top = 16
  end
  object Q100: TOracleDataSet
    SQL.Strings = (
      'select T100.*,T100.ROWID FROM T100_TIMBRATURE T100'
      'where  PROGRESSIVO = :Progressivo '
      'and    DATA BETWEEN :DataInizio AND :DataFine'
      'and    FLAG IN ('#39'O'#39','#39'I'#39')'
      'order by DATA,ORA,VERSO,FLAG')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000160000003A0044004100540041004900
      4E0049005A0049004F000C0000000000000000000000120000003A0044004100
      54004100460049004E0045000C0000000000000000000000}
    BeforePost = Q100BeforePost
    AfterPost = Q100AfterPost
    BeforeDelete = Q100BeforeDelete
    AfterDelete = Q100AfterDelete
    OnNewRecord = Q100NewRecord
    Left = 235
    Top = 20
    object Q100PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
    end
    object Q100DATA: TDateTimeField
      FieldName = 'DATA'
    end
    object Q100ORA: TDateTimeField
      FieldName = 'ORA'
      OnGetText = Q100ORAGetText
      OnSetText = Q100ORASetText
      DisplayFormat = 't'
      EditMask = '!90:00;1;_'
    end
    object Q100VERSO: TStringField
      FieldName = 'VERSO'
      Size = 1
    end
    object Q100FLAG: TStringField
      FieldName = 'FLAG'
      Size = 1
    end
    object Q100RILEVATORE: TStringField
      FieldName = 'RILEVATORE'
      OnChange = Q100RILEVATOREChange
      Size = 2
    end
    object Q100CAUSALE: TStringField
      FieldName = 'CAUSALE'
      Size = 5
    end
    object Q100ID_RICHIESTA: TFloatField
      FieldName = 'ID_RICHIESTA'
    end
  end
  object D100: TDataSource
    AutoEdit = False
    DataSet = Q100
    Left = 271
    Top = 20
  end
  object selT320: TOracleDataSet
    SQL.Strings = (
      'select distinct DATA'
      'from   T320_PIANLIBPROFESSIONE'
      'where  PROGRESSIVO = :Progressivo '
      'and    DATA BETWEEN :DataInizio and :DataFine'
      'order by DATA')
    ReadBuffer = 31
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000160000003A0044004100540041004900
      4E0049005A0049004F000C0000000000000000000000120000003A0044004100
      54004100460049004E0045000C0000000000000000000000}
    Left = 316
    Top = 139
  end
  object Q265: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE,'
      
        '       UM_INSERIMENTO, UM_INSERIMENTO_MG, UM_INSERIMENTO_H, UM_I' +
        'NSERIMENTO_D,'
      
        '       CUMULO_FAMILIARI,FRUIZIONE_FAMILIARI,TIPOCUMULO,VALIDAZIO' +
        'NE,'
      '       OreMinuti(FRUIZ_MIN) FRUIZ_MIN,'
      '       OreMinuti(nvl(FRUIZ_MAX,'#39'24.00'#39')) FRUIZ_MAX,'
      '       OreMinuti(FRUIZ_ARR) FRUIZ_ARR,'
      '       FRUIZCOMPETENZE_ARR,'
      '       FRUIZ_MAX_DEBITO,'
      '       VISITA_FISCALE'
      'FROM   T265_CAUASSENZE '
      'ORDER BY CODICE')
    ReadBuffer = 200
    Optimize = False
    AfterOpen = Q265AfterOpen
    OnFilterRecord = Q265FilterRecord
    Left = 80
    Top = 142
  end
  object Q031_1: TOracleDataSet
    SQL.Strings = (
      'SELECT T031.* FROM T031_DATACARTELLINO T031'
      'WHERE PROGRESSIVO = :Progressivo and TIPO = '#39'1'#39)
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    OracleDictionary.DefaultValues = True
    Left = 198
    Top = 142
  end
  object D265: TDataSource
    DataSet = Q265
    Left = 111
    Top = 142
  end
  object Q275: TOracleDataSet
    SQL.Strings = (
      
        'SELECT CODICE, DESCRIZIONE, ARROT_RIEPGG, LINK_ASSENZA, UM_INSER' +
        'IMENTO_H, UM_INSERIMENTO_D, INSERIMENTO_TIMB'
      'FROM   T275_CAUPRESENZE'
      'ORDER BY CODICE')
    ReadBuffer = 500
    Optimize = False
    AfterOpen = Q275AfterOpen
    OnFilterRecord = Q275FilterRecord
    Left = 315
    Top = 19
  end
  object D275: TDataSource
    DataSet = Q275
    Left = 347
    Top = 18
  end
  object Q305: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE'
      'FROM   T305_CAUGIUSTIF '
      'ORDER BY CODICE')
    Optimize = False
    AfterOpen = Q305AfterOpen
    Left = 388
    Top = 19
  end
  object Q361: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE '
      'FROM   T361_OROLOGI'
      'WHERE  FUNZIONE IN ('#39'P'#39','#39'E'#39') '
      'ORDER BY CODICE')
    Optimize = False
    OnFilterRecord = Q361FilterRecord
    Left = 456
    Top = 19
  end
  object D361: TDataSource
    DataSet = Q361
    Left = 484
    Top = 19
  end
  object D305: TDataSource
    DataSet = Q305
    Left = 419
    Top = 18
  end
  object PeriodiAssenza: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      
        '  GENERA_PERIODI_ASSENZA(:PROG, :INIZIO, :FINE, :CAUS, :TG, :DAL' +
        'LE, :ALLE, :OPER);'
      'END;')
    Optimize = False
    Variables.Data = {
      04000000080000000A0000003A00500052004F00470003000000000000000000
      00000E0000003A0049004E0049005A0049004F000C0000000000000000000000
      0A0000003A00460049004E0045000C00000000000000000000000A0000003A00
      4300410055005300050000000000000000000000060000003A00540047000500
      000000000000000000000C0000003A00440041004C004C004500050000000000
      0000000000000A0000003A0041004C004C004500050000000000000000000000
      0A0000003A004F00500045005200050000000000000000000000}
    Left = 24
    Top = 141
  end
  object Q031: TOracleDataSet
    SQL.Strings = (
      'SELECT T031.*,T031.ROWID '
      'FROM   T031_DATACARTELLINO T031'
      'WHERE  PROGRESSIVO = :Progressivo '
      'and    TIPO = '#39'0'#39)
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    OracleDictionary.DefaultValues = True
    Left = 152
    Top = 143
  end
  object Q101: TOracleDataSet
    SQL.Strings = (
      'SELECT COGNOME,NOME,MATRICOLA,T101.*'
      'FROM   T101_ANOMALIE T101, T030_ANAGRAFICO T030'
      'WHERE  T101.PROGRESSIVO = T030.PROGRESSIVO '
      'AND    OPERATORE = :OPERATORE'
      'ORDER BY COGNOME,NOME,MATRICOLA,DATA,LIVELLO')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000001000000140000003A004F00500045005200410054004F0052004500
      030000000000000000000000}
    Left = 361
    Top = 139
    object Q101PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Origin = 'T101_ANOMALIE.PROGRESSIVO'
    end
    object Q101DATA: TDateTimeField
      FieldName = 'DATA'
      Origin = 'T101_ANOMALIE.DATA'
    end
    object Q101LIVELLO: TFloatField
      FieldName = 'LIVELLO'
      Origin = 'T101_ANOMALIE.LIVELLO'
    end
    object Q101ANOMALIA: TStringField
      FieldName = 'ANOMALIA'
      Origin = 'T101_ANOMALIE.ANOMALIA'
      Size = 150
    end
  end
  object selT100: TOracleDataSet
    SQL.Strings = (
      'select T100.*,T100.ROWID '
      'from   T100_TIMBRATURE T100'
      'where  PROGRESSIVO = :Progressivo '
      'and    DATA = :Data '
      'and    FLAG IN ('#39'O'#39','#39'I'#39')'
      'order by DATA,ORA,VERSO,FLAG')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    BeforePost = Q100BeforePost
    AfterPost = Q100AfterPost
    BeforeDelete = Q100BeforeDelete
    AfterDelete = Q100AfterDelete
    OnNewRecord = Q100NewRecord
    Left = 403
    Top = 139
    object FloatField1: TFloatField
      FieldName = 'PROGRESSIVO'
    end
    object DateTimeField1: TDateTimeField
      FieldName = 'DATA'
    end
    object DateTimeField2: TDateTimeField
      FieldName = 'ORA'
      OnSetText = selT100Ora
      DisplayFormat = 'hh:mm'
      EditMask = '!90:00;1;_'
    end
    object StringField1: TStringField
      FieldName = 'VERSO'
      Size = 1
    end
    object StringField2: TStringField
      FieldName = 'FLAG'
      Size = 1
    end
    object StringField3: TStringField
      FieldName = 'RILEVATORE'
      Size = 2
    end
    object StringField4: TStringField
      FieldName = 'CAUSALE'
      Size = 5
    end
  end
  object Q101Delete: TOracleQuery
    SQL.Strings = (
      'DELETE FROM T101_ANOMALIE'
      'WHERE  PROGRESSIVO =:PROGRESSIVO '
      'AND    DATA =:DATA '
      'AND    LIVELLO =:LIVELLO '
      'AND    ANOMALIA =:ANOMALIA '
      'AND    OPERATORE = :OPERATORE')
    Optimize = False
    Variables.Data = {
      0400000005000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000100000003A004C004900560045004C004C004F000300
      00000000000000000000120000003A0041004E004F004D0041004C0049004100
      050000000000000000000000140000003A004F00500045005200410054004F00
      52004500030000000000000000000000}
    Left = 456
    Top = 139
  end
  object selT100Ripristino: TOracleDataSet
    SQL.Strings = (
      'select T.*, decode(ID_RICHIESTA,null,null,'#39'Si'#39') D_WEB'
      'from   T100_TIMBRATURE T'
      'where  PROGRESSIVO = :PROGRESSIVO'
      'and    DATA between :DATA_INIZIO and :DATA_FINE'
      'order by DATA, ORA, VERSO, FLAG')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000180000003A0044004100540041005F00
      49004E0049005A0049004F000C0000000000000000000000140000003A004400
      4100540041005F00460049004E0045000C0000000000000000000000}
    ReadOnly = True
    CountAllRecords = True
    Left = 30
    Top = 196
    object StringField6: TStringField
      DisplayLabel = 'Flag'
      FieldName = 'FLAG'
      Size = 1
    end
    object FloatField2: TFloatField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object DateTimeField3: TDateTimeField
      DisplayLabel = 'Data'
      FieldName = 'DATA'
    end
    object StringField5: TStringField
      DisplayLabel = 'Verso'
      FieldName = 'VERSO'
      Size = 1
    end
    object DateTimeField4: TDateTimeField
      DisplayLabel = 'Ora'
      FieldName = 'ORA'
      OnSetText = DateTimeField4SetText
      DisplayFormat = 'hhhh.mm'
      EditMask = '!90:00;1;_'
    end
    object StringField7: TStringField
      DisplayLabel = 'Rilev.'
      FieldName = 'RILEVATORE'
      Size = 2
    end
    object StringField8: TStringField
      DisplayLabel = 'Causale'
      FieldName = 'CAUSALE'
      Size = 5
    end
    object selT100RipristinoID_RICHIESTA: TFloatField
      DisplayLabel = 'ID rich.'
      FieldName = 'ID_RICHIESTA'
      Visible = False
    end
    object selT100RipristinoD_WEB: TStringField
      DisplayLabel = 'Da iter'
      FieldName = 'D_WEB'
      Size = 2
    end
  end
  object dscT100Ripristino: TDataSource
    DataSet = selT100Ripristino
    Left = 120
    Top = 196
  end
  object cdsT100RiprSim: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'FLAG'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'PROGRESSIVO'
        DataType = ftFloat
      end
      item
        Name = 'DATA'
        DataType = ftDateTime
      end
      item
        Name = 'ORA'
        DataType = ftDateTime
      end
      item
        Name = 'VERSO'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'RILEVATORE'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'CAUSALE'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'ID_RICHIESTA'
        DataType = ftFloat
      end
      item
        Name = 'FLAG_SIM'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'VIS_SIM'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'D_WEB'
        DataType = ftString
        Size = 2
      end>
    IndexDefs = <
      item
        Name = 'Primario'
        Fields = 'DATA;ORA;VERSO;FLAG_SIM'
      end>
    IndexName = 'Primario'
    Params = <>
    StoreDefs = True
    Left = 206
    Top = 196
    object cdsT100RiprSimFLAG: TStringField
      DisplayLabel = 'Flag'
      FieldName = 'FLAG'
      Size = 1
    end
    object cdsT100RiprSimPROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object cdsT100RiprSimDATA: TDateTimeField
      DisplayLabel = 'Data'
      FieldName = 'DATA'
    end
    object cdsT100RiprSimVERSO: TStringField
      DisplayLabel = 'Verso'
      FieldName = 'VERSO'
      Size = 1
    end
    object cdsT100RiprSimORA: TDateTimeField
      DisplayLabel = 'Ora'
      FieldName = 'ORA'
      DisplayFormat = 'hhhh.mm'
      EditMask = '!90:00;1;_'
    end
    object cdsT100RiprSimRILEVATORE: TStringField
      DisplayLabel = 'Rilev.'
      FieldName = 'RILEVATORE'
      Size = 2
    end
    object cdsT100RiprSimCAUSALE: TStringField
      DisplayLabel = 'Causale'
      FieldName = 'CAUSALE'
      Size = 5
    end
    object cdsT100RiprSimID_RICHIESTA: TFloatField
      DisplayLabel = 'ID rich.'
      FieldName = 'ID_RICHIESTA'
      Visible = False
    end
    object cdsT100RiprSimD_WEB: TStringField
      DisplayLabel = 'Da iter'
      FieldName = 'D_WEB'
      Size = 2
    end
    object cdsT100RiprSimFLAG_SIM: TStringField
      DisplayLabel = 'Flag new'
      FieldName = 'FLAG_SIM'
      Visible = False
      Size = 1
    end
    object cdsT100RiprSimVIS_SIM: TStringField
      FieldName = 'VIS_SIM'
      Visible = False
      Size = 1
    end
  end
  object dscT100RiprSim: TDataSource
    DataSet = cdsT100RiprSim
    Left = 285
    Top = 196
  end
  object Q100Delete: TOracleQuery
    SQL.Strings = (
      'DELETE T100_TIMBRATURE '
      'WHERE  PROGRESSIVO = :PROGRESSIVO '
      'AND    DATA BETWEEN :DATA1 AND :DATA2 '
      'AND    FLAG = '#39'I'#39
      ':FILTRO_ID_RICHIESTA')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000280000003A00460049004C00540052004F005F0049004400
      5F00520049004300480049004500530054004100010000000000000000000000}
    Left = 365
    Top = 196
  end
  object Q100Update: TOracleQuery
    SQL.Strings = (
      'UPDATE T100_TIMBRATURE '
      'SET    FLAG = '#39'O'#39' '
      'WHERE  PROGRESSIVO = :PROGRESSIVO '
      'AND    DATA BETWEEN :DATA1 AND :DATA2 '
      'AND    FLAG IN ('#39'M'#39','#39'C'#39')')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 435
    Top = 196
  end
  object EliminaTimbriDoppi: TOracleQuery
    SQL.Strings = (
      'begin'
      '  elimina_timbri_doppi(:matricola, :dal, :al);'
      'end;')
    Optimize = False
    Variables.Data = {
      0400000003000000140000003A004D00410054005200490043004F004C004100
      050000000000000000000000080000003A00440041004C000500000000000000
      00000000060000003A0041004C00050000000000000000000000}
    Left = 516
    Top = 196
  end
  object selT361: TOracleDataSet
    SQL.Strings = (
      'select T361.* '
      'from   T361_OROLOGI T361 '
      'order by CODICE')
    ReadBuffer = 40
    Optimize = False
    Left = 540
    Top = 19
  end
  object selCountVT100: TOracleQuery
    SQL.Strings = (
      'select count(*)'
      'from   VT100_TIMB_DATAORA'
      'where  PROGRESSIVO = :PROGRESSIVO'
      'and    trunc(DATAORA,'#39'mi'#39') = :DATAORA'
      'and    VERSO = :VERSO')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A0044004100540041004F00
      520041000C00000000000000000000000C0000003A0056004500520053004F00
      050000000000000000000000}
    Left = 604
    Top = 196
  end
  object insT100: TOracleQuery
    SQL.Strings = (
      
        'insert into T100_TIMBRATURE(PROGRESSIVO,DATA,ORA,VERSO,CAUSALE,F' +
        'LAG,RILEVATORE)'
      
        'values (:PROGRESSIVO, :DATA, TO_DATE('#39'01/01/1900 '#39' || :ORA,'#39'DD/M' +
        'M/YYYY HH24.MI.SS'#39'), :VERSO, :CAUSALE, :FLAG, :RILEVATORE) ')
    Optimize = False
    Variables.Data = {
      0400000007000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000080000003A004F005200410005000000000000000000
      00000C0000003A0056004500520053004F000500000000000000000000000A00
      00003A0046004C0041004700050000000000000000000000160000003A005200
      49004C0045005600410054004F00520045000500000000000000000000001000
      00003A00430041005500530041004C004500050000000000000000000000}
    Left = 27
    Top = 256
  end
  object selVT100TimbPrec: TOracleDataSet
    SQL.Strings = (
      'select VT100.*'
      'from   VT100_TIMB_DATAORA VT100'
      'where  VT100.PROGRESSIVO = :PROGRESSIVO'
      'and    VT100.DATAORA = (select max(DATAORA)'
      '                        from   VT100_TIMB_DATAORA'
      '                        where  PROGRESSIVO = VT100.PROGRESSIVO'
      '                        and    DATAORA < :DATA_TIMB)')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000140000003A0044004100540041005F00
      540049004D0042000C0000000000000000000000}
    Left = 104
    Top = 256
  end
  object selV430Turnista: TOracleQuery
    SQL.Strings = (
      'select T430TGESTIONE'
      'from   V430_STORICO V430'
      'where  V430.T430PROGRESSIVO = :PROGRESSIVO'
      
        'and    :DATA between V430.T430DATADECORRENZA and V430.T430DATAFI' +
        'NE')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A0044004100540041000C000000070000007875
      090701010100000000180000003A00500052004F004700520045005300530049
      0056004F0003000000040000001D67000000000000}
    Left = 200
    Top = 256
  end
  object scrTimbVirtTriggerBefore: TOracleQuery
    SQL.Strings = (
      'begin'
      
        '  TIMBVIRT_TRIGGER_BEFORE(:PROGRESSIVO, :DATA, :ORA, :VERSO, :RI' +
        'LEVATORE, :CAUSALE, :MSG);'
      'end;')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000070000000A0000003A0044004100540041000C000000070000007875
      090701010100000000180000003A00500052004F004700520045005300530049
      0056004F0003000000040000001D67000000000000080000003A004F00520041
      000C00000000000000000000000C0000003A0056004500520053004F00050000
      000000000000000000160000003A00520049004C0045005600410054004F0052
      004500050000000000000000000000100000003A00430041005500530041004C
      004500050000000000000000000000080000003A004D00530047000500000000
      00000000000000}
    Left = 312
    Top = 256
  end
  object selVT105: TOracleDataSet
    SQL.Strings = (
      'select VT105.ID,'
      '       VT105.T850DATA,       '
      '       VT105.DATA,'
      '       VT105.TIPO_RICHIESTA,'
      '       VT105.STATO,'
      '       VT105.ORA,'
      '       VT105.VERSO,'
      '       VT105.CAUSALE,'
      '       VT105.RILEVATORE_RICH,'
      '       VT105.OPERAZIONE'
      'from   VT105_RICHIESTETIMBRATURE VT105'
      'where  VT105.PROGRESSIVO = :PROGRESSIVO'
      'and    VT105.DATA BETWEEN :DataInizio and :DataFine'
      'and    VT105.ELABORATO = '#39'N'#39
      'order by VT105.DATA, VT105.ORA, VT105.ID')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000160000003A0044004100540041004900
      4E0049005A0049004F000C0000000000000000000000120000003A0044004100
      54004100460049004E0045000C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      0500000009000000040000004900440001000000000008000000440041005400
      41000100000000001C0000005400490050004F005F0052004900430048004900
      45005300540041000100000000000A00000053005400410054004F0001000000
      0000060000004F00520041000100000000000A00000056004500520053004F00
      0100000000000E000000430041005500530041004C0045000100000000001E00
      0000520049004C0045005600410054004F00520045005F005200490043004800
      010000000000140000004F0050004500520041005A0049004F004E0045000100
      00000000}
    ReadOnly = True
    OnCalcFields = selVT105CalcFields
    Left = 216
    Top = 320
    object selVT105ID: TFloatField
      FieldName = 'ID'
      Required = True
      Visible = False
    end
    object selVT105DATA: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
      Visible = False
      DisplayFormat = 'dd/mm/yyyy'
    end
    object selVT105T850DATA: TDateTimeField
      DisplayLabel = 'Data richiesta'
      DisplayWidth = 16
      FieldName = 'T850DATA'
      DisplayFormat = 'dd/mm/yyyy hh.mm'
    end
    object selVT105TIPO_RICHIESTA: TStringField
      FieldName = 'TIPO_RICHIESTA'
      Visible = False
      Size = 1
    end
    object selVT105STATO: TStringField
      FieldName = 'STATO'
      Visible = False
      Size = 1
    end
    object selVT105D_STATO: TStringField
      DisplayLabel = 'Autorizzata'
      DisplayWidth = 15
      FieldKind = fkCalculated
      FieldName = 'D_STATO'
      Calculated = True
    end
    object selVT105D_OPERAZIONE: TStringField
      DisplayLabel = 'Operazione'
      DisplayWidth = 15
      FieldKind = fkCalculated
      FieldName = 'D_OPERAZIONE'
      Calculated = True
    end
    object selVT105VERSO: TStringField
      DisplayLabel = 'Verso'
      FieldName = 'VERSO'
      Size = 1
    end
    object selVT105ORA: TStringField
      DisplayLabel = 'Ora'
      FieldName = 'ORA'
      Size = 5
    end
    object selVT105CAUSALE: TStringField
      DisplayLabel = 'Causale'
      FieldName = 'CAUSALE'
      Size = 5
    end
    object selVT105RILEVATORE_RICH: TStringField
      DisplayLabel = 'Rilevatore'
      FieldName = 'RILEVATORE_RICH'
      Size = 2
    end
    object selVT105OPERAZIONE: TStringField
      FieldName = 'OPERAZIONE'
      Visible = False
      Size = 1
    end
  end
  object selVT050: TOracleDataSet
    SQL.Strings = (
      '-- selVT050'
      'select VT050.ID, '
      '       V010.DATA, '
      '       VT050.DATA T850DATA,'
      '       VT050.TIPO_RICHIESTA, '
      '       VT050.STATO, '
      '       T851F_STATO_INTERMEDIO('#39'T050'#39',VT050.ID) STATO_INTERMEDIO,'
      '       VT050.CAUSALE,'
      
        '       VT050.CAUSALE || '#39' - '#39' || nvl(T265.DESCRIZIONE,T275.DESCR' +
        'IZIONE) D_CAUSALE,'
      '       VT050.DAL,'
      '       VT050.AL,'
      '       VT050.TIPOGIUST,'
      '       VT050.NUMEROORE DAORE, '
      '       VT050.AORE ,'
      '       VT050.DATANAS'
      'from   VT050_RICHIESTE_SENZAREVOCA VT050,'
      '       V010_CALENDARI V010,'
      '       T265_CAUASSENZE T265,'
      '       T275_CAUPRESENZE T275'
      'where  VT050.PROGRESSIVO = :PROGRESSIVO'
      'and    (VT050.DAL <= :DataFine) and (VT050.AL >= :DataInizio)'
      'and    VT050.ELABORATO = '#39'N'#39
      'and    V010.PROGRESSIVO = VT050.PROGRESSIVO'
      'and    V010.DATA BETWEEN VT050.DAL AND VT050.AL'
      'and    VT050.CAUSALE = T265.CODICE(+) '
      'and    VT050.CAUSALE = T275.CODICE(+) '
      ''
      'union'
      ''
      'select VT050.ID, '
      '       V010.DATA, '
      '       VT050.DATA T850DATA,'
      '       VT050.TIPO_RICHIESTA, '
      '       VT050.STATO, '
      '       T851F_STATO_INTERMEDIO('#39'T050'#39',VT050.ID) STATO_INTERMEDIO,'
      '       VT050.CAUSALE,'
      
        '       VT050.CAUSALE || '#39' - '#39' || nvl(T265.DESCRIZIONE,T275.DESCR' +
        'IZIONE) D_CAUSALE,'
      '       VT050.DAL,'
      '       VT050.AL,'
      '       VT050.TIPOGIUST,'
      '       VT050.NUMEROORE DAORE, '
      '       VT050.AORE ,'
      '       VT050.DATANAS'
      'from   VT050_RICHIESTEASSENZA VT050,'
      '       V010_CALENDARI V010,'
      '       T265_CAUASSENZE T265,'
      '       T275_CAUPRESENZE T275'
      'where  VT050.PROGRESSIVO = :PROGRESSIVO'
      'and    (VT050.DAL <= :DataFine) and (VT050.AL >= :DataInizio)'
      'and    VT050.TIPO_RICHIESTA = '#39'R'#39
      'and    VT050.ELABORATO = '#39'N'#39
      'and    V010.PROGRESSIVO = VT050.PROGRESSIVO'
      'and    V010.DATA BETWEEN VT050.DAL AND VT050.AL'
      'and    VT050.CAUSALE = T265.CODICE(+) '
      'and    VT050.CAUSALE = T275.CODICE(+) '
      
        'and    VT050.ID_REVOCATO in (select ID_RICHIESTA from T040_GIUST' +
        'IFICATIVI where PROGRESSIVO = :PROGRESSIVO and DATA between :DAT' +
        'AINIZIO and :DATAFINE)'
      ''
      'order by DATA, CAUSALE, TIPOGIUST, DAORE')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000160000003A0044004100540041004900
      4E0049005A0049004F000C0000000000000000000000120000003A0044004100
      54004100460049004E0045000C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000A000000040000004900440001000000000008000000440041005400
      41000100000000001C0000005400490050004F005F0052004900430048004900
      45005300540041000100000000000A00000053005400410054004F0001000000
      000006000000440041004C000100000000000400000041004C00010000000000
      120000005400490050004F00470049005500530054000100000000000A000000
      440041004F00520045000100000000000800000041004F005200450001000000
      00000E00000044004100540041004E0041005300010000000000}
    ReadOnly = True
    OnCalcFields = selVT050CalcFields
    Left = 25
    Top = 320
    object selVT050ID: TFloatField
      FieldName = 'ID'
      Required = True
      Visible = False
    end
    object selVT050DATA: TDateTimeField
      DisplayLabel = 'Data'
      FieldName = 'DATA'
      Required = True
      Visible = False
      DisplayFormat = 'dd/mm/yyyy'#13#10
    end
    object selVT050T850DATA: TDateTimeField
      DisplayLabel = 'Data richiesta'
      DisplayWidth = 16
      FieldName = 'T850DATA'
      DisplayFormat = 'dd/mm/yyyy hh.mm'
    end
    object selVT050TIPO_RICHIESTA: TStringField
      FieldName = 'TIPO_RICHIESTA'
      Visible = False
      Size = 1
    end
    object selVT050D_TIPO_RICHIESTA: TStringField
      DisplayLabel = 'Tipo'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'D_TIPO_RICHIESTA'
      Calculated = True
    end
    object selVT050STATO: TStringField
      FieldName = 'STATO'
      Visible = False
      Size = 1
    end
    object selVT050D_STATO: TStringField
      DisplayLabel = 'Autorizzata'
      DisplayWidth = 15
      FieldKind = fkCalculated
      FieldName = 'D_STATO'
      Calculated = True
    end
    object selVT050STATO_INTERMEDIO: TStringField
      FieldName = 'STATO_INTERMEDIO'
      Visible = False
      Size = 1
    end
    object selVT050CAUSALE: TStringField
      FieldName = 'CAUSALE'
      Visible = False
      Size = 5
    end
    object selVT050D_CAUSALE: TStringField
      DisplayLabel = 'Causale'
      DisplayWidth = 20
      FieldName = 'D_CAUSALE'
      Size = 50
    end
    object selVT050DAL: TDateTimeField
      DisplayLabel = 'Dal'
      DisplayWidth = 10
      FieldName = 'DAL'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object selVT050AL: TDateTimeField
      DisplayLabel = 'Al'
      DisplayWidth = 10
      FieldName = 'AL'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object selVT050TIPOGIUST: TStringField
      FieldName = 'TIPOGIUST'
      Visible = False
      Size = 1
    end
    object selVT050D_TIPOGIUST: TStringField
      DisplayLabel = 'Tipo giust.'
      FieldKind = fkCalculated
      FieldName = 'D_TIPOGIUST'
      Calculated = True
    end
    object selVT050DAORE: TStringField
      DisplayLabel = 'Dalle'
      FieldName = 'DAORE'
      Size = 5
    end
    object selVT050AORE: TStringField
      DisplayLabel = 'Alle'
      FieldName = 'AORE'
      Size = 5
    end
    object selVT050DATANAS: TDateTimeField
      DisplayLabel = 'Familiare'
      FieldName = 'DATANAS'
    end
  end
  object T230F_GETVALUE: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      '  :VALORE:=T230F_GETVALUE(:CAUSALE,:NOME,:DATA);'
      'END;')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A0044004100540041000C000000000000000000
      0000100000003A00430041005500530041004C00450005000000000000000000
      00000A0000003A004E004F004D0045000500000000000000000000000E000000
      3A00560041004C004F0052004500050000000000000000000000}
    Left = 312
    Top = 320
  end
  object selVT085: TOracleDataSet
    SQL.Strings = (
      'select VT085.T850ID           ID,'
      '       VT085.T850DATA         T850DATA,       '
      '       VT085.T850STATO        STATO,'
      '       VT085.T085DATA_ORARIO  DATA,'
      '       VT085.T085DATA_ORARIO  DATA_ORARIO,'
      '       VT085.T085TIPOGIORNO   TIPOGIORNO, '
      '       VT085.T085GIORNO       ORARIO, '
      '       VT085.T085DATA_INVER   DATA_INVER, '
      '       VT085.T085TIPOGIORNO_INVER TIPOGIORNO_INVER, '
      '       VT085.T085ORARIO_INVER ORARIO_INVER,'
      '       VT085.T850NOTE         NOTE'
      'from   VT085_ITER_RICHIESTECAMBIORARI VT085'
      'where  VT085.PROGRESSIVO = :PROGRESSIVO'
      'and    VT085.T085DATA_ORARIO between :DataInizio and :DataFine'
      'and    VT085.T850STATO is null'
      'and    nvl(VT085.T085SOLO_NOTE,'#39'N'#39') = '#39'N'#39
      ''
      'union '
      ''
      'select VT085.T850ID,'
      '       VT085.T850DATA,       '
      '       VT085.T850STATO,'
      '       VT085.T085DATA_INVER DATA,'
      '       VT085.T085DATA_ORARIO,'
      '       VT085.T085TIPOGIORNO, '
      '       VT085.T085GIORNO, '
      '       VT085.T085DATA_INVER, '
      '       VT085.T085TIPOGIORNO_INVER, '
      '       VT085.T085ORARIO_INVER,'
      '       VT085.T850NOTE'
      'from   VT085_ITER_RICHIESTECAMBIORARI VT085'
      'where  VT085.PROGRESSIVO = :PROGRESSIVO'
      'and    VT085.T085DATA_INVER is not null'
      'and    VT085.T085DATA_INVER between :DataInizio and :DataFine'
      'and    VT085.T850STATO is null'
      'and    nvl(VT085.T085SOLO_NOTE,'#39'N'#39') = '#39'N'#39
      ''
      'order by DATA, ID'
      ''
      '/*CON DESCRIZIONE ORARIO'
      'select VT085.T850ID           ID,'
      '       VT085.T850DATA         T850DATA,       '
      '       VT085.T850STATO        STATO,'
      '       VT085.T085DATA_ORARIO  DATA,'
      '       VT085.T085DATA_ORARIO  DATA_ORARIO,'
      '       VT085.T085TIPOGIORNO   TIPOGIORNO, '
      '       VT085.T085GIORNO       ORARIO,'
      '       T020a.DESCRIZIONE      DESCRIZIONE, '
      '       VT085.T085DATA_INVER   DATA_INVER, '
      '       VT085.T085TIPOGIORNO_INVER TIPOGIORNO_INVER, '
      '       VT085.T085ORARIO_INVER ORARIO_INVER,'
      '       T020b.DESCRIZIONE      DESCRIZIONE_INVER,       '
      '       VT085.T850NOTE         NOTE'
      
        'from   VT085_ITER_RICHIESTECAMBIORARI VT085, T020_ORARI T020a, T' +
        '020_ORARI T020b'
      'where  VT085.PROGRESSIVO = :PROGRESSIVO'
      'and    VT085.T085DATA_ORARIO between :DataInizio and :DataFine'
      'and    VT085.T850STATO is null'
      'and    nvl(VT085.T085SOLO_NOTE,'#39'N'#39') = '#39'N'#39
      'and    T020a.CODICE = T085GIORNO  '
      
        'and    T020a.DECORRENZA = (select max(DECORRENZA) from T020_ORAR' +
        'I where CODICE = T085GIORNO and DECORRENZA < VT085.T085DATA_ORAR' +
        'IO)'
      'and    T020b.CODICE = T085ORARIO_INVER  '
      
        'and    T020b.DECORRENZA = (select max(DECORRENZA) from T020_ORAR' +
        'I where CODICE = T085ORARIO_INVER and DECORRENZA < VT085.T085DAT' +
        'A_INVER)             '
      ''
      'union '
      ''
      'select VT085.T850ID,'
      '       VT085.T850DATA,       '
      '       VT085.T850STATO,'
      '       VT085.T085DATA_INVER DATA,'
      '       VT085.T085DATA_ORARIO,'
      '       VT085.T085TIPOGIORNO, '
      '       VT085.T085GIORNO, '
      '       T020a.DESCRIZIONE,'
      '       VT085.T085DATA_INVER, '
      '       VT085.T085TIPOGIORNO_INVER,'
      '       VT085.T085ORARIO_INVER,'
      '       T020b.DESCRIZIONE,        '
      '       VT085.T850NOTE'
      
        'from   VT085_ITER_RICHIESTECAMBIORARI VT085, T020_ORARI T020a, T' +
        '020_ORARI T020b'
      'where  VT085.PROGRESSIVO = :PROGRESSIVO'
      'and    VT085.T085DATA_INVER is not null'
      'and    VT085.T085DATA_INVER between :DataInizio and :DataFine'
      'and    VT085.T850STATO is null'
      'and    nvl(VT085.T085SOLO_NOTE,'#39'N'#39') = '#39'N'#39
      'and    T020a.CODICE = T085GIORNO  '
      
        'and    T020a.DECORRENZA = (select max(DECORRENZA) from T020_ORAR' +
        'I where CODICE = T085GIORNO and DECORRENZA < VT085.T085DATA_ORAR' +
        'IO)'
      'and    T020b.CODICE = T085ORARIO_INVER  '
      
        'and    T020b.DECORRENZA = (select max(DECORRENZA) from T020_ORAR' +
        'I where CODICE = T085ORARIO_INVER and DECORRENZA < VT085.T085DAT' +
        'A_INVER) '
      ''
      'order by DATA, ID*/')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000160000003A0044004100540041004900
      4E0049005A0049004F000C0000000000000000000000120000003A0044004100
      54004100460049004E0045000C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      0500000009000000040000004900440001000000000008000000440041005400
      41000100000000001C0000005400490050004F005F0052004900430048004900
      45005300540041000100000000000A00000053005400410054004F0001000000
      0000060000004F00520041000100000000000A00000056004500520053004F00
      0100000000000E000000430041005500530041004C0045000100000000001E00
      0000520049004C0045005600410054004F00520045005F005200490043004800
      010000000000140000004F0050004500520041005A0049004F004E0045000100
      00000000}
    ReadOnly = True
    OnCalcFields = selVT085CalcFields
    Left = 168
    Top = 320
    object selVT085ID: TFloatField
      DisplayWidth = 8
      FieldName = 'ID'
      Required = True
      Visible = False
    end
    object selVT085IDT850DATA: TDateTimeField
      DisplayLabel = 'Data richiesta'
      DisplayWidth = 16
      FieldName = 'T850DATA'
      DisplayFormat = 'dd/mm/yyyy hh.mm'
    end
    object selVT085STATO: TStringField
      FieldName = 'STATO'
      Visible = False
      Size = 1
    end
    object selVT085D_STATO: TStringField
      DisplayLabel = 'Autorizzata'
      DisplayWidth = 12
      FieldKind = fkCalculated
      FieldName = 'D_STATO'
      Visible = False
      Calculated = True
    end
    object selVT085DATA: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
      Visible = False
      DisplayFormat = 'dd/mm/yyyy'
    end
    object selVT085DATA_ORARIO: TDateTimeField
      DisplayLabel = 'Giorno'
      DisplayWidth = 10
      FieldName = 'DATA_ORARIO'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object selVT085TIPOGIORNO: TStringField
      FieldName = 'TIPOGIORNO'
      Visible = False
      Size = 1
    end
    object selVT085D_TIPOGIORNO: TStringField
      DisplayLabel = 'Tipo giorno'
      DisplayWidth = 15
      FieldKind = fkCalculated
      FieldName = 'D_TIPOGIORNO'
      Calculated = True
    end
    object selVT085ORARIO: TStringField
      DisplayLabel = 'Orario'
      DisplayWidth = 7
      FieldName = 'ORARIO'
      Size = 5
    end
    object selVT085DATA_INVER: TDateTimeField
      DisplayLabel = 'Giorno invertito'
      DisplayWidth = 10
      FieldName = 'DATA_INVER'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object selVT085TIPOGIORNO_INVER: TStringField
      DisplayLabel = 'Tipo giorno'
      FieldName = 'TIPOGIORNO_INVER'
      Visible = False
      Size = 1
    end
    object selVT085D_TIPOGIORNO_INVER: TStringField
      DisplayLabel = 'Tipo giorno'
      DisplayWidth = 15
      FieldKind = fkCalculated
      FieldName = 'D_TIPOGIORNO_INVER'
      Calculated = True
    end
    object selVT085ORARIO_INVER: TStringField
      DisplayLabel = 'Orario'
      DisplayWidth = 7
      FieldName = 'ORARIO_INVER'
      Size = 5
    end
    object selVT085NOTE: TStringField
      DisplayLabel = 'Note'
      DisplayWidth = 30
      FieldName = 'NOTE'
      Size = 2000
    end
  end
end
