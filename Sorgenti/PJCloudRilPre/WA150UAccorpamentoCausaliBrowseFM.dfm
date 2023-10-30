inherited WA150FAccorpamentoCausaliBrowseFM: TWA150FAccorpamentoCausaliBrowseFM
  inherited IWFrameRegion: TIWRegion
    inherited grdTabella: TmedpIWDBGrid
      Caption = 'Accorpamenti'
      Summary = 'Tipi Accorpamento Causali'
      OnDataSet2Componenti = grdTabellaDataSet2Componenti
      OnComponenti2DataSet = grdTabellaComponenti2DataSet
    end
  end
end
