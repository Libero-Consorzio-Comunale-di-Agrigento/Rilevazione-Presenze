object A008FProfili: TA008FProfili
  Left = 152
  Top = 205
  HelpContext = 8300
  Caption = '<A008> Profili'
  ClientHeight = 472
  ClientWidth = 689
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 689
    Height = 29
    Caption = 'ToolBar1'
    Flat = False
    Images = ImageList1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Action = actNuovoProfilo
    end
    object ToolButton7: TToolButton
      Left = 23
      Top = 0
      Action = actCopiaSu
    end
    object ToolButton2: TToolButton
      Left = 46
      Top = 0
      Action = actCancellaProfilo
    end
    object ToolButton3: TToolButton
      Left = 69
      Top = 0
      Width = 8
      Caption = 'ToolButton3'
      ImageIndex = 2
      Style = tbsSeparator
    end
    object ToolButton4: TToolButton
      Left = 77
      Top = 0
      Action = actModificaProfilo
    end
    object ToolButton5: TToolButton
      Left = 100
      Top = 0
      Action = actConferma
    end
    object ToolButton6: TToolButton
      Left = 123
      Top = 0
      Action = actAnnulla
    end
    object ToolButton8: TToolButton
      Left = 146
      Top = 0
      Width = 8
      Caption = 'ToolButton8'
      ImageIndex = 6
      Style = tbsSeparator
    end
    object lblAzienda: TLabel
      Left = 154
      Top = 0
      Width = 44
      Height = 22
      Caption = 'Azienda: '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
    end
    object cmbSelAzin: TComboBox
      Left = 198
      Top = 0
      Width = 145
      Height = 21
      Style = csDropDownList
      TabOrder = 0
      OnChange = cmbSelAzinChange
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 453
    Width = 689
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 29
    Width = 689
    Height = 424
    ActivePage = tabFiltroDizionario
    Align = alClient
    TabOrder = 2
    OnChange = PageControl1Change
    OnChanging = PageControl1Changing
    object tabPermessi: TTabSheet
      Caption = 'Permessi'
      object dlstPermessi: TDBLookupListBox
        Left = 0
        Top = 0
        Width = 150
        Height = 394
        Align = alLeft
        KeyField = 'PROFILO'
        ListField = 'PROFILO'
        ListSource = A008FOperatoriDtm1.dsrI071
        TabOrder = 0
      end
      object PageControl2: TPageControl
        Left = 150
        Top = 0
        Width = 531
        Height = 396
        ActivePage = tabPermessiBase
        Align = alClient
        Style = tsFlatButtons
        TabOrder = 1
        object tabPermessiBase: TTabSheet
          Caption = 'Moduli base'
          object Label8: TLabel
            Left = 239
            Top = 167
            Width = 141
            Height = 13
            Caption = 'Dati anagrafici di intestazione:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object GroupBox3: TGroupBox
            Left = 0
            Top = 0
            Width = 225
            Height = 195
            Caption = 'Anagrafico'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            object Label5: TLabel
              Left = 9
              Top = 14
              Width = 126
              Height = 13
              Caption = 'Layout scheda anagrafica:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object lblAnag: TLabel
              Left = 169
              Top = 51
              Width = 23
              Height = 13
              Caption = 'Gen.'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object lblAnagP430: TLabel
              Left = 200
              Top = 51
              Width = 21
              Height = 13
              Caption = 'Stip.'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object DBCheckBox12: TDBCheckBox
              Left = 9
              Top = 64
              Width = 178
              Height = 17
              Alignment = taLeftJustify
              Caption = 'Inserimento anagrafiche'
              DataField = 'INSERIMENTO_MATRICOLE'
              DataSource = A008FOperatoriDtm1.dsrI071
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object DBCheckBox13: TDBCheckBox
              Left = 9
              Top = 79
              Width = 178
              Height = 17
              Alignment = taLeftJustify
              Caption = 'Storicizzazione dati'
              DataField = 'STORICIZZAZIONE'
              DataSource = A008FOperatoriDtm1.dsrI071
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 3
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object DBLookupComboBox1: TDBLookupComboBox
              Left = 9
              Top = 28
              Width = 207
              Height = 21
              DataField = 'LAYOUT'
              DataSource = A008FOperatoriDtm1.dsrI071
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              KeyField = 'NOME'
              ListField = 'NOME'
              ListSource = A008FOperatoriDtm1.dsrT033
              ParentFont = False
              TabOrder = 0
              OnKeyDown = DBLookupComboBox1KeyDown
            end
            object dchkModificaPersonaleEsterno: TDBCheckBox
              Left = 9
              Top = 139
              Width = 178
              Height = 17
              Alignment = taLeftJustify
              Caption = 'Modifica personale esterno'
              DataField = 'MOD_PERSONALE_ESTERNO'
              DataSource = A008FOperatoriDtm1.dsrI071
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 9
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object DBRadioGroup3: TDBRadioGroup
              Left = 9
              Top = 158
              Width = 207
              Height = 30
              Caption = 'Default tipo personale'
              Columns = 2
              DataField = 'DEF_TIPO_PERSONALE'
              DataSource = A008FOperatoriDtm1.dsrI071
              Items.Strings = (
                'Interno'
                'Esterno')
              TabOrder = 10
              Values.Strings = (
                'I'
                'E')
            end
            object dchkEliminaStorici: TDBCheckBox
              Left = 9
              Top = 109
              Width = 178
              Height = 17
              Alignment = taLeftJustify
              Caption = 'Cancellazione storici'
              DataField = 'ELIMINA_STORICI'
              DataSource = A008FOperatoriDtm1.dsrI071
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 7
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object dchkModificaDecorrenza: TDBCheckBox
              Left = 9
              Top = 94
              Width = 178
              Height = 17
              Alignment = taLeftJustify
              Caption = 'Modifica decorrenze'
              DataField = 'MODIFICA_DECORRENZA'
              DataSource = A008FOperatoriDtm1.dsrI071
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 5
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object dchkInserimentoMatricoleP430: TDBCheckBox
              Left = 198
              Top = 64
              Width = 18
              Height = 17
              Alignment = taLeftJustify
              Caption = ' '
              DataField = 'INSERIMENTO_MATRICOLE_P430'
              DataSource = A008FOperatoriDtm1.dsrI071
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object dchkStoricizzazioneP430: TDBCheckBox
              Left = 198
              Top = 79
              Width = 18
              Height = 17
              Alignment = taLeftJustify
              Caption = ' '
              DataField = 'STORICIZZAZIONE_P430'
              DataSource = A008FOperatoriDtm1.dsrI071
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 4
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object dchkModificaDecorrenzaP430: TDBCheckBox
              Left = 198
              Top = 94
              Width = 18
              Height = 17
              Alignment = taLeftJustify
              Caption = ' '
              DataField = 'MODIFICA_DECORRENZA_P430'
              DataSource = A008FOperatoriDtm1.dsrI071
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 6
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object dchkEliminaStoriciP430: TDBCheckBox
              Left = 198
              Top = 109
              Width = 18
              Height = 17
              Alignment = taLeftJustify
              Caption = ' '
              DataField = 'ELIMINA_STORICI_P430'
              DataSource = A008FOperatoriDtm1.dsrI071
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 8
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object dchkStoriaInizioFine: TDBCheckBox
              Left = 9
              Top = 124
              Width = 178
              Height = 17
              Alignment = taLeftJustify
              Caption = 'Storia dato con inizio-fine servizio'
              DataField = 'STORIA_INIZIO_FINE'
              DataSource = A008FOperatoriDtm1.dsrI071
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 11
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
          end
          object GroupBox1: TGroupBox
            Left = 0
            Top = 201
            Width = 225
            Height = 126
            Caption = 'Timbrature'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            object DBCheckBox1: TDBCheckBox
              Left = 9
              Top = 45
              Width = 207
              Height = 17
              Alignment = taLeftJustify
              Caption = 'Cancellazione timbr. manuali'
              DataField = 'CANCELLA_TIMBRATURE'
              DataSource = A008FOperatoriDtm1.dsrI071
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object DBCheckBox5: TDBCheckBox
              Left = 9
              Top = 75
              Width = 207
              Height = 17
              Alignment = taLeftJustify
              Caption = 'Modifica Ora'
              DataField = 'T100_ORA'
              DataSource = A008FOperatoriDtm1.dsrI071
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 4
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object DBCheckBox6: TDBCheckBox
              Left = 9
              Top = 90
              Width = 207
              Height = 17
              Alignment = taLeftJustify
              Caption = 'Modifica Rilevatore'
              DataField = 'T100_RILEVATORE'
              DataSource = A008FOperatoriDtm1.dsrI071
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 5
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object DBCheckBox7: TDBCheckBox
              Left = 9
              Top = 105
              Width = 207
              Height = 17
              Alignment = taLeftJustify
              Caption = 'Modifica Causale'
              DataField = 'T100_CAUSALE'
              DataSource = A008FOperatoriDtm1.dsrI071
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 6
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object DBCheckBox10: TDBCheckBox
              Left = 9
              Top = 15
              Width = 207
              Height = 17
              Alignment = taLeftJustify
              Caption = 'Ripristino timbrature originali'
              DataField = 'RIPRISTINO_TIMB_ORI'
              DataSource = A008FOperatoriDtm1.dsrI071
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object DBCheckBox22: TDBCheckBox
              Left = 9
              Top = 30
              Width = 207
              Height = 17
              Alignment = taLeftJustify
              Caption = 'Inserimento'
              DataField = 'INSERISCI_TIMBRATURE'
              DataSource = A008FOperatoriDtm1.dsrI071
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object chkCancTimbOrig: TDBCheckBox
              Left = 9
              Top = 60
              Width = 207
              Height = 17
              Alignment = taLeftJustify
              Caption = 'Cancellazione timbr. originali'
              DataField = 'T100_CANC_ORIGINALI'
              DataSource = A008FOperatoriDtm1.dsrI071
              TabOrder = 3
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
          end
          object GroupBox2: TGroupBox
            Left = 230
            Top = 0
            Width = 225
            Height = 96
            Caption = 'Scheda riepilogativa'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            object DBCheckBox3: TDBCheckBox
              Left = 9
              Top = 15
              Width = 207
              Height = 17
              Alignment = taLeftJustify
              Caption = 'Saldi'
              DataField = 'A029_SALDI'
              DataSource = A008FOperatoriDtm1.dsrI071
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object DBCheckBox4: TDBCheckBox
              Left = 9
              Top = 30
              Width = 207
              Height = 17
              Alignment = taLeftJustify
              Caption = 'Indennit'#224
              DataField = 'A029_INDENNITA'
              DataSource = A008FOperatoriDtm1.dsrI071
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object DBCheckBox8: TDBCheckBox
              Left = 9
              Top = 45
              Width = 207
              Height = 17
              Alignment = taLeftJustify
              Caption = 'Straordinario'
              DataField = 'A029_STRAORDINARIO'
              DataSource = A008FOperatoriDtm1.dsrI071
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object DBCheckBox9: TDBCheckBox
              Left = 9
              Top = 60
              Width = 207
              Height = 17
              Alignment = taLeftJustify
              Caption = 'Riepilogo presenze'
              DataField = 'A029_CAUPRESENZA'
              DataSource = A008FOperatoriDtm1.dsrI071
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 3
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object DBCheckBox11: TDBCheckBox
              Left = 9
              Top = 75
              Width = 207
              Height = 17
              Alignment = taLeftJustify
              Caption = 'Liquidaz. ore non disponibili'
              DataField = 'LIQUIDAZIONE_FORZATA'
              DataSource = A008FOperatoriDtm1.dsrI071
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 4
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
          end
          object GroupBox5: TGroupBox
            Left = 230
            Top = 97
            Width = 225
            Height = 67
            Caption = 'Variazione limiti eccedenze orarie'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            object DBCheckBox20: TDBCheckBox
              Left = 9
              Top = 30
              Width = 207
              Height = 17
              Alignment = taLeftJustify
              Caption = 'Limiti annuali'
              DataField = 'A094_ANNO'
              DataSource = A008FOperatoriDtm1.dsrI071
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object DBCheckBox19: TDBCheckBox
              Left = 9
              Top = 15
              Width = 207
              Height = 17
              Alignment = taLeftJustify
              Caption = 'Limiti mensili'
              DataField = 'A094_MESE'
              DataSource = A008FOperatoriDtm1.dsrI071
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object DBCheckBox21: TDBCheckBox
              Left = 9
              Top = 45
              Width = 207
              Height = 17
              Alignment = taLeftJustify
              Caption = 'Limiti per raggruppamento'
              DataField = 'A094_RAGGR'
              DataSource = A008FOperatoriDtm1.dsrI071
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
          end
          object DBCheckBox17: TDBCheckBox
            Left = 239
            Top = 240
            Width = 207
            Height = 18
            Alignment = taLeftJustify
            Caption = 'Ricreazione file per lo scarico paghe'
            DataField = 'RICREA_SCARICO_PAGHE'
            DataSource = A008FOperatoriDtm1.dsrI071
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 9
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
          object dedtDatiC700: TDBEdit
            Left = 239
            Top = 183
            Width = 192
            Height = 21
            DataField = 'DATIC700'
            DataSource = A008FOperatoriDtm1.dsrI071
            TabOrder = 5
          end
          object btnDatiC700: TButton
            Left = 432
            Top = 183
            Width = 14
            Height = 21
            Caption = '...'
            TabOrder = 6
            OnClick = btnDatiC700Click
          end
          object DBCheckBox2: TDBCheckBox
            Left = 239
            Top = 225
            Width = 207
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Eludi blocchi su riepiloghi'
            DataField = 'ABILITA_SCHEDE_CHIUSE'
            DataSource = A008FOperatoriDtm1.dsrI071
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 8
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
          object DBCheckBox14: TDBCheckBox
            Left = 239
            Top = 210
            Width = 207
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Utility aggiornamento base dati'
            DataField = 'CANCELLAZIONE_DATI'
            DataSource = A008FOperatoriDtm1.dsrI071
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
          object DBCheckBox16: TDBCheckBox
            Left = 239
            Top = 255
            Width = 207
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Elim. voci scaricate/buoni acquistati'
            DataField = 'ELIMINA_DATA_CASSA'
            DataSource = A008FOperatoriDtm1.dsrI071
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 10
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
          object dChkModificaDatiProtetti: TDBCheckBox
            Left = 239
            Top = 270
            Width = 207
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Permetti modifica dati protetti'
            DataField = 'MODIFICA_DATI_PROTETTI'
            DataSource = A008FOperatoriDtm1.dsrI071
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 11
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
          object drgpC700SalvaSelezioni: TDBRadioGroup
            Left = 0
            Top = 332
            Width = 225
            Height = 30
            Caption = 'Registrazione selezioni anagrafiche'
            Columns = 3
            DataField = 'C700_SALVASELEZIONI'
            DataSource = A008FOperatoriDtm1.dsrI071
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Items.Strings = (
              'Abilitata'
              'Disabilitata'
              'Inserimento')
            ParentFont = False
            TabOrder = 2
            Values.Strings = (
              'S'
              'N'
              'I')
          end
          object chkPasswordDipendenti: TDBCheckBox
            Left = 239
            Top = 285
            Width = 207
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Permetti modifica password dipendenti'
            DataField = 'I060_PASSWORD'
            DataSource = A008FOperatoriDtm1.dsrI071
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 12
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
          object chkPasswordOperatori: TDBCheckBox
            Left = 239
            Top = 300
            Width = 207
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Permetti modifica password operatori'
            DataField = 'I070_PASSWORD'
            DataSource = A008FOperatoriDtm1.dsrI071
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 13
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
          object dchkAccessibilitaNonVedenti: TDBCheckBox
            Left = 239
            Top = 330
            Width = 207
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Accessibilit'#224' operatori non vedenti'
            DataField = 'ACCESSIBILITA_NONVEDENTI'
            DataSource = A008FOperatoriDtm1.dsrI071
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 15
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
          object dChkDownloadMassivo: TDBCheckBox
            Left = 239
            Top = 315
            Width = 207
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Permetti download massivo allegati iter'
            DataField = 'DOWNLOAD_MASSIVO'
            DataSource = A008FOperatoriDtm1.dsrI071
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 14
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
        end
        object tabPermessiAccessori: TTabSheet
          Caption = 'Moduli accessori'
          ImageIndex = 1
          object Label6: TLabel
            Left = 4
            Top = 172
            Width = 165
            Height = 13
            Caption = 'Gestione trasferte - anticipi gestibili:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object DBRadioGroup1: TDBRadioGroup
            Left = 0
            Top = 0
            Width = 225
            Height = 58
            Caption = 'Pianificazione orari operativa'
            DataField = 'A058_OPERATIVA'
            DataSource = A008FOperatoriDtm1.dsrI071
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Items.Strings = (
              'Visualizzazione'
              'Inserimento/Modifica'
              'Inserimento/Modifica/Cancellaz.')
            ParentFont = False
            TabOrder = 0
            Values.Strings = (
              'N'
              'M'
              'S')
          end
          object DBRadioGroup2: TDBRadioGroup
            Left = 0
            Top = 59
            Width = 225
            Height = 58
            Caption = 'Pianificazione orari non operativa'
            DataField = 'A058_NONOPERATIVA'
            DataSource = A008FOperatoriDtm1.dsrI071
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Items.Strings = (
              'Visualizzazione'
              'Inserimento/Modifica'
              'Inserimento/Modifica/Cancellaz.')
            ParentFont = False
            TabOrder = 1
            Values.Strings = (
              'N'
              'M'
              'S')
          end
          object GroupBox6: TGroupBox
            Left = 0
            Top = 285
            Width = 225
            Height = 71
            Caption = 'Pianificazione servizi'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
            Visible = False
            object Label7: TLabel
              Left = 10
              Top = 48
              Width = 95
              Height = 13
              Caption = 'Tipi turno accessibili'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object DBCheckBox25: TDBCheckBox
              Left = 8
              Top = 12
              Width = 207
              Height = 17
              Alignment = taLeftJustify
              Caption = 'Blocco servizi'
              DataField = 'SERVIZI_BLOCCO'
              DataSource = A008FOperatoriDtm1.dsrI071
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object DBCheckBox26: TDBCheckBox
              Left = 8
              Top = 27
              Width = 207
              Height = 17
              Alignment = taLeftJustify
              Caption = 'Sblocco servizi'
              DataField = 'SERVIZI_SBLOCCO'
              DataSource = A008FOperatoriDtm1.dsrI071
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object DBComboBox1: TDBComboBox
              Left = 173
              Top = 45
              Width = 42
              Height = 21
              DataField = 'SERVIZI_COMANDATI'
              DataSource = A008FOperatoriDtm1.dsrI071
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              Items.Strings = (
                'Comandati'
                'Normali'
                'Tutti')
              ParentFont = False
              TabOrder = 2
            end
          end
          object DEdtAnticipi: TDBEdit
            Left = 4
            Top = 187
            Width = 170
            Height = 21
            Color = clBtnFace
            DataField = 'A131_ANTICIPIGESTIBILI'
            DataSource = A008FOperatoriDtm1.dsrI071
            ReadOnly = True
            TabOrder = 3
          end
          object BtnAnticipi: TButton
            Left = 174
            Top = 188
            Width = 15
            Height = 21
            Caption = '...'
            TabOrder = 4
            OnClick = BtnAnticipiClick
          end
          object DBCheckBox24: TDBCheckBox
            Left = 4
            Top = 128
            Width = 216
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Validazione assenze su tab.turni'
            DataField = 'T040_VALIDAZIONE'
            DataSource = A008FOperatoriDtm1.dsrI071
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
          object GroupBox4: TGroupBox
            Left = 231
            Top = 0
            Width = 225
            Height = 105
            Caption = 'IrisWEB - Stampa cartellino'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
            object Label12: TLabel
              Left = 9
              Top = 19
              Width = 96
              Height = 13
              Caption = 'Disponibile dal mese'
            end
            object Label13: TLabel
              Left = 9
              Top = 43
              Width = 152
              Height = 13
              Caption = 'Mesi indietro rispetto al corrente:'
            end
            object Label14: TLabel
              Left = 9
              Top = 66
              Width = 167
              Height = 13
              Caption = 'Mesi successivi rispetto al corrente:'
            end
            object btnWEBCartelliniDataMin: TSpeedButton
              Left = 201
              Top = 16
              Width = 15
              Height = 21
              Caption = '...'
              NumGlyphs = 2
              OnClick = btnWEBCartelliniDataMinClick
            end
            object dedtWebCartelliniChiusi: TDBCheckBox
              Left = 9
              Top = 84
              Width = 207
              Height = 17
              Alignment = taLeftJustify
              Caption = 'Solo cartellini gi'#224' registrati'
              DataField = 'WEB_CARTELLINI_CHIUSI'
              DataSource = A008FOperatoriDtm1.dsrI071
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 3
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object dedtWebCartelliniDataMin: TDBEdit
              Left = 124
              Top = 16
              Width = 76
              Height = 21
              DataField = 'WEB_CARTELLINI_DATAMIN'
              DataSource = A008FOperatoriDtm1.dsrI071
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
            end
            object dedtWebCartelliniMMPrec: TDBEdit
              Left = 186
              Top = 40
              Width = 30
              Height = 21
              DataField = 'WEB_CARTELLINI_MMPREC'
              DataSource = A008FOperatoriDtm1.dsrI071
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              MaxLength = 3
              ParentFont = False
              TabOrder = 1
            end
            object dedtWebCartelliniMMSucc: TDBEdit
              Left = 186
              Top = 63
              Width = 30
              Height = 21
              DataField = 'WEB_CARTELLINI_MMSUCC'
              DataSource = A008FOperatoriDtm1.dsrI071
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              MaxLength = 3
              ParentFont = False
              TabOrder = 2
            end
          end
          object GroupBox7: TGroupBox
            Left = 231
            Top = 106
            Width = 225
            Height = 120
            Caption = 'IrisWEB - Stampa cedolino'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
            object Label15: TLabel
              Left = 9
              Top = 19
              Width = 96
              Height = 13
              Caption = 'Disponibile dal mese'
            end
            object Label16: TLabel
              Left = 9
              Top = 43
              Width = 152
              Height = 13
              Caption = 'Mesi indietro rispetto al corrente:'
            end
            object Label17: TLabel
              Left = 9
              Top = 66
              Width = 152
              Height = 13
              Caption = 'Giorni dopo la data di emissione:'
            end
            object btnWEBCedoliniDataMin: TSpeedButton
              Left = 201
              Top = 16
              Width = 15
              Height = 21
              Caption = '...'
              NumGlyphs = 2
              OnClick = btnWEBCedoliniDataMinClick
            end
            object dedtWebCedoliniDataMin: TDBEdit
              Left = 124
              Top = 16
              Width = 76
              Height = 21
              DataField = 'WEB_CEDOLINI_DATAMIN'
              DataSource = A008FOperatoriDtm1.dsrI071
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
            end
            object dedtWebCedoliniMMPrec: TDBEdit
              Left = 186
              Top = 40
              Width = 30
              Height = 21
              DataField = 'WEB_CEDOLINI_MMPREC'
              DataSource = A008FOperatoriDtm1.dsrI071
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              MaxLength = 3
              ParentFont = False
              TabOrder = 1
            end
            object dedtWebCartelliniGGEmiss: TDBEdit
              Left = 186
              Top = 63
              Width = 30
              Height = 21
              DataField = 'WEB_CEDOLINI_GGEMISS'
              DataSource = A008FOperatoriDtm1.dsrI071
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              MaxLength = 2
              ParentFont = False
              TabOrder = 2
            end
            object dchkWebCedoliniFilePDF: TDBCheckBox
              Left = 9
              Top = 99
              Width = 207
              Height = 17
              Alignment = taLeftJustify
              Caption = 'Cedolini da archivio PDF'
              DataField = 'WEB_CEDOLINI_FILEPDF'
              DataSource = A008FOperatoriDtm1.dsrI071
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 4
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object dchkWebRichiestaConsegnaCed: TDBCheckBox
              Left = 9
              Top = 84
              Width = 207
              Height = 17
              Alignment = taLeftJustify
              Caption = 'Richiesta presa visione'
              DataField = 'WEB_RICHIESTA_CONSEGNA_CED'
              DataSource = A008FOperatoriDtm1.dsrI071
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 3
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
          end
          object GroupBox8: TGroupBox
            Left = 231
            Top = 227
            Width = 225
            Height = 129
            Caption = 'IrisWEB - Valutazioni'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 8
            object lblStatiAvanzamentoVal: TLabel
              Left = 7
              Top = 90
              Width = 126
              Height = 13
              Caption = 'Stati avanzamento abilitati:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object dchkSupervisoreValut: TDBCheckBox
              Left = 9
              Top = 13
              Width = 207
              Height = 17
              Alignment = taLeftJustify
              Caption = 'Supervisore delle Valutazioni'
              DataField = 'S710_SUPERVISOREVALUT'
              DataSource = A008FOperatoriDtm1.dsrI071
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object dchkModValutatore: TDBCheckBox
              Left = 9
              Top = 43
              Width = 207
              Height = 17
              Alignment = taLeftJustify
              Caption = 'Riassegnazione valutatore'
              DataField = 'S710_MOD_VALUTATORE'
              DataSource = A008FOperatoriDtm1.dsrI071
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object dedtStatiAvanzamentoVal: TDBEdit
              Left = 9
              Top = 103
              Width = 189
              Height = 21
              Color = clBtnFace
              DataField = 'S710_STATI_ABILITATI'
              DataSource = A008FOperatoriDtm1.dsrI071
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 4
            end
            object btnStatiAvanzamentoVal: TButton
              Left = 201
              Top = 103
              Width = 15
              Height = 21
              Caption = '...'
              TabOrder = 5
              OnClick = btnStatiAvanzamentoValClick
            end
            object dchkValidaStato: TDBCheckBox
              Left = 9
              Top = 28
              Width = 207
              Height = 17
              Alignment = taLeftJustify
              Caption = 'Validatore stato'
              DataField = 'S710_VALIDA_STATO'
              DataSource = A008FOperatoriDtm1.dsrI071
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object drgpWebRegistraConsegnaVal: TDBRadioGroup
              Left = 9
              Top = 59
              Width = 207
              Height = 31
              BiDiMode = bdLeftToRight
              Caption = 'Registrazione presa visione'
              Columns = 3
              DataField = 'WEB_RICHIESTA_CONSEGNA_VAL'
              DataSource = A008FOperatoriDtm1.dsrI071
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              Items.Strings = (
                'No'
                'S'#236
                'Richiesta')
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 3
              Values.Strings = (
                'N'
                'S'
                'R')
            end
          end
          object dchkAutoPianificazione: TDBCheckBox
            Left = 4
            Top = 143
            Width = 216
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Permetti auto-pianificazione reperibilit'#224
            DataField = 'T380_AUTO_PIANIFICAZIONE'
            DataSource = A008FOperatoriDtm1.dsrI071
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 9
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
        end
      end
    end
    object tabFiltroAnagrafe: TTabSheet
      Caption = 'Filtro anagrafe'
      ImageIndex = 1
      object dlstFiltroAnagrafe: TDBLookupListBox
        Left = 0
        Top = 0
        Width = 150
        Height = 394
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alLeft
        KeyField = 'PROFILO'
        ListField = 'PROFILO'
        ListSource = A008FOperatoriDtm1.dsrI072Dist
        TabOrder = 0
      end
      object Panel1: TPanel
        Left = 150
        Top = 0
        Width = 531
        Height = 396
        Align = alClient
        BevelOuter = bvNone
        Padding.Bottom = 2
        TabOrder = 1
        object splFAnag: TSplitter
          Left = 0
          Top = 199
          Width = 531
          Height = 2
          Cursor = crVSplit
          Align = alTop
          ExplicitTop = 169
          ExplicitWidth = 416
        end
        object memoFiltroAnagrafe: TMemo
          Left = 0
          Top = 24
          Width = 531
          Height = 175
          Align = alTop
          ReadOnly = True
          TabOrder = 1
          WordWrap = False
          OnDragOver = memoFiltroAnagrafeDragOver
        end
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 531
          Height = 24
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object SpeedButton1: TSpeedButton
            Left = 33
            Top = 0
            Width = 23
            Height = 22
            Hint = 'Verifica espressione sul database corrente'
            Glyph.Data = {
              F6000000424DF600000000000000760000002800000010000000100000000100
              04000000000080000000C40E0000C40E00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFF90FFFFFFFFFFFFF9990FFFFFFFFFFFF9990FFFF
              FFFFFFF999990FFFFFFFFF9999990FFFFFFFF7990F9990FFFFFF790FFFF990FF
              FFFFFFFFFFF9990FFFFFFFFFFFFF990FFFFFFFFFFFFFF990FFFFFFFFFFFFFF79
              0FFFFFFFFFFFFFF790FFFFFFFFFFFFFFF990FFFFFFFFFFFFFFFF}
            ParentShowHint = False
            ShowHint = True
            OnClick = SpeedButton1Click
          end
          inline C600frmSelAnagrafe: TC600frmSelAnagrafe
            Left = 4
            Top = 0
            Width = 24
            Height = 24
            TabOrder = 0
            TabStop = True
            ExplicitLeft = 4
            ExplicitWidth = 24
            inherited pnlSelAnagrafe: TPanel
              Width = 24
              ExplicitWidth = 24
              inherited lblDipendente: TLabel
                Height = 15
                Font.Height = -12
                ExplicitHeight = 15
              end
              inherited btnSelezione: TBitBtn
                Left = -1
                Hint = 'Crea filtro'
                OnClick = C600frmSelAnagrafebtnSelezioneClick
                ExplicitLeft = -1
              end
            end
          end
          object btnAnteprima: TBitBtn
            Left = 63
            Top = 0
            Width = 75
            Height = 22
            Caption = 'Anteprima'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Glyph.Data = {
              F6000000424DF600000000000000760000002800000010000000100000000100
              0400000000008000000000000000000000001000000000000000000000000000
              80000080000000808000800000008000800080800000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
              FFFF000000000000FF000FFFFFFFFFF0F0000FFFFFFF0000800F0FFFFFF08778
              08FF0FFFFF0877E880FF0FFFFF07777870FF0FFFFF07E77870FF0FFFFF08EE78
              80FF0FFFFFF087780FFF0FFFFFFF0000FFFF0FFFFFFFFFF0FFFF0FFFFFFF0000
              FFFF0FFFFFFF070FFFFF0FFFFFFF00FFFFFF000000000FFFFFFF}
            ParentFont = False
            TabOrder = 1
            OnClick = SpeedButton1Click
          end
          object chkSelezioneRichiestaPortale: TCheckBox
            Left = 168
            Top = 2
            Width = 281
            Height = 17
            Caption = 'Selezione anagrafica necessaria per accedere al portale'
            Enabled = False
            TabOrder = 2
          end
        end
        object dGridFAnag: TDBGrid
          Left = 0
          Top = 201
          Width = 531
          Height = 193
          Align = alClient
          DataSource = A008FOperatoriDtm1.dsrTestFiltroAnagrafe
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          PopupMenu = popmnuFiltroanagrafe
          ShowHint = True
          TabOrder = 2
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clBlue
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
        end
      end
    end
    object tabFiltroFunzioni: TTabSheet
      Caption = 'Filtro funzioni'
      ImageIndex = 2
      object dlstFiltroFunzioni: TDBLookupListBox
        Left = 0
        Top = 0
        Width = 150
        Height = 394
        Align = alLeft
        KeyField = 'PROFILO'
        ListField = 'PROFILO'
        ListSource = A008FOperatoriDtm1.dsrI073Dist
        TabOrder = 0
      end
      object Panel3: TPanel
        Left = 150
        Top = 0
        Width = 531
        Height = 396
        Align = alClient
        BevelOuter = bvNone
        Padding.Bottom = 2
        TabOrder = 1
        object ScrollBox2: TScrollBox
          Left = 0
          Top = 0
          Width = 531
          Height = 76
          Align = alTop
          BorderStyle = bsNone
          TabOrder = 0
          DesignSize = (
            531
            76)
          object Label3: TLabel
            Left = 4
            Top = 55
            Width = 337
            Height = 13
            Anchors = [akLeft, akBottom]
            Caption = 
              'Abilitazione: S = Scrittura/Lettura; N = Accesso negato; R = Sol' +
              'a lettura'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ExplicitTop = 100
          end
          object lblFiltroFunzioni: TLabel
            Left = 4
            Top = 8
            Width = 38
            Height = 13
            Caption = 'Gruppo:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object lblContenuto: TLabel
            Left = 4
            Top = 32
            Width = 46
            Height = 13
            Caption = 'Funzione:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object chkSelezioneMultipla: TCheckBox
            Left = 422
            Top = 31
            Width = 109
            Height = 17
            Anchors = [akLeft, akBottom]
            Caption = 'Selezione multipla'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = chkSelezioneMultiplaClick
          end
          object btnAggiornaFiltroFunzioni: TBitBtn
            Left = 360
            Top = 3
            Width = 171
            Height = 25
            Caption = 'Aggiorna funzioni disponibili'
            Glyph.Data = {
              AA040000424DAA04000000000000360000002800000013000000130000000100
              18000000000074040000C30E0000C30E00000000000000000000E1E1E1E1E1E1
              E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
              E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1FFE1E1E1E1E1E1E1E1E1E1
              E1E1E1E1E1E1E1E1800000800000800000800000800000800000E1E1E1E1E1E1
              E1E1E1E1E1E1E1E1E1E1E1E1E1E1E18000FFE1E1E1008000800000E1E1E1E1E1
              E1800000008000008000008000008000008000008000800000800000E1E1E1E1
              E1E1E1E1E1E1E1E1E1E1E1E1E1FFE1E1E1008000008000800000800000008000
              008000008000008000008000008000008000008000008000800000E1E1E1E1E1
              E1E1E1E1E1E1E1E1E1FFE1E1E100800000800000800000800000800000800000
              FF0000FF0000FF0000FF0000FF00008000008000008000800000E1E1E1E1E1E1
              E1E1E10000FFE1E1E100800000800000800000800000800000FF00E1E1E1E1E1
              E1E1E1E1E1E1E1E1E1E100FF00008000008000008000800000E1E1E1E1E1E1E1
              E1FFE1E1E1008000008000008000008000008000E1E1E1E1E1E1E1E1E1E1E1E1
              E1E1E1E1E1E1E1E1E100FF00008000008000800000E1E1E1E1E1E1FF00FFE1E1
              E1008000008000008000008000008000008000E1E1E1E1E1E1E1E1E1E1E1E1E1
              E1E1E1E1E100FF00800000800000800000E1E1E1E1E1E1E1E1FFE1E1E100FF00
              00FF0000FF0000FF0000FF0000FF0000FF00E1E1E1E1E1E1E1E1E1E1E1E1E1E1
              E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E10000FFE1E1E1E1E1E1E1E1E1E1
              E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
              E1E1E1E1E1E1E1E1E1E1E1E1E1E1E18000FFE1E1E1E1E1E1E1E1E1E1E1E1E1E1
              E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E180000080000080000080
              0000800000800000E1E1E1FF00FFE1E1E100FF00800000800000800000E1E1E1
              E1E1E1E1E1E1E1E1E1E1E1E1E1E1E100FF000080000080000080000080000080
              00800000E1E1E1E1E1FFE1E1E100FF00008000008000800000E1E1E1E1E1E1E1
              E1E1E1E1E1E1E1E1E1E1E1E1E1E100FF00008000008000008000008000800000
              E1E1E1E1E1FFE1E1E1E1E1E100FF00008000008000800000E1E1E1E1E1E1E1E1
              E1E1E1E1E1E1E1800000800000008000008000008000008000800000E1E1E180
              00FFE1E1E1E1E1E100FF00008000008000008000800000800000800000800000
              800000008000008000008000008000008000008000800000E1E1E10000FFE1E1
              E1E1E1E1E1E1E100FF0000800000800000800000800000800000800000800000
              800000800000800000FF0000FF00008000800000E1E1E1E1E1FFE1E1E1E1E1E1
              E1E1E1E1E1E100FF0000FF0000800000800000800000800000800000800000FF
              0000FF00E1E1E1E1E1E100FF00E1E1E1E1E1E18000FFE1E1E1E1E1E1E1E1E1E1
              E1E1E1E1E1E1E1E100FF0000FF0000FF0000FF0000FF0000FF00E1E1E1E1E1E1
              E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1FF00FFE1E1E1E1E1E1E1E1E1E1E1E1E1E1
              E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1
              E1E1E1E1E1E1E1E1E1E1E1E1E1FF}
            TabOrder = 1
            OnClick = btnAggiornaFiltroFunzioniClick
          end
          object cmbFiltroFunzioni: TComboBox
            Left = 55
            Top = 5
            Width = 145
            Height = 21
            Style = csDropDownList
            DropDownCount = 16
            TabOrder = 2
            OnChange = cmbFiltroFunzioniChange
          end
          object edtContenuto: TEdit
            Left = 55
            Top = 29
            Width = 145
            Height = 21
            TabOrder = 3
            OnChange = cmbFiltroFunzioniChange
          end
        end
        object DBGrid2: TDBGrid
          Left = 0
          Top = 76
          Width = 531
          Height = 318
          Hint = 
            'Abilitazione: S = Scrittura/Lettura; N = Accesso negato; R = Sol' +
            'a lettura'
          Align = alClient
          DataSource = A008FOperatoriDtm1.dsrI073
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit]
          ParentFont = False
          ParentShowHint = False
          PopupMenu = PopupMenu1
          ShowHint = True
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clNavy
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnTitleClick = DBGrid2TitleClick
          Columns = <
            item
              Expanded = False
              FieldName = 'GRUPPO'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ReadOnly = True
              Title.Caption = 'Gruppo'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clBlue
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = []
              Width = 133
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DESCRIZIONE'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ReadOnly = True
              Title.Caption = 'Funzione'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clBlue
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = []
              Width = 148
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'INIBIZIONE'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              PickList.Strings = (
                'S'
                'N'
                'R')
              Title.Caption = 'Abilitazione'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clBlue
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = []
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ACCESSO_BROWSE'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              PickList.Strings = (
                'S'
                'N')
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clBlue
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = []
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'RIGHE_PAGINA'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clBlue
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = []
              Visible = True
            end>
        end
      end
    end
    object tabIterAutorizzativi: TTabSheet
      Caption = 'Iter autorizzativi'
      ImageIndex = 4
      object dlstIterAutorizzativi: TDBLookupListBox
        Left = 0
        Top = 0
        Width = 150
        Height = 394
        Align = alLeft
        KeyField = 'PROFILO'
        ListField = 'PROFILO'
        ListSource = A008FOperatoriDtm1.dsrI075Dist
        TabOrder = 0
      end
      object Panel6: TPanel
        Left = 150
        Top = 0
        Width = 531
        Height = 396
        Align = alClient
        BevelOuter = bvNone
        Padding.Bottom = 2
        TabOrder = 1
        object Panel7: TPanel
          Left = 0
          Top = 0
          Width = 531
          Height = 31
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object Label2: TLabel
            Left = 4
            Top = 7
            Width = 83
            Height = 13
            Caption = 'Iter autorizzativo: '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object cmbCodiceIter: TComboBox
            Left = 88
            Top = 4
            Width = 185
            Height = 22
            Style = csOwnerDrawFixed
            TabOrder = 0
            OnChange = cmbCodiceIterChange
            OnDrawItem = cmbCodiceIterDrawItem
          end
        end
        object dGridIterAutorizzativi: TDBGrid
          Left = 0
          Top = 31
          Width = 531
          Height = 363
          Align = alClient
          DataSource = A008FOperatoriDtm1.dsrI075
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clBlue
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'D_ITER'
              ReadOnly = False
              Title.Caption = 'Codice'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'COD_ITER'
              Title.Caption = 'Struttura'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'LIVELLO'
              ReadOnly = False
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'D_ACCESSO'
              Title.Caption = 'Accesso'
              Visible = True
            end>
        end
      end
    end
    object tabFiltroDizionario: TTabSheet
      Caption = 'Filtro dizionario'
      ImageIndex = 3
      object dlstFiltroDizionario: TDBLookupListBox
        Left = 0
        Top = 0
        Width = 150
        Height = 394
        Align = alLeft
        KeyField = 'PROFILO'
        ListField = 'PROFILO'
        ListSource = A008FOperatoriDtm1.dsrI074Dist
        TabOrder = 0
      end
      object Panel4: TPanel
        Left = 150
        Top = 0
        Width = 531
        Height = 396
        Align = alClient
        BevelOuter = bvNone
        Padding.Bottom = 2
        TabOrder = 1
        object Panel5: TPanel
          Left = 0
          Top = 0
          Width = 531
          Height = 31
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object Label1: TLabel
            Left = 4
            Top = 8
            Width = 38
            Height = 13
            Caption = 'Tabella:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object cmbDizionario: TComboBox
            Left = 43
            Top = 4
            Width = 207
            Height = 21
            Style = csDropDownList
            DropDownCount = 30
            TabOrder = 0
            OnChange = cmbDizionarioChange
          end
          object rgpDizionario: TRadioGroup
            Left = 256
            Top = -2
            Width = 156
            Height = 31
            Caption = 'Modalit'#224' filtro'
            Columns = 2
            ItemIndex = 0
            Items.Strings = (
              'Abilitato'
              'Disabilitato')
            TabOrder = 1
          end
        end
        object lstDizionario: TCheckListBox
          Left = 0
          Top = 31
          Width = 531
          Height = 363
          Align = alClient
          Enabled = False
          ItemHeight = 13
          PopupMenu = PopupMenu2
          TabOrder = 1
        end
      end
    end
  end
  object MainMenu1: TMainMenu
    Images = ImageList1
    Left = 368
    Top = 2
    object File1: TMenuItem
      Caption = 'File'
      object Esci1: TMenuItem
        Action = actEsci
      end
    end
    object Strumenti1: TMenuItem
      Caption = 'Strumenti'
      object Nuovoprofilo1: TMenuItem
        Action = actNuovoProfilo
      end
      object Copiasu1: TMenuItem
        Action = actCopiaSu
      end
      object Cancellaprofilo1: TMenuItem
        Action = actCancellaProfilo
      end
      object Esci2: TMenuItem
        Action = actModificaProfilo
      end
      object Conferma1: TMenuItem
        Action = actConferma
      end
      object Annulla1: TMenuItem
        Action = actAnnulla
      end
    end
  end
  object ActionList1: TActionList
    Images = ImageList1
    Left = 400
    Top = 2
    object actEsci: TAction
      Caption = 'Esci'
      Hint = 'Esci'
      ImageIndex = 10
      OnExecute = actEsciExecute
    end
    object actNuovoProfilo: TAction
      Caption = 'Nuovo profilo'
      Hint = 'Nuovo profilo'
      ImageIndex = 12
      OnExecute = actNuovoProfiloExecute
    end
    object actModificaProfilo: TAction
      Caption = 'Modifica profilo'
      Hint = 'Modifica profilo'
      ImageIndex = 13
      OnExecute = actModificaProfiloExecute
    end
    object actCancellaProfilo: TAction
      Caption = 'Cancella profilo'
      Hint = 'Cancella profilo'
      ImageIndex = 15
      OnExecute = actCancellaProfiloExecute
    end
    object actConferma: TAction
      Caption = 'Conferma'
      Hint = 'Conferma'
      ImageIndex = 16
      OnExecute = actConfermaExecute
    end
    object actAnnulla: TAction
      Caption = 'Annulla'
      Hint = 'Annulla'
      ImageIndex = 5
      OnExecute = actAnnullaExecute
    end
    object actCopiaSu: TAction
      Caption = 'Copia su...'
      Hint = 'Copia su...'
      ImageIndex = 11
      OnExecute = actCopiaSuExecute
    end
  end
  object ImageList1: TImageList
    Left = 432
    Top = 2
    Bitmap = {
      494C010117001900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000006000000001002000000000000060
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF000000
      00007B7B7B007B7B7B007B7B7B0000FFFF0000FFFF007B7B7B007B7B7B007B7B
      7B007B7B7B0000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000007B7B
      7B000000000000000000000000007B7B7B000000000000FFFF007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B00000000000000000000FFFF000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000FFFF0000FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000FFFF0000FFFF000000000000000000000000007B7B7B00FFFF
      FF00BDBDBD00FFFFFF00BDBDBD00FFFFFF007B7B7B0000000000000000000000
      000000000000000000000000000000000000000000007B7B7B000000FF000000
      FF0000000000000000000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000FFFF0000FFFF0000FFFF007B7B7B007B7B7B00FFFFFF00BDBD
      BD00FFFFFF000000FF00FFFFFF00BDBDBD00FFFFFF007B7B7B007B7B7B000000
      0000000000000000000000000000000000007B7B7B000000FF00000000000000
      00000000000000000000000000000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00BDBDBD00FFFF
      FF00BDBDBD000000FF00BDBDBD00FFFFFF00BDBDBD007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      000000000000000000000000000000000000000000007B7B7B00FFFFFF000000
      FF000000FF000000FF000000FF000000FF00FFFFFF007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF000000000000FF
      FF0000000000000000000000000000000000000000007B7B7B00BDBDBD00FFFF
      FF00BDBDBD000000FF00BDBDBD00FFFFFF00BDBDBD007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000FF
      FF0000FFFF000000000000000000000000007B7B7B007B7B7B00FFFFFF00BDBD
      BD00FFFFFF000000FF00FFFFFF00BDBDBD00FFFFFF007B7B7B007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF00000000000000000000000000000000007B7B7B00FFFF
      FF00BDBDBD00FFFFFF00BDBDBD00FFFFFF007B7B7B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF000000
      000000000000000000000000000000FFFF0000FFFF0000000000000000000000
      00000000000000FFFF0000FFFF00000000000000000000000000000000007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000007B7B
      7B000000000000000000000000007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000840000008400000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000084000000840000008400000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000008400000084000000FF000000FF00000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000084
      000000FF000000FF00000000000000FF00000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000000000000000000000000000000000000000000000FF
      000000FF0000000000000000000000FF000000FF000000840000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF000000840000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF0000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000FFFFFF000000
      0000FFFFFF00000000000000000000000000FFFFFF00000000007B7B7B000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF0000008400000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000FFFFFF000000
      0000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000007B7B7B000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF00000084
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF0000000000FFFFFF000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF00000084
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      0000008400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF00000084000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000840084848400848484000000000000000000000000000000
      0000000000008484840084848400000000000000000000000000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000000000000000000000000000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000008400000000000000
      0000000000000000840000008400848484008484840000000000000000000000
      0000000000000000840000000000000000000000000000000000000084000000
      8400000084000000000000000000000000000000000000000000840000000000
      0000840000000000000000000000000000000000000000000000000084000000
      8400000084000000000000000000000000000000000000FFFF00848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008400000084000000
      0000000000008484840000008400000084008484840000000000000000000000
      0000848484000000840000000000000000000000000000000000000084000000
      8400000084000000840000000000000000000000000000000000000000008400
      0000840000008400000000000000000000000000000000000000000084000000
      8400000084000000840000000000000000000000000000FFFF00848484000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000008400000084000000
      8400000000000000000000008400000084008484840084848400000000000000
      8400000084008484840000000000000000000000000000000000000084000000
      8400000084000000840000008400000000000000000084000000840000008400
      0000840000008400000084000000000000000000000000000000000084000000
      84000000840000008400000000000000000000000000C6C6C60000FFFF008484
      8400000000000000000000000000000000000000000000000000FFFFFF000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000008400000084000000
      8400000084000000000084848400000084000000840084848400848484000000
      8400000084000000000000000000000000000000000000000000000084000000
      8400000084000000840000000000000000000000000000000000000000008400
      0000840000008400000000000000000000000000000000000000000084000000
      8400000084000000840000000000000000000000000000000000C6C6C60000FF
      FF00848484000000000000000000000000000000000000000000FFFFFF000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000008400000084000000
      8400000084000000840000000000000084000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000084000000
      8400000084000000000000000000000000000000000000000000840000000000
      0000840000000000000000000000000000000000000000000000000084000000
      84000000840000000000000000000000000000000000000000000000000000FF
      FF00848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008400000084000000
      8400000084000000000000000000848484000000840000008400000084008484
      8400000000000000000000000000000000000000000000000000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000000000000000000000000000000084000000
      840000000000000000000000000000000000000000000000000000000000C6C6
      C60000FFFF00848484000000000000000000000000000000000000000000FFFF
      FF000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000008400000084000000
      8400000000008484840084848400000084000000840000008400000084008484
      8400848484000000000000000000000000000000000000000000000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6C6C60000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008400000084000000
      0000848484000000840000008400000000000000000084848400000084000000
      8400848484008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000008400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008400000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      8400000084008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000840000008400000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084848400BDBD0000BDBD0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000C6C6C6000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084848400BDBD0000BDBD0000BDBD0000BDBD
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000840000008400000084000000840000008400
      0000840000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C60000000000000000000000000000000000000000000000
      000000000000000000000000000084848400BDBD0000BDBD0000BDBD0000BDBD
      0000BDBD0000BDBD000000000000000000000000000000000000000000000000
      0000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C60000FFFF0000FFFF0000FFFF00C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084848400BDBD0000BDBD0000BDBD0000BDBD
      0000BDBD0000BDBD000000000000000000000000000000000000000000000000
      0000000000000000000084000000FFFFFF000000000000000000000000000000
      000000000000FFFFFF0084000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600848484008484840084848400C6C6C600C6C6
      C60000000000C6C6C60000000000000000000000000000000000000000000000
      000000000000848484008484840084848400BDBD0000BDBD0000BDBD0000BDBD
      0000BDBD0000BDBD000000000000000000000000000000000000000000000000
      0000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600C6C6C600000000000000000000000000000000000000
      000000000000848484008484840084848400BDBD0000BDBD0000BDBD0000BDBD
      0000BDBD0000BDBD0000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000FFFFFF000000000000000000000000000000
      000000000000FFFFFF0084000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      FF000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000C6C6C60000000000C6C6C600000000000000000000000000000000000000
      00000000FF00848484008484840084848400BDBD000084848400BDBD0000BDBD
      0000BDBD0000BDBD0000000000000000000000000000FFFFFF00000000000000
      0000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF008400000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C60000000000C6C6C600000000000000000000000000000000000000BD000000
      BD000000FF000000FF008484840084848400BDBD000084848400BDBD0000BDBD
      0000BDBD0000BDBD0000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000FFFFFF000000000000000000FFFFFF008400
      0000840000008400000084000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      FF0000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000C6C6C60000000000C6C6C6000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF0084848400BDBD0000BDBD0000BDBD0000BDBD
      0000BDBD0000BDBD0000000000000000000000000000FFFFFF00000000000000
      0000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF008400
      0000FFFFFF008400000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF008484840084848400BDBD0000BDBD0000BDBD0000BDBD
      0000BDBD0000BDBD0000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF008400
      0000840000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000FF00848484008484840084848400BDBD0000BDBD0000BDBD0000BDBD
      0000BDBD0000BDBD0000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000084000000840000008400000084000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000848484008484840084848400FFFF0000BDBD0000BDBD0000BDBD
      0000BDBD0000BDBD0000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400848484008484840084848400FFFF0000BDBD
      0000BDBD0000BDBD0000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400848484008484840084848400848484008484
      8400FFFF0000BDBD000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400848484008484840084848400848484008484
      8400848484008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000840000008400000084000000840000008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000084000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00848484008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084000000FFFFFF00FFFFFF00FFFFFF0084848400840000008484
      8400840000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF0000008400000000000000000000000000000000000000
      000000000000000000000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00848484008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000000084000000FF0000008400000000000000000000000000000000000000
      0000000000000000840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084000000FFFFFF00FFFFFF00FFFFFF0084848400840000008484
      8400840000000000000000000000000000000000000000000000000000000000
      000000000000000084000000FF000000FF000000000000000000000000000000
      00000000FF000000840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00848484008484
      8400840000000000000000000000000000000000000000000000000000000000
      00000000000000000000000084000000FF000000840000000000000000000000
      84000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000840000008400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000840000008400000084000000840000008400
      0000840000008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000084000000FF00000084000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF00000084000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      84000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000000000000084000000000000000000000000000000000000000000
      00000000000000000000000000000000FF00000084000000FF00000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      0000008484000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000000000000000000000000000000000000000
      0000000000008400000084848400000000000000000000000000000000000000
      00000000000000000000000084000000FF000000840000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000000000FF
      FF00000000000084840000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084000000FFFFFF0000000000840000000000000000000000000000000000
      0000840000008484840084000000000000000000000000000000000000000000
      00000000FF00000084000000FF00000084000000000000000000000000000000
      0000000084000000FF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      000000FFFF000000000000848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084000000FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000848484008400000084000000000000000000000000000000000000000000
      84000000FF00000084000000FF00000000000000000000000000000000000000
      000000000000000084000000FF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF000000000000FFFF0000848400008484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000000000000
      FF00000084000000000000000000000000000000000000000000000000000000
      00000000000000000000000084000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000FFFF00008484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000000000000000000000000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000000000000000000000000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000000000000000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000000000000000000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000000000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000000000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000084000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000084000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000084000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000084000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000084000000840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000084000000840000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000084000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000084000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000000000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000000000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000000000000000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000000000000000000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000000000000000000000000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000000000000000000000000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000600000000100010000000000000300000000000000000000
      000000000000000000000000FFFFFF00FF7EFFFDFFFF00009001FFF8FFFF0000
      C003FFF1F9FF0000E003FFE3F0FF0000E003FFC7F0FF0000E003E08FE07F0000
      E003C01FC07F00000001803F843F00008000001F1E3F0000E007001FFE1F0000
      E00F001FFF1F0000E00F001FFF8F0000E027001FFFC70000C073803FFFE30000
      9E79C07FFFF800007EFEE0FFFFFF0000FFFFFFFFFFFF8003FFFFFFFFFFFF8003
      FFFFFFFFFFFF8003FCFFFF3FFFFF8003F8FFFC3FFCFF8003F07FF03FFC3F8003
      E27FC000FC0F8003E63F000000038003FF3FC00000008003FF9FF03F00038003
      FFCFFC3FFC0F8003FFCFFF3FFC3F8003FFE7FFFFFCFF8003FFF3FFFFFFFF8007
      FFFFFFFFFFFF800FFFFFFFFFFFFF801FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFCFF07C1FFFFDFFFDF7F07C1F8F9CFF7CF3F07C1B879C7D5C71F01019873
      C3E3C30F00018C23C181C38F00018407C3E3C3C70001820FC7D5C7C38003860F
      CFF7CFE3C1078807DFFFDFF1C1079183FFFFFFF0E38FBFC1FFFFFFF9E38FFFF3
      FFFFFFFFE38FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7FFFFFFFFFC007FE1FFFFF
      FFFF8003FE07FC01FFFF00010600FC01FCFF0001FE01FC01FC3F0001F8010001
      FC0F0000F801000100030000F001000100008000C00100010003C000C0010003
      FC0FE001C0010007FC3FE007F001000FFCFFF007F80100FFFFFFF003F80101FF
      FFFFF803F80103FFFFFFFFFFF801FFFFF807FFFE847FFFFFF807FBFF00EFFFFF
      F807F1FD31BFFFFFF807F1FB39FFFF3FF807F8F3993FFC3FF807FC67CA1FF03F
      F803FE0FF40FC000FFF3FF1F9C070000FFF1FE0F9603C000F9F1FC6FCB01F03F
      F0F1F0F3FF80FC3FF0F1E1F9F7C0FF3FF9FBE7FCFFE0FFFFEFF3FFFFEFF0FFFF
      FFF7FFFFFFF8FFFFFFFFFFFFFFFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFF3EFFFEFF7FFF7CFF3CFFFCFF3FFF3CFF38FFF8FF1FFF1CF
      F30FFF0FF0FFF0CFF20FFE0FF07FF04FF30FFF0FF0FFF0CFF38FFF8FF1FFF1CF
      F3CFFFCFF3FFF3CFF3EFFFEFF7FFF7CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 464
    Top = 2
    object AbilitazioniS1: TMenuItem
      Caption = 'Abilitazioni S'
      OnClick = AbilitazioniR1Click
    end
    object AbilitazioniN1: TMenuItem
      Caption = 'Abilitazioni N'
      OnClick = AbilitazioniR1Click
    end
    object AbilitazioniR1: TMenuItem
      Caption = 'Abilitazioni R'
      OnClick = AbilitazioniR1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object mnuRegoleAccessoIP: TMenuItem
      Caption = 'Regole accesso IP'
      OnClick = mnuRegoleAccessoIPClick
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 496
    Top = 2
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      OnClick = Invertiselezione1Click
    end
    object Annullatutto1: TMenuItem
      Caption = 'Annulla tutto'
      OnClick = Invertiselezione1Click
    end
    object Invertiselezione1: TMenuItem
      Caption = 'Inverti selezione'
      OnClick = Invertiselezione1Click
    end
  end
  object popmnuFiltroanagrafe: TPopupMenu
    OnPopup = popmnuFiltroanagrafePopup
    Left = 618
    Top = 272
    object Copiainexcel1: TMenuItem
      Caption = 'Copia in excel'
      OnClick = Copiainexcel1Click
    end
  end
  object imglstBtn: TImageList
    Left = 537
    Top = 158
    Bitmap = {
      494C010101000500040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000008400000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000840000008400000084000000840000008400000084
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000008400000084000000000000000000000000
      0000008400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000084000000000000000000000000
      0000008400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008400000000000000000000000000000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008400000000000000000000000000000084000000840000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000084000000840000008400000084000000840000008400000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000084000000840000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFF000000000000FF7F000000000000
      FE7F000000000000FC0F000000000000FE77000000000000FF77000000000000
      FFF7000000000000FFF7000000000000F7FF000000000000F7FF000000000000
      F77F000000000000F73F000000000000F81F000000000000FF3F000000000000
      FF7F000000000000FFFF00000000000000000000000000000000000000000000
      000000000000}
  end
end
