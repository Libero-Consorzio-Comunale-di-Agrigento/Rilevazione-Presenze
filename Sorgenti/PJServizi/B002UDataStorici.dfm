object B002FDataStorici: TB002FDataStorici
  Left = 59
  Top = 173
  Width = 435
  Height = 169
  Caption = 'Aggiornamento dati anagrafici storicizzati'
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object RGStorici: TRadioGroup
    Left = 0
    Top = 0
    Width = 427
    Height = 105
    Align = alTop
    ItemIndex = 0
    Items.Strings = (
      'Aggiornamento ultimo movimento storico'
      'Aggiornamento movimento storico con data compresa'
      'Creazione movimento storico con decorrenza specificata')
    TabOrder = 0
  end
  object Button1: TButton
    Left = 0
    Top = 106
    Width = 111
    Height = 25
    Caption = 'Data di riferimento...'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 112
    Top = 108
    Width = 85
    Height = 21
    ReadOnly = True
    TabOrder = 2
    Text = 'Edit1'
  end
  object BitBtn1: TBitBtn
    Left = 238
    Top = 106
    Width = 75
    Height = 25
    TabOrder = 3
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 316
    Top = 106
    Width = 75
    Height = 25
    TabOrder = 4
    Kind = bkCancel
  end
end
