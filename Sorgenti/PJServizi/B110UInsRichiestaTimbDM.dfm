inherited B110FInsRichiestaTimbDM: TB110FInsRichiestaTimbDM
  OldCreateOrder = True
  Height = 152
  Width = 117
  object selT361: TOracleQuery
    SQL.Strings = (
      'select T361.FUNZIONE'
      'from   T361_OROLOGI T361'
      'where  T361.CODICE = :CODICE')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 31
    Top = 22
  end
end
