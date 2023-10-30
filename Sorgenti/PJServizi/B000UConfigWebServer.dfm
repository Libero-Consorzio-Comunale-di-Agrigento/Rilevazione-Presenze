object B000FConfigWebServer: TB000FConfigWebServer
  Left = 286
  Top = 64
  HelpContext = 9000000
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '<B000> Configurazione applicativi web'
  ClientHeight = 733
  ClientWidth = 695
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TPageControl
    Left = 0
    Top = 66
    Width = 695
    Height = 648
    ActivePage = tsIISConfig
    Align = alClient
    TabOrder = 1
    OnChange = PageControlChange
    OnChanging = PageControlChanging
    object tsParametri: TTabSheet
      Caption = 'Parametri di configurazione'
      object grpImpOper: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 27
        Width = 681
        Height = 378
        Align = alTop
        Caption = 'Impostazioni operative'
        Ctl3D = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 1
        DesignSize = (
          681
          378)
        object lblUrlIrisWebCloud: TLabel
          Left = 8
          Top = 296
          Width = 107
          Height = 13
          Caption = 'URL richiamo IrisCloud'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label1: TLabel
          Left = 8
          Top = 33
          Width = 46
          Height = 13
          Caption = 'Database'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblTOOperatore: TLabel
          Left = 8
          Top = 148
          Width = 122
          Height = 13
          Caption = 'Timeout (minuti) operatore'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblTODipendente: TLabel
          Left = 230
          Top = 148
          Width = 56
          Height = 13
          Caption = 'dipendente '
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label5: TLabel
          Left = 8
          Top = 173
          Width = 28
          Height = 13
          Caption = 'Home'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label24: TLabel
          Left = 8
          Top = 58
          Width = 38
          Height = 13
          Caption = 'Azienda'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblProfiloDefault: TLabel
          Left = 8
          Top = 81
          Width = 29
          Height = 13
          Caption = 'Profilo'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblUrlWsAuth: TLabel
          Left = 8
          Top = 217
          Width = 100
          Height = 13
          Caption = 'URL webservice aut.'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblURLMan: TLabel
          Left = 8
          Top = 240
          Width = 91
          Height = 13
          Caption = 'URL manutenzione'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblTabColPartenza: TLabel
          Left = 8
          Top = 286
          Width = 99
          Height = 13
          Caption = 'Tab. col. partenza (*)'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblNumLivelli: TLabel
          Left = 8
          Top = 309
          Width = 75
          Height = 13
          Caption = 'Numero livelli (*)'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblMaxSessioni: TLabel
          Left = 8
          Top = 102
          Width = 83
          Height = 13
          Caption = 'Max sessioni web'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblUrlSuperoMaxSessioni: TLabel
          Left = 8
          Top = 125
          Width = 120
          Height = 13
          Caption = 'URL supero sessioni web'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label2: TLabel
          Left = 8
          Top = 194
          Width = 129
          Height = 13
          Caption = 'URL se login esterno errato'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblPaginaIniziale: TLabel
          Left = 224
          Top = 263
          Width = 67
          Height = 13
          Caption = 'Pagina iniziale'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblPaginaSingola: TLabel
          Left = 8
          Top = 263
          Width = 69
          Height = 13
          Caption = 'Pagina singola'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblMainDir: TLabel
          Left = 8
          Top = 332
          Width = 90
          Height = 13
          Caption = 'Directory principale'
        end
        object lblUrlWebApp: TLabel
          Left = 8
          Top = 355
          Width = 131
          Height = 13
          Caption = 'URL richiamo altra web app'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblUrlBaseINI: TLabel
          Left = 350
          Top = 337
          Width = 48
          Height = 13
          Anchors = [akTop, akRight]
          Caption = 'URL base'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ExplicitLeft = 351
        end
        object edtUrlIrisWebCloud: TEdit
          Left = 145
          Top = 293
          Width = 198
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 15
        end
        object edtTOOperatore: TMaskEdit
          Left = 145
          Top = 145
          Width = 45
          Height = 21
          EditMask = '####'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 4
          ParentFont = False
          ReadOnly = True
          TabOrder = 6
          Text = '    '
        end
        object edtTODipendente: TMaskEdit
          Left = 298
          Top = 145
          Width = 45
          Height = 21
          EditMask = '##'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 2
          ParentFont = False
          ReadOnly = True
          TabOrder = 7
          Text = '  '
        end
        object grpCampiInvisibili: TGroupBox
          AlignWithMargins = True
          Left = 350
          Top = 13
          Width = 322
          Height = 289
          Margins.Top = 0
          Anchors = [akTop, akRight]
          Caption = 'Campi da non visualizzare'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 20
          DesignSize = (
            322
            289)
          object Label16: TLabel
            Left = 8
            Top = 20
            Width = 54
            Height = 13
            Caption = 'Contenitore'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label17: TLabel
            Left = 8
            Top = 47
            Width = 60
            Height = 13
            Caption = 'Componente'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object cmbPagina: TComboBox
            Left = 85
            Top = 17
            Width = 205
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            Sorted = True
            TabOrder = 0
            OnChange = cmbPaginaChange
          end
          object cmbComponente: TComboBox
            Left = 85
            Top = 44
            Width = 205
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            Sorted = True
            TabOrder = 1
          end
          object btnAggiungiCI: TBitBtn
            Left = 293
            Top = 44
            Width = 21
            Height = 21
            Hint = 'Aggiunge il componente selezionato'
            Anchors = [akTop, akRight]
            Enabled = False
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
              0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFF0000000000FF000000FFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000
              00FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFF0000000000FF0000FF0000FF000000FFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000FF00
              00FF0000FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF0000000000FF0000FF0000FF0000FF0000FF000000FFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000FF0000FF00
              00FF0000FF0000FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF0000000000FF0000FF0000FF0000FF0000FF0000FF0000FF000000FFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000
              00FF000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFF0000000000FF000000FFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000
              00FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFF0000000000FF000000FFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000
              00FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFF0000000000FF000000FFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000
              0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
            TabOrder = 2
            OnClick = btnAggiungiCIClick
          end
          object lstCampiInvisibili: TListBox
            Left = 2
            Top = 69
            Width = 318
            Height = 218
            Hint = 'Elenco campi da non visualizzare'
            Align = alBottom
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemHeight = 13
            ParentFont = False
            Sorted = True
            TabOrder = 3
            OnDblClick = lstCampiInvisibiliDblClick
            OnKeyDown = lstCampiInvisibiliKeyDown
          end
        end
        object chkLoginEsterno: TCheckBox
          Left = 6
          Top = 13
          Width = 152
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Login esterno'
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object edtAziendaDefault: TEdit
          Left = 145
          Top = 53
          Width = 200
          Height = 21
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
        end
        object edtProfiloDefault: TEdit
          Left = 145
          Top = 76
          Width = 200
          Height = 21
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
        end
        object edtUrlWsAuth: TEdit
          Left = 145
          Top = 214
          Width = 198
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 10
        end
        object edtURLMan: TEdit
          Left = 145
          Top = 237
          Width = 198
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 11
        end
        object edtTabColPartenza: TEdit
          Left = 145
          Top = 283
          Width = 200
          Height = 21
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 14
        end
        object edtNumLivelli: TMaskEdit
          Left = 145
          Top = 306
          Width = 47
          Height = 21
          EditMask = '###'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 3
          ParentFont = False
          ReadOnly = True
          TabOrder = 16
          Text = '   '
        end
        object edtMaxSessioni: TMaskEdit
          Left = 145
          Top = 99
          Width = 45
          Height = 21
          EditMask = '####'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 4
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
          Text = '    '
        end
        object edtHome: TEdit
          Left = 145
          Top = 168
          Width = 198
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 8
        end
        object edtUrlSuperoMaxSessioni: TEdit
          Left = 145
          Top = 122
          Width = 198
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
        end
        object edtURLLoginErrato: TEdit
          Left = 145
          Top = 191
          Width = 198
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 9
        end
        object edtPaginaIniziale: TEdit
          Left = 296
          Top = 260
          Width = 47
          Height = 21
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 13
        end
        object edtPaginaSingola: TEdit
          Left = 145
          Top = 260
          Width = 47
          Height = 21
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 12
        end
        object chkIrisWebCloudNewTab: TCheckBox
          Left = 8
          Top = 318
          Width = 337
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Apri IrisCloud in un'#39'altra finestra'
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 17
        end
        object edtMainDir: TEdit
          Left = 145
          Top = 329
          Width = 200
          Height = 21
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 18
        end
        object edtUrlWebApp: TEdit
          Left = 145
          Top = 352
          Width = 198
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 19
        end
        object cmbDataBase: TComboBox
          Left = 145
          Top = 30
          Width = 200
          Height = 21
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Text = 'cmbDataBase'
        end
        object edtUrlBaseINI: TEdit
          Left = 350
          Top = 352
          Width = 322
          Height = 21
          Anchors = [akTop, akRight]
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 21
          OnChange = edtUrlBaseINIChange
        end
        object rgpTipoInstallazione: TRadioGroup
          AlignWithMargins = True
          Left = 350
          Top = 302
          Width = 183
          Height = 35
          Anchors = [akTop, akRight]
          Caption = 'Tipo installazione'
          Columns = 2
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemIndex = 0
          Items.Strings = (
            'IIS'
            'Service')
          ParentFont = False
          TabOrder = 22
          OnClick = rgpTipoInstallazioneClick
        end
      end
      object grpImpSist: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 411
        Width = 681
        Height = 188
        Align = alTop
        Caption = 'Impostazioni di sistema'
        Ctl3D = True
        DoubleBuffered = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentCtl3D = False
        ParentDoubleBuffered = False
        ParentFont = False
        TabOrder = 2
        DesignSize = (
          681
          188)
        object Label6: TLabel
          Left = 3
          Top = 32
          Width = 38
          Height = 13
          Caption = 'Porta (*)'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblMaxOpenCursors: TLabel
          Left = 3
          Top = 127
          Width = 84
          Height = 13
          Caption = 'Max open cursors'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblCursoriLogin: TLabel
          Left = 3
          Top = 64
          Width = 61
          Height = 13
          Caption = 'Cursori Login'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblCursoriSessione: TLabel
          Left = 3
          Top = 95
          Width = 78
          Height = 13
          Caption = 'Cursori Sessione'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label36: TLabel
          Left = 3
          Top = 151
          Width = 100
          Height = 26
          Caption = 'Memoria massima per il processo MB (*)'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object grpLogAbil: TGroupBox
          Left = 141
          Top = 8
          Width = 75
          Height = 177
          Caption = 'Log abilitati'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          object chkSessione: TCheckBox
            Left = 7
            Top = 87
            Width = 62
            Height = 17
            Caption = 'Sessione'
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
          object chkAccesso: TCheckBox
            Left = 7
            Top = 119
            Width = 62
            Height = 17
            Caption = 'Accesso'
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object chkTraccia: TCheckBox
            Left = 7
            Top = 151
            Width = 58
            Height = 17
            Caption = 'Traccia'
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
          end
          object chkErrore: TCheckBox
            Left = 7
            Top = 24
            Width = 58
            Height = 17
            Caption = 'Errore'
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object chkMemoria: TCheckBox
            Left = 7
            Top = 56
            Width = 58
            Height = 17
            Caption = 'Memoria'
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
        end
        object grpParAvanzati: TGroupBox
          Left = 220
          Top = 8
          Width = 223
          Height = 144
          Caption = 'Parametri avanzati'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          object chkParametriAvanzati: TCheckListBox
            Left = 2
            Top = 15
            Width = 219
            Height = 127
            Align = alClient
            BevelInner = bvNone
            BevelOuter = bvNone
            BorderStyle = bsNone
            Color = clWhite
            Columns = 1
            Enabled = False
            HeaderColor = clWhite
            HeaderBackgroundColor = clWhite
            ItemHeight = 13
            Items.Strings = (
              'Sono caricati a runtime!')
            TabOrder = 0
          end
        end
        object edtPort: TMaskEdit
          Left = 101
          Top = 31
          Width = 36
          Height = 21
          EditMask = '#####'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 5
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          Text = '     '
        end
        object edtCursoriLogin: TMaskEdit
          Left = 105
          Top = 61
          Width = 32
          Height = 21
          EditMask = '####'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 4
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          Text = '    '
        end
        object edtCursoriSessione: TMaskEdit
          Left = 105
          Top = 92
          Width = 32
          Height = 21
          EditMask = '####'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 4
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
          Text = '    '
        end
        object edtMaxOpenCursors: TMaskEdit
          Left = 105
          Top = 124
          Width = 32
          Height = 21
          EditMask = '####'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 4
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
          Text = '    '
        end
        object edtMaxProcessMemory: TMaskEdit
          Left = 105
          Top = 156
          Width = 32
          Height = 21
          EditMask = '####'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 4
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
          Text = '    '
        end
        object grpReCAPTCHA: TGroupBox
          Left = 447
          Top = 8
          Width = 229
          Height = 144
          Anchors = [akLeft, akTop, akRight]
          Caption = 'ReCAPTCHA'
          TabOrder = 7
          Visible = False
          DesignSize = (
            229
            144)
          object lblUrlReCAPTCHA: TLabel
            Left = 5
            Top = 15
            Width = 13
            Height = 13
            Caption = 'Url'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object lblSiteKeyReCAPTCHA: TLabel
            Left = 5
            Top = 58
            Width = 36
            Height = 13
            Caption = 'SiteKey'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object lblSecretKeyReCAPTCHA: TLabel
            Left = 5
            Top = 99
            Width = 49
            Height = 13
            Caption = 'SecretKey'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object edtUrlReCAPTCHA: TEdit
            Left = 5
            Top = 30
            Width = 220
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            Color = clWhite
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
          end
          object edtSiteKeyReCAPTCHA: TEdit
            Left = 5
            Top = 73
            Width = 220
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            Color = clWhite
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 1
          end
          object edtSecretKeyReCAPTCHA: TEdit
            Left = 5
            Top = 114
            Width = 220
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            Color = clWhite
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
          end
        end
        object rgpCom: TRadioGroup
          AlignWithMargins = True
          Left = 220
          Top = 151
          Width = 456
          Height = 34
          Anchors = [akLeft, akTop, akRight]
          Caption = 'COM'
          Columns = 4
          Enabled = False
          ItemIndex = 0
          Items.Strings = (
            'NULL'
            'NONE'
            'NORMAL'
            'MULTI')
          TabOrder = 8
        end
      end
      object ToolBar1: TToolBar
        Left = 0
        Top = 0
        Width = 687
        Height = 24
        Caption = 'ToolBar'
        Images = imglstToolbarFiglio
        TabOrder = 0
        object btnModifica: TToolButton
          Left = 0
          Top = 0
          Hint = 'Modifica'
          Caption = 'Modifica'
          ImageIndex = 5
          OnClick = btnModificaClick
        end
        object ToolButton4: TToolButton
          Left = 23
          Top = 0
          Width = 8
          Caption = 'ToolButton4'
          ImageIndex = 9
          Style = tbsSeparator
        end
        object btnAnnulla: TToolButton
          Left = 31
          Top = 0
          Hint = 'Annulla'
          Caption = 'Annulla'
          Enabled = False
          ImageIndex = 7
          OnClick = btnAnnullaClick
        end
        object btnSalva: TToolButton
          Left = 54
          Top = 0
          Hint = 'Salva'
          Caption = 'Salva'
          Enabled = False
          ImageIndex = 8
          OnClick = btnSalvaClick
        end
      end
      object pnlInfo: TPanel
        Left = 0
        Top = 602
        Width = 687
        Height = 18
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 3
        object lblParRiavvio: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 156
          Height = 13
          Caption = '(*) = richiesto riavvio servizio web'
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object tsComponenti: TTabSheet
      Caption = 'Registrazione componenti'
      ImageIndex = 1
      object lblMidasPath: TLabel
        Left = 168
        Top = 32
        Width = 3
        Height = 13
      end
      object lblA077ComServer: TLabel
        Left = 209
        Top = 72
        Width = 3
        Height = 13
      end
      object GroupBoxLibrerie: TGroupBox
        Left = 0
        Top = 0
        Width = 687
        Height = 153
        Align = alTop
        Caption = 'Librerie generali'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Label12: TLabel
          Left = 105
          Top = 26
          Width = 138
          Height = 13
          Caption = 'Registra la libreria "midas.dll"'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label27: TLabel
          Left = 105
          Top = 55
          Width = 223
          Height = 13
          Caption = 'Annulla la registrazione della libreria "midas.dll"'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label45: TLabel
          Left = 105
          Top = 94
          Width = 200
          Height = 13
          Caption = 'Registra la libreria "DebenuPDFLibrary.dll"'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label46: TLabel
          Left = 105
          Top = 123
          Width = 285
          Height = 13
          Caption = 'Annulla la registrazione della libreria "DebenuPDFLibrary.dll"'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Shape1: TShape
          Left = 16
          Top = 82
          Width = 397
          Height = 1
        end
        object btnMidasReg: TButton
          Left = 16
          Top = 22
          Width = 73
          Height = 23
          Caption = 'Registra'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = btnMidasRegClick
        end
        object btnMidasUnreg: TButton
          Left = 16
          Top = 51
          Width = 73
          Height = 23
          Caption = 'Annulla'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = btnMidasRegClick
        end
        object btnDebenuPDFReg: TButton
          Left = 16
          Top = 90
          Width = 73
          Height = 23
          Caption = 'Registra'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnClick = btnMidasRegClick
        end
        object btnDebenuPDFUnreg: TButton
          Left = 16
          Top = 119
          Width = 73
          Height = 23
          Caption = 'Annulla'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnClick = btnMidasRegClick
        end
      end
      object GroupBoxGenStampe: TGroupBox
        Left = 0
        Top = 153
        Width = 687
        Height = 157
        Align = alTop
        Caption = 'Generatore di stampe'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object Label13: TLabel
          Left = 105
          Top = 26
          Width = 226
          Height = 13
          Caption = 'Registra il componente "A077PComServer.exe"'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label18: TLabel
          Left = 105
          Top = 99
          Width = 227
          Height = 13
          Caption = 'Registra il componente "P077PCOMServer.exe"'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label19: TLabel
          Left = 105
          Top = 128
          Width = 308
          Height = 13
          Caption = 'Annulla la registrazione del componente "P077PCOMServer.exe"'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label20: TLabel
          Left = 105
          Top = 58
          Width = 309
          Height = 13
          Caption = 'Annulla la registrazione del componente "A077PCOMServer.exe"'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Shape3: TShape
          Left = 17
          Top = 86
          Width = 397
          Height = 1
        end
        object btnRegA077PComServer: TButton
          Left = 16
          Top = 22
          Width = 73
          Height = 23
          Caption = 'Registra'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = btnMidasRegClick
        end
        object btnRegP077PComServer: TButton
          Left = 16
          Top = 95
          Width = 73
          Height = 23
          Caption = 'Registra'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnClick = btnMidasRegClick
        end
        object btnUnRegP077PComServer: TButton
          Left = 16
          Top = 124
          Width = 73
          Height = 23
          Caption = 'Annulla'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnClick = btnMidasRegClick
        end
        object btnUnRegA077PComServer: TButton
          Left = 16
          Top = 54
          Width = 73
          Height = 23
          Caption = 'Annulla'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = btnMidasRegClick
        end
      end
      object GroupBox3: TGroupBox
        Left = 0
        Top = 458
        Width = 687
        Height = 87
        Align = alTop
        Caption = 'Stampa CUD/CU (obsoleto)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        object Label21: TLabel
          Left = 105
          Top = 29
          Width = 227
          Height = 13
          Caption = 'Registra il componente "P714PCOMServer.exe"'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label22: TLabel
          Left = 105
          Top = 58
          Width = 308
          Height = 13
          Caption = 'Annulla la registrazione del componente "P714PCOMServer.exe"'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object btnRegP714PComServer: TButton
          Left = 16
          Top = 25
          Width = 73
          Height = 23
          Caption = 'Registra'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = btnMidasRegClick
        end
        object btnUnRegP714PComServer: TButton
          Left = 16
          Top = 54
          Width = 73
          Height = 23
          Caption = 'Annulla'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = btnMidasRegClick
        end
      end
      object GroupBox6: TGroupBox
        Left = 0
        Top = 397
        Width = 687
        Height = 61
        Align = alTop
        Caption = 'Configurazione stampante standard usata dai print server'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        Visible = False
        object Label38: TLabel
          Left = 105
          Top = 29
          Width = 298
          Height = 13
          Caption = 'Crea le chiavi di registro necessarie in HKEY_USERS\.DEFAULT'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Button2: TButton
          Left = 16
          Top = 25
          Width = 73
          Height = 23
          Caption = 'Crea registri'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = Button2Click
        end
      end
      object GrpStampeCloud: TGroupBox
        Left = 0
        Top = 310
        Width = 687
        Height = 87
        Align = alTop
        Caption = 'Stampe IrisCloud / IrisWEB'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        object lblRegB028PComServer: TLabel
          Left = 105
          Top = 29
          Width = 255
          Height = 13
          Caption = 'Registra il componente "B028PPrintServer_COM.exe"'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblUnRegB028PComServer: TLabel
          Left = 105
          Top = 58
          Width = 336
          Height = 13
          Caption = 
            'Annulla la registrazione del componente "B028PPrintServer_COM.ex' +
            'e"'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object btnRegB028PComServer: TButton
          Left = 16
          Top = 25
          Width = 73
          Height = 23
          Caption = 'Registra'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = btnMidasRegClick
        end
        object btnUnRegB028PComServer: TButton
          Left = 16
          Top = 54
          Width = 73
          Height = 23
          Caption = 'Annulla'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = btnMidasRegClick
        end
      end
    end
    object tsURL: TTabSheet
      Caption = 'Generazione URL'
      ImageIndex = 2
      object grpAzioniUrl: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 47
        Width = 681
        Height = 221
        Align = alTop
        Caption = 'Azioni sito'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        object lblDescrizioneAzione: TLabel
          Left = 191
          Top = 27
          Width = 378
          Height = 13
          AutoSize = False
        end
        object cmbAzioni: TComboBox
          Left = 8
          Top = 24
          Width = 177
          Height = 21
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnChange = cmbAzioniChange
        end
        object btnEseguiAzione: TButton
          Left = 575
          Top = 22
          Width = 90
          Height = 25
          Caption = 'Esegui'
          TabOrder = 1
          OnClick = btnEseguiAzioneClick
        end
        object memRisultato: TMemo
          Left = 8
          Top = 53
          Width = 658
          Height = 157
          Color = clSilver
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
        end
      end
      object grpGenerazioneUrl: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 380
        Width = 681
        Height = 237
        Align = alClient
        Caption = 'Generazione url con parametri'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object lblAziendaGen: TLabel
          Left = 10
          Top = 26
          Width = 38
          Height = 13
          Caption = 'Azienda'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblUtenteGen: TLabel
          Left = 10
          Top = 54
          Width = 32
          Height = 13
          Caption = 'Utente'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblPasswordGen: TLabel
          Left = 10
          Top = 81
          Width = 46
          Height = 13
          Caption = 'Password'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblProfiloGen: TLabel
          Left = 330
          Top = 26
          Width = 29
          Height = 13
          Caption = 'Profilo'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblDatabaseGen: TLabel
          Left = 330
          Top = 53
          Width = 46
          Height = 13
          Caption = 'Database'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblHomeGen: TLabel
          Left = 330
          Top = 80
          Width = 28
          Height = 13
          Caption = 'Home'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object shp1: TShape
          Left = 8
          Top = 111
          Width = 665
          Height = 1
        end
        object lblURL: TLabel
          Left = 10
          Top = 125
          Width = 66
          Height = 13
          Caption = 'URL generato'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object edtUrlAzienda: TEdit
          Left = 83
          Top = 23
          Width = 207
          Height = 21
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnChange = edtUrlAziendaChange
        end
        object edtUrlUtente: TEdit
          Left = 83
          Top = 50
          Width = 207
          Height = 21
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnChange = edtUrlAziendaChange
        end
        object edtUrlPassword: TEdit
          Left = 83
          Top = 77
          Width = 207
          Height = 21
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnChange = edtUrlAziendaChange
        end
        object edtUrlProfilo: TEdit
          Left = 396
          Top = 23
          Width = 207
          Height = 21
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnChange = edtUrlAziendaChange
        end
        object edtUrlHome: TEdit
          Left = 396
          Top = 77
          Width = 207
          Height = 21
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          OnChange = edtUrlAziendaChange
        end
        object edtURLGenerato: TEdit
          Left = 83
          Top = 122
          Width = 586
          Height = 21
          Color = clSilver
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
        end
        object cmbURLDataBase: TComboBox
          Left = 396
          Top = 50
          Width = 207
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          Text = 'cmbURLDataBase'
          OnChange = cmbURLDataBaseChange
        end
      end
      object pnlTop: TPanel
        Left = 0
        Top = 0
        Width = 687
        Height = 44
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object lblUrlBase: TLabel
          Left = 11
          Top = 19
          Width = 39
          Height = 13
          Caption = 'Url base'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsUnderline]
          ParentFont = False
        end
        object edtUrlBase: TEdit
          Left = 85
          Top = 13
          Width = 582
          Height = 21
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
        end
      end
      object grpGestioneSito: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 274
        Width = 681
        Height = 100
        Align = alTop
        Caption = 'Gestione sito'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        object lblMonitorSessioni: TLabel
          Left = 8
          Top = 48
          Width = 76
          Height = 13
          Cursor = crHandPoint
          Caption = 'Monitor sessioni'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsUnderline]
          ParentFont = False
          OnClick = lnkMonitorSessioniClick
        end
        object lblVisParConfig: TLabel
          Left = 8
          Top = 73
          Width = 203
          Height = 13
          Cursor = crHandPoint
          Caption = 'Visualizzazione parametri di configurazione'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsUnderline]
          ParentFont = False
          OnClick = lnkVisParametriConfigClick
        end
        object lblAccessoSito: TLabel
          Left = 8
          Top = 23
          Width = 123
          Height = 13
          Cursor = crHandPoint
          Caption = 'Accesso interattivo al sito'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsUnderline]
          ParentFont = False
          OnClick = lblAccessoSitoClick
        end
      end
    end
    object tsMessaggi: TTabSheet
      Caption = 'Messaggi log'
      ImageIndex = 3
      object Splitter1: TSplitter
        Left = 0
        Top = 216
        Width = 687
        Height = 4
        Cursor = crVSplit
        Align = alTop
        ExplicitWidth = 602
      end
      object GroupBox4: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 681
        Height = 45
        Align = alTop
        Caption = 'Connessione database'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object Label28: TLabel
          Left = 310
          Top = 20
          Width = 46
          Height = 13
          Caption = 'Database'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label29: TLabel
          Left = 8
          Top = 20
          Width = 32
          Height = 13
          Caption = 'Utente'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label30: TLabel
          Left = 149
          Top = 20
          Width = 46
          Height = 13
          Caption = 'Password'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object edtPasswordMsg: TEdit
          Left = 202
          Top = 17
          Width = 97
          Height = 21
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          PasswordChar = '*'
          TabOrder = 1
          Text = 'TIMOTEO'
        end
        object edtUtenteMsg: TEdit
          Left = 47
          Top = 17
          Width = 92
          Height = 21
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          Text = 'MONDOEDP'
        end
        object btnLogon: TButton
          Left = 539
          Top = 15
          Width = 74
          Height = 25
          Caption = 'Connetti'
          Default = True
          TabOrder = 2
          OnClick = btnLogonClick
        end
        object cmbDataBaseMsg: TComboBox
          Left = 362
          Top = 17
          Width = 145
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          Text = 'cmbDataBaseMsg'
        end
      end
      object GroupBox5: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 54
        Width = 681
        Height = 159
        Align = alTop
        Caption = 'Elenco messaggi'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object dbgHead: TDBGrid
          Left = 2
          Top = 43
          Width = 677
          Height = 114
          Align = alClient
          DataSource = B000FConfigWebServerDM.dsrMsgHead
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clBlue
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'ID'
              Width = 57
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DATA'
              Title.Caption = 'Data'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'HOSTNAME'
              Title.Caption = 'Hostname'
              Width = 90
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'HOSTIPADDRESS'
              Title.Caption = 'Host IP'
              Width = 70
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'MASCHERA'
              Title.Caption = 'Maschera'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'COUNTMSG'
              Title.Caption = 'Righe'
              Width = 49
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DATA_INI'
              Title.Caption = 'Inizio'
              Width = 90
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DATA_FINE'
              Title.Caption = 'Fine'
              Width = 90
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'MAX_SESSIONI'
              Title.Caption = 'Max sessioni'
              Width = 77
              Visible = True
            end>
        end
        object Panel2: TPanel
          Left = 2
          Top = 15
          Width = 677
          Height = 28
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          DesignSize = (
            677
            28)
          object Label31: TLabel
            Left = 7
            Top = 6
            Width = 53
            Height = 13
            Caption = 'Periodo dal'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label32: TLabel
            Left = 145
            Top = 6
            Width = 8
            Height = 13
            Caption = 'al'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object lblNumMsg: TLabel
            Left = 576
            Top = 7
            Width = 96
            Height = 13
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = 'Num. messaggi: nnn'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ExplicitLeft = 491
          end
          object edtDal: TMaskEdit
            Left = 71
            Top = 3
            Width = 66
            Height = 21
            EditMask = '!99/99/9999;1;_'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 10
            ParentFont = False
            TabOrder = 0
            Text = '  /  /    '
          end
          object edtAl: TMaskEdit
            Left = 163
            Top = 3
            Width = 68
            Height = 21
            EditMask = '!99/99/9999;1;_'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 10
            ParentFont = False
            TabOrder = 1
            Text = '  /  /    '
          end
          object btnFiltra: TButton
            Left = 238
            Top = 1
            Width = 68
            Height = 25
            Caption = 'Filtra'
            Default = True
            Enabled = False
            TabOrder = 2
            OnClick = btnFiltraClick
          end
        end
      end
      object grpDett: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 223
        Width = 681
        Height = 394
        Align = alClient
        Caption = 'Dettaglio messaggio'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        Visible = False
        object dgrdDettaglio: TDBGrid
          Left = 2
          Top = 41
          Width = 677
          Height = 351
          Align = alClient
          DataSource = B000FConfigWebServerDM.dsrMsgDett
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clBlue
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'DATA_MSG'
              Title.Caption = 'Data'
              Width = 88
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'C_TIPO_MSG'
              Title.Alignment = taCenter
              Title.Caption = 'T'
              Width = 18
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'C_NUMSESS'
              Title.Caption = 'Sessioni'
              Width = 46
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'C_IDSESS'
              Title.Caption = 'ID Sessione'
              Width = 152
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'C_IPCLIENT'
              Title.Caption = 'IP Client'
              Width = 86
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'C_BROWSER'
              Title.Caption = 'Browser'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'C_FORM'
              Title.Caption = 'Form'
              Width = 45
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'C_DETT'
              Title.Caption = 'Messaggio'
              Width = 328
              Visible = True
            end>
        end
        object Panel1: TPanel
          Left = 2
          Top = 15
          Width = 677
          Height = 26
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object chkFiltroErrore: TCheckBox
            Left = 6
            Top = 3
            Width = 70
            Height = 17
            Caption = 'Errore'
            Checked = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            State = cbChecked
            TabOrder = 0
            OnClick = chkFiltroErroreClick
          end
          object chkFiltroSessione: TCheckBox
            Left = 190
            Top = 3
            Width = 70
            Height = 17
            Caption = 'Sessione'
            Checked = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            State = cbChecked
            TabOrder = 2
            OnClick = chkFiltroErroreClick
          end
          object chkFiltroAccesso: TCheckBox
            Left = 282
            Top = 3
            Width = 70
            Height = 17
            Caption = 'Accesso'
            Checked = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            State = cbChecked
            TabOrder = 3
            OnClick = chkFiltroErroreClick
          end
          object chkFiltroTraccia: TCheckBox
            Left = 375
            Top = 3
            Width = 70
            Height = 17
            Caption = 'Traccia'
            Checked = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            State = cbChecked
            TabOrder = 4
            OnClick = chkFiltroErroreClick
          end
          object chkFiltroMemoria: TCheckBox
            Left = 98
            Top = 3
            Width = 70
            Height = 17
            Caption = 'Memoria'
            Checked = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            State = cbChecked
            TabOrder = 1
            OnClick = chkFiltroErroreClick
          end
        end
      end
    end
    object tsIISConfig: TTabSheet
      Caption = 'Configurazione IIS'
      ImageIndex = 5
      object grpWebConfig: TGroupBox
        Left = 0
        Top = 24
        Width = 687
        Height = 596
        Align = alClient
        Caption = 'Web.config'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object lblDLLProdotto: TLabel
          Left = 9
          Top = 51
          Width = 65
          Height = 13
          Caption = 'Percorso DLL'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblVirtualPath: TLabel
          Left = 10
          Top = 20
          Width = 79
          Height = 13
          Caption = 'Percorso virtuale'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblVirtualPathValue: TLabel
          Left = 97
          Top = 20
          Width = 3
          Height = 13
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblModuloNonInstallato: TLabel
          Left = 10
          Top = 215
          Width = 177
          Height = 13
          Caption = 'Modulo "URL Rewrite" non installato!'
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          Visible = False
        end
        object edtDLLPath: TEdit
          Left = 79
          Top = 46
          Width = 560
          Height = 21
          Enabled = False
          ReadOnly = True
          TabOrder = 0
        end
        object bntSelezionaDLL: TButton
          Left = 643
          Top = 44
          Width = 29
          Height = 25
          Caption = '...'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = bntSelezionaDLLClick
        end
        object grpURLRewrite: TGroupBox
          Left = 10
          Top = 90
          Width = 247
          Height = 119
          Caption = 'Modulo URL rewrite'
          Color = clBtnFace
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          TabOrder = 2
          object chkHttps: TCheckBox
            Left = 10
            Top = 24
            Width = 137
            Height = 17
            Caption = 'Forza HTTP(S) nelle URL'
            TabOrder = 0
          end
          object chkMonitorPrivati: TCheckBox
            Left = 10
            Top = 71
            Width = 180
            Height = 17
            Caption = 'Monitor iw(monitor|config) privati'
            TabOrder = 2
          end
          object chkPaginaManutenzione: TCheckBox
            Left = 10
            Top = 47
            Width = 180
            Height = 17
            Caption = 'Redirect pagina di manutenzione'
            TabOrder = 1
          end
          object chkForzaDominioCookie: TCheckBox
            Left = 10
            Top = 94
            Width = 180
            Height = 17
            Caption = 'Aggiungi dominio sui cookie'
            TabOrder = 3
          end
        end
        object grpHiddenSegments: TGroupBox
          Left = 263
          Top = 90
          Width = 412
          Height = 252
          Caption = 'Directory private'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          object lstDirectoryPrivate: TListBox
            Left = 9
            Top = 20
            Width = 319
            Height = 223
            ItemHeight = 13
            TabOrder = 0
          end
          object btnAggiungiHiddenSegments: TButton
            Left = 334
            Top = 20
            Width = 75
            Height = 25
            Caption = '+'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnClick = btnAggiungiHiddenSegmentsClick
          end
          object btnRimuoviHiddenSegments: TButton
            Left = 334
            Top = 49
            Width = 75
            Height = 25
            Caption = '-'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnClick = btnRimuoviHiddenSegmentsClick
          end
        end
        object grbPagineErroreCustom: TGroupBox
          Left = 10
          Top = 237
          Width = 247
          Height = 105
          Caption = 'Pagina di errore personalizzata'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          object cblPagineErrore: TCheckListBox
            Left = 3
            Top = 22
            Width = 241
            Height = 80
            ItemHeight = 13
            Items.Strings = (
              '401'
              '403'
              '404'
              '405'
              '406'
              '412'
              '431'
              '500'
              '501'
              '502')
            TabOrder = 0
          end
        end
        object btnScaricaURLRewrite: TButton
          Left = 191
          Top = 215
          Width = 66
          Height = 16
          Caption = 'Scarica'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          Visible = False
          OnClick = btnScaricaURLRewriteClick
        end
        object btnSalvaWebConfig: TButton
          Left = 552
          Top = 348
          Width = 123
          Height = 25
          Caption = 'Genera / Sovrascrivi'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          OnClick = btnSalvaWebConfigClick
        end
        object chkOverrideDefaultPage: TCheckBox
          Left = 424
          Top = 20
          Width = 248
          Height = 17
          Caption = 'Sovrascrivere home page (index.html/DLL login)'
          TabOrder = 7
        end
      end
      object ToolBar3: TToolBar
        Left = 0
        Top = 0
        Width = 687
        Height = 24
        Caption = 'ToolBar'
        Images = imglstToolbarFiglio
        TabOrder = 1
        object btnModifica3: TToolButton
          Left = 0
          Top = 0
          Hint = 'Modifica'
          Caption = 'Modifica'
          ImageIndex = 5
          OnClick = btnModificaClick
        end
        object ToolButton3: TToolButton
          Left = 23
          Top = 0
          Width = 8
          Caption = 'ToolButton4'
          ImageIndex = 9
          Style = tbsSeparator
        end
        object btnAnnulla3: TToolButton
          Left = 31
          Top = 0
          Hint = 'Annulla'
          Caption = 'Annulla'
          Enabled = False
          ImageIndex = 7
          OnClick = btnAnnullaClick
        end
        object btnSalva3: TToolButton
          Left = 54
          Top = 0
          Hint = 'Salva'
          Caption = 'Salva'
          Enabled = False
          ImageIndex = 8
          OnClick = btnSalvaClick
        end
      end
    end
    object tsAltro: TTabSheet
      Caption = 'Altro'
      ImageIndex = 4
      object ToolBar2: TToolBar
        Left = 0
        Top = 0
        Width = 687
        Height = 24
        Caption = 'ToolBar'
        Images = imglstToolbarFiglio
        TabOrder = 0
        object btnModifica2: TToolButton
          Left = 0
          Top = 0
          Hint = 'Modifica'
          Caption = 'Modifica'
          ImageIndex = 5
          OnClick = btnModificaClick
        end
        object ToolButton2: TToolButton
          Left = 23
          Top = 0
          Width = 8
          Caption = 'ToolButton4'
          ImageIndex = 9
          Style = tbsSeparator
        end
        object btnAnnulla2: TToolButton
          Left = 31
          Top = 0
          Hint = 'Annulla'
          Caption = 'Annulla'
          Enabled = False
          ImageIndex = 7
          OnClick = btnAnnullaClick
        end
        object btnSalva2: TToolButton
          Left = 54
          Top = 0
          Hint = 'Salva'
          Caption = 'Salva'
          Enabled = False
          ImageIndex = 8
          OnClick = btnSalvaClick
        end
      end
      object pnlAltroSettings: TPanel
        Left = 0
        Top = 24
        Width = 687
        Height = 593
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object grpExceptionLogger: TGroupBox
          Left = 3
          Top = 6
          Width = 679
          Height = 187
          Caption = '        '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          object lblELNomeFile: TLabel
            Left = 8
            Top = 49
            Width = 61
            Height = 13
            Caption = 'Nome dei file'
          end
          object lblELPathFile: TLabel
            Left = 8
            Top = 24
            Width = 76
            Height = 13
            Caption = 'Percorso dei file'
          end
          object lblELPurge1: TLabel
            Left = 8
            Top = 73
            Width = 115
            Height = 13
            Caption = 'Rimuovi log pi'#249' vecchi di'
          end
          object lblELPurge2: TLabel
            Left = 179
            Top = 73
            Width = 26
            Height = 13
            Caption = 'giorni'
          end
          object grpELEcc: TGroupBox
            Left = 320
            Top = 10
            Width = 351
            Height = 172
            Caption = 'Eccezioni da ignorare'
            TabOrder = 0
            object lblELEccPredefinite: TLabel
              Left = 8
              Top = 16
              Width = 52
              Height = 13
              Caption = 'Predefinite'
            end
            object lblELEccCustom: TLabel
              Left = 7
              Top = 131
              Width = 36
              Height = 13
              Caption = 'Custom'
            end
            object chkELEccPredefinite: TCheckListBox
              Left = 7
              Top = 29
              Width = 337
              Height = 98
              Columns = 1
              ItemHeight = 13
              Items.Strings = (
                'System.SysUtils.EAccessViolation'
                'System.SysUtils.EExternalException'
                'System.SysUtils.EMonitorLockException'
                'ENoCookieSupportException'
                'Oracle.EOracleError'
                'IWException.ESessionAlreadyLocked'
                'IWException.EIWSecurityException'
                'IWException.EUnknownBrowserException'
                'EInvalidSession'
                'EExpiredSession'
                'System.Classes.EWriteError')
              TabOrder = 0
            end
            object edtELEccCustom: TEdit
              Left = 7
              Top = 146
              Width = 337
              Height = 21
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
            end
          end
          object edtELPathFile: TEdit
            Left = 98
            Top = 21
            Width = 216
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object edtELNomeFile: TEdit
            Left = 98
            Top = 46
            Width = 216
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
          object edtELNumGiorniPurge: TSpinEdit
            Left = 131
            Top = 70
            Width = 42
            Height = 22
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxValue = 999
            MinValue = 0
            ParentFont = False
            TabOrder = 3
            Value = 0
          end
          object memELHelp: TMemo
            Left = 6
            Top = 97
            Width = 308
            Height = 85
            BorderStyle = bsNone
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Lines.Strings = (
              'Configura l'#39'exception logger integrato in Intraweb. La '
              'configurazione sui log presente nelle scheda "Parametri di '
              'configurazione" riguarda il sistema di logging di '
              'MondoEDP.'
              '- Se non '#232' specificato alcun percorso, sar'#224' usato X:'
              '\<directory EXE/DLL>\ErrorLog'
              '- Se non '#232' specificato alcun file, sar'#224' utilizzato '
              '<nome_app>@<timestamp>.log'
              '- Se il numero di giorni '#232' impostato a 0, non sar'#224' eseguita '
              'alcuna pulizia.'
              '- Saranno ignorate le eccezioni selezionate in "Predefinite" '
              'e quelle specificate nella casella "Custom" (separare i nomi '
              'delle eccezioni tra loro con una virgola). Possibilmente '
              'specificare i nomi delle eccezioni comprensive delle unit che '
              'le contengono. In caso contrario, si cercher'#224' comunque di '
              'determinare la classe dell'#39'eccezione.')
            ParentFont = False
            ReadOnly = True
            ScrollBars = ssVertical
            TabOrder = 4
          end
        end
        object chkEnableExcLog: TCheckBox
          Left = 13
          Top = 6
          Width = 158
          Height = 14
          Caption = 'Abilita exception logger (*)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = chkEnableExcLogClick
        end
        object grpIrisAPP: TGroupBox
          AlignWithMargins = True
          Left = 3
          Top = 145
          Width = 681
          Height = 445
          Align = alBottom
          Caption = 'Impostazioni operative'
          Ctl3D = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 2
          object Label7: TLabel
            Left = 6
            Top = 33
            Width = 46
            Height = 13
            Caption = 'Database'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label8: TLabel
            Left = 6
            Top = 194
            Width = 74
            Height = 13
            Caption = 'Timeout (minuti)'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label10: TLabel
            Left = 6
            Top = 276
            Width = 28
            Height = 13
            Caption = 'Home'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label14: TLabel
            Left = 6
            Top = 58
            Width = 38
            Height = 13
            Caption = 'Azienda'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label15: TLabel
            Left = 6
            Top = 102
            Width = 29
            Height = 13
            Caption = 'Profilo'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label26: TLabel
            Left = 348
            Top = 56
            Width = 91
            Height = 13
            Caption = 'URL manutenzione'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label35: TLabel
            Left = 6
            Top = 149
            Width = 60
            Height = 13
            Caption = 'Max sessioni'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label37: TLabel
            Left = 348
            Top = 33
            Width = 97
            Height = 13
            Caption = 'URL supero sessioni'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label39: TLabel
            Left = 348
            Top = 79
            Width = 129
            Height = 13
            Caption = 'URL se login esterno errato'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label40: TLabel
            Left = 6
            Top = 299
            Width = 67
            Height = 13
            Caption = 'Pagina iniziale'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label42: TLabel
            Left = 6
            Top = 322
            Width = 90
            Height = 13
            Caption = 'Directory principale'
          end
          object Label44: TLabel
            Left = 348
            Top = 102
            Width = 48
            Height = 13
            Caption = 'URL base'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label4: TLabel
            Left = 6
            Top = 171
            Width = 63
            Height = 13
            Caption = 'Max requests'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label25: TLabel
            Left = 6
            Top = 253
            Width = 26
            Height = 13
            Caption = 'Titolo'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label41: TLabel
            Left = 6
            Top = 125
            Width = 56
            Height = 13
            Caption = 'Stato profilo'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label43: TLabel
            Left = 6
            Top = 79
            Width = 65
            Height = 13
            Caption = 'Stato azienda'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object edtIATimeout: TMaskEdit
            Left = 144
            Top = 191
            Width = 47
            Height = 21
            EditMask = '###'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 3
            ParentFont = False
            ReadOnly = True
            TabOrder = 8
            Text = '   '
          end
          object chkIALoginEsterno: TCheckBox
            Left = 4
            Top = 13
            Width = 152
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Login esterno'
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object edtIAAzienda: TEdit
            Left = 145
            Top = 53
            Width = 184
            Height = 21
            Color = clWhite
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
          end
          object edtIAProfilo: TEdit
            Left = 144
            Top = 99
            Width = 185
            Height = 21
            Color = clWhite
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 4
          end
          object edtIAURLManutenzione: TEdit
            Left = 491
            Top = 53
            Width = 184
            Height = 21
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 16
          end
          object edtIAMaxSessioni: TMaskEdit
            Left = 144
            Top = 145
            Width = 48
            Height = 21
            EditMask = '####'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 4
            ParentFont = False
            ReadOnly = True
            TabOrder = 6
            Text = '    '
          end
          object edtIAHome: TEdit
            Left = 145
            Top = 273
            Width = 184
            Height = 21
            Color = clWhite
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 12
          end
          object edtIAURLSuperoMaxSessioni: TEdit
            Left = 491
            Top = 30
            Width = 184
            Height = 21
            Color = clWhite
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 15
          end
          object edtIAURLLoginErrato: TEdit
            Left = 491
            Top = 76
            Width = 184
            Height = 21
            Color = clWhite
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 17
          end
          object edtIAPaginaIniziale: TEdit
            Left = 145
            Top = 296
            Width = 47
            Height = 21
            Color = clWhite
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 13
          end
          object edtIAMainDir: TEdit
            Left = 145
            Top = 319
            Width = 184
            Height = 21
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 14
          end
          object cmbIADatabase: TComboBox
            Left = 145
            Top = 30
            Width = 184
            Height = 21
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            Text = 'cmbDataBase'
          end
          object edtIAURLBase: TEdit
            Left = 491
            Top = 99
            Width = 184
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 18
            OnChange = edtUrlBaseINIChange
          end
          object chkIARegistraCredenziali: TCheckBox
            Left = 4
            Top = 215
            Width = 152
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Registra credenziali'
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 9
          end
          object GroupBox7: TGroupBox
            Left = 346
            Top = 120
            Width = 329
            Height = 185
            Caption = 'Impostazioni sistema (B110)'
            TabOrder = 19
            object Label9: TLabel
              Left = 12
              Top = 45
              Width = 22
              Height = 13
              Caption = 'Host'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label11: TLabel
              Left = 12
              Top = 71
              Width = 19
              Height = 13
              Caption = 'Port'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label33: TLabel
              Left = 12
              Top = 97
              Width = 13
              Height = 13
              Caption = 'Url'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label34: TLabel
              Left = 12
              Top = 129
              Width = 44
              Height = 13
              Caption = 'Url di test'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object edtIAB110Host: TEdit
              Left = 102
              Top = 42
              Width = 200
              Height = 21
              Color = clWhite
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 0
              OnChange = edtIAB110HostChange
            end
            object edtIAB110Port: TEdit
              Left = 102
              Top = 68
              Width = 200
              Height = 21
              Color = clWhite
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 1
              OnChange = edtIAB110HostChange
            end
            object chkIAB110Protocollo: TCheckBox
              Left = 12
              Top = 21
              Width = 104
              Height = 17
              Alignment = taLeftJustify
              Caption = 'Protocollo https'
              Enabled = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
              OnClick = chkIAB110ProtocolloClick
            end
            object edtIAB110Url: TEdit
              Left = 102
              Top = 94
              Width = 200
              Height = 21
              Color = clWhite
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 3
              OnChange = edtIAB110HostChange
            end
            object edtIAB110UrlTest: TEdit
              Left = 102
              Top = 123
              Width = 200
              Height = 21
              Color = clSilver
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 4
            end
            object btnIAB110Test: TButton
              Left = 102
              Top = 152
              Width = 75
              Height = 25
              Caption = 'Test'
              TabOrder = 5
              OnClick = btnIAB110TestClick
            end
          end
          object GroupBox8: TGroupBox
            Left = 346
            Top = 306
            Width = 329
            Height = 88
            Caption = 'UG Exception logger'
            TabOrder = 20
            object chkUGExceptionIndy: TCheckBox
              Left = 12
              Top = 20
              Width = 122
              Height = 17
              Alignment = taLeftJustify
              Caption = 'Indy Exceptions'
              Enabled = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
            end
            object chkUGExceptionIndySSL: TCheckBox
              Left = 12
              Top = 40
              Width = 122
              Height = 17
              Alignment = taLeftJustify
              Caption = 'Indy SSL Exceptions'
              Enabled = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
            end
            object chkUGExceptionSession: TCheckBox
              Left = 12
              Top = 59
              Width = 122
              Height = 17
              Alignment = taLeftJustify
              Caption = 'Session Exceptions'
              Enabled = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
            end
          end
          object chkIARecuperoPassword: TCheckBox
            Left = 4
            Top = 233
            Width = 152
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Recupero password'
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 10
          end
          object edtIAMaxRequests: TMaskEdit
            Left = 144
            Top = 168
            Width = 47
            Height = 21
            EditMask = '####'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 4
            ParentFont = False
            ReadOnly = True
            TabOrder = 7
            Text = '    '
          end
          object edtIATitolo: TEdit
            Left = 145
            Top = 250
            Width = 184
            Height = 21
            Color = clWhite
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 11
          end
          object cmbIAStatoProfilo: TComboBox
            Left = 144
            Top = 122
            Width = 48
            Height = 21
            Style = csDropDownList
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
            Items.Strings = (
              ''
              'S'
              'N'
              'R')
          end
          object cmbIAStatoAzienda: TComboBox
            Left = 144
            Top = 76
            Width = 48
            Height = 21
            Style = csDropDownList
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            Items.Strings = (
              ''
              'S'
              'N'
              'R')
          end
          object grpIAReCAPTCHA: TGroupBox
            Left = 6
            Top = 344
            Width = 323
            Height = 94
            Caption = 'ReCAPTCHA'
            TabOrder = 21
            object lblIAUrlRECAPTCHA: TLabel
              Left = 10
              Top = 22
              Width = 13
              Height = 13
              Caption = 'Url'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object lblIASiteKeyRECAPTCHA: TLabel
              Left = 10
              Top = 43
              Width = 36
              Height = 13
              Caption = 'SiteKey'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object lblIASecretKeyRECAPTCHA: TLabel
              Left = 10
              Top = 67
              Width = 49
              Height = 13
              Caption = 'SecretKey'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object edtIAUrlRECAPTCHA: TEdit
              Left = 72
              Top = 16
              Width = 244
              Height = 21
              Color = clWhite
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 0
            end
            object edtIASiteKeyRECAPTCHA: TEdit
              Left = 72
              Top = 40
              Width = 244
              Height = 21
              Color = clWhite
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 1
            end
            object edtIASecretKeyRECAPTCHA: TEdit
              Left = 72
              Top = 64
              Width = 244
              Height = 21
              Color = clWhite
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 2
            end
          end
        end
      end
      object pnlAltroInfo: TPanel
        Left = 0
        Top = 617
        Width = 687
        Height = 3
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 2
        object Label3: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 8
          Width = 156
          Height = 13
          Caption = '(*) = richiesto riavvio servizio web'
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 714
    Width = 695
    Height = 19
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Panels = <
      item
        Text = 'Gestione configurazione'
        Width = 300
      end
      item
        Text = 'Non connesso'
        Width = 95
      end
      item
        Width = 250
      end>
    UseSystemFont = False
  end
  object pnlApplicativo: TPanel
    Left = 0
    Top = 0
    Width = 695
    Height = 50
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object GroupBox1: TGroupBox
      AlignWithMargins = True
      Left = 361
      Top = 3
      Width = 331
      Height = 44
      Align = alClient
      Caption = 'Path base applicativo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object edtPathBase: TEdit
        AlignWithMargins = True
        Left = 5
        Top = 18
        Width = 321
        Height = 21
        Align = alClient
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
    end
    object rgpApplicativo: TRadioGroup
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 352
      Height = 44
      Align = alLeft
      Caption = 'Applicativo'
      Columns = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'IrisWeb'
        'IrisCloud'
        'X001')
      ParentFont = False
      TabOrder = 1
      OnClick = rgpApplicativoClick
    end
  end
  object pnlInfoApplicativo: TPanel
    Left = 0
    Top = 50
    Width = 695
    Height = 16
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
  end
  object imglstToolbarFiglio: TImageList
    Left = 593
    Top = 46
    Bitmap = {
      494C010113001500040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000005000000001002000000000000050
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000007B7B
      7B000000000000000000000000007B7B7B000000000000FFFF007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B00000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      FF000000000000000000000000000000000000FFFF0000FFFF0000FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000FFFF0000FFFF000000000000000000000000007B7B7B00FFFF
      FF00BDBDBD00FFFFFF00BDBDBD00FFFFFF007B7B7B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000FFFF0000FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000FFFF0000FFFF0000FFFF007B7B7B007B7B7B00FFFFFF00BDBD
      BD00FFFFFF000000FF00FFFFFF00BDBDBD00FFFFFF007B7B7B007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00BDBDBD00FFFF
      FF00BDBDBD000000FF00BDBDBD00FFFFFF00BDBDBD007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      000000000000000000000000000000000000000000007B7B7B00FFFFFF000000
      FF000000FF000000FF000000FF000000FF00FFFFFF007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF000000000000FF
      FF0000000000000000000000000000000000000000007B7B7B00BDBDBD00FFFF
      FF00BDBDBD000000FF00BDBDBD00FFFFFF00BDBDBD007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000FF
      FF0000FFFF000000000000000000000000007B7B7B007B7B7B00FFFFFF00BDBD
      BD00FFFFFF000000FF00FFFFFF00BDBDBD00FFFFFF007B7B7B007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF00000000000000000000000000000000007B7B7B00FFFF
      FF00BDBDBD00FFFFFF00BDBDBD00FFFFFF007B7B7B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF000000
      000000000000000000000000000000FFFF0000FFFF0000000000000000000000
      00000000000000FFFF0000FFFF00000000000000000000000000000000007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000840000008400000084000000840000008400
      0000840000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00840000000000000000000000FFFFFF00000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000FFFFFF000000000000000000000000000000
      000000000000FFFFFF00840000000000000000000000FFFFFF00000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000840000008400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF0000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000FFFFFF000000000000000000000000000000
      000000000000FFFFFF0084000000000000000000000000000000FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF0000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000000000000000000000000000FFFFFF000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      84000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000FFFFFF000000000000000000FFFFFF008400
      0000840000008400000084000000000000000000000000000000FFFFFF000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      0000008484000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF0000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF008400
      0000FFFFFF008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000000000FF
      FF00000000000084840000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF0000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF008400
      000084000000000000000000000000000000000000000000000000000000FFFF
      FF000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      000000FFFF000000000000848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000084000000840000008400000084000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF000000000000FFFF0000848400008484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000FFFF00008484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      0000000000008400000084000000840000008400000084000000840000008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00848484008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000008400000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000C6C6C6000000000000000000000000000000000000000000000000000000
      00000000000084000000FFFFFF00FFFFFF00FFFFFF0084848400840000008484
      8400840000000000000000000000000000000000000000000000000000000000
      0000000000000000000000840000008400000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000840000008400000084000000840000008400000084
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C60000000000000000000000000000000000000000000000
      00000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00848484008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000084000000840000008400000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000008400000084000000000000000000000000
      00000084000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C60000FFFF0000FFFF0000FFFF00C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      00000000000084000000FFFFFF00FFFFFF00FFFFFF0084848400840000008484
      8400840000000000000000000000000000000000000000000000000000000000
      0000008400000084000000FF000000FF00000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000084000000000000000000000000
      00000084000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600848484008484840084848400C6C6C600C6C6
      C60000000000C6C6C60000000000000000000000000000000000000000000000
      00000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00848484008484
      8400840000000000000000000000000000000000000000000000000000000084
      000000FF000000FF00000000000000FF00000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600C6C6C600000000000000000000000000000000000000
      0000000000008400000084000000840000008400000084000000840000008400
      00008400000084848400000000000000000000000000000000000000000000FF
      000000FF0000000000000000000000FF000000FF000000840000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000084000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000C6C6C60000000000C6C6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF000000840000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C60000000000C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000000000000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF0000008400000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008400000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000C6C6C60000000000C6C6C600000000000000000000000000000000000000
      0000000000008400000084000000000000000000000000000000000000000000
      0000000000008400000084848400000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF00000084
      0000000000000000000000000000000000000000000000000000000000000000
      0000008400000000000000000000000000000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084000000FFFFFF0000000000840000000000000000000000000000000000
      0000840000008484840084000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF00000084
      0000000000000000000000000000000000000000000000000000000000000000
      0000008400000000000000000000000000000084000000840000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000084000000FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000848484008400000084000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      0000008400000000000000000000000000000000000000000000000000000000
      0000000000000084000000840000008400000084000000840000008400000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF00000084000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000084000000840000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000000000000000000000000000000000000000
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
      0000000000000000000000000000000084000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      00000000FF000000FF0000008400000000000000000000000000000000000000
      000000000000000000000000FF00000000000000000000000000000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000840084848400848484000000000000000000000000000000
      0000000000008484840084848400000000000000000000000000000000000000
      0000000084000000FF0000008400000000000000000000000000000000000000
      0000000000000000840000000000000000000000000000000000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000000000000000000000000000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008400000000000000
      0000000000000000840000008400848484008484840000000000000000000000
      0000000000000000840000000000000000000000000000000000000000000000
      000000000000000084000000FF000000FF000000000000000000000000000000
      00000000FF000000840000000000000000000000000000000000000084000000
      8400000084000000000000000000000000000000000000000000840000000000
      0000840000000000000000000000000000000000000000000000000084000000
      8400000084000000000000000000000000000000000000FFFF00848484000000
      0000000000000000000000000000000000000000000000008400000084000000
      0000000000008484840000008400000084008484840000000000000000000000
      0000848484000000840000000000000000000000000000000000000000000000
      00000000000000000000000084000000FF000000840000000000000000000000
      84000000FF000000000000000000000000000000000000000000000084000000
      8400000084000000840000000000000000000000000000000000000000008400
      0000840000008400000000000000000000000000000000000000000084000000
      8400000084000000840000000000000000000000000000FFFF00848484000000
      0000000000000000000000000000000000000000000000008400000084000000
      8400000000000000000000008400000084008484840084848400000000000000
      8400000084008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000084000000FF00000084000000FF000000
      FF00000000000000000000000000000000000000000000000000000084000000
      8400000084000000840000008400000000000000000084000000840000008400
      0000840000008400000084000000000000000000000000000000000084000000
      84000000840000008400000000000000000000000000C6C6C60000FFFF008484
      8400000000000000000000000000000000000000000000008400000084000000
      8400000084000000000084848400000084000000840084848400848484000000
      8400000084000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF00000084000000FF000000
      0000000000000000000000000000000000000000000000000000000084000000
      8400000084000000840000000000000000000000000000000000000000008400
      0000840000008400000000000000000000000000000000000000000084000000
      8400000084000000840000000000000000000000000000000000C6C6C60000FF
      FF00848484000000000000000000000000000000000000008400000084000000
      8400000084000000840000000000000084000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF00000084000000FF00000084000000
      8400000000000000000000000000000000000000000000000000000084000000
      8400000084000000000000000000000000000000000000000000840000000000
      0000840000000000000000000000000000000000000000000000000084000000
      84000000840000000000000000000000000000000000000000000000000000FF
      FF00848484000000000000000000000000000000000000008400000084000000
      8400000084000000000000000000848484000000840000008400000084008484
      8400000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000084000000FF000000840000000000000000000000
      FF00000000000000000000000000000000000000000000000000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000000000000000000000000000000084000000
      840000000000000000000000000000000000000000000000000000000000C6C6
      C60000FFFF008484840000000000000000000000000000008400000084000000
      8400000000008484840084848400000084000000840000008400000084008484
      8400848484000000000000000000000000000000000000000000000000000000
      00000000FF00000084000000FF00000084000000000000000000000000000000
      0000000084000000FF0000000000000000000000000000000000000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6C6C60000FFFF0000000000000000000000000000008400000084000000
      0000848484000000840000008400000000000000000084848400000084000000
      8400848484008484840000000000000000000000000000000000000000000000
      84000000FF00000084000000FF00000000000000000000000000000000000000
      000000000000000084000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000008400000000000000000000008400000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      8400000084008484840000000000000000000000000000000000000000000000
      FF00000084000000000000000000000000000000000000000000000000000000
      00000000000000000000000084000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000840000008400000000000000000000000000000000000000
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
      2800000040000000500000000100010000000000800200000000000000000000
      000000000000000000000000FFFFFF00FFFFFF7EFFFD0000FFFF9001FFF80000
      FFFFC003FFF10000FFFFE003FFE30000FCFFE003FFC70000FC3FE003E08F0000
      FC0FE003C01F000000030001803F000000008000001F00000003E007001F0000
      FC0FE00F001F0000FC3FE00F001F0000FCFFE027001F0000FFFFC073803F0000
      FFFF9E79C07F0000FFFF7EFEE0FF0000FFFFFFFF847FFFFFFFFFFFFF00EFFFFF
      FC0107C131BFFFFFFC0107C139FFFF3FFC0107C1993FFC3F00010101CA1FF03F
      00010001F40FC000000100019C070000000100019603C00000038003CB01F03F
      0007C107FF80FC3F000FC107F7C0FF3F00FFE38FFFE0FFFF01FFE38FEFF0FFFF
      03FFE38FFFF8FFFFFFFFFFFFFFFCFFFFFFFFFFFFFFFFF807FFFFFF7FC007F807
      FFFFFE7F8003F807FCFFFC0F0001F807F8FFFE770001F807F07FFF770001F807
      E27FFFF70000F803E63FFFF70000FFF3FF3FF7FF8000FFF1FF9FF7FFC000F9F1
      FFCFF77FE001F0F1FFCFF73FE007F0F1FFE7F81FF007F9FBFFF3FF3FF003EFF3
      FFFFFF7FF803FFF7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFFFFFFFBFF
      FFFFFCFFFFFFF1FDDFFFDF7FF8F9F1FBCFF7CF3FB879F8F3C7D5C71F9873FC67
      C3E3C30F8C23FE0FC181C38F8407FF1FC3E3C3C7820FFE0FC7D5C7C3860FFC6F
      CFF7CFE38807F0F3DFFFDFF19183E1F9FFFFFFF0BFC1E7FCFFFFFFF9FFF3FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFF3EFFFEFF7FFF7CFF3CFFFCFF3FFF3CFF38FFF8FF1FFF1CF
      F30FFF0FF0FFF0CFF20FFE0FF07FF04FF30FFF0FF0FFF0CFF38FFF8FF1FFF1CF
      F3CFFFCFF3FFF3CFF3EFFFEFF7FFF7CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object pmnDettaglio: TPopupMenu
    Left = 520
    Top = 48
    object mnuFiltraIdSessione: TMenuItem
      AutoCheck = True
      Caption = 'Filtra per ID Sessione'
      OnClick = mnuFiltraIdSessioneClick
    end
    object mnuFiltraIP: TMenuItem
      Caption = 'Filtra per IP client'
      OnClick = mnuFiltraIPClick
    end
  end
  object IdHTTP1: TIdHTTP
    AllowCookies = True
    HandleRedirects = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 640
    Top = 48
  end
end
