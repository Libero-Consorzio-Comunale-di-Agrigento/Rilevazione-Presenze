object WM000FMessageDlg: TWM000FMessageDlg
  Left = 0
  Top = 0
  Margins.Left = 0
  Margins.Top = 0
  Margins.Right = 0
  Margins.Bottom = 0
  ClientHeight = 138
  ClientWidth = 280
  Caption = 'WM000FMessageDlg'
  AlignmentControl = uniAlignmentClient
  LayoutConfig.Height = 'auto'
  LayoutAttribs.Align = 'center'
  LayoutAttribs.Pack = 'justify'
  BorderIcons = []
  AutoHeight = False
  DisplayCaption = False
  ClientEvents.UniEvents.Strings = (
    
      'window.afterCreate=function window.afterCreate(sender)'#13#10'{'#13#10'  //s' +
      'ender.setHeight('#39'auto'#39');'#13#10'}')
  ShowTitle = False
  FullScreen = False
  CloseButton.Visible = False
  TitleButtons = <>
  ShowAnimation = 'fade'
  DesignSize = (
    280
    138)
  PixelsPerInch = 96
  TextHeight = 13
  ScrollPosition = 0
  ScrollHeight = 0
  PlatformData = {}
  object pnlTitolo: TMedpUnimPanelBase
    Left = 5
    Top = -5
    Width = 270
    Height = 36
    Hint = ''
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    CreateOrder = 1
    Anchors = []
    AlignmentControl = uniAlignmentClient
    LayoutAttribs.Align = 'center'
    LayoutAttribs.Pack = 'center'
    LayoutConfig.Cls = 'x-uni-window-header'
    LayoutConfig.Height = '35'
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
      270
      36)
    object lblTitolo: TMedpUnimLabel
      Left = 64
      Top = -79
      Width = 200
      Height = 45
      Hint = ''
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Caption = 'lblTitolo'
      ParentFont = False
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
  end
  object pnlTesto: TMedpUnimPanelBase
    Left = 5
    Top = 31
    Width = 270
    Height = 42
    Hint = ''
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    CreateOrder = 2
    Anchors = []
    AlignmentControl = uniAlignmentClient
    LayoutAttribs.Align = 'center'
    LayoutAttribs.Pack = 'center'
    LayoutConfig.Height = 'auto'
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
      270
      42)
    object lblTesto: TMedpUnimLabel
      Left = 54
      Top = 1
      Width = 200
      Height = 45
      Hint = ''
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Caption = 'lblTesto'
      LayoutConfig.Height = 'auto'
      LayoutConfig.Width = '90%'
      ParentFont = False
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
  end
  object pnlButtons: TMedpUnimPanelBase
    Left = 5
    Top = 77
    Width = 270
    Height = 43
    Hint = ''
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    CreateOrder = 3
    Anchors = []
    AlignmentControl = uniAlignmentClient
    Layout = 'hbox'
    LayoutAttribs.Align = 'center'
    LayoutAttribs.Pack = 'center'
    LayoutConfig.Height = '40'
    LayoutConfig.Width = '80%'
    ClickEnabled = True
    ChangeEnabled = True
    BoxModel.CSSMargin.Top = '0px'
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
    BoxModel.CSSBorderRadius = '0px'
    DesignSize = (
      270
      43)
    object Button1: TMedpUnimButton
      Left = 10
      Top = 0
      Width = 113
      Height = 45
      Hint = ''
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      CreateOrder = 1
      Anchors = []
      UI = 'action'
      Caption = 'Si'
      ModalResult = 6
      LayoutConfig.Height = '35'
      LayoutConfig.Width = '45%'
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
        113
        45)
    end
    object Button2: TMedpUnimButton
      Left = 149
      Top = 0
      Width = 105
      Height = 45
      Hint = ''
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      CreateOrder = 2
      Anchors = []
      UI = 'action'
      Caption = 'No'
      ModalResult = 7
      LayoutConfig.Height = '35'
      LayoutConfig.Width = '45%'
      BoxModel.CSSMargin.Top = '0px'
      BoxModel.CSSMargin.Bottom = '0px'
      BoxModel.CSSMargin.Right = '0px'
      BoxModel.CSSMargin.Left = '10px'
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
        105
        45)
    end
  end
end
