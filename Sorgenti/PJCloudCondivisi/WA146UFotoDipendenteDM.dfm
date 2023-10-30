inherited WA146FFotoDipendenteDM: TWA146FFotoDipendenteDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T032.*, T032.ROWID '
      '  FROM T032_FOTODIPENDENTE T032'
      ' WHERE T032.PROGRESSIVO = :PROGRESSIVO :ORDERBY')
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A004F005200440045005200
      42005900010000000000000000000000}
    object selTabellaPROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
    end
    object selTabellaFILE_FOTO: TStringField
      DisplayWidth = 200
      FieldName = 'FILE_FOTO'
      Size = 200
    end
    object selTabellaFOTO: TBlobField
      FieldName = 'FOTO'
      Visible = False
    end
  end
end
