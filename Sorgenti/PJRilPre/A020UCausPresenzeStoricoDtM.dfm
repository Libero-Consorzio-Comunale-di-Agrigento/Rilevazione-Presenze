inherited A020FCausPresenzeStoricoDtM: TA020FCausPresenzeStoricoDtM
  OldCreateOrder = True
  Height = 82
  Width = 73
  object selT235: TOracleDataSet
    SQL.Strings = (
      'select T.ROWID, T.*'
      'from T235_CAUPRESENZE_PARSTO T'
      'where T.ID = :ID'
      'order by T.DECORRENZA')
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      0500000006000000040000004900440001000000000014000000440045004300
      4F005200520045004E005A0041000100000000001E0000004400450043004F00
      5200520045004E005A0041005F00460049004E00450001000000000016000000
      4400450053004300520049005A0049004F004E00450001000000000030000000
      4E004F004E004100420049004C00490054004100540041005F0045004C004900
      4D0049004E004100540049004D0042000100000000002E0000004E004F004E00
      4100430043004F005000500049004100540041005F0041004E004F004D004200
      4C004F0043004300010000000000}
    BeforePost = BeforePost
    Left = 16
    Top = 16
    object selT235ID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object selT235CODICE: TStringField
      FieldKind = fkLookup
      FieldName = 'CODICE'
      LookupKeyFields = 'ID'
      LookupResultField = 'CODICE'
      KeyFields = 'ID'
      Lookup = True
    end
    object selT235DESC_CAUSALE: TStringField
      FieldKind = fkLookup
      FieldName = 'DESC_CAUSALE'
      LookupKeyFields = 'ID'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'ID'
      Size = 40
      Lookup = True
    end
    object selT235DECORRENZA: TDateTimeField
      FieldName = 'DECORRENZA'
      Required = True
    end
    object selT235DECORRENZA_FINE: TDateTimeField
      FieldName = 'DECORRENZA_FINE'
    end
    object selT235DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 80
    end
    object selT235NONABILITATA_ELIMINATIMB: TStringField
      FieldName = 'NONABILITATA_ELIMINATIMB'
      Size = 1
    end
    object selT235NONACCOPPIATA_ANOMBLOCC: TStringField
      FieldName = 'NONACCOPPIATA_ANOMBLOCC'
      Size = 1
    end
    object selT235CAUSCOMP_DEBITOGG: TStringField
      FieldName = 'CAUSCOMP_DEBITOGG'
      Size = 5
    end
    object selT235DETRAZ_RIEPPR_SEQ: TIntegerField
      FieldName = 'DETRAZ_RIEPPR_SEQ'
    end
    object selT235GIUST_DAA_RECUP_FLEX: TStringField
      FieldName = 'GIUST_DAA_RECUP_FLEX'
      Size = 1
    end
    object selT235ITER_AUTSTR_ARROT_LIQ: TStringField
      DisplayLabel = 'Arrot. quantit'#224' richiedibile in liquidazione'
      FieldName = 'ITER_AUTSTR_ARROT_LIQ'
      OnValidate = selT235ITER_AUTSTR_ARROT_LIQValidate
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT235ITER_AUTSTR_ARROT_LIQ_FASCE: TStringField
      DisplayLabel = 'Arrot. applicato sulle singole fasce'
      FieldName = 'ITER_AUTSTR_ARROT_LIQ_FASCE'
      Size = 1
    end
    object selT235CONTEGGIO_TIMB_INTERNA: TStringField
      FieldName = 'CONTEGGIO_TIMB_INTERNA'
      Size = 1
    end
    object selT235MATURAMENSA: TStringField
      FieldName = 'MATURAMENSA'
      Size = 1
    end
    object selT235TIMB_PM: TStringField
      FieldName = 'TIMB_PM'
      Size = 1
    end
    object selT235TIMB_PM_DETRAZ: TStringField
      FieldName = 'TIMB_PM_DETRAZ'
      Size = 1
    end
    object selT235TIMB_PM_H: TStringField
      FieldName = 'TIMB_PM_H'
      Size = 1
    end
    object selT235INTERSEZIONE_TIMBRATURE: TStringField
      FieldName = 'INTERSEZIONE_TIMBRATURE'
      Size = 1
    end
    object selT235AUTOCOMPLETAMENTO_UE: TStringField
      FieldName = 'AUTOCOMPLETAMENTO_UE'
      Size = 1
    end
    object selT235SEPARA_CAUSALI_UE: TStringField
      FieldName = 'SEPARA_CAUSALI_UE'
      Size = 1
    end
    object selT235SPEZZ_STRAORD: TStringField
      FieldName = 'SPEZZ_STRAORD'
      Size = 1
    end
    object selT235RICONOSCIMENTO_TURNO: TStringField
      FieldName = 'RICONOSCIMENTO_TURNO'
      Size = 1
    end
    object selT235CONDIZIONE_ABILITAZIONE: TStringField
      FieldName = 'CONDIZIONE_ABILITAZIONE'
      Size = 4000
    end
  end
end
