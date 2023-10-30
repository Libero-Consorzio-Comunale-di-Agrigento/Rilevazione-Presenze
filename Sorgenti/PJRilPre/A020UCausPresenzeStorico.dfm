inherited A020FCausPresStorico: TA020FCausPresStorico
  HelpContext = 20700
  BorderStyle = bsSingle
  Caption = '<A020> Causali di presenza - Parametri storicizzati'
  ClientHeight = 506
  ClientWidth = 557
  ExplicitWidth = 563
  ExplicitHeight = 555
  PixelsPerInch = 96
  TextHeight = 13
  object lblCodice: TLabel [0]
    Left = 8
    Top = 72
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
  object lblDescCausale: TLabel [1]
    Left = 124
    Top = 72
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
  object lblDescrizione: TLabel [2]
    Left = 8
    Top = 154
    Width = 96
    Height = 13
    Caption = 'Descrizione periodo:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblCausTimb: TLabel [3]
    Left = 8
    Top = 99
    Width = 141
    Height = 13
    Caption = 'Causalizzazione su timbrature:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblInclEsclOreNorm: TLabel [4]
    Left = 8
    Top = 126
    Width = 160
    Height = 13
    Caption = 'Inclusione/esclusione ore normali:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblCausCompDebitoGG: TLabel [5]
    Left = 280
    Top = 222
    Width = 183
    Height = 13
    Caption = 'Causale per compensazione debito gg:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblDetrazRiepprSeq: TLabel [6]
    Left = 280
    Top = 248
    Width = 157
    Height = 13
    Hint = 
      'Ordine numerico con cui la causale viene considerata per applica' +
      're le detrazioni su straordinario da ore normali dai conteggi gi' +
      'ornalieri'
    Caption = 'Ordine di detrazione straordinario:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
  end
  inherited StatusBar: TStatusBar
    Top = 488
    Width = 557
    ExplicitTop = 416
    ExplicitWidth = 557
  end
  inherited grbDecorrenza: TGroupBox
    Width = 557
    TabOrder = 0
    ExplicitWidth = 557
    inherited lblDecorrenza: TLabel
      Top = 14
      ExplicitTop = 14
    end
  end
  inherited ToolBar1: TToolBar
    Width = 557
    TabOrder = 1
    ExplicitWidth = 557
    inherited ToolButton2: TToolButton
      Visible = False
    end
  end
  object dedtCodice: TDBEdit [10]
    Left = 52
    Top = 69
    Width = 58
    Height = 21
    Color = clBtnFace
    DataField = 'CODICE'
    DataSource = DButton
    TabOrder = 2
  end
  object dedtDescCausale: TDBEdit [11]
    Left = 186
    Top = 69
    Width = 359
    Height = 21
    Color = clBtnFace
    DataField = 'DESC_CAUSALE'
    DataSource = DButton
    TabOrder = 3
  end
  object dedtDescrizione: TDBEdit [12]
    Left = 110
    Top = 151
    Width = 435
    Height = 21
    DataField = 'DESCRIZIONE'
    DataSource = DButton
    TabOrder = 6
  end
  object dchkNonAbilEliminaTimb: TDBCheckBox [13]
    Left = 228
    Top = 379
    Width = 319
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Timbrature non considerate se causale non abilitata (nascosto)'
    DataField = 'NONABILITATA_ELIMINATIMB'
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 15
    ValueChecked = 'S'
    ValueUnchecked = 'N'
    Visible = False
  end
  object dchkAnomCausNonAccop: TDBCheckBox [14]
    Left = 228
    Top = 395
    Width = 319
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Anomalia bloccante se causale non accoppiata (nascosto)'
    DataField = 'NONACCOPPIATA_ANOMBLOCC'
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 16
    ValueChecked = 'S'
    ValueUnchecked = 'N'
    Visible = False
  end
  object edtCausTimb: TEdit [15]
    Left = 186
    Top = 96
    Width = 359
    Height = 21
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 4
    Text = 'edtCausTimb'
  end
  object edtInclEsclOreNorm: TEdit [16]
    Left = 186
    Top = 123
    Width = 359
    Height = 21
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 5
    Text = 'edtInclEsclOreNorm'
  end
  object dcmbCausCompDebitoGG: TDBLookupComboBox [17]
    Left = 469
    Top = 219
    Width = 76
    Height = 21
    DataField = 'CAUSCOMP_DEBITOGG'
    DataSource = DButton
    DropDownRows = 8
    DropDownWidth = 300
    KeyField = 'CODICE'
    ListField = 'CODICE;DESCRIZIONE'
    TabOrder = 10
  end
  object dedtDetrazRiepprSeq: TDBEdit [18]
    Left = 469
    Top = 245
    Width = 76
    Height = 21
    DataField = 'DETRAZ_RIEPPR_SEQ'
    DataSource = DButton
    MaxLength = 4
    TabOrder = 11
  end
  object grpIterAutStr: TGroupBox [19]
    Left = 8
    Top = 340
    Width = 265
    Height = 72
    Caption = 'Iter autorizzativo straordinari'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 14
    object lblIterAutStrArrotLiq: TLabel
      Left = 7
      Top = 20
      Width = 127
      Height = 13
      Caption = 'Arrotondamento liquidabile:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dedtIterAutStrArrotLiq: TDBEdit
      Left = 206
      Top = 18
      Width = 40
      Height = 21
      DataField = 'ITER_AUTSTR_ARROT_LIQ'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object dchkIterAutStrArrotLiqFasce: TDBCheckBox
      Left = 7
      Top = 43
      Width = 244
      Height = 14
      Caption = 'Arrotond. liquidabile applicato alle singole fasce'
      DataField = 'ITER_AUTSTR_ARROT_LIQ_FASCE'
      DataSource = DButton
      TabOrder = 1
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
  end
  object drgpConteggioTimbInterna: TDBRadioGroup [20]
    Left = 277
    Top = 269
    Width = 268
    Height = 65
    Caption = 'Tipo conteggio dalle..alle se timbratura interna'
    DataField = 'CONTEGGIO_TIMB_INTERNA'
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Items.Strings = (
      'Termina prima della timbratura'
      'Scelta intervallo maggiore'
      'Compensazione')
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 13
    Values.Strings = (
      'P'
      'S'
      'C')
  end
  object drgpIntersezioneTimbrature: TDBRadioGroup [21]
    Left = 8
    Top = 269
    Width = 265
    Height = 65
    Hint = 'Valorizzazione tramite i Parametri storicizzati'
    Caption = 'Sovrapposizione su timbrature'
    DataField = 'INTERSEZIONE_TIMBRATURE'
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Items.Strings = (
      'Conteggia entrambi'
      'Conteggia timbrature'
      'Conteggia giustificativi')
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 12
    Values.Strings = (
      'E'
      'T'
      'G')
    OnChange = drgpIntersezioneTimbratureChange
  end
  object dchkAutoCompletamentoUE: TDBCheckBox [22]
    Left = 280
    Top = 180
    Width = 265
    Height = 15
    Alignment = taLeftJustify
    Caption = 'Auto-completamento se manca una causale'
    DataField = 'AUTOCOMPLETAMENTO_UE'
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 8
    ValueChecked = 'S'
    ValueUnchecked = 'N'
    OnClick = dchkAutoCompletamentoUEClick
  end
  object dchkSeparaCausaliUE: TDBCheckBox [23]
    Left = 280
    Top = 199
    Width = 265
    Height = 13
    Alignment = taLeftJustify
    Caption = 'Mantiene le causalizzazioni separate'
    DataField = 'SEPARA_CAUSALI_UE'
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 9
    ValueChecked = 'S'
    ValueUnchecked = 'N'
  end
  object grpPausaMensa: TGroupBox [24]
    Left = 8
    Top = 174
    Width = 265
    Height = 91
    Caption = 'Pausa mensa'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    object dchkTimbPM: TDBCheckBox
      Left = 7
      Top = 34
      Width = 251
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Considera i giustificativi dalle..alle'
      DataField = 'TIMB_PM'
      DataSource = DButton
      ParentShowHint = False
      ShowHint = False
      TabOrder = 1
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dchkTimbPMDetraz: TDBCheckBox
      Left = 7
      Top = 66
      Width = 251
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Ore rese conteggiate al netto della pausa mensa'
      DataField = 'TIMB_PM_DETRAZ'
      DataSource = DButton
      ParentShowHint = False
      ShowHint = False
      TabOrder = 3
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dchkTimbPMH: TDBCheckBox
      Left = 7
      Top = 50
      Width = 251
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Considera i giustificativi in numero ore'
      DataField = 'TIMB_PM_H'
      DataSource = DButton
      ParentShowHint = False
      ShowHint = False
      TabOrder = 2
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dchkMaturaMensa: TDBCheckBox
      Left = 7
      Top = 18
      Width = 251
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Matura pausa mensa'
      DataField = 'MATURAMENSA'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 0
      ValueChecked = 'S'
      ValueUnchecked = 'N'
      OnClick = dchkMaturaMensaClick
    end
  end
  object dchkSpezzStraord: TDBCheckBox [25]
    Left = 280
    Top = 340
    Width = 265
    Height = 13
    Alignment = taLeftJustify
    Caption = 'Applica le regole degli spezzoni di straordinario'
    DataField = 'SPEZZ_STRAORD'
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 18
    ValueChecked = 'S'
    ValueUnchecked = 'N'
  end
  object dchkRiconoscimentoTurno: TDBCheckBox [26]
    Left = 280
    Top = 358
    Width = 265
    Height = 13
    Alignment = taLeftJustify
    Caption = 'Riconoscimento turno anche se causalizzato'
    DataField = 'RICONOSCIMENTO_TURNO'
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 19
    ValueChecked = 'S'
    ValueUnchecked = 'N'
  end
  object grpCondizioneAbilitazione: TGroupBox [27]
    Left = 8
    Top = 418
    Width = 541
    Height = 63
    Caption = 'Condizione di abilitazione'
    TabOrder = 20
    object dedtCondizioneAbilitazione: TDBEdit
      Left = 2
      Top = 15
      Width = 537
      Height = 46
      Align = alClient
      AutoSize = False
      DataField = 'CONDIZIONE_ABILITAZIONE'
      DataSource = DButton
      TabOrder = 0
      ExplicitLeft = 3
      ExplicitTop = 16
      ExplicitWidth = 535
      ExplicitHeight = 136
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 360
    Top = 24
  end
  inherited DButton: TDataSource
    Left = 388
    Top = 24
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 416
    Top = 24
  end
  inherited ImageList1: TImageList
    Left = 444
    Top = 24
  end
  inherited ActionList1: TActionList
    Left = 472
    Top = 24
    inherited actRicerca: TAction
      Visible = False
    end
    inherited actPrimo: TAction
      Visible = False
    end
    inherited actPrecedente: TAction
      Visible = False
    end
    inherited actSuccessivo: TAction
      Visible = False
    end
    inherited actUltimo: TAction
      Visible = False
    end
    inherited actInserisci: TAction
      Visible = False
    end
  end
end
