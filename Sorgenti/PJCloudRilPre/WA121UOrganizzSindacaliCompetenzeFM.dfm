inherited WA121FOrganizzSindacaliCompetenzeFM: TWA121FOrganizzSindacaliCompetenzeFM
  inherited IWFrameRegion: TIWRegion
    inherited grdTabella: TmedpIWDBGrid
      Summary = 'Competenze'
      medpContextMenu = PopupMenu1
      OnDataSet2Componenti = grdTabellaDataSet2Componenti
      OnComponenti2DataSet = grdTabellaComponenti2DataSet
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 544
    Top = 366
    object Annocorrente1: TMenuItem
      AutoCheck = True
      Caption = 'Anno corrente'
      OnClick = Annocorrente1Click
    end
  end
end
