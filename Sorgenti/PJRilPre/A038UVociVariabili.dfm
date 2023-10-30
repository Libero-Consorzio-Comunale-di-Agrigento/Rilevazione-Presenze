object A038FVociVariabili: TA038FVociVariabili
  Left = 249
  Top = 180
  HelpContext = 38000
  Caption = '<A038> Voci variabili scaricate'
  ClientHeight = 468
  ClientWidth = 692
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 449
    Width = 692
    Height = 19
    Panels = <
      item
        Width = 100
      end
      item
        Width = 50
      end>
    SimpleText = '1 Record'
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 692
    Height = 24
    Align = alTop
    TabOrder = 1
    TabStop = True
    ExplicitWidth = 692
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 692
      Height = 24
      ExplicitWidth = 692
      ExplicitHeight = 24
      inherited btnSelezione: TBitBtn
        OnClick = frmSelAnagrafebtnSelezioneClick
      end
    end
    inherited pmnuDatiAnagrafici: TPopupMenu
      inherited R003Datianagrafici: TMenuItem
        OnClick = frmSelAnagrafeR003DatianagraficiClick
      end
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 24
    Width = 692
    Height = 425
    ActivePage = tabFiltro
    Align = alClient
    TabOrder = 2
    OnChange = PageControl1Change
    object tabFiltro: TTabSheet
      Caption = 'Filtro'
      object Panel1: TPanel
        Left = 125
        Top = 0
        Width = 559
        Height = 397
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object CheckListBox1: TCheckListBox
          Left = 0
          Top = 33
          Width = 136
          Height = 364
          OnClickCheck = CheckListBox1ClickCheck
          Align = alLeft
          ItemHeight = 13
          PopupMenu = PopupMenu1
          TabOrder = 0
        end
        object CheckListBox2: TCheckListBox
          Left = 136
          Top = 33
          Width = 423
          Height = 364
          OnClickCheck = CheckListBox1ClickCheck
          Align = alClient
          ItemHeight = 13
          PopupMenu = PopupMenu1
          TabOrder = 1
        end
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 559
          Height = 33
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 2
          object Label3: TLabel
            Left = 4
            Top = 0
            Width = 65
            Height = 13
            Caption = 'Voci paghe'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label4: TLabel
            Left = 140
            Top = 0
            Width = 75
            Height = 13
            Caption = 'Codici interni'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object chkVoci: TCheckBox
            Left = 4
            Top = 14
            Width = 117
            Height = 17
            Caption = 'Voci selezionate'
            TabOrder = 0
            OnClick = AttivaFiltroClick
          end
          object chkCodici: TCheckBox
            Left = 140
            Top = 14
            Width = 117
            Height = 17
            Caption = 'Voci selezionate'
            TabOrder = 1
            OnClick = AttivaFiltroClick
          end
        end
      end
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 125
        Height = 397
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 1
        object chkTuttiDipendenti: TCheckBox
          Left = 6
          Top = 6
          Width = 113
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Tutti i dipendenti'
          TabOrder = 0
          OnClick = chkTuttiDipendentiClick
        end
        object chkMeseCassa: TCheckBox
          Left = 6
          Top = 146
          Width = 113
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Mese di cassa'
          TabOrder = 1
          OnClick = AttivaFiltroClick
        end
        object cmbMeseCassa: TComboBox
          Left = 6
          Top = 163
          Width = 114
          Height = 21
          Style = csDropDownList
          DropDownCount = 12
          TabOrder = 2
          OnChange = cmbMeseCassaChange
        end
        object rgpTipoElenco: TRadioGroup
          Left = 6
          Top = 267
          Width = 114
          Height = 57
          Caption = 'Elenco voci'
          ItemIndex = 1
          Items.Strings = (
            'Dettagliato'
            'Riassuntivo')
          TabOrder = 4
          OnClick = rgpTipoElencoClick
        end
        object chkTipoVoci: TGroupBox
          Left = 6
          Top = 191
          Width = 114
          Height = 73
          Caption = 'Tipo voci'
          TabOrder = 3
          object chkUMNumero: TCheckBox
            Left = 6
            Top = 16
            Width = 101
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Numero/Quantit'#224
            Checked = True
            State = cbChecked
            TabOrder = 0
            OnClick = AttivaFiltroClick
          end
          object chkUMOre: TCheckBox
            Left = 6
            Top = 34
            Width = 101
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Ore'
            Checked = True
            State = cbChecked
            TabOrder = 1
            OnClick = AttivaFiltroClick
          end
          object chkUMValuta: TCheckBox
            Left = 6
            Top = 52
            Width = 101
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Valuta'
            Checked = True
            State = cbChecked
            TabOrder = 2
            OnClick = AttivaFiltroClick
          end
        end
        inline frmInputPeriodo: TfrmInputPeriodo
          Left = 3
          Top = 29
          Width = 118
          Height = 111
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentBackground = False
          ParentColor = False
          ParentFont = False
          TabOrder = 5
          ExplicitLeft = 3
          ExplicitTop = 29
          ExplicitWidth = 118
          ExplicitHeight = 111
          inherited lblInizio: TLabel
            Top = 3
            Width = 44
            Caption = 'Dal mese'
            ExplicitTop = 3
            ExplicitWidth = 44
          end
          inherited lblFine: TLabel
            Left = 8
            Top = 43
            Width = 37
            Caption = 'Al mese'
            ExplicitLeft = 8
            ExplicitTop = 43
            ExplicitWidth = 37
          end
          inherited edtInizio: TMaskEdit
            Left = 3
            Top = 19
            Width = 90
            OnExit = frmInputPeriodoedtInizioExit
            ExplicitLeft = 3
            ExplicitTop = 19
            ExplicitWidth = 90
          end
          inherited edtFine: TMaskEdit
            Left = 3
            Top = 59
            Width = 90
            OnExit = frmInputPeriodoedtFineExit
            ExplicitLeft = 3
            ExplicitTop = 59
            ExplicitWidth = 90
          end
          inherited btnIndietro: TBitBtn
            Left = 71
            Top = 83
            OnClick = frmInputPeriodobtnIndietroClick
            ExplicitLeft = 71
            ExplicitTop = 83
          end
          inherited btnAvanti: TBitBtn
            Left = 93
            Top = 83
            OnClick = frmInputPeriodobtnAvantiClick
            ExplicitLeft = 93
            ExplicitTop = 83
          end
          inherited btnDataInizio: TBitBtn
            Left = 93
            Top = 18
            OnClick = frmInputPeriodobtnDataInizioClick
            ExplicitLeft = 93
            ExplicitTop = 18
          end
          inherited btnDataFine: TBitBtn
            Left = 93
            Top = 58
            OnClick = frmInputPeriodobtnDataFineClick
            ExplicitLeft = 93
            ExplicitTop = 58
          end
        end
      end
    end
    object tabVoci: TTabSheet
      Caption = 'Voci scaricate'
      ImageIndex = 1
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 684
        Height = 397
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = PopupMenu2
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clBlue
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
    end
  end
  object MainMenu1: TMainMenu
    Left = 100
    Top = 65525
    object File1: TMenuItem
      Caption = 'File'
      object Stampa1: TMenuItem
        Caption = 'Stampa'
        OnClick = Stampa1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Decodificavoci1: TMenuItem
        Caption = 'Decodifica voci'
        OnClick = Decodificavoci1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Esci1: TMenuItem
        Caption = 'Esci'
        OnClick = Esci1Click
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 257
    Top = 164
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      OnClick = Annullatutto1Click
    end
    object Annullatutto1: TMenuItem
      Caption = 'Annulla tutto'
      OnClick = Annullatutto1Click
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 521
    Top = 172
    object CopiaInExcel: TMenuItem
      Caption = 'Copia in Excel'
      OnClick = CopiaInExcelClick
    end
  end
end
