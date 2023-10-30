inherited B009FPuntoInformativoDtM1: TB009FPuntoInformativoDtM1
  OldCreateOrder = True
  Left = 201
  Top = 166
  Height = 479
  Width = 741
  object SelT430: TOracleDataSet
    SQL.Strings = (
      'SELECT T430.PROGRESSIVO'
      'FROM T430_STORICO T430'
      'WHERE T430.BADGE = :BADGEIN'
      '  AND T430.DATADECORRENZA = '
      '                       (SELECT MAX(T430B.DATADECORRENZA) '
      '                        FROM T430_STORICO T430B'
      
        '                        WHERE T430B.DATADECORRENZA <= :DECORRENZ' +
        'A'
      
        '                          AND T430B.PROGRESSIVO = T430.PROGRESSI' +
        'VO)')
    Variables.Data = {
      0300000002000000080000003A4241444745494E080000000000000000000000
      0B0000003A4445434F5252454E5A410C0000000000000000000000}
    Left = 40
    Top = 20
  end
  object SelT070: TOracleDataSet
    SQL.Strings = (
      'select max(Data) as DATA from t070_schedariepil '
      'where progressivo = :PROGRESSIVO'
      '  and data <= :DATA')
    Variables.Data = {
      03000000020000000C0000003A50524F475245535349564F0300000000000000
      00000000050000003A444154410C0000000000000000000000}
    Left = 116
    Top = 20
  end
end
