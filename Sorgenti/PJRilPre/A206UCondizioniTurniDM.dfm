inherited A206FCondizioniTurniDM: TA206FCondizioniTurniDM
  OldCreateOrder = True
  Height = 102
  Width = 103
  object selT606: TOracleDataSet
    SQL.Strings = (
      
        'select T030.COGNOME, T030.NOME, T030.MATRICOLA, T606.*, T606.ROW' +
        'ID'
      'from T606_CONDIZIONI T606, T030_ANAGRAFICO T030'
      'where (:PROGRESSIVO = -2 or T606.PROGRESSIVO = :PROGRESSIVO)'
      'and T030.PROGRESSIVO (+) = T606.PROGRESSIVO'
      'order by T030.COGNOME, T030.NOME, T030.MATRICOLA,'
      
        '         T606.PROGRESSIVO, T606.COD_SQUADRA, T606.COD_TIPOOPE, T' +
        '606.COD_GIORNO, '
      
        '         T606.COD_ORARIO, T606.SIGLA_TURNO, T606.COD_CONDIZIONE,' +
        ' T606.DECORRENZA')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    BeforePost = BeforePost
    AfterScroll = selT606AfterScroll
    OnCalcFields = selT606CalcFields
    OnFilterRecord = selT606FilterRecord
    OnNewRecord = OnNewRecord
    Left = 24
    Top = 24
    object selT606MATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldKind = fkInternalCalc
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selT606COGNOME: TStringField
      DisplayLabel = 'Cognome'
      FieldKind = fkInternalCalc
      FieldName = 'COGNOME'
      Size = 50
    end
    object selT606NOME: TStringField
      DisplayLabel = 'Nome'
      FieldKind = fkInternalCalc
      FieldName = 'NOME'
      Size = 50
    end
    object selT606PROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selT606DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
      Required = True
      OnValidate = selT606DECORRENZAValidate
      EditMask = '!99/99/0000;1;_'
    end
    object selT606DECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Scadenza'
      FieldName = 'DECORRENZA_FINE'
      Required = True
      OnValidate = selT606DECORRENZAValidate
      EditMask = '!99/99/0000;1;_'
    end
    object selT606COD_SQUADRA: TStringField
      DisplayLabel = 'Squadra'
      FieldName = 'COD_SQUADRA'
      Required = True
      Size = 10
    end
    object selT606DESC_SQUADRA: TStringField
      DisplayLabel = 'Desc. squadra'
      FieldKind = fkCalculated
      FieldName = 'DESC_SQUADRA'
      Size = 40
      Calculated = True
    end
    object selT606COD_TIPOOPE: TStringField
      DisplayLabel = 'Tipo operatore'
      FieldName = 'COD_TIPOOPE'
      Required = True
      Size = 5
    end
    object selT606DESC_TIPOOPE: TStringField
      DisplayLabel = 'Desc. tipo operatore'
      FieldKind = fkCalculated
      FieldName = 'DESC_TIPOOPE'
      Size = 22
      Calculated = True
    end
    object selT606COD_ORARIO: TStringField
      DisplayLabel = 'Orario'
      FieldName = 'COD_ORARIO'
      Required = True
      OnValidate = selT606DECORRENZAValidate
      Size = 5
    end
    object selT606DESC_ORARIO: TStringField
      DisplayLabel = 'Desc. orario'
      FieldKind = fkCalculated
      FieldName = 'DESC_ORARIO'
      Size = 40
      Calculated = True
    end
    object selT606SIGLA_TURNO: TStringField
      DisplayLabel = 'Sigla turno'
      FieldName = 'SIGLA_TURNO'
      Required = True
      Size = 2
    end
    object selT606DESC_SIGLATURNO: TStringField
      DisplayLabel = 'Desc. sigla turno'
      FieldKind = fkCalculated
      FieldName = 'DESC_SIGLATURNO'
      Calculated = True
    end
    object selT606COD_GIORNO: TStringField
      DisplayLabel = 'Giorno'
      FieldName = 'COD_GIORNO'
      Required = True
      Size = 1
    end
    object selT606DESC_GIORNO: TStringField
      DisplayLabel = 'Desc. giorno'
      DisplayWidth = 22
      FieldKind = fkLookup
      FieldName = 'DESC_GIORNO'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COD_GIORNO'
      Size = 15
      Lookup = True
    end
    object selT606COD_CONDIZIONE: TStringField
      DisplayLabel = 'Condizione'
      FieldName = 'COD_CONDIZIONE'
      Required = True
      OnValidate = selT606DECORRENZAValidate
      Size = 5
    end
    object selT606DESC_CONDIZIONE: TStringField
      DisplayLabel = 'Cod. condizione'
      DisplayWidth = 22
      FieldKind = fkLookup
      FieldName = 'DESC_CONDIZIONE'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COD_CONDIZIONE'
      Size = 40
      Lookup = True
    end
    object selT606PRIORITA: TIntegerField
      DisplayLabel = 'Priorit'#224
      FieldName = 'PRIORITA'
      MaxValue = 999
      MinValue = -999
    end
    object selT606LIVELLO_ANOMALIA: TIntegerField
      DisplayLabel = 'Livello anomalia'
      FieldName = 'LIVELLO_ANOMALIA'
      MaxValue = 3
      MinValue = 1
    end
    object selT606MINIMO: TIntegerField
      DisplayLabel = 'Minimo'
      FieldName = 'MINIMO'
    end
    object selT606OTTIMALE: TIntegerField
      DisplayLabel = 'Ottimale'
      FieldName = 'OTTIMALE'
    end
    object selT606MASSIMO: TIntegerField
      DisplayLabel = 'Massimo'
      FieldName = 'MASSIMO'
    end
    object selT606VALORE: TStringField
      DisplayLabel = 'Valore'
      FieldName = 'VALORE'
      Size = 4000
    end
  end
end
