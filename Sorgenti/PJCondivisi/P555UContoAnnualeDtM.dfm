inherited P555FContoAnnualeDtM: TP555FContoAnnualeDtM
  OldCreateOrder = True
  Height = 244
  Width = 605
  object selP554: TOracleDataSet
    SQL.Strings = (
      'select p554.*, p554.rowid'
      'from  p554_contoanntestate p554'
      'order by anno, cod_tabella')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000050000000C000000430048004900550053004F000100000000001A00
      000044004100540041005F004300480049005500530055005200410001000000
      00000800000041004E004E004F000100000000001600000043004F0044005F00
      54004100420045004C004C00410001000000000016000000490044005F004300
      4F004E0054004F0041004E004E00010000000000}
    BeforeDelete = BeforeDelete
    AfterScroll = selP554AfterScroll
    Left = 9
    Top = 13
  end
end
