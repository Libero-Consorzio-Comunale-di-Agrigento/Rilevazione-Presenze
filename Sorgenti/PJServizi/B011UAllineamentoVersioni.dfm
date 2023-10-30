object B011FAllineamentoVersioni: TB011FAllineamentoVersioni
  Left = 199
  Top = 174
  Width = 375
  Height = 43
  AutoSize = True
  BorderIcons = []
  Caption = '<B011> Controllo versioni in corso...'
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
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PrbVersioni: TProgressBar
    Left = 0
    Top = 0
    Width = 367
    Height = 16
    Align = alTop
    Min = 0
    Max = 100
    TabOrder = 0
  end
end
