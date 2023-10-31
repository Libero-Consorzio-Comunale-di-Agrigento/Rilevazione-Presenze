object A139FDialogStampa: TA139FDialogStampa
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '<A139> Carta di servizio'
  ClientHeight = 306
  ClientWidth = 393
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
  object Label1: TLabel
    Left = 10
    Top = 15
    Width = 34
    Height = 13
    Caption = 'Ufficio:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 10
    Top = 41
    Width = 113
    Height = 13
    Caption = 'Note a fine documento:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 10
    Top = 88
    Width = 44
    Height = 13
    Caption = 'Firma sx:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 10
    Top = 113
    Width = 45
    Height = 13
    Caption = 'Firma dx:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblNote2: TLabel
    Left = 10
    Top = 64
    Width = 92
    Height = 13
    Caption = 'Note a fine pagina:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object BitBtn2: TBitBtn
    Left = 29
    Top = 267
    Width = 100
    Height = 25
    Caption = 'S&tampante'
    TabOrder = 10
    OnClick = BitBtn2Click
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FF0000000000
      0FFFF0777777777070FF000000000000070F0778777BBB87000F077887788887
      070F00000000000007700778888778807070F000000000070700FF0777777770
      7070FFF077777776EEE0F8000000000E6008F0E6EEEEEEEE0FFFF8000000000E
      6008FFFF07777786EEE0FFFFF00000080008FFFFFFFFFFFFFFFF}
  end
  object BitBtn3: TBitBtn
    Left = 142
    Top = 267
    Width = 100
    Height = 25
    Caption = '&Anteprima'
    Default = True
    TabOrder = 11
    OnClick = BitBtn3Click
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
      FFFF000000000000FF000FFFFFFFFFF0F0000FFFFFFF0000800F0FFFFFF08778
      08FF0FFFFF0877E880FF0FFFFF07777870FF0FFFFF07E77870FF0FFFFF08EE78
      80FF0FFFFFF087780FFF0FFFFFFF0000FFFF0FFFFFFFFFF0FFFF0FFFFFFF0000
      FFFF0FFFFFFF070FFFFF0FFFFFFF00FFFFFF000000000FFFFFFF}
  end
  object BitBtn1: TBitBtn
    Left = 256
    Top = 267
    Width = 100
    Height = 25
    Caption = '&Stampa'
    TabOrder = 12
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
      00033FFFFFFFFFFFFFFF0888888888888880777777777777777F088888888888
      8880777777777777777F0000000000000000FFFFFFFFFFFFFFFF0F8F8F8F8F8F
      8F80777777777777777F08F8F8F8F8F8F9F0777777777777777F0F8F8F8F8F8F
      8F807777777777777F7F0000000000000000777777777777777F3330FFFFFFFF
      03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
      03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
      33333337F3FF7F3733333330F08F0F0333333337F7737F7333333330FFFF0033
      33333337FFFF7733333333300000033333333337777773333333}
    NumGlyphs = 2
  end
  object edtNote: TEdit
    Left = 126
    Top = 37
    Width = 253
    Height = 21
    TabOrder = 1
  end
  object edtFirmaSx: TEdit
    Left = 126
    Top = 84
    Width = 253
    Height = 21
    TabOrder = 3
  end
  object chkAssentiGiustificati: TCheckBox
    Left = 10
    Top = 210
    Width = 369
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Stampa assenti giustificati'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
  end
  object chkAssentiNonGiustificati: TCheckBox
    Left = 10
    Top = 234
    Width = 369
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Stampa assenti non giustificati'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
  end
  object chkSortCronologico: TCheckBox
    Left = 10
    Top = 141
    Width = 369
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Ordine cronologico'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object chkSortCampo1: TCheckBox
    Left = 10
    Top = 186
    Width = 369
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Raggruppamento per ufficio'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object edtFirmaDx: TEdit
    Left = 126
    Top = 109
    Width = 253
    Height = 21
    TabOrder = 4
  end
  object cmbCampo1: TComboBox
    Left = 126
    Top = 11
    Width = 253
    Height = 21
    ItemHeight = 13
    TabOrder = 0
    Text = 'cmbCampo1'
  end
  object chkRaggrTipo: TCheckBox
    Left = 10
    Top = 162
    Width = 369
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Raggruppamento per tipo turno'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object edtNote2: TEdit
    Left = 126
    Top = 60
    Width = 253
    Height = 21
    TabOrder = 2
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 38
    Top = 218
  end
end
