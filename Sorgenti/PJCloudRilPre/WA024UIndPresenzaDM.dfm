inherited WA024FIndPresenzaDM: TWA024FIndPresenzaDM
  Height = 294
  Width = 587
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T.*,T.ROWID FROM T163_CODICIINDENNITA T'
      '  :ORDERBY')
    BeforePost = BeforePostNoStorico
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    AfterDelete = AfterDelete
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Required = True
      Size = 5
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
  object dsrT160: TDataSource
    DataSet = selT160
    Left = 40
    Top = 184
  end
  object selT160: TOracleDataSet
    SQL.Strings = (
      'SELECT T160.*,T160.ROWID FROM T160_PROFILIINDENNITA T160'
      'WHERE CODICE = :CODICE  :ORDERBY'
      '')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A0043004F004400490043004500050000000000
      000000000000100000003A004F00520044004500520042005900010000000000
      000000000000}
    Left = 36
    Top = 128
    object selT160CODICE: TStringField
      FieldName = 'CODICE'
      Origin = 'T160_PROFILIINDENNITA.CODICE'
      Visible = False
      Size = 5
    end
    object selT160INDENNITA: TStringField
      DisplayLabel = 'Indennit'#224
      FieldName = 'INDENNITA'
      Origin = 'T160_PROFILIINDENNITA.INDENNITA'
      Required = True
      Size = 5
    end
    object selT160D_INDENNITA: TStringField
      DisplayLabel = 'Descrizione'
      FieldKind = fkLookup
      FieldName = 'D_INDENNITA'
      LookupDataSet = Q162
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'INDENNITA'
      Size = 50
      Lookup = True
    end
  end
  object Ins160: TOracleQuery
    SQL.Strings = (
      'insert into T160_PROFILIINDENNITA'
      '  (CODICE, INDENNITA)'
      'values'
      '  (:CODICE, :INDENNITA)')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A0043004F004400490043004500050000000000
      000000000000140000003A0049004E00440045004E004E004900540041000500
      00000000000000000000}
    Left = 96
    Top = 128
  end
  object Update160: TOracleQuery
    SQL.Strings = (
      'update T160_PROFILIINDENNITA'
      'set'
      '  INDENNITA = :INDENNITA'
      'where'
      '  CODICE = :OLD_CODICE AND'
      '  INDENNITA = :OLD_INDENNITA')
    Optimize = False
    Variables.Data = {
      0400000003000000140000003A0049004E00440045004E004E00490054004100
      050000000000000000000000160000003A004F004C0044005F0043004F004400
      4900430045000500000000000000000000001C0000003A004F004C0044005F00
      49004E00440045004E004E00490054004100050000000000000000000000}
    Left = 152
    Top = 128
  end
  object Delete160: TOracleQuery
    SQL.Strings = (
      'delete from T160_PROFILIINDENNITA'
      'where'
      '  CODICE = :OLD_CODICE AND'
      '  INDENNITA = :OLD_INDENNITA')
    Optimize = False
    Variables.Data = {
      0400000002000000160000003A004F004C0044005F0043004F00440049004300
      45000500000000000000000000001C0000003A004F004C0044005F0049004E00
      440045004E004E00490054004100050000000000000000000000}
    Left = 208
    Top = 128
  end
  object Upd160: TOracleQuery
    SQL.Strings = (
      'UPDATE T160_PROFILIINDENNITA SET CODICE = :NEW_CODICE'
      'WHERE CODICE = :OLD_CODICE')
    Optimize = False
    Variables.Data = {
      0400000002000000160000003A004E00450057005F0043004F00440049004300
      4500050000000000000000000000160000003A004F004C0044005F0043004F00
      4400490043004500050000000000000000000000}
    Left = 260
    Top = 128
  end
  object Del160: TOracleQuery
    SQL.Strings = (
      'DELETE FROM T160_PROFILIINDENNITA WHERE CODICE = :CODICE')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 308
    Top = 128
  end
  object Q162: TOracleDataSet
    SQL.Strings = (
      'SELECT T162.*,T162.ROWID '
      '  FROM T162_INDENNITA T162'
      ' ORDER BY CODICE')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000150000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000000E00
      000049004D0050004F00520054004F000100000000001200000056004F004300
      450050004100470048004500010000000000080000005400490050004F000100
      00000000100000004E0055004D005400550052004E0049000100000000000A00
      00005400550052004E0049000100000000000E00000041005300530045004E00
      5A0045000100000000000E00000043004F004400490043004500320001000000
      00000C0000005400550052004E004F0031000100000000000C00000054005500
      52004E004F0032000100000000000C0000005400550052004E004F0033000100
      000000000C0000005400550052004E004F003400010000000000100000005000
      520049004F0052004900540041000100000000002E00000049004E0044004500
      4E004E004900540041005F0049004E0043004F004D0050004100540049004200
      49004C0049000100000000001800000043004F00450046004600490043004900
      45004E00540045000100000000001C0000004100520052004F0054004F004E00
      440041004D0045004E0054004F00010000000000220000004100530053004500
      4E005A0045005F004100420049004C0049005400410054004500010000000000
      1800000053005500500050004C005F003500470047004C004100560001000000
      00001E00000043004100550050005200450053005F0052004900450050004F00
      520045000100000000001E0000004E004D004500530049005F00450051005500
      49005400550052004E004900010000000000}
    Left = 352
    Top = 128
    object Q162CODICE: TStringField
      FieldName = 'CODICE'
      Origin = 'T162_INDENNITA.CODICE'
      Size = 5
    end
    object Q162DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Origin = 'T162_INDENNITA.DESCRIZIONE'
      Size = 40
    end
    object Q162IMPORTO: TFloatField
      FieldName = 'IMPORTO'
      Origin = 'T162_INDENNITA.IMPORTO'
      currency = True
    end
    object Q162VOCEPAGHE: TStringField
      FieldName = 'VOCEPAGHE'
      Origin = 'T162_INDENNITA.VOCEPAGHE'
      Size = 6
    end
    object Q162TIPO: TStringField
      FieldName = 'TIPO'
      Origin = 'T162_INDENNITA.TIPO'
      Size = 1
    end
    object Q162NUMTURNI: TFloatField
      FieldName = 'NUMTURNI'
      Origin = 'T162_INDENNITA.NUMTURNI'
    end
    object Q162TURNI: TStringField
      FieldName = 'TURNI'
      Origin = 'T162_INDENNITA.TURNI'
      Size = 4
    end
    object Q162ASSENZE: TStringField
      FieldName = 'ASSENZE'
      Origin = 'T162_INDENNITA.ASSENZE'
      Size = 1000
    end
    object Q162CODICE2: TStringField
      FieldName = 'CODICE2'
      Origin = 'T162_INDENNITA.CODICE2'
      Size = 5
    end
    object Q162TURNO1: TFloatField
      FieldName = 'TURNO1'
    end
    object Q162TURNO2: TFloatField
      FieldName = 'TURNO2'
    end
    object Q162TURNO3: TFloatField
      FieldName = 'TURNO3'
    end
    object Q162TURNO4: TFloatField
      FieldName = 'TURNO4'
    end
    object Q162PRIORITA: TIntegerField
      FieldName = 'PRIORITA'
    end
    object Q162INDENNITA_INCOMPATIBILI: TStringField
      FieldName = 'INDENNITA_INCOMPATIBILI'
      Size = 200
    end
    object Q162COEFFICIENTE: TFloatField
      FieldName = 'COEFFICIENTE'
    end
    object Q162ARROTONDAMENTO: TStringField
      FieldName = 'ARROTONDAMENTO'
      Size = 1
    end
    object Q162ASSENZE_ABILITATE: TStringField
      FieldName = 'ASSENZE_ABILITATE'
      Size = 1000
    end
    object Q162SUPPL_5GGLAV: TStringField
      FieldName = 'SUPPL_5GGLAV'
      Size = 1
    end
    object Q162CAUPRES_RIEPORE: TStringField
      FieldName = 'CAUPRES_RIEPORE'
      Size = 5
    end
    object Q162D_CAUPRES_RIEPORE: TStringField
      FieldKind = fkLookup
      FieldName = 'D_CAUPRES_RIEPORE'
      LookupDataSet = selT275Escluse
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAUPRES_RIEPORE'
      Size = 40
      Lookup = True
    end
    object Q162NMESI_EQUITURNI: TFloatField
      FieldName = 'NMESI_EQUITURNI'
    end
  end
  object selT275Escluse: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE FROM T275_CAUPRESENZE '
      'WHERE ORENORMALI = '#39'A'#39
      'ORDER BY CODICE')
    Optimize = False
    Left = 424
    Top = 128
    object selT275EscluseCODICE: TStringField
      DisplayWidth = 7
      FieldName = 'CODICE'
      Size = 5
    end
    object selT275EscluseDESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
end
