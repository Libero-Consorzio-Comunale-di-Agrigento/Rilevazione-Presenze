object C006FStoriaDip: TC006FStoriaDip
  Left = 161
  Top = 107
  Caption = '<C006> Situazione storica'
  ClientHeight = 366
  ClientWidth = 712
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 341
    Width = 712
    Height = 25
    Align = alBottom
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 305
      Top = 0
      Width = 80
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 0
    end
    object btnStampa: TBitBtn
      Left = 137
      Top = 0
      Width = 75
      Height = 25
      Caption = 'Stampa'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
        0000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000
        C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6000000C6C6
        C6000000FFFFFFFFFFFF00000000000000000000000000000000000000000000
        0000000000000000000000000000000000C6C6C6000000FFFFFF000000C6C6C6
        C6C6C6C6C6C6C6C6C6C6C6C6C6C6C600FFFF00FFFF00FFFFC6C6C6C6C6C60000
        00000000000000FFFFFF000000C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C684
        8484848484848484C6C6C6C6C6C6000000C6C6C6000000FFFFFF000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00C6C6C6C6C6C6000000000000C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6
        C6C6C6C6C6C6C6C6C6C6C6000000C6C6C6000000C6C6C6000000FFFFFF000000
        000000000000000000000000000000000000000000000000000000C6C6C60000
        00C6C6C6000000000000FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFF000000C6C6C6000000C6C6C6000000FFFFFFFFFFFF
        FFFFFF000000FFFFFF000000000000000000000000000000FFFFFF0000000000
        00000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFF000000FFFFFF000000000000000000000000000000FFFFFF0000
        00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000
        00000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      TabOrder = 1
      OnClick = btnStampaClick
    end
  end
  object Grid: TStringGrid
    Left = 0
    Top = 0
    Width = 712
    Height = 341
    Align = alClient
    DefaultColWidth = 110
    DefaultRowHeight = 16
    FixedCols = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect, goThumbTracking]
    PopupMenu = pmnuVaiADecorrenza
    TabOrder = 1
    OnDrawCell = GridDrawCell
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 480
    Top = 16
  end
  object pmnuVaiADecorrenza: TPopupMenu
    Left = 512
    Top = 16
    object Posizionasullostoricoselezionato1: TMenuItem
      Caption = 'Posiziona sul periodo selezionato'
      OnClick = Posizionasullostoricoselezionato1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object CopiainExcel1: TMenuItem
      Caption = 'Copia in Excel'
      OnClick = CopiainExcel1Click
    end
  end
end
