inherited A158FCapitoliRimborsoDM: TA158FCapitoliRimborsoDM
  OldCreateOrder = True
  Height = 142
  Width = 151
  object selM031: TOracleDataSet
    SQL.Strings = (
      
        'select M031.CAPITOLO_TRASFERTA, M031.CATEG_RIMBORSO, M031.DECORR' +
        'ENZA, M031.DECORRENZA_FINE, M031.PERCENTUALE, M031.CAPITOLO_BILA' +
        'NCIO, '
      
        '       M031.IMPEGNO, M031.IMPORTO, M031.CENTRO_COSTO, M031.FATTO' +
        'RE_PRODUTTIVO, M031.ROWID'
      '  from M031_CAPITOLI_RIMBORSO M031'
      
        ' order by M031.CAPITOLO_TRASFERTA, M031.CATEG_RIMBORSO, M031.CAP' +
        'ITOLO_BILANCIO, M031.DECORRENZA, M031.DECORRENZA_FINE')
    Optimize = False
    OnCalcFields = selM031CalcFields
    Left = 32
    Top = 24
    object selM031DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA'
      EditMask = '!99/99/0000;1;_'
    end
    object selM031DECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Scadenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA_FINE'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object selM031CAPITOLO_TRASFERTA: TStringField
      DisplayLabel = 'Cod. capitolo trasferta'
      FieldName = 'CAPITOLO_TRASFERTA'
    end
    object selM031dCapitolo_trasferta: TStringField
      DisplayLabel = 'Desc. capitolo trasferta'
      DisplayWidth = 30
      FieldKind = fkCalculated
      FieldName = 'dCapitolo_trasferta'
      Size = 121
      Calculated = True
    end
    object selM031CATEG_RIMBORSO: TStringField
      DisplayLabel = 'Cod. categoria rimborso'
      FieldName = 'CATEG_RIMBORSO'
      Visible = False
      Size = 10
    end
    object selM031dCateg_rimborso: TStringField
      DisplayLabel = 'Categoria rimborso'
      FieldKind = fkLookup
      FieldName = 'dCateg_rimborso'
      LookupDataSet = A158FCapitoliRimborsoMW.selM022
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CODICE'
      KeyFields = 'CATEG_RIMBORSO'
      Size = 10
      Lookup = True
    end
    object selM031dDescCateg_rimborso: TStringField
      DisplayLabel = 'Desc categoria rimborso'
      FieldKind = fkLookup
      FieldName = 'dDescCateg_rimborso'
      LookupDataSet = A158FCapitoliRimborsoMW.selM022
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CATEG_RIMBORSO'
      Size = 30
      Lookup = True
    end
    object selM031PERCENTUALE: TFloatField
      DisplayLabel = 'Percentuale'
      FieldName = 'PERCENTUALE'
      MaxValue = 100.000000000000000000
    end
    object selM031CAPITOLO_BILANCIO: TStringField
      DisplayLabel = 'Capitolo di bilancio'
      FieldName = 'CAPITOLO_BILANCIO'
      Size = 10
    end
    object selM031IMPEGNO: TStringField
      DisplayLabel = 'Impegno'
      FieldName = 'IMPEGNO'
      Size = 10
    end
    object selM031IMPORTO: TFloatField
      DisplayLabel = 'Importo'
      FieldName = 'IMPORTO'
      DisplayFormat = '###.###,##'
    end
    object selM031CENTRO_COSTO: TStringField
      DisplayLabel = 'Centro di costo'
      DisplayWidth = 5
      FieldName = 'CENTRO_COSTO'
      Size = 10
    end
    object selM031FATTORE_PRODUTTIVO: TStringField
      DisplayLabel = 'Fattore produttivo'
      FieldName = 'FATTORE_PRODUTTIVO'
      Size = 10
    end
  end
end
