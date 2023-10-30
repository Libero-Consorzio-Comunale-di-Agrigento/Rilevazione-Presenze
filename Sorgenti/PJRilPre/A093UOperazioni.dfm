object A093FOperazioni: TA093FOperazioni
  Left = 245
  Top = 159
  HelpContext = 93000
  Caption = '<A093> Monitoraggio tabella di log'
  ClientHeight = 440
  ClientWidth = 625
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 205
    Top = 58
    Height = 248
    ExplicitHeight = 253
  end
  object Splitter2: TSplitter
    Left = 414
    Top = 58
    Height = 248
    Align = alRight
    ExplicitLeft = 411
    ExplicitHeight = 253
  end
  object Splitter3: TSplitter
    Left = 622
    Top = 58
    Height = 248
    Align = alRight
    ExplicitLeft = 619
    ExplicitHeight = 253
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 421
    Width = 625
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object gbxDettaglio: TGroupBox
    Left = 0
    Top = 306
    Width = 625
    Height = 85
    Align = alBottom
    Caption = 'Selezioni sul dettaglio'
    TabOrder = 6
    object pnlDettaglio: TPanel
      Left = 2
      Top = 15
      Width = 621
      Height = 68
      Align = alClient
      BevelOuter = bvNone
      Enabled = False
      TabOrder = 0
      object Label6: TLabel
        Left = 4
        Top = 27
        Width = 71
        Height = 13
        Caption = 'Valore vecchio'
      end
      object Label7: TLabel
        Left = 12
        Top = 49
        Width = 63
        Height = 13
        Caption = 'Valore nuovo'
      end
      object Label8: TLabel
        Left = 36
        Top = 5
        Width = 39
        Height = 13
        Caption = 'Colonna'
      end
      object edtValoreVecchio: TEdit
        Left = 135
        Top = 24
        Width = 121
        Height = 21
        TabOrder = 3
      end
      object edtValoreNuovo: TEdit
        Left = 135
        Top = 46
        Width = 121
        Height = 21
        TabOrder = 5
      end
      object cmbColonna: TComboBox
        Left = 135
        Top = 2
        Width = 121
        Height = 21
        TabOrder = 1
      end
      object cmbOper1: TComboBox
        Left = 80
        Top = 2
        Width = 49
        Height = 21
        Style = csDropDownList
        TabOrder = 0
        Items.Strings = (
          '='
          'LIKE')
      end
      object cmbOper2: TComboBox
        Left = 80
        Top = 24
        Width = 49
        Height = 21
        Style = csDropDownList
        TabOrder = 2
        Items.Strings = (
          '='
          'LIKE')
      end
      object cmbOper3: TComboBox
        Left = 80
        Top = 46
        Width = 49
        Height = 21
        Style = csDropDownList
        TabOrder = 4
        Items.Strings = (
          '='
          'LIKE')
      end
      object chkValoriModificati: TCheckBox
        Left = 276
        Top = 4
        Width = 117
        Height = 17
        Caption = 'solo valori modificati'
        TabOrder = 6
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 391
    Width = 625
    Height = 30
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 5
    object BtnClose: TBitBtn
      Left = 519
      Top = 2
      Width = 100
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 4
    end
    object BtnStampa: TBitBtn
      Left = 262
      Top = 2
      Width = 100
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
      TabOrder = 2
      OnClick = BtnStampaClick
    end
    object BitVideo: TBitBtn
      Left = 391
      Top = 2
      Width = 100
      Height = 25
      Caption = '&Video'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FF0000000000
        0FFFFFF077777770FFFFFFFFF08880FFFFFF000000000000000F0FFFFFFFFFF9
        FF0F0F78888888887F0F0F70000000008F0F0F70AAAAAAA08F0F0F70ADDDDDA0
        8F0F0F70A99A99A08F0F0F70A99A99A08F0F0F70AAAAAAA08F0F0F7000000000
        8F0F0F77777777777F0F0FFFFFFFFFFFFF0F000000000000000F}
      TabOrder = 3
      OnClick = BtnStampaClick
    end
    object BtnPrinterSetUp: TBitBtn
      Left = 6
      Top = 2
      Width = 100
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
      Left = 134
      Top = 2
      Width = 100
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
      TabOrder = 1
      OnClick = BtnStampaClick
    end
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 625
    Height = 24
    Align = alTop
    TabOrder = 0
    TabStop = True
    ExplicitWidth = 625
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 625
      Height = 24
      ExplicitWidth = 625
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
  object pnlPeriodo: TPanel
    Left = 0
    Top = 24
    Width = 625
    Height = 34
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object btnElinimaRegistrazioni: TBitBtn
      Left = 496
      Top = 4
      Width = 122
      Height = 25
      Caption = 'Elimina registrazioni'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        7777777777770000777777777700778807777777007777880777770077277788
        0777778772222788807777872727278880777877277777888077787222722788
        807778772772278888077877722FFFF8880777777FF8888FF807777FF88F8FF8
        FF077FF88FFF8FF88877777FFFF8FFF87777FF77FF8FF8877777}
      TabOrder = 1
      OnClick = btnElinimaRegistrazioniClick
    end
    inline frmInputPeriodo: TfrmInputPeriodo
      Left = 0
      Top = 0
      Width = 625
      Height = 34
      Align = alClient
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
      ExplicitWidth = 625
      ExplicitHeight = 34
      inherited lblInizio: TLabel
        Top = 8
        ExplicitTop = 8
      end
      inherited lblFine: TLabel
        Top = 8
        ExplicitTop = 8
      end
      inherited edtInizio: TMaskEdit
        Top = 5
        ExplicitTop = 5
      end
      inherited edtFine: TMaskEdit
        Top = 5
        ExplicitTop = 5
      end
      inherited btnIndietro: TBitBtn
        Top = 5
        ExplicitTop = 5
      end
      inherited btnAvanti: TBitBtn
        Top = 5
        ExplicitTop = 5
      end
      inherited btnDataInizio: TBitBtn
        Top = 4
        ExplicitTop = 4
      end
      inherited btnDataFine: TBitBtn
        Left = 241
        Top = 3
        ExplicitLeft = 241
        ExplicitTop = 3
      end
    end
  end
  object pnlOperatoriOperazioni: TPanel
    Left = 0
    Top = 58
    Width = 205
    Height = 248
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 2
    object Label4: TLabel
      Left = 0
      Top = 165
      Width = 205
      Height = 13
      Align = alBottom
      Caption = 'Operazioni:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 53
    end
    object CLBOperatori: TCheckListBox
      Left = 0
      Top = 16
      Width = 205
      Height = 149
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      PopupMenu = PopupMenu1
      Sorted = True
      TabOrder = 0
    end
    object CLBOperazioni: TCheckListBox
      Left = 0
      Top = 178
      Width = 205
      Height = 70
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      Items.Strings = (
        'Accesso'
        'Cancellazione'
        'Inserimento'
        'Modifica')
      ParentFont = False
      PopupMenu = PopupMenu1
      Sorted = True
      TabOrder = 1
    end
    object pnlEtichettaOperatori: TPanel
      Left = 0
      Top = 0
      Width = 205
      Height = 16
      Align = alTop
      TabOrder = 2
      object Label5: TLabel
        Left = 6
        Top = 1
        Width = 46
        Height = 13
        Caption = 'Operatori:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
    end
  end
  object pnlFunzioniOrdinamento: TPanel
    Left = 208
    Top = 58
    Width = 206
    Height = 248
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object Label3: TLabel
      Left = 0
      Top = 165
      Width = 206
      Height = 13
      Align = alBottom
      Caption = 'Ordinamento:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 63
    end
    object CLBFunzioni: TCheckListBox
      Left = 0
      Top = 16
      Width = 206
      Height = 149
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      PopupMenu = PopupMenu1
      TabOrder = 0
    end
    object LBOrdine: TCheckListBox
      Left = 0
      Top = 178
      Width = 206
      Height = 70
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      Items.Strings = (
        'Operatore'
        'Funzione'
        'Tabella'
        'Operazione'
        'Data')
      ParentFont = False
      PopupMenu = PopupMenu1
      TabOrder = 1
      OnMouseDown = LBOrdineMouseDown
      OnMouseUp = LBOrdineMouseUp
    end
    object pnlEtichettaFunzioni: TPanel
      Left = 0
      Top = 0
      Width = 206
      Height = 16
      Align = alTop
      TabOrder = 2
      object Label1: TLabel
        Left = 6
        Top = 1
        Width = 42
        Height = 13
        Caption = 'Funzioni:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
    end
  end
  object pnlTabelleOpzioni: TPanel
    Left = 417
    Top = 58
    Width = 205
    Height = 248
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 4
    object CLBTabelle: TCheckListBox
      Left = 0
      Top = 16
      Width = 205
      Height = 114
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      PopupMenu = PopupMenu1
      Sorted = True
      TabOrder = 0
    end
    object GroupBox1: TGroupBox
      Left = 0
      Top = 130
      Width = 205
      Height = 118
      Align = alBottom
      Caption = 'Opzioni'
      TabOrder = 1
      object chkVisualizzaDettaglio: TCheckBox
        Left = 8
        Top = 13
        Width = 113
        Height = 17
        Caption = 'visualizza dettaglio'
        TabOrder = 0
      end
      object chkSaltoPagina: TCheckBox
        Left = 8
        Top = 64
        Width = 113
        Height = 17
        Caption = 'salto pagina'
        TabOrder = 3
      end
      object chkDettaglioFiltrato: TCheckBox
        Left = 8
        Top = 47
        Width = 173
        Height = 17
        Caption = 'dettaglio filtrato sulla selezione'
        TabOrder = 2
        OnClick = chkDettaglioClick
      end
      object chkDettaglio: TCheckBox
        Left = 8
        Top = 31
        Width = 167
        Height = 16
        Caption = 'selezioni sul dettaglio'
        TabOrder = 1
        OnClick = chkDettaglioClick
      end
      object chkDipendentiSelezionati: TCheckBox
        Left = 8
        Top = 81
        Width = 141
        Height = 17
        Caption = 'nei dipendenti selezionati'
        TabOrder = 4
        OnClick = chkDipendentiSelezionatiClick
      end
      object chkRicercaDipendenti: TCheckBox
        Left = 8
        Top = 98
        Width = 125
        Height = 17
        Caption = 'ricerca per dipendenti'
        TabOrder = 5
        OnClick = chkDipendentiSelezionatiClick
      end
    end
    object pnlEtichettaTabelle: TPanel
      Left = 0
      Top = 0
      Width = 205
      Height = 16
      Align = alTop
      TabOrder = 2
      object Label2: TLabel
        Left = 1
        Top = 1
        Width = 38
        Height = 14
        Align = alLeft
        Caption = 'Tabelle:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ExplicitHeight = 13
      end
    end
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 372
    Top = 10
  end
  object PopupMenu1: TPopupMenu
    Left = 401
    Top = 10
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
