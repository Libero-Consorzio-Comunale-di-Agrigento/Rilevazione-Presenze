inherited WR302FGestTabellaDM: TWR302FGestTabellaDM
  OldCreateOrder = True
  Height = 217
  Width = 491
  object selTabella: TOracleDataSet
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A004F0052004400450052004200590001000000
      0000000000000000}
    OracleDictionary.DefaultValues = True
    OracleDictionary.FieldKinds = True
    BeforePost = BeforePostNoStorico
    AfterScroll = AfterScroll
    Left = 32
    Top = 16
  end
  object dsrTabella: TDataSource
    AutoEdit = False
    DataSet = selTabella
    OnStateChange = dsrTabellaStateChange
    OnUpdateData = dsrTabellaUpdateData
    Left = 32
    Top = 64
  end
  object selEstrazioneDati: TOracleDataSet
    ReadBuffer = 500
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A004F0052004400450052004200590001000000
      0000000000000000}
    Left = 192
    Top = 16
  end
  object dsrEstrazioniDati: TDataSource
    DataSet = selEstrazioneDati
    Left = 192
    Top = 64
  end
  object selT900: TOracleDataSet
    SQL.Strings = (
      'select T900.*, ROWID'
      'from   T900_STAMPABASE T900'
      'where  T900.CODICEINTERNO = :CODICEINTERNO'
      'order by T900.NOMESTAMPA ')
    Optimize = False
    Variables.Data = {
      04000000010000001C0000003A0043004F00440049004300450049004E005400
      450052004E004F00050000000000000000000000}
    Left = 280
    Top = 16
  end
  object selT901: TOracleDataSet
    SQL.Strings = (
      'select T901.*, ROWID'
      'from   T901_STAMPABASE_DATI T901'
      'where  CODICEINTERNO = :CODICEINTERNO'
      'and    NOMESTAMPA = :NOMESTAMPA'
      'order by NUMRIGA')
    Optimize = False
    Variables.Data = {
      04000000020000001C0000003A0043004F00440049004300450049004E005400
      450052004E004F00050000000000000000000000160000003A004E004F004D00
      45005300540041004D0050004100050000000000000000000000}
    Left = 336
    Top = 16
  end
end
