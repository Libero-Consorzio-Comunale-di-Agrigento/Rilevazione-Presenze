inherited WA195FImpRichRimborsoDM: TWA195FImpRichRimborsoDM
  Height = 138
  Width = 404
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select '
      '  T850.TIPO_RICHIESTA,'
      '  T030.COGNOME||'#39' '#39'||T030.NOME NOMINATIVO,'
      '  T030.MATRICOLA,'
      '  --M140.*,'
      '  M140.ID,'
      '  M140.PROGRESSIVO,'
      '  M140.PROTOCOLLO,'
      
        '  decode(M140.FLAG_DESTINAZIONE,'#39'R'#39','#39'Italia'#39','#39'I'#39','#39'Italia'#39','#39'Ester' +
        'o'#39') D_DESTINAZIONE,'
      '  M140.FLAG_ISPETTIVA,'
      '  M140F_GETPARTENZA(M140.ID) PARTENZA,'
      '  M140F_GETDESTINAZIONI(M140.ID) ELENCO_DESTINAZIONI,'
      '  M140F_GETRIENTRO(M140.ID) RIENTRO,'
      '  M140.DATADA,'
      '  M140.DATAA,'
      '  M140.ORADA,'
      '  M140.ORAA,'
      '  --M150.*,'
      '  M150.INDENNITA_KM,  '
      '  M150.CODICE,'
      '  M150.ID_RIMBORSO,'
      
        '  decode(M150.INDENNITA_KM,'#39'S'#39',M021.DESCRIZIONE,M020.DESCRIZIONE' +
        ') DESCRIZIONE,'
      '  M150.KMPERCORSI,'
      '  M150.KMPERCORSI_VARIATO,'
      '  M150.RIMBORSO,'
      '  M150.COD_VALUTA,'
      '  M150.RIMBORSO_VARIATO,'
      '  M150.STATO,'
      '  M150.NOTE,'
      '  M150.ROWID,'
      '  T480.CITTA COMUNE_RESIDENZA,'
      '  T480.CAP CAP_RESIDENZA,'
      '  T480_DOM.CITTA COMUNE_DOMICILIO,'
      '  T480_DOM.CAP CAP_DOMICILIO'
      'from '
      
        '  M140_RICHIESTE_MISSIONI M140, M150_RICHIESTE_RIMBORSI M150, T8' +
        '50_ITER_RICHIESTE T850, '
      
        '  M020_TIPIRIMBORSI M020, M021_TIPIINDENNITAKM M021, T480_COMUNI' +
        ' T480_DOM,'
      '  :C700SELANAGRAFE'
      'and T030.PROGRESSIVO = M140.PROGRESSIVO'
      'and T850.ITER = '#39'M140'#39
      'and T850.ID = M140.ID'
      'and T850.TIPO_RICHIESTA = '#39'5'#39
      'and M150.ID = M140.ID'
      'and M150.STATO = '#39'A'#39
      'and M020.CODICE(+) = M150.CODICE'
      'and M021.CODICE(+) = M150.CODICE'
      
        'and trunc(sysdate) between M021.DECORRENZA(+) and M021.DECORRENZ' +
        'A_FINE(+)'
      'and V430.T430COMUNE_DOM_BASE = T480_DOM.CODICE(+)'
      'order by M140.DATADA,M140.ORADA,M140.PROTOCOLLO'
      ''
      '')
    Variables.Data = {
      0400000002000000100000003A004F0052004400450052004200590001000000
      0000000000000000200000003A004300370030003000530045004C0041004E00
      410047005200410046004500010000000000000000000000}
    OnApplyRecord = selTabellaApplyRecord
    UpdatingTable = 'M150_RICHIESTE_RIMBORSI'
    CachedUpdates = True
    BeforeInsert = BeforeInsert
    BeforeDelete = BeforeDelete
    OnCalcFields = selTabellaCalcFields
    object selM150TIPO_RICHIESTA: TStringField
      FieldName = 'TIPO_RICHIESTA'
      ReadOnly = True
      Visible = False
      Size = 1
    end
    object selM150NOMINATIVO: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 30
      FieldName = 'NOMINATIVO'
      ReadOnly = True
      Size = 61
    end
    object selM150MATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldName = 'MATRICOLA'
      ReadOnly = True
      Size = 8
    end
    object selM150D_DESTINAZIONE: TStringField
      DisplayLabel = 'Destin.'
      DisplayWidth = 6
      FieldName = 'D_DESTINAZIONE'
      ReadOnly = True
      Size = 10
    end
    object selM150FLAG_ISPETTIVA: TStringField
      DisplayLabel = 'Isp.'
      FieldName = 'FLAG_ISPETTIVA'
      ReadOnly = True
      Required = True
      Size = 1
    end
    object selM150PARTENZA: TStringField
      DisplayLabel = 'Partenza'
      DisplayWidth = 40
      FieldName = 'PARTENZA'
      Visible = False
      Size = 200
    end
    object selTabellaELENCO_DESTINAZIONI: TStringField
      DisplayLabel = 'Destinazioni'
      DisplayWidth = 40
      FieldName = 'ELENCO_DESTINAZIONI'
      Size = 2000
    end
    object selM150RIENTRO: TStringField
      DisplayLabel = 'Rientro'
      DisplayWidth = 40
      FieldName = 'RIENTRO'
      Visible = False
      Size = 200
    end
    object selM150C_PERCORSO: TStringField
      DisplayLabel = 'Percorso'
      DisplayWidth = 50
      FieldKind = fkCalculated
      FieldName = 'C_PERCORSO'
      Size = 500
      Calculated = True
    end
    object selM150DATADA: TDateTimeField
      DisplayLabel = 'Dal'
      DisplayWidth = 10
      FieldName = 'DATADA'
      ReadOnly = True
    end
    object selM150DATAA: TDateTimeField
      DisplayLabel = 'Al'
      DisplayWidth = 10
      FieldName = 'DATAA'
      ReadOnly = True
    end
    object selM150ORADA: TStringField
      DisplayLabel = 'Dalle'
      FieldName = 'ORADA'
      ReadOnly = True
      Size = 5
    end
    object selM150ORAA: TStringField
      DisplayLabel = 'Alle'
      FieldName = 'ORAA'
      ReadOnly = True
      Size = 5
    end
    object selM150INDENNITA_KM: TStringField
      FieldName = 'INDENNITA_KM'
      Visible = False
      Size = 1
    end
    object selM150DESCRIZIONE: TStringField
      DisplayLabel = 'Voce'
      DisplayWidth = 20
      FieldName = 'DESCRIZIONE'
      ReadOnly = True
      Size = 40
    end
    object selM150KMPERCORSI: TFloatField
      DisplayLabel = 'KM'
      DisplayWidth = 4
      FieldName = 'KMPERCORSI'
      ReadOnly = True
    end
    object selTabellaKMPERCORSI_VARIATO: TFloatField
      DisplayLabel = 'KM rimb.'
      DisplayWidth = 8
      FieldName = 'KMPERCORSI_VARIATO'
    end
    object selTabellaCOD_VALUTA: TStringField
      DisplayLabel = 'Valuta'
      DisplayWidth = 6
      FieldName = 'COD_VALUTA'
      ReadOnly = True
      Size = 10
    end
    object selTabellaRIMBORSO: TFloatField
      DisplayLabel = 'Richiesta'
      DisplayWidth = 8
      FieldName = 'RIMBORSO'
      ReadOnly = True
    end
    object selTabellaRIMBORSO_VARIATO: TFloatField
      DisplayLabel = 'A rimborso'
      DisplayWidth = 8
      FieldName = 'RIMBORSO_VARIATO'
    end
    object selTabellaSTATO: TStringField
      DisplayLabel = 'Conf.'
      FieldName = 'STATO'
      Size = 1
    end
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Cod.rimb.'
      FieldName = 'CODICE'
      ReadOnly = True
      Required = True
      Size = 5
    end
    object selTabellaPROTOCOLLO: TStringField
      DisplayLabel = 'Prot.'
      DisplayWidth = 6
      FieldName = 'PROTOCOLLO'
      ReadOnly = True
      Required = True
      Size = 10
    end
    object selTabellaNOTE: TStringField
      DisplayLabel = 'Note'
      DisplayWidth = 40
      FieldName = 'NOTE'
      Size = 2000
    end
    object selTabellaID: TFloatField
      FieldName = 'ID'
      Visible = False
    end
    object selTabellaCOMUNE_RESIDENZA: TStringField
      FieldName = 'COMUNE_RESIDENZA'
      Size = 60
    end
    object selTabellaCAP_RESIDENZA: TStringField
      FieldName = 'CAP_RESIDENZA'
      Size = 5
    end
    object selTabellaCOMUNE_DOMICILIO: TStringField
      FieldName = 'COMUNE_DOMICILIO'
      Size = 60
    end
    object selTabellaCAP_DOMICILIO: TStringField
      FieldName = 'CAP_DOMICILIO'
      Size = 5
    end
    object selTabellaPROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selTabellaC_SEDE_LAVORO: TStringField
      FieldKind = fkCalculated
      FieldName = 'C_SEDE_LAVORO'
      Visible = False
      Size = 100
      Calculated = True
    end
    object selTabellaC_COMUNE_RES: TStringField
      FieldKind = fkCalculated
      FieldName = 'C_COMUNE_RES'
      Visible = False
      Size = 100
      Calculated = True
    end
    object selTabellaC_COMUNE_DOM: TStringField
      FieldKind = fkCalculated
      FieldName = 'C_COMUNE_DOM'
      Size = 100
      Calculated = True
    end
    object selTabellaID_RIMBORSO: TIntegerField
      FieldName = 'ID_RIMBORSO'
    end
  end
end
