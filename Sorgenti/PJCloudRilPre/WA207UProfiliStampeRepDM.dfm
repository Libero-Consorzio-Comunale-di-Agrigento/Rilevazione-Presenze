inherited WA207FProfiliStampeRepDM: TWA207FProfiliStampeRepDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select T355.*, T355.ROWID'
      '  from T355_STAMPE_REPERIB T355'
      ' order by T355.CODICE')
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Size = 10
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 50
    end
    object selTabellaTIPO: TStringField
      DisplayLabel = 'Tipo stampa'
      FieldName = 'TIPO'
      Size = 1
    end
    object selTabellaORIENTAMENTO: TStringField
      DisplayLabel = 'Orientamento'
      FieldName = 'ORIENTAMENTO'
      Size = 1
    end
    object selTabellaFORMATO: TStringField
      DisplayLabel = 'Formato'
      FieldName = 'FORMATO'
      Size = 100
    end
    object selTabellaFONTNAME: TStringField
      DisplayLabel = 'Nome Font'
      FieldName = 'FONTNAME'
      Size = 100
    end
    object selTabellaFONTSIZE: TIntegerField
      DisplayLabel = 'Dimensione testo'
      FieldName = 'FONTSIZE'
    end
    object selTabellaTITOLO: TStringField
      DisplayLabel = 'Titolo'
      FieldName = 'TITOLO'
      Size = 1000
    end
    object selTabellaTITOLO_SIZE: TIntegerField
      DisplayLabel = 'Dimensione titolo'
      FieldName = 'TITOLO_SIZE'
    end
    object selTabellaTITOLO_BOLD: TStringField
      DisplayLabel = 'Titolo in grassetto'
      FieldName = 'TITOLO_BOLD'
      Size = 1
    end
    object selTabellaTITOLO_UNDERLINE: TStringField
      DisplayLabel = 'Titolo sottolineato'
      FieldName = 'TITOLO_UNDERLINE'
      Size = 1
    end
    object selTabellaCAMPO_RAGGRUPPAMENTO: TStringField
      DisplayLabel = 'Campo anagrafico di raggruppamento'
      FieldName = 'CAMPO_RAGGRUPPAMENTO'
      Size = 40
    end
    object selTabellaSALTO_PAGINA: TStringField
      DisplayLabel = 'Salto pagina'
      FieldName = 'SALTO_PAGINA'
      Size = 1
    end
    object selTabellaSELEZIONE: TStringField
      DisplayLabel = 'Tipo selezione turni'
      FieldName = 'SELEZIONE'
      Size = 1
    end
    object selTabellaTURNI: TStringField
      DisplayLabel = 'Turni da considerare'
      FieldName = 'TURNI'
      Size = 2000
    end
    object selTabellaCAMPO_NOMINATIVO: TStringField
      DisplayLabel = 'Campo anagrafico associato'
      FieldName = 'CAMPO_NOMINATIVO'
      Size = 40
    end
    object selTabellaNOME_COMPLETO: TStringField
      DisplayLabel = 'Nome completo'
      FieldName = 'NOME_COMPLETO'
      Size = 1
    end
    object selTabellaDETTAGLIO: TStringField
      DisplayLabel = 'Tipo dettaglio'
      FieldName = 'DETTAGLIO'
      Size = 1
    end
    object selTabellaCAMPO_DETTAGLIO: TStringField
      DisplayLabel = 'Dato anagrafico dettaglio'
      FieldName = 'CAMPO_DETTAGLIO'
      Size = 40
    end
    object selTabellaDIP_NP: TStringField
      DisplayLabel = 'Dipendenti non pianificati'
      FieldName = 'DIP_NP'
      Size = 1
    end
    object selTabellaLEGENDA: TStringField
      DisplayLabel = 'Legenda'
      FieldName = 'LEGENDA'
      Size = 1
    end
    object selTabellaDETT_CODICE: TStringField
      DisplayLabel = 'Dettaglio Codice'
      FieldName = 'DETT_CODICE'
      Size = 1
    end
    object selTabellaDETT_SIGLA: TStringField
      DisplayLabel = 'Dettaglio codice sigla'
      FieldName = 'DETT_SIGLA'
      Size = 1
    end
    object selTabellaDETT_PRIORITA: TStringField
      DisplayLabel = 'Dettaglio codice priorit'#224
      FieldName = 'DETT_PRIORITA'
      Size = 1
    end
    object selTabellaDETT_ORARIO: TStringField
      DisplayLabel = 'Dettaglio orario'
      FieldName = 'DETT_ORARIO'
      Size = 1
    end
    object selTabellaDETT_ORARIO_RIGA: TStringField
      DisplayLabel = 'Dettaglio in riga'
      FieldName = 'DETT_ORARIO_RIGA'
      Size = 1
    end
    object selTabellaDETT_DATI_AGG: TStringField
      DisplayLabel = 'Dettaglio dati aggiuntivi'
      FieldName = 'DETT_DATI_AGG'
      Size = 1
    end
    object selTabellaDETT_DATI_AGG_RIGA: TStringField
      DisplayLabel = 'Dettaglio dati aggiuntivi in riga'
      FieldName = 'DETT_DATI_AGG_RIGA'
      Size = 1
    end
    object selTabellaDETT_DATO_LIBERO: TStringField
      DisplayLabel = 'Dettaglio dato libero'
      FieldName = 'DETT_DATO_LIBERO'
      Size = 1
    end
    object selTabellaDETT_ASSENZA: TStringField
      DisplayLabel = 'Dettaglio dati assenza'
      FieldName = 'DETT_ASSENZA'
      Size = 1
    end
    object selTabellaDETT_SIGLA_ASSENZA: TStringField
      DisplayLabel = 'Dettaglio sigla assenza'
      FieldName = 'DETT_SIGLA_ASSENZA'
      Size = 5
    end
  end
end
