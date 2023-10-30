inherited WA064FBudgetStraordinarioMesiFM: TWA064FBudgetStraordinarioMesiFM
  inherited IWFrameRegion: TIWRegion
    inherited grdTabella: TmedpIWDBGrid
      Summary = 'Dettaglio mensile del gruppo'
      medpComandiInsert = True
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
