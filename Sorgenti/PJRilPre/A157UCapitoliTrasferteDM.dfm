inherited A157FCapitoliTrasferteDM: TA157FCapitoliTrasferteDM
  OldCreateOrder = True
  Height = 115
  Width = 129
  object selM030: TOracleDataSet
    SQL.Strings = (
      
        'select M030.CODICE, M030.DESCRIZIONE, M030.DECORRENZA, M030.DECO' +
        'RRENZA_FINE, M030.FILTRO_ANAGRAFE, M030.TIPO_MISSIONE, M030.ROWI' +
        'D'
      '  from M030_CAPITOLI_TRASFERTA M030'
      ' order by M030.CODICE, M030.DECORRENZA')
    Optimize = False
    Left = 40
    Top = 24
    object selM030CODICE: TStringField
      DisplayLabel = 'Codice'
      DisplayWidth = 20
      FieldName = 'CODICE'
    end
    object selM030DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 50
      FieldName = 'DESCRIZIONE'
      Size = 100
    end
    object selM030DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA'
      EditMask = '!00/00/0000;1;_'
    end
    object selM030DECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Scadenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA_FINE'
      EditMask = '!00/00/0000;1;_'
    end
    object selM030FILTRO_ANAGRAFE: TStringField
      DisplayLabel = 'Filtro anagrafe'
      DisplayWidth = 5
      FieldName = 'FILTRO_ANAGRAFE'
      Size = 2000
    end
    object selM030TIPO_MISSIONE: TStringField
      DisplayLabel = 'Tipi missione'
      DisplayWidth = 20
      FieldName = 'TIPO_MISSIONE'
      Visible = False
      Size = 1000
    end
  end
end
