inherited WR207FMenuWebPJFM: TWR207FMenuWebPJFM
  Width = 517
  Height = 324
  ParentCustomHint = False
  ParentBackground = False
  ParentBiDiMode = False
  ParentColor = False
  ParentCtl3D = False
  ParentDoubleBuffered = False
  ParentFont = False
  ParentShowHint = False
  ExplicitWidth = 517
  ExplicitHeight = 324
  inherited IWFrameRegion: TIWRegion
    Width = 517
    Height = 324
    LayoutMgr = TemplateProcessor
    ExplicitWidth = 517
    ExplicitHeight = 324
    inherited IWMainMenu: TmeIWMenu
      AttachedMenu = MainMenu
    end
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    Templates.Default = 'WR207FMenuWebPJFM.html'
  end
  inherited ActionList: TActionList
    object actEntiLocali: TAction
      Tag = 530
      Category = 'Ambiente'
      Caption = 'Enti locali'
      Hint = 'Enti locali'
      OnExecute = actExecute
    end
    object actDatiLiberi: TAction
      Tag = 116
      Category = 'Amministrazione sistema'
      Caption = 'Definizione dati liberi'
      Hint = 'Definizione dati liberi'
      OnExecute = actExecute
    end
    object actMsgElaborazioni: TAction
      Tag = 201
      Category = 'Amministrazione sistema'
      Caption = 'Messaggi delle elaborazioni'
      Hint = 'Messaggi delle elaborazioni'
      OnExecute = actExecute
    end
    object actUtilityDB: TAction
      Tag = 51
      Category = 'Amministrazione sistema'
      Caption = 'Utility del Database'
      Hint = 'Utility del Database'
      OnExecute = actExecute
    end
    object actOperatori: TAction
      Tag = 83
      Category = 'Amministrazione sistema'
      Caption = 'Operatori'
      Hint = 'Operatori'
      OnExecute = actExecute
    end
    object actAziende: TAction
      Tag = 84
      Category = 'Amministrazione sistema'
      Caption = 'Aziende'
      Hint = 'Aziende'
      OnExecute = actExecute
    end
    object actPermessi: TAction
      Tag = 85
      Category = 'Amministrazione sistema'
      Caption = 'Permessi'
      Hint = 'Permessi'
      OnExecute = actExecute
    end
    object actFiltroAnagrafe: TAction
      Tag = 86
      Category = 'Amministrazione sistema'
      Caption = 'Filtro anagrafe'
      Hint = 'Filtro anagrafe'
      OnExecute = actExecute
    end
    object actFiltroFunzioni: TAction
      Tag = 87
      Category = 'Amministrazione sistema'
      Caption = 'Filtro funzioni'
      Hint = 'Filtro funzioni'
      OnExecute = actExecute
    end
    object actFiltroDizionario: TAction
      Tag = 88
      Category = 'Amministrazione sistema'
      Caption = 'Filtro dizionario'
      Hint = 'Filtro dizionario'
      OnExecute = actExecute
    end
    object actProfiloIterAutorizzativi: TAction
      Tag = 80
      Category = 'Amministrazione sistema'
      Caption = 'Profilo iter autorizzativi'
      OnExecute = actExecute
    end
    object actLoginDipendenti: TAction
      Tag = 209
      Category = 'Amministrazione sistema'
      Caption = 'Login dipendenti'
      Hint = 'Login dipendenti'
      OnExecute = actExecute
    end
    object actAccessi: TAction
      Tag = 90
      Category = 'Amministrazione sistema'
      Caption = 'Accessi'
      Hint = 'Accessi'
      OnExecute = actExecute
    end
    object actMonitoraggioLog: TAction
      Tag = 149
      Category = 'Amministrazione sistema'
      Caption = 'Monitoraggio tabella di log'
      Hint = 'Monitoraggio tabella di log'
      OnExecute = actExecute
    end
    object actTabelleDatiLiberi: TAction
      Tag = 114
      Category = 'Ambiente'
      Caption = 'Tabelle dati liberi'
      Hint = 'Tabelle dati liberi'
      OnExecute = actExecute
    end
    object actRelazioni: TAction
      Tag = 190
      Category = 'Amministrazione sistema'
      Caption = 'Relazioni tra dati anagrafici'
      Hint = 'Relazioni tra dati anagrafici'
      OnExecute = actExecute
    end
    object actAllineaStorici: TAction
      Tag = 20
      Category = 'Amministrazione sistema'
      Caption = 'Allineamento dati storici'
      Hint = 'Allineamento dati storici'
      OnExecute = actExecute
    end
    object actManipolazioneDati: TAction
      Tag = 202
      Category = 'Amministrazione sistema'
      Caption = 'Utility manipolazione dati'
      OnExecute = actExecute
    end
    object actGestioneSicurezza: TAction
      Tag = -2
      Caption = 'Cambio Password'
      Hint = 'Cambio Password'
      OnExecute = actGestioneSicurezzaExecute
    end
    object actDataLavoro: TAction
      Tag = -1
      Category = 'Personale'
      Caption = 'Data di lavoro'
      Hint = 'Data di lavoro'
      OnExecute = actDataLavoroExecute
    end
    object actFiltroCessati: TAction
      Tag = -2
      Category = 'Personale'
      Caption = 'Visualizza dipendenti cessati'
      Hint = 'Visualizza dipendenti cessati'
      OnExecute = actFiltroCessatiExecute
    end
    object actDatiCalcolati: TAction
      Tag = 73
      Category = 'Elaborazioni'
      Caption = 'Dati calcolati'
      OnExecute = actExecute
    end
    object actCheckRimborsi: TAction
      Tag = 74
      Category = 'Gestione trasferte'
      Caption = 'Controllo rimborsi'
      Hint = 'Controllo rimborsi'
    end
    object actElaborazioneFluper: TAction
      Tag = 574
      Category = 'Flussi statistici'
      Caption = 'Elaborazione fornitura FLUPER'
      OnExecute = actExecute
    end
    object actAnagraficaStipendi: TAction
      Tag = 503
      Category = 'Personale'
      Caption = 'Anagrafica stipendi'
      OnExecute = actExecute
    end
    object actInformazioniSu: TAction
      Tag = -1
      Caption = 'Informazioni su...'
      OnExecute = actExecute
    end
    object actCambioAzienda: TAction
      Tag = 158
      Category = 'Amministrazione sistema'
      Caption = 'Cambio azienda'
      Hint = 'Cambio azienda'
      OnExecute = actExecute
    end
    object actFotoDipendente: TAction
      Tag = 67
      Caption = 'Foto del dipendente'
      Hint = 'Foto del dipendente'
      OnExecute = actExecute
    end
    object actDownloadTeamViewer: TAction
      Tag = -1
      Caption = 'Download TeamViewer per assistenza remota'
      Hint = 'Download TeamViewer per assistenza remota'
      OnExecute = actExecute
    end
  end
  inherited MainMenu: TMainMenu
    Left = 24
    Top = 80
    object File1: TMenuItem
      Caption = 'File'
    end
    object Amministrazionesistema1: TMenuItem
      Caption = 'Amministrazione sistema'
      object AziendeOperatori1: TMenuItem
        Caption = 'Aziende/Operatori'
        object Operatori1: TMenuItem
          Action = actOperatori
        end
        object Aziende1: TMenuItem
          Action = actAziende
        end
        object Permessi1: TMenuItem
          Action = actPermessi
        end
        object FiltroAnagrafe1: TMenuItem
          Action = actFiltroAnagrafe
        end
        object FiltroFunzioni1: TMenuItem
          Action = actFiltroFunzioni
        end
        object FiltroDizionario1: TMenuItem
          Action = actFiltroDizionario
        end
        object Profiliiterautorizzativi1: TMenuItem
          Tag = 80
          Action = actProfiloIterAutorizzativi
        end
        object NWR207_2: TMenuItem
          Caption = '-'
        end
        object Logindipendenti1: TMenuItem
          Action = actLoginDipendenti
        end
        object Accessi1: TMenuItem
          Action = actAccessi
        end
        object NWR207_3: TMenuItem
          Caption = '-'
        end
        object CambioPassword1: TMenuItem
          Tag = -2
          Action = actGestioneSicurezza
        end
        object Cambioazienda1: TMenuItem
          Tag = 158
          Action = actCambioAzienda
        end
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object AllineaStorici1: TMenuItem
        Tag = 1020
        Action = actAllineaStorici
      end
      object Utilitymanipolazionedati1: TMenuItem
        Action = actManipolazioneDati
      end
      object N8: TMenuItem
        Caption = '-'
      end
      object Utilitydeldatabase1: TMenuItem
        Action = actUtilityDB
      end
      object Monitoraggiotabelladilog1: TMenuItem
        Action = actMonitoraggioLog
      end
      object Messaggidelleelaborazioni1: TMenuItem
        Action = actMsgElaborazioni
      end
      object N9: TMenuItem
        Caption = '-'
      end
      object Definizionedatiliberi1: TMenuItem
        Action = actDatiLiberi
      end
      object Relazionitracampianagrafici1: TMenuItem
        Action = actRelazioni
      end
    end
    object Personale1: TMenuItem
      Caption = 'Personale'
      object Anagraficastipendi1: TMenuItem
        Action = actAnagraficaStipendi
      end
      object Datadilavoro1: TMenuItem
        Tag = -2
        Action = actDataLavoro
      end
      object Visualizzadipendenticessati1: TMenuItem
        Tag = -2
        Action = actFiltroCessati
      end
      object N26: TMenuItem
        Caption = '-'
      end
    end
    object Ambiente1: TMenuItem
      Caption = 'Ambiente'
      object abelledatiliberi1: TMenuItem
        Action = actTabelleDatiLiberi
      end
      object EntiLocalieRegioni1: TMenuItem
        Action = actEntiLocali
      end
    end
    object Interfacce1: TMenuItem
      Caption = 'Interfacce'
    end
    object Moduliaccessori1: TMenuItem
      Caption = 'Moduli accessori'
    end
    object N4: TMenuItem
      Caption = '?'
      object Informazionisu1: TMenuItem
        Action = actInformazioniSu
      end
      object DownloadTeamViewer1: TMenuItem
        Action = actDownloadTeamViewer
        Caption = 
          '<div onclick="ReleaseLock(); GActivateLock=false; return true;">' +
          'Download TeamViewer per assistenza remota</div>'
      end
    end
  end
end
