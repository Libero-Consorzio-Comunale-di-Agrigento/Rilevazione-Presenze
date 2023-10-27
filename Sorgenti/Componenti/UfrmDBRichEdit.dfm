object frmDBRichEdit: TfrmDBRichEdit
  Left = 0
  Top = 0
  Width = 455
  Height = 263
  TabOrder = 0
  object pnlTools: TPanel
    Left = 0
    Top = 0
    Width = 455
    Height = 26
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 825
    object btnBold: TSpeedButton
      Left = 243
      Top = 1
      Width = 23
      Height = 22
      AllowAllUp = True
      GroupIndex = 1
      Caption = 'G'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = btnBoldClick
    end
    object btnItalic: TSpeedButton
      Left = 267
      Top = 1
      Width = 23
      Height = 22
      AllowAllUp = True
      GroupIndex = 2
      Caption = 'I'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsItalic]
      ParentFont = False
      OnClick = btnItalicClick
    end
    object btnUnderline: TSpeedButton
      Left = 291
      Top = 1
      Width = 23
      Height = 22
      AllowAllUp = True
      GroupIndex = 3
      Caption = 'S'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
      OnClick = btnUnderlineClick
    end
    object btnAlignLeft: TSpeedButton
      Left = 329
      Top = 1
      Width = 30
      Height = 22
      AllowAllUp = True
      GroupIndex = 4
      Down = True
      Caption = 'S'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Margin = 1
      ParentFont = False
      OnClick = btnAlignLeftClick
    end
    object btnAlignCenter: TSpeedButton
      Left = 360
      Top = 1
      Width = 30
      Height = 22
      AllowAllUp = True
      GroupIndex = 4
      Caption = 'C'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = btnAlignCenterClick
    end
    object btnAlignRight: TSpeedButton
      Left = 391
      Top = 1
      Width = 30
      Height = 22
      AllowAllUp = True
      GroupIndex = 4
      Caption = 'D'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Margin = 11
      ParentFont = False
      OnClick = btnAlignRightClick
    end
    object cmbSize: TComboBox
      Left = 136
      Top = 1
      Width = 43
      Height = 22
      Style = csOwnerDrawFixed
      ItemIndex = 1
      TabOrder = 0
      Text = '8'
      OnChange = cmbSizeChange
      Items.Strings = (
        '6'
        '8'
        '10'
        '12'
        '14'
        '16'
        '18'
        '20')
    end
    object cmbColore: TComboBox
      Left = 185
      Top = 1
      Width = 43
      Height = 22
      Style = csOwnerDrawFixed
      TabOrder = 1
      OnChange = cmbColoreChange
      OnDrawItem = cmbColoreDrawItem
    end
    object cmbFontName: TComboBox
      Left = 7
      Top = 1
      Width = 123
      Height = 22
      Style = csOwnerDrawFixed
      TabOrder = 2
      OnChange = cmbFontNameChange
      OnKeyPress = cmbFontNameKeyPress
    end
  end
  object DMemo: TDBRichEdit
    Left = 0
    Top = 26
    Width = 455
    Height = 237
    Hint = 'Tasto sinistro + rotella del mouse per modificare lo zoom'
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    HideSelection = False
    HideScrollBars = False
    ParentShowHint = False
    ScrollBars = ssVertical
    ShowHint = True
    TabOrder = 1
    WantTabs = True
    Zoom = 100
    OnSelectionChange = DMemoSelectionChange
    ExplicitWidth = 825
    ExplicitHeight = 617
  end
end
