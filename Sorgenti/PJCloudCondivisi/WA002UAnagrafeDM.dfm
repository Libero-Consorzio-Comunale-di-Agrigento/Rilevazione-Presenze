inherited WA002FAnagrafeDM: TWA002FAnagrafeDM
  Height = 356
  Width = 628
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T430.*, T430.ROWID '
      'FROM T430_STORICO T430'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      ':ORDERBY'
      '')
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A004F005200440045005200
      42005900010000000000000000000000}
    AfterOpen = selTabellaAfterOpen
    BeforeInsert = BeforeInsert
    BeforeEdit = BeforeEdit
    AfterEdit = selTabellaAfterEdit
    BeforePost = BeforePost
    AfterPost = AfterPost
    AfterCancel = AfterCancel
    BeforeDelete = BeforeDelete
    AfterDelete = AfterDelete
    OnPostError = selTabellaPostError
    Left = 24
    object selTabellaPROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selTabellaDATADECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DATADECORRENZA'
    end
    object selTabellaDATAFINE: TDateTimeField
      DisplayLabel = 'Scadenza'
      FieldName = 'DATAFINE'
    end
    object selTabellaBADGE: TFloatField
      DisplayLabel = 'Badge'
      FieldName = 'BADGE'
    end
    object selTabellaEDBADGE: TStringField
      DisplayLabel = 'Ed.Badge'
      FieldName = 'EDBADGE'
      Visible = False
      Size = 15
    end
    object selTabellaINIZIO: TDateTimeField
      DisplayLabel = 'Assunzione'
      FieldName = 'INIZIO'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object selTabellaFINE: TDateTimeField
      DisplayLabel = 'Cessazione'
      FieldName = 'FINE'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object selTabellaTIPORAPPORTO: TStringField
      DisplayLabel = 'Tipo rapporto'
      FieldName = 'TIPORAPPORTO'
      Origin = 'T430_STORICO.TIPORAPPORTO'
      Size = 5
    end
    object selTabellaPARTTIME: TStringField
      DisplayLabel = 'Part Time'
      FieldName = 'PARTTIME'
      Origin = 'T430_STORICO.PARTTIME'
      Size = 5
    end
    object selTabellaORARIO: TStringField
      DisplayLabel = 'Ore settimanali'
      FieldName = 'ORARIO'
    end
    object selTabellaCONTRATTO: TStringField
      DisplayLabel = 'Contratto'
      DisplayWidth = 6
      FieldName = 'CONTRATTO'
      Size = 5
    end
    object selTabellaPERSELASTICO: TStringField
      DisplayLabel = 'Tipo cartellino'
      FieldName = 'PERSELASTICO'
      Size = 5
    end
    object selTabellaTGESTIONE: TStringField
      DisplayLabel = 'Turnista'
      FieldName = 'TGESTIONE'
      Size = 1
    end
    object selTabellaCALENDARIO: TStringField
      DisplayLabel = 'Calendario'
      DisplayWidth = 6
      FieldName = 'CALENDARIO'
      Size = 5
    end
    object selTabellaPORARIO: TStringField
      DisplayLabel = 'Profilo orario'
      DisplayWidth = 8
      FieldName = 'PORARIO'
      Size = 5
    end
    object selTabellaIPRESENZA: TStringField
      DisplayLabel = 'Profilo indennit'#224
      DisplayWidth = 6
      FieldName = 'IPRESENZA'
      Size = 5
    end
    object selTabellaPASSENZE: TStringField
      DisplayLabel = 'Profilo assenze'
      DisplayWidth = 6
      FieldName = 'PASSENZE'
      Size = 5
    end
    object selTabellaINDIRIZZO: TStringField
      DisplayLabel = 'Indirizzo Res.'
      FieldName = 'INDIRIZZO'
      Visible = False
      Size = 80
    end
    object selTabellaCOMUNE: TStringField
      DisplayLabel = 'Comune Res.'
      DisplayWidth = 6
      FieldName = 'COMUNE'
      Visible = False
      Size = 6
    end
    object selTabellaCAP: TStringField
      FieldName = 'CAP'
      Visible = False
      Size = 5
    end
    object seltabellaTELEFONO: TStringField
      DisplayLabel = 'Telefono'
      FieldName = 'TELEFONO'
      Visible = False
      Size = 15
    end
    object selTabellaSQUADRA: TStringField
      DisplayLabel = 'Squadra'
      DisplayWidth = 12
      FieldName = 'SQUADRA'
      Visible = False
      Size = 10
    end
    object selTabellaTIPOOPE: TStringField
      DisplayLabel = 'Tipo operatore'
      FieldName = 'TIPOOPE'
      Visible = False
      Size = 5
    end
    object selTabellaTERMINALI: TStringField
      DisplayLabel = 'Terminali abilitati'
      DisplayWidth = 10
      FieldName = 'TERMINALI'
      Visible = False
      Size = 300
    end
    object selTabellaDOCENTE: TStringField
      DisplayLabel = 'Docente'
      FieldName = 'DOCENTE'
      Required = True
      Visible = False
      Size = 1
    end
    object selTabellaCAUSSTRAORD: TStringField
      FieldName = 'CAUSSTRAORD'
      Visible = False
      Size = 1
    end
    object selTabellaSTRAORDE: TStringField
      DisplayLabel = 'Straord.E'
      FieldName = 'STRAORDE'
      Visible = False
      Size = 1
    end
    object selTabellaSTRAORDU: TStringField
      DisplayLabel = 'Straord.U'
      FieldName = 'STRAORDU'
      Visible = False
      Size = 1
    end
    object selTabellaSTRAORDEU: TStringField
      DisplayLabel = 'Straord.U matt.'
      FieldName = 'STRAORDEU'
      Visible = False
      Size = 1
    end
    object selTabellaSTRAORDEU2: TStringField
      DisplayLabel = 'Straord. E pom.'
      FieldName = 'STRAORDEU2'
      Origin = 'T430_STORICO.STRAORDEU2'
      Visible = False
      Size = 1
    end
    object selTabellaHTEORICHE: TStringField
      DisplayLabel = 'Ore teoriche'
      FieldName = 'HTEORICHE'
      Visible = False
      Size = 1
    end
    object selTabellaPLUSORA: TStringField
      DisplayLabel = 'Debito aggiuntivo'
      DisplayWidth = 6
      FieldName = 'PLUSORA'
      Visible = False
      Size = 5
    end
    object selTabellaABCAUSALE1: TStringField
      DisplayLabel = 'Assenze abilitate'
      DisplayWidth = 20
      FieldName = 'ABCAUSALE1'
      Visible = False
      Size = 200
    end
    object selTabellaABPRESENZA1: TStringField
      DisplayLabel = 'Presenze abilitate'
      DisplayWidth = 20
      FieldName = 'ABPRESENZA1'
      Visible = False
      Size = 200
    end
    object selTabellaQUALIFICAMINIST: TStringField
      DisplayLabel = 'Qualifica minist.'
      DisplayWidth = 10
      FieldName = 'QUALIFICAMINIST'
      Visible = False
    end
    object selTabellaTIPO_LOCALITA_DIST_LAVORO: TStringField
      FieldName = 'TIPO_LOCALITA_DIST_LAVORO'
      Visible = False
      Size = 1
    end
    object selTabellaCOD_LOCALITA_DIST_LAVORO: TStringField
      FieldName = 'COD_LOCALITA_DIST_LAVORO'
      Visible = False
      Size = 6
    end
    object selTabellaINIZIO_IND_MAT: TDateTimeField
      FieldName = 'INIZIO_IND_MAT'
      Visible = False
      DisplayFormat = 'dd/mm/yyyy'
    end
    object selTabellaFINE_IND_MAT: TDateTimeField
      FieldName = 'FINE_IND_MAT'
      Visible = False
      DisplayFormat = 'dd/mm/yyyy'
    end
    object selTabellaMEDICINA_LEGALE: TStringField
      FieldName = 'MEDICINA_LEGALE'
      Visible = False
      Size = 10
    end
    object selTabellaINDIRIZZO_DOM_BASE: TStringField
      FieldName = 'INDIRIZZO_DOM_BASE'
      Visible = False
      Size = 80
    end
    object selTabellaCOMUNE_DOM_BASE: TStringField
      FieldName = 'COMUNE_DOM_BASE'
      Visible = False
      Size = 6
    end
    object selTabellaCAP_DOM_BASE: TStringField
      FieldName = 'CAP_DOM_BASE'
      Visible = False
      Size = 5
    end
    object selTabellaAZIENDA_BASE: TStringField
      FieldName = 'AZIENDA_BASE'
      Visible = False
      Size = 5
    end
    object selTabellaRAPPORTI_UNIFICATI: TStringField
      DisplayLabel = 'Rapporti unificati'
      FieldName = 'RAPPORTI_UNIFICATI'
      Size = 1
    end
  end
  inherited dsrTabella: TDataSource
    Left = 96
    Top = 16
  end
  inherited selEstrazioneDati: TOracleDataSet
    Left = 456
    Top = 32
  end
  inherited dsrEstrazioniDati: TDataSource
    Left = 544
    Top = 32
  end
  inherited selT900: TOracleDataSet
    Left = 488
    Top = 88
  end
  inherited selT901: TOracleDataSet
    Left = 536
    Top = 88
  end
  object selT030: TOracleDataSet
    SQL.Strings = (
      'SELECT T.*, T.ROWID '
      'FROM T030_ANAGRAFICO T'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      'ORDER BY PROGRESSIVO')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    OracleDictionary.DefaultValues = True
    LockingMode = lmLockImmediate
    OnCalcFields = selT030CalcFields
    OnNewRecord = selT030NewRecord
    Left = 24
    Top = 72
    object selT030PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
    end
    object selT030COGNOME: TStringField
      FieldName = 'COGNOME'
      Size = 50
    end
    object selT030NOME: TStringField
      FieldName = 'NOME'
      Size = 50
    end
    object selT030MATRICOLA: TStringField
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selT030SESSO: TStringField
      FieldName = 'SESSO'
      Size = 1
    end
    object selT030DATANAS: TDateTimeField
      FieldName = 'DATANAS'
    end
    object selT030COMUNENAS: TStringField
      FieldName = 'COMUNENAS'
      Size = 6
    end
    object selT030CAPNAS: TStringField
      FieldName = 'CAPNAS'
      Size = 5
    end
    object selT030CODFISCALE: TStringField
      FieldName = 'CODFISCALE'
      Size = 16
    end
    object selT030INIZIOSERVIZIO: TDateTimeField
      FieldName = 'INIZIOSERVIZIO'
    end
    object selT030RAPPORTI_UNITI: TStringField
      FieldName = 'RAPPORTI_UNITI'
      Size = 1
    end
    object selT030TIPO_PERSONALE: TStringField
      FieldName = 'TIPO_PERSONALE'
      Size = 1
    end
    object selT030TIPO_SOGGETTO_BASE: TStringField
      FieldName = 'TIPO_SOGGETTO_BASE'
      Size = 1
    end
    object selT030I060EMAIL: TStringField
      FieldKind = fkCalculated
      FieldName = 'I060EMAIL'
      Size = 200
      Calculated = True
    end
    object selT030I060EMAILPEC: TStringField
      FieldKind = fkCalculated
      FieldName = 'I060EMAILPEC'
      Size = 200
      Calculated = True
    end
    object selT030I060CELLULARE: TStringField
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'I060CELLULARE'
      Size = 200
      Calculated = True
    end
    object selT030I060EMAILPERSONALE: TStringField
      FieldKind = fkCalculated
      FieldName = 'I060EMAILPERSONALE'
      Size = 200
      Calculated = True
    end
    object selT030I060CELLULAREPERSONALE: TStringField
      FieldKind = fkCalculated
      FieldName = 'I060CELLULAREPERSONALE'
      Size = 200
      Calculated = True
    end
  end
  object selT480: TOracleDataSet
    SQL.Strings = (
      'SELECT * '
      'FROM T480_COMUNI'
      'WHERE CODICE = :CODICE')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 120
    Top = 144
    object selT480CODICE: TStringField
      FieldName = 'CODICE'
      Size = 6
    end
    object selT480CITTA: TStringField
      DisplayWidth = 35
      FieldName = 'CITTA'
      Size = 60
    end
    object selT480CAP: TStringField
      FieldName = 'CAP'
      Size = 5
    end
    object selT480PROVINCIA: TStringField
      FieldName = 'PROVINCIA'
      Size = 2
    end
    object selT480CODCATASTALE: TStringField
      FieldName = 'CODCATASTALE'
      Size = 4
    end
  end
  object dsrT030: TDataSource
    AutoEdit = False
    DataSet = selT030
    Left = 224
    Top = 72
  end
  object selComune: TOracleDataSet
    SQL.Strings = (
      'SELECT * '
      'FROM T480_COMUNI'
      ':ORDERBY ')
    ReadBuffer = 10000
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A004F0052004400450052004200590001000000
      0000000000000000}
    Left = 24
    Top = 208
    object selComuneCODICE: TStringField
      DisplayLabel = 'Cod.ISTAT'
      DisplayWidth = 10
      FieldName = 'CODICE'
      Required = True
      Size = 6
    end
    object selComuneCITTA: TStringField
      DisplayLabel = 'Comune'
      DisplayWidth = 60
      FieldName = 'CITTA'
      Size = 60
    end
    object selComuneCAP: TStringField
      FieldName = 'CAP'
      Size = 5
    end
    object selComunePROVINCIA: TStringField
      DisplayLabel = 'Prov.'
      DisplayWidth = 5
      FieldName = 'PROVINCIA'
      Size = 2
    end
    object selComuneCODCATASTALE: TStringField
      DisplayLabel = 'Cod.Catastale'
      DisplayWidth = 10
      FieldName = 'CODCATASTALE'
      Size = 4
    end
  end
  object dsrComune: TDataSource
    AutoEdit = False
    DataSet = selComune
    Left = 88
    Top = 208
  end
  object selT033_Pagine: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT NOMEPAGINA FROM T033_LAYOUT WHERE '
      'NOMEPAGINA <> '#39'Dati Anagrafici'#39' AND'
      'NOMEPAGINA <> '#39'Parametri orario'#39' AND'
      'NOMEPAGINA <> '#39'Presenze/Assenze'#39
      'AND NOME = :NOME'
      'ORDER BY NOMEPAGINA')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A004E004F004D00450005000000000000000000
      0000}
    Left = 152
    Top = 72
  end
  object selT033: TOracleDataSet
    SQL.Strings = (
      'SELECT ROWID,NOMEPAGINA,TOP,LFT,CAPTION,ACCESSO, CAMPODB'
      'FROM T033_LAYOUT'
      'WHERE NOME = :NOME')
    ReadBuffer = 200
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A004E004F004D00450005000000000000000000
      0000}
    QBEDefinition.QBEFieldDefs = {
      05000000070000000C00000052004F0057004E0055004D000100000000001400
      00004E004F004D00450050004100470049004E0041000100000000000E000000
      430041004D0050004F00440042000100000000000600000054004F0050000100
      00000000060000004C00460054000100000000000E0000004300410050005400
      49004F004E000100000000000E0000004100430043004500530053004F000100
      00000000}
    Left = 88
    Top = 72
  end
  object selT430_appoggio: TOracleDataSet
    SQL.Strings = (
      'select T430.*,T430.ROWID from T430_STORICO T430'
      ' where :DataLav between DATADECORRENZA and DATAFINE'
      '   and  PROGRESSIVO = :Progressivo'
      '')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0044004100540041004C00410056000C000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000003C00000016000000500052004F004700520045005300530049005600
      4F000100000000001C00000044004100540041004400450043004F0052005200
      45004E005A004100010000000000100000004400410054004100460049004E00
      45000100000000000A000000420041004400470045000100000000000E000000
      45004400420041004400470045000100000000001200000049004E0044004900
      520049005A005A004F000100000000000C00000043004F004D0055004E004500
      0100000000000600000043004100500001000000000010000000540045004C00
      450046004F004E004F000100000000000C00000049004E0049005A0049004F00
      01000000000008000000460049004E0045000100000000000E00000054004900
      50004F004F0050004500010000000000120000005400450052004D0049004E00
      41004C0049000100000000001600000043004100550053005300540052004100
      4F00520044000100000000001000000053005400520041004F00520044004500
      0100000000001000000053005400520041004F00520044005500010000000000
      1200000053005400520041004F00520044004500550001000000000012000000
      43004F004E00540052004100540054004F000100000000000C0000004F005200
      4100520049004F00010000000000120000004800540045004F00520049004300
      4800450001000000000018000000500045005200530045004C00410053005400
      490043004F00010000000000120000005400470045005300540049004F004E00
      45000100000000000E00000050004C00550053004F0052004100010000000000
      14000000430041004C0045004E0044004100520049004F000100000000001200
      00004900500052004500530045004E005A0041000100000000000E0000005000
      4F0052004100520049004F000100000000001000000050004100530053004500
      4E005A0045000100000000001400000041004200430041005500530041004C00
      450031000100000000001600000041004200500052004500530045004E005A00
      410031000100000000000E000000530051005500410044005200410001000000
      0000180000005400490050004F0052004100500050004F00520054004F000100
      00000000100000005000410052005400540049004D0045000100000000001400
      000053005400520041004F005200440045005500320001000000000012000000
      50004500520053004F004E0041004C0045000100000000001200000053005400
      52005500540054005500520041000100000000000E00000041005A0049004500
      4E004400410001000000000010000000530045005200560049005A0049004F00
      0100000000001E00000053004F00540054004F005F0050004500520053004F00
      4E0041004C0045000100000000000E00000053004500540054004F0052004500
      0100000000000E0000005200450050004100520054004F000100000000001200
      00005100550041004C0049004600490043004100010000000000180000004300
      45004E00540052004F005F0043004F00530054004F000100000000001A000000
      5400490054004F004C004F005F00530054005500440049004F00010000000000
      1C0000005400490050004F005F004F00500045005200410054004F0052004500
      010000000000080000004E004F00540045000100000000001200000054004500
      4C00450046004F004E004F0032000100000000000C00000049004E0044004400
      4F004D000100000000000C00000043004100500044004F004D00010000000000
      0C00000043004F004D0044004F004D000100000000000E000000500052004F00
      560044004F004D00010000000000180000005200450050004500520049004200
      49004C004900540041000100000000001A00000053005400520041004F005200
      440049004E004100520049004F000100000000001200000049004E0043004500
      4E0054004900560049000100000000000E0000004C004900560045004C004C00
      4F000100000000001000000043004F004D004D00450053005300410001000000
      00001200000044004900520045005A0049004F004E0045000100000000000600
      000055004F0043000100000000000600000055004F0053000100000000001400
      000055004E004900540041005F00500052004F0044000100000000000E000000
      44004F00430045004E0054004500010000000000}
    LockingMode = lmLockImmediate
    CachedUpdates = True
    Left = 36
    Top = 142
  end
  object cdsElencoCampi: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 24
    Top = 272
    object cdsElencoCampiETICHETTA: TStringField
      FieldName = 'ETICHETTA'
    end
    object cdsElencoCampiNOMEDATO: TStringField
      DisplayLabel = 'NOME DATO'
      FieldName = 'NOMEDATO'
    end
    object cdsElencoCampiRIDEFINITO: TStringField
      FieldName = 'RIDEFINITO'
    end
    object cdsElencoCampiPAGINA: TStringField
      FieldName = 'PAGINA'
    end
    object cdsElencoCampiIDPAGINA: TIntegerField
      FieldName = 'IDPAGINA'
      Visible = False
    end
    object cdsElencoCampiIDCOMPONENTE: TIntegerField
      FieldName = 'IDCOMPONENTE'
      Visible = False
    end
  end
  object cdsrGridCercaCampo: TDataSource
    AutoEdit = False
    DataSet = cdsGridCercaCampo
    Left = 224
    Top = 272
  end
  object cdsGridCercaCampo: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 120
    Top = 272
  end
  object cdsStoriaDato: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 344
    Top = 272
    object cdsStoriaDatoDATO: TStringField
      DisplayLabel = 'Dato'
      DisplayWidth = 50
      FieldName = 'DATO'
      Size = 50
    end
    object cdsStoriaDatoDATADEC: TStringField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DATADEC'
    end
    object cdsStoriaDatoDATAFINE: TStringField
      DisplayLabel = 'Termine'
      FieldName = 'DATAFINE'
    end
    object cdsStoriaDatoVALORE: TStringField
      DisplayLabel = 'Valore'
      FieldName = 'VALORE'
      Size = 50
    end
    object cdsStoriaDatoDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 200
      FieldName = 'DESCRIZIONE'
      Size = 200
    end
    object cdsStoriaDatoKEY: TStringField
      FieldName = 'KEY'
      Visible = False
    end
    object cdsStoriaDatoRIGACOLORATA: TBooleanField
      FieldName = 'RIGACOLORATA'
      Visible = False
    end
  end
  object cdsrStoriaDato: TDataSource
    AutoEdit = False
    DataSet = cdsStoriaDato
    Left = 416
    Top = 272
  end
end
