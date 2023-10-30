inherited P688FMonitoraggioFondiMW: TP688FMonitoraggioFondiMW
  OldCreateOrder = True
  object selP688: TOracleDataSet
    SQL.Strings = (
      'select :DATI,'
      '       decorrenza_da,decorrenza_a,'
      
        '       max(data_ultimo_monit) data_ultimo_monit, to_char(max(dat' +
        'a_ultima_retr),'#39'mm/yyyy'#39') mm_ultima_retr,'
      
        '       round(sum(tot_risorse)) tot_risorse, round(sum(tot_speso)' +
        ') tot_speso, round(sum(tot_risorse)) - round(sum(tot_speso)) tot' +
        '_residuo'
      'from'
      '('
      'select p680.cod_macrocateg, p680.descrizione desc_macrocateg, '
      '       p682.cod_raggr, p682.descrizione desc_raggr,'
      '       nvl(p682.cod_raggr,p684.cod_fondo) cod_fondo_raggr,'
      '       nvl(p682.descrizione,p684.descrizione) desc_fondo_raggr,'
      '       p684.cod_fondo,p684.descrizione desc_fondo,'
      
        '       p684.decorrenza_da,p684.decorrenza_a,p684.data_ultimo_mon' +
        'it,'
      
        '       sum(decode(p688.class_voce,'#39'R'#39',p688.importo,0)) tot_risor' +
        'se,'
      
        '       sum(decode(p688.class_voce,'#39'D'#39',p688.importo,0)) tot_speso' +
        ','
      
        '       sum(decode(p688.class_voce,'#39'R'#39',p688.importo,-p688.importo' +
        ')) tot_residuo,'
      
        '       (select max(p690.data_retribuzione) from p690_fondispeso ' +
        'p690 where p690.cod_fondo=p684.cod_fondo and p690.decorrenza_da=' +
        'p684.decorrenza_da) data_ultima_retr'
      
        'from p680_fondimacrocateg p680, p682_fondiraggr p682, p684_fondi' +
        ' p684, p688_risdestdet p688'
      
        'where p680.cod_macrocateg(+)=p684.cod_macrocateg and p682.cod_ra' +
        'ggr(+)=p684.cod_raggr and '
      
        '      p684.cod_fondo=p688.cod_fondo and p684.decorrenza_da=p688.' +
        'decorrenza_da and'
      '      p684.decorrenza_da <= :FINE and'
      '      p684.decorrenza_a >= :INIZIO  '
      'group by p680.cod_macrocateg, p680.descrizione, '
      '         p682.cod_raggr, p682.descrizione,'
      '         nvl(p682.cod_raggr,p684.cod_fondo),'
      '         nvl(p682.descrizione,p684.descrizione),'
      '         p684.cod_fondo,p684.descrizione,'
      
        '         p684.decorrenza_da,p684.decorrenza_a,p684.data_ultimo_m' +
        'onit'
      ')'
      'group by :DATI ,decorrenza_da,decorrenza_a'
      'order by :DATI ,decorrenza_da')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A004400410054004900010000004F000000434F
      445F4D4143524F43415445472C444553435F4D4143524F43415445472C434F44
      5F464F4E444F5F52414747522C444553435F52414747522C434F445F464F4E44
      4F2C444553435F464F4E444F00000000000A0000003A00460049004E0045000C
      00000000000000000000000E0000003A0049004E0049005A0049004F000C0000
      000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000C0000001C00000043004F0044005F004D004100430052004F004300
      41005400450047000100000000001E00000044004500530043005F004D004100
      430052004F00430041005400450047000100000000001E00000043004F004400
      5F0046004F004E0044004F005F00520041004700470052000100000000001400
      000044004500530043005F005200410047004700520001000000000012000000
      43004F0044005F0046004F004E0044004F000100000000001400000044004500
      530043005F0046004F004E0044004F000100000000001A000000440045004300
      4F005200520045004E005A0041005F0044004100010000000000180000004400
      450043004F005200520045004E005A0041005F00410001000000000022000000
      44004100540041005F0055004C00540049004D004F005F004D004F004E004900
      54000100000000001600000054004F0054005F005200490053004F0052005300
      45000100000000001200000054004F0054005F0053005000450053004F000100
      000000001600000054004F0054005F005200450053004900440055004F000100
      00000000}
    Left = 26
    Top = 33
  end
  object cdsDati: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 25
    Top = 85
  end
  object dsrDati: TDataSource
    DataSet = cdsDati
    Left = 96
    Top = 85
  end
end
