inherited A139FGestisciPattuglie: TA139FGestisciPattuglie
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = '<A139> Composizione Pattuglia'
  ClientHeight = 220
  ClientWidth = 588
  ExplicitWidth = 596
  ExplicitHeight = 266
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 202
    Width = 588
    ExplicitTop = 202
    ExplicitWidth = 588
  end
  inherited Panel1: TToolBar
    Width = 588
    ExplicitWidth = 588
  end
  object DBGridPattuglia: TDBGrid [2]
    Left = 0
    Top = 29
    Width = 588
    Height = 173
    Align = alClient
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    PopupMenu = PopupMenu1
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = DBGridPattugliaDblClick
    OnEditButtonClick = DBGridPattugliaEditButtonClick
    OnKeyUp = DBGridPattugliaKeyUp
    Columns = <
      item
        Expanded = False
        FieldName = 'DATA'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'CAMPO1'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'CAMPO2'
        Visible = False
      end
      item
        DropDownRows = 20
        Expanded = False
        FieldName = 'DescCampo1'
        Visible = True
      end
      item
        DropDownRows = 20
        Expanded = False
        FieldName = 'DescCampo2'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PATTUGLIA'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'PROGRESSIVO'
        Visible = False
      end
      item
        ButtonStyle = cbsEllipsis
        Expanded = False
        FieldName = 'Matricola'
        Visible = True
      end
      item
        DropDownRows = 20
        Expanded = False
        FieldName = 'Nominativo'
        Visible = True
      end>
  end
  inherited DButton: TDataSource
    AutoEdit = True
    DataSet = A139FPianifServiziDtm.selT502_2
  end
  inherited ActionList1: TActionList
    inherited actCopiaSu: TAction
      Caption = 'Copia riga'
      Hint = 'Copia riga'
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 16
    Top = 56
    object Copiariga1: TMenuItem
      Action = actCopiaSu
    end
  end
end
