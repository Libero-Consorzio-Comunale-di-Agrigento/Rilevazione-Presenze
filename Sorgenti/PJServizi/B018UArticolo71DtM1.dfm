object B018FArticolo71DtM1: TB018FArticolo71DtM1
  OldCreateOrder = True
  OnCreate = B007FCancellaDtM1Create
  OnDestroy = B007FCancellaDtM1Destroy
  Height = 373
  Width = 352
  object dsrQ265: TDataSource
    DataSet = selQ265
    Left = 136
    Top = 10
  end
  object selQ265: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE, DESCRIZIONE'
      'FROM T265_CAUASSENZE'
      'order by codice'
      '')
    Optimize = False
    Left = 92
    Top = 10
  end
  object selT040: TOracleDataSet
    SQL.Strings = (
      'SELECT T040.*,T040.ROWID FROM T040_GIUSTIFICATIVI T040 '
      '  WHERE PROGRESSIVO = :Progressivo'
      '  AND DATA = :DataElaborazione '
      '  AND CAUSALE IN (:CodOrigine)'
      '  AND TIPOGIUST = '#39'I'#39' '
      '-- COMPATIBILE CON ORACLE 8.0.5'
      '  AND NOT EXISTS (SELECT '#39'X'#39' FROM T040_GIUSTIFICATIVI T040A '
      '    WHERE T040.PROGRESSIVO = T040A.PROGRESSIVO'
      '    AND CAUSALE IN (:CausPeriodi)'
      '    AND TIPOGIUST = '#39'I'#39' '
      
        '    AND DATA BETWEEN T040.DATA - 10 AND T040.DATA HAVING COUNT(*' +
        ') > 10)'
      '-- FUNZIONA SOLO DA ORACLE 8.1.7 IN AVANTI'
      '/*'
      '  AND (SELECT COUNT(*) FROM T040_GIUSTIFICATIVI T040A '
      '    WHERE T040.PROGRESSIVO = T040A.PROGRESSIVO'
      '    AND CAUSALE IN (:CausPeriodi)'
      '    AND TIPOGIUST = '#39'I'#39' '
      '    AND DATA BETWEEN T040.DATA - 10 AND T040.DATA) <= 10'
      ''
      '*/')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000220000003A0044004100540041004500
      4C00410042004F00520041005A0049004F004E0045000C000000000000000000
      0000160000003A0043004F0044004F0052004900470049004E00450001000000
      0000000000000000180000003A00430041005500530050004500520049004F00
      44004900010000000000000000000000}
    Left = 20
    Top = 10
  end
  object PeriodiAssenza: TOracleQuery
    SQL.Strings = (
      'begin'
      'GENERA_PERIODI_ASSENZA'
      '  (:PROG, :INIZIO, :FINE, :CAUS, :TG, :DALLE, :ALLE, :OPER);'
      'end;')
    Optimize = False
    Variables.Data = {
      04000000080000000A0000003A00500052004F00470003000000000000000000
      00000E0000003A0049004E0049005A0049004F000C0000000000000000000000
      0A0000003A00460049004E0045000C00000000000000000000000A0000003A00
      4300410055005300050000000000000000000000060000003A00540047000500
      000000000000000000000C0000003A00440041004C004C004500050000000000
      0000000000000A0000003A0041004C004C004500050000000000000000000000
      0A0000003A004F00500045005200050000000000000000000000}
    Left = 32
    Top = 72
  end
end
