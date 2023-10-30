inherited P651FRelazioniTabelle: TP651FRelazioniTabelle
  Tag = 162
  Left = 195
  Top = 162
  HelpContext = 3651000
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  Caption = '<P651> Relazioni tabelle FLUPER'
  ClientHeight = 542
  ClientWidth = 784
  ExplicitWidth = 800
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 413
    Width = 784
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 285
    ExplicitWidth = 570
  end
  inherited StatusBar: TStatusBar
    Top = 524
    Width = 784
    Panels = <
      item
        Width = 10
      end
      item
        Text = 'Data lavoro'
        Width = 130
      end
      item
        Text = 'Records'
        Width = 100
      end
      item
        Width = 100
      end
      item
        Width = 150
      end>
    ExplicitTop = 524
    ExplicitWidth = 784
  end
  inherited grbDecorrenza: TGroupBox
    Width = 784
    TabOrder = 2
    ExplicitWidth = 784
    inherited btnStoricizza: TSpeedButton
      Left = 316
      ExplicitLeft = 316
    end
    inherited dedtDecorrenza: TDBEdit
      DataField = 'DECORRENZA'
    end
  end
  inherited ToolBar1: TToolBar
    Width = 784
    TabOrder = 1
    ExplicitWidth = 784
  end
  object dgrdRelazioni: TDBGrid [4]
    Left = 0
    Top = 103
    Width = 784
    Height = 310
    Align = alClient
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'DECORRENZA'
        Title.Caption = 'Decorrenza'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DECORRENZA_FINE'
        Title.Caption = 'Scadenza'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COD_DATO1'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCR_DATO1'
        Title.Caption = 'Descrizione'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COD_DATO2'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCR_DATO2'
        Title.Caption = 'Descrizione'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PERCENTUALE'
        Title.Caption = 'Perc. (%)'
        Width = 50
        Visible = True
      end>
  end
  object Panel1: TPanel [5]
    Left = 0
    Top = 63
    Width = 784
    Height = 40
    Align = alTop
    TabOrder = 0
    object lblTipologia: TLabel
      Left = 19
      Top = 12
      Width = 43
      Height = 13
      Caption = 'Tipologia'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object cmbTipologia: TDBLookupComboBox
      Left = 68
      Top = 8
      Width = 144
      Height = 21
      DropDownRows = 5
      KeyField = 'NOME_FLUSSO'
      ListField = 'NOME_FLUSSO'
      ListSource = P651FRelazioniTabelleDtM.dsrFlussi
      TabOrder = 0
      OnCloseUp = cmbTipologiaCloseUp
      OnKeyUp = cmbTipologiaKeyUp
    end
  end
  object MemoControlli: TMemo [6]
    Left = 0
    Top = 416
    Width = 784
    Height = 108
    Align = alBottom
    Color = cl3DLight
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 5
  end
  inherited MainMenu1: TMainMenu
    Left = 390
    Top = 65531
    inherited Strumenti1: TMenuItem
      inherited Primo1: TMenuItem
        Enabled = False
        Visible = False
      end
      inherited Precedente1: TMenuItem
        Enabled = False
        Visible = False
      end
      inherited Successivo1: TMenuItem
        Enabled = False
        Visible = False
      end
      inherited Ultimo1: TMenuItem
        Enabled = False
        Visible = False
      end
      inherited Inserisci1: TMenuItem
        Enabled = False
        Visible = False
      end
    end
  end
  inherited DButton: TDataSource
    Left = 417
    Top = 65531
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 444
    Top = 65531
  end
  inherited ImageList1: TImageList
    Left = 473
    Top = 65530
  end
  inherited ActionList1: TActionList
    Left = 500
    Top = 65530
    inherited actCopiaSu: TAction
      Visible = False
    end
    object actCopiaSuAltriDip: TAction
      Caption = 'Copia su altri dipendenti'
      Hint = 'Copia su altri dipendenti'
      ImageIndex = 11
    end
  end
end
