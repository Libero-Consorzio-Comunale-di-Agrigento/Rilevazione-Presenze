inherited WA136FRelazioniAnagrafeDM: TWA136FRelazioniAnagrafeDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      
        'SELECT I030.ROWID, I030.*, DECODE(I030.TIPO,'#39'S'#39','#39'Ass. aut. vinco' +
        'lata'#39','#39'L'#39','#39'Ass. aut. libera'#39','#39'F'#39','#39'Ass. filtrata'#39') D_TIPO'
      'FROM   I030_RELAZIONI_ANAGRAFE I030'
      ':ORDERBY')
    BeforePost = BeforePost
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    OnCalcFields = selTabellaCalcFields
    object selTabellaTABELLA: TStringField
      DisplayLabel = 'Tabella'
      FieldName = 'TABELLA'
    end
    object selTabellaCOLONNA: TStringField
      DisplayLabel = 'Colonna'
      FieldName = 'COLONNA'
      Size = 40
    end
    object selTabellaDECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
    end
    object selTabellaDECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Decorrenza fine'
      FieldName = 'DECORRENZA_FINE'
      Visible = False
    end
    object selTabellaORDINE: TIntegerField
      DisplayLabel = 'Ordine'
      FieldName = 'ORDINE'
      Required = True
    end
    object selTabellaTIPO: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO'
    end
    object selTabellaD_TIPO: TStringField
      DisplayLabel = 'Descrizione tipo'
      FieldKind = fkInternalCalc
      FieldName = 'D_TIPO'
    end
    object selTabellaTAB_ORIGINE: TStringField
      DisplayLabel = 'Tabella origine'
      FieldName = 'TAB_ORIGINE'
    end
    object selTabellaCOL_ORIGINE: TStringField
      DisplayLabel = 'Colonna origine'
      DisplayWidth = 40
      FieldKind = fkCalculated
      FieldName = 'COL_ORIGINE'
      Size = 40
      Calculated = True
    end
  end
end
