object A071FRegoleBuoniDtM1: TA071FRegoleBuoniDtM1
  OldCreateOrder = True
  OnCreate = A071FRegoleBuoniDtM1Create
  Height = 228
  Width = 340
  object DSource: TDataSource
    AutoEdit = False
    DataSet = QSource
    Left = 88
    Top = 8
  end
  object QTabs: TOracleDataSet
    SQL.Strings = (
      'SELECT COUNT(*) FROM TABS '
      'WHERE TABLE_NAME = :TABLE_NAME')
    Optimize = False
    Variables.Data = {
      0400000001000000160000003A005400410042004C0045005F004E0041004D00
      4500050000000000000000000000}
    Left = 4
    Top = 8
  end
  object QSource: TOracleDataSet
    ReadBuffer = 100
    Optimize = False
    Left = 44
    Top = 8
  end
  object Q670: TOracleDataSet
    SQL.Strings = (
      'SELECT T670.*,T670.ROWID '
      '  FROM T670_REGOLEBUONI T670 '
      ' ORDER BY CODICE')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000270000000C00000043004F0044004900430045000100000000001800
      000050004100530054004F005F005400490043004B0045005400010000000000
      0E00000041005300530045004E005A0041000100000000001000000050005200
      4500530045004E005A004100010000000000120000004F00520045004D004900
      4E0049004D0045000100000000001A0000004E004F004E004C00410056004F00
      520041005400490056004F000100000000001600000043004100550053005F00
      5400490043004B00450054000100000000000600000044004100310001000000
      0000040000004100310001000000000006000000440041003200010000000000
      04000000410032000100000000002000000046004F0052005A0041004D004100
      54005500520041005A0049004F004E0045000100000000001E00000049004E00
      490042004D00410054005500520041005A0049004F004E004500010000000000
      1A0000004F0052004100520049005300500045005A005A004100540049000100
      000000001A00000049004E00540045005200560041004C004C004F004D004900
      4E000100000000001A00000049004E00540045005200560041004C004C004F00
      4D0041005800010000000000180000005400490050004F005F00430041004C00
      43004F004C004F00010000000000180000004D004500530045005F0041005300
      530045004E005A0045000100000000001E0000004C0049004D00490054004900
      5F0053004500500041005200410054004900010000000000160000004F005200
      45005F004D0041005400540049004E0041000100000000001C0000004F005200
      45005F0050004F004D004500520049004700470049004F000100000000001C00
      000043004F004E0047005500410047004C0049004F005F004D00410058000100
      000000002800000050004500520049004F004400490043004900540041005F00
      41004300510055004900530054004F0001000000000020000000410043005100
      55004900530054004F005F00540045004F005200490043004F00010000000000
      1C000000480048004D0049004E005F0041004300510055004900530054004F00
      0100000000002000000041005300530045004E005A0045005F00410043005100
      55004900530054004F00010000000000220000004D0045004400490041004D00
      410058005F0041004300510055004900530054004F0001000000000022000000
      4D0045004400490041004D0049004E005F004100430051005500490053005400
      4F000100000000001A00000041004300430045005300530049005F004D004500
      4E00530041000100000000001E00000041004300510055004900530054004F00
      5F004D0049004E0049004D004F00010000000000200000005200450053005400
      4900540055005A0049004F004E0045005F004D00410058000100000000001600
      0000500041005500530041005F004D0045004E00530041000100000000001000
      00004D0049005300530049004F004E0049000100000000002000000044004500
      4200490054004F005F00470049004F0052004E005F004D0049004E0001000000
      000018000000470049004F0052004E0049005F00460049005300530049000100
      000000001A0000004500430043004500440045004E005A0041005F004D004900
      4E000100000000001A0000004E0055004D005F004D00410058005F0042005500
      4F004E0049000100000000002600000043004F004E0047005500410047004C00
      49004F005F0050005200450043005F004D004100580001000000000024000000
      5200450053004900440055004F005F0050005200450043004500440045004E00
      54004500010000000000}
    CachedUpdates = True
    BeforePost = Q670BeforePost
    AfterPost = Q670AfterPost
    AfterCancel = Q670AfterCancel
    BeforeDelete = Q670BeforeDelete
    AfterDelete = Q670AfterDelete
    AfterScroll = Q670AfterScroll
    OnNewRecord = Q670NewRecord
    Left = 140
    Top = 8
    object Q670CODICE: TStringField
      FieldName = 'CODICE'
      Origin = 'T670_REGOLEBUONI.CODICE'
      Required = True
    end
    object Q670PASTO_TICKET: TStringField
      FieldName = 'PASTO_TICKET'
      Origin = 'T670_REGOLEBUONI.PASTO_TICKET'
      Size = 1
    end
    object Q670ASSENZA: TStringField
      DisplayWidth = 20
      FieldName = 'ASSENZA'
      Origin = 'T670_REGOLEBUONI.ASSENZA'
      Size = 2000
    end
    object Q670PRESENZA: TStringField
      DisplayWidth = 20
      FieldName = 'PRESENZA'
      Origin = 'T670_REGOLEBUONI.PRESENZA'
      Size = 2000
    end
    object Q670OREMINIME: TDateTimeField
      FieldName = 'OREMINIME'
      Origin = 'T670_REGOLEBUONI.OREMINIME'
      Required = True
      OnGetText = Q670OREMINIMEGetText
      OnSetText = BDEQ670OREMINIMESetText
      DisplayFormat = 'hh.mm'
      EditMask = '!00:00;1;_'
    end
    object Q670CAUS_TICKET: TStringField
      FieldName = 'CAUS_TICKET'
      Origin = 'T670_REGOLEBUONI.CAUS_TICKET'
      Size = 120
    end
    object Q670DA1: TDateTimeField
      FieldName = 'DA1'
      Origin = 'T670_REGOLEBUONI.DA1'
      OnGetText = Q670A2GetText
      OnSetText = BDEQ670OREMINIMESetText
      DisplayFormat = 'hh.mm'
      EditMask = '!00:00;1;_'
    end
    object Q670A1: TDateTimeField
      FieldName = 'A1'
      Origin = 'T670_REGOLEBUONI.A1'
      OnGetText = Q670A2GetText
      OnSetText = BDEQ670OREMINIMESetText
      DisplayFormat = 'hh.mm'
      EditMask = '!00:00;1;_'
    end
    object Q670DA2: TDateTimeField
      FieldName = 'DA2'
      Origin = 'T670_REGOLEBUONI.DA2'
      OnGetText = Q670A2GetText
      OnSetText = BDEQ670OREMINIMESetText
      DisplayFormat = 'hh.mm'
      EditMask = '!00:00;1;_'
    end
    object Q670A2: TDateTimeField
      FieldName = 'A2'
      Origin = 'T670_REGOLEBUONI.A2'
      OnGetText = Q670A2GetText
      OnSetText = BDEQ670OREMINIMESetText
      DisplayFormat = 'hh.mm'
      EditMask = '!00:00;1;_'
    end
    object Q670D_Codice: TStringField
      FieldKind = fkLookup
      FieldName = 'D_Codice'
      LookupDataSet = QSource
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CODICE'
      Size = 40
      Lookup = True
    end
    object Q670NONLAVORATIVO: TStringField
      FieldName = 'NONLAVORATIVO'
      Origin = 'T670_REGOLEBUONI.NONLAVORATIVO'
      Size = 1
    end
    object Q670FORZAMATURAZIONE: TStringField
      DisplayWidth = 20
      FieldName = 'FORZAMATURAZIONE'
      Origin = 'T670_REGOLEBUONI.FORZAMATURAZIONE'
      Size = 2000
    end
    object Q670INIBMATURAZIONE: TStringField
      DisplayWidth = 20
      FieldName = 'INIBMATURAZIONE'
      Origin = 'T670_REGOLEBUONI.INIBMATURAZIONE'
      Size = 2000
    end
    object Q670ORARISPEZZATI: TStringField
      FieldName = 'ORARISPEZZATI'
      Origin = 'T670_REGOLEBUONI.ORARISPEZZATI'
      Size = 1
    end
    object Q670INTERVALLOMIN: TStringField
      FieldName = 'INTERVALLOMIN'
      OnValidate = Q670INTERVALLOMINValidate
      EditMask = '!00.00;1;_'
      Size = 5
    end
    object Q670INTERVALLOMAX: TStringField
      FieldName = 'INTERVALLOMAX'
      OnValidate = Q670INTERVALLOMINValidate
      EditMask = '!00.00;1;_'
      Size = 5
    end
    object Q670MESE_ASSENZE: TIntegerField
      FieldName = 'MESE_ASSENZE'
      MaxValue = 12
    end
    object Q670ORE_MATTINA: TStringField
      FieldName = 'ORE_MATTINA'
      OnValidate = Q670INTERVALLOMINValidate
      EditMask = '!00:00;1;_'
      Size = 5
    end
    object Q670ORE_POMERIGGIO: TStringField
      FieldName = 'ORE_POMERIGGIO'
      OnValidate = Q670INTERVALLOMINValidate
      EditMask = '!00:00;1;_'
      Size = 5
    end
    object Q670CONGUAGLIO_MAX: TIntegerField
      FieldName = 'CONGUAGLIO_MAX'
      MaxValue = 999
    end
    object Q670PERIODICITA_ACQUISTO: TStringField
      FieldName = 'PERIODICITA_ACQUISTO'
      Size = 12
    end
    object Q670ACQUISTO_TEORICO: TStringField
      FieldName = 'ACQUISTO_TEORICO'
      Size = 1
    end
    object Q670HHMIN_ACQUISTO: TStringField
      FieldName = 'HHMIN_ACQUISTO'
      Size = 1
    end
    object Q670ASSENZE_ACQUISTO: TStringField
      FieldName = 'ASSENZE_ACQUISTO'
      Size = 1
    end
    object Q670MEDIAMAX_ACQUISTO: TIntegerField
      FieldName = 'MEDIAMAX_ACQUISTO'
    end
    object Q670MEDIAMIN_ACQUISTO: TIntegerField
      FieldName = 'MEDIAMIN_ACQUISTO'
    end
    object Q670ACCESSI_MENSA: TStringField
      FieldName = 'ACCESSI_MENSA'
      Size = 1
    end
    object Q670ACQUISTO_MINIMO: TIntegerField
      FieldName = 'ACQUISTO_MINIMO'
      MaxValue = 999
    end
    object Q670RESTITUZIONE_MAX: TIntegerField
      FieldName = 'RESTITUZIONE_MAX'
      MaxValue = 999
    end
    object Q670PAUSA_MENSA: TStringField
      FieldName = 'PAUSA_MENSA'
      Size = 1
    end
    object Q670MISSIONI: TStringField
      FieldName = 'MISSIONI'
      Size = 1
    end
    object Q670DEBITO_MIN: TStringField
      FieldName = 'DEBITO_MIN'
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object Q670DEBITO_MAX: TStringField
      FieldName = 'DEBITO_MAX'
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object Q670DEBITO_GIORN_MIN: TStringField
      FieldName = 'DEBITO_GIORN_MIN'
      OnValidate = Q670DEBITO_GIORN_MINValidate
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object Q670GIORNI_FISSI: TStringField
      FieldName = 'GIORNI_FISSI'
      Size = 7
    end
    object Q670ECCEDENZA_MIN: TStringField
      FieldName = 'ECCEDENZA_MIN'
      OnValidate = Q670ECCEDENZA_MINValidate
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object Q670NUM_MAX_BUONI: TIntegerField
      FieldName = 'NUM_MAX_BUONI'
    end
    object Q670NUM_MAX_BUONI_SETTIMANA: TIntegerField
      FieldName = 'NUM_MAX_BUONI_SETTIMANA'
    end
    object Q670CONGUAGLIO_PREC_MAX: TIntegerField
      FieldName = 'CONGUAGLIO_PREC_MAX'
      MaxValue = 999
    end
    object Q670RESIDUO_PRECEDENTE: TDateTimeField
      FieldName = 'RESIDUO_PRECEDENTE'
      DisplayFormat = 'mm/yyyy'
      EditMask = '!00/0000;1;_'
    end
    object Q670OREMIN_NETTOPM: TStringField
      FieldName = 'OREMIN_NETTOPM'
      Size = 1
    end
    object Q670INIZIO_POMERIGGIO: TStringField
      FieldName = 'INIZIO_POMERIGGIO'
      OnValidate = Q670INTERVALLOMINValidate
      EditMask = '!00:00;1;_'
      Size = 5
    end
    object Q670PAUSA_MENSA_GESTITA: TStringField
      FieldName = 'PAUSA_MENSA_GESTITA'
      Size = 1
    end
    object Q670OREMINIME_FASCE: TStringField
      FieldName = 'OREMINIME_FASCE'
      Size = 1
    end
    object Q670INTERVALLO_EFFETTIVO: TStringField
      FieldName = 'INTERVALLO_EFFETTIVO'
      Size = 1
    end
    object Q670FASCIA1_ESCLUSIVA: TStringField
      FieldName = 'FASCIA1_ESCLUSIVA'
      Size = 1
    end
    object Q670REGOLA_SUCCESSIVA: TStringField
      FieldName = 'REGOLA_SUCCESSIVA'
    end
    object Q670D_RegolaSuccessiva: TStringField
      FieldKind = fkLookup
      FieldName = 'D_RegolaSuccessiva'
      LookupDataSet = QSource
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'REGOLA_SUCCESSIVA'
      Size = 40
      Lookup = True
    end
    object Q670FASCE_MATPOM_PMT: TStringField
      FieldName = 'FASCE_MATPOM_PMT'
      Size = 1
    end
    object Q670REGOLA_RIENTRO_POMERIDIANO: TStringField
      FieldName = 'REGOLA_RIENTRO_POMERIDIANO'
      Size = 1
    end
    object Q670RIENTRO_MASSIMO_PM: TStringField
      FieldName = 'RIENTRO_MASSIMO_PM'
      OnValidate = Q670INTERVALLOMINValidate
      EditMask = '!00.00;1;_'
      Size = 5
    end
    object Q670TIPO_GIORNI_FISSI: TStringField
      FieldName = 'TIPO_GIORNI_FISSI'
      Size = 1
    end
    object Q670ASSENZA_PM: TStringField
      FieldName = 'ASSENZA_PM'
      Size = 2000
    end
    object Q670GGLAV_SEMPRE_CALENDARIO: TStringField
      FieldName = 'GGLAV_SEMPRE_CALENDARIO'
      Size = 1
    end
    object Q670GGLAV_NOPIANIF_CALENDARIO: TStringField
      FieldName = 'GGLAV_NOPIANIF_CALENDARIO'
      Size = 1
    end
    object Q670TURNILAV_GG: TIntegerField
      FieldName = 'TURNILAV_GG'
    end
    object Q670TURNILAV_ORE: TStringField
      FieldName = 'TURNILAV_ORE'
      OnValidate = Q670TURNILAV_OREValidate
      EditMask = '!00:00;1;_'
      Size = 5
    end
    object Q670RECUPERO_DEBITO_START: TDateTimeField
      DisplayWidth = 6
      FieldName = 'RECUPERO_DEBITO_START'
      OnGetText = Q670RECUPERO_DEBITO_STARTGetText
      OnSetText = Q670RECUPERO_DEBITO_STARTSetText
      DisplayFormat = 'MM/YYYY'
      EditMask = '!00/0000;1;_'
    end
    object Q670RECUPERO_DEBITO_MM: TIntegerField
      FieldName = 'RECUPERO_DEBITO_MM'
    end
    object Q670SALDO_ANNUO_MINIMO: TStringField
      FieldName = 'SALDO_ANNUO_MINIMO'
      OnValidate = Q670SALDO_ANNUO_MINIMOValidate
      EditMask = '!#00:00;1;_'
      Size = 6
    end
    object Q670INTERVALLO_INTERNO_PMT: TStringField
      FieldName = 'INTERVALLO_INTERNO_PMT'
      Size = 1
    end
    object Q670RICHIESTA_NOME_DATO_LIBERO: TStringField
      DisplayLabel = 'Nome dato per abilitazione'
      FieldName = 'RICHIESTA_NOME_DATO_LIBERO'
      Size = 30
    end
    object Q670RICHIESTA_VALORE_DATO_LIBERO: TStringField
      DisplayLabel = 'Valore dato per abilitazione'
      DisplayWidth = 40
      FieldName = 'RICHIESTA_VALORE_DATO_LIBERO'
      Size = 2000
    end
    object Q670RICHIESTA_GG_DAL: TIntegerField
      DisplayLabel = 'Giorno di inizio periodo richiesta'
      DisplayWidth = 2
      FieldName = 'RICHIESTA_GG_DAL'
      MaxValue = 31
      MinValue = 1
    end
    object Q670RICHIESTA_GG_AL: TIntegerField
      DisplayLabel = 'Giorno di fine periodo richiesta'
      DisplayWidth = 2
      FieldName = 'RICHIESTA_GG_AL'
      MaxValue = 31
      MinValue = 1
    end
    object Q670RICHIESTA_MAX_TICKET_MESE: TIntegerField
      DisplayLabel = 'Max ticket mensili richiedibili'
      DisplayWidth = 3
      FieldName = 'RICHIESTA_MAX_TICKET_MESE'
      MaxValue = 999
    end
    object Q670REGOLA_CUSTOM: TStringField
      DisplayWidth = 50
      FieldName = 'REGOLA_CUSTOM'
      Size = 4000
    end
    object Q670ACQUISTO_QUANTITA: TIntegerField
      FieldName = 'ACQUISTO_QUANTITA'
    end
  end
  object Q265: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE, DESCRIZIONE FROM T265_CAUASSENZE ORDER BY CODICE')
    ReadBuffer = 100
    Optimize = False
    Left = 180
    Top = 8
  end
  object Q275: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE, DESCRIZIONE FROM T275_CAUPRESENZE ORDER BY CODICE')
    Optimize = False
    Left = 216
    Top = 8
  end
  object Q305: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE, DESCRIZIONE FROM T305_CAUGIUSTIF ORDER BY CODICE')
    Optimize = False
    Left = 256
    Top = 8
  end
  object selT670lkp: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE'
      ' FROM T670_REGOLEBUONI T670'
      '  WHERE CODICE <> :CODICE '
      ' ORDER BY CODICE')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000270000000C00000043004F0044004900430045000100000000001800
      000050004100530054004F005F005400490043004B0045005400010000000000
      0E00000041005300530045004E005A0041000100000000001000000050005200
      4500530045004E005A004100010000000000120000004F00520045004D004900
      4E0049004D0045000100000000001A0000004E004F004E004C00410056004F00
      520041005400490056004F000100000000001600000043004100550053005F00
      5400490043004B00450054000100000000000600000044004100310001000000
      0000040000004100310001000000000006000000440041003200010000000000
      04000000410032000100000000002000000046004F0052005A0041004D004100
      54005500520041005A0049004F004E0045000100000000001E00000049004E00
      490042004D00410054005500520041005A0049004F004E004500010000000000
      1A0000004F0052004100520049005300500045005A005A004100540049000100
      000000001A00000049004E00540045005200560041004C004C004F004D004900
      4E000100000000001A00000049004E00540045005200560041004C004C004F00
      4D0041005800010000000000180000005400490050004F005F00430041004C00
      43004F004C004F00010000000000180000004D004500530045005F0041005300
      530045004E005A0045000100000000001E0000004C0049004D00490054004900
      5F0053004500500041005200410054004900010000000000160000004F005200
      45005F004D0041005400540049004E0041000100000000001C0000004F005200
      45005F0050004F004D004500520049004700470049004F000100000000001C00
      000043004F004E0047005500410047004C0049004F005F004D00410058000100
      000000002800000050004500520049004F004400490043004900540041005F00
      41004300510055004900530054004F0001000000000020000000410043005100
      55004900530054004F005F00540045004F005200490043004F00010000000000
      1C000000480048004D0049004E005F0041004300510055004900530054004F00
      0100000000002000000041005300530045004E005A0045005F00410043005100
      55004900530054004F00010000000000220000004D0045004400490041004D00
      410058005F0041004300510055004900530054004F0001000000000022000000
      4D0045004400490041004D0049004E005F004100430051005500490053005400
      4F000100000000001A00000041004300430045005300530049005F004D004500
      4E00530041000100000000001E00000041004300510055004900530054004F00
      5F004D0049004E0049004D004F00010000000000200000005200450053005400
      4900540055005A0049004F004E0045005F004D00410058000100000000001600
      0000500041005500530041005F004D0045004E00530041000100000000001000
      00004D0049005300530049004F004E0049000100000000002000000044004500
      4200490054004F005F00470049004F0052004E005F004D0049004E0001000000
      000018000000470049004F0052004E0049005F00460049005300530049000100
      000000001A0000004500430043004500440045004E005A0041005F004D004900
      4E000100000000001A0000004E0055004D005F004D00410058005F0042005500
      4F004E0049000100000000002600000043004F004E0047005500410047004C00
      49004F005F0050005200450043005F004D004100580001000000000024000000
      5200450053004900440055004F005F0050005200450043004500440045004E00
      54004500010000000000}
    Left = 140
    Top = 56
  end
  object dsrT670lkp: TDataSource
    DataSet = selT670lkp
    Left = 200
    Top = 56
  end
  object dsrCols: TDataSource
    DataSet = selCols
    Left = 65
    Top = 107
  end
  object selCols: TOracleDataSet
    SQL.Strings = (
      'SELECT COLUMN_NAME '
      'FROM   COLS '
      'WHERE  TABLE_NAME = '#39'T430_STORICO'#39
      'ORDER BY COLUMN_NAME')
    ReadBuffer = 200
    Optimize = False
    Left = 16
    Top = 107
  end
  object selT670RegolaCustom: TOracleQuery
    Optimize = False
    Left = 140
    Top = 107
  end
end