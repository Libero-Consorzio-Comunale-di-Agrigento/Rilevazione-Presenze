object B016FSetupPercorsi: TB016FSetupPercorsi
  Left = 0
  Top = 0
  HelpContext = 9016000
  Caption = '<B016> Setup IrisWIN'
  ClientHeight = 300
  ClientWidth = 519
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 268
    Width = 519
    Height = 32
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      519
      32)
    object btnOk: TBitBtn
      Left = 359
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnOkClick
    end
    object btnCancel: TBitBtn
      Left = 440
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnCancelClick
    end
    object btnAdd: TBitBtn
      Left = 5
      Top = 4
      Width = 112
      Height = 25
      Caption = 'Aggiungi'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000FFFFF003333333330
        FFFF0B03333333330FFF0FB03333333330FF0BFB03333333330F0FBFB0000000
        000F0BFBFBFBFB0FFFFF0FBFBFBFBF0FFFFF0BFB0000000FFFFFF000FFFFFFFF
        000FFFFFFFFFFFFFF00FFFFFFFFF0FFF0F0FFFFFFFFFF000FFFF}
      TabOrder = 2
      OnClick = btnAddClick
    end
  end
  object memPercorsi: TMemo
    Left = 0
    Top = 0
    Width = 519
    Height = 268
    Align = alClient
    TabOrder = 1
    ExplicitTop = -2
  end
end
