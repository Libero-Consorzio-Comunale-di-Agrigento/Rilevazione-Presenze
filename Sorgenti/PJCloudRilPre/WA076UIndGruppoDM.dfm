inherited WA076FIndGruppoDM: TWA076FIndGruppoDM
  Height = 170
  Width = 332
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      
        'select T161.DECORRENZA, T161.CODICE, T161.CODICE2, T161.INDENNIT' +
        'A, T161.ROWID '
      '  from T161_INDGRUPPO T161 '
      ' :ORDERBY')
    object selTabellaDECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      DisplayWidth = 12
      FieldName = 'DECORRENZA'
    end
    object selTabellaCODICE: TStringField
      FieldName = 'CODICE'
      OnValidate = selTabellaCODICEValidate
    end
    object selTabellaD_DescCodice: TStringField
      DisplayLabel = 'Descrizione'
      FieldKind = fkLookup
      FieldName = 'D_DescCodice'
      LookupDataSet = A076FIndGRuppoMW.selCodice1
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CODICE'
      ReadOnly = True
      Size = 40
      Lookup = True
    end
    object selTabellaCODICE2: TStringField
      FieldName = 'CODICE2'
      OnValidate = selTabellaCODICEValidate
    end
    object selTabellaD_DescCodice2: TStringField
      DisplayLabel = 'Descrizione'
      FieldKind = fkLookup
      FieldName = 'D_DescCodice2'
      LookupDataSet = A076FIndGRuppoMW.selCodice2
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CODICE2'
      ReadOnly = True
      Size = 40
      Lookup = True
    end
    object selTabellaINDENNITA: TStringField
      DisplayWidth = 1
      FieldName = 'INDENNITA'
      OnValidate = selTabellaINDENNITAValidate
      Size = 5
    end
    object selTabellaD_CodiceInd: TStringField
      DisplayLabel = 'Indennit'#224
      FieldKind = fkLookup
      FieldName = 'D_CodiceInd'
      LookupDataSet = A076FIndGRuppoMW.Q163
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CODICE'
      KeyFields = 'INDENNITA'
      Visible = False
      Size = 10
      Lookup = True
    end
    object selTabellaD_INDENNITA: TStringField
      DisplayLabel = 'Descrizione'
      FieldKind = fkLookup
      FieldName = 'D_INDENNITA'
      LookupDataSet = A076FIndGRuppoMW.Q163
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'INDENNITA'
      ReadOnly = True
      Size = 40
      Lookup = True
    end
  end
  inherited selEstrazioneDati: TOracleDataSet
    Left = 112
  end
  inherited dsrEstrazioniDati: TDataSource
    Left = 112
  end
  inherited selT900: TOracleDataSet
    Left = 200
  end
  inherited selT901: TOracleDataSet
    Left = 256
  end
end
