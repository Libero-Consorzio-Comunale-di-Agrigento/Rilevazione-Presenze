inherited WA012FCalendariDM: TWA012FCalendariDM
  Height = 265
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT '
      '  T010.ROWID,T010.*,'
      
        '  decode(LUNEDI,'#39'S'#39',1,0) + decode(MARTEDI,'#39'S'#39',1,0) + decode(MERC' +
        'OLEDI,'#39'S'#39',1,0) + decode(GIOVEDI,'#39'S'#39',1,0) + '
      
        '  decode(VENERDI,'#39'S'#39',1,0) + decode(SABATO,'#39'S'#39',1,0) + decode(DOME' +
        'NICA,'#39'S'#39',1,0) GGLAV'
      'FROM T010_CALENDIMPOSTAZ T010 '
      ':ORDERBY')
    Filtered = True
    AfterPost = AfterPost
    AfterCancel = AfterCancel
    BeforeDelete = BeforeDelete
    OnFilterRecord = selTabellaFilterRecord
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Size = 5
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selTabellaGGLAV: TFloatField
      DisplayLabel = 'gg lav.'
      DisplayWidth = 5
      FieldName = 'GGLAV'
    end
    object selTabellaLUNEDI: TStringField
      DisplayLabel = 'Luned'#236
      FieldName = 'LUNEDI'
      Size = 1
    end
    object selTabellaMARTEDI: TStringField
      DisplayLabel = 'Marted'#236
      FieldName = 'MARTEDI'
      Size = 1
    end
    object selTabellaMERCOLEDI: TStringField
      DisplayLabel = 'Mercoled'#236
      FieldName = 'MERCOLEDI'
      Size = 1
    end
    object selTabellaGIOVEDI: TStringField
      DisplayLabel = 'Gioved'#236
      FieldName = 'GIOVEDI'
      Size = 1
    end
    object selTabellaVENERDI: TStringField
      DisplayLabel = 'Venerd'#236
      FieldName = 'VENERDI'
      Size = 1
    end
    object selTabellaSABATO: TStringField
      DisplayLabel = 'Sabato'
      FieldName = 'SABATO'
      Size = 1
    end
    object selTabellaDOMENICA: TStringField
      DisplayLabel = 'Domenica'
      FieldName = 'DOMENICA'
      Size = 1
    end
    object selTabellaNUMGG_LAV: TIntegerField
      DisplayLabel = 'Num.gg.lav.'
      DisplayWidth = 8
      FieldName = 'NUMGG_LAV'
    end
    object Q010IGNORAFESTIVITA: TStringField
      DisplayLabel = 'Ignora fest.naz.'
      FieldName = 'IGNORAFEST_AUTO'
      Size = 1
    end
  end
  object Q011: TOracleDataSet
    SQL.Strings = (
      'SELECT T011.*,T011.ROWID FROM T011_CALENDARI T011'
      '  WHERE CODICE = :Codice'
      '  AND DATA BETWEEN :DAL AND :AL'
      '  ORDER BY DATA')
    ReadBuffer = 1000
    Optimize = False
    Variables.Data = {
      04000000030000000E0000003A0043004F004400490043004500050000000000
      000000000000080000003A00440041004C000C00000000000000000000000600
      00003A0041004C000C0000000000000000000000}
    Left = 32
    Top = 116
  end
  object selT013: TOracleDataSet
    SQL.Strings = (
      'SELECT T013.*,T013.ROWID FROM T013_FESTIVITA_AGGIUNTIVE T013'
      '  WHERE CODICE = :Codice'
      '  ORDER BY ANNO,MESE,GIORNO')
    ReadBuffer = 1000
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    AutoCalcFields = False
    CachedUpdates = True
    BeforePost = selT013BeforePost
    Left = 88
    Top = 116
    object selT013CODICE: TStringField
      FieldName = 'CODICE'
      Visible = False
      Size = 5
    end
    object selT013ANNO: TIntegerField
      DisplayLabel = 'Anno'
      DisplayWidth = 4
      FieldName = 'ANNO'
      MaxValue = 3999
    end
    object selT013MESE: TIntegerField
      DisplayLabel = 'Mese'
      DisplayWidth = 2
      FieldName = 'MESE'
      MaxValue = 12
      MinValue = 1
    end
    object selT013GIORNO: TIntegerField
      DisplayLabel = 'Giorno'
      DisplayWidth = 2
      FieldName = 'GIORNO'
      MaxValue = 31
      MinValue = 1
    end
  end
  object dsrT013: TDataSource
    DataSet = selT013
    Left = 88
    Top = 168
  end
  object CancQ011: TOracleQuery
    SQL.Strings = (
      'begin'
      '  DELETE FROM T011_CALENDARI WHERE CODICE = :Codice;'
      '  DELETE FROM T013_FESTIVITA_AGGIUNTIVE where CODICE = :CODICE;'
      'end;')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 144
    Top = 116
  end
  object UpdQ011: TOracleQuery
    SQL.Strings = (
      'UPDATE T011_CALENDARI SET'
      'CODICE = :NEWCODICE WHERE CODICE = :OLDCODICE')
    Optimize = False
    Variables.Data = {
      0400000002000000140000003A004E004500570043004F004400490043004500
      050000000000000000000000140000003A004F004C00440043004F0044004900
      43004500050000000000000000000000}
    Left = 196
    Top = 116
  end
  object GeneraCal: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      '  GENERACALENDARIO.GENERACAL(:COD, :DAL, :AL, '#39'S'#39');'
      'END;')
    Optimize = False
    Variables.Data = {
      0400000003000000080000003A0043004F004400050000000000000000000000
      080000003A00440041004C000C0000000000000000000000060000003A004100
      4C000C0000000000000000000000}
    Left = 260
    Top = 116
  end
end
