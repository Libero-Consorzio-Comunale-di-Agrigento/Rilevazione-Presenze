inherited WM013FRicAssenzeFM: TWM013FRicAssenzeFM
  inherited MainPanel: TMedpUnimPanelBase
    inherited tpnlRichieste: TMedpUnimTabPanelBase
      inherited tabElenco: TUnimTabSheet
        inherited rgpTipoRichiesta: TMedpUnimRadioGroup
          ScreenMask.Target = Owner
        end
        inherited pnlFiltroRichieste: TMedpUnimPanelBase
          Visible = False
        end
        inherited pnlListaRichieste: TMedpUnimPanelListaDisclosure
          ScreenMask.Enabled = False
        end
      end
      inherited tabDettaglio: TUnimTabSheet
        inherited btnDettModifica: TMedpUnimButton
          Visible = False
        end
      end
      inherited tabNote: TUnimTabSheet
        inherited pnlHeaderNote: TMedpUnimPanelHeaderDett
          Back.ScreenMask.Enabled = False
        end
      end
      inherited tabNuovaRichiesta: TUnimTabSheet
        inherited pnlDatiNuovaRichiesta: TMedpUnimPanelBase
          LayoutAttribs.Align = 'center'
          LayoutAttribs.Pack = 'start'
          LayoutConfig.Width = '100%'
          object lblAccorpCausali: TMedpUnimLabel
            Left = 0
            Top = 0
            Width = 321
            Height = 29
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 1
            Caption = 'Accorpamento causali'
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '98%'
            ParentFont = False
            Font.Style = [fsBold]
            JustifyContent = JustifyStart
            BoxModel.CSSMargin.Top = '3px'
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
              321
              29)
          end
          object cmbAccorpCausali: TMedpUnimSelect
            Left = 0
            Top = 23
            Width = 321
            Height = 33
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 2
            Anchors = []
            ClientEvents.UniEvents.Strings = (
              
                'afterCreate=function afterCreate(sender){ sender.setEditable(fal' +
                'se); }')
            ScreenMask.Enabled = True
            ScreenMask.WaitData = True
            ScreenMask.ShowMessage = False
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '98%'
            TabOrder = 13
            TabStop = False
            Picker = dptFloated
            OnChange = cmbAccorpCausaliChange
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
            SeparatoreTesto = ' '
            ElementoVuoto = True
            DesignSize = (
              321
              33)
          end
          object lblCausale: TMedpUnimLabel
            Left = 0
            Top = 57
            Width = 321
            Height = 29
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 3
            Caption = 'Causale'
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '98%'
            ParentFont = False
            Font.Style = [fsBold]
            JustifyContent = JustifyStart
            BoxModel.CSSMargin.Top = '3px'
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
              321
              29)
          end
          object cmbCausale: TMedpUnimSelect
            Left = 0
            Top = 78
            Width = 321
            Height = 33
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
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '98%'
            TabOrder = 6
            TabStop = False
            Picker = dptFloated
            OnChange = cmbCausaleChange
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
            SeparatoreTesto = ' '
            ElementoVuoto = False
            DesignSize = (
              321
              33)
          end
          object lblFamiliare: TMedpUnimLabel
            Left = 0
            Top = 111
            Width = 321
            Height = 29
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 5
            Caption = 'Familiare'
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '98%'
            ParentFont = False
            Font.Style = [fsBold]
            JustifyContent = JustifyStart
            BoxModel.CSSMargin.Top = '3px'
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
              321
              29)
          end
          object cmbFamiliare: TMedpUnimSelect
            Left = 0
            Top = 131
            Width = 321
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
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '98%'
            TabOrder = 5
            TabStop = False
            Picker = dptFloated
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
            SeparatoreTesto = ' '
            ElementoVuoto = False
            DesignSize = (
              321
              33)
          end
          object lblTipoFruizione: TMedpUnimLabel
            Left = 0
            Top = 164
            Width = 321
            Height = 29
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 7
            Caption = 'Tipo fruizione'
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '98%'
            ParentFont = False
            Font.Style = [fsBold]
            JustifyContent = JustifyStart
            BoxModel.CSSMargin.Top = '3px'
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
              321
              29)
          end
          object cmbTipoFruizione: TMedpUnimSelect
            Left = 0
            Top = 186
            Width = 321
            Height = 33
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 8
            Anchors = []
            ClientEvents.UniEvents.Strings = (
              
                'afterCreate=function afterCreate(sender){ sender.setEditable(fal' +
                'se); }')
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '98%'
            TabOrder = 4
            TabStop = False
            Picker = dptFloated
            OnChange = cmbTipoFruizioneChange
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
            TipoTesto = Descrizione
            SeparatoreTesto = ' '
            ElementoVuoto = False
            DesignSize = (
              321
              33)
          end
          object lblNote: TMedpUnimLabel
            Left = 0
            Top = 219
            Width = 321
            Height = 29
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 9
            Caption = 'Note'
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '98%'
            ParentFont = False
            Font.Style = [fsBold]
            JustifyContent = JustifyStart
            BoxModel.CSSMargin.Top = '3px'
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
              321
              29)
          end
          object cmbNote: TMedpUnimSelect
            Left = 0
            Top = 240
            Width = 321
            Height = 33
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 10
            Anchors = []
            ClientEvents.UniEvents.Strings = (
              
                'afterCreate=function afterCreate(sender){ sender.setEditable(fal' +
                'se); }')
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '98%'
            TabOrder = 3
            TabStop = False
            Picker = dptFloated
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
            SeparatoreTesto = ' '
            ElementoVuoto = True
            DesignSize = (
              321
              33)
          end
          object lblPeriodo: TMedpUnimLabel
            Left = 0
            Top = 273
            Width = 321
            Height = 29
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 11
            Caption = 'Periodo'
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '98%'
            ParentFont = False
            Font.Style = [fsBold]
            JustifyContent = JustifyStart
            BoxModel.CSSMargin.Top = '3px'
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
              321
              29)
          end
          object pnlDataDaANew: TMedpUnimPanelDataDaA
            Left = -6
            Top = 296
            Width = 321
            Height = 32
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 12
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
            DataDa.Left = 7
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
            DataDa.DateFormat = 'ddd, dd/MM/yyyy'
            DataDa.LayoutConfig.Height = '100%'
            DataDa.SlotOrder = 'd/m/y'
            DataDa.Date = 43790.000000000000000000
            DataDa.Picker = dptFloated
            DataDa.OnChange = edtDataDaChange
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
            Separatore.Left = 7
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
            DataA.Left = 7
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
            DataA.DateFormat = 'ddd, dd/MM/yyyy'
            DataA.LayoutConfig.Height = '100%'
            DataA.SlotOrder = 'd/m/y'
            DataA.Date = 43790.000000000000000000
            DataA.Picker = dptFloated
            DataA.OnChange = edtDataAChange
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
              321
              32)
          end
          object pnlOraDaANew: TMedpUnimPanelOraDaA
            Left = -6
            Top = 335
            Width = 321
            Height = 24
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 13
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
            BoxModel.CSSMargin.Top = '4px'
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
            OraDa.Left = 7
            OraDa.Top = -9
            OraDa.Width = 200
            OraDa.Height = 45
            OraDa.Hint = ''
            OraDa.Margins.Left = 0
            OraDa.Margins.Top = 0
            OraDa.Margins.Right = 0
            OraDa.Margins.Bottom = 0
            OraDa.BoxModel.CSSMargin.Top = '0px'
            OraDa.BoxModel.CSSMargin.Bottom = '0px'
            OraDa.BoxModel.CSSMargin.Right = '0px'
            OraDa.BoxModel.CSSMargin.Left = '0px'
            OraDa.BoxModel.CSSPadding.Top = '0px'
            OraDa.BoxModel.CSSPadding.Bottom = '0px'
            OraDa.BoxModel.CSSPadding.Right = '0px'
            OraDa.BoxModel.CSSPadding.Left = '0px'
            OraDa.BoxModel.CSSBorder.Top = '0px'
            OraDa.BoxModel.CSSBorder.Bottom = '0px'
            OraDa.BoxModel.CSSBorder.Right = '0px'
            OraDa.BoxModel.CSSBorder.Left = '0px'
            OraDa.BoxModel.CSSBorderRadius = '0px'
            OraDa.FieldLabel = 'Da'
            OraDa.FieldLabelWidth = 20
            OraDa.ClientEvents.UniEvents.Strings = (
              
                'afterCreate=function afterCreate(sender){ sender.setEditable(fal' +
                'se); }')
            OraDa.Flex = 1
            OraDa.TimeFormat = 'HH.mm'
            OraDa.LayoutConfig.Height = '100%'
            OraDa.Time = 0.490042546298354900
            OraDa.Picker = dptFloated
            OraDa.DesignSize = (
              200
              45)
            Separatore.Left = 7
            Separatore.Top = -9
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
            OraA.Left = 7
            OraA.Top = -9
            OraA.Width = 200
            OraA.Height = 45
            OraA.Hint = ''
            OraA.Margins.Left = 0
            OraA.Margins.Top = 0
            OraA.Margins.Right = 0
            OraA.Margins.Bottom = 0
            OraA.BoxModel.CSSMargin.Top = '0px'
            OraA.BoxModel.CSSMargin.Bottom = '0px'
            OraA.BoxModel.CSSMargin.Right = '0px'
            OraA.BoxModel.CSSMargin.Left = '4px'
            OraA.BoxModel.CSSPadding.Top = '0px'
            OraA.BoxModel.CSSPadding.Bottom = '0px'
            OraA.BoxModel.CSSPadding.Right = '0px'
            OraA.BoxModel.CSSPadding.Left = '0px'
            OraA.BoxModel.CSSBorder.Top = '0px'
            OraA.BoxModel.CSSBorder.Bottom = '0px'
            OraA.BoxModel.CSSBorder.Right = '0px'
            OraA.BoxModel.CSSBorder.Left = '0px'
            OraA.BoxModel.CSSBorderRadius = '0px'
            OraA.FieldLabel = 'a'
            OraA.FieldLabelWidth = 20
            OraA.ClientEvents.UniEvents.Strings = (
              
                'afterCreate=function afterCreate(sender){ sender.setEditable(fal' +
                'se); }')
            OraA.Flex = 1
            OraA.TimeFormat = 'HH.mm'
            OraA.LayoutConfig.Height = '100%'
            OraA.Time = 0.490042546298354900
            OraA.Picker = dptFloated
            OraA.DesignSize = (
              200
              45)
            DesignSize = (
              321
              24)
          end
          object lblNoteRichiesta: TMedpUnimLabel
            Left = 0
            Top = 371
            Width = 321
            Height = 29
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 14
            Caption = 'Note richiesta'
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '98%'
            ParentFont = False
            Font.Style = [fsBold]
            JustifyContent = JustifyStart
            BoxModel.CSSMargin.Top = '3px'
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
              321
              29)
          end
          object memNoteRichiesta: TMedpUnimMemo
            Left = 0
            Top = 400
            Width = 321
            Height = 48
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 15
            Anchors = []
            ParentAlignmentControl = False
            AlignmentControl = uniAlignmentClient
            Layout = 'fit'
            LayoutConfig.Height = '50'
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
            ConfermaIcon.Left = 61
            ConfermaIcon.Top = -1
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
              321
              48)
          end
          object lblMotivazione: TMedpUnimLabel
            Left = 0
            Top = 456
            Width = 321
            Height = 29
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 16
            Caption = 'Motivazione'
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '98%'
            ParentFont = False
            Font.Style = [fsBold]
            JustifyContent = JustifyStart
            BoxModel.CSSMargin.Top = '3px'
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
              321
              29)
          end
          object cmbMotivazione: TMedpUnimSelect
            Left = 0
            Top = 477
            Width = 321
            Height = 33
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 17
            Anchors = []
            ClientEvents.UniEvents.Strings = (
              
                'afterCreate=function afterCreate(sender){ sender.setEditable(fal' +
                'se); }')
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '98%'
            TabOrder = 2
            TabStop = False
            Picker = dptFloated
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
            SeparatoreTesto = ' '
            ElementoVuoto = False
            DesignSize = (
              321
              33)
          end
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
