object A059FStampa: TA059FStampa
  Left = 152
  Top = 61
  Caption = 'A059FStampa'
  ClientHeight = 494
  ClientWidth = 1120
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object QRep: TQuickRep
    Left = 0
    Top = 0
    Width = 1123
    Height = 794
    ShowingPreview = False
    DataSet = A059FContSquadreDtM1.selT603
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    Functions.Strings = (
      'PAGENUMBER'
      'COLUMNNUMBER'
      'REPORTTITLE')
    Functions.DATA = (
      '0'
      '0'
      #39#39)
    Options = [FirstPageHeader, LastPageFooter]
    Page.Columns = 1
    Page.Orientation = poLandscape
    Page.PaperSize = A4
    Page.Continuous = False
    Page.Values = (
      100.000000000000000000
      2100.000000000000000000
      100.000000000000000000
      2970.000000000000000000
      100.000000000000000000
      100.000000000000000000
      0.000000000000000000)
    PrinterSettings.Copies = 1
    PrinterSettings.OutputBin = Auto
    PrinterSettings.Duplex = False
    PrinterSettings.FirstPage = 0
    PrinterSettings.LastPage = 0
    PrinterSettings.UseStandardprinter = False
    PrinterSettings.UseCustomBinCode = False
    PrinterSettings.CustomBinCode = 0
    PrinterSettings.ExtendedDuplex = 0
    PrinterSettings.UseCustomPaperCode = False
    PrinterSettings.CustomPaperCode = 0
    PrinterSettings.PrintMetaFile = False
    PrinterSettings.MemoryLimit = 1000000
    PrinterSettings.PrintQuality = 0
    PrinterSettings.Collate = 0
    PrinterSettings.ColorOption = 0
    PrintIfEmpty = False
    SnapToGrid = True
    Units = MM
    Zoom = 100
    PrevFormStyle = fsNormal
    PreviewInitialState = wsMaximized
    PreviewWidth = 500
    PreviewHeight = 500
    PrevShowThumbs = False
    PrevShowSearch = False
    PrevInitialZoom = qrZoomOther
    PreviewDefaultSaveType = stPDF
    PreviewLeft = 0
    PreviewTop = 0
    object DetailBand1: TQRBand
      Left = 38
      Top = 156
      Width = 1047
      Height = 24
      Frame.DrawTop = True
      AlignToBottom = False
      BeforePrint = DetailBand1BeforePrint
      TransparentBand = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      ForceNewColumn = False
      ForceNewPage = False
      ParentFont = False
      Size.Values = (
        63.500000000000000000
        2770.187500000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbDetail
      object QRLabel18: TQRLabel
        Left = 0
        Top = 4
        Width = 57
        Height = 17
        Size.Values = (
          44.979166666666670000
          0.000000000000000000
          10.583333333333330000
          150.812500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = True
        Caption = 'Squadra:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRSquadra: TQRDBText
        Left = 68
        Top = 4
        Width = 81
        Height = 17
        Size.Values = (
          44.979166666666670000
          179.916666666666700000
          10.583333333333330000
          214.312500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = True
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = A059FContSquadreDtM1.selT603
        DataField = 'CODICE'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRDSquadra: TQRDBText
        Left = 155
        Top = 4
        Width = 78
        Height = 17
        Size.Values = (
          44.979166666666670000
          410.104166666666700000
          10.583333333333330000
          206.375000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = True
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataSet = A059FContSquadreDtM1.selT603
        DataField = 'DESCRIZIONE'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
    end
    object ColumnHeaderBand1: TQRBand
      Left = 38
      Top = 113
      Width = 1047
      Height = 43
      Frame.DrawTop = True
      AlignToBottom = False
      TransparentBand = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ForceNewColumn = False
      ForceNewPage = False
      ParentFont = False
      Size.Values = (
        113.770833333333300000
        2770.187500000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbColumnHeader
      object QRLabel6: TQRLabel
        Left = 188
        Top = 24
        Width = 26
        Height = 17
        Size.Values = (
          44.979166666666670000
          497.416666666666700000
          63.500000000000000000
          68.791666666666680000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Min'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLabel7: TQRLabel
        Left = 220
        Top = 24
        Width = 26
        Height = 17
        Size.Values = (
          44.979166666666670000
          582.083333333333200000
          63.500000000000000000
          68.791666666666680000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Max'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLabel1: TQRLabel
        Left = 201
        Top = 8
        Width = 45
        Height = 17
        Size.Values = (
          44.979166666666670000
          531.812500000000000000
          21.166666666666670000
          119.062500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = '(Mese)'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRGiorni: TQRRichText
        Left = 252
        Top = 24
        Width = 53
        Height = 17
        Size.Values = (
          44.979166666666670000
          666.750000000000000000
          63.500000000000000000
          140.229166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AutoStretch = False
        Color = clWindow
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        HiresExport = False
        Transparent = False
        YIncrement = 50
        Lines.Strings = (
          '01 02 '
          '03 04 '
          '05 06 '
          '07 08 '
          '09 10 '
          '01 02 '
          '03 04 '
          '05 06 '
          '07 08 '
          '09 10 '
          '01 02 '
          '03 04 '
          '05 06 '
          '07 08 '
          '09 10')
        ParentRichEdit = REGiorni
      end
      object REGiorni: TRichEdit
        Left = 318
        Top = 24
        Width = 185
        Height = 18
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        Lines.Strings = (
          
            '01 02 03 04 05 06 07 08 09 10 01 02 03 04 05 06 07 08 09 10 01 0' +
            '2 03 04 05 06 07 08 09 10')
        ParentFont = False
        TabOrder = 4
        WordWrap = False
        Zoom = 100
      end
      object QRMesi: TQRRichText
        Left = 252
        Top = 8
        Width = 53
        Height = 17
        Size.Values = (
          44.979166666666670000
          666.750000000000000000
          21.166666666666670000
          140.229166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AutoStretch = False
        Color = clWindow
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        HiresExport = False
        Transparent = False
        YIncrement = 50
        Lines.Strings = (
          '11')
        ParentRichEdit = REMesi
      end
      object REMesi: TRichEdit
        Left = 318
        Top = 6
        Width = 185
        Height = 18
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        Lines.Strings = (
          '11')
        ParentFont = False
        TabOrder = 6
        WordWrap = False
        Zoom = 100
      end
    end
    object PageHeaderBand1: TQRBand
      Left = 38
      Top = 38
      Width = 1047
      Height = 75
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        198.437500000000000000
        2770.187500000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbPageHeader
      object QRSysData1: TQRSysData
        Left = 0
        Top = 0
        Width = 49
        Height = 17
        Size.Values = (
          44.979166666666670000
          0.000000000000000000
          0.000000000000000000
          129.645833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = True
        Color = clWhite
        Data = qrsDate
        Text = ''
        Transparent = False
        ExportAs = exptText
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRSysData2: TQRSysData
        Left = 990
        Top = 0
        Width = 57
        Height = 17
        Size.Values = (
          44.979166666666670000
          2619.375000000000000000
          0.000000000000000000
          150.812500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taRightJustify
        AlignToBand = True
        Color = clWhite
        Data = qrsPageNumber
        Text = ''
        Transparent = False
        ExportAs = exptText
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRTitolo: TQRLabel
        Left = 419
        Top = 4
        Width = 209
        Height = 17
        Size.Values = (
          44.979166666666670000
          1108.604166666667000000
          10.583333333333330000
          552.979166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = True
        Caption = 'Riepilogo squadre turnisti'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRRange: TQRLabel
        Left = 419
        Top = 24
        Width = 209
        Height = 17
        Size.Values = (
          44.979166666666670000
          1108.604166666667000000
          63.500000000000000000
          552.979166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = True
        Caption = 'dalla squadra alla squadra'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRData: TQRLabel
        Left = 499
        Top = 44
        Width = 49
        Height = 17
        Size.Values = (
          44.979166666666670000
          1320.270833333333000000
          116.416666666666700000
          129.645833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = True
        Caption = 'dal al'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
    end
    object QRSubDetail1: TQRSubDetail
      Left = 38
      Top = 180
      Width = 1047
      Height = 77
      Frame.Style = psDashDot
      AlignToBottom = False
      BeforePrint = QRSubDetail1BeforePrint
      TransparentBand = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ForceNewColumn = False
      ForceNewPage = False
      ParentFont = False
      Size.Values = (
        203.729166666666700000
        2770.187500000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Master = QRep
      DataSet = A059FContSquadreDtM1.selT606
      FooterBand = QRBand1
      PrintBefore = False
      PrintIfEmpty = False
      object QRLabel19: TQRLabel
        Left = 12
        Top = 6
        Width = 71
        Height = 17
        Size.Values = (
          44.979166666666670000
          31.750000000000000000
          15.875000000000000000
          187.854166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Operatore:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QROperatore: TQRDBText
        Left = 88
        Top = 6
        Width = 78
        Height = 17
        Size.Values = (
          44.979166666666670000
          232.833333333333400000
          15.875000000000000000
          206.375000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = True
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = A059FContSquadreDtM1.selT606
        DataField = 'COD_TIPOOPE'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRDBText1: TQRDBText
        Left = 188
        Top = 6
        Width = 26
        Height = 17
        Size.Values = (
          44.979166666666670000
          497.416666666666700000
          15.875000000000000000
          68.791666666666680000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = True
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = A059FContSquadreDtM1.selT606
        DataField = 'MIN1'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRDBText2: TQRDBText
        Left = 220
        Top = 6
        Width = 26
        Height = 17
        Size.Values = (
          44.979166666666670000
          582.083333333333200000
          15.875000000000000000
          68.791666666666680000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = True
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = A059FContSquadreDtM1.selT606
        DataField = 'MAX1'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRDBText4: TQRDBText
        Left = 188
        Top = 22
        Width = 26
        Height = 17
        Size.Values = (
          44.979166666666670000
          497.416666666666700000
          58.208333333333320000
          68.791666666666680000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = True
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = A059FContSquadreDtM1.selT606
        DataField = 'MIN2'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRDBText5: TQRDBText
        Left = 220
        Top = 22
        Width = 26
        Height = 17
        Size.Values = (
          44.979166666666670000
          582.083333333333200000
          58.208333333333320000
          68.791666666666680000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = True
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = A059FContSquadreDtM1.selT606
        DataField = 'MAX2'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRDBText7: TQRDBText
        Left = 188
        Top = 38
        Width = 26
        Height = 17
        Size.Values = (
          44.979166666666670000
          497.416666666666700000
          100.541666666666700000
          68.791666666666680000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = True
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = A059FContSquadreDtM1.selT606
        DataField = 'MIN3'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRDBText8: TQRDBText
        Left = 220
        Top = 38
        Width = 26
        Height = 17
        Size.Values = (
          44.979166666666670000
          582.083333333333200000
          100.541666666666700000
          68.791666666666680000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = True
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = A059FContSquadreDtM1.selT606
        DataField = 'MAX3'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRDBText10: TQRDBText
        Left = 188
        Top = 54
        Width = 26
        Height = 17
        Size.Values = (
          44.979166666666670000
          497.416666666666700000
          142.875000000000000000
          68.791666666666680000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = True
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = A059FContSquadreDtM1.selT606
        DataField = 'MIN4'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRDBText11: TQRDBText
        Left = 220
        Top = 54
        Width = 26
        Height = 17
        Size.Values = (
          44.979166666666670000
          582.083333333333200000
          142.875000000000000000
          68.791666666666680000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = True
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = A059FContSquadreDtM1.selT606
        DataField = 'MAX4'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLabel2: TQRLabel
        Left = 132
        Top = 6
        Width = 50
        Height = 17
        Size.Values = (
          44.979166666666670000
          349.250000000000000000
          15.875000000000000000
          132.291666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = '1'#176'Turno'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLabel3: TQRLabel
        Left = 132
        Top = 22
        Width = 50
        Height = 17
        Size.Values = (
          44.979166666666670000
          349.250000000000000000
          58.208333333333330000
          132.291666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = '2'#176'Turno'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLabel4: TQRLabel
        Left = 132
        Top = 38
        Width = 50
        Height = 17
        Size.Values = (
          44.979166666666670000
          349.250000000000000000
          100.541666666666700000
          132.291666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = '3'#176'Turno'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLabel5: TQRLabel
        Left = 132
        Top = 54
        Width = 50
        Height = 17
        Size.Values = (
          44.979166666666670000
          349.250000000000000000
          142.875000000000000000
          132.291666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = '4'#176'Turno'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRTurno1: TQRRichText
        Left = 256
        Top = 6
        Width = 53
        Height = 17
        Size.Values = (
          44.979166666666670000
          677.333333333333200000
          15.875000000000000000
          140.229166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AutoStretch = False
        Color = clWindow
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        HiresExport = False
        Transparent = False
        YIncrement = 50
        Lines.Strings = (
          'zd.gbn'
          'sdk.jg'
          'nbsk'#242'b'
          'fgsdkj'
          'fbdas'#242
          'fjbg'#242'd'
          'jbf'#242'da'
          'bzfd'#242'o'
          'jbfzkb'
          'fb<n'
          '<znfb'
          '<nf<z'
          'nbdf'#224
          '<zbfdn'
          '<bk'
          '<djkd.'
          '<bf'
          '<dbf'
          '<kdbfb'
          'f d<d'
          '<bd'#224'bf'
          '<d'#242
          '<dfb'
          '<dbd<'
          'd<'#224'fb'
          '<d'#242'idv'
          #242'<i'
          '<d'#242'if')
        ParentRichEdit = RichEdit1
      end
      object QRTurno2: TQRRichText
        Left = 256
        Top = 22
        Width = 53
        Height = 17
        Size.Values = (
          44.979166666666670000
          677.333333333333200000
          58.208333333333320000
          140.229166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AutoStretch = False
        Color = clWindow
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        HiresExport = False
        Transparent = False
        YIncrement = 50
        Lines.Strings = (
          'RichEd'
          'it')
        ParentRichEdit = RichEdit2
      end
      object QRTurno3: TQRRichText
        Left = 256
        Top = 38
        Width = 53
        Height = 17
        Size.Values = (
          44.979166666666670000
          677.333333333333200000
          100.541666666666700000
          140.229166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AutoStretch = False
        Color = clWindow
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        HiresExport = False
        Transparent = False
        YIncrement = 50
        Lines.Strings = (
          'RichEd'
          'it')
        ParentRichEdit = RichEdit3
      end
      object QRTurno4: TQRRichText
        Left = 256
        Top = 54
        Width = 53
        Height = 17
        Size.Values = (
          44.979166666666670000
          677.333333333333200000
          142.875000000000000000
          140.229166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AutoStretch = False
        Color = clWindow
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        HiresExport = False
        Transparent = False
        YIncrement = 50
        Lines.Strings = (
          'RichEd'
          'it')
        ParentRichEdit = RichEdit4
      end
      object RichEdit2: TRichEdit
        Left = 318
        Top = 17
        Width = 185
        Height = 20
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        Lines.Strings = (
          'RichEdit')
        ParentFont = False
        TabOrder = 18
        WordWrap = False
        Zoom = 100
      end
      object RichEdit3: TRichEdit
        Left = 318
        Top = 33
        Width = 185
        Height = 20
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        Lines.Strings = (
          'RichEdit')
        ParentFont = False
        TabOrder = 19
        WordWrap = False
        Zoom = 100
      end
      object RichEdit4: TRichEdit
        Left = 318
        Top = 49
        Width = 185
        Height = 20
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        Lines.Strings = (
          'RichEdit')
        ParentFont = False
        TabOrder = 20
        WordWrap = False
        Zoom = 100
      end
      object RichEdit1: TRichEdit
        Left = 318
        Top = 3
        Width = 185
        Height = 18
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        Lines.Strings = (
          
            'zd.gbnsdk.jgnbsk'#242'bfgsdkjfbdas'#242'fjbg'#242'djbf'#242'dabzfd'#242'ojbfzkbfb<n<znfb<' +
            'nf<z'
          'nbdf'#224'<zbfdn<bk<djkd.<bf<dbf<kdbfbf d<d<bd'#224'bf<d'#242'<dfb<dbd<'
          'd<'#224'fb<d'#242'idv'#242'<i<d'#242'if')
        ParentFont = False
        TabOrder = 21
        WordWrap = False
        Zoom = 100
      end
    end
    object QRBand1: TQRBand
      Left = 38
      Top = 257
      Width = 1047
      Height = 72
      Frame.DrawTop = True
      AlignToBottom = False
      BeforePrint = QRBand1BeforePrint
      TransparentBand = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ForceNewColumn = False
      ForceNewPage = False
      ParentFont = False
      Size.Values = (
        190.500000000000000000
        2770.187500000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbGroupFooter
      object QRDBText13: TQRDBText
        Left = 188
        Top = 4
        Width = 26
        Height = 17
        Size.Values = (
          44.979166666666670000
          497.416666666666700000
          10.583333333333330000
          68.791666666666680000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = True
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = A059FContSquadreDtM1.selT603
        DataField = 'TOTMIN1'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRDBText14: TQRDBText
        Left = 220
        Top = 4
        Width = 26
        Height = 17
        Size.Values = (
          44.979166666666670000
          582.083333333333200000
          10.583333333333330000
          68.791666666666680000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = True
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = A059FContSquadreDtM1.selT603
        DataField = 'TOTMAX1'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRDBText16: TQRDBText
        Left = 188
        Top = 20
        Width = 26
        Height = 17
        Size.Values = (
          44.979166666666670000
          497.416666666666700000
          52.916666666666670000
          68.791666666666680000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = True
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = A059FContSquadreDtM1.selT603
        DataField = 'TOTMIN2'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRDBText17: TQRDBText
        Left = 220
        Top = 20
        Width = 26
        Height = 17
        Size.Values = (
          44.979166666666670000
          582.083333333333200000
          52.916666666666670000
          68.791666666666680000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = True
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = A059FContSquadreDtM1.selT603
        DataField = 'TOTMAX2'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRDBText19: TQRDBText
        Left = 188
        Top = 36
        Width = 26
        Height = 17
        Size.Values = (
          44.979166666666670000
          497.416666666666700000
          95.250000000000000000
          68.791666666666680000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = True
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = A059FContSquadreDtM1.selT603
        DataField = 'TOTMIN3'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRDBText20: TQRDBText
        Left = 220
        Top = 36
        Width = 26
        Height = 17
        Size.Values = (
          44.979166666666670000
          582.083333333333200000
          95.250000000000000000
          68.791666666666680000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = True
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = A059FContSquadreDtM1.selT603
        DataField = 'TOTMAX3'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRDBText22: TQRDBText
        Left = 188
        Top = 52
        Width = 26
        Height = 17
        Size.Values = (
          44.979166666666670000
          497.416666666666700000
          137.583333333333300000
          68.791666666666680000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = True
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = A059FContSquadreDtM1.selT603
        DataField = 'TOTMIN4'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRDBText23: TQRDBText
        Left = 220
        Top = 52
        Width = 26
        Height = 17
        Size.Values = (
          44.979166666666670000
          582.083333333333200000
          137.583333333333300000
          68.791666666666680000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = True
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = A059FContSquadreDtM1.selT603
        DataField = 'TOTMAX4'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRSquadra1: TQRRichText
        Left = 256
        Top = 4
        Width = 53
        Height = 17
        Size.Values = (
          44.979166666666670000
          677.333333333333200000
          10.583333333333330000
          140.229166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AutoStretch = False
        Color = clWindow
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        HiresExport = False
        Transparent = False
        YIncrement = 50
        Lines.Strings = (
          'RichEd'
          'it1')
        ParentRichEdit = RE1
      end
      object QRSquadra2: TQRRichText
        Left = 256
        Top = 20
        Width = 53
        Height = 17
        Size.Values = (
          44.979166666666670000
          677.333333333333200000
          52.916666666666670000
          140.229166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AutoStretch = False
        Color = clWindow
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        HiresExport = False
        Transparent = False
        YIncrement = 50
        Lines.Strings = (
          'RichEd'
          'it')
        ParentRichEdit = RE2
      end
      object QRSquadra3: TQRRichText
        Left = 256
        Top = 36
        Width = 53
        Height = 17
        Size.Values = (
          44.979166666666670000
          677.333333333333200000
          95.250000000000000000
          140.229166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AutoStretch = False
        Color = clWindow
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        HiresExport = False
        Transparent = False
        YIncrement = 50
        Lines.Strings = (
          'RichEd'
          'it')
        ParentRichEdit = RE3
      end
      object QRSquadra4: TQRRichText
        Left = 256
        Top = 52
        Width = 53
        Height = 17
        Size.Values = (
          44.979166666666670000
          677.333333333333200000
          137.583333333333300000
          140.229166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AutoStretch = False
        Color = clWindow
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        HiresExport = False
        Transparent = False
        YIncrement = 50
        Lines.Strings = (
          'RichEd'
          'it')
        ParentRichEdit = RE4
      end
      object RE1: TRichEdit
        Left = 318
        Top = 2
        Width = 185
        Height = 23
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        Lines.Strings = (
          'RichEdit1')
        ParentFont = False
        TabOrder = 12
        WordWrap = False
        Zoom = 100
      end
      object RE2: TRichEdit
        Left = 318
        Top = 20
        Width = 185
        Height = 17
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        Lines.Strings = (
          'RichEdit')
        ParentFont = False
        TabOrder = 13
        WordWrap = False
        Zoom = 100
      end
      object RE3: TRichEdit
        Left = 318
        Top = 36
        Width = 185
        Height = 17
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        Lines.Strings = (
          'RichEdit')
        ParentFont = False
        TabOrder = 14
        WordWrap = False
        Zoom = 100
      end
      object RE4: TRichEdit
        Left = 318
        Top = 52
        Width = 185
        Height = 17
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        Lines.Strings = (
          'RichEdit')
        ParentFont = False
        TabOrder = 15
        WordWrap = False
        Zoom = 100
      end
    end
  end
  object QRTextFilter1: TQRTextFilter
    TextEncoding = DefaultEncoding
    Left = 344
  end
  object QRRTFFilter1: TQRRTFFilter
    TextEncoding = DefaultEncoding
    Left = 416
  end
  object QRPDFFilter1: TQRPDFFilter
    CompressionOn = True
    Fonthandling = False
    TextEncoding = UTF8Encoding
    Codepage = '1252'
    SuppressDateTime = False
    Left = 488
  end
  object QRHTMLFilter1: TQRHTMLFilter
    MultiPage = False
    PageLinks = False
    FinalPage = 0
    FirstLastLinks = False
    Concat = False
    ConcatCount = 1
    LinkFontSize = 12
    LinkFontName = 'Arial'
    TextEncoding = ASCIIEncoding
    Left = 560
  end
  object QRExcelFilter1: TQRExcelFilter
    TextEncoding = DefaultEncoding
    UseXLColumns = False
    Left = 632
  end
end
