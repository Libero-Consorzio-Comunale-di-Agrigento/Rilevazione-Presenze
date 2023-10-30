inherited WA199FCheckRimborsiDM: TWA199FCheckRimborsiDM
  Height = 138
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select T030.COGNOME || '#39' '#39' || T030.NOME NOMINATIVO, '
      '       T030.MATRICOLA,'
      '       M040.DATADA, '
      '       M040.ORADA, '
      '       M040.DATAA, '
      '       M040.ORAA,'
      '       M040.PARTENZA,'
      '       M040.DESTINAZIONE,'
      '       M041F_GETDESCLOCALITA(M040.PARTENZA) D_PARTENZA,'
      '       M041F_GETDESCLOCALITA(M040.DESTINAZIONE) D_DESTINAZIONE,'
      '       M040.TIPOREGISTRAZIONE,'
      '       M140.FLAG_DESTINAZIONE,'
      
        '       decode(M140.FLAG_DESTINAZIONE,'#39'R'#39','#39'Regione'#39','#39'I'#39','#39'Fuori re' +
        'gione'#39','#39'E'#39','#39'Estero'#39',M140.FLAG_DESTINAZIONE) D_FLAG_DESTINAZIONE,'
      '       M140.FLAG_ISPETTIVA,'
      
        '       decode(M140.FLAG_ISPETTIVA,'#39'S'#39','#39'S'#236#39','#39'N'#39','#39'No'#39') D_FLAG_ISPE' +
        'TTIVA,'
      '       M040.STATO,'
      
        '       decode(M040.STATO,'#39'D'#39','#39'Da liquidare'#39','#39'L'#39','#39'Liquidata'#39','#39'P'#39',' +
        #39'Parzialmente liquidata'#39','#39'S'#39','#39'Sospesa'#39',M040.STATO) D_STATO,'
      
        '       T480_RES.CITTA || '#39' ('#39' || T480_RES.PROVINCIA || '#39')'#39' D_RES' +
        'IDENZA,'
      '       M040.MESESCARICO, '
      '       M040.MESECOMPETENZA, '
      '       M040.TOTALEGG,'
      '       M040.DURATA,'
      '       M040.ID_MISSIONE,'
      '       M040.PROTOCOLLO,'
      '       M040.COMMESSA,'
      '       M040.PROGRESSIVO'
      'from   M040_MISSIONI M040,'
      '       M140_RICHIESTE_MISSIONI M140, '
      '       T480_COMUNI T480_RES,'
      '       T850_ITER_RICHIESTE T850,'
      ':C700SELANAGRAFE'
      'and    T030.PROGRESSIVO = M040.PROGRESSIVO'
      'and    M140.ID(+) = M040.ID_MISSIONE'
      'and    V430.T430COMUNE = T480_RES.CODICE(+)'
      'and    T850.ID = M140.ID'
      'and    T850.ITER = '#39'M140'#39
      'and    T850.TIPO_RICHIESTA <> '#39'A'#39
      ':FILTRO'
      'order by M040.PROGRESSIVO, M040.DATADA desc')
    ReadBuffer = 50
    Variables.Data = {
      0400000003000000100000003A004F0052004400450052004200590001000000
      0000000000000000200000003A004300370030003000530045004C0041004E00
      4100470052004100460045000100000000000000000000000E0000003A004600
      49004C00540052004F00010000000000000000000000}
    ReadOnly = True
    AfterOpen = selTabellaAfterOpen
    AfterRefresh = selTabellaAfterRefresh
    object selTabellaNOMINATIVO: TStringField
      DisplayLabel = 'Nominativo'
      DisplayWidth = 20
      FieldName = 'NOMINATIVO'
      Size = 61
    end
    object selTabellaMATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selTabellaDATADA: TDateTimeField
      DisplayLabel = 'Data da'
      DisplayWidth = 10
      FieldName = 'DATADA'
    end
    object selTabellaORADA: TStringField
      DisplayLabel = 'Ora da'
      FieldName = 'ORADA'
      Size = 5
    end
    object selTabellaDATAA: TDateTimeField
      DisplayLabel = 'Data a'
      DisplayWidth = 10
      FieldName = 'DATAA'
    end
    object selTabellaORAA: TStringField
      DisplayLabel = 'Ora a'
      FieldName = 'ORAA'
      Size = 5
    end
    object selTabellaPARTENZA: TStringField
      DisplayLabel = 'Partenza'
      FieldName = 'PARTENZA'
      Visible = False
      Size = 8
    end
    object selTabellaD_PARTENZA: TStringField
      DisplayLabel = 'Partenza'
      DisplayWidth = 20
      FieldName = 'D_PARTENZA'
      Size = 40
    end
    object selTabellaDESTINAZIONE: TStringField
      DisplayLabel = 'Destinazione'
      DisplayWidth = 20
      FieldName = 'DESTINAZIONE'
      Visible = False
      Size = 200
    end
    object selTabellaD_DESTINAZIONE: TStringField
      DisplayLabel = 'Destinazione'
      DisplayWidth = 20
      FieldName = 'D_DESTINAZIONE'
      Size = 40
    end
    object selTabellaTIPOREGISTRAZIONE: TStringField
      DisplayLabel = 'Tipo trasferta'
      FieldName = 'TIPOREGISTRAZIONE'
      Size = 5
    end
    object selTabellaFLAG_DESTINAZIONE: TStringField
      DisplayLabel = 'Flag destinazione'
      FieldName = 'FLAG_DESTINAZIONE'
      Visible = False
      Size = 1
    end
    object selTabellaD_FLAG_DESTINAZIONE: TStringField
      DisplayLabel = 'Flag destinazione'
      DisplayWidth = 10
      FieldKind = fkInternalCalc
      FieldName = 'D_FLAG_DESTINAZIONE'
    end
    object selTabellaFLAG_ISPETTIVA: TStringField
      DisplayLabel = 'Flag ispettiva'
      FieldName = 'FLAG_ISPETTIVA'
      Visible = False
      Size = 1
    end
    object selTabellaD_FLAG_ISPETTIVA: TStringField
      DisplayLabel = 'Ispettiva'
      FieldKind = fkInternalCalc
      FieldName = 'D_FLAG_ISPETTIVA'
      Size = 2
    end
    object selTabellaSTATO: TStringField
      DisplayLabel = 'Stato'
      FieldName = 'STATO'
      Visible = False
      Size = 1
    end
    object selTabellaD_STATO: TStringField
      DisplayLabel = 'Stato'
      DisplayWidth = 10
      FieldKind = fkInternalCalc
      FieldName = 'D_STATO'
    end
    object selTabellaD_RESIDENZA: TStringField
      DisplayLabel = 'Residenza'
      DisplayWidth = 20
      FieldName = 'D_RESIDENZA'
      Size = 70
    end
    object selTabellaMESESCARICO: TDateTimeField
      DisplayLabel = 'Mese scarico'
      DisplayWidth = 10
      FieldName = 'MESESCARICO'
    end
    object selTabellaMESECOMPETENZA: TDateTimeField
      DisplayLabel = 'Mese competenza'
      DisplayWidth = 10
      FieldName = 'MESECOMPETENZA'
    end
    object selTabellaTOTALEGG: TFloatField
      DisplayLabel = 'Totale gg.'
      FieldName = 'TOTALEGG'
    end
    object selTabellaDURATA: TStringField
      DisplayLabel = 'Durata'
      FieldName = 'DURATA'
      Size = 7
    end
    object selTabellaID_MISSIONE: TIntegerField
      DisplayLabel = 'ID Missione'
      FieldName = 'ID_MISSIONE'
    end
    object selTabellaPROTOCOLLO: TStringField
      DisplayLabel = 'Protocollo'
      FieldName = 'PROTOCOLLO'
      Size = 10
    end
    object selTabellaCOMMESSA: TStringField
      DisplayLabel = 'Commessa'
      DisplayWidth = 15
      FieldName = 'COMMESSA'
      Size = 80
    end
    object selTabellaPROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
  end
end
