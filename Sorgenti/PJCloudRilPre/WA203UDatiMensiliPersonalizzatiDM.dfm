inherited WA203FDatiMensiliPersonalizzatiDM: TWA203FDatiMensiliPersonalizzatiDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select I011.*, ROWID'
      '  from I011_DIZIONARIO_DATISCHEDA I011'
      'order by DATO, DECORRENZA')
  end
end
