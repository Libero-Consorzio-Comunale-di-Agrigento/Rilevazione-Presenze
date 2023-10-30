inherited X001FCentriCostoDtM: TX001FCentriCostoDtM
  OldCreateOrder = True
  Height = 188
  Width = 418
  object selX001: TOracleDataSet
    SQL.Strings = (
      'select *'
      'from :tabella'
      'where decorrenza <= :dataA'
      'and scadenza >= :dataDa'
      ':filtro'
      ':ordinamento')
    Optimize = False
    Variables.Data = {
      0400000005000000100000003A0054004100420045004C004C00410001000000
      00000000000000000E0000003A00460049004C00540052004F00010000000000
      000000000000180000003A004F005200440049004E0041004D0045004E005400
      4F000100000000000000000000000C0000003A00440041005400410041000C00
      000000000000000000000E0000003A004400410054004100440041000C000000
      0000000000000000}
    Left = 312
    Top = 120
  end
  object selCols: TOracleDataSet
    SQL.Strings = (
      'select column_name, column_id'
      'from cols'
      'where table_name = :tabella'
      'order by column_id')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0054004100420045004C004C00410005000000
      0000000000000000}
    Left = 368
    Top = 120
  end
end
