inherited WM019FModelloCertificazioneMW: TWM019FModelloCertificazioneMW
  OldCreateOrder = True
  Height = 277
  Width = 356
  object selSG236SG237: TOracleDataSet
    SQL.Strings = (
      'select'
      
        '  SG236.ID, SG236.CODICE COD_CAT, SG236.DESCRIZIONE DESC_CAT, SG' +
        '236.ORDINE ORDINE_CAT,'
      
        '  SG237.CODICE COD_DATO, SG237.DESCRIZIONE DESC_DATO, SG237.ORDI' +
        'NE ORDINE_DATO,'
      
        '  SG237.OBBLIGATORIO, SG237.RIGHE, SG237.FORMATO, SG237.LUNG_MAX' +
        ', SG237.VALORI, SG237.DATO_ANAGRAFICO,'
      
        '  SG237.QUERY_VALORE, SG237.ELENCO_FISSO, SG237.VALORE_DEFAULT, ' +
        'SG237.HINT'
      'from'
      
        '  SG236_CATEGORIE_CERTIFICAZIONI SG236, SG237_DATI_CERTIFICAZION' +
        'I SG237'
      'where'
      '  SG236.ID = :ID'
      '  and SG237.ID = SG236.ID'
      '  and SG237.CATEGORIA = SG236.CODICE'
      'order by'
      '  SG236.ORDINE, SG236.CODICE, SG237.ORDINE, SG237.CODICE')
    Optimize = False
    Variables.Data = {
      0400000001000000060000003A00490044000300000004000000000000000000
      0000}
    UpdatingTable = 'T105_RICHIESTETIMBRATURE'
    CommitOnPost = False
    Left = 89
    Top = 17
  end
  object selSG235: TOracleDataSet
    SQL.Strings = (
      'select'
      '  SG235.*'
      'from'
      '  SG235_MODELLI_CERTIFICAZIONI SG235'
      'where '
      '  SG235.CODICE = :COD_MODELLO')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A0043004F0044005F004D004F00440045004C00
      4C004F00050000000000000000000000}
    CommitOnPost = False
    Left = 16
    Top = 17
  end
  object selQueryValore: TOracleQuery
    SQL.Strings = (
      
        'select concatena_testo('#39'select riga from t002_querypersonalizzat' +
        'e where nome = '#39#39#39' || :nome || '#39#39#39' and applicazione = '#39#39'RILPRE'#39#39 +
        ' and posiz >= 0 order by posiz'#39','#39' '#39') '
      'from   dual')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A004E004F004D00450005000000000000000000
      0000}
    Left = 175
    Top = 16
  end
  object selDatoLibero: TOracleDataSet
    ReadBuffer = 200
    Optimize = False
    Left = 258
    Top = 17
  end
  object selSG231: TOracleDataSet
    SQL.Strings = (
      'select ID, CODICE, VALORE, ROWID'
      'from   SG231_VALORI_CERTIFICAZIONI SG231'
      'where ID = :ID'
      'order by CODICE'
      ''
      '/*select ID, CODICE, VALORE, ROWID'
      'from   SG231_VALORI_CERTIFICAZIONI SG231'
      'order by ID, CODICE*/')
    ReadBuffer = 500
    Optimize = False
    Variables.Data = {
      0400000001000000060000003A00490044000400000008000000000000000000
      000000000000}
    UpdatingTable = 'sg231_valori_certificazioni'
    Left = 18
    Top = 73
  end
  object insSG231: TOracleQuery
    SQL.Strings = (
      
        'insert into SG231_VALORI_CERTIFICAZIONI values (:ID, :CODICE, :V' +
        'ALORE)')
    Optimize = False
    Variables.Data = {
      0400000003000000060000003A00490044000300000000000000000000000E00
      00003A0043004F0044004900430045000500000000000000000000000E000000
      3A00560041004C004F0052004500050000000000000000000000}
    Left = 88
    Top = 72
  end
end
