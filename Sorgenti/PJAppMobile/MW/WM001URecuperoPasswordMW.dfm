inherited WM001FRecuperoPasswordMW: TWM001FRecuperoPasswordMW
  OldCreateOrder = True
  Height = 191
  Width = 264
  object QI090: TOracleDataSet
    SQL.Strings = (
      'SELECT * '
      '  FROM I090_ENTI '
      ' WHERE UPPER(AZIENDA) = UPPER(:AZIENDA)')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    Left = 13
    Top = 16
  end
  object QI091: TOracleDataSet
    SQL.Strings = (
      'SELECT TIPO,DATO '
      '  FROM I091_DATIENTE '
      ' WHERE AZIENDA = :AZIENDA')
    ReadBuffer = 150
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004E004400410005000000
      05000000415A494E0000000000}
    Left = 61
    Top = 16
  end
  object QI060: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM I060_LOGIN_DIPENDENTE '
      'WHERE  AZIENDA = :AZIENDA '
      '--AND    NOME_UTENTE = :UTENTE'
      'AND    UPPER(NOME_UTENTE ) = UPPER(:UTENTE)')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      00000000000000000E0000003A005500540045004E0054004500050000000000
      000000000000}
    Left = 111
    Top = 16
  end
  object IdSMTP: TIdSMTP
    SASLMechanisms = <>
    Left = 15
    Top = 86
  end
  object IdMessage: TIdMessage
    AttachmentEncoding = 'MIME'
    BccList = <>
    CCList = <>
    Encoding = meMIME
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 64
    Top = 87
  end
  object IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 176
    Top = 87
  end
  object selDistAzienda: TOracleDataSet
    SQL.Strings = (
      'SELECT I090.AZIENDA '
      'FROM   I090_ENTI I090, '
      '       I060_LOGIN_DIPENDENTE I060'
      'WHERE  I090.AZIENDA = I060.AZIENDA '
      'AND    I090.LOGIN_DIP_ABILITATO = '#39'S'#39
      'AND    :I060 = '#39'S'#39
      'AND    UPPER(I060.NOME_UTENTE) = UPPER(:UTENTE)'
      'UNION'
      'SELECT I090.AZIENDA'
      'FROM   I090_ENTI I090, '
      '       I070_UTENTI I070'
      'WHERE  I090.AZIENDA = I070.AZIENDA '
      'AND    I090.LOGIN_USR_ABILITATO = '#39'S'#39
      'AND    UPPER(I070.UTENTE) = UPPER(:UTENTE)'
      'ORDER BY 1')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A005500540045004E0054004500050000000000
      0000000000000A0000003A004900300036003000050000000000000000000000}
    Left = 173
    Top = 14
  end
end
