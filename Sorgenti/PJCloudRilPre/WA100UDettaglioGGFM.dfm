inherited WA100FDettaglioGGFM: TWA100FDettaglioGGFM
  inherited IWFrameRegion: TIWRegion
    inherited grdTabella: TmedpIWDBGrid
      Summary = 'dettaglio giornaliero della missione'
      medpContextMenu = pmnGrdTabellaDettFiglio
      OnDataSet2Componenti = grdTabellaDataSet2Componenti
      OnComponenti2DataSet = grdTabellaComponenti2DataSet
    end
  end
  inherited pmnGrdTabellaDett: TPopupMenu
    inherited actScaricaInExcelDett: TMenuItem
      Caption = 'Scarica in Excel '
    end
  end
  object pmnGrdTabellaDettFiglio: TPopupMenu
    Left = 328
    Top = 176
    object actEseguiOpzione: TMenuItem
      Caption = 'Scarica in Excel'
      Hint = 'file_xls'
      OnClick = actScaricaInExcelClick
    end
    object Aggiornagiustificatividaserviziattivi2: TMenuItem
      Caption = 'Aggiorna giustificativi da servizi attivi'
      Hint = 'submit'
      OnClick = Aggiornagiustificativi1Click
    end
  end
end
