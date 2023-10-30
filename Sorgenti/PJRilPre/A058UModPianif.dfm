object A058FModPianif: TA058FModPianif
  AlignWithMargins = True
  Left = 289
  Top = 284
  Caption = '<A058> Dati di pianificazione'
  ClientHeight = 445
  ClientWidth = 960
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBase: TPanel
    Left = 0
    Top = 0
    Width = 286
    Height = 445
    Align = alLeft
    TabOrder = 0
    object Label1: TLabel
      Left = 10
      Top = 3
      Width = 28
      Height = 13
      Caption = 'Orario'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object DBText1: TDBText
      Left = 107
      Top = 20
      Width = 42
      Height = 13
      AutoSize = True
      DataField = 'DESCRIZIONE'
      DataSource = D020
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object Label6: TLabel
      Left = 10
      Top = 43
      Width = 90
      Height = 13
      Caption = 'Num.fascia 1'#176'turno'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 157
      Top = 43
      Width = 90
      Height = 13
      Caption = 'Num.fascia 2'#176'turno'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblPNT1: TLabel
      Left = 11
      Top = 79
      Width = 72
      Height = 13
      Caption = 'E06.30 U14.00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblPNT2: TLabel
      Left = 157
      Top = 79
      Width = 41
      Height = 13
      Caption = '1'#176' Turno'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblSiglaT1: TLabel
      Left = 112
      Top = 60
      Width = 15
      Height = 13
      Caption = '(M)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblSiglaT2: TLabel
      Left = 259
      Top = 60
      Width = 15
      Height = 13
      Caption = '(M)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dtxtArea: TDBText
      Left = 145
      Top = 115
      Width = 39
      Height = 13
      AutoSize = True
      DataField = 'DESCRIZIONE'
      DataSource = D651
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object lblArea: TLabel
      Left = 10
      Top = 97
      Width = 22
      Height = 13
      Caption = 'Area'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblTipoOpe: TLabel
      Left = 183
      Top = 158
      Width = 69
      Height = 13
      Caption = 'Tipo operatore'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object EOrario: TDBLookupComboBox
      Left = 10
      Top = 16
      Width = 89
      Height = 21
      DropDownWidth = 400
      KeyField = 'CODICE'
      ListField = 'CODICE;DESCRIZIONE'
      ListSource = D020
      TabOrder = 0
      OnClick = EOrarioClick
      OnCloseUp = EAssenza1CloseUp
      OnExit = EOrarioExit
      OnKeyDown = EOrarioKeyDown
    end
    object BitBtn1: TBitBtn
      Left = 8
      Top = 410
      Width = 75
      Height = 25
      Caption = 'OK'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      TabOrder = 12
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 89
      Top = 410
      Width = 75
      Height = 25
      Caption = 'Cancel'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      ModalResult = 2
      NumGlyphs = 2
      TabOrder = 13
      OnClick = BitBtn2Click
    end
    object cmbTurno1: TComboBox
      Left = 10
      Top = 56
      Width = 60
      Height = 21
      DropDownCount = 10
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 2
      ParentFont = False
      TabOrder = 1
      OnChange = cmbTurno1Change
      Items.Strings = (
        '0 - Riposo'
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8'
        '9')
    end
    object cmbTurno1EU: TComboBox
      Left = 72
      Top = 56
      Width = 40
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Items.Strings = (
        'E'
        'U')
    end
    object cmbTurno2: TComboBox
      Left = 157
      Top = 56
      Width = 60
      Height = 21
      DropDownCount = 10
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 2
      ParentFont = False
      TabOrder = 3
      OnChange = cmbTurno1Change
      Items.Strings = (
        '0 - Riposo'
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8'
        '9')
    end
    object cmbTurno2EU: TComboBox
      Left = 219
      Top = 56
      Width = 40
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Items.Strings = (
        'E'
        'U')
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 199
      Width = 264
      Height = 138
      Caption = 'Assenze'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      object Label2: TLabel
        Left = 10
        Top = 19
        Width = 50
        Height = 13
        Caption = '1'#176'Assenza'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object DBText2: TDBText
        Left = 11
        Top = 38
        Width = 42
        Height = 13
        AutoSize = True
        DataField = 'DESCRIZIONE'
        DataSource = D265
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object Label3: TLabel
        Left = 10
        Top = 58
        Width = 50
        Height = 13
        Caption = '2'#176'Assenza'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object DBText3: TDBText
        Left = 11
        Top = 77
        Width = 42
        Height = 13
        AutoSize = True
        DataField = 'DESCRIZIONE'
        DataSource = D265B
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object EAssenza1: TDBLookupComboBox
        Left = 69
        Top = 15
        Width = 89
        Height = 21
        DropDownWidth = 400
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        KeyField = 'CODICE'
        ListField = 'CODICE;DESCRIZIONE'
        ListSource = D265
        ParentFont = False
        TabOrder = 0
        OnCloseUp = EAssenza1CloseUp
        OnKeyDown = EOrarioKeyDown
      end
      object EAssenza2: TDBLookupComboBox
        Left = 69
        Top = 55
        Width = 89
        Height = 21
        DropDownWidth = 400
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        KeyField = 'CODICE'
        ListField = 'CODICE;DESCRIZIONE'
        ListSource = D265B
        ParentFont = False
        TabOrder = 1
        OnCloseUp = EAssenza1CloseUp
        OnKeyDown = EOrarioKeyDown
      end
      inline frmInputPeriodo: TfrmInputPeriodo
        Left = 2
        Top = 94
        Width = 260
        Height = 42
        Align = alBottom
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentBackground = False
        ParentColor = False
        ParentFont = False
        TabOrder = 2
        ExplicitLeft = 2
        ExplicitTop = 94
        ExplicitWidth = 260
        ExplicitHeight = 42
        inherited lblInizio: TLabel
          Top = 4
          ExplicitTop = 4
        end
        inherited lblFine: TLabel
          Left = 112
          Top = 4
          ExplicitLeft = 112
          ExplicitTop = 4
        end
        inherited edtInizio: TMaskEdit
          Left = 8
          Top = 17
          ExplicitLeft = 8
          ExplicitTop = 17
        end
        inherited edtFine: TMaskEdit
          Left = 112
          Top = 17
          ExplicitLeft = 112
          ExplicitTop = 17
        end
        inherited btnIndietro: TBitBtn
          Left = 211
          Top = 17
          ExplicitLeft = 211
          ExplicitTop = 17
        end
        inherited btnAvanti: TBitBtn
          Left = 233
          Top = 17
          ExplicitLeft = 233
          ExplicitTop = 17
        end
        inherited btnDataInizio: TBitBtn
          Left = 79
          Top = 16
          ExplicitLeft = 79
          ExplicitTop = 16
        end
        inherited btnDataFine: TBitBtn
          Left = 183
          Top = 16
          ExplicitLeft = 183
          ExplicitTop = 16
        end
      end
    end
    object chkAntincendio: TCheckBox
      Left = 10
      Top = 138
      Width = 157
      Height = 17
      Caption = 'Responsabile antincendio'
      TabOrder = 6
    end
    object memoNote: TMemo
      Left = 8
      Top = 341
      Width = 264
      Height = 65
      ScrollBars = ssVertical
      TabOrder = 11
    end
    object chkReferente: TCheckBox
      Left = 10
      Top = 157
      Width = 74
      Height = 17
      Caption = 'Referente'
      TabOrder = 7
    end
    object chkRichiestoDaTurnista: TCheckBox
      Left = 10
      Top = 176
      Width = 127
      Height = 17
      Caption = 'Richiesto da turnista'
      TabOrder = 8
    end
    object dcmbArea: TDBLookupComboBox
      Left = 10
      Top = 111
      Width = 129
      Height = 21
      DropDownWidth = 400
      KeyField = 'CODICE_AREA'
      ListField = 'SIGLA;DESCRIZIONE'
      ListSource = D651
      TabOrder = 5
      OnCloseUp = dcmbAreaCloseUp
      OnKeyDown = dcmbAreaKeyDown
    end
    object cmbTipoOpe: TDBLookupComboBox
      Left = 183
      Top = 172
      Width = 89
      Height = 21
      DropDownWidth = 400
      KeyField = 'TIPOOPE'
      ListField = 'TIPOOPE'
      ListSource = dsrTipoOpe
      TabOrder = 9
      OnKeyDown = EOrarioKeyDown
    end
  end
  object pnlRicerca: TPanel
    Left = 286
    Top = 0
    Width = 674
    Height = 445
    Align = alClient
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 1
      Top = 306
      Width = 672
      Height = 3
      Cursor = crVSplit
      Align = alTop
      ExplicitLeft = 104
      ExplicitTop = 224
      ExplicitWidth = 100
    end
    object gpbSostituti: TGroupBox
      Left = 1
      Top = 343
      Width = 672
      Height = 101
      Align = alClient
      Caption = 'Lista sostituti'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      ExplicitWidth = 496
      object dgrdSostituti: TDBGrid
        Left = 2
        Top = 15
        Width = 668
        Height = 84
        Align = alClient
        DataSource = A058FPianifTurniDtM1.dsrSostituti
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete]
        ParentFont = False
        PopupMenu = pmuSostituti
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clBlue
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
      object btnAggiornaSostituti: TButton
        Left = 12
        Top = 25
        Width = 141
        Height = 44
        Caption = 'Aggiorna lista sostituti'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = btnAggiornaSostitutiClick
      end
    end
    object gpbFiltri: TGroupBox
      Left = 1
      Top = 1
      Width = 672
      Height = 305
      Align = alTop
      Caption = 'Ricerca sostituti'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object Splitter2: TSplitter
        Left = 2
        Top = 265
        Width = 668
        Height = 3
        Cursor = crVSplit
        Align = alBottom
        ExplicitTop = 256
      end
      object memFiltri: TMemo
        Left = 2
        Top = 196
        Width = 668
        Height = 69
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
        WordWrap = False
      end
      object pnlFiltri: TPanel
        Left = 2
        Top = 15
        Width = 668
        Height = 181
        Align = alTop
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object lblCampi: TLabel
          Left = 225
          Top = 3
          Width = 112
          Height = 13
          Caption = 'Dati anagrafici opzionali'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblColonne: TLabel
          Left = 225
          Top = 41
          Width = 63
          Height = 13
          Caption = 'Lista colonne'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblFiltri: TLabel
          Left = 11
          Top = 167
          Width = 108
          Height = 13
          Caption = 'Filtri attivi sulle colonne'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblOrdinamento: TLabel
          Left = 448
          Top = 41
          Width = 60
          Height = 13
          Caption = 'Ordinamento'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object edtCampi: TEdit
          Left = 225
          Top = 17
          Width = 417
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
        end
        object btnCampi: TButton
          Left = 643
          Top = 17
          Width = 15
          Height = 22
          Caption = '...'
          TabOrder = 2
          OnClick = btnCampiClick
        end
        object btnEliminaTuttiFiltri: TButton
          Left = 11
          Top = 143
          Width = 91
          Height = 22
          Caption = 'Elimina tutti i filtri'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          OnClick = btnEliminaTuttiFiltriClick
        end
        object cmbColonne: TComboBox
          Left = 225
          Top = 55
          Width = 210
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnChange = cmbColonneChange
          OnDblClick = cmbColonneDblClick
        end
        object lstOrdinamento: TListBox
          Left = 448
          Top = 55
          Width = 210
          Height = 110
          DragMode = dmAutomatic
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 13
          ParentFont = False
          TabOrder = 4
          OnDblClick = lstOrdinamentoDblClick
          OnDragDrop = lstOrdinamentoDragDrop
          OnDragOver = lstOrdinamentoDragOver
          OnMouseDown = lstOrdinamentoMouseDown
        end
        object gpbFiltriDipendenti: TGroupBox
          Left = 6
          Top = 3
          Width = 206
          Height = 137
          Caption = 'Filtro dipendenti'
          TabOrder = 0
          object rgpPianificati: TRadioGroup
            Left = 7
            Top = 14
            Width = 193
            Height = 30
            Caption = 'Pianificati'
            Columns = 3
            ItemIndex = 2
            Items.Strings = (
              'S'#236
              'No'
              'Entrambi')
            TabOrder = 0
            OnClick = rgpPianificatiClick
          end
          object rgpEsuberiMin: TRadioGroup
            Left = 7
            Top = 43
            Width = 193
            Height = 30
            Caption = 'In esubero su copertura minima'
            Columns = 3
            ItemIndex = 2
            Items.Strings = (
              'S'#236
              'No'
              'Entrambi')
            TabOrder = 1
            OnClick = rgpPianificatiClick
          end
          object rgpEsuberiMax: TRadioGroup
            Left = 7
            Top = 72
            Width = 193
            Height = 30
            Caption = 'In esubero su copertura massima'
            Columns = 3
            ItemIndex = 2
            Items.Strings = (
              'S'#236
              'No'
              'Entrambi')
            TabOrder = 2
            OnClick = rgpPianificatiClick
          end
          object rgpDisponibili: TRadioGroup
            Left = 7
            Top = 101
            Width = 193
            Height = 30
            Caption = 'Disponibili'
            Columns = 3
            ItemIndex = 2
            Items.Strings = (
              'S'#236
              'No'
              'Entrambi')
            TabOrder = 3
            OnClick = rgpPianificatiClick
          end
        end
        object gpbFiltriColonne: TGroupBox
          Left = 225
          Top = 81
          Width = 210
          Height = 84
          Caption = 'Filtro colonna'
          TabOrder = 5
          object btnImpostaFiltro: TButton
            Left = 8
            Top = 15
            Width = 79
            Height = 22
            Caption = 'Imposta filtro'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = btnImpostaFiltroClick
          end
          object btnEliminaFiltro: TButton
            Left = 124
            Top = 13
            Width = 79
            Height = 22
            Caption = 'Elimina filtro'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
            OnClick = btnImpostaFiltroClick
          end
          object chkValoriResidui: TCheckBox
            Left = 8
            Top = 41
            Width = 113
            Height = 17
            Caption = 'Elenca valori residui'
            TabOrder = 1
          end
          object chkFiltriRange: TCheckBox
            Left = 8
            Top = 62
            Width = 79
            Height = 17
            Caption = 'Range valori'
            TabOrder = 2
            OnClick = chkFiltriRangeClick
          end
          object chkFiltriRangeDa: TCheckBox
            Left = 94
            Top = 62
            Width = 41
            Height = 17
            Caption = 'da -'
            TabOrder = 3
            OnClick = chkFiltriRangeDaClick
          end
          object chkFiltriRangeA: TCheckBox
            Left = 132
            Top = 62
            Width = 30
            Height = 17
            Caption = 'a'
            TabOrder = 4
            OnClick = chkFiltriRangeAClick
          end
        end
      end
      object memFiltroObbligatorio: TMemo
        Left = 2
        Top = 268
        Width = 668
        Height = 35
        Align = alBottom
        Color = cl3DLight
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
        WordWrap = False
      end
    end
    object gpbSostituto: TGroupBox
      Left = 1
      Top = 309
      Width = 672
      Height = 34
      Align = alTop
      Caption = 'Sostituto selezionato'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      object lblSostituto: TLabel
        Left = 13
        Top = 15
        Width = 64
        Height = 13
        Caption = 'lblSostituto'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  object D020: TDataSource
    DataSet = A058FPianifTurniDtM1.Q020
    OnDataChange = D020DataChange
    Left = 195
    Top = 65535
  end
  object D265: TDataSource
    DataSet = A058FPianifTurniDtM1.Q265
    OnDataChange = D020DataChange
    Left = 170
    Top = 211
  end
  object D265B: TDataSource
    DataSet = A058FPianifTurniDtM1.Q265B
    OnDataChange = D020DataChange
    Left = 172
    Top = 247
  end
  object D651: TDataSource
    DataSet = A058FPianifTurniDtM1.selT651
    OnDataChange = D651DataChange
    Left = 131
    Top = 124
  end
  object dsrTipoOpe: TDataSource
    DataSet = A058FPianifTurniDtM1.selTipoOpe
    OnDataChange = D020DataChange
    Left = 211
    Top = 119
  end
  object pmuSostituti: TPopupMenu
    OnPopup = pmuSostitutiPopup
    Left = 567
    Top = 311
    object Sceglisostituto1: TMenuItem
      Caption = 'Scegli sostituto'
      OnClick = Sceglisostituto1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object ImpostaFiltroColonna: TMenuItem
      Caption = 'Imposta filtro su colonna '
      OnClick = GestisciFiltroDaGrigliaClick
    end
    object EliminaFiltroColonna: TMenuItem
      Caption = 'Elimina filtro su colonna '
      OnClick = GestisciFiltroDaGrigliaClick
    end
    object AggiungiValoreFiltroColonna: TMenuItem
      Caption = 'Aggiungi valore al filtro su colonna'
      OnClick = GestisciFiltroDaGrigliaClick
    end
    object TogliValoreFiltroColonna: TMenuItem
      Caption = 'Togli valore dal filtro su colonna'
      OnClick = GestisciFiltroDaGrigliaClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object ImpostaOrdinamentoColonna: TMenuItem
      Caption = 'Imposta ordinamento per colonna'
      OnClick = ImpostaOrdinamentoColonnaClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object CopiaInExcel1: TMenuItem
      Caption = 'Copia in Excel'
      OnClick = CopiaInExcel1Click
    end
  end
end
