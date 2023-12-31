inherited A124FPermessiSindacaliMW: TA124FPermessiSindacaliMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 420
  Width = 586
  object Q040: TOracleDataSet
    SQL.Strings = (
      
        'SELECT /*+ INDEX(T040_GIUSTIFICATIVI T040_PK)*/ T040.*,T040.ROWI' +
        'D'
      'FROM T040_GIUSTIFICATIVI T040'
      'WHERE PROGRESSIVO = :Progressivo'
      'AND DATA BETWEEN :DataInizio and :DataFine'
      'ORDER BY DATA, CAUSALE, PROGRCAUSALE')
    ReadBuffer = 31
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000160000003A0044004100540041004900
      4E0049005A0049004F000C0000000000000000000000120000003A0044004100
      54004100460049004E0045000C0000000000000000000000}
    Left = 392
    Top = 16
  end
  object Q100: TOracleDataSet
    SQL.Strings = (
      'SELECT T100.*,T100.ROWID'
      'FROM T100_TIMBRATURE T100'
      'WHERE PROGRESSIVO = :Progressivo '
      'AND DATA BETWEEN :DataInizio AND :DataFine'
      'AND FLAG IN ('#39'O'#39','#39'I'#39')'
      'ORDER BY DATA,ORA,VERSO,FLAG')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000160000003A0044004100540041004900
      4E0049005A0049004F000C0000000000000000000000120000003A0044004100
      54004100460049004E0045000C0000000000000000000000}
    Left = 424
    Top = 16
    object Q100PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
    end
    object Q100DATA: TDateTimeField
      FieldName = 'DATA'
    end
    object Q100ORA: TDateTimeField
      FieldName = 'ORA'
      DisplayFormat = 't'
      EditMask = '!90:00;1;_'
    end
    object Q100VERSO: TStringField
      FieldName = 'VERSO'
      Size = 1
    end
    object Q100FLAG: TStringField
      FieldName = 'FLAG'
      Size = 1
    end
    object Q100RILEVATORE: TStringField
      FieldName = 'RILEVATORE'
      Size = 2
    end
    object Q100CAUSALE: TStringField
      FieldName = 'CAUSALE'
      Size = 5
    end
  end
  object Q275: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE'
      'FROM T275_CAUPRESENZE'
      'ORDER BY CODICE')
    Optimize = False
    Left = 456
    Top = 16
  end
  object Q305: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE'
      'FROM T305_CAUGIUSTIF'
      'ORDER BY CODICE')
    Optimize = False
    Left = 488
    Top = 16
  end
  object selPermessi: TOracleDataSet
    SQL.Strings = (
      'select TIPO_PERMESSO, DALLE, ALLE, prog_permesso'
      '  from t248_permessisindacali'
      ' where progressivo = :PROG'
      '   and data >= :DATA_DA'
      '   and data_da <= :DATA'
      'order by prog_permesso')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A00500052004F00470003000000000000000000
      00000A0000003A0044004100540041000C000000000000000000000010000000
      3A0044004100540041005F00440041000C0000000000000000000000}
    Left = 32
    Top = 176
  end
  object selT240Filtro: TOracleDataSet
    SQL.Strings = (
      
        'SELECT :SINDACATO SINDACATO FROM T030_ANAGRAFICO T030, T430_STOR' +
        'ICO T430, P430_ANAGRAFICO P430'
      'WHERE'
      '  T030.PROGRESSIVO = T430.PROGRESSIVO AND'
      '  :PROGRESSIVO = T030.PROGRESSIVO AND'
      '  :DATA BETWEEN T430.DATADECORRENZA AND T430.DATAFINE ')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A0044004100540041000C000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      00000000000000000000}
    Left = 120
    Top = 176
  end
  object selV010: TOracleDataSet
    SQL.Strings = (
      'select V010.data'
      '  from V010_calendari V010'
      ' where V010.lavorativo = '#39'S'#39
      '   and V010.data > :DATA'
      '   and V010.progressivo = :PROGRESSIVO'
      'order by data')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 328
    Top = 16
  end
  object cdsT248: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'PROGRESSIVO'
        DataType = ftInteger
      end
      item
        Name = 'DATA_DA'
        DataType = ftDate
      end
      item
        Name = 'DATA'
        DataType = ftDate
      end
      item
        Name = 'NUMERO_PROT'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'DATA_PROT'
        DataType = ftDate
      end
      item
        Name = 'DALLE'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'ALLE'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'ORE'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'ABBATTE_COMPETENZE'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'RETRIBUITO'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'COD_SINDACATO'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'COD_ORGANISMO'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'STATO'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'PROT_MODIFICA'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'DATA_MODIFICA'
        DataType = ftDate
      end
      item
        Name = 'RSU'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'RAGGRUPPAMENTO'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'SINDACATI_RAGGRUPPATI'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'TIPO_PERMESSO'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'PROG_PERMESSO'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    AfterScroll = cdsT248AfterScroll
    OnNewRecord = cdsT248NewRecord
    Left = 328
    Top = 232
    object cdsT248PROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object cdsT248DATA: TDateField
      DisplayLabel = 'Data'
      FieldName = 'DATA'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!99/99/0000;1;_'
    end
    object cdsT248NUMERO_PROT: TStringField
      DisplayLabel = 'N.Prot.'
      DisplayWidth = 5
      FieldName = 'NUMERO_PROT'
      Size = 10
    end
    object cdsT248DATA_PROT: TDateField
      DisplayLabel = 'Data Prot.'
      FieldName = 'DATA_PROT'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!99/99/0000;1;_'
    end
    object cdsT248DALLE: TStringField
      DisplayLabel = 'Dalle'
      FieldName = 'DALLE'
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object cdsT248ALLE: TStringField
      DisplayLabel = 'Alle'
      FieldName = 'ALLE'
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object cdsT248ORE: TStringField
      DisplayLabel = 'Ore'
      FieldName = 'ORE'
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object cdsT248ABBATTE_COMPETENZE: TStringField
      DisplayLabel = 'Abbat.'
      FieldName = 'ABBATTE_COMPETENZE'
      Size = 1
    end
    object cdsT248COD_SINDACATO: TStringField
      DisplayLabel = 'Sindacato'
      FieldName = 'COD_SINDACATO'
      Size = 10
    end
    object cdsT248COD_ORGANISMO: TStringField
      DisplayLabel = 'Organismo'
      FieldName = 'COD_ORGANISMO'
      Size = 5
    end
    object cdsT248STATO: TStringField
      DisplayLabel = 'Stato'
      FieldName = 'STATO'
      Size = 1
    end
    object cdsT248PROT_MODIFICA: TStringField
      DisplayLabel = 'Prot.Mod.'
      DisplayWidth = 5
      FieldName = 'PROT_MODIFICA'
      Size = 10
    end
    object cdsT248DATA_MODIFICA: TDateField
      DisplayLabel = 'Data Mod.'
      FieldName = 'DATA_MODIFICA'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!99/99/0000;1;_'
    end
    object cdsT248RSU: TStringField
      FieldName = 'RSU'
      Visible = False
      Size = 1
    end
    object cdsT248RAGGRUPPAMENTO: TStringField
      FieldName = 'RAGGRUPPAMENTO'
      Visible = False
      Size = 1
    end
    object cdsT248SINDACATI_RAGGRUPPATI: TStringField
      FieldName = 'SINDACATI_RAGGRUPPATI'
      Visible = False
      Size = 200
    end
    object cdsT248TIPO_PERMESSO: TStringField
      FieldName = 'TIPO_PERMESSO'
      Size = 1
    end
    object cdsT248PROG_PERMESSO: TIntegerField
      FieldName = 'PROG_PERMESSO'
      Visible = False
    end
  end
  object dsrT240C: TDataSource
    AutoEdit = False
    DataSet = selT240C
    Left = 384
    Top = 280
  end
  object selT240C: TOracleDataSet
    SQL.Strings = (
      
        'select distinct T240.codice, T240.descrizione, T240.rsu, t240.ra' +
        'ggruppamento, T240.sindacati_raggruppati, t240.filtro'
      
        'from t240_organizzazionisindacali T240, t242_competenzesindacati' +
        ' T242'
      'where '
      
        '  T240.decorrenza = (select max(decorrenza) from t240_organizzaz' +
        'ionisindacali where codice = T240.CODICE and decorrenza < :DATA)' +
        ' '
      'and '
      '  (:COMPETENZE = '#39'N'#39' OR'
      '   :COMPETENZE = '#39'S'#39' and'
      '   T242.Codice = T240.Codice and'
      
        '   :data between t242.decorrenza and nvl(t242.scadenza,to_date('#39 +
        '31123999'#39','#39'ddmmyyyy'#39')) )'
      'order by codice,descrizione')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A0044004100540041000C000000000000000000
      0000160000003A0043004F004D0050004500540045004E005A00450005000000
      0000000000000000}
    Left = 384
    Top = 232
  end
  object selCompetenze: TOracleDataSet
    SQL.Strings = (
      'select'
      
        'selA.area_sindacale, selA.tipo, selA.competenza, selA.decorrenza' +
        ', selA.scadenza,'
      
        'minutiore(sum(decode(t430.progressivo,null,0,decode(t245.abbatte' +
        '_competenze_org,'#39'S'#39',oreminuti(selA.ore),0)))) fruito, '
      
        'minutiore(oreminuti(selA.competenza) - sum(decode(t430.progressi' +
        'vo,null,0,decode(t245.abbatte_competenze_org,'#39'S'#39',oreminuti(selA.' +
        'ore),0)))) residuo'
      'from '
      '('
      
        'select * from  t242_competenzesindacati t242, t248_permessisinda' +
        'cali T248'
      'where t242.codice = :CODICE'
      
        '  and t242.area_sindacale = (select decode(t242.area_sindacale,'#39 +
        '*'#39','#39'*'#39',contratto)'
      '                               from T430_Storico'
      '                              where progressivo = :PROGRESSIVO'
      
        '                                and :DATA between datadecorrenza' +
        ' and datafine and rownum = 1)'
      
        '  and :DATA between t242.decorrenza and nvl(t242.scadenza,to_dat' +
        'e('#39'31123999'#39','#39'ddmmyyyy'#39'))'
      
        '  and T248.data(+) between T242.DECORRENZA and nvl(t242.scadenza' +
        ',to_date('#39'31123999'#39','#39'ddmmyyyy'#39'))'
      '  and nvl(T248.stato,'#39'O'#39') in ('#39'O'#39','#39'M'#39')'
      '  and T248.cod_sindacato (+) = :CODICE'
      '  :NUMRIGA'
      ') selA, '
      
        '(select codice, decode(fruizione_permessi,'#39'S'#39',decode(retribuito,' +
        #39'S'#39',decode(statutario,'#39'N'#39','#39'S'#39','#39'N'#39'),'#39'N'#39'),'#39'N'#39') abbatte_competenze_' +
        'org'
      ' from t245_organismisindacali) t245,'
      't430_storico t430  '
      'where selA.progressivo = t430.progressivo(+) '
      
        '  and selA.data between t430.datadecorrenza(+) and t430.datafine' +
        '(+)'
      
        '  and selA.area_sindacale = decode(selA.area_sindacale,'#39'*'#39','#39'*'#39',t' +
        '430.contratto(+))'
      
        '  and decode(selA.tipo,'#39'C'#39',:PROGRESSIVO,T430.progressivo(+)) = :' +
        'PROGRESSIVO'
      '  and selA.cod_organismo = t245.codice (+)'
      
        'group by selA.area_sindacale, selA.tipo, selA.competenza, selA.d' +
        'ecorrenza, selA.scadenza')
    Optimize = False
    Variables.Data = {
      04000000040000000E0000003A0043004F004400490043004500050000000000
      0000000000000A0000003A0044004100540041000C0000000000000000000000
      180000003A00500052004F0047005200450053005300490056004F0003000000
      0000000000000000100000003A004E0055004D00520049004700410001000000
      0000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000070000001400000043004F004D0050004500540045004E005A004100
      0100000000000C000000460052005500490054004F000100000000000E000000
      5200450053004900440055004F000100000000001C0000004100520045004100
      5F00530049004E0044004100430041004C004500010000000000140000004400
      450043004F005200520045004E005A0041000100000000001000000053004300
      4100440045004E005A004100010000000000080000005400490050004F000100
      00000000}
    Left = 264
    Top = 72
    object selCompetenzeAREA_SINDACALE: TStringField
      DisplayLabel = 'Contr.'
      DisplayWidth = 5
      FieldName = 'AREA_SINDACALE'
      Required = True
    end
    object selCompetenzeTIPO: TStringField
      DisplayLabel = 'Tipo'
      DisplayWidth = 1
      FieldName = 'TIPO'
      Required = True
      Size = 1
    end
    object selCompetenzeDECORRENZA: TDateTimeField
      DisplayLabel = 'Dal'
      DisplayWidth = 10
      FieldName = 'DECORRENZA'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object selCompetenzeSCADENZA: TDateTimeField
      DisplayLabel = 'Al'
      DisplayWidth = 10
      FieldName = 'SCADENZA'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object selCompetenzeCOMPETENZA: TStringField
      DisplayLabel = 'Competenze'
      DisplayWidth = 10
      FieldName = 'COMPETENZA'
      Size = 7
    end
    object selCompetenzeFRUITO: TStringField
      DisplayLabel = 'Fruito'
      DisplayWidth = 10
      FieldName = 'FRUITO'
      Size = 4000
    end
    object selCompetenzeRESIDUO: TStringField
      DisplayLabel = 'Residuo'
      DisplayWidth = 10
      FieldName = 'RESIDUO'
      Size = 4000
    end
  end
  object dsrCompetenze: TDataSource
    DataSet = selCompetenze
    Left = 264
    Top = 120
  end
  object selT245: TOracleDataSet
    SQL.Strings = (
      'select CODICE, DESCRIZIONE'
      '  from T245_ORGANISMISINDACALI T245'
      ' where FRUIZIONE_PERMESSI = '#39'S'#39
      '   and (PARTECIPAZIONE_RICHIESTA = '#39'N'#39' or '
      
        '        CODICE in (select COD_ORGANISMO from T247_PARTECIPAZIONI' +
        'SINDACATI where PROGRESSIVO = :PROGRESSIVO))'
      'order by CODICE, DESCRIZIONE')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000020000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E004500010000000000}
    Left = 192
    Top = 72
  end
  object dsrT245: TDataSource
    AutoEdit = False
    DataSet = selT245
    Left = 192
    Top = 120
  end
  object selT240: TOracleDataSet
    SQL.Strings = (
      
        'select distinct T240.codice, T240.descrizione, T240.rsu, t240.ra' +
        'ggruppamento, T240.sindacati_raggruppati, t240.filtro, :progress' +
        'ivo progressivo'
      
        'from t240_organizzazionisindacali T240, T247_partecipazionisinda' +
        'cati T247, t242_competenzesindacati T242, t430_storico t430'
      'where '
      
        '  T240.decorrenza = (select max(decorrenza) from t240_organizzaz' +
        'ionisindacali where codice = T240.CODICE and decorrenza < :DATA)' +
        ' and'
      
        '  ((T240.raggruppamento = '#39'N'#39' and T240.codice = T247.COD_SINDACA' +
        'TO) or'
      
        '   (T240.raggruppamento = '#39'S'#39'  and '#39','#39' || T240.sindacati_raggrup' +
        'pati || '#39','#39' like '#39'%,'#39' || T247.cod_sindacato || '#39'%,'#39')) and'
      '  T247.progressivo = :PROGRESSIVO and'
      
        '  :data between T247.dadata and nvl(T247.adata,to_date('#39'31123999' +
        #39','#39'ddmmyyyy'#39')) and '
      '  t430.progressivo = :progressivo and'
      '  :data between t430.datadecorrenza and t430.datafine and '
      '  (:COMPETENZE = '#39'N'#39' OR'
      '   :COMPETENZE = '#39'S'#39' and'
      '   T242.Codice = T240.Codice and'
      
        '   :data between t242.decorrenza and nvl(t242.scadenza,to_date('#39 +
        '31123999'#39','#39'ddmmyyyy'#39')) and'
      
        '   t242.area_sindacale = decode(t242.area_sindacale,'#39'*'#39','#39'*'#39',T430' +
        '.CONTRATTO)'
      '  ) and'
      '  t240.rsu = decode(:STATUTARIO,'#39'S'#39','#39'N'#39',t240.rsu)'
      'order by codice,descrizione')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A0044004100540041000C000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      00000000000000000000160000003A0043004F004D0050004500540045004E00
      5A004500050000000000000000000000160000003A0053005400410054005500
      54004100520049004F00050000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000050000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000000600
      00005200530055000100000000001C0000005200410047004700520055005000
      500041004D0045004E0054004F000100000000002A000000530049004E004400
      410043004100540049005F005200410047004700520055005000500041005400
      4900010000000000}
    AfterOpen = selT240AfterOpen
    OnFilterRecord = selT240FilterRecord
    Left = 120
    Top = 72
  end
  object dsrT240: TDataSource
    AutoEdit = False
    DataSet = selT240
    Left = 120
    Top = 120
  end
  object selT248Canc: TOracleDataSet
    SQL.Strings = (
      'select T248.*, T248.ROWID '
      'from T248_PERMESSISINDACALI T248'
      'where DATA = :DATA'
      '  and NVL(DALLE,'#39'X'#39') = NVL(:DALLE,'#39'X'#39')'
      '  and NVL(ALLE,'#39'X'#39') = NVL(:ALLE,'#39'X'#39')'
      '  and NVL(ORE,'#39'X'#39') = NVL(:ORE,'#39'X'#39')'
      '  and ABBATTE_COMPETENZE = :ABBATTE'
      '  and COD_SINDACATO = :COD_SINDACATO'
      '  and COD_ORGANISMO = :COD_ORGANISMO'
      '  and NVL(NUMERO_PROT,'#39'X'#39') = NVL(:NUMERO_PROT,'#39'X'#39')'
      '  and DATA_PROT = :DATA_PROT'
      '  and ((:TIPO = '#39'C'#39') or '
      
        '       (:TIPO = '#39'E'#39' and NVL(PROT_MODIFICA,'#39'X'#39') = NVL(:PROT_MODIF' +
        'ICA,'#39'X'#39') and DATA_MODIFICA = :DATA_MODIFICA))'
      '  and PROGRESSIVO in :SELC700'
      'order by PROGRESSIVO')
    Optimize = False
    Variables.Data = {
      040000000D0000000A0000003A0044004100540041000C000000000000000000
      00000C0000003A00440041004C004C0045000500000000000000000000000A00
      00003A0041004C004C004500050000000000000000000000080000003A004F00
      52004500050000000000000000000000100000003A0041004200420041005400
      540045000500000000000000000000001C0000003A0043004F0044005F005300
      49004E00440041004300410054004F000500000000000000000000001C000000
      3A0043004F0044005F004F005200470041004E00490053004D004F0005000000
      0000000000000000180000003A004E0055004D00450052004F005F0050005200
      4F005400050000000000000000000000140000003A0044004100540041005F00
      500052004F0054000C0000000000000000000000100000003A00530045004C00
      43003700300030000100000000000000000000000A0000003A00540049005000
      4F000500000000000000000000001C0000003A00500052004F0054005F004D00
      4F004400490046004900430041000500000000000000000000001C0000003A00
      44004100540041005F004D004F004400490046004900430041000C0000000000
      000000000000}
    Left = 520
    Top = 232
  end
  object selT247InsColl: TOracleDataSet
    SQL.Strings = (
      'SELECT T030.PROGRESSIVO'
      'FROM T030_ANAGRAFICO T030, V430_STORICO V430'
      'WHERE T030.PROGRESSIVO = V430.T430PROGRESSIVO'
      
        'AND :DATALAVORO BETWEEN V430.T430DATADECORRENZA AND V430.T430DAT' +
        'AFINE'
      ':FILTRO_T240'
      'AND T030.PROGRESSIVO IN '
      '(SELECT DISTINCT T247.PROGRESSIVO'
      
        ' FROM t240_organizzazionisindacali T240, T247_partecipazionisind' +
        'acati T247, t242_competenzesindacati T242, t430_storico t430'
      
        ' WHERE T240.decorrenza = (select max(decorrenza) from t240_organ' +
        'izzazionisindacali'
      
        '                          where codice = T240.CODICE and decorre' +
        'nza < :DATALAVORO)'
      
        ' AND (   (T240.raggruppamento = '#39'N'#39' and T240.codice = T247.COD_S' +
        'INDACATO) '
      
        '      OR (T240.raggruppamento = '#39'S'#39' and '#39','#39' || T240.sindacati_ra' +
        'ggruppati || '#39','#39' like '#39'%,'#39' || T247.cod_sindacato || '#39'%,'#39'))'
      ' AND T247.COD_SINDACATO = :COD_SINDACATO'
      
        ' AND :datalavoro between T247.dadata and nvl(T247.adata,to_date(' +
        #39'31123999'#39','#39'ddmmyyyy'#39'))'
      ' AND T247.PROGRESSIVO = T430.PROGRESSIVO'
      ' AND :datalavoro between t430.datadecorrenza and t430.datafine'
      ' AND (   :ABBATTE_COMPETENZE <> '#39'S'#39' '
      '      OR (    T242.Codice = T247.COD_SINDACATO '
      
        '          and :datalavoro between t242.decorrenza and nvl(t242.s' +
        'cadenza,to_date('#39'31123999'#39','#39'ddmmyyyy'#39')) '
      
        '          and t242.area_sindacale = decode(t242.area_sindacale,'#39 +
        '*'#39','#39'*'#39',T430.CONTRATTO))))')
    Optimize = False
    Variables.Data = {
      0400000004000000160000003A0044004100540041004C00410056004F005200
      4F000C0000000000000000000000180000003A00460049004C00540052004F00
      5F0054003200340030000100000000000000000000001C0000003A0043004F00
      44005F00530049004E00440041004300410054004F0005000000000000000000
      0000260000003A0041004200420041005400540045005F0043004F004D005000
      4500540045004E005A004500050000000000000000000000}
    Left = 448
    Top = 232
  end
  object selT248NoGEDAP: TOracleDataSet
    SQL.Strings = (
      'select T030.matricola, T030.cognome, T030.nome,'
      '       T248.*, T248.ROWID'
      'from T248_PERMESSISINDACALI T248, T030_ANAGRAFICO T030'
      'where T248.progressivo = T030.progressivo'
      
        '  and T030.progressivo IN (select progressivo from :C700SELANAGR' +
        'AFE)'
      '  and T248.inserito_gedap = '#39'N'#39
      '  and T248.data_da <= :DATAF'
      '  and T248.data >= :DATAI'
      
        '  and T248.cod_sindacato = nvl(:COD_SINDACATO,T248.cod_sindacato' +
        ')'
      
        '  and T248.cod_organismo = nvl(:COD_ORGANISMO,T248.cod_organismo' +
        ')'
      
        'order by T248.data desc, T248.data_da desc, T030.cognome, T030.n' +
        'ome, T030.matricola, T248.cod_sindacato, T248.cod_organismo')
    Optimize = False
    Variables.Data = {
      04000000050000000C0000003A00440041005400410049000C00000000000000
      000000000C0000003A00440041005400410046000C0000000000000000000000
      1C0000003A0043004F0044005F00530049004E00440041004300410054004F00
      0500000000000000000000001C0000003A0043004F0044005F004F0052004700
      41004E00490053004D004F00050000000000000000000000200000003A004300
      370030003000530045004C0041004E0041004700520041004600450001000000
      0000000000000000}
    OnCalcFields = selT248NoGEDAPCalcFields
    Left = 32
    Top = 232
    object selT248NoGEDAPMATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldName = 'MATRICOLA'
      ReadOnly = True
      Size = 8
    end
    object selT248NoGEDAPCOGNOME: TStringField
      DisplayLabel = 'Cognome'
      DisplayWidth = 25
      FieldName = 'COGNOME'
      ReadOnly = True
      Size = 50
    end
    object selT248NoGEDAPNOME: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 25
      FieldName = 'NOME'
      ReadOnly = True
      Size = 50
    end
    object selT248PROGRESSIVO: TIntegerField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      ReadOnly = True
      Required = True
      Visible = False
    end
    object selT248TIPO_PERMESSO: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO_PERMESSO'
      ReadOnly = True
      Size = 1
    end
    object selT248NoGEDAPDATA_DA: TDateTimeField
      DisplayLabel = 'da Data'
      DisplayWidth = 10
      FieldName = 'DATA_DA'
      ReadOnly = True
      Required = True
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!99/99/0000;1;_'
    end
    object selT248DATA: TDateTimeField
      DisplayLabel = 'a Data'
      DisplayWidth = 10
      FieldName = 'DATA'
      ReadOnly = True
      Required = True
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!99/99/0000;1;_'
    end
    object selT248NUMERO_PROT: TStringField
      DisplayLabel = 'N.Prot.'
      DisplayWidth = 5
      FieldName = 'NUMERO_PROT'
      ReadOnly = True
      Size = 10
    end
    object selT248DATA_PROT: TDateTimeField
      DisplayLabel = 'Data Prot.'
      DisplayWidth = 10
      FieldName = 'DATA_PROT'
      ReadOnly = True
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!99/99/0000;1;_'
    end
    object selT248NoGEDAPDALLE: TStringField
      DisplayLabel = 'da Ore'
      FieldName = 'DALLE'
      ReadOnly = True
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT248NoGEDAPALLE: TStringField
      DisplayLabel = 'a Ore'
      FieldName = 'ALLE'
      ReadOnly = True
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT248NoGEDAPORE: TStringField
      DisplayLabel = 'Ore tot.'
      FieldName = 'ORE'
      ReadOnly = True
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT248NoGEDAPABBATTE_COMPETENZE: TStringField
      DisplayLabel = 'Abbat.'
      FieldName = 'ABBATTE_COMPETENZE'
      ReadOnly = True
      Visible = False
      Size = 1
    end
    object selT248NoGEDAPABBATTE_COMPETENZE_ORG: TStringField
      DisplayLabel = 'Abbat.'
      FieldKind = fkCalculated
      FieldName = 'ABBATTE_COMPETENZE_ORG'
      ReadOnly = True
      Size = 1
      Calculated = True
    end
    object selT248NoGEDAPCOD_ORGANISMO: TStringField
      DisplayLabel = 'Cod.'
      FieldName = 'COD_ORGANISMO'
      ReadOnly = True
      Required = True
      Size = 5
    end
    object selT248NoGEDAPD_ORGANISMO: TStringField
      DisplayLabel = 'Organismo'
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'D_ORGANISMO'
      ReadOnly = True
      Size = 80
      Calculated = True
    end
    object selT248NoGEDAPCOD_SINDACATO: TStringField
      DisplayLabel = 'Cod.'
      DisplayWidth = 5
      FieldName = 'COD_SINDACATO'
      ReadOnly = True
      Required = True
      Size = 10
    end
    object selT248NoGEDAPD_SINDACATO: TStringField
      DisplayLabel = 'Sindacato'
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'D_SINDACATO'
      ReadOnly = True
      Size = 40
      Calculated = True
    end
    object selT248NoGEDAPCOD_MINISTERIALE: TStringField
      FieldKind = fkCalculated
      FieldName = 'COD_MINISTERIALE'
      ReadOnly = True
      Visible = False
      Size = 11
      Calculated = True
    end
    object selT248NoGEDAPSTATO: TStringField
      DisplayLabel = 'Stato'
      FieldName = 'STATO'
      ReadOnly = True
      Required = True
      Size = 1
    end
    object selT248NoGEDAPPROT_MODIFICA: TStringField
      DisplayLabel = 'Prot.Mod.'
      DisplayWidth = 5
      FieldName = 'PROT_MODIFICA'
      ReadOnly = True
      Size = 10
    end
    object selT248NoGEDAPDATA_MODIFICA: TDateTimeField
      DisplayLabel = 'Data Mod.'
      DisplayWidth = 10
      FieldName = 'DATA_MODIFICA'
      ReadOnly = True
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!99/99/0000;1;_'
    end
    object selT248NoGEDAPINSERITO_GEDAP: TStringField
      DisplayLabel = 'Inserito su GEDAP'
      FieldName = 'INSERITO_GEDAP'
      ReadOnly = True
      Required = True
      Visible = False
      Size = 1
    end
    object selT248NoGEDAPPROG_PERMESSO: TFloatField
      DisplayLabel = 'Prog. permesso'
      FieldName = 'PROG_PERMESSO'
      ReadOnly = True
      Required = True
      Visible = False
    end
    object selT248NoGEDAPRSU: TStringField
      FieldKind = fkCalculated
      FieldName = 'RSU'
      ReadOnly = True
      Visible = False
      Size = 1
      Calculated = True
    end
    object selT248NoGEDAPRAGGRUPPAMENTO: TStringField
      FieldKind = fkCalculated
      FieldName = 'RAGGRUPPAMENTO'
      ReadOnly = True
      Visible = False
      Size = 1
      Calculated = True
    end
    object selT248NoGEDAPRETRIBUITO: TStringField
      FieldKind = fkCalculated
      FieldName = 'RETRIBUITO'
      ReadOnly = True
      Visible = False
      Size = 1
      Calculated = True
    end
    object selT248NoGEDAPSTATUTARIO: TStringField
      FieldKind = fkCalculated
      FieldName = 'STATUTARIO'
      ReadOnly = True
      Visible = False
      Size = 1
      Calculated = True
    end
    object selT248NoGEDAPSIGLA_GEDAP: TStringField
      FieldKind = fkCalculated
      FieldName = 'SIGLA_GEDAP'
      ReadOnly = True
      Visible = False
      Calculated = True
    end
  end
  object dsrT248NoGEDAP: TDataSource
    AutoEdit = False
    DataSet = selT248NoGEDAP
    Left = 32
    Top = 280
  end
  object dsrT240NoGEDAP: TDataSource
    AutoEdit = False
    DataSet = selT240NoGEDAP
    Left = 120
    Top = 280
  end
  object selT240NoGEDAP: TOracleDataSet
    SQL.Strings = (
      'select distinct T240.codice, T240.descrizione'
      'from t240_organizzazionisindacali T240'
      
        'where T240.decorrenza = (select max(decorrenza) from t240_organi' +
        'zzazionisindacali where codice = T240.CODICE) '
      'order by codice,descrizione')
    Optimize = False
    Left = 120
    Top = 232
  end
  object selT245Tutti: TOracleDataSet
    SQL.Strings = (
      'select codice, descrizione, retribuito, statutario, causale,'
      
        '       decode(fruizione_permessi,'#39'S'#39',decode(retribuito,'#39'S'#39',decod' +
        'e(statutario,'#39'N'#39','#39'S'#39','#39'N'#39'),'#39'N'#39'),'#39'N'#39') abbatte_competenze_org'
      '  from t245_organismisindacali T245'
      'order by codice, descrizione')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000020000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E004500010000000000}
    Left = 192
    Top = 16
  end
  object selT240Tutti: TOracleDataSet
    SQL.Strings = (
      
        'select T240.codice, T240.descrizione, T240.rsu, T240.raggruppame' +
        'nto, T240.cod_ministeriale'
      'from t240_organizzazionisindacali T240'
      
        'where T240.decorrenza = (select max(decorrenza) from t240_organi' +
        'zzazionisindacali where codice = T240.CODICE and decorrenza < :D' +
        'ATA)'
      'order by codice,descrizione')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A0044004100540041000C000000000000000000
      0000}
    QBEDefinition.QBEFieldDefs = {
      05000000050000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000000600
      00005200530055000100000000001C0000005200410047004700520055005000
      500041004D0045004E0054004F000100000000002A000000530049004E004400
      410043004100540049005F005200410047004700520055005000500041005400
      4900010000000000}
    Left = 120
    Top = 16
  end
  object selV430: TOracleDataSet
    SQL.Strings = (
      
        'select T030.matricola, T030.cognome, T030.nome, T030.codfiscale,' +
        ' T030.sesso, T030.datanas, t480f_codcatastale(T030.comunenas) co' +
        'dcatastalenas :CampiEstratti'
      'from T030_ANAGRAFICO T030, V430_STORICO V430'
      'where T030.progressivo = :PROGRESSIVO'
      'and T030.progressivo = V430.t430progressivo'
      'and :DATA between V430.t430datadecorrenza and V430.t430datafine')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000001C0000003A00430041004D0050004900
      450053005400520041005400540049000100000000000000000000000A000000
      3A0044004100540041000C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000020000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E004500010000000000}
    Left = 264
    Top = 16
  end
  object dsrT245NoGEDAP: TDataSource
    AutoEdit = False
    DataSet = selT245NoGEDAP
    Left = 208
    Top = 280
  end
  object selT245NoGEDAP: TOracleDataSet
    SQL.Strings = (
      'select codice, descrizione'
      '  from t245_organismisindacali T245'
      ' where fruizione_permessi = '#39'S'#39
      'order by codice, descrizione')
    Optimize = False
    Left = 208
    Top = 232
  end
  object updT248: TOracleQuery
    SQL.Strings = (
      'UPDATE T248_PERMESSISINDACALI'
      'SET INSERITO_GEDAP = '#39'S'#39
      'WHERE ROWID = :ROWID')
    Optimize = False
    Variables.Data = {
      04000000010000000C0000003A0052004F005700490044000100000000000000
      00000000}
    Left = 32
    Top = 120
  end
  object selT040PFP: TOracleDataSet
    SQL.Strings = (
      'select T030.MATRICOLA, T030.COGNOME, T030.NOME,'
      
        '       T040.PROGRESSIVO,T040.DATA,T040.CAUSALE, T265.DESCRIZIONE' +
        ','
      '       T040.TIPOGIUST TIPO_PERMESSO,T040.DAORE,T040.AORE,'
      
        '       --DECODE(T040.CAUSALE,'#39'CARPU'#39','#39'2'#39','#39'CAPUP'#39','#39'2'#39','#39'CPUNR'#39','#39'2'#39 +
        ','#39'CARPB'#39','#39'5'#39') CAUSALE_GEDAP '
      '       VT230.GEDAP_CAUSALE CAUSALE_GEDAP'
      
        'from T040_GIUSTIFICATIVI T040, T030_ANAGRAFICO T030, VT230_CAUAS' +
        'SENZE_PARSTO VT230, T265_CAUASSENZE T265           '
      'where T040.PROGRESSIVO = T030.PROGRESSIVO'
      '  and T040.CAUSALE = T265.CODICE      '
      
        '  and T030.PROGRESSIVO in (select PROGRESSIVO from :C700SELANAGR' +
        'AFE)'
      '  and T040.DATA between :DATAI and :DATAF'
      '  and T040.CAUSALE = VT230.CODICE'
      
        '  and T040.DATA between VT230.DECORRENZA and VT230.DECORRENZA_FI' +
        'NE'
      '  and VT230.GEDAP_TIPO = '#39'P'#39
      '  and VT230.GEDAP_CAUSALE is not null'
      'order by T030.COGNOME, T030.NOME, T030.MATRICOLA, T040.DATA'
      ''
      '/*select T030.MATRICOLA, T030.COGNOME, T030.NOME,'
      
        '       T040.PROGRESSIVO,T040.DATA,T040.CAUSALE, T265.DESCRIZIONE' +
        ','
      '       T040.TIPOGIUST TIPO_PERMESSO,T040.DAORE,T040.AORE,'
      
        '       DECODE(T040.CAUSALE,'#39'CARPU'#39','#39'2'#39','#39'CAPUP'#39','#39'2'#39','#39'CPUNR'#39','#39'2'#39','#39 +
        'CARPB'#39','#39'5'#39','#39'CG1*P'#39','#39'5'#39') CAUSALE_GEDAP '
      
        'from T040_GIUSTIFICATIVI T040, T030_ANAGRAFICO T030, T265_CAUASS' +
        'ENZE T265'
      'where T040.PROGRESSIVO = T030.PROGRESSIVO'
      '  and T040.CAUSALE = T265.CODICE'
      
        '  and T030.PROGRESSIVO in (select PROGRESSIVO from :C700SELANAGR' +
        'AFE)'
      '  and T040.DATA between :DATAI and :DATAF'
      '  and T040.CAUSALE in ('#39'CARPU'#39','#39'CAPUP'#39','#39'CPUNR'#39','#39'CARPB'#39','#39'CG1*P'#39')'
      'order by T030.COGNOME, T030.NOME, T030.MATRICOLA, T040.DATA*/')
    Optimize = False
    Variables.Data = {
      0400000003000000200000003A004300370030003000530045004C0041004E00
      4100470052004100460045000100000000000000000000000C0000003A004400
      41005400410049000C00000000000000000000000C0000003A00440041005400
      410046000C0000000000000000000000}
    OnCalcFields = selT040PFPCalcFields
    Left = 32
    Top = 352
    object selT040PFPMATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selT040PFPCOGNOME: TStringField
      DisplayLabel = 'Cognome'
      DisplayWidth = 20
      FieldName = 'COGNOME'
      Size = 50
    end
    object selT040PFPNOME: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 20
      FieldName = 'NOME'
      Size = 50
    end
    object selT040PFPPROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selT040PFPDATA: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 13
      FieldName = 'DATA'
      EditMask = '!99/99/0000;1;_'
    end
    object selT040PFPCAUSALE: TStringField
      FieldName = 'CAUSALE'
      Visible = False
      Size = 5
    end
    object selT040PFPDESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Visible = False
      Size = 40
    end
    object selT040PFPD_CAUSALE: TStringField
      DisplayLabel = 'Causale'
      DisplayWidth = 35
      FieldKind = fkCalculated
      FieldName = 'D_CAUSALE'
      Size = 48
      Calculated = True
    end
    object selT040PFPTIPO_PERMESSO: TStringField
      DisplayWidth = 2
      FieldName = 'TIPO_PERMESSO'
      Size = 1
    end
    object selT040PFPD_TIPO: TStringField
      DisplayLabel = 'Tipo'
      DisplayWidth = 15
      FieldKind = fkCalculated
      FieldName = 'D_TIPO'
      Calculated = True
    end
    object selT040PFPDAORE: TDateTimeField
      FieldName = 'DAORE'
      Visible = False
    end
    object selT040PFPAORE: TDateTimeField
      FieldName = 'AORE'
      Visible = False
    end
    object selT040PFPDALLE: TStringField
      DisplayLabel = 'Dalle'
      DisplayWidth = 6
      FieldKind = fkCalculated
      FieldName = 'DALLE'
      Size = 5
      Calculated = True
    end
    object selT040PFPALLE: TStringField
      DisplayLabel = 'Alle'
      DisplayWidth = 6
      FieldKind = fkCalculated
      FieldName = 'ALLE'
      Size = 5
      Calculated = True
    end
    object selT040PFPCAUSALE_GEDAP: TStringField
      FieldName = 'CAUSALE_GEDAP'
      Size = 1
    end
  end
  object dsrT040PFP: TDataSource
    DataSet = selT040PFP
    Left = 128
    Top = 352
  end
end
