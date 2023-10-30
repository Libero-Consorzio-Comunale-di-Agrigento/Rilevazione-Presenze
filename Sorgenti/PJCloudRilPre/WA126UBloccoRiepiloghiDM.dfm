inherited WA126FBloccoRiepiloghiDM: TWA126FBloccoRiepiloghiDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      
        'select matricola, cognome || '#39' '#39' || nome nome, t180.progressivo,' +
        ' t180.riepilogo, '
      
        '  to_char(t180.dal,'#39'mm/yyyy'#39') dadata, to_char(t180.al,'#39'mm/yyyy'#39')' +
        ' adata, t180.rowid'
      'from t180_datibloccati t180, t030_anagrafico t030'
      'where '
      '  t180.progressivo = t030.progressivo and '
      '  t180.dal <= :data2 and '
      '  t180.al >= :data1 and'
      '  riepilogo in (:riepilogo) and'
      '  t180.stato = '#39'C'#39
      ':orderby')
    Variables.Data = {
      0400000004000000100000003A004F0052004400450052004200590001000000
      00000000000000000C0000003A00440041005400410032000C00000000000000
      000000000C0000003A00440041005400410031000C0000000000000000000000
      140000003A00520049004500500049004C004F0047004F000100000004000000
      272A270000000000}
    OnCalcFields = selTabellaCalcFields
    OnFilterRecord = selTabellaFilterRecord
    object selTabellaMATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selTabellaNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Size = 61
    end
    object selTabellaRIEPILOGO: TStringField
      DisplayLabel = 'Riepilogo'
      FieldName = 'RIEPILOGO'
      Size = 5
    end
    object selTabellaD_RIEPILOGO: TStringField
      DisplayLabel = 'Descrizione'
      FieldKind = fkCalculated
      FieldName = 'D_RIEPILOGO'
      Size = 30
      Calculated = True
    end
    object selTabellaDADATA: TStringField
      DisplayLabel = 'Dal'
      FieldName = 'DADATA'
      Size = 7
    end
    object selTabellaADATA: TStringField
      DisplayLabel = 'Al'
      FieldName = 'ADATA'
      Size = 7
    end
    object selTabellaPROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
  end
end
