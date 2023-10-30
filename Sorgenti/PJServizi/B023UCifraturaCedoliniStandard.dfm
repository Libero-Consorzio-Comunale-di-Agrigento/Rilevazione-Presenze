inherited B023FCifraturaCedoliniStandard: TB023FCifraturaCedoliniStandard
  ClientHeight = 227
  ClientWidth = 486
  OnShow = FormShow
  ExplicitWidth = 502
  ExplicitHeight = 265
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBottom: TPanel
    Top = 162
    Width = 486
    ExplicitTop = 162
    ExplicitWidth = 486
    inherited prbProgress: TProgressBar
      Width = 484
      ExplicitWidth = 484
    end
    inherited StatusBar: TStatusBar
      Width = 484
      ExplicitWidth = 484
    end
  end
  inherited pnlMain: TPanel
    Width = 486
    Height = 162
    ExplicitWidth = 486
    ExplicitHeight = 162
    object grpPercorso: TGroupBox
      Left = 12
      Top = 16
      Width = 463
      Height = 105
      Caption = 'Posizione file da cifrare'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object lblAnno: TLabel
        Left = 135
        Top = 47
        Width = 25
        Height = 13
        Caption = 'Anno'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblDataCed: TLabel
        Left = 11
        Top = 47
        Width = 26
        Height = 13
        Caption = 'Data:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblDirectory: TLabel
        Left = 11
        Top = 77
        Width = 42
        Height = 13
        Caption = 'Percorso'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblMese: TLabel
        Left = 59
        Top = 47
        Width = 26
        Height = 13
        Caption = 'Mese'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object edtPath: TEdit
        Left = 59
        Top = 74
        Width = 390
        Height = 21
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
      object rdbCedolini: TRadioButton
        Left = 11
        Top = 20
        Width = 79
        Height = 17
        Caption = 'Cedolini'
        Checked = True
        TabOrder = 1
        TabStop = True
        OnClick = rdbCedoliniClick
      end
      object rdbCU: TRadioButton
        Left = 96
        Top = 20
        Width = 42
        Height = 17
        Caption = 'CU'
        TabOrder = 2
        OnClick = rdbCUClick
      end
      object spMese: TSpinEdit
        Left = 89
        Top = 44
        Width = 37
        Height = 22
        MaxValue = 12
        MinValue = 1
        TabOrder = 3
        Value = 1
      end
      object spAnno: TSpinEdit
        Left = 165
        Top = 44
        Width = 51
        Height = 22
        MaxValue = 3000
        MinValue = 1900
        TabOrder = 4
        Value = 1900
      end
    end
  end
  inherited btnDisattivaElaborazioni: TBitBtn
    Left = 328
    Top = 127
    ExplicitLeft = 328
    ExplicitTop = 127
  end
end
