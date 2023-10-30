inherited A210FRegoleArchiviazioneDoc: TA210FRegoleArchiviazioneDoc
  Left = 172
  Top = 175
  HelpContext = 210000
  Caption = '<A210> Regole archiviazione documenti'
  ClientHeight = 602
  ClientWidth = 562
  ExplicitWidth = 578
  ExplicitHeight = 661
  PixelsPerInch = 96
  TextHeight = 13
  object lblDTipoDocumento: TLabel [0]
    Left = 16
    Top = 33
    Width = 77
    Height = 13
    Caption = 'Tipo documento'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  inherited StatusBar: TStatusBar
    Top = 584
    Width = 562
    ExplicitTop = 584
    ExplicitWidth = 562
  end
  inherited Panel1: TToolBar
    Width = 562
    TabOrder = 2
    ExplicitWidth = 562
  end
  object dedtDTipoDocumento: TDBEdit [3]
    Left = 16
    Top = 48
    Width = 123
    Height = 21
    Color = clBtnFace
    DataField = 'D_TIPO_DOCUMENTO'
    DataSource = DButton
    ReadOnly = True
    TabOrder = 0
  end
  object pgcMain: TPageControl [4]
    Left = 16
    Top = 75
    Width = 529
    Height = 502
    ActivePage = tshLocale
    TabOrder = 3
    object tshLocale: TTabSheet
      Caption = 'Archiviazione locale'
      DesignSize = (
        521
        474)
      object lblPathFile: TLabel
        Left = 7
        Top = 7
        Width = 118
        Height = 13
        Caption = 'Percorso di archiviazione'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblFilePdf: TLabel
        Left = 7
        Top = 51
        Width = 128
        Height = 13
        Caption = 'Nome del file in formato pdf'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblFileXml: TLabel
        Left = 7
        Top = 94
        Width = 115
        Height = 13
        Caption = 'Nome del file di metadati'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblCampiXml: TLabel
        Left = 7
        Top = 136
        Width = 219
        Height = 13
        Caption = 'Elenco dei campi da inserire nel file di metadati'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblDataUltimaArch: TLabel
        Left = 7
        Top = 397
        Width = 198
        Height = 13
        Caption = 'Data di riferimento dell'#39'ultima archiviazione'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object spdDataRifUltimaElab: TSpeedButton
        Left = 82
        Top = 411
        Width = 17
        Height = 21
        Caption = '...'
        OnClick = spdDataRifUltimaElabClick
      end
      object lblTipologiaDocumenti: TLabel
        Left = 7
        Top = 224
        Width = 224
        Height = 13
        Caption = 'Registra nella tipologia di gestione documentale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblBucketId: TLabel
        Left = 7
        Top = 179
        Width = 189
        Height = 13
        Caption = 'BucketId di destinazione del documento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblScriptVerificaValidazione: TLabel
        Left = 7
        Top = 267
        Width = 156
        Height = 13
        Caption = 'Script di verifica della validazione'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblScriptNote: TLabel
        Left = 7
        Top = 309
        Width = 149
        Height = 13
        Caption = 'Script per l'#39'estrazione delle note'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblScriptPostArchiviazione: TLabel
        Left = 7
        Top = 352
        Width = 115
        Height = 13
        Caption = 'Script post archiviazione'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object btnPathFile: TButton
        Left = 498
        Top = 23
        Width = 19
        Height = 21
        Caption = '...'
        TabOrder = 1
        OnClick = btnPathFileClick
      end
      object dedtFilePdf: TDBEdit
        Left = 7
        Top = 66
        Width = 489
        Height = 21
        DataField = 'FILE_PDF'
        DataSource = DButton
        TabOrder = 2
      end
      object dedtFileXml: TDBEdit
        Left = 7
        Top = 109
        Width = 489
        Height = 21
        DataField = 'FILE_XML'
        DataSource = DButton
        TabOrder = 3
      end
      object dedtCampiXml: TDBEdit
        Left = 7
        Top = 151
        Width = 489
        Height = 21
        DataField = 'CAMPI_XML'
        DataSource = DButton
        TabOrder = 4
      end
      object dchkSostituzioneFile: TDBCheckBox
        Left = 338
        Top = 415
        Width = 129
        Height = 17
        Caption = 'Sovrascrittura file'
        DataField = 'SOSTITUZIONE_FILE'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dchkSvuotaCartella: TDBCheckBox
        Left = 338
        Top = 394
        Width = 180
        Height = 17
        Caption = 'Svuota cartella di destinazione'
        DataField = 'SVUOTA_DIRECTORY'
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
        OnClick = dchkSvuotaCartellaClick
      end
      object dedtPathFile: TDBEdit
        Left = 7
        Top = 23
        Width = 489
        Height = 21
        DataField = 'PATH_FILE'
        DataSource = DButton
        TabOrder = 0
      end
      object dedtDataRifUltimaElab: TDBEdit
        Left = 7
        Top = 411
        Width = 71
        Height = 21
        DataField = 'DATA_RIF_ULTIMA_ELAB'
        DataSource = DButton
        TabOrder = 6
      end
      object dcmbTipologiaDocumenti: TDBLookupComboBox
        Left = 7
        Top = 240
        Width = 489
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        DataField = 'TIPOLOGIA_DOCUMENTI'
        DataSource = DButton
        KeyField = 'CODICE'
        ListField = 'DESCRIZIONE'
        ListSource = A210FRegoleArchiviazioneDocDtM.dsrT962Lookup
        TabOrder = 5
      end
      object dedtBucketId: TDBEdit
        Left = 7
        Top = 195
        Width = 489
        Height = 21
        DataField = 'BUCKETID'
        DataSource = DButton
        TabOrder = 9
      end
      object dchkVerificaValidazione: TDBCheckBox
        Left = 338
        Top = 436
        Width = 129
        Height = 17
        Caption = 'Verifica validazione'
        DataField = 'VERIFICA_VALIDAZIONE'
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
      object dedtScriptVerificaValidazione: TDBEdit
        Left = 7
        Top = 282
        Width = 489
        Height = 21
        DataField = 'SCRIPT_VALIDAZIONE'
        DataSource = DButton
        TabOrder = 11
      end
      object dedtScriptNote: TDBEdit
        Left = 7
        Top = 325
        Width = 489
        Height = 21
        DataField = 'SCRIPT_NOTE'
        DataSource = DButton
        TabOrder = 12
      end
      object dedtScriptPostArchiviazione: TDBEdit
        Left = 7
        Top = 368
        Width = 489
        Height = 21
        DataField = 'SCRIPT_ARCHIVIAZIONE'
        DataSource = DButton
        TabOrder = 13
      end
      object dchkInviaRegistro: TDBCheckBox
        Left = 338
        Top = 457
        Width = 129
        Height = 17
        Caption = 'Invia registro'
        DataField = 'INVIA_REGISTRO'
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
    object tshRemoto: TTabSheet
      Caption = 'Archiviazione remota (SFTP/REST)'
      ImageIndex = 1
      object lblServerSFTP: TLabel
        Left = 7
        Top = 7
        Width = 125
        Height = 13
        Caption = 'Nome / indirizzo del server'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblUsername: TLabel
        Left = 7
        Top = 51
        Width = 61
        Height = 13
        Caption = 'Nome utente'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblPassword: TLabel
        Left = 7
        Top = 94
        Width = 46
        Height = 13
        Caption = 'Password'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblDirArch: TLabel
        Left = 7
        Top = 136
        Width = 157
        Height = 13
        Caption = 'Cartella remota in cui copiare i file'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblPathPSCP: TLabel
        Left = 7
        Top = 177
        Width = 287
        Height = 13
        Caption = 'Percorso dell'#39'eseguibile di PSCP (PuTTY Secure Copy client)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object dedtServerSFTP: TDBEdit
        Left = 7
        Top = 22
        Width = 506
        Height = 21
        DataField = 'SERVER_SFTP'
        DataSource = DButton
        TabOrder = 0
      end
      object dedtUsername: TDBEdit
        Left = 7
        Top = 66
        Width = 506
        Height = 21
        DataField = 'USERNAME_SFTP'
        DataSource = DButton
        TabOrder = 1
      end
      object dedtDirArch: TDBEdit
        Left = 7
        Top = 151
        Width = 506
        Height = 21
        DataField = 'DIR_ARCH_SFTP'
        DataSource = DButton
        TabOrder = 3
      end
      object dedtPathPSCP: TDBEdit
        Left = 7
        Top = 192
        Width = 489
        Height = 21
        DataField = 'PATH_PSCP'
        DataSource = DButton
        TabOrder = 4
      end
      object btnBrowsePSCP: TButton
        Left = 499
        Top = 192
        Width = 14
        Height = 21
        Caption = '...'
        TabOrder = 5
        OnClick = btnBrowsePSCPClick
      end
      object dedtPassword: TDBEdit
        Left = 7
        Top = 109
        Width = 506
        Height = 21
        DataField = 'PASSWORD_SFTP'
        DataSource = DButton
        TabOrder = 2
      end
    end
  end
  object rgpTipoMetadati: TDBRadioGroup [5]
    Left = 162
    Top = 33
    Width = 156
    Height = 36
    Caption = 'Tipo file metadati'
    Columns = 2
    DataField = 'TIPO_FILE_METADATI'
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Items.Strings = (
      'XML'
      'JSON')
    ParentFont = False
    TabOrder = 4
    Values.Strings = (
      'X'
      'J')
    OnChange = rgpTipoMetadatiChange
  end
  inherited MainMenu1: TMainMenu
    Left = 376
    Top = 22
  end
  inherited DButton: TDataSource
    Left = 430
    Top = 22
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 403
    Top = 22
  end
  inherited ImageList1: TImageList
    Left = 457
    Top = 22
  end
  inherited ActionList1: TActionList
    Left = 484
    Top = 22
    inherited actInserisci: TAction
      Visible = False
    end
    inherited actCancella: TAction
      Visible = False
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 
      'File Rich Text Format (*.rtf)|*.rtf|File di testo (*.txt)|*.txt|' +
      'Tutti i files (*.*)|*.*'
    Left = 524
    Top = 24
  end
end
