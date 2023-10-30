inherited WM012FElencoDipendentiFMNew: TWM012FElencoDipendentiFMNew
  OnCreate = UniFrameCreate
  OnDestroy = UniFrameDestroy
  inherited MainPanel: TMedpUnimPanelBase
    Layout = 'fit'
    object tpnlElencoDipendenti: TMedpUnimTabPanelBase
      Left = 0
      Top = 0
      Width = 347
      Height = 610
      Hint = ''
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      ActivePage = tabElencoDipendenti
      Anchors = []
      LayoutConfig.Width = '100%'
      TabBarVisible = False
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
      DesignSize = (
        347
        610)
      object tabElencoDipendenti: TUnimTabSheet
        Left = 4
        Top = 51
        Width = 339
        Height = 555
        Hint = ''
        Caption = 'tabElencoDipendenti'
        LayoutConfig.Height = '100%'
        LayoutConfig.Width = '100%'
        LayoutAttribs.Align = 'center'
        LayoutAttribs.Pack = 'start'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 347
        ExplicitHeight = 610
        DesignSize = (
          339
          555)
        object pnlNumDipendenti: TMedpUnimPanelNumElem
          Left = -4
          Top = 11
          Width = 347
          Height = 45
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
          LayoutAttribs.Pack = 'start'
          LayoutConfig.Height = '45'
          LayoutConfig.Width = '98%'
          ClickEnabled = True
          ChangeEnabled = True
          BoxModel.CSSMargin.Top = '0px'
          BoxModel.CSSMargin.Bottom = '3px'
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
          LabelNumElementi.Left = 16
          LabelNumElementi.Top = 0
          LabelNumElementi.Width = 200
          LabelNumElementi.Height = 45
          LabelNumElementi.Hint = ''
          LabelNumElementi.Margins.Left = 0
          LabelNumElementi.Margins.Top = 0
          LabelNumElementi.Margins.Right = 0
          LabelNumElementi.Margins.Bottom = 0
          LabelNumElementi.Caption = 'Nessun dipendente'
          LabelNumElementi.Flex = 1
          LabelNumElementi.LayoutConfig.Height = 'auto'
          LabelNumElementi.ParentFont = False
          LabelNumElementi.Font.Style = [fsBold]
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
          LabelNumElementi.ExplicitLeft = 0
          LabelNumElementi.DesignSize = (
            200
            45)
          Icona.Left = 16
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
          Icona.ExplicitLeft = 0
          Icona.DesignSize = (
            200
            45)
          CaptionZero = 'Nessun dipendente'
          CaptionSingolare = 'dipendente'
          CaptionPlurale = 'dipendenti'
          DesignSize = (
            347
            45)
        end
        object pnlListaDipendenti: TMedpUnimPanelListaDisclosure
          Left = -8
          Top = 56
          Width = 347
          Height = 499
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          CreateOrder = 2
          AutoScroll = True
          Anchors = []
          ParentAlignmentControl = False
          AlignmentControl = uniAlignmentClient
          LayoutAttribs.Align = 'center'
          LayoutAttribs.Pack = 'start'
          LayoutConfig.Width = '98%'
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
          ColorPari = 16448250
          CSSBordoSeparatore = '1px solid #f0f0f0'
          DesignSize = (
            347
            499)
        end
      end
      object tabDettaglio: TUnimTabSheet
        Left = 4
        Top = 51
        Width = 339
        Height = 555
        Hint = ''
        Caption = 'tabDettaglio'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 347
        ExplicitHeight = 610
        DesignSize = (
          339
          555)
        object pnlHeaderDettaglio: TMedpUnimPanelHeaderDett
          Left = 0
          Top = 0
          Width = 339
          Height = 40
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
          LayoutAttribs.Pack = 'start'
          LayoutConfig.Height = '45'
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
          Back.Left = 13
          Back.Top = 0
          Back.Width = 200
          Back.Height = 45
          Back.Hint = ''
          Back.Margins.Left = 0
          Back.Margins.Top = 0
          Back.Margins.Right = 0
          Back.Margins.Bottom = 0
          Back.Caption = 'fas fa-arrow-circle-left'
          Back.LayoutConfig.Height = '100%'
          Back.LayoutConfig.Width = '45'
          Back.ParentFont = False
          Back.Font.Height = -27
          Back.OnClick = lblBackDettaglioClick
          Back.BoxModel.CSSMargin.Top = '0px'
          Back.BoxModel.CSSMargin.Bottom = '0px'
          Back.BoxModel.CSSMargin.Right = '0px'
          Back.BoxModel.CSSMargin.Left = '0px'
          Back.BoxModel.CSSPadding.Top = '0px'
          Back.BoxModel.CSSPadding.Bottom = '0px'
          Back.BoxModel.CSSPadding.Right = '0px'
          Back.BoxModel.CSSPadding.Left = '0px'
          Back.BoxModel.CSSBorder.Top = '0px'
          Back.BoxModel.CSSBorder.Bottom = '0px'
          Back.BoxModel.CSSBorder.Right = '0px'
          Back.BoxModel.CSSBorder.Left = '0px'
          Back.ExplicitLeft = 0
          Back.DesignSize = (
            200
            45)
          LabelDettaglio.Left = 13
          LabelDettaglio.Top = 0
          LabelDettaglio.Width = 200
          LabelDettaglio.Height = 45
          LabelDettaglio.Hint = ''
          LabelDettaglio.Margins.Left = 0
          LabelDettaglio.Margins.Top = 0
          LabelDettaglio.Margins.Right = 0
          LabelDettaglio.Margins.Bottom = 0
          LabelDettaglio.Caption = ''
          LabelDettaglio.Flex = 1
          LabelDettaglio.LayoutConfig.Height = 'auto'
          LabelDettaglio.ParentFont = False
          LabelDettaglio.BoxModel.CSSMargin.Top = '0px'
          LabelDettaglio.BoxModel.CSSMargin.Bottom = '0px'
          LabelDettaglio.BoxModel.CSSMargin.Right = '0px'
          LabelDettaglio.BoxModel.CSSMargin.Left = '0px'
          LabelDettaglio.BoxModel.CSSPadding.Top = '0px'
          LabelDettaglio.BoxModel.CSSPadding.Bottom = '0px'
          LabelDettaglio.BoxModel.CSSPadding.Right = '0px'
          LabelDettaglio.BoxModel.CSSPadding.Left = '0px'
          LabelDettaglio.BoxModel.CSSBorder.Top = '0px'
          LabelDettaglio.BoxModel.CSSBorder.Bottom = '0px'
          LabelDettaglio.BoxModel.CSSBorder.Right = '0px'
          LabelDettaglio.BoxModel.CSSBorder.Left = '0px'
          LabelDettaglio.ExplicitLeft = 0
          LabelDettaglio.DesignSize = (
            200
            45)
          Up.Left = 13
          Up.Top = 0
          Up.Width = 200
          Up.Height = 45
          Up.Hint = ''
          Up.Margins.Left = 0
          Up.Margins.Top = 0
          Up.Margins.Right = 0
          Up.Margins.Bottom = 0
          Up.Caption = 'fas fa-arrow-circle-up'
          Up.LayoutConfig.Height = '100%'
          Up.LayoutConfig.Width = '45'
          Up.ParentFont = False
          Up.Font.Height = -27
          Up.OnClick = lblUpClick
          Up.BoxModel.CSSMargin.Top = '0px'
          Up.BoxModel.CSSMargin.Bottom = '0px'
          Up.BoxModel.CSSMargin.Right = '0px'
          Up.BoxModel.CSSMargin.Left = '0px'
          Up.BoxModel.CSSPadding.Top = '0px'
          Up.BoxModel.CSSPadding.Bottom = '0px'
          Up.BoxModel.CSSPadding.Right = '0px'
          Up.BoxModel.CSSPadding.Left = '0px'
          Up.BoxModel.CSSBorder.Top = '0px'
          Up.BoxModel.CSSBorder.Bottom = '0px'
          Up.BoxModel.CSSBorder.Right = '0px'
          Up.BoxModel.CSSBorder.Left = '0px'
          Up.ExplicitLeft = 0
          Up.DesignSize = (
            200
            45)
          Down.Left = 13
          Down.Top = 0
          Down.Width = 200
          Down.Height = 45
          Down.Hint = ''
          Down.Margins.Left = 0
          Down.Margins.Top = 0
          Down.Margins.Right = 0
          Down.Margins.Bottom = 0
          Down.Caption = 'fas fa-arrow-circle-down'
          Down.LayoutConfig.Height = '100%'
          Down.LayoutConfig.Width = '45'
          Down.ParentFont = False
          Down.Font.Height = -27
          Down.OnClick = lblDownClick
          Down.BoxModel.CSSMargin.Top = '0px'
          Down.BoxModel.CSSMargin.Bottom = '0px'
          Down.BoxModel.CSSMargin.Right = '0px'
          Down.BoxModel.CSSMargin.Left = '0px'
          Down.BoxModel.CSSPadding.Top = '0px'
          Down.BoxModel.CSSPadding.Bottom = '0px'
          Down.BoxModel.CSSPadding.Right = '0px'
          Down.BoxModel.CSSPadding.Left = '0px'
          Down.BoxModel.CSSBorder.Top = '0px'
          Down.BoxModel.CSSBorder.Bottom = '0px'
          Down.BoxModel.CSSBorder.Right = '0px'
          Down.BoxModel.CSSBorder.Left = '0px'
          Down.ExplicitLeft = 0
          Down.DesignSize = (
            200
            45)
          DesignSize = (
            339
            40)
        end
        object pnlListaDettaglio: TMedpUnimPanelListaDettaglio
          Left = 0
          Top = 40
          Width = 329
          Height = 515
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          CreateOrder = 2
          AutoScroll = True
          Anchors = []
          ParentAlignmentControl = False
          AlignmentControl = uniAlignmentClient
          LayoutAttribs.Align = 'center'
          LayoutAttribs.Pack = 'start'
          LayoutConfig.Width = '98%'
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
          ColorPari = 16448250
          CSSBordoSeparatore = '1px solid #f0f0f0'
          DesignSize = (
            329
            515)
        end
      end
      object tabDettaglioCampo: TUnimTabSheet
        Left = 4
        Top = 51
        Width = 339
        Height = 555
        Hint = ''
        Caption = 'tabDettaglioCampo'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 347
        ExplicitHeight = 610
        DesignSize = (
          339
          555)
        object pnlHeaderDettCampo: TMedpUnimPanelHeaderDett
          Left = 0
          Top = 8
          Width = 339
          Height = 40
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
          LayoutAttribs.Pack = 'start'
          LayoutConfig.Height = '45'
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
          Back.Left = 13
          Back.Top = 0
          Back.Width = 200
          Back.Height = 45
          Back.Hint = ''
          Back.Margins.Left = 0
          Back.Margins.Top = 0
          Back.Margins.Right = 0
          Back.Margins.Bottom = 0
          Back.Caption = 'fas fa-arrow-circle-left'
          Back.LayoutConfig.Height = '100%'
          Back.LayoutConfig.Width = '45'
          Back.ParentFont = False
          Back.Font.Height = -27
          Back.OnClick = lblBackDettCampoClick
          Back.BoxModel.CSSMargin.Top = '0px'
          Back.BoxModel.CSSMargin.Bottom = '0px'
          Back.BoxModel.CSSMargin.Right = '0px'
          Back.BoxModel.CSSMargin.Left = '0px'
          Back.BoxModel.CSSPadding.Top = '0px'
          Back.BoxModel.CSSPadding.Bottom = '0px'
          Back.BoxModel.CSSPadding.Right = '0px'
          Back.BoxModel.CSSPadding.Left = '0px'
          Back.BoxModel.CSSBorder.Top = '0px'
          Back.BoxModel.CSSBorder.Bottom = '0px'
          Back.BoxModel.CSSBorder.Right = '0px'
          Back.BoxModel.CSSBorder.Left = '0px'
          Back.ExplicitLeft = 0
          Back.DesignSize = (
            200
            45)
          LabelDettaglio.Left = 13
          LabelDettaglio.Top = 0
          LabelDettaglio.Width = 200
          LabelDettaglio.Height = 45
          LabelDettaglio.Hint = ''
          LabelDettaglio.Margins.Left = 0
          LabelDettaglio.Margins.Top = 0
          LabelDettaglio.Margins.Right = 0
          LabelDettaglio.Margins.Bottom = 0
          LabelDettaglio.Caption = ''
          LabelDettaglio.Flex = 1
          LabelDettaglio.LayoutConfig.Height = 'auto'
          LabelDettaglio.ParentFont = False
          LabelDettaglio.BoxModel.CSSMargin.Top = '0px'
          LabelDettaglio.BoxModel.CSSMargin.Bottom = '0px'
          LabelDettaglio.BoxModel.CSSMargin.Right = '0px'
          LabelDettaglio.BoxModel.CSSMargin.Left = '0px'
          LabelDettaglio.BoxModel.CSSPadding.Top = '0px'
          LabelDettaglio.BoxModel.CSSPadding.Bottom = '0px'
          LabelDettaglio.BoxModel.CSSPadding.Right = '0px'
          LabelDettaglio.BoxModel.CSSPadding.Left = '0px'
          LabelDettaglio.BoxModel.CSSBorder.Top = '0px'
          LabelDettaglio.BoxModel.CSSBorder.Bottom = '0px'
          LabelDettaglio.BoxModel.CSSBorder.Right = '0px'
          LabelDettaglio.BoxModel.CSSBorder.Left = '0px'
          LabelDettaglio.ExplicitLeft = 0
          LabelDettaglio.DesignSize = (
            200
            45)
          Up.Left = 13
          Up.Top = 0
          Up.Width = 200
          Up.Height = 45
          Up.Hint = ''
          Up.Margins.Left = 0
          Up.Margins.Top = 0
          Up.Margins.Right = 0
          Up.Margins.Bottom = 0
          Up.Visible = False
          Up.Caption = 'fas fa-arrow-circle-up'
          Up.LayoutConfig.Height = '100%'
          Up.LayoutConfig.Width = '45'
          Up.ParentFont = False
          Up.Font.Height = -27
          Up.BoxModel.CSSMargin.Top = '0px'
          Up.BoxModel.CSSMargin.Bottom = '0px'
          Up.BoxModel.CSSMargin.Right = '0px'
          Up.BoxModel.CSSMargin.Left = '0px'
          Up.BoxModel.CSSPadding.Top = '0px'
          Up.BoxModel.CSSPadding.Bottom = '0px'
          Up.BoxModel.CSSPadding.Right = '0px'
          Up.BoxModel.CSSPadding.Left = '0px'
          Up.BoxModel.CSSBorder.Top = '0px'
          Up.BoxModel.CSSBorder.Bottom = '0px'
          Up.BoxModel.CSSBorder.Right = '0px'
          Up.BoxModel.CSSBorder.Left = '0px'
          Up.ExplicitLeft = 0
          Up.DesignSize = (
            200
            45)
          Down.Left = 13
          Down.Top = 0
          Down.Width = 200
          Down.Height = 45
          Down.Hint = ''
          Down.Margins.Left = 0
          Down.Margins.Top = 0
          Down.Margins.Right = 0
          Down.Margins.Bottom = 0
          Down.Visible = False
          Down.Caption = 'fas fa-arrow-circle-down'
          Down.LayoutConfig.Height = '100%'
          Down.LayoutConfig.Width = '45'
          Down.ParentFont = False
          Down.Font.Height = -27
          Down.BoxModel.CSSMargin.Top = '0px'
          Down.BoxModel.CSSMargin.Bottom = '0px'
          Down.BoxModel.CSSMargin.Right = '0px'
          Down.BoxModel.CSSMargin.Left = '0px'
          Down.BoxModel.CSSPadding.Top = '0px'
          Down.BoxModel.CSSPadding.Bottom = '0px'
          Down.BoxModel.CSSPadding.Right = '0px'
          Down.BoxModel.CSSPadding.Left = '0px'
          Down.BoxModel.CSSBorder.Top = '0px'
          Down.BoxModel.CSSBorder.Bottom = '0px'
          Down.BoxModel.CSSBorder.Right = '0px'
          Down.BoxModel.CSSBorder.Left = '0px'
          Down.ExplicitLeft = 0
          Down.DesignSize = (
            200
            45)
          DesignSize = (
            339
            40)
        end
        object pnlListaDettCampo: TMedpUnimPanelListaDettaglio
          Left = 0
          Top = 50
          Width = 329
          Height = 505
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          CreateOrder = 2
          AutoScroll = True
          Anchors = []
          ParentAlignmentControl = False
          AlignmentControl = uniAlignmentClient
          LayoutAttribs.Align = 'center'
          LayoutAttribs.Pack = 'start'
          LayoutConfig.Width = '98%'
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
          ColorPari = 16448250
          CSSBordoSeparatore = '1px solid #f0f0f0'
          DesignSize = (
            329
            505)
        end
      end
    end
  end
end
