inherited WA106FDistanzeTrasfertaDM: TWA106FDistanzeTrasfertaDM
  Height = 133
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      
        'select t.*,t.rowid,c1.desc_partenza,c1.citta1,c1.cap1,c1.prov1,c' +
        '2.desc_destinazione,c2.citta2,c2.cap2,c2.prov2'
      'from m041_distanze t,'
      
        '     (select ('#39'C'#39' || codice) as codice, citta as desc_partenza, ' +
        'citta as citta1, cap as cap1 ,provincia as prov1'
      '      from   t480_comuni'
      '      union all'
      
        '      select ('#39'P'#39' || m042.codice) as codice, m042.descrizione,t4' +
        '80.citta, t480.cap, t480.provincia'
      '      from   m042_localita m042, t480_comuni t480'
      '      where  t480.codice (+) = m042.cod_istat'
      '      ) c1,'
      
        '     (select ('#39'C'#39' || codice) as codice, citta as desc_destinazio' +
        'ne, citta as citta2, cap as cap2 ,provincia as prov2'
      '      from t480_comuni'
      '      union all'
      
        '      select ('#39'P'#39' || m042.codice) as codice, m042.descrizione, t' +
        '480.citta, t480.cap, t480.provincia'
      '      from   m042_localita m042, t480_comuni t480'
      '      where  t480.codice (+) = m042.cod_istat  '
      '      ) c2    '
      'where t.tipo1 || t.localita1 = c1.codice'
      'and   t.tipo2 || t.localita2 = c2.codice'
      ':ORDERBY')
    object selTabelladesc_partenza: TStringField
      DisplayLabel = 'Localit'#224' partenza'
      FieldName = 'DESC_PARTENZA'
      Size = 60
    end
    object selTabellaTIPO1: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO1'
      Size = 1
    end
    object selTabellaLOCALITA1: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'LOCALITA1'
      Size = 6
    end
    object selTabellaCITTA1: TStringField
      FieldName = 'CITTA1'
      Size = 60
    end
    object selTabellacap1: TStringField
      DisplayLabel = 'Cap'
      FieldName = 'CAP1'
    end
    object selTabellaprov1: TStringField
      DisplayLabel = 'Prov.'
      FieldName = 'PROV1'
    end
    object selTabelladesc_destinazione: TStringField
      DisplayLabel = 'Localit'#224' arrivo'
      FieldName = 'DESC_DESTINAZIONE'
      Size = 60
    end
    object selTabellaTIPO2: TStringField
      DisplayLabel = 'Tipo '
      FieldName = 'TIPO2'
      Size = 1
    end
    object selTabellaLOCALITA2: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'LOCALITA2'
    end
    object selTabellaCITTA2: TStringField
      FieldName = 'CITTA2'
      Size = 60
    end
    object selTabellacap2: TStringField
      DisplayLabel = 'Cap'
      FieldName = 'CAP2'
    end
    object selTabellaprov2: TStringField
      DisplayLabel = 'Prov.'
      FieldName = 'PROV2'
    end
    object selTabellaCHILOMETRI: TFloatField
      DisplayLabel = 'Chilometri'
      FieldName = 'CHILOMETRI'
    end
  end
end
