inherited WA191FCampiRaggrDM: TWA191FCampiRaggrDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      
        'SELECT DATADECORR, NOMECAMPO1, NOMECAMPO2, TIPOLIMITE ,T800.ROWI' +
        'D '
      'FROM T800_CAMPILIMITI T800 '
      ':ORDERBY')
    BeforePost = BeforePostNoStorico
    object selTabellaDATADECORR: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DATADECORR'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
    end
    object selTabellaNOMECAMPO1: TStringField
      DisplayLabel = 'Campo 1'
      FieldName = 'NOMECAMPO1'
    end
    object selTabellaNOMECAMPO2: TStringField
      DisplayLabel = 'Campo 2'
      FieldName = 'NOMECAMPO2'
    end
    object selTabellaTIPOLIMITE: TStringField
      DisplayLabel = 'Tipo limite'
      DisplayWidth = 1
      FieldName = 'TIPOLIMITE'
      Required = True
      Size = 1
    end
  end
end
