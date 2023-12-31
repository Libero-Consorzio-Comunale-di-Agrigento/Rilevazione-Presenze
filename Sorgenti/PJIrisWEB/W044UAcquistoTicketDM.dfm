object W044FAcquistoTicketDM: TW044FAcquistoTicketDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 88
  Width = 268
  object selT670: TOracleDataSet
    SQL.Strings = (
      'SELECT * '
      'FROM   T670_REGOLEBUONI'
      'WHERE  CODICE = :CODICE')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000150000000C00000043004F0044004900430045000100000000001800
      000050004100530054004F005F005400490043004B0045005400010000000000
      0E00000041005300530045004E005A0041000100000000001000000050005200
      4500530045004E005A004100010000000000120000004F00520045004D004900
      4E0049004D0045000100000000001A0000004E004F004E004C00410056004F00
      520041005400490056004F000100000000001600000043004100550053005F00
      5400490043004B00450054000100000000000600000044004100310001000000
      0000040000004100310001000000000006000000440041003200010000000000
      04000000410032000100000000002000000046004F0052005A0041004D004100
      54005500520041005A0049004F004E0045000100000000001E00000049004E00
      490042004D00410054005500520041005A0049004F004E004500010000000000
      1A0000004F0052004100520049005300500045005A005A004100540049000100
      000000001A00000049004E00540045005200560041004C004C004F004D004900
      4E000100000000001A00000049004E00540045005200560041004C004C004F00
      4D0041005800010000000000180000005400490050004F005F00430041004C00
      43004F004C004F00010000000000180000004D004500530045005F0041005300
      530045004E005A0045000100000000001E0000004C0049004D00490054004900
      5F0053004500500041005200410054004900010000000000160000004F005200
      45005F004D0041005400540049004E0041000100000000001C0000004F005200
      45005F0050004F004D004500520049004700470049004F00010000000000}
    Left = 24
    Top = 20
  end
  object selT690: TOracleDataSet
    SQL.Strings = (
      'SELECT T690.PROGRESSIVO, '
      '       T690.DATA,'
      '       T690.BUONIPASTO,'
      '       T690.TICKET,'
      '       T690.NOTE,'
      '       T690.ROWID '
      'FROM   T690_ACQUISTOBUONI T690'
      'WHERE  T690.PROGRESSIVO = :PROGRESSIVO'
      
        'AND    T690.DATA >= ADD_MONTHS(TRUNC(SYSDATE,'#39'MM'#39'),-:MESI_PREGRE' +
        'SSI)'
      'ORDER BY T690.DATA DESC')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000500000000000000000000001E0000003A004D004500530049005F00
      500052004500470052004500530053004900030000000000000000000000}
    BeforeEdit = selT690BeforeEdit
    BeforePost = selT690BeforePost
    AfterPost = selT690AfterPost
    OnNewRecord = selT690NewRecord
    Left = 96
    Top = 20
    object selT690PROGRESSIVO: TIntegerField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selT690DATA: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
      ReadOnly = True
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
    end
    object selT690BUONIPASTO: TIntegerField
      Alignment = taCenter
      DisplayLabel = 'Buoni pasto'
      DisplayWidth = 3
      FieldName = 'BUONIPASTO'
    end
    object selT690TICKET: TIntegerField
      Alignment = taCenter
      DisplayLabel = 'Ticket'
      DisplayWidth = 3
      FieldName = 'TICKET'
    end
    object selT690NOTE: TStringField
      DisplayLabel = 'Note'
      DisplayWidth = 40
      FieldName = 'NOTE'
      ReadOnly = True
      Size = 200
    end
  end
  object selT690SumTicket: TOracleQuery
    SQL.Strings = (
      'SELECT SUM(NVL(T690.BUONIPASTO,0)) BUONIPASTO,'
      '       SUM(NVL(T690.TICKET,0)) TICKET'
      'FROM   T690_ACQUISTOBUONI T690'
      'WHERE  T690.PROGRESSIVO = :PROGRESSIVO'
      'AND    TRUNC(T690.DATA,'#39'MM'#39') = :DATARIF'
      ':FILTRO_ESCLUDI_RECORD')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A0044004100540041005200
      490046000C00000000000000000000002C0000003A00460049004C0054005200
      4F005F004500530043004C005500440049005F005200450043004F0052004400
      010000000000000000000000}
    Left = 177
    Top = 20
  end
end
