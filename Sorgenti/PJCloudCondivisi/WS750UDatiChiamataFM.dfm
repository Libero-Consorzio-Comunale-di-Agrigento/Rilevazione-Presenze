inherited WS750FDatiChiamataFM: TWS750FDatiChiamataFM
  inherited IWFrameRegion: TIWRegion
    inherited grdTabella: TmedpIWDBGrid
      Summary = 'Dati Chiamata'
      OnDataSet2Componenti = grdTabellaDataSet2Componenti
    end
  end
  inherited actlstDetailNavBar: TActionList
    inherited actNuovo: TAction
      Visible = False
    end
    inherited actElimina: TAction
      Visible = False
    end
  end
end
