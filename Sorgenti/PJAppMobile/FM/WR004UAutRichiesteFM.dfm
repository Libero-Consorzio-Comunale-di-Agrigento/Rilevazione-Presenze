inherited WR004FAutRichiesteFM: TWR004FAutRichiesteFM
  inherited MainPanel: TMedpUnimPanelBase
    inherited tpnlRichieste: TMedpUnimTabPanelBase
      inherited tabElenco: TUnimTabSheet
        inherited rgpTipoRichiesta: TMedpUnimRadioGroup
          ScreenMask.Target = Owner
        end
        inherited pnlNumRichieste: TMedpUnimPanelNumElem
          Icona.Visible = False
        end
        inherited pnlListaRichieste: TMedpUnimPanelListaDisclosure
          Height = 270
          ExplicitHeight = 270
          DesignSize = (
            347
            270)
        end
        object pnlAutorizzaTutti: TMedpUnimPanelSlideUp
          Left = -8
          Top = 405
          Width = 347
          Height = 150
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Anchors = []
          ClientEvents.UniEvents.Strings = (
            
              'afterCreate= function afterCreate(sender) { sender.setStyle("tra' +
              'nsition: width 500ms, height 500ms");}')
          ParentAlignmentControl = False
          AlignmentControl = uniAlignmentClient
          LayoutAttribs.Align = 'center'
          LayoutAttribs.Pack = 'start'
          LayoutConfig.Height = '30'
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
          BoxModel.CSSBorderRadius = '15px 15px 0px 0px'
          HeightAperto = 82
          DesignSize = (
            347
            150)
          object pnlAutorizzaNegaTutti: TMedpUnimPanel2Button
            Left = -2
            Top = 70
            Width = 339
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
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '100%'
            ClickEnabled = True
            ChangeEnabled = True
            BoxModel.CSSMargin.Top = '6px'
            BoxModel.CSSMargin.Bottom = '6px'
            BoxModel.CSSMargin.Right = '0'
            BoxModel.CSSMargin.Left = '0'
            BoxModel.CSSPadding.Top = '0px'
            BoxModel.CSSPadding.Bottom = '0px'
            BoxModel.CSSPadding.Right = '3px'
            BoxModel.CSSPadding.Left = '3px'
            BoxModel.CSSBorder.Top = '0px'
            BoxModel.CSSBorder.Bottom = '0px'
            BoxModel.CSSBorder.Right = '0px'
            BoxModel.CSSBorder.Left = '0px'
            BoxModel.CSSBorderRadius = '0px'
            Button1.Left = 13
            Button1.Top = 0
            Button1.Width = 200
            Button1.Height = 45
            Button1.Hint = ''
            Button1.Margins.Left = 0
            Button1.Margins.Top = 0
            Button1.Margins.Right = 0
            Button1.Margins.Bottom = 0
            Button1.Anchors = []
            Button1.Flex = 1
            Button1.UI = 'action'
            Button1.IconCls = 'fas fa-check'
            Button1.Caption = 'Autorizza tutti'
            Button1.LayoutConfig.Height = '40'
            Button1.OnClick = btnAutorizzaTuttiClick
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
            Button2.Left = 13
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
            Button2.Caption = 'Nega tutti'
            Button2.LayoutConfig.Height = '40'
            Button2.OnClick = btnNegaTuttiClick
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
              339
              45)
          end
        end
      end
      inherited tabDettaglio: TUnimTabSheet
        object pnlAutorizzazione: TMedpUnimPanelBase [1]
          Left = 0
          Top = 440
          Width = 339
          Height = 115
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          CreateOrder = 3
          Anchors = []
          ParentAlignmentControl = False
          AlignmentControl = uniAlignmentClient
          LayoutAttribs.Align = 'center'
          LayoutAttribs.Pack = 'start'
          LayoutConfig.Height = 'auto'
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
          DesignSize = (
            339
            115)
          object lblLivello: TMedpUnimLabel
            Left = 0
            Top = 30
            Width = 339
            Height = 27
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 1
            Caption = 'lblLivello'
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '100%'
            ParentFont = False
            BoxModel.CSSMargin.Top = '4px'
            BoxModel.CSSMargin.Bottom = '4px'
            BoxModel.CSSMargin.Right = '0px'
            BoxModel.CSSMargin.Left = '0px'
            BoxModel.CSSPadding.Top = '4px'
            BoxModel.CSSPadding.Bottom = '4px'
            BoxModel.CSSPadding.Right = '1px'
            BoxModel.CSSPadding.Left = '1px'
            BoxModel.CSSBorder.Top = '1px solid black'
            BoxModel.CSSBorder.Bottom = '1px solid black'
            BoxModel.CSSBorder.Right = '1px solid black'
            BoxModel.CSSBorder.Left = '1px solid black'
            BoxModel.CSSBorderRadius = '0px'
            DesignSize = (
              339
              27)
          end
          object pnlAutorizzaNega: TMedpUnimPanel2Button
            Left = 0
            Top = 70
            Width = 339
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
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '100%'
            ClickEnabled = True
            ChangeEnabled = True
            BoxModel.CSSMargin.Top = '0px'
            BoxModel.CSSMargin.Bottom = '4px'
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
            Button1.Left = 13
            Button1.Top = 0
            Button1.Width = 200
            Button1.Height = 45
            Button1.Hint = ''
            Button1.Margins.Left = 0
            Button1.Margins.Top = 0
            Button1.Margins.Right = 0
            Button1.Margins.Bottom = 0
            Button1.Anchors = []
            Button1.Flex = 1
            Button1.UI = 'action'
            Button1.IconCls = 'fas fa-check'
            Button1.Caption = 'Autorizza'
            Button1.LayoutConfig.Height = '40'
            Button1.OnClick = btnAutorizzaClick
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
            Button2.Left = 13
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
            Button2.Caption = 'Nega'
            Button2.LayoutConfig.Height = '40'
            Button2.OnClick = btnNegaClick
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
              339
              45)
          end
        end
        inherited pnlListaDettaglio: TMedpUnimPanelListaDettaglio
          Left = 2
          Height = 378
          ExplicitLeft = 2
          ExplicitHeight = 378
          DesignSize = (
            339
            378)
        end
      end
    end
  end
end
