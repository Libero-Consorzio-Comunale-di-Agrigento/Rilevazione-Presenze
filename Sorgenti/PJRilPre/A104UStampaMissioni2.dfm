object A104FStampaMissioni2: TA104FStampaMissioni2
  Left = 0
  Top = 0
  Width = 794
  Height = 1123
  ShowingPreview = False
  BeforePrint = QuickRepBeforePrint
  DataSet = A104FStampaMissioniDtM1.TabellaStampa
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
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
  PrintIfEmpty = True
  SnapToGrid = True
  Units = MM
  Zoom = 100
  PrevFormStyle = fsNormal
  PreviewInitialState = wsMaximized
  PreviewWidth = 500
  PreviewHeight = 500
  PrevInitialZoom = qrZoomToFit
  PreviewDefaultSaveType = stPDF
  PreviewLeft = 0
  PreviewTop = 0
  object QRBand3: TQRBand
    Left = 38
    Top = 38
    Width = 718
    Height = 57
    AlignToBottom = False
    BeforePrint = QRBand3BeforePrint
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      150.812500000000000000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbTitle
    object QRSysData1: TQRSysData
      Left = 8
      Top = 1
      Width = 31
      Height = 17
      Size.Values = (
        44.979166666666670000
        21.166666666666670000
        2.645833333333333000
        82.020833333333340000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Color = clWhite
      Data = qrsDate
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Text = ''
      Transparent = False
      ExportAs = exptText
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRSysData2: TQRSysData
      Left = 637
      Top = 1
      Width = 74
      Height = 17
      Size.Values = (
        44.979166666666670000
        1685.395833333333000000
        2.645833333333333000
        195.791666666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taRightJustify
      AlignToBand = False
      Color = clWhite
      Data = qrsPageNumber
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Text = 'Pagina '
      Transparent = False
      ExportAs = exptText
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLblAzienda: TQRLabel
      Left = 325
      Top = 10
      Width = 68
      Height = 17
      Size.Values = (
        44.979166666666670000
        859.895833333333400000
        26.458333333333330000
        179.916666666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taCenter
      AlignToBand = True
      Caption = 'MONDOEDP'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 9
    end
    object QRLblTitolo: TQRLabel
      Left = 248
      Top = 25
      Width = 221
      Height = 17
      Size.Values = (
        44.979166666666670000
        656.166666666666800000
        66.145833333333340000
        584.729166666666800000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taCenter
      AlignToBand = True
      Caption = 'RIEPILOGO LIQUIDAZIONI MENSILI'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 10
    end
    object QRLblCompetenza: TQRLabel
      Left = 277
      Top = 40
      Width = 164
      Height = 17
      Size.Values = (
        44.979166666666670000
        732.895833333333200000
        105.833333333333300000
        433.916666666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taCenter
      AlignToBand = True
      Caption = 'Mese/Anno cassa: 11/2001'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 10
    end
  end
  object QRGroup4: TQRGroup
    Left = 38
    Top = 95
    Width = 718
    Height = 2
    AlignToBottom = False
    BeforePrint = QRGroup4BeforePrint
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = True
    Size.Values = (
      5.291666666666667000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    Expression = 'TabellaStampa.MESESCARICO'
    Master = Owner
    ReprintOnNewPage = False
  end
  object QRGroup1: TQRGroup
    Left = 38
    Top = 97
    Width = 718
    Height = 30
    AlignToBottom = False
    BeforePrint = QRGroup1BeforePrint
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      79.375000000000000000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    Expression = 'TabellaStampa.PROGRESSIVO'
    Master = Owner
    ReprintOnNewPage = False
    object QRShape1: TQRShape
      Left = 3
      Top = 4
      Width = 710
      Height = 23
      Size.Values = (
        60.854166666666680000
        7.937500000000000000
        10.583333333333330000
        1878.541666666667000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Shape = qrsRectangle
      VertAdjust = 0
    end
    object QrLblDipendente: TQRLabel
      Left = 9
      Top = 7
      Width = 109
      Height = 17
      Size.Values = (
        44.979166666666670000
        23.812500000000000000
        18.520833333333330000
        288.395833333333400000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'QrLblDipendente'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 10
    end
  end
  object QRGroup2: TQRGroup
    Left = 38
    Top = 127
    Width = 718
    Height = 145
    AfterPrint = QRGroup2AfterPrint
    AlignToBottom = False
    BeforePrint = QRGroup2BeforePrint
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      383.645833333333400000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    Expression = 
      'TabellaStampa.PROGRESSIVO +TabellaStampa.MESESCARICO + TabellaSt' +
      'ampa.MESECOMPETENZA + TabellaStampa.DATADA + TabellaStampa.ORADA'
    Master = Owner
    ReprintOnNewPage = False
    object QRDBText14: TQRDBText
      Left = 83
      Top = 4
      Width = 70
      Height = 17
      Size.Values = (
        44.979166666666670000
        219.604166666666700000
        10.583333333333330000
        185.208333333333300000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.TabellaStampa
      DataField = 'DATADA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLabel12: TQRLabel
      Left = 8
      Top = 4
      Width = 59
      Height = 17
      Size.Values = (
        44.979166666666670000
        21.166666666666670000
        10.583333333333330000
        156.104166666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Data inizio:'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLabel13: TQRLabel
      Left = 29
      Top = 17
      Width = 38
      Height = 17
      Size.Values = (
        44.979166666666670000
        76.729166666666680000
        44.979166666666670000
        100.541666666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Da ora:'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLabel14: TQRLabel
      Left = 170
      Top = 5
      Width = 51
      Height = 17
      Size.Values = (
        44.979166666666670000
        449.791666666666700000
        13.229166666666670000
        134.937500000000000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Data fine:'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRDBText15: TQRDBText
      Left = 235
      Top = 5
      Width = 70
      Height = 17
      Size.Values = (
        44.979166666666670000
        621.770833333333200000
        13.229166666666670000
        185.208333333333300000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.TabellaStampa
      DataField = 'DATAA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRDBText16: TQRDBText
      Left = 83
      Top = 17
      Width = 70
      Height = 17
      Size.Values = (
        44.979166666666670000
        219.604166666666700000
        44.979166666666670000
        185.208333333333300000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.TabellaStampa
      DataField = 'ORADA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLabel15: TQRLabel
      Left = 188
      Top = 18
      Width = 33
      Height = 17
      Size.Values = (
        44.979166666666670000
        497.416666666666700000
        47.625000000000000000
        87.312500000000000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'A ora:'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRDBText17: TQRDBText
      Left = 235
      Top = 18
      Width = 70
      Height = 17
      Size.Values = (
        44.979166666666670000
        621.770833333333200000
        47.625000000000000000
        185.208333333333300000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.TabellaStampa
      DataField = 'ORAA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLabel16: TQRLabel
      Left = 8
      Top = 38
      Width = 17
      Height = 15
      Size.Values = (
        39.687500000000000000
        21.166666666666670000
        100.541666666666700000
        44.979166666666670000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Da:'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRDBText18: TQRDBText
      Left = 32
      Top = 38
      Width = 56
      Height = 15
      Size.Values = (
        39.687500000000000000
        84.666666666666680000
        100.541666666666700000
        148.166666666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.TabellaStampa
      DataField = 'PARTENZA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRDBText19: TQRDBText
      Left = 32
      Top = 52
      Width = 74
      Height = 15
      Size.Values = (
        39.687500000000000000
        84.666666666666680000
        137.583333333333300000
        195.791666666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.TabellaStampa
      DataField = 'DESTINAZIONE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLabel17: TQRLabel
      Left = 16
      Top = 52
      Width = 12
      Height = 15
      Size.Values = (
        39.687500000000000000
        42.333333333333340000
        137.583333333333300000
        31.750000000000000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'A:'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLabel18: TQRLabel
      Left = 338
      Top = 5
      Width = 73
      Height = 17
      Size.Values = (
        44.979166666666670000
        894.291666666666800000
        13.229166666666670000
        193.145833333333300000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Totale giorni:'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRDBText20: TQRDBText
      Left = 427
      Top = 5
      Width = 70
      Height = 17
      Size.Values = (
        44.979166666666670000
        1129.770833333333000000
        13.229166666666670000
        185.208333333333300000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.TabellaStampa
      DataField = 'TOTALEGG'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLabel19: TQRLabel
      Left = 351
      Top = 18
      Width = 60
      Height = 17
      Size.Values = (
        44.979166666666670000
        928.687500000000000000
        47.625000000000000000
        158.750000000000000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Totale ore:'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRDBText21: TQRDBText
      Left = 427
      Top = 18
      Width = 70
      Height = 17
      Size.Values = (
        44.979166666666670000
        1129.770833333333000000
        47.625000000000000000
        185.208333333333300000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.TabellaStampa
      DataField = 'DURATA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLblIndennitaDiTrasferta: TQRLabel
      Left = 8
      Top = 69
      Width = 151
      Height = 15
      Size.Values = (
        39.687500000000000000
        21.166666666666670000
        182.562500000000000000
        399.520833333333400000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Indennit'#224' di trasferta intera'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QrLblImportoTrasferta: TQRLabel
      Left = 600
      Top = 69
      Width = 104
      Height = 15
      Size.Values = (
        39.687500000000000000
        1587.500000000000000000
        182.562500000000000000
        275.166666666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Caption = 'QrLblImportoTrasfertaIntera'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRShape3: TQRShape
      Left = 9
      Top = 127
      Width = 697
      Height = 1
      Size.Values = (
        2.645833333333333000
        23.812500000000000000
        336.020833333333300000
        1844.145833333333000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Pen.Style = psDot
      Shape = qrsHorLine
      VertAdjust = 0
    end
    object QRShape8: TQRShape
      Left = 3
      Top = 1
      Width = 710
      Height = 1
      Size.Values = (
        2.645833333333333000
        7.937500000000000000
        2.645833333333333000
        1878.541666666667000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Shape = qrsHorLine
      VertAdjust = 0
    end
    object QRShape9: TQRShape
      Left = 3
      Top = 2
      Width = 1
      Height = 106
      Size.Values = (
        280.458333333333300000
        7.937500000000000000
        5.291666666666667000
        2.645833333333333000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRDBText4: TQRDBText
      Left = 552
      Top = 69
      Width = 40
      Height = 15
      Size.Values = (
        39.687500000000000000
        1460.500000000000000000
        182.562500000000000000
        105.833333333333300000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.TabellaStampa
      DataField = 'ABBREVIAZIONE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRShape17: TQRShape
      Left = 712
      Top = 2
      Width = 1
      Height = 104
      Size.Values = (
        275.166666666666700000
        1883.833333333333000000
        5.291666666666667000
        2.645833333333333000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRLabel1: TQRLabel
      Left = 8
      Top = 82
      Width = 303
      Height = 15
      Size.Values = (
        39.687500000000000000
        21.166666666666670000
        216.958333333333400000
        801.687500000000000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Indennit'#224' al supero delle ore massime/rimborso pasto'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLabel2: TQRLabel
      Left = 8
      Top = 95
      Width = 272
      Height = 15
      Size.Values = (
        39.687500000000000000
        21.166666666666670000
        251.354166666666700000
        719.666666666666800000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Indennit'#224' al supero massimo dei giorni nel mese'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLabel3: TQRLabel
      Left = 8
      Top = 109
      Width = 229
      Height = 15
      Size.Values = (
        39.687500000000000000
        21.166666666666670000
        288.395833333333400000
        605.895833333333400000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Indennit'#224' al supero massimo ore e giorni'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLabel4: TQRLabel
      Left = 160
      Top = 69
      Width = 393
      Height = 15
      Size.Values = (
        39.687500000000000000
        423.333333333333300000
        182.562500000000000000
        1039.812500000000000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Caption = 
        '................................................................' +
        '................................................................' +
        '....'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLabel5: TQRLabel
      Left = 312
      Top = 82
      Width = 241
      Height = 15
      Size.Values = (
        39.687500000000000000
        825.500000000000000000
        216.958333333333300000
        637.645833333333200000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Caption = 
        '................................................................' +
        '................................................................' +
        '....'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLabel6: TQRLabel
      Left = 281
      Top = 95
      Width = 272
      Height = 15
      Size.Values = (
        39.687500000000000000
        743.479166666666800000
        251.354166666666700000
        719.666666666666800000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Caption = 
        '................................................................' +
        '................................................................' +
        '....'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLabel7: TQRLabel
      Left = 238
      Top = 109
      Width = 315
      Height = 15
      Size.Values = (
        39.687500000000000000
        629.708333333333200000
        288.395833333333300000
        833.437500000000000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Caption = 
        '................................................................' +
        '................................................................' +
        '....'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRDBText1: TQRDBText
      Left = 552
      Top = 82
      Width = 40
      Height = 15
      Size.Values = (
        39.687500000000000000
        1460.500000000000000000
        216.958333333333300000
        105.833333333333300000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.TabellaStampa
      DataField = 'ABBREVIAZIONE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLabel8: TQRLabel
      Left = 600
      Top = 82
      Width = 104
      Height = 15
      Size.Values = (
        39.687500000000000000
        1587.500000000000000000
        216.958333333333300000
        275.166666666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Caption = 'QrLblImportoTrasfertaSupHH'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRDBText2: TQRDBText
      Left = 552
      Top = 95
      Width = 40
      Height = 15
      Size.Values = (
        39.687500000000000000
        1460.500000000000000000
        251.354166666666700000
        105.833333333333300000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.TabellaStampa
      DataField = 'ABBREVIAZIONE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLabel9: TQRLabel
      Left = 600
      Top = 95
      Width = 104
      Height = 15
      Size.Values = (
        39.687500000000000000
        1587.500000000000000000
        251.354166666666700000
        275.166666666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Caption = 'QrLblImportoTrasfertaSupGG'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRDBText3: TQRDBText
      Left = 552
      Top = 108
      Width = 40
      Height = 15
      Size.Values = (
        39.687500000000000000
        1460.500000000000000000
        285.750000000000000000
        105.833333333333300000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.TabellaStampa
      DataField = 'ABBREVIAZIONE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLabel10: TQRLabel
      Left = 600
      Top = 108
      Width = 104
      Height = 15
      Size.Values = (
        39.687500000000000000
        1587.500000000000000000
        285.750000000000000000
        275.166666666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Caption = 'QrLblImportoTrasfertaHHGG'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLabel21: TQRLabel
      Left = 8
      Top = 129
      Width = 131
      Height = 15
      Size.Values = (
        39.687500000000000000
        21.166666666666670000
        341.312500000000000000
        346.604166666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Indennit'#224' chilometriche'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
  end
  object QRSubDetail1: TQRSubDetail
    Left = 38
    Top = 272
    Width = 718
    Height = 15
    AlignToBottom = False
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      39.687500000000000000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    Master = Owner
    DataSet = A104FStampaMissioniDtM1.SelM052
    PrintBefore = False
    PrintIfEmpty = True
    object QRDBText5: TQRDBText
      Left = 25
      Top = 0
      Width = 48
      Height = 15
      Size.Values = (
        39.687500000000000000
        66.145833333333320000
        0.000000000000000000
        127.000000000000000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.SelM050
      DataField = 'CODICERIMBORSOSPESE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRDBText12: TQRDBText
      Left = 80
      Top = 0
      Width = 458
      Height = 15
      Size.Values = (
        39.687500000000000000
        211.666666666666700000
        0.000000000000000000
        1211.791666666667000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.SelM050
      DataField = 'DESCRIZIONE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRDBText6: TQRDBText
      Left = 552
      Top = 0
      Width = 40
      Height = 15
      Size.Values = (
        39.687500000000000000
        1460.500000000000000000
        0.000000000000000000
        105.833333333333300000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.TabellaStampa
      DataField = 'ABBREVIAZIONE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRDBText13: TQRDBText
      Left = 600
      Top = 0
      Width = 105
      Height = 15
      Size.Values = (
        39.687500000000000000
        1587.500000000000000000
        0.000000000000000000
        277.812500000000000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.SelM050
      DataField = 'IMPORTORIMBORSOSPESE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      VerticalAlignment = tlTop
      FontSize = 8
    end
  end
  object QRSubDetail2: TQRSubDetail
    Left = 38
    Top = 302
    Width = 718
    Height = 16
    AlignToBottom = False
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      42.333333333333340000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    Master = Owner
    DataSet = A104FStampaMissioniDtM1.SelM050
    FooterBand = GroupFooterBand1
    PrintBefore = False
    PrintIfEmpty = True
    object QRDBText7: TQRDBText
      Left = 25
      Top = 0
      Width = 48
      Height = 15
      Size.Values = (
        39.687500000000000000
        66.145833333333320000
        0.000000000000000000
        127.000000000000000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.SelM052
      DataField = 'CODICEINDENNITAKM'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRDBText8: TQRDBText
      Left = 80
      Top = 0
      Width = 458
      Height = 15
      Size.Values = (
        39.687500000000000000
        211.666666666666700000
        0.000000000000000000
        1211.791666666667000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.SelM052
      DataField = 'DESCRIZIONE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRDBText9: TQRDBText
      Left = 552
      Top = 0
      Width = 40
      Height = 15
      Size.Values = (
        39.687500000000000000
        1460.500000000000000000
        0.000000000000000000
        105.833333333333300000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.TabellaStampa
      DataField = 'ABBREVIAZIONE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRDBText10: TQRDBText
      Left = 600
      Top = 0
      Width = 105
      Height = 15
      Size.Values = (
        39.687500000000000000
        1587.500000000000000000
        0.000000000000000000
        277.812500000000000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.SelM052
      DataField = 'IMPORTOINDENNITA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      VerticalAlignment = tlTop
      FontSize = 8
    end
  end
  object ChildBand1: TQRChildBand
    Left = 38
    Top = 287
    Width = 718
    Height = 15
    AlignToBottom = False
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      39.687500000000000000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    ParentBand = QRSubDetail1
    PrintOrder = cboAfterParent
    object QRLabel11: TQRLabel
      Left = 8
      Top = 0
      Width = 51
      Height = 15
      Size.Values = (
        39.687500000000000000
        21.166666666666670000
        0.000000000000000000
        134.937500000000000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Rimborsi'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
  end
  object QRBand1: TQRBand
    Left = 38
    Top = 334
    Width = 718
    Height = 50
    AlignToBottom = False
    BeforePrint = QRBand1BeforePrint
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    LinkBand = QRBand2
    Size.Values = (
      132.291666666666700000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbGroupFooter
    object QRLabel22: TQRLabel
      Left = 453
      Top = 6
      Width = 86
      Height = 15
      Size.Values = (
        39.687500000000000000
        1198.562500000000000000
        15.875000000000000000
        227.541666666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Totale rimborsi'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRShape2: TQRShape
      Left = 600
      Top = 4
      Width = 104
      Height = 1
      Size.Values = (
        2.645833333333333000
        1587.500000000000000000
        10.583333333333330000
        275.166666666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Shape = qrsHorLine
      VertAdjust = 0
    end
    object QRLabel23: TQRLabel
      Left = 504
      Top = 25
      Width = 35
      Height = 15
      Size.Values = (
        39.687500000000000000
        1333.500000000000000000
        66.145833333333340000
        92.604166666666680000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Totale'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLblTotaleRimborsi: TQRLabel
      Left = 600
      Top = 6
      Width = 104
      Height = 15
      Size.Values = (
        39.687500000000000000
        1587.500000000000000000
        15.875000000000000000
        275.166666666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Caption = 'QRLblTotaleRimborsi'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLblTotale: TQRLabel
      Left = 600
      Top = 25
      Width = 104
      Height = 15
      Size.Values = (
        39.687500000000000000
        1587.500000000000000000
        66.145833333333320000
        275.166666666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Caption = 'QRLblTotale'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRShape5: TQRShape
      Left = 600
      Top = 39
      Width = 104
      Height = 1
      Size.Values = (
        2.645833333333333000
        1587.500000000000000000
        103.187500000000000000
        275.166666666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Shape = qrsHorLine
      VertAdjust = 0
    end
    object QRShape6: TQRShape
      Left = 600
      Top = 41
      Width = 104
      Height = 1
      Size.Values = (
        2.645833333333333000
        1587.500000000000000000
        108.479166666666700000
        275.166666666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Shape = qrsHorLine
      VertAdjust = 0
    end
    object QRShape7: TQRShape
      Left = 3
      Top = 47
      Width = 710
      Height = 1
      Size.Values = (
        2.645833333333333000
        7.937500000000000000
        124.354166666666700000
        1878.541666666667000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Shape = qrsHorLine
      VertAdjust = 0
    end
    object QRShape4: TQRShape
      Left = 8
      Top = 22
      Width = 697
      Height = 1
      Size.Values = (
        2.645833333333333000
        21.166666666666670000
        58.208333333333320000
        1844.145833333333000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Pen.Style = psDot
      Shape = qrsHorLine
      VertAdjust = 0
    end
    object QRShape12: TQRShape
      Left = 3
      Top = -3
      Width = 1
      Height = 50
      Size.Values = (
        132.291666666666700000
        7.937500000000000000
        -7.937500000000000000
        2.645833333333333000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape14: TQRShape
      Left = 712
      Top = -13
      Width = 1
      Height = 61
      Size.Values = (
        161.395833333333300000
        1883.833333333333000000
        -34.395833333333330000
        2.645833333333333000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRDBText23: TQRDBText
      Left = 552
      Top = 6
      Width = 40
      Height = 15
      Size.Values = (
        39.687500000000000000
        1460.500000000000000000
        15.875000000000000000
        105.833333333333300000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.TabellaStampa
      DataField = 'ABBREVIAZIONE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRDBText24: TQRDBText
      Left = 552
      Top = 25
      Width = 40
      Height = 15
      Size.Values = (
        39.687500000000000000
        1460.500000000000000000
        66.145833333333320000
        105.833333333333300000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.TabellaStampa
      DataField = 'ABBREVIAZIONE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      VerticalAlignment = tlTop
      FontSize = 8
    end
  end
  object QRBand2: TQRBand
    Left = 38
    Top = 384
    Width = 718
    Height = 29
    AlignToBottom = False
    BeforePrint = QRBand2BeforePrint
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      76.729166666666680000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbGroupFooter
    object QRShape21: TQRShape
      Left = 3
      Top = 4
      Width = 710
      Height = 21
      Size.Values = (
        55.562500000000000000
        7.937500000000000000
        10.583333333333330000
        1878.541666666667000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Shape = qrsRectangle
      VertAdjust = 0
    end
    object QRLabel24: TQRLabel
      Left = 452
      Top = 8
      Width = 87
      Height = 15
      Size.Values = (
        39.687500000000000000
        1195.916666666667000000
        21.166666666666670000
        230.187500000000000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Totale generale'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLblTotaleGenerale: TQRLabel
      Left = 600
      Top = 8
      Width = 104
      Height = 15
      Size.Values = (
        39.687500000000000000
        1587.500000000000000000
        21.166666666666670000
        275.166666666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Caption = 'QRLblTotaleGenerale'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRDBText25: TQRDBText
      Left = 552
      Top = 8
      Width = 40
      Height = 15
      Size.Values = (
        39.687500000000000000
        1460.500000000000000000
        21.166666666666670000
        105.833333333333300000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.TabellaStampa
      DataField = 'ABBREVIAZIONE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      VerticalAlignment = tlTop
      FontSize = 8
    end
  end
  object GroupFooterBand1: TQRBand
    Left = 38
    Top = 318
    Width = 718
    Height = 16
    AlignToBottom = False
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      42.333333333333340000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbGroupFooter
    object QRLabel20: TQRLabel
      Left = 112
      Top = 0
      Width = 118
      Height = 15
      Size.Values = (
        39.687500000000000000
        296.333333333333400000
        0.000000000000000000
        312.208333333333400000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Indennit'#224' supplementare'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRDBText22: TQRDBText
      Left = 552
      Top = 0
      Width = 40
      Height = 15
      Size.Values = (
        39.687500000000000000
        1460.500000000000000000
        0.000000000000000000
        105.833333333333300000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.TabellaStampa
      DataField = 'ABBREVIAZIONE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRDBText11: TQRDBText
      Left = 600
      Top = 0
      Width = 105
      Height = 15
      Size.Values = (
        39.687500000000000000
        1587.500000000000000000
        0.000000000000000000
        277.812500000000000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      DataSet = A104FStampaMissioniDtM1.SelM050
      DataField = 'IMPORTOINDENNITASUPPLEMENTARE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      FullJustify = False
      MaxBreakChars = 0
      VerticalAlignment = tlTop
      FontSize = 8
    end
  end
end
