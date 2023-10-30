inherited WA045FStatAssenzeDM: TWA045FStatAssenzeDM
  OldCreateOrder = True
  object QSceltaQualif: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT T470.CODICE, T470.DESCRIZIONE '
      'FROM T470_QUALIFICAMINIST T470, :C700SelAnagrafe'
      ' AND T470.CODICE = T430QUALIFICAMINIST'
      
        ' AND :DataLAVORO BETWEEN T470.DECORRENZA AND T470.DECORRENZA_FIN' +
        'E'
      'ORDER BY 1'
      '')
    ReadBuffer = 200
    Optimize = False
    Variables.Data = {
      04000000030000000C0000003A00440041005400410049000C00000000000000
      00000000200000003A004300370030003000530045004C0041004E0041004700
      5200410046004500010000000000000000000000160000003A00440041005400
      41004C00410056004F0052004F000C0000000000000000000000}
    Left = 116
    Top = 16
  end
  object QTipiRapporto: TOracleDataSet
    SQL.Strings = (
      'select * '
      'from t450_tiporapporto '
      'where Tipo is not null'
      'order by codice')
    ReadBuffer = 200
    Optimize = False
    Left = 40
    Top = 12
  end
end
