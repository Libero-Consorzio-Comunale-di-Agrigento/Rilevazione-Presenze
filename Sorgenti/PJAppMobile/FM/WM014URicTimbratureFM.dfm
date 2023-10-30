inherited WM014FRicTimbratureFM: TWM014FRicTimbratureFM
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
          Height = 441
          LayoutAttribs.Align = 'center'
          LayoutAttribs.Pack = 'start'
          LayoutConfig.Height = 'auto'
          LayoutConfig.Width = '98%'
          BoxModel.CSSMargin.Bottom = '6px'
          ExplicitLeft = 0
          ExplicitWidth = 339
          ExplicitHeight = 441
          object lblGiorno: TMedpUnimLabel
            Left = 0
            Top = 2
            Width = 339
            Height = 40
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 1
            Caption = 'Ora'
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '100%'
            ParentFont = False
            Font.Style = [fsBold]
            BoxModel.CSSMargin.Top = '6px'
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
              40)
          end
          object edtOra: TMedpUnimTimePicker
            Left = 56
            Top = 38
            Width = 200
            Height = 33
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 2
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
            ClientEvents.UniEvents.Strings = (
              
                'afterCreate=function afterCreate(sender){ sender.setEditable(fal' +
                'se); }')
            TimeFormat = 'HH.mm'
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = 'auto'
            Time = 0.517361111111111200
            Picker = dptFloated
            Font.Height = -12
            DesignSize = (
              200
              33)
          end
          object rgpVersoTimbratura: TMedpUnimRadioGroup
            Left = -4
            Top = 66
            Width = 347
            Height = 35
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
            LayoutAttribs.Align = 'start'
            LayoutAttribs.Pack = 'justify'
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '60%'
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
            BoxModel.CSSBorder.Top = '0px'
            BoxModel.CSSBorder.Bottom = '0px'
            BoxModel.CSSBorder.Right = '0px'
            BoxModel.CSSBorder.Left = '0px'
            BoxModel.CSSBorderRadius = '0px'
            Items.Strings = (
              'Entrata'
              'Uscita')
            DesignSize = (
              347
              35)
          end
          object lblCausale: TMedpUnimLabel
            Left = 0
            Top = 111
            Width = 339
            Height = 40
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 6
            Caption = 'Causale'
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
              339
              40)
          end
          object cmbCausale: TMedpUnimSelect
            Left = 64
            Top = 135
            Width = 200
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
            LayoutConfig.Width = '100%'
            TabOrder = 6
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
              200
              45)
          end
          object lblRilevatore: TMedpUnimLabel
            Left = 0
            Top = 164
            Width = 339
            Height = 40
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 8
            Caption = 'Rilevatore'
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '100%'
            ParentFont = False
            Font.Style = [fsBold]
            JustifyContent = JustifyStart
            BoxModel.CSSMargin.Top = '8px'
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
              40)
          end
          object cmbRilevatore: TMedpUnimSelect
            Left = 64
            Top = 191
            Width = 200
            Height = 45
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
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '100%'
            TabOrder = 8
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
              200
              45)
          end
          object lblMotivazione: TMedpUnimLabel
            Left = 0
            Top = 226
            Width = 339
            Height = 40
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 10
            Caption = 'Motivazione'
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '100%'
            ParentFont = False
            Font.Style = [fsBold]
            JustifyContent = JustifyStart
            BoxModel.CSSMargin.Top = '8px'
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
              40)
          end
          object cmbMotivazione: TMedpUnimSelect
            Left = 64
            Top = 253
            Width = 200
            Height = 45
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 11
            Anchors = []
            ClientEvents.UniEvents.Strings = (
              
                'afterCreate=function afterCreate(sender){ sender.setEditable(fal' +
                'se); }')
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '100%'
            TabOrder = 11
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
              200
              45)
          end
          object lblNote: TMedpUnimLabel
            Left = 0
            Top = 286
            Width = 339
            Height = 40
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 12
            Caption = 'Note richiesta'
            LayoutConfig.Height = 'auto'
            LayoutConfig.Width = '100%'
            ParentFont = False
            Font.Style = [fsBold]
            JustifyContent = JustifyStart
            BoxModel.CSSMargin.Top = '8px'
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
              40)
          end
          object memNote: TMedpUnimMemo
            Left = 64
            Top = 320
            Width = 200
            Height = 50
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CreateOrder = 13
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
            ConfermaIcon.Left = 0
            ConfermaIcon.Top = 0
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
              200
              50)
          end
        end
        inherited pnlOkAnnulla: TMedpUnimPanel2Button
          Top = 441
          CreateOrder = 3
          ExplicitTop = 441
        end
        object btnEliminaTimbratura: TMedpUnimButton
          Left = -2
          Top = 486
          Width = 341
          Height = 45
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          CreateOrder = 3
          Anchors = []
          UI = 'action'
          IconCls = 'trash'
          Caption = 'Elimina Timbratura'
          LayoutConfig.Height = '40'
          LayoutConfig.Width = '98%'
          OnClick = OnEliminaTimbraturaClick
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
      object tabTimbrature: TUnimTabSheet
        Left = 4
        Top = 51
        Width = 339
        Height = 555
        Hint = ''
        Caption = 'tabTimbrature'
        LayoutConfig.Width = '98%'
        LayoutAttribs.Align = 'center'
        LayoutAttribs.Pack = 'start'
        DesignSize = (
          339
          555)
        object pnlHeaderTimbrature: TMedpUnimPanelHeaderDett
          Left = 2
          Top = 0
          Width = 337
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
          Back.Left = 12
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
          Back.OnClick = OnBackTimbratureClick
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
          LabelDettaglio.Top = 3
          LabelDettaglio.Width = 200
          LabelDettaglio.Height = 45
          LabelDettaglio.Hint = ''
          LabelDettaglio.Margins.Left = 0
          LabelDettaglio.Margins.Top = 0
          LabelDettaglio.Margins.Right = 0
          LabelDettaglio.Margins.Bottom = 0
          LabelDettaglio.Caption = 'Data'
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
          LabelDettaglio.BoxModel.CSSBorderRadius = '0px'
          LabelDettaglio.DesignSize = (
            200
            45)
          Up.Left = 12
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
          Down.Left = 12
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
            337
            46)
          object edtDataTimbrature: TMedpUnimDatePicker
            Left = 128
            Top = 0
            Width = 200
            Height = 45
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            ClientEvents.UniEvents.Strings = (
              
                'afterCreate=function afterCreate(sender){ sender.originalValue=n' +
                'ull; sender.setEditable(false); }')
            DateFormat = 'dd/MM/yyyy'
            SlotOrder = 'd/m/y'
            Date = 43777.000000000000000000
            Picker = dptFloated
            OnChange = OnDataTimbratureChange
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
              45)
          end
        end
        object btnNuovaTimbratura: TMedpUnimButton
          Left = 0
          Top = 70
          Width = 337
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
          Caption = 'Nuova Timbratura'
          LayoutConfig.Height = '45'
          LayoutConfig.Width = '98%'
          OnClick = OnNuovaTimbraturaClick
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
            45)
        end
        object pnlListaTimbrature: TMedpUnimPanelListaElem
          Left = -2
          Top = 115
          Width = 341
          Height = 440
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
          ColorPari = 16448250
          CSSBordoSeparatore = '1px solid #f0f0f0'
          DesignSize = (
            341
            440)
        end
      end
    end
  end
end
