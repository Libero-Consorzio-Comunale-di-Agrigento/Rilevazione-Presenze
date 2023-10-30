inherited B110FDatiGeneraliDM: TB110FDatiGeneraliDM
  OldCreateOrder = True
  Height = 332
  Width = 203
  object selT030_T430: TOracleDataSet
    SQL.Strings = (
      'select T030.PROGRESSIVO,'
      '       T030.MATRICOLA,'
      '       T030.COGNOME,'
      '       T030.NOME,'
      '       T030.SESSO,'
      '       T030.DATANAS,'
      '       T030.CODFISCALE,'
      '       T430.INDIRIZZO,'
      '       T430.COMUNE,'
      '       T430.CAP,'
      '       T430.INIZIO,'
      '       T430.FINE'
      'from   T030_ANAGRAFICO T030,'
      '       T430_STORICO T430'
      'where  T030.PROGRESSIVO = :PROGRESSIVO'
      'and    T430.PROGRESSIVO = T030.PROGRESSIVO'
      
        'and    :DATA_RIFERIMENTO between T430.DATADECORRENZA and T430.DA' +
        'TAFINE')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000220000003A0044004100540041005F00
      5200490046004500520049004D0045004E0054004F000C000000000000000000
      0000}
    Left = 120
    Top = 80
  end
  object selP441_MaxData: TOracleQuery
    SQL.Strings = (
      'select max(DATA_CEDOLINO)'
      'from   P441_CEDOLINO'
      'where  CHIUSO = '#39'S'#39
      'and    PROGRESSIVO = :PROGRESSIVO')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Left = 32
    Top = 192
  end
  object selT950: TOracleDataSet
    SQL.Strings = (
      'select CODICE, DESCRIZIONE'
      'from   T950_STAMPACARTELLINO'
      'order by CODICE')
    ReadBuffer = 50
    Optimize = False
    Filtered = True
    OnFilterRecord = selT950FilterRecord
    Left = 32
    Top = 136
  end
  object selI061: TOracleDataSet
    SQL.Strings = (
      'select I061.*'
      'from   MONDOEDP.I061_PROFILI_DIPENDENTE I061'
      'where  I061.AZIENDA = :AZIENDA'
      'and    upper(I061.NOME_UTENTE) = upper(:NOME_UTENTE)'
      'and    trunc(SYSDATE) between INIZIO_VALIDITA and FINE_VALIDITA'
      'order by I061.NOME_PROFILO')
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      0000000000000000180000003A004E004F004D0045005F005500540045004E00
      54004500050000000000000000000000}
    Left = 37
    Top = 16
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
    Left = 32
    Top = 248
  end
  object selAnagrafe: TOracleDataSet
    Optimize = False
    Variables.Data = {
      0400000002000000160000003A0044004100540041004C00410056004F005200
      4F000C00000000000000000000000E0000003A00460049004C00540052004F00
      010000000000000000000000}
    Left = 35
    Top = 78
  end
end
