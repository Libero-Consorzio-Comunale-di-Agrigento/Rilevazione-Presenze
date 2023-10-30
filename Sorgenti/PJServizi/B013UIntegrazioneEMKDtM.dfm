object B013FIntegrazioneEMKDtM: TB013FIntegrazioneEMKDtM
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  Height = 163
  Width = 363
  object DbIris032: TOracleSession
    Left = 16
    Top = 8
  end
  object Aggiorna: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      '  EMK_Aggiornamento_Abilitazioni(:AbMensa);'
      'END;')
    Optimize = False
    Variables.Data = {
      0300000001000000080000003A41424D454E5341050000000000000000000000}
    Left = 88
    Top = 8
  end
  object selI103: TOracleDataSet
    SQL.Strings = (
      'SELECT ROWID,ORA FROM I103_EMK_PIANIF_INTEG')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {0400000001000000030000004F5241010000000000}
    Session = DbIris032
    Left = 20
    Top = 64
    object selI103ORA: TStringField
      FieldName = 'ORA'
      OnValidate = selI103ORAValidate
      EditMask = '!00:00;1;_'
      Size = 5
    end
  end
  object Dsel103: TDataSource
    DataSet = selI103
    Left = 88
    Top = 64
  end
  object delEMKTimb: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      
        '  DELETE FROM EMKTIMBRATURE WHERE DATA <= :DataCancellazione AND' +
        ' (ELABORATO = '#39'V'#39' OR TIPO = '#39'X'#39');'
      '  :RigheElaborate:=SQL%ROWCOUNT;'
      '  COMMIT;'
      'END;')
    Optimize = False
    Variables.Data = {
      0300000002000000120000003A4441544143414E43454C4C415A494F4E450C00
      000000000000000000000F0000003A5249474845454C41424F52415445030000
      00040000000000000000000000}
    Left = 236
    Top = 8
  end
  object AggiornaMicr: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      '  Micr_Aggiorn_Abilitazioni(:AbMensa);'
      'END;')
    Optimize = False
    Variables.Data = {
      0300000001000000080000003A41424D454E5341050000000000000000000000}
    Left = 160
    Top = 8
  end
  object delMicrTimb: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      
        '  DELETE FROM MICR_TIMBRATURE WHERE DATA <= :DataCancellazione A' +
        'ND (ELABORATO = '#39'V'#39' OR TIPO = '#39'X'#39');'
      '  :RigheElaborate:=SQL%ROWCOUNT;'
      '  COMMIT;'
      'END;')
    Optimize = False
    Variables.Data = {
      0300000002000000120000003A4441544143414E43454C4C415A494F4E450C00
      000000000000000000000F0000003A5249474845454C41424F52415445030000
      00040000000000000000000000}
    Left = 308
    Top = 8
  end
  object selMicr: TOracleDataSet
    SQL.Strings = (
      'SELECT COUNT(*) FROM MICR_ABILITAZIONI')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {0400000001000000030000004F5241010000000000}
    Session = DbIris032
    Left = 188
    Top = 64
  end
end
