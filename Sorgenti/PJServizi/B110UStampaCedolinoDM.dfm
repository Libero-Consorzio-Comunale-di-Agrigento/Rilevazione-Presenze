inherited B110FStampaCedolinoDM: TB110FStampaCedolinoDM
  OldCreateOrder = True
  object selP441: TOracleDataSet
    SQL.Strings = (
      'select DATA_CEDOLINO,'
      '       DATA_RETRIBUZIONE,'
      '       TIPO_CEDOLINO,       '
      
        '       decode(TIPO_CEDOLINO,'#39'NR'#39','#39'Normale'#39','#39'EX'#39','#39'Extra'#39','#39'TR'#39','#39'Tr' +
        'edicesima'#39') D_TIPO_CEDOLINO, '
      '       DATA_EMISSIONE, '
      '       DATA_CONSEGNA'
      'from   P441_CEDOLINO P441'
      'where  ID_CEDOLINO = :ID_CEDOLINO ')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00490044005F004300450044004F004C004900
      4E004F00030000000000000000000000}
    Left = 27
    Top = 15
  end
end
