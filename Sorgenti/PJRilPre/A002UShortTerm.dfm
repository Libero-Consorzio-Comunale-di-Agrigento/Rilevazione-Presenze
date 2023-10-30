object A002FShortTerm: TA002FShortTerm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '<A002> Analisi short term'
  ClientHeight = 456
  ClientWidth = 842
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
  object pnlNominativo: TPanel
    Left = 0
    Top = 0
    Width = 842
    Height = 49
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 781
    object lblNominativo: TLabel
      Left = 17
      Top = 18
      Width = 53
      Height = 13
      Caption = 'Nominativo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
  end
  object pnlPrevisioni: TPanel
    Left = 0
    Top = 339
    Width = 842
    Height = 117
    Align = alBottom
    TabOrder = 1
    ExplicitWidth = 781
    object lblMessFineContrPrev: TLabel
      Left = 93
      Top = 10
      Width = 65
      Height = 13
      Caption = 'prevista il ....'
    end
    object lblFineContrPrev: TLabel
      Left = 17
      Top = 10
      Width = 72
      Height = 13
      Caption = 'Fine contratto:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblRegola35Prev: TLabel
      Left = 17
      Top = 36
      Width = 56
      Height = 13
      Caption = 'Regola 3.5:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblPensionePrev: TLabel
      Left = 17
      Top = 63
      Width = 47
      Height = 13
      Caption = 'Pensione:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblShifPrev: TLabel
      Left = 17
      Top = 90
      Width = 18
      Height = 13
      Caption = 'Shif'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblMessRegola35Prev: TLabel
      Left = 93
      Top = 36
      Width = 65
      Height = 13
      Caption = 'prevista il ....'
    end
    object lblMessPensionePrev: TLabel
      Left = 93
      Top = 63
      Width = 65
      Height = 13
      Caption = 'prevista il ....'
    end
    object lblMessShifPrev: TLabel
      Left = 93
      Top = 90
      Width = 65
      Height = 13
      Caption = 'prevista il ....'
    end
  end
  object dgrdPeriodi: TDBGrid
    Left = 0
    Top = 49
    Width = 842
    Height = 290
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    PopupMenu = pmnEsporta
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'TIPO'
        Title.Caption = 'Tipo'
        Width = 85
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TIPOCONTRATTO'
        Title.Caption = 'Tipo contratto'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'INIZIO'
        Title.Caption = 'Inizio'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FINE'
        Title.Caption = 'Fine'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GGSERVIZIO'
        Title.Caption = 'gg servizio'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GGPAUSA'
        Title.Caption = 'gg pausa'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATAFINECONTREFF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Caption = 'Fine contratto'
        Width = 85
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATAREGOLA35EFF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Caption = 'Regola 3.5'
        Width = 85
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATAPENSIONEEFF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Caption = 'Pensione'
        Width = 85
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATASHIFEFF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Caption = 'Shif'
        Width = 85
        Visible = True
      end>
  end
  object pmnEsporta: TPopupMenu
    Left = 624
    Top = 80
    object mnuCopiaExcel: TMenuItem
      Caption = 'Copia in Excel'
      OnClick = mnuCopiaExcelClick
    end
  end
end
