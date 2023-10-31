object A167FRegistraIncentivi: TA167FRegistraIncentivi
  Left = 0
  Top = 0
  HelpContext = 167000
  ActiveControl = frmSelAnagrafe
  Caption = '<A167> Cartolina incentivi'
  ClientHeight = 378
  ClientWidth = 663
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 663
    Height = 24
    Align = alTop
    TabOrder = 0
    TabStop = True
    ExplicitWidth = 663
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 663
      Height = 24
      ExplicitWidth = 663
      ExplicitHeight = 24
      inherited btnSelezione: TBitBtn
        OnClick = frmSelAnagrafebtnSelezioneClick
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 24
    Width = 663
    Height = 320
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object btnQuote: TSpeedButton
      Left = 454
      Top = 123
      Width = 23
      Height = 22
      Caption = '...'
      NumGlyphs = 2
      OnClick = btnQuoteClick
    end
    object lblQuote: TLabel
      Left = 10
      Top = 109
      Width = 91
      Height = 13
      Caption = 'Quote da elaborare'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 10
      Top = 57
      Width = 86
      Height = 13
      Caption = 'Da Tipo di calcolo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblMeseCompMax: TLabel
      Left = 336
      Top = 11
      Width = 80
      Height = 13
      Caption = 'Mese comp. max'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object sbtMeseCompMax: TSpeedButton
      Left = 407
      Top = 25
      Width = 23
      Height = 22
      Caption = '...'
      NumGlyphs = 2
      OnClick = sbtMeseCompMaxClick
    end
    object chkAggiorna: TCheckBox
      Left = 495
      Top = 6
      Width = 155
      Height = 17
      Caption = 'Aggiornamento riepilogo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnClick = chkAggiornaClick
    end
    object BtnClose: TBitBtn
      Left = 495
      Top = 191
      Width = 155
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 13
    end
    object btnAnomalie: TBitBtn
      Left = 495
      Top = 163
      Width = 155
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
      TabOrder = 11
      OnClick = btnAnomalieClick
    end
    object btnAggiornamento: TBitBtn
      Left = 495
      Top = 134
      Width = 155
      Height = 25
      Caption = 'Solo aggiornamento'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF00000000000000FF03300000077030FF033000000770
        30FF03300000077030FF03300000000030FF03333333333330FF033000000003
        30FF03077777777030FF03077777777030FF03077777777030FF030777777770
        30FF03077777777000FF03077777777070FF00000000000000FF}
      TabOrder = 10
      OnClick = btnAggiornamentoClick
    end
    object BtnStampa: TBitBtn
      Left = 495
      Top = 105
      Width = 155
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
      TabOrder = 9
      OnClick = BtnAnteprimaClick
    end
    object BtnAnteprima: TBitBtn
      Left = 495
      Top = 76
      Width = 155
      Height = 25
      Caption = '&Anteprima'
      Default = True
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFF000000000000FF000FFFFFFFFFF0F0000FFFFFFF0000800F0FFFFFF08778
        08FF0FFFFF0877E880FF0FFFFF07777870FF0FFFFF07E77870FF0FFFFF08EE78
        80FF0FFFFFF087780FFF0FFFFFFF0000FFFF0FFFFFFFFFF0FFFF0FFFFFFF0000
        FFFF0FFFFFFF070FFFFF0FFFFFFF00FFFFFF000000000FFFFFFF}
      TabOrder = 8
      OnClick = BtnAnteprimaClick
    end
    object BtnPrinterSetUp: TBitBtn
      Left = 495
      Top = 48
      Width = 155
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
      TabOrder = 7
      OnClick = BtnPrinterSetUpClick
    end
    object gpbStampa: TGroupBox
      Left = 1
      Top = 191
      Width = 661
      Height = 128
      Align = alBottom
      Caption = 'Impostazioni di stampa'
      TabOrder = 12
      object Label3: TLabel
        Left = 9
        Top = 18
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
      object Label1: TLabel
        Left = 158
        Top = 59
        Width = 39
        Height = 13
        Caption = 'Colonne'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object chkColonne: TCheckListBox
        Left = 158
        Top = 72
        Width = 491
        Height = 52
        OnClickCheck = chkColonneClickCheck
        Columns = 3
        ItemHeight = 13
        Items.Strings = (
          'Quota intera [1]'
          'Quota proporzionata [2]'
          'Quota netta [3]'
          'Quota netta + Risp. [4]'
          'Abbattimento con risp.'
          'Abbattimento senza risp.'
          'Quota quantitativa [5]')
        TabOrder = 4
      end
      object dcmbCampoAnag: TDBLookupComboBox
        Left = 9
        Top = 33
        Width = 250
        Height = 21
        DropDownWidth = 500
        KeyField = 'NOME_CAMPO'
        ListField = 'NOME_CAMPO;NOME_LOGICO'
        ListSource = A167FRegistraIncentiviDtM.dsrI010
        TabOrder = 0
        OnCloseUp = dcmbCampoAnagCloseUp
        OnKeyDown = dcmbCampoAnagKeyDown
        OnKeyUp = dcmbCampoAnagKeyUp
      end
      object chkSaltoPagina: TCheckBox
        Left = 268
        Top = 35
        Width = 100
        Height = 17
        Caption = 'Salto pagina'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object chkDettaglio: TCheckBox
        Left = 378
        Top = 35
        Width = 100
        Height = 17
        Caption = 'Dettaglio mensile'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object rgpTipoDati: TRadioGroup
        Left = 9
        Top = 59
        Width = 136
        Height = 65
        Caption = 'Tipo dati'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemIndex = 0
        Items.Strings = (
          'Quote in valuta'
          'Giorni di competenza')
        ParentFont = False
        TabOrder = 3
      end
    end
    object edtQuote: TEdit
      Left = 10
      Top = 123
      Width = 443
      Height = 21
      TabOrder = 3
      Text = 'edtQuote'
      OnExit = edtQuoteExit
    end
    object cmbTipoCalcolo: TComboBox
      Left = 10
      Top = 71
      Width = 469
      Height = 21
      TabOrder = 2
      Text = 'cmbTipoCalcolo'
      OnChange = cmbTipoCalcoloChange
      OnKeyDown = dcmbCampoAnagKeyDown
    end
    object chkAnnulla: TCheckBox
      Left = 495
      Top = 24
      Width = 155
      Height = 17
      Caption = 'Annullamento riepilogo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      OnClick = chkAnnullaClick
    end
    object edtMeseCompMax: TMaskEdit
      Left = 335
      Top = 25
      Width = 71
      Height = 21
      EditMask = '!99/0000;1;_'
      MaxLength = 7
      TabOrder = 1
      Text = '  /    '
      OnDblClick = edtMeseCompMaxDblClick
    end
    object chkCalcolaImportiSaldoAnnoCorr: TCheckBox
      Left = 10
      Top = 152
      Width = 469
      Height = 17
      Caption = 
        'Calcola anche gli importi per le quote con Riferimento a saldo o' +
        're anno corrente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    inline frmInputPeriodo: TfrmInputPeriodo
      Left = 7
      Top = 3
      Width = 326
      Height = 49
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
      ExplicitLeft = 7
      ExplicitTop = 3
      ExplicitWidth = 326
      ExplicitHeight = 49
      inherited lblInizio: TLabel
        Left = 4
        Top = 8
        Width = 44
        Caption = 'Dal mese'
        ExplicitLeft = 4
        ExplicitTop = 8
        ExplicitWidth = 44
      end
      inherited lblFine: TLabel
        Left = 154
        Top = 8
        Width = 37
        Caption = 'Al mese'
        ExplicitLeft = 154
        ExplicitTop = 8
        ExplicitWidth = 37
      end
      inherited edtInizio: TMaskEdit
        Left = 3
        Top = 22
        ExplicitLeft = 3
        ExplicitTop = 22
      end
      inherited edtFine: TMaskEdit
        Left = 153
        Top = 22
        OnExit = frmInputPeriodoedtFineExit
        ExplicitLeft = 153
        ExplicitTop = 22
      end
      inherited btnIndietro: TBitBtn
        Left = 271
        Top = 22
        ExplicitLeft = 271
        ExplicitTop = 22
      end
      inherited btnAvanti: TBitBtn
        Left = 293
        Top = 22
        ExplicitLeft = 293
        ExplicitTop = 22
      end
      inherited btnDataInizio: TBitBtn
        Left = 75
        Top = 22
        ExplicitLeft = 75
        ExplicitTop = 22
      end
      inherited btnDataFine: TBitBtn
        Left = 225
        Top = 22
        ExplicitLeft = 225
        ExplicitTop = 22
      end
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 359
    Width = 663
    Height = 19
    Panels = <
      item
        Width = 100
      end
      item
        Width = 50
      end>
    SimpleText = '0 Records'
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 344
    Width = 663
    Height = 15
    Align = alBottom
    TabOrder = 3
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 404
    Top = 28
  end
end
