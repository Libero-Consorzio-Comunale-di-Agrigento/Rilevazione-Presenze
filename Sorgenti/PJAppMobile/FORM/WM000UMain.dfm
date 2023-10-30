object WM000FMain: TWM000FMain
  Left = 0
  Top = 0
  ClientHeight = 480
  ClientWidth = 514
  Caption = 
    '<span style="display: flex; align-items: center;"><img src="/fil' +
    'es/favicon/favicon-96x96.png"><p>&nbsp&nbspIrisAPP</p></span>'
  AlignmentControl = uniAlignmentClient
  Layout = 'fit'
  CloseButton.UI = 'action'
  TitleButtons = <
    item
      ButtonId = 0
      Separator = True
    end
    item
      Action = CambioProfilo
      ButtonId = 1
      IconCls = 'user'
      UI = 'action'
      ScreenMask.Enabled = True
      ScreenMask.WaitData = True
      ScreenMask.ShowMessage = False
    end>
  ShowAnimation = 'fade'
  HideAnimation = 'fadeOut'
  OnCreate = UnimFormCreate
  OnDestroy = UnimFormDestroy
  OnClose = UnimFormClose
  DesignSize = (
    514
    480)
  PixelsPerInch = 96
  TextHeight = 13
  ScrollPosition = 0
  ScrollHeight = 47
  PlatformData = {}
  object MainPanel: TMedpUnimPanelBase
    Left = 5
    Top = 5
    Width = 504
    Height = 460
    Hint = ''
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    CreateOrder = 1
    Anchors = []
    AlignmentControl = uniAlignmentClient
    Layout = 'hbox'
    LayoutAttribs.Align = 'start'
    LayoutAttribs.Pack = 'center'
    LayoutConfig.Height = '100%'
    LayoutConfig.Width = '100%'
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
    DesignSize = (
      504
      460)
    object pnlMainMenu: TMedpUnimMainMenu
      Left = 0
      Top = 0
      Width = 225
      Height = 460
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
      LayoutConfig.Height = '98%'
      LayoutConfig.Width = '300'
      ScreenMask.Enabled = True
      ScreenMask.WaitData = True
      ScreenMask.ShowMessage = False
      ClickEnabled = True
      ChangeEnabled = True
      BoxModel.CSSMargin.Top = '0px'
      BoxModel.CSSMargin.Bottom = '0px'
      BoxModel.CSSMargin.Right = '1px'
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
      Title = 'Testo di prova'
      DesignSize = (
        225
        460)
    end
    object pnlFrameBase: TMedpUnimPanelBase
      Left = 220
      Top = 0
      Width = 284
      Height = 460
      Hint = ''
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      CreateOrder = 2
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
        284
        460)
      object lblFrameTitle: TMedpUnimLabel
        Left = 48
        Top = 8
        Width = 200
        Height = 45
        Hint = ''
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        CreateOrder = 1
        Caption = ''
        ParentColor = False
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    aggiornaN' +
            'otifiche = function() '#13#10'    {'#13#10'      ajaxRequest'#13#10'      ('#13#10'     ' +
            '   WM000FMain.lblFrameTitle,'#13#10'        "AggiornaNotifiche",'#13#10'    ' +
            '    []'#13#10'      );'#13#10'    };'#13#10'}')
        LayoutConfig.Cls = 'background-blue'
        LayoutConfig.Height = '36'
        LayoutConfig.Width = '100%'
        ParentFont = False
        Font.Style = [fsBold]
        Color = clWhite
        OnAjaxEvent = lblFrameTitleAjaxEvent
        BoxModel.CSSMargin.Top = '1px'
        BoxModel.CSSMargin.Bottom = '1px'
        BoxModel.CSSMargin.Right = '0px'
        BoxModel.CSSMargin.Left = '0px'
        BoxModel.CSSPadding.Top = '0px'
        BoxModel.CSSPadding.Bottom = '0px'
        BoxModel.CSSPadding.Right = '0px'
        BoxModel.CSSPadding.Left = '0px'
        BoxModel.CSSBorder.Top = '0px solid white'
        BoxModel.CSSBorder.Bottom = '0px solid white'
        BoxModel.CSSBorder.Right = '0px'
        BoxModel.CSSBorder.Left = '0px'
        BoxModel.CSSBorderRadius = '0px'
        DesignSize = (
          200
          45)
      end
      object pnlFrame: TMedpUnimPanelBase
        Left = 0
        Top = 40
        Width = 284
        Height = 420
        Hint = ''
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        CreateOrder = 2
        Anchors = []
        ParentAlignmentControl = False
        AlignmentControl = uniAlignmentClient
        Layout = 'fit'
        LayoutConfig.Width = '100%'
        Flex = 1
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
        DesignSize = (
          284
          420)
      end
    end
  end
  object ActionList: TActionList
    Left = 240
    Top = 56
    object CambioProfilo: TAction
      OnExecute = CambioProfiloExecute
    end
  end
end
