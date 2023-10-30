inherited WA198FDatiCalcolatiDM: TWA198FDatiCalcolatiDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T909.*,T909.ROWID'
      '  FROM T909_DATICALCOLATI T909'
      ' WHERE T909.APPLICAZIONE = :APPLICAZIONE '
      ':FILTRO'
      ':ORDERBY'
      '')
    Variables.Data = {
      0400000003000000100000003A004F0052004400450052004200590001000000
      00000000000000001A0000003A004100500050004C004900430041005A004900
      4F004E0045000500000000000000000000000E0000003A00460049004C005400
      52004F00010000000000000000000000}
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    OnCalcFields = selTabellaCalcFields
    OnNewRecord = OnNewRecord
    object selTabellaAPPLICAZIONE: TStringField
      FieldName = 'APPLICAZIONE'
      Required = True
      Visible = False
      Size = 6
    end
    object selTabellaCODICE_STAMPA: TStringField
      DisplayLabel = 'Codice stampa'
      FieldName = 'CODICE_STAMPA'
    end
    object selTabellaID_SERBATOIO: TIntegerField
      DisplayLabel = 'Serbatoio'
      FieldName = 'ID_SERBATOIO'
      Required = True
      Visible = False
    end
    object selTabellaD_SERBATOIO: TStringField
      DisplayLabel = 'Serbatoio'
      FieldKind = fkCalculated
      FieldName = 'D_SERBATOIO'
      Calculated = True
    end
    object selTabellaNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Required = True
      Size = 40
    end
    object selTabellaTIPO: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO'
      Required = True
      Visible = False
      Size = 1
    end
    object selTabellaESPRESSIONE: TStringField
      DisplayLabel = 'Espressione'
      FieldName = 'ESPRESSIONE'
      Required = True
      Size = 2000
    end
  end
end
