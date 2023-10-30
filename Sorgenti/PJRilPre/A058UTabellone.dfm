object A058FTabellone: TA058FTabellone
  Left = 265
  Top = 233
  Caption = 'A058FTabellone'
  ClientHeight = 612
  ClientWidth = 1002
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object QRep: TQuickRep
    Left = 0
    Top = 0
    Width = 1123
    Height = 794
    ShowingPreview = False
    BeforePrint = QRepBeforePrint
    DataSet = A058FPianifTurniDtM1.T058Stampa
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'Courier New'
    Font.Style = []
    Functions.Strings = (
      'PAGENUMBER'
      'COLUMNNUMBER'
      'REPORTTITLE'
      'QRSTRINGSBAND1'
      'QRLOOPBAND1')
    Functions.DATA = (
      '0'
      '0'
      #39#39
      #39#39
      '0')
    Options = [FirstPageHeader, LastPageFooter, Compression]
    Page.Columns = 1
    Page.Orientation = poLandscape
    Page.PaperSize = A4
    Page.Continuous = False
    Page.Values = (
      100.000000000000000000
      2100.000000000000000000
      100.000000000000000000
      2970.000000000000000000
      50.000000000000000000
      50.000000000000000000
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
    PrevFormStyle = fsMDIForm
    PreviewInitialState = wsMaximized
    PreviewWidth = 500
    PreviewHeight = 500
    PrevShowThumbs = False
    PrevShowSearch = False
    PrevInitialZoom = qrZoomOther
    PreviewDefaultSaveType = stPDF
    PreviewLeft = 0
    PreviewTop = 0
    object bndTitolo: TQRBand
      Left = 19
      Top = 38
      Width = 1085
      Height = 54
      Frame.DrawBottom = True
      AlignToBottom = False
      BeforePrint = bndTitoloBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        142.875000000000000000
        2870.729166666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbPageHeader
      object QRSysData1: TQRSysData
        Left = 0
        Top = 0
        Width = 31
        Height = 17
        Size.Values = (
          44.979166666666670000
          0.000000000000000000
          0.000000000000000000
          82.020833333333330000)
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
        FontSize = 7
      end
      object QRSysData2: TQRSysData
        Left = 1049
        Top = 0
        Width = 36
        Height = 17
        Size.Values = (
          44.979166666666670000
          2775.479166666667000000
          0.000000000000000000
          95.250000000000000000)
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
        FontSize = 7
      end
      object QRTitolo: TQRLabel
        Left = 467
        Top = 2
        Width = 151
        Height = 20
        Size.Values = (
          52.916666666666670000
          1235.604166666667000000
          5.291666666666667000
          399.520833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = True
        Caption = 'Tabellone turni'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 12
      end
      object QRData: TQRLabel
        Left = 494
        Top = 33
        Width = 97
        Height = 18
        Size.Values = (
          47.625000000000000000
          1307.041666666667000000
          87.312500000000000000
          256.645833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = True
        Caption = 'dal // al //'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = [fsItalic]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLblSituazione: TQRLabel
        Left = 450
        Top = 18
        Width = 185
        Height = 17
        Size.Values = (
          44.979166666666670000
          1190.625000000000000000
          47.625000000000000000
          489.479166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = True
        Caption = '(situazione consuntiva)'
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
    end
    object bndSquadra: TQRBand
      Left = 19
      Top = 92
      Width = 1085
      Height = 24
      Frame.DrawBottom = True
      AlignToBottom = False
      TransparentBand = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -7
      Font.Name = 'Courier New'
      Font.Style = []
      ForceNewColumn = False
      ForceNewPage = False
      ParentFont = False
      Size.Values = (
        63.500000000000000000
        2870.729166666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbColumnHeader
      object QRSquadra: TQRDBText
        Left = 2
        Top = 3
        Width = 112
        Height = 17
        Size.Values = (
          44.979166666666670000
          5.291666666666667000
          7.937500000000000000
          296.333333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = True
        Color = clWhite
        DataSet = A058FPianifTurniDtM1.T058Stampa
        DataField = 'Squadra'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRDSquadra: TQRDBText
        Left = 120
        Top = 3
        Width = 65
        Height = 17
        Size.Values = (
          44.979166666666670000
          317.500000000000000000
          7.937500000000000000
          171.979166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataSet = A058FPianifTurniDtM1.T058Stampa
        DataField = 'DSquadra'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
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
    object bndGruppo: TQRGroup
      Left = 19
      Top = 143
      Width = 1085
      Height = 15
      AlignToBottom = False
      BeforePrint = bndGruppoBeforePrint
      TransparentBand = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Courier New'
      Font.Style = []
      ForceNewColumn = False
      ForceNewPage = True
      ParentFont = False
      Size.Values = (
        39.687500000000000000
        2870.729166666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Expression = 'T058Stampa.Squadra + T058Stampa.Datainizio'
      FooterBand = bndTotLiquidabile
      Master = QRep
      ReprintOnNewPage = False
    end
    object bndDettaglio: TQRBand
      Left = 19
      Top = 158
      Width = 1085
      Height = 33
      AfterPrint = bndDettaglioAfterPrint
      AlignToBottom = False
      BeforePrint = bndDettaglioBeforePrint
      TransparentBand = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -7
      Font.Name = 'Courier New'
      Font.Style = []
      ForceNewColumn = False
      ForceNewPage = False
      ParentFont = False
      Size.Values = (
        87.312500000000000000
        2870.729166666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbDetail
      object QRMatricola: TQRDBText
        Left = 0
        Top = 1
        Width = 37
        Height = 14
        Size.Values = (
          37.041666666666670000
          0.000000000000000000
          2.645833333333333000
          97.895833333333320000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = A058FPianifTurniDtM1.T058Stampa
        DataField = 'Matricola'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 5
      end
      object QRNome: TQRDBText
        Left = 0
        Top = 16
        Width = 108
        Height = 14
        Size.Values = (
          37.041666666666670000
          0.000000000000000000
          42.333333333333330000
          285.750000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = A058FPianifTurniDtM1.T058Stampa
        DataField = 'Nome'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 5
      end
      object QROp: TQRDBText
        Left = 120
        Top = 1
        Width = 17
        Height = 17
        Size.Values = (
          44.979166666666670000
          317.500000000000000000
          2.645833333333333000
          44.979166666666670000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = A058FPianifTurniDtM1.T058Stampa
        DataField = 'Operatore'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakAnywhere
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 5
      end
      object QrLblDebito: TQRLabel
        Left = 194
        Top = 1
        Width = 25
        Height = 9
        Size.Values = (
          23.812500000000000000
          513.291666666666700000
          2.645833333333333000
          66.145833333333330000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'XXX.XX'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 5
      end
      object QRLblAssegnato: TQRLabel
        Left = 194
        Top = 9
        Width = 25
        Height = 9
        Size.Values = (
          23.812500000000000000
          513.291666666666700000
          23.812500000000000000
          66.145833333333330000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'XXX.XX'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 5
      end
      object QRLblScostamento: TQRLabel
        Left = 194
        Top = 17
        Width = 25
        Height = 9
        Size.Values = (
          23.812500000000000000
          513.291666666666700000
          44.979166666666670000
          66.145833333333330000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'XXX.XX'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 5
      end
      object QrLblTotTurno1: TQRLabel
        Left = 264
        Top = 1
        Width = 25
        Height = 9
        Size.Values = (
          23.812500000000000000
          698.500000000000000000
          2.645833333333333000
          66.145833333333340000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Totale'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 5
      end
      object QrLblTotTurno2: TQRLabel
        Left = 264
        Top = 9
        Width = 25
        Height = 9
        Size.Values = (
          23.812500000000000000
          698.500000000000000000
          23.812500000000000000
          66.145833333333340000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Totale'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 5
      end
    end
    object bndTotLiquidabile: TQRBand
      Left = 19
      Top = 191
      Width = 1085
      Height = 22
      Frame.DrawTop = True
      AlignToBottom = False
      BeforePrint = bndTotLiquidabileBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        58.208333333333330000
        2870.729166666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbGroupFooter
      object qlblTotLiquid: TQRLabel
        Left = 2
        Top = 4
        Width = 116
        Height = 13
        Size.Values = (
          34.395833333333330000
          5.291666666666667000
          10.583333333333330000
          306.916666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Tot. liquidabile: 00.00'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
    end
    object bndAssenze: TQRChildBand
      Left = 19
      Top = 282
      Width = 1085
      Height = 16
      Frame.DrawTop = True
      AlignToBottom = False
      BeforePrint = bndAssenzeBeforePrint
      TransparentBand = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Courier New'
      Font.Style = []
      ForceNewColumn = False
      ForceNewPage = False
      ParentFont = False
      Size.Values = (
        42.333333333333330000
        2870.729166666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      ParentBand = bndOrari
      PrintOrder = cboAfterParent
      object QRMAssenze: TQRMemo
        Left = 45
        Top = 1
        Width = 36
        Height = 13
        Size.Values = (
          34.395833333333330000
          119.062500000000000000
          2.645833333333333000
          95.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        AutoStretch = True
        Color = clWhite
        Lines.Strings = (
          'Assenze')
        Transparent = False
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 7
      end
      object QRLAssenze: TQRLabel
        Left = 2
        Top = 1
        Width = 41
        Height = 13
        Size.Values = (
          34.395833333333330000
          5.291666666666667000
          2.645833333333333000
          108.479166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Assenze:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
    end
    object bndOrari: TQRChildBand
      Left = 19
      Top = 266
      Width = 1085
      Height = 16
      Frame.DrawTop = True
      AlignToBottom = False
      BeforePrint = bndOrariBeforePrint
      TransparentBand = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Courier New'
      Font.Style = []
      ForceNewColumn = False
      ForceNewPage = False
      ParentFont = False
      Size.Values = (
        42.333333333333330000
        2870.729166666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      ParentBand = bndTotGenerali
      PrintOrder = cboAfterParent
      object QRLOrari: TQRLabel
        Left = 2
        Top = 1
        Width = 31
        Height = 13
        Size.Values = (
          34.395833333333330000
          5.291666666666667000
          2.645833333333333000
          82.020833333333330000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Orari:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object QRMOrari: TQRMemo
        Left = 45
        Top = 1
        Width = 26
        Height = 13
        Size.Values = (
          34.395833333333330000
          119.062500000000000000
          2.645833333333333000
          68.791666666666670000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        AutoStretch = True
        Color = clWhite
        Lines.Strings = (
          'Orari')
        Transparent = False
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 7
      end
      object QRLblTemp: TQRLabel
        Left = 120
        Top = 0
        Width = 46
        Height = 13
        Size.Values = (
          34.395833333333330000
          317.500000000000000000
          0.000000000000000000
          121.708333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'QRLblTemp'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
    end
    object bndFirme: TQRChildBand
      Left = 19
      Top = 298
      Width = 1085
      Height = 52
      Frame.DrawTop = True
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        137.583333333333300000
        2870.729166666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      ParentBand = bndAssenze
      PrintOrder = cboAfterParent
      object QRNota: TQRLabel
        Left = 2
        Top = 10
        Width = 461
        Height = 17
        Size.Values = (
          44.979166666666670000
          5.291666666666667000
          26.458333333333330000
          1219.729166666667000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 
          'NOTA: Ogni richiesta di variazione al presente turno dovr'#224' esser' +
          'e trasmessa a questo ufficio'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object QRDesc1: TQRLabel
        Left = 52
        Top = 30
        Width = 116
        Height = 17
        Size.Values = (
          44.979166666666670000
          137.583333333333300000
          79.375000000000000000
          306.916666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'L'#39'UFFICIO DEL PERSONALE'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object QRDesc2: TQRLabel
        Left = 487
        Top = 30
        Width = 111
        Height = 17
        Size.Values = (
          44.979166666666670000
          1288.520833333333000000
          79.375000000000000000
          293.687500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = True
        Caption = 'IL DIRETTORE SANITARIO'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
    end
    object bndTotTurni: TQRChildBand
      Left = 19
      Top = 234
      Width = 1085
      Height = 16
      Frame.DrawTop = True
      AlignToBottom = False
      BeforePrint = bndTotTurniBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        42.333333333333330000
        2870.729166666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      ParentBand = bndTotOrario
      PrintOrder = cboAfterParent
      object QRLTurniTotali: TQRLabel
        Left = 2
        Top = 1
        Width = 26
        Height = 13
        Size.Values = (
          34.395833333333330000
          5.291666666666667000
          2.645833333333333000
          68.791666666666670000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Turni'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object QRLMinMax: TQRLabel
        Left = 103
        Top = 1
        Width = 26
        Height = 13
        Size.Values = (
          34.395833333333330000
          272.520833333333300000
          2.645833333333333000
          68.791666666666670000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'mn-MX'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object QRLTotaliTurno: TQRLabel
        Left = 70
        Top = 1
        Width = 21
        Height = 13
        Size.Values = (
          34.395833333333330000
          185.208333333333300000
          2.645833333333333000
          55.562500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Tot.'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
    end
    object bndGiorni: TQRChildBand
      Left = 19
      Top = 116
      Width = 1085
      Height = 27
      Frame.DrawBottom = True
      AlignToBottom = False
      BeforePrint = bndGiorniBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        71.437500000000000000
        2870.729166666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      ParentBand = bndSquadra
      PrintOrder = cboAfterParent
      object QRLMatricola: TQRLabel
        Left = 16
        Top = 1
        Width = 46
        Height = 13
        Size.Values = (
          34.395833333333330000
          42.333333333333330000
          2.645833333333333000
          121.708333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Matricola'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object QRLNome: TQRLabel
        Left = 16
        Top = 11
        Width = 51
        Height = 13
        Size.Values = (
          34.395833333333330000
          42.333333333333330000
          29.104166666666670000
          134.937500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Nominativo'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object QRLOp: TQRLabel
        Left = 120
        Top = 1
        Width = 26
        Height = 13
        Size.Values = (
          34.395833333333330000
          317.500000000000000000
          2.645833333333333000
          68.791666666666670000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Oper.'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object LblAssegnato: TQRLabel
        Left = 176
        Top = 9
        Width = 66
        Height = 13
        Size.Values = (
          34.395833333333330000
          465.666666666666700000
          23.812500000000000000
          174.625000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Ore assegnate'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object LblDebito: TQRLabel
        Left = 176
        Top = 1
        Width = 66
        Height = 13
        Size.Values = (
          34.395833333333330000
          465.666666666666700000
          2.645833333333333000
          174.625000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Debito contr.'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object LblScostamento: TQRLabel
        Left = 176
        Top = 17
        Width = 56
        Height = 13
        Size.Values = (
          34.395833333333330000
          465.666666666666700000
          44.979166666666670000
          148.166666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Scostamento'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object QrTotale: TQRLabel
        Left = 264
        Top = 1
        Width = 36
        Height = 13
        Size.Values = (
          34.395833333333330000
          698.500000000000000000
          2.645833333333333000
          95.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Totale '
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object QrTurno: TQRLabel
        Left = 264
        Top = 9
        Width = 26
        Height = 13
        Size.Values = (
          34.395833333333330000
          698.500000000000000000
          23.812500000000000000
          68.791666666666670000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'turni'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object QrLblDatoLibero: TQRLabel
        Left = 889
        Top = 6
        Width = 76
        Height = 13
        Size.Values = (
          34.395833333333330000
          2352.145833333333000000
          15.875000000000000000
          201.083333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'QrLblDatoLibero'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
    end
    object bndTotOrario: TQRChildBand
      Left = 19
      Top = 213
      Width = 1085
      Height = 21
      AlignToBottom = False
      BeforePrint = bndTotOrarioBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        55.562500000000000000
        2870.729166666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      ParentBand = bndTotLiquidabile
      PrintOrder = cboAfterParent
      object QRLTotali: TQRLabel
        Left = 2
        Top = 1
        Width = 91
        Height = 13
        Size.Values = (
          34.395833333333330000
          5.291666666666667000
          2.645833333333333000
          240.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Totali per orario:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object QRMTotali: TQRMemo
        Left = 228
        Top = 1
        Width = 46
        Height = 13
        Size.Values = (
          34.395833333333330000
          603.250000000000000000
          2.645833333333333000
          121.708333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        AutoStretch = True
        Color = clWhite
        Transparent = True
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 7
      end
    end
    object bndTotGenerali: TQRChildBand
      Left = 19
      Top = 250
      Width = 1085
      Height = 16
      Frame.DrawTop = True
      AlignToBottom = False
      BeforePrint = bndTotGeneraliBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        42.333333333333330000
        2870.729166666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      ParentBand = bndTotTurni
      PrintOrder = cboAfterParent
      object qrLblTotGen: TQRLabel
        Left = 2
        Top = 1
        Width = 62
        Height = 13
        Size.Values = (
          34.395833333333330000
          5.291666666666667000
          2.645833333333333000
          164.041666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Caption = 'Tot. turni: '
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
      end
      object QRLTotaliPagina: TQRLabel
        Left = 70
        Top = 1
        Width = 21
        Height = 13
        Size.Values = (
          34.395833333333330000
          185.208333333333300000
          2.645833333333333000
          55.562500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Tot.'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 7
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
