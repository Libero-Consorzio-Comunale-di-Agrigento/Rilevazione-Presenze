inherited A177FFerieSolidali: TA177FFerieSolidali
  Tag = 81
  HelpContext = 177000
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = '<A177> Gestione ferie solidali'
  ClientHeight = 542
  ClientWidth = 784
  ExplicitWidth = 800
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 524
    Width = 784
    ExplicitTop = 524
    ExplicitWidth = 784
  end
  inherited Panel1: TToolBar
    Top = 29
    Width = 784
    ExplicitTop = 29
    ExplicitWidth = 784
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe [2]
    Left = 0
    Top = 0
    Width = 784
    Height = 29
    Align = alTop
    TabOrder = 2
    TabStop = True
    ExplicitWidth = 784
    inherited pnlSelAnagrafe: TPanel
      Width = 784
      ExplicitWidth = 784
    end
  end
  object pnlAzioni: TPanel [3]
    Left = 0
    Top = 444
    Width = 784
    Height = 80
    Align = alBottom
    TabOrder = 3
    object btnEsegui: TBitBtn
      Left = 640
      Top = 11
      Width = 87
      Height = 25
      Caption = 'Esegui'
      Enabled = False
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000C40E0000C40E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFF808
        8FFF0FFFFFFF003000FFB0FFFFF0B333300F8B0FFFF0BB883088F8B0FF0BB0F8
        3300F8BB0FF0B0003088888BB0F0BB3BB00FBBBBBB0F00B000FF8BBB0088FF00
        FFFFF8BBB0FFFFFFFFFFFF8BBB0FFFFFFFFF8888BBB0FFFFFFFFF8BBBBBB0FFF
        FFFFFF8BBB0000FFFFFFFFF8BBB0FFFFFFFFFFFF8BBB0FFFFFFF}
      TabOrder = 2
      OnClick = btnEseguiClick
    end
    object btnAnomalie: TBitBtn
      Left = 640
      Top = 43
      Width = 87
      Height = 25
      Caption = 'Anomalie'
      Enabled = False
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        04000000000068010000120B0000120B00001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333333333333333
        0000333333333933333333333333333833333333000033333BFB999BFB333333
        333F3F080F3F333300003333BFBF393FBFB33333337F7F383F7F73330000333B
        FBFBFBFBFBFB33333FFFFFF7FFF7FF3300003333BFBFB9BFBFB33333337F7F78
        7F7FF3330000333BFBFBF98BFBFB333337FFF7F887FFF733000033BFBFBFB99F
        BFBFB333FF7FFFF08FFF7FF3000033FBFBFBFB99FBFB3333F7FFF7F780F7FF33
        000033BFBF88BF899FBFB333FFFF88FF808F7F730000333BFB99FB899BFB3333
        37F7087F8887FF3300003333BF998F899FB3333333FF888F880F73330000333B
        FBF99999FBFB33333FF7F08080FFFF3300003333BFBF999FBFB33333337FFF80
        8F7F7333000033333B3BFBFB3B333333333F37FFF73F3333000033333333BFB3
        33333333333333FF733333330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      TabOrder = 3
      OnClick = btnAnomalieClick
    end
    object chkAggiornaQuantita: TCheckBox
      Left = 18
      Top = 15
      Width = 240
      Height = 17
      Caption = 'Chiudi e aggiorna quantit'#224' ottenute/accettate'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = chkAggiornaQuantitaClick
    end
    object chkAggiornaProfili: TCheckBox
      Left = 18
      Top = 41
      Width = 256
      Height = 17
      Caption = 'Rendi fruibile e aggiorna profili assenze individuali'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = chkAggiornaProfiliClick
    end
    object chkAzzeraQuantita: TCheckBox
      Left = 293
      Top = 15
      Width = 231
      Height = 17
      Caption = 'Riapri e azzera quantit'#224' ottenute/accettate'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = chkAzzeraQuantitaClick
    end
    object chkImpostaTermine: TCheckBox
      Left = 293
      Top = 41
      Width = 146
      Height = 17
      Caption = 'Imposta data termine diritto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = chkImpostaTermineClick
    end
    object btnTermine: TButton
      Left = 515
      Top = 39
      Width = 17
      Height = 21
      Caption = '...'
      TabOrder = 6
      Visible = False
      OnClick = btnTermineClick
    end
    object edtTermine: TMaskEdit
      Left = 444
      Top = 39
      Width = 69
      Height = 21
      EditMask = '!00/00/0000;1;_'
      MaxLength = 10
      TabOrder = 7
      Text = '  /  /    '
      Visible = False
    end
  end
  object Panel2: TPanel [4]
    Left = 0
    Top = 58
    Width = 784
    Height = 215
    Align = alTop
    TabOrder = 4
    object pnlStato: TPanel
      Left = 588
      Top = 1
      Width = 195
      Height = 213
      Align = alClient
      TabOrder = 0
      object lblTermine: TLabel
        Left = 8
        Top = 87
        Width = 66
        Height = 13
        Caption = 'Termine diritto'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblQuantitaRestituita: TLabel
        Left = 8
        Top = 134
        Width = 82
        Height = 13
        Caption = 'Quantit'#224' restituita'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object dedtTermine: TDBEdit
        Left = 8
        Top = 102
        Width = 70
        Height = 21
        DataField = 'TERMINE_DIRITTO'
        DataSource = DButton
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object drdgStato: TDBRadioGroup
        Left = 8
        Top = 37
        Width = 180
        Height = 37
        Caption = 'Stato'
        Columns = 3
        DataField = 'STATO'
        DataSource = DButton
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Aperta'
          'Chiusa'
          'Fruibile')
        ParentFont = False
        TabOrder = 0
        Values.Strings = (
          'A'
          'C'
          'F')
      end
      object dedtQuantitaRestituita: TDBEdit
        Left = 8
        Top = 148
        Width = 49
        Height = 21
        DataField = 'QUANTITA_RESTITUITA'
        DataSource = DButton
        Enabled = False
        TabOrder = 2
      end
    end
    object pnlDati: TPanel
      Left = 1
      Top = 1
      Width = 587
      Height = 213
      Align = alLeft
      TabOrder = 1
      object lblAnno: TLabel
        Left = 187
        Top = 25
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
      object lblRaggruppamento: TLabel
        Left = 8
        Top = 87
        Width = 82
        Height = 13
        Caption = 'Raggruppamento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblDecorrenza: TLabel
        Left = 273
        Top = 25
        Width = 55
        Height = 13
        Caption = 'Decorrenza'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblScadenza: TLabel
        Left = 439
        Top = 25
        Width = 48
        Height = 13
        Caption = 'Scadenza'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblIDRichiesta: TLabel
        Left = 8
        Top = 56
        Width = 79
        Height = 13
        Caption = 'Numero richiesta'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblDescrizione: TLabel
        Left = 157
        Top = 56
        Width = 55
        Height = 13
        Caption = 'Descrizione'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblQuantitaRichiesta: TLabel
        Left = 164
        Top = 134
        Width = 82
        Height = 13
        Caption = 'Quantit'#224' richiesta'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblQuantitaOttenuta: TLabel
        Left = 302
        Top = 134
        Width = 82
        Height = 13
        Caption = 'Quantit'#224' ottenuta'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblQuantitaOfferta: TLabel
        Left = 164
        Top = 171
        Width = 73
        Height = 13
        Caption = 'Quantit'#224' offerta'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblQuantitaAccettata: TLabel
        Left = 302
        Top = 171
        Width = 88
        Height = 13
        Caption = 'Quantit'#224' accettata'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblDescRaggruppamento: TLabel
        Left = 98
        Top = 106
        Width = 117
        Height = 13
        Caption = 'lblDescRaggruppamento'
      end
      object lblCausale: TLabel
        Left = 302
        Top = 87
        Width = 38
        Height = 13
        Caption = 'Causale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblDescCausale: TLabel
        Left = 396
        Top = 106
        Width = 73
        Height = 13
        Caption = 'lblDescCausale'
      end
      object lblTotOfferte: TLabel
        Left = 417
        Top = 134
        Width = 63
        Height = 13
        Caption = 'Totale offerte'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object drdgTipo: TDBRadioGroup
        Left = 8
        Top = 8
        Width = 140
        Height = 35
        Caption = 'Tipo'
        Columns = 2
        DataField = 'TIPO'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Richiesta'
          'Offerta')
        ParentFont = False
        TabOrder = 0
        Values.Strings = (
          'R'
          'O')
        OnClick = drdgTipoClick
      end
      object dedtAnno: TDBEdit
        Left = 215
        Top = 22
        Width = 40
        Height = 21
        DataField = 'ANNO'
        DataSource = DButton
        TabOrder = 1
        OnExit = dedtAnnoExit
      end
      object dcmbRaggruppamento: TDBLookupComboBox
        Left = 8
        Top = 102
        Width = 85
        Height = 21
        DataField = 'CODRAGGR'
        DataSource = DButton
        DropDownWidth = 200
        KeyField = 'Codice'
        ListField = 'Codice;Descrizione'
        TabOrder = 9
        OnCloseUp = dcmbRaggruppamentoCloseUp
        OnKeyDown = dcmbRaggruppamentoKeyDown
        OnKeyUp = dcmbRaggruppamentoKeyUp
      end
      object dRdgUMisura: TDBRadioGroup
        Left = 8
        Top = 134
        Width = 85
        Height = 71
        Caption = 'Unit'#224' di misura'
        DataField = 'UMisura'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Giorni'
          'Ore')
        ParentFont = False
        TabOrder = 11
        Values.Strings = (
          'G'
          'O')
        OnClick = dRdgUMisuraClick
      end
      object dedtDecorrenza: TDBEdit
        Left = 333
        Top = 22
        Width = 70
        Height = 21
        DataField = 'DECORRENZA'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object dedtScadenza: TDBEdit
        Left = 492
        Top = 22
        Width = 70
        Height = 21
        DataField = 'DECORRENZA_FINE'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object dedtIDRichiesta: TDBEdit
        Left = 90
        Top = 53
        Width = 40
        Height = 21
        DataField = 'ID_RICHIESTA'
        DataSource = DButton
        Enabled = False
        TabOrder = 6
      end
      object dedtDescrizione: TDBEdit
        Left = 215
        Top = 53
        Width = 365
        Height = 21
        DataField = 'DESCRIZIONE'
        DataSource = DButton
        TabOrder = 8
      end
      object dedtQuantitaRichiesta: TDBEdit
        Left = 164
        Top = 148
        Width = 50
        Height = 21
        DataField = 'QUANTITA_RICHIESTA'
        DataSource = DButton
        TabOrder = 12
      end
      object btnDecorrenza: TButton
        Left = 404
        Top = 22
        Width = 17
        Height = 21
        Caption = '...'
        TabOrder = 3
        OnClick = btnDecorrenzaClick
      end
      object btnScadenza: TButton
        Left = 563
        Top = 22
        Width = 17
        Height = 21
        Caption = '...'
        TabOrder = 5
        OnClick = btnScadenzaClick
      end
      object dedtQuantitaOttenuta: TDBEdit
        Left = 302
        Top = 148
        Width = 50
        Height = 21
        DataField = 'QUANTITA_OTTENUTA'
        DataSource = DButton
        Enabled = False
        TabOrder = 13
      end
      object dedtQuantitaOfferta: TDBEdit
        Left = 164
        Top = 184
        Width = 50
        Height = 21
        DataField = 'QUANTITA_OFFERTA'
        DataSource = DButton
        TabOrder = 16
      end
      object dedtQuantitaAccettata: TDBEdit
        Left = 302
        Top = 184
        Width = 50
        Height = 21
        DataField = 'QUANTITA_ACCETTATA'
        DataSource = DButton
        Enabled = False
        TabOrder = 17
      end
      object btnIDRichiesta: TButton
        Left = 131
        Top = 53
        Width = 17
        Height = 21
        Caption = '...'
        TabOrder = 7
        OnClick = btnIDRichiestaClick
      end
      object dcmbCausale: TDBLookupComboBox
        Left = 302
        Top = 102
        Width = 88
        Height = 21
        DataField = 'CAUSALE'
        DataSource = DButton
        DropDownWidth = 200
        KeyField = 'Codice'
        ListField = 'Codice;Descrizione'
        TabOrder = 10
        OnCloseUp = dcmbCausaleCloseUp
        OnKeyDown = dcmbRaggruppamentoKeyDown
        OnKeyUp = dcmbCausaleKeyUp
      end
      object btnVisOfferte: TBitBtn
        Left = 477
        Top = 148
        Width = 87
        Height = 21
        Caption = 'Dettaglio offerte'
        Enabled = False
        TabOrder = 15
        OnClick = btnVisOfferteClick
      end
      object edtTotOfferte: TEdit
        Left = 418
        Top = 148
        Width = 50
        Height = 21
        TabStop = False
        Enabled = False
        TabOrder = 14
      end
    end
  end
  object dgrdFerieSolidali: TDBGrid [5]
    Left = 0
    Top = 273
    Width = 784
    Height = 171
    Align = alClient
    DataSource = A177FFerieSolidaliDM.dsrT254Vis
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    PopupMenu = MnuCopia
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  inherited MainMenu1: TMainMenu [6]
    Left = 432
    Top = 28
  end
  inherited DButton: TDataSource [7]
    Left = 468
    Top = 28
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog [8]
    Left = 504
    Top = 28
  end
  inherited ImageList1: TImageList [9]
    Left = 540
    Top = 28
  end
  inherited ActionList1: TActionList
    Left = 576
    Top = 28
  end
  object MnuCopia: TPopupMenu
    Left = 560
    Top = 306
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      OnClick = Selezionatutto1Click
    end
    object Annullatutto1: TMenuItem
      Caption = 'Deseleziona tutto'
      OnClick = Annullatutto1Click
    end
    object Invertiselezione1: TMenuItem
      Caption = 'Inverti selezione'
      OnClick = Invertiselezione1Click
    end
    object N9: TMenuItem
      Caption = '-'
    end
    object Copia1: TMenuItem
      Caption = 'Copia'
      OnClick = Copia1Click
    end
    object CopiaInExcel: TMenuItem
      Caption = 'Copia in Excel'
      OnClick = Copia1Click
    end
  end
end
