object A047FRaggrStampa: TA047FRaggrStampa
  Left = 0
  Top = 0
  Caption = '<A047> Raggruppamenti Stampa'
  ClientHeight = 282
  ClientWidth = 319
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnl: TPanel
    Left = 0
    Top = 252
    Width = 319
    Height = 30
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object btnConferma: TBitBtn
      Tag = 2
      Left = 7
      Top = 3
      Width = 75
      Height = 25
      Caption = 'Conferma'
      Glyph.Data = {
        42020000424D4202000000000000420000002800000010000000100000000100
        1000030000000002000000000000000000000000000000000000007C0000E003
        00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C000200021F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0002000200021F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C00020002E003E00300021F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C0002E003E0031F7CE00300021F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7CE003E0031F7C1F7CE003E00300021F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CE00300021F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CE00300021F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CE00300021F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CE00300021F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CE0030002
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CE003
        00021F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C}
      ModalResult = 1
      TabOrder = 0
      OnClick = btnConfermaClick
    end
    object btnAnnulla: TBitBtn
      Tag = 3
      Left = 239
      Top = 3
      Width = 75
      Height = 25
      Caption = 'Annulla'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFF000084FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000084FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF0000FF0000FF000084FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000840000FF000084FFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000084FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFF0000840000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000
        84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000840000FF00
        0084FFFFFFFFFFFF0000840000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFF0000840000FF0000840000FF0000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
        00FF0000840000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFF0000FF0000840000FF000084000084FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000840000FF00
        0084FFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF0000FF0000840000FF000084FFFFFFFFFFFFFFFFFFFFFFFF0000840000
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000840000FF0000840000FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF0000840000FFFFFFFFFFFFFFFFFFFFFFFFFF
        0000FF000084FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF0000840000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      ModalResult = 2
      TabOrder = 1
      OnClick = btnAnnullaClick
    end
  end
  object edtListaCampi: TEdit
    Left = 0
    Top = 231
    Width = 319
    Height = 21
    Hint = 'Doppio click del mouse sul campo raggruppamento da cancellare'
    Align = alBottom
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnDblClick = edtListaCampiDblClick
  end
  object lstBoxRaggr: TListBox
    Left = 0
    Top = 0
    Width = 319
    Height = 231
    Align = alClient
    ItemHeight = 13
    TabOrder = 0
    OnDblClick = lstBoxRaggrDblClick
  end
end