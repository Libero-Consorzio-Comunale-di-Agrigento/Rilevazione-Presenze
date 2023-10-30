inherited WA107FInsAssAutoRegoleDM: TWA107FInsAssAutoRegoleDM
  Height = 117
  Width = 400
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T045.*,T045.ROWID FROM T045_ASSENZEAUTOMATICHE T045'
      ':ORDERBY')
    BeforePost = BeforePostNoStorico
    AfterCancel = AfterCancel
    object selTabellaCAUSALI: TStringField
      DisplayLabel = 'Causali'
      FieldName = 'CAUSALI'
      Size = 300
    end
    object selTabellaDEBITO: TStringField
      DisplayLabel = 'Debito da coprire'
      FieldName = 'DEBITO'
      Size = 1
    end
    object selTabellaGIORNI_VUOTI: TStringField
      DisplayLabel = 'Considera giorni vuoti'
      FieldName = 'GIORNI_VUOTI'
      Size = 1
    end
    object selTabellaORE_MAX: TStringField
      DisplayLabel = 'Ore max giornaliere'
      FieldName = 'ORE_MAX'
      Required = True
      OnValidate = selTabellaORE_MAXValidate
      EditMask = '!00:00;1;_'
      Size = 5
    end
    object selTabellaELIMINA_GIUSTIFICATIVI: TStringField
      DisplayLabel = 'Elimina giustificativi preesistenti'
      FieldName = 'ELIMINA_GIUSTIFICATIVI'
      Size = 1
    end
  end
end
