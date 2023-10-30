inherited WM019FCertificazioniDM: TWM019FCertificazioniDM
  OnCreate = DataModuleCreate
  Height = 204
  Width = 443
  object selSG230: TOracleDataSet
    SQL.Strings = (
      '-- v. C018UIterAutDM')
    Optimize = False
    Variables.Data = {
      04000000060000001A0000003A005100560049005300540041004F0052004100
      43004C004500010000000000000000000000160000003A004400410054004100
      4C00410056004F0052004F000C00000000000000000000001E0000003A004600
      49004C00540052004F005F0050004500520049004F0044004F00010000000000
      000000000000100000003A0041005A00490045004E0044004100050000000000
      000000000000180000003A00460049004C00540052004F005F0041004E004100
      47000100000000000000000000002E0000003A00460049004C00540052004F00
      5F00560049005300550041004C0049005A005A0041005A0049004F004E004500
      010000000000000000000000}
    UpdatingTable = 'SG230_ITER_CERTIFICAZIONI'
    CommitOnPost = False
    Filtered = True
    OnCalcFields = selSG230CalcFields
    OnFilterRecord = selSG230FilterRecord
    Left = 41
    Top = 17
    object selSG230ID: TFloatField
      FieldName = 'ID'
    end
    object selSG230ID_REVOCA: TFloatField
      FieldName = 'ID_REVOCA'
    end
    object selSG230ID_REVOCATO: TFloatField
      FieldName = 'ID_REVOCATO'
    end
    object selSG230PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
    end
    object selSG230NOMINATIVO: TStringField
      FieldName = 'NOMINATIVO'
      Size = 65
    end
    object selSG230MATRICOLA: TStringField
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selSG230SESSO: TStringField
      FieldName = 'SESSO'
      Size = 1
    end
    object selSG230COD_ITER: TStringField
      FieldName = 'COD_ITER'
    end
    object selSG230TIPO_RICHIESTA: TStringField
      FieldName = 'TIPO_RICHIESTA'
      Size = 1
    end
    object selSG230D_TIPO_RICHIESTA: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_TIPO_RICHIESTA'
      Calculated = True
    end
    object selSG230D_RESPONSABILE: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_RESPONSABILE'
      Size = 84
      Calculated = True
    end
    object selSG230D_AUTORIZZAZIONE: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_AUTORIZZAZIONE'
      Size = 2
      Calculated = True
    end
    object selSG230D_STATO: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_STATO'
      Size = 2
      Calculated = True
    end
    object selSG230AUTORIZZ_AUTOMATICA: TStringField
      FieldName = 'AUTORIZZ_AUTOMATICA'
      Size = 1
    end
    object selSG230REVOCABILE: TStringField
      FieldName = 'REVOCABILE'
      Size = 10
    end
    object selSG230DATA_RICHIESTA: TDateTimeField
      DisplayWidth = 50
      FieldName = 'DATA_RICHIESTA'
      DisplayFormat = 'dd/mm/yyyy hhhh.nn'
    end
    object selSG230LIVELLO_AUTORIZZAZIONE: TFloatField
      FieldName = 'LIVELLO_AUTORIZZAZIONE'
    end
    object selSG230DATA_AUTORIZZAZIONE: TDateTimeField
      FieldName = 'DATA_AUTORIZZAZIONE'
    end
    object selSG230AUTORIZZAZIONE: TStringField
      FieldName = 'AUTORIZZAZIONE'
      Size = 1
    end
    object selSG230NOMINATIVO_RESP: TStringField
      FieldName = 'NOMINATIVO_RESP'
      Size = 65
    end
    object selSG230AUTORIZZ_AUTOM_PREV: TStringField
      FieldName = 'AUTORIZZ_AUTOM_PREV'
      Size = 1
    end
    object selSG230AUTORIZZ_PREV: TStringField
      FieldName = 'AUTORIZZ_PREV'
      Size = 1
    end
    object selSG230RESPONSABILE_PREV: TStringField
      FieldName = 'RESPONSABILE_PREV'
      Size = 30
    end
    object selSG230AUTORIZZ_UTILE: TStringField
      FieldName = 'AUTORIZZ_UTILE'
      Size = 1
    end
    object selSG230AUTORIZZ_REVOCA: TStringField
      FieldName = 'AUTORIZZ_REVOCA'
      Size = 1
    end
    object selSG230MSGAUT_SI: TStringField
      FieldName = 'MSGAUT_SI'
      Size = 2000
    end
    object selSG230MSGAUT_NO: TStringField
      FieldName = 'MSGAUT_NO'
      Size = 2000
    end
    object selSG230COD_MODELLO: TStringField
      FieldName = 'COD_MODELLO'
      Size = 10
    end
    object selSG230DESC_MODELLO: TStringField
      FieldName = 'DESC_MODELLO'
      Size = 80
    end
    object selSG230DAL: TDateTimeField
      FieldName = 'DAL'
    end
    object selSG230AL: TDateTimeField
      FieldName = 'AL'
    end
    object selSG230DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 80
    end
    object selSG230ID_CERTIFICAZIONE: TFloatField
      FieldName = 'ID_CERTIFICAZIONE'
    end
  end
  object selSG235: TOracleDataSet
    SQL.Strings = (
      'select'
      '  SG235.ID,'
      '  SG235.CODICE,'
      '  SG235.DESCRIZIONE,'
      '  SG235.AUTOCERTIFICAZIONE,'
      '  SG235.PERIODO,'
      '  SG235.UM,'
      '  SG235.QUANTITA,'
      '  SG235.PERIODO_MODIFICABILE,'
      '  SG235.ORDINE'
      'from'
      '  SG235_MODELLI_CERTIFICAZIONI SG235'
      'where '
      '  sysdate between INIZIO_VALIDITA and FINE_VALIDITA and '
      
        '  V430F_CHEKANAGRAFE(:PROGRESSIVO,trunc(sysdate),SELEZIONE_ANAGR' +
        'AFE) = '#39'S'#39
      'order by'
      '  NVL(SG235.ORDINE, 9999), SG235.CODICE, SG235.DESCRIZIONE')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00040000000000000000000000}
    CommitOnPost = False
    Left = 112
    Top = 17
  end
  object selSG237CampiInput: TOracleQuery
    SQL.Strings = (
      
        '--estrae il numero di dati che ammettono degli input per il mode' +
        'llo'
      '--i campi check obbligatori sono esclusi da questo conteggio'
      'select'
      '  COUNT(*)'
      'from'
      '  SG237_DATI_CERTIFICAZIONI T '
      'WHERE'
      
        '  --T.ID = (select b.ID from sg235_modelli_certificazioni b wher' +
        'e b.codice='#39'CERT01'#39') and'
      '  T.ID = :ID AND'
      ' (T.FORMATO in ('#39'S'#39','#39'N'#39','#39'D'#39') OR'
      ' (T.FORMATO = '#39'C'#39' AND T.Obbligatorio='#39'N'#39'))')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400010000000000000000000000}
    Left = 39
    Top = 78
  end
  object selSG235c: TOracleDataSet
    SQL.Strings = (
      'select'
      '  SG235.*'
      'from'
      '  SG235_MODELLI_CERTIFICAZIONI SG235')
    Optimize = False
    CommitOnPost = False
    Left = 183
    Top = 17
  end
  object selSG235b: TOracleDataSet
    SQL.Strings = (
      'select'
      '  SG235.ID,'
      '  SG235.CODICE,'
      '  SG235.DESCRIZIONE,'
      '  SG235.AUTOCERTIFICAZIONE,'
      '  SG235.PERIODO,'
      '  SG235.UM,'
      '  SG235.QUANTITA,'
      '  SG235.PERIODO_MODIFICABILE'
      'from'
      '  SG235_MODELLI_CERTIFICAZIONI SG235'
      'where '
      '  SG235.ID = :ID')
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    CommitOnPost = False
    Left = 255
    Top = 17
  end
  object selQueryPeriodo: TOracleQuery
    SQL.Strings = (
      'select :PERIODO'
      'from   dual')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0050004500520049004F0044004F0001000000
      0000000000000000}
    Left = 144
    Top = 78
  end
  object selQueryVSG230: TOracleQuery
    SQL.Strings = (
      'select '
      '  t.COD_MODELLO || '#39' '#39' || t.DESCRIZIONE MODELLO,'
      '  TRUNC(t.DATA_RICHIESTA) DATA_RICHIESTA,'
      '  T.DAL DAL,'
      '  T.AL AL'
      '  --NVL(T.DAL,TRUNC(t.DATA_RICHIESTA)) DAL,'
      '  --NVL(T.AL,TRUNC(t.DATA_RICHIESTA)) AL'
      'from vsg230_iter_certificazioni t'
      'where'
      
        '  --greatest(NVL(T.DAL,TRUNC(t.DATA_RICHIESTA)), :DATA_I) <= lea' +
        'st(NVL(T.AL,TRUNC(t.DATA_RICHIESTA)), :DATA_F)'
      
        '  ((greatest(NVL(T.DAL,TRUNC(t.DATA_RICHIESTA)), :DATA_I) <= lea' +
        'st(NVL(T.AL,TRUNC(t.DATA_RICHIESTA)), :DATA_F))'
      
        '  or (NVL(T.DAL,TRUNC(t.DATA_RICHIESTA)) > :DATA_IMin and NVL(T.' +
        'DAL,TRUNC(t.DATA_RICHIESTA)) < :DATA_IMax ))'
      '  and T.ID_CERTIFICAZIONE = :ID'
      '  and T.PROGRESSIVO = :PROGR'
      '  :ROWID_T')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000070000000E0000003A0044004100540041005F004900010000000000
      0000000000000E0000003A0044004100540041005F0046000100000000000000
      00000000060000003A0049004400030000000000000000000000100000003A00
      52004F005700490044005F005400010000000000000000000000140000003A00
      44004100540041005F0049004D0049004E000100000000000000000000001400
      00003A0044004100540041005F0049004D004100580001000000000000000000
      00000C0000003A00500052004F0047005200040000000000000000000000}
    Left = 231
    Top = 78
  end
end
