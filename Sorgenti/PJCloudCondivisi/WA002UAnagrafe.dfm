inherited WA002FAnagrafe: TWA002FAnagrafe
  Title = '(WA002) Scheda anagrafica'
  DesignLeft = 8
  DesignTop = 8
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    Templates.Default = 'WA002FAnagrafe.html'
  end
  inherited actlstNavigatorBar: TActionList
    Left = 302
    Top = 28
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
    object actCercaCampo: TAction
      Caption = 'btnCercaCampo'
      Hint = 'Cerca campo'
      OnExecute = actCercaCampoExecute
    end
    object actCdcPercent: TAction
      Caption = 'btnCdcPercent'
      OnExecute = actCdcPercentExecute
    end
    object actAnagraficaStipendi: TAction
      Caption = 'btnAnagraficaStipendi'
      Hint = 'Anagrafica stipendi'
      OnExecute = actAnagraficaStipendiExecute
    end
    object actLoginDipendente: TAction
      Caption = 'btnLoginDipendenti'
      Hint = 'Login dipendente'
      OnExecute = actLoginDipendenteExecute
    end
    object actFotoDipendente: TAction
      Caption = 'btnFotoDipendente'
      Hint = 'Foto del dipendente'
      OnExecute = actFotoDipendenteExecute
    end
  end
end
