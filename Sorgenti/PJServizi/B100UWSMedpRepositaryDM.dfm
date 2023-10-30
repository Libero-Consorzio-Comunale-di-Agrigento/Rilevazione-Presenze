object B100FWSMedpRepositaryDM: TB100FWSMedpRepositaryDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 223
  Width = 323
  object SessioneMEDP: TOracleSession
    LogonUsername = 'MEDP_REPOSITARY'
    LogonPassword = 'TIMOTEO'
    LogonDatabase = 'MEDP_REPOSITARY'
    ThreadSafe = True
    Preferences.ConvertUTF = cuUTF8ToUTF16
    Left = 48
    Top = 16
  end
end
