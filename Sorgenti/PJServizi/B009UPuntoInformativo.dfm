object B009FPuntoInformativo: TB009FPuntoInformativo
  Left = 63
  Top = 110
  ActiveControl = EdtNumeroBadge
  Align = alClient
  BorderIcons = []
  BorderStyle = bsNone
  ClientHeight = 581
  ClientWidth = 800
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object LblNumeroBadge: TLabel
    Left = 2
    Top = 158
    Width = 792
    Height = 40
    Alignment = taCenter
    AutoSize = False
    Caption = 'Numero di badge'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -31
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LblElaborazione: TLabel
    Left = 0
    Top = 273
    Width = 800
    Height = 36
    Alignment = taCenter
    AutoSize = False
    Caption = 
      'strisciare il badge ed attendere la visualizzazione del cartelli' +
      'no'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -20
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 200
    Top = 17
    Width = 405
    Height = 25
    Alignment = taCenter
    AutoSize = False
    Caption = 'per la visualizazione del cartellino relativo al mese di '
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -19
    Font.Name = 'Arial Narrow'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object PnlNumeroBadge: TPanel
    Left = 204
    Top = 200
    Width = 394
    Height = 65
    BevelOuter = bvNone
    TabOrder = 0
    object EdtNumeroBadge: TEdit
      Tag = 1
      Left = 1
      Top = 2
      Width = 393
      Height = 53
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -40
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 20
      ParentFont = False
      TabOrder = 0
      OnKeyPress = EdtNumeroBadgeKeyPress
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 800
    Height = 41
    Align = alTop
    Alignment = taLeftJustify
    Caption = '          Punto informativo del dipendente'
    Color = clActiveCaption
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Image1: TImage
      Left = 8
      Top = 5
      Width = 32
      Height = 32
      AutoSize = True
      Picture.Data = {
        055449636F6E0000010002001010100000000000280100002600000020201000
        00000000E80200004E0100002800000010000000200000000100040000000000
        C000000000000000000000000000000000000000000000000000800000800000
        0080800080000000800080008080000080808000C0C0C0000000FF0000FF0000
        00FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000000000000444
        444000000004444444444000004444FFFFF444000044444FFF4444000444444F
        FF4444400444444FFF4444400444444FFF444440044444FFFF44444004444444
        4444444004444444444444400044444FF4444400004444FFFF4444000004444F
        F444400000000444444000000000000000000000F81F0000E0070000C0030000
        8001000080010000000000000000000000000000000000000000000000000000
        8001000080010000C0030000E0070000F81F0000280000002000000040000000
        0100040000000000800200000000000000000000000000000000000000000000
        00008000008000000080800080000000800080008080000080808000C0C0C000
        0000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0000000000
        000000000000000000000000000000000000BBBBBBBB00000000000000000000
        0BBBBBBBBBBBBBB0000000000000000BBBBBBBBBBBBBBBBBB0000000000000BB
        BBB444444444444BBB00000000000BBBBBB444444444444BBBB000000000BBBB
        BBB444444444444BBBBB0000000BBBBBBBBBBB444444BBBBBBBBB000000BBBBB
        BBBBBB444444BBBBBBBBB00000BBBBBBBBBBBB444444BBBBBBBBBB0000BBBBBB
        BBBBBB444444BBBBBBBBBB0000BBBBBBBBBBBB444444BBBBBBBBBB000BBBBBBB
        BBBBBB444444BBBBBBBBBBB00BBBBBBBBBBBBB444444BBBBBBBBBBB00BBBBBBB
        BBBBBB444444BBBBBBBBBBB00BBBBBBBBBBBBB444444BBBBBBBBBBB00BBBBBBB
        BBBBBB444444BBBBBBBBBBB00BBBBBBBBBBBBB444444BBBBBBBBBBB00BBBBBBB
        BBBBBB444444BBBBBBBBBBB00BBBBBBBBBB444444444BBBBBBBBBBB000BBBBBB
        BBB444444444BBBBBBBBBB0000BBBBBBBBBBBBBBBBBBBBBBBBBBBB0000BBBBBB
        BBBBBBBBBBBBBBBBBBBBBB00000BBBBBBBBBBB4444BBBBBBBBBBB000000BBBBB
        BBBBB444444BBBBBBBBBB0000000BBBBBBBB44444444BBBBBBBB000000000BBB
        BBBB44444444BBBBBBB00000000000BBBBBB44444444BBBBBB0000000000000B
        BBBBB444444BBBBBB0000000000000000BBBBB4444BBBBB00000000000000000
        0000BBBBBBBB00000000000000000000000000000000000000000000FFF00FFF
        FF8001FFFE00007FFC00003FF800001FF000000FE0000007C0000003C0000003
        8000000180000001800000010000000000000000000000000000000000000000
        000000000000000000000000800000018000000180000001C0000003C0000003
        E0000007F000000FF800001FFC00003FFE00007FFF8001FFFFF00FFF}
    end
  end
  object PnlBottoni: TPanel
    Left = 4
    Top = 371
    Width = 591
    Height = 151
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 2
    object SpbA: TSpeedButton
      Left = 135
      Top = 0
      Width = 53
      Height = 48
      GroupIndex = 1
      Down = True
      Caption = 'A'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -31
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object SpbB: TSpeedButton
      Left = 135
      Top = 51
      Width = 53
      Height = 49
      GroupIndex = 1
      Caption = 'B'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -31
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object SpbC: TSpeedButton
      Left = 135
      Top = 102
      Width = 53
      Height = 49
      GroupIndex = 1
      Caption = 'C'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -31
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 0
      Top = 17
      Width = 132
      Height = 25
      Alignment = taCenter
      AutoSize = False
      Caption = 'Premere il tasto:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LblB: TLabel
      Left = 195
      Top = 68
      Width = 396
      Height = 19
      Alignment = taCenter
      Caption = 'per la visualizazione del cartellino relativo al mese di'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LblA: TLabel
      Left = 195
      Top = 17
      Width = 396
      Height = 19
      Alignment = taCenter
      Caption = 'per la visualizazione del cartellino relativo al mese di'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LblC: TLabel
      Left = 195
      Top = 119
      Width = 387
      Height = 19
      Alignment = taCenter
      Caption = 'per la visualizazione dell'#39'ultimo cartellino elaborato'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 562
    Width = 800
    Height = 19
    Panels = <>
    SimplePanel = True
    SimpleText = 
      'Premere Shift + Alt + Invio per modificare le impostazioni del b' +
      'adge'
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 636
    Top = 240
  end
end
