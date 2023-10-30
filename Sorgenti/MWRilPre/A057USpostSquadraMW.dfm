inherited A057FSpostSquadraMW: TA057FSpostSquadraMW
  OldCreateOrder = True
  Height = 178
  Width = 280
  object selT603: TOracleDataSet
    SQL.Strings = (
      'select T603.CODICE, T603.DESCRIZIONE'
      'from T603_SQUADRE T603'
      'where :DATA between T603.INIZIO_VALIDITA and T603.FINE_VALIDITA'
      'order by T603.CODICE')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A0044004100540041000C000000000000000000
      0000}
    Left = 40
    Top = 32
    object selT603CODICE: TStringField
      DisplayWidth = 12
      FieldName = 'CODICE'
      Size = 10
    end
    object selT603DESCRIZIONE: TStringField
      DisplayWidth = 48
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
  object dsrT603: TDataSource
    DataSet = selT603
    Left = 40
    Top = 88
  end
  object selT020: TOracleDataSet
    SQL.Strings = (
      'select T020.CODICE, T020.DESCRIZIONE'
      'from T020_ORARI T020, T606_CONDIZIONI T606'
      'where T020.DECORRENZA = (select max(T020B.DECORRENZA)'
      '                         from T020_ORARI T020B'
      '                         where T020B.CODICE = T020.CODICE'
      '                         and T020B.DECORRENZA <= :DATA)'
      'and T606.PROGRESSIVO = -1'
      'and T606.COD_SQUADRA = :COD_SQUADRA'
      'and T606.COD_CONDIZIONE = '#39'00000'#39
      'and :DATA between T606.DECORRENZA and T606.DECORRENZA_FINE'
      'and INSTR('#39','#39'||T606.VALORE||'#39','#39','#39','#39'||T020.CODICE||'#39','#39') > 0'
      'order by T020.CODICE')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A0044004100540041000C000000000000000000
      0000180000003A0043004F0044005F0053005100550041004400520041000500
      00000000000000000000}
    Left = 168
    Top = 32
    object selT020CODICE: TStringField
      DisplayWidth = 7
      FieldName = 'CODICE'
      Size = 5
    end
    object selT020DESCRIZIONE: TStringField
      DisplayWidth = 48
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
  object dsrT020: TDataSource
    DataSet = selT020
    Left = 168
    Top = 88
  end
  object selT021: TOracleDataSet
    SQL.Strings = (
      'select distinct T021.SIGLATURNI'
      'from T021_FASCEORARI T021'
      'where T021.CODICE = :CODICE'
      'and T021.SIGLATURNI is not null'
      'order by T021.SIGLATURNI')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 232
    Top = 32
    object selT021SIGLATURNI: TStringField
      DisplayWidth = 3
      FieldName = 'SIGLATURNI'
      Size = 2
    end
  end
  object dsrT021: TDataSource
    DataSet = selT021
    Left = 232
    Top = 88
  end
  object selT430: TOracleDataSet
    SQL.Strings = (
      'select distinct T430.TIPOOPE'
      'from T430_STORICO T430'
      'where T430.DATADECORRENZA <= :DECORRENZA_FINE'
      'and T430.DATAFINE >= :DECORRENZA'
      'and T430.TIPOOPE is not null'
      'order by T430.TIPOOPE')
    Optimize = False
    Variables.Data = {
      0400000002000000200000003A004400450043004F005200520045004E005A00
      41005F00460049004E0045000C0000000000000000000000160000003A004400
      450043004F005200520045004E005A0041000C0000000000000000000000}
    Left = 104
    Top = 32
    object selT430TIPOOPE: TStringField
      DisplayWidth = 7
      FieldName = 'TIPOOPE'
      Size = 5
    end
  end
  object dsrT430: TDataSource
    DataSet = selT430
    Left = 104
    Top = 88
  end
end
