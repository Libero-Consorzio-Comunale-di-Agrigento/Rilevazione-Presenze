inherited A203FDatiMensiliPersonalizzatiDtM: TA203FDatiMensiliPersonalizzatiDtM
  OldCreateOrder = True
  object selI011: TOracleDataSet
    SQL.Strings = (
      'select I011.*, ROWID'
      '  from I011_DIZIONARIO_DATISCHEDA I011'
      'order by DATO, DECORRENZA')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      0500000009000000080000004400410054004F00010000000000080000005400
      490050004F00010000000000160000004400450053004300520049005A004900
      4F004E004500010000000000160000004F005200440049004E0041004D004500
      4E0054004F000100000000001600000045005300500052004500530053004900
      4F004E0045000100000000001200000056004F00430045005000410047004800
      4500010000000000140000004400450043004F005200520045004E005A004100
      0100000000001E0000004400450043004F005200520045004E005A0041005F00
      460049004E00450001000000000024000000530045004C0045005A0049004F00
      4E0045005F0041004E00410047005200410046004500010000000000}
    AfterScroll = selI011AfterScroll
    Left = 32
    Top = 16
    object selI011DATO: TStringField
      DisplayLabel = 'Dato'
      FieldName = 'DATO'
      Required = True
      Size = 30
    end
    object selI011DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selI011DECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Fine Decorrenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA_FINE'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selI011TIPO: TStringField
      DisplayLabel = 'Tipo'
      DisplayWidth = 2
      FieldName = 'TIPO'
      Size = 1
    end
    object selI011DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selI011ORDINAMENTO: TIntegerField
      DisplayLabel = 'Ord.'
      DisplayWidth = 2
      FieldName = 'ORDINAMENTO'
    end
    object selI011ESPRESSIONE: TStringField
      DisplayLabel = 'Espressione'
      DisplayWidth = 30
      FieldName = 'ESPRESSIONE'
      Size = 2000
    end
    object selI011VOCEPAGHE: TStringField
      DisplayLabel = 'Voce paghe'
      FieldName = 'VOCEPAGHE'
      Size = 10
    end
    object selI011SELEZIONE_ANAGRAFE: TStringField
      FieldName = 'SELEZIONE_ANAGRAFE'
      Size = 2000
    end
  end
  object sesTest: TOracleSession
    LogonUsername = 'MONDOEDP'
    LogonPassword = 'TIMOTEO'
    LogonDatabase = 'IRIS'
    Preferences.ConvertUTF = cuUTF8ToUTF16
    Left = 96
    Top = 16
  end
end
