object A033FStampaAnomalieQR: TA033FStampaAnomalieQR
  Left = 77
  Top = 101
  Caption = 'A033FStampaAnomalieQR'
  ClientHeight = 573
  ClientWidth = 937
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
    Left = 8
    Top = 0
    Width = 794
    Height = 1123
    ShowingPreview = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    Functions.Strings = (
      'PAGENUMBER'
      'COLUMNNUMBER'
      'REPORTTITLE'
      'QRLOOPBAND1')
    Functions.DATA = (
      '0'
      '0'
      #39#39
      '0')
    Options = [FirstPageHeader, LastPageFooter]
    Page.Columns = 1
    Page.Orientation = poPortrait
    Page.PaperSize = A4
    Page.Continuous = False
    Page.Values = (
      100.000000000000000000
      2970.000000000000000000
      100.000000000000000000
      2100.000000000000000000
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
    PreviewDefaultSaveType = stQRP
    PreviewLeft = 0
    PreviewTop = 0
    object qrbIntestazione: TQRBand
      Left = 38
      Top = 38
      Width = 718
      Height = 43
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      LinkBand = cdbIntestazioneRagg
      Size.Values = (
        113.770833333333300000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbPageHeader
      object QRSysData1: TQRSysData
        Left = 0
        Top = 0
        Width = 89
        Height = 17
        Size.Values = (
          44.979166666666670000
          0.000000000000000000
          0.000000000000000000
          235.479166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        Data = qrsDateTime
        Text = ''
        Transparent = False
        ExportAs = exptText
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRSysData2: TQRSysData
        Left = 661
        Top = 8
        Width = 57
        Height = 17
        Size.Values = (
          44.979166666666670000
          1748.895833333334000000
          21.166666666666670000
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
      object QRLabel1: TQRLabel
        Left = 298
        Top = 4
        Width = 121
        Height = 17
        Size.Values = (
          44.979166666666670000
          788.458333333333400000
          10.583333333333330000
          320.145833333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = True
        Caption = 'ELENCO ANOMALIE'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel2: TQRLabel
        Left = 330
        Top = 24
        Width = 57
        Height = 17
        Size.Values = (
          44.979166666666670000
          873.124999999999900000
          63.500000000000000000
          150.812500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = True
        Caption = 'dal  al'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
    end
    object cdbIntestazioneRagg: TQRChildBand
      Left = 38
      Top = 81
      Width = 718
      Height = 21
      AlignToBottom = False
      BeforePrint = cdbIntestazioneRaggBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      LinkBand = cdbIntestazioneDipendente
      Size.Values = (
        55.562500000000000000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      ParentBand = qrbIntestazione
      PrintOrder = cboAfterParent
      object LRaggInt: TQRLabel
        Left = 2
        Top = 1
        Width = 145
        Height = 17
        Size.Values = (
          44.979166666666670000
          5.291666666666667000
          2.645833333333333000
          383.645833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'DescRagg'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRDBText4: TQRDBText
        Left = 153
        Top = 1
        Width = 127
        Height = 18
        Size.Values = (
          47.625000000000000000
          404.812500000000000000
          2.645833333333333000
          336.020833333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataField = 'Raggruppamento'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 11
      end
    end
    object cdbIntestazioneDipendente: TQRChildBand
      Left = 38
      Top = 102
      Width = 718
      Height = 25
      AlignToBottom = False
      BeforePrint = cdbIntestazioneDipendenteBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        66.145833333333340000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      ParentBand = cdbIntestazioneRagg
      PrintOrder = cboAfterParent
      object QRShape2: TQRShape
        Left = 1
        Top = 3
        Width = 718
        Height = 1
        Size.Values = (
          2.645833333333333000
          2.645833333333333000
          7.937500000000000000
          1899.708333333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Pen.Color = clWindowText
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel5: TQRLabel
        Left = 4
        Top = 6
        Width = 49
        Height = 17
        Size.Values = (
          44.979166666666670000
          10.583333333333330000
          15.875000000000000000
          129.645833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Badge:'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
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
      object QRDBText5: TQRDBText
        Left = 60
        Top = 6
        Width = 81
        Height = 17
        Size.Values = (
          44.979166666666670000
          158.750000000000000000
          15.875000000000000000
          214.312500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'BADGE'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRDBText6: TQRDBText
        Left = 152
        Top = 6
        Width = 33
        Height = 17
        Size.Values = (
          44.979166666666670000
          402.166666666666700000
          15.875000000000000000
          87.312500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataField = 'NOME'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
      end
    end
    object qrbDettaglio: TQRBand
      Left = 38
      Top = 173
      Width = 718
      Height = 21
      AlignToBottom = False
      BeforePrint = qrbDettaglioBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      LinkBand = qrgDipendente
      Size.Values = (
        55.562500000000000000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbDetail
      object QRDBText3: TQRDBText
        Left = 4
        Top = 1
        Width = 65
        Height = 17
        Size.Values = (
          44.979166666666670000
          10.583333333333330000
          2.645833333333333000
          171.979166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        AutoStretch = True
        Color = clWhite
        DataField = 'Anomalia'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
      end
    end
    object qrgRaggruppamento: TQRGroup
      Left = 38
      Top = 127
      Width = 718
      Height = 21
      AfterPrint = qrgRaggruppamentoAfterPrint
      AlignToBottom = False
      BeforePrint = qrgRaggruppamentoBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        55.562500000000000000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Expression = 'TStampa.Raggruppamento'
      Master = QRep
      ReprintOnNewPage = False
      object LRagg: TQRLabel
        Left = 4
        Top = 2
        Width = 145
        Height = 17
        Size.Values = (
          44.979166666666670000
          10.583333333333330000
          5.291666666666667000
          383.645833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'DescRagg'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object ERagg: TQRDBText
        Left = 153
        Top = 1
        Width = 127
        Height = 18
        Size.Values = (
          47.625000000000000000
          404.812500000000000000
          2.645833333333333000
          336.020833333333400000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataField = 'Raggruppamento'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 11
      end
    end
    object qrgDipendente: TQRGroup
      Left = 38
      Top = 148
      Width = 718
      Height = 25
      AlignToBottom = False
      BeforePrint = qrgDipendenteBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      LinkBand = qrgRaggruppamento
      Size.Values = (
        66.145833333333340000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Expression = 'PROGRESSIVO'
      Master = QRep
      ReprintOnNewPage = False
      object QRShape3: TQRShape
        Left = 1
        Top = 3
        Width = 718
        Height = 1
        Size.Values = (
          2.645833333333333000
          2.645833333333333000
          7.937500000000000000
          1899.708333333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRLabel3: TQRLabel
        Left = 4
        Top = 6
        Width = 49
        Height = 17
        Size.Values = (
          44.979166666666670000
          10.583333333333330000
          15.875000000000000000
          129.645833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Badge:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRDBText1: TQRDBText
        Left = 60
        Top = 6
        Width = 81
        Height = 17
        Size.Values = (
          44.979166666666670000
          158.750000000000000000
          15.875000000000000000
          214.312500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'BADGE'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRDBText2: TQRDBText
        Left = 155
        Top = 4
        Width = 33
        Height = 17
        Size.Values = (
          44.979166666666670000
          410.104166666666700000
          10.583333333333330000
          87.312500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataField = 'NOME'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
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
    TextEncoding = AnsiEncoding
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
    TextEncoding = AnsiEncoding
    Left = 560
  end
  object QRExcelFilter1: TQRExcelFilter
    TextEncoding = DefaultEncoding
    UseXLColumns = False
    Left = 632
  end
end
