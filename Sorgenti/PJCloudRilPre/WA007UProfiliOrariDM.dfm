inherited WA007FProfiliOrariDM: TWA007FProfiliOrariDM
  Height = 294
  Width = 587
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T220.*,T220.ROWID FROM T220_PROFILIORARI T220'
      '  :ORDERBY')
    ReadBuffer = 200
    Filtered = True
    BeforePost = BeforePost
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    AfterDelete = AfterDelete
    OnFilterRecord = selTabellaFilterRecord
    object Q220CODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Size = 5
    end
    object Q220DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object Q220DECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Decorrenza Fine'
      FieldName = 'DECORRENZA_FINE'
    end
    object Q220DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 200
    end
    object selTabellaANTICIPOUSCITA: TDateTimeField
      DisplayLabel = 'Anticipo uscita'
      FieldName = 'ANTICIPOUSCITA'
      DisplayFormat = 'hh.mm'
      EditMask = '!00:00;1;_'
    end
    object selTabellaPRITIMSC: TStringField
      DisplayLabel = 'Confronto timbrature su punti nominali'
      FieldName = 'PRITIMSC'
      Size = 1
    end
    object selTabellaSCOSTENTRATA: TStringField
      DisplayLabel = 'Scostamento in entrata'
      FieldName = 'SCOSTENTRATA'
      Origin = 'T220_PROFILIORARI.SCOSTENTRATA'
      Size = 1
    end
    object selTabellaTIMBNONAPPOGGIATE: TStringField
      DisplayLabel = 'Timbrature esterne'
      FieldName = 'TIMBNONAPPOGGIATE'
      Size = 1
    end
    object selTabellaRITARDO_ENTRATA: TIntegerField
      DisplayLabel = 'Min. ritardo su entrata'
      FieldName = 'RITARDO_ENTRATA'
      MaxValue = 999
      MinValue = -1
    end
    object selTabellaIGNORA_TIMBNONINSEQ: TStringField
      DisplayLabel = 'Ignora timbrature non in sequenza'
      FieldName = 'IGNORA_TIMBNONINSEQ'
      Size = 1
    end
    object selTabellaPRIORITA_DOM_FEST: TStringField
      FieldName = 'PRIORITA_DOM_FEST'
      Visible = False
      Size = 1
    end
    object selTabellaPRIORITA_DOM_NONLAV: TStringField
      FieldName = 'PRIORITA_DOM_NONLAV'
      Visible = False
      Size = 1
    end
    object selTabellaPESO_SCOSTENTRATA_S: TIntegerField
      FieldName = 'PESO_SCOSTENTRATA_S'
      ReadOnly = True
      Visible = False
    end
    object selTabellaPESO_TIMBESTERNE: TIntegerField
      FieldName = 'PESO_TIMBESTERNE'
      ReadOnly = True
      Visible = False
    end
    object selTabellaPESO_TIMBNONAPPOGGIATE_S: TIntegerField
      FieldName = 'PESO_TIMBNONAPPOGGIATE_S'
      ReadOnly = True
      Visible = False
    end
    object selTabellaPESO_TIMBNONAPPOGGIATE_N: TIntegerField
      FieldName = 'PESO_TIMBNONAPPOGGIATE_N'
      ReadOnly = True
      Visible = False
    end
    object selTabellaPESO_PRITIMSC_S: TIntegerField
      FieldName = 'PESO_PRITIMSC_S'
      ReadOnly = True
      Visible = False
    end
    object selTabellaPESO_PRITIMSC_A: TIntegerField
      FieldName = 'PESO_PRITIMSC_A'
      ReadOnly = True
      Visible = False
    end
    object selTabellaPESO_MINANTSCELTA: TIntegerField
      FieldName = 'PESO_MINANTSCELTA'
      ReadOnly = True
      Visible = False
    end
    object selTabellaPESO_RITARDO_ENTRATA: TIntegerField
      FieldName = 'PESO_RITARDO_ENTRATA'
      ReadOnly = True
      Visible = False
    end
    object selTabellaIGNORA_STACCOPMT: TStringField
      FieldName = 'IGNORA_STACCOPMT'
      Visible = False
      Size = 1
    end
  end
  object dsrT221: TDataSource
    DataSet = selT221
    Left = 22
    Top = 180
  end
  object selT221: TOracleDataSet
    SQL.Strings = (
      'SELECT T221.*,T221.ROWID FROM T221_PROFILISETTIMANA T221'
      'WHERE CODICE = :Codice AND DECORRENZA = :Decorrenza  '
      ' :ORDERBY')
    Optimize = False
    Variables.Data = {
      04000000030000000E0000003A0043004F004400490043004500050000000000
      000000000000160000003A004400450043004F005200520045004E005A004100
      0C0000000000000000000000100000003A004F00520044004500520042005900
      010000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000C0000000C00000043004F0044004900430045000100000000001600
      0000500052004F0047005200450053005300490056004F000100000000000C00
      00004C0055004E004500440049000100000000000E0000004D00410052005400
      450044004900010000000000120000004D004500520043004F004C0045004400
      49000100000000000E000000470049004F005600450044004900010000000000
      0E000000560045004E0045005200440049000100000000000C00000053004100
      4200410054004F000100000000001000000044004F004D0045004E0049004300
      41000100000000000C0000004E004F004E004C00410056000100000000000E00
      00004600450053005400490056004F0001000000000014000000440045004300
      4F005200520045004E005A004100010000000000}
    AfterPost = selT221AfterPost
    AfterDelete = selT221AfterDelete
    OnNewRecord = selT221NewRecord
    Left = 24
    Top = 124
    object selT221Codice: TStringField
      FieldName = 'Codice'
      Required = True
      Visible = False
      Size = 5
    end
    object selT221D_Codice: TStringField
      DisplayLabel = 'Descrizione'
      FieldKind = fkLookup
      FieldName = 'D_Codice'
      LookupDataSet = selTabella
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'Codice'
      Visible = False
      Size = 40
      Lookup = True
    end
    object selT221Progressivo: TFloatField
      DisplayLabel = 'Num.'
      DisplayWidth = 5
      FieldName = 'Progressivo'
      ReadOnly = True
      Required = True
    end
    object selT221Lunedi: TStringField
      Alignment = taCenter
      DisplayLabel = 'Luned'#236
      DisplayWidth = 5
      FieldName = 'Lunedi'
      Size = 5
    end
    object selT221Martedi: TStringField
      Alignment = taCenter
      DisplayLabel = 'Marted'#236
      DisplayWidth = 5
      FieldName = 'Martedi'
      Size = 5
    end
    object selT221Mercoledi: TStringField
      Alignment = taCenter
      DisplayLabel = 'Mercoled'#236
      DisplayWidth = 5
      FieldName = 'Mercoledi'
      Size = 5
    end
    object selT221Giovedi: TStringField
      Alignment = taCenter
      DisplayLabel = 'Gioved'#236
      DisplayWidth = 5
      FieldName = 'Giovedi'
      Size = 5
    end
    object selT221Venerdi: TStringField
      Alignment = taCenter
      DisplayLabel = 'Venerd'#236
      DisplayWidth = 5
      FieldName = 'Venerdi'
      Size = 5
    end
    object selT221Sabato: TStringField
      Alignment = taCenter
      DisplayWidth = 5
      FieldName = 'Sabato'
      Size = 5
    end
    object selT221Domenica: TStringField
      Alignment = taCenter
      DisplayWidth = 5
      FieldName = 'Domenica'
      Size = 5
    end
    object selT221NonLav: TStringField
      Alignment = taCenter
      DisplayLabel = 'Non lavorativo'
      DisplayWidth = 5
      FieldName = 'NonLav'
      Size = 5
    end
    object selT221FESTIVO: TStringField
      Alignment = taCenter
      DisplayLabel = 'Festivo'
      DisplayWidth = 5
      FieldName = 'FESTIVO'
      Size = 5
    end
    object selT221DLunedi: TStringField
      DisplayWidth = 30
      FieldKind = fkLookup
      FieldName = 'DLunedi'
      LookupDataSet = selT020
      LookupKeyFields = 'Codice'
      LookupResultField = 'Descrizione'
      KeyFields = 'Lunedi'
      Visible = False
      Size = 40
      Lookup = True
    end
    object selT221DMartedi: TStringField
      DisplayWidth = 30
      FieldKind = fkLookup
      FieldName = 'DMartedi'
      LookupDataSet = selT020
      LookupKeyFields = 'Codice'
      LookupResultField = 'Descrizione'
      KeyFields = 'Martedi'
      Visible = False
      Size = 40
      Lookup = True
    end
    object selT221DMercoledi: TStringField
      DisplayWidth = 30
      FieldKind = fkLookup
      FieldName = 'DMercoledi'
      LookupDataSet = selT020
      LookupKeyFields = 'Codice'
      LookupResultField = 'Descrizione'
      KeyFields = 'Mercoledi'
      Visible = False
      Size = 40
      Lookup = True
    end
    object selT221DGiovedi: TStringField
      DisplayWidth = 30
      FieldKind = fkLookup
      FieldName = 'DGiovedi'
      LookupDataSet = selT020
      LookupKeyFields = 'Codice'
      LookupResultField = 'Descrizione'
      KeyFields = 'Giovedi'
      Visible = False
      Size = 40
      Lookup = True
    end
    object selT221DVenerdi: TStringField
      DisplayWidth = 30
      FieldKind = fkLookup
      FieldName = 'DVenerdi'
      LookupDataSet = selT020
      LookupKeyFields = 'Codice'
      LookupResultField = 'Descrizione'
      KeyFields = 'Venerdi'
      Visible = False
      Size = 40
      Lookup = True
    end
    object selT221DSabato: TStringField
      DisplayWidth = 30
      FieldKind = fkLookup
      FieldName = 'DSabato'
      LookupDataSet = selT020
      LookupKeyFields = 'Codice'
      LookupResultField = 'Descrizione'
      KeyFields = 'Sabato'
      Visible = False
      Size = 40
      Lookup = True
    end
    object selT221DDomenica: TStringField
      DisplayWidth = 30
      FieldKind = fkLookup
      FieldName = 'DDomenica'
      LookupDataSet = selT020
      LookupKeyFields = 'Codice'
      LookupResultField = 'Descrizione'
      KeyFields = 'Domenica'
      Visible = False
      Size = 40
      Lookup = True
    end
    object selT221DNonLav: TStringField
      DisplayWidth = 30
      FieldKind = fkLookup
      FieldName = 'DNonLav'
      LookupDataSet = selT020
      LookupKeyFields = 'Codice'
      LookupResultField = 'Descrizione'
      KeyFields = 'NonLav'
      Visible = False
      Size = 40
      Lookup = True
    end
    object selT221DFestivo: TStringField
      FieldKind = fkLookup
      FieldName = 'DFestivo'
      LookupDataSet = selT020
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'FESTIVO'
      Visible = False
      Size = 40
      Lookup = True
    end
    object selT221DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
      Required = True
      Visible = False
    end
  end
  object selT020: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT T020.CODICE, T020.DESCRIZIONE, T020.DECORRENZA'
      '  FROM T020_ORARI T020'
      ' WHERE T020.DECORRENZA = (SELECT MAX(DECORRENZA)'
      '                            FROM T020_ORARI'
      '                           WHERE CODICE=T020.CODICE)'
      ' ORDER BY T020.CODICE')
    ReadBuffer = 200
    Optimize = False
    Filtered = True
    OnFilterRecord = selTabellaFilterRecord
    Left = 80
    Top = 124
    object selT020CODICE: TStringField
      DisplayWidth = 7
      FieldName = 'CODICE'
      Origin = 'T020_ORARI.CODICE'
      Size = 5
    end
    object selT020DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Origin = 'T020_ORARI.DESCRIZIONE'
      Size = 40
    end
  end
  object dsrT020: TDataSource
    AutoEdit = False
    DataSet = selT020
    Left = 78
    Top = 180
  end
  object OperSQL: TOracleQuery
    Optimize = False
    Left = 280
    Top = 124
  end
  object insT221: TOracleQuery
    SQL.Strings = (
      
        'insert into t221_profilisettimana(CODICE,DECORRENZA,PROGRESSIVO,' +
        'LUNEDI,MARTEDI,MERCOLEDI,GIOVEDI,VENERDI,SABATO,DOMENICA,NONLAV,' +
        'FESTIVO)'
      
        'values(:CODICE,:DECORRENZA,:PROGRESSIVO,:LUNEDI,:MARTEDI,:MERCOL' +
        'EDI,:GIOVEDI,:VENERDI,:SABATO,:DOMENICA,:NONLAV,:FESTIVO)')
    Optimize = False
    Variables.Data = {
      040000000C0000000E0000003A0043004F004400490043004500050000000000
      000000000000160000003A004400450043004F005200520045004E005A004100
      0C0000000000000000000000180000003A00500052004F004700520045005300
      5300490056004F000300000000000000000000000E0000003A004C0055004E00
      450044004900050000000000000000000000100000003A004D00410052005400
      450044004900050000000000000000000000140000003A004D00450052004300
      4F004C00450044004900050000000000000000000000100000003A0047004900
      4F005600450044004900050000000000000000000000100000003A0056004500
      4E0045005200440049000500000000000000000000000E0000003A0053004100
      4200410054004F00050000000000000000000000120000003A0044004F004D00
      45004E004900430041000500000000000000000000000E0000003A004E004F00
      4E004C0041005600050000000000000000000000100000003A00460045005300
      5400490056004F00050000000000000000000000}
    Left = 280
    Top = 176
  end
  object selT220CopiaR: TOracleDataSet
    SQL.Strings = (
      
        'select t.*,rowid from T220_PROFILIORARI t where CODICE = :CODICE' +
        ' order by codice,decorrenza')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 344
    Top = 124
  end
  object selT220CopiaW: TOracleDataSet
    SQL.Strings = (
      
        'select t.*,rowid from T220_PROFILIORARI t where CODICE = :CODICE' +
        ' order by codice,decorrenza')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 424
    Top = 124
  end
  object selT221Copia: TOracleDataSet
    SQL.Strings = (
      
        'select t.*,rowid from T221_PROFILISETTIMANA t where CODICE = :CO' +
        'DICE order by codice,decorrenza')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 496
    Top = 124
  end
  object selT221MaxProgr: TOracleDataSet
    SQL.Strings = (
      
        'select max(progressivo) as max from T221_PROFILISETTIMANA where ' +
        'CODICE = :CODICE '
      'and DECORRENZA = :DECORRENZA')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A0043004F004400490043004500050000000000
      000000000000160000003A004400450043004F005200520045004E005A004100
      050000000000000000000000}
    Left = 496
    Top = 180
  end
end
