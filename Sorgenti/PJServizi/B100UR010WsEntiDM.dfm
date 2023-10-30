inherited B100FR010WsEntiDM: TB100FR010WsEntiDM
  OldCreateOrder = True
  Height = 81
  Width = 331
  inherited selProg: TOracleQuery
    SQL.Strings = (
      'SELECT PROGRESSIVO, COGNOME, NOME'
      'FROM   T030_ANAGRAFICO '
      'WHERE  MATRICOLA = :MATRICOLA')
  end
  object selR010: TOracleDataSet
    SQL.Strings = (
      'select * from R010_WS_ENTI'
      'order by ID')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      0500000003000000040000004900440001000000000006000000550052004C00
      0100000000000E00000041005A00490045004E0044004100010000000000}
    Left = 112
    Top = 16
  end
end
