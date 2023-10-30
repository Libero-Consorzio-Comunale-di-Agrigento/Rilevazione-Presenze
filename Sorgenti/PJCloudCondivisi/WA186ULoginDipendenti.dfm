inherited WA186FLoginDipendenti: TWA186FLoginDipendenti
  Tag = 209
  Width = 742
  Height = 562
  Title = '(WA186) Login dipendenti'
  ExplicitWidth = 742
  ExplicitHeight = 562
  DesignLeft = 8
  DesignTop = 8
  inherited grdDetailTabControl: TmedpIWTabControl
    Left = 17
    Top = 369
    ExplicitLeft = 17
    ExplicitTop = 369
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    Left = 215
  end
  inherited actlstNavigatorBar: TActionList
    object actCreaLogin: TAction [12]
      Tag = 18
      Category = 'Edit'
      Caption = 'btnCreaLogin'
      Hint = 'Crea login'
      Visible = False
    end
    inherited actCopiaSu: TAction
      Visible = False
    end
  end
  object jqGestSolaLettura: TIWJQueryWidget
    Enabled = False
    OnReady.Strings = (
      '$("#tabs" ).tabs({'
      '  disabled: [1, 2]'
      '});')
    Left = 40
    Top = 304
  end
end
