inherited WA204FCategorieCertificazioneDettFM: TWA204FCategorieCertificazioneDettFM
  inherited IWFrameRegion: TIWRegion
    inherited grdTabella: TmedpIWDBGrid
      Caption = 'Categorie'
      Summary = 'Categorie del modello selezionato'
      OnDataSet2Componenti = grdTabellaDataSet2Componenti
      OnComponenti2DataSet = grdTabellaComponenti2DataSet
    end
  end
end
