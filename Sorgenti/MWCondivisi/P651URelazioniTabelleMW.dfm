inherited P651FRelazioniTabelleMW: TP651FRelazioniTabelleMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 191
  Width = 451
  object selDato1: TOracleDataSet
    Optimize = False
    Left = 88
    Top = 8
  end
  object selDato2: TOracleDataSet
    Optimize = False
    Left = 168
    Top = 8
  end
  object selP660: TOracleDataSet
    SQL.Strings = (
      'select distinct P660.NOME_DATO '
      'from P660_FLUSSIREGOLE P660'
      'where P660.NOME_FLUSSO = '#39'FLUPER'#39
      '  and P660.PARTE = '#39'B'#39' AND NUMERO IN (:NUMERI)'
      
        '  and P660.DECORRENZA = (select max(t.decorrenza) from p660_flus' +
        'siregole t where t.nome_flusso = p660.nome_flusso'
      
        '                            and t.parte = P660.parte and t.numer' +
        'o = p660.numero) ')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A004E0055004D00450052004900010000000000
      000000000000}
    Left = 24
    Top = 64
  end
  object selFlussi: TOracleDataSet
    SQL.Strings = (
      'select distinct NOME_FLUSSO'
      'from I037_RELAZIONI_TABELLE'
      'where NOME_FLUSSO :OPERATORE_RELAZIONALE '#39'FLUPER%'#39
      'order by NOME_FLUSSO')
    Optimize = False
    Variables.Data = {
      04000000010000002C0000003A004F00500045005200410054004F0052004500
      5F00520045004C0041005A0049004F004E0041004C0045000100000000000000
      00000000}
    Left = 24
    Top = 8
  end
  object selCtrlPerc: TOracleDataSet
    SQL.Strings = (
      
        'select I037B.COD_DATO1, I037B.DATARIF, sum(nvl(I037A.PERCENTUALE' +
        ',100)) PERCENTUALE from'
      'I037_RELAZIONI_TABELLE I037A,'
      '('
      'select distinct NOME_FLUSSO, COD_DATO1, DECORRENZA DATARIF'
      'from I037_RELAZIONI_TABELLE'
      'where NOME_FLUSSO = :NOME_FLUSSO'
      'union'
      'select distinct NOME_FLUSSO, COD_DATO1, DECORRENZA_FINE DATARIF'
      'from I037_RELAZIONI_TABELLE'
      'where NOME_FLUSSO = :NOME_FLUSSO'
      'union'
      'select distinct NOME_FLUSSO, COD_DATO1, DECORRENZA - 1 DATARIF'
      'from I037_RELAZIONI_TABELLE'
      'where NOME_FLUSSO = :NOME_FLUSSO'
      'union'
      
        'select distinct NOME_FLUSSO, COD_DATO1, DECORRENZA_FINE + 1 DATA' +
        'RIF'
      'from I037_RELAZIONI_TABELLE'
      'where NOME_FLUSSO = :NOME_FLUSSO'
      ') I037B'
      'where I037B.NOME_FLUSSO = I037A.NOME_FLUSSO'
      'and I037B.COD_DATO1 = I037A.COD_DATO1'
      
        'and I037B.DATARIF between I037A.DECORRENZA and I037A.DECORRENZA_' +
        'FINE'
      'group by I037B.COD_DATO1, I037B.DATARIF'
      'having sum(nvl(I037A.PERCENTUALE,100)) <> 100'
      'order by I037B.COD_DATO1, I037B.DATARIF')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A004E004F004D0045005F0046004C0055005300
      53004F00050000000000000000000000}
    Left = 168
    Top = 64
  end
  object selDato1Cod: TOracleDataSet
    Optimize = False
    Left = 248
    Top = 8
  end
  object selDato2Cod: TOracleDataSet
    Optimize = False
    Left = 328
    Top = 8
  end
end
