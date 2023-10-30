object B002FAggiornamento: TB002FAggiornamento
  Left = 11
  Top = 7
  Caption = 'Importazione e aggiornamento tabelle IRIS'
  ClientHeight = 428
  ClientWidth = 575
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 293
    Height = 428
    ActivePage = TabSheet1
    Align = alLeft
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clYellow
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    MultiLine = True
    ParentFont = False
    TabOrder = 0
    ExplicitHeight = 435
    object TabSheet1: TTabSheet
      Caption = 'Tabella di DataBase'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label10: TLabel
        Left = 0
        Top = 240
        Width = 53
        Height = 29
        AutoSize = False
        Caption = 'Campi selezionati'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clOlive
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        WordWrap = True
      end
      object Label9: TLabel
        Left = 0
        Top = 96
        Width = 39
        Height = 29
        AutoSize = False
        Caption = 'Campi originali'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clFuchsia
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        WordWrap = True
      end
      object Label5: TLabel
        Left = 56
        Top = 330
        Width = 67
        Height = 13
        Caption = 'Campi originali'
      end
      object Label6: TLabel
        Left = 18
        Top = 52
        Width = 35
        Height = 13
        Caption = 'Tabella'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 6
        Top = 12
        Width = 47
        Height = 13
        Caption = 'DataBase'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 56
        Top = 30
        Width = 3
        Height = 13
      end
      object ListBox1: TListBox
        Left = 56
        Top = 94
        Width = 145
        Height = 145
        DragMode = dmAutomatic
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clFuchsia
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 0
        OnDblClick = ListBox1DblClick
      end
      object ListBox3: TListBox
        Left = 56
        Top = 240
        Width = 145
        Height = 145
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clOlive
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 1
        OnDblClick = ListBox3DblClick
        OnDragDrop = ListBox3DragDrop
        OnDragOver = ListBox3DragOver
      end
      object ListBox5: TListBox
        Left = 201
        Top = 240
        Width = 82
        Height = 145
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clOlive
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 2
      end
      object ComboBox3: TComboBox
        Left = 56
        Top = 48
        Width = 145
        Height = 21
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 0
        ParentFont = False
        Sorted = True
        TabOrder = 3
        OnChange = ComboBox3Exit
      end
      object Button2: TButton
        Left = 200
        Top = 50
        Width = 39
        Height = 18
        Caption = 'Browse'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnClick = Button2Click
      end
      object ComboBox1: TComboBox
        Left = 56
        Top = 8
        Width = 145
        Height = 21
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 0
        ParentFont = False
        Sorted = True
        TabOrder = 5
        OnChange = ComboBox1Exit
      end
      object Button5: TButton
        Left = 240
        Top = 50
        Width = 39
        Height = 18
        Caption = 'Query'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        OnClick = Button5Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'File sequenziale'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label13: TLabel
        Left = 2
        Top = 34
        Width = 75
        Height = 13
        Caption = 'File sequenziale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object NomeFile: TEdit
        Left = 2
        Top = 50
        Width = 187
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object Button6: TButton
        Left = 188
        Top = 50
        Width = 15
        Height = 21
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = Button6Click
      end
      object BMappatura: TButton
        Left = 2
        Top = 72
        Width = 81
        Height = 23
        Caption = 'Mappatura file'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = BMappaturaClick
      end
      object BApri: TButton
        Left = 204
        Top = 50
        Width = 29
        Height = 21
        Caption = 'Apri'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = BApriClick
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Valori di default'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
    object TabSheet4: TTabSheet
      Caption = 'Selezione dati sorgente'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object BitBtn1: TBitBtn
        Left = 70
        Top = 124
        Width = 133
        Height = 25
        Caption = 'Tabella di Database'
        TabOrder = 0
        OnClick = BitBtn1Click
      end
      object BitBtn2: TBitBtn
        Left = 70
        Top = 154
        Width = 133
        Height = 25
        Caption = 'File sequenziale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = BitBtn1Click
      end
      object BitBtn3: TBitBtn
        Left = 70
        Top = 184
        Width = 133
        Height = 25
        Caption = 'Valori utente'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnClick = BitBtn1Click
      end
    end
  end
  object Panel1: TPanel
    Left = 293
    Top = 0
    Width = 282
    Height = 428
    Align = alClient
    TabOrder = 1
    ExplicitHeight = 435
    object Label7: TLabel
      Left = 14
      Top = 76
      Width = 35
      Height = 13
      Caption = 'Tabella'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 4
      Top = 38
      Width = 47
      Height = 13
      Caption = 'DataBase'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 56
      Top = 56
      Width = 3
      Height = 13
    end
    object Label8: TLabel
      Left = 8
      Top = 4
      Width = 74
      Height = 13
      Caption = 'Destinazione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label11: TLabel
      Left = 202
      Top = 182
      Width = 7
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label12: TLabel
      Left = 202
      Top = 208
      Width = 7
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ListBox2: TListBox
      Left = 52
      Top = 118
      Width = 145
      Height = 145
      DragMode = dmAutomatic
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clFuchsia
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 0
      OnDblClick = ListBox1DblClick
    end
    object ListBox4: TListBox
      Left = 52
      Top = 264
      Width = 145
      Height = 145
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clOlive
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      PopupMenu = PopupMenu2
      TabOrder = 1
      OnDblClick = ListBox3DblClick
      OnDragDrop = ListBox3DragDrop
      OnDragOver = ListBox3DragOver
    end
    object ComboBox4: TComboBox
      Left = 52
      Top = 72
      Width = 145
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 0
      ParentFont = False
      Sorted = True
      TabOrder = 2
      OnChange = ComboBox3Exit
    end
    object Button3: TButton
      Left = 196
      Top = 74
      Width = 39
      Height = 18
      Caption = 'Browse'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = Button3Click
    end
    object ComboBox2: TComboBox
      Left = 54
      Top = 34
      Width = 145
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 0
      ParentFont = False
      Sorted = True
      TabOrder = 4
      OnChange = ComboBox1Exit
    end
    object Button1: TButton
      Left = 202
      Top = 236
      Width = 75
      Height = 25
      Caption = 'Trasferimento'
      TabOrder = 5
      OnClick = Button1Click
    end
    object Button4: TButton
      Left = 52
      Top = 94
      Width = 81
      Height = 23
      Caption = 'Campi chiave...'
      TabOrder = 6
      OnClick = Button4Click
    end
    object BQueryDest: TButton
      Left = 236
      Top = 74
      Width = 39
      Height = 18
      Caption = 'Query'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      Visible = False
      OnClick = Button5Click
    end
    object ListBox6: TListBox
      Left = 197
      Top = 264
      Width = 82
      Height = 145
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clOlive
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 8
    end
  end
  object Db1: TDatabase
    DatabaseName = 'Db1'
    SessionName = 'Default'
    Left = 56
    Top = 324
  end
  object Db2: TDatabase
    DatabaseName = 'Db2'
    Params.Strings = (
      'USER NAME=MONDOEDP')
    SessionName = 'Default'
    Left = 402
    Top = 120
  end
  object QDest: TQuery
    DatabaseName = 'Db2'
    RequestLive = True
    Left = 375
    Top = 120
  end
  object DataSource1: TDataSource
    AutoEdit = False
    DataSet = QSorg
    Left = 2
    Top = 324
  end
  object DataSource2: TDataSource
    AutoEdit = False
    DataSet = QDest
    Left = 347
    Top = 120
  end
  object PopupMenu1: TPopupMenu
    Left = 2
    Top = 354
    object Valoredidefault1: TMenuItem
      Caption = 'Valore di Default'
      OnClick = Valoredidefault1Click
    end
    object Autoincrementante1: TMenuItem
      Caption = 'AutoIncrementante'
      OnClick = Autoincrementante1Click
    end
    object Invariato1: TMenuItem
      Caption = 'Invariato'
      OnClick = Invariato1Click
    end
  end
  object QSorg: TQuery
    DatabaseName = 'Db1'
    Left = 29
    Top = 324
  end
  object Q430: TQuery
    DatabaseName = 'Db2'
    OnFilterRecord = Q430FilterRecord
    RequestLive = True
    SQL.Strings = (
      'SELECT * FROM T430_STORICO'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      'ORDER BY PROGRESSIVO,DATADECORRENZA')
    Left = 461
    Top = 120
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PROGRESSIVO'
        ParamType = ptUnknown
      end>
  end
  object Q030: TQuery
    DatabaseName = 'Db2'
    RequestLive = True
    SQL.Strings = (
      'SELECT * FROM T030_ANAGRAFICO '
      'WHERE PROGRESSIVO = :PROGRESSIVO')
    Left = 433
    Top = 120
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PROGRESSIVO'
        ParamType = ptUnknown
      end>
  end
  object OperSQL: TQuery
    DatabaseName = 'Db2'
    SQL.Strings = (
      'SELECT * FROM T030_ANAGRAFICO')
    Left = 375
    Top = 156
  end
  object T035: TTable
    DatabaseName = 'Db2'
    TableName = 'T035_PROGRESSIVO'
    Left = 403
    Top = 156
  end
  object OpenSeq: TOpenDialog
    Left = 2
    Top = 384
  end
  object PopupMenu2: TPopupMenu
    Left = 346
    Top = 266
    object MenuItem3: TMenuItem
      Caption = 'Sostituzione'
      OnClick = Sostituzione1Click
    end
    object Transcodifica1: TMenuItem
      Caption = 'Transcodifica'
      OnClick = Transcodifica1Click
    end
  end
  object ProgAnagra: TQuery
    DatabaseName = 'Db2'
    Left = 433
    Top = 156
  end
end
