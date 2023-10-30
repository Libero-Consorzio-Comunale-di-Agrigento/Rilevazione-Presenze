inherited WA168FIncentiviMaturatiDM: TWA168FIncentiviMaturatiDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select T762.*,T762.rowid '
      'from T762_INCENTIVIMATURATI T762'
      'where PROGRESSIVO = :PROGRESSIVO'
      ':FILTRO'
      ':ORDERBY')
    Variables.Data = {
      0400000003000000100000003A004F0052004400450052004200590001000000
      00000000000000000E0000003A00460049004C00540052004F00010000000000
      000000000000180000003A00500052004F004700520045005300530049005600
      4F00030000000000000000000000}
    BeforeDelete = BeforeDelete
    OnCalcFields = selTabellaCalcFields
    OnNewRecord = OnNewRecord
    object selTabellaPROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selTabellaANNO: TFloatField
      DisplayLabel = 'Anno'
      DisplayWidth = 4
      FieldName = 'ANNO'
      Required = True
      DisplayFormat = '!0000.;'
    end
    object selTabellaMESE: TFloatField
      DisplayLabel = 'Mese'
      DisplayWidth = 2
      FieldName = 'MESE'
      Required = True
    end
    object selTabellaDesc_Mese: TStringField
      DisplayLabel = ' '
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'Desc_Mese'
      Calculated = True
    end
    object selTabellaCODTIPOQUOTA: TStringField
      DisplayLabel = 'Quota'
      FieldName = 'CODTIPOQUOTA'
      Required = True
      Size = 5
    end
    object selTabellaDesc_Quota: TStringField
      DisplayLabel = ' '
      DisplayWidth = 30
      FieldKind = fkLookup
      FieldName = 'Desc_Quota'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CODTIPOQUOTA'
      Size = 50
      Lookup = True
    end
    object selTabellaTipologia_Quota: TStringField
      DisplayLabel = ' '
      FieldKind = fkLookup
      FieldName = 'Tipologia_Quota'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'TIPOQUOTA'
      KeyFields = 'CODTIPOQUOTA'
      Size = 1
      Lookup = True
    end
    object selTabellaTIPOIMPORTO: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPOIMPORTO'
      Required = True
      Size = 5
    end
    object selTabellaDesc_Importo: TStringField
      DisplayLabel = ' '
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'Desc_Importo'
      Size = 30
      Calculated = True
    end
    object selTabellaIMPORTO: TFloatField
      DisplayLabel = 'Importo'
      FieldName = 'IMPORTO'
      ReadOnly = True
      DisplayFormat = '###,###,###,##0.#####'
    end
    object selTabellaVARIAZIONI: TFloatField
      DisplayLabel = 'Var. Importo'
      FieldName = 'VARIAZIONI'
    end
    object selTabellaGIORNI_ORE: TFloatField
      DisplayLabel = 'Giorni/Ore'
      FieldName = 'GIORNI_ORE'
      ReadOnly = True
      Visible = False
    end
    object selTabellaDescGiorniOre: TStringField
      DisplayLabel = 'Giorni/Ore'
      FieldKind = fkCalculated
      FieldName = 'DescGiorniOre'
      ReadOnly = True
      Size = 7
      Calculated = True
    end
    object selTabellaRisparmio: TStringField
      FieldKind = fkLookup
      FieldName = 'Risparmio'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'RISPARMIO_BILANCIO'
      KeyFields = 'TIPOIMPORTO'
      Visible = False
      Size = 1
      Lookup = True
    end
    object selTabellaTIPOCALCOLO: TStringField
      FieldName = 'TIPOCALCOLO'
      Visible = False
      Size = 1
    end
  end
  object dsrT763: TDataSource
    Left = 104
    Top = 64
  end
end
