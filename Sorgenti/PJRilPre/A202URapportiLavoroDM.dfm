inherited A202FRapportiLavoroDM: TA202FRapportiLavoroDM
  OldCreateOrder = True
  object selT425: TOracleDataSet
    SQL.Strings = (
      'select T425.*,T425.ROWID,'
      
        '       T450.CODICE||'#39' - '#39'||T450.DESCRIZIONE D_TIPORAPPORTO, T450' +
        '.TIPO,'
      
        '       T460.DESCRIZIONE D_PARTTIME, T460.TIPO TIPO_PT, T460.PIAN' +
        'TA PERC_PT'
      
        '  from T425_RAPPORTILAVORO_ALTRIENTI T425, T450_TIPORAPPORTO T45' +
        '0, T460_PARTTIME T460'
      ' where T425.PROGRESSIVO = :PROGRESSIVO'
      '   and T425.TIPORAPPORTO = T450.CODICE(+)'
      '   and T425.PARTTIME = T460.CODICE(+) '
      '   and T425.VALIDAZIONE in (:F_VAL)'
      ' order by T425.INIZIO'
      ''
      '/*select T425.*,ROWID'
      '  from T425_RAPPORTILAVORO_ALTRIENTI T425'
      ' where T425.PROGRESSIVO = :PROGRESSIVO'
      ' order by T425.INIZIO*/')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0046005F00560041004C00
      010000000000000000000000}
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
    BeforeInsert = selT425BeforeInsert
    AfterEdit = selT425AfterEdit
    BeforePost = BeforePostNoStorico
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    AfterDelete = AfterDelete
    OnCalcFields = selT425CalcFields
    OnNewRecord = selT425NewRecord
    Left = 24
    Top = 24
    object selT425PROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selT425VALIDAZIONE: TStringField
      DisplayLabel = 'Validato'
      DisplayWidth = 8
      FieldName = 'VALIDAZIONE'
      Visible = False
      OnValidate = selT425VALIDAZIONEValidate
      Size = 1
    end
    object selT425INIZIO: TDateTimeField
      DisplayLabel = 'Inizio rapporto'
      DisplayWidth = 11
      FieldName = 'INIZIO'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selT425FINE: TDateTimeField
      DisplayLabel = 'Fine rapporto'
      DisplayWidth = 11
      FieldName = 'FINE'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selT425ENTE: TStringField
      DisplayLabel = 'Ente'
      DisplayWidth = 8
      FieldName = 'ENTE'
      Size = 100
    end
    object selT425d_ENTE: TStringField
      DisplayLabel = 'Ente desc.'
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'd_ENTE'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'ENTE'
      Visible = False
      Size = 100
      Calculated = True
    end
    object selT425TIPORAPPORTO: TStringField
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
    object selT425TIPO: TStringField
      FieldName = 'TIPO'
      Visible = False
      Size = 1
    end
    object selT425d_TIPO: TStringField
      DisplayLabel = 'Tipologia'
      DisplayWidth = 15
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
      DisplayWidth = 20
      FieldName = 'd_PARTTIME'
      Visible = False
      Size = 40
    end
    object selT425PERC_PT: TFloatField
      DisplayLabel = '% Presenza'
      DisplayWidth = 12
      FieldName = 'PERC_PT'
      Visible = False
    end
    object selT425TIPO_PT: TStringField
      FieldName = 'TIPO_PT'
      Visible = False
      Size = 1
    end
    object selT425d_TIPOPT: TStringField
      DisplayLabel = 'Tipo part time'
      DisplayWidth = 15
      FieldKind = fkCalculated
      FieldName = 'd_TIPOPT'
      KeyFields = 'PARTTIME'
      Visible = False
      Size = 15
      Calculated = True
    end
    object selT425QUALIFICA: TStringField
      DisplayLabel = 'Qualifica'
      DisplayWidth = 10
      FieldName = 'QUALIFICA'
      Visible = False
      Size = 10
    end
    object selT425d_QUALIFICA: TStringField
      DisplayLabel = 'Qualifica desc.'
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'd_QUALIFICA'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'QUALIFICA'
      Visible = False
      Size = 100
      Calculated = True
    end
    object selT425DISCIPLINA: TStringField
      DisplayLabel = 'Disciplina'
      DisplayWidth = 10
      FieldName = 'DISCIPLINA'
      Visible = False
      Size = 10
    end
    object selT425d_DISCIPLINA: TStringField
      DisplayLabel = 'Diciplina desc.'
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'd_DISCIPLINA'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'DISCIPLINA'
      Visible = False
      Size = 100
      Calculated = True
    end
    object selT425NOTE: TStringField
      DisplayLabel = 'Note'
      DisplayWidth = 60
      FieldName = 'NOTE'
      Size = 2000
    end
  end
end
