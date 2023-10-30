inherited WA151FAssenteismoDM: TWA151FAssenteismoDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid '
      'from T151_ASSENTEISMO t'
      ':ORDERBY')
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Size = 10
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 100
    end
    object selTabellaSTAMPA_GENERATORE: TStringField
      DisplayLabel = 'Stampa del generatore'
      FieldName = 'STAMPA_GENERATORE'
    end
    object selTabellaCOD_TIPOACCORPCAUSALI: TStringField
      DisplayLabel = 'Tipo accorpamenti'
      FieldName = 'COD_TIPOACCORPCAUSALI'
      Size = 5
    end
    object selTabellaCOD_CODICIACCORPCAUSALI: TStringField
      DisplayLabel = 'Codici accorpamenti'
      FieldName = 'COD_CODICIACCORPCAUSALI'
      Size = 500
    end
    object selTabellaMODO_ACCORPCAUSALI: TStringField
      DisplayLabel = 'Modo accorpamenti'
      FieldName = 'MODO_ACCORPCAUSALI'
      Visible = False
      Size = 1
    end
    object selTabellaRIGHE: TStringField
      DisplayLabel = 'Righe di raggruppamento'
      FieldName = 'RIGHE'
      Visible = False
      Size = 4000
    end
    object selTabellaDETTAGLIO_DIP: TStringField
      DisplayLabel = 'Dettaglio dipendente'
      FieldName = 'DETTAGLIO_DIP'
      Visible = False
      Size = 1
    end
    object selTabellaTOTALE_GENERALE: TStringField
      DisplayLabel = 'Totale generale'
      FieldName = 'TOTALE_GENERALE'
      Visible = False
      Size = 1
    end
    object selTabellaRIGHE_VUOTE: TStringField
      DisplayLabel = 'Stampa righe vuote'
      FieldName = 'RIGHE_VUOTE'
      Visible = False
      Size = 1
    end
    object selTabellaCOLONNE: TStringField
      DisplayLabel = 'Colonne di elaborazione'
      FieldName = 'COLONNE'
      Visible = False
      Size = 500
    end
    object selTabellaNUMDIP_PERIODO: TStringField
      DisplayLabel = 'Num.Dip. Periodo di riferimento'
      FieldName = 'NUMDIP_PERIODO'
      Visible = False
      Size = 1
    end
    object selTabellaNUMDIP_ARROT: TStringField
      DisplayLabel = 'Num.Dip. Arrotondamento'
      FieldName = 'NUMDIP_ARROT'
      Visible = False
      Size = 1
    end
    object selTabellaPRESENZA_GGLAV: TStringField
      DisplayLabel = 'Pres. Considera solo giorni lavorativi'
      FieldName = 'PRESENZA_GGLAV'
      Visible = False
      Size = 1
    end
    object selTabellaPRESENZA_ARROT: TStringField
      DisplayLabel = 'Pres. Arrotondamento'
      FieldName = 'PRESENZA_ARROT'
      Visible = False
      Size = 1
    end
    object selTabellaASSENZA_GGLAV: TStringField
      DisplayLabel = 'Ass. Considera solo giorni lavorativi'
      FieldName = 'ASSENZA_GGLAV'
      Visible = False
      Size = 1
    end
    object selTabellaASSENZA_GGINT: TStringField
      DisplayLabel = 'Ass. Considera solo le assenze che coprono la giornata intera'
      FieldName = 'ASSENZA_GGINT'
      Visible = False
      Size = 1
    end
    object selTabellaASS_DEBITO_GGINT: TStringField
      DisplayLabel = 'Ass. Debito di riferimento'
      FieldName = 'ASS_DEBITO_GGINT'
      Visible = False
      Size = 1
    end
    object selTabellaASSENZA_QM: TStringField
      DisplayLabel = 
        'Ass. Giorni di ass. accorpate, calcolati in base al teorico dell' +
        'a qualif. min. (DEBITOGGQM) '
      FieldName = 'ASSENZA_QM'
      Visible = False
      Size = 1
    end
    object selTabellaASS_DETTAGLIO: TStringField
      DisplayLabel = 'Ass. Dettaglio giornaliero'
      FieldName = 'ASS_DETTAGLIO'
      Visible = False
      Size = 1
    end
    object selTabellaASS_FAMILIARI: TStringField
      DisplayLabel = 'Ass. Dettaglio familiari'
      FieldName = 'ASS_FAMILIARI'
      Visible = False
      Size = 1
    end
    object selTabellaASS_FRUIZIONE_GG: TStringField
      DisplayLabel = 'Ass. Considera fruizione Giornate'
      FieldName = 'ASS_FRUIZIONE_GG'
      Visible = False
      Size = 1
    end
    object selTabellaASS_FRUIZIONE_MG: TStringField
      DisplayLabel = 'Ass. Considera fruizione 1/2 giornate'
      FieldName = 'ASS_FRUIZIONE_MG'
      Visible = False
      Size = 1
    end
    object selTabellaASS_FRUIZIONE_HH: TStringField
      DisplayLabel = 'Ass. Considera fruizione Num. ore'
      FieldName = 'ASS_FRUIZIONE_HH'
      Visible = False
      Size = 1
    end
    object selTabellaASS_FRUIZIONE_DH: TStringField
      DisplayLabel = 'Ass. Considera fruizione Da ore a ore'
      FieldName = 'ASS_FRUIZIONE_DH'
      Visible = False
      Size = 1
    end
    object selTabellaASS_MAXPERIODO_GG: TIntegerField
      DisplayLabel = 'Ass. Max periodo considerato GG'
      FieldName = 'ASS_MAXPERIODO_GG'
      Visible = False
    end
    object selTabellaASSENZA_ARROT: TStringField
      DisplayLabel = 'Ass. Arrotondamento'
      FieldName = 'ASSENZA_ARROT'
      Visible = False
      Size = 1
    end
    object selTabellaESPORTA_XML: TStringField
      DisplayLabel = 'Esport. in formato .XML/Invio WS'
      FieldName = 'ESPORTA_XML'
      Size = 1
    end
    object selTabellaRIEPILOGO_ARROT: TStringField
      DisplayLabel = 'Riep. Arrotondamento'
      FieldName = 'RIEPILOGO_ARROT'
      Visible = False
      Size = 1
    end
  end
end
