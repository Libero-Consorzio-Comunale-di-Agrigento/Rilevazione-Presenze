inherited WA115FIterAutorizzativiSelI96DetailFM: TWA115FIterAutorizzativiSelI96DetailFM
  Width = 724
  Height = 471
  ExplicitWidth = 724
  ExplicitHeight = 471
  inherited IWFrameRegion: TIWRegion
    Width = 724
    Height = 471
    ExplicitWidth = 724
    ExplicitHeight = 471
    inherited grdTabella: TmedpIWDBGrid
      Caption = 'Livelli'
      OnDataSet2Componenti = grdTabellaDataSet2Componenti
      OnComponenti2DataSet = grdTabellaComponenti2DataSet
    end
  end
  inherited pmnGrdTabellaDett: TPopupMenu
    object N1: TMenuItem
      Caption = '-'
    end
    object Scriptdidefault1: TMenuItem
      Caption = 'Script di default'
      Hint = 'submit'
      OnClick = actImpostaScriptDefaultExecute
    end
  end
end
