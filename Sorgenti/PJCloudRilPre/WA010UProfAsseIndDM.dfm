inherited WA010FProfAsseIndDM: TWA010FProfAsseIndDM
  Height = 194
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT '
      '  T263.*,'
      
        '  decode(T263.FAMILIARE_DATANAS,to_date('#39'30121899'#39','#39'ddmmyyyy'#39'),t' +
        'o_date(null),T263.FAMILIARE_DATANAS) C_FAMILIARE_DATANAS, '
      '  T263.ROWID '
      'FROM T263_PROFASSIND T263'
      'WHERE PROGRESSIVO = :PROGRESSIVO :ORDERBY')
    Variables.Data = {
      0400000002000000100000003A004F0052004400450052004200590001000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000001A00000016000000500052004F004700520045005300530049005600
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
      4F004C000100000000002600000043005F00460041004D0049004C0049004100
      520045005F0044004100540041004E0041005300010000000000}
    AfterPost = AfterPost
    AfterCancel = AfterCancel
    AfterDelete = AfterDelete
    OnNewRecord = OnNewRecord
    object selTabellaPROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selTabellaDAL: TDateTimeField
      DisplayLabel = 'Dal'
      DisplayWidth = 10
      FieldName = 'DAL'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/9999;1;_'
    end
    object selTabellaAL: TDateTimeField
      DisplayLabel = 'Al'
      DisplayWidth = 10
      FieldName = 'AL'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/9999;1;_'
    end
    object selTabellaCODRAGGR: TStringField
      DisplayLabel = 'Cod.ragg.'
      FieldName = 'CODRAGGR'
      Required = True
      Size = 5
    end
    object selTabellaD_RAGGRUPPAMENTO: TStringField
      DisplayLabel = 'Desc.raggr.'
      FieldKind = fkLookup
      FieldName = 'D_RAGGRUPPAMENTO'
      LookupDataSet = Q260
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CODRAGGR'
      Size = 40
      Lookup = True
    end
    object selTabellaFAMILIARE_DATANAS: TDateTimeField
      DisplayLabel = 'Familiare'
      FieldName = 'FAMILIARE_DATANAS'
      Required = True
      Visible = False
    end
    object selTabellaC_FAMILIARE_DATANAS: TDateTimeField
      DisplayLabel = 'Familiare'
      FieldKind = fkInternalCalc
      FieldName = 'C_FAMILIARE_DATANAS'
      ReadOnly = True
    end
    object selTabellaDATARES: TDateTimeField
      DisplayLabel = 'Residuo fruibile fino a'
      DisplayWidth = 10
      FieldName = 'DATARES'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaRAPPORTI_UNITI: TStringField
      DisplayLabel = 'Rapporti unificati'
      FieldName = 'RAPPORTI_UNITI'
      Visible = False
      Size = 1
    end
    object selTabellaUMISURA: TStringField
      DisplayLabel = 'Unit'#224' misura'
      FieldName = 'UMISURA'
      Size = 1
    end
    object selTabellaDECURTAZIONE: TStringField
      DisplayLabel = 'Variaz.manuale'
      FieldName = 'DECURTAZIONE'
      Size = 7
    end
    object selTabellaVARIAZ_FERIESOL: TStringField
      DisplayLabel = 'Variaz.ferie sol.'
      FieldName = 'VARIAZ_FERIESOL'
      Visible = False
      Size = 7
    end
    object selTabellaCOMPETENZA1: TStringField
      DisplayLabel = 'Competenza 1'
      FieldName = 'COMPETENZA1'
      Size = 7
    end
    object selTabellaRETRIBUZIONE1: TFloatField
      DisplayLabel = 'Retribuzione 1'
      FieldName = 'RETRIBUZIONE1'
      MaxValue = 100.000000000000000000
    end
    object selTabellaCOMPETENZA2: TStringField
      DisplayLabel = 'Competenza 2'
      FieldName = 'COMPETENZA2'
      Size = 7
    end
    object selTabellaRETRIBUZIONE2: TFloatField
      DisplayLabel = 'Retribuzione 2'
      FieldName = 'RETRIBUZIONE2'
      MaxValue = 100.000000000000000000
    end
    object selTabellaCOMPETENZA3: TStringField
      DisplayLabel = 'Competenza 3'
      FieldName = 'COMPETENZA3'
      Size = 7
    end
    object selTabellaRETRIBUZIONE3: TFloatField
      DisplayLabel = 'Retribuzione 3'
      FieldName = 'RETRIBUZIONE3'
      MaxValue = 100.000000000000000000
    end
    object selTabellaCOMPETENZA4: TStringField
      DisplayLabel = 'Competenza 4'
      FieldName = 'COMPETENZA4'
      Size = 7
    end
    object selTabellaRETRIBUZIONE4: TFloatField
      DisplayLabel = 'Retribuzione 4'
      FieldName = 'RETRIBUZIONE4'
      MaxValue = 100.000000000000000000
    end
    object selTabellaCOMPETENZA5: TStringField
      DisplayLabel = 'Competenza 5'
      FieldName = 'COMPETENZA5'
      Size = 7
    end
    object selTabellaRETRIBUZIONE5: TFloatField
      DisplayLabel = 'Retribuzione 5'
      FieldName = 'RETRIBUZIONE5'
      MaxValue = 100.000000000000000000
    end
    object selTabellaCOMPETENZA6: TStringField
      DisplayLabel = 'Competenza 6'
      FieldName = 'COMPETENZA6'
      Size = 7
    end
    object selTabellaRETRIBUZIONE6: TFloatField
      DisplayLabel = 'Retribuzione 6'
      FieldName = 'RETRIBUZIONE6'
      MaxValue = 100.000000000000000000
    end
    object selTabellaAGGIORNABILE: TStringField
      DisplayLabel = 'Aggiornabile'
      FieldName = 'AGGIORNABILE'
      Visible = False
      Size = 1
    end
    object selTabellaNOTE: TStringField
      DisplayLabel = 'Note'
      FieldName = 'NOTE'
      Visible = False
      Size = 2000
    end
  end
  object D260: TDataSource
    AutoEdit = False
    DataSet = Q260
    Left = 75
    Top = 128
  end
  object Q260: TOracleDataSet
    SQL.Strings = (
      
        'select T260.CODICE,T260.DESCRIZIONE,T260.CONTASOLARE,max(T265.UM' +
        'ISURA) UMISURA'
      'from T260_RAGGRASSENZE T260, T265_CAUASSENZE T265'
      'where /*(T260.CONTASOLARE = '#39'S'#39
      
        '       or T260.CODICE in (select CODRAGGR from T265_CAUASSENZE w' +
        'here TIPOCUMULO in ('#39'A'#39','#39'M'#39','#39'N'#39','#39'P'#39','#39'Q'#39','#39'R'#39','#39'S'#39','#39'U'#39')))'
      'and*/ T260.CODICE = T265.CODRAGGR'
      'group by T260.CODICE,T260.DESCRIZIONE,T260.CONTASOLARE'
      'order by T260.CODICE')
    Optimize = False
    Filtered = True
    Left = 32
    Top = 128
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
    Left = 120
    Top = 127
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
    Left = 178
    Top = 127
  end
end
