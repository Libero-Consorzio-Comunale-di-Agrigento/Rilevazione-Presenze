object A151FGrigliaRisultato: TA151FGrigliaRisultato
  Left = 0
  Top = 0
  Caption = '<A151> Griglia risultato'
  ClientHeight = 560
  ClientWidth = 784
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
    Top = 516
    Width = 784
    Height = 44
    Align = alBottom
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 690
      Top = 9
      Width = 81
      Height = 27
      Caption = '&Chiudi'
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 0
    end
    object btnSelezionaTutto: TBitBtn
      Left = 230
      Top = 9
      Width = 98
      Height = 27
      Caption = 'Seleziona tutto'
      TabOrder = 1
      OnClick = btnSelezionaTuttoClick
    end
    object btnCopia: TBitBtn
      Left = 334
      Top = 9
      Width = 97
      Height = 27
      Caption = 'Copia in Excel'
      TabOrder = 2
      OnClick = btnCopiaClick
    end
    object btnStampa: TBitBtn
      Left = 565
      Top = 9
      Width = 97
      Height = 27
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
      TabOrder = 3
      OnClick = btnStampaClick
    end
    object btnStampante: TBitBtn
      Left = 463
      Top = 9
      Width = 97
      Height = 27
      Caption = 'Stampante'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000C40E0000C40E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        00030777777777777770077777777777777000000000000000000F7F7F7F7F7F
        7F7007F7F7F7F7F7F9F00F7F7F7F7F7F7F700000000000000000FFF0FFFFFFFF
        0FFFFFF0F0000F0F0FFFFFF0FFFFFFFF0FFFFFF0F00F00000FFFFFF0FFFF0FF0
        FFFFFFF0F07F0F0FFFFFFFF0FFFF00FFFFFFFFF000000FFFFFFF}
      TabOrder = 4
      OnClick = btnStampanteClick
    end
    object btnEsportaXML: TBitBtn
      Left = 12
      Top = 9
      Width = 190
      Height = 27
      Caption = 'Esporta legge 104/1992 in .XML'
      Glyph.Data = {
        36010000424D3601000000000000760000002800000012000000100000000100
        040000000000C0000000130B0000130B00001000000010000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF0F
        FFFFFFFFEFFFFFFFFFFFFF90FFFFFFFFFFFFFFFFFFFFFF990FFFFFFFEFFF0000
        0099999990FFFFFFFFFF0FFFF0999999990FFFFFEFFF0FFFF09999999990FFFF
        FFFF0F00F0999999990FFFFFEFFF0FFFF099999990FFFFFFFFFF0F00FFFFF099
        0FFFFFFFEFFF0FFFFFFFF090FFFFFFFFFFFF0F00F000000FFFFFFFFFEFFF0FFF
        F0FF0FFFFFFFFFFFFFFF0F08F0F0FFFFFFFFFFFFEFFF0FFFF00FFFFFFFFFFFFF
        FFFF000000FFFFFFFFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      TabOrder = 5
      OnClick = btnEsportaXMLClick
    end
  end
  object dgrdRisultato: TDBGrid
    Left = 0
    Top = 0
    Width = 784
    Height = 516
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    PopupMenu = PopupMenu1
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -12
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDrawColumnCell = dgrdRisultatoDrawColumnCell
  end
  object PopupMenu1: TPopupMenu
    Left = 264
    Top = 185
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      OnClick = Selezionatutto1Click
    end
    object Deselezionatutto1: TMenuItem
      Caption = 'Deseleziona tutto'
      OnClick = Deselezionatutto1Click
    end
    object Invertiselezione1: TMenuItem
      Caption = 'Inverti selezione'
      OnClick = Invertiselezione1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Copia2: TMenuItem
      Caption = 'Copia'
      OnClick = CopiaInExcelClick
    end
    object CopiaInExcel: TMenuItem
      Caption = 'Copia in Excel'
      OnClick = CopiaInExcelClick
    end
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 420
    Top = 388
  end
end
