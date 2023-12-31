object A004FRecapitoVisFiscali: TA004FRecapitoVisFiscali
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = '<A004> Recapito alternativo per visite fiscali'
  ClientHeight = 545
  ClientWidth = 579
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
  object lblInfo: TLabel
    AlignWithMargins = True
    Left = 6
    Top = 485
    Width = 570
    Height = 29
    Margins.Left = 6
    Margins.Top = 6
    Margins.Bottom = 0
    Align = alBottom
    AutoSize = False
    Caption = 
      'Compilare questa scheda per specificare un domicilio alternativo' +
      ' da comunicare alla medicina legale ove effettuare la visita fis' +
      'cale.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
    ExplicitTop = 457
    ExplicitWidth = 509
  end
  object grpVisiteFiscali: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 573
    Height = 238
    Margins.Bottom = 0
    Align = alTop
    Caption = 'Domicilio per visite fiscali'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      573
      238)
    object lblComune: TLabel
      Left = 8
      Top = 44
      Width = 42
      Height = 13
      Caption = 'Comune:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblCap: TLabel
      Left = 8
      Top = 70
      Width = 22
      Height = 13
      Caption = 'Cap:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblIndirizzo: TLabel
      Left = 8
      Top = 92
      Width = 41
      Height = 13
      Caption = 'Indirizzo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblTelefono: TLabel
      Left = 8
      Top = 141
      Width = 45
      Height = 13
      Caption = 'Telefono:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblNote: TLabel
      Left = 8
      Top = 166
      Width = 26
      Height = 13
      Caption = 'Note:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblNominativo: TLabel
      Left = 8
      Top = 20
      Width = 56
      Height = 13
      Caption = 'Nominativo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblDettagliIndirizzo: TLabel
      Left = 8
      Top = 116
      Width = 79
      Height = 13
      Caption = 'Dettagli indirizzo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object edtComune: TEdit
      Left = 93
      Top = 41
      Width = 421
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 60
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object edtIndirizzo: TEdit
      Left = 93
      Top = 89
      Width = 469
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 80
      ParentFont = False
      TabOrder = 5
    end
    object edtTelefono: TEdit
      Left = 93
      Top = 138
      Width = 141
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 15
      ParentFont = False
      TabOrder = 7
    end
    object edtCap: TMaskEdit
      Left = 93
      Top = 65
      Width = 41
      Height = 21
      EditMask = '00000;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 4
      Text = '     '
    end
    object btnComuni: TBitBtn
      Left = 515
      Top = 40
      Width = 19
      Height = 21
      Hint = 'Scelta comune alternativo per il recapito'
      Anchors = [akTop, akRight]
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnComuniClick
    end
    object btnGomma: TBitBtn
      Left = 537
      Top = 39
      Width = 25
      Height = 23
      Hint = 'Pulisce i dati del domicilio alternativo'
      Anchors = [akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        42020000424D4202000000000000420000002800000010000000100000000100
        1000030000000002000000000000000000000000000000000000007C0000E003
        00001F0000001F7C00000000000000001F7C0000000000001F7C1F7C1F7C1F7C
        1F7C1F7C1F7C000000000000000000000000000000001F7C1F7C1F7C00001F7C
        1F7C1F7C1F7C000000001F7C1F7C0000000000001F7C1F7C00001F7C1F7C1F7C
        1F7C1F7C1F7C000000001F7C1F7C1F7C000000001F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C000000001F7C1F7C000000001F7C000000001F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C000000001F7C00001F7C00000040004000001F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C00001F7C0000007C007C007C004000001F7C
        1F7C1F7C1F7C1F7C000000001F7C1F7C1F7C0000007C007C007C007C00400000
        1F7C1F7C1F7C1F7C000000001F7C00001F7C1F7C0000007C007C007C00000042
        00001F7C1F7C1F7C1F7C000000001F7C00001F7C1F7C0000007C0000E07F0000
        004200001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000E07F0000E07F
        0000004200001F7C1F7C1F7C1F7C00001F7C1F7C1F7C1F7C1F7C0000E07F0000
        E07F004200421F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000E07F
        E07FE07F00421F7C1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000
        E07FE07FE07F1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        0000E07FE07F1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C0000E07F}
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = btnGommaClick
    end
    object MemoNote: TMemo
      Left = 93
      Top = 163
      Width = 469
      Height = 68
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Lines.Strings = (
        'MemoNote')
      ParentFont = False
      TabOrder = 8
    end
    object edtNominativo: TEdit
      Left = 93
      Top = 17
      Width = 469
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 80
      ParentFont = False
      TabOrder = 0
    end
    object edtDettagliIndirizzo: TEdit
      Left = 93
      Top = 113
      Width = 469
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 50
      ParentFont = False
      TabOrder = 6
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 514
    Width = 579
    Height = 31
    Margins.Bottom = 0
    Align = alBottom
    TabOrder = 4
    object btnOk: TBitBtn
      Left = 201
      Top = 3
      Width = 75
      Height = 25
      Caption = 'OK'
      Default = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      OnClick = btnOkClick
    end
    object btnCancel: TBitBtn
      Left = 297
      Top = 3
      Width = 75
      Height = 25
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Kind = bkCancel
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
    end
  end
  object grpMedLegale: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 244
    Width = 573
    Height = 44
    Margins.Bottom = 0
    Align = alTop
    Caption = 'Medicina legale di competenza'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object lblMedicinaLegale: TLabel
      Left = 8
      Top = 21
      Width = 58
      Height = 13
      Caption = 'Med. legale:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dtxtMedicinaLegale: TDBText
      Left = 193
      Top = 21
      Width = 92
      Height = 13
      AutoSize = True
      DataField = 'DESCRIZIONE'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dcmbMedicineLegali: TDBLookupComboBox
      Left = 93
      Top = 18
      Width = 94
      Height = 21
      DropDownWidth = 300
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      KeyField = 'CODICE'
      ListField = 'CODICE;DESCRIZIONE'
      ParentFont = False
      TabOrder = 0
    end
  end
  object grpEsenzione: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 291
    Width = 573
    Height = 89
    Margins.Bottom = 0
    Align = alTop
    Caption = 'Esenzione'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object lblTipoEsenzione: TLabel
      Left = 8
      Top = 17
      Width = 24
      Height = 13
      Caption = 'Tipo:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblDataEsenzione: TLabel
      Left = 8
      Top = 41
      Width = 26
      Height = 13
      Caption = 'Data:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblOperatoreEsenzione: TLabel
      Left = 8
      Top = 65
      Width = 50
      Height = 13
      Caption = 'Operatore:'
    end
    object cmbTipoEsenzione: TComboBox
      Left = 93
      Top = 14
      Width = 141
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 50
      ParentFont = False
      TabOrder = 0
      OnChange = cmbTipoEsenzioneChange
    end
    object edtOperatoreEsenzione: TEdit
      Left = 93
      Top = 62
      Width = 141
      Height = 21
      Color = clBtnFace
      DoubleBuffered = False
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 15
      ParentDoubleBuffered = False
      ParentFont = False
      TabOrder = 1
    end
    object edtDataEsenzione: TEdit
      Left = 93
      Top = 38
      Width = 68
      Height = 21
      Color = clBtnFace
      DoubleBuffered = False
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 15
      ParentDoubleBuffered = False
      ParentFont = False
      TabOrder = 2
    end
  end
  object grpRecapitiCertINPS: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 383
    Width = 573
    Height = 96
    Margins.Bottom = 0
    Align = alClient
    Caption = 'Recapiti registrati sui certificati INPS'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object dgrdRecapitiCertINPS: TDBGrid
      AlignWithMargins = True
      Left = 5
      Top = 18
      Width = 563
      Height = 73
      Align = alClient
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlue
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
end
