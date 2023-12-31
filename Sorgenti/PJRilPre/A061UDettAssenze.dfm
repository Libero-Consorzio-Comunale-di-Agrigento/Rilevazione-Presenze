object A061FDettAssenze: TA061FDettAssenze
  Left = 32
  Top = 156
  HelpContext = 61000
  Caption = '<A061> Elenco assenze individuali'
  ClientHeight = 562
  ClientWidth = 729
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
  object StatusBar: TStatusBar
    Left = 0
    Top = 543
    Width = 729
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 527
    Width = 729
    Height = 16
    Align = alBottom
    TabOrder = 4
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 729
    Height = 24
    Align = alTop
    TabOrder = 2
    TabStop = True
    ExplicitWidth = 729
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 729
      Height = 24
      ExplicitWidth = 729
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
  object pnl2: TPanel
    Left = 252
    Top = 24
    Width = 477
    Height = 503
    Align = alRight
    TabOrder = 1
    object BtnPrinterSetUp: TBitBtn
      Left = 14
      Top = 470
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
      TabOrder = 5
      OnClick = BtnPrinterSetUpClick
    end
    object BtnPreView: TBitBtn
      Left = 104
      Top = 470
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
      TabOrder = 6
      OnClick = BtnPreViewClick
    end
    object BtnClose: TBitBtn
      Left = 375
      Top = 470
      Width = 90
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 9
    end
    object BtnStampa: TBitBtn
      Left = 194
      Top = 470
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
      TabOrder = 7
      OnClick = BtnPreViewClick
    end
    object gpbRegStamp: TGroupBox
      Left = 16
      Top = 36
      Width = 445
      Height = 99
      Caption = 'Data di registrazione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object chkSalvaUltRegStamp: TCheckBox
        Left = 352
        Top = 37
        Width = 85
        Height = 16
        Alignment = taLeftJustify
        Caption = 'Memorizza'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object chkSoloAssRegSucc: TCheckBox
        Left = 7
        Top = 14
        Width = 293
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Solo assenze con registrazione nel periodo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = chkSoloAssRegSuccClick
      end
      object rgpAssenzeConsiderate: TRadioGroup
        Left = 7
        Top = 61
        Width = 430
        Height = 32
        Caption = 'Assenze da considerare'
        Columns = 3
        Items.Strings = (
          'Tutte'
          'Assenze inserite'
          'Assenze cancellate')
        TabOrder = 2
      end
      inline frmInputPeriodoRegStamp: TfrmInputPeriodo
        Left = 5
        Top = 32
        Width = 337
        Height = 27
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentBackground = False
        ParentColor = False
        ParentFont = False
        TabOrder = 3
        ExplicitLeft = 5
        ExplicitTop = 32
        ExplicitWidth = 337
        ExplicitHeight = 27
        inherited lblInizio: TLabel
          Left = 4
          Top = 6
          Font.Color = clGreen
          ExplicitLeft = 4
          ExplicitTop = 6
        end
        inherited lblFine: TLabel
          Left = 145
          Top = 6
          Font.Color = clGreen
          ExplicitLeft = 145
          ExplicitTop = 6
        end
        inherited edtInizio: TMaskEdit
          Left = 29
          Top = 3
          Font.Color = clBlack
          ParentFont = False
          ExplicitLeft = 29
          ExplicitTop = 3
        end
        inherited edtFine: TMaskEdit
          Top = 3
          Hint = 'Data fine periodo SECONDO'
          Font.Color = clBlack
          ParentFont = False
          ExplicitTop = 3
        end
        inherited btnIndietro: TBitBtn
          Left = 278
          Top = 3
          ExplicitLeft = 278
          ExplicitTop = 3
        end
        inherited btnAvanti: TBitBtn
          Left = 300
          Top = 3
          ExplicitLeft = 300
          ExplicitTop = 3
        end
        inherited btnDataInizio: TBitBtn
          Left = 100
          Top = 2
          ExplicitLeft = 100
          ExplicitTop = 2
        end
        inherited btnDataFine: TBitBtn
          Top = 2
          ExplicitTop = 2
        end
      end
    end
    object gpbTotali: TGroupBox
      Left = 16
      Top = 412
      Width = 445
      Height = 54
      Caption = 'Totali'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      object chkTotGenerali: TCheckBox
        Left = 245
        Top = 32
        Width = 192
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Generali'
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
      object chkTotIndividuali: TCheckBox
        Left = 7
        Top = 14
        Width = 192
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Individuali'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 0
        OnClick = chkDatiIndividualiClick
      end
      object chkTotRaggrup: TCheckBox
        Left = 245
        Top = 14
        Width = 192
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Per raggruppamento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object chkTotFam: TCheckBox
        Left = 7
        Top = 32
        Width = 192
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Distinti per familiare'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
    end
    object gpbConteggi: TGroupBox
      Left = 16
      Top = 317
      Width = 445
      Height = 94
      Caption = 'Parametri di calcolo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      object lblGGMinCont: TLabel
        Left = 246
        Top = 35
        Width = 118
        Height = 13
        Caption = 'Giorni minimi continuativi '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object chkRiduzioni: TCheckBox
        Left = 7
        Top = 34
        Width = 192
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Calcola riduzioni'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = chkDatiIndividualiClick
      end
      object edtGGMinCont: TEdit
        Left = 398
        Top = 32
        Width = 39
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnKeyPress = edtGGMinContKeyPress
      end
      object chkConiuge: TCheckBox
        Left = 7
        Top = 14
        Width = 192
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Conteggi con coniuge'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object chkCausaliCumulate: TCheckBox
        Left = 245
        Top = 54
        Width = 192
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Causali cumulate insieme'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object chkGiorniSignificativi: TCheckBox
        Left = 245
        Top = 14
        Width = 192
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Considera giorni di significativit'#224
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 4
        OnClick = chkDatiIndividualiClick
      end
      object chkSoloRiduzioni: TCheckBox
        Left = 7
        Top = 54
        Width = 192
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Stampa solo assenze ridotte'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object chkConteggiGG: TCheckBox
        Left = 7
        Top = 72
        Width = 192
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Conteggi giornalieri'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object chkPeriodoServizio: TCheckBox
        Left = 245
        Top = 72
        Width = 192
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Considera periodo servizio ass./cess.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
      end
    end
    object gpbDati: TGroupBox
      Left = 16
      Top = 137
      Width = 445
      Height = 174
      Caption = 'Parametri di stampa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      object Label3: TLabel
        Left = 245
        Top = 14
        Width = 192
        Height = 13
        Caption = 'Campo anagr. di raggruppamento:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object dcmbCampo: TDBLookupComboBox
        Left = 245
        Top = 30
        Width = 192
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        KeyField = 'NOME_CAMPO'
        ListField = 'NOME_LOGICO'
        ParentFont = False
        TabOrder = 7
        OnCloseUp = dcmbCampoCloseUp
        OnKeyDown = dcmbCampoKeyDown
        OnKeyUp = dcmbCampoKeyUp
      end
      object chkSaltoPagIndividuale: TCheckBox
        Left = 245
        Top = 71
        Width = 192
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Salto pagina individuale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
      end
      object chkSaltoPagRaggrup: TCheckBox
        Left = 245
        Top = 54
        Width = 192
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Salto pagina per raggruppamento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
      end
      object chkDettGiorn: TCheckBox
        Left = 7
        Top = 103
        Width = 192
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Dettaglio giornaliero'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnClick = chkDettGiornClick
      end
      object chkDatiIndividuali: TCheckBox
        Left = 7
        Top = 14
        Width = 192
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
        TabOrder = 0
        OnClick = chkDatiIndividualiClick
      end
      object chkDettPer: TCheckBox
        Left = 7
        Top = 120
        Width = 192
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
        TabOrder = 5
        OnClick = chkDettPerClick
      end
      object rgpValidate: TRadioGroup
        Left = 245
        Top = 98
        Width = 192
        Height = 52
        Caption = 'Validazione assenze'
        Columns = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Da validare'
          'Validate'
          'Tutte')
        ParentFont = False
        TabOrder = 10
      end
      object rgpOrdinamento: TRadioGroup
        Left = 7
        Top = 138
        Width = 192
        Height = 32
        Caption = 'Ordinamento'
        Columns = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Per data'
          'Per causale')
        ParentFont = False
        TabOrder = 6
      end
      object chkStampaNominativo: TCheckBox
        Left = 19
        Top = 50
        Width = 167
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Nominativo'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 1
        OnClick = chkStampaNominativoClick
      end
      object chkStampaMatricola: TCheckBox
        Left = 19
        Top = 67
        Width = 167
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Matricola'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 2
        OnClick = chkStampaMatricolaClick
      end
      object chkStampaBadge: TCheckBox
        Left = 19
        Top = 84
        Width = 167
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Badge'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 3
        OnClick = chkStampaBadgeClick
      end
      object chkStampaDatiAnagrafici: TCheckBox
        Left = 19
        Top = 32
        Width = 167
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Dati anagrafici della selezione'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 11
        OnClick = chkStampaDatiAnagraficiClick
      end
    end
    object btnTabella: TBitBtn
      Left = 284
      Top = 470
      Width = 90
      Height = 25
      Caption = 'Tabella'
      Glyph.Data = {
        42020000424D4202000000000000420000002800000010000000100000000100
        1000030000000002000000000000000000000000000000000000007C0000E003
        00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C0000000000000000000000000000000000000000000000000000
        0000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
        FF7FFF7F00000000FF7F00000000FF7F00000000FF7F00000000FF7F00000000
        0000FF7F00000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
        FF7FFF7F00000000FF7F00000000FF7F00000000FF7F00000000FF7F00000000
        0000FF7F00000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
        FF7FFF7F00000000FF7F00000000FF7F00000000FF7F00000000FF7F00000000
        0000FF7F00000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
        FF7FFF7F00000000FF7F00000000FF7F00000000FF7F00000000FF7F00000000
        0000FF7F00000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
        FF7FFF7F000000001F001F001F001F001F001F001F001F001F001F001F001F00
        1F001F0000000000F75EF75E1F001F001F001F001F001F001F001F001F001F00
        F75EF75E00000000000000000000000000000000000000000000000000000000
        0000000000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C}
      TabOrder = 8
      OnClick = BtnPreViewClick
    end
    inline frmInputPeriodo: TfrmInputPeriodo
      Left = 1
      Top = 1
      Width = 475
      Height = 36
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
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 475
      ExplicitHeight = 36
      inherited lblInizio: TLabel
        Left = 24
        ExplicitLeft = 24
      end
      inherited lblFine: TLabel
        Left = 165
        ExplicitLeft = 165
      end
      inherited edtInizio: TMaskEdit
        Left = 49
        ExplicitLeft = 49
      end
      inherited edtFine: TMaskEdit
        Left = 184
        Hint = 'Data fine periodo PRIMO'
        ExplicitLeft = 184
      end
      inherited btnIndietro: TBitBtn
        Left = 298
        ExplicitLeft = 298
      end
      inherited btnAvanti: TBitBtn
        Left = 320
        ExplicitLeft = 320
      end
      inherited btnDataInizio: TBitBtn
        Left = 120
        ExplicitLeft = 120
      end
      inherited btnDataFine: TBitBtn
        Left = 255
        ExplicitLeft = 255
      end
    end
  end
  object pnl1: TPanel
    Left = 0
    Top = 24
    Width = 252
    Height = 503
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object pnl13: TPanel
      Left = 0
      Top = 196
      Width = 252
      Height = 307
      Align = alClient
      TabOrder = 2
      object LstCausali: TCheckListBox
        Left = 1
        Top = 18
        Width = 250
        Height = 288
        OnClickCheck = LstCausaliClickCheck
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Pitch = fpFixed
        Font.Style = []
        ItemHeight = 14
        ParentFont = False
        PopupMenu = PopupMenu1
        ScrollWidth = 350
        TabOrder = 0
      end
      object pnl131: TPanel
        Left = 1
        Top = 1
        Width = 250
        Height = 17
        Align = alTop
        TabOrder = 1
        object lblCodCau: TLabel
          Left = 3
          Top = 1
          Width = 63
          Height = 13
          Caption = 'Codici causali'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object pnl12: TPanel
      Left = 0
      Top = 44
      Width = 252
      Height = 152
      Align = alTop
      TabOrder = 1
      object lstCodAcc: TCheckListBox
        Left = 1
        Top = 18
        Width = 250
        Height = 133
        OnClickCheck = lstCodAccClickCheck
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Pitch = fpFixed
        Font.Style = []
        ItemHeight = 14
        ParentFont = False
        PopupMenu = PopupMenu2
        ScrollWidth = 650
        TabOrder = 0
      end
      object pnl121: TPanel
        Left = 1
        Top = 1
        Width = 250
        Height = 17
        Align = alTop
        TabOrder = 1
        object lblCodAcc: TLabel
          Left = 3
          Top = 1
          Width = 99
          Height = 13
          Caption = 'Codici accorpamento'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object pnl11: TPanel
      Left = 0
      Top = 0
      Width = 252
      Height = 44
      Align = alTop
      TabOrder = 0
      object lblTipoAcc: TLabel
        Left = 5
        Top = 3
        Width = 92
        Height = 13
        Caption = 'Tipo accorpamento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object dlblTipoAcc: TDBText
        Left = 91
        Top = 23
        Width = 56
        Height = 13
        AutoSize = True
        DataField = 'DESCRIZIONE'
      end
      object dcmbTipoAcc: TDBLookupComboBox
        Left = 5
        Top = 18
        Width = 82
        Height = 21
        DropDownWidth = 350
        KeyField = 'cod_tipoaccorpcausali'
        ListField = 'cod_tipoaccorpcausali;descrizione'
        PopupMenu = PopupMenu3
        TabOrder = 0
        OnClick = dcmbTipoAccClick
        OnKeyDown = dcmbTipoAccKeyDown
      end
    end
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 628
    Top = 4
  end
  object PopupMenu1: TPopupMenu
    Left = 36
    Top = 312
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      OnClick = Selezionatutto1Click
    end
    object Annullatutto1: TMenuItem
      Caption = 'Annulla tutto'
      OnClick = Annullatutto1Click
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 44
    Top = 136
    object Selezionatutto2: TMenuItem
      Caption = 'Seleziona tutto'
      OnClick = Selezionatutto2Click
    end
    object Annullatutto2: TMenuItem
      Caption = 'Annulla tutto'
      OnClick = Annullatutto2Click
    end
  end
  object PopupMenu3: TPopupMenu
    Left = 168
    Top = 32
    object Accedi1: TMenuItem
      Caption = 'Accedi'
      OnClick = Accedi1Click
    end
  end
end
