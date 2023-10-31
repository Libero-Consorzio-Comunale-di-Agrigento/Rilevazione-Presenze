inherited A204FModelliCertificazione: TA204FModelliCertificazione
  Tag = 183
  HelpContext = 204000
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '<A204> Modelli di scheda informativa'
  ClientHeight = 573
  ClientWidth = 831
  ExplicitWidth = 847
  ExplicitHeight = 632
  PixelsPerInch = 96
  TextHeight = 13
  object splModelliCategorie: TSplitter [0]
    Left = 0
    Top = 193
    Width = 831
    Height = 5
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 227
    ExplicitWidth = 802
  end
  object splCategorieDati: TSplitter [1]
    Left = 0
    Top = 366
    Width = 831
    Height = 5
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 386
  end
  inherited StatusBar: TStatusBar
    Top = 555
    Width = 831
    ExplicitTop = 555
    ExplicitWidth = 831
  end
  inherited Panel1: TToolBar
    Width = 831
    ExplicitWidth = 831
  end
  object pnlMasterModelli: TPanel [4]
    Left = 0
    Top = 24
    Width = 831
    Height = 169
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlMasterModelli'
    TabOrder = 2
    object dgrdModelli: TDBGrid
      Left = 0
      Top = 0
      Width = 831
      Height = 169
      Align = alClient
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlue
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnEditButtonClick = dgrdDatiButtonClick
      Columns = <
        item
          Expanded = False
          FieldName = 'CODICE'
          Visible = True
        end
        item
          ButtonStyle = cbsEllipsis
          Expanded = False
          FieldName = 'DESCRIZIONE'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'INIZIO_VALIDITA'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FINE_VALIDITA'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'AUTOCERTIFICAZIONE'
          PickList.Strings = (
            'S=S'#236
            'N=No')
          Visible = True
        end
        item
          ButtonStyle = cbsEllipsis
          Expanded = False
          FieldName = 'PERIODO'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PERIODO_MODIFICABILE'
          PickList.Strings = (
            'S=S'#236
            'N=No')
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'UM'
          PickList.Strings = (
            'D=Giorni'
            'W=Settimane'
            'M=Mesi'
            'Y=Anni')
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'QUANTITA'
          Visible = True
        end
        item
          ButtonStyle = cbsEllipsis
          Expanded = False
          FieldName = 'SELEZIONE_ANAGRAFE'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ORDINE'
          Visible = True
        end>
    end
  end
  object pnlCategorie: TPanel [5]
    Left = 0
    Top = 198
    Width = 831
    Height = 168
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlMasterModelli'
    TabOrder = 3
    object lblCategorie: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 3
      Width = 823
      Height = 13
      Margins.Left = 5
      Align = alTop
      Caption = 'Categorie'
      Layout = tlCenter
      ExplicitWidth = 45
    end
    object dgrdCategorie: TDBGrid
      Left = 0
      Top = 42
      Width = 831
      Height = 126
      Align = alClient
      DataSource = A204FModelliCertificazioneDtM.dsrSG236
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlue
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnEditButtonClick = dgrdDatiButtonClick
      Columns = <
        item
          Expanded = False
          FieldName = 'CODICE'
          Visible = True
        end
        item
          ButtonStyle = cbsEllipsis
          Expanded = False
          FieldName = 'DESCRIZIONE'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ORDINE'
          Visible = True
        end>
    end
    inline frmToolbarCategoria: TfrmToolbarFiglio
      Left = 0
      Top = 19
      Width = 831
      Height = 23
      Align = alTop
      TabOrder = 1
      TabStop = True
      ExplicitTop = 19
      ExplicitWidth = 831
      inherited tlbarFiglio: TToolBar
        Width = 831
        ExplicitWidth = 831
      end
    end
  end
  object pnlDati: TPanel [6]
    Left = 0
    Top = 371
    Width = 831
    Height = 184
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlMasterModelli'
    TabOrder = 4
    object lblDati: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 3
      Width = 823
      Height = 13
      Margins.Left = 5
      Align = alTop
      Caption = 'Dati'
      Layout = tlCenter
      ExplicitWidth = 19
    end
    object dgrdDati: TDBGrid
      Left = 0
      Top = 42
      Width = 831
      Height = 142
      Align = alClient
      DataSource = A204FModelliCertificazioneDtM.dsrSG237
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlue
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnEditButtonClick = dgrdDatiButtonClick
      OnKeyPress = dgrdDatiKeyPress
      Columns = <
        item
          Expanded = False
          FieldName = 'CODICE'
          Visible = True
        end
        item
          ButtonStyle = cbsEllipsis
          Expanded = False
          FieldName = 'DESCRIZIONE'
          Visible = True
        end
        item
          ButtonStyle = cbsEllipsis
          Expanded = False
          FieldName = 'HINT'
          Width = 94
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ORDINE'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'OBBLIGATORIO'
          PickList.Strings = (
            'S=S'#236
            'N=No')
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FORMATO'
          PickList.Strings = (
            'S=Stringa'
            'C=Checkbox'
            'N=Numero'
            'D=Data'
            'M=Messaggio'
            'U=Url'
            'T=Testo su due colonne')
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'LUNG_MAX'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'RIGHE'
          Width = 64
          Visible = True
        end
        item
          ButtonStyle = cbsEllipsis
          Expanded = False
          FieldName = 'VALORI'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATO_ANAGRAFICO'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'QUERY_VALORE'
          Width = 64
          Visible = True
        end
        item
          ButtonStyle = cbsEllipsis
          Expanded = False
          FieldName = 'VALIDAZIONE'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALORE_DEFAULT'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ELENCO_FISSO'
          PickList.Strings = (
            'S=S'#236
            'N=No')
          Width = 64
          Visible = True
        end>
    end
    inline frmToolbarDati: TfrmToolbarFiglio
      Left = 0
      Top = 19
      Width = 831
      Height = 23
      Align = alTop
      TabOrder = 1
      TabStop = True
      ExplicitTop = 19
      ExplicitWidth = 831
      inherited tlbarFiglio: TToolBar
        Width = 831
        ExplicitWidth = 831
      end
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 232
    Top = 34
  end
  inherited DButton: TDataSource
    Left = 260
    Top = 34
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 288
    Top = 34
  end
  inherited ImageList1: TImageList
    Left = 316
    Top = 34
  end
  inherited ActionList1: TActionList
    Left = 344
    Top = 34
  end
end
