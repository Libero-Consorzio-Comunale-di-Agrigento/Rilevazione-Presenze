inherited WP684FGrigliaDettDefinizioneFondiDM: TWP684FGrigliaDettDefinizioneFondiDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      
        'select P690.*, P690.rowid, T030.COGNOME, T030.NOME, T030.MATRICO' +
        'LA, P430.COD_POSIZIONE_ECONOMICA'
      
        'from P690_FONDISPESO P690, T030_ANAGRAFICO T030, P430_ANAGRAFICO' +
        ' P430'
      'where P690.cod_fondo = :COD'
      'and P690.decorrenza_da = :DEC'
      'and P690.class_voce = '#39'D'#39
      'and P690.PROGRESSIVO = T030.PROGRESSIVO (+)'
      
        'and P690.PROGRESSIVO = P430.PROGRESSIVO (+) and P690.DATA_RETRIB' +
        'UZIONE between P430.DECORRENZA (+) and P430.DECORRENZA_FINE (+)'
      ':CODGEN'
      ':CODDET'
      ':ORDERBY')
    Variables.Data = {
      0400000005000000100000003A004F0052004400450052004200590001000000
      0000000000000000080000003A0043004F004400050000000000000000000000
      080000003A004400450043000C00000000000000000000000E0000003A004300
      4F004400470045004E000100000000000000000000000E0000003A0043004F00
      4400440045005400010000000000000000000000}
    AfterDelete = AfterDelete
    OnCalcFields = selTabellaCalcFields
    OnNewRecord = OnNewRecord
    object selTabellaPROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      ReadOnly = True
      Visible = False
    end
    object selTabellaMATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldName = 'MATRICOLA'
      ReadOnly = True
      Size = 8
    end
    object selTabellaCOGNOME: TStringField
      DisplayLabel = 'Cognome'
      FieldName = 'COGNOME'
      ReadOnly = True
      Size = 50
    end
    object selTabellaNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      ReadOnly = True
      Size = 50
    end
    object selTabellaCOD_POSIZIONE_ECONOMICA: TStringField
      DisplayLabel = 'Posiz. economica'
      FieldName = 'COD_POSIZIONE_ECONOMICA'
      ReadOnly = True
      Size = 5
    end
    object selTabellaCOD_FONDO: TStringField
      DisplayLabel = 'Cod. fondo'
      FieldName = 'COD_FONDO'
      ReadOnly = True
      Visible = False
      Size = 15
    end
    object selTabellaDECORRENZA_DA: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA_DA'
      ReadOnly = True
      Visible = False
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = #39'!00/00/0000;1;_'
    end
    object selTabellaCLASS_VOCE: TStringField
      DisplayLabel = 'Classificaz. voce'
      FieldName = 'CLASS_VOCE'
      ReadOnly = True
      Visible = False
      Size = 1
    end
    object selTabellaCOD_VOCE_GEN: TStringField
      DisplayLabel = 'Voce gen.'
      FieldName = 'COD_VOCE_GEN'
      ReadOnly = True
      Visible = False
      Size = 5
    end
    object selTabellaCOD_VOCE_DET: TStringField
      DisplayLabel = 'Cod. dett.'
      FieldName = 'COD_VOCE_DET'
      ReadOnly = True
      Visible = False
      Size = 5
    end
    object selTabellaDATA_RETRIBUZIONE: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Mese retribuzione'
      FieldName = 'DATA_RETRIBUZIONE'
      DisplayFormat = 'mm/yyyy'
      EditMask = '!00/0000;1;_'
    end
    object selTabellaCOD_CONTRATTO: TStringField
      DisplayLabel = 'Contratto voci'
      FieldName = 'COD_CONTRATTO'
      Size = 5
    end
    object selTabellaCOD_VOCE: TStringField
      DisplayLabel = 'Codice voce'
      FieldName = 'COD_VOCE'
      Size = 5
    end
    object selTabellaDescrizione: TStringField
      FieldKind = fkCalculated
      FieldName = 'Descrizione'
      ReadOnly = True
      Size = 40
      Calculated = True
    end
    object selTabellaIMPORTO: TFloatField
      DisplayLabel = 'Importo'
      FieldName = 'IMPORTO'
      DisplayFormat = '###,###,###,##0.00'
    end
  end
end
