inherited WA100FMissioni: TWA100FMissioni
  Tag = 49
  HelpType = htKeyword
  DesignLeft = 8
  DesignTop = 8
  inherited actlstNavigatorBar: TActionList
    Left = 376
    Top = 104
    object actRicalcolaIndKM: TAction
      Caption = 'btnRicalcolaIndKM'
      Hint = 'Ricalcola indennit'#224' chilometriche'
      OnExecute = actRicalcolaIndKMExecute
    end
    object actGestioneAnticipi: TAction
      Caption = 'btnGestioneAnticipi'
      Hint = 'Gestione anticipi'
      OnExecute = actGestioneAnticipiExecute
    end
    object actImpRichRimb: TAction
      Caption = 'btnImport'
      Hint = 'Importazione richieste di rimborso dei dipendenti'
      OnExecute = actImpRichRimbExecute
    end
    object actCheckRimborsi: TAction
      Caption = 'btnCheckRimborsi'
      Hint = 'Controllo rimborsi'
      OnExecute = actCheckRimborsiExecute
    end
    object actRiapriRichiestaMissione: TAction
      Caption = 'btnRiapriRichiesta'
      Hint = 'Riapri richiesta missione'
      OnExecute = actRiapriRichiestaMissioneExecute
    end
  end
end
