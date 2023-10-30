object W047FIscrizioneOrdineDM: TW047FIscrizioneOrdineDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 190
  Width = 565
  object selSG220: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid '
      'from   SG220_ORDPROFSAN_ISCRIZ t'
      'where  t.PROGRESSIVO = :PROGRESSIVO'
      'order by t.COD_ORDINE, T.DATA_ISCRIZIONE')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    BeforeEdit = selSG220BeforeEdit
    BeforePost = selSG220BeforePost
    AfterPost = selSG220AfterPost
    BeforeDelete = selSG220BeforeDelete
    AfterDelete = selSG220AfterDelete
    OnNewRecord = selSG220NewRecord
    Left = 43
    Top = 16
    object selSG220PROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selSG220COD_ORDINE: TStringField
      DisplayLabel = '(*) Codice ordine'
      FieldName = 'COD_ORDINE'
      Required = True
      Visible = False
      Size = 10
    end
    object selSG220d_ORDINE: TStringField
      DisplayLabel = 'Ordine Professionale'
      FieldKind = fkLookup
      FieldName = 'd_ORDINE'
      LookupDataSet = selSG221_all
      LookupKeyFields = 'COD_ORDINE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COD_ORDINE'
      Size = 160
      Lookup = True
    end
    object selSG220COD_PROVINCIA: TStringField
      DisplayLabel = '(*) Provincia'
      FieldName = 'COD_PROVINCIA'
      Required = True
      Visible = False
      Size = 2
    end
    object selSG220d_PROVINCIA: TStringField
      DisplayLabel = 'Provincia'
      FieldKind = fkLookup
      FieldName = 'd_PROVINCIA'
      LookupDataSet = selT481
      LookupKeyFields = 'COD_PROVINCIA'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COD_PROVINCIA'
      Size = 40
      Lookup = True
    end
    object selSG220COD_ISCRIZIONE: TStringField
      DisplayLabel = '(*) Numero iscrizione'
      FieldName = 'COD_ISCRIZIONE'
      Required = True
      Size = 10
    end
    object selSG220DATA_ISCRIZIONE: TDateTimeField
      DisplayLabel = 'Data iscrizione'
      FieldName = 'DATA_ISCRIZIONE'
    end
    object selSG220EMAIL_PEC: TStringField
      DisplayLabel = 'Indirizzo e-mail certificata PEC'
      FieldName = 'EMAIL_PEC'
      Size = 1000
    end
    object selSG220NOTE: TStringField
      DisplayLabel = 'Note'
      DisplayWidth = 40
      FieldName = 'NOTE'
      Size = 4000
    end
  end
  object selSG221_all: TOracleDataSet
    SQL.Strings = (
      'select t.* '
      'from SG221_ORDPROFSAN_ELENCO t'
      'order by t.COD_ORDINE')
    ReadBuffer = 100
    Optimize = False
    Left = 110
    Top = 16
    object selSG221_allCOD_ORDINE: TStringField
      FieldName = 'COD_ORDINE'
      Size = 10
    end
    object selSG221_allDESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 160
    end
    object selSG221_allQUALIFICHE_COLLEGATE: TStringField
      FieldName = 'QUALIFICHE_COLLEGATE'
      Size = 4000
    end
  end
  object selT481: TOracleDataSet
    SQL.Strings = (
      'select t.* from T481_PROVINCE t'
      'order by t.COD_PROVINCIA')
    ReadBuffer = 200
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000150000000C00000043004F0044004900430045000100000000001800
      000050004100530054004F005F005400490043004B0045005400010000000000
      0E00000041005300530045004E005A0041000100000000001000000050005200
      4500530045004E005A004100010000000000120000004F00520045004D004900
      4E0049004D0045000100000000001A0000004E004F004E004C00410056004F00
      520041005400490056004F000100000000001600000043004100550053005F00
      5400490043004B00450054000100000000000600000044004100310001000000
      0000040000004100310001000000000006000000440041003200010000000000
      04000000410032000100000000002000000046004F0052005A0041004D004100
      54005500520041005A0049004F004E0045000100000000001E00000049004E00
      490042004D00410054005500520041005A0049004F004E004500010000000000
      1A0000004F0052004100520049005300500045005A005A004100540049000100
      000000001A00000049004E00540045005200560041004C004C004F004D004900
      4E000100000000001A00000049004E00540045005200560041004C004C004F00
      4D0041005800010000000000180000005400490050004F005F00430041004C00
      43004F004C004F00010000000000180000004D004500530045005F0041005300
      530045004E005A0045000100000000001E0000004C0049004D00490054004900
      5F0053004500500041005200410054004900010000000000160000004F005200
      45005F004D0041005400540049004E0041000100000000001C0000004F005200
      45005F0050004F004D004500520049004700470049004F00010000000000}
    Left = 261
    Top = 16
    object selT481COD_PROVINCIA: TStringField
      FieldName = 'COD_PROVINCIA'
      Size = 2
    end
    object selT481DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
  object selV430a: TOracleDataSet
    SQL.Strings = (
      'SELECT :CAMPI'
      'FROM V430_STORICO '
      'WHERE T430PROGRESSIVO = :PROGRESSIVO'
      'AND TRUNC(SYSDATE) BETWEEN T430DATADECORRENZA AND T430DATAFINE')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A00430041004D0050004900
      010000000000000000000000}
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
    CommitOnPost = False
    Left = 310
    Top = 16
  end
  object selSG221_fil: TOracleDataSet
    SQL.Strings = (
      'select t.*'
      'from SG221_ORDPROFSAN_ELENCO t'
      'where intersez_liste(QUALIFICHE_COLLEGATE,:VALORE) = :VALORE'
      'order by t.COD_ORDINE')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A00560041004C004F0052004500050000000000
      000000000000}
    Left = 182
    Top = 16
    object StringField1: TStringField
      FieldName = 'COD_ORDINE'
      Size = 10
    end
    object StringField2: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 160
    end
    object StringField3: TStringField
      FieldName = 'QUALIFICHE_COLLEGATE'
      Size = 4000
    end
  end
  object selSG221_GetCodOrdine: TOracleDataSet
    SQL.Strings = (
      'select COD_ORDINE'
      'from SG221_ORDPROFSAN_ELENCO'
      'where upper(COD_ORDINE) = upper(:CODICE)')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 56
    Top = 112
  end
  object selT481_GetCodProv: TOracleDataSet
    SQL.Strings = (
      'select COD_PROVINCIA'
      'from T481_PROVINCE'
      'where upper(COD_PROVINCIA) = upper(:PROV)')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A00500052004F00560005000000000000000000
      0000}
    Left = 208
    Top = 112
  end
end
