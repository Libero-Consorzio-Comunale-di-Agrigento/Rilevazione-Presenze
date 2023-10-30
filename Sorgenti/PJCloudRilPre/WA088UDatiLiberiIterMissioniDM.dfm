inherited WA088FDatiLiberiIterMissioniDM: TWA088FDatiLiberiIterMissioniDM
  Height = 242
  Width = 401
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      
        'select CODICE, DESCRIZIONE, ORDINE, MIN_FASE_VISIBILE, MAX_FASE_' +
        'VISIBILE, MIN_FASE_MODIFICA, MAX_FASE_MODIFICA, ROWID'
      'from   M024_CATEG_DATI_LIBERI M024'
      ':ORDERBY')
    BeforeEdit = BeforeEdit
    BeforeDelete = BeforeDelete
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      ReadOnly = True
      Size = 5
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 50
      FieldName = 'DESCRIZIONE'
      Size = 200
    end
    object selTabellaORDINE: TIntegerField
      DisplayLabel = 'Ordine'
      DisplayWidth = 3
      FieldName = 'ORDINE'
      MaxValue = 9999
      MinValue = 1
    end
    object selTabellaMIN_FASE_VISIBILE: TIntegerField
      DisplayLabel = 'Visibilit'#224' fase min'
      FieldName = 'MIN_FASE_VISIBILE'
      MaxValue = 99
      MinValue = -1
    end
    object selTabellaMAX_FASE_VISIBILE: TIntegerField
      DisplayLabel = 'Visibilit'#224' fase max'
      FieldName = 'MAX_FASE_VISIBILE'
      MaxValue = 99
      MinValue = -1
    end
    object selTabellaMIN_FASE_MODIFICA: TIntegerField
      DisplayLabel = 'Modifica fase min'
      FieldName = 'MIN_FASE_MODIFICA'
      MaxValue = 99
      MinValue = -1
    end
    object selTabellaMAX_FASE_MODIFICA: TIntegerField
      DisplayLabel = 'Modifica fase max'
      FieldName = 'MAX_FASE_MODIFICA'
      MaxValue = 99
      MinValue = -1
    end
  end
  object selM025: TOracleDataSet
    SQL.Strings = (
      
        'select CODICE, DESCRIZIONE, CATEGORIA, ORDINE, VALORI, OBBLIGATO' +
        'RIO, RIGHE, FORMATO, LUNG_MAX, DATO_ANAGRAFICO, QUERY_VALORE, EL' +
        'ENCO_FISSO, VALORE_DEFAULT , ROWID'
      'from   M025_MOTIVAZIONI M025'
      'where  CATEGORIA = :CODICE'
      'order by ORDINE, CODICE, DESCRIZIONE')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    OracleDictionary.DefaultValues = True
    OracleDictionary.FieldKinds = True
    BeforePost = selM025BeforePost
    BeforeDelete = selM025BeforeDelete
    OnNewRecord = selM025NewRecord
    Left = 32
    Top = 128
    object selM025CODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Size = 5
    end
    object selM025DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 40
      FieldName = 'DESCRIZIONE'
      Size = 200
    end
    object selM025CATEGORIA: TStringField
      DisplayLabel = 'Categoria'
      FieldName = 'CATEGORIA'
      Visible = False
      Size = 5
    end
    object selM025ORDINE: TIntegerField
      DisplayLabel = 'Ordine'
      DisplayWidth = 3
      FieldName = 'ORDINE'
      MaxValue = 9999
    end
    object selM025OBBLIGATORIO: TStringField
      DisplayLabel = 'Obbligatorio'
      FieldName = 'OBBLIGATORIO'
      Size = 1
    end
    object selM025RIGHE: TIntegerField
      DisplayLabel = 'Righe'
      DisplayWidth = 2
      FieldName = 'RIGHE'
      MaxValue = 9
      MinValue = 1
    end
    object selM025FORMATO: TStringField
      DisplayLabel = 'Formato'
      FieldName = 'FORMATO'
      Size = 1
    end
    object selM025LUNG_MAX: TIntegerField
      DisplayLabel = 'Lung. max'
      DisplayWidth = 4
      FieldName = 'LUNG_MAX'
      MaxValue = 9999
    end
    object selM025ELENCO_FISSO: TStringField
      DisplayLabel = 'Elenco fisso'
      FieldName = 'ELENCO_FISSO'
      Size = 1
    end
    object selM025VALORI: TStringField
      DisplayLabel = 'Valori'
      DisplayWidth = 20
      FieldName = 'VALORI'
      Size = 2000
    end
    object selM025DATO_ANAGRAFICO: TStringField
      DisplayLabel = 'Dato anagrafico'
      DisplayWidth = 15
      FieldName = 'DATO_ANAGRAFICO'
      Size = 30
    end
    object selM025QUERY_VALORE: TStringField
      DisplayLabel = 'Interrog. servizio'
      DisplayWidth = 15
      FieldName = 'QUERY_VALORE'
      Size = 30
    end
    object selM025VALORE_DEFAULT: TStringField
      DisplayLabel = 'Default'
      DisplayWidth = 10
      FieldName = 'VALORE_DEFAULT'
      Size = 2000
    end
  end
  object dsrM025: TDataSource
    DataSet = selM025
    Left = 32
    Top = 184
  end
end
