inherited A104FStampaMissioniDtM1: TA104FStampaMissioniDtM1
  OldCreateOrder = True
  Height = 164
  Width = 303
  object SelM040: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT'
      'T030.MATRICOLA, T030.COGNOME, T030.NOME,'
      
        'M040.PROGRESSIVO, M040.MESESCARICO, M040.MESECOMPETENZA, M040.DA' +
        'TADA, M040.ORADA, M040.PROTOCOLLO, '
      
        'M040.TIPOREGISTRAZIONE, M040.DATAA, M040.ORAA, M040.TOTALEGG, M0' +
        '40.DURATA, M040.TARIFFAINDINTERA, M040.OREINDINTERA,'
      
        'M040.IMPORTOINDINTERA, M040.TARIFFAINDRIDOTTAH, M040.OREINDRIDOT' +
        'TAH, M040.IMPORTOINDRIDOTTAH, M040.TARIFFAINDRIDOTTAG, '
      
        'M040.OREINDRIDOTTAG, M040.IMPORTOINDRIDOTTAG, M040.TARIFFAINDRID' +
        'OTTAHG, M040.OREINDRIDOTTAHG, M040.IMPORTOINDRIDOTTAHG,'
      
        '-- M040.TARIFFAINDKMNELCOMUNE, M040.KMPERCORSINELCOMUNE, M040.IM' +
        'PORTOINDKMNELCOMUNE, M040.TARIFFAINDKMFUORICOMUNE, M040.KMPERCOR' +
        'SIFUORICOMUNE, M040.IMPORTOINDKMFUORICOMUNE, '
      
        'M040.FLAG_MODIFICATO, M040.PARTENZA, M040.DESTINAZIONE, M040.COM' +
        'MESSA, M011.DESCRIZIONE as DESCTIPOREGISTRAZIONE, M040.NOTE_RIMB' +
        'ORSI, M040.STATO, '
      'P030.ABBREVIAZIONE'
      
        'FROM M040_MISSIONI M040, T030_ANAGRAFICO T030, P030_VALUTE P030,' +
        ' M011_TIPOMISSIONE M011'
      'WHERE M040.PROGRESSIVO = T030.PROGRESSIVO'
      '  :STATOMISSIONE'
      '  AND M011.CODICE = M040.TIPOREGISTRAZIONE'
      '  AND P030.COD_VALUTA ='
      
        '       (SELECT COD_VALUTA_BASE FROM P150_SETUP WHERE DECORRENZA ' +
        '='
      
        '               (SELECT MAX(DECORRENZA) FROM P150_SETUP WHERE DEC' +
        'ORRENZA <= M040.DATAA))'
      
        '  AND P030.DECORRENZA = (SELECT MAX(P030B.DECORRENZA) FROM P030_' +
        'VALUTE P030B WHERE P030B.DECORRENZA <= M040.DATAA AND P030B.COD_' +
        'VALUTA = P030.COD_VALUTA)'
      
        '  AND T030.PROGRESSIVO IN (SELECT PROGRESSIVO FROM :C700SELANAGR' +
        'AFE)'
      '  :MESESCARICO'
      
        'order by M040.MESESCARICO, M040.PROGRESSIVO, M040.MESECOMPETENZA' +
        ', M040.DATADA, M040.ORADA')
    Optimize = False
    Variables.Data = {
      04000000030000001C0000003A0053005400410054004F004D00490053005300
      49004F004E004500010000000000000000000000200000003A00430037003000
      3000530045004C0041004E004100470052004100460045000100000000000000
      00000000180000003A004D004500530045005300430041005200490043004F00
      010000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000002100000016000000500052004F004700520045005300530049005600
      4F00010000000000160000004D00450053004500530043004100520049004300
      4F000100000000001C0000004D0045005300450043004F004D00500045005400
      45004E005A0041000100000000000C0000004400410054004100440041000100
      000000000A0000004F0052004100440041000100000000001400000050005200
      4F0054004F0043004F004C004C004F0001000000000022000000540049005000
      4F00520045004700490053005400520041005A0049004F004E00450001000000
      00000A00000044004100540041004100010000000000080000004F0052004100
      41000100000000001000000054004F00540041004C0045004700470001000000
      00000C0000004400550052004100540041000100000000002000000054004100
      5200490046004600410049004E00440049004E00540045005200410001000000
      0000180000004F005200450049004E00440049004E0054004500520041000100
      000000002000000049004D0050004F00520054004F0049004E00440049004E00
      5400450052004100010000000000240000005400410052004900460046004100
      49004E0044005200490044004F0054005400410048000100000000001C000000
      4F005200450049004E0044005200490044004F00540054004100480001000000
      00002400000049004D0050004F00520054004F0049004E004400520049004400
      4F00540054004100480001000000000024000000540041005200490046004600
      410049004E0044005200490044004F0054005400410047000100000000001C00
      00004F005200450049004E0044005200490044004F0054005400410047000100
      000000002400000049004D0050004F00520054004F0049004E00440052004900
      44004F0054005400410047000100000000002600000054004100520049004600
      4600410049004E0044005200490044004F005400540041004800470001000000
      00001E0000004F005200450049004E0044005200490044004F00540054004100
      480047000100000000002600000049004D0050004F00520054004F0049004E00
      44005200490044004F00540054004100480047000100000000001E0000004600
      4C00410047005F004D004F0044004900460049004300410054004F0001000000
      000010000000500041005200540045004E005A00410001000000000018000000
      440045005300540049004E0041005A0049004F004E0045000100000000001200
      00004D00410054005200490043004F004C0041000100000000000E0000004300
      4F0047004E004F004D004500010000000000080000004E004F004D0045000100
      000000001A000000410042004200520045005600490041005A0049004F004E00
      45000100000000001000000043004F004D004D00450053005300410001000000
      00002A00000044004500530043005400490050004F0052004500470049005300
      5400520041005A0049004F004E0045000100000000001A0000004E004F005400
      45005F00520049004D0042004F00520053004900010000000000}
    Filtered = True
    OnFilterRecord = FiltroDizionario
    Left = 36
    Top = 31
    object SelM040MATRICOLA: TStringField
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object SelM040COGNOME: TStringField
      DisplayWidth = 30
      FieldName = 'COGNOME'
      Size = 50
    end
    object SelM040NOME: TStringField
      DisplayWidth = 30
      FieldName = 'NOME'
      Size = 50
    end
    object SelM040PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Required = True
    end
    object SelM040MESESCARICO: TDateTimeField
      FieldName = 'MESESCARICO'
      Required = True
    end
    object SelM040MESECOMPETENZA: TDateTimeField
      FieldName = 'MESECOMPETENZA'
      Required = True
    end
    object SelM040DATADA: TDateTimeField
      FieldName = 'DATADA'
      Required = True
    end
    object SelM040ORADA: TStringField
      FieldName = 'ORADA'
      Required = True
      Size = 5
    end
    object SelM040PROTOCOLLO: TStringField
      FieldName = 'PROTOCOLLO'
      Size = 10
    end
    object SelM040TIPOREGISTRAZIONE: TStringField
      FieldName = 'TIPOREGISTRAZIONE'
      Required = True
      Size = 5
    end
    object SelM040DATAA: TDateTimeField
      FieldName = 'DATAA'
    end
    object SelM040ORAA: TStringField
      FieldName = 'ORAA'
      Size = 5
    end
    object SelM040TOTALEGG: TFloatField
      FieldName = 'TOTALEGG'
    end
    object SelM040DURATA: TStringField
      FieldName = 'DURATA'
      Size = 7
    end
    object SelM040TARIFFAINDINTERA: TFloatField
      FieldName = 'TARIFFAINDINTERA'
    end
    object SelM040OREINDINTERA: TFloatField
      FieldName = 'OREINDINTERA'
    end
    object SelM040IMPORTOINDINTERA: TFloatField
      FieldName = 'IMPORTOINDINTERA'
    end
    object SelM040TARIFFAINDRIDOTTAH: TFloatField
      FieldName = 'TARIFFAINDRIDOTTAH'
    end
    object SelM040OREINDRIDOTTAH: TFloatField
      FieldName = 'OREINDRIDOTTAH'
    end
    object SelM040IMPORTOINDRIDOTTAH: TFloatField
      FieldName = 'IMPORTOINDRIDOTTAH'
    end
    object SelM040TARIFFAINDRIDOTTAG: TFloatField
      FieldName = 'TARIFFAINDRIDOTTAG'
    end
    object SelM040OREINDRIDOTTAG: TFloatField
      FieldName = 'OREINDRIDOTTAG'
    end
    object SelM040IMPORTOINDRIDOTTAG: TFloatField
      FieldName = 'IMPORTOINDRIDOTTAG'
    end
    object SelM040TARIFFAINDRIDOTTAHG: TFloatField
      FieldName = 'TARIFFAINDRIDOTTAHG'
    end
    object SelM040OREINDRIDOTTAHG: TFloatField
      FieldName = 'OREINDRIDOTTAHG'
    end
    object SelM040IMPORTOINDRIDOTTAHG: TFloatField
      FieldName = 'IMPORTOINDRIDOTTAHG'
    end
    object SelM040FLAG_MODIFICATO: TStringField
      FieldName = 'FLAG_MODIFICATO'
      Size = 1
    end
    object SelM040PARTENZA: TStringField
      FieldName = 'PARTENZA'
      Size = 80
    end
    object SelM040DESTINAZIONE: TStringField
      FieldName = 'DESTINAZIONE'
      Size = 80
    end
    object SelM040ABBREVIAZIONE: TStringField
      FieldName = 'ABBREVIAZIONE'
      Size = 3
    end
    object SelM040COMMESSA: TStringField
      FieldName = 'COMMESSA'
      Size = 80
    end
    object SelM040DESCTIPOREGISTRAZIONE: TStringField
      FieldName = 'DESCTIPOREGISTRAZIONE'
      Size = 40
    end
    object SelM040NOTE_RIMBORSI: TStringField
      FieldName = 'NOTE_RIMBORSI'
      Size = 240
    end
    object SelM040STATO: TStringField
      FieldName = 'STATO'
      Size = 1
    end
  end
  object SelM050: TOracleDataSet
    SQL.Strings = (
      
        'SELECT M050.CODICERIMBORSOSPESE, M020.DESCRIZIONE, M020.FLAG_ANT' +
        'ICIPO, M050.IMPORTORIMBORSOSPESE, M050.IMPORTOINDENNITASUPPLEMEN' +
        'TARE'
      'FROM M050_RIMBORSI M050, M020_TIPIRIMBORSI M020'
      'WHERE M050.PROGRESSIVO=:PROGRESSIVO'
      '  AND M050.MESESCARICO=:MESESCARICO'
      '  AND M050.MESECOMPETENZA=:MESECOMPETENZA'
      '  AND M050.DATADA=:DATADA'
      '  AND M050.ORADA=:ORADA'
      '  AND M020.CODICE = M050.CODICERIMBORSOSPESE'
      'ORDER BY M020.FLAG_ANTICIPO ASC')
    Optimize = False
    Variables.Data = {
      0400000005000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000180000003A004D004500530045005300
      430041005200490043004F000C00000000000000000000001E0000003A004D00
      45005300450043004F004D0050004500540045004E005A0041000C0000000000
      0000000000000E0000003A004400410054004100440041000C00000000000000
      000000000C0000003A004F005200410044004100050000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000050000002600000043004F004400490043004500520049004D004200
      4F00520053004F00530050004500530045000100000000001600000044004500
      53004300520049005A0049004F004E0045000100000000002800000049004D00
      50004F00520054004F00520049004D0042004F00520053004F00530050004500
      530045000100000000003A00000049004D0050004F00520054004F0049004E00
      440045004E004E0049005400410053005500500050004C0045004D0045004E00
      54004100520045000100000000001A00000046004C00410047005F0041004E00
      540049004300490050004F00010000000000}
    Left = 88
    Top = 31
    object SelM050CODICERIMBORSOSPESE: TStringField
      FieldName = 'CODICERIMBORSOSPESE'
      Required = True
      Size = 5
    end
    object SelM050DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object SelM050FLAG_ANTICIPO: TStringField
      FieldName = 'FLAG_ANTICIPO'
      Required = True
      Size = 1
    end
    object SelM050IMPORTORIMBORSOSPESE: TFloatField
      FieldName = 'IMPORTORIMBORSOSPESE'
      DisplayFormat = '0.00'
    end
    object SelM050IMPORTOINDENNITASUPPLEMENTARE: TFloatField
      FieldName = 'IMPORTOINDENNITASUPPLEMENTARE'
      DisplayFormat = '0.00'
    end
  end
  object TabellaStampa: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 240
    Top = 32
  end
  object Q010: TOracleDataSet
    SQL.Strings = (
      'select '
      
        'decorrenza, codice, tipo_missione, descrizione, oreminimeperinde' +
        'nnita, limiteoreretribuiteintere, arrotondamentoore, percretribs' +
        'uperoore,'
      
        'maxgiorniretrmese, percretribsuperogg, arrottariffadoporiduzione' +
        ', arrottotimportidatipaghe, tipo, riduzione_pasto, percretribpas' +
        'to, '
      
        'tariffaindennita, tipo_tariffa, codvocepagheintera, codvocepaghe' +
        'suphh, codvocepaghesupgg, codvocepaghesuphhgg, '
      
        'orerimborsopasto, tariffarimborsopasto, orerimborsopasto2, tarif' +
        'farimborsopasto2, ind_da_tab_tariffe'
      'from m010_parametriconteggio'
      'where decorrenza = (select max(decorrenza) '
      '                      from m010_parametriconteggio '
      '                     where decorrenza <= :DECORRENZA '
      '                       AND tipo_missione=:tiporegistrazione'
      '                       and codice=:codice)'
      '  and tipo_missione=:tiporegistrazione'
      '  and codice=:codice')
    Optimize = False
    Variables.Data = {
      0400000003000000160000003A004400450043004F005200520045004E005A00
      41000C0000000000000000000000240000003A005400490050004F0052004500
      4700490053005400520041005A0049004F004E00450005000000000000000000
      00000E0000003A0043004F004400490043004500050000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000001A000000140000004400450043004F005200520045004E005A004100
      010000000000160000004400450053004300520049005A0049004F004E004500
      0100000000002A0000004F00520045004D0049004E0049004D00450050004500
      520049004E00440045004E004E00490054004100010000000000320000004C00
      49004D004900540045004F005200450052004500540052004900420055004900
      5400450049004E00540045005200450001000000000022000000410052005200
      4F0054004F004E00440041004D0045004E0054004F004F005200450001000000
      0000260000005000450052004300520045005400520049004200530055005000
      450052004F004F0052004500010000000000220000004D004100580047004900
      4F0052004E00490052004500540052004D004500530045000100000000002400
      0000500045005200430052004500540052004900420053005500500045005200
      4F0047004700010000000000320000004100520052004F005400540041005200
      490046004600410044004F0050004F0052004900440055005A0049004F004E00
      4500010000000000300000004100520052004F00540054004F00540049004D00
      50004F0052005400490044004100540049005000410047004800450001000000
      0000080000005400490050004F000100000000001E0000005200490044005500
      5A0049004F004E0045005F0050004100530054004F000100000000001E000000
      500045005200430052004500540052004900420050004100530054004F000100
      000000000C00000043004F0044004900430045000100000000001A0000005400
      490050004F005F004D0049005300530049004F004E0045000100000000002000
      0000540041005200490046004600410049004E00440045004E004E0049005400
      4100010000000000180000005400490050004F005F0054004100520049004600
      460041000100000000002400000043004F00440056004F004300450050004100
      47004800450049004E0054004500520041000100000000002200000043004F00
      440056004F004300450050004100470048004500530055005000480048000100
      000000002200000043004F00440056004F004300450050004100470048004500
      530055005000470047000100000000002600000043004F00440056004F004300
      4500500041004700480045005300550050004800480047004700010000000000
      2000000043004F004400520049004D0042004F00520053004F00500041005300
      54004F00010000000000200000004F0052004500520049004D0042004F005200
      53004F0050004100530054004F00010000000000280000005400410052004900
      460046004100520049004D0042004F00520053004F0050004100530054004F00
      010000000000220000004F0052004500520049004D0042004F00520053004F00
      50004100530054004F0032000100000000002A00000054004100520049004600
      46004100520049004D0042004F00520053004F0050004100530054004F003200
      010000000000}
    Left = 148
    Top = 32
    object Q010DECORRENZA: TDateTimeField
      FieldName = 'DECORRENZA'
      Required = True
    end
    object Q010CODICE: TStringField
      FieldName = 'CODICE'
      Required = True
      Size = 80
    end
    object Q010TIPO_MISSIONE: TStringField
      FieldName = 'TIPO_MISSIONE'
      Required = True
      Size = 5
    end
    object Q010DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object Q010OREMINIMEPERINDENNITA: TStringField
      FieldName = 'OREMINIMEPERINDENNITA'
      Size = 5
    end
    object Q010LIMITEORERETRIBUITEINTERE: TStringField
      FieldName = 'LIMITEORERETRIBUITEINTERE'
      Size = 6
    end
    object Q010ARROTONDAMENTOORE: TFloatField
      FieldName = 'ARROTONDAMENTOORE'
    end
    object Q010PERCRETRIBSUPEROORE: TFloatField
      FieldName = 'PERCRETRIBSUPEROORE'
    end
    object Q010MAXGIORNIRETRMESE: TFloatField
      FieldName = 'MAXGIORNIRETRMESE'
    end
    object Q010PERCRETRIBSUPEROGG: TFloatField
      FieldName = 'PERCRETRIBSUPEROGG'
    end
    object Q010ARROTTARIFFADOPORIDUZIONE: TStringField
      FieldName = 'ARROTTARIFFADOPORIDUZIONE'
      Size = 5
    end
    object Q010ARROTTOTIMPORTIDATIPAGHE: TStringField
      FieldName = 'ARROTTOTIMPORTIDATIPAGHE'
      Size = 5
    end
    object Q010TIPO: TStringField
      FieldName = 'TIPO'
      Required = True
      Size = 1
    end
    object Q010RIDUZIONE_PASTO: TStringField
      FieldName = 'RIDUZIONE_PASTO'
      Required = True
      Size = 1
    end
    object Q010PERCRETRIBPASTO: TFloatField
      FieldName = 'PERCRETRIBPASTO'
    end
    object Q010TARIFFAINDENNITA: TFloatField
      FieldName = 'TARIFFAINDENNITA'
    end
    object Q010TIPO_TARIFFA: TStringField
      FieldName = 'TIPO_TARIFFA'
      Size = 1
    end
    object Q010CODVOCEPAGHEINTERA: TStringField
      FieldName = 'CODVOCEPAGHEINTERA'
      Size = 6
    end
    object Q010CODVOCEPAGHESUPHH: TStringField
      FieldName = 'CODVOCEPAGHESUPHH'
      Size = 6
    end
    object Q010CODVOCEPAGHESUPGG: TStringField
      FieldName = 'CODVOCEPAGHESUPGG'
      Size = 6
    end
    object Q010CODVOCEPAGHESUPHHGG: TStringField
      FieldName = 'CODVOCEPAGHESUPHHGG'
      Size = 6
    end
    object Q010ORERIMBORSOPASTO: TStringField
      FieldName = 'ORERIMBORSOPASTO'
      Size = 5
    end
    object Q010TARIFFARIMBORSOPASTO: TFloatField
      FieldName = 'TARIFFARIMBORSOPASTO'
    end
    object Q010ORERIMBORSOPASTO2: TStringField
      FieldName = 'ORERIMBORSOPASTO2'
      Size = 5
    end
    object Q010TARIFFARIMBORSOPASTO2: TFloatField
      FieldName = 'TARIFFARIMBORSOPASTO2'
    end
    object Q010IND_DA_TAB_TARIFFE: TStringField
      FieldName = 'IND_DA_TAB_TARIFFE'
      Size = 1
    end
  end
  object SelM052: TOracleDataSet
    SQL.Strings = (
      
        'SELECT m052.CODICEINDENNITAKM, m052.KMPERCORSI, m052.IMPORTOINDE' +
        'NNITA,'
      '      m021.DESCRIZIONE, m021.IMPORTO'
      'FROM M052_INDENNITAKM M052, M021_TIPIINDENNITAKM M021'
      'WHERE M052.PROGRESSIVO=:PROGRESSIVO'
      '  AND M052.MESESCARICO=:MESESCARICO'
      '  AND M052.MESECOMPETENZA=:MESECOMPETENZA'
      '  AND M052.DATADA=:DATADA'
      '  AND M052.ORADA=:ORADA'
      '  AND M021.CODICE = M052.CODICEINDENNITAKM'
      
        '  --AND M021.DECORRENZA = (SELECT MAX(DECORRENZA) FROM M021_TIPI' +
        'INDENNITAKM WHERE CODICE=M021.CODICE AND DECORRENZA <= :decorren' +
        'za) '
      
        '  AND :decorrenza BETWEEN M021.DECORRENZA AND M021.DECORRENZA_FI' +
        'NE ')
    Optimize = False
    Variables.Data = {
      0400000006000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000180000003A004D004500530045005300
      430041005200490043004F000C00000000000000000000001E0000003A004D00
      45005300450043004F004D0050004500540045004E005A0041000C0000000000
      0000000000000E0000003A004400410054004100440041000C00000000000000
      000000000C0000003A004F005200410044004100050000000000000000000000
      160000003A004400450043004F005200520045004E005A0041000C0000000000
      000000000000}
    QBEDefinition.QBEFieldDefs = {
      0500000005000000160000004400450053004300520049005A0049004F004E00
      45000100000000002200000043004F00440049004300450049004E0044004500
      4E004E004900540041004B004D00010000000000140000004B004D0050004500
      520043004F005200530049000100000000002000000049004D0050004F005200
      54004F0049004E00440045004E004E004900540041000100000000000E000000
      49004D0050004F00520054004F00010000000000}
    Left = 88
    Top = 79
    object SelM052CODICEINDENNITAKM: TStringField
      FieldName = 'CODICEINDENNITAKM'
      Required = True
      Size = 5
    end
    object SelM052KMPERCORSI: TFloatField
      FieldName = 'KMPERCORSI'
    end
    object SelM052IMPORTOINDENNITA: TFloatField
      FieldName = 'IMPORTOINDENNITA'
      DisplayFormat = '0.00'
    end
    object SelM052DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object SelM052IMPORTO: TFloatField
      FieldName = 'IMPORTO'
      DisplayFormat = '0,00'
    end
  end
  object P050: TOracleDataSet
    SQL.Strings = (
      'select '
      'T.COD_ARROTONDAMENTO,'
      'T.COD_VALUTA,'
      'T.DECORRENZA,'
      'T.DESCRIZIONE,'
      'T.VALORE,'
      'T.TIPO'
      'from p050_arrotondamenti T'
      'WHERE COD_ARROTONDAMENTO = :CODICE AND'
      
        'T.DECORRENZA = (SELECT MAX(A.DECORRENZA) FROM p050_arrotondament' +
        'i A WHERE A.DECORRENZA <= :DECORRENZA AND A.COD_ARROTONDAMENTO =' +
        ' T.COD_ARROTONDAMENTO) ')
    Optimize = False
    Variables.Data = {
      0400000002000000160000003A004400450043004F005200520045004E005A00
      41000C00000000000000000000000E0000003A0043004F004400490043004500
      050000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000060000002400000043004F0044005F004100520052004F0054004F00
      4E00440041004D0045004E0054004F000100000000001400000043004F004400
      5F00560041004C00550054004100010000000000140000004400450043004F00
      5200520045004E005A0041000100000000001600000044004500530043005200
      49005A0049004F004E0045000100000000000C000000560041004C004F005200
      4500010000000000080000005400490050004F00010000000000}
    Left = 147
    Top = 81
    object P050COD_ARROTONDAMENTO: TStringField
      FieldName = 'COD_ARROTONDAMENTO'
      Required = True
      Size = 5
    end
    object P050COD_VALUTA: TStringField
      FieldName = 'COD_VALUTA'
      Required = True
      Size = 10
    end
    object P050DECORRENZA: TDateTimeField
      FieldName = 'DECORRENZA'
      Required = True
    end
    object P050DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object P050VALORE: TFloatField
      FieldName = 'VALORE'
    end
    object P050TIPO: TStringField
      FieldName = 'TIPO'
      Size = 1
    end
  end
  object QSede: TOracleDataSet
    Optimize = False
    Left = 236
    Top = 84
  end
end
