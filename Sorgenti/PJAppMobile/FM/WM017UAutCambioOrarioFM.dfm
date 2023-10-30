inherited WM017FAutCambioOrarioFM: TWM017FAutCambioOrarioFM
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
        inherited pnlAutorizzaTutti: TMedpUnimPanelSlideUp
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
    end
  end
end
