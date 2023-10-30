inherited WA202FValidazioneBrowseFM: TWA202FValidazioneBrowseFM
  Height = 324
  ExplicitHeight = 324
  inherited IWFrameRegion: TIWRegion
    Height = 324
    ExplicitHeight = 324
    inherited grdTabella: TmedpIWDBGrid
      Top = 80
      Height = 209
      Summary = 'Periodi autocertificati'
      OnDataSet2Componenti = grdTabellaDataSet2Componenti
      OnComponenti2DataSet = grdTabellaComponenti2DataSet
      ExplicitTop = 80
      ExplicitHeight = 209
    end
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    MasterFormTag = False
    Templates.Default = 'WA202FValidazioneBrowseFM.html'
  end
end
