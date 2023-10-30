inherited S740FRegoleValutazioniMW: TS740FRegoleValutazioniMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 229
  Width = 448
  object D010: TDataSource
    Left = 368
    Top = 16
  end
  object selT450: TOracleDataSet
    SQL.Strings = (
      'select *'
      'from t450_tiporapporto'
      'order by codice')
    Optimize = False
    Left = 248
    Top = 16
  end
  object SG742: TOracleDataSet
    SQL.Strings = (
      'SELECT SG742.*, SG742.ROWID'
      'FROM SG742_ETICHETTE_VALUTAZIONI SG742'
      'WHERE DECORRENZA = :DECORRENZA'
      'AND CODREGOLA = :CODREGOLA'
      'ORDER BY ORDINE')
    Optimize = False
    Variables.Data = {
      0400000002000000160000003A004400450043004F005200520045004E005A00
      41000C0000000000000000000000140000003A0043004F004400520045004700
      4F004C004100050000000000000000000000}
    OracleDictionary.DefaultValues = True
    CountAllRecords = True
    CommitOnPost = False
    CachedUpdates = True
    CompressBLOBs = True
    BeforeInsert = SG742BeforeInsert
    BeforeEdit = SG742BeforeEdit
    BeforeDelete = SG742BeforeDelete
    OnCalcFields = SG742CalcFields
    Left = 72
    Top = 16
    object SG742DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
      Visible = False
    end
    object SG742CODREGOLA: TStringField
      DisplayLabel = 'Cod. regola'
      FieldName = 'CODREGOLA'
      Visible = False
      Size = 5
    end
    object SG742NOME_CAMPO: TStringField
      DisplayLabel = 'Cod. nome campo'
      FieldName = 'NOME_CAMPO'
      Visible = False
      Size = 40
    end
    object SG742DESCRIZIONE: TStringField
      DisplayLabel = 'Campo'
      FieldKind = fkCalculated
      FieldName = 'DESCRIZIONE'
      ReadOnly = True
      Size = 100
      Calculated = True
    end
    object SG742ETICHETTA: TStringField
      DisplayLabel = 'Etichetta'
      FieldName = 'ETICHETTA'
      Size = 40
    end
    object SG742ORDINE: TFloatField
      DisplayLabel = 'Ordine'
      FieldName = 'ORDINE'
      ReadOnly = True
      Visible = False
    end
  end
  object D742: TDataSource
    DataSet = SG742
    Left = 72
    Top = 64
  end
  object delSG742: TOracleQuery
    SQL.Strings = (
      'DELETE SG742_ETICHETTE_VALUTAZIONI'
      'WHERE DECORRENZA = :DECORRENZA'
      'AND CODREGOLA = :CODREGOLA'
      'AND NOME_CAMPO = NVL(:NOME_CAMPO,NOME_CAMPO)')
    Optimize = False
    Variables.Data = {
      0400000003000000160000003A004400450043004F005200520045004E005A00
      41000C0000000000000000000000140000003A0043004F004400520045004700
      4F004C004100050000000000000000000000160000003A004E004F004D004500
      5F00430041004D0050004F00050000000000000000000000}
    Left = 72
    Top = 160
  end
  object insaSG742: TOracleQuery
    SQL.Strings = (
      'insert into SG742_ETICHETTE_VALUTAZIONI'
      'select :DECORRENZA_NEW, CODREGOLA, NOME_CAMPO, ETICHETTA, ORDINE'
      'from SG742_ETICHETTE_VALUTAZIONI'
      'where DECORRENZA = :DECORRENZA_OLD'
      'and CODREGOLA = :CODREGOLA')
    Optimize = False
    Variables.Data = {
      0400000003000000140000003A0043004F0044005200450047004F004C004100
      0500000000000000000000001E0000003A004400450043004F00520052004500
      4E005A0041005F004E00450057000C00000000000000000000001E0000003A00
      4400450043004F005200520045004E005A0041005F004F004C0044000C000000
      0000000000000000}
    Left = 128
    Top = 112
  end
  object insSG742: TOracleQuery
    SQL.Strings = (
      'insert into SG742_ETICHETTE_VALUTAZIONI'
      '( DECORRENZA, CODREGOLA, NOME_CAMPO, ETICHETTA, ORDINE)'
      'values'
      '(:DECORRENZA,:CODREGOLA,:NOME_CAMPO,:ETICHETTA,:ORDINE)')
    Optimize = False
    Variables.Data = {
      0400000005000000140000003A0043004F0044005200450047004F004C004100
      050000000000000000000000160000003A004400450043004F00520052004500
      4E005A0041000C0000000000000000000000160000003A004E004F004D004500
      5F00430041004D0050004F00050000000000000000000000140000003A004500
      540049004300480045005400540041000500000000000000000000000E000000
      3A004F005200440049004E004500040000000000000000000000}
    Left = 72
    Top = 112
  end
  object updSG742: TOracleQuery
    SQL.Strings = (
      'update SG742_ETICHETTE_VALUTAZIONI'
      'set ORDINE = :ORDINE'
      'where DECORRENZA = :DECORRENZA'
      'and CODREGOLA = :CODREGOLA'
      'and NOME_CAMPO = :NOME_CAMPO')
    Optimize = False
    Variables.Data = {
      0400000004000000160000003A004400450043004F005200520045004E005A00
      41000C0000000000000000000000140000003A0043004F004400520045004700
      4F004C0041000500000000000000000000000E0000003A004F00520044004900
      4E004500030000000000000000000000160000003A004E004F004D0045005F00
      430041004D0050004F00050000000000000000000000}
    Left = 128
    Top = 160
  end
  object selSG750: TOracleDataSet
    SQL.Strings = (
      'select codice, descrizione'
      'from sg750_parprotocollo'
      'order by codice')
    Optimize = False
    Left = 184
    Top = 16
  end
  object D750: TDataSource
    DataSet = selSG750
    Left = 184
    Top = 64
  end
  object selSG735: TOracleDataSet
    SQL.Strings = (
      'select codice, descrizione'
      ' from t765_tipoquote T765'
      'where tipoquota in ('#39'I'#39','#39'V'#39','#39'C'#39','#39'D'#39','#39'N'#39')'
      '  and decorrenza = (select max(decorrenza)'
      '                      from t765_tipoquote'
      '                     where codice = T765.codice)'
      '  and exists (select 1'
      '                from sg735_punteggifasce_incentivi'
      '               where codquota = T765.codice'
      '                 and tipologia = '#39'V'#39')'
      'order by codice')
    Optimize = False
    Left = 128
    Top = 16
  end
  object D735: TDataSource
    DataSet = selSG735
    Left = 128
    Top = 64
  end
end
