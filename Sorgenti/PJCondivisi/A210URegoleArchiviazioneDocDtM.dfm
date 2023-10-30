inherited A210FRegoleArchiviazioneDocDtM: TA210FRegoleArchiviazioneDocDtM
  OldCreateOrder = True
  Height = 132
  Width = 168
  object selI210: TOracleDataSet
    SQL.Strings = (
      'select T.*, T.ROWID'
      'from I210_REGOLE_ARCHIVIAZIONE T'
      'where T.APPLICAZIONE = :APPLICAZIONE'
      'order by T.TIPO_DOCUMENTO')
    Optimize = False
    Variables.Data = {
      04000000010000001A0000003A004100500050004C004900430041005A004900
      4F004E004500050000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000040000001800000043004F0044005F00500041005200540054004900
      4D004500010000000000160000004400450053004300520049005A0049004F00
      4E00450001000000000016000000500045005200430045004E00540055004100
      4C004500010000000000080000005400490050004F00010000000000}
    BeforePost = BeforePostNoStorico
    OnCalcFields = selI210CalcFields
    Left = 20
    Top = 16
    object selI210APPLICAZIONE: TStringField
      DisplayLabel = 'Applicazione'
      FieldName = 'APPLICAZIONE'
      ReadOnly = True
      Visible = False
      Size = 6
    end
    object selI210TIPO_DOCUMENTO: TStringField
      DisplayLabel = 'Tipo documento'
      DisplayWidth = 10
      FieldName = 'TIPO_DOCUMENTO'
      ReadOnly = True
      Visible = False
      Size = 10
    end
    object selI210D_TIPO_DOCUMENTO: TStringField
      DisplayLabel = 'Descr. tipo documento'
      DisplayWidth = 50
      FieldKind = fkCalculated
      FieldName = 'D_TIPO_DOCUMENTO'
      ReadOnly = True
      Size = 50
      Calculated = True
    end
    object selI210PATH_FILE: TStringField
      DisplayLabel = 'Percorso archiviazione'
      FieldName = 'PATH_FILE'
      Size = 200
    end
    object selI210FILE_PDF: TStringField
      DisplayLabel = 'Nome del file pdf'
      FieldName = 'FILE_PDF'
      Size = 200
    end
    object selI210FILE_XML: TStringField
      DisplayLabel = 'Nome del file xml'
      FieldName = 'FILE_XML'
      Size = 200
    end
    object selI210CAMPI_XML: TStringField
      DisplayLabel = 'Elenco dei campi nel file xml'
      FieldName = 'CAMPI_XML'
      Size = 4000
    end
    object selI210SOSTITUZIONE_FILE: TStringField
      DisplayLabel = 'Sovrascrittura file'
      FieldName = 'SOSTITUZIONE_FILE'
      Size = 1
    end
    object selI210SVUOTA_DIRECTORY: TStringField
      DisplayLabel = 'Svuota cartelle'
      FieldName = 'SVUOTA_DIRECTORY'
      Size = 1
    end
    object selI210SERVER_SFTP: TStringField
      DisplayLabel = 'Nome del server SFTP'
      FieldName = 'SERVER_SFTP'
      Size = 200
    end
    object selI210USERNAME_SFTP: TStringField
      DisplayLabel = 'Nome utente'
      FieldName = 'USERNAME_SFTP'
      Size = 100
    end
    object selI210PASSWORD_SFTP: TStringField
      DisplayLabel = 'Password'
      FieldName = 'PASSWORD_SFTP'
      OnGetText = selI210PASSWORD_SFTPGetText
      OnSetText = selI210PASSWORD_SFTPSetText
      Size = 100
    end
    object selI210DIR_ARCH_SFTP: TStringField
      DisplayLabel = 'Cartella di archiviazione'
      FieldName = 'DIR_ARCH_SFTP'
      Size = 200
    end
    object selI210PATH_PSCP: TStringField
      DisplayLabel = 'Percorso di PSCP'
      FieldName = 'PATH_PSCP'
      Size = 200
    end
    object selI210DATA_RIF_ULTIMA_ELAB: TDateTimeField
      FieldName = 'DATA_RIF_ULTIMA_ELAB'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selI210TIPOLOGIA_DOCUMENTI: TStringField
      FieldName = 'TIPOLOGIA_DOCUMENTI'
      Size = 10
    end
    object selI210TIPO_FILE_METADATI: TStringField
      FieldName = 'TIPO_FILE_METADATI'
    end
    object selI210BUCKETID: TStringField
      FieldName = 'BUCKETID'
      Size = 60
    end
    object selI210VERIFICA_VALIDAZIONE: TStringField
      FieldName = 'VERIFICA_VALIDAZIONE'
      Size = 1
    end
    object selI210SCRIPT_VALIDAZIONE: TStringField
      FieldName = 'SCRIPT_VALIDAZIONE'
      Size = 2000
    end
    object selI210SCRIPT_NOTE: TStringField
      FieldName = 'SCRIPT_NOTE'
      Size = 2000
    end
    object selI210SCRIPT_ARCHIVIAZIONE: TStringField
      FieldName = 'SCRIPT_ARCHIVIAZIONE'
      Size = 2000
    end
    object selI210INVIA_REGISTRO: TStringField
      FieldName = 'INVIA_REGISTRO'
      Size = 1
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
    Left = 84
    Top = 16
  end
  object dsrT962Lookup: TDataSource
    DataSet = selT962Lookup
    Left = 88
    Top = 72
  end
end
