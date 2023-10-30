object W052FRichiestaDispTurniDM: TW052FRichiestaDispTurniDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 89
  Width = 493
  object selT600: TOracleDataSet
    SQL.Strings = (
      '-- v. C018UIterAutDM')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      04000000060000000E0000003A00460049004C00540052004F00010000000000
      0000000000001A0000003A005100560049005300540041004F00520041004300
      4C0045000100000000000000000000001E0000003A004100550054004F005200
      49005A005A0041005A0049004F004E0045000100000000000000000000001600
      00003A0044004100540041004C00410056004F0052004F000C00000000000000
      000000001E0000003A00460049004C00540052004F005F005000450052004900
      4F0044004F00010000000000000000000000100000003A0041005A0049004500
      4E0044004100050000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000D00000016000000500052004F004700520045005300530049005600
      4F000100000000000E000000430041005500530041004C004500010000000000
      06000000440041004C000100000000000400000041004C000100000000001200
      00005400490050004F00470049005500530054000100000000001C0000004100
      550054004F00520049005A005A0041005A0049004F004E004500010000000000
      1800000052004500530050004F004E0053004100420049004C00450001000000
      00000E00000044004100540041004E0041005300010000000000120000004E00
      55004D00450052004F004F005200450001000000000004000000520049000100
      0000000010000000500055004C00530041004E00540045000100000000001200
      00004D00410054005200490043004F004C004100010000000000140000004E00
      4F004D0049004E0041005400490056004F00010000000000}
    OnCalcFields = selT600CalcFields
    OnNewRecord = selT600NewRecord
    Left = 14
    Top = 16
    object selT600ID: TFloatField
      FieldName = 'ID'
    end
    object selT600ID_REVOCA: TFloatField
      FieldName = 'ID_REVOCA'
    end
    object selT600ID_REVOCATO: TFloatField
      FieldName = 'ID_REVOCATO'
    end
    object selT600PROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
    end
    object selT600NOMINATIVO: TStringField
      FieldName = 'NOMINATIVO'
      Size = 65
    end
    object selT600MATRICOLA: TStringField
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selT600SESSO: TStringField
      FieldName = 'SESSO'
      Size = 1
    end
    object selT600COD_ITER: TStringField
      DisplayWidth = 20
      FieldName = 'COD_ITER'
      Size = 30
    end
    object selT600TIPO_RICHIESTA: TStringField
      FieldName = 'TIPO_RICHIESTA'
      Size = 1
    end
    object selT600AUTORIZZ_AUTOMATICA: TStringField
      FieldName = 'AUTORIZZ_AUTOMATICA'
      Size = 1
    end
    object selT600REVOCABILE: TStringField
      FieldName = 'REVOCABILE'
      Size = 10
    end
    object selT600DATA_RICHIESTA: TDateTimeField
      FieldName = 'DATA_RICHIESTA'
    end
    object selT600LIVELLO_AUTORIZZAZIONE: TFloatField
      FieldName = 'LIVELLO_AUTORIZZAZIONE'
    end
    object selT600DATA_AUTORIZZAZIONE: TDateTimeField
      FieldName = 'DATA_AUTORIZZAZIONE'
    end
    object selT600AUTORIZZAZIONE: TStringField
      FieldName = 'AUTORIZZAZIONE'
      Size = 1
    end
    object selT600NOMINATIVO_RESP: TStringField
      FieldName = 'NOMINATIVO_RESP'
      Size = 65
    end
    object selT600AUTORIZZ_AUTOM_PREV: TStringField
      FieldName = 'AUTORIZZ_AUTOM_PREV'
      Size = 1
    end
    object selT600AUTORIZZ_PREV: TStringField
      FieldName = 'AUTORIZZ_PREV'
      Size = 1
    end
    object selT600RESPONSABILE_PREV: TStringField
      FieldName = 'RESPONSABILE_PREV'
      Size = 30
    end
    object selT600AUTORIZZ_UTILE: TStringField
      FieldName = 'AUTORIZZ_UTILE'
      Size = 1
    end
    object selT600AUTORIZZ_REVOCA: TStringField
      FieldName = 'AUTORIZZ_REVOCA'
      Size = 1
    end
    object selT600D_TIPO_RICHIESTA: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_TIPO_RICHIESTA'
      Size = 100
      Calculated = True
    end
    object selT600D_RESPONSABILE: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_RESPONSABILE'
      Size = 84
      Calculated = True
    end
    object selT600D_AUTORIZZAZIONE: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_AUTORIZZAZIONE'
      Size = 2
      Calculated = True
    end
    object selT600DATA: TDateTimeField
      FieldName = 'DATA'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object selT600DAORE: TStringField
      FieldName = 'DAORE'
      Size = 5
    end
    object selT600AORE: TStringField
      FieldName = 'AORE'
      Size = 5
    end
    object selT600SQUADRE: TStringField
      FieldName = 'SQUADRE'
      Size = 1000
    end
    object selT600CF_SQUADRE: TStringField
      FieldKind = fkCalculated
      FieldName = 'CF_SQUADRE'
      Size = 2000
      Calculated = True
    end
    object selT600MESSAGGI: TStringField
      FieldKind = fkCalculated
      FieldName = 'MESSAGGI'
      Size = 200
      Calculated = True
    end
    object selT600MSGAUT_SI: TStringField
      FieldName = 'MSGAUT_SI'
      Size = 2000
    end
    object selT600MSGAUT_NO: TStringField
      FieldName = 'MSGAUT_NO'
      Size = 2000
    end
  end
  object selaT600: TOracleQuery
    SQL.Strings = (
      'SELECT COUNT(*)'
      'FROM T850_ITER_RICHIESTE T850, T600_RICHIESTEDISPTURNI T600'
      'WHERE T600.PROGRESSIVO = :PROGRESSIVO'
      'AND T600.DATA = :DATA'
      'AND T850.ID = T600.ID'
      'AND NVL(T850.STATO,'#39'S'#39') = '#39'S'#39)
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 71
    Top = 16
  end
  object selT080: TOracleDataSet
    SQL.Strings = (
      'select T080.ROWID, T080.*'
      'from   T080_PIANIFORARI T080'
      'where  T080.PROGRESSIVO = :PROGRESSIVO'
      'and    T080.DATA = :DATA')
    ReadBuffer = 31
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 123
    Top = 16
  end
  object selT603: TOracleDataSet
    SQL.Strings = (
      'select T603.CODICE, T603.DESCRIZIONE'
      'from   T603_SQUADRE T603'
      'order by T603.CODICE')
    ReadBuffer = 31
    Optimize = False
    Left = 179
    Top = 16
  end
  object selT040: TOracleQuery
    SQL.Strings = (
      'select COUNT(*)'
      'from T040_GIUSTIFICATIVI T040, T265_CAUASSENZE T265'
      'where T040.PROGRESSIVO = :PROGRESSIVO'
      'and T040.DATA = :DATA'
      'and T265.CODICE = T040.CAUSALE'
      'and not exists (select 1'
      '                from T606_CONDIZIONI T606'
      '                where T606.PROGRESSIVO = -1'
      '                and T606.COD_SQUADRA = '#39'*'#39
      '                and T606.COD_TIPOOPE = '#39'*'#39
      '                and T606.COD_GIORNO = '#39'*'#39
      '                and T606.COD_ORARIO = '#39'*'#39
      '                and T606.SIGLA_TURNO = '#39'*'#39
      '                and T606.COD_CONDIZIONE = '#39'00004'#39
      
        '                and T040.DATA between T606.DECORRENZA and T606.D' +
        'ECORRENZA_FINE'
      
        '                and INSTR('#39','#39'||T606.VALORE||'#39','#39','#39','#39'||T040.CAUSAL' +
        'E||'#39','#39') > 0)')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 231
    Top = 16
  end
  object selT600a: TOracleDataSet
    SQL.Strings = (
      'select T600.SQUADRE'
      'from T600_RICHIESTEDISPTURNI T600'
      'where T600.PROGRESSIVO = :PROGRESSIVO'
      'and T600.DATA = (select MAX(T600A.DATA) '
      '                 from T600_RICHIESTEDISPTURNI T600A '
      '                 where T600A.PROGRESSIVO = T600.PROGRESSIVO)')
    ReadBuffer = 31
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Left = 283
    Top = 16
  end
end
