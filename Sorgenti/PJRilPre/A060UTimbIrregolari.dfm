object A060FTimbIrregolari: TA060FTimbIrregolari
  Left = 183
  Top = 147
  HelpContext = 60000
  Caption = '<A060> Timbrature irregolari'
  ClientHeight = 507
  ClientWidth = 742
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 34
    Width = 742
    Height = 156
    HorzScrollBar.Visible = False
    VertScrollBar.Visible = False
    Align = alTop
    BorderStyle = bsNone
    TabOrder = 1
    DesignSize = (
      742
      156)
    object Label2: TLabel
      Left = 8
      Top = 121
      Width = 41
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'Azienda:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ExplicitTop = 186
    end
    object LAzienda: TLabel
      Left = 90
      Top = 121
      Width = 3
      Height = 13
      Anchors = [akLeft, akBottom]
      ExplicitTop = 94
    end
    object Label3: TLabel
      Left = 8
      Top = 137
      Width = 78
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'Badge / Chiave:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ExplicitTop = 202
    end
    object LBadge: TLabel
      Left = 90
      Top = 137
      Width = 3
      Height = 13
      Anchors = [akLeft, akBottom]
      ExplicitTop = 110
    end
    object lblDalBadge: TLabel
      Left = 8
      Top = 5
      Width = 49
      Height = 13
      Caption = 'Dal badge'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblAlBadge: TLabel
      Left = 230
      Top = 5
      Width = 42
      Height = 13
      Caption = 'Al badge'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblDaChiave: TLabel
      Left = 8
      Top = 32
      Width = 49
      Height = 13
      Caption = 'Da chiave'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblAChiave: TLabel
      Left = 230
      Top = 32
      Width = 42
      Height = 13
      Caption = 'A chiave'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblAScarico: TLabel
      Left = 230
      Top = 59
      Width = 44
      Height = 13
      Caption = 'A scarico'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblDaScarico: TLabel
      Left = 8
      Top = 59
      Width = 51
      Height = 13
      Caption = 'Da scarico'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object BitBtn1: TBitBtn
      Left = 162
      Top = 89
      Width = 110
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Inizia recupero'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777808
        87770777777700300077B0777770B33330078B077770BB88308878B0770BB0F8
        330078BB0770B0003088888BB070BB3BB007BBBBBB0700B000778BBB00887700
        777778BBB07777777777778BBB07777777778888BBB07777777778BBBBBB0777
        7777778BBB00007777777778BBB07777777777778BBB07777777}
      ParentFont = False
      TabOrder = 7
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 624
      Top = 120
      Width = 110
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = '&Chiudi'
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 11
    end
    object BitBtn4: TBitBtn
      Left = 470
      Top = 89
      Width = 110
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Stampante...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00770000000000
        0777707777777770707700000000000007070778777BBB870007077887788887
        0707000000000000077007788887788070707000000000070700770777777770
        7070777077777776EEE078000000000E600870E6EEEEEEEE077778000000000E
        6008777707777786EEE077777000000800087777777777777777}
      ParentFont = False
      TabOrder = 9
      OnClick = BitBtn4Click
    end
    object BitBtn5: TBitBtn
      Left = 624
      Top = 89
      Width = 110
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Stampa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        42020000424D4202000000000000420000002800000010000000100000000100
        1000030000000002000000000000000000000000000000000000007C0000E003
        00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C00000000000000000000000000000000000000000000
        1F7C1F7C1F7C1F7C000018631863186318631863186318631863186300001863
        00001F7C1F7C0000000000000000000000000000000000000000000000000000
        186300001F7C0000186318631863186318631863E07FE07FE07F186318630000
        000000001F7C0000186318631863186318631863104210421042186318630000
        186300001F7C0000000000000000000000000000000000000000000000000000
        1863186300000000186318631863186318631863186318631863186300001863
        0000186300001F7C000000000000000000000000000000000000000018630000
        1863000000001F7C1F7C0000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F00001863
        0000186300001F7C1F7C1F7C0000FF7F00000000000000000000FF7F00000000
        000000001F7C1F7C1F7C1F7C0000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F0000
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000FF7F00000000000000000000FF7F0000
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
        00001F7C1F7C1F7C1F7C1F7C1F7C1F7C00000000000000000000000000000000
        00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C}
      ParentFont = False
      TabOrder = 10
      OnClick = BitBtn5Click
    end
    object btnCancella: TBitBtn
      Left = 316
      Top = 89
      Width = 110
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Cancella'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        7777777777770000777777777700778807777777007777880777770077277788
        0777778772222788807777872727278880777877277777888077787222722788
        807778772772278888077877722FFFF8880777777FF8888FF807777FF88F8FF8
        FF077FF88FFF8FF88877777FFFF8FFF87777FF77FF8FF8877777}
      ParentFont = False
      TabOrder = 8
      OnClick = btnCancellaClick
    end
    object cmbABadge: TComboBox
      Left = 286
      Top = 2
      Width = 138
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnChange = cmbDaBadgeChange
    end
    object cmbDaBadge: TComboBox
      Left = 72
      Top = 2
      Width = 138
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnChange = cmbDaBadgeChange
    end
    object btnRefresh: TBitBtn
      Left = 8
      Top = 89
      Width = 110
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Refresh'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFF2FFFFFFFFFFFFFF22FFFFFFFFFFFFF222222FFFFFFFFFFF22FFF
        2FFFFFFFFFFF2FFF2FFFFFFFFFFFFFFF2FFFFFFFFFFFFFFF2FFFFFFF2FFFFFFF
        FFFFFFFF2FFFFFFFFFFFFFFF2FFF2FFFFFFFFFFF2FFF22FFFFFFFFFFF222222F
        FFFFFFFFFFFF22FFFFFFFFFFFFFF2FFFFFFFFFFFFFFFFFFFFFFF}
      ParentFont = False
      TabOrder = 6
      OnClick = btnRefreshClick
    end
    object cmbDaChiave: TComboBox
      Left = 72
      Top = 29
      Width = 138
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 20
      ParentFont = False
      TabOrder = 2
      OnChange = cmbDaChiaveChange
    end
    object cmbAChiave: TComboBox
      Left = 286
      Top = 29
      Width = 138
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 20
      ParentFont = False
      TabOrder = 3
      OnChange = cmbAChiaveChange
    end
    object cmbDaScarico: TComboBox
      Left = 72
      Top = 56
      Width = 138
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 20
      ParentFont = False
      TabOrder = 4
      OnChange = cmbDaScaricoChange
    end
    object cmbAScarico: TComboBox
      Left = 286
      Top = 56
      Width = 138
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 20
      ParentFont = False
      TabOrder = 5
      OnChange = cmbAScaricoChange
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 190
    Width = 742
    Height = 298
    Align = alClient
    DataSource = A060FTimbIrregolariMW.DI101
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'DATA'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BADGE'
        Width = 55
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EDBADGE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CHIAVE'
        Width = 140
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ORA'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VERSO'
        Width = 40
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RILEV'
        Width = 58
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CAUSALE'
        Width = 56
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AZIENDE'
        Width = 56
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SCARICO'
        Width = 90
        Visible = True
      end>
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 488
    Width = 742
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  inline frmInputPeriodo: TfrmInputPeriodo
    Left = 0
    Top = 0
    Width = 742
    Height = 34
    Align = alTop
    Color = clBtnFace
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentBackground = False
    ParentColor = False
    ParentFont = False
    TabOrder = 0
    ExplicitWidth = 742
    ExplicitHeight = 34
    inherited lblInizio: TLabel
      Width = 48
      Caption = 'Dalla data'
      ExplicitWidth = 48
    end
    inherited lblFine: TLabel
      Left = 230
      Width = 41
      Caption = 'Alla data'
      ExplicitLeft = 230
      ExplicitWidth = 41
    end
    inherited edtInizio: TMaskEdit
      Left = 72
      OnExit = frmInputPeriodoedtInizioExit
      ExplicitLeft = 72
    end
    inherited edtFine: TMaskEdit
      Left = 286
      OnExit = frmInputPeriodoedtFineExit
      ExplicitLeft = 286
    end
    inherited btnIndietro: TBitBtn
      Left = 379
      OnClick = frmInputPeriodobtnIndietroClick
      ExplicitLeft = 379
    end
    inherited btnAvanti: TBitBtn
      Left = 401
      OnClick = frmInputPeriodobtnAvantiClick
      ExplicitLeft = 401
    end
    inherited btnDataInizio: TBitBtn
      Left = 143
      OnClick = frmInputPeriodobtnDataInizioClick
      ExplicitLeft = 143
    end
    inherited btnDataFine: TBitBtn
      Left = 357
      OnExit = frmInputPeriodobtnDataFineExit
      ExplicitLeft = 357
    end
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 380
    Top = 88
  end
end
