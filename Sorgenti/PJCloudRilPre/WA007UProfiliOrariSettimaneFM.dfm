inherited WA007FProfiliOrariSettimaneFM: TWA007FProfiliOrariSettimaneFM
  inherited IWFrameRegion: TIWRegion
    inherited grdTabella: TmedpIWDBGrid
      ExtraTagParams.Strings = (
        'style=width:75em')
      OnDataSet2Componenti = grdTabellaDataSet2Componenti
      OnComponenti2DataSet = grdTabellaComponenti2DataSet
    end
  end
  inherited pmnGrdTabellaDett: TPopupMenu
    object mnuModelliOrarioGrid: TMenuItem
      Caption = 'Modelli orario'
      Hint = 'submit'
      OnClick = mnuModelliOrarioGridClick
    end
  end
  object pmnModelloOrario: TPopupMenu
    Left = 424
    Top = 16
    object mnuAccedi: TMenuItem
      Caption = 'Accedi'
      Hint = 'submit'
      OnClick = mnuAccediClick
    end
  end
end
