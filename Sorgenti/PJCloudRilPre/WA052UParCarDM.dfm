inherited WA052FParCarDM: TWA052FParCarDM
  Height = 192
  Width = 450
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T950.*,T950.ROWID FROM T950_STAMPACARTELLINO T950'
      ':ORDERBY')
    Filtered = True
    BeforePost = BeforePostNoStorico
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    AfterDelete = AfterDelete
    OnFilterRecord = selTabellaFilterRecord
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
    object selTabellaSEPARARIGHE: TStringField
      FieldName = 'SEPARARIGHE'
      Visible = False
      Size = 1
    end
    object selTabellaSEPARADATI: TStringField
      FieldName = 'SEPARADATI'
      Visible = False
      Size = 1
    end
    object selTabellaANOMALIA: TStringField
      FieldName = 'ANOMALIA'
      Visible = False
      Size = 1
    end
    object selTabellaFESTIVO: TStringField
      FieldName = 'FESTIVO'
      Visible = False
      Size = 1
    end
    object selTabellaNONLAV: TStringField
      FieldName = 'NONLAV'
      Visible = False
      Size = 1
    end
    object selTabellaGRASSETTO: TStringField
      FieldName = 'GRASSETTO'
      Visible = False
      Size = 1
    end
    object selTabellaRAGIONE_SOCIALE: TStringField
      FieldName = 'RAGIONE_SOCIALE'
      Visible = False
      Size = 1
    end
    object selTabellaDATA_STAMPA: TStringField
      FieldName = 'DATA_STAMPA'
      Visible = False
      Size = 40
    end
    object selTabellaNUM_PAGINE: TStringField
      FieldName = 'NUM_PAGINE'
      Visible = False
      Size = 1
    end
    object selTabellaMARGINE_SUP: TIntegerField
      FieldName = 'MARGINE_SUP'
      Visible = False
    end
    object selTabellaLOGO_LARGHEZZA: TIntegerField
      FieldName = 'LOGO_LARGHEZZA'
      Visible = False
    end
    object selTabellaANOMALIE2: TStringField
      FieldName = 'ANOMALIE2'
      Visible = False
      Size = 150
    end
    object selTabellaANOMALIE3: TStringField
      FieldName = 'ANOMALIE3'
      Visible = False
      Size = 30
    end
    object selTabellaORIENTAMENTO: TStringField
      FieldName = 'ORIENTAMENTO'
      Visible = False
      Size = 1
    end
    object selTabellaCAUPRES_ESCLUSE: TStringField
      FieldName = 'CAUPRES_ESCLUSE'
      Visible = False
      Size = 1000
    end
    object selTabellaINTESTAZIONE_RIPETUTA: TStringField
      FieldName = 'INTESTAZIONE_RIPETUTA'
      Visible = False
      Size = 1
    end
    object selTabellaCAUPRES: TStringField
      FieldName = 'CAUPRES'
      Visible = False
      Size = 1000
    end
    object selTabellaCAUASS_NO_RIEPILOGO: TStringField
      FieldName = 'CAUASS_NO_RIEPILOGO'
      Visible = False
      Size = 1000
    end
    object selTabellaTIMBRATURE_MANUALI: TStringField
      FieldName = 'TIMBRATURE_MANUALI'
      Visible = False
      Size = 1
    end
    object selTabellaCARTELLINI_VALIDATI: TStringField
      FieldName = 'CARTELLINI_VALIDATI'
      Visible = False
      Size = 1
    end
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 280
    Top = 112
  end
end
