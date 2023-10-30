inherited WP684FRisorseDettDefinizioneFondiFM: TWP684FRisorseDettDefinizioneFondiFM
  inherited IWFrameRegion: TIWRegion
    inherited grdTabella: TmedpIWDBGrid
      Caption = 'Risorse dettagliate'
      Summary = 'Risorse dettagliate'
      OnDataSet2Componenti = grdTabellaDataSet2Componenti
      OnComponenti2DataSet = grdTabellaComponenti2DataSet
    end
  end
  inherited actlstDetailNavBar: TActionList
    inherited actCopiaSu: TAction
      Visible = True
      OnExecute = actCopiaSuExecute
    end
  end
end
