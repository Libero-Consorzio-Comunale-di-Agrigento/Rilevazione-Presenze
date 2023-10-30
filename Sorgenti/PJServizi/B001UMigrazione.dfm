object Form1: TForm1
  Left = 92
  Top = 26
  Width = 461
  Height = 443
  Caption = 'Form1'
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 12
    Top = 14
    Width = 14
    Height = 13
    Caption = 'Da'
  end
  object Label2: TLabel
    Left = 220
    Top = 14
    Width = 7
    Height = 13
    Caption = 'A'
  end
  object Label3: TLabel
    Left = 12
    Top = 54
    Width = 14
    Height = 13
    Caption = 'Da'
  end
  object Label4: TLabel
    Left = 220
    Top = 54
    Width = 7
    Height = 13
    Caption = 'A'
  end
  object Label5: TLabel
    Left = 14
    Top = 304
    Width = 114
    Height = 13
    Caption = 'Alias locale di appoggio:'
  end
  object Label6: TLabel
    Left = 250
    Top = 330
    Width = 3
    Height = 13
  end
  object ComboBox1: TComboBox
    Left = 12
    Top = 30
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    Sorted = True
    TabOrder = 0
    OnChange = ComboBox1Exit
  end
  object ComboBox2: TComboBox
    Left = 220
    Top = 30
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    Sorted = True
    TabOrder = 1
    OnChange = ComboBox1Exit
  end
  object ListBox1: TListBox
    Left = 14
    Top = 74
    Width = 201
    Height = 220
    ItemHeight = 13
    MultiSelect = True
    Sorted = True
    TabOrder = 2
  end
  object ListBox2: TListBox
    Left = 222
    Top = 74
    Width = 201
    Height = 220
    ExtendedSelect = False
    ItemHeight = 13
    Sorted = True
    TabOrder = 3
  end
  object Button1: TButton
    Left = 170
    Top = 326
    Width = 75
    Height = 25
    Caption = 'Migrazione'
    TabOrder = 4
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 130
    Top = 300
    Width = 115
    Height = 21
    TabOrder = 5
    Text = 'Parametri'
  end
  object RadioGroup1: TRadioGroup
    Left = 16
    Top = 324
    Width = 149
    Height = 69
    Caption = 'Modalità'
    ItemIndex = 1
    Items.Strings = (
      'Creazione'
      'Creazione e migrazione'
      'Migrazione')
    TabOrder = 6
  end
  object Db1: TDatabase
    DatabaseName = 'Db1'
    SessionName = 'Default'
    Left = 130
    Top = 2
  end
  object Db2: TDatabase
    DatabaseName = 'Db2'
    Params.Strings = (
      'USER NAME=MONDOEDP')
    SessionName = 'Default'
    Left = 338
  end
  object Table1: TTable
    DatabaseName = 'Db1'
    Left = 102
    Top = 2
  end
  object Table2: TTable
    DatabaseName = 'Db2'
    TableName = 'A'
    Left = 310
  end
  object Query1: TQuery
    DatabaseName = 'Db2'
    Left = 282
  end
  object BatchMove1: TBatchMove
    AbortOnKeyViol = False
    AbortOnProblem = False
    Destination = Table2
    Source = Table1
    Left = 170
    Top = 2
  end
end
