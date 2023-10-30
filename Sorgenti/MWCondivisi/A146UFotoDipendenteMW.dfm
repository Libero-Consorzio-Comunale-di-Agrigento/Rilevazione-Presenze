inherited A146FFotoDipendenteMW: TA146FFotoDipendenteMW
  OldCreateOrder = True
  Height = 164
  Width = 367
  object selT032Blob: TOracleDataSet
    SQL.Strings = (
      'select PROGRESSIVO, FILE_FOTO'
      'from   T032_FOTODIPENDENTE'
      'where  FILE_FOTO is not null'
      ''
      '')
    ReadBuffer = 2000
    Optimize = False
    ReadOnly = True
    Left = 32
    Top = 24
  end
  object updT032Blob: TOracleQuery
    SQL.Strings = (
      'update T032_FOTODIPENDENTE'
      'set    FOTO = :FOTO'
      'where  PROGRESSIVO = :PROGRESSIVO')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A0046004F0054004F0071000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      00000000000000000000}
    Left = 104
    Top = 24
  end
end
