inherited A040FStampa2: TA040FStampa2
  Caption = 'A040FStampa2'
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inherited QRep: TQuickRep
    DataSet = A040FPianifRepDtM2.cdsPianif
    Functions.DATA = (
      '0'
      '0'
      #39#39)
    Page.Values = (
      100.000000000000000000
      2970.000000000000000000
      100.000000000000000000
      2100.000000000000000000
      100.000000000000000000
      100.000000000000000000
      0.000000000000000000)
    inherited Titolo: TQRBand
      Size.Values = (
        124.354166666666700000
        1899.708333333333000000)
      BandType = rbPageHeader
      inherited LEnte: TQRLabel
        Top = -1
        Size.Values = (
          50.270833333333330000
          881.062500000000000000
          -2.645833333333333000
          134.937500000000000000)
        FontSize = 12
        ExplicitTop = -1
      end
      inherited qlblSysData: TQRSysData
        Left = 675
        Top = 21
        Size.Values = (
          39.687500000000000000
          1785.937500000000000000
          55.562500000000000000
          113.770833333333300000)
        Alignment = taRightJustify
        FontSize = 8
        ExplicitLeft = 675
        ExplicitTop = 21
      end
      inherited LTitolo: TQRLabel
        Size.Values = (
          50.270833333333330000
          873.125000000000000000
          63.500000000000000000
          150.812500000000000000)
        FontSize = 10
      end
      inherited qlblSysPagina: TQRSysData
        Size.Values = (
          39.687500000000000000
          1767.416666666667000000
          0.000000000000000000
          132.291666666666700000)
        FontSize = 8
      end
      object QRLPeriodo: TQRLabel
        Left = 0
        Top = 0
        Width = 71
        Height = 15
        Size.Values = (
          39.687500000000000000
          0.000000000000000000
          0.000000000000000000
          187.854166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = True
        Caption = 'QRLPeriodo'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
    end
    object QRGroup1: TQRGroup
      Left = 38
      Top = 152
      Width = 718
      Height = 27
      AfterPrint = QRGroup1AfterPrint
      AlignToBottom = False
      BeforePrint = QRGroup1BeforePrint
      TransparentBand = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ForceNewColumn = False
      ForceNewPage = False
      ParentFont = False
      Size.Values = (
        71.437500000000000000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      FooterBand = QRBLegendaHead
      Master = QRep
      ReprintOnNewPage = False
      object QRLRaggruppamento1: TQRLabel
        Left = 5
        Top = 5
        Width = 239
        Height = 18
        Size.Values = (
          47.625000000000000000
          13.229166666666670000
          13.229166666666670000
          632.354166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Campo anagrafico di raggruppamento'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 9
      end
      object QRDBTRaggr1: TQRDBText
        Left = 249
        Top = 5
        Width = 78
        Height = 17
        Size.Values = (
          44.979166666666670000
          658.812500000000000000
          13.229166666666670000
          206.375000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataSet = A040FPianifRepDtM2.cdsPianif
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 9
      end
      object QRLRaggruppamento2: TQRLabel
        Left = 5
        Top = 23
        Width = 239
        Height = 18
        Size.Values = (
          47.625000000000000000
          13.229166666666670000
          60.854166666666670000
          632.354166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Campo anagrafico di raggruppamento'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 9
      end
      object QRDBTRaggr2: TQRDBText
        Left = 249
        Top = 23
        Width = 78
        Height = 17
        Size.Values = (
          44.979166666666670000
          658.812500000000000000
          60.854166666666670000
          206.375000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataSet = A040FPianifRepDtM2.cdsPianif
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 9
      end
    end
    object QRBDettaglio: TQRBand
      Left = 38
      Top = 219
      Width = 718
      Height = 24
      Frame.DrawTop = True
      Frame.DrawBottom = True
      Frame.DrawLeft = True
      Frame.DrawRight = True
      AfterPrint = QRBDettaglioAfterPrint
      AlignToBottom = False
      BeforePrint = QRBHeaderBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        63.500000000000000000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbDetail
    end
    object QRBHeader: TQRBand
      Left = 38
      Top = 111
      Width = 718
      Height = 41
      Frame.DrawTop = True
      Frame.DrawBottom = True
      Frame.DrawLeft = True
      Frame.DrawRight = True
      AlignToBottom = False
      BeforePrint = QRBHeaderBeforePrint
      TransparentBand = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      ForceNewColumn = False
      ForceNewPage = False
      ParentFont = False
      Size.Values = (
        108.479166666666700000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbColumnHeader
    end
    object ChildBand1: TQRChildBand
      Left = 38
      Top = 85
      Width = 718
      Height = 26
      AlignToBottom = False
      BeforePrint = ChildBand1BeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        68.791666666666670000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      ParentBand = Titolo
      PrintOrder = cboAfterParent
      object QRLRaggruppamentoChild1: TQRLabel
        Left = 5
        Top = 5
        Width = 239
        Height = 18
        Size.Values = (
          47.625000000000000000
          13.229166666666670000
          13.229166666666670000
          632.354166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Campo anagrafico di raggruppamento'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 9
      end
      object QRDBTRaggrChild1: TQRDBText
        Left = 249
        Top = 5
        Width = 113
        Height = 17
        Size.Values = (
          44.979166666666670000
          658.812500000000000000
          13.229166666666670000
          298.979166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataSet = A040FPianifRepDtM2.cdsPianif
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 9
      end
      object QRLRaggruppamentoChild2: TQRLabel
        Left = 5
        Top = 23
        Width = 239
        Height = 18
        Size.Values = (
          47.625000000000000000
          13.229166666666670000
          60.854166666666670000
          632.354166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Campo anagrafico di raggruppamento'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 9
      end
      object QRDBTRaggrChild2: TQRDBText
        Left = 249
        Top = 23
        Width = 113
        Height = 17
        Size.Values = (
          44.979166666666670000
          658.812500000000000000
          60.854166666666670000
          298.979166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataSet = A040FPianifRepDtM2.cdsPianif
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 9
      end
    end
    object QRBLegendaHead: TQRBand
      Left = 38
      Top = 243
      Width = 718
      Height = 66
      AlignToBottom = False
      BeforePrint = QRBLegendaHeadBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        174.625000000000000000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = True
      BandType = rbGroupFooter
      object QRLineHeadB: TQRShape
        Left = 0
        Top = 64
        Width = 700
        Height = 1
        Size.Values = (
          2.645833333333333000
          0.000000000000000000
          169.333333333333300000
          1852.083333333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRShape2: TQRShape
        Left = 0
        Top = 30
        Width = 1
        Height = 30
        Size.Values = (
          79.375000000000000000
          0.000000000000000000
          79.375000000000000000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLineHeadT: TQRShape
        Left = 0
        Top = 20
        Width = 700
        Height = 1
        Size.Values = (
          2.645833333333333000
          0.000000000000000000
          52.916666666666670000
          1852.083333333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object qlblTurniTitolo: TQRLabel
        Left = 5
        Top = 23
        Width = 92
        Height = 15
        Size.Values = (
          39.687500000000000000
          13.229166666666670000
          60.854166666666670000
          243.416666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'LEGENDA TURNI'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object qlblCausTitolo: TQRLabel
        Left = 180
        Top = 23
        Width = 183
        Height = 15
        Size.Values = (
          39.687500000000000000
          476.250000000000000000
          60.854166666666670000
          484.187500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'LEGENDA CAUSALI DI ASSENZA'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object qlblDatoAgg1Titolo: TQRLabel
        Left = 355
        Top = 23
        Width = 113
        Height = 15
        Size.Values = (
          39.687500000000000000
          939.270833333333300000
          60.854166666666670000
          298.979166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'LEGENDA DATOAGG1'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object qlblDatoAgg2Titolo: TQRLabel
        Left = 530
        Top = 23
        Width = 113
        Height = 15
        Size.Values = (
          39.687500000000000000
          1402.291666666667000000
          60.854166666666670000
          298.979166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'LEGENDA DATOAGG2'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object qlblTurniCod: TQRLabel
        Left = 5
        Top = 45
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          13.229166666666670000
          119.062500000000000000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Codice'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object qlblTurniDesc: TQRLabel
        Left = 91
        Top = 45
        Width = 78
        Height = 15
        Size.Values = (
          39.687500000000000000
          240.770833333333300000
          119.062500000000000000
          206.375000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Descrizione'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object qlblCausCod: TQRLabel
        Left = 180
        Top = 45
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          476.250000000000000000
          119.062500000000000000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Codice'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object qlblCausDesc: TQRLabel
        Left = 242
        Top = 45
        Width = 78
        Height = 15
        Size.Values = (
          39.687500000000000000
          640.291666666666700000
          119.062500000000000000
          206.375000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Descrizione'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object qlblDatoAgg1Cod: TQRLabel
        Left = 355
        Top = 45
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          939.270833333333300000
          119.062500000000000000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Codice'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object qlblDatoAgg1Desc: TQRLabel
        Left = 417
        Top = 45
        Width = 78
        Height = 15
        Size.Values = (
          39.687500000000000000
          1103.312500000000000000
          119.062500000000000000
          206.375000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Descrizione'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object qlblDatoAgg2Cod: TQRLabel
        Left = 530
        Top = 45
        Width = 43
        Height = 15
        Size.Values = (
          39.687500000000000000
          1402.291666666667000000
          119.062500000000000000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Codice'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object qlblDatoAgg2Desc: TQRLabel
        Left = 592
        Top = 45
        Width = 78
        Height = 15
        Size.Values = (
          39.687500000000000000
          1566.333333333333000000
          119.062500000000000000
          206.375000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Descrizione'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object qshpTurniTitolo: TQRShape
        Left = 175
        Top = 30
        Width = 1
        Height = 30
        Size.Values = (
          79.375000000000000000
          463.020833333333300000
          79.375000000000000000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object qshpCausTitolo: TQRShape
        Left = 350
        Top = 30
        Width = 1
        Height = 30
        Size.Values = (
          79.375000000000000000
          926.041666666666700000
          79.375000000000000000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object qshpDatoAgg1Titolo: TQRShape
        Left = 525
        Top = 30
        Width = 1
        Height = 30
        Size.Values = (
          79.375000000000000000
          1389.062500000000000000
          79.375000000000000000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object qshpDatoAgg2Titolo: TQRShape
        Left = 699
        Top = 30
        Width = 1
        Height = 30
        Size.Values = (
          79.375000000000000000
          1849.437500000000000000
          79.375000000000000000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Shape = qrsVertLine
        VertAdjust = 0
      end
    end
    object QRBLegendaDett: TQRChildBand
      Left = 38
      Top = 309
      Width = 718
      Height = 20
      AfterPrint = QRBLegendaDettAfterPrint
      AlignToBottom = False
      BeforePrint = QRBLegendaDettBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        52.916666666666670000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = True
      ParentBand = QRBLegendaHead
      PrintOrder = cboAfterParent
      object QRShape6: TQRShape
        Left = 0
        Top = 4
        Width = 1
        Height = 13
        Size.Values = (
          34.395833333333330000
          0.000000000000000000
          10.583333333333330000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object QRLineDettB: TQRShape
        Left = 0
        Top = 20
        Width = 600
        Height = 1
        Size.Values = (
          2.645833333333333000
          0.000000000000000000
          52.916666666666670000
          1587.500000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object dlblTurniCod: TQRDBText
        Left = 5
        Top = 3
        Width = 70
        Height = 15
        Size.Values = (
          39.687500000000000000
          13.229166666666670000
          7.937500000000000000
          185.208333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = A040FPianifRepDtM2.cdsLegenda
        DataField = 'CODTURNO'
        Transparent = True
        WordWrap = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object dlblTurniDesc: TQRDBText
        Left = 91
        Top = 3
        Width = 78
        Height = 15
        Size.Values = (
          39.687500000000000000
          240.770833333333300000
          7.937500000000000000
          206.375000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = A040FPianifRepDtM2.cdsLegenda
        DataField = 'DESCTURNO'
        Transparent = True
        WordWrap = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object dlblCausCod: TQRDBText
        Left = 180
        Top = 3
        Width = 50
        Height = 15
        Size.Values = (
          39.687500000000000000
          476.250000000000000000
          7.937500000000000000
          132.291666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = A040FPianifRepDtM2.cdsLegenda
        DataField = 'CODCAUS'
        Transparent = True
        WordWrap = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object dlblCausDesc: TQRDBText
        Left = 242
        Top = 3
        Width = 78
        Height = 15
        Size.Values = (
          39.687500000000000000
          640.291666666666700000
          7.937500000000000000
          206.375000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = A040FPianifRepDtM2.cdsLegenda
        DataField = 'DESCCAUS'
        Transparent = True
        WordWrap = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object dlblDatoAgg1Cod: TQRDBText
        Left = 355
        Top = 3
        Width = 50
        Height = 15
        Size.Values = (
          39.687500000000000000
          939.270833333333300000
          7.937500000000000000
          132.291666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = A040FPianifRepDtM2.cdsLegenda
        DataField = 'CODDATOAGG1'
        Transparent = True
        WordWrap = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object dlblDatoAgg1Desc: TQRDBText
        Left = 417
        Top = 3
        Width = 78
        Height = 15
        Size.Values = (
          39.687500000000000000
          1103.312500000000000000
          7.937500000000000000
          206.375000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = A040FPianifRepDtM2.cdsLegenda
        DataField = 'DESCDATOAGG1'
        Transparent = True
        WordWrap = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object dlblDatoAgg2Cod: TQRDBText
        Left = 530
        Top = 3
        Width = 50
        Height = 15
        Size.Values = (
          39.687500000000000000
          1402.291666666667000000
          7.937500000000000000
          132.291666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = A040FPianifRepDtM2.cdsLegenda
        DataField = 'CODDATOAGG2'
        Transparent = True
        WordWrap = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object dlblDatoAgg2Desc: TQRDBText
        Left = 592
        Top = 3
        Width = 78
        Height = 15
        Size.Values = (
          39.687500000000000000
          1566.333333333333000000
          7.937500000000000000
          206.375000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataSet = A040FPianifRepDtM2.cdsLegenda
        DataField = 'DESCDATOAGG2'
        Transparent = True
        WordWrap = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object qshpTurniDett: TQRShape
        Left = 175
        Top = 4
        Width = 1
        Height = 13
        Size.Values = (
          34.395833333333330000
          463.020833333333300000
          10.583333333333330000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object qshpCausDett: TQRShape
        Left = 350
        Top = 4
        Width = 1
        Height = 13
        Size.Values = (
          34.395833333333330000
          926.041666666666700000
          10.583333333333330000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object qshpDatoAgg1Dett: TQRShape
        Left = 525
        Top = 4
        Width = 1
        Height = 13
        Size.Values = (
          34.395833333333330000
          1389.062500000000000000
          10.583333333333330000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Shape = qrsVertLine
        VertAdjust = 0
      end
      object qshpDatoAgg2Dett: TQRShape
        Left = 699
        Top = 4
        Width = 1
        Height = 13
        Size.Values = (
          34.395833333333330000
          1849.437500000000000000
          10.583333333333330000
          2.645833333333333000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Shape = qrsVertLine
        VertAdjust = 0
      end
    end
    object bndColonneRaggr: TQRChildBand
      Left = 38
      Top = 179
      Width = 718
      Height = 40
      Frame.DrawTop = True
      Frame.DrawBottom = True
      Frame.DrawLeft = True
      Frame.DrawRight = True
      AlignToBottom = False
      BeforePrint = bndColonneRaggrBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        105.833333333333300000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      ParentBand = QRGroup1
      PrintOrder = cboAfterParent
    end
  end
end
