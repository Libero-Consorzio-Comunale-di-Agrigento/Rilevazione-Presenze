inherited WA148FProfiliImportazioneCertificatiINPSDM: TWA148FProfiliImportazioneCertificatiINPSDM
  Height = 123
  Width = 314
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select T269.*, T269.ROWID'
      '  from T269_RELAZIONI_ATTESTATIINPS T269'
      ' :ORDERBY')
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Profilo'
      DisplayWidth = 15
      FieldName = 'CODICE'
    end
    object selTabellaFILTRO: TStringField
      DisplayLabel = 'Selezione'
      DisplayWidth = 40
      FieldName = 'FILTRO'
      Size = 2000
    end
    object selTabelladCProvvisoria: TStringField
      DisplayLabel = 'Causale provvisoria'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'dCProvvisoria'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAUS_PROVVISORIA'
      Size = 40
      Lookup = True
    end
    object selTabelladCInserimento: TStringField
      DisplayLabel = 'Causale di inserimento'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'dCInserimento'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAUS_INSERIMENTO'
      Size = 40
      Lookup = True
    end
    object selTabelladCRicovero: TStringField
      DisplayLabel = 'Causale di ricovero'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'dCRicovero'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAUS_RICOVERO'
      Size = 40
      Lookup = True
    end
    object selTabelladCPostRicovero: TStringField
      DisplayLabel = 'Causale post-ricovero'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'dCPostRicovero'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAUS_POSTRICOVERO'
      Size = 40
      Lookup = True
    end
    object selTabelladCSalvaVita: TStringField
      DisplayLabel = 'Causale salva-vita'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'dCSalvaVita'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAUS_SALVAVITA'
      Size = 40
      Lookup = True
    end
    object selTabelladCInvalidita: TStringField
      DisplayLabel = 'Causale d'#39'invalidit'#224
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'dCInvalidita'
      LookupDataSet = A148FProfiliImportazioneCertificatiINPSMW.selT265_All
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAUS_INVALIDITA'
      Size = 40
      Lookup = True
    end
    object selTabelladCServizio: TStringField
      DisplayLabel = 'Causale di servizio'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'dCServizio'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAUS_SERVIZIO'
      Size = 40
      Lookup = True
    end
    object selTabellaCAUS_PROVVISORIA: TStringField
      DisplayLabel = 'Causale provvisoria'
      FieldName = 'CAUS_PROVVISORIA'
      Visible = False
      Size = 5
    end
    object selTabellaCAUS_INSERIMENTO: TStringField
      DisplayLabel = 'Causale di inserimento'
      FieldName = 'CAUS_INSERIMENTO'
      Visible = False
      Size = 5
    end
    object selTabellaCAUS_RICOVERO: TStringField
      DisplayLabel = 'Causale di ricovero'
      FieldName = 'CAUS_RICOVERO'
      Visible = False
      Size = 5
    end
    object selTabellaCAUS_POSTRICOVERO: TStringField
      DisplayLabel = 'Causale di post-ricovero'
      FieldName = 'CAUS_POSTRICOVERO'
      Visible = False
      Size = 5
    end
    object selTabellaCAUS_SALVAVITA: TStringField
      DisplayLabel = 'Causale salva-vita'
      FieldName = 'CAUS_SALVAVITA'
      Visible = False
      Size = 5
    end
    object selTabellaCAUS_INVALIDITA: TStringField
      FieldName = 'CAUS_INVALIDITA'
      Visible = False
      Size = 5
    end
    object selTabellaCAUS_SERVIZIO: TStringField
      DisplayLabel = 'Causale di servizio'
      FieldName = 'CAUS_SERVIZIO'
      Visible = False
      Size = 5
    end
    object selTabellaPOSTRICOVERO_AUTO: TStringField
      DisplayLabel = 'Post-ricovero automatico'
      FieldName = 'POSTRICOVERO_AUTO'
      Size = 1
    end
    object selTabellaFLAG_IGNORA_NUOVO_PERIODO: TStringField
      DisplayLabel = 'Ignora Continuazione/Nuovo periodo'
      FieldName = 'FLAG_IGNORA_NUOVO_PERIODO'
      Size = 1
    end
  end
  inherited selEstrazioneDati: TOracleDataSet
    Left = 112
  end
  inherited dsrEstrazioniDati: TDataSource
    Left = 112
  end
  inherited selT900: TOracleDataSet
    Left = 200
  end
  inherited selT901: TOracleDataSet
    Left = 256
  end
end
