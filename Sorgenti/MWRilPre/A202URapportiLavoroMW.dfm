inherited A202FRapportiLavoroMW: TA202FRapportiLavoroMW
  OldCreateOrder = True
  Height = 274
  Width = 695
  object selT450: TOracleDataSet
    SQL.Strings = (
      
        'select T450.CODICE,T450.DESCRIZIONE,T450.CODICE||'#39' - '#39'||T450.DES' +
        'CRIZIONE COD_DESC, T450.TIPO'
      'from   T450_TIPORAPPORTO T450'
      'order by T450.CODICE')
    ReadBuffer = 100
    Optimize = False
    ReadOnly = True
    Filtered = True
    OnFilterRecord = FiltroDizionario
    Left = 24
    Top = 24
    object selT450CODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Size = 10
    end
    object selT450DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 45
      FieldName = 'DESCRIZIONE'
      Size = 80
    end
    object selT450COD_DESC: TStringField
      FieldName = 'COD_DESC'
      Size = 50
    end
    object selT450TIPO: TStringField
      FieldName = 'TIPO'
      Size = 1
    end
  end
  object selT430: TOracleDataSet
    SQL.Strings = (
      'select distinct '
      '  T430.PROGRESSIVO, '
      '  T430.INIZIO, T430.FINE, '
      
        '  T430.TIPORAPPORTO TIPO_RAPPORTO, T450.CODICE||'#39' - '#39'||T450.DESC' +
        'RIZIONE D_TIPORAPPORTO, T450.TIPO,'
      
        '  T430.PARTTIME, T460.DESCRIZIONE D_PARTTIME, T460.TIPO TIPO_PT,' +
        ' T460.PIANTA PERC_PT,'
      '  :DAL_AP DAL_AP,'
      '  :AL_AP AL_AP,'
      '  --:DAL DAL,'
      '  --:AL AL,'
      '  :ENTE ENTE, --t.cod_ente ENTE'
      '  :QUALIFICA QUALIFICA,  --null QUALIFICA'
      '  :DISCIPLINA DISCIPLINA,'
      '  :INIZIO_RAPGIUR INIZIO_RAPGIUR,'
      '  :FINE_RAPGIUR FINE_RAPGIUR'
      ''
      
        '  from T430_STORICO T430, T450_TIPORAPPORTO T450, T460_PARTTIME ' +
        'T460 '
      ' where T430.PROGRESSIVO = :PROGRESSIVO '
      '   and T430.TIPORAPPORTO = T450.CODICE(+)'
      '   and T430.PARTTIME = T460.CODICE(+)'
      '   and T430.INIZIO is not null'
      
        '   and T430.DATAFINE >= LEAST(T430.INIZIO, nvl(:INIZIO_RAPGIUR, ' +
        'T430.INIZIO)) --T430.INIZIO '
      
        '   --and T430.DATADECORRENZA <= GREATEST(nvl(T430.FINE, to_date(' +
        #39'31123999'#39', '#39'ddmmyyyy'#39')),nvl(:FINE_RAPGIUR, nvl(T430.FINE, to_da' +
        'te('#39'31123999'#39', '#39'ddmmyyyy'#39')))) ??'
      
        '   and T430.DATADECORRENZA <= GREATEST(nvl(T430.FINE, to_date('#39'3' +
        '1123999'#39', '#39'ddmmyyyy'#39')),nvl(:FINE_RAPGIUR, to_date('#39'31123999'#39', '#39'd' +
        'dmmyyyy'#39')))'
      ' order by T430.INIZIO, :INIZIO_RAPGIUR, DAL_AP')
    Optimize = False
    Variables.Data = {
      0400000009000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0045004E00540045000100
      0000050000006E756C6C0000000000140000003A005100550041004C00490046
      0049004300410001000000050000006E756C6C0000000000160000003A004400
      490053004300490050004C0049004E00410001000000050000006E756C6C0000
      0000001E0000003A0049004E0049005A0049004F005F00520041005000470049
      0055005200010000000E000000544F5F44415445286E756C6C2900000000001A
      0000003A00460049004E0045005F005200410050004700490055005200010000
      000E000000544F5F44415445286E756C6C2900000000000E0000003A00440041
      004C005F0041005000010000000E000000544F5F44415445286E756C6C290000
      0000000C0000003A0041004C005F0041005000010000000E000000544F5F4441
      5445286E756C6C290000000000180000003A00460049004C00540052004F005F
      00460049004E0045000100000004000000313D310000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000150000001E0000005400300035003000500052004F00470052004500
      53005300490056004F0001000000000016000000540030003500300043004100
      5500530041004C0045000100000000001A000000540030003500300054004900
      50004F00470049005500530054000100000000000E0000005400300035003000
      440041004C000100000000000C000000540030003500300041004C0001000000
      00001A00000054003000350030004E0055004D00450052004F004F0052004500
      01000000000010000000540030003500300041004F0052004500010000000000
      16000000540030003500300044004100540041004E0041005300010000000000
      2400000054003000350030004E0055004D00450052004F004F00520045005F00
      50005200450056000100000000001A000000540030003500300041004F005200
      45005F0050005200450056000100000000001A00000054003000350030004500
      4C00410042004F005200410054004F0001000000000010000000540038003500
      3000490054004500520001000000000018000000540038003500300043004F00
      44005F0049005400450052000100000000000C00000054003800350030004900
      4400010000000000100000005400380035003000440041005400410001000000
      000012000000540038003500300053005400410054004F000100000000001000
      000054003800350030004E004F00540045000100000000002400000054003800
      350030005400490050004F005F00520049004300480049004500530054004100
      0100000000002E00000054003800350030004100550054004F00520049005A00
      5A005F004100550054004F004D00410054004900430041000100000000001A00
      00005400380035003000490044005F005200450056004F004300410001000000
      00001E0000005400380035003000490044005F005200450056004F0043004100
      54004F00010000000000}
    OnCalcFields = selT430CalcFields
    Left = 144
    Top = 24
    object selT430PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selT430DAL: TDateTimeField
      DisplayLabel = 'Dal'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'DAL'
      Visible = False
      Calculated = True
    end
    object selT430AL: TDateTimeField
      DisplayLabel = 'Al'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'AL'
      Visible = False
      Calculated = True
    end
    object selT430DAL_AP: TDateTimeField
      FieldName = 'DAL_AP'
      Visible = False
    end
    object selT430AL_AP: TDateTimeField
      FieldName = 'AL_AP'
      Visible = False
    end
    object selT430INIZIO: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Inizio Rapporto'
      DisplayWidth = 10
      FieldName = 'INIZIO'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selT430FINE: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Fine rapporto'
      DisplayWidth = 10
      FieldName = 'FINE'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selT430ENTE: TStringField
      DisplayLabel = 'Ente'
      FieldName = 'ENTE'
      Visible = False
      Size = 10
    end
    object selT430d_ENTE: TStringField
      DisplayLabel = 'Ente desc.'
      FieldKind = fkCalculated
      FieldName = 'd_ENTE'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'ENTE'
      Visible = False
      Size = 100
      Calculated = True
    end
    object selT430TIPO_RAPPORTO: TStringField
      DisplayLabel = 'Tipo rapporto'
      FieldName = 'TIPO_RAPPORTO'
      Visible = False
      Size = 5
    end
    object selT430D_TIPORAPPORTO: TStringField
      DisplayLabel = 'Tipo rapporto'
      FieldName = 'd_TIPORAPPORTO'
      Size = 60
    end
    object selT430TIPO: TStringField
      FieldName = 'TIPO'
      Visible = False
      Size = 1
    end
    object selT430D_TIPO: TStringField
      DisplayLabel = 'Tipologia'
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'd_TIPO'
      Size = 50
      Calculated = True
    end
    object selT430PARTTIME: TStringField
      DisplayLabel = 'Part time'
      FieldName = 'PARTTIME'
      Visible = False
      Size = 5
    end
    object selT430D_PARTTIME: TStringField
      DisplayLabel = 'Part time'
      FieldName = 'd_PARTTIME'
      Visible = False
      Size = 40
    end
    object selT430TIPO_PT: TStringField
      FieldName = 'TIPO_PT'
      Visible = False
      Size = 1
    end
    object selT430PERC_PT: TFloatField
      DisplayLabel = '% Presenza'
      FieldName = 'PERC_PT'
      Visible = False
    end
    object selT430d_TIPOPT: TStringField
      DisplayLabel = 'Tipo part time'
      FieldKind = fkCalculated
      FieldName = 'd_TIPOPT'
      Visible = False
      Size = 15
      Calculated = True
    end
    object selT430QUALIFICA: TStringField
      DisplayLabel = 'Qualifica'
      FieldName = 'QUALIFICA'
      Visible = False
      Size = 10
    end
    object selT430d_QUALIFICA: TStringField
      DisplayLabel = 'Qualifica desc.'
      FieldKind = fkCalculated
      FieldName = 'd_QUALIFICA'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'QUALIFICA'
      Visible = False
      Size = 100
      Calculated = True
    end
    object selT430DISCIPLINA: TStringField
      DisplayLabel = 'Disciplina'
      FieldName = 'DISCIPLINA'
      Visible = False
      Size = 10
    end
    object selT430d_DISCIPLINA: TStringField
      DisplayLabel = 'Diciplina desc.'
      FieldKind = fkCalculated
      FieldName = 'd_DISCIPLINA'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'DISCIPLINA'
      Visible = False
      Size = 100
      Calculated = True
    end
    object selT430INIZIO_RAPGIUR: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Inizio rapporto giuridico'
      DisplayWidth = 10
      FieldName = 'INIZIO_RAPGIUR'
      Visible = False
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selT430FINE_RAPGIUR: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Fine rapporto giuridico'
      DisplayWidth = 10
      FieldName = 'FINE_RAPGIUR'
      Visible = False
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
  end
  object dsrT430: TDataSource
    DataSet = selT430
    Left = 144
    Top = 72
  end
  object selT425T430_InizioFine: TOracleDataSet
    SQL.Strings = (
      'select '
      '  '#39'T425'#39' TABELLA,'
      '  rowidtochar(T425.ROWID) IDRIGA,'
      '  T425.TIPORAPPORTO TIPO_RAPPORTO,'
      '  T450.TIPO,'
      '  T425.INIZIO INIZIO,'
      '  T425.FINE FINE,'
      '  T425.VALIDAZIONE  '
      
        '  from T425_RAPPORTILAVORO_ALTRIENTI T425, T450_TIPORAPPORTO T45' +
        '0'
      ' where T425.PROGRESSIVO = :PROGRESSIVO'
      '   and T425.TIPORAPPORTO = T450.CODICE(+)'
      ''
      'union'
      ''
      'select distinct'
      '  '#39'T430'#39' TABELLA,      '
      '  '#39#39' IDRIGA,'
      '  T430.TIPORAPPORTO TIPO_RAPPORTO,'
      '  T450.TIPO,'
      
        '  GREATEST(NVL(INIZIO, TO_DATE('#39'01011900'#39', '#39'ddmmyyyy'#39')), :DAL_AP' +
        ') INIZIO,'
      '  LEAST(FINE, :AL_AP) FINE,'
      
        '  --LEAST(NVL(FINE, TO_DATE('#39'31123999'#39', '#39'ddmmyyyy'#39')), :AL_AP) FI' +
        'NE,'
      '  '#39#39' VALIDAZIONE'
      '  from T430_STORICO T430, T450_TIPORAPPORTO T450'
      ' where T430.PROGRESSIVO = :PROGRESSIVO '
      '   and T430.TIPORAPPORTO = T450.CODICE(+)'
      '   and T430.INIZIO is not null'
      
        '   and T430.DATAFINE >= LEAST(T430.INIZIO, nvl(:INIZIO_RAPGIUR, ' +
        'T430.INIZIO))'
      
        '   and T430.DATADECORRENZA <= GREATEST(nvl(T430.FINE, to_date('#39'3' +
        '1123999'#39', '#39'ddmmyyyy'#39')),nvl(:FINE_RAPGIUR, to_date('#39'31123999'#39', '#39'd' +
        'dmmyyyy'#39')))'
      ' order by INIZIO'
      ''
      
        '/*select '#39'T425'#39' TABELLA, T425.INIZIO, T425.FINE, rowidtochar(ROW' +
        'ID) IDRIGA, T425.VALIDAZIONE, '#39#39' TIPO'
      '  from T425_RAPPORTILAVORO_ALTRIENTI T425'
      ' where T425.PROGRESSIVO = :PROGRESSIVO'
      'union'
      
        'select '#39'T430'#39' TABELLA, T430.:INIZIO INIZIO, T430.:FINE FINE, '#39#39' ' +
        'IDRIGA, '#39#39' VALIDAZIONE, T450.TIPO'
      '  from T430_STORICO T430, T450_TIPORAPPORTO T450'
      ' where T430.PROGRESSIVO = :PROGRESSIVO'
      
        '   --and T450.TIPO <> '#39'A'#39' -- deve essere ignorata l'#39'intersezione' +
        ' con periodi di lavoro di tipo "Altro"'
      '   and T430.:INIZIO is not null   --T430.INIZIO is not null'
      
        '   and T430.DATAFINE >= T430.:INIZIO    --T430.DATAFINE >= T430.' +
        'INIZIO '
      '   and T450.CODICE = T430.TIPORAPPORTO'
      ' order by INIZIO*/'
      ''
      
        '/*select '#39'T425'#39' TABELLA, T425.INIZIO, T425.FINE, rowidtochar(ROW' +
        'ID) IDRIGA, T425.VALIDAZIONE'
      '  from T425_RAPPORTILAVORO_ALTRIENTI T425'
      ' where T425.PROGRESSIVO = :PROGRESSIVO'
      'union'
      
        'select '#39'T430'#39' TABELLA, T430.:INIZIO INIZIO, T430.:FINE FINE, '#39#39' ' +
        'IDRIGA, '#39#39' VALIDAZIONE  --select '#39'T430'#39' TABELLA, T430.INIZIO, T4' +
        '30.FINE, '#39#39' IDRIGA'
      '  from T430_STORICO T430'
      ' where T430.PROGRESSIVO = :PROGRESSIVO'
      '   and T430.:INIZIO is not null   --T430.INIZIO is not null'
      
        '   and T430.DATAFINE >= T430.:INIZIO    --T430.DATAFINE >= T430.' +
        'INIZIO '
      ' order by INIZIO*/')
    Optimize = False
    Variables.Data = {
      0400000005000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A00440041004C005F004100
      5000010000000E000000544F5F44415445284E554C4C2900000000000C000000
      3A0041004C005F0041005000010000000E000000544F5F44415445284E554C4C
      2900000000001E0000003A0049004E0049005A0049004F005F00520041005000
      4700490055005200010000000E000000544F5F44415445286E756C6C29000000
      00001A0000003A00460049004E0045005F005200410050004700490055005200
      010000000E000000544F5F44415445286E756C6C290000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000150000001E0000005400300035003000500052004F00470052004500
      53005300490056004F0001000000000016000000540030003500300043004100
      5500530041004C0045000100000000001A000000540030003500300054004900
      50004F00470049005500530054000100000000000E0000005400300035003000
      440041004C000100000000000C000000540030003500300041004C0001000000
      00001A00000054003000350030004E0055004D00450052004F004F0052004500
      01000000000010000000540030003500300041004F0052004500010000000000
      16000000540030003500300044004100540041004E0041005300010000000000
      2400000054003000350030004E0055004D00450052004F004F00520045005F00
      50005200450056000100000000001A000000540030003500300041004F005200
      45005F0050005200450056000100000000001A00000054003000350030004500
      4C00410042004F005200410054004F0001000000000010000000540038003500
      3000490054004500520001000000000018000000540038003500300043004F00
      44005F0049005400450052000100000000000C00000054003800350030004900
      4400010000000000100000005400380035003000440041005400410001000000
      000012000000540038003500300053005400410054004F000100000000001000
      000054003800350030004E004F00540045000100000000002400000054003800
      350030005400490050004F005F00520049004300480049004500530054004100
      0100000000002E00000054003800350030004100550054004F00520049005A00
      5A005F004100550054004F004D00410054004900430041000100000000001A00
      00005400380035003000490044005F005200450056004F004300410001000000
      00001E0000005400380035003000490044005F005200450056004F0043004100
      54004F00010000000000}
    Left = 61
    Top = 88
  end
  object selT430_InizioFine: TOracleDataSet
    SQL.Strings = (
      
        'select distinct T430.PROGRESSIVO, T430.INIZIO, NVL(T430.FINE,TO_' +
        'DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) FINE'
      '  from T430_STORICO T430'
      ' where T430.PROGRESSIVO = :PROGRESSIVO '
      
        '   and ((:DATASCADENZA < T430.INIZIO) or (:DATASCADENZA between ' +
        'T430.INIZIO and NVL(T430.FINE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39'))))'
      '   and T430.INIZIO is not null'
      '   and T430.DATAFINE >= T430.INIZIO '
      ' order by T430.INIZIO')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000001A0000003A0044004100540041005300
      43004100440045004E005A0041000C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000150000001E0000005400300035003000500052004F00470052004500
      53005300490056004F0001000000000016000000540030003500300043004100
      5500530041004C0045000100000000001A000000540030003500300054004900
      50004F00470049005500530054000100000000000E0000005400300035003000
      440041004C000100000000000C000000540030003500300041004C0001000000
      00001A00000054003000350030004E0055004D00450052004F004F0052004500
      01000000000010000000540030003500300041004F0052004500010000000000
      16000000540030003500300044004100540041004E0041005300010000000000
      2400000054003000350030004E0055004D00450052004F004F00520045005F00
      50005200450056000100000000001A000000540030003500300041004F005200
      45005F0050005200450056000100000000001A00000054003000350030004500
      4C00410042004F005200410054004F0001000000000010000000540038003500
      3000490054004500520001000000000018000000540038003500300043004F00
      44005F0049005400450052000100000000000C00000054003800350030004900
      4400010000000000100000005400380035003000440041005400410001000000
      000012000000540038003500300053005400410054004F000100000000001000
      000054003800350030004E004F00540045000100000000002400000054003800
      350030005400490050004F005F00520049004300480049004500530054004100
      0100000000002E00000054003800350030004100550054004F00520049005A00
      5A005F004100550054004F004D00410054004900430041000100000000001A00
      00005400380035003000490044005F005200450056004F004300410001000000
      00001E0000005400380035003000490044005F005200450056004F0043004100
      54004F00010000000000}
    OnCalcFields = selT430CalcFields
    Left = 61
    Top = 168
  end
  object selT261: TOracleDataSet
    SQL.Strings = (
      'select '
      '  T261.CODICE, T261.DESCRIZIONE, T261RUOLO.PROFILI_RUOLO '
      'from '
      '  T261_DESCPROFASS T261,'
      
        '  (select max(PROFILI_RUOLO) PROFILI_RUOLO from T261_DESCPROFASS' +
        ' where CODICE = :CODICE) T261RUOLO'
      'where '
      'T261.CODICE = :CODICE'
      
        'or intersez_liste(T261.CODICE,T261RUOLO.PROFILI_RUOLO) = T261.CO' +
        'DICE'
      'or T261RUOLO.PROFILI_RUOLO is null'
      'order by T261.CODICE')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000150000001E0000005400300035003000500052004F00470052004500
      53005300490056004F0001000000000016000000540030003500300043004100
      5500530041004C0045000100000000001A000000540030003500300054004900
      50004F00470049005500530054000100000000000E0000005400300035003000
      440041004C000100000000000C000000540030003500300041004C0001000000
      00001A00000054003000350030004E0055004D00450052004F004F0052004500
      01000000000010000000540030003500300041004F0052004500010000000000
      16000000540030003500300044004100540041004E0041005300010000000000
      2400000054003000350030004E0055004D00450052004F004F00520045005F00
      50005200450056000100000000001A000000540030003500300041004F005200
      45005F0050005200450056000100000000001A00000054003000350030004500
      4C00410042004F005200410054004F0001000000000010000000540038003500
      3000490054004500520001000000000018000000540038003500300043004F00
      44005F0049005400450052000100000000000C00000054003800350030004900
      4400010000000000100000005400380035003000440041005400410001000000
      000012000000540038003500300053005400410054004F000100000000001000
      000054003800350030004E004F00540045000100000000002400000054003800
      350030005400490050004F005F00520049004300480049004500530054004100
      0100000000002E00000054003800350030004100550054004F00520049005A00
      5A005F004100550054004F004D00410054004900430041000100000000001A00
      00005400380035003000490044005F005200450056004F004300410001000000
      00001E0000005400380035003000490044005F005200450056004F0043004100
      54004F00010000000000}
    OnCalcFields = selT430CalcFields
    Left = 224
    Top = 24
    object selT261CODICE: TStringField
      FieldName = 'CODICE'
      Size = 7
    end
    object selT261DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
  object dsrT261: TDataSource
    DataSet = selT261
    Left = 224
    Top = 72
  end
  object scrT430PAssenze: TOracleQuery
    SQL.Strings = (
      'begin'
      '  CREAZIONE_STORICO(:PROGRESSIVO,:DECORRENZA,:SCADENZA);'
      ''
      '  update T430_STORICO set PASSENZE = :PASSENZE'
      '  where PROGRESSIVO = :PROGRESSIVO'
      '  and DATADECORRENZA between :DECORRENZA and :SCADENZA - 1;'
      ' '
      '  commit;'
      'end;'
      '   ')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000160000003A004400450043004F005200
      520045004E005A0041000C0000000000000000000000120000003A0053004300
      4100440045004E005A0041000C0000000000000000000000120000003A005000
      41005300530045004E005A004500050000000000000000000000}
    Left = 304
    Top = 24
  end
  object cdsProfili: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 576
    Top = 144
    object cdsProfiliDecorrenza: TStringField
      FieldName = 'Decorrenza'
    end
    object cdsProfiliTermine: TStringField
      FieldName = 'Termine'
    end
    object cdsProfiliValore: TStringField
      FieldName = 'Valore'
    end
    object cdsProfiliDescrizione: TStringField
      FieldName = 'Descrizione'
    end
    object cdsProfiliNomeCampo: TStringField
      FieldName = 'NomeCampo'
      Visible = False
    end
    object cdsProfiliColore: TBooleanField
      FieldName = 'Colore'
      Visible = False
    end
    object cdsProfiliValorizza: TBooleanField
      FieldName = 'Valorizza'
      Visible = False
    end
  end
  object dsrProfili: TDataSource
    DataSet = cdsProfili
    Left = 576
    Top = 200
  end
  object selT460: TOracleDataSet
    SQL.Strings = (
      
        'select T460.CODICE, T460.DESCRIZIONE, T460.CODICE||'#39' - '#39'||T460.D' +
        'ESCRIZIONE COD_DESC, T460.TIPO, T460.PIANTA'
      'from T460_PARTTIME T460'
      'order by T460.CODICE')
    ReadBuffer = 100
    Optimize = False
    ReadOnly = True
    Filtered = True
    OnFilterRecord = FiltroDizionario
    Left = 80
    Top = 24
    object selT460CODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Size = 10
    end
    object selT460DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 45
      FieldName = 'DESCRIZIONE'
      Size = 80
    end
    object selT460TIPO: TStringField
      FieldName = 'TIPO'
      Size = 1
    end
    object selT460PIANTA: TFloatField
      FieldName = 'PIANTA'
    end
  end
  object selEnte: TOracleDataSet
    Optimize = False
    Filtered = True
    OnFilterRecord = FiltroDizionario
    Left = 216
    Top = 176
  end
  object selQualifica: TOracleDataSet
    Optimize = False
    Filtered = True
    OnFilterRecord = FiltroDizionario
    Left = 272
    Top = 176
  end
  object selDisciplina: TOracleDataSet
    Optimize = False
    Filtered = True
    OnFilterRecord = FiltroDizionario
    Left = 336
    Top = 176
  end
  object selT265: TOracleDataSet
    SQL.Strings = (
      'select T265.CODICE, T265.DESCRIZIONE'
      
        'from T265_CAUASSENZE T265, T255_TIPOACCORPCAUSALI T255, T257_ACC' +
        'ORPCAUSALI T257'
      'where 1=1'
      '/*and PERIODO_LUNGO = '#39'S'#39' or RAGGRSTAT in ('#39'G'#39','#39'L'#39')*/'
      'and T255.COD_TIPOACCORPCAUSALI = T257.COD_TIPOACCORPCAUSALI '
      'and T255.TIPO = PCK_CONST.T255_ASP'
      'and :DATA between T257.DECORRENZA and T257.DECORRENZA_FINE'
      'and T265.CODICE = T257.COD_CAUSALE'
      'order by T265.DESCRIZIONE, T265.CODICE')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A0044004100540041000C000000000000000000
      0000}
    Left = 400
    Top = 24
    object selT265CODICE: TStringField
      FieldName = 'CODICE'
      Size = 5
    end
    object selT265DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
  object selRiepilogo: TOracleDataSet
    SQL.Strings = (
      'select T425F_GGSERVIZIO(:PROGRESSIVO,'#39'*'#39','#39'*'#39') G_ALL,'
      '       T425F_GGSERVIZIO(:PROGRESSIVO,'#39'I'#39','#39'*'#39') G_TI,'
      '       T425F_GGSERVIZIO(:PROGRESSIVO,'#39'*'#39','#39'N'#39') G_ALL_NA,'
      '       T425F_GGSERVIZIO(:PROGRESSIVO,'#39'I'#39','#39'N'#39') G_TI_NA,'
      
        '       T425F_GGSERVIZIO(:PROGRESSIVO,'#39'*'#39','#39'*'#39',SYSDATE,'#39'S'#39','#39'5'#39') DT' +
        '_ANZ_5,'
      
        '       T425F_GGSERVIZIO(:PROGRESSIVO,'#39'*'#39','#39'*'#39',SYSDATE,'#39'S'#39','#39'15'#39') D' +
        'T_ANZ_15,'
      
        '       T425F_GGSERVIZIO(:PROGRESSIVO,'#39'*'#39','#39'*'#39',SYSDATE,'#39'E'#39') G_FTE_' +
        'ALL,'
      
        '       T425F_GGSERVIZIO(:PROGRESSIVO,'#39'*'#39','#39'N'#39',SYSDATE,'#39'E'#39') G_FTE_' +
        'NA'
      'from dual')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F0003000000040000000000000000000000}
    Left = 16
    Top = 224
    object selRiepilogoG_ALL: TStringField
      FieldName = 'G_ALL'
      Size = 10
    end
    object selRiepilogoG_TI: TStringField
      FieldName = 'G_TI'
      Size = 10
    end
    object selRiepilogoG_ALL_NA: TStringField
      FieldName = 'G_ALL_NA'
      Size = 10
    end
    object selRiepilogoG_TI_NA: TStringField
      FieldName = 'G_TI_NA'
      Size = 10
    end
    object selRiepilogoDT_ANZ_5: TStringField
      FieldName = 'DT_ANZ_5'
      Size = 30
    end
    object selRiepilogoDT_ANZ_15: TStringField
      FieldName = 'DT_ANZ_15'
      Size = 30
    end
    object selRiepilogoG_FTE_ALL: TStringField
      FieldName = 'G_FTE_ALL'
      Size = 10
    end
    object selRiepilogoG_FTE_NA: TStringField
      FieldName = 'G_FTE_NA'
      Size = 10
    end
  end
  object selT055: TOracleDataSet
    SQL.Strings = (
      'select T055.*,ROWID, rowidtochar(ROWID) IDRIGA'
      '  from T055_PERIODI_ASPETTATIVA T055'
      ' where T055.PROGRESSIVO = :PROGRESSIVO'
      ' order by T055.DAL')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    BeforeInsert = selT055BeforeInsert
    BeforeDelete = selT055BeforeDelete
    Left = 152
    Top = 168
    object selT055PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selT055VALIDAZIONE: TStringField
      Alignment = taCenter
      DisplayLabel = 'Validato'
      FieldName = 'VALIDAZIONE'
      Size = 1
    end
    object selT055DAL: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Dal'
      DisplayWidth = 10
      FieldName = 'DAL'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selT055AL: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Al'
      DisplayWidth = 10
      FieldName = 'AL'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selT055CAUSALE: TStringField
      DisplayLabel = 'Causale'
      FieldName = 'CAUSALE'
      Size = 5
    end
    object selT055d_CAUSALE: TStringField
      DisplayLabel = 'Causale desc.'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'd_CAUSALE'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAUSALE'
      Size = 50
      Lookup = True
    end
    object selT055NOTE: TStringField
      DisplayLabel = 'Note'
      FieldName = 'NOTE'
      Size = 2000
    end
    object selT055IDRIGA: TStringField
      FieldName = 'IDRIGA'
      Visible = False
    end
  end
  object scrT430DatiGiuridici: TOracleQuery
    SQL.Strings = (
      'begin'
      '  creazione_storico(:PROGRESSIVO, :INIZIO, :FINE);'
      '  update T430_STORICO'
      '  set TIPORAPPORTO = nvl(:TIPORAPPORTO, TIPORAPPORTO),'
      '      :C22_INIZIO = nvl(:INIZIO, :C22_INIZIO),'
      '      :C22_FINE = nvl(:FINE, :C22_FINE),'
      '      :C22_QUALIFICA = nvl(:QUALIFICA, :C22_QUALIFICA),'
      '      :C22_DISCIPLINA = nvl(:DISCIPLINA, :C22_DISCIPLINA),'
      '      :C22_ENTE = nvl(:ENTE, :C22_ENTE),'
      '      PARTTIME = nvl(:PARTTIME, PARTTIME)'
      '  where PROGRESSIVO = :PROGRESSIVO'
      '  and DATADECORRENZA >= :INIZIO'
      '  and DATAFINE <= :FINE;'
      ''
      '  commit;'
      'end;')
    Optimize = False
    Variables.Data = {
      040000000A000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A0049004E0049005A004900
      4F000C00000000000000000000000A0000003A00460049004E0045000C000000
      00000000000000001A0000003A005400490050004F0052004100500050004F00
      520054004F00050000000000000000000000120000003A005000410052005400
      540049004D0045000500000000000000000000001C0000003A00430032003200
      5F005100550041004C0049004600490043004100010000000000000000000000
      1E0000003A004300320032005F004400490053004300490050004C0049004E00
      4100010000000000000000000000120000003A004300320032005F0045004E00
      54004500010000000000000000000000160000003A004300320032005F004900
      4E0049005A0049004F00010000000000000000000000120000003A0043003200
      32005F00460049004E004500010000000000000000000000}
    Left = 304
    Top = 72
  end
  object dsrT055: TDataSource
    DataSet = selT055
    Left = 152
    Top = 216
  end
  object selT425_T050_NA: TOracleDataSet
    SQL.Strings = (
      'select T030.MATRICOLA, T030.COGNOME, T030.NOME,'
      
        '       nvl(T425.NR_RL, 0) RAPP_GIUR_NA, nvl(T055.NR_PA, 0) PER_A' +
        'SP_NA'
      'from   T030_ANAGRAFICO T030,'
      '       (select PROGRESSIVO, count(*) as Nr_RL'
      '        from T425_RAPPORTILAVORO_ALTRIENTI'
      '        where VALIDAZIONE = '#39'N'#39
      '        group by PROGRESSIVO) T425'
      '       full outer join '
      '       (select PROGRESSIVO, count(*) as Nr_PA '
      '        from T055_PERIODI_ASPETTATIVA'
      '        where VALIDAZIONE = '#39'N'#39
      '        group by PROGRESSIVO) T055'
      'on  T425.PROGRESSIVO = T055.PROGRESSIVO'
      'where T030.PROGRESSIVO = T425.PROGRESSIVO'
      'or T030.PROGRESSIVO = T055.PROGRESSIVO'
      'order by T030.MATRICOLA')
    Optimize = False
    ReadOnly = True
    Left = 584
    Top = 40
    object selT425_T050_NAMATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      DisplayWidth = 10
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selT425_T050_NACOGNOME: TStringField
      DisplayLabel = 'Cognome'
      DisplayWidth = 35
      FieldName = 'COGNOME'
      Size = 50
    end
    object selT425_T050_NANOME: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 35
      FieldName = 'NOME'
      Size = 50
    end
    object selT425_T050_NARAPP_GIUR_NA: TFloatField
      DisplayLabel = 'Rapp. Giur. non validati'
      DisplayWidth = 12
      FieldName = 'RAPP_GIUR_NA'
    end
    object selT425_T050_NAPER_ASP_NA: TFloatField
      DisplayLabel = 'Aspettative non validate'
      DisplayWidth = 12
      FieldName = 'PER_ASP_NA'
    end
  end
  object drsT425_T050_NA: TDataSource
    DataSet = selT425_T050_NA
    Left = 584
    Top = 88
  end
  object selT040: TOracleDataSet
    SQL.Strings = (
      
        'select INIZIO_PERIODO DAL, max(FINE_PERIODO) AL, CAUSALE, T265.D' +
        'ESCRIZIONE d_CAUSALE'
      'from  T265_CAUASSENZE T265,'
      
        '      (select PROGRESSIVO, CAUSALE,t040f_getinizioassenza(T040.P' +
        'ROGRESSIVO,T040.DATA,T040.CAUSALE) INIZIO_PERIODO,DATA FINE_PERI' +
        'ODO'
      '      from T040_GIUSTIFICATIVI T040  '
      '      where T040.PROGRESSIVO = :PROGRESSIVO'
      '      and CAUSALE in (select T265.CODICE'
      
        '                      from T265_CAUASSENZE T265, T255_TIPOACCORP' +
        'CAUSALI T255, T257_ACCORPCAUSALI T257'
      
        '                      where T255.COD_TIPOACCORPCAUSALI = T257.CO' +
        'D_TIPOACCORPCAUSALI '
      '                      and T255.TIPO = PCK_CONST.T255_ASP'
      
        '                      --and :DATA between T257.DECORRENZA and T2' +
        '57.DECORRENZA_FINE'
      '                      and T265.CODICE = T257.COD_CAUSALE'
      '                      ) '
      '      --and t.data > '#39'12-07-2000'#39
      '      )'
      'WHERE CAUSALE = T265.CODICE                    '
      'group by PROGRESSIVO,CAUSALE,INIZIO_PERIODO, T265.DESCRIZIONE'
      'order by 1')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Left = 496
    Top = 56
    object selT040DAL: TDateTimeField
      DisplayLabel = 'Dal'
      FieldName = 'DAL'
    end
    object selT040AL: TDateTimeField
      DisplayLabel = 'Al'
      FieldName = 'AL'
    end
    object selT040CAUSALE: TStringField
      DisplayLabel = 'Causale'
      FieldName = 'CAUSALE'
      Size = 5
    end
    object selT040d_CAUSALE: TStringField
      DisplayLabel = 'Causale desc.'
      DisplayWidth = 20
      FieldName = 'd_CAUSALE'
      Size = 50
    end
  end
  object dsrT040: TDataSource
    DataSet = selT040
    Left = 496
    Top = 112
  end
end
