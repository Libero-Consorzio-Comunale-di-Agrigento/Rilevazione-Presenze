object A042FImpostazioniGrafico: TA042FImpostazioniGrafico
  Left = 222
  Top = 178
  HelpContext = 42000
  BorderIcons = [biSystemMenu]
  Caption = '<A042> Impostazione colori del grafico'
  ClientHeight = 287
  ClientWidth = 398
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 120
    Width = 392
    Height = 111
    Align = alTop
    Caption = 'Causali di assenza '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    ExplicitLeft = 4
    ExplicitTop = 112
    ExplicitWidth = 393
    object Label1: TLabel
      Left = 17
      Top = 27
      Width = 41
      Height = 13
      Caption = 'Causale:'
    end
    object Label4: TLabel
      Left = 17
      Top = 67
      Width = 33
      Height = 13
      Caption = 'Colore:'
    end
    object DbLblDescAssenza: TDBText
      Left = 75
      Top = 48
      Width = 163
      Height = 12
      DataField = 'DESCRIZIONE'
      DataSource = A042FStampaPreAssMW.dscT265
    end
    object edtColoreAssenza: TEdit
      Left = 72
      Top = 64
      Width = 170
      Height = 21
      TabStop = False
      ReadOnly = True
      TabOrder = 0
    end
    object BtnColoreAssenza: TButton
      Left = 223
      Top = 66
      Width = 17
      Height = 17
      Caption = '...'
      TabOrder = 1
      OnClick = BtnColoreAssenzaClick
    end
    object BtnSalvaAssenze: TBitBtn
      Left = 269
      Top = 15
      Width = 112
      Height = 25
      Caption = 'Salva colori'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        04000000000068010000120B0000120B00001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333333333333333
        0000333333333333333333333333333333333333000033000000000000003333
        00000000000000330000330CC000000770C0333308800000077080330000330C
        C000000770C0333308800000077080330000330CC000000770C0333308800000
        077080330000330CC000000000C0333308800000000080330000330CCCCCCCCC
        CCC0333308888888888880330000330CC00000000CC033330880000000088033
        0000330C0777777770C0333308077777777080330000330C0777777770C03333
        08077777777080330000330C0777777770C0333308077777777080330000330C
        0777777770C0333308077777777080330000330C077777777000333308077777
        777000330000330C0777777770C0333308077777777070330000330000000000
        0000333300000000000000330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 2
      OnClick = BtnSalvaAssenzeClick
    end
    object BtnCancellaAssenze: TBitBtn
      Left = 269
      Top = 47
      Width = 112
      Height = 25
      Caption = 'Ripulisci colori'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        04000000000068010000120B0000120B00001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333333333333333
        0000333333333333333333333333333333333333000033333333333333333333
        333333333333333300003330000000333333333330000000333333330000330B
        BBBBB0033333333307777770033333330000330BBBBBB0B03333333307777770
        70333333000033033333303B03333333077777707803333300003330BBBBBB0B
        3033333330F7FFF707803333000033330BBBBBB03B033333330FFF7FF0780333
        0000333330BBBBBB0B3033333330F7FFF707803300003333330BBBBBB0303333
        33330FFF7FF07033000033333330BBBBBB003333333330F7FFF7003300003333
        33330BBBBBB033333333330FFF7FF03300003333333330000003333333333330
        0000033300003333333333333333333333333333333333330000333333333333
        3333333333333333333333330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 3
      OnClick = BtnCancellaAssenzeClick
    end
    object BtnImportaAssenze: TBitBtn
      Left = 269
      Top = 79
      Width = 112
      Height = 25
      Caption = 'Importa colori'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        04000000000068010000120B0000120B00001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000300000833333333333300000833333333333
        00003330B0000833333333333070000833333333000033330B30008333333333
        330F8000833333330000333330B3000033333333333078000033333300003333
        30BB3300333333333330F7880033333300003333330BB3300333333333330F78
        800333330000300000000030803333300000000080803333000030EEEEEEE000
        B70033307778777000770033000030EE888EE030B00003307888887030F00003
        000030EEEEEEE03300910330777777703300800300003000EEE0003330111330
        007870003330080300003330EEE0333333019333307770333333008300003300
        EEE003333330133300787003333330030000330EEEEE03333333033307777703
        3333330300003300000003333333333300000003333333330000333333333333
        3333333333333333333333330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 4
      OnClick = BtnImportaAssenzeClick
    end
    object DbCmbAssenza: TDBLookupComboBox
      Left = 72
      Top = 24
      Width = 169
      Height = 21
      DropDownWidth = 300
      KeyField = 'CODICE'
      ListField = 'CODICE; DESCRIZIONE'
      ListSource = A042FStampaPreAssMW.dscT265
      TabOrder = 5
      OnClick = DbCmbAssenzaClick
      OnKeyDown = DbCmbPresenzaKeyDown
    end
  end
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 392
    Height = 111
    Align = alTop
    Caption = 'Causali di presenza '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    ExplicitLeft = -3
    ExplicitTop = -3
    ExplicitWidth = 398
    object Label2: TLabel
      Left = 17
      Top = 27
      Width = 41
      Height = 13
      Caption = 'Causale:'
    end
    object Label3: TLabel
      Left = 17
      Top = 67
      Width = 33
      Height = 13
      Caption = 'Colore:'
    end
    object DbLblDescPresenza: TDBText
      Left = 75
      Top = 48
      Width = 163
      Height = 12
      DataField = 'DESCRIZIONE'
    end
    object edtColorePresenza: TEdit
      Left = 72
      Top = 64
      Width = 170
      Height = 21
      TabStop = False
      ReadOnly = True
      TabOrder = 0
    end
    object BtnColorePresenza: TButton
      Left = 223
      Top = 66
      Width = 17
      Height = 17
      Caption = '...'
      TabOrder = 1
      OnClick = BtnColorePresenzaClick
    end
    object BtnSalvaPresenze: TBitBtn
      Left = 269
      Top = 15
      Width = 112
      Height = 25
      Caption = 'Salva colori'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        04000000000068010000120B0000120B00001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333333333333333
        0000333333333333333333333333333333333333000033000000000000003333
        00000000000000330000330CC000000770C0333308800000077080330000330C
        C000000770C0333308800000077080330000330CC000000770C0333308800000
        077080330000330CC000000000C0333308800000000080330000330CCCCCCCCC
        CCC0333308888888888880330000330CC00000000CC033330880000000088033
        0000330C0777777770C0333308077777777080330000330C0777777770C03333
        08077777777080330000330C0777777770C0333308077777777080330000330C
        0777777770C0333308077777777080330000330C077777777000333308077777
        777000330000330C0777777770C0333308077777777070330000330000000000
        0000333300000000000000330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 2
      OnClick = BtnSalvaPresenzeClick
    end
    object BtnCancellaPresenze: TBitBtn
      Left = 269
      Top = 47
      Width = 112
      Height = 25
      Caption = 'Ripulisci colori'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        04000000000068010000120B0000120B00001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333333333333333
        0000333333333333333333333333333333333333000033333333333333333333
        333333333333333300003330000000333333333330000000333333330000330B
        BBBBB0033333333307777770033333330000330BBBBBB0B03333333307777770
        70333333000033033333303B03333333077777707803333300003330BBBBBB0B
        3033333330F7FFF707803333000033330BBBBBB03B033333330FFF7FF0780333
        0000333330BBBBBB0B3033333330F7FFF707803300003333330BBBBBB0303333
        33330FFF7FF07033000033333330BBBBBB003333333330F7FFF7003300003333
        33330BBBBBB033333333330FFF7FF03300003333333330000003333333333330
        0000033300003333333333333333333333333333333333330000333333333333
        3333333333333333333333330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 3
      OnClick = BtnCancellaPresenzeClick
    end
    object BtnImportaPresenze: TBitBtn
      Left = 269
      Top = 79
      Width = 112
      Height = 25
      Caption = 'Importa colori'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        04000000000068010000120B0000120B00001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000300000833333333333300000833333333333
        00003330B0000833333333333070000833333333000033330B30008333333333
        330F8000833333330000333330B3000033333333333078000033333300003333
        30BB3300333333333330F7880033333300003333330BB3300333333333330F78
        800333330000300000000030803333300000000080803333000030EEEEEEE000
        B70033307778777000770033000030EE888EE030B00003307888887030F00003
        000030EEEEEEE03300910330777777703300800300003000EEE0003330111330
        007870003330080300003330EEE0333333019333307770333333008300003300
        EEE003333330133300787003333330030000330EEEEE03333333033307777703
        3333330300003300000003333333333300000003333333330000333333333333
        3333333333333333333333330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 4
      OnClick = BtnImportaPresenzeClick
    end
    object DbCmbPresenza: TDBLookupComboBox
      Left = 72
      Top = 24
      Width = 169
      Height = 21
      DropDownWidth = 300
      KeyField = 'CODICE'
      ListField = 'CODICE; DESCRIZIONE'
      TabOrder = 5
      OnClick = DbCmbPresenzaClick
      OnKeyDown = DbCmbPresenzaKeyDown
    end
  end
  object BtnClose: TBitBtn
    Left = 168
    Top = 256
    Width = 75
    Height = 25
    Caption = '&Chiudi'
    Kind = bkClose
    NumGlyphs = 2
    TabOrder = 2
  end
  object ChkCausaliNonAbbinate: TCheckBox
    Left = 6
    Top = 236
    Width = 331
    Height = 17
    Caption = 
      'Visualizza nel grafico anche le causali non abbinate ad un color' +
      'e'
    Checked = True
    State = cbChecked
    TabOrder = 3
    OnClick = ChkCausaliNonAbbinateClick
  end
  object ColorDialogPresenza: TColorDialog
    Left = 371
    Top = 225
  end
  object ColorDialogAssenza: TColorDialog
    Left = 339
    Top = 225
  end
end