object C014FImpostazioneFiltro: TC014FImpostazioneFiltro
  Left = 239
  Top = 200
  Width = 498
  Height = 369
  Caption = '<C014> Impostazione Filtro'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 135
    Width = 490
    Height = 3
    Cursor = crVSplit
    Align = alBottom
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 490
    Height = 21
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label3: TLabel
      Left = 141
      Top = 5
      Width = 29
      Height = 13
      Caption = 'Valori:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 5
      Top = 5
      Width = 42
      Height = 13
      Caption = 'Colonne:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 301
    Width = 490
    Height = 41
    Align = alBottom
    TabOrder = 1
    object btnOK: TBitBtn
      Left = 288
      Top = 8
      Width = 75
      Height = 25
      Caption = 'OK'
      TabOrder = 0
      OnClick = btnOKClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object BitBtn1: TBitBtn
      Left = 381
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 1
      Kind = bkCancel
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 21
    Width = 137
    Height = 114
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 2
    object Label2: TLabel
      Left = 5
      Top = 26
      Width = 46
      Height = 13
      Caption = 'Operatori:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object btnCreaEspressione: TSpeedButton
      Left = 67
      Top = 70
      Width = 23
      Height = 22
      Hint = 'Crea espressione'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
        333333333337F33333333333333033333333333333373F333333333333090333
        33333333337F7F33333333333309033333333333337373F33333333330999033
        3333333337F337F33333333330999033333333333733373F3333333309999903
        333333337F33337F33333333099999033333333373333373F333333099999990
        33333337FFFF3FF7F33333300009000033333337777F77773333333333090333
        33333333337F7F33333333333309033333333333337F7F333333333333090333
        33333333337F7F33333333333309033333333333337F7F333333333333090333
        33333333337F7F33333333333300033333333333337773333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = btnCreaEspressioneClick
    end
    object btnAggiornaValori: TSpeedButton
      Left = 109
      Top = 0
      Width = 23
      Height = 22
      Hint = 'Aggiorna valori'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFF2FFFFFFFFFFFFFF22FFFFFFFFFFFFF222222FFFFFFFFFFF22FFF
        2FFFFFFFFFFF2FFF2FFFFFFFFFFFFFFF2FFFFFFFFFFFFFFF2FFFFFFF2FFFFFFF
        FFFFFFFF2FFFFFFFFFFFFFFF2FFF2FFFFFFFFFFF2FFF22FFFFFFFFFFF222222F
        FFFFFFFFFFFF22FFFFFFFFFFFFFF2FFFFFFFFFFFFFFFFFFFFFFF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnAggiornaValoriClick
    end
    object btnPulisciMemo: TSpeedButton
      Left = 34
      Top = 70
      Width = 23
      Height = 22
      Hint = 'Pulisci espressione'
      Glyph.Data = {
        42020000424D4202000000000000420000002800000010000000100000000100
        1000030000000002000000000000000000000000000000000000007C0000E003
        00001F0000001F7C00000000000000001F7C0000000000001F7C1F7C1F7C1F7C
        1F7C1F7C1F7C000000000000000000000000000000001F7C1F7C1F7C00001F7C
        1F7C1F7C1F7C000000001F7C1F7C0000000000001F7C1F7C00001F7C1F7C1F7C
        1F7C1F7C1F7C000000001F7C1F7C1F7C000000001F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C000000001F7C1F7C000000001F7C000000001F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C000000001F7C00001F7C00000040004000001F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C00001F7C0000007C007C007C004000001F7C
        1F7C1F7C1F7C1F7C000000001F7C1F7C1F7C0000007C007C007C007C00400000
        1F7C1F7C1F7C1F7C000000001F7C00001F7C1F7C0000007C007C007C00000042
        00001F7C1F7C1F7C1F7C000000001F7C00001F7C1F7C0000007C0000E07F0000
        004200001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000E07F0000E07F
        0000004200001F7C1F7C1F7C1F7C00001F7C1F7C1F7C1F7C1F7C0000E07F0000
        E07F004200421F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000E07F
        E07FE07F00421F7C1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000
        E07FE07FE07F1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        0000E07FE07F1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C0000E07F}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnPulisciMemoClick
    end
    object Label4: TLabel
      Left = 0
      Top = 101
      Width = 137
      Height = 13
      Align = alBottom
      Caption = 'Espressione:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dCmbColonne: TDBLookupComboBox
      Left = 3
      Top = 0
      Width = 107
      Height = 21
      DropDownWidth = 300
      KeyField = 'NOME_LOGICO'
      ListField = 'NOME_LOGICO'
      ListSource = C014FImpostazioneFiltroDtM.dsrI010
      TabOrder = 0
      OnCloseUp = dCmbColonneCloseUp
      OnKeyDown = dCmbColonneKeyDown
      OnKeyUp = dCmbColonneKeyUp
    end
    object cmbOperatori: TComboBox
      Left = 3
      Top = 42
      Width = 129
      Height = 21
      ItemHeight = 13
      TabOrder = 1
      Items.Strings = (
        ' ='
        ' <'
        ' >'
        ' <>'
        ' >='
        ' <='
        ' BETWEEN ... AND ...'
        ' IN (...,...)'
        ' AND '
        ' OR '
        ' NOT ')
    end
  end
  object clbValori: TCheckListBox
    Left = 137
    Top = 21
    Width = 353
    Height = 114
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ItemHeight = 14
    ParentFont = False
    PopupMenu = PopupMenu1
    TabOrder = 3
  end
  object memoEspressione: TMemo
    Left = 0
    Top = 138
    Width = 490
    Height = 163
    Align = alBottom
    MaxLength = 2000
    TabOrder = 4
  end
  object PopupMenu1: TPopupMenu
    Left = 212
    Top = 92
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      OnClick = AnnullaTutto1Click
    end
    object AnnullaTutto1: TMenuItem
      Caption = 'Annulla Tutto'
      OnClick = AnnullaTutto1Click
    end
  end
end
