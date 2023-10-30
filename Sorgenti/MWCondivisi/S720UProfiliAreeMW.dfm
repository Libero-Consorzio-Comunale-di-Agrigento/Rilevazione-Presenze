inherited S720FProfiliAreeMW: TS720FProfiliAreeMW
  OldCreateOrder = True
  Height = 467
  Width = 462
  object selDato1: TOracleDataSet
    Optimize = False
    Left = 112
    Top = 24
  end
  object dsrDato1: TDataSource
    DataSet = selDato1
    Left = 112
    Top = 80
  end
  object selDato2: TOracleDataSet
    Optimize = False
    Left = 176
    Top = 24
  end
  object selDato3: TOracleDataSet
    Optimize = False
    Left = 240
    Top = 24
  end
  object dsrDato2: TDataSource
    DataSet = selDato2
    Left = 176
    Top = 80
  end
  object dsrDato3: TDataSource
    DataSet = selDato3
    Left = 240
    Top = 80
  end
  object selArea: TOracleDataSet
    SQL.Strings = (
      'select cod_area, descrizione '
      'from SG701_AREE_VALUTAZIONI'
      'where :Decorrenza between decorrenza and decorrenza_fine'
      'order by cod_area')
    Optimize = False
    Variables.Data = {
      0400000001000000160000003A004400450043004F005200520045004E005A00
      41000C0000000000000000000000}
    Left = 392
    Top = 24
  end
  object dsrArea: TDataSource
    DataSet = selArea
    Left = 392
    Top = 80
  end
  object selDato4: TOracleDataSet
    Optimize = False
    Left = 304
    Top = 24
  end
  object dsrDato4: TDataSource
    DataSet = selDato4
    Left = 304
    Top = 80
  end
  object selSG720a: TOracleQuery
    SQL.Strings = (
      'select count(*) n_dec_intersecanti'
      'from   sg720_profili_aree'
      'where  dato1 = :dato1'
      'and    dato2 = :dato2'
      'and    dato3 = :dato3'
      'and    dato4 = :dato4'
      'and    cod_area = :cod_area'
      ':cond_rowid'
      'and    (   :decorrenza between decorrenza and decorrenza_fine'
      '        or :scadenza   between decorrenza and decorrenza_fine'
      
        '        or (:decorrenza < decorrenza and :scadenza > decorrenza_' +
        'fine))')
    Optimize = False
    Variables.Data = {
      04000000080000000C0000003A004400410054004F0031000500000000000000
      000000000C0000003A004400410054004F003200050000000000000000000000
      0C0000003A004400410054004F00330005000000000000000000000012000000
      3A0043004F0044005F0041005200450041000500000000000000000000001600
      00003A004400450043004F005200520045004E005A0041000C00000000000000
      00000000120000003A00530043004100440045004E005A0041000C0000000000
      000000000000160000003A0043004F004E0044005F0052004F00570049004400
      0100000000000000000000000C0000003A004400410054004F00340005000000
      0000000000000000}
    Left = 40
    Top = 24
  end
  object delSG701: TOracleQuery
    SQL.Strings = (
      'delete SG701_AREE_VALUTAZIONI SG701'
      'where exists (select 1 '
      '              from SG720_PROFILI_AREE SG720 '
      '              where SG720.COD_AREA = SG701.COD_AREA '
      '              and SG720.DECORRENZA_FINE >= :InizioAnno)'
      'and SG701.DECORRENZA >= :InizioAnno'
      'and substr(COD_AREA,2,3) not in ('#39'000'#39','#39'999'#39')')
    Optimize = False
    Variables.Data = {
      0400000001000000160000003A0049004E0049005A0049004F0041004E004E00
      4F000C0000000000000000000000}
    Left = 40
    Top = 208
  end
  object updSG701a: TOracleQuery
    SQL.Strings = (
      'update SG701_AREE_VALUTAZIONI SG701'
      'set DECORRENZA_FINE = to_date('#39'31123999'#39','#39'DDMMYYYY'#39')'
      'where exists (select 1 '
      '              from SG720_PROFILI_AREE SG720 '
      '              where SG720.COD_AREA = SG701.COD_AREA '
      '              and SG720.DECORRENZA_FINE >= :InizioAnno)'
      'and SG701.DECORRENZA_FINE = :InizioAnno - 1'
      'and substr(COD_AREA,2,3) not in ('#39'000'#39','#39'999'#39')')
    Optimize = False
    Variables.Data = {
      0400000001000000160000003A0049004E0049005A0049004F0041004E004E00
      4F000C0000000000000000000000}
    Left = 40
    Top = 264
  end
  object updI501a: TOracleQuery
    SQL.Strings = (
      'update :Tabella'
      'set DECORRENZA_FINE = :InizioAnno - 1'
      'where DECORRENZA_FINE >= :InizioAnno'
      'and substr(CODICE,2,3) <> '#39'000'#39)
    Optimize = False
    Variables.Data = {
      0400000002000000160000003A0049004E0049005A0049004F0041004E004E00
      4F000C0000000000000000000000100000003A0054004100420045004C004C00
      4100010000000000000000000000}
    Left = 40
    Top = 320
  end
  object delI501: TOracleQuery
    SQL.Strings = (
      'delete :Tabella'
      'where DECORRENZA > DECORRENZA_FINE')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0054004100420045004C004C00410001000000
      0000000000000000}
    Left = 40
    Top = 376
  end
  object scrT430: TOracleQuery
    SQL.Strings = (
      'declare'
      '  cursor C1 is'
      '    select PROGRESSIVO, min(DATADECORRENZA) DECOMIN'
      '    from T430_STORICO'
      '    where :CampoRegole is not null'
      '    and INIZIO <= :FineAnno'
      '    and nvl(FINE,to_date('#39'31123999'#39','#39'DDMMYYYY'#39')) >= :InizioAnno'
      '    group by progressivo;'
      '  dDAL date;'
      'begin'
      '  for R1 IN C1 loop'
      '    dDAL:=:InizioAnno;'
      '    if R1.DECOMIN > dDAL then'
      '      dDAL:=R1.DECOMIN;'
      '    end if;'
      '    CREAZIONE_STORICO(R1.PROGRESSIVO,dDAL,NULL);'
      '    update T430_STORICO'
      
        '    set :CampoProfili = decode(:CampoRegole,null,null,:CampoRego' +
        'le||'#39'000'#39')'
      '    where PROGRESSIVO = R1.PROGRESSIVO'
      '    and DATADECORRENZA >= dDAL;'
      '  end loop;'
      'end;')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00430041004D0050004F005200450047004F00
      4C004500010000000000000000000000160000003A0049004E0049005A004900
      4F0041004E004E004F000C00000000000000000000001A0000003A0043004100
      4D0050004F00500052004F00460049004C004900010000000000000000000000
      120000003A00460049004E00450041004E004E004F000C000000000000000000
      0000}
    Left = 104
    Top = 320
  end
  object cdsAppoggio: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 40
    Top = 152
  end
  object selT030: TOracleDataSet
    SQL.Strings = (
      'select PROGRESSIVO, COGNOME, NOME'
      'from T030_ANAGRAFICO T030'
      'where T030.MATRICOLA = :Matricola'
      'and exists (select 1 '
      '            from T430_STORICO T430'
      '            where T030.PROGRESSIVO = T430.PROGRESSIVO'
      '            and T430.INIZIO <= :FineAnno'
      
        '            and nvl(T430.FINE,to_date('#39'31123999'#39','#39'DDMMYYYY'#39')) >=' +
        ' :InizioAnno)')
    Optimize = False
    Variables.Data = {
      0400000003000000140000003A004D00410054005200490043004F004C004100
      050000000000000000000000120000003A00460049004E00450041004E004E00
      4F000C0000000000000000000000160000003A0049004E0049005A0049004F00
      41004E004E004F000C0000000000000000000000}
    CommitOnPost = False
    Left = 168
    Top = 208
  end
  object selSG711a: TOracleDataSet
    SQL.Strings = (
      'select distinct substr(SG711.COD_AREA,2,3) COD_DIR'
      
        'from SG710_TESTATA_VALUTAZIONI SG710, SG711_VALUTAZIONI_DIPENDEN' +
        'TE SG711'
      'where SG710.PROGRESSIVO = :Progressivo'
      'and SG710.TIPO_VALUTAZIONE = '#39'V'#39
      'and SG710.DATA = (select max(SG710A.DATA) '
      '                  from SG710_TESTATA_VALUTAZIONI SG710A '
      '                  where SG710A.PROGRESSIVO = SG710.PROGRESSIVO'
      
        '                  and SG710A.TIPO_VALUTAZIONE = SG710.TIPO_VALUT' +
        'AZIONE'
      '                  and SG710A.DATA >= :DecMinNuoviCodici)'
      
        'and SG710.STATO_AVANZAMENTO = (select max(SG710A.STATO_AVANZAMEN' +
        'TO) '
      '                  from SG710_TESTATA_VALUTAZIONI SG710A '
      '                  where SG710A.PROGRESSIVO = SG710.PROGRESSIVO'
      
        '                  and SG710A.TIPO_VALUTAZIONE = SG710.TIPO_VALUT' +
        'AZIONE'
      '                  and SG710A.DATA = SG710.DATA)'
      'and SG711.PROGRESSIVO = SG710.PROGRESSIVO'
      'and SG711.DATA = SG710.DATA'
      'and SG711.TIPO_VALUTAZIONE = SG710.TIPO_VALUTAZIONE'
      'and SG711.STATO_AVANZAMENTO = SG710.STATO_AVANZAMENTO'
      'and substr(SG711.COD_AREA,2,3) NOT IN ('#39'000'#39','#39'999'#39')')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000240000003A004400450043004D004900
      4E004E0055004F005600490043004F0044004900430049000C00000000000000
      00000000}
    CommitOnPost = False
    Left = 168
    Top = 264
  end
  object selI501: TOracleDataSet
    SQL.Strings = (
      'select nvl(max(substr(CODICE,2,3)),0) MAX_COD_DIR'
      'from :Tabella'
      'where DECORRENZA_FINE >= :DecMinNuoviCodici'
      'and substr(CODICE,2,3) <> '#39'000'#39)
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0054004100420045004C004C00410001000000
      0000000000000000240000003A004400450043004D0049004E004E0055004F00
      5600490043004F0044004900430049000C0000000000000000000000}
    CommitOnPost = False
    Left = 104
    Top = 376
  end
  object updI501b: TOracleQuery
    SQL.Strings = (
      'update :Tabella'
      'set DECORRENZA_FINE = to_date('#39'31123999'#39','#39'DDMMYYYY'#39')'
      'where :InizioAnno - 1 between DECORRENZA and DECORRENZA_FINE'
      'and CODICE = :CodProf'
      'and DESCRIZIONE = :DescProf')
    Optimize = False
    Variables.Data = {
      0400000004000000160000003A0049004E0049005A0049004F0041004E004E00
      4F000C0000000000000000000000100000003A0054004100420045004C004C00
      4100010000000000000000000000100000003A0043004F004400500052004F00
      4600050000000000000000000000120000003A00440045005300430050005200
      4F004600050000000000000000000000}
    Left = 168
    Top = 320
  end
  object insI501: TOracleQuery
    SQL.Strings = (
      
        'insert into :Tabella (codice, decorrenza, decorrenza_fine, descr' +
        'izione)'
      
        'values (:CodProf, :InizioAnno, to_date('#39'31123999'#39','#39'DDMMYYYY'#39'), :' +
        'DescProf)')
    Optimize = False
    Variables.Data = {
      0400000004000000160000003A0049004E0049005A0049004F0041004E004E00
      4F000C0000000000000000000000100000003A0043004F004400500052004F00
      4600050000000000000000000000120000003A00440045005300430050005200
      4F004600050000000000000000000000100000003A0054004100420045004C00
      4C004100010000000000000000000000}
    Left = 168
    Top = 376
  end
  object updT430: TOracleQuery
    SQL.Strings = (
      'update T430_STORICO'
      'set :CampoProfili = :CodProf,'
      '    :CampoRegole = substr(:CodProf,1,1)'
      'where PROGRESSIVO = :Progressivo'
      'and DATAFINE >= :InizioAnno')
    Optimize = False
    Variables.Data = {
      0400000005000000180000003A00430041004D0050004F005200450047004F00
      4C004500010000000000000000000000160000003A0049004E0049005A004900
      4F0041004E004E004F000C00000000000000000000001A0000003A0043004100
      4D0050004F00500052004F00460049004C004900010000000000000000000000
      100000003A0043004F004400500052004F004600050000000000000000000000
      180000003A00500052004F0047005200450053005300490056004F0003000000
      0000000000000000}
    Left = 232
    Top = 208
  end
  object updSG701b: TOracleQuery
    SQL.Strings = (
      'update SG701_AREE_VALUTAZIONI SG701'
      'set DECORRENZA_FINE = :InizioAnno - 1'
      'where SG701.DECORRENZA_FINE = to_date('#39'31123999'#39','#39'DDMMYYYY'#39')'
      'and COD_AREA = :CodArea')
    Optimize = False
    Variables.Data = {
      0400000002000000160000003A0049004E0049005A0049004F0041004E004E00
      4F000C0000000000000000000000100000003A0043004F004400410052004500
      4100050000000000000000000000}
    Left = 232
    Top = 264
  end
  object insSG701a: TOracleQuery
    SQL.Strings = (
      'insert into SG701_AREE_VALUTAZIONI'
      
        '(COD_AREA, DECORRENZA, DECORRENZA_FINE, DESCRIZIONE, PESO_PERCEN' +
        'TUALE, PESO_VARIABILE_ITEMS, TIPO_PUNTEGGIO_ITEMS, ITEM_TUTTI_VA' +
        'LUTABILI, '
      
        ' ITEM_PERSONALIZZATI_MIN, ITEM_PERSONALIZZATI_MAX, TIPO_PESO_PER' +
        'CENTUALE, TIPO_LINK_ITEM, STATI_ABILITATI_PUNTEGGI, STATI_ABILIT' +
        'ATI_ELEMENTI, '
      
        ' PESO_EQUO_ITEMS, TESTO_ITEM_PERSONALIZZATI, PESO_PERC_MIN, PESO' +
        '_PERC_MAX, PUNTEGGI_SOLO_ITEM_VALUTABILI)'
      'values'
      
        '(:CodArea, :InizioAnno, to_date('#39'31123999'#39','#39'DDMMYYYY'#39'), :DescAre' +
        'a, :PercArea, '#39'N'#39', '#39'1'#39', '#39'S'#39', '
      
        ' 0, 0, '#39'1'#39', :TipoLinkItem, DECODE(:TipoLinkItem,'#39'0'#39',SUBSTR(:CodA' +
        'rea,1,1)||'#39'.2'#39',null), null, '
      
        ' DECODE(:TipoLinkItem,'#39'0'#39','#39'N'#39','#39'S'#39'), null, :PercArea, :PercArea, ' +
        'DECODE(:TipoLinkItem,'#39'1'#39','#39'S'#39','#39'N'#39'))')
    Optimize = False
    Variables.Data = {
      0400000005000000160000003A0049004E0049005A0049004F0041004E004E00
      4F000C0000000000000000000000100000003A0043004F004400410052004500
      4100050000000000000000000000120000003A00440045005300430041005200
      45004100050000000000000000000000120000003A0050004500520043004100
      5200450041000400000000000000000000001A0000003A005400490050004F00
      4C0049004E004B004900540045004D00050000000000000000000000}
    Left = 232
    Top = 320
  end
  object insSG700: TOracleQuery
    SQL.Strings = (
      'insert into SG700_VALUTAZIONI'
      
        '(COD_AREA, DECORRENZA, COD_VALUTAZIONE, DESCRIZIONE, PESO_PERCEN' +
        'TUALE, COD_AREA_LINK, COD_VALUTAZIONE_LINK)'
      'values'
      
        '(:CodArea, :InizioAnno, :CodItem, :DescItem, :PercItem, :CodArea' +
        'Link, :CodItemLink)')
    Optimize = False
    Variables.Data = {
      0400000007000000160000003A0049004E0049005A0049004F0041004E004E00
      4F000C0000000000000000000000100000003A0043004F004400410052004500
      4100050000000000000000000000100000003A0043004F004400490054004500
      4D00050000000000000000000000120000003A00440045005300430049005400
      45004D00050000000000000000000000120000003A0050004500520043004900
      540045004D00040000000000000000000000180000003A0043004F0044004100
      5200450041004C0049004E004B00050000000000000000000000180000003A00
      43004F0044004900540045004D004C0049004E004B0005000000000000000000
      0000}
    Left = 232
    Top = 376
  end
  object updSG720a: TOracleQuery
    SQL.Strings = (
      'update SG720_PROFILI_AREE'
      'set DECORRENZA_FINE = :InizioAnno - 1'
      'where DECORRENZA_FINE >= :InizioAnno'
      'and substr(DATO1,2,3) <> '#39'000'#39)
    Optimize = False
    Variables.Data = {
      0400000001000000160000003A0049004E0049005A0049004F0041004E004E00
      4F000C0000000000000000000000}
    Left = 104
    Top = 208
  end
  object delSG720: TOracleQuery
    SQL.Strings = (
      'delete SG720_PROFILI_AREE'
      'where DECORRENZA > DECORRENZA_FINE')
    Optimize = False
    Left = 104
    Top = 264
  end
  object updSG720b: TOracleQuery
    SQL.Strings = (
      'update SG720_PROFILI_AREE'
      'set DECORRENZA_FINE = to_date('#39'31123999'#39','#39'DDMMYYYY'#39')'
      'where DECORRENZA_FINE = :InizioAnno - 1'
      'and DATO1 = :CodProf'
      'and COD_AREA = :CodArea'
      'and :CodProfStoricizzato = '#39'N'#39)
    Optimize = False
    Variables.Data = {
      0400000004000000160000003A0049004E0049005A0049004F0041004E004E00
      4F000C0000000000000000000000100000003A0043004F004400500052004F00
      4600050000000000000000000000100000003A0043004F004400410052004500
      4100050000000000000000000000280000003A0043004F004400500052004F00
      4600530054004F0052004900430049005A005A00410054004F00050000000000
      000000000000}
    Left = 296
    Top = 208
  end
  object insSG720: TOracleQuery
    SQL.Strings = (
      'insert into SG720_PROFILI_AREE'
      
        '(DECORRENZA, DECORRENZA_FINE, DATO1, DATO2, DATO3, DATO4, COD_AR' +
        'EA)'
      'values'
      
        '(:InizioAnno, to_date('#39'31123999'#39','#39'DDMMYYYY'#39'), :CodProf, '#39' '#39', '#39' '#39 +
        ', '#39' '#39', :CodArea)')
    Optimize = False
    Variables.Data = {
      0400000003000000160000003A0049004E0049005A0049004F0041004E004E00
      4F000C0000000000000000000000100000003A0043004F004400410052004500
      4100050000000000000000000000100000003A0043004F004400500052004F00
      4600050000000000000000000000}
    Left = 296
    Top = 264
  end
  object cdsDipInf: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 104
    Top = 152
  end
  object selSG701: TOracleDataSet
    SQL.Strings = (
      
        'select SG701.COD_AREA, CONCATENA_TESTO('#39'select COD_VALUTAZIONE_L' +
        'INK from SG700_VALUTAZIONI where COD_AREA = '#39#39#39'||SG701.COD_AREA ' +
        '||'#39#39#39' and DECORRENZA = to_date('#39#39#39'||TO_CHAR(SG701.DECORRENZA,'#39'DD' +
        'MMYYYY'#39')||'#39#39#39','#39#39'DDMMYYYY'#39#39') order by COD_VALUTAZIONE'#39','#39'/'#39') ELENC' +
        'O_ITEM'
      'from SG701_AREE_VALUTAZIONI SG701'
      'where SG701.COD_AREA like :CodProf||'#39'%'#39
      'and SG701.DECORRENZA = :InizioAnno'
      'order by SG701.COD_AREA')
    Optimize = False
    Variables.Data = {
      0400000002000000160000003A0049004E0049005A0049004F0041004E004E00
      4F000C0000000000000000000000100000003A0043004F004400500052004F00
      4600050000000000000000000000}
    CommitOnPost = False
    Left = 296
    Top = 320
  end
  object selT430: TOracleDataSet
    SQL.Strings = (
      'select distinct substr(:CampoProfili,2,3) COD_DIR'
      'from T430_STORICO'
      'where progressivo = :Progressivo'
      'and DATADECORRENZA >= :DecMinNuoviCodici'
      'and substr(:CampoProfili,2,3) NOT IN ('#39'000'#39','#39'999'#39')'
      'and substr(:CampoProfili,1,1) IN ('#39'A'#39','#39'B'#39')')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000240000003A004400450043004D004900
      4E004E0055004F005600490043004F0044004900430049000C00000000000000
      000000001A0000003A00430041004D0050004F00500052004F00460049004C00
      4900010000000000000000000000}
    CommitOnPost = False
    Left = 296
    Top = 376
  end
  object selSG710: TOracleDataSet
    SQL.Strings = (
      'select count(*) N_SCHEDE'
      'from SG710_TESTATA_VALUTAZIONI'
      'where DATA >= :InizioAnno')
    Optimize = False
    Variables.Data = {
      0400000001000000160000003A0049004E0049005A0049004F0041004E004E00
      4F000C0000000000000000000000}
    CommitOnPost = False
    Left = 168
    Top = 152
  end
end
