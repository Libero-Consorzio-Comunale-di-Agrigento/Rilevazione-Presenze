inherited A207FProfiliStampeRep: TA207FProfiliStampeRep
  HelpContext = 207000
  BorderStyle = bsSingle
  Caption = '<A207> Profili stampe reperibili'
  ClientHeight = 599
  ClientWidth = 439
  ExplicitWidth = 445
  ExplicitHeight = 648
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 581
    Width = 439
    ExplicitTop = 581
    ExplicitWidth = 439
  end
  inherited Panel1: TToolBar
    Width = 439
    ExplicitWidth = 439
  end
  object grpDettaglioTabellone: TGroupBox [2]
    AlignWithMargins = True
    Left = 5
    Top = 470
    Width = 429
    Height = 104
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alTop
    Caption = 'Dettaglio tabellone'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object grpDatiPianif: TGroupBox
      Left = 9
      Top = 17
      Width = 227
      Height = 80
      Caption = 'Dati pianificazione'
      TabOrder = 0
      object dchkCodice: TDBCheckBox
        Left = 7
        Top = 17
        Width = 71
        Height = 17
        Caption = 'Codice'
        DataField = 'DETT_CODICE'
        DataSource = DButton
        TabOrder = 0
        ValueChecked = 'S'
        ValueUnchecked = 'N'
        OnClick = dchkCodiceClick
      end
      object dchkSigla: TDBCheckBox
        Left = 79
        Top = 17
        Width = 71
        Height = 17
        Caption = 'Sigla'
        DataField = 'DETT_SIGLA'
        DataSource = DButton
        TabOrder = 1
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dchkDatoLibero: TDBCheckBox
        Left = 7
        Top = 67
        Width = 214
        Height = 17
        Caption = 'Dato libero pianif.'
        DataField = 'DETT_DATO_LIBERO'
        DataSource = DButton
        TabOrder = 2
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dchkDatiAggInRiga: TDBCheckBox
        Left = 151
        Top = 57
        Width = 71
        Height = 17
        Caption = 'In riga'
        DataField = 'DETT_DATI_AGG_RIGA'
        DataSource = DButton
        TabOrder = 3
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dchkDatiAggiuntivi: TDBCheckBox
        Left = 7
        Top = 57
        Width = 143
        Height = 17
        Caption = 'Dati aggiuntivi'
        DataField = 'DETT_DATI_AGG'
        DataSource = DButton
        TabOrder = 4
        ValueChecked = 'S'
        ValueUnchecked = 'N'
        OnClick = dchkDatiAggiuntiviClick
      end
      object dchkOrarioInRiga: TDBCheckBox
        Left = 151
        Top = 37
        Width = 71
        Height = 17
        Caption = 'In riga'
        DataField = 'DETT_ORARIO_RIGA'
        DataSource = DButton
        TabOrder = 5
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dchkOrario: TDBCheckBox
        Left = 7
        Top = 37
        Width = 97
        Height = 17
        Caption = 'Orario'
        DataField = 'DETT_ORARIO'
        DataSource = DButton
        TabOrder = 6
        ValueChecked = 'S'
        ValueUnchecked = 'N'
        OnClick = dchkOrarioClick
      end
      object dchkPriorita: TDBCheckBox
        Left = 153
        Top = 14
        Width = 71
        Height = 17
        Caption = 'Priorit'#224
        DataField = 'DETT_PRIORITA'
        DataSource = DButton
        TabOrder = 7
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
    end
    object drgpDatiAssenza: TDBRadioGroup
      Left = 242
      Top = 17
      Width = 168
      Height = 80
      Caption = 'Dati assenza'
      DataField = 'DETT_ASSENZA'
      DataSource = DButton
      Items.Strings = (
        'No'
        'Codice causale'
        'Sigla definita')
      TabOrder = 1
      Values.Strings = (
        'N'
        'C'
        'S')
      OnClick = drgpDatiAssenzaClick
    end
    object dedtSiglaAssenza: TDBEdit
      Left = 341
      Top = 71
      Width = 58
      Height = 21
      DataField = 'DETT_SIGLA_ASSENZA'
      DataSource = DButton
      TabOrder = 2
    end
  end
  object pnlOpzioniTabellone: TPanel [3]
    Left = 0
    Top = 438
    Width = 439
    Height = 27
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object dchkLegenda: TDBCheckBox
      Left = 252
      Top = 6
      Width = 114
      Height = 17
      Caption = 'Visualizza legenda'
      DataField = 'LEGENDA'
      DataSource = DButton
      TabOrder = 0
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dchkIncludiNonPianif: TDBCheckBox
      Left = 5
      Top = 3
      Width = 212
      Height = 17
      Caption = 'Includi dipendenti non pianificati'
      DataField = 'DIP_NP'
      DataSource = DButton
      TabOrder = 1
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
  end
  object pnlCampoDettaglio: TPanel [4]
    Left = 0
    Top = 579
    Width = 439
    Height = 80
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 4
    object drgpDettaglio: TDBRadioGroup
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 429
      Height = 70
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alClient
      Caption = 'Campo di dettaglio'
      DataField = 'DETTAGLIO'
      DataSource = DButton
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
      Values.Strings = (
        'A'
        'R')
      OnChange = drgpDettaglioChange
    end
    object dcmbCampoDett: TDBLookupComboBox
      Left = 167
      Top = 21
      Width = 237
      Height = 21
      DataField = 'CAMPO_DETTAGLIO'
      DataSource = DButton
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
  object pnlCampoConNominativo: TPanel [5]
    Left = 0
    Top = 394
    Width = 439
    Height = 44
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 5
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
      Left = 4
      Top = 18
      Width = 237
      Height = 21
      DataField = 'CAMPO_NOMINATIVO'
      DataSource = DButton
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
    object dchkNomeCompleto: TDBCheckBox
      Left = 250
      Top = 20
      Width = 171
      Height = 17
      Caption = 'Nome completo nel nominativo'
      DataField = 'NOME_COMPLETO'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
  end
  object pnlSceltaTurni: TPanel [6]
    Left = 0
    Top = 363
    Width = 439
    Height = 31
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
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
      TabOrder = 0
      OnClick = btnScegliTurniClick
    end
    object drgpSelTurni: TDBRadioGroup
      Left = 293
      Top = -2
      Width = 127
      Height = 32
      Caption = 'Seleziona per'
      Columns = 2
      DataField = 'SELEZIONE'
      DataSource = DButton
      Items.Strings = (
        'Codice'
        'Orario')
      TabOrder = 1
      Values.Strings = (
        'C'
        'O')
      OnClick = drgpSelTurniClick
    end
    object dedtTurni: TDBEdit
      Left = 108
      Top = 6
      Width = 160
      Height = 21
      DataField = 'TURNI'
      DataSource = DButton
      TabOrder = 2
    end
  end
  object pnlRaggruppamento: TPanel [7]
    Left = 0
    Top = 316
    Width = 439
    Height = 47
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
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
      Left = 4
      Top = 19
      Width = 236
      Height = 21
      DataField = 'CAMPO_RAGGRUPPAMENTO'
      DataSource = DButton
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
    object dchkSaltoPagina: TDBCheckBox
      Left = 252
      Top = 22
      Width = 97
      Height = 17
      Caption = 'Salto pagina'
      DataField = 'SALTO_PAGINA'
      DataSource = DButton
      TabOrder = 1
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
  end
  object pnlTop: TPanel [8]
    Left = 0
    Top = 62
    Width = 439
    Height = 254
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 8
    object drgpTipoStampa: TDBRadioGroup
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 429
      Height = 74
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      Caption = 'Tipo stampa'
      Columns = 2
      DataField = 'TIPO'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Items.Strings = (
        'Tabellone mensile'
        'Tabellone personalizzato'
        'Prospetto per dipendente'
        'Prospetto per raggr.')
      ParentFont = False
      TabOrder = 0
      Values.Strings = (
        'M'
        'P'
        'D'
        'R')
      OnClick = drgpTipoStampaClick
    end
    object grpTitolo: TGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 185
      Width = 429
      Height = 64
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alBottom
      Caption = 'Titolo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
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
      object Label1: TLabel
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
      object dedtTitolo: TDBEdit
        Left = 50
        Top = 13
        Width = 365
        Height = 21
        DataField = 'TITOLO'
        DataSource = DButton
        TabOrder = 0
      end
      object dEdtTitoloSize: TDBEdit
        Left = 69
        Top = 37
        Width = 30
        Height = 21
        DataField = 'TITOLO_SIZE'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object dchkTitoloBold: TDBCheckBox
        Left = 172
        Top = 39
        Width = 114
        Height = 17
        Caption = 'Grassetto'
        DataField = 'TITOLO_BOLD'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dchkTitoloUnderline: TDBCheckBox
        Left = 302
        Top = 40
        Width = 114
        Height = 17
        Caption = 'Sottolineato'
        DataField = 'TITOLO_UNDERLINE'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
    end
    object grpLayout: TGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 89
      Width = 429
      Height = 91
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      Caption = 'Layout'
      TabOrder = 2
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
      object lblDimensione: TLabel
        Left = 302
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
      object Label4: TLabel
        Left = 9
        Top = 40
        Width = 43
        Height = 13
        Caption = 'Esempio:'
      end
      object lblEsempio: TLabel
        Left = 76
        Top = 40
        Width = 106
        Height = 13
        AutoSize = False
        Caption = 'AaBbCcYyZz'
        Layout = tlCenter
      end
      object lblFormato: TLabel
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
      object dcmbOrientamento: TDBComboBox
        Left = 76
        Top = 61
        Width = 97
        Height = 22
        Style = csOwnerDrawFixed
        DataField = 'ORIENTAMENTO'
        DataSource = DButton
        DropDownCount = 3
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'A'
          'V'
          'O')
        ParentFont = False
        TabOrder = 0
        OnDrawItem = dcmbOrientamentoDrawItem
      end
      object dcmbFont: TDBComboBox
        Left = 76
        Top = 13
        Width = 195
        Height = 22
        Style = csOwnerDrawFixed
        DataField = 'FONTNAME'
        DataSource = DButton
        DropDownCount = 3
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnChange = dcmbFontChange
      end
      object dedtSize: TDBEdit
        Left = 362
        Top = 13
        Width = 30
        Height = 21
        DataField = 'FONTSIZE'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object dcmbFormato: TDBComboBox
        Left = 227
        Top = 61
        Width = 188
        Height = 22
        Style = csOwnerDrawFixed
        DataField = 'FORMATO'
        DataSource = DButton
        DropDownCount = 3
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
    end
  end
  object Panel2: TPanel [9]
    Left = 0
    Top = 24
    Width = 439
    Height = 38
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 9
    object lblCodProfilo: TLabel
      Left = 12
      Top = 0
      Width = 36
      Height = 13
      Caption = 'Codice:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblDescProfilo: TLabel
      Left = 83
      Top = 0
      Width = 58
      Height = 13
      Caption = 'Descrizione:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dEdtCodice: TDBEdit
      Left = 12
      Top = 13
      Width = 65
      Height = 21
      DataField = 'CODICE'
      DataSource = DButton
      TabOrder = 0
    end
    object dEdtDesc: TDBEdit
      Left = 83
      Top = 13
      Width = 337
      Height = 21
      DataField = 'DESCRIZIONE'
      DataSource = DButton
      TabOrder = 1
    end
  end
end
