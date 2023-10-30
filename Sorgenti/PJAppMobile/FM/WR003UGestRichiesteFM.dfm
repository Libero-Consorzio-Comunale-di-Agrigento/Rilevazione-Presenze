inherited WR003FGestRichiesteFM: TWR003FGestRichiesteFM
  inherited MainPanel: TMedpUnimPanelBase
    inherited tpnlRichieste: TMedpUnimTabPanelBase
      ActivePage = tabNuovaRichiesta
      inherited tabElenco: TUnimTabSheet
        inherited rgpTipoRichiesta: TMedpUnimRadioGroup
          ScreenMask.Target = Owner
        end
        inherited pnlNumRichieste: TMedpUnimPanelNumElem
          Icona.OnClick = OnNuovaRichiestaClick
        end
      end
      inherited tabDettaglio: TUnimTabSheet
        inherited pnlListaDettaglio: TMedpUnimPanelListaDettaglio
          Left = 2
          Top = 56
          Height = 393
          CreateOrder = 2
          BoxModel.CSSMargin.Bottom = '3px'
          ExplicitLeft = 2
          ExplicitTop = 56
          ExplicitHeight = 393
          DesignSize = (
            339
            393)
        end
        object btnDettModifica: TMedpUnimButton
          Left = 0
          Top = 465
          Width = 339
          Height = 45
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          CreateOrder = 3
          Anchors = []
          UI = 'action'
          IconCls = 'fas fa-pencil-alt'
          Caption = 'Modifica'
          LayoutConfig.Height = '50'
          LayoutConfig.Width = '98%'
          OnClick = OnModificaRichiestaClick
          BoxModel.CSSMargin.Top = '3px'
          BoxModel.CSSMargin.Bottom = '3px'
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
            339
            45)
        end
        object pnlEliminaRevoca: TMedpUnimPanel2Button
          Left = 0
          Top = 510
          Width = 339
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
          LayoutConfig.Height = 'auto'
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
          Button1.ScreenMask.Enabled = True
          Button1.ScreenMask.WaitData = True
          Button1.ScreenMask.ShowMessage = False
          Button1.Flex = 1
          Button1.UI = 'action'
          Button1.IconCls = 'trash'
          Button1.Caption = 'Elimina'
          Button1.LayoutConfig.Height = '50'
          Button1.OnClick = OnEliminaRichiestaClick
          Button1.BoxModel.CSSMargin.Top = '0px'
          Button1.BoxModel.CSSMargin.Bottom = '0px'
          Button1.BoxModel.CSSMargin.Right = '3px'
          Button1.BoxModel.CSSMargin.Left = '3px'
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
          Button2.ScreenMask.Enabled = True
          Button2.ScreenMask.WaitData = True
          Button2.ScreenMask.ShowMessage = False
          Button2.Flex = 1
          Button2.UI = 'action'
          Button2.IconCls = 'delete'
          Button2.Caption = 'Revoca'
          Button2.LayoutConfig.Height = '50'
          Button2.OnClick = OnRevocaRichiestaClick
          Button2.BoxModel.CSSMargin.Top = '0px'
          Button2.BoxModel.CSSMargin.Bottom = '0px'
          Button2.BoxModel.CSSMargin.Right = '3px'
          Button2.BoxModel.CSSMargin.Left = '3px'
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
      inherited tabAllegati: TUnimTabSheet
        inherited pnlNuovoModifica: TMedpUnimPanelBase
          inherited pnlModificaFile: TMedpUnimPanel2Labels [1]
          end
          inherited pnlUpload: TMedpUnimPanelBase [2]
          end
        end
      end
      object tabNuovaRichiesta: TUnimTabSheet
        Left = 4
        Top = 51
        Width = 339
        Height = 555
        Hint = ''
        Caption = 'tabNuovaRichiesta'
        LayoutAttribs.Align = 'center'
        LayoutAttribs.Pack = 'start'
        DesignSize = (
          339
          555)
        object pnlDatiNuovaRichiesta: TMedpUnimPanelBase
          Left = 6
          Top = 0
          Width = 333
          Height = 510
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          CreateOrder = 1
          AutoScroll = True
          Anchors = []
          ParentAlignmentControl = False
          AlignmentControl = uniAlignmentClient
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
            333
            510)
        end
        object pnlOkAnnulla: TMedpUnimPanel2Button
          Left = -4
          Top = 510
          Width = 347
          Height = 45
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Anchors = []
          ParentAlignmentControl = False
          AlignmentControl = uniAlignmentClient
          Layout = 'hbox'
          LayoutAttribs.Align = 'center'
          LayoutAttribs.Pack = 'start'
          LayoutConfig.Height = 'auto'
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
          BoxModel.CSSBorderRadius = '0px'
          Button1.Left = 16
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
          Button1.Caption = 'Ok'
          Button1.LayoutConfig.Height = '40'
          Button1.OnClick = OnOkRichiestaClick
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
          Button2.Left = 16
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
          Button2.OnClick = OnAnnullaRichiestaClick
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
            347
            45)
        end
      end
    end
  end
end
