inherited WR002FRichiesteFM: TWR002FRichiesteFM
  OnCreate = UniFrameCreate
  inherited MainPanel: TMedpUnimPanelBase
    object tpnlRichieste: TMedpUnimTabPanelBase
      Left = 0
      Top = 0
      Width = 347
      Height = 610
      Hint = ''
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      ActivePage = tabElenco
      Anchors = []
      ClientEvents.UniEvents.Strings = (
        
          'afterCreate=function afterCreate(sender){ sender.getTabBar().hid' +
          'e(); }')
      LayoutConfig.Height = '100%'
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
      BoxModel.CSSBorderRadius = '0px'
      DesignSize = (
        347
        610)
      object tabElenco: TUnimTabSheet
        Left = 4
        Top = 51
        Width = 339
        Height = 555
        Hint = ''
        Caption = 'tabElenco'
        LayoutAttribs.Align = 'center'
        LayoutAttribs.Pack = 'start'
        DesignSize = (
          339
          555)
        object rgpTipoRichiesta: TMedpUnimRadioGroup
          Left = 0
          Top = 0
          Width = 347
          Height = 46
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
          LayoutConfig.Height = '45'
          LayoutConfig.Width = '98%'
          ScreenMask.Enabled = True
          ScreenMask.WaitData = True
          ScreenMask.ShowMessage = False
          ScreenMask.Target = Owner
          OnChange = OnFiltriRichiestaChange
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
          Items.Strings = (
            'Da autorizzare'
            'Autorizzate'
            'Negate')
          ItemIndex = 0
          DesignSize = (
            347
            46)
        end
        object pnlDataDaA: TMedpUnimPanelDataDaA
          Left = -4
          Top = 46
          Width = 347
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
          LayoutConfig.Height = '40'
          LayoutConfig.Width = '98%'
          ScreenMask.Enabled = True
          ScreenMask.WaitData = True
          ScreenMask.ShowMessage = False
          OnChange = OnFiltriRichiestaChange
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
          DataDa.Left = 16
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
          DataDa.DateFormat = 'dd/MM/yyyy'
          DataDa.LayoutConfig.Height = '100%'
          DataDa.SlotOrder = 'd/m/y'
          DataDa.Date = 43769.000000000000000000
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
          Separatore.Left = 16
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
          DataA.Left = 16
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
          DataA.DateFormat = 'dd/MM/yyyy'
          DataA.LayoutConfig.Height = '100%'
          DataA.SlotOrder = 'd/m/y'
          DataA.Date = 43769.000000000000000000
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
            347
            40)
        end
        object pnlFiltroRichieste: TMedpUnimPanelBase
          Left = 0
          Top = 89
          Width = 339
          Height = 50
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          CreateOrder = 3
          Anchors = []
          ParentAlignmentControl = False
          AlignmentControl = uniAlignmentClient
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
            339
            50)
        end
        object pnlNumRichieste: TMedpUnimPanelNumElem
          Left = -4
          Top = 139
          Width = 347
          Height = 45
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
          LayoutAttribs.Pack = 'start'
          LayoutConfig.Height = '45'
          LayoutConfig.Width = '98%'
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
          LabelNumElementi.Left = 16
          LabelNumElementi.Top = 0
          LabelNumElementi.Width = 200
          LabelNumElementi.Height = 45
          LabelNumElementi.Hint = ''
          LabelNumElementi.Margins.Left = 0
          LabelNumElementi.Margins.Top = 0
          LabelNumElementi.Margins.Right = 0
          LabelNumElementi.Margins.Bottom = 0
          LabelNumElementi.Caption = 'Nessuna richiesta'
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
          LabelNumElementi.BoxModel.CSSBorderRadius = '0px'
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
          Icona.Caption = 'fas fa-plus-circle'
          Icona.ScreenMask.Enabled = True
          Icona.ScreenMask.WaitData = True
          Icona.ScreenMask.Message = 'Caricamento...'
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
          CaptionZero = 'Nessuna richiesta'
          CaptionSingolare = 'richiesta'
          CaptionPlurale = 'richieste'
          DesignSize = (
            347
            45)
        end
        object pnlListaRichieste: TMedpUnimPanelListaDisclosure
          Left = -4
          Top = 184
          Width = 347
          Height = 375
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          CreateOrder = 5
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
          ScreenMask.ShowMessage = False
          OnChange = OnPnlListaRichiesteChange
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
          ColorHeader = 15455685
          DesignSize = (
            347
            375)
        end
      end
      object tabDettaglio: TUnimTabSheet
        Left = 4
        Top = 51
        Width = 339
        Height = 555
        Hint = ''
        Caption = 'tabDettaglio'
        LayoutAttribs.Align = 'center'
        LayoutAttribs.Pack = 'start'
        DesignSize = (
          339
          555)
        object pnlHeaderDettaglio: TMedpUnimPanelHeaderDett
          Left = 0
          Top = 0
          Width = 339
          Height = 46
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
          Back.Left = 13
          Back.Top = 3
          Back.Width = 200
          Back.Height = 45
          Back.Hint = ''
          Back.Margins.Left = 0
          Back.Margins.Top = 0
          Back.Margins.Right = 0
          Back.Margins.Bottom = 0
          Back.Caption = 'fas fa-arrow-circle-left'
          Back.ScreenMask.Enabled = True
          Back.ScreenMask.ShowMessage = False
          Back.LayoutConfig.Height = '100%'
          Back.LayoutConfig.Width = '45'
          Back.ParentFont = False
          Back.Font.Height = -27
          Back.OnClick = OnBackClick
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
          Back.BoxModel.CSSBorderRadius = '0px'
          Back.DesignSize = (
            200
            45)
          LabelDettaglio.Left = 13
          LabelDettaglio.Top = 3
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
          LabelDettaglio.JustifyContent = JustifyStart
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
          LabelDettaglio.BoxModel.CSSBorderRadius = '0px'
          LabelDettaglio.DesignSize = (
            200
            45)
          Up.Left = 13
          Up.Top = 3
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
          Up.OnClick = OnHeaderDettaglioUpClick
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
          Up.BoxModel.CSSBorderRadius = '0px'
          Up.DesignSize = (
            200
            45)
          Down.Left = 13
          Down.Top = 3
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
          Down.OnClick = OnHeaderDettaglioDownClick
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
          Down.BoxModel.CSSBorderRadius = '0px'
          Down.DesignSize = (
            200
            45)
          DesignSize = (
            339
            46)
        end
        object pnlListaDettaglio: TMedpUnimPanelListaDettaglio
          Left = 0
          Top = 62
          Width = 339
          Height = 493
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
          LayoutConfig.Width = '98%'
          Flex = 1
          ScreenMask.Enabled = True
          ScreenMask.WaitData = True
          ScreenMask.ShowMessage = False
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
          ColorHeader = clGradientInactiveCaption
          DesignSize = (
            339
            493)
        end
      end
      object tabNote: TUnimTabSheet
        Left = 4
        Top = 51
        Width = 339
        Height = 555
        Hint = ''
        Caption = 'tabNote'
        LayoutAttribs.Align = 'center'
        LayoutAttribs.Pack = 'start'
        DesignSize = (
          339
          555)
        object pnlHeaderNote: TMedpUnimPanelHeaderDett
          Left = 0
          Top = 0
          Width = 339
          Height = 46
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
          Back.Left = 13
          Back.Top = 3
          Back.Width = 200
          Back.Height = 45
          Back.Hint = ''
          Back.Margins.Left = 0
          Back.Margins.Top = 0
          Back.Margins.Right = 0
          Back.Margins.Bottom = 0
          Back.Caption = 'fas fa-arrow-circle-left'
          Back.ScreenMask.Enabled = True
          Back.ScreenMask.ShowMessage = False
          Back.LayoutConfig.Height = '100%'
          Back.LayoutConfig.Width = '45'
          Back.ParentFont = False
          Back.Font.Height = -27
          Back.OnClick = OnBackClick
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
          Back.BoxModel.CSSBorderRadius = '0px'
          Back.DesignSize = (
            200
            45)
          LabelDettaglio.Left = 13
          LabelDettaglio.Top = 3
          LabelDettaglio.Width = 200
          LabelDettaglio.Height = 45
          LabelDettaglio.Hint = ''
          LabelDettaglio.Margins.Left = 0
          LabelDettaglio.Margins.Top = 0
          LabelDettaglio.Margins.Right = 0
          LabelDettaglio.Margins.Bottom = 0
          LabelDettaglio.Caption = 'Note'
          LabelDettaglio.Flex = 1
          LabelDettaglio.LayoutConfig.Height = 'auto'
          LabelDettaglio.ParentFont = False
          LabelDettaglio.JustifyContent = JustifyStart
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
          LabelDettaglio.BoxModel.CSSBorderRadius = '0px'
          LabelDettaglio.DesignSize = (
            200
            45)
          Up.Left = 13
          Up.Top = 3
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
          Up.BoxModel.CSSBorderRadius = '0px'
          Up.DesignSize = (
            200
            45)
          Down.Left = 13
          Down.Top = 3
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
          Down.BoxModel.CSSBorderRadius = '0px'
          Down.DesignSize = (
            200
            45)
          DesignSize = (
            339
            46)
        end
        object pnlListaNote: TMedpUnimPanelListaElem
          Left = 2
          Top = 46
          Width = 337
          Height = 509
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
          BoxModel.CSSBorderRadius = '0px'
          CSSBordoSeparatore = '1px solid #f0f0f0'
          DesignSize = (
            337
            509)
        end
      end
      object tabAllegati: TUnimTabSheet
        Left = 4
        Top = 51
        Width = 339
        Height = 555
        Hint = ''
        Caption = 'tabAllegati'
        LayoutAttribs.Align = 'center'
        LayoutAttribs.Pack = 'start'
        DesignSize = (
          339
          555)
        object pnlHeaderAllegati: TMedpUnimPanelHeaderDett
          Left = 2
          Top = 6
          Width = 337
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
          LayoutConfig.Width = '98%'
          DaContare = False
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
          Back.Left = 12
          Back.Top = 0
          Back.Width = 200
          Back.Height = 45
          Back.Hint = ''
          Back.Margins.Left = 0
          Back.Margins.Top = 0
          Back.Margins.Right = 0
          Back.Margins.Bottom = 0
          Back.Caption = 'fas fa-arrow-circle-left'
          Back.ScreenMask.Enabled = True
          Back.ScreenMask.ShowMessage = False
          Back.LayoutConfig.Height = '100%'
          Back.LayoutConfig.Width = '45'
          Back.ParentFont = False
          Back.Font.Height = -27
          Back.OnClick = OnBackClick
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
          Back.BoxModel.CSSBorderRadius = '0px'
          Back.DesignSize = (
            200
            45)
          LabelDettaglio.Left = 12
          LabelDettaglio.Top = 0
          LabelDettaglio.Width = 200
          LabelDettaglio.Height = 45
          LabelDettaglio.Hint = ''
          LabelDettaglio.Margins.Left = 0
          LabelDettaglio.Margins.Top = 0
          LabelDettaglio.Margins.Right = 0
          LabelDettaglio.Margins.Bottom = 0
          LabelDettaglio.Caption = 'Allegati'
          LabelDettaglio.Flex = 1
          LabelDettaglio.LayoutConfig.Height = 'auto'
          LabelDettaglio.ParentFont = False
          LabelDettaglio.JustifyContent = JustifyStart
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
          LabelDettaglio.BoxModel.CSSBorderRadius = '0px'
          LabelDettaglio.DesignSize = (
            200
            45)
          Up.Left = 12
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
          Up.BoxModel.CSSBorderRadius = '0px'
          Up.DesignSize = (
            200
            45)
          Down.Left = 12
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
          Down.BoxModel.CSSBorderRadius = '0px'
          Down.DesignSize = (
            200
            45)
          DesignSize = (
            337
            40)
        end
        object pnlNuovoModifica: TMedpUnimPanelBase
          Left = 0
          Top = 46
          Width = 337
          Height = 269
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          CreateOrder = 2
          Anchors = []
          ClientEvents.UniEvents.Strings = (
            
              'afterCreate=function afterCreate(sender)'#13#10'{'#13#10'   sender.setStyle(' +
              '"transition: width 500ms, height 500ms");'#13#10'}')
          ParentAlignmentControl = False
          AlignmentControl = uniAlignmentClient
          LayoutAttribs.Align = 'center'
          LayoutAttribs.Pack = 'justify'
          LayoutConfig.Height = '0px'
          LayoutConfig.Width = '98%'
          ClickEnabled = True
          ChangeEnabled = True
          BoxModel.CSSMargin.Top = '0px'
          BoxModel.CSSMargin.Bottom = '2px'
          BoxModel.CSSMargin.Right = '0px'
          BoxModel.CSSMargin.Left = '0px'
          BoxModel.CSSPadding.Top = '0px'
          BoxModel.CSSPadding.Bottom = '0px'
          BoxModel.CSSPadding.Right = '3px'
          BoxModel.CSSPadding.Left = '3px'
          BoxModel.CSSBorder.Top = '0px'
          BoxModel.CSSBorder.Bottom = '0px'
          BoxModel.CSSBorder.Right = '0px'
          BoxModel.CSSBorder.Left = '0px'
          BoxModel.CSSBorderRadius = '0px'
          DesignSize = (
            337
            269)
          object lblInsAllegato: TMedpUnimLabel
            Left = 3
            Top = 6
            Width = 334
            Height = 24
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 1
            Caption = 'Inserimento allegato'
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '100%'
            ParentFont = False
            Font.Height = -20
            Font.Style = [fsBold, fsUnderline]
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
            DesignSize = (
              334
              24)
          end
          object pnlUpload: TMedpUnimPanelBase
            Left = 0
            Top = 63
            Width = 337
            Height = 50
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
              337
              50)
            object edtUploadFile: TMedpUnimEdit
              Left = 72
              Top = 5
              Width = 200
              Height = 45
              Hint = ''
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 0
              Margins.Bottom = 0
              CreateOrder = 1
              BoxModel.CSSMargin.Top = '0px'
              BoxModel.CSSMargin.Bottom = '0px'
              BoxModel.CSSMargin.Right = '5px'
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
              Text = ''
              ClearButton = False
              EmptyText = '(nessun file selezionato)'
              ParentFont = False
              Font.Style = [fsItalic]
              Flex = 1
              ReadOnly = True
              LayoutConfig.Height = '100%'
              TabOrder = 1
              TabStop = False
              DesignSize = (
                200
                45)
            end
          end
          object pnlModificaFile: TMedpUnimPanel2Labels
            Left = 0
            Top = 26
            Width = 334
            Height = 45
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
            LayoutConfig.Height = '20'
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
            Label1.Left = 11
            Label1.Top = 0
            Label1.Width = 200
            Label1.Height = 45
            Label1.Hint = ''
            Label1.Margins.Left = 0
            Label1.Margins.Top = 0
            Label1.Margins.Right = 0
            Label1.Margins.Bottom = 0
            Label1.Caption = 'Nome file:  '
            Label1.Flex = 1
            Label1.LayoutConfig.Height = 'auto'
            Label1.LayoutConfig.Width = '25%'
            Label1.ParentFont = False
            Label1.Font.Style = [fsBold]
            Label1.JustifyContent = JustifyStart
            Label1.BoxModel.CSSMargin.Top = '0px'
            Label1.BoxModel.CSSMargin.Bottom = '0px'
            Label1.BoxModel.CSSMargin.Right = '0px'
            Label1.BoxModel.CSSMargin.Left = '0px'
            Label1.BoxModel.CSSPadding.Top = '0px'
            Label1.BoxModel.CSSPadding.Bottom = '0px'
            Label1.BoxModel.CSSPadding.Right = '0px'
            Label1.BoxModel.CSSPadding.Left = '0px'
            Label1.BoxModel.CSSBorder.Top = '0px'
            Label1.BoxModel.CSSBorder.Bottom = '0px'
            Label1.BoxModel.CSSBorder.Right = '0px'
            Label1.BoxModel.CSSBorder.Left = '0px'
            Label1.BoxModel.CSSBorderRadius = '0px'
            Label1.DesignSize = (
              200
              45)
            Label2.Left = 11
            Label2.Top = 0
            Label2.Width = 200
            Label2.Height = 45
            Label2.Hint = ''
            Label2.Margins.Left = 0
            Label2.Margins.Top = 0
            Label2.Margins.Right = 0
            Label2.Margins.Bottom = 0
            Label2.Caption = ''
            Label2.Flex = 3
            Label2.LayoutConfig.Cls = 'white-space-nowrap'
            Label2.LayoutConfig.Height = 'auto'
            Label2.LayoutConfig.Width = '75%'
            Label2.ParentFont = False
            Label2.Font.Style = [fsBold]
            Label2.JustifyContent = JustifyStart
            Label2.BoxModel.CSSMargin.Top = '0px'
            Label2.BoxModel.CSSMargin.Bottom = '0px'
            Label2.BoxModel.CSSMargin.Right = '0px'
            Label2.BoxModel.CSSMargin.Left = '0px'
            Label2.BoxModel.CSSPadding.Top = '0px'
            Label2.BoxModel.CSSPadding.Bottom = '0px'
            Label2.BoxModel.CSSPadding.Right = '0px'
            Label2.BoxModel.CSSPadding.Left = '0px'
            Label2.BoxModel.CSSBorder.Top = '0px'
            Label2.BoxModel.CSSBorder.Bottom = '0px'
            Label2.BoxModel.CSSBorder.Right = '0px'
            Label2.BoxModel.CSSBorder.Left = '0px'
            Label2.BoxModel.CSSBorderRadius = '0px'
            Label2.DesignSize = (
              200
              45)
            DesignSize = (
              334
              45)
          end
          object lblInsNote: TMedpUnimLabel
            Left = 0
            Top = 113
            Width = 334
            Height = 40
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 3
            Caption = 'Note:'
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '100%'
            ParentFont = False
            Font.Style = [fsBold]
            JustifyContent = JustifyStart
            BoxModel.CSSMargin.Top = '5px'
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
              334
              40)
          end
          object memNoteAllegato: TMedpUnimMemo
            Left = 3
            Top = 138
            Width = 337
            Height = 40
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 4
            Anchors = []
            ParentAlignmentControl = False
            AlignmentControl = uniAlignmentClient
            Layout = 'fit'
            LayoutConfig.Height = '50'
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
            ConfermaIcon.Left = 69
            ConfermaIcon.Top = -4
            ConfermaIcon.Width = 200
            ConfermaIcon.Height = 45
            ConfermaIcon.Hint = ''
            ConfermaIcon.Margins.Left = 0
            ConfermaIcon.Margins.Top = 0
            ConfermaIcon.Margins.Right = 0
            ConfermaIcon.Margins.Bottom = 0
            ConfermaIcon.Visible = False
            ConfermaIcon.Caption = 'fas fa-check-circle'
            ConfermaIcon.ClientEvents.UniEvents.Strings = (
              
                'afterCreate= function afterCreate(sender) { sender.setStyle("pos' +
                'ition: absolute; bottom: 8px; right: 5px;");}')
            ConfermaIcon.LayoutConfig.Height = 'auto'
            ConfermaIcon.LayoutConfig.Width = 'auto'
            ConfermaIcon.ParentFont = False
            ConfermaIcon.Font.Height = -29
            ConfermaIcon.BoxModel.CSSMargin.Top = '0px'
            ConfermaIcon.BoxModel.CSSMargin.Bottom = '0px'
            ConfermaIcon.BoxModel.CSSMargin.Right = '0px'
            ConfermaIcon.BoxModel.CSSMargin.Left = '0px'
            ConfermaIcon.BoxModel.CSSPadding.Top = '0px'
            ConfermaIcon.BoxModel.CSSPadding.Bottom = '0px'
            ConfermaIcon.BoxModel.CSSPadding.Right = '0px'
            ConfermaIcon.BoxModel.CSSPadding.Left = '0px'
            ConfermaIcon.BoxModel.CSSBorder.Top = '0px'
            ConfermaIcon.BoxModel.CSSBorder.Bottom = '0px'
            ConfermaIcon.BoxModel.CSSBorder.Right = '0px'
            ConfermaIcon.BoxModel.CSSBorder.Left = '0px'
            ConfermaIcon.BoxModel.CSSBorderRadius = '0px'
            ConfermaIcon.DesignSize = (
              200
              45)
            Memo.Left = 0
            Memo.Top = 0
            Memo.Width = 225
            Memo.Height = 235
            Memo.Hint = ''
            Memo.LayoutConfig.Height = '100%'
            Memo.LayoutConfig.Width = '100%'
            Memo.TabOrder = 0
            DesignSize = (
              337
              40)
          end
          object chkAllConformi: TUnimCheckBox
            Left = 14
            Top = 178
            Width = 311
            Height = 47
            Hint = ''
            CreateOrder = 5
            FieldLabel = 
              'Il sottoscritto ai sensi dell'#39#39'art. 76 del D.P.R. n. 445/2000 di' +
              'chiara sotto la propria responsabilit&agrave; che gli allegati f' +
              'orniti sono conformi agli originali'
            FieldLabelAlign = laRight
            FieldLabelWidth = 90
            FieldLabelFont.Height = -13
            Caption = 
              'Il sottoscritto ai sensi dell'#39#39'art. 76 del D.P.R. n. 445/2000 di' +
              'chiara sotto la propria responsabilit&agrave; che gli allegati f' +
              'orniti sono conformi agli originali'
            ClientEvents.UniEvents.Strings = (
              
                'afterCreate=function afterCreate(sender)'#13#10'{'#13#10'  sender.setLabelWr' +
                'ap(true);'#13#10'}')
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '100%'
            OnClick = chkAllConformiClick
          end
          object pnlOkAnnullaAllegato: TMedpUnimPanel2Button
            Left = 3
            Top = 224
            Width = 334
            Height = 45
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 6
            Anchors = []
            ParentAlignmentControl = False
            AlignmentControl = uniAlignmentClient
            Layout = 'hbox'
            LayoutAttribs.Align = 'center'
            LayoutAttribs.Pack = 'start'
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '100%'
            ClickEnabled = True
            ChangeEnabled = True
            BoxModel.CSSMargin.Top = '6px'
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
            Button1.Left = 11
            Button1.Top = 0
            Button1.Width = 200
            Button1.Height = 45
            Button1.Hint = ''
            Button1.Margins.Left = 0
            Button1.Margins.Top = 0
            Button1.Margins.Right = 0
            Button1.Margins.Bottom = 0
            Button1.Anchors = []
            Button1.ScreenMask.Enabled = True
            Button1.Flex = 1
            Button1.UI = 'action'
            Button1.IconCls = 'fas fa-check'
            Button1.Caption = 'Ok'
            Button1.LayoutConfig.Height = '40'
            Button1.OnClick = btnConfermaAllegatoClick
            Button1.BoxModel.CSSMargin.Top = '0px'
            Button1.BoxModel.CSSMargin.Bottom = '0px'
            Button1.BoxModel.CSSMargin.Right = '0px'
            Button1.BoxModel.CSSMargin.Left = '0px'
            Button1.BoxModel.CSSPadding.Top = '0px'
            Button1.BoxModel.CSSPadding.Bottom = '0px'
            Button1.BoxModel.CSSPadding.Right = '0px'
            Button1.BoxModel.CSSPadding.Left = '0px'
            Button1.BoxModel.CSSBorder.Top = '0px'
            Button1.BoxModel.CSSBorder.Bottom = '0px'
            Button1.BoxModel.CSSBorder.Right = '0px'
            Button1.BoxModel.CSSBorder.Left = '0px'
            Button1.BoxModel.CSSBorderRadius = '0px'
            Button1.DesignSize = (
              200
              45)
            Button2.Left = 11
            Button2.Top = 0
            Button2.Width = 200
            Button2.Height = 45
            Button2.Hint = ''
            Button2.Margins.Left = 0
            Button2.Margins.Top = 0
            Button2.Margins.Right = 0
            Button2.Margins.Bottom = 0
            Button2.Anchors = []
            Button2.Flex = 1
            Button2.UI = 'action'
            Button2.IconCls = 'delete'
            Button2.Caption = 'Annulla'
            Button2.LayoutConfig.Height = '40'
            Button2.OnClick = btnAnnullaAllegatoClick
            Button2.BoxModel.CSSMargin.Top = '0px'
            Button2.BoxModel.CSSMargin.Bottom = '0px'
            Button2.BoxModel.CSSMargin.Right = '0px'
            Button2.BoxModel.CSSMargin.Left = '6px'
            Button2.BoxModel.CSSPadding.Top = '0px'
            Button2.BoxModel.CSSPadding.Bottom = '0px'
            Button2.BoxModel.CSSPadding.Right = '0px'
            Button2.BoxModel.CSSPadding.Left = '0px'
            Button2.BoxModel.CSSBorder.Top = '0px'
            Button2.BoxModel.CSSBorder.Bottom = '0px'
            Button2.BoxModel.CSSBorder.Right = '0px'
            Button2.BoxModel.CSSBorder.Left = '0px'
            Button2.BoxModel.CSSBorderRadius = '0px'
            Button2.DesignSize = (
              200
              45)
            DesignSize = (
              334
              45)
          end
        end
        object pnlNumAllegati: TMedpUnimPanelNumElem
          Left = 0
          Top = 315
          Width = 339
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
          LayoutConfig.Height = '35'
          LayoutConfig.Width = '98%'
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
          LabelNumElementi.Left = 13
          LabelNumElementi.Top = 0
          LabelNumElementi.Width = 200
          LabelNumElementi.Height = 45
          LabelNumElementi.Hint = ''
          LabelNumElementi.Margins.Left = 0
          LabelNumElementi.Margins.Top = 0
          LabelNumElementi.Margins.Right = 0
          LabelNumElementi.Margins.Bottom = 0
          LabelNumElementi.Caption = 'Nessun allegato presente'
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
          LabelNumElementi.BoxModel.CSSBorderRadius = '0px'
          LabelNumElementi.DesignSize = (
            200
            45)
          Icona.Left = 13
          Icona.Top = 0
          Icona.Width = 200
          Icona.Height = 45
          Icona.Hint = ''
          Icona.Margins.Left = 0
          Icona.Margins.Top = 0
          Icona.Margins.Right = 0
          Icona.Margins.Bottom = 0
          Icona.Caption = 'fas fa-plus-circle'
          Icona.LayoutConfig.Height = '100%'
          Icona.LayoutConfig.Width = '40'
          Icona.ParentFont = False
          Icona.Font.Height = -27
          Icona.OnClick = pnlNumAllegatilblIconaClick
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
          CaptionZero = 'Nessun allegato presente'
          CaptionSingolare = 'allegato presente'
          CaptionPlurale = 'allegati presenti'
          DesignSize = (
            339
            45)
        end
        object pnlListaAllegati: TMedpUnimPanelListaElem
          Left = 0
          Top = 360
          Width = 337
          Height = 195
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
          OnChange = pnlListaAllegatiChange
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
            337
            195)
        end
      end
    end
  end
end
