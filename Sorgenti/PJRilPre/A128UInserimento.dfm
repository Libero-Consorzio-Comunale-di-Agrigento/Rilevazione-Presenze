object A128FInserimento: TA128FInserimento
  Left = 353
  Top = 191
  BorderStyle = bsSingle
  Caption = '<A128> Gestione mensile'
  ClientHeight = 401
  ClientWidth = 320
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 370
    Width = 320
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object BtnOK: TBitBtn
      Left = 11
      Top = 4
      Width = 75
      Height = 25
      Caption = '&Inserisci'
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
      TabOrder = 0
      OnClick = BtnOKClick
    end
    object BtnAnnulla: TBitBtn
      Left = 218
      Top = 4
      Width = 75
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 1
    end
    object btnElimina: TBitBtn
      Left = 96
      Top = 4
      Width = 75
      Height = 25
      Caption = '&Cancella'
      Glyph.Data = {
        42020000424D4202000000000000420000002800000010000000100000000100
        1000030000000002000000000000000000000000000000000000007C0000E003
        00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C00401F7C1F7C1F7C1F7C1F7C00401F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C007C007C00401F7C1F7C1F7C1F7C1F7C1F7C
        1F7C007C1F7C1F7C1F7C1F7C1F7C0040007C00401F7C1F7C1F7C1F7C1F7C1F7C
        00401F7C1F7C1F7C1F7C1F7C1F7C1F7C0040007C007C1F7C1F7C1F7C1F7C007C
        00401F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0040007C00401F7C1F7C0040007C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0040007C0040007C007C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C007C0040007C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C007C0040007C004000401F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0040007C00401F7C1F7C007C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C007C0040007C00401F7C1F7C1F7C1F7C0040
        007C1F7C1F7C1F7C1F7C1F7C0040007C0040007C1F7C1F7C1F7C1F7C1F7C1F7C
        0040007C1F7C1F7C1F7C1F7C007C00401F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C0040007C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C}
      TabOrder = 2
      OnClick = btnEliminaClick
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 320
    Height = 217
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 39
      Width = 55
      Height = 13
      Caption = 'Dipendente'
      FocusControl = DBLookupProgressivo
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 181
      Top = 2
      Width = 31
      Height = 13
      Caption = 'Badge'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LContratto: TLabel
      Left = 8
      Top = 79
      Width = 46
      Height = 13
      Caption = 'Contratto:'
    end
    object Label4: TLabel
      Left = 8
      Top = 2
      Width = 43
      Height = 13
      Caption = 'Matricola'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblPartTime: TLabel
      Left = 8
      Top = 96
      Width = 44
      Height = 13
      Caption = 'Part-time:'
    end
    object DBLookupProgressivo: TDBLookupComboBox
      Left = 8
      Top = 54
      Width = 305
      Height = 21
      DropDownWidth = 450
      KeyField = 'PROGRESSIVO'
      ListField = 'MATRICOLA;CHR_BADGE;NOMINATIVO'
      ListFieldIndex = 2
      PopupMenu = PopupMenu3
      TabOrder = 2
      OnCloseUp = DBLookupProgressivoCloseUp
      OnKeyDown = dCmbMatricolaKeyDown
      OnKeyUp = DBLookupProgressivoKeyUp
    end
    object dCmbMatricola: TDBLookupComboBox
      Left = 8
      Top = 17
      Width = 116
      Height = 21
      DropDownWidth = 450
      KeyField = 'PROGRESSIVO'
      ListField = 'MATRICOLA;CHR_BADGE;NOMINATIVO'
      PopupMenu = PopupMenu3
      TabOrder = 0
      OnCloseUp = DBLookupProgressivoCloseUp
      OnKeyDown = dCmbMatricolaKeyDown
      OnKeyUp = DBLookupProgressivoKeyUp
    end
    object dCmbBadge: TDBLookupComboBox
      Left = 181
      Top = 17
      Width = 132
      Height = 21
      DropDownWidth = 450
      KeyField = 'PROGRESSIVO'
      ListField = 'CHR_BADGE;MATRICOLA;NOMINATIVO'
      PopupMenu = PopupMenu3
      TabOrder = 1
      OnCloseUp = DBLookupProgressivoCloseUp
      OnKeyDown = dCmbMatricolaKeyDown
      OnKeyUp = DBLookupProgressivoKeyUp
    end
    object grpTurno1: TGroupBox
      Left = 8
      Top = 115
      Width = 150
      Height = 94
      Caption = 'Turno &1'
      TabOrder = 3
      object lblCodiceTurno: TLabel
        Left = 5
        Top = 21
        Width = 64
        Height = 13
        Caption = 'Codice Turno'
        FocusControl = DBLookupTurno1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblOraInizioTurno1: TLabel
        Left = 5
        Top = 45
        Width = 44
        Height = 13
        Caption = 'Ora Inizio'
        FocusControl = DBLookupTurno1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblOraFineTurno1: TLabel
        Left = 5
        Top = 70
        Width = 40
        Height = 13
        Caption = 'Ora Fine'
        FocusControl = DBLookupTurno1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object DBLookupTurno1: TDBLookupComboBox
        Left = 74
        Top = 17
        Width = 70
        Height = 21
        DataField = 'Turno1'
        DropDownWidth = 350
        KeyField = 'CODICE'
        ListField = 'CODICE;DESCRIZIONE'
        PopupMenu = PopupMenu1
        TabOrder = 0
        OnKeyDown = dCmbMatricolaKeyDown
      end
      object dEdtOraInizioTurno1: TDBEdit
        Left = 74
        Top = 42
        Width = 70
        Height = 21
        DataField = 'ORAINIZIO_TURNO1'
        TabOrder = 1
        OnChange = PulisciValore
      end
      object dEdtOraFineTurno1: TDBEdit
        Left = 74
        Top = 67
        Width = 70
        Height = 21
        DataField = 'ORAFINE_TURNO1'
        TabOrder = 2
        OnChange = PulisciValore
      end
    end
    object grpTurno2: TGroupBox
      Left = 163
      Top = 115
      Width = 150
      Height = 94
      Caption = 'Turno &2'
      TabOrder = 4
      object lblCodiceTurno2: TLabel
        Left = 5
        Top = 21
        Width = 64
        Height = 13
        Caption = 'Codice Turno'
        FocusControl = DBLookupTurno2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblOraFineTurno2: TLabel
        Left = 5
        Top = 70
        Width = 40
        Height = 13
        Caption = 'Ora Fine'
        FocusControl = DBLookupTurno1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblOraInizioTurno2: TLabel
        Left = 5
        Top = 45
        Width = 44
        Height = 13
        Caption = 'Ora Inizio'
        FocusControl = DBLookupTurno1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object dEdtOraFineTurno2: TDBEdit
        Left = 74
        Top = 67
        Width = 70
        Height = 21
        DataField = 'ORAFINE_TURNO2'
        TabOrder = 2
        OnChange = PulisciValore
      end
      object dEdtOraInizioTurno2: TDBEdit
        Left = 74
        Top = 42
        Width = 70
        Height = 21
        DataField = 'ORAINIZIO_TURNO2'
        TabOrder = 1
        OnChange = PulisciValore
      end
      object DBLookupTurno2: TDBLookupComboBox
        Left = 74
        Top = 18
        Width = 70
        Height = 21
        DataField = 'Turno2'
        DropDownWidth = 350
        KeyField = 'CODICE'
        ListField = 'CODICE;DESCRIZIONE'
        PopupMenu = PopupMenu1
        TabOrder = 0
        OnKeyDown = dCmbMatricolaKeyDown
      end
    end
  end
  object CheckListBox1: TCheckListBox
    Left = 0
    Top = 217
    Width = 320
    Height = 153
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ItemHeight = 14
    ParentFont = False
    PopupMenu = PopupMenu2
    TabOrder = 1
  end
  object PopupMenu1: TPopupMenu
    Left = 468
    Top = 73
    object Nuovoelemento1: TMenuItem
      Caption = 'Accedi'
      OnClick = Nuovoelemento1Click
    end
  end
  object PopupMenu3: TPopupMenu
    Left = 387
    Top = 59
    object Datianagrafici1: TMenuItem
      Caption = 'Dati anagrafici'
      OnClick = Datianagrafici1Click
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 444
    Top = 114
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      OnClick = Annullatutto1Click
    end
    object Annullatutto1: TMenuItem
      Caption = 'Annulla tutto'
      OnClick = Annullatutto1Click
    end
  end
end
