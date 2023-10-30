inherited WP684FDefinizioneFondiDM: TWP684FDefinizioneFondiDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT P684.*,P684.ROWID, P680.DESCRIZIONE DESC_MACROCATEG'
      'FROM P684_FONDI P684, P680_FONDIMACROCATEG P680'
      'WHERE P684.COD_MACROCATEG = P680.COD_MACROCATEG(+)'
      ':ORDERBY')
    object selTabellaCOD_FONDO: TStringField
      DisplayLabel = 'Cod. fondo'
      FieldName = 'COD_FONDO'
      Required = True
      Size = 15
    end
    object selTabellaDECORRENZA_DA: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Decorrenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA_DA'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaDECORRENZA_A: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Scadenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA_A'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 500
    end
    object selTabellaCOD_MACROCATEG: TStringField
      DisplayLabel = 'Cod. macrocateg.'
      FieldName = 'COD_MACROCATEG'
      Size = 5
    end
    object selTabellaDESC_MACROCATEG: TStringField
      DisplayLabel = 'Macrocategoria'
      FieldName = 'DESC_MACROCATEG'
      Size = 50
    end
    object selTabellaCOD_RAGGR: TStringField
      DisplayLabel = 'Cod. raggrupp.'
      FieldName = 'COD_RAGGR'
      Size = 15
    end
    object selTabellaDATA_COSTITUZ: TDateTimeField
      DisplayLabel = 'Data costituz.'
      DisplayWidth = 10
      FieldName = 'DATA_COSTITUZ'
      Visible = False
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaFILTRO_DIPENDENTI: TStringField
      DisplayLabel = 'Filtro dipendenti'
      FieldName = 'FILTRO_DIPENDENTI'
      Visible = False
      Size = 500
    end
    object selTabellaDATA_ULTIMO_MONIT: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Data ultimo monit.'
      DisplayWidth = 10
      FieldName = 'DATA_ULTIMO_MONIT'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaNOTE: TStringField
      DisplayLabel = 'Note'
      FieldName = 'NOTE'
      Visible = False
      Size = 4000
    end
  end
end
