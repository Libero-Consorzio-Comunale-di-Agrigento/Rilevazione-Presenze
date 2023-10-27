inherited WR003FGeneratoreStampeDM: TWR003FGeneratoreStampeDM
  Height = 231
  Width = 499
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T.*,T.ROWID '
      'FROM T910_RIEPILOGO T'
      'WHERE T.APPLICAZIONE = :APPLICAZIONE  '
      'AND nvl(TEMP_B028,'#39'N'#39') = nvl(:TEMP_B028,nvl(TEMP_B028,'#39'N'#39'))'
      ':ORDERBY')
    Variables.Data = {
      0400000003000000100000003A004F0052004400450052004200590001000000
      00000000000000001A0000003A004100500050004C004900430041005A004900
      4F004E004500050000000000000000000000140000003A00540045004D005000
      5F004200300032003800050000000000000000000000}
    Filtered = True
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    OnFilterRecord = selTabellaFilterRecord
    OnNewRecord = OnNewRecord
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Size = 30
    end
    object selTabellaTITOLO: TStringField
      DisplayLabel = 'Titolo'
      FieldName = 'TITOLO'
      Size = 80
    end
    object selTabellaAPPLICAZIONE: TStringField
      DisplayLabel = 'Applicazione'
      FieldName = 'APPLICAZIONE'
      Visible = False
      Size = 70
    end
    object selTabellaTABELLA_GENERATA: TStringField
      DisplayLabel = 'Tabella generata'
      FieldName = 'TABELLA_GENERATA'
      Size = 200
    end
    object selTabellaTIPO: TStringField
      DisplayLabel = 'Tipo stampa'
      FieldName = 'TIPO'
      Size = 1
    end
    object selTabellaFORMATO_PAGINA: TStringField
      DisplayLabel = 'Formato pagina'
      FieldName = 'FORMATO_PAGINA'
      Size = 3
    end
    object selTabellaORIENTAMENTO_PAGINA: TStringField
      DisplayLabel = 'Orientamento pagina'
      FieldName = 'ORIENTAMENTO_PAGINA'
      Size = 1
    end
    object selTabellaCONTEGGIGIORNALIERI: TStringField
      DisplayLabel = 'Periodi storici'
      FieldName = 'CONTEGGIGIORNALIERI'
      Size = 1
    end
    object selTabellaCDC_PERCENTUALIZZATI: TStringField
      DisplayLabel = 'cdc percentualizzati'
      FieldName = 'CDC_PERCENTUALIZZATI'
      Size = 1
    end
    object selTabellaDATA_ACCESSO: TDateTimeField
      DisplayLabel = 'Data ultimo accesso'
      FieldName = 'DATA_ACCESSO'
    end
    object selTabellaUTENTE_ACCESSO: TStringField
      DisplayLabel = 'Utente ultimo acesso'
      FieldName = 'UTENTE_ACCESSO'
      Size = 30
    end
    object selTabellaSEPARAH: TStringField
      DisplayLabel = 'Separatore riga'
      FieldName = 'SEPARAH'
      Visible = False
      Size = 1
    end
    object selTabellaSEPARAV: TStringField
      DisplayLabel = 'Separatore colonna'
      FieldName = 'SEPARAV'
      Visible = False
      Size = 1
    end
    object selTabellaFONTNAME: TStringField
      DisplayLabel = 'Nome font'
      FieldName = 'FONTNAME'
      Visible = False
      Size = 30
    end
    object selTabellaFONTSIZE: TIntegerField
      DisplayLabel = 'Dim. font'
      FieldName = 'FONTSIZE'
      Visible = False
    end
    object selTabellaSALTOPAGINA: TStringField
      DisplayLabel = 'Salto pagina'
      FieldName = 'SALTOPAGINA'
      Visible = False
      Size = 1
    end
    object selTabellaTOTALI: TStringField
      DisplayLabel = 'Solo totali'
      FieldName = 'TOTALI'
      Visible = False
      Size = 1
    end
    object selTabellaTOTPARZIALI: TStringField
      DisplayLabel = 'Totali parziali'
      FieldName = 'TOTPARZIALI'
      Visible = False
      Size = 1
    end
    object selTabellaTOTGENERALI: TStringField
      DisplayLabel = 'Totali generali'
      FieldName = 'TOTGENERALI'
      Visible = False
      Size = 1
    end
    object selTabellaFILTROESCLUSIVO: TStringField
      DisplayLabel = 'Filtri esclusivi sui dipendenti'
      FieldName = 'FILTROESCLUSIVO'
      Visible = False
      Size = 1
    end
    object selTabellaVALORENULLO: TStringField
      DisplayLabel = 'Evidenzia valori nulli'
      FieldName = 'VALORENULLO'
      Visible = False
      Size = 1
    end
    object selTabellaIMPOSTAZIONI: TStringField
      DisplayLabel = 'Impostazioni'
      FieldName = 'IMPOSTAZIONI'
      Visible = False
      Size = 300
    end
    object selTabellaSTAMPA_TITOLO: TStringField
      DisplayLabel = 'Stampa titolo'
      FieldName = 'STAMPA_TITOLO'
      Visible = False
      Size = 1
    end
    object selTabellaSTAMPA_PERIODO: TStringField
      DisplayLabel = 'Stampa periodo'
      FieldName = 'STAMPA_PERIODO'
      Visible = False
      Size = 1
    end
    object selTabellaSTAMPA_NUMPAG: TStringField
      DisplayLabel = 'Stampa num pag.'
      FieldName = 'STAMPA_NUMPAG'
      Visible = False
      Size = 1
    end
    object selTabellaSTAMPA_DATA: TStringField
      DisplayLabel = 'stampa data'
      FieldName = 'STAMPA_DATA'
      Visible = False
      Size = 1
    end
    object selTabellaSTAMPA_AZIENDA: TStringField
      DisplayLabel = 'Stampa azienda'
      FieldName = 'STAMPA_AZIENDA'
      Visible = False
      Size = 1
    end
    object selTabellaTOTRIEPILOGO: TStringField
      DisplayLabel = 'Tot. riepilogo'
      FieldName = 'TOTRIEPILOGO'
      Visible = False
      Size = 1
    end
    object selTabellaINTESTAZIONE_COLONNE: TStringField
      DisplayLabel = 'Intestazione colonne'
      FieldName = 'INTESTAZIONE_COLONNE'
      Visible = False
      Size = 1
    end
    object selTabellaFILTRO_INSERVIZIO: TStringField
      DisplayLabel = 'Filtro in servizio'
      FieldName = 'FILTRO_INSERVIZIO'
      Visible = False
      Size = 1
    end
    object selTabellaSALTOPAGINA_TOTALI: TStringField
      FieldName = 'SALTOPAGINA_TOTALI'
      Visible = False
      Size = 1
    end
    object selTabellaTABELLA_GENERATA_DROP: TStringField
      DisplayLabel = 'Ricrea / aggiorna tabella'
      FieldName = 'TABELLA_GENERATA_DROP'
      Visible = False
      Size = 1
    end
    object selTabellaTABELLA_GENERATA_KEY: TStringField
      DisplayLabel = 'Chiave di aggiornamento'
      FieldName = 'TABELLA_GENERATA_KEY'
      Visible = False
      Size = 1000
    end
    object selTabellaTABELLA_GENERATA_DELETE: TStringField
      DisplayLabel = 'Condiz. cancellaz. record'
      FieldName = 'TABELLA_GENERATA_DELETE'
      Visible = False
      Size = 1000
    end
    object selTabellaSTAMPA_BLOCCATA: TStringField
      DisplayLabel = 'Stampa bloccata'
      FieldName = 'STAMPA_BLOCCATA'
      Visible = False
      Size = 1
    end
    object selTabellaQUERY_INTESTAZIONE: TStringField
      DisplayLabel = 'Query intestazione'
      FieldName = 'QUERY_INTESTAZIONE'
      Visible = False
      Size = 30
    end
    object selTabellaQUERY_FINESTAMPA: TStringField
      DisplayLabel = 'Query fine stampa'
      FieldName = 'QUERY_FINESTAMPA'
      Visible = False
      Size = 30
    end
    object selTabellaROTTURA_PERIODI_NON_CONTIGUI: TStringField
      FieldName = 'ROTTURA_PERIODI_NON_CONTIGUI'
      Visible = False
      Size = 1
    end
  end
  object cdsDatiIntestazione: TClientDataSet
    Aggregates = <>
    DisableStringTrim = True
    Params = <>
    Left = 424
    Top = 128
    object cdsDatiIntestazioneNOME: TStringField
      DisplayLabel = 'Campo'
      DisplayWidth = 20
      FieldName = 'NOME'
      Size = 100
    end
    object cdsDatiIntestazioneCAPTION: TStringField
      DisplayLabel = 'Caption'
      DisplayWidth = 20
      FieldName = 'CAPTION'
      Size = 40
    end
    object cdsDatiIntestazioneTOP: TIntegerField
      DisplayLabel = 'Alto'
      DisplayWidth = 2
      FieldName = 'TOP'
    end
    object cdsDatiIntestazioneLEFT: TIntegerField
      DisplayLabel = 'Sin.'
      DisplayWidth = 2
      FieldName = 'LEFT'
    end
    object cdsDatiIntestazioneHEIGHT: TIntegerField
      DisplayLabel = 'Alt.'
      DisplayWidth = 2
      FieldName = 'HEIGHT'
    end
    object cdsDatiIntestazioneWIDTH: TIntegerField
      DisplayLabel = 'Largh.'
      DisplayWidth = 2
      FieldName = 'WIDTH'
    end
    object cdsDatiIntestazioneTOTALE: TStringField
      Alignment = taCenter
      DisplayLabel = 'Totale'
      FieldName = 'TOTALE'
      Size = 1
    end
    object cdsDatiIntestazioneFITTIZIO: TStringField
      DisplayLabel = 'Propriet'#224
      FieldName = 'FITTIZIO'
      Size = 1
    end
  end
  object cdsDatiDettaglio: TClientDataSet
    Aggregates = <>
    DisableStringTrim = True
    Params = <>
    Left = 424
    Top = 176
    object StringField1: TStringField
      DisplayLabel = 'Campo'
      DisplayWidth = 20
      FieldName = 'NOME'
      Size = 100
    end
    object StringField2: TStringField
      DisplayLabel = 'Caption'
      DisplayWidth = 20
      FieldName = 'CAPTION'
      Size = 40
    end
    object IntegerField1: TIntegerField
      DisplayLabel = 'Alto'
      DisplayWidth = 2
      FieldName = 'TOP'
    end
    object IntegerField2: TIntegerField
      DisplayLabel = 'Sin.'
      DisplayWidth = 2
      FieldName = 'LEFT'
    end
    object IntegerField3: TIntegerField
      DisplayLabel = 'Alt.'
      DisplayWidth = 2
      FieldName = 'HEIGHT'
    end
    object IntegerField4: TIntegerField
      DisplayLabel = 'Largh.'
      DisplayWidth = 2
      FieldName = 'WIDTH'
    end
    object cdsDatiDettaglioTOTALE: TStringField
      Alignment = taCenter
      DisplayLabel = 'Totale'
      FieldName = 'TOTALE'
      Size = 1
    end
    object cdsDatiDettaglioFITTIZIO: TStringField
      DisplayLabel = 'Propriet'#224
      FieldName = 'FITTIZIO'
      Size = 1
    end
  end
  object delT910_TempB028: TOracleQuery
    SQL.Strings = (
      'begin'
      '  update T910_RIEPILOGO '
      
        '  set DATA_ACCESSO = (select DATA_ACCESSO from T910_RIEPILOGO wh' +
        'ere CODICE = :CODICE and TEMP_B028 = '#39'S'#39'), '
      
        '      UTENTE_ACCESSO = (select UTENTE_ACCESSO from T910_RIEPILOG' +
        'O where CODICE = :CODICE and TEMP_B028 = '#39'S'#39') '
      
        '  where CODICE = (select TEMP_B028_CODICE from T910_RIEPILOGO wh' +
        'ere CODICE = :CODICE and TEMP_B028 = '#39'S'#39');'
      ''
      
        '  delete from T911_DATIRIEPILOGO where CODICE = :CODICE and CODI' +
        'CE in (select CODICE from T910_RIEPILOGO where TEMP_B028 = '#39'S'#39');'
      
        '  delete from T912_SORTRIEPILOGO where CODICE = :CODICE and CODI' +
        'CE in (select CODICE from T910_RIEPILOGO where TEMP_B028 = '#39'S'#39');'
      
        '  delete from T913_SERBATOIKEY where CODICE = :CODICE and CODICE' +
        ' in (select CODICE from T910_RIEPILOGO where TEMP_B028 = '#39'S'#39');'
      
        '  delete from T914_SERBATOIFILTRO where CODICE = :CODICE and COD' +
        'ICE in (select CODICE from T910_RIEPILOGO where TEMP_B028 = '#39'S'#39')' +
        ';'
      
        '  delete from T915_CODICISELEZIONATI where CODICE = :CODICE and ' +
        'CODICE in (select CODICE from T910_RIEPILOGO where TEMP_B028 = '#39 +
        'S'#39');'
      
        '  delete from T910_RIEPILOGO where CODICE = :CODICE and TEMP_B02' +
        '8 = '#39'S'#39';'
      'end;')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 192
    Top = 120
  end
end
