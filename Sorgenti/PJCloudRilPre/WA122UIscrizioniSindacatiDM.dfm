inherited WA122FIscrizioniSindacatiDM: TWA122FIscrizioniSindacatiDM
  Height = 127
  Width = 307
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select T246.*, T246.ROWID'
      'from T246_ISCRIZIONISINDACATI T246'
      'where progressivo = :PROGRESSIVO'
      ' :ORDERBY')
    Variables.Data = {
      0400000002000000100000003A004F0052004400450052004200590001000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    BeforeInsert = BeforeInsert
    BeforePost = BeforePostNoStorico
    OnCalcFields = selTabellaCalcFields
    OnNewRecord = OnNewRecord
    object selTabellaPROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selTabellaNUM_PROT_ISCR: TFloatField
      DisplayLabel = 'Pr.Iscriz.'
      DisplayWidth = 6
      FieldName = 'NUM_PROT_ISCR'
      Required = True
    end
    object selTabellaDATA_ISCR: TDateTimeField
      DisplayLabel = 'Comunic.Iscriz.'
      DisplayWidth = 10
      FieldName = 'DATA_ISCR'
      Required = True
      OnValidate = selTabellaDATA_ISCRValidate
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object selTabellaDATA_DEC_ISCR: TDateTimeField
      DisplayLabel = 'Decorr.Iscriz'
      DisplayWidth = 10
      FieldName = 'DATA_DEC_ISCR'
      Required = True
      OnValidate = selTabellaDATA_DEC_ISCRValidate
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object selTabellaNUM_PROT_CESS: TFloatField
      DisplayLabel = 'Pr.Cessaz.'
      DisplayWidth = 6
      FieldName = 'NUM_PROT_CESS'
    end
    object selTabellaDATA_CESS: TDateTimeField
      DisplayLabel = 'Comunic.Cessaz.'
      DisplayWidth = 10
      FieldName = 'DATA_CESS'
      OnValidate = selTabellaDATA_CESSValidate
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object selTabellaDATA_DEC_CES: TDateTimeField
      DisplayLabel = 'Decorr.Cessaz.'
      DisplayWidth = 10
      FieldName = 'DATA_DEC_CES'
      OnValidate = selTabellaDATA_DEC_CESValidate
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object selTabellaCOD_SINDACATO: TStringField
      DisplayLabel = 'Sindacato'
      DisplayWidth = 6
      FieldName = 'COD_SINDACATO'
      Required = True
      OnChange = selTabellaCOD_SINDACATOChange
      Size = 10
    end
    object selTabellaDESC_SINDACATO: TStringField
      DisplayLabel = 'Descr. Sindacato'
      DisplayWidth = 30
      FieldKind = fkCalculated
      FieldName = 'DESC_SINDACATO'
      Size = 50
      Calculated = True
    end
  end
  inherited selEstrazioneDati: TOracleDataSet
    Left = 112
  end
  inherited dsrEstrazioniDati: TDataSource
    Left = 112
  end
  inherited selT900: TOracleDataSet
    Left = 200
  end
  inherited selT901: TOracleDataSet
    Left = 256
  end
end
