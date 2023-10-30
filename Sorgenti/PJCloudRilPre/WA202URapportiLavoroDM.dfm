inherited WA202FRapportiLavoroDM: TWA202FRapportiLavoroDM
  inherited selTabella: TOracleDataSet
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
      '       :ORDERBY'
      ''
      '/*select T425.*,ROWID'
      '  from T425_RAPPORTILAVORO_ALTRIENTI T425'
      ' where T425.PROGRESSIVO = :PROGRESSIVO'
      ' :ORDERBY*/')
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000500000002000000310000000000100000003A004F00520044004500
      52004200590001000000150000006F7264657220627920543432352E494E495A
      494F00000000000C0000003A0046005F00560041004C00010000000000000000
      000000}
    QBEDefinition.QBEFieldDefs = {
      050000000600000016000000500052004F004700520045005300530049005600
      4F000100000000000C00000049004E0049005A0049004F000100000000000800
      0000460049004E004500010000000000180000005400490050004F0052004100
      500050004F00520054004F000100000000000800000045004E00540045000100
      00000000080000004E004F0054004500010000000000}
    AfterEdit = selTabellaAfterEdit
    AfterPost = AfterPost
    AfterDelete = AfterDelete
    OnCalcFields = selTabellaCalcFields
    OnNewRecord = OnNewRecord
    object selTabellaPROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selTabellaVALIDAZIONE: TStringField
      Alignment = taCenter
      DisplayLabel = 'Validato'
      FieldName = 'VALIDAZIONE'
      Visible = False
      Size = 1
    end
    object selTabellaINIZIO: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Inizio rapporto'
      DisplayWidth = 10
      FieldName = 'INIZIO'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaFINE: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Fine rapporto'
      DisplayWidth = 10
      FieldName = 'FINE'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaENTE: TStringField
      DisplayLabel = 'Ente'
      DisplayWidth = 30
      FieldName = 'ENTE'
      Size = 100
    end
    object selTabellad_ENTE: TStringField
      DisplayLabel = 'Ente desc.'
      FieldKind = fkCalculated
      FieldName = 'd_ENTE'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'ENTE'
      Visible = False
      Size = 100
      Calculated = True
    end
    object selTabellaTIPORAPPORTO: TStringField
      DisplayLabel = 'Tipo rapporto'
      FieldName = 'TIPORAPPORTO'
      Size = 5
    end
    object selTabellad_TIPORAPPORTO: TStringField
      DisplayLabel = 'Tipo rapporto'
      DisplayWidth = 30
      FieldName = 'd_TIPORAPPORTO'
      Size = 60
    end
    object selTabellaTIPO: TStringField
      FieldName = 'TIPO'
      Visible = False
      Size = 1
    end
    object selTabellad_TIPO: TStringField
      DisplayLabel = 'Tipologia'
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'd_TIPO'
      Size = 50
      Calculated = True
    end
    object selTabellaPARTTIME: TStringField
      DisplayLabel = 'Part time'
      FieldName = 'PARTTIME'
      Visible = False
      Size = 5
    end
    object selTabellad_PARTTIME: TStringField
      DisplayLabel = 'Part time'
      FieldKind = fkCalculated
      FieldName = 'd_PARTTIME'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'PARTTIME'
      Visible = False
      Size = 40
      Calculated = True
    end
    object selTabellaPERC_PT: TFloatField
      DisplayLabel = '% Presenza'
      FieldName = 'PERC_PT'
      Visible = False
    end
    object selTabellaTIPO_PT: TStringField
      FieldName = 'TIPO_PT'
      Visible = False
      Size = 1
    end
    object selTabellad_TIPOPT: TStringField
      DisplayLabel = 'Tipo part time'
      FieldKind = fkCalculated
      FieldName = 'd_TIPOPT'
      KeyFields = 'PARTTIME'
      Visible = False
      Size = 15
      Calculated = True
    end
    object selTabellaQUALIFICA: TStringField
      DisplayLabel = 'Qualifica'
      FieldName = 'QUALIFICA'
      Visible = False
      Size = 10
    end
    object selTabellad_QUALIFICA: TStringField
      DisplayLabel = 'Qualifica desc.'
      FieldKind = fkCalculated
      FieldName = 'd_QUALIFICA'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'QUALIFICA'
      Visible = False
      Size = 100
      Calculated = True
    end
    object selTabellaDISCIPLINA: TStringField
      DisplayLabel = 'Diciplina'
      FieldName = 'DISCIPLINA'
      Visible = False
      Size = 10
    end
    object selTabellad_DISCIPLINA: TStringField
      DisplayLabel = 'Diciplina desc.'
      FieldKind = fkCalculated
      FieldName = 'd_DISCIPLINA'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'DISCIPLINA'
      Visible = False
      Size = 100
      Calculated = True
    end
    object selTabellaNOTE: TStringField
      DisplayLabel = 'Note'
      DisplayWidth = 30
      FieldName = 'NOTE'
      Size = 2000
    end
  end
end
