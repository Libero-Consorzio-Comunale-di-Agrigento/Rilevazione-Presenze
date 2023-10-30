inherited WA189FLimitiEccedenzaLiqMesiFM: TWA189FLimitiEccedenzaLiqMesiFM
  inherited IWFrameRegion: TIWRegion
    inherited grdTabella: TmedpIWDBGrid
      Summary = 'limiti eccedenza liquidabile  '
    end
  end
  inherited actlstDetailNavBar: TActionList
    object actAssegnazioneAnnua: TAction
      Caption = 'btnAssegnazioneAnnua'
      Hint = 'Assegnazione annua'
      OnExecute = actAssegnazioneAnnuaExecute
    end
  end
end
