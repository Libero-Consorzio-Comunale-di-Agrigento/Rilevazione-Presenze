object B024FADSCatanzaroDM: TB024FADSCatanzaroDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 144
  Width = 249
  object selI090: TOracleQuery
    SQL.Strings = (
      'select UTENTE, PAROLACHIAVE '
      'from   I090_ENTI '
      'where  AZIENDA = :AZIENDA')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    Left = 32
    Top = 24
  end
end
