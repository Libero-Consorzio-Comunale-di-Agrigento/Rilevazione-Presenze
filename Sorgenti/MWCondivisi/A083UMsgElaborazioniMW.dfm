inherited A083FMsgElaborazioniMW: TA083FMsgElaborazioniMW
  OldCreateOrder = True
  object selOutAnagrafe: TOracleDataSet
    SQL.Strings = (
      'SELECT :HINT'
      
        '       I005.ID,I005.DATA, I005.MASCHERA, NVL(I005.OPERATORE,'#39'SER' +
        'VIZI_MONDOEDP'#39') AS OPERATORE, NVL(I006.AZIENDA_MSG,'#39'AZIN'#39') AS AZ' +
        'IENDA_MSG, I006.DATA_MSG, '
      
        '       DECODE(LTRIM(RTRIM(I006.TIPO)),'#39'A'#39','#39'Anomalia'#39','#39'I'#39','#39'Inform' +
        'azione'#39','#39'B'#39','#39'Riep.bloccato'#39') AS TIPO, I006.MSG, '
      
        '       T030.COGNOME||'#39' '#39'||T030.NOME AS NOMINATIVO, T030.MATRICOL' +
        'A'
      '  FROM MONDOEDP.I005_MSGINFO I005, MONDOEDP.I006_MSGDATI I006,'
      '       :QVISTAORACLE'
      '   AND I005.ID = I006.ID'
      '   AND T030.PROGRESSIVO(+) = I006.PROGRESSIVO'
      '    :FILTRO'
      '    :FILTROC700'
      'ORDER BY I005.ID DESC, I006.ID_MSG')
    ReadBuffer = 10000
    Optimize = False
    Variables.Data = {
      04000000050000000E0000003A00460049004C00540052004F00010000000000
      0000000000001A0000003A005100560049005300540041004F00520041004300
      4C004500010000000000000000000000160000003A00460049004C0054005200
      4F004300370030003000010000000000000000000000160000003A0044004100
      540041004C00410056004F0052004F000C00000000000000000000000A000000
      3A00480049004E005400010000000000000000000000}
    Left = 128
    Top = 24
    object selOutAnagrafeID: TFloatField
      FieldName = 'ID'
    end
    object selOutAnagrafeDATA_MSG: TDateTimeField
      DisplayLabel = 'Data messaggio'
      FieldName = 'DATA_MSG'
      Visible = False
    end
    object selOutAnagrafeAZIENDA_MSG: TStringField
      DisplayLabel = 'Azienda'
      DisplayWidth = 20
      FieldName = 'AZIENDA_MSG'
      Visible = False
      Size = 30
    end
    object selOutAnagrafeOPERATORE: TStringField
      DisplayLabel = 'Operatore'
      DisplayWidth = 20
      FieldName = 'OPERATORE'
      Visible = False
      Size = 30
    end
    object selOutAnagrafeMASCHERA: TStringField
      DisplayLabel = 'Maschera'
      DisplayWidth = 5
      FieldName = 'MASCHERA'
      Visible = False
      Size = 30
    end
    object selOutAnagrafeTIPO: TStringField
      DisplayLabel = 'Tipo'
      DisplayWidth = 10
      FieldName = 'TIPO'
      Visible = False
    end
    object selOutAnagrafeMSG: TStringField
      DisplayLabel = 'Messaggio'
      DisplayWidth = 50
      FieldName = 'MSG'
      Visible = False
      Size = 2000
    end
    object selOutAnagrafeMATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selOutAnagrafeNOMINATIVO: TStringField
      DisplayLabel = 'Nominativo'
      DisplayWidth = 20
      FieldName = 'NOMINATIVO'
      Size = 100
    end
  end
  object selOutPut: TOracleDataSet
    SQL.Strings = (
      'SELECT :HINT'
      
        '       I005.ID,I005.DATA, I005.MASCHERA, NVL(I005.OPERATORE,'#39'SER' +
        'VIZI_MONDOEDP'#39') AS OPERATORE, NVL(I006.AZIENDA_MSG,'#39'AZIN'#39') AS AZ' +
        'IENDA_MSG, I006.DATA_MSG, '
      
        '       DECODE(LTRIM(RTRIM(I006.TIPO)),'#39'A'#39','#39'Anomalia'#39','#39'I'#39','#39'Inform' +
        'azione'#39','#39'B'#39','#39'Riep.bloccato'#39') AS TIPO, RTRIM(LTRIM(I006.MSG)) AS ' +
        'MSG, T030.COGNOME||'#39' '#39'||T030.NOME AS NOMINATIVO, T030.MATRICOLA'
      
        '  FROM MONDOEDP.I005_MSGINFO I005, MONDOEDP.I006_MSGDATI I006, T' +
        '030_ANAGRAFICO T030'
      ' WHERE I005.ID = I006.ID'
      '   AND T030.PROGRESSIVO(+) = I006.PROGRESSIVO'
      ':FILTRO'
      'ORDER BY I005.ID DESC, I006.ID_MSG')
    ReadBuffer = 10000
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A00460049004C00540052004F00010000000000
      0000000000000A0000003A00480049004E005400010000000000000000000000}
    Left = 40
    Top = 24
    object selOutPutID: TFloatField
      FieldName = 'ID'
    end
    object selOutPutDATA_MSG: TDateTimeField
      DisplayLabel = 'Data messaggio'
      FieldName = 'DATA_MSG'
      Visible = False
    end
    object selOutPutAZIENDA: TStringField
      DisplayLabel = 'Azienda'
      DisplayWidth = 20
      FieldName = 'AZIENDA_MSG'
      Visible = False
      Size = 30
    end
    object selOutPutOPERATORE: TStringField
      DisplayLabel = 'Operatore'
      DisplayWidth = 20
      FieldName = 'OPERATORE'
      Visible = False
      Size = 30
    end
    object selOutPutMASCHERA: TStringField
      DisplayLabel = 'Maschera'
      DisplayWidth = 5
      FieldName = 'MASCHERA'
      Visible = False
      Size = 30
    end
    object selOutPutTIPO: TStringField
      DisplayLabel = 'Tipo'
      DisplayWidth = 10
      FieldName = 'TIPO'
      Visible = False
    end
    object selOutPutMSG: TStringField
      DisplayLabel = 'Messaggio'
      DisplayWidth = 50
      FieldName = 'MSG'
      Visible = False
      Size = 2000
    end
    object selOutPutMATRICOLA: TStringField
      FieldName = 'Matricola'
      Size = 8
    end
    object selOutPutNOMINATIVO: TStringField
      DisplayWidth = 20
      FieldName = 'Nominativo'
      Size = 100
    end
  end
  object selI005Aziende: TOracleDataSet
    SQL.Strings = (
      'SELECT I090.AZIENDA'
      'FROM MONDOEDP.I090_ENTI I090'
      ':FILTRO'
      'ORDER BY 1')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A00460049004C00540052004F00010000000000
      000000000000}
    Left = 40
    Top = 88
  end
  object selI005Valori: TOracleDataSet
    SQL.Strings = (
      'select :HINT'
      '  :SELECT'
      '  from VI005_I006_MSGELABORAZIONI I005'
      
        ' where nvl(nvl(I005.AZIENDA_MSG,I005.AZIENDA),'#39'AZIN'#39') in (:AZIEN' +
        'DA)'
      'order by 1')
    ReadBuffer = 500
    Optimize = False
    Variables.Data = {
      0400000003000000100000003A0041005A00490045004E004400410001000000
      00000000000000000E0000003A00530045004C00450043005400010000000000
      0000000000000A0000003A00480049004E005400010000000000000000000000}
    Left = 128
    Top = 88
  end
  object GetDataDaID: TOracleQuery
    SQL.Strings = (
      'SELECT TRUNC(NVL(MIN(I005.DATA),SYSDATE)) AS DATA'
      '  FROM MONDOEDP.I005_MSGINFO I005'
      ' WHERE I005.ID = :ID')
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    Left = 40
    Top = 152
  end
end
