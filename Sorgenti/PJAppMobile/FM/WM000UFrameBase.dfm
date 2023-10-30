object WM000FFrameBase: TWM000FFrameBase
  Left = 0
  Top = 0
  Width = 347
  Height = 610
  Margins.Left = 0
  Margins.Top = 0
  Margins.Right = 0
  Margins.Bottom = 0
  OnDestroy = UniFrameDestroy
  Layout = 'fit'
  LayoutConfig.Height = '100%'
  LayoutConfig.Width = '100%'
  ParentAlignmentControl = False
  AlignmentControl = uniAlignmentClient
  Anchors = []
  TabOrder = 0
  DesignSize = (
    347
    610)
  object MainPanel: TMedpUnimPanelBase
    Left = 0
    Top = 0
    Width = 347
    Height = 610
    Hint = ''
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    AutoScroll = True
    Anchors = []
    ParentAlignmentControl = False
    AlignmentControl = uniAlignmentClient
    LayoutAttribs.Align = 'center'
    LayoutAttribs.Pack = 'start'
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
      347
      610)
  end
end
