inherited B025FPubblDoc2GestDocDM: TB025FPubblDoc2GestDocDM
  OldCreateOrder = True
  Height = 164
  Width = 300
  object selT962Lookup: TOracleDataSet
    SQL.Strings = (
      'select CODICE, DESCRIZIONE'
      'from   T962_TIPO_DOCUMENTI'
      'order by CODICE')
    ReadBuffer = 100
    Optimize = False
    ReadOnly = True
    Left = 44
    Top = 16
  end
  object selCountT960: TOracleQuery
    SQL.Strings = (
      'select count(ID)'
      'from   T960_DOCUMENTI_INFO'
      'where  TIPOLOGIA = :TIPOLOGIA')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000001000000140000003A005400490050004F004C004F00470049004100
      050000000000000000000000}
    Threaded = True
    OnThreadExecuted = selCountT960ThreadExecuted
    Left = 128
    Top = 16
  end
  object insT960: TOracleQuery
    SQL.Strings = (
      'insert into T960_DOCUMENTI_INFO'
      
        '  (ID, DATA_CREAZIONE,  UTENTE, PROGRESSIVO, TIPOLOGIA, UFFICIO,' +
        ' NOME_FILE, EXT_FILE, DIMENSIONE, PERIODO_DAL, PERIODO_AL, PATH_' +
        'STORAGE, PROVENIENZA)'
      'values'
      
        '  (T960_ID.Nextval, sysdate, :OPERATORE, :PROGRESSIVO, :TIPOLOGI' +
        'A, :UFFICIO, :NOME_FILE, :EXT_FILE, :DIMENSIONE_FILE, :PERIODO_D' +
        'AL, :PERIODO_AL, :PATH_STORAGE, '#39'E'#39')')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      040000000A000000140000003A004F00500045005200410054004F0052004500
      050000000000000000000000180000003A00500052004F004700520045005300
      5300490056004F00030000000000000000000000140000003A00540049005000
      4F004C004F00470049004100050000000000000000000000100000003A005500
      460046004900430049004F00050000000000000000000000140000003A004E00
      4F004D0045005F00460049004C00450005000000000000000000000012000000
      3A004500580054005F00460049004C0045000500000000000000000000002000
      00003A00440049004D0045004E00530049004F004E0045005F00460049004C00
      4500030000000000000000000000180000003A0050004500520049004F004400
      4F005F00440041004C000C0000000000000000000000160000003A0050004500
      520049004F0044004F005F0041004C000C00000000000000000000001A000000
      3A0050004100540048005F00530054004F005200410047004500050000000000
      000000000000}
    Left = 40
    Top = 80
  end
  object selT030: TOracleQuery
    SQL.Strings = (
      'select distinct T030.PROGRESSIVO, T030.MATRICOLA'
      'from   T030_ANAGRAFICO T030,'
      '       MONDOEDP.I060_LOGIN_DIPENDENTE I060'
      'where  I060.MATRICOLA = T030.MATRICOLA '
      'and    I060.AZIENDA = :AZIENDA'
      'and    :FILTRO_DIPENDENTE')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      0000000000000000240000003A00460049004C00540052004F005F0044004900
      500045004E00440045004E0054004500010000000000000000000000}
    Left = 183
    Top = 16
  end
  object updI200: TOracleQuery
    SQL.Strings = (
      'update I200_PUBBL_DOC'
      'set    SORGENTE_DOCUMENTI = :SORGENTE_DOCUMENTI,'
      '       TIPOLOGIA_DOCUMENTI = :TIPOLOGIA'
      'where  CODICE = :CODICE')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000003000000140000003A005400490050004F004C004F00470049004100
      0500000000000000000000000E0000003A0043004F0044004900430045000500
      00000000000000000000260000003A0053004F005200470045004E0054004500
      5F0044004F00430055004D0045004E0054004900050000000000000000000000}
    Left = 183
    Top = 80
  end
  object delT960: TOracleQuery
    SQL.Strings = (
      'delete from T960_DOCUMENTI_INFO '
      'where  TIPOLOGIA = :TIPOLOGIA')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000001000000140000003A005400490050004F004C004F00470049004100
      050000000000000000000000}
    Left = 128
    Top = 80
  end
end