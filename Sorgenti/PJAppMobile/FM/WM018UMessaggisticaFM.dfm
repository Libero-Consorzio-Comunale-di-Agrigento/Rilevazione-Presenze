inherited WM018FMessaggisticaFM: TWM018FMessaggisticaFM
  OnCreate = UniFrameCreate
  inherited MainPanel: TMedpUnimPanelBase
    Layout = 'fit'
    object tpnlMessaggistica: TMedpUnimTabPanelBase
      Left = 0
      Top = 0
      Width = 347
      Height = 610
      Hint = ''
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      ActivePage = tabRicevuti
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
      object tabRicevuti: TUnimTabSheet
        Left = 4
        Top = 51
        Width = 339
        Height = 555
        Hint = ''
        Caption = 'tabRicevuti'
        LayoutAttribs.Align = 'center'
        LayoutAttribs.Pack = 'start'
        DesignSize = (
          339
          555)
        object pnlHeaderRicevuti: TMedpUnimPanelBase
          Left = 0
          Top = 0
          Width = 339
          Height = 57
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
          LayoutAttribs.Pack = 'center'
          LayoutConfig.Cls = 'background-blue'
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
          DesignSize = (
            339
            57)
          object imgInbox: TUnimImage
            Left = 3
            Top = 0
            Width = 65
            Height = 57
            Hint = ''
            CreateOrder = 1
            Center = True
            AutoSize = True
            Proportional = True
            Url = '/wwwroot/IrisAPP/img/inbox-white.png'
            LayoutConfig.Height = '30'
            LayoutConfig.Width = '30'
            LayoutConfig.Margin = '0px 10px 0px 0px'
          end
          object lblMessaggiRicevuti: TMedpUnimLabel
            Left = 71
            Top = 0
            Width = 163
            Height = 57
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 2
            Caption = 'Messaggi ricevuti'
            LayoutConfig.Width = 'auto'
            ParentFont = False
            Font.Style = [fsBold]
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
              163
              57)
          end
          object pnlOutboxNext: TMedpUnimPanelBase
            Left = 220
            Top = 0
            Width = 119
            Height = 57
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 3
            Anchors = []
            ClientEvents.UniEvents.Strings = (
              
                'afterCreate=function afterCreate(sender)'#13#10'{'#13#10'  sender.setStyle(s' +
                'ender.style + " position: absolute; right: 0px;");'#13#10'}')
            ParentAlignmentControl = False
            AlignmentControl = uniAlignmentClient
            Layout = 'hbox'
            LayoutAttribs.Align = 'center'
            LayoutAttribs.Pack = 'justify'
            LayoutConfig.Cls = 'background-white activeClick'
            LayoutConfig.Height = '100%'
            LayoutConfig.Width = 'auto'
            ScreenMask.Enabled = True
            ScreenMask.ShowMessage = False
            OnClick = pnlOutboxNextClick
            ClickEnabled = True
            ChangeEnabled = True
            BoxModel.CSSMargin.Top = '0px'
            BoxModel.CSSMargin.Bottom = '0px'
            BoxModel.CSSMargin.Right = '0px'
            BoxModel.CSSMargin.Left = '0px'
            BoxModel.CSSPadding.Top = '5px'
            BoxModel.CSSPadding.Bottom = '5px'
            BoxModel.CSSPadding.Right = '0px'
            BoxModel.CSSPadding.Left = '5px'
            BoxModel.CSSBorder.Top = '0px'
            BoxModel.CSSBorder.Bottom = '0px'
            BoxModel.CSSBorder.Right = '0px'
            BoxModel.CSSBorder.Left = '0px'
            BoxModel.CSSBorderRadius = '20px 0px 0px 0px'
            DesignSize = (
              119
              57)
            object imgOutboxNext: TUnimImage
              Left = -7
              Top = 0
              Width = 73
              Height = 57
              Hint = ''
              CreateOrder = 1
              Center = True
              AutoSize = True
              Proportional = True
              Url = '/wwwroot/IrisAPP/img/outbox-blue.png'
              Anchors = []
              LayoutConfig.Height = '25'
              LayoutConfig.Width = '25'
              LayoutConfig.Margin = '0px 0px 0px 5px'
              OnClick = pnlOutboxNextClick
            end
            object lblOutboxNext: TMedpUnimLabel
              Left = 62
              Top = 0
              Width = 57
              Height = 57
              Hint = ''
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 0
              Margins.Bottom = 0
              CreateOrder = 2
              Caption = '<i class="fas fa-chevron-right"></i>'
              ScreenMask.Enabled = True
              ScreenMask.WaitData = True
              ScreenMask.ShowMessage = False
              LayoutConfig.Height = '25'
              LayoutConfig.Width = '25'
              ParentFont = False
              OnClick = pnlOutboxNextClick
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
                57
                57)
            end
          end
        end
        object lblFiltroRicevuti: TMedpUnimLabel
          Left = 0
          Top = 60
          Width = 339
          Height = 45
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          CreateOrder = 2
          Caption = 
            '<i class="fas fa-angle-down"></i> Filtro messaggi <i class="fas ' +
            'fa-angle-down"></i>'
          ScreenMask.ShowMessage = False
          LayoutConfig.Cls = 'activeClick background-blue'
          LayoutConfig.Height = '35'
          LayoutConfig.Width = '98%'
          ParentFont = False
          Font.Style = [fsBold]
          OnClick = lblFiltroRicevutiClick
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
          BoxModel.CSSBorderRadius = '10px 10px 10px 10px'
          DesignSize = (
            339
            45)
        end
        object pnlFiltroRicevuti: TMedpUnimPanelBase
          Left = 0
          Top = 120
          Width = 339
          Height = 235
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          CreateOrder = 3
          Anchors = []
          ClientEvents.UniEvents.Strings = (
            
              'afterCreate=function afterCreate(sender)'#13#10'{'#13#10'  sender.setStyle("' +
              'transition: width 500ms, height 500ms");'#13#10'}')
          ParentAlignmentControl = False
          AlignmentControl = uniAlignmentClient
          LayoutAttribs.Align = 'center'
          LayoutAttribs.Pack = 'start'
          LayoutConfig.Height = '40px'
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
            339
            235)
          object rgpFiltroRicevuti: TMedpUnimRadioGroup
            Left = 0
            Top = 2
            Width = 339
            Height = 44
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
            LayoutAttribs.Align = 'start'
            LayoutAttribs.Pack = 'justify'
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '100%'
            ScreenMask.Enabled = True
            ScreenMask.ShowMessage = False
            OnChange = rgpFiltroRicevutiChange
            ClickEnabled = True
            ChangeEnabled = True
            BoxModel.CSSMargin.Top = '5px'
            BoxModel.CSSMargin.Bottom = '8px'
            BoxModel.CSSMargin.Right = '2px'
            BoxModel.CSSMargin.Left = '2px'
            BoxModel.CSSPadding.Top = '5px'
            BoxModel.CSSPadding.Bottom = '5px'
            BoxModel.CSSPadding.Right = '2px'
            BoxModel.CSSPadding.Left = '2px'
            BoxModel.CSSBorder.Top = '0px'
            BoxModel.CSSBorder.Bottom = '0px'
            BoxModel.CSSBorder.Right = '0px'
            BoxModel.CSSBorder.Left = '0px'
            BoxModel.CSSBorderRadius = '0px'
            Items.Strings = (
              'Da leggere'
              'Letti'
              'Tutti'
              'Cancellati')
            ItemIndex = 0
            DesignSize = (
              339
              44)
          end
          object lblFiltroDataRic: TMedpUnimLabel
            Left = 0
            Top = 66
            Width = 339
            Height = 29
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 2
            Caption = 'Data di invio dal/al:'
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '100%'
            ParentFont = False
            Font.Height = -16
            Font.Style = [fsBold]
            BoxModel.CSSMargin.Top = '2px'
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
              29)
          end
          object pnlFiltroDataRic: TMedpUnimPanelDataDaA
            Left = 0
            Top = 98
            Width = 339
            Height = 40
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
            LayoutConfig.Width = '100%'
            ScreenMask.Enabled = True
            ScreenMask.ShowMessage = False
            OnChange = AggiornaListaMessaggiRicevuti
            ClickEnabled = True
            ChangeEnabled = True
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
            DataDa.Top = 0
            DataDa.Width = 200
            DataDa.Height = 45
            DataDa.Hint = ''
            DataDa.Margins.Left = 0
            DataDa.Margins.Top = 0
            DataDa.Margins.Right = 0
            DataDa.Margins.Bottom = 0
            DataDa.FieldLabelWidth = 10
            DataDa.ClientEvents.UniEvents.Strings = (
              
                'afterCreate=function afterCreate(sender){ sender.originalValue=n' +
                'ull; sender.setEditable(false); }')
            DataDa.Flex = 1
            DataDa.DateFormat = 'dd/MM/yyyy'
            DataDa.LayoutConfig.Height = '100%'
            DataDa.SlotOrder = 'd/m/y'
            DataDa.Date = 44263.000000000000000000
            DataDa.Picker = dptFloated
            DataDa.ScreenMask.Enabled = True
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
            Separatore.Left = 13
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
            DataA.Left = 13
            DataA.Top = 0
            DataA.Width = 200
            DataA.Height = 45
            DataA.Hint = ''
            DataA.Margins.Left = 0
            DataA.Margins.Top = 0
            DataA.Margins.Right = 0
            DataA.Margins.Bottom = 0
            DataA.FieldLabelWidth = 10
            DataA.ClientEvents.UniEvents.Strings = (
              
                'afterCreate=function afterCreate(sender){ sender.originalValue=n' +
                'ull; sender.setEditable(false); }')
            DataA.Flex = 1
            DataA.DateFormat = 'dd/MM/yyyy'
            DataA.LayoutConfig.Height = '100%'
            DataA.SlotOrder = 'd/m/y'
            DataA.Date = 44263.000000000000000000
            DataA.Picker = dptFloated
            DataA.ScreenMask.Enabled = True
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
              339
              40)
          end
          object cmbMittente: TMedpUnimSelect
            Left = 0
            Top = 150
            Width = 339
            Height = 45
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 4
            Anchors = []
            ClientEvents.UniEvents.Strings = (
              
                'afterCreate=function afterCreate(sender){ sender.setEditable(fal' +
                'se); }')
            FieldLabel = 'Mittente:'
            FieldLabelWidth = 25
            FieldLabelFont.Height = -16
            FieldLabelFont.Style = [fsBold]
            ScreenMask.Enabled = True
            ScreenMask.ShowMessage = False
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '100%'
            TabOrder = 3
            Picker = dptFloated
            OnChange = AggiornaListaMessaggiRicevuti
            BoxModel.CSSMargin.Top = '13px'
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
            SeparatoreTesto = ' - '
            ElementoVuoto = True
            DesignSize = (
              339
              45)
          end
          object pnlOggettoTestoRic: TMedpUnimPanelBase
            Left = 0
            Top = 184
            Width = 339
            Height = 51
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
            BoxModel.CSSPadding.Top = '3px'
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
              51)
            object edtOggettoTestoRic: TMedpUnimEdit
              Left = 0
              Top = 10
              Width = 253
              Height = 41
              Hint = ''
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 0
              Margins.Bottom = 0
              CreateOrder = 1
              BoxModel.CSSMargin.Top = '3px'
              BoxModel.CSSMargin.Bottom = '3px'
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
              Text = ''
              EmptyText = 'Ricerca nell'#39'oggetto o nel testo'
              ParentFont = False
              Flex = 1
              LayoutConfig.Height = '35'
              TabOrder = 1
              DesignSize = (
                253
                41)
            end
            object btnFiltroRicercaRic: TMedpUnimButton
              Left = 270
              Top = 3
              Width = 62
              Height = 45
              Hint = ''
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 0
              Margins.Bottom = 0
              CreateOrder = 2
              Anchors = []
              ScreenMask.Enabled = True
              ScreenMask.ShowMessage = False
              UI = 'action'
              Caption = '<i class="fas fa-filter"></i>'
              LayoutConfig.Height = '40'
              LayoutConfig.Width = '40'
              OnClick = AggiornaListaMessaggiRicevuti
              BoxModel.CSSMargin.Top = '3px'
              BoxModel.CSSMargin.Bottom = '3px'
              BoxModel.CSSMargin.Right = '3px'
              BoxModel.CSSMargin.Left = '3px'
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
                62
                45)
            end
          end
        end
        object pnlNumRicevuti: TMedpUnimPanelNumElem
          Left = 0
          Top = 355
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
          BoxModel.CSSBorder.Top = '1px solid black'
          BoxModel.CSSBorder.Bottom = '1px solid black'
          BoxModel.CSSBorder.Right = '1px solid black'
          BoxModel.CSSBorder.Left = '1px solid black'
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
          LabelNumElementi.Caption = 'Nessun messaggio'
          LabelNumElementi.Flex = 1
          LabelNumElementi.LayoutConfig.Height = 'auto'
          LabelNumElementi.ParentFont = False
          LabelNumElementi.Font.Style = [fsBold]
          LabelNumElementi.BoxModel.CSSMargin.Top = '0px'
          LabelNumElementi.BoxModel.CSSMargin.Bottom = '0px'
          LabelNumElementi.BoxModel.CSSMargin.Right = '0px'
          LabelNumElementi.BoxModel.CSSMargin.Left = '0px'
          LabelNumElementi.BoxModel.CSSPadding.Top = '0px'
          LabelNumElementi.BoxModel.CSSPadding.Bottom = '0px'
          LabelNumElementi.BoxModel.CSSPadding.Right = '0px'
          LabelNumElementi.BoxModel.CSSPadding.Left = '0px'
          LabelNumElementi.BoxModel.CSSBorder.Top = '0px'
          LabelNumElementi.BoxModel.CSSBorder.Bottom = '0px'
          LabelNumElementi.BoxModel.CSSBorder.Right = '0px'
          LabelNumElementi.BoxModel.CSSBorder.Left = '0px'
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
          Icona.BoxModel.CSSBorderRadius = '0px'
          Icona.DesignSize = (
            200
            45)
          CaptionZero = 'Nessun messaggio'
          CaptionSingolare = 'messaggio'
          CaptionPlurale = 'messaggi'
          DesignSize = (
            339
            45)
        end
        object pnlListaRicevuti: TMedpUnimPanelListaDisclosure
          Left = 0
          Top = 400
          Width = 339
          Height = 155
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
          OnChange = pnlListaRicevutiChange
          ClickEnabled = True
          ChangeEnabled = True
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
          ColorPari = 16448250
          CSSBordoSeparatore = '1px solid #f0f0f0'
          ColorHeader = 15455685
          DesignSize = (
            339
            155)
        end
      end
      object tabInviati: TUnimTabSheet
        Left = 4
        Top = 51
        Width = 339
        Height = 555
        Hint = ''
        Caption = 'tabInviati'
        LayoutAttribs.Align = 'center'
        LayoutAttribs.Pack = 'start'
        DesignSize = (
          339
          555)
        object pnlHeaderInviati: TMedpUnimPanelBase
          Left = 0
          Top = 8
          Width = 339
          Height = 57
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
          LayoutAttribs.Pack = 'center'
          LayoutConfig.Cls = 'background-blue'
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
          DesignSize = (
            339
            57)
          object imgOutbox: TUnimImage
            Left = 122
            Top = -3
            Width = 65
            Height = 57
            Hint = ''
            CreateOrder = 1
            Center = True
            AutoSize = True
            Proportional = True
            Url = '/wwwroot/IrisAPP/img/outbox-white.png'
            LayoutConfig.Height = '30'
            LayoutConfig.Width = '30'
            LayoutConfig.Margin = '0px 10px 0px 0px'
          end
          object lblMessaggiInviati: TMedpUnimLabel
            Left = 190
            Top = 0
            Width = 163
            Height = 57
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 2
            Caption = 'Messaggi inviati'
            LayoutConfig.Width = 'auto'
            ParentFont = False
            Font.Style = [fsBold]
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
              163
              57)
          end
          object pnlInboxPrev: TMedpUnimPanelBase
            Left = 0
            Top = 0
            Width = 119
            Height = 57
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 3
            Anchors = []
            ClientEvents.UniEvents.Strings = (
              
                'afterCreate=function afterCreate(sender)'#13#10'{'#13#10'  sender.setStyle(s' +
                'ender.style + " position: absolute; left: 0px;");'#13#10'}')
            ParentAlignmentControl = False
            AlignmentControl = uniAlignmentClient
            Layout = 'hbox'
            LayoutAttribs.Align = 'center'
            LayoutAttribs.Pack = 'justify'
            LayoutConfig.Cls = 'background-white activeClick'
            LayoutConfig.Height = '100%'
            LayoutConfig.Width = 'auto'
            ScreenMask.Enabled = True
            ScreenMask.ShowMessage = False
            OnClick = pnlInboxPrevClick
            ClickEnabled = True
            ChangeEnabled = True
            BoxModel.CSSMargin.Top = '0px'
            BoxModel.CSSMargin.Bottom = '0px'
            BoxModel.CSSMargin.Right = '0px'
            BoxModel.CSSMargin.Left = '0px'
            BoxModel.CSSPadding.Top = '5px'
            BoxModel.CSSPadding.Bottom = '5px'
            BoxModel.CSSPadding.Right = '5px'
            BoxModel.CSSPadding.Left = '0px'
            BoxModel.CSSBorder.Top = '0px'
            BoxModel.CSSBorder.Bottom = '0px'
            BoxModel.CSSBorder.Right = '0px'
            BoxModel.CSSBorder.Left = '0px'
            BoxModel.CSSBorderRadius = '0px 20px 0px 0px'
            DesignSize = (
              119
              57)
            object lblInboxPrev: TMedpUnimLabel
              Left = 0
              Top = 0
              Width = 57
              Height = 57
              Hint = ''
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 0
              Margins.Bottom = 0
              CreateOrder = 1
              Caption = '<i class="fas fa-chevron-left"></i>'
              ScreenMask.Enabled = True
              ScreenMask.WaitData = True
              ScreenMask.ShowMessage = False
              LayoutConfig.Height = '25'
              LayoutConfig.Width = '25'
              ParentFont = False
              OnClick = pnlInboxPrevClick
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
                57
                57)
            end
            object imgInboxPrev: TUnimImage
              Left = 72
              Top = -3
              Width = 73
              Height = 57
              Hint = ''
              CreateOrder = 2
              Center = True
              AutoSize = True
              Proportional = True
              Url = '/wwwroot/IrisAPP/img/inbox-blue.png'
              Anchors = []
              LayoutConfig.Height = '25'
              LayoutConfig.Width = '25'
              LayoutConfig.Margin = '0px 5px 0px 0px'
              OnClick = pnlInboxPrevClick
            end
          end
        end
        object lblFiltroInviati: TMedpUnimLabel
          Left = 0
          Top = 65
          Width = 339
          Height = 28
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          CreateOrder = 2
          Caption = 
            '<i class="fas fa-angle-down"></i> Filtro messaggi <i class="fas ' +
            'fa-angle-down"></i>'
          LayoutConfig.Cls = 'activeClick background-blue'
          LayoutConfig.Height = '35'
          LayoutConfig.Width = '98%'
          ParentFont = False
          Font.Style = [fsBold]
          OnClick = lblFiltroInviatiClick
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
          BoxModel.CSSBorderRadius = '10px'
          DesignSize = (
            339
            28)
        end
        object pnlFiltroInviati: TMedpUnimPanelBase
          Left = 0
          Top = 93
          Width = 339
          Height = 259
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          CreateOrder = 3
          Anchors = []
          ClientEvents.UniEvents.Strings = (
            
              'afterCreate=function afterCreate(sender)'#13#10'{'#13#10'  sender.setStyle("' +
              'transition: width 500ms, height 500ms");'#13#10'}')
          ParentAlignmentControl = False
          AlignmentControl = uniAlignmentClient
          LayoutAttribs.Align = 'center'
          LayoutAttribs.Pack = 'start'
          LayoutConfig.Height = '114px'
          LayoutConfig.Width = '98%'
          ClickEnabled = True
          ChangeEnabled = True
          BoxModel.CSSMargin.Top = '4px'
          BoxModel.CSSMargin.Bottom = '4px'
          BoxModel.CSSMargin.Right = '3px'
          BoxModel.CSSMargin.Left = '3px'
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
            259)
          object pnlChkFiltroInv: TMedpUnimPanelBase
            Left = 0
            Top = 11
            Width = 339
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
            LayoutAttribs.Pack = 'justify'
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '100%'
            ClickEnabled = True
            ChangeEnabled = True
            BoxModel.CSSMargin.Top = '10px'
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
              339
              50)
            object pnlChkSospesiInv: TMedpUnimPanelBase
              Left = 3
              Top = 10
              Width = 119
              Height = 32
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
              LayoutConfig.Height = 'auto'
              LayoutConfig.Width = 'auto'
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
                119
                32)
              object chkSospesiInv: TUnimCheckBox
                Left = 0
                Top = -15
                Width = 25
                Height = 47
                Hint = ''
                Margins.Left = 0
                Margins.Top = 0
                Margins.Right = 0
                Margins.Bottom = 0
                CreateOrder = 1
                Caption = ''
                LayoutConfig.Height = 'auto'
                LayoutConfig.Width = 'auto'
                OnClick = chkSospesiInvClick
              end
              object lblSospesiInv: TMedpUnimLabel
                Left = 20
                Top = 16
                Width = 99
                Height = 45
                Hint = ''
                Margins.Left = 0
                Margins.Top = 0
                Margins.Right = 0
                Margins.Bottom = 0
                CreateOrder = 2
                Caption = 'Sospesi'
                LayoutConfig.Height = 'auto'
                LayoutConfig.Width = 'auto'
                ParentFont = False
                Font.Height = -16
                Font.Style = [fsBold]
                JustifyContent = JustifyStart
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
                  99
                  45)
              end
            end
            object pnlChkCancellatiInv: TMedpUnimPanelBase
              Left = 122
              Top = 10
              Width = 119
              Height = 32
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
              LayoutConfig.Width = 'auto'
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
                119
                32)
              object chkCancellatiInv: TUnimCheckBox
                Left = 0
                Top = -15
                Width = 25
                Height = 47
                Hint = ''
                Margins.Left = 0
                Margins.Top = 0
                Margins.Right = 0
                Margins.Bottom = 0
                CreateOrder = 1
                Caption = ''
                LayoutConfig.Height = 'auto'
                LayoutConfig.Width = 'auto'
                OnClick = chkCancellatiInvClick
              end
              object lblCancellatiInv: TMedpUnimLabel
                Left = 20
                Top = 16
                Width = 99
                Height = 45
                Hint = ''
                Margins.Left = 0
                Margins.Top = 0
                Margins.Right = 0
                Margins.Bottom = 0
                CreateOrder = 2
                Caption = 'Cancellati'
                LayoutConfig.Height = 'auto'
                LayoutConfig.Width = 'auto'
                ParentFont = False
                Font.Height = -16
                Font.Style = [fsBold]
                JustifyContent = JustifyStart
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
                  99
                  45)
              end
            end
            object pnlTuttiInv: TMedpUnimPanelBase
              Left = 220
              Top = 10
              Width = 119
              Height = 32
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
              LayoutConfig.Width = 'auto'
              ClickEnabled = True
              ChangeEnabled = True
              BoxModel.CSSMargin.Top = '0px'
              BoxModel.CSSMargin.Bottom = '5px'
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
              DesignSize = (
                119
                32)
              object chkTuttiInv: TUnimCheckBox
                Left = 0
                Top = -15
                Width = 25
                Height = 47
                Hint = ''
                Margins.Left = 0
                Margins.Top = 0
                Margins.Right = 0
                Margins.Bottom = 0
                CreateOrder = 1
                Caption = ''
                LayoutConfig.Height = 'auto'
                LayoutConfig.Width = 'auto'
                OnClick = chkTuttiInvClick
              end
              object lblTuttiInv: TMedpUnimLabel
                Left = 20
                Top = 16
                Width = 99
                Height = 45
                Hint = ''
                Margins.Left = 0
                Margins.Top = 0
                Margins.Right = 0
                Margins.Bottom = 0
                CreateOrder = 2
                Caption = 'Tutti'
                LayoutConfig.Height = 'auto'
                LayoutConfig.Width = 'auto'
                ParentFont = False
                Font.Height = -16
                Font.Style = [fsBold]
                JustifyContent = JustifyStart
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
                  99
                  45)
              end
            end
          end
          object pnlFiltroDataInvioInv: TMedpUnimPanelBase
            Left = 0
            Top = 73
            Width = 339
            Height = 32
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
            LayoutConfig.Width = '100%'
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
              339
              32)
            object chkInviatiInv: TUnimCheckBox
              Left = 40
              Top = -17
              Width = 36
              Height = 47
              Hint = ''
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 0
              Margins.Bottom = 0
              CreateOrder = 1
              Caption = ''
              LayoutConfig.Height = 'auto'
              LayoutConfig.Width = 'auto'
              OnClick = chkInviatiInvClick
            end
            object lblFiltroDataInv: TMedpUnimLabel
              Left = 109
              Top = -1
              Width = 200
              Height = 45
              Hint = ''
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 0
              Margins.Bottom = 0
              CreateOrder = 2
              Caption = 'Data di invio dal/al:'
              LayoutConfig.Height = 'auto'
              ParentFont = False
              Font.Height = -16
              Font.Style = [fsBold]
              JustifyContent = JustifyStart
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
                200
                45)
            end
          end
          object pnlFiltroDataInv: TMedpUnimPanelDataDaA
            Left = 0
            Top = 115
            Width = 339
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
            Layout = 'hbox'
            LayoutAttribs.Align = 'center'
            LayoutAttribs.Pack = 'start'
            LayoutConfig.Height = '35'
            LayoutConfig.Width = '100%'
            ScreenMask.Enabled = True
            ScreenMask.ShowMessage = False
            OnChange = AggiornaListaMessaggiInviati
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
            DataDa.Top = 0
            DataDa.Width = 200
            DataDa.Height = 45
            DataDa.Hint = ''
            DataDa.Margins.Left = 0
            DataDa.Margins.Top = 0
            DataDa.Margins.Right = 0
            DataDa.Margins.Bottom = 0
            DataDa.FieldLabelWidth = 10
            DataDa.ClientEvents.UniEvents.Strings = (
              
                'afterCreate=function afterCreate(sender){ sender.originalValue=n' +
                'ull; sender.setEditable(false); }')
            DataDa.Flex = 1
            DataDa.DateFormat = 'dd/MM/yyyy'
            DataDa.LayoutConfig.Height = '100%'
            DataDa.SlotOrder = 'd/m/y'
            DataDa.Date = 44263.000000000000000000
            DataDa.Picker = dptFloated
            DataDa.ScreenMask.Enabled = True
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
            Separatore.Left = 13
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
            DataA.Left = 13
            DataA.Top = 0
            DataA.Width = 200
            DataA.Height = 45
            DataA.Hint = ''
            DataA.Margins.Left = 0
            DataA.Margins.Top = 0
            DataA.Margins.Right = 0
            DataA.Margins.Bottom = 0
            DataA.FieldLabelWidth = 10
            DataA.ClientEvents.UniEvents.Strings = (
              
                'afterCreate=function afterCreate(sender){ sender.originalValue=n' +
                'ull; sender.setEditable(false); }')
            DataA.Flex = 1
            DataA.DateFormat = 'dd/MM/yyyy'
            DataA.LayoutConfig.Height = '100%'
            DataA.SlotOrder = 'd/m/y'
            DataA.Date = 44263.000000000000000000
            DataA.Picker = dptFloated
            DataA.ScreenMask.Enabled = True
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
              339
              40)
          end
          object cmbSelAnagrafica: TMedpUnimSelect
            Left = 0
            Top = 165
            Width = 339
            Height = 33
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 6
            Anchors = []
            ClientEvents.UniEvents.Strings = (
              
                'afterCreate=function afterCreate(sender){ sender.setEditable(fal' +
                'se); }')
            FieldLabel = 'Selezione:'
            FieldLabelWidth = 28
            FieldLabelFont.Height = -16
            FieldLabelFont.Style = [fsBold]
            ScreenMask.Enabled = True
            ScreenMask.ShowMessage = False
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '100%'
            TabOrder = 2
            Picker = dptFloated
            OnChange = AggiornaListaMessaggiInviati
            BoxModel.CSSMargin.Top = '13px'
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
            SeparatoreTesto = ' - '
            ElementoVuoto = True
            DesignSize = (
              339
              33)
          end
          object pnlOggettoTestoInv: TMedpUnimPanelBase
            Left = 0
            Top = 203
            Width = 339
            Height = 48
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
            LayoutConfig.Width = '100%'
            ClickEnabled = True
            ChangeEnabled = True
            BoxModel.CSSMargin.Top = '0px'
            BoxModel.CSSMargin.Bottom = '0px'
            BoxModel.CSSMargin.Right = '0px'
            BoxModel.CSSMargin.Left = '0px'
            BoxModel.CSSPadding.Top = '3px'
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
              48)
            object edtOggettoTestoInv: TMedpUnimEdit
              Left = 0
              Top = 2
              Width = 253
              Height = 41
              Hint = ''
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 0
              Margins.Bottom = 0
              CreateOrder = 1
              BoxModel.CSSMargin.Top = '3px'
              BoxModel.CSSMargin.Bottom = '3px'
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
              Text = ''
              EmptyText = 'Ricerca nell'#39'oggetto o nel testo'
              ParentFont = False
              Flex = 1
              LayoutConfig.Height = '35'
              TabOrder = 1
              DesignSize = (
                253
                41)
            end
            object btnFiltroRicercaInv: TMedpUnimButton
              Left = 270
              Top = 3
              Width = 62
              Height = 45
              Hint = ''
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 0
              Margins.Bottom = 0
              CreateOrder = 2
              Anchors = []
              ScreenMask.Enabled = True
              ScreenMask.ShowMessage = False
              UI = 'action'
              Caption = '<i class="fas fa-filter"></i>'
              LayoutConfig.Height = '40'
              LayoutConfig.Width = '40'
              OnClick = AggiornaListaMessaggiInviati
              BoxModel.CSSMargin.Top = '3px'
              BoxModel.CSSMargin.Bottom = '3px'
              BoxModel.CSSMargin.Right = '3px'
              BoxModel.CSSMargin.Left = '3px'
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
                62
                45)
            end
          end
        end
        object pnlNumInviati: TMedpUnimPanelNumElem
          Left = 0
          Top = 355
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
          BoxModel.CSSBorder.Top = '1px solid black'
          BoxModel.CSSBorder.Bottom = '1px solid black'
          BoxModel.CSSBorder.Right = '1px solid black'
          BoxModel.CSSBorder.Left = '1px solid black'
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
          LabelNumElementi.Caption = 'Nessun messaggio'
          LabelNumElementi.Flex = 1
          LabelNumElementi.LayoutConfig.Height = 'auto'
          LabelNumElementi.ParentFont = False
          LabelNumElementi.Font.Style = [fsBold]
          LabelNumElementi.BoxModel.CSSMargin.Top = '0px'
          LabelNumElementi.BoxModel.CSSMargin.Bottom = '0px'
          LabelNumElementi.BoxModel.CSSMargin.Right = '0px'
          LabelNumElementi.BoxModel.CSSMargin.Left = '0px'
          LabelNumElementi.BoxModel.CSSPadding.Top = '0px'
          LabelNumElementi.BoxModel.CSSPadding.Bottom = '0px'
          LabelNumElementi.BoxModel.CSSPadding.Right = '0px'
          LabelNumElementi.BoxModel.CSSPadding.Left = '0px'
          LabelNumElementi.BoxModel.CSSBorder.Top = '0px'
          LabelNumElementi.BoxModel.CSSBorder.Bottom = '0px'
          LabelNumElementi.BoxModel.CSSBorder.Right = '0px'
          LabelNumElementi.BoxModel.CSSBorder.Left = '0px'
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
          Icona.BoxModel.CSSBorderRadius = '0px'
          Icona.DesignSize = (
            200
            45)
          CaptionZero = 'Nessun messaggio'
          CaptionSingolare = 'messaggio'
          CaptionPlurale = 'messaggi'
          DesignSize = (
            339
            45)
        end
        object pnlListaInviati: TMedpUnimPanelListaDisclosure
          Left = 0
          Top = 400
          Width = 339
          Height = 155
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
          OnChange = pnlListaInviatiChange
          ClickEnabled = True
          ChangeEnabled = True
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
          ColorPari = 16448250
          CSSBordoSeparatore = '1px solid #f0f0f0'
          ColorHeader = 15455685
          DesignSize = (
            339
            155)
        end
      end
      object tabDettaglioMessaggio: TUnimTabSheet
        Left = 4
        Top = 51
        Width = 339
        Height = 555
        Hint = ''
        Caption = 'tabDettaglioMessaggio'
        LayoutAttribs.Align = 'center'
        LayoutAttribs.Pack = 'start'
        DesignSize = (
          339
          555)
        object pnlHeaderDettMessaggio: TMedpUnimPanelHeaderDett
          Left = 0
          Top = 0
          Width = 339
          Height = 25
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
          Back.Top = -8
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
          Back.OnClick = pnlHeaderDettMessaggiolblBackClick
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
          LabelDettaglio.Top = -8
          LabelDettaglio.Width = 200
          LabelDettaglio.Height = 45
          LabelDettaglio.Hint = ''
          LabelDettaglio.Margins.Left = 0
          LabelDettaglio.Margins.Top = 0
          LabelDettaglio.Margins.Right = 0
          LabelDettaglio.Margins.Bottom = 0
          LabelDettaglio.Caption = 'Dettaglio messaggio'
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
          Up.Top = -8
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
          Up.OnClick = pnlHeaderDettMessaggiolblUpClick
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
          Down.Top = -8
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
          Down.OnClick = pnlHeaderDettMessaggiolblDownClick
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
            25)
        end
        object pnlDettMittente: TMedpUnimPanelBase
          Left = 0
          Top = 25
          Width = 339
          Height = 52
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          CreateOrder = 2
          Anchors = []
          Color = 16448250
          ParentAlignmentControl = False
          AlignmentControl = uniAlignmentClient
          Layout = 'hbox'
          LayoutAttribs.Align = 'center'
          LayoutAttribs.Pack = 'justify'
          LayoutConfig.Cls = 'activeColor'
          LayoutConfig.Height = 'auto'
          LayoutConfig.Width = '98%'
          OnClick = pnlDettMittenteClick
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
          BoxModel.CSSBorder.Top = '1px solid #f0f0f0'
          BoxModel.CSSBorder.Bottom = '1px solid #f0f0f0'
          BoxModel.CSSBorder.Right = '0px'
          BoxModel.CSSBorder.Left = '0px'
          BoxModel.CSSBorderRadius = '0px'
          DesignSize = (
            339
            52)
          object lblDettDestinatari: TMedpUnimLabel
            Left = 0
            Top = -5
            Width = 57
            Height = 57
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 1
            Caption = '<i class="fas fa-users"></i>'
            LayoutConfig.Cls = 'background-blue'
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = 'auto'
            ParentFont = False
            Font.Height = -28
            OnClick = pnlDettMittenteClick
            BoxModel.CSSMargin.Top = '5px'
            BoxModel.CSSMargin.Bottom = '5px'
            BoxModel.CSSMargin.Right = '3px'
            BoxModel.CSSMargin.Left = '2px'
            BoxModel.CSSPadding.Top = '4px'
            BoxModel.CSSPadding.Bottom = '4px'
            BoxModel.CSSPadding.Right = '4px'
            BoxModel.CSSPadding.Left = '4px'
            BoxModel.CSSBorder.Top = '0px'
            BoxModel.CSSBorder.Bottom = '0px'
            BoxModel.CSSBorder.Right = '0px'
            BoxModel.CSSBorder.Left = '0px'
            BoxModel.CSSBorderRadius = '25px'
            DesignSize = (
              57
              57)
          end
          object lblDettMittente: TMedpUnimLabel
            Left = 57
            Top = 0
            Width = 119
            Height = 41
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 2
            Caption = 'Da: mittente del messaggio'
            Flex = 1
            LayoutConfig.Height = '100%'
            LayoutConfig.Width = 'auto'
            ParentFont = False
            Font.Height = -17
            Font.Style = [fsUnderline]
            OnClick = pnlDettMittenteClick
            JustifyContent = JustifyStart
            BoxModel.CSSMargin.Top = '5px'
            BoxModel.CSSMargin.Bottom = '5px'
            BoxModel.CSSMargin.Right = '0px'
            BoxModel.CSSMargin.Left = '2px'
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
              119
              41)
          end
          object lblDettObbligatorio: TMedpUnimLabel
            Left = 234
            Top = 5
            Width = 49
            Height = 41
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 3
            Caption = '<i class="fas fa-exclamation-triangle"></i>'
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = 'auto'
            ParentFont = False
            Font.Height = -20
            OnClick = pnlDettMittenteClick
            BoxModel.CSSMargin.Top = '0px'
            BoxModel.CSSMargin.Bottom = '0px'
            BoxModel.CSSMargin.Right = '0px'
            BoxModel.CSSMargin.Left = '0px'
            BoxModel.CSSPadding.Top = '5px'
            BoxModel.CSSPadding.Bottom = '5px'
            BoxModel.CSSPadding.Right = '5px'
            BoxModel.CSSPadding.Left = '5px'
            BoxModel.CSSBorder.Top = '0px'
            BoxModel.CSSBorder.Bottom = '0px'
            BoxModel.CSSBorder.Right = '0px'
            BoxModel.CSSBorder.Left = '0px'
            BoxModel.CSSBorderRadius = '0px'
            DesignSize = (
              49
              41)
          end
          object lblDettLetto: TMedpUnimLabel
            Left = 290
            Top = 5
            Width = 49
            Height = 41
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 4
            Caption = '<i class="fas fa-envelope"></i>'
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = 'auto'
            ParentFont = False
            Font.Height = -20
            OnClick = pnlDettMittenteClick
            BoxModel.CSSMargin.Top = '0px'
            BoxModel.CSSMargin.Bottom = '0px'
            BoxModel.CSSMargin.Right = '0px'
            BoxModel.CSSMargin.Left = '0px'
            BoxModel.CSSPadding.Top = '5px'
            BoxModel.CSSPadding.Bottom = '5px'
            BoxModel.CSSPadding.Right = '5px'
            BoxModel.CSSPadding.Left = '5px'
            BoxModel.CSSBorder.Top = '0px'
            BoxModel.CSSBorder.Bottom = '0px'
            BoxModel.CSSBorder.Right = '0px'
            BoxModel.CSSBorder.Left = '0px'
            BoxModel.CSSBorderRadius = '0px'
            DesignSize = (
              49
              41)
          end
        end
        object pnlDettDateMessaggio: TMedpUnimPanel2Labels
          Left = 0
          Top = 77
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
          LayoutConfig.Height = 'auto'
          LayoutConfig.Width = '98%'
          ClickEnabled = True
          ChangeEnabled = True
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
          Label1.Left = 13
          Label1.Top = 0
          Label1.Width = 200
          Label1.Height = 45
          Label1.Hint = ''
          Label1.Margins.Left = 0
          Label1.Margins.Top = 0
          Label1.Margins.Right = 0
          Label1.Margins.Bottom = 0
          Label1.Caption = 'Invio:<br>22/02/2021 05:35'
          Label1.Flex = 1
          Label1.LayoutConfig.Height = 'auto'
          Label1.ParentFont = False
          Label1.Font.Height = -17
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
          Label2.Left = 13
          Label2.Top = 0
          Label2.Width = 200
          Label2.Height = 45
          Label2.Hint = ''
          Label2.Margins.Left = 0
          Label2.Margins.Top = 0
          Label2.Margins.Right = 0
          Label2.Margins.Bottom = 0
          Label2.Caption = 'Ricezione:<br>22/02/2021 05:35'
          Label2.Flex = 1
          Label2.LayoutConfig.Height = 'auto'
          Label2.ParentFont = False
          Label2.Font.Height = -17
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
            339
            45)
        end
        object pnlDettMsgLetto: TMedpUnimPanelBase
          Left = -4
          Top = 134
          Width = 347
          Height = 32
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
            32)
          object lblDettMsgLetto: TMedpUnimLabel
            Left = 0
            Top = 0
            Width = 137
            Height = 45
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 1
            Caption = 'Messaggio letto:'
            ParentFont = False
            Font.Height = -17
            JustifyContent = JustifyStart
            BoxModel.CSSMargin.Top = '0px'
            BoxModel.CSSMargin.Bottom = '0px'
            BoxModel.CSSMargin.Right = '0px'
            BoxModel.CSSMargin.Left = '0px'
            BoxModel.CSSPadding.Top = '5px'
            BoxModel.CSSPadding.Bottom = '5px'
            BoxModel.CSSPadding.Right = '5px'
            BoxModel.CSSPadding.Left = '0px'
            BoxModel.CSSBorder.Top = '0px'
            BoxModel.CSSBorder.Bottom = '0px'
            BoxModel.CSSBorder.Right = '0px'
            BoxModel.CSSBorder.Left = '0px'
            BoxModel.CSSBorderRadius = '0px'
            DesignSize = (
              137
              45)
          end
          object chkDettMsgLetto: TUnimCheckBox
            Left = 151
            Top = -15
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
            OnClick = chkDettMsgLettoClick
          end
          object lblDettDataLettura: TMedpUnimLabel
            Left = 199
            Top = 0
            Width = 137
            Height = 40
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 3
            Caption = ''
            LayoutConfig.Width = 'auto'
            ParentFont = False
            Font.Height = -17
            JustifyContent = JustifyStart
            BoxModel.CSSMargin.Top = '0px'
            BoxModel.CSSMargin.Bottom = '0px'
            BoxModel.CSSMargin.Right = '0px'
            BoxModel.CSSMargin.Left = '10px'
            BoxModel.CSSPadding.Top = '5px'
            BoxModel.CSSPadding.Bottom = '5px'
            BoxModel.CSSPadding.Right = '5px'
            BoxModel.CSSPadding.Left = '0px'
            BoxModel.CSSBorder.Top = '0px'
            BoxModel.CSSBorder.Bottom = '0px'
            BoxModel.CSSBorder.Right = '0px'
            BoxModel.CSSBorder.Left = '0px'
            BoxModel.CSSBorderRadius = '0px'
            DesignSize = (
              137
              40)
          end
        end
        object lblDettOggetto: TMedpUnimLabel
          Left = 0
          Top = 166
          Width = 339
          Height = 45
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          CreateOrder = 5
          Caption = 'Oggetto del messaggio'
          LayoutConfig.Height = 'auto'
          LayoutConfig.Width = '98%'
          ParentFont = False
          Font.Height = -19
          Font.Style = [fsBold]
          BoxModel.CSSMargin.Top = '0px'
          BoxModel.CSSMargin.Bottom = '0px'
          BoxModel.CSSMargin.Right = '0px'
          BoxModel.CSSMargin.Left = '0px'
          BoxModel.CSSPadding.Top = '5px'
          BoxModel.CSSPadding.Bottom = '5px'
          BoxModel.CSSPadding.Right = '5px'
          BoxModel.CSSPadding.Left = '5px'
          BoxModel.CSSBorder.Top = '0px'
          BoxModel.CSSBorder.Bottom = '0px'
          BoxModel.CSSBorder.Right = '0px'
          BoxModel.CSSBorder.Left = '0px'
          BoxModel.CSSBorderRadius = '0px'
          DesignSize = (
            339
            45)
        end
        object pnlDettAllegati: TMedpUnimPanelBase
          Left = -4
          Top = 208
          Width = 347
          Height = 96
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          CreateOrder = 6
          Anchors = []
          ClientEvents.UniEvents.Strings = (
            
              'afterCreate=function afterCreate(sender)'#13#10'{'#13#10'  sender.setStyle("' +
              'transition: width 500ms, height 500ms");'#13#10'}')
          ParentAlignmentControl = False
          AlignmentControl = uniAlignmentClient
          LayoutAttribs.Align = 'center'
          LayoutAttribs.Pack = 'start'
          LayoutConfig.Height = '35px'
          LayoutConfig.Width = '98%'
          ClickEnabled = True
          ChangeEnabled = True
          BoxModel.CSSMargin.Top = '5px'
          BoxModel.CSSMargin.Bottom = '0px'
          BoxModel.CSSMargin.Right = '0px'
          BoxModel.CSSMargin.Left = '0px'
          BoxModel.CSSPadding.Top = '0px'
          BoxModel.CSSPadding.Bottom = '0px'
          BoxModel.CSSPadding.Right = '0px'
          BoxModel.CSSPadding.Left = '0px'
          BoxModel.CSSBorder.Top = '1px solid black'
          BoxModel.CSSBorder.Bottom = '1px solid black'
          BoxModel.CSSBorder.Right = '1px solid black'
          BoxModel.CSSBorder.Left = '1px solid black'
          BoxModel.CSSBorderRadius = '0px'
          DesignSize = (
            347
            96)
          object pnlNumAllegati: TMedpUnimPanelNumElem
            Left = 0
            Top = 3
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
            LayoutConfig.Cls = 'activeColor'
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
            LabelNumElementi.Left = 16
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
            LabelNumElementi.Font.Height = -16
            LabelNumElementi.OnClick = pnlNumAllegatilblIconaClick
            LabelNumElementi.BoxModel.CSSMargin.Top = '0px'
            LabelNumElementi.BoxModel.CSSMargin.Bottom = '0px'
            LabelNumElementi.BoxModel.CSSMargin.Right = '0px'
            LabelNumElementi.BoxModel.CSSMargin.Left = '0px'
            LabelNumElementi.BoxModel.CSSPadding.Top = '0px'
            LabelNumElementi.BoxModel.CSSPadding.Bottom = '0px'
            LabelNumElementi.BoxModel.CSSPadding.Right = '0px'
            LabelNumElementi.BoxModel.CSSPadding.Left = '0px'
            LabelNumElementi.BoxModel.CSSBorder.Top = '0px'
            LabelNumElementi.BoxModel.CSSBorder.Bottom = '0px'
            LabelNumElementi.BoxModel.CSSBorder.Right = '0px'
            LabelNumElementi.BoxModel.CSSBorder.Left = '0px'
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
            Icona.Caption = 'fas fa-angle-down'
            Icona.LayoutConfig.Height = '100%'
            Icona.LayoutConfig.Width = '40'
            Icona.ParentFont = False
            Icona.Font.Height = -33
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
              347
              45)
          end
          object pnlDettListaAllegati: TMedpUnimPanelListaDisclosure
            Left = 0
            Top = 28
            Width = 347
            Height = 60
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
            ColorDispari = 16448250
            CSSBordoSeparatore = '1px solid #f0f0f0'
            ColorHeader = 15455685
            DesignSize = (
              347
              60)
          end
        end
        object memTestoMessaggio: TMedpUnimMemo
          Left = 0
          Top = 315
          Width = 339
          Height = 245
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          CreateOrder = 7
          Anchors = []
          ParentAlignmentControl = False
          AlignmentControl = uniAlignmentClient
          Layout = 'fit'
          LayoutConfig.Width = '98%'
          Flex = 1
          DaContare = False
          ClickEnabled = False
          ChangeEnabled = False
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
          ConfermaIcon.Left = 70
          ConfermaIcon.Top = 86
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
          Memo.ClearButton = False
          Memo.ReadOnly = True
          Memo.LayoutConfig.Height = '100%'
          Memo.LayoutConfig.Width = '100%'
          Memo.TabOrder = 0
          DesignSize = (
            339
            245)
        end
      end
      object tabDestinatari: TUnimTabSheet
        Left = 4
        Top = 51
        Width = 339
        Height = 555
        Hint = ''
        Caption = 'tabDestinatari'
        LayoutConfig.Width = '100%'
        LayoutAttribs.Align = 'center'
        LayoutAttribs.Pack = 'start'
        DesignSize = (
          339
          555)
        object pnlHeaderDettDestinatari: TMedpUnimPanelHeaderDett
          Left = 0
          Top = 8
          Width = 339
          Height = 33
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
          Back.Top = -4
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
          Back.OnClick = pnlHeaderDettDestinatarilblBackClick
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
          LabelDettaglio.Top = -4
          LabelDettaglio.Width = 200
          LabelDettaglio.Height = 45
          LabelDettaglio.Hint = ''
          LabelDettaglio.Margins.Left = 0
          LabelDettaglio.Margins.Top = 0
          LabelDettaglio.Margins.Right = 0
          LabelDettaglio.Margins.Bottom = 0
          LabelDettaglio.Caption = 'Lista destinatari'
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
          Up.Top = -4
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
          Down.Top = -4
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
            33)
        end
        object rgpFiltroDestinatari: TMedpUnimRadioGroup
          Left = 0
          Top = 41
          Width = 339
          Height = 44
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
          LayoutAttribs.Align = 'start'
          LayoutAttribs.Pack = 'justify'
          LayoutConfig.Height = 'auto'
          LayoutConfig.Width = '98%'
          ScreenMask.Enabled = True
          ScreenMask.ShowMessage = False
          OnChange = AggiornaListaDestinatari
          ClickEnabled = True
          ChangeEnabled = True
          BoxModel.CSSMargin.Top = '0px'
          BoxModel.CSSMargin.Bottom = '0px'
          BoxModel.CSSMargin.Right = '2px'
          BoxModel.CSSMargin.Left = '2px'
          BoxModel.CSSPadding.Top = '10px'
          BoxModel.CSSPadding.Bottom = '10px'
          BoxModel.CSSPadding.Right = '2px'
          BoxModel.CSSPadding.Left = '2px'
          BoxModel.CSSBorder.Top = '1px solid black'
          BoxModel.CSSBorder.Bottom = '1px solid black'
          BoxModel.CSSBorder.Right = '0px'
          BoxModel.CSSBorder.Left = '0px'
          BoxModel.CSSBorderRadius = '0px'
          Items.Strings = (
            'Tutti'
            'Ricevuto'
            'Non ricevuto')
          ItemIndex = 0
          DesignSize = (
            339
            44)
        end
        object pnlListaDestinatari: TMedpUnimPanelListaElem
          Left = 3
          Top = 87
          Width = 333
          Height = 468
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          CreateOrder = 3
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
          ColorDispari = 16448250
          CSSBordoSeparatore = '1px solid #f0f0f0'
          DesignSize = (
            333
            468)
        end
      end
    end
  end
end
