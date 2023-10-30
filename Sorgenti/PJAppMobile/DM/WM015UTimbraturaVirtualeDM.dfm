inherited WM015FTimbraturaVirtualeDM: TWM015FTimbraturaVirtualeDM
  OldCreateOrder = True
  object selT361: TOracleDataSet
    SQL.Strings = (
      'select T361.* '
      
        'from   T361_OROLOGI T361 where RAGGIO_VALIDITA is not null and R' +
        'AGGIO_VALIDITA <> 0'
      'order by CODICE')
    ReadBuffer = 100
    Optimize = False
    Filtered = True
    OnFilterRecord = selT361FilterRecord
    Left = 15
    Top = 14
  end
  object selT430: TOracleDataSet
    SQL.Strings = (
      
        'select TERMINALI from T430_STORICO t where PROGRESSIVO = :PROGRE' +
        'SSIVO and trunc(sysdate) between DATADECORRENZA and DATAFINE')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Left = 88
    Top = 16
  end
end
