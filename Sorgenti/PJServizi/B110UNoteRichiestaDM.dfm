inherited B110FNoteRichiestaDM: TB110FNoteRichiestaDM
  OldCreateOrder = True
  Height = 97
  Width = 111
  object selT850: TOracleQuery
    SQL.Strings = (
      'select ITER, COD_ITER'
      'from   T850_ITER_RICHIESTE'
      'where  ID = :ID')
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    Left = 32
    Top = 16
  end
end
