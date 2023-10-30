inherited A157FCapitoliTrasferteMW: TA157FCapitoliTrasferteMW
  OldCreateOrder = True
  Height = 132
  Width = 165
  object selM011: TOracleDataSet
    SQL.Strings = (
      
        'select M011.CODICE, rpad(M011.CODICE,5,'#39' '#39')||'#39' '#39'||M011.DESCRIZIO' +
        'NE as DESCRIZIONE'
      '  from M011_TIPOMISSIONE M011'
      ' order by M011.CODICE')
    Optimize = False
    Left = 40
    Top = 24
  end
end
