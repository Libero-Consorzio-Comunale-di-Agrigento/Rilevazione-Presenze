inherited WM010FAutTimbratureFM: TWM010FAutTimbratureFM
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
      inherited tabNote: TUnimTabSheet
        inherited pnlHeaderNote: TMedpUnimPanelHeaderDett
          Back.ScreenMask.Enabled = False
        end
      end
      inherited tabAllegati: TUnimTabSheet
        inherited pnlNuovoModifica: TMedpUnimPanelBase
          inherited pnlUpload: TMedpUnimPanelBase [1]
          end
          inherited pnlModificaFile: TMedpUnimPanel2Labels [2]
          end
        end
      end
    end
  end
end
