inherited WS700FElementiFM: TWS700FElementiFM
  inherited IWFrameRegion: TIWRegion
    inherited grdTabella: TmedpIWDBGrid
      Summary = 'Elementi'
      OnDataSet2Componenti = grdTabellaDataSet2Componenti
      OnComponenti2DataSet = grdTabellaComponenti2DataSet
    end
    object meIWButton1: TmeIWButton
      Left = 580
      Top = 96
      Width = 75
      Height = 25
      Cursor = crAuto
      Css = 'pulsante'
      ParentShowHint = False
      ShowHint = True
      ZIndex = 0
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      Caption = 'meIWButton1'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'meIWButton1'
      ScriptEvents = <>
      TabOrder = 0
      OnClick = meIWButton1Click
      medpDownloadButton = False
    end
  end
  inherited actlstDetailNavBar: TActionList
    inherited actElimina: TAction
      OnExecute = actDetailEliminaExecute
    end
    inherited actAnnulla: TAction
      OnExecute = actDetailAnnullaExecute
    end
    inherited actConferma: TAction
      OnExecute = actDetailConfermaExecute
    end
  end
  object pmnDettaglio: TPopupMenu
    Left = 546
    Top = 206
    object actScaricaInExcelDett1: TMenuItem
      Caption = 'Scarica in Excel'
      Hint = 'file_xls'
      OnClick = actScaricaInExcelClick
    end
    object mniCopiaDettaglio: TMenuItem
      Caption = 'Riporta elementi su altra area con la stessa decorrenza'
      OnClick = mniCopiaDettaglioClick
    end
  end
end
