object B005FAggIris: TB005FAggIris
  Left = 320
  Top = 288
  HelpContext = 9005000
  Caption = '<B005> Aggiornamento base dati'
  ClientHeight = 802
  ClientWidth = 590
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
  object Splitter1: TSplitter
    Left = 0
    Top = 186
    Width = 590
    Height = 5
    Cursor = crVSplit
    Align = alTop
    Beveled = True
    OnMoved = Splitter1Moved
    ExplicitTop = 209
    ExplicitWidth = 606
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 783
    Width = 590
    Height = 19
    Panels = <
      item
        Width = 260
      end
      item
        Width = 50
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 191
    Width = 590
    Height = 332
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    OnClick = Panel1Click
    object lblFileMedp: TLabel
      Left = 3
      Top = 2
      Width = 63
      Height = 13
      Caption = 'File MEDP.ini'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblRagSoc: TLabel
      Left = 86
      Top = 40
      Width = 3
      Height = 13
    end
    object lblTablespaceTabelle: TLabel
      Left = 4
      Top = 208
      Width = 93
      Height = 13
      Caption = 'Tablespace tabelle:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblTablespaceIndici: TLabel
      Left = 4
      Top = 223
      Width = 86
      Height = 13
      Caption = 'Tablespace indici:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblAddIrpef: TLabel
      Left = 3
      Top = 239
      Width = 474
      Height = 13
      Caption = 
        'Attenzione! P042_ENTIIRPEF valorizzata. Verranno eseguiti gli sc' +
        'ripts "AddIRPEF"'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblModuliDB: TLabel
      Left = 3
      Top = 54
      Width = 72
      Height = 13
      Caption = 'Moduli esistenti'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblModuliFile: TLabel
      Left = 294
      Top = 54
      Width = 90
      Height = 13
      Caption = 'Moduli da installare'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 3
      Top = 40
      Width = 79
      Height = 13
      Caption = 'Ragione sociale:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object btnDBMenoFile: TSpeedButton
      Left = 271
      Top = 68
      Width = 23
      Height = 22
      Hint = 'Moduli esistenti che verranno disinstallati'
      AllowAllUp = True
      GroupIndex = 1
      Caption = '-'
      ParentShowHint = False
      ShowHint = True
      OnClick = btnDBMenoFileClick
    end
    object btnFileMenoDB: TSpeedButton
      Left = 271
      Top = 96
      Width = 23
      Height = 22
      Hint = 'Nuovi moduli che verranno installati'
      AllowAllUp = True
      GroupIndex = 2
      Caption = '+'
      ParentShowHint = False
      ShowHint = True
      OnClick = btnFileMenoDBClick
    end
    object lblScriptSQLCustom: TLabel
      Left = 4
      Top = 256
      Width = 571
      Height = 13
      Caption = 
        'Attenzione! La tabella I051_SQL_CUSTOM contiene script personali' +
        'zzati attivi che saranno eseguiti.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object BitBtn1: TBitBtn
      Left = 483
      Top = 308
      Width = 101
      Height = 24
      Caption = '&Chiudi'
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 15
    end
    object btnEseguiScript: TBitBtn
      Left = 145
      Top = 308
      Width = 107
      Height = 24
      Hint = 'Esegue solo gli scripts'
      Caption = 'Esegui scripts'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 12
      OnClick = btnEseguiScriptClick
    end
    object btnCreazioneProcedure: TBitBtn
      Left = 260
      Top = 308
      Width = 107
      Height = 24
      Hint = 'Esegue solo la creazione delle procedure'
      Caption = 'Creazione procedure'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 13
      OnClick = btnCreazioneProcedureClick
    end
    object btnInvioLog: TBitBtn
      Left = 375
      Top = 308
      Width = 101
      Height = 24
      Caption = 'Invio log per E-mail'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 14
      OnClick = btnInvioLogClick
    end
    object chkRegistra: TCheckBox
      Left = 483
      Top = 241
      Width = 88
      Height = 17
      Caption = 'Registra su file'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      Visible = False
    end
    object chkNoStorage: TCheckBox
      Left = 359
      Top = 18
      Width = 225
      Height = 18
      Alignment = taLeftJustify
      Caption = 'Esegui scripts senza parametri di STORAGE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = chkNoStorageClick
    end
    object CmbMEdp: TComboBox
      Left = 3
      Top = 17
      Width = 291
      Height = 21
      Style = csDropDownList
      TabOrder = 0
      OnChange = CmbMEdpChange
    end
    object ChkRagioneSociale: TCheckBox
      Left = 360
      Top = 34
      Width = 224
      Height = 20
      Alignment = taLeftJustify
      Caption = 'Aggiorna ragione sociale'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object chkRegistraSuDB: TCheckBox
      Left = 359
      Top = 2
      Width = 225
      Height = 18
      Alignment = taLeftJustify
      Caption = 'Registra log di aggiornamento su DB'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object btnScriptsProcedure: TBitBtn
      Left = 4
      Top = 308
      Width = 135
      Height = 24
      Hint = 'Esegue in sequenza gli scripts e la creazione delle procedure'
      Caption = 'Esegui scripts e procedure'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 11
      OnClick = btnScriptsProcedureClick
    end
    object lstStringModuliDB: TListBox
      Left = 2
      Top = 67
      Width = 268
      Height = 139
      ItemHeight = 13
      Sorted = True
      TabOrder = 6
    end
    object lststringModuliFile: TListBox
      Left = 294
      Top = 67
      Width = 290
      Height = 139
      ItemHeight = 13
      Sorted = True
      TabOrder = 7
    end
    object btnAggVersioneDB: TBitBtn
      Left = 483
      Top = 278
      Width = 101
      Height = 25
      Caption = 'Agg.to versione DB'
      TabOrder = 9
      OnClick = btnAggVersioneDBClick
    end
    object btnAccessoA008: TBitBtn
      Left = 298
      Top = 278
      Width = 184
      Height = 25
      Caption = 'Abilita accesso aziende/operatori'
      TabOrder = 8
      OnClick = btnAccessoA008Click
    end
    object rgpTipoAggiornamento: TRadioGroup
      Left = 2
      Top = 269
      Width = 250
      Height = 33
      Caption = 'Tipologia aggiornamento'
      Color = clBtnFace
      Columns = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Azienda selezionata'
        'Tutte le aziende')
      ParentBackground = False
      ParentColor = False
      ParentFont = False
      TabOrder = 5
    end
    object chkMedpAutomatico: TCheckBox
      Left = 155
      Top = 2
      Width = 139
      Height = 15
      Alignment = taLeftJustify
      Caption = 'Associazione automatica'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 523
    Width = 590
    Height = 260
    Align = alClient
    Caption = 'Messaggi'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object Messaggi: TMemo
      Left = 2
      Top = 15
      Width = 383
      Height = 243
      Align = alClient
      Color = cl3DLight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 0
      WordWrap = False
    end
    object memoTrace: TMemo
      Left = 385
      Top = 15
      Width = 203
      Height = 243
      Align = alRight
      Color = cl3DLight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 1
      WordWrap = False
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 590
    Height = 186
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    DesignSize = (
      590
      186)
    object Label1: TLabel
      Left = 2
      Top = 21
      Width = 120
      Height = 13
      Caption = 'Cartella degli scripts SQL:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 254
      Top = 41
      Width = 88
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'Scripts gi'#224' eseguiti'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 428
      Top = 41
      Width = 90
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'Scripts da eseguire'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 2
      Top = 41
      Width = 38
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'Aziende'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblDatabasename: TLabel
      Left = 3
      Top = 0
      Width = 124
      Height = 16
      Caption = 'lblDatabasename'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtPathSQL: TEdit
      Left = 128
      Top = 18
      Width = 441
      Height = 21
      ReadOnly = True
      TabOrder = 0
      Text = 'edtPathSQL'
    end
    object Button1: TButton
      Left = 570
      Top = 18
      Width = 14
      Height = 22
      Caption = '...'
      TabOrder = 1
      OnClick = Button1Click
    end
    object ListBox1: TListBox
      Left = 250
      Top = 56
      Width = 157
      Height = 129
      Anchors = [akLeft, akTop, akBottom]
      ItemHeight = 13
      Sorted = True
      TabOrder = 3
      OnDblClick = ListBox1DblClick
    end
    object ListBox2: TListBox
      Left = 428
      Top = 56
      Width = 157
      Height = 129
      Anchors = [akLeft, akTop, akBottom]
      ItemHeight = 13
      Sorted = True
      TabOrder = 6
      OnDblClick = ListBox2DblClick
    end
    object Button2: TButton
      Left = 408
      Top = 56
      Width = 21
      Height = 22
      Caption = '>'
      Enabled = False
      TabOrder = 4
      OnClick = ListBox1DblClick
    end
    object Button3: TButton
      Left = 408
      Top = 86
      Width = 21
      Height = 22
      Caption = '<'
      TabOrder = 5
      OnClick = ListBox2DblClick
    end
    object DBGrid1: TDBGrid
      Left = -3
      Top = 56
      Width = 247
      Height = 129
      Anchors = [akLeft, akTop, akBottom]
      DataSource = B005FAggIrisDtM1.D090
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.SQL'
    Filter = 'SQL file (*.SQL)|*.SQL'
    Left = 360
    Top = 4
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '*.SQL'
    Left = 425
    Top = 4
  end
end
