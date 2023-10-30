object A058FGrigliaPianif: TA058FGrigliaPianif
  Left = 183
  Top = 144
  HelpContext = 58000
  ActiveControl = GVista
  Caption = '<A058> Visualizzazione turni pianificati'
  ClientHeight = 535
  ClientWidth = 971
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 464
    Width = 971
    Height = 71
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object btnTurno1: TSpeedButton
      Left = 563
      Top = 2
      Width = 25
      Height = 25
      Hint = 'Modifica rapida Turno1'
      AllowAllUp = True
      GroupIndex = 1
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000C40E0000C40E00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFF00000FFFFFFFFF008877700FFFFFF08870007770FFFF0880FBFBF07
        70FFF080F00000F070FF087F00B3300F770F080B0B3B330B070F0F0F0BBBB30F
        070F0F0B0FBB3B0B080F0F7F00FFB00F780FF080F00000F080FFF0F80FBFBF08
        80FFFF0F870007880FFFFFF00FFF8800FFFFFFFFF00000FFFFFF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnTurno1Click
    end
    object LblOPerazioni: TLabel
      Left = 2
      Top = 29
      Width = 3
      Height = 13
    end
    object btnAssenza1: TSpeedButton
      Left = 588
      Top = 2
      Width = 25
      Height = 25
      Hint = 'Modifica rapida Assenza'
      AllowAllUp = True
      GroupIndex = 1
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333FFFFF3333333333000003333333333F777773FF333333008877700
        33333337733FFF773F33330887000777033333733F777FFF73F330880F9F9F07
        703337F37733377FF7F33080F00000F07033373733777337F73F087F0091100F
        77037F3737333737FF7F08090919110907037F737F3333737F7F0F0F0999910F
        07037F737F3333737F7F0F090F99190908037F737FF33373737F0F7F00FF900F
        780373F737FFF737F3733080F00000F0803337F73377733737F330F80F9F9F08
        8033373F773337733733330F8700078803333373FF77733F733333300FFF8800
        3333333773FFFF77333333333000003333333333377777333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = btnTurno1Click
    end
    object btnOrario: TSpeedButton
      Left = 613
      Top = 2
      Width = 25
      Height = 25
      Hint = 'Modifica rapida Orario'
      AllowAllUp = True
      GroupIndex = 1
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000
        0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF000000000000BFBFBFBFBFBF7F7F7F7F7F7F7F7F7F000000000000FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000BFBFBFBFBFBF7F7F7F00000000
        00000000007F7F7F7F7F7F7F7F7F000000FFFFFFFFFFFFFFFFFFFFFFFF000000
        BFBFBFBFBFBF000000FFFFFF00FF00FFFFFF00FF00FFFFFF0000007F7F7F7F7F
        7F000000FFFFFFFFFFFFFFFFFF000000BFBFBF000000FFFFFF00000000000000
        0000000000000000FFFFFF0000007F7F7F000000FFFFFFFFFFFF000000BFBFBF
        7F7F7FFFFFFF00000000000000FF00007F00007F00000000000000FFFFFF7F7F
        7F7F7F7F000000FFFFFF000000BFBFBF00000000FF0000000000FF00007F0000
        FF00007F00007F0000000000FF000000007F7F7F000000FFFFFF000000FFFFFF
        000000FFFFFF00000000FF0000FF0000FF0000FF00007F00000000FFFFFF0000
        007F7F7F000000FFFFFF000000FFFFFF00000000FF00000000FFFFFF00FF0000
        FF00007F0000FF0000000000FF00000000BFBFBF000000FFFFFF000000FFFFFF
        7F7F7FFFFFFF000000000000FFFFFFFFFFFF00FF00000000000000FFFFFF7F7F
        7FBFBFBF000000FFFFFFFFFFFF000000BFBFBF000000FFFFFF00000000000000
        0000000000000000FFFFFF000000BFBFBF000000FFFFFFFFFFFFFFFFFF000000
        FFFFFFBFBFBF000000FFFFFF00FF00FFFFFF00FF00FFFFFF000000BFBFBFBFBF
        BF000000FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFBFBFBF7F7F7F00000000
        00000000007F7F7FBFBFBFBFBFBF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF000000000000FFFFFFFFFFFFFFFFFFBFBFBFBFBFBF000000000000FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000
        0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnTurno1Click
    end
    object btnAntincendio: TSpeedButton
      Left = 638
      Top = 2
      Width = 25
      Height = 25
      Hint = 'Modifica rapida Resp.antincendio'
      AllowAllUp = True
      GroupIndex = 1
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000
        0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF000000000000BFBFBFBFBFBF7F7F7F7F7F7F7F7F7F000000000000FFFF
        FF000000FFFFFFFFFFFFFFFFFFFFFFFF000000BFBFBFBFBFBF7F7F7F00000000
        00000000007F7F7F7F7F7F7F7F7F000000FFFFFFFFFFFFFFFFFFFFFFFF000000
        BFBFBFBFBFBF000000FFFFFF277FFFFFFFFF277FFFFFFFFF0000007F7F7F7F7F
        7F000000FFFFFFFFFFFFFFFFFF000000BFBFBF000000FFFFFF00000000000000
        0000000000000000FFFFFF0000007F7F7F000000FFFFFFFFFFFF000000BFBFBF
        7F7F7FFFFFFF000000000000277FFF00007F00007F000000000000FFFFFF7F7F
        7F7F7F7F000000FFFFFF000000BFBFBF000000277FFF000000277FFF00007F27
        7FFF00007F00007F000000277FFF0000007F7F7F000000FFFFFF000000FFFFFF
        000000FFFFFF000000277FFF277FFF277FFF277FFF00007F000000FFFFFF0000
        007F7F7F000000FFFFFF000000FFFFFF000000277FFF000000FFFFFF277FFF27
        7FFF00007F277FFF000000277FFF000000BFBFBF000000FFFFFF000000FFFFFF
        7F7F7FFFFFFF000000000000FFFFFFFFFFFF277FFF000000000000FFFFFF7F7F
        7FBFBFBF000000FFFFFFFFFFFF000000BFBFBF000000FFFFFF00000000000000
        0000000000000000FFFFFF000000BFBFBF000000FFFFFFFFFFFFFFFFFF000000
        FFFFFFBFBFBF000000FFFFFF277FFFFFFFFF277FFFFFFFFF000000BFBFBFBFBF
        BF000000FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFBFBFBF7F7F7F00000000
        00000000007F7F7FBFBFBFBFBFBF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF000000000000FFFFFFFFFFFFFFFFFFBFBFBFBFBFBF000000000000FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000
        0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnTurno1Click
    end
    object btnSblocca1: TSpeedButton
      Left = 79
      Top = 29
      Width = 75
      Height = 25
      Hint = 'Modifica rapida Orario'
      AllowAllUp = True
      GroupIndex = 1
      Caption = 'Sblocca'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000
        0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF000000000000BFBFBFBFBFBF7F7F7F7F7F7F7F7F7F000000000000FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000BFBFBFBFBFBF7F7F7F00000000
        00000000007F7F7F7F7F7F7F7F7F000000FFFFFFFFFFFFFFFFFFFFFFFF000000
        BFBFBFBFBFBF000000FFFFFF00FF00FFFFFF00FF00FFFFFF0000007F7F7F7F7F
        7F000000FFFFFFFFFFFFFFFFFF000000BFBFBF000000FFFFFF00000000000000
        0000000000000000FFFFFF0000007F7F7F000000FFFFFFFFFFFF000000BFBFBF
        7F7F7FFFFFFF00000000000000FF00007F00007F00000000000000FFFFFF7F7F
        7F7F7F7F000000FFFFFF000000BFBFBF00000000FF0000000000FF00007F0000
        FF00007F00007F0000000000FF000000007F7F7F000000FFFFFF000000FFFFFF
        000000FFFFFF00000000FF0000FF0000FF0000FF00007F00000000FFFFFF0000
        007F7F7F000000FFFFFF000000FFFFFF00000000FF00000000FFFFFF00FF0000
        FF00007F0000FF0000000000FF00000000BFBFBF000000FFFFFF000000FFFFFF
        7F7F7FFFFFFF000000000000FFFFFFFFFFFF00FF00000000000000FFFFFF7F7F
        7FBFBFBF000000FFFFFFFFFFFF000000BFBFBF000000FFFFFF00000000000000
        0000000000000000FFFFFF000000BFBFBF000000FFFFFFFFFFFFFFFFFF000000
        FFFFFFBFBFBF000000FFFFFF00FF00FFFFFF00FF00FFFFFF000000BFBFBFBFBF
        BF000000FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFBFBFBF7F7F7F00000000
        00000000007F7F7FBFBFBFBFBFBF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF000000000000FFFFFFFFFFFFFFFFFFBFBFBFBFBFBF000000000000FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000
        0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnBloccaSbloccaClick
    end
    object btnBlocca1: TSpeedButton
      Left = 2
      Top = 29
      Width = 75
      Height = 25
      Hint = 'Modifica rapida Assenza'
      AllowAllUp = True
      GroupIndex = 1
      Caption = 'Blocca'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333FFFFF3333333333000003333333333F777773FF333333008877700
        33333337733FFF773F33330887000777033333733F777FFF73F330880F9F9F07
        703337F37733377FF7F33080F00000F07033373733777337F73F087F0091100F
        77037F3737333737FF7F08090919110907037F737F3333737F7F0F0F0999910F
        07037F737F3333737F7F0F090F99190908037F737FF33373737F0F7F00FF900F
        780373F737FFF737F3733080F00000F0803337F73377733737F330F80F9F9F08
        8033373F773337733733330F8700078803333373FF77733F733333300FFF8800
        3333333773FFFF77333333333000003333333333377777333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = btnBloccaSbloccaClick
    end
    object lblBlocca: TLabel
      Left = 450
      Top = 33
      Width = 97
      Height = 13
      Caption = 'Cella BLOCCATA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object BRegistrazione: TBitBtn
      Left = 2
      Top = 2
      Width = 75
      Height = 25
      Caption = 'Registrazione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 0
      OnClick = BRegistrazioneClick
    end
    object BitBtn3: TBitBtn
      Left = 876
      Top = 2
      Width = 75
      Height = 25
      Caption = 'Chiudi'
      Kind = bkClose
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = False
      TabOrder = 4
    end
    object PGVista: TProgressBar
      Left = 0
      Top = 55
      Width = 971
      Height = 16
      Align = alBottom
      TabOrder = 5
    end
    object BCancellazione: TBitBtn
      Left = 79
      Top = 2
      Width = 75
      Height = 25
      Caption = 'Cancellazione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 1
      OnClick = BCancellazioneClick
    end
    object btnAnteprima: TBitBtn
      Left = 682
      Top = 2
      Width = 92
      Height = 25
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
      ParentShowHint = False
      ShowHint = False
      TabOrder = 3
      OnClick = btnAnteprimaClick
    end
    object btnAnomalie: TBitBtn
      Left = 323
      Top = 2
      Width = 115
      Height = 25
      Caption = 'Ricerca anomalie'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333FFFFF3333333333F797F3333333333F737373FF333333BFB999BFB
        33333337737773773F3333BFBF797FBFB33333733337333373F33BFBFBFBFBFB
        FB3337F33333F33337F33FBFBFB9BFBFBF3337333337F333373FFBFBFBF97BFB
        FBF37F333337FF33337FBFBFBFB99FBFBFB37F3333377FF3337FFBFBFBFB99FB
        FBF37F33333377FF337FBFBF77BF799FBFB37F333FF3377F337FFBFB99FB799B
        FBF373F377F3377F33733FBF997F799FBF3337F377FFF77337F33BFBF99999FB
        FB33373F37777733373333BFBF999FBFB3333373FF77733F7333333BFBFBFBFB
        3333333773FFFF77333333333FBFBF3333333333377777333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = False
      TabOrder = 2
      OnClick = btnAnomalieClick
    end
    object BOperativa: TBitBtn
      Left = 157
      Top = 2
      Width = 85
      Height = 25
      Caption = 'Rendi operativa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 6
      Visible = False
      OnClick = BOperativaClick
    end
    object chkElaborazioneAnnuale: TCheckBox
      Left = 323
      Top = 28
      Width = 97
      Height = 17
      Caption = 'Considera anno'
      TabOrder = 7
    end
    object btnFiltroAnomalie: TBitBtn
      Left = 450
      Top = 2
      Width = 98
      Height = 25
      Caption = 'Filtro anomalie'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000120B0000120B00001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF0660FFFFFFFFFFFF0660FF
        FFFFFFFFFF0F70FFFFFFFFFFFF0F70FFFFFFFFFFF077760FFFFFFFFF06777660
        FFFFFFF067F777660FFFFF067F77777660FFF067FFF77776660FF00000000000
        000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      TabOrder = 8
      OnClick = btnFiltroAnomalieClick
    end
  end
  object GVista: TStringGrid
    Left = 0
    Top = 27
    Width = 971
    Height = 437
    Align = alClient
    ColCount = 8
    DefaultColWidth = 100
    DefaultRowHeight = 45
    FixedCols = 6
    FixedRows = 2
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing]
    ParentFont = False
    ParentShowHint = False
    PopupMenu = PopupMenu1
    ShowHint = True
    TabOrder = 1
    OnClick = GVistaClick
    OnDblClick = GVistaDblClick
    OnDrawCell = GVistaDrawCell
    OnKeyDown = GVistaKeyDown
    OnKeyPress = GVistaKeyPress
    OnMouseDown = GVistaMouseDown
    OnSelectCell = GVistaSelectCell
    RowHeights = (
      45
      45
      45
      45
      45)
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 971
    Height = 27
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 921
      Height = 27
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object LblModificaRapida: TLabel
        Left = 2
        Top = 12
        Width = 81
        Height = 13
        Caption = 'Modifica rapida...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
    end
    object Panel4: TPanel
      Left = 921
      Top = 0
      Width = 50
      Height = 27
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      object btnLegenda: TButton
        Left = 0
        Top = 0
        Width = 50
        Height = 27
        Hint = 'Legenda'
        Align = alClient
        Caption = '?'
        TabOrder = 0
        OnClick = btnLegendaClick
      end
    end
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 643
    Top = 128
    object Modifica1: TMenuItem
      Caption = 'Modifica'
      OnClick = Modifica1Click
    end
    object Copiapianificazione1: TMenuItem
      Caption = 'Copia pianificazione'
      OnClick = Copiapianificazione1Click
    end
    object RicercaSostituti1: TMenuItem
      Caption = 'Ricerca sostituti'
      OnClick = Modifica1Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object CompetenzeResiduiassenza1: TMenuItem
      Caption = 'Visualizza competenze/residui assenza'
      OnClick = CompetenzeResiduiassenza1Click
    end
    object InsCancGiust1: TMenuItem
      Caption = 'Ins/Canc Giustificativi'
      OnClick = InsCancGiust1Click
    end
    object VisualizzaAssenze1: TMenuItem
      Caption = 'Visualizza assenze da validare nel periodo'
      OnClick = VisualizzaAssenze1Click
    end
    object ValidaCausale1: TMenuItem
      Caption = 'Valida Causale'
      OnClick = ValidaCausale1Click
    end
    object Reperibilit1: TMenuItem
      Caption = 'Pianificazione Reperibilit'#224
      OnClick = Reperibilit1Click
    end
    object CopiainExcel1: TMenuItem
      Caption = 'Copia in Excel'
      OnClick = CopiainExcel1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Visualizzacopertura1: TMenuItem
      Caption = 'Visualizza riga copertura turni squadra'
      OnClick = Visualizzacopertura1Click
    end
    object Visualizzacolonnamatricola1: TMenuItem
      AutoCheck = True
      Caption = 'Visualizza colonna matricola'
      OnClick = Visualizzacolonnamatricola1Click
    end
    object Visualizzadebito1: TMenuItem
      Caption = 'Visualizza colonna saldi ore (debito/pianif./residuo)'
      OnClick = Visualizzadebito1Click
    end
    object Visualizzaturni: TMenuItem
      Caption = 'Visualizza colonna totale turni per dipendente'
      OnClick = VisualizzaturniClick
    end
    object Visualizzaassenze: TMenuItem
      Caption = 'Visualizza colonna situazione assenze'
      Visible = False
      OnClick = VisualizzaassenzeClick
    end
    object VisualizzaRiposiFestivi: TMenuItem
      Caption = 'Visualizza colonna riposi/fest.lav. al mese precedente'
      OnClick = VisualizzaRiposiFestiviClick
    end
    object Visualizzazionesintetica1: TMenuItem
      Caption = 'Visualizza tabellone sintetico'
      OnClick = Visualizzazionesintetica1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Visualizzaprogressividiturnazione1: TMenuItem
      Caption = 'Visualizza progressivi di turnazione'
      OnClick = Visualizzaprogressividiturnazione1Click
    end
    object Visualizzadettaglioorariogiornaliero1: TMenuItem
      Caption = 'Visualizza dettaglio orario giornaliero'
      OnClick = Visualizzadettaglioorariogiornaliero1Click
    end
    object VisualizzaLimitiMinMax1: TMenuItem
      Caption = 'Visualizza limiti minimi e massimi'
      OnClick = VisualizzaLimitiMinMax1Click
    end
    object VisualizzaCoperturaSquadre1: TMenuItem
      Caption = 'Visualizza copertura squadra'
      OnClick = VisualizzaCoperturaSquadre1Click
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object Visualizzaassenzemezzagiorn1: TMenuItem
      Caption = 'Visualizza assenze di mezza giornata'
      OnClick = Visualizzaassenzemezzagiorn1Click
    end
    object Visualizzaassenzeadore1: TMenuItem
      Caption = 'Visualizza assenze ad ore'
      OnClick = Visualizzaassenzeadore1Click
    end
  end
  object popmnuModificaRapida: TPopupMenu
    Left = 504
    Top = 408
    object mnuFastPrimoturno: TMenuItem
      Caption = 'Primo turno'
      OnClick = mnuModificaRapidaClick
    end
    object mnuFastPrimaassenza: TMenuItem
      Caption = 'Prima assenza'
      OnClick = mnuModificaRapidaClick
    end
    object mnuFastOrario: TMenuItem
      Caption = 'Orario'
      OnClick = mnuModificaRapidaClick
    end
  end
end
