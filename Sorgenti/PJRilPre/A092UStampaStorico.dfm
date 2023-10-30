object A092FStampaStorico: TA092FStampaStorico
  Left = 279
  Top = 49
  HelpContext = 92000
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '<A092> Elenco movimenti storici'
  ClientHeight = 600
  ClientWidth = 496
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object splMain: TSplitter
    Left = 0
    Top = 387
    Width = 496
    Height = 1
    Cursor = crVSplit
    Align = alTop
    MinSize = 1
    ResizeStyle = rsLine
    ExplicitTop = 361
    ExplicitWidth = 500
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 581
    Width = 496
    Height = 19
    Panels = <
      item
        Width = 350
      end
      item
        Width = 50
      end>
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 565
    Width = 496
    Height = 16
    Align = alBottom
    TabOrder = 5
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 496
    Height = 24
    Align = alTop
    TabOrder = 0
    TabStop = True
    ExplicitWidth = 496
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 496
      Height = 24
      ExplicitWidth = 496
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
  object pnlEsporta: TPanel
    Left = 0
    Top = 388
    Width = 496
    Height = 144
    Align = alClient
    TabOrder = 2
    object dgrdEsporta: TDBGrid
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 488
      Height = 136
      Align = alClient
      PopupMenu = pmnEsporta
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
    end
  end
  object pnlMain: TPanel
    Left = 0
    Top = 24
    Width = 496
    Height = 363
    Align = alTop
    Constraints.MinHeight = 250
    ParentBackground = False
    ParentColor = True
    TabOrder = 1
    DesignSize = (
      496
      363)
    object Label1: TLabel
      Left = 4
      Top = 43
      Width = 160
      Height = 13
      Caption = 'Dati anagrafici storicizzati richiesti:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object ListaAnagra: TCheckListBox
      Left = 4
      Top = 60
      Width = 256
      Height = 297
      Anchors = [akLeft, akTop, akBottom]
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Pitch = fpFixed
      Font.Style = []
      ItemHeight = 14
      ParentFont = False
      PopupMenu = PopupMenu1
      TabOrder = 1
      OnMouseDown = ListaAnagraMouseDown
      OnMouseUp = ListaAnagraMouseUp
    end
    object chkSaltoPagina: TCheckBox
      Left = 269
      Top = 152
      Width = 219
      Height = 22
      Alignment = taLeftJustify
      Caption = 'Salto pagina per dipendente'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 4
    end
    object rgpOrdinamento: TRadioGroup
      Left = 266
      Top = 58
      Width = 223
      Height = 65
      Caption = 'Ordinamento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Cronologico'
        'Per dato')
      ParentFont = False
      TabOrder = 2
    end
    object chkVariazioni: TCheckBox
      Left = 269
      Top = 128
      Width = 219
      Height = 22
      Alignment = taLeftJustify
      Caption = 'Stampa solo se ci sono variazioni'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    inline frmInputPeriodo: TfrmInputPeriodo
      Left = 1
      Top = 1
      Width = 494
      Height = 37
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
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 494
      ExplicitHeight = 37
      inherited lblInizio: TLabel
        Left = 3
        ExplicitLeft = 3
      end
      inherited lblFine: TLabel
        Left = 150
        ExplicitLeft = 150
      end
      inherited edtInizio: TMaskEdit
        Left = 28
        ExplicitLeft = 28
      end
      inherited edtFine: TMaskEdit
        Left = 165
        ExplicitLeft = 165
      end
      inherited btnIndietro: TBitBtn
        Left = 271
        ExplicitLeft = 271
      end
      inherited btnAvanti: TBitBtn
        Left = 293
        ExplicitLeft = 293
      end
      inherited btnDataInizio: TBitBtn
        Left = 99
        ExplicitLeft = 99
      end
      inherited btnDataFine: TBitBtn
        Left = 236
        ExplicitLeft = 236
      end
    end
  end
  object pnlBottoni: TPanel
    Left = 0
    Top = 532
    Width = 496
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object BtnPrinterSetUp: TBitBtn
      Left = 3
      Top = 3
      Width = 90
      Height = 25
      Caption = 'S&tampante'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FF0000000000
        0FFFF0777777777070FF000000000000070F0778777BBB87000F077887788887
        070F00000000000007700778888778807070F000000000070700FF0777777770
        7070FFF077777776EEE0F8000000000E6008F0E6EEEEEEEE0FFFF8000000000E
        6008FFFF07777786EEE0FFFFF00000080008FFFFFFFFFFFFFFFF}
      TabOrder = 0
      OnClick = BtnPrinterSetUpClick
    end
    object BtnPreView: TBitBtn
      Left = 203
      Top = 3
      Width = 90
      Height = 25
      Caption = 'Anteprima'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFF000000000000FF000FFFFFFFFFF0F0000FFFFFFF0000800F0FFFFFF08778
        08FF0FFFFF0877E880FF0FFFFF07777870FF0FFFFF07E77870FF0FFFFF08EE78
        80FF0FFFFFF087780FFF0FFFFFFF0000FFFF0FFFFFFFFFF0FFFF0FFFFFFF0000
        FFFF0FFFFFFF070FFFFF0FFFFFFF00FFFFFF000000000FFFFFFF}
      TabOrder = 2
      OnClick = BtnPreViewClick
    end
    object BtnClose: TBitBtn
      Left = 403
      Top = 3
      Width = 90
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 4
    end
    object BtnStampa: TBitBtn
      Left = 303
      Top = 3
      Width = 90
      Height = 25
      Caption = '&Stampa'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        00033FFFFFFFFFFFFFFF0888888888888880777777777777777F088888888888
        8880777777777777777F0000000000000000FFFFFFFFFFFFFFFF0F8F8F8F8F8F
        8F80777777777777777F08F8F8F8F8F8F9F0777777777777777F0F8F8F8F8F8F
        8F807777777777777F7F0000000000000000777777777777777F3330FFFFFFFF
        03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
        03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
        33333337F3FF7F3733333330F08F0F0333333337F7737F7333333330FFFF0033
        33333337FFFF7733333333300000033333333337777773333333}
      NumGlyphs = 2
      TabOrder = 3
      OnClick = BtnStampaClick
    end
    object btnEsporta: TBitBtn
      Left = 103
      Top = 3
      Width = 90
      Height = 25
      Caption = 'Visualizza'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333FFFFFFFFFFFFFFF000000000000000077777777777777770FFFFFFFFFFF
        FFF07F3FF3FF3FF3FFF70F00F00F00F000F07F773773773777370FFFFFFFFFFF
        FFF07F3FF3FF3FF3FFF70F00F00F00F000F07F773773773777370FFFFFFFFFFF
        FFF07F3FF3FF3FF3FFF70F00F00F00F000F07F773773773777370FFFFFFFFFFF
        FFF07F3FF3FF3FF3FFF70F00F00F00F000F07F773773773777370FFFFFFFFFFF
        FFF07FFFFFFFFFFFFFF70CCCCCCCCCCCCCC07777777777777777088CCCCCCCCC
        C8807FF7777777777FF700000000000000007777777777777777333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnEsportaClick
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 4
    Top = 48
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      OnClick = Selezionatutto1Click
    end
    object Annullatutto1: TMenuItem
      Caption = 'Annulla tutto'
      OnClick = Annullatutto1Click
    end
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 308
    Top = 12
  end
  object pmnEsporta: TPopupMenu
    Left = 4
    Top = 368
    object CopiainExcel: TMenuItem
      Caption = 'Copia in Excel'
      OnClick = CopiainExcelClick
    end
  end
end
