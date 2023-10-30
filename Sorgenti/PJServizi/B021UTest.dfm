object B021FTest: TB021FTest
  Left = 0
  Top = 0
  Caption = '<B021> Client REST di test'
  ClientHeight = 665
  ClientWidth = 624
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 618
    Height = 659
    ActivePage = TabSheet1
    Align = alClient
    Constraints.MinHeight = 659
    TabOrder = 0
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Caption = 'Dati richiesta'
      DesignSize = (
        610
        631)
      object grpInfo: TGroupBox
        Left = 3
        Top = -4
        Width = 602
        Height = 73
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Informazioni registro'
        Color = clBtnFace
        ParentBackground = False
        ParentColor = False
        TabOrder = 0
        object lblInfoDatabase: TLabel
          Left = 12
          Top = 23
          Width = 45
          Height = 13
          Caption = 'Logon DB'
        end
        object lblInfoPathLog: TLabel
          Left = 12
          Top = 48
          Width = 56
          Height = 13
          Caption = 'Path file log'
        end
        object lblInfoAzienda: TLabel
          Left = 212
          Top = 23
          Width = 38
          Height = 13
          Caption = 'Azienda'
        end
        object lblInfoUtenteI070: TLabel
          Left = 395
          Top = 23
          Width = 58
          Height = 13
          Caption = 'Utente I070'
        end
        object edtInfoDatabase: TEdit
          Left = 76
          Top = 20
          Width = 130
          Height = 21
          TabOrder = 0
          OnChange = edtInfoDatabaseChange
        end
        object edtInfoUtente: TEdit
          Left = 460
          Top = 20
          Width = 130
          Height = 21
          TabOrder = 2
          OnChange = edtInfoDatabaseChange
        end
        object edtInfoPathLog: TEdit
          Left = 74
          Top = 45
          Width = 312
          Height = 21
          TabOrder = 3
          OnChange = edtInfoDatabaseChange
        end
        object edtInfoAzienda: TEdit
          Left = 256
          Top = 20
          Width = 130
          Height = 21
          TabOrder = 1
          OnChange = edtInfoDatabaseChange
        end
        object chkLog: TCheckBox
          Left = 395
          Top = 47
          Width = 70
          Height = 17
          Caption = 'Log attivo'
          Ctl3D = True
          ParentCtl3D = False
          TabOrder = 4
          OnClick = chkLogClick
        end
        object btnSalvaRegistro: TButton
          Left = 468
          Top = 43
          Width = 57
          Height = 26
          Caption = 'Salva'
          Enabled = False
          TabOrder = 5
          OnClick = btnSalvaRegistroClick
        end
        object btnAnnullaRegistro: TButton
          Left = 533
          Top = 43
          Width = 57
          Height = 26
          Caption = 'Annulla'
          Enabled = False
          TabOrder = 6
          OnClick = btnAnnullaRegistroClick
        end
      end
      object grpEsecuzione: TGroupBox
        Left = 3
        Top = 556
        Width = 602
        Height = 73
        Anchors = [akLeft, akRight, akBottom]
        Caption = 'Esecuzione'
        Color = clBtnFace
        ParentBackground = False
        ParentColor = False
        TabOrder = 3
        DesignSize = (
          602
          73)
        object Label9: TLabel
          Left = 12
          Top = 22
          Width = 103
          Height = 13
          Caption = 'Chiamate simultanee:'
        end
        object lblTempo: TLabel
          Left = 466
          Top = 29
          Width = 113
          Height = 13
          AutoSize = False
        end
        object lblConta: TLabel
          Left = 466
          Top = 49
          Width = 112
          Height = 13
          AutoSize = False
        end
        object Label4: TLabel
          Left = 391
          Top = 29
          Width = 36
          Height = 13
          Caption = 'Tempo:'
        end
        object Label5: TLabel
          Left = 391
          Top = 49
          Width = 70
          Height = 13
          Caption = 'Avanzamento:'
        end
        object ProgressBar1: TProgressBar
          Left = 12
          Top = 47
          Width = 206
          Height = 18
          DoubleBuffered = False
          ParentDoubleBuffered = False
          Smooth = True
          MarqueeInterval = 1
          TabOrder = 3
          Visible = False
        end
        object btnEsegui: TButton
          Left = 256
          Top = 29
          Width = 113
          Height = 38
          Caption = 'Esegui'
          TabOrder = 2
          OnClick = btnEseguiClick
        end
        object SpinEdit1: TSpinEdit
          Left = 147
          Top = 19
          Width = 71
          Height = 22
          MaxValue = 10000
          MinValue = 1
          TabOrder = 0
          Value = 1
          OnKeyPress = SpinEdit1KeyPress
        end
        object chkFiddler: TCheckBox
          Left = 256
          Top = 10
          Width = 113
          Height = 17
          Anchors = [akLeft, akBottom]
          Caption = 'Analizza con Fiddler'
          TabOrder = 1
        end
      end
      object grpParametri: TGroupBox
        Left = 3
        Top = 133
        Width = 602
        Height = 423
        Anchors = [akLeft, akTop, akRight, akBottom]
        Caption = 'Parametri richiesta'
        Color = clBtnFace
        Constraints.MinHeight = 420
        ParentBackground = False
        ParentColor = False
        TabOrder = 2
        DesignSize = (
          602
          423)
        object lblServerURL: TLabel
          Left = 12
          Top = 23
          Width = 19
          Height = 13
          Caption = 'URL'
        end
        object lblMetodoURL: TLabel
          Left = 12
          Top = 51
          Width = 36
          Height = 13
          Caption = 'Metodo'
        end
        object lblParJson: TLabel
          Left = 259
          Top = 51
          Width = 46
          Height = 13
          Caption = 'Parametri'
        end
        object lblPostData: TLabel
          Left = 12
          Top = 314
          Width = 53
          Height = 13
          Caption = 'POSTDATA'
          Visible = False
        end
        object lblQueryString: TLabel
          Left = 12
          Top = 287
          Width = 57
          Height = 13
          Caption = 'Querystring'
        end
        object lblPassphrase: TLabel
          Left = 239
          Top = 260
          Width = 55
          Height = 13
          Caption = 'Passphrase'
        end
        object cmbServerURL: TComboBox
          Left = 74
          Top = 20
          Width = 522
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          Text = 'http://localhost:8080/datasnap/rest/TB021FIrisRestSvcDM'
          Items.Strings = (
            'http://localhost:8080/datasnap/rest/TB021FIrisRestSvcDM'
            'http://192.0.0.106/IrisWEB/B021PIrisRestSvc_IIS.dll'
            
              'http://134.255.177.33:8080/hsacomo/rest/calendar/list/v1?start=0' +
              '1-10-2012&end=30-10-2012'
            
              'http://134.255.177.33:8080/hsacomo/rest/justification/insertjust' +
              'ification/v1'
            
              'http://134.255.177.33:8080/hsacomo/rest/justification/list/v1?st' +
              'art=01-03-2012&end=01-04-2012'
            
              'https://server114.gestioneturni.com/hsacomostaging/rest/justific' +
              'ation/list/v1?start=01-03-2012&end=01-04-2012')
        end
        object edtMethodUrl: TEdit
          Left = 74
          Top = 48
          Width = 177
          Height = 21
          TabOrder = 1
          Text = '/Anagrafiche/'
          OnKeyPress = edtMethodUrlKeyPress
        end
        object edtParametri: TEdit
          Left = 308
          Top = 48
          Width = 206
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 2
          Text = '*/*/*/001703'
          OnKeyPress = edtParametriKeyPress
        end
        object memPostData: TMemo
          Left = 74
          Top = 309
          Width = 440
          Height = 104
          Anchors = [akLeft, akTop, akRight, akBottom]
          DoubleBuffered = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          ParentDoubleBuffered = False
          ParentFont = False
          ScrollBars = ssBoth
          TabOrder = 9
          Visible = False
          WordWrap = False
        end
        object btnPulisciPostData: TButton
          Left = 520
          Top = 309
          Width = 76
          Height = 26
          Anchors = [akRight]
          Caption = 'Pulisci'
          TabOrder = 10
          Visible = False
          OnClick = btnPulisciPostDataClick
        end
        object btnCopiaURL: TButton
          Left = 520
          Top = 44
          Width = 76
          Height = 31
          Anchors = [akTop, akRight]
          Caption = 'Copia URL in Appunti'
          TabOrder = 3
          WordWrap = True
          OnClick = btnCopiaURLClick
        end
        object edtQueryString: TEdit
          Left = 74
          Top = 284
          Width = 440
          Height = 21
          Color = cl3DLight
          ReadOnly = True
          TabOrder = 8
        end
        object chkTokenAutenticazione: TCheckBox
          Left = 12
          Top = 260
          Width = 189
          Height = 17
          Caption = 'Utilizza token per autenticazione'
          TabOrder = 6
        end
        object edtPassphrase: TEdit
          Left = 308
          Top = 257
          Width = 206
          Height = 21
          TabOrder = 7
          Text = '123-456-789-987-654-321'
        end
        object memoScript: TMemo
          Left = 74
          Top = 76
          Width = 440
          Height = 173
          Anchors = [akLeft, akTop, akRight]
          DoubleBuffered = True
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          ParentDoubleBuffered = False
          ParentFont = False
          ScrollBars = ssBoth
          TabOrder = 5
          WordWrap = False
        end
        object chkEseguiScript: TCheckBox
          Left = 8
          Top = 76
          Width = 63
          Height = 38
          Caption = 'Esegui elenco di chiamate'
          TabOrder = 4
          WordWrap = True
          OnClick = chkEseguiScriptClick
        end
      end
      object grpMetodo: TGroupBox
        Left = 3
        Top = 75
        Width = 602
        Height = 58
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Metodo'
        Color = clBtnFace
        ParentBackground = False
        ParentColor = False
        TabOrder = 1
        object cmbMetodo: TComboBox
          Left = 95
          Top = 23
          Width = 330
          Height = 21
          Style = csDropDownList
          TabOrder = 1
          OnChange = cmbMetodoChange
        end
        object cmbMetodoHtml: TComboBox
          Left = 12
          Top = 23
          Width = 77
          Height = 21
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 0
          Text = 'Get'
          OnChange = cmbMetodoHtmlChange
          Items.Strings = (
            'Get'
            'Post'
            'Put'
            'Delete')
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Output webservice'
      ImageIndex = 1
      object memOutputSvc: TMemo
        Left = 0
        Top = 0
        Width = 610
        Height = 597
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssHorizontal
        TabOrder = 0
        WordWrap = False
      end
      object Panel2: TPanel
        Left = 0
        Top = 597
        Width = 610
        Height = 34
        Align = alBottom
        TabOrder = 1
        object btnSaveFile: TButton
          Left = 502
          Top = 5
          Width = 101
          Height = 25
          Caption = 'Salva su file...'
          TabOrder = 0
          OnClick = btnSaveFileClick
        end
        object btnCopia: TButton
          Left = 4
          Top = 5
          Width = 101
          Height = 25
          Caption = 'Copia in Appunti'
          TabOrder = 1
          OnClick = btnCopiaClick
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Log'
      ImageIndex = 3
      object memLog: TMemo
        Left = 0
        Top = 0
        Width = 610
        Height = 597
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 0
        WordWrap = False
      end
      object Panel1: TPanel
        Left = 0
        Top = 597
        Width = 610
        Height = 34
        Align = alBottom
        TabOrder = 1
        object btnCancLog: TButton
          Left = 0
          Top = 5
          Width = 101
          Height = 25
          Caption = 'Cancella log'
          TabOrder = 0
          OnClick = btnCancLogClick
        end
      end
    end
  end
  object IdHTTP1: TIdHTTP
    IOHandler = IdSSLIOHandlerSocketOpenSSL1
    MaxAuthRetries = 5
    AllowCookies = True
    HandleRedirects = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.Connection = 'close'
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 368
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 465
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '*.xml'
    FileName = 'Output.xml'
    Filter = 'File XML (*.xml)|*.xml|Tutti i file (*.*)|*.*'#39
    InitialDir = 'c:\'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 312
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 50
    OnTimer = Timer1Timer
    Left = 560
    Top = 432
  end
  object IdCompressorZLib1: TIdCompressorZLib
    Left = 568
  end
end
