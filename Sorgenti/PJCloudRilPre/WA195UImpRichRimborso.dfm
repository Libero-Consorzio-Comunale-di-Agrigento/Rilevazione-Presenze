inherited WA195FImpRichRimborso: TWA195FImpRichRimborso
  Tag = 98
  DesignLeft = 8
  DesignTop = 8
  inherited actlstNavigatorBar: TActionList
    object actConfermaTutto: TAction
      Caption = 'btnConfermaTutto'
      Hint = 'Conferma tutti i rimborsi'
      OnExecute = actConfermaTuttoExecute
    end
    object actConfermaModifiche: TAction
      Caption = 'btnConfermaModifiche'
      Enabled = False
      Hint = 'Salva le modifiche'
      OnExecute = actConfermaModificheExecute
    end
    object actAnnullaModifiche: TAction
      Caption = 'btnAnnullaModifiche'
      Enabled = False
      Hint = 'Annulla le modifiche'
      OnExecute = actAnnullaModificheExecute
    end
  end
end
