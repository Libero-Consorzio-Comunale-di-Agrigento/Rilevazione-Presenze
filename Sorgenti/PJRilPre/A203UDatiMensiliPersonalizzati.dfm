inherited A203FDatiMensiliPersonalizzati: TA203FDatiMensiliPersonalizzati
  HelpContext = 203000
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '<A203> Dati atipici'
  ClientHeight = 448
  ClientWidth = 927
  ExplicitWidth = 943
  ExplicitHeight = 507
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 430
    Width = 927
    ExplicitTop = 430
    ExplicitWidth = 927
  end
  inherited grbDecorrenza: TGroupBox
    Width = 927
    ExplicitWidth = 927
    inherited btnStoricizza: TSpeedButton
      Left = 494
      Top = 9
      ExplicitLeft = 494
      ExplicitTop = 9
    end
    object lblDataEnd: TLabel [2]
      Left = 154
      Top = 15
      Width = 81
      Height = 13
      Caption = 'Fine Decorrenza:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    inherited chkStoriciPrec: TCheckBox
      Left = 327
      ExplicitLeft = 327
    end
    inherited chkStoriciSucc: TCheckBox
      Left = 410
      ExplicitLeft = 410
    end
    object dedtDecorrenzaFine: TDBEdit
      Left = 238
      Top = 11
      Width = 73
      Height = 21
      DataField = 'DECORRENZA_FINE'
      DataSource = DButton
      TabOrder = 3
    end
  end
  inherited ToolBar1: TToolBar
    Width = 927
    ExplicitWidth = 927
  end
  object dgrdI011: TDBGrid [3]
    Left = 0
    Top = 236
    Width = 927
    Height = 194
    Align = alClient
    DataSource = DButton
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object pnlDettaglio: TPanel [4]
    Left = 0
    Top = 63
    Width = 927
    Height = 173
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 4
    object Label1: TLabel
      Left = 15
      Top = 7
      Width = 23
      Height = 13
      Caption = 'Dato'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 229
      Top = 7
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
    object Label3: TLabel
      Left = 227
      Top = 53
      Width = 57
      Height = 13
      Caption = 'Espressione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 130
      Top = 53
      Width = 60
      Height = 13
      Caption = 'Ordinamento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 15
      Top = 53
      Width = 60
      Height = 13
      Caption = 'Codice voce'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblDescVocePaghe: TLabel
      Left = 15
      Top = 99
      Width = 36
      Height = 13
      Caption = '______'
    end
    object Label5: TLabel
      Left = 16
      Top = 124
      Width = 105
      Height = 13
      Caption = 'Selezione anagrafiche'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dedtDato: TDBEdit
      Left = 15
      Top = 26
      Width = 182
      Height = 21
      DataField = 'Dato'
      DataSource = DButton
      TabOrder = 0
    end
    object desdDesc: TDBEdit
      Left = 229
      Top = 26
      Width = 319
      Height = 21
      DataField = 'Descrizione'
      DataSource = DButton
      TabOrder = 1
    end
    object dmemoEspressione: TDBMemo
      Left = 227
      Top = 72
      Width = 321
      Height = 40
      DataField = 'ESPRESSIONE'
      DataSource = DButton
      ScrollBars = ssVertical
      TabOrder = 2
    end
    object dedtOrdinamento: TDBEdit
      Left = 130
      Top = 72
      Width = 67
      Height = 21
      DataField = 'ORDINAMENTO'
      DataSource = DButton
      TabOrder = 3
    end
    object drgpTipo: TDBRadioGroup
      Left = 572
      Top = 7
      Width = 78
      Height = 105
      Caption = 'Tipo'
      DataField = 'TIPO'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Items.Strings = (
        'Data'
        'Ore'
        'Numero'
        'Stringa')
      ParentFont = False
      TabOrder = 4
      Values.Strings = (
        'D'
        'O'
        'N'
        'S')
    end
    object dedtVocePaghe: TDBEdit
      Left = 15
      Top = 72
      Width = 67
      Height = 21
      DataField = 'VOCEPAGHE'
      DataSource = DButton
      TabOrder = 5
      OnChange = dedtVocePagheChange
      OnExit = dedtVocePagheExit
    end
    object btnVocePaghe: TButton
      Left = 84
      Top = 72
      Width = 16
      Height = 21
      Caption = '...'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnClick = btnVocePagheClick
    end
    object dedtSelezioneAnagrafiche: TDBEdit
      Left = 15
      Top = 143
      Width = 533
      Height = 21
      DataField = 'SELEZIONE_ANAGRAFE'
      DataSource = DButton
      TabOrder = 7
    end
    inline C600frmSelAnagrafe: TC600frmSelAnagrafe
      Left = 572
      Top = 142
      Width = 47
      Height = 24
      TabOrder = 8
      TabStop = True
      ExplicitLeft = 572
      ExplicitTop = 142
      ExplicitWidth = 47
      inherited pnlSelAnagrafe: TPanel
        Width = 47
        ExplicitWidth = 47
        inherited btnSelezione: TBitBtn
          Left = 2
          OnClick = C600frmSelAnagrafebtnSelezioneClick
          ExplicitLeft = 2
        end
      end
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 720
    Top = 32
  end
  inherited DButton: TDataSource
    Left = 748
    Top = 32
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 776
    Top = 32
  end
  inherited ImageList1: TImageList
    Left = 804
    Top = 32
  end
  inherited ActionList1: TActionList
    Left = 832
    Top = 32
  end
end
