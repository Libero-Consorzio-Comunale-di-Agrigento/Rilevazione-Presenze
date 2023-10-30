object B027FCartellinoSrv: TB027FCartellinoSrv
  OldCreateOrder = False
  DisplayName = 'B027FCartellinoSrv'
  StartType = stManual
  OnExecute = ServiceExecute
  OnStart = ServiceStart
  Height = 133
  Width = 224
  object IdSMTP: TIdSMTP
    SASLMechanisms = <>
    Left = 24
    Top = 4
  end
  object IdAntiFreeze1: TIdAntiFreeze
    Left = 80
    Top = 4
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
    Left = 144
    Top = 4
  end
  object selT940: TOracleDataSet
    SQL.Strings = (
      
        'select T940.*,I090.UTENTE I090UTENTE,I090.PAROLACHIAVE I090PAROL' +
        'ACHIAVE '
      
        'from MONDOEDP.T940_SCHEDULAZIONI_B027 T940, MONDOEDP.I090_ENTI I' +
        '090'
      'where trunc(sysdate) between T940.DAL and T940.AL'
      'and T940.AZIENDA = I090.AZIENDA'
      'order by ORDINE')
    Optimize = False
    Session = SessioneMondoEDP
    Left = 144
    Top = 61
  end
  object SessioneMondoEDP: TOracleSession
    Preferences.ConvertUTF = cuUTF8ToUTF16
    Left = 72
    Top = 64
  end
end
