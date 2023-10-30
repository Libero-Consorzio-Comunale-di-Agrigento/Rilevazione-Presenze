object W038FBollatriceVirtualeDM: TW038FBollatriceVirtualeDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 92
  Width = 192
  object selT361: TOracleDataSet
    SQL.Strings = (
      'select CODICE,INDIRIZZO_IP,INDIRIZZO '
      'from T361_OROLOGI '
      'where INDIRIZZO_IP is not null '
      'or INDIRIZZO is not null')
    Optimize = False
    Left = 32
    Top = 16
  end
  object selT275Abilitate: TOracleDataSet
    SQL.Strings = (
      'select '#39'T275'#39' TIPO, T275.CODICE, T275.DESCRIZIONE'
      'from   T275_CAUPRESENZE T275, T430_STORICO T430'
      'where  T430.PROGRESSIVO = :PROGRESSIVO'
      'and    :DATA between T430.DATADECORRENZA and T430.DATAFINE'
      
        'and    instr('#39','#39'||T430.ABPRESENZA1||'#39','#39','#39','#39'||T275.CODRAGGR||'#39','#39')' +
        ' > 0'
      'and    T275.INSERIMENTO_TIMB = '#39'S'#39
      'and    T275.INSERIMENTO_TIMBVIRT = '#39'S'#39
      'union --richiesto dal CSI e CISAP'
      'select '#39'T305'#39' TIPO, T305.CODICE, T305.DESCRIZIONE'
      'from   T305_CAUGIUSTIF T305, T300_RAGGRGIUSTIF T300'
      'where  T305.CODRAGGR = T300.CODICE'
      '--and    T300.CODINTERNO = '#39'B'#39
      'order by 2')
    ReadBuffer = 200
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Filtered = True
    OnFilterRecord = selT275AbilitateFilterRecord
    Left = 109
    Top = 16
  end
end
