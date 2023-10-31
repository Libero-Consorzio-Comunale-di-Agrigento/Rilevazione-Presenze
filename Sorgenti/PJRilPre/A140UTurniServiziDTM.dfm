inherited A140FTurniServiziDTM: TA140FTurniServiziDTM
  OldCreateOrder = True
  Height = 134
  Width = 307
  object selT540: TOracleDataSet
    SQL.Strings = (
      'SELECT T540.*, T540.ROWID'
      '  FROM T540_SERVIZI T540'
      ':WHERE'
      ' ORDER BY T540.CODICE')
    Optimize = False
    Variables.Data = {0300000001000000060000003A5748455245010000000000000000000000}
    OracleDictionary.DefaultValues = True
    BeforeInsert = selT540BeforeInsert
    BeforeEdit = selT540BeforeEdit
    BeforePost = BeforePostNoStorico
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    AfterScroll = selT540AfterScroll
    Left = 96
    Top = 24
    object selT540CODICE: TStringField
      DisplayLabel = 'Codice'
      DisplayWidth = 10
      FieldName = 'CODICE'
      Size = 10
    end
    object selT540DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 40
      FieldName = 'DESCRIZIONE'
      Size = 80
    end
    object selT540COLORE: TStringField
      DisplayLabel = 'Colore sfondo'
      DisplayWidth = 10
      FieldName = 'COLORE'
    end
    object selT540COLOREFONT: TStringField
      DisplayLabel = 'Colore font'
      DisplayWidth = 10
      FieldName = 'COLOREFONT'
    end
    object selT540PADRE: TStringField
      DisplayLabel = 'Servizio padre'
      FieldName = 'PADRE'
      Visible = False
      Size = 10
    end
    object selT540FILTRO_ANAGRAFE: TStringField
      FieldName = 'FILTRO_ANAGRAFE'
    end
  end
  object selT545: TOracleDataSet
    SQL.Strings = (
      
        'select T545.*,T545.rowid from T545_TIPITURNO T545 order by CODIC' +
        'E')
    Optimize = False
    BeforePost = selT545BeforePost
    AfterPost = AfterDelete
    BeforeDelete = BeforeDelete
    AfterDelete = AfterDelete
    AfterScroll = selT540AfterScroll
    Left = 168
    Top = 24
    object selT545CODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Size = 10
    end
    object selT545DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selT545COMANDATO: TStringField
      DisplayLabel = 'Comandato'
      FieldName = 'COMANDATO'
      Size = 1
    end
  end
  object selT530: TOracleDataSet
    SQL.Strings = (
      'SELECT T530.*, T530.ROWID'
      '  FROM T530_CONFIGSERVIZI T530')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      04000000060000000F000000444154415F5052494D4F47474C41560100000000
      000F000000444154415F5052494D4F474746455301000000000010000000414C
      5445524E414E5A415F47474C415601000000000010000000414C5445524E414E
      5A415F47474645530100000000000A0000004747434849555355524101000000
      00000A00000043414C454E444152494F010000000000}
    BeforeInsert = selT530BeforeInsert
    BeforePost = BeforePostNoStorico
    AfterScroll = selT540AfterScroll
    Left = 24
    Top = 24
    object selT530DATA_PRIMOGGLAV: TDateTimeField
      FieldName = 'DATA_PRIMOGGLAV'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selT530DATA_PRIMOGGFES: TDateTimeField
      FieldName = 'DATA_PRIMOGGFES'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selT530ALTERNANZA_GGLAV: TIntegerField
      FieldName = 'ALTERNANZA_GGLAV'
      MaxValue = 999
      MinValue = 1
    end
    object selT530ALTERNANZA_GGFES: TIntegerField
      FieldName = 'ALTERNANZA_GGFES'
      MaxValue = 999
      MinValue = 1
    end
    object selT530GGCHIUSURA: TIntegerField
      FieldName = 'GGCHIUSURA'
    end
    object selT530CALENDARIO: TStringField
      FieldName = 'CALENDARIO'
      Size = 5
    end
    object selT530D_CALENDARIO: TStringField
      FieldKind = fkLookup
      FieldName = 'D_CALENDARIO'
      LookupDataSet = selT010
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CALENDARIO'
      Size = 40
      Lookup = True
    end
  end
  object selT010: TOracleDataSet
    SQL.Strings = (
      'select CODICE,DESCRIZIONE'
      'from T010_CALENDIMPOSTAZ'
      'order by CODICE')
    Optimize = False
    Left = 240
    Top = 24
  end
  object dsrT010: TDataSource
    DataSet = selT010
    Left = 240
    Top = 72
  end
  object selT540SelPadre: TOracleDataSet
    SQL.Strings = (
      'SELECT T540.CODICE, T540.DESCRIZIONE'
      '  FROM T540_SERVIZI T540'
      ' WHERE T540.PADRE IS NULL'
      ' ORDER BY T540.CODICE, T540.DESCRIZIONE')
    Optimize = False
    Left = 96
    Top = 72
  end
  object selI070: TOracleDataSet
    SQL.Strings = (
      'SELECT I070.FILTRO_ANAGRAFE'
      '  FROM MONDOEDP.I070_UTENTI I070'
      ' WHERE I070.AZIENDA = :AZIENDA'
      '   AND I070.UTENTE = :UTENTE')
    Optimize = False
    Variables.Data = {
      0300000002000000080000003A415A49454E4441050000000000000000000000
      070000003A5554454E5445050000000000000000000000}
    Left = 168
    Top = 72
  end
end
