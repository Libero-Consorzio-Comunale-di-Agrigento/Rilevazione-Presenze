inherited WP651FRelazioniTabelleDM: TWP651FRelazioniTabelleDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT I037.*,I037.ROWID FROM I037_RELAZIONI_TABELLE I037'
      'WHERE NOME_FLUSSO = :NOME_FLUSSO'
      ':ORDERBY')
    Variables.Data = {
      0400000002000000100000003A004F0052004400450052004200590001000000
      0000000000000000180000003A004E004F004D0045005F0046004C0055005300
      53004F00050000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      0500000005000000160000004E004F004D0045005F0046004C00550053005300
      4F00010000000000140000004400450043004F005200520045004E005A004100
      0100000000001E0000004400450043004F005200520045004E005A0041005F00
      460049004E0045000100000000001200000043004F0044005F00440041005400
      4F0031000100000000001200000043004F0044005F004400410054004F003200
      010000000000}
    BeforePost = BeforePost
    AfterPost = AfterPost
    AfterDelete = AfterDelete
    OnCalcFields = selTabellaCalcFields
    OnNewRecord = OnNewRecord
    object selTabellaNOME_FLUSSO: TStringField
      DisplayLabel = 'Nome flusso'
      FieldName = 'NOME_FLUSSO'
      Required = True
      Visible = False
      Size = 10
    end
    object selTabellaDECORRENZA: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Decorrenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaDECORRENZA_FINE: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Scadenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA_FINE'
      Visible = False
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaCOD_DATO1: TStringField
      FieldName = 'COD_DATO1'
      Required = True
      Size = 100
    end
    object selTabellaDESCR_DATO1: TStringField
      DisplayLabel = 'Descrizione'
      FieldKind = fkCalculated
      FieldName = 'DESCR_DATO1'
      Size = 100
      Calculated = True
    end
    object selTabellaCOD_DATO2: TStringField
      FieldName = 'COD_DATO2'
      Required = True
      Size = 100
    end
    object selTabellaDESCR_DATO2: TStringField
      DisplayLabel = 'Descrizione'
      FieldKind = fkCalculated
      FieldName = 'DESCR_DATO2'
      Size = 100
      Calculated = True
    end
    object selTabellaPERCENTUALE: TFloatField
      DisplayLabel = 'Percentuale'
      FieldName = 'PERCENTUALE'
      Visible = False
    end
  end
end
