object A037FAnnullaScarico: TA037FAnnullaScarico
  Left = 248
  Top = 332
  BorderStyle = bsDialog
  Caption = 'Attenzione'
  ClientHeight = 116
  ClientWidth = 255
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
  object Label1: TLabel
    Left = 4
    Top = 4
    Width = 249
    Height = 53
    AutoSize = False
    WordWrap = True
  end
  object BitBtn1: TBitBtn
    Left = 48
    Top = 88
    Width = 75
    Height = 25
    TabOrder = 0
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 140
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Annulla'
    TabOrder = 1
    Kind = bkAbort
  end
  object chkAnnullaltimoScarico: TCheckBox
    Left = 8
    Top = 64
    Width = 249
    Height = 17
    Caption = 'Annullare le movimentazioni dell'#39'ultimo scarico'
    TabOrder = 2
  end
end
