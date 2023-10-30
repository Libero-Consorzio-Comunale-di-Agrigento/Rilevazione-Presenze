inherited WA071FRegoleBuoniDM: TWA071FRegoleBuoniDM
  Height = 283
  Width = 487
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T670.*,T670.ROWID '
      'FROM T670_REGOLEBUONI T670 '
      ':ORDERBY')
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
    BeforeDelete = BeforeDelete
    Left = 28
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Required = True
    end
    object selTabellaD_Codice: TStringField
      DisplayLabel = 'Descrizione'
      FieldKind = fkLookup
      FieldName = 'D_Codice'
      LookupDataSet = QSource
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CODICE'
      Size = 40
      Lookup = True
    end
    object selTabellaPASTO_TICKET: TStringField
      DisplayLabel = 'Tipologia'
      FieldName = 'PASTO_TICKET'
      Size = 1
    end
    object selTabellaOREMINIME: TDateTimeField
      DisplayLabel = 'Ore minime'
      FieldName = 'OREMINIME'
      Required = True
      OnGetText = selTabellaOREMINIMEGetText
      DisplayFormat = 'hh.mm'
      EditMask = '!00:00;1;_'
    end
    object selTabellaORE_MATTINA: TStringField
      DisplayLabel = 'Ore del mattino'
      FieldName = 'ORE_MATTINA'
      EditMask = '!00:00;1;_'
      Size = 5
    end
    object selTabellaORE_POMERIGGIO: TStringField
      DisplayLabel = 'Ore del pomeriggio'
      FieldName = 'ORE_POMERIGGIO'
      EditMask = '!00:00;1;_'
      Size = 5
    end
    object selTabellaINTERVALLOMIN: TStringField
      DisplayLabel = 'Intervallo min PM'
      FieldName = 'INTERVALLOMIN'
      EditMask = '!00.00;1;_'
      Size = 5
    end
    object selTabellaINTERVALLOMAX: TStringField
      DisplayLabel = 'Intervallo max PM'
      FieldName = 'INTERVALLOMAX'
      EditMask = '!00.00;1;_'
      Size = 5
    end
    object selTabellaASSENZA: TStringField
      DisplayWidth = 20
      FieldName = 'ASSENZA'
      Visible = False
      Size = 2000
    end
    object selTabellaPRESENZA: TStringField
      DisplayWidth = 20
      FieldName = 'PRESENZA'
      Visible = False
      Size = 2000
    end
    object selTabellaCAUS_TICKET: TStringField
      FieldName = 'CAUS_TICKET'
      Visible = False
      Size = 120
    end
    object selTabellaDA1: TDateTimeField
      FieldName = 'DA1'
      Visible = False
      DisplayFormat = 'hh.mm'
      EditMask = '!00:00;1;_'
    end
    object selTabellaA1: TDateTimeField
      FieldName = 'A1'
      Visible = False
      DisplayFormat = 'hh.mm'
      EditMask = '!00:00;1;_'
    end
    object selTabellaDA2: TDateTimeField
      FieldName = 'DA2'
      Visible = False
      DisplayFormat = 'hh.mm'
      EditMask = '!00:00;1;_'
    end
    object selTabellaA2: TDateTimeField
      FieldName = 'A2'
      Visible = False
      OnGetText = selTabellaA2GetText
      DisplayFormat = 'hh.mm'
      EditMask = '!00:00;1;_'
    end
    object selTabellaNONLAVORATIVO: TStringField
      FieldName = 'NONLAVORATIVO'
      Visible = False
      Size = 1
    end
    object selTabellaFORZAMATURAZIONE: TStringField
      DisplayWidth = 20
      FieldName = 'FORZAMATURAZIONE'
      Visible = False
      Size = 2000
    end
    object selTabellaINIBMATURAZIONE: TStringField
      DisplayWidth = 20
      FieldName = 'INIBMATURAZIONE'
      Visible = False
      Size = 2000
    end
    object selTabellaORARISPEZZATI: TStringField
      FieldName = 'ORARISPEZZATI'
      Visible = False
      Size = 1
    end
    object selTabellaMESE_ASSENZE: TIntegerField
      FieldName = 'MESE_ASSENZE'
      Visible = False
      MaxValue = 12
    end
    object selTabellaCONGUAGLIO_MAX: TIntegerField
      FieldName = 'CONGUAGLIO_MAX'
      Visible = False
      MaxValue = 999
    end
    object selTabellaPERIODICITA_ACQUISTO: TStringField
      FieldName = 'PERIODICITA_ACQUISTO'
      Visible = False
      Size = 12
    end
    object selTabellaACCESSI_MENSA: TStringField
      FieldName = 'ACCESSI_MENSA'
      Visible = False
      Size = 1
    end
    object selTabellaACQUISTO_TEORICO: TStringField
      FieldName = 'ACQUISTO_TEORICO'
      Visible = False
      Size = 1
    end
    object selTabellaHHMIN_ACQUISTO: TStringField
      FieldName = 'HHMIN_ACQUISTO'
      Visible = False
      Size = 1
    end
    object selTabellaASSENZE_ACQUISTO: TStringField
      FieldName = 'ASSENZE_ACQUISTO'
      Visible = False
      Size = 1
    end
    object selTabellaMEDIAMAX_ACQUISTO: TIntegerField
      FieldName = 'MEDIAMAX_ACQUISTO'
      Visible = False
    end
    object selTabellaMEDIAMIN_ACQUISTO: TIntegerField
      FieldName = 'MEDIAMIN_ACQUISTO'
      Visible = False
    end
    object selTabellaACQUISTO_MINIMO: TIntegerField
      FieldName = 'ACQUISTO_MINIMO'
      Visible = False
      MaxValue = 999
    end
    object selTabellaRESTITUZIONE_MAX: TIntegerField
      FieldName = 'RESTITUZIONE_MAX'
      Visible = False
      MaxValue = 999
    end
    object selTabellaPAUSA_MENSA: TStringField
      FieldName = 'PAUSA_MENSA'
      Visible = False
      Size = 1
    end
    object selTabellaMISSIONI: TStringField
      FieldName = 'MISSIONI'
      Visible = False
      Size = 1
    end
    object selTabellaFASCIA1_ESCLUSIVA: TStringField
      FieldName = 'FASCIA1_ESCLUSIVA'
      Visible = False
      Size = 1
    end
    object selTabellaDEBITO_GIORN_MIN: TStringField
      FieldName = 'DEBITO_GIORN_MIN'
      Visible = False
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaGIORNI_FISSI: TStringField
      FieldName = 'GIORNI_FISSI'
      Visible = False
      Size = 7
    end
    object selTabellaECCEDENZA_MIN: TStringField
      FieldName = 'ECCEDENZA_MIN'
      Visible = False
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaNUM_MAX_BUONI: TIntegerField
      FieldName = 'NUM_MAX_BUONI'
      Visible = False
    end
    object selTabellaNUM_MAX_BUONI_SETTIMANA: TIntegerField
      FieldName = 'NUM_MAX_BUONI_SETTIMANA'
    end
    object selTabellaCONGUAGLIO_PREC_MAX: TIntegerField
      FieldName = 'CONGUAGLIO_PREC_MAX'
      Visible = False
      MaxValue = 999
    end
    object selTabellaRESIDUO_PRECEDENTE: TDateTimeField
      FieldName = 'RESIDUO_PRECEDENTE'
      Visible = False
      OnSetText = selTabellaRESIDUO_PRECEDENTESetText
      DisplayFormat = 'mm/yyyy'
      EditMask = '!00/0000;1;_'
    end
    object selTabellaOREMIN_NETTOPM: TStringField
      FieldName = 'OREMIN_NETTOPM'
      Visible = False
      Size = 1
    end
    object selTabellaINIZIO_POMERIGGIO: TStringField
      FieldName = 'INIZIO_POMERIGGIO'
      Visible = False
      EditMask = '!00:00;1;_'
      Size = 5
    end
    object selTabellaPAUSA_MENSA_GESTITA: TStringField
      FieldName = 'PAUSA_MENSA_GESTITA'
      Visible = False
      Size = 1
    end
    object selTabellaOREMINIME_FASCE: TStringField
      FieldName = 'OREMINIME_FASCE'
      Visible = False
      Size = 1
    end
    object selTabellaINTERVALLO_EFFETTIVO: TStringField
      FieldName = 'INTERVALLO_EFFETTIVO'
      Visible = False
      Size = 1
    end
    object selTabellaREGOLA_SUCCESSIVA: TStringField
      FieldName = 'REGOLA_SUCCESSIVA'
      Visible = False
    end
    object selTabellaD_RegolaSuccessiva: TStringField
      FieldKind = fkLookup
      FieldName = 'D_RegolaSuccessiva'
      LookupDataSet = QSource
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'REGOLA_SUCCESSIVA'
      Visible = False
      Size = 40
      Lookup = True
    end
    object selTabellaFASCE_MATPOM_PMT: TStringField
      FieldName = 'FASCE_MATPOM_PMT'
      Visible = False
      Size = 1
    end
    object selTabellaREGOLA_RIENTRO_POMERIDIANO: TStringField
      FieldName = 'REGOLA_RIENTRO_POMERIDIANO'
      Visible = False
      Size = 1
    end
    object selTabellaRIENTRO_MASSIMO_PM: TStringField
      FieldName = 'RIENTRO_MASSIMO_PM'
      Visible = False
      EditMask = '!00.00;1;_'
      Size = 5
    end
    object selTabellaTIPO_GIORNI_FISSI: TStringField
      FieldName = 'TIPO_GIORNI_FISSI'
      Visible = False
      Size = 1
    end
    object selTabellaDEBITO_MIN: TStringField
      FieldName = 'DEBITO_MIN'
      Visible = False
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaDEBITO_MAX: TStringField
      FieldName = 'DEBITO_MAX'
      Visible = False
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaASSENZA_PM: TStringField
      DisplayWidth = 20
      FieldName = 'ASSENZA_PM'
      Visible = False
      Size = 2000
    end
    object selTabellaGGLAV_SEMPRE_CALENDARIO: TStringField
      FieldName = 'GGLAV_SEMPRE_CALENDARIO'
      Visible = False
      Size = 1
    end
    object selTabellaGGLAV_NOPIANIF_CALENDARIO: TStringField
      FieldName = 'GGLAV_NOPIANIF_CALENDARIO'
      Visible = False
      Size = 1
    end
    object selTabellaTURNILAV_GG: TIntegerField
      FieldName = 'TURNILAV_GG'
      Visible = False
      MaxValue = 9
      MinValue = 1
    end
    object selTabellaTURNILAV_ORE: TStringField
      FieldName = 'TURNILAV_ORE'
      Visible = False
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaRECUPERO_DEBITO_START: TDateTimeField
      DisplayWidth = 6
      FieldName = 'RECUPERO_DEBITO_START'
      Visible = False
      OnGetText = selTabellaRECUPERO_DEBITO_STARTGetText
      OnSetText = selTabellaRECUPERO_DEBITO_STARTSetText
      DisplayFormat = 'mm/yyyy'
      EditMask = '!00/0000;1;_'
    end
    object selTabellaRECUPERO_DEBITO_MM: TIntegerField
      FieldName = 'RECUPERO_DEBITO_MM'
      Visible = False
      MaxValue = 12
      MinValue = 1
    end
    object selTabellaSALDO_ANNUO_MINIMO: TStringField
      FieldName = 'SALDO_ANNUO_MINIMO'
      Visible = False
      EditMask = '!#00:00;1;_'
      Size = 6
    end
    object selTabellaINTERVALLO_INTERNO_PMT: TStringField
      FieldName = 'INTERVALLO_INTERNO_PMT'
      Size = 1
    end
    object selTabellaACQUISTO_QUANTITA: TIntegerField
      FieldName = 'ACQUISTO_QUANTITA'
    end
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
    Left = 164
    Top = 200
  end
  object dsrT670lkp: TDataSource
    DataSet = selT670lkp
    Left = 224
    Top = 200
  end
  object DSource: TDataSource
    AutoEdit = False
    DataSet = QSource
    Left = 112
    Top = 152
  end
  object QSource: TOracleDataSet
    ReadBuffer = 100
    Optimize = False
    Left = 68
    Top = 152
  end
  object QTabs: TOracleDataSet
    SQL.Strings = (
      'SELECT COUNT(*) FROM TABS '
      'WHERE TABLE_NAME = :TABLE_NAME')
    Optimize = False
    Variables.Data = {
      0400000001000000160000003A005400410042004C0045005F004E0041004D00
      4500050000000000000000000000}
    Left = 28
    Top = 152
  end
  object Q265: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE, DESCRIZIONE FROM T265_CAUASSENZE ORDER BY CODICE')
    ReadBuffer = 100
    Optimize = False
    Left = 204
    Top = 152
  end
  object Q275: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE, DESCRIZIONE FROM T275_CAUPRESENZE ORDER BY CODICE')
    Optimize = False
    Left = 240
    Top = 152
  end
  object Q305: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE, DESCRIZIONE FROM T305_CAUGIUSTIF ORDER BY CODICE')
    Optimize = False
    Left = 280
    Top = 152
  end
end
