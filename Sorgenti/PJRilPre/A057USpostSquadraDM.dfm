inherited A057FSpostSquadraDM: TA057FSpostSquadraDM
  OldCreateOrder = True
  Height = 100
  Width = 90
  object Q630: TOracleDataSet
    SQL.Strings = (
      'SELECT T630.*,T630.ROWID FROM T630_SPOSTSQUADRA T630'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      'ORDER BY DATA,SQUADRA')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    OnTranslateMessage = OnTranslateMessage
    BeforeInsert = BeforeInsert
    BeforeEdit = BeforeEdit
    BeforePost = BeforePostNoStorico
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    AfterScroll = Q630AfterScroll
    OnCalcFields = Q630CalcFields
    OnNewRecord = Q630NewRecord
    Left = 12
    Top = 8
    object Q630PROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object Q630DATA: TDateTimeField
      DisplayLabel = 'Data'
      FieldName = 'DATA'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object Q630SQUADRA: TStringField
      DisplayLabel = 'Cod. Squadra'
      FieldName = 'SQUADRA'
      Required = True
      Size = 10
    end
    object Q630DESC_SQUADRA: TStringField
      DisplayLabel = 'Desc. squadra'
      FieldKind = fkCalculated
      FieldName = 'DESC_SQUADRA'
      Size = 40
      Calculated = True
    end
    object Q630COD_TIPOOPE: TStringField
      DisplayLabel = 'Tipo operatore'
      FieldName = 'COD_TIPOOPE'
      Size = 5
    end
    object Q630ORARIO: TStringField
      DisplayLabel = 'Cod. orario'
      FieldName = 'ORARIO'
      Size = 5
    end
    object Q630DESC_ORARIO: TStringField
      DisplayLabel = 'Desc. orario'
      FieldKind = fkCalculated
      FieldName = 'DESC_ORARIO'
      Size = 40
      Calculated = True
    end
    object Q630TURNO1: TStringField
      DisplayLabel = 'Sigla turno 1'
      DisplayWidth = 2
      FieldName = 'TURNO1'
      Size = 2
    end
    object Q630TURNO2: TStringField
      DisplayLabel = 'Sigla turno 2'
      DisplayWidth = 2
      FieldName = 'TURNO2'
      Size = 2
    end
  end
end
