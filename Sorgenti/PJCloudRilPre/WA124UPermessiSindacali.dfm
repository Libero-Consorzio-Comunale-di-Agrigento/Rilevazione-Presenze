inherited WA124FPermessiSindacali: TWA124FPermessiSindacali
  Tag = 58
  DesignLeft = 8
  DesignTop = 8
  inherited actlstNavigatorBar: TActionList
    object actPermessiNonCancellati: TAction [12]
      Category = 'Azioni'
      Caption = 'btnCheck'
      Hint = 'Nascondi permessi CANCELLATI'
      OnExecute = actPermessiNonCancellatiExecute
    end
    object actPermessiAnnoCorrente: TAction [13]
      Category = 'Azioni'
      Caption = 'btnVisioneCorrente'
      Hint = 'Attiva visione anno corrente'
      OnExecute = actPermessiAnnoCorrenteExecute
    end
    object actCartellino: TAction
      Category = 'Azioni'
      Caption = 'btnCartellino'
      Hint = 'Visualizza timbrature/giustificativi'
      OnExecute = actCartellinoExecute
    end
    object actAnomalie: TAction
      Tag = -1
      Category = 'Azioni'
      Caption = 'btnAnomalie'
      Hint = 'Anomalie'
      OnExecute = actAnomalieExecute
    end
  end
end
