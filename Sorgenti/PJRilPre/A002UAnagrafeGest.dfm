inherited A002FAnagrafeGest: TA002FAnagrafeGest
  Left = 44
  Top = 140
  Caption = 'A002FAnagrafeGest'
  ClientWidth = 920
  ExplicitWidth = 936
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 920
    ExplicitWidth = 693
  end
  inherited StatusBar: TStatusBar
    Width = 920
    ExplicitTop = 522
    ExplicitWidth = 693
  end
  inherited PageControl1: TPageControl
    Width = 920
    ExplicitWidth = 693
    ExplicitHeight = 421
    inherited TabSheet1: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 685
      inherited EditBadge: TDBEdit
        ParentFont = True
      end
      inherited EComune: TDBEdit
        TabOrder = 24
      end
      inherited ECapNas: TDBEdit
        TabOrder = 8
      end
      inherited EProvNas: TDBEdit
        TabOrder = 9
      end
      inherited ECodFiscale: TDBEdit
        TabOrder = 10
      end
      inherited dedtTelefono: TDBEdit
        TabOrder = 11
      end
      inherited dedtIndirizzo: TDBEdit
        TabOrder = 12
      end
      inherited dcmbComune: TDBLookupComboBox
        TabOrder = 26
      end
      inherited dedtComune: TDBEdit
        TabOrder = 27
      end
      inherited dedtCap: TDBEdit
        TabOrder = 28
      end
      inherited dedtProvincia: TDBEdit
        TabOrder = 29
      end
      inherited EInizio: TDBEdit
        TabOrder = 16
      end
      inherited EFine: TDBEdit
        TabOrder = 17
      end
      inherited EInizioServizio: TDBEdit
        TabOrder = 18
      end
      inherited ETipoRapp: TDBLookupComboBox
        TabOrder = 20
      end
      inherited ETerminali: TDBEdit
        TabOrder = 21
      end
      inherited ESquadra: TDBLookupComboBox
        TabOrder = 22
      end
      inherited ETipoOpe: TDBEdit
        TabOrder = 23
      end
      inherited dchkRapportiUniti: TDBCheckBox
        TabOrder = 19
      end
    end
    inherited TabSheet2: TTabSheet
      ExplicitWidth = 685
      ExplicitHeight = 393
    end
    inherited TabSheet3: TTabSheet
      ExplicitWidth = 685
      ExplicitHeight = 393
    end
  end
  inherited ToolBar1: TToolBar
    Width = 920
    ExplicitWidth = 693
  end
  inherited grbDecorrenza: TGroupBox
    Width = 920
    ExplicitWidth = 693
  end
  inherited MainMenu1: TMainMenu
    Left = 526
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 582
  end
  inherited PopupMenu1: TPopupMenu
    object Provvedimento1: TMenuItem
      Caption = 'Provvedimento'
      OnClick = Provvedimento1Click
    end
  end
  inherited ImageList1: TImageList
    Left = 496
  end
  inherited ActionList1: TActionList
    Left = 468
  end
end
