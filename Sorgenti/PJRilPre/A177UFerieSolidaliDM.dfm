inherited A177FFerieSolidaliDM: TA177FFerieSolidaliDM
  OldCreateOrder = True
  object selT254: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid from T254_FERIESOLIDALI t'
      ' where T.PROGRESSIVO = :PROGRESSIVO'
      ' order by T.DECORRENZA DESC, T.ID_RICHIESTA, T.CODRAGGR')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000001200000016000000500052004F004700520045005300530049005600
      4F00010000000000080000005400490050004F00010000000000100000004300
      4F004400520041004700470052000100000000000800000041004E004E004F00
      010000000000140000004400450043004F005200520045004E005A0041000100
      0000000018000000490044005F00520049004300480049004500530054004100
      010000000000160000004400450053004300520049005A0049004F004E004500
      0100000000001E0000004400450043004F005200520045004E005A0041005F00
      460049004E0045000100000000001E0000005400450052004D0049004E004500
      5F004400490052004900540054004F000100000000000A000000530054004100
      54004F000100000000000E000000430041005500530041004C00450001000000
      00000E00000055004D0049005300550052004100010000000000240000005100
      550041004E0054004900540041005F0052004900430048004900450053005400
      4100010000000000200000005100550041004E0054004900540041005F004F00
      460046004500520054004100010000000000220000005100550041004E005400
      4900540041005F004F005400540045004E005500540041000100000000001C00
      000043004F004500460046005F005100550041004E0054004900540041000100
      00000000240000005100550041004E0054004900540041005F00410043004300
      450054005400410054004100010000000000260000005100550041004E005400
      4900540041005F00520045005300540049005400550049005400410001000000
      0000}
    BeforeInsert = BeforeInsert
    BeforePost = selT254BeforePost
    AfterPost = selT254AfterPost
    BeforeDelete = BeforeDelete
    AfterDelete = AfterDelete
    AfterScroll = selT254AfterScroll
    OnCalcFields = selT254CalcFields
    OnNewRecord = selT254NewRecord
    Left = 24
    Top = 16
    object selT254PROGRESSIVO: TIntegerField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selT254TIPO: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO'
      Required = True
      Size = 1
    end
    object selT254ANNO: TFloatField
      DisplayLabel = 'Anno'
      DisplayWidth = 4
      FieldName = 'ANNO'
      Required = True
    end
    object selT254DECORRENZA: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Decorrenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA'
      Required = True
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selT254DECORRENZA_FINE: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Scadenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA_FINE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selT254ID_RICHIESTA: TFloatField
      DisplayLabel = 'N.Rich.'
      DisplayWidth = 5
      FieldName = 'ID_RICHIESTA'
      Required = True
    end
    object selT254DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 30
      FieldName = 'DESCRIZIONE'
      Visible = False
      Size = 100
    end
    object selT254DESCR_OFFERTA: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'DESCR_OFFERTA'
      Size = 100
      Calculated = True
    end
    object selT254STATO: TStringField
      DisplayLabel = 'Stato'
      FieldName = 'STATO'
      Required = True
      Size = 1
    end
    object selT254CODRAGGR: TStringField
      DisplayLabel = 'Raggruppamento'
      FieldName = 'CODRAGGR'
      Required = True
      Visible = False
      Size = 5
    end
    object selT254DESCR_RAGGR: TStringField
      DisplayLabel = 'Raggruppamento'
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'DESCR_RAGGR'
      Size = 100
      Calculated = True
    end
    object selT254CAUSALE: TStringField
      DisplayLabel = 'Causale'
      FieldName = 'CAUSALE'
      Visible = False
      Size = 5
    end
    object selT254UMISURA: TStringField
      DisplayLabel = 'U.M.'
      FieldName = 'UMISURA'
      Required = True
      Size = 1
    end
    object selT254QUANTITA_RICHIESTA: TStringField
      DisplayLabel = 'Q.Richiesta'
      FieldName = 'QUANTITA_RICHIESTA'
      OnValidate = selT254QUANTITA_RICHIESTAValidate
      Size = 7
    end
    object selT254QUANTITA_OTTENUTA: TStringField
      DisplayLabel = 'Q.Ottenuta'
      FieldName = 'QUANTITA_OTTENUTA'
      Size = 7
    end
    object selT254QUANTITA_OFFERTA: TStringField
      DisplayLabel = 'Q.Offerta'
      FieldName = 'QUANTITA_OFFERTA'
      OnValidate = selT254QUANTITA_RICHIESTAValidate
      Size = 7
    end
    object selT254QUANTITA_ACCETTATA: TStringField
      DisplayLabel = 'Q.Accettata'
      FieldName = 'QUANTITA_ACCETTATA'
      Size = 7
    end
    object selT254TERMINE_DIRITTO: TDateTimeField
      DisplayLabel = 'Termine diritto'
      DisplayWidth = 10
      FieldName = 'TERMINE_DIRITTO'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selT254QUANTITA_RESTITUITA: TStringField
      DisplayLabel = 'Q.Restituita'
      FieldName = 'QUANTITA_RESTITUITA'
      Size = 7
    end
  end
  object selT254Vis: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid from T254_FERIESOLIDALI t'
      ' where T.PROGRESSIVO = :PROGRESSIVO'
      ' order by T.DECORRENZA DESC, T.ID_RICHIESTA, T.CODRAGGR')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000001100000016000000500052004F004700520045005300530049005600
      4F00010000000000080000005400490050004F00010000000000100000004300
      4F004400520041004700470052000100000000000800000041004E004E004F00
      010000000000140000004400450043004F005200520045004E005A0041000100
      0000000018000000490044005F00520049004300480049004500530054004100
      010000000000160000004400450053004300520049005A0049004F004E004500
      0100000000001E0000004400450043004F005200520045004E005A0041005F00
      460049004E0045000100000000001E0000005400450052004D0049004E004500
      5F004400490052004900540054004F000100000000000A000000530054004100
      54004F000100000000000E000000430041005500530041004C00450001000000
      00000E00000055004D0049005300550052004100010000000000240000005100
      550041004E0054004900540041005F0052004900430048004900450053005400
      4100010000000000200000005100550041004E0054004900540041005F004F00
      460046004500520054004100010000000000220000005100550041004E005400
      4900540041005F004F005400540045004E005500540041000100000000002400
      00005100550041004E0054004900540041005F00410043004300450054005400
      410054004100010000000000260000005100550041004E005400490054004100
      5F005200450053005400490054005500490054004100010000000000}
    AfterScroll = selT254VisAfterScroll
    OnCalcFields = selT254CalcFields
    Left = 104
    Top = 16
    object IntegerField1: TIntegerField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object StringField1: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO'
      Required = True
      Size = 1
    end
    object FloatField1: TFloatField
      DisplayLabel = 'Anno'
      DisplayWidth = 4
      FieldName = 'ANNO'
      Required = True
    end
    object DateTimeField1: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Decorrenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA'
      Required = True
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object DateTimeField2: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Scadenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA_FINE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object FloatField2: TFloatField
      DisplayLabel = 'N.Rich.'
      DisplayWidth = 5
      FieldName = 'ID_RICHIESTA'
      Required = True
    end
    object StringField2: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 30
      FieldName = 'DESCRIZIONE'
      Visible = False
      Size = 100
    end
    object StringField3: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'DESCR_OFFERTA'
      Size = 100
      Calculated = True
    end
    object StringField4: TStringField
      DisplayLabel = 'Stato'
      FieldName = 'STATO'
      Required = True
      Size = 1
    end
    object StringField5: TStringField
      DisplayLabel = 'Raggruppamento'
      FieldName = 'CODRAGGR'
      Required = True
      Visible = False
      Size = 5
    end
    object StringField6: TStringField
      DisplayLabel = 'Raggruppamento'
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'DESCR_RAGGR'
      Size = 100
      Calculated = True
    end
    object StringField7: TStringField
      DisplayLabel = 'Causale'
      FieldName = 'CAUSALE'
      Visible = False
      Size = 5
    end
    object StringField8: TStringField
      DisplayLabel = 'U.M.'
      FieldName = 'UMISURA'
      Required = True
      Size = 1
    end
    object StringField9: TStringField
      DisplayLabel = 'Q.Richiesta'
      FieldName = 'QUANTITA_RICHIESTA'
      OnValidate = selT254QUANTITA_RICHIESTAValidate
      Size = 7
    end
    object StringField10: TStringField
      DisplayLabel = 'Q.Ottenuta'
      FieldName = 'QUANTITA_OTTENUTA'
      Size = 7
    end
    object StringField11: TStringField
      DisplayLabel = 'Q.Offerta'
      FieldName = 'QUANTITA_OFFERTA'
      OnValidate = selT254QUANTITA_RICHIESTAValidate
      Size = 7
    end
    object StringField12: TStringField
      DisplayLabel = 'Q.Accettata'
      FieldName = 'QUANTITA_ACCETTATA'
      Size = 7
    end
    object DateTimeField3: TDateTimeField
      DisplayLabel = 'Termine diritto'
      DisplayWidth = 10
      FieldName = 'TERMINE_DIRITTO'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object StringField13: TStringField
      DisplayLabel = 'Q.Restituita'
      FieldName = 'QUANTITA_RESTITUITA'
      Size = 7
    end
  end
  object dsrT254Vis: TDataSource
    DataSet = selT254Vis
    Left = 104
    Top = 72
  end
end
