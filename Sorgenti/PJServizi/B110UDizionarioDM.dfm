inherited B110FDizionarioDM: TB110FDizionarioDM
  OldCreateOrder = True
  Height = 460
  Width = 251
  object selT275Abilitate: TOracleDataSet
    SQL.Strings = (
      'select '#39'T275'#39' TIPO, T275.CODICE, T275.DESCRIZIONE'
      'from   T275_CAUPRESENZE T275, T430_STORICO T430'
      'where  T430.PROGRESSIVO = :PROGRESSIVO'
      'and    :DATA between T430.DATADECORRENZA and T430.DATAFINE'
      
        'and    instr('#39','#39'||T430.ABPRESENZA1||'#39','#39','#39','#39'||T275.CODRAGGR||'#39','#39')' +
        ' > 0'
      'and    T275.INSERIMENTO_TIMB = '#39'S'#39
      'and    T275.INSERIMENTO_TIMBVIRT = '#39'S'#39
      'union --richiesto dal CSI e CISAP'
      'select '#39'T305'#39' TIPO, T305.CODICE, T305.DESCRIZIONE'
      'from   T305_CAUGIUSTIF T305, T300_RAGGRGIUSTIF T300'
      'where  T305.CODRAGGR = T300.CODICE'
      'and    T300.CODINTERNO = '#39'B'#39
      'order by 2')
    ReadBuffer = 200
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Filtered = True
    OnFilterRecord = selT275AbilitateFilterRecord
    Left = 103
    Top = 302
  end
  object selT361: TOracleDataSet
    SQL.Strings = (
      'select T361.* '
      'from   T361_OROLOGI T361 '
      'order by CODICE')
    ReadBuffer = 100
    Optimize = False
    Filtered = True
    OnFilterRecord = selT361FilterRecord
    Left = 31
    Top = 366
  end
  object selT106: TOracleDataSet
    SQL.Strings = (
      
        'select T106.CODICE, T106.DESCRIZIONE, T106.CAUSALI, T106.CODICE_' +
        'DEFAULT'
      'from   T106_MOTIVAZIONIRICHIESTE T106'
      'where  T106.TIPO = :TIPO'
      'order by T106.CODICE')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A005400490050004F0005000000000000000000
      0000}
    ReadOnly = True
    Left = 32
    Top = 176
  end
  object selT257: TOracleDataSet
    SQL.Strings = (
      'SELECT T257.COD_CODICIACCORPCAUSALI, '
      '       T257.COD_CAUSALE, '
      '       T256.DESCRIZIONE'
      'FROM   T257_ACCORPCAUSALI T257, '
      '       T256_CODICIACCORPCAUSALI T256, '
      '       T255_TIPOACCORPCAUSALI T255'
      'WHERE  T255.TIPO = '#39'WEB'#39
      'AND    :INDATA BETWEEN T257.DECORRENZA AND T257.DECORRENZA_FINE'
      'AND    T257.COD_TIPOACCORPCAUSALI = T256.COD_TIPOACCORPCAUSALI'
      
        'AND    T257.COD_CODICIACCORPCAUSALI = T256.COD_CODICIACCORPCAUSA' +
        'LI'
      'AND    T257.COD_TIPOACCORPCAUSALI = T255.COD_TIPOACCORPCAUSALI'
      'ORDER BY T257.COD_CODICIACCORPCAUSALI, T257.COD_CAUSALE')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0049004E0044004100540041000C0000000000
      000000000000}
    ReadOnly = True
    Left = 32
    Top = 238
  end
  object selT265: TOracleDataSet
    SQL.Strings = (
      'select CODICE, '
      '       DESCRIZIONE,'
      '       UM_INSERIMENTO,'
      '       UM_INSERIMENTO_MG,'
      '       UM_INSERIMENTO_D,'
      '       UM_INSERIMENTO_H,'
      
        '       decode(nvl(FRUIZIONE_FAMILIARI,'#39'N'#39'),'#39'N'#39',decode(TIPOCUMULO' +
        ','#39'H'#39','#39'N'#39',decode(nvl(CUMULO_FAMILIARI,'#39'N'#39'),'#39'N'#39','#39'N'#39','#39'S'#39')),'#39'S'#39') FAM' +
        'ILIARI,'
      '       t265f_isiniziocatena(CODICE) INIZIO_CATENA'
      'from   T265_CAUASSENZE'
      'order by CODICE')
    ReadBuffer = 500
    Optimize = False
    ReadOnly = True
    Filtered = True
    OnFilterRecord = selT265FilterRecord
    Left = 104
    Top = 240
  end
  object selT275: TOracleDataSet
    SQL.Strings = (
      'select CODICE, DESCRIZIONE, UM_INSERIMENTO_H, UM_INSERIMENTO_D'
      'from   T275_CAUPRESENZE'
      'order by CODICE')
    Optimize = False
    ReadOnly = True
    Filtered = True
    OnFilterRecord = selT275FilterRecord
    Left = 32
    Top = 304
  end
  object selSG101: TOracleDataSet
    SQL.Strings = (
      'select COGNOME, '
      '       NOME, '
      '       CODFISCALE, '
      '       nvl(DATAADOZ,DATANAS) DATANAS,'
      '       CAUSALI_ABILITATE '
      'from   SG101_FAMILIARI'
      'where  PROGRESSIVO = :PROGRESSIVO'
      'and    trunc(sysdate) between DECORRENZA and DECORRENZA_FINE'
      'order by COGNOME, NOME, DATANAS')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    ReadOnly = True
    Left = 31
    Top = 64
  end
  object selT040Note: TOracleDataSet
    SQL.Strings = (
      'select distinct NOTE '
      'from   T040_GIUSTIFICATIVI '
      'where  DATA >= add_months(sysdate,-12) '
      'and    NOTE is not null'
      'order by 1')
    ReadBuffer = 20
    Optimize = False
    ReadOnly = True
    Left = 31
    Top = 120
  end
  object selI096: TOracleDataSet
    SQL.Strings = (
      'select * '
      'from   MONDOEDP.I096_LIVELLI_ITER_AUT '
      'where  AZIENDA = :AZIENDA '
      'and    ITER = :ITER'
      'order by COD_ITER,LIVELLO')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      00000000000000000A0000003A00490054004500520005000000000000000000
      0000}
    Left = 32
    Top = 8
  end
end
