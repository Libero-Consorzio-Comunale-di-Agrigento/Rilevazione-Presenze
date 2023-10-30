inherited A203FDatiMensiliPersonalizzatiMW: TA203FDatiMensiliPersonalizzatiMW
  OldCreateOrder = True
  object selP200: TOracleDataSet
    SQL.Strings = (
      
        'select distinct COD_VOCE, DESCRIZIONE from p200_voci t where COD' +
        '_VOCE_SPECIALE = '#39'BASE'#39' --and TIPO='#39'AS'#39
      'order by DESCRIZIONE')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000020000001000000043004F0044005F0056004F004300450001000000
      0000160000004400450053004300520049005A0049004F004E00450001000000
      0000}
    Left = 64
    Top = 40
  end
end
