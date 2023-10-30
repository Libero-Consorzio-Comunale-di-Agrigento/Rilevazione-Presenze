inherited A181FAziendeMW: TA181FAziendeMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 326
  Width = 577
  object insI091: TOracleQuery
    SQL.Strings = (
      'INSERT INTO MONDOEDP.I091_DATIENTE '
      '(AZIENDA, ORDINE, TIPO) '
      'VALUES '
      '(:AZIENDA, :ORDINE, :TIPO) '
      '')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000003000000100000003A0041005A00490045004E004400410005000000
      00000000000000000A0000003A005400490050004F0005000000000000000000
      00000E0000003A004F005200440049004E004500030000000000000000000000}
    Left = 205
    Top = 12
  end
  object scrdelI090: TOracleQuery
    SQL.Strings = (
      'begin'
      '  delete mondoedp.i091_datiente where azienda = :azienda;'
      '  delete mondoedp.i092_logtabelle where azienda = :azienda;'
      '  --delete mondoedp.i070_utenti where azienda = :azienda;'
      '  --delete mondoedp.i071_permessi where azienda = :azienda;'
      
        '  --delete mondoedp.i072_filtroanagrafe where azienda = :azienda' +
        ';'
      
        '  --delete mondoedp.i073_filtrofunzioni where azienda = :azienda' +
        ';'
      
        '  --delete mondoedp.i074_filtrodizionario where azienda = :azien' +
        'da;'
      
        '  --delete mondoedp.i060_login_dipendente where azienda = :azien' +
        'da;'
      
        '  --delete mondoedp.i061_profili_dipendente where azienda = :azi' +
        'enda;'
      'end;')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    Left = 30
    Top = 12
  end
  object scrupdI090: TOracleQuery
    SQL.Strings = (
      'begin'
      
        '  update mondoedp.i091_datiente set azienda = :azienda_new where' +
        ' azienda = :azienda_old;'
      
        '  update mondoedp.i092_logtabelle set azienda = :azienda_new whe' +
        're azienda = :azienda_old;'
      
        '  update mondoedp.i070_utenti set azienda = :azienda_new where a' +
        'zienda = :azienda_old;'
      
        '  update mondoedp.i071_permessi set azienda = :azienda_new where' +
        ' azienda = :azienda_old;'
      
        '  update mondoedp.i072_filtroanagrafe set azienda = :azienda_new' +
        ' where azienda = :azienda_old;'
      
        '  update mondoedp.i073_filtrofunzioni set azienda = :azienda_new' +
        ' where azienda = :azienda_old;'
      
        '  update mondoedp.i074_filtrodizionario set azienda = :azienda_n' +
        'ew where azienda = :azienda_old;'
      
        '  update mondoedp.i060_login_dipendente set azienda = :azienda_n' +
        'ew where azienda = :azienda_old;'
      
        '  update mondoedp.i061_profili_dipendente set azienda = :azienda' +
        '_new where azienda = :azienda_old;'
      'end;')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A0041005A00490045004E00440041005F004E00
      45005700050000000000000000000000180000003A0041005A00490045004E00
      440041005F004F004C004400050000000000000000000000}
    Left = 94
    Top = 12
  end
  object IdSMTP: TIdSMTP
    SASLMechanisms = <>
    Left = 24
    Top = 192
  end
  object IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 128
    Top = 192
  end
  object IdMessage: TIdMessage
    AttachmentEncoding = 'UUE'
    BccList = <>
    CCList = <>
    Encoding = meDefault
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 241
    Top = 191
  end
  object QI091: TOracleDataSet
    SQL.Strings = (
      'select I091.*, I091.ROWID '
      '  from MONDOEDP.I091_DATIENTE I091 '
      ' where I091.AZIENDA = :AZIENDA'
      ' order by instr(I091.TIPO,'#39'_'#39'), ORDINE, TIPO')
    ReadBuffer = 250
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004E004400410005000000
      05000000415A494E0000000000}
    Filtered = True
    BeforeInsert = QI091BeforeDelete
    BeforePost = QI091BeforePost
    AfterPost = QI091AfterPost
    BeforeDelete = QI091BeforeDelete
    AfterDelete = QI091AfterDelete
    AfterScroll = QI091AfterScroll
    OnCalcFields = QI091CalcFields
    OnFilterRecord = QI091FilterRecord
    Left = 149
    Top = 12
    object QI091AZIENDA: TStringField
      FieldName = 'AZIENDA'
      Origin = 'I091_DATIENTE.AZIENDA'
      Visible = False
      Size = 30
    end
    object QI091Gruppo: TStringField
      FieldKind = fkCalculated
      FieldName = 'Gruppo'
      ReadOnly = True
      Calculated = True
    end
    object QI091TIPO: TStringField
      FieldName = 'TIPO'
      Origin = 'I091_DATIENTE.TIPO'
      ReadOnly = True
      Visible = False
      Size = 40
    end
    object QI091D_Tipo: TStringField
      DisplayLabel = 'Tipo Dato'
      DisplayWidth = 50
      FieldKind = fkCalculated
      FieldName = 'D_Tipo'
      ReadOnly = True
      Size = 80
      Calculated = True
    end
    object QI091DATO: TStringField
      DisplayLabel = 'Valore'
      DisplayWidth = 200
      FieldName = 'DATO'
      Origin = 'I091_DATIENTE.DATO'
      OnGetText = QI091DATOGetText
      OnSetText = QI091DATOSetText
      Size = 2000
    end
  end
  object QCOLS: TOracleDataSet
    SQL.Strings = (
      'SELECT COLUMN_NAME FROM COLS '
      'WHERE TABLE_NAME = '#39'T430_STORICO'#39
      'ORDER BY COLUMN_NAME')
    ReadBuffer = 200
    Optimize = False
    Left = 28
    Top = 70
  end
  object selDizionario: TOracleDataSet
    ReadBuffer = 1000
    Optimize = False
    BeforeOpen = selDizionarioBeforeOpen
    Left = 84
    Top = 70
  end
  object DBMondoedp: TOracleSession
    Preferences.ConvertUTF = cuUTF8ToUTF16
    Left = 26
    Top = 126
  end
  object scrI092: TOracleQuery
    ReadBuffer = 1
    Optimize = False
    Left = 261
    Top = 12
  end
  object selI091Dato: TOracleQuery
    SQL.Strings = (
      'select DATO'
      '  from MONDOEDP.I091_DATIENTE'
      ' where AZIENDA = :AZIENDA '
      '   and TIPO = :TIPO')
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      00000000000000000A0000003A005400490050004F0005000000000000000000
      0000}
    Left = 152
    Top = 72
  end
end
