inherited WA120FTipiRimborsiDM: TWA120FTipiRimborsiDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid '
      '  from m020_tipirimborsi t'
      ' :ORDERBY')
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    AfterDelete = AfterDelete
    OnCalcFields = selTabellaCalcFields
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Required = True
      Size = 5
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selTabellaTIPO: TStringField
      DisplayLabel = 'Tipo rimborso'
      FieldName = 'TIPO'
      Size = 5
    end
    object selTabellaSCARICOPAGHE: TStringField
      DisplayLabel = 'Scarico paghe'
      FieldName = 'SCARICOPAGHE'
      Size = 1
    end
    object selTabellaCODICEVOCEPAGHE: TStringField
      DisplayLabel = 'Codice voci paghe'
      FieldName = 'CODICEVOCEPAGHE'
      Size = 10
    end
    object selTabellaFLAG_ANTICIPO: TStringField
      DisplayLabel = 'Anticipo'
      FieldName = 'FLAG_ANTICIPO'
      Required = True
      Size = 1
    end
    object selTabellaPERC_ANTICIPO: TFloatField
      DisplayLabel = 'Percentuale anticipo'
      FieldName = 'PERC_ANTICIPO'
      MaxValue = 100.000000000000000000
    end
    object selTabellaTIPO_QUANTITA: TStringField
      DisplayLabel = 'Tipo quantit'#224' richiesta'
      FieldName = 'TIPO_QUANTITA'
      Size = 1
    end
    object selTabellaFLAG_MOTIVAZIONE: TStringField
      DisplayLabel = 'Richiesta motivazione'
      FieldName = 'FLAG_MOTIVAZIONE'
      Size = 1
    end
    object selTabellaFLAG_TARGA: TStringField
      DisplayLabel = 'Richiesta targa'
      FieldName = 'FLAG_TARGA'
      Size = 1
    end
    object selTabellaESISTENZAINDENNITASUPPL: TStringField
      DisplayLabel = 'Esistenza i.s.'
      FieldName = 'ESISTENZAINDENNITASUPPL'
      Visible = False
      Size = 1
    end
    object selTabellaCODICEVOCEPAGHEINDENNITASUPPL: TStringField
      DisplayLabel = 'Codice voci paghe i.s.'
      FieldName = 'CODICEVOCEPAGHEINDENNITASUPPL'
      Visible = False
      Size = 10
    end
    object selTabellaSCARICOPAGHEINDENNITASUPPL: TStringField
      DisplayLabel = 'Scarico paghe i.s.'
      FieldName = 'SCARICOPAGHEINDENNITASUPPL'
      Visible = False
      Size = 1
    end
    object selTabellaPERCINDENNITASUPPL: TFloatField
      DisplayLabel = 'Perc. per i.s.'
      FieldName = 'PERCINDENNITASUPPL'
      Visible = False
      MaxValue = 100.000000000000000000
    end
    object selTabellaARROTINDENNITASUPPL: TStringField
      DisplayLabel = 'Arrot. i.s.'
      FieldName = 'ARROTINDENNITASUPPL'
      Visible = False
      Size = 5
    end
    object selTabellaCalcArrotIndennitaSuppl: TStringField
      FieldKind = fkCalculated
      FieldName = 'CalcArrotIndennitaSuppl'
      Visible = False
      Size = 40
      Calculated = True
    end
    object selTabellaNOTE_FISSE: TStringField
      DisplayLabel = 'Note'
      FieldName = 'NOTE_FISSE'
      Size = 500
    end
    object selTabellaCATEG_RIMBORSO: TStringField
      FieldName = 'CATEG_RIMBORSO'
      Size = 10
    end
    object selTabellaIMPORTO_MAX: TFloatField
      FieldName = 'IMPORTO_MAX'
      MaxValue = 999999999999.000100000000000000
    end
    object selTabellaFLAG_MEZZO_PROPRIO: TStringField
      FieldName = 'FLAG_MEZZO_PROPRIO'
      Size = 1
    end
    object selTabellaFASI_COMPETENZA: TStringField
      FieldName = 'FASI_COMPETENZA'
      Size = 10
    end
  end
end
