inherited S031FFamiliariMW: TS031FFamiliariMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 234
  Width = 500
  object Q480: TOracleDataSet
    SQL.Strings = (
      'Select Codice,Citta,Cap,Provincia,CodCatastale from T480_Comuni '
      ':ORDERBY')
    ReadBuffer = 10000
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A004F0052004400450052004200590001000000
      0000000000000000}
    Left = 25
    Top = 7
    object Q480CODICE: TStringField
      DisplayLabel = 'Cod.ISTAT'
      DisplayWidth = 10
      FieldName = 'CODICE'
      Size = 6
    end
    object Q480CITTA: TStringField
      DisplayLabel = 'Comune'
      DisplayWidth = 60
      FieldName = 'CITTA'
      Size = 60
    end
    object Q480CAP: TStringField
      FieldName = 'CAP'
      Size = 5
    end
    object Q480PROVINCIA: TStringField
      DisplayLabel = 'Prov.'
      DisplayWidth = 5
      FieldName = 'PROVINCIA'
      Size = 2
    end
    object Q480CODCATASTALE: TStringField
      DisplayLabel = 'Cod.Catastale'
      DisplayWidth = 10
      FieldName = 'CODCATASTALE'
      Size = 4
    end
  end
  object selT030: TOracleDataSet
    SQL.Strings = (
      
        'SELECT MATRICOLA, COGNOME || '#39' '#39' || NOME NOMINATIVO, COGNOME, NO' +
        'ME, DATANAS, COMUNENAS, SESSO, CODFISCALE, CAPNAS'
      'FROM T030_ANAGRAFICO '
      'ORDER BY NOMINATIVO')
    ReadBuffer = 2000
    Optimize = False
    Left = 85
    Top = 8
  end
  object dsrQ480: TDataSource
    DataSet = Q480
    Left = 27
    Top = 56
  end
  object selT265: TOracleDataSet
    SQL.Strings = (
      'select CODICE,DESCRIZIONE,TIPOCUMULO,FRUIBILE,RAGGRSTAT'
      'from T265_CAUASSENZE '
      
        'where (nvl(CUMULO_FAMILIARI,'#39'N'#39') <> '#39'N'#39' or nvl(FRUIZIONE_FAMILIA' +
        'RI,'#39'N'#39') <> '#39'N'#39')'
      'order by CODICE')
    Optimize = False
    Left = 143
    Top = 8
  end
  object updSG101: TOracleQuery
    SQL.Strings = (
      'UPDATE SG101_FAMILIARI'
      
        'SET DATA_ULT_FAM_CAR = DECODE(:DATA_ULT_FAM_CAR,TO_DATE('#39'3012189' +
        '9'#39','#39'DDMMYYYY'#39'),NULL,:DATA_ULT_FAM_CAR)'
      'WHERE PROGRESSIVO = :PROGRESSIVO')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000220000003A0044004100540041005F00
      55004C0054005F00460041004D005F004300410052000C000000000000000000
      0000}
    Left = 24
    Top = 117
  end
  object selT040Count: TOracleQuery
    SQL.Strings = (
      'declare'
      '  i integer;'
      'begin'
      '  :COUNT:=0;'
      '  select count(*) into i from SG101_FAMILIARI '
      '  where PROGRESSIVO = :PROGRESSIVO '
      '  and DATANAS = :DATANAS;'
      '  '
      '  if i = 1 then'
      '    select count(*),min(DATA),max(DATA) '
      '    into :COUNT,:MINDATA,:MAXDATA '
      '    from T040_GIUSTIFICATIVI'
      '    where PROGRESSIVO = :PROGRESSIVO'
      '    and DATANAS = :DATANAS;'
      '  end if;'
      'end;')
    Optimize = False
    Variables.Data = {
      0400000005000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A0044004100540041004E00
      410053000C00000000000000000000000C0000003A0043004F0055004E005400
      03000000040000000000000000000000100000003A004D0049004E0044004100
      540041000C0000000000000000000000100000003A004D004100580044004100
      540041000C0000000000000000000000}
    Left = 362
    Top = 116
  end
  object selNumOrd: TOracleQuery
    SQL.Strings = (
      'SELECT NVL(MAX(NUMORD),0), MAX(DATA_ULT_FAM_CAR)'
      'FROM SG101_FAMILIARI'
      'WHERE PROGRESSIVO = :PROGRESSIVO')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Left = 95
    Top = 116
  end
  object selGradoPar: TOracleQuery
    SQL.Strings = (
      'SELECT COUNT(*) CONTA'
      'FROM SG101_FAMILIARI'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      'AND GRADOPAR = '#39'NS'#39
      'and numord <> :NUM')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000080000003A004E0055004D0003000000
      0000000000000000}
    Left = 286
    Top = 116
  end
  object selCodFiscDuplicato: TOracleQuery
    SQL.Strings = (
      'select nvl(max(numord),0)'
      'from sg101_familiari'
      'where progressivo = :PROGRESSIVO'
      'and codfiscale = :CODICE_FISCALE'
      'and numord <> :NUMERO_ORDINE')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000001E0000003A0043004F00440049004300
      45005F00460049005300430041004C0045000500000000000000000000001C00
      00003A004E0055004D00450052004F005F004F005200440049004E0045000300
      00000000000000000000}
    Left = 190
    Top = 116
  end
  object selNomePA: TOracleDataSet
    SQL.Strings = (
      'select distinct :DATO'
      'from SG101_FAMILIARI'
      'where :DATO is not null'
      'order by :DATO')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A004400410054004F0001000000000000000000
      0000}
    Left = 211
    Top = 8
  end
  object selT483: TOracleDataSet
    SQL.Strings = (
      'select * from T483_NAZIONI T483'
      'order by descrizione')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000020000001600000043004F0044005F004E0041005A0049004F004E00
      4500010000000000160000004400450053004300520049005A0049004F004E00
      4500010000000000}
    Left = 280
    Top = 8
    object selT483COD_NAZIONE: TStringField
      DisplayWidth = 5
      FieldName = 'COD_NAZIONE'
      Required = True
      Size = 3
    end
    object selT483DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Required = True
      Size = 40
    end
  end
  object dsrT483: TDataSource
    DataSet = selT483
    Left = 280
    Top = 56
  end
  object selT960: TOracleDataSet
    SQL.Strings = (
      
        'select T960.ID, T960.DATA_CREAZIONE, T960.NOME_UTENTE, T960.UTEN' +
        'TE, T960.PROGRESSIVO, T960.TIPOLOGIA,'
      
        '       T960.UFFICIO, T960.NOME_FILE, T960.EXT_FILE, T960.DIMENSI' +
        'ONE, T960.PERIODO_DAL, T960.PERIODO_AL, T960.DATA_RILASCIO, T960' +
        '.NOTE, '
      
        '       T960.DATA_ACCESSO, T960.UTENTE_ACCESSO, T960.ACCESSO_RESP' +
        'ONSABILE, T960.DATA_LETTURA_PROGRESSIVO, T960.CF_FAMILIARE,'
      '       T962.DESCRIZIONE D_TIPOLOGIA,'
      '       T963.DESCRIZIONE D_UFFICIO'
      'from   T960_DOCUMENTI_INFO T960,'
      '       T962_TIPO_DOCUMENTI T962,'
      '       T963_UFFICIO_DOCUMENTI T963'
      'where  T960.PROGRESSIVO = :PROGRESSIVO'
      'and    T960.CF_FAMILIARE = :CF_FAMILIARE'
      'and    T962.CODICE = T960.TIPOLOGIA'
      'and    T963.CODICE = T960.UFFICIO'
      
        'order by D_TIPOLOGIA, D_UFFICIO, T960.PERIODO_DAL DESC, T960.NOM' +
        'E_FILE')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      04000000020000001A0000003A00430046005F00460041004D0049004C004900
      410052004500050000000000000000000000180000003A00500052004F004700
      5200450053005300490056004F00030000000000000000000000}
    SequenceField.ApplyMoment = amOnNewRecord
    ReadOnly = True
    UpdatingTable = 'T960_DOCUMENTI_INFO'
    OnCalcFields = selT960CalcFields
    Left = 336
    Top = 8
    object selT960D_NOME_FILE: TStringField
      DisplayLabel = 'Nome file'
      DisplayWidth = 25
      FieldKind = fkCalculated
      FieldName = 'D_NOME_FILE'
      Size = 230
      Calculated = True
    end
    object selT960D_DIMENSIONE: TStringField
      DisplayLabel = 'Dimensione'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'D_DIMENSIONE'
      Size = 50
      Calculated = True
    end
    object selT960PERIODO_DAL: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Inizio periodo'
      DisplayWidth = 10
      FieldName = 'PERIODO_DAL'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selT960PERIODO_AL: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Fine periodo'
      DisplayWidth = 10
      FieldName = 'PERIODO_AL'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selT960CF_FAMILIARE: TStringField
      DisplayLabel = 'CF Familiare'
      FieldName = 'CF_FAMILIARE'
      Visible = False
      Size = 16
    end
    object selT960DATA_RILASCIO: TDateTimeField
      DisplayLabel = 'Data rilascio'
      DisplayWidth = 10
      FieldName = 'DATA_RILASCIO'
      DisplayFormat = 'dd/mm/yyy'
    end
    object selT960D_TIPOLOGIA: TStringField
      DisplayLabel = 'Tipologia'
      DisplayWidth = 30
      FieldName = 'D_TIPOLOGIA'
      Size = 80
    end
    object selT960D_UFFICIO: TStringField
      DisplayLabel = 'Ufficio'
      DisplayWidth = 25
      FieldName = 'D_UFFICIO'
      Size = 80
    end
    object selT960D_ACCESSO_RESPONSABILE: TStringField
      Alignment = taCenter
      DisplayLabel = 'Vis. resp.'
      FieldKind = fkCalculated
      FieldName = 'D_ACCESSO_RESPONSABILE'
      Visible = False
      Size = 2
      Calculated = True
    end
    object selT960NOTE: TStringField
      DisplayLabel = 'Note'
      DisplayWidth = 20
      FieldName = 'NOTE'
      Size = 2000
    end
    object selT960DATA_LETTURA_PROGRESSIVO: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Data lettura'
      FieldName = 'DATA_LETTURA_PROGRESSIVO'
      Visible = False
      DisplayFormat = 'dd/mm/yyyy hh.mm.ss'
    end
    object selT960D_DATI_ACCESSO: TStringField
      DisplayLabel = 'Accesso amministratori'
      DisplayWidth = 30
      FieldKind = fkCalculated
      FieldName = 'D_DATI_ACCESSO'
      Visible = False
      Size = 60
      Calculated = True
    end
    object selT960D_PROPRIETARIO: TStringField
      DisplayLabel = 'Utente creazione'
      DisplayWidth = 25
      FieldKind = fkCalculated
      FieldName = 'D_PROPRIETARIO'
      Visible = False
      Size = 120
      Calculated = True
    end
    object selT960DATA_CREAZIONE: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Data creazione'
      DisplayWidth = 18
      FieldName = 'DATA_CREAZIONE'
      Visible = False
      DisplayFormat = 'dd/mm/yyyy hh.nn.ss'
      EditMask = '!00/00/0000 09:00:00;1;_'
    end
    object selT960ID: TFloatField
      FieldName = 'ID'
      Visible = False
    end
    object selT960ACCESSO_RESPONSABILE: TStringField
      Alignment = taCenter
      DisplayLabel = 'Visualizzabile dai responsabili'
      FieldName = 'ACCESSO_RESPONSABILE'
      Visible = False
      Size = 1
    end
    object selT960DATA_ACCESSO: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Data accesso'
      DisplayWidth = 18
      FieldName = 'DATA_ACCESSO'
      Visible = False
      DisplayFormat = 'dd/mm/yyyy hh.nn.ss'
    end
    object selT960UTENTE_ACCESSO: TStringField
      DisplayLabel = 'Utente accesso'
      DisplayWidth = 15
      FieldName = 'UTENTE_ACCESSO'
      Visible = False
      Size = 30
    end
    object selT960UTENTE: TStringField
      DisplayLabel = 'Utente'
      FieldName = 'UTENTE'
      Visible = False
      Size = 30
    end
    object selT960NOME_UTENTE: TStringField
      DisplayLabel = 'Nome utente'
      FieldName = 'NOME_UTENTE'
      Visible = False
      Size = 30
    end
    object selT960PROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selT960TIPOLOGIA: TStringField
      DisplayLabel = 'Tipologia'
      DisplayWidth = 10
      FieldName = 'TIPOLOGIA'
      Visible = False
    end
    object selT960UFFICIO: TStringField
      DisplayLabel = 'Ufficio'
      DisplayWidth = 10
      FieldName = 'UFFICIO'
      Visible = False
    end
    object selT960NOME_FILE: TStringField
      DisplayLabel = 'Nome file'
      FieldName = 'NOME_FILE'
      Visible = False
      Size = 200
    end
    object selT960EXT_FILE: TStringField
      DisplayLabel = 'Estensione file'
      FieldName = 'EXT_FILE'
      Visible = False
    end
    object selT960DIMENSIONE: TFloatField
      DisplayLabel = 'Dimensione'
      FieldName = 'DIMENSIONE'
      Visible = False
    end
  end
  object dsrT960: TDataSource
    DataSet = selT960
    Left = 336
    Top = 56
  end
end
