object A097FPianifLibProf: TA097FPianifLibProf
  Left = 142
  Top = 102
  HelpContext = 97000
  Caption = '<A097> Pianificazione libera professione'
  ClientHeight = 562
  ClientWidth = 593
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
  object pnlGestioneProfilo: TPanel
    Left = 0
    Top = 120
    Width = 593
    Height = 65
    Align = alTop
    TabOrder = 1
    Visible = False
    object Label4: TLabel
      Left = 22
      Top = 5
      Width = 29
      Height = 13
      Caption = 'Profilo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 118
      Top = 23
      Width = 32
      Height = 13
      Caption = 'Label3'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object EProfilo: TDBLookupComboBox
      Left = 22
      Top = 19
      Width = 93
      Height = 21
      DropDownWidth = 400
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      KeyField = 'CODICE'
      ListField = 'CODICE;DESCRIZIONE'
      ListSource = A097FPianifLibProfDtM1.D310
      ParentFont = False
      PopupMenu = PopupMenu2
      TabOrder = 0
      OnKeyDown = EProfiloKeyDown
    end
    object btnInserimento: TBitBtn
      Left = 461
      Top = 7
      Width = 92
      Height = 23
      Caption = 'Inserimento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = btnInserimentoClick
    end
    object btnCancellazione: TBitBtn
      Left = 461
      Top = 36
      Width = 92
      Height = 23
      Caption = 'Cancellazione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = btnInserimentoClick
    end
    object ChkFestivi: TCheckBox
      Left = 22
      Top = 45
      Width = 149
      Height = 13
      Caption = 'Pianificazione giorni festivi'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 256
    Width = 593
    Height = 271
    Align = alClient
    DataSource = A097FPianifLibProfDtM1.D320
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clRed
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnEditButtonClick = DBGrid1EditButtonClick
    Columns = <
      item
        Expanded = False
        FieldName = 'DATA'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'D_GIORNO'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 76
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DALLE'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ALLE'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Visible = True
      end
      item
        ButtonStyle = cbsEllipsis
        Expanded = False
        FieldName = 'CAUSALE'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 53
        Visible = True
      end
      item
        ButtonStyle = cbsEllipsis
        Expanded = False
        FieldName = 'D_CAUSALE'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 268
        Visible = True
      end>
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 543
    Width = 593
    Height = 19
    Panels = <
      item
        Width = 50
      end>
    SimpleText = '0 Records'
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 527
    Width = 593
    Height = 16
    Align = alBottom
    TabOrder = 6
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 593
    Height = 24
    Align = alTop
    TabOrder = 4
    TabStop = True
    ExplicitWidth = 593
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 593
      Height = 24
      ExplicitWidth = 593
      ExplicitHeight = 24
      inherited btnSelezione: TBitBtn
        OnClick = frmSelAnagrafebtnSelezioneClick
      end
    end
    inherited pmnuDatiAnagrafici: TPopupMenu
      inherited R003Datianagrafici: TMenuItem
        OnClick = frmSelAnagrafeR003DatianagraficiClick
      end
    end
  end
  object pnlTestata: TPanel
    Left = 0
    Top = 24
    Width = 593
    Height = 96
    Align = alTop
    TabOrder = 0
    object btnStampante: TBitBtn
      Left = 461
      Top = 7
      Width = 92
      Height = 23
      Caption = 'Stampante'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FF0000000000
        0FFFF0777777777070FF000000000000070F0778777BBB87000F077887788887
        070F00000000000007700778888778807070F000000000070700FF0777777770
        7070FFF077777776EEE0F8000000000E6008F0E6EEEEEEEE0FFFF8000000000E
        6008FFFF07777786EEE0FFFFF00000080008FFFFFFFFFFFFFFFF}
      TabOrder = 1
      OnClick = btnStampanteClick
    end
    object btnStampa: TBitBtn
      Left = 461
      Top = 36
      Width = 92
      Height = 23
      Caption = 'Stampa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000C40E0000C40E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        00030777777777777770077777777777777000000000000000000F7F7F7F7F7F
        7F7007F7F7F7F7F7F9F00F7F7F7F7F7F7F700000000000000000FFF0FFFFFFFF
        0FFFFFF0F0000F0F0FFFFFF0FFFFFFFF0FFFFFF0F00F00000FFFFFF0FFFF0FF0
        FFFFFFF0F07F0F0FFFFFFFF0FFFF00FFFFFFFFF000000FFFFFFF}
      ParentFont = False
      TabOrder = 2
      OnClick = btnStampaClick
    end
    object btnAnomalie: TBitBtn
      Left = 461
      Top = 65
      Width = 92
      Height = 23
      Caption = '&Anomalie'
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
      TabOrder = 3
      OnClick = btnAnomalieClick
    end
    object rgpGestioneProfilo: TRadioGroup
      Left = 22
      Top = 49
      Width = 402
      Height = 41
      Caption = 'Pianificazione'
      Columns = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Individuale'
        'Profilo'
        'Importazione file')
      ParentFont = False
      TabOrder = 0
      OnClick = rgpGestioneProfiloClick
    end
    inline frmInputPeriodo: TfrmInputPeriodo
      Left = 17
      Top = 6
      Width = 407
      Height = 40
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBackground = False
      ParentColor = False
      ParentFont = False
      TabOrder = 4
      ExplicitLeft = 17
      ExplicitTop = 6
      ExplicitWidth = 407
      inherited lblInizio: TLabel
        Left = 5
        ExplicitLeft = 5
      end
      inherited lblFine: TLabel
        Left = 170
        ExplicitLeft = 170
      end
      inherited edtInizio: TMaskEdit
        Left = 30
        OnExit = frmInputPeriodoedtInizioExit
        ExplicitLeft = 30
      end
      inherited edtFine: TMaskEdit
        Left = 185
        OnExit = frmInputPeriodoedtFineExit
        ExplicitLeft = 185
      end
      inherited btnIndietro: TBitBtn
        Left = 362
        OnClick = frmInputPeriodobtnIndietroClick
        ExplicitLeft = 362
      end
      inherited btnAvanti: TBitBtn
        Left = 384
        OnClick = frmInputPeriodobtnAvantiClick
        ExplicitLeft = 384
      end
      inherited btnDataInizio: TBitBtn
        Left = 101
        OnClick = frmInputPeriodobtnDataInizioClick
        ExplicitLeft = 101
      end
      inherited btnDataFine: TBitBtn
        Left = 256
        OnClick = frmInputPeriodobtnDataFineClick
        ExplicitLeft = 256
      end
    end
  end
  inline frmToolbarFiglio: TfrmToolbarFiglio
    Left = 0
    Top = 233
    Width = 593
    Height = 23
    Align = alTop
    TabOrder = 7
    TabStop = True
    ExplicitTop = 233
    ExplicitWidth = 593
    inherited tlbarFiglio: TToolBar
      Width = 593
      ExplicitWidth = 593
    end
  end
  object pnlImportazioneFile: TPanel
    Left = 0
    Top = 185
    Width = 593
    Height = 48
    Align = alTop
    TabOrder = 2
    object lblNomeFileInput: TLabel
      Left = 22
      Top = 5
      Width = 89
      Height = 13
      Caption = 'File di importazione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object sbtNomeFileInput: TSpeedButton
      Left = 372
      Top = 19
      Width = 15
      Height = 21
      Caption = '...'
      OnClick = sbtNomeFileInputClick
    end
    object edtNomeFileInput: TEdit
      Left = 22
      Top = 19
      Width = 350
      Height = 21
      TabOrder = 0
    end
    object btnImportazioneFile: TBitBtn
      Left = 461
      Top = 12
      Width = 92
      Height = 23
      Caption = 'Inserimento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = btnImportazioneFileClick
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 172
    Top = 124
    object Nuovoelemento1: TMenuItem
      Caption = 'Accedi'
      OnClick = Nuovoelemento1Click
    end
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 416
    Top = 3
  end
  object OpenDialog1: TOpenDialog
    Left = 249
    Top = 187
  end
end
