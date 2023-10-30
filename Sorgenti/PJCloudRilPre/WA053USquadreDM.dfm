inherited WA053FSquadreDM: TWA053FSquadreDM
  Height = 314
  Width = 566
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T600.*,T600.ROWID FROM T600_SQUADRE T600 :ORDERBY')
    BeforeDelete = selTabellaBeforeDelete
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Size = 5
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selTabellaDESCRIZIONELUNGA: TStringField
      DisplayLabel = 'Descrizione Estesa'
      FieldName = 'DESCRIZIONELUNGA'
      Size = 80
    end
    object selTabellaTOTMIN1: TIntegerField
      DisplayLabel = 'Turno 1 Fr Min'
      FieldName = 'TOTMIN1'
    end
    object selTabellaTOTMIN2: TIntegerField
      DisplayLabel = 'Turno 2 Fr Min'
      FieldName = 'TOTMIN2'
    end
    object selTabellaTOTMIN3: TIntegerField
      DisplayLabel = 'Turno 3 Fr Min'
      FieldName = 'TOTMIN3'
    end
    object selTabellaTOTMIN4: TIntegerField
      DisplayLabel = 'Turno 4 Fr Min'
      FieldName = 'TOTMIN4'
    end
    object selTabellaFESMIN1: TIntegerField
      DisplayLabel = 'Turno 1 Fs Min'
      FieldName = 'FESMIN1'
    end
    object selTabellaFESMIN2: TIntegerField
      DisplayLabel = 'Turno 2 Fs Min'
      FieldName = 'FESMIN2'
    end
    object selTabellaFESMIN3: TIntegerField
      DisplayLabel = 'Turno 3 Fs Min'
      FieldName = 'FESMIN3'
    end
    object selTabellaFESMIN4: TIntegerField
      DisplayLabel = 'Turno 5 Fs Min'
      FieldName = 'FESMIN4'
    end
    object selTabellaTOTMAX1: TIntegerField
      FieldName = 'TOTMAX1'
      Visible = False
    end
    object selTabellaTOTMAX2: TIntegerField
      FieldName = 'TOTMAX2'
      Visible = False
    end
    object selTabellaTOTMAX3: TIntegerField
      FieldName = 'TOTMAX3'
      Visible = False
    end
    object selTabellaTOTMAX4: TIntegerField
      FieldName = 'TOTMAX4'
      Visible = False
    end
    object selTabellaFESMAX1: TIntegerField
      FieldName = 'FESMAX1'
      Visible = False
    end
    object selTabellaFESMAX2: TIntegerField
      FieldName = 'FESMAX2'
      Visible = False
    end
    object selTabellaFESMAX3: TIntegerField
      FieldName = 'FESMAX3'
      Visible = False
    end
    object selTabellaFESMAX4: TIntegerField
      FieldName = 'FESMAX4'
      Visible = False
    end
    object selTabellaCAUS_RIPOSO: TStringField
      FieldName = 'CAUS_RIPOSO'
      Visible = False
      Size = 5
    end
    object selTabellaMIN_IND1: TIntegerField
      FieldName = 'MIN_IND1'
      Visible = False
    end
    object selTabellaMIN_IND2: TIntegerField
      FieldName = 'MIN_IND2'
      Visible = False
    end
    object selTabellaMIN_IND3: TIntegerField
      FieldName = 'MIN_IND3'
      Visible = False
    end
    object selTabellaMIN_IND4: TIntegerField
      FieldName = 'MIN_IND4'
      Visible = False
    end
    object selTabellaPERIODO_MATUR_IND: TIntegerField
      FieldName = 'PERIODO_MATUR_IND'
      Visible = False
    end
    object selTabellaMIN_FESTIVITA_MESE: TIntegerField
      FieldName = 'MIN_FESTIVITA_MESE'
      Visible = False
    end
    object selTabellaPRIORITA_MINMAX: TStringField
      FieldName = 'PRIORITA_MINMAX'
      Visible = False
      Size = 4
    end
    object selTabellaMAX_NOTTI_MESE: TIntegerField
      FieldName = 'MAX_NOTTI_MESE'
    end
  end
  object dsrT601: TDataSource
    DataSet = selT601
    Left = 24
    Top = 200
  end
  object selT601: TOracleDataSet
    SQL.Strings = (
      'SELECT T601.*,T601.ROWID FROM T601_TIPIOPERATORE T601'
      'WHERE SQUADRA = :SQUADRA'
      ':ORDERBY')
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A00530051005500410044005200410005000000
      0000000000000000100000003A004F0052004400450052004200590001000000
      0000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000130000000E0000005300510055004100440052004100010000000000
      0C00000043004F004400490043004500010000000000080000004D0049004E00
      3100010000000000080000004D00410058003100010000000000080000004D00
      49004E003200010000000000080000004D004100580032000100000000000800
      00004D0049004E003300010000000000080000004D0041005800330001000000
      0000080000004D0049004E003400010000000000080000004D00410058003400
      0100000000000C0000005400550052004E0041005A000100000000000C000000
      4F0052004100520049004F00010000000000160000004F005400540049004D00
      41004C004500310046005200010000000000160000004F005400540049004D00
      41004C004500310046005300010000000000160000004F005400540049004D00
      41004C004500320046005200010000000000160000004F005400540049004D00
      41004C004500320046005300010000000000160000004F005400540049004D00
      41004C004500330046005200010000000000160000004F005400540049004D00
      41004C0045003300460053000100000000000E000000500052004F0046004900
      4C004F00010000000000}
    BeforePost = selT601BeforePost
    BeforeDelete = selT601BeforeDelete
    Left = 24
    Top = 136
    object selT601CODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Required = True
      Size = 5
    end
    object selT601MIN1: TIntegerField
      DisplayWidth = 5
      FieldName = 'Min1'
    end
    object selT601MAX1: TIntegerField
      DisplayWidth = 5
      FieldName = 'Max1'
    end
    object selT601FESMIN1: TIntegerField
      DisplayLabel = 'Min Fest. 1'
      FieldName = 'FESMIN1'
    end
    object selT601FESMAX1: TIntegerField
      DisplayLabel = 'Max Fest. 1'
      FieldName = 'FESMAX1'
    end
    object selT601OTTIMALE1FR: TIntegerField
      DisplayLabel = 'Ott. 1 Fer.'
      FieldName = 'OTTIMALE1FR'
    end
    object selT601OTTIMALE1FS: TIntegerField
      DisplayLabel = 'Ott. 1 Fer.'
      FieldName = 'OTTIMALE1FS'
    end
    object selT601MIN2: TIntegerField
      DisplayLabel = 'Min2'
      DisplayWidth = 5
      FieldName = 'MIN2'
    end
    object selT601MAX2: TIntegerField
      DisplayLabel = 'Max2'
      DisplayWidth = 5
      FieldName = 'MAX2'
    end
    object selT601FESMIN2: TIntegerField
      DisplayLabel = 'Min Fest. 2'
      FieldName = 'FESMIN2'
    end
    object selT601FESMAX2: TIntegerField
      DisplayLabel = 'Max Fest. 2'
      FieldName = 'FESMAX2'
    end
    object selT601OTTIMALE2FR: TIntegerField
      DisplayLabel = 'Ott. 2 Fer.'
      FieldName = 'OTTIMALE2FR'
    end
    object selT601OTTIMALE2FS: TIntegerField
      DisplayLabel = 'Ott. 2 Fest.'
      FieldName = 'OTTIMALE2FS'
    end
    object selT601MIN3: TIntegerField
      DisplayLabel = 'Min3'
      DisplayWidth = 5
      FieldName = 'MIN3'
    end
    object selT601MAX3: TIntegerField
      DisplayLabel = 'Max3'
      DisplayWidth = 5
      FieldName = 'MAX3'
    end
    object selT601FESMIN3: TIntegerField
      DisplayLabel = 'Min Fest. 3'
      FieldName = 'FESMIN3'
    end
    object selT601FESMAX3: TIntegerField
      DisplayLabel = 'Max Fest. 3'
      FieldName = 'FESMAX3'
    end
    object selT601OTTIMALE3FR: TIntegerField
      DisplayLabel = 'Ott. 3 Fer.'
      FieldName = 'OTTIMALE3FR'
    end
    object selT601OTTIMALE3FS: TIntegerField
      DisplayLabel = 'Ott. 3 Fest.'
      FieldName = 'OTTIMALE3FS'
    end
    object selT601MIN4: TIntegerField
      DisplayLabel = 'Min4'
      DisplayWidth = 5
      FieldName = 'MIN4'
    end
    object selT601MAX4: TIntegerField
      DisplayLabel = 'Max4'
      DisplayWidth = 5
      FieldName = 'MAX4'
    end
    object selT601FESMIN4: TIntegerField
      DisplayLabel = 'Min Fest. 4'
      FieldName = 'FESMIN4'
    end
    object selT601FESMAX4: TIntegerField
      DisplayLabel = 'Max Fest. 4'
      FieldName = 'FESMAX4'
    end
    object selT601SQUADRA: TStringField
      FieldName = 'SQUADRA'
      Required = True
      Visible = False
      Size = 5
    end
    object selT601ORARIO: TStringField
      FieldName = 'ORARIO'
      Visible = False
      Size = 5
    end
    object selT601PROFILO: TStringField
      DisplayLabel = 'Prof. Turni'
      FieldName = 'PROFILO'
      Size = 5
    end
    object selT601TURNAZ: TStringField
      DisplayLabel = 'Turnazione'
      FieldName = 'TURNAZ'
      Size = 5
    end
  end
  object selT265: TOracleDataSet
    SQL.Strings = (
      'SELECT T265.CODICE, T265.DESCRIZIONE'
      '  FROM T265_CAUASSENZE T265, T260_RAGGRASSENZE T260'
      ' WHERE T265.CODRAGGR = T260.CODICE'
      '   AND T260.CODINTERNO = '#39'H'#39
      ' ORDER BY CODICE')
    Optimize = False
    Left = 96
    Top = 136
  end
  object selT602: TOracleDataSet
    SQL.Strings = (
      
        'select CODICE, DESCRIZIONE from t602_profiliturni order by codic' +
        'e')
    Optimize = False
    Left = 216
    Top = 136
  end
  object selT640: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE FROM T640_TURNAZIONI '
      'ORDER BY CODICE')
    Optimize = False
    Left = 160
    Top = 136
  end
  object selT601AggiornaSquadra: TOracleQuery
    SQL.Strings = (
      'UPDATE T601_TIPIOPERATORE SET SQUADRA = :SQUADRA '
      'WHERE SQUADRA = :SQUADRA_OLD')
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A00530051005500410044005200410005000000
      0000000000000000180000003A0053005100550041004400520041005F004F00
      4C004400050000000000000000000000}
    Left = 224
    Top = 200
  end
  object Q651: TOracleDataSet
    SQL.Strings = (
      'SELECT T651.*,T651.ROWID FROM T651_AREE_SQUADRA T651'
      'WHERE CODICE_SQUADRA = :SQUADRA'
      'ORDER BY CODICE_OPERATORE, CODICE_AREA')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A00530051005500410044005200410005000000
      0000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000130000000E0000005300510055004100440052004100010000000000
      0C00000043004F004400490043004500010000000000080000004D0049004E00
      3100010000000000080000004D00410058003100010000000000080000004D00
      49004E003200010000000000080000004D004100580032000100000000000800
      00004D0049004E003300010000000000080000004D0041005800330001000000
      0000080000004D0049004E003400010000000000080000004D00410058003400
      0100000000000C0000005400550052004E0041005A000100000000000C000000
      4F0052004100520049004F00010000000000160000004F005400540049004D00
      41004C004500310046005200010000000000160000004F005400540049004D00
      41004C004500310046005300010000000000160000004F005400540049004D00
      41004C004500320046005200010000000000160000004F005400540049004D00
      41004C004500320046005300010000000000160000004F005400540049004D00
      41004C004500330046005200010000000000160000004F005400540049004D00
      41004C0045003300460053000100000000000E000000500052004F0046004900
      4C004F00010000000000}
    CachedUpdates = True
    OnNewRecord = Q651NewRecord
    Left = 448
    Top = 16
    object Q651Codice_Squadra: TStringField
      FieldName = 'Codice_Squadra'
      Visible = False
      Size = 5
    end
    object Q651Codice_Operatore: TStringField
      DisplayLabel = 'Tipo operatore'
      FieldName = 'Codice_Operatore'
      Size = 5
    end
    object Q651Codice_Area: TStringField
      DisplayLabel = 'Area'
      FieldName = 'Codice_Area'
      Size = 10
    end
  end
  object selT650: TOracleDataSet
    SQL.Strings = (
      
        'select CODICE, DESCRIZIONE, CODICE||'#39'-'#39'||DESCRIZIONE DECODIFICA ' +
        'from T650_AREE_TURNI'
      'order by CODICE')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000130000000E0000005300510055004100440052004100010000000000
      0C00000043004F004400490043004500010000000000080000004D0049004E00
      3100010000000000080000004D00410058003100010000000000080000004D00
      49004E003200010000000000080000004D004100580032000100000000000800
      00004D0049004E003300010000000000080000004D0041005800330001000000
      0000080000004D0049004E003400010000000000080000004D00410058003400
      0100000000000C0000005400550052004E0041005A000100000000000C000000
      4F0052004100520049004F00010000000000160000004F005400540049004D00
      41004C004500310046005200010000000000160000004F005400540049004D00
      41004C004500310046005300010000000000160000004F005400540049004D00
      41004C004500320046005200010000000000160000004F005400540049004D00
      41004C004500320046005300010000000000160000004F005400540049004D00
      41004C004500330046005200010000000000160000004F005400540049004D00
      41004C0045003300460053000100000000000E000000500052004F0046004900
      4C004F00010000000000}
    ReadOnly = True
    Left = 504
    Top = 16
  end
  object lstT601: TOracleDataSet
    SQL.Strings = (
      'select CODICE, CODICE as DESCRIZIONE from T601_TIPIOPERATORE'
      'where SQUADRA = :SQUADRA'
      'union'
      'select '#39'<*>'#39' CODICE, '#39'Tutti'#39' as DESCRIZIONE from DUAL'
      'order by CODICE')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A00530051005500410044005200410005000000
      0000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000130000000E0000005300510055004100440052004100010000000000
      0C00000043004F004400490043004500010000000000080000004D0049004E00
      3100010000000000080000004D00410058003100010000000000080000004D00
      49004E003200010000000000080000004D004100580032000100000000000800
      00004D0049004E003300010000000000080000004D0041005800330001000000
      0000080000004D0049004E003400010000000000080000004D00410058003400
      0100000000000C0000005400550052004E0041005A000100000000000C000000
      4F0052004100520049004F00010000000000160000004F005400540049004D00
      41004C004500310046005200010000000000160000004F005400540049004D00
      41004C004500310046005300010000000000160000004F005400540049004D00
      41004C004500320046005200010000000000160000004F005400540049004D00
      41004C004500320046005300010000000000160000004F005400540049004D00
      41004C004500330046005200010000000000160000004F005400540049004D00
      41004C0045003300460053000100000000000E000000500052004F0046004900
      4C004F00010000000000}
    ReadOnly = True
    Left = 400
    Top = 16
  end
  object Q651CancellaSquadra: TOracleQuery
    SQL.Strings = (
      'DELETE FROM T651_AREE_SQUADRA'
      'WHERE CODICE_SQUADRA = :SQUADRA')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A00530051005500410044005200410005000000
      0000000000000000}
    Left = 448
    Top = 69
  end
  object Q651CancellaOperatore: TOracleQuery
    SQL.Strings = (
      'delete from T651_AREE_SQUADRA'
      'where CODICE_SQUADRA = :SQUADRA'
      'and CODICE_OPERATORE = :OPERATORE'
      '')
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A00530051005500410044005200410005000000
      0000000000000000140000003A004F00500045005200410054004F0052004500
      050000000000000000000000}
    Left = 448
    Top = 117
  end
  object Q651AggiornaSquadra: TOracleQuery
    SQL.Strings = (
      'UPDATE T651_AREE_SQUADRA SET CODICE_SQUADRA = :SQUADRA '
      'WHERE CODICE_SQUADRA = :SQUADRA_OLD')
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A00530051005500410044005200410005000000
      0000000000000000180000003A0053005100550041004400520041005F004F00
      4C004400050000000000000000000000}
    Left = 448
    Top = 164
  end
  object Q651AggiornaOperatore: TOracleQuery
    SQL.Strings = (
      'update T651_AREE_SQUADRA '
      'set    CODICE_OPERATORE = :OPERATORE'
      'where  CODICE_OPERATORE = :OPERATORE_OLD '
      'and    CODICE_SQUADRA = :SQUADRA')
    Optimize = False
    Variables.Data = {
      0400000003000000100000003A00530051005500410044005200410005000000
      0000000000000000140000003A004F00500045005200410054004F0052004500
      0500000000000000000000001C0000003A004F00500045005200410054004F00
      520045005F004F004C004400050000000000000000000000}
    Left = 448
    Top = 213
  end
  object D651: TDataSource
    DataSet = Q651
    Left = 448
    Top = 266
  end
  object selT601CancellaSquadra: TOracleQuery
    SQL.Strings = (
      'DELETE FROM T601_TIPIOPERATORE '
      'WHERE SQUADRA = :SQUADRA')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A00530051005500410044005200410005000000
      0000000000000000}
    Left = 104
    Top = 200
  end
end
