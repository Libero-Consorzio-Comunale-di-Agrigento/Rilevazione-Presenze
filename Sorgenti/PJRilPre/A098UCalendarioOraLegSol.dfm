inherited A098FCalendarioOraLegSol: TA098FCalendarioOraLegSol
  HelpContext = 98000
  Caption = '<A098> Calendario ora legale solare'
  ClientHeight = 357
  ClientWidth = 432
  ExplicitWidth = 448
  ExplicitHeight = 416
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 339
    Width = 432
    ExplicitTop = 339
    ExplicitWidth = 432
  end
  inherited Panel1: TToolBar
    Width = 432
    ExplicitWidth = 432
  end
  object dGrdT110: TDBGrid [2]
    Left = 0
    Top = 29
    Width = 432
    Height = 310
    Align = alClient
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
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
    Columns = <
      item
        Expanded = False
        FieldName = 'DATA'
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TOraDesc'
        Visible = True
      end
      item
        Color = cl3DLight
        Expanded = False
        FieldName = 'ORAVECCHIA'
        Width = 64
        Visible = True
      end
      item
        Color = cl3DLight
        Expanded = False
        FieldName = 'ORANUOVA'
        Width = 64
        Visible = True
      end>
  end
  inherited DButton: TDataSource
    DataSet = A098FCalendarioOraLegSolDtm.selT110
  end
end
