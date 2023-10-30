inherited S030FProvvedimentiDtM: TS030FProvvedimentiDtM
  OldCreateOrder = True
  Height = 75
  Width = 90
  object selSG100: TOracleDataSet
    SQL.Strings = (
      'SELECT SG100.*,SG100.ROWID FROM SG100_PROVVEDIMENTO SG100'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      'ORDER BY TIPO_PROVV,DATADECOR DESC,DATAREGISTR DESC')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000E00000016000000500052004F004700520045005300530049005600
      4F00010000000000120000004E004F004D004500430041004D0050004F000100
      000000001200000044004100540041004400450043004F005200010000000000
      1600000044004100540041005200450047004900530054005200010000000000
      0E000000430041005500530041004C0045000100000000001000000041005500
      54004F005200490054004100010000000000100000005400490050004F004100
      540054004F000100000000000E0000004E0055004D004100540054004F000100
      000000001000000044004100540041004100540054004F000100000000001000
      000044004100540041004500530045004300010000000000080000004E004F00
      54004500010000000000140000005400490050004F005F00500052004F005600
      5600010000000000100000004400410054004100460049004E00450001000000
      0000080000005300450044004500010000000000}
    BeforePost = BeforePostNoStorico
    AfterPost = AfterPost
    AfterScroll = selSG100AfterScroll
    OnNewRecord = selSG100NewRecord
    Left = 20
    Top = 8
    object selSG100PROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Required = True
    end
    object selSG100TIPO_PROVV: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO_PROVV'
      Size = 1
    end
    object selSG100NOMECAMPO: TStringField
      DisplayLabel = 'Nome dato'
      FieldName = 'NOMECAMPO'
      Required = True
    end
    object selSG100DATAREGISTR: TDateTimeField
      DisplayLabel = 'Registrazione'
      FieldName = 'DATAREGISTR'
      OnGetText = selSG100DATAREGISTRGetText
      DisplayFormat = 'dd/mm/yyyy hh.nn'
      EditMask = '!00/00/0000 09:00;1;_'
    end
    object selSG100DATADECOR: TDateTimeField
      DisplayLabel = 'Decorrenza'
      DisplayWidth = 10
      FieldName = 'DATADECOR'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selSG100DATAFINE: TDateTimeField
      DisplayLabel = 'Fine'
      DisplayWidth = 10
      FieldName = 'DATAFINE'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object selSG100CAUSALE: TStringField
      DisplayLabel = 'Motivazione'
      DisplayWidth = 5
      FieldName = 'CAUSALE'
      Size = 5
    end
    object selSG100D_CAUSALI: TStringField
      DisplayLabel = 'Desc. motivazione'
      FieldKind = fkLookup
      FieldName = 'D_CAUSALI'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAUSALE'
      Size = 130
      Lookup = True
    end
    object selSG100TIPOATTO: TStringField
      DisplayLabel = 'Tipo atto'
      FieldName = 'TIPOATTO'
      Size = 30
    end
    object selSG100NUMATTO: TStringField
      DisplayLabel = 'Numero atto'
      FieldName = 'NUMATTO'
      Size = 100
    end
    object selSG100DATAATTO: TDateTimeField
      DisplayLabel = 'Data atto'
      FieldName = 'DATAATTO'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selSG100DATAESEC: TDateTimeField
      DisplayLabel = 'Data esecutivit'#224
      FieldName = 'DATAESEC'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selSG100AUTORITA: TStringField
      DisplayLabel = 'Autorit'#224
      FieldName = 'AUTORITA'
      Size = 40
    end
    object selSG100SEDE: TStringField
      DisplayLabel = 'Sede'
      FieldName = 'SEDE'
      Size = 80
    end
    object selSG100NOTE: TStringField
      DisplayLabel = 'Annotazioni'
      DisplayWidth = 100
      FieldName = 'NOTE'
      Size = 2000
    end
    object selSG100TESTOVAR: TStringField
      DisplayLabel = 'Testo variazione'
      FieldName = 'TESTOVAR'
      Size = 4000
    end
  end
end
