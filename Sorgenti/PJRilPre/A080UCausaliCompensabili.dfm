object A080FCausaliCompensabili: TA080FCausaliCompensabili
  Left = 366
  Top = 280
  BorderStyle = bsDialog
  Caption = '<A080> Causali compensabili'
  ClientHeight = 222
  ClientWidth = 206
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 22
    Width = 206
    Height = 25
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 28
      Top = 0
      Width = 75
      Height = 25
      Caption = 'Aggiungi'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
        333333333337F33333333333333033333333333333373F333333333333090333
        33333333337F7F33333333333309033333333333337373F33333333330999033
        3333333337F337F33333333330999033333333333733373F3333333309999903
        333333337F33337F33333333099999033333333373333373F333333099999990
        33333337FFFF3FF7F33333300009000033333337777F77773333333333090333
        33333333337F7F33333333333309033333333333337F7F333333333333090333
        33333333337F7F33333333333309033333333333337F7F333333333333090333
        33333333337F7F33333333333300033333333333337773333333}
      NumGlyphs = 2
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 107
      Top = 0
      Width = 75
      Height = 25
      Caption = 'Rimuovi'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000333
        3333333333777F33333333333309033333333333337F7F333333333333090333
        33333333337F7F33333333333309033333333333337F7F333333333333090333
        33333333337F7F33333333333309033333333333FF7F7FFFF333333000090000
        3333333777737777F333333099999990333333373F3333373333333309999903
        333333337F33337F33333333099999033333333373F333733333333330999033
        3333333337F337F3333333333099903333333333373F37333333333333090333
        33333333337F7F33333333333309033333333333337373333333333333303333
        333333333337F333333333333330333333333333333733333333}
      NumGlyphs = 2
      TabOrder = 1
      OnClick = BitBtn2Click
    end
  end
  object lstCausali: TListBox
    Left = 0
    Top = 47
    Width = 206
    Height = 150
    Align = alBottom
    ItemHeight = 13
    TabOrder = 1
    OnDblClick = BitBtn2Click
  end
  object dcmbCausali: TDBLookupComboBox
    Left = 28
    Top = 0
    Width = 154
    Height = 21
    DropDownRows = 12
    DropDownWidth = 250
    KeyField = 'CODICE'
    ListField = 'CODICE;DESCRIZIONE'
    ListSource = A080FModConteDtM1.dsrT275
    TabOrder = 2
    OnKeyDown = dcmbCausaliKeyDown
  end
  object Panel2: TPanel
    Left = 0
    Top = 197
    Width = 206
    Height = 25
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object BitBtn3: TBitBtn
      Left = 28
      Top = 0
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
    end
    object BitBtn4: TBitBtn
      Left = 107
      Top = 0
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
end
