inherited WP552FRegoleContoAnnualeDM: TWP552FRegoleContoAnnualeDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      
        'select P552.*, DECODE(TIPO_TABELLA_RIGHE,'#39'0'#39','#39'Qualifica minister' +
        'iale'#39','#39'1'#39','#39'Altro dato libero'#39','#39'3'#39','#39'Funzione Oracle'#39','#39'2'#39','#39'Paramet' +
        'rizzabili'#39','#39#39') DESC_TIPO_TABELLA_RIGHE ,P552.rowid '
      'from p552_contoannregole P552'
      'where P552.riga = 0 and p552.colonna = 0'
      ':ORDERBY')
    OnNewRecord = OnNewRecord
    object selTabellaANNO: TIntegerField
      DisplayLabel = 'Anno'
      FieldName = 'ANNO'
    end
    object selTabellaCOD_TABELLA: TStringField
      DisplayLabel = 'Tabella'
      FieldName = 'COD_TABELLA'
      Size = 10
    end
    object selTabellaRIGA: TIntegerField
      DisplayLabel = 'Riga'
      FieldName = 'RIGA'
      Visible = False
    end
    object selTabellaCOLONNA: TIntegerField
      DisplayLabel = 'Colonna'
      FieldName = 'COLONNA'
      Visible = False
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 200
    end
    object selTabellaTIPO_TABELLA_RIGHE: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO_TABELLA_RIGHE'
      Visible = False
      Size = 1
    end
    object selTabellaDESC_TIPO_TABELLA_RIGHE: TStringField
      DisplayLabel = 'Tipologia righe'
      FieldKind = fkInternalCalc
      FieldName = 'DESC_TIPO_TABELLA_RIGHE'
      Size = 50
    end
    object selTabellaVALORE_COSTANTE: TStringField
      DisplayLabel = 'Parametro'
      FieldName = 'VALORE_COSTANTE'
      Size = 500
    end
    object selTabellaCOD_ARROTONDAMENTO: TStringField
      DisplayLabel = 'Arrotondamento'
      FieldName = 'COD_ARROTONDAMENTO'
      Visible = False
      Size = 5
    end
    object selTabellaCODICI_ACCORPAMENTOVOCI: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICI_ACCORPAMENTOVOCI'
      Visible = False
      Size = 500
    end
    object selTabellaREGOLA_CALCOLO_AUTOMATICA: TStringField
      DisplayLabel = 'Regola automatica'
      DisplayWidth = 4000
      FieldName = 'REGOLA_CALCOLO_AUTOMATICA'
      Visible = False
      Size = 4000
    end
    object selTabellaREGOLA_CALCOLO_MANUALE: TStringField
      DisplayLabel = 'Regola manuale'
      FieldName = 'REGOLA_CALCOLO_MANUALE'
      Visible = False
      Size = 4000
    end
    object selTabellaREGOLA_MODIFICABILE: TStringField
      DisplayLabel = 'Regola Modificabile'
      FieldName = 'REGOLA_MODIFICABILE'
      Visible = False
      Size = 1
    end
    object selTabellaNUMERO_TREDCORR: TStringField
      DisplayLabel = 'Tredicesiam AA corr.'
      FieldName = 'NUMERO_TREDCORR'
      Visible = False
      Size = 15
    end
    object selTabellaNUMERO_TREDPREC: TStringField
      DisplayLabel = 'Tredicesima AA prec.'
      FieldName = 'NUMERO_TREDPREC'
      Visible = False
      Size = 15
    end
    object selTabellaNUMERO_ARRCORR: TStringField
      DisplayLabel = 'Arretrati AA corr.'
      FieldName = 'NUMERO_ARRCORR'
      Visible = False
      Size = 15
    end
    object selTabellaNUMERO_ARRPREC: TStringField
      DisplayLabel = 'Arretrati AA prec.'
      FieldName = 'NUMERO_ARRPREC'
      Visible = False
      Size = 15
    end
    object selTabellaDATA_ACCORPAMENTO: TStringField
      DisplayLabel = 'Modalita accorpamento'
      FieldName = 'DATA_ACCORPAMENTO'
      Visible = False
      Size = 2
    end
    object selTabellaFILTRO_DIPENDENTI: TStringField
      DisplayLabel = 'Filtro dipendenti'
      FieldName = 'FILTRO_DIPENDENTI'
      Visible = False
      Size = 1500
    end
    object selTabellaSCRIPT_INIZIALE: TStringField
      DisplayLabel = 'Script iniziale'
      FieldName = 'SCRIPT_INIZIALE'
      ReadOnly = True
      Visible = False
      Size = 1500
    end
  end
end
