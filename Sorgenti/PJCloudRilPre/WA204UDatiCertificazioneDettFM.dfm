inherited WA204FDatiCertificazioneDettFM: TWA204FDatiCertificazioneDettFM
  inherited IWFrameRegion: TIWRegion
    inherited grdTabella: TmedpIWDBGrid
      Caption = 'Dati'
      Summary = 'Dati della categoria selezionata'
      OnDataSet2Componenti = grdTabellaDataSet2Componenti
      OnComponenti2DataSet = grdTabellaComponenti2DataSet
    end
  end
end
