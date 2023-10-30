inherited A210FRegoleArchiviazioneDocMW: TA210FRegoleArchiviazioneDocMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  object selCols: TOracleDataSet
    SQL.Strings = (
      'select data_type'
      'from cols'
      'where table_name = :TABELLA'
      'and column_name = :NOME_CAMPO')
    Optimize = False
    Variables.Data = {
      0400000002000000160000003A004E004F004D0045005F00430041004D005000
      4F00050000000000000000000000100000003A0054004100420045004C004C00
      4100050000000000000000000000}
    Left = 24
    Top = 24
  end
  object updUltimaDataRifElab: TOracleQuery
    SQL.Strings = (
      'update I210_REGOLE_ARCHIVIAZIONE I210'
      'set I210.DATA_RIF_ULTIMA_ELAB = :DATA_RIF_ULTIMA_ELAB'
      'where I210.APPLICAZIONE = :APPLICAZIONE'
      'and I210.TIPO_DOCUMENTO = :TIPO_DOCUMENTO')
    Optimize = False
    Variables.Data = {
      04000000030000001A0000003A004100500050004C004900430041005A004900
      4F004E0045000500000000000000000000001E0000003A005400490050004F00
      5F0044004F00430055004D0045004E0054004F00050000000000000000000000
      2A0000003A0044004100540041005F005200490046005F0055004C0054004900
      4D0041005F0045004C00410042000C0000000000000000000000}
    Left = 112
    Top = 24
  end
  object selJSON: TOracleDataSet
    Optimize = False
    Left = 208
    Top = 24
  end
  object HTTPClient: TNetHTTPClient
    Asynchronous = False
    ConnectionTimeout = 60000
    ResponseTimeout = 60000
    AllowCookies = True
    HandleRedirects = True
    UserAgent = 'Embarcadero URI Client/1.0'
    Left = 376
    Top = 24
  end
  object HTTPRequest: TNetHTTPRequest
    Asynchronous = False
    ConnectionTimeout = 60000
    ResponseTimeout = 60000
    Client = HTTPClient
    Left = 448
    Top = 24
  end
  object selScript: TOracleQuery
    SQL.Strings = (
      'begin'
      '  :RESULT:=T960F_INVIA_REGISTROARCH_A159(:IDT960,:HASH);'
      'end;')
    Optimize = False
    Variables.Data = {
      04000000030000000E0000003A0052004500530055004C005400050000000000
      0000000000000E0000003A004900440054003900360030000400000000000000
      000000000A0000003A004800410053004800050000000000000000000000}
    Left = 24
    Top = 96
  end
end
