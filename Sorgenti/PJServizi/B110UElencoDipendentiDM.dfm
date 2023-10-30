inherited B110FElencoDipendentiDM: TB110FElencoDipendentiDM
  OldCreateOrder = True
  Height = 134
  object selT033Nome: TOracleQuery
    SQL.Strings = (
      'declare'
      '  wConta integer;'
      'begin'
      '  :result:=:LAYOUT;'
      
        '  select count(*) into wConta from T033_LAYOUT where NOME = :LAY' +
        'OUT;'
      '  if wConta = 0 then'
      '    :result:=:OPERATORE;'
      
        '    select count(*) into wConta from T033_LAYOUT where NOME = :O' +
        'PERATORE;'
      '    if wConta = 0 then'
      '      :result:='#39'DEFAULT'#39';'
      '    end if;'
      '  end if;'
      'end;')
    Optimize = False
    Variables.Data = {
      04000000030000000E0000003A0052004500530055004C005400050000000800
      000044454641554C5400000000000E0000003A004C00410059004F0055005400
      050000000000000000000000140000003A004F00500045005200410054004F00
      52004500050000000000000000000000}
    Left = 24
    Top = 8
  end
  object selAnagrafe: TOracleDataSet
    Optimize = False
    Variables.Data = {
      0400000002000000160000003A0044004100540041004C00410056004F005200
      4F000C00000000000000000000000E0000003A00460049004C00540052004F00
      010000000000000000000000}
    Left = 27
    Top = 65
  end
  object cdsI010: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 96
    Top = 63
  end
end
