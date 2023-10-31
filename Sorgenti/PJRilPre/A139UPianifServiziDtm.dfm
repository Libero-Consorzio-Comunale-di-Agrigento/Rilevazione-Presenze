inherited A139FPianifServiziDtm: TA139FPianifServiziDtm
  OldCreateOrder = True
  Height = 484
  Width = 618
  object selT545: TOracleDataSet
    SQL.Strings = (
      'SELECT T545.*'
      '  FROM T545_TIPITURNO T545'
      ' ORDER BY T545.DESCRIZIONE')
    Optimize = False
    Filtered = True
    OnFilterRecord = selT545FilterRecord
    Left = 255
    Top = 152
  end
  object DscT545: TDataSource
    DataSet = selT545
    Left = 255
    Top = 200
  end
  object CDtsT545: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODICE'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 313
    Top = 152
    Data = {
      350000009619E0BD010000001800000001000000000003000000350006434F44
      49434501004900000001000557494454480200020014000000}
  end
  object DscSuppT545: TDataSource
    DataSet = CDtsT545
    OnDataChange = DscSuppT545DataChange
    Left = 313
    Top = 200
  end
  object selT540: TOracleDataSet
    SQL.Strings = (
      'SELECT T540.CODICE, T540.DESCRIZIONE'
      '  FROM T540_SERVIZI T540'
      ':WHERE'
      ' ORDER BY T540.DESCRIZIONE')
    Optimize = False
    Variables.Data = {0300000001000000060000003A5748455245010000000000000000000000}
    Left = 380
    Top = 152
  end
  object DscT540: TDataSource
    DataSet = selT540
    Left = 380
    Top = 200
  end
  object CDtsT540: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'Codice'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 456
    Top = 152
    Data = {
      350000009619E0BD010000001800000001000000000003000000350006436F64
      69636501004900000001000557494454480200020014000000}
  end
  object DscSuppT540: TDataSource
    DataSet = CDtsT540
    OnDataChange = DscSuppT540DataChange
    Left = 456
    Top = 200
  end
  object GetMaxProg: TOracleDataSet
    SQL.Strings = (
      'SELECT NVL(MAX(T500.PATTUGLIA),0) + 1 AS PROG'
      '  FROM T500_PIANIFSERVIZI T500'
      ' WHERE T500.DATA = :DATAIN')
    Optimize = False
    Variables.Data = {0300000001000000070000003A44415441494E0C0000000000000000000000}
    Left = 213
    Top = 8
  end
  object selT501: TOracleDataSet
    SQL.Strings = (
      'SELECT T501.*, T501.ROWID'
      '  FROM T501_PIANIFAPPARATI T501'
      'WHERE  PATTUGLIA = :PATTUGLIA'
      '  AND'#9'DATA = :DATA'
      ' ORDER BY T501.TIPO, T501.CODICE')
    Optimize = False
    Variables.Data = {
      03000000020000000A0000003A5041545455474C494105000000000000000000
      0000050000003A444154410C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      0400000005000000090000005041545455474C49410100000000000400000044
      4154410100000000000500000044414C4C45010000000000040000005449504F
      01000000000006000000434F44494345010000000000}
    BeforePost = selT501BeforePost
    AfterPost = AfterDelete
    BeforeDelete = BeforeDelete
    AfterDelete = AfterDelete
    OnNewRecord = selT501NewRecord
    Left = 29
    Top = 56
    object selT501PATTUGLIA: TIntegerField
      FieldName = 'PATTUGLIA'
      Required = True
    end
    object selT501DATA: TDateTimeField
      FieldName = 'DATA'
      Required = True
    end
    object selT501TIPO: TStringField
      FieldName = 'TIPO'
      Size = 5
    end
    object selT501CODICE: TStringField
      DisplayLabel = 'Apparato'
      DisplayWidth = 10
      FieldName = 'CODICE'
      Size = 10
    end
    object selT501CodTipo: TStringField
      DisplayLabel = 'Tipo'
      DisplayWidth = 5
      FieldKind = fkLookup
      FieldName = 'CodTipo'
      LookupDataSet = selT555
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CODICE'
      KeyFields = 'TIPO'
      Size = 5
      Lookup = True
    end
    object selT501DescTipo: TStringField
      DisplayLabel = 'Tipologia'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'DescTipo'
      LookupDataSet = selT555
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'TIPO'
      Size = 40
      Lookup = True
    end
    object selT501DescApparato: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'DescApparato'
      LookupDataSet = selT550
      LookupKeyFields = 'COD_APPARATO;CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'TIPO;CODICE'
      Size = 80
      Lookup = True
    end
  end
  object selT550: TOracleDataSet
    SQL.Strings = (
      'SELECT T550.CODICE, T550.DESCRIZIONE, T550.COD_APPARATO'
      '  FROM T550_APPARATI T550'
      
        ' WHERE :DATA BETWEEN T550.DECORRENZA AND NVL(T550.DECORRENZA_FIN' +
        'E,TO_DATE('#39'31/12/3999'#39','#39'DD/MM/YYYY'#39'))'
      '   AND T550.STATO = '#39'D'#39
      ' ORDER BY T550.CODICE')
    Optimize = False
    Variables.Data = {0300000001000000050000003A444154410C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      040000000600000006000000434F444943450100000000000B00000044455343
      52495A494F4E450100000000000C000000434F445F415050415241544F010000
      0000000700000046494C54524F310100000000000700000046494C54524F3201
      00000000000E00000046494C54524F5F53455256495A49010000000000}
    Left = 519
    Top = 152
    object selT550CODICE: TStringField
      DisplayLabel = 'Codice'
      DisplayWidth = 10
      FieldName = 'CODICE'
      Size = 10
    end
    object selT550DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 20
      FieldName = 'DESCRIZIONE'
      Size = 80
    end
    object selT550COD_APPARATO: TStringField
      FieldName = 'COD_APPARATO'
      Visible = False
      Size = 5
    end
  end
  object selT555: TOracleDataSet
    SQL.Strings = (
      'SELECT T555.*'
      '  FROM T555_TIPOAPPARATI T555'
      ' ORDER BY T555.CODICE')
    Optimize = False
    Left = 569
    Top = 152
  end
  object selT502: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T502.CAMPO1, T502.CAMPO2, T030.COGNOME, T030.NOME, T030.M' +
        'ATRICOLA, T502.PROGRESSIVO, T500.SERVIZIO, T500.DALLE, T500.ALLE' +
        ', T500.DATA, T500.PATTUGLIA, T502.ROWID'
      
        '  FROM T502_PATTUGLIE T502, T030_ANAGRAFICO T030, T500_PIANIFSER' +
        'VIZI T500 '
      ' WHERE --T502.PATTUGLIA = :PATTUGLIA'
      '       T502.DATA = :DATA'
      '   AND T030.PROGRESSIVO(+) = T502.PROGRESSIVO'
      '   AND T500.PATTUGLIA = T502.PATTUGLIA'
      '   AND T500.DATA = T502.DATA'
      
        '   AND (T502.PROGRESSIVO < 0 OR T502.PROGRESSIVO IN (SELECT T030' +
        '.PROGRESSIVO FROM :C700SelAnagrafe))'
      
        '   AND (CAMPO1 IS NULL OR CAMPO1 IN (SELECT T430:PARAMETRI1 FROM' +
        ' :C700SelAnagrafe))'
      
        '   AND (CAMPO2 IS NULL OR CAMPO2 IN (SELECT T430:PARAMETRI2 FROM' +
        ' :C700SelAnagrafe))'
      'ORDER BY CAMPO1,CAMPO2,COGNOME,NOME,MATRICOLA')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0300000004000000050000003A444154410C00000000000000000000000B0000
      003A504152414D4554524931010000000000000000000000100000003A433730
      3053454C414E4147524146450100000000000000000000000B0000003A504152
      414D4554524932010000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      0400000008000000040000004441544101000000000009000000504154545547
      4C49410100000000000600000043414D504F310100000000000600000043414D
      504F320100000000000B00000050524F475245535349564F0100000000000700
      0000434F474E4F4D45010000000000040000004E4F4D45010000000000090000
      004D41545249434F4C41010000000000}
    Left = 28
    Top = 104
  end
  object selT520: TOracleDataSet
    SQL.Strings = (
      'SELECT T520.*, T545.DESCRIZIONE, T520.ROWID'
      '  FROM T520_TEMPLATE_SERVIZI T520, T545_TIPITURNO T545'
      'WHERE T520.TIPO_TURNO = T545.CODICE '
      '  AND T520.COMANDATO = :COMANDATO'
      'ORDER BY T520.NOME, T520.DATA')
    Optimize = False
    Variables.Data = {
      03000000010000000A0000003A434F4D414E4441544F05000000000000000000
      0000}
    QBEDefinition.QBEFieldDefs = {
      040000000400000004000000444154410100000000000A0000005449504F5F54
      55524E4F010000000000040000004E4F4D4501000000000009000000434F4D41
      4E4441544F010000000000}
    Left = 32
    Top = 152
    object selT520NOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Required = True
    end
    object selT520COMANDATO: TStringField
      DisplayLabel = 'Comandato'
      DisplayWidth = 5
      FieldName = 'COMANDATO'
      Size = 1
    end
    object selT520TIPO_TURNO: TStringField
      DisplayLabel = 'Tipo turno'
      DisplayWidth = 10
      FieldName = 'TIPO_TURNO'
      Required = True
      Visible = False
      Size = 10
    end
    object selT520DESCRIZIONE: TStringField
      DisplayLabel = 'Tipo turno'
      DisplayWidth = 15
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selT520DATA: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
      Required = True
    end
  end
  object DscT520: TDataSource
    DataSet = selT520
    Left = 32
    Top = 200
  end
  object InsT520: TOracleQuery
    SQL.Strings = (
      
        'INSERT INTO T520_TEMPLATE_SERVIZI(DATA, TIPO_TURNO, NOME,COMANDA' +
        'TO)'
      'VALUES (:DATA,:TIPO_TURNO,:NOME,:COMANDATO)')
    Optimize = False
    Variables.Data = {
      0300000004000000050000003A444154410C00000000000000000000000B0000
      003A5449504F5F5455524E4F050000000000000000000000050000003A4E4F4D
      450500000000000000000000000A0000003A434F4D414E4441544F0500000000
      00000000000000}
    Left = 79
    Top = 152
  end
  object CopiaSelT500: TOracleDataSet
    SQL.Strings = (
      'SELECT T500.*, T500.ROWID'
      '  FROM T500_PIANIFSERVIZI T500'
      ' WHERE T500.DATA = :DATA'
      '   AND T500.TIPO_TURNO = :TTURNO'
      '   AND T500.COMANDATO = :COMANDATO')
    Optimize = False
    Variables.Data = {
      0300000003000000050000003A444154410C0000000000000000000000070000
      003A545455524E4F0500000000000000000000000A0000003A434F4D414E4441
      544F050000000000000000000000}
    Filtered = True
    OnFilterRecord = CopiaSelT500FilterRecord
    Left = 89
    Top = 8
  end
  object InsT500: TOracleQuery
    SQL.Strings = (
      
        'INSERT INTO T500_PIANIFSERVIZI(ORDINE, COMANDATO, TIPO_TURNO, PA' +
        'TTUGLIA, SERVIZIO, DATA, DALLE, ALLE, CAUSALE, NOTE, NOTE_SERVIZ' +
        'IO)'
      
        'VALUES (:ORDINE, :COMANDATO, :TIPO_TURNO, :PATTUGLIA, :SERVIZIO,' +
        ' :DATA, :DALLE, :ALLE, :CAUSALE, :NOTE, :NOTE_SERVIZIO)')
    Optimize = False
    Variables.Data = {
      030000000B0000000A0000003A434F4D414E4441544F05000000000000000000
      00000B0000003A5449504F5F5455524E4F050000000000000000000000090000
      003A53455256495A494F050000000000000000000000050000003A444154410C
      0000000000000000000000060000003A44414C4C450500000000000000000000
      00050000003A414C4C45050000000000000000000000080000003A4341555341
      4C45050000000000000000000000050000003A4E4F5445050000000000000000
      0000000E0000003A4E4F54455F53455256495A494F0500000000000000000000
      000A0000003A5041545455474C4941030000000000000000000000070000003A
      4F5244494E45030000000000000000000000}
    Left = 156
    Top = 8
  end
  object GetMinProg: TOracleDataSet
    SQL.Strings = (
      'SELECT NVL(MIN(T502.PROGRESSIVO),0) - 1 AS PROG'
      '  FROM T502_PATTUGLIE T502'
      ' WHERE T502.DATA = :DATAIN'
      '   AND T502.PROGRESSIVO < 0')
    Optimize = False
    Variables.Data = {0300000001000000070000003A44415441494E0C0000000000000000000000}
    Left = 279
    Top = 104
  end
  object selAnag: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T030.COGNOME || '#39' '#39' || T030.NOME NOMINATIVO, T030.MATRICO' +
        'LA, T030.PROGRESSIVO'
      '  FROM :C700SelAnagrafe'
      
        '  AND NOT EXISTS(SELECT '#39'X'#39' FROM T040_GIUSTIFICATIVI WHERE PROGR' +
        'ESSIVO = T030.PROGRESSIVO AND DATA = :DATA AND TIPOGIUST = '#39'I'#39')'
      ':FILTRO'
      ' ORDER BY 1,2')
    Optimize = False
    Variables.Data = {
      0300000003000000100000003A4337303053454C414E41475241464501000000
      0000000000000000070000003A46494C54524F01000000000000000000000005
      0000003A444154410C0000000000000000000000}
    Left = 31
    Top = 256
  end
  object selT502_2: TOracleDataSet
    SQL.Strings = (
      'SELECT T502.*,T502.ROWID'
      '  FROM T502_PATTUGLIE T502'
      ' WHERE T502.DATA = :DATA'
      '   AND T502.PATTUGLIA = :PATTUGLIA'
      
        '   AND (T502.PROGRESSIVO < 0 OR T502.PROGRESSIVO IN (SELECT T030' +
        '.PROGRESSIVO FROM :C700SelAnagrafe))'
      
        '   AND (CAMPO1 IS NULL OR CAMPO1 IN (SELECT T430:PARAMETRI1 FROM' +
        ' :C700SelAnagrafe))'
      
        '   AND (CAMPO2 IS NULL OR CAMPO2 IN (SELECT T430:PARAMETRI2 FROM' +
        ' :C700SelAnagrafe))'
      'ORDER BY T502.PROGRESSIVO')
    Optimize = False
    Variables.Data = {
      0300000005000000050000003A444154410C0000000000000000000000100000
      003A4337303053454C414E4147524146450100000000000000000000000B0000
      003A504152414D45545249310100000000000000000000000B0000003A504152
      414D45545249320100000000000000000000000A0000003A5041545455474C49
      41050000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      0400000005000000040000004441544101000000000009000000504154545547
      4C49410100000000000600000043414D504F310100000000000600000043414D
      504F320100000000000B00000050524F475245535349564F010000000000}
    BeforeInsert = selT502_2BeforeInsert
    BeforePost = selT502_2BeforePost
    AfterPost = AfterDelete
    BeforeDelete = selT502_2BeforeDelete
    AfterDelete = AfterDelete
    AfterScroll = selT502_2AfterScroll
    OnNewRecord = selT502_2NewRecord
    Left = 77
    Top = 104
    object selT502_2DATA: TDateTimeField
      FieldName = 'DATA'
      Required = True
    end
    object selT502_2CAMPO1: TStringField
      FieldName = 'CAMPO1'
    end
    object selT502_2CAMPO2: TStringField
      FieldName = 'CAMPO2'
    end
    object selT502_2DescCampo1: TStringField
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'DescCampo1'
      LookupDataSet = selCampo1
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAMPO1'
      Size = 40
      Lookup = True
    end
    object selT502_2DescCampo2: TStringField
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'DescCampo2'
      LookupDataSet = selCampo2
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAMPO2'
      Size = 40
      Lookup = True
    end
    object selT502_2Matricola: TStringField
      FieldKind = fkLookup
      FieldName = 'Matricola'
      LookupDataSet = selTotAnag
      LookupKeyFields = 'progressivo'
      LookupResultField = 'Matricola'
      KeyFields = 'PROGRESSIVO'
      Size = 8
      Lookup = True
    end
    object selT502_2Nominativo: TStringField
      FieldKind = fkLookup
      FieldName = 'Nominativo'
      LookupDataSet = selTotAnag
      LookupKeyFields = 'progressivo'
      LookupResultField = 'nominativo'
      KeyFields = 'PROGRESSIVO'
      Size = 40
      Lookup = True
    end
    object selT502_2PROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selT502_2PATTUGLIA: TIntegerField
      FieldName = 'PATTUGLIA'
      Visible = False
    end
    object selT502_2COMANDATO: TStringField
      FieldName = 'COMANDATO'
      Visible = False
      Size = 1
    end
  end
  object selCampo1: TOracleDataSet
    Optimize = False
    Left = 159
    Top = 256
  end
  object selCampo2: TOracleDataSet
    Optimize = False
    Left = 225
    Top = 256
  end
  object selTotAnag: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T030.PROGRESSIVO, T030.MATRICOLA, T030.COGNOME || '#39' '#39' || ' +
        'T030.NOME NOMINATIVO :DATI'
      '  FROM :C700SelAnagrafe'
      'ORDER BY 3')
    Optimize = False
    Variables.Data = {
      0300000002000000050000003A44415449010000000000000000000000100000
      003A4337303053454C414E414752414645010000000000000000000000}
    Left = 104
    Top = 256
  end
  object TabellaStampa: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 320
    Top = 368
  end
  object selT030T502: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T030.PROGRESSIVO, T502.PATTUGLIA, T502.DATA, T502.CAMPO1,' +
        ' T502.CAMPO2, T030.COGNOME || '#39' '#39' || T030.NOME AS NOMINATIVO'
      '  FROM T502_PATTUGLIE T502, T030_ANAGRAFICO T030'
      ' WHERE T502.PROGRESSIVO = T030.PROGRESSIVO'
      '   AND T502.PATTUGLIA = :PATTUGLIA'
      '   AND T502.DATA = :DATA'
      'ORDER BY T502.PROGRESSIVO')
    Optimize = False
    Variables.Data = {
      03000000020000000A0000003A5041545455474C494103000000000000000000
      0000050000003A444154410C0000000000000000000000}
    Left = 471
    Top = 104
  end
  object selT500: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T500.*, T501F_ELENCO_APPARATI(T500.DATA,T500.PATTUGLIA) A' +
        'PPARATI, T500.ROWID '
      '  FROM T500_PIANIFSERVIZI T500'
      ' WHERE T500.DATA BETWEEN :DATA1 AND :DATA2'
      '   AND (T500.COMANDATO = '#39'S'#39' OR :COMANDATO = '#39'N'#39')'
      '   AND (T500.TIPO_TURNO = :TIPO_TURNO OR 1=:FILT_TURNO)'
      '   AND (T500.SERVIZIO = :SERVIZIO OR 1=:FILT_SERVIZIO)'
      '   AND EXISTS('
      '        SELECT '#39'X'#39
      '          FROM T502_PATTUGLIE T502'
      '         WHERE T502.DATA = T500.DATA'
      '           AND T502.PATTUGLIA = T500.PATTUGLIA'
      
        '           AND (T502.PROGRESSIVO < 0 OR T502.PROGRESSIVO IN (SEL' +
        'ECT T030.PROGRESSIVO FROM :C700SelAnagrafe))'
      
        '           AND (CAMPO1 IS NULL OR CAMPO1 IN (SELECT T430:PARAMET' +
        'RI1 FROM :C700SelAnagrafe))'
      
        '           AND (CAMPO2 IS NULL OR CAMPO2 IN (SELECT T430:PARAMET' +
        'RI2 FROM :C700SelAnagrafe))'
      ')'
      'ORDER BY '
      '  T500.DATA,'
      '  :ORDINE '
      '  T500.TIPO_TURNO,'
      '  T500.DALLE,'
      '  T500.SERVIZIO')
    ReadBuffer = 200
    Optimize = False
    Variables.Data = {
      030000000B000000100000003A4337303053454C414E41475241464501000000
      00000000000000000B0000003A504152414D4554524931010000000000000000
      0000000B0000003A504152414D45545249320100000000000000000000000B00
      00003A5449504F5F5455524E4F0500000000000000000000000B0000003A4649
      4C545F5455524E4F030000000000000000000000090000003A53455256495A49
      4F0500000000000000000000000E0000003A46494C545F53455256495A494F03
      00000000000000000000000A0000003A434F4D414E4441544F05000000000000
      0000000000060000003A44415441310C0000000000000000000000060000003A
      44415441320C0000000000000000000000070000003A4F5244494E4501000000
      0000000000000000}
    QBEDefinition.QBEFieldDefs = {
      040000000A00000009000000434F4D414E4441544F0100000000000A00000054
      49504F5F5455524E4F0100000000000800000053455256495A494F0100000000
      0004000000444154410100000000000500000044414C4C450100000000000400
      0000414C4C450100000000000700000043415553414C45010000000000040000
      004E4F54450100000000000D0000004E4F54455F53455256495A494F01000000
      0000090000005041545455474C4941010000000000}
    RefreshOptions = [roAfterInsert]
    AfterOpen = selT500AfterOpen
    BeforeInsert = selT500BeforeInsert
    BeforeEdit = selT500BeforeEdit
    BeforePost = BeforePostNoStorico
    AfterPost = AfterPost
    AfterCancel = selT500AfterCancel
    BeforeDelete = BeforeDelete
    AfterDelete = selT500AfterDelete
    AfterScroll = selT500AfterScroll
    OnCalcFields = selT500CalcFields
    OnNewRecord = selT500NewRecord
    Left = 29
    Top = 8
    object selT500COMANDATO: TStringField
      DisplayLabel = 'Comandato'
      FieldName = 'COMANDATO'
      Visible = False
      Size = 1
    end
    object selT500ORDINE: TIntegerField
      DisplayLabel = 'Num.'
      DisplayWidth = 3
      FieldName = 'ORDINE'
    end
    object selT500DescTTurno: TStringField
      DisplayLabel = 'Tipo Turno'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'DescTTurno'
      LookupDataSet = selT545Tutto
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'TIPO_TURNO'
      Required = True
      Size = 40
      Lookup = True
    end
    object selT500TIPO_TURNO: TStringField
      FieldName = 'TIPO_TURNO'
      Required = True
      OnValidate = selT500TIPO_TURNOValidate
      Size = 10
    end
    object selT500DescServizio: TStringField
      DisplayLabel = 'Servizio'
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'DescServizio'
      LookupDataSet = selT540
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'SERVIZIO'
      Size = 40
      Lookup = True
    end
    object selT500SERVIZIO: TStringField
      FieldName = 'SERVIZIO'
      Required = True
      OnValidate = selT500SERVIZIOValidate
      Size = 10
    end
    object selT500DATA: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/9999;1;_'
    end
    object selT500DALLE: TStringField
      DisplayLabel = 'Dalle'
      FieldName = 'DALLE'
      Required = True
      OnValidate = selT500DALLEValidate
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT500ALLE: TStringField
      DisplayLabel = 'Alle'
      FieldName = 'ALLE'
      Required = True
      OnValidate = selT500DALLEValidate
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT500DescCausale: TStringField
      DisplayLabel = 'Causale'
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'DescCausale'
      LookupDataSet = selT275
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAUSALE'
      Size = 40
      Lookup = True
    end
    object selT500NOTE: TStringField
      DisplayLabel = 'Messaggi'
      DisplayWidth = 20
      FieldName = 'NOTE'
      Size = 2000
    end
    object selT500NOTE_SERVIZIO: TStringField
      DisplayLabel = 'Note Servizio'
      DisplayWidth = 20
      FieldName = 'NOTE_SERVIZIO'
      Size = 2000
    end
    object selT500PATTUGLIA: TIntegerField
      DisplayLabel = 'Pattuglia'
      FieldName = 'PATTUGLIA'
      Required = True
      Visible = False
    end
    object selT500C_CAMPO1: TStringField
      DisplayWidth = 15
      FieldKind = fkCalculated
      FieldName = 'C_CAMPO1'
      Size = 2000
      Calculated = True
    end
    object selT500C_CAMPO2: TStringField
      DisplayWidth = 15
      FieldKind = fkCalculated
      FieldName = 'C_CAMPO2'
      Size = 2000
      Calculated = True
    end
    object selT500NOMINATIVO: TStringField
      DisplayLabel = 'Nominativo'
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'NOMINATIVO'
      Size = 2000
      Calculated = True
    end
    object selT500APPARATI: TStringField
      DisplayLabel = 'Dotazione'
      DisplayWidth = 15
      FieldName = 'Apparati'
      ReadOnly = True
      Size = 500
    end
    object selT500CAUSALE: TStringField
      DisplayLabel = 'Causale'
      FieldName = 'CAUSALE'
      Size = 5
    end
    object selT500PROGRESSIVI: TStringField
      FieldKind = fkCalculated
      FieldName = 'PROGRESSIVI'
      Size = 200
      Calculated = True
    end
    object selT500STATO: TStringField
      DisplayLabel = 'Confermato'
      FieldName = 'STATO'
      Visible = False
      Size = 1
    end
    object selT500ORDINE_CMD: TIntegerField
      DisplayLabel = 'Num.'
      FieldName = 'ORDINE_CMD'
    end
  end
  object selT275: TOracleDataSet
    SQL.Strings = (
      'SELECT T275.CODICE,T275.DESCRIZIONE FROM T275_CAUPRESENZE T275'
      'UNION '
      'SELECT NULL, '#39' '#39' FROM DUAL'
      'ORDER BY DESCRIZIONE')
    Optimize = False
    Left = 135
    Top = 367
  end
  object InsT320: TOracleQuery
    SQL.Strings = (
      'DECLARE'
      'BEGIN'
      ''
      'DELETE'
      '  FROM T320_PIANLIBPROFESSIONE T320'
      ' WHERE T320.PROGRESSIVO = :PROGRESSIVO'
      '   AND T320.DATA = :DATA'
      '   AND T320.DALLE = :DALLE;'
      ''
      
        'INSERT INTO T320_PIANLIBPROFESSIONE(PROGRESSIVO, DATA, DALLE, AL' +
        'LE, CAUSALE)'
      ' VALUES (:PROGRESSIVO,:DATA,:DALLE,:ALLE,:CAUSALE);'
      ''
      'END;')
    Optimize = False
    Variables.Data = {
      03000000050000000C0000003A50524F475245535349564F0300000000000000
      00000000050000003A444154410C0000000000000000000000060000003A4441
      4C4C45050000000000000000000000050000003A414C4C450500000000000000
      00000000080000003A43415553414C45050000000000000000000000}
    Left = 241
    Top = 367
  end
  object InsT501: TOracleQuery
    SQL.Strings = (
      'INSERT INTO T501_PIANIFAPPARATI(PATTUGLIA, DATA, TIPO, CODICE)'
      'VALUES(:PATTUGLIA,:DATA,:TIPO,:CODICE)')
    Optimize = False
    Variables.Data = {
      03000000040000000A0000003A5041545455474C494103000000000000000000
      0000050000003A444154410C0000000000000000000000050000003A5449504F
      050000000000000000000000070000003A434F44494345050000000000000000
      000000}
    Left = 143
    Top = 56
  end
  object UpdT501_502: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      #9'UPDATE T501_PIANIFAPPARATI T501'
      '          SET T501.DATA = :DATA, PATTUGLIA = :PATTUGLIA'
      '        WHERE T501.PATTUGLIA = :OLDPATTUGLIA'
      '          AND T501.DATA = :OLDDATA;'
      ''
      #9'UPDATE T502_PATTUGLIE T502'
      '          SET T502.DATA = :DATA, PATTUGLIA = :PATTUGLIA'
      '        WHERE T502.PATTUGLIA = :OLDPATTUGLIA'
      '          AND T502.DATA = :OLDDATA;'
      'END;')
    Optimize = False
    Variables.Data = {
      0300000004000000050000003A444154410C00000000000000000000000D0000
      003A4F4C445041545455474C4941030000000000000000000000080000003A4F
      4C44444154410C00000000000000000000000A0000003A5041545455474C4941
      030000000000000000000000}
    Left = 396
    Top = 55
  end
  object DelT501_T502: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      #9'DELETE'
      #9'  FROM T501_PIANIFAPPARATI T501'
      #9' WHERE T501.PATTUGLIA = :PATTUGLIA'
      '          AND T501.DATA = :DATA;'
      ''
      #9'DELETE'
      #9'  FROM T502_PATTUGLIE T502'
      #9' WHERE T502.PATTUGLIA = :PATTUGLIA'
      #9'   AND T502.DATA = :DATA;'
      'END;')
    Optimize = False
    Variables.Data = {
      03000000020000000A0000003A5041545455474C494103000000000000000000
      0000050000003A444154410C0000000000000000000000}
    Left = 325
    Top = 55
  end
  object selT500_T502: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T500.*,T502.*,T030.MATRICOLA, T030.COGNOME||'#39' '#39'||T030.NOM' +
        'E NOMINATIVO '
      
        '  FROM T500_PIANIFSERVIZI T500, T502_PATTUGLIE T502, T030_ANAGRA' +
        'FICO T030'
      ' WHERE T500.DATA = T502.DATA '
      '   AND T500.PATTUGLIA = T502.PATTUGLIA '
      '   AND T502.PROGRESSIVO > 0'
      '   AND T500.CAUSALE IS NULL '
      '   AND T500.DATA = :DATA '
      '   AND T502.PROGRESSIVO IN (:PROGRESSIVI)'
      '   AND T502.PROGRESSIVO = T030.PROGRESSIVO'
      ' ORDER BY T502.PROGRESSIVO,T500.DALLE')
    Optimize = False
    Variables.Data = {
      0300000002000000050000003A444154410C00000000000000000000000C0000
      003A50524F4752455353495649010000000000000000000000}
    Left = 213
    Top = 104
  end
  object selT021: TOracleDataSet
    SQL.Strings = (
      
        'SELECT OREMINUTI(T021.ENTRATA) ENTRATA, OREMINUTI(T021.USCITA) U' +
        'SCITA'
      '  FROM T021_FASCEORARI T021'
      ' WHERE T021.CODICE = :CODORARIO'
      '   AND T021.DECORRENZA = (SELECT MAX(DECORRENZA)'
      '                            FROM T021_FASCEORARI'
      '                           WHERE DECORRENZA <= :DATADEC'
      '                             AND CODICE = T021.CODICE)'
      ' ORDER BY T021.ENTRATA')
    Optimize = False
    Variables.Data = {
      03000000020000000A0000003A434F444F524152494F05000000000000000000
      0000080000003A444154414445430C0000000000000000000000}
    Left = 80
    Top = 368
  end
  object selT011: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T011.*, DECODE(TO_CHAR(T011.DATA,'#39'D'#39'),1,'#39'S'#39',T011.FESTIVO)' +
        ' PFESTIVO'
      '  FROM T011_CALENDARI T011 '
      ' WHERE T011.CODICE = :CODICE '
      '   AND T011.DATA BETWEEN :DATA1 AND :DATA2'
      ' ORDER BY T011.DATA')
    Optimize = False
    Variables.Data = {
      0300000003000000070000003A434F4449434505000000000000000000000006
      0000003A44415441310C0000000000000000000000060000003A44415441320C
      0000000000000000000000}
    Left = 32
    Top = 368
  end
  object selCountT502: TOracleQuery
    SQL.Strings = (
      'SELECT COUNT(*) '
      '  FROM T502_PATTUGLIE '
      ' WHERE PATTUGLIA = :PATTUGLIA '
      '   AND DATA = :DATA '
      '   AND PROGRESSIVO > 0')
    Optimize = False
    Variables.Data = {
      03000000020000000A0000003A5041545455474C494103000000000000000000
      0000050000003A444154410C0000000000000000000000}
    Left = 397
    Top = 104
  end
  object dsrCampo1: TDataSource
    DataSet = selCampo1
    Left = 160
    Top = 304
  end
  object dsrCampo2: TDataSource
    DataSet = selCampo2
    Left = 224
    Top = 304
  end
  object selT040: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T040.DATA, T030.COGNOME || '#39' '#39' || T030.NOME NOMINATIVO, T' +
        '030.MATRICOLA, T265.DESCRIZIONE CAUSALE'
      
        '  FROM T040_GIUSTIFICATIVI T040, T265_CAUASSENZE T265, :C700SelA' +
        'nagrafe'
      '  AND  T040.PROGRESSIVO = T030.PROGRESSIVO'
      '  AND  T040.DATA BETWEEN :DATA1 AND :DATA2'
      '  AND  T040.TIPOGIUST = '#39'I'#39' '
      '  AND  T040.CAUSALE = T265.CODICE'
      'ORDER BY 1,2')
    Optimize = False
    Variables.Data = {
      0300000003000000100000003A4337303053454C414E41475241464501000000
      0000000000000000060000003A44415441310C00000000000000000000000600
      00003A44415441320C0000000000000000000000}
    Left = 292
    Top = 256
    object selT040DATA: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
    end
    object selT040NOMINATIVO: TStringField
      DisplayLabel = 'Nominativo'
      DisplayWidth = 30
      FieldName = 'NOMINATIVO'
      Size = 40
    end
    object selT040MATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      DisplayWidth = 9
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selT040CAUSALE: TStringField
      DisplayLabel = 'Causale'
      DisplayWidth = 20
      FieldName = 'CAUSALE'
      Size = 40
    end
  end
  object dsrT040: TDataSource
    DataSet = selT040
    Left = 292
    Top = 304
  end
  object selAssenti: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T030.COGNOME || '#39' '#39' || T030.NOME NOMINATIVO, T030.MATRICO' +
        'LA '
      'FROM   T030_ANAGRAFICO T030 '
      'WHERE  PROGRESSIVO IN '
      '('
      'SELECT T030.PROGRESSIVO FROM :C700SelAnagrafe'
      'MINUS'
      
        'SELECT T502.PROGRESSIVO FROM T502_PATTUGLIE T502 WHERE DATA = :D' +
        'ATA'
      'MINUS'
      
        'SELECT T040.PROGRESSIVO FROM T040_GIUSTIFICATIVI T040 WHERE DATA' +
        ' = :DATA AND TIPOGIUST = '#39'I'#39
      ')'
      'ORDER BY 1,2')
    Optimize = False
    Variables.Data = {
      0300000002000000100000003A4337303053454C414E41475241464501000000
      0000000000000000050000003A444154410C0000000000000000000000}
    Left = 364
    Top = 256
    object StringField1: TStringField
      DisplayLabel = 'Nominativo'
      DisplayWidth = 30
      FieldName = 'NOMINATIVO'
      Size = 40
    end
    object StringField2: TStringField
      DisplayLabel = 'Matricola'
      DisplayWidth = 9
      FieldName = 'MATRICOLA'
      Size = 8
    end
  end
  object dsrAssenti: TDataSource
    DataSet = selAssenti
    Left = 364
    Top = 304
  end
  object selT502Inters: TOracleDataSet
    SQL.Strings = (
      
        'select T500.DATA,T500.DALLE,T500.ALLE,T500.TIPO_TURNO,T500.SERVI' +
        'ZIO from '
      '  T500_PIANIFSERVIZI T500, T502_PATTUGLIE T502 '
      'where'
      '  T500.DATA = T502.DATA and'
      '  T500.PATTUGLIA = T502.PATTUGLIA and'
      '  T502.PROGRESSIVO = :PROGRESSIVO and'
      '  (:RIGAID is null or T502.ROWID <> :RIGAID) and'
      '  T500.DATA = :DATA and'
      '  oreminuti(T500.DALLE) < oreminuti(T500.ALLE) and'
      '  oreminuti(T500.DALLE) < :ALLE and'
      '  oreminuti(T500.ALLE) > :DALLE'
      'union all'
      
        'select T500.DATA,T500.DALLE,T500.ALLE,T500.TIPO_TURNO,T500.SERVI' +
        'ZIO from '
      '  T500_PIANIFSERVIZI T500, T502_PATTUGLIE T502 '
      'where'
      '  T500.DATA = T502.DATA and'
      '  T500.PATTUGLIA = T502.PATTUGLIA and'
      '  T502.PROGRESSIVO = :PROGRESSIVO and'
      '  (:RIGAID is null or T502.ROWID <> :RIGAID) and'
      '  T500.DATA = :DATA and'
      '  oreminuti(T500.DALLE) >= oreminuti(T500.ALLE) and'
      '  oreminuti(T500.DALLE) < :ALLE'
      'union all'
      
        'select T500.DATA,T500.DALLE,T500.ALLE,T500.TIPO_TURNO,T500.SERVI' +
        'ZIO from '
      '  T500_PIANIFSERVIZI T500, T502_PATTUGLIE T502 '
      'where'
      '  T500.DATA = T502.DATA and'
      '  T500.PATTUGLIA = T502.PATTUGLIA and'
      '  T502.PROGRESSIVO = :PROGRESSIVO and'
      '  T500.DATA = :DATA - 1 and'
      '  oreminuti(T500.DALLE) > oreminuti(T500.ALLE) and'
      '  oreminuti(T500.ALLE) > :DALLE'
      'union all'
      
        'select T500.DATA,T500.DALLE,T500.ALLE,T500.TIPO_TURNO,T500.SERVI' +
        'ZIO from '
      '  T500_PIANIFSERVIZI T500, T502_PATTUGLIE T502 '
      'where'
      '  :ALLE > 1440 and'
      '  T500.DATA = T502.DATA and'
      '  T500.PATTUGLIA = T502.PATTUGLIA and'
      '  T502.PROGRESSIVO = :PROGRESSIVO and'
      '  T500.DATA = :DATA + 1 and'
      '  oreminuti(T500.DALLE) < (:ALLE - 1440)'
      ''
      '')
    Optimize = False
    Variables.Data = {
      0300000005000000050000003A444154410C00000000000000000000000C0000
      003A50524F475245535349564F030000000000000000000000070000003A5249
      47414944050000000000000000000000050000003A414C4C4503000000000000
      0000000000060000003A44414C4C45030000000000000000000000}
    Left = 140
    Top = 104
  end
  object selT501Inters: TOracleDataSet
    SQL.Strings = (
      
        'select T500.DATA,T500.DALLE,T500.ALLE,T500.TIPO_TURNO,T500.SERVI' +
        'ZIO from '
      '  T500_PIANIFSERVIZI T500, T501_PIANIFAPPARATI T501 '
      'where'
      '  T500.DATA = T501.DATA and'
      '  T500.PATTUGLIA = T501.PATTUGLIA and'
      '  T501.TIPO = :TIPO and'
      '  T501.CODICE = :CODICE and'
      '  (:RIGAID is null or T501.ROWID <> :RIGAID) and'
      '  T500.DATA = :DATA and'
      '  oreminuti(T500.DALLE) < oreminuti(T500.ALLE) and'
      '  oreminuti(T500.DALLE) < :ALLE and'
      '  oreminuti(T500.ALLE) > :DALLE'
      'union all'
      
        'select T500.DATA,T500.DALLE,T500.ALLE,T500.TIPO_TURNO,T500.SERVI' +
        'ZIO from '
      '  T500_PIANIFSERVIZI T500, T501_PIANIFAPPARATI T501 '
      'where'
      '  T500.DATA = T501.DATA and'
      '  T500.PATTUGLIA = T501.PATTUGLIA and'
      '  T501.TIPO = :TIPO and'
      '  T501.CODICE = :CODICE and'
      '  (:RIGAID is null or T501.ROWID <> :RIGAID) and'
      '  T500.DATA = :DATA and'
      '  oreminuti(T500.DALLE) >= oreminuti(T500.ALLE) and'
      '  oreminuti(T500.DALLE) < :ALLE'
      'union all'
      
        'select T500.DATA,T500.DALLE,T500.ALLE,T500.TIPO_TURNO,T500.SERVI' +
        'ZIO from '
      '  T500_PIANIFSERVIZI T500, T501_PIANIFAPPARATI T501 '
      'where'
      '  T500.DATA = T501.DATA and'
      '  T500.PATTUGLIA = T501.PATTUGLIA and'
      '  T501.TIPO = :TIPO and'
      '  T501.CODICE = :CODICE and'
      '  T500.DATA = :DATA - 1 and'
      '  oreminuti(T500.DALLE) > oreminuti(T500.ALLE) and'
      '  oreminuti(T500.ALLE) > :DALLE'
      'union all'
      
        'select T500.DATA,T500.DALLE,T500.ALLE,T500.TIPO_TURNO,T500.SERVI' +
        'ZIO from '
      '  T500_PIANIFSERVIZI T500, T501_PIANIFAPPARATI T501 '
      'where'
      '  :ALLE > 1440 and'
      '  T500.DATA = T501.DATA and'
      '  T500.PATTUGLIA = T501.PATTUGLIA and'
      '  T501.TIPO = :TIPO and'
      '  T501.CODICE = :CODICE and'
      '  T500.DATA = :DATA + 1 and'
      '  oreminuti(T500.DALLE) < (:ALLE - 1440)'
      ''
      '')
    Optimize = False
    Variables.Data = {
      0300000006000000050000003A444154410C0000000000000000000000070000
      003A524947414944050000000000000000000000050000003A414C4C45030000
      000000000000000000060000003A44414C4C4503000000000000000000000005
      0000003A5449504F050000000000000000000000070000003A434F4449434505
      0000000000000000000000}
    Left = 84
    Top = 56
  end
  object selT545Tutto: TOracleDataSet
    SQL.Strings = (
      'SELECT T545.CODICE,T545.DESCRIZIONE'
      '  FROM T545_TIPITURNO T545'
      ' ORDER BY T545.DESCRIZIONE')
    Optimize = False
    Left = 135
    Top = 152
  end
  object selT500Aperti: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T500.*, T540.DESCRIZIONE D_SERVIZIO, T545.DESCRIZIONE D_T' +
        'IPOTURNO'
      
        '  FROM T500_PIANIFSERVIZI T500, T502_PATTUGLIE T502, T545_TIPITU' +
        'RNO T545, T540_SERVIZI T540'
      ' WHERE T500.DATA <= TRUNC(SYSDATE) - :OFFSET '
      '   AND STATO = '#39'A'#39
      '   AND ROWNUM <= 1'
      '   AND T500.TIPO_TURNO = T545.CODICE '
      '   AND T500.SERVIZIO = T540.CODICE'
      '   AND (T500.COMANDATO = '#39'S'#39' OR :COMANDATO = '#39'N'#39')'
      '   AND T502.DATA = T500.DATA'
      '   AND T502.PATTUGLIA = T500.PATTUGLIA'
      
        '   AND ((PROGRESSIVO > 0 AND T502.PROGRESSIVO IN (SELECT T030.PR' +
        'OGRESSIVO FROM :C700SelAnagrafe)) OR '
      
        '        (T502.PROGRESSIVO < 0 AND CAMPO1 IN (SELECT T430:PARAMET' +
        'RI1 FROM :C700SelAnagrafe) '
      
        '                              AND CAMPO2 IN (SELECT T430:PARAMET' +
        'RI2 FROM :C700SelAnagrafe))'
      '       )')
    Optimize = False
    Variables.Data = {
      03000000050000000A0000003A434F4D414E4441544F05000000000000000000
      00000B0000003A504152414D4554524931010000000000000000000000100000
      003A4337303053454C414E4147524146450100000000000000000000000B0000
      003A504152414D4554524932010000000000000000000000070000003A4F4646
      534554030000000000000000000000}
    Left = 285
    Top = 8
  end
  object cdsT500: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 32
    Top = 424
  end
  object cdsT501: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 104
    Top = 424
  end
  object cdsT502: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 168
    Top = 424
  end
  object selT530: TOracleDataSet
    SQL.Strings = (
      'select * from T530_CONFIGSERVIZI')
    ReadBuffer = 1
    Optimize = False
    Left = 200
    Top = 152
  end
  object TabellaStampaAss: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 320
    Top = 416
  end
  object selT040Stampa: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T040.DATA, T040.DAORE, T040.AORE, T030.COGNOME, T030.NOME' +
        ', T030.MATRICOLA, T040.CAUSALE, T265.DESCRIZIONE, T030.PROGRESSI' +
        'VO'
      
        '  FROM T040_GIUSTIFICATIVI T040, T030_ANAGRAFICO T030, T265_CAUA' +
        'SSENZE T265'
      ' WHERE T040.PROGRESSIVO IN (SELECT T502.PROGRESSIVO'
      '                              FROM T502_PATTUGLIE T502'
      '                             WHERE T502.PATTUGLIA = :PATTUGLIA'
      '                               AND T502.DATA = :DATA'
      '                               AND T502.PROGRESSIVO >= 0)'
      '   AND T040.PROGRESSIVO = T030.PROGRESSIVO'
      '   AND T040.CAUSALE = T265.CODICE'
      '   AND T040.DATA = :DATA'
      '   AND T040.TIPOGIUST = '#39'D'#39
      ' ORDER BY T040.PROGRESSIVO, T040.CAUSALE, T040.DAORE, T040.AORE')
    Optimize = False
    Variables.Data = {
      03000000020000000A0000003A5041545455474C494103000000000000000000
      0000050000003A444154410C0000000000000000000000}
    Left = 456
    Top = 256
  end
  object selI070: TOracleDataSet
    SQL.Strings = (
      'SELECT I070.FILTRO_ANAGRAFE'
      '  FROM MONDOEDP.I070_UTENTI I070'
      ' WHERE I070.AZIENDA = :AZIENDA'
      '   AND I070.UTENTE = :UTENTE')
    Optimize = False
    Variables.Data = {
      0300000002000000080000003A415A49454E4441050000000000000000000000
      070000003A5554454E5445050000000000000000000000}
    Left = 213
    Top = 56
  end
  object selT503: TOracleDataSet
    SQL.Strings = (
      'SELECT T503.*, T503.ROWID'
      '  FROM T503_NOTE_SERVIZI T503'
      ' WHERE T503.DATA = :DATA'
      '   AND T503.FILTRO_ANAGRAFE = :FANAGRAFE')
    Optimize = False
    Variables.Data = {
      0300000002000000050000003A444154410C00000000000000000000000A0000
      003A46414E414752414645050000000000000000000000}
    Left = 396
    Top = 8
  end
  object selT502QuadroRiass: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T500.DATA, T500.SERVIZIO, T500.DALLE, T500.ALLE, T540.DES' +
        'CRIZIONE, T540.COLORE, T540.COLOREFONT'
      
        '  FROM T500_PIANIFSERVIZI T500, T502_PATTUGLIE T502, T540_SERVIZ' +
        'I T540'
      ' WHERE T500.DATA = T502.DATA '
      '   AND T500.PATTUGLIA = T502.PATTUGLIA'
      '   AND T502.PROGRESSIVO = :PROGRESSIVO'
      '   AND T500.SERVIZIO = T540.CODICE'
      '   AND T500.DATA BETWEEN :DATADA AND :DATAA'
      'ORDER BY T500.DATA,T500.DALLE')
    ReadBuffer = 31
    Optimize = False
    Variables.Data = {
      03000000030000000C0000003A50524F475245535349564F0300000000000000
      00000000070000003A4441544144410C0000000000000000000000060000003A
      44415441410C0000000000000000000000}
    Left = 488
    Top = 48
  end
  object selT040GetAss: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T040.*, T265.DESCRIZIONE, DECODE(T265.VALIDAZIONE,'#39'S'#39',DEC' +
        'ODE(T040.SCHEDA,'#39'V'#39','#39'N'#39','#39'S'#39'),'#39'N'#39') VALIDAZIONE'
      '  FROM T040_GIUSTIFICATIVI T040, T265_CAUASSENZE T265'
      ' WHERE T040.DATA BETWEEN :DATADA AND :DATAA'
      '   AND T040.PROGRESSIVO = :PROGRESSIVO'
      '   AND T040.CAUSALE = T265.CODICE'
      'ORDER BY T040.DATA,T040.CAUSALE')
    ReadBuffer = 31
    Optimize = False
    Variables.Data = {
      0300000003000000070000003A4441544144410C000000000000000000000006
      0000003A44415441410C00000000000000000000000C0000003A50524F475245
      535349564F050000000000000000000000}
    Left = 104
    Top = 200
  end
  object InsT080: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      ''
      '--ANNULLO I TURNI CHE NON SONO RIFERITI AL GIORNO PRIMA'
      'UPDATE T080_PIANIFORARI SET '
      '  TURNO1 = NULL,'
      '  TURNO1EU = NULL'
      'WHERE '
      '  PROGRESSIVO = :PROGRESSIVO AND'
      '  DATA = :DATA AND'
      '  NVL(TURNO1EU,'#39'E'#39') <> '#39'U'#39';'
      ''
      'UPDATE T080_PIANIFORARI SET '
      '  TURNO2 = NULL,'
      '  TURNO2EU = NULL'
      'WHERE '
      '  PROGRESSIVO = :PROGRESSIVO AND'
      '  DATA = :DATA AND'
      '  NVL(TURNO2EU,'#39'E'#39') <> '#39'U'#39';'
      ''
      '--ANNULLO I TURNI CHE SONO RIFERITI AL GIORNO DOPO'
      'UPDATE T080_PIANIFORARI SET '
      '  TURNO1 = NULL,'
      '  TURNO1EU = NULL'
      'WHERE '
      '  PROGRESSIVO = :PROGRESSIVO AND'
      '  DATA = :DATA + 1 AND'
      '  NVL(TURNO1EU,'#39'E'#39') = '#39'U'#39';'
      ''
      'UPDATE T080_PIANIFORARI SET '
      '  TURNO2 = NULL,'
      '  TURNO2EU = NULL'
      'WHERE '
      '  PROGRESSIVO = :PROGRESSIVO AND'
      '  DATA = :DATA + 1 AND'
      '  NVL(TURNO2EU,'#39'E'#39') = '#39'U'#39';'
      ''
      '--CANCELLO LE RIGHE DI PIANIFICAZIONE VUOTE DI OGGI E DOMANI'
      'DELETE'
      '  FROM T080_PIANIFORARI T080'
      ' WHERE '
      '  T080.PROGRESSIVO = :PROGRESSIVO AND '
      '  T080.DATA = :DATA AND'
      '  TURNO1 = NULL AND TURNO2 IS NULL AND INDPRESENZA IS NULL;'
      ''
      'DELETE'
      '  FROM T080_PIANIFORARI T080'
      ' WHERE '
      '  T080.PROGRESSIVO = :PROGRESSIVO AND'
      '  T080.DATA = :DATA + 1 AND'
      '  TURNO1 = NULL AND TURNO2 IS NULL AND INDPRESENZA IS NULL;'
      ''
      '--INSERISCO LE RIGHE VUOTE PER OGGI'
      'BEGIN'
      '  INSERT INTO T080_PIANIFORARI(PROGRESSIVO, DATA, ORARIO)'
      '  VALUES(:PROGRESSIVO, :DATA, :ORARIO);'
      'EXCEPTION'
      '  WHEN DUP_VAL_ON_INDEX THEN NULL;'
      'END;'
      ''
      '--INSERISCO LE RIGHE VUOTE PER DOMANI, SE TURNO NOTTURNO'
      'IF (NVL(:TURNO1EU,'#39'E'#39') = '#39'U'#39') OR (NVL(:TURNO2EU,'#39'E'#39') = '#39'U'#39') THEN'
      '  BEGIN'
      '    INSERT INTO T080_PIANIFORARI(PROGRESSIVO, DATA, ORARIO)'
      '    VALUES(:PROGRESSIVO, :DATA + 1, :ORARIO);'
      '  EXCEPTION'
      '    WHEN DUP_VAL_ON_INDEX THEN NULL;'
      '  END;'
      'END IF;'
      ''
      '--PIANIFICO IL PRIMO TURNO'
      'IF :TURNO1 IS NOT NULL THEN'
      '  UPDATE T080_PIANIFORARI SET '
      '    TURNO1 = :TURNO1,'
      '    TURNO1EU = DECODE(:TURNO1EU,NULL,NULL,'#39'E'#39')'
      '  WHERE '
      '    PROGRESSIVO = :PROGRESSIVO AND'
      '    DATA = :DATA AND'
      '    TURNO1 IS NULL;'
      ''
      '  IF SQL%ROWCOUNT = 0 THEN'
      '    UPDATE T080_PIANIFORARI SET '
      '      TURNO2 = :TURNO1,'
      '      TURNO2EU = DECODE(:TURNO1EU,NULL,NULL,'#39'E'#39')'
      '    WHERE '
      '      PROGRESSIVO = :PROGRESSIVO AND'
      '      DATA = :DATA AND'
      '      TURNO2 IS NULL;'
      '  END IF;'
      'END IF;'
      ''
      '--PIANIFICO IL SECONDO TURNO'
      'IF :TURNO2 IS NOT NULL THEN'
      '  UPDATE T080_PIANIFORARI SET '
      '   TURNO2 = :TURNO2,'
      '    TURNO2EU = DECODE(:TURNO2EU,NULL,NULL,'#39'E'#39')'
      '  WHERE '
      '    PROGRESSIVO = :PROGRESSIVO AND'
      '    DATA = :DATA AND'
      '    TURNO2 IS NULL;'
      'END IF;'
      ''
      '--PIANIFICO LO SMONTO NOTTE DEL PRIMO TURNO SU DOMANI'
      'IF NVL(:TURNO1EU,'#39'E'#39') = '#39'U'#39' THEN'
      '  UPDATE T080_PIANIFORARI SET '
      '    TURNO1 = :TURNO1,'
      '    TURNO1EU = :TURNO1EU'
      '  WHERE '
      '    PROGRESSIVO = :PROGRESSIVO AND'
      '    DATA = :DATA  + 1 AND'
      '    TURNO1 IS NULL;'
      '  IF SQL%ROWCOUNT = 0 THEN'
      '    UPDATE T080_PIANIFORARI SET '
      '      TURNO2 = :TURNO1,'
      '      TURNO2EU = :TURNO1EU'
      '    WHERE '
      '      PROGRESSIVO = :PROGRESSIVO AND'
      '      DATA = :DATA  + 1 AND'
      '      TURNO2 IS NULL;'
      '  END IF;'
      'END IF;'
      ''
      '--PIANIFICO LO SMONTO NOTTE DEL SECONDO TURNO SU DOMANI'
      'IF NVL(:TURNO2EU,'#39'E'#39') = '#39'U'#39' THEN'
      '  UPDATE T080_PIANIFORARI SET '
      '    TURNO1 = :TURNO1,'
      '    TURNO1EU = :TURNO2EU'
      '  WHERE '
      '    PROGRESSIVO = :PROGRESSIVO AND'
      '    DATA = :DATA  + 1 AND'
      '    TURNO1 IS NULL;'
      '  IF SQL%ROWCOUNT = 0 THEN'
      '    UPDATE T080_PIANIFORARI SET '
      '      TURNO2 = :TURNO1,'
      '      TURNO2EU = :TURNO2EU'
      '    WHERE '
      '      PROGRESSIVO = :PROGRESSIVO AND'
      '      DATA = :DATA  + 1 AND'
      '      TURNO2 IS NULL;'
      '  END IF;'
      'END IF;'
      ''
      'END;')
    Optimize = False
    Variables.Data = {
      03000000070000000C0000003A50524F475245535349564F0300000000000000
      00000000050000003A444154410C0000000000000000000000070000003A4F52
      4152494F050000000000000000000000070000003A5455524E4F310500000000
      00000000000000070000003A5455524E4F320500000000000000000000000900
      00003A5455524E4F314555050000000000000000000000090000003A5455524E
      4F324555050000000000000000000000}
    Left = 192
    Top = 368
  end
  object selT430T502: TOracleDataSet
    SQL.Strings = (
      'SELECT T502.*, T502.ROWID'
      '  FROM T502_PATTUGLIE T502, T430_STORICO T430'
      ' WHERE NVL(T502.CAMPO1,T430.:CAMPO1) = T430.:CAMPO1'
      '   AND NVL(T502.CAMPO2,T430.:CAMPO2) = T430.:CAMPO2'
      '   AND :DATA BETWEEN T430.DATADECORRENZA AND T430.DATAFINE'
      '   AND T502.DATA = :DATA'
      '   AND T502.PATTUGLIA = :PATTUGLIA'
      '   AND T430.PROGRESSIVO = :PROGRESSIVO'
      '   AND T502.PROGRESSIVO < 0')
    Optimize = False
    Variables.Data = {
      0300000005000000070000003A43414D504F3101000000000000000000000007
      0000003A43414D504F320100000000000000000000000C0000003A50524F4752
      45535349564F030000000000000000000000050000003A444154410C00000000
      000000000000000A0000003A5041545455474C49410500000000000000000000
      00}
    Left = 488
    Top = 8
  end
  object updT502: TOracleQuery
    SQL.Strings = (
      'UPDATE T502_PATTUGLIE T502'
      '   SET T502.PROGRESSIVO = :PROGRESSIVONEW,'
      '       T502.DATA = :DATA'
      ' WHERE T502.PROGRESSIVO = :PROGRESSIVOOLD'
      '   AND T502.PATTUGLIA = :PATTUGLIA'
      '   AND T502.DATA = :DATA')
    Optimize = False
    Variables.Data = {
      0300000004000000050000003A444154410C00000000000000000000000A0000
      003A5041545455474C49410300000000000000000000000F0000003A50524F47
      5245535349564F4E45570300000000000000000000000F0000003A50524F4752
      45535349564F4F4C44030000000000000000000000}
    Left = 560
    Top = 8
  end
  object InsT502: TOracleQuery
    SQL.Strings = (
      
        'INSERT INTO T502_PATTUGLIE (DATA, PATTUGLIA, CAMPO1, CAMPO2, PRO' +
        'GRESSIVO)'
      'VALUES (:DATA, :PATTUGLIA, :CAMPO1, :CAMPO2, :PROGRESSIVO)')
    Optimize = False
    Variables.Data = {
      0300000005000000050000003A444154410C00000000000000000000000A0000
      003A5041545455474C4941030000000000000000000000070000003A43414D50
      4F31050000000000000000000000070000003A43414D504F3205000000000000
      00000000000C0000003A50524F475245535349564F0300000000000000000000
      00}
    Left = 335
    Top = 104
  end
  object UpdT040: TOracleQuery
    SQL.Strings = (
      'UPDATE T040_GIUSTIFICATIVI T040'
      '   SET T040.SCHEDA = '#39'V'#39
      ' WHERE T040.PROGRESSIVO = :PROG'
      '   AND T040.DATA = :DATA'
      '   AND T040.CAUSALE  = :CAUS')
    Optimize = False
    Variables.Data = {
      0300000003000000050000003A50524F47030000000000000000000000050000
      003A444154410C0000000000000000000000050000003A434155530500000000
      00000000000000}
    Left = 240
    Top = 424
  end
end
