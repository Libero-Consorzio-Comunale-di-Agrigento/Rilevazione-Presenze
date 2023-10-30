inherited A220FArchiviazioneLarchiveMW: TA220FArchiviazioneLarchiveMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 302
  Width = 252
  object cdsFileCaricati: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 24
    Top = 72
    object cdsFileCaricatiID_DOCUMENTO: TStringField
      DisplayLabel = 'Id documento'
      DisplayWidth = 15
      FieldName = 'ID_DOCUMENTO'
      Size = 100
    end
    object cdsFileCaricatiTIPO_DOCUMENTO: TStringField
      DisplayLabel = 'Tipo documento'
      DisplayWidth = 15
      FieldName = 'TIPO'
    end
    object cdsFileCaricatiNOME_FILE: TStringField
      DisplayLabel = 'Nome file'
      DisplayWidth = 20
      FieldName = 'NOME_FILE'
      Size = 100
    end
    object cdsFileCaricatiPATH: TStringField
      DisplayLabel = 'Percorso'
      DisplayWidth = 40
      FieldName = 'PATH'
      Size = 300
    end
    object cdsFileCaricatiDATA_CREAZIONE: TDateTimeField
      DisplayLabel = 'Data creazione'
      DisplayWidth = 20
      FieldName = 'DATA_CREAZIONE'
    end
    object cdsFileCaricatiSTATO_TRASMISSIONE: TStringField
      DisplayLabel = 'PdvStatus'
      DisplayWidth = 20
      FieldName = 'STATO'
      Size = 100
    end
  end
  object HTTPClient: TNetHTTPClient
    Asynchronous = False
    ConnectionTimeout = 5000
    ResponseTimeout = 5000
    AllowCookies = True
    HandleRedirects = True
    UserAgent = 'Embarcadero URI Client/1.0'
    Left = 24
    Top = 16
  end
  object HTTPRequest: TNetHTTPRequest
    Asynchronous = False
    ConnectionTimeout = 5000
    ResponseTimeout = 5000
    Client = HTTPClient
    Left = 104
    Top = 16
  end
  object dsrFileCaricati: TDataSource
    AutoEdit = False
    DataSet = cdsFileCaricati
    Left = 103
    Top = 72
  end
  object selI220a: TOracleDataSet
    SQL.Strings = (
      'SELECT * '
      
        'FROM I220_LARCHIVE WHERE DATA_TRASMISSIONE BETWEEN :DATA_INIZIO ' +
        'AND :DATA_FINE :ID_TRASMISSIONE :PDVSTATUS :TIPO_DOCUMENTO :DOCU' +
        'SERID :DOCFILENAME ORDER BY ID_TRASMISSIONE DESC')
    Optimize = False
    Variables.Data = {
      0400000007000000180000003A0044004100540041005F0049004E0049005A00
      49004F000C0000000000000000000000140000003A0044004100540041005F00
      460049004E0045000C0000000000000000000000140000003A00500044005600
      5300540041005400550053000100000000000000000000001E0000003A005400
      490050004F005F0044004F00430055004D0045004E0054004F00010000000000
      000000000000140000003A0044004F0043005500530045005200490044000100
      00000000000000000000180000003A0044004F004300460049004C0045004E00
      41004D004500010000000000000000000000200000003A00490044005F005400
      5200410053004D0049005300530049004F004E00450001000000000000000000
      0000}
    Left = 24
    Top = 128
    object selI220aID_TRASMISSIONE: TFloatField
      DisplayLabel = 'Id'
      DisplayWidth = 8
      FieldName = 'ID_TRASMISSIONE'
    end
    object selI220aDATA_TRASMISSIONE: TDateTimeField
      DisplayLabel = 'Data trasmissione'
      DisplayWidth = 18
      FieldName = 'DATA_TRASMISSIONE'
    end
    object selI220aTIPO_DOCUMENTO: TStringField
      DisplayLabel = 'Tipo documento'
      DisplayWidth = 14
      FieldName = 'TIPO_DOCUMENTO'
    end
    object selI220aDOCUSERID: TStringField
      DisplayLabel = 'DocUserId'
      DisplayWidth = 20
      FieldName = 'DOCUSERID'
      Size = 28
    end
    object selI220aDOCFILENAME: TStringField
      DisplayLabel = 'DocFileName'
      DisplayWidth = 30
      FieldName = 'DOCFILENAME'
      Size = 55
    end
    object selI220aDATA_CREAZIONE: TDateTimeField
      DisplayLabel = 'Data creazione'
      FieldName = 'DATA_CREAZIONE'
    end
    object selI220aPDVSTATUS: TStringField
      DisplayLabel = 'PdvStatus'
      FieldName = 'PDVSTATUS'
      Size = 16
    end
    object selI220aPDVSTATUSMESSAGE: TStringField
      DisplayLabel = 'PdvStatusMessage'
      DisplayWidth = 40
      FieldName = 'PDVSTATUSMESSAGE'
      Size = 50
    end
    object selI220aUPLOADDATE: TDateTimeField
      DisplayLabel = 'UploadDate'
      FieldName = 'UPLOADDATE'
    end
    object selI220aPDVID: TStringField
      DisplayLabel = 'PdvId'
      DisplayWidth = 40
      FieldName = 'PDVID'
      Size = 60
    end
    object selI220aUSERPDVID: TStringField
      DisplayLabel = 'UserPdvId'
      DisplayWidth = 40
      FieldName = 'USERPDVID'
      Size = 60
    end
    object selI220aBUCKETID: TStringField
      DisplayLabel = 'BucketId'
      DisplayWidth = 40
      FieldName = 'BUCKETID'
      Size = 60
    end
    object selI220aERRORMESSAGE: TStringField
      DisplayLabel = 'ErrorMessage'
      DisplayWidth = 50
      FieldName = 'ERRORMESSAGE'
      Size = 1000
    end
    object selI220aDOCHASH: TStringField
      DisplayLabel = 'DocHash'
      FieldName = 'DOCHASH'
      Size = 90
    end
  end
  object dsrselI220a: TDataSource
    DataSet = selI220a
    Left = 104
    Top = 128
  end
  object selI220b: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT TIPO_DOCUMENTO        '
      'FROM I220_LARCHIVE')
    Optimize = False
    Left = 24
    Top = 184
  end
  object selI220c: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT PDVSTATUS'
      'FROM I220_LARCHIVE')
    Optimize = False
    Left = 104
    Top = 184
  end
  object insI220: TOracleQuery
    SQL.Strings = (
      'INSERT INTO I220_LARCHIVE'
      
        '  (ID_TRASMISSIONE, DATA_TRASMISSIONE, TIPO_DOCUMENTO, DOCUSERID' +
        ', DOCFILENAME, DATA_CREAZIONE, DOCHASH, BUCKETID, USERPDVID, PDV' +
        'ID, UPLOADDATE, PDVSTATUS, PDVSTATUSMESSAGE, ERRORMESSAGE)'
      'VALUES'
      
        '  (I220_ID.NEXTVAL, :DATA_TRASMISSIONE, :TIPO_DOCUMENTO, :DOCUSE' +
        'RID, :DOCFILENAME, :DATA_CREAZIONE, :DOCHASH, :BUCKETID, :USERPD' +
        'VID, :PDVID, :UPLOADDATE, :PDVSTATUS, :PDVSTATUSMESSAGE, :ERRORM' +
        'ESSAGE)')
    Optimize = False
    Variables.Data = {
      040000000D000000240000003A0044004100540041005F005400520041005300
      4D0049005300530049004F004E0045000C00000000000000000000001E000000
      3A005400490050004F005F0044004F00430055004D0045004E0054004F000500
      00000000000000000000140000003A0044004F00430055005300450052004900
      4400050000000000000000000000180000003A0044004F004300460049004C00
      45004E0041004D0045000500000000000000000000001E0000003A0044004100
      540041005F0043005200450041005A0049004F004E0045000C00000000000000
      00000000100000003A0044004F00430048004100530048000500000000000000
      00000000120000003A004200550043004B004500540049004400050000000000
      000000000000140000003A005500530045005200500044005600490044000500
      000000000000000000000C0000003A0050004400560049004400050000000000
      000000000000160000003A00550050004C004F00410044004400410054004500
      0C0000000000000000000000140000003A005000440056005300540041005400
      55005300050000000000000000000000220000003A0050004400560053005400
      41005400550053004D0045005300530041004700450005000000000000000000
      00001A0000003A004500520052004F0052004D00450053005300410047004500
      050000000000000000000000}
    Left = 24
    Top = 240
  end
  object updI220: TOracleQuery
    SQL.Strings = (
      'UPDATE I220_LARCHIVE'
      '   SET PDVID = :PDVID,'
      '       UPLOADDATE = :UPLOADDATE,'
      '       PDVSTATUS = :PDVSTATUS,'
      '       PDVSTATUSMESSAGE = :PDVSTATUSMESSAGE,'
      '       ERRORMESSAGE = :ERRORMESSAGE'
      ' WHERE ID_TRASMISSIONE = :ID_TRASMISSIONE')
    Optimize = False
    Variables.Data = {
      04000000060000000C0000003A00500044005600490044000500000000000000
      00000000160000003A00550050004C004F004100440044004100540045000C00
      00000000000000000000140000003A0050004400560053005400410054005500
      5300050000000000000000000000220000003A00500044005600530054004100
      5400550053004D00450053005300410047004500050000000000000000000000
      1A0000003A004500520052004F0052004D004500530053004100470045000500
      00000000000000000000200000003A00490044005F0054005200410053004D00
      49005300530049004F004E004500050000000000000000000000}
    Left = 104
    Top = 240
  end
  object selI210: TOracleDataSet
    SQL.Strings = (
      
        'SELECT * FROM I210_REGOLE_ARCHIVIAZIONE WHERE TIPO_DOCUMENTO = :' +
        'TIPO_DOCUMENTO')
    Optimize = False
    Variables.Data = {
      04000000010000001E0000003A005400490050004F005F0044004F0043005500
      4D0045004E0054004F00050000000000000000000000}
    Left = 176
    Top = 240
  end
end
