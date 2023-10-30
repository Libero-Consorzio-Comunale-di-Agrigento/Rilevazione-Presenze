inherited WA187FAccessiDM: TWA187FAccessiDM
  Height = 254
  Width = 400
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT I070.*, I070.ROWID'
      'FROM MONDOEDP.I070_UTENTI I070'
      'WHERE UTENTE NOT IN ('#39'SYSMAN'#39','#39'MONDOEDP'#39')'
      ' :ORDERBY')
    AfterScroll = nil
    object selTabellaAZIENDA: TStringField
      DisplayLabel = 'Azienda'
      DisplayWidth = 20
      FieldName = 'AZIENDA'
      ReadOnly = True
      Required = True
      Size = 30
    end
    object selTabellaUTENTE: TStringField
      DisplayLabel = 'Utente'
      DisplayWidth = 20
      FieldName = 'UTENTE'
      ReadOnly = True
      Required = True
      Size = 30
    end
    object selTabellaACCESSO_NEGATO: TStringField
      DisplayLabel = 'Accesso negato'
      FieldName = 'ACCESSO_NEGATO'
      Size = 1
    end
    object selTabellaPROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
  end
  object dsrVSESSION: TDataSource
    DataSet = selVSESSION
    Left = 28
    Top = 164
  end
  object selVSESSION: TOracleDataSet
    SQL.Strings = (
      'select'
      '  SID,SERIAL#,STATUS,USERNAME,OSUSER,MACHINE,TERMINAL,PROGRAM'
      'from'
      '  gv$session'
      'where'
      '  (instr(upper(program),'#39'A002PANAGRAFE.EXE'#39')          > 0 or'
      '  instr(upper(program),'#39'M000PMISSIONI.EXE'#39')           > 0 or'
      '  instr(upper(program),'#39'P000PSTIPENDI.EXE'#39')           > 0 or'
      '  instr(upper(program),'#39'S000PSTATOGIURIDICO.EXE'#39')     > 0 or'
      '  instr(upper(program),'#39'B006PSCARICO'#39')                > 0 or'
      '  instr(upper(program),'#39'B010PMESSAGGIOROLOGI'#39')        > 0 or'
      '  instr(upper(program),'#39'B014PINTEGRAZIONEANAGRAFICA'#39') > 0 or'
      '  instr(upper(program),'#39'B015PSCARICOGIUSTIFICATIVI'#39') > 0 or'
      '  instr(upper(program),'#39'B019PGENERATORESTAMPE'#39') > 0 or'
      '  instr(upper(program),'#39'W3WP'#39') > 0 or'
      '  instr(upper(program),'#39'W000PIRISWEB'#39') > 0'
      '  ) and'
      '  UPPER(osuser||terminal||program) <> '
      
        '  (SELECT UPPER(osuser||terminal||program) FROM GV$SESSION V WHE' +
        'RE V.SID = (SELECT MAX(SID) FROM GV$MYSTAT))'
      '    :ORDERBY')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A004F0052004400450052004200590001000000
      0000000000000000}
    QBEDefinition.QBEFieldDefs = {
      0500000008000000060000005300490044000100000000000E00000053004500
      5200490041004C0023000100000000000C000000530054004100540055005300
      0100000000001000000055005300450052004E0041004D004500010000000000
      0C0000004F00530055005300450052000100000000000E0000004D0041004300
      480049004E004500010000000000100000005400450052004D0049004E004100
      4C000100000000000E000000500052004F004700520041004D00010000000000}
    Left = 28
    Top = 116
    object selVSESSIONSID: TFloatField
      DisplayLabel = 'Sid'
      DisplayWidth = 5
      FieldName = 'SID'
    end
    object selVSESSIONSERIAL: TFloatField
      DisplayLabel = 'Serial#'
      DisplayWidth = 5
      FieldName = 'SERIAL#'
    end
    object selVSESSIONSTATUS: TStringField
      DisplayLabel = 'Stato'
      FieldName = 'STATUS'
      Size = 8
    end
    object selVSESSIONUSERNAME: TStringField
      DisplayLabel = 'User name'
      DisplayWidth = 10
      FieldName = 'USERNAME'
      Size = 30
    end
    object selVSESSIONOSUSER: TStringField
      DisplayLabel = 'Os user'
      DisplayWidth = 25
      FieldName = 'OSUSER'
      Size = 30
    end
    object selVSESSIONMACHINE: TStringField
      DisplayLabel = 'Macchina'
      DisplayWidth = 25
      FieldName = 'MACHINE'
      Size = 64
    end
    object selVSESSIONTERMINAL: TStringField
      DisplayLabel = 'Terminale'
      DisplayWidth = 15
      FieldName = 'TERMINAL'
      Size = 16
    end
    object selVSESSIONPROGRAM: TStringField
      DisplayLabel = 'Programma utilizzato'
      DisplayWidth = 20
      FieldName = 'PROGRAM'
      Size = 64
    end
  end
  object OperSQL: TOracleQuery
    ReadBuffer = 1
    Optimize = False
    Left = 174
    Top = 113
  end
  object cdsVSESSION: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 100
    Top = 115
  end
end
