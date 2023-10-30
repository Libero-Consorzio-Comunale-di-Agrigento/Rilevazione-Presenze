object B026FArchiviazioneCartelliniSrv: TB026FArchiviazioneCartelliniSrv
  OldCreateOrder = False
  OnCreate = ServiceCreate
  OnDestroy = ServiceDestroy
  DisplayName = 'B026FArchiviazioneCartelliniSrv'
  StartType = stManual
  OnExecute = ServiceExecute
  OnStart = ServiceStart
  Height = 216
  Width = 458
  object SessioneMondoEDP: TOracleSession
    Preferences.ConvertUTF = cuUTF8ToUTF16
    Left = 40
    Top = 104
  end
  object selT941: TOracleDataSet
    SQL.Strings = (
      
        'select T941.*,I090.UTENTE I090UTENTE,I090.PAROLACHIAVE I090PAROL' +
        'ACHIAVE '
      
        'from MONDOEDP.T941_SCHEDULAZIONI_B026 T941, MONDOEDP.I090_ENTI I' +
        '090'
      'where sysdate between T941.DAL and T941.AL'
      'and T941.AZIENDA = I090.AZIENDA'
      'order by ORDINE')
    Optimize = False
    Session = SessioneMondoEDP
    Left = 136
    Top = 104
  end
  object IdSMTP: TIdSMTP
    SASLMechanisms = <>
    Left = 15
    Top = 14
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
    Left = 80
    Top = 15
  end
  object IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 208
    Top = 15
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
    Session = SessioneMondoEDP
    Left = 213
    Top = 104
  end
end
