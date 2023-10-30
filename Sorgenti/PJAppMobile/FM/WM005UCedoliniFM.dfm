object WM005FCedoliniFM: TWM005FCedoliniFM
  Left = 0
  Top = 0
  Width = 347
  Height = 610
  Margins.Left = 0
  Margins.Top = 0
  Margins.Right = 0
  Margins.Bottom = 0
  OnCreate = UniFrameCreate
  OnDestroy = UniFrameDestroy
  Layout = 'fit'
  ParentAlignmentControl = False
  AlignmentControl = uniAlignmentClient
  Anchors = []
  TabOrder = 0
  DesignSize = (
    347
    610)
  object UnimContainerPanel2: TUnimContainerPanel
    Left = 2
    Top = 3
    Width = 342
    Height = 604
    Hint = ''
    AutoScroll = True
    Anchors = []
    LayoutAttribs.Align = 'center'
    LayoutAttribs.Pack = 'start'
    LayoutConfig.Width = '100%'
    DesignSize = (
      342
      604)
    ScrollHeight = 604
    ScrollWidth = 342
    object pnlHeader: TUnimContainerPanel
      Left = -2
      Top = 0
      Width = 350
      Height = 142
      Hint = ''
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      CreateOrder = 1
      Anchors = []
      LayoutAttribs.Align = 'center'
      LayoutAttribs.Pack = 'start'
      LayoutConfig.Height = 'auto'
      LayoutConfig.Width = '100%'
      DesignSize = (
        350
        142)
      object lblMesiRiferimento: TUnimLabel
        Left = 4
        Top = -2
        Width = 341
        Height = 35
        Hint = ''
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        CreateOrder = 1
        Alignment = taCenter
        AutoSize = False
        Caption = 'Periodo di ricerca'
        Anchors = []
        ClientEvents.UniEvents.Strings = (
          
            'afterCreate=function afterCreate(sender)'#13#10'{'#13#10'  sender.setStyle("' +
            'display: flex; justify-content: center; align-items: center; fon' +
            't-size: 18px;");'#13#10'}')
        LayoutConfig.Height = '35'
        LayoutConfig.Width = '100%'
        ParentFont = False
        Font.Height = -20
        Font.Style = [fsBold]
      end
      object pnlDate: TUnimContainerPanel
        Left = 3
        Top = 27
        Width = 347
        Height = 41
        Hint = ''
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        CreateOrder = 2
        Constraints.MaxWidth = 400
        Anchors = []
        Layout = 'hbox'
        LayoutAttribs.Align = 'stretch'
        LayoutAttribs.Pack = 'center'
        LayoutConfig.Height = '40'
        LayoutConfig.Width = '98%'
        DesignSize = (
          347
          41)
        object edtMeseDa: TUnimDatePicker
          Left = 2
          Top = 0
          Width = 160
          Height = 38
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          CreateOrder = 1
          Anchors = []
          Flex = 1
          DateFormat = 'MM/yyyy'
          ShowBlankDate = False
          LayoutConfig.Height = '100%'
          SlotOrder = 'm/y'
          Date = 43699.000000000000000000
          Picker = dptFloated
          OnChange = edtMeseChange
        end
        object UnimContainerPanel4: TUnimContainerPanel
          Left = 170
          Top = 8
          Width = 20
          Height = 20
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          CreateOrder = 2
          Anchors = []
          LayoutConfig.Height = '100%'
          LayoutConfig.Width = '20'
        end
        object edtMeseA: TUnimDatePicker
          Left = 183
          Top = 1
          Width = 160
          Height = 38
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          CreateOrder = 3
          Anchors = []
          Flex = 1
          DateFormat = 'MM/yyyy'
          ShowBlankDate = False
          LayoutConfig.Height = '100%'
          SlotOrder = 'm/y'
          Date = 43699.000000000000000000
          Picker = dptFloated
          OnChange = edtMeseChange
        end
      end
      object lblNumCedolini: TUnimLabel
        Left = 9
        Top = 88
        Width = 341
        Height = 25
        Hint = ''
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        CreateOrder = 3
        Alignment = taCenter
        AutoSize = False
        Caption = 'lblNumCedolini'
        Anchors = []
        ClientEvents.UniEvents.Strings = (
          
            'afterCreate=function afterCreate(sender)'#13#10'{'#13#10'  sender.setStyle("' +
            'display: flex; justify-content: center; align-items: center; fon' +
            't-size: 18px;");'#13#10'}')
        LayoutConfig.Height = '35'
        LayoutConfig.Width = '100%'
        ParentFont = False
        Font.Height = -20
        Font.Style = [fsBold]
      end
    end
  end
end
