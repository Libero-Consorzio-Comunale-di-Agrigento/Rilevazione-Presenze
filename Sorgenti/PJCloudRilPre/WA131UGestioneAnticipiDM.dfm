inherited WA131FGestioneAnticipiDM: TWA131FGestioneAnticipiDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT M060.*,ROWID'
      'FROM M060_ANTICIPI M060 '
      'WHERE M060.PROGRESSIVO = :PROGRESSIVO'
      ':ORDERBY')
    Variables.Data = {
      0400000002000000100000003A004F0052004400450052004200590001000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    BeforePost = BeforePostNoStorico
    AfterPost = AfterPost
    AfterDelete = AfterDelete
    OnNewRecord = OnNewRecord
    object selTabellaCASSA: TStringField
      DisplayLabel = 'Cassa'
      FieldName = 'CASSA'
      Size = 10
    end
    object selTabellaNROSOSP: TFloatField
      DisplayLabel = 'Numero sospeso'
      FieldName = 'NROSOSP'
    end
    object selTabellaANNO_MOVIMENTO: TStringField
      DisplayLabel = 'Anno movimento'
      FieldName = 'ANNO_MOVIMENTO'
      Size = 4
    end
    object selTabellaNUM_MOVIMENTO: TFloatField
      DisplayLabel = 'Num. movimento'
      FieldName = 'NUM_MOVIMENTO'
    end
    object selTabellaDATA_MOVIMENTO: TDateTimeField
      DisplayLabel = 'Data movimento'
      FieldName = 'DATA_MOVIMENTO'
      Visible = False
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaSTATO: TStringField
      DisplayLabel = 'Stato'
      FieldName = 'STATO'
    end
    object selTabellaDATA_MISSIONE: TDateTimeField
      DisplayLabel = 'Data missione'
      FieldName = 'DATA_MISSIONE'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaIMPORTO: TFloatField
      DisplayLabel = 'Importo'
      FieldName = 'IMPORTO'
    end
    object selTabellaCOD_VOCE: TStringField
      DisplayLabel = 'Cod.anticipo'
      FieldName = 'COD_VOCE'
    end
    object selTabellaDESC_CODVOCE: TStringField
      DisplayLabel = 'Voce anticipo'
      FieldKind = fkLookup
      FieldName = 'DESC_CODVOCE'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COD_VOCE'
      Size = 100
      Lookup = True
    end
    object selTabellaQUANTITA: TFloatField
      FieldName = 'QUANTITA'
      Visible = False
    end
    object selTabellaFLAG_TOTALIZZATORE: TStringField
      FieldName = 'FLAG_TOTALIZZATORE'
      Visible = False
    end
    object selTabellaDATA_IMPOSTAZIONE_STATO: TDateTimeField
      FieldName = 'DATA_IMPOSTAZIONE_STATO'
      Visible = False
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaNOTE: TStringField
      FieldName = 'NOTE'
      Visible = False
      Size = 500
    end
    object selTabellaPROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selTabellaITA_EST: TStringField
      FieldName = 'ITA_EST'
      Visible = False
      Size = 1
    end
    object selTabellaID_MISSIONE: TIntegerField
      FieldName = 'ID_MISSIONE'
      Visible = False
    end
  end
end
