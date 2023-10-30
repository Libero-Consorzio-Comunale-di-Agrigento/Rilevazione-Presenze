inherited P684FDefinizioneFondiDtM: TP684FDefinizioneFondiDtM
  OldCreateOrder = True
  Width = 707
  object selP684: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid from P684_FONDI t'
      'order by decorrenza_da, cod_fondo')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000090000001200000043004F0044005F0046004F004E0044004F000100
      000000001A0000004400450043004F005200520045004E005A0041005F004400
      4100010000000000180000004400450043004F005200520045004E005A004100
      5F004100010000000000160000004400450053004300520049005A0049004F00
      4E0045000100000000001C00000043004F0044005F004D004100430052004F00
      430041005400450047000100000000001200000043004F0044005F0052004100
      4700470052000100000000001A00000044004100540041005F0043004F005300
      54004900540055005A0001000000000022000000460049004C00540052004F00
      5F0044004900500045004E00440045004E005400490001000000000022000000
      44004100540041005F0055004C00540049004D004F005F004D004F004E004900
      5400010000000000}
    BeforePost = BeforePostNoStorico
    AfterScroll = selP684AfterScroll
    Left = 40
    Top = 24
    object selP684COD_FONDO: TStringField
      DisplayLabel = 'Cod. fondo'
      FieldName = 'COD_FONDO'
      Required = True
      Size = 15
    end
    object selP684DECORRENZA_DA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA_DA'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object selP684DECORRENZA_A: TDateTimeField
      DisplayLabel = 'Scadenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA_A'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object selP684DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 500
    end
    object selP684COD_MACROCATEG: TStringField
      DisplayLabel = 'Cod. macrocateg.'
      FieldName = 'COD_MACROCATEG'
      Size = 5
    end
    object selP684COD_RAGGR: TStringField
      DisplayLabel = 'Cod. raggrupp.'
      FieldName = 'COD_RAGGR'
      Size = 15
    end
    object selP684DATA_COSTITUZ: TDateTimeField
      DisplayLabel = 'Data costituz.'
      DisplayWidth = 10
      FieldName = 'DATA_COSTITUZ'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!99/99/0000;1;_'
    end
    object selP684FILTRO_DIPENDENTI: TStringField
      DisplayLabel = 'Filtro dipendenti'
      FieldName = 'FILTRO_DIPENDENTI'
      Size = 500
    end
    object selP684DATA_ULTIMO_MONIT: TDateTimeField
      DisplayLabel = 'Data ultimo monit.'
      DisplayWidth = 10
      FieldName = 'DATA_ULTIMO_MONIT'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!99/99/0000;1;_'
    end
    object selP684NOTE: TStringField
      DisplayLabel = 'Note'
      FieldName = 'NOTE'
      Size = 4000
    end
  end
  object dsrP684Ricerca: TDataSource
    Left = 180
    Top = 80
  end
  object dsrP684Dec: TDataSource
    Left = 268
    Top = 80
  end
  object selP690: TOracleDataSet
    SQL.Strings = (
      
        'select P690.*, P690.rowid, T030.COGNOME, T030.NOME, T030.MATRICO' +
        'LA, P430.COD_POSIZIONE_ECONOMICA'
      
        'from P690_FONDISPESO P690, T030_ANAGRAFICO T030, P430_ANAGRAFICO' +
        ' P430'
      'where P690.cod_fondo = :COD'
      'and P690.decorrenza_da = :DEC'
      'and P690.class_voce = '#39'D'#39
      'and P690.PROGRESSIVO = T030.PROGRESSIVO (+)'
      
        'and P690.PROGRESSIVO = P430.PROGRESSIVO (+) and P690.DATA_RETRIB' +
        'UZIONE between P430.DECORRENZA (+) and P430.DECORRENZA_FINE (+)'
      ':CODGEN'
      ':CODDET'
      
        'order by cognome, nome, matricola, data_retribuzione, P690.cod_c' +
        'ontratto, cod_voce')
    Optimize = False
    Variables.Data = {
      0400000004000000080000003A0043004F004400050000000000000000000000
      080000003A004400450043000C00000000000000000000000E0000003A004300
      4F004400470045004E000100000000000000000000000E0000003A0043004F00
      4400440045005400010000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000D0000002200000044004100540041005F0052004500540052004900
      420055005A0049004F004E0045000100000000001A00000043004F0044005F00
      43004F004E00540052004100540054004F000100000000001000000043004F00
      44005F0056004F00430045000100000000000E00000049004D0050004F005200
      54004F000100000000001200000043004F0044005F0046004F004E0044004F00
      0100000000001A0000004400450043004F005200520045004E005A0041005F00
      440041000100000000001400000043004C004100530053005F0056004F004300
      45000100000000001800000043004F0044005F0056004F00430045005F004700
      45004E000100000000001800000043004F0044005F0056004F00430045005F00
      44004500540001000000000016000000500052004F0047005200450053005300
      490056004F00010000000000120000004D00410054005200490043004F004C00
      41000100000000000E00000043004F0047004E004F004D004500010000000000
      080000004E004F004D004500010000000000}
    BeforePost = selP690BeforePost
    OnCalcFields = selP690CalcFields
    OnNewRecord = selP690NewRecord
    Left = 98
    Top = 24
    object selP690PROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selP690MATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldName = 'MATRICOLA'
      Required = True
      Size = 8
    end
    object selP690COGNOME: TStringField
      DisplayLabel = 'Cognome'
      FieldName = 'COGNOME'
      Size = 50
    end
    object selP690NOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Size = 50
    end
    object selP690COD_POSIZIONE_ECONOMICA: TStringField
      DisplayLabel = 'Posiz. economica'
      FieldName = 'COD_POSIZIONE_ECONOMICA'
      Size = 5
    end
    object selP690COD_FONDO: TStringField
      DisplayLabel = 'Cod. fondo'
      FieldName = 'COD_FONDO'
      Required = True
      Visible = False
      Size = 15
    end
    object selP690DECORRENZA_DA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA_DA'
      Required = True
      Visible = False
    end
    object selP690CLASS_VOCE: TStringField
      DisplayLabel = 'Classificaz. voce'
      FieldName = 'CLASS_VOCE'
      Required = True
      Visible = False
      Size = 1
    end
    object selP690COD_VOCE_GEN: TStringField
      DisplayLabel = 'Voce gen.'
      FieldName = 'COD_VOCE_GEN'
      Required = True
      Visible = False
      Size = 5
    end
    object selP690COD_VOCE_DET: TStringField
      DisplayLabel = 'Cod. dett.'
      FieldName = 'COD_VOCE_DET'
      Required = True
      Visible = False
      Size = 5
    end
    object selP690DATA_RETRIBUZIONE: TDateTimeField
      DisplayLabel = 'Mese retribuzione'
      DisplayWidth = 10
      FieldName = 'DATA_RETRIBUZIONE'
      Required = True
      OnGetText = selP690DATA_RETRIBUZIONEGetText
      OnSetText = selP690DATA_RETRIBUZIONESetText
      DisplayFormat = 'MM/YYYY'
      EditMask = '!00/0000;1;_'
    end
    object selP690COD_CONTRATTO: TStringField
      DisplayLabel = 'Contratto voci'
      FieldName = 'COD_CONTRATTO'
      Required = True
      Size = 5
    end
    object selP690COD_VOCE: TStringField
      DisplayLabel = 'Codice voce'
      FieldName = 'COD_VOCE'
      Required = True
      Size = 5
    end
    object selP690Descrizione: TStringField
      FieldKind = fkCalculated
      FieldName = 'Descrizione'
      Size = 50
      Calculated = True
    end
    object selP690IMPORTO: TFloatField
      DisplayLabel = 'Importo'
      DisplayWidth = 15
      FieldName = 'IMPORTO'
      Required = True
      DisplayFormat = '###,###,###,##0.00'
    end
  end
end
