object A079FAssenzeAuto: TA079FAssenzeAuto
  Left = 504
  Top = 329
  HelpContext = 79000
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '<A079> Inserimento automatico assenze'
  ClientHeight = 162
  ClientWidth = 339
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object BtnEsegui: TBitBtn
    Left = 64
    Top = 96
    Width = 100
    Height = 25
    Caption = '&Esegui'
    NumGlyphs = 2
    TabOrder = 2
    OnClick = BtnEseguiClick
  end
  object BtnClose: TBitBtn
    Left = 175
    Top = 96
    Width = 100
    Height = 25
    Caption = '&Chiudi'
    Kind = bkClose
    NumGlyphs = 2
    TabOrder = 3
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 127
    Width = 339
    Height = 16
    Align = alBottom
    TabOrder = 4
    ExplicitTop = 114
    ExplicitWidth = 283
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 143
    Width = 339
    Height = 19
    Panels = <
      item
        Text = '0 Records'
        Width = 100
      end
      item
        Width = 50
      end>
    SimpleText = '0 Records'
    ExplicitTop = 130
    ExplicitWidth = 283
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 339
    Height = 24
    Align = alTop
    TabOrder = 0
    TabStop = True
    ExplicitWidth = 283
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 339
      Height = 24
      ExplicitWidth = 283
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
  inline frmInputPeriodo: TfrmInputPeriodo
    Left = 0
    Top = 24
    Width = 339
    Height = 57
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
    TabOrder = 1
    ExplicitTop = 24
    ExplicitWidth = 520
    ExplicitHeight = 57
    inherited lblInizio: TLabel
      Left = 35
      ExplicitLeft = 35
    end
    inherited lblFine: TLabel
      Left = 166
      ExplicitLeft = 166
    end
    inherited edtInizio: TMaskEdit
      Top = 30
      ExplicitTop = 30
    end
    inherited edtFine: TMaskEdit
      Top = 30
      ExplicitTop = 30
    end
    inherited btnIndietro: TBitBtn
      Top = 30
      ExplicitTop = 30
    end
    inherited btnAvanti: TBitBtn
      Top = 30
      ExplicitTop = 30
    end
    inherited btnDataInizio: TBitBtn
      Top = 29
      ExplicitTop = 29
    end
    inherited btnDataFine: TBitBtn
      Top = 29
      ExplicitTop = 29
    end
  end
end
