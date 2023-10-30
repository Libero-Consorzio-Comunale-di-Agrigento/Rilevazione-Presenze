inherited WS030FProvvedimentiDM: TWS030FProvvedimentiDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT SG100.*,SG100.ROWID FROM SG100_PROVVEDIMENTO SG100'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      ':ORDERBY')
    Variables.Data = {
      0400000002000000100000003A004F0052004400450052004200590001000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    AfterPost = AfterPost
    OnCalcFields = selTabellaCalcFields
    OnNewRecord = OnNewRecord
    object selTabellaPROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selTabellaTIPO_PROVV: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO_PROVV'
      Size = 1
    end
    object selTabellaNOMECAMPO: TStringField
      DisplayLabel = 'Nome dato'
      FieldName = 'NOMECAMPO'
      Required = True
    end
    object selTabellaD_DATO: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_DATO'
      Visible = False
      Size = 40
      Calculated = True
    end
    object selTabellaDATAREGISTR: TDateTimeField
      DisplayLabel = 'Registrazione'
      FieldName = 'DATAREGISTR'
      DisplayFormat = 'dd/mm/yyyy hh.nn'
      EditMask = '!00/00/0000 09:00;1;_'
    end
    object selTabellaDATADECOR: TDateTimeField
      DisplayLabel = 'Decorrenza'
      DisplayWidth = 10
      FieldName = 'DATADECOR'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaDATAFINE: TDateTimeField
      DisplayLabel = 'Fine'
      DisplayWidth = 10
      FieldName = 'DATAFINE'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object selTabellaCAUSALE: TStringField
      DisplayLabel = 'Motivazione'
      DisplayWidth = 5
      FieldName = 'CAUSALE'
      Size = 5
    end
    object selTabellaD_CAUSALI: TStringField
      DisplayLabel = 'Desc. motivazione'
      FieldKind = fkLookup
      FieldName = 'D_CAUSALI'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAUSALE'
      Size = 130
      Lookup = True
    end
    object selTabellaTIPOATTO: TStringField
      DisplayLabel = 'Tipo atto'
      FieldName = 'TIPOATTO'
      Size = 30
    end
    object selTabellaNUMATTO: TStringField
      DisplayLabel = 'Numero atto'
      FieldName = 'NUMATTO'
      Size = 100
    end
    object selTabellaDATAATTO: TDateTimeField
      DisplayLabel = 'Data atto'
      FieldName = 'DATAATTO'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaDATAESEC: TDateTimeField
      DisplayLabel = 'Data esecutivit'#224
      FieldName = 'DATAESEC'
      Visible = False
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaAUTORITA: TStringField
      DisplayLabel = 'Autorit'#224
      FieldName = 'AUTORITA'
      Visible = False
      Size = 40
    end
    object selTabellaSEDE: TStringField
      DisplayLabel = 'Sede'
      FieldName = 'SEDE'
      Visible = False
      Size = 80
    end
    object selTabellaD_SEDE: TStringField
      FieldKind = fkLookup
      FieldName = 'D_SEDE'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'SEDE'
      Visible = False
      Size = 100
      Lookup = True
    end
    object selTabellaNOTE: TStringField
      DisplayLabel = 'Annotazioni'
      DisplayWidth = 100
      FieldName = 'NOTE'
      Visible = False
      Size = 2000
    end
    object selTabellaTESTOVAR: TStringField
      DisplayLabel = 'Testo variazione'
      DisplayWidth = 100
      FieldName = 'TESTOVAR'
      Visible = False
      Size = 4000
    end
  end
  object cdsStoriaDato: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 120
    Top = 145
    object cdsStoriaDatoDATO: TStringField
      FieldName = 'DATO'
    end
    object cdsStoriaDatoDATADEC: TStringField
      FieldName = 'DATADEC'
    end
    object cdsStoriaDatoDATAFINE: TStringField
      FieldName = 'DATAFINE'
    end
    object cdsStoriaDatoVALORE: TStringField
      FieldName = 'VALORE'
    end
    object cdsStoriaDatoDESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
    end
    object cdsStoriaDatoKEY: TStringField
      FieldName = 'KEY'
      Visible = False
    end
    object cdsStoriaDatoRIGACOLORATA: TBooleanField
      FieldName = 'RIGACOLORATA'
      Visible = False
    end
  end
  object cdsrStoriaDato: TDataSource
    AutoEdit = False
    DataSet = cdsStoriaDato
    Left = 192
    Top = 145
  end
end
