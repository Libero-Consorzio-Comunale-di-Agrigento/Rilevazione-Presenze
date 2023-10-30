inherited A016FCausAssenzeStorico: TA016FCausAssenzeStorico
  HelpContext = 16800
  BorderStyle = bsSingle
  Caption = '<A016> Causali di assenza - Parametri storicizzati'
  ClientHeight = 570
  ClientWidth = 593
  ExplicitWidth = 599
  ExplicitHeight = 619
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 552
    Width = 593
    ExplicitTop = 552
    ExplicitWidth = 593
  end
  inherited grbDecorrenza: TGroupBox
    Width = 593
    ExplicitWidth = 593
  end
  inherited ToolBar1: TToolBar
    Width = 593
    TabOrder = 0
    ExplicitWidth = 593
    inherited ToolButton2: TToolButton
      Visible = False
    end
    inherited ToolButton6: TToolButton
      Visible = False
    end
  end
  object PageControl1: TPageControl [3]
    Left = 0
    Top = 122
    Width = 593
    Height = 430
    ActivePage = tabCartellino
    Align = alClient
    TabOrder = 3
    object tabCartellino: TTabSheet
      Caption = 'Cartellino'
      object lblValorGiorOre: TLabel
        Left = 8
        Top = 152
        Width = 140
        Height = 13
        Caption = 'Ore valorizzazione giornaliera:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblValorGiorOreComp: TLabel
        Left = 6
        Top = 343
        Width = 140
        Height = 13
        Caption = 'Ore valorizzazione giornaliera:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblHMAssenza: TLabel
        Left = 234
        Top = 4
        Width = 140
        Height = 13
        Caption = 'HH:MM per giorno di assenza'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object drgpValorGior: TDBRadioGroup
        Left = 8
        Top = 4
        Width = 211
        Height = 143
        Caption = 'Valorizzazione giornaliera'
        DataField = 'VALORGIOR'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Monte ore sett./gg. lav.'
          'Ore teoriche dell'#39'orario'
          'Monte ore sett./6'
          'Ore teoriche da anagrafico'
          'Ore del debito giornaliero'
          'Ore fisse')
        ParentFont = False
        TabOrder = 0
        Values.Strings = (
          'A'
          'B'
          'C'
          'D'
          'E'
          'F')
        OnChange = drgpValorGiorChange
      end
      object dedtValorGiorOre: TDBEdit
        Left = 176
        Top = 149
        Width = 43
        Height = 21
        DataField = 'VALORGIOR_ORE'
        DataSource = DButton
        TabOrder = 1
        OnChange = OnDBEditOraChange
      end
      object drgpValorGiorComp: TDBRadioGroup
        Left = 4
        Top = 171
        Width = 215
        Height = 167
        Caption = 'Valorizz. giorn. per competenze'
        DataField = 'VALORGIOR_COMP'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Come Valorizzazione giornaliera'
          'Monte ore sett./gg. lav.'
          'Ore teoriche dell'#39'orario'
          'Monte ore sett./6'
          'Ore teoriche da anagrafico'
          'Ore del debito giornaliero'
          'Ore fisse')
        ParentFont = False
        TabOrder = 2
        Values.Strings = (
          '-'
          'A'
          'B'
          'C'
          'D'
          'E'
          'F')
        OnChange = drgpValorGiorCompChange
      end
      object dedtValorGiorOreComp: TDBEdit
        Left = 176
        Top = 340
        Width = 43
        Height = 21
        DataField = 'VALORGIOR_ORECOMP'
        DataSource = DButton
        TabOrder = 3
        OnChange = OnDBEditOraChange
      end
      object dchkValorGiorOrePropPT: TDBCheckBox
        Left = 6
        Top = 362
        Width = 213
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Proporziona se part-time'
        DataField = 'VALORGIOR_ORE_PROPPT'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dedtHMAssenza: TDBEdit
        Left = 457
        Top = 4
        Width = 43
        Height = 21
        DataField = 'HMASSENZA'
        DataSource = DButton
        TabOrder = 6
        OnChange = OnDBEditOraChange
      end
      object dchkHMAssenzaPropPT: TDBCheckBox
        Left = 232
        Top = 27
        Width = 268
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Proporziona se part-time'
        DataField = 'HMASSENZA_PROPPT'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object grpFruizAbilSP: TGroupBox
        Left = 234
        Top = 117
        Width = 266
        Height = 40
        Caption = 'Fruizioni abilitate allo scarico paghe'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        object dchkFruizAbilSPGiorni: TDBCheckBox
          Left = 8
          Top = 16
          Width = 65
          Height = 17
          Caption = 'Giorni'
          DataField = 'SCARICOPAGHE_FRUIZ_GG'
          DataSource = DButton
          TabOrder = 0
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dchkFruizAbilSPOre: TDBCheckBox
          Left = 70
          Top = 16
          Width = 42
          Height = 17
          Caption = 'Ore'
          DataField = 'SCARICOPAGHE_FRUIZ_ORE'
          DataSource = DButton
          TabOrder = 1
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
      end
      object grpPausaMensa: TGroupBox
        Left = 234
        Top = 45
        Width = 266
        Height = 71
        Caption = 'Pausa mensa'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
        object dchkTimbPM: TDBCheckBox
          Left = 7
          Top = 16
          Width = 251
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Considera i giustificativi dalle..alle'
          DataField = 'TIMB_PM'
          DataSource = DButton
          ParentShowHint = False
          ShowHint = False
          TabOrder = 0
          ValueChecked = 'S'
          ValueUnchecked = 'N'
          OnClick = dchkTimbPMClick
        end
        object dchkTimbPMDetraz: TDBCheckBox
          Left = 7
          Top = 48
          Width = 251
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Ore rese conteggiate al netto della pausa mensa'
          DataField = 'TIMB_PM_DETRAZ'
          DataSource = DButton
          ParentShowHint = False
          ShowHint = False
          TabOrder = 2
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dchkTimbPMH: TDBCheckBox
          Left = 7
          Top = 32
          Width = 251
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Considera i giustificativi in numero ore'
          DataField = 'TIMB_PM_H'
          DataSource = DButton
          ParentShowHint = False
          ShowHint = False
          TabOrder = 1
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
      end
      object dchkPesoGiorDaOrario: TDBCheckBox
        Left = 6
        Top = 380
        Width = 213
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Peso giornata assenza da modello orario'
        DataField = 'PESOGIOR_DAORARIO'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dchkGiustDaARecupFlex: TDBCheckBox
        Left = 232
        Top = 159
        Width = 268
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Il giustificativo dalle..alle '#232' recuperabile in uscita'
        DataField = 'GIUST_DAA_RECUP_FLEX'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dchkAbbatteStrInd: TDBCheckBox
        Left = 232
        Top = 191
        Width = 268
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Abbatte la maturazione di straordinario e indennit'#224
        DataField = 'ABBATTE_STRIND'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 12
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object drgpConteggioTimbInterna: TDBRadioGroup
        Left = 234
        Top = 326
        Width = 266
        Height = 66
        Caption = 'Tipo conteggio dalle..alle se timbratura interna'
        DataField = 'CONTEGGIO_TIMB_INTERNA'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Termina prima della timbratura'
          'Scelta intervallo maggiore'
          'Compensazione')
        ParentFont = False
        TabOrder = 17
        Values.Strings = (
          'P'
          'S'
          'C')
      end
      object drgpIntersezioneTimbrature: TDBRadioGroup
        Left = 234
        Top = 260
        Width = 266
        Height = 66
        Caption = 'Sovrapposizione su timbrature'
        DataField = 'INTERSEZIONE_TIMBRATURE'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Conteggia entrambi'
          'Conteggia timbrature'
          'Conteggia giustificativi')
        ParentFont = False
        TabOrder = 16
        Values.Strings = (
          'E'
          'T'
          'G')
        OnChange = drgpIntersezioneTimbratureChange
      end
      object dchkSceltaOrario: TDBCheckBox
        Left = 234
        Top = 175
        Width = 266
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Considera il giustif. dalle..alle nella scelta dell'#39'orario'
        DataField = 'SCELTA_ORARIO'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 11
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dchkIndPresenza: TDBCheckBox
        Left = 234
        Top = 207
        Width = 266
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Matura indennit'#224' di presenza'
        DataField = 'INDPRES'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 13
        ValueChecked = 'S'
        ValueUnchecked = 'N'
        OnClick = dchkIndPresenzaClick
      end
      object dchkIndTurno: TDBCheckBox
        Left = 234
        Top = 239
        Width = 266
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Matura indennit'#224' di turno'
        DataField = 'INDTURNO'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 15
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dchkIndPresenzaSuFestivo: TDBCheckBox
        Left = 234
        Top = 223
        Width = 266
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Matura indennit'#224' di presenza su gg festivo'
        DataField = 'INDPRES_FESTIVO'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 14
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
    end
    object tabRegoleInserimento: TTabSheet
      Caption = 'Regole inserimento'
      ImageIndex = 1
      object lblCausaliCompatibili: TLabel
        Left = 3
        Top = 95
        Width = 86
        Height = 13
        Caption = 'Causali compatibili'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblCausaliCheckComp: TLabel
        Left = 3
        Top = 190
        Width = 154
        Height = 13
        Caption = 'Controllo aggiuntivo competenze'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblVisualComp: TLabel
        Left = 3
        Top = 233
        Width = 129
        Height = 13
        Caption = 'Visualizza le competenze di'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblCausaleFruizOre: TLabel
        Left = 3
        Top = 35
        Width = 174
        Height = 13
        Caption = 'Causale da inserire se fruizione oraria'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblCausaleHMAssenza: TLabel
        Left = 3
        Top = 3
        Width = 177
        Height = 26
        AutoSize = False
        Caption = 'Causale cumulativa giornaliera delle fruizioni orarie'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object dedtCausaliCompatibili: TDBEdit
        Left = 3
        Top = 110
        Width = 281
        Height = 21
        Color = clBtnFace
        DataField = 'CAUSALI_COMPATIBILI'
        DataSource = DButton
        ReadOnly = True
        TabOrder = 4
      end
      object btnCausaliCompatibili: TButton
        Left = 286
        Top = 110
        Width = 17
        Height = 21
        Caption = '...'
        TabOrder = 5
        OnClick = SelezioneCausali
      end
      object drgpStatoCompatibilta: TDBRadioGroup
        Left = 3
        Top = 133
        Width = 303
        Height = 51
        Caption = 'Stato compatibilit'#224
        Columns = 3
        DataField = 'STATO_COMPATIBILITA'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Disattivato'
          'Compatibile'
          'Incompatibile')
        ParentFont = False
        TabOrder = 6
        Values.Strings = (
          'D'
          'C'
          'I')
      end
      object dedtCausaliCheckComp: TDBEdit
        Left = 3
        Top = 205
        Width = 281
        Height = 21
        Color = clBtnFace
        DataField = 'CAUSALI_CHECKCOMPETENZE'
        DataSource = DButton
        ReadOnly = True
        TabOrder = 7
      end
      object btnCausaliCheckComp: TButton
        Left = 286
        Top = 205
        Width = 17
        Height = 21
        Caption = '...'
        TabOrder = 8
        OnClick = SelezioneCausali
      end
      object dcmbVisualCompetenze: TDBComboBox
        Left = 186
        Top = 230
        Width = 117
        Height = 21
        Style = csDropDownList
        DataField = 'CAUSALE_VISUALCOMPETENZE'
        DataSource = DButton
        TabOrder = 9
      end
      object dcmbCausaleFruizOre: TDBLookupComboBox
        Left = 189
        Top = 31
        Width = 117
        Height = 21
        DataField = 'CAUSALE_FRUIZORE'
        DataSource = DButton
        TabOrder = 1
      end
      object dcmbCausaleHMAssenza: TDBLookupComboBox
        Left = 189
        Top = 4
        Width = 117
        Height = 21
        DataField = 'CAUSALE_HMASSENZA'
        DataSource = DButton
        TabOrder = 0
      end
      object dchkCheckSoloCompetenze: TDBCheckBox
        Left = 1
        Top = 56
        Width = 303
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Esclusione dei controlli utente'
        DataField = 'CHECK_SOLOCOMPETENZE'
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
      object GroupBox1: TGroupBox
        Left = 3
        Top = 257
        Width = 303
        Height = 117
        Caption = 'Inserimento impedito se esiste residuo per le causali'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
        object lblCausCheckNoCompI: TLabel
          Left = 7
          Top = 21
          Width = 121
          Height = 13
          Caption = 'Fruizione a giornata intera'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblCausCheckNoCompM: TLabel
          Left = 7
          Top = 45
          Width = 125
          Height = 13
          Caption = 'Fruizione a mezza giornata'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblCausCheckNoCompN: TLabel
          Left = 8
          Top = 69
          Width = 107
          Height = 13
          Caption = 'Fruizione a numero ore'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblCausCheckNoCompD: TLabel
          Left = 8
          Top = 92
          Width = 89
          Height = 13
          Caption = 'Fruizione dalle..alle'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object dedtCausCheckNoCompI: TDBEdit
          Left = 137
          Top = 18
          Width = 141
          Height = 21
          Color = clBtnFace
          DataField = 'CAUS_CHECKNOCOMP_I'
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
        object btnCausCheckNoCompI: TButton
          Left = 279
          Top = 18
          Width = 17
          Height = 21
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = SelezioneCausali
        end
        object dedtCausCheckNoCompM: TDBEdit
          Left = 137
          Top = 42
          Width = 141
          Height = 21
          Color = clBtnFace
          DataField = 'CAUS_CHECKNOCOMP_M'
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
        object btnCausCheckNoCompM: TButton
          Left = 279
          Top = 42
          Width = 17
          Height = 21
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnClick = SelezioneCausali
        end
        object dedtCausCheckNoCompN: TDBEdit
          Left = 137
          Top = 66
          Width = 141
          Height = 21
          Color = clBtnFace
          DataField = 'CAUS_CHECKNOCOMP_N'
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
        object btnCausCheckNoCompN: TButton
          Left = 279
          Top = 66
          Width = 17
          Height = 21
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          OnClick = SelezioneCausali
        end
        object dedtCausCheckNoCompD: TDBEdit
          Left = 137
          Top = 89
          Width = 141
          Height = 21
          Color = clBtnFace
          DataField = 'CAUS_CHECKNOCOMP_D'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 6
        end
        object btnCausCheckNoCompD: TButton
          Left = 279
          Top = 89
          Width = 17
          Height = 21
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
          OnClick = SelezioneCausali
        end
      end
      object dchkFruizInternaPN: TDBCheckBox
        Left = 1
        Top = 75
        Width = 303
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Fruizione dalle..alle limitata entro i punti nominali'
        DataField = 'FRUIZ_INTERNA_PN'
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
      object drgpCondizioneAllegati: TDBRadioGroup
        Left = 323
        Top = 3
        Width = 231
        Height = 66
        Caption = 'Condizione allegati'
        Columns = 2
        DataField = 'CONDIZIONE_ALLEGATI'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Da Iter'
          'No'
          'Obbligatori'
          'Facoltativi')
        ParentFont = False
        TabOrder = 11
        Values.Strings = (
          'I'
          'N'
          'O'
          'F')
      end
      object grpGEDAP: TGroupBox
        Left = 323
        Top = 84
        Width = 231
        Height = 167
        Caption = 'Interfaccia GEDAP - Cariche elettive'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 12
        object lblCausale: TLabel
          Left = 9
          Top = 29
          Width = 38
          Height = 13
          Caption = 'Causale'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object dCmbCausaleGEDAP: TDBComboBox
          Left = 53
          Top = 26
          Width = 170
          Height = 22
          Style = csOwnerDrawFixed
          DataField = 'GEDAP_CAUSALE'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnDrawItem = dCmbCausaleGEDAPDrawItem
        end
        object dGrpTipoGEDAP: TDBRadioGroup
          Left = 8
          Top = 54
          Width = 215
          Height = 105
          Caption = 'Tipo'
          DataField = 'GEDAP_TIPO'
          DataSource = DButton
          Items.Strings = (
            'Nullo'
            'Aspettativa'
            'Permesso')
          TabOrder = 1
          Values.Strings = (
            'N'
            'A'
            'P')
        end
      end
    end
    object tabRegoleCumuloFruizione: TTabSheet
      Caption = 'Regole cumulo/fruizione'
      ImageIndex = 2
      object lblCMCausPresIncluse: TLabel
        Left = 6
        Top = 7
        Width = 204
        Height = 13
        Caption = 'Causali che maturano competenze (tipo M):'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object dedtCMCausPresIncluse: TDBEdit
        Left = 212
        Top = 4
        Width = 301
        Height = 21
        Color = cl3DLight
        DataField = 'CM_CAUSPRES_INCLUSE'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
      object btnCMCausPresIncluse: TButton
        Left = 514
        Top = 4
        Width = 16
        Height = 21
        Caption = '...'
        TabOrder = 1
        OnClick = btnCMCausPresIncluseClick
      end
      object dchkCompetenzePersonalizzate: TDBCheckBox
        Left = 4
        Top = 31
        Width = 225
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Competenze personalizzate'
        DataField = 'COMPETENZE_PERSONALIZZATE'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        PopupMenu = ppmnuProcPers
        ShowHint = False
        TabOrder = 2
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dchkArrotCompetenze: TDBCheckBox
        Left = 3
        Top = 49
        Width = 226
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Arrotondamento personalizzato competenze '
        DataField = 'ARROT_COMPETENZE'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        PopupMenu = ppmnuProcPers
        ShowHint = False
        TabOrder = 3
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dchkArrotResidui: TDBCheckBox
        Left = 3
        Top = 68
        Width = 226
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Arrotondamento personalizzato residui'
        DataField = 'ARROT_RESIDUI'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        PopupMenu = ppmnuProcPers
        ShowHint = False
        TabOrder = 4
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 63
    Width = 593
    Height = 59
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object lblDescrizione: TLabel
      Left = 8
      Top = 35
      Width = 99
      Height = 13
      Caption = 'Descrizione periodo :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblCodice: TLabel
      Left = 8
      Top = 8
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
    object lblDescCausale: TLabel
      Left = 130
      Top = 8
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
    object dedtCodice: TDBEdit
      Left = 48
      Top = 5
      Width = 56
      Height = 21
      Color = clBtnFace
      DataField = 'CODICE'
      DataSource = DButton
      TabOrder = 0
    end
    object dedtDescrizione: TDBEdit
      Left = 113
      Top = 32
      Width = 465
      Height = 21
      DataField = 'DESCRIZIONE'
      DataSource = DButton
      TabOrder = 1
    end
    object dedtDescCausale: TDBEdit
      Left = 189
      Top = 5
      Width = 389
      Height = 21
      Color = clBtnFace
      DataField = 'DESC_CAUSALE'
      DataSource = DButton
      TabOrder = 2
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 360
    Top = 32
  end
  inherited DButton: TDataSource
    Left = 388
    Top = 32
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 416
    Top = 32
  end
  inherited ImageList1: TImageList
    Left = 444
    Top = 32
  end
  inherited ActionList1: TActionList
    Left = 472
    Top = 32
    inherited actRicerca: TAction
      ShortCut = 0
      Visible = False
    end
    inherited actPrimo: TAction
      ShortCut = 0
      Visible = False
    end
    inherited actPrecedente: TAction
      ShortCut = 0
      Visible = False
    end
    inherited actSuccessivo: TAction
      ShortCut = 0
      Visible = False
    end
    inherited actUltimo: TAction
      ShortCut = 0
      Visible = False
    end
    inherited actInserisci: TAction
      ShortCut = 0
      Visible = False
      OnExecute = nil
    end
  end
  object ppmnuProcPers: TPopupMenu
    OnPopup = ppmnuProcPersPopup
    Left = 539
    Top = 31
    object Accedi1: TMenuItem
      Caption = 'Accedi'
      OnClick = Accedi1Click
    end
  end
end
