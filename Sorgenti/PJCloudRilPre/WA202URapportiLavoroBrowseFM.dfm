inherited WA202FRapportiLavoroBrowseFM: TWA202FRapportiLavoroBrowseFM
  Width = 716
  Height = 399
  ExplicitWidth = 716
  ExplicitHeight = 399
  inherited IWFrameRegion: TIWRegion
    Width = 716
    Height = 399
    ExplicitWidth = 716
    ExplicitHeight = 399
    inherited grdTabella: TmedpIWDBGrid
      Summary = 'Rapporti di lavoro presso altri Enti'
      OnDataSet2Componenti = grdTabellaDataSet2Componenti
    end
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    MasterFormTag = False
    Templates.Default = 'WA202FRapportiLavoroBrowseFM.html'
  end
end
