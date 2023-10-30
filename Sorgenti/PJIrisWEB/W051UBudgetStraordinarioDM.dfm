object W051FBudgetStraordinarioDM: TW051FBudgetStraordinarioDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 214
  Width = 506
  object selT713: TOracleDataSet
    SQL.Strings = (
      'select T713.*, T713.ROWID,               '
      '       TA.CODICE || '#39' - '#39' || TA.DESCRIZIONE CDESCRIZIONE, '
      '       T714_I.TOT_ORE_F,'
      
        '       decode(VT700.T850ID, null,'#39'N'#39', decode(VT700.T850STATO, nu' +
        'll, '#39'S'#39', '#39'N'#39')) BLOCCATO'
      'from '
      '  T713_BUDGETANNO T713,'
      '  ('
      
        '    select '#39'#LIQ#'#39' codice, '#39'Ore liquidabili'#39' descrizione from du' +
        'al'
      '    union'
      '    select '#39'#B.O#'#39' codice, '#39'Banca ore'#39' descrizione from dual'
      '    union'
      
        '    select '#39'#ECC#'#39' codice, '#39'Saldo positivo anno corrente'#39' descri' +
        'zione from dual'
      '    union'
      '    select t.codice, t.descrizione from T275_CAUPRESENZE t'
      '  ) TA,'
      '  ('
      
        '     select minutiore(sum(oreminuti(T714.ore_fruito))) tot_ore_f' +
        ', tipo, decorrenza, codgruppo'
      '     from T714_BUDGETMESE T714'
      '     group by (T714.codgruppo, T714.tipo, T714.decorrenza)'
      '  ) T714_I,'
      '  VT700_ITER_BUDGETANNO VT700  '
      'where '
      '  T713.tipo = TA.Codice    '
      '  and T713.tipo = T714_I.tipo'
      '  and T713.decorrenza = T714_I.decorrenza'
      '  and T713.codgruppo = T714_I.codgruppo'
      '  :ANNO /*and T713.anno = :ANNO*/'
      
        '  :RESPONSABILE /*and exists (select '#39'x'#39' from T715_BUDGETRESPONS' +
        'ABILI T715 where T715.CODGRUPPO = T713.CODGRUPPO and T715.TIPO =' +
        ' T713.TIPO and T715.DECORRENZA = T713.DECORRENZA and T715.RESPON' +
        'SABILE = PROGOPERATORE)*/'
      '  and T713.tipo = VT700.T700tipo(+)'
      '  and T713.codgruppo = VT700.T700codgruppo(+)'
      '  and T713.Decorrenza = VT700.T700decorrenza(+)'
      '  and (VT700.T850ID = (select max(t850id) '
      '                         from VT700_ITER_BUDGETANNO b'
      
        '                        where b.T700CODGRUPPO = vt700.T700CODGRU' +
        'PPO'
      '                          and b.T700TIPO = vt700.T700TIPO '
      
        '                          and b.T700DECORRENZA = vt700.T700DECOR' +
        'RENZA)'
      '       or VT700.T850ID is null)                       '
      'order by ANNO, T713.CODGRUPPO')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A0041004E004E004F0001000000000000000000
      00001A0000003A0052004500530050004F004E0053004100420049004C004500
      010000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000D00000016000000500052004F004700520045005300530049005600
      4F000100000000000E000000430041005500530041004C004500010000000000
      06000000440041004C000100000000000400000041004C000100000000001200
      00005400490050004F00470049005500530054000100000000001C0000004100
      550054004F00520049005A005A0041005A0049004F004E004500010000000000
      1800000052004500530050004F004E0053004100420049004C00450001000000
      00000E00000044004100540041004E0041005300010000000000120000004E00
      55004D00450052004F004F005200450001000000000004000000520049000100
      0000000010000000500055004C00530041004E00540045000100000000001200
      00004D00410054005200490043004F004C004100010000000000140000004E00
      4F004D0049004E0041005400490056004F00010000000000}
    Filtered = True
    BeforePost = selT713BeforePost
    AfterScroll = selT713AfterScroll
    OnCalcFields = selT713CalcFields
    OnFilterRecord = selT713FilterRecord
    Left = 28
    Top = 56
    object selT713ANNO: TFloatField
      DisplayLabel = 'Anno'
      FieldName = 'ANNO'
      ReadOnly = True
      Visible = False
    end
    object selT713CODGRUPPO: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODGRUPPO'
      ReadOnly = True
      Size = 10
    end
    object selT713DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      ReadOnly = True
      Size = 100
    end
    object selT713CDESCRIZIONE: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'CDESCRIZIONE'
      ReadOnly = True
      Size = 50
    end
    object selT713TIPO: TStringField
      FieldName = 'TIPO'
      ReadOnly = True
      Visible = False
      Size = 5
    end
    object selT713ORE: TStringField
      DisplayLabel = 'Ore'
      FieldName = 'ORE'
      EditMask = '!#000:00;1;_'
      Size = 10
    end
    object selT713IMPORTO: TFloatField
      DisplayLabel = 'Importo'
      FieldName = 'IMPORTO'
      DisplayFormat = '0.00'
    end
    object selT713DECORRENZA: TDateTimeField
      FieldName = 'DECORRENZA'
      ReadOnly = True
      Visible = False
    end
    object selT713FILTRO_ANAGRAFE: TStringField
      DisplayLabel = 'Filtro anagrafe'
      FieldName = 'FILTRO_ANAGRAFE'
      ReadOnly = True
      Visible = False
      Size = 4000
    end
    object selT713DECORRENZA_FINE: TDateTimeField
      FieldName = 'DECORRENZA_FINE'
      ReadOnly = True
      Visible = False
    end
    object selT713RIEPILOGO_ORARIO: TStringField
      DisplayLabel = 'Riepilogo orario'
      FieldKind = fkCalculated
      FieldName = 'RIEPILOGO_ORARIO'
      ReadOnly = True
      Calculated = True
    end
    object selT713TOT_ORE_F: TStringField
      DisplayLabel = 'Totale ore fruite'
      FieldName = 'TOT_ORE_F'
      ReadOnly = True
      Visible = False
      Size = 10
    end
    object selT713TOT_ORE_R: TStringField
      DisplayLabel = 'Totale ore residue'
      FieldKind = fkCalculated
      FieldName = 'TOT_ORE_R'
      Visible = False
      Size = 10
      Calculated = True
    end
    object selT713BLOCCATO: TStringField
      FieldName = 'BLOCCATO'
      Visible = False
      Size = 1
    end
  end
  object selT714: TOracleDataSet
    SQL.Strings = (
      'select t714.*, t714.rowid'
      'from T714_BUDGETMESE t714'
      'where codgruppo = :CODGRUPPO'
      '  and tipo = :TIPO'
      '  and decorrenza = :DECORRENZA'
      'order by t714.mese')
    Optimize = False
    Variables.Data = {
      0400000003000000140000003A0043004F004400470052005500500050004F00
      0500000000000000000000000A0000003A005400490050004F00050000000000
      000000000000160000003A004400450043004F005200520045004E005A004100
      0C0000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000C0000001200000043004F004400470052005500500050004F000100
      000000001800000043004F0044005400490050004F00510055004F0054004100
      01000000000016000000500052004F0047005200450053005300490056004F00
      010000000000200000005000450053004F005F0049004E004400490056004900
      4400550041004C0045000100000000001C0000005000450053004F005F004300
      41004C0043004F004C00410054004F0001000000000022000000510055004F00
      540041005F0049004E0044004900560049004400550041004C00450001000000
      00001E000000510055004F00540041005F00430041004C0043004F004C004100
      540041000100000000000E00000043004F0047004E004F004D00450001000000
      0000080000004E004F004D004500010000000000120000004D00410054005200
      490043004F004C00410001000000000016000000470047005F00530045005200
      560049005A0049004F000100000000000800000041004E004E004F0001000000
      0000}
    BeforePost = selT714BeforePost
    AfterPost = selT714AfterPost
    OnCalcFields = selT714CalcFields
    Left = 27
    Top = 104
    object selT714CODGRUPPO: TStringField
      DisplayLabel = 'Cod. gruppo'
      FieldName = 'CODGRUPPO'
      ReadOnly = True
      Required = True
      Visible = False
      Size = 10
    end
    object selT714TIPO: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO'
      ReadOnly = True
      Required = True
      Visible = False
      Size = 5
    end
    object selT714DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
      ReadOnly = True
      Required = True
      Visible = False
    end
    object selT714MESE: TFloatField
      DisplayLabel = 'Mese'
      FieldName = 'MESE'
      ReadOnly = True
      Required = True
    end
    object selT714ORE_AUTO: TStringField
      DisplayLabel = 'Ore autom.'
      FieldKind = fkCalculated
      FieldName = 'ORE_AUTO'
      ReadOnly = True
      Visible = False
      EditMask = '!9999990:00;1;_'
      Size = 10
      Calculated = True
    end
    object selT714ORE: TStringField
      DisplayLabel = 'Ore'
      FieldName = 'ORE'
      EditMask = '!#000:00;1;_'
      Size = 10
    end
    object selT714ORE_FRUITO: TStringField
      DisplayLabel = 'Ore fruite'
      FieldName = 'ORE_FRUITO'
      ReadOnly = True
      EditMask = '!9999990:00;1;_'
      Size = 10
    end
    object selT714ORE_RESIDUO_AUTO: TStringField
      DisplayLabel = 'Ore res. aut.'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'ORE_RESIDUO_AUTO'
      ReadOnly = True
      Visible = False
      EditMask = '!9999990:00;1;_'
      Size = 10
      Calculated = True
    end
    object selT714ORE_RESIDUO: TStringField
      DisplayLabel = 'Ore residue'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'ORE_RESIDUO'
      ReadOnly = True
      EditMask = '!9999990:00;1;_'
      Size = 10
      Calculated = True
    end
    object selT714IMPORTO_AUTO: TFloatField
      DisplayLabel = 'Importo autom.'
      FieldKind = fkCalculated
      FieldName = 'IMPORTO_AUTO'
      Visible = False
      DisplayFormat = '0.00'
      Calculated = True
    end
    object selT714IMPORTO: TFloatField
      DisplayLabel = 'Importo'
      FieldName = 'IMPORTO'
      DisplayFormat = '0.00'
    end
    object selT714IMPORTO_FRUITO: TFloatField
      DisplayLabel = 'Importo fruito'
      FieldName = 'IMPORTO_FRUITO'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object selT714IMPORTO_RESIDUO_AUTO: TFloatField
      DisplayLabel = 'Imp. res. aut.'
      FieldKind = fkCalculated
      FieldName = 'IMPORTO_RESIDUO_AUTO'
      ReadOnly = True
      Visible = False
      DisplayFormat = '0.00'
      Calculated = True
    end
    object selT714IMPORTO_RESIDUO: TFloatField
      DisplayLabel = 'Importo res.'
      FieldKind = fkCalculated
      FieldName = 'IMPORTO_RESIDUO'
      ReadOnly = True
      DisplayFormat = '0.00'
      Calculated = True
    end
  end
  object selT715: TOracleDataSet
    SQL.Strings = (
      '  select *'
      '    from T715_BUDGETRESPONSABILI'
      'order by DECORRENZA, CODGRUPPO, RESPONSABILE')
    ReadBuffer = 100
    Optimize = False
    Left = 27
    Top = 152
  end
  object selT700: TOracleDataSet
    SQL.Strings = (
      '-- v. C018UIterAutDM')
    Optimize = False
    Variables.Data = {
      04000000070000001A0000003A005100560049005300540041004F0052004100
      43004C0045000100000000000000000000001E0000003A00460049004C005400
      52004F005F0050004500520049004F0044004F00010000000000000000000000
      100000003A0041005A00490045004E0044004100050000000000000000000000
      180000003A00460049004C00540052004F005F0041004E004100470001000000
      00000000000000002E0000003A00460049004C00540052004F005F0056004900
      5300550041004C0049005A005A0041005A0049004F004E004500010000000000
      000000000000160000003A0044004100540041004C00410056004F0052004F00
      0C00000000000000000000001C0000003A00460049004C00540052004F005000
      4500520049004F0044004F00010000000000000000000000}
    UpdatingTable = 'T700_ITER_BUDGETANNO'
    CommitOnPost = False
    Filtered = True
    OnCalcFields = selT700CalcFields
    Left = 28
    Top = 9
    object selT700ID: TFloatField
      FieldName = 'ID'
    end
    object selT700ID_REVOCA: TFloatField
      FieldName = 'ID_REVOCA'
    end
    object selT700ID_REVOCATO: TFloatField
      FieldName = 'ID_REVOCATO'
    end
    object selT700COD_ITER: TStringField
      FieldName = 'COD_ITER'
    end
    object selT700TIPO_RICHIESTA: TStringField
      FieldName = 'TIPO_RICHIESTA'
      Size = 1
    end
    object selT700D_TIPO_RICHIESTA: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_TIPO_RICHIESTA'
      Calculated = True
    end
    object selT700D_RESPONSABILE: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_RESPONSABILE'
      Size = 84
      Calculated = True
    end
    object selT700D_AUTORIZZAZIONE: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_AUTORIZZAZIONE'
      Size = 2
      Calculated = True
    end
    object selT700D_STATO: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_STATO'
      Size = 2
      Calculated = True
    end
    object selT700AUTORIZZ_AUTOMATICA: TStringField
      FieldName = 'AUTORIZZ_AUTOMATICA'
      Size = 1
    end
    object selT700REVOCABILE: TStringField
      FieldName = 'REVOCABILE'
      Size = 10
    end
    object selT700DATA_RICHIESTA: TDateTimeField
      DisplayWidth = 50
      FieldName = 'DATA_RICHIESTA'
      DisplayFormat = 'dd/mm/yyyy hhhh.nn'
    end
    object selT700LIVELLO_AUTORIZZAZIONE: TFloatField
      FieldName = 'LIVELLO_AUTORIZZAZIONE'
    end
    object selT700DATA_AUTORIZZAZIONE: TDateTimeField
      FieldName = 'DATA_AUTORIZZAZIONE'
    end
    object selT700AUTORIZZAZIONE: TStringField
      FieldName = 'AUTORIZZAZIONE'
      Size = 1
    end
    object selT700NOMINATIVO_RESP: TStringField
      FieldName = 'NOMINATIVO_RESP'
      Size = 65
    end
    object selT700AUTORIZZ_AUTOM_PREV: TStringField
      FieldName = 'AUTORIZZ_AUTOM_PREV'
      Size = 1
    end
    object selT700AUTORIZZ_PREV: TStringField
      FieldName = 'AUTORIZZ_PREV'
      Size = 1
    end
    object selT700RESPONSABILE_PREV: TStringField
      FieldName = 'RESPONSABILE_PREV'
      Size = 30
    end
    object selT700AUTORIZZ_UTILE: TStringField
      FieldName = 'AUTORIZZ_UTILE'
      Size = 1
    end
    object selT700AUTORIZZ_REVOCA: TStringField
      FieldName = 'AUTORIZZ_REVOCA'
      Size = 1
    end
    object selT700MSGAUT_SI: TStringField
      FieldName = 'MSGAUT_SI'
      Size = 2000
    end
    object selT700MSGAUT_NO: TStringField
      FieldName = 'MSGAUT_NO'
      Size = 2000
    end
    object selT700CODGRUPPO: TStringField
      FieldName = 'CODGRUPPO'
      Size = 10
    end
    object selT700D_CODGRUPPO: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_CODGRUPPO'
      Size = 100
      Calculated = True
    end
    object selT700TIPO: TStringField
      FieldName = 'TIPO'
      Size = 5
    end
    object selT700ORE: TStringField
      FieldName = 'ORE'
      Size = 10
    end
    object selT700IMPORTO: TFloatField
      FieldName = 'IMPORTO'
    end
    object selT700DECORRENZA: TDateTimeField
      FieldName = 'DECORRENZA'
    end
  end
  object updT713: TOracleQuery
    SQL.Strings = (
      'update T713_BUDGETANNO T'
      '   set T.ORE = :ORE,'
      '       T.IMPORTO = :IMPORTO'
      ' where T.CODGRUPPO = :CODGRUPPO'
      '   and T.TIPO = :TIPO'
      '   and T.DECORRENZA = :DECORRENZA')
    Optimize = False
    Variables.Data = {
      0400000005000000080000003A004F0052004500050000000000000000000000
      100000003A0049004D0050004F00520054004F00040000000000000000000000
      140000003A0043004F004400470052005500500050004F000500000000000000
      000000000A0000003A005400490050004F000500000000000000000000001600
      00003A004400450043004F005200520045004E005A0041000C00000000000000
      00000000}
    Left = 220
    Top = 56
  end
  object selT713lkp: TOracleDataSet
    SQL.Strings = (
      'select distinct CODGRUPPO,DESCRIZIONE'
      'from T713_BUDGETANNO T713'
      'where 1 = 1'
      ':RESPONSABILE'
      'order by 1,2')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      04000000010000001A0000003A0052004500530050004F004E00530041004200
      49004C004500010000000000000000000000}
    Left = 164
    Top = 56
  end
  object selT713lstAnno: TOracleDataSet
    SQL.Strings = (
      'select distinct ANNO'
      'from T713_BUDGETANNO T713'
      'where 1 = 1'
      ':RESPONSABILE'
      'order by ANNO desc')
    Optimize = False
    Variables.Data = {
      04000000010000001A0000003A0052004500530050004F004E00530041004200
      49004C004500010000000000000000000000}
    Left = 92
    Top = 56
  end
end
