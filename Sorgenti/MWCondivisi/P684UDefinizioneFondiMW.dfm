inherited P684FDefinizioneFondiMW: TP684FDefinizioneFondiMW
  OldCreateOrder = True
  Height = 436
  Width = 509
  object selP684Dec: TOracleDataSet
    SQL.Strings = (
      'select distinct decorrenza_da DECORRENZA'
      'from p684_fondi P684'
      'order by decorrenza_da')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000020000001600000043004F0044005F0054004100420045004C004C00
      4100010000000000160000004400450053004300520049005A0049004F004E00
      4500010000000000}
    Left = 143
    Top = 133
  end
  object selP684Ricerca: TOracleDataSet
    SQL.Strings = (
      'select distinct cod_fondo, descrizione'
      'from p684_fondi P684'
      'where decorrenza_da = :DEC'
      'order by cod_fondo')
    Optimize = False
    Variables.Data = {
      0400000001000000080000003A004400450043000C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000020000001600000043004F0044005F0054004100420045004C004C00
      4100010000000000160000004400450053004300520049005A0049004F004E00
      4500010000000000}
    OnFilterRecord = selP684RicercaFilterRecord
    Left = 229
    Top = 133
    object selP684RicercaCOD_FONDO: TStringField
      DisplayLabel = 'Cod. fondo'
      DisplayWidth = 20
      FieldName = 'COD_FONDO'
      Size = 15
    end
    object selP684RicercaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 500
    end
  end
  object selP680: TOracleDataSet
    SQL.Strings = (
      'select *'
      'from p680_fondimacrocateg'
      'order by cod_macrocateg')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000020000001600000043004F0044005F0054004100420045004C004C00
      4100010000000000160000004400450053004300520049005A0049004F004E00
      4500010000000000}
    Left = 325
    Top = 21
  end
  object dsrP680: TDataSource
    DataSet = selP680
    Left = 325
    Top = 73
  end
  object selP682: TOracleDataSet
    SQL.Strings = (
      'select *'
      'from p682_fondiraggr'
      'order by cod_raggr')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000020000001600000043004F0044005F0054004100420045004C004C00
      4100010000000000160000004400450053004300520049005A0049004F004E00
      4500010000000000}
    Left = 389
    Top = 21
  end
  object dsrP682: TDataSource
    DataSet = selP682
    Left = 389
    Top = 73
  end
  object selP686D: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid from P686_RISDESTGEN t'
      'where cod_fondo = :COD'
      'and decorrenza_da = :DEC'
      'and class_voce = '#39'D'#39
      'order by nvl(ordine_stampa,9999), cod_voce_gen')
    Optimize = False
    Variables.Data = {
      0400000002000000080000003A0043004F004400050000000000000000000000
      080000003A004400450043000C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000070000001200000043004F0044005F0046004F004E0044004F000100
      000000001A0000004400450043004F005200520045004E005A0041005F004400
      4100010000000000160000004400450053004300520049005A0049004F004E00
      45000100000000001400000043004C004100530053005F0056004F0043004500
      0100000000001800000043004F0044005F0056004F00430045005F0047004500
      4E00010000000000120000005400490050004F005F0056004F00430045000100
      000000001A0000004F005200440049004E0045005F005300540041004D005000
      4100010000000000}
    BeforeInsert = selP686DBeforeInsert
    BeforeEdit = selP686DBeforeEdit
    OnCalcFields = selP686DCalcFields
    OnNewRecord = selP686DNewRecord
    Left = 82
    Top = 197
    object selP686DCOD_FONDO: TStringField
      DisplayLabel = 'Cod. fondo'
      FieldName = 'COD_FONDO'
      Required = True
      Visible = False
      Size = 15
    end
    object selP686DDECORRENZA_DA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA_DA'
      Required = True
      Visible = False
    end
    object selP686DCLASS_VOCE: TStringField
      DisplayLabel = 'Classificaz. voce'
      FieldName = 'CLASS_VOCE'
      Required = True
      Visible = False
      Size = 1
    end
    object selP686DCOD_VOCE_GEN: TStringField
      DisplayLabel = 'Voce gen.'
      FieldName = 'COD_VOCE_GEN'
      Required = True
      Size = 5
    end
    object selP686DDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 50
      FieldName = 'DESCRIZIONE'
      Size = 200
    end
    object selP686DTIPO_VOCE: TStringField
      DisplayLabel = 'Tipo'
      DisplayWidth = 20
      FieldName = 'TIPO_VOCE'
      Size = 50
    end
    object selP686DORDINE_STAMPA: TFloatField
      DisplayLabel = 'Ordine stampa'
      FieldName = 'ORDINE_STAMPA'
    end
    object selP686DImporto: TFloatField
      DisplayWidth = 15
      FieldKind = fkCalculated
      FieldName = 'Importo'
      ReadOnly = True
      DisplayFormat = '###,###,###,##0'
      Calculated = True
    end
  end
  object dsrP686D: TDataSource
    AutoEdit = False
    DataSet = selP686D
    Left = 82
    Top = 249
  end
  object selP688R: TOracleDataSet
    SQL.Strings = (
      'select P688.*, P688.rowid'
      'from P688_RISDESTDET P688, P686_RISDESTGEN P686'
      'where P688.cod_fondo = :COD'
      'and P688.decorrenza_da = :DEC'
      'and P688.class_voce = '#39'R'#39
      'and P688.cod_fondo = P686.cod_fondo'
      'and P688.decorrenza_da = P686.decorrenza_da'
      'and P688.class_voce = P686.class_voce'
      'and P688.cod_voce_gen = P686.cod_voce_gen'
      
        'order by nvl(ordine_stampa,9999), P686.cod_voce_gen, P688.cod_vo' +
        'ce_det')
    Optimize = False
    Variables.Data = {
      0400000002000000080000003A0043004F004400050000000000000000000000
      080000003A004400450043000C0000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000100000001200000043004F0044005F0046004F004E0044004F000100
      000000001A0000004400450043004F005200520045004E005A0041005F004400
      4100010000000000160000004400450053004300520049005A0049004F004E00
      45000100000000001400000043004C004100530053005F0056004F0043004500
      0100000000001800000043004F0044005F0056004F00430045005F0047004500
      4E000100000000001A0000004F005200440049004E0045005F00530054004100
      4D00500041000100000000001800000043004F0044005F0056004F0043004500
      5F004400450054000100000000002000000044004100540041005F0052004900
      46004500520049004D0045004E0054004F000100000000001000000051005500
      41004E005400490054004100010000000000100000004400410054004F004200
      4100530045000100000000001C0000004D004F004C005400490050004C004900
      4300410054004F00520045000100000000000E00000049004D0050004F005200
      54004F000100000000002400000043004F0044005F004100520052004F005400
      4F004E00440041004D0045004E0054004F000100000000002200000046004900
      4C00540052004F005F0044004900500045004E00440045004E00540049000100
      000000002E00000043004F0044004900430049005F004100430043004F005200
      500041004D0045004E0054004F0056004F00430049000100000000001A000000
      4400450053004300520049005A0049004F004E0045005F003100010000000000}
    BeforeInsert = selP688RBeforeInsert
    BeforeEdit = selP688RBeforeEdit
    BeforePost = selP688RBeforePost
    BeforeDelete = selP688DBeforeDelete
    AfterDelete = selP688DAfterDelete
    OnNewRecord = selP688RNewRecord
    Left = 221
    Top = 197
    object selP688RCOD_FONDO: TStringField
      DisplayLabel = 'Cod. fondo'
      FieldName = 'COD_FONDO'
      Required = True
      Visible = False
      Size = 15
    end
    object selP688RDECORRENZA_DA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA_DA'
      Required = True
      Visible = False
    end
    object selP688RCLASS_VOCE: TStringField
      DisplayLabel = 'Classificaz. voce'
      FieldName = 'CLASS_VOCE'
      Required = True
      Visible = False
      Size = 1
    end
    object selP688RCOD_VOCE_GEN: TStringField
      DisplayLabel = 'Voce gen.'
      FieldName = 'COD_VOCE_GEN'
      Required = True
      Size = 5
    end
    object selP688RDescVoceGen: TStringField
      DisplayLabel = 'Risorsa generale'
      DisplayWidth = 40
      FieldKind = fkLookup
      FieldName = 'DescVoceGen'
      LookupDataSet = selP686R
      LookupKeyFields = 'COD_VOCE_GEN'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COD_VOCE_GEN'
      ReadOnly = True
      Size = 500
      Lookup = True
    end
    object selP688RCOD_VOCE_DET: TStringField
      DisplayLabel = 'Cod. dett.'
      FieldName = 'COD_VOCE_DET'
      Required = True
      Size = 5
    end
    object selP688RDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione risorsa dettagliata'
      DisplayWidth = 40
      FieldName = 'DESCRIZIONE'
      Size = 200
    end
    object selP688RDATA_RIFERIMENTO: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Data riferim.'
      DisplayWidth = 10
      FieldName = 'DATA_RIFERIMENTO'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object selP688RQUANTITA: TFloatField
      DisplayLabel = 'Quantit'#224
      FieldName = 'QUANTITA'
    end
    object selP688RDATOBASE: TFloatField
      DisplayLabel = 'Dato base'
      FieldName = 'DATOBASE'
    end
    object selP688RMOLTIPLICATORE: TFloatField
      DisplayLabel = 'Moltiplicatore'
      FieldName = 'MOLTIPLICATORE'
    end
    object selP688RIMPORTO: TFloatField
      DisplayLabel = 'Imp. previsto'
      DisplayWidth = 15
      FieldName = 'IMPORTO'
      Required = True
      DisplayFormat = '###,###,###,##0.00'
    end
    object selP688RCOD_ARROTONDAMENTO: TStringField
      DisplayLabel = 'Cod. arrotondamento'
      FieldName = 'COD_ARROTONDAMENTO'
      Size = 5
    end
    object selP688RFILTRO_DIPENDENTI: TStringField
      DisplayLabel = 'Filtro dipendenti'
      DisplayWidth = 50
      FieldName = 'FILTRO_DIPENDENTI'
      Visible = False
      Size = 500
    end
    object selP688RCODICI_ACCORPAMENTOVOCI: TStringField
      DisplayLabel = 'Cod. accorpamento'
      DisplayWidth = 50
      FieldName = 'CODICI_ACCORPAMENTOVOCI'
      Visible = False
      Size = 500
    end
  end
  object dsrP688R: TDataSource
    DataSet = selP688R
    Left = 221
    Top = 249
  end
  object dsrP688D: TDataSource
    DataSet = selP688D
    Left = 300
    Top = 249
  end
  object selP688D: TOracleDataSet
    SQL.Strings = (
      'select P688.*, P688.rowid'
      'from P688_RISDESTDET P688, P686_RISDESTGEN P686'
      'where P688.cod_fondo = :COD'
      'and P688.decorrenza_da = :DEC'
      'and P688.class_voce = '#39'D'#39
      'and P688.cod_fondo = P686.cod_fondo'
      'and P688.decorrenza_da = P686.decorrenza_da'
      'and P688.class_voce = P686.class_voce'
      'and P688.cod_voce_gen = P686.cod_voce_gen'
      
        'order by nvl(ordine_stampa,9999), P686.cod_voce_gen, P688.cod_vo' +
        'ce_det'
      '')
    Optimize = False
    Variables.Data = {
      0400000002000000080000003A0043004F004400050000000000000000000000
      080000003A004400450043000C0000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000100000001200000043004F0044005F0046004F004E0044004F000100
      000000001A0000004400450043004F005200520045004E005A0041005F004400
      4100010000000000160000004400450053004300520049005A0049004F004E00
      45000100000000001400000043004C004100530053005F0056004F0043004500
      0100000000001800000043004F0044005F0056004F00430045005F0047004500
      4E000100000000001A0000004F005200440049004E0045005F00530054004100
      4D00500041000100000000001800000043004F0044005F0056004F0043004500
      5F004400450054000100000000002000000044004100540041005F0052004900
      46004500520049004D0045004E0054004F000100000000001000000051005500
      41004E005400490054004100010000000000100000004400410054004F004200
      4100530045000100000000001C0000004D004F004C005400490050004C004900
      4300410054004F00520045000100000000000E00000049004D0050004F005200
      54004F000100000000002400000043004F0044005F004100520052004F005400
      4F004E00440041004D0045004E0054004F000100000000002200000046004900
      4C00540052004F005F0044004900500045004E00440045004E00540049000100
      000000002E00000043004F0044004900430049005F004100430043004F005200
      500041004D0045004E0054004F0056004F00430049000100000000001A000000
      4400450053004300520049005A0049004F004E0045005F003100010000000000}
    BeforeInsert = selP688DBeforeInsert
    BeforeEdit = selP688DBeforeEdit
    BeforePost = selP688DBeforePost
    BeforeDelete = selP688DBeforeDelete
    AfterDelete = selP688DAfterDelete
    OnNewRecord = selP688DNewRecord
    Left = 300
    Top = 197
    object selP688DCOD_FONDO: TStringField
      DisplayLabel = 'Cod. fondo'
      FieldName = 'COD_FONDO'
      Required = True
      Visible = False
      Size = 15
    end
    object selP688DDECORRENZA_DA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA_DA'
      Required = True
      Visible = False
    end
    object selP688DCLASS_VOCE: TStringField
      DisplayLabel = 'Classificaz. voce'
      FieldName = 'CLASS_VOCE'
      Required = True
      Visible = False
      Size = 1
    end
    object selP688DCOD_VOCE_GEN: TStringField
      DisplayLabel = 'Voce gen.'
      FieldName = 'COD_VOCE_GEN'
      Required = True
      Size = 5
    end
    object selP688DDescVoceGen: TStringField
      DisplayLabel = 'Destinazione generale'
      DisplayWidth = 40
      FieldKind = fkLookup
      FieldName = 'DescVoceGen'
      LookupDataSet = selP686D
      LookupKeyFields = 'COD_VOCE_GEN'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COD_VOCE_GEN'
      ReadOnly = True
      Size = 500
      Lookup = True
    end
    object selP688DCOD_VOCE_DET: TStringField
      DisplayLabel = 'Cod. dett.'
      FieldName = 'COD_VOCE_DET'
      Required = True
      Size = 5
    end
    object selP688DDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione destinazione dettagliata'
      DisplayWidth = 40
      FieldName = 'DESCRIZIONE'
      Size = 200
    end
    object selP688DDATA_RIFERIMENTO: TDateTimeField
      DisplayLabel = 'Data riferim.'
      DisplayWidth = 10
      FieldName = 'DATA_RIFERIMENTO'
      Visible = False
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object selP688DQUANTITA: TFloatField
      DisplayLabel = 'Quantit'#224
      FieldName = 'QUANTITA'
      Visible = False
    end
    object selP688DDATOBASE: TFloatField
      DisplayLabel = 'Dato base'
      FieldName = 'DATOBASE'
      Visible = False
    end
    object selP688DMOLTIPLICATORE: TFloatField
      DisplayLabel = 'Moltiplicatore'
      FieldName = 'MOLTIPLICATORE'
      Visible = False
    end
    object selP688DIMPORTO: TFloatField
      DisplayLabel = 'Imp. speso'
      DisplayWidth = 15
      FieldName = 'IMPORTO'
      Required = True
      DisplayFormat = '###,###,###,##0.00'
    end
    object selP688DCOD_ARROTONDAMENTO: TStringField
      DisplayLabel = 'Cod. arrotondamento'
      FieldName = 'COD_ARROTONDAMENTO'
      Size = 5
    end
    object selP688DFILTRO_DIPENDENTI: TStringField
      DisplayLabel = 'Filtro dipendenti'
      DisplayWidth = 50
      FieldName = 'FILTRO_DIPENDENTI'
      Size = 500
    end
    object selP688DCODICI_ACCORPAMENTOVOCI: TStringField
      DisplayLabel = 'Cod. accorpamento'
      DisplayWidth = 20
      FieldName = 'CODICI_ACCORPAMENTOVOCI'
      Size = 500
    end
  end
  object selP688Tot: TOracleQuery
    SQL.Strings = (
      
        'select ROUND(sum(decode(p688.class_voce,'#39'R'#39',p688.importo,0))) ri' +
        'sorse,'
      
        '       ROUND(sum(decode(p688.class_voce,'#39'D'#39',p688.importo,0))) sp' +
        'eso,'
      
        '       ROUND(sum(decode(p688.class_voce,'#39'R'#39',p688.importo,0))) - ' +
        'ROUND(sum(decode(p688.class_voce,'#39'D'#39',p688.importo,0))) residuo'
      'from p688_risdestdet P688'
      'where cod_fondo = :COD'
      '  and decorrenza_da = :DEC'
      ':FILTRO')
    Optimize = False
    Variables.Data = {
      0400000003000000080000003A0043004F004400050000000000000000000000
      080000003A004400450043000C00000000000000000000000E0000003A004600
      49004C00540052004F00010000000000000000000000}
    Left = 202
    Top = 324
  end
  object selP686Tipo: TOracleDataSet
    SQL.Strings = (
      'select distinct tipo_voce from P686_RISDESTGEN t'
      'where class_voce = :CLASS'
      'and tipo_voce is not null'
      'order by tipo_voce')
    Optimize = False
    Variables.Data = {
      04000000010000000C0000003A0043004C004100530053000500000002000000
      520000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000070000001200000043004F0044005F0046004F004E0044004F000100
      000000001A0000004400450043004F005200520045004E005A0041005F004400
      4100010000000000160000004400450053004300520049005A0049004F004E00
      45000100000000001400000043004C004100530053005F0056004F0043004500
      0100000000001800000043004F0044005F0056004F00430045005F0047004500
      4E00010000000000120000005400490050004F005F0056004F00430045000100
      000000001A0000004F005200440049004E0045005F005300540041004D005000
      4100010000000000}
    Left = 143
    Top = 197
  end
  object dsrP050: TDataSource
    DataSet = selP050
    Left = 26
    Top = 73
  end
  object selP050: TOracleDataSet
    SQL.Strings = (
      'SELECT P050.COD_ARROTONDAMENTO,P050.VALORE,P050.TIPO'
      'FROM P050_ARROTONDAMENTI P050 WHERE'
      'P050.COD_VALUTA = :CodValuta AND'
      
        'P050.DECORRENZA = (SELECT MAX(DECORRENZA) FROM P050_ARROTONDAMEN' +
        'TI'
      
        '   WHERE DECORRENZA <= :Decorrenza AND COD_ARROTONDAMENTO = P050' +
        '.COD_ARROTONDAMENTO AND '
      '   COD_VALUTA = P050.COD_VALUTA)')
    Optimize = False
    Variables.Data = {
      0400000002000000160000003A004400450043004F005200520045004E005A00
      41000C0000000000000000000000140000003A0043004F004400560041004C00
      550054004100050000000000000000000000}
    CommitOnPost = False
    Left = 28
    Top = 21
  end
  object selP500: TOracleDataSet
    SQL.Strings = (
      'SELECT COD_VALUTA '
      'FROM P500_CUDSETUP P1'
      'WHERE ANNO = (SELECT MAX(ANNO) '
      '              FROM P500_CUDSETUP P2 '
      '              WHERE ANNO <= :Anno '
      '              AND P2.COD_AZIENDA_BASE = P1.COD_AZIENDA_BASE)'
      'AND P1.COD_AZIENDA_BASE = '#39'BASE'#39)
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A0041004E004E004F0005000000000000000000
      0000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000C0000000800000041004E004E004F000100000000000A0000005000
      41005200540045000100000000000C0000004E0055004D00450052004F000100
      00000000160000004400450053004300520049005A0049004F004E0045000100
      00000000100000004E0055004D0045005200490043004F000100000000002400
      000043004F0044005F004100520052004F0054004F004E00440041004D004500
      4E0054004F000100000000000E00000046004F0052004D00410054004F000100
      00000000180000004F004D0045005400540049005F00560055004F0054004F00
      010000000000320000005200450047004F004C0041005F00430041004C004300
      4F004C004F005F004100550054004F004D004100540049004300410001000000
      00002C0000005200450047004F004C0041005F00430041004C0043004F004C00
      4F005F004D0041004E00550041004C0045000100000000002600000052004500
      47004F004C0041005F004D004F00440049004600490043004100420049004C00
      45000100000000001000000043004F004D004D0045004E0054004F0001000000
      0000}
    Left = 263
    Top = 21
  end
  object selP690A: TOracleDataSet
    SQL.Strings = (
      'select :DATI, SUM(P690.IMPORTO) Importo'
      
        'from P690_FONDISPESO P690, P200_VOCI P200, T030_ANAGRAFICO T030,' +
        ' P430_ANAGRAFICO P430'
      'where P690.cod_fondo = :COD'
      'and P690.decorrenza_da = :DEC'
      'and P690.class_voce = '#39'D'#39
      ':CODGEN'
      ':CODDET'
      'and p690.cod_contratto = p200.cod_contratto (+)'
      'and p690.cod_voce = p200.cod_voce (+)'
      'and p200.cod_voce_speciale (+) = '#39'BASE'#39
      
        'and NVL(p200.decorrenza,TO_DATE('#39'01011900'#39','#39'DDMMYYYY'#39'))  = NVL((' +
        'select max(decorrenza) from p200_voci'
      
        '                        where cod_contratto = p200.cod_contratto' +
        ' '
      '                          and cod_voce = p200.cod_voce'
      
        '                          and cod_voce_speciale = p200.cod_voce_' +
        'speciale'
      
        '                          and decorrenza <= :DEC),TO_DATE('#39'01011' +
        '900'#39','#39'DDMMYYYY'#39')) '
      'and P690.PROGRESSIVO = T030.PROGRESSIVO (+)'
      
        'and P690.PROGRESSIVO = P430.PROGRESSIVO (+) and P690.DATA_RETRIB' +
        'UZIONE between P430.DECORRENZA (+) and P430.DECORRENZA_FINE (+)'
      'group by :DATI'
      'order by :DATI')
    Optimize = False
    Variables.Data = {
      0400000005000000080000003A0043004F004400050000000000000000000000
      080000003A004400450043000C00000000000000000000000E0000003A004300
      4F004400470045004E000100000000000000000000000E0000003A0043004F00
      44004400450054000100000000000000000000000A0000003A00440041005400
      4900010000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000A0000002200000044004100540041005F0052004500540052004900
      420055005A0049004F004E0045000100000000001A00000043004F0044005F00
      43004F004E00540052004100540054004F000100000000001000000043004F00
      44005F0056004F00430045000100000000002200000043004F0044005F005600
      4F00430045005F005300500045004300490041004C0045000100000000000E00
      000049004D0050004F00520054004F000100000000001200000043004F004400
      5F0046004F004E0044004F000100000000001A0000004400450043004F005200
      520045004E005A0041005F00440041000100000000001400000043004C004100
      530053005F0056004F00430045000100000000001800000043004F0044005F00
      56004F00430045005F00470045004E000100000000001800000043004F004400
      5F0056004F00430045005F00440045005400010000000000}
    AfterOpen = selP690AAfterOpen
    Left = 430
    Top = 197
  end
  object dsrP690A: TDataSource
    DataSet = selP690A
    Left = 430
    Top = 249
  end
  object selP210: TOracleDataSet
    SQL.Strings = (
      'select COD_CONTRATTO,DESCRIZIONE'
      'from P210_CONTRATTI P210'
      'order by cod_contratto')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000020000001A00000043004F0044005F0043004F004E00540052004100
      540054004F00010000000000160000004400450053004300520049005A004900
      4F004E004500010000000000}
    Left = 142
    Top = 21
    object selP210COD_CONTRATTO: TStringField
      DisplayLabel = 'Contratto voci'
      FieldName = 'COD_CONTRATTO'
      Required = True
      Size = 5
    end
    object selP210DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
  object selP200: TOracleDataSet
    SQL.Strings = (
      'select *'
      'from P200_VOCI P200'
      'where P200.cod_contratto = :Cod_Contratto'
      'and (P200.cod_voce = :Cod_Voce or :Cod_Voce = '#39'*'#39')'
      'and P200.cod_voce_speciale = '#39'BASE'#39
      'and P200.decorrenza = (select max(decorrenza) from P200_voci'
      
        '                         where cod_contratto = P200.cod_contratt' +
        'o'
      '                           and cod_voce = P200.cod_voce'
      
        '                           and cod_voce_speciale = P200.cod_voce' +
        '_speciale'
      '                           and decorrenza <= :Decorrenza)'
      ':ORDERBY')
    Optimize = False
    Variables.Data = {
      04000000040000001C0000003A0043004F0044005F0043004F004E0054005200
      4100540054004F00050000000000000000000000120000003A0043004F004400
      5F0056004F0043004500050000000000000000000000160000003A0044004500
      43004F005200520045004E005A0041000C000000000000000000000010000000
      3A004F00520044004500520042005900010000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000060000002200000044004100540041005F0052004500540052004900
      420055005A0049004F004E0045000100000000001A00000043004F0044005F00
      43004F004E00540052004100540054004F000100000000001000000043004F00
      44005F0056004F00430045000100000000002200000043004F0044005F005600
      4F00430045005F005300500045004300490041004C0045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000000E00
      000049004D0050004F00520054004F00010000000000}
    Left = 85
    Top = 21
    object selP200COD_VOCE: TStringField
      DisplayLabel = 'Cod. voce'
      FieldName = 'COD_VOCE'
      Size = 5
    end
    object selP200COD_VOCE_SPECIALE: TStringField
      DisplayLabel = 'Speciale'
      FieldName = 'COD_VOCE_SPECIALE'
      Size = 5
    end
    object selP200DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
  object selP215: TOracleDataSet
    SQL.Strings = (
      
        'select t.cod_tipoaccorpamentovoci || '#39'.'#39' || t.cod_codiciaccorpam' +
        'entovoci codice, descrizione'
      'from p215_codiciaccorpamentovoci t'
      'order by codice')
    Optimize = False
    Left = 204
    Top = 21
  end
  object ScriptSQL: TOracleScript
    Left = 28
    Top = 324
  end
  object selP684Controllo: TOracleQuery
    SQL.Strings = (
      'select count(*) conta'
      'from p684_fondi P684'
      'where cod_fondo = :COD'
      'and decorrenza_da <= :FINE'
      'and decorrenza_a >= :DEC'
      'and rowid <> :RIGA')
    Optimize = False
    Variables.Data = {
      0400000004000000080000003A0043004F004400050000000000000000000000
      0A0000003A00460049004E0045000C0000000000000000000000080000003A00
      4400450043000C00000000000000000000000A0000003A005200490047004100
      050000000000000000000000}
    Left = 46
    Top = 133
  end
  object selCheckAnagrafe: TOracleQuery
    SQL.Strings = (
      'select v430f_chekanagrafe(1,sysdate,:FILTRO_DIPENDENTI)'
      '  from DUAL')
    Optimize = False
    Variables.Data = {
      0400000001000000240000003A00460049004C00540052004F005F0044004900
      500045004E00440045004E0054004900050000000000000000000000}
    Left = 114
    Top = 324
  end
  object selP686R: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid from P686_RISDESTGEN t'
      'where cod_fondo = :COD'
      'and decorrenza_da = :DEC'
      'and class_voce = '#39'R'#39
      'order by nvl(ordine_stampa,9999), cod_voce_gen')
    Optimize = False
    Variables.Data = {
      0400000002000000080000003A0043004F004400050000000000000000000000
      080000003A004400450043000C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000070000001200000043004F0044005F0046004F004E0044004F000100
      000000001A0000004400450043004F005200520045004E005A0041005F004400
      4100010000000000160000004400450053004300520049005A0049004F004E00
      45000100000000001400000043004C004100530053005F0056004F0043004500
      0100000000001800000043004F0044005F0056004F00430045005F0047004500
      4E00010000000000120000005400490050004F005F0056004F00430045000100
      000000001A0000004F005200440049004E0045005F005300540041004D005000
      4100010000000000}
    BeforeInsert = selP686RBeforeInsert
    BeforeEdit = selP686RBeforeEdit
    OnCalcFields = selP686RCalcFields
    OnNewRecord = selP686RNewRecord
    Left = 28
    Top = 198
    object selP686RCOD_FONDO: TStringField
      DisplayLabel = 'Cod. fondo'
      FieldName = 'COD_FONDO'
      Required = True
      Visible = False
      Size = 15
    end
    object selP686RDECORRENZA_DA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA_DA'
      Required = True
      Visible = False
    end
    object selP686RCLASS_VOCE: TStringField
      DisplayLabel = 'Classificaz. voce'
      FieldName = 'CLASS_VOCE'
      Required = True
      Visible = False
      Size = 1
    end
    object selP686RCOD_VOCE_GEN: TStringField
      DisplayLabel = 'Voce gen.'
      FieldName = 'COD_VOCE_GEN'
      Required = True
      Size = 5
    end
    object selP686RDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 50
      FieldName = 'DESCRIZIONE'
      Size = 200
    end
    object selP686RTIPO_VOCE: TStringField
      DisplayLabel = 'Tipo'
      DisplayWidth = 20
      FieldName = 'TIPO_VOCE'
      Size = 50
    end
    object selP686RORDINE_STAMPA: TFloatField
      DisplayLabel = 'Ordine stampa'
      FieldName = 'ORDINE_STAMPA'
    end
    object selP686RImporto: TFloatField
      DisplayWidth = 15
      FieldKind = fkCalculated
      FieldName = 'Importo'
      ReadOnly = True
      DisplayFormat = '###,###,###,##0'
      Calculated = True
    end
  end
  object dsrP686R: TDataSource
    AutoEdit = False
    DataSet = selP686R
    Left = 29
    Top = 249
  end
end
