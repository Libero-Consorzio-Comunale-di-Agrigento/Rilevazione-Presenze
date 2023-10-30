object A091FLiquidPresenze: TA091FLiquidPresenze
  Tag = 527
  Left = 318
  Top = 173
  HelpContext = 91000
  BorderIcons = [biSystemMenu]
  Caption = '<A091> Liquidazione ore causalizzate '
  ClientHeight = 588
  ClientWidth = 558
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
  object StatusBar: TStatusBar
    Left = 0
    Top = 569
    Width = 558
    Height = 19
    Panels = <
      item
        Width = 250
      end
      item
        Width = 50
      end>
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 553
    Width = 558
    Height = 16
    Align = alBottom
    Step = 1
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 24
    Width = 558
    Height = 356
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object Label1: TLabel
      Left = 4
      Top = 7
      Width = 25
      Height = 13
      Caption = 'Anno'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblCausale: TLabel
      Left = 4
      Top = 47
      Width = 34
      Height = 13
      Caption = 'Causali'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblMeseDa: TLabel
      Left = 59
      Top = 7
      Width = 42
      Height = 13
      Caption = 'Da mese'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object lblMeseA: TLabel
      Left = 177
      Top = 7
      Width = 35
      Height = 13
      Caption = 'A mese'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object lblMessaggio: TLabel
      Left = 20
      Top = 267
      Width = 61
      Height = 13
      Caption = 'lblMessaggio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object sedtAnno: TSpinEdit
      Left = 4
      Top = 22
      Width = 49
      Height = 22
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 4
      MaxValue = 3000
      MinValue = 1900
      ParentFont = False
      TabOrder = 0
      Value = 1900
      OnChange = sedtAnnoChange
    end
    object grpLiquidazione: TGroupBox
      Left = 4
      Top = 91
      Width = 142
      Height = 73
      Caption = 'Liquidazione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      object Label3: TLabel
        Left = 7
        Top = 20
        Width = 78
        Height = 13
        Caption = 'Arrotondamento:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 7
        Top = 48
        Width = 44
        Height = 13
        Caption = 'Massimo:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object edtArrotLiq: TMaskEdit
        Left = 88
        Top = 16
        Width = 45
        Height = 21
        EditMask = '!999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 3
        ParentFont = False
        TabOrder = 0
        Text = '   '
      end
      object edtMaxLiq: TMaskEdit
        Left = 88
        Top = 44
        Width = 45
        Height = 21
        EditMask = '!999:99;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 6
        ParentFont = False
        TabOrder = 1
        Text = ':  .  '
        OnExit = edtMaxLiqExit
      end
    end
    object grpCompensazione: TGroupBox
      Left = 149
      Top = 91
      Width = 137
      Height = 73
      Caption = 'Compensazione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      object Label5: TLabel
        Left = 7
        Top = 20
        Width = 78
        Height = 13
        Caption = 'Arrotondamento:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 7
        Top = 48
        Width = 44
        Height = 13
        Caption = 'Massimo:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object edtArrotComp: TMaskEdit
        Left = 87
        Top = 16
        Width = 41
        Height = 21
        EditMask = '!999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 3
        ParentFont = False
        TabOrder = 0
        Text = '   '
      end
      object edtMaxComp: TMaskEdit
        Left = 87
        Top = 44
        Width = 41
        Height = 21
        EditMask = '!999:99;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 6
        ParentFont = False
        TabOrder = 1
        Text = ':  .  '
        OnExit = edtMaxLiqExit
      end
    end
    object rgpDisponibilita: TRadioGroup
      Left = 289
      Top = 91
      Width = 121
      Height = 73
      Caption = 'Disponibilit'#224' liquidabile'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Mensile'
        'Annuale')
      ParentFont = False
      TabOrder = 7
    end
    object btnCausale: TBitBtn
      Left = 390
      Top = 61
      Width = 20
      Height = 23
      Caption = '...'
      TabOrder = 4
      OnClick = btnCausaleClick
    end
    object edtCausale: TEdit
      Left = 4
      Top = 62
      Width = 385
      Height = 21
      Color = clSilver
      ReadOnly = True
      TabOrder = 3
    end
    object cmbMeseDa: TComboBox
      Left = 59
      Top = 22
      Width = 110
      Height = 21
      Style = csDropDownList
      DropDownCount = 12
      TabOrder = 1
      OnChange = cmbMeseDaChange
      Items.Strings = (
        'Gennaio'
        'Febbraio'
        'Marzo'
        'Aprile'
        'Maggio'
        'Giugno'
        'Luglio'
        'Agosto'
        'Settembre'
        'Ottobre'
        'Novembre'
        'Dicembre')
    end
    object cmbMeseA: TComboBox
      Left = 177
      Top = 22
      Width = 110
      Height = 21
      Style = csDropDownList
      DropDownCount = 12
      TabOrder = 2
      OnChange = cmbMeseAChange
      Items.Strings = (
        'Gennaio'
        'Febbraio'
        'Marzo'
        'Aprile'
        'Maggio'
        'Giugno'
        'Luglio'
        'Agosto'
        'Settembre'
        'Ottobre'
        'Novembre'
        'Dicembre')
    end
    object chkAggiornamento: TCheckBox
      Left = 4
      Top = 178
      Width = 138
      Height = 17
      Caption = 'Effettua liquidazione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
      OnClick = chkAggiornamentoClick
    end
    object chkLiquidazioni: TCheckBox
      Left = 20
      Top = 222
      Width = 85
      Height = 17
      Caption = 'Liquidazioni'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      OnClick = chkLiquidazioniClick
    end
    object chkCompensazioni: TCheckBox
      Left = 20
      Top = 244
      Width = 97
      Height = 17
      Caption = 'Compensazioni'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 11
      OnClick = chkCompensazioniClick
    end
    object chkSaltoPagina: TCheckBox
      Left = 4
      Top = 288
      Width = 149
      Height = 17
      Caption = 'Salto pagina '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 12
    end
    object chkTotaliRaggr: TCheckBox
      Left = 4
      Top = 310
      Width = 149
      Height = 17
      Caption = 'Totali per raggruppamento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 13
    end
    object chkTotaliGenerali: TCheckBox
      Left = 4
      Top = 333
      Width = 149
      Height = 17
      Caption = 'Totali generali'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 14
    end
    object chkAnnullaLiquidazione: TCheckBox
      Left = 4
      Top = 200
      Width = 152
      Height = 17
      Caption = 'Annulla liquidazione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 9
      OnClick = chkAnnullaLiquidazioneClick
    end
    object btnPrinterSetUp: TBitBtn
      Left = 418
      Top = 174
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
      TabOrder = 15
      OnClick = BtnPrinterSetUpClick
    end
    object btnAnteprima: TBitBtn
      Left = 418
      Top = 205
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
      TabOrder = 16
      OnClick = btnStampaClick
    end
    object btnStampa: TBitBtn
      Left = 418
      Top = 236
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
      TabOrder = 17
      OnClick = btnStampaClick
    end
    object btnSoloAggiornamento: TBitBtn
      Left = 418
      Top = 267
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
      TabOrder = 18
      OnClick = btnStampaClick
    end
    object btnAnomalie: TBitBtn
      Left = 418
      Top = 298
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
      TabOrder = 19
      OnClick = btnAnomalieClick
    end
    object btnChiudi: TBitBtn
      Left = 418
      Top = 329
      Width = 130
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 20
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 380
    Width = 558
    Height = 173
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object grpDettaglio: TGroupBox
      AlignWithMargins = True
      Left = 292
      Top = 3
      Width = 263
      Height = 167
      Align = alClient
      Caption = 'Dettaglio'
      TabOrder = 1
      object Dettaglio: TCheckListBox
        Left = 2
        Top = 15
        Width = 259
        Height = 150
        Align = alClient
        ItemHeight = 13
        TabOrder = 0
        OnMouseDown = DettaglioMouseDown
        OnMouseUp = DettaglioMouseUp
      end
    end
    object grpIntestazione: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 283
      Height = 167
      Align = alLeft
      Caption = 'Intestazione'
      TabOrder = 0
      object Intestazione: TCheckListBox
        Left = 2
        Top = 15
        Width = 279
        Height = 150
        Align = alClient
        ItemHeight = 13
        TabOrder = 0
        OnMouseDown = IntestazioneMouseDown
        OnMouseUp = IntestazioneMouseUp
      end
    end
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 558
    Height = 24
    Align = alTop
    TabOrder = 4
    TabStop = True
    ExplicitWidth = 558
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 558
      Height = 24
      ExplicitWidth = 558
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
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 476
    Top = 36
  end
end
