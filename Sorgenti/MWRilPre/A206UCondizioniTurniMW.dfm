inherited A206FCondizioniTurniMW: TA206FCondizioniTurniMW
  OldCreateOrder = True
  Height = 169
  Width = 695
  object selT603: TOracleDataSet
    SQL.Strings = (
      'select '#39'*'#39' CODICE, '#39'Tutte le squadre'#39' DESCRIZIONE'
      'from dual'
      'where :SQUADRA_ABILITA = '#39'N'#39
      'union'
      'select T603.CODICE, T603.DESCRIZIONE'
      'from T603_SQUADRE T603'
      
        'where T603.INIZIO_VALIDITA <= NVL(:DECORRENZA_FINE,TO_DATE('#39'3112' +
        '3999'#39','#39'DDMMYYYY'#39'))'
      
        'and T603.FINE_VALIDITA >=  NVL(:DECORRENZA,TO_DATE('#39'01011900'#39','#39'D' +
        'DMMYYYY'#39'))'
      'order by 1')
    Optimize = False
    Variables.Data = {
      0400000003000000200000003A004400450043004F005200520045004E005A00
      41005F00460049004E0045000C0000000000000000000000160000003A004400
      450043004F005200520045004E005A0041000C00000000000000000000002000
      00003A0053005100550041004400520041005F004100420049004C0049005400
      4100050000000000000000000000}
    Filtered = True
    OnFilterRecord = selT603FilterRecord
    Left = 40
    Top = 32
    object selT603CODICE: TStringField
      DisplayWidth = 12
      FieldName = 'CODICE'
      Size = 10
    end
    object selT603DESCRIZIONE: TStringField
      DisplayWidth = 48
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
  object dsrT603: TDataSource
    DataSet = selT603
    Left = 40
    Top = 88
  end
  object selT430: TOracleDataSet
    SQL.Strings = (
      'select distinct T430.TIPOOPE'
      'from T430_STORICO T430'
      'where T430.DATADECORRENZA <= :DECORRENZA_FINE'
      'and T430.DATAFINE >= :DECORRENZA'
      'and T430.TIPOOPE is not null'
      'order by 1')
    Optimize = False
    Variables.Data = {
      0400000002000000200000003A004400450043004F005200520045004E005A00
      41005F00460049004E0045000C0000000000000000000000160000003A004400
      450043004F005200520045004E005A0041000C0000000000000000000000}
    Left = 104
    Top = 32
    object selT430TIPOOPE: TStringField
      FieldName = 'TIPOOPE'
      Size = 5
    end
  end
  object dsrTipoOpe: TDataSource
    DataSet = selTipoOpe
    Left = 168
    Top = 88
  end
  object selGiorni: TOracleDataSet
    SQL.Strings = (
      
        'select '#39'*'#39' CODICE, '#39'Tutti i giorni'#39' DESCRIZIONE,  1 ORD from dua' +
        'l union'
      
        'select '#39'1'#39' CODICE, '#39'Luned'#236#39'         DESCRIZIONE,  2 ORD from dua' +
        'l union'
      
        'select '#39'2'#39' CODICE, '#39'Marted'#236#39'        DESCRIZIONE,  3 ORD from dua' +
        'l union'
      
        'select '#39'3'#39' CODICE, '#39'Mercoled'#236#39'      DESCRIZIONE,  4 ORD from dua' +
        'l union'
      
        'select '#39'4'#39' CODICE, '#39'Gioved'#236#39'        DESCRIZIONE,  5 ORD from dua' +
        'l union'
      
        'select '#39'5'#39' CODICE, '#39'Venerd'#236#39'        DESCRIZIONE,  6 ORD from dua' +
        'l union'
      
        'select '#39'6'#39' CODICE, '#39'Sabato'#39'         DESCRIZIONE,  7 ORD from dua' +
        'l union'
      
        'select '#39'7'#39' CODICE, '#39'Domenica'#39'       DESCRIZIONE,  8 ORD from dua' +
        'l union'
      
        'select '#39'P'#39' CODICE, '#39'Prefestivi'#39'     DESCRIZIONE,  9 ORD from dua' +
        'l union'
      
        'select '#39'F'#39' CODICE, '#39'Festivi'#39'        DESCRIZIONE, 10 ORD from dua' +
        'l'
      'order by ORD')
    Optimize = False
    Left = 360
    Top = 32
    object selGiorniCODICE: TStringField
      DisplayWidth = 2
      FieldName = 'CODICE'
      Size = 1
    end
    object selGiorniDESCRIZIONE: TStringField
      DisplayWidth = 17
      FieldName = 'DESCRIZIONE'
      Size = 14
    end
    object selGiorniORD: TFloatField
      FieldName = 'ORD'
    end
  end
  object dsrGiorni: TDataSource
    DataSet = selGiorni
    Left = 360
    Top = 88
  end
  object selT020: TOracleDataSet
    SQL.Strings = (
      'select '#39'*'#39' CODICE, '#39'Tutti gli orari'#39' DESCRIZIONE'
      'from DUAL'
      'union'
      'select T020.CODICE, T020.DESCRIZIONE'
      'from T020_ORARI T020'
      'where T020.DECORRENZA = (select max(T020B.DECORRENZA)'
      '                         from T020_ORARI T020B'
      '                         where T020B.CODICE = T020.CODICE'
      
        '                         and T020B.DECORRENZA <= NVL(:DECORRENZA' +
        '_FINE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')))'
      'and exists (select 1 from T021_FASCEORARI T021'
      '            where T021.CODICE = T020.CODICE'
      '            and T021.SIGLATURNI is not null)'
      'order by 1')
    Optimize = False
    Variables.Data = {
      0400000001000000200000003A004400450043004F005200520045004E005A00
      41005F00460049004E0045000C0000000000000000000000}
    Left = 232
    Top = 32
    object selT020CODICE: TStringField
      DisplayWidth = 7
      FieldName = 'CODICE'
      Size = 5
    end
    object selT020DESCRIZIONE: TStringField
      DisplayWidth = 48
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
  object dsrT020: TDataSource
    DataSet = selT020
    Left = 232
    Top = 88
  end
  object selT021: TOracleDataSet
    SQL.Strings = (
      'select '#39'*'#39' SIGLATURNI, '#39'Tutte le sigle turno'#39' DESCRIZIONE'
      'from dual'
      'where :TURNO_ABILITA = '#39'N'#39
      'union'
      'select distinct T021.SIGLATURNI, NULL DESCRIZIONE'
      'from T021_FASCEORARI T021'
      'where T021.CODICE = DECODE(:CODICE,'#39'*'#39',T021.CODICE,:CODICE)'
      'and T021.SIGLATURNI is not null'
      'order by 1')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A0043004F004400490043004500050000000000
      0000000000001C0000003A005400550052004E004F005F004100420049004C00
      490054004100050000000000000000000000}
    Left = 296
    Top = 32
    object selT021SIGLATURNI: TStringField
      DisplayWidth = 3
      FieldName = 'SIGLATURNI'
      Size = 2
    end
    object selT021DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
    end
  end
  object dsrT021: TDataSource
    DataSet = selT021
    Left = 296
    Top = 88
  end
  object selT605: TOracleDataSet
    SQL.Strings = (
      'select T605.CODICE, T605.DESCRIZIONE'
      'from T605_CODICICONDIZIONI T605'
      'order by T605.CODICE')
    Optimize = False
    OnFilterRecord = selT605FilterRecord
    Left = 424
    Top = 32
    object selT605CODICE: TStringField
      DisplayWidth = 7
      FieldName = 'CODICE'
      Size = 5
    end
    object selT605DESCRIZIONE: TStringField
      DisplayWidth = 48
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
  object dsrT605: TDataSource
    DataSet = selT605
    Left = 424
    Top = 88
  end
  object selT605a: TOracleDataSet
    SQL.Strings = (
      'select T605.*'
      'from T605_CODICICONDIZIONI T605'
      'order by T605.CODICE')
    Optimize = False
    Left = 480
    Top = 32
    object selT605aCODICE: TStringField
      DisplayLabel = 'Codice'
      DisplayWidth = 7
      FieldName = 'CODICE'
      Size = 5
    end
    object selT605aDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 48
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selT605aGENERALE: TStringField
      DisplayLabel = 'Generale'
      FieldName = 'GENERALE'
      Size = 1
    end
    object selT605aINDIVIDUALE: TStringField
      DisplayLabel = 'Individuale'
      FieldName = 'INDIVIDUALE'
      Size = 1
    end
    object selT605aSQUADRA_ABILITA: TStringField
      DisplayLabel = 'Squadra abilitata'
      FieldName = 'SQUADRA_ABILITA'
      Size = 1
    end
    object selT605aTIPOOPE_ABILITA: TStringField
      DisplayLabel = 'Operatore abilitato'
      FieldName = 'TIPOOPE_ABILITA'
      Size = 1
    end
    object selT605aORARIO_ABILITA: TStringField
      DisplayLabel = 'Orario abilitato'
      FieldName = 'ORARIO_ABILITA'
      Size = 1
    end
    object selT605aTURNO_ABILITA: TStringField
      DisplayLabel = 'Sigla turno abilitata'
      FieldName = 'TURNO_ABILITA'
      Size = 1
    end
    object selT605aGIORNO_ABILITA: TStringField
      DisplayLabel = 'Giorno abilitato'
      FieldName = 'GIORNO_ABILITA'
      Size = 1
    end
    object selT605aMINIMO_ABILITA: TStringField
      DisplayLabel = 'Minimo abilitato'
      FieldName = 'MINIMO_ABILITA'
      Size = 1
    end
    object selT605aMINIMO_OBBLIGA: TStringField
      DisplayLabel = 'Minimo obbligatorio'
      FieldName = 'MINIMO_OBBLIGA'
      Size = 1
    end
    object selT605aOTTIMALE_ABILITA: TStringField
      DisplayLabel = 'Ottimale abilitato'
      FieldName = 'OTTIMALE_ABILITA'
      Size = 1
    end
    object selT605aOTTIMALE_OBBLIGA: TStringField
      DisplayLabel = 'Ottimale obbligatorio'
      FieldName = 'OTTIMALE_OBBLIGA'
      Size = 1
    end
    object selT605aMASSIMO_ABILITA: TStringField
      DisplayLabel = 'Massimo abilitato'
      FieldName = 'MASSIMO_ABILITA'
      Size = 1
    end
    object selT605aMASSIMO_OBBLIGA: TStringField
      DisplayLabel = 'Massimo obbligatorio'
      FieldName = 'MASSIMO_OBBLIGA'
      Size = 1
    end
    object selT605aVALORE_ABILITA: TStringField
      DisplayLabel = 'Valore abilitato'
      FieldName = 'VALORE_ABILITA'
      Size = 1
    end
    object selT605aVALORE_OBBLIGA: TStringField
      DisplayLabel = 'Valore obbligatorio'
      FieldName = 'VALORE_OBBLIGA'
      Size = 1
    end
    object selT605aVALORE_TIPO: TStringField
      DisplayLabel = 'Tipologia valore'
      FieldName = 'VALORE_TIPO'
      Size = 4
    end
  end
  object selTipoVal: TOracleDataSet
    SQL.Strings = (
      'select '#39'ANAG'#39' TIPOVAL from dual union'
      'select '#39'T020'#39' TIPOVAL from dual union'
      'select '#39'T265'#39' TIPOVAL from dual')
    Optimize = False
    Left = 536
    Top = 32
  end
  object dsrTipoVal: TDataSource
    DataSet = selTipoVal
    Left = 536
    Top = 88
  end
  object selTipoOpe: TOracleDataSet
    SQL.Strings = (
      'select '#39'*'#39' TIPOOPE, '#39'Tutti i tipi operatore'#39' DESCRIZIONE'
      'from dual'
      'where :TIPOOPE_ABILITA = '#39'N'#39
      ':COND_TIPIOPE_T430'
      'order by 1')
    Optimize = False
    Variables.Data = {
      0400000002000000200000003A005400490050004F004F00500045005F004100
      420049004C00490054004100050000000000000000000000240000003A004300
      4F004E0044005F0054004900500049004F00500045005F005400340033003000
      010000000000000000000000}
    Left = 168
    Top = 32
    object selTipoOpeTIPOOPE: TStringField
      DisplayWidth = 7
      FieldName = 'TIPOOPE'
      Size = 5
    end
    object selTipoOpeDESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 22
    end
  end
  object selT265: TOracleDataSet
    SQL.Strings = (
      'select CODICE, DESCRIZIONE'
      'from T265_CAUASSENZE'
      'order by CODICE')
    Optimize = False
    Left = 600
    Top = 32
  end
end
