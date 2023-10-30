inherited WA206FCodiciCondizioniTurniDM: TWA206FCodiciCondizioniTurniDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select T605.*'
      'from T605_CODICICONDIZIONI T605'
      ':ORDERBY')
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Size = 5
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selTabellaGENERALE: TStringField
      DisplayLabel = 'Gen.'
      FieldName = 'GENERALE'
      Size = 1
    end
    object selTabellaINDIVIDUALE: TStringField
      DisplayLabel = 'Ind.'
      FieldName = 'INDIVIDUALE'
      Size = 1
    end
    object selTabellaSQUADRA_ABILITA: TStringField
      DisplayLabel = 'Sq A'
      FieldName = 'SQUADRA_ABILITA'
      Size = 1
    end
    object selTabellaTIPOOPE_ABILITA: TStringField
      DisplayLabel = 'Op A'
      FieldName = 'TIPOOPE_ABILITA'
      Size = 1
    end
    object selTabellaORARIO_ABILITA: TStringField
      DisplayLabel = 'Or A'
      FieldName = 'ORARIO_ABILITA'
      Size = 1
    end
    object selTabellaTURNO_ABILITA: TStringField
      DisplayLabel = 'Sg A'
      FieldName = 'TURNO_ABILITA'
      Size = 1
    end
    object selTabellaGIORNO_ABILITA: TStringField
      DisplayLabel = 'Gg A'
      FieldName = 'GIORNO_ABILITA'
      Size = 1
    end
    object selTabellaMINIMO_ABILITA: TStringField
      DisplayLabel = 'Mn A'
      FieldName = 'MINIMO_ABILITA'
      Size = 1
    end
    object selTabellaMINIMO_OBBLIGA: TStringField
      DisplayLabel = 'Mn O'
      FieldName = 'MINIMO_OBBLIGA'
      Size = 1
    end
    object selTabellaOTTIMALE_ABILITA: TStringField
      DisplayLabel = 'Ot A'
      FieldName = 'OTTIMALE_ABILITA'
      Size = 1
    end
    object selTabellaOTTIMALE_OBBLIGA: TStringField
      DisplayLabel = 'Ot O'
      FieldName = 'OTTIMALE_OBBLIGA'
      Size = 1
    end
    object selTabellaMASSIMO_ABILITA: TStringField
      DisplayLabel = 'Mx A'
      FieldName = 'MASSIMO_ABILITA'
      Size = 1
    end
    object selTabellaMASSIMO_OBBLIGA: TStringField
      DisplayLabel = 'Mx O'
      FieldName = 'MASSIMO_OBBLIGA'
      Size = 1
    end
    object selTabellaVALORE_ABILITA: TStringField
      DisplayLabel = 'Vr A'
      FieldName = 'VALORE_ABILITA'
      Size = 1
    end
    object selTabellaVALORE_OBBLIGA: TStringField
      DisplayLabel = 'Vr O'
      FieldName = 'VALORE_OBBLIGA'
      Size = 1
    end
    object selTabellaVALORE_TIPO: TStringField
      DisplayLabel = 'Vr Tipo'
      FieldName = 'VALORE_TIPO'
      Size = 4
    end
  end
end
