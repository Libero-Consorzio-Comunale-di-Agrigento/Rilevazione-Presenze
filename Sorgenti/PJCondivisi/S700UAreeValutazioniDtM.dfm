inherited S700FAreeValutazioniDtM: TS700FAreeValutazioniDtM
  OldCreateOrder = True
  OnDestroy = nil
  Height = 297
  Width = 539
  object selSG701: TOracleDataSet
    SQL.Strings = (
      'select SG701.*, SG701.rowid '
      'from SG701_AREE_VALUTAZIONI SG701'
      'order by cod_area, decorrenza, descrizione')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000050000001000000043004F0044005F00410052004500410001000000
      0000140000004400450043004F005200520045004E005A004100010000000000
      1E0000004400450043004F005200520045004E005A0041005F00460049004E00
      4500010000000000160000004400450053004300520049005A0049004F004E00
      4500010000000000200000005000450053004F005F0050004500520043004500
      4E005400550041004C004500010000000000}
    BeforePost = BeforePost
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    AfterDelete = AfterDelete
    AfterScroll = selSG701AfterScroll
    OnNewRecord = OnNewRecord
    Left = 32
    Top = 16
    object selSG701COD_AREA: TStringField
      DisplayLabel = 'Cod. area'
      FieldName = 'COD_AREA'
      Required = True
      Size = 5
    end
    object selSG701DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object selSG701DECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Scadenza'
      FieldName = 'DECORRENZA_FINE'
    end
    object selSG701DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Required = True
      Size = 100
    end
    object selSG701PESO_PERCENTUALE: TFloatField
      DisplayLabel = 'Peso %'
      FieldName = 'PESO_PERCENTUALE'
      OnValidate = selSG701PESO_PERCENTUALEValidate
      DisplayFormat = '0.00'
      Precision = 2
    end
    object selSG701PESO_PERC_MIN: TFloatField
      DisplayLabel = 'Peso % min'
      FieldName = 'PESO_PERC_MIN'
      DisplayFormat = '0.00'
      Precision = 2
    end
    object selSG701PESO_PERC_MAX: TFloatField
      DisplayLabel = 'Peso % max'
      FieldName = 'PESO_PERC_MAX'
      DisplayFormat = '0.00'
      Precision = 2
    end
    object selSG701PESO_VARIABILE_ITEMS: TStringField
      DisplayLabel = 'Elementi con peso variabile'
      FieldName = 'PESO_VARIABILE_ITEMS'
      Size = 1
    end
    object selSG701TIPO_PUNTEGGIO_ITEMS: TStringField
      DisplayLabel = 'Assegn. punteggio'
      FieldName = 'TIPO_PUNTEGGIO_ITEMS'
      Size = 1
    end
    object selSG701ITEM_TUTTI_VALUTABILI: TStringField
      DisplayLabel = 'Item tutti valutabili'
      FieldName = 'ITEM_TUTTI_VALUTABILI'
      Size = 1
    end
    object selSG701ITEM_PERSONALIZZATI_MIN: TIntegerField
      DisplayLabel = 'Minimo item personalizzati'
      FieldName = 'ITEM_PERSONALIZZATI_MIN'
      DisplayFormat = '0'
    end
    object selSG701ITEM_PERSONALIZZATI_MAX: TIntegerField
      DisplayLabel = 'Massimo item personalizzati'
      FieldName = 'ITEM_PERSONALIZZATI_MAX'
      DisplayFormat = '0'
    end
    object selSG701TIPO_PESO_PERCENTUALE: TStringField
      DisplayLabel = 'Peso % degli elementi'
      FieldName = 'TIPO_PESO_PERCENTUALE'
      Size = 1
    end
    object selSG701TIPO_LINK_ITEM: TStringField
      DisplayLabel = 'Tipo collegamento elementi'
      FieldName = 'TIPO_LINK_ITEM'
      Size = 1
    end
    object selSG701STATI_ABILITATI_PUNTEGGI: TStringField
      DisplayLabel = 'Stati abilitati punteggi'
      FieldName = 'STATI_ABILITATI_PUNTEGGI'
      Size = 200
    end
    object selSG701STATI_ABILITATI_ELEMENTI: TStringField
      DisplayLabel = 'Stati abilitati elementi'
      FieldName = 'STATI_ABILITATI_ELEMENTI'
      Size = 200
    end
    object selSG701TESTO_ITEM_PERSONALIZZATI: TStringField
      DisplayLabel = 'Testo iniziale item personalizzati'
      FieldName = 'TESTO_ITEM_PERSONALIZZATI'
      Size = 500
    end
    object selSG701PESO_EQUO_ITEMS: TStringField
      DisplayLabel = 'Peso elementi uniforme'
      FieldName = 'PESO_EQUO_ITEMS'
      Size = 1
    end
    object selSG701PUNTEGGI_SOLO_ITEM_VALUTABILI: TStringField
      DisplayLabel = 'Punteggi solo elementi valutabili'
      FieldName = 'PUNTEGGI_SOLO_ITEM_VALUTABILI'
      Size = 1
    end
  end
  object dsrSG700: TDataSource
    Left = 120
    Top = 88
  end
end
