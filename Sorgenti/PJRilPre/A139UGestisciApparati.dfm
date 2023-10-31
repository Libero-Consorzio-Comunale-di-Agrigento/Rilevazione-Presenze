inherited A139FGestisciApparati: TA139FGestisciApparati
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '<A139> Dotazione della Pattuglia'
  ClientHeight = 245
  ClientWidth = 381
  ExplicitWidth = 389
  ExplicitHeight = 291
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 227
    Width = 381
    ExplicitTop = 227
    ExplicitWidth = 381
  end
  inherited Panel1: TToolBar
    Width = 381
    ExplicitWidth = 381
  end
  object DBGridApparati: TDBGrid [2]
    Left = 0
    Top = 117
    Width = 381
    Height = 110
    Align = alClient
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = DBGridApparatiDblClick
    OnEditButtonClick = DBGridApparatiEditButtonClick
    OnKeyUp = DBGridApparatiKeyUp
    Columns = <
      item
        Expanded = False
        FieldName = 'PATTUGLIA'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'DATA'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'TIPO'
        Visible = False
      end
      item
        DropDownRows = 10
        Expanded = False
        FieldName = 'DescTipo'
        Visible = True
      end
      item
        ButtonStyle = cbsEllipsis
        Expanded = False
        FieldName = 'DescApparato'
        Visible = True
      end>
  end
  object GroupBox1: TGroupBox [3]
    Left = 0
    Top = 29
    Width = 381
    Height = 88
    Align = alTop
    Caption = 'Filtro'
    TabOrder = 3
    object chkServizio: TCheckBox
      Left = 12
      Top = 16
      Width = 94
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Servizio'
      TabOrder = 0
    end
    object chkCampo1: TCheckBox
      Left = 12
      Top = 39
      Width = 94
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Campo1'
      TabOrder = 1
    end
    object chkCampo2: TCheckBox
      Left = 12
      Top = 64
      Width = 94
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Campo2'
      TabOrder = 2
    end
    object dcmbCampo1: TDBLookupComboBox
      Left = 120
      Top = 37
      Width = 253
      Height = 21
      KeyField = 'CODICE'
      ListField = 'DESCRIZIONE'
      ListSource = A139FPianifServiziDtm.dsrCampo1
      TabOrder = 3
    end
    object dcmbCampo2: TDBLookupComboBox
      Left = 120
      Top = 62
      Width = 253
      Height = 21
      KeyField = 'CODICE'
      ListField = 'DESCRIZIONE'
      ListSource = A139FPianifServiziDtm.dsrCampo2
      TabOrder = 4
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 240
    Top = 10
  end
  inherited DButton: TDataSource
    AutoEdit = True
    Left = 268
    Top = 10
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 296
    Top = 10
  end
  inherited ImageList1: TImageList
    Left = 324
    Top = 10
  end
  inherited ActionList1: TActionList
    Left = 352
    Top = 10
  end
end
