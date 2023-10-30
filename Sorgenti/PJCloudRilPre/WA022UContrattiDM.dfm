inherited WA022FContrattiDM: TWA022FContrattiDM
  Height = 265
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T200.*,T200.ROWID FROM T200_CONTRATTI T200 '
      ':ORDERBY')
    AfterEdit = selTabellaAfterEdit
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    OnNewRecord = OnNewRecord
    object selTabellaCodice: TStringField
      FieldName = 'Codice'
      Required = True
      Size = 5
    end
    object selTabellaDescrizione: TStringField
      FieldName = 'Descrizione'
      Size = 40
    end
    object selTabellaTipo: TStringField
      DisplayLabel = 'Tipologia'
      FieldName = 'Tipo'
      Size = 3
    end
    object selTabellaIndTurno: TStringField
      DisplayLabel = 'Ind.turno'
      FieldName = 'IndTurno'
      Size = 1
    end
    object selTabellaReperibilita: TStringField
      FieldName = 'Reperibilita'
      EditMask = '!990:00;1;_'
      Size = 6
    end
    object selTabellaMaxStraord: TStringField
      DisplayLabel = 'Straordinario annuo'
      FieldName = 'MaxStraord'
      Size = 7
    end
    object selTabellaMAXRESIDUABILE: TStringField
      DisplayLabel = 'Residuabile annuo'
      FieldName = 'MAXRESIDUABILE'
      Size = 7
    end
    object selTabellaIndNotteDa: TDateTimeField
      FieldName = 'IndNotteDa'
      Visible = False
      OnSetText = selTabellaIndNotteDaSetText
      DisplayFormat = 'hh:mm'
    end
    object selTabellaIndNotteA: TDateTimeField
      FieldName = 'IndNotteA'
      Visible = False
      OnSetText = selTabellaIndNotteDaSetText
      DisplayFormat = 'hh:mm'
    end
    object selTabellaTOLINDNOT: TFloatField
      FieldName = 'TOLINDNOT'
      Visible = False
      MaxValue = 99.000000000000000000
      Precision = 2
    end
    object selTabellaARRINDNOT: TFloatField
      FieldName = 'ARRINDNOT'
      Visible = False
      MaxValue = 99.000000000000000000
      Precision = 2
    end
    object selTabellaDATADECORRENZA: TDateTimeField
      FieldName = 'DATADECORRENZA'
      Visible = False
      DisplayFormat = 'dd/mm/yyyy'
    end
    object selTabellaARR_INDTURNO_PAL: TStringField
      FieldName = 'ARR_INDTURNO_PAL'
      Visible = False
      Size = 5
    end
    object selTabellaORE_LAVFASCE_CONASS: TStringField
      FieldName = 'ORE_LAVFASCE_CONASS'
      Visible = False
      Size = 1
    end
  end
  object T201: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T201.*,T201.ROWID FROM T201_MAGGIORAZIONI T201 WHERE CODI' +
        'CE = :CODICE'
      'ORDER BY GIORNO')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    OracleDictionary.DefaultValues = True
    CachedUpdates = True
    BeforeInsert = T201BeforeInsert
    BeforePost = T201BeforePost
    AfterPost = T201AfterPost
    BeforeDelete = T201BeforeDelete
    OnCalcFields = T201CalcFields
    Left = 36
    Top = 120
    object T201Codice: TStringField
      FieldName = 'Codice'
      Visible = False
      Size = 5
    end
    object T201Giorno: TStringField
      FieldName = 'Giorno'
      Visible = False
      Size = 1
    end
    object T201D_Giorno: TStringField
      DisplayLabel = 'Giorno'
      FieldKind = fkCalculated
      FieldName = 'D_Giorno'
      Size = 9
      Calculated = True
    end
    object T201FasciaDa1: TDateTimeField
      DisplayLabel = 'Dalle'
      DisplayWidth = 5
      FieldName = 'FasciaDa1'
      DisplayFormat = 'hh:mm'
      EditMask = '!90:00;1;_'
    end
    object T201FasciaA1: TDateTimeField
      DisplayLabel = 'Alle'
      DisplayWidth = 5
      FieldName = 'FasciaA1'
      DisplayFormat = 'hh:mm'
      EditMask = '!90:00;1;_'
    end
    object T201Maggior1: TStringField
      DisplayLabel = 'Fascia 1'
      FieldName = 'Maggior1'
      Size = 5
    end
    object T201FasciaDa2: TDateTimeField
      DisplayLabel = 'Dalle'
      DisplayWidth = 5
      FieldName = 'FasciaDa2'
      DisplayFormat = 'hh:mm'
      EditMask = '!90:00;1;_'
    end
    object T201FasciaA2: TDateTimeField
      DisplayLabel = 'Alle'
      DisplayWidth = 5
      FieldName = 'FasciaA2'
      DisplayFormat = 'hh:mm'
      EditMask = '!90:00;1;_'
    end
    object T201Maggior2: TStringField
      DisplayLabel = 'Fascia 2'
      FieldName = 'Maggior2'
      Size = 5
    end
    object T201FasciaDa3: TDateTimeField
      DisplayLabel = 'Dalle'
      DisplayWidth = 5
      FieldName = 'FasciaDa3'
      DisplayFormat = 'hh:mm'
      EditMask = '!90:00;1;_'
    end
    object T201FasciaA3: TDateTimeField
      DisplayLabel = 'Alle'
      DisplayWidth = 5
      FieldName = 'FasciaA3'
      DisplayFormat = 'hh:mm'
      EditMask = '!90:00;1;_'
    end
    object T201Maggior3: TStringField
      DisplayLabel = 'Fascia 3'
      FieldName = 'Maggior3'
      Size = 5
    end
    object T201FasciaDa4: TDateTimeField
      DisplayLabel = 'Dalle'
      DisplayWidth = 5
      FieldName = 'FasciaDa4'
      DisplayFormat = 'hh:mm'
      EditMask = '!90:00;1;_'
    end
    object T201FasciaA4: TDateTimeField
      DisplayLabel = 'Alle'
      DisplayWidth = 5
      FieldName = 'FasciaA4'
      DisplayFormat = 'hh:mm'
      EditMask = '!90:00;1;_'
    end
    object T201Maggior4: TStringField
      DisplayLabel = 'Fascia 4'
      FieldName = 'Maggior4'
      Size = 5
    end
  end
  object D201: TDataSource
    DataSet = T201
    Left = 64
    Top = 120
  end
  object T210: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T210.*, T210.ROWID FROM T210_MAGGIORAZIONI T210 ORDER BY ' +
        'CODICE')
    ReadBuffer = 10
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000070000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000001A00
      00004D0041004700470049004F00520041005A0049004F004E00450001000000
      00001000000050004F00520045005F004C00410056000100000000001A000000
      50005300540052005F004E0045004C005F004D00450053004500010000000000
      10000000500049004E0044005F00540055005200010000000000120000005000
      4F00520045005F0043004F004D005000010000000000}
    BeforePost = T210BeforePost
    AfterPost = T210AfterPost
    BeforeDelete = T210BeforeDelete
    AfterDelete = T210AfterDelete
    Left = 100
    Top = 120
    object T210Codice: TStringField
      FieldName = 'Codice'
      Size = 5
    end
    object T210Descrizione: TStringField
      DisplayWidth = 30
      FieldName = 'Descrizione'
      Size = 40
    end
    object T210Maggiorazione: TFloatField
      DisplayLabel = 'Magg.(%)'
      DisplayWidth = 6
      FieldName = 'Maggiorazione'
      EditFormat = '###'
      MaxValue = 100.000000000000000000
    end
    object T210PORE_LAV: TStringField
      DisplayLabel = 'Ore lavorate'
      FieldName = 'PORE_LAV'
      Size = 6
    end
    object T210PSTR_NEL_MESE: TStringField
      DisplayLabel = 'Ore liquidate'
      FieldName = 'PSTR_NEL_MESE'
      Size = 6
    end
    object T210PIND_TUR: TStringField
      DisplayLabel = 'Ore ind.turno'
      FieldName = 'PIND_TUR'
      Size = 6
    end
    object T210PORE_COMP: TStringField
      DisplayLabel = 'Banca ore'
      FieldName = 'PORE_COMP'
      Size = 6
    end
  end
  object D210: TDataSource
    DataSet = T210
    Left = 128
    Top = 120
  end
  object Q201ModificaContr: TOracleQuery
    SQL.Strings = (
      'UPDATE T201_MAGGIORAZIONI SET CODICE = :CODICE'
      'WHERE CODICE = :CODICE_OLD')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A0043004F004400490043004500050000000000
      000000000000160000003A0043004F0044004900430045005F004F004C004400
      050000000000000000000000}
    Left = 192
    Top = 120
  end
end
