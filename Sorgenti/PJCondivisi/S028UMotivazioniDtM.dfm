inherited S028FMotivazioniDtM: TS028FMotivazioniDtM
  OldCreateOrder = True
  Height = 182
  object selSG104: TOracleDataSet
    SQL.Strings = (
      'SELECT SG104.*,SG104.ROWID FROM SG104_TIPOMOTIVAZIONI SG104'
      'ORDER BY CODICE')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000060000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000001E00
      00004400450053004300520049005A0049004F004E0045005F00410047004700
      010000000000200000005300540041004D00500041005F00460041004D004900
      4C0049004100520049000100000000002400000045004C0045004E0043004F00
      5F004E0055004D004500520049005F0050005200450043000100000000002400
      000045004C0045004E0043004F005F004E0055004D004500520049005F005300
      550043004300010000000000}
    Left = 48
    Top = 32
    object selSG104CODICE: TStringField
      DisplayLabel = 'Codice'
      DisplayWidth = 10
      FieldName = 'CODICE'
      Required = True
      Size = 5
    end
    object selSG104DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 100
      FieldName = 'DESCRIZIONE'
      Size = 130
    end
    object selSG104DESCRIZIONE_AGG: TStringField
      DisplayLabel = 'Desc.aggiuntiva'
      DisplayWidth = 100
      FieldName = 'DESCRIZIONE_AGG'
      Size = 200
    end
    object selSG104STAMPA_FAMILIARI: TStringField
      FieldName = 'STAMPA_FAMILIARI'
      Required = True
      Visible = False
      Size = 1
    end
    object selSG104ELENCO_NUMERI_PREC: TStringField
      FieldName = 'ELENCO_NUMERI_PREC'
      Visible = False
      Size = 500
    end
    object selSG104ELENCO_NUMERI_SUCC: TStringField
      FieldName = 'ELENCO_NUMERI_SUCC'
      Visible = False
      Size = 500
    end
  end
end
