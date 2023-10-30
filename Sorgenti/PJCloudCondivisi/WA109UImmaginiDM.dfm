inherited WA109FImmaginiDM: TWA109FImmaginiDM
  Height = 182
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T004.*, T004.ROWID FROM T004_IMMAGINI T004 '
      ':ORDERBY')
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
    end
    object selTabellaDECORRENZA: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Decorrenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaDECORRENZA_FINE: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Scadenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA_FINE'
      Visible = False
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 100
    end
    object selTabellaLARGHEZZA_CEDOLINO: TIntegerField
      DisplayLabel = 'Largh.cedolino'
      FieldName = 'LARGHEZZA_CEDOLINO'
      MaxValue = 9999
      MinValue = -1
    end
    object selTabellaIMMAGINE: TBlobField
      DisplayLabel = 'Immagine'
      FieldName = 'IMMAGINE'
      Visible = False
      BlobType = ftGraphic
    end
    object selTabellaCOLONNA_AZIONI: TStringField
      DisplayLabel = ' '
      FieldKind = fkCalculated
      FieldName = 'COLONNA_AZIONI'
      OnGetText = selTabellaCOLONNA_AZIONIGetText
      Calculated = True
    end
  end
end
