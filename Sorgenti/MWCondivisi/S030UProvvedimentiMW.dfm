inherited S030FProvvedimentiMW: TS030FProvvedimentiMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 300
  Width = 580
  object insSG100: TOracleQuery
    SQL.Strings = (
      'INSERT INTO SG100_PROVVEDIMENTO '
      
        '(PROGRESSIVO,NOMECAMPO,DATADECOR,DATAREGISTR,CAUSALE,AUTORITA,TI' +
        'POATTO,NUMATTO,DATAATTO,DATAESEC,NOTE,DATAFINE,SEDE,TIPO_PROVV,T' +
        'ESTOVAR)'
      'VALUES'
      
        '(:PROGRESSIVO,:NOMECAMPO,:DATADECOR,:DATAREGISTR,:CAUSALE,:AUTOR' +
        'ITA,:TIPOATTO,:NUMATTO,:DATAATTO,:DATAESEC,:NOTE,:DATAFINE,:SEDE' +
        ',:TIPO_PROVV,:TESTOVAR)')
    Optimize = False
    Variables.Data = {
      040000000F000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000140000003A004E004F004D0045004300
      41004D0050004F00050000000000000000000000140000003A00440041005400
      41004400450043004F0052000C0000000000000000000000180000003A004400
      41005400410052004500470049005300540052000C0000000000000000000000
      100000003A00430041005500530041004C004500050000000000000000000000
      120000003A004100550054004F00520049005400410005000000000000000000
      0000120000003A005400490050004F004100540054004F000500000000000000
      00000000100000003A004E0055004D004100540054004F000500000000000000
      00000000120000003A0044004100540041004100540054004F000C0000000000
      000000000000120000003A00440041005400410045005300450043000C000000
      00000000000000000A0000003A004E004F005400450005000000000000000000
      0000120000003A004400410054004100460049004E0045000C00000000000000
      000000000A0000003A0053004500440045000500000000000000000000001600
      00003A005400490050004F005F00500052004F00560056000500000000000000
      00000000120000003A0054004500530054004F00560041005200050000000000
      000000000000}
    Left = 24
    Top = 152
  end
  object delSG100: TOracleQuery
    SQL.Strings = (
      'DELETE SG100_PROVVEDIMENTO '
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      '  AND NOMECAMPO = :NOMECAMPO'
      '  AND DATADECOR = :DATADECOR'
      '  AND DATAREGISTR = :DATAREGISTR'
      '  AND DATAFINE = :DATAFINE'
      '  AND TIPO_PROVV = :TIPO_PROVV'
      '  AND NVL(CAUSALE,'#39' '#39') = NVL(:CAUSALE,'#39' '#39')'
      '  AND NVL(SEDE,'#39' '#39') = NVL(:SEDE,'#39' '#39')'
      '  AND NVL(AUTORITA,'#39' '#39') = NVL(:AUTORITA,'#39' '#39')'
      '  AND NVL(TIPOATTO,'#39' '#39') = NVL(:TIPOATTO,'#39' '#39')'
      '  AND NVL(NUMATTO,'#39' '#39') = NVL(:NUMATTO,'#39' '#39')'
      
        '  AND NVL(DATAATTO,TO_DATE('#39'01/01/1900'#39','#39'DD/MM/YYYY'#39')) = NVL(:DA' +
        'TAATTO,TO_DATE('#39'01/01/1900'#39','#39'DD/MM/YYYY'#39'))'
      
        '  AND NVL(DATAESEC,TO_DATE('#39'01/01/1900'#39','#39'DD/MM/YYYY'#39')) = NVL(:DA' +
        'TAESEC,TO_DATE('#39'01/01/1900'#39','#39'DD/MM/YYYY'#39'))'
      '  AND NVL(NOTE,'#39' '#39') = NVL(:NOTE,'#39' '#39')'
      '  AND NVL(TESTOVAR,'#39' '#39') = NVL(:TESTOVAR,'#39' '#39')')
    Optimize = False
    Variables.Data = {
      040000000F000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000140000003A004E004F004D0045004300
      41004D0050004F00050000000000000000000000140000003A00440041005400
      41004400450043004F0052000C0000000000000000000000180000003A004400
      41005400410052004500470049005300540052000C0000000000000000000000
      100000003A00430041005500530041004C004500050000000000000000000000
      120000003A004100550054004F00520049005400410005000000000000000000
      0000120000003A005400490050004F004100540054004F000500000000000000
      00000000100000003A004E0055004D004100540054004F000500000000000000
      00000000120000003A0044004100540041004100540054004F000C0000000000
      000000000000120000003A00440041005400410045005300450043000C000000
      00000000000000000A0000003A004E004F005400450005000000000000000000
      0000120000003A004400410054004100460049004E0045000C00000000000000
      000000000A0000003A0053004500440045000500000000000000000000001600
      00003A005400490050004F005F00500052004F00560056000500000000000000
      00000000120000003A0054004500530054004F00560041005200050000000000
      000000000000}
    Left = 24
    Top = 104
  end
  object selMaxNum: TOracleQuery
    SQL.Strings = (
      'declare'
      '  cursor c1 is'
      '    select numatto from sg100_provvedimento;'
      'begin'
      '  :MaxNum:=0;'
      '  for t1 in c1 loop'
      '    begin'
      '      if to_number(t1.numatto) > :MaxNum then'
      '        :MaxNum:=t1.numatto;'
      '      end if;'
      '    exception'
      '      when others then null;'
      '    end;'
      '  end loop;'
      '  :MaxNum:=:MaxNum + 1;'
      'end;')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A004D00410058004E0055004D00030000000400
      00006500000000000000}
    Left = 316
    Top = 104
  end
  object dsrI010: TDataSource
    Left = 66
    Top = 56
  end
  object selV430: TOracleDataSet
    SQL.Strings = (
      'select :DATI'
      '  from t030_anagrafico t030, V430_storico V430'
      ' where t030.progressivo = T430progressivo'
      '   and t030.progressivo = :PROG'
      '   and :DEC between T430DATADECORRENZA AND T430DATAFINE')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A00440041005400490001000000000000000000
      00000A0000003A00500052004F00470003000000000000000000000008000000
      3A004400450043000C0000000000000000000000}
    Left = 24
    Top = 216
  end
  object selFam: TOracleDataSet
    SQL.Strings = (
      'select * from '
      '(select distinct PROGRESSIVO, NUMORD, COGNOME, NOME, '
      '  TRUNC(DATANAS) DATANAS, '
      
        '-- Data nascita effettiva: primo giorno del mese successivo alla' +
        ' data di nascita. Se la data di nascita '#232' il giorno 1, mese stes' +
        'so'
      
        '  DECODE(TRUNC(DATANAS), TRUNC(DATANAS,'#39'MM'#39'), TRUNC(DATANAS), TR' +
        'UNC(ADD_MONTHS(TRUNC(DATANAS),1),'#39'MM'#39')) DATANAS_EFF, '
      '  TRUNC(DATAADOZ) DATAADOZ,'
      
        '-- Data adozione effettiva: primo giorno del mese successivo all' +
        'a data di adozione. Se la data di adozione '#232' il giorno 1, mese s' +
        'tesso'
      
        '  DECODE(TRUNC(DATAADOZ), TRUNC(DATAADOZ,'#39'MM'#39'), TRUNC(DATAADOZ),' +
        ' TRUNC(ADD_MONTHS(TRUNC(DATAADOZ),1),'#39'MM'#39')) DATAADOZ_EFF, '
      '  DATASEP,'
      
        '-- Data esclusione effettiva: primo giorno del mese successivo a' +
        'lla data di esclusione.'
      '  TRUNC(ADD_MONTHS(DATASEP,1),'#39'MM'#39') DATASEP_EFF,'
      
        '  DECODE(GRADOPAR,'#39'FG'#39',DECODE(SESSO,'#39'M'#39','#39'Son'#39','#39'F'#39','#39'Daughter'#39','#39'So' +
        'n\Daughter'#39'),'#39'CG'#39','#39'Spouse'#39','#39'GT'#39','#39'Parent'#39','
      
        '   '#39'FR'#39',DECODE(SESSO,'#39'M'#39','#39'Brother'#39','#39'F'#39','#39'Sister'#39','#39'Brother/Sister'#39 +
        '),'#39'NP'#39','#39'Grandson\Granddaughter\Nephew'#39','
      
        '   '#39'NF'#39','#39'Grandson\Granddaughter\Nephew'#39','#39'Domestic partner'#39') GRAD' +
        'OPAR'
      '  from SG101_FAMILIARI'
      ' where PROGRESSIVO = :PROG'
      '   and :DEC between DECORRENZA and DECORRENZA_FINE)'
      'where NVL(DATAADOZ_EFF,DATANAS_EFF) <= :DEC'
      '  and NVL(DATASEP_EFF,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) > :DEC'
      'order by PROGRESSIVO, NUMORD, DATANAS')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A00500052004F00470003000000000000000000
      0000080000003A004400450043000C0000000000000000000000}
    Left = 144
    Top = 216
  end
  object selSG100Atto: TOracleDataSet
    SQL.Strings = (
      
        'select distinct TRIM(INITCAP(tipoatto)) tipoatto from sg100_prov' +
        'vedimento'
      'where tipoatto is not null'
      'UNION'
      'select '#39'Delibera'#39' tipoatto from sg100_provvedimento'
      'UNION'
      'select '#39'Determina'#39' tipoatto from sg100_provvedimento'
      'UNION'
      'select '#39'Protocollo'#39' tipoatto from sg100_provvedimento'
      'order by tipoatto'
      ''
      '')
    Optimize = False
    Left = 320
    Top = 8
  end
  object selSG100Aut: TOracleDataSet
    SQL.Strings = (
      'select distinct AUTORITA from SG100_PROVVEDIMENTO'
      'order by AUTORITA')
    Optimize = False
    Left = 384
    Top = 8
  end
  object selSede: TOracleDataSet
    Optimize = False
    Left = 232
    Top = 8
  end
  object dsrSede: TDataSource
    DataSet = selSede
    Left = 232
    Top = 53
  end
  object selT265: TOracleDataSet
    SQL.Strings = (
      'select codice, descrizione '
      'from t265_cauassenze '
      'order by codice')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000020000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E004500010000000000}
    Filtered = True
    OnFilterRecord = selT265FilterRecord
    Left = 108
    Top = 8
    object selT265CODICE: TStringField
      FieldName = 'CODICE'
      Required = True
      Size = 5
    end
    object selT265DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
  object dsrT265: TDataSource
    DataSet = selT265
    Left = 108
    Top = 56
  end
  object selSG104: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM SG104_TIPOMOTIVAZIONI ORDER BY Codice')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000060000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000001E00
      00004400450053004300520049005A0049004F004E0045005F00410047004700
      010000000000200000005300540041004D00500041005F00460041004D004900
      4C0049004100520049000100000000002400000045004C0045004E0043004F00
      5F004E0055004D004500520049005F0050005200450043000100000000002400
      000045004C0045004E0043004F005F004E0055004D004500520049005F005300
      550043004300010000000000}
    Left = 178
    Top = 7
    object selSG104CODICE: TStringField
      DisplayWidth = 9
      FieldName = 'CODICE'
      Required = True
      Size = 5
    end
    object selSG104DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 130
    end
    object selSG104DESCRIZIONE_AGG: TStringField
      FieldName = 'DESCRIZIONE_AGG'
      Size = 200
    end
    object selSG104STAMPA_FAMILIARI: TStringField
      FieldName = 'STAMPA_FAMILIARI'
      Required = True
      Size = 1
    end
    object selSG104ELENCO_NUMERI_PREC: TStringField
      FieldName = 'ELENCO_NUMERI_PREC'
      Size = 500
    end
    object selSG104ELENCO_NUMERI_SUCC: TStringField
      FieldName = 'ELENCO_NUMERI_SUCC'
      Size = 500
    end
  end
  object dsrSG104: TDataSource
    DataSet = selSG104
    Left = 180
    Top = 54
  end
  object selSQL: TOracleQuery
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000001E0000003A0044004100540041004400
      450043004F005200520045004E005A0041000C0000000000000000000000}
    Left = 428
    Top = 100
  end
  object selNum: TOracleQuery
    SQL.Strings = (
      'SELECT COUNT(*) FROM SG100_PROVVEDIMENTO'
      ' WHERE NVL(TIPOATTO,'#39' '#39') = NVL(:TIPO,'#39' '#39')'
      '   AND NUMATTO = :NUMERO')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A005400490050004F0005000000000000000000
      00000E0000003A004E0055004D00450052004F00050000000000000000000000}
    Left = 316
    Top = 160
  end
  object insSQL: TOracleQuery
    Optimize = False
    Left = 428
    Top = 156
  end
  object selSG095: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid from SG095_provvedimentodett t'
      'where progressivo = :PROG'
      '  and nomecampo = :CAMPO'
      '  and datadecor = :DATADEC'
      '  and dataregistr = :DATAREG'
      'order by numero')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A00500052004F00470003000000000000000000
      00000C0000003A00430041004D0050004F000500000000000000000000001000
      00003A0044004100540041004400450043000C00000000000000000000001000
      00003A0044004100540041005200450047000C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000700000016000000500052004F004700520045005300530049005600
      4F00010000000000120000004E004F004D004500430041004D0050004F000100
      000000001200000044004100540041004400450043004F005200010000000000
      1600000044004100540041005200450047004900530054005200010000000000
      0C0000004E0055004D00450052004F0001000000000016000000560041004C00
      4F00520045005F00500052004500430001000000000016000000560041004C00
      4F00520045005F005300550043004300010000000000}
    Left = 444
    Top = 8
    object selSG095PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selSG095NOMECAMPO: TStringField
      FieldName = 'NOMECAMPO'
      Required = True
      Visible = False
    end
    object selSG095DATADECOR: TDateTimeField
      FieldName = 'DATADECOR'
      Required = True
      Visible = False
    end
    object selSG095DATAREGISTR: TDateTimeField
      FieldName = 'DATAREGISTR'
      Required = True
      Visible = False
    end
    object selSG095NUMERO: TStringField
      DisplayLabel = 'Numero'
      FieldName = 'NUMERO'
      Required = True
      Size = 4
    end
    object selSG095DescNum: TStringField
      DisplayLabel = 'Descrizione'
      FieldKind = fkLookup
      FieldName = 'DescNum'
      LookupDataSet = selP660
      LookupKeyFields = 'NUMERO'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'NUMERO'
      Size = 100
      Lookup = True
    end
    object selSG095VALORE_PREC: TStringField
      DisplayLabel = 'Valore precedente'
      FieldName = 'VALORE_PREC'
      Size = 200
    end
    object selSG095VALORE_SUCC: TStringField
      DisplayLabel = 'Valore successivo'
      FieldName = 'VALORE_SUCC'
      Size = 200
    end
  end
  object selP660: TOracleDataSet
    SQL.Strings = (
      'select numero, descrizione, regola_calcolo_manuale '
      '  from P660_flussiregole p660'
      ' where nome_flusso = '#39'NPA'#39
      
        '   and decorrenza = (select max(decorrenza) from p660_flussirego' +
        'le'
      '                      where nome_flusso = '#39'NPA'#39
      '                        and numero = P660.numero'
      '                        and decorrenza <= :DEC)'
      ' order by numero')
    Optimize = False
    Variables.Data = {
      0400000001000000080000003A004400450043000C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000030000000C0000004E0055004D00450052004F000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000002C00
      00005200450047004F004C0041005F00430041004C0043004F004C004F005F00
      4D0041004E00550041004C004500010000000000}
    Left = 504
    Top = 8
    object selP660NUMERO: TStringField
      FieldName = 'NUMERO'
      Required = True
      Size = 4
    end
    object selP660DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 200
    end
    object selP660REGOLA_CALCOLO_MANUALE: TStringField
      FieldName = 'REGOLA_CALCOLO_MANUALE'
      Size = 4000
    end
  end
end
