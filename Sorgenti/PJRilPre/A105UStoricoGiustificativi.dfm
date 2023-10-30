object A105FStoricoGiustificativi: TA105FStoricoGiustificativi
  Left = 182
  Top = 149
  HelpContext = 105000
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '<A105> Storico giustificativi'
  ClientHeight = 493
  ClientWidth = 632
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pgcMain: TPageControl
    Left = 0
    Top = 24
    Width = 310
    Height = 434
    ActivePage = tshStampa
    Align = alLeft
    TabOrder = 0
    object tshStampa: TTabSheet
      Caption = 'Stampa'
      object Label3: TLabel
        Left = 6
        Top = 45
        Width = 180
        Height = 13
        Caption = 'Campo anagrafico di raggruppamento:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblStatoElab: TLabel
        Left = 6
        Top = 88
        Width = 141
        Height = 13
        Caption = 'Stato elaborazione su cedolini'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object dcmbCampo: TDBLookupComboBox
        Left = 6
        Top = 61
        Width = 270
        Height = 21
        KeyField = 'NOME_CAMPO'
        ListField = 'NOME_LOGICO'
        TabOrder = 1
        OnCloseUp = dcmbCampoExit
        OnExit = dcmbCampoExit
        OnKeyDown = dcmbCampoKeyDown
      end
      object chkTotaliIndividuali: TCheckBox
        Left = 6
        Top = 286
        Width = 269
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Totali individuali'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 11
      end
      object chkTotaliRaggr: TCheckBox
        Left = 6
        Top = 308
        Width = 269
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Totali per raggruppamento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 12
      end
      object chkTotaliGenerali: TCheckBox
        Left = 6
        Top = 330
        Width = 269
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Totali generali'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 13
      end
      object chkSaltoPaginaIndividuale: TCheckBox
        Left = 6
        Top = 242
        Width = 269
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Salto pagina individuale'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 9
      end
      object chkSaltoPaginaRaggr: TCheckBox
        Left = 6
        Top = 264
        Width = 269
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Salto pagina per raggruppamento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
      end
      object chkDettaglioGiornaliero: TCheckBox
        Left = 6
        Top = 176
        Width = 269
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Dettaglio giornaliero'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 6
        OnClick = chkDettaglioGiornalieroClick
      end
      object chkDatiIndividuali: TCheckBox
        Left = 6
        Top = 220
        Width = 269
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Stampa dati individuali'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 8
        OnClick = chkDatiIndividualiClick
      end
      object chkDettaglioPeriodico: TCheckBox
        Left = 6
        Top = 198
        Width = 269
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Dettaglio periodico'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 7
        OnClick = chkDettaglioPeriodicoClick
      end
      object chkAssenzeInserite: TCheckBox
        Left = 6
        Top = 132
        Width = 269
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Assenze inserite'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object chkAssenzeCancellate: TCheckBox
        Left = 6
        Top = 154
        Width = 269
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Assenze cancellate'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 5
      end
      object chkRecordFisici: TCheckBox
        Left = 6
        Top = 110
        Width = 269
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Tutte le operazioni registrate'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 3
      end
      object sbtStatoElab: TButton
        Left = 252
        Top = 85
        Width = 23
        Height = 22
        Caption = '...'
        TabOrder = 2
        OnClick = sbtStatoElabClick
      end
      object pnlBottoni: TPanel
        Left = 0
        Top = 374
        Width = 302
        Height = 32
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 14
        object BtnPrinterSetUp: TBitBtn
          Left = 207
          Top = 4
          Width = 90
          Height = 25
          Caption = 'S&tampante'
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FF0000000000
            0FFFF0777777777070FF000000000000070F0778777BBB87000F077887788887
            070F00000000000007700778888778807070F000000000070700FF0777777770
            7070FFF077777776EEE0F8000000000E6008F0E6EEEEEEEE0FFFF8000000000E
            6008FFFF07777786EEE0FFFFF00000080008FFFFFFFFFFFFFFFF}
          TabOrder = 2
          OnClick = BtnPrinterSetUpClick
        end
        object BtnPreView: TBitBtn
          Left = 5
          Top = 4
          Width = 90
          Height = 25
          Caption = 'Anteprima'
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
            FFFF000000000000FF000FFFFFFFFFF0F0000FFFFFFF0000800F0FFFFFF08778
            08FF0FFFFF0877E880FF0FFFFF07777870FF0FFFFF07E77870FF0FFFFF08EE78
            80FF0FFFFFF087780FFF0FFFFFFF0000FFFF0FFFFFFFFFF0FFFF0FFFFFFF0000
            FFFF0FFFFFFF070FFFFF0FFFFFFF00FFFFFF000000000FFFFFFF}
          TabOrder = 0
          OnClick = BtnPreViewClick
        end
        object BtnStampa: TBitBtn
          Left = 106
          Top = 4
          Width = 90
          Height = 25
          Caption = '&Stampa'
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000130B0000130B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
            00033FFFFFFFFFFFFFFF0888888888888880777777777777777F088888888888
            8880777777777777777F0000000000000000FFFFFFFFFFFFFFFF0F8F8F8F8F8F
            8F80777777777777777F08F8F8F8F8F8F9F0777777777777777F0F8F8F8F8F8F
            8F807777777777777F7F0000000000000000777777777777777F3330FFFFFFFF
            03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
            03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
            33333337F3FF7F3733333330F08F0F0333333337F7737F7333333330FFFF0033
            33333337FFFF7733333333300000033333333337777773333333}
          NumGlyphs = 2
          TabOrder = 1
          OnClick = BtnPreViewClick
        end
      end
      inline frmInputPeriodoS: TfrmInputPeriodo
        Left = 0
        Top = 0
        Width = 302
        Height = 40
        Align = alTop
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentBackground = False
        ParentColor = False
        ParentFont = False
        TabOrder = 0
        ExplicitWidth = 302
        inherited lblInizio: TLabel
          Left = 6
          ExplicitLeft = 6
        end
        inherited lblFine: TLabel
          Left = 136
          ExplicitLeft = 136
        end
        inherited edtInizio: TMaskEdit
          Left = 27
          ExplicitLeft = 27
        end
        inherited edtFine: TMaskEdit
          Left = 151
          ExplicitLeft = 151
        end
        inherited btnIndietro: TBitBtn
          Left = 252
          ExplicitLeft = 252
        end
        inherited btnAvanti: TBitBtn
          Left = 274
          ExplicitLeft = 274
        end
        inherited btnDataInizio: TBitBtn
          Left = 98
          ExplicitLeft = 98
        end
        inherited btnDataFine: TBitBtn
          Left = 222
          ExplicitLeft = 222
        end
      end
    end
    object tshAllinea: TTabSheet
      Caption = 'Allineamento'
      ImageIndex = 1
      object lblDataRegistrazione: TLabel
        Left = 6
        Top = 105
        Width = 139
        Height = 13
        Caption = 'Data registrazione movimento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object sbtDataRegistrazione: TSpeedButton
        Left = 252
        Top = 102
        Width = 23
        Height = 22
        Caption = '...'
        NumGlyphs = 2
        OnClick = sbtDataRegistrazioneClick
      end
      object lblDefinizionePeriodo: TLabel
        Left = 0
        Top = 0
        Width = 302
        Height = 13
        Align = alTop
        Caption = 'Periodo assenze da considerare'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 151
      end
      object chkRegistrazioneInserimenti: TCheckBox
        Left = 6
        Top = 127
        Width = 269
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Registrazione inserimenti mancanti'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object chkRegistrazioneCancellazioni: TCheckBox
        Left = 6
        Top = 149
        Width = 269
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Registrazione cancellazioni mancanti'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 2
      end
      object chkEliminazioneAssenze: TCheckBox
        Left = 6
        Top = 171
        Width = 269
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Eliminazione movimenti non pi'#249' da storicizzare'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object edtDataRegistrazione: TMaskEdit
        Left = 181
        Top = 103
        Width = 71
        Height = 21
        EditMask = '!00/00/0000;1;_'
        MaxLength = 10
        TabOrder = 4
        Text = '  /  /    '
      end
      object chkDefinizioneDataRegistrazione: TCheckBox
        Left = 6
        Top = 61
        Width = 269
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Data registrazione uguale a data assenza'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnClick = chkDefinizioneDataRegistrazioneClick
      end
      object chkImpostaAssElab: TCheckBox
        Left = 6
        Top = 83
        Width = 269
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Imposta assenza gi'#224' elaborata su cedolino'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object pnlFunzioni: TPanel
        Left = 0
        Top = 374
        Width = 302
        Height = 32
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 7
        object btnEsegui: TBitBtn
          Left = 5
          Top = 4
          Width = 90
          Height = 25
          Caption = '&Esegui'
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777808
            87770777777700300077B0777770B33330078B077770BB88308878B0770BB0F8
            330078BB0770B0003088888BB070BB3BB007BBBBBB0700B000778BBB00887700
            777778BBB07777777777778BBB07777777778888BBB07777777778BBBBBB0777
            7777778BBB00007777777778BBB07777777777778BBB07777777}
          TabOrder = 0
          OnClick = btnEseguiClick
        end
      end
      inline frmInputPeriodoA: TfrmInputPeriodo
        Left = 0
        Top = 13
        Width = 302
        Height = 40
        Align = alTop
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentBackground = False
        ParentColor = False
        ParentFont = False
        TabOrder = 0
        ExplicitTop = 13
        ExplicitWidth = 302
        inherited lblInizio: TLabel
          Left = 6
          ExplicitLeft = 6
        end
        inherited lblFine: TLabel
          Left = 136
          ExplicitLeft = 136
        end
        inherited edtInizio: TMaskEdit
          Left = 27
          ExplicitLeft = 27
        end
        inherited edtFine: TMaskEdit
          Left = 151
          ExplicitLeft = 151
        end
        inherited btnIndietro: TBitBtn
          Left = 251
          ExplicitLeft = 251
        end
        inherited btnAvanti: TBitBtn
          Left = 276
          ExplicitLeft = 276
        end
        inherited btnDataInizio: TBitBtn
          Left = 98
          ExplicitLeft = 98
        end
        inherited btnDataFine: TBitBtn
          Left = 222
          ExplicitLeft = 222
        end
      end
    end
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 477
    Width = 632
    Height = 16
    Align = alBottom
    TabOrder = 1
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 632
    Height = 24
    Align = alTop
    TabOrder = 2
    TabStop = True
    ExplicitWidth = 632
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 632
      Height = 24
      ExplicitWidth = 632
      ExplicitHeight = 24
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 458
    Width = 632
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object pnlCausali: TPanel
    Left = 310
    Top = 24
    Width = 322
    Height = 434
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 4
    object pnlCausaliRichieste: TPanel
      Left = 0
      Top = 0
      Width = 322
      Height = 22
      Align = alTop
      TabOrder = 0
      object Label1: TLabel
        Left = 9
        Top = 5
        Width = 84
        Height = 13
        Caption = 'Causali elaborate:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
    end
    object clbCausali: TCheckListBox
      Left = 0
      Top = 22
      Width = 322
      Height = 412
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Pitch = fpFixed
      Font.Style = []
      ItemHeight = 14
      ParentFont = False
      PopupMenu = pmnCausali
      TabOrder = 1
    end
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 364
  end
  object pmnCausali: TPopupMenu
    Left = 404
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      OnClick = Selezionatutto1Click
    end
    object Annullatutto1: TMenuItem
      Caption = 'Annulla tutto'
      OnClick = Annullatutto1Click
    end
  end
end
