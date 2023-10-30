inherited WA156FNotificheIrisWEBBrowseFM: TWA156FNotificheIrisWEBBrowseFM
  Height = 545
  ExplicitHeight = 545
  inherited IWFrameRegion: TIWRegion
    Height = 545
    ExplicitHeight = 545
    inherited grdTabella: TmedpIWDBGrid
      Height = 249
      Summary = 'Elenco delle notifiche'
      OnDataSet2Componenti = grdTabellaDataSet2Componenti
      OnComponenti2DataSet = grdTabellaComponenti2DataSet
      ExplicitHeight = 249
    end
    object dmemNotificaSqlText: TmeIWDBMemo
      Left = 30
      Top = 344
      Width = 619
      Height = 177
      Css = 'textarea_sql height30'
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      BGColor = clNone
      Editable = False
      Font.Color = clNone
      Font.Size = 10
      Font.Style = []
      InvisibleBorder = False
      HorizScrollBar = False
      VertScrollBar = True
      Required = False
      TabOrder = 0
      SubmitOnAsyncEvent = True
      AutoEditable = True
      DataField = 'NOTIFICA_SQL_TEXT'
      FriendlyName = 'dmemNotificaSqlText'
    end
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    Templates.Default = 'WA156FNotificheIrisWEBBrowseFM.html'
  end
end
