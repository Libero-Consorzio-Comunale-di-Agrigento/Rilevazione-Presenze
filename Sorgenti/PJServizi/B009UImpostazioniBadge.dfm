object B009FImpostazioniBadge: TB009FImpostazioniBadge
  Left = 238
  Top = 152
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '<B009> Impostazioni badge'
  ClientHeight = 260
  ClientWidth = 342
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 342
    Height = 225
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 57
      Top = 86
      Width = 184
      Height = 13
      Caption = 'Posizione di inizio del numero di badge:'
    end
    object Label2: TLabel
      Left = 43
      Top = 193
      Width = 206
      Height = 13
      Caption = 'Lunghezza in caratteri del numero di badge:'
    end
    object EdtPosizione: TEdit
      Left = 244
      Top = 83
      Width = 33
      Height = 21
      MaxLength = 2
      TabOrder = 0
    end
    object EdtLunghezza: TEdit
      Left = 255
      Top = 190
      Width = 33
      Height = 21
      MaxLength = 2
      TabOrder = 1
    end
    object GroupBox1: TGroupBox
      Left = 5
      Top = 2
      Width = 331
      Height = 72
      TabOrder = 2
      object Label3: TLabel
        Left = 8
        Top = 12
        Width = 315
        Height = 29
        AutoSize = False
        Caption = 
          'Indicare la posizione di partenza del numero di badge del dipend' +
          'ente all'#39'interno del tracciato del badge.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object Label5: TLabel
        Left = 8
        Top = 39
        Width = 315
        Height = 29
        AutoSize = False
        Caption = 
          'Es.: Se il tracciato del badge fosse il seguente: '#39'xxxNNNNNxxxxx' +
          #39' dove N indica il numero di badge, la posizione di inizio sareb' +
          'be 4.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
    end
    object GroupBox2: TGroupBox
      Left = 9
      Top = 109
      Width = 331
      Height = 72
      TabOrder = 3
      object Label4: TLabel
        Left = 8
        Top = 12
        Width = 315
        Height = 29
        AutoSize = False
        Caption = 
          'Indicare il numero di caratteri da cui '#232' costituito il numero di' +
          ' badge del dipendente all'#39'interno del tracciato del badge.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object Label6: TLabel
        Left = 8
        Top = 39
        Width = 315
        Height = 29
        AutoSize = False
        Caption = 
          'Nell'#39'esempio precedente, la lunghezza del numero di badge sarebb' +
          'e 5.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
    end
  end
  object BtnOk: TBitBtn
    Left = 100
    Top = 230
    Width = 75
    Height = 25
    TabOrder = 1
    OnClick = BtnOkClick
    Kind = bkOK
  end
  object BtnCancel: TBitBtn
    Left = 179
    Top = 230
    Width = 75
    Height = 25
    Caption = 'Annulla'
    TabOrder = 2
    OnClick = BtnCancelClick
    Kind = bkCancel
  end
end
