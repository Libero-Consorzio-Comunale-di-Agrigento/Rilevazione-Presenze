inherited WA174FParPianifTurniDM: TWA174FParPianifTurniDM
  Height = 126
  Width = 316
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select T082.*, T082.rowid'
      '  from T082_PAR_PIANIFORARI T082'
      ' :ORDERBY')
    QBEDefinition.QBEFieldDefs = {
      05000000240000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000000C00
      00005400490054004F004C004F00010000000000160000004E004F0054004500
      5F005300540041004D0050004100010000000000180000004400450053004300
      520049005A0049004F004E004500310001000000000018000000440045005300
      4300520049005A0049004F004E00450032000100000000001600000044004500
      540054005F005300540041004D00500041000100000000001200000052004900
      4700480045005F00440049005000010000000000140000004F00520044005F00
      5300540041004D0050004100010000000000160000005400490050004F005F00
      5300540041004D00500041000100000000001200000054004F0054005F005400
      550052004E004F000100000000001A00000054004F0054005F004F0050004500
      5F005400550052004E004F000100000000001E00000054004F0054005F004C00
      490051005500490044004100420049004C004500010000000000140000004400
      4500540054005F004F0052004100520049000100000000001C00000054004F00
      54005F005400550052004E0049005F004D004500530045000100000000001800
      000054004F0054005F00470045004E004500520041004C004900010000000000
      0E00000041005300530045004E005A0045000100000000001200000053004100
      4C00440049005F004F0052004500010000000000140000004D00410052004700
      49004E0045005F00530058000100000000001E000000440049004D0045004E00
      530049004F004E0045005F0046004F004E005400010000000000120000004700
      47005F0050004100470049004E0041000100000000001C000000530045005000
      41005200410054004F00520045005F0043004F004C0001000000000020000000
      53004500500041005200410054004F00520045005F0052004900470048004500
      010000000000200000004F005200490045004E00540041004D0045004E005400
      4F005F005000410047000100000000001E0000004D004F00440041004C004900
      540041005F004C00410056004F0052004F000100000000000E0000004F005200
      44005F005600490053000100000000001C0000005000490041004E0049004600
      5F00470047005F00460045005300540001000000000020000000500049004100
      4E00490046005F0053004F004C004F005F005400550052004E00010000000000
      1A0000005000490041004E00490046005F00470047005F004100530053000100
      000000002000000043004100550053005F00450043004C005500440049005400
      550052004E004F0001000000000014000000520049004700480045005F004E00
      4F004D004500010000000000200000004F0052004100520049004F005F005300
      49004E00540045005400490043004F000100000000001E000000440041005400
      4F005F0041004E0041004700520041004600490043004F000100000000001600
      0000470045004E004500520041005A0049004F004E0045000100000000001000
      000049004E0049005A00490041004C0045000100000000001000000043004F00
      5200520045004E0054004500010000000000}
    AfterInsert = selTabellaAfterInsert
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Required = True
      Size = 5
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 1000
    end
    object selTabellaTITOLO: TStringField
      DisplayLabel = 'Titolo'
      FieldName = 'TITOLO'
      Size = 1000
    end
    object selTabellaMODALITA_LAVORO: TStringField
      DisplayLabel = 'Modalit'#224' lavoro'
      FieldName = 'MODALITA_LAVORO'
      Size = 1
    end
    object selTabellaGENERAZIONE: TStringField
      DisplayLabel = 'Gener. pianif. progressiva'
      FieldName = 'GENERAZIONE'
      Size = 1
    end
    object selTabellaINIZIALE: TStringField
      DisplayLabel = 'Vis. pianif. iniziale'
      FieldName = 'INIZIALE'
      Size = 1
    end
    object selTabellaCORRENTE: TStringField
      DisplayLabel = 'Vis. pianif. corrente'
      FieldName = 'CORRENTE'
      Size = 1
    end
    object selTabellaDETT_STAMPA: TStringField
      DisplayLabel = 'Sintet./Dettagl.'
      FieldName = 'DETT_STAMPA'
      Size = 1
    end
    object selTabellaTIPO_STAMPA: TStringField
      DisplayLabel = 'Prevent./Consunt.'
      FieldName = 'TIPO_STAMPA'
      Size = 1
    end
    object selTabellaGG_PAGINA: TIntegerField
      DisplayLabel = 'GG per pag.'
      FieldName = 'GG_PAGINA'
      Visible = False
    end
    object selTabellaDIMENSIONE_FONT: TIntegerField
      DisplayLabel = 'Dimens. font'
      FieldName = 'DIMENSIONE_FONT'
    end
    object selTabellaNOTE_STAMPA: TStringField
      FieldName = 'NOTE_STAMPA'
      Visible = False
      Size = 2000
    end
    object selTabellaDESCRIZIONE1: TStringField
      DisplayLabel = 'Descrizione 1'
      FieldName = 'DESCRIZIONE1'
      Visible = False
      Size = 1000
    end
    object selTabellaDESCRIZIONE2: TStringField
      DisplayLabel = 'Descrizione 2'
      FieldName = 'DESCRIZIONE2'
      Visible = False
      Size = 1000
    end
    object selTabellaRIGHE_DIP: TStringField
      FieldName = 'RIGHE_DIP'
      Visible = False
      Size = 1
    end
    object selTabellaORD_STAMPA: TStringField
      FieldName = 'ORD_STAMPA'
      Visible = False
      Size = 10
    end
    object selTabellaTOT_TURNO: TStringField
      FieldName = 'TOT_TURNO'
      Visible = False
      Size = 1
    end
    object selTabellaTOT_OPE_TURNO: TStringField
      FieldName = 'TOT_OPE_TURNO'
      Visible = False
      Size = 1
    end
    object selTabellaTOT_LIQUIDABILE: TStringField
      FieldName = 'TOT_LIQUIDABILE'
      Visible = False
      Size = 1
    end
    object selTabellaDETT_ORARI: TStringField
      FieldName = 'DETT_ORARI'
      Visible = False
      Size = 1
    end
    object selTabellaTOT_TURNI_MESE: TStringField
      FieldName = 'TOT_TURNI_MESE'
      Visible = False
      Size = 1
    end
    object selTabellaTOT_GENERALI: TStringField
      FieldName = 'TOT_GENERALI'
      Visible = False
      Size = 1
    end
    object selTabellaASSENZE: TStringField
      FieldName = 'ASSENZE'
      Visible = False
      Size = 1
    end
    object selTabellaSALDI_ORE: TStringField
      FieldName = 'SALDI_ORE'
      Visible = False
      Size = 1
    end
    object selTabellaMARGINE_SX: TIntegerField
      FieldName = 'MARGINE_SX'
      Visible = False
    end
    object selTabellaSEPARATORE_COL: TStringField
      FieldName = 'SEPARATORE_COL'
      Visible = False
      Size = 1
    end
    object selTabellaSEPARATORE_RIGHE: TStringField
      FieldName = 'SEPARATORE_RIGHE'
      Visible = False
      Size = 1
    end
    object selTabellaORIENTAMENTO_PAG: TStringField
      FieldName = 'ORIENTAMENTO_PAG'
      Visible = False
      Size = 1
    end
    object selTabellaORD_VIS: TStringField
      FieldName = 'ORD_VIS'
      Visible = False
      Size = 10
    end
    object selTabellaPIANIF_GG_FEST: TStringField
      FieldName = 'PIANIF_GG_FEST'
      Visible = False
      Size = 1
    end
    object selTabellaPIANIF_SOLO_TURN: TStringField
      FieldName = 'PIANIF_SOLO_TURN'
      Visible = False
      Size = 1
    end
    object selTabellaPIANIF_GG_ASS: TStringField
      FieldName = 'PIANIF_GG_ASS'
      Visible = False
      Size = 1
    end
    object selTabellaCAUS_ECLUDITURNO: TStringField
      FieldName = 'CAUS_ECLUDITURNO'
      Visible = False
      Size = 2000
    end
    object selTabellaRIGHE_NOME: TStringField
      FieldName = 'RIGHE_NOME'
      Visible = False
      Size = 1
    end
    object selTabellaORARIO_SINTETICO: TStringField
      FieldName = 'ORARIO_SINTETICO'
      Visible = False
      Size = 1
    end
    object selTabellaDATO_ANAGRAFICO: TStringField
      FieldName = 'DATO_ANAGRAFICO'
      Visible = False
      Size = 40
    end
    object selTabellaASSENZE_OPERATIVE: TStringField
      FieldName = 'ASSENZE_OPERATIVE'
      Size = 1
    end
    object selTabellaRENDI_OPERATIVA: TStringField
      FieldName = 'RENDI_OPERATIVA'
      Size = 1
    end
    object selTabellaREPERIBILITA: TStringField
      FieldName = 'REPERIBILITA'
      Size = 1
    end
    object selTabellaRIEPILOGO_NOTE: TStringField
      FieldName = 'RIEPILOGO_NOTE'
      Size = 1
    end
    object selTabellaCOMPATTA_RIGHE_DIP: TStringField
      DisplayLabel = 'Compatta righe di dettaglio'
      FieldName = 'COMPATTA_RIGHE_DIP'
      Visible = False
      Size = 1
    end
  end
  inherited selEstrazioneDati: TOracleDataSet
    Left = 112
  end
  inherited dsrEstrazioniDati: TDataSource
    Left = 112
  end
  inherited selT900: TOracleDataSet
    Left = 200
  end
  inherited selT901: TOracleDataSet
    Left = 256
  end
end
