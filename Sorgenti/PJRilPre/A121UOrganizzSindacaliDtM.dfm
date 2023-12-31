inherited A121FOrganizzSindacaliDtM: TA121FOrganizzSindacaliDtM
  OldCreateOrder = True
  Height = 65
  Width = 53
  object selT240: TOracleDataSet
    SQL.Strings = (
      'SELECT T240.*,T240.ROWID '
      'FROM T240_ORGANIZZAZIONISINDACALI T240'
      'ORDER BY CODICE, DECORRENZA')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000B000000140000004400450043004F005200520045004E005A004100
      010000000000160000004400450053004300520049005A0049004F004E004500
      0100000000000C00000043004F00440049004300450001000000000020000000
      43004F0044005F004D0049004E0049005300540045005200490041004C004500
      0100000000000C000000460049004C00540052004F000100000000001C000000
      5200410047004700520055005000500041004D0045004E0054004F0001000000
      00002A000000530049004E004400410043004100540049005F00520041004700
      4700520055005000500041005400490001000000000006000000520053005500
      0100000000001200000056004F00430045005000410047004800450001000000
      000024000000430041005500530041004C0045005F0043004F004D0050004500
      540045004E005A0045000100000000002A000000430041005500530041004C00
      45005F0043004F004D0050004500540045004E005A0045005F004E004F000100
      00000000}
    BeforePost = BeforePost
    AfterScroll = selT240AfterScroll
    Left = 8
    Top = 8
    object selT240CODICE: TStringField
      FieldName = 'CODICE'
      Required = True
      OnValidate = selT240CODICEValidate
      Size = 10
    end
    object selT240DECORRENZA: TDateTimeField
      FieldName = 'DECORRENZA'
      Required = True
    end
    object selT240DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selT240COD_MINISTERIALE: TStringField
      FieldName = 'COD_MINISTERIALE'
      Size = 11
    end
    object selT240COD_REGIONALE: TStringField
      FieldName = 'COD_REGIONALE'
      Size = 4
    end
    object selT240FILTRO: TStringField
      FieldName = 'FILTRO'
      Size = 500
    end
    object selT240RAGGRUPPAMENTO: TStringField
      FieldName = 'RAGGRUPPAMENTO'
      OnValidate = selT240RAGGRUPPAMENTOValidate
      Size = 1
    end
    object selT240SINDACATI_RAGGRUPPATI: TStringField
      FieldName = 'SINDACATI_RAGGRUPPATI'
      Size = 200
    end
    object selT240RSU: TStringField
      FieldName = 'RSU'
      OnValidate = selT240RSUValidate
      Size = 1
    end
    object selT240VOCEPAGHE: TStringField
      FieldName = 'VOCEPAGHE'
      Size = 6
    end
    object selT240CAUSALE_COMPETENZE: TStringField
      FieldName = 'CAUSALE_COMPETENZE'
      Visible = False
      Size = 5
    end
    object selT240CAUSALE_COMPETENZE_NO: TStringField
      FieldName = 'CAUSALE_COMPETENZE_NO'
      Visible = False
      Size = 5
    end
  end
end
