inherited A109FimmaginiMW: TA109FimmaginiMW
  OldCreateOrder = True
  object scrT004References: TOracleQuery
    SQL.Strings = (
      'declare'
      '  wConto integer;'
      'begin'
      '  :result:=null;'
      ''
      
        '  select count(*) into wConto from T004_IMMAGINI where CODICE = ' +
        ':CODICE;'
      '  if wConto > 1 then'
      '    return;'
      '  end if; '
      ''
      '  select count(*) into wConto'
      '  from T440_AZIENDE_BASE T440 '
      '  where LOGO = :CODICE;'
      ''
      '  if wConto > 1 then'
      '    :result:=wConto;'
      '  end if;'
      'end;')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A0052004500530055004C005400050000000000
      0000000000000E0000003A0043004F0044004900430045000500000000000000
      00000000}
    Left = 40
    Top = 16
  end
end
