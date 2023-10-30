inherited WA202FDetailEnteCorrFM: TWA202FDetailEnteCorrFM
  inherited IWFrameRegion: TIWRegion
    inherited grdTabella: TmedpIWDBGrid
      Summary = 'Rapporti di lavoro Ente corrente'
      RowClick = False
      medpBrowse = False
    end
  end
  inherited actlstDetailNavBar: TActionList
    inherited actNuovo: TAction
      Visible = False
    end
    inherited actModifica: TAction
      Visible = False
    end
    inherited actElimina: TAction
      Visible = False
    end
    inherited actAnnulla: TAction
      Visible = False
    end
    inherited actConferma: TAction
      Visible = False
    end
  end
end
