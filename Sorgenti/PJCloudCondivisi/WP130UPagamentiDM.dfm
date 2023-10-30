inherited WP130FPagamentiDM: TWP130FPagamentiDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT P130.*,P130.ROWID FROM P130_PAGAMENTI P130'
      ':ORDERBY')
    QBEDefinition.QBEFieldDefs = {
      05000000030000001A00000043004F0044005F0050004100470041004D004500
      4E0054004F00010000000000160000004400450053004300520049005A004900
      4F004E0045000100000000001A0000004D004F0044005F005000410047004100
      4D0045004E0054004F00010000000000}
    object selTabellaCOD_PAGAMENTO: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'COD_PAGAMENTO'
      Required = True
      Size = 5
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selTabellaMOD_PAGAMENTO: TStringField
      DisplayLabel = 'Modalit'#224' di pagamento record 10 tracciato SETIF/CBI'
      FieldName = 'MOD_PAGAMENTO'
      Size = 1
    end
  end
end
