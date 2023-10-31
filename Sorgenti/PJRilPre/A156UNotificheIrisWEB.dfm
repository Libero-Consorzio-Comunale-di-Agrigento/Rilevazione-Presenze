inherited A156FNotificheIrisWEB: TA156FNotificheIrisWEB
  Tag = 78
  HelpContext = 156000
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = '<A156> Notifiche IrisWEB'
  ClientHeight = 442
  ClientWidth = 784
  ExplicitWidth = 800
  ExplicitHeight = 501
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 174
    Width = 784
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 179
  end
  inherited StatusBar: TStatusBar
    Top = 424
    Width = 784
    ExplicitTop = 424
    ExplicitWidth = 784
  end
  inherited Panel1: TToolBar
    Width = 784
    TabOrder = 0
    ExplicitWidth = 784
  end
  object dgrdNotifiche: TDBGrid [3]
    Left = 0
    Top = 24
    Width = 784
    Height = 150
    Align = alTop
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'DESCRIZIONE'
        Title.Caption = 'Descrizione'
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'D_NOTIFICA'
        Title.Caption = 'Notifica'
        Width = 180
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ATTIVO'
        PickList.Strings = (
          'S'
          'N')
        Title.Caption = 'Attivo'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALIDO_DAL'
        Title.Caption = 'Inizio validit'#224
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALIDO_AL'
        Title.Caption = 'Fine validit'#224
        Width = 90
        Visible = True
      end>
  end
  object pnlBottom: TPanel [4]
    Left = 0
    Top = 177
    Width = 784
    Height = 247
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlBottom'
    TabOrder = 2
    object dmemNotificaSqlText: TDBMemo
      Left = 0
      Top = 0
      Width = 784
      Height = 247
      Align = alClient
      DataField = 'NOTIFICA_SQL_TEXT'
      DataSource = DButton
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
      WordWrap = False
    end
  end
end
