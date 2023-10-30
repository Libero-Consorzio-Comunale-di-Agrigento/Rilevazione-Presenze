inherited WA158FCapitoliRimborsoDM: TWA158FCapitoliRimborsoDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      
        'select M031.DECORRENZA, M031.DECORRENZA_FINE, M031.CAPITOLO_TRAS' +
        'FERTA, M031.CATEG_RIMBORSO, M031.PERCENTUALE, M031.CAPITOLO_BILA' +
        'NCIO, '
      
        '       M031.IMPEGNO, M031.IMPORTO, M031.CENTRO_COSTO, M031.FATTO' +
        'RE_PRODUTTIVO, M031.ROWID'
      '  from M031_CAPITOLI_RIMBORSO M031'
      
        ' order by M031.CAPITOLO_TRASFERTA, M031.CATEG_RIMBORSO, M031.CAP' +
        'ITOLO_BILANCIO, M031.DECORRENZA, M031.DECORRENZA_FINE')
    BeforeEdit = BeforeEdit
    OnCalcFields = selTabellaCalcFields
    object selTabellaDECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA'
    end
    object selTabellaDECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Scadenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA_FINE'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaCAPITOLO_TRASFERTA: TStringField
      DisplayLabel = 'Cod. capitolo trasferta'
      FieldName = 'CAPITOLO_TRASFERTA'
    end
    object selTabelladCapitolo_trasferta: TStringField
      DisplayLabel = 'Desc. capitolo trasferta'
      FieldKind = fkCalculated
      FieldName = 'dCapitolo_trasferta'
      ReadOnly = True
      Size = 100
      Calculated = True
    end
    object selTabellaCATEG_RIMBORSO: TStringField
      DisplayLabel = 'Cod. categoria rimborso'
      FieldName = 'CATEG_RIMBORSO'
      Size = 10
    end
    object selTabellaPERCENTUALE: TFloatField
      DisplayLabel = 'Percentuale'
      FieldName = 'PERCENTUALE'
      MaxValue = 100.000000000000000000
    end
    object selTabellaCAPITOLO_BILANCIO: TStringField
      DisplayLabel = 'Capitolo di bilancio'
      FieldName = 'CAPITOLO_BILANCIO'
      Size = 10
    end
    object selTabellaIMPEGNO: TStringField
      DisplayLabel = 'Impegno'
      FieldName = 'IMPEGNO'
      Size = 10
    end
    object selTabellaIMPORTO: TFloatField
      DisplayLabel = 'Importo'
      FieldName = 'IMPORTO'
      DisplayFormat = '###.###,##'
    end
    object selTabellaCENTRO_COSTO: TStringField
      DisplayLabel = 'Centro di costo'
      FieldName = 'CENTRO_COSTO'
      Size = 10
    end
    object selTabellaFATTORE_PRODUTTIVO: TStringField
      DisplayLabel = 'Fattore produttivo'
      FieldName = 'FATTORE_PRODUTTIVO'
      Size = 10
    end
  end
end
