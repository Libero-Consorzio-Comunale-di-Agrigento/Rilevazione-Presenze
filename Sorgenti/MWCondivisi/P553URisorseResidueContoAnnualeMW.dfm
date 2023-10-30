inherited P553FRisorseResidueContoAnnualeMW: TP553FRisorseResidueContoAnnualeMW
  OldCreateOrder = True
  Height = 144
  Width = 199
  object selP552: TOracleDataSet
    SQL.Strings = (
      'select ANNO,COD_TABELLA,DESCRIZIONE,TIPO_TABELLA_RIGHE '
      '  from p552_contoannregole'
      ' where RIGA=0 and COLONNA=0 and TIPO_TABELLA_RIGHE in (0,2)'
      '   and ANNO = :ANNO'
      'order by anno')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A0041004E004E004F0003000000000000000000
      0000}
    QBEDefinition.QBEFieldDefs = {
      05000000040000000800000041004E004E004F00010000000000160000004300
      4F0044005F0054004100420045004C004C004100010000000000160000004400
      450053004300520049005A0049004F004E004500010000000000240000005400
      490050004F005F0054004100420045004C004C0041005F005200490047004800
      4500010000000000}
    Left = 24
    Top = 16
  end
  object QSQL: TOracleDataSet
    Optimize = False
    Left = 136
    Top = 16
  end
  object selT470: TOracleDataSet
    SQL.Strings = (
      'select distinct MACRO_CATEG_QM from T470_QUALIFICAMINIST'
      'order by MACRO_CATEG_QM ')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0054004100420045004C004C00410001000000
      0000000000000000}
    Left = 80
    Top = 16
  end
  object dsrT470: TDataSource
    DataSet = selT470
    Left = 80
    Top = 64
  end
end
