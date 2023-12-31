inherited A036FTurniRepMW: TA036FTurniRepMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 78
  Width = 79
  object selT350: TOracleDataSet
    SQL.Strings = (
      
        'SELECT DISTINCT '#39'VP_TURNO'#39' TIPO,VP_TURNO VOCEPAGHE FROM T350_REG' +
        'REPERIB WHERE VP_TURNO NOT IN ('#39'<SI>'#39','#39'<NO>'#39') AND VP_TURNO IS NO' +
        'T NULL'
      'UNION'
      
        'SELECT DISTINCT '#39'VP_ORE'#39' TIPO,VP_ORE VOCEPAGHE FROM T350_REGREPE' +
        'RIB WHERE VP_ORE NOT IN ('#39'<SI>'#39','#39'<NO>'#39') AND VP_ORE IS NOT NULL'
      'UNION'
      
        'SELECT DISTINCT '#39'VP_MAGGIORATE'#39' TIPO,VP_MAGGIORATE VOCEPAGHE FRO' +
        'M T350_REGREPERIB WHERE VP_MAGGIORATE NOT IN ('#39'<SI>'#39','#39'<NO>'#39') AND' +
        ' VP_MAGGIORATE IS NOT NULL'
      'UNION'
      
        'SELECT DISTINCT '#39'VP_NONMAGGIORATE'#39' TIPO,VP_NONMAGGIORATE VOCEPAG' +
        'HE FROM T350_REGREPERIB WHERE VP_NONMAGGIORATE NOT IN ('#39'<SI>'#39','#39'<' +
        'NO>'#39') AND VP_NONMAGGIORATE IS NOT NULL'
      'UNION'
      
        'SELECT DISTINCT '#39'VP_GETTONE_CHIAMATA'#39' TIPO,VP_GETTONE_CHIAMATA V' +
        'OCEPAGHE FROM T350_REGREPERIB WHERE VP_GETTONE_CHIAMATA NOT IN (' +
        #39'<SI>'#39','#39'<NO>'#39') AND VP_GETTONE_CHIAMATA IS NOT NULL'
      'UNION'
      
        'SELECT DISTINCT '#39'VP_TURNI_OLTREMAX'#39' TIPO,VP_TURNI_OLTREMAX VOCEP' +
        'AGHE FROM T350_REGREPERIB WHERE VP_TURNI_OLTREMAX NOT IN ('#39'<SI>'#39 +
        ','#39'<NO>'#39') AND VP_TURNI_OLTREMAX IS NOT NULL')
    Optimize = False
    Left = 24
    Top = 12
  end
end
