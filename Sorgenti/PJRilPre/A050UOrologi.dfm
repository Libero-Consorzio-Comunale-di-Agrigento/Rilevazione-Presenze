inherited A050FOrologi: TA050FOrologi
  Left = 127
  Top = 104
  HelpContext = 50000
  Caption = '<A050> Orologi di timbratura'
  ClientHeight = 464
  ClientWidth = 450
  ExplicitWidth = 466
  ExplicitHeight = 523
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 446
    Width = 450
    SizeGrip = False
    ExplicitTop = 446
    ExplicitWidth = 450
  end
  inherited Panel1: TToolBar
    Width = 450
    ExplicitWidth = 450
  end
  object Panel2: TPanel [2]
    Left = 0
    Top = 24
    Width = 450
    Height = 422
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object LCodice: TLabel
      Left = 3
      Top = 3
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
    object LDescrizione: TLabel
      Left = 53
      Top = 3
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
    object Label1: TLabel
      Left = 3
      Top = 147
      Width = 194
      Height = 13
      Caption = 'Timbrature di mensa se causalizzate con:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblIndirizzo: TLabel
      Left = 3
      Top = 44
      Width = 38
      Height = 13
      Caption = 'Indirizzo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblDLocalita: TLabel
      Left = 131
      Top = 209
      Width = 91
      Height = 13
      Caption = 'Descrizione localit'#224
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblCodLocalita: TLabel
      Left = 363
      Top = 209
      Width = 56
      Height = 13
      Caption = 'Codice Istat'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 3
      Top = 320
      Width = 48
      Height = 13
      Caption = 'Rilevatore'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 159
      Top = 320
      Width = 36
      Height = 13
      Caption = 'Scarico'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object DBECodice: TDBEdit
      Left = 3
      Top = 19
      Width = 44
      Height = 21
      DataField = 'CODICE'
      DataSource = DButton
      MaxLength = 2
      TabOrder = 0
    end
    object DBEDescr: TDBEdit
      Left = 53
      Top = 19
      Width = 383
      Height = 21
      DataField = 'DESCRIZIONE'
      DataSource = DButton
      MaxLength = 100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object DBRGFunzione: TDBRadioGroup
      Left = 3
      Top = 85
      Width = 351
      Height = 36
      Caption = 'Funzione'
      Columns = 3
      DataField = 'FUNZIONE'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Items.Strings = (
        'Presenza'
        'Mensa'
        'Presenza/Mensa')
      ParentFont = False
      TabOrder = 3
      Values.Strings = (
        'P'
        'M'
        'E')
      OnChange = DBRGFunzioneChange
    end
    object ECausale: TDBLookupComboBox
      Left = 221
      Top = 143
      Width = 83
      Height = 21
      DataField = 'CAUSMENSA'
      DataSource = DButton
      DropDownWidth = 200
      KeyField = 'CODICE'
      ListField = 'CODICE;DESCRIZIONE'
      ListSource = A050FOrologiDtM1.D305
      PopupMenu = PopupMenu1
      TabOrder = 5
      OnKeyDown = ECausaleKeyDown
    end
    object DBRadioGroup1: TDBRadioGroup
      Left = 3
      Top = 164
      Width = 351
      Height = 36
      Caption = 'Verso di timbratura associato'
      Columns = 3
      DataField = 'VERSO'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Items.Strings = (
        'Nessuno'
        'Entrata'
        'Uscita')
      ParentFont = False
      TabOrder = 6
      Values.Strings = (
        'N'
        'E'
        'U')
      OnChange = DBRGFunzioneChange
    end
    object GroupBox1: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 362
      Width = 444
      Height = 57
      Align = alBottom
      Caption = 'Messaggi'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 12
      object Label2: TLabel
        Left = 6
        Top = 16
        Width = 52
        Height = 13
        Caption = 'Postazione'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 75
        Top = 16
        Width = 38
        Height = 13
        Caption = 'Indirizzo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 145
        Top = 16
        Width = 51
        Height = 13
        Caption = 'Indirizzo IP'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object dEdtPostazione: TDBEdit
        Left = 5
        Top = 31
        Width = 60
        Height = 21
        DataField = 'POSTAZIONE'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object dEdtIndirizzoTerm: TDBEdit
        Left = 75
        Top = 31
        Width = 60
        Height = 21
        DataField = 'INDIRIZZO_TERMINALE'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object dEdtIndirizzoIP: TDBEdit
        Left = 143
        Top = 31
        Width = 100
        Height = 21
        DataField = 'INDIRIZZO_IP'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object dChkRicezione: TDBCheckBox
        Left = 251
        Top = 33
        Width = 117
        Height = 17
        Caption = 'Ricezione Messaggi'
        DataField = 'RICEZIONE_MESSAG'
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
    object dchkApplicaPercorrenza: TDBCheckBox
      Left = 3
      Top = 124
      Width = 351
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Pausa mensa: applica eventuale tempo di percorrenza'
      DataField = 'APPLICA_PERCORRENZA_PM'
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
    object dedtIndirizzo: TDBEdit
      Left = 3
      Top = 58
      Width = 433
      Height = 21
      DataField = 'INDIRIZZO'
      DataSource = DButton
      MaxLength = 100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object drgpTipoLocalita: TDBRadioGroup
      Left = 3
      Top = 204
      Width = 123
      Height = 47
      Caption = 'Tipologia localit'#224
      DataField = 'TIPO_LOCALITA'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Items.Strings = (
        'Comune (C)'
        'Personalizzata (P)')
      ParentFont = False
      TabOrder = 7
      Values.Strings = (
        'C'
        'P')
      OnChange = drgpTipoLocalitaChange
    end
    object dcmbDLocalita: TDBLookupComboBox
      Left = 131
      Top = 227
      Width = 225
      Height = 21
      DataField = 'D_LOCALITA'
      DataSource = DButton
      DropDownWidth = 400
      KeyField = 'DESCRIZIONE'
      ListField = 'DESCRIZIONE'
      ListSource = A050FOrologiDtM1.DSelLocalita
      PopupMenu = PopupMenu1
      TabOrder = 8
      OnKeyDown = dcmbDLocalitaKeyDown
    end
    object dedtCodLocalita: TDBEdit
      Left = 363
      Top = 227
      Width = 73
      Height = 21
      TabStop = False
      DataField = 'COD_LOCALITA'
      DataSource = DButton
      ReadOnly = True
      TabOrder = 9
    end
    object dedtRilevatore: TDBEdit
      Left = 3
      Top = 336
      Width = 149
      Height = 21
      DataField = 'RILEVATORE'
      DataSource = DButton
      MaxLength = 10
      TabOrder = 10
      OnChange = dedtRilevatoreChange
    end
    object dcmbScarico: TDBLookupComboBox
      Left = 159
      Top = 336
      Width = 197
      Height = 21
      DataField = 'SCARICO'
      DataSource = DButton
      KeyField = 'SCARICO'
      ListField = 'SCARICO'
      ListSource = A050FOrologiDtM1.dsrI100
      PopupMenu = PopupMenu1
      TabOrder = 11
      OnKeyDown = dcmbDLocalitaKeyDown
    end
    object grpPosizioneRilevatore: TGroupBox
      Left = 3
      Top = 252
      Width = 354
      Height = 64
      Caption = 'Coordinate geografiche'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 13
      object lblLat: TLabel
        Left = 6
        Top = 19
        Width = 46
        Height = 13
        Caption = 'Latitudine'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblLng: TLabel
        Left = 140
        Top = 19
        Width = 55
        Height = 13
        Caption = 'Longitudine'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblRaggioValidita: TLabel
        Left = 6
        Top = 43
        Width = 130
        Height = 13
        Caption = 'Raggio di validit'#224' timbratura'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblRaggioValiditaMetri: TLabel
        Left = 200
        Top = 43
        Width = 22
        Height = 13
        Caption = 'metri'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object dedtLat: TDBEdit
        Left = 56
        Top = 16
        Width = 80
        Height = 21
        DataField = 'LAT'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object dedtLng: TDBEdit
        Left = 200
        Top = 16
        Width = 80
        Height = 21
        DataField = 'LNG'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object dedtRaggioValidita: TDBEdit
        Left = 140
        Top = 40
        Width = 50
        Height = 21
        DataField = 'RAGGIO_VALIDITA'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 4
        ParentFont = False
        TabOrder = 3
      end
      object btnCercaPosizione: TBitBtn
        Left = 284
        Top = 14
        Width = 24
        Height = 24
        Hint = 'Cerca posizione'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C30E0000C30E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFC0C0C0B0B0B0A9A9A9A5A5A5A6A6A6A3A3A3A3A3A3A3
          A3A3A3A3A3A3A3A3A6A6A6A5A5A5A9A9A9B0B0B0C0C0C0FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFEBEBEBB0B0AF98907AADADACE7E7E7FFFFFFFFFFFFFFFF
          FF9F7B29B99241FFFFFFFFFFFFFFFFFFFFFFFFE5E5E59F7B299F7B299F7B299F
          7B299F7B299F7B2988FC85DDDDDDFFFFFFB68F3ED1A556FFFFFFFFFFFFFFFFFF
          CBCBCB9F7B299F7B299F7B299F7B299F7B299F7B29A07E31B3B3B388FC85B28C
          3ACDA252FFFFFFFFFFFFFFFFFFF2F2F29F7B299F7B299F7B29A07C2AA17D2CA1
          7D2CBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCE8E8E8FFFFFFFFFFFFFFFFFF9F7B29
          9F7B29A27E2DA68232A88535AA8738C4C4C4C4C4C4BDD59BB7FAB5B8FCB7C4C4
          C488FC85FFFFFFFFFFFFFCFCFC9F7B29A48130AA8637AE8B3DB18E41B29043CB
          CBCBB18F42CCB78ACCB789CBB587CBCBCB9F7B29F8F8F8FFFFFFEDEDEDA58131
          AB8839B18E41B59347B9974C88FC85D1D1D1D1D1D1D3F0C8E1D3B6E0D3B4D1D1
          D1A17D2CE0E0E0FFFFFFE9E9E9AA8738B18E42B7954ABD9B5188FC8588FC8588
          FC85D5D5D5D5D5D5D5D5D5D5D5D5ECECECA68232DCDCDBFFFFFFF5F5F5AF8C3E
          B69448BD9C52C4A25BCAA86288FC8588FC8588FC85C7DDC7D6D6D6B9974DB28F
          43AA8738ECECECFFFFFFFFFFFFB29043BA984EC2A158CBA96288FC8588FC8588
          FC85D3B26E88FC85C7A45DBE9C52B6934888FC85FEFEFEFFFFFFFFFFFFAFAFAE
          BD9B52C7A45D88FC8588FC8588FC8588FC85DAB977D2B16DCAA862C19F56B896
          4B999998FFFFFFFFFFFFFFFFFFFFFFFFBE9C53C8A65FD0AF6AA1E780E2C181CE
          D38688FC8588FC85CBA96388FC8588FC85FEFEFEFFFFFFFFFFFFFFFFFFFFFFFF
          FCFCFCC5A45D88FC85D6B572DDBC7BDFBE7DDAB976D2B16D88FC8588FC85F9F9
          F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCACACA88FC8588FC85D6
          B572D3B26E88FC85C2C2C1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        Visible = False
        OnClick = btnCercaPosizioneClick
      end
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 296
    Top = 29
  end
  inherited DButton: TDataSource
    Left = 269
    Top = 29
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 324
    Top = 29
  end
  object PopupMenu1: TPopupMenu
    Left = 360
    Top = 29
    object Nuovoelemento1: TMenuItem
      Caption = 'Accedi'
      OnClick = Nuovoelemento1Click
    end
  end
  object IdHTTP1: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 296
    Top = 24
  end
end
