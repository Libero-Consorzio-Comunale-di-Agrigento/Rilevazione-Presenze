object B021FRiallineamento: TB021FRiallineamento
  Left = 0
  Top = 0
  Caption = 'Riallineamento assenze FIRLAB'
  ClientHeight = 533
  ClientWidth = 718
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    718
    533)
  PixelsPerInch = 96
  TextHeight = 13
  object lblServerUrl: TLabel
    Left = 8
    Top = 11
    Width = 19
    Height = 13
    Caption = 'URL'
  end
  object btnEsegui: TButton
    Left = 624
    Top = 148
    Width = 86
    Height = 25
    Caption = 'Esegui'
    TabOrder = 5
    OnClick = btnEseguiClick
  end
  object cmbServerURL: TComboBox
    Left = 35
    Top = 8
    Width = 675
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    Text = 'http://134.255.177.174:8080/hsacomo/rest/justification'
    Items.Strings = (
      'http://134.255.177.174:8080/hsacomo/rest/justification')
  end
  object dgrdOperazioni: TDBGrid
    Left = 8
    Top = 179
    Width = 702
    Height = 135
    Anchors = [akLeft, akTop, akRight]
    DataSource = dsrOperazioni
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'FLAG_ESEGUI'
        PickList.Strings = (
          'S'
          'N')
        Title.Caption = 'Esegui'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'STEP'
        Title.Caption = 'Passaggio'
        Width = 54
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRIZIONE'
        Title.Caption = 'Descrizione'
        Width = 410
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TOTALE'
        Title.Caption = 'Tot.'
        Width = 51
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FILTRO'
        Title.Caption = 'Filtro'
        Width = 200
        Visible = True
      end>
  end
  object grpMetodi: TGroupBox
    Left = 8
    Top = 35
    Width = 702
    Height = 46
    Caption = 'Metodi'
    TabOrder = 1
    object lblMetodoDel: TLabel
      Left = 332
      Top = 21
      Width = 102
      Height = 13
      Caption = 'Metodo cancellazione'
    end
    object lblMetodoIns: TLabel
      Left = 11
      Top = 21
      Width = 94
      Height = 13
      Caption = 'Metodo inserimento'
    end
    object edtMetodoIns: TEdit
      Left = 111
      Top = 18
      Width = 197
      Height = 21
      TabOrder = 0
      Text = '/createjustifications/v1'
    end
    object edtMetodoDel: TEdit
      Left = 440
      Top = 18
      Width = 217
      Height = 21
      TabOrder = 1
      Text = '/deletejustifications/v1'
    end
  end
  object pgbElaborazione: TProgressBar
    Left = 0
    Top = 497
    Width = 718
    Height = 17
    Align = alBottom
    TabOrder = 6
  end
  object sbMain: TStatusBar
    Left = 0
    Top = 514
    Width = 718
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object memLog: TMemo
    Left = 8
    Top = 320
    Width = 702
    Height = 171
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 4
  end
  object grpOpzioni: TGroupBox
    Left = 8
    Top = 87
    Width = 610
    Height = 86
    Caption = 'Opzioni'
    TabOrder = 2
    object lblElementi: TLabel
      Left = 11
      Top = 64
      Width = 83
      Height = 13
      Caption = 'Raggruppa giust.'
    end
    object chkFiddler: TCheckBox
      Left = 211
      Top = 18
      Width = 128
      Height = 17
      Caption = 'Debug con Fiddler'
      Enabled = False
      TabOrder = 2
    end
    object chkModoTest: TCheckBox
      Left = 11
      Top = 18
      Width = 152
      Height = 17
      Caption = 'Modalit'#224' test (no chiamate)'
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = chkModoTestClick
    end
    object sedtElementi: TSpinEdit
      Left = 111
      Top = 61
      Width = 73
      Height = 22
      MaxValue = 50000
      MinValue = 1
      TabOrder = 3
      Value = 5000
    end
    object chkFiltro: TCheckBox
      Left = 211
      Top = 41
      Width = 97
      Height = 17
      Caption = 'Utilizza filtri'
      TabOrder = 1
      OnClick = chkFiltroClick
    end
    object chkIndici: TCheckBox
      Left = 11
      Top = 41
      Width = 152
      Height = 17
      Caption = 'Gestione indici'
      TabOrder = 4
      OnClick = chkModoTestClick
    end
  end
  object IdHTTP1: TIdHTTP
    IOHandler = IdSSLIOHandlerSocketOpenSSL1
    MaxAuthRetries = 5
    AllowCookies = True
    HandleRedirects = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    HTTPOptions = [hoForceEncodeParams]
    Left = 336
    Top = 240
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 457
    Top = 240
  end
  object cdsOperazioni: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'FLAG_ESEGUI'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'STEP'
        DataType = ftInteger
      end
      item
        Name = 'TIPO'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'DESCRIZIONE'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'TOTALE'
        DataType = ftInteger
      end
      item
        Name = 'FILTRO'
        DataType = ftString
        Size = 2000
      end>
    IndexDefs = <
      item
        Name = 'DEFAULT_ORDER'
      end
      item
        Name = 'CHANGEINDEX'
      end>
    Params = <>
    StoreDefs = True
    Left = 208
    Top = 232
    Data = {
      C00000009619E0BD010000001800000006000000000003000000C0000B464C41
      475F455345475549010049000000010005574944544802000200140004535445
      500400010000000000045449504F010049000000010005574944544802000200
      01000B4445534352495A494F4E45010049000000010005574944544802000200
      C80006544F54414C4504000100000000000646494C54524F0200490000000100
      05574944544802000200D00701000D44454641554C545F4F5244455202008200
      00000000}
    object cdsOperazioniFLAG_ESEGUI: TStringField
      FieldName = 'FLAG_ESEGUI'
      Size = 1
    end
    object cdsOperazioniSTEP: TIntegerField
      FieldName = 'STEP'
    end
    object cdsOperazioniTIPO: TStringField
      FieldName = 'TIPO'
      Size = 1
    end
    object cdsOperazioniDESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 200
    end
    object cdsOperazioniTOTALE: TIntegerField
      FieldName = 'TOTALE'
    end
    object cdsOperazioniFILTRO: TStringField
      FieldName = 'FILTRO'
      Size = 2000
    end
  end
  object dsrOperazioni: TDataSource
    DataSet = cdsOperazioni
    Left = 264
    Top = 232
  end
end
