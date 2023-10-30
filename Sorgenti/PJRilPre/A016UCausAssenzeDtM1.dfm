object A016FCausAssenzeDtM1: TA016FCausAssenzeDtM1
  OldCreateOrder = True
  OnCreate = A016FCausAssenzeDtM1Create
  OnDestroy = A016FCausAssenzeDtM1Destroy
  Height = 104
  Width = 168
  object T265: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T265.*,T265.ROWID FROM T265_CAUASSENZE T265 ORDER BY CODI' +
        'CE')
    Optimize = False
    SequenceField.Field = 'ID'
    SequenceField.Sequence = 'T265_ID'
    SequenceField.ApplyMoment = amOnNewRecord
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000830000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000001000
      000043004F004400520041004700470052000100000000000E00000047004E00
      4F004E004C00410056000100000000001200000049004E0046004C0055004300
      4F004E00540001000000000012000000560041004C004F005200470049004F00
      52000100000000001600000049004E0046004C00550045004E005A0041005000
      4F000100000000000E00000049004E0044005000520045005300010000000000
      10000000450043004300450044004C0049005100010000000000120000004800
      4D0041005300530045004E005A00410001000000000012000000520041004700
      4700520053005400410054000100000000000C0000005300540041004D005000
      41000100000000001200000056004F0043004500500041004700480045000100
      000000001200000047005300490047004E004900460049004300010000000000
      100000004600520055004900420049004C004500010000000000140000004D00
      4100540055005200460045005200490045000100000000001200000041005600
      41004C00490044004100530053000100000000001800000048004D0041005800
      55004E00490054004100520049004F000100000000001800000047004D004100
      580055004E00490054004100520049004F000100000000000E00000055004D00
      490053005500520041000100000000001600000043004F004D00500045005400
      45004E005A00410031000100000000001A000000520045005400520049004200
      55005A0049004F004E00450031000100000000001600000043004F004D005000
      4500540045004E005A00410032000100000000001A0000005200450054005200
      4900420055005A0049004F004E00450032000100000000001600000043004F00
      4D0050004500540045004E005A00410033000100000000001A00000052004500
      540052004900420055005A0049004F004E004500330001000000000016000000
      43004F004D0050004500540045004E005A00410034000100000000001A000000
      52004500540052004900420055005A0049004F004E0045003400010000000000
      1600000043004F004D0050004500540045004E005A0041003500010000000000
      1A00000052004500540052004900420055005A0049004F004E00450035000100
      000000001600000043004F004D0050004500540045004E005A00410036000100
      000000001A00000052004500540052004900420055005A0049004F004E004500
      3600010000000000140000005400490050004F00430055004D0055004C004F00
      01000000000018000000440055005200410054004100430055004D0055004C00
      4F000100000000001000000055004D00430055004D0055004C004F0001000000
      00001000000047004D00430055004D0055004C004F0001000000000018000000
      43004F00440043004100550049004E0049005A0049004F000100000000000E00
      000043004F00440043004100550031000100000000000E00000043004F004400
      43004100550032000100000000000E00000043004F0044004300410055003300
      0100000000000E00000043004F00440043004100550034000100000000000E00
      000043004F00440043004100550035000100000000000E00000043004F004400
      43004100550036000100000000001200000046005200550049005A0049004F00
      4E0045000100000000001E000000440055005200410054004100460052005500
      49005A0049004F004E0045000100000000001600000055004D00460052005500
      49005A0049004F004E0045000100000000001E00000043004F00440043004100
      550046005200550049005A0049004F004E004500010000000000140000004400
      4500540052004500500045005200490042000100000000000E0000004F005200
      450053004500540054000100000000000E00000041005300530054004F004C00
      4C000100000000001A000000430055004D0055004C004F0047004C004F004200
      41004C00450001000000000018000000430041004D0050004F0047004C004F00
      420041004C0045000100000000001400000056004F0043004500500041004700
      4800450032000100000000001400000056004F00430045005000410047004800
      450033000100000000001400000056004F004300450050004100470048004500
      34000100000000001400000056004F0043004500500041004700480045003500
      0100000000001400000056004F00430045005000410047004800450036000100
      00000000140000005200490043004F005200530049004F004E00450001000000
      000012000000560041004C0053004500540049004D0042000100000000001E00
      000052004500430055005000450052004F004600450053005400490056004F00
      010000000000140000004500530043004C005500530049004F004E0045000100
      00000000180000005400490050004F0052004500430055005000450052004F00
      010000000000100000005000410052005400540049004D004500010000000000
      200000005400490050004F005F00500052004F0050004F0052005A0049004F00
      4E00450001000000000026000000500052004F0050004F0052005A0049004F00
      4E0041005F005000450052005300450052005600010000000000220000005400
      45004D0050004F005F00440045005400450052004D0049004E00410054004F00
      01000000000020000000430055004D0055004C004F005F00460041004D004900
      4C0049004100520049000100000000002600000046005200550049005A004900
      4F004E0045005F00460041004D0049004C004900410052004900010000000000
      200000004F00460046005300450054005F0046005200550049005A0049004F00
      4E0045000100000000001A00000041004C004C0055004E00470041005F005000
      52004F0056004100010000000000200000005200450047004900530054005200
      41005F00530054004F005200490043004F000100000000001C00000055004D00
      5F0049004E0053004500520049004D0045004E0054004F000100000000002800
      00004E004F005F00530055005000450052004F005F0043004F004D0050004500
      540045004E005A00450001000000000024000000440045005300430052004900
      5A0049004F004E0045005F004500530054004500530041000100000000001200
      000046005200550049005A005F004D0049004E00010000000000120000004600
      5200550049005A005F0041005200520001000000000020000000460052005500
      49005A005F004D00410058005F00440045004200490054004F00010000000000
      2600000046004C004500530053004900420049004C004900540041005F004F00
      52004100520049004F000100000000002200000055004D005F0049004E005300
      4500520049004D0045004E0054004F005F004D00470001000000000020000000
      55004D005F0049004E0053004500520049004D0045004E0054004F005F004800
      0100000000001C000000430051005F00500052004F0047005200450053005300
      490056004F0001000000000014000000430051005F0046004500530054004900
      5600490001000000000016000000430051005F00470047004E004F004E004C00
      410056000100000000002600000046005200550049005A0043004F004D005000
      4500540045004E005A0045005F00410052005200010000000000140000005000
      4500520043005F0049004E00410049004C000100000000002E00000049004E00
      540045005200530045005A0049004F004E0045005F00540049004D0042005200
      4100540055005200450001000000000030000000500052004F0050004F005200
      5A0049004F004E0041005F004100420049004C004900540041005A0049004F00
      4E00450001000000000018000000430050005F0044004F004D0045004E004900
      4300480045000100000000001C000000430050005F005000490041004E004900
      4600520045005000450052000100000000001C000000430050005F0046004500
      5300540047004900550053005400490046000100000000001C00000041004200
      420041005400540045005F0053005400520049004E0044000100000000002400
      0000430041005500530041004C0045005F005300550043004300450053005300
      4900560041000100000000000E000000540049004D0042005F0050004D000100
      000000001E000000430055004D0055004C004F005F005400490050004F005F00
      4F00520045000100000000001400000043004D005F0044004500420053004500
      5400540001000000000016000000560041004C004900440041005A0049004F00
      4E0045000100000000001C0000005600490053004900540041005F0046004900
      5300430041004C00450001000000000028000000530043004100520049004300
      4F00500041004700480045005F0055004D005F00500052004F00500001000000
      00001A00000050004500520049004F0044004F005F004C0055004E0047004F00
      0100000000001C00000043004F005000520049005F00470047004E004F004E00
      4C00410056000100000000001C00000052004100500050004F00520054004900
      5F0055004E004900540049000100000000001C0000004D004100540045005200
      4E004900540041005F004F00420042004C000100000000001C00000054004900
      4D0042005F0050004D005F00440045005400520041005A000100000000002000
      000055004D005F0049004E0053004500520049004D0045004E0054004F005F00
      44000100000000001200000046005200550049005A005F004D00410058000100
      0000000028000000430055004D0055004C0041005F0052004900430048004900
      45005300540045005F00570045004200010000000000300000004E004F005F00
      530055005000450052004F005F0043004F004D0050004500540045004E005A00
      45005F005700450042000100000000001E00000055004D005F00530043004100
      5200490043004F00500041004700480045000100000000002200000043005500
      4D0055004C004F005F00460041004D005F004700470044004F0050004F000100
      000000002800000046005200550049005A0049004F004E0045005F0046004100
      4D005F004700470044004F0050004F000100000000001000000047004C004100
      560049004E00500053000100000000001A00000046005200550049005A005F00
      4D00410058005F004E0055004D000100000000001C0000004700490055005300
      54005F004400410041005F00540049004D004200010000000000220000004400
      4500540052004500500045005200490042005F0054004F00540041004C004500
      0100000000003C00000041004C004C00410052004D0045005F00460052005500
      49005A0049004F004E0045005F0043004F004E00540049004E00550041005400
      4900560041000100000000003200000043004F004D0050004500540045004E00
      5A0045005F0050004500520053004F004E0041004C0049005A005A0041005400
      4500010000000000180000004100520052004F0054005F004F00520045003200
      470047000100000000001A0000005300490047004C0041005F00430041005500
      530041004C0045000100000000002E0000004100420042004100540054004500
      5F004700470053004500520056005F00540045004D0050004F00440045005400
      0100000000002A00000041004200420041005400540045005F00470047005600
      41004C005500540041005A0049004F004E0045000100000000002A0000005600
      4100520043004F004D0050005F0046005200550049005A004D004D0049004E00
      54004500520049000100000000002600000056004100520043004F004D005000
      5F0046005200550049005A004D004D0043004F004E0054000100000000001C00
      00004D004D0043004F004E0054005F0056004100520043004F004D0050000100
      000000003600000043004F004D00500049004E004400490056005F0043004F00
      4E0049005500470045005F004500530049005300540045004E00540045000100
      00000000200000004100520052004F0054005F0043004F004D00500045005400
      45004E005A0045000100000000002E0000004100550054004F00520049005A00
      5A005F004100550054004F004D00410054004900430041005F00570045004200
      0100000000001C0000004F0052004500470047005F004D00410058005F004900
      4E00460036000100000000001C0000004F0052004500470047005F004D004100
      58005F0053005500500036000100000000002000000043004F00500052004500
      5F004600410053004300490041005F004F004200420001000000000012000000
      500052004F005000500054005600470047000100000000003A00000050004500
      520049004F0044004F005F00430055004D0055004C004F005F00500045005200
      53004F004E0041004C0049005A005A00410054004F00010000000000}
    Filtered = True
    BeforePost = T265BeforePost
    AfterPost = T265AfterPost
    BeforeCancel = T265BeforeCancel
    BeforeDelete = T265BeforeDelete
    AfterDelete = T265AfterDelete
    AfterScroll = T265AfterScroll
    OnFilterRecord = T265FilterRecord
    OnNewRecord = T265NewRecord
    Left = 16
    Top = 12
    object T265Codice: TStringField
      DisplayWidth = 6
      FieldName = 'Codice'
      Required = True
      Size = 5
    end
    object T265Descrizione: TStringField
      FieldName = 'Descrizione'
      Required = True
      Size = 40
    end
    object T265CodRaggr: TStringField
      FieldName = 'CodRaggr'
      Required = True
      OnChange = BDET265CodRaggrChange
      Size = 5
    end
    object T265GNonLav: TStringField
      FieldName = 'GNonLav'
      Required = True
      Size = 1
    end
    object T265InfluCont: TStringField
      FieldName = 'InfluCont'
      Required = True
      OnChange = T265InfluContChange
      Size = 1
    end
    object T265ValorGior: TStringField
      FieldName = 'ValorGior'
      ReadOnly = True
      Required = True
      Size = 1
    end
    object T265InfluenzaPO: TStringField
      FieldName = 'InfluenzaPO'
      Required = True
      Size = 1
    end
    object T265Indpres: TStringField
      FieldName = 'Indpres'
      Required = True
      Size = 1
    end
    object T265EccedLiq: TStringField
      FieldName = 'EccedLiq'
      Required = True
      Size = 1
    end
    object T265HMAssenza: TDateTimeField
      FieldName = 'HMAssenza'
      LookupDataSet = A016FCausAssenzeMW.Q260
      ReadOnly = True
      OnGetText = T265HMAssenzaGetText
      DisplayFormat = 'hh:nn'
      EditMask = '!90:00;1;_'
    end
    object T265RaggrStat: TStringField
      FieldName = 'RaggrStat'
      Required = True
      Size = 1
    end
    object T265Stampa: TStringField
      FieldName = 'Stampa'
      Required = True
      Size = 1
    end
    object T265VocePaghe: TStringField
      DisplayLabel = 'Codice voce paghe'
      FieldName = 'VocePaghe'
      Size = 10
    end
    object T265VOCEPAGHE2: TStringField
      DisplayLabel = 'Codice aggiuntivo paghe'
      FieldName = 'VOCEPAGHE2'
      Size = 10
    end
    object T265GSignific: TStringField
      FieldName = 'GSignific'
      Size = 2
    end
    object T265Fruibile: TStringField
      FieldName = 'Fruibile'
      Size = 1
    end
    object T265MaturFerie: TStringField
      FieldName = 'MaturFerie'
      Size = 1
    end
    object T265AValidAss: TFloatField
      FieldName = 'AValidAss'
    end
    object T265HMaxUnitario: TStringField
      FieldName = 'HMaxUnitario'
      OnValidate = BDET265HMaxUnitarioValidate
      EditMask = '!9990.00;1;_'
      Size = 7
    end
    object T265GMaxUnitario: TStringField
      FieldName = 'GMaxUnitario'
      OnValidate = BDET265GMaxUnitarioValidate
      EditMask = '!9990,9;1;_'
      Size = 6
    end
    object T265UMisura: TStringField
      FieldName = 'UMisura'
      Size = 1
    end
    object T265Competenza1: TStringField
      FieldName = 'Competenza1'
      OnValidate = BDET265Competenza1Validate
      EditMask = '!990.9;1;_'
      Size = 7
    end
    object T265Retribuzione1: TFloatField
      FieldName = 'Retribuzione1'
      MaxValue = 100.000000000000000000
    end
    object T265Competenza2: TStringField
      FieldName = 'Competenza2'
      OnValidate = BDET265Competenza1Validate
      EditMask = '!990.9;1;_'
      Size = 7
    end
    object T265Retribuzione2: TFloatField
      FieldName = 'Retribuzione2'
      MaxValue = 100.000000000000000000
    end
    object T265Competenza3: TStringField
      FieldName = 'Competenza3'
      OnValidate = BDET265Competenza1Validate
      EditMask = '!990.9;1;_'
      Size = 7
    end
    object T265Retribuzione3: TFloatField
      FieldName = 'Retribuzione3'
      MaxValue = 100.000000000000000000
    end
    object T265Competenza4: TStringField
      FieldName = 'Competenza4'
      OnValidate = BDET265Competenza1Validate
      EditMask = '!990.9;1;_'
      Size = 7
    end
    object T265Retribuzione4: TFloatField
      FieldName = 'Retribuzione4'
      MaxValue = 100.000000000000000000
    end
    object T265Competenza5: TStringField
      FieldName = 'Competenza5'
      OnValidate = BDET265Competenza1Validate
      EditMask = '!990.9;1;_'
      Size = 7
    end
    object T265Retribuzione5: TFloatField
      FieldName = 'Retribuzione5'
      MaxValue = 100.000000000000000000
    end
    object T265Competenza6: TStringField
      FieldName = 'Competenza6'
      OnValidate = BDET265Competenza1Validate
      EditMask = '!990.9;1;_'
      Size = 7
    end
    object T265Retribuzione6: TFloatField
      FieldName = 'Retribuzione6'
      MaxValue = 100.000000000000000000
    end
    object T265TipoCumulo: TStringField
      FieldName = 'TipoCumulo'
      Required = True
      Size = 1
    end
    object T265DurataCumulo: TFloatField
      FieldName = 'DurataCumulo'
    end
    object T265UMCumulo: TStringField
      FieldName = 'UMCumulo'
      Size = 1
    end
    object T265GMCumulo: TStringField
      DisplayWidth = 5
      FieldName = 'GMCumulo'
      OnValidate = BDET265GMCumuloValidate
      EditMask = '!99/99;1;_'
      Size = 5
    end
    object T265CodCauInizio: TStringField
      FieldName = 'CodCauInizio'
      OnValidate = BDET265CodCauInizioValidate
      Size = 5
    end
    object T265CodCau1: TStringField
      DisplayWidth = 20
      FieldName = 'CodCau1'
      Size = 1000
    end
    object T265CODCAU2: TStringField
      FieldName = 'CODCAU2'
      Size = 1000
    end
    object T265Fruizione: TStringField
      FieldName = 'Fruizione'
      Size = 1
    end
    object T265DurataFruizione: TFloatField
      FieldName = 'DurataFruizione'
    end
    object T265UMFruizione: TStringField
      FieldName = 'UMFruizione'
      Size = 1
    end
    object T265CodCauFruizione: TStringField
      FieldName = 'CodCauFruizione'
      Size = 5
    end
    object T265D_Raggruppamento: TStringField
      FieldKind = fkLookup
      FieldName = 'D_Raggruppamento'
      LookupDataSet = A016FCausAssenzeMW.Q260
      LookupKeyFields = 'Codice'
      LookupResultField = 'Descrizione'
      KeyFields = 'CodRaggr'
      Size = 40
      Lookup = True
    end
    object T265D_CodCauInizio: TStringField
      FieldKind = fkLookup
      FieldName = 'D_CodCauInizio'
      LookupDataSet = A016FCausAssenzeMW.Q265A
      LookupKeyFields = 'Codice'
      LookupResultField = 'Descrizione'
      KeyFields = 'CodCauInizio'
      Size = 40
      Lookup = True
    end
    object T265D_CodCauFruizione: TStringField
      FieldKind = fkLookup
      FieldName = 'D_CodCauFruizione'
      LookupDataSet = A016FCausAssenzeMW.Q265A
      LookupKeyFields = 'Codice'
      LookupResultField = 'Descrizione'
      KeyFields = 'CodCauFruizione'
      Size = 40
      Lookup = True
    end
    object T265DETREPERIB: TStringField
      FieldName = 'DETREPERIB'
      Size = 1
    end
    object T265ORESETT: TStringField
      FieldName = 'ORESETT'
      OnValidate = BDET265ORESETTValidate
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object T265ASSTOLL: TStringField
      FieldName = 'ASSTOLL'
      Size = 200
    end
    object T265CUMULOGLOBALE: TStringField
      FieldName = 'CUMULOGLOBALE'
      Size = 1
    end
    object T265CAMPOGLOBALE: TStringField
      FieldName = 'CAMPOGLOBALE'
    end
    object T265RICORSIONE: TStringField
      FieldName = 'RICORSIONE'
      Size = 1
    end
    object T265VALSETIMB: TStringField
      FieldName = 'VALSETIMB'
      Size = 1
    end
    object T265RECUPEROFESTIVO: TStringField
      FieldName = 'RECUPEROFESTIVO'
      Size = 1
    end
    object T265ESCLUSIONE: TStringField
      FieldName = 'ESCLUSIONE'
      Size = 1
    end
    object T265TIPORECUPERO: TStringField
      FieldName = 'TIPORECUPERO'
      Size = 2
    end
    object T265PARTTIME: TStringField
      FieldName = 'PARTTIME'
      Size = 3
    end
    object T265TIPO_PROPORZIONE: TStringField
      FieldName = 'TIPO_PROPORZIONE'
      Size = 1
    end
    object T265PROPORZIONA_PERSERV: TStringField
      FieldName = 'PROPORZIONA_PERSERV'
      Size = 1
    end
    object T265TEMPO_DETERMINATO: TStringField
      FieldName = 'TEMPO_DETERMINATO'
      Size = 1
    end
    object T265CUMULO_FAMILIARI: TStringField
      FieldName = 'CUMULO_FAMILIARI'
      Size = 1
    end
    object T265FRUIZIONE_FAMILIARI: TStringField
      FieldName = 'FRUIZIONE_FAMILIARI'
      Size = 1
    end
    object T265OFFSET_FRUIZIONE: TIntegerField
      FieldName = 'OFFSET_FRUIZIONE'
    end
    object T265ALLUNGA_PROVA: TStringField
      FieldName = 'ALLUNGA_PROVA'
      Size = 1
    end
    object T265REGISTRA_STORICO: TStringField
      FieldName = 'REGISTRA_STORICO'
      Size = 1
    end
    object T265UM_INSERIMENTO: TStringField
      FieldName = 'UM_INSERIMENTO'
      Size = 1
    end
    object T265NO_SUPERO_COMPETENZE: TStringField
      FieldName = 'NO_SUPERO_COMPETENZE'
      Size = 1
    end
    object T265DESCRIZIONE_ESTESA: TStringField
      DisplayWidth = 50
      FieldName = 'Descrizione_estesa'
      Size = 200
    end
    object T265FRUIZ_MIN_COMP: TStringField
      FieldName = 'FRUIZ_MIN_COMP'
      OnValidate = T265FRUIZ_MINValidate
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object T265FRUIZ_MIN: TStringField
      FieldName = 'FRUIZ_MIN'
      OnValidate = T265FRUIZ_MINValidate
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object T265FRUIZ_MAX: TStringField
      FieldName = 'FRUIZ_MAX'
      OnValidate = T265FRUIZ_MINValidate
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object T265FRUIZ_ARR: TStringField
      FieldName = 'FRUIZ_ARR'
      OnValidate = T265FRUIZ_MINValidate
      EditMask = '!#0:00;1;_'
      Size = 5
    end
    object T265FRUIZ_MAX_DEBITO: TStringField
      FieldName = 'FRUIZ_MAX_DEBITO'
      Size = 1
    end
    object T265FLESSIBILITA_ORARIO: TStringField
      FieldName = 'FLESSIBILITA_ORARIO'
      Size = 1
    end
    object T265UM_INSERIMENTO_MG: TStringField
      FieldName = 'UM_INSERIMENTO_MG'
      Size = 1
    end
    object T265UM_INSERIMENTO_H: TStringField
      FieldName = 'UM_INSERIMENTO_H'
      Size = 1
    end
    object T265CQ_PROGRESSIVO: TStringField
      FieldName = 'CQ_PROGRESSIVO'
      Size = 1
    end
    object T265CQ_FESTIVI: TStringField
      FieldName = 'CQ_FESTIVI'
      Size = 1
    end
    object T265CQ_GGNONLAV: TStringField
      FieldName = 'CQ_GGNONLAV'
      Size = 1
    end
    object T265FRUIZCOMPETENZE_ARR: TStringField
      DisplayWidth = 1
      FieldName = 'FRUIZCOMPETENZE_ARR'
      Size = 1
    end
    object T265D_VOCEPAGHE: TStringField
      Tag = 1999
      FieldKind = fkLookup
      FieldName = 'D_VOCEPAGHE'
      LookupDataSet = A016FCausAssenzeMW.selP200
      LookupKeyFields = 'COD_VOCE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'VocePaghe'
      Size = 100
      Lookup = True
    end
    object T265PERC_INAIL: TFloatField
      FieldName = 'PERC_INAIL'
      MaxValue = 100.000000000000000000
    end
    object T265INTERSEZIONE_TIMBRATURE: TStringField
      FieldName = 'INTERSEZIONE_TIMBRATURE'
      Size = 1
    end
    object T265PROPORZIONA_ABILITAZIONE: TStringField
      FieldName = 'PROPORZIONA_ABILITAZIONE'
      Size = 1
    end
    object T265CP_DOMENICHE: TStringField
      FieldName = 'CP_DOMENICHE'
      Size = 1
    end
    object T265CP_PIANIFREPER: TStringField
      FieldName = 'CP_PIANIFREPER'
      Size = 1
    end
    object T265CP_FESTGIUSTIF: TStringField
      FieldName = 'CP_FESTGIUSTIF'
      Size = 1
    end
    object T265ABBATTE_STRIND: TStringField
      FieldName = 'ABBATTE_STRIND'
      Size = 1
    end
    object T265CAUSALE_SUCCESSIVA: TStringField
      FieldName = 'CAUSALE_SUCCESSIVA'
      Size = 5
    end
    object T265D_CAUSALE_SUCCESSIVA2: TStringField
      FieldKind = fkLookup
      FieldName = 'D_CAUSALE_SUCCESSIVA'
      LookupDataSet = A016FCausAssenzeMW.Q265A
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAUSALE_SUCCESSIVA'
      Size = 40
      Lookup = True
    end
    object T265D_CODCAU3: TStringField
      FieldKind = fkLookup
      FieldName = 'D_CODCAU3'
      LookupDataSet = A016FCausAssenzeMW.Q265A
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CODCAU3'
      Size = 40
      Lookup = True
    end
    object T265TIMB_PM: TStringField
      FieldName = 'TIMB_PM'
      OnChange = BDET265CodCauInizioValidate
      Size = 1
    end
    object T265CUMULO_TIPO_ORE: TStringField
      FieldName = 'CUMULO_TIPO_ORE'
      Size = 1
    end
    object T265CM_DEBSETT: TStringField
      FieldName = 'CM_DEBSETT'
      OnValidate = T265CM_DEBSETTValidate
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object T265VALIDAZIONE: TStringField
      FieldName = 'VALIDAZIONE'
      Size = 1
    end
    object T265CODCAU3: TStringField
      FieldName = 'CODCAU3'
      Size = 5
    end
    object T265VISITA_FISCALE: TStringField
      FieldName = 'VISITA_FISCALE'
      Size = 1
    end
    object T265SCARICOPAGHE_UM_PROP: TStringField
      FieldName = 'SCARICOPAGHE_UM_PROP'
      Size = 1
    end
    object T265PERIODO_LUNGO: TStringField
      FieldName = 'PERIODO_LUNGO'
      Size = 1
    end
    object T265COPRI_GGNONLAV: TStringField
      FieldName = 'COPRI_GGNONLAV'
      Size = 1
    end
    object T265RAPPORTI_UNITI: TStringField
      FieldName = 'RAPPORTI_UNITI'
      Size = 1
    end
    object T265MATERNITA_OBBL: TStringField
      FieldName = 'MATERNITA_OBBL'
      Size = 1
    end
    object T265TIMB_PM_DETRAZ: TStringField
      FieldName = 'TIMB_PM_DETRAZ'
      Size = 1
    end
    object T265UM_INSERIMENTO_D: TStringField
      FieldName = 'UM_INSERIMENTO_D'
      Size = 1
    end
    object T265CUMULA_RICHIESTE_WEB: TStringField
      FieldName = 'CUMULA_RICHIESTE_WEB'
      Size = 1
    end
    object T265UM_SCARICOPAGHE: TStringField
      FieldName = 'UM_SCARICOPAGHE'
      Size = 1
    end
    object T265CUMULO_FAM_GGDOPO: TStringField
      FieldName = 'CUMULO_FAM_GGDOPO'
      Size = 1
    end
    object T265FRUIZIONE_FAM_GGDOPO: TStringField
      FieldName = 'FRUIZIONE_FAM_GGDOPO'
      Size = 1
    end
    object T265GLAVINPS: TStringField
      FieldName = 'GLAVINPS'
      Size = 1
    end
    object T265FRUIZ_MAX_NUM: TIntegerField
      FieldName = 'FRUIZ_MAX_NUM'
      MaxValue = 9999
    end
    object T265ALLARME_FRUIZIONE_CONTINUATIVA: TIntegerField
      FieldName = 'ALLARME_FRUIZIONE_CONTINUATIVA'
    end
    object T265DETREPERIB_TOTALE: TStringField
      FieldName = 'DETREPERIB_TOTALE'
      Size = 1
    end
    object T265NO_SUPERO_COMPETENZE_WEB: TStringField
      FieldName = 'NO_SUPERO_COMPETENZE_WEB'
      Size = 1
    end
    object T265COMPETENZE_PERSONALIZZATE: TStringField
      FieldName = 'COMPETENZE_PERSONALIZZATE'
      Size = 1
    end
    object T265ARROT_ORE2GG: TStringField
      FieldName = 'ARROT_ORE2GG'
      Size = 1
    end
    object T265SIGLA_CAUSALE: TStringField
      FieldName = 'SIGLA_CAUSALE'
      Size = 5
    end
    object T265ABBATTE_GGSERV_TEMPODET: TStringField
      FieldName = 'ABBATTE_GGSERV_TEMPODET'
      Size = 1
    end
    object T265ABBATTE_GGVALUTAZIONE: TStringField
      FieldName = 'ABBATTE_GGVALUTAZIONE'
      Size = 1
    end
    object T265VARCOMP_FRUIZMMINTERI: TStringField
      FieldName = 'VARCOMP_FRUIZMMINTERI'
      Size = 1
    end
    object T265VARCOMP_FRUIZMMCONT: TIntegerField
      FieldName = 'VARCOMP_FRUIZMMCONT'
      MaxValue = 999
    end
    object T265MMCONT_VARCOMP: TIntegerField
      FieldName = 'MMCONT_VARCOMP'
      MaxValue = 999
    end
    object T265COMPINDIV_CONIUGE_ESISTENTE: TIntegerField
      FieldName = 'COMPINDIV_CONIUGE_ESISTENTE'
      MaxValue = 999
    end
    object T265ARROT_COMPETENZE: TStringField
      FieldName = 'ARROT_COMPETENZE'
      Size = 1
    end
    object T265VOCEPAGHE3: TStringField
      FieldName = 'VOCEPAGHE3'
      Size = 10
    end
    object T265VOCEPAGHE4: TStringField
      FieldName = 'VOCEPAGHE4'
      Size = 10
    end
    object T265VOCEPAGHE5: TStringField
      FieldName = 'VOCEPAGHE5'
      Size = 10
    end
    object T265VOCEPAGHE6: TStringField
      FieldName = 'VOCEPAGHE6'
      Size = 10
    end
    object T265OREGG_MAX_INF6: TStringField
      FieldName = 'OREGG_MAX_INF6'
      OnValidate = T265FRUIZ_MINValidate
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object T265OREGG_MAX_SUP6: TStringField
      FieldName = 'OREGG_MAX_SUP6'
      OnValidate = T265FRUIZ_MINValidate
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object T265COPRE_FASCIA_OBB: TStringField
      FieldName = 'COPRE_FASCIA_OBB'
      Size = 1
    end
    object T265PERIODO_CUMULO_PERSONALIZZATO: TStringField
      FieldName = 'PERIODO_CUMULO_PERSONALIZZATO'
      Size = 1
    end
    object T265PROPPTVGG: TStringField
      FieldName = 'PROPPTVGG'
      Size = 1
    end
    object T265CT_MANTIENI_RESIDNEG: TStringField
      FieldName = 'CT_MANTIENI_RESIDNEG'
      Size = 1
    end
    object T265ITER_ECCGG: TStringField
      FieldName = 'ITER_ECCGG'
      Size = 1
    end
    object T265FRUIZGG_NEUTRA: TStringField
      FieldName = 'FRUIZGG_NEUTRA'
      Size = 1
    end
    object T265ITER_IGNORA_FINERAPPORTO: TStringField
      FieldName = 'ITER_IGNORA_FINERAPPORTO'
      Size = 1
    end
    object T265ID: TIntegerField
      Tag = -1
      FieldName = 'ID'
    end
    object T265CAUSALI_CUMULO_L133: TStringField
      FieldName = 'CAUSALI_CUMULO_L133'
      Size = 2000
    end
  end
end