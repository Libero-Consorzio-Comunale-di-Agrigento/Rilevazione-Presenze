inherited WA177FFerieSolidaliDM: TWA177FFerieSolidaliDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid from T254_FERIESOLIDALI t'
      ' where T.PROGRESSIVO = :PROGRESSIVO'
      ' :orderby ')
    Variables.Data = {
      0400000002000000100000003A004F0052004400450052004200590001000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000001100000016000000500052004F004700520045005300530049005600
      4F00010000000000080000005400490050004F00010000000000080000004100
      4E004E004F00010000000000140000004400450043004F005200520045004E00
      5A0041000100000000001E0000004400450043004F005200520045004E005A00
      41005F00460049004E00450001000000000018000000490044005F0052004900
      4300480049004500530054004100010000000000160000004400450053004300
      520049005A0049004F004E0045000100000000000A0000005300540041005400
      4F000100000000001000000043004F0044005200410047004700520001000000
      00000E000000430041005500530041004C0045000100000000000E0000005500
      4D0049005300550052004100010000000000240000005100550041004E005400
      4900540041005F00520049004300480049004500530054004100010000000000
      220000005100550041004E0054004900540041005F004F005400540045004E00
      550054004100010000000000200000005100550041004E005400490054004100
      5F004F0046004600450052005400410001000000000024000000510055004100
      4E0054004900540041005F004100430043004500540054004100540041000100
      000000001E0000005400450052004D0049004E0045005F004400490052004900
      540054004F00010000000000260000005100550041004E005400490054004100
      5F005200450053005400490054005500490054004100010000000000}
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    AfterDelete = AfterDelete
    OnCalcFields = selTabellaCalcFields
    OnNewRecord = OnNewRecord
    object selT254PROGRESSIVO: TIntegerField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selT254TIPO: TStringField
      Alignment = taCenter
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO'
      Required = True
      Size = 1
    end
    object selT254ANNO: TFloatField
      Alignment = taCenter
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
      Alignment = taCenter
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
      Alignment = taCenter
      DisplayLabel = 'U.M.'
      FieldName = 'UMISURA'
      Required = True
      Size = 1
    end
    object selTabellaQUANTITA_RICHIESTA: TStringField
      DisplayLabel = 'Q.Richiesta'
      FieldName = 'QUANTITA_RICHIESTA'
      Size = 7
    end
    object selTabellaQUANTITA_OTTENUTA: TStringField
      DisplayLabel = 'Q.Ottenuta'
      FieldName = 'QUANTITA_OTTENUTA'
      Size = 7
    end
    object selTabellaQUANTITA_OFFERTA: TStringField
      DisplayLabel = 'Q.Offerta'
      FieldName = 'QUANTITA_OFFERTA'
      Size = 7
    end
    object selTabellaQUANTITA_ACCETTATA: TStringField
      DisplayLabel = 'Q.Accettata'
      FieldName = 'QUANTITA_ACCETTATA'
      Size = 7
    end
    object selTabellaTERMINE_DIRITTO: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Termine diritto'
      DisplayWidth = 10
      FieldName = 'TERMINE_DIRITTO'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaQUANTITA_RESTITUITA: TStringField
      DisplayLabel = 'Q.Restituita'
      FieldName = 'QUANTITA_RESTITUITA'
      Size = 7
    end
  end
end
