inherited A157FCapitoliTrasferte: TA157FCapitoliTrasferte
  Tag = 135
  HelpContext = 157000
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '<A157> Capitoli trasferte'
  ClientWidth = 854
  ExplicitWidth = 870
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Width = 854
    ExplicitWidth = 854
  end
  inherited grbDecorrenza: TGroupBox
    Width = 854
    ExplicitWidth = 854
  end
  inherited ToolBar1: TToolBar
    Width = 854
    ExplicitWidth = 854
  end
  object dGrdCapitoliTrasferta: TDBGrid [3]
    Left = 0
    Top = 63
    Width = 854
    Height = 266
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
    OnEditButtonClick = dGrdCapitoliTrasfertaEditButtonClick
    Columns = <
      item
        Expanded = False
        FieldName = 'CODICE'
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRIZIONE'
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DECORRENZA'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DECORRENZA_FINE'
        Visible = True
      end
      item
        ButtonStyle = cbsEllipsis
        Expanded = False
        FieldName = 'TIPO_MISSIONE'
        PopupMenu = popmnuAccedi
        Visible = True
      end
      item
        ButtonStyle = cbsEllipsis
        Expanded = False
        FieldName = 'FILTRO_ANAGRAFE'
        Width = 64
        Visible = True
      end>
  end
  inherited DButton: TDataSource
    DataSet = A157FCapitoliTrasferteDM.selM030
  end
  object popmnuAccedi: TPopupMenu
    Left = 208
    Top = 65
    object Accedi1: TMenuItem
      Caption = 'Accedi'
      OnClick = Accedi1Click
    end
  end
end
