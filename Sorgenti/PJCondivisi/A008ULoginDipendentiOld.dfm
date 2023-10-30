inherited A008FLoginDipendentiOld: TA008FLoginDipendentiOld
  Left = 241
  Top = 164
  HelpContext = 8200
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '<A008> Gestione login dipendenti'
  ClientHeight = 421
  ClientWidth = 612
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 404
    Width = 612
    Height = 17
  end
  inherited Panel1: TToolBar
    Width = 612
    TabOrder = 0
  end
  object pnlDatiGenerali: TPanel [2]
    Left = 0
    Top = 29
    Width = 612
    Height = 100
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    object Label1: TLabel
      Left = 12
      Top = 9
      Width = 41
      Height = 13
      Caption = 'Azienda:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object DBText1: TDBText
      Left = 212
      Top = 9
      Width = 50
      Height = 13
      AutoSize = True
      DataField = 'DESCRIZIONE'
      DataSource = A008FOperatoriDtM1.dselI090
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblFiltroFunzioni: TLabel
      Left = 12
      Top = 35
      Width = 61
      Height = 13
      Caption = 'Filtro funzioni'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dcmbAzienda: TDBLookupComboBox
      Left = 58
      Top = 5
      Width = 145
      Height = 21
      DataField = 'AZIENDA'
      DataSource = A008FOperatoriDtM1.D090
      DropDownWidth = 200
      KeyField = 'Azienda'
      ListField = 'Azienda;Descrizione'
      ListSource = A008FOperatoriDtM1.dselI090
      TabOrder = 0
    end
    object btnInserisciLogin: TBitBtn
      Left = 229
      Top = 29
      Width = 100
      Height = 25
      Caption = 'Inserisci login'
      TabOrder = 1
      OnClick = btnInserisciLoginClick
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFF1FFFFF4FFFFFFFFF11FF4F4F4FFFFFFF111FF444FFFFFFFF111144444FFF
        FFFF111FF444FFFFFFFF11FF4F40480FFFFF1FFFFF4FF005050FFFFFF000FFF0
        F0FFFFFF077FFFF0F0FFFFFF0770FFFF0F0FFFFF0770FF00FF0FFFFF07770FF0
        FFF0FFFF80777770F00FFFFFFF000008FF0FFFFFFFFF0888880F}
    end
    object cmbFiltroFunzioni: TComboBox
      Left = 80
      Top = 31
      Width = 120
      Height = 21
      ItemHeight = 13
      TabOrder = 2
    end
    object chkAssegnaPwd: TCheckBox
      Left = 381
      Top = 6
      Width = 139
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Assegna password'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object BitBtn1: TBitBtn
      Left = 349
      Top = 29
      Width = 100
      Height = 25
      Caption = 'Inserisci login'
      TabOrder = 4
      OnClick = btnInserisciLoginClick
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFF1FFFFF4FFFFFFFFF11FF4F4F4FFFFFFF111FF444FFFFFFFF111144444FFF
        FFFF111FF444FFFFFFFF11FF4F40480FFFFF1FFFFF4FF005050FFFFFF000FFF0
        F0FFFFFF077FFFF0F0FFFFFF0770FFFF0F0FFFFF0770FF00FF0FFFFF07770FF0
        FFF0FFFF80777770F00FFFFFFF000008FF0FFFFFFFFF0888880F}
    end
  end
  object pnlDatiDipendente: TPanel [3]
    Left = 0
    Top = 129
    Width = 612
    Height = 275
    Align = alClient
    TabOrder = 3
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 610
      Height = 25
      Align = alTop
      Caption = 'Dettaglio login dipendenti'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object dgrdLoginDipendente: TDBGrid
      Left = 1
      Top = 26
      Width = 610
      Height = 248
      Align = alClient
      DataSource = A008FOperatoriDtM1.dselI060
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit]
      ParentFont = False
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlue
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Color = clBtnFace
          Expanded = False
          FieldName = 'ROWNUM'
          Title.Caption = '  '
          Width = 31
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MATRICOLA'
          Title.Caption = 'Matricola'
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOME_UTENTE'
          Title.Caption = 'Nome utente'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PASSWORD'
          Title.Caption = 'Password'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FILTRO_FUNZIONI'
          Title.Caption = 'Filtro funzioni'
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FILTRO_ANAGRAFE'
          Title.Caption = 'Filtro anagrafe'
          Width = 120
          Visible = True
        end
        item
          Color = clBtnFace
          Expanded = False
          FieldName = 'D_NOMINATIVO'
          Title.Caption = 'Nominativo'
          Width = 250
          Visible = True
        end>
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 478
    Top = 3
  end
  inherited DButton: TDataSource
    Left = 506
    Top = 3
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 450
    Top = 3
  end
  inherited ImageList1: TImageList
    Left = 380
    Top = 2
  end
  inherited ActionList1: TActionList
    Left = 408
    Top = 2
  end
end
