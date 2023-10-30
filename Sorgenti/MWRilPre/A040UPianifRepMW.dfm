inherited A040FPianifRepMW: TA040FPianifRepMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 279
  Width = 559
  object D350: TDataSource
    DataSet = Q350
    Left = 44
    Top = 12
  end
  object Q350: TOracleDataSet
    SQL.Strings = (
      'SELECT T350.*, ROWID FROM T350_REGREPERIB T350'
      'WHERE TIPOLOGIA = :TIPOLOGIA'
      'ORDER BY CODICE')
    Optimize = False
    Variables.Data = {
      0400000001000000140000003A005400490050004F004C004F00470049004100
      050000000000000000000000}
    Filtered = True
    OnFilterRecord = FiltroDizionario
    Left = 16
    Top = 12
    object Q350CODICE: TStringField
      FieldName = 'CODICE'
      Origin = 'T350_REGREPERIB.CODICE'
      Size = 5
    end
    object Q350DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Origin = 'T350_REGREPERIB.DESCRIZIONE'
      Size = 40
    end
    object Q350ORAINIZIO: TDateTimeField
      FieldName = 'ORAINIZIO'
      Origin = 'T350_REGREPERIB.ORAINIZIO'
    end
    object Q350ORAFINE: TDateTimeField
      FieldName = 'ORAFINE'
      Origin = 'T350_REGREPERIB.ORAFINE'
    end
    object Q350TIPOORE: TStringField
      FieldName = 'TIPOORE'
      Origin = 'T350_REGREPERIB.TIPOORE'
      Size = 1
    end
    object Q350ORENORMALI: TDateTimeField
      FieldName = 'ORENORMALI'
      Origin = 'T350_REGREPERIB.ORENORMALI'
    end
    object Q350ORECOMPRESENZA: TDateTimeField
      FieldName = 'ORECOMPRESENZA'
      Origin = 'T350_REGREPERIB.ORECOMPRESENZA'
    end
    object Q350TIPOTURNO: TStringField
      FieldName = 'TIPOTURNO'
      Origin = 'T350_REGREPERIB.TIPOTURNO'
      Size = 1
    end
    object Q350RAGGRUPPAMENTO: TStringField
      FieldName = 'RAGGRUPPAMENTO'
      Origin = 'T350_REGREPERIB.RAGGRUPPAMENTO'
    end
    object Q350PIANIF_MAX_MESE: TIntegerField
      FieldName = 'PIANIF_MAX_MESE'
    end
    object Q350PIANIF_MAX_MESE_TURNI_INTERI: TStringField
      FieldName = 'PIANIF_MAX_MESE_TURNI_INTERI'
      Size = 1
    end
    object Q350ORE_MIN_INDENNITA: TStringField
      FieldName = 'ORE_MIN_INDENNITA'
      Size = 5
    end
    object Q350TURNO_INTERO: TStringField
      FieldName = 'TURNO_INTERO'
      Size = 5
    end
    object Q350BLOCCA_MAX_MESE: TStringField
      FieldName = 'BLOCCA_MAX_MESE'
      Size = 1
    end
  end
  object Q350Opposto: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM T350_REGREPERIB'
      'WHERE TIPOLOGIA <> :TIPOLOGIA'
      'ORDER BY CODICE')
    Optimize = False
    Variables.Data = {
      0400000001000000140000003A005400490050004F004C004F00470049004100
      050000000000000000000000}
    Filtered = True
    OnFilterRecord = FiltroDizionario
    Left = 101
    Top = 12
    object StringField1: TStringField
      FieldName = 'CODICE'
      Origin = 'T350_REGREPERIB.CODICE'
      Size = 5
    end
    object StringField2: TStringField
      FieldName = 'DESCRIZIONE'
      Origin = 'T350_REGREPERIB.DESCRIZIONE'
      Size = 40
    end
    object DateTimeField1: TDateTimeField
      FieldName = 'ORAINIZIO'
      Origin = 'T350_REGREPERIB.ORAINIZIO'
    end
    object DateTimeField2: TDateTimeField
      FieldName = 'ORAFINE'
      Origin = 'T350_REGREPERIB.ORAFINE'
    end
    object StringField3: TStringField
      FieldName = 'TIPOORE'
      Origin = 'T350_REGREPERIB.TIPOORE'
      Size = 1
    end
    object DateTimeField3: TDateTimeField
      FieldName = 'ORENORMALI'
      Origin = 'T350_REGREPERIB.ORENORMALI'
    end
    object DateTimeField4: TDateTimeField
      FieldName = 'ORECOMPRESENZA'
      Origin = 'T350_REGREPERIB.ORECOMPRESENZA'
    end
    object StringField4: TStringField
      FieldName = 'TIPOTURNO'
      Origin = 'T350_REGREPERIB.TIPOTURNO'
      Size = 1
    end
    object StringField5: TStringField
      FieldName = 'RAGGRUPPAMENTO'
      Origin = 'T350_REGREPERIB.RAGGRUPPAMENTO'
    end
  end
  object Q270: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE '
      'FROM T270_RAGGRPRESENZE'
      'WHERE CODINTERNO = :CODINTERNO')
    Optimize = False
    Variables.Data = {
      0400000001000000160000003A0043004F00440049004E005400450052004E00
      4F00050000000000000000000000}
    Left = 259
    Top = 12
  end
  object QControllo: TOracleDataSet
    SQL.Strings = (
      'select count(*) '
      '  from T380_PIANIFREPERIB T380, '
      '  :C700SelAnagrafe'
      '  and T380.DATA = :DATA '
      '  and T380.PROGRESSIVO <> :PROGRESSIVO '
      '  and T380.TIPOLOGIA = :TIPOLOGIA '
      '  and (T380.TURNO1 in (:T1,:T2,:T3) '
      '   or T380.TURNO2 in (:T1,:T2,:T3) '
      '   or T380.TURNO3 in (:T1,:T2,:T3))')
    Optimize = False
    Variables.Data = {
      0400000007000000060000003A00540031000500000000000000000000000600
      00003A00540032000500000000000000000000000A0000003A00440041005400
      41000C0000000000000000000000180000003A00500052004F00470052004500
      53005300490056004F00030000000000000000000000060000003A0054003300
      050000000000000000000000140000003A005400490050004F004C004F004700
      49004100050000000000000000000000200000003A0043003700300030005300
      45004C0041004E00410047005200410046004500010000000000000000000000}
    Left = 368
    Top = 12
  end
  object Q040: TOracleDataSet
    SQL.Strings = (
      'SELECT CAUSALE FROM T040_GIUSTIFICATIVI WHERE'
      'PROGRESSIVO = :PROGRESSIVO AND'
      'DATA = :DATA '
      'AND TIPOGIUST = '#39'I'#39)
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 416
    Top = 12
  end
  object Q430Contratto: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T430.CONTRATTO, T200.DESCRIZIONE, T430.ABPRESENZA1, T200.' +
        'REPERIBILITA'
      'FROM   T430_STORICO T430, T200_CONTRATTI T200'
      'WHERE  T430.PROGRESSIVO = :PROGRESSIVO'
      'AND    T430.DATADECORRENZA <= :DATA'
      'AND    T430.DATAFINE >= :DATA '
      'AND    T430.CONTRATTO = T200.CODICE')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 478
    Top = 12
  end
  object selT380a: TOracleDataSet
    SQL.Strings = (
      'select T380.TURNO1, T380.TURNO2, T380.TURNO3'
      'from   t380_pianifreperib T380'
      'where  T380.progressivo = :PROGRESSIVO'
      'and    T380.data = :DATA'
      'and    T380.tipologia <> :TIPOLOGIA')
    ReadBuffer = 200
    Optimize = False
    Variables.Data = {
      0400000003000000140000003A005400490050004F004C004F00470049004100
      050000000000000000000000180000003A00500052004F004700520045005300
      5300490056004F000300000000000000000000000A0000003A00440041005400
      41000C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      0500000006000000080000004400410054004100010000000000160000005000
      52004F0047005200450053005300490056004F000100000000000C0000005400
      550052004E004F0031000100000000000C0000005400550052004E004F003200
      010000000000140000004400410054004F004C0049004200450052004F000100
      000000000C0000005400550052004E004F003300010000000000}
    UpdatingTable = 'T380_PIANIFREPERIB '
    Left = 84
    Top = 75
  end
  object dsrDatoLibero: TDataSource
    DataSet = selDatoLibero
    Left = 241
    Top = 75
  end
  object selDatoLibero: TOracleDataSet
    ReadBuffer = 200
    Optimize = False
    Left = 168
    Top = 75
  end
  object cdsParametri: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'Turno1'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'Turno2'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'Turno3'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'DatoLibero'
        DataType = ftString
        Size = 40
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 352
    Top = 75
    object cdsParametriTurno1: TStringField
      FieldName = 'Turno1'
      Size = 5
    end
    object cdsParametriTurno2: TStringField
      FieldName = 'Turno2'
      Size = 5
    end
    object cdsParametriTurno3: TStringField
      FieldName = 'Turno3'
      Size = 5
    end
    object cdsParametriDatoLibero: TStringField
      FieldName = 'DatoLibero'
      Size = 40
    end
  end
  object dsrParametri: TDataSource
    DataSet = cdsParametri
    Left = 420
    Top = 75
  end
  object insT380: TOracleQuery
    SQL.Strings = (
      'insert into T380_PIANIFREPERIB'
      
        '  ( DATA, PROGRESSIVO, TURNO1, TURNO2, TURNO3, DATOLIBERO, TIPOL' +
        'OGIA, PRIORITA1, PRIORITA2, PRIORITA3, DATOAGG1_T1, DATOAGG1_T2,' +
        ' DATOAGG1_T3, DATOAGG2_T1, DATOAGG2_T2, DATOAGG2_T3, AREASQUADRA' +
        '_T1, AREASQUADRA_T2, AREASQUADRA_T3, RECAPITO1, RECAPITO2, RECAP' +
        'ITO3)'
      'values'
      
        '  (:DATA,:PROGRESSIVO,:TURNO1,:TURNO2,:TURNO3,:DATOLIBERO,:TIPOL' +
        'OGIA,:PRIORITA1,:PRIORITA2,:PRIORITA3,:DATOAGG1_T1,:DATOAGG1_T2,' +
        ':DATOAGG1_T3,:DATOAGG2_T1,:DATOAGG2_T2,:DATOAGG2_T3,:AREASQUADRA' +
        '_T1,:AREASQUADRA_T2,:AREASQUADRA_T3, :RECAPITO1, :RECAPITO2, :RE' +
        'CAPITO3)')
    Optimize = False
    Variables.Data = {
      04000000160000000A0000003A0044004100540041000C000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      000000000000000000000E0000003A005400550052004E004F00310005000000
      00000000000000000E0000003A005400550052004E004F003200050000000000
      000000000000160000003A004400410054004F004C0049004200450052004F00
      0500000000000000000000000E0000003A005400550052004E004F0033000500
      00000000000000000000140000003A005400490050004F004C004F0047004900
      4100050000000000000000000000180000003A004400410054004F0041004700
      470031005F0054003100050000000000000000000000180000003A0044004100
      54004F0041004700470031005F00540032000500000000000000000000001800
      00003A004400410054004F0041004700470031005F0054003300050000000000
      000000000000180000003A004400410054004F0041004700470032005F005400
      3100050000000000000000000000180000003A004400410054004F0041004700
      470032005F0054003200050000000000000000000000180000003A0044004100
      54004F0041004700470032005F00540033000500000000000000000000001400
      00003A005000520049004F005200490054004100310003000000000000000000
      0000140000003A005000520049004F0052004900540041003200030000000000
      000000000000140000003A005000520049004F00520049005400410033000300
      000000000000000000001E0000003A0041005200450041005300510055004100
      4400520041005F00540031000500000000000000000000001E0000003A004100
      52004500410053005100550041004400520041005F0054003200050000000000
      0000000000001E0000003A004100520045004100530051005500410044005200
      41005F0054003300050000000000000000000000140000003A00520045004300
      41005000490054004F003100050000000000000000000000140000003A005200
      4500430041005000490054004F00320005000000000000000000000014000000
      3A0052004500430041005000490054004F003300050000000000000000000000}
    Left = 22
    Top = 139
  end
  object delT380: TOracleQuery
    SQL.Strings = (
      'DELETE FROM T380_PIANIFREPERIB '
      'WHERE  PROGRESSIVO = :PROGRESSIVO '
      'AND    DATA = :DATA '
      'AND    TIPOLOGIA = :TIPOLOGIA'
      '       :WHERE')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      000000000000000000000C0000003A0057004800450052004500010000000000
      000000000000140000003A005400490050004F004C004F004700490041000500
      00000000000000000000}
    Left = 84
    Top = 139
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
    UpdatingTable = 'T380_PIANIFREPERIB '
    Left = 169
    Top = 135
  end
  object selSumTurniAtt: TOracleQuery
    SQL.Strings = (
      
        '-- nota: DATARIF serve unicamente a leggere il codice contratto ' +
        'nel periodo storico corretto'
      
        '--       il contratto '#232' utilizzato per reperire la durata del tu' +
        'rno di reperibilit'#224' se il turno_intero '
      '--       non '#232' specificato sulle regole'
      'select sum(rapporto), sum(contatore) from'
      '('
      
        'select t350.orainizio,t350.orafine,nvl(t350.turno_intero,t200.re' +
        'peribilita) turno_intero,'
      
        '       decode(oreminuti(nvl(t350.turno_intero,t200.reperibilita)' +
        '),'
      '              0,0,'
      '              (oreminuti(to_char(t350.orafine,'#39'hh24.mi'#39')) - '
      '               oreminuti(to_char(t350.orainizio,'#39'hh24.mi'#39')) +'
      '               decode(sign(t350.orafine - t350.orainizio),'
      '                      0,1440,'
      '                      -1,1440,'
      '                      0)) /'
      
        '              oreminuti(nvl(t350.turno_intero,t200.reperibilita)' +
        ')) rapporto,'
      '       1 contatore'
      
        'from   t350_regreperib t350, t430_storico t430, t200_contratti t' +
        '200'
      'where  t350.tipologia = :TIPOLOGIA'
      'and    t350.codice = :TURNO1'
      'and    t430.progressivo = :PROGRESSIVO'
      'and    :DATARIF between t430.datadecorrenza and t430.datafine'
      'and    t430.contratto = t200.codice'
      'union all'
      
        'select t350.orainizio,t350.orafine,nvl(t350.turno_intero,t200.re' +
        'peribilita) turno_intero,'
      
        '       decode(oreminuti(nvl(t350.turno_intero,t200.reperibilita)' +
        '),'
      '              0,0,'
      '              (oreminuti(to_char(t350.orafine,'#39'hh24.mi'#39')) - '
      '               oreminuti(to_char(t350.orainizio,'#39'hh24.mi'#39')) +'
      '               decode(sign(t350.orafine - t350.orainizio),'
      '                      0,1440,'
      '                      -1,1440,'
      '                      0)) /'
      
        '              oreminuti(nvl(t350.turno_intero,t200.reperibilita)' +
        ')) rapporto,'
      '       1 contatore'
      
        'from   t350_regreperib t350, t430_storico t430, t200_contratti t' +
        '200'
      'where  t350.tipologia = :TIPOLOGIA'
      'and    t350.codice = :TURNO2'
      'and    t430.progressivo = :PROGRESSIVO'
      'and    :DATARIF between t430.datadecorrenza and t430.datafine'
      'and    t430.contratto = t200.codice'
      'union all'
      
        'select t350.orainizio,t350.orafine,nvl(t350.turno_intero,t200.re' +
        'peribilita) turno_intero,'
      
        '       decode(oreminuti(nvl(t350.turno_intero,t200.reperibilita)' +
        '),'
      '              0,0,'
      '              (oreminuti(to_char(t350.orafine,'#39'hh24.mi'#39')) - '
      '               oreminuti(to_char(t350.orainizio,'#39'hh24.mi'#39')) +'
      '               decode(sign(t350.orafine - t350.orainizio),'
      '                      0,1440,'
      '                      -1,1440,'
      '                      0)) /'
      
        '              oreminuti(nvl(t350.turno_intero,t200.reperibilita)' +
        ')) rapporto,'
      '       1 contatore'
      
        'from   t350_regreperib t350, t430_storico t430, t200_contratti t' +
        '200'
      'where  t350.tipologia = :TIPOLOGIA'
      'and    t350.codice = :TURNO3'
      'and    t430.progressivo = :PROGRESSIVO'
      'and    :DATARIF between t430.datadecorrenza and t430.datafine'
      'and    t430.contratto = t200.codice'
      ')')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000006000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A0044004100540041005200
      490046000C00000000000000000000000E0000003A005400550052004E004F00
      31000500000000000000000000000E0000003A005400550052004E004F003200
      0500000000000000000000000E0000003A005400550052004E004F0033000500
      00000000000000000000140000003A005400490050004F004C004F0047004900
      4100050000000000000000000000}
    Left = 108
    Top = 196
  end
  object selT380SumTurniMese: TOracleQuery
    SQL.Strings = (
      'select sum(rapporto), sum(contatore) from'
      '('
      
        'select decode(oreminuti(nvl(t350.turno_intero,t200.reperibilita)' +
        '),'
      '              0,0,'
      '              (oreminuti(to_char(t350.orafine,'#39'hh24.mi'#39')) - '
      '               oreminuti(to_char(t350.orainizio,'#39'hh24.mi'#39')) +'
      '               decode(sign(t350.orafine - t350.orainizio),'
      '                      0,1440,'
      '                      -1,1440,'
      '                      0)) /'
      
        '              oreminuti(nvl(t350.turno_intero,t200.reperibilita)' +
        ')) rapporto,'
      '       1 contatore'
      
        'from   t380_pianifreperib t380, t350_regreperib t350, t430_stori' +
        'co t430, t200_contratti t200'
      'where  t350.tipologia = :TIPOLOGIA'
      'and    t380.progressivo = :PROGRESSIVO'
      'and    t380.data between :DATADA and :DATAA'
      ':FILTRO'
      'and    t380.turno1 = t350.codice'
      'and    t380.progressivo = t430.progressivo'
      'and    t380.data between t430.datadecorrenza and t430.datafine'
      'and    t430.contratto = t200.codice'
      'union all'
      
        'select decode(oreminuti(nvl(t350.turno_intero,t200.reperibilita)' +
        '),'
      '              0,0,'
      '              (oreminuti(to_char(t350.orafine,'#39'hh24.mi'#39')) - '
      '               oreminuti(to_char(t350.orainizio,'#39'hh24.mi'#39')) +'
      '               decode(sign(t350.orafine - t350.orainizio),'
      '                      0,1440,'
      '                      -1,1440,'
      '                      0)) /'
      
        '              oreminuti(nvl(t350.turno_intero,t200.reperibilita)' +
        ')) rapporto,'
      '       1 contatore'
      
        'from   t380_pianifreperib t380, t350_regreperib t350, t430_stori' +
        'co t430, t200_contratti t200'
      'where  t350.tipologia = :TIPOLOGIA'
      'and    t380.progressivo = :PROGRESSIVO'
      'and    t380.data between :DATADA and :DATAA'
      ':FILTRO'
      'and    t380.turno2 = t350.codice'
      'and    t380.progressivo = t430.progressivo'
      'and    t380.data between t430.datadecorrenza and t430.datafine'
      'and    t430.contratto = t200.codice'
      'union all'
      
        'select decode(oreminuti(nvl(t350.turno_intero,t200.reperibilita)' +
        '),'
      '              0,0,'
      '              (oreminuti(to_char(t350.orafine,'#39'hh24.mi'#39')) - '
      '               oreminuti(to_char(t350.orainizio,'#39'hh24.mi'#39')) +'
      '               decode(sign(t350.orafine - t350.orainizio),'
      '                      0,1440,'
      '                      -1,1440,'
      '                      0)) /'
      
        '              oreminuti(nvl(t350.turno_intero,t200.reperibilita)' +
        ')) rapporto,'
      '       1 contatore'
      
        'from   t380_pianifreperib t380, t350_regreperib t350, t430_stori' +
        'co t430, t200_contratti t200'
      'where  t350.tipologia = :TIPOLOGIA'
      'and    t380.progressivo = :PROGRESSIVO'
      'and    t380.data between :DATADA and :DATAA'
      ':FILTRO'
      'and    t380.turno3 = t350.codice'
      'and    t380.progressivo = t430.progressivo'
      'and    t380.data between t430.datadecorrenza and t430.datafine'
      'and    t430.contratto = t200.codice'
      ')')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000005000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A0044004100540041004400
      41000C00000000000000000000000C0000003A00440041005400410041000C00
      000000000000000000000E0000003A00460049004C00540052004F0001000000
      0000000000000000140000003A005400490050004F004C004F00470049004100
      050000000000000000000000}
    Left = 204
    Top = 196
  end
  object selTurni: TOracleDataSet
    SQL.Strings = (
      'SELECT :HINTT030V430'
      '       T380.TURNO1 TURNO'
      'FROM   T380_PIANIFREPERIB T380,'
      '       :C700SelAnagrafe'
      'AND    T380.PROGRESSIVO = T030.PROGRESSIVO'
      'AND    T380.DATA BETWEEN :DATA1 AND :DATA2'
      'AND    T380.TIPOLOGIA = :TIPOLOGIA'
      'AND    T380.TURNO1 IS NOT NULL'
      ':RAGGRUPPAMENTO'
      'UNION'
      'SELECT :HINTT030V430'
      '       T380.TURNO2'
      'FROM   T380_PIANIFREPERIB T380,'
      '       :C700SelAnagrafe'
      'AND    T380.PROGRESSIVO = T030.PROGRESSIVO'
      'AND    T380.DATA BETWEEN :DATA1 AND :DATA2'
      'AND    T380.TIPOLOGIA = :TIPOLOGIA'
      'AND    T380.TURNO2 IS NOT NULL'
      ':RAGGRUPPAMENTO'
      'UNION'
      'SELECT :HINTT030V430'
      '       T380.TURNO3'
      'FROM   T380_PIANIFREPERIB T380,'
      '       :C700SelAnagrafe'
      'AND    T380.PROGRESSIVO = T030.PROGRESSIVO'
      'AND    T380.DATA BETWEEN :DATA1 AND :DATA2'
      'AND    T380.TIPOLOGIA = :TIPOLOGIA'
      'AND    T380.TURNO3 IS NOT NULL'
      ':RAGGRUPPAMENTO')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      0400000006000000200000003A004300370030003000530045004C0041004E00
      4100470052004100460045000100000000000000000000001A0000003A004800
      49004E0054005400300033003000560034003300300001000000000000000000
      00000C0000003A00440041005400410031000C00000000000000000000000C00
      00003A00440041005400410032000C0000000000000000000000140000003A00
      5400490050004F004C004F004700490041000500000000000000000000001E00
      00003A005200410047004700520055005000500041004D0045004E0054004F00
      010000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000C00000016000000500052004F004700520045005300530049005600
      4F000100000000000E000000430041005500530041004C004500010000000000
      120000005400490050004F004700490055005300540001000000000006000000
      440041004C000100000000000400000041004C00010000000000120000004E00
      55004D00450052004F004F00520045000100000000000E000000440041005400
      41004E00410053000100000000001C0000004100550054004F00520049005A00
      5A0041005A0049004F004E004500010000000000180000005200450053005000
      4F004E0053004100420049004C004500010000000000140000004E004F004D00
      49004E0041005400490056004F00010000000000120000004D00410054005200
      490043004F004C00410001000000000016000000440045005300430052004900
      5A0049004F004E004500010000000000}
    Left = 370
    Top = 140
  end
  object selT350Cod: TOracleDataSet
    SQL.Strings = (
      
        'select CODICE, DESCRIZIONE, to_char(ORAINIZIO,'#39'hh24.mi'#39') HINI, t' +
        'o_char(ORAFINE,'#39'hh24.mi'#39') HFINE'
      'from   T350_REGREPERIB'
      'where  TIPOLOGIA = :TIPOLOGIA'
      'order by :ORDERBY')
    ReadBuffer = 20
    Optimize = False
    Variables.Data = {
      0400000002000000140000003A005400490050004F004C004F00470049004100
      050000000000000000000000100000003A004F00520044004500520042005900
      010000000000000000000000}
    Filtered = True
    Left = 424
    Top = 140
  end
  object D010: TDataSource
    Left = 437
    Top = 196
  end
  object D010B: TDataSource
    Left = 477
    Top = 196
  end
  object D010C: TDataSource
    Left = 517
    Top = 196
  end
  object selT355: TOracleDataSet
    SQL.Strings = (
      
        'select T355.* ,rpad(CODICE,5,'#39' '#39') || '#39' '#39' || DESCRIZIONE CODICE_D' +
        'ESCRIZIONE'
      '  from T355_STAMPE_REPERIB T355'
      ' order by T355.CODICE')
    Optimize = False
    Left = 328
    Top = 200
  end
  object drsT355: TDataSource
    DataSet = selT355
    Left = 376
    Top = 200
  end
  object selNumMaxTurni: TOracleDataSet
    SQL.Strings = (
      'SELECT MAX(COUNT(DISTINCT TURNO)) '
      'FROM ('
      ''
      'SELECT :HINTT030V430'
      
        '       /*NULL|T030.MATRICOLA*/ /*T030.MATRICOLA*/ :RAGGRUPPAMENT' +
        'O1 CAMPO_RAGGRUPPAMENTO,'
      '       T380.TURNO1 TURNO'
      'FROM   T380_PIANIFREPERIB T380,'
      '       :C700SelAnagrafe'
      'AND    T380.PROGRESSIVO = T030.PROGRESSIVO'
      'AND    T380.DATA BETWEEN :DATA1 AND :DATA2'
      'AND    T380.TIPOLOGIA = :TIPOLOGIA'
      'AND    T380.TURNO1 IS NOT NULL'
      'UNION'
      'SELECT :HINTT030V430'
      
        '        /*NULL|T030.MATRICOLA*/ /*T030.MATRICOLA*/ :RAGGRUPPAMEN' +
        'TO2 CAMPO_RAGGRUPPAMENTO,'
      '       T380.TURNO2'
      'FROM   T380_PIANIFREPERIB T380,'
      '       :C700SelAnagrafe'
      'AND    T380.PROGRESSIVO = T030.PROGRESSIVO'
      'AND    T380.DATA BETWEEN :DATA1 AND :DATA2'
      'AND    T380.TIPOLOGIA = :TIPOLOGIA'
      'AND    T380.TURNO2 IS NOT NULL'
      'UNION'
      'SELECT :HINTT030V430'
      
        '       /*NULL|T030.MATRICOLA*/ /*T030.MATRICOLA*/ :RAGGRUPPAMENT' +
        'O3 CAMPO_RAGGRUPPAMENTO, '
      '       T380.TURNO3'
      'FROM   T380_PIANIFREPERIB T380,'
      '       :C700SelAnagrafe'
      'AND    T380.PROGRESSIVO = T030.PROGRESSIVO'
      'AND    T380.DATA BETWEEN :DATA1 AND :DATA2'
      'AND    T380.TIPOLOGIA = :TIPOLOGIA'
      'AND    T380.TURNO3 IS NOT NULL'
      ') GROUP BY CAMPO_RAGGRUPPAMENTO'
      '')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      0400000008000000200000003A004300370030003000530045004C0041004E00
      4100470052004100460045000100000000000000000000001A0000003A004800
      49004E0054005400300033003000560034003300300001000000000000000000
      00000C0000003A00440041005400410031000C00000000000000000000000C00
      00003A00440041005400410032000C0000000000000000000000140000003A00
      5400490050004F004C004F004700490041000500000000000000000000002000
      00003A005200410047004700520055005000500041004D0045004E0054004F00
      3100010000000000000000000000200000003A00520041004700470052005500
      5000500041004D0045004E0054004F0032000100000000000000000000002000
      00003A005200410047004700520055005000500041004D0045004E0054004F00
      3300010000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000C00000016000000500052004F004700520045005300530049005600
      4F000100000000000E000000430041005500530041004C004500010000000000
      120000005400490050004F004700490055005300540001000000000006000000
      440041004C000100000000000400000041004C00010000000000120000004E00
      55004D00450052004F004F00520045000100000000000E000000440041005400
      41004E00410053000100000000001C0000004100550054004F00520049005A00
      5A0041005A0049004F004E004500010000000000180000005200450053005000
      4F004E0053004100420049004C004500010000000000140000004E004F004D00
      49004E0041005400490056004F00010000000000120000004D00410054005200
      490043004F004C00410001000000000016000000440045005300430052004900
      5A0049004F004E004500010000000000}
    Left = 290
    Top = 140
  end
  object selPermutazioniDatiAgg: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT DATOAGG1, DATOAGG2 FROM ('
      'SELECT T380.DATOAGG1_T1 DATOAGG1, T380.DATOAGG2_T1 DATOAGG2'
      'FROM   T380_PIANIFREPERIB T380,'
      '       :C700SelAnagrafe'
      'AND    T380.PROGRESSIVO = T030.PROGRESSIVO'
      'AND    T380.DATA BETWEEN :DATA1 AND :DATA2'
      'AND    T380.TIPOLOGIA = :TIPOLOGIA'
      'AND    T380.TURNO1 IS NOT NULL'
      ':RAGGRUPPAMENTO'
      'UNION'
      'SELECT T380.DATOAGG1_T2 DATOAGG1, T380.DATOAGG2_T2 DATOAGG2'
      'FROM   T380_PIANIFREPERIB T380,'
      '       :C700SelAnagrafe'
      'AND    T380.PROGRESSIVO = T030.PROGRESSIVO'
      'AND    T380.DATA BETWEEN :DATA1 AND :DATA2'
      'AND    T380.TIPOLOGIA = :TIPOLOGIA'
      'AND    T380.TURNO2 IS NOT NULL'
      ':RAGGRUPPAMENTO'
      'UNION'
      'SELECT T380.DATOAGG1_T3 DATOAGG1, T380.DATOAGG2_T3 DATOAGG2'
      'FROM   T380_PIANIFREPERIB T380,'
      '       :C700SelAnagrafe'
      'AND    T380.PROGRESSIVO = T030.PROGRESSIVO'
      'AND    T380.DATA BETWEEN :DATA1 AND :DATA2'
      'AND    T380.TIPOLOGIA = :TIPOLOGIA'
      'AND    T380.TURNO3 IS NOT NULL'
      ':RAGGRUPPAMENTO)')
    Optimize = False
    Variables.Data = {
      0400000005000000200000003A004300370030003000530045004C0041004E00
      4100470052004100460045000100000000000000000000000C0000003A004400
      41005400410031000C00000000000000000000000C0000003A00440041005400
      410032000C0000000000000000000000140000003A005400490050004F004C00
      4F004700490041000500000000000000000000001E0000003A00520041004700
      4700520055005000500041004D0045004E0054004F0001000000000000000000
      0000}
    Left = 504
    Top = 136
  end
  object SelAnagrafeLookUp: TOracleDataSet
    Optimize = False
    Left = 24
    Top = 198
  end
end
