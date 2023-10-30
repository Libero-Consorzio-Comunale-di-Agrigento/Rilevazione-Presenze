inherited WA121FOrganizzSindacaliDM: TWA121FOrganizzSindacaliDM
  Height = 130
  Width = 312
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T240.*,T240.ROWID '
      'FROM T240_ORGANIZZAZIONISINDACALI T240'
      ':ORDERBY')
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Required = True
      OnValidate = selTabellaCODICEValidate
      Size = 10
    end
    object selTabellaDECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
      Required = True
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selTabellaCOD_MINISTERIALE: TStringField
      DisplayLabel = 'Cod. ministeriale'
      DisplayWidth = 11
      FieldName = 'COD_MINISTERIALE'
      Size = 11
    end
    object selTabellaCOD_REGIONALE: TStringField
      DisplayLabel = 'Cod.regionale'
      FieldName = 'COD_REGIONALE'
      Size = 4
    end
    object selTabellaFILTRO: TStringField
      DisplayLabel = 'Filtro'
      FieldName = 'FILTRO'
      Size = 500
    end
    object selTabellaRAGGRUPPAMENTO: TStringField
      DisplayLabel = 'Raggruppamento'
      FieldName = 'RAGGRUPPAMENTO'
      OnValidate = selTabellaRAGGRUPPAMENTOValidate
      Size = 1
    end
    object selTabellaSINDACATI_RAGGRUPPATI: TStringField
      DisplayLabel = 'Sindacati raggruppati'
      FieldName = 'SINDACATI_RAGGRUPPATI'
      Size = 200
    end
    object selTabellaRSU: TStringField
      FieldName = 'RSU'
      OnValidate = selTabellaRSUValidate
      Size = 1
    end
    object selTabellaVOCEPAGHE: TStringField
      DisplayLabel = 'Voce paghe'
      FieldName = 'VOCEPAGHE'
      Size = 6
    end
    object selTabellaCAUSALE_COMPETENZE: TStringField
      DisplayLabel = 'Causale assenza'
      FieldName = 'CAUSALE_COMPETENZE'
      Visible = False
      Size = 5
    end
    object selTabellaCAUSALE_COMPETENZE_NO: TStringField
      DisplayLabel = 'Causale fuori competenza'
      FieldName = 'CAUSALE_COMPETENZE_NO'
      Visible = False
      Size = 5
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
