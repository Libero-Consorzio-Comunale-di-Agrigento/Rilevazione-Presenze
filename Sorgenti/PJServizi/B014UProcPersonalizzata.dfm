object B014FProcPersonalizzata: TB014FProcPersonalizzata
  Left = 0
  Top = 0
  Width = 475
  Height = 399
  Caption = '<B014> Procedura B014Personalizzata'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 467
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 10
      Width = 42
      Height = 13
      Caption = 'Azienda:'
    end
    object dcmbAzienda: TDBLookupComboBox
      Left = 68
      Top = 6
      Width = 145
      Height = 21
      KeyField = 'AZIENDA'
      ListField = 'AZIENDA'
      ListSource = B014FMonitorIntegrazioneDtM.dsrI090
      TabOrder = 0
    end
    object Button1: TButton
      Left = 224
      Top = 4
      Width = 75
      Height = 25
      Caption = 'Visualizza'
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 41
    Width = 467
    Height = 331
    Align = alClient
    ReadOnly = True
    TabOrder = 1
  end
end
