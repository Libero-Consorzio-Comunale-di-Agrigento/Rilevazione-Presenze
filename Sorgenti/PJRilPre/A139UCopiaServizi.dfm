object A139FCopiaServizi: TA139FCopiaServizi
  Left = 0
  Top = 0
  Caption = '<A139> Modelli dei servizi'
  ClientHeight = 388
  ClientWidth = 424
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
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 424
    Height = 249
    Align = alClient
    DataSource = A139FPianifServiziDtm.DscT520
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object PnlTop: TPanel
    Left = 0
    Top = 249
    Width = 424
    Height = 53
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object btnConferma: TSpeedButton
      Left = 332
      Top = 28
      Width = 23
      Height = 22
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
      OnClick = btnConfermaClick
    end
    object btnEsci1: TSpeedButton
      Left = 397
      Top = 29
      Width = 23
      Height = 22
      Glyph.Data = {
        42020000424D4202000000000000420000002800000010000000100000000100
        1000030000000002000000000000000000000000000000000000007C0000E003
        00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C00001F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1042F702F70200001F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1042F702F702F702F7020000
        1F7C1F7C1F7C000000000000000000001F7C1F7C1042F702F702F702F702F702
        F702000000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1042F702F702F702F702F702
        F70200001F7C1F7C1F7C1F7C1F7C1F7C104210421042F702F702F702F702F702
        F70200001F7C1F7C1F7C1F7C1F7C1F7C104210421042F702F702F702F702F702
        F70200001F7C1F7C1F7C1F7C1F7C007C104210421042F7021042F702F702F702
        F70200001F7C1F7C1F7C005C005C007C007C10421042F7021042F702F702F702
        F70200001F7C1F7C1F7C007C007C007C007C007C1042F702F702F702F702F702
        F70200001F7C1F7C1F7C007C007C007C007C10421042F702F702F702F702F702
        F70200001F7C1F7C1F7C1F7C1F7C007C104210421042F702F702F702F702F702
        F70200001F7C1F7C1F7C1F7C1F7C1F7C104210421042FF03F702F702F702F702
        F70200001F7C1F7C1F7C1F7C1F7C1F7C10421042104210421042FF03F702F702
        F70200001F7C1F7C1F7C1F7C1F7C1F7C1042104210421042104210421042FF03
        F70200001F7C1F7C1F7C1F7C1F7C1F7C10421042104210421042104210421042
        104200001F7C}
      OnClick = btnEsci1Click
    end
    object Data: TLabel
      Left = 47
      Top = 9
      Width = 23
      Height = 13
      Caption = 'Data'
    end
    object LblTTurno: TLabel
      Left = 147
      Top = 9
      Width = 49
      Height = 13
      Caption = 'Tipo turno'
    end
    object LblComandato: TLabel
      Left = 340
      Top = 9
      Width = 55
      Height = 13
      Caption = 'Comandato'
    end
    object LblNome: TLabel
      Left = 4
      Top = 33
      Width = 66
      Height = 13
      Caption = 'Nome modello'
    end
    object edtComandato: TEdit
      Left = 400
      Top = 5
      Width = 20
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
    end
    object edtNome: TEdit
      Left = 74
      Top = 29
      Width = 256
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object EdtDataOrigine: TDBEdit
      Left = 74
      Top = 5
      Width = 65
      Height = 21
      DataField = 'DATA'
      DataSource = A139FPianifServizi.DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object EdtTTurno: TDBEdit
      Left = 200
      Top = 5
      Width = 130
      Height = 21
      DataField = 'DescTTurno'
      DataSource = A139FPianifServizi.DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  object PnlBottom: TPanel
    Left = 0
    Top = 302
    Width = 424
    Height = 86
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object btnCancella: TSpeedButton
      Left = 288
      Top = 58
      Width = 106
      Height = 22
      Caption = 'Cancella modello'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Glyph.Data = {
        42020000424D4202000000000000420000002800000010000000100000000100
        1000030000000002000000000000000000000000000000000000007C0000E003
        00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0040104210421F7C1F7C1F7C1F7C1F7C
        104210421F7C1F7C00401F7C1F7C1F7C00400040104210421F7C1F7C1F7C1F7C
        004000001F7C1F7C004000401F7C1F7C10420040004010421F7C1F7C1F7C1042
        00401F7C1F7C1F7C0040004000401F7C1F7C00400040104210421F7C00400040
        10421F7C1F7C1F7C00400040004000401F7C1042004000401042104200400040
        1F7C1F7C1F7C1F7C004000400040004000401F7C004000400040004000401F7C
        1F7C1F7C1F7C1F7C00400040004000401F7C1F7C104200400040004010421F7C
        1F7C1F7C1F7C1F7C0040004000401F7C10421042004000400040004010421042
        1F7C1F7C1F7C1F7C004000401F7C1042004000401F7C1F7C1042004000401042
        10421F7C1F7C1F7C00401F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C104200400040
        104200001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000
        00401F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C}
      ParentFont = False
      OnClick = btnCancellaClick
    end
    object btnEsci2: TSpeedButton
      Left = 397
      Top = 58
      Width = 23
      Height = 22
      Glyph.Data = {
        42020000424D4202000000000000420000002800000010000000100000000100
        1000030000000002000000000000000000000000000000000000007C0000E003
        00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C00001F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1042F702F70200001F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1042F702F702F702F7020000
        1F7C1F7C1F7C000000000000000000001F7C1F7C1042F702F702F702F702F702
        F702000000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1042F702F702F702F702F702
        F70200001F7C1F7C1F7C1F7C1F7C1F7C104210421042F702F702F702F702F702
        F70200001F7C1F7C1F7C1F7C1F7C1F7C104210421042F702F702F702F702F702
        F70200001F7C1F7C1F7C1F7C1F7C007C104210421042F7021042F702F702F702
        F70200001F7C1F7C1F7C005C005C007C007C10421042F7021042F702F702F702
        F70200001F7C1F7C1F7C007C007C007C007C007C1042F702F702F702F702F702
        F70200001F7C1F7C1F7C007C007C007C007C10421042F702F702F702F702F702
        F70200001F7C1F7C1F7C1F7C1F7C007C104210421042F702F702F702F702F702
        F70200001F7C1F7C1F7C1F7C1F7C1F7C104210421042FF03F702F702F702F702
        F70200001F7C1F7C1F7C1F7C1F7C1F7C10421042104210421042FF03F702F702
        F70200001F7C1F7C1F7C1F7C1F7C1F7C1042104210421042104210421042FF03
        F70200001F7C1F7C1F7C1F7C1F7C1F7C10421042104210421042104210421042
        104200001F7C}
      OnClick = btnEsci1Click
    end
    object LblData2: TLabel
      Left = 11
      Top = 62
      Width = 71
      Height = 13
      Caption = 'Copia alla data'
    end
    object EdtData: TMaskEdit
      Left = 89
      Top = 58
      Width = 65
      Height = 21
      EditMask = '!99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 7
      Text = '  /  /    '
    end
    object btnDuplica: TButton
      Left = 159
      Top = 58
      Width = 75
      Height = 22
      Caption = 'Copia modello'
      TabOrder = 8
      OnClick = btnDuplicaClick
    end
    object chkServizi: TCheckBox
      Left = 11
      Top = 4
      Width = 110
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Servizi'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = chkServiziClick
    end
    object chkNoteServizi: TCheckBox
      Left = 11
      Top = 20
      Width = 110
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Note servizi'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = chkNoteServiziClick
    end
    object chkApparati: TCheckBox
      Left = 163
      Top = 4
      Width = 80
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Dotazione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object chkOrari: TCheckBox
      Left = 163
      Top = 20
      Width = 80
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Orari'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object chkPattuglie: TCheckBox
      Left = 291
      Top = 4
      Width = 80
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Pattuglie'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = chkPattuglieClick
    end
    object chkNominativi: TCheckBox
      Left = 291
      Top = 20
      Width = 80
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Nominativi'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnClick = chkNominativiClick
    end
    object chkServiziStraordinari: TCheckBox
      Left = 11
      Top = 35
      Width = 110
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Servizi straordinari'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = chkNoteServiziClick
    end
  end
end
