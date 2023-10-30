inherited B110FTimbModificabiliDM: TB110FTimbModificabiliDM
  OldCreateOrder = True
  object selT100ModifTimb: TOracleDataSet
    SQL.Strings = (
      'select T100.ROWID ID,'
      '       T100.DATA, TO_CHAR(T100.ORA,'#39'HH24.MI'#39') as ORA, '
      
        '       T100.CAUSALE, rpad(T100.CAUSALE,5,'#39' '#39') ||'#39' '#39'|| nvl(T275.D' +
        'ESCRIZIONE,T305.DESCRIZIONE) DESC_CAUSALE,'
      
        '       T100.VERSO, DECODE(T100.VERSO,'#39'E'#39','#39'Entrata'#39','#39'U'#39','#39'Uscita'#39')' +
        ' DESC_VERSO,'
      
        '       T100.PROGRESSIVO, T100.FLAG, T100.RILEVATORE, T100.ROWID,' +
        ' '
      
        '       T030.MATRICOLA, T030.COGNOME || '#39' '#39' || T030.NOME as NOMIN' +
        'ATIVO'
      
        'from   T100_TIMBRATURE T100, T030_ANAGRAFICO T030, T275_CAUPRESE' +
        'NZE T275, T305_CAUGIUSTIF T305'
      'where  T100.PROGRESSIVO = :PROGRESSIVO'
      'and    T100.DATA = :DATA_RIF'
      'and    T100.PROGRESSIVO = T030.PROGRESSIVO'
      'and    T100.FLAG IN ('#39'O'#39','#39'I'#39')'
      'and    T100.CAUSALE = T275.CODICE(+)'
      'and    T100.CAUSALE = T305.CODICE(+)'
      'and    not exists (select '#39'X'#39' '
      '                   from   T105_RICHIESTETIMBRATURE T105 '
      '                   where  T100.PROGRESSIVO = T105.PROGRESSIVO '
      '                   and    T100.DATA = T105.DATA '
      
        '                   and    OREMINUTI(to_char(T100.ORA,'#39'HH24.MI'#39'))' +
        ' = OREMINUTI(T105.ORA)'
      '                   and    ((T105.OPERAZIONE <> '#39'M'#39' and '
      '                            T100.VERSO = T105.VERSO) or'
      '                           (T105.OPERAZIONE = '#39'M'#39' and '
      '                            T100.VERSO = T105.VERSO_ORIG))'
      '                   and    nvl(T105.ELABORATO,'#39'N'#39') = '#39'N'#39')'
      'order by T100.DATA, T100.ORA')
    ReadBuffer = 200
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000120000003A0044004100540041005F00
      5200490046000C0000000000000000000000}
    Left = 42
    Top = 30
    object selT100ModifTimbID: TStringField
      FieldName = 'ID'
      Size = 72
    end
    object selT100ModifTimbDATA: TDateTimeField
      FieldName = 'DATA'
    end
    object selT100ModifTimbORA: TStringField
      FieldName = 'ORA'
      Size = 5
    end
    object selT100ModifTimbVERSO: TStringField
      FieldName = 'VERSO'
      Size = 1
    end
    object selT100ModifTimbFLAG: TStringField
      FieldName = 'FLAG'
      Size = 1
    end
    object selT100ModifTimbCAUSALE: TStringField
      FieldName = 'CAUSALE'
      Size = 5
    end
    object selT100ModifTimbRILEVATORE: TStringField
      FieldName = 'RILEVATORE'
      Size = 2
    end
    object selT100ModifTimbMATRICOLA: TStringField
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selT100ModifTimbNOMINATIVO: TStringField
      FieldName = 'NOMINATIVO'
      Size = 65
    end
    object selT100ModifTimbDESC_VERSO: TStringField
      FieldName = 'DESC_VERSO'
      Size = 7
    end
    object selT100ModifTimbDESC_CAUSALE: TStringField
      FieldName = 'DESC_CAUSALE'
      Size = 40
    end
    object selT100ModifTimbMOTIVAZIONE: TStringField
      FieldKind = fkCalculated
      FieldName = 'MOTIVAZIONE'
      Size = 1
      Calculated = True
    end
    object selT100ModifTimbPROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
    end
    object selT100ModifTimbNOTE: TStringField
      FieldKind = fkCalculated
      FieldName = 'NOTE'
      Size = 2000
      Calculated = True
    end
  end
end
