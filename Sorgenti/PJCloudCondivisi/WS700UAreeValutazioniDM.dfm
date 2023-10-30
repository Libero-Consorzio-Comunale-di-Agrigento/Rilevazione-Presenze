inherited WS700FAreeValutazioniDM: TWS700FAreeValutazioniDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select SG701.*, SG701.rowid '
      'from SG701_AREE_VALUTAZIONI SG701'
      ':ORDERBY'
      '--order by cod_area, decorrenza, descrizione')
    BeforePost = BeforePost
    AfterPost = selTabellaAfterPost
    BeforeDelete = selTabellaBeforeDelete
    OnNewRecord = selTabellaNewRecord
    object selTabellaCOD_AREA: TStringField
      DisplayLabel = 'Cod. area'
      FieldName = 'COD_AREA'
      Size = 5
    end
    object selTabellaDECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object selTabellaDECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Scadenza'
      FieldName = 'DECORRENZA_FINE'
      Visible = False
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Required = True
      Size = 100
    end
    object selTabellaPESO_PERCENTUALE: TFloatField
      DisplayLabel = 'Peso %'
      FieldName = 'PESO_PERCENTUALE'
      OnValidate = selTabellaPESO_PERCENTUALEValidate
      DisplayFormat = '0.00'
      Precision = 2
    end
    object selTabellaPESO_PERC_MIN: TFloatField
      DisplayLabel = 'Peso % min'
      FieldName = 'PESO_PERC_MIN'
      DisplayFormat = '0.00'
      Precision = 2
    end
    object selTabellaPESO_PERC_MAX: TFloatField
      DisplayLabel = 'Peso % max'
      FieldName = 'PESO_PERC_MAX'
      DisplayFormat = '0.00'
      Precision = 2
    end
    object selTabellaTIPO_LINK_ITEM: TStringField
      DisplayLabel = 'Tipo collegamento elementi'
      FieldName = 'TIPO_LINK_ITEM'
      Size = 1
    end
    object selTabellaPESO_VARIABILE_ITEMS: TStringField
      DisplayLabel = 'Peso % Modificabile'
      FieldName = 'PESO_VARIABILE_ITEMS'
      Size = 1
    end
    object selTabellaPESO_EQUO_ITEMS: TStringField
      DisplayLabel = 'Peso % uniforme'
      FieldName = 'PESO_EQUO_ITEMS'
      Size = 1
    end
    object selTabellaITEM_TUTTI_VALUTABILI: TStringField
      DisplayLabel = 'Elementi tutti valutabili'
      FieldName = 'ITEM_TUTTI_VALUTABILI'
      Size = 1
    end
    object selTabellaPUNTEGGI_SOLO_ITEM_VALUTABILI: TStringField
      DisplayLabel = 'Punteggi solo elementi valutabili'
      FieldName = 'PUNTEGGI_SOLO_ITEM_VALUTABILI'
      Size = 1
    end
    object selTabellaTIPO_PUNTEGGIO_ITEMS: TStringField
      DisplayLabel = 'Assegnazione punteggio'
      FieldName = 'TIPO_PUNTEGGIO_ITEMS'
      Size = 1
    end
    object selTabellaITEM_PERSONALIZZATI_MIN: TIntegerField
      DisplayLabel = 'Minimo item personalizzati'
      FieldName = 'ITEM_PERSONALIZZATI_MIN'
    end
    object selTabellaITEM_PERSONALIZZATI_MAX: TIntegerField
      DisplayLabel = 'Massimo item personalizzati'
      FieldName = 'ITEM_PERSONALIZZATI_MAX'
    end
    object selTabellaTIPO_PESO_PERCENTUALE: TStringField
      DisplayLabel = 'Peso % degli elementi'
      FieldName = 'TIPO_PESO_PERCENTUALE'
      Size = 1
    end
    object selTabellaTESTO_ITEM_PERSONALIZZATI: TStringField
      DisplayLabel = 'Testo iniziale item personalizzati'
      FieldName = 'TESTO_ITEM_PERSONALIZZATI'
      Size = 500
    end
    object selTabellaSTATI_ABILITATI_ELEMENTI: TStringField
      DisplayLabel = 'Configurazione elementi'
      FieldName = 'STATI_ABILITATI_ELEMENTI'
      Size = 200
    end
    object selTabellaSTATI_ABILITATI_PUNTEGGI: TStringField
      DisplayLabel = 'Assegnazione punteggio'
      FieldName = 'STATI_ABILITATI_PUNTEGGI'
      Size = 200
    end
  end
  object dsrSG700: TDataSource
    Left = 104
    Top = 64
  end
end
