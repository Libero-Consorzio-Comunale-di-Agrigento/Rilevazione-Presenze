inherited WA206FCondizioniTurniDM: TWA206FCondizioniTurniDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      
        'select T030.COGNOME, T030.NOME, T030.MATRICOLA, T606.*, T606.ROW' +
        'ID'
      'from T606_CONDIZIONI T606, T030_ANAGRAFICO T030'
      'where (:PROGRESSIVO = -2 or T606.PROGRESSIVO = :PROGRESSIVO)'
      'and T030.PROGRESSIVO (+) = T606.PROGRESSIVO'
      ':orderby')
    Variables.Data = {
      0400000002000000100000003A004F0052004400450052004200590001000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    BeforePost = BeforePost
    OnCalcFields = selTabellaCalcFields
    OnFilterRecord = selTabellaFilterRecord
    OnNewRecord = OnNewRecord
    object selTabellaMATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldKind = fkInternalCalc
      FieldName = 'MATRICOLA'
      Visible = False
      Size = 8
    end
    object selTabellaCOGNOME: TStringField
      DisplayLabel = 'Cognome'
      FieldKind = fkInternalCalc
      FieldName = 'COGNOME'
      Visible = False
      Size = 50
    end
    object selTabellaNOME: TStringField
      DisplayLabel = 'Nome'
      FieldKind = fkInternalCalc
      FieldName = 'NOME'
      Visible = False
      Size = 50
    end
    object selTabellaPROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selTabellaDECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
      Required = True
      EditMask = '!99/99/0000;1;_'
    end
    object selTabellaDECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Scadenza'
      FieldName = 'DECORRENZA_FINE'
      Required = True
      EditMask = '!99/99/0000;1;_'
    end
    object selTabellaCOD_SQUADRA: TStringField
      DisplayLabel = 'Squadra'
      FieldName = 'COD_SQUADRA'
      Required = True
      Size = 10
    end
    object selTabellaDESC_SQUADRA: TStringField
      DisplayLabel = 'Desc. squadra'
      FieldKind = fkCalculated
      FieldName = 'DESC_SQUADRA'
      Size = 40
      Calculated = True
    end
    object selTabellaCOD_TIPOOPE: TStringField
      DisplayLabel = 'Tipo ope.'
      FieldName = 'COD_TIPOOPE'
      Required = True
      Size = 5
    end
    object selTabellaDESC_TIPOOPE: TStringField
      DisplayLabel = 'Desc. tipo operatore'
      FieldKind = fkCalculated
      FieldName = 'DESC_TIPOOPE'
      Visible = False
      Size = 22
      Calculated = True
    end
    object selTabellaCOD_ORARIO: TStringField
      DisplayLabel = 'Orario'
      FieldName = 'COD_ORARIO'
      Required = True
      Size = 5
    end
    object selTabellaDESC_ORARIO: TStringField
      DisplayLabel = 'Desc. orario'
      FieldKind = fkCalculated
      FieldName = 'DESC_ORARIO'
      Size = 40
      Calculated = True
    end
    object selTabellaSIGLA_TURNO: TStringField
      DisplayLabel = 'Sigla'
      FieldName = 'SIGLA_TURNO'
      Required = True
      Size = 2
    end
    object selTabellaDESC_SIGLATURNO: TStringField
      DisplayLabel = 'Desc. sigla turno'
      FieldKind = fkCalculated
      FieldName = 'DESC_SIGLATURNO'
      Visible = False
      Calculated = True
    end
    object selTabellaCOD_GIORNO: TStringField
      DisplayLabel = 'Giorno'
      FieldName = 'COD_GIORNO'
      Required = True
      Size = 1
    end
    object selTabellaDESC_GIORNO: TStringField
      DisplayLabel = 'Desc. giorno'
      FieldKind = fkLookup
      FieldName = 'DESC_GIORNO'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COD_GIORNO'
      Visible = False
      Size = 15
      Lookup = True
    end
    object selTabellaCOD_CONDIZIONE: TStringField
      DisplayLabel = 'Condizione'
      FieldName = 'COD_CONDIZIONE'
      Required = True
      Size = 5
    end
    object selTabellaDESC_CONDIZIONE: TStringField
      DisplayLabel = 'Desc. condizione'
      FieldKind = fkLookup
      FieldName = 'DESC_CONDIZIONE'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COD_CONDIZIONE'
      Size = 40
      Lookup = True
    end
    object selTabellaPRIORITA: TIntegerField
      DisplayLabel = 'Priorit'#224
      FieldName = 'PRIORITA'
      MaxValue = 999
      MinValue = -999
    end
    object selTabellaLIVELLO_ANOMALIA: TIntegerField
      DisplayLabel = 'Anom.'
      FieldName = 'LIVELLO_ANOMALIA'
      MaxValue = 3
      MinValue = 1
    end
    object selTabellaMINIMO: TIntegerField
      DisplayLabel = 'Minimo'
      FieldName = 'MINIMO'
    end
    object selTabellaOTTIMALE: TIntegerField
      DisplayLabel = 'Ottimale'
      FieldName = 'OTTIMALE'
    end
    object selTabellaMASSIMO: TIntegerField
      DisplayLabel = 'Massimo'
      FieldName = 'MASSIMO'
    end
    object selTabellaVALORE: TStringField
      DisplayLabel = 'Valore'
      FieldName = 'VALORE'
      Size = 4000
    end
  end
end
