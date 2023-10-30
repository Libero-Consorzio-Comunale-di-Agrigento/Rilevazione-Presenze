inherited S026FDatiLiberiMW: TS026FDatiLiberiMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  object QCols: TOracleDataSet
    SQL.Strings = (
      'SELECT TABLE_NAME, COLUMN_NAME '
      '  FROM COLS '
      ' WHERE TABLE_NAME  = '#39'T030_ANAGRAFICO'#39' '
      '    OR TABLE_NAME  = '#39'V430_STORICO'#39' '
      '    OR TABLE_NAME  = '#39'VSG651_CORSI'#39
      '    OR TABLE_NAME  = '#39'VSG402_RISCHIPRESCRIZIONI'#39
      '    OR TABLE_NAME  = '#39'VSG303_INCARICHI'#39
      'ORDER BY TABLE_NAME, COLUMN_NAME')
    Optimize = False
    Left = 72
    Top = 11
  end
  object OperSQL: TOracleQuery
    Optimize = False
    Left = 19
    Top = 9
  end
  object selSG500Segnalibri: TOracleDataSet
    SQL.Strings = (
      'SELECT * '
      'FROM SG500_DATILIBERI '
      'WHERE ARCHIVIO = '#39'SEGNALIBRI'#39
      'ORDER BY ARCHIVIO,NOMECAMPO')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      050000000A0000001000000041005200430048004900560049004F0001000000
      0000120000004E004F004D004500430041004D0050004F000100000000001200
      000056004100520049004100420049004C004500010000000000160000004900
      4E0049005A0049004F00560041004C0049004400010000000000120000004600
      49004E004500560041004C004900440001000000000016000000440045005300
      4300520049005A0049004F004E00450001000000000014000000520049004600
      500052004F0056005600450044000100000000001800000046004F0052004D00
      410054004F005F00440041005400410001000000000022000000440045004300
      4F004400490046004900430041005F00560041004C004F005200450001000000
      0000140000004400450043004F005200520045004E005A004100010000000000}
    Left = 440
    Top = 24
    object StringField1: TStringField
      DisplayWidth = 13
      FieldName = 'ARCHIVIO'
      Required = True
      Size = 50
    end
    object StringField2: TStringField
      DisplayWidth = 17
      FieldName = 'NOMECAMPO'
      Required = True
      Size = 50
    end
    object StringField3: TStringField
      DisplayWidth = 25
      FieldName = 'VARIABILE'
      Size = 50
    end
    object StringField4: TStringField
      DisplayWidth = 25
      FieldName = 'DESCRIZIONE'
      Size = 80
    end
    object selSG500SegnalibriFORMATO_DATA: TStringField
      FieldName = 'FORMATO_DATA'
    end
    object selSG500SegnalibriDECODIFICA_VALORE: TStringField
      FieldName = 'DECODIFICA_VALORE'
      Size = 500
    end
    object selSG500SegnalibriDECORRENZA: TDateTimeField
      FieldName = 'DECORRENZA'
      Required = True
    end
  end
  object dsrSG500Segnalibri: TDataSource
    AutoEdit = False
    DataSet = selSG500Segnalibri
    Left = 440
    Top = 73
  end
  object selDual: TOracleDataSet
    SQL.Strings = (
      
        'SELECT '#39'TUTTI I DATI'#39' DATO_STORICO,'#39'TUTTE LE ASSENZE'#39' CAUSALE_AS' +
        'SENZA'
      'FROM DUAL')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      0500000002000000180000004400410054004F005F00530054004F0052004900
      43004F000100000000001E000000430041005500530041004C0045005F004100
      5300530045004E005A004100010000000000}
    ReadOnly = True
    Left = 256
    Top = 32
    object selDualDATO_STORICO: TStringField
      DisplayWidth = 50
      FieldName = 'DATO_STORICO'
      Size = 50
    end
    object selDualCAUSALE_ASSENZA: TStringField
      DisplayWidth = 50
      FieldName = 'CAUSALE_ASSENZA'
      Size = 50
    end
  end
  object dsrDual: TDataSource
    DataSet = selDual
    Left = 256
    Top = 79
  end
  object dsrI010: TDataSource
    Left = 200
    Top = 80
  end
end
