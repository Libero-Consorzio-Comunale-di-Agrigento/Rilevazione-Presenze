inherited WP652FINPDAPMMRegoleDM: TWP652FINPDAPMMRegoleDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select P660.*, P660.ROWID '
      '  from P660_FLUSSIREGOLE P660 '
      ' where NOME_FLUSSO=:NOMEFLUSSO'
      ' :ORDERBY')
    Variables.Data = {
      0400000002000000100000003A004F0052004400450052004200590001000000
      0000000000000000160000003A004E004F004D00450046004C00550053005300
      4F00050000000000000000000000}
    object selTabellaNOME_FLUSSO: TStringField
      DisplayLabel = 'Nome flusso'
      FieldName = 'NOME_FLUSSO'
      Required = True
      Visible = False
      Size = 10
    end
    object selTabellaPARTE: TStringField
      Alignment = taCenter
      DisplayLabel = 'Parte'
      FieldName = 'PARTE'
      Required = True
      Size = 5
    end
    object selTabellaNUMERO: TStringField
      Alignment = taCenter
      DisplayLabel = 'Numero dato'
      FieldName = 'NUMERO'
      Required = True
      Size = 4
    end
    object selTabellaDECORRENZA: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
      Required = True
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 200
    end
    object selTabellaTIPO_RECORD: TStringField
      DisplayLabel = 'Tipo record file'
      FieldName = 'TIPO_RECORD'
      Visible = False
      Size = 1
    end
    object selTabellaSEZIONE_FILE: TStringField
      DisplayLabel = 'Sezione file'
      FieldName = 'SEZIONE_FILE'
      Visible = False
      Size = 2
    end
    object selTabellaNUMERO_FILE: TStringField
      DisplayLabel = 'Numero file'
      FieldName = 'NUMERO_FILE'
      Visible = False
      Size = 3
    end
    object selTabellaFORMATO_FILE: TStringField
      DisplayLabel = 'Formato file'
      FieldName = 'FORMATO_FILE'
      Visible = False
      Size = 5
    end
    object selTabellaLUNGHEZZA_FILE: TFloatField
      DisplayLabel = 'Lunghezza file'
      FieldName = 'LUNGHEZZA_FILE'
      Visible = False
    end
    object selTabellaFORMATO_ANNOMESE: TStringField
      DisplayLabel = 'Formato anno/mese'
      FieldName = 'FORMATO_ANNOMESE'
      Required = True
      Visible = False
      Size = 1
    end
    object selTabellaNUMERICO: TStringField
      DisplayLabel = 'Numerico'
      FieldName = 'NUMERICO'
      Visible = False
      Size = 1
    end
    object selTabellaCOD_ARROTONDAMENTO: TStringField
      DisplayLabel = 'Cod.arrotondamento'
      FieldName = 'COD_ARROTONDAMENTO'
      Visible = False
      Size = 5
    end
    object selTabellaFORMATO: TStringField
      DisplayLabel = 'Formato'
      FieldName = 'FORMATO'
      Visible = False
      Size = 11
    end
    object selTabellaOMETTI_VUOTO: TStringField
      DisplayLabel = 'Ometti vuoto'
      FieldName = 'OMETTI_VUOTO'
      Visible = False
      Size = 1
    end
    object selTabellaTIPO_DATO: TStringField
      DisplayLabel = 'Tipo dato'
      FieldName = 'TIPO_DATO'
      Visible = False
      Size = 1
    end
    object selTabellaFL_NUMERO_TREDICESIMA: TStringField
      DisplayLabel = 'Fluper numero tred. AC'
      FieldName = 'FL_NUMERO_TREDICESIMA'
      Visible = False
      Size = 4
    end
    object selTabellaFL_NUMERO_TREDPREC: TStringField
      DisplayLabel = 'Fluper numero tred. AP'
      FieldName = 'FL_NUMERO_TREDPREC'
      Visible = False
      Size = 4
    end
    object selTabellaFL_NUMERO_ARRCORR: TStringField
      DisplayLabel = 'Fluper numero AC'
      FieldName = 'FL_NUMERO_ARRCORR'
      Visible = False
      Size = 4
    end
    object selTabellaFL_NUMERO_ARRPREC: TStringField
      DisplayLabel = 'Fluper numero AP'
      FieldName = 'FL_NUMERO_ARRPREC'
      Visible = False
      Size = 4
    end
    object selTabelladesc_FL_NUMERO_ARRPREC: TStringField
      FieldKind = fkLookup
      FieldName = 'desc_FL_NUMERO_ARRPREC'
      LookupKeyFields = 'PARTE;NUMERO'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'PARTE;FL_NUMERO_ARRPREC'
      Visible = False
      Size = 200
      Lookup = True
    end
    object selTabelladesc_FL_NUMERO_ARRCORR: TStringField
      FieldKind = fkLookup
      FieldName = 'desc_FL_NUMERO_ARRCORR'
      LookupKeyFields = 'PARTE;NUMERO'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'PARTE;FL_NUMERO_ARRCORR'
      Visible = False
      Size = 200
      Lookup = True
    end
    object selTabelladescFL_NUMERO_TREDPREC: TStringField
      FieldKind = fkLookup
      FieldName = 'descFL_NUMERO_TREDPREC'
      LookupKeyFields = 'PARTE;NUMERO'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'PARTE;FL_NUMERO_TREDPREC'
      Visible = False
      Size = 200
      Lookup = True
    end
    object selTabelladescFL_NUMERO_TREDICESIMA: TStringField
      FieldKind = fkLookup
      FieldName = 'descFL_NUMERO_TREDICESIMA'
      LookupKeyFields = 'PARTE;NUMERO'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'PARTE;FL_NUMERO_TREDICESIMA'
      Visible = False
      Size = 200
      Lookup = True
    end
    object selTabellaNOME_DATO: TStringField
      DisplayLabel = 'Nome dato'
      FieldName = 'NOME_DATO'
      Size = 40
    end
    object selTabellaCODICI_CAUSALI: TStringField
      DisplayLabel = 'Codici causali'
      FieldName = 'CODICI_CAUSALI'
      Visible = False
      Size = 500
    end
    object selTabellaCOMMENTO: TStringField
      DisplayLabel = 'Commento'
      FieldName = 'COMMENTO'
      Visible = False
      Size = 300
    end
    object selTabellaREGOLA_CALCOLO_AUTOMATICA: TStringField
      DisplayLabel = 'Regola calcolo automatica'
      DisplayWidth = 4000
      FieldName = 'REGOLA_CALCOLO_AUTOMATICA'
      Visible = False
      Size = 4000
    end
    object selTabellaREGOLA_CALCOLO_MANUALE: TStringField
      DisplayLabel = 'Regola calcolo manuale'
      DisplayWidth = 4000
      FieldName = 'REGOLA_CALCOLO_MANUALE'
      Visible = False
      Size = 4000
    end
    object selTabellaREGOLA_MODIFICABILE: TStringField
      DisplayLabel = 'Regola modificabile'
      FieldName = 'REGOLA_MODIFICABILE'
      Visible = False
      Size = 1
    end
    object selTabellaREGOLA_CALCOLO_ECCEZIONI: TStringField
      DisplayLabel = 'Regola calcolo eccezioni'
      FieldName = 'REGOLA_CALCOLO_ECCEZIONI'
      ReadOnly = True
      Visible = False
      Size = 4000
    end
  end
end
