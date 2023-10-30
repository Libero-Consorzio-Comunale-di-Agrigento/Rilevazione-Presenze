inherited WA141FRegoleRiposiDM: TWA141FRegoleRiposiDM
  Height = 446
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select t267.*,t267.rowid from t267_regoleriposi t267 '
      ':ORDERBY')
    AfterPost = AfterPost
    AfterCancel = AfterCancel
    AfterDelete = AfterDelete
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 60
    end
    object selTabellaTIPO_CAUSALE: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO_CAUSALE'
      Size = 1
    end
    object selTabellaRIPOSO_ORDINARIO: TStringField
      DisplayLabel = 'Riposo'
      FieldName = 'RIPOSO_ORDINARIO'
      Size = 5
    end
    object selTabellaRIPOSO_COMPENSATIVO: TStringField
      DisplayLabel = 'Riposo comp.'
      FieldName = 'RIPOSO_COMPENSATIVO'
      Size = 5
    end
    object selTabellaRIPOSO_COMPENSATIVO_SALDONEG: TStringField
      DisplayLabel = 'Riposo comp. saldo neg.'
      FieldName = 'RIPOSO_COMPENSATIVO_SALDONEG'
      Size = 5
    end
    object selTabellaRIPOSO_MESEPREC: TStringField
      DisplayLabel = 'Riposo mese prec.'
      FieldName = 'RIPOSO_MESEPREC'
      Size = 5
    end
    object selTabellaRIPOSO_LAVORATO: TStringField
      DisplayLabel = 'Riposo lavorato'
      FieldName = 'RIPOSO_LAVORATO'
      Size = 5
    end
    object selTabellaCANCELLAZIONE_CAUSALE: TStringField
      FieldName = 'CANCELLAZIONE_CAUSALE'
      Visible = False
      Size = 1
    end
    object selTabellaPERSONALE_NON_TURNISTA: TStringField
      FieldName = 'PERSONALE_NON_TURNISTA'
      Visible = False
      Size = 1
    end
    object selTabellaSMONTO_NOTTE: TStringField
      FieldName = 'SMONTO_NOTTE'
      Visible = False
      Size = 1
    end
    object selTabellaLIMITE_SALDO: TStringField
      FieldName = 'LIMITE_SALDO'
      Visible = False
      Size = 1
    end
    object selTabellaPRIORITA_FESTIVI: TStringField
      FieldName = 'PRIORITA_FESTIVI'
      Visible = False
      Size = 1
    end
    object selTabellaGGNONLAV_CON_TIMBRATURE: TStringField
      FieldName = 'GGNONLAV_CON_TIMBRATURE'
      Visible = False
      Size = 1
    end
    object selTabellaSOLO_SE_NON_REPERIBILE: TStringField
      FieldName = 'SOLO_SE_NON_REPERIBILE'
      Visible = False
      Size = 1
    end
    object selTabellaDOMENICA_GIUSTIFICATA: TStringField
      FieldName = 'DOMENICA_GIUSTIFICATA'
      Visible = False
      Size = 1
    end
    object selTabellaGGNONLAV_GIUSTIFICATO: TStringField
      FieldName = 'GGNONLAV_GIUSTIFICATO'
      Visible = False
      Size = 1
    end
    object selTabellaGGCALEND_GIUSTIFICATO: TStringField
      FieldName = 'GGCALEND_GIUSTIFICATO'
      Visible = False
      Size = 1
    end
    object selTabellaCAUS_PRESENZA_TOLLERATE: TStringField
      FieldName = 'CAUS_PRESENZA_TOLLERATE'
      Visible = False
      Size = 2000
    end
    object selTabellaCAUS_ASSENZA_NONTOLLERATE: TStringField
      FieldName = 'CAUS_ASSENZA_NONTOLLERATE'
      Visible = False
      Size = 2000
    end
    object selTabellaGGFEST_GIUSTIFICATO: TStringField
      FieldName = 'GGFEST_GIUSTIFICATO'
      Visible = False
      Size = 1
    end
    object selTabellaGIUST_NONELABORATI: TStringField
      FieldName = 'GIUST_NONELABORATI'
      Size = 1
    end
  end
  object selT265: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T265.CODICE,T265.DESCRIZIONE,GSIGNIFIC, UMCUMULO, CQ_PROG' +
        'RESSIVO, CQ_FESTIVI, CQ_GGNONLAV, UM_INSERIMENTO, CODINTERNO'
      'FROM T265_CAUASSENZE T265, T260_RAGGRASSENZE T260'
      'WHERE T265.CODRAGGR = T260.CODICE'
      'ORDER BY CODICE')
    Optimize = False
    Filtered = True
    Left = 104
    Top = 126
  end
  object selT275: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE,ORENORMALI '
      'FROM T275_CAUPRESENZE '
      'ORDER BY CODICE')
    Optimize = False
    Filtered = True
    Left = 176
    Top = 126
    object selT275CODICE: TStringField
      FieldName = 'CODICE'
      Origin = 'T275_CAUPRESENZE.CODICE'
      Size = 5
    end
    object selT275DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Origin = 'T275_CAUPRESENZE.DESCRIZIONE'
      Size = 40
    end
    object selT275ORENORMALI: TStringField
      FieldName = 'ORENORMALI'
      Origin = 'T275_CAUPRESENZE.ORENORMALI'
      Size = 1
    end
  end
  object selInterfaccia: TOracleDataSet
    Optimize = False
    Left = 272
    Top = 128
  end
  object dsrInterfaccia: TDataSource
    DataSet = selInterfaccia
    Left = 272
    Top = 184
  end
  object QCausale1: TOracleDataSet
    SQL.Strings = (
      'SELECT T265.CODICE T265CODICE, '
      '       T265.DESCRIZIONE T265DESCRIZIONE,'
      '       T265.CODRAGGR T265CODRAGGR'
      'FROM T265_CAUASSENZE T265'
      'ORDER BY T265.CODICE')
    Optimize = False
    Filtered = True
    Left = 92
    Top = 189
    object QCausale1T265CODICE: TStringField
      DisplayWidth = 8
      FieldName = 'T265CODICE'
      Origin = 'T265_CAUASSENZE.CODICE'
      Size = 5
    end
    object QCausale1T265DESCRIZIONE: TStringField
      FieldName = 'T265DESCRIZIONE'
      Origin = 'T265_CAUASSENZE.DESCRIZIONE'
      Size = 40
    end
    object QCausale1T265CODRAGGR: TStringField
      FieldName = 'T265CODRAGGR'
      Origin = 'T265_CAUASSENZE.CODRAGGR'
      Size = 5
    end
  end
  object DCausale1: TDataSource
    DataSet = QCausale1
    Left = 17
    Top = 190
  end
  object DCausale2: TDataSource
    DataSet = QCausale2
    Left = 16
    Top = 236
  end
  object QCausale2: TOracleDataSet
    SQL.Strings = (
      'SELECT T265.CODICE T265CODICE, '
      '       T265.DESCRIZIONE T265DESCRIZIONE,'
      '       T265.CODRAGGR T265CODRAGGR'
      'FROM T265_CAUASSENZE T265'
      'ORDER BY T265.CODICE')
    Optimize = False
    Filtered = True
    Left = 92
    Top = 237
    object QCausale2T265CODICE: TStringField
      DisplayWidth = 8
      FieldName = 'T265CODICE'
      Origin = 'T265_CAUASSENZE.CODICE'
      Size = 5
    end
    object QCausale2T265DESCRIZIONE: TStringField
      FieldName = 'T265DESCRIZIONE'
      Origin = 'T265_CAUASSENZE.DESCRIZIONE'
      Size = 40
    end
    object QCausale2T265CODRAGGR: TStringField
      FieldName = 'T265CODRAGGR'
      Origin = 'T265_CAUASSENZE.CODRAGGR'
      Size = 5
    end
  end
  object QCausale3: TOracleDataSet
    SQL.Strings = (
      'SELECT T265.CODICE T265CODICE, '
      '       T265.DESCRIZIONE T265DESCRIZIONE,'
      '       T265.CODRAGGR T265CODRAGGR'
      'FROM T265_CAUASSENZE T265'
      'ORDER BY T265.CODICE')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      050000000300000014000000540032003600350043004F004400490043004500
      0100000000001E00000054003200360035004400450053004300520049005A00
      49004F004E00450001000000000018000000540032003600350043004F004400
      52004100470047005200010000000000}
    Filtered = True
    Left = 92
    Top = 289
    object QCausale3T265CODICE: TStringField
      DisplayWidth = 8
      FieldName = 'T265CODICE'
      Required = True
      Size = 5
    end
    object QCausale3T265DESCRIZIONE: TStringField
      FieldName = 'T265DESCRIZIONE'
      Size = 40
    end
    object QCausale3T265CODRAGGR: TStringField
      FieldName = 'T265CODRAGGR'
      Size = 5
    end
  end
  object DCausale3: TDataSource
    DataSet = QCausale3
    Left = 16
    Top = 289
  end
  object DCausale4: TDataSource
    DataSet = QCausale4
    Left = 16
    Top = 337
  end
  object QCausale4: TOracleDataSet
    SQL.Strings = (
      'SELECT T265.CODICE T265CODICE, '
      '       T265.DESCRIZIONE T265DESCRIZIONE'
      'FROM T265_CAUASSENZE T265'
      'ORDER BY T265.CODICE')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      050000000300000014000000540032003600350043004F004400490043004500
      0100000000001E00000054003200360035004400450053004300520049005A00
      49004F004E00450001000000000018000000540032003600350043004F004400
      52004100470047005200010000000000}
    Filtered = True
    Left = 92
    Top = 337
    object QCausale4T265CODICE: TStringField
      FieldName = 'T265CODICE'
      Size = 5
    end
    object QCausale4T265DESCRIZIONE: TStringField
      FieldName = 'T265DESCRIZIONE'
      Size = 40
    end
  end
  object DCausaleNeg: TDataSource
    DataSet = QCausaleNeg
    Left = 16
    Top = 393
  end
  object QCausaleNeg: TOracleDataSet
    SQL.Strings = (
      'SELECT T265.CODICE T265CODICE, '
      '       T265.DESCRIZIONE T265DESCRIZIONE'
      'FROM T265_CAUASSENZE T265'
      'ORDER BY T265.CODICE')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      050000000300000014000000540032003600350043004F004400490043004500
      0100000000001E00000054003200360035004400450053004300520049005A00
      49004F004E00450001000000000018000000540032003600350043004F004400
      52004100470047005200010000000000}
    Filtered = True
    Left = 92
    Top = 393
    object StringField1: TStringField
      FieldName = 'T265CODICE'
      Size = 5
    end
    object StringField2: TStringField
      FieldName = 'T265DESCRIZIONE'
      Size = 40
    end
  end
end
