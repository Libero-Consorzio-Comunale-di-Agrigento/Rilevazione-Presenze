inherited S715FStampaValutazioniDtM: TS715FStampaValutazioniDtM
  OldCreateOrder = True
  Height = 371
  Width = 762
  object cdsStampaAnagrafico: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'PROG_VALUTATO'
        DataType = ftInteger
      end
      item
        Name = 'DATA_VALUTAZIONE'
        DataType = ftDateTime
      end
      item
        Name = 'DAL'
        DataType = ftDateTime
      end
      item
        Name = 'AL'
        DataType = ftDateTime
      end
      item
        Name = 'TIPO_VALUTAZIONE'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'CODREGOLA'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'STATO_AVANZAMENTO'
        DataType = ftInteger
      end
      item
        Name = 'ANNO_VALUTAZIONE'
        DataType = ftInteger
      end
      item
        Name = 'DATARIF'
        DataType = ftDateTime
      end
      item
        Name = 'DATA_COMPILAZIONE'
        DataType = ftDateTime
      end
      item
        Name = 'PERIODO_VALUTAZIONE'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'MATR_VALUTATO'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'NOM_VALUTATO'
        DataType = ftString
        Size = 61
      end
      item
        Name = 'DATO1_VALUTATO'
        DataType = ftString
        Size = 120
      end
      item
        Name = 'DATO2_VALUTATO'
        DataType = ftString
        Size = 120
      end
      item
        Name = 'DATO3_VALUTATO'
        DataType = ftString
        Size = 120
      end
      item
        Name = 'DATO4_VALUTATO'
        DataType = ftString
        Size = 120
      end
      item
        Name = 'DATO5_VALUTATO'
        DataType = ftString
        Size = 500
      end
      item
        Name = 'DATO6_VALUTATO'
        DataType = ftString
        Size = 120
      end
      item
        Name = 'MATR_VALUTATORE'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'NOM_VALUTATORE'
        DataType = ftString
        Size = 310
      end
      item
        Name = 'N_VALUTATORI'
        DataType = ftInteger
      end
      item
        Name = 'VALUTAZIONE_INTERMEDIA'
        DataType = ftString
        Size = 4000
      end
      item
        Name = 'VALUTAZIONI_COMPLESSIVE'
        DataType = ftString
        Size = 4000
      end
      item
        Name = 'OBIETTIVI_PIANIFICATI'
        DataType = ftString
        Size = 500
      end
      item
        Name = 'IMPORTO_INCENTIVO'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'ORE_INCENTIVO'
        DataType = ftString
        Size = 7
      end
      item
        Name = 'ACCETTAZIONE_OBIETTIVI'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'NOTE_INCENTIVO'
        DataType = ftString
        Size = 500
      end
      item
        Name = 'PROPOSTE_FORMATIVE'
        DataType = ftString
        Size = 800
      end
      item
        Name = 'COMMENTI_VALUTATO'
        DataType = ftString
        Size = 500
      end
      item
        Name = 'ACCETTAZIONE_VALUTATO'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'DATA_ACCETTAZIONE_VALUTATO'
        DataType = ftDateTime
      end
      item
        Name = 'NOTE'
        DataType = ftString
        Size = 500
      end
      item
        Name = 'CALCOLO_PFP'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'PUNTEGGIO_FINALE_PESATO'
        DataType = ftString
        Size = 6
      end
      item
        Name = 'CHIUSO'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'DATA_CHIUSURA'
        DataType = ftDateTime
      end
      item
        Name = 'FIRMA_1'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'FIRMA_2'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'FIRMA_3'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'FIRMA_4'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'FIRMA_5'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'FIRMA_6'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'LEGENDA_PUNTEGGI'
        DataType = ftString
        Size = 500
      end
      item
        Name = 'SCAGLIONI_INCENTIVI'
        DataType = ftString
        Size = 500
      end
      item
        Name = 'PRESA_VISIONE'
        DataType = ftString
        Size = 500
      end
      item
        Name = 'VIS_COL_VALUTABILE'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'VIS_COL_SOGLIA_PUNTEGGIO'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'STATO_SCHEDA'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'PUNTEGGI_ASSEGNATI'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'NUMEROEANNO_PROTOCOLLO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'DATA_PROTOCOLLO'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    AfterScroll = cdsStampaAnagraficoAfterScroll
    Left = 568
    Top = 256
  end
  object cdsStampaElementi: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'PROG_VALUTATO'
        DataType = ftInteger
      end
      item
        Name = 'DATA_VALUTAZIONE'
        DataType = ftDateTime
      end
      item
        Name = 'TIPO_VALUTAZIONE'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'STATO_AVANZAMENTO'
        DataType = ftInteger
      end
      item
        Name = 'COD_AREA'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'DESC_AREA'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'PERC_AREA'
        DataType = ftFloat
      end
      item
        Name = 'PUNTEGGIO_AREA'
        DataType = ftString
        Size = 7
      end
      item
        Name = 'COD_VALUTAZIONE'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'DESC_VALUTAZIONE'
        DataType = ftString
        Size = 1000
      end
      item
        Name = 'ITEM_PERSONALIZZATO'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'PERC_VALUTAZIONE'
        DataType = ftString
        Size = 6
      end
      item
        Name = 'SOGLIA_PUNTEGGIO'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'VALUTABILE'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'D_PUNTEGGIO'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'NOTE_PUNTEGGIO'
        DataType = ftString
        Size = 500
      end
      item
        Name = 'PUNTEGGIO_PESATO'
        DataType = ftString
        Size = 7
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 568
    Top = 304
  end
  object selSG710: TOracleDataSet
    SQL.Strings = (
      'SELECT SG710.*, SG745.esito, SG710.ROWID'
      'FROM   SG710_TESTATA_VALUTAZIONI SG710,'
      '       SG745_CONSEGNA_VALUTAZIONI SG745'
      'WHERE  SG710.progressivo = :PROGRESSIVO'
      'AND    SG710.data BETWEEN :D_INI AND :D_FIN'
      'AND    SG710.tipo_valutazione IN (:TIPO_VAL)'
      'AND    SG745.data (+) = SG710.data'
      'AND    SG745.progressivo (+) = SG710.progressivo'
      'AND    SG745.tipo_valutazione (+) = SG710.tipo_valutazione'
      'AND    SG745.stato_avanzamento (+) = SG710.stato_avanzamento'
      'AND    SG745.prog_utente (+) = SG710.progressivo'
      'AND    SG745.tipo_consegna (+) = '#39'PV'#39
      
        'ORDER BY SG710.DATA, SG710.TIPO_VALUTAZIONE, SG710.STATO_AVANZAM' +
        'ENTO')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044005F0049004E004900
      0C00000000000000000000000C0000003A0044005F00460049004E000C000000
      0000000000000000120000003A005400490050004F005F00560041004C000100
      00000000000000000000}
    CommitOnPost = False
    Left = 272
    Top = 16
  end
  object selSG705: TOracleDataSet
    SQL.Strings = (
      'SELECT SG705.PROGRESSIVO'
      'FROM   SG705_VALUTATORI SG705'
      'WHERE  SG705.DATO = :DATO'
      'AND    SG705.DATO2 = :DATO2'
      'AND    :DATA BETWEEN DECORRENZA AND DECORRENZA_FINE')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A004400410054004F0005000000000000000000
      00000A0000003A0044004100540041000C00000000000000000000000C000000
      3A004400410054004F003200050000000000000000000000}
    Left = 176
    Top = 16
  end
  object selSG706: TOracleDataSet
    SQL.Strings = (
      'SELECT SG706.PROGRESSIVO'
      'FROM   SG706_VALUTATORI_DIPENDENTE SG706'
      'WHERE  SG706.PROGRESSIVO_VALUTATO = :PROGRESSIVO'
      'AND    :DATA BETWEEN SG706.DECORRENZA AND SG706.DECORRENZA_FINE'
      '')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A0044004100540041000C000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      00000000000000000000}
    Left = 224
    Top = 16
  end
  object selSQL: TOracleDataSet
    Optimize = False
    Left = 112
    Top = 152
  end
  object selSG711: TOracleDataSet
    SQL.Strings = (
      'SELECT SG711.*, SG711.ROWID'
      'FROM   SG711_VALUTAZIONI_DIPENDENTE SG711'
      'WHERE  PROGRESSIVO = :PROGRESSIVO'
      'AND    DATA = :DATA'
      'AND    TIPO_VALUTAZIONE = :TIPO_VAL'
      'AND    STATO_AVANZAMENTO = :STATO_AVANZAMENTO'
      'ORDER BY COD_AREA, COD_VALUTAZIONE')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000120000003A005400490050004F005F00
      560041004C000500000000000000000000000A0000003A004400410054004100
      0C0000000000000000000000240000003A0053005400410054004F005F004100
      560041004E005A0041004D0045004E0054004F00030000000000000000000000}
    CommitOnPost = False
    Left = 328
    Top = 16
  end
  object selSG700: TOracleDataSet
    SQL.Strings = (
      'SELECT SG700.*, SG701.DESCRIZIONE D_AREA'
      'FROM SG700_VALUTAZIONI SG700, SG701_AREE_VALUTAZIONI SG701'
      'WHERE SG700.COD_AREA (+) = SG701.COD_AREA'
      'AND SG700.DECORRENZA (+) = SG701.DECORRENZA'
      'AND SG701.COD_AREA = :COD_AREA'
      'AND :DATA BETWEEN SG701.DECORRENZA AND SG701.DECORRENZA_FINE'
      'ORDER BY SG700.COD_VALUTAZIONE')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A0044004100540041000C000000000000000000
      0000120000003A0043004F0044005F0041005200450041000500000000000000
      00000000}
    Left = 80
    Top = 16
  end
  object updSG710: TOracleQuery
    SQL.Strings = (
      'UPDATE SG710_TESTATA_VALUTAZIONI'
      'SET CHIUSO = :CHIUSO,'
      
        '    DATA_CHIUSURA = DECODE(:CHIUSO,'#39'S'#39',DECODE(DATA_CHIUSURA,NULL' +
        ',TRUNC(SYSDATE),DATA_CHIUSURA),NULL),'
      
        '    DATA_COMPILAZIONE = DECODE(:AGGIORNA,'#39'S'#39',DECODE(DATA_CHIUSUR' +
        'A,NULL,TRUNC(SYSDATE),DATA_COMPILAZIONE),DATA_COMPILAZIONE)'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      'AND   DATA = :DATA'
      'AND   TIPO_VALUTAZIONE = :TIPO_VAL'
      'AND   STATO_AVANZAMENTO = :STATO_AVANZAMENTO')
    Optimize = False
    Variables.Data = {
      0400000006000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000120000003A005400490050004F005F00560041004C00
      0500000000000000000000000E0000003A00430048004900550053004F000500
      00000000000000000000120000003A0041004700470049004F0052004E004100
      050000000000000000000000240000003A0053005400410054004F005F004100
      560041004E005A0041004D0045004E0054004F00030000000000000000000000}
    Left = 272
    Top = 264
  end
  object D010: TDataSource
    Left = 16
    Top = 16
  end
  object selSG741: TOracleDataSet
    SQL.Strings = (
      'SELECT SG741.*'
      'FROM SG741_REGOLE_VALUTAZIONI SG741'
      'WHERE (CODICE = :CODICE OR :CODICE IS NULL)'
      
        'AND (:DATA BETWEEN DECORRENZA AND DECORRENZA_FINE OR :DATA IS NU' +
        'LL)'
      'ORDER BY CODICE')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A0043004F004400490043004500050000000000
      0000000000000A0000003A0044004100540041000C0000000000000000000000}
    Left = 472
    Top = 16
  end
  object selSG730: TOracleDataSet
    SQL.Strings = (
      'SELECT SG730.*'
      'FROM SG730_PUNTEGGI SG730'
      
        'WHERE :DATA_VAL BETWEEN SG730.DECORRENZA AND SG730.DECORRENZA_FI' +
        'NE'
      'AND DATO1 = :DATO1'
      
        'ORDER BY DECODE(SG730.ITEM_GIUDICABILE,'#39'S'#39',1,2), SG730.PUNTEGGIO' +
        ', SG730.CODICE')
    Optimize = False
    Variables.Data = {
      0400000002000000120000003A0044004100540041005F00560041004C000C00
      000000000000000000000C0000003A004400410054004F003100050000000000
      000000000000}
    Left = 376
    Top = 16
  end
  object selT775: TOracleDataSet
    SQL.Strings = (
      'select t775.DECORRENZA,'
      '       greatest(t775.DECORRENZA,:DATAINIZIO) dec_periodo,'
      '       t775.SCADENZA,'
      '       least(t775.SCADENZA,:DATAFINE) scad_periodo,'
      '       t775.perc_individuale,'
      '       t775.rowid'
      'from T775_QUOTEINDIVIDUALI t775'
      'WHERE t775.PROGRESSIVO = :PROGRESSIVO'
      'AND t775.DECORRENZA <= :DATAFINE'
      'AND t775.SCADENZA >= :DATAINIZIO'
      'AND t775.CODTIPOQUOTA = :CODTIPOQUOTA'
      'ORDER BY t775.DECORRENZA')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000120000003A0044004100540041004600
      49004E0045000C0000000000000000000000160000003A004400410054004100
      49004E0049005A0049004F000C00000000000000000000001A0000003A004300
      4F0044005400490050004F00510055004F005400410005000000000000000000
      0000}
    CommitOnPost = False
    Left = 63
    Top = 208
  end
  object insT775: TOracleQuery
    SQL.Strings = (
      
        'insert into T775_QUOTEINDIVIDUALI (progressivo,decorrenza,scaden' +
        'za,codtipoquota,importo,perc_individuale) values (:valori)')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A00560041004C004F0052004900010000000000
      000000000000}
    Left = 63
    Top = 256
  end
  object insT775a: TOracleQuery
    SQL.Strings = (
      'insert into T775_QUOTEINDIVIDUALI (:campi) '
      'select :valori '
      'from T775_QUOTEINDIVIDUALI '
      'where progressivo = :progressivo '
      'and decorrenza = :decorrenza'
      'and codtipoquota = :codtipoquota')
    Optimize = False
    Variables.Data = {
      04000000050000000E0000003A00560041004C004F0052004900010000000000
      0000000000000C0000003A00430041004D005000490001000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      00000000000000000000160000003A004400450043004F005200520045004E00
      5A0041000C00000000000000000000001A0000003A0043004F00440054004900
      50004F00510055004F0054004100050000000000000000000000}
    Left = 63
    Top = 304
  end
  object selCols: TOracleDataSet
    SQL.Strings = (
      'select COLUMN_NAME'
      'from cols'
      'where table_name = :TABELLA'
      'order by COLUMN_ID')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0054004100420045004C004C00410005000000
      0000000000000000}
    Left = 63
    Top = 152
  end
  object selSG735b: TOracleQuery
    SQL.Strings = (
      'SELECT PERC'
      'FROM SG735_PUNTEGGIFASCE_INCENTIVI'
      'WHERE TIPOLOGIA = '#39'V'#39
      'AND CODQUOTA = :QUOTA'
      'AND :DATA_VAL BETWEEN DECORRENZA AND DECORRENZA_FINE'
      'AND :PUNTEGGIO BETWEEN PUNTEGGIO_DA AND PUNTEGGIO_A')
    Optimize = False
    Variables.Data = {
      0400000003000000120000003A0044004100540041005F00560041004C000C00
      00000000000000000000140000003A00500055004E0054004500470047004900
      4F000400000000000000000000000C0000003A00510055004F00540041000500
      00000000000000000000}
    Left = 424
    Top = 64
  end
  object selSG710a: TOracleQuery
    SQL.Strings = (
      'select count(*)'
      'from sg710_testata_valutazioni'
      'where progressivo = :progressivo'
      'and data > :data'
      'and chiuso = '#39'S'#39
      'and tipo_valutazione = :tipo')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A005400490050004F000500
      000000000000000000000A0000003A0044004100540041000C00000000000000
      00000000}
    Left = 271
    Top = 64
  end
  object selFormaz: TOracleDataSet
    SQL.Strings = (
      
        'SELECT '#39'A'#39' CODICE, '#39'Formazione residenziale'#39' DESCRIZIONE, 1 ORDI' +
        'NE'
      'FROM DUAL'
      'UNION'
      'SELECT '#39'B'#39' CODICE, '#39'Formazione sul campo'#39' DESCRIZIONE, 2 ORDINE'
      'FROM DUAL'
      'UNION'
      'SELECT '#39'C'#39' CODICE, '#39'Affiancamento'#39' DESCRIZIONE, 3 ORDINE'
      'FROM DUAL'
      'UNION'
      'SELECT '#39'D'#39' CODICE, '#39'Formazione a distanza'#39' DESCRIZIONE, 4 ORDINE'
      'FROM DUAL'
      'UNION'
      'SELECT '#39'Z'#39' CODICE, '#39'Altro'#39' DESCRIZIONE, 5 ORDINE'
      'FROM DUAL'
      'ORDER BY ORDINE')
    Optimize = False
    Left = 16
    Top = 152
    object selFormazCODICE: TStringField
      FieldName = 'CODICE'
      Size = 1
    end
    object selFormazDESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 30
    end
    object selFormazORDINE: TFloatField
      FieldName = 'ORDINE'
    end
  end
  object selT430a: TOracleDataSet
    SQL.Strings = (
      'SELECT COUNT(*) N_VARIAZIONI'
      'FROM T430_STORICO T1'
      'WHERE T1.PROGRESSIVO = :PROGRESSIVO'
      'AND :DATARIF BETWEEN T1.DATADECORRENZA AND T1.DATAFINE'
      'AND EXISTS (SELECT 1'
      '            FROM T430_STORICO T2'
      '            WHERE T2.PROGRESSIVO = T1.PROGRESSIVO'
      '            AND T2.:DATO <> T1.:DATO'
      '            AND T2.DATADECORRENZA < T1.DATADECORRENZA'
      '            AND T2.DATAFINE >= :DATAINI)')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A0044004100540041005200
      490046000C00000000000000000000000A0000003A004400410054004F000100
      00000000000000000000100000003A00440041005400410049004E0049000C00
      00000000000000000000}
    Left = 64
    Top = 96
  end
  object selV430: TOracleDataSet
    SQL.Strings = (
      'select DISTINCT t030.matricola, t030.cognome, t030.nome'
      'from :QVistaOracle'
      'and :filtro'
      'and t030.progressivo = :progressivo'
      'order by 2,3,1')
    ReadBuffer = 5000
    Optimize = False
    Variables.Data = {
      04000000040000000E0000003A00460049004C00540052004F00010000000000
      0000000000001A0000003A005100560049005300540041004F00520041004300
      4C004500010000000000000000000000160000003A0044004100540041004C00
      410056004F0052004F000C0000000000000000000000180000003A0050005200
      4F0047005200450053005300490056004F00030000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000500000016000000500052004F004700520045005300530049005600
      4F00010000000000120000004D00410054005200490043004F004C0041000100
      000000000E00000043004F0047004E004F004D00450001000000000008000000
      4E004F004D004500010000000000140000004700470053004500520056004900
      5A0049004F00010000000000}
    Left = 112
    Top = 96
    object selV430MATRICOLA: TStringField
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selV430COGNOME: TStringField
      DisplayWidth = 30
      FieldName = 'COGNOME'
      Size = 50
    end
    object selV430NOME: TStringField
      DisplayWidth = 30
      FieldName = 'NOME'
      Size = 50
    end
  end
  object cdsRegole: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'DATA'
        DataType = ftDateTime
      end
      item
        Name = 'PROGRESSIVO'
        DataType = ftInteger
      end
      item
        Name = 'CODICE'
        DataType = ftString
        Size = 5
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 568
    Top = 208
  end
  object selSG701: TOracleDataSet
    SQL.Strings = (
      'SELECT *'
      'FROM SG701_AREE_VALUTAZIONI'
      'WHERE COD_AREA = :COD_AREA'
      'AND :DATA BETWEEN DECORRENZA AND DECORRENZA_FINE'
      '')
    Optimize = False
    Variables.Data = {
      0400000002000000120000003A0043004F0044005F0041005200450041000500
      000000000000000000000A0000003A0044004100540041000C00000000000000
      00000000}
    Left = 128
    Top = 16
  end
  object selSG711c: TOracleDataSet
    SQL.Strings = (
      'SELECT T.PERC_VALUTAZIONE, T.VALUTABILE, T.PUNTEGGIO_PESATO'
      'FROM   SG711_VALUTAZIONI_DIPENDENTE T'
      'WHERE  DATA = :DATA'
      'AND    PROGRESSIVO = :PROGRESSIVO'
      'AND    COD_AREA = :COD_AREA'
      'AND    TIPO_VALUTAZIONE = :TIPO_VALUTAZIONE'
      'AND    STATO_AVANZAMENTO = :STATO_AVANZAMENTO')
    Optimize = False
    Variables.Data = {
      0400000005000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000240000003A0053005400410054004F005F0041005600
      41004E005A0041004D0045004E0054004F000300000000000000000000001200
      00003A0043004F0044005F004100520045004100050000000000000000000000
      220000003A005400490050004F005F00560041004C005500540041005A004900
      4F004E004500050000000000000000000000}
    Left = 328
    Top = 160
  end
  object selSchedeCollegateAperte: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T030.MATRICOLA, T030.COGNOME, T030.NOME, SG710.DATA, SG71' +
        '1.COD_AREA, SG711.COD_VALUTAZIONE, SG701.DESCRIZIONE || '#39' - '#39' ||' +
        ' SG700.DESCRIZIONE DESCRIZIONE'
      
        'FROM SG711_VALUTAZIONI_DIPENDENTE SG711, SG710_TESTATA_VALUTAZIO' +
        'NI SG710, T030_ANAGRAFICO T030, SG701_AREE_VALUTAZIONI SG701, SG' +
        '700_VALUTAZIONI SG700,'
      '     (SELECT /*+ unnest*/ COD_AREA_LINK, COD_VALUTAZIONE_LINK'
      
        '      FROM SG711_VALUTAZIONI_DIPENDENTE SG711A, SG701_AREE_VALUT' +
        'AZIONI SG701A, SG700_VALUTAZIONI SG700A'
      '      WHERE SG711A.PROGRESSIVO = :PROGRESSIVO'
      '      AND SG711A.DATA = :DATA'
      '      AND SG711A.TIPO_VALUTAZIONE = :TIPO_VALUTAZIONE'
      '      AND SG711A.STATO_AVANZAMENTO = :STATO_AVANZAMENTO'
      '      AND SG701A.COD_AREA = SG711A.COD_AREA'
      
        '      AND :DATA BETWEEN SG701A.DECORRENZA AND SG701A.DECORRENZA_' +
        'FINE'
      '      AND SG700A.COD_AREA = SG701A.COD_AREA'
      '      AND SG700A.DECORRENZA = SG701A.DECORRENZA'
      '      AND (    SG701A.TIPO_LINK_ITEM = '#39'1'#39
      
        '           OR (SG701A.TIPO_LINK_ITEM = '#39'2'#39' AND SG700A.COD_VALUTA' +
        'ZIONE = SG711A.COD_VALUTAZIONE))'
      '      ) LINK'
      'WHERE SG711.COD_AREA = LINK.COD_AREA_LINK'
      'AND SG711.COD_VALUTAZIONE = LINK.COD_VALUTAZIONE_LINK'
      'AND :DATA BETWEEN NVL((SELECT MAX(SG711B.DATA) + 1'
      '                       FROM SG711_VALUTAZIONI_DIPENDENTE SG711B'
      '                       WHERE SG711B.DATA >= TRUNC(:DATA,'#39'Y'#39') '
      '                       AND SG711B.DATA < SG711.DATA'
      
        '                       AND SG711B.PROGRESSIVO = SG711.PROGRESSIV' +
        'O'
      
        '                       AND SG711B.TIPO_VALUTAZIONE = SG711.TIPO_' +
        'VALUTAZIONE)'
      '                      ,TRUNC(:DATA,'#39'Y'#39')) '
      '              AND SG711.DATA'
      'AND SG711.TIPO_VALUTAZIONE = :TIPO_VALUTAZIONE'
      
        'AND SG711.STATO_AVANZAMENTO = (SELECT MAX(SG711B.STATO_AVANZAMEN' +
        'TO)'
      
        '                               FROM SG711_VALUTAZIONI_DIPENDENTE' +
        ' SG711B'
      '                               WHERE SG711B.DATA = SG711.DATA'
      
        '                               AND SG711B.PROGRESSIVO = SG711.PR' +
        'OGRESSIVO'
      
        '                               AND SG711B.TIPO_VALUTAZIONE = SG7' +
        '11.TIPO_VALUTAZIONE)'
      'AND SG710.PROGRESSIVO = SG711.PROGRESSIVO'
      'AND SG710.DATA = SG711.DATA'
      'AND SG710.TIPO_VALUTAZIONE = SG711.TIPO_VALUTAZIONE'
      'AND SG710.STATO_AVANZAMENTO = SG711.STATO_AVANZAMENTO'
      'AND SG710.CHIUSO = '#39'N'#39
      'AND T030.PROGRESSIVO = SG710.PROGRESSIVO'
      
        'AND SG711.DATA BETWEEN SG701.DECORRENZA AND SG701.DECORRENZA_FIN' +
        'E'
      'AND SG701.COD_AREA = SG711.COD_AREA '
      'AND SG700.DECORRENZA = SG701.DECORRENZA'
      'AND SG700.COD_AREA = SG701.COD_AREA '
      'AND SG700.COD_VALUTAZIONE = SG711.COD_VALUTAZIONE '
      
        'ORDER BY T030.COGNOME, T030.NOME, T030.MATRICOLA, SG710.DATA, SG' +
        '711.COD_AREA, SG711.COD_VALUTAZIONE')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A0044004100540041000C000000000000000000
      0000220000003A005400490050004F005F00560041004C005500540041005A00
      49004F004E004500050000000000000000000000180000003A00500052004F00
      47005200450053005300490056004F0003000000000000000000000024000000
      3A0053005400410054004F005F004100560041004E005A0041004D0045004E00
      54004F00030000000000000000000000}
    Left = 568
    Top = 96
  end
  object selSchedeCollegateChiuse: TOracleDataSet
    SQL.Strings = (
      
        'SELECT DISTINCT T030.MATRICOLA, T030.COGNOME, T030.NOME, SG710.D' +
        'ATA, SG711.COD_AREA,'
      
        '       DECODE(SG701.TIPO_LINK_ITEM,'#39'1'#39','#39#39',SG711.COD_VALUTAZIONE)' +
        ' COD_VALUTAZIONE, '
      
        '       SG701.DESCRIZIONE ||  DECODE(SG701.TIPO_LINK_ITEM,'#39'1'#39','#39#39',' +
        #39' - '#39' || SG700.DESCRIZIONE) DESCRIZIONE'
      
        'FROM SG711_VALUTAZIONI_DIPENDENTE SG711, SG710_TESTATA_VALUTAZIO' +
        'NI SG710, T030_ANAGRAFICO T030, SG701_AREE_VALUTAZIONI SG701, SG' +
        '700_VALUTAZIONI SG700,'
      
        '      (SELECT /*+ unnest*/ SG711A.COD_AREA, SG711A.COD_VALUTAZIO' +
        'NE'
      
        '      FROM SG711_VALUTAZIONI_DIPENDENTE SG711A, SG701_AREE_VALUT' +
        'AZIONI SG701A'
      '      WHERE SG711A.PROGRESSIVO = :PROGRESSIVO'
      '      AND SG711A.DATA = :DATA'
      '      AND SG711A.TIPO_VALUTAZIONE = :TIPO_VALUTAZIONE'
      '      AND SG711A.STATO_AVANZAMENTO = :STATO_AVANZAMENTO'
      '      AND SG701A.COD_AREA = SG711A.COD_AREA'
      
        '      AND :DATA BETWEEN SG701A.DECORRENZA AND SG701A.DECORRENZA_' +
        'FINE'
      '      AND SG701A.TIPO_LINK_ITEM = '#39'0'#39') LINK'
      'WHERE SG711.DATA BETWEEN NVL((SELECT MAX(SG711B.DATA) + 1'
      
        '                              FROM SG711_VALUTAZIONI_DIPENDENTE ' +
        'SG711B'
      
        '                              WHERE SG711B.DATA >= TRUNC(:DATA,'#39 +
        'Y'#39') '
      '                              AND SG711B.DATA < :DATA'
      
        '                              AND SG711B.PROGRESSIVO = :PROGRESS' +
        'IVO'
      
        '                              AND SG711B.TIPO_VALUTAZIONE = :TIP' +
        'O_VALUTAZIONE)'
      '                             ,TRUNC(:DATA,'#39'Y'#39')) '
      '                     AND :DATA'
      'AND SG711.TIPO_VALUTAZIONE = :TIPO_VALUTAZIONE'
      
        'AND SG711.STATO_AVANZAMENTO = (SELECT MAX(SG711B.STATO_AVANZAMEN' +
        'TO)'
      
        '                               FROM SG711_VALUTAZIONI_DIPENDENTE' +
        ' SG711B'
      '                               WHERE SG711B.DATA = SG711.DATA'
      
        '                               AND SG711B.PROGRESSIVO = SG711.PR' +
        'OGRESSIVO'
      
        '                               AND SG711B.TIPO_VALUTAZIONE = SG7' +
        '11.TIPO_VALUTAZIONE)'
      'AND SG710.PROGRESSIVO = SG711.PROGRESSIVO'
      'AND SG710.DATA = SG711.DATA'
      'AND SG710.TIPO_VALUTAZIONE = SG711.TIPO_VALUTAZIONE'
      'AND SG710.STATO_AVANZAMENTO = SG711.STATO_AVANZAMENTO'
      'AND SG710.CHIUSO = '#39'S'#39
      'AND T030.PROGRESSIVO = SG710.PROGRESSIVO'
      
        'AND SG711.DATA BETWEEN SG701.DECORRENZA AND SG701.DECORRENZA_FIN' +
        'E'
      'AND SG701.COD_AREA = SG711.COD_AREA '
      'AND SG700.DECORRENZA = SG701.DECORRENZA'
      'AND SG700.COD_AREA = SG701.COD_AREA '
      
        'AND (SG701.TIPO_LINK_ITEM = '#39'1'#39' OR (SG701.TIPO_LINK_ITEM = '#39'2'#39' A' +
        'ND SG700.COD_VALUTAZIONE = SG711.COD_VALUTAZIONE))'
      'AND SG700.COD_AREA_LINK = LINK.COD_AREA'
      'AND SG700.COD_VALUTAZIONE_LINK = LINK.COD_VALUTAZIONE'
      
        'ORDER BY T030.COGNOME, T030.NOME, T030.MATRICOLA, SG710.DATA, SG' +
        '711.COD_AREA, COD_VALUTAZIONE')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A0044004100540041000C000000000000000000
      0000220000003A005400490050004F005F00560041004C005500540041005A00
      49004F004E004500050000000000000000000000180000003A00500052004F00
      47005200450053005300490056004F0003000000000000000000000024000000
      3A0053005400410054004F005F004100560041004E005A0041004D0045004E00
      54004F00030000000000000000000000}
    Left = 568
    Top = 144
  end
  object insSG710: TOracleQuery
    SQL.Strings = (
      'INSERT INTO SG710_TESTATA_VALUTAZIONI'
      
        '(DATA,PROGRESSIVO,TIPO_VALUTAZIONE,VALUTAZIONE_COMPLESSIVE,OBIET' +
        'TIVI_AZIONI,PROPOSTE_FORMATIVE,COMMENTI_VALUTATO,DATA_COMPILAZIO' +
        'NE,'
      
        ' CHIUSO,DATA_CHIUSURA,ACCETTAZIONE_VALUTATO,PROPOSTE_FORMATIVE_1' +
        ',PROPOSTE_FORMATIVE_2,PROPOSTE_FORMATIVE_3,VALUTABILE,'
      
        ' IMPORTO_INCENTIVO,ORE_INCENTIVO,ACCETTAZIONE_OBIETTIVI,STATO_AV' +
        'ANZAMENTO,PROGRESSIVI_VALUTATORI,PUNTEGGIO_FINALE_PESATO,NOTE,'
      
        ' CODREGOLA,DAL,AL,NUMERO_PROTOCOLLO,ANNO_PROTOCOLLO,DATA_PROTOCO' +
        'LLO,TIPO_PROTOCOLLO)'
      'SELECT'
      
        ' DATA,PROGRESSIVO,TIPO_VALUTAZIONE,VALUTAZIONE_COMPLESSIVE,OBIET' +
        'TIVI_AZIONI,PROPOSTE_FORMATIVE,DECODE(:COMMENTI_VALUTATO_DIP,'#39'S'#39 +
        ',NULL,COMMENTI_VALUTATO) COMMENTI_VALUTATO,DATA_COMPILAZIONE,'
      
        ' CHIUSO,DATA_CHIUSURA,DECODE(:COMMENTI_VALUTATO_DIP,'#39'S'#39','#39#39',ACCET' +
        'TAZIONE_VALUTATO) ACCETTAZIONE_VALUTATO,PROPOSTE_FORMATIVE_1,PRO' +
        'POSTE_FORMATIVE_2,PROPOSTE_FORMATIVE_3,VALUTABILE,'
      
        ' IMPORTO_INCENTIVO,ORE_INCENTIVO,ACCETTAZIONE_OBIETTIVI,STATO_AV' +
        'ANZAMENTO + 1,PROGRESSIVI_VALUTATORI,PUNTEGGIO_FINALE_PESATO,NOT' +
        'E,'
      
        ' CODREGOLA,DAL,AL,NUMERO_PROTOCOLLO,ANNO_PROTOCOLLO,DATA_PROTOCO' +
        'LLO,TIPO_PROTOCOLLO'
      'FROM SG710_TESTATA_VALUTAZIONI'
      'WHERE DATA = :DATA'
      'AND PROGRESSIVO = :PROGRESSIVO'
      'AND TIPO_VALUTAZIONE = :TIPO_VALUTAZIONE'
      'AND STATO_AVANZAMENTO = :STATO_AVANZAMENTO')
    Optimize = False
    Variables.Data = {
      04000000050000000A0000003A0044004100540041000C000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      00000000000000000000220000003A005400490050004F005F00560041004C00
      5500540041005A0049004F004E00450005000000000000000000000024000000
      3A0053005400410054004F005F004100560041004E005A0041004D0045004E00
      54004F000300000000000000000000002C0000003A0043004F004D004D004500
      4E00540049005F00560041004C0055005400410054004F005F00440049005000
      050000000000000000000000}
    Left = 272
    Top = 208
  end
  object insaSG711: TOracleQuery
    SQL.Strings = (
      'INSERT INTO SG711_VALUTAZIONI_DIPENDENTE'
      
        '(DATA,PROGRESSIVO,TIPO_VALUTAZIONE,COD_AREA,COD_VALUTAZIONE,VALU' +
        'TABILE,PUNTEGGIO,'
      
        ' DESC_VALUTAZIONE_AGG,COD_PUNTEGGIO,PERC_VALUTAZIONE,SOGLIA_PUNT' +
        'EGGIO,PUNTEGGIO_PESATO,'
      ' STATO_AVANZAMENTO,NOTE_PUNTEGGIO)'
      'SELECT '
      
        ' DATA,PROGRESSIVO,TIPO_VALUTAZIONE,COD_AREA,COD_VALUTAZIONE,VALU' +
        'TABILE,PUNTEGGIO,'
      
        ' DESC_VALUTAZIONE_AGG,COD_PUNTEGGIO,PERC_VALUTAZIONE,SOGLIA_PUNT' +
        'EGGIO,PUNTEGGIO_PESATO,'
      ' STATO_AVANZAMENTO + 1,NOTE_PUNTEGGIO'
      'FROM SG711_VALUTAZIONI_DIPENDENTE'
      'WHERE DATA = :DATA'
      'AND PROGRESSIVO = :PROGRESSIVO'
      'AND TIPO_VALUTAZIONE = :TIPO_VALUTAZIONE'
      'AND STATO_AVANZAMENTO = :STATO_AVANZAMENTO')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A0044004100540041000C000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      00000000000000000000220000003A005400490050004F005F00560041004C00
      5500540041005A0049004F004E00450005000000000000000000000024000000
      3A0053005400410054004F005F004100560041004E005A0041004D0045004E00
      54004F00030000000000000000000000}
    Left = 328
    Top = 208
  end
  object selSG711a: TOracleDataSet
    SQL.Strings = (
      'SELECT SUM(NVL(SG711.PUNTEGGIO,0)) / COUNT(*) PUNTEGGIO_MEDIO'
      
        'FROM SG711_VALUTAZIONI_DIPENDENTE SG711, SG710_TESTATA_VALUTAZIO' +
        'NI SG710'
      'WHERE SG711.COD_AREA = :COD_AREA'
      'AND SG711.COD_VALUTAZIONE = :COD_VALUTAZIONE'
      'AND :DATA BETWEEN NVL((SELECT MAX(SG711B.DATA) + 1'
      '                       FROM SG711_VALUTAZIONI_DIPENDENTE SG711B'
      '                       WHERE SG711B.DATA >= TRUNC(:DATA,'#39'Y'#39') '
      '                       AND SG711B.DATA < SG711.DATA'
      
        '                       AND SG711B.PROGRESSIVO = SG711.PROGRESSIV' +
        'O'
      
        '                       AND SG711B.TIPO_VALUTAZIONE = SG711.TIPO_' +
        'VALUTAZIONE)'
      '                      ,TRUNC(:DATA,'#39'Y'#39')) '
      '              AND SG711.DATA'
      'AND SG711.TIPO_VALUTAZIONE = :TIPO_VALUTAZIONE'
      
        'AND SG711.STATO_AVANZAMENTO = (SELECT MAX(SG711A.STATO_AVANZAMEN' +
        'TO)'
      
        '                               FROM SG711_VALUTAZIONI_DIPENDENTE' +
        ' SG711A'
      '                               WHERE SG711A.DATA = SG711.DATA'
      
        '                               AND SG711A.PROGRESSIVO = SG711.PR' +
        'OGRESSIVO'
      
        '                               AND SG711A.TIPO_VALUTAZIONE = SG7' +
        '11.TIPO_VALUTAZIONE)'
      'AND SG711.VALUTABILE = '#39'S'#39
      'AND SG710.PROGRESSIVO = SG711.PROGRESSIVO'
      'AND SG710.DATA = SG711.DATA'
      'AND SG710.TIPO_VALUTAZIONE = SG711.TIPO_VALUTAZIONE'
      'AND SG710.STATO_AVANZAMENTO = SG711.STATO_AVANZAMENTO')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A0044004100540041000C000000000000000000
      0000120000003A0043004F0044005F0041005200450041000500000000000000
      00000000200000003A0043004F0044005F00560041004C005500540041005A00
      49004F004E004500050000000000000000000000220000003A00540049005000
      4F005F00560041004C005500540041005A0049004F004E004500050000000000
      000000000000}
    Left = 328
    Top = 64
  end
  object selSG711b: TOracleDataSet
    SQL.Strings = (
      'SELECT SG711.PROGRESSIVO,'
      
        '       SG711.PUNTEGGIO * DECODE(SG701.TIPO_PESO_PERCENTUALE,'#39'0'#39',' +
        'ROUND(NVL(SG711.PERC_VALUTAZIONE,0) * 100 / NVL(SG701.PESO_PERCE' +
        'NTUALE,0),5),NVL(SG711.PERC_VALUTAZIONE,0)) / 100 RAGG'
      
        'FROM SG711_VALUTAZIONI_DIPENDENTE SG711, SG710_TESTATA_VALUTAZIO' +
        'NI SG710, SG701_AREE_VALUTAZIONI SG701, SG700_VALUTAZIONI SG700'
      'WHERE SG711.COD_AREA = :COD_AREA'
      'AND SG711.COD_VALUTAZIONE = :COD_VALUTAZIONE'
      'AND :DATA BETWEEN NVL((SELECT MAX(SG711B.DATA) + 1'
      '                       FROM SG711_VALUTAZIONI_DIPENDENTE SG711B'
      '                       WHERE SG711B.DATA >= TRUNC(:DATA,'#39'Y'#39') '
      '                       AND SG711B.DATA < SG711.DATA'
      
        '                       AND SG711B.PROGRESSIVO = SG711.PROGRESSIV' +
        'O'
      
        '                       AND SG711B.TIPO_VALUTAZIONE = SG711.TIPO_' +
        'VALUTAZIONE)'
      '                      ,TRUNC(:DATA,'#39'Y'#39')) '
      '              AND SG711.DATA'
      'AND SG711.TIPO_VALUTAZIONE = :TIPO_VALUTAZIONE'
      
        'AND SG711.STATO_AVANZAMENTO = (SELECT MAX(SG711A.STATO_AVANZAMEN' +
        'TO)'
      
        '                               FROM SG711_VALUTAZIONI_DIPENDENTE' +
        ' SG711A'
      '                               WHERE SG711A.DATA = SG711.DATA'
      
        '                               AND SG711A.PROGRESSIVO = SG711.PR' +
        'OGRESSIVO'
      
        '                               AND SG711A.TIPO_VALUTAZIONE = SG7' +
        '11.TIPO_VALUTAZIONE)'
      'AND SG711.VALUTABILE = '#39'S'#39
      'AND SG710.PROGRESSIVO = SG711.PROGRESSIVO'
      'AND SG710.DATA = SG711.DATA'
      'AND SG710.TIPO_VALUTAZIONE = SG711.TIPO_VALUTAZIONE'
      'AND SG710.STATO_AVANZAMENTO = SG711.STATO_AVANZAMENTO'
      
        'AND SG711.DATA BETWEEN SG701.DECORRENZA AND SG701.DECORRENZA_FIN' +
        'E'
      'AND SG701.COD_AREA = SG711.COD_AREA '
      'AND SG700.DECORRENZA = SG701.DECORRENZA'
      'AND SG700.COD_AREA = SG701.COD_AREA '
      'AND SG700.COD_VALUTAZIONE = SG711.COD_VALUTAZIONE')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A0044004100540041000C000000000000000000
      0000120000003A0043004F0044005F0041005200450041000500000000000000
      00000000200000003A0043004F0044005F00560041004C005500540041005A00
      49004F004E004500050000000000000000000000220000003A00540049005000
      4F005F00560041004C005500540041005A0049004F004E004500050000000000
      000000000000}
    Left = 328
    Top = 112
  end
  object selSG745: TOracleDataSet
    SQL.Strings = (
      'SELECT SG745.*, SG745.ROWID'
      'FROM SG745_CONSEGNA_VALUTAZIONI SG745'
      
        'ORDER BY DATA, PROGRESSIVO, TIPO_VALUTAZIONE, STATO_AVANZAMENTO,' +
        ' DATA_CONSEGNA, UTENTE')
    Optimize = False
    Left = 568
    Top = 16
  end
  object delSG711: TOracleQuery
    SQL.Strings = (
      'DELETE SG711_VALUTAZIONI_DIPENDENTE'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      'AND DATA = :DATA'
      'AND TIPO_VALUTAZIONE = :TIPO_VALUTAZIONE'
      'AND STATO_AVANZAMENTO = :STATO_AVANZAMENTO')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000220000003A005400490050004F005F00560041004C00
      5500540041005A0049004F004E00450005000000000000000000000024000000
      3A0053005400410054004F005F004100560041004E005A0041004D0045004E00
      54004F00030000000000000000000000}
    Left = 328
    Top = 304
  end
  object selSG742: TOracleDataSet
    SQL.Strings = (
      'SELECT SG742.*'
      'FROM SG742_ETICHETTE_VALUTAZIONI SG742'
      'WHERE DECORRENZA = :DECORRENZA'
      'AND CODREGOLA = :CODREGOLA'
      'ORDER BY ORDINE')
    Optimize = False
    Variables.Data = {
      0400000002000000140000003A0043004F0044005200450047004F004C004100
      050000000000000000000000160000003A004400450043004F00520052004500
      4E005A0041000C0000000000000000000000}
    Left = 520
    Top = 16
  end
  object selT030: TOracleDataSet
    SQL.Strings = (
      'SELECT MATRICOLA, COGNOME||'#39' '#39'||NOME NOMINATIVO'
      'FROM   T030_ANAGRAFICO'
      'WHERE  PROGRESSIVO = :PROGRESSIVO')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Left = 16
    Top = 96
  end
  object selSG710b: TOracleQuery
    SQL.Strings = (
      
        'select greatest(nvl(max(data) + 1,to_date('#39'01011900'#39','#39'ddmmyyyy'#39')' +
        '),trunc(:data,'#39'y'#39')) inizio_periodo'
      'From sg710_testata_valutazioni'
      'where progressivo = :progressivo'
      'and tipo_valutazione = :tipo'
      'and data < :data')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A005400490050004F000500
      000000000000000000000A0000003A0044004100540041000C00000000000000
      00000000}
    Left = 271
    Top = 112
  end
  object selT770: TOracleDataSet
    SQL.Strings = (
      'SELECT COUNT(*) NUM'
      'FROM T770_QUOTE'
      'WHERE CODTIPOQUOTA = :CODTIPOQUOTA'
      'AND (DATO1 = '#39' '#39' OR DATO1 = :DATO1)'
      'AND (DATO2 = '#39' '#39' OR DATO2 = :DATO2)'
      'AND (DATO3 = '#39' '#39' OR DATO3 = :DATO3)'
      'AND :DATARIF BETWEEN DECORRENZA AND DECORRENZA_FINE')
    Optimize = False
    Variables.Data = {
      04000000050000001A0000003A0043004F0044005400490050004F0051005500
      4F00540041000500000000000000000000000C0000003A004400410054004F00
      31000500000000000000000000000C0000003A004400410054004F0032000500
      000000000000000000000C0000003A004400410054004F003300050000000000
      000000000000100000003A0044004100540041005200490046000C0000000000
      000000000000}
    Left = 15
    Top = 208
  end
  object selSG710c: TOracleDataSet
    SQL.Strings = (
      'select progressivo, stato_avanzamento, '
      
        '       chiuso, DECODE(numero_protocollo,NULL,DECODE(anno_protoco' +
        'llo,NULL,DECODE(data_protocollo,NULL,'#39'N'#39','#39'S'#39'),'#39'S'#39'),'#39'S'#39') scheda_p' +
        'rotocollata '
      'from sg710_testata_valutazioni'
      'where data = :data'
      'and progressivo = :progressivo'
      'and tipo_valutazione = :tipo_valutazione'
      'order by stato_avanzamento')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000220000003A005400490050004F005F00560041004C00
      5500540041005A0049004F004E004500050000000000000000000000}
    CommitOnPost = False
    Left = 272
    Top = 160
  end
  object selStoriaValInterm: TOracleQuery
    SQL.Strings = (
      'select SG710F_STORIA_VAL_INTERM(:data,:progressivo,:tipo,:stato)'
      'From dual')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A005400490050004F000500
      000000000000000000000A0000003A0044004100540041000C00000000000000
      000000000C0000003A0053005400410054004F00030000000000000000000000}
    Left = 671
    Top = 256
  end
  object selSG735: TOracleDataSet
    SQL.Strings = (
      'select SG735.PUNTEGGIO_DA, SG735.PUNTEGGIO_A, SG735.PERC'
      '  from SG735_PUNTEGGIFASCE_INCENTIVI SG735'
      ' where SG735.TIPOLOGIA = '#39'V'#39
      '   and SG735.CODQUOTA = :QUOTA'
      
        '   and :DATA_VAL between SG735.DECORRENZA and SG735.DECORRENZA_F' +
        'INE'
      ' order by SG735.PUNTEGGIO_DA, SG735.PUNTEGGIO_A')
    Optimize = False
    Variables.Data = {
      0400000002000000120000003A0044004100540041005F00560041004C000C00
      000000000000000000000C0000003A00510055004F0054004100050000000000
      000000000000}
    Left = 424
    Top = 16
  end
end
