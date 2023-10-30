inherited WA089FRegIndPresenzaDM: TWA089FRegIndPresenzaDM
  Height = 294
  Width = 622
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T162.*,T162.ROWID '
      '  FROM T162_INDENNITA T162'
      '  :ORDERBY')
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    OnNewRecord = OnNewRecord
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Origin = 'T162_INDENNITA.CODICE'
      OnValidate = selTabellaCODICEValidate
      Size = 5
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Origin = 'T162_INDENNITA.DESCRIZIONE'
      Size = 40
    end
    object selTabellaIMPORTO: TFloatField
      DisplayLabel = 'Importo'
      FieldName = 'IMPORTO'
      Origin = 'T162_INDENNITA.IMPORTO'
      currency = True
    end
    object selTabellaVOCEPAGHE: TStringField
      DisplayLabel = 'Voce paghe'
      FieldName = 'VOCEPAGHE'
      Origin = 'T162_INDENNITA.VOCEPAGHE'
      Size = 6
    end
    object selTabellaTIPO: TStringField
      DisplayLabel = 'Tipologia'
      FieldName = 'TIPO'
      Origin = 'T162_INDENNITA.TIPO'
      Size = 1
    end
    object selTabellaNUMTURNI: TFloatField
      FieldName = 'NUMTURNI'
      Origin = 'T162_INDENNITA.NUMTURNI'
      Visible = False
    end
    object selTabellaTURNI: TStringField
      FieldName = 'TURNI'
      Origin = 'T162_INDENNITA.TURNI'
      Visible = False
      Size = 4
    end
    object selTabellaASSENZE: TStringField
      FieldName = 'ASSENZE'
      Origin = 'T162_INDENNITA.ASSENZE'
      Visible = False
      Size = 1000
    end
    object selTabellaCODICE2: TStringField
      DisplayLabel = 'Indennit'#224' secondaria'
      FieldName = 'CODICE2'
      Origin = 'T162_INDENNITA.CODICE2'
      Size = 5
    end
    object selTabellaTURNO1: TFloatField
      FieldName = 'TURNO1'
      Visible = False
    end
    object selTabellaTURNO2: TFloatField
      FieldName = 'TURNO2'
      Visible = False
    end
    object selTabellaTURNO3: TFloatField
      FieldName = 'TURNO3'
      Visible = False
    end
    object selTabellaTURNO4: TFloatField
      FieldName = 'TURNO4'
      Visible = False
    end
    object selTabellaPRIORITA: TIntegerField
      DisplayLabel = 'Priorita'
      FieldName = 'PRIORITA'
    end
    object selTabellaINDENNITA_INCOMPATIBILI: TStringField
      FieldName = 'INDENNITA_INCOMPATIBILI'
      Visible = False
      Size = 200
    end
    object selTabellaCOEFFICIENTE: TFloatField
      FieldName = 'COEFFICIENTE'
      Visible = False
    end
    object selTabellaARROTONDAMENTO: TStringField
      FieldName = 'ARROTONDAMENTO'
      Visible = False
      Size = 1
    end
    object selTabellaASSENZE_ABILITATE: TStringField
      FieldName = 'ASSENZE_ABILITATE'
      Visible = False
      Size = 1000
    end
    object selTabellaSUPPL_5GGLAV: TStringField
      FieldName = 'SUPPL_5GGLAV'
      Visible = False
      Size = 1
    end
    object selTabellaCAUPRES_RIEPORE: TStringField
      FieldName = 'CAUPRES_RIEPORE'
      Visible = False
      Size = 5
    end
    object selTabellaD_CAUPRES_RIEPORE: TStringField
      FieldKind = fkLookup
      FieldName = 'D_CAUPRES_RIEPORE'
      LookupDataSet = selT275Escluse
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAUPRES_RIEPORE'
      Visible = False
      Size = 40
      Lookup = True
    end
    object selTabellaNMESI_EQUITURNI: TFloatField
      FieldName = 'NMESI_EQUITURNI'
      Visible = False
    end
    object selTabellaOFFSET_METADEBITO: TIntegerField
      FieldName = 'OFFSET_METADEBITO'
      Visible = False
    end
    object selTabellaMATURA_SABATO: TStringField
      FieldName = 'MATURA_SABATO'
      Visible = False
      Size = 1
    end
    object selTabellaPIANIF_NOOP: TStringField
      FieldName = 'PIANIF_NOOP'
      Visible = False
      Size = 1
    end
    object selTabellaMIN_TURNI_PRIORITARI: TStringField
      FieldName = 'MIN_TURNI_PRIORITARI'
      Visible = False
      Size = 2000
    end
    object selTabellaMIN_TURNI_SECONDARI: TStringField
      FieldName = 'MIN_TURNI_SECONDARI'
      Visible = False
      Size = 2000
    end
    object selTabellaOFFSET_GGPREC: TStringField
      FieldName = 'OFFSET_GGPREC'
      Visible = False
      Size = 5
    end
    object selTabellaESCLUDI_FESTIVI: TStringField
      FieldName = 'ESCLUDI_FESTIVI'
      Visible = False
      Size = 1
    end
    object selTabellaMATURAZ_PROP_DEBITOGG: TStringField
      FieldName = 'MATURAZ_PROP_DEBITOGG'
      Visible = False
      Size = 1
    end
    object selTabellaMATURAZ_PROP_IGNORA_SCOSTNEG: TStringField
      FieldName = 'MATURAZ_PROP_IGNORA_SCOSTNEG'
      Visible = False
      Size = 1
    end
    object selTabellaCONGUAGLIO_EQUITURNI: TStringField
      FieldName = 'CONGUAGLIO_EQUITURNI'
      Size = 1
    end
  end
  object selT275: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE FROM T275_CAUPRESENZE '
      'ORDER BY CODICE')
    Optimize = False
    Left = 424
    Top = 120
  end
  object selT275Escluse: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE FROM T275_CAUPRESENZE '
      'WHERE ORENORMALI = '#39'A'#39
      'ORDER BY CODICE')
    Optimize = False
    Left = 488
    Top = 120
    object selT275EscluseCODICE: TStringField
      DisplayWidth = 7
      FieldName = 'CODICE'
      Size = 5
    end
    object selT275EscluseDESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
  object dsrT275Escluse: TDataSource
    DataSet = selT275Escluse
    Left = 564
    Top = 120
  end
  object SelQ162: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,CODICE2 FROM T162_INDENNITA T162'
      'WHERE CODICE=:CODICE')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000110000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000000E00
      000049004D0050004F00520054004F000100000000001200000056004F004300
      450050004100470048004500010000000000080000005400490050004F000100
      00000000100000004E0055004D005400550052004E0049000100000000000A00
      00005400550052004E0049000100000000000E00000041005300530045004E00
      5A0045000100000000000E00000043004F004400490043004500320001000000
      00000C0000005400550052004E004F0031000100000000000C00000054005500
      52004E004F0032000100000000000C0000005400550052004E004F0033000100
      000000000C0000005400550052004E004F003400010000000000100000005000
      520049004F0052004900540041000100000000002E00000049004E0044004500
      4E004E004900540041005F0049004E0043004F004D0050004100540049004200
      49004C0049000100000000001800000043004F00450046004600490043004900
      45004E00540045000100000000001C0000004100520052004F0054004F004E00
      440041004D0045004E0054004F00010000000000}
    Left = 424
    Top = 168
  end
  object selT162Incomp: TOracleDataSet
    SQL.Strings = (
      
        'SELECT CODICE,DESCRIZIONE FROM T162_INDENNITA WHERE CODICE <> :C' +
        'ODICE'
      'ORDER BY CODICE')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 352
    Top = 164
    object StringField1: TStringField
      FieldName = 'CODICE'
      Size = 5
    end
    object StringField2: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
  object D162: TDataSource
    DataSet = Look162
    Left = 292
    Top = 164
  end
  object Look162: TOracleDataSet
    SQL.Strings = (
      
        'SELECT CODICE,DESCRIZIONE FROM T162_INDENNITA WHERE CODICE <> :C' +
        'ODICE'
      'AND TIPO IN ('#39'A'#39','#39'B'#39','#39'C'#39','#39'D'#39','#39'E'#39','#39'I'#39','#39'P'#39')'
      'ORDER BY CODICE')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 256
    Top = 164
    object Look162CODICE: TStringField
      DisplayWidth = 7
      FieldName = 'CODICE'
      Size = 5
    end
    object Look162DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
  object Q265: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE FROM T265_CAUASSENZE '
      'ORDER BY CODICE')
    Optimize = False
    Left = 208
    Top = 164
  end
  object dsrT164: TDataSource
    DataSet = selT164
    Left = 151
    Top = 121
  end
  object selT164: TOracleDataSet
    SQL.Strings = (
      'select T164.*, T164.ROWID'
      'from T164_ASSOCIAZIONIINDENNITA T164'
      'where CODICE = :CODICE'
      ' :ORDERBY')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A0043004F004400490043004500050000000000
      000000000000100000003A004F00520044004500520042005900010000000000
      000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000040000000C00000043004F0044004900430045000100000000001400
      00004400450043004F005200520045004E005A00410001000000000016000000
      450053005000520045005300530049004F004E00450001000000000010000000
      530043004100440045004E005A004100010000000000}
    OnNewRecord = selT164NewRecord
    Left = 110
    Top = 121
    object selT164CODICE: TStringField
      FieldName = 'CODICE'
      Required = True
      Visible = False
      Size = 5
    end
    object selT164TIPO_ASSOCIAZIONE: TStringField
      DisplayLabel = 'Tipo'
      DisplayWidth = 5
      FieldName = 'TIPO_ASSOCIAZIONE'
      Size = 1
    end
    object selT164DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
      Required = True
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!99/99/0000;1;_'
    end
    object selT164SCADENZA: TDateTimeField
      DisplayLabel = 'Scadenza'
      FieldName = 'SCADENZA'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!99/99/0000;1;_'
    end
    object selT164ESPRESSIONE: TStringField
      DisplayLabel = 'Espressione'
      FieldName = 'ESPRESSIONE'
      Required = True
      Size = 2000
    end
  end
  object dsrT171: TDataSource
    DataSet = selT171
    Left = 48
    Top = 170
  end
  object selT171: TOracleDataSet
    SQL.Strings = (
      'SELECT T171.*,T171.ROWID FROM T171_LIMITI T171'
      'WHERE CODICE = :CODICE'
      ':ORDERBY'
      '')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A0043004F004400490043004500050000000000
      000000000000100000003A004F00520044004500520042005900010000000000
      000000000000}
    CachedUpdates = True
    OnNewRecord = selT171NewRecord
    Left = 20
    Top = 170
    object selT171CODICE: TStringField
      FieldName = 'CODICE'
      Origin = 'T171_LIMITI.CODICE'
      Required = True
      Visible = False
      Size = 5
    end
    object selT171GIORNI: TFloatField
      DisplayLabel = 'Giorni'
      FieldName = 'GIORNI'
      Origin = 'T171_LIMITI.GIORNI'
      Required = True
    end
    object selT171ESPRESSIONE: TStringField
      DisplayLabel = 'Espressione'
      FieldName = 'ESPRESSIONE'
      Origin = 'T171_LIMITI.ESPRESSIONE'
      Required = True
      Size = 40
    end
  end
  object Del171: TOracleQuery
    SQL.Strings = (
      'DELETE FROM T171_LIMITI WHERE CODICE = :CODICE')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 20
    Top = 216
  end
  object Upd171: TOracleQuery
    SQL.Strings = (
      'UPDATE T171_LIMITI SET CODICE = :CODICENEW'
      'WHERE CODICE = :CODICEOLD')
    Optimize = False
    Variables.Data = {
      0400000002000000140000003A0043004F0044004900430045004E0045005700
      050000000000000000000000140000003A0043004F0044004900430045004F00
      4C004400050000000000000000000000}
    Left = 60
    Top = 216
  end
  object delT164: TOracleQuery
    SQL.Strings = (
      'delete '
      'from T164_ASSOCIAZIONIINDENNITA'
      'where CODICE = :CODICE')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 108
    Top = 216
  end
  object updT164: TOracleQuery
    SQL.Strings = (
      'update T164_ASSOCIAZIONIINDENNITA '
      'set CODICE = :CODICENEW'
      'where CODICE = :CODICEOLD')
    Optimize = False
    Variables.Data = {
      0400000002000000140000003A0043004F0044004900430045004E0045005700
      050000000000000000000000140000003A0043004F0044004900430045004F00
      4C004400050000000000000000000000}
    Left = 152
    Top = 216
  end
  object selI010: TOracleDataSet
    SQL.Strings = (
      
        'SELECT REPLACE(NOME_CAMPO,'#39'T430'#39','#39#39') NOME_CAMPO, NOME_LOGICO, TA' +
        'BLE_NAME'
      'FROM I010_CAMPIANAGRAFICI, COLS'
      'WHERE '
      '  REPLACE(NOME_CAMPO,'#39'T430'#39','#39#39') = COLUMN_NAME AND '
      '  TABLE_NAME IN ('#39'T430_STORICO'#39','#39'T030_ANAGRAFICO'#39') AND '
      '  COLUMN_NAME NOT IN ('#39'PROGRESSIVO'#39','#39'DATADECORRENZA'#39','#39'DATAFINE'#39')'
      'ORDER BY TABLE_NAME, NOME_LOGICO ')
    Optimize = False
    Left = 212
    Top = 220
  end
  object dsrI010: TDataSource
    DataSet = selI010
    Left = 260
    Top = 220
  end
  object selSQL: TOracleDataSet
    Optimize = False
    Left = 308
    Top = 224
  end
  object testSQL: TOracleQuery
    Optimize = False
    Left = 352
    Top = 224
  end
end
