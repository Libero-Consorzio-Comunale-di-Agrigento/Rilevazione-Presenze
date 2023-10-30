inherited WA172FAnagraficaDetailFM: TWA172FAnagraficaDetailFM
  inherited IWFrameRegion: TIWRegion
    inherited grdTabella: TmedpIWDBGrid
      Summary = 'Elenco dipendenti appartenenti al gruppi schede quantitative'
      OnDataSet2Componenti = grdTabellaDataSet2Componenti
      OnComponenti2DataSet = grdTabellaComponenti2DataSet
    end
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    Templates.Default = ''
  end
end
