object A040FDialogStampa: TA040FDialogStampa
  Left = 343
  Top = 287
  HelpContext = 40200
  Margins.Top = 0
  Margins.Bottom = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '<A040> Stampa reperibilit'#224' mensile'
  ClientHeight = 758
  ClientWidth = 427
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTipo: TPanel
    Left = 0
    Top = 94
    Width = 427
    Height = 84
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object rgpTipoStampa: TRadioGroup
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 417
      Height = 74
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alClient
      Caption = 'Tipo stampa'
      Columns = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 2
      Items.Strings = (
        'Tabellone mensile'
        'Tabellone personalizzato'
        'Prospetto per dipendente'
        'Prospetto per raggr.')
      ParentFont = False
      TabOrder = 0
      OnClick = rgpTipoStampaClick
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 725
    Width = 427
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 11
    object btnPrinterSetUp: TBitBtn
      Left = 5
      Top = 4
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
      OnClick = btnPrinterSetUpClick
    end
    object btnAnteprima: TBitBtn
      Left = 113
      Top = 4
      Width = 100
      Height = 25
      Caption = '&Anteprima'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFF000000000000FF000FFFFFFFFFF0F0000FFFFFFF0000800F0FFFFFF08778
        08FF0FFFFF0877E880FF0FFFFF07777870FF0FFFFF07E77870FF0FFFFF08EE78
        80FF0FFFFFF087780FFF0FFFFFFF0000FFFF0FFFFFFFFFF0FFFF0FFFFFFF0000
        FFFF0FFFFFFF070FFFFF0FFFFFFF00FFFFFF000000000FFFFFFF}
      ParentFont = False
      TabOrder = 1
      OnClick = btnStampaClick
    end
    object btnStampa: TBitBtn
      Left = 217
      Top = 4
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
      OnClick = btnStampaClick
    end
    object btnClose: TBitBtn
      Left = 320
      Top = 4
      Width = 100
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 3
    end
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 709
    Width = 427
    Height = 16
    Align = alBottom
    TabOrder = 10
  end
  object pnlProfili: TPanel
    Left = 0
    Top = 0
    Width = 427
    Height = 36
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object dLblDescProfilo: TDBText
      Left = 218
      Top = 12
      Width = 74
      Height = 13
      AutoSize = True
      DataField = 'DESCRIZIONE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblProfilo: TLabel
      Left = 14
      Top = 12
      Width = 29
      Height = 13
      Caption = 'Profilo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dCmbLkpProfili: TDBLookupComboBox
      Left = 55
      Top = 8
      Width = 149
      Height = 21
      DropDownRows = 10
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      KeyField = 'CODICE'
      ListField = 'CODICE;DESCRIZIONE'
      ParentFont = False
      PopupMenu = ppMnuAccedi
      TabOrder = 0
      OnClick = dCmbLkpProfiliClick
      OnKeyDown = dCmbLkpProfiliKeyDown
    end
  end
  object pnlPeriodo: TPanel
    Left = 0
    Top = 36
    Width = 427
    Height = 58
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 1
    object grpPeriodo: TGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 417
      Height = 48
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alClient
      Caption = 'Periodo elaborazione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object lblDataDa: TLabel
        Left = 9
        Top = 20
        Width = 16
        Height = 13
        Caption = 'Dal'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblDataA: TLabel
        Left = 214
        Top = 20
        Width = 8
        Height = 13
        Caption = 'al'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object edtDataDa: TMaskEdit
        Left = 50
        Top = 17
        Width = 70
        Height = 21
        EditMask = '!00/00/0000;1;_'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
        Text = '  /  /    '
      end
      object btnDataDa: TBitBtn
        Left = 120
        Top = 17
        Width = 15
        Height = 21
        Hint = 'Data inizio periodo'
        Caption = '...'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = btnDataDaClick
      end
      object edtDataA: TMaskEdit
        Left = 244
        Top = 17
        Width = 73
        Height = 21
        EditMask = '!00/00/0000;1;_'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 2
        Text = '  /  /    '
        OnDblClick = edtDataADblClick
      end
      object btnDataA: TBitBtn
        Left = 317
        Top = 17
        Width = 15
        Height = 21
        Hint = 'Data fine periodo'
        Caption = '...'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = btnDataDaClick
      end
    end
  end
  object pnlTitolo: TPanel
    Left = 0
    Top = 279
    Width = 427
    Height = 75
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 4
    object GroupBox1: TGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 417
      Height = 65
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alClient
      Caption = 'Titolo'
      TabOrder = 0
      object lblTitolo: TLabel
        Left = 9
        Top = 16
        Width = 27
        Height = 13
        Caption = 'Testo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblTitoloSize: TLabel
        Left = 9
        Top = 40
        Width = 55
        Height = 13
        Caption = 'Dimensione'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object edtTitolo: TEdit
        Left = 50
        Top = 13
        Width = 358
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnExit = edtTitoloExit
      end
      object edtTitoloSize: TEdit
        Left = 76
        Top = 37
        Width = 41
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        NumbersOnly = True
        ParentFont = False
        TabOrder = 1
      end
      object chkTitoloBold: TCheckBox
        Left = 184
        Top = 39
        Width = 97
        Height = 17
        Caption = 'Grassetto'
        TabOrder = 2
      end
      object chkTitoloUnderline: TCheckBox
        Left = 311
        Top = 35
        Width = 97
        Height = 25
        Caption = 'Sottolineato'
        TabOrder = 3
      end
    end
  end
  object pnlLayout: TPanel
    Left = 0
    Top = 178
    Width = 427
    Height = 101
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 3
    object grpLayout: TGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 417
      Height = 91
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alClient
      Caption = 'Layout'
      TabOrder = 0
      object Label2: TLabel
        Left = 9
        Top = 16
        Width = 21
        Height = 13
        Caption = 'Font'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblOPagina: TLabel
        Left = 9
        Top = 64
        Width = 63
        Height = 13
        Caption = 'Orientamento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 307
        Top = 16
        Width = 55
        Height = 13
        Caption = 'Dimensione'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblEsempio: TLabel
        Left = 76
        Top = 40
        Width = 185
        Height = 13
        AutoSize = False
        Caption = 'AaBbCcYyZz'
        Layout = tlCenter
      end
      object Label1: TLabel
        Left = 9
        Top = 40
        Width = 43
        Height = 13
        Caption = 'Esempio:'
      end
      object Label4: TLabel
        Left = 183
        Top = 64
        Width = 38
        Height = 13
        Caption = 'Formato'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object edtSize: TEdit
        Left = 367
        Top = 13
        Width = 41
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        NumbersOnly = True
        ParentFont = False
        TabOrder = 0
      end
      object cmbFont: TComboBox
        Left = 76
        Top = 13
        Width = 187
        Height = 22
        Style = csOwnerDrawFixed
        TabOrder = 1
        OnChange = cmbFontChange
      end
      object cmbOrientamento: TComboBox
        Left = 76
        Top = 61
        Width = 97
        Height = 22
        Style = csOwnerDrawFixed
        ItemIndex = 0
        TabOrder = 2
        Text = '(non impostato)'
        Items.Strings = (
          '(non impostato)'
          'Verticale'
          'Orizzontale')
      end
      object cmbFormato: TComboBox
        Left = 227
        Top = 59
        Width = 181
        Height = 22
        Style = csOwnerDrawFixed
        TabOrder = 3
      end
    end
  end
  object pnlRaggruppamento: TPanel
    Left = 0
    Top = 354
    Width = 427
    Height = 47
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 5
    object lblCampoRaggr: TLabel
      Left = 5
      Top = 4
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
    object dcmbCampoRaggr: TDBLookupComboBox
      Left = 5
      Top = 19
      Width = 236
      Height = 21
      DropDownRows = 10
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      KeyField = 'NOME_CAMPO'
      ListField = 'NOME_LOGICO'
      ParentFont = False
      TabOrder = 0
      OnClick = dcmbCampoRaggrClick
      OnKeyDown = dcmbCampoRaggrKeyDown
    end
    object chkSaltoPagina: TCheckBox
      Left = 252
      Top = 22
      Width = 89
      Height = 17
      Caption = 'Salto pagina'
      TabOrder = 1
    end
  end
  object pnlSceltaTurni: TPanel
    Left = 0
    Top = 401
    Width = 427
    Height = 31
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 6
    object lblTurni: TLabel
      Left = 5
      Top = 9
      Width = 97
      Height = 13
      Caption = 'Turni da considerare'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object edtTurni: TEdit
      Left = 108
      Top = 6
      Width = 160
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object btnScegliTurni: TButton
      Left = 268
      Top = 6
      Width = 15
      Height = 21
      Hint = 'Scelta turni'
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnScegliTurniClick
    end
    object rgpSelTurni: TRadioGroup
      Left = 293
      Top = -2
      Width = 127
      Height = 32
      Caption = 'Seleziona per'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Codice'
        'Orario')
      TabOrder = 2
      OnClick = rgpSelTurniClick
    end
  end
  object pnlCampoConNominativo: TPanel
    Left = 0
    Top = 432
    Width = 427
    Height = 44
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 7
    object lblCampoConNom: TLabel
      Left = 5
      Top = 4
      Width = 199
      Height = 13
      Caption = 'Campo anagrafico associato al nominativo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dcmbCampoConNom: TDBLookupComboBox
      Left = 5
      Top = 20
      Width = 236
      Height = 21
      DropDownRows = 10
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      KeyField = 'NOME_CAMPO'
      ListField = 'NOME_LOGICO'
      ParentFont = False
      TabOrder = 0
      OnKeyDown = dcmbCampoRaggrKeyDown
    end
    object chkNomeCompleto: TCheckBox
      Left = 252
      Top = 20
      Width = 168
      Height = 17
      Caption = 'Nome completo nel nominativo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  object pnlOpzioniTabellone: TPanel
    Left = 0
    Top = 476
    Width = 427
    Height = 27
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 8
    object chkIncludiNonPianif: TCheckBox
      Left = 27
      Top = 3
      Width = 212
      Height = 17
      Caption = 'Includi dipendenti non pianificati'
      TabOrder = 0
    end
    object chkLegenda: TCheckBox
      Left = 252
      Top = 3
      Width = 114
      Height = 17
      Caption = 'Visualizza legenda'
      TabOrder = 1
    end
  end
  object pnlCampoDettaglio: TPanel
    Left = 0
    Top = 610
    Width = 427
    Height = 80
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 9
    object rgpCampoDettaglio: TRadioGroup
      AlignWithMargins = True
      Left = 5
      Top = 0
      Width = 417
      Height = 75
      Margins.Left = 5
      Margins.Top = 0
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alClient
      Caption = 'Campo di dettaglio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Items.Strings = (
        'Dato anagrafico'
        'Recapito alternativo')
      ParentFont = False
      TabOrder = 1
      OnClick = rgpCampoDettaglioClick
    end
    object dcmbCampoDett: TDBLookupComboBox
      Left = 168
      Top = 18
      Width = 236
      Height = 21
      DropDownRows = 10
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      KeyField = 'NOME_CAMPO'
      ListField = 'NOME_LOGICO'
      ParentFont = False
      TabOrder = 0
      OnKeyDown = dcmbCampoRaggrKeyDown
    end
  end
  object pnlDettaglioTabellone: TPanel
    Left = 0
    Top = 503
    Width = 427
    Height = 107
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 12
    object grpDettaglioTabellone: TGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 0
      Width = 417
      Height = 104
      Margins.Left = 5
      Margins.Top = 0
      Margins.Right = 5
      Margins.Bottom = 0
      Align = alTop
      Caption = 'Dettaglio tabellone'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object rgpDatiAssenza: TRadioGroup
        Left = 240
        Top = 17
        Width = 168
        Height = 80
        Caption = 'Dati assenza'
        ItemIndex = 0
        Items.Strings = (
          'No'
          'Codice causale'
          'Sigla definita')
        TabOrder = 1
        OnClick = rgpDatiAssenzaClick
      end
      object edtSiglaAssenza: TEdit
        Left = 341
        Top = 71
        Width = 58
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 5
        ParentFont = False
        TabOrder = 2
      end
      object grpDatiPianif: TGroupBox
        Left = 9
        Top = 17
        Width = 227
        Height = 80
        Caption = 'Dati pianificazione'
        TabOrder = 0
        DesignSize = (
          227
          80)
        object chkCodice: TCheckBox
          Left = 7
          Top = 17
          Width = 71
          Height = 17
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Codice'
          TabOrder = 0
          OnClick = chkCodiceClick
        end
        object chkOrario: TCheckBox
          Left = 7
          Top = 37
          Width = 143
          Height = 17
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Orario'
          TabOrder = 3
          OnClick = chkOrarioClick
        end
        object chkDatoLibero: TCheckBox
          Left = 7
          Top = 67
          Width = 214
          Height = 17
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Dato libero pianif.'
          TabOrder = 7
        end
        object chkSigla: TCheckBox
          Left = 79
          Top = 17
          Width = 71
          Height = 17
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Sigla'
          TabOrder = 1
        end
        object chkPriorita: TCheckBox
          Left = 151
          Top = 17
          Width = 71
          Height = 17
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Priorit'#224
          TabOrder = 2
        end
        object chkOrarioInRiga: TCheckBox
          Left = 151
          Top = 37
          Width = 71
          Height = 17
          Anchors = [akLeft, akTop, akRight]
          Caption = 'In riga'
          TabOrder = 4
        end
        object chkDatiAggInRiga: TCheckBox
          Left = 151
          Top = 57
          Width = 71
          Height = 17
          Anchors = [akLeft, akTop, akRight]
          Caption = 'In riga'
          TabOrder = 6
        end
        object chkDatiAggiuntivi: TCheckBox
          Left = 7
          Top = 57
          Width = 143
          Height = 17
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Dati aggiuntivi'
          TabOrder = 5
          OnClick = chkDatiAggiuntiviClick
        end
      end
    end
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 353
  end
  object ppMnuAccedi: TPopupMenu
    Left = 381
    Top = 1
    object Accedi1: TMenuItem
      Caption = 'Accedi'
      OnClick = Accedi1Click
    end
  end
end
