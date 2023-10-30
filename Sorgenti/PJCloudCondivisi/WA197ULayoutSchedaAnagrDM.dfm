inherited WA197FLayoutSchedaAnagrDM: TWA197FLayoutSchedaAnagrDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T.NOME,T.CAMPODB, T.TOP, T.LFT, T.CAPTION, T.ACCESSO, T.N' +
        'OMEPAGINA, T.ROWID FROM T033_LAYOUT T'
      'WHERE UPPER(T.CAMPODB)= '#39'MATRICOLA'#39
      ':ORDERBY'
      
        '/*ATTENZIONE devono essere esrtatti tutti i campi anche se non v' +
        'isualizzati per far funzionare correttamente la funzione copiasu' +
        '*/')
    CachedUpdates = True
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    AfterDelete = AfterDelete
    OnNewRecord = OnNewRecord
    object selTabellaNOME: TStringField
      DisplayLabel = 'Nome layout'
      FieldName = 'NOME'
      Size = 50
    end
    object selTabellaCAMPODB: TStringField
      FieldName = 'CAMPODB'
      Visible = False
      Size = 50
    end
    object selTabellaTOP: TFloatField
      FieldName = 'TOP'
      Visible = False
    end
    object selTabellaLFT: TFloatField
      FieldName = 'LFT'
      Visible = False
    end
    object selTabellaCAPTION: TStringField
      FieldName = 'CAPTION'
      Visible = False
      Size = 50
    end
    object selTabellaACCESSO: TStringField
      FieldName = 'ACCESSO'
      Visible = False
      Size = 1
    end
    object selTabellaNOMEPAGINA: TStringField
      FieldName = 'NOMEPAGINA'
      Visible = False
    end
  end
  object selT033_Pagine: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT NOMEPAGINA FROM T033_LAYOUT WHERE '
      'NOME = :NOME'
      
        'ORDER BY DECODE(NOMEPAGINA,'#39'Dati Anagrafici'#39',0,'#39'Parametri orario' +
        #39',1,'#39'Presenze/Assenze'#39',2,3), NOMEPAGINA')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A004E004F004D00450005000000000000000000
      0000}
    Left = 282
    Top = 63
  end
  object selLayout: TOracleDataSet
    SQL.Strings = (
      'select NOME'
      '  from (select I070.UTENTE NOME '
      '          from MONDOEDP.I070_UTENTI I070'
      '         where I070.AZIENDA = :AZIELAV'
      '           and I070.UTENTE <> '#39'MONDOEDP'#39
      '         union'
      '        select T033.NOME'
      '          from T033_LAYOUT T033'
      '         where T033.NOME <> '#39'DEFAULT'#39')'
      ' order by 1')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004C004100560005000000
      0000000000000000}
    Left = 32
    Top = 120
  end
  object selI071: TOracleQuery
    SQL.Strings = (
      'select count(*)'
      'from MONDOEDP.I071_PERMESSI'
      'where upper(LAYOUT)=upper(:nome)')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A004E004F004D00450005000000000000000000
      0000}
    Left = 184
    Top = 128
  end
  object delT033: TOracleQuery
    SQL.Strings = (
      'delete from t033_layout'
      'where nome = :NOME')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A004E004F004D00450005000000000000000000
      0000}
    Left = 280
    Top = 128
  end
end
