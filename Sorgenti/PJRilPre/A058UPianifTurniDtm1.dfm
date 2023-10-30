object A058FPianifTurniDtM1: TA058FPianifTurniDtM1
  OldCreateOrder = True
  OnCreate = A058FPianifTurniDtM1Create
  OnDestroy = A058FPianifTurniDtM1Destroy
  Height = 366
  Width = 787
  object Q020: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE, DESCRIZIONE, TIPOORA, DECORRENZA'
      '  FROM T020_ORARI T020'
      ' WHERE DECORRENZA = (SELECT MAX(DECORRENZA) '
      '                       FROM T020_ORARI '
      '                      WHERE CODICE = T020.CODICE) '
      ' ORDER BY CODICE')
    ReadBuffer = 200
    Optimize = False
    BeforeOpen = ReadBufferBeforeOpen
    AfterOpen = Q020AfterOpen
    OnFilterRecord = FiltroDizionario
    Left = 84
    Top = 12
  end
  object Q020Turni: TOracleDataSet
    SQL.Strings = (
      
        'select T021.ENTRATA, T021.USCITA, T021.SIGLATURNI, T021.NUMTURNO' +
        ', T021.ID_TURNO'
      '  from T021_FASCEORARI T021'
      ' where T021.CODICE = :Cod '
      '   and T021.TIPO_FASCIA = '#39'PN'#39' '
      '   and T021.DECORRENZA = (select max(DECORRENZA) '
      '                            from T021_FASCEORARI '
      #9#9#9'   where CODICE = T021.CODICE '
      '                             and DECORRENZA <= :Data)'
      'order by nvl(T021.ID_TURNO,oreminuti(T021.ENTRATA)),T021.USCITA')
    ReadBuffer = 200
    Optimize = False
    Variables.Data = {
      0400000002000000080000003A0043004F004400050000000000000000000000
      0A0000003A0044004100540041000C0000000000000000000000}
    Left = 124
    Top = 12
  end
  object Q040: TOracleDataSet
    SQL.Strings = (
      'select /*+ INDEX(T040_GIUSTIFICATIVI T040_PK)*/'
      '  '#39'T040'#39' TABELLA,'
      
        '  T040.DATA, T040.CAUSALE, T040.PROGRCAUSALE, T040.SCHEDA, DECOD' +
        'E(T265.VALIDAZIONE,'#39'S'#39',DECODE(T040.SCHEDA,'#39'V'#39','#39'N'#39','#39'S'#39'),'#39'N'#39') VALI' +
        'DAZIONE,'
      '  T040.TIPOGIUST,'
      '  T040.DAORE,T040.AORE,'
      '  decode(T040.SCHEDA,'#39'P'#39','#39'PIAN'#39','#39'CART'#39') COMPETENZA'
      'from T040_GIUSTIFICATIVI T040, T265_CAUASSENZE T265'
      'where PROGRESSIVO = :PROGRESSIVO '
      '  and T040.CAUSALE = T265.CODICE'
      '  and DATA between :DATA1 and :DATA2 '
      '  --AND TIPOGIUST = '#39'I'#39
      ''
      'union all'
      ''
      'select'
      '  decode(T050.STATO,null,'#39'T050'#39','#39'T040'#39') TABELLA,'
      
        '  V010.DATA,T050.CAUSALE, 0 PROGRCAUSALE, null SCHEDA, '#39'N'#39' VALID' +
        'AZIONE,'
      '  T050.TIPOGIUST,'
      
        '  decode(T050.NUMEROORE,null,to_date(null),to_date('#39'30121899'#39','#39'd' +
        'dmmyyyy'#39') + oreminuti(T050.NUMEROORE)/1440) DAORE,'
      
        '  decode(T050.AORE,null,to_date(null),to_date('#39'30121899'#39','#39'ddmmyy' +
        'yy'#39') + oreminuti(T050.AORE)/1440) AAORE,'
      '  decode(T050.STATO,null,'#39'ITER'#39','#39'CART'#39') COMPETENZA'
      
        'from VT050_RICHIESTE_SENZAREVOCA T050, T265_CAUASSENZE T265, V01' +
        '0_CALENDARI V010'
      'where T050.PROGRESSIVO = :PROGRESSIVO '
      '  and T050.CAUSALE = T265.CODICE'
      '  and DAL <= :DATA2'
      '  and AL >= :DATA1'
      '  and T050.ELABORATO = '#39'N'#39
      '  and nvl(T050.STATO,'#39'S'#39') = '#39'S'#39
      '  and V010.PROGRESSIVO = T050.PROGRESSIVO'
      '  and V010.DATA between T050.DAL and T050.AL'
      '  and V010.DATA between :DATA1 and :DATA2'
      ''
      'order by DATA,TIPOGIUST,CAUSALE,PROGRCAUSALE')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 168
    Top = 12
  end
  object Q080: TOracleDataSet
    SQL.Strings = (
      'select T080.*'
      '  from T080_PIANIFORARI T080'
      ' where T080.PROGRESSIVO = :PROGRESSIVO '
      '   and T080.DATA BETWEEN :DATA1 AND :DATA2 '
      '   and (T080.FLAGAGG <> '#39'P'#39' '
      '    or T080.FLAGAGG is null)'
      ' order by T080.DATA')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 200
    Top = 12
  end
  object Q221: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T221.* FROM T221_PROFILISETTIMANA T221, T220_PROFILIORARI' +
        ' T220'
      'WHERE T220.CODICE = :CODICE '
      'AND   :DATA BETWEEN T220.DECORRENZA AND T220.DECORRENZA_FINE'
      'AND   T220.CODICE = T221.CODICE '
      'AND   T220.DECORRENZA = T221.DECORRENZA'
      'AND   T221.PROGRESSIVO = 1'
      '')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A0043004F004400490043004500050000000000
      0000000000000A0000003A0044004100540041000C0000000000000000000000}
    Left = 232
    Top = 12
  end
  object Q265: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T265.CODICE, T265.DESCRIZIONE, T265.GSIGNIFIC, T265.TIPOC' +
        'UMULO, T260.CODINTERNO'
      '  FROM T265_CAUASSENZE T265, T260_RAGGRASSENZE T260'
      ' WHERE T265.CODRAGGR = T260.CODICE'
      ' ORDER BY T265.CODICE')
    ReadBuffer = 100
    Optimize = False
    BeforeOpen = Q265BeforeOpen
    OnFilterRecord = FiltroDizionario
    Left = 264
    Top = 12
  end
  object Q265B: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T265.CODICE, T265.DESCRIZIONE, T265.GSIGNIFIC, T265.TIPOC' +
        'UMULO, T260.CODINTERNO'
      '  FROM T265_CAUASSENZE T265, T260_RAGGRASSENZE T260'
      ' WHERE T265.CODRAGGR = T260.CODICE'
      ' ORDER BY T265.CODICE')
    ReadBuffer = 200
    Optimize = False
    BeforeOpen = Q265BBeforeOpen
    OnFilterRecord = FiltroDizionario
    Left = 296
    Top = 12
  end
  object Q430: TOracleDataSet
    SQL.Strings = (
      'SELECT CALENDARIO,PORARIO,TIPOOPE,SQUADRA FROM T430_STORICO'
      'WHERE PROGRESSIVO = :PROGRESSIVO AND'
      ':DATA BETWEEN DATADECORRENZA AND DATAFINE')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 328
    Top = 12
  end
  object Q080Gest: TOracleDataSet
    SQL.Strings = (
      'select T080.*,T080.ROWID'
      '  from T080_PIANIFORARI T080'
      ' where T080.PROGRESSIVO = :PROGRESSIVO '
      '   and T080.DATA BETWEEN :DATA1 AND :DATA2'
      ' order by T080.DATA')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    CachedUpdates = True
    Left = 20
    Top = 60
  end
  object Q040Gest: TOracleDataSet
    SQL.Strings = (
      'select /*+ INDEX(T040_GIUSTIFICATIVI T040_PK)*/'
      '  '#39'T040'#39' TABELLA,'
      
        '  PROGRESSIVO,DATA,CAUSALE,PROGRCAUSALE,SCHEDA,DECODE(T265.VALID' +
        'AZIONE,'#39'S'#39',DECODE(T040.SCHEDA,'#39'V'#39','#39'N'#39','#39'S'#39'),'#39'N'#39') VALIDAZIONE,TIPO' +
        'GIUST,DAORE,AORE,T040.ROWID,'
      '  decode(T040.SCHEDA,'#39'P'#39','#39'PIAN'#39','#39'CART'#39') COMPETENZA'
      '  from T040_GIUSTIFICATIVI T040, T265_CAUASSENZE T265'
      ' where PROGRESSIVO = :PROGRESSIVO '
      '   and T040.CAUSALE = T265.CODICE'
      '   and DATA between :DATA1 and :DATA2 '
      '--   AND TIPOGIUST = '#39'I'#39
      ':SCHEDA'
      ''
      'union all'
      ''
      'select'
      '  decode(T050.STATO,null,'#39'T050'#39','#39'T040'#39') TABELLA,'
      '  T050.PROGRESSIVO, V010.DATA,T050.CAUSALE, 0 PROGRCAUSALE, '
      '  null SCHEDA, '#39'N'#39' VALIDAZIONE,'
      '  T050.TIPOGIUST,'
      
        '  decode(T050.NUMEROORE,null,to_date(null),to_date('#39'30121899'#39','#39'd' +
        'dmmyyyy'#39') + oreminuti(T050.NUMEROORE)/1440) DAORE,'
      
        '  decode(T050.AORE,null,to_date(null),to_date('#39'30121899'#39','#39'ddmmyy' +
        'yy'#39') + oreminuti(T050.AORE)/1440) AAORE,'
      '  T050.ROWID,'
      '  decode(T050.STATO,null,'#39'ITER'#39','#39'CART'#39') COMPETENZA'
      
        'from VT050_RICHIESTE_SENZAREVOCA T050, T265_CAUASSENZE T265, V01' +
        '0_CALENDARI V010'
      'where T050.PROGRESSIVO = :PROGRESSIVO '
      '  and T050.CAUSALE = T265.CODICE'
      '  and DAL <= :DATA2'
      '  and AL >= :DATA1'
      '  and T050.ELABORATO = '#39'N'#39
      '  and nvl(T050.STATO,'#39'S'#39') = '#39'S'#39
      '  and V010.PROGRESSIVO = T050.PROGRESSIVO'
      '  and V010.DATA between T050.DAL and T050.AL'
      '  and V010.DATA between :DATA1 and :DATA2'
      ''
      'order by DATA,TIPOGIUST,CAUSALE,PROGRCAUSALE')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      00000000000000000E0000003A00530043004800450044004100010000000000
      000000000000}
    UpdatingTable = 'T040_GIUSTIFICATIVI'
    CachedUpdates = True
    Left = 72
    Top = 60
  end
  object Q081Gest: TOracleDataSet
    SQL.Strings = (
      'SELECT T081.*,T081.ROWID'
      'FROM T081_PROVVISORIO T081'
      'WHERE PROGRESSIVO = :PROGRESSIVO '
      '  AND DATA BETWEEN :DATA1 AND :DATA2'
      '  :FLAGAGG'
      'ORDER BY DATA')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000100000003A0046004C004100470041004700470001000000
      0000000000000000}
    CachedUpdates = True
    Left = 128
    Top = 60
  end
  object Q041Gest: TOracleDataSet
    SQL.Strings = (
      
        'SELECT PROGRESSIVO,DATA,CAUSALE, PROGRCAUSALE, FLAGAGG, COMPETEN' +
        'ZA, ROWID'
      'FROM T041_PROVVISORIO'
      'WHERE PROGRESSIVO = :PROGRESSIVO '
      '  AND DATA BETWEEN :DATA1 AND :DATA2'
      '  :FLAGAGG'
      'ORDER BY DATA, PROGRCAUSALE')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000100000003A0046004C004100470041004700470001000000
      0000000000000000}
    CachedUpdates = True
    Left = 184
    Top = 60
  end
  object Q611: TOracleDataSet
    SQL.Strings = (
      'SELECT TURNO1,TURNO2,TURNO1EU,TURNO2EU,ORARIO,CAUSALE '
      'FROM T611_CICLIGIORNALIERI'
      'WHERE CICLO = :CICLO'
      'ORDER BY GIORNO')
    Optimize = False
    Variables.Data = {
      04000000010000000C0000003A004300490043004C004F000500000000000000
      00000000}
    Left = 52
    Top = 108
  end
  object Q620: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T620.DATA, T620.TURNAZIONE, T620.PARTENZA, T620.VERIFICA_' +
        'TURNI, T620.VERIFICA_RIPOSI, T620.PIANIF_DA_CALENDARIO'
      '  FROM T620_TURNAZIND T620'
      ' WHERE T620.PROGRESSIVO = :PROGRESSIVO'
      ' ORDER BY T620.DATA')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Left = 84
    Top = 108
  end
  object Q630: TOracleDataSet
    SQL.Strings = (
      'SELECT DATA,ORARIO,TURNO1,TURNO2 '
      '  FROM T630_SPOSTSQUADRA'
      ' WHERE PROGRESSIVO = :PROGRESSIVO '
      '   AND DATA BETWEEN :DATA1 AND :DATA2'
      ' ORDER BY DATA')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 116
    Top = 108
  end
  object Q641: TOracleDataSet
    SQL.Strings = (
      'SELECT CICLO1,CICLO2,CICLO3,CICLO4,CICLO5,MULTIPLO'
      'FROM T641_MOLTTURNAZIONE'
      'WHERE TURNAZIONE = :TURNAZIONE'
      'ORDER BY ORDINE')
    Optimize = False
    Variables.Data = {
      0400000001000000160000003A005400550052004E0041005A0049004F004E00
      4500050000000000000000000000}
    Left = 148
    Top = 108
  end
  object CancAllT080: TOracleQuery
    SQL.Strings = (
      'DELETE FROM T080_PIANIFORARI WHERE'
      'PROGRESSIVO = :PROGRESSIVO AND'
      'DATA BETWEEN :DATA1 AND :DATA2'
      '')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 20
    Top = 156
  end
  object CancT080: TOracleQuery
    SQL.Strings = (
      'DELETE '
      '  FROM T080_PIANIFORARI '
      ' WHERE PROGRESSIVO = :PROGRESSIVO '
      '   AND DATA BETWEEN :DATA1 AND :DATA2 '
      '   AND FLAGAGG = '#39'P'#39)
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 80
    Top = 156
  end
  object CancT081: TOracleQuery
    SQL.Strings = (
      'DELETE '
      '  FROM T081_PROVVISORIO '
      ' WHERE PROGRESSIVO = :PROGRESSIVO '
      '   AND DATA BETWEEN :DATA1 AND :DATA2'
      ' :FLAGAGG')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000100000003A0046004C004100470041004700470001000000
      0000000000000000}
    Left = 132
    Top = 156
  end
  object CancT040: TOracleQuery
    SQL.Strings = (
      'DELETE /*+ INDEX(T040_GIUSTIFICATIVI T040_PK)*/'
      ' FROM T040_GIUSTIFICATIVI '
      'WHERE PROGRESSIVO = :PROGRESSIVO '
      '  AND DATA BETWEEN :DATA1 '
      '  AND :DATA2 '
      '  AND SCHEDA = '#39'P'#39
      '')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 192
    Top = 156
  end
  object CancT041: TOracleQuery
    SQL.Strings = (
      'DELETE FROM T041_PROVVISORIO '
      'WHERE PROGRESSIVO = :PROGRESSIVO '
      '  AND DATA BETWEEN :DATA1 AND :DATA2'
      '  :FLAGAGG ')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000100000003A0046004C004100470041004700470001000000
      0000000000000000}
    Left = 240
    Top = 156
  end
  object T058Stampa: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 344
    Top = 161
  end
  object QT021: TOracleDataSet
    SQL.Strings = (
      'SELECT *'
      '  FROM (SELECT T021.CODICE, T020.DECORRENZA, '
      
        #9'T020F_GETDECORRENZAFINE(T020.CODICE, T020.DECORRENZA) DECORRENZ' +
        'A_FINE,'
      
        #9'T021.TIPO_FASCIA,T021.ENTRATA,T021.USCITA,T021.SIGLATURNI,T021.' +
        'NUMTURNO,T021.ID_TURNO'
      '          FROM T021_FASCEORARI T021, T020_ORARI T020'
      '         WHERE T021.CODICE = T020.CODICE'
      '           AND T021.DECORRENZA = T020.DECORRENZA'
      '           AND T021.TIPO_FASCIA = '#39'PN'#39
      '           AND T021.CODICE IN (:ORARI)'
      
        '         ORDER BY T021.CODICE,T021.DECORRENZA,T021.TIPO_FASCIA,n' +
        'vl(T021.ID_TURNO,oreminuti(T021.ENTRATA)),T021.USCITA)')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      04000000010000000C0000003A004F0052004100520049000100000005000000
      6E756C6C0000000000}
    Left = 416
    Top = 13
  end
  object dsrT603: TDataSource
    DataSet = selT603
    Left = 504
    Top = 16
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
      00003A004700030000000000000000000000120000003A004D004F004E005400
      45004F0052004500050000000000000000000000}
    Left = 624
    Top = 68
  end
  object _SelQ040: TOracleDataSet
    SQL.Strings = (
      'SELECT count(*) as CONTA'
      '  FROM T040_GIUSTIFICATIVI'
      ' WHERE PROGRESSIVO = :PROGRESSIVO '
      '   AND DATA=:DATA'
      '   AND CAUSALE=:CAUSALE'
      '   AND PROGRCAUSALE=:PROGRCAUSALE'
      '   AND TIPOGIUST = '#39'I'#39
      '   AND NVL(SCHEDA,'#39#39')='#39#39)
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    CachedUpdates = True
    Left = 715
    Top = 132
  end
  object Q021: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T021.CODICE, T021.NUMTURNO, T021.ID_TURNO, T021.SIGLATURN' +
        'I, T021.ENTRATA, T021.USCITA'
      '  FROM T021_FASCEORARI T021'
      ' WHERE T021.DECORRENZA = (SELECT MAX(DECORRENZA) '
      '                            FROM T021_FASCEORARI '
      '                           WHERE CODICE = T021.CODICE '
      '                             AND DECORRENZA <= :DECORRENZA) '
      '   AND T021.TIPO_FASCIA = '#39'PN'#39
      
        ' ORDER BY T021.CODICE, nvl(T021.ID_TURNO,oreminuti(T021.ENTRATA)' +
        '), T021.USCITA')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000001000000160000003A004400450043004F005200520045004E005A00
      41000C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000050000000C00000043004F0044004900430045000100000000001000
      00004E0055004D005400550052004E004F000100000000001400000053004900
      47004C0041005400550052004E0049000100000000000E00000045004E005400
      52004100540041000100000000000C0000005500530043004900540041000100
      00000000}
    BeforeOpen = ReadBufferBeforeOpen
    Left = 462
    Top = 161
    object Q021CODICE: TStringField
      FieldName = 'CODICE'
      Required = True
      Size = 5
    end
    object Q021NUMTURNO: TIntegerField
      FieldName = 'NUMTURNO'
    end
    object Q021ID_TURNO: TIntegerField
      FieldName = 'ID_TURNO'
    end
    object Q021SIGLATURNI: TStringField
      FieldName = 'SIGLATURNI'
      Size = 2
    end
    object Q021ENTRATA: TStringField
      FieldName = 'ENTRATA'
      Required = True
      Size = 5
    end
    object Q021USCITA: TStringField
      FieldName = 'USCITA'
      Required = True
      Size = 5
    end
    object Q021numfascia: TStringField
      FieldKind = fkCalculated
      FieldName = 'numfascia'
      Size = 1
      Calculated = True
    end
  end
  object D021: TDataSource
    DataSet = Q021
    Left = 406
    Top = 161
  end
  object selRiposi: TOracleDataSet
    SQL.Strings = (
      'select count(*) NUM '
      '  from (select T080.DATA '
      '          from T080_PIANIFORARI T080'
      '         where T080.PROGRESSIVO = :PROGRESSIVO '
      '           and T080.DATA between :DATA1 and :DATA2 '
      '           and T080.TURNO1 = '#39'0'#39
      '         union'
      '        select DATA '
      
        '          from T040_GIUSTIFICATIVI T040, T265_CAUASSENZE T265, T' +
        '260_RAGGRASSENZE T260'
      '         where T040.PROGRESSIVO = :PROGRESSIVO '
      '           and T040.DATA between :DATA1 and :DATA2 '
      '           and T040.CAUSALE = T265.CODICE '
      '           and T265.CODRAGGR = T260.CODICE '
      '           and T260.CODINTERNO in ('#39'H'#39','#39'E'#39'))')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 24
    Top = 208
  end
  object selFestLav: TOracleDataSet
    SQL.Strings = (
      'SELECT COUNT(*) NUM '
      '  FROM (SELECT DATA '
      '          FROM V010_CALENDARI V010'
      '         WHERE V010.PROGRESSIVO = :PROGRESSIVO '
      '           AND V010.DATA BETWEEN :DATA1 AND :DATA2 '
      
        '           AND (V010.FESTIVO = '#39'S'#39' OR TO_CHAR(V010.DATA,'#39'd'#39') IN ' +
        '(7,1))'
      '         MINUS'
      '        SELECT DATA '
      '          FROM T080_PIANIFORARI T080'
      '         WHERE T080.PROGRESSIVO = :PROGRESSIVO '
      '           AND T080.DATA BETWEEN :DATA1 AND :DATA2 '
      '           AND T080.TURNO1 = '#39'0'#39
      '           AND :PIANIF_OPERATIVA = '#39'S'#39
      '         MINUS'
      '        SELECT DATA '
      '          FROM T081_PROVVISORIO T081'
      '         WHERE T081.PROGRESSIVO = :PROGRESSIVO '
      '           AND T081.DATA BETWEEN :DATA1 AND :DATA2 '
      '           AND T081.TURNO1 = '#39'0'#39
      '           AND :PIANIF_OPERATIVA = '#39'N'#39
      '           AND T081.FLAGAGG = :FLAGAGG'
      '         MINUS'
      '        SELECT DATA '
      
        '          FROM T040_GIUSTIFICATIVI T040, T265_CAUASSENZE T265, T' +
        '260_RAGGRASSENZE T260'
      '         WHERE T040.PROGRESSIVO = :PROGRESSIVO '
      '           AND T040.DATA BETWEEN :DATA1 AND :DATA2 '
      '           AND T040.CAUSALE = T265.CODICE '
      '           AND T265.CODRAGGR = T260.CODICE '
      '           AND T260.CODINTERNO IN ('#39'H'#39','#39'E'#39')'
      '           AND :GIUST_OPERATIVI = '#39'S'#39
      '         MINUS'
      '        SELECT DATA '
      
        '          FROM T041_PROVVISORIO T041, T265_CAUASSENZE T265, T260' +
        '_RAGGRASSENZE T260'
      '         WHERE T041.PROGRESSIVO = :PROGRESSIVO '
      '           AND T041.DATA BETWEEN :DATA1 AND :DATA2 '
      '           AND T041.CAUSALE = T265.CODICE '
      '           AND T265.CODRAGGR = T260.CODICE '
      '           AND T260.CODINTERNO IN ('#39'H'#39','#39'E'#39')'
      '           AND :GIUST_NONOPERATIVI = '#39'S'#39
      '           AND T041.FLAGAGG = :FLAGAGG'
      '       )')
    Optimize = False
    Variables.Data = {
      0400000007000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000220000003A005000490041004E00490046005F004F005000
      4500520041005400490056004100050000000000000000000000200000003A00
      470049005500530054005F004F00500045005200410054004900560049000500
      00000000000000000000260000003A00470049005500530054005F004E004F00
      4E004F0050004500520041005400490056004900050000000000000000000000
      100000003A0046004C0041004700410047004700050000000000000000000000}
    Left = 88
    Top = 208
  end
  object dsrT606a: TDataSource
    DataSet = selT606a
    Left = 632
    Top = 304
  end
  object V430Colonne: TOracleDataSet
    SQL.Strings = (
      'SELECT COLUMN_NAME'
      '  FROM COLS'
      ' WHERE TABLE_NAME = '#39'V430_STORICO'#39
      '   AND TABLE_NAME = '#39'T030_ANAGRAFICO'#39)
    Optimize = False
    Left = 152
    Top = 208
  end
  object SovrascriviT041: TOracleQuery
    SQL.Strings = (
      'declare'
      '  cursor C1 is'
      
        '    select T040.PROGRESSIVO,T040.DATA, T040.CAUSALE, T040.PROGRC' +
        'AUSALE, decode(T040.SCHEDA,'#39'P'#39','#39'PIAN'#39','#39'CART'#39') COMPETENZA'
      '      from T040_GIUSTIFICATIVI T040'
      '     where T040.PROGRESSIVO = :PROGRESSIVO'
      '       and T040.DATA between :DATADA and :DATAA'
      '       and T040.TIPOGIUST = '#39'I'#39
      '    union'
      
        '    select T050.PROGRESSIVO, V010.DATA,T050.CAUSALE, 0 PROGRCAUS' +
        'ALE, decode(T050.STATO,null,'#39'ITER'#39','#39'CART'#39') COMPETENZA'
      
        '    from VT050_RICHIESTE_SENZAREVOCA T050, T265_CAUASSENZE T265,' +
        ' V010_CALENDARI V010'
      '    where T050.PROGRESSIVO = :PROGRESSIVO '
      '      and T050.CAUSALE = T265.CODICE'
      '      and DAL <= :DATAA'
      '      and AL >= :DATADA'
      '      and T050.TIPOGIUST = '#39'I'#39
      '      and T050.ELABORATO = '#39'N'#39
      '      and nvl(T050.STATO,'#39'S'#39') = '#39'S'#39
      '      and V010.PROGRESSIVO = T050.PROGRESSIVO'
      '      and V010.DATA between T050.DAL and T050.AL'
      '      and V010.DATA between :DATADA and :DATAA'
      '    order by DATA;'
      'begin'
      '  for T1 in C1 loop'
      '    delete'
      '      from T041_PROVVISORIO T041'
      '     where T041.PROGRESSIVO = T1.PROGRESSIVO'
      '       and T041.DATA = T1.DATA'
      '       and T041.CAUSALE = T1.CAUSALE'
      '       and T041.FLAGAGG = '#39'N'#39';'
      '   '
      
        '    insert into T041_PROVVISORIO(PROGRESSIVO, DATA, CAUSALE, FLA' +
        'GAGG, PROGRCAUSALE, COMPETENZA)'
      
        '    values(T1.PROGRESSIVO, T1.DATA, T1.CAUSALE, '#39'N'#39', T1.PROGRCAU' +
        'SALE, T1.COMPETENZA);'
      '  end loop;'
      'end;')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A0044004100540041004400
      41000C00000000000000000000000C0000003A00440041005400410041000C00
      00000000000000000000}
    Left = 336
    Top = 210
  end
  object InserisciT041: TOracleQuery
    SQL.Strings = (
      
        'insert into T041_PROVVISORIO(PROGRESSIVO, DATA, CAUSALE, FLAGAGG' +
        ', PROGRCAUSALE, COMPETENZA)'
      
        'select PROGRESSIVO, DATA, CAUSALE, FLAGG, PROGRCAUSALE, COMPETEN' +
        'ZA from '
      '('
      
        '  select T040.PROGRESSIVO, T040.DATA, T040.CAUSALE, '#39'N'#39' FLAGG, T' +
        '040.PROGRCAUSALE, decode(T040.SCHEDA,'#39'P'#39','#39'PIAN'#39','#39'CART'#39') COMPETEN' +
        'ZA'
      '    from T040_GIUSTIFICATIVI T040'
      '   where T040.DATA between :DATADA and :DATAA'
      '     and T040.PROGRESSIVO = :PROGRESSIVO'
      '     and T040.TIPOGIUST = '#39'I'#39
      '  union '
      
        '  select T050.PROGRESSIVO, V010.DATA,T050.CAUSALE, '#39'N'#39', 0 PROGRC' +
        'AUSALE, decode(T050.STATO,null,'#39'ITER'#39','#39'CART'#39') COMPETENZA'
      
        '    from VT050_RICHIESTE_SENZAREVOCA T050, T265_CAUASSENZE T265,' +
        ' V010_CALENDARI V010'
      '   where T050.PROGRESSIVO = :PROGRESSIVO '
      '     and T050.CAUSALE = T265.CODICE'
      '     and DAL <= :DATAA'
      '     and AL >= :DATADA'
      '     and T050.TIPOGIUST = '#39'I'#39
      '     and T050.ELABORATO = '#39'N'#39
      '     and nvl(T050.STATO,'#39'S'#39') = '#39'S'#39
      '     and V010.PROGRESSIVO = T050.PROGRESSIVO'
      '     and V010.DATA between T050.DAL and T050.AL'
      '     and V010.DATA between :DATADA and :DATAA'
      ') T040 '
      'where DATA not in'
      '  (select T041.DATA '
      '   from T041_PROVVISORIO T041'
      '   where T041.DATA between :DATADA and :DATAA'
      '   and T041.PROGRESSIVO = T040.PROGRESSIVO'
      '  )')
    Optimize = False
    Variables.Data = {
      04000000030000000E0000003A004400410054004100440041000C0000000000
      0000000000000C0000003A00440041005400410041000C000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      00000000000000000000}
    Left = 406
    Top = 210
  end
  object selT620: TOracleDataSet
    SQL.Strings = (
      'SELECT T620.PROGRESSIVO, '#39'*'#39' as PIANIF_DA_CALENDARIO '
      '  FROM T620_TURNAZIND T620'
      ' WHERE T620.PIANIF_DA_CALENDARIO = '#39'S'#39
      '   AND T620.DATA = (SELECT MAX(DATA)'
      '                      FROM T620_TURNAZIND'
      '                     WHERE DATA <= :DATAA'
      '                       AND PROGRESSIVO = T620.PROGRESSIVO)'
      ' ORDER BY T620.PROGRESSIVO')
    Optimize = False
    Variables.Data = {
      04000000010000000C0000003A00440041005400410041000C00000000000000
      00000000}
    Left = 462
    Top = 210
  end
  object UpdT040: TOracleQuery
    SQL.Strings = (
      'UPDATE T040_GIUSTIFICATIVI T040'
      '   SET T040.SCHEDA = '#39'V'#39
      ' WHERE T040.PROGRESSIVO = :PROG'
      '   AND T040.DATA = :DATA'
      '   AND T040.CAUSALE  = :CAUS')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A00500052004F00470003000000000000000000
      00000A0000003A0044004100540041000C00000000000000000000000A000000
      3A004300410055005300050000000000000000000000}
    Left = 240
    Top = 208
  end
  object selT040: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T030.MATRICOLA, T030.COGNOME, T030.NOME, T040.DATA, T040.' +
        'CAUSALE'
      
        '  FROM T040_GIUSTIFICATIVI T040, T030_ANAGRAFICO T030, T265_CAUA' +
        'SSENZE T265'
      ' WHERE T040.PROGRESSIVO = T030.PROGRESSIVO'
      '   AND T040.CAUSALE = T265.CODICE'
      '   AND T040.PROGRESSIVO = :PROG'
      '   AND T040.DATA BETWEEN :DATADA AND :DATAA'
      '   AND T265.VALIDAZIONE = '#39'S'#39
      '   AND NVL(T040.SCHEDA,'#39'P'#39') <> '#39'V'#39
      
        ' ORDER BY T030.MATRICOLA, T030.COGNOME, T030.NOME, T040.DATA, T0' +
        '40.TIPOGIUST, T040.CAUSALE, T040.PROGRCAUSALE')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A00500052004F00470003000000000000000000
      00000E0000003A004400410054004100440041000C0000000000000000000000
      0C0000003A00440041005400410041000C0000000000000000000000}
    Left = 243
    Top = 112
  end
  object selT530: TOracleDataSet
    SQL.Strings = (
      'select * from T530_CONFIGSERVIZI')
    Optimize = False
    Left = 515
    Top = 68
  end
  object selT011: TOracleDataSet
    SQL.Strings = (
      'SELECT * '
      '  FROM T011_CALENDARI '
      ' WHERE CODICE = :CODICE '
      '   AND DATA BETWEEN :DATA1 AND :DATA2'
      ' ORDER BY DATA')
    Optimize = False
    Variables.Data = {
      04000000030000000E0000003A0043004F004400490043004500050000000000
      0000000000000C0000003A00440041005400410031000C000000000000000000
      00000C0000003A00440041005400410032000C0000000000000000000000}
    Left = 472
    Top = 68
  end
  object selT380: TOracleDataSet
    SQL.Strings = (
      'select T380.DATA, T380.TURNO1, T380.TURNO2, T380.TURNO3,'
      
        '       nvl(T350_1.SIGLA,T350_1.CODICE) SIGLA, to_char(T350_1.ORA' +
        'INIZIO,'#39'HH24.MI'#39') ORAINIZIO, to_char(T350_1.ORAFINE,'#39'HH24.MI'#39') O' +
        'RAFINE,'
      
        '       nvl(T350_2.SIGLA,T350_2.CODICE) SIGLA2, to_char(T350_2.OR' +
        'AINIZIO,'#39'HH24.MI'#39') ORAINIZIO2, to_char(T350_2.ORAFINE,'#39'HH24.MI'#39')' +
        ' ORAFINE2,'
      
        '       nvl(T350_3.SIGLA,T350_3.CODICE) SIGLA3, to_char(T350_3.OR' +
        'AINIZIO,'#39'HH24.MI'#39') ORAINIZIO3, to_char(T350_3.ORAFINE,'#39'HH24.MI'#39')' +
        ' ORAFINE3'
      'from   T380_PIANIFREPERIB T380, '
      '       T350_REGREPERIB T350_1, '
      '       T350_REGREPERIB T350_2, '
      '       T350_REGREPERIB T350_3'
      'where  T380.TURNO1 = T350_1.CODICE '
      'and    T380.TURNO2 = T350_2.CODICE(+) '
      'and    T380.TURNO3 = T350_3.CODICE(+) '
      'and    T380.PROGRESSIVO = :PROGRESSIVO '
      'and    T380.DATA between :DATADA and :DATAA'
      'order by T380.DATA')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A0044004100540041004400
      41000C00000000000000000000000C0000003A00440041005400410041000C00
      00000000000000000000}
    Left = 294
    Top = 154
  end
  object selT430: TOracleDataSet
    SQL.Strings = (
      'SELECT T430.SQUADRA, T603.DESCRIZIONE, COUNT(*) AS NUMTURN'
      '  FROM T430_STORICO T430, T603_SQUADRE T603'
      ' WHERE T430.SQUADRA IS NOT NULL'
      
        '   AND TRUNC(SYSDATE) BETWEEN T430.DATADECORRENZA AND T430.DATAF' +
        'INE'
      '   AND T603.CODICE = T430.SQUADRA'
      '   :FILTRO'
      ' GROUP BY T430.SQUADRA, T603.DESCRIZIONE'
      ' ORDER BY NUMTURN DESC')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A00460049004C00540052004F00010000000000
      000000000000}
    Left = 571
    Top = 112
  end
  object selT082: TOracleDataSet
    SQL.Strings = (
      'select T082.*'
      '  from T082_PAR_PIANIFORARI T082'
      ' order by T082.CODICE')
    Optimize = False
    OnFilterRecord = FiltroDizionario
    Left = 292
    Top = 61
  end
  object dtsT082: TDataSource
    DataSet = selT082
    Left = 294
    Top = 105
  end
  object AusT058: TClientDataSet
    PersistDataPacket.Data = {
      350000009619E0BD010000001800000001000000000003000000350006434F44
      49434501004900000001000557494454480200020005000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODICE'
        DataType = ftString
        Size = 5
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 336
    Top = 63
  end
  object dtsAusT058: TDataSource
    DataSet = AusT058
    Left = 336
    Top = 105
  end
  object selT100: TOracleDataSet
    SQL.Strings = (
      
        'select T100.DATA, T100.CAUSALE, to_char(T100.ORA,'#39'HH24.MI'#39') as O' +
        'RA, T100.VERSO, T100.CAUSALE'
      '  from T100_TIMBRATURE T100'
      ' where T100.PROGRESSIVO = :PROGRESSIVO'
      '   and T100.DATA between :DADATA and :ADATA'
      ' order by T100.DATA')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A0044004100440041005400
      41000C00000000000000000000000C0000003A00410044004100540041000C00
      00000000000000000000}
    Left = 91
    Top = 252
  end
  object selV430: TOracleDataSet
    SQL.Strings = (
      'select :COLONNE'
      '  from V430_STORICO V430, T030_ANAGRAFICO T030'
      ' where T030.PROGRESSIVO = V430.T430PROGRESSIVO'
      '   and T030.PROGRESSIVO = :PROGRESSIVO'
      
        '   and :DATA between V430.T430DATADECORRENZA and V430.T430DATAFI' +
        'NE'
      ' order by 1')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000003000000100000003A0043004F004C004F004E004E00450001000000
      00000000000000000A0000003A0044004100540041000C000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      00000000000000000000}
    Left = 154
    Top = 252
  end
  object selGetSquadraDip: TOracleDataSet
    SQL.Strings = (
      'select T.*, T603.DESCRIZIONE'
      
        '  from (select '#39'T430'#39' PROVENIENZA, T430.SQUADRA, T430.TIPOOPE, T' +
        '430.DATADECORRENZA, T430.DATAFINE '
      '          from T430_STORICO T430'
      '         where T430.PROGRESSIVO = :PROGRESSIVO'
      '           and T430.DATADECORRENZA <= :DATA2'
      '           and T430.DATAFINE >= :DATA1'
      '         union'
      
        '        select '#39'T630'#39' PROVENIENZA, T630.SQUADRA, T630.COD_TIPOOP' +
        'E TIPOOPE, T630.DATA, T630.DATA '
      '          from T630_SPOSTSQUADRA T630'
      '         where T630.PROGRESSIVO = :PROGRESSIVO'
      
        '           and T630.DATA between :DATA1 and :DATA2) T, T603_SQUA' +
        'DRE T603'
      ' where T.SQUADRA = T603.CODICE'
      ' order by T.PROVENIENZA, T.DATADECORRENZA')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003200
      0C00000000000000000000000C0000003A00440041005400410031000C000000
      0000000000000000}
    Left = 475
    Top = 112
  end
  object selT265Esclusione: TOracleDataSet
    SQL.Strings = (
      'SELECT T265.CODICE,T265.ESCLUSIONE,T260.CODINTERNO'
      'FROM T265_CAUASSENZE T265, T260_RAGGRASSENZE T260'
      'WHERE 1=1'
      '--AND T265.ESCLUSIONE = '#39'S'#39
      'AND T265.CODRAGGR = T260.CODICE'
      'ORDER BY CODICE')
    ReadBuffer = 200
    Optimize = False
    BeforeOpen = selT265EsclusioneBeforeOpen
    OnFilterRecord = FiltroDizionario
    Left = 626
    Top = 13
  end
  object selV010: TOracleDataSet
    SQL.Strings = (
      'select DATA,FESTIVO,LAVORATIVO,NUMGIORNI,CODICE '
      'from V010_CALENDARI '
      'where PROGRESSIVO = :PROGRESSIVO'
      'and DATA between :DAL and :AL'
      'order by DATA')
    ReadBuffer = 32
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000080000003A00440041004C000C000000
      0000000000000000060000003A0041004C000C0000000000000000000000}
    Left = 679
    Top = 68
  end
  object cdsT611: TClientDataSet
    PersistDataPacket.Data = {
      460100009619E0BD01000000180000000B00000000000300000046010B50524F
      475245535349564F0400010000000000094D41545249434F4C41010049000000
      01000557494454480200020008000A4E4F4D494E415449564F01004900000001
      00055749445448020002003C0007535155414452410100490000000100055749
      4454480200020028000E5449504F5F4F50455241544F52450100490000000100
      0557494454480200020005000A5455524E415A494F4E45010049000000010005
      5749445448020002000500054349434C4F010049000000010005574944544802
      000200050009504F53495A494F4E450400010000000000064F524152494F0100
      490000000100055749445448020002000500065455524E4F3101004900000001
      00055749445448020002000500065455524E4F32010049000000010005574944
      54480200020005000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'PROGRESSIVO'
        DataType = ftInteger
      end
      item
        Name = 'MATRICOLA'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'NOMINATIVO'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'SQUADRA'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'TIPO_OPERATORE'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'TURNAZIONE'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'CICLO'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'POSIZIONE'
        DataType = ftInteger
      end
      item
        Name = 'ORARIO'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'TURNO1'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'TURNO2'
        DataType = ftString
        Size = 5
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 193
    Top = 108
  end
  object selAnomalie: TOracleDataSet
    SQL.Strings = (
      
        'SELECT DECODE(LTRIM(RTRIM(I006.TIPO)),'#39'A'#39','#39'Anomalia'#39','#39'I'#39','#39'Inform' +
        'azione'#39','#39'B'#39','#39'Riep.bloccato'#39') AS TIPO,'
      '       RTRIM(LTRIM(I006.MSG)) AS MSG,'
      '       T030.COGNOME||'#39' '#39'||T030.NOME AS NOMINATIVO,'
      '       T030.MATRICOLA'
      
        'FROM MONDOEDP.I005_MSGINFO I005, MONDOEDP.I006_MSGDATI I006, T03' +
        '0_ANAGRAFICO T030'
      'WHERE I005.ID = I006.ID'
      '   AND T030.PROGRESSIVO(+) = I006.PROGRESSIVO'
      '   AND NVL(I006.AZIENDA_MSG,'#39'AZIN'#39') = :AZIENDA'
      
        '   AND NVL(I005.AZIENDA,'#39'AZIN'#39')||'#39'.'#39'||NVL(I005.OPERATORE,'#39'SERVIZ' +
        'I_MONDOEDP'#39') = :AZIENDA || '#39'.'#39' || :OPERATORE'
      '   AND I005.MASCHERA = '#39'A058'#39
      '   AND I006.TIPO IN ('#39'A'#39', '#39'B'#39')'
      '   AND TRUNC(I005.DATA) = :DATA_ELAB'
      '   AND I005.ID = :ID_MESSAGGI'
      'ORDER BY I005.ID DESC, I006.ID_MSG')
    Optimize = False
    Variables.Data = {
      0400000004000000100000003A0041005A00490045004E004400410005000000
      0000000000000000140000003A004F00500045005200410054004F0052004500
      050000000000000000000000140000003A0044004100540041005F0045004C00
      410042000C0000000000000000000000180000003A00490044005F004D004500
      530053004100470047004900030000000000000000000000}
    Left = 24
    Top = 304
    object selAnomalieMSG: TStringField
      DisplayLabel = 'Anomalia'
      DisplayWidth = 4000
      FieldName = 'MSG'
      Size = 4000
    end
    object selAnomalieMATRICOLA: TStringField
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selAnomalieNOMINATIVO: TStringField
      DisplayWidth = 100
      FieldName = 'NOMINATIVO'
      Size = 100
    end
  end
  object selT650: TOracleDataSet
    SQL.Strings = (
      
        'select T650.*, T650.CODICE||'#39'-'#39'||T650.DESCRIZIONE DECODIFICA fro' +
        'm T650_AREE_TURNI T650'
      '-- where T650.CODICE = :AREA'
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
    BeforeOpen = ReadBufferBeforeOpen
    Left = 96
    Top = 304
  end
  object selT651: TOracleDataSet
    SQL.Strings = (
      'select T650.*,T651.* '
      'from T650_AREE_TURNI T650, T651_AREE_SQUADRA T651'
      'where T651.CODICE_AREA = T650.CODICE'
      
        'order by T651.CODICE_SQUADRA, T651.CODICE_OPERATORE, T650.SIGLA,' +
        ' T650.CODICE')
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
    BeforeOpen = ReadBufferBeforeOpen
    Left = 136
    Top = 304
  end
  object selT603: TOracleDataSet
    SQL.Strings = (
      
        'select INIZIO_VALIDITA, FINE_VALIDITA, T603.CODICE, T603.DESCRIZ' +
        'IONE, T603.CAUS_RIPOSO'
      'from T603_SQUADRE T603'
      'where T603.INIZIO_VALIDITA <= :DATAA'
      'and T603.FINE_VALIDITA >= :DATADA'
      'and :DATAA >= :DATADA'
      'order by T603.CODICE')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A004400410054004100440041000C0000000000
      0000000000000C0000003A00440041005400410041000C000000000000000000
      0000}
    Filtered = True
    BeforeOpen = ReadBufferBeforeOpen
    OnFilterRecord = selT603FilterRecord
    Left = 464
    Top = 16
    object selT603CODICE: TStringField
      DisplayWidth = 13
      FieldName = 'CODICE'
      Size = 10
    end
    object selT603DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selT603CAUS_RIPOSO: TStringField
      FieldName = 'CAUS_RIPOSO'
      Size = 5
    end
  end
  object selT606: TOracleDataSet
    SQL.Strings = (
      
        'select DECORRENZA,DECORRENZA_FINE,COD_GIORNO,COD_CONDIZIONE,SIGL' +
        'A_TURNO, MINIMO, MASSIMO'
      'from T606_CONDIZIONI'
      'where PROGRESSIVO = :PROGRESSIVO'
      'and COD_SQUADRA = :COD_SQUADRA'
      'and COD_TIPOOPE = :COD_TIPOOPE'
      'and COD_ORARIO = :COD_ORARIO'
      '--and :DATA between DECORRENZA and DECORRENZA_FINE'
      '--and COD_CONDIZIONE = :COD_CONDIZIONE'
      '--and COD_GIORNO = :COD_GIORNO'
      'order by PRIORITA')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A0043004F0044005F0053005100550041004400
      52004100050000000000000000000000180000003A00500052004F0047005200
      450053005300490056004F00030000000000000000000000160000003A004300
      4F0044005F004F0052004100520049004F000500000000000000000000001800
      00003A0043004F0044005F005400490050004F004F0050004500050000000000
      000000000000}
    OnFilterRecord = FilterRecordT606
    Left = 528
    Top = 304
  end
  object selT606a: TOracleDataSet
    SQL.Strings = (
      'select DECORRENZA,DECORRENZA_FINE, '
      '       COD_TIPOOPE, SIGLA_TURNO, COD_GIORNO,'
      '       GIORNI.DESCRIZIONE DESC_GIORNO, '
      '       GIORNI.ORD ORD_GIORNO, '
      '       MINIMO, MASSIMO'
      'from T606_CONDIZIONI T606,'
      
        '     (select '#39'F'#39' CODICE, '#39'Festivi'#39'        DESCRIZIONE,  1 ORD fr' +
        'om dual union'
      
        '      select '#39'P'#39' CODICE, '#39'Prefestivi'#39'     DESCRIZIONE,  2 ORD fr' +
        'om dual union'
      
        '      select '#39'1'#39' CODICE, '#39'Luned'#236#39'         DESCRIZIONE,  3 ORD fr' +
        'om dual union'
      
        '      select '#39'2'#39' CODICE, '#39'Marted'#236#39'        DESCRIZIONE,  4 ORD fr' +
        'om dual union'
      
        '      select '#39'3'#39' CODICE, '#39'Mercoled'#236#39'      DESCRIZIONE,  5 ORD fr' +
        'om dual union'
      
        '      select '#39'4'#39' CODICE, '#39'Gioved'#236#39'        DESCRIZIONE,  6 ORD fr' +
        'om dual union'
      
        '      select '#39'5'#39' CODICE, '#39'Venerd'#236#39'        DESCRIZIONE,  7 ORD fr' +
        'om dual union'
      
        '      select '#39'6'#39' CODICE, '#39'Sabato'#39'         DESCRIZIONE,  8 ORD fr' +
        'om dual union'
      
        '      select '#39'7'#39' CODICE, '#39'Domenica'#39'       DESCRIZIONE,  9 ORD fr' +
        'om dual union'
      
        '      select '#39'*'#39' CODICE, '#39'Tutti i giorni'#39' DESCRIZIONE, 10 ORD fr' +
        'om dual      ) GIORNI'
      'where PROGRESSIVO = :PROGRESSIVO'
      'and COD_SQUADRA = :COD_SQUADRA'
      'and COD_ORARIO = :COD_ORARIO'
      'and :DATA between DECORRENZA and DECORRENZA_FINE'
      'and GIORNI.CODICE = T606.COD_GIORNO'
      'and COD_CONDIZIONE = :COD_CONDIZIONE'
      'order by COD_TIPOOPE, PRIORITA, SIGLA_TURNO, ORD_GIORNO')
    Optimize = False
    Variables.Data = {
      0400000005000000180000003A0043004F0044005F0053005100550041004400
      520041000500000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000180000003A00500052004F0047005200450053005300
      490056004F00030000000000000000000000160000003A0043004F0044005F00
      4F0052004100520049004F000500000000000000000000001E0000003A004300
      4F0044005F0043004F004E00440049005A0049004F004E004500050000000000
      000000000000}
    Left = 584
    Top = 304
  end
  object selT606b: TOracleDataSet
    SQL.Strings = (
      
        'select DECORRENZA, DECORRENZA_FINE, COD_GIORNO, COD_TIPOOPE, SIG' +
        'LA_TURNO'
      'from T606_CONDIZIONI'
      'where PROGRESSIVO = :PROGRESSIVO'
      'and COD_SQUADRA = :COD_SQUADRA'
      'and COD_ORARIO = :COD_ORARIO'
      'and COD_CONDIZIONE = :COD_CONDIZIONE'
      '--and COD_GIORNO = :COD_GIORNO'
      '--and :DATA between DECORRENZA and DECORRENZA_FINE'
      
        'order by DECORRENZA, COD_GIORNO, COD_TIPOOPE, PRIORITA, SIGLA_TU' +
        'RNO')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A0043004F0044005F0053005100550041004400
      520041000500000000000000000000001E0000003A0043004F0044005F004300
      4F004E00440049005A0049004F004E0045000500000000000000000000001800
      00003A00500052004F0047005200450053005300490056004F00030000000000
      000000000000160000003A0043004F0044005F004F0052004100520049004F00
      050000000000000000000000}
    OnFilterRecord = FilterRecordT606
    Left = 688
    Top = 304
  end
  object selI210: TOracleDataSet
    SQL.Strings = (
      'SELECT *'
      'FROM   I210_REGOLE_ARCHIVIAZIONE'
      'WHERE  TIPO_DOCUMENTO = '#39'TAB'#39)
    Optimize = False
    Left = 496
    Top = 255
  end
  object selT962: TOracleDataSet
    SQL.Strings = (
      'select * from T962_TIPO_DOCUMENTI where CODICE = :CODICE')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 550
    Top = 255
  end
  object selT606c: TOracleDataSet
    SQL.Strings = (
      'select DECORRENZA,DECORRENZA_FINE,VALORE'
      'from T606_CONDIZIONI'
      'where PROGRESSIVO = :PROGRESSIVO'
      'and COD_SQUADRA = :COD_SQUADRA'
      'and COD_TIPOOPE = :COD_TIPOOPE'
      'and COD_ORARIO = :COD_ORARIO'
      'and SIGLA_TURNO = :SIGLA_TURNO'
      'and COD_GIORNO = :COD_GIORNO'
      'and COD_CONDIZIONE = :COD_CONDIZIONE'
      'and :DATA between DECORRENZA and DECORRENZA_FINE')
    Optimize = False
    Variables.Data = {
      0400000008000000180000003A0043004F0044005F0053005100550041004400
      520041000500000000000000000000001E0000003A0043004F0044005F004300
      4F004E00440049005A0049004F004E0045000500000000000000000000000A00
      00003A0044004100540041000C0000000000000000000000160000003A004300
      4F0044005F00470049004F0052004E004F000500000000000000000000001800
      00003A00500052004F0047005200450053005300490056004F00030000000000
      000000000000160000003A0043004F0044005F004F0052004100520049004F00
      050000000000000000000000180000003A005300490047004C0041005F005400
      550052004E004F00050000000000000000000000180000003A0043004F004400
      5F005400490050004F004F0050004500050000000000000000000000}
    Left = 736
    Top = 304
  end
  object selTipoOpe: TOracleDataSet
    SQL.Strings = (
      'select distinct T430.TIPOOPE'
      'from T430_STORICO T430'
      'where T430.TIPOOPE is not null'
      'order by T430.TIPOOPE')
    Optimize = False
    Left = 232
    Top = 304
    object selT430TIPOOPE: TStringField
      DisplayWidth = 7
      FieldName = 'TIPOOPE'
      Size = 5
    end
  end
  object selSostituti: TOracleDataSet
    SQL.Strings = (
      'select A.*, '
      
        '       TO_DATE(DECODE(A.ULTIMA_USCITA,'#39'In servizio'#39',NULL,A.ULTIM' +
        'A_USCITA),'#39'DD/MM/YYYY HH24.MI'#39') ULTIMA_USCITA_NV,'
      '       DECODE(A.N_ESUBERO_MIN,NULL,'#39'N'#39','#39'S'#39') ESUBERO_MIN_NV,'
      '       DECODE(A.N_ESUBERO_MAX,NULL,'#39'N'#39','#39'S'#39') ESUBERO_MAX_NV'
      'from ('
      
        '  select T030.PROGRESSIVO PROGRESSIVO_NV, V430.T430BADGE BADGE_N' +
        'V, T030.MATRICOLA, T030.COGNOME, T030.NOME,'
      
        '         trunc(months_between(:DATA,NVL(T030.DATANAS,:DATA))/12)' +
        ' ETA_ANNI,'
      
        '         trunc(months_between(:DATA,NVL(V430.T430INIZIO,:DATA))/' +
        '12) RL_ANNI,'
      
        '         (select max(decode(T100.VERSO,'#39'U'#39',T100.DATA ||'#39' '#39'|| to_' +
        'char(T100.ORA,'#39'HH24.MI'#39'),'#39'E'#39','#39'In servizio'#39',NULL))'
      '          from T100_TIMBRATURE T100'
      '          where T100.PROGRESSIVO = T030.PROGRESSIVO'
      '          and T100.FLAG in ('#39'I'#39','#39'O'#39')'
      '          and T100.DATA = (select max(T100B.DATA) '
      '                           from T100_TIMBRATURE T100B'
      
        '                           where T100B.PROGRESSIVO = T100.PROGRE' +
        'SSIVO'
      '                           and T100B.FLAG in ('#39'I'#39','#39'O'#39'))'
      
        '          and OREMINUTI(to_char(T100.ORA,'#39'HH24.MI'#39')) = (select m' +
        'ax(OREMINUTI(to_char(T100B.ORA,'#39'HH24.MI'#39')))'
      
        '                                                        from T10' +
        '0_TIMBRATURE T100B'
      
        '                                                        where T1' +
        '00B.PROGRESSIVO = T100.PROGRESSIVO'
      
        '                                                        and T100' +
        'B.FLAG in ('#39'I'#39','#39'O'#39')'
      
        '                                                        and T100' +
        'B.DATA = T100.DATA)) ULTIMA_USCITA,'
      
        '         (select nvl(TRIM(T08X1.TURNO2||T08X1.TURNO2EU),TRIM(T08' +
        'X1.TURNO1||T08X1.TURNO1EU))'
      '          from :TAB_PIANIF T08X1'
      '          where nvl(T08X1.FLAGAGG,'#39'X'#39') = nvl(:FLAGAGG,'#39'X'#39')'
      '          and T08X1.PROGRESSIVO = T030.PROGRESSIVO'
      '          and T08X1.DATA = :DATA - 1) ULTIMO_TR_GGPREC,'
      
        '         ASSE.CAUSALE_ASS, ASSE.D_CAUSALE_ASS, ASSE.TIPOGIUST_AS' +
        'S, ASSE.DURATA_ASS,'
      '         decode(PIAN.TIPO,'#39'P'#39','#39'S'#39','#39'N'#39') PIANIFICATO_NV,'
      
        '         PIAN.SQ_PIANIF, PIAN.D_SQ_PIANIF, PIAN.OP_PIANIF, PIAN.' +
        'TR_PIANIF, PIAN.ETR_PIANIF, PIAN.UTR_PIANIF, '
      
        '         PIAN.SG_PIANIF, PIAN.MIN_SIGLA N_MIN_PIANIF, PIAN.DIP_S' +
        'IGLA N_DIP_PIANIF, PIAN.MAX_SIGLA N_MAX_PIANIF,'
      
        '         decode(PIAN.TIPO,'#39'P'#39',decode(SIGN(NVL(PIAN.MIN_SIGLA,999' +
        '9) - PIAN.DIP_SIGLA),-1,PIAN.MIN_SIGLA - PIAN.DIP_SIGLA,NULL),NU' +
        'LL) N_ESUBERO_MIN,--Esuberi sul min a livello di squadra/operato' +
        're/sigla'
      
        '         decode(PIAN.TIPO,'#39'P'#39',decode(SIGN(NVL(PIAN.MAX_SIGLA,999' +
        '9) - PIAN.DIP_SIGLA),-1,PIAN.MAX_SIGLA - PIAN.DIP_SIGLA,NULL),NU' +
        'LL) N_ESUBERO_MAX,--Esuberi sul max a livello di squadra/operato' +
        're/sigla'
      '         decode(DISP.TIPO,'#39'D'#39','#39'S'#39','#39'N'#39') DISPONIBILE_NV,'
      
        '         DISP.SQUADRE SQ_DISP, DISP.DAORE DA_DISP, DISP.AORE A_D' +
        'ISP, DISP.NOTE NT_DISP,'
      '         V430.T430SQUADRA, V430.T430D_SQUADRA, '
      
        '         (select round(sum(least(V430A.T430DATAFINE,:DATA) - gre' +
        'atest(V430A.T430DATADECORRENZA,V430A.T430INIZIO) + 1)/365,1)'
      '          from V430_STORICO V430A'
      '          where V430A.T430PROGRESSIVO = V430.T430PROGRESSIVO'
      '          and V430A.T430INIZIO = V430.T430INIZIO'
      
        '          and nvl(V430A.T430FINE,:DATA) = nvl(V430.T430FINE,:DAT' +
        'A)'
      
        '          and nvl(V430A.T430SQUADRA,'#39'#NULL#'#39') = nvl(V430.T430SQU' +
        'ADRA,'#39'#NULL#'#39')'
      
        '          and greatest(V430A.T430DATADECORRENZA,V430A.T430INIZIO' +
        ') <= least(V430A.T430DATAFINE,:DATA)) T430SQUADRA_ANNI,'
      '         V430.T430TIPOOPE,'
      
        '         (select round(sum(least(V430A.T430DATAFINE,:DATA) - gre' +
        'atest(V430A.T430DATADECORRENZA,V430A.T430INIZIO) + 1)/365,1)'
      '          from V430_STORICO V430A'
      '          where V430A.T430PROGRESSIVO = V430.T430PROGRESSIVO'
      '          and V430A.T430INIZIO = V430.T430INIZIO'
      
        '          and nvl(V430A.T430FINE,:DATA) = nvl(V430.T430FINE,:DAT' +
        'A)'
      
        '          and nvl(V430A.T430TIPOOPE,'#39'#NULL#'#39') = nvl(V430.T430TIP' +
        'OOPE,'#39'#NULL#'#39')'
      
        '          and greatest(V430A.T430DATADECORRENZA,V430A.T430INIZIO' +
        ') <= least(V430A.T430DATAFINE,:DATA)) T430TIPOOPE_ANNI'
      '          :CAMPI'
      '  from T030_ANAGRAFICO T030,'
      '       V430_STORICO V430,'
      
        '       (select '#39'D'#39' TIPO, T600.PROGRESSIVO, T600.DAORE, T600.AORE' +
        ', T600.SQUADRE, '#39'R: '#39'||T850.NOTE||'#39' - A: '#39'||T851F_GETNOTE(T850.I' +
        'D,T851F_MAXLIV_AUTORIZZATO(:AZIENDA,'#39'T600'#39',T850.ID)) NOTE'
      '        from T600_RICHIESTEDISPTURNI T600,'
      '             T850_ITER_RICHIESTE T850'
      '        where T600.DATA = :DATA'
      '        and INSTR('#39','#39'||T600.SQUADRE||'#39','#39','#39','#39'||:SQUADRA||'#39','#39') > 0'
      '        and T850.ITER = '#39'T600'#39
      '        and T850.ID = T600.ID'
      '        and T850.STATO = '#39'S'#39
      '        and OREMINUTI(T600.DAORE) <= OREMINUTI(:DAORE)'
      '        and (   (    OREMINUTI(:AORE) > OREMINUTI(:DAORE)'
      '                 and OREMINUTI(T600.AORE) >= OREMINUTI(:AORE))'
      '             or (    OREMINUTI(:AORE) < OREMINUTI(:DAORE)'
      '                 and OREMINUTI(T600.AORE) = OREMINUTI('#39'23.59'#39') '
      
        '                 and exists (select 1 from T600_RICHIESTEDISPTUR' +
        'NI T600A'
      '                             where T600A.DATA = T600.DATA + 1'
      
        '                             and T600A.PROGRESSIVO = T600.PROGRE' +
        'SSIVO'
      
        '                             and INSTR('#39','#39'||T600A.SQUADRE||'#39','#39','#39 +
        ','#39'||:SQUADRA||'#39','#39') > 0'
      
        '                             and OREMINUTI(T600A.DAORE) = OREMIN' +
        'UTI('#39'00.00'#39') '
      
        '                             and OREMINUTI(T600A.AORE) >= OREMIN' +
        'UTI(:AORE))))'
      '        ) DISP,'
      '       (--Dipendenti pianificati'
      
        '        select '#39'P'#39' TIPO, T_PIANMINMAX.PROGRESSIVO, T_PIANMINMAX.' +
        'COD_SQUADRA SQ_PIANIF, T603.DESCRIZIONE D_SQ_PIANIF, T_PIANMINMA' +
        'X.COD_TIPOOPE OP_PIANIF, T_PIANMINMAX.ID_TURNO TR_PIANIF, T_PIAN' +
        'MINMAX.ENTRATA ETR_PIANIF, T_PIANMINMAX.USCITA UTR_PIANIF, T_PIA' +
        'NMINMAX.SIGLA_TURNO SG_PIANIF, T_PIANMINMAX.MINIMO MIN_SIGLA, T_' +
        'PIANMINMAX.N_DIP DIP_SIGLA, T_PIANMINMAX.MASSIMO MAX_SIGLA'
      '        from ('
      
        '          select T_PIANIF.PROGRESSIVO, T_PIANIF.COD_SQUADRA, T_P' +
        'IANIF.COD_TIPOOPE, T_PIANIF.ID_TURNO, T_PIANIF.ENTRATA, T_PIANIF' +
        '.USCITA, T_PIANIF.SIGLA_TURNO, T606Z.MINIMO, T606Z.MASSIMO, '
      
        '                 count(*) over (partition by T_PIANIF.COD_SQUADR' +
        'A, T_PIANIF.COD_TIPOOPE, T_PIANIF.SIGLA_TURNO) N_DIP --Numero di' +
        ' dipendenti pianificati per ogni squadra/operatore/sigla'
      '          from'
      
        '            (--Pianificazioni giornaliere con dati dell'#39'orario p' +
        'ianificato'
      
        '            select T430.PROGRESSIVO, nvl(T630.SQUADRA,T430.SQUAD' +
        'RA) COD_SQUADRA, nvl(T630.COD_TIPOOPE,T430.TIPOOPE) COD_TIPOOPE,' +
        ' T021B.ID_TURNO, T021B.ENTRATA, T021B.USCITA, '
      
        '                   decode(T021B.ID_TURNO,T08X.TURNO1,decode(T08X' +
        '.TURNO1EU,'#39'U'#39','#39'Sn'#39',T021B.SIGLATURNI),T08X.TURNO2,decode(T08X.TUR' +
        'NO2EU,'#39'U'#39','#39'Sn'#39',T021B.SIGLATURNI)) SIGLA_TURNO'
      
        '            from :TAB_PIANIF T08X, T430_STORICO T430, T630_SPOST' +
        'SQUADRA T630,'
      '                 (--Orari con sigla valorizzata'
      
        '                  select T021.CODICE, T021.SIGLATURNI, T021.ENTR' +
        'ATA, T021.USCITA, --T021.NUMTURNO, T021.ID_TURNO, '
      
        '                         row_number() over (partition by T021.CO' +
        'DICE order by nvl(T021.ID_TURNO,oreminuti(T021.ENTRATA))) ID_TUR' +
        'NO--Numero del turno all'#39'interno del codice ordinati per id/entr' +
        'ata'
      '                  from T021_FASCEORARI T021'
      '                  where T021.TIPO_FASCIA = '#39'PN'#39
      
        '                  and T021.DECORRENZA = (select max(T021A.DECORR' +
        'ENZA)'
      
        '                                         from T021_FASCEORARI T0' +
        '21A'
      
        '                                         where T021A.CODICE = T0' +
        '21.CODICE'
      
        '                                         and T021A.DECORRENZA <=' +
        ' :DATA)'
      
        '                  order by T021.CODICE, nvl(T021.ID_TURNO,oremin' +
        'uti(T021.ENTRATA)), T021.USCITA) T021B'
      '            where nvl(T08X.FLAGAGG,'#39'X'#39') = nvl(:FLAGAGG,'#39'X'#39')'
      '            and T08X.DATA = :DATA'
      '            and T08X.ORARIO = T021B.CODICE'
      
        '            and (T08X.TURNO1 = T021B.ID_TURNO or T08X.TURNO2 = T' +
        '021B.ID_TURNO)'
      '            and T630.PROGRESSIVO (+) = T08X.PROGRESSIVO'
      '            and T630.DATA (+) = T08X.DATA'
      '            and T430.PROGRESSIVO = T08X.PROGRESSIVO'
      
        '            and :DATA between T430.DATADECORRENZA and T430.DATAF' +
        'INE'
      
        '            and :DATA between T430.INIZIO and nvl(T430.FINE,:DAT' +
        'A + 1)'
      '            ) T_PIANIF,'
      
        '            (--Copertura minima/massima per squadra/operatore/si' +
        'gla in base al tipo di giorno del dipendente corrente'
      
        '            select T606A.COD_SQUADRA, T606A.COD_TIPOOPE, T606A.S' +
        'IGLA_TURNO, '
      
        '                   nvl(decode(T606F.SIGLA_TURNO,NULL,decode(T606' +
        'P.SIGLA_TURNO,NULL,decode(T606G.SIGLA_TURNO,NULL,T606T.COD_GIORN' +
        'O,T606G.COD_GIORNO),T606P.COD_GIORNO),T606F.COD_GIORNO),0) COD_G' +
        'IORNO,'
      
        '                   nvl(decode(T606F.SIGLA_TURNO,NULL,decode(T606' +
        'P.SIGLA_TURNO,NULL,decode(T606G.SIGLA_TURNO,NULL,T606T.MINIMO,T6' +
        '06G.MINIMO),T606P.MINIMO),T606F.MINIMO),0) MINIMO,--Se non esist' +
        'e la condizione per quel tipo giorno, lo cerco a livelli pi'#249' gen' +
        'erali'
      
        '                   decode(T606F.SIGLA_TURNO,NULL,decode(T606P.SI' +
        'GLA_TURNO,NULL,decode(T606G.SIGLA_TURNO,NULL,T606T.MASSIMO,T606G' +
        '.MASSIMO),T606P.MASSIMO),T606F.MASSIMO) MASSIMO--Se non esiste l' +
        'a condizione per quel tipo giorno, lo cerco a livelli pi'#249' genera' +
        'li'
      
        '            from (--Sigle per squadra/operatore con copertura mi' +
        'nima impostata'
      
        '                  select distinct COD_SQUADRA, COD_TIPOOPE, SIGL' +
        'A_TURNO'
      '                  from T606_CONDIZIONI'
      '                  where COD_CONDIZIONE = '#39'00001'#39
      '                  and PROGRESSIVO = -1'
      '                  and COD_ORARIO = '#39'*'#39
      '                  and MINIMO is not null'
      
        '                  and :DATA between DECORRENZA and DECORRENZA_FI' +
        'NE) T606A,'
      
        '                 (--Sigle per squadra/operatore con copertura mi' +
        'nima impostata per i giorni FESTIVI'
      
        '                  select distinct COD_SQUADRA, COD_TIPOOPE, COD_' +
        'GIORNO, SIGLA_TURNO, MINIMO, MASSIMO'
      '                  from T606_CONDIZIONI'
      '                  where COD_CONDIZIONE = '#39'00001'#39
      '                  and PROGRESSIVO = -1'
      '                  and COD_ORARIO = '#39'*'#39
      '                  and COD_GIORNO = '#39'F'#39
      
        '                  and T080PCK_TURNO.GETTIPOGIORNO(:PROGRESSIVO,:' +
        'DATA,'#39'S'#39') = '#39'F'#39
      
        '                  and :DATA between DECORRENZA and DECORRENZA_FI' +
        'NE) T606F,'
      
        '                 (--Sigle per squadra/operatore con copertura mi' +
        'nima impostata per i giorni PREFESTIVI'
      
        '                  select distinct COD_SQUADRA, COD_TIPOOPE, COD_' +
        'GIORNO, SIGLA_TURNO, MINIMO, MASSIMO'
      '                  from T606_CONDIZIONI'
      '                  where COD_CONDIZIONE = '#39'00001'#39
      '                  and PROGRESSIVO = -1'
      '                  and COD_ORARIO = '#39'*'#39
      '                  and COD_GIORNO = '#39'P'#39
      
        '                  and T080PCK_TURNO.GETTIPOGIORNO(:PROGRESSIVO,:' +
        'DATA,'#39'S'#39') = '#39'P'#39
      
        '                  and :DATA between DECORRENZA and DECORRENZA_FI' +
        'NE) T606P,'
      
        '                 (--Sigle per squadra/operatore con copertura mi' +
        'nima impostata per i giorni SETTIMANALI'
      
        '                  select distinct COD_SQUADRA, COD_TIPOOPE, COD_' +
        'GIORNO, SIGLA_TURNO, MINIMO, MASSIMO'
      '                  from T606_CONDIZIONI'
      '                  where COD_CONDIZIONE = '#39'00001'#39
      '                  and PROGRESSIVO = -1'
      '                  and COD_ORARIO = '#39'*'#39
      '                  and COD_GIORNO = to_char(:DATA - 1,'#39'd'#39')'
      
        '                  and :DATA between DECORRENZA and DECORRENZA_FI' +
        'NE) T606G,'
      
        '                 (--Sigle per squadra/operatore con copertura mi' +
        'nima impostata per TUTTI i giorni'
      
        '                  select distinct COD_SQUADRA, COD_TIPOOPE, COD_' +
        'GIORNO, SIGLA_TURNO, MINIMO, MASSIMO'
      '                  from T606_CONDIZIONI'
      '                  where COD_CONDIZIONE = '#39'00001'#39
      '                  and PROGRESSIVO = -1'
      '                  and COD_ORARIO = '#39'*'#39
      '                  and COD_GIORNO = '#39'*'#39
      
        '                  and :DATA between DECORRENZA and DECORRENZA_FI' +
        'NE) T606T'
      
        '            where T606F.COD_SQUADRA (+) = T606A.COD_SQUADRA and ' +
        'T606F.COD_TIPOOPE (+) = T606A.COD_TIPOOPE and T606F.SIGLA_TURNO ' +
        '(+) = T606A.SIGLA_TURNO'
      
        '              and T606P.COD_SQUADRA (+) = T606A.COD_SQUADRA and ' +
        'T606P.COD_TIPOOPE (+) = T606A.COD_TIPOOPE and T606P.SIGLA_TURNO ' +
        '(+) = T606A.SIGLA_TURNO'
      
        '              and T606G.COD_SQUADRA (+) = T606A.COD_SQUADRA and ' +
        'T606G.COD_TIPOOPE (+) = T606A.COD_TIPOOPE and T606G.SIGLA_TURNO ' +
        '(+) = T606A.SIGLA_TURNO'
      
        '              and T606T.COD_SQUADRA (+) = T606A.COD_SQUADRA and ' +
        'T606T.COD_TIPOOPE (+) = T606A.COD_TIPOOPE and T606T.SIGLA_TURNO ' +
        '(+) = T606A.SIGLA_TURNO'
      
        '            --order by T606A.COD_SQUADRA, T606A.COD_TIPOOPE, T60' +
        '6A.SIGLA_TURNO'
      '            ) T606Z'
      '          where T606Z.SIGLA_TURNO (+) = T_PIANIF.SIGLA_TURNO'
      '            and T606Z.COD_SQUADRA (+) = T_PIANIF.COD_SQUADRA'
      '            and T606Z.COD_TIPOOPE (+) = T_PIANIF.COD_TIPOOPE'
      '          ) T_PIANMINMAX,'
      '          T603_SQUADRE T603'
      '        where T603.CODICE (+) = T_PIANMINMAX.COD_SQUADRA'
      '        ) PIAN,'
      '       (--Dipendenti con assenze'
      '        select ASSR.*'
      
        '        from (select row_number() over (partition by ASSM.PROGRE' +
        'SSIVO order by ASSM.MINUTI desc,DECODE(ASSM.TIPOGIUST_ASS,'#39'I'#39',1,' +
        #39'M'#39',2,3)) RIGA_PROG, ASSM.*'
      
        '              from (select ASSH.*, OREMINUTI(ASSH.ORE) MINUTI, D' +
        'ECODE(ASSH.TIPOGIUST_ASS,'#39'I'#39',NULL,'#39'M'#39',DECODE(ASSH.ORE,'#39'49.59'#39',NU' +
        'LL,ASSH.ORE),ASSH.ORE) DURATA_ASS'
      
        '                    from (select T040.PROGRESSIVO, T040.CAUSALE ' +
        'CAUSALE_ASS, T265.DESCRIZIONE D_CAUSALE_ASS, T040.TIPOGIUST TIPO' +
        'GIUST_ASS,'
      '                           DECODE(T040.TIPOGIUST,'#39'I'#39','#39'99.59'#39','
      
        '                                                 '#39'M'#39',DECODE(T040' +
        '.DAORE,NULL,'#39'49.59'#39',TO_CHAR(T040.DAORE,'#39'HH24.MI'#39')),'
      
        '                                                 '#39'N'#39',TO_CHAR(T04' +
        '0.DAORE,'#39'HH24.MI'#39'),'
      
        '                                                 '#39'D'#39',MINUTIORE((' +
        'T040.AORE-T040.DAORE)*24*60)) ORE'
      
        '                          from T040_GIUSTIFICATIVI T040, T265_CA' +
        'UASSENZE T265'
      '                          where T040.DATA = :DATA'
      '                          and T040.CAUSALE = T265.CODICE'
      '                          ) ASSH'
      '                    ) ASSM'
      '              ) ASSR'
      '        where ASSR.RIGA_PROG = 1 '
      '        ) ASSE'
      '  where T030.PROGRESSIVO = DISP.PROGRESSIVO (+)'
      '  and T030.PROGRESSIVO = PIAN.PROGRESSIVO (+)'
      '  and T030.PROGRESSIVO = ASSE.PROGRESSIVO (+)'
      '  and V430.T430PROGRESSIVO = T030.PROGRESSIVO'
      
        '  and :DATA between V430.T430DATADECORRENZA and V430.T430DATAFIN' +
        'E'
      
        '  and :DATA between V430.T430INIZIO and NVL(V430.T430FINE,:DATA ' +
        '+ 1)'
      '  and V430.T430SQUADRA IS NOT NULL'
      '  and V430.T430TIPOOPE IS NOT NULL'
      '  and :ORARIO IS NOT NULL'
      '  :FILTRO_OBBLIGATORIO'
      '  ) A'
      'order by :ORDERBY')
    Optimize = False
    Variables.Data = {
      040000000C0000000A0000003A0044004100540041000C000000000000000000
      0000100000003A00530051005500410044005200410005000000000000000000
      00000C0000003A00430041004D00500049000100000000000000000000000C00
      00003A00440041004F00520045000500000000000000000000000A0000003A00
      41004F00520045000500000000000000000000000E0000003A004F0052004100
      520049004F00050000000000000000000000160000003A005400410042005F00
      5000490041004E0049004600010000000000000000000000180000003A005000
      52004F0047005200450053005300490056004F00030000000000000000000000
      100000003A0041005A00490045004E0044004100050000000000000000000000
      100000003A0046004C0041004700410047004700050000000000000000000000
      100000003A004F00520044004500520042005900010000000000000000000000
      280000003A00460049004C00540052004F005F004F00420042004C0049004700
      410054004F00520049004F00010000000000000000000000}
    AfterOpen = selSostitutiAfterOpen
    AfterScroll = selSostitutiAfterScroll
    Left = 288
    Top = 304
  end
  object dsrSostituti: TDataSource
    AutoEdit = False
    DataSet = selSostituti
    Left = 344
    Top = 304
  end
  object scrT630: TOracleQuery
    SQL.Strings = (
      'begin'
      '  delete T630_SPOSTSQUADRA'
      '  where PROGRESSIVO = :PROGRESSIVO'
      '  and DATA = :DATA;'
      '  insert into T630_SPOSTSQUADRA'
      '  (PROGRESSIVO, DATA, SQUADRA, ORARIO, COD_TIPOOPE)'
      '  values (:PROGRESSIVO, :DATA, :SQUADRA, :ORARIO,:COD_TIPOOPE);'
      'end;')
    Optimize = False
    Variables.Data = {
      0400000005000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000100000003A0053005100550041004400520041000500
      000000000000000000000E0000003A004F0052004100520049004F0005000000
      0000000000000000180000003A0043004F0044005F005400490050004F004F00
      50004500050000000000000000000000}
    Left = 400
    Top = 304
  end
  object selT630: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT SQUADRA, COD_TIPOOPE, ORARIO'
      '  FROM T630_SPOSTSQUADRA'
      ' WHERE PROGRESSIVO = :PROGRESSIVO'
      '   AND DATA = :DATA')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 510
    Top = 210
  end
  object selT430B: TOracleDataSet
    SQL.Strings = (
      'SELECT :CAMPO CAMPO, COUNT(*) CONTA'
      '  FROM V430_STORICO '
      ' WHERE :DATA BETWEEN T430DATADECORRENZA AND T430DATAFINE'
      '   AND :CAMPO IS NOT NULL'
      '   AND T430PROGRESSIVO IN (:FILTRO)'
      ' GROUP BY :CAMPO'
      ' ORDER BY CONTA DESC')
    Optimize = False
    Variables.Data = {
      04000000030000000E0000003A00460049004C00540052004F00010000000000
      0000000000000C0000003A00430041004D0050004F0001000000000000000000
      00000A0000003A0044004100540041000C0000000000000000000000}
    Left = 619
    Top = 112
  end
end
