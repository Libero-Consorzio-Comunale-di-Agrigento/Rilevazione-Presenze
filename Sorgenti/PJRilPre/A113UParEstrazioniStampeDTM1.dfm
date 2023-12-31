object A113FParEstrazioniStampeDTM1: TA113FParEstrazioniStampeDTM1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 375
  Width = 559
  object Q910: TOracleDataSet
    SQL.Strings = (
      
        'select CODICE, TITOLO from t910_riepilogo t where applicazione =' +
        ' :APPLICAZIONE'
      'ORDER BY CODICE')
    Optimize = False
    Variables.Data = {
      04000000010000001A0000003A004100500050004C004900430041005A004900
      4F004E004500050000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000180000000C00000043004F0044004900430045000100000000000C00
      00005400490054004F004C004F00010000000000180000004100500050004C00
      4900430041005A0049004F004E00450001000000000008000000540049005000
      4F000100000000000E0000005300450050004100520041004800010000000000
      0E00000053004500500041005200410056000100000000001000000046004F00
      4E0054004E0041004D0045000100000000001000000046004F004E0054005300
      49005A00450001000000000016000000530041004C0054004F00500041004700
      49004E0041000100000000000C00000054004F00540041004C00490001000000
      00001600000054004F0054005000410052005A00490041004C00490001000000
      00001600000054004F005400470045004E004500520041004C00490001000000
      00002600000043004F004E0054004500470047004900470049004F0052004E00
      41004C0049004500520049000100000000001E000000460049004C0054005200
      4F004500530043004C0055005300490056004F00010000000000160000005600
      41004C004F00520045004E0055004C004C004F00010000000000180000004900
      4D0050004F005300540041005A0049004F004E0049000100000000001A000000
      5300540041004D00500041005F005400490054004F004C004F00010000000000
      1C0000005300540041004D00500041005F0050004500520049004F0044004F00
      0100000000001A0000005300540041004D00500041005F004E0055004D005000
      41004700010000000000160000005300540041004D00500041005F0044004100
      540041000100000000001C00000046004F0052004D00410054004F005F005000
      4100470049004E004100010000000000260000004F005200490045004E005400
      41004D0045004E0054004F005F0050004100470049004E004100010000000000
      1C0000005300540041004D00500041005F0041005A00490045004E0044004100
      0100000000002000000054004100420045004C004C0041005F00470045004E00
      45005200410054004100010000000000}
    Left = 16
    Top = 72
    object Q910CODICE: TStringField
      DisplayWidth = 17
      FieldName = 'CODICE'
      Required = True
      Size = 10
    end
    object Q910TITOLO: TStringField
      FieldName = 'TITOLO'
      Size = 80
    end
  end
  object D910: TDataSource
    DataSet = Q910
    Left = 48
    Top = 72
  end
  object Q930: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid from t930_parestrazionistampe t'
      'ORDER BY CODICE_STAMPA')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000050000001A00000043004F0044004900430045005F00530054004100
      4D0050004100010000000000120000004E004F004D0045005F00460049004C00
      4500010000000000120000005400490050004F005F00460049004C0045000100
      000000001400000043004F0044004900430045005F0050004100520001000000
      0000200000005500540045004E00540049005F00500052004900560049004C00
      450047004900010000000000}
    BeforePost = Q930BeforePost
    AfterPost = Q930AfterPost
    BeforeDelete = Q930BeforeDelete
    AfterDelete = Q930AfterDelete
    OnNewRecord = Q930NewRecord
    Left = 16
    Top = 16
    object Q930CODICE_PAR: TStringField
      FieldName = 'CODICE_PAR'
      Required = True
      Size = 10
    end
    object Q930CODICE_STAMPA: TStringField
      DisplayWidth = 10
      FieldName = 'CODICE_STAMPA'
      Required = True
      Size = 10
    end
    object Q930DESC_STAMPA: TStringField
      FieldKind = fkLookup
      FieldName = 'DESC_STAMPA'
      LookupDataSet = Q910
      LookupKeyFields = 'CODICE'
      LookupResultField = 'TITOLO'
      KeyFields = 'CODICE_STAMPA'
      Size = 80
      Lookup = True
    end
    object Q930TIPO_FILE: TStringField
      FieldName = 'TIPO_FILE'
      Size = 1
    end
    object Q930NOME_FILE: TStringField
      FieldName = 'NOME_FILE'
      Size = 200
    end
    object Q930UTENTI_PRIVILEGI: TStringField
      FieldName = 'UTENTI_PRIVILEGI'
      Size = 50
    end
  end
  object Q911: TOracleDataSet
    SQL.Strings = (
      'select T911.nome, T911.caption, T909.TIPO'
      ' from t911_datiriepilogo T911, T909_DATICALCOLATI T909'
      'where t911.nome = t909.nome'
      '  and T911.codice = :CODICESTAMPA'
      '  and T911.banda = '#39'D'#39
      'order by T911.nome')
    Optimize = False
    Variables.Data = {
      04000000010000001A0000003A0043004F004400490043004500530054004100
      4D0050004100050000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      0500000003000000080000004E004F004D0045000100000000000E0000004300
      41005000540049004F004E00010000000000080000005400490050004F000100
      00000000}
    Left = 104
    Top = 72
    object Q911NOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 40
    end
    object Q911CAPTION: TStringField
      FieldName = 'CAPTION'
      Size = 40
    end
    object Q911TIPO: TStringField
      FieldName = 'TIPO'
      Required = True
      Size = 1
    end
  end
  object D911: TDataSource
    DataSet = Q911
    Left = 136
    Top = 72
  end
  object Q931: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid '
      'from t931_tracciatoestrazionistampe t'
      'where codice_par = :codicepar'
      'order by posizione, dato')
    Optimize = False
    Variables.Data = {
      0400000001000000140000003A0043004F004400490043004500500041005200
      050000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      0500000009000000080000004400410054004F00010000000000120000005000
      4F00530049005A0049004F004E00450001000000000008000000540049005000
      4F000100000000001C000000560041005200490041005A0049004F004E004900
      5F004D00410058000100000000001400000043004F0044004900430045005F00
      5000410052000100000000000C00000043004800490041005600450001000000
      000016000000560041004C004F00520045005F004E0055004C004C0001000000
      00000E00000046004F0052004D00410054004F00010000000000200000005300
      4F004D004D0041005F005200490043004F005200520045004E005A0045000100
      00000000}
    ReadOnly = True
    CachedUpdates = True
    BeforePost = Q931BeforePost
    AfterPost = Q931AfterPost
    BeforeDelete = Q931BeforeDelete
    AfterDelete = Q931AfterDelete
    OnNewRecord = Q931NewRecord
    Left = 104
    Top = 16
    object Q931CODICE_PAR: TStringField
      FieldName = 'CODICE_PAR'
      Required = True
      Size = 10
    end
    object Q931DATO: TStringField
      FieldName = 'DATO'
      Required = True
      Size = 40
    end
    object Q931CHIAVE: TStringField
      FieldName = 'CHIAVE'
      Required = True
      Size = 1
    end
    object Q931DATO_LOOKUP: TStringField
      FieldKind = fkLookup
      FieldName = 'DATO_LOOKUP'
      LookupDataSet = Q911
      LookupKeyFields = 'NOME'
      LookupResultField = 'NOME'
      KeyFields = 'DATO'
      Size = 40
      Lookup = True
    end
    object Q931POSIZIONE: TIntegerField
      FieldName = 'POSIZIONE'
    end
    object Q931TIPO: TStringField
      FieldName = 'TIPO'
    end
    object Q931VARIAZIONI_MAX: TIntegerField
      FieldName = 'VARIAZIONI_MAX'
    end
    object Q931VALORE_NULL: TStringField
      FieldName = 'VALORE_NULL'
      Size = 1
    end
    object Q931FORMATO: TStringField
      FieldName = 'FORMATO'
    end
    object Q931SOMMA_RICORRENZE: TStringField
      DisplayWidth = 25
      FieldName = 'SOMMA_RICORRENZE'
      Required = True
      Size = 25
    end
  end
  object D931: TDataSource
    DataSet = Q931
    Left = 136
    Top = 16
  end
  object Del931: TOracleQuery
    SQL.Strings = (
      'DELETE t931_tracciatoestrazionistampe '
      ' WHERE CODICE_PAR = :CODICEPAR')
    Optimize = False
    Variables.Data = {
      0400000001000000140000003A0043004F004400490043004500500041005200
      050000000000000000000000}
    Left = 200
    Top = 16
  end
  object SelQ930: TOracleDataSet
    SQL.Strings = (
      'select codice, titolo'
      '  from t910_riepilogo '
      ' where tabella_generata = :tabella')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0054004100420045004C004C00410005000000
      0000000000000000}
    Left = 56
    Top = 16
  end
  object SelUser: TOracleDataSet
    SQL.Strings = (
      'select USERNAME from dba_users')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000010000001000000055005300450052004E0041004D00450001000000
      0000}
    Left = 200
    Top = 72
    object SelUserUSERNAME: TStringField
      FieldName = 'USERNAME'
      Required = True
      Size = 30
    end
  end
end
