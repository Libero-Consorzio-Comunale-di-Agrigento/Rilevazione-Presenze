inherited WA156FNotificheIrisWEBDM: TWA156FNotificheIrisWEBDM
  Height = 127
  Width = 402
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select i040.id, '
      '       i040.descrizione, '
      '       i040.notifica, '
      '       decode(t.object_name,'
      
        '              null,'#39'ATTENZIONE! La procedura Oracle di notifica ' +
        '"'#39' || i040.notifica || '#39'" '#232' stata rimossa oppure '#232' invalida!'#39','
      
        '              dbms_lob.substr(dbms_metadata.get_ddl(t.object_typ' +
        'e,t.object_name),2000,1)) notifica_sql_text,'
      '       I040.ATTIVO,'
      '       I040.VALIDO_DAL,'
      '       I040.VALIDO_AL,'
      '       i040.rowid'
      'from   i040_notifiche_irisweb i040,'
      '       user_objects t'
      'where  t.object_name (+) = i040.notifica'
      'and    t.object_type (+) = '#39'PROCEDURE'#39'       '
      ':ORDERBY')
    object selTabellaID: TIntegerField
      DisplayWidth = 8
      FieldName = 'ID'
      Visible = False
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 50
      FieldName = 'DESCRIZIONE'
      Size = 100
    end
    object selTabellaNOTIFICA: TStringField
      DisplayLabel = 'Notifica'
      FieldName = 'NOTIFICA'
      Size = 30
    end
    object selTabellaNOTIFICA_SQL_TEXT: TStringField
      DisplayLabel = 'Testo SQL'
      FieldName = 'NOTIFICA_SQL_TEXT'
      ReadOnly = True
      Visible = False
      Size = 2000
    end
    object selTabellaATTIVO: TStringField
      DisplayLabel = 'Attivo'
      FieldName = 'ATTIVO'
      Required = True
      Size = 1
    end
    object selTabellaVALIDO_DAL: TDateTimeField
      DisplayLabel = 'Inizio Validit'#224
      DisplayWidth = 10
      FieldName = 'VALIDO_DAL'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaVALIDO_AL: TDateTimeField
      DisplayLabel = 'Fine Validit'#224
      DisplayWidth = 10
      FieldName = 'VALIDO_AL'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
  end
end
