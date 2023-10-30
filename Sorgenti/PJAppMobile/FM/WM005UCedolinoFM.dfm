inherited WM005FCedolinoFM: TWM005FCedolinoFM
  OnCreate = UniFrameCreate
  inherited MainPanel: TMedpUnimPanelBase
    LayoutConfig.Width = '100%'
    object lblPeriodo: TMedpUnimLabel
      Left = 80
      Top = 0
      Width = 200
      Height = 45
      Hint = ''
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      CreateOrder = 1
      Caption = 'Periodo di ricerca'
      LayoutConfig.Height = '30'
      LayoutConfig.Width = '98%'
      ParentFont = False
      Font.Style = [fsBold]
      BoxModel.CSSMargin.Top = '0px'
      BoxModel.CSSMargin.Bottom = '0px'
      BoxModel.CSSMargin.Right = '0px'
      BoxModel.CSSMargin.Left = '0px'
      BoxModel.CSSPadding.Top = '0px'
      BoxModel.CSSPadding.Bottom = '0px'
      BoxModel.CSSPadding.Right = '0px'
      BoxModel.CSSPadding.Left = '0px'
      BoxModel.CSSBorder.Top = '0px'
      BoxModel.CSSBorder.Bottom = '0px'
      BoxModel.CSSBorder.Right = '0px'
      BoxModel.CSSBorder.Left = '0px'
      BoxModel.CSSBorderRadius = '0px'
      DesignSize = (
        200
        45)
    end
    object pnlDataDaA: TMedpUnimPanelDataDaA
      Left = 16
      Top = 32
      Width = 300
      Height = 40
      Hint = ''
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      CreateOrder = 2
      Anchors = []
      ParentAlignmentControl = False
      AlignmentControl = uniAlignmentClient
      Layout = 'hbox'
      LayoutAttribs.Align = 'center'
      LayoutAttribs.Pack = 'start'
      LayoutConfig.Height = '35'
      LayoutConfig.Width = '98%'
      OnChange = pnlDataDaAChange
      ClickEnabled = True
      ChangeEnabled = True
      BoxModel.CSSMargin.Top = '0px'
      BoxModel.CSSMargin.Bottom = '0px'
      BoxModel.CSSMargin.Right = '0px'
      BoxModel.CSSMargin.Left = '0px'
      BoxModel.CSSPadding.Top = '0px'
      BoxModel.CSSPadding.Bottom = '0px'
      BoxModel.CSSPadding.Right = '0px'
      BoxModel.CSSPadding.Left = '0px'
      BoxModel.CSSBorder.Top = '0px'
      BoxModel.CSSBorder.Bottom = '0px'
      BoxModel.CSSBorder.Right = '0px'
      BoxModel.CSSBorder.Left = '0px'
      BoxModel.CSSBorderRadius = '0px'
      ClearIcon.Left = 0
      ClearIcon.Top = 0
      ClearIcon.Width = 200
      ClearIcon.Height = 45
      ClearIcon.Hint = ''
      ClearIcon.Margins.Left = 0
      ClearIcon.Margins.Top = 0
      ClearIcon.Margins.Right = 0
      ClearIcon.Margins.Bottom = 0
      ClearIcon.Visible = False
      ClearIcon.Caption = 'fas fa-times-circle'
      ClearIcon.LayoutConfig.Height = '100%'
      ClearIcon.LayoutConfig.Width = 'auto'
      ClearIcon.BoxModel.CSSMargin.Top = '0px'
      ClearIcon.BoxModel.CSSMargin.Bottom = '0px'
      ClearIcon.BoxModel.CSSMargin.Right = '0px'
      ClearIcon.BoxModel.CSSMargin.Left = '0px'
      ClearIcon.BoxModel.CSSPadding.Top = '5px'
      ClearIcon.BoxModel.CSSPadding.Bottom = '5px'
      ClearIcon.BoxModel.CSSPadding.Right = '5px'
      ClearIcon.BoxModel.CSSPadding.Left = '0px'
      ClearIcon.BoxModel.CSSBorder.Top = '0px'
      ClearIcon.BoxModel.CSSBorder.Bottom = '0px'
      ClearIcon.BoxModel.CSSBorder.Right = '0px'
      ClearIcon.BoxModel.CSSBorder.Left = '0px'
      ClearIcon.BoxModel.CSSBorderRadius = '0px'
      ClearIcon.CSSColor = '#b0b0b0'
      ClearIcon.DesignSize = (
        200
        45)
      DataDa.Left = 0
      DataDa.Top = 0
      DataDa.Width = 200
      DataDa.Height = 45
      DataDa.Hint = ''
      DataDa.Margins.Left = 0
      DataDa.Margins.Top = 0
      DataDa.Margins.Right = 0
      DataDa.Margins.Bottom = 0
      DataDa.ClientEvents.UniEvents.Strings = (
        
          'afterCreate=function afterCreate(sender){ sender.originalValue=n' +
          'ull; sender.setEditable(false); }')
      DataDa.Flex = 1
      DataDa.DateFormat = 'MM/yyyy'
      DataDa.LayoutConfig.Height = '100%'
      DataDa.SlotOrder = 'm/y'
      DataDa.Date = 43804.000000000000000000
      DataDa.Picker = dptFloated
      DataDa.ScreenMask.Enabled = True
      DataDa.ScreenMask.WaitData = True
      DataDa.ScreenMask.ShowMessage = False
      DataDa.BoxModel.CSSMargin.Top = '0px'
      DataDa.BoxModel.CSSMargin.Bottom = '0px'
      DataDa.BoxModel.CSSMargin.Right = '0px'
      DataDa.BoxModel.CSSMargin.Left = '0px'
      DataDa.BoxModel.CSSPadding.Top = '0px'
      DataDa.BoxModel.CSSPadding.Bottom = '0px'
      DataDa.BoxModel.CSSPadding.Right = '0px'
      DataDa.BoxModel.CSSPadding.Left = '0px'
      DataDa.BoxModel.CSSBorder.Top = '0px'
      DataDa.BoxModel.CSSBorder.Bottom = '0px'
      DataDa.BoxModel.CSSBorder.Right = '0px'
      DataDa.BoxModel.CSSBorder.Left = '0px'
      DataDa.BoxModel.CSSBorderRadius = '0px'
      DataDa.DesignSize = (
        200
        45)
      Separatore.Left = 0
      Separatore.Top = 0
      Separatore.Width = 200
      Separatore.Height = 45
      Separatore.Hint = ''
      Separatore.Margins.Left = 0
      Separatore.Margins.Top = 0
      Separatore.Margins.Right = 0
      Separatore.Margins.Bottom = 0
      Separatore.Caption = '-'
      Separatore.LayoutConfig.Height = '100%'
      Separatore.LayoutConfig.Width = '20'
      Separatore.ParentFont = False
      Separatore.BoxModel.CSSMargin.Top = '0px'
      Separatore.BoxModel.CSSMargin.Bottom = '0px'
      Separatore.BoxModel.CSSMargin.Right = '0px'
      Separatore.BoxModel.CSSMargin.Left = '0px'
      Separatore.BoxModel.CSSPadding.Top = '0px'
      Separatore.BoxModel.CSSPadding.Bottom = '0px'
      Separatore.BoxModel.CSSPadding.Right = '0px'
      Separatore.BoxModel.CSSPadding.Left = '0px'
      Separatore.BoxModel.CSSBorder.Top = '0px'
      Separatore.BoxModel.CSSBorder.Bottom = '0px'
      Separatore.BoxModel.CSSBorder.Right = '0px'
      Separatore.BoxModel.CSSBorder.Left = '0px'
      Separatore.BoxModel.CSSBorderRadius = '0px'
      Separatore.DesignSize = (
        200
        45)
      DataA.Left = 0
      DataA.Top = 0
      DataA.Width = 200
      DataA.Height = 45
      DataA.Hint = ''
      DataA.Margins.Left = 0
      DataA.Margins.Top = 0
      DataA.Margins.Right = 0
      DataA.Margins.Bottom = 0
      DataA.ClientEvents.UniEvents.Strings = (
        
          'afterCreate=function afterCreate(sender){ sender.originalValue=n' +
          'ull; sender.setEditable(false); }')
      DataA.Flex = 1
      DataA.DateFormat = 'MM/yyyy'
      DataA.LayoutConfig.Height = '100%'
      DataA.SlotOrder = 'm/y'
      DataA.Date = 43804.000000000000000000
      DataA.Picker = dptFloated
      DataA.ScreenMask.Enabled = True
      DataA.ScreenMask.WaitData = True
      DataA.ScreenMask.ShowMessage = False
      DataA.BoxModel.CSSMargin.Top = '0px'
      DataA.BoxModel.CSSMargin.Bottom = '0px'
      DataA.BoxModel.CSSMargin.Right = '0px'
      DataA.BoxModel.CSSMargin.Left = '0px'
      DataA.BoxModel.CSSPadding.Top = '0px'
      DataA.BoxModel.CSSPadding.Bottom = '0px'
      DataA.BoxModel.CSSPadding.Right = '0px'
      DataA.BoxModel.CSSPadding.Left = '0px'
      DataA.BoxModel.CSSBorder.Top = '0px'
      DataA.BoxModel.CSSBorder.Bottom = '0px'
      DataA.BoxModel.CSSBorder.Right = '0px'
      DataA.BoxModel.CSSBorder.Left = '0px'
      DataA.BoxModel.CSSBorderRadius = '0px'
      DataA.DesignSize = (
        200
        45)
      DesignSize = (
        300
        40)
    end
    object pnlNumCedolini: TMedpUnimPanelNumElem
      Left = 16
      Top = 72
      Width = 300
      Height = 45
      Hint = ''
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      CreateOrder = 3
      Anchors = []
      ParentAlignmentControl = False
      AlignmentControl = uniAlignmentClient
      Layout = 'hbox'
      LayoutAttribs.Align = 'center'
      LayoutAttribs.Pack = 'start'
      LayoutConfig.Height = '30'
      LayoutConfig.Width = '98%'
      ClickEnabled = True
      ChangeEnabled = True
      BoxModel.CSSMargin.Top = '5px'
      BoxModel.CSSMargin.Bottom = '5px'
      BoxModel.CSSMargin.Right = '0px'
      BoxModel.CSSMargin.Left = '0px'
      BoxModel.CSSPadding.Top = '0px'
      BoxModel.CSSPadding.Bottom = '0px'
      BoxModel.CSSPadding.Right = '0px'
      BoxModel.CSSPadding.Left = '0px'
      BoxModel.CSSBorder.Top = '0px'
      BoxModel.CSSBorder.Bottom = '0px'
      BoxModel.CSSBorder.Right = '0px'
      BoxModel.CSSBorder.Left = '0px'
      BoxModel.CSSBorderRadius = '0px'
      LabelNumElementi.Left = 0
      LabelNumElementi.Top = 0
      LabelNumElementi.Width = 200
      LabelNumElementi.Height = 45
      LabelNumElementi.Hint = ''
      LabelNumElementi.Margins.Left = 0
      LabelNumElementi.Margins.Top = 0
      LabelNumElementi.Margins.Right = 0
      LabelNumElementi.Margins.Bottom = 0
      LabelNumElementi.Caption = 'Nessun cedolino'
      LabelNumElementi.Flex = 1
      LabelNumElementi.LayoutConfig.Height = 'auto'
      LabelNumElementi.ParentFont = False
      LabelNumElementi.BoxModel.CSSMargin.Top = '0px'
      LabelNumElementi.BoxModel.CSSMargin.Bottom = '0px'
      LabelNumElementi.BoxModel.CSSMargin.Right = '0px'
      LabelNumElementi.BoxModel.CSSMargin.Left = '0px'
      LabelNumElementi.BoxModel.CSSPadding.Top = '3px'
      LabelNumElementi.BoxModel.CSSPadding.Bottom = '3px'
      LabelNumElementi.BoxModel.CSSPadding.Right = '3px'
      LabelNumElementi.BoxModel.CSSPadding.Left = '3px'
      LabelNumElementi.BoxModel.CSSBorder.Top = '1px solid black'
      LabelNumElementi.BoxModel.CSSBorder.Bottom = '1px solid black'
      LabelNumElementi.BoxModel.CSSBorder.Right = '1px solid black'
      LabelNumElementi.BoxModel.CSSBorder.Left = '1px solid black'
      LabelNumElementi.BoxModel.CSSBorderRadius = '0px'
      LabelNumElementi.DesignSize = (
        200
        45)
      Icona.Left = 0
      Icona.Top = 0
      Icona.Width = 200
      Icona.Height = 45
      Icona.Hint = ''
      Icona.Margins.Left = 0
      Icona.Margins.Top = 0
      Icona.Margins.Right = 0
      Icona.Margins.Bottom = 0
      Icona.Visible = False
      Icona.Caption = 'fas fa-plus-circle'
      Icona.LayoutConfig.Height = '100%'
      Icona.LayoutConfig.Width = '40'
      Icona.ParentFont = False
      Icona.Font.Height = -27
      Icona.BoxModel.CSSMargin.Top = '0px'
      Icona.BoxModel.CSSMargin.Bottom = '0px'
      Icona.BoxModel.CSSMargin.Right = '0px'
      Icona.BoxModel.CSSMargin.Left = '0px'
      Icona.BoxModel.CSSPadding.Top = '0px'
      Icona.BoxModel.CSSPadding.Bottom = '0px'
      Icona.BoxModel.CSSPadding.Right = '0px'
      Icona.BoxModel.CSSPadding.Left = '0px'
      Icona.BoxModel.CSSBorder.Top = '0px'
      Icona.BoxModel.CSSBorder.Bottom = '0px'
      Icona.BoxModel.CSSBorder.Right = '0px'
      Icona.BoxModel.CSSBorder.Left = '0px'
      Icona.BoxModel.CSSBorderRadius = '0px'
      Icona.DesignSize = (
        200
        45)
      CaptionZero = 'Nessun cedolino'
      CaptionSingolare = 'cedolino'
      CaptionPlurale = 'cedolini'
      DesignSize = (
        300
        45)
    end
    object pnlListaCedolini: TMedpUnimPanelListaDisclosure
      Left = 0
      Top = 117
      Width = 347
      Height = 493
      Hint = ''
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      CreateOrder = 4
      AutoScroll = True
      Anchors = []
      ParentAlignmentControl = False
      AlignmentControl = uniAlignmentClient
      LayoutAttribs.Align = 'center'
      LayoutAttribs.Pack = 'start'
      LayoutConfig.Width = '98%'
      Flex = 1
      ScreenMask.Enabled = True
      ScreenMask.WaitData = True
      ScreenMask.Message = 'Stampa PDF in corso...'
      ClickEnabled = True
      ChangeEnabled = True
      BoxModel.CSSMargin.Top = '0px'
      BoxModel.CSSMargin.Bottom = '0px'
      BoxModel.CSSMargin.Right = '0px'
      BoxModel.CSSMargin.Left = '0px'
      BoxModel.CSSPadding.Top = '0px'
      BoxModel.CSSPadding.Bottom = '0px'
      BoxModel.CSSPadding.Right = '0px'
      BoxModel.CSSPadding.Left = '0px'
      BoxModel.CSSBorder.Top = '0px'
      BoxModel.CSSBorder.Bottom = '0px'
      BoxModel.CSSBorder.Right = '0px'
      BoxModel.CSSBorder.Left = '0px'
      BoxModel.CSSBorderRadius = '0px'
      ColorPari = 16448250
      CSSBordoSeparatore = '1px solid #f0f0f0'
      DesignSize = (
        347
        493)
    end
  end
end
