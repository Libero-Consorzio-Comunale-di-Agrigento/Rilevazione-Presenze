inherited A139FPianifServizi: TA139FPianifServizi
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = '<A139> Pianificazione Servizi'
  ClientHeight = 600
  ClientWidth = 761
  KeyPreview = True
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  ExplicitWidth = 769
  ExplicitHeight = 646
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter3: TSplitter [0]
    Left = 0
    Top = 462
    Width = 761
    Height = 2
    Cursor = crVSplit
    Align = alBottom
    ExplicitLeft = 1
    ExplicitTop = 189
    ExplicitWidth = 542
  end
  inherited StatusBar: TStatusBar
    Top = 580
    Width = 761
    Height = 20
    ExplicitTop = 580
    ExplicitWidth = 761
    ExplicitHeight = 20
  end
  inherited Panel1: TToolBar
    Top = 25
    Width = 761
    Height = 26
    ButtonHeight = 24
    ExplicitTop = 25
    ExplicitWidth = 761
    ExplicitHeight = 26
    inherited ToolButton1: TToolButton
      Width = 24
      ExplicitWidth = 24
      ExplicitHeight = 24
    end
    inherited TCerca: TToolButton
      Left = 24
      ExplicitLeft = 24
      ExplicitHeight = 24
    end
    inherited ToolButton13: TToolButton
      Left = 47
      ExplicitLeft = 47
      ExplicitHeight = 24
    end
    inherited TPrimo: TToolButton
      Left = 54
      ExplicitLeft = 54
      ExplicitHeight = 24
    end
    inherited TPrec: TToolButton
      Left = 77
      ExplicitLeft = 77
      ExplicitHeight = 24
    end
    inherited TSucc: TToolButton
      Left = 100
      ExplicitLeft = 100
      ExplicitHeight = 24
    end
    inherited TUltimo: TToolButton
      Left = 123
      ExplicitLeft = 123
      ExplicitHeight = 24
    end
    inherited ToolButton6: TToolButton
      Left = 146
      ExplicitLeft = 146
      ExplicitHeight = 24
    end
    inherited btnRefresh: TToolButton
      Left = 153
      ExplicitLeft = 153
      ExplicitHeight = 24
    end
    inherited ToolButton3: TToolButton
      Left = 176
      ExplicitLeft = 176
      ExplicitHeight = 24
    end
    inherited TInser: TToolButton
      Left = 183
      ExplicitLeft = 183
      ExplicitHeight = 24
    end
    inherited TModif: TToolButton
      Left = 206
      ExplicitLeft = 206
      ExplicitHeight = 24
    end
    inherited TCanc: TToolButton
      Left = 229
      ExplicitLeft = 229
      ExplicitHeight = 24
    end
    inherited ToolButton10: TToolButton
      Left = 252
      ExplicitLeft = 252
      ExplicitHeight = 24
    end
    inherited TAnnulla: TToolButton
      Left = 259
      ExplicitLeft = 259
      ExplicitHeight = 24
    end
    inherited TRegis: TToolButton
      Left = 282
      ExplicitLeft = 282
      ExplicitHeight = 24
    end
    inherited ToolButton14: TToolButton
      Left = 305
      ExplicitLeft = 305
      ExplicitHeight = 24
    end
    inherited TGomma: TToolButton
      Left = 312
      ExplicitLeft = 312
      ExplicitHeight = 24
    end
    inherited ToolButton16: TToolButton
      Left = 335
      ExplicitLeft = 335
      ExplicitHeight = 24
    end
    inherited TStampa: TToolButton
      Left = 342
      ExplicitLeft = 342
      ExplicitHeight = 24
    end
  end
  object PnlCenter: TPanel [3]
    Left = 0
    Top = 127
    Width = 761
    Height = 335
    Align = alClient
    TabOrder = 3
    object Splitter1: TSplitter
      Left = 1
      Top = 238
      Width = 759
      Height = 2
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 189
      ExplicitWidth = 542
    end
    object PnlDescrizioni: TPanel
      Left = 1
      Top = 240
      Width = 759
      Height = 94
      Align = alBottom
      TabOrder = 0
      OnResize = PnlDescrizioniResize
      object Splitter2: TSplitter
        Left = 186
        Top = 1
        Width = 2
        Height = 92
      end
      object grpNoteServizi: TGroupBox
        Left = 1
        Top = 1
        Width = 185
        Height = 92
        Align = alLeft
        Caption = 'Note Servizio'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object DBMemoNoteServizio: TDBMemo
          Left = 2
          Top = 15
          Width = 181
          Height = 75
          Align = alClient
          DataField = 'NOTE_SERVIZIO'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
      object grpNote: TGroupBox
        Left = 188
        Top = 1
        Width = 570
        Height = 92
        Align = alClient
        Caption = 'Messaggi'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object DBMemoNote: TDBMemo
          Left = 2
          Top = 15
          Width = 566
          Height = 75
          Align = alClient
          DataField = 'NOTE'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
    end
    object GridServizi: TDBAdvGrid
      Left = 1
      Top = 1
      Width = 759
      Height = 237
      Cursor = crDefault
      Align = alClient
      ColCount = 18
      RowCount = 2
      FixedRows = 1
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goRowSizing, goColSizing, goEditing, goTabs]
      ParentFont = False
      PopupMenu = PopupMenu1
      ScrollBars = ssBoth
      TabOrder = 1
      OnClick = GridServiziClick
      OnGetCellColor = GridServiziGetCellColor
      OnRowChanging = GridServiziRowChanging
      OnCanAddRow = GridServiziCanAddRow
      OnCanInsertRow = GridServiziCanInsertRow
      OnDblClickCell = GridServiziDblClickCell
      OnOleDrop = GridServiziOleDrop
      DragDropSettings.OleDropTarget = True
      DragDropSettings.OleDropSource = True
      ActiveCellFont.Charset = DEFAULT_CHARSET
      ActiveCellFont.Color = clWindowText
      ActiveCellFont.Height = -11
      ActiveCellFont.Name = 'Tahoma'
      ActiveCellFont.Style = [fsBold]
      ActiveCellColor = clBtnFace
      ActiveCellColorTo = clBtnFace
      ControlLook.FixedGradientFrom = clWhite
      ControlLook.FixedGradientTo = clBtnFace
      ControlLook.FixedGradientHoverFrom = 16775139
      ControlLook.FixedGradientHoverTo = 16775139
      ControlLook.FixedGradientHoverMirrorFrom = 16772541
      ControlLook.FixedGradientHoverMirrorTo = 16508855
      ControlLook.FixedGradientDownFrom = 16377020
      ControlLook.FixedGradientDownTo = 16377020
      ControlLook.FixedGradientDownMirrorFrom = 16242317
      ControlLook.FixedGradientDownMirrorTo = 16109962
      ControlLook.FixedGradientDownBorder = 11440207
      ControlLook.ControlStyle = csClassic
      Filter = <>
      FixedColWidth = 12
      FixedRowHeight = 22
      FixedFont.Charset = DEFAULT_CHARSET
      FixedFont.Color = clBlue
      FixedFont.Height = -11
      FixedFont.Name = 'Tahoma'
      FixedFont.Style = [fsBold]
      FloatFormat = '%.2f'
      IntelliZoom = False
      Look = glClassic
      Multilinecells = True
      Navigation.AllowInsertRow = True
      Navigation.AutoComboDropSize = True
      Navigation.AppendOnArrowDown = True
      Navigation.LineFeedOnEnter = True
      Navigation.SkipFixedCells = False
      PrintSettings.DateFormat = 'dd/mm/yyyy'
      PrintSettings.Font.Charset = DEFAULT_CHARSET
      PrintSettings.Font.Color = clWindowText
      PrintSettings.Font.Height = -11
      PrintSettings.Font.Name = 'Tahoma'
      PrintSettings.Font.Style = []
      PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
      PrintSettings.FixedFont.Color = clWindowText
      PrintSettings.FixedFont.Height = -11
      PrintSettings.FixedFont.Name = 'Tahoma'
      PrintSettings.FixedFont.Style = []
      PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
      PrintSettings.HeaderFont.Color = clWindowText
      PrintSettings.HeaderFont.Height = -11
      PrintSettings.HeaderFont.Name = 'Tahoma'
      PrintSettings.HeaderFont.Style = []
      PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
      PrintSettings.FooterFont.Color = clWindowText
      PrintSettings.FooterFont.Height = -11
      PrintSettings.FooterFont.Name = 'Tahoma'
      PrintSettings.FooterFont.Style = []
      PrintSettings.PageNumSep = '/'
      ScrollWidth = 16
      SearchFooter.Color = clBtnFace
      SearchFooter.FindNextCaption = 'Find &next'
      SearchFooter.FindPrevCaption = 'Find &previous'
      SearchFooter.Font.Charset = DEFAULT_CHARSET
      SearchFooter.Font.Color = clWindowText
      SearchFooter.Font.Height = -11
      SearchFooter.Font.Name = 'Tahoma'
      SearchFooter.Font.Style = []
      SearchFooter.HighLightCaption = 'Highlight'
      SearchFooter.HintClose = 'Close'
      SearchFooter.HintFindNext = 'Find next occurence'
      SearchFooter.HintFindPrev = 'Find previous occurence'
      SearchFooter.HintHighlight = 'Highlight occurences'
      SearchFooter.MatchCaseCaption = 'Match case'
      SelectionTextColor = clWhite
      SortSettings.HeaderColor = 16579058
      SortSettings.HeaderColorTo = 16579058
      SortSettings.HeaderMirrorColor = 16380385
      SortSettings.HeaderMirrorColorTo = 16182488
      WordWrap = False
      AutoCreateColumns = False
      AutoRemoveColumns = False
      Columns = <
        item
          Borders = []
          BorderPen.Color = cl3DLight
          CheckFalse = 'N'
          CheckTrue = 'Y'
          Color = clWindow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          HeaderFont.Charset = DEFAULT_CHARSET
          HeaderFont.Color = clWindowText
          HeaderFont.Height = -11
          HeaderFont.Name = 'Tahoma'
          HeaderFont.Style = []
          PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
          PrintFont.Charset = DEFAULT_CHARSET
          PrintFont.Color = clWindowText
          PrintFont.Height = -11
          PrintFont.Name = 'Tahoma'
          PrintFont.Style = []
          Width = 12
        end
        item
          Borders = []
          BorderPen.Color = cl3DLight
          CheckFalse = 'N'
          CheckTrue = 'Y'
          Color = clWindow
          Editor = edNumeric
          FieldName = 'ORDINE'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HeaderFont.Charset = ANSI_CHARSET
          HeaderFont.Color = clWindowText
          HeaderFont.Height = -11
          HeaderFont.Name = 'Arial'
          HeaderFont.Style = []
          PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
          PrintFont.Charset = ANSI_CHARSET
          PrintFont.Color = clWindowText
          PrintFont.Height = -11
          PrintFont.Name = 'Arial'
          PrintFont.Style = []
          Width = 28
        end
        item
          Borders = []
          BorderPen.Color = cl3DLight
          CheckFalse = 'N'
          CheckTrue = 'Y'
          Color = clWindow
          EditMask = '!00/00/0000;1;_'
          FieldName = 'Data'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HeaderFont.Charset = DEFAULT_CHARSET
          HeaderFont.Color = clWindowText
          HeaderFont.Height = -11
          HeaderFont.Name = 'Tahoma'
          HeaderFont.Style = []
          Name = 'DATA'
          PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
          PrintFont.Charset = DEFAULT_CHARSET
          PrintFont.Color = clWindowText
          PrintFont.Height = -11
          PrintFont.Name = 'Tahoma'
          PrintFont.Style = []
          Width = 73
        end
        item
          Borders = []
          BorderPen.Color = cl3DLight
          CheckFalse = 'N'
          CheckTrue = 'Y'
          Color = clWindow
          Editor = edNone
          FieldName = 'C_CAMPO1'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HeaderFont.Charset = DEFAULT_CHARSET
          HeaderFont.Color = clWindowText
          HeaderFont.Height = -11
          HeaderFont.Name = 'Tahoma'
          HeaderFont.Style = []
          Name = 'C_CAMPO1'
          PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
          PrintFont.Charset = DEFAULT_CHARSET
          PrintFont.Color = clWindowText
          PrintFont.Height = -11
          PrintFont.Name = 'Tahoma'
          PrintFont.Style = []
          Width = 75
        end
        item
          Borders = []
          BorderPen.Color = cl3DLight
          CheckFalse = 'N'
          CheckTrue = 'Y'
          Color = clWindow
          Editor = edNone
          FieldName = 'C_CAMPO2'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HeaderFont.Charset = DEFAULT_CHARSET
          HeaderFont.Color = clWindowText
          HeaderFont.Height = -11
          HeaderFont.Name = 'Tahoma'
          HeaderFont.Style = []
          Name = 'C_CAMPO2'
          PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
          PrintFont.Charset = DEFAULT_CHARSET
          PrintFont.Color = clWindowText
          PrintFont.Height = -11
          PrintFont.Name = 'Tahoma'
          PrintFont.Style = []
          Width = 85
        end
        item
          Borders = []
          BorderPen.Color = cl3DLight
          CheckFalse = 'N'
          CheckTrue = 'Y'
          Color = clWindow
          Editor = edNone
          FieldName = 'NOMINATIVO'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HeaderFont.Charset = DEFAULT_CHARSET
          HeaderFont.Color = clWindowText
          HeaderFont.Height = -11
          HeaderFont.Name = 'Tahoma'
          HeaderFont.Style = []
          Name = 'NOMINATIVO'
          PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
          PrintFont.Charset = DEFAULT_CHARSET
          PrintFont.Color = clWindowText
          PrintFont.Height = -11
          PrintFont.Name = 'Tahoma'
          PrintFont.Style = []
          Width = 64
        end
        item
          Borders = []
          BorderPen.Color = cl3DLight
          CheckFalse = 'N'
          CheckTrue = 'Y'
          Color = clWindow
          FieldName = 'NOTE'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HeaderFont.Charset = DEFAULT_CHARSET
          HeaderFont.Color = clWindowText
          HeaderFont.Height = -11
          HeaderFont.Name = 'Tahoma'
          HeaderFont.Style = []
          Name = 'NOTE'
          PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
          PrintFont.Charset = DEFAULT_CHARSET
          PrintFont.Color = clWindowText
          PrintFont.Height = -11
          PrintFont.Name = 'Tahoma'
          PrintFont.Style = []
          Width = 75
        end
        item
          Borders = []
          BorderPen.Color = cl3DLight
          CheckFalse = 'N'
          CheckTrue = 'Y'
          Color = clWindow
          ComboItems.Strings = (
            '00.00'
            '00.30'
            '01.00'
            '01.30'
            '02.00'
            '02.30'
            '03.00'
            '03.30'
            '04.00'
            '04.30'
            '05.00'
            '05.30'
            '06.00'
            '06.30'
            '07.00'
            '07.30'
            '08.00'
            '08.30'
            '09.00'
            '09.30'
            '10.00'
            '10.30'
            '11.00'
            '11.30'
            '12.00'
            '12.30'
            '13.30'
            '14.00'
            '14.30'
            '15.00'
            '15.30'
            '16.00'
            '16.30'
            '17.00'
            '17.30'
            '18.00'
            '18.30'
            '19.00'
            '19.30'
            '20.00'
            '20.30'
            '21.00'
            '21.30'
            '22.00'
            '22.30'
            '23.00'
            '23.30')
          EditMask = '!90:00;1;_'
          Editor = edComboEdit
          FieldName = 'DALLE'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HeaderFont.Charset = DEFAULT_CHARSET
          HeaderFont.Color = clWindowText
          HeaderFont.Height = -11
          HeaderFont.Name = 'Tahoma'
          HeaderFont.Style = []
          Name = 'DALLE'
          PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
          PrintFont.Charset = DEFAULT_CHARSET
          PrintFont.Color = clWindowText
          PrintFont.Height = -11
          PrintFont.Name = 'Tahoma'
          PrintFont.Style = []
          Width = 80
        end
        item
          Borders = []
          BorderPen.Color = cl3DLight
          CheckFalse = 'N'
          CheckTrue = 'Y'
          Color = clWindow
          EditMask = '!90:00;1;_'
          FieldName = 'ALLE'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HeaderFont.Charset = DEFAULT_CHARSET
          HeaderFont.Color = clWindowText
          HeaderFont.Height = -11
          HeaderFont.Name = 'Tahoma'
          HeaderFont.Style = []
          Name = 'ALLE'
          PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
          PrintFont.Charset = DEFAULT_CHARSET
          PrintFont.Color = clWindowText
          PrintFont.Height = -11
          PrintFont.Name = 'Tahoma'
          PrintFont.Style = []
          Width = 100
        end
        item
          Borders = []
          BorderPen.Color = cl3DLight
          CheckFalse = 'N'
          CheckTrue = 'Y'
          Color = clWindow
          FieldName = 'DescCausale'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HeaderFont.Charset = DEFAULT_CHARSET
          HeaderFont.Color = clBlue
          HeaderFont.Height = -11
          HeaderFont.Name = 'Tahoma'
          HeaderFont.Style = []
          Name = 'DESCCAUSALE'
          PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
          PrintFont.Charset = DEFAULT_CHARSET
          PrintFont.Color = clWindowText
          PrintFont.Height = -11
          PrintFont.Name = 'Tahoma'
          PrintFont.Style = []
          Width = 47
        end
        item
          Borders = []
          BorderPen.Color = cl3DLight
          CheckFalse = 'N'
          CheckTrue = 'Y'
          Color = clWindow
          FieldName = 'APPARATI'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HeaderFont.Charset = DEFAULT_CHARSET
          HeaderFont.Color = clWindowText
          HeaderFont.Height = -11
          HeaderFont.Name = 'Tahoma'
          HeaderFont.Style = []
          Name = 'APPARATI'
          PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
          PrintFont.Charset = DEFAULT_CHARSET
          PrintFont.Color = clWindowText
          PrintFont.Height = -11
          PrintFont.Name = 'Tahoma'
          PrintFont.Style = []
          Width = 65
        end
        item
          Borders = []
          BorderPen.Color = cl3DLight
          CheckFalse = 'N'
          CheckTrue = 'Y'
          Color = clWindow
          FieldName = 'DescTTurno'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HeaderFont.Charset = DEFAULT_CHARSET
          HeaderFont.Color = clWindowText
          HeaderFont.Height = -11
          HeaderFont.Name = 'Tahoma'
          HeaderFont.Style = []
          Name = 'DESCTTURNO'
          PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
          PrintFont.Charset = DEFAULT_CHARSET
          PrintFont.Color = clWindowText
          PrintFont.Height = -11
          PrintFont.Name = 'Tahoma'
          PrintFont.Style = []
          Width = 81
        end
        item
          Borders = []
          BorderPen.Color = cl3DLight
          CheckFalse = 'N'
          CheckTrue = 'Y'
          Color = clWindow
          FieldName = 'DescServizio'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HeaderFont.Charset = DEFAULT_CHARSET
          HeaderFont.Color = clWindowText
          HeaderFont.Height = -11
          HeaderFont.Name = 'Tahoma'
          HeaderFont.Style = []
          Name = 'DESCSERVIZIO'
          PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
          PrintFont.Charset = DEFAULT_CHARSET
          PrintFont.Color = clWindowText
          PrintFont.Height = -11
          PrintFont.Name = 'Tahoma'
          PrintFont.Style = []
        end
        item
          Borders = []
          BorderPen.Color = cl3DLight
          CheckFalse = 'N'
          CheckTrue = 'Y'
          Color = clWindow
          FieldName = 'NOTE_SERVIZIO'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HeaderFont.Charset = DEFAULT_CHARSET
          HeaderFont.Color = clWindowText
          HeaderFont.Height = -11
          HeaderFont.Name = 'Tahoma'
          HeaderFont.Style = []
          Name = 'NOTE_SERVIZIO'
          PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
          PrintFont.Charset = DEFAULT_CHARSET
          PrintFont.Color = clWindowText
          PrintFont.Height = -11
          PrintFont.Name = 'Tahoma'
          PrintFont.Style = []
          Width = 43
        end
        item
          Borders = []
          BorderPen.Color = cl3DLight
          CheckBoxField = True
          CheckFalse = 'A'
          CheckTrue = 'C'
          Color = clWindow
          FieldName = 'STATO'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HeaderFont.Charset = ANSI_CHARSET
          HeaderFont.Color = clWindowText
          HeaderFont.Height = -11
          HeaderFont.Name = 'Arial'
          HeaderFont.Style = []
          PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
          PrintFont.Charset = ANSI_CHARSET
          PrintFont.Color = clWindowText
          PrintFont.Height = -11
          PrintFont.Name = 'Arial'
          PrintFont.Style = []
          ReadOnly = True
          Width = 32
        end
        item
          Borders = []
          BorderPen.Color = cl3DLight
          CheckFalse = 'N'
          CheckTrue = 'Y'
          Color = clWindow
          FieldName = 'COMANDATO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          HeaderFont.Charset = DEFAULT_CHARSET
          HeaderFont.Color = clWindowText
          HeaderFont.Height = -11
          HeaderFont.Name = 'Tahoma'
          HeaderFont.Style = []
          Name = 'COMANDATO'
          PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
          PrintFont.Charset = DEFAULT_CHARSET
          PrintFont.Color = clWindowText
          PrintFont.Height = -11
          PrintFont.Name = 'Tahoma'
          PrintFont.Style = []
          Width = 47
        end
        item
          Borders = []
          BorderPen.Color = cl3DLight
          CheckFalse = 'N'
          CheckTrue = 'Y'
          Color = clWindow
          FieldName = 'CAUSALE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          HeaderFont.Charset = DEFAULT_CHARSET
          HeaderFont.Color = clWindowText
          HeaderFont.Height = -11
          HeaderFont.Name = 'Tahoma'
          HeaderFont.Style = []
          Name = 'CAUSALE'
          PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
          PrintFont.Charset = DEFAULT_CHARSET
          PrintFont.Color = clWindowText
          PrintFont.Height = -11
          PrintFont.Name = 'Tahoma'
          PrintFont.Style = []
          Width = 85
        end
        item
          Borders = []
          BorderPen.Color = cl3DLight
          CheckFalse = 'N'
          CheckTrue = 'Y'
          Color = clWindow
          FieldName = 'TIPO_TURNO'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HeaderFont.Charset = ANSI_CHARSET
          HeaderFont.Color = clWindowText
          HeaderFont.Height = -11
          HeaderFont.Name = 'Arial'
          HeaderFont.Style = []
          Name = 'TIPO_TURNO'
          PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
          PrintFont.Charset = ANSI_CHARSET
          PrintFont.Color = clWindowText
          PrintFont.Height = -11
          PrintFont.Name = 'Arial'
          PrintFont.Style = []
          Width = 64
        end>
      DataSource = DButton
      DatasetTypeAuto = False
      EditPostMode = epRow
      InvalidPicture.Data = {
        055449636F6E0000010001002020200000000000A81000001600000028000000
        2000000040000000010020000000000000100000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000003000000290000005C0000008B000000AF000000C1
        000000CA000000CB000000C9000000C1000000AF0000008A0000005E0000002C
        0000000400000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000220000007100001CBE000047F401015DFF01016CFF000074FF
        000075FF00006CFF01015EFF010145FF000020FF000001F3000000DE000000AE
        0000006B00000026000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000005401013DC5010175FF010186FF010189FF000085FF000082FF000081FF
        000080FF000080FF000080FF000083FF000082FF01016EFF01013FFF000007FB
        000000E0000000A10000004D0000000700000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000300003A8B
        010178FF010191FF00008AFF000085FF000085FF000085FF000085FF000086FF
        000086FF000084FF000081FF000080FF00007FFF000081FF000085FF010172FF
        000030FF000000F5000000C3000000610000000A000000000000000000000000
        000000000000000000000000000000000000000000000001010159A5010193FF
        01018EFF000089FF000089FF00008CFF00008CFF00008FFF000090FF000090FF
        000090FF00008FFF00008BFF00008AFF000086FF000082FF00007EFF000081FF
        010182FF00004FFF000000FC000000CB0000005F000000080000000000000000
        0000000000000000000000000000000000000000010167AA02029EFF01018EFF
        00008CFF00008FFF000092FF000095FF000098FF000099FF000098FF00009BFF
        00009AFF000098FF000097FF000094FF00008FFF00008BFF000087FF000082FF
        00007FFF010188FF00005BFF000000FC000000C4000000530000000000000000
        00000000000000000000000000000000010169850202A4FF010191FF000090FF
        000095FF000093FF000096FF00009DFF0000A2FF0000A2FF0000A2FF0000A3FF
        0000A2FF0000A1FF00009FFF00009BFF000097FF00008DFF00008BFF00008AFF
        000084FF00007FFF01018BFF000054FF000000F6000000AC0000003000000000
        000000000000000000000000000168400202A6FF020294FF000094FF00009AFF
        000098FF4949BFFF5353C4FF00009DFF0000A7FF0000A9FF0101AAFF0101AAFF
        0101A9FF0101A8FF0000A5FF0000A2FF00009AFF5F5FC5FF3A3AB3FF00008AFF
        00008BFF000086FF010183FF01018BFF000037FF000000E50000007900000009
        0000000000000000000000000202A2D803039EFF00009AFF0000A0FF0000A1FF
        2929ABFFFFFFFAFFFFFFFFFF4A4AC8FF0000A5FF0000AFFF0000AFFF0101AEFF
        0101B0FF0000AFFF0000ACFF0000A5FF4848B6FFFFFFFFFFFFFFFFFF2424AEFF
        00008FFF000090FF000089FF01018BFF010180FF00000CFF000000BB00000038
        00000000000000000101655C0303B2FF02029EFF0000A4FF0000AAFF2F2FA9FF
        CCCCC0FFFFFFF4FFFFFFFFFFFFFFFFFF4141CAFF0000ACFF0000B3FF0000B3FF
        0000B3FF0000B2FF0000ADFF4343B5FFEDEDD9FFFFFFFFFFFFFFFFFFFFFFFFFF
        3232AFFF000095FF000092FF01018BFF020293FF010155FF000000E50000006F
        00000000000000000303A6D70303A2FF0202A5FF0000ACFF0000B2FF78788DFF
        CBCBA5FFFFFFFCFFFFFFFFFFFFFFFFFFFFFFFFFF4F4FCEFF0000AEFF0000B5FF
        0000B6FF0000B2FF4B4BBDFFF2F2D9FFFFFFF8FFFFFFFFFFFFFFFFFFF8F8D4FF
        8282AEFF0000A2FF00009DFF010194FF020291FF02028CFF000110FD0000009F
        000000180000C5200404A3FF0404A7FF0202ADFF0101B3FF0000BCFF0000B0FF
        606073FFC4C4A9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4040CFFF0000B1FF
        0000B3FF4E4EC8FFF6F6DFFFFFFFF6FFFFFFFFFFFFFFFFFFE7E7CBFF737393FF
        0000A9FF0000ABFF0000A4FF01019BFF020292FF02029BFF010139FF000000C2
        000000370201BE6D0505A7FF0404AEFF0303B6FF0303BBFF0101C1FF0000CDFF
        0000B9FF56566EFFC0C0A5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3B3BCFFF
        5050D7FFFFFFFAFFFFFFF5FFFFFFFFFFFFFFFFFFE0E0C8FF6D6D8FFF0000B2FF
        0000B8FF0000B1FF0101ABFF0101A3FF01019AFF02029EFF02026FFF000000DC
        0000004D0405BAA10707ADFF0606B5FF0404BBFF0505C2FF0505C8FF0303CBFF
        0000D2FF0000BAFF616177FFC6C6ABFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE9E9CDFF747495FF0000B7FF0000C2FF
        0101BDFF0202B8FF0202B2FF0101AAFF02029FFF03039EFF020289FF000004E6
        000000550606B9CB0808B5FF0606BBFF0606C4FF0606C9FF0606CDFF0606D0FF
        0202CFFF0000D4FF0000BDFF6E6E86FFDADABDFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFF5F5DAFF8181A4FF0000BCFF0000C5FF0000C4FF
        0303C1FF0303BEFF0202B8FF0202B0FF0202A6FF0303A1FF03039FFF00000CEC
        000000590909BBE80909BAFF0808C2FF0808CAFF0808D0FF0909D4FF0707D4FF
        0303D2FF0000D0FF0000D4FF0000C2FF8A8AAEFFF7F7EAFFFFFFFFFFFEFEFEFF
        FEFEFEFFFFFFFFFFFFFFF9FF9393C8FF0000C3FF0000C8FF0000C6FF0101C6FF
        0404C6FF0505C5FF0303BEFF0202B6FF0202ACFF0303A3FF0606AEFF010113ED
        0000005A0A0ABFF80C0CC2FF0B0BC9FF0B0BD0FF0B0BD8FF0D0DDCFF0808D9FF
        0303D5FF0000D2FF0000D2FF0000D4FF4648C5FFF9F9E6FFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFF6FF3A3ACEFF0000C6FF0000CBFF0000C9FF0303CAFF
        0505CAFF0505CAFF0505C4FF0404BEFF0404B2FF0505A9FF0505B9FF010115EB
        000000570B0BC6EA1010C9FF0E0ED0FF0E0EDAFF0F0FE1FF0F0FE2FF0B0BE0FF
        0303DAFF0000D6FF0000D4FF4242CBFFE9E9D5FFFFFFFBFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFEFFFFFFF9FF4949DEFF0000C6FF0000CCFF0101CDFF
        0606CFFF0707CFFF0606C9FF0505C3FF0505B7FF0606ADFF0707B8FF010113E2
        0000004F0C0CCDCE1313CFFF1212D7FF1313E1FF1313E9FF1313ECFF0C0CE7FF
        0000E0FF0000DCFF3F3FCDFFEAEAD2FFFFFFF6FFFFFFFFFFFFFFFFFFFFFFF5FF
        FFFFF3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4343DCFF0000CAFF0000D2FF
        0606D4FF0A0AD3FF0808CEFF0808C6FF0707BBFF0808B4FF0606B3FF01010ED4
        000000410909D7A41515D4FF1717E0FF1818E9FF1A1AF2FF1A1AF5FF0E0EF3FF
        0000EBFF4848D2FFECECD0FFFFFFF5FFFFFFFFFFFFFFFFFFEEEED6FF8585BBFF
        8787ADFFDDDDC5FFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFF4E4EE2FF0000D2FF
        0505DBFF0C0CD9FF0B0BD3FF0A0ACAFF0A0ABEFF0B0BBCFF0606A5FF000004B1
        000000200608DE751919D6FF1C1CE6FF1E1EF2FF2121FCFF1E1EFFFF0606FFFF
        4D4DE0FFE6E6CBFFFFFFF4FFFFFFFFFFFFFFFFFFEAEACAFF7B7BA3FF0000D9FF
        0000D4FF737389FFCBCBABFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4F4FEEFF
        0000E4FF0B0BE1FF0D0DDAFF0C0CCEFF0C0CC2FF0F0FC7FF060690FF00000085
        000000050000E6221717DCFF2222E9FF2626F9FF2727FFFF2424FFFF5E5ED6FF
        DFDFC0FFFFFFF5FFFFFFFFFFFFFFFFFFDFDFC2FF72729BFF0000DDFF0000E8FF
        0000E9FF0000D1FF605F7AFFC2C2A4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFF
        5656DFFF0606E8FF1010E0FF1111D4FF0F0FC7FF0E0ECEFF020253E200000047
        00000000000000001010E3D92424ECFF2D2DFFFF3131FFFF2F2FFFFF7C7C9FFF
        D8D8B2FFFFFFFFFFFFFFFFFFE1E1C0FF696996FF0000E0FF0000E9FF0000E6FF
        0000E4FF0000ECFF0000D4FF595971FFBEBE9DFFFFFFFFFFFFFFFDFFD6D6A6FF
        7272BFFF1010F6FF1616E4FF1515D6FF1313CFFF0D0DC5FF000021A200000012
        00000000000000000607E85C2121EDFF3030FFFF3C3CFFFF3E3EFFFF3B3BF8FF
        71719AFFD8D8BDFFD9D9BAFF6C6C99FF0000F1FF0000F6FF0000E9FF0000E6FF
        0000E7FF0000E8FF0000F5FF0000DEFF565674FFBBBB98FFC1C19BFF5F5FA8FF
        1717FFFF1919FAFF1C1CE7FF1919D9FF1515DBFF05058CF20000004300000000
        0000000000000000000000001313EED32E2EFDFF4040FFFF4B4BFFFF4F4FFFFF
        4C4CFBFF696981FF6B6B80FF2525FBFF1212FFFF0D0DFFFF0707FAFF0404F3FF
        0505F2FF0606F5FF0A0AFCFF0C0CFFFF1A1AF4FF606067FF5B5B8FFF2323FFFF
        2626FFFF2727FBFF2222E9FF1D1DE0FF1010D2FF000025880000000800000000
        0000000000000000000000000202F1352020F8FF3B3BFFFF4D4DFFFF5C5CFFFF
        6666FFFF6464FCFF5F5FF7FF5555FFFF4343FFFF3131FFFF2121FFFF1919FFFF
        1818FFFF1C1CFFFF2525FFFF3131FFFF3737FFFF3D3DF6FF3939FEFF3535FFFF
        3333FFFF2C2CFAFF2525EAFF1A1AE8FF030380C1000000170000000000000000
        000000000000000000000000000000000909F3712B2BFEFF4646FFFF5D5DFFFF
        6E6EFFFF7B7BFFFF8080FFFF8181FFFF7575FFFF6767FFFF5555FFFF4949FFFF
        4646FFFF4848FFFF4E4EFFFF5454FFFF5757FFFF5050FFFF4949FFFF4040FFFF
        3838FFFF2D2DF6FF2020F6FF0808B6DF00000423000000000000000000000000
        00000000000000000000000000000000000000000D0EF6902F2FFFFF4D4DFFFF
        6666FFFF7C7CFFFF8B8BFFFF9494FFFF9696FFFF9191FFFF8A8AFFFF7E7EFFFF
        7878FFFF7373FFFF7171FFFF6C6CFFFF6464FFFF5B5BFFFF5050FFFF4343FFFF
        3636FFFF2626FFFF0D0ECCE30000072800000000000000000000000000000000
        0000000000000000000000000000000000000000000000000A0AF8782B2BFDFF
        4E4EFFFF6868FFFF7F7FFFFF9292FFFFA0A0FFFFA5A5FFFFA7A7FFFFA2A2FFFF
        9999FFFF8E8EFFFF8282FFFF7575FFFF6868FFFF5959FFFF4B4BFFFF3A3AFFFF
        2727FFFF0B0BCEC600000A150000000000000000000000000000000000000000
        000000000000000000000000000000000000000000000000000000000001F841
        2121FCDD4545FFFF6262FFFF7979FFFF8C8CFFFF9B9BFFFFA4A4FFFFA3A3FFFF
        9B9BFFFF8E8EFFFF7E7EFFFF6C6CFFFF5D5DFFFF4B4BFFFF3838FFFF1F1FEFFF
        0405B77D00000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000708F96B2827FDE24646FEFF6464FFFF7474FFFF8080FFFF8484FFFF
        7E7EFFFF7373FFFF6363FFFF5353FFFF3F3FFEFF2323FAF40C0CE69800007B1C
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000A0AF9321415F9802727F9B03C3CFBD84949FFF1
        4848FFF53939FCDE2727F9BB1516F88B0608F9480708E4070000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000FF8000FFFF00007FFE00001FF800000FF0000007F0000007E0000003
        C0000001C0000001800000018000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000180000001
        80000003C0000003C0000007E000000FF000001FF800003FFC0000FFFF0001FF
        FFC007FF}
      ShowDesignHelper = False
      ShowUnicode = False
      OnGetRecordCount = GridServiziGetRecordCount
      ColWidths = (
        12
        28
        73
        75
        85
        64
        75
        80
        100
        47
        65
        81
        50
        43
        32
        47
        85
        64)
    end
  end
  object PnlBottom: TPanel [4]
    Left = 0
    Top = 464
    Width = 761
    Height = 116
    Align = alBottom
    TabOrder = 4
    object grpAssentiNonGiustificati: TGroupBox
      Left = 450
      Top = 1
      Width = 310
      Height = 114
      Align = alRight
      Caption = 'Assenti non giustificati'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object dgrdAssentiNonGiustificati: TDBGrid
        Left = 2
        Top = 15
        Width = 306
        Height = 97
        Align = alClient
        DataSource = A139FPianifServiziDtm.dsrAssenti
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
        OnDblClick = dgrdAssentiGiustificatiDblClick
      end
    end
    object grpAssentiGiustificati: TGroupBox
      Left = 1
      Top = 1
      Width = 449
      Height = 114
      Align = alClient
      Caption = 'Assenti giustificati'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object dgrdAssentiGiustificati: TDBGrid
        Left = 2
        Top = 15
        Width = 445
        Height = 97
        Align = alClient
        DataSource = A139FPianifServiziDtm.dsrT040
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
        OnDblClick = dgrdAssentiGiustificatiDblClick
      end
    end
  end
  object PnlTop: TPanel [5]
    Left = 0
    Top = 51
    Width = 761
    Height = 76
    Align = alTop
    TabOrder = 2
    object lblTipoGiorno1: TLabel
      Left = 9
      Top = 60
      Width = 68
      Height = 13
      Caption = 'lblTipoGiorno1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object SpeedButton1: TSpeedButton
      Left = 76
      Top = 36
      Width = 14
      Height = 22
      Caption = '...'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      OnClick = SpeedButton1Click
    end
    object SpeedButton2: TSpeedButton
      Left = 167
      Top = 36
      Width = 14
      Height = 22
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      OnClick = SpeedButton2Click
    end
    object Label3: TLabel
      Left = 10
      Top = 21
      Width = 48
      Height = 13
      Caption = 'Dalla data'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 100
      Top = 21
      Width = 41
      Height = 13
      Caption = 'Alla data'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblTipoGiorno2: TLabel
      Left = 100
      Top = 60
      Width = 68
      Height = 13
      Caption = 'lblTipoGiorno2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object edtDatada: TMaskEdit
      Left = 10
      Top = 37
      Width = 66
      Height = 21
      EditMask = '!00/00/0000;1;_'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
      OnExit = edtDatadaExit
      OnKeyPress = edtDatadaKeyPress
    end
    object edtDataa: TMaskEdit
      Left = 100
      Top = 37
      Width = 67
      Height = 21
      EditMask = '!00/00/0000;1;_'
      MaxLength = 10
      TabOrder = 2
      Text = '  /  /    '
      OnDblClick = edtDataaDblClick
      OnExit = edtDatadaExit
      OnKeyPress = edtDatadaKeyPress
    end
    object chkColonneAutoDimensionate: TCheckBox
      Left = 10
      Top = 2
      Width = 147
      Height = 19
      Caption = 'Colonne auto-dimensionate'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = chkColonneAutoDimensionateClick
    end
    object chkTTurno: TCheckBox
      Left = 191
      Top = 20
      Width = 72
      Height = 17
      Caption = 'Tipo Turno'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      TabOrder = 3
      OnClick = chkTTurnoClick
    end
    object DBCmbTTurno: TDBLookupComboBox
      Left = 191
      Top = 37
      Width = 191
      Height = 21
      DataField = 'CODICE'
      DataSource = A139FPianifServiziDtm.DscSuppT545
      KeyField = 'CODICE'
      ListField = 'DESCRIZIONE'
      ListSource = A139FPianifServiziDtm.DscT545
      NullValueKey = 46
      TabOrder = 4
    end
    object chkServizio: TCheckBox
      Left = 390
      Top = 20
      Width = 59
      Height = 17
      Caption = 'Servizio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = chkServizioClick
    end
    object DBCmbServizio: TDBLookupComboBox
      Left = 390
      Top = 37
      Width = 276
      Height = 21
      DataField = 'Codice'
      DataSource = A139FPianifServiziDtm.DscSuppT540
      KeyField = 'CODICE'
      ListField = 'DESCRIZIONE'
      ListSource = A139FPianifServiziDtm.DscT540
      NullValueKey = 46
      TabOrder = 6
    end
    object chkOrdinamento: TCheckBox
      Left = 191
      Top = 2
      Width = 147
      Height = 19
      Caption = 'Ordinamento cronologico'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      OnClick = chkOrdinamentoClick
    end
  end
  object ToolBar1: TToolBar [6]
    Left = 0
    Top = 0
    Width = 761
    Height = 25
    ButtonHeight = 24
    Flat = False
    Images = ImageListA139
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 46
      Height = 24
      BevelOuter = bvNone
      TabOrder = 0
      inline frmSelAnagrafe: TfrmSelAnagrafe
        Left = 0
        Top = 0
        Width = 46
        Height = 58
        Align = alTop
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 46
        ExplicitHeight = 58
        inherited pnlSelAnagrafe: TPanel
          Width = 46
          Height = 58
          BevelOuter = bvNone
          ExplicitWidth = 46
          ExplicitHeight = 58
          inherited btnSelezione: TBitBtn
            Left = 1
            OnClick = frmSelAnagrafebtnSelezioneClick
            ExplicitLeft = 1
          end
          inherited btnEreditaSelezione: TBitBtn
            OnClick = frmSelAnagrafebtnEreditaSelezioneClick
          end
        end
      end
    end
    object ToolButton2: TToolButton
      Left = 46
      Top = 0
      Width = 7
      Caption = 'ToolButton2'
      ImageIndex = 5
      Style = tbsSeparator
    end
    object btnServiziComandati: TSpeedButton
      Left = 53
      Top = 0
      Width = 110
      Height = 24
      AllowAllUp = True
      GroupIndex = 1
      Caption = 'Servizi normali'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnClick = btnServiziComandatiClick
    end
    object ToolButton12: TToolButton
      Left = 163
      Top = 0
      Width = 7
      Caption = 'ToolButton12'
      ImageIndex = 5
      Style = tbsSeparator
    end
    object ToolButton5: TToolButton
      Left = 170
      Top = 0
      Action = actOpenA004
    end
    object ToolButton7: TToolButton
      Left = 193
      Top = 0
      Action = actShowQuadroRiass
    end
    object ToolButton8: TToolButton
      Left = 216
      Top = 0
      Action = actOpenA097
    end
    object ToolButton11: TToolButton
      Left = 239
      Top = 0
      Width = 7
      Caption = 'ToolButton11'
      ImageIndex = 4
      Style = tbsSeparator
    end
    object ToolButton18: TToolButton
      Left = 246
      Top = 0
      Action = actDuplicaRiga
    end
    object ToolButton4: TToolButton
      Left = 269
      Top = 0
      Action = actRegistraServizio
    end
    object BtnAnomalie: TSpeedButton
      Left = 292
      Top = 0
      Width = 78
      Height = 24
      Caption = 'Anomalie'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F7F00
        00FF7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF00FFFFFFFFFF00FFFF0000FF0000FF0000FF00FFFFFFFFFF00FFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFF7F7F7F00
        00FF7F7F7FFFFFFF00FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
        FFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFFFFFF
        FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFF00
        00FF00FFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
        FFFFFF00FFFFFFFFFF00FFFFFFFFFF0000FF7F7F7F00FFFFFFFFFF00FFFFFFFF
        FF00FFFFFFFFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFF00
        00FF0000FFFFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFFFFFFFF00FFFF
        FFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFF0000FF0000FFFFFFFF00FFFFFFFF
        FF00FFFFFFFFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFF7F7F7F7F7F7F00FFFFFF
        FFFF7F7F7F0000FF0000FFFFFFFF00FFFFFFFFFF00FFFFFFFFFFFFFFFF00FFFF
        FFFFFF00FFFF0000FF0000FFFFFFFF00FFFF7F7F7F0000FF0000FF00FFFFFFFF
        FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFF0000FF0000FF7F7F7FFF
        FFFF7F7F7F0000FF0000FFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
        FFFFFF00FFFFFFFFFF0000FF0000FF0000FF0000FF0000FFFFFFFF00FFFFFFFF
        FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFF0000FF00
        00FF0000FFFFFFFF00FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFF
        FFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      ParentFont = False
      OnClick = BtnAnomalieClick
    end
    object ToolButton15: TToolButton
      Left = 370
      Top = 0
      Width = 7
      Caption = 'ToolButton15'
      ImageIndex = 5
      Style = tbsSeparator
    end
    object ToolButton9: TToolButton
      Left = 377
      Top = 0
      Action = actChiudiServizio
    end
    object ToolButton17: TToolButton
      Left = 400
      Top = 0
      Action = actSbloccaPattuglia
    end
    object ToolButton20: TToolButton
      Left = 423
      Top = 0
      Width = 7
      Caption = 'ToolButton20'
      ImageIndex = 7
      Style = tbsSeparator
    end
    object ToolButton19: TToolButton
      Left = 430
      Top = 0
      Action = actApriNote
      ImageIndex = 7
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 408
  end
  inherited DButton: TDataSource
    Left = 436
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 464
  end
  inherited ImageList1: TImageList
    Left = 492
  end
  inherited ActionList1: TActionList
    Left = 520
  end
  object PopupMenu1: TPopupMenu
    Images = ImageListA139
    OnPopup = PopupMenu1Popup
    Left = 503
    Top = 65535
    object Rinumerapattuglie1: TMenuItem
      Action = actRinumera
    end
    object Duplicariga1: TMenuItem
      Action = actDuplicaRiga
    end
    object Commento1: TMenuItem
      Action = actInsCommento
    end
    object actSaltoPagina1: TMenuItem
      Action = actSaltoPagina
    end
    object N7: TMenuItem
      Caption = '-'
    end
    object actRegistra1: TMenuItem
      Action = actRegistraPattuglia
    end
    object RegistraTutto1: TMenuItem
      Action = actRegistraServizio
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object Registrasingolapattuglia1: TMenuItem
      Action = actChiudiPattuglia
    end
    object Sbloccasingolapattuglia1: TMenuItem
      Action = actSbloccaPattuglia
    end
    object Chiudituttoilservizio1: TMenuItem
      Action = actChiudiServizio
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object InsCancgiustificativi1: TMenuItem
      Action = actOpenA004
    end
    object actShowQuadroRiass1: TMenuItem
      Action = actShowQuadroRiass
    end
    object urnistraordinari1: TMenuItem
      Action = actOpenA097
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object RegistraT5201: TMenuItem
      Action = actRegistraT520
    end
    object actVisualizzaT5201: TMenuItem
      Action = actVisualizzaT520
    end
    object Cancella2: TMenuItem
      Action = actCancellapianificazionecorrente
    end
  end
  object ActionList3: TActionList
    Images = ImageListA139
    Left = 531
    Top = 65535
    object actRegistraPattuglia: TAction
      Caption = 'Controlla singola pattuglia'
      Hint = 'Controlla singola pattuglia'
      OnExecute = actRegistraPattugliaExecute
    end
    object actRegistraServizio: TAction
      Caption = 'Controlla tutto il servizio'
      Hint = 'Controlla tutto il servizio'
      ImageIndex = 0
      OnExecute = actRegistraServizioExecute
    end
    object actRegistraT520: TAction
      Caption = 'Registra il servizio corrente come modello '
      Hint = 'Registra il servizio corrente come modello '
      OnExecute = actRegistraT520Execute
    end
    object actVisualizzaT520: TAction
      Caption = 'Utilizza modelli esistenti'
      OnExecute = actVisualizzaT520Execute
    end
    object actCancellapianificazionecorrente: TAction
      Caption = 'Cancella servizio corrente'
      Hint = 'Cancella servizio corrente'
      OnExecute = actCancellapianificazionecorrenteExecute
    end
    object actOpenA004: TAction
      Caption = 'Giustificativi'
      Hint = 'Giustificativi'
      ImageIndex = 2
      OnExecute = actOpenA004Execute
    end
    object actOpenA097: TAction
      Caption = 'Turni straordinari'
      Hint = 'Turni straordinari'
      ImageIndex = 3
      OnExecute = actOpenA097Execute
    end
    object actChiudiPattuglia: TAction
      Caption = 'Conferma singola pattuglia'
      Hint = 'Conferma singola pattuglia'
      OnExecute = actChiudiPattugliaExecute
    end
    object actChiudiServizio: TAction
      Caption = 'Conferma tutto il servizio'
      Hint = 'Conferma tutto il servizio'
      ImageIndex = 4
      OnExecute = actChiudiServizioExecute
    end
    object actSbloccaPattuglia: TAction
      Caption = 'Sblocca singola pattuglia'
      Hint = 'Sblocca singola pattuglia'
      ImageIndex = 5
      OnExecute = actSbloccaPattugliaExecute
    end
    object actRinumera: TAction
      Caption = 'Rinumera pattuglie'
      Hint = 'Rinumera pattuglie'
      OnExecute = actRinumeraExecute
    end
    object actDuplicaRiga: TAction
      Caption = 'Duplica riga'
      Hint = 'Duplica riga'
      ImageIndex = 6
      OnExecute = actDuplicaRigaExecute
    end
    object actApriNote: TAction
      Caption = 'actApriNote'
      OnExecute = actApriNoteExecute
    end
    object actShowQuadroRiass: TAction
      Caption = 'Mostra quadro riassuntivo'
      Hint = 'Mostra quadro riassuntivo'
      ImageIndex = 1
      OnExecute = actShowQuadroRiassExecute
    end
    object actSaltoPagina: TAction
      Caption = 'Salto pagina'
      OnExecute = actSaltoPaginaExecute
    end
    object actInsCommento: TAction
      Caption = 'Commento'
      Hint = 'Commento'
      OnExecute = actInsCommentoExecute
    end
  end
  object ImageListA139: TImageList
    Left = 560
    Top = 65535
    Bitmap = {
      494C010108000A00040010001000FFFFFFFFFF00FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000000000FFFF000080
      8000008080000080800000808000008080000080800000808000008080000080
      8000008080008080800000000000000000000000000000000000000000000000
      00000000000000000000BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000000000FFFF000080
      800000FFFF000080800000FFFF00000000000000000000FFFF000080800000FF
      FF00008080008080800000000000000000000000000000000000000000000000
      00007B7B7B007B7B7B00BDBDBD007B7B7B00000000007B7B7B00BDBDBD007B7B
      7B007B7B7B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF00000000000000000000000000000000
      000000000000FFFFFF000000000000000000000000000000000000FFFF000080
      8000008080000080800000808000000000000000000000808000008080000080
      800000808000808080000000000000000000000000000000000000000000BDBD
      BD00BDBDBD00BDBDBD00BDBDBD007B7B7B00000000007B7B7B00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD0000000000000000000000000000000000000000000000
      0000000000000000000080000000800000008000000080000000800000008000
      00008000000080000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000FFFF00FFFFFF0000FFFF00FFFF
      FF0000FFFF000000000000000000FFFF0000000000000000000000FFFF000080
      800000FFFF0000808000C0C0C0000000000000000000C0C0C0000080800000FF
      FF00008080008080800000000000000000000000000000000000000000007B7B
      7B007B7B7B007B7B7B00BDBDBD00BDBDBD0000000000BDBDBD00BDBDBD007B7B
      7B007B7B7B007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000080000000000000000000000000000000000000000000
      00000000000080000000000000000000000000000000FFFFFF0000000000FFFF
      0000FFFF0000FFFF0000FFFF0000000000000000000000000000FFFFFF0000FF
      FF00FFFFFF0000FFFF0000000000FFFF0000000000000000000000FFFF000080
      8000008080000080800000000000000000000000000000000000008080000080
      800000808000808080000000000000000000000000000000000000000000BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00000000000000000000000000BDBDBD00BDBD
      BD00BDBDBD00BDBDBD0000000000000000000000000000000000000000000000
      0000000000000000000080000000000000000000000000000000000000000000
      00000000000080000000000000000000000000000000FFFFFF00FFFFFF000000
      000000000000FFFFFF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000000000FFFF0000000000000000000000FFFF000080
      800000FFFF0000808000000000000000000000000000000000000080800000FF
      FF00008080008080800000000000000000000000000000000000000000007B7B
      7B007B7B7B007B7B7B007B7B7B000000000000000000000000007B7B7B007B7B
      7B007B7B7B007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000080000000000000000000000000000000000000000000
      00000000000080000000000000000000000000000000FFFFFF00FFFF00000000
      000000FFFF000000000000000000000000000000000000000000FFFFFF0000FF
      FF00FFFFFF0000FFFF0000000000FFFF0000000000000000000000FFFF000080
      8000008080000080800080808000000000000000000080808000008080000080
      80000080800080808000000000000000000000FFFF000000000000000000BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD0000000000000000000000000000000000000000000000
      0000000000000000000080000000000000000000000000000000000000000000
      00000000000080000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000000000FFFF0000000000000000000000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF008080800000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080000000000000000000000000000000800000008000
      00008000000080000000000000000000000000000000FFFFFF00FFFF0000FFFF
      0000FFFF00000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000FFFF0000000000FFFF00000000000000000000000000008080
      80000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF008080
      800000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF0000FFFF000000000000000000000000000000000000000000BDBD
      BD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080000000000000000000000000000000800000000000
      00008000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000FFFF00000000000000000000FFFF00FFFF
      FF0000FFFF000000000000000000000000000000000000000000000000008080
      8000000000000000000000000000000000000000000000000000000000008080
      80000000000000000000000000000000000000FFFF0000FFFF0000FFFF0000FF
      FF007B7B7B00000000007B7B7B0000FFFF0000FFFF000000000000000000BDBD
      BD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080000000000000000000000000000000800000008000
      00000000000000000000000000000000000000000000FFFFFF00FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF00000000000000FFFF0000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000008080
      8000000000000000000000000000000000000000000000000000000000008080
      800000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000000000BDBDBD000000000000000000000000000000000000000000BDBD
      BD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080000000800000008000000080000000800000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000FFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000008080
      8000000000000000000000000000000000000000000000000000000000008080
      8000000000000000000000000000000000000000000000FFFF000000000000FF
      FF0000000000BDBDBD000000000000000000000000000000000000000000BDBD
      BD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000FFFFFF0000000000FFFFFF0000000000FFFFFF000000000000FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000008080
      8000000000000000000000000000000000000000000000000000000000008080
      80000000000000000000000000000000000000FFFF00000000000000000000FF
      FF007B7B7B007B7B7B00BDBDBD00000000000000000000000000BDBDBD007B7B
      7B007B7B7B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000808080000000
      00008080800000000000808080000000000080808000000000000000000000FF
      FF0000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000808080000000000000000000000000000000000000000000808080000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF000000000000000000BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000808080000000
      0000808080000000000080808000000000008080800000000000FFFFFF000000
      00000000FF0000000000FFFFFF00FFFFFF000000000000000000000000000000
      0000000000008080800080808000808080008080800080808000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF0000000000FFFF
      FF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF00BDBDBD00FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000000000000000000000000000000000000000000000000
      0000000000000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B00000000000000FF00FFFFFF00FF000000FFFFFF00FFFFFF00FFFFFF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF0000008000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000007B7B
      7B000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF0000000000000000000000FF
      FF000000000000FFFF000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000008000
      0000BFBFBF00BFBFBF000000800000FFFF0000008000BFBFBF00BFBFBF008000
      0000800000008000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B007B7B7B007B7B
      7B007B7B7B000000FF00BDBDBD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF00000000000000FFFF000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BFBFBF00BFBFBF00BFBFBF0000008000FFFFFF00FFFFFF007F7F7F000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B0000000000000000000000FF00FFFFFF00FF000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FF000000FFFFFF00FFFF0000000000000000000000FF
      FF000000000000FFFF000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BFBFBF00BFBFBF00BFBFBF0000FFFF00FFFFFF007F7F7F007F7F7F000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000007B7B
      7B000000FF00000000000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00FF00
      0000FFFFFF00FFFFFF00FFFFFF000000FF00FFFF00000000000000FFFF000000
      000000FFFF0000000000000000000000000000000000000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000BFBFBF00BFBFBF0000008000FFFFFF007F7F7F00000000000000
      000000000000000000000000000000000000000000007F7F7F000000FF000000
      FF0000000000000000000000FF000000FF000000FF0000000000000000000000
      000000000000000000000000000000000000000000007B7B7B007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B000000FF000000FF00BDBDBD00FFFFFF00FF00
      0000FFFFFF00BDBDBD000000FF000000FF00FFFF0000000000000000000000FF
      FF000000000000FFFF000000000000FFFF000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000BFBFBF0000FFFF007F7F7F0000000000000000000000
      0000000000000000000000000000000000007F7F7F000000FF00000000000000
      00000000000000000000000000000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B0000000000000000007B7B7B0000000000000000000000FF000000FF000000
      FF000000FF000000FF000000000000000000FFFF00000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000BFBFBF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      000000000000000000000000000000000000000000000000FF00000000007B7B
      7B000000FF00000000007B7B7B000000FF00000000007B7B7B000000FF000000
      00007B7B7B000000FF00000000000000000000000000000000000000000000FF
      FF000000000000FFFF00000000000000000000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000008000FFFFFF000000800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      000000000000000000000000000000000000000000007B7B7B007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B00000000000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800000FFFF0000008000FFFFFF0000008000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007B7B7B0000000000000000007B7B7B00000000000000
      00007B7B7B000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BFBFBF00BFBFBF000000800000FFFF00FFFFFF0000FFFF007F7F7F000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007F7F7F000000
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000000000007B7B7B000000FF00000000007B7B7B000000FF000000
      00007B7B7B000000FF0000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BFBFBF00BFBFBF00BFBFBF00BFBFBF0000008000FFFFFF007F7F7F000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000008000
      0000BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF008000
      0000800000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF0000000000FF000000FF000000FF000000FF00
      0000FF000000FF000000BDBDBD00BDBDBD00BDBDBD00BDBDBD00FF000000FF00
      0000FF000000FF000000FF000000FF0000000000000000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF0000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      000080000000800000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000C003FC1FFFFF8000C003F007FFFF0000
      C003E003FFFF0000C003C001FC030000C003C001FD0B0000C003C001C1FB0000
      C003C001FD0B0000C0034001E1FB0000C003A003FD030000E007C3C7E1D70000
      E7E70047FDCF0000E7E7C1C7E41F0000E7E7A1C7FDFF0000E7E76007C3FF0000
      F00FE80FFFFF0000F81FEC1FFFFF0000FFFFF800FC00FFFFFFFF0000FDFE8003
      F9FF680020D28003F0FF20000A7E8003F0FF0000147AE00FE07F6C002AA6E00F
      C07F24001406F01F843F00002AAEF83F1E3F6D82101EFC7FFE1F24920832F83F
      FF1F0000E07EF01FFF8F7DB6F8F0E00FFFC77C92F196E00FFFE30000E1F58003
      FFF80000C5F38003FFFF0000EC078003}
  end
end
