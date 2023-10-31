inherited A174FParPianifTurni: TA174FParPianifTurni
  HelpContext = 174000
  Caption = '<A174> Profili di pianificazione'
  ClientHeight = 570
  ClientWidth = 550
  ExplicitWidth = 566
  ExplicitHeight = 629
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 552
    Width = 550
    ExplicitTop = 552
    ExplicitWidth = 550
  end
  inherited Panel1: TToolBar
    Width = 550
    ExplicitWidth = 550
  end
  object PgCtrlParametri: TPageControl [2]
    Left = 0
    Top = 62
    Width = 550
    Height = 490
    ActivePage = TSheetVisualizzazione
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object TSheetVisualizzazione: TTabSheet
      Caption = 'Pianificazione'
      object drgpModLavoro: TDBRadioGroup
        Left = 8
        Top = 3
        Width = 261
        Height = 106
        Caption = 'Modalit'#224' di lavoro'
        DataField = 'MODALITA_LAVORO'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Operativa'
          'Non operativa')
        ParentFont = False
        TabOrder = 0
        Values.Strings = (
          'O'
          'N')
        OnClick = drgpModLavoroClick
      end
      object grpOpzioniPianif: TGroupBox
        Left = 8
        Top = 110
        Width = 528
        Height = 58
        Caption = 'Opzioni pianificazione'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        object dChkPianifGGFest: TDBCheckBox
          Left = 8
          Top = 15
          Width = 210
          Height = 17
          Caption = 'Pianificazione giorni festivi'
          DataField = 'PIANIF_GG_FEST'
          DataSource = DButton
          TabOrder = 0
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dChkPinifSoloTurnista: TDBCheckBox
          Left = 274
          Top = 15
          Width = 210
          Height = 17
          Caption = 'Pianificazione solo se gestione turnista'
          DataField = 'PIANIF_SOLO_TURN'
          DataSource = DButton
          TabOrder = 1
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dChkPianifGGAss: TDBCheckBox
          Left = 8
          Top = 34
          Width = 210
          Height = 17
          Caption = 'Pianificazione orario su giorni di assenza'
          DataField = 'PIANIF_GG_ASS'
          DataSource = DButton
          TabOrder = 2
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dChkGiustifOperativi: TDBCheckBox
          Left = 274
          Top = 34
          Width = 210
          Height = 17
          Caption = 'Giustificativi operativi'
          DataField = 'ASSENZE_OPERATIVE'
          DataSource = DButton
          TabOrder = 3
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
      end
      object grpBoxProgressiva: TGroupBox
        Left = 8
        Top = 169
        Width = 528
        Height = 58
        Caption = 'Pianificazione progressiva'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        object dchkGenera: TDBCheckBox
          Left = 8
          Top = 15
          Width = 140
          Height = 17
          Caption = 'Genera pianif. iniziale'
          DataField = 'GENERAZIONE'
          DataSource = DButton
          TabOrder = 0
          ValueChecked = 'S'
          ValueUnchecked = 'N'
          OnClick = dchkGeneraClick
        end
        object dchkIniziale: TDBCheckBox
          Left = 194
          Top = 15
          Width = 140
          Height = 17
          Caption = 'Visualizza pianif. iniziale'
          DataField = 'INIZIALE'
          DataSource = DButton
          TabOrder = 1
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dchkCorrente: TDBCheckBox
          Left = 380
          Top = 15
          Width = 140
          Height = 17
          Caption = 'Visualizza pianif. corrente'
          DataField = 'CORRENTE'
          DataSource = DButton
          TabOrder = 2
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dChkRendiOperativa: TDBCheckBox
          Left = 8
          Top = 34
          Width = 140
          Height = 17
          Caption = 'Rendi operativa'
          DataField = 'RENDI_OPERATIVA'
          DataSource = DButton
          TabOrder = 3
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
      end
      object grpOrd_Visualizzazione: TGroupBox
        Left = 275
        Top = 3
        Width = 261
        Height = 106
        Caption = 'Ordinamento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object lblListaDati: TLabel
          Left = 7
          Top = 15
          Width = 67
          Height = 13
          Caption = 'Dati disponibili'
        end
        object lblOrdVis: TLabel
          Left = 133
          Top = 15
          Width = 71
          Height = 13
          Caption = 'Dati selezionati'
        end
        object lstElencoOrd: TListBox
          Left = 7
          Top = 29
          Width = 120
          Height = 72
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 13
          ParentFont = False
          TabOrder = 0
          OnDblClick = lstElencoOrdDblClick
        end
        object lstOrdinamento: TListBox
          Left = 133
          Top = 29
          Width = 120
          Height = 72
          DragMode = dmAutomatic
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 13
          ParentFont = False
          TabOrder = 1
          OnDblClick = lstOrdinamentoDblClick
          OnDragDrop = lstOrdinamentoDragDrop
          OnDragOver = lstOrdinamentoDragOver
          OnMouseDown = lstOrdinamentoMouseDown
        end
      end
      object grpRicercaSostituto: TGroupBox
        Left = 8
        Top = 233
        Width = 528
        Height = 98
        Caption = 'Ricerca sostituto'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        object lblSostDatiElenco: TLabel
          Left = 8
          Top = 16
          Width = 171
          Height = 13
          Caption = 'Dati anagrafici opzionali selezionabili'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblSostDatiInizio: TLabel
          Left = 8
          Top = 56
          Width = 186
          Height = 13
          Caption = 'Dati anagrafici opzionali per filtro iniziale'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblSostDatiFiltro: TLabel
          Left = 270
          Top = 56
          Width = 165
          Height = 13
          Caption = 'Dati anagrafici per filtro obbligatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object dedtSostDatiElenco: TDBEdit
          Left = 8
          Top = 30
          Width = 500
          Height = 21
          DataField = 'SOST_DATI_ELENCO'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
        end
        object btnSostDatiElenco: TButton
          Left = 508
          Top = 30
          Width = 14
          Height = 21
          Caption = '...'
          TabOrder = 1
          OnClick = btnDatiClick
        end
        object dedtSostDatiInizio: TDBEdit
          Left = 8
          Top = 70
          Width = 239
          Height = 21
          DataField = 'SOST_DATI_INIZIO'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
        end
        object btnSostDatiInizio: TButton
          Left = 247
          Top = 70
          Width = 14
          Height = 21
          Caption = '...'
          TabOrder = 3
          OnClick = btnDatiClick
        end
        object dedtSostDatiFiltro: TDBEdit
          Left = 270
          Top = 70
          Width = 238
          Height = 21
          DataField = 'SOST_DATI_FILTRO'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
        end
        object btnSostDatiFiltro: TButton
          Left = 508
          Top = 70
          Width = 14
          Height = 21
          Caption = '...'
          TabOrder = 5
          OnClick = btnDatiClick
        end
      end
    end
    object TSheetStampa: TTabSheet
      Caption = 'Stampa'
      ImageIndex = 1
      object lblTitolo: TLabel
        Left = 8
        Top = 2
        Width = 26
        Height = 13
        Caption = 'Titolo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblDesc1: TLabel
        Left = 8
        Top = 420
        Width = 64
        Height = 13
        Caption = 'Descrizione 1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblDesc2: TLabel
        Left = 275
        Top = 420
        Width = 64
        Height = 13
        Caption = 'Descrizione 2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 8
        Top = 383
        Width = 84
        Height = 13
        Caption = 'Note a pi'#232' pagina'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblCauEsclusione: TLabel
        Left = 8
        Top = 250
        Width = 132
        Height = 13
        Caption = 'Causali per esclusione turno'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object dEdtTitolo: TDBEdit
        Left = 8
        Top = 16
        Width = 528
        Height = 21
        DataField = 'TITOLO'
        DataSource = DButton
        TabOrder = 0
      end
      object dEdtDesc1: TDBEdit
        Left = 8
        Top = 434
        Width = 261
        Height = 21
        DataField = 'DESCRIZIONE1'
        DataSource = DButton
        TabOrder = 9
      end
      object dEdtDesc2: TDBEdit
        Left = 275
        Top = 434
        Width = 261
        Height = 21
        DataField = 'DESCRIZIONE2'
        DataSource = DButton
        TabOrder = 10
      end
      object dEdtNotePagina: TDBEdit
        Left = 8
        Top = 397
        Width = 528
        Height = 21
        DataField = 'NOTE_STAMPA'
        DataSource = DButton
        TabOrder = 8
      end
      object drgpDettStampa: TDBRadioGroup
        Left = 8
        Top = 105
        Width = 261
        Height = 40
        Caption = 'Esposizione dati'
        Columns = 2
        DataField = 'DETT_STAMPA'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Sintetica'
          'Dettagliata')
        ParentFont = False
        TabOrder = 2
        Values.Strings = (
          'S'
          'D')
        OnClick = drgpDettStampaClick
      end
      object drgpTipoStampa: TDBRadioGroup
        Left = 8
        Top = 39
        Width = 261
        Height = 64
        Caption = 'Origine dati'
        DataField = 'TIPO_STAMPA'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Preventiva (da pianificazione)'
          'Consuntiva (da conteggi)')
        ParentFont = False
        TabOrder = 1
        Values.Strings = (
          'P'
          'C')
        OnClick = drgpTipoStampaClick
      end
      object grpDatiOpzionali: TGroupBox
        Left = 8
        Top = 286
        Width = 528
        Height = 96
        Caption = 'Dati opzionali'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        object lblDatoAnag: TLabel
          Left = 274
          Top = 54
          Width = 76
          Height = 13
          Caption = 'Dato anagrafico'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object dChkTotTurni: TDBCheckBox
          Left = 141
          Top = 34
          Width = 120
          Height = 17
          Caption = 'Totali per turno'
          DataField = 'TOT_TURNO'
          DataSource = DButton
          TabOrder = 5
          ValueChecked = 'S'
          ValueUnchecked = 'N'
          OnClick = dChkTotTurniClick
        end
        object dchkTotTurnoOpe: TDBCheckBox
          Left = 141
          Top = 53
          Width = 120
          Height = 17
          Caption = 'Totali per operatore'
          DataField = 'TOT_OPE_TURNO'
          DataSource = DButton
          TabOrder = 6
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dchkTotCopertura: TDBCheckBox
          Left = 141
          Top = 72
          Width = 120
          Height = 17
          Caption = 'Totali generali'
          DataField = 'TOT_GENERALI'
          DataSource = DButton
          TabOrder = 7
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dChkDettOrari: TDBCheckBox
          Left = 274
          Top = 15
          Width = 120
          Height = 17
          Caption = 'Legenda orari'
          DataField = 'DETT_ORARI'
          DataSource = DButton
          TabOrder = 8
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dChkTotLiquid: TDBCheckBox
          Left = 141
          Top = 15
          Width = 120
          Height = 17
          Caption = 'Totali liquidabile'
          DataField = 'TOT_LIQUIDABILE'
          DataSource = DButton
          TabOrder = 4
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dChkAssenze: TDBCheckBox
          Left = 274
          Top = 34
          Width = 120
          Height = 17
          Caption = 'Assenze e legenda'
          DataField = 'ASSENZE'
          DataSource = DButton
          TabOrder = 9
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dChkRiepNote: TDBCheckBox
          Left = 400
          Top = 15
          Width = 120
          Height = 17
          Caption = 'Riepilogo note'
          DataField = 'RIEPILOGO_NOTE'
          DataSource = DButton
          TabOrder = 11
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dChkSaldiOre: TDBCheckBox
          Left = 8
          Top = 15
          Width = 120
          Height = 17
          Caption = 'Saldi ore'
          DataField = 'SALDI_ORE'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dChkToTurnitMese: TDBCheckBox
          Left = 8
          Top = 34
          Width = 120
          Height = 17
          Caption = 'Totali per dipendente'
          DataField = 'TOT_TURNI_MESE'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dChkVisOrario: TDBCheckBox
          Left = 8
          Top = 53
          Width = 120
          Height = 17
          Caption = 'Codice orario'
          DataField = 'ORARIO_SINTETICO'
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
        object dChkStampaReperibilità: TDBCheckBox
          Left = 8
          Top = 72
          Width = 120
          Height = 17
          Caption = 'Turni di reperibilit'#224
          DataField = 'REPERIBILITA'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dCmbDatoAnag: TDBLookupComboBox
          Left = 274
          Top = 68
          Width = 246
          Height = 21
          DataField = 'DATO_ANAGRAFICO'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          KeyField = 'NOME_CAMPO'
          ListField = 'NOME_LOGICO'
          NullValueKey = 46
          ParentFont = False
          TabOrder = 10
        end
      end
      object dEdtEcludiCaus: TDBEdit
        Left = 8
        Top = 264
        Width = 514
        Height = 21
        DataField = 'caus_ecluditurno'
        DataSource = DButton
        ReadOnly = True
        TabOrder = 5
      end
      object btnCaus: TButton
        Left = 522
        Top = 264
        Width = 14
        Height = 21
        Caption = '...'
        TabOrder = 6
        OnClick = btnCausClick
      end
      object grpOrd_Stampa: TGroupBox
        Left = 275
        Top = 39
        Width = 261
        Height = 106
        Caption = 'Ordinamento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        object lblListaDatiStampa: TLabel
          Left = 7
          Top = 15
          Width = 67
          Height = 13
          Caption = 'Dati disponibili'
        end
        object lblOrdStampa: TLabel
          Left = 133
          Top = 15
          Width = 71
          Height = 13
          Caption = 'Dati selezionati'
        end
        object lstElencoOrdStampa: TListBox
          Left = 7
          Top = 29
          Width = 120
          Height = 72
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 13
          ParentFont = False
          TabOrder = 0
          OnDblClick = lstElencoOrdStampaDblClick
        end
        object lstOrdinamentoStampa: TListBox
          Left = 133
          Top = 29
          Width = 120
          Height = 72
          DragMode = dmAutomatic
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 13
          ParentFont = False
          TabOrder = 1
          OnDblClick = lstOrdinamentoStampaDblClick
          OnDragDrop = lstOrdinamentoDragDrop
          OnDragOver = lstOrdinamentoDragOver
          OnMouseDown = lstOrdinamentoMouseDown
        end
      end
      object grpLayout: TGroupBox
        Left = 8
        Top = 146
        Width = 528
        Height = 103
        Caption = 'Layout'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        object lblMarginesx: TLabel
          Left = 274
          Top = 16
          Width = 73
          Height = 13
          Caption = 'Margine sinistro'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblDimFont: TLabel
          Left = 274
          Top = 58
          Width = 76
          Height = 13
          Caption = 'Dimensione font'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblNumGG: TLabel
          Left = 274
          Top = 37
          Width = 80
          Height = 13
          Caption = 'Giorni per pagina'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblOPagina: TLabel
          Left = 274
          Top = 79
          Width = 98
          Height = 13
          Caption = 'Orientamento pagina'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object dEdtMgSx: TDBEdit
          Left = 400
          Top = 13
          Width = 30
          Height = 21
          DataField = 'MARGINE_SX'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object dEdtDimFont: TDBEdit
          Left = 400
          Top = 55
          Width = 30
          Height = 21
          DataField = 'DIMENSIONE_FONT'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
        end
        object dEdtNumGG: TDBEdit
          Left = 400
          Top = 34
          Width = 30
          Height = 21
          DataField = 'GG_PAGINA'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
        object dCmbOPagina: TDBComboBox
          Left = 400
          Top = 76
          Width = 120
          Height = 22
          Style = csOwnerDrawFixed
          DataField = 'ORIENTAMENTO_PAG'
          DataSource = DButton
          DropDownCount = 3
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Items.Strings = (
            'A'
            'O'
            'V')
          ParentFont = False
          TabOrder = 7
          OnDrawItem = dCmbOPaginaDrawItem
        end
        object dchkRiduciRigheDip: TDBCheckBox
          Left = 8
          Top = 15
          Width = 153
          Height = 17
          Caption = 'Compatta righe di dettaglio'
          DataField = 'COMPATTA_RIGHE_DIP'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          ValueChecked = 'S'
          ValueUnchecked = 'N'
          OnClick = dChkTotTurniClick
        end
        object dChkRigheNome: TDBCheckBox
          Left = 8
          Top = 36
          Width = 121
          Height = 17
          Caption = 'Nominativo su 2 righe'
          DataField = 'RIGHE_NOME'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          ValueChecked = 'S'
          ValueUnchecked = 'N'
          OnClick = dChkTotTurniClick
        end
        object dChkSeparatoreCol: TDBCheckBox
          Left = 8
          Top = 57
          Width = 118
          Height = 17
          Caption = 'Separatore colonne'
          DataField = 'SEPARATORE_COL'
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
        object dChkSepratoreRighe: TDBCheckBox
          Left = 8
          Top = 78
          Width = 118
          Height = 15
          Caption = 'Separatore righe'
          DataField = 'SEPARATORE_RIGHE'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
      end
    end
  end
  object pnlTOP: TPanel [3]
    Left = 0
    Top = 24
    Width = 550
    Height = 38
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object lblCodProfilo: TLabel
      Left = 12
      Top = 0
      Width = 36
      Height = 13
      Caption = 'Codice:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblDescProfilo: TLabel
      Left = 83
      Top = 0
      Width = 58
      Height = 13
      Caption = 'Descrizione:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dEdtCodice: TDBEdit
      Left = 12
      Top = 14
      Width = 65
      Height = 21
      DataField = 'CODICE'
      DataSource = DButton
      TabOrder = 0
    end
    object dEdtDesc: TDBEdit
      Left = 83
      Top = 14
      Width = 457
      Height = 21
      DataField = 'DESCRIZIONE'
      DataSource = DButton
      TabOrder = 1
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 375
  end
  inherited DButton: TDataSource
    DataSet = A174FParPianifTurniDtm.selT082
    Left = 403
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 431
  end
  inherited ImageList1: TImageList
    Left = 459
  end
  inherited ActionList1: TActionList
    Left = 487
  end
end
