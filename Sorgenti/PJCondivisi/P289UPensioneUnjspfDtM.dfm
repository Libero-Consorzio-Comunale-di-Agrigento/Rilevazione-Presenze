inherited P289FPensioneUnjspfDtM: TP289FPensioneUnjspfDtM
  OldCreateOrder = True
  Height = 381
  Width = 1148
  object selU120: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid from U120_UNJSPF_STAFF_MEMBER t'
      'where ID_UNJSPF = :ID'
      '  :prog'
      'order by lastname, firstname, employee_number')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A00500052004F00470001000000000000000000
      0000060000003A0049004400030000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      0500000010000000160000004C00410053005400550050004400410054004500
      440001000000000012000000490044005F0055004E004A005300500046000100
      000000001A000000500045004E00530049004F004E004E0055004D0042004500
      52000100000000001E00000045004E0054005200590054004F00460055004E00
      4400440041005400450001000000000012000000460049005200530054004E00
      41004D004500010000000000140000004D004900440044004C0045004E004100
      4D004500010000000000100000004C004100530054004E0041004D0045000100
      0000000012000000420049005200540048004400410054004500010000000000
      160000004E004100540049004F004E0041004C00490054005900010000000000
      1C00000043004F0055004E005400520059004F00460042004900520054004800
      0100000000000C000000470045004E004400450052000100000000001A000000
      4D00410052004900540041004C00530054004100540055005300010000000000
      1600000043004F004D004C0041004E0047005500410047004500010000000000
      2600000046004F0052004D0045005200500045004E00530049004F004E004E00
      55004D004200450052000100000000001E00000045004D0050004C004F005900
      450045005F004E0055004D004200450052000100000000001600000050005200
      4F0047005200450053005300490056004F00010000000000}
    OnNewRecord = selU120NewRecord
    Left = 80
    Top = 16
    object selU120ID_UNJSPF: TFloatField
      DisplayLabel = 'Identificativo UNJSPF'
      FieldName = 'ID_UNJSPF'
      ReadOnly = True
      Required = True
      Visible = False
    end
    object selU120PROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selU120EMPLOYEE_NUMBER: TStringField
      DisplayLabel = 'Employee number'
      DisplayWidth = 10
      FieldName = 'EMPLOYEE_NUMBER'
      ReadOnly = True
      Required = True
      Size = 30
    end
    object selU120LASTNAME: TStringField
      DisplayLabel = 'Last name'
      DisplayWidth = 30
      FieldName = 'LASTNAME'
      Required = True
      Size = 150
    end
    object selU120FIRSTNAME: TStringField
      DisplayLabel = 'First name'
      DisplayWidth = 30
      FieldName = 'FIRSTNAME'
      Size = 150
    end
    object selU120PENSIONNUMBER: TStringField
      DisplayLabel = 'Pension number'
      DisplayWidth = 10
      FieldName = 'PENSIONNUMBER'
      Size = 150
    end
    object selU120ENTRYTOFUNDDATE: TDateTimeField
      DisplayLabel = 'Entry to fund date'
      DisplayWidth = 10
      FieldName = 'ENTRYTOFUNDDATE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU120MIDDLENAME: TStringField
      DisplayLabel = 'Middle name'
      DisplayWidth = 10
      FieldName = 'MIDDLENAME'
      Size = 60
    end
    object selU120BIRTHDATE: TDateTimeField
      DisplayLabel = 'Birth date'
      DisplayWidth = 10
      FieldName = 'BIRTHDATE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU120NATIONALITY: TStringField
      DisplayLabel = 'Nationality'
      DisplayWidth = 10
      FieldName = 'NATIONALITY'
      Size = 150
    end
    object selU120COUNTRYOFBIRTH: TStringField
      DisplayLabel = 'Country of birth'
      FieldName = 'COUNTRYOFBIRTH'
      Size = 3
    end
    object selU120GENDER: TStringField
      DisplayLabel = 'Gender'
      DisplayWidth = 10
      FieldName = 'GENDER'
      Size = 80
    end
    object selU120MARITALSTATUS: TStringField
      DisplayLabel = 'Marital status'
      DisplayWidth = 20
      FieldName = 'MARITALSTATUS'
      Size = 150
    end
    object selU120COMLANGUAGE: TStringField
      DisplayLabel = 'Com language'
      DisplayWidth = 10
      FieldName = 'COMLANGUAGE'
      Size = 240
    end
    object selU120FORMERPENSIONNUMBER: TFloatField
      DisplayLabel = 'Former pension number'
      FieldName = 'FORMERPENSIONNUMBER'
    end
    object selU120LASTUPDATED: TDateTimeField
      DisplayLabel = 'Last updated'
      DisplayWidth = 10
      FieldName = 'LASTUPDATED'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
  end
  object selU100: TOracleDataSet
    SQL.Strings = (
      'select t.*,t.rowid from U100_UNJSPF_TESTATE t'
      'where tipo_flusso = :TipoFlusso'
      'order by data_fine_periodo')
    Optimize = False
    Variables.Data = {
      0400000001000000160000003A005400490050004F0046004C00550053005300
      4F00050000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000700000012000000490044005F0055004E004A005300500046000100
      00000000160000005400490050004F005F0046004C005500530053004F000100
      000000002200000044004100540041005F00460049004E0045005F0050004500
      520049004F0044004F000100000000002200000044004100540041005F004500
      530050004F005200540041005A0049004F004E0045000100000000000C000000
      430048004900550053004F000100000000001A00000044004100540041005F00
      4300480049005500530055005200410001000000000022000000440041005400
      41005F0045004C00410042004F00520041005A0049004F004E00450001000000
      0000}
    AfterScroll = selU100AfterScroll
    Left = 24
    Top = 16
    object selU100TIPO_FLUSSO: TStringField
      DisplayLabel = 'Tipo flusso'
      FieldName = 'TIPO_FLUSSO'
      Required = True
      Size = 5
    end
    object selU100DATA_FINE_PERIODO: TDateTimeField
      DisplayLabel = 'Data fine periodo'
      DisplayWidth = 10
      FieldName = 'DATA_FINE_PERIODO'
      Required = True
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU100ID_UNJSPF: TFloatField
      DisplayLabel = 'Identificativo UNJSPF'
      FieldName = 'ID_UNJSPF'
      Required = True
    end
    object selU100DATA_ESPORTAZIONE: TDateTimeField
      DisplayLabel = 'Data esportazione'
      DisplayWidth = 10
      FieldName = 'DATA_ESPORTAZIONE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU100CHIUSO: TStringField
      DisplayLabel = 'Chiuso'
      FieldName = 'CHIUSO'
      Size = 1
    end
    object selU100DATA_CHIUSURA: TDateTimeField
      DisplayLabel = 'Data chiusura'
      DisplayWidth = 10
      FieldName = 'DATA_CHIUSURA'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU100DATA_ELABORAZIONE: TDateTimeField
      DisplayLabel = 'Data elaborazione'
      DisplayWidth = 10
      FieldName = 'DATA_ELABORAZIONE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
  end
  object dsrU100: TDataSource
    DataSet = selU100
    Left = 24
    Top = 69
  end
  object selU125: TOracleDataSet
    SQL.Strings = (
      'select T.*, T.rowid, U120.LASTNAME, U120.FIRSTNAME '
      '  from U125_UNJSPF_LANG_ALLWNCS T, U120_UNJSPF_STAFF_MEMBER U120'
      ' where T.ID_UNJSPF = :ID'
      '   and T.ID_UNJSPF = U120.ID_UNJSPF'
      '   and T.PROGRESSIVO = U120.PROGRESSIVO'
      '       :prog'
      
        'order by U120.LASTNAME, U120.FIRSTNAME, T.EMPLOYEE_NUMBER, T.STA' +
        'RT_DATE')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A00500052004F00470001000000000000000000
      0000060000003A0049004400030000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      0500000008000000160000004C00410053005400550050004400410054004500
      440001000000000012000000490044005F0055004E004A005300500046000100
      0000000014000000530054004100520054005F00440041005400450001000000
      00000A00000043004F0055004E0054000100000000001E00000045004D005000
      4C004F005900450045005F004E0055004D004200450052000100000000001000
      00004C004100530054004E0041004D0045000100000000001200000046004900
      5200530054004E0041004D00450001000000000016000000500052004F004700
      5200450053005300490056004F00010000000000}
    OnNewRecord = selU125NewRecord
    Left = 128
    Top = 16
    object selU125ID_UNJSPF: TFloatField
      DisplayLabel = 'Identificativo UNJSPF'
      FieldName = 'ID_UNJSPF'
      ReadOnly = True
      Visible = False
    end
    object selU125PROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selU125EMPLOYEE_NUMBER: TStringField
      DisplayLabel = 'Employee number'
      DisplayWidth = 10
      FieldName = 'EMPLOYEE_NUMBER'
      ReadOnly = True
      Required = True
      Size = 30
    end
    object selU125LASTNAME: TStringField
      DisplayLabel = 'Last name'
      DisplayWidth = 30
      FieldName = 'LASTNAME'
      ReadOnly = True
      Size = 150
    end
    object selU125FIRSTNAME: TStringField
      DisplayLabel = 'First name'
      DisplayWidth = 30
      FieldName = 'FIRSTNAME'
      ReadOnly = True
      Size = 150
    end
    object selU125START_DATE: TDateTimeField
      DisplayLabel = 'Start date'
      DisplayWidth = 10
      FieldName = 'START_DATE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU125COUNT: TFloatField
      DisplayLabel = 'Count'
      FieldName = 'COUNT'
    end
    object selU125LASTUPDATED: TDateTimeField
      DisplayLabel = 'Last updated'
      DisplayWidth = 10
      FieldName = 'LASTUPDATED'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
  end
  object dsrU120: TDataSource
    DataSet = selU120
    Left = 80
    Top = 69
  end
  object dsrU125: TDataSource
    DataSet = selU125
    Left = 128
    Top = 69
  end
  object dsrU130: TDataSource
    DataSet = selU130
    Left = 176
    Top = 69
  end
  object selU130: TOracleDataSet
    SQL.Strings = (
      'select T.*, T.rowid, U120.LASTNAME, U120.FIRSTNAME '
      '  from U130_UNJSPF_PARTTIMES T, U120_UNJSPF_STAFF_MEMBER U120'
      ' where T.ID_UNJSPF = :ID'
      '   and T.ID_UNJSPF = U120.ID_UNJSPF'
      '   and T.PROGRESSIVO = U120.PROGRESSIVO'
      '   :prog'
      
        'order by U120.LASTNAME, U120.FIRSTNAME, T.EMPLOYEE_NUMBER, T.EFF' +
        'ECTIVEDATE')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A00500052004F00470001000000000000000000
      0000060000003A0049004400030000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      0500000008000000160000004C00410053005400550050004400410054004500
      440001000000000012000000490044005F0055004E004A005300500046000100
      000000001A000000450046004600450043005400490056004500440041005400
      4500010000000000240000005000410052005400540049004D00450050004500
      5200430045004E0054004100470045000100000000001E00000045004D005000
      4C004F005900450045005F004E0055004D004200450052000100000000001000
      00004C004100530054004E0041004D0045000100000000001200000046004900
      5200530054004E0041004D00450001000000000016000000500052004F004700
      5200450053005300490056004F00010000000000}
    OnNewRecord = selU130NewRecord
    Left = 176
    Top = 16
    object selU130ID_UNJSPF: TFloatField
      DisplayLabel = 'Identificativo UNJSPF'
      FieldName = 'ID_UNJSPF'
      ReadOnly = True
      Required = True
      Visible = False
    end
    object selU130PROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selU130EMPLOYEE_NUMBER: TStringField
      DisplayLabel = 'Employee number'
      DisplayWidth = 10
      FieldName = 'EMPLOYEE_NUMBER'
      ReadOnly = True
      Required = True
      Size = 30
    end
    object selU130LASTNAME: TStringField
      DisplayLabel = 'Last name'
      DisplayWidth = 30
      FieldName = 'LASTNAME'
      ReadOnly = True
      Size = 150
    end
    object selU130FIRSTNAME: TStringField
      DisplayLabel = 'First name'
      DisplayWidth = 30
      FieldName = 'FIRSTNAME'
      ReadOnly = True
      Size = 150
    end
    object selU130EFFECTIVEDATE: TDateTimeField
      DisplayLabel = 'Effective date'
      DisplayWidth = 10
      FieldName = 'EFFECTIVEDATE'
      Required = True
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU130PARTTIMEPERCENTAGE: TFloatField
      DisplayLabel = 'Part time percentage'
      FieldName = 'PARTTIMEPERCENTAGE'
    end
    object selU130LASTUPDATED: TDateTimeField
      DisplayLabel = 'Last updated'
      DisplayWidth = 10
      FieldName = 'LASTUPDATED'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
  end
  object dsrU135: TDataSource
    DataSet = selU135
    Left = 224
    Top = 69
  end
  object selU135: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid, U120.LASTNAME, U120.FIRSTNAME'
      '  from U135_UNJSPF_DUTY_STTNS t, U120_UNJSPF_STAFF_MEMBER U120'
      ' where T.ID_UNJSPF = :ID'
      '   and T.ID_UNJSPF = U120.ID_UNJSPF'
      '   and T.PROGRESSIVO = U120.PROGRESSIVO'
      '       :prog'
      
        'order by U120.LASTNAME, U120.FIRSTNAME, T.EMPLOYEE_NUMBER, T.EFF' +
        'ECTIVEDATE')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A00500052004F00470001000000000000000000
      0000060000003A0049004400030000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000A000000160000004C00410053005400550050004400410054004500
      440001000000000012000000490044005F0055004E004A005300500046000100
      000000001A000000450046004600450043005400490056004500440041005400
      45000100000000001E0000004400550054005900530054004100540049004F00
      4E0043004F004400450001000000000024000000440055005400590053005400
      4100540049004F004E0043004F0055004E005400520059000100000000001E00
      000045004D0050004C004F005900450045005F004E0055004D00420045005200
      0100000000001A0000004C004F0043004100540049004F004E005F0043004F00
      44004500010000000000100000004C004100530054004E0041004D0045000100
      0000000012000000460049005200530054004E0041004D004500010000000000
      16000000500052004F0047005200450053005300490056004F00010000000000}
    OnNewRecord = selU135NewRecord
    Left = 224
    Top = 16
    object selU135ID_UNJSPF: TFloatField
      DisplayLabel = 'Identificativo UNJSPF'
      FieldName = 'ID_UNJSPF'
      ReadOnly = True
      Required = True
      Visible = False
    end
    object selU135PROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selU135EMPLOYEE_NUMBER: TStringField
      DisplayLabel = 'Employee number'
      DisplayWidth = 10
      FieldName = 'EMPLOYEE_NUMBER'
      ReadOnly = True
      Required = True
      Size = 30
    end
    object selU135LASTNAME: TStringField
      DisplayLabel = 'Last name'
      DisplayWidth = 30
      FieldName = 'LASTNAME'
      ReadOnly = True
      Size = 150
    end
    object selU135FIRSTNAME: TStringField
      DisplayLabel = 'First name'
      DisplayWidth = 30
      FieldName = 'FIRSTNAME'
      ReadOnly = True
      Size = 150
    end
    object selU135LOCATION_CODE: TStringField
      DisplayLabel = 'Location code'
      DisplayWidth = 30
      FieldName = 'LOCATION_CODE'
      Size = 60
    end
    object selU135EFFECTIVEDATE: TDateTimeField
      DisplayLabel = 'Effective date'
      DisplayWidth = 10
      FieldName = 'EFFECTIVEDATE'
      Required = True
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU135DUTYSTATIONCODE: TStringField
      DisplayLabel = 'Duty station code'
      DisplayWidth = 10
      FieldName = 'DUTYSTATIONCODE'
      Size = 150
    end
    object selU135DUTYSTATIONCOUNTRY: TStringField
      DisplayLabel = 'Duty station country'
      DisplayWidth = 10
      FieldName = 'DUTYSTATIONCOUNTRY'
      Size = 240
    end
    object selU135LASTUPDATED: TDateTimeField
      DisplayLabel = 'Last updated'
      DisplayWidth = 10
      FieldName = 'LASTUPDATED'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
  end
  object dsrU140: TDataSource
    DataSet = selU140
    Left = 272
    Top = 69
  end
  object selU140: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid, U120.LASTNAME, U120.FIRSTNAME '
      '  from U140_UNJSPF_SALARIES t, U120_UNJSPF_STAFF_MEMBER U120'
      ' where T.ID_UNJSPF = :ID'
      '   and T.ID_UNJSPF = U120.ID_UNJSPF'
      '   and T.PROGRESSIVO = U120.PROGRESSIVO'
      '  :prog'
      
        'order by U120.LASTNAME, U120.FIRSTNAME, T.EMPLOYEE_NUMBER, T.EFF' +
        'ECTIVEDATE')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A00500052004F00470001000000000000000000
      0000060000003A0049004400030000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000A000000160000004C00410053005400550050004400410054004500
      440001000000000012000000490044005F0055004E004A005300500046000100
      000000001A000000450046004600450043005400490056004500440041005400
      450001000000000010000000430041005400450047004F005200590001000000
      00000A0000004700520041004400450001000000000008000000530054004500
      50000100000000001E00000045004D0050004C004F005900450045005F004E00
      55004D00420045005200010000000000100000004C004100530054004E004100
      4D00450001000000000012000000460049005200530054004E0041004D004500
      01000000000016000000500052004F0047005200450053005300490056004F00
      010000000000}
    OnNewRecord = selU140NewRecord
    Left = 272
    Top = 16
    object selU140ID_UNJSPF: TFloatField
      DisplayLabel = 'Identificativo UNJSPF'
      FieldName = 'ID_UNJSPF'
      ReadOnly = True
      Required = True
      Visible = False
    end
    object selU140PROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selU140EMPLOYEE_NUMBER: TStringField
      DisplayLabel = 'Employee number'
      DisplayWidth = 10
      FieldName = 'EMPLOYEE_NUMBER'
      ReadOnly = True
      Required = True
      Size = 30
    end
    object selU140LASTNAME: TStringField
      DisplayLabel = 'Last name'
      DisplayWidth = 30
      FieldName = 'LASTNAME'
      ReadOnly = True
      Size = 150
    end
    object selU140FIRSTNAME: TStringField
      DisplayLabel = 'First name'
      DisplayWidth = 30
      FieldName = 'FIRSTNAME'
      ReadOnly = True
      Size = 150
    end
    object selU140EFFECTIVEDATE: TDateTimeField
      DisplayLabel = 'Effective date'
      DisplayWidth = 10
      FieldName = 'EFFECTIVEDATE'
      Required = True
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU140CATEGORY: TStringField
      DisplayLabel = 'Category'
      DisplayWidth = 10
      FieldName = 'CATEGORY'
    end
    object selU140GRADE: TStringField
      DisplayLabel = 'Grade'
      DisplayWidth = 10
      FieldName = 'GRADE'
    end
    object selU140STEP: TStringField
      DisplayLabel = 'Step'
      DisplayWidth = 10
      FieldName = 'STEP'
      Size = 150
    end
    object selU140LASTUPDATED: TDateTimeField
      DisplayLabel = 'Last updated'
      DisplayWidth = 10
      FieldName = 'LASTUPDATED'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
  end
  object dsrU145: TDataSource
    DataSet = selU145
    Left = 320
    Top = 68
  end
  object selU145: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid, U120.LASTNAME, U120.FIRSTNAME '
      '  from U145_UNJSPF_CONTRACTS t, U120_UNJSPF_STAFF_MEMBER U120'
      ' where T.ID_UNJSPF = :ID'
      '   and T.ID_UNJSPF = U120.ID_UNJSPF'
      '   and T.PROGRESSIVO = U120.PROGRESSIVO'
      '  :prog'
      
        'order by U120.LASTNAME, U120.FIRSTNAME, T.EMPLOYEE_NUMBER, T.STA' +
        'RTDATE')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A00500052004F00470001000000000000000000
      0000060000003A0049004400030000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      0500000009000000160000004C00410053005400550050004400410054004500
      440001000000000012000000490044005F0055004E004A005300500046000100
      0000000012000000530054004100520054004400410054004500010000000000
      0E00000045004E00440044004100540045000100000000002400000052004500
      4100500050004F0049004E00540049004E00440049004300410054004F005200
      0100000000001E00000045004D0050004C004F005900450045005F004E005500
      4D00420045005200010000000000100000004C004100530054004E0041004D00
      450001000000000012000000460049005200530054004E0041004D0045000100
      0000000016000000500052004F0047005200450053005300490056004F000100
      00000000}
    OnNewRecord = selU145NewRecord
    Left = 320
    Top = 15
    object selU145ID_UNJSPF: TFloatField
      DisplayLabel = 'Identificativo UNJSPF'
      FieldName = 'ID_UNJSPF'
      ReadOnly = True
      Required = True
      Visible = False
    end
    object selU145PROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selU145EMPLOYEE_NUMBER: TStringField
      DisplayLabel = 'Employee number'
      DisplayWidth = 10
      FieldName = 'EMPLOYEE_NUMBER'
      ReadOnly = True
      Required = True
      Size = 30
    end
    object selU145LASTNAME: TStringField
      DisplayLabel = 'Last name'
      DisplayWidth = 30
      FieldName = 'LASTNAME'
      ReadOnly = True
      Size = 150
    end
    object selU145FIRSTNAME: TStringField
      DisplayLabel = 'First name'
      DisplayWidth = 30
      FieldName = 'FIRSTNAME'
      ReadOnly = True
      Size = 150
    end
    object selU145STARTDATE: TDateTimeField
      DisplayLabel = 'Start date'
      DisplayWidth = 10
      FieldName = 'STARTDATE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU145ENDDATE: TDateTimeField
      DisplayLabel = 'End date'
      DisplayWidth = 10
      FieldName = 'ENDDATE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU145REAPPOINTINDICATOR: TStringField
      DisplayLabel = 'Reappoint indicator'
      FieldName = 'REAPPOINTINDICATOR'
      Size = 7
    end
    object selU145LASTUPDATED: TDateTimeField
      DisplayLabel = 'Last updated'
      DisplayWidth = 10
      FieldName = 'LASTUPDATED'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
  end
  object dsrU150: TDataSource
    DataSet = selU150
    Left = 368
    Top = 68
  end
  object selU150: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid, U120.LASTNAME, U120.FIRSTNAME '
      '  from U150_UNJSPF_SEPARATIONS t, U120_UNJSPF_STAFF_MEMBER U120'
      ' where T.ID_UNJSPF = :ID'
      '   and T.ID_UNJSPF = U120.ID_UNJSPF'
      '   and T.PROGRESSIVO = U120.PROGRESSIVO'
      '   :prog'
      
        'order by U120.LASTNAME, U120.FIRSTNAME, T.EMPLOYEE_NUMBER, T.EFF' +
        'ECTIVEDATE')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A00500052004F00470001000000000000000000
      0000060000003A0049004400030000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      0500000009000000160000004C00410053005400550050004400410054004500
      440001000000000012000000490044005F0055004E004A005300500046000100
      000000001A000000450046004600450043005400490056004500440041005400
      45000100000000000C00000052004500410053004F004E000100000000001200
      00004400450041005400480044004100540045000100000000001E0000004500
      4D0050004C004F005900450045005F004E0055004D0042004500520001000000
      0000100000004C004100530054004E0041004D00450001000000000012000000
      460049005200530054004E0041004D0045000100000000001600000050005200
      4F0047005200450053005300490056004F00010000000000}
    OnNewRecord = selU150NewRecord
    Left = 368
    Top = 15
    object selU150ID_UNJSPF: TFloatField
      DisplayLabel = 'Identificativo UNJSPF'
      FieldName = 'ID_UNJSPF'
      ReadOnly = True
      Required = True
      Visible = False
    end
    object selU150PROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selU150EMPLOYEE_NUMBER: TStringField
      DisplayLabel = 'Employee number'
      DisplayWidth = 10
      FieldName = 'EMPLOYEE_NUMBER'
      ReadOnly = True
      Required = True
      Size = 30
    end
    object selU150LASTNAME: TStringField
      DisplayLabel = 'Last name'
      DisplayWidth = 30
      FieldName = 'LASTNAME'
      ReadOnly = True
      Size = 150
    end
    object selU150FIRSTNAME: TStringField
      DisplayLabel = 'First name'
      DisplayWidth = 30
      FieldName = 'FIRSTNAME'
      ReadOnly = True
      Size = 150
    end
    object selU150EFFECTIVEDATE: TDateTimeField
      DisplayLabel = 'Effective date'
      DisplayWidth = 10
      FieldName = 'EFFECTIVEDATE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU150REASON: TStringField
      DisplayLabel = 'Reason'
      DisplayWidth = 30
      FieldName = 'REASON'
      Size = 150
    end
    object selU150DEATHDATE: TDateTimeField
      DisplayLabel = 'Death date'
      DisplayWidth = 10
      FieldName = 'DEATHDATE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU150LASTUPDATED: TDateTimeField
      DisplayLabel = 'Last updated'
      DisplayWidth = 10
      FieldName = 'LASTUPDATED'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
  end
  object dsrU155: TDataSource
    DataSet = selU155
    Left = 413
    Top = 68
  end
  object selU155: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid, U120.LASTNAME, U120.FIRSTNAME '
      '  from U155_UNJSPF_DEPENDANTS t, U120_UNJSPF_STAFF_MEMBER U120'
      ' where T.ID_UNJSPF = :ID'
      '   and T.ID_UNJSPF = U120.ID_UNJSPF'
      '   and T.PROGRESSIVO = U120.PROGRESSIVO'
      '  :prog'
      
        'order by U120.LASTNAME, U120.FIRSTNAME, T.EMPLOYEE_NUMBER, T.ORG' +
        'DEPENDENTID')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A00500052004F00470001000000000000000000
      0000060000003A0049004400030000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      0500000011000000160000004C00410053005400550050004400410054004500
      440001000000000012000000490044005F0055004E004A005300500046000100
      0000000012000000440045004100540048004400410054004500010000000000
      1E00000045004D0050004C004F005900450045005F004E0055004D0042004500
      52000100000000001C0000004F005200470044004500500045004E0044004500
      4E005400490044000100000000001A000000530050004F005500530045005300
      540041004600460049004400010000000000100000004C004100530054004E00
      41004D00450001000000000012000000460049005200530054004E0041004D00
      4500010000000000120000004200490052005400480044004100540045000100
      000000000C000000470045004E00440045005200010000000000180000005200
      45004C004100540049004F004E00530048004900500001000000000016000000
      4E004100540049004F004E0041004C0049005400590001000000000018000000
      4D00410052005200490041004700450044004100540045000100000000001600
      00004400490056004F0052004300450044004100540045000100000000001400
      00004C004100530054004E0041004D0045005F00310001000000000016000000
      460049005200530054004E0041004D0045005F00310001000000000016000000
      500052004F0047005200450053005300490056004F00010000000000}
    OnNewRecord = selU155NewRecord
    Left = 413
    Top = 15
    object selU155ID_UNJSPF: TFloatField
      DisplayLabel = 'Identificativo UNJSPF'
      FieldName = 'ID_UNJSPF'
      ReadOnly = True
      Required = True
      Visible = False
    end
    object selU155PROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selU155EMPLOYEE_NUMBER: TStringField
      DisplayLabel = 'Employee number'
      DisplayWidth = 10
      FieldName = 'EMPLOYEE_NUMBER'
      ReadOnly = True
      Required = True
      Size = 30
    end
    object selU155LASTNAME_1: TStringField
      DisplayLabel = 'Last name'
      DisplayWidth = 30
      FieldName = 'LASTNAME_1'
      ReadOnly = True
      Size = 150
    end
    object selU155FIRSTNAME_1: TStringField
      DisplayLabel = 'First name'
      DisplayWidth = 30
      FieldName = 'FIRSTNAME_1'
      ReadOnly = True
      Size = 150
    end
    object selU155ORGDEPENDENTID: TFloatField
      DisplayLabel = 'Org. dependent ID'
      FieldName = 'ORGDEPENDENTID'
      Required = True
    end
    object selU155SPOUSESTAFFID: TStringField
      DisplayLabel = 'Spouse st. affid.'
      DisplayWidth = 10
      FieldName = 'SPOUSESTAFFID'
      Size = 30
    end
    object selU155LASTNAME: TStringField
      DisplayLabel = 'Last name'
      DisplayWidth = 30
      FieldName = 'LASTNAME'
      Required = True
      Size = 150
    end
    object selU155FIRSTNAME: TStringField
      DisplayLabel = 'First name'
      DisplayWidth = 30
      FieldName = 'FIRSTNAME'
      Size = 150
    end
    object selU155BIRTHDATE: TDateTimeField
      DisplayLabel = 'Birth date'
      DisplayWidth = 10
      FieldName = 'BIRTHDATE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU155GENDER: TStringField
      DisplayLabel = 'Gender'
      DisplayWidth = 10
      FieldName = 'GENDER'
      Size = 80
    end
    object selU155RELATIONSHIP: TStringField
      DisplayLabel = 'Relationship'
      DisplayWidth = 10
      FieldName = 'RELATIONSHIP'
      Size = 150
    end
    object selU155NATIONALITY: TStringField
      DisplayLabel = 'Nationality'
      DisplayWidth = 10
      FieldName = 'NATIONALITY'
      Size = 150
    end
    object selU155MARRIAGEDATE: TDateTimeField
      DisplayLabel = 'Marriage date'
      DisplayWidth = 10
      FieldName = 'MARRIAGEDATE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU155DIVORCEDATE: TDateTimeField
      DisplayLabel = 'Divorce date'
      DisplayWidth = 10
      FieldName = 'DIVORCEDATE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU155DEATHDATE: TDateTimeField
      DisplayLabel = 'Death date'
      DisplayWidth = 10
      FieldName = 'DEATHDATE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU155LASTUPDATED: TDateTimeField
      DisplayLabel = 'Last updated'
      DisplayWidth = 10
      FieldName = 'LASTUPDATED'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
  end
  object dsrU160: TDataSource
    DataSet = selU160
    Left = 461
    Top = 68
  end
  object selU160: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid, U120.LASTNAME, U120.FIRSTNAME '
      '  from U160_UNJSPF_CHILDS t, U120_UNJSPF_STAFF_MEMBER U120'
      ' where T.ID_UNJSPF = :ID'
      '   and T.ID_UNJSPF = U120.ID_UNJSPF'
      '   and T.PROGRESSIVO = U120.PROGRESSIVO'
      '  :prog'
      
        'order by U120.LASTNAME, U120.FIRSTNAME, T.EMPLOYEE_NUMBER, T.ORG' +
        'CHILDID')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A00500052004F00470001000000000000000000
      0000060000003A0049004400030000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000F000000160000004C00410053005400550050004400410054004500
      440001000000000012000000490044005F0055004E004A005300500046000100
      0000000012000000440045004100540048004400410054004500010000000000
      1E00000045004D0050004C004F005900450045005F004E0055004D0042004500
      5200010000000000100000004C004100530054004E0041004D00450001000000
      000012000000460049005200530054004E0041004D0045000100000000001200
      00004200490052005400480044004100540045000100000000000C0000004700
      45004E00440045005200010000000000160000004E004100540049004F004E00
      41004C00490054005900010000000000140000004F0052004700430048004900
      4C004400490044000100000000001C0000004400490053004100420049004C00
      4900540059004400410054004500010000000000220000004400490053004100
      420049004C0049005400590045004E0044004400410054004500010000000000
      140000004C004100530054004E0041004D0045005F0031000100000000001600
      0000460049005200530054004E0041004D0045005F0031000100000000001600
      0000500052004F0047005200450053005300490056004F00010000000000}
    OnNewRecord = selU160NewRecord
    Left = 461
    Top = 15
    object selU160ID_UNJSPF: TFloatField
      DisplayLabel = 'Identificativo UNJSPF'
      FieldName = 'ID_UNJSPF'
      ReadOnly = True
      Required = True
      Visible = False
    end
    object selU160PROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selU160EMPLOYEE_NUMBER: TStringField
      DisplayLabel = 'Employee number'
      DisplayWidth = 10
      FieldName = 'EMPLOYEE_NUMBER'
      ReadOnly = True
      Required = True
      Size = 30
    end
    object selU160LASTNAME_1: TStringField
      DisplayLabel = 'Last name'
      DisplayWidth = 30
      FieldName = 'LASTNAME_1'
      ReadOnly = True
      Size = 150
    end
    object selU160FIRSTNAME_1: TStringField
      DisplayLabel = 'First name'
      DisplayWidth = 30
      FieldName = 'FIRSTNAME_1'
      ReadOnly = True
      Size = 150
    end
    object selU160ORGCHILDID: TFloatField
      DisplayLabel = 'Org. child ID'
      FieldName = 'ORGCHILDID'
      Required = True
    end
    object selU160LASTNAME: TStringField
      DisplayLabel = 'Last name'
      DisplayWidth = 30
      FieldName = 'LASTNAME'
      Required = True
      Size = 150
    end
    object selU160FIRSTNAME: TStringField
      DisplayLabel = 'First name'
      DisplayWidth = 30
      FieldName = 'FIRSTNAME'
      Size = 150
    end
    object selU160BIRTHDATE: TDateTimeField
      DisplayLabel = 'Birth date'
      DisplayWidth = 10
      FieldName = 'BIRTHDATE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU160GENDER: TStringField
      DisplayLabel = 'Gender'
      DisplayWidth = 10
      FieldName = 'GENDER'
      Size = 80
    end
    object selU160NATIONALITY: TStringField
      DisplayLabel = 'Nationality'
      DisplayWidth = 10
      FieldName = 'NATIONALITY'
      Size = 150
    end
    object selU160DEATHDATE: TDateTimeField
      DisplayLabel = 'Death date'
      DisplayWidth = 10
      FieldName = 'DEATHDATE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU160DISABILITYDATE: TDateTimeField
      DisplayLabel = 'Disability date'
      DisplayWidth = 10
      FieldName = 'DISABILITYDATE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU160DISABILITYENDDATE: TDateTimeField
      DisplayLabel = 'Disability end date'
      DisplayWidth = 10
      FieldName = 'DISABILITYENDDATE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU160LASTUPDATED: TDateTimeField
      DisplayLabel = 'Last updated'
      DisplayWidth = 10
      FieldName = 'LASTUPDATED'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
  end
  object selU165: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid, U120.LASTNAME, U120.FIRSTNAME '
      '  from U165_UNJSPF_LWOP t, U120_UNJSPF_STAFF_MEMBER U120'
      ' where T.ID_UNJSPF = :ID'
      '   and T.ID_UNJSPF = U120.ID_UNJSPF'
      '   and T.PROGRESSIVO = U120.PROGRESSIVO'
      '  :prog'
      
        'order by U120.LASTNAME, U120.FIRSTNAME, T.EMPLOYEE_NUMBER, T.STA' +
        'RTDATE')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A00500052004F00470001000000000000000000
      0000060000003A0049004400030000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      0500000008000000160000004C00410053005400550050004400410054004500
      440001000000000012000000490044005F0055004E004A005300500046000100
      0000000012000000530054004100520054004400410054004500010000000000
      0E00000045004E00440044004100540045000100000000001E00000045004D00
      50004C004F005900450045005F004E0055004D00420045005200010000000000
      100000004C004100530054004E0041004D004500010000000000120000004600
      49005200530054004E0041004D00450001000000000016000000500052004F00
      47005200450053005300490056004F00010000000000}
    OnNewRecord = selU165NewRecord
    Left = 509
    Top = 15
    object selU165ID_UNJSPF: TFloatField
      DisplayLabel = 'Identificativo UNJSPF'
      FieldName = 'ID_UNJSPF'
      ReadOnly = True
      Required = True
      Visible = False
    end
    object selU165PROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selU165EMPLOYEE_NUMBER: TStringField
      DisplayLabel = 'Employee number'
      DisplayWidth = 10
      FieldName = 'EMPLOYEE_NUMBER'
      ReadOnly = True
      Required = True
      Size = 30
    end
    object selU165LASTNAME: TStringField
      DisplayLabel = 'Last name'
      DisplayWidth = 30
      FieldName = 'LASTNAME'
      ReadOnly = True
      Size = 150
    end
    object selU165FIRSTNAME: TStringField
      DisplayLabel = 'First name'
      DisplayWidth = 30
      FieldName = 'FIRSTNAME'
      ReadOnly = True
      Size = 150
    end
    object selU165STARTDATE: TDateTimeField
      DisplayLabel = 'Start date'
      DisplayWidth = 10
      FieldName = 'STARTDATE'
      Required = True
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU165ENDDATE: TDateTimeField
      DisplayLabel = 'End date'
      DisplayWidth = 10
      FieldName = 'ENDDATE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU165LASTUPDATED: TDateTimeField
      DisplayLabel = 'Last updated'
      DisplayWidth = 10
      FieldName = 'LASTUPDATED'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
  end
  object dsrU165: TDataSource
    DataSet = selU165
    Left = 509
    Top = 68
  end
  object dsrU170: TDataSource
    DataSet = selU170
    Left = 559
    Top = 68
  end
  object selU170: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid, U120.LASTNAME, U120.FIRSTNAME '
      '  from U170_UNJSPF_ADDRESS t, U120_UNJSPF_STAFF_MEMBER U120'
      ' where T.ID_UNJSPF = :ID'
      '   and T.ID_UNJSPF = U120.ID_UNJSPF'
      '   and T.PROGRESSIVO = U120.PROGRESSIVO'
      '  :prog'
      
        'order by U120.LASTNAME, U120.FIRSTNAME, T.EMPLOYEE_NUMBER, T.EFF' +
        'ECTIVEDATE')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A00500052004F00470001000000000000000000
      0000060000003A0049004400030000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000001000000012000000490044005F0055004E004A005300500046000100
      000000001800000041004400440052004500530053005F005400590050004500
      0100000000001A00000045004600460045004300540049005600450044004100
      540045000100000000000A0000004C0049004E00450031000100000000000A00
      00004C0049004E00450032000100000000000A0000004C0049004E0045003300
      0100000000000A00000053005400410054004500010000000000080000004300
      4900540059000100000000001400000050004F005300540041004C0043004F00
      440045000100000000000E00000043004F0055004E0054005200590001000000
      00001E00000045004D0050004C004F005900450045005F004E0055004D004200
      450052000100000000000A0000004C0049004E00450034000100000000001C00
      000043004F0055004E00540052005900490053004F0043004F00440045000100
      00000000100000004C004100530054004E0041004D0045000100000000001200
      0000460049005200530054004E0041004D004500010000000000160000005000
      52004F0047005200450053005300490056004F00010000000000}
    OnNewRecord = selU170NewRecord
    Left = 559
    Top = 15
    object selU170ID_UNJSPF: TFloatField
      DisplayLabel = 'Identificativo UNJSPF'
      FieldName = 'ID_UNJSPF'
      ReadOnly = True
      Required = True
      Visible = False
    end
    object selU170PROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selU170EMPLOYEE_NUMBER: TStringField
      DisplayLabel = 'Employee number'
      DisplayWidth = 10
      FieldName = 'EMPLOYEE_NUMBER'
      ReadOnly = True
      Required = True
      Size = 30
    end
    object selU170LASTNAME: TStringField
      DisplayLabel = 'Last name'
      DisplayWidth = 30
      FieldName = 'LASTNAME'
      ReadOnly = True
      Size = 150
    end
    object selU170FIRSTNAME: TStringField
      DisplayLabel = 'First name'
      DisplayWidth = 30
      FieldName = 'FIRSTNAME'
      ReadOnly = True
      Size = 150
    end
    object selU170ADDRESS_TYPE: TStringField
      DisplayLabel = 'Address type'
      DisplayWidth = 10
      FieldName = 'ADDRESS_TYPE'
      Size = 30
    end
    object selU170EFFECTIVEDATE: TDateTimeField
      DisplayLabel = 'Effective date'
      DisplayWidth = 10
      FieldName = 'EFFECTIVEDATE'
      Required = True
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU170LINE1: TStringField
      DisplayLabel = 'Line 1'
      DisplayWidth = 30
      FieldName = 'LINE1'
      Size = 240
    end
    object selU170LINE2: TStringField
      DisplayLabel = 'Line 2'
      DisplayWidth = 10
      FieldName = 'LINE2'
      Size = 240
    end
    object selU170LINE3: TStringField
      DisplayLabel = 'Line 3'
      DisplayWidth = 10
      FieldName = 'LINE3'
      Size = 240
    end
    object selU170LINE4: TStringField
      DisplayLabel = 'Line 4'
      DisplayWidth = 10
      FieldName = 'LINE4'
      Size = 120
    end
    object selU170STATE: TStringField
      DisplayLabel = 'State'
      DisplayWidth = 10
      FieldName = 'STATE'
      Size = 120
    end
    object selU170CITY: TStringField
      DisplayLabel = 'City'
      DisplayWidth = 20
      FieldName = 'CITY'
      Size = 30
    end
    object selU170POSTALCODE: TStringField
      DisplayLabel = 'Postal code'
      DisplayWidth = 10
      FieldName = 'POSTALCODE'
      Size = 30
    end
    object selU170COUNTRY: TStringField
      DisplayLabel = 'Country'
      DisplayWidth = 10
      FieldName = 'COUNTRY'
      Size = 80
    end
    object selU170COUNTRYISOCODE: TStringField
      DisplayLabel = 'Country ISO code'
      FieldName = 'COUNTRYISOCODE'
      Size = 3
    end
  end
  object dsrU175: TDataSource
    DataSet = selU175
    Left = 607
    Top = 68
  end
  object selU175: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid, U120.LASTNAME, U120.FIRSTNAME '
      '  from U175_UNJSPF_PHONES t, U120_UNJSPF_STAFF_MEMBER U120'
      ' where T.ID_UNJSPF = :ID'
      '   and T.ID_UNJSPF = U120.ID_UNJSPF'
      '   and T.PROGRESSIVO = U120.PROGRESSIVO'
      '   :prog'
      'order by U120.LASTNAME, U120.FIRSTNAME, T.EMPLOYEE_NUMBER')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A00500052004F00470001000000000000000000
      0000060000003A0049004400030000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000700000012000000490044005F0055004E004A005300500046000100
      0000000014000000500048004F004E0045005F00540059005000450001000000
      000018000000500048004F004E0045005F004E0055004D004200450052000100
      000000001E00000045004D0050004C004F005900450045005F004E0055004D00
      420045005200010000000000100000004C004100530054004E0041004D004500
      01000000000012000000460049005200530054004E0041004D00450001000000
      000016000000500052004F0047005200450053005300490056004F0001000000
      0000}
    OnNewRecord = selU175NewRecord
    Left = 607
    Top = 15
    object selU175ID_UNJSPF: TFloatField
      DisplayLabel = 'Identificativo UNJSPF'
      FieldName = 'ID_UNJSPF'
      ReadOnly = True
      Required = True
      Visible = False
    end
    object selU175PROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selU175EMPLOYEE_NUMBER: TStringField
      DisplayLabel = 'Employee number'
      DisplayWidth = 10
      FieldName = 'EMPLOYEE_NUMBER'
      ReadOnly = True
      Required = True
      Size = 30
    end
    object selU175LASTNAME: TStringField
      DisplayLabel = 'Last name'
      DisplayWidth = 30
      FieldName = 'LASTNAME'
      ReadOnly = True
      Size = 150
    end
    object selU175FIRSTNAME: TStringField
      DisplayLabel = 'First name'
      DisplayWidth = 30
      FieldName = 'FIRSTNAME'
      ReadOnly = True
      Size = 150
    end
    object selU175PHONE_TYPE: TStringField
      DisplayLabel = 'Phone type'
      DisplayWidth = 10
      FieldName = 'PHONE_TYPE'
      Required = True
      Size = 30
    end
    object selU175PHONE_NUMBER: TStringField
      DisplayLabel = 'Phone number'
      DisplayWidth = 30
      FieldName = 'PHONE_NUMBER'
      Required = True
      Size = 60
    end
  end
  object selU180: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid, U120.LASTNAME, U120.FIRSTNAME '
      '  from U180_UNJSPF_EMAILS t, U120_UNJSPF_STAFF_MEMBER U120'
      ' where T.ID_UNJSPF = :ID'
      '   and T.ID_UNJSPF = U120.ID_UNJSPF'
      '   and T.PROGRESSIVO = U120.PROGRESSIVO'
      '   :prog'
      'order by U120.LASTNAME, U120.FIRSTNAME, T.EMPLOYEE_NUMBER')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A00500052004F00470001000000000000000000
      0000060000003A0049004400030000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000700000012000000490044005F0055004E004A005300500046000100
      000000000800000054005900500045000100000000001800000045004D004100
      49004C0041004400440052004500530053000100000000001E00000045004D00
      50004C004F005900450045005F004E0055004D00420045005200010000000000
      100000004C004100530054004E0041004D004500010000000000120000004600
      49005200530054004E0041004D00450001000000000016000000500052004F00
      47005200450053005300490056004F00010000000000}
    OnNewRecord = selU180NewRecord
    Left = 655
    Top = 15
    object selU180ID_UNJSPF: TFloatField
      DisplayLabel = 'Identificativo UNJSPF'
      FieldName = 'ID_UNJSPF'
      ReadOnly = True
      Required = True
      Visible = False
    end
    object selU180PROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selU180EMPLOYEE_NUMBER: TStringField
      DisplayLabel = 'Employee number'
      DisplayWidth = 10
      FieldName = 'EMPLOYEE_NUMBER'
      ReadOnly = True
      Required = True
      Size = 30
    end
    object selU180LASTNAME: TStringField
      DisplayLabel = 'Last name'
      DisplayWidth = 30
      FieldName = 'LASTNAME'
      ReadOnly = True
      Size = 150
    end
    object selU180FIRSTNAME: TStringField
      DisplayLabel = 'First name'
      DisplayWidth = 30
      FieldName = 'FIRSTNAME'
      ReadOnly = True
      Size = 150
    end
    object selU180TYPE: TStringField
      DisplayLabel = 'Type'
      FieldName = 'TYPE'
      Size = 7
    end
    object selU180EMAILADDRESS: TStringField
      DisplayLabel = 'E-mail address'
      DisplayWidth = 30
      FieldName = 'EMAILADDRESS'
      Size = 240
    end
  end
  object dsrU180: TDataSource
    DataSet = selU180
    Left = 655
    Top = 68
  end
  object selU190: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid'
      '  from U190_UNJSPF_PAY_TRAN t'
      ' where T.ID_UNJSPF = :ID'
      '   :prog'
      
        'order by T.LAST_NAME, T.FIRST_NAME, T.EMPLOYEE_NUMBER, T.TRANSAC' +
        'TION_TYPE, T.EFFECTIVE_START_DATE, T.EFFECTIVE_END_DATE')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A00500052004F00470001000000000000000000
      0000060000003A0049004400030000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000002F00000012000000490044005F0055004E004A005300500046000100
      0000000016000000500052004F0047005200450053005300490056004F000100
      000000001E00000045004D0050004C004F005900450045005F004E0055004D00
      4200450052000100000000001C000000500045004E00530049004F004E005F00
      4E0055004D004200450052000100000000001600000044004100540045005F00
      4500410052004E00450044000100000000001800000044004100540045005F00
      5000410059004D0045004E005400010000000000140000004600490052005300
      54005F004E0041004D004500010000000000120000004C004100530054005F00
      4E0041004D0045000100000000001A00000044004100540045005F004F004600
      5F0042004900520054004800010000000000200000005400520041004E005300
      41004300540049004F004E005F00540059005000450001000000000028000000
      4500460046004500430054004900560045005F00530054004100520054005F00
      4400410054004500010000000000240000004500460046004500430054004900
      560045005F0045004E0044005F00440041005400450001000000000022000000
      4C0057004F0050005F0043004F004E0054005200490042005F0046004C004100
      470001000000000010000000430041005400450047004F005200590001000000
      00000A0000004700520041004400450001000000000008000000530054004500
      50000100000000001800000044005500540059005F0053005400410054004900
      4F004E00010000000000200000005000410052005400540049004D0045005F00
      500045005200430045004E0054000100000000001A0000004300550052005200
      45004E00430059005F0043004F00440045000100000000001A00000045005800
      4300480041004E00470045005F00520041005400450001000000000026000000
      5000520052004100540045005F004C004F00430041004C005F0041004D004F00
      55004E005400010000000000240000005000520052004100540045005F004200
      4100530045005F0041004D004F0055004E0054000100000000003C0000004C00
      41004E00470055004100470045005F0041004C004C004F00570041004E004300
      45004C004F00430041004C005F0041004D004F0055004E005400010000000000
      3A0000004C0041004E00470055004100470045005F0041004C004C004F005700
      41004E004300450042004100530045005F0041004D004F0055004E0054000100
      000000001A000000500052004F00520041005400450044005200410054004900
      4F000100000000003600000043004F004E005400520049004200550054004900
      4F004E005F004C004F00430041004C005F0041004D004F0055004E0054005300
      4D000100000000003400000043004F004E005400520049004200550054004900
      4F004E005F0042004100530045005F0041004D004F0055004E00540053004D00
      0100000000003800000043004F004E0054005200490042005500540049004F00
      4E005F004C004F00430041004C005F0041004D004F0055004E0054004F005200
      47000100000000003600000043004F004E005400520049004200550054004900
      4F004E005F0042004100530045005F0041004D004F0055004E0054004F005200
      470001000000000032000000410044004A005500530054004D0045004E005400
      5F004C004F00430041004C005F0041004D004F0055004E00540053004D000100
      0000000030000000410044004A005500530054004D0045004E0054005F004200
      4100530045005F0041004D004F0055004E00540053004D000100000000003400
      0000410044004A005500530054004D0045004E0054005F004C004F0043004100
      4C005F0041004D004F0055004E0054004F005200470001000000000032000000
      410044004A005500530054004D0045004E0054005F0042004100530045005F00
      41004D004F0055004E0054004F00520047000100000000003A00000041004400
      4A005500530054004D0045004E0054005F004C004F00430041004C005F004100
      4D004F0055004E005400460055004C004C0053004D0001000000000038000000
      410044004A005500530054004D0045004E0054005F0042004100530045005F00
      41004D004F0055004E005400460055004C004C0053004D000100000000003C00
      0000410044004A005500530054004D0045004E0054005F004C004F0043004100
      4C005F0041004D004F0055004E005400460055004C004C004F00520047000100
      000000003A000000410044004A005500530054004D0045004E0054005F004200
      4100530045005F0041004D004F0055004E005400460055004C004C004F005200
      470001000000000026000000560041004C00490044004100540049004F004E00
      5F0041004D004F0055004E00540053004D000100000000002800000056004100
      4C00490044004100540049004F004E005F0041004D004F0055004E0054004F00
      520047000100000000002800000052004500530054004F005200410054004900
      4F004E005F0041004D004F0055004E00540053004D000100000000002A000000
      52004500530054004F0052004100540049004F004E005F0041004D004F005500
      4E0054004F005200470001000000000022000000410043005400550041005200
      490041004C005F0043004F0053005400530053004D0001000000000024000000
      410043005400550041005200490041004C005F0043004F005300540053004F00
      520047000100000000002E00000049004E005400450052004500530054005F00
      43004F004E0054005200490042005500540049004F004E0053004D0001000000
      00003000000049004E005400450052004500530054005F0043004F004E005400
      5200490042005500540049004F004E004F005200470001000000000022000000
      4D004900530043005F00410044004A005500530054004D0045004E0054005300
      4D00010000000000240000004D004900530043005F00410044004A0055005300
      54004D0045004E0054004F0052004700010000000000}
    OnNewRecord = selU180NewRecord
    Left = 727
    Top = 15
    object selU190ID_UNJSPF: TFloatField
      DisplayLabel = 'Identificativo UNJSPF'
      FieldName = 'ID_UNJSPF'
      Required = True
      Visible = False
    end
    object selU190PROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selU190EMPLOYEE_NUMBER: TStringField
      DisplayLabel = 'Employee number'
      DisplayWidth = 10
      FieldName = 'EMPLOYEE_NUMBER'
      Required = True
      Size = 30
    end
    object selU190LAST_NAME: TStringField
      DisplayLabel = 'Last name'
      DisplayWidth = 30
      FieldName = 'LAST_NAME'
      Size = 150
    end
    object selU190FIRST_NAME: TStringField
      DisplayLabel = 'First name'
      DisplayWidth = 30
      FieldName = 'FIRST_NAME'
      Size = 150
    end
    object selU190PENSION_NUMBER: TStringField
      DisplayLabel = 'Pension number'
      DisplayWidth = 10
      FieldName = 'PENSION_NUMBER'
      Size = 150
    end
    object selU190DATE_OF_BIRTH: TDateTimeField
      DisplayLabel = 'Date of birth'
      DisplayWidth = 10
      FieldName = 'DATE_OF_BIRTH'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU190DATE_EARNED: TDateTimeField
      DisplayLabel = 'Date earned'
      DisplayWidth = 10
      FieldName = 'DATE_EARNED'
      Required = True
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU190DATE_PAYMENT: TDateTimeField
      DisplayLabel = 'Date payment'
      DisplayWidth = 10
      FieldName = 'DATE_PAYMENT'
      Required = True
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU190LWOP_CONTRIB_FLAG: TStringField
      DisplayLabel = 'LWOP contrib.'
      FieldName = 'LWOP_CONTRIB_FLAG'
      Size = 10
    end
    object selU190CATEGORY: TStringField
      DisplayLabel = 'Category'
      DisplayWidth = 10
      FieldName = 'CATEGORY'
      Size = 80
    end
    object selU190GRADE: TStringField
      DisplayLabel = 'Grade'
      DisplayWidth = 10
      FieldName = 'GRADE'
      Size = 80
    end
    object selU190STEP: TStringField
      DisplayLabel = 'Step'
      FieldName = 'STEP'
      Size = 10
    end
    object selU190DUTY_STATION: TStringField
      DisplayLabel = 'Duty station'
      DisplayWidth = 10
      FieldName = 'DUTY_STATION'
      Size = 100
    end
    object selU190PARTTIME_PERCENT: TFloatField
      DisplayLabel = 'Part time percentage'
      FieldName = 'PARTTIME_PERCENT'
    end
    object selU190CURRENCY_CODE: TStringField
      DisplayLabel = 'Currency code'
      DisplayWidth = 10
      FieldName = 'CURRENCY_CODE'
      Size = 30
    end
    object selU190TRANSACTION_TYPE: TStringField
      DisplayLabel = 'Transaction type'
      DisplayWidth = 10
      FieldName = 'TRANSACTION_TYPE'
      Size = 60
    end
    object selU190EFFECTIVE_START_DATE: TDateTimeField
      DisplayLabel = 'Effective start date'
      DisplayWidth = 10
      FieldName = 'EFFECTIVE_START_DATE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU190EFFECTIVE_END_DATE: TDateTimeField
      DisplayLabel = 'Effective end date'
      DisplayWidth = 10
      FieldName = 'EFFECTIVE_END_DATE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU190EXCHANGE_RATE: TFloatField
      DisplayLabel = 'Exchange rate'
      FieldName = 'EXCHANGE_RATE'
    end
    object selU190PRRATE_LOCAL_AMOUNT: TFloatField
      DisplayLabel = 'Prrate local amount'
      FieldName = 'PRRATE_LOCAL_AMOUNT'
    end
    object selU190PRRATE_BASE_AMOUNT: TFloatField
      DisplayLabel = 'Prrate base amount'
      FieldName = 'PRRATE_BASE_AMOUNT'
    end
    object selU190LANGUAGE_ALLOWANCELOCAL_AMOUNT: TFloatField
      DisplayLabel = 'Language allowance local amount'
      FieldName = 'LANGUAGE_ALLOWANCELOCAL_AMOUNT'
    end
    object selU190LANGUAGE_ALLOWANCEBASE_AMOUNT: TFloatField
      DisplayLabel = 'Language allowance base amount'
      FieldName = 'LANGUAGE_ALLOWANCEBASE_AMOUNT'
    end
    object selU190PRORATEDRATIO: TFloatField
      DisplayLabel = 'Prorated ratio'
      FieldName = 'PRORATEDRATIO'
    end
    object selU190CONTRIBUTION_LOCAL_AMOUNTSM: TFloatField
      DisplayLabel = 'Contribution local amount SM'
      FieldName = 'CONTRIBUTION_LOCAL_AMOUNTSM'
    end
    object selU190CONTRIBUTION_BASE_AMOUNTSM: TFloatField
      DisplayLabel = 'Contribution base amount SM'
      FieldName = 'CONTRIBUTION_BASE_AMOUNTSM'
    end
    object selU190CONTRIBUTION_LOCAL_AMOUNTORG: TFloatField
      DisplayLabel = 'Contribution local amount Org'
      FieldName = 'CONTRIBUTION_LOCAL_AMOUNTORG'
    end
    object selU190CONTRIBUTION_BASE_AMOUNTORG: TFloatField
      DisplayLabel = 'Contribution base amount Org'
      FieldName = 'CONTRIBUTION_BASE_AMOUNTORG'
    end
    object selU190ADJUSTMENT_LOCAL_AMOUNTSM: TFloatField
      DisplayLabel = 'Adjustment local amount SM'
      FieldName = 'ADJUSTMENT_LOCAL_AMOUNTSM'
    end
    object selU190ADJUSTMENT_BASE_AMOUNTSM: TFloatField
      DisplayLabel = 'Adjustment base amount SM'
      FieldName = 'ADJUSTMENT_BASE_AMOUNTSM'
    end
    object selU190ADJUSTMENT_LOCAL_AMOUNTORG: TFloatField
      DisplayLabel = 'Adjustment local amount Org'
      FieldName = 'ADJUSTMENT_LOCAL_AMOUNTORG'
    end
    object selU190ADJUSTMENT_BASE_AMOUNTORG: TFloatField
      DisplayLabel = 'Adjustment base amount Org'
      FieldName = 'ADJUSTMENT_BASE_AMOUNTORG'
    end
    object selU190ADJUSTMENT_LOCAL_AMOUNTFULLSM: TFloatField
      DisplayLabel = 'Adjustment local amount full SM'
      FieldName = 'ADJUSTMENT_LOCAL_AMOUNTFULLSM'
    end
    object selU190ADJUSTMENT_BASE_AMOUNTFULLSM: TFloatField
      DisplayLabel = 'Adjustment base amount full SM'
      FieldName = 'ADJUSTMENT_BASE_AMOUNTFULLSM'
    end
    object selU190ADJUSTMENT_LOCAL_AMOUNTFULLORG: TFloatField
      DisplayLabel = 'Adjustment local amount full Org'
      FieldName = 'ADJUSTMENT_LOCAL_AMOUNTFULLORG'
    end
    object selU190ADJUSTMENT_BASE_AMOUNTFULLORG: TFloatField
      DisplayLabel = 'Adjustment base amount full Org'
      FieldName = 'ADJUSTMENT_BASE_AMOUNTFULLORG'
    end
    object selU190VALIDATION_AMOUNTSM: TFloatField
      DisplayLabel = 'Validation amount SM'
      FieldName = 'VALIDATION_AMOUNTSM'
    end
    object selU190VALIDATION_AMOUNTORG: TFloatField
      DisplayLabel = 'Validation amount Org'
      FieldName = 'VALIDATION_AMOUNTORG'
    end
    object selU190RESTORATION_AMOUNTSM: TFloatField
      DisplayLabel = 'Restoration amount SM'
      FieldName = 'RESTORATION_AMOUNTSM'
    end
    object selU190RESTORATION_AMOUNTORG: TFloatField
      DisplayLabel = 'Restoration amount Org'
      FieldName = 'RESTORATION_AMOUNTORG'
    end
    object selU190ACTUARIAL_COSTSSM: TFloatField
      DisplayLabel = 'Actuarial costs SM'
      FieldName = 'ACTUARIAL_COSTSSM'
    end
    object selU190ACTUARIAL_COSTSORG: TFloatField
      DisplayLabel = 'Actuarial costs Org'
      FieldName = 'ACTUARIAL_COSTSORG'
    end
    object selU190INTEREST_CONTRIBUTIONSM: TFloatField
      DisplayLabel = 'Interest contributions SM'
      FieldName = 'INTEREST_CONTRIBUTIONSM'
    end
    object selU190INTEREST_CONTRIBUTIONORG: TFloatField
      DisplayLabel = 'Interest contributions Org'
      FieldName = 'INTEREST_CONTRIBUTIONORG'
    end
    object selU190MISC_ADJUSTMENTSM: TFloatField
      DisplayLabel = 'Misc adjustments SM'
      FieldName = 'MISC_ADJUSTMENTSM'
    end
    object selU190MISC_ADJUSTMENTORG: TFloatField
      DisplayLabel = 'Misc adjustments Org'
      FieldName = 'MISC_ADJUSTMENTORG'
    end
  end
  object dsrU190: TDataSource
    DataSet = selU190
    Left = 727
    Top = 67
  end
  object selU120Diff: TOracleDataSet
    SQL.Strings = (
      'select * from'
      
        '(select :DataCorr DATA, progressivo, employee_number, pensionnum' +
        'ber, entrytofunddate, firstname, middlename, lastname, birthdate' +
        ', '
      
        '       nationality, countryofbirth, gender, maritalstatus, comla' +
        'nguage, formerpensionnumber'
      '  from U120_UNJSPF_STAFF_MEMBER U120, U100_UNJSPF_TESTATE U100'
      ' where U120.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :Tipo'
      '   and U100.DATA_FINE_PERIODO = :DataCorr'
      'MINUS'
      
        'select :DataCorr DATA, progressivo, employee_number, pensionnumb' +
        'er, entrytofunddate, firstname, middlename, lastname, birthdate,' +
        ' '
      
        '       nationality, countryofbirth, gender, maritalstatus, comla' +
        'nguage, formerpensionnumber'
      '  from U120_UNJSPF_STAFF_MEMBER U120, U100_UNJSPF_TESTATE U100'
      ' where U120.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :Tipo'
      '   and U100.DATA_FINE_PERIODO = :DataPrec)'
      'UNION ALL'
      
        '(select :DataPrec DATA, progressivo, employee_number, pensionnum' +
        'ber, entrytofunddate, firstname, middlename, lastname, birthdate' +
        ', '
      
        '       nationality, countryofbirth, gender, maritalstatus, comla' +
        'nguage, formerpensionnumber'
      '  from U120_UNJSPF_STAFF_MEMBER U120, U100_UNJSPF_TESTATE U100'
      ' where U120.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :TIPO'
      '   and U100.DATA_FINE_PERIODO = :DataPrec'
      'MINUS'
      
        'select :DataPrec DATA, progressivo, employee_number, pensionnumb' +
        'er, entrytofunddate, firstname, middlename, lastname, birthdate,' +
        ' '
      
        '       nationality, countryofbirth, gender, maritalstatus, comla' +
        'nguage, formerpensionnumber'
      '  from U120_UNJSPF_STAFF_MEMBER U120, U100_UNJSPF_TESTATE U100'
      ' where U120.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :TIPO'
      '   and U100.DATA_FINE_PERIODO = :DataCorr)'
      'order by lastname, firstname, employee_number, data'
      '')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A005400490050004F0005000000000000000000
      0000120000003A00440041005400410043004F00520052000C00000000000000
      00000000120000003A00440041005400410050005200450043000C0000000000
      000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      0500000010000000160000004C00410053005400550050004400410054004500
      44000100000000001A000000500045004E00530049004F004E004E0055004D00
      4200450052000100000000001E00000045004E0054005200590054004F004600
      55004E0044004400410054004500010000000000120000004600490052005300
      54004E0041004D004500010000000000140000004D004900440044004C004500
      4E0041004D004500010000000000100000004C004100530054004E0041004D00
      4500010000000000120000004200490052005400480044004100540045000100
      00000000160000004E004100540049004F004E0041004C004900540059000100
      000000001C00000043004F0055004E005400520059004F004600420049005200
      540048000100000000000C000000470045004E00440045005200010000000000
      1A0000004D00410052004900540041004C005300540041005400550053000100
      000000001600000043004F004D004C0041004E00470055004100470045000100
      000000002600000046004F0052004D0045005200500045004E00530049004F00
      4E004E0055004D004200450052000100000000001E00000045004D0050004C00
      4F005900450045005F004E0055004D0042004500520001000000000008000000
      440041005400410001000000000016000000500052004F004700520045005300
      5300490056004F00010000000000}
    Left = 27
    Top = 136
    object selU120DiffDATA: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU120DiffPROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selU120DiffEMPLOYEE_NUMBER: TStringField
      DisplayLabel = 'Employee number'
      DisplayWidth = 10
      FieldName = 'EMPLOYEE_NUMBER'
      Size = 30
    end
    object selU120DiffLASTNAME: TStringField
      DisplayLabel = 'Last name'
      DisplayWidth = 30
      FieldName = 'LASTNAME'
      Size = 150
    end
    object selU120DiffFIRSTNAME: TStringField
      DisplayLabel = 'First name'
      DisplayWidth = 30
      FieldName = 'FIRSTNAME'
      Size = 150
    end
    object selU120DiffPENSIONNUMBER: TStringField
      DisplayLabel = 'Pension number'
      DisplayWidth = 10
      FieldName = 'PENSIONNUMBER'
      Size = 150
    end
    object selU120DiffENTRYTOFUNDDATE: TDateTimeField
      DisplayLabel = 'Entry to fund date'
      DisplayWidth = 10
      FieldName = 'ENTRYTOFUNDDATE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU120DiffMIDDLENAME: TStringField
      DisplayLabel = 'Middle name'
      DisplayWidth = 10
      FieldName = 'MIDDLENAME'
      Size = 60
    end
    object selU120DiffBIRTHDATE: TDateTimeField
      DisplayLabel = 'Birth date'
      DisplayWidth = 10
      FieldName = 'BIRTHDATE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU120DiffNATIONALITY: TStringField
      DisplayLabel = 'Nationality'
      DisplayWidth = 10
      FieldName = 'NATIONALITY'
      Size = 150
    end
    object selU120DiffCOUNTRYOFBIRTH: TStringField
      DisplayLabel = 'Country of birth'
      FieldName = 'COUNTRYOFBIRTH'
      Size = 3
    end
    object selU120DiffGENDER: TStringField
      DisplayLabel = 'Gender'
      DisplayWidth = 10
      FieldName = 'GENDER'
      Size = 80
    end
    object selU120DiffMARITALSTATUS: TStringField
      DisplayLabel = 'Marital status'
      DisplayWidth = 20
      FieldName = 'MARITALSTATUS'
      Size = 150
    end
    object selU120DiffCOMLANGUAGE: TStringField
      DisplayLabel = 'Com language'
      DisplayWidth = 10
      FieldName = 'COMLANGUAGE'
      Size = 240
    end
    object selU120DiffFORMERPENSIONNUMBER: TFloatField
      DisplayLabel = 'Former pension number'
      FieldName = 'FORMERPENSIONNUMBER'
    end
  end
  object dsrU120Diff: TDataSource
    DataSet = selU120Diff
    Left = 27
    Top = 189
  end
  object selDataPrec: TOracleQuery
    SQL.Strings = (
      'SELECT MAX(U100P.DATA_FINE_PERIODO) '
      '  FROM U100_UNJSPF_TESTATE U100P '
      ' WHERE U100P.TIPO_FLUSSO = :Tipo'
      '   AND U100P.DATA_FINE_PERIODO < :DataRif')
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0044004100540041005200490046000C000000
      00000000000000000A0000003A005400490050004F0005000000000000000000
      0000}
    Left = 24
    Top = 256
  end
  object selU125Diff: TOracleDataSet
    SQL.Strings = (
      'select DISTINCT t.*, U120.LASTNAME, U120.FIRSTNAME from'
      
        '((select :DataCorr DATA, progressivo, employee_number, start_dat' +
        'e, count'
      '  from U125_UNJSPF_LANG_ALLWNCS U125, U100_UNJSPF_TESTATE U100'
      ' where U125.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :Tipo'
      '   and U100.DATA_FINE_PERIODO = :DataCorr'
      'MINUS'
      
        'select :DataCorr DATA, progressivo, employee_number, start_date,' +
        ' count'
      '  from U125_UNJSPF_LANG_ALLWNCS U125, U100_UNJSPF_TESTATE U100'
      ' where U125.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :Tipo'
      '   and U100.DATA_FINE_PERIODO = :DataPrec)'
      'UNION ALL'
      
        '(select :DataPrec DATA, progressivo, employee_number, start_date' +
        ', count'
      '  from U125_UNJSPF_LANG_ALLWNCS U125, U100_UNJSPF_TESTATE U100'
      ' where U125.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :TIPO'
      '   and U100.DATA_FINE_PERIODO = :DataPrec'
      'MINUS'
      
        'select :DataPrec DATA, progressivo, employee_number, start_date,' +
        ' count'
      '  from U125_UNJSPF_LANG_ALLWNCS U125, U100_UNJSPF_TESTATE U100'
      ' where U125.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :TIPO'
      
        '   and U100.DATA_FINE_PERIODO = :DataCorr)) T, U120_UNJSPF_STAFF' +
        '_MEMBER U120, U100_UNJSPF_TESTATE U100'
      'where T.PROGRESSIVO = U120.PROGRESSIVO'
      '  and U120.ID_UNJSPF = U100.ID_UNJSPF'
      '  and U100.TIPO_FLUSSO = :TIPO'
      '  and U100.DATA_FINE_PERIODO = :DataCorr'
      
        'order by U120.LASTNAME, U120.FIRSTNAME, T.EMPLOYEE_NUMBER, T.DAT' +
        'A'
      '')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A005400490050004F0005000000000000000000
      0000120000003A00440041005400410043004F00520052000C00000000000000
      00000000120000003A00440041005400410050005200450043000C0000000000
      000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      0500000008000000160000004C00410053005400550050004400410054004500
      440001000000000012000000460049005200530054004E0041004D0045000100
      00000000100000004C004100530054004E0041004D0045000100000000001E00
      000045004D0050004C004F005900450045005F004E0055004D00420045005200
      0100000000000800000044004100540041000100000000001400000053005400
      4100520054005F0044004100540045000100000000000A00000043004F005500
      4E00540001000000000016000000500052004F00470052004500530053004900
      56004F00010000000000}
    Left = 97
    Top = 136
    object selU125DiffDATA: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU125DiffPROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selU125DiffEMPLOYEE_NUMBER: TStringField
      DisplayLabel = 'Employee number'
      DisplayWidth = 10
      FieldName = 'EMPLOYEE_NUMBER'
      Size = 30
    end
    object selU125DiffLASTNAME: TStringField
      DisplayLabel = 'Last name'
      DisplayWidth = 30
      FieldName = 'LASTNAME'
      Size = 150
    end
    object selU125DiffFIRSTNAME: TStringField
      DisplayLabel = 'First name'
      DisplayWidth = 30
      FieldName = 'FIRSTNAME'
      Size = 150
    end
    object selU125DiffSTART_DATE: TDateTimeField
      DisplayLabel = 'Start date'
      DisplayWidth = 10
      FieldName = 'START_DATE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU125DiffCOUNT: TFloatField
      DisplayLabel = 'Count'
      FieldName = 'COUNT'
    end
  end
  object dsrU125Diff: TDataSource
    DataSet = selU125Diff
    Left = 97
    Top = 189
  end
  object selU130Diff: TOracleDataSet
    SQL.Strings = (
      'select DISTINCT t.*, U120.LASTNAME, U120.FIRSTNAME from'
      
        '((select :DataCorr DATA, progressivo, employee_number, effective' +
        'date, parttimepercentage'
      '  from U130_UNJSPF_PARTTIMES U130, U100_UNJSPF_TESTATE U100'
      ' where U130.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :Tipo'
      '   and U100.DATA_FINE_PERIODO = :DataCorr'
      'MINUS'
      
        'select :DataCorr DATA, progressivo, employee_number, effectiveda' +
        'te, parttimepercentage'
      '  from U130_UNJSPF_PARTTIMES U130, U100_UNJSPF_TESTATE U100'
      ' where U130.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :Tipo'
      '   and U100.DATA_FINE_PERIODO = :DataPrec)'
      'UNION ALL'
      
        '(select :DataPrec DATA, progressivo, employee_number, effectived' +
        'ate, parttimepercentage'
      '  from U130_UNJSPF_PARTTIMES U130, U100_UNJSPF_TESTATE U100'
      ' where U130.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :TIPO'
      '   and U100.DATA_FINE_PERIODO = :DataPrec'
      'MINUS'
      
        'select :DataPrec DATA, progressivo, employee_number, effectiveda' +
        'te, parttimepercentage'
      '  from U130_UNJSPF_PARTTIMES U130, U100_UNJSPF_TESTATE U100'
      ' where U130.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :TIPO'
      
        '   and U100.DATA_FINE_PERIODO = :DataCorr)) T, U120_UNJSPF_STAFF' +
        '_MEMBER U120, U100_UNJSPF_TESTATE U100'
      'where T.PROGRESSIVO = U120.PROGRESSIVO'
      '  and U120.ID_UNJSPF = U100.ID_UNJSPF'
      '  and U100.TIPO_FLUSSO = :TIPO'
      '  and U100.DATA_FINE_PERIODO = :DataCorr'
      
        'order by U120.LASTNAME, U120.FIRSTNAME, T.EMPLOYEE_NUMBER, T.DAT' +
        'A'
      '')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A005400490050004F0005000000000000000000
      0000120000003A00440041005400410043004F00520052000C00000000000000
      00000000120000003A00440041005400410050005200450043000C0000000000
      000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      0500000008000000160000004C00410053005400550050004400410054004500
      440001000000000012000000460049005200530054004E0041004D0045000100
      00000000100000004C004100530054004E0041004D0045000100000000001E00
      000045004D0050004C004F005900450045005F004E0055004D00420045005200
      0100000000000800000044004100540041000100000000001A00000045004600
      4600450043005400490056004500440041005400450001000000000024000000
      5000410052005400540049004D004500500045005200430045004E0054004100
      4700450001000000000016000000500052004F00470052004500530053004900
      56004F00010000000000}
    Left = 167
    Top = 136
    object selU130DiffDATA: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU130DiffPROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selU130DiffEMPLOYEE_NUMBER: TStringField
      DisplayLabel = 'Employee number'
      DisplayWidth = 10
      FieldName = 'EMPLOYEE_NUMBER'
      Size = 30
    end
    object selU130DiffLASTNAME: TStringField
      DisplayLabel = 'Last name'
      DisplayWidth = 30
      FieldName = 'LASTNAME'
      Size = 150
    end
    object selU130DiffFIRSTNAME: TStringField
      DisplayLabel = 'First name'
      DisplayWidth = 30
      FieldName = 'FIRSTNAME'
      Size = 150
    end
    object selU130DiffEFFECTIVEDATE: TDateTimeField
      DisplayLabel = 'Effective date'
      DisplayWidth = 10
      FieldName = 'EFFECTIVEDATE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU130DiffPARTTIMEPERCENTAGE: TFloatField
      DisplayLabel = 'Part-time percentage'
      FieldName = 'PARTTIMEPERCENTAGE'
    end
  end
  object dsrU130Diff: TDataSource
    DataSet = selU130Diff
    Left = 167
    Top = 189
  end
  object selU135Diff: TOracleDataSet
    SQL.Strings = (
      'select DISTINCT t.*, U120.LASTNAME, U120.FIRSTNAME from'
      
        '((select :DataCorr DATA, progressivo, employee_number, location_' +
        'code, effectivedate, dutystationcode, dutystationcountry'
      '  from U135_UNJSPF_DUTY_STTNS U135, U100_UNJSPF_TESTATE U100'
      ' where U135.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :Tipo'
      '   and U100.DATA_FINE_PERIODO = :DataCorr'
      'MINUS'
      
        'select :DataCorr DATA, progressivo, employee_number, location_co' +
        'de, effectivedate, dutystationcode, dutystationcountry'
      '  from U135_UNJSPF_DUTY_STTNS U135, U100_UNJSPF_TESTATE U100'
      ' where U135.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :Tipo'
      '   and U100.DATA_FINE_PERIODO = :DataPrec)'
      'UNION ALL'
      
        '(select :DataPrec DATA, progressivo, employee_number, location_c' +
        'ode, effectivedate, dutystationcode, dutystationcountry'
      '  from U135_UNJSPF_DUTY_STTNS U135, U100_UNJSPF_TESTATE U100'
      ' where U135.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :TIPO'
      '   and U100.DATA_FINE_PERIODO = :DataPrec'
      'MINUS'
      
        'select :DataPrec DATA, progressivo, employee_number, location_co' +
        'de, effectivedate, dutystationcode, dutystationcountry'
      '  from U135_UNJSPF_DUTY_STTNS U135, U100_UNJSPF_TESTATE U100'
      ' where U135.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :TIPO'
      
        '   and U100.DATA_FINE_PERIODO = :DataCorr)) T, U120_UNJSPF_STAFF' +
        '_MEMBER U120, U100_UNJSPF_TESTATE U100'
      'where T.PROGRESSIVO = U120.PROGRESSIVO'
      '  and U120.ID_UNJSPF = U100.ID_UNJSPF'
      '  and U100.TIPO_FLUSSO = :TIPO'
      '  and U100.DATA_FINE_PERIODO = :DataCorr'
      
        'order by U120.LASTNAME, U120.FIRSTNAME, T.EMPLOYEE_NUMBER, T.DAT' +
        'A'
      '')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A005400490050004F0005000000000000000000
      0000120000003A00440041005400410043004F00520052000C00000000000000
      00000000120000003A00440041005400410050005200450043000C0000000000
      000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000A000000160000004C00410053005400550050004400410054004500
      440001000000000012000000460049005200530054004E0041004D0045000100
      00000000100000004C004100530054004E0041004D0045000100000000001E00
      000045004D0050004C004F005900450045005F004E0055004D00420045005200
      0100000000000800000044004100540041000100000000001A00000045004600
      460045004300540049005600450044004100540045000100000000001A000000
      4C004F0043004100540049004F004E005F0043004F0044004500010000000000
      1E0000004400550054005900530054004100540049004F004E0043004F004400
      4500010000000000240000004400550054005900530054004100540049004F00
      4E0043004F0055004E0054005200590001000000000016000000500052004F00
      47005200450053005300490056004F00010000000000}
    Left = 236
    Top = 136
    object selU135DiffDATA: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU135DiffPROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selU135DiffEMPLOYEE_NUMBER: TStringField
      DisplayLabel = 'Employee number'
      DisplayWidth = 10
      FieldName = 'EMPLOYEE_NUMBER'
      Size = 30
    end
    object selU135DiffLASTNAME: TStringField
      DisplayLabel = 'Last name'
      DisplayWidth = 30
      FieldName = 'LASTNAME'
      Size = 150
    end
    object selU135DiffFIRSTNAME: TStringField
      DisplayLabel = 'First name'
      DisplayWidth = 30
      FieldName = 'FIRSTNAME'
      Size = 150
    end
    object selU135DiffLOCATION_CODE: TStringField
      DisplayLabel = 'Location code'
      DisplayWidth = 30
      FieldName = 'LOCATION_CODE'
      Size = 60
    end
    object selU135DiffEFFECTIVEDATE: TDateTimeField
      DisplayLabel = 'Effective date'
      DisplayWidth = 10
      FieldName = 'EFFECTIVEDATE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU135DiffDUTYSTATIONCODE: TStringField
      DisplayLabel = 'Duty station code'
      DisplayWidth = 10
      FieldName = 'DUTYSTATIONCODE'
      Size = 150
    end
    object selU135DiffDUTYSTATIONCOUNTRY: TStringField
      DisplayLabel = 'Duty station country'
      DisplayWidth = 10
      FieldName = 'DUTYSTATIONCOUNTRY'
      Size = 240
    end
  end
  object dsrU135Diff: TDataSource
    DataSet = selU135Diff
    Left = 236
    Top = 189
  end
  object selU140Diff: TOracleDataSet
    SQL.Strings = (
      'select DISTINCT t.*, U120.LASTNAME, U120.FIRSTNAME from'
      
        '((select :DataCorr DATA, progressivo, employee_number, effective' +
        'date, category, grade, step'
      '  from U140_UNJSPF_SALARIES U140, U100_UNJSPF_TESTATE U100'
      ' where U140.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :Tipo'
      '   and U100.DATA_FINE_PERIODO = :DataCorr'
      'MINUS'
      
        'select :DataCorr DATA, progressivo, employee_number, effectiveda' +
        'te, category, grade, step'
      '  from U140_UNJSPF_SALARIES U140, U100_UNJSPF_TESTATE U100'
      ' where U140.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :Tipo'
      '   and U100.DATA_FINE_PERIODO = :DataPrec)'
      'UNION ALL'
      
        '(select :DataPrec DATA, progressivo, employee_number, effectived' +
        'ate, category, grade, step'
      '  from U140_UNJSPF_SALARIES U140, U100_UNJSPF_TESTATE U100'
      ' where U140.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :TIPO'
      '   and U100.DATA_FINE_PERIODO = :DataPrec'
      'MINUS'
      
        'select :DataPrec DATA, progressivo, employee_number, effectiveda' +
        'te, category, grade, step'
      '  from U140_UNJSPF_SALARIES U140, U100_UNJSPF_TESTATE U100'
      ' where U140.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :TIPO'
      
        '   and U100.DATA_FINE_PERIODO = :DataCorr)) T, U120_UNJSPF_STAFF' +
        '_MEMBER U120, U100_UNJSPF_TESTATE U100'
      'where T.PROGRESSIVO = U120.PROGRESSIVO'
      '  and U120.ID_UNJSPF = U100.ID_UNJSPF'
      '  and U100.TIPO_FLUSSO = :TIPO'
      '  and U100.DATA_FINE_PERIODO = :DataCorr'
      
        'order by U120.LASTNAME, U120.FIRSTNAME, T.EMPLOYEE_NUMBER, T.DAT' +
        'A'
      '')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A005400490050004F0005000000000000000000
      0000120000003A00440041005400410043004F00520052000C00000000000000
      00000000120000003A00440041005400410050005200450043000C0000000000
      000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000A000000160000004C00410053005400550050004400410054004500
      440001000000000012000000460049005200530054004E0041004D0045000100
      00000000100000004C004100530054004E0041004D0045000100000000001E00
      000045004D0050004C004F005900450045005F004E0055004D00420045005200
      0100000000000800000044004100540041000100000000001A00000045004600
      4600450043005400490056004500440041005400450001000000000010000000
      430041005400450047004F00520059000100000000000A000000470052004100
      4400450001000000000008000000530054004500500001000000000016000000
      500052004F0047005200450053005300490056004F00010000000000}
    Left = 306
    Top = 136
    object selU140DiffDATA: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU140DiffPROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selU140DiffEMPLOYEE_NUMBER: TStringField
      DisplayLabel = 'Employee number'
      DisplayWidth = 10
      FieldName = 'EMPLOYEE_NUMBER'
      Size = 30
    end
    object selU140DiffLASTNAME: TStringField
      DisplayLabel = 'Last name'
      DisplayWidth = 30
      FieldName = 'LASTNAME'
      Size = 150
    end
    object selU140DiffFIRSTNAME: TStringField
      DisplayLabel = 'First name'
      DisplayWidth = 30
      FieldName = 'FIRSTNAME'
      Size = 150
    end
    object selU140DiffEFFECTIVEDATE: TDateTimeField
      DisplayLabel = 'Effective date'
      DisplayWidth = 10
      FieldName = 'EFFECTIVEDATE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU140DiffCATEGORY: TStringField
      DisplayLabel = 'Category'
      DisplayWidth = 10
      FieldName = 'CATEGORY'
    end
    object selU140DiffGRADE: TStringField
      DisplayLabel = 'Grade'
      DisplayWidth = 10
      FieldName = 'GRADE'
    end
    object selU140DiffSTEP: TStringField
      DisplayLabel = 'Step'
      DisplayWidth = 10
      FieldName = 'STEP'
      Size = 150
    end
  end
  object dsrU140Diff: TDataSource
    DataSet = selU140Diff
    Left = 306
    Top = 189
  end
  object selU145Diff: TOracleDataSet
    SQL.Strings = (
      'select DISTINCT t.*, U120.LASTNAME, U120.FIRSTNAME from'
      
        '((select :DataCorr DATA, progressivo, employee_number, startdate' +
        ', enddate, reappointindicator'
      '  from U145_UNJSPF_CONTRACTS U145, U100_UNJSPF_TESTATE U100'
      ' where U145.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :Tipo'
      '   and U100.DATA_FINE_PERIODO = :DataCorr'
      'MINUS'
      
        'select :DataCorr DATA, progressivo, employee_number, startdate, ' +
        'enddate, reappointindicator'
      '  from U145_UNJSPF_CONTRACTS U145, U100_UNJSPF_TESTATE U100'
      ' where U145.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :Tipo'
      '   and U100.DATA_FINE_PERIODO = :DataPrec)'
      'UNION ALL'
      
        '(select :DataPrec DATA, progressivo, employee_number, startdate,' +
        ' enddate, reappointindicator'
      '  from U145_UNJSPF_CONTRACTS U145, U100_UNJSPF_TESTATE U100'
      ' where U145.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :TIPO'
      '   and U100.DATA_FINE_PERIODO = :DataPrec'
      'MINUS'
      
        'select :DataPrec DATA, progressivo, employee_number, startdate, ' +
        'enddate, reappointindicator'
      '  from U145_UNJSPF_CONTRACTS U145, U100_UNJSPF_TESTATE U100'
      ' where U145.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :TIPO'
      
        '   and U100.DATA_FINE_PERIODO = :DataCorr)) T, U120_UNJSPF_STAFF' +
        '_MEMBER U120, U100_UNJSPF_TESTATE U100'
      'where T.PROGRESSIVO = U120.PROGRESSIVO'
      '  and U120.ID_UNJSPF = U100.ID_UNJSPF'
      '  and U100.TIPO_FLUSSO = :TIPO'
      '  and U100.DATA_FINE_PERIODO = :DataCorr'
      
        'order by U120.LASTNAME, U120.FIRSTNAME, T.EMPLOYEE_NUMBER, T.DAT' +
        'A'
      '')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A005400490050004F0005000000000000000000
      0000120000003A00440041005400410043004F00520052000C00000000000000
      00000000120000003A00440041005400410050005200450043000C0000000000
      000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      0500000009000000160000004C00410053005400550050004400410054004500
      440001000000000012000000460049005200530054004E0041004D0045000100
      00000000100000004C004100530054004E0041004D0045000100000000001E00
      000045004D0050004C004F005900450045005F004E0055004D00420045005200
      0100000000000800000044004100540041000100000000001200000053005400
      41005200540044004100540045000100000000000E00000045004E0044004400
      41005400450001000000000024000000520045004100500050004F0049004E00
      540049004E00440049004300410054004F005200010000000000160000005000
      52004F0047005200450053005300490056004F00010000000000}
    Left = 375
    Top = 136
    object selU145DiffDATA: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU145DiffPROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selU145DiffEMPLOYEE_NUMBER: TStringField
      DisplayLabel = 'Employee number'
      DisplayWidth = 10
      FieldName = 'EMPLOYEE_NUMBER'
      Size = 30
    end
    object selU145DiffLASTNAME: TStringField
      DisplayLabel = 'Last name'
      DisplayWidth = 30
      FieldName = 'LASTNAME'
      Size = 150
    end
    object selU145DiffFIRSTNAME: TStringField
      DisplayLabel = 'First name'
      DisplayWidth = 30
      FieldName = 'FIRSTNAME'
      Size = 150
    end
    object selU145DiffSTARTDATE: TDateTimeField
      DisplayLabel = 'Start date'
      DisplayWidth = 10
      FieldName = 'STARTDATE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU145DiffENDDATE: TDateTimeField
      DisplayLabel = 'End date'
      DisplayWidth = 10
      FieldName = 'ENDDATE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU145DiffREAPPOINTINDICATOR: TStringField
      DisplayLabel = 'Reap point indicator'
      FieldName = 'REAPPOINTINDICATOR'
      Size = 7
    end
  end
  object dsrU145Diff: TDataSource
    DataSet = selU145Diff
    Left = 375
    Top = 189
  end
  object dsrU150Diff: TDataSource
    DataSet = selU150Diff
    Left = 441
    Top = 188
  end
  object selU150Diff: TOracleDataSet
    SQL.Strings = (
      'select DISTINCT t.*, U120.LASTNAME, U120.FIRSTNAME from'
      
        '((select :DataCorr DATA, progressivo, employee_number, effective' +
        'date, reason, deathdate'
      '  from U150_UNJSPF_SEPARATIONS U150, U100_UNJSPF_TESTATE U100'
      ' where U150.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :Tipo'
      '   and U100.DATA_FINE_PERIODO = :DataCorr'
      'MINUS'
      
        'select :DataCorr DATA, progressivo, employee_number, effectiveda' +
        'te, reason, deathdate'
      '  from U150_UNJSPF_SEPARATIONS U150, U100_UNJSPF_TESTATE U100'
      ' where U150.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :Tipo'
      '   and U100.DATA_FINE_PERIODO = :DataPrec)'
      'UNION ALL'
      
        '(select :DataPrec DATA, progressivo, employee_number, effectived' +
        'ate, reason, deathdate'
      '  from U150_UNJSPF_SEPARATIONS U150, U100_UNJSPF_TESTATE U100'
      ' where U150.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :TIPO'
      '   and U100.DATA_FINE_PERIODO = :DataPrec'
      'MINUS'
      
        'select :DataPrec DATA, progressivo, employee_number, effectiveda' +
        'te, reason, deathdate'
      '  from U150_UNJSPF_SEPARATIONS U150, U100_UNJSPF_TESTATE U100'
      ' where U150.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :TIPO'
      
        '   and U100.DATA_FINE_PERIODO = :DataCorr)) T, U120_UNJSPF_STAFF' +
        '_MEMBER U120, U100_UNJSPF_TESTATE U100'
      'where T.PROGRESSIVO = U120.PROGRESSIVO'
      '  and U120.ID_UNJSPF = U100.ID_UNJSPF'
      '  and U100.TIPO_FLUSSO = :TIPO'
      '  and U100.DATA_FINE_PERIODO = :DataCorr'
      
        'order by U120.LASTNAME, U120.FIRSTNAME, T.EMPLOYEE_NUMBER, T.DAT' +
        'A'
      '')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A005400490050004F0005000000000000000000
      0000120000003A00440041005400410043004F00520052000C00000000000000
      00000000120000003A00440041005400410050005200450043000C0000000000
      000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      0500000009000000160000004C00410053005400550050004400410054004500
      440001000000000012000000460049005200530054004E0041004D0045000100
      00000000100000004C004100530054004E0041004D0045000100000000001E00
      000045004D0050004C004F005900450045005F004E0055004D00420045005200
      0100000000000800000044004100540041000100000000001A00000045004600
      460045004300540049005600450044004100540045000100000000000C000000
      52004500410053004F004E000100000000001200000044004500410054004800
      440041005400450001000000000016000000500052004F004700520045005300
      5300490056004F00010000000000}
    Left = 441
    Top = 135
    object selU150DiffDATA: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU150DiffPROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selU150DiffEMPLOYEE_NUMBER: TStringField
      DisplayLabel = 'Employee number'
      DisplayWidth = 10
      FieldName = 'EMPLOYEE_NUMBER'
      Size = 30
    end
    object selU150DiffLASTNAME: TStringField
      DisplayLabel = 'Last name'
      DisplayWidth = 30
      FieldName = 'LASTNAME'
      Size = 150
    end
    object selU150DiffFIRSTNAME: TStringField
      DisplayLabel = 'First name'
      DisplayWidth = 30
      FieldName = 'FIRSTNAME'
      Size = 150
    end
    object selU150DiffEFFECTIVEDATE: TDateTimeField
      DisplayLabel = 'Effective date'
      DisplayWidth = 10
      FieldName = 'EFFECTIVEDATE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU150DiffREASON: TStringField
      DisplayLabel = 'Reason'
      DisplayWidth = 30
      FieldName = 'REASON'
      Size = 150
    end
    object selU150DiffDEATHDATE: TDateTimeField
      DisplayLabel = 'Death date'
      DisplayWidth = 10
      FieldName = 'DEATHDATE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
  end
  object dsrU155Diff: TDataSource
    DataSet = selU155Diff
    Left = 505
    Top = 188
  end
  object selU155Diff: TOracleDataSet
    SQL.Strings = (
      'select DISTINCT t.*, U120.LASTNAME, U120.FIRSTNAME from'
      
        '((select :DataCorr DATA, progressivo, employee_number, orgdepend' +
        'entid, spousestaffid, lastname, firstname, birthdate, gender, re' +
        'lationship, nationality, marriagedate, divorcedate, deathdate'
      '  from U155_UNJSPF_DEPENDANTS U155, U100_UNJSPF_TESTATE U100'
      ' where U155.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :Tipo'
      '   and U100.DATA_FINE_PERIODO = :DataCorr'
      'MINUS'
      
        'select :DataCorr DATA, progressivo, employee_number, orgdependen' +
        'tid, spousestaffid, lastname, firstname, birthdate, gender, rela' +
        'tionship, nationality, marriagedate, divorcedate, deathdate'
      '  from U155_UNJSPF_DEPENDANTS U155, U100_UNJSPF_TESTATE U100'
      ' where U155.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :Tipo'
      '   and U100.DATA_FINE_PERIODO = :DataPrec)'
      'UNION ALL'
      
        '(select :DataPrec DATA, progressivo, employee_number, orgdepende' +
        'ntid, spousestaffid, lastname, firstname, birthdate, gender, rel' +
        'ationship, nationality, marriagedate, divorcedate, deathdate'
      '  from U155_UNJSPF_DEPENDANTS U155, U100_UNJSPF_TESTATE U100'
      ' where U155.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :TIPO'
      '   and U100.DATA_FINE_PERIODO = :DataPrec'
      'MINUS'
      
        'select :DataPrec DATA, progressivo, employee_number, orgdependen' +
        'tid, spousestaffid, lastname, firstname, birthdate, gender, rela' +
        'tionship, nationality, marriagedate, divorcedate, deathdate'
      '  from U155_UNJSPF_DEPENDANTS U155, U100_UNJSPF_TESTATE U100'
      ' where U155.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :TIPO'
      
        '   and U100.DATA_FINE_PERIODO = :DataCorr)) T, U120_UNJSPF_STAFF' +
        '_MEMBER U120, U100_UNJSPF_TESTATE U100'
      'where T.PROGRESSIVO = U120.PROGRESSIVO'
      '  and U120.ID_UNJSPF = U100.ID_UNJSPF'
      '  and U100.TIPO_FLUSSO = :TIPO'
      '  and U100.DATA_FINE_PERIODO = :DataCorr'
      
        'order by U120.LASTNAME, U120.FIRSTNAME, T.EMPLOYEE_NUMBER, T.DAT' +
        'A'
      '')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A005400490050004F0005000000000000000000
      0000120000003A00440041005400410043004F00520052000C00000000000000
      00000000120000003A00440041005400410050005200450043000C0000000000
      000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      0500000011000000160000004C00410053005400550050004400410054004500
      440001000000000012000000460049005200530054004E0041004D0045000100
      00000000100000004C004100530054004E0041004D0045000100000000001E00
      000045004D0050004C004F005900450045005F004E0055004D00420045005200
      0100000000000800000044004100540041000100000000001200000044004500
      41005400480044004100540045000100000000001C0000004F00520047004400
      4500500045004E00440045004E005400490044000100000000001A0000005300
      50004F0055005300450053005400410046004600490044000100000000001200
      00004200490052005400480044004100540045000100000000000C0000004700
      45004E0044004500520001000000000018000000520045004C00410054004900
      4F004E005300480049005000010000000000160000004E004100540049004F00
      4E0041004C00490054005900010000000000180000004D004100520052004900
      4100470045004400410054004500010000000000160000004400490056004F00
      5200430045004400410054004500010000000000140000004C00410053005400
      4E0041004D0045005F0031000100000000001600000046004900520053005400
      4E0041004D0045005F00310001000000000016000000500052004F0047005200
      450053005300490056004F00010000000000}
    Left = 505
    Top = 135
    object selU155DiffDATA: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU155DiffPROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selU155DiffEMPLOYEE_NUMBER: TStringField
      DisplayLabel = 'Employee number'
      DisplayWidth = 10
      FieldName = 'EMPLOYEE_NUMBER'
      Size = 30
    end
    object selU155DiffLASTNAME_1: TStringField
      DisplayLabel = 'Last name'
      DisplayWidth = 30
      FieldName = 'LASTNAME_1'
      Size = 150
    end
    object selU155DiffFIRSTNAME_1: TStringField
      DisplayLabel = 'First name'
      DisplayWidth = 30
      FieldName = 'FIRSTNAME_1'
      Size = 150
    end
    object selU155DiffORGDEPENDENTID: TFloatField
      DisplayLabel = 'Org. dependent ID'
      FieldName = 'ORGDEPENDENTID'
    end
    object selU155DiffSPOUSESTAFFID: TStringField
      DisplayLabel = 'Spouse st. affid.'
      DisplayWidth = 10
      FieldName = 'SPOUSESTAFFID'
      Size = 30
    end
    object selU155DiffLASTNAME: TStringField
      DisplayLabel = 'Last name'
      DisplayWidth = 30
      FieldName = 'LASTNAME'
      Size = 150
    end
    object selU155DiffFIRSTNAME: TStringField
      DisplayLabel = 'First name'
      DisplayWidth = 30
      FieldName = 'FIRSTNAME'
      Size = 150
    end
    object selU155DiffBIRTHDATE: TDateTimeField
      DisplayLabel = 'Birth date'
      DisplayWidth = 10
      FieldName = 'BIRTHDATE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU155DiffGENDER: TStringField
      DisplayLabel = 'Gender'
      DisplayWidth = 10
      FieldName = 'GENDER'
      Size = 80
    end
    object selU155DiffRELATIONSHIP: TStringField
      DisplayLabel = 'Relationship'
      DisplayWidth = 10
      FieldName = 'RELATIONSHIP'
      Size = 150
    end
    object selU155DiffNATIONALITY: TStringField
      DisplayLabel = 'Nationality'
      DisplayWidth = 10
      FieldName = 'NATIONALITY'
      Size = 150
    end
    object selU155DiffMARRIAGEDATE: TDateTimeField
      DisplayLabel = 'Marriage date'
      DisplayWidth = 10
      FieldName = 'MARRIAGEDATE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU155DiffDIVORCEDATE: TDateTimeField
      DisplayLabel = 'Divorce date'
      DisplayWidth = 10
      FieldName = 'DIVORCEDATE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU155DiffDEATHDATE: TDateTimeField
      DisplayLabel = 'Death date'
      DisplayWidth = 10
      FieldName = 'DEATHDATE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
  end
  object selU160Diff: TOracleDataSet
    SQL.Strings = (
      'select DISTINCT t.*, U120.LASTNAME, U120.FIRSTNAME from'
      
        '((select :DataCorr DATA, progressivo, employee_number, orgchildi' +
        'd, lastname, firstname, birthdate, gender, nationality, deathdat' +
        'e, disabilitydate, disabilityenddate'
      '  from U160_UNJSPF_CHILDS U160, U100_UNJSPF_TESTATE U100'
      ' where U160.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :Tipo'
      '   and U100.DATA_FINE_PERIODO = :DataCorr'
      'MINUS'
      
        'select :DataCorr DATA, progressivo, employee_number, orgchildid,' +
        ' lastname, firstname, birthdate, gender, nationality, deathdate,' +
        ' disabilitydate, disabilityenddate'
      '  from U160_UNJSPF_CHILDS U160, U100_UNJSPF_TESTATE U100'
      ' where U160.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :Tipo'
      '   and U100.DATA_FINE_PERIODO = :DataPrec)'
      'UNION ALL'
      
        '(select :DataPrec DATA, progressivo, employee_number, orgchildid' +
        ', lastname, firstname, birthdate, gender, nationality, deathdate' +
        ', disabilitydate, disabilityenddate'
      '  from U160_UNJSPF_CHILDS U160, U100_UNJSPF_TESTATE U100'
      ' where U160.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :TIPO'
      '   and U100.DATA_FINE_PERIODO = :DataPrec'
      'MINUS'
      
        'select :DataPrec DATA, progressivo, employee_number, orgchildid,' +
        ' lastname, firstname, birthdate, gender, nationality, deathdate,' +
        ' disabilitydate, disabilityenddate'
      '  from U160_UNJSPF_CHILDS U160, U100_UNJSPF_TESTATE U100'
      ' where U160.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :TIPO'
      
        '   and U100.DATA_FINE_PERIODO = :DataCorr)) T, U120_UNJSPF_STAFF' +
        '_MEMBER U120, U100_UNJSPF_TESTATE U100'
      'where T.PROGRESSIVO = U120.PROGRESSIVO'
      '  and U120.ID_UNJSPF = U100.ID_UNJSPF'
      '  and U100.TIPO_FLUSSO = :TIPO'
      '  and U100.DATA_FINE_PERIODO = :DataCorr'
      
        'order by U120.LASTNAME, U120.FIRSTNAME, T.EMPLOYEE_NUMBER, T.DAT' +
        'A'
      '')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A005400490050004F0005000000000000000000
      0000120000003A00440041005400410043004F00520052000C00000000000000
      00000000120000003A00440041005400410050005200450043000C0000000000
      000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000F000000160000004C00410053005400550050004400410054004500
      440001000000000012000000460049005200530054004E0041004D0045000100
      00000000100000004C004100530054004E0041004D0045000100000000001E00
      000045004D0050004C004F005900450045005F004E0055004D00420045005200
      0100000000000800000044004100540041000100000000001200000044004500
      4100540048004400410054004500010000000000120000004200490052005400
      480044004100540045000100000000000C000000470045004E00440045005200
      010000000000160000004E004100540049004F004E0041004C00490054005900
      010000000000140000004C004100530054004E0041004D0045005F0031000100
      0000000016000000460049005200530054004E0041004D0045005F0031000100
      00000000140000004F00520047004300480049004C0044004900440001000000
      00001C0000004400490053004100420049004C00490054005900440041005400
      4500010000000000220000004400490053004100420049004C00490054005900
      45004E004400440041005400450001000000000016000000500052004F004700
      5200450053005300490056004F00010000000000}
    Left = 569
    Top = 135
    object selU160DiffDATA: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU160DiffPROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selU160DiffEMPLOYEE_NUMBER: TStringField
      DisplayLabel = 'Employee number'
      DisplayWidth = 10
      FieldName = 'EMPLOYEE_NUMBER'
      Size = 30
    end
    object selU160DiffLASTNAME_1: TStringField
      DisplayLabel = 'Last name'
      DisplayWidth = 30
      FieldName = 'LASTNAME_1'
      Size = 150
    end
    object selU160DiffFIRSTNAME_1: TStringField
      DisplayLabel = 'First name'
      DisplayWidth = 30
      FieldName = 'FIRSTNAME_1'
      Size = 150
    end
    object selU160DiffORGCHILDID: TFloatField
      DisplayLabel = 'Org. child ID'
      FieldName = 'ORGCHILDID'
    end
    object selU160DiffLASTNAME: TStringField
      DisplayLabel = 'Last name'
      DisplayWidth = 30
      FieldName = 'LASTNAME'
      Size = 150
    end
    object selU160DiffFIRSTNAME: TStringField
      DisplayLabel = 'First name'
      DisplayWidth = 30
      FieldName = 'FIRSTNAME'
      Size = 150
    end
    object selU160DiffBIRTHDATE: TDateTimeField
      DisplayLabel = 'Birth date'
      DisplayWidth = 10
      FieldName = 'BIRTHDATE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU160DiffGENDER: TStringField
      DisplayLabel = 'Gender'
      DisplayWidth = 10
      FieldName = 'GENDER'
      Size = 80
    end
    object selU160DiffNATIONALITY: TStringField
      DisplayLabel = 'Nationality'
      DisplayWidth = 10
      FieldName = 'NATIONALITY'
      Size = 150
    end
    object selU160DiffDEATHDATE: TDateTimeField
      DisplayLabel = 'Death date'
      DisplayWidth = 10
      FieldName = 'DEATHDATE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU160DiffDISABILITYDATE: TDateTimeField
      DisplayLabel = 'Disability date'
      DisplayWidth = 10
      FieldName = 'DISABILITYDATE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU160DiffDISABILITYENDDATE: TDateTimeField
      DisplayLabel = 'Disability end date'
      DisplayWidth = 10
      FieldName = 'DISABILITYENDDATE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
  end
  object dsrU160Diff: TDataSource
    DataSet = selU160Diff
    Left = 569
    Top = 188
  end
  object dsrU165Diff: TDataSource
    DataSet = selU165Diff
    Left = 631
    Top = 187
  end
  object selU165Diff: TOracleDataSet
    SQL.Strings = (
      'select DISTINCT t.*, U120.LASTNAME, U120.FIRSTNAME from'
      
        '((select :DataCorr DATA, progressivo, employee_number, startdate' +
        ', enddate'
      '  from U165_UNJSPF_LWOP U165, U100_UNJSPF_TESTATE U100'
      ' where U165.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :Tipo'
      '   and U100.DATA_FINE_PERIODO = :DataCorr'
      'MINUS'
      
        'select :DataCorr DATA, progressivo, employee_number, startdate, ' +
        'enddate'
      '  from U165_UNJSPF_LWOP U165, U100_UNJSPF_TESTATE U100'
      ' where U165.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :Tipo'
      '   and U100.DATA_FINE_PERIODO = :DataPrec)'
      'UNION ALL'
      
        '(select :DataPrec DATA, progressivo, employee_number, startdate,' +
        ' enddate'
      '  from U165_UNJSPF_LWOP U165, U100_UNJSPF_TESTATE U100'
      ' where U165.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :TIPO'
      '   and U100.DATA_FINE_PERIODO = :DataPrec'
      'MINUS'
      
        'select :DataPrec DATA, progressivo, employee_number, startdate, ' +
        'enddate'
      '  from U165_UNJSPF_LWOP U165, U100_UNJSPF_TESTATE U100'
      ' where U165.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :TIPO'
      
        '   and U100.DATA_FINE_PERIODO = :DataCorr)) T, U120_UNJSPF_STAFF' +
        '_MEMBER U120, U100_UNJSPF_TESTATE U100'
      'where T.PROGRESSIVO = U120.PROGRESSIVO'
      '  and U120.ID_UNJSPF = U100.ID_UNJSPF'
      '  and U100.TIPO_FLUSSO = :TIPO'
      '  and U100.DATA_FINE_PERIODO = :DataCorr'
      
        'order by U120.LASTNAME, U120.FIRSTNAME, T.EMPLOYEE_NUMBER, T.DAT' +
        'A'
      '')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A005400490050004F0005000000000000000000
      0000120000003A00440041005400410043004F00520052000C00000000000000
      00000000120000003A00440041005400410050005200450043000C0000000000
      000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      0500000008000000160000004C00410053005400550050004400410054004500
      440001000000000012000000460049005200530054004E0041004D0045000100
      00000000100000004C004100530054004E0041004D0045000100000000001E00
      000045004D0050004C004F005900450045005F004E0055004D00420045005200
      0100000000000800000044004100540041000100000000001200000053005400
      41005200540044004100540045000100000000000E00000045004E0044004400
      41005400450001000000000016000000500052004F0047005200450053005300
      490056004F00010000000000}
    Left = 631
    Top = 134
    object selU165DiffDATA: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU165DiffPROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selU165DiffEMPLOYEE_NUMBER: TStringField
      DisplayLabel = 'Employee number'
      DisplayWidth = 10
      FieldName = 'EMPLOYEE_NUMBER'
      Size = 30
    end
    object selU165DiffLASTNAME: TStringField
      DisplayLabel = 'Last name'
      DisplayWidth = 30
      FieldName = 'LASTNAME'
      Size = 150
    end
    object selU165DiffFIRSTNAME: TStringField
      DisplayLabel = 'First name'
      DisplayWidth = 30
      FieldName = 'FIRSTNAME'
      Size = 150
    end
    object selU165DiffSTARTDATE: TDateTimeField
      DisplayLabel = 'Start date'
      DisplayWidth = 10
      FieldName = 'STARTDATE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU165DiffENDDATE: TDateTimeField
      DisplayLabel = 'End date'
      DisplayWidth = 10
      FieldName = 'ENDDATE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
  end
  object dsrU170Diff: TDataSource
    DataSet = selU170Diff
    Left = 695
    Top = 187
  end
  object selU170Diff: TOracleDataSet
    SQL.Strings = (
      'select DISTINCT t.*, U120.LASTNAME, U120.FIRSTNAME from'
      
        '((select :DataCorr DATA, progressivo, employee_number, address_t' +
        'ype, effectivedate, line1, line2, line3, line4, state, city, pos' +
        'talcode, country, countryisocode'
      '  from U170_UNJSPF_ADDRESS U170, U100_UNJSPF_TESTATE U100'
      ' where U170.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :Tipo'
      '   and U100.DATA_FINE_PERIODO = :DataCorr'
      'MINUS'
      
        'select :DataCorr DATA, progressivo, employee_number, address_typ' +
        'e, effectivedate, line1, line2, line3, line4, state, city, posta' +
        'lcode, country, countryisocode'
      '  from U170_UNJSPF_ADDRESS U170, U100_UNJSPF_TESTATE U100'
      ' where U170.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :Tipo'
      '   and U100.DATA_FINE_PERIODO = :DataPrec)'
      'UNION ALL'
      
        '(select :DataPrec DATA, progressivo, employee_number, address_ty' +
        'pe, effectivedate, line1, line2, line3, line4, state, city, post' +
        'alcode, country, countryisocode'
      '  from U170_UNJSPF_ADDRESS U170, U100_UNJSPF_TESTATE U100'
      ' where U170.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :TIPO'
      '   and U100.DATA_FINE_PERIODO = :DataPrec'
      'MINUS'
      
        'select :DataPrec DATA, progressivo, employee_number, address_typ' +
        'e, effectivedate, line1, line2, line3, line4, state, city, posta' +
        'lcode, country, countryisocode'
      '  from U170_UNJSPF_ADDRESS U170, U100_UNJSPF_TESTATE U100'
      ' where U170.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :TIPO'
      
        '   and U100.DATA_FINE_PERIODO = :DataCorr)) T, U120_UNJSPF_STAFF' +
        '_MEMBER U120, U100_UNJSPF_TESTATE U100'
      'where T.PROGRESSIVO = U120.PROGRESSIVO'
      '  and U120.ID_UNJSPF = U100.ID_UNJSPF'
      '  and U100.TIPO_FLUSSO = :TIPO'
      '  and U100.DATA_FINE_PERIODO = :DataCorr'
      
        'order by U120.LASTNAME, U120.FIRSTNAME, T.EMPLOYEE_NUMBER, T.DAT' +
        'A'
      '')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A005400490050004F0005000000000000000000
      0000120000003A00440041005400410043004F00520052000C00000000000000
      00000000120000003A00440041005400410050005200450043000C0000000000
      000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000001000000012000000460049005200530054004E0041004D0045000100
      00000000100000004C004100530054004E0041004D0045000100000000001E00
      000045004D0050004C004F005900450045005F004E0055004D00420045005200
      0100000000000800000044004100540041000100000000001800000041004400
      440052004500530053005F0054005900500045000100000000001A0000004500
      4600460045004300540049005600450044004100540045000100000000000A00
      00004C0049004E00450031000100000000000A0000004C0049004E0045003200
      0100000000000A0000004C0049004E00450033000100000000000A0000004C00
      49004E00450034000100000000000A0000005300540041005400450001000000
      00000800000043004900540059000100000000001400000050004F0053005400
      41004C0043004F00440045000100000000000E00000043004F0055004E005400
      520059000100000000001C00000043004F0055004E0054005200590049005300
      4F0043004F004400450001000000000016000000500052004F00470052004500
      53005300490056004F00010000000000}
    Left = 695
    Top = 134
    object selU170DiffDATA: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU170DiffPROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selU170DiffEMPLOYEE_NUMBER: TStringField
      DisplayLabel = 'Employee number'
      DisplayWidth = 10
      FieldName = 'EMPLOYEE_NUMBER'
      Size = 30
    end
    object selU170DiffLASTNAME: TStringField
      DisplayLabel = 'Last name'
      DisplayWidth = 30
      FieldName = 'LASTNAME'
      Size = 150
    end
    object selU170DiffFIRSTNAME: TStringField
      DisplayLabel = 'First name'
      DisplayWidth = 30
      FieldName = 'FIRSTNAME'
      Size = 150
    end
    object selU170DiffADDRESS_TYPE: TStringField
      DisplayLabel = 'Address type'
      DisplayWidth = 10
      FieldName = 'ADDRESS_TYPE'
      Size = 150
    end
    object selU170DiffEFFECTIVEDATE: TDateTimeField
      DisplayLabel = 'Effective date'
      DisplayWidth = 10
      FieldName = 'EFFECTIVEDATE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU170DiffLINE1: TStringField
      DisplayLabel = 'Line 1'
      DisplayWidth = 30
      FieldName = 'LINE1'
      Size = 240
    end
    object selU170DiffLINE2: TStringField
      DisplayLabel = 'Line 2'
      DisplayWidth = 10
      FieldName = 'LINE2'
      Size = 240
    end
    object selU170DiffLINE3: TStringField
      DisplayLabel = 'Line 3'
      DisplayWidth = 10
      FieldName = 'LINE3'
      Size = 240
    end
    object selU170DiffLINE4: TStringField
      DisplayLabel = 'Line 4'
      DisplayWidth = 10
      FieldName = 'LINE4'
      Size = 120
    end
    object selU170DiffSTATE: TStringField
      DisplayLabel = 'State'
      DisplayWidth = 10
      FieldName = 'STATE'
      Size = 120
    end
    object selU170DiffCITY: TStringField
      DisplayLabel = 'City'
      DisplayWidth = 20
      FieldName = 'CITY'
      Size = 30
    end
    object selU170DiffPOSTALCODE: TStringField
      DisplayLabel = 'Postal code'
      DisplayWidth = 10
      FieldName = 'POSTALCODE'
      Size = 30
    end
    object selU170DiffCOUNTRY: TStringField
      DisplayLabel = 'Country'
      DisplayWidth = 10
      FieldName = 'COUNTRY'
      Size = 80
    end
    object selU170DiffCOUNTRYISOCODE: TStringField
      DisplayLabel = 'Country ISO code'
      FieldName = 'COUNTRYISOCODE'
      Size = 3
    end
  end
  object dsrU175Diff: TDataSource
    DataSet = selU175Diff
    Left = 759
    Top = 187
  end
  object selU175Diff: TOracleDataSet
    SQL.Strings = (
      'select DISTINCT t.*, U120.LASTNAME, U120.FIRSTNAME from'
      
        '((select :DataCorr DATA, progressivo, employee_number, phone_typ' +
        'e, phone_number'
      '  from U175_UNJSPF_PHONES U175, U100_UNJSPF_TESTATE U100'
      ' where U175.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :Tipo'
      '   and U100.DATA_FINE_PERIODO = :DataCorr'
      'MINUS'
      
        'select :DataCorr DATA, progressivo, employee_number, phone_type,' +
        ' phone_number'
      '  from U175_UNJSPF_PHONES U175, U100_UNJSPF_TESTATE U100'
      ' where U175.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :Tipo'
      '   and U100.DATA_FINE_PERIODO = :DataPrec)'
      'UNION ALL'
      
        '(select :DataPrec DATA, progressivo, employee_number, phone_type' +
        ', phone_number'
      '  from U175_UNJSPF_PHONES U175, U100_UNJSPF_TESTATE U100'
      ' where U175.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :TIPO'
      '   and U100.DATA_FINE_PERIODO = :DataPrec'
      'MINUS'
      
        'select :DataPrec DATA, progressivo, employee_number, phone_type,' +
        ' phone_number'
      '  from U175_UNJSPF_PHONES U175, U100_UNJSPF_TESTATE U100'
      ' where U175.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :TIPO'
      
        '   and U100.DATA_FINE_PERIODO = :DataCorr)) T, U120_UNJSPF_STAFF' +
        '_MEMBER U120, U100_UNJSPF_TESTATE U100'
      'where T.PROGRESSIVO = U120.PROGRESSIVO'
      '  and U120.ID_UNJSPF = U100.ID_UNJSPF'
      '  and U100.TIPO_FLUSSO = :TIPO'
      '  and U100.DATA_FINE_PERIODO = :DataCorr'
      
        'order by U120.LASTNAME, U120.FIRSTNAME, T.EMPLOYEE_NUMBER, T.DAT' +
        'A'
      '')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A005400490050004F0005000000000000000000
      0000120000003A00440041005400410043004F00520052000C00000000000000
      00000000120000003A00440041005400410050005200450043000C0000000000
      000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000700000012000000460049005200530054004E0041004D0045000100
      00000000100000004C004100530054004E0041004D0045000100000000001E00
      000045004D0050004C004F005900450045005F004E0055004D00420045005200
      0100000000000800000044004100540041000100000000001400000050004800
      4F004E0045005F00540059005000450001000000000018000000500048004F00
      4E0045005F004E0055004D004200450052000100000000001600000050005200
      4F0047005200450053005300490056004F00010000000000}
    Left = 759
    Top = 134
    object selU175DiffDATA: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU175DiffPROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selU175DiffEMPLOYEE_NUMBER: TStringField
      DisplayLabel = 'Employee number'
      DisplayWidth = 10
      FieldName = 'EMPLOYEE_NUMBER'
      Size = 30
    end
    object selU175DiffLASTNAME: TStringField
      DisplayLabel = 'Last name'
      DisplayWidth = 30
      FieldName = 'LASTNAME'
      Size = 150
    end
    object selU175DiffFIRSTNAME: TStringField
      DisplayLabel = 'First name'
      DisplayWidth = 30
      FieldName = 'FIRSTNAME'
      Size = 150
    end
    object selU175DiffPHONE_TYPE: TStringField
      DisplayLabel = 'Phone type'
      DisplayWidth = 10
      FieldName = 'PHONE_TYPE'
      Size = 150
    end
    object selU175DiffPHONE_NUMBER: TStringField
      DisplayLabel = 'Phone number'
      DisplayWidth = 30
      FieldName = 'PHONE_NUMBER'
      Size = 60
    end
  end
  object selU180Diff: TOracleDataSet
    SQL.Strings = (
      'select DISTINCT t.*, U120.LASTNAME, U120.FIRSTNAME from'
      
        '((select :DataCorr DATA, progressivo, employee_number, type, ema' +
        'iladdress'
      '  from U180_UNJSPF_EMAILS U180, U100_UNJSPF_TESTATE U100'
      ' where U180.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :Tipo'
      '   and U100.DATA_FINE_PERIODO = :DataCorr'
      'MINUS'
      
        'select :DataCorr DATA, progressivo, employee_number, type, email' +
        'address'
      '  from U180_UNJSPF_EMAILS U180, U100_UNJSPF_TESTATE U100'
      ' where U180.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :Tipo'
      '   and U100.DATA_FINE_PERIODO = :DataPrec)'
      'UNION ALL'
      
        '(select :DataPrec DATA, progressivo, employee_number, type, emai' +
        'laddress'
      '  from U180_UNJSPF_EMAILS U180, U100_UNJSPF_TESTATE U100'
      ' where U180.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :TIPO'
      '   and U100.DATA_FINE_PERIODO = :DataPrec'
      'MINUS'
      
        'select :DataPrec DATA, progressivo, employee_number, type, email' +
        'address'
      '  from U180_UNJSPF_EMAILS U180, U100_UNJSPF_TESTATE U100'
      ' where U180.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :TIPO'
      
        '   and U100.DATA_FINE_PERIODO = :DataCorr)) T, U120_UNJSPF_STAFF' +
        '_MEMBER U120, U100_UNJSPF_TESTATE U100'
      'where T.PROGRESSIVO = U120.PROGRESSIVO'
      '  and U120.ID_UNJSPF = U100.ID_UNJSPF'
      '  and U100.TIPO_FLUSSO = :TIPO'
      '  and U100.DATA_FINE_PERIODO = :DataCorr'
      
        'order by U120.LASTNAME, U120.FIRSTNAME, T.EMPLOYEE_NUMBER, T.DAT' +
        'A'
      '')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A005400490050004F0005000000000000000000
      0000120000003A00440041005400410043004F00520052000C00000000000000
      00000000120000003A00440041005400410050005200450043000C0000000000
      000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000700000012000000460049005200530054004E0041004D0045000100
      00000000100000004C004100530054004E0041004D0045000100000000001E00
      000045004D0050004C004F005900450045005F004E0055004D00420045005200
      0100000000000800000044004100540041000100000000000800000054005900
      500045000100000000001800000045004D00410049004C004100440044005200
      45005300530001000000000016000000500052004F0047005200450053005300
      490056004F00010000000000}
    Left = 831
    Top = 134
    object selU180DiffDATA: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU180DiffPROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selU180DiffEMPLOYEE_NUMBER: TStringField
      DisplayLabel = 'Employee number'
      DisplayWidth = 10
      FieldName = 'EMPLOYEE_NUMBER'
      Size = 30
    end
    object selU180DiffLASTNAME: TStringField
      DisplayLabel = 'Last name'
      DisplayWidth = 30
      FieldName = 'LASTNAME'
      Size = 150
    end
    object selU180DiffFIRSTNAME: TStringField
      DisplayLabel = 'First name'
      DisplayWidth = 30
      FieldName = 'FIRSTNAME'
      Size = 150
    end
    object selU180DiffTYPE: TStringField
      DisplayLabel = 'Type'
      FieldName = 'TYPE'
      Size = 7
    end
    object selU180DiffEMAILADDRESS: TStringField
      DisplayLabel = 'E-mail address'
      DisplayWidth = 30
      FieldName = 'EMAILADDRESS'
      Size = 240
    end
  end
  object dsrU180Diff: TDataSource
    DataSet = selU180Diff
    Left = 831
    Top = 187
  end
  object dsrU190Diff: TDataSource
    DataSet = selU190Diff
    Left = 903
    Top = 187
  end
  object selU190Diff: TOracleDataSet
    SQL.Strings = (
      'select t.* from'
      
        '((select :DataCorr DATA, progressivo, employee_number, pension_n' +
        'umber, first_name, last_name, date_of_birth, '
      
        '         lwop_contrib_flag, category, grade, step, duty_station,' +
        ' parttime_percent, currency_code, transaction_type, '
      
        '         DECODE(transaction_type,'#39'Adjustment'#39',effective_start_da' +
        'te,null) effective_start_date, DECODE(transaction_type,'#39'Adjustme' +
        'nt'#39',effective_end_date,null) effective_end_date, '
      '         prrate_local_amount, language_allowancelocal_amount, '
      
        '         proratedratio, contribution_local_amountsm, contributio' +
        'n_local_amountorg, '
      '         adjustment_local_amountsm, adjustment_local_amountorg, '
      
        '         adjustment_local_amountfullsm, adjustment_local_amountf' +
        'ullorg,  '
      
        '         validation_amountsm, validation_amountorg, restoration_' +
        'amountsm, restoration_amountorg,'
      
        '         actuarial_costssm, actuarial_costsorg, interest_contrib' +
        'utionsm, interest_contributionorg, misc_adjustmentsm, misc_adjus' +
        'tmentorg'
      '  from U190_UNJSPF_PAY_TRAN U190, U100_UNJSPF_TESTATE U100'
      ' where U190.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :Tipo'
      '   and U100.DATA_FINE_PERIODO = :DataCorr'
      'MINUS'
      
        'select :DataCorr DATA, progressivo, employee_number, pension_num' +
        'ber, first_name, last_name, date_of_birth, '
      
        '         lwop_contrib_flag, category, grade, step, duty_station,' +
        ' parttime_percent, currency_code, transaction_type, '
      
        '         DECODE(transaction_type,'#39'Adjustment'#39',effective_start_da' +
        'te,null) effective_start_date, DECODE(transaction_type,'#39'Adjustme' +
        'nt'#39',effective_end_date,null) effective_end_date, '
      '         prrate_local_amount, language_allowancelocal_amount, '
      
        '         proratedratio, contribution_local_amountsm, contributio' +
        'n_local_amountorg, '
      '         adjustment_local_amountsm, adjustment_local_amountorg, '
      
        '         adjustment_local_amountfullsm, adjustment_local_amountf' +
        'ullorg,  '
      
        '         validation_amountsm, validation_amountorg, restoration_' +
        'amountsm, restoration_amountorg,'
      
        '         actuarial_costssm, actuarial_costsorg, interest_contrib' +
        'utionsm, interest_contributionorg, misc_adjustmentsm, misc_adjus' +
        'tmentorg'
      '  from U190_UNJSPF_PAY_TRAN U190, U100_UNJSPF_TESTATE U100'
      ' where U190.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :Tipo'
      '   and U100.DATA_FINE_PERIODO = :DataPrec)'
      'UNION ALL'
      
        '(select :DataPrec DATA, progressivo, employee_number, pension_nu' +
        'mber, first_name, last_name, date_of_birth, '
      
        '         lwop_contrib_flag, category, grade, step, duty_station,' +
        ' parttime_percent, currency_code, transaction_type, '
      
        '         DECODE(transaction_type,'#39'Adjustment'#39',effective_start_da' +
        'te,null) effective_start_date, DECODE(transaction_type,'#39'Adjustme' +
        'nt'#39',effective_end_date,null) effective_end_date, '
      '         prrate_local_amount, language_allowancelocal_amount, '
      
        '         proratedratio, contribution_local_amountsm, contributio' +
        'n_local_amountorg, '
      '         adjustment_local_amountsm, adjustment_local_amountorg, '
      
        '         adjustment_local_amountfullsm, adjustment_local_amountf' +
        'ullorg,  '
      
        '         validation_amountsm, validation_amountorg, restoration_' +
        'amountsm, restoration_amountorg,'
      
        '         actuarial_costssm, actuarial_costsorg, interest_contrib' +
        'utionsm, interest_contributionorg, misc_adjustmentsm, misc_adjus' +
        'tmentorg'
      '  from U190_UNJSPF_PAY_TRAN U190, U100_UNJSPF_TESTATE U100'
      ' where U190.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :TIPO'
      '   and U100.DATA_FINE_PERIODO = :DataPrec'
      'MINUS'
      
        'select :DataPrec DATA, progressivo, employee_number, pension_num' +
        'ber, first_name, last_name, date_of_birth, '
      
        '         lwop_contrib_flag, category, grade, step, duty_station,' +
        ' parttime_percent, currency_code, transaction_type, '
      
        '         DECODE(transaction_type,'#39'Adjustment'#39',effective_start_da' +
        'te,null) effective_start_date, DECODE(transaction_type,'#39'Adjustme' +
        'nt'#39',effective_end_date,null) effective_end_date, '
      '         prrate_local_amount, language_allowancelocal_amount, '
      
        '         proratedratio, contribution_local_amountsm, contributio' +
        'n_local_amountorg, '
      '         adjustment_local_amountsm, adjustment_local_amountorg, '
      
        '         adjustment_local_amountfullsm, adjustment_local_amountf' +
        'ullorg,  '
      
        '         validation_amountsm, validation_amountorg, restoration_' +
        'amountsm, restoration_amountorg,'
      
        '         actuarial_costssm, actuarial_costsorg, interest_contrib' +
        'utionsm, interest_contributionorg, misc_adjustmentsm, misc_adjus' +
        'tmentorg'
      '  from U190_UNJSPF_PAY_TRAN U190, U100_UNJSPF_TESTATE U100'
      ' where U190.ID_UNJSPF = U100.ID_UNJSPF'
      '   and U100.TIPO_FLUSSO = :TIPO'
      '   and U100.DATA_FINE_PERIODO = :DataCorr)) T'
      
        'order by T.LAST_NAME, T.FIRST_NAME, T.EMPLOYEE_NUMBER, T.DATA, T' +
        '.TRANSACTION_TYPE, T.EFFECTIVE_START_DATE, T.EFFECTIVE_END_DATE')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A005400490050004F0005000000000000000000
      0000120000003A00440041005400410043004F00520052000C00000000000000
      00000000120000003A00440041005400410050005200450043000C0000000000
      000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000240000001E00000045004D0050004C004F005900450045005F004E00
      55004D0042004500520001000000000008000000440041005400410001000000
      000016000000500052004F0047005200450053005300490056004F0001000000
      00001C000000500045004E00530049004F004E005F004E0055004D0042004500
      520001000000000014000000460049005200530054005F004E0041004D004500
      010000000000120000004C004100530054005F004E0041004D00450001000000
      00001A00000044004100540045005F004F0046005F0042004900520054004800
      010000000000220000004C0057004F0050005F0043004F004E00540052004900
      42005F0046004C00410047000100000000001000000043004100540045004700
      4F00520059000100000000000A00000047005200410044004500010000000000
      0800000053005400450050000100000000001800000044005500540059005F00
      530054004100540049004F004E00010000000000200000005000410052005400
      540049004D0045005F00500045005200430045004E0054000100000000001A00
      0000430055005200520045004E00430059005F0043004F004400450001000000
      0000200000005400520041004E00530041004300540049004F004E005F005400
      5900500045000100000000002800000045004600460045004300540049005600
      45005F00530054004100520054005F0044004100540045000100000000002400
      00004500460046004500430054004900560045005F0045004E0044005F004400
      410054004500010000000000260000005000520052004100540045005F004C00
      4F00430041004C005F0041004D004F0055004E0054000100000000003C000000
      4C0041004E00470055004100470045005F0041004C004C004F00570041004E00
      430045004C004F00430041004C005F0041004D004F0055004E00540001000000
      00001A000000500052004F005200410054004500440052004100540049004F00
      0100000000003600000043004F004E0054005200490042005500540049004F00
      4E005F004C004F00430041004C005F0041004D004F0055004E00540053004D00
      0100000000003800000043004F004E0054005200490042005500540049004F00
      4E005F004C004F00430041004C005F0041004D004F0055004E0054004F005200
      470001000000000032000000410044004A005500530054004D0045004E005400
      5F004C004F00430041004C005F0041004D004F0055004E00540053004D000100
      0000000034000000410044004A005500530054004D0045004E0054005F004C00
      4F00430041004C005F0041004D004F0055004E0054004F005200470001000000
      00003A000000410044004A005500530054004D0045004E0054005F004C004F00
      430041004C005F0041004D004F0055004E005400460055004C004C0053004D00
      0100000000003C000000410044004A005500530054004D0045004E0054005F00
      4C004F00430041004C005F0041004D004F0055004E005400460055004C004C00
      4F005200470001000000000026000000560041004C0049004400410054004900
      4F004E005F0041004D004F0055004E00540053004D0001000000000028000000
      560041004C00490044004100540049004F004E005F0041004D004F0055004E00
      54004F00520047000100000000002800000052004500530054004F0052004100
      540049004F004E005F0041004D004F0055004E00540053004D00010000000000
      2A00000052004500530054004F0052004100540049004F004E005F0041004D00
      4F0055004E0054004F0052004700010000000000220000004100430054005500
      41005200490041004C005F0043004F0053005400530053004D00010000000000
      24000000410043005400550041005200490041004C005F0043004F0053005400
      53004F00520047000100000000002E00000049004E0054004500520045005300
      54005F0043004F004E0054005200490042005500540049004F004E0053004D00
      0100000000003000000049004E005400450052004500530054005F0043004F00
      4E0054005200490042005500540049004F004E004F0052004700010000000000
      220000004D004900530043005F00410044004A005500530054004D0045004E00
      540053004D00010000000000240000004D004900530043005F00410044004A00
      5500530054004D0045004E0054004F0052004700010000000000}
    Left = 903
    Top = 134
    object selU190DiffDATA: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU190DiffPROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selU190DiffEMPLOYEE_NUMBER: TStringField
      DisplayLabel = 'Employee number'
      DisplayWidth = 10
      FieldName = 'EMPLOYEE_NUMBER'
      Size = 30
    end
    object selU190DiffLAST_NAME: TStringField
      DisplayLabel = 'Last name'
      DisplayWidth = 30
      FieldName = 'LAST_NAME'
      Size = 150
    end
    object selU190DiffFIRST_NAME: TStringField
      DisplayLabel = 'First name'
      DisplayWidth = 30
      FieldName = 'FIRST_NAME'
      Size = 150
    end
    object selU190DiffPENSION_NUMBER: TStringField
      DisplayLabel = 'Pension number'
      DisplayWidth = 10
      FieldName = 'PENSION_NUMBER'
      Size = 150
    end
    object selU190DiffDATE_OF_BIRTH: TDateTimeField
      DisplayLabel = 'Date of birth'
      DisplayWidth = 10
      FieldName = 'DATE_OF_BIRTH'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU190DiffLWOP_CONTRIB_FLAG: TStringField
      DisplayLabel = 'LWOP Contrib.'
      FieldName = 'LWOP_CONTRIB_FLAG'
      Size = 10
    end
    object selU190DiffCATEGORY: TStringField
      DisplayLabel = 'Category'
      DisplayWidth = 10
      FieldName = 'CATEGORY'
      Size = 80
    end
    object selU190DiffGRADE: TStringField
      DisplayLabel = 'Grade'
      DisplayWidth = 10
      FieldName = 'GRADE'
      Size = 80
    end
    object selU190DiffSTEP: TStringField
      DisplayLabel = 'Step'
      FieldName = 'STEP'
      Size = 10
    end
    object selU190DiffDUTY_STATION: TStringField
      DisplayLabel = 'Duty station'
      DisplayWidth = 10
      FieldName = 'DUTY_STATION'
      Size = 100
    end
    object selU190DiffPARTTIME_PERCENT: TFloatField
      DisplayLabel = 'Parttime percent'
      FieldName = 'PARTTIME_PERCENT'
    end
    object selU190DiffCURRENCY_CODE: TStringField
      DisplayLabel = 'Currency code'
      DisplayWidth = 10
      FieldName = 'CURRENCY_CODE'
      Size = 30
    end
    object selU190DiffTRANSACTION_TYPE: TStringField
      DisplayLabel = 'Transaction type'
      DisplayWidth = 10
      FieldName = 'TRANSACTION_TYPE'
      Size = 60
    end
    object selU190DiffEFFECTIVE_START_DATE: TDateTimeField
      DisplayLabel = 'Effective start date'
      DisplayWidth = 10
      FieldName = 'EFFECTIVE_START_DATE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU190DiffEFFECTIVE_END_DATE: TDateTimeField
      DisplayLabel = 'Effective end date'
      DisplayWidth = 10
      FieldName = 'EFFECTIVE_END_DATE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selU190DiffPRRATE_LOCAL_AMOUNT: TFloatField
      DisplayLabel = 'Prrate local amount'
      FieldName = 'PRRATE_LOCAL_AMOUNT'
    end
    object selU190DiffLANGUAGE_ALLOWANCELOCAL_AMOUNT: TFloatField
      DisplayLabel = 'Language allowance local amount'
      FieldName = 'LANGUAGE_ALLOWANCELOCAL_AMOUNT'
    end
    object selU190DiffPRORATEDRATIO: TFloatField
      DisplayLabel = 'Pro rated ratio'
      FieldName = 'PRORATEDRATIO'
    end
    object selU190DiffCONTRIBUTION_LOCAL_AMOUNTSM: TFloatField
      DisplayLabel = 'Contribution local amount SM'
      FieldName = 'CONTRIBUTION_LOCAL_AMOUNTSM'
    end
    object selU190DiffCONTRIBUTION_LOCAL_AMOUNTORG: TFloatField
      DisplayLabel = 'Contribution local amount Org'
      FieldName = 'CONTRIBUTION_LOCAL_AMOUNTORG'
    end
    object selU190DiffADJUSTMENT_LOCAL_AMOUNTSM: TFloatField
      DisplayLabel = 'Adjustment local amount SM'
      FieldName = 'ADJUSTMENT_LOCAL_AMOUNTSM'
    end
    object selU190DiffADJUSTMENT_LOCAL_AMOUNTORG: TFloatField
      DisplayLabel = 'Adjustment local amount Org'
      FieldName = 'ADJUSTMENT_LOCAL_AMOUNTORG'
    end
    object selU190DiffADJUSTMENT_LOCAL_AMOUNTFULLSM: TFloatField
      DisplayLabel = 'Adjustment local amount full SM'
      FieldName = 'ADJUSTMENT_LOCAL_AMOUNTFULLSM'
    end
    object selU190DiffADJUSTMENT_LOCAL_AMOUNTFULLORG: TFloatField
      DisplayLabel = 'Adjustment local amount full Org'
      FieldName = 'ADJUSTMENT_LOCAL_AMOUNTFULLORG'
    end
    object selU190DiffVALIDATION_AMOUNTSM: TFloatField
      DisplayLabel = 'Validation amount SM'
      FieldName = 'VALIDATION_AMOUNTSM'
    end
    object selU190DiffVALIDATION_AMOUNTORG: TFloatField
      DisplayLabel = 'Validation amount Org'
      FieldName = 'VALIDATION_AMOUNTORG'
    end
    object selU190DiffRESTORATION_AMOUNTSM: TFloatField
      DisplayLabel = 'Restoration amount SM'
      FieldName = 'RESTORATION_AMOUNTSM'
    end
    object selU190DiffRESTORATION_AMOUNTORG: TFloatField
      DisplayLabel = 'Restoration amount Org'
      FieldName = 'RESTORATION_AMOUNTORG'
    end
    object selU190DiffACTUARIAL_COSTSSM: TFloatField
      DisplayLabel = 'Actuarial costs SM'
      FieldName = 'ACTUARIAL_COSTSSM'
    end
    object selU190DiffACTUARIAL_COSTSORG: TFloatField
      DisplayLabel = 'Actuarial costs Org'
      FieldName = 'ACTUARIAL_COSTSORG'
    end
    object selU190DiffINTEREST_CONTRIBUTIONSM: TFloatField
      DisplayLabel = 'Interest contributions SM'
      FieldName = 'INTEREST_CONTRIBUTIONSM'
    end
    object selU190DiffINTEREST_CONTRIBUTIONORG: TFloatField
      DisplayLabel = 'Interest contributions Org'
      FieldName = 'INTEREST_CONTRIBUTIONORG'
    end
    object selU190DiffMISC_ADJUSTMENTSM: TFloatField
      DisplayLabel = 'Misc adjustments SM'
      FieldName = 'MISC_ADJUSTMENTSM'
    end
    object selU190DiffMISC_ADJUSTMENTORG: TFloatField
      DisplayLabel = 'Misc adjustments Org'
      FieldName = 'MISC_ADJUSTMENTORG'
    end
  end
end
