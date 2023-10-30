inherited P690FStampaFondiMW: TP690FStampaFondiMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 93
  Width = 82
  object selP684: TOracleDataSet
    SQL.Strings = (
      'SELECT distinct cod_fondo,descrizione FROM P684_FONDI'
      'WHERE DECORRENZA_DA <= :FINE'
      'AND DECORRENZA_A >= :INIZIO'
      'order by cod_fondo')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A00460049004E0045000C000000000000000000
      00000E0000003A0049004E0049005A0049004F000C0000000000000000000000}
    Left = 24
    Top = 24
  end
end
