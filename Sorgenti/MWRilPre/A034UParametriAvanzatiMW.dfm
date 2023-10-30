inherited A034FParametriAvanzatiMW: TA034FParametriAvanzatiMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  object selP200: TOracleDataSet
    SQL.Strings = (
      'select distinct COD_VOCE, DESCRIZIONE '
      'from p200_voci t '
      'where TIPO NOT IN ('#39'IM'#39','#39'RI'#39','#39'RA'#39') '
      '  and COD_CONTRATTO = :CodContratto'
      '  and COD_VOCE_SPECIALE = '#39'BASE'#39
      
        '  and decorrenza = (select max(decorrenza) from p200_voci where ' +
        'cod_voce = t.cod_voce)'
      'order by COD_VOCE')
    Optimize = False
    Variables.Data = {
      04000000010000001A0000003A0043004F00440043004F004E00540052004100
      540054004F00050000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000020000001000000043004F0044005F0056004F004300450001000000
      0000160000004400450053004300520049005A0049004F004E00450001000000
      0000}
    Left = 80
    Top = 16
  end
  object insT193: TOracleQuery
    SQL.Strings = (
      'DECLARE'
      
        '  CURSOR C1 IS SELECT DISTINCT CODICE FROM T190_INTERFACCIAPAGHE' +
        ';'
      '  CURSOR C2 IS '
      '      SELECT VOCE_PAGHE FROM T190_INTERFACCIAPAGHE UNION'
      '      SELECT PORE_LAV FROM T210_MAGGIORAZIONI UNION'
      '      SELECT PIND_TUR FROM T210_MAGGIORAZIONI UNION'
      '      SELECT PSTR_NEL_MESE FROM T210_MAGGIORAZIONI UNION'
      '      SELECT PORE_LAV FROM T210_MAGGIORAZIONI UNION'
      '      SELECT PORE_COMP FROM T210_MAGGIORAZIONI UNION'
      '      SELECT VOCEPAGHE1 FROM T305_CAUGIUSTIF UNION '
      '      SELECT VOCEPAGHE2 FROM T305_CAUGIUSTIF UNION '
      '      SELECT VOCEPAGHE3 FROM T305_CAUGIUSTIF UNION '
      '      SELECT VOCEPAGHE4 FROM T305_CAUGIUSTIF UNION'
      '      SELECT VOCEPAGHE1 FROM T275_CAUPRESENZE UNION '
      '      SELECT VOCEPAGHE2 FROM T275_CAUPRESENZE UNION '
      '      SELECT VOCEPAGHE3 FROM T275_CAUPRESENZE UNION '
      '      SELECT VOCEPAGHE4 FROM T275_CAUPRESENZE UNION'
      '      SELECT VOCEPAGHELIQ1 FROM T275_CAUPRESENZE UNION '
      '      SELECT VOCEPAGHELIQ2 FROM T275_CAUPRESENZE UNION '
      '      SELECT VOCEPAGHELIQ3 FROM T275_CAUPRESENZE UNION '
      '      SELECT VOCEPAGHELIQ4 FROM T275_CAUPRESENZE UNION'
      '      SELECT VOCEPAGHE FROM T276_VOCIPAGHEPRESENZA UNION'
      '      SELECT VOCEPAGHE FROM T265_CAUASSENZE UNION'
      '      SELECT VOCEPAGHE FROM T162_INDENNITA UNION'
      '      --SELECT VOCEPAGHE FROM T760_REGOLEINCENTIVI UNION'
      '      SELECT VOCEPAGHE1 FROM T360_TERMENSA UNION '
      '      SELECT VOCEPAGHE2 FROM T360_TERMENSA UNION'
      
        '      SELECT DECODE(VP_TURNO,'#39'<SI>'#39',NULL,'#39'<NO>'#39',NULL,VP_TURNO) V' +
        'OCE_PAGHE FROM T350_REGREPERIB UNION'
      
        '      SELECT DECODE(VP_ORE,'#39'<SI>'#39',NULL,'#39'<NO>'#39',NULL,VP_ORE) VOCE_' +
        'PAGHE FROM T350_REGREPERIB UNION'
      
        '      SELECT DECODE(VP_MAGGIORATE,'#39'<SI>'#39',NULL,'#39'<NO>'#39',NULL,VP_MAG' +
        'GIORATE) VOCE_PAGHE FROM T350_REGREPERIB UNION'
      
        '      SELECT DECODE(VP_NONMAGGIORATE,'#39'<SI>'#39',NULL,'#39'<NO>'#39',NULL,VP_' +
        'NONMAGGIORATE) VOCE_PAGHE FROM T350_REGREPERIB UNION'
      '      SELECT CODICEVOCEPAGHE FROM M020_TIPIRIMBORSI UNION'
      
        '      SELECT CODICEVOCEPAGHEINDENNITASUPPL FROM M020_TIPIRIMBORS' +
        'I UNION'
      '      SELECT CODVOCEPAGHE FROM M021_TIPIINDENNITAKM UNION'
      
        '      SELECT CODVOCEPAGHEINTERA FROM M010_PARAMETRICONTEGGIO UNI' +
        'ON'
      
        '      SELECT CODVOCEPAGHESUPHH FROM M010_PARAMETRICONTEGGIO UNIO' +
        'N'
      
        '      SELECT CODVOCEPAGHESUPGG FROM M010_PARAMETRICONTEGGIO UNIO' +
        'N'
      
        '      SELECT CODVOCEPAGHESUPHHGG FROM M010_PARAMETRICONTEGGIO UN' +
        'ION'
      '      SELECT VOCEPAGHE_ESENTE FROM M065_TARIFFE_INDENNITA UNION'
      '      SELECT VOCEPAGHE_ASSOG FROM M065_TARIFFE_INDENNITA UNION'
      '      SELECT VOCEPAGHE FROM I011_DIZIONARIO_DATISCHEDA;'
      'NREC NUMBER;'
      'BEGIN'
      '  FOR T1 IN C1 LOOP'
      '    FOR T2 IN C2 LOOP '
      '      SELECT COUNT(*) INTO NREC FROM T193_VOCIPAGHE_PARAMETRI'
      
        '      WHERE COD_INTERFACCIA = T1.CODICE AND VOCE_PAGHE = T2.VOCE' +
        '_PAGHE;'
      '      IF (NREC = 0) AND (TRIM(T2.VOCE_PAGHE) IS NOT NULL) THEN'
      '        INSERT INTO T193_VOCIPAGHE_PARAMETRI '
      
        '        (COD_INTERFACCIA,VOCE_PAGHE,DECORRENZA,VOCE_PAGHE_CEDOLI' +
        'NO)'
      '        VALUES'
      
        '        (T1.CODICE,T2.VOCE_PAGHE,TO_DATE('#39'01011900'#39','#39'DDMMYYYY'#39'),' +
        'T2.VOCE_PAGHE);'
      '      END IF;'
      '    END LOOP;'
      '  END LOOP;'
      'END;')
    Optimize = False
    Left = 16
    Top = 16
  end
  object selInterfaccia: TOracleDataSet
    Optimize = False
    Left = 142
    Top = 16
  end
  object dsrInterfaccia: TDataSource
    DataSet = selInterfaccia
    Left = 128
    Top = 72
  end
end
