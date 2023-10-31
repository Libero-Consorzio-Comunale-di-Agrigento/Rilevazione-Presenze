inherited A168FIncentiviMaturati: TA168FIncentiviMaturati
  HelpContext = 168000
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = '<A168> Riepilogo incentivi'
  ClientHeight = 546
  ClientWidth = 792
  ExplicitWidth = 808
  ExplicitHeight = 604
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 528
    Width = 792
    ExplicitTop = 528
    ExplicitWidth = 792
  end
  inherited Panel1: TToolBar
    Top = 24
    Width = 792
    ExplicitTop = 24
    ExplicitWidth = 792
  end
  object dgrdMaturazioni: TDBGrid [2]
    Left = 0
    Top = 128
    Width = 792
    Height = 295
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
    OnDrawColumnCell = dgrdMaturazioniDrawColumnCell
    Columns = <
      item
        Expanded = False
        FieldName = 'ANNO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MESE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Desc_Mese'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODTIPOQUOTA'
        Title.Caption = 'Quota'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Desc_Quota'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Tipologia_Quota'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TIPOIMPORTO'
        PickList.Strings = (
          '1'
          '2'
          '3'
          '4'
          '5')
        Title.Caption = 'Tipo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Desc_Importo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'IMPORTO'
        Title.Caption = 'Importo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VARIAZIONI'
        Title.Caption = 'Var.Importo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DescGiorniOre'
        Visible = True
      end>
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe [3]
    Left = 0
    Top = 0
    Width = 792
    Height = 24
    Align = alTop
    TabOrder = 3
    TabStop = True
    ExplicitWidth = 792
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 792
      Height = 24
      ExplicitWidth = 792
      ExplicitHeight = 24
    end
  end
  object gpbAbbattimenti: TGroupBox [4]
    Left = 0
    Top = 423
    Width = 792
    Height = 105
    Align = alBottom
    Caption = 'Abbattimenti'
    TabOrder = 4
    object dgrdAbbattimenti: TDBGrid
      Left = 2
      Top = 15
      Width = 788
      Height = 88
      Align = alClient
      DataSource = A168FIncentiviMaturatiDtM.dsrT763
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
  object Panel2: TPanel [5]
    Left = 0
    Top = 53
    Width = 792
    Height = 75
    Align = alTop
    TabOrder = 5
    object rgpVisualizzazione: TGroupBox
      Left = 1
      Top = 1
      Width = 790
      Height = 73
      Align = alClient
      Caption = 'Visualizzazione'
      TabOrder = 0
      object Quote: TLabel
        Left = 332
        Top = 44
        Width = 59
        Height = 13
        Caption = 'Codici quote'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object chkVisIntere: TCheckBox
        Left = 8
        Top = 17
        Width = 102
        Height = 17
        Caption = 'Quote intere [1]'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = chkVisIntereClick
      end
      object chkVisProporzionate: TCheckBox
        Left = 135
        Top = 17
        Width = 133
        Height = 17
        Caption = 'Quote proporzionate [2]'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = chkVisIntereClick
      end
      object chkVisNette: TCheckBox
        Left = 313
        Top = 17
        Width = 92
        Height = 17
        Caption = 'Quote nette [3]'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 2
        OnClick = chkVisIntereClick
      end
      object chkVisNetteRisp: TCheckBox
        Left = 449
        Top = 17
        Width = 148
        Height = 17
        Caption = 'Quote nette + risparmio [4]'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = chkVisIntereClick
      end
      object chkVisAssenze: TCheckBox
        Left = 8
        Top = 40
        Width = 155
        Height = 17
        Caption = 'Quote abbattimento assenze'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnClick = chkVisIntereClick
      end
      object chkVisQuantitative: TCheckBox
        Left = 641
        Top = 17
        Width = 121
        Height = 17
        Caption = 'Quote quantitative [5]'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnClick = chkVisIntereClick
      end
      object edtQuote: TEdit
        Left = 397
        Top = 41
        Width = 349
        Height = 21
        TabOrder = 6
        OnChange = edtQuoteChange
      end
      object btnQuote: TBitBtn
        Left = 745
        Top = 39
        Width = 17
        Height = 25
        Caption = '...'
        TabOrder = 7
        OnClick = btnQuoteClick
      end
    end
  end
  inherited MainMenu1: TMainMenu [6]
    Left = 392
    Top = 65530
  end
  inherited DButton: TDataSource [7]
    Left = 420
    Top = 65530
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog [8]
    Left = 448
    Top = 65530
  end
  inherited ImageList1: TImageList [9]
    Left = 476
    Top = 65530
  end
  inherited ActionList1: TActionList
    Left = 504
    Top = 65530
  end
end
