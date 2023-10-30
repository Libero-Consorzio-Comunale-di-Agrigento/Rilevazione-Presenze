inherited WA020FCausPresenzeStorico: TWA020FCausPresenzeStorico
  Tag = 107
  DesignLeft = 8
  DesignTop = 8
  inherited grdNavigatorBar: TmeIWGrid
    RenderSize = False
    StyleRenderOptions.RenderSize = False
  end
  inherited grdToolBarStorico: TmeIWGrid
    RenderSize = False
    StyleRenderOptions.RenderSize = False
  end
  inherited actlstNavigatorBar: TActionList
    inherited actRicerca: TAction
      Visible = False
    end
    inherited actPrimo: TAction
      Visible = False
    end
    inherited actPrecedente: TAction
      Visible = False
    end
    inherited actSuccessivo: TAction
      Visible = False
    end
    inherited actUltimo: TAction
      Visible = False
    end
    inherited actCopiaSu: TAction
      Visible = False
    end
    inherited actNuovo: TAction
      Visible = False
    end
  end
end
