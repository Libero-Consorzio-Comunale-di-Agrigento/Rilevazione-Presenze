inherited WM006FGestioneDelegheFM: TWM006FGestioneDelegheFM
  OnCreate = UniFrameCreate
  inherited MainPanel: TMedpUnimPanelBase
    object tpnlGestioneDeleghe: TMedpUnimTabPanelBase
      Left = 0
      Top = 0
      Width = 347
      Height = 610
      Hint = ''
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      ActivePage = tabInserimentoModifica
      Anchors = []
      ClientEvents.UniEvents.Strings = (
        
          'afterCreate=function afterCreate(sender){ sender.getTabBar().hid' +
          'e(); }')
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
      object tabDelegheAttive: TUnimTabSheet
        Left = 4
        Top = 51
        Width = 339
        Height = 555
        Hint = ''
        Caption = 'tabDelegheAttive'
        LayoutAttribs.Align = 'center'
        LayoutAttribs.Pack = 'start'
        DesignSize = (
          339
          555)
        object pnlNumDeleghe: TMedpUnimPanelNumElem
          Left = -4
          Top = 33
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
          LabelNumElementi.Caption = 'Nessuna delega attiva'
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
          Icona.OnClick = InserimentoDelegaClick
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
          CaptionZero = 'Nessuna delega attiva'
          CaptionSingolare = 'delega'
          CaptionPlurale = 'deleghe'
          DesignSize = (
            347
            45)
        end
        object pnlListaDeleghe: TMedpUnimPanelListaDisclosure
          Left = -4
          Top = 78
          Width = 347
          Height = 477
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
          LayoutAttribs.Align = 'start'
          LayoutAttribs.Pack = 'start'
          LayoutConfig.Width = '98%'
          Flex = 1
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
          ColorPari = 16448250
          CSSBordoSeparatore = '1px solid #f0f0f0'
          DesignSize = (
            347
            477)
        end
      end
      object tabInserimentoModifica: TUnimTabSheet
        Left = 4
        Top = 51
        Width = 339
        Height = 555
        Hint = ''
        Caption = 'tabInserimentoModifica'
        LayoutAttribs.Align = 'center'
        LayoutAttribs.Pack = 'start'
        DesignSize = (
          339
          555)
        object pnlInserimentoModifica: TMedpUnimPanelBase
          Left = -4
          Top = 0
          Width = 347
          Height = 571
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
          LayoutAttribs.Align = 'center'
          LayoutAttribs.Pack = 'justify'
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
            347
            571)
          object lblInsModDelega: TMedpUnimLabel
            Left = 14
            Top = 14
            Width = 333
            Height = 33
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 1
            Caption = 'Inserimento/Modifica delega'
            LayoutConfig.Width = '100%'
            ParentFont = False
            Font.Height = -20
            Font.Style = [fsBold]
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
              333
              33)
          end
          object pnlDaDelegare: TMedpUnimPanelBase
            Left = 9
            Top = 46
            Width = 339
            Height = 64
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
              339
              64)
            object lblDaDelegare: TMedpUnimLabel
              Left = 17
              Top = 8
              Width = 132
              Height = 25
              Hint = ''
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 0
              Margins.Bottom = 0
              CreateOrder = 1
              Caption = 'Profilo in uso da delegare:'
              LayoutConfig.Height = '25'
              LayoutConfig.Width = '98%'
              ParentFont = False
              Font.Height = -16
              Font.Style = [fsBold]
              JustifyContent = JustifyStart
              BoxModel.CSSMargin.Top = '0px'
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
                132
                25)
            end
            object lblDaDelegareValue: TMedpUnimLabel
              Left = 17
              Top = 36
              Width = 132
              Height = 25
              Hint = ''
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 0
              Margins.Bottom = 0
              CreateOrder = 2
              Caption = '--'
              LayoutConfig.Height = 'auto'
              LayoutConfig.Width = 'auto'
              ParentFont = False
              Font.Height = -16
              Font.Style = [fsItalic]
              BoxModel.CSSMargin.Top = '0px'
              BoxModel.CSSMargin.Bottom = '5px'
              BoxModel.CSSMargin.Right = '0px'
              BoxModel.CSSMargin.Left = '0px'
              BoxModel.CSSPadding.Top = '3px'
              BoxModel.CSSPadding.Bottom = '3px'
              BoxModel.CSSPadding.Right = '6px'
              BoxModel.CSSPadding.Left = '6px'
              BoxModel.CSSBorder.Top = '1px solid black'
              BoxModel.CSSBorder.Bottom = '1px solid black'
              BoxModel.CSSBorder.Right = '1px solid black'
              BoxModel.CSSBorder.Left = '1px solid black'
              BoxModel.CSSBorderRadius = '0px'
              DesignSize = (
                132
                25)
            end
          end
          object pnlUtente: TMedpUnimPanelBase
            Left = 8
            Top = 111
            Width = 340
            Height = 124
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
              340
              124)
            object pnlLabelsUtente: TMedpUnimPanelBase
              Left = 0
              Top = 0
              Width = 283
              Height = 124
              Hint = ''
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 0
              Margins.Bottom = 0
              CreateOrder = 1
              Anchors = []
              ParentAlignmentControl = False
              AlignmentControl = uniAlignmentClient
              LayoutConfig.Height = 'auto'
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
                283
                124)
              object lblUtente: TMedpUnimLabel
                Left = 9
                Top = 0
                Width = 132
                Height = 25
                Hint = ''
                Margins.Left = 0
                Margins.Top = 0
                Margins.Right = 0
                Margins.Bottom = 0
                CreateOrder = 1
                Caption = 'Utente:'
                LayoutConfig.Height = '25'
                LayoutConfig.Width = '100%'
                ParentFont = False
                Font.Height = -16
                Font.Style = [fsBold]
                JustifyContent = JustifyStart
                BoxModel.CSSMargin.Top = '0px'
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
                  132
                  25)
              end
              object lblUtenteValue: TMedpUnimLabel
                Left = 9
                Top = 28
                Width = 132
                Height = 25
                Hint = ''
                Margins.Left = 0
                Margins.Top = 0
                Margins.Right = 0
                Margins.Bottom = 0
                CreateOrder = 2
                Caption = '--'
                LayoutConfig.Height = '25'
                LayoutConfig.Width = '100%'
                ParentFont = False
                Font.Height = -16
                Font.Style = [fsItalic]
                BoxModel.CSSMargin.Top = '0px'
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
                  132
                  25)
              end
              object lblNominativo: TMedpUnimLabel
                Left = 9
                Top = 65
                Width = 132
                Height = 25
                Hint = ''
                Margins.Left = 0
                Margins.Top = 0
                Margins.Right = 0
                Margins.Bottom = 0
                CreateOrder = 3
                Caption = 'Nominativo:'
                LayoutConfig.Height = '25'
                LayoutConfig.Width = '98%'
                ParentFont = False
                Font.Height = -16
                Font.Style = [fsBold]
                JustifyContent = JustifyStart
                BoxModel.CSSMargin.Top = '0px'
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
                  132
                  25)
              end
              object lblNominativoValue: TMedpUnimLabel
                Left = 9
                Top = 90
                Width = 132
                Height = 25
                Hint = ''
                Margins.Left = 0
                Margins.Top = 0
                Margins.Right = 0
                Margins.Bottom = 0
                CreateOrder = 4
                Caption = '--'
                LayoutConfig.Height = '25'
                LayoutConfig.Width = '100%'
                ParentFont = False
                Font.Height = -16
                Font.Style = [fsItalic]
                BoxModel.CSSMargin.Top = '0px'
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
                  132
                  25)
              end
            end
            object btnFiltroUtenti: TMedpUnimButton
              Left = 283
              Top = 28
              Width = 50
              Height = 45
              Hint = ''
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 0
              Margins.Bottom = 0
              CreateOrder = 2
              Anchors = []
              UI = 'action'
              IconCls = 'search'
              Caption = ''
              LayoutConfig.Height = '50'
              LayoutConfig.Width = '50'
              OnClick = SelezionaUtenteClick
              BoxModel.CSSMargin.Top = '0px'
              BoxModel.CSSMargin.Bottom = '0px'
              BoxModel.CSSMargin.Right = '3px'
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
                50
                45)
            end
          end
          object pnlProfilo: TMedpUnimPanelBase
            Left = 8
            Top = 236
            Width = 339
            Height = 93
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 4
            Anchors = []
            ParentAlignmentControl = False
            AlignmentControl = uniAlignmentClient
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
              339
              93)
            object lblProfilo: TMedpUnimLabel
              Left = 0
              Top = 8
              Width = 326
              Height = 25
              Hint = ''
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 0
              Margins.Bottom = 0
              CreateOrder = 1
              Caption = 'Profilo:'
              LayoutConfig.Height = '25'
              LayoutConfig.Width = '98%'
              ParentFont = False
              Font.Height = -16
              Font.Style = [fsBold]
              JustifyContent = JustifyStart
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
                326
                25)
            end
            object pnlLabelsProfilo: TMedpUnimPanelBase
              Left = 0
              Top = 33
              Width = 339
              Height = 60
              Hint = ''
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 0
              Margins.Bottom = 0
              CreateOrder = 2
              Constraints.MinHeight = 35
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
                60)
              object edtProfilo: TMedpUnimEdit
                Left = 14
                Top = 10
                Width = 200
                Height = 37
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
                ParentFont = False
                Flex = 1
                LayoutConfig.Height = 'auto'
                TabOrder = 1
                DesignSize = (
                  200
                  37)
              end
              object btnProfiloDefault: TMedpUnimButton
                Left = 284
                Top = 2
                Width = 50
                Height = 45
                Hint = ''
                Margins.Left = 0
                Margins.Top = 0
                Margins.Right = 0
                Margins.Bottom = 0
                CreateOrder = 2
                Anchors = []
                UI = 'action'
                IconCls = 'refresh'
                Caption = ''
                LayoutConfig.Height = '50'
                LayoutConfig.Width = '50'
                OnClick = ProfiloDefaultClick
                BoxModel.CSSMargin.Top = '0px'
                BoxModel.CSSMargin.Bottom = '0px'
                BoxModel.CSSMargin.Right = '3px'
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
                  50
                  45)
              end
            end
          end
          object pnlValidita: TMedpUnimPanelBase
            Left = 8
            Top = 330
            Width = 339
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
            LayoutAttribs.Align = 'center'
            LayoutAttribs.Pack = 'start'
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '100%'
            ClickEnabled = True
            ChangeEnabled = True
            BoxModel.CSSMargin.Top = '0px'
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
              339
              76)
            object lblValidita: TMedpUnimLabel
              Left = 0
              Top = 7
              Width = 340
              Height = 25
              Hint = ''
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 0
              Margins.Bottom = 0
              CreateOrder = 6
              Caption = 'Validit'#224':'
              LayoutConfig.Height = '25'
              LayoutConfig.Width = '98%'
              ParentFont = False
              Font.Height = -16
              Font.Style = [fsBold]
              JustifyContent = JustifyStart
              BoxModel.CSSMargin.Top = '0px'
              BoxModel.CSSMargin.Bottom = '2px'
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
                340
                25)
            end
            object pnlDateValidita: TMedpUnimPanelDataDaA
              Left = 0
              Top = 32
              Width = 339
              Height = 32
              Hint = ''
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 0
              Margins.Bottom = 0
              CreateOrder = 7
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
              DataDa.Left = 13
              DataDa.Top = -4
              DataDa.Width = 200
              DataDa.Height = 45
              DataDa.Hint = ''
              DataDa.Margins.Left = 0
              DataDa.Margins.Top = 0
              DataDa.Margins.Right = 0
              DataDa.Margins.Bottom = 0
              DataDa.FieldLabel = 'Da'
              DataDa.FieldLabelWidth = 20
              DataDa.ClientEvents.UniEvents.Strings = (
                
                  'afterCreate=function afterCreate(sender){ sender.originalValue=n' +
                  'ull; sender.setEditable(false); }')
              DataDa.Flex = 1
              DataDa.DateFormat = 'dd/MM/yyyy'
              DataDa.LayoutConfig.Height = '100%'
              DataDa.SlotOrder = 'd/m/y'
              DataDa.Date = 43790.000000000000000000
              DataDa.Picker = dptFloated
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
              Separatore.Left = 13
              Separatore.Top = -4
              Separatore.Width = 200
              Separatore.Height = 45
              Separatore.Hint = ''
              Separatore.Margins.Left = 0
              Separatore.Margins.Top = 0
              Separatore.Margins.Right = 0
              Separatore.Margins.Bottom = 0
              Separatore.Visible = False
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
              DataA.Left = 13
              DataA.Top = -4
              DataA.Width = 200
              DataA.Height = 45
              DataA.Hint = ''
              DataA.Margins.Left = 0
              DataA.Margins.Top = 0
              DataA.Margins.Right = 0
              DataA.Margins.Bottom = 0
              DataA.FieldLabel = 'a'
              DataA.FieldLabelWidth = 20
              DataA.ClientEvents.UniEvents.Strings = (
                
                  'afterCreate=function afterCreate(sender){ sender.originalValue=n' +
                  'ull; sender.setEditable(false); }')
              DataA.Flex = 1
              DataA.DateFormat = 'dd/MM/yyyy'
              DataA.LayoutConfig.Height = '100%'
              DataA.SlotOrder = 'd/m/y'
              DataA.Date = 43790.000000000000000000
              DataA.Picker = dptFloated
              DataA.BoxModel.CSSMargin.Top = '0px'
              DataA.BoxModel.CSSMargin.Bottom = '0px'
              DataA.BoxModel.CSSMargin.Right = '0px'
              DataA.BoxModel.CSSMargin.Left = '4px'
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
                339
                32)
            end
          end
          object pnlEscludiDelegato: TMedpUnimPanelBase
            Left = 0
            Top = 407
            Width = 347
            Height = 63
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
            LayoutConfig.Width = '98%'
            ClickEnabled = True
            ChangeEnabled = True
            BoxModel.CSSMargin.Top = '0px'
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
              347
              63)
            object lblEscludiDelegato: TMedpUnimLabel
              Left = 17
              Top = 18
              Width = 200
              Height = 39
              Hint = ''
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 0
              Margins.Bottom = 0
              CreateOrder = 1
              Caption = 'Escludi il delegato:'
              LayoutConfig.Height = '30'
              ParentFont = False
              Font.Style = [fsBold]
              JustifyContent = JustifyStart
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
                39)
            end
            object chkEscludiDelegato: TUnimCheckBox
              Left = 253
              Top = 13
              Width = 36
              Height = 47
              Hint = ''
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 0
              Margins.Bottom = 0
              CreateOrder = 2
              Caption = ''
              LayoutConfig.Height = 'auto'
              LayoutConfig.Width = 'auto'
            end
          end
          object pnlPulsanti: TMedpUnimPanelBase
            Left = 0
            Top = 472
            Width = 347
            Height = 99
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 7
            Anchors = []
            ParentAlignmentControl = False
            AlignmentControl = uniAlignmentClient
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
              347
              99)
            object pnlOkAnnulla: TMedpUnimPanel2Button
              Left = 0
              Top = 2
              Width = 347
              Height = 45
              Hint = ''
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 0
              Margins.Bottom = 0
              CreateOrder = 9
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
              Button2.OnClick = AnnullaDelegaClick
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
            object btnEliminaDelega: TMedpUnimButton
              Left = 0
              Top = 46
              Width = 341
              Height = 45
              Hint = ''
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 0
              Margins.Bottom = 0
              CreateOrder = 10
              Anchors = []
              UI = 'action'
              IconCls = 'trash'
              Caption = 'Elimina Delega'
              LayoutConfig.Height = '40'
              LayoutConfig.Width = '98%'
              OnClick = EliminaDelegaClick
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
              DesignSize = (
                341
                45)
            end
          end
        end
      end
      object tabFiltroUtenti: TUnimTabSheet
        Left = 4
        Top = 51
        Width = 339
        Height = 555
        Hint = ''
        Caption = 'tabFiltroUtenti'
        LayoutAttribs.Align = 'center'
        LayoutAttribs.Pack = 'start'
        DesignSize = (
          339
          555)
        object pnlHeaderFiltroUtenti: TMedpUnimPanelHeaderDett
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
          Back.LayoutConfig.Height = '100%'
          Back.LayoutConfig.Width = '45'
          Back.ParentFont = False
          Back.Font.Height = -27
          Back.OnClick = BackClick
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
          LabelDettaglio.Caption = 'Selezione utente'
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
        object lblFiltroPersonalizzato: TMedpUnimLabel
          Left = 0
          Top = 62
          Width = 339
          Height = 45
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          CreateOrder = 2
          Caption = 
            'L'#39'elenco degli utenti da delegare '#232' filtrato in base a criteri p' +
            'ersonalizzati'
          LayoutConfig.Cls = 'x-text-center'
          LayoutConfig.Height = 'auto'
          LayoutConfig.Width = '95%'
          ParentFont = False
          Font.Style = [fsBold]
          BoxModel.CSSMargin.Top = '0px'
          BoxModel.CSSMargin.Bottom = '8px'
          BoxModel.CSSMargin.Right = '0px'
          BoxModel.CSSMargin.Left = '0px'
          BoxModel.CSSPadding.Top = '4px'
          BoxModel.CSSPadding.Bottom = '4px'
          BoxModel.CSSPadding.Right = '4px'
          BoxModel.CSSPadding.Left = '4px'
          BoxModel.CSSBorder.Top = '1px solid black'
          BoxModel.CSSBorder.Bottom = '1px solid black'
          BoxModel.CSSBorder.Right = '1px solid black'
          BoxModel.CSSBorder.Left = '1px solid black'
          BoxModel.CSSBorderRadius = '0px'
          DesignSize = (
            339
            45)
        end
        object pnlCognome: TMedpUnimPanelBase
          Left = 0
          Top = 107
          Width = 337
          Height = 42
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
          LayoutConfig.Height = 'auto'
          LayoutConfig.Width = '98%'
          ClickEnabled = True
          ChangeEnabled = True
          BoxModel.CSSMargin.Top = '0px'
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
            337
            42)
          object lblCognome: TMedpUnimLabel
            Left = 0
            Top = 1
            Width = 153
            Height = 45
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 1
            Caption = 'Cognome:'
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '100'
            ParentFont = False
            JustifyContent = JustifyStart
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
              153
              45)
          end
          object edtCognome: TMedpUnimEdit
            Left = 131
            Top = 9
            Width = 200
            Height = 33
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 2
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
            Text = ''
            ParentFont = False
            Flex = 1
            LayoutConfig.Height = '35'
            TabOrder = 2
            DesignSize = (
              200
              33)
          end
        end
        object pnlMatricola: TMedpUnimPanelBase
          Left = 2
          Top = 159
          Width = 337
          Height = 42
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
          LayoutConfig.Height = 'auto'
          LayoutConfig.Width = '98%'
          ClickEnabled = True
          ChangeEnabled = True
          BoxModel.CSSMargin.Top = '0px'
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
            337
            42)
          object lblMatricola: TMedpUnimLabel
            Left = 0
            Top = 2
            Width = 153
            Height = 45
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 1
            Caption = 'Matricola:'
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '100'
            ParentFont = False
            JustifyContent = JustifyStart
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
              153
              45)
          end
          object edtMatricola: TMedpUnimEdit
            Left = 131
            Top = 9
            Width = 200
            Height = 33
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 2
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
            Text = ''
            ParentFont = False
            Flex = 1
            LayoutConfig.Height = '35'
            TabOrder = 2
            DesignSize = (
              200
              33)
          end
        end
        object pnlUtenteDelegato: TMedpUnimPanelBase
          Left = 0
          Top = 202
          Width = 337
          Height = 42
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
            337
            42)
          object lblUtenteDelegato: TMedpUnimLabel
            Left = 0
            Top = 0
            Width = 153
            Height = 45
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 1
            Caption = 'Utente:'
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '100'
            ParentFont = False
            JustifyContent = JustifyStart
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
              153
              45)
          end
          object edtUtenteDelegato: TMedpUnimEdit
            Left = 131
            Top = 9
            Width = 200
            Height = 33
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 2
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
            Text = ''
            ParentFont = False
            Flex = 1
            LayoutConfig.Height = '35'
            TabOrder = 2
            DesignSize = (
              200
              33)
          end
        end
        object btnFiltra: TMedpUnimButton
          Left = 0
          Top = 255
          Width = 341
          Height = 45
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          CreateOrder = 6
          Anchors = []
          UI = 'action'
          IconCls = 'refresh'
          Caption = 'Filtra'
          LayoutConfig.Height = '40'
          LayoutConfig.Width = '98%'
          OnClick = FiltraUtentiClick
          BoxModel.CSSMargin.Top = '7px'
          BoxModel.CSSMargin.Bottom = '7px'
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
            341
            45)
        end
        object pnlNumUtentiTrovati: TMedpUnimPanelNumElem
          Left = 0
          Top = 300
          Width = 347
          Height = 45
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          CreateOrder = 7
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
          BoxModel.CSSMargin.Bottom = '7px'
          BoxModel.CSSMargin.Right = '0px'
          BoxModel.CSSMargin.Left = '0px'
          BoxModel.CSSPadding.Top = '0px'
          BoxModel.CSSPadding.Bottom = '0px'
          BoxModel.CSSPadding.Right = '0px'
          BoxModel.CSSPadding.Left = '0px'
          BoxModel.CSSBorder.Top = '0px'
          BoxModel.CSSBorder.Bottom = '5px'
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
          LabelNumElementi.Caption = 'Nessun utente trovato'
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
          Icona.Visible = False
          Icona.Caption = ''
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
          CaptionZero = 'Nessun utente trovato'
          CaptionSingolare = 'utente trovato'
          CaptionPlurale = 'utenti trovati'
          DesignSize = (
            347
            45)
        end
        object pnlListaUtentiTrovati: TMedpUnimPanelListaDisclosure
          Left = -8
          Top = 362
          Width = 347
          Height = 193
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          CreateOrder = 8
          AutoScroll = True
          Anchors = []
          ParentAlignmentControl = False
          AlignmentControl = uniAlignmentClient
          LayoutAttribs.Align = 'center'
          LayoutAttribs.Pack = 'start'
          LayoutConfig.Width = '100%'
          Flex = 1
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
          ColorPari = 16448250
          CSSBordoSeparatore = '1px solid #f0f0f0'
          DesignSize = (
            347
            193)
        end
      end
    end
  end
end
