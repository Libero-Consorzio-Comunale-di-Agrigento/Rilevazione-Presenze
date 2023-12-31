inherited A096FProfiliLibProfMW: TA096FProfiliLibProfMW
  OldCreateOrder = True
  Height = 117
  Width = 261
  object Upd311: TOracleQuery
    SQL.Strings = (
      'UPDATE T311_DETTLIBPROF'
      'SET CODICE = :CODICE'
      'WHERE CODICE = :CODICE_OLD')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A0043004F004400490043004500050000000000
      000000000000160000003A0043004F0044004900430045005F004F004C004400
      050000000000000000000000}
    Left = 128
    Top = 8
  end
  object Del311: TOracleQuery
    SQL.Strings = (
      'DELETE FROM T311_DETTLIBPROF '
      'WHERE CODICE = :CODICE')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 172
    Top = 8
  end
  object Q275: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE'
      'FROM T275_CAUPRESENZE'
      'ORDER BY CODICE')
    Optimize = False
    Left = 216
    Top = 8
  end
  object selaT311: TOracleDataSet
    SQL.Strings = (
      'select * from '
      '  (select giorno, dalle, alle,'
      
        '          decode(greatest(oreminuti(alle) - oreminuti(dalle),0),' +
        '0,minutiore(oreminuti(alle) + oreminuti('#39'24.00'#39')),alle) alle_con' +
        'tinue'
      '  from t311_dettlibprof'
      '  where codice = :codice'
      '  :COND_ROWID)'
      'where (    :giorno = giorno'
      '       and oreminuti(:dalle) <= oreminuti(alle_continue)'
      '       and oreminuti(:alle_continue) >= oreminuti(dalle))'
      '  :COND_FERIALE')
    Optimize = False
    Variables.Data = {
      04000000060000000C0000003A00440041004C004C0045000500000000000000
      000000001C0000003A0041004C004C0045005F0043004F004E00540049004E00
      55004500050000000000000000000000160000003A0043004F004E0044005F00
      52004F005700490044000100000000000000000000000E0000003A0043004F00
      44004900430045000500000000000000000000001A0000003A0043004F004E00
      44005F00460045005200490041004C0045000100000000000000000000000E00
      00003A00470049004F0052004E004F00050000000000000000000000}
    Left = 88
    Top = 60
  end
end
