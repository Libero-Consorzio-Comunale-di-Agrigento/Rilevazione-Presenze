inherited S130FOrdiniProfessionali: TS130FOrdiniProfessionali
  Left = 112
  Top = 176
  HelpContext = 2130000
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = '<S130> Gestione Ordini professionali'
  ClientHeight = 393
  ClientWidth = 1086
  ExplicitWidth = 1102
  ExplicitHeight = 452
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 375
    Width = 1086
    ExplicitTop = 375
    ExplicitWidth = 1086
  end
  inherited Panel1: TToolBar
    Width = 1086
    ExplicitWidth = 1086
  end
  object grdOrdiniProf: TDBGrid [2]
    Left = 0
    Top = 29
    Width = 1086
    Height = 346
    Align = alClient
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnEditButtonClick = grdOrdiniProfEditButtonClick
    Columns = <
      item
        Expanded = False
        FieldName = 'COD_ORDINE'
        Title.Caption = 'Codice'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRIZIONE'
        Title.Caption = 'Descrizione'
        Visible = True
      end
      item
        ButtonStyle = cbsEllipsis
        Expanded = False
        FieldName = 'QUALIFICHE_COLLEGATE'
        Title.Caption = 'Qualifiche collegate'
        Visible = True
      end>
  end
  inherited MainMenu1: TMainMenu
    Left = 478
    Top = 25
  end
  inherited DButton: TDataSource
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
