inherited P651FRelazioniTabelleDtM: TP651FRelazioniTabelleDtM
  OldCreateOrder = True
  Height = 173
  Width = 200
  object selI037: TOracleDataSet
    SQL.Strings = (
      'SELECT I037.*,I037.ROWID FROM I037_RELAZIONI_TABELLE I037'
      'WHERE NOME_FLUSSO = :NOME_FLUSSO'
      'ORDER BY COD_DATO1, :ORDERBY')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A004E004F004D0045005F0046004C0055005300
      53004F00050000000000000000000000100000003A004F005200440045005200
      42005900010000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      0500000005000000140000004400450043004F005200520045004E005A004100
      0100000000001E0000004400450043004F005200520045004E005A0041005F00
      460049004E004500010000000000160000004E004F004D0045005F0046004C00
      5500530053004F000100000000001200000043004F0044005F00440041005400
      4F0031000100000000001200000043004F0044005F004400410054004F003200
      010000000000}
    BeforePost = BeforePost
    AfterPost = AfterPost
    AfterDelete = AfterDelete
    OnCalcFields = selI037CalcFields
    OnNewRecord = selI037NewRecord
    Left = 16
    Top = 10
    object selI037NOME_FLUSSO: TStringField
      DisplayLabel = 'Nome flusso'
      FieldName = 'NOME_FLUSSO'
      Required = True
      Size = 10
    end
    object selI037DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selI037DECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Scadenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA_FINE'
      Visible = False
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selI037COD_DATO1: TStringField
      DisplayLabel = 'Dato 1'
      DisplayWidth = 20
      FieldName = 'COD_DATO1'
      Required = True
      OnSetText = selI037COD_DATO1SetText
      Size = 100
    end
    object selI037DESCR_DATO1: TStringField
      DisplayLabel = 'Descrizione'
      FieldKind = fkCalculated
      FieldName = 'DESCR_DATO1'
      Size = 100
      Calculated = True
    end
    object selI037COD_DATO2: TStringField
      DisplayLabel = 'Dato 2'
      DisplayWidth = 20
      FieldName = 'COD_DATO2'
      Required = True
      OnSetText = selI037COD_DATO2SetText
      Size = 100
    end
    object selI037DESCR_DATO2: TStringField
      DisplayLabel = 'Descrizione'
      FieldKind = fkCalculated
      FieldName = 'DESCR_DATO2'
      Size = 100
      Calculated = True
    end
    object selI037PERCENTUALE: TFloatField
      DisplayLabel = 'Percentuale'
      FieldName = 'PERCENTUALE'
      Visible = False
    end
  end
  object dsrFlussi: TDataSource
    Left = 88
    Top = 72
  end
end
