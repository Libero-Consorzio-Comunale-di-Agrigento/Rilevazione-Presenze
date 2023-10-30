inherited WA181FAziendeDM: TWA181FAziendeDM
  Height = 377
  Width = 902
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT I090.*,I090.ROWID '
      '  FROM MONDOEDP.I090_ENTI I090'
      ' :ORDERBY')
    ReadBuffer = 5
    AfterEdit = selTabellaAfterEdit
    AfterPost = AfterPost
    AfterCancel = AfterCancel
    BeforeDelete = BeforeDelete
    AfterDelete = AfterDelete
    OnFilterRecord = selTabellaFilterRecord
    OnNewRecord = OnNewRecord
    object selTabellaAZIENDA: TStringField
      DisplayLabel = 'Azienda'
      FieldName = 'AZIENDA'
      Required = True
      Size = 30
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 40
      FieldName = 'DESCRIZIONE'
      Size = 150
    end
    object selTabellaINDIRIZZO: TStringField
      DisplayLabel = 'Indirizzo'
      FieldName = 'INDIRIZZO'
      Size = 40
    end
    object selTabellaUTENTE: TStringField
      DisplayLabel = 'Utente'
      FieldName = 'UTENTE'
    end
    object selTabellaPAROLACHIAVE: TStringField
      DisplayLabel = 'Password'
      FieldName = 'PAROLACHIAVE'
      Visible = False
      OnGetText = selTabellaPAROLACHIAVEGetText
      OnSetText = selTabellaPAROLACHIAVESetText
    end
    object selTabellaSTORIAINTERVENTO: TStringField
      DisplayLabel = 'Registrazione log'
      FieldName = 'STORIAINTERVENTO'
      Size = 1
    end
    object selTabellaTSLAVORO: TStringField
      DisplayLabel = 'Tablespace tabelle'
      FieldName = 'TSLAVORO'
      Origin = 'I090_ENTI.TSLAVORO'
    end
    object selTabellaTSINDICI: TStringField
      DisplayLabel = 'Tablespace indici'
      FieldName = 'TSINDICI'
      Origin = 'I090_ENTI.TSINDICI'
    end
    object selTabellaTSAUSILIARIO: TStringField
      DisplayLabel = 'Tablespace ausiliario'
      FieldName = 'TSAUSILIARIO'
    end
    object selTabellaTIMBORIG_VERSO: TStringField
      FieldName = 'TIMBORIG_VERSO'
      Visible = False
      Size = 1
    end
    object selTabellaTIMBORIG_CAUSALE: TStringField
      FieldName = 'TIMBORIG_CAUSALE'
      Visible = False
      Size = 1
    end
    object selTabellaCODICE_INTEGRAZIONE: TStringField
      DisplayLabel = 'Codice integrazione anagrafica'
      FieldName = 'CODICE_INTEGRAZIONE'
      Size = 30
    end
    object selTabellaLUNG_PASSWORD: TIntegerField
      DisplayLabel = 'Lung. min. password'
      FieldName = 'LUNG_PASSWORD'
      MaxValue = 99
    end
    object selTabellaVALID_PASSWORD: TIntegerField
      DisplayLabel = 'Mesi validit'#224' password'
      FieldName = 'VALID_PASSWORD'
      MaxValue = 999
    end
    object selTabellaVALID_UTENTE: TIntegerField
      DisplayLabel = 'Mesi validit'#224' utente'
      FieldName = 'VALID_UTENTE'
      MaxValue = 999
    end
    object selTabellaPATHALLCLIENT: TStringField
      FieldName = 'PATHALLCLIENT'
      Visible = False
      Size = 200
    end
    object selTabellaDOMINIO_USR: TStringField
      DisplayLabel = 'Server dominio utenti'
      FieldName = 'DOMINIO_USR'
      Size = 80
    end
    object selTabellaDOMINIO_USR_TIPO: TStringField
      DisplayLabel = 'Tipo autenticazione utenti'
      FieldName = 'DOMINIO_USR_TIPO'
      OnChange = selTabellaDOMINIO_DIP_TIPOChange
      Size = 5
    end
    object selTabellaDOMINIO_DIP: TStringField
      DisplayLabel = 'Server dominio dipendenti'
      FieldName = 'DOMINIO_DIP'
      Size = 80
    end
    object selTabellaDOMINIO_DIP_TIPO: TStringField
      DisplayLabel = 'Tipo autenticazione dipendenti'
      FieldName = 'DOMINIO_DIP_TIPO'
      OnChange = selTabellaDOMINIO_DIP_TIPOChange
      Size = 5
    end
    object selTabellaDOMINIO_LDAP_SUFFISSO: TStringField
      DisplayLabel = 'Suffisso al nome utente'
      FieldName = 'DOMINIO_LDAP_SUFFISSO'
      Size = 80
    end
    object selTabellaDOMINIO_LDAP_DN: TStringField
      DisplayLabel = 'Stringa DN per LDAP'
      DisplayWidth = 20
      FieldName = 'DOMINIO_LDAP_DN'
      Size = 1000
    end
    object selTabellaPASSWORD_CARSPECIALI: TIntegerField
      DisplayLabel = 'Numero minimo di caratteri speciali nelle password'
      FieldName = 'PASSWORD_CARSPECIALI'
    end
    object selTabellaPASSWORD_MAIUSCOLE: TIntegerField
      DisplayLabel = 'Numero minimo di maiuscole nelle password'
      FieldName = 'PASSWORD_MAIUSCOLE'
    end
    object selTabellaPASSWORD_CIFRE: TIntegerField
      DisplayLabel = 'Numero minimo di cifre nelle password'
      FieldName = 'PASSWORD_CIFRE'
    end
    object selTabellaGRUPPO_BADGE: TStringField
      DisplayLabel = 'Gruppo badge'
      FieldName = 'GRUPPO_BADGE'
      Size = 1
    end
  end
  inherited selEstrazioneDati: TOracleDataSet
    ReadBuffer = 5
    Left = 104
  end
  inherited dsrEstrazioniDati: TDataSource
    Left = 104
  end
  inherited selT900: TOracleDataSet
    ReadBuffer = 10
    Left = 192
  end
  inherited selT901: TOracleDataSet
    Left = 248
  end
  object selDizionario: TOracleDataSet
    ReadBuffer = 100
    Optimize = False
    Session = DbIris008B
    BeforeOpen = selDizionarioBeforeOpen
    Left = 130
    Top = 162
  end
  object DbIris008B: TOracleSession
    Preferences.ConvertUTF = cuUTF8ToUTF16
    Preferences.TrimStringFields = False
    Preferences.ZeroDateIsNull = False
    NullValue = nvNull
    Left = 22
    Top = 162
  end
  object D091: TDataSource
    Left = 539
    Top = 68
  end
  object QI092: TOracleDataSet
    SQL.Strings = (
      'SELECT SCHEDA FROM MONDOEDP.I092_LOGTABELLE '
      'WHERE AZIENDA = :AZIENDA')
    ReadBuffer = 500
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    Left = 585
    Top = 12
  end
  object selI060UtentiRipetuti: TOracleQuery
    SQL.Strings = (
      'select UTENTE'
      '  from (select upper(I060.NOME_UTENTE) UTENTE'
      '          from I060_LOGIN_DIPENDENTE I060'
      '         where I060.AZIENDA = :AZIENDA'
      '        union all'
      '        select upper(I060.NOME_UTENTE2) UTENTE'
      '          from I060_LOGIN_DIPENDENTE I060'
      '         where I060.AZIENDA = :AZIENDA'
      '           and I060.NOME_UTENTE2 is not null'
      '        union all'
      
        '        select upper(I060.NOME_UTENTE || :DOMINIO_LDAP_SUFFISSO)' +
        ' UTENTE'
      '          from I060_LOGIN_DIPENDENTE I060'
      '         where I060.AZIENDA = :AZIENDA'
      '        union all'
      
        '        select upper(I060.NOME_UTENTE2 || :DOMINIO_LDAP_SUFFISSO' +
        ') UTENTE'
      '          from I060_LOGIN_DIPENDENTE I060'
      '         where I060.AZIENDA = :AZIENDA'
      '           and I060.NOME_UTENTE2 is not null)'
      ' group by UTENTE'
      'having count(UTENTE) > 1')
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      00000000000000002C0000003A0044004F004D0049004E0049004F005F004C00
      4400410050005F0053005500460046004900530053004F000500000000000000
      00000000}
    Left = 336
    Top = 16
  end
end
