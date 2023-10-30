inherited B110FCartelliniDM: TB110FCartelliniDM
  OldCreateOrder = True
  object selCartellini: TOracleDataSet
    SQL.Strings = (
      'select T.DATA, '
      
        '       trim(to_char(T.DATA,'#39'month'#39'))||to_char(T.DATA,'#39' yyyy'#39') LB' +
        'L_DATA,'
      
        '       decode(VT860.T850STATO,null,null,'#39'(validato)'#39') LBL_VALIDA' +
        'TO'
      'from   ('
      '        select add_months(trunc(:DATA2,'#39'mm'#39'),-ROWNUM + 1) DATA'
      '        from dual '
      '        connect by ROWNUM <= (months_between(:DATA2,:DATA1) + 1)'
      '       ) T, '
      '       VT860_ITER_STAMPACARTELLINI VT860'
      'where  VT860.PROGRESSIVO(+) = :PROGRESSIVO'
      'and    VT860.T860MESE_CARTELLINO(+) = T.DATA'
      'and    VT860.T850STATO(+) = '#39'S'#39
      'and    T.DATA >= :WEB_CARTELLINI_DATAMIN and'
      '       (:WEB_CARTELLINI_MMPREC < 0 or '
      
        '        T.DATA >= add_months(trunc(sysdate,'#39'MM'#39'),-:WEB_CARTELLIN' +
        'I_MMPREC))'
      'order by 1 desc')
    Optimize = False
    Variables.Data = {
      04000000050000000C0000003A00440041005400410032000C00000000000000
      000000000C0000003A00440041005400410031000C0000000000000000000000
      180000003A00500052004F0047005200450053005300490056004F0003000000
      00000000000000002E0000003A005700450042005F0043004100520054004500
      4C004C0049004E0049005F0044004100540041004D0049004E000C0000000000
      0000000000002C0000003A005700450042005F00430041005200540045004C00
      4C0049004E0049005F004D004D00500052004500430003000000000000000000
      0000}
    Left = 32
    Top = 16
  end
end
