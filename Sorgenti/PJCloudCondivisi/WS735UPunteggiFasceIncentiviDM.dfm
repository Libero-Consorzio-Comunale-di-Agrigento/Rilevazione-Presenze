inherited WS735FPunteggiFasceIncentiviDM: TWS735FPunteggiFasceIncentiviDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT SG735.*, SG735.ROWID'
      'FROM SG735_PUNTEGGIFASCE_INCENTIVI SG735'
      'WHERE TIPOLOGIA = NVL(:TIPO,'#39'V'#39')'
      ':ORDERBY')
    Variables.Data = {
      0400000002000000100000003A004F0052004400450052004200590001000000
      00000000000000000A0000003A005400490050004F0005000000000000000000
      0000}
    BeforePost = BeforePost
    object selTabellaCODQUOTA: TStringField
      DisplayLabel = 'Quota'
      FieldName = 'CODQUOTA'
      Size = 5
    end
    object selTabellaD_CODQUOTA: TStringField
      DisplayLabel = 'Descrizione'
      FieldKind = fkLookup
      FieldName = 'D_CODQUOTA'
      LookupDataSet = S735FPunteggiFasceIncentiviMW.selT765
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CODQUOTA'
      ReadOnly = True
      Size = 200
      Lookup = True
    end
    object selTabellaDECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
    end
    object selTabellaDECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Scadenza'
      FieldName = 'DECORRENZA_FINE'
    end
    object selTabellaPUNTEGGIO_DA: TFloatField
      DisplayLabel = 'Da % gg. effettivi'
      FieldName = 'PUNTEGGIO_DA'
    end
    object selTabellaPUNTEGGIO_A: TFloatField
      DisplayLabel = 'A % gg. effettivi'
      FieldName = 'PUNTEGGIO_A'
    end
    object selTabellaPERC: TFloatField
      DisplayLabel = '% gg. effettivi'
      FieldName = 'PERC'
    end
    object selTabellaTIPOLOGIA: TStringField
      FieldName = 'TIPOLOGIA'
      Visible = False
      Size = 1
    end
    object selTabellaFLESSIBILITA: TStringField
      DisplayLabel = 'Flessibilit'#224
      FieldName = 'FLESSIBILITA'
      Visible = False
      Size = 1
    end
  end
end
