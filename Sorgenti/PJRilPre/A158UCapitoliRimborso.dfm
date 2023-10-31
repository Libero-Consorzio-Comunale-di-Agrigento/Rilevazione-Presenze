inherited A158FCapitoliRimborso: TA158FCapitoliRimborso
  Tag = 147
  HelpContext = 158000
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '<A158> Capitoli rimborso'
  ClientHeight = 414
  ClientWidth = 1158
  ExplicitWidth = 1166
  ExplicitHeight = 460
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 396
    Width = 1158
    ExplicitTop = 396
    ExplicitWidth = 1158
  end
  inherited grbDecorrenza: TGroupBox
    Width = 1158
    ExplicitWidth = 1158
  end
  inherited ToolBar1: TToolBar
    Width = 1158
    ExplicitWidth = 1158
  end
  object dGrdCapitoloRimborso: TDBGrid [3]
    Left = 0
    Top = 63
    Width = 1158
    Height = 333
    Align = alClient
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    PopupMenu = popmnuAccedi
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  inherited DButton: TDataSource
    AutoEdit = True
    DataSet = A158FCapitoliRimborsoDM.selM031
  end
  object popmnuAccedi: TPopupMenu
    OnPopup = popmnuAccediPopup
    Left = 216
    Top = 64
    object Accedi1: TMenuItem
      Caption = 'Accedi'
      OnClick = Accedi1Click
    end
  end
end
