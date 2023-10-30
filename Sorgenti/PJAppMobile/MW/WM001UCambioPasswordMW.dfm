inherited WM001FCambioPasswordMW: TWM001FCambioPasswordMW
  OldCreateOrder = True
  Height = 103
  Width = 210
  object QI060: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM MONDOEDP.I060_LOGIN_DIPENDENTE '
      'WHERE  AZIENDA = :AZIENDA '
      '--AND    NOME_UTENTE = :UTENTE'
      'AND    UPPER(NOME_UTENTE ) = UPPER(:UTENTE)')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      00000000000000000E0000003A005500540045004E0054004500050000000000
      000000000000}
    Left = 15
    Top = 8
  end
end
