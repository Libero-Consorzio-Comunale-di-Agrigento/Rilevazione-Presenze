object B024FClient: TB024FClient
  Left = 0
  Top = 0
  Caption = '<B024> Client'
  ClientHeight = 540
  ClientWidth = 668
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object grpInfo: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 662
    Height = 78
    Align = alTop
    Caption = 'Informazioni ambiente'
    TabOrder = 0
    ExplicitWidth = 658
    object PageControl2: TPageControl
      Left = 2
      Top = 15
      Width = 658
      Height = 61
      ActivePage = TabSheet6
      Align = alClient
      TabOrder = 0
      ExplicitWidth = 654
      object TabSheet6: TTabSheet
        Caption = 'URL server'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 646
        ExplicitHeight = 0
        object lblWebSvc: TLabel
          Left = 8
          Top = 6
          Width = 19
          Height = 13
          Caption = 'URL'
        end
        object edtUrlWebSvc: TEdit
          Left = 45
          Top = 3
          Width = 396
          Height = 21
          ReadOnly = True
          TabOrder = 0
        end
      end
      object tabInfoServer: TTabSheet
        Caption = 'Impostazioni del server'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 646
        ExplicitHeight = 0
        object Label8: TLabel
          Left = 8
          Top = 6
          Width = 46
          Height = 13
          Caption = 'Database'
        end
        object edtLogonDB: TEdit
          Left = 69
          Top = 3
          Width = 220
          Height = 21
          ReadOnly = True
          TabOrder = 0
        end
      end
      object TabSheet4: TTabSheet
        Caption = 'Path salvati su registro'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 646
        ExplicitHeight = 0
        object lblHome: TLabel
          Left = 8
          Top = 6
          Width = 27
          Height = 13
          Caption = 'Home'
        end
        object Label10: TLabel
          Left = 295
          Top = 6
          Width = 39
          Height = 13
          Caption = 'Path log'
        end
        object edtHome: TEdit
          Left = 47
          Top = 3
          Width = 226
          Height = 21
          ReadOnly = True
          TabOrder = 0
        end
        object edtPathLog: TEdit
          Left = 354
          Top = 3
          Width = 229
          Height = 21
          ReadOnly = True
          TabOrder = 1
        end
      end
    end
  end
  object PageControl1: TPageControl
    AlignWithMargins = True
    Left = 3
    Top = 87
    Width = 662
    Height = 432
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 658
    object TabSheet1: TTabSheet
      Caption = 'Esecuzione'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 650
      ExplicitHeight = 0
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 654
        Height = 361
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 650
        object grp02GetListaRuoli: TGroupBox
          AlignWithMargins = True
          Left = 192
          Top = 2
          Width = 305
          Height = 55
          Caption = 'Parametri'
          TabOrder = 0
          object Label1: TLabel
            Left = 8
            Top = 24
            Width = 98
            Height = 13
            Caption = 'Codice componente:'
          end
          object edt00CodiceComponente: TEdit
            Left = 140
            Top = 21
            Width = 150
            Height = 21
            TabOrder = 0
            Text = 'C01'
          end
        end
        object rgpTipoRichiesta: TRadioGroup
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 182
          Height = 353
          Align = alLeft
          Caption = 'Tipo richiesta'
          TabOrder = 1
          OnClick = rgpTipoRichiestaClick
        end
        object grp00GetListaApplicativiUtente: TGroupBox
          AlignWithMargins = True
          Left = 503
          Top = 4
          Width = 307
          Height = 77
          Caption = 'Parametri'
          TabOrder = 2
          object Label7: TLabel
            Left = 8
            Top = 24
            Width = 115
            Height = 13
            Caption = 'Codice amministrazione:'
          end
          object Label11: TLabel
            Left = 8
            Top = 51
            Width = 102
            Height = 13
            Caption = 'Identificativo utente:'
          end
          object edt02CodiceAmministrazione: TEdit
            Left = 140
            Top = 21
            Width = 150
            Height = 21
            TabOrder = 0
            Text = 'A01'
          end
          object edt02IdentificativoUtente: TEdit
            Left = 140
            Top = 48
            Width = 150
            Height = 21
            TabOrder = 1
            Text = 'C01'
          end
        end
        object grp01GetListaUnita: TGroupBox
          AlignWithMargins = True
          Left = 503
          Top = 87
          Width = 307
          Height = 82
          Caption = 'Parametri'
          TabOrder = 3
          object Label12: TLabel
            Left = 8
            Top = 24
            Width = 115
            Height = 13
            Caption = 'Codice amministrazione:'
          end
          object Label13: TLabel
            Left = 8
            Top = 51
            Width = 63
            Height = 13
            Caption = 'Codice ruolo:'
          end
          object edt03CodiceAmministrazione: TEdit
            Left = 140
            Top = 21
            Width = 150
            Height = 21
            TabOrder = 0
            Text = 'A01'
          end
          object edt03CodiceRuolo: TEdit
            Left = 140
            Top = 48
            Width = 150
            Height = 21
            TabOrder = 1
            Text = 'R01'
          end
        end
        object grp03GetAbilitazioniSoggetto: TGroupBox
          AlignWithMargins = True
          Left = 192
          Top = 60
          Width = 305
          Height = 132
          Caption = 'Parametri'
          TabOrder = 4
          object Label2: TLabel
            Left = 8
            Top = 24
            Width = 69
            Height = 13
            Caption = 'Codice fiscale:'
          end
          object Label3: TLabel
            Left = 8
            Top = 51
            Width = 115
            Height = 13
            Caption = 'Codice amministrazione:'
          end
          object Label4: TLabel
            Left = 8
            Top = 78
            Width = 98
            Height = 13
            Caption = 'Codice componente:'
          end
          object Label5: TLabel
            Left = 8
            Top = 105
            Width = 75
            Height = 13
            Caption = 'Codice sistema:'
          end
          object edt01CodiceFiscale: TEdit
            Left = 140
            Top = 21
            Width = 150
            Height = 21
            TabOrder = 0
            Text = 'AAADDD70A01D205N'
          end
          object edt01CodiceAmministrazione: TEdit
            Left = 140
            Top = 48
            Width = 150
            Height = 21
            TabOrder = 1
            Text = 'A01'
          end
          object edt01CodiceComponente: TEdit
            Left = 140
            Top = 75
            Width = 150
            Height = 21
            TabOrder = 2
            Text = 'C01'
          end
          object edt01CodiceSistema: TEdit
            Left = 140
            Top = 102
            Width = 150
            Height = 21
            TabOrder = 3
            Text = 'S01'
          end
        end
        object grp04SetAbilitazioniSoggetto: TGroupBox
          AlignWithMargins = True
          Left = 816
          Top = 2
          Width = 281
          Height = 351
          Caption = 'Parametri'
          TabOrder = 5
          object Label6: TLabel
            Left = 8
            Top = 24
            Width = 69
            Height = 13
            Caption = 'Codice fiscale:'
          end
          object Label14: TLabel
            Left = 8
            Top = 51
            Width = 49
            Height = 13
            Caption = 'Cognome:'
          end
          object Label15: TLabel
            Left = 8
            Top = 78
            Width = 31
            Height = 13
            Caption = 'Nome:'
          end
          object Label16: TLabel
            Left = 8
            Top = 105
            Width = 28
            Height = 13
            Caption = 'Email:'
          end
          object Label17: TLabel
            Left = 8
            Top = 132
            Width = 46
            Height = 13
            Caption = 'Telefono:'
          end
          object Label18: TLabel
            Left = 8
            Top = 159
            Width = 115
            Height = 13
            Caption = 'Codice amministrazione:'
          end
          object Label19: TLabel
            Left = 8
            Top = 186
            Width = 98
            Height = 13
            Caption = 'Codice componente:'
          end
          object Label20: TLabel
            Left = 8
            Top = 213
            Width = 63
            Height = 13
            Caption = 'Codice ruolo:'
          end
          object Label21: TLabel
            Left = 8
            Top = 240
            Width = 75
            Height = 13
            Caption = 'Codice sistema:'
          end
          object Label22: TLabel
            Left = 8
            Top = 267
            Width = 63
            Height = 13
            Caption = 'Codice unit'#224':'
          end
          object Label23: TLabel
            Left = 8
            Top = 294
            Width = 129
            Height = 13
            Caption = 'Codice tipo autorizzazione:'
          end
          object Label24: TLabel
            Left = 8
            Top = 321
            Width = 127
            Height = 13
            Caption = 'Data decorrenza / revoca:'
          end
          object edt04CodiceFiscale: TEdit
            Left = 140
            Top = 21
            Width = 150
            Height = 21
            TabOrder = 0
            Text = 'AAADDD70A01D205N'
          end
          object edt04Cognome: TEdit
            Left = 140
            Top = 48
            Width = 150
            Height = 21
            TabOrder = 1
            Text = 'A01'
          end
          object edt04Nome: TEdit
            Left = 140
            Top = 75
            Width = 150
            Height = 21
            TabOrder = 2
            Text = 'A01'
          end
          object edt04Email: TEdit
            Left = 140
            Top = 102
            Width = 150
            Height = 21
            TabOrder = 3
            Text = 'A01'
          end
          object edt04Telefono: TEdit
            Left = 140
            Top = 129
            Width = 150
            Height = 21
            TabOrder = 4
            Text = 'A01'
          end
          object edt04CodiceAmministrazione: TEdit
            Left = 140
            Top = 156
            Width = 150
            Height = 21
            TabOrder = 5
            Text = 'A01'
          end
          object edt04CodiceComponente: TEdit
            Left = 140
            Top = 183
            Width = 150
            Height = 21
            TabOrder = 6
            Text = 'C01'
          end
          object edt04CodiceRuolo: TEdit
            Left = 140
            Top = 210
            Width = 150
            Height = 21
            TabOrder = 7
            Text = 'R01'
          end
          object edt04CodiceSistema: TEdit
            Left = 140
            Top = 237
            Width = 150
            Height = 21
            TabOrder = 8
            Text = 'S01'
          end
          object edt04CodiceUnita: TEdit
            Left = 140
            Top = 264
            Width = 150
            Height = 21
            TabOrder = 9
            Text = 'U01'
          end
          object edt04CodiceTipoAutorizzazione: TEdit
            Left = 140
            Top = 291
            Width = 150
            Height = 21
            TabOrder = 10
            Text = '0/1'
          end
          object edt04DataDecorrenzaORevoca: TEdit
            Left = 140
            Top = 318
            Width = 150
            Height = 21
            TabOrder = 11
            Text = '2018-03-01'
          end
        end
        object grp05ModificaAnagrafica: TGroupBox
          AlignWithMargins = True
          Left = 192
          Top = 198
          Width = 457
          Height = 171
          Caption = 'Parametri'
          TabOrder = 6
          object Label25: TLabel
            Left = 8
            Top = 24
            Width = 69
            Height = 13
            Caption = 'Codice fiscale:'
          end
          object Label26: TLabel
            Left = 8
            Top = 51
            Width = 49
            Height = 13
            Caption = 'Cognome:'
          end
          object Label27: TLabel
            Left = 8
            Top = 78
            Width = 31
            Height = 13
            Caption = 'Nome:'
          end
          object Label28: TLabel
            Left = 8
            Top = 105
            Width = 28
            Height = 13
            Caption = 'Email:'
          end
          object Label29: TLabel
            Left = 8
            Top = 132
            Width = 46
            Height = 13
            Caption = 'Telefono:'
          end
          object edt05CodiceFiscaleOld: TEdit
            Left = 140
            Top = 21
            Width = 150
            Height = 21
            TabOrder = 0
            Text = 'AAADDD70A01D205N'
          end
          object edt05CognomeOld: TEdit
            Left = 140
            Top = 48
            Width = 150
            Height = 21
            TabOrder = 1
            Text = 'A01'
          end
          object edt05NomeOld: TEdit
            Left = 140
            Top = 75
            Width = 150
            Height = 21
            TabOrder = 2
            Text = 'A01'
          end
          object edt05EmailOld: TEdit
            Left = 140
            Top = 102
            Width = 150
            Height = 21
            TabOrder = 3
            Text = 'A01'
          end
          object edt05TelefonoOld: TEdit
            Left = 140
            Top = 129
            Width = 150
            Height = 21
            TabOrder = 4
            Text = 'A01'
          end
          object edt05CodiceFiscaleNew: TEdit
            Left = 297
            Top = 21
            Width = 150
            Height = 21
            TabOrder = 5
            Text = 'AAADDD70A01D205N'
          end
          object edt05CognomeNew: TEdit
            Left = 297
            Top = 48
            Width = 150
            Height = 21
            TabOrder = 6
            Text = 'A01'
          end
          object edt05NomeNew: TEdit
            Left = 297
            Top = 75
            Width = 150
            Height = 21
            TabOrder = 7
            Text = 'A01'
          end
          object edt05EmailNew: TEdit
            Left = 297
            Top = 102
            Width = 150
            Height = 21
            TabOrder = 8
            Text = 'A01'
          end
          object edt05TelefonoNew: TEdit
            Left = 297
            Top = 129
            Width = 150
            Height = 21
            TabOrder = 9
            Text = 'A01'
          end
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 361
        Width = 654
        Height = 43
        Align = alBottom
        TabOrder = 1
        ExplicitWidth = 650
        object Label9: TLabel
          Left = 10
          Top = 14
          Width = 61
          Height = 13
          Caption = 'Elaborazioni:'
        end
        object SpinEdit1: TSpinEdit
          Left = 80
          Top = 11
          Width = 58
          Height = 22
          MaxValue = 500
          MinValue = 1
          TabOrder = 0
          Value = 1
        end
        object Button1: TButton
          AlignWithMargins = True
          Left = 186
          Top = 4
          Width = 464
          Height = 35
          Align = alRight
          Caption = 'Esegui'
          TabOrder = 1
          OnClick = Button1Click
          ExplicitLeft = 182
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Output'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 650
      ExplicitHeight = 0
      object memOutput: TMemo
        Left = 0
        Top = 0
        Width = 654
        Height = 404
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        Lines.Strings = (
          'memOutput')
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
        WordWrap = False
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Output server'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 650
      ExplicitHeight = 0
      object Memo1: TMemo
        Left = 0
        Top = 0
        Width = 654
        Height = 404
        Align = alClient
        Lines.Strings = (
          'Memo1')
        TabOrder = 0
        ExplicitWidth = 650
      end
    end
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 522
    Width = 668
    Height = 18
    Align = alBottom
    DoubleBuffered = True
    ParentDoubleBuffered = False
    Smooth = True
    Step = 1
    TabOrder = 2
    ExplicitWidth = 664
  end
  object IdSoapClientHTTP1: TIdSoapClientHTTP
    Active = True
    DefaultNamespace = 'urn:nevrona.com/indysoap/v1/'
    EncodingOptions = [seoUseCrLf, seoCheckStrings, seoReferences, seoRequireTypes]
    EncodingType = etIdAutomatic
    ITIResourceName = 'B024UADSCatanzaroIntf'
    ITISource = islResource
    RTTINamesType = rntInclude
    SessionSettings.SessionPolicy = sspNoSessions
    SessionSettings.AutoAcceptSessions = False
    WsdlOptions.UseCategories = False
    XMLProvider = xpOpenXML
    GarbageCollectObjects = True
    SoapVersion = IdSoapV1_1
    SoapURL = 'http://localhost:8080/soap/'
    Compression = False
    Left = 72
    Top = 168
  end
end
