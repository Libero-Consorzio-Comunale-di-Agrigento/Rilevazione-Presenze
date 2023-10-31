object A139FQuadroRiass: TA139FQuadroRiass
  Left = 0
  Top = 0
  Caption = '<A139> Quadro Riassuntivo'
  ClientHeight = 475
  ClientWidth = 667
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GridQuadro: TAdvStringGrid
    Left = 0
    Top = 0
    Width = 667
    Height = 439
    Cursor = crDefault
    Align = alClient
    ColCount = 6
    DefaultColWidth = 100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goRowSizing, goColSizing]
    ParentFont = False
    PopupMenu = PopupMenu
    ScrollBars = ssBoth
    TabOrder = 0
    OnDrawCell = GridQuadroDrawCell
    OnGetCellColor = GridQuadroGetCellColor
    ActiveCellFont.Charset = DEFAULT_CHARSET
    ActiveCellFont.Color = clWindowText
    ActiveCellFont.Height = -11
    ActiveCellFont.Name = 'Tahoma'
    ActiveCellFont.Style = [fsBold]
    ActiveCellColor = clWhite
    ActiveCellColorTo = 16767411
    ControlLook.FixedGradientFrom = clWhite
    ControlLook.FixedGradientTo = clBtnFace
    ControlLook.ControlStyle = csClassic
    Filter = <>
    FixedColWidth = 100
    FixedRowHeight = 50
    FixedFont.Charset = DEFAULT_CHARSET
    FixedFont.Color = clWindowText
    FixedFont.Height = -11
    FixedFont.Name = 'Tahoma'
    FixedFont.Style = [fsBold]
    FloatFormat = '%.2f'
    Look = glClassic
    Multilinecells = True
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
    SearchFooter.ColorTo = 16767411
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
    WordWrap = False
    ColWidths = (
      100
      20
      20
      20
      20
      20)
    RowHeights = (
      50
      22
      22
      22
      22
      22
      22
      22
      22
      22)
  end
  object pnlCmd: TPanel
    Left = 0
    Top = 439
    Width = 667
    Height = 36
    Align = alBottom
    BiDiMode = bdRightToLeft
    ParentBiDiMode = False
    TabOrder = 1
    DesignSize = (
      667
      36)
    object btnSelDip: TSpeedButton
      Left = 432
      Top = 6
      Width = 136
      Height = 24
      Action = actInsPattuglia
      Anchors = [akTop, akRight]
      BiDiMode = bdRightToLeft
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000C40E0000C40E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFF44FFFFFFFFFFFFF4224FFFFFFFFFFF422224FFFFFFFFF42222224FFF
        FFFF4222A22224FFFFFF222AFA2224FFFFFFA2AFFFA2224FFFFFFAFFFFFA2224
        FFFFFFFFFFFFA2224FFFFFFFFFFFFA2224FFFFFFFFFFFFA2224FFFFFFFFFFFFA
        2224FFFFFFFFFFFFA224FFFFFFFFFFFFFA22FFFFFFFFFFFFFFA7}
      ParentBiDiMode = False
    end
    object lblMessaggio: TLabel
      Left = 7
      Top = 14
      Width = 5
      Height = 19
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnAnnulla: TSpeedButton
      Left = 574
      Top = 7
      Width = 87
      Height = 24
      Anchors = [akTop, akRight]
      BiDiMode = bdRightToLeft
      Caption = 'Chiudi'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFF000084FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000084FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF0000FF0000FF000084FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000840000FF000084FFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000084FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFF0000840000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000
        84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000840000FF00
        0084FFFFFFFFFFFF0000840000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFF0000840000FF0000840000FF0000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
        00FF0000840000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFF0000FF0000840000FF000084000084FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000840000FF00
        0084FFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF0000FF0000840000FF000084FFFFFFFFFFFFFFFFFFFFFFFF0000840000
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000840000FF0000840000FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF0000840000FFFFFFFFFFFFFFFFFFFFFFFFFF
        0000FF000084FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF0000840000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      ParentBiDiMode = False
      OnClick = btnAnnullaClick
    end
  end
  object PopupMenu: TPopupMenu
    Left = 224
    Top = 32
    object inseriscipattuglia1: TMenuItem
      Action = actInsPattuglia
    end
    object Giustificativi1: TMenuItem
      Action = actOpenA004
    end
    object actOpenA139VAss1: TMenuItem
      Action = actOpenA139VAss
    end
  end
  object ActionList1: TActionList
    Left = 252
    Top = 32
    object actInsPattuglia: TAction
      Caption = 'Inserisci in pattuglia'
      Hint = 'Inserisci in pattuglia'
      OnExecute = actInsPattugliaExecute
    end
    object actOpenA004: TAction
      Caption = 'Giustificativi'
      Hint = 'Giustificativi'
      OnExecute = actOpenA004Execute
    end
    object actOpenA139VAss: TAction
      Caption = 'Valida assenze'
      Hint = 'Valida assenze'
      OnExecute = actOpenA139VAssExecute
    end
  end
end
