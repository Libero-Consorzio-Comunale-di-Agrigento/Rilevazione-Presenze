object A023FRichiesteInCorso: TA023FRichiesteInCorso
  Left = 0
  Top = 0
  Caption = '<A023> Richieste in corso'
  ClientHeight = 511
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object splTimbrature: TSplitter
    Left = 0
    Top = 185
    Width = 784
    Height = 8
    Cursor = crVSplit
    Align = alTop
    ExplicitLeft = 8
    ExplicitTop = 241
    ExplicitWidth = 718
  end
  object splGiustificativi: TSplitter
    Left = 0
    Top = 343
    Width = 784
    Height = 8
    Cursor = crVSplit
    Align = alTop
    ExplicitLeft = -8
    ExplicitTop = 335
  end
  object splCambioOrario: TSplitter
    Left = 0
    Top = 501
    Width = 784
    Height = 8
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 359
  end
  object pnlTimbrature: TPanel
    Left = 0
    Top = 35
    Width = 784
    Height = 150
    Align = alTop
    Caption = 'pnlTimbrature'
    TabOrder = 0
    object dgrdRichiesteTimb: TDBGrid
      AlignWithMargins = True
      Left = 4
      Top = 28
      Width = 776
      Height = 118
      Align = alClient
      DataSource = dsrVT105
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      PopupMenu = pmnInfo
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlue
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
    object pnlTimbratureHead: TPanel
      Left = 1
      Top = 1
      Width = 782
      Height = 24
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object lblTimbrature: TLabel
        Left = 7
        Top = 5
        Width = 52
        Height = 13
        Caption = 'Timbrature'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
    end
  end
  object pnlData: TPanel
    Left = 0
    Top = 0
    Width = 784
    Height = 35
    Align = alTop
    TabOrder = 1
    object lblData: TLabel
      Left = 8
      Top = 11
      Width = 33
      Height = 13
      Caption = 'lblData'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
  end
  object pnlGiustificativi: TPanel
    Left = 0
    Top = 193
    Width = 784
    Height = 150
    Align = alTop
    Caption = 'pnlGiustificativi'
    TabOrder = 2
    object pnlGiustificativiHead: TPanel
      Left = 1
      Top = 1
      Width = 782
      Height = 24
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object lblGiustificativi: TLabel
        Left = 7
        Top = 5
        Width = 57
        Height = 13
        Caption = 'Giustificativi'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
    end
    object dgrdRichiesteGiust: TDBGrid
      AlignWithMargins = True
      Left = 4
      Top = 28
      Width = 776
      Height = 118
      Align = alClient
      DataSource = dsrVT050
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      PopupMenu = pmnInfo
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlue
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object pnlCambioOrario: TPanel
    Left = 0
    Top = 351
    Width = 784
    Height = 150
    Align = alTop
    Caption = 'pnlGiustificativi'
    TabOrder = 3
    ExplicitTop = 201
    object pnlCambioOrarioHead: TPanel
      Left = 1
      Top = 1
      Width = 782
      Height = 24
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object lblCambioOrario: TLabel
        Left = 7
        Top = 5
        Width = 66
        Height = 13
        Caption = 'Cambio orario'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
    end
    object dgrdRichiesteCambioOrario: TDBGrid
      AlignWithMargins = True
      Left = 4
      Top = 28
      Width = 776
      Height = 118
      Align = alClient
      DataSource = dsrVT085
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      PopupMenu = pmnInfo
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlue
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object dsrVT050: TDataSource
    Left = 520
    Top = 264
  end
  object dsrVT105: TDataSource
    Left = 528
    Top = 96
  end
  object pmnInfo: TPopupMenu
    Left = 240
    object mnuInfoRichiesta: TMenuItem
      Caption = 'Info richiesta'
      OnClick = mnuInfoRichiestaClick
    end
  end
  object dsrVT085: TDataSource
    Left = 520
    Top = 408
  end
end
