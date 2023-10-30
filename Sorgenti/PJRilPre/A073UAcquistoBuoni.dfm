inherited A073FAcquistoBuoni: TA073FAcquistoBuoni
  Left = 310
  Top = 242
  HelpContext = 73000
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '<A073> Riepilogo acquisto buoni pasto/ticket'
  ClientHeight = 426
  ClientWidth = 612
  ExplicitWidth = 628
  ExplicitHeight = 484
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 408
    Width = 612
    ExplicitTop = 408
    ExplicitWidth = 612
  end
  inherited Panel1: TToolBar
    Top = 24
    Width = 612
    ExplicitTop = 24
    ExplicitWidth = 612
  end
  object DBGrid1: TDBGrid [2]
    Left = 0
    Top = 48
    Width = 612
    Height = 360
    Align = alClient
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'DATA'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_MAGAZZINOlk'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ID_BLOCCHETTI'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOTE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BUONIPASTO'
        Visible = True
      end
      item
        Color = cl3DLight
        Expanded = False
        FieldName = 'BUONI_AUTO'
        Visible = True
      end
      item
        Color = cl3DLight
        Expanded = False
        FieldName = 'BUONI_RECUPERATI'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TICKET'
        Visible = True
      end
      item
        Color = cl3DLight
        Expanded = False
        FieldName = 'TICKET_AUTO'
        Visible = True
      end
      item
        Color = cl3DLight
        Expanded = False
        FieldName = 'TICKET_RECUPERATI'
        Visible = True
      end>
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe [3]
    Left = 0
    Top = 0
    Width = 612
    Height = 24
    Align = alTop
    TabOrder = 3
    TabStop = True
    ExplicitWidth = 612
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 612
      Height = 24
      ExplicitWidth = 612
      ExplicitHeight = 24
      inherited btnSelezione: TBitBtn
        OnClick = frmSelAnagrafebtnSelezioneClick
      end
    end
    inherited pmnuDatiAnagrafici: TPopupMenu
      inherited R003Datianagrafici: TMenuItem
        OnClick = frmSelAnagrafeR003DatianagraficiClick
      end
    end
  end
  inherited MainMenu1: TMainMenu [4]
    inherited File1: TMenuItem
      object Riepilogo1: TMenuItem [1]
        Caption = 'Riepilogo acquisti/maturazione'
        OnClick = Riepilogo1Click
      end
      object Interrogazionidiservizio1: TMenuItem [6]
        Caption = 'Interrogazioni di servizio'
        OnClick = Interrogazionidiservizio1Click
      end
      object N4: TMenuItem [7]
        Caption = '-'
      end
      object MagazzinoBuonipasto1: TMenuItem [8]
        Caption = 'Magazzino Buoni pasto'
        OnClick = MagazzinoBuonipasto1Click
      end
      object N5: TMenuItem [9]
        Caption = '-'
      end
      object Importazioneacquistidafileexcel1: TMenuItem [10]
        Action = actImportaDaFile
      end
      object N6: TMenuItem [11]
        Caption = '-'
      end
    end
  end
  inherited DButton: TDataSource [5]
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog [6]
  end
  inherited ImageList1: TImageList [7]
  end
  inherited ActionList1: TActionList
    object actImportaDaFile: TAction
      Caption = 'Importazione acquisti da file'
      OnExecute = actImportaDaFileExecute
    end
  end
end
