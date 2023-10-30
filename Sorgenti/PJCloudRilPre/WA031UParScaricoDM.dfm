inherited WA031FParScaricoDM: TWA031FParScaricoDM
  Height = 182
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT I100.*,I100.ROWID '
      '  FROM MONDOEDP.I100_PARSCARICO I100'
      ':WHERE '
      ':ORDERBY')
    Variables.Data = {
      0400000002000000100000003A004F0052004400450052004200590001000000
      00000000000000000C0000003A00570048004500520045000100000000000000
      00000000}
    BeforePost = BeforePostNoStorico
    AfterPost = AfterPost
    AfterCancel = AfterCancel
    AfterDelete = AfterDelete
    OnNewRecord = OnNewRecord
    object selTabellaSCARICO: TStringField
      DisplayLabel = 'Nome scarico'
      FieldName = 'SCARICO'
      Required = True
    end
    object selTabellaNOMEFILE: TStringField
      DisplayLabel = 'File'
      FieldName = 'NOMEFILE'
      Required = True
      Size = 100
    end
    object selTabellaCORRENTE: TStringField
      DisplayLabel = 'Scarico automatico'
      FieldName = 'CORRENTE'
      Size = 1
    end
    object selTabellaAZIENDE: TStringField
      DisplayLabel = 'Aziende abilitate'
      FieldName = 'AZIENDE'
      Size = 150
    end
    object selTabellaTIPOSCARICO: TStringField
      DisplayLabel = 'Scarico dating'
      FieldName = 'TIPOSCARICO'
      Origin = 'I100_PARSCARICO.TIPOSCARICO'
      Size = 1
    end
    object selTabellaOFFSET_ANNO: TIntegerField
      DisplayLabel = 'Offset dell'#39'anno'
      FieldName = 'OFFSET_ANNO'
    end
    object selTabellaTRIGGER_BEFORE: TStringField
      FieldName = 'TRIGGER_BEFORE'
      Visible = False
      Size = 1
    end
    object selTabellaTRIGGER_AFTER: TStringField
      FieldName = 'TRIGGER_AFTER'
      Visible = False
      Size = 1
    end
    object selTabellaFUNZIONE: TStringField
      FieldName = 'FUNZIONE'
      Visible = False
      Size = 1
    end
    object selTabellaTIMB_NONTOLL_GGPREC: TIntegerField
      FieldName = 'TIMB_NONTOLL_GGPREC'
      Visible = False
    end
    object selTabellaTIMB_NONTOLL_GGSUCC: TIntegerField
      FieldName = 'TIMB_NONTOLL_GGSUCC'
      Visible = False
    end
    object selTabellaTIMB_NONTOLL_LOG: TStringField
      FieldName = 'TIMB_NONTOLL_LOG'
      Visible = False
      Size = 1
    end
    object selTabellaTIMB_NONTOLL_REG: TStringField
      FieldName = 'TIMB_NONTOLL_REG'
      Visible = False
      Size = 1
    end
    object selTabellaENTRATA: TStringField
      DisplayLabel = 'Entrata'
      FieldName = 'ENTRATA'
      Required = True
      Size = 2
    end
    object selTabellaUSCITA: TStringField
      DisplayLabel = 'Uscita'
      FieldName = 'USCITA'
      Required = True
      Size = 2
    end
    object selTabellaBADGE: TStringField
      DisplayLabel = 'Badge'
      FieldName = 'BADGE'
      Size = 8
    end
    object selTabellaEDBADGE: TStringField
      DisplayLabel = 'Ed.Badge'
      FieldName = 'EDBADGE'
      Size = 8
    end
    object selTabellaANNO: TStringField
      DisplayLabel = 'Anno'
      FieldName = 'ANNO'
      Size = 8
    end
    object selTabellaMESE: TStringField
      DisplayLabel = 'Mese'
      FieldName = 'MESE'
      Size = 8
    end
    object selTabellaGIORNO: TStringField
      DisplayLabel = 'Giorno'
      FieldName = 'GIORNO'
      Size = 8
    end
    object selTabellaORE: TStringField
      DisplayLabel = 'Ore'
      FieldName = 'ORE'
      Size = 8
    end
    object selTabellaMINUTI: TStringField
      DisplayLabel = 'Minuti'
      FieldName = 'MINUTI'
      Size = 8
    end
    object selTabellaSECONDI: TStringField
      DisplayLabel = 'Secondi'
      FieldName = 'SECONDI'
      Size = 8
    end
    object selTabellaVERSO: TStringField
      DisplayLabel = 'Verso'
      FieldName = 'VERSO'
      Size = 8
    end
    object selTabellaRILEVATORE: TStringField
      DisplayLabel = 'Rilevatore'
      FieldName = 'RILEVATORE'
      Size = 8
    end
    object selTabellaCAUSALE: TStringField
      DisplayLabel = 'Causale'
      FieldName = 'CAUSALE'
      Size = 8
    end
    object selTabellaIPADDRESS: TStringField
      FieldName = 'IPADDRESS'
      Visible = False
      Size = 15
    end
    object selTabellaTCP: TStringField
      FieldName = 'TCP'
      Visible = False
      Size = 1
    end
    object selTabellaEXPR_CHIAVE: TStringField
      FieldName = 'EXPR_CHIAVE'
      Visible = False
      Size = 2000
    end
    object selTabellaCHIAVE: TStringField
      FieldName = 'CHIAVE'
      Visible = False
      Size = 8
    end
  end
  inherited dsrTabella: TDataSource
    AutoEdit = True
  end
  object selI090: TOracleDataSet
    SQL.Strings = (
      'SELECT AZIENDA FROM MONDOEDP.I090_ENTI ORDER BY AZIENDA')
    Optimize = False
    Left = 28
    Top = 124
  end
end
