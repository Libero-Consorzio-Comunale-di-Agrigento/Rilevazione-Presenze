inherited WA100FRimborsiFM: TWA100FRimborsiFM
  inherited IWFrameRegion: TIWRegion
    inherited grdTabella: TmedpIWDBGrid
      Caption = 'Elenco rimborsi'
      Summary = 'elenco rimborsi'
      OnDataSet2Componenti = grdTabellaDataSet2Componenti
    end
  end
  object pmnTipoRimborso: TPopupMenu
    Left = 312
    Top = 40
    object Accedi1: TMenuItem
      Caption = 'Accedi'
      Hint = 'submit'
      OnClick = Accedi1Click
    end
  end
end
