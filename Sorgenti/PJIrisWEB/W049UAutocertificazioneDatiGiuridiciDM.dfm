object W049FAutocertificazioneDatiGiuridiciDM: TW049FAutocertificazioneDatiGiuridiciDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 207
  Width = 439
  object selT055Copy: TOracleDataSet
    SQL.Strings = (
      'select T055.*, rowidtochar(ROWID) IDRIGA'
      '  from T055_PERIODI_ASPETTATIVA T055'
      ' where T055.PROGRESSIVO = :PROGRESSIVO'
      ' order by T055.DAL')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Left = 152
    Top = 24
    object DateTimeField1: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Periodo dal'
      DisplayWidth = 10
      FieldName = 'DAL'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object DateTimeField2: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Al'
      DisplayWidth = 10
      FieldName = 'AL'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object StringField3: TStringField
      FieldName = 'IDRIGA'
      Visible = False
    end
  end
  object selT040: TOracleDataSet
    SQL.Strings = (
      'select T040.DATA'
      '  from T040_GIUSTIFICATIVI T040'
      ' where T040.PROGRESSIVO = :PROGRESSIVO'
      ' and T040.DATA>= :INIZIO'
      ' and T040.DATA<= :FINE')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A0049004E0049005A004900
      4F000C00000000000000000000000A0000003A00460049004E0045000C000000
      0000000000000000}
    Left = 96
    Top = 80
    object selT040DATA: TDateField
      FieldName = 'DATA'
    end
  end
  object selT425T430Durata: TOracleDataSet
    SQL.Strings = (
      
        'select NVL(sum(gg + 1),0) gg_servizio, (:al - :dal  + 1) gg_aspe' +
        'ttativa, NVL(sum(al - dal + 1),0) gg_servizio_dal_al'
      'from ('
      ' select distinct '
      '    greatest(t425.INIZIO,:dal) dal,'
      '    least(t425.FINE,:al) al,'
      '    least(t425.FINE,:al) - greatest(INIZIO,:dal) gg'
      '  from t425_rapportilavoro_altrienti t425 '
      '  where t425.progressivo = :PROGRESSIVO '
      '  and greatest(t425.INIZIO,:dal) <= least(t425.FINE,:al) '
      
        '  and t425.validazione = decode(nvl(:INIZIO_GIUR,'#39'INIZIO'#39'),'#39'INIZ' +
        'IO'#39','#39'N'#39',t425.validazione)'
      '  '
      'union '
      ''
      '  select distinct'
      '    greatest(T430.INIZIO, :dal) dal,'
      '    least(NVL(T430.FINE,pck_const.DATA_INF), :al) al,'
      
        '    least(NVL(T430.FINE,pck_const.DATA_INF), :al) - greatest(T43' +
        '0.INIZIO, :dal) gg     '
      '  from T430_STORICO T430, T450_TIPORAPPORTO T450'
      '  where T430.PROGRESSIVO = :PROGRESSIVO'
      '  and T430.TIPORAPPORTO = T450.CODICE(+)'
      
        '  and greatest(T430.INIZIO,:dal) <= least(NVL(T430.FINE,pck_cons' +
        't.DATA_INF),:al) '
      ')'
      'order by 1')
    Optimize = False
    Variables.Data = {
      0400000004000000060000003A0041004C000C00000000000000000000000800
      00003A00440041004C000C0000000000000000000000180000003A0050005200
      4F0047005200450053005300490056004F000300000000000000000000001800
      00003A0049004E0049005A0049004F005F004700490055005200050000000000
      000000000000}
    Left = 272
    Top = 128
    object selT425T430DurataGG_SERVIZIO2: TFloatField
      FieldName = 'GG_SERVIZIO'
    end
    object selT425T430DurataGG_ASPETTATIVA: TFloatField
      FieldName = 'GG_ASPETTATIVA'
    end
  end
  object selPeriodo: TOracleQuery
    SQL.Strings = (
      'declare'
      '  -- Boolean parameters are translated from/to integers: '
      '  -- 0/1/null <--> false/true/null '
      '  result boolean;'
      'begin'
      '  -- Call the function'
      
        '  result := T425F_PERIODO_COPERTO(P_PROGRESSIVO => :P_PROGRESSIV' +
        'O,'
      '                                  P_DAL => :P_DAL,'
      '                                  P_AL => :P_AL,'
      '                                  P_INIZIOG => :P_INIZIOG,'
      '                                  P_FINEG => :P_FINEG);'
      '  -- Convert false/true/null to 0/1/null '
      '  :result := sys.diutil.bool_to_int(result);'
      'end;')
    Optimize = False
    Variables.Data = {
      04000000060000001C0000003A0050005F00500052004F004700520045005300
      5300490056004F000300000000000000000000000C0000003A0050005F004400
      41004C000C00000000000000000000000A0000003A0050005F0041004C000C00
      00000000000000000000140000003A0050005F0049004E0049005A0049004F00
      4700050000000000000000000000100000003A0050005F00460049004E004500
      47000500000000000000000000000E0000003A0052004500530055004C005400
      050000000000000000000000}
    Left = 320
    Top = 40
  end
  object selT040T055Durata: TOracleDataSet
    SQL.Strings = (
      '--Conta i giorni di aspettativa tra le date passate'
      'select NVL(sum(gg),0) gg_aspettativa'
      'from ('
      '  select distinct'
      
        '    least(NVL(T055.AL,pck_const.DATA_INF), :AL) - greatest(T055.' +
        'DAL, :DAL) + 1 gg     '
      '  from T055_PERIODI_ASPETTATIVA T055'
      '  where T055.PROGRESSIVO = :PROGRESSIVO'
      
        '  and greatest(T055.DAL,:DAL) <= least(NVL(T055.AL,pck_const.DAT' +
        'A_INF),:AL) '
      '  and T055.VALIDAZIONE = '#39'S'#39
      '  '
      'union'
      ''
      'select '
      ' count(*) gg'
      
        '  from T040_GIUSTIFICATIVI T040, T257_ACCORPCAUSALI T257, T255_T' +
        'IPOACCORPCAUSALI T255'
      ' where T040.PROGRESSIVO = :PROGRESSIVO'
      '   and T257.COD_CAUSALE = T040.CAUSALE'
      '   and T040.DATA between :DAL and :AL'
      '   and T040.Tipogiust = '#39'I'#39
      
        '   and T257.COD_TIPOACCORPCAUSALI = T255.COD_TIPOACCORPCAUSALI a' +
        'nd T255.TIPO = '#39'ASP'#39
      '   and not exists (select '#39'x'#39' from T055_PERIODI_ASPETTATIVA T055'
      
        '                    where T055.PROGRESSIVO = T040.PROGRESSIVO an' +
        'd T040.DATA between T055.DAL and T055.AL'
      '                      and T055.VALIDAZIONE = '#39'S'#39
      '                      and T257.COD_CAUSALE = T040.CAUSALE'
      
        '                      and T040.DATA between T257.DECORRENZA and ' +
        'T257.DECORRENZA_FINE'
      
        '                      and T257.COD_TIPOACCORPCAUSALI = T255.COD_' +
        'TIPOACCORPCAUSALI and T255.TIPO = '#39'ASP'#39')'
      '  '
      ')'
      'order by 1'
      ''
      
        '/*select NVL(sum(gg + 1),0) gg_aspettativa, (:al - :dal  + 1) gg' +
        '_servizio, NVL(sum(al - dal + 1),0) gg_servizio_dal_al'
      'from ('
      '  select distinct'
      '    greatest(T055.DAL, :dal) dal,'
      '    least(NVL(T055.AL,pck_const.DATA_INF), :al) al,'
      
        '    least(NVL(T055.AL,pck_const.DATA_INF), :al) - greatest(T055.' +
        'DAL, :dal) gg     '
      '  from T055_PERIODI_ASPETTATIVA T055'
      '  where T055.PROGRESSIVO = :PROGRESSIVO'
      
        '  and greatest(T055.DAL,:dal) <= least(NVL(T055.AL,pck_const.DAT' +
        'A_INF),:al) '
      '  and T055.VALIDAZIONE = '#39'S'#39
      ')'
      'order by 1*/')
    Optimize = False
    Variables.Data = {
      0400000003000000060000003A0041004C000C00000000000000000000000800
      00003A00440041004C000C0000000000000000000000180000003A0050005200
      4F0047005200450053005300490056004F00030000000000000000000000}
    Left = 80
    Top = 144
    object selT040T055DurataGG_ASPETTATIVA: TFloatField
      FieldName = 'GG_ASPETTATIVA'
    end
  end
  object selT425: TOracleDataSet
    SQL.Strings = (
      'select T425.*,ROWID'
      '  from T425_RAPPORTILAVORO_ALTRIENTI T425'
      ' where T425.PROGRESSIVO = :PROGRESSIVO'
      '   and T425.VALIDAZIONE <> '#39'P'#39
      ' order by T425.INIZIO')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000150000001E0000005400300035003000500052004F00470052004500
      53005300490056004F0001000000000016000000540030003500300043004100
      5500530041004C0045000100000000001A000000540030003500300054004900
      50004F00470049005500530054000100000000000E0000005400300035003000
      440041004C000100000000000C000000540030003500300041004C0001000000
      00001A00000054003000350030004E0055004D00450052004F004F0052004500
      01000000000010000000540030003500300041004F0052004500010000000000
      16000000540030003500300044004100540041004E0041005300010000000000
      2400000054003000350030004E0055004D00450052004F004F00520045005F00
      50005200450056000100000000001A000000540030003500300041004F005200
      45005F0050005200450056000100000000001A00000054003000350030004500
      4C00410042004F005200410054004F0001000000000010000000540038003500
      3000490054004500520001000000000018000000540038003500300043004F00
      44005F0049005400450052000100000000000C00000054003800350030004900
      4400010000000000100000005400380035003000440041005400410001000000
      000012000000540038003500300053005400410054004F000100000000001000
      000054003800350030004E004F00540045000100000000002400000054003800
      350030005400490050004F005F00520049004300480049004500530054004100
      0100000000002E00000054003800350030004100550054004F00520049005A00
      5A005F004100550054004F004D00410054004900430041000100000000001A00
      00005400380035003000490044005F005200450056004F004300410001000000
      00001E0000005400380035003000490044005F005200450056004F0043004100
      54004F00010000000000}
    OnCalcFields = selT425CalcFields
    Left = 24
    Top = 24
    object selT425PROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selT425VALIDAZIONE: TStringField
      DisplayLabel = 'Validato'
      FieldName = 'VALIDAZIONE'
      Size = 1
    end
    object selT425INIZIO: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Dal'
      DisplayWidth = 10
      FieldName = 'INIZIO'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selT425FINE: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Al'
      DisplayWidth = 10
      FieldName = 'FINE'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selT425ENTE: TStringField
      DisplayLabel = 'Ente'
      DisplayWidth = 30
      FieldName = 'ENTE'
      Size = 100
    end
    object selT425d_ENTE: TStringField
      DisplayLabel = 'Ente desc.'
      FieldKind = fkLookup
      FieldName = 'd_ENTE'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'ENTE'
      Size = 100
      Lookup = True
    end
    object selT425TIPORAPPORTO: TStringField
      DisplayLabel = 'Tipo rapporto'
      FieldName = 'TIPORAPPORTO'
      Visible = False
      Size = 5
    end
    object selT425d_TIPORAPPORTO: TStringField
      DisplayLabel = 'Tipo rapporto'
      DisplayWidth = 30
      FieldKind = fkLookup
      FieldName = 'd_TIPORAPPORTO'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'COD_DESC'
      KeyFields = 'TIPORAPPORTO'
      Size = 60
      Lookup = True
    end
    object selT425d_TIPO: TStringField
      DisplayLabel = 'Tipologia'
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'd_TIPO'
      Size = 50
      Calculated = True
    end
    object selT425PARTTIME: TStringField
      DisplayLabel = 'Part time'
      FieldName = 'PARTTIME'
      Visible = False
      Size = 5
    end
    object selT425d_PARTTIME: TStringField
      DisplayLabel = 'Part time'
      FieldKind = fkLookup
      FieldName = 'd_PARTTIME'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'PARTTIME'
      Size = 40
      Lookup = True
    end
    object selT425d_INDPRESPT: TFloatField
      DisplayLabel = '% Presenza'
      FieldKind = fkLookup
      FieldName = 'd_INDPRESPT'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'PIANTA'
      KeyFields = 'PARTTIME'
      Lookup = True
    end
    object selT425d_TIPOPT: TStringField
      DisplayLabel = 'Tipo part time'
      FieldKind = fkCalculated
      FieldName = 'd_TIPOPT'
      KeyFields = 'PARTTIME'
      Size = 15
      Calculated = True
    end
    object selT425QUALIFICA: TStringField
      DisplayLabel = 'Qualifica'
      FieldName = 'QUALIFICA'
      Size = 10
    end
    object selT425d_QUALIFICA: TStringField
      DisplayLabel = 'Qualifica desc.'
      FieldKind = fkLookup
      FieldName = 'd_QUALIFICA'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'QUALIFICA'
      Size = 100
      Lookup = True
    end
    object selT425DISCIPLINA: TStringField
      DisplayLabel = 'Disciplina'
      FieldName = 'DISCIPLINA'
      Size = 10
    end
    object selT425d_DISCIPLINA: TStringField
      DisplayLabel = 'Diciplina desc.'
      FieldKind = fkLookup
      FieldName = 'd_DISCIPLINA'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'DISCIPLINA'
      Size = 100
      Lookup = True
    end
    object selT425NOTE: TStringField
      DisplayLabel = 'Note'
      DisplayWidth = 30
      FieldName = 'NOTE'
      Size = 2000
    end
  end
end
