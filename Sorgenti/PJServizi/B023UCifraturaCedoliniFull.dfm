inherited B023FCifraturaCedoliniFull: TB023FCifraturaCedoliniFull
  ClientHeight = 440
  ClientWidth = 487
  OnShow = FormShow
  ExplicitWidth = 503
  ExplicitHeight = 478
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBottom: TPanel
    Top = 375
    Width = 487
    ExplicitTop = 375
    ExplicitWidth = 487
    inherited prbProgress: TProgressBar
      Width = 485
      ExplicitWidth = 485
    end
    inherited StatusBar: TStatusBar
      Width = 485
      ExplicitWidth = 485
    end
    inherited btnEsegui: TBitBtn
      Caption = '&Esegui'
    end
    inherited btnChiudi: TBitBtn
      Left = 340
      ExplicitLeft = 340
    end
  end
  inherited pnlMain: TPanel
    Width = 487
    Height = 375
    ExplicitWidth = 487
    ExplicitHeight = 375
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 487
    Height = 375
    Align = alClient
    TabOrder = 2
    object lblNuoviFile: TLabel
      Left = 41
      Top = 308
      Width = 69
      Height = 13
      Caption = 'Nomi nuovi file'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object grpDirectory: TGroupBox
      Left = 15
      Top = 15
      Width = 458
      Height = 146
      Caption = 'Posizione file da cifrare'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object lblMese: TLabel
        Left = 32
        Top = 69
        Width = 26
        Height = 13
        Caption = 'Mese'
      end
      object lblAnno: TLabel
        Left = 107
        Top = 69
        Width = 25
        Height = 13
        Caption = 'Anno'
      end
      object lblDirectory: TLabel
        Left = 13
        Top = 119
        Width = 99
        Height = 13
        Caption = 'Percorso dei file PDF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object spMese: TSpinEdit
        Left = 64
        Top = 66
        Width = 37
        Height = 22
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxValue = 12
        MinValue = 1
        ParentFont = False
        TabOrder = 3
        Value = 1
      end
      object spAnno: TSpinEdit
        Left = 135
        Top = 66
        Width = 51
        Height = 22
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxValue = 3000
        MinValue = 1900
        ParentFont = False
        TabOrder = 4
        Value = 1900
      end
      object edtPath: TEdit
        Left = 118
        Top = 116
        Width = 307
        Height = 21
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        OnChange = edtPathChange
      end
      object rdbSceltaManualeDir: TRadioButton
        Left = 13
        Top = 96
        Width = 228
        Height = 17
        Caption = 'Scelta manuale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnClick = rdbSceltaManualeDirClick
      end
      object rdbDirectoryData: TRadioButton
        Left = 13
        Top = 21
        Width = 396
        Height = 17
        Caption = 
          'Cartella determinata automaticamente in base al tipo documento e' +
          ' alla data:'
        Checked = True
        TabOrder = 2
        TabStop = True
        OnClick = rdbDirectoryDataClick
      end
      object btnBrowse: TButton
        Left = 431
        Top = 115
        Width = 14
        Height = 22
        Caption = '...'
        Enabled = False
        TabOrder = 1
        OnClick = btnBrowseClick
      end
      object pnlRadioDir: TPanel
        Left = 26
        Top = 44
        Width = 255
        Height = 17
        BevelOuter = bvNone
        TabOrder = 6
        object rdbCedolini: TRadioButton
          Left = 6
          Top = 0
          Width = 80
          Height = 17
          Caption = 'Cedolini'
          Checked = True
          TabOrder = 0
          TabStop = True
          OnClick = rdbCedoliniClick
        end
        object rdbCU: TRadioButton
          Left = 81
          Top = 0
          Width = 64
          Height = 17
          Caption = 'CU'
          TabOrder = 1
          OnClick = rdbCUClick
        end
      end
    end
    object rgpHash: TRadioGroup
      Left = 15
      Top = 223
      Width = 307
      Height = 54
      Caption = 'Algoritmo di hash da applicare alla passphrase'
      Columns = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 2
      Items.Strings = (
        'Nessuno'
        'SHA-1'
        'SHA-256')
      ParentFont = False
      TabOrder = 1
    end
    object rgpOperazione: TRadioGroup
      Left = 328
      Top = 223
      Width = 145
      Height = 54
      Caption = 'Operazione'
      Columns = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Cifra'
        'Decifra')
      ParentFont = False
      TabOrder = 2
      OnClick = rgpOperazioneClick
    end
    object grpPassphrase: TGroupBox
      Left = 15
      Top = 167
      Width = 458
      Height = 50
      Caption = 'Passphrase (vuota per usare quella di default)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      object edtPassphrase: TEdit
        Left = 9
        Top = 19
        Width = 439
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
    end
    object chkSostFile: TCheckBox
      Left = 15
      Top = 284
      Width = 129
      Height = 17
      Caption = 'Sostituisci file esistenti'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 4
      OnClick = chkSostFileClick
    end
  end
  inherited btnDisattivaElaborazioni: TBitBtn
    Left = 326
    Top = 336
    TabOrder = 3
    ExplicitLeft = 326
    ExplicitTop = 336
  end
  object edtNomeNuoviFile: TEdit
    Left = 116
    Top = 305
    Width = 357
    Height = 21
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 4
    Visible = False
    OnChange = edtPathChange
  end
  object OpenDialog1: TOpenDialog
    Left = 16
    Top = 336
  end
end
