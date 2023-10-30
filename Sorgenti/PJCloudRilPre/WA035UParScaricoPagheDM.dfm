inherited WA035FParScaricoPagheDM: TWA035FParScaricoPagheDM
  Height = 182
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T191.*,T191.ROWID FROM T191_PARPAGHE T191'
      'WHERE T191.TIPO_PARAMETRIZZAZIONE = :TIPOPAR '
      ':ORDERBY')
    Variables.Data = {
      0400000002000000100000003A004F0052004400450052004200590001000000
      0000000000000000100000003A005400490050004F0050004100520005000000
      0000000000000000}
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    AfterDelete = AfterDelete
    OnNewRecord = OnNewRecord
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Origin = 'T191_PARPAGHE.CODICE'
      Size = 5
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Origin = 'T191_PARPAGHE.DESCRIZIONE'
      Size = 40
    end
    object selTabellaTIPOFILE: TStringField
      DisplayLabel = 'Tipo di supporto'
      FieldName = 'TIPOFILE'
      Origin = 'T191_PARPAGHE.TIPOFILE'
      Size = 1
    end
    object selTabellaDEFAULTENTE: TStringField
      DisplayLabel = 'Nome ente'
      FieldName = 'DEFAULTENTE'
      Origin = 'T191_PARPAGHE.DEFAULTENTE'
    end
    object selTabellaNOMEFILE: TStringField
      DisplayLabel = 'Nome file'
      FieldName = 'NOMEFILE'
      Origin = 'T191_PARPAGHE.NOMEFILE'
      Size = 80
    end
    object selTabellaDATAFILE: TStringField
      DisplayLabel = 'Formato data'
      FieldName = 'DATAFILE'
      Origin = 'T191_PARPAGHE.DATAFILE'
      Size = 10
    end
    object selTabellaFORMATOORE: TStringField
      DisplayLabel = 'Espressione dati orari'
      FieldName = 'FORMATOORE'
      Origin = 'T191_PARPAGHE.FORMATOORE'
      Size = 1
    end
    object selTabellaPRECISIONE: TStringField
      DisplayLabel = 'Precisione'
      FieldName = 'PRECISIONE'
      Origin = 'T191_PARPAGHE.PRECISIONE'
      Size = 1
    end
    object selTabellaSEPARATOREDECIMALI: TStringField
      DisplayLabel = 'Separatore dei decimali'
      FieldName = 'SEPARATOREDECIMALI'
      Size = 1
    end
    object selTabellaUSERPAGHE: TStringField
      DisplayLabel = 'Utente procedura Paghe'
      FieldName = 'USERPAGHE'
      Origin = 'T191_PARPAGHE.USERPAGHE'
    end
    object selTabellaSALVATAGGIO_AUTOMATICO: TStringField
      DisplayLabel = 'Salvataggio automatico'
      FieldName = 'SALVATAGGIO_AUTOMATICO'
      Size = 1
    end
    object selTabellaRICREAZIONE_AUTOMATICA: TStringField
      DisplayLabel = 'Ricreazione automatica'
      FieldName = 'RICREAZIONE_AUTOMATICA'
      Size = 1
    end
    object selTabellaTIPO_PARAMETRIZZAZIONE: TStringField
      FieldName = 'TIPO_PARAMETRIZZAZIONE'
      Required = True
      Visible = False
      Size = 10
    end
    object selTabellaCAMPOENTE: TStringField
      FieldName = 'CAMPOENTE'
      Origin = 'T191_PARPAGHE.CAMPOENTE'
      Visible = False
      Size = 30
    end
    object selTabellaTIPODATA_FILE: TStringField
      FieldName = 'TIPODATA_FILE'
      Visible = False
      Size = 1
    end
    object selTabellaMESEANNO: TStringField
      FieldName = 'MESEANNO'
      Origin = 'T191_PARPAGHE.MESEANNO'
      Visible = False
      Size = 10
    end
    object selTabellaTABELLAENTE: TStringField
      DisplayLabel = 'Nome file'
      FieldName = 'TABELLAENTE'
      Origin = 'T191_PARPAGHE.TABELLAENTE'
      Visible = False
      Size = 50
    end
  end
  object D192: TDataSource
    DataSet = Q192
    Left = 72
    Top = 116
  end
  object Q192: TOracleDataSet
    SQL.Strings = (
      'SELECT T192.*,T192.ROWID FROM T192_PARPAGHEDATI T192'
      'WHERE CODICE = :CODICE '
      'AND   TIPO_PARAMETRIZZAZIONE = :TIPOPAR'
      'ORDER BY POS')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A0043004F004400490043004500050000000000
      000000000000100000003A005400490050004F00500041005200050000000000
      000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000070000000C00000043004F0044004900430045000100000000000600
      000050004F005300010000000000080000004C0055004E004700010000000000
      06000000440045004600010000000000080000005400490050004F0001000000
      0000080000004E004F004D0045000100000000002C0000005400490050004F00
      5F0050004100520041004D0045005400520049005A005A0041005A0049004F00
      4E004500010000000000}
    CachedUpdates = True
    BeforePost = Q192BeforePost
    OnCalcFields = Q192CalcFields
    OnNewRecord = Q192NewRecord
    Left = 36
    Top = 116
    object Q192CODICE: TStringField
      FieldName = 'CODICE'
      Origin = 'T192_PARPAGHEDATI.CODICE'
      Visible = False
      Size = 5
    end
    object Q192TIPO: TStringField
      DisplayLabel = 'Tipo'
      DisplayWidth = 5
      FieldName = 'TIPO'
      Origin = 'T192_PARPAGHEDATI.TIPO'
      Size = 1
    end
    object Q192D_TIPO: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 25
      FieldKind = fkCalculated
      FieldName = 'D_TIPO'
      Size = 40
      Calculated = True
    end
    object Q192NOME: TStringField
      DisplayLabel = 'Nome colonna'
      DisplayWidth = 10
      FieldName = 'NOME'
      Origin = 'T192_PARPAGHEDATI.CODICE'
    end
    object Q192POS: TIntegerField
      DisplayLabel = 'Pos.'
      DisplayWidth = 4
      FieldName = 'POS'
      Required = True
    end
    object Q192LUNG: TIntegerField
      DisplayLabel = 'Lung.'
      DisplayWidth = 5
      FieldName = 'LUNG'
    end
    object Q192DEF: TStringField
      DisplayLabel = 'Default'
      DisplayWidth = 30
      FieldName = 'DEF'
      Origin = 'T192_PARPAGHEDATI.DEF'
      Size = 80
    end
    object Q192TIPO_PARAMETRIZZAZIONE: TStringField
      FieldName = 'TIPO_PARAMETRIZZAZIONE'
      Required = True
      Visible = False
      Size = 10
    end
  end
  object Del192: TOracleQuery
    SQL.Strings = (
      'DELETE FROM T192_PARPAGHEDATI '
      'WHERE CODICE = :CODICE '
      'AND   TIPO_PARAMETRIZZAZIONE = :TIPOPAR')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A0043004F004400490043004500050000000000
      000000000000100000003A005400490050004F00500041005200050000000000
      000000000000}
    Left = 120
    Top = 120
  end
end
