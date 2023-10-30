inherited WP684FDestGenDefinizioneFondiFM: TWP684FDestGenDefinizioneFondiFM
  inherited IWFrameRegion: TIWRegion
    inherited grdTabella: TmedpIWDBGrid
      Caption = 'Destinazioni generali'
      Summary = 'Destinazioni generali'
      OnDataSet2Componenti = grdTabellaDataSet2Componenti
      OnComponenti2DataSet = grdTabellaComponenti2DataSet
    end
  end
  inherited actlstDetailNavBar: TActionList
    object actRinumeraOrdineStampa: TAction
      Caption = 'btnElenco2'
      Hint = 'Rinumera ordine stampa'
      OnExecute = actRinumeraOrdineStampaExecute
    end
    object actModificaCodiceVoce: TAction
      Caption = 'btnModificaXParamComp'
      Hint = 'Modifica codice voce'
      OnExecute = actModificaCodiceVoceExecute
    end
  end
end
