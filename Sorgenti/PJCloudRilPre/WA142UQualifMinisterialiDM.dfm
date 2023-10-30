inherited WA142FQualifMinisterialiDM: TWA142FQualifMinisterialiDM
  Height = 182
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T470.*, T470.ROWID FROM T470_QUALIFICAMINIST T470 :ORDERB' +
        'Y')
    AfterPost = AfterPost
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
    end
    object selTabellaDECORRENZA: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Decorrenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaDECORRENZA_FINE: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Scadenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA_FINE'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 100
    end
    object selTabellaPROGRESSIVOQM: TIntegerField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVOQM'
    end
    object selTabellaDEBITOGGQM: TStringField
      DisplayLabel = 'Debito gg.'
      FieldName = 'DEBITOGGQM'
      Size = 5
    end
    object selTabellaMACRO_CATEG_QM: TStringField
      DisplayLabel = 'Macro categoria'
      FieldName = 'MACRO_CATEG_QM'
      Size = 10
    end
  end
end
