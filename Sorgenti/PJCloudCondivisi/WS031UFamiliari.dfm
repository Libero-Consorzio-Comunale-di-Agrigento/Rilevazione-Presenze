inherited WS031FFamiliari: TWS031FFamiliari
  Tag = 303
  Title = '(WS031) Familiari'
  DesignLeft = 8
  DesignTop = 8
  inherited actlstNavigatorBar: TActionList
    Left = 368
    Top = 176
    inherited actCopiaSu: TAction
      Visible = False
    end
    object actCarica: TAction
      Caption = 'btnSalvataggio'
      Hint = 'Carica s'#232' stesso'
      OnExecute = actCaricaExecute
    end
  end
end
