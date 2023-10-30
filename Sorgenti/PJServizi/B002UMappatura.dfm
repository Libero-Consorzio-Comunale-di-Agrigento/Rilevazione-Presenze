object B002FMappatura: TB002FMappatura
  Left = 82
  Top = 138
  Caption = 'Mappatura file sequenziale'
  ClientHeight = 266
  ClientWidth = 427
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object MemoFile: TMemo
    Left = 0
    Top = 0
    Width = 427
    Height = 55
    Hint = 'Doppio click per vedere riga successiva'
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clFuchsia
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    HideSelection = False
    Lines.Strings = (
      '')
    ParentFont = False
    ParentShowHint = False
    ReadOnly = True
    ScrollBars = ssHorizontal
    ShowHint = True
    TabOrder = 0
    WordWrap = False
    OnDblClick = MemoFileDblClick
    OnEndDrag = MemoFileEndDrag
    OnMouseUp = MemoFileMouseUp
  end
  object StringGrid1: TStringGrid
    Left = 0
    Top = 55
    Width = 427
    Height = 211
    Align = alClient
    ColCount = 3
    DefaultColWidth = 100
    DefaultRowHeight = 15
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing, goTabs]
    PopupMenu = PopupMenu1
    TabOrder = 1
    OnDragDrop = StringGrid1DragDrop
    OnDragOver = StringGrid1DragOver
  end
  object PopupMenu1: TPopupMenu
    Left = 2
    Top = 108
    object Aggiungicampo1: TMenuItem
      Caption = 'Aggiungi riga'
      OnClick = Aggiungicampo1Click
    end
    object Eliminacampo1: TMenuItem
      Caption = 'Elimina riga'
      OnClick = Eliminacampo1Click
    end
  end
end
