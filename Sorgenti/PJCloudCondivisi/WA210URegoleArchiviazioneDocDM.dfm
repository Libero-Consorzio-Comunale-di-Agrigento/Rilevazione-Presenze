inherited WA210FRegoleArchiviazioneDocDM: TWA210FRegoleArchiviazioneDocDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select T.*,'
      '  decode(T.TIPO_DOCUMENTO,'#39'CAR'#39','#39'Cartellino'#39','
      '                          '#39'CED'#39','#39'Cedolino'#39','
      '                          '#39'CU'#39','#39'CU'#39','
      '                          '#39'LOGCED'#39','#39'Log cedolino'#39','
      '                          '#39'LOGCU'#39','#39'Log CU'#39','
      '                                '#39#39') D_TIPO_DOCUMENTO,'
      '  decode(T.SOSTITUZIONE_FILE,'#39'S'#39','#39'Si'#39','#39'No'#39') D_SOSTITUZIONE_FILE,'
      '  decode(T.SVUOTA_DIRECTORY,'#39'S'#39','#39'Si'#39','#39'No'#39') D_SVUOTA_DIRECTORY,'
      '  T.ROWID'
      'from I210_REGOLE_ARCHIVIAZIONE T'
      'where T.APPLICAZIONE = :APPLICAZIONE'
      ':ORDERBY')
    Variables.Data = {
      0400000002000000100000003A004F0052004400450052004200590001000000
      00000000000000001A0000003A004100500050004C004900430041005A004900
      4F004E004500050000000000000000000000}
    BeforeEdit = selTabellaBeforeEdit
    object selTabellaAPPLICAZIONE: TStringField
      DisplayLabel = 'Applicazione'
      FieldName = 'APPLICAZIONE'
      ReadOnly = True
      Visible = False
      Size = 6
    end
    object selTabellaTIPO_DOCUMENTO: TStringField
      DisplayLabel = 'Tipo documento'
      DisplayWidth = 10
      FieldName = 'TIPO_DOCUMENTO'
      ReadOnly = True
      Visible = False
      Size = 10
    end
    object selTabellaD_TIPO_DOCUMENTO: TStringField
      DisplayLabel = 'Tipo documento'
      DisplayWidth = 20
      FieldKind = fkInternalCalc
      FieldName = 'D_TIPO_DOCUMENTO'
      ReadOnly = True
    end
    object selTabellaPATH_FILE: TStringField
      DisplayLabel = 'Percorso archiviazione'
      FieldName = 'PATH_FILE'
      Size = 200
    end
    object selTabellaFILE_PDF: TStringField
      DisplayLabel = 'Nome del file pdf'
      FieldName = 'FILE_PDF'
      Size = 200
    end
    object selTabellaFILE_XML: TStringField
      DisplayLabel = 'Nome del file xml'
      FieldName = 'FILE_XML'
      Size = 200
    end
    object selTabellaCAMPI_XML: TStringField
      DisplayLabel = 'Elenco dei campi nel file xml'
      FieldName = 'CAMPI_XML'
      Visible = False
      Size = 4000
    end
    object selTabellaSVUOTA_DIRECTORY: TStringField
      DisplayLabel = 'Svuota cartella'
      FieldName = 'SVUOTA_DIRECTORY'
      Visible = False
      Size = 1
    end
    object selTabellaD_SVUOTA_DIRECTORY: TStringField
      Alignment = taCenter
      DisplayLabel = 'Svuota cartella'
      FieldKind = fkInternalCalc
      FieldName = 'D_SVUOTA_DIRECTORY'
      Size = 2
    end
    object selTabellaSOSTITUZIONE_FILE: TStringField
      DisplayLabel = 'Sovrascrittura file'
      FieldName = 'SOSTITUZIONE_FILE'
      Visible = False
      Size = 1
    end
    object selTabellaD_SOSTITUZIONE_FILE: TStringField
      Alignment = taCenter
      DisplayLabel = 'Sovrascrittura file'
      FieldKind = fkInternalCalc
      FieldName = 'D_SOSTITUZIONE_FILE'
      Size = 2
    end
    object selTabellaSERVER_SFTP: TStringField
      DisplayLabel = 'Server SFTP'
      FieldName = 'SERVER_SFTP'
      Size = 200
    end
    object selTabellaUSERNAME_SFTP: TStringField
      DisplayLabel = 'Nome utente'
      FieldName = 'USERNAME_SFTP'
      Size = 100
    end
    object selTabellaPASSWORD_SFTP: TStringField
      DisplayLabel = 'Password'
      FieldName = 'PASSWORD_SFTP'
      Visible = False
      OnGetText = selTabellaPASSWORD_SFTPGetText
      OnSetText = selTabellaPASSWORD_SFTPSetText
      Size = 100
    end
    object selTabellaDIR_ARCH_SFTP: TStringField
      DisplayLabel = 'Cartella remota'
      FieldName = 'DIR_ARCH_SFTP'
      Visible = False
      Size = 200
    end
    object selTabellaPATH_PSCP: TStringField
      DisplayLabel = 'Path PSCP'
      FieldName = 'PATH_PSCP'
      Visible = False
      Size = 200
    end
    object selTabellaDATA_RIF_ULTIMA_ELAB: TDateTimeField
      DisplayLabel = 'Data riferimento ultima archiviazione'
      FieldName = 'DATA_RIF_ULTIMA_ELAB'
      Visible = False
    end
    object selTabellaTIPOLOGIA_DOCUMENTI: TStringField
      DisplayLabel = 'Tipologia documenti'
      FieldName = 'TIPOLOGIA_DOCUMENTI'
      Size = 10
    end
    object selTabellaTIPO_FILE_METADATI: TStringField
      DisplayLabel = 'Tipo file metadati'
      FieldName = 'TIPO_FILE_METADATI'
      Size = 1
    end
    object selTabellaBUCKETID: TStringField
      DisplayLabel = 'BucketId'
      FieldName = 'BUCKETID'
      Size = 60
    end
  end
  object selT962Lookup: TOracleDataSet
    SQL.Strings = (
      'select CODICE, DESCRIZIONE'
      'from   T962_TIPO_DOCUMENTI'
      'order by CODICE')
    ReadBuffer = 100
    Optimize = False
    ReadOnly = True
    Left = 396
    Top = 16
  end
  object dsrT962Lookup: TDataSource
    DataSet = selT962Lookup
    Left = 396
    Top = 63
  end
end
