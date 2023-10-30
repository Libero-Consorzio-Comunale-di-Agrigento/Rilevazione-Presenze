inherited WA188FCampiAnagrafeDM: TWA188FCampiAnagrafeDM
  Height = 129
  Width = 299
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT I010.*,I010.ROWID FROM I010_CAMPIANAGRAFICI I010 '
      'WHERE APPLICAZIONE = DECODE(:APPLICAZIONE,'#39'PAGHE'#39','#39'PAGHE'#39','#39'*'#39')'
      ' :ORDERBY')
    Variables.Data = {
      04000000020000001A0000003A004100500050004C004900430041005A004900
      4F004E004500050000000000000000000000100000003A004F00520044004500
      520042005900010000000000000000000000}
    AfterOpen = selTabellaAfterOpen
    BeforeInsert = BeforeInsert
    AfterPost = AfterPost
    BeforeDelete = BeforeInsert
    OnPostError = selTabellaPostError
    object selTabellaNOME_CAMPO: TStringField
      DisplayLabel = 'Nome dato'
      DisplayWidth = 20
      FieldName = 'NOME_CAMPO'
      Size = 40
    end
    object selTabellaNOME_LOGICO: TStringField
      DisplayLabel = 'Ridefinito'
      DisplayWidth = 20
      FieldName = 'NOME_LOGICO'
      Size = 40
    end
    object selTabellaPOSIZIONE: TFloatField
      DisplayLabel = 'Posizione'
      DisplayWidth = 5
      FieldName = 'POSIZIONE'
      Precision = 2
    end
    object selTabellaRICERCA: TIntegerField
      DisplayLabel = 'Ricerca'
      DisplayWidth = 5
      FieldName = 'RICERCA'
    end
    object selTabellaVAL_DEFAULT: TStringField
      DisplayLabel = 'Default'
      DisplayWidth = 5
      FieldName = 'VAL_DEFAULT'
      Size = 50
    end
    object selTabellaAPPLICAZIONE: TStringField
      FieldName = 'APPLICAZIONE'
      Visible = False
      Size = 6
    end
    object selTabellaPROVVEDIMENTO: TStringField
      DisplayLabel = 'Provv.'
      FieldName = 'PROVVEDIMENTO'
      Size = 1
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
