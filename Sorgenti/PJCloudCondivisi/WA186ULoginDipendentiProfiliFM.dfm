inherited WA186FLoginDipendentiProfiliFM: TWA186FLoginDipendentiProfiliFM
  inherited IWFrameRegion: TIWRegion
    OnRender = IWFrameRegionRender
    inherited grdTabella: TmedpIWDBGrid
      Caption = 'Profili associati al login'
      Summary = 'login dipendenti'
      OnDataSet2Componenti = grdTabellaDataSet2Componenti
      OnComponenti2DataSet = grdTabellaComponenti2DataSet
    end
  end
  inherited actlstDetailNavBar: TActionList
    object actVisioneCorrente: TAction
      Category = 'Personalizzato'
      Caption = 'btnVisioneCorrente'
      Hint = 'Visione corrente'
      OnExecute = actVisioneCorrenteExecute
    end
    object actRiportaSuImpostazione: TAction
      Caption = 'btnAccedi3'
      Hint = 'Riporta su Impostazioni profili'
      OnExecute = actRiportaSuImpostazioneExecute
    end
  end
end
