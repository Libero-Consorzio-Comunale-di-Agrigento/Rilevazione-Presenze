object A003FDataLavoro: TA003FDataLavoro
  Left = 193
  Top = 149
  HelpContext = 200
  BorderStyle = bsDialog
  Caption = 'Data di lavoro'
  ClientHeight = 147
  ClientWidth = 273
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Calendar1: TCalendar
    Left = 0
    Top = 25
    Width = 273
    Height = 92
    HelpContext = 200
    Align = alTop
    BorderStyle = bsNone
    StartOfWeek = 1
    TabOrder = 0
    UseCurrentDate = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 273
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 4
      Width = 28
      Height = 13
      Caption = 'Anno:'
    end
    object Label2: TLabel
      Left = 104
      Top = 4
      Width = 29
      Height = 13
      Caption = 'Mese:'
    end
    object Lab_Mese: TLabel
      Left = 200
      Top = 4
      Width = 48
      Height = 13
      Caption = 'Gennaio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Anno: TSpinEdit
      Left = 40
      Top = -1
      Width = 57
      Height = 22
      HelpContext = 200
      MaxLength = 4
      MaxValue = 9999
      MinValue = 0
      TabOrder = 0
      Value = 0
      OnChange = AnnoChange
    end
    object Mese: TSpinEdit
      Left = 136
      Top = -1
      Width = 57
      Height = 22
      HelpContext = 200
      MaxLength = 2
      MaxValue = 12
      MinValue = 1
      TabOrder = 1
      Value = 1
      OnChange = MeseChange
    end
  end
  object BitBtn1: TBitBtn
    Left = 0
    Top = 120
    Width = 75
    Height = 25
    HelpContext = 200
    TabOrder = 2
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 84
    Top = 120
    Width = 75
    Height = 25
    HelpContext = 200
    TabOrder = 3
    Kind = bkCancel
  end
end
