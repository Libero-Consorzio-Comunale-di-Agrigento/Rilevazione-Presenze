inherited WA036FTurniRepDM: TWA036FTurniRepDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T340.*,T340.ROWID FROM T340_TURNIREPERIB T340'
      'WHERE PROGRESSIVO =:PROGRESSIVO'
      ':ORDERBY')
    Variables.Data = {
      0400000002000000100000003A004F0052004400450052004200590001000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    BeforePost = BeforePostNoStorico
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    AfterDelete = AfterDelete
    OnCalcFields = selTabellaCalcFields
    OnNewRecord = OnNewRecord
    object selTabellaPROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Origin = 'T340_TURNIREPERIB.PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selTabellaANNO: TFloatField
      DisplayLabel = 'Anno'
      DisplayWidth = 4
      FieldName = 'ANNO'
      Origin = 'T340_TURNIREPERIB.ANNO'
      Required = True
    end
    object selTabellaMESE: TFloatField
      DisplayLabel = 'Mese'
      DisplayWidth = 2
      FieldName = 'MESE'
      Origin = 'T340_TURNIREPERIB.MESE'
      Required = True
      MaxValue = 12.000000000000000000
      MinValue = 1.000000000000000000
    end
    object selTabellaCALCMESE: TStringField
      DisplayLabel = ' '
      FieldKind = fkCalculated
      FieldName = 'CALCMESE'
      Calculated = True
    end
    object selTabellaTURNIINTERI: TFloatField
      DisplayLabel = 'Turni interi'
      DisplayWidth = 3
      FieldName = 'TURNIINTERI'
      Origin = 'T340_TURNIREPERIB.TURNIINTERI'
      MaxValue = 999.000000000000000000
    end
    object selTabellaVP_TURNO: TStringField
      DisplayLabel = 'Voce paghe '
      FieldName = 'VP_TURNO'
      OnValidate = ValidaVoce
      Size = 6
    end
    object selTabellaTURNIORE: TStringField
      DisplayLabel = 'Turni ore'
      DisplayWidth = 5
      FieldName = 'TURNIORE'
      Origin = 'T340_TURNIREPERIB.TURNIORE'
      OnValidate = ValidaOre
      EditMask = '!990:00;1;_'
      Size = 7
    end
    object selTabellaVP_ORE: TStringField
      DisplayLabel = 'Voce paghe'
      FieldName = 'VP_ORE'
      OnValidate = ValidaVoce
      Size = 6
    end
    object selTabellaOREMAGG: TStringField
      DisplayLabel = 'Ore maggiorate'
      DisplayWidth = 5
      FieldName = 'OREMAGG'
      Origin = 'T340_TURNIREPERIB.OREMAGG'
      OnValidate = ValidaOre
      EditMask = '!990:00;1;_'
      Size = 7
    end
    object selTabellaVP_MAGGIORATE: TStringField
      DisplayLabel = 'Voce paghe '
      FieldName = 'VP_MAGGIORATE'
      OnValidate = ValidaVoce
      Size = 6
    end
    object selTabellaORENONMAGG: TStringField
      DisplayLabel = 'Ore non magg'
      DisplayWidth = 5
      FieldName = 'ORENONMAGG'
      Origin = 'T340_TURNIREPERIB.ORENONMAGG'
      OnValidate = ValidaOre
      EditMask = '!990:00;1;_'
      Size = 7
    end
    object selTabellaVP_NONMAGGIORATE: TStringField
      DisplayLabel = 'Voce Paghe '
      FieldName = 'VP_NONMAGGIORATE'
      OnValidate = ValidaVoce
      Size = 6
    end
    object selTabellaGETTONE_CHIAMATA: TIntegerField
      DisplayLabel = 'Gettone chiamata'
      DisplayWidth = 3
      FieldName = 'GETTONE_CHIAMATA'
      MaxValue = 999
    end
    object selTabellaVP_GETTONE_CHIAMATA: TStringField
      DisplayLabel = 'Voce paghe'
      FieldName = 'VP_GETTONE_CHIAMATA'
      OnValidate = ValidaVoce
      Size = 6
    end
    object selTabellaTURNI_OLTREMAX: TIntegerField
      DisplayLabel = 'Eccedenza turni'
      DisplayWidth = 3
      FieldName = 'TURNI_OLTREMAX'
      MaxValue = 999
    end
    object selTabellaVP_TURNI_OLTREMAX: TStringField
      DisplayLabel = 'Voce paghe'
      FieldName = 'VP_TURNI_OLTREMAX'
      OnValidate = ValidaVoce
      Size = 6
    end
  end
end
