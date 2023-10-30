inherited A092FStampaStoricoMW: TA092FStampaStoricoMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 191
  Width = 358
  object Q010S: TOracleDataSet
    SQL.Strings = (
      'select DISTINCT COLUMN_NAME,TABLE_NAME,NOME_LOGICO'
      'from cols, i010_campianagrafici'
      'where table_name in (:tabelle)'
      
        'and DECODE(TABLE_NAME,'#39'T430_STORICO'#39','#39'T430'#39' || COLUMN_NAME,'#39'P430' +
        #39' || COLUMN_NAME) = NOME_CAMPO'
      'and applicazione = :applicazione'
      'ORDER BY NOME_LOGICO')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0054004100420045004C004C00450001000000
      00000000000000001A0000003A004100500050004C004900430041005A004900
      4F004E004500050000000000000000000000}
    Left = 24
    Top = 12
  end
  object TabellaStampa: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 121
    Top = 13
  end
  object dsrTabellaStampa: TDataSource
    DataSet = TabellaStampa
    Left = 121
    Top = 57
  end
  object Q430: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM V430_STORICO'
      'WHERE T430PROGRESSIVO = :Prog '
      'ORDER BY T430DATADECORRENZA   ')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A00500052004F00470003000000000000000000
      0000}
    Left = 68
    Top = 12
  end
end
