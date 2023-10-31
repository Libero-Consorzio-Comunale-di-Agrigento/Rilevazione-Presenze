inherited A202FStampa: TA202FStampa
  Caption = 'A202FStampa'
  ClientHeight = 812
  ClientWidth = 809
  Font.Name = 'Tahoma'
  ExplicitTop = -130
  ExplicitWidth = 825
  ExplicitHeight = 851
  PixelsPerInch = 96
  TextHeight = 13
  inherited QRep: TQuickRep
    Left = 8
    Font.Height = -13
    Font.Name = 'Arial'
    Functions.Strings = (
      'PAGENUMBER'
      'COLUMNNUMBER'
      'REPORTTITLE'
      'QRLOOPBAND1'
      'QRSTRINGSBAND1')
    Functions.DATA = (
      '0'
      '0'
      #39#39
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
    PrintIfEmpty = True
    ExplicitLeft = 8
    object qrbTitoloPeriodi: TQRBand [0]
      Left = 38
      Top = 357
      Width = 718
      Height = 32
      AlignToBottom = False
      Enabled = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        84.666666666666670000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbColumnHeader
      object QRLabel1: TQRLabel
        Left = 238
        Top = 3
        Width = 227
        Height = 21
        Size.Values = (
          55.562500000000000000
          629.708333333333300000
          7.937500000000000000
          600.604166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        Caption = 'Periodi giuridici autocertificati'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 12
      end
    end
    inherited Titolo: TQRBand
      Height = 75
      Frame.DrawBottom = True
      Size.Values = (
        198.437500000000000000
        1899.708333333333000000)
      BandType = rbPageHeader
      ExplicitHeight = 75
      inherited LEnte: TQRLabel
        Top = 10
        Height = 23
        Size.Values = (
          60.854166666666670000
          881.062500000000000000
          26.458333333333330000
          134.937500000000000000)
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = []
        FontSize = 14
        ExplicitTop = 10
        ExplicitHeight = 23
      end
      inherited qlblSysData: TQRSysData
        Width = 32
        Size.Values = (
          39.687500000000000000
          0.000000000000000000
          0.000000000000000000
          84.666666666666670000)
        Font.Name = 'Tahoma'
        ParentFont = False
        FontSize = 8
        ExplicitWidth = 32
      end
      inherited LTitolo: TQRLabel
        Left = 227
        Top = 38
        Width = 264
        Height = 24
        Size.Values = (
          63.500000000000000000
          600.604166666666700000
          100.541666666666700000
          698.500000000000000000)
        Caption = 'Dati giuridici autocertificati'
        Font.Height = -19
        Font.Name = 'Tahoma'
        FontSize = 14
        ExplicitLeft = 227
        ExplicitTop = 38
        ExplicitWidth = 264
        ExplicitHeight = 24
      end
      inherited qlblSysPagina: TQRSysData
        Left = 677
        Width = 41
        Size.Values = (
          39.687500000000000000
          1791.229166666667000000
          0.000000000000000000
          108.479166666666700000)
        Font.Name = 'Tahoma'
        ParentFont = False
        FontSize = 8
        ExplicitLeft = 677
        ExplicitWidth = 41
      end
    end
    object qrT425: TQRBand
      Left = 38
      Top = 389
      Width = 718
      Height = 192
      Frame.Color = clMedGray
      Frame.DrawBottom = True
      Frame.Style = psDash
      AlignToBottom = False
      BeforePrint = qrT425BeforePrint
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        508.000000000000000000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbDetail
      object qlblInizio: TQRDBText
        Left = 119
        Top = 4
        Width = 36
        Height = 17
        Size.Values = (
          44.979166666666670000
          314.854166666666700000
          10.583333333333330000
          95.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataField = 'INIZIO'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object qlblFine: TQRDBText
        Left = 227
        Top = 4
        Width = 30
        Height = 17
        Size.Values = (
          44.979166666666670000
          600.604166666666700000
          10.583333333333330000
          79.375000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataField = 'FINE'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object qlblDal: TQRLabel
        Left = 16
        Top = 4
        Width = 70
        Height = 17
        Size.Values = (
          44.979166666666670000
          42.333333333333330000
          10.583333333333330000
          185.208333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Periodo dal:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object qlblAl: TQRLabel
        Left = 199
        Top = 4
        Width = 15
        Height = 17
        Size.Values = (
          44.979166666666670000
          526.520833333333300000
          10.583333333333330000
          39.687500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'al:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object qlblTipoRapporto: TQRLabel
        Left = 16
        Top = 40
        Width = 80
        Height = 17
        Size.Values = (
          44.979166666666670000
          42.333333333333330000
          105.833333333333300000
          211.666666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Tipo rapporto:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object qlblD_TipoRapporto: TQRDBText
        Left = 119
        Top = 40
        Width = 116
        Height = 17
        Size.Values = (
          44.979166666666670000
          314.854166666666700000
          105.833333333333300000
          306.916666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataField = 'd_TIPORAPPORTO'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object qlblEnte: TQRLabel
        Left = 16
        Top = 20
        Width = 32
        Height = 17
        Size.Values = (
          44.979166666666670000
          42.333333333333330000
          52.916666666666670000
          84.666666666666670000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Ente:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object qlblD_Ente: TQRDBText
        Left = 119
        Top = 20
        Width = 49
        Height = 17
        Size.Values = (
          44.979166666666670000
          314.854166666666700000
          52.916666666666670000
          129.645833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataField = 'd_ENTE'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object qlblPartTime: TQRLabel
        Left = 16
        Top = 76
        Width = 58
        Height = 17
        Size.Values = (
          44.979166666666670000
          42.333333333333330000
          201.083333333333300000
          153.458333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Part time:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object qlblD_PartTime: TQRDBText
        Left = 119
        Top = 76
        Width = 79
        Height = 17
        Size.Values = (
          44.979166666666670000
          314.854166666666700000
          201.083333333333300000
          209.020833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataField = 'd_PARTTIME'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object qlblTipologia: TQRLabel
        Left = 16
        Top = 56
        Width = 56
        Height = 17
        Size.Values = (
          44.979166666666670000
          42.333333333333330000
          148.166666666666700000
          148.166666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Tipologia:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object qlblD_TIPO: TQRDBText
        Left = 119
        Top = 56
        Width = 44
        Height = 17
        Size.Values = (
          44.979166666666670000
          314.854166666666700000
          148.166666666666700000
          116.416666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataField = 'd_TIPO'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object qlblTipoPartTime: TQRLabel
        Left = 16
        Top = 92
        Width = 84
        Height = 17
        Size.Values = (
          44.979166666666670000
          42.333333333333330000
          243.416666666666700000
          222.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Tipo part time:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object qlblD_TipoPT: TQRDBText
        Left = 119
        Top = 92
        Width = 60
        Height = 17
        Size.Values = (
          44.979166666666670000
          314.854166666666700000
          243.416666666666700000
          158.750000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataField = 'd_TIPOPT'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel8: TQRLabel
        Left = 280
        Top = 92
        Width = 76
        Height = 17
        Size.Values = (
          44.979166666666670000
          740.833333333333300000
          243.416666666666700000
          201.083333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = '% Presenza:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object qlblD_INDPRESPT: TQRDBText
        Left = 368
        Top = 92
        Width = 88
        Height = 17
        Size.Values = (
          44.979166666666670000
          973.666666666666700000
          243.416666666666700000
          232.833333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataField = 'd_INDPRESPT'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object qlblQualifica: TQRLabel
        Left = 16
        Top = 112
        Width = 55
        Height = 17
        Size.Values = (
          44.979166666666670000
          42.333333333333330000
          296.333333333333300000
          145.520833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Qualifica:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object qlblDisciplina: TQRLabel
        Left = 16
        Top = 132
        Width = 61
        Height = 17
        Size.Values = (
          44.979166666666670000
          42.333333333333330000
          349.250000000000000000
          161.395833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Disciplina:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object qlblD_Disciplina: TQRDBText
        Left = 119
        Top = 132
        Width = 85
        Height = 17
        Size.Values = (
          44.979166666666670000
          314.854166666666700000
          349.250000000000000000
          224.895833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataField = 'd_DISCIPLINA'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object qlblD_Qualifica: TQRDBText
        Left = 119
        Top = 112
        Width = 82
        Height = 17
        Size.Values = (
          44.979166666666670000
          314.854166666666700000
          296.333333333333300000
          216.958333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataField = 'd_QUALIFICA'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object qlblNoteT: TQRLabel
        Left = 16
        Top = 152
        Width = 32
        Height = 17
        Size.Values = (
          44.979166666666670000
          42.333333333333330000
          402.166666666666700000
          84.666666666666670000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Note:'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object qlblNote: TQRDBText
        Left = 119
        Top = 152
        Width = 36
        Height = 17
        Size.Values = (
          44.979166666666670000
          314.854166666666700000
          402.166666666666700000
          95.250000000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataField = 'NOTE'
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object qExprValidato: TQRExpr
        Left = 686
        Top = 4
        Width = 239
        Height = 17
        Size.Values = (
          44.979166666666670000
          1815.041666666667000000
          10.583333333333330000
          632.354166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Color = clWhite
        ParentFont = False
        ResetAfterPrint = False
        Transparent = False
        Expression = 'IF(selT425.VALIDAZIONE = '#39'S'#39','#39'S'#236#39','#39'No'#39')'
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FontSize = 10
      end
      object qlblValidato: TQRLabel
        Left = 630
        Top = 4
        Width = 52
        Height = 17
        Size.Values = (
          44.979166666666670000
          1666.875000000000000000
          10.583333333333330000
          137.583333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Validato:'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
    end
    object qrDatiAnagrafico: TQRBand
      Left = 38
      Top = 113
      Width = 718
      Height = 35
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        92.604166666666670000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbTitle
      object qlblMatricola: TQRLabel
        Left = 632
        Top = 8
        Width = 62
        Height = 17
        Size.Values = (
          44.979166666666670000
          1672.166666666667000000
          21.166666666666670000
          164.041666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taRightJustify
        AlignToBand = False
        Caption = 'Matricola: '
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object qlblCognome: TQRLabel
        Left = 16
        Top = 8
        Width = 64
        Height = 17
        Size.Values = (
          44.979166666666670000
          42.333333333333330000
          21.166666666666670000
          169.333333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Cognome: '
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object qlblNome: TQRLabel
        Left = 216
        Top = 8
        Width = 43
        Height = 17
        Size.Values = (
          44.979166666666670000
          571.500000000000000000
          21.166666666666670000
          113.770833333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Nome: '
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
    end
    object qrRiepilogo_Titolo: TQRChildBand
      Left = 38
      Top = 148
      Width = 718
      Height = 32
      Frame.DrawTop = True
      Frame.DrawBottom = True
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        84.666666666666670000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      ParentBand = qrDatiAnagrafico
      PrintOrder = cboAfterParent
      object QRLabel5: TQRLabel
        Left = 314
        Top = 5
        Width = 74
        Height = 21
        Size.Values = (
          55.562500000000000000
          830.791666666666700000
          13.229166666666670000
          195.791666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        Caption = 'Riepilogo'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 12
      end
    end
    object qrT055_Titolo: TQRBand
      Left = 38
      Top = 581
      Width = 718
      Height = 32
      Frame.DrawBottom = True
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = True
      Size.Values = (
        84.666666666666670000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbSummary
      object QRLabel3: TQRLabel
        Left = 218
        Top = 5
        Width = 267
        Height = 21
        Size.Values = (
          55.562500000000000000
          576.791666666666700000
          13.229166666666670000
          706.437500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        Caption = 'Periodi di aspettativa autocertificati'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 12
      end
    end
    object qrRiepilogo: TQRChildBand
      Left = 38
      Top = 180
      Width = 718
      Height = 145
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        383.645833333333300000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      ParentBand = qrRiepilogo_Titolo
      PrintOrder = cboAfterParent
      object QRLabel7: TQRLabel
        Left = 16
        Top = 76
        Width = 219
        Height = 17
        Size.Values = (
          44.979166666666670000
          42.333333333333330000
          201.083333333333300000
          579.437500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Servizi prestati a tempo indeterminato'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel6: TQRLabel
        Left = 16
        Top = 53
        Width = 122
        Height = 17
        Size.Values = (
          44.979166666666670000
          42.333333333333330000
          140.229166666666700000
          322.791666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Servizi prestati totale'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object qlblComplGG: TQRLabel
        Left = 260
        Top = 10
        Width = 74
        Height = 35
        Size.Values = (
          92.604166666666670000
          687.916666666666700000
          26.458333333333330000
          195.791666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        Caption = 'Complessivo'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object qlblSPT_GG: TQRLabel
        Left = 321
        Top = 53
        Width = 13
        Height = 17
        Size.Values = (
          44.979166666666670000
          849.312500000000000000
          140.229166666666700000
          34.395833333333330000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taRightJustify
        AlignToBand = False
        Caption = '---'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object qlblSPTI_GG: TQRLabel
        Left = 321
        Top = 76
        Width = 13
        Height = 17
        Size.Values = (
          44.979166666666670000
          849.312500000000000000
          201.083333333333300000
          34.395833333333330000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taRightJustify
        AlignToBand = False
        Caption = '---'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object qlblSPTI_AA: TQRLabel
        Left = 441
        Top = 76
        Width = 13
        Height = 17
        Size.Values = (
          44.979166666666670000
          1166.812500000000000000
          201.083333333333300000
          34.395833333333330000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taRightJustify
        AlignToBand = False
        Caption = '---'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object qlblComplAA: TQRLabel
        Left = 380
        Top = 10
        Width = 74
        Height = 35
        Size.Values = (
          92.604166666666670000
          1005.416666666667000000
          26.458333333333330000
          195.791666666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        Caption = 'Complessivo'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object qlblSPT_AA: TQRLabel
        Left = 441
        Top = 53
        Width = 13
        Height = 17
        Size.Values = (
          44.979166666666670000
          1166.812500000000000000
          140.229166666666700000
          34.395833333333330000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taRightJustify
        AlignToBand = False
        Caption = '---'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object qlblDaApprGG: TQRLabel
        Left = 500
        Top = 10
        Width = 76
        Height = 35
        Size.Values = (
          92.604166666666670000
          1322.916666666667000000
          26.458333333333330000
          201.083333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        Caption = 'Da approvare'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object qlblSPT_GG_NA: TQRLabel
        Left = 561
        Top = 53
        Width = 13
        Height = 17
        Size.Values = (
          44.979166666666670000
          1484.312500000000000000
          140.229166666666700000
          34.395833333333330000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taRightJustify
        AlignToBand = False
        Caption = '---'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object qlblSPTI_GG_NA: TQRLabel
        Left = 561
        Top = 76
        Width = 13
        Height = 17
        Size.Values = (
          44.979166666666670000
          1484.312500000000000000
          201.083333333333300000
          34.395833333333330000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taRightJustify
        AlignToBand = False
        Caption = '---'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object qlblSPT_AA_NA: TQRLabel
        Left = 681
        Top = 53
        Width = 13
        Height = 17
        Size.Values = (
          44.979166666666670000
          1801.812500000000000000
          140.229166666666700000
          34.395833333333330000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taRightJustify
        AlignToBand = False
        Caption = '---'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object qlblSPTI_AA_NA: TQRLabel
        Left = 681
        Top = 76
        Width = 13
        Height = 17
        Size.Values = (
          44.979166666666670000
          1801.812500000000000000
          201.083333333333300000
          34.395833333333330000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taRightJustify
        AlignToBand = False
        Caption = '---'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object qlblDaApprAA: TQRLabel
        Left = 620
        Top = 10
        Width = 76
        Height = 35
        Size.Values = (
          92.604166666666670000
          1640.416666666667000000
          26.458333333333330000
          201.083333333333300000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        Caption = 'Da approvare'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object QRLabel2: TQRLabel
        Left = 16
        Top = 99
        Width = 213
        Height = 17
        Size.Values = (
          44.979166666666670000
          42.333333333333330000
          261.937500000000000000
          563.562500000000000000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taLeftJustify
        AlignToBand = False
        Caption = 'Servizi prestati rapportati al part time'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object qlblSFTE_GG: TQRLabel
        Left = 321
        Top = 99
        Width = 13
        Height = 17
        Size.Values = (
          44.979166666666670000
          849.312500000000000000
          261.937500000000000000
          34.395833333333330000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taRightJustify
        AlignToBand = False
        Caption = '---'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object qlblSFTE_AA: TQRLabel
        Left = 441
        Top = 99
        Width = 13
        Height = 17
        Size.Values = (
          44.979166666666670000
          1166.812500000000000000
          261.937500000000000000
          34.395833333333330000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taRightJustify
        AlignToBand = False
        Caption = '---'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object qlblSFTE_GG_NA: TQRLabel
        Left = 561
        Top = 99
        Width = 13
        Height = 17
        Size.Values = (
          44.979166666666670000
          1484.312500000000000000
          261.937500000000000000
          34.395833333333330000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taRightJustify
        AlignToBand = False
        Caption = '---'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
      object qlblSFTE_AA_NA: TQRLabel
        Left = 681
        Top = 99
        Width = 13
        Height = 17
        Size.Values = (
          44.979166666666670000
          1801.812500000000000000
          261.937500000000000000
          34.395833333333330000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taRightJustify
        AlignToBand = False
        Caption = '---'
        Color = clWhite
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 10
      end
    end
    object qrT425_Titolo: TQRChildBand
      Left = 38
      Top = 325
      Width = 718
      Height = 32
      Frame.DrawTop = True
      Frame.DrawBottom = True
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        84.666666666666670000
        1899.708333333333000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      ParentBand = qrRiepilogo
      PrintOrder = cboAfterParent
      object QRLabel4: TQRLabel
        Left = 238
        Top = 5
        Width = 227
        Height = 21
        Size.Values = (
          55.562500000000000000
          629.708333333333300000
          13.229166666666670000
          600.604166666666700000)
        XLColumn = 0
        XLNumFormat = nfGeneral
        ActiveInPreview = False
        Alignment = taCenter
        AlignToBand = False
        Caption = 'Periodi giuridici autocertificati'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        VerticalAlignment = tlTop
        FontSize = 12
      end
    end
  end
end
