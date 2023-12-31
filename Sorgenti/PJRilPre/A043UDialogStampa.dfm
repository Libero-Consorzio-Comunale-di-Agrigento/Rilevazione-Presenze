object A043FDialogStampa: TA043FDialogStampa
  Left = 389
  Top = 182
  HelpContext = 43000
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '<A043> Cartolina reperibilit'#224
  ClientHeight = 316
  ClientWidth = 424
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
  PixelsPerInch = 96
  TextHeight = 13
  object lblRaggr: TLabel
    Left = 9
    Top = 234
    Width = 177
    Height = 13
    Caption = 'Campo anagrafico di raggruppamento'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object btnPrinterSetUp: TBitBtn
    Left = 285
    Top = 71
    Width = 130
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
    TabOrder = 9
    OnClick = btnPrinterSetUpClick
  end
  object btnStampa: TBitBtn
    Left = 285
    Top = 141
    Width = 130
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
    TabOrder = 11
    OnClick = btnStampaClick
  end
  object btnClose: TBitBtn
    Left = 285
    Top = 246
    Width = 130
    Height = 25
    Caption = '&Chiudi'
    Kind = bkClose
    NumGlyphs = 2
    TabOrder = 14
  end
  object chkSpezzoniMese: TCheckBox
    Left = 9
    Top = 111
    Width = 212
    Height = 17
    Caption = 'Somma spezzoni mese precedente'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object chkSalva: TCheckBox
    Left = 9
    Top = 73
    Width = 212
    Height = 16
    Caption = 'Aggiornamento del riepilogo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = chkSalvaClick
  end
  object chkCumula: TCheckBox
    Left = 9
    Top = 130
    Width = 212
    Height = 16
    Caption = 'Cumula spezzoni in ore'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object dcmbCampo: TDBLookupComboBox
    Left = 9
    Top = 250
    Width = 212
    Height = 21
    KeyField = 'NOME_CAMPO'
    ListField = 'NOME_LOGICO'
    ListSource = A043FStampaRepMW.D010
    TabOrder = 8
    OnKeyDown = dcmbCampoKeyDown
  end
  object rgpTipoStampa: TRadioGroup
    Left = 9
    Top = 150
    Width = 212
    Height = 34
    Caption = 'Stampa'
    Columns = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'Dettaglio'
      'Riepilogo')
    ParentFont = False
    TabOrder = 5
    OnClick = rgpTipoStampaClick
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 297
    Width = 424
    Height = 19
    Panels = <
      item
        Width = 200
      end
      item
        Width = 50
      end>
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 281
    Width = 424
    Height = 16
    Align = alBottom
    DoubleBuffered = True
    ParentDoubleBuffered = False
    Step = 1
    TabOrder = 15
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 424
    Height = 24
    Align = alTop
    TabOrder = 0
    TabStop = True
    ExplicitWidth = 424
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 424
      Height = 24
      ExplicitWidth = 424
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
  object chkSaltoPagina: TCheckBox
    Left = 9
    Top = 210
    Width = 212
    Height = 16
    Caption = 'Salto pagina'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    State = cbChecked
    TabOrder = 7
  end
  object btnAnomalie: TBitBtn
    Left = 285
    Top = 211
    Width = 130
    Height = 25
    Caption = '&Anomalie'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333FFFFF3333333333F797F3333333333F737373FF333333BFB999BFB
      33333337737773773F3333BFBF797FBFB33333733337333373F33BFBFBFBFBFB
      FB3337F33333F33337F33FBFBFB9BFBFBF3337333337F333373FFBFBFBF97BFB
      FBF37F333337FF33337FBFBFBFB99FBFBFB37F3333377FF3337FFBFBFBFB99FB
      FBF37F33333377FF337FBFBF77BF799FBFB37F333FF3377F337FFBFB99FB799B
      FBF373F377F3377F33733FBF997F799FBF3337F377FFF77337F33BFBF99999FB
      FB33373F37777733373333BFBF999FBFB3333373FF77733F7333333BFBFBFBFB
      3333333773FFFF77333333333FBFBF3333333333377777333333}
    NumGlyphs = 2
    TabOrder = 13
    OnClick = btnAnomalieClick
  end
  object btnSoloAggiornamento: TBitBtn
    Left = 285
    Top = 176
    Width = 130
    Height = 25
    Caption = '&Solo aggiornamento'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333FFFFFFFFFFFFF33000077777770033377777777777773F000007888888
      00037F3337F3FF37F37F00000780088800037F3337F77F37F37F000007800888
      00037F3337F77FF7F37F00000788888800037F3337777777337F000000000000
      00037F3FFFFFFFFFFF7F00000000000000037F77777777777F7F000FFFFFFFFF
      00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
      00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
      00037F7F333333337F7F000FFFFFFFFF07037F7F33333333777F000FFFFFFFFF
      0003737FFFFFFFFF7F7330099999999900333777777777777733}
    NumGlyphs = 2
    TabOrder = 12
    OnClick = btnStampaClick
  end
  object btnAnteprima: TBitBtn
    Left = 285
    Top = 106
    Width = 130
    Height = 25
    Caption = '&Anteprima'
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
      FFFF000000000000FF000FFFFFFFFFF0F0000FFFFFFF0000800F0FFFFFF08778
      08FF0FFFFF0877E880FF0FFFFF07777870FF0FFFFF07E77870FF0FFFFF08EE78
      80FF0FFFFFF087780FFF0FFFFFFF0000FFFF0FFFFFFFFFF0FFFF0FFFFFFF0000
      FFFF0FFFFFFF070FFFFF0FFFFFFF00FFFFFF000000000FFFFFFF}
    TabOrder = 10
    OnClick = btnStampaClick
  end
  object chkSoloAnomalie: TCheckBox
    Left = 9
    Top = 189
    Width = 212
    Height = 16
    Caption = 'Stampa solo anomalie'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object chkIgnoraAnomalie: TCheckBox
    Left = 9
    Top = 92
    Width = 212
    Height = 17
    Caption = 'Ignora anomalie bloccanti'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  inline frmInputPeriodo: TfrmInputPeriodo
    Left = 0
    Top = 24
    Width = 424
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
    TabOrder = 17
    ExplicitTop = 24
    ExplicitWidth = 424
    inherited edtInizio: TMaskEdit
      OnExit = frmInputPeriodoedtInizioExit
    end
    inherited edtFine: TMaskEdit
      OnExit = frmInputPeriodoedtFineExit
    end
    inherited btnIndietro: TBitBtn
      Left = 285
      OnClick = frmInputPeriodobtnIndietroClick
      ExplicitLeft = 285
    end
    inherited btnAvanti: TBitBtn
      Left = 307
      OnClick = frmInputPeriodobtnAvantiClick
      ExplicitLeft = 307
    end
    inherited btnDataInizio: TBitBtn
      OnClick = frmInputPeriodobtnDataInizioClick
    end
    inherited btnDataFine: TBitBtn
      OnClick = frmInputPeriodobtnDataFineClick
    end
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 239
    Top = 65535
  end
end
