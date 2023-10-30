object A058FDialogStampa: TA058FDialogStampa
  Left = 135
  Top = 216
  ActiveControl = edtMargineSx
  BorderStyle = bsDialog
  Caption = '<A058> Impostazioni del tabellone turni'
  ClientHeight = 425
  ClientWidth = 435
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 4
    Top = 1
    Width = 29
    Height = 13
    Caption = 'Titolo:'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Label2: TLabel
    Left = 4
    Top = 40
    Width = 98
    Height = 13
    Caption = 'Nota a pi'#232' di pagina:'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Label3: TLabel
    Left = 4
    Top = 77
    Width = 67
    Height = 13
    Caption = 'Descrizione 1:'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Label4: TLabel
    Left = 219
    Top = 77
    Width = 67
    Height = 13
    Caption = 'Descrizione 2:'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Label5: TLabel
    Left = 8
    Top = 354
    Width = 95
    Height = 13
    Caption = 'Num.giorni per pag.:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object LblSizeFont: TLabel
    Left = 8
    Top = 329
    Width = 82
    Height = 13
    Caption = 'Dimensione Font:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 8
    Top = 302
    Width = 54
    Height = 13
    Caption = 'Margine sx:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblOriPagina: TLabel
    Left = 182
    Top = 355
    Width = 101
    Height = 13
    Caption = 'Orientamente pagina:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object btnStampa: TBitBtn
    Left = 97
    Top = 380
    Width = 75
    Height = 25
    Caption = 'Stampa'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
      0003377777777777777308888888888888807F33333333333337088888888888
      88807FFFFFFFFFFFFFF7000000000000000077777777777777770F8F8F8F8F8F
      8F807F333333333333F708F8F8F8F8F8F9F07F333333333337370F8F8F8F8F8F
      8F807FFFFFFFFFFFFFF7000000000000000077777777777777773330FFFFFFFF
      03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
      03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
      33333337F3F37F3733333330F08F0F0333333337F7337F7333333330FFFF0033
      33333337FFFF7733333333300000033333333337777773333333}
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 16
    OnClick = btnStampaClick
  end
  object BitBtn2: TBitBtn
    Left = 355
    Top = 380
    Width = 75
    Height = 25
    Caption = '&Chiudi'
    Kind = bkClose
    TabOrder = 18
  end
  object BitBtn3: TBitBtn
    Left = 4
    Top = 380
    Width = 87
    Height = 25
    Caption = 'Stampante'
    Default = True
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FF0000000000
      0FFFF0777777777070FF000000000000070F0778777BBB87000F077887788887
      070F00000000000007700778888778807070F000000000070700FF0777777770
      7070FFF077777776EEE0F8000000000E6008F0E6EEEEEEEE0FFFF8000000000E
      6008FFFF07777786EEE0FFFFF00000080008FFFFFFFFFFFFFFFF}
    TabOrder = 15
    OnClick = BitBtn3Click
  end
  object ETitolo: TEdit
    Left = 4
    Top = 16
    Width = 423
    Height = 21
    TabOrder = 0
    Text = 'Tabellone turni'
  end
  object ENota: TEdit
    Left = 4
    Top = 56
    Width = 423
    Height = 21
    TabOrder = 1
    Text = 
      'NOTA: Ogni richiesta di variazione al presente turno dovr'#224' esser' +
      'e trasmessa a questo ufficio'
  end
  object EDesc1: TEdit
    Left = 4
    Top = 93
    Width = 208
    Height = 21
    TabOrder = 2
    Text = 'L'#39'UFFICIO DEL PERSONALE'
  end
  object EDesc2: TEdit
    Left = 219
    Top = 93
    Width = 208
    Height = 21
    TabOrder = 3
    Text = 'IL DIRETTORE SANITARIO'
  end
  object btnAnteprima: TBitBtn
    Left = 178
    Top = 380
    Width = 82
    Height = 25
    Caption = 'Anteprima'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
      FFFF000000000000FF000FFFFFFFFFF0F0000FFFFFFF0000800F0FFFFFF08778
      08FF0FFFFF0877E880FF0FFFFF07777870FF0FFFFF07E77870FF0FFFFF08EE78
      80FF0FFFFFF087780FFF0FFFFFFF0000FFFF0FFFFFFFFFF0FFFF0FFFFFFF0000
      FFFF0FFFFFFF070FFFFF0FFFFFFF00FFFFFF000000000FFFFFFF}
    ParentFont = False
    TabOrder = 17
    OnClick = btnStampaClick
  end
  object RG1: TRadioGroup
    Left = 4
    Top = 115
    Width = 193
    Height = 34
    Caption = 'Tipo stampa'
    Columns = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'Sintetica'
      'Dettagliata')
    ParentFont = False
    TabOrder = 4
  end
  object RadioGroup2: TRadioGroup
    Left = 4
    Top = 149
    Width = 423
    Height = 34
    Caption = 'Ordinamento'
    Columns = 4
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'Cognome'
      'Squadra/Operatore'
      'Turno di partenza'
      'Turno pianificato')
    ParentFont = False
    TabOrder = 6
  end
  object PG1: TProgressBar
    Left = 0
    Top = 409
    Width = 435
    Height = 16
    Align = alBottom
    TabOrder = 19
  end
  object RG3: TRadioGroup
    Left = 4
    Top = 182
    Width = 423
    Height = 38
    Columns = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemIndex = 1
    Items.Strings = (
      'Stampa preventiva (da pianificaz.)'
      'Stampa consuntiva (da conteggi)')
    ParentFont = False
    TabOrder = 7
    OnClick = RG3Click
  end
  object GroupBox1: TGroupBox
    Left = 5
    Top = 220
    Width = 422
    Height = 75
    Caption = 'Dati opzionali da stampare'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    object ChkTotTurno: TCheckBox
      Left = 11
      Top = 16
      Width = 95
      Height = 17
      Caption = 'Totali per turno'
      TabOrder = 0
    end
    object ChkDettaglioOrari: TCheckBox
      Left = 163
      Top = 16
      Width = 87
      Height = 17
      Caption = 'Dettaglio orari'
      TabOrder = 2
    end
    object ChkAssenze: TCheckBox
      Left = 295
      Top = 16
      Width = 63
      Height = 17
      Caption = 'Assenze'
      TabOrder = 4
    end
    object ChkSaldi: TCheckBox
      Left = 295
      Top = 33
      Width = 78
      Height = 17
      Caption = 'Saldi ore'
      TabOrder = 5
    end
    object ChkTotaleTurni: TCheckBox
      Left = 163
      Top = 33
      Width = 122
      Height = 17
      Caption = 'Totale turni nel mese'
      TabOrder = 3
    end
    object chkTotOper: TCheckBox
      Left = 11
      Top = 33
      Width = 146
      Height = 17
      Caption = 'Totali turno per operatori'
      TabOrder = 1
    end
    object chkLiquid: TCheckBox
      Left = 11
      Top = 51
      Width = 97
      Height = 17
      Caption = 'Totali liquidabile'
      TabOrder = 6
    end
    object chkTotGenTurni: TCheckBox
      Left = 163
      Top = 51
      Width = 126
      Height = 17
      Caption = 'Totale copertura turni'
      TabOrder = 7
    end
  end
  object edtNumGG: TSpinEdit
    Left = 106
    Top = 351
    Width = 41
    Height = 22
    MaxValue = 31
    MinValue = 1
    TabOrder = 11
    Value = 1
  end
  object chkSepColonne: TCheckBox
    Left = 285
    Top = 302
    Width = 137
    Height = 13
    Caption = 'Separatore di colonne'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 12
  end
  object chkSepRighe: TCheckBox
    Left = 285
    Top = 321
    Width = 137
    Height = 17
    Caption = 'Separatore di righe'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 13
  end
  object SEdtFontSize: TSpinEdit
    Left = 106
    Top = 324
    Width = 41
    Height = 22
    MaxValue = 13
    MinValue = 6
    TabOrder = 10
    Value = 8
  end
  object edtMargineSx: TSpinEdit
    Left = 106
    Top = 297
    Width = 41
    Height = 22
    MaxValue = 500
    MinValue = 0
    TabOrder = 9
    Value = 5
  end
  object cmbOriPagina: TComboBox
    Left = 285
    Top = 352
    Width = 142
    Height = 22
    Style = csOwnerDrawFixed
    ItemIndex = 0
    TabOrder = 14
    Text = 'Automatico'
    Items.Strings = (
      'Automatico'
      'Verticale'
      'Orizzontale')
  end
  object rgpRigheDip: TRadioGroup
    Left = 203
    Top = 115
    Width = 224
    Height = 34
    Caption = 'Righe per dipendente'
    Columns = 3
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Items.Strings = (
      '2'
      '3'
      '4')
    ParentFont = False
    TabOrder = 5
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 319
    Top = 380
  end
end
