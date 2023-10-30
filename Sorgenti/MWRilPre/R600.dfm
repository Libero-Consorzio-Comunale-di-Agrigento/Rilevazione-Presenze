object R600DtM1: TR600DtM1
  OldCreateOrder = True
  Height = 732
  Width = 1008
  object DFruizione: TDataSource
    AutoEdit = False
    DataSet = CausFruizione
    Left = 317
    Top = 12
  end
  object RiposiEsistenti: TOracleDataSet
    SQL.Strings = (
      'select sum(CONTA),max(CAUSALE) from'
      '('
      'select /*SIHINT10 INDEX(T040_GIUSTIFICATIVI T040_PK)*/'
      '       '#39'T040'#39' T, count(*) CONTA, max(T040.CAUSALE) CAUSALE'
      
        'from   T040_GIUSTIFICATIVI T040, T265_CAUASSENZE T265, T260_RAGG' +
        'RASSENZE T260'
      'where  T040.PROGRESSIVO = :PROGRESSIVO'
      'and    T040.DATA = :DATA'
      'and    T040.TIPOGIUST = :TIPOGIUST'
      'and    T040.CAUSALE = T265.CODICE'
      'and    T260.CODICE = T265.CODRAGGR'
      'and    T260.CODINTERNO not in (:CODINTERNO,:RIPOSOCOMP)'
      'and    T265.FRUIZGG_NEUTRA not in (:FRUIZGG_NEUTRA)'
      
        '--and    exists (select '#39'X'#39' from dual where T050F_REVOCATA(T040.' +
        'ID_RICHIESTA) = '#39'N'#39')'
      
        'and    exists (select '#39'X'#39' from dual where T050F_CANCELLATA(T040.' +
        'ID_RICHIESTA,:DATA) = '#39'N'#39')'
      'union all'
      
        'select /*SIHINT10 INDEX(T050_RICHIESTEASSENZA T050_BMI_ELABORATO' +
        ')*/'
      '       '#39'T050'#39', count(*), max(VT050.CAUSALE) '
      
        'from   VT050_RICHIESTE_SENZAREVOCA VT050, T265_CAUASSENZE T265, ' +
        'T260_RAGGRASSENZE T260 '
      'where  VT050.PROGRESSIVO = :PROGRESSIVO'
      'and    :DATA between VT050.DAL and VT050.AL'
      'and    VT050.ELABORATO = '#39'N'#39
      'and    VT050.TIPOGIUST = :TIPOGIUST'
      'and    VT050.CAUSALE = T265.CODICE'
      'and    T260.CODICE = T265.CODRAGGR'
      'and    T260.CODINTERNO not in (:CODINTERNO,:RIPOSOCOMP)'
      'and    T265.FRUIZGG_NEUTRA not in (:FRUIZGG_NEUTRA)'
      
        'and    exists (select '#39'X'#39' from dual where nvl(T050F_AUTORIZZATA(' +
        'VT050.ID),'#39'N'#39') = '#39'S'#39')'
      
        'and    exists (select '#39'X'#39' from dual where T050F_CANCELLATA(VT050' +
        '.ID,:DATA) = '#39'N'#39')'
      'and    :RichiesteIterAutorizzativo = '#39'S'#39
      ')')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000007000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000160000003A0043004F00440049004E00540045005200
      4E004F00050000000000000000000000160000003A005200490050004F005300
      4F0043004F004D005000050000000000000000000000140000003A0054004900
      50004F0047004900550053005400050000000000000000000000360000003A00
      5200490043004800490045005300540045004900540045005200410055005400
      4F00520049005A005A0041005400490056004F00050000000000000000000000
      1E0000003A0046005200550049005A00470047005F004E004500550054005200
      4100050000000000000000000000}
    Left = 32
    Top = 12
  end
  object CausaleRiposo: TOracleDataSet
    SQL.Strings = (
      'SELECT T260.CODINTERNO FROM T265_CAUASSENZE T265,'
      'T260_RAGGRASSENZE T260'
      'WHERE'
      'T265.CODICE = :CODICE AND'
      'T260.CODICE = T265.CODRAGGR')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 126
    Top = 12
  end
  object CausFruizione: TOracleDataSet
    SQL.Strings = (
      'SELECT /*+ INDEX(T040_GIUSTIFICATIVI T040_PK)*/'
      'DATA FROM'
      'T040_GIUSTIFICATIVI '
      'WHERE'
      'PROGRESSIVO = :PROGRESSIVO AND'
      'DATA < :DATA AND'
      'CAUSALE = :CAUSALE AND'
      '--(DATANAS IS NULL OR DATANAS = :DATANAS)'
      '(:DATANAS IS NULL OR DATANAS = :DATANAS)'
      'ORDER BY DATA DESC')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000100000003A00430041005500530041004C0045000500
      00000000000000000000100000003A0044004100540041004E00410053000C00
      00000000000000000000}
    Left = 254
    Top = 12
  end
  object AssenzeCollettive: TOracleDataSet
    ReadBuffer = 1000
    Optimize = False
    Left = 124
    Top = 60
  end
  object QuantAssenze: TOracleDataSet
    SQL.Strings = (
      'SELECT /*+ INDEX(T040_GIUSTIFICATIVI T040_DATANAS)*/'
      'DATA,CAUSALE,PROGRCAUSALE,TIPOGIUST,DAORE,AORE FROM'
      'T040_GIUSTIFICATIVI T040'
      'WHERE'
      'PROGRESSIVO = :PROGRESSIVO AND'
      'DATA BETWEEN :DATA1 AND :DATA2 AND'
      'CAUSALE = :CAUSALE'
      'ORDER BY DATA,CAUSALE,PROGRCAUSALE')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {
      04000000040000000C0000003A00440041005400410031000C00000000000000
      000000000C0000003A00440041005400410032000C0000000000000000000000
      180000003A00500052004F0047005200450053005300490056004F0003000000
      0000000000000000100000003A00430041005500530041004C00450005000000
      0000000000000000}
    Left = 352
    Top = 108
  end
  object Q040: TOracleDataSet
    SQL.Strings = (
      'SELECT /*+ INDEX(T040_GIUSTIFICATIVI T040_PK)*/'
      'COUNT(*)'
      'FROM T040_GIUSTIFICATIVI WHERE '
      'PROGRESSIVO = :PROGRESSIVO AND'
      'DATA = :DATA')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 28
    Top = 156
  end
  object Q080: TOracleDataSet
    SQL.Strings = (
      'SELECT TURNO1, TURNO2'
      'FROM T080_PIANIFORARI WHERE '
      'PROGRESSIVO = :PROGRESSIVO AND'
      'DATA = :DATA')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 64
    Top = 156
  end
  object Q100: TOracleDataSet
    SQL.Strings = (
      'SELECT ORA,VERSO,CAUSALE FROM T100_TIMBRATURE WHERE '
      'PROGRESSIVO = :PROGRESSIVO AND'
      'DATA = :DATA AND'
      'FLAG IN ('#39'O'#39','#39'I'#39')'
      'ORDER BY ORA')
    ReadBuffer = 8
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 100
    Top = 156
  end
  object Q262: TOracleDataSet
    SQL.Strings = (
      'SELECT UMISURA, COMPETENZA1, COMPETENZA2, COMPETENZA3, '
      '                COMPETENZA4, COMPETENZA5, COMPETENZA6,'
      
        '                RETRIBUZIONE1, RETRIBUZIONE2, RETRIBUZIONE3, RET' +
        'RIBUZIONE4,'
      
        '                RETRIBUZIONE5, RETRIBUZIONE6, PROPGGMM, FRUIZ_AN' +
        'NO_MINIMA, FRUIZ_MINIMA_DAL, COMPETENZE_PERSONALIZZATE '
      'FROM T262_PROFASSANN'
      'WHERE '
      'CODPROFILO = :CODPROFILO AND'
      'ANNO = :ANNO AND'
      'CODRAGGR = :CODRAGGR')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000003000000160000003A0043004F004400500052004F00460049004C00
      4F000500000000000000000000000A0000003A0041004E004E004F0003000000
      0000000000000000120000003A0043004F004400520041004700470052000500
      00000000000000000000}
    Left = 208
    Top = 156
  end
  object Q262B: TOracleDataSet
    SQL.Strings = (
      
        'SELECT UMISURA,MG,ARRFAV,NVL(ARR_COMPETENZA_IN_ORE,'#39'00.00'#39') ARR_' +
        'COMPETENZA_IN_ORE,DATARES,DESCRIZIONE,FRUIZ_ANNO_MINIMA,FRUIZ_MI' +
        'NIMA_DAL'
      'FROM T262_PROFASSANN T262, T261_DESCPROFASS T261'
      'WHERE '
      'CODPROFILO = CODICE AND'
      'CODPROFILO = :CODPROFILO AND'
      'ANNO = :ANNO AND'
      'CODRAGGR = :CODRAGGR')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000003000000160000003A0043004F004400500052004F00460049004C00
      4F000500000000000000000000000A0000003A0041004E004E004F0003000000
      0000000000000000120000003A0043004F004400520041004700470052000500
      00000000000000000000}
    Left = 244
    Top = 156
  end
  object Q262C: TOracleDataSet
    SQL.Strings = (
      'SELECT '
      '  *'
      '  --PROPORZIONE,SOMMA '
      'FROM T262_PROFASSANN'
      'WHERE '
      'CODPROFILO = :CODPROFILO AND'
      'ANNO = :ANNO AND'
      'CODRAGGR = :CODRAGGR')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000003000000160000003A0043004F004400500052004F00460049004C00
      4F000500000000000000000000000A0000003A0041004E004E004F0003000000
      0000000000000000120000003A0043004F004400520041004700470052000500
      00000000000000000000}
    Left = 280
    Top = 156
  end
  object Q263: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T263.UMISURA, T263.DATARES, T263.COMPETENZA1, T263.COMPET' +
        'ENZA2, T263.COMPETENZA3, '
      
        '       T263.COMPETENZA4, T263.COMPETENZA5, T263.COMPETENZA6, T26' +
        '3.RETRIBUZIONE1, '
      
        '       T263.RETRIBUZIONE2, T263.RETRIBUZIONE3, T263.RETRIBUZIONE' +
        '4, T263.RETRIBUZIONE5, '
      
        '       T263.RETRIBUZIONE6, T263.DECURTAZIONE, T263.FAMILIARE_DAT' +
        'ANAS'
      '  FROM T263_PROFASSIND T263'
      ' WHERE T263.PROGRESSIVO = :PROGRESSIVO '
      '   AND T263.DAL <= :ININIZIO'
      '   AND T263.AL >= :INFINE'
      '   AND T263.CODRAGGR = :CODRAGGR'
      '/*'
      'SELECT UMISURA, DATARES,COMPETENZA1, COMPETENZA2, COMPETENZA3, '
      '               COMPETENZA4, COMPETENZA5, COMPETENZA6,'
      
        '               RETRIBUZIONE1, RETRIBUZIONE2, RETRIBUZIONE3, RETR' +
        'IBUZIONE4,'
      '               RETRIBUZIONE5, RETRIBUZIONE6,DECURTAZIONE'
      'FROM T263_PROFASSIND  '
      'WHERE '
      'PROGRESSIVO = :PROGRESSIVO AND'
      'ANNO = :ANNO AND'
      'CODRAGGR = :CODRAGGR*/'
      '')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000120000003A0043004F00440052004100
      470047005200050000000000000000000000120000003A0049004E0049004E00
      49005A0049004F000C00000000000000000000000E0000003A0049004E004600
      49004E0045000C0000000000000000000000}
    Left = 364
    Top = 156
  end
  object Q264: TOracleDataSet
    SQL.Strings = (
      
        'SELECT RESIDUO1,RESIDUO2,RESIDUO3,RESIDUO4,RESIDUO5,RESIDUO6,FRU' +
        'IZCOMPPREC_CUMULO_T'
      'FROM T264_RESIDASSANN WHERE'
      'PROGRESSIVO = :PROGRESSIVO AND'
      'ANNO = :ANNO AND'
      'CODRAGGR = :CODRAGGR')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0041004E004E004F000300
      00000000000000000000120000003A0043004F00440052004100470047005200
      050000000000000000000000}
    Left = 400
    Top = 156
  end
  object GiustifDaOre: TOracleDataSet
    SQL.Strings = (
      'select /*SIHINT10 INDEX(T040_GIUSTIFICATIVI T040_PK)*/'
      '       '#39'T040'#39',T040.DAORE,T040.AORE,T040.CAUSALE '
      'from   T040_GIUSTIFICATIVI T040 '
      'where  T040.PROGRESSIVO = :PROGRESSIVO '
      'and    T040.DATA = :DATA'
      'and    T040.TIPOGIUST = '#39'D'#39
      
        '--and    exists (select '#39'X'#39' from dual where T050F_REVOCATA(T040.' +
        'ID_RICHIESTA) = '#39'N'#39')'
      
        'and    exists (select '#39'X'#39' from dual where T050F_CANCELLATA(T040.' +
        'ID_RICHIESTA,:DATA) = '#39'N'#39')'
      'union all'
      
        'select /*SIHINT10 INDEX(T050_RICHIESTEASSENZA T050_BMI_ELABORATO' +
        ')*/'
      
        '       '#39'T050'#39',to_date('#39'30121899'#39'||NUMEROORE,'#39'ddmmyyyyhh24.mi'#39'),t' +
        'o_date('#39'30121899'#39'||AORE,'#39'ddmmyyyyhh24.mi'#39'),VT050.CAUSALE '
      'from   VT050_RICHIESTE_SENZAREVOCA VT050'
      'where  VT050.PROGRESSIVO = :PROGRESSIVO'
      'and    :DATA between VT050.DAL and VT050.AL'
      'and    VT050.ELABORATO = '#39'N'#39
      'and    VT050.TIPOGIUST = '#39'D'#39
      
        'and    exists (select '#39'X'#39' from dual where nvl(T050F_AUTORIZZATA(' +
        'VT050.ID),'#39'N'#39') = '#39'S'#39')'
      
        'and    exists (select '#39'X'#39' from dual where T050F_CANCELLATA(VT050' +
        '.ID,:DATA) = '#39'N'#39')'
      'and    :RichiesteIterAutorizzativo = '#39'S'#39)
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000360000003A0052004900430048004900450053005400
      450049005400450052004100550054004F00520049005A005A00410054004900
      56004F00050000000000000000000000}
    Left = 204
    Top = 60
  end
  object Q130: TOracleDataSet
    SQL.Strings = (
      'SELECT SALDOORELAV FROM T130_RESIDANNOPREC'
      'WHERE ANNO = :ANNO AND PROGRESSIVO = :PROGRESSIVO')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A0041004E004E004F0003000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      00000000000000000000}
    Left = 172
    Top = 156
  end
  object QAnagra: TOracleDataSet
    SQL.Strings = (
      
        'SELECT COGNOME,NOME,MATRICOLA,INIZIOSERVIZIO,MIN(INIZIO) MIN_INI' +
        'ZIO'
      'FROM T030_ANAGRAFICO T030,T430_STORICO T430'
      'WHERE '
      'T030.PROGRESSIVO = :PROGRESSIVO AND '
      'T030.PROGRESSIVO = T430.PROGRESSIVO(+) AND '
      'T030.INIZIOSERVIZIO < T430.INIZIO(+)'
      'GROUP BY COGNOME,NOME,MATRICOLA,INIZIOSERVIZIO')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F0003000000040000000400000000000000}
    Left = 344
    Top = 60
  end
  object Q430: TOracleDataSet
    SQL.Strings = (
      
        'SELECT INIZIO,FINE,DATADECORRENZA,DATAFINE,PASSENZE,ABCAUSALE1,P' +
        'ARTTIME '
      'FROM T430_STORICO'
      'WHERE PROGRESSIVO = :PROGRESSIVO AND'
      'DATAFINE >= :DATA1 AND DATADECORRENZA <= :DATA2'
      'ORDER BY DATADECORRENZA')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 472
    Top = 156
  end
  object Q430Ragg: TOracleDataSet
    SQL.Strings = (
      'SELECT COGNOME,NOME,BADGE,ORARIO,CALENDARIO,INIZIOSERVIZIO'
      'FROM T030_ANAGRAFICO T030, T430_STORICO T430'
      'WHERE '
      'T030.PROGRESSIVO = :PROGRESSIVO AND'
      'T030.PROGRESSIVO = T430.PROGRESSIVO AND'
      'DATADECORRENZA <= :DATA AND'
      'DATAFINE >= :DATA')
    ReadBuffer = 2
    Optimize = False
    Left = 516
    Top = 156
  end
  object NonMaturaFerie: TOracleDataSet
    SQL.Strings = (
      'select /*SIHINT10 INDEX(T040_GIUSTIFICATIVI T040_PK)*/'
      
        '       '#39'T040'#39',T040.DATA, decode(T040.TIPOGIUST,'#39'I'#39',1,'#39'M'#39',0.5,0) ' +
        'QUANTITA'
      'from   T040_GIUSTIFICATIVI T040, T265_CAUASSENZE T265'
      'where  T040.PROGRESSIVO = :PROGRESSIVO '
      'and    T040.DATA BETWEEN :DATA1 and :DATA2 '
      'and    T040.CAUSALE = T265.CODICE '
      'and    T265.MATURFERIE = '#39'N'#39' '
      'and    T040.TIPOGIUST in ('#39'I'#39','#39'M'#39')'
      
        '--and    exists (select '#39'X'#39' from dual where T050F_REVOCATA(T040.' +
        'ID_RICHIESTA) = '#39'N'#39')'
      
        'and    exists (select '#39'X'#39' from dual where T050F_CANCELLATA(T040.' +
        'ID_RICHIESTA,T040.DATA) = '#39'N'#39')'
      'union all'
      
        'select /*SIHINT10 INDEX(T050_RICHIESTEASSENZA T050_BMI_ELABORATO' +
        ')*/'
      
        '       '#39'T050'#39', V010.DATA, decode(VT050.TIPOGIUST,'#39'I'#39',1,'#39'M'#39',0.5,0' +
        ') QUANTITA'
      
        'from   VT050_RICHIESTE_SENZAREVOCA VT050, T265_CAUASSENZE T265, ' +
        'V010_CALENDARI V010'
      'where  VT050.PROGRESSIVO = :PROGRESSIVO'
      'and    :DATA1 <= VT050.AL'
      'and    :DATA2 >= VT050.DAL'
      'and    VT050.ELABORATO = '#39'N'#39
      'and    VT050.TIPOGIUST in ('#39'I'#39','#39'M'#39')'
      'and    VT050.CAUSALE = T265.CODICE '
      'and    T265.MATURFERIE = '#39'N'#39' '
      'and    V010.PROGRESSIVO = :PROGRESSIVO'
      
        'and    V010.DATA between greatest(VT050.DAL,:DATA1) and least(VT' +
        '050.AL,:DATA2)'
      
        'and    exists (select '#39'X'#39' from dual where nvl(T050F_AUTORIZZATA(' +
        'VT050.ID),'#39'N'#39') = '#39'S'#39')'
      
        'and    exists (select '#39'X'#39' from dual where T050F_CANCELLATA(VT050' +
        '.ID,V010.DATA) = '#39'N'#39')'
      'and    :RichiesteIterAutorizzativo = '#39'S'#39
      'order by DATA')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000360000003A00520049004300480049004500530054004500
      49005400450052004100550054004F00520049005A005A004100540049005600
      4F00050000000000000000000000}
    Left = 892
    Top = 156
  end
  object NumRiposi: TOracleDataSet
    SQL.Strings = (
      'select sum(CONTA) from'
      '('
      'select /*SIHINT10 INDEX(T040_GIUSTIFICATIVI T040_PK)*/'
      '       '#39'T040'#39' T, count(*) CONTA'
      
        'from   T040_GIUSTIFICATIVI T040, T265_CAUASSENZE T265, T260_RAGG' +
        'RASSENZE T260'
      'where  T040.PROGRESSIVO = :PROGRESSIVO'
      'and    T040.DATA = :DATA'
      'and    T040.TIPOGIUST = '#39'I'#39
      'and    T040.CAUSALE = T265.CODICE'
      'and    T260.CODICE = T265.CODRAGGR'
      'and    T260.CODINTERNO = :CODINTERNO'
      
        '--and    exists (select '#39'X'#39' from dual where T050F_REVOCATA(T040.' +
        'ID_RICHIESTA) = '#39'N'#39')'
      
        'and    exists (select '#39'X'#39' from dual where T050F_CANCELLATA(T040.' +
        'ID_RICHIESTA,:DATA) = '#39'N'#39')'
      'union all'
      
        'select /*SIHINT10 INDEX(T050_RICHIESTEASSENZA T050_BMI_ELABORATO' +
        ')*/'
      '       '#39'T050'#39', count(*) '
      
        'from   VT050_RICHIESTE_SENZAREVOCA VT050, T265_CAUASSENZE T265, ' +
        'T260_RAGGRASSENZE T260 '
      'where  VT050.PROGRESSIVO = :PROGRESSIVO'
      'and    :DATA between VT050.DAL and VT050.AL'
      'and    VT050.ELABORATO = '#39'N'#39
      'and    VT050.TIPOGIUST = '#39'I'#39
      'and    VT050.CAUSALE = T265.CODICE'
      'and    T260.CODICE = T265.CODRAGGR'
      'and    T260.CODINTERNO = :CODINTERNO'
      
        'and    exists (select '#39'X'#39' from dual where nvl(T050F_AUTORIZZATA(' +
        'VT050.ID),'#39'N'#39') = '#39'S'#39')'
      
        'and    exists (select '#39'X'#39' from dual where T050F_CANCELLATA(VT050' +
        '.ID,:DATA) = '#39'N'#39')'
      'and    :RichiesteIterAutorizzativo = '#39'S'#39
      ')')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000160000003A0043004F00440049004E00540045005200
      4E004F00050000000000000000000000360000003A0052004900430048004900
      450053005400450049005400450052004100550054004F00520049005A005A00
      41005400490056004F00050000000000000000000000}
    Left = 190
    Top = 12
  end
  object GetInizioAssenza: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      '  GETINIZIOASSENZA(:PROG, :D, :CAUS, :DI, :BDATA);'
      'END;')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000005000000060000003A00440049000C00000000000000000000000A00
      00003A00500052004F004700030000000000000000000000040000003A004400
      0C00000000000000000000000A0000003A004300410055005300050000000000
      0000000000000C0000003A004200440041005400410005000000000000000000
      0000}
    Left = 32
    Top = 108
  end
  object GetCalend: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      '  GETCALENDARIO(:PROG, :D, :F, :L, :G, :MONTEORE);'
      'END;')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      04000000060000000A0000003A00500052004F00470003000000000000000000
      0000040000003A0044000C0000000000000000000000040000003A0046000500
      00000000000000000000040000003A004C000500000000000000000000000400
      00003A004700030000000000000000000000120000003A004D004F004E005400
      45004F0052004500050000000000000000000000}
    Left = 104
    Top = 108
  end
  object GetUMisura: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      '  GETUMISURAASSENZA (:PROG, :D, :CAUSALE, :UM);'
      'END;')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A00500052004F00470003000000000000000000
      0000040000003A0044000C0000000000000000000000100000003A0043004100
      5500530041004C004500050000000000000000000000060000003A0055004D00
      050000000000000000000000}
    Left = 164
    Top = 108
  end
  object Q265: TOracleDataSet
    SQL.Strings = (
      'SELECT T265.*,'
      '       OreMinuti(T265.FRUIZ_MIN) FRUIZ_MIN_MINUTI, '
      '       OreMinuti(nvl(T265.FRUIZ_MAX,'#39'24.00'#39')) FRUIZ_MAX_MINUTI, '
      '       OreMinuti(T265.FRUIZ_ARR) FRUIZ_ARR_MINUTI,'
      '       OreMinuti(T265.FRUIZ_MIN_COMP) FRUIZ_MIN_COMP_MINUTI,'
      '       T260.CODINTERNO,T260.CONTASOLARE,T260.RESIDUABILE'
      'FROM T265_CAUASSENZE T265, T260_RAGGRASSENZE T260'
      'WHERE T265.CODRAGGR = T260.CODICE       '
      'ORDER BY T265.CODICE')
    ReadBuffer = 100
    Optimize = False
    Left = 436
    Top = 156
  end
  object selMinDataDecorrenza: TOracleQuery
    SQL.Strings = (
      
        'SELECT MIN(DATADECORRENZA) FROM T430_STORICO WHERE PROGRESSIVO =' +
        ' :PROGRESSIVO')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Left = 252
    Top = 108
  end
  object selPartTime: TOracleDataSet
    SQL.Strings = (
      'select '
      
        '  datadecorrenza,datafine,inizio,fine,t460.tipo,t460.assenzegg,t' +
        '460.assenzehh,'
      
        '  decode(nvl(tipo,'#39'xx'#39'),'#39'V'#39',round(100/7*(decode(t010.lunedi,'#39'S'#39',' +
        '1,0)+decode(t010.martedi,'#39'S'#39',1,0)+decode(t010.mercoledi,'#39'S'#39',1,0)' +
        '+decode(t010.giovedi,'#39'S'#39',1,0)+decode(t010.venerdi,'#39'S'#39',1,0)+decod' +
        'e(t010.sabato,'#39'S'#39',1,0)+decode(t010.domenica,'#39'S'#39',1,0)),2),nvl(t46' +
        '0.assenzegg,100)) assenzeg7,'
      
        '  decode(nvl(tipo,'#39'xx'#39'),'#39'V'#39',round(100/5*(decode(t010.lunedi,'#39'S'#39',' +
        '1,0)+decode(t010.martedi,'#39'S'#39',1,0)+decode(t010.mercoledi,'#39'S'#39',1,0)' +
        '+decode(t010.giovedi,'#39'S'#39',1,0)+decode(t010.venerdi,'#39'S'#39',1,0)+decod' +
        'e(t010.sabato,'#39'S'#39',1,0)+decode(t010.domenica,'#39'S'#39',1,0)),2),nvl(t46' +
        '0.assenzegg,100)) assenzeg5,'
      
        '  decode(t010.lunedi,'#39'S'#39',1,0)+decode(t010.martedi,'#39'S'#39',1,0)+decod' +
        'e(t010.mercoledi,'#39'S'#39',1,0)+decode(t010.giovedi,'#39'S'#39',1,0)+decode(t0' +
        '10.venerdi,'#39'S'#39',1,0)+decode(t010.sabato,'#39'S'#39',1,0)+decode(t010.dome' +
        'nica,'#39'S'#39',1,0) num_gglav'
      
        'from t430_storico t430, t460_parttime t460, t010_calendimpostaz ' +
        't010'
      'where '
      't430.parttime = t460.codice(+) and'
      'progressivo = :progressivo and'
      'datadecorrenza <= :fine and datafine >= :inizio'
      'and t430.calendario = t010.codice'
      'order by datadecorrenza')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A0049004E0049005A004900
      4F000C00000000000000000000000A0000003A00460049004E0045000C000000
      0000000000000000}
    Left = 400
    Top = 60
  end
  object GetGiorniServizio: TOracleQuery
    SQL.Strings = (
      'begin'
      
        '  GetGiorniServizio(:Prog,:InizioCumulo,:FineCumulo,:Raggrup,:GS' +
        ',:TR);'
      'end;')
    Optimize = False
    Variables.Data = {
      04000000060000000A0000003A00500052004F00470003000000000000000000
      00001A0000003A0049004E0049005A0049004F00430055004D0055004C004F00
      0C0000000000000000000000160000003A00460049004E004500430055004D00
      55004C004F000C0000000000000000000000060000003A004700530003000000
      0000000000000000060000003A00540052000500000000000000000000001000
      00003A005200410047004700520055005000050000000000000000000000}
    Left = 472
    Top = 60
  end
  object selSG101: TOracleDataSet
    SQL.Strings = (
      
        'SELECT DISTINCT NVL(DATAADOZ,DATANAS) DATA,COGNOME || '#39' '#39' || NOM' +
        'E NOME, '
      
        '       NUMORD--'#39'<'#39'||replace(CAUSALI_ABILITATE,'#39','#39','#39'>,<'#39')||'#39'>'#39' CA' +
        'USALI_ABILITATE'
      'FROM SG101_FAMILIARI'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      '--AND GRADOPAR = '#39'FG'#39
      'ORDER BY 1,2')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Filtered = True
    Left = 508
    Top = 12
  end
  object QuantAssenzeDataNas: TOracleDataSet
    SQL.Strings = (
      'SELECT /*+ INDEX(T040_GIUSTIFICATIVI T040_DATANAS)*/'
      'DATA,CAUSALE,PROGRCAUSALE,TIPOGIUST,DAORE,AORE FROM'
      'T040_GIUSTIFICATIVI T040'
      'WHERE'
      'PROGRESSIVO = :PROGRESSIVO AND'
      'DATA BETWEEN :DATA1 AND :DATA2 AND'
      'CAUSALE = :CAUSALE AND'
      'DATANAS = :DATANAS'
      'ORDER BY DATA,CAUSALE,PROGRCAUSALE')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      04000000050000000C0000003A00440041005400410031000C00000000000000
      000000000C0000003A00440041005400410032000C0000000000000000000000
      180000003A00500052004F0047005200450053005300490056004F0003000000
      0000000000000000100000003A00430041005500530041004C00450005000000
      0000000000000000100000003A0044004100540041004E00410053000C000000
      0000000000000000}
    Left = 448
    Top = 108
  end
  object selT040DataNas: TOracleDataSet
    SQL.Strings = (
      'select nvl(SG101.DATAADOZ,SG101.DATANAS) DATANAS'
      'from   SG101_FAMILIARI SG101'
      'where  SG101.PROGRESSIVO = :PROGRESSIVO'
      'and    :DATA2 >= SG101.DECORRENZA '
      'and    :DATA1 <= SG101.DECORRENZA_FINE'
      
        'and    INTERSEZ_LISTE(SG101.CAUSALI_ABILITATE,:CAUSALE) = :CAUSA' +
        'LE'
      ''
      'union'
      ''
      'select /*+ INDEX(T040_GIUSTIFICATIVI T040_DATANAS)*/'
      '       T040.DATANAS '
      'from   T040_GIUSTIFICATIVI T040, '
      '       T265_CAUASSENZE T265, '
      
        '       (select CODRAGGR, CODCAU1 from T265_CAUASSENZE where CODI' +
        'CE = :CAUSALE) T265B,'
      '       SG101_FAMILIARI SG101'
      'where  T040.PROGRESSIVO = :PROGRESSIVO'
      'and    T040.CAUSALE = T265.CODICE'
      'and    T040.DATA between :DATA1 and :DATA2'
      'and    T040.DATANAS is not null'
      'and    (T265.CODRAGGR = T265B.CODRAGGR'
      '        or '
      
        '        instr('#39','#39' || T265B.CODCAU1 ||'#39','#39'||T265F_GETCATENACOMPLET' +
        'A(:CAUSALE,'#39'T'#39') || '#39','#39','#39','#39' || T040.CAUSALE || '#39','#39') > 0)'
      'and    SG101.PROGRESSIVO = :PROGRESSIVO'
      'and    nvl(SG101.DATAADOZ,SG101.DATANAS) = T040.DATANAS'
      'and    :DATA2 between SG101.DECORRENZA and SG101.DECORRENZA_FINE'
      'and    SG101.CAUSALI_ABILITATE = '#39'*'#39
      '')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A0043004100550053004100
      4C0045000500000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    Left = 444
    Top = 12
  end
  object selGGnonLav: TOracleQuery
    SQL.Strings = (
      
        'SELECT SUM(DOMENICHE) DOMENICHE, SUM(NOLAVNOFEST), SUM(NOLAVSIFE' +
        'ST), SUM(SILAVSIFEST) FROM ('
      '  SELECT SUM(DECODE(TO_CHAR(DATA,'#39'D'#39'),1,1,0)) DOMENICHE,'
      
        '         SUM(DECODE(TO_CHAR(DATA,'#39'D'#39'),1,0,DECODE(LAVORATIVO,'#39'N'#39',' +
        'DECODE(FESTIVO,'#39'S'#39',0,1),0) ) ) NOLAVNOFEST,'
      
        '         SUM(DECODE(TO_CHAR(DATA,'#39'D'#39'),1,0,DECODE(LAVORATIVO,'#39'N'#39',' +
        'DECODE(FESTIVO,'#39'S'#39',1,0),0) ) ) NOLAVSIFEST,'
      
        '         SUM(DECODE(TO_CHAR(DATA,'#39'D'#39'),1,0,DECODE(LAVORATIVO,'#39'N'#39',' +
        '0,DECODE(FESTIVO,'#39'S'#39',1,0)) ) ) SILAVSIFEST'
      '  '
      '  FROM T011_CALENDARI T011,T430_STORICO T430 '
      '  WHERE '
      '  PROGRESSIVO = :PROGRESSIVO AND '
      '  CODICE = CALENDARIO AND'
      '  DATA BETWEEN DATADECORRENZA AND DATAFINE AND'
      '  DATA BETWEEN :DADATA AND :ADATA AND '
      '  (LAVORATIVO = '#39'N'#39' OR FESTIVO = '#39'S'#39') AND'
      
        '  EXISTS (SELECT '#39'X'#39' FROM T430_STORICO WHERE PROGRESSIVO = :PROG' +
        'RESSIVO AND T011.DATA BETWEEN INIZIO AND NVL(FINE,T011.DATA)) AN' +
        'D'
      '  NOT EXISTS (SELECT '#39'X'#39' FROM T012_CALENDINDIVID '
      '              WHERE'
      '              PROGRESSIVO = :PROGRESSIVO AND DATA = T011.DATA)'
      '  UNION ALL'
      '  SELECT SUM(DECODE(TO_CHAR(DATA,'#39'D'#39'),1,1,0)) DOMENICHE,'
      
        '         SUM(DECODE(TO_CHAR(DATA,'#39'D'#39'),1,0,DECODE(LAVORATIVO,'#39'N'#39',' +
        'DECODE(FESTIVO,'#39'S'#39',0,1),0) ) ) NOLAVNOFEST,'
      
        '         SUM(DECODE(TO_CHAR(DATA,'#39'D'#39'),1,0,DECODE(LAVORATIVO,'#39'N'#39',' +
        'DECODE(FESTIVO,'#39'S'#39',1,0),0) ) ) NOLAVSIFEST,'
      
        '         SUM(DECODE(TO_CHAR(DATA,'#39'D'#39'),1,0,DECODE(LAVORATIVO,'#39'N'#39',' +
        '0,DECODE(FESTIVO,'#39'S'#39',1,0)) ) ) SILAVSIFEST'
      '  FROM T012_CALENDINDIVID T012'
      '  WHERE '
      '  DATA BETWEEN :DADATA AND :ADATA AND '
      '  PROGRESSIVO = :PROGRESSIVO AND'
      '  (LAVORATIVO = '#39'N'#39' OR FESTIVO = '#39'S'#39') AND'
      
        '  EXISTS (SELECT '#39'X'#39' FROM T430_STORICO WHERE PROGRESSIVO = :PROG' +
        'RESSIVO AND T012.DATA BETWEEN INIZIO AND NVL(FINE,T012.DATA))'
      ')'
      '')
    Optimize = False
    Variables.Data = {
      04000000030000000E0000003A004400410044004100540041000C0000000700
      000078650101010101000000000C0000003A00410044004100540041000C0000
      00070000007865071F01010100000000180000003A00500052004F0047005200
      450053005300490056004F0003000000040000000400000000000000}
    Left = 548
    Top = 60
  end
  object GiustifEsistenti: TOracleDataSet
    SQL.Strings = (
      'select sum(CONTA) from'
      '(select /*SIHINT10 INDEX(T040_GIUSTIFICATIVI T040_PK)*/'
      '       '#39'T040'#39' T, count(*) CONTA'
      'from   T040_GIUSTIFICATIVI T040'
      'where  T040.PROGRESSIVO = :PROGRESSIVO'
      'and    T040.DATA = :DATA'
      
        '--and    exists (select '#39'X'#39' from dual where T050F_REVOCATA(T040.' +
        'ID_RICHIESTA) = '#39'N'#39')'
      
        'and    exists (select '#39'X'#39' from dual where T050F_CANCELLATA(T040.' +
        'ID_RICHIESTA,:DATA) = '#39'N'#39')'
      'union all'
      
        'select /*SIHINT10 INDEX(T050_RICHIESTEASSENZA T050_BMI_ELABORATO' +
        ')*/'
      '       '#39'T050'#39', count(*) '
      'from   VT050_RICHIESTE_SENZAREVOCA VT050'
      'where  VT050.PROGRESSIVO = :PROGRESSIVO'
      'and    :DATA between VT050.DAL and VT050.AL'
      'and    VT050.ELABORATO = '#39'N'#39
      
        'and    exists (select '#39'X'#39' from dual where nvl(T050F_AUTORIZZATA(' +
        'VT050.ID),'#39'N'#39') = '#39'S'#39')'
      
        'and    exists (select '#39'X'#39' from dual where T050F_CANCELLATA(VT050' +
        '.ID,:DATA) = '#39'N'#39')'
      'and    :RichiesteIterAutorizzativo = '#39'S'#39
      ')')
    ReadBuffer = 8
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000360000003A0052004900430048004900450053005400
      450049005400450052004100550054004F00520049005A005A00410054004900
      56004F00050000000000000000000000}
    Left = 28
    Top = 208
  end
  object PeriodiAssenza: TOracleQuery
    SQL.Strings = (
      'begin'
      'GENERA_PERIODI_ASSENZA'
      '  (:PROG, :INIZIO, :FINE, :CAUS, :TG, :DALLE, :ALLE, :OPER);'
      'end;')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      04000000080000000A0000003A00500052004F00470003000000000000000000
      00000E0000003A0049004E0049005A0049004F000C0000000000000000000000
      0A0000003A00460049004E0045000C00000000000000000000000A0000003A00
      4300410055005300050000000000000000000000060000003A00540047000500
      000000000000000000000C0000003A00440041004C004C004500050000000000
      0000000000000A0000003A0041004C004C004500050000000000000000000000
      0A0000003A004F00500045005200050000000000000000000000}
    Left = 104
    Top = 208
  end
  object selSG101NumOrd: TOracleDataSet
    SQL.Strings = (
      'select distinct '
      '  nvl(DATAADOZ,DATANAS) DATA,'
      '  NUMORD,GRADOPAR,'
      '  DATAADOZ,DATANAS,COGNOME,NOME'
      'from SG101_FAMILIARI'
      'where PROGRESSIVO = :PROGRESSIVO')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Left = 661
    Top = 12
  end
  object selT131: TOracleDataSet
    SQL.Strings = (
      'select '
      't131.causale,'
      'least('
      '  oreminuti(ore_fascia1) + oreminuti(ore_fascia2) + '
      '  oreminuti(ore_fascia3) + oreminuti(ore_fascia4) + '
      '  oreminuti(ore_fascia5) + oreminuti(ore_fascia6),'
      '  oreminuti(t275.residuabile)'
      ') residuo'
      'from t131_residpresenze t131,t275_caupresenze t275'
      'where '
      '  progressivo = :progressivo and'
      '  anno = :anno and'
      '  t131.causale = t275.codice and'
      '  oreminuti(t275.residuabile) > 0')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0041004E004E004F000300
      00000000000000000000}
    Left = 572
    Top = 156
  end
  object selT262: TOracleDataSet
    SQL.Strings = (
      
        'select NVL(MAX(OREMINUTI(NVL(max_fruizione_giorn_in_ore,'#39'23.59'#39')' +
        ')),1439) MAX_FRUIZIONE_GIORN_IN_ORE '
      
        'from   t430_storico t430, t262_profassann t262, t265_cauassenze ' +
        't265, t260_raggrassenze t260'
      'where  t430.progressivo = :progressivo '
      'and    :datains between datadecorrenza and datafine'
      'and    t430.passenze = t262.codprofilo'
      'and    t262.anno = to_char(:datains,'#39'yyyy'#39') '
      'and    t262.codraggr = t265.codraggr '
      'and    t265.codice = :causale'
      'and    t265.codraggr = t260.codice'
      'and    t260.contasolare = '#39'S'#39)
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A0044004100540041004900
      4E0053000C0000000000000000000000100000003A0043004100550053004100
      4C004500050000000000000000000000}
    Left = 325
    Top = 156
  end
  object ScrBancaOreResidua: TOracleQuery
    SQL.Strings = (
      'declare'
      '  num integer;'
      'begin'
      '  :banca_ore:=0;'
      '  select count(*) into num from t070_schedariepil'
      '    where progressivo = :progressivo and data <= :data;'
      '  if num = 0 then'
      
        '    select oreminuti(banca_ore) into :banca_ore from t130_resida' +
        'nnoprec'
      
        '      where progressivo = :progressivo and anno = to_char(add_mo' +
        'nths(:data,1),'#39'yyyy'#39');'
      '  end if;'
      'exception'
      '  when others then null;'
      'end;')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000003000000140000003A00420041004E00430041005F004F0052004500
      030000000000000000000000180000003A00500052004F004700520045005300
      5300490056004F000300000000000000000000000A0000003A00440041005400
      41000C0000000000000000000000}
    Left = 204
    Top = 208
  end
  object selFestiviInfraSett: TOracleQuery
    SQL.Strings = (
      'SELECT '
      
        '  SUM(decode(:UMISURA,'#39'O'#39',decode(V010.NUMGIORNI,0,0,TRUNC(OREMIN' +
        'UTI(T430.ORARIO)/V010.NUMGIORNI)),'#39'G'#39',1,0)) TOTALE '
      'FROM V010_CALENDARI V010, T430_STORICO T430'
      'WHERE'
      
        '  V010.PROGRESSIVO = :PROGRESSIVO AND V010.DATA BETWEEN :DADATA ' +
        'AND :ADATA AND'
      '  (TO_CHAR(V010.DATA,'#39'd'#39') <> '#39'1'#39' AND V010.FESTIVO = '#39'S'#39') AND'
      
        '  V010.PROGRESSIVO = T430.PROGRESSIVO AND V010.DATA BETWEEN T430' +
        '.DATADECORRENZA AND T430.DATAFINE AND'
      '  NOT EXISTS '
      '  (SELECT '#39'X'#39' FROM T040_GIUSTIFICATIVI T040 WHERE '
      '     PROGRESSIVO = V010.PROGRESSIVO AND '
      
        '     DATA = V010.DATA AND TIPOGIUST = '#39'I'#39' AND CAUSALE NOT IN (:C' +
        'AUSALI)) AND'
      '  EXISTS'
      '  (SELECT '#39'X'#39' FROM T430_STORICO WHERE'
      '   PROGRESSIVO = V010.PROGRESSIVO AND'
      
        '   V010.DATA BETWEEN INIZIO AND NVL(FINE,TO_DATE('#39'31123999'#39','#39'ddm' +
        'myyyy'#39')))')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000005000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A0044004100440041005400
      41000C00000000000000000000000C0000003A00410044004100540041000C00
      00000000000000000000100000003A00430041005500530041004C0049000100
      0000050000004E554C4C0000000000100000003A0055004D0049005300550052
      004100050000000000000000000000}
    Left = 632
    Top = 60
  end
  object QuantAssenzeQualMin: TOracleDataSet
    SQL.Strings = (
      'SELECT '
      
        '  T040.DATA, T040.TIPOGIUST, T040.CAUSALE, T040.PROGRCAUSALE, T0' +
        '40.DAORE, T040.AORE,T470.DEBITOGGQM,'
      
        '  OREMINUTI(T430.ORARIO) ORESETT,NVL(T012.NUMGIORNI,T011.NUMGIOR' +
        'NI) NUMGIORNISETT'
      'FROM '
      
        'T470_QUALIFICAMINIST T470, T011_CALENDARI T011, T012_CALENDINDIV' +
        'ID T012, T040_GIUSTIFICATIVI T040, '
      
        'T265_CAUASSENZE T265, T030_ANAGRAFICO T030, T460_PARTTIME T460, ' +
        'T430_STORICO T430'
      'WHERE '
      'T030.PROGRESSIVO = :PROGRESSIVO'
      'AND T265.CODICE = :CAUSALE'
      'AND T030.PROGRESSIVO = T430.PROGRESSIVO'
      'AND T030.PROGRESSIVO = T040.PROGRESSIVO'
      'AND T470.CODICE = T430.QUALIFICAMINIST'
      'AND T040.DATA BETWEEN T470.DECORRENZA AND T470.DECORRENZA_FINE'
      'AND T460.CODICE(+) = T430.PARTTIME'
      'AND T040.DATA BETWEEN :DATA1 AND :DATA2'
      'AND T040.DATA BETWEEN T430.DATADECORRENZA AND T430.DATAFINE'
      'AND T265.CODICE = T040.CAUSALE'
      'AND T265.RAGGRSTAT <> '#39'Z'#39
      
        'AND EXISTS (SELECT '#39'X'#39' FROM T430_STORICO WHERE PROGRESSIVO = T43' +
        '0.PROGRESSIVO AND T040.DATA BETWEEN INIZIO AND NVL(FINE,TO_DATE(' +
        #39'31123999'#39','#39'DDMMYYYY'#39')))'
      'AND T011.DATA  = T040.DATA'
      'AND T011.CODICE = T430.CALENDARIO'
      'AND T012.PROGRESSIVO(+) = T040.PROGRESSIVO'
      'AND T012.DATA(+) = T040.DATA'
      ':DATANAS'
      
        'AND NVL(T012.FESTIVO,T011.FESTIVO) = '#39'N'#39' AND ((T460.TIPO = '#39'V'#39' A' +
        'ND NVL(T012.LAVORATIVO,T011.LAVORATIVO) = '#39'S'#39') OR  TO_CHAR(NVL(T' +
        '012.DATA,T011.DATA),'#39'd'#39') <> 1)'
      'ORDER BY T040.DATA, T040.CAUSALE, T040.PROGRCAUSALE')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      04000000050000000C0000003A00440041005400410031000C00000000000000
      000000000C0000003A00440041005400410032000C0000000000000000000000
      180000003A00500052004F0047005200450053005300490056004F0003000000
      0000000000000000100000003A00430041005500530041004C00450005000000
      0000000000000000100000003A0044004100540041004E004100530001000000
      0000000000000000}
    Left = 568
    Top = 108
  end
  object selV010: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM V010_CALENDARI V010, T430_STORICO T430'
      'WHERE V010.PROGRESSIVO = :PROGRESSIVO '
      'AND V010.DATA BETWEEN :DADATA AND :ADATA '
      'AND (TO_CHAR(V010.DATA,'#39'd'#39') = '#39'1'#39' OR V010.FESTIVO = '#39'S'#39') '
      'AND V010.PROGRESSIVO = T430.PROGRESSIVO'
      'AND V010.DATA BETWEEN T430.DATADECORRENZA AND T430.DATAFINE'
      
        'AND (:FRUIBILE = '#39'S'#39' OR INTERSEZ_LISTE(:CAUSALE,T430.ABCAUSALE1)' +
        ' = :CAUSALE)'
      'ORDER BY DATA')
    Optimize = False
    Variables.Data = {
      0400000005000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A0044004100440041005400
      41000C00000000000000000000000C0000003A00410044004100540041000C00
      00000000000000000000120000003A004600520055004900420049004C004500
      050000000000000000000000100000003A00430041005500530041004C004500
      050000000000000000000000}
    Left = 304
    Top = 208
  end
  object selT460: TOracleDataSet
    SQL.Strings = (
      'select * from t460_parttime'
      'where codice = :COD')
    Optimize = False
    Variables.Data = {
      0400000001000000080000003A0043004F004400050000000000000000000000}
    Left = 360
    Top = 208
  end
  object selT266: TOracleDataSet
    SQL.Strings = (
      'select T266.*,ROWID from T266_DETTAGLIOCUMULO T266 '
      'where CODICE = :CODICE '
      'order by ID')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    CachedUpdates = True
    Left = 616
    Top = 156
  end
  object cdsPeriodiAssenza: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 480
    Top = 256
  end
  object selPeriodiAssenza: TOracleDataSet
    SQL.Strings = (
      'select t040.*, t265.descrizione'
      'from t040_giustificativi t040, t265_cauassenze t265'
      'where t040.causale = t265.codice'
      '  and t040.progressivo = :prog'
      '  and t040.causale IN (:causale)'
      'order by t040.data')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A00500052004F00470003000000000000000000
      0000100000003A00430041005500530041004C00450001000000000000000000
      0000}
    Left = 480
    Top = 208
  end
  object scrDieciGiorniPrima: TOracleQuery
    SQL.Strings = (
      'begin'
      
        '  L133DieciGiorniPrima(:progressivo, :data, :gsignific, :causper' +
        'iodi, :numgg);'
      'end;')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000005000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      000000000000000000000C0000003A004E0055004D0047004700030000000000
      000000000000180000003A00430041005500530050004500520049004F004400
      4900050000000000000000000000140000003A0047005300490047004E004900
      460049004300050000000000000000000000}
    Left = 40
    Top = 258
  end
  object scrDieciGiorniDopo: TOracleQuery
    SQL.Strings = (
      'begin'
      '  L133DieciGiorniDopo(:progressivo, :data, :ggmodif);'
      'end;')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000100000003A00470047004D004F004400490046000300
      00000000000000000000}
    Left = 136
    Top = 258
  end
  object selT047: TOracleDataSet
    SQL.Strings = (
      'select T047.*, T047.ROWID'
      'from   T047_VISITEFISCALI T047'
      'where  TIPO_EVENTO = '#39'__'#39
      'and PROGRESSIVO = -1')
    Optimize = False
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
    Left = 26
    Top = 316
  end
  object selT047CancPrec: TOracleDataSet
    SQL.Strings = (
      'select T047.*, T047.ROWID'
      'from   T047_VISITEFISCALI T047'
      'where  TIPO_EVENTO = '#39'01'#39' and'
      '       PROGRESSIVO = :PROGRESSIVO and'
      '       OPERAZIONE = '#39'C'#39' and'
      '       DATA_INIZIO_ASSENZA <= :DATA_CORR and'
      '       DATA_FINE_ASSENZA >= :DATA_CORR and'
      '       DATA_PRIMA_COMUNICAZIONE is null')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000140000003A0044004100540041005F00
      43004F00520052000C0000000000000000000000}
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
    Left = 90
    Top = 317
  end
  object selT047Prec: TOracleDataSet
    SQL.Strings = (
      '-- PERIODO PRECEDENTE: prolungato | non comunicato'
      'select T047.*, T047.ROWID'
      'from   T047_VISITEFISCALI T047'
      'where  TIPO_EVENTO = '#39'01'#39' and'
      '       PROGRESSIVO = :PROGRESSIVO and'
      '       OPERAZIONE = :OPERAZIONE and'
      '       (DATA_FINE_ASSENZA = :DATA_FINE or'
      '        NUOVA_DATA_FINE = :DATA_FINE) and'
      '       DATA_COMUN_PROLUNGAMENTO is null'
      'order by DATA_REGISTRAZIONE desc')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000140000003A0044004100540041005F00
      460049004E0045000C0000000000000000000000160000003A004F0050004500
      520041005A0049004F004E004500050000000000000000000000}
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
    Left = 170
    Top = 317
  end
  object selT047Succ: TOracleDataSet
    SQL.Strings = (
      'select T047.*, T047.ROWID'
      'from   T047_VISITEFISCALI T047'
      'where  TIPO_EVENTO = '#39'01'#39' and'
      '       PROGRESSIVO = :PROGRESSIVO and'
      '       OPERAZIONE = :OPERAZIONE and'
      '       DATA_INIZIO_ASSENZA = :DATA_INIZIO and'
      '       DATA_PRIMA_COMUNICAZIONE is null')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000180000003A0044004100540041005F00
      49004E0049005A0049004F000C0000000000000000000000160000003A004F00
      50004500520041005A0049004F004E004500050000000000000000000000}
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
    Left = 242
    Top = 317
  end
  object selT047InsPrec: TOracleDataSet
    SQL.Strings = (
      'select T047.*, T047.ROWID'
      'from   T047_VISITEFISCALI T047'
      'where  TIPO_EVENTO = '#39'01'#39' and'
      '       PROGRESSIVO = :PROGRESSIVO and'
      '       OPERAZIONE = '#39'I'#39' and'
      '       ((DATA_INIZIO_ASSENZA <= :DATA_CORR and'
      '         DATA_FINE_ASSENZA >= :DATA_CORR and'
      '         DATA_PRIMA_COMUNICAZIONE is null) or'
      '        (DATA_FINE_ASSENZA < :DATA_CORR and'
      '         NUOVA_DATA_FINE >= :DATA_CORR and'
      '         DATA_COMUN_PROLUNGAMENTO is null))')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000140000003A0044004100540041005F00
      43004F00520052000C0000000000000000000000}
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
    Left = 326
    Top = 317
  end
  object selT047InsPrecCom: TOracleDataSet
    SQL.Strings = (
      'select T047.*, T047.ROWID'
      'from   T047_VISITEFISCALI T047'
      'where  TIPO_EVENTO = '#39'01'#39' and'
      '       PROGRESSIVO = :PROGRESSIVO and'
      '       OPERAZIONE = '#39'I'#39' and'
      '       DATA_INIZIO_ASSENZA <= :DATA_CORR and'
      '       DATA_FINE_ASSENZA >= :DATA_CORR and'
      '       DATA_PRIMA_COMUNICAZIONE is not null and'
      '       NUOVA_DATA_FINE is not null and'
      '       DATA_COMUN_PROLUNGAMENTO is null')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000140000003A0044004100540041005F00
      43004F00520052000C0000000000000000000000}
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
    Left = 416
    Top = 317
  end
  object scrL133PServeCertificPubbl: TOracleQuery
    SQL.Strings = (
      'begin'
      
        '  :risultato:=L133ServeCertificPubbl(:p_progressivo,:p_data1,:p_' +
        'data2);'
      'end;')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000004000000140000003A0052004900530055004C005400410054004F00
      0500000000000000000000001C0000003A0050005F00500052004F0047005200
      450053005300490056004F00030000000000000000000000100000003A005000
      5F00440041005400410031000C0000000000000000000000100000003A005000
      5F00440041005400410032000C0000000000000000000000}
    Left = 560
    Top = 317
  end
  object selRapportiUniti: TOracleQuery
    SQL.Strings = (
      'select '
      '  nvl(decode(T.CONTASOLARE,'
      '             '#39'N'#39',T.RAPPORTI_UNITI,'
      
        '             nvl(decode(T263.RAPPORTI_UNITI,'#39'P'#39',T262.RAPPORTI_UN' +
        'ITI,T263.RAPPORTI_UNITI),T262.RAPPORTI_UNITI)'
      '            )'
      '      ,'#39'A'#39') RAPPORTI_UNITI'
      'from '
      '  T263_PROFASSIND T263, '
      '  T262_PROFASSANN T262,'
      '  ('
      
        '  select T265.RAPPORTI_UNITI, T430.PROGRESSIVO, T430.PASSENZE, T' +
        '260.CONTASOLARE, T260.CODICE from '
      '    T265_CAUASSENZE T265, '
      '    T260_RAGGRASSENZE T260, '
      '    T430_STORICO T430'
      '  where T265.CODRAGGR = T260.CODICE'
      '  and   T430.PROGRESSIVO = :PROGRESSIVO'
      '  and   :data between T430.DATADECORRENZA and T430.DATAFINE '
      '  and   T265.CODICE = :CAUSALE'
      '  ) T'
      'where T263.PROGRESSIVO(+) = T.PROGRESSIVO '
      '--and   T263.ANNO(+) = to_char(:DATA,'#39'yyyy'#39')'
      'and   :DATA between T263.DAL(+) and T263.AL(+)'
      'and   T263.CODRAGGR(+) = T.CODICE'
      'and   T262.CODPROFILO(+) = T.PASSENZE'
      'and   T262.CODRAGGR(+) = T.CODICE'
      'and   T262.ANNO(+) = to_char(:DATA,'#39'yyyy'#39')')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000100000003A00430041005500530041004C0045000500
      00000000000000000000}
    Left = 600
    Top = 208
  end
  object selT040Concat: TOracleDataSet
    SQL.Strings = (
      'select T040.*, T040.ROWID '
      'from   T040_GIUSTIFICATIVI T040 '
      'where  PROGRESSIVO = :PROGRESSIVO'
      
        'and    nvl(DATANAS,to_date('#39'01011900'#39','#39'ddmmyyyy'#39')) = nvl(:DATANA' +
        'S,to_date('#39'01011900'#39','#39'ddmmyyyy'#39'))'
      'and    DATA > :DATA_LIMITE'
      'and    (CAUSALE in (:ELENCO_CAUSALI) or '
      
        '        CAUSALE in (select CODICE from T265_CAUASSENZE where COD' +
        'RAGGR = :CODRAGGR))'
      'and exists ('
      
        '    --deve prevedere una causale successiva (sia direttamente ch' +
        'e tramite le causali che determinano l'#39'inizio periodo (10gg Brun' +
        'etta?))'
      '    select '#39'X'#39' from T265_CAUASSENZE T265'
      
        '    where intersez_liste(T040.CAUSALE,T265.CODICE||'#39','#39'||T265.CAU' +
        'SALI_CUMULO_L133) is not null'
      '    and T265.CAUSALE_SUCCESSIVA is not null'
      '    union  '
      
        '    --oppure '#232' una causale successiva (sia direttamente che tram' +
        'ite le causali che determinano l'#39'inizio periodo (10gg Brunetta?)' +
        ')'
      '    select '#39'X'#39' from T265_CAUASSENZE T265'
      '    where T265.CAUSALE_SUCCESSIVA = T040.CAUSALE '
      
        '    or    T265.CAUSALE_SUCCESSIVA in (select CODICE from T265_CA' +
        'UASSENZE where intersez_liste(CAUSALI_CUMULO_L133,T040.CAUSALE) ' +
        'is not null)'
      ')'
      'order by DATA')
    ReadBuffer = 1000
    Optimize = False
    Variables.Data = {
      0400000005000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000001E0000003A0045004C0045004E004300
      4F005F00430041005500530041004C0049000100000000000000000000001800
      00003A0044004100540041005F004C0049004D004900540045000C0000000000
      000000000000120000003A0043004F0044005200410047004700520005000000
      0000000000000000100000003A0044004100540041004E00410053000C000000
      0000000000000000}
    Left = 136
    Top = 380
  end
  object selSG101DataNas: TOracleDataSet
    SQL.Strings = (
      'SELECT DATANAS '
      'FROM SG101_FAMILIARI'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      'AND NVL(DATAADOZ,DATANAS) = :DATANAS'
      'AND :DATA BETWEEN DECORRENZA AND DECORRENZA_FINE')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A0044004100540041004E00
      410053000C00000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 749
    Top = 12
  end
  object selCompS: TOracleDataSet
    SQL.Strings = (
      'select DATA from T100_TIMBRATURE T100, T275_CAUPRESENZE T275'
      'where T100.PROGRESSIVO = :PROGRESSIVO '
      'and T100.FLAG in ('#39'O'#39','#39'I'#39')'
      'and T100.CAUSALE = T275.CODICE'
      'and instr('#39','#39'||:CAUSALI||'#39','#39','#39','#39'||T100.CAUSALE||'#39','#39') > 0'
      'and T100.DATA between least(:DATA0,:DATA1) and :DATA2'
      
        'and T100.DATA between decode(T275.COMP_CAUS_OREMAX,'#39'S'#39',:DATA0,:D' +
        'ATA1) and :DATA2'
      'union'
      'select DATA from T040_GIUSTIFICATIVI T040, T275_CAUPRESENZE T275'
      'where T040.PROGRESSIVO = :PROGRESSIVO '
      'and T040.CAUSALE = T275.CODICE'
      'and instr('#39','#39'||:CAUSALI||'#39','#39','#39','#39'||T040.CAUSALE||'#39','#39') > 0'
      'and T040.DATA between least(:DATA0,:DATA1) and :DATA2'
      
        'and T040.DATA between decode(T275.COMP_CAUS_OREMAX,'#39'S'#39',:DATA0,:D' +
        'ATA1) and :DATA2'
      'union'
      
        'select DATA from T320_PIANLIBPROFESSIONE T320, T275_CAUPRESENZE ' +
        'T275'
      'where T320.PROGRESSIVO = :PROGRESSIVO '
      'and T320.CAUSALE = T275.CODICE'
      'and instr('#39','#39'||:CAUSALI||'#39','#39','#39','#39'||T320.CAUSALE||'#39','#39') > 0'
      
        'and T320.DATA between decode(T275.COMP_CAUS_OREMAX,'#39'S'#39',:DATA0,:D' +
        'ATA1) and :DATA2'
      'union'
      'select DATA from V010_CALENDARI V010'
      'where V010.PROGRESSIVO = :PROGRESSIVO '
      'and V010.DATA between :DATA1 and :DATA2'
      'and V010.FESTIVO = '#39'S'#39)
    Optimize = False
    Variables.Data = {
      0400000005000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000100000003A00430041005500530041004C00490005000000
      00000000000000000C0000003A00440041005400410030000C00000000000000
      00000000}
    Left = 724
    Top = 64
  end
  object selT275CompS: TOracleDataSet
    SQL.Strings = (
      'select CODICE from T275_CAUPRESENZE where COMP_CAUS_OREMAX = '#39'S'#39)
    ReadBuffer = 5
    Optimize = False
    Left = 788
    Top = 64
  end
  object selSG101Causali: TOracleDataSet
    SQL.Strings = (
      'SELECT '
      
        '  NUMORD, NVL(DATAADOZ,DATANAS) DATA, '#39'<'#39'||replace(CAUSALI_ABILI' +
        'TATE,'#39','#39','#39'>,<'#39')||'#39'>'#39' CAUSALI_ABILITATE,'
      '  DECORRENZA, DECORRENZA_FINE'
      'FROM SG101_FAMILIARI'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      'ORDER BY NUMORD,DECORRENZA')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Filtered = True
    Left = 573
    Top = 12
  end
  object selT050: TOracleDataSet
    SQL.Strings = (
      'select '
      
        '  /*SIHINT9 LEADING(T265) INDEX(T050_RICHIESTEASSENZA T050_BMI_E' +
        'LABORATO) */'
      '  T050.PROGRESSIVO,'
      '  greatest(T050.DAL,:DATA1) DAL,'
      '  least(T050.AL,:DATA2) AL,'
      '  V010.DATA,'
      '  T050.CAUSALE,'
      '  T050.TIPOGIUST,'
      
        '  TO_DATE(DECODE(NUMEROORE,NULL,NULL,'#39'30121899'#39')||NUMEROORE,'#39'DDM' +
        'MYYYYHH24.MI'#39') DAORE,'
      
        '  TO_DATE(DECODE(AORE,NULL,NULL,'#39'30121899'#39')||AORE,'#39'DDMMYYYYHH24.' +
        'MI'#39') AORE,'
      '  T050.DATANAS,'
      '  DECODE(T050.PROGRESSIVO,:PROG1,'#39'N'#39',:PROG2,'#39'S'#39') CONIUGE,'
      '  T050.STATO AUTORIZZAZIONE,'
      '  T050.ID'
      'from '
      '  T265_CAUASSENZE T265, '
      '  VT050_RICHIESTE_SENZAREVOCA T050,'
      '  V010_CALENDARI V010'
      'where T050.ELABORATO = '#39'N'#39
      'and T050.PROGRESSIVO in (:PROG1,:PROG2)'
      'and T050.DAL <= :DATA2'
      'and T050.AL >= :DATA1'
      'and V010.PROGRESSIVO = T050.PROGRESSIVO '
      
        'and V010.DATA between greatest(T050.DAL,:DATA1) and least(T050.A' +
        'L,:DATA2)'
      'and T050.CAUSALE = T265.CODICE'
      
        'and exists (select '#39'x'#39' from dual where nvl(T050F_AUTORIZZATA(T05' +
        '0.ID),'#39'N'#39') = '#39'S'#39')'
      
        'and exists (select '#39'x'#39' from dual where T050F_CANCELLATA(T050.ID,' +
        'V010.DATA) = '#39'N'#39')'
      
        'and (T265.CODRAGGR = :RAGGRUPPAMENTO or T265.CODICE in (:ELENCOC' +
        'AUSALI))'
      'and (:DATANAS is null or DATANAS = :DATANAS)'
      'order by V010.DATA,T050.CAUSALE')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      04000000070000000C0000003A00440041005400410031000C00000000000000
      000000000C0000003A00440041005400410032000C0000000000000000000000
      0C0000003A00500052004F00470031000300000000000000000000000C000000
      3A00500052004F00470032000300000000000000000000001E0000003A005200
      410047004700520055005000500041004D0045004E0054004F00050000000000
      0000000000001C0000003A0045004C0045004E0043004F004300410055005300
      41004C004900010000000000000000000000100000003A004400410054004100
      4E00410053000C0000000000000000000000}
    Left = 736
    Top = 156
  end
  object selT460a: TOracleDataSet
    SQL.Strings = (
      'select t460.tipo,t460.assenzegg,t460.assenzehh '
      'from t430_storico t430, t460_parttime t460'
      'where '
      't430.parttime = t460.codice(+) and'
      
        'progressivo = :progressivo and :data  between datadecorrenza and' +
        ' datafine')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 410
    Top = 207
  end
  object cdsFruizioni: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 680
    Top = 320
  end
  object selGGContinuativi: TOracleQuery
    SQL.Strings = (
      'select sum(decode(TIPOGIUST,'#39'I'#39',1,'#39'M'#39',0.5)) NUMGG '
      'from T040_GIUSTIFICATIVI'
      'where PROGRESSIVO = :PROGRESSIVO '
      
        'and instr('#39','#39'||T265F_GETCATENACOMPLETA(:CAUSALE,'#39'T'#39')||'#39','#39'||T265F' +
        '_CAUSALI_CUMULATE(:CAUSALE)||'#39','#39','#39','#39'||CAUSALE||'#39','#39') > 0 '
      'and DATA between :DATA - (:PERIODO - 1) AND :DATA '
      'and TIPOGIUST in ('#39'I'#39','#39'M'#39')'
      'and not exists ('
      '  select '#39'x'#39
      '  from T040_GIUSTIFICATIVI'
      '  where PROGRESSIVO = :PROGRESSIVO '
      
        '  and instr('#39','#39'||T265F_GETCATENACOMPLETA(:CAUSALE,'#39'T'#39')||'#39','#39'||T26' +
        '5F_CAUSALI_CUMULATE(:CAUSALE)||'#39','#39','#39','#39'||CAUSALE||'#39','#39') > 0 '
      '  and DATA = :DATA - :PERIODO'
      '  and TIPOGIUST in ('#39'I'#39','#39'M'#39')'
      ')')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000100000003A00430041005500530041004C0045000500
      00000000000000000000100000003A0050004500520049004F0044004F000300
      00000000000000000000}
    Left = 688
    Top = 208
  end
  object selPresAbil: TOracleDataSet
    SQL.Strings = (
      'select 1'
      
        'from T270_RAGGRPRESENZE T270, T275_CAUPRESENZE T275, T430_STORIC' +
        'O T430'
      'where T270.CODICE = T275.CODRAGGR'
      'and T275.CODICE = :CAUSALE'
      'and T430.PROGRESSIVO = :PROGRESSIVO'
      'and :DATA between T430.DATADECORRENZA and T430.DATAFINE'
      'and instr('#39','#39'||T430.ABPRESENZA1||'#39','#39','#39','#39'||T270.CODICE||'#39','#39') > 0')
    ReadBuffer = 1000
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A0043004100550053004100
      4C0045000500000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 224
    Top = 380
  end
  object selCatenaCausali: TOracleQuery
    SQL.Strings = (
      'select T265F_GETCATENACOMPLETA(:causale,'#39'N'#39') catena from dual')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A00430041005500530041004C00450005000000
      0000000000000000}
    Left = 296
    Top = 381
  end
  object GetTurRepFest: TOracleQuery
    SQL.Strings = (
      'begin'
      '  :NumTurni:=GetTurRepFest(:Prog,:InizioCumulo,:FineCumulo);'
      'end;')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A00500052004F00470003000000000000000000
      00001A0000003A0049004E0049005A0049004F00430055004D0055004C004F00
      0C0000000000000000000000160000003A00460049004E004500430055004D00
      55004C004F000C0000000000000000000000120000003A004E0055004D005400
      550052004E00490003000000040000000000000000000000}
    Left = 528
    Top = 381
  end
  object selConiuge: TOracleQuery
    SQL.Strings = (
      'declare'
      '  wProgressivo integer;'
      'begin'
      '  wProgressivo:=null;'
      '  begin  '
      '    if :DATANAS is null then'
      '      select max(T030.PROGRESSIVO)'
      '      into   wProgressivo'
      '      from   SG101_FAMILIARI SG101, T030_ANAGRAFICO T030'
      '      where  SG101.PROGRESSIVO = :PROGRESSIVO '
      
        '      and    SG101.GRADOPAR in ('#39'CG'#39','#39'UC'#39','#39'CF'#39') --AL dovrebbe co' +
        'nsiderarsi come query sotto, ma storicamente era stato ignorato.' +
        ' Per prudenza si mantiene ignorato.'
      '      and    SG101.MATRICOLA = T030.MATRICOLA;'
      '    else'
      '      select max(T030.PROGRESSIVO)'
      '      into   wProgressivo'
      
        '      from   SG101_FAMILIARI SG101, T030_ANAGRAFICO T030, SG101_' +
        'FAMILIARI SG101CG'
      '      where  SG101.PROGRESSIVO = :PROGRESSIVO '
      '      and    SG101.GRADOPAR in ('#39'CG'#39','#39'AL'#39','#39'UC'#39','#39'CF'#39') '
      '      and    SG101.MATRICOLA = T030.MATRICOLA'
      '      and    SG101CG.PROGRESSIVO = T030.PROGRESSIVO'
      '      and    nvl(SG101CG.DATAADOZ,SG101CG.DATANAS) = :DATANAS;'
      '    end if;'
      '  exception'
      '    when NO_DATA_FOUND then'
      '      null;'
      '  end;'
      '  :PROG_CG:=wProgressivo;'
      'end;'
      '')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A0044004100540041004E00
      410053000C0000000000000000000000100000003A00500052004F0047005F00
      43004700030000000000000000000000}
    Left = 375
    Top = 12
  end
  object T380F_Turnifestivi_NOChiamata: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      
        '  :NUMTURNI:=T380F_TURNIFESTIVI_NOCHIAMATA(:PROG, :INIZIOCUMULO,' +
        ' :FINECUMULO);'
      'END;')
    Optimize = False
    Variables.Data = {
      0400000004000000120000003A004E0055004D005400550052004E0049000300
      000000000000000000000A0000003A00500052004F0047000300000000000000
      000000001A0000003A0049004E0049005A0049004F00430055004D0055004C00
      4F000C0000000000000000000000160000003A00460049004E00450043005500
      4D0055004C004F000C0000000000000000000000}
    Left = 672
    Top = 378
  end
  object T265P_GETPERIODOCUMULO: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      
        '  T265P_GETPERIODOCUMULO(:PROGRESSIVO,:DATA,:CAUSALE,:DATARIF_FA' +
        'MILIARE,:INIZIO_CUMULO,:FINE_CUMULO);'
      'END;')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000006000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000100000003A00430041005500530041004C0045000500
      000000000000000000001C0000003A0049004E0049005A0049004F005F004300
      55004D0055004C004F000C0000000000000000000000180000003A0046004900
      4E0045005F00430055004D0055004C004F000C00000000000000000000002400
      00003A0044004100540041005200490046005F00460041004D0049004C004900
      4100520045000C0000000000000000000000}
    Left = 80
    Top = 432
  end
  object T265P_GETCOMPETENZE: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      
        '  T265P_GETCOMPETENZE(:PROGRESSIVO,:DATA,:CAUSALE,:DATANAS_FAM,:' +
        'INIZIO_CUMULO,:FINE_CUMULO,:COMP1,:COMP2,:COMP3,:COMP4,:COMP5,:C' +
        'OMP6);'
      'END;')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      040000000C000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000100000003A00430041005500530041004C0045000500
      000000000000000000000C0000003A0043004F004D0050003100050000000600
      000030302E303000000000000C0000003A0043004F004D005000320005000000
      0600000030302E303000000000000C0000003A0043004F004D00500033000500
      00000600000030302E303000000000000C0000003A0043004F004D0050003400
      050000000600000030302E303000000000000C0000003A0043004F004D005000
      3500050000000600000030302E303000000000000C0000003A0043004F004D00
      50003600050000000600000030302E30300000000000180000003A0044004100
      540041004E00410053005F00460041004D000C00000000000000000000001C00
      00003A0049004E0049005A0049004F005F00430055004D0055004C004F000C00
      00000000000000000000180000003A00460049004E0045005F00430055004D00
      55004C004F000C0000000000000000000000}
    Left = 248
    Top = 432
  end
  object T265F_GETINIZIOCATENA: TOracleQuery
    SQL.Strings = (
      'declare'
      '  elenco1 varchar2(500);'
      'begin'
      '  elenco1:=null;'
      '  :caus_inizio:=t265f_getiniziocatena(:causale,elenco1);'
      'end;')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A0043004100550053005F0049004E0049005A00
      49004F00050000000000000000000000100000003A0043004100550053004100
      4C004500050000000000000000000000}
    Left = 80
    Top = 488
  end
  object T265F_GETCATENACOMPLETA: TOracleQuery
    SQL.Strings = (
      'declare'
      '  tipo varchar2(1);'
      'begin'
      '  tipo:='#39'T'#39'; /* T = tutte le causali (normali e ridotte) */'
      '  :catena:=t265f_getcatenacompleta(:causale,tipo);'
      'end;')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A00430041005500530041004C00450005000000
      00000000000000000E0000003A0043004100540045004E004100050000000000
      000000000000}
    Left = 248
    Top = 488
  end
  object T265P_COMP_CONGPARENTALI: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      
        '  T265P_COMP_CONGPARENTALI(:PROGRESSIVO,:DATA,:CAUSALE,:DATANAS_' +
        'FAM,:INIZIO_CUMULO,:FINE_CUMULO,:OFFSET_MAXINDIVIDUALE,:OFFSET_M' +
        'MINTERI,:OFFSET_MMCONT,:OFFSET_GGVUOTI);'
      'END;')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      040000000A000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000100000003A00430041005500530041004C0045000500
      00000000000000000000180000003A0044004100540041004E00410053005F00
      460041004D000C00000000000000000000001C0000003A0049004E0049005A00
      49004F005F00430055004D0055004C004F000C00000000000000000000001800
      00003A00460049004E0045005F00430055004D0055004C004F000C0000000000
      0000000000002C0000003A004F00460046005300450054005F004D0041005800
      49004E0044004900560049004400550041004C00450003000000000000000000
      0000200000003A004F00460046005300450054005F004D004D0049004E005400
      4500520049000300000000000000000000001C0000003A004F00460046005300
      450054005F004D004D0043004F004E0054000300000000000000000000001E00
      00003A004F00460046005300450054005F0047004700560055004F0054004900
      030000000000000000000000}
    Left = 392
    Top = 432
  end
  object T265P_ARROTCOMPETENZE: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      
        '  T265P_ARROTCOMPETENZE(:PROGRESSIVO,:DATA,:CAUSALE,:UMISURA,:TI' +
        'PO,:COMP1,:COMP2,:COMP3,:COMP4,:COMP5,:COMP6,:COMP_PARZIALI);'
      'END;')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      040000000C000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000100000003A00430041005500530041004C0045000500
      00000000000000000000100000003A0055004D00490053005500520041000500
      000000000000000000000C0000003A0043004F004D0050003100050000000000
      0000000000000C0000003A0043004F004D005000320005000000000000000000
      00000C0000003A0043004F004D00500033000500000000000000000000000C00
      00003A0043004F004D00500034000500000000000000000000000C0000003A00
      43004F004D00500035000500000000000000000000000C0000003A0043004F00
      4D00500036000500000000000000000000000A0000003A005400490050004F00
      0500000000000000000000001C0000003A0043004F004D0050005F0050004100
      52005A00490041004C004900050000000000000000000000}
    Left = 408
    Top = 488
  end
  object selT025: TOracleDataSet
    SQL.Strings = (
      
        'select T025.CARTELLINO,T025.RIEPASS_COMPENSABILI_MESE,T025.RIEPA' +
        'SS_COMPENSABILI_ANNO'
      'from T430_STORICO T430, T025_CONTMENSILI T025'
      'where T430.PROGRESSIVO = :PROGRESSIVO'
      'and :DATA between T430.DATADECORRENZA and T430.DATAFINE'
      'and T430.PERSELASTICO = T025.CODICE'
      '')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 680
    Top = 156
  end
  object selCausIncomp: TOracleQuery
    SQL.Strings = (
      'declare cursor c259 is'
      
        'select CODICE, TIPO_CONTROLLO, SEX_FRUITORE, CAU_INCOMPATIBILE, ' +
        'SEX_CAU_INCOMP, INCLUDI_FAM from T259_CONTROLLI_CAUASSENZE, T030' +
        '_ANAGRAFICO T030'
      
        '  where CODICE = :Causale and T030.PROGRESSIVO = :Progressivo an' +
        'd (SEX_FRUITORE = '#39'I'#39' or SEX_FRUITORE = T030.SESSO);'
      'wEsisteIncomp number;'
      'wMessIncomp varchar2(500);'
      'begin'
      '  wEsisteIncomp:=0;'
      '  wMessIncomp:='#39#39';'
      '  for t259 in c259 loop'
      '    -- Controlli su stesso giorno per stesso figlio'
      '    if t259.TIPO_CONTROLLO = '#39'A'#39' then'
      
        '      -- Verifico esistenza causali incompatibili per il dipende' +
        'nte stesso'
      '      if t259.INCLUDI_FAM = '#39'N'#39' then'
      
        '        select count(*) into wEsisteIncomp from T040_GIUSTIFICAT' +
        'IVI T040, T030_ANAGRAFICO T030 '
      
        '          where T040.PROGRESSIVO = :Progressivo and T040.DATA = ' +
        ':Data and T040.CAUSALE = t259.cau_incompatibile and T040.DATANAS' +
        ' = :Datanas '
      
        '          and T040.PROGRESSIVO = T030.PROGRESSIVO and (T030.SESS' +
        'O = t259.sex_cau_incomp or t259.sex_cau_incomp = '#39'I'#39');'
      '        if wEsisteIncomp > 0 then'
      
        '          wMessIncomp:='#39'nel giorno esiste gi'#224' una causale '#39'||t25' +
        '9.cau_incompatibile;'
      '        end if;'
      '      end if;'
      
        '      -- Verifico esistenza causali incompatibili per il coniuge' +
        ' o convivente che pu'#242' usufruire di assenze per lo stesso figlio'
      
        '      if wEsisteIncomp = 0 and t259.INCLUDI_FAM in ('#39'S'#39','#39'F'#39') the' +
        'n'
      '        -- Caso di coniuge interno'
      '        if nvl(:Prog_CG,0) > 0 then'
      
        '          select count(*) into wEsisteIncomp from T040_GIUSTIFIC' +
        'ATIVI T040, T030_ANAGRAFICO T030 '
      
        '            where T040.PROGRESSIVO = :Prog_CG and T040.DATA = :D' +
        'ata and T040.CAUSALE = t259.cau_incompatibile and T040.DATANAS =' +
        ' :Datanas '
      
        '            and T040.PROGRESSIVO = T030.PROGRESSIVO and (T030.SE' +
        'SSO = t259.sex_cau_incomp or t259.sex_cau_incomp = '#39'I'#39');'
      '          if wEsisteIncomp > 0 then'
      
        '            wMessIncomp:='#39'nel giorno esiste gi'#224' una causale '#39'||t' +
        '259.cau_incompatibile||'#39' fruita dal coniuge'#39';'
      '          end if;'
      '        else'
      '        -- Caso di coniuge esterno'
      
        '          select count(*) into wEsisteIncomp from T046_GIUSTIFIC' +
        'ATIVIFAMILIARI T046, T030_ANAGRAFICO T030 '
      
        '            where T046.PROGRESSIVO = :Progressivo and T046.DATA ' +
        '= :Data and T046.CAUSALE = t259.cau_incompatibile and T046.DATAN' +
        'AS = :Datanas '
      
        '            and T046.PROGRESSIVO = T030.PROGRESSIVO and (T030.SE' +
        'SSO <> t259.sex_cau_incomp or t259.sex_cau_incomp = '#39'I'#39');'
      '          if wEsisteIncomp > 0 then'
      
        '            wMessIncomp:='#39'nel giorno esiste gi'#224' una causale '#39'||t' +
        '259.cau_incompatibile||'#39' fruita dal coniuge'#39';'
      '          end if;'
      '        end if;'
      '      end if;'
      '    -- Controlli su stesso mese per stesso figlio'
      '    elsif t259.TIPO_CONTROLLO = '#39'B'#39' then'
      
        '      -- Verifico esistenza causali incompatibili per il dipende' +
        'nte stesso'
      '      if t259.INCLUDI_FAM = '#39'N'#39' then'
      
        '        select count(*) into wEsisteIncomp from T040_GIUSTIFICAT' +
        'IVI T040, T030_ANAGRAFICO T030 '
      
        '          where T040.PROGRESSIVO = :Progressivo and to_char(T040' +
        '.DATA,'#39'MMYYY'#39') = to_char(:Data,'#39'MMYYY'#39') and T040.CAUSALE = t259.' +
        'cau_incompatibile and T040.DATANAS = :Datanas '
      
        '          and T040.PROGRESSIVO = T030.PROGRESSIVO and (T030.SESS' +
        'O = t259.sex_cau_incomp or t259.sex_cau_incomp = '#39'I'#39');'
      '        if wEsisteIncomp > 0 then'
      
        '          wMessIncomp:='#39'nel mese esiste gi'#224' una causale '#39'||t259.' +
        'cau_incompatibile;'
      '        end if;'
      '      end if;'
      
        '      -- Verifico esistenza causali incompatibili per il coniuge' +
        ' o convivente che pu'#242' usufruire di assenze per lo stesso figlio'
      
        '      if wEsisteIncomp = 0 and t259.INCLUDI_FAM in ('#39'S'#39','#39'F'#39') the' +
        'n'
      '        -- Caso di coniuge interno'
      '        if nvl(:Prog_CG,0) > 0 then'
      
        '          select count(*) into wEsisteIncomp from T040_GIUSTIFIC' +
        'ATIVI T040, T030_ANAGRAFICO T030 '
      
        '            where T040.PROGRESSIVO = :Prog_CG and to_char(T040.D' +
        'ATA,'#39'MMYYY'#39') = to_char(:Data,'#39'MMYYY'#39') and T040.CAUSALE = t259.ca' +
        'u_incompatibile and T040.DATANAS = :Datanas '
      
        '            and T040.PROGRESSIVO = T030.PROGRESSIVO and (T030.SE' +
        'SSO = t259.sex_cau_incomp or t259.sex_cau_incomp = '#39'I'#39');'
      '          if wEsisteIncomp > 0 then'
      
        '            wMessIncomp:='#39'nel mese esiste gi'#224' una causale '#39'||t25' +
        '9.cau_incompatibile||'#39' fruita dal coniuge'#39';'
      '          end if;'
      '        else'
      '        -- Caso di coniuge esterno'
      
        '          select count(*) into wEsisteIncomp from T046_GIUSTIFIC' +
        'ATIVIFAMILIARI T046, T030_ANAGRAFICO T030 '
      
        '            where T046.PROGRESSIVO = :Progressivo and to_char(T0' +
        '46.DATA,'#39'MMYYY'#39') = to_char(:Data,'#39'MMYYY'#39') and T046.CAUSALE = t25' +
        '9.cau_incompatibile and T046.DATANAS = :Datanas '
      
        '            and T046.PROGRESSIVO = T030.PROGRESSIVO and (T030.SE' +
        'SSO <> t259.sex_cau_incomp or t259.sex_cau_incomp = '#39'I'#39');'
      '          if wEsisteIncomp > 0 then'
      
        '            wMessIncomp:='#39'nel mese esiste gi'#224' una causale '#39'||t25' +
        '9.cau_incompatibile||'#39' fruita dal coniuge'#39';'
      '          end if;'
      '        end if;'
      '      end if;'
      '    end if;'
      '  end loop; '
      '  :Mess_incomp:=wMessIncomp;'
      'end;')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000006000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A0044004100540041004E00
      410053000C0000000000000000000000100000003A00500052004F0047005F00
      43004700030000000000000000000000100000003A0043004100550053004100
      4C0045000500000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000180000003A004D004500530053005F0049004E004300
      4F004D005000050000000000000000000000}
    Left = 518
    Top = 432
  end
  object selSG101DataNasCausale: TOracleDataSet
    SQL.Strings = (
      'select distinct nvl(DATAADOZ,DATANAS) DATANAS'
      'from   SG101_FAMILIARI SG101'
      'where  SG101.PROGRESSIVO = :PROGRESSIVO'
      'and    :DATA1 <= SG101.DECORRENZA_FINE'
      'and    :DATA2 >= SG101.DECORRENZA '
      
        'and    ((SG101.CAUSALI_ABILITATE = '#39'*'#39') or (INTERSEZ_LISTE(SG101' +
        '.CAUSALI_ABILITATE, :CAUSALE) is not null))')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000100000003A00430041005500530041004C00450005000000
      0000000000000000}
    Left = 861
    Top = 12
  end
  object selFruizGGNeutre: TOracleDataSet
    SQL.Strings = (
      'select sum(CONTA) from'
      '('
      'select /*SIHINT10 INDEX(T040_GIUSTIFICATIVI T040_PK)*/'
      '       '#39'T040'#39' T, count(*) CONTA, max(T040.CAUSALE) CAUSALE'
      'from   T040_GIUSTIFICATIVI T040, T265_CAUASSENZE T265'
      'where  T040.PROGRESSIVO = :PROGRESSIVO'
      'and    T040.DATA = :DATA'
      'and    T040.TIPOGIUST = '#39'I'#39
      'and    T040.CAUSALE = T265.CODICE'
      'and    T265.FRUIZGG_NEUTRA = '#39'S'#39
      
        'and    exists (select '#39'X'#39' from dual where T050F_CANCELLATA(T040.' +
        'ID_RICHIESTA,:DATA) = '#39'N'#39')'
      'union all'
      
        'select /*SIHINT10 INDEX(T050_RICHIESTEASSENZA T050_BMI_ELABORATO' +
        ')*/'
      '       '#39'T050'#39', count(*), max(VT050.CAUSALE) '
      'from   VT050_RICHIESTE_SENZAREVOCA VT050, T265_CAUASSENZE T265'
      'where  VT050.PROGRESSIVO = :PROGRESSIVO'
      'and    :DATA between VT050.DAL and VT050.AL'
      'and    VT050.ELABORATO = '#39'N'#39
      'and    VT050.TIPOGIUST = '#39'I'#39
      'and    VT050.CAUSALE = T265.CODICE'
      'and    T265.FRUIZGG_NEUTRA = '#39'S'#39
      
        'and    exists (select '#39'X'#39' from dual where nvl(T050F_AUTORIZZATA(' +
        'VT050.ID),'#39'N'#39') = '#39'S'#39')'
      
        'and    exists (select '#39'X'#39' from dual where T050F_CANCELLATA(VT050' +
        '.ID,:DATA) = '#39'N'#39')'
      'and    :RichiesteIterAutorizzativo = '#39'S'#39
      ')')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000360000003A0052004900430048004900450053005400
      450049005400450052004100550054004F00520049005A005A00410054004900
      56004F00050000000000000000000000}
    Left = 32
    Top = 60
  end
  object selT275: TOracleDataSet
    SQL.Strings = (
      
        'select CODICE, CAUSALIZZA_TIMB_INTERSECANTI, ARROT_RIEPGG, MINMI' +
        'NUTI, MAXMINUTI, UM_INSERIMENTO_H, UM_INSERIMENTO_D'
      'from T275_CAUPRESENZE order by CODICE')
    Optimize = False
    Left = 852
    Top = 64
  end
  object selT275TipoCumuloS: TOracleDataSet
    SQL.Strings = (
      'select count(*) from T275_CAUPRESENZE T275 '
      'where PERIODICITA_ABBATTIMENTO >= 0'
      'and INTERSEZ_LISTE(T275.CODICE,:CAUSALI) is not null')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A00430041005500530041004C00490005000000
      0000000000000000}
    Left = 932
    Top = 64
  end
  object T040F_CHECKFRUIZCOMPATIBILE: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      
        '  :causali_incompatibili:=T040F_CHECKFRUIZCOMPATIBILE(:TABELLA,:' +
        'PROGRESSIVO,:DATA,:CAUSALE,:TIPOGIUST,:DAORE,:AORE,:FAMILIARE);'
      'END;')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000009000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000100000003A00430041005500530041004C0045000500
      000000000000000000002C0000003A00430041005500530041004C0049005F00
      49004E0043004F004D005000410054004900420049004C004900050000000000
      000000000000140000003A005400490050004F00470049005500530054000500
      000000000000000000000C0000003A00440041004F0052004500050000000000
      0000000000000A0000003A0041004F0052004500050000000000000000000000
      140000003A00460041004D0049004C0049004100520045000C00000000000000
      00000000100000003A0054004100420045004C004C0041000500000000000000
      00000000}
    Left = 568
    Top = 488
  end
  object T230F_HMASSENZA_PROPPT: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      
        '  :HMASSENZA:=T230F_HMASSENZA_PROPPT(:PROGRESSIVO,:DATA,:CAUSALE' +
        ');'
      'END;')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000100000003A00430041005500530041004C0045000500
      00000000000000000000140000003A0048004D0041005300530045004E005A00
      4100030000000000000000000000}
    Left = 80
    Top = 544
  end
  object T230F_GETVALUE: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      '  :VALORE:=T230F_GETVALUE(:CAUSALE,:NOME,:DATA);'
      
        '  T230P_GETPERIODODECORRENZA(:CAUSALE,:DATA,:DECORRENZA,:DECORRE' +
        'NZA_FINE);'
      'END;')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000060000000A0000003A0044004100540041000C000000000000000000
      0000100000003A00430041005500530041004C00450005000000000000000000
      00000A0000003A004E004F004D0045000500000000000000000000000E000000
      3A00560041004C004F0052004500050000000000000000000000160000003A00
      4400450043004F005200520045004E005A0041000C0000000000000000000000
      200000003A004400450043004F005200520045004E005A0041005F0046004900
      4E0045000C0000000000000000000000}
    Left = 240
    Top = 544
  end
  object T230F_CHECK_SCARICOPAGHE_FRUIZ: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      
        '  :VALORE:=T230F_CHECK_SCARICOPAGHE_FRUIZ(:CAUSALE,:DATA,:TIPOGI' +
        'UST);'
      'END;')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A0044004100540041000C000000000000000000
      0000100000003A00430041005500530041004C00450005000000000000000000
      00000E0000003A00560041004C004F0052004500050000000000000000000000
      140000003A005400490050004F00470049005500530054000500000000000000
      00000000}
    Left = 409
    Top = 544
  end
  object scrDelT040GGAuto: TOracleQuery
    SQL.Strings = (
      'declare'
      '  wTipo varchar2(1);'
      '  wCatena varchar2(1000);'
      'begin'
      '  wTipo:='#39'T'#39'; /* T = tutte le causali (normali e ridotte) */'
      '  wCatena:=t265f_getcatenacompleta(:CAUSALE,wTipo);'
      ''
      '  delete from T040_GIUSTIFICATIVI T040'
      '  where T040.PROGRESSIVO = :PROGRESSIVO'
      '  and   T040.DATA between :DAL and :AL'
      '  and   intersez_liste(T040.CAUSALE,wCatena) = T040.CAUSALE'
      '  and   T040.TIPOGIUST = '#39'I'#39
      '  and   exists'
      '    ('
      '    select '#39'x'#39
      '    from  T265_CAUASSENZE T265, T230_CAUASSENZE_PARSTO T230'
      '    where T265.ID = T230.ID'
      '    and   T265.CODICE = T040.CAUSALE'
      
        '    and   T040.DATA between T230.DECORRENZA and T230.DECORRENZA_' +
        'FINE'
      '    and   T230.CHECK_SOLOCOMPETENZE = '#39'S'#39
      '    );'
      'end;')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000004000000100000003A00430041005500530041004C00450005000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000080000003A00440041004C000C000000
      0000000000000000060000003A0041004C000C0000000000000000000000}
    Left = 80
    Top = 596
  end
  object scrT040UltimoGGAuto: TOracleQuery
    SQL.Strings = (
      'declare'
      '  wTipo varchar2(1);'
      '  wCatena varchar2(1000);'
      ''
      '  cursor c1 is  '
      '    select DATA,RESTO_CUMULO_HMA'
      '    from T040_GIUSTIFICATIVI T040'
      '    where T040.PROGRESSIVO = :PROGRESSIVO'
      '    and   T040.DATA between :DAL and :AL'
      '    and   intersez_liste(T040.CAUSALE,wCatena) = T040.CAUSALE'
      '    and   T040.TIPOGIUST = '#39'I'#39
      '    and   exists'
      '      ('
      '      select '#39'x'#39
      '      from  T265_CAUASSENZE T265, T230_CAUASSENZE_PARSTO T230'
      '      where T265.ID = T230.ID'
      '      and   T265.CODICE = T040.CAUSALE'
      
        '      and   T040.DATA between T230.DECORRENZA and T230.DECORRENZ' +
        'A_FINE'
      '      and   T230.CHECK_SOLOCOMPETENZE = '#39'S'#39
      '      )'
      '      order by T040.DATA desc;'
      'begin'
      '  wTipo:='#39'T'#39'; /* T = tutte le causali (normali e ridotte) */'
      '  wCatena:=t265f_getcatenacompleta(:CAUSALE,wTipo);'
      ''
      '  :DATA:=null;'
      '  :RESTO_CUMULO_HMA:=0;'
      '   '
      
        '  --leggo solo il primo record, ovvero l'#39'ultima fruizione prima ' +
        'di :AL'
      '  for t1 in c1 loop'
      '    :DATA:=t1.DATA;'
      '    :RESTO_CUMULO_HMA:=nvl(t1.RESTO_CUMULO_HMA,0);'
      '    exit;'
      '  end loop;  '
      'end;')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000006000000100000003A00430041005500530041004C00450005000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000080000003A00440041004C000C000000
      0000000000000000060000003A0041004C000C00000000000000000000000A00
      00003A0044004100540041000C0000000000000000000000220000003A005200
      4500530054004F005F00430055004D0055004C004F005F0048004D0041000300
      00000000000000000000}
    Left = 192
    Top = 596
  end
  object scrCausAssCatena: TOracleQuery
    SQL.Strings = (
      'declare'
      '  wElenco       varchar2(1000);'
      '  wInizioCatena varchar2(5);'
      '  wFruizOre     varchar2(5);'
      '  wHMAssenza    varchar2(5);'
      'begin'
      '  :chain:=null;'
      '  :chain_l133:=null;'
      '  :chain_raggr:=null;'
      '  '
      '  wElenco:=null;  '
      '  wInizioCatena:=t265f_getiniziocatena(:c,wElenco);'
      '  '
      '  if wInizioCatena is null then'
      '    return;'
      '  end if;'
      '  '
      '  wElenco:=null;  '
      '  t265f_getcatena(wInizioCatena,:chain,:chain_l133,wElenco);'
      ''
      
        '  select CONCATENA_TESTO('#39'select CODICE from T265_CAUASSENZE whe' +
        're CODRAGGR = '#39#39#39'||T265.CODRAGGR||'#39#39#39#39','#39','#39') '
      '  into :chain_raggr'
      '  from T265_CAUASSENZE T265'
      '  where T265.CODICE = :C;'
      '  '
      'exception'
      '  when no_data_found then'
      '    null;  '
      'end;')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000004000000040000003A0043000500000000000000000000000C000000
      3A0043004800410049004E00050000000000000000000000160000003A004300
      4800410049004E005F004C003100330033000500000000000000000000001800
      00003A0043004800410049004E005F0052004100470047005200050000000000
      000000000000}
    Left = 40
    Top = 380
  end
  object selT040GGAuto: TOracleDataSet
    SQL.Strings = (
      'select *'
      'from T040_GIUSTIFICATIVI T040'
      'where T040.PROGRESSIVO = :PROGRESSIVO'
      'and   T040.DATA between :DAL and :AL'
      
        'and   intersez_liste(T040.CAUSALE,t265f_getcatenacompleta(:CAUSA' +
        'LE,'#39'T'#39')) = T040.CAUSALE'
      'and   T040.TIPOGIUST = '#39'I'#39
      'and   exists'
      '('
      '    select '#39'x'#39
      '    from  T265_CAUASSENZE T265, T230_CAUASSENZE_PARSTO T230'
      '    where T265.ID = T230.ID'
      '    and   T265.CODICE = T040.CAUSALE'
      
        '    and   T040.DATA between T230.DECORRENZA and T230.DECORRENZA_' +
        'FINE'
      '    and   T230.CHECK_SOLOCOMPETENZE = '#39'S'#39
      ')'
      '')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000080000003A00440041004C000C000000
      0000000000000000060000003A0041004C000C00000000000000000000001000
      00003A00430041005500530041004C004500050000000000000000000000}
    Left = 80
    Top = 656
  end
  object selT265GGAutoFruizGG: TOracleDataSet
    SQL.Strings = (
      'select T265.CODICE,T265.CODCAU1'
      'from VT230_CAUASSENZE_PARSTO T230, T265_CAUASSENZE T265'
      
        'where trunc(sysdate) between T230.DECORRENZA and T230.DECORRENZA' +
        '_FINE'
      'and T265.CODICE = T230.CODICE'
      'and T230.CAUSALE_HMASSENZA is not null'
      'and INTERSEZ_LISTE(T265.CODCAU1,:CAUSALE) is not null')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A00430041005500530041004C00450005000000
      0000000000000000}
    Left = 192
    Top = 656
  end
  object selT070: TOracleDataSet
    SQL.Strings = (
      'select '
      '  T070.PROGRESSIVO,T070.DATA,'
      
        '  T025.RIEPASS_COMPENSABILI_ANNO,T070.RIEPASS_COMPENSATE_ANNO,T2' +
        '65_A.CODRAGGR CODRAGGR_ANNO,'
      
        '  T025.RIEPASS_COMPENSABILI_MESE,T070.RIEPASS_COMPENSATE_MESE,T2' +
        '65_A.CODRAGGR CODRAGGR_MESE'
      
        'from T070_SCHEDARIEPIL T070, T430_STORICO T430, T025_CONTMENSILI' +
        ' T025, T265_CAUASSENZE T265_A, T265_CAUASSENZE T265_M'
      'where T070.PROGRESSIVO = :PROGRESSIVO'
      'and T070.DATA between :DATA1 and :DATA2'
      'and T430.PROGRESSIVO = T070.PROGRESSIVO'
      
        'and last_day(T070.DATA) between T430.DATADECORRENZA and T430.DAT' +
        'AFINE'
      'and T430.PERSELASTICO = T025.CODICE'
      
        'and nvl(T025.RIEPASS_COMPENSABILI_ANNO,T025.RIEPASS_COMPENSABILI' +
        '_MESE) is not null'
      
        'and nvl(T070.RIEPASS_COMPENSATE_ANNO,T070.RIEPASS_COMPENSATE_MES' +
        'E) is not null'
      'and T025.RIEPASS_COMPENSABILI_ANNO = T265_A.CODICE(+)'
      'and T025.RIEPASS_COMPENSABILI_MESE = T265_M.CODICE(+)'
      'and (T265_A.CODRAGGR = :RAGGRUPPAMENTO'
      '     or'
      '     T265_M.CODRAGGR = :RAGGRUPPAMENTO'
      '     or'
      
        '     INTERSEZ_LISTE(T025.RIEPASS_COMPENSABILI_ANNO||'#39','#39'||T025.RI' +
        'EPASS_COMPENSABILI_MESE,:ELENCOCAUSALI) is not null)'
      'order by T070.DATA')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      04000000050000000C0000003A00440041005400410031000C00000000000000
      000000000C0000003A00440041005400410032000C0000000000000000000000
      180000003A00500052004F0047005200450053005300490056004F0003000000
      00000000000000001E0000003A00520041004700470052005500500050004100
      4D0045004E0054004F000500000000000000000000001C0000003A0045004C00
      45004E0043004F00430041005500530041004C00490001000000000000000000
      0000}
    Left = 792
    Top = 156
  end
  object NonMaturaFerieMesi: TOracleDataSet
    SQL.Strings = (
      'select trunc(DATA,'#39'mm'#39') DATA,count(*) NUMERO from '
      '('
      'select /*SIHINT10 INDEX(T040_GIUSTIFICATIVI T040_PK)*/'
      
        '       '#39'T040'#39',T040.DATA, decode(T040.TIPOGIUST,'#39'I'#39',1,'#39'M'#39',0.5,0) ' +
        'QUANTITA'
      'from   T040_GIUSTIFICATIVI T040, T265_CAUASSENZE T265'
      'where  T040.PROGRESSIVO = :PROGRESSIVO '
      'and    T040.DATA BETWEEN :DATA1 and :DATA2 '
      'and    T040.CAUSALE = T265.CODICE '
      'and    T265.MATURFERIE = '#39'N'#39' '
      'and    T040.TIPOGIUST in ('#39'I'#39','#39'M'#39')'
      
        '--and    exists (select '#39'X'#39' from dual where T050F_REVOCATA(T040.' +
        'ID_RICHIESTA) = '#39'N'#39')'
      
        'and    exists (select '#39'X'#39' from dual where T050F_CANCELLATA(T040.' +
        'ID_RICHIESTA,T040.DATA) = '#39'N'#39')'
      'union all'
      
        'select /*SIHINT10 INDEX(T050_RICHIESTEASSENZA T050_BMI_ELABORATO' +
        ')*/'
      
        '       '#39'T050'#39', V010.DATA, decode(VT050.TIPOGIUST,'#39'I'#39',1,'#39'M'#39',0.5,0' +
        ') QUANTITA'
      
        'from   VT050_RICHIESTE_SENZAREVOCA VT050, T265_CAUASSENZE T265, ' +
        'V010_CALENDARI V010'
      'where  VT050.PROGRESSIVO = :PROGRESSIVO'
      'and    :DATA1 <= VT050.AL'
      'and    :DATA2 >= VT050.DAL'
      'and    VT050.ELABORATO = '#39'N'#39
      'and    VT050.TIPOGIUST in ('#39'I'#39','#39'M'#39')'
      'and    VT050.CAUSALE = T265.CODICE '
      'and    T265.MATURFERIE = '#39'N'#39' '
      'and    V010.PROGRESSIVO = :PROGRESSIVO'
      
        'and    V010.DATA between greatest(VT050.DAL,:DATA1) and least(VT' +
        '050.AL,:DATA2)'
      
        'and    exists (select '#39'X'#39' from dual where nvl(T050F_AUTORIZZATA(' +
        'VT050.ID),'#39'N'#39') = '#39'S'#39')'
      
        'and    exists (select '#39'X'#39' from dual where T050F_CANCELLATA(VT050' +
        '.ID,V010.DATA) = '#39'N'#39')'
      'and    :RichiesteIterAutorizzativo = '#39'S'#39
      '--order by DATA'
      ')'
      'group by trunc(data,'#39'mm'#39')'
      'having count(*) > to_char(last_day(trunc(DATA,'#39'mm'#39')),'#39'dd'#39')/2'
      'order by 1')
    ReadBuffer = 13
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000360000003A00520049004300480049004500530054004500
      49005400450052004100550054004F00520049005A005A004100540049005600
      4F00050000000000000000000000}
    Left = 892
    Top = 204
  end
end
