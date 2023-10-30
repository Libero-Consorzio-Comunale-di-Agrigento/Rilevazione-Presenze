inherited A156FNotificheIrisWEBMW: TA156FNotificheIrisWEBMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 79
  Width = 251
  object selElencoProc: TOracleDataSet
    SQL.Strings = (
      'select a.object_name, count(*) '
      'from   user_procedures p,'
      '       user_arguments a'
      'where  a.object_name = p.object_name'
      'and    p.object_type = '#39'PROCEDURE'#39
      'group by a.object_name'
      'having count(*) = :NUMERO_PARAMETRI'
      'order by a.object_name')
    Optimize = False
    Variables.Data = {
      0400000001000000220000003A004E0055004D00450052004F005F0050004100
      520041004D004500540052004900030000000000000000000000}
    Left = 24
    Top = 16
  end
  object selArgomentiProc: TOracleDataSet
    SQL.Strings = (
      'select a.position, a.argument_name, a.data_type, a.in_out'
      'from   user_procedures p,'
      '       user_arguments a'
      'where  a.object_name = p.object_name'
      'and    a.object_name = :NOME_PROCEDURA'
      'order by a.position')
    Optimize = False
    Variables.Data = {
      04000000010000001E0000003A004E004F004D0045005F00500052004F004300
      45004400550052004100050000000000000000000000}
    Left = 104
    Top = 16
  end
  object cdsProc: TClientDataSet
    PersistDataPacket.Data = {
      330000009619E0BD0100000018000000010000000000030000003300044E4F4D
      450100490000000100055749445448020002001E000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 192
    Top = 16
    object cdsProcNOME: TStringField
      FieldName = 'NOME'
      Size = 30
    end
  end
end
