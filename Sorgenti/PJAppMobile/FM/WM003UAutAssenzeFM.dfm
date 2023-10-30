inherited WM003FAutAssenzeFM: TWM003FAutAssenzeFM
  inherited MainPanel: TMedpUnimPanelBase
    inherited tpnlRichieste: TMedpUnimTabPanelBase
      inherited tabElenco: TUnimTabSheet
        inherited rgpTipoRichiesta: TMedpUnimRadioGroup
          ScreenMask.Target = Owner
        end
        inherited pnlFiltroRichieste: TMedpUnimPanelBase
          Visible = False
        end
      end
      object tabCompetenze: TUnimTabSheet
        Left = 4
        Top = 51
        Width = 339
        Height = 555
        Hint = ''
        Caption = 'tabCompetenze'
        LayoutAttribs.Align = 'center'
        LayoutAttribs.Pack = 'start'
        DesignSize = (
          339
          555)
        object pnlHeaderCompetenze: TMedpUnimPanelHeaderDett
          Left = 0
          Top = 6
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
          Back.OnClick = pnlHeaderCompetenzelblBackClick
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
          Down.BoxModel.CSSBorderRadius = '0px'
          Down.DesignSize = (
            200
            45)
          DesignSize = (
            339
            40)
        end
        object pnlListaCompetenze: TMedpUnimPanelListaDettaglio
          Left = 0
          Top = 46
          Width = 339
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
          ColorPari = 16448250
          CSSBordoSeparatore = '1px solid #f0f0f0'
          ColorHeader = clGradientInactiveCaption
          DesignSize = (
            339
            509)
        end
      end
    end
  end
end
