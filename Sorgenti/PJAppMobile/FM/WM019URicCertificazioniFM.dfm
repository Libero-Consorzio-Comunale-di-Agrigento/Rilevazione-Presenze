inherited WM019FRicCertificazioniFM: TWM019FRicCertificazioniFM
  inherited MainPanel: TMedpUnimPanelBase
    inherited tpnlRichieste: TMedpUnimTabPanelBase
      inherited tabElenco: TUnimTabSheet
        inherited rgpTipoRichiesta: TMedpUnimRadioGroup
          ScreenMask.Target = Owner
          Items.Strings = (
            'Da validare'
            'Validate'
            'Negate')
        end
        inherited pnlDataDaA: TMedpUnimPanelDataDaA
          ClearIcon.Visible = True
        end
        inherited pnlFiltroRichieste: TMedpUnimPanelBase
          Layout = 'hbox'
          LayoutConfig.Height = 'auto'
          LayoutConfig.Width = '98%'
          BoxModel.CSSMargin.Bottom = '5px'
          object lblFiltroModello: TMedpUnimLabel
            Left = 8
            Top = 5
            Width = 153
            Height = 45
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 1
            Caption = 'Filtro modello:'
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
              153
              45)
          end
          object cmbFiltroModello: TMedpUnimSelect
            Left = 169
            Top = 5
            Width = 170
            Height = 45
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
            Flex = 1
            TabOrder = 2
            Picker = dptFloated
            OnChange = cmbFiltroModelloChange
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
            TipoTesto = Codice
            SeparatoreTesto = ' '
            ElementoVuoto = True
            DesignSize = (
              170
              45)
          end
        end
        inherited pnlListaRichieste: TMedpUnimPanelListaDisclosure
          CreateOrder = 4
        end
      end
      inherited tabDettaglio: TUnimTabSheet
        inherited pnlEliminaRevoca: TMedpUnimPanel2Button
          Visible = False
          Button2.Visible = False
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
          Left = 0
          Width = 339
          LayoutAttribs.Align = 'center'
          LayoutAttribs.Pack = 'start'
          LayoutConfig.Width = '100%'
          ExplicitLeft = 0
          ExplicitWidth = 339
          object lblInsModRichiesta: TMedpUnimLabel
            Left = 6
            Top = 14
            Width = 333
            Height = 33
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 1
            Caption = 'Inserimento/Modifica scheda informativa'
            LayoutConfig.Cls = 'x-text-center'
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '98%'
            ParentFont = False
            Font.Height = -24
            Font.Style = [fsBold]
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
              333
              33)
          end
          object pnlStato: TMedpUnimPanelBase
            Left = -4
            Top = 56
            Width = 347
            Height = 63
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
            LayoutConfig.Width = '98%'
            LayoutConfig.Margin = '98%'
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
            object lblStato: TMedpUnimLabel
              Left = 17
              Top = 18
              Width = 88
              Height = 39
              Hint = ''
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 0
              Margins.Bottom = 0
              CreateOrder = 1
              Caption = 'Stato:'
              LayoutConfig.Height = '30'
              LayoutConfig.Width = 'auto'
              ParentFont = False
              Font.Height = -20
              Font.Style = [fsBold]
              JustifyContent = JustifyStart
              BoxModel.CSSMargin.Top = '0px'
              BoxModel.CSSMargin.Bottom = '0px'
              BoxModel.CSSMargin.Right = '20px'
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
                88
                39)
            end
            object chkStato: TMedpUnimCheckBox
              Left = 144
              Top = 0
              Width = 189
              Height = 58
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
              LayoutConfig.Width = 'auto'
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
              CheckIcon.Left = 0
              CheckIcon.Top = 0
              CheckIcon.Width = 225
              CheckIcon.Height = 47
              CheckIcon.Hint = ''
              CheckIcon.Caption = ''
              CheckIcon.LayoutConfig.Height = '100%'
              CheckIcon.LayoutConfig.Width = 'auto'
              CheckIcon.LayoutConfig.Margin = '3px 3px 3px 3px'
              CheckLabel.Left = 89
              CheckLabel.Top = 21
              CheckLabel.Width = 200
              CheckLabel.Height = 45
              CheckLabel.Hint = ''
              CheckLabel.Margins.Left = 0
              CheckLabel.Margins.Top = 0
              CheckLabel.Margins.Right = 0
              CheckLabel.Margins.Bottom = 0
              CheckLabel.Caption = 'Definitiva'
              CheckLabel.Flex = 1
              CheckLabel.LayoutConfig.Height = '100%'
              CheckLabel.ParentFont = False
              CheckLabel.JustifyContent = JustifyStart
              CheckLabel.BoxModel.CSSMargin.Top = '0px'
              CheckLabel.BoxModel.CSSMargin.Bottom = '0px'
              CheckLabel.BoxModel.CSSMargin.Right = '0px'
              CheckLabel.BoxModel.CSSMargin.Left = '5px'
              CheckLabel.BoxModel.CSSPadding.Top = '0px'
              CheckLabel.BoxModel.CSSPadding.Bottom = '0px'
              CheckLabel.BoxModel.CSSPadding.Right = '0px'
              CheckLabel.BoxModel.CSSPadding.Left = '0px'
              CheckLabel.BoxModel.CSSBorder.Top = '0px'
              CheckLabel.BoxModel.CSSBorder.Bottom = '0px'
              CheckLabel.BoxModel.CSSBorder.Right = '0px'
              CheckLabel.BoxModel.CSSBorder.Left = '0px'
              CheckLabel.BoxModel.CSSBorderRadius = '0px'
              CheckLabel.DesignSize = (
                200
                45)
              DesignSize = (
                189
                58)
            end
          end
          object lblValidita: TMedpUnimLabel
            Left = -1
            Top = 159
            Width = 340
            Height = 25
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 3
            Caption = 'Validit'#224':'
            LayoutConfig.Height = '25'
            LayoutConfig.Width = '98%'
            ParentFont = False
            Font.Height = -20
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
            Top = 189
            Width = 339
            Height = 32
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 4
            Enabled = False
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
          object lblModello: TMedpUnimLabel
            Left = 0
            Top = 226
            Width = 153
            Height = 45
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 5
            Caption = 'Modello:'
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '98%'
            ParentFont = False
            Font.Height = -20
            Font.Style = [fsBold]
            JustifyContent = JustifyStart
            BoxModel.CSSMargin.Top = '10px'
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
              153
              45)
          end
          object lblCodModello: TMedpUnimLabel
            Left = 0
            Top = 258
            Width = 339
            Height = 36
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 6
            Caption = 'lblCodModello'
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '98%'
            ParentFont = False
            Font.Height = -16
            BoxModel.CSSMargin.Top = '2px'
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
              339
              36)
          end
          object cmbModello: TMedpUnimSelect
            Left = 0
            Top = 294
            Width = 339
            Height = 45
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
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '98%'
            TabOrder = 9
            Picker = dptFloated
            OnChange = cmbModelloChange
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
            TipoTesto = Codice
            SeparatoreTesto = ' '
            ElementoVuoto = False
            DesignSize = (
              339
              45)
          end
          object lblDescrizioneModello: TMedpUnimLabel
            Left = 0
            Top = 333
            Width = 340
            Height = 27
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 8
            Caption = 'Nessun modello selezionato'
            LayoutConfig.Cls = 'x-text-center'
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '98%'
            ParentFont = False
            Font.Height = -16
            BoxModel.CSSMargin.Top = '5px'
            BoxModel.CSSMargin.Bottom = '2px'
            BoxModel.CSSMargin.Right = '0px'
            BoxModel.CSSMargin.Left = '0px'
            BoxModel.CSSPadding.Top = '5px'
            BoxModel.CSSPadding.Bottom = '5px'
            BoxModel.CSSPadding.Right = '5px'
            BoxModel.CSSPadding.Left = '5px'
            BoxModel.CSSBorder.Top = '1px solid black'
            BoxModel.CSSBorder.Bottom = '1px solid black'
            BoxModel.CSSBorder.Right = '1px solid black'
            BoxModel.CSSBorder.Left = '1px solid black'
            BoxModel.CSSBorderRadius = '5px'
            DesignSize = (
              340
              27)
          end
          object btnCompilaScheda: TMedpUnimButton
            Left = 0
            Top = 360
            Width = 329
            Height = 45
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 9
            Anchors = []
            UI = 'action'
            IconCls = 'fas fa-pencil-alt'
            Caption = 'Compila scheda'
            Font.Height = -17
            LayoutConfig.Width = '98%'
            OnClick = btnCompilaSchedaClick
            BoxModel.CSSMargin.Top = '10px'
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
              329
              45)
          end
          object lblNoteDocumento: TMedpUnimLabel
            Left = 5
            Top = 402
            Width = 334
            Height = 40
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 10
            Caption = 'Note al documento:'
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '98%'
            ParentFont = False
            Font.Height = -20
            Font.Style = [fsBold]
            JustifyContent = JustifyStart
            BoxModel.CSSMargin.Top = '10px'
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
              334
              40)
          end
          object memNoteDocumento: TMedpUnimMemo
            Left = 0
            Top = 431
            Width = 337
            Height = 79
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 11
            Anchors = []
            ParentAlignmentControl = False
            AlignmentControl = uniAlignmentClient
            Layout = 'fit'
            LayoutConfig.Height = '75'
            LayoutConfig.Width = '98%'
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
            ConfermaIcon.Left = 69
            ConfermaIcon.Top = 13
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
              79)
          end
        end
      end
      object tabModello: TUnimTabSheet
        Left = 4
        Top = 51
        Width = 339
        Height = 555
        Hint = ''
        Caption = 'tabModello'
        LayoutAttribs.Align = 'center'
        LayoutAttribs.Pack = 'start'
        DesignSize = (
          339
          555)
        object pnlHeaderModello: TMedpUnimPanelHeaderDett
          Left = 2
          Top = 0
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
          Back.OnClick = pnlHeaderModellolblBackClick
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
          LabelDettaglio.Caption = 'Modello scheda informativa'
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
        object pnlModello: TMedpUnimPanelBase
          Left = 4
          Top = 42
          Width = 333
          Height = 455
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
          Layout = 'float'
          LayoutAttribs.Align = 'center'
          LayoutAttribs.Pack = 'start'
          LayoutConfig.Width = '98%'
          Flex = 1
          ClickEnabled = True
          ChangeEnabled = True
          BoxModel.CSSMargin.Top = '0px'
          BoxModel.CSSMargin.Bottom = '5px'
          BoxModel.CSSMargin.Right = '0px'
          BoxModel.CSSMargin.Left = '0px'
          BoxModel.CSSPadding.Top = '0px'
          BoxModel.CSSPadding.Bottom = '5px'
          BoxModel.CSSPadding.Right = '0px'
          BoxModel.CSSPadding.Left = '0px'
          BoxModel.CSSBorder.Top = '1px solid black'
          BoxModel.CSSBorder.Bottom = '1px solid black'
          BoxModel.CSSBorder.Right = '0px'
          BoxModel.CSSBorder.Left = '0px'
          BoxModel.CSSBorderRadius = '0px'
          DesignSize = (
            333
            455)
        end
        object pnlOkAnnullaModello: TMedpUnimPanel2Button
          Left = -8
          Top = 510
          Width = 347
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
          Button1.OnClick = pnlOkAnnullaModelloButton1Click
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
          Button2.OnClick = pnlOkAnnullaModelloButton2Click
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
