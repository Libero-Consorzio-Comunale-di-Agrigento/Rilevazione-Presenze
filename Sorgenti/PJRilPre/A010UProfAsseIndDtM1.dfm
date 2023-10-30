object A010FProfAsseIndDtM1: TA010FProfAsseIndDtM1
  OldCreateOrder = True
  OnCreate = L007FProfAsseIndDtM1Create
  OnDestroy = A010FProfAsseIndDtM1Destroy
  Height = 144
  Width = 430
  object D260: TDataSource
    AutoEdit = False
    DataSet = Q260
    Left = 75
    Top = 8
  end
  object T263: TOracleDataSet
    SQL.Strings = (
      'SELECT T263.*,T263.ROWID '
      '  FROM T263_PROFASSIND T263'
      ' WHERE T263.PROGRESSIVO = :PROGRESSIVO '
      ' ORDER BY T263.DAL DESC, T263.AL DESC, T263.CODRAGGR')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000001900000016000000500052004F004700520045005300530049005600
      4F000100000000000800000041004E004E004F00010000000000100000004300
      4F004400520041004700470052000100000000000E00000055004D0049005300
      5500520041000100000000001600000043004F004D0050004500540045004E00
      5A00410031000100000000001A00000052004500540052004900420055005A00
      49004F004E00450031000100000000001600000043004F004D00500045005400
      45004E005A00410032000100000000001A000000520045005400520049004200
      55005A0049004F004E00450032000100000000001600000043004F004D005000
      4500540045004E005A00410033000100000000001A0000005200450054005200
      4900420055005A0049004F004E00450033000100000000001600000043004F00
      4D0050004500540045004E005A00410034000100000000001A00000052004500
      540052004900420055005A0049004F004E004500340001000000000016000000
      43004F004D0050004500540045004E005A00410035000100000000001A000000
      52004500540052004900420055005A0049004F004E0045003500010000000000
      1600000043004F004D0050004500540045004E005A0041003600010000000000
      1A00000052004500540052004900420055005A0049004F004E00450036000100
      000000001800000041004700470049004F0052004E004100420049004C004500
      0100000000000E00000044004100540041005200450053000100000000001800
      000044004500430055005200540041005A0049004F004E004500010000000000
      1C00000052004100500050004F005200540049005F0055004E00490054004900
      01000000000006000000440041004C000100000000000400000041004C000100
      00000000080000004E004F005400450001000000000022000000460041004D00
      49004C0049004100520045005F0044004100540041004E004100530001000000
      00001E000000560041005200490041005A005F00460045005200490045005300
      4F004C00010000000000}
    AfterInsert = T263AfterInsert
    BeforePost = T263BeforePost
    AfterPost = T263AfterPost
    BeforeDelete = T263BeforeDelete
    AfterDelete = T263AfterDelete
    OnNewRecord = T263NewRecord
    Left = 12
    Top = 8
    object T263Progressivo: TFloatField
      FieldName = 'Progressivo'
    end
    object T263Anno: TFloatField
      FieldName = 'Anno'
    end
    object T263CodRaggr: TStringField
      FieldName = 'CodRaggr'
      Required = True
      OnChange = T263CodRaggrChange
      Size = 5
    end
    object T263UMisura: TStringField
      FieldName = 'UMisura'
      Size = 1
    end
    object T263Competenza1: TStringField
      FieldName = 'Competenza1'
      OnValidate = BDET263Competenza1Validate
      EditMask = '!999.9;1;_'
      Size = 7
    end
    object T263Retribuzione1: TFloatField
      FieldName = 'Retribuzione1'
      MaxValue = 100.000000000000000000
    end
    object T263Competenza2: TStringField
      FieldName = 'Competenza2'
      OnValidate = BDET263Competenza1Validate
      EditMask = '!999.9;1;_'
      Size = 7
    end
    object T263Retribuzione2: TFloatField
      FieldName = 'Retribuzione2'
      MaxValue = 100.000000000000000000
    end
    object T263Competenza3: TStringField
      FieldName = 'Competenza3'
      OnValidate = BDET263Competenza1Validate
      EditMask = '!999.9;1;_'
      Size = 7
    end
    object T263Retribuzione3: TFloatField
      FieldName = 'Retribuzione3'
      MaxValue = 100.000000000000000000
    end
    object T263Competenza4: TStringField
      FieldName = 'Competenza4'
      OnValidate = BDET263Competenza1Validate
      EditMask = '!999.9;1;_'
      Size = 7
    end
    object T263Retribuzione4: TFloatField
      FieldName = 'Retribuzione4'
      MaxValue = 100.000000000000000000
    end
    object T263Competenza5: TStringField
      FieldName = 'Competenza5'
      OnValidate = BDET263Competenza1Validate
      EditMask = '!999.9;1;_'
      Size = 7
    end
    object T263Retribuzione5: TFloatField
      FieldName = 'Retribuzione5'
      MaxValue = 100.000000000000000000
    end
    object T263Competenza6: TStringField
      FieldName = 'Competenza6'
      OnValidate = BDET263Competenza1Validate
      EditMask = '!999.9;1;_'
      Size = 7
    end
    object T263Retribuzione6: TFloatField
      FieldName = 'Retribuzione6'
      MaxValue = 100.000000000000000000
    end
    object T263Aggiornabile: TStringField
      FieldName = 'Aggiornabile'
      Size = 1
    end
    object T263D_Raggruppamento: TStringField
      FieldKind = fkLookup
      FieldName = 'D_Raggruppamento'
      LookupDataSet = Q260
      LookupKeyFields = 'Codice'
      LookupResultField = 'Descrizione'
      KeyFields = 'CodRaggr'
      Size = 40
      Lookup = True
    end
    object T263DATARES: TDateTimeField
      DisplayLabel = 'Residuo'
      DisplayWidth = 10
      FieldName = 'DATARES'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object T263DECURTAZIONE: TStringField
      DisplayLabel = 'Variazione manuale'
      FieldName = 'DECURTAZIONE'
      OnValidate = BDET263Competenza1Validate
      EditMask = '!#90.9;1;_'
      Size = 7
    end
    object T263RAPPORTI_UNITI: TStringField
      DisplayLabel = 'Rapporti uniti'
      FieldName = 'RAPPORTI_UNITI'
      Size = 1
    end
    object T263Dal: TDateTimeField
      FieldName = 'Dal'
      EditMask = '!99/99/9999;1;_'
    end
    object T263Al: TDateTimeField
      FieldName = 'Al'
      EditMask = '!99/99/9999;1;_'
    end
    object T263Note: TStringField
      FieldName = 'Note'
      Size = 2000
    end
    object T263FAMILIARE_DATANAS: TDateTimeField
      DisplayLabel = 'Familiare'
      FieldName = 'FAMILIARE_DATANAS'
    end
    object T263VARIAZ_FERIESOL: TStringField
      DisplayLabel = 'Variazione ferie solidali'
      FieldName = 'VARIAZ_FERIESOL'
      OnValidate = BDET263Competenza1Validate
      EditMask = '!#90.9;1;_'
      Size = 7
    end
  end
  object Q260: TOracleDataSet
    SQL.Strings = (
      
        'select T260.CODICE,T260.DESCRIZIONE,T260.CONTASOLARE,max(T265.UM' +
        'ISURA) UMISURA'
      'from T260_RAGGRASSENZE T260, T265_CAUASSENZE T265'
      'where /*T260.CONTASOLARE = '#39'S'#39'*/ '
      
        'T260.CODICE in (select CODRAGGR from T265_CAUASSENZE where TIPOC' +
        'UMULO <> '#39'H'#39')'
      'and T260.CODICE = T265.CODRAGGR'
      'group by T260.CODICE,T260.DESCRIZIONE,T260.CONTASOLARE'
      'order by T260.CODICE')
    Optimize = False
    Filtered = True
    AfterOpen = Q260AfterOpen
    AfterScroll = Q260AfterScroll
    OnFilterRecord = Q260FilterRecord
    Left = 48
    Top = 8
  end
  object selT265: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T260.CODICE,T260.DESCRIZIONE,T260.CONTASOLARE, T265.TIPOC' +
        'UMULO'
      '  FROM T260_RAGGRASSENZE T260, T265_CAUASSENZE T265'
      ' WHERE T260.CODICE = T265.CODRAGGR'
      '   AND T265.TIPOCUMULO IN ('#39'A'#39','#39'M'#39','#39'N'#39','#39'P'#39','#39'Q'#39','#39'R'#39','#39'S'#39','#39'U'#39')'
      ' ORDER BY T260.CODICE')
    Optimize = False
    Left = 112
    Top = 7
  end
  object dsrSG101: TDataSource
    DataSet = selSG101
    Left = 210
    Top = 7
  end
  object selSG101: TOracleDataSet
    SQL.Strings = (
      
        'SELECT DISTINCT NVL(DATAADOZ,DATANAS) DATA,COGNOME || '#39' '#39' || NOM' +
        'E NOME, '
      
        '       NUMORD--'#39'<'#39'||replace(CAUSALI_ABILITATE,'#39','#39','#39'>,<'#39')||'#39'>'#39' CA' +
        'USALI_ABILITATE'
      'FROM SG101_FAMILIARI'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      '--AND GRADOPAR = '#39'FG'#39
      'ORDER BY 1,2')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Filtered = True
    Left = 162
    Top = 7
  end
end
