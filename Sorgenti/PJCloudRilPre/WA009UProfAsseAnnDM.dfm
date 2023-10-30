inherited WA009FProfAsseAnnDM: TWA009FProfAsseAnnDM
  Height = 242
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T262.*,T262.ROWID '
      'FROM T262_PROFASSANN T262 '
      ':ORDERBY')
    AfterRefreshRecord = selTabellaAfterRefreshRecord
    BeforePost = BeforePostNoStorico
    AfterPost = AfterPost
    AfterCancel = AfterCancel
    AfterDelete = AfterDelete
    OnFilterRecord = FiltroDizionario
    OnNewRecord = OnNewRecord
    Left = 24
    object selTabellaAnno: TFloatField
      DisplayWidth = 12
      FieldName = 'Anno'
      Required = True
    end
    object selTabellaRAPPORTI_UNITI: TStringField
      DisplayLabel = 'Rapporti di lavoro unificati'
      FieldName = 'RAPPORTI_UNITI'
      Visible = False
      Size = 1
    end
    object selTabellaD_Profilo: TStringField
      DisplayLabel = 'Profilo'
      DisplayWidth = 18
      FieldKind = fkLookup
      FieldName = 'D_Profilo'
      LookupDataSet = selT261
      LookupKeyFields = 'Codice'
      LookupResultField = 'Descrizione'
      KeyFields = 'CodProfilo'
      Size = 40
      Lookup = True
    end
    object selTabellaCodProfilo: TStringField
      DisplayLabel = 'Cod.profilo'
      DisplayWidth = 10
      FieldName = 'CodProfilo'
      Required = True
      Size = 5
    end
    object selTabellaCodRaggr: TStringField
      DisplayLabel = 'Cod.raggr'
      DisplayWidth = 9
      FieldName = 'CodRaggr'
      Required = True
      Size = 5
    end
    object selTabellaD_Raggruppamento: TStringField
      DisplayLabel = 'Raggruppamento'
      DisplayWidth = 19
      FieldKind = fkLookup
      FieldName = 'D_Raggruppamento'
      LookupDataSet = Q260
      LookupKeyFields = 'Codice'
      LookupResultField = 'Descrizione'
      KeyFields = 'CodRaggr'
      Size = 40
      Lookup = True
    end
    object selTabellaUMisura: TStringField
      DisplayWidth = 8
      FieldName = 'UMisura'
      Size = 1
    end
    object selTabellaCompetenza1: TStringField
      DisplayWidth = 13
      FieldName = 'Competenza1'
      Size = 7
    end
    object selTabellaRetribuzione1: TFloatField
      DisplayWidth = 13
      FieldName = 'Retribuzione1'
      Visible = False
      MaxValue = 100.000000000000000000
    end
    object selTabellaCompetenza2: TStringField
      DisplayWidth = 13
      FieldName = 'Competenza2'
      Size = 7
    end
    object selTabellaRetribuzione2: TFloatField
      DisplayWidth = 13
      FieldName = 'Retribuzione2'
      Visible = False
      MaxValue = 100.000000000000000000
    end
    object selTabellaCompetenza3: TStringField
      DisplayWidth = 13
      FieldName = 'Competenza3'
      Size = 7
    end
    object selTabellaRetribuzione3: TFloatField
      DisplayWidth = 13
      FieldName = 'Retribuzione3'
      Visible = False
      MaxValue = 100.000000000000000000
    end
    object selTabellaCompetenza4: TStringField
      DisplayWidth = 13
      FieldName = 'Competenza4'
      Size = 7
    end
    object selTabellaRetribuzione4: TFloatField
      DisplayWidth = 13
      FieldName = 'Retribuzione4'
      Visible = False
      MaxValue = 100.000000000000000000
    end
    object selTabellaCompetenza5: TStringField
      DisplayWidth = 13
      FieldName = 'Competenza5'
      Size = 7
    end
    object selTabellaRetribuzione5: TFloatField
      DisplayWidth = 13
      FieldName = 'Retribuzione5'
      Visible = False
      MaxValue = 100.000000000000000000
    end
    object selTabellaCompetenza6: TStringField
      DisplayWidth = 13
      FieldName = 'Competenza6'
      Size = 7
    end
    object selTabellaRetribuzione6: TFloatField
      DisplayWidth = 13
      FieldName = 'Retribuzione6'
      Visible = False
      MaxValue = 100.000000000000000000
    end
    object selTabellaPROPORZIONE: TStringField
      FieldName = 'PROPORZIONE'
      Visible = False
      Size = 1
    end
    object selTabellaSOMMA: TStringField
      FieldName = 'SOMMA'
      Visible = False
      Size = 1
    end
    object selTabellaMG: TStringField
      DisplayLabel = 'Mezze giornate'
      FieldName = 'MG'
      Visible = False
      Size = 1
    end
    object selTabellaARRFAV: TStringField
      FieldName = 'ARRFAV'
      Visible = False
      Size = 1
    end
    object selTabellaDATARES: TDateTimeField
      DisplayLabel = 'Residuo fruibile fino a'
      FieldName = 'DATARES'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object selTabellaPROPGGMM: TStringField
      FieldName = 'PROPGGMM'
      Visible = False
      Size = 1
    end
    object selTabellaARR_COMPETENZA_IN_ORE: TStringField
      FieldName = 'ARR_COMPETENZA_IN_ORE'
      Visible = False
      Size = 5
    end
    object selTabellaMAX_FRUIZIONE_GIORN_IN_ORE: TStringField
      FieldName = 'MAX_FRUIZIONE_GIORN_IN_ORE'
      Visible = False
      Size = 5
    end
    object selTabellaFRUIZ_ANNO_MINIMA: TStringField
      DisplayLabel = 'Fruizione minima anno corrente'
      FieldName = 'FRUIZ_ANNO_MINIMA'
      Size = 7
    end
    object selTabellaFRUIZ_MINIMA_DAL: TDateTimeField
      FieldName = 'FRUIZ_MINIMA_DAL'
      Visible = False
      DisplayFormat = 'dd/mm/yyyy'
    end
    object selTabellaCOMPETENZE_PERSONALIZZATE: TStringField
      FieldName = 'COMPETENZE_PERSONALIZZATE'
      Visible = False
    end
    object selTabellaPROPGG_INFSOGLIA: TStringField
      FieldName = 'PROPGG_INFSOGLIA'
      Size = 1
    end
  end
  inherited dsrTabella: TDataSource
    OnDataChange = dsrTabellaDataChange
  end
  object dsrT261: TDataSource
    AutoEdit = False
    DataSet = selT261
    Left = 36
    Top = 172
  end
  object D260: TDataSource
    AutoEdit = False
    DataSet = Q260
    Left = 120
    Top = 124
  end
  object D262: TDataSource
    AutoEdit = False
    DataSet = Q262
    Left = 192
    Top = 124
  end
  object selT261: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T261.*, T261.ROWID  FROM T261_DESCPROFASS T261 ORDER BY C' +
        'ODICE')
    Optimize = False
    Filtered = True
    Left = 32
    Top = 124
  end
  object Q260: TOracleDataSet
    SQL.Strings = (
      'SELECT Codice,Descrizione from T260_RaggrAssenze '
      'WHERE  ContASolare = '#39'S'#39
      'ORDER BY Codice ')
    Optimize = False
    Filtered = True
    Left = 92
    Top = 124
  end
  object Q262: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T262.ANNO,T262.CODPROFILO,T262.CODRAGGR,T260.DESCRIZIONE,' +
        'T262.UMISURA,'
      
        '               T262.COMPETENZA1,T262.COMPETENZA2,T262.COMPETENZA' +
        '3,T262.COMPETENZA4,'
      '               T262.COMPETENZA5,T262.COMPETENZA6'
      'FROM T262_ProfAssAnn T262, T260_RaggrAssenze T260'
      'WHERE  ANNO = :ANNO AND'
      '               CODPROFILO = :CODPROFILO AND'
      '               T262.CODRAGGR = T260.CODICE'
      'ORDER BY CODRAGGR')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A0041004E004E004F0003000000000000000000
      0000160000003A0043004F004400500052004F00460049004C004F0005000000
      0000000000000000}
    Left = 164
    Top = 124
    object Q262ANNO: TFloatField
      FieldName = 'ANNO'
      Origin = 'T262_PROFASSANN.ANNO'
    end
    object Q262CODPROFILO: TStringField
      DisplayLabel = 'PROFILO'
      FieldName = 'CODPROFILO'
      Origin = 'T262_PROFASSANN.CODPROFILO'
      Size = 5
    end
    object Q262CODRAGGR: TStringField
      DisplayLabel = 'ASSENZA'
      FieldName = 'CODRAGGR'
      Origin = 'T262_PROFASSANN.CODRAGGR'
      Size = 5
    end
    object Q262DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Origin = 'T260_RAGGRASSENZE.DESCRIZIONE'
      Size = 40
    end
    object Q262UMISURA: TStringField
      DisplayLabel = 'U.M.'
      FieldName = 'UMISURA'
      Origin = 'T262_PROFASSANN.UMISURA'
      Size = 1
    end
    object Q262COMPETENZA1: TStringField
      FieldName = 'COMPETENZA1'
      Origin = 'T262_PROFASSANN.COMPETENZA1'
      Size = 7
    end
    object Q262COMPETENZA2: TStringField
      FieldName = 'COMPETENZA2'
      Origin = 'T262_PROFASSANN.COMPETENZA2'
      Size = 7
    end
    object Q262COMPETENZA3: TStringField
      FieldName = 'COMPETENZA3'
      Origin = 'T262_PROFASSANN.COMPETENZA3'
      Size = 7
    end
    object Q262COMPETENZA4: TStringField
      FieldName = 'COMPETENZA4'
      Origin = 'T262_PROFASSANN.COMPETENZA4'
      Size = 7
    end
    object Q262COMPETENZA5: TStringField
      FieldName = 'COMPETENZA5'
      Origin = 'T262_PROFASSANN.COMPETENZA5'
      Size = 7
    end
    object Q262COMPETENZA6: TStringField
      FieldName = 'COMPETENZA6'
      Origin = 'T262_PROFASSANN.COMPETENZA6'
      Size = 7
    end
  end
end
