object W043FModPersonaleReperibileDM: TW043FModPersonaleReperibileDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 192
  Width = 528
  object selT380: TOracleDataSet
    SQL.Strings = (
      'select T380.DATA,'
      '       T380.PROGRESSIVO,'
      '       T380.TURNO1,'
      '       T380.TURNO2,'
      '       T380.TURNO3,'
      '       T380.TIPOLOGIA,'
      '       T380.RECAPITO1,'
      '       T380.RECAPITO2,'
      '       T380.RECAPITO3,     '
      '       T380.PRIORITA1,'
      '       T380.PRIORITA2,'
      '       T380.PRIORITA3,   '
      '       T380.DATOAGG1_T1,'
      '       T380.DATOAGG1_T2,'
      '       T380.DATOAGG1_T3,   '
      '       T380.DATOAGG2_T1,'
      '       T380.DATOAGG2_T2,'
      '       T380.DATOAGG2_T3,   '
      '       T380.AREASQUADRA_T1,'
      '       T380.AREASQUADRA_T2,'
      '       T380.AREASQUADRA_T3,   '
      '       T350_T1.DESCRIZIONE DESCRIZIONE_TURNO1,'
      '       T350_T1.SIGLA SIGLA_TURNO1,'
      '       to_char(T350_T1.ORAINIZIO,'#39'HH24.MI'#39') DALLE_TURNO1,'
      '       to_char(T350_T1.ORAFINE,'#39'HH24.MI'#39') ALLE_TURNO1,'
      '       T350_T2.DESCRIZIONE DESCRIZIONE_TURNO2,'
      '       T350_T2.SIGLA SIGLA_TURNO2,'
      '       to_char(T350_T2.ORAINIZIO,'#39'HH24.MI'#39') DALLE_TURNO2,'
      '       to_char(T350_T2.ORAFINE,'#39'HH24.MI'#39') ALLE_TURNO2,'
      '       T350_T3.DESCRIZIONE DESCRIZIONE_TURNO3,'
      '       T350_T3.SIGLA SIGLA_TURNO3,'
      '       to_char(T350_T3.ORAINIZIO,'#39'HH24.MI'#39') DALLE_TURNO3,'
      '       to_char(T350_T3.ORAFINE,'#39'HH24.MI'#39') ALLE_TURNO3'
      'from T380_PIANIFREPERIB T380, '
      '     T350_REGREPERIB T350_T1,'
      '     T350_REGREPERIB T350_T2, '
      '     T350_REGREPERIB T350_T3'
      'where T380.PROGRESSIVO = :PROGRESSIVO'
      'and T380.DATA = :DATA_PIANIFICAZIONE'
      'and T380.TIPOLOGIA = '#39'R'#39
      'and T350_T1.CODICE(+) = T380.TURNO1'
      'and T350_T2.CODICE(+) = T380.TURNO2'
      'and T350_T3.CODICE(+) = T380.TURNO3'
      'order by T380.DATA')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000280000003A0044004100540041005F00
      5000490041004E00490046004900430041005A0049004F004E0045000C000000
      0000000000000000}
    Left = 232
    Top = 16
  end
  object cdsTurniDip1: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'ID'
    Params = <>
    Left = 24
    Top = 72
    object cdsTurniDip1ID: TIntegerField
      FieldName = 'ID'
    end
    object cdsTurniDip1PROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
    end
    object cdsTurniDip1DATA: TDateField
      FieldName = 'DATA'
    end
    object cdsTurniDip1NUMERO_TURNO: TIntegerField
      FieldName = 'NUMERO_TURNO'
    end
    object cdsTurniDip1TURNO: TStringField
      FieldName = 'TURNO'
      Size = 5
    end
    object cdsTurniDip1SIGLA: TStringField
      FieldName = 'SIGLA'
      Size = 5
    end
    object cdsTurniDip1D_TURNO: TStringField
      FieldName = 'D_TURNO'
      Size = 100
    end
    object cdsTurniDip1PRIORITA: TStringField
      FieldName = 'PRIORITA'
      Size = 1
    end
    object cdsTurniDip1RECAPITO_EXTRA: TStringField
      FieldName = 'RECAPITO_EXTRA'
      Size = 100
    end
    object cdsTurniDip1D_MODIFICA_RECAPITO: TStringField
      FieldName = 'D_MODIFICA_RECAPITO'
      Size = 1
    end
    object cdsTurniDip1DATOAGG1: TStringField
      FieldName = 'DATOAGG1'
      Size = 100
    end
    object cdsTurniDip1D_DATOAGG1: TStringField
      FieldName = 'D_DATOAGG1'
      Size = 200
    end
    object cdsTurniDip1DATOAGG2: TStringField
      FieldName = 'DATOAGG2'
      Size = 100
    end
    object cdsTurniDip1D_DATOAGG2: TStringField
      FieldName = 'D_DATOAGG2'
      Size = 200
    end
  end
  object dsrTurniDip1: TDataSource
    DataSet = cdsTurniDip1
    Left = 104
    Top = 72
  end
  object dsrTurniDip2: TDataSource
    DataSet = cdsTurniDip2
    Left = 104
    Top = 120
  end
  object selAnagrafeDipRep: TOracleDataSet
    SQL.Strings = (
      'select T030.*,'
      '       V430.*'
      'from :QVISTAORACLE'
      '--and T030.PROGRESSIVO in (:FILTRODIP)'
      ':FILTRODIP'
      ':FILTRO_DATO1'
      ':FILTRO_DATO2 '
      ':FILTRO_AREASQUADRA '
      
        'and exists(select '#39'x'#39' from T270_RAGGRPRESENZE T270 where CODINTE' +
        'RNO = '#39'C'#39' and intersez_liste(T270.CODICE,V430.T430ABPRESENZA1) i' +
        's not null)'
      'order by T030.COGNOME, T030.NOME, T030.MATRICOLA')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      04000000060000001A0000003A005100560049005300540041004F0052004100
      43004C004500010000000000000000000000140000003A00460049004C005400
      52004F00440049005000010000000000000000000000160000003A0044004100
      540041004C00410056004F0052004F000C00000000000000000000001A000000
      3A00460049004C00540052004F005F004400410054004F003100010000000000
      0000000000001A0000003A00460049004C00540052004F005F00440041005400
      4F003200010000000000000000000000260000003A00460049004C0054005200
      4F005F0041005200450041005300510055004100440052004100010000000000
      000000000000}
    Left = 40
    Top = 16
  end
  object cdsTurniDip2: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'ID'
    Params = <>
    Left = 24
    Top = 120
    object IntegerField1: TIntegerField
      FieldName = 'ID'
    end
    object cdsTurniDip2PROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
    end
    object DateField1: TDateField
      FieldName = 'DATA'
    end
    object cdsTurniDip2NUMERO_TURNO: TIntegerField
      FieldName = 'NUMERO_TURNO'
    end
    object cdsTurniDip2TURNO: TStringField
      FieldName = 'TURNO'
      Size = 5
    end
    object cdsTurniDip2SIGLA: TStringField
      FieldName = 'SIGLA'
      Size = 5
    end
    object StringField1: TStringField
      FieldName = 'D_TURNO'
      Size = 100
    end
    object cdsTurniDip2PRIORITA: TStringField
      FieldName = 'PRIORITA'
      Size = 1
    end
    object StringField2: TStringField
      FieldName = 'RECAPITO_EXTRA'
      Size = 100
    end
    object StringField3: TStringField
      FieldName = 'D_MODIFICA_RECAPITO'
      Size = 1
    end
    object cdsTurniDip2DATOAGG1: TStringField
      FieldName = 'DATOAGG1'
      Size = 100
    end
    object cdsTurniDip2D_DATOAGG1: TStringField
      FieldName = 'D_DATOAGG1'
      Size = 200
    end
    object cdsTurniDip2DATOAGG2: TStringField
      FieldName = 'DATOAGG2'
      Size = 100
    end
    object cdsTurniDip2D_DATOAGG2: TStringField
      FieldName = 'D_DATOAGG2'
      Size = 200
    end
  end
  object selT350: TOracleDataSet
    SQL.Strings = (
      'select CODICE,'
      '       SIGLA,'
      '       DESCRIZIONE, '
      '       ORAINIZIO,'
      '       OREMINUTI(to_char(ORAINIZIO,'#39'HH24.MI'#39')) INIZIO,'
      '       to_char(ORAINIZIO,'#39'HH24.MI'#39') ORAINIZIOSTR,'
      '       ORAFINE,'
      '       OREMINUTI(to_char(ORAFINE,'#39'HH24.MI'#39')) FINE,'
      '       to_char(ORAFINE,'#39'HH24.MI'#39') ORAFINESTR'
      'from   T350_REGREPERIB'
      'where  TIPOLOGIA = '#39'R'#39
      'order by CODICE')
    ReadBuffer = 1000
    Optimize = False
    Left = 280
    Top = 16
  end
  object selT385: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T385.*, V010.FESTIVO DTFESTIVO, V010A.FESTIVO DTPREFESTIV' +
        'O, TO_CHAR(:DATA - 1,'#39'D'#39') DTGIORNO'
      
        'FROM T385_VINCOLI_REPERIB T385, V010_CALENDARI V010, V010_CALEND' +
        'ARI V010A'
      'WHERE T385.PROGRESSIVO = :PROGRESSIVO '
      '  AND T385.TIPOLOGIA = :TIPO'
      '  AND :DATA BETWEEN T385.DECORRENZA AND T385.DECORRENZA_FINE'
      '  AND V010.PROGRESSIVO = :PROGRESSIVO '
      '  AND V010.DATA = :DATA'
      '  AND V010A.PROGRESSIVO = :PROGRESSIVO '
      '  AND V010A.DATA = :DATA + 1'
      
        'ORDER BY DECODE(T385.GIORNO,'#39'*'#39',0,'#39'PF'#39',8,'#39'FS'#39',9,T385.GIORNO) DES' +
        'C')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      000000000000000000000A0000003A005400490050004F000500000000000000
      00000000}
    QBEDefinition.QBEFieldDefs = {
      0500000006000000080000004400410054004100010000000000160000005000
      52004F0047005200450053005300490056004F000100000000000C0000005400
      550052004E004F0031000100000000000C0000005400550052004E004F003200
      010000000000140000004400410054004F004C0049004200450052004F000100
      000000000C0000005400550052004E004F003300010000000000}
    Left = 336
    Top = 16
  end
  object selT380TurniIntersecati: TOracleDataSet
    SQL.Strings = (
      'select T350.CODICE CODICE_TURNO,'
      '       T350.SIGLA SIGLA_TURNO,'
      '       T350.TIPOLOGIA,'
      '       T380.DATA,'
      '       T350.ORAINIZIO,'
      '       T350.ORAFINE,'
      '       to_char(T350.ORAINIZIO,'#39'SSSSS'#39')/60 MINUTI_INIZIO,'
      '       to_char(T350.ORAFINE,'#39'SSSSS'#39')/60 MINUTI_FINE'
      'from T350_REGREPERIB T350,'
      '     T380_PIANIFREPERIB T380'
      'where T380.PROGRESSIVO = :PROGRESSIVO'
      'and T380.DATA between (:DATA_TURNO - 1) and (:DATA_TURNO + 1)'
      'and T350.CODICE in (T380.TURNO1,T380.TURNO2,T380.TURNO3)'
      'and T350.TIPOLOGIA = T380.TIPOLOGIA'
      
        'and MEDPF_INTERSEZ_INTERVALLI(:DATA_TURNO,:ORA_INIZIO_TURNO,:ORA' +
        '_FINE_TURNO,'
      
        '                              T380.DATA,T350.ORAINIZIO, T350.ORA' +
        'FINE) = '#39'S'#39)
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000160000003A0044004100540041005F00
      5400550052004E004F000C0000000000000000000000220000003A004F005200
      41005F0049004E0049005A0049004F005F005400550052004E004F000C000000
      00000000000000001E0000003A004F00520041005F00460049004E0045005F00
      5400550052004E004F000C0000000000000000000000}
    Left = 416
    Top = 16
  end
  object selT380RowId: TOracleDataSet
    SQL.Strings = (
      'select T380.ROWID, T380.*'
      'from T380_PIANIFREPERIB T380'
      
        'where T380.PROGRESSIVO = :PROGRESSIVO and T380.DATA = :DATA_PIAN' +
        'IFICAZIONE'
      '      and T380.TIPOLOGIA = '#39'R'#39)
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000280000003A0044004100540041005F00
      5000490041004E00490046004900430041005A0049004F004E0045000C000000
      0000000000000000}
    CommitOnPost = False
    Left = 184
    Top = 72
  end
  object selDatoLibero: TOracleDataSet
    SQL.Strings = (
      '/* Settato a runtime da ImpostaODSDatoLibero */')
    Optimize = False
    Variables.Data = {
      0400000003000000280000003A0054004100420045004C004C0041005F004400
      410054004F005F004C0049004200450052004F00010000000000000000000000
      0E0000003A0043004F0044004900430045000500000000000000000000001E00
      00003A0043004F004C004F004E004E0041005F0043004F004400490043004500
      010000000000000000000000}
    Left = 280
    Top = 72
  end
  object selT030: TOracleDataSet
    SQL.Strings = (
      'select MATRICOLA, COGNOME, NOME'
      'from T030_ANAGRAFICO'
      'where PROGRESSIVO = :Progressivo')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Left = 112
    Top = 16
  end
  object selSQLDatoAgg1: TOracleDataSet
    Optimize = False
    Left = 360
    Top = 72
  end
  object selSQLDatoAgg2: TOracleDataSet
    Optimize = False
    Left = 448
    Top = 72
  end
  object selT650Lookup: TOracleDataSet
    SQL.Strings = (
      'select DISTINCT '
      ' T650.CODICE,'
      ' T650.DESCRIZIONE'
      ' FROM T651_AREE_SQUADRA T651, T650_AREE_TURNI T650'
      'where T651.CODICE_AREA = T650.CODICE'
      'order by T650.CODICE')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000130000000E0000005300510055004100440052004100010000000000
      0C00000043004F004400490043004500010000000000080000004D0049004E00
      3100010000000000080000004D00410058003100010000000000080000004D00
      49004E003200010000000000080000004D004100580032000100000000000800
      00004D0049004E003300010000000000080000004D0041005800330001000000
      0000080000004D0049004E003400010000000000080000004D00410058003400
      0100000000000C0000005400550052004E0041005A000100000000000C000000
      4F0052004100520049004F00010000000000160000004F005400540049004D00
      41004C004500310046005200010000000000160000004F005400540049004D00
      41004C004500310046005300010000000000160000004F005400540049004D00
      41004C004500320046005200010000000000160000004F005400540049004D00
      41004C004500320046005300010000000000160000004F005400540049004D00
      41004C004500330046005200010000000000160000004F005400540049004D00
      41004C0045003300460053000100000000000E000000500052004F0046004900
      4C004F00010000000000}
    ReadOnly = True
    Left = 363
    Top = 128
  end
  object selT651: TOracleDataSet
    SQL.Strings = (
      'select * FROM T651_AREE_SQUADRA T651, T650_AREE_TURNI T650'
      'where T651.CODICE_AREA = T650.CODICE'
      'order by T651.CODICE_SQUADRA, T651.CODICE_OPERATORE')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000130000000E0000005300510055004100440052004100010000000000
      0C00000043004F004400490043004500010000000000080000004D0049004E00
      3100010000000000080000004D00410058003100010000000000080000004D00
      49004E003200010000000000080000004D004100580032000100000000000800
      00004D0049004E003300010000000000080000004D0041005800330001000000
      0000080000004D0049004E003400010000000000080000004D00410058003400
      0100000000000C0000005400550052004E0041005A000100000000000C000000
      4F0052004100520049004F00010000000000160000004F005400540049004D00
      41004C004500310046005200010000000000160000004F005400540049004D00
      41004C004500310046005300010000000000160000004F005400540049004D00
      41004C004500320046005200010000000000160000004F005400540049004D00
      41004C004500320046005300010000000000160000004F005400540049004D00
      41004C004500330046005200010000000000160000004F005400540049004D00
      41004C0045003300460053000100000000000E000000500052004F0046004900
      4C004F00010000000000}
    ReadOnly = True
    Left = 275
    Top = 128
  end
  object selT030DatoLibero: TOracleDataSet
    SQL.Strings = (
      'SELECT T030.MATRICOLA, T030.COGNOME, T030.NOME, :DATOL DATOL'
      'FROM T430_STORICO T430, T030_ANAGRAFICO T030'
      'WHERE T030.PROGRESSIVO = T430.PROGRESSIVO'
      'AND T030.PROGRESSIVO = :PROGRESSIVO'
      'AND :DATA_LAVORO BETWEEN DATADECORRENZA AND DATAFINE'
      'ORDER BY DATADECORRENZA')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A004400410054004F004C00
      010000000000000000000000180000003A0044004100540041005F004C004100
      56004F0052004F000C0000000000000000000000}
    Left = 184
    Top = 136
  end
  object selT430Recapito: TOracleQuery
    SQL.Strings = (
      'select :RECAPITO from V430_Storico V430'
      ' where :PROGRESSIVO = V430.T430Progressivo'
      
        '   and :DATA BETWEEN V430.T430DataDecorrenza and V430.T430DataFi' +
        'ne')
    Optimize = False
    Variables.Data = {
      0400000003000000120000003A0052004500430041005000490054004F000100
      00000000000000000000180000003A00500052004F0047005200450053005300
      490056004F000300000000000000000000000A0000003A004400410054004100
      0C0000000000000000000000}
    Left = 456
    Top = 128
  end
end
