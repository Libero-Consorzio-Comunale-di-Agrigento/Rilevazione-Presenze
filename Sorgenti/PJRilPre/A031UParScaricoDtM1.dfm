object A031FParScaricoDtM1: TA031FParScaricoDtM1
  OldCreateOrder = True
  OnCreate = A031FParScaricoDtM1Create
  Height = 79
  Width = 208
  object QI100: TOracleDataSet
    SQL.Strings = (
      'SELECT I100.*,I100.ROWID '
      '  FROM MONDOEDP.I100_PARSCARICO I100'
      ':WHERE'
      ' ORDER BY SCARICO')
    Optimize = False
    Variables.Data = {
      04000000010000000C0000003A00570048004500520045000100000000000000
      00000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000001B0000000E0000005300430041005200490043004F00010000000000
      100000004E004F004D004500460049004C004500010000000000060000005400
      4300500001000000000012000000490050004100440044005200450053005300
      0100000000001000000043004F005200520045004E0054004500010000000000
      0A000000420041004400470045000100000000000E0000004500440042004100
      4400470045000100000000000800000041004E004E004F000100000000000800
      00004D004500530045000100000000000C000000470049004F0052004E004F00
      010000000000060000004F00520045000100000000000C0000004D0049004E00
      5500540049000100000000000E0000005300450043004F004E00440049000100
      0000000014000000520049004C0045005600410054004F005200450001000000
      00000E000000430041005500530041004C0045000100000000000A0000005600
      4500520053004F000100000000000E00000045004E0054005200410054004100
      0100000000000C00000055005300430049005400410001000000000016000000
      5400490050004F005300430041005200490043004F000100000000001C000000
      54005200490047004700450052005F004200450046004F005200450001000000
      00001A00000054005200490047004700450052005F0041004600540045005200
      0100000000000E00000041005A00490045004E00440045000100000000001000
      0000460055004E005A0049004F004E0045000100000000002600000054004900
      4D0042005F004E004F004E0054004F004C004C005F0047004700500052004500
      430001000000000026000000540049004D0042005F004E004F004E0054004F00
      4C004C005F004700470053005500430043000100000000002000000054004900
      4D0042005F004E004F004E0054004F004C004C005F004C004F00470001000000
      000020000000540049004D0042005F004E004F004E0054004F004C004C005F00
      520045004700010000000000}
    BeforePost = QI100BeforePost
    AfterPost = QI100AfterPost
    AfterCancel = QI100AfterCancel
    BeforeDelete = QI100BeforeDelete
    AfterDelete = QI100AfterDelete
    OnNewRecord = QI100NewRecord
    Left = 60
    Top = 4
    object QI100SCARICO: TStringField
      FieldName = 'SCARICO'
      Required = True
    end
    object QI100NOMEFILE: TStringField
      FieldName = 'NOMEFILE'
      Required = True
      Size = 100
    end
    object QI100TCP: TStringField
      FieldName = 'TCP'
      Size = 1
    end
    object QI100IPADDRESS: TStringField
      FieldName = 'IPADDRESS'
      EditMask = '999.999.999.999;1;_'
      Size = 15
    end
    object QI100CORRENTE: TStringField
      FieldName = 'CORRENTE'
      Size = 1
    end
    object QI100BADGE: TStringField
      FieldName = 'BADGE'
      Size = 8
    end
    object QI100EDBADGE: TStringField
      FieldName = 'EDBADGE'
      Size = 8
    end
    object QI100ANNO: TStringField
      FieldName = 'ANNO'
      Size = 8
    end
    object QI100MESE: TStringField
      FieldName = 'MESE'
      Size = 8
    end
    object QI100GIORNO: TStringField
      FieldName = 'GIORNO'
      Size = 8
    end
    object QI100ORE: TStringField
      FieldName = 'ORE'
      Size = 8
    end
    object QI100MINUTI: TStringField
      FieldName = 'MINUTI'
      Size = 8
    end
    object QI100SECONDI: TStringField
      FieldName = 'SECONDI'
      Size = 8
    end
    object QI100VERSO: TStringField
      FieldName = 'VERSO'
      Size = 8
    end
    object QI100RILEVATORE: TStringField
      FieldName = 'RILEVATORE'
      Size = 8
    end
    object QI100CAUSALE: TStringField
      FieldName = 'CAUSALE'
      Size = 8
    end
    object QI100CHIAVE: TStringField
      FieldName = 'CHIAVE'
      Size = 8
    end
    object QI100ENTRATA: TStringField
      FieldName = 'ENTRATA'
      Required = True
      Size = 2
    end
    object QI100USCITA: TStringField
      FieldName = 'USCITA'
      Required = True
      Size = 2
    end
    object QI100TIPOSCARICO: TStringField
      FieldName = 'TIPOSCARICO'
      Origin = 'I100_PARSCARICO.TIPOSCARICO'
      Size = 1
    end
    object QI100TRIGGER_BEFORE: TStringField
      FieldName = 'TRIGGER_BEFORE'
      Size = 1
    end
    object QI100TRIGGER_AFTER: TStringField
      FieldName = 'TRIGGER_AFTER'
      Size = 1
    end
    object QI100AZIENDE: TStringField
      FieldName = 'AZIENDE'
      Size = 150
    end
    object QI100FUNZIONE: TStringField
      FieldName = 'FUNZIONE'
      Size = 1
    end
    object QI100TIMB_NONTOLL_GGPREC: TIntegerField
      FieldName = 'TIMB_NONTOLL_GGPREC'
    end
    object QI100TIMB_NONTOLL_GGSUCC: TIntegerField
      FieldName = 'TIMB_NONTOLL_GGSUCC'
    end
    object QI100TIMB_NONTOLL_LOG: TStringField
      FieldName = 'TIMB_NONTOLL_LOG'
      Size = 1
    end
    object QI100TIMB_NONTOLL_REG: TStringField
      FieldName = 'TIMB_NONTOLL_REG'
      Size = 1
    end
    object QI100OFFSET_ANNO: TIntegerField
      FieldName = 'OFFSET_ANNO'
    end
    object QI100EXPR_CHIAVE: TStringField
      FieldName = 'EXPR_CHIAVE'
      Size = 2000
    end
  end
  object selI090: TOracleDataSet
    SQL.Strings = (
      'SELECT AZIENDA FROM MONDOEDP.I090_ENTI ORDER BY AZIENDA')
    Optimize = False
    Left = 12
    Top = 4
  end
end
