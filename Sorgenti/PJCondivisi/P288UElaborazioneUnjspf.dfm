object P288FElaborazioneUnjspf: TP288FElaborazioneUnjspf
  Left = 0
  Top = 0
  HelpContext = 3288000
  Caption = '<P288> Elaborazione UNJSPF'
  ClientHeight = 444
  ClientWidth = 584
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 584
    Height = 27
    Align = alTop
    TabOrder = 0
    TabStop = True
    ExplicitWidth = 584
    ExplicitHeight = 27
    inherited pnlSelAnagrafe: TPanel
      Width = 584
      Height = 27
      ExplicitWidth = 584
      ExplicitHeight = 27
      inherited btnPrimo: TSpeedButton
        Left = 78
        Width = 21
        Height = 20
        ExplicitLeft = 78
        ExplicitWidth = 21
        ExplicitHeight = 20
      end
      inherited btnPrecedente: TSpeedButton
        Left = 99
        Width = 22
        Height = 20
        ExplicitLeft = 99
        ExplicitWidth = 22
        ExplicitHeight = 20
      end
      inherited btnSuccessivo: TSpeedButton
        Left = 121
        Width = 21
        Height = 20
        ExplicitLeft = 121
        ExplicitWidth = 21
        ExplicitHeight = 20
      end
      inherited btnUltimo: TSpeedButton
        Left = 142
        Width = 21
        Height = 20
        ExplicitLeft = 142
        ExplicitWidth = 21
        ExplicitHeight = 20
      end
      inherited lblDipendente: TLabel
        Left = 168
        Width = 65
        Height = 12
        Font.Height = -9
        ExplicitLeft = 168
        ExplicitWidth = 65
        ExplicitHeight = 12
      end
      inherited btnSelezione: TBitBtn
        Left = 1
        Width = 21
        Height = 20
        OnClick = frmSelAnagrafebtnSelezioneClick
        ExplicitLeft = 1
        ExplicitWidth = 21
        ExplicitHeight = 20
      end
      inherited btnRicerca: TBitBtn
        Left = 50
        Width = 22
        Height = 20
        ExplicitLeft = 50
        ExplicitWidth = 22
        ExplicitHeight = 20
      end
      inherited btnEreditaSelezione: TBitBtn
        Left = 21
        Width = 22
        Height = 20
        ExplicitLeft = 21
        ExplicitWidth = 22
        ExplicitHeight = 20
      end
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 425
    Width = 584
    Height = 19
    Panels = <
      item
        Width = 100
      end
      item
        Width = 50
      end>
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 407
    Width = 584
    Height = 18
    Align = alBottom
    TabOrder = 2
  end
  object pnlPulsanti: TPanel
    Left = 0
    Top = 365
    Width = 584
    Height = 42
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object BChiudi: TBitBtn
      Left = 468
      Top = 10
      Width = 84
      Height = 24
      Caption = '&Chiudi'
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 0
    end
    object btnEsegui: TBitBtn
      Left = 50
      Top = 10
      Width = 84
      Height = 24
      Caption = 'Esegui'
      Enabled = False
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000C40E0000C40E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFF808
        8FFF0FFFFFFF003000FFB0FFFFF0B333300F8B0FFFF0BB883088F8B0FF0BB0F8
        3300F8BB0FF0B0003088888BB0F0BB3BB00FBBBBBB0F00B000FF8BBB0088FF00
        FFFFF8BBB0FFFFFFFFFFFF8BBB0FFFFFFFFF8888BBB0FFFFFFFFF8BBBBBB0FFF
        FFFFFF8BBB0000FFFFFFFFF8BBB0FFFFFFFFFFFF8BBB0FFFFFFF}
      TabOrder = 1
      OnClick = btnEseguiClick
    end
    object btnAnomalie: TBitBtn
      Left = 187
      Top = 10
      Width = 84
      Height = 24
      Caption = '&Anomalie'
      Enabled = False
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333FFFFF3333333333F797F3333333333F737373FF333333BFB999BFB
        33333337737773773F3333BFBF797FBFB33333733337333373F33BFBFBFBFBFB
        FB3337F33333F33337F33FBFBFB9BFBFBF3337333337F333373FFBFBFBF97BFB
        FBF37F333337FF33337FBFBFBFB99FBFBFB37F3333377FF3337FFBFBFBFB99FB
        FBF37F33333377FF337FBFBF77BF799FBFB37F333FF3377F337FFBFB99FB799B
        FBF373F377F3377F33733FBF997F799FBF3337F377FFF77337F33BFBF99999FB
        FB33373F37777733373333BFBF999FBFB3333373FF77733F7333333BFBFBFBFB
        3333333773FFFF77333333333FBFBF3333333333377777333333}
      NumGlyphs = 2
      TabOrder = 2
      OnClick = btnAnomalieClick
    end
    object btnInformazioni: TBitBtn
      Left = 323
      Top = 9
      Width = 90
      Height = 25
      Caption = '&Informazioni'
      Enabled = False
      Glyph.Data = {
        BE060000424DBE06000000000000360400002800000024000000120000000100
        08000000000088020000C40E0000C40E000000010000000100006F5912007561
        3E007F7F7F009A5F000084551100A15D0000996B0C0090681000A5600000A668
        0E00AD6F0900B1670000A4700C00BE750100B6720900A3671300A56A1400A273
        1700AF771200AB721700B0751800B97D1900835E2200946C2B009A6C2C008770
        2C008B702D00957125009A75230082623700966E390085723F00907434009C75
        31009F75300094723C0093743F0098713A00AF7A2300A4702900A47A2D00AD7A
        2A00AB7D2900B37C2B00A3773700AF7E3A00C1780600C37C0D00C57F0D00CC7F
        0B009E79410092754E00847457008A7451008F79550091785000987F5300987E
        5600AF811C00B8841900BF881900B0852400B7842600B7872700BA8A2400BF8B
        2700B0842B00B58A2900BB8A2800BB902F00A5803000A6803200A9873400AC88
        3A00B6813100BD853300B3823E00B88A3D00D6890F00CE861600C28C2100D294
        2800C0883600C48D3800CF953600D0A23D00E7A63900968253009E815A00AB85
        4400BB8B4900BA8D4A00BC904300A3835200A58A5100A48E5400A38A5800A38C
        5E00AB895B00AC8B5A00AC915900B9915700BF99580096826900A1866400A88C
        6300AE8D6000A88B6600A38C6C00A58D6F00A88E6900B0916400B2936600AB96
        7700A8947B00C4904400CA964300C4964F00C89A4D00C7995200C59E5300CC9D
        5900DCA75700D5A75900CA9F6000C5A66100C9A26B00C9A36D00DCB86C00C7A8
        7500D8B57D00E0B87000E8C1730000808000A3938200A5968600B9A38A00B8A6
        8F00D9BD8100DEC58500E3C48700FBD78B00FBD7A100FFDFA300F5D8AB00F8E2
        AE00FFFAA200FFF2A800FFECBD00FFFFB200FFFFBE00FFFFC200FFFFC600FFFF
        CE00FFFFFF000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000858585858585
        8585858585858585858585858585858585858585858585858585858585858585
        8585858585850019858585858585858585858585858585850202858585858585
        858585858585858584114043468A85858585858585858585858502029A9A0202
        85858585858585858585858006503C3B3D488B85858585858585858585029A9A
        9A9A9A9A028585858585858585858C1B0745553A3F4247858585858585858585
        029A9A9A9A9A9A9A9A0285858585858585822178491C9295440C3E2A83858585
        858585029A9A9A9A02029A9A9A9A028585858585657776287D1A93964151560A
        266685858585029A9A9A9A9A02029A9A9A9A9A02858585855A4A745C205F998D
        12300B2F542285858585029A9A9A9A9A02029A9A9A9A9A028585851D2D4B537B
        5E1F9997150D4E4F1317018585029A9A9A9A9A9A02029A9A9A9A9A9A02858535
        7C7A524D64579198032E31052923348585029A9A9A9A9A9A02029A9A9A9A9A9A
        028585856379737524616059140E0810163685858585029A9A9A9A9A9A9A9A9A
        9A9A9A0285858585857E5B2C8138948F2B090F0437858585858585029A9A9A9A
        02029A9A9A9A02858585858585857F327069908E4C27185D8585858585858585
        029A9A9A02029A9A9A028585858585858585856F396E586A1E25628585858585
        8585858585029A9A9A9A9A9A028585858585858585858585716D6C68336B8585
        85858585858585858585029A9A9A9A0285858585858585858585858585897267
        888585858585858585858585858585029A9A0285858585858585858585858585
        8585868785858585858585858585858585858585020285858585858585858585
        8585858585858585858585858585858585858585858585858585858585858585
        8585}
      NumGlyphs = 2
      TabOrder = 3
      OnClick = btnAnomalieClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 27
    Width = 584
    Height = 338
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    object Label2: TLabel
      Left = 375
      Top = 132
      Width = 44
      Height = 39
      Caption = 'Tabelle da elaborare'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -9
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object sbtMeseElaborazione: TSpeedButton
      Left = 208
      Top = 31
      Width = 15
      Height = 21
      Caption = '...'
      NumGlyphs = 2
      OnClick = sbtMeseElaborazioneClick
    end
    object lblMeseElaborazione: TLabel
      Left = 50
      Top = 35
      Width = 89
      Height = 13
      Caption = 'Mese elaborazione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object sbtDataChiusura: TSpeedButton
      Left = 344
      Top = 263
      Width = 14
      Height = 21
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      NumGlyphs = 2
      ParentFont = False
      OnClick = sbtDataChiusuraClick
    end
    object lblDataChiusura: TLabel
      Left = 181
      Top = 266
      Width = 66
      Height = 13
      Caption = 'Data chiusura'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblDataEsportazione: TLabel
      Left = 181
      Top = 296
      Width = 86
      Height = 13
      Caption = 'Data esportazione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object sbtDataEsportazione: TSpeedButton
      Left = 344
      Top = 293
      Width = 14
      Height = 21
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      NumGlyphs = 2
      ParentFont = False
      OnClick = sbtDataEsportazioneClick
    end
    object lblDataInizioEstraz: TLabel
      Left = 50
      Top = 92
      Width = 83
      Height = 13
      Caption = 'Data inizio storico'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object sbtDataInizioEstraz: TSpeedButton
      Left = 225
      Top = 89
      Width = 14
      Height = 21
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      NumGlyphs = 2
      ParentFont = False
      OnClick = sbtDataInizioEstrazClick
    end
    object lblDataElaborazione: TLabel
      Left = 50
      Top = 63
      Width = 86
      Height = 13
      Caption = 'Data elaborazione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object sbtDataElaborazione: TSpeedButton
      Left = 225
      Top = 60
      Width = 14
      Height = 21
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      NumGlyphs = 2
      ParentFont = False
      OnClick = sbtDataElaborazioneClick
    end
    object chkCalcola: TCheckBox
      Left = 50
      Top = 132
      Width = 126
      Height = 16
      Caption = 'Calcola dati UNJSPF'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -9
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = chkCalcolaClick
    end
    object chklstTabelle: TCheckListBox
      Left = 426
      Top = 132
      Width = 126
      Height = 188
      ItemHeight = 13
      TabOrder = 7
    end
    object chkAnnulla: TCheckBox
      Left = 50
      Top = 163
      Width = 126
      Height = 16
      Caption = 'Annulla dati UNJSPF'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -9
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = chkCalcolaClick
    end
    object chkChiusura: TCheckBox
      Left = 50
      Top = 266
      Width = 71
      Height = 16
      Caption = 'Chiusura'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -9
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      OnClick = chkCalcolaClick
    end
    object chkPulisci: TCheckBox
      Left = 50
      Top = 193
      Width = 92
      Height = 16
      Caption = 'Svuota tabelle'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -9
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnClick = chkCalcolaClick
    end
    object chkEsportazione: TCheckBox
      Left = 50
      Top = 296
      Width = 92
      Height = 16
      Caption = 'Esportazione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -9
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      OnClick = chkCalcolaClick
    end
    object edtMeseElaborazione: TMaskEdit
      Left = 153
      Top = 31
      Width = 56
      Height = 21
      EditMask = '!00/0000;1;_'
      MaxLength = 7
      TabOrder = 0
      Text = '  /    '
    end
    object edtDataChiusura: TMaskEdit
      Left = 272
      Top = 263
      Width = 71
      Height = 21
      EditMask = '!00/00/0000;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 9
      Text = '  /  /    '
    end
    object edtDataEsportazione: TMaskEdit
      Left = 272
      Top = 293
      Width = 71
      Height = 21
      EditMask = '!00/00/0000;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 11
      Text = '  /  /    '
    end
    object edtDataInizioEstraz: TMaskEdit
      Left = 153
      Top = 89
      Width = 71
      Height = 21
      EditMask = '!00/00/0000;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 3
      Text = '  /  /    '
    end
    object rgpStatoCedolini: TRadioGroup
      Left = 278
      Top = 18
      Width = 274
      Height = 34
      Caption = 'Stato cedolini da considerare'
      Columns = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Solo chiusi'
        'Chiusi e aperti'
        'Solo aperti')
      ParentFont = False
      TabOrder = 1
    end
    object edtDataElaborazione: TMaskEdit
      Left = 153
      Top = 60
      Width = 71
      Height = 21
      EditMask = '!00/00/0000;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 2
      Text = '  /  /    '
    end
  end
end
