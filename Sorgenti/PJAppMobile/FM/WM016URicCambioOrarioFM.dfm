inherited WM016FRicCambioOrarioFM: TWM016FRicCambioOrarioFM
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
        inherited pnlEliminaRevoca: TMedpUnimPanel2Button
          Button2.Visible = False
        end
      end
      inherited tabNote: TUnimTabSheet
        inherited pnlHeaderNote: TMedpUnimPanelHeaderDett
          Back.ScreenMask.Enabled = False
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
      inherited tabNuovaRichiesta: TUnimTabSheet
        inherited pnlDatiNuovaRichiesta: TMedpUnimPanelBase
          LayoutAttribs.Align = 'center'
          LayoutAttribs.Pack = 'start'
          LayoutConfig.Height = 'auto'
          LayoutConfig.Width = '98%'
          object pnlModRichiesta: TMedpUnimPanelBase
            Left = 2
            Top = 4
            Width = 331
            Height = 67
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 1
            Anchors = []
            ParentAlignmentControl = False
            AlignmentControl = uniAlignmentClient
            Layout = 'float'
            LayoutAttribs.Align = 'center'
            LayoutAttribs.Pack = 'justify'
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '100%'
            ClickEnabled = True
            ChangeEnabled = True
            BoxModel.CSSMargin.Top = '5px'
            BoxModel.CSSMargin.Bottom = '5px'
            BoxModel.CSSMargin.Right = '0px'
            BoxModel.CSSMargin.Left = '0px'
            BoxModel.CSSPadding.Top = '3px'
            BoxModel.CSSPadding.Bottom = '3px'
            BoxModel.CSSPadding.Right = '3px'
            BoxModel.CSSPadding.Left = '3px'
            BoxModel.CSSBorder.Top = '1px solid black'
            BoxModel.CSSBorder.Bottom = '1px solid black'
            BoxModel.CSSBorder.Right = '1px solid black'
            BoxModel.CSSBorder.Left = '1px solid black'
            BoxModel.CSSBorderRadius = '5px'
            DesignSize = (
              331
              67)
            object rbtnCambio: TMedpUnimRadioButton
              Left = 0
              Top = 3
              Width = 161
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
              Layout = 'hbox'
              LayoutAttribs.Align = 'center'
              LayoutAttribs.Pack = 'start'
              LayoutConfig.Height = 'auto'
              LayoutConfig.Width = '50%'
              OnChange = rbtnModRichiestaChange
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
              RadioIcon.Left = 6
              RadioIcon.Top = 11
              RadioIcon.Width = 20
              RadioIcon.Height = 20
              RadioIcon.Hint = ''
              RadioIcon.Margins.Left = 0
              RadioIcon.Margins.Top = 0
              RadioIcon.Margins.Right = 0
              RadioIcon.Margins.Bottom = 0
              RadioIcon.FieldLabel = 'RadioIcon'
              RadioIcon.FieldLabelWidth = 0
              RadioIcon.Anchors = []
              RadioIcon.ClientEvents.UniEvents.Strings = (
                'afterCreate=function afterCreate(sender){ sender.setLabel(""); }')
              RadioIcon.LayoutConfig.Height = '100%'
              RadioIcon.LayoutConfig.Width = 'auto'
              RadioIcon.ScreenMask.Enabled = True
              RadioIcon.ScreenMask.Message = 'Caricamento...'
              RadioIcon.BoxModel.CSSMargin.Top = '2px'
              RadioIcon.BoxModel.CSSMargin.Bottom = '2px'
              RadioIcon.BoxModel.CSSMargin.Right = '6px'
              RadioIcon.BoxModel.CSSMargin.Left = '2px'
              RadioIcon.BoxModel.CSSPadding.Top = '0px'
              RadioIcon.BoxModel.CSSPadding.Bottom = '0px'
              RadioIcon.BoxModel.CSSPadding.Right = '0px'
              RadioIcon.BoxModel.CSSPadding.Left = '0px'
              RadioIcon.BoxModel.CSSBorder.Top = '0px'
              RadioIcon.BoxModel.CSSBorder.Bottom = '0px'
              RadioIcon.BoxModel.CSSBorder.Right = '0px'
              RadioIcon.BoxModel.CSSBorder.Left = '0px'
              RadioIcon.BoxModel.CSSBorderRadius = '0px'
              RadioIcon.DesignSize = (
                20
                20)
              RadioLabel.Left = 61
              RadioLabel.Top = 25
              RadioLabel.Width = 200
              RadioLabel.Height = 45
              RadioLabel.Hint = ''
              RadioLabel.Margins.Left = 0
              RadioLabel.Margins.Top = 0
              RadioLabel.Margins.Right = 0
              RadioLabel.Margins.Bottom = 0
              RadioLabel.Caption = 'Cambio orario nel giorno stesso'
              RadioLabel.Flex = 1
              RadioLabel.ScreenMask.Enabled = True
              RadioLabel.ScreenMask.Message = 'Caricamento...'
              RadioLabel.LayoutConfig.Height = '100%'
              RadioLabel.ParentFont = False
              RadioLabel.Font.Style = [fsItalic]
              RadioLabel.JustifyContent = JustifyStart
              RadioLabel.BoxModel.CSSMargin.Top = '0px'
              RadioLabel.BoxModel.CSSMargin.Bottom = '0px'
              RadioLabel.BoxModel.CSSMargin.Right = '0px'
              RadioLabel.BoxModel.CSSMargin.Left = '0px'
              RadioLabel.BoxModel.CSSPadding.Top = '0px'
              RadioLabel.BoxModel.CSSPadding.Bottom = '0px'
              RadioLabel.BoxModel.CSSPadding.Right = '0px'
              RadioLabel.BoxModel.CSSPadding.Left = '0px'
              RadioLabel.BoxModel.CSSBorder.Top = '0px'
              RadioLabel.BoxModel.CSSBorder.Bottom = '0px'
              RadioLabel.BoxModel.CSSBorder.Right = '0px'
              RadioLabel.BoxModel.CSSBorder.Left = '0px'
              RadioLabel.BoxModel.CSSBorderRadius = '0px'
              RadioLabel.DesignSize = (
                200
                45)
              DesignSize = (
                161
                64)
            end
            object rbtnInversione: TMedpUnimRadioButton
              Left = 161
              Top = 0
              Width = 170
              Height = 64
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
              LayoutConfig.Width = '50%'
              OnChange = rbtnModRichiestaChange
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
              RadioIcon.Left = 7
              RadioIcon.Top = 11
              RadioIcon.Width = 20
              RadioIcon.Height = 20
              RadioIcon.Hint = ''
              RadioIcon.Margins.Left = 0
              RadioIcon.Margins.Top = 0
              RadioIcon.Margins.Right = 0
              RadioIcon.Margins.Bottom = 0
              RadioIcon.FieldLabel = 'RadioIcon'
              RadioIcon.FieldLabelWidth = 0
              RadioIcon.Anchors = []
              RadioIcon.ClientEvents.UniEvents.Strings = (
                'afterCreate=function afterCreate(sender){ sender.setLabel(""); }')
              RadioIcon.LayoutConfig.Height = '100%'
              RadioIcon.LayoutConfig.Width = 'auto'
              RadioIcon.ScreenMask.Enabled = True
              RadioIcon.ScreenMask.Message = 'Caricamento...'
              RadioIcon.BoxModel.CSSMargin.Top = '2px'
              RadioIcon.BoxModel.CSSMargin.Bottom = '2px'
              RadioIcon.BoxModel.CSSMargin.Right = '6px'
              RadioIcon.BoxModel.CSSMargin.Left = '2px'
              RadioIcon.BoxModel.CSSPadding.Top = '0px'
              RadioIcon.BoxModel.CSSPadding.Bottom = '0px'
              RadioIcon.BoxModel.CSSPadding.Right = '0px'
              RadioIcon.BoxModel.CSSPadding.Left = '0px'
              RadioIcon.BoxModel.CSSBorder.Top = '0px'
              RadioIcon.BoxModel.CSSBorder.Bottom = '0px'
              RadioIcon.BoxModel.CSSBorder.Right = '0px'
              RadioIcon.BoxModel.CSSBorder.Left = '0px'
              RadioIcon.BoxModel.CSSBorderRadius = '0px'
              RadioIcon.DesignSize = (
                20
                20)
              RadioLabel.Left = 70
              RadioLabel.Top = 25
              RadioLabel.Width = 200
              RadioLabel.Height = 45
              RadioLabel.Hint = ''
              RadioLabel.Margins.Left = 0
              RadioLabel.Margins.Top = 0
              RadioLabel.Margins.Right = 0
              RadioLabel.Margins.Bottom = 0
              RadioLabel.Caption = 'Scambio orario con altro giorno'
              RadioLabel.Flex = 1
              RadioLabel.ScreenMask.Enabled = True
              RadioLabel.ScreenMask.Message = 'Caricamento...'
              RadioLabel.LayoutConfig.Height = '100%'
              RadioLabel.ParentFont = False
              RadioLabel.Font.Style = [fsItalic]
              RadioLabel.JustifyContent = JustifyStart
              RadioLabel.BoxModel.CSSMargin.Top = '0px'
              RadioLabel.BoxModel.CSSMargin.Bottom = '0px'
              RadioLabel.BoxModel.CSSMargin.Right = '0px'
              RadioLabel.BoxModel.CSSMargin.Left = '0px'
              RadioLabel.BoxModel.CSSPadding.Top = '0px'
              RadioLabel.BoxModel.CSSPadding.Bottom = '0px'
              RadioLabel.BoxModel.CSSPadding.Right = '0px'
              RadioLabel.BoxModel.CSSPadding.Left = '0px'
              RadioLabel.BoxModel.CSSBorder.Top = '0px'
              RadioLabel.BoxModel.CSSBorder.Bottom = '0px'
              RadioLabel.BoxModel.CSSBorder.Right = '0px'
              RadioLabel.BoxModel.CSSBorder.Left = '0px'
              RadioLabel.BoxModel.CSSBorderRadius = '0px'
              RadioLabel.DesignSize = (
                200
                45)
              DesignSize = (
                170
                64)
            end
          end
          object lblGiorno: TMedpUnimLabel
            Left = 9
            Top = 71
            Width = 97
            Height = 31
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 2
            Caption = 'Giorno'
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '100%'
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
              97
              31)
          end
          object pnlData: TMedpUnimPanelBase
            Left = -4
            Top = 97
            Width = 347
            Height = 41
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
            BoxModel.CSSMargin.Top = '5px'
            BoxModel.CSSMargin.Bottom = '8px'
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
              41)
            object edtData: TMedpUnimDatePicker
              Left = 8
              Top = 4
              Width = 169
              Height = 37
              Hint = ''
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 0
              Margins.Bottom = 0
              CreateOrder = 1
              FieldLabelWidth = 0
              ClientEvents.UniEvents.Strings = (
                
                  'afterCreate=function afterCreate(sender){ sender.originalValue=n' +
                  'ull; sender.setEditable(false); }')
              DateFormat = 'dd/MM/yyyy'
              LayoutConfig.Height = '35'
              LayoutConfig.Width = '38%'
              SlotOrder = 'd/m/y'
              Date = 43971.000000000000000000
              Picker = dptFloated
              ScreenMask.Enabled = True
              ScreenMask.WaitData = True
              ScreenMask.ShowMessage = False
              OnChange = edtDataChange
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
                169
                37)
            end
            object lblGiornoSett: TMedpUnimLabel
              Left = 185
              Top = 11
              Width = 150
              Height = 37
              Hint = ''
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 0
              Margins.Bottom = 0
              CreateOrder = 2
              Caption = 'lblGiornoSett'
              ParentColor = False
              LayoutConfig.Cls = 'x-text-center'
              LayoutConfig.Height = '35'
              LayoutConfig.Width = '60%'
              ParentFont = False
              Font.Style = [fsBold]
              Color = clBtnFace
              BoxModel.CSSMargin.Top = '0px'
              BoxModel.CSSMargin.Bottom = '0px'
              BoxModel.CSSMargin.Right = '0px'
              BoxModel.CSSMargin.Left = '6px'
              BoxModel.CSSPadding.Top = '2px'
              BoxModel.CSSPadding.Bottom = '2px'
              BoxModel.CSSPadding.Right = '2px'
              BoxModel.CSSPadding.Left = '2px'
              BoxModel.CSSBorder.Top = '1px solid black'
              BoxModel.CSSBorder.Bottom = '1px solid black'
              BoxModel.CSSBorder.Right = '1px solid black'
              BoxModel.CSSBorder.Left = '1px solid black'
              BoxModel.CSSBorderRadius = '0px'
              DesignSize = (
                150
                37)
            end
          end
          object lblOrario: TMedpUnimLabel
            Left = 0
            Top = 136
            Width = 97
            Height = 31
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 4
            Caption = 'Orario'
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '100%'
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
              97
              31)
          end
          object lblOrarioDesc: TMedpUnimLabel
            Left = 59
            Top = 152
            Width = 200
            Height = 45
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 5
            Constraints.MinHeight = 25
            Caption = '000 orario di prova'
            LayoutConfig.Cls = 'x-text-center'
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '100%'
            ParentFont = False
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
              200
              45)
          end
          object lblSecondoGiorno: TMedpUnimLabel
            Left = 1
            Top = 172
            Width = 194
            Height = 31
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 6
            Caption = 'Secondo giorno'
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '100%'
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
              194
              31)
          end
          object cmbSecondoGiorno: TMedpUnimSelect
            Left = 3
            Top = 193
            Width = 324
            Height = 36
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 7
            Anchors = []
            ClientEvents.UniEvents.Strings = (
              
                'afterCreate=function afterCreate(sender){ sender.setEditable(fal' +
                'se); }')
            LayoutConfig.Cls = 'x-text-center'
            LayoutConfig.Height = '35'
            LayoutConfig.Width = '100%'
            TabOrder = 8
            Picker = dptFloated
            OnChange = cmbSecondoGiornoChange
            BoxModel.CSSMargin.Top = '5px'
            BoxModel.CSSMargin.Bottom = '8px'
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
              324
              36)
          end
          object lblOrarioRichiesto: TMedpUnimLabel
            Left = 0
            Top = 224
            Width = 194
            Height = 31
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 8
            Caption = 'Orario richiesto'
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '100%'
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
              194
              31)
          end
          object cmbOrarioRichiesto: TMedpUnimSelect
            Left = 0
            Top = 249
            Width = 324
            Height = 36
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 9
            Anchors = []
            ClientEvents.UniEvents.Strings = (
              
                'afterCreate=function afterCreate(sender){ sender.setEditable(fal' +
                'se); }')
            LayoutConfig.Height = '35'
            LayoutConfig.Width = '100%'
            TabOrder = 11
            Picker = dptFloated
            BoxModel.CSSMargin.Top = '5px'
            BoxModel.CSSMargin.Bottom = '8px'
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
              324
              36)
          end
          object lblOrarioRichiestoDesc: TMedpUnimLabel
            Left = 32
            Top = 285
            Width = 273
            Height = 41
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 10
            Constraints.MinHeight = 25
            Caption = '010 orario di prova richiesto'
            LayoutConfig.Cls = 'x-text-center'
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '100%'
            ParentFont = False
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
              273
              41)
          end
          object pnlSoloNote: TMedpUnimPanelBase
            Left = 0
            Top = 341
            Width = 333
            Height = 50
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 11
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
              333
              50)
            object lblSoloNote: TMedpUnimLabel
              Left = 13
              Top = 0
              Width = 200
              Height = 39
              Hint = ''
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 0
              Margins.Bottom = 0
              CreateOrder = 1
              Caption = 'Note richiesta - SOLO NOTE'
              LayoutConfig.Height = 'auto'
              LayoutConfig.Width = 'auto'
              ParentFont = False
              Font.Style = [fsBold]
              JustifyContent = JustifyStart
              BoxModel.CSSMargin.Top = '0px'
              BoxModel.CSSMargin.Bottom = '0px'
              BoxModel.CSSMargin.Right = '10px'
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
            object chkSoloNote: TUnimCheckBox
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
              OnClick = chkSoloNoteClick
            end
          end
          object memNote: TMedpUnimMemo
            Left = 0
            Top = 391
            Width = 333
            Height = 48
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 12
            Anchors = []
            ParentAlignmentControl = False
            AlignmentControl = uniAlignmentClient
            Layout = 'fit'
            LayoutConfig.Height = '70'
            LayoutConfig.Width = '100%'
            ClickEnabled = True
            ChangeEnabled = True
            BoxModel.CSSMargin.Top = '5px'
            BoxModel.CSSMargin.Bottom = '15px'
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
            ConfermaIcon.Left = 67
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
              333
              48)
          end
        end
      end
    end
  end
end
