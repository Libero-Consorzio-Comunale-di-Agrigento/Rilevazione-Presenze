object A027StampaTimb: TA027StampaTimb
  Left = 0
  Top = 0
  Width = 794
  Height = 1123
  AfterPrint = QRepAfterPrint
  AfterPreview = QRepAfterPreview
  ShowingPreview = False
  BeforePrint = QRepBeforePrint
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
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
  OnEndPage = QuickRepEndPage
  OnStartPage = QRepStartPage
  Options = [FirstPageHeader, LastPageFooter, Compression]
  Page.Columns = 1
  Page.Orientation = poPortrait
  Page.PaperSize = A4
  Page.Continuous = False
  Page.Values = (
    50.000000000000000000
    2970.000000000000000000
    50.000000000000000000
    2100.000000000000000000
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
  Units = Pixels
  Zoom = 100
  PrevFormStyle = fsNormal
  PreviewInitialState = wsMaximized
  PreviewWidth = 500
  PreviewHeight = 500
  PrevShowThumbs = False
  PrevShowSearch = False
  PrevInitialZoom = qrZoomToWidth
  PreviewDefaultSaveType = stQRP
  PreviewLeft = 0
  PreviewTop = 0
  object QRBDett: TQRBand
    Left = 19
    Top = 153
    Width = 756
    Height = 0
    Frame.Width = 0
    AlignToBottom = False
    BeforePrint = QRBDettBeforePrint
    Color = clBlack
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      0.000000000000000000
      2000.250000000000000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbDetail
  end
  object QRSDet1: TQRSubDetail
    Left = 19
    Top = 267
    Width = 756
    Height = 18
    Frame.Style = psInsideFrame
    AlignToBottom = False
    BeforePrint = QRSDet1BeforePrint
    TransparentBand = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ForceNewColumn = False
    ForceNewPage = False
    ParentFont = False
    Size.Values = (
      47.625000000000000000
      2000.250000000000000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    Master = QRSDet
    FooterBand = TotaliDett
    HeaderBand = QRBInt3
    OnNeedData = QRSDet1NeedData
    PrintBefore = False
    PrintIfEmpty = False
    object RETimb: TRichEdit
      Left = 120
      Top = 0
      Width = 73
      Height = 18
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 0
      Visible = False
      WordWrap = False
      Zoom = 100
    end
    object RTTimb: TQRRichText
      Left = 49
      Top = 1
      Width = 69
      Height = 16
      Enabled = False
      Size.Values = (
        42.333333333333300000
        129.645833333333000000
        2.645833333333330000
        182.562500000000000000)
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
      ParentRichEdit = RETimb
    end
    object ShapeDett: TQRShape
      Left = 0
      Top = 15
      Width = 775
      Height = 1
      Enabled = False
      Size.Values = (
        2.645833333333330000
        0.000000000000000000
        39.687500000000000000
        2050.520833333330000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Shape = qrsHorLine
      VertAdjust = 0
    end
    object QMTimb: TQRMemo
      Tag = 901
      Left = 192
      Top = 1
      Width = 50
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        508.000000000000000000
        2.645833333333330000
        132.291666666667000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Transparent = False
      WordWrap = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
  end
  object QRBInt3: TQRBand
    Left = 19
    Top = 247
    Width = 756
    Height = 20
    AlignToBottom = False
    TransparentBand = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ForceNewColumn = False
    ForceNewPage = False
    ParentFont = False
    Size.Values = (
      52.916666666666670000
      2000.250000000000000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbGroupHeader
    object QRShape2: TQRShape
      Left = 0
      Top = 7
      Width = 775
      Height = 1
      Size.Values = (
        2.645833333333330000
        0.000000000000000000
        18.520833333333300000
        2050.520833333330000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Shape = qrsHorLine
      VertAdjust = 0
    end
  end
  object TotaliDett: TQRBand
    Left = 19
    Top = 303
    Width = 756
    Height = 19
    Frame.DrawTop = True
    AlignToBottom = False
    BeforePrint = TotaliDettBeforePrint
    Enabled = False
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      50.270833333333330000
      2000.250000000000000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbGroupFooter
  end
  object QRSDet: TQRSubDetail
    Left = 19
    Top = 153
    Width = 756
    Height = 54
    AfterPrint = QRSDetAfterPrint
    AlignToBottom = False
    BeforePrint = QRSDetBeforePrint
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      142.875000000000000000
      2000.250000000000000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    Master = Owner
    OnNeedData = QRSDetNeedData
    PrintBefore = False
    PrintIfEmpty = False
    object QRLMese: TQRLabel
      Left = 281
      Top = 36
      Width = 193
      Height = 17
      Size.Values = (
        44.979166666666670000
        743.479166666666700000
        95.250000000000000000
        510.645833333333300000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taCenter
      AlignToBand = True
      Caption = 'RILEVAZIONI DEL MESE DI '
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      OnPrint = QRLMesePrint
      ParentFont = False
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 10
    end
    object QRLNow: TQRLabel
      Left = 0
      Top = 2
      Width = 43
      Height = 15
      Size.Values = (
        39.687500000000000000
        0.000000000000000000
        5.291666666666667000
        113.770833333333300000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = True
      Caption = 'QRLNow'
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object LAzienda: TQRLabel
      Left = 349
      Top = 18
      Width = 57
      Height = 17
      Size.Values = (
        44.979166666666670000
        923.395833333333300000
        47.625000000000000000
        150.812500000000000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taCenter
      AlignToBand = True
      AutoStretch = True
      Caption = 'Azienda'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
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
    object qimgLogo: TQRImage
      Left = 0
      Top = 18
      Width = 51
      Height = 35
      Enabled = False
      Size.Values = (
        92.604166666666680000
        0.000000000000000000
        47.625000000000000000
        134.937500000000000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Stretch = True
    end
  end
  object Riepilogo: TQRChildBand
    Left = 19
    Top = 322
    Width = 756
    Height = 127
    Frame.DrawTop = True
    Frame.DrawBottom = True
    AlignToBottom = False
    BeforePrint = RiepilogoBeforePrint
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      336.020833333333300000
      2000.250000000000000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    ParentBand = TotaliDett
    PrintOrder = cboAfterParent
    object QRLabel11: TQRLabel
      Left = 8
      Top = 2
      Width = 106
      Height = 15
      Size.Values = (
        39.687500000000000000
        21.166666666666670000
        5.291666666666667000
        280.458333333333400000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Deb.Tot.mese = '
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLDebTot: TQRLabel
      Left = 116
      Top = 2
      Width = 162
      Height = 15
      Size.Values = (
        39.687500000000000000
        306.916666666667000000
        5.291666666666670000
        428.625000000000000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Caption = 'QRLDebTot'
      Color = clWhite
      Transparent = False
      WordWrap = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLrese: TQRLabel
      Left = 160
      Top = 15
      Width = 50
      Height = 15
      Size.Values = (
        39.687500000000000000
        423.333333333333300000
        39.687500000000000000
        132.291666666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'QRLrese'
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLabel12: TQRLabel
      Left = 8
      Top = 15
      Width = 148
      Height = 15
      Size.Values = (
        39.687500000000000000
        21.166666666666670000
        39.687500000000000000
        391.583333333333400000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Ore rese (ass/pre) = '
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLabel13: TQRLabel
      Left = 8
      Top = 28
      Width = 127
      Height = 15
      Size.Values = (
        39.687500000000000000
        21.166666666666670000
        74.083333333333340000
        336.020833333333400000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Saldo mese att. = '
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLSaldoMese: TQRLabel
      Left = 136
      Top = 28
      Width = 85
      Height = 15
      Size.Values = (
        39.687500000000000000
        359.833333333333400000
        74.083333333333340000
        224.895833333333300000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'QRLSaldoMese'
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLSaldoAnno: TQRLabel
      Left = 185
      Top = 57
      Width = 85
      Height = 15
      Size.Values = (
        39.687500000000000000
        489.479166666666700000
        150.812500000000000000
        224.895833333333300000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'QRLSaldoAnno'
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLabel14: TQRLabel
      Left = 8
      Top = 57
      Width = 176
      Height = 15
      Size.Values = (
        39.687500000000000000
        21.166666666666670000
        150.812500000000000000
        465.666666666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Saldo anno complessivo = '
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLabel20: TQRLabel
      Left = 8
      Top = 77
      Width = 372
      Height = 15
      Size.Values = (
        39.687500000000000000
        21.166666666666670000
        203.729166666666700000
        984.250000000000000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Eccedenza compens. con assenza - Maturata nel mese = '
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLabel22: TQRLabel
      Left = 8
      Top = 93
      Width = 190
      Height = 15
      Size.Values = (
        39.687500000000000000
        21.166666666666670000
        246.062500000000000000
        502.708333333333400000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Indennit'#224' festive intere = '
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLIdnInt: TQRLabel
      Left = 200
      Top = 93
      Width = 37
      Height = 15
      Size.Values = (
        39.687500000000000000
        529.166666666667000000
        246.062500000000000000
        97.895833333333300000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Caption = 'QRLIdnInt'
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLEccComp: TQRLabel
      Left = 380
      Top = 77
      Width = 45
      Height = 15
      Size.Values = (
        39.687500000000000000
        1005.416666666670000000
        203.729166666667000000
        119.062500000000000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Caption = 'QRLEccComp'
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLabel24: TQRLabel
      Left = 236
      Top = 93
      Width = 197
      Height = 15
      Size.Values = (
        39.687500000000000000
        624.416666666666800000
        246.062500000000000000
        521.229166666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Indennit'#224' festive ridotte = '
      Color = clWhite
      Transparent = False
      WordWrap = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLIdnRid: TQRLabel
      Left = 432
      Top = 93
      Width = 37
      Height = 15
      Size.Values = (
        39.687500000000000000
        1143.000000000000000000
        246.062500000000000000
        97.895833333333300000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Caption = 'QRLIdnRid'
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLabel21: TQRLabel
      Left = 432
      Top = 77
      Width = 148
      Height = 15
      Size.Values = (
        39.687500000000000000
        1143.000000000000000000
        203.729166666666700000
        391.583333333333400000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Maturata nell'#39'anno = '
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLabel25: TQRLabel
      Left = 472
      Top = 93
      Width = 204
      Height = 15
      Size.Values = (
        39.687500000000000000
        1248.833333333333000000
        246.062500000000000000
        539.750000000000000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Indennit'#224' di turno gg./ore = '
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLabel23: TQRLabel
      Left = 628
      Top = 77
      Width = 71
      Height = 15
      Size.Values = (
        39.687500000000000000
        1661.583333333333000000
        203.729166666666700000
        187.854166666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Residua = '
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLMat: TQRLabel
      Left = 580
      Top = 77
      Width = 43
      Height = 15
      Size.Values = (
        39.687500000000000000
        1534.583333333333000000
        203.729166666666700000
        113.770833333333300000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'QRLMat'
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLturno: TQRLabel
      Left = 672
      Top = 93
      Width = 57
      Height = 15
      Size.Values = (
        39.687500000000000000
        1778.000000000000000000
        246.062500000000000000
        150.812500000000000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'QRLturno'
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLResidua: TQRLabel
      Left = 700
      Top = 77
      Width = 71
      Height = 15
      Size.Values = (
        39.687500000000000000
        1852.083333333333000000
        203.729166666666700000
        187.854166666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'QRLResidua'
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLabel19: TQRLabel
      Left = 414
      Top = 62
      Width = 155
      Height = 15
      Size.Values = (
        39.687500000000000000
        1095.375000000000000000
        164.041666666666700000
        410.104166666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Str. liq.to nel mese ='
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLabel18: TQRLabel
      Left = 414
      Top = 47
      Width = 155
      Height = 15
      Size.Values = (
        39.687500000000000000
        1095.375000000000000000
        124.354166666666700000
        410.104166666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Residuo ecc. liq.le  ='
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLabel17: TQRLabel
      Left = 414
      Top = 32
      Width = 155
      Height = 15
      Size.Values = (
        39.687500000000000000
        1095.375000000000000000
        84.666666666666680000
        410.104166666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Str liq.to inizio aa ='
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLabel16: TQRLabel
      Left = 414
      Top = 17
      Width = 162
      Height = 15
      Size.Values = (
        39.687500000000000000
        1095.375000000000000000
        44.979166666666670000
        428.625000000000000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Ecc iniz.anno liq.le = '
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLabel15: TQRLabel
      Left = 414
      Top = 2
      Width = 162
      Height = 15
      Size.Values = (
        39.687500000000000000
        1095.375000000000000000
        5.291666666666667000
        428.625000000000000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Ecc nel mese liq.le  = '
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLEccMese: TQRLabel
      Left = 575
      Top = 2
      Width = 71
      Height = 15
      Size.Values = (
        39.687500000000000000
        1521.354166666667000000
        5.291666666666667000
        187.854166666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'QRLEccMese'
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLEccAnno: TQRLabel
      Left = 575
      Top = 17
      Width = 71
      Height = 15
      Size.Values = (
        39.687500000000000000
        1521.354166666667000000
        44.979166666666670000
        187.854166666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'QRLEccAnno'
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLStrAnno: TQRLabel
      Left = 575
      Top = 32
      Width = 71
      Height = 15
      Size.Values = (
        39.687500000000000000
        1521.354166666667000000
        84.666666666666680000
        187.854166666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'QRLStrAnno'
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLResEcc: TQRLabel
      Left = 575
      Top = 47
      Width = 64
      Height = 15
      Size.Values = (
        39.687500000000000000
        1521.354166666667000000
        124.354166666666700000
        169.333333333333300000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'QRLResEcc'
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLStrMese: TQRLabel
      Left = 575
      Top = 62
      Width = 71
      Height = 15
      Size.Values = (
        39.687500000000000000
        1521.354166666667000000
        164.041666666666700000
        187.854166666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'QRLStrMese'
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLabel2: TQRLabel
      Left = 8
      Top = 110
      Width = 155
      Height = 15
      Size.Values = (
        39.687500000000000000
        21.166666666666670000
        291.041666666666700000
        410.104166666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Indennit'#224' di presenza:'
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLabel3: TQRLabel
      Left = 168
      Top = 110
      Width = 64
      Height = 15
      Size.Values = (
        39.687500000000000000
        444.500000000000000000
        291.041666666666700000
        169.333333333333300000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'QRLIdnInt'
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLSaldoAnnoCorr: TQRLabel
      Left = 129
      Top = 42
      Width = 65
      Height = 15
      Size.Values = (
        39.687500000000000000
        341.312500000000000000
        111.125000000000000000
        171.979166666667000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Caption = 'QRLSaldoAnnoCorr'
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLabel4: TQRLabel
      Left = 8
      Top = 42
      Width = 120
      Height = 15
      Size.Values = (
        39.687500000000000000
        21.166666666666670000
        111.125000000000000000
        317.500000000000000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Saldo anno att.= '
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLSaldoAnnoPrec: TQRLabel
      Left = 324
      Top = 42
      Width = 65
      Height = 15
      Size.Values = (
        39.687500000000000000
        857.250000000000000000
        111.125000000000000000
        171.979166666667000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Caption = 'QRLSaldoAnnoPrec'
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLabel8: TQRLabel
      Left = 196
      Top = 42
      Width = 127
      Height = 15
      Size.Values = (
        39.687500000000000000
        518.583333333333400000
        111.125000000000000000
        336.020833333333400000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Saldo anno prec.= '
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
  end
  object Riepilogo2: TQRChildBand
    Left = 19
    Top = 449
    Width = 756
    Height = 17
    Frame.DrawBottom = True
    AlignToBottom = False
    BeforePrint = Riepilogo2BeforePrint
    Enabled = False
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      44.979166666666670000
      2000.250000000000000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    ParentBand = Riepilogo
    PrintOrder = cboAfterParent
    object QRMemo1: TQRMemo
      Tag = 901
      Left = 8
      Top = 1
      Width = 25
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        21.166666666666670000
        2.645833333333333000
        66.145833333333340000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Transparent = False
      WordWrap = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRMemo2: TQRMemo
      Tag = 902
      Left = 36
      Top = 1
      Width = 25
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        95.250000000000000000
        2.645833333333333000
        66.145833333333340000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Transparent = False
      WordWrap = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRMemo3: TQRMemo
      Tag = 903
      Left = 64
      Top = 1
      Width = 25
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        169.333333333333300000
        2.645833333333333000
        66.145833333333340000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Transparent = False
      WordWrap = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRMemo4: TQRMemo
      Tag = 904
      Left = 92
      Top = 1
      Width = 25
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        243.416666666666700000
        2.645833333333333000
        66.145833333333340000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Transparent = False
      WordWrap = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRMemo5: TQRMemo
      Tag = 905
      Left = 120
      Top = 1
      Width = 25
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        317.500000000000000000
        2.645833333333333000
        66.145833333333340000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Transparent = False
      WordWrap = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRMemo6: TQRMemo
      Tag = 906
      Left = 148
      Top = 1
      Width = 25
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        391.583333333333300000
        2.645833333333333000
        66.145833333333340000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Transparent = False
      WordWrap = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRMemo7: TQRMemo
      Tag = 907
      Left = 176
      Top = 1
      Width = 25
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        465.666666666666700000
        2.645833333333333000
        66.145833333333340000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Transparent = False
      WordWrap = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRMemo11: TQRMemo
      Tag = 908
      Left = 204
      Top = 1
      Width = 25
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        539.750000000000000000
        2.645833333333333000
        66.145833333333340000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Transparent = False
      WordWrap = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRMemo14: TQRMemo
      Tag = 909
      Left = 232
      Top = 1
      Width = 25
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        613.833333333333400000
        2.645833333333333000
        66.145833333333340000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Transparent = False
      WordWrap = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRMemo15: TQRMemo
      Tag = 910
      Left = 260
      Top = 1
      Width = 25
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        687.916666666666600000
        2.645833333333333000
        66.145833333333340000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Transparent = False
      WordWrap = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRMemo18: TQRMemo
      Tag = 911
      Left = 288
      Top = 1
      Width = 25
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        762.000000000000000000
        2.645833333333333000
        66.145833333333340000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Transparent = False
      WordWrap = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRMemo19: TQRMemo
      Tag = 912
      Left = 316
      Top = 1
      Width = 25
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        836.083333333333400000
        2.645833333333333000
        66.145833333333340000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Transparent = False
      WordWrap = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRMemo20: TQRMemo
      Tag = 913
      Left = 344
      Top = 1
      Width = 25
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        910.166666666666600000
        2.645833333333333000
        66.145833333333340000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Transparent = False
      WordWrap = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRMemo33: TQRMemo
      Tag = 914
      Left = 372
      Top = 1
      Width = 25
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        984.250000000000000000
        2.645833333333333000
        66.145833333333340000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Transparent = False
      WordWrap = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRMemo34: TQRMemo
      Tag = 915
      Left = 400
      Top = 1
      Width = 25
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        1058.333333333333000000
        2.645833333333333000
        66.145833333333340000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Transparent = False
      WordWrap = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRMemo39: TQRMemo
      Tag = 916
      Left = 428
      Top = 1
      Width = 25
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        1132.416666666667000000
        2.645833333333333000
        66.145833333333340000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Transparent = False
      WordWrap = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRMemo40: TQRMemo
      Tag = 917
      Left = 457
      Top = 1
      Width = 25
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        1209.145833333333000000
        2.645833333333333000
        66.145833333333320000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Transparent = False
      WordWrap = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRMemo41: TQRMemo
      Tag = 918
      Left = 486
      Top = 1
      Width = 25
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        1285.875000000000000000
        2.645833333333333000
        66.145833333333320000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Transparent = False
      WordWrap = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRMemo42: TQRMemo
      Tag = 919
      Left = 516
      Top = 1
      Width = 25
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        1365.250000000000000000
        2.645833333333333000
        66.145833333333320000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Transparent = False
      WordWrap = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
  end
  object Riepilogo3: TQRChildBand
    Left = 19
    Top = 466
    Width = 756
    Height = 17
    Frame.DrawBottom = True
    AlignToBottom = False
    BeforePrint = Riepilogo3BeforePrint
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      44.979166666666670000
      2000.250000000000000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    ParentBand = Riepilogo2
    PrintOrder = cboAfterParent
    object QRMemo8: TQRMemo
      Tag = 951
      Left = 8
      Top = 1
      Width = 25
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        21.166666666666670000
        2.645833333333333000
        66.145833333333340000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Transparent = False
      WordWrap = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRMemo9: TQRMemo
      Tag = 952
      Left = 37
      Top = 1
      Width = 25
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        97.895833333333340000
        2.645833333333333000
        66.145833333333340000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Transparent = False
      WordWrap = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRMemo10: TQRMemo
      Tag = 953
      Left = 66
      Top = 1
      Width = 25
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        174.625000000000000000
        2.645833333333333000
        66.145833333333340000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Transparent = False
      WordWrap = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRMemo12: TQRMemo
      Tag = 954
      Left = 96
      Top = 1
      Width = 25
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        254.000000000000000000
        2.645833333333333000
        66.145833333333340000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Transparent = False
      WordWrap = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRMemo13: TQRMemo
      Tag = 955
      Left = 126
      Top = 1
      Width = 25
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        333.375000000000000000
        2.645833333333333000
        66.145833333333340000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Transparent = False
      WordWrap = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRMemo16: TQRMemo
      Tag = 956
      Left = 156
      Top = 1
      Width = 25
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        412.750000000000100000
        2.645833333333333000
        66.145833333333340000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Transparent = False
      WordWrap = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRMemo17: TQRMemo
      Tag = 957
      Left = 186
      Top = 1
      Width = 25
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        492.124999999999900000
        2.645833333333333000
        66.145833333333340000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Transparent = False
      WordWrap = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRMemo21: TQRMemo
      Tag = 958
      Left = 216
      Top = 1
      Width = 25
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        571.500000000000000000
        2.645833333333333000
        66.145833333333340000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Transparent = False
      WordWrap = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRMemo22: TQRMemo
      Tag = 959
      Left = 246
      Top = 1
      Width = 25
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        650.875000000000000000
        2.645833333333333000
        66.145833333333340000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Transparent = False
      WordWrap = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRMemo23: TQRMemo
      Tag = 960
      Left = 276
      Top = 1
      Width = 25
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        730.250000000000000000
        2.645833333333333000
        66.145833333333340000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Transparent = False
      WordWrap = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRMemo24: TQRMemo
      Tag = 961
      Left = 306
      Top = 1
      Width = 25
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        809.625000000000000000
        2.645833333333333000
        66.145833333333340000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Transparent = False
      WordWrap = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRMemo25: TQRMemo
      Tag = 962
      Left = 338
      Top = 1
      Width = 25
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        894.291666666666800000
        2.645833333333333000
        66.145833333333340000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Transparent = False
      WordWrap = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRMemo26: TQRMemo
      Tag = 963
      Left = 366
      Top = 1
      Width = 25
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        968.375000000000000000
        2.645833333333333000
        66.145833333333340000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Transparent = False
      WordWrap = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRMemo27: TQRMemo
      Tag = 964
      Left = 396
      Top = 1
      Width = 25
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        1047.750000000000000000
        2.645833333333333000
        66.145833333333340000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Transparent = False
      WordWrap = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRMemo28: TQRMemo
      Tag = 965
      Left = 426
      Top = 1
      Width = 25
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        1127.125000000000000000
        2.645833333333333000
        66.145833333333340000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Transparent = False
      WordWrap = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRMemo29: TQRMemo
      Tag = 966
      Left = 456
      Top = 1
      Width = 25
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        1206.500000000000000000
        2.645833333333333000
        66.145833333333340000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Transparent = False
      WordWrap = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRMemo30: TQRMemo
      Tag = 967
      Left = 486
      Top = 1
      Width = 25
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        1285.875000000000000000
        2.645833333333333000
        66.145833333333340000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Transparent = False
      WordWrap = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRMemo31: TQRMemo
      Tag = 968
      Left = 516
      Top = 1
      Width = 25
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        1365.250000000000000000
        2.645833333333333000
        66.145833333333340000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Transparent = False
      WordWrap = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRMemo32: TQRMemo
      Tag = 969
      Left = 546
      Top = 1
      Width = 25
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        1444.625000000000000000
        2.645833333333333000
        66.145833333333340000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Transparent = False
      WordWrap = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRMemo35: TQRMemo
      Tag = 970
      Left = 572
      Top = 1
      Width = 25
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        1513.416666666667000000
        2.645833333333333000
        66.145833333333340000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Transparent = False
      WordWrap = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRMemo36: TQRMemo
      Tag = 971
      Left = 598
      Top = 1
      Width = 25
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        1582.208333333333000000
        2.645833333333333000
        66.145833333333340000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Transparent = False
      WordWrap = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRMemo37: TQRMemo
      Tag = 972
      Left = 625
      Top = 1
      Width = 25
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        1653.645833333333000000
        2.645833333333333000
        66.145833333333340000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Transparent = False
      WordWrap = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRMemo38: TQRMemo
      Tag = 973
      Left = 651
      Top = 1
      Width = 25
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        1722.437500000000000000
        2.645833333333333000
        66.145833333333340000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Transparent = False
      WordWrap = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
  end
  object Intestazione: TQRChildBand
    Left = 19
    Top = 207
    Width = 756
    Height = 40
    AlignToBottom = False
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      105.833333333333300000
      2000.250000000000000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    ParentBand = QRSDet
    PrintOrder = cboAfterParent
  end
  object Riepilogo4: TQRChildBand
    Left = 19
    Top = 483
    Width = 756
    Height = 17
    AlignToBottom = False
    BeforePrint = Riepilogo4BeforePrint
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      44.979166666666670000
      2000.250000000000000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    ParentBand = Riepilogo3
    PrintOrder = cboAfterParent
  end
  object TotSettimana: TQRChildBand
    Left = 19
    Top = 285
    Width = 756
    Height = 18
    Frame.DrawTop = True
    Frame.DrawBottom = True
    AlignToBottom = False
    BeforePrint = TotSettimanaBeforePrint
    Enabled = False
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      47.625000000000000000
      2000.250000000000000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    ParentBand = QRSDet1
    PrintOrder = cboAfterParent
    object QRLabel1: TQRLabel
      Left = 0
      Top = 2
      Width = 155
      Height = 15
      Size.Values = (
        39.687500000000000000
        0.000000000000000000
        5.291666666666667000
        410.104166666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = True
      Caption = 'Ore rese (ass./pres.):'
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object OreRese: TQRLabel
      Left = 164
      Top = 2
      Width = 36
      Height = 15
      Size.Values = (
        39.687500000000000000
        433.916666666666700000
        5.291666666666667000
        95.250000000000000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = '00.00'
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLabel7: TQRLabel
      Left = 228
      Top = 2
      Width = 134
      Height = 15
      Size.Values = (
        39.687500000000000000
        603.250000000000000000
        5.291666666666667000
        354.541666666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Debito settimanale:'
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object DebitoSet: TQRLabel
      Left = 376
      Top = 2
      Width = 36
      Height = 15
      Size.Values = (
        39.687500000000000000
        994.833333333333400000
        5.291666666666667000
        95.250000000000000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = '00.00'
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object QRLabel10: TQRLabel
      Left = 440
      Top = 2
      Width = 127
      Height = 15
      Size.Values = (
        39.687500000000000000
        1164.166666666667000000
        5.291666666666667000
        336.020833333333400000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Saldo settimanale:'
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object SaldoSet: TQRLabel
      Left = 584
      Top = 2
      Width = 36
      Height = 15
      Size.Values = (
        39.687500000000000000
        1545.166666666667000000
        5.291666666666667000
        95.250000000000000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = '00.00'
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
  end
  object qlblNumPaginaMan: TQRLabel
    Left = 662
    Top = 1
    Width = 113
    Height = 15
    Size.Values = (
      39.687500000000000000
      1751.541666666667000000
      2.645833333333333000
      298.979166666666700000)
    XLColumn = 0
    XLNumFormat = nfGeneral
    ActiveInPreview = False
    Alignment = taRightJustify
    AlignToBand = True
    Caption = 'qlblNumPaginaMan'
    Color = clWhite
    Transparent = False
    ExportAs = exptText
    WrapStyle = BreakOnSpaces
    VerticalAlignment = tlTop
    FontSize = 8
  end
  object qlblNumPaginaAuto: TQRSysData
    Left = 726
    Top = 22
    Width = 50
    Height = 15
    Size.Values = (
      39.687500000000000000
      1920.875000000000000000
      58.208333333333340000
      132.291666666666700000)
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
    FontSize = 8
  end
  object bndGruppoFileSeq: TQRGroup
    Left = 19
    Top = 99
    Width = 756
    Height = 54
    AlignToBottom = False
    BeforePrint = bndGruppoFileSeqBeforePrint
    Enabled = False
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      142.875000000000000000
      2000.250000000000000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    Expression = 'COGNOME'
    Master = Owner
    ReprintOnNewPage = False
    object QRLabel5: TQRLabel
      Left = 112
      Top = 0
      Width = 78
      Height = 15
      Size.Values = (
        39.687500000000000000
        296.333333333333400000
        0.000000000000000000
        206.375000000000000000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'Stampa del '
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object lblStrappoPagina: TQRLabel
      Left = 112
      Top = 16
      Width = 113
      Height = 15
      Enabled = False
      Size.Values = (
        39.687500000000000000
        296.333333333333400000
        42.333333333333340000
        298.979166666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      Caption = 'lblStrappoPagina'
      Color = clWhite
      Transparent = False
      ExportAs = exptText
      WrapStyle = BreakOnSpaces
      VerticalAlignment = tlTop
      FontSize = 8
    end
    object memoBanner: TQRMemo
      Left = 0
      Top = 32
      Width = 71
      Height = 15
      Size.Values = (
        39.687500000000000000
        0.000000000000000000
        84.666666666666680000
        187.854166666666700000)
      XLColumn = 0
      XLNumFormat = nfGeneral
      ActiveInPreview = False
      Alignment = taLeftJustify
      AlignToBand = False
      AutoStretch = True
      Color = clWhite
      Transparent = False
      FullJustify = False
      MaxBreakChars = 0
      FontSize = 8
    end
    object QRSysData1: TQRSysData
      Left = 192
      Top = 0
      Width = 78
      Height = 15
      Size.Values = (
        39.687500000000000000
        508.000000000000000000
        0.000000000000000000
        206.375000000000000000)
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
      FontSize = 8
    end
  end
  object qrbIntestazionePagina: TQRBand
    Left = 19
    Top = 19
    Width = 756
    Height = 40
    AlignToBottom = False
    Enabled = False
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      105.833333333333300000
      2000.250000000000000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbPageHeader
  end
  object qrbIntestazionePaginaChild: TQRChildBand
    Left = 19
    Top = 59
    Width = 756
    Height = 40
    AlignToBottom = False
    Enabled = False
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      105.833333333333300000
      2000.250000000000000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    ParentBand = qrbIntestazionePagina
    PrintOrder = cboAfterParent
  end
  object Riepilogo5: TQRChildBand
    Left = 19
    Top = 500
    Width = 756
    Height = 17
    AlignToBottom = False
    BeforePrint = Riepilogo5BeforePrint
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = True
    Size.Values = (
      44.979166666666670000
      2000.250000000000000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    ParentBand = Riepilogo4
    PrintOrder = cboAfterParent
  end
  object QRPDFFilter1: TQRPDFFilter
    CompressionOn = True
    Fonthandling = False
    TextEncoding = ASCIIEncoding
    Codepage = '1252'
    SuppressDateTime = False
    Left = 488
  end
  object QRTextFilter1: TQRTextFilter
    TextEncoding = DefaultEncoding
    Left = 344
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
  object QRRTFFilter1: TQRRTFFilter
    TextEncoding = DefaultEncoding
    Left = 416
  end
end
