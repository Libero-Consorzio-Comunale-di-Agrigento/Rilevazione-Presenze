inherited B110FInsTimbraturaDM: TB110FInsTimbraturaDM
  OldCreateOrder = True
  object selVT100: TOracleDataSet
    SQL.Strings = (
      'select VT100.*'
      'from   VT100_TIMB_DATAORA VT100'
      'where  VT100.PROGRESSIVO = :PROGRESSIVO '
      'and    VT100.DATA between :DAL and :AL '
      'and    VT100.FLAG in ('#39'O'#39','#39'I'#39')'
      'order by VT100.DATA, VT100.ORA, VT100.VERSO, VT100.FLAG')
    ReadBuffer = 40
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000080000003A00440041004C000C000000
      0000000000000000060000003A0041004C000C0000000000000000000000}
    ReadOnly = True
    Left = 32
    Top = 16
  end
end
