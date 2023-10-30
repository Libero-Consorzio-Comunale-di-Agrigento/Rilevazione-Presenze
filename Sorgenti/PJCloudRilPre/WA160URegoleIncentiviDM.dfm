inherited WA160FRegoleIncentiviDM: TWA160FRegoleIncentiviDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT '
      '  T760.*, '
      
        '  decode(T760.PROPORZIONE_INCENTIVI,'#39'0'#39','#39'Lavorato > 15 gg (0)'#39','#39 +
        '1'#39','#39'gg effettivi (1)'#39') D_PROPORZIONE_INCENTIVI, '
      
        '  decode(T760.TIPO,'#39'C'#39','#39'Quote incentivanti mensili (C)'#39','#39'D'#39','#39'Gio' +
        'rni utili (D)'#39') D_TIPO,'
      
        '  decode(T760.TIPO_QUOTEQUANT,'#39'G'#39','#39'Quote generali standard (G)'#39',' +
        #39'S'#39','#39'Schede quantitative individuali (S)'#39') D_TIPO_QUOTEQUANT,'
      '  T760.ROWID '
      'FROM T760_REGOLEINCENTIVI T760'
      ':ORDERBY')
    OnCalcFields = selTabellaCalcFields
    object selTabellaLIVELLO: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'LIVELLO'
    end
    object selTabellaDECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
    end
    object selTabellaD_LIVELLO: TStringField
      DisplayLabel = 'Descrizione'
      FieldKind = fkCalculated
      FieldName = 'D_LIVELLO'
      Size = 40
      Calculated = True
    end
    object selTabellaTIPO: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO'
      Visible = False
    end
    object selTabellaD_TIPO: TStringField
      DisplayLabel = 'Tipo'
      FieldKind = fkInternalCalc
      FieldName = 'D_TIPO'
      Size = 40
    end
    object selTabellaPROPORZIONE_INCENTIVI: TStringField
      DisplayLabel = 'Proporzione incentivi'
      FieldName = 'PROPORZIONE_INCENTIVI'
      Visible = False
    end
    object selTabellaD_PROPORZIONE_INCENTIVI: TStringField
      DisplayLabel = 'Proporzione Incentivi'
      FieldKind = fkInternalCalc
      FieldName = 'D_PROPORZIONE_INCENTIVI'
      Size = 40
    end
    object selTabellaPROPORZIONE_PARTTIME: TStringField
      DisplayLabel = 'Proporzione part-time'
      FieldName = 'PROPORZIONE_PARTTIME'
    end
    object selTabellaSCAGLIONI_GGEFF: TStringField
      DisplayLabel = 'Scaglioni gg. effettivi'
      FieldName = 'SCAGLIONI_GGEFF'
    end
    object selTabellaABBATTIMENTO_MAX: TFloatField
      DisplayLabel = 'Abbattimento max'
      FieldName = 'ABBATTIMENTO_MAX'
      OnSetText = selTabellaABBATTIMENTO_MAXSetText
    end
    object selTabellaTIPO_QUOTEQUANT: TStringField
      DisplayLabel = 'Tipo quote quantitative'
      FieldName = 'TIPO_QUOTEQUANT'
      Visible = False
    end
    object selTabellaD_TIPO_QUOTEQUANT: TStringField
      DisplayLabel = 'Tipo quote quantitative'
      FieldKind = fkInternalCalc
      FieldName = 'D_TIPO_QUOTEQUANT'
      Size = 40
    end
    object selTabellaELENCOLIV: TStringField
      DisplayLabel = 'Elenco livello'
      FieldName = 'ELENCOLIV'
    end
    object selTabellaFILE_ISTRUZIONI: TStringField
      DisplayLabel = 'File istruzioni'
      FieldName = 'FILE_ISTRUZIONI'
    end
  end
end
