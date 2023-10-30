inherited A154FGestioneDocumentaleMW: TA154FGestioneDocumentaleMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 122
  Width = 543
  object selT962: TOracleDataSet
    SQL.Strings = (
      'select T962.*, T962.ROWID'
      'from   T962_TIPO_DOCUMENTI T962'
      'order by 1')
    ReadBuffer = 100
    Optimize = False
    BeforePost = selT962BeforePost
    AfterPost = selT962AfterPost
    BeforeDelete = selT962BeforeDelete
    AfterDelete = selT962AfterDelete
    AfterScroll = selT962AfterScroll
    OnDeleteError = selT962DeleteError
    Left = 24
    Top = 8
    object selT962CODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      ReadOnly = True
      Size = 10
    end
    object selT962DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 45
      FieldName = 'DESCRIZIONE'
      Size = 80
    end
    object selT962CODICE_DEFAULT: TStringField
      DisplayLabel = 'Default'
      FieldName = 'CODICE_DEFAULT'
      Size = 1
    end
    object selT962EMAIL: TStringField
      DisplayLabel = 'E-Mail'
      DisplayWidth = 40
      FieldName = 'EMAIL'
      Size = 2000
    end
    object selT962ORDINE: TFloatField
      DisplayLabel = 'Ordine'
      FieldName = 'ORDINE'
    end
    object selT962VERSIONABILE: TStringField
      DisplayLabel = 'Versionabile'
      FieldName = 'VERSIONABILE'
      Size = 1
    end
    object selT962UM: TStringField
      DisplayLabel = 'Unit'#224' di misura'
      FieldName = 'UM'
      Size = 1
    end
    object selT962QUANTITA: TIntegerField
      DisplayLabel = 'Quantit'#224
      FieldName = 'QUANTITA'
    end
    object selT962SCRIPT_TICKET_PDF: TStringField
      DisplayLabel = 'Script ticket pdf'
      DisplayWidth = 40
      FieldName = 'SCRIPT_TICKET_PDF'
      Size = 2000
    end
  end
  object selT963: TOracleDataSet
    SQL.Strings = (
      
        'select T963.CODICE, T963.DESCRIZIONE, T963.CODICE_DEFAULT, T963.' +
        'EMAIL, T963.ROWID'
      'from   T963_UFFICIO_DOCUMENTI T963'
      'order by decode(T963.CODICE,'#39'*'#39','#39'*'#39',T963.DESCRIZIONE)')
    ReadBuffer = 100
    Optimize = False
    BeforePost = selT963BeforePost
    AfterPost = selT963AfterPost
    BeforeDelete = selT963BeforeDelete
    AfterDelete = selT963AfterDelete
    AfterScroll = selT963AfterScroll
    OnDeleteError = selT963DeleteError
    Left = 80
    Top = 8
    object selT963CODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      ReadOnly = True
      Size = 10
    end
    object selT963DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 45
      FieldName = 'DESCRIZIONE'
      Size = 80
    end
    object selT963CODICE_DEFAULT: TStringField
      DisplayLabel = 'Default'
      FieldName = 'CODICE_DEFAULT'
      Size = 1
    end
    object selT963EMAIL: TStringField
      DisplayLabel = 'E-Mail'
      DisplayWidth = 40
      FieldName = 'EMAIL'
      Size = 2000
    end
  end
  object dsrT962: TDataSource
    DataSet = selT962
    OnStateChange = dsrT962StateChange
    Left = 24
    Top = 64
  end
  object dsrT963: TDataSource
    DataSet = selT963
    OnStateChange = dsrT963StateChange
    Left = 80
    Top = 64
  end
  object selT962Lookup: TOracleDataSet
    SQL.Strings = (
      'select T962.CODICE, T962.DESCRIZIONE, T962.EMAIL'
      'from   T962_TIPO_DOCUMENTI T962'
      'where T962.CODICE not in ('#39'MEDP_SEPA'#39', '#39'MEDP_INPS'#39', '#39'ITER'#39')'
      'order by 2')
    ReadBuffer = 100
    Optimize = False
    ReadOnly = True
    BeforeDelete = selT962BeforeDelete
    Left = 152
    Top = 8
    object StringField1: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Size = 10
    end
    object StringField2: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 45
      FieldName = 'DESCRIZIONE'
      Size = 80
    end
    object selT962LookupEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 2000
    end
  end
  object selT963Lookup: TOracleDataSet
    SQL.Strings = (
      'select T963.CODICE, T963.DESCRIZIONE, T963.EMAIL'
      'from   T963_UFFICIO_DOCUMENTI T963'
      'order by 2')
    ReadBuffer = 100
    Optimize = False
    ReadOnly = True
    BeforeDelete = selT963BeforeDelete
    Left = 239
    Top = 8
    object StringField3: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Size = 10
    end
    object StringField4: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 45
      FieldName = 'DESCRIZIONE'
      Size = 80
    end
    object selT963LookupEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 2000
    end
  end
  object dsrT962Lookup: TDataSource
    DataSet = selT962Lookup
    Left = 152
    Top = 64
  end
  object dsrT963Lookup: TDataSource
    DataSet = selT963Lookup
    Left = 240
    Top = 64
  end
  object selSG101: TOracleDataSet
    SQL.Strings = (
      
        'select distinct SG101.CODFISCALE, SG101.COGNOME||'#39' '#39'||SG101.NOME' +
        ' DENOMINAZIONE '
      'from   SG101_FAMILIARI SG101'
      'where  SG101.PROGRESSIVO = :PROGRESSIVO'
      'and    SG101.CODFISCALE is not NULL'
      'order by SG101.CODFISCALE')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    ReadOnly = True
    Left = 319
    Top = 8
  end
  object dsrSG101: TDataSource
    DataSet = selSG101
    Left = 320
    Top = 64
  end
  object selT962NoVersione: TOracleDataSet
    SQL.Strings = (
      
        'select T962.CODICE, T962.DESCRIZIONE, T962.CODICE_DEFAULT, T962.' +
        'EMAIL, T962.ROWID'
      'from   T962_TIPO_DOCUMENTI T962 '
      'where T962.VERSIONABILE <> '#39'S'#39' '
      'and T962.CODICE not in ('#39'MEDP_SEPA'#39', '#39'MEDP_INPS'#39', '#39'ITER'#39') '
      'order by T962.CODICE')
    ReadBuffer = 100
    Optimize = False
    Left = 400
    Top = 8
    object StringField5: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      ReadOnly = True
      Size = 10
    end
    object StringField6: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 45
      FieldName = 'DESCRIZIONE'
      Size = 80
    end
    object StringField7: TStringField
      DisplayLabel = 'Default'
      FieldName = 'CODICE_DEFAULT'
      Size = 1
    end
    object StringField8: TStringField
      DisplayLabel = 'E-Mail'
      DisplayWidth = 40
      FieldName = 'EMAIL'
      Size = 2000
    end
  end
  object selT960MaxVersione: TOracleQuery
    SQL.Strings = (
      
        'SELECT NVL(MAX(VERSIONE), 0)+1 AS MAX_VERSIONE FROM T960_DOCUMEN' +
        'TI_INFO '
      'WHERE PROGRESSIVO = :PROGRESSIVO '
      'AND NOME_FILE = :NOME_FILE '
      'AND EXT_FILE = :EXT_FILE '
      'AND TIPOLOGIA = :TIPOLOGIA')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F00040000000000000000000000140000003A004E004F004D0045005F00
      460049004C004500050000000000000000000000120000003A00450058005400
      5F00460049004C004500050000000000000000000000140000003A0054004900
      50004F004C004F00470049004100050000000000000000000000}
    Left = 400
    Top = 64
  end
end
