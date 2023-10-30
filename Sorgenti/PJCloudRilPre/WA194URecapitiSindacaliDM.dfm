inherited WA194FRecapitiSindacaliDM: TWA194FRecapitiSindacaliDM
  Height = 124
  Width = 297
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T241.*,T241.ROWID '
      'FROM T241_RECAPITISINDACATI T241'
      'WHERE CODICE = :CODICE'
      ':ORDERBY')
    Variables.Data = {
      0400000002000000100000003A004F0052004400450052004200590001000000
      00000000000000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    BeforePost = BeforePost
    OnNewRecord = OnNewRecord
    object selTabellaCODICE: TStringField
      FieldName = 'CODICE'
      ReadOnly = True
      Required = True
      Visible = False
      Size = 10
    end
    object selTabellaDECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA'
      Required = True
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selTabellaTIPO_RECAPITO: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO_RECAPITO'
      Required = True
      Size = 2
    end
    object selTabellaPROG_RECAPITO: TIntegerField
      DisplayLabel = 'Prog.'
      DisplayWidth = 2
      FieldName = 'PROG_RECAPITO'
      Required = True
    end
    object selTabellaINDIRIZZO: TStringField
      DisplayLabel = 'Indirizzo'
      DisplayWidth = 20
      FieldName = 'INDIRIZZO'
      Size = 50
    end
    object selTabellaCitta: TStringField
      DisplayLabel = 'Citt'#224
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'Citta'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CITTA'
      KeyFields = 'COMUNE'
      Size = 60
      Lookup = True
    end
    object selTabellaProvincia: TStringField
      DisplayLabel = 'Prov'
      FieldKind = fkLookup
      FieldName = 'Provincia'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'PROVINCIA'
      KeyFields = 'COMUNE'
      Size = 2
      Lookup = True
    end
    object selTabellaCOMUNE: TStringField
      FieldName = 'COMUNE'
      Visible = False
      OnChange = selTabellaCOMUNEChange
      Size = 6
    end
    object selTabellaCAP: TStringField
      FieldName = 'CAP'
      Size = 5
    end
    object selTabellaTELEFONO: TStringField
      DisplayLabel = 'Telefono'
      FieldName = 'TELEFONO'
      Size = 15
    end
    object selTabellaFAX: TStringField
      DisplayLabel = 'Fax'
      FieldName = 'FAX'
      Size = 15
    end
    object selTabellaCOGNOME: TStringField
      DisplayLabel = 'Cognome'
      FieldName = 'COGNOME'
    end
    object selTabellaNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
    end
    object selTabellaTELEFONO_CASA: TStringField
      DisplayLabel = 'Tel.Casa'
      FieldName = 'TELEFONO_CASA'
      Size = 15
    end
    object selTabellaTELEFONO_UFFICIO: TStringField
      DisplayLabel = 'Tel.Ufficio'
      FieldName = 'TELEFONO_UFFICIO'
      Size = 15
    end
    object selTabellaCELLULARE: TStringField
      DisplayLabel = 'Cellulare'
      FieldName = 'CELLULARE'
      Size = 15
    end
    object selTabellaEMAIL: TStringField
      DisplayLabel = 'E-mail'
      FieldName = 'EMAIL'
      Size = 40
    end
  end
  inherited selEstrazioneDati: TOracleDataSet
    Left = 104
  end
  inherited dsrEstrazioniDati: TDataSource
    Left = 104
  end
  inherited selT900: TOracleDataSet
    Left = 192
  end
  inherited selT901: TOracleDataSet
    Left = 248
  end
end
