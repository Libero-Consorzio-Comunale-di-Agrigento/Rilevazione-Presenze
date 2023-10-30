inherited B110FWebServiceEnteDM: TB110FWebServiceEnteDM
  OldCreateOrder = True
  object selR010: TOracleDataSet
    SQL.Strings = (
      'select * '
      'from   R010_WS_ENTI'
      'where  ID = :ID'
      'order by ID')
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400050000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      0500000003000000040000004900440001000000000006000000550052004C00
      0100000000000E00000041005A00490045004E0044004100010000000000}
    Left = 40
    Top = 88
  end
  object SessioneMEDP: TOracleSession
    LogonUsername = 'MEDP_REPOSITORY'
    LogonPassword = 'TIMOTEO'
    ThreadSafe = True
    Preferences.ConvertUTF = cuUTF8ToUTF16
    Left = 40
    Top = 24
  end
end
