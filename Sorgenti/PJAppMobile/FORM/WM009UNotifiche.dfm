object WM009FNotifiche: TWM009FNotifiche
  Left = 0
  Top = 0
  ClientHeight = 480
  ClientWidth = 320
  Caption = 
    '<span style="display: flex; align-items: center;"><img src="/fil' +
    'es/favicon/favicon-32x32.png"><p>&nbsp&nbspNotifiche</p></span>'
  OnShow = UnimFormShow
  AlignmentControl = uniAlignmentClient
  LayoutAttribs.Align = 'center'
  LayoutAttribs.Pack = 'start'
  CloseButton.UI = 'action'
  TitleDocked = True
  TitleButtons = <>
  OnCreate = UnimFormCreate
  DesignSize = (
    320
    480)
  PixelsPerInch = 96
  TextHeight = 13
  ScrollPosition = 0
  ScrollHeight = 47
  PlatformData = {}
  object MainPanel: TMedpUnimPanelBase
    Left = 5
    Top = 5
    Width = 310
    Height = 470
    Hint = ''
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Constraints.MaxWidth = 450
    AutoScroll = True
    Anchors = []
    AlignmentControl = uniAlignmentClient
    LayoutAttribs.Align = 'center'
    LayoutAttribs.Pack = 'start'
    LayoutConfig.Height = '100%'
    LayoutConfig.Width = '95%'
    ClickEnabled = True
    ChangeEnabled = True
    BoxModel.CSSMargin.Top = '0px'
    BoxModel.CSSMargin.Bottom = '0px'
    BoxModel.CSSMargin.Right = '0px'
    BoxModel.CSSMargin.Left = '0px'
    BoxModel.CSSPadding.Top = '10px'
    BoxModel.CSSPadding.Bottom = '0px'
    BoxModel.CSSPadding.Right = '0px'
    BoxModel.CSSPadding.Left = '0px'
    BoxModel.CSSBorder.Top = '0px'
    BoxModel.CSSBorder.Bottom = '0px'
    BoxModel.CSSBorder.Right = '0px'
    BoxModel.CSSBorder.Left = '0px'
    BoxModel.CSSBorderRadius = '0px'
    DesignSize = (
      310
      470)
    object lblNessunaNotifica: TMedpUnimLabel
      Left = 0
      Top = 0
      Width = 300
      Height = 45
      Hint = ''
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      CreateOrder = 1
      Caption = 'Nessuna notifica da visualizzare'
      LayoutConfig.Cls = 'x-text-center'
      LayoutConfig.Height = 'auto'
      LayoutConfig.Width = '98%'
      ParentFont = False
      Font.Height = -20
      Font.Style = [fsBold]
      BoxModel.CSSMargin.Top = '15px'
      BoxModel.CSSMargin.Bottom = '0px'
      BoxModel.CSSMargin.Right = '0px'
      BoxModel.CSSMargin.Left = '0px'
      BoxModel.CSSPadding.Top = '5px'
      BoxModel.CSSPadding.Bottom = '5px'
      BoxModel.CSSPadding.Right = '5px'
      BoxModel.CSSPadding.Left = '5px'
      BoxModel.CSSBorder.Top = '0px'
      BoxModel.CSSBorder.Bottom = '0px'
      BoxModel.CSSBorder.Right = '0px'
      BoxModel.CSSBorder.Left = '0px'
      BoxModel.CSSBorderRadius = '0px'
      DesignSize = (
        300
        45)
    end
    object pnlGiustificativi: TMedpUnimPanelBase
      Left = 0
      Top = 39
      Width = 310
      Height = 65
      Hint = ''
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      CreateOrder = 1
      Anchors = []
      ParentAlignmentControl = False
      AlignmentControl = uniAlignmentClient
      Layout = 'hbox'
      LayoutAttribs.Align = 'center'
      LayoutAttribs.Pack = 'justify'
      LayoutConfig.Cls = 'background-blue activeClick'
      LayoutConfig.Height = '60'
      LayoutConfig.Width = '100%'
      ClickEnabled = True
      ChangeEnabled = True
      BoxModel.CSSMargin.Top = '10px'
      BoxModel.CSSMargin.Bottom = '10px'
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
      BoxModel.CSSBorderRadius = '10px'
      DesignSize = (
        310
        65)
      object pnlLblGiustificativi: TMedpUnimPanelBase
        Left = 0
        Top = -18
        Width = 225
        Height = 113
        Hint = ''
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        CreateOrder = 1
        Anchors = []
        ParentAlignmentControl = False
        AlignmentControl = uniAlignmentClient
        LayoutAttribs.Align = 'center'
        LayoutAttribs.Pack = 'start'
        LayoutConfig.Height = '100%'
        Flex = 1
        ClickEnabled = True
        ChangeEnabled = True
        BoxModel.CSSMargin.Top = '0px'
        BoxModel.CSSMargin.Bottom = '0px'
        BoxModel.CSSMargin.Right = '0px'
        BoxModel.CSSMargin.Left = '5px'
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
          225
          113)
        object lblHeaderGiust: TMedpUnimLabel
          Left = 6
          Top = 29
          Width = 200
          Height = 29
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          CreateOrder = 1
          Caption = 'Nuovi giustificativi da autorizzare'
          ScreenMask.Enabled = True
          ScreenMask.WaitData = True
          ScreenMask.ShowMessage = False
          LayoutConfig.Cls = 'x-text-center'
          LayoutConfig.Height = '50%'
          LayoutConfig.Width = '100%'
          ParentFont = False
          Font.Style = [fsBold]
          OnClick = lblDisclGiustificativiClick
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
            29)
        end
        object lblNumGiust: TMedpUnimLabel
          Left = 0
          Top = 68
          Width = 200
          Height = 29
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          CreateOrder = 3
          Caption = '1 richiesta'
          ScreenMask.Enabled = True
          ScreenMask.WaitData = True
          ScreenMask.ShowMessage = False
          LayoutConfig.Height = '50%'
          LayoutConfig.Width = '100%'
          ParentFont = False
          Font.Style = [fsItalic]
          OnClick = lblDisclGiustificativiClick
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
            29)
        end
      end
      object lblDisclGiustificativi: TMedpUnimLabelIcon
        Left = 225
        Top = 5
        Width = 75
        Height = 45
        Hint = ''
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        CreateOrder = 2
        Caption = 'fas fa-arrow-circle-right'
        ScreenMask.Enabled = True
        ScreenMask.WaitData = True
        ScreenMask.ShowMessage = False
        LayoutConfig.Height = '100%'
        LayoutConfig.Width = '15%'
        ParentFont = False
        Font.Height = -33
        OnClick = lblDisclGiustificativiClick
        BoxModel.CSSMargin.Top = '0px'
        BoxModel.CSSMargin.Bottom = '0px'
        BoxModel.CSSMargin.Right = '0px'
        BoxModel.CSSMargin.Left = '5px'
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
          75
          45)
      end
    end
    object pnlTimbrature: TMedpUnimPanelBase
      Left = 0
      Top = 96
      Width = 310
      Height = 81
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
      LayoutAttribs.Pack = 'justify'
      LayoutConfig.Cls = 'background-blue activeClick'
      LayoutConfig.Height = '60'
      LayoutConfig.Width = '100%'
      ClickEnabled = True
      ChangeEnabled = True
      BoxModel.CSSMargin.Top = '10px'
      BoxModel.CSSMargin.Bottom = '10px'
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
      BoxModel.CSSBorderRadius = '10px'
      DesignSize = (
        310
        81)
      object pnlLblTimbrature: TMedpUnimPanelBase
        Left = 0
        Top = -11
        Width = 225
        Height = 113
        Hint = ''
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        CreateOrder = 1
        Anchors = []
        ParentAlignmentControl = False
        AlignmentControl = uniAlignmentClient
        LayoutAttribs.Align = 'center'
        LayoutAttribs.Pack = 'start'
        LayoutConfig.Height = '100%'
        Flex = 1
        ClickEnabled = True
        ChangeEnabled = True
        BoxModel.CSSMargin.Top = '0px'
        BoxModel.CSSMargin.Bottom = '0px'
        BoxModel.CSSMargin.Right = '0px'
        BoxModel.CSSMargin.Left = '5px'
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
          225
          113)
        object lblHeaderTimb: TMedpUnimLabel
          Left = 6
          Top = 29
          Width = 200
          Height = 29
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          CreateOrder = 1
          Caption = 'Nuove timbrature da autorizzare'
          ScreenMask.Enabled = True
          ScreenMask.WaitData = True
          ScreenMask.ShowMessage = False
          LayoutConfig.Cls = 'x-text-center'
          LayoutConfig.Height = '50%'
          LayoutConfig.Width = '100%'
          ParentFont = False
          Font.Style = [fsBold]
          OnClick = lblDisclTimbratureClick
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
            29)
        end
        object lblNumTimb: TMedpUnimLabel
          Left = 0
          Top = 68
          Width = 200
          Height = 29
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          CreateOrder = 3
          Caption = '1 richiesta'
          ScreenMask.Enabled = True
          ScreenMask.WaitData = True
          ScreenMask.ShowMessage = False
          LayoutConfig.Height = '50%'
          LayoutConfig.Width = '100%'
          ParentFont = False
          Font.Style = [fsItalic]
          OnClick = lblDisclTimbratureClick
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
            29)
        end
      end
      object lblDisclTimbrature: TMedpUnimLabelIcon
        Left = 225
        Top = 11
        Width = 75
        Height = 45
        Hint = ''
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        CreateOrder = 2
        Caption = 'fas fa-arrow-circle-right'
        ScreenMask.Enabled = True
        ScreenMask.WaitData = True
        ScreenMask.ShowMessage = False
        LayoutConfig.Height = '100%'
        LayoutConfig.Width = '15%'
        ParentFont = False
        Font.Height = -33
        OnClick = lblDisclTimbratureClick
        BoxModel.CSSMargin.Top = '0px'
        BoxModel.CSSMargin.Bottom = '0px'
        BoxModel.CSSMargin.Right = '0px'
        BoxModel.CSSMargin.Left = '5px'
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
          75
          45)
      end
    end
    object pnlCambioOrario: TMedpUnimPanelBase
      Left = 0
      Top = 171
      Width = 310
      Height = 81
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
      LayoutAttribs.Pack = 'justify'
      LayoutConfig.Cls = 'background-blue activeClick'
      LayoutConfig.Height = '60'
      LayoutConfig.Width = '100%'
      ClickEnabled = True
      ChangeEnabled = True
      BoxModel.CSSMargin.Top = '10px'
      BoxModel.CSSMargin.Bottom = '10px'
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
      BoxModel.CSSBorderRadius = '10px'
      DesignSize = (
        310
        81)
      object pnlLblCambioOrario: TMedpUnimPanelBase
        Left = 0
        Top = -19
        Width = 225
        Height = 113
        Hint = ''
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        CreateOrder = 1
        Anchors = []
        ParentAlignmentControl = False
        AlignmentControl = uniAlignmentClient
        LayoutAttribs.Align = 'center'
        LayoutAttribs.Pack = 'start'
        LayoutConfig.Height = '100%'
        Flex = 1
        ClickEnabled = True
        ChangeEnabled = True
        BoxModel.CSSMargin.Top = '0px'
        BoxModel.CSSMargin.Bottom = '0px'
        BoxModel.CSSMargin.Right = '0px'
        BoxModel.CSSMargin.Left = '5px'
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
          225
          113)
        object lblHeaderCambioOrario: TMedpUnimLabel
          Left = 0
          Top = 22
          Width = 200
          Height = 29
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          CreateOrder = 1
          Caption = 'Nuove richieste cambio orario da autorizzare'
          ScreenMask.Enabled = True
          ScreenMask.WaitData = True
          ScreenMask.ShowMessage = False
          LayoutConfig.Cls = 'x-text-center'
          LayoutConfig.Height = '65%'
          LayoutConfig.Width = '100%'
          ParentFont = False
          Font.Style = [fsBold]
          OnClick = lblDisclCambioOrarioClick
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
            29)
        end
        object lblNumCambioOrario: TMedpUnimLabel
          Left = 0
          Top = 70
          Width = 200
          Height = 29
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          CreateOrder = 3
          Caption = '1 richiesta'
          ScreenMask.Enabled = True
          ScreenMask.WaitData = True
          ScreenMask.ShowMessage = False
          LayoutConfig.Height = '35%'
          LayoutConfig.Width = '100%'
          ParentFont = False
          Font.Style = [fsItalic]
          OnClick = lblDisclCambioOrarioClick
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
            29)
        end
      end
      object lblDisclCambioOrario: TMedpUnimLabelIcon
        Left = 225
        Top = 11
        Width = 75
        Height = 45
        Hint = ''
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        CreateOrder = 2
        Caption = 'fas fa-arrow-circle-right'
        ScreenMask.Enabled = True
        ScreenMask.WaitData = True
        ScreenMask.ShowMessage = False
        LayoutConfig.Height = '100%'
        LayoutConfig.Width = '15%'
        ParentFont = False
        Font.Height = -33
        OnClick = lblDisclCambioOrarioClick
        BoxModel.CSSMargin.Top = '0px'
        BoxModel.CSSMargin.Bottom = '0px'
        BoxModel.CSSMargin.Right = '0px'
        BoxModel.CSSMargin.Left = '5px'
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
          75
          45)
      end
    end
    object pnlMessaggi: TMedpUnimPanelBase
      Left = 0
      Top = 314
      Width = 310
      Height = 76
      Hint = ''
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      CreateOrder = 4
      Anchors = []
      ParentAlignmentControl = False
      AlignmentControl = uniAlignmentClient
      Layout = 'hbox'
      LayoutAttribs.Align = 'center'
      LayoutAttribs.Pack = 'justify'
      LayoutConfig.Cls = 'background-blue activeClick'
      LayoutConfig.Height = '60'
      LayoutConfig.Width = '100%'
      ClickEnabled = True
      ChangeEnabled = True
      BoxModel.CSSMargin.Top = '10px'
      BoxModel.CSSMargin.Bottom = '10px'
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
      BoxModel.CSSBorderRadius = '10px'
      DesignSize = (
        310
        76)
      object pnllblMessaggi: TMedpUnimPanelBase
        Left = 0
        Top = -21
        Width = 219
        Height = 113
        Hint = ''
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        CreateOrder = 1
        Anchors = []
        ParentAlignmentControl = False
        AlignmentControl = uniAlignmentClient
        LayoutAttribs.Align = 'center'
        LayoutAttribs.Pack = 'start'
        LayoutConfig.Height = '100%'
        Flex = 1
        ClickEnabled = True
        ChangeEnabled = True
        BoxModel.CSSMargin.Top = '0px'
        BoxModel.CSSMargin.Bottom = '0px'
        BoxModel.CSSMargin.Right = '0px'
        BoxModel.CSSMargin.Left = '5px'
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
          219
          113)
        object lblHeaderMessaggi: TMedpUnimLabel
          Left = 10
          Top = 29
          Width = 200
          Height = 29
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          CreateOrder = 1
          Caption = 'Nuovi messaggi da leggere'
          ScreenMask.Enabled = True
          ScreenMask.WaitData = True
          ScreenMask.ShowMessage = False
          LayoutConfig.Cls = 'x-text-center'
          LayoutConfig.Height = '50%'
          LayoutConfig.Width = '100%'
          ParentFont = False
          Font.Style = [fsBold]
          OnClick = lblDisclMessaggiClick
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
            29)
        end
        object lblNumMessaggi: TMedpUnimLabel
          Left = -3
          Top = 58
          Width = 200
          Height = 29
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          CreateOrder = 3
          Caption = '1 messaggio'
          ScreenMask.Enabled = True
          ScreenMask.WaitData = True
          ScreenMask.ShowMessage = False
          LayoutConfig.Height = '50%'
          LayoutConfig.Width = '100%'
          ParentFont = False
          Font.Style = [fsItalic]
          OnClick = lblDisclMessaggiClick
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
            29)
        end
      end
      object lblDisclMessaggi: TMedpUnimLabelIcon
        Left = 241
        Top = 16
        Width = 75
        Height = 45
        Hint = ''
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        CreateOrder = 2
        Caption = 'fas fa-arrow-circle-right'
        ScreenMask.Enabled = True
        ScreenMask.WaitData = True
        ScreenMask.ShowMessage = False
        LayoutConfig.Height = '100%'
        LayoutConfig.Width = '15%'
        ParentFont = False
        Font.Height = -33
        OnClick = lblDisclMessaggiClick
        BoxModel.CSSMargin.Top = '0px'
        BoxModel.CSSMargin.Bottom = '0px'
        BoxModel.CSSMargin.Right = '0px'
        BoxModel.CSSMargin.Left = '5px'
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
          75
          45)
      end
    end
    object pnlCertificati: TMedpUnimPanelBase
      Left = 0
      Top = 394
      Width = 310
      Height = 76
      Hint = ''
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      CreateOrder = 5
      Anchors = []
      ParentAlignmentControl = False
      AlignmentControl = uniAlignmentClient
      Layout = 'hbox'
      LayoutAttribs.Align = 'center'
      LayoutAttribs.Pack = 'justify'
      LayoutConfig.Cls = 'background-blue activeClick'
      LayoutConfig.Height = '60'
      LayoutConfig.Width = '100%'
      ClickEnabled = True
      ChangeEnabled = True
      BoxModel.CSSMargin.Top = '10px'
      BoxModel.CSSMargin.Bottom = '10px'
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
      BoxModel.CSSBorderRadius = '10px'
      DesignSize = (
        310
        76)
      object pnlLblCertificati: TMedpUnimPanelBase
        Left = 0
        Top = -21
        Width = 219
        Height = 113
        Hint = ''
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        CreateOrder = 1
        Anchors = []
        ParentAlignmentControl = False
        AlignmentControl = uniAlignmentClient
        LayoutAttribs.Align = 'center'
        LayoutAttribs.Pack = 'start'
        LayoutConfig.Height = '100%'
        Flex = 1
        ClickEnabled = True
        ChangeEnabled = True
        BoxModel.CSSMargin.Top = '0px'
        BoxModel.CSSMargin.Bottom = '0px'
        BoxModel.CSSMargin.Right = '0px'
        BoxModel.CSSMargin.Left = '5px'
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
          219
          113)
        object lblHeaderCertificati: TMedpUnimLabel
          Left = 10
          Top = 29
          Width = 200
          Height = 29
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          CreateOrder = 1
          Caption = 'Nuove schede informative da validare'
          ScreenMask.Enabled = True
          ScreenMask.WaitData = True
          ScreenMask.ShowMessage = False
          LayoutConfig.Cls = 'x-text-center'
          LayoutConfig.Height = '60%'
          LayoutConfig.Width = '100%'
          ParentFont = False
          Font.Style = [fsBold]
          OnClick = lblDisclCertificatiClick
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
            29)
        end
        object lblNumCertificati: TMedpUnimLabel
          Left = -3
          Top = 58
          Width = 200
          Height = 29
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          CreateOrder = 3
          Caption = '1 scheda informativa'
          ScreenMask.Enabled = True
          ScreenMask.WaitData = True
          ScreenMask.ShowMessage = False
          LayoutConfig.Height = '40%'
          LayoutConfig.Width = '100%'
          ParentFont = False
          Font.Style = [fsItalic]
          OnClick = lblDisclCertificatiClick
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
            29)
        end
      end
      object lblDisclCertificati: TMedpUnimLabelIcon
        Left = 241
        Top = 16
        Width = 75
        Height = 45
        Hint = ''
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        CreateOrder = 2
        Caption = 'fas fa-arrow-circle-right'
        ScreenMask.Enabled = True
        ScreenMask.WaitData = True
        ScreenMask.ShowMessage = False
        LayoutConfig.Height = '100%'
        LayoutConfig.Width = '15%'
        ParentFont = False
        Font.Height = -33
        OnClick = lblDisclCertificatiClick
        BoxModel.CSSMargin.Top = '0px'
        BoxModel.CSSMargin.Bottom = '0px'
        BoxModel.CSSMargin.Right = '0px'
        BoxModel.CSSMargin.Left = '5px'
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
          75
          45)
      end
    end
    object pnlCedolini: TMedpUnimPanelBase
      Left = 0
      Top = 244
      Width = 310
      Height = 76
      Hint = ''
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      CreateOrder = 5
      Anchors = []
      ParentAlignmentControl = False
      AlignmentControl = uniAlignmentClient
      Layout = 'hbox'
      LayoutAttribs.Align = 'center'
      LayoutAttribs.Pack = 'justify'
      LayoutConfig.Cls = 'background-blue activeClick'
      LayoutConfig.Height = '60'
      LayoutConfig.Width = '100%'
      ClickEnabled = True
      ChangeEnabled = True
      BoxModel.CSSMargin.Top = '10px'
      BoxModel.CSSMargin.Bottom = '10px'
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
      BoxModel.CSSBorderRadius = '10px'
      DesignSize = (
        310
        76)
      object pnlLblCedolini: TMedpUnimPanelBase
        Left = 0
        Top = -21
        Width = 225
        Height = 113
        Hint = ''
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        CreateOrder = 1
        Anchors = []
        ParentAlignmentControl = False
        AlignmentControl = uniAlignmentClient
        LayoutAttribs.Align = 'center'
        LayoutAttribs.Pack = 'start'
        LayoutConfig.Height = '100%'
        Flex = 1
        ClickEnabled = True
        ChangeEnabled = True
        BoxModel.CSSMargin.Top = '0px'
        BoxModel.CSSMargin.Bottom = '0px'
        BoxModel.CSSMargin.Right = '0px'
        BoxModel.CSSMargin.Left = '5px'
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
          225
          113)
        object lblHeaderCedolini: TMedpUnimLabel
          Left = 6
          Top = 29
          Width = 200
          Height = 29
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          CreateOrder = 1
          Caption = 'Nuovi cedolini da visualizzare'
          ScreenMask.Enabled = True
          ScreenMask.WaitData = True
          ScreenMask.ShowMessage = False
          LayoutConfig.Cls = 'x-text-center'
          LayoutConfig.Height = '50%'
          LayoutConfig.Width = '100%'
          ParentFont = False
          Font.Style = [fsBold]
          OnClick = lblDisclCedoliniClick
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
            29)
        end
        object lblNumCedolini: TMedpUnimLabel
          Left = 6
          Top = 68
          Width = 200
          Height = 29
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          CreateOrder = 3
          Caption = '1 richiesta'
          ScreenMask.Enabled = True
          ScreenMask.WaitData = True
          ScreenMask.ShowMessage = False
          LayoutConfig.Height = '50%'
          LayoutConfig.Width = '100%'
          ParentFont = False
          Font.Style = [fsItalic]
          OnClick = lblDisclCedoliniClick
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
            29)
        end
      end
      object lblDisclCedolini: TMedpUnimLabelIcon
        Left = 225
        Top = 25
        Width = 75
        Height = 45
        Hint = ''
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        CreateOrder = 2
        Caption = 'fas fa-arrow-circle-right'
        ScreenMask.Enabled = True
        ScreenMask.WaitData = True
        ScreenMask.ShowMessage = False
        LayoutConfig.Height = '100%'
        LayoutConfig.Width = '15%'
        ParentFont = False
        Font.Height = -33
        OnClick = lblDisclCedoliniClick
        BoxModel.CSSMargin.Top = '0px'
        BoxModel.CSSMargin.Bottom = '0px'
        BoxModel.CSSMargin.Right = '0px'
        BoxModel.CSSMargin.Left = '5px'
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
          75
          45)
      end
    end
  end
end
