inherited A140FTurniServizi: TA140FTurniServizi
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '<A140> Servizi'
  ClientHeight = 354
  ClientWidth = 567
  OnShow = FormShow
  ExplicitWidth = 575
  ExplicitHeight = 400
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 336
    Width = 567
    ExplicitTop = 336
    ExplicitWidth = 485
  end
  inherited Panel1: TToolBar
    Width = 567
    ExplicitWidth = 485
  end
  object PageControl1: TPageControl [2]
    Left = 0
    Top = 29
    Width = 567
    Height = 307
    ActivePage = tabServizi
    Align = alClient
    TabOrder = 2
    OnChange = PageControl1Change
    OnChanging = PageControl1Changing
    ExplicitWidth = 485
    object tabParametriGenerali: TTabSheet
      Caption = 'Parametri generali'
      ImageIndex = 2
      ExplicitWidth = 477
      object Label1: TLabel
        Left = 26
        Top = 81
        Width = 97
        Height = 13
        Caption = 'Alternanza dei festivi'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 26
        Top = 134
        Width = 94
        Height = 13
        Caption = 'Alternanza dei feriali'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 26
        Top = 161
        Width = 157
        Height = 13
        Caption = 'GG disponibili per chiusura servizi'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object btnDataPrimoFestivo: TSpeedButton
        Left = 259
        Top = 52
        Width = 13
        Height = 22
        Caption = '...'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 26
        Top = 56
        Width = 89
        Height = 13
        Caption = 'Festivo di partenza'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object btnDataPrimoFeriale: TSpeedButton
        Left = 259
        Top = 105
        Width = 12
        Height = 22
        Caption = '...'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 26
        Top = 109
        Width = 86
        Height = 13
        Caption = 'Feriale di partenza'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 26
        Top = 31
        Width = 112
        Height = 13
        Caption = 'Calendario di riferimento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object DBText1: TDBText
        Left = 267
        Top = 31
        Width = 42
        Height = 13
        AutoSize = True
        DataField = 'D_CALENDARIO'
        DataSource = DButton
      end
      object dedtAlternanzaFest: TDBEdit
        Left = 193
        Top = 78
        Width = 66
        Height = 21
        DataField = 'ALTERNANZA_GGFES'
        DataSource = DButton
        TabOrder = 2
      end
      object dedtAlternanzaGGLav: TDBEdit
        Left = 193
        Top = 131
        Width = 66
        Height = 21
        DataField = 'ALTERNANZA_GGLAV'
        DataSource = DButton
        TabOrder = 4
      end
      object dedtGGChiusura: TDBEdit
        Left = 193
        Top = 158
        Width = 66
        Height = 21
        DataField = 'GGCHIUSURA'
        DataSource = DButton
        TabOrder = 5
      end
      object dedtPrimoGGFest: TDBEdit
        Left = 193
        Top = 53
        Width = 66
        Height = 21
        DataField = 'DATA_PRIMOGGFES'
        DataSource = DButton
        TabOrder = 1
      end
      object dedtPrimoGGLav: TDBEdit
        Left = 193
        Top = 106
        Width = 66
        Height = 21
        DataField = 'DATA_PRIMOGGLAV'
        DataSource = DButton
        TabOrder = 3
      end
      object dedtCalendario: TDBLookupComboBox
        Left = 193
        Top = 26
        Width = 68
        Height = 21
        DataField = 'CALENDARIO'
        DataSource = DButton
        KeyField = 'CODICE'
        ListField = 'CODICE;DESCRIZIONE'
        ListSource = A140FTurniServiziDTM.dsrT010
        TabOrder = 0
      end
    end
    object tabServizi: TTabSheet
      Caption = 'Servizi'
      ExplicitWidth = 477
      object dgrdT540: TDBGrid
        Left = 0
        Top = 0
        Width = 559
        Height = 279
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
        OnDrawColumnCell = dgrdT540DrawColumnCell
        OnEditButtonClick = dgrdT540EditButtonClick
        Columns = <
          item
            Expanded = False
            FieldName = 'CODICE'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESCRIZIONE'
            Visible = True
          end
          item
            ButtonStyle = cbsEllipsis
            Expanded = False
            FieldName = 'COLORE'
            Visible = True
          end
          item
            ButtonStyle = cbsEllipsis
            Expanded = False
            FieldName = 'COLOREFONT'
            Visible = True
          end
          item
            ButtonStyle = cbsEllipsis
            Expanded = False
            FieldName = 'PADRE'
            Visible = True
          end>
      end
    end
    object tabTipiTurno: TTabSheet
      Caption = 'Tipi turno'
      ImageIndex = 1
      ExplicitWidth = 477
      object dgrdT545: TDBGrid
        Left = 0
        Top = 0
        Width = 559
        Height = 279
        Align = alClient
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
      end
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 216
  end
  inherited DButton: TDataSource
    Left = 244
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 272
  end
  inherited ImageList1: TImageList
    Left = 300
  end
  inherited ActionList1: TActionList
    Left = 328
  end
  object ColorDialog: TColorDialog
    Left = 356
    Top = 26
  end
end
