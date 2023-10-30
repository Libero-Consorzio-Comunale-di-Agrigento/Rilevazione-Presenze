inherited WA084FTipoRapportoDM: TWA084FTipoRapportoDM
  Height = 182
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T450.*,DECODE(T450.TIPO,'#39'R'#39','#39'Ruolo'#39','#39'S'#39','#39'Supplente'#39','#39'I'#39','#39 +
        'Incaricato'#39','#39'P'#39','#39'Prova'#39','#39'A'#39','#39'Altro'#39') D_TIPO,T450.ROWID '
      'FROM T450_TIPORAPPORTO T450 '
      ':ORDERBY')
    OnNewRecord = OnNewRecord
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Size = 5
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selTabellaTIPO: TStringField
      DisplayLabel = 'Tipologia'
      FieldName = 'TIPO'
      Visible = False
      Size = 1
    end
    object selTabellaD_TIPO: TStringField
      DisplayLabel = 'Tipologia'
      FieldKind = fkInternalCalc
      FieldName = 'D_TIPO'
      Size = 10
    end
  end
end
