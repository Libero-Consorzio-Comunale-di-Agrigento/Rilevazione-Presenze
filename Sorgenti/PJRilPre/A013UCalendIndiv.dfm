inherited A013FCalendIndiv: TA013FCalendIndiv
  Left = 213
  Top = 209
  HelpContext = 13000
  Caption = '<A013> Calendario individuale'
  ClientHeight = 226
  ClientWidth = 430
  Position = poScreenCenter
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 446
  ExplicitHeight = 285
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 207
    Width = 430
    Panels = <
      item
        Text = 'Data'
        Width = 130
      end
      item
        Width = 50
      end>
    ExplicitTop = 206
    ExplicitWidth = 430
  end
  object ScrollBox1: TScrollBox [1]
    Left = 0
    Top = 24
    Width = 430
    Height = 183
    Align = alClient
    BorderStyle = bsNone
    TabOrder = 1
    ExplicitWidth = 551
    ExplicitHeight = 321
    object Label3: TLabel
      Left = 7
      Top = 8
      Width = 71
      Height = 13
      Caption = 'Santo Patrono:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object GroupBox1: TGroupBox
      Left = 7
      Top = 28
      Width = 147
      Height = 148
      Caption = 'Giorni lavorativi'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      TabOrder = 1
      object ELunedi: TCheckBox
        Left = 8
        Top = 16
        Width = 69
        Height = 17
        Caption = 'Luned'#236
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 0
      end
      object EMartedi: TCheckBox
        Left = 8
        Top = 34
        Width = 69
        Height = 17
        Caption = 'Marted'#236
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 1
      end
      object EMercoledi: TCheckBox
        Left = 8
        Top = 52
        Width = 69
        Height = 17
        Caption = 'Mercoled'#236
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 2
      end
      object EGiovedi: TCheckBox
        Left = 8
        Top = 70
        Width = 69
        Height = 17
        Caption = 'Gioved'#236
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 3
      end
      object EVenerdi: TCheckBox
        Left = 8
        Top = 88
        Width = 69
        Height = 17
        Caption = 'Venerd'#236
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 4
      end
      object ESabato: TCheckBox
        Left = 8
        Top = 106
        Width = 69
        Height = 17
        Caption = 'Sabato'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object EDomenica: TCheckBox
        Left = 8
        Top = 124
        Width = 69
        Height = 17
        Caption = 'Domenica'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
    end
    object GroupBox2: TGroupBox
      Left = 160
      Top = 2
      Width = 262
      Height = 174
      Caption = 'Generazione calendari'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      object Genera: TBitBtn
        Left = 5
        Top = 61
        Width = 250
        Height = 25
        Caption = '&Genera Calendario'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          04000000000080000000C40E0000C40E00001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFF808
          8FFF0FFFFFFF003000FFB0FFFFF0B333300F8B0FFFF0BB883088F8B0FF0BB0F8
          3300F8BB0FF0B0003088888BB0F0BB3BB00FBBBBBB0F00B000FF8BBB0088FF00
          FFFFF8BBB0FFFFFFFFFFFF8BBB0FFFFFFFFF8888BBB0FFFFFFFFF8BBBBBB0FFF
          FFFFFF8BBB0000FFFFFFFFF8BBB0FFFFFFFFFFFF8BBB0FFFFFFF}
        ParentFont = False
        TabOrder = 1
        OnClick = GeneraClick
      end
      object Visualizza: TBitBtn
        Left = 5
        Top = 109
        Width = 250
        Height = 25
        Caption = '&Visualizza Calendario'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFF000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000
          FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFFFFFFFFFFFF
          FF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000
          FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF000000FFFFFFFFFFFFFFFFFF000000000000000000FFFFFF000000FFFFFF00
          0000FFFFFF000000FFFFFF000000FFFFFF000000FFFFFFFFFFFFFFFFFF000000
          FFFFFF000000FFFFFF000000000000000000FFFFFF0000007B7B7B000000FFFF
          FF000000FFFFFFFFFFFFFFFFFF000000FFFFFF000000FFFFFF000000FFFFFF00
          0000FFFFFF0000007B7B7B000000FFFFFF000000FFFFFFFFFFFFFFFFFF000000
          FFFFFF000000FFFFFFFFFFFF000000FFFFFFFFFFFF000000FFFFFF000000FFFF
          FF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF000000000000000000000000FFFFFFFFFFFFFFFFFF000000
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFF
          FF000000FFFFFFFFFFFFFFFFFF0000000000FF0000FF0000FF0000FF0000FF00
          00FF0000FF0000FF000000FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFF000000
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000000000
          0000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        ParentFont = False
        TabOrder = 2
        OnClick = VisualizzaClick
      end
      object ProgressBar1: TProgressBar
        Left = 6
        Top = 91
        Width = 248
        Height = 13
        TabOrder = 3
      end
      inline frmInputPeriodo: TfrmInputPeriodo
        Left = 2
        Top = 15
        Width = 258
        Height = 40
        Align = alTop
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentBackground = False
        ParentColor = False
        ParentFont = False
        TabOrder = 0
        ExplicitLeft = 2
        ExplicitTop = 15
        ExplicitWidth = 258
        inherited lblInizio: TLabel
          Left = 4
          Top = 4
          ExplicitLeft = 4
          ExplicitTop = 4
        end
        inherited lblFine: TLabel
          Left = 109
          Top = 4
          ExplicitLeft = 109
          ExplicitTop = 4
        end
        inherited edtInizio: TMaskEdit
          Left = 4
          Top = 17
          ExplicitLeft = 4
          ExplicitTop = 17
        end
        inherited edtFine: TMaskEdit
          Left = 109
          Top = 17
          ExplicitLeft = 109
          ExplicitTop = 17
        end
        inherited btnIndietro: TBitBtn
          Left = 208
          Top = 17
          ExplicitLeft = 208
          ExplicitTop = 17
        end
        inherited btnAvanti: TBitBtn
          Left = 230
          Top = 17
          ExplicitLeft = 230
          ExplicitTop = 17
        end
        inherited btnDataInizio: TBitBtn
          Left = 75
          Top = 16
          ExplicitLeft = 75
          ExplicitTop = 16
        end
        inherited btnDataFine: TBitBtn
          Left = 180
          Top = 16
          ExplicitLeft = 180
          ExplicitTop = 16
        end
      end
    end
    object EPatrono: TMaskEdit
      Left = 81
      Top = 4
      Width = 73
      Height = 21
      EditMask = '!99/99/9999;1;_'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
    end
    object Cancella: TBitBtn
      Left = 165
      Top = 142
      Width = 250
      Height = 25
      Caption = 'Cancella'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF8400008400008400008400008400008400008400008400
        00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF840000FFFFFFFF
        FFFFFFFFFFFFFFFF848484840000840000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF840000FFFFFFFFFFFFFFFFFF8484848400008484848400
        00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF840000FFFFFFFF
        FFFFFFFFFFFFFFFF848484840000840000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF840000FFFFFFFFFFFFFFFFFF8484848400008484848400
        00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF840000FFFFFFFF
        FFFFFFFFFFFFFFFF848484848484840000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF8400008400008400008400008400008400008400008400
        00848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000840000FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8400
        00000000840000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF840000840000FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000840000848484FFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFF840000FFFFFF000000840000FFFFFFFFFFFFFFFFFFFFFFFF8400
        00848484840000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF840000FFFFFFFFFFFF00
        0000FFFFFFFFFFFFFFFFFFFFFFFF848484840000840000FFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF840000840000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF840000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF840000FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF840000840000FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8400
        00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      ParentFont = False
      TabOrder = 3
      OnClick = GeneraClick
    end
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe [2]
    Left = 0
    Top = 0
    Width = 430
    Height = 24
    Align = alTop
    TabOrder = 0
    TabStop = True
    ExplicitWidth = 372
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 430
      Height = 24
      ExplicitWidth = 372
      ExplicitHeight = 24
      inherited btnSelezione: TBitBtn
        OnClick = frmSelAnagrafebtnSelezioneClick
      end
    end
    inherited pmnuDatiAnagrafici: TPopupMenu
      inherited R003Datianagrafici: TMenuItem
        OnClick = frmSelAnagrafeR003DatianagraficiClick
      end
    end
  end
  inherited MainMenu1: TMainMenu [3]
    Left = 100
    Top = 58
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 100
    Top = 86
  end
end
