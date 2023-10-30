object A058FLegenda: TA058FLegenda
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Legenda'
  ClientHeight = 509
  ClientWidth = 602
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBox: TScrollBox
    Left = 0
    Top = 0
    Width = 602
    Height = 509
    Align = alClient
    BevelOuter = bvRaised
    BorderStyle = bsNone
    TabOrder = 0
    object grpAssenze: TGroupBox
      Left = 8
      Top = 144
      Width = 585
      Height = 216
      Caption = 'Contenuto delle celle - Assenze'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object Riquadro7: TShape
        Left = 10
        Top = 17
        Width = 71
        Height = 48
      end
      object lblRiquadro: TLabel
        Left = 87
        Top = 17
        Width = 200
        Height = 48
        AutoSize = False
        Caption = 'Assenza operativa effettiva a giornata intera'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        WordWrap = True
      end
      object lblElemRiquadro7: TLabel
        Left = 11
        Top = 18
        Width = 69
        Height = 14
        AutoSize = False
        Caption = ' XXX'
        Color = clRed
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = False
      end
      object Riquadro10: TShape
        Left = 299
        Top = 77
        Width = 71
        Height = 48
      end
      object lblRiquadro10: TLabel
        Left = 376
        Top = 77
        Width = 200
        Height = 48
        AutoSize = False
        Caption = 'Assenza da validare'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        WordWrap = True
      end
      object lblElemRiquadro10: TLabel
        Left = 300
        Top = 78
        Width = 69
        Height = 14
        AutoSize = False
        Caption = ' XXX'
        Color = clAqua
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = False
      end
      object Riquadro9: TShape
        Left = 10
        Top = 77
        Width = 71
        Height = 48
      end
      object lblRiquadro9: TLabel
        Left = 87
        Top = 77
        Width = 200
        Height = 48
        AutoSize = False
        Caption = 'Assenza richiesta dal dipendente e da autorizzare'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        WordWrap = True
      end
      object Riquadro12: TShape
        Left = 10
        Top = 137
        Width = 71
        Height = 48
      end
      object lblRiquadro12: TLabel
        Left = 88
        Top = 132
        Width = 200
        Height = 74
        AutoSize = False
        Caption = 
          'Assenza a giornata parziale, la lettera tra parentesi "T" indica' +
          ' il tipo:'#13#10'M: mezza giornata'#13#10'D: da ore - a ore'#13#10'N: numero di or' +
          'e'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        WordWrap = True
      end
      object lblElemRiquadro9: TLabel
        Left = 11
        Top = 78
        Width = 69
        Height = 14
        AutoSize = False
        Caption = ' XXX(T)'
        Color = 55552
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = False
      end
      object lblRiquadro11: TLabel
        Left = 376
        Top = 136
        Width = 200
        Height = 66
        AutoSize = False
        Caption = 
          'Assenza a giornata parziale da validare, la lettera tra parentes' +
          'i "T" indica il tipo:'#13#10'M: mezza giornata'#13#10'D: da ore - a ore'#13#10'N: ' +
          'numero di ore'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        WordWrap = True
      end
      object Riquadro11: TShape
        Left = 299
        Top = 137
        Width = 71
        Height = 48
      end
      object lblElemRiquadro11: TLabel
        Left = 300
        Top = 138
        Width = 69
        Height = 14
        AutoSize = False
        Caption = ' XXX(T)'
        Color = 16777164
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = False
      end
      object lblElemRiquadro12: TLabel
        Left = 11
        Top = 138
        Width = 69
        Height = 14
        AutoSize = False
        Caption = ' XXX(T)'
        Color = 14465535
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = False
      end
      object lblRiquadro8: TLabel
        Left = 376
        Top = 13
        Width = 200
        Height = 63
        AutoSize = False
        Caption = 
          'Assenza non operativa a giornata intera aggiunta mediante pianif' +
          'icazione (solo in modalit'#224' "Gestione assenze" non operativa)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        WordWrap = True
      end
      object Riquadro8: TShape
        Left = 299
        Top = 18
        Width = 71
        Height = 48
      end
      object lblElemRiquadro8: TLabel
        Left = 300
        Top = 19
        Width = 69
        Height = 14
        AutoSize = False
        Caption = ' XXX'
        Color = clRed
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = [fsItalic]
        ParentColor = False
        ParentFont = False
        Transparent = False
      end
    end
    object grpCelle: TGroupBox
      Left = 8
      Top = 5
      Width = 585
      Height = 128
      Caption = 'Celle tabellone'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object Riquadro1: TShape
        Left = 10
        Top = 17
        Width = 71
        Height = 48
      end
      object Riquadro2: TShape
        Left = 202
        Top = 17
        Width = 71
        Height = 48
        Brush.Color = 6939763
      end
      object Riquadro3: TShape
        Left = 394
        Top = 17
        Width = 71
        Height = 48
        Brush.Color = 8454143
      end
      object Riquadro4: TShape
        Left = 10
        Top = 71
        Width = 71
        Height = 48
        Brush.Color = 8454143
      end
      object Riquadro5: TShape
        Left = 202
        Top = 71
        Width = 71
        Height = 48
        Brush.Color = clAqua
      end
      object Riquadro6: TShape
        Left = 394
        Top = 71
        Width = 71
        Height = 48
        Brush.Color = 14540253
      end
      object lblElemRiquadro2: TLabel
        Left = 207
        Top = 18
        Width = 56
        Height = 14
        Caption = 'X (Y)ZZZ'
        Color = 6939763
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = False
      end
      object lblRiquadro1: TLabel
        Left = 87
        Top = 17
        Width = 109
        Height = 48
        AutoSize = False
        Caption = 'Non pianificato o riposo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        WordWrap = True
      end
      object lblRiquadro3: TLabel
        Left = 471
        Top = 17
        Width = 109
        Height = 48
        AutoSize = False
        Caption = 'Pianificato'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        WordWrap = True
      end
      object lblElemRiquadro3: TLabel
        Left = 399
        Top = 18
        Width = 56
        Height = 14
        Caption = 'X (Y)ZZZ'
        Color = 8454143
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = False
      end
      object lblRiquadro4: TLabel
        Left = 87
        Top = 71
        Width = 109
        Height = 48
        AutoSize = False
        Caption = 'Modificato (testo rosso)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        WordWrap = True
      end
      object lblRiquadro2: TLabel
        Left = 279
        Top = 17
        Width = 109
        Height = 48
        AutoSize = False
        Caption = 'Sviluppo turni'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        WordWrap = True
      end
      object lblRiquadro5: TLabel
        Left = 279
        Top = 71
        Width = 109
        Height = 48
        AutoSize = False
        Caption = 'Cambio squadra'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        WordWrap = True
      end
      object lblRiquadro6: TLabel
        Left = 473
        Top = 71
        Width = 109
        Height = 49
        AutoSize = False
        Caption = 'Non in squadra'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        WordWrap = True
      end
      object lblElemRiquadro4: TLabel
        Left = 15
        Top = 72
        Width = 56
        Height = 14
        Caption = 'X (Y)ZZZ'
        Color = 8454143
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = False
      end
      object lblElemRiquadro5: TLabel
        Left = 207
        Top = 72
        Width = 56
        Height = 14
        Caption = 'X (Y)ZZZ'
        Color = clAqua
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = False
      end
    end
    object grpFlag: TGroupBox
      Left = 8
      Top = 369
      Width = 585
      Height = 130
      Caption = 'Contenuto delle celle - Flag e reperibilit'#224
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      object Riquadro13: TShape
        Left = 10
        Top = 17
        Width = 71
        Height = 48
      end
      object lblRiquadro13: TLabel
        Left = 87
        Top = 17
        Width = 200
        Height = 48
        AutoSize = False
        Caption = 'Presenza di un turno di reperibilit'#224
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        WordWrap = True
      end
      object lblElemRiquadro13: TLabel
        Left = 68
        Top = 50
        Width = 12
        Height = 14
        Alignment = taCenter
        AutoSize = False
        Caption = 'R'
        Color = clBlue
        Font.Charset = ANSI_CHARSET
        Font.Color = clYellow
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = False
      end
      object Riquadro14: TShape
        Left = 298
        Top = 17
        Width = 71
        Height = 48
      end
      object lblRiquadro14: TLabel
        Left = 375
        Top = 17
        Width = 200
        Height = 48
        AutoSize = False
        Caption = 'A: antincendio'#13#10'R: referente turno'#13#10'T: richiesto da turnista'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        WordWrap = True
      end
      object Riquadro15: TShape
        Left = 10
        Top = 71
        Width = 71
        Height = 48
      end
      object lblRiquadro15: TLabel
        Left = 87
        Top = 71
        Width = 200
        Height = 48
        AutoSize = False
        Caption = 'Nota'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        WordWrap = True
      end
      object Riquadro16: TShape
        Left = 298
        Top = 72
        Width = 71
        Height = 48
      end
      object lblRiquadro16: TLabel
        Left = 375
        Top = 72
        Width = 200
        Height = 49
        AutoSize = False
        Caption = 'Anomalia'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        WordWrap = True
      end
      object lblElem1Riquadro14: TLabel
        Left = 299
        Top = 18
        Width = 11
        Height = 17
        Alignment = taCenter
        AutoSize = False
        Caption = 'A'
        Color = 42495
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = False
      end
      object lblElem2Riquadro14: TLabel
        Left = 316
        Top = 18
        Width = 11
        Height = 17
        Alignment = taCenter
        AutoSize = False
        Caption = 'R'
        Color = clFuchsia
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = False
      end
      object lblElem3Riquadro14: TLabel
        Left = 333
        Top = 18
        Width = 11
        Height = 17
        Alignment = taCenter
        AutoSize = False
        Caption = 'T'
        Color = clLime
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = False
      end
      object imgElemRiquadro15: TImage
        Left = 72
        Top = 72
        Width = 8
        Height = 8
        Picture.Data = {
          0954506E67496D61676589504E470D0A1A0A0000000D49484452000000080000
          00080806000000C40FBE8B000000017352474200AECE1CE90000000467414D41
          0000B18F0BFC6105000000097048597300000EC300000EC301C76FA864000000
          1974455874536F667477617265007061696E742E6E657420342E302E3139D4D6
          B264000000394944415478DA636460F8FF9F010F608450B815312298D815212B
          00B1FF6128F80FD4C8C888A40ECD24B00230038722B8025C8A501460530400F7
          A91BF95FDA29DE0000000049454E44AE426082}
      end
      object imgElemRiquadro16: TImage
        Left = 299
        Top = 73
        Width = 8
        Height = 8
        Picture.Data = {
          0954506E67496D61676589504E470D0A1A0A0000000D49484452000000080000
          00080806000000C40FBE8B000000017352474200AECE1CE90000000467414D41
          0000B18F0BFC6105000000097048597300000EC300000EC301C76FA864000000
          1974455874536F667477617265007061696E742E6E657420342E302E3139D4D6
          B264000000374944415478DA7D8C410E00200CC2C0FFFF19378D263343C2AD05
          0A88FAF027306A05AE9A074263A34638CB8CA42ABCB03C74F00A0E6626F5B71D
          FB7C1E41D10000000049454E44AE426082}
      end
    end
  end
end
