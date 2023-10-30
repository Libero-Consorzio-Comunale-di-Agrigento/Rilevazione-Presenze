inherited S715FStampaValutazioniMW: TS715FStampaValutazioniMW
  OldCreateOrder = True
  Height = 336
  Width = 786
  object selSG746: TOracleDataSet
    SQL.Strings = (
      
        'SELECT CODREGOLA, CODICE, DESCRIZIONE, VAL_INTERM_OBBLIGATORIA, ' +
        'CREA_AUTOVALUTAZIONE'
      'FROM SG746_STATI_AVANZAMENTO S1'
      'WHERE DECORRENZA = (SELECT MAX(DECORRENZA)'
      '                    FROM SG746_STATI_AVANZAMENTO S2'
      '                    WHERE S2.CODREGOLA = S1.CODREGOLA'
      '                    AND S2.CODICE = S1.CODICE'
      '                    AND S2.DECORRENZA <= :DECORRENZA_FINE'
      '                    AND S2.DECORRENZA_FINE >= :DECORRENZA)'
      'ORDER BY CODREGOLA, CODICE')
    Optimize = False
    Variables.Data = {
      0400000002000000200000003A004400450043004F005200520045004E005A00
      41005F00460049004E0045000C0000000000000000000000160000003A004400
      450043004F005200520045004E005A0041000C0000000000000000000000}
    Left = 616
    Top = 16
  end
  object selSG750: TOracleDataSet
    SQL.Strings = (
      'SELECT *'
      'FROM SG750_PARPROTOCOLLO'
      'WHERE (CODICE = :CODICE OR :CODICE IS NULL)'
      'ORDER BY CODICE')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 664
    Top = 16
  end
  object selSG751: TOracleDataSet
    SQL.Strings = (
      'SELECT *'
      'FROM SG751_PARPROTOCOLLODATI'
      'WHERE (CODICE = :CODICE OR :CODICE IS NULL)'
      'ORDER BY CODICE, ORDINE')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 712
    Top = 16
  end
  object selT765: TOracleDataSet
    SQL.Strings = (
      'select * from t765_tipoquote T765'
      'where tipoquota in ('#39'I'#39','#39'V'#39','#39'C'#39','#39'D'#39','#39'N'#39')'
      '  and decorrenza = (select max(decorrenza) from t765_tipoquote'
      '                     where codice = T765.codice)'
      'order by codice'
      '')
    Optimize = False
    Left = 111
    Top = 208
  end
end
