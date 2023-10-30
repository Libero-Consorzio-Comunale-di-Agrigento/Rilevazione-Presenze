object B016FSetup: TB016FSetup
  Left = 0
  Top = 0
  HelpContext = 9016000
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = '<B016> Setup IrisWIN'
  ClientHeight = 547
  ClientWidth = 679
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 679
    Height = 528
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Download pacchetti disponibili'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label2: TLabel
        Left = 7
        Top = 1
        Width = 195
        Height = 13
        Caption = 'Indicare il percorso dove scaricare i files:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 7
        Top = 39
        Width = 37
        Height = 13
        Caption = 'Utente:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 7
        Top = 77
        Width = 50
        Height = 13
        Caption = 'Password:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object btnLogin: TButton
        Left = 7
        Top = 119
        Width = 186
        Height = 25
        Caption = 'Connetti al sito'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = btnLoginClick
      end
      object edtDownloadPath: TEdit
        Left = 7
        Top = 15
        Width = 394
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object btnDownloadPath: TButton
        Left = 403
        Top = 14
        Width = 20
        Height = 23
        Caption = '...'
        TabOrder = 2
        OnClick = btnDownloadPathClick
      end
      object edtUtente: TEdit
        Left = 7
        Top = 53
        Width = 186
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object edtPassword: TEdit
        Left = 7
        Top = 91
        Width = 186
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        PasswordChar = '*'
        TabOrder = 4
      end
      object btnDownload: TButton
        Left = 200
        Top = 238
        Width = 223
        Height = 25
        Caption = 'Download'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnClick = btnDownloadClick
      end
      object chklstDownloads: TCheckListBox
        Left = 200
        Top = 52
        Width = 223
        Height = 183
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 6
      end
      object StatusBar1: TStatusBar
        Left = 0
        Top = 481
        Width = 671
        Height = 19
        Panels = <
          item
            Width = 350
          end
          item
            Width = 50
          end>
      end
      object memoDownload: TMemo
        Left = 8
        Top = 150
        Width = 185
        Height = 112
        Color = cl3DLight
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 8
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Installazione pacchetti disponibili'
      ImageIndex = 1
      object Label1: TLabel
        Left = 7
        Top = 1
        Width = 178
        Height = 13
        Caption = 'Percorso dei pacchetti di installazione'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 8
        Top = 387
        Width = 96
        Height = 13
        Caption = 'Applicativi disponibili'
      end
      object Label6: TLabel
        Left = 227
        Top = 387
        Width = 79
        Height = 13
        Caption = 'Servizi disponibili'
      end
      object lstPacchetti: TListBox
        Left = 7
        Top = 252
        Width = 420
        Height = 133
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        Sorted = True
        TabOrder = 3
      end
      object edtPathPacchetti: TEdit
        Left = 7
        Top = 16
        Width = 394
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Text = 'edtPathPacchetti'
        OnExit = edtPathPacchettiExit
      end
      object btnPathPacchetti: TButton
        Left = 403
        Top = 16
        Width = 17
        Height = 22
        Caption = '...'
        TabOrder = 1
        OnClick = btnPathPacchettiClick
      end
      object memoPacchetti: TMemo
        Left = 7
        Top = 401
        Width = 218
        Height = 97
        Color = cl3DLight
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 4
      end
      object GroupBox1: TGroupBox
        Left = 7
        Top = 38
        Width = 420
        Height = 212
        Caption = 'Path di installazione'
        TabOrder = 2
        object edtPathAmministrazione: TEdit
          Left = 148
          Top = 17
          Width = 246
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Text = 'c:\irisWIN'
        end
        object btnPathAmministrazione: TButton
          Left = 396
          Top = 17
          Width = 17
          Height = 22
          Caption = '...'
          TabOrder = 2
          OnClick = btnPathAmministrazioneClick
        end
        object chkAmministrazione: TCheckBox
          Left = 13
          Top = 19
          Width = 135
          Height = 17
          Caption = 'Tools di amministrazione'
          TabOrder = 0
          OnClick = chkAmministrazioneClick
        end
        object chkIrisWIN: TCheckBox
          Left = 13
          Top = 43
          Width = 135
          Height = 17
          Caption = 'IrisWIN'
          TabOrder = 3
          OnClick = chkAmministrazioneClick
        end
        object edtPathIrisWIN: TEdit
          Left = 148
          Top = 41
          Width = 246
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          Text = 'c:\irisWIN'
        end
        object btnPathIrisWIN: TButton
          Left = 396
          Top = 41
          Width = 17
          Height = 22
          Caption = '...'
          TabOrder = 5
          OnClick = btnPathAmministrazioneClick
        end
        object chkServizi: TCheckBox
          Left = 13
          Top = 68
          Width = 135
          Height = 17
          Caption = 'Servizi'
          TabOrder = 6
          OnClick = chkAmministrazioneClick
        end
        object edtPathServizi: TEdit
          Left = 148
          Top = 66
          Width = 246
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
          Text = 'c:\irisWIN'
        end
        object btnPathServizi: TButton
          Left = 396
          Top = 66
          Width = 17
          Height = 22
          Caption = '...'
          TabOrder = 8
          OnClick = btnPathAmministrazioneClick
        end
        object chkIrisWEB: TCheckBox
          Left = 13
          Top = 92
          Width = 135
          Height = 17
          Caption = 'IrisWEB'
          TabOrder = 9
          OnClick = chkAmministrazioneClick
        end
        object edtPathIrisWEB: TEdit
          Left = 148
          Top = 90
          Width = 246
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
          Text = 'c:\irisWIN'
        end
        object btnPathIrisWEB: TButton
          Left = 396
          Top = 90
          Width = 17
          Height = 22
          Caption = '...'
          TabOrder = 11
          OnClick = btnPathAmministrazioneClick
        end
        object chkWebSvc: TCheckBox
          Left = 13
          Top = 188
          Width = 135
          Height = 17
          Caption = 'Web/Print services'
          TabOrder = 21
          OnClick = chkAmministrazioneClick
        end
        object edtPathWebSvc: TEdit
          Left = 148
          Top = 186
          Width = 246
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 22
          Text = 'c:\irisWIN'
        end
        object btnPathWebSvc: TButton
          Left = 396
          Top = 186
          Width = 17
          Height = 22
          Caption = '...'
          TabOrder = 23
          OnClick = btnPathAmministrazioneClick
        end
        object chkIrisCloud: TCheckBox
          Left = 13
          Top = 140
          Width = 135
          Height = 17
          Caption = 'IrisCloud'
          TabOrder = 15
          OnClick = chkAmministrazioneClick
        end
        object edtPathIrisCloud: TEdit
          Left = 148
          Top = 138
          Width = 246
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 16
          Text = 'c:\irisWIN'
        end
        object btnPathIrisCloud: TButton
          Left = 396
          Top = 138
          Width = 17
          Height = 22
          Caption = '...'
          TabOrder = 17
          OnClick = btnPathAmministrazioneClick
        end
        object chkIrisWEBSSO: TCheckBox
          Left = 13
          Top = 116
          Width = 135
          Height = 17
          Caption = 'IrisWEB SSO'
          TabOrder = 12
          OnClick = chkAmministrazioneClick
        end
        object edtPathIrisWEBSSO: TEdit
          Left = 148
          Top = 114
          Width = 246
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 13
          Text = 'c:\irisWIN'
        end
        object btnPathIrisWEBSSO: TButton
          Left = 396
          Top = 114
          Width = 17
          Height = 22
          Caption = '...'
          TabOrder = 14
          OnClick = btnPathAmministrazioneClick
        end
        object chkIrisAPP: TCheckBox
          Left = 13
          Top = 164
          Width = 135
          Height = 17
          Caption = 'IrisAPP'
          TabOrder = 18
          OnClick = chkAmministrazioneClick
        end
        object edtPathIrisAPP: TEdit
          Left = 148
          Top = 162
          Width = 246
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 19
          Text = 'c:\irisWIN'
        end
        object btnPathIrisAPP: TButton
          Left = 396
          Top = 162
          Width = 17
          Height = 22
          Caption = '...'
          TabOrder = 20
          OnClick = btnPathAmministrazioneClick
        end
      end
      object lstServizi: TListBox
        Left = 227
        Top = 401
        Width = 200
        Height = 97
        Color = cl3DLight
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        Sorted = True
        TabOrder = 5
      end
      object btnChiudi: TBitBtn
        Left = 439
        Top = 473
        Width = 112
        Height = 25
        Caption = '&Chiudi'
        Kind = bkClose
        NumGlyphs = 2
        TabOrder = 6
      end
      object GroupBox2: TGroupBox
        Left = 430
        Top = 38
        Width = 238
        Height = 243
        Caption = 'Azioni'
        TabOrder = 7
        object btnScompatta: TBitBtn
          Left = 8
          Top = 132
          Width = 112
          Height = 25
          Caption = 'Scompatta i files'
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000FFFFF003333333330
            FFFF0B03333333330FFF0FB03333333330FF0BFB03333333330F0FBFB0000000
            000F0BFBFBFBFB0FFFFF0FBFBFBFBF0FFFFF0BFB0000000FFFFFF000FFFFFFFF
            000FFFFFFFFFFFFFF00FFFFFFFFF0FFF0F0FFFFFFFFFF000FFFF}
          TabOrder = 5
          OnClick = btnScompattaClick
        end
        object btnB005: TBitBtn
          Left = 8
          Top = 170
          Width = 112
          Height = 25
          Caption = 'Lancia B005'
          Glyph.Data = {
            6E040000424D6E04000000000000360000002800000014000000120000000100
            1800000000003804000000000000000000000000000000000000FCFCFCFCFCFC
            FCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFC
            FCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFC
            FCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFC
            FCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFC0000
            007F7F7F3F3F3FFCFCFCFCFCFCFCFCFC000000303030505020000000000000FC
            FCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFC000000BFBFBF
            505050FCFCFCFCFCFCFCFCFCFCFCFC303000303000000000FCFCFCFCFCFCFCFC
            FCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFC606060000000FC
            FCFCFCFCFCFCFCFCFCFCFC303030303000000000FCFCFCFCFCFCFCFCFCFCFCFC
            FCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFC606060000000FCFCFCFCFC
            FCFCFCFCFCFCFC3F3F3F303000000000FCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFC
            FCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFC606060000000FCFCFCFCFCFCFCFCFC
            FCFCFC3F3F3F303030000000FCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFC
            FCFCFCFCFCFCFCFCFCFCFCFCFC606060000000FCFCFCFCFCFCFCFCFCFCFCFC3F
            3F3F202020000000FCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFC
            FCFCFCFCFCFCFCFCFC606060000000FCFCFCFCFCFCFCFCFCFCFCFC3030303030
            00000000FCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFC
            FCFCFCFCFC606060000000FCFCFCFCFCFCFCFCFCFCFCFC303000303000000000
            FCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFC0000
            00303030000000FCFCFCFCFCFCFCFCFCFCFCFC000000000000000000FCFCFCFC
            FCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFC0000303FAFDF
            006090000000FCFCFCFCFCFCFCFCFC000000AFAF70000000FCFCFCFCFCFCFCFC
            FCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFC000060006FDF0060C000
            0000FCFCFCFCFCFCFCFCFC000000AFAFAF000000FCFCFCFCFCFCFCFCFCFCFCFC
            FCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFC00006F006FCF0060C0000000FCFC
            FCFCFCFCFCFCFC0000005F5F5F000000FCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFC
            FCFCFCFCFCFCFCFCFCFCFCFCFCFC00006F007FEF0060C0000000FCFCFCFCFCFC
            FCFCFC000000000000000000FCFCFCFCFCFC000000000000FCFCFCFCFCFCFCFC
            FCFCFCFCFCFCFCFCFCFC00006F007FEF0060C00000002020202020203030305F
            5F5FAFAFAF505050000000000000707070000000FCFCFCFCFCFCFCFCFCFCFCFC
            FCFCFCFCFCFC00006F00AFDF0060C00000007F7F3F5F5F5F606060BFBF7FFFFF
            BFAFAFAFBFBFBFAFAF70303030FCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFC
            FCFC0000303F7F7F003060000000000000000000000000202020606060505050
            202020000000FCFCFCFCFCFCFCFCFCFCFCFC}
          TabOrder = 6
          OnClick = btnB005Click
        end
        object chkServiziStop: TCheckBox
          Left = 124
          Top = 53
          Width = 97
          Height = 17
          Caption = 'Servizi arrestati'
          TabOrder = 2
        end
        object chkServiziStart: TCheckBox
          Left = 124
          Top = 211
          Width = 97
          Height = 17
          Caption = 'Servizi riavviati'
          TabOrder = 9
        end
        object chkBackup: TCheckBox
          Left = 124
          Top = 88
          Width = 97
          Height = 17
          Caption = 'Backup cartelle'
          TabOrder = 4
        end
        object btnBackup: TBitBtn
          Left = 8
          Top = 84
          Width = 112
          Height = 25
          Caption = 'Backup cartelle'
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFF00000000000000FF03300000077030FF033000000770
            30FF03300000077030FF03300000000030FF03333333333330FF033000000003
            30FF03077777777030FF03077777777030FF03077777777030FF030777777770
            30FF03077777777000FF03077777777070FF00000000000000FF}
          TabOrder = 3
          OnClick = btnBackupClick
        end
        object chkAggDB: TCheckBox
          Left = 124
          Top = 174
          Width = 109
          Height = 17
          Caption = 'DB aggiornato'
          TabOrder = 7
        end
        object btnServiziStop: TBitBtn
          Left = 8
          Top = 49
          Width = 112
          Height = 25
          Hint = 'Esegue comando '#39'net stop'#39
          Caption = 'Arresta servizi'
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            04000000000080000000130B0000130B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
            FFFFFFFFF99999FFFFFFFFF999999999FFFFFF99FF707F999FFFF9999F000FF9
            99FFF9F999707FFF99FF99FF999FFFFFF99F99FFF990FFFFF99F99FFFF707FFF
            F99F99FFFF1019FFF99F99FFFF00099FF99FF99FFF000999F9FFF999FF000F99
            99FFFF999F707FF99FFFFFF999999999FFFFFFFFF99999FFFFFF}
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = btnServiziStopClick
        end
        object btnServiziStart: TBitBtn
          Left = 8
          Top = 207
          Width = 112
          Height = 25
          Hint = 'Esegue comando '#39'net start'#39
          Caption = 'Avvia servizi'
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777770000077
            777777770BF33307777700000FB300000077BFF00BF0BF333307FBBFBFBBFB33
            33070FFB330BB03000770BB3B330F0000007BFF30B30BFB33330FBB30F30FBF3
            33303FF3F330B00000073BBF330BF0300077BFFBFBFBBF333307FBB00FB0FB33
            330733303BF30000007777773FB3330777777777733000777777}
          ParentShowHint = False
          ShowHint = True
          TabOrder = 8
          OnClick = btnServiziStartClick
        end
        object chkIISReset: TCheckBox
          Left = 8
          Top = 24
          Width = 139
          Height = 17
          Hint = 
            'esegue comandi '#39'iisreset -stop / -start'#39' in fase di arresto e av' +
            'vio servizi'
          Caption = 'Consenti stop/start di IIS'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = chkIISResetClick
        end
        object chkFilesScompattati: TCheckBox
          Left = 124
          Top = 147
          Width = 101
          Height = 17
          Caption = 'Files scompattati'
          TabOrder = 10
        end
        object chkFrameworkUniGui: TCheckBox
          Left = 124
          Top = 118
          Width = 108
          Height = 28
          Caption = 'Installa framework UniGUI'
          TabOrder = 11
          WordWrap = True
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Creazione collegamenti agli applicativi'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object rgpGruppoCollegamenti: TRadioGroup
        Left = 7
        Top = 0
        Width = 169
        Height = 64
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemIndex = 0
        Items.Strings = (
          'nel gruppo'
          'sul Desktop')
        ParentFont = False
        TabOrder = 0
      end
      object chklstCollegamenti: TCheckListBox
        Left = 183
        Top = 5
        Width = 241
        Height = 173
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 1
      end
      object btnCollegamenti: TButton
        Left = 3
        Top = 153
        Width = 169
        Height = 25
        Caption = 'Crea i collegamenti'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = btnCollegamentiClick
      end
      object rgpUserCollegamenti: TRadioGroup
        Left = 7
        Top = 64
        Width = 169
        Height = 64
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemIndex = 0
        Items.Strings = (
          'per l'#39'utente corrente'
          'per tutti gli utenti')
        ParentFont = False
        TabOrder = 3
      end
      object edtGruppoSetup: TEdit
        Left = 87
        Top = 15
        Width = 81
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        Text = 'IrisWIN'
      end
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 528
    Width = 679
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object SaveDialog1: TSaveDialog
    Left = 375
    Top = 312
  end
  object PopupMenu1: TPopupMenu
    Left = 343
    Top = 312
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      OnClick = Deselezionatutto1Click
    end
    object Deselezionatutto1: TMenuItem
      Caption = 'Deseleziona tutto'
      OnClick = Deselezionatutto1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Refresh1: TMenuItem
      Caption = 'Refresh'
      OnClick = Refresh1Click
    end
  end
  object IdFTP: TIdFTP
    OnWork = IdFTPWork
    IPVersion = Id_IPv4
    Host = 'www.mondoedp.com'
    ConnectTimeout = 0
    Password = 'm2g2s8gy'
    Username = 'inod0010'
    NATKeepAlive.UseKeepAlive = False
    NATKeepAlive.IdleTimeMS = 0
    NATKeepAlive.IntervalMS = 0
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    Left = 311
    Top = 312
  end
  object msqlConnessione: TMySQLDatabase
    DatabaseName = 'mondoedp_com'
    UserName = 'inod0010'
    UserPassword = 'm2g2s8gy'
    Host = 'www.mondoedp.com'
    ConnectOptions = []
    ConnectionTimeout = 3600
    Params.Strings = (
      'Port=3306'
      'TIMEOUT=3600'
      'DatabaseName=mondoedp_com'
      'UID=inod0010'
      'Host=www.mondoedp.com'
      'PWD=m2g2s8gy')
    DatasetOptions = []
    Left = 247
    Top = 344
  end
  object selNukeUsers: TMySQLQuery
    Database = msqlConnessione
    SQL.Strings = (
      'SELECT username'
      'FROM nuke_users where '
      'username = :username and '
      'user_password = md5(:user_password)')
    Left = 279
    Top = 344
    ParamData = <
      item
        DataType = ftString
        Name = 'username'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'user_password'
        ParamType = ptInput
      end>
  end
  object selNukeDownloads: TMySQLQuery
    Database = msqlConnessione
    SQL.Strings = (
      'select title from nuke_downloads_downloads'
      'where'
      'title <> '#39#39' and '
      'title is not null and '
      'upper(title) <> '#39'B016PSETUP.EXE'#39' and'
      '(downloadenabled = '#39'*'#39' or'
      'concat('#39','#39',downloadenabled,'#39','#39') like '#39'%,:UTENTE,%'#39')')
    Left = 311
    Top = 344
  end
  object selDownloadUsers: TMySQLQuery
    Database = msqlConnessione
    RequestLive = True
    SQL.Strings = (
      'select * from nuke_downloads_downloads'
      'where title = :title')
    Left = 343
    Top = 344
    ParamData = <
      item
        DataType = ftString
        Name = 'title'
        ParamType = ptInput
      end>
  end
  object selDownloadVersione: TMySQLQuery
    Database = msqlConnessione
    SQL.Strings = (
      'select * from nuke_downloads_versione')
    Left = 375
    Top = 344
  end
end
