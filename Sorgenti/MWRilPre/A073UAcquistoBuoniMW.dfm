inherited A073FAcquistoBuoniMW: TA073FAcquistoBuoniMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 264
  Width = 375
  object BuoniPasto: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 24
    Top = 80
  end
  object selT680: TOracleDataSet
    SQL.Strings = (
      
        'select last_day(to_date(anno||lpad(mese,2,0)||'#39'01'#39','#39'yyyymmdd'#39')) ' +
        'DATA,NVL(BUONIPASTO,0) + NVL(VARBUONIPASTO,0) BUONIPASTO'
      'from T680_BUONIMENSILI'
      'where PROGRESSIVO=:PROGRESSIVO'
      
        'and last_day(to_date(anno||lpad(mese,2,0)||'#39'01'#39','#39'yyyymmdd'#39'))>:DA' +
        'TADAL'
      
        'and last_day(to_date(anno||lpad(mese,2,0)||'#39'01'#39','#39'yyyymmdd'#39'))<=:D' +
        'ATAAL'
      'order by ANNO,MESE')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A0044004100540041004400
      41004C000C00000000000000000000000E0000003A0044004100540041004100
      4C000C0000000000000000000000}
    Left = 96
    Top = 80
  end
  object selT690: TOracleDataSet
    SQL.Strings = (
      'select T690.data_magazzino, T691.data_scadenza, T690.buonipasto '
      'from T690_ACQUISTOBUONI T690, T691_MAGAZZINOBUONI T691'
      'where T690.PROGRESSIVO=:PROGRESSIVO'
      'and T690.DATA <= :DATA'
      'and T690.DATA_MAGAZZINO = T691.DATA_ACQUISTO(+)'
      'order by T690.data_magazzino')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 208
    Top = 80
  end
  object selT691: TOracleDataSet
    SQL.Strings = (
      'select * from t691_magazzinobuoni'
      'order by DATA_ACQUISTO DESC')
    Optimize = False
    Left = 24
    Top = 8
  end
  object selT690DataInizio: TOracleDataSet
    SQL.Strings = (
      'select DATA from T690_ACQUISTOBUONI'
      'where PROGRESSIVO=:PROGRESSIVO'
      'and DATA<=:DATA'
      'order by DATA')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 96
    Top = 8
  end
  object selT690_IDBLOCCHETTI: TOracleDataSet
    SQL.Strings = (
      
        'select T690.PROGRESSIVO,T690.DATA,T030.MATRICOLA,T030.COGNOME,T0' +
        '30.NOME,T690.BUONIPASTO,T690.TICKET,T690.ID_BLOCCHETTI,T690.ROWI' +
        'D'
      'from T690_ACQUISTOBUONI T690, T030_ANAGRAFICO T030'
      'where (:IDRIGA is null or T690.ROWID <> :IDRIGA)'
      
        'and '#39','#39'||replace(T690.ID_BLOCCHETTI,'#39' '#39','#39#39')||'#39','#39' like '#39'%,'#39'||:ID_' +
        'BLOCCHETTO||'#39',%'#39
      'and T030.PROGRESSIVO = T690.PROGRESSIVO')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A00490044005200490047004100050000000000
      0000000000001C0000003A00490044005F0042004C004F004300430048004500
      540054004F00050000000000000000000000}
    Left = 208
    Top = 8
  end
  object cdsMappaturaExcel: TClientDataSet
    PersistDataPacket.Data = {
      430000009619E0BD010000001800000002000000000003000000430004444154
      4F010049000000010005574944544802000200640007434F4C4F4E4E41040001
      00000000000000}
    Active = True
    Aggregates = <>
    Params = <>
    BeforeInsert = cdsMappaturaExcelBeforeInsert
    BeforeDelete = cdsMappaturaExcelBeforeDelete
    Left = 40
    Top = 144
    object cdsMappaturaExcelDATO: TStringField
      DisplayLabel = 'Dato'
      DisplayWidth = 20
      FieldName = 'DATO'
      ReadOnly = True
      Size = 100
    end
    object cdsMappaturaExcelCOLONNA: TIntegerField
      Alignment = taCenter
      DisplayLabel = 'Colonna'
      DisplayWidth = 5
      FieldName = 'COLONNA'
      MaxValue = 9999
      MinValue = 1
    end
  end
  object selT690Import: TOracleDataSet
    SQL.Strings = (
      'SELECT PROGRESSIVO, DATA, BUONIPASTO, TICKET, ROWID'
      'FROM   T690_ACQUISTOBUONI'
      'WHERE  PROGRESSIVO = :PROGRESSIVO'
      'AND    DATA = :DATA'
      '')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 144
    Top = 144
  end
  object txtRdrCsv: TFDBatchMoveTextReader
    DataDef.Fields = <>
    DataDef.Delimiter = '"'
    DataDef.Separator = ';'
    DataDef.RecordFormat = rfCustom
    DataDef.WithFieldNames = True
    Encoding = ecUTF8
    Left = 295
    Top = 72
  end
  object mvDtstWrCsv: TFDBatchMoveDataSetWriter
    DataSet = cdsLetturaCsv
    Optimise = False
    Left = 295
    Top = 128
  end
  object bMvCsv: TFDBatchMove
    Reader = txtRdrCsv
    Writer = mvDtstWrCsv
    Options = []
    Mappings = <>
    LogFileName = 'Data.log'
    Analyze = [taDelimSep, taFormatSet, taHeader, taFields]
    Left = 295
    Top = 184
  end
  object cdsLetturaCsv: TClientDataSet
    PersistDataPacket.Data = {
      720000009619E0BD010000001800000004000000000003000000720001410100
      4900000001000557494454480200020014000142010049000000010005574944
      5448020002001400014301004900000001000557494454480200020014000144
      01004900000001000557494454480200020014000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'A'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'B'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'C'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'D'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 296
    Top = 16
  end
  object WtCrsr: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 216
    Top = 192
  end
end
