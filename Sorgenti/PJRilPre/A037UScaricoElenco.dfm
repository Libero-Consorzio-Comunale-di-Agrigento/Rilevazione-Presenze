object A033FElenco: TA033FElenco
  Left = 198
  Top = 131
  Width = 247
  Height = 300
  Caption = 'Anomalie di 1° livello'
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 247
    Width = 239
    Height = 26
    Align = alBottom
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 0
      Top = 0
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkOK
    end
  end
  object Anomalie1: TCheckListBox
    Left = 0
    Top = 0
    Width = 239
    Height = 57
    ItemHeight = 13
    TabOrder = 1
  end
  object Anomalie2: TCheckListBox
    Left = 0
    Top = 64
    Width = 239
    Height = 57
    ItemHeight = 13
    TabOrder = 2
  end
  object Anomalie3: TCheckListBox
    Left = 0
    Top = 128
    Width = 239
    Height = 57
    ItemHeight = 13
    TabOrder = 3
  end
end
