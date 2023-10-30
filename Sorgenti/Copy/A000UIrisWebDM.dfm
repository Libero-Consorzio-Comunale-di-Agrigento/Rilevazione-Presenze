inherited A000FIrisWebDM: TA000FIrisWebDM
  OldCreateOrder = True
  Height = 478
  Width = 872
  inherited selaT033: TOracleDataSet
    Left = 256
  end
  inherited selAnagrafe: TOracleDataSet
    Left = 28
    Top = 8
  end
  inherited selI091: TOracleDataSet
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004E004400410005000000
      05000000415A494E0000000000}
  end
  object cdsT950Int: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 336
    Top = 248
  end
  object IdSMTP: TIdSMTP
    SASLMechanisms = <>
    Left = 65
    Top = 308
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
    Left = 61
    Top = 356
  end
  object selI081: TOracleDataSet
    SQL.Strings = (
      'select TAG '
      'from MONDOEDP.I081_FUNZIONI_ABILITATE'
      'where APPLICAZIONE = '#39'IRIS_CLOUD'#39)
    ReadBuffer = 50
    Optimize = False
    Left = 384
    Top = 8
  end
end
