object B002FCampiChiave: TB002FCampiChiave
  Left = 83
  Top = 125
  Width = 435
  Height = 300
  Caption = 'Specificazione campi chiave'
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 78
    Top = 6
    Width = 79
    Height = 13
    Caption = 'Tabella sorgente'
  end
  object Label2: TLabel
    Left = 212
    Top = 6
    Width = 92
    Height = 13
    Caption = 'Tabella destinataria'
  end
  object Label3: TLabel
    Left = 50
    Top = 132
    Width = 20
    Height = 13
    Caption = 'Link'
  end
  object ListBox5: TListBox
    Left = 211
    Top = 22
    Width = 110
    Height = 105
    Font.Color = clOlive
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    TabOrder = 0
    OnDblClick = ListBox5DblClick
    OnDragDrop = ListBox5DragDrop
    OnDragOver = ListBox5DragOver
  end
  object ListBox1: TListBox
    Left = 75
    Top = 22
    Width = 110
    Height = 105
    DragMode = dmAutomatic
    Font.Color = clOlive
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    TabOrder = 1
    OnDblClick = ListBox5DblClick
  end
  object ListBox2: TListBox
    Left = 74
    Top = 130
    Width = 247
    Height = 105
    Font.Color = clOlive
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    TabOrder = 2
    OnDblClick = ListBox2DblClick
  end
  object BitBtn1: TBitBtn
    Left = 324
    Top = 212
    Width = 75
    Height = 25
    TabOrder = 3
    Kind = bkOK
  end
end
