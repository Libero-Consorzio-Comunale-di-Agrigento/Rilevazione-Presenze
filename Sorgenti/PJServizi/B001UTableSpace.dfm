object B001FTableSpace: TB001FTableSpace
  Left = 56
  Top = 123
  Width = 256
  Height = 129
  Caption = 'Table spaces Oracle'
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 14
    Top = 8
    Width = 124
    Height = 13
    Caption = 'TableSpace per le tabelle:'
  end
  object Label2: TLabel
    Left = 14
    Top = 52
    Width = 119
    Height = 13
    Caption = 'TableSpace per gli indici:'
  end
  object Edit1: TEdit
    Left = 14
    Top = 24
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'LAVORO'
  end
  object Edit2: TEdit
    Left = 14
    Top = 68
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'INDICI'
  end
  object BitBtn1: TBitBtn
    Left = 158
    Top = 22
    Width = 75
    Height = 25
    TabOrder = 2
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 158
    Top = 66
    Width = 75
    Height = 25
    TabOrder = 3
    Kind = bkCancel
  end
end
