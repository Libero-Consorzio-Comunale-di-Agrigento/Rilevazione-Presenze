inherited A156FNotificheIrisWEBDtM: TA156FNotificheIrisWEBDtM
  OldCreateOrder = True
  Height = 77
  Width = 102
  object selI040: TOracleDataSet
    SQL.Strings = (
      'select I040.ID, '
      '       I040.DESCRIZIONE, '
      '       I040.NOTIFICA, '
      '       decode(t.object_name,'
      
        '              null,'#39'ATTENZIONE! La procedura Oracle di notifica ' +
        '"'#39' || I040.NOTIFICA || '#39'" '#232' stata rimossa oppure '#232' invalida!'#39','
      
        '              dbms_lob.substr(dbms_metadata.get_ddl(t.object_typ' +
        'e,t.object_name),2000,1)) NOTIFICA_SQL_TEXT,'
      '       I040.ATTIVO,'
      '       I040.VALIDO_DAL,'
      '       I040.VALIDO_AL,'
      '       I040.ROWID'
      'from   I040_NOTIFICHE_IRISWEB I040,'
      '       user_objects t'
      'where  t.object_name (+) = I040.NOTIFICA'
      'and    t.object_type (+) = '#39'PROCEDURE'#39' '
      'order by I040.DESCRIZIONE')
    Optimize = False
    OracleDictionary.DefaultValues = True
    BeforePost = BeforePostNoStorico
    Left = 24
    Top = 16
    object selI040ID: TIntegerField
      DisplayWidth = 8
      FieldName = 'ID'
      Visible = False
    end
    object selI040DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 50
      FieldName = 'DESCRIZIONE'
      Size = 100
    end
    object selI040NOTIFICA: TStringField
      FieldName = 'NOTIFICA'
      Visible = False
      Size = 30
    end
    object selI040D_NOTIFICA: TStringField
      DisplayLabel = 'Notifica'
      FieldKind = fkLookup
      FieldName = 'D_NOTIFICA'
      LookupKeyFields = 'NOME'
      LookupResultField = 'NOME'
      KeyFields = 'NOTIFICA'
      Size = 30
      Lookup = True
    end
    object selI040NOTIFICA_SQL_TEXT: TStringField
      DisplayLabel = 'Testo SQL'
      FieldName = 'NOTIFICA_SQL_TEXT'
      ReadOnly = True
      Visible = False
      Size = 2000
    end
    object selI040ATTIVO: TStringField
      DisplayLabel = 'Attivo'
      FieldName = 'ATTIVO'
      Size = 1
    end
    object selI040VALIDO_DAL: TDateTimeField
      DisplayLabel = 'Inizio Validit'#224
      FieldName = 'VALIDO_DAL'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selI040VALIDO_AL: TDateTimeField
      DisplayLabel = 'Fine Validit'#224
      FieldName = 'VALIDO_AL'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
  end
end
