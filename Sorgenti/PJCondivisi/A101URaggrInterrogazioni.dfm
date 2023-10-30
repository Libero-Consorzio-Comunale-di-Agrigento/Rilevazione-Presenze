inherited A101FRaggrInterrogazioni: TA101FRaggrInterrogazioni
  HelpContext = 101000
  Caption = '<A101> Raggruppamenti interrogazioni di servizio'
  ClientHeight = 435
  ClientWidth = 570
  ExplicitWidth = 586
  ExplicitHeight = 494
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 199
    Width = 570
    Height = 2
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 198
    ExplicitWidth = 710
  end
  inherited StatusBar: TStatusBar
    Top = 417
    Width = 570
    ExplicitTop = 417
    ExplicitWidth = 570
  end
  inherited Panel1: TToolBar
    Width = 570
    ExplicitWidth = 570
  end
  object pnlAssociazioni: TPanel [3]
    Left = 0
    Top = 201
    Width = 570
    Height = 216
    Align = alBottom
    TabOrder = 2
    object dGrdAssociazioni: TDBGrid
      Left = 1
      Top = 24
      Width = 568
      Height = 191
      Align = alClient
      DataSource = A101FRaggrInterrogazioniDtm.dsrT006
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
      OnDrawColumnCell = dGrdAssociazioniDrawColumnCell
      Columns = <
        item
          Expanded = False
          FieldName = 'COD_QUERY'
          Visible = True
        end>
    end
    inline frmToolbarFiglio: TfrmToolbarFiglio
      Left = 1
      Top = 1
      Width = 568
      Height = 23
      Align = alTop
      TabOrder = 1
      TabStop = True
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 568
      inherited tlbarFiglio: TToolBar
        Width = 568
        ExplicitWidth = 568
      end
    end
  end
  object dGrdRaggrinterrogazioni: TDBGrid [4]
    Left = 0
    Top = 24
    Width = 570
    Height = 175
    Align = alClient
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  inherited MainMenu1: TMainMenu
    Left = 392
  end
  inherited DButton: TDataSource
    DataSet = A101FRaggrInterrogazioniDtm.selT005
    Left = 420
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 448
  end
  inherited ImageList1: TImageList
    Left = 476
  end
  inherited ActionList1: TActionList
    Left = 504
  end
end
