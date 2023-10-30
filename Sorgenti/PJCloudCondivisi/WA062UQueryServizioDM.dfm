inherited WA062FQueryServizioDM: TWA062FQueryServizioDM
  Height = 127
  Width = 300
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      
        '/*In fase di RunTime la query viene ridefinita dalla dalla proce' +
        'dure OpenSelT002(definita su A062QueryServizioMW)*/'
      'select distinct T002.NOME, '
      
        '       concatena_testo('#39'select T005.DESCRIZIONE from T005_RAGGRQ' +
        'UERYPERS T005, T006_ASSOCIA_QUERYPERS_RAGGR T006 where T006.ID =' +
        ' T005.ID and T006.COD_QUERY = '#39#39#39'||replace(T002.NOME,'#39#39#39#39','#39#39#39#39#39#39 +
        ')||'#39#39#39#39','#39','#39') RAGGRUPPAMENTO'
      'from T002_QUERYPERSONALIZZATE T002'
      'where T002.APPLICAZIONE = :APPLICAZIONE'
      ':ORDERBY')
    ReadBuffer = 250
    Variables.Data = {
      04000000020000001A0000003A004100500050004C004900430041005A004900
      4F004E004500050000000000000000000000100000003A004F00520044004500
      520042005900010000000000000000000000}
    OnFilterRecord = selTabellaFilterRecord
    object selTabellaNOME: TStringField
      FieldName = 'NOME'
      Origin = 'T002_QUERYPERSONALIZZATE.NOME'
      Size = 30
    end
    object selTabellaRAGGRUPPAMENTO: TStringField
      FieldName = 'RAGGRUPPAMENTO'
      Size = 100
    end
  end
  inherited selEstrazioneDati: TOracleDataSet
    Left = 112
  end
  inherited dsrEstrazioniDati: TDataSource
    Left = 112
  end
  inherited selT900: TOracleDataSet
    Left = 200
  end
  inherited selT901: TOracleDataSet
    Left = 256
  end
end
