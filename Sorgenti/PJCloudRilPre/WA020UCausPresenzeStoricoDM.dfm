inherited WA020FCausPresenzeStoricoDM: TWA020FCausPresenzeStoricoDM
  Height = 137
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select T.*,T.ROWID'
      'from T235_CAUPRESENZE_PARSTO T'
      'where id = :ID'
      ':ORDERBY')
    Variables.Data = {
      0400000002000000100000003A004F0052004400450052004200590001000000
      0000000000000000060000003A0049004400030000000000000000000000}
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
    object selTabellaID: TIntegerField
      FieldName = 'ID'
      Required = True
      Visible = False
    end
    object selTabellaCODICE: TStringField
      FieldKind = fkLookup
      FieldName = 'CODICE'
      LookupKeyFields = 'ID'
      LookupResultField = 'CODICE'
      KeyFields = 'ID'
      Visible = False
      Size = 5
      Lookup = True
    end
    object selTabellaDESC_CAUSALE: TStringField
      FieldKind = fkLookup
      FieldName = 'DESC_CAUSALE'
      LookupKeyFields = 'ID'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'ID'
      Visible = False
      Size = 40
      Lookup = True
    end
    object selTabellaDECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
      Required = True
    end
    object selTabellaDECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Scadenza'
      FieldName = 'DECORRENZA_FINE'
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione periodo'
      FieldName = 'DESCRIZIONE'
      Size = 80
    end
    object selTabellaNONABILITATA_ELIMINATIMB: TStringField
      FieldName = 'NONABILITATA_ELIMINATIMB'
      Visible = False
      Size = 1
    end
    object selTabellaNONACCOPPIATA_ANOMBLOCC: TStringField
      FieldName = 'NONACCOPPIATA_ANOMBLOCC'
      Visible = False
      Size = 1
    end
    object selTabellaCAUSCOMP_DEBITOGG: TStringField
      FieldName = 'CAUSCOMP_DEBITOGG'
      Visible = False
      Size = 5
    end
    object selTabellaDETRAZ_RIEPPR_SEQ: TIntegerField
      FieldName = 'DETRAZ_RIEPPR_SEQ'
      Visible = False
    end
    object selTabellaGIUST_DAA_RECUP_FLEX: TStringField
      FieldName = 'GIUST_DAA_RECUP_FLEX'
      Visible = False
      Size = 1
    end
    object selTabellaITER_AUTSTR_ARROT_LIQ: TStringField
      FieldName = 'ITER_AUTSTR_ARROT_LIQ'
      Visible = False
      Size = 5
    end
    object selTabellaITER_AUTSTR_ARROT_LIQ_FASCE: TStringField
      FieldName = 'ITER_AUTSTR_ARROT_LIQ_FASCE'
      Visible = False
      Size = 1
    end
    object selTabellaCONTEGGIO_TIMB_INTERNA: TStringField
      FieldName = 'CONTEGGIO_TIMB_INTERNA'
      Visible = False
      Size = 1
    end
    object selTabellaMATURAMENSA: TStringField
      FieldName = 'MATURAMENSA'
      Visible = False
      Size = 1
    end
    object selTabellaTIMB_PM: TStringField
      FieldName = 'TIMB_PM'
      Visible = False
      Size = 1
    end
    object selTabellaTIMB_PM_DETRAZ: TStringField
      FieldName = 'TIMB_PM_DETRAZ'
      Visible = False
      Size = 1
    end
    object selTabellaTIMB_PM_H: TStringField
      FieldName = 'TIMB_PM_H'
      Visible = False
      Size = 1
    end
    object selTabellaINTERSEZIONE_TIMBRATURE: TStringField
      FieldName = 'INTERSEZIONE_TIMBRATURE'
      Visible = False
      Size = 1
    end
    object selTabellaAUTOCOMPLETAMENTO_UE: TStringField
      FieldName = 'AUTOCOMPLETAMENTO_UE'
      Visible = False
      Size = 1
    end
    object selTabellaSEPARA_CAUSALI_UE: TStringField
      FieldName = 'SEPARA_CAUSALI_UE'
      Visible = False
      Size = 1
    end
    object selTabellaSPEZZ_STRAORD: TStringField
      FieldName = 'SPEZZ_STRAORD'
      Visible = False
      Size = 1
    end
    object selTabellaRICONOSCIMENTO_TURNO: TStringField
      FieldName = 'RICONOSCIMENTO_TURNO'
      Visible = False
      Size = 1
    end
    object selTabellaCONDIZIONE_ABILITAZIONE: TStringField
      FieldName = 'CONDIZIONE_ABILITAZIONE'
      Visible = False
      Size = 4000
    end
  end
end
