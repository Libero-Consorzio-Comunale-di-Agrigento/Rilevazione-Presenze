object A081FTimbCaus: TA081FTimbCaus
  Left = 412
  Top = 214
  HelpContext = 81000
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '<A081> Elenco timbrature causalizzate'
  ClientHeight = 467
  ClientWidth = 512
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
  OnShow = FormShow
  DesignSize = (
    512
    467)
  PixelsPerInch = 96
  TextHeight = 13
  object lblCampoRaggr: TLabel
    Left = 262
    Top = 82
    Width = 216
    Height = 13
    Caption = 'Campo anagrafico di raggruppamento:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblListaCausali: TLabel
    Left = 6
    Top = 66
    Width = 79
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Causali richieste:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ExplicitTop = 68
  end
  object BtnPrinterSetUp: TBitBtn
    Left = 5
    Top = 396
    Width = 100
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'S&tampante'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
      0003377777777777777308888888888888807F33333333333337088888888888
      88807FFFFFFFFFFFFFF7000000000000000077777777777777770F8F8F8F8F8F
      8F807F333333333333F708F8F8F8F8F8F9F07F333333333337370F8F8F8F8F8F
      8F807FFFFFFFFFFFFFF7000000000000000077777777777777773330FFFFFFFF
      03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
      03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
      33333337F3F37F3733333330F08F0F0333333337F7337F7333333330FFFF0033
      33333337FFFF7733333333300000033333333337777773333333}
    NumGlyphs = 2
    TabOrder = 11
    OnClick = BtnPrinterSetUpClick
  end
  object BtnPreView: TBitBtn
    Left = 139
    Top = 396
    Width = 100
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Anteprima'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      33033333333333333F7F3333333333333000333333333333F777333333333333
      000333333333333F777333333333333000333333333333F77733333333333300
      033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
      33333377333777733333307F8F8F7033333337F333F337F3333377F8F9F8F773
      3333373337F3373F3333078F898F870333337F33F7FFF37F333307F99999F703
      33337F377777337F3333078F898F8703333373F337F33373333377F8F9F8F773
      333337F3373337F33333307F8F8F70333333373FF333F7333333330777770333
      333333773FF77333333333370007333333333333777333333333}
    NumGlyphs = 2
    TabOrder = 12
    OnClick = BtnPreViewClick
  end
  object BtnClose: TBitBtn
    Left = 407
    Top = 396
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Chiudi'
    Kind = bkClose
    NumGlyphs = 2
    TabOrder = 14
  end
  object dcmbCampoRaggr: TDBLookupComboBox
    Left = 262
    Top = 98
    Width = 244
    Height = 21
    KeyField = 'NOME_CAMPO'
    ListField = 'NOME_LOGICO'
    ListSource = A081FTimbCausDtM1.D010
    TabOrder = 3
    OnKeyDown = dcmbCampoRaggrKeyDown
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 448
    Width = 512
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 432
    Width = 512
    Height = 16
    Align = alBottom
    TabOrder = 16
  end
  object CgpListaCausali: TCheckListBox
    Left = 6
    Top = 82
    Width = 250
    Height = 305
    Anchors = [akLeft, akBottom]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Pitch = fpFixed
    Font.Style = []
    ItemHeight = 14
    ParentFont = False
    PopupMenu = PopupMenu1
    TabOrder = 2
  end
  object chkTotData: TCheckBox
    Left = 262
    Top = 190
    Width = 244
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Totali per data'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object chkTotRaggr: TCheckBox
    Left = 262
    Top = 150
    Width = 244
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Totali per raggruppamento'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object chkTotCaus: TCheckBox
    Left = 262
    Top = 170
    Width = 244
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Totali per causale'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    State = cbChecked
    TabOrder = 6
  end
  object BtnStampa: TBitBtn
    Left = 273
    Top = 396
    Width = 100
    Height = 25
    Anchors = [akLeft, akBottom]
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
    TabOrder = 13
    OnClick = BtnPreViewClick
  end
  object chkSaltoCaus: TCheckBox
    Left = 262
    Top = 250
    Width = 244
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Salto pagina per causale'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
  end
  object chkSaltoRaggr: TCheckBox
    Left = 262
    Top = 230
    Width = 244
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Salto pagina raggruppamento'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
  end
  object chkTotGenerale: TCheckBox
    Left = 264
    Top = 130
    Width = 242
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Totale generale'
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
  object chkStampaDett: TCheckBox
    Left = 262
    Top = 210
    Width = 244
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Stampa dettagli'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 512
    Height = 24
    Align = alTop
    TabOrder = 0
    TabStop = True
    ExplicitWidth = 512
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 512
      Height = 24
      ExplicitWidth = 512
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
  inline frmInputPeriodo: TfrmInputPeriodo
    Left = 0
    Top = 24
    Width = 512
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
    TabOrder = 1
    ExplicitTop = 24
    ExplicitWidth = 512
    inherited lblInizio: TLabel
      Left = 6
      ExplicitLeft = 6
    end
    inherited lblFine: TLabel
      Left = 139
      ExplicitLeft = 139
    end
    inherited edtInizio: TMaskEdit
      Left = 31
      ExplicitLeft = 31
    end
    inherited edtFine: TMaskEdit
      Left = 154
      ExplicitLeft = 154
    end
    inherited btnIndietro: TBitBtn
      Left = 257
      ExplicitLeft = 257
    end
    inherited btnAvanti: TBitBtn
      Left = 279
      ExplicitLeft = 279
    end
    inherited btnDataInizio: TBitBtn
      Left = 102
      ExplicitLeft = 102
    end
    inherited btnDataFine: TBitBtn
      Left = 225
      ExplicitLeft = 225
    end
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 404
    Top = 4
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
end
