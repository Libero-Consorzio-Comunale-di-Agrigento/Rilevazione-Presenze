object W042FDatiConiugeDM: TW042FDatiConiugeDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 229
  Width = 580
  object selaSG101: TOracleDataSet
    SQL.Strings = (
      
        'SELECT NVL(DATAMAT,(SELECT MIN(DECORRENZA) FROM SG101_FAMILIARI ' +
        'SG101A WHERE SG101A.PROGRESSIVO = SG101.PROGRESSIVO AND SG101A.N' +
        'UMORD = SG101.NUMORD)) MIN_INI,'
      '       NVL(DATASEP,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) MAX_FIN'
      'FROM SG101_FAMILIARI SG101'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      'AND NUMORD <> :NUMORD'
      'AND GRADOPAR = '#39'CG'#39
      'AND TRUNC(SYSDATE) BETWEEN DECORRENZA AND DECORRENZA_FINE'
      'ORDER BY MAX_FIN DESC, MIN_INI DESC')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A004E0055004D004F005200
      4400030000000000000000000000}
    Left = 79
    Top = 16
  end
  object selT480: TOracleDataSet
    SQL.Strings = (
      'Select * from T480_Comuni '
      ':ORDERBY')
    ReadBuffer = 10000
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A004F0052004400450052004200590001000000
      0000000000000000}
    Left = 384
    Top = 16
    object selT480CODICE: TStringField
      DisplayLabel = 'Cod.ISTAT'
      DisplayWidth = 10
      FieldName = 'CODICE'
      Size = 6
    end
    object selT480CITTA: TStringField
      DisplayLabel = 'Comune'
      DisplayWidth = 60
      FieldName = 'CITTA'
      Size = 60
    end
    object selT480CAP: TStringField
      FieldName = 'CAP'
      Size = 5
    end
    object selT480PROVINCIA: TStringField
      DisplayLabel = 'Prov.'
      DisplayWidth = 5
      FieldName = 'PROVINCIA'
      Size = 2
    end
    object selT480CODCATASTALE: TStringField
      DisplayLabel = 'Cod.Catastale'
      DisplayWidth = 10
      FieldName = 'CODCATASTALE'
      Size = 4
    end
  end
  object dsrQ480: TDataSource
    DataSet = selT480
    Left = 384
    Top = 80
  end
  object selT040: TOracleDataSet
    SQL.Strings = (
      'SELECT count(*) N_GIUST'
      'FROM t040_giustificativi'
      'WHERE progressivo = :Progressivo'
      'AND datanas = :DataNascita')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000180000003A0044004100540041004E00
      4100530043004900540041000C0000000000000000000000}
    Left = 327
    Top = 16
  end
  object insSG120: TOracleQuery
    SQL.Strings = (
      'INSERT INTO sg120_familiaridipgen '
      '(progressivo, data_agg, conferma)'
      'VALUES '
      '(:progressivo, :data_agg, '#39'S'#39')')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000120000003A0044004100540041005F00
      4100470047000C0000000000000000000000}
    Left = 144
    Top = 80
  end
  object insSG122: TOracleQuery
    SQL.Strings = (
      'INSERT INTO sg122_familiaridipdet'
      
        '(progressivo, data_agg, tipo_fam, numord, cognome, nome, manca_c' +
        'oniuge, datanas, codfiscale, sesso, comnas, datamat, datasep, mo' +
        'tivo_esclusione)'
      'VALUES '
      
        '(:progressivo, :data_agg, '#39'CG'#39', :numord, :cognome, :nome, :manca' +
        '_coniuge, :datanas, :codfiscale, :sesso, :comnas, :datamat, :dat' +
        'asep, :motivo_esclusione)')
    Optimize = False
    Variables.Data = {
      040000000D000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000120000003A0044004100540041005F00
      4100470047000C00000000000000000000000E0000003A004E0055004D004F00
      52004400030000000000000000000000100000003A0043004F0047004E004F00
      4D0045000500000000000000000000000A0000003A004E004F004D0045000500
      00000000000000000000100000003A0044004100540041004E00410053000C00
      00000000000000000000160000003A0043004F00440046004900530043004100
      4C0045000500000000000000000000000C0000003A0053004500530053004F00
      0500000000000000000000000E0000003A0043004F004D004E00410053000500
      00000000000000000000100000003A0044004100540041004D00410054000C00
      00000000000000000000100000003A0044004100540041005300450050000C00
      00000000000000000000240000003A004D004F005400490056004F005F004500
      530043004C005500530049004F004E0045000500000000000000000000001C00
      00003A004D0041004E00430041005F0043004F004E0049005500470045000500
      00000000000000000000}
    Left = 200
    Top = 80
  end
  object selcSG101: TOracleDataSet
    SQL.Strings = (
      'SELECT nvl(max(numord),0) + 1 numord_new'
      'FROM sg101_familiari'
      'WHERE progressivo = :Progressivo')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Left = 207
    Top = 16
  end
  object scrSG101: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      '  IF :Inserimento = '#39'S'#39' THEN'
      '    INSERT INTO sg101_familiari'
      
        '    (Progressivo, NumOrd, Decorrenza, Cognome, Nome, ComNas, Dat' +
        'aNas, '
      
        '     GradoPar, DataMat, DataSep, Sesso, CodFiscale, Decorrenza_F' +
        'ine, '
      
        '     DataNas_Presunta, CapNas, Motivo_Esclusione, Inserimento_CU' +
        ')'
      '    VALUES'
      
        '    (:Progressivo, :NumOrd, :Decorrenza, :Cognome, :Nome, :ComNa' +
        's, :DataNas, '
      
        '     '#39'CG'#39', :DataMat, :DataSep, :Sesso, :CodFiscale, to_date('#39'311' +
        '23999'#39','#39'ddmmyyyy'#39'),'
      '     :DataNas, :CapNas, :Motivo_Esclusione, '#39'S'#39');'
      '  ELSE'
      '    UPDATE sg101_familiari'
      '    SET Cognome = :Cognome,'
      '        Nome = :Nome,'
      '        ComNas = :ComNas,'
      '        DataNas = :DataNas,'
      '        GradoPar = '#39'CG'#39','
      '        DataMat = :DataMat,'
      '        DataSep = :DataSep,'
      '        Sesso = :Sesso,'
      '        CodFiscale = :CodFiscale,'
      '        DataNas_Presunta = :DataNas,'
      '        CapNas = :CapNas,'
      '        Motivo_Esclusione = :Motivo_Esclusione,'
      '        Inserimento_CU = '#39'S'#39
      '    WHERE Progressivo = :Progressivo'
      '    AND NumOrd = :NumOrd;'
      '    --Anticipo la prima decorrenza, se necessario'
      '    UPDATE sg101_familiari'
      '    SET Decorrenza = LEAST(Decorrenza,:Decorrenza)'
      '    WHERE Progressivo = :Progressivo'
      '    AND NumOrd = :NumOrd'
      '    AND Decorrenza = (SELECT MIN(Decorrenza)'
      '                      FROM sg101_familiari'
      '                      WHERE Progressivo = :Progressivo'
      '                      AND NumOrd = :NumOrd);'
      '  END IF;'
      'END;')
    Optimize = False
    Variables.Data = {
      040000000E000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A004E0055004D004F005200
      4400030000000000000000000000160000003A004400450043004F0052005200
      45004E005A0041000C0000000000000000000000100000003A0043004F004700
      4E004F004D0045000500000000000000000000000A0000003A004E004F004D00
      45000500000000000000000000000E0000003A0043004F004D004E0041005300
      050000000000000000000000100000003A0044004100540041004E0041005300
      0C0000000000000000000000100000003A0044004100540041004D0041005400
      0C0000000000000000000000100000003A004400410054004100530045005000
      0C00000000000000000000000C0000003A0053004500530053004F0005000000
      0000000000000000160000003A0043004F004400460049005300430041004C00
      4500050000000000000000000000240000003A004D004F005400490056004F00
      5F004500530043004C005500530049004F004E00450005000000000000000000
      0000180000003A0049004E0053004500520049004D0045004E0054004F000500
      000000000000000000000E0000003A004300410050004E004100530005000000
      0000000000000000}
    Left = 80
    Top = 80
  end
  object selbSG101: TOracleDataSet
    SQL.Strings = (
      'SELECT decode(gradopar,'#39'NS'#39','#39'Nessuno/S'#232' stesso'#39','
      '                       '#39'CG'#39','#39'Coniuge'#39','
      '                       '#39'FG'#39','#39'Figlio/Figlia'#39','
      '                       '#39'GT'#39','#39'Genitore'#39','
      '                       '#39'FR'#39','#39'Fratello/Sorella'#39','
      '                       '#39'NP'#39','#39'Nipote'#39','
      '                       '#39'NF'#39','#39'Nipote equiparato Figlio'#39','
      '                       '#39'AL'#39','#39'Altro'#39','
      '                       '#39'AF'#39','#39'Affidato'#39') GRADO'
      'FROM sg101_familiari'
      'WHERE progressivo = :Progressivo'
      'AND codfiscale = :CodFiscale'
      'AND numord <> :NumOrd'
      'AND rownum < 2')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000160000003A0043004F00440046004900
      5300430041004C0045000500000000000000000000000E0000003A004E005500
      4D004F0052004400030000000000000000000000}
    Left = 143
    Top = 16
  end
  object selSG101: TOracleDataSet
    SQL.Strings = (
      'SELECT SG101.*, SG101.ROWID, '
      
        '       NVL(DATAMAT,(SELECT MIN(DECORRENZA) FROM SG101_FAMILIARI ' +
        'SG101A WHERE SG101A.PROGRESSIVO = SG101.PROGRESSIVO AND SG101A.N' +
        'UMORD = SG101.NUMORD)) MIN_INI,'
      '       NVL(DATASEP,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) MAX_FIN,'
      '       (SELECT MAX(DATA_AGG)'
      '        FROM SG122_FAMILIARIDIPDET SG122'
      '        WHERE SG122.PROGRESSIVO = SG101.PROGRESSIVO'
      '        AND SG122.NUMORD = SG101.NUMORD'
      '        AND SG122.TIPO_FAM = SG101.GRADOPAR'
      
        '        AND SG122.DATA_AGG > (SELECT NVL(MAX(DATA_AGG),TO_DATE('#39 +
        '01012016'#39','#39'DDMMYYYY'#39'))'
      '                              FROM SG122_FAMILIARIDIPDET SG122A'
      
        '                              WHERE SG122A.PROGRESSIVO = SG122.P' +
        'ROGRESSIVO'
      '                              AND SG122A.NUMORD = SG122.NUMORD'
      
        '                              AND SG122A.TIPO_FAM = SG122.TIPO_F' +
        'AM'
      
        '                              AND SG122A.MANCA_CONIUGE = '#39'S'#39')) D' +
        'ATA_REG,'
      '       DECODE(TIPO_DETRAZIONE,'#39'ND'#39','#39'N'#39','#39'S'#39') ACARICO_OGGI,'
      '       NVL((SELECT DISTINCT '#39'S'#39
      '        FROM SG101_FAMILIARI SG101B'
      '        WHERE SG101B.PROGRESSIVO = SG101.PROGRESSIVO'
      '        AND SG101B.NUMORD = SG101.NUMORD'
      '        AND SG101B.TIPO_DETRAZIONE <> '#39'ND'#39'),'#39'N'#39') ACARICO_STORIA,'
      '       NVL((SELECT DISTINCT '#39'S'#39
      '        FROM SG101_FAMILIARI SG101C'
      '        WHERE SG101C.PROGRESSIVO = SG101.PROGRESSIVO'
      '        AND SG101C.NUMORD = SG101.NUMORD'
      '        AND SG101C.COMPONENTE_ANF = '#39'S'#39'),'#39'N'#39') NUCLEO_STORIA,'
      '       NVL((SELECT DISTINCT '#39'S'#39
      '        FROM T040_GIUSTIFICATIVI T040'
      '        WHERE T040.PROGRESSIVO = SG101.PROGRESSIVO'
      '        AND T040.DATANAS = SG101.DATANAS),'#39'N'#39') GIUSTIFICATIVI'
      'FROM SG101_FAMILIARI SG101'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      'AND GRADOPAR = '#39'CG'#39
      'AND TRUNC(SYSDATE) BETWEEN DECORRENZA AND DECORRENZA_FINE'
      'ORDER BY MIN_INI DESC, MAX_FIN DESC')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000D00000016000000500052004F004700520045005300530049005600
      4F000100000000000E000000430041005500530041004C004500010000000000
      06000000440041004C000100000000000400000041004C000100000000001200
      00005400490050004F00470049005500530054000100000000001C0000004100
      550054004F00520049005A005A0041005A0049004F004E004500010000000000
      1800000052004500530050004F004E0053004100420049004C00450001000000
      00000E00000044004100540041004E0041005300010000000000120000004E00
      55004D00450052004F004F005200450001000000000004000000520049000100
      0000000010000000500055004C00530041004E00540045000100000000001200
      00004D00410054005200490043004F004C004100010000000000140000004E00
      4F004D0049004E0041005400490056004F00010000000000}
    OnCalcFields = selSG101CalcFields
    OnNewRecord = selSG101NewRecord
    Left = 14
    Top = 16
    object selSG101PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selSG101NUMORD: TFloatField
      FieldName = 'NUMORD'
      Visible = False
    end
    object selSG101GRADOPAR: TStringField
      FieldName = 'GRADOPAR'
      Visible = False
      Size = 2
    end
    object selSG101MATRICOLA: TStringField
      FieldName = 'MATRICOLA'
      Visible = False
      Size = 8
    end
    object selSG101COGNOME: TStringField
      DisplayLabel = 'Cognome (*)'
      FieldName = 'COGNOME'
      Size = 50
    end
    object selSG101NOME: TStringField
      DisplayLabel = 'Nome (*)'
      FieldName = 'NOME'
      Size = 50
    end
    object selSG101SESSO: TStringField
      DisplayLabel = 'Sesso (*)'
      FieldName = 'SESSO'
      Visible = False
      Size = 1
    end
    object selSG101DATANAS: TDateTimeField
      DisplayLabel = 'Data di nascita (*)'
      FieldName = 'DATANAS'
      Visible = False
    end
    object selSG101COMNAS: TStringField
      FieldName = 'COMNAS'
      Visible = False
      Size = 6
    end
    object selSG101D_COMUNE: TStringField
      DisplayLabel = 'Comune di nascita (*)'
      DisplayWidth = 15
      FieldKind = fkCalculated
      FieldName = 'D_COMUNE'
      Visible = False
      Size = 100
      Calculated = True
    end
    object selSG101D_PROVINCIA: TStringField
      DisplayLabel = 'Prov.'
      FieldKind = fkCalculated
      FieldName = 'D_PROVINCIA'
      Visible = False
      Size = 2
      Calculated = True
    end
    object selSG101CODFISCALE: TStringField
      DisplayLabel = 'Codice fiscale (*)'
      FieldName = 'CODFISCALE'
      Size = 16
    end
    object selSG101DATAMAT: TDateTimeField
      DisplayLabel = 'Data matrimonio (*)'
      FieldName = 'DATAMAT'
    end
    object selSG101DATASEP: TDateTimeField
      DisplayLabel = 'Fine matrimonio'
      FieldName = 'DATASEP'
    end
    object selSG101MOTIVO_ESCLUSIONE: TStringField
      DisplayLabel = 'Motivo'
      FieldName = 'MOTIVO_ESCLUSIONE'
      Visible = False
      Size = 1
    end
    object selSG101INSERIMENTO_CU: TStringField
      FieldName = 'INSERIMENTO_CU'
      Visible = False
      Size = 1
    end
    object selSG101MAX_FIN: TDateTimeField
      FieldKind = fkInternalCalc
      FieldName = 'MAX_FIN'
      Visible = False
    end
    object selSG101MIN_INI: TDateTimeField
      FieldKind = fkInternalCalc
      FieldName = 'MIN_INI'
      Visible = False
    end
    object selSG101DATA_REG: TDateTimeField
      DisplayLabel = 'Data ultima conferma'
      FieldKind = fkInternalCalc
      FieldName = 'DATA_REG'
    end
    object selSG101ACARICO_OGGI: TStringField
      FieldKind = fkInternalCalc
      FieldName = 'ACARICO_OGGI'
      Visible = False
      Size = 1
    end
    object selSG101ACARICO_STORIA: TStringField
      FieldKind = fkInternalCalc
      FieldName = 'ACARICO_STORIA'
      Visible = False
      Size = 1
    end
    object selSG101COMPONENTE_ANF: TStringField
      FieldName = 'COMPONENTE_ANF'
      Visible = False
      Size = 1
    end
    object selSG101NUCLEO_STORIA: TStringField
      FieldKind = fkInternalCalc
      FieldName = 'NUCLEO_STORIA'
      Visible = False
      Size = 1
    end
    object selSG101GIUSTIFICATIVI: TStringField
      FieldKind = fkInternalCalc
      FieldName = 'GIUSTIFICATIVI'
      Visible = False
      Size = 1
    end
    object selSG101ANOMALIE: TStringField
      FieldKind = fkCalculated
      FieldName = 'ANOMALIE'
      Visible = False
      Size = 200
      Calculated = True
    end
    object selSG101INFOW: TStringField
      FieldKind = fkCalculated
      FieldName = 'INFOW'
      Visible = False
      Size = 100
      Calculated = True
    end
    object selSG101INFOI: TStringField
      FieldKind = fkCalculated
      FieldName = 'INFOI'
      Visible = False
      Size = 100
      Calculated = True
    end
    object selSG101SITUAZIONE: TStringField
      FieldKind = fkCalculated
      FieldName = 'SITUAZIONE'
      Visible = False
      Size = 500
      Calculated = True
    end
    object selSG101INFOANOMALIE: TStringField
      FieldKind = fkCalculated
      FieldName = 'INFOANOMALIE'
      Visible = False
      Size = 500
      Calculated = True
    end
    object selSG101MESSAGGI: TStringField
      DisplayLabel = 'Messaggi'
      FieldKind = fkCalculated
      FieldName = 'MESSAGGI'
      Size = 1000
      Calculated = True
    end
  end
  object delSG101: TOracleQuery
    SQL.Strings = (
      'DELETE SG101_FAMILIARI'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      'AND NUMORD = :NUMORD')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A004E0055004D004F005200
      4400030000000000000000000000}
    Left = 16
    Top = 80
  end
end
