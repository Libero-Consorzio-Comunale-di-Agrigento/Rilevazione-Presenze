inherited WA089FRegIndPresenzaRegoleFM: TWA089FRegIndPresenzaRegoleFM
  inherited IWFrameRegion: TIWRegion
    inherited grdTabella: TmedpIWDBGrid
      Summary = 'Regole indennit'#224
      OnDataSet2Componenti = grdTabellaDataSet2Componenti
      OnComponenti2DataSet = grdTabellaComponenti2DataSet
    end
  end
  inherited actlstDetailNavBar: TActionList
    object actVisCorrente: TAction [0]
      Category = 'Funzioni'
      Caption = 'btnVisioneCorrente'
      OnExecute = actVisCorrenteExecute
    end
  end
end
