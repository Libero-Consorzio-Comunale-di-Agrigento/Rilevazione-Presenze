inherited A004FGiustifAssPres: TA004FGiustifAssPres
  Left = 214
  Top = 176
  HelpContext = 4000
  Caption = '<A004> Giustificativi ass./pres.'
  ClientHeight = 443
  ClientWidth = 845
  Position = poScreenCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 855
  ExplicitHeight = 493
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 424
    Width = 845
    Panels = <
      item
        Text = 'Data'
        Width = 130
      end
      item
        Text = '1 Record'
        Width = 50
      end>
    ExplicitTop = 424
    ExplicitWidth = 845
  end
  object ScrollBox1: TScrollBox [1]
    Left = 0
    Top = 24
    Width = 292
    Height = 385
    HorzScrollBar.Visible = False
    Align = alLeft
    BorderStyle = bsNone
    TabOrder = 1
    DesignSize = (
      292
      385)
    object Label1: TLabel
      Left = 8
      Top = 136
      Width = 41
      Height = 13
      Caption = 'Causale:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LAOre: TLabel
      Left = 183
      Top = 264
      Width = 29
      Height = 13
      Caption = 'a Ore:'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LCausale: TDBText
      Left = 8
      Top = 159
      Width = 254
      Height = 13
      DataField = 'Descrizione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LDaOre: TLabel
      Left = 11
      Top = 264
      Width = 80
      Height = 13
      Caption = 'da Ore/num.Ore:'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblFamiliari: TLabel
      Left = 8
      Top = 181
      Width = 106
      Height = 13
      Caption = 'Familiare di riferimento:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 249
      Top = 72
      Width = 38
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'num gg:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 225
    end
    object lblNote: TLabel
      Left = 8
      Top = 289
      Width = 26
      Height = 13
      Caption = 'Note:'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object EAOre: TMaskEdit
      Left = 221
      Top = 261
      Width = 37
      Height = 21
      Enabled = False
      EditMask = '99:99;1;_'
      MaxLength = 5
      TabOrder = 9
      Text = '  :  '
    end
    object RGTipoGiust: TRadioGroup
      Left = 4
      Top = 203
      Width = 286
      Height = 53
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Tipo giustificativo'
      Columns = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Giornata'
        'Mezza giornata'
        'Numero ore'
        'Da ore a ore')
      ParentFont = False
      TabOrder = 7
      OnClick = RGTipoGiustClick
    end
    object ECausale: TDBLookupComboBox
      Left = 170
      Top = 134
      Width = 88
      Height = 21
      DropDownRows = 15
      DropDownWidth = 300
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      KeyField = 'Codice'
      ListField = 'Codice;Descrizione'
      ParentFont = False
      PopupMenu = PopupMenu1
      TabOrder = 5
      OnCloseUp = ECausaleCloseUp
      OnContextPopup = ECausaleContextPopup
      OnKeyDown = ECausaleKeyDown
      OnKeyUp = ECausaleKeyUp
    end
    object RGCausali: TRadioGroup
      AlignWithMargins = True
      Left = 3
      Top = 34
      Width = 286
      Height = 34
      Margins.Top = 0
      Margins.Bottom = 0
      Align = alTop
      Caption = 'Tipo causale'
      Columns = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 1
      Items.Strings = (
        'Presenza'
        'Assenza')
      ParentFont = False
      TabOrder = 1
      OnClick = RGCausaliClick
    end
    object EDaOre: TMaskEdit
      Left = 98
      Top = 261
      Width = 37
      Height = 21
      Enabled = False
      EditMask = '!99:99;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 8
      Text = '  :  '
    end
    object rgpGestione: TRadioGroup
      AlignWithMargins = True
      Left = 3
      Top = 0
      Width = 286
      Height = 34
      Margins.Top = 0
      Margins.Bottom = 0
      Align = alTop
      Caption = 'Assegnazione a'
      Columns = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Dipendente'
        'Altro genitore non dip.')
      ParentFont = False
      TabOrder = 0
      OnClick = rgpGestioneClick
    end
    object dcmbFamiliari: TDBLookupComboBox
      Left = 126
      Top = 178
      Width = 133
      Height = 21
      DropDownWidth = 300
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      KeyField = 'Data'
      ListField = 'Data;Nome'
      ParentFont = False
      PopupMenu = PopupMenu3
      TabOrder = 6
      OnEnter = dcmbFamiliariEnter
      OnKeyDown = ECausaleKeyDown
    end
    object btnRecapitoAlternativo: TBitBtn
      Left = 6
      Top = 316
      Width = 280
      Height = 28
      Hint = 
        'Permette di specificare un domicilio alternativo per le visite f' +
        'iscali'
      Anchors = [akLeft, akRight]
      Caption = 'Recapito &visite fiscali'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFF00000000000FFFFF09111111110FFF1109707070710FFFFF0999999991
        0FFFFFF097070790FFFF000109999901000F011100000001110F099901111109
        990FF0999999999990FFFF10000000001FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 11
      OnClick = btnRecapitoAlternativoClick
    end
    object SpinEdit1: TSpinEdit
      Left = 248
      Top = 89
      Width = 41
      Height = 22
      Anchors = [akTop, akRight]
      MaxValue = 9999
      MinValue = 0
      TabOrder = 3
      Value = 0
      OnChange = SpinEdit1Change
    end
    object chkNuovoPeriodo: TCheckBox
      Left = 8
      Top = 113
      Width = 92
      Height = 17
      Caption = 'Nuovo periodo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object edtNote: TEdit
      Left = 40
      Top = 286
      Width = 95
      Height = 21
      Enabled = False
      MaxLength = 10
      TabOrder = 10
      Visible = False
    end
    object BInserisci: TBitBtn
      Left = 6
      Top = 349
      Width = 80
      Height = 25
      Caption = '&Inserisci'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000CE0E0000D80E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000080FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        000080000080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8000
        00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000080000080000080FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF800000FFFFFF800000FFFFFF000000FFFFFFFFFFFFFFFFFF
        000080000080000080000080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8000008000
        00800000FFFFFFFFFFFFFFFFFFFFFFFF000080000080000080000080000080FF
        FFFFFFFFFF800000800000800000800000800000800000FFFFFFFFFFFFFFFFFF
        000080000080000080000080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8000008000
        00800000FFFFFFFFFFFFFFFFFFFFFFFF000080000080000080FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF800000FFFFFF800000FFFFFF000000FFFFFFFFFFFFFFFFFF
        000080000080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8000
        00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000080FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      ParentFont = False
      TabOrder = 12
      OnClick = BInserisciClick
    end
    object BCancella: TBitBtn
      Left = 106
      Top = 349
      Width = 80
      Height = 25
      Caption = '&Cancella'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000C40E0000C40E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF188FFFFF88FF1FFF1188FF
        FF10FF11FF8118FFF81FFF111FF1188F118FFF1111F8118811FFFF11111F1111
        1FFFFF1111FF81118FFFFF111F88111188FFFF11F811FF81188FFF1FFFFFFFF8
        1180FFFFFFFFFFFFF01FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      ParentFont = False
      TabOrder = 13
      OnClick = BInserisciClick
    end
    object btnAnomalie: TBitBtn
      Left = 206
      Top = 349
      Width = 80
      Height = 25
      Anchors = [akTop, akRight]
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
      TabOrder = 14
      OnClick = btnAnomalieClick
    end
    inline frmInputPeriodo: TfrmInputPeriodo
      Left = 5
      Top = 71
      Width = 237
      Height = 40
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBackground = False
      ParentColor = False
      ParentFont = False
      TabOrder = 2
      ExplicitLeft = 5
      ExplicitTop = 71
      ExplicitWidth = 237
      inherited lblInizio: TLabel
        Left = 2
        Top = 1
        ExplicitLeft = 2
        ExplicitTop = 1
      end
      inherited lblFine: TLabel
        Left = 106
        Top = 1
        ExplicitLeft = 106
        ExplicitTop = 1
      end
      inherited edtInizio: TMaskEdit
        Left = 0
        Top = 18
        OnChange = frmInputPeriodoedtInizioChange
        OnExit = nil
        ExplicitLeft = 0
        ExplicitTop = 18
      end
      inherited edtFine: TMaskEdit
        Left = 98
        Top = 18
        OnChange = frmInputPeriodoedtFineChange
        ExplicitLeft = 98
        ExplicitTop = 18
      end
      inherited btnIndietro: TBitBtn
        Left = 193
        Top = 18
        ExplicitLeft = 193
        ExplicitTop = 18
      end
      inherited btnAvanti: TBitBtn
        Left = 214
        Top = 18
        ExplicitLeft = 214
        ExplicitTop = 18
      end
      inherited btnDataInizio: TBitBtn
        Left = 71
        Top = 17
        ExplicitLeft = 71
        ExplicitTop = 17
      end
      inherited btnDataFine: TBitBtn
        Left = 169
        Top = 17
        ExplicitLeft = 169
        ExplicitTop = 17
      end
    end
  end
  object DBGrid1: TDBGrid [2]
    Left = 292
    Top = 24
    Width = 553
    Height = 385
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    PopupMenu = PopupMenu2
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe [3]
    Left = 0
    Top = 0
    Width = 845
    Height = 24
    Align = alTop
    TabOrder = 0
    TabStop = True
    ExplicitWidth = 845
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 845
      Height = 24
      ExplicitWidth = 845
      ExplicitHeight = 24
      inherited lblDipendente: TLabel
        Height = 15
        Font.Height = -12
        ExplicitHeight = 15
      end
      inherited btnSelezione: TBitBtn
        OnClick = frmSelAnagrafebtnSelezioneClick
      end
      inherited btnRicerca: TBitBtn
        OnClick = frmSelAnagrafebtnRicercaClick
      end
    end
    inherited pmnuDatiAnagrafici: TPopupMenu
      inherited R003Datianagrafici: TMenuItem
        OnClick = TfrmSelAnagrafe1R003DatianagraficiClick
      end
    end
  end
  object ProgressBar: TProgressBar [4]
    Left = 0
    Top = 409
    Width = 845
    Height = 15
    Align = alBottom
    TabOrder = 4
  end
  inherited MainMenu1: TMainMenu [5]
    Left = 236
    Top = 2
    inherited File1: TMenuItem
      inherited ImpostaStampante1: TMenuItem
        Visible = False
      end
      inherited Stampa1: TMenuItem
        Visible = False
      end
      inherited N1: TMenuItem
        Visible = False
      end
      inherited Exit1: TMenuItem
        ShortCut = 24689
      end
      object CaricaAssenze: TMenuItem
        Caption = 'Carica giustificativi richiesti'
        OnClick = CaricaAssenzeClick
      end
    end
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 264
    Top = 2
  end
  object PopupMenu1: TPopupMenu
    Left = 292
    Top = 2
    object Nuovoelemento1: TMenuItem
      Caption = 'Accedi'
      OnClick = Nuovoelemento1Click
    end
    object CompetenzeResidui1: TMenuItem
      Caption = 'Competenze/Residui'
      OnClick = CompetenzeResidui1Click
    end
  end
  object PopupMenu2: TPopupMenu
    OnPopup = PopupMenu2Popup
    Left = 320
    Top = 2
    object Refresh1: TMenuItem
      Caption = 'Refresh'
      OnClick = DBGrid1DblClick
    end
    object Copiaimpostazioni1: TMenuItem
      Caption = 'Copia impostazioni'
      OnClick = Copiaimpostazioni1Click
    end
    object Causaleselezionata1: TMenuItem
      AutoCheck = True
      Caption = 'Causale selezionata'
      OnClick = Causaleselezionata1Click
    end
    object CompetenzeResidui2: TMenuItem
      Caption = 'Competenze/Residui'
      OnClick = CompetenzeResidui2Click
    end
  end
  object PopupMenu3: TPopupMenu
    OnPopup = PopupMenu3Popup
    Left = 348
    Top = 2
    object Nuovoelemento2: TMenuItem
      Caption = 'Accedi'
      OnClick = Nuovoelemento2Click
    end
  end
end
