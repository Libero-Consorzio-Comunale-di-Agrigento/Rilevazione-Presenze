inherited WP655FDatiINPDAPMMDM: TWP655FDatiINPDAPMMDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      
        'select P662.*, DECODE(CHIUSO,'#39'S'#39','#39'Si'#39','#39'N'#39','#39'No'#39') DESC_CHIUSO,P662' +
        '.ROWID '
      '  from P662_FLUSSITESTATE P662'
      ' where NOME_FLUSSO=:NOMEFLUSSO'
      ' :ORDERBY'
      ''
      '')
    Variables.Data = {
      0400000002000000100000003A004F0052004400450052004200590001000000
      0000000000000000160000003A004E004F004D00450046004C00550053005300
      4F00050000000000000000000000}
    BeforeDelete = BeforeDelete
    object selTabellaDATA_FINE_PERIODO: TDateTimeField
      DisplayLabel = 'Data fine mese fornitura'
      FieldName = 'DATA_FINE_PERIODO'
      Required = True
    end
    object selTabellaCHIUSO: TStringField
      FieldName = 'CHIUSO'
      Visible = False
      Size = 1
    end
    object selTabellaDESC_CHIUSO: TStringField
      DisplayLabel = 'Elaborazione chiusa'
      FieldKind = fkInternalCalc
      FieldName = 'DESC_CHIUSO'
      Size = 5
    end
    object selTabellaDATA_CHIUSURA: TDateTimeField
      DisplayLabel = 'Data chiusura'
      FieldName = 'DATA_CHIUSURA'
    end
    object selTabellaNOME_FLUSSO: TStringField
      FieldName = 'NOME_FLUSSO'
      Visible = False
      Size = 10
    end
    object selTabellaID_FLUSSO: TFloatField
      DisplayLabel = 'Identificativo'
      FieldName = 'ID_FLUSSO'
      Required = True
    end
  end
end
