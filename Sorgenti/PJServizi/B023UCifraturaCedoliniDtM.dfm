inherited B023FCifraturaCedoliniDtM: TB023FCifraturaCedoliniDtM
  OldCreateOrder = True
  Height = 180
  Width = 344
  object selP500Ced: TOracleDataSet
    SQL.Strings = (
      'select'
      'COD_AZIENDA_BASE,'
      'PATH_FILEPDF_CED'
      'from p500_cudsetup t'
      'where anno=:anno')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A0041004E004E004F0003000000000000000000
      0000}
    Left = 16
    Top = 8
  end
  object selP500CU: TOracleDataSet
    SQL.Strings = (
      'select *'
      'from P500_CUDSETUP P500'
      
        'where P500.ANNO = (SELECT MAX(ANNO) FROM P500_CUDSETUP P WHERE P' +
        '.ANNO <= :Anno AND P.COD_AZIENDA_BASE = P500.COD_AZIENDA_BASE)')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A0041004E004E004F0003000000000000000000
      0000}
    Left = 88
    Top = 8
  end
end
