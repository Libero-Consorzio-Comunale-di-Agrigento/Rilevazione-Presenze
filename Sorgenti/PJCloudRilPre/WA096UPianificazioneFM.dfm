inherited WA096FPianificazioneFM: TWA096FPianificazioneFM
  inherited IWFrameRegion: TIWRegion
    inherited grdTabella: TmedpIWDBGrid
      Summary = 'Pianificazione profilo libera professione'
      medpEditMultiplo = True
      OnDataSet2Componenti = grdTabellaDataSet2Componenti
      OnComponenti2DataSet = grdTabellaComponenti2DataSet
    end
  end
end
