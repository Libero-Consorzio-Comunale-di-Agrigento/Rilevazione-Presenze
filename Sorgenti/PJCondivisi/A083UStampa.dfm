inherited A083FStampa: TA083FStampa
  Caption = 'A083FStampa'
  ClientHeight = 962
  ClientWidth = 1267
  ExplicitWidth = 1283
  ExplicitHeight = 1001
  PixelsPerInch = 96
  TextHeight = 13
  inherited QRep: TQuickRep
    Width = 1123
    Height = 794
    Functions.DATA = (
      '0'
      '0'
      #39#39)
    Page.Orientation = poLandscape
    Page.Values = (
      100.000000000000000000
      2100.000000000000000000
      100.000000000000000000
      2970.000000000000000000
      100.000000000000000000
      100.000000000000000000
      0.000000000000000000)
    ExplicitWidth = 1123
    ExplicitHeight = 794
    object QRBndDettaglio: TQRBand [0]
      Left = 38
      Top = 126
      Width = 1047
      Height = 40
      AlignToBottom = False
      BeforePrint = QRBndDettaglioBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        105.833333333333300000
        2770.187500000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbDetail
      object QRDBTxtMessaggio: TQRDBText
        Left = 100
        Top = 21
        Width = 940
        Height = 15
        Size.Values = (
          39.687500000000000000
          264.583333333333300000
          55.562500000000000000
          2487.083333333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = True
        Color = clWhite
        DataField = 'MSG'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRDBTxtNominativo: TQRDBText
        Left = 770
        Top = 5
        Width = 270
        Height = 15
        Size.Values = (
          39.687500000000000000
          2037.291666666667000000
          13.229166666666670000
          714.375000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'Nominativo'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRDBTxtMatricola: TQRDBText
        Left = 703
        Top = 5
        Width = 64
        Height = 15
        Size.Values = (
          39.687500000000000000
          1860.020833333333000000
          13.229166666666670000
          169.333333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'MATRICOLA'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLineaOrizz: TQRShape
        Left = 2
        Top = 1
        Width = 1045
        Height = 3
        Size.Values = (
          7.937500000000000000
          5.291666666666667000
          2.645833333333333000
          2764.895833333333000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Shape = qrsHorLine
        VertAdjust = 0
      end
      object QRDBTxtTipo: TQRDBText
        Left = 2
        Top = 21
        Width = 95
        Height = 15
        Size.Values = (
          39.687500000000000000
          5.291666666666667000
          55.562500000000000000
          251.354166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'TIPO'
        Transparent = False
        WordWrap = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRDBTxtMaschera: TQRDBText
        Left = 545
        Top = 5
        Width = 60
        Height = 15
        Size.Values = (
          39.687500000000000000
          1441.979166666667000000
          13.229166666666670000
          158.750000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'MASCHERA'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRDBTxtOperatore: TQRDBText
        Left = 385
        Top = 5
        Width = 70
        Height = 15
        Size.Values = (
          39.687500000000000000
          1018.645833333333000000
          13.229166666666670000
          185.208333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'OPERATORE'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRDBTxtData: TQRDBText
        Left = 145
        Top = 5
        Width = 150
        Height = 15
        Size.Values = (
          39.687500000000000000
          383.645833333333300000
          13.229166666666670000
          396.875000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'DATA_MSG'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRDBTxtID: TQRDBText
        Left = 29
        Top = 5
        Width = 50
        Height = 15
        Size.Values = (
          39.687500000000000000
          76.729166666666680000
          13.229166666666670000
          132.291666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        Color = clWhite
        DataField = 'ID'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLblID: TQRLabel
        Left = 2
        Top = 5
        Width = 22
        Height = 15
        Size.Values = (
          39.687500000000000000
          5.291666666666667000
          13.229166666666670000
          58.208333333333330000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'ID:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLblData: TQRLabel
        Left = 100
        Top = 5
        Width = 36
        Height = 15
        Size.Values = (
          39.687500000000000000
          264.583333333333300000
          13.229166666666670000
          95.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Data:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLblOperatore: TQRLabel
        Left = 309
        Top = 5
        Width = 71
        Height = 15
        Size.Values = (
          39.687500000000000000
          817.562500000000000000
          13.229166666666670000
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
      object QRLblMaschera: TQRLabel
        Left = 475
        Top = 5
        Width = 64
        Height = 15
        Size.Values = (
          39.687500000000000000
          1256.770833333333000000
          13.229166666666670000
          169.333333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Maschera:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRLblMatricola: TQRLabel
        Left = 628
        Top = 5
        Width = 71
        Height = 15
        Size.Values = (
          39.687500000000000000
          1661.583333333333000000
          13.229166666666670000
          187.854166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Matricola:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
    end
    inherited Titolo: TQRBand
      Top = 54
      Width = 1047
      Height = 50
      BeforePrint = TitoloBeforePrint
      Size.Values = (
        132.291666666666700000
        2770.187500000000000000)
      ExplicitTop = 54
      ExplicitWidth = 1047
      ExplicitHeight = 50
      inherited LEnte: TQRLabel
        Left = 498
        Size.Values = (
          50.270833333333330000
          1317.625000000000000000
          0.000000000000000000
          134.937500000000000000)
        FontSize = 12
        ExplicitLeft = 498
      end
      inherited qlblSysData: TQRSysData
        Enabled = False
        Size.Values = (
          39.687500000000000000
          0.000000000000000000
          0.000000000000000000
          113.770833333333300000)
        FontSize = 8
      end
      inherited LTitolo: TQRLabel
        Left = 495
        Size.Values = (
          50.270833333333330000
          1309.687500000000000000
          63.500000000000000000
          150.812500000000000000)
        FontSize = 10
        ExplicitLeft = 495
      end
      inherited qlblSysPagina: TQRSysData
        Left = 997
        Enabled = False
        Size.Values = (
          39.687500000000000000
          2637.895833333333000000
          0.000000000000000000
          132.291666666666700000)
        FontSize = 8
        ExplicitLeft = 997
      end
    end
    object QRBndAzienda: TQRGroup
      Left = 38
      Top = 104
      Width = 1047
      Height = 22
      AlignToBottom = False
      BeforePrint = QRBndAziendaBeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = True
      Size.Values = (
        58.208333333333330000
        2770.187500000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Master = QRep
      ReprintOnNewPage = False
      object QRLblAzienda: TQRLabel
        Left = 465
        Top = 4
        Width = 50
        Height = 15
        Size.Values = (
          39.687500000000000000
          1230.312500000000000000
          10.583333333333330000
          132.291666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Azienda'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 8
      end
      object QRDBTxtAzienda: TQRDBText
        Left = 520
        Top = 4
        Width = 78
        Height = 15
        Size.Values = (
          39.687500000000000000
          1375.833333333333000000
          10.583333333333330000
          206.375000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataField = 'AZIENDA_MSG'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
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
    object QRBndIntestazione: TQRBand
      Left = 38
      Top = 38
      Width = 1047
      Height = 16
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        42.333333333333330000
        2770.187500000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbPageHeader
      object QRSysData1: TQRSysData
        Left = 997
        Top = 0
        Width = 50
        Height = 15
        Size.Values = (
          39.687500000000000000
          2637.895833333333000000
          0.000000000000000000
          132.291666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taRightJustify
        AlignToBand = False
        Color = clWhite
        Data = qrsPageNumber
        Text = ''
        Transparent = False
        ExportAs = exptText
        VerticalAlignment = tlTop
        FontSize = 8
      end
    end
  end
end
