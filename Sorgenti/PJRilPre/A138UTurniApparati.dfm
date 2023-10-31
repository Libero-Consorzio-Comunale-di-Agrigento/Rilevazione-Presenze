inherited A138FTurniApparati: TA138FTurniApparati
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = '<A138> Apparati'
  ClientHeight = 399
  OnResize = FormResize
  ExplicitWidth = 519
  ExplicitHeight = 453
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 381
    ExplicitTop = 381
  end
  object PageControl1: TPageControl [3]
    Left = 0
    Top = 63
    Width = 511
    Height = 318
    ActivePage = tabTipoApparati
    Align = alClient
    TabOrder = 3
    OnChange = PageControl1Change
    OnChanging = PageControl1Changing
    ExplicitTop = 64
    object tabApparati: TTabSheet
      Caption = 'Apparati'
      object Panel1: TPanel
        Left = 0
        Top = 89
        Width = 503
        Height = 201
        Align = alClient
        TabOrder = 0
        object GrpBoxFiltro1: TGroupBox
          Left = 1
          Top = 1
          Width = 185
          Height = 199
          Align = alLeft
          Caption = 'Filtro1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          object ChkFiltro1: TCheckListBox
            Left = 2
            Top = 15
            Width = 181
            Height = 182
            Align = alClient
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Style = []
            ItemHeight = 14
            ParentFont = False
            PopupMenu = PopMenuFiltro1
            TabOrder = 0
          end
        end
        object GrpBoxFiltro2: TGroupBox
          Left = 186
          Top = 1
          Width = 131
          Height = 199
          Align = alClient
          Caption = 'Filtro2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          object ChkFiltro2: TCheckListBox
            Left = 2
            Top = 15
            Width = 127
            Height = 182
            Align = alClient
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Style = []
            ItemHeight = 14
            ParentFont = False
            PopupMenu = PopMenuFiltro1
            TabOrder = 0
          end
        end
        object GrpBoxFiltroServizi: TGroupBox
          Left = 317
          Top = 1
          Width = 185
          Height = 199
          Align = alRight
          Caption = 'Filtro servizi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          object ChkFiltroServizi: TCheckListBox
            Left = 2
            Top = 15
            Width = 181
            Height = 182
            Align = alClient
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Style = []
            ItemHeight = 14
            ParentFont = False
            PopupMenu = PopMenuFiltro1
            TabOrder = 0
          end
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 503
        Height = 89
        Align = alTop
        TabOrder = 1
        object Label3: TLabel
          Left = 28
          Top = 69
          Width = 55
          Height = 13
          Caption = 'Descrizione'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object DLbl: TDBText
          Left = 221
          Top = 13
          Width = 22
          Height = 13
          AutoSize = True
          DataField = 'desccod_apparato'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label1: TLabel
          Left = 4
          Top = 15
          Width = 79
          Height = 13
          Caption = 'Codice Apparato'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label2: TLabel
          Left = 50
          Top = 41
          Width = 33
          Height = 13
          Caption = 'Codice'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object DEdtDesc: TDBEdit
          Left = 93
          Top = 65
          Width = 406
          Height = 21
          DataField = 'DESCRIZIONE'
          DataSource = DButton
          TabOrder = 4
        end
        object GroupStato: TDBRadioGroup
          Left = 367
          Top = 2
          Width = 130
          Height = 60
          Caption = 'Stato'
          DataField = 'STATO'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Items.Strings = (
            'Disponibile'
            'Occupato'
            'Non funzionante')
          ParentBackground = True
          ParentFont = False
          TabOrder = 3
          Values.Strings = (
            'D'
            'O'
            'N')
        end
        object DEdtCodice: TDBEdit
          Left = 93
          Top = 38
          Width = 122
          Height = 21
          DataField = 'CODICE'
          DataSource = DButton
          TabOrder = 1
        end
        object DCmbCodApparato: TDBLookupComboBox
          Left = 93
          Top = 11
          Width = 122
          Height = 21
          DataField = 'COD_APPARATO'
          DataSource = DButton
          KeyField = 'CODICE'
          ListField = 'CODICE'
          ListSource = A138FTurniApparatiDTM.dsrT555
          TabOrder = 0
          OnKeyDown = DCmbCodApparatoKeyDown
        end
        object dchkRadio: TDBCheckBox
          Left = 221
          Top = 42
          Width = 94
          Height = 17
          Caption = 'Radio a bordo'
          DataField = 'DOTAZ_RADIO'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
      end
    end
    object tabTipoApparati: TTabSheet
      Caption = 'Tipo Apparati'
      ImageIndex = 1
      object DGrdTApparati: TDBGrid
        Left = 0
        Top = 0
        Width = 503
        Height = 290
        Align = alClient
        DataSource = A138FTurniApparatiDTM.dsrT555
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clBlue
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
    end
  end
  inherited DButton: TDataSource
    DataSet = A138FTurniApparatiDTM.selT550
  end
  object PopMenuFiltro1: TPopupMenu
    Left = 116
    Top = 192
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      OnClick = Annullatutto1Click
    end
    object Annullatutto1: TMenuItem
      Caption = 'Annulla tutto'
      OnClick = Annullatutto1Click
    end
  end
end
