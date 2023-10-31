inherited A138FAreeTurni: TA138FAreeTurni
  Left = 112
  Top = 176
  HelpContext = 2130000
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = '<A138> Aree turni'
  ClientHeight = 393
  ClientWidth = 700
  ExplicitWidth = 716
  ExplicitHeight = 452
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 375
    Width = 700
    ExplicitTop = 375
    ExplicitWidth = 700
  end
  inherited Panel1: TToolBar
    Width = 700
    ExplicitWidth = 700
  end
  object grdAreeTurni: TDBGrid [2]
    Left = 0
    Top = 29
    Width = 700
    Height = 346
    Align = alClient
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDrawColumnCell = grdAreeTurniDrawColumnCell
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
        Expanded = False
        FieldName = 'SIGLA'
        Visible = True
      end
      item
        DropDownRows = 16
        Expanded = False
        FieldName = 'COLORE'
        Visible = True
      end>
  end
  inherited MainMenu1: TMainMenu
    Left = 478
    Top = 25
  end
  inherited DButton: TDataSource
    AutoEdit = True
    Left = 534
    Top = 25
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 506
    Top = 25
  end
  inherited ImageList1: TImageList
    Left = 412
  end
  inherited ActionList1: TActionList
    Left = 440
  end
end
