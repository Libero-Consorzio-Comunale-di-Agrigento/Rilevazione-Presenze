object WM016FGoogleMaps: TWM016FGoogleMaps
  Left = 0
  Top = 0
  ClientHeight = 480
  ClientWidth = 320
  Caption = 
    '<span style="display: flex; align-items: center;"><img src="/fil' +
    'es/favicon/favicon-32x32.png"><p>&nbsp&nbspMappa rilevatori</p><' +
    '/span>'
  AlignmentControl = uniAlignmentClient
  Layout = 'fit'
  CloseButton.UI = 'action'
  TitleDocked = True
  TitleButtons = <>
  OnCreate = UnimFormCreate
  OnDestroy = UnimFormDestroy
  OnReady = UnimFormReady
  DesignSize = (
    320
    480)
  PixelsPerInch = 96
  TextHeight = 13
  ScrollPosition = 0
  ScrollHeight = 47
  PlatformData = {}
  object HTMLFrame: TUnimHTMLFrame
    Left = 0
    Top = 0
    Width = 321
    Height = 481
    Hint = ''
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    CreateOrder = 1
    HTML.Strings = (
      
        '<div id="map_canvas" style="position: absolute; width: 100%; hei' +
        'ght: 100%"></div>')
    Anchors = []
  end
end
