object Form1: TForm1
  Left = 0
  Top = 0
  Caption = '<B020> Test WebServices'
  ClientHeight = 443
  ClientWidth = 530
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 530
    Height = 443
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    ExplicitHeight = 447
    object TabSheet1: TTabSheet
      Caption = 'Dati richiesta'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 419
      object rgpTipoRichiesta: TRadioGroup
        Left = 3
        Top = 66
        Width = 182
        Height = 133
        Caption = 'Tipo richiesta'
        ItemIndex = 0
        Items.Strings = (
          'echoDouble'
          'cartellino PDF'
          'dati assenze'
          'anomalie conteggi')
        TabOrder = 1
        OnClick = rgpTipoRichiestaClick
      end
      object grpParametri: TGroupBox
        Left = 3
        Top = 203
        Width = 510
        Height = 208
        Caption = 'Parametri richiesta'
        TabOrder = 3
        object Label3: TLabel
          Left = 12
          Top = 79
          Width = 79
          Height = 13
          Caption = 'Matricola / Progr'
        end
        object Label4: TLabel
          Left = 12
          Top = 106
          Width = 15
          Height = 13
          Caption = 'Dal'
        end
        object Label5: TLabel
          Left = 12
          Top = 133
          Width = 9
          Height = 13
          Caption = 'Al'
        end
        object Label6: TLabel
          Left = 12
          Top = 159
          Width = 56
          Height = 13
          Caption = 'Parametrizz'
        end
        object Label7: TLabel
          Left = 12
          Top = 183
          Width = 16
          Height = 13
          Caption = 'File'
        end
        object Label2: TLabel
          Left = 12
          Top = 52
          Width = 13
          Height = 13
          Caption = 'DB'
        end
        object Label1: TLabel
          Left = 12
          Top = 25
          Width = 38
          Height = 13
          Caption = 'Azienda'
        end
        object edtMatricolaProgressivo: TEdit
          Left = 105
          Top = 76
          Width = 264
          Height = 21
          TabOrder = 2
          Text = '4'
        end
        object edtData1: TEdit
          Left = 105
          Top = 103
          Width = 264
          Height = 21
          TabOrder = 3
          Text = '01/01/2009'
        end
        object edtData2: TEdit
          Left = 105
          Top = 130
          Width = 264
          Height = 21
          TabOrder = 4
          Text = '31/01/2009'
        end
        object edtParametrizzazione: TEdit
          Left = 105
          Top = 156
          Width = 264
          Height = 21
          TabOrder = 5
          Text = 'STD'
        end
        object edtFilePdf: TEdit
          Left = 105
          Top = 180
          Width = 264
          Height = 21
          TabOrder = 6
          Text = 'C:\Alberto\_Alberto_SOAP_New\CART_WS.PDF'
        end
        object edtDatabase: TEdit
          Left = 105
          Top = 49
          Width = 112
          Height = 21
          TabOrder = 1
          Text = 'IRIS9.WORLD'
        end
        object edtAzienda: TEdit
          Left = 105
          Top = 22
          Width = 112
          Height = 21
          TabOrder = 0
          Text = 'AZIN'
        end
      end
      object grpInfo: TGroupBox
        Left = 3
        Top = -2
        Width = 510
        Height = 67
        Caption = 'Dati del registro'
        TabOrder = 0
        object Label8: TLabel
          Left = 12
          Top = 18
          Width = 46
          Height = 13
          Caption = 'Database'
        end
        object lblHome: TLabel
          Left = 12
          Top = 43
          Width = 27
          Height = 13
          Caption = 'Home'
        end
        object Label10: TLabel
          Left = 219
          Top = 43
          Width = 42
          Height = 13
          Caption = 'Path_log'
        end
        object lblWebSvc: TLabel
          Left = 219
          Top = 18
          Width = 19
          Height = 13
          Caption = 'URL'
        end
        object lblIIS: TLabel
          Left = 461
          Top = 18
          Width = 14
          Height = 13
          Caption = 'IIS'
        end
        object edtLogonDB: TEdit
          Left = 64
          Top = 15
          Width = 147
          Height = 21
          ReadOnly = True
          TabOrder = 0
        end
        object edtHome: TEdit
          Left = 64
          Top = 40
          Width = 147
          Height = 21
          ReadOnly = True
          TabOrder = 1
        end
        object edtPathLog: TEdit
          Left = 264
          Top = 40
          Width = 236
          Height = 21
          ReadOnly = True
          TabOrder = 3
        end
        object edtUrlWebSvc: TEdit
          Left = 264
          Top = 15
          Width = 190
          Height = 21
          ReadOnly = True
          TabOrder = 2
        end
        object edtIIS: TEdit
          Left = 479
          Top = 15
          Width = 21
          Height = 21
          ReadOnly = True
          TabOrder = 4
        end
      end
      object grpEsecuzione: TGroupBox
        Left = 191
        Top = 66
        Width = 322
        Height = 133
        Caption = 'Esecuzione'
        TabOrder = 2
        object Label9: TLabel
          Left = 9
          Top = 83
          Width = 85
          Height = 13
          Caption = 'Num. elaborazioni'
        end
        object lblConfronto: TLabel
          Left = 9
          Top = 111
          Width = 53
          Height = 13
          Caption = 'Confronto:'
          Visible = False
        end
        object Button1: TButton
          Left = 231
          Top = 16
          Width = 79
          Height = 25
          Caption = 'Esegui'
          TabOrder = 1
          OnClick = Button1Click
        end
        object SpinEdit1: TSpinEdit
          Left = 103
          Top = 80
          Width = 58
          Height = 22
          MaxValue = 500
          MinValue = 1
          TabOrder = 0
          Value = 1
        end
        object chkNormale: TCheckBox
          Left = 9
          Top = 43
          Width = 97
          Height = 17
          Caption = 'Normale'
          TabOrder = 3
          OnClick = chkWebServiceClick
        end
        object chkWebService: TCheckBox
          Left = 9
          Top = 16
          Width = 97
          Height = 17
          Caption = 'Web Service'
          Checked = True
          State = cbChecked
          TabOrder = 2
          OnClick = chkWebServiceClick
        end
        object ProgressBar1: TProgressBar
          Left = 172
          Top = 82
          Width = 138
          Height = 18
          TabOrder = 4
        end
        object edtConfronto: TEdit
          Left = 70
          Top = 108
          Width = 59
          Height = 21
          ReadOnly = True
          TabOrder = 5
          Visible = False
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Output webservice'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 419
      object memOutputSvc: TMemo
        Left = 0
        Top = 0
        Width = 522
        Height = 381
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
        ExplicitHeight = 385
      end
      object Panel1: TPanel
        Left = 0
        Top = 381
        Width = 522
        Height = 34
        Align = alBottom
        TabOrder = 1
        ExplicitTop = 385
        DesignSize = (
          522
          34)
        object btnSaveFile: TButton
          Left = 423
          Top = 5
          Width = 97
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Salva su file...'
          TabOrder = 0
          OnClick = btnSaveFileClick
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Output normale'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 419
      object memOutputNorm: TMemo
        Left = 0
        Top = 0
        Width = 522
        Height = 381
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
        ExplicitHeight = 385
      end
      object Panel2: TPanel
        Left = 0
        Top = 381
        Width = 522
        Height = 34
        Align = alBottom
        TabOrder = 1
        ExplicitTop = 385
        DesignSize = (
          522
          34)
        object btnSaveFile2: TButton
          Left = 423
          Top = 5
          Width = 97
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Salva su file...'
          TabOrder = 0
          OnClick = btnSaveFileClick
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Log'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 419
      object memLog: TMemo
        Left = 0
        Top = 0
        Width = 522
        Height = 381
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
        ExplicitHeight = 385
      end
      object Panel3: TPanel
        Left = 0
        Top = 381
        Width = 522
        Height = 34
        Align = alBottom
        TabOrder = 1
        ExplicitTop = 385
        DesignSize = (
          522
          34)
        object Button2: TButton
          Left = 423
          Top = 5
          Width = 97
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Cancella log'
          TabOrder = 0
          OnClick = Button2Click
        end
      end
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '*.xml'
    FileName = 'Output.xml'
    Filter = 'File XML (*.xml)|*.xml|Tutti i file (*.*)|*.*'#39
    InitialDir = 'c:\'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 328
  end
end
