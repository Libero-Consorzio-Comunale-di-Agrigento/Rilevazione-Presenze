object A058FCoperturaSquadra: TA058FCoperturaSquadra
  Left = 348
  Top = 304
  Caption = '<A058> Copertura squadra il dd/mm/yyyy'
  ClientHeight = 159
  ClientWidth = 380
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object SquadGriglia: TStringGrid
    Left = 0
    Top = 0
    Width = 380
    Height = 159
    Align = alClient
    TabOrder = 0
    OnDrawCell = SquadGrigliaDrawCell
  end
end
