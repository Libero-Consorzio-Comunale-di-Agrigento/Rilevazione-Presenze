inherited A176FRiepilogoIterAutorizzativiMW: TA176FRiepilogoIterAutorizzativiMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 317
  object selVT050: TOracleDataSet
    SQL.Strings = (
      
        'select VT050.*, decode(T853F_NUMALLEGATI(VT050.T850ID),0,'#39'N'#39','#39'S'#39 +
        ') T853FILE_ALLEGATO,'
      '       decode(T265.CODICE,null,'#39'P'#39','#39'A'#39') TIPOCAUS,'
      
        '       I060F_EMAIL(I090F_GETAZIENDACORRENTE, VT050.PROGRESSIVO) ' +
        'EMAIL'
      '  from VT050_ITER_RICHIESTEASSENZA VT050, T265_CAUASSENZE T265'
      ' where 1 = 1'
      '   and VT050.T050CAUSALE = T265.CODICE(+)'
      '       :FILTRO'
      ' order by VT050.T850ID desc')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A00460049004C00540052004F00010000000000
      000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000150000001E0000005400300035003000500052004F00470052004500
      53005300490056004F0001000000000016000000540030003500300043004100
      5500530041004C0045000100000000001A000000540030003500300054004900
      50004F00470049005500530054000100000000000E0000005400300035003000
      440041004C000100000000000C000000540030003500300041004C0001000000
      00001A00000054003000350030004E0055004D00450052004F004F0052004500
      01000000000010000000540030003500300041004F0052004500010000000000
      16000000540030003500300044004100540041004E0041005300010000000000
      2400000054003000350030004E0055004D00450052004F004F00520045005F00
      50005200450056000100000000001A000000540030003500300041004F005200
      45005F0050005200450056000100000000001A00000054003000350030004500
      4C00410042004F005200410054004F0001000000000010000000540038003500
      3000490054004500520001000000000018000000540038003500300043004F00
      44005F0049005400450052000100000000000C00000054003800350030004900
      4400010000000000100000005400380035003000440041005400410001000000
      000012000000540038003500300053005400410054004F000100000000001000
      000054003800350030004E004F00540045000100000000002400000054003800
      350030005400490050004F005F00520049004300480049004500530054004100
      0100000000002E00000054003800350030004100550054004F00520049005A00
      5A005F004100550054004F004D00410054004900430041000100000000001A00
      00005400380035003000490044005F005200450056004F004300410001000000
      00001E0000005400380035003000490044005F005200450056004F0043004100
      54004F00010000000000}
    Filtered = True
    OnFilterRecord = selVT050FilterRecord
    Left = 40
    Top = 16
    object selVT050T850ITER: TStringField
      FieldName = 'T850ITER'
      Required = True
      Visible = False
      Size = 10
    end
    object selVT050PROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selVT050T850COD_ITER: TStringField
      DisplayLabel = 'Struttura'
      DisplayWidth = 15
      FieldName = 'T850COD_ITER'
    end
    object selVT050T850ID: TFloatField
      DisplayLabel = 'ID'
      FieldName = 'T850ID'
      Required = True
    end
    object selVT050T850DATA: TDateTimeField
      DisplayLabel = 'Data richiesta'
      FieldName = 'T850DATA'
    end
    object selVT050T850RICHIEDENTE: TStringField
      DisplayLabel = 'Richiedente'
      DisplayWidth = 20
      FieldName = 'T850RICHIEDENTE'
      Size = 30
    end
    object selVT050EMAIL: TStringField
      DisplayLabel = 'e-mail'
      DisplayWidth = 20
      FieldName = 'EMAIL'
      Size = 200
    end
    object selVT050T850STATO: TStringField
      DisplayLabel = 'Autorizzato'
      FieldName = 'T850STATO'
      Size = 1
    end
    object selVT050T850AUTORIZZ_AUTOMATICA: TStringField
      DisplayLabel = 'Autorizz. autom.'
      FieldName = 'T850AUTORIZZ_AUTOMATICA'
      Size = 1
    end
    object selVT050T850TIPO_RICHIESTA: TStringField
      DisplayLabel = 'Tipo rich.'
      FieldName = 'T850TIPO_RICHIESTA'
      Size = 1
    end
    object selVT050T850ID_REVOCA: TFloatField
      DisplayLabel = 'ID revoca'
      FieldName = 'T850ID_REVOCA'
    end
    object selVT050T850ID_REVOCATO: TFloatField
      DisplayLabel = 'ID revocato'
      FieldName = 'T850ID_REVOCATO'
    end
    object selVT050T850NOTE: TStringField
      DisplayLabel = 'Note'
      DisplayWidth = 20
      FieldName = 'T850NOTE'
      Size = 2000
    end
    object selVT050T850CONDIZ_ALLEGATI: TStringField
      DisplayLabel = 'Condiz. allegati'
      FieldName = 'T850CONDIZ_ALLEGATI'
      Size = 1
    end
    object selVT050T050CAUSALE: TStringField
      DisplayLabel = 'Causale'
      FieldName = 'T050CAUSALE'
      Size = 5
    end
    object selVT050T050TIPOGIUST: TStringField
      DisplayLabel = 'Tipo giustificativo'
      FieldName = 'T050TIPOGIUST'
      Size = 1
    end
    object selVT050T050DAL: TDateTimeField
      DisplayLabel = 'Dal'
      DisplayWidth = 10
      FieldName = 'T050DAL'
    end
    object selVT050T050AL: TDateTimeField
      DisplayLabel = 'Al'
      DisplayWidth = 10
      FieldName = 'T050AL'
    end
    object selVT050T050NUMEROORE: TStringField
      DisplayLabel = 'Dalle'
      FieldName = 'T050NUMEROORE'
      Size = 5
    end
    object selVT050T050AORE: TStringField
      DisplayLabel = 'Alle'
      FieldName = 'T050AORE'
      Size = 5
    end
    object selVT050T050DATANAS: TDateTimeField
      DisplayLabel = 'Data nascita'
      FieldName = 'T050DATANAS'
    end
    object selVT050T050NUMEROORE_PREV: TStringField
      DisplayLabel = 'Dalle (prev.)'
      FieldName = 'T050NUMEROORE_PREV'
      Size = 5
    end
    object selVT050T050AORE_PREV: TStringField
      DisplayLabel = 'Alle (prev.)'
      FieldName = 'T050AORE_PREV'
      Size = 5
    end
    object selVT050T050ELABORATO: TStringField
      DisplayLabel = 'Elaborato'
      FieldName = 'T050ELABORATO'
      Size = 1
    end
    object selVT050T853FILE_ALLEGATO: TStringField
      DisplayLabel = 'Allegato'
      FieldName = 'T853FILE_ALLEGATO'
      Size = 1
    end
    object selVT050TIPOCAUS: TStringField
      FieldName = 'TIPOCAUS'
      Visible = False
      Size = 1
    end
  end
  object selVT105: TOracleDataSet
    SQL.Strings = (
      
        'select VT105.*, decode(T853F_NUMALLEGATI(VT105.T850ID),0,'#39'N'#39','#39'S'#39 +
        ') T853FILE_ALLEGATO, I060F_EMAIL(I090F_GETAZIENDACORRENTE, VT105' +
        '.PROGRESSIVO) EMAIL'
      '  from VT105_ITER_RICHIESTETIMBRATURE VT105'
      ' where 1 = 1'
      '       :FILTRO'
      ' order by VT105.T850ID desc')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A00460049004C00540052004F00010000000000
      000000000000}
    QBEDefinition.QBEFieldDefs = {
      0500000016000000100000005400380035003000440041005400410001000000
      00001E0000005400310030003500500052004F00470052004500530053004900
      56004F0001000000000010000000540031003000350044004100540041000100
      000000000E00000054003100300035004F005200410001000000000012000000
      540031003000350056004500520053004F000100000000001600000054003100
      30003500430041005500530041004C0045000100000000002600000054003100
      30003500520049004C0045005600410054004F00520045005F00520049004300
      48000100000000001C00000054003100300035004F0050004500520041005A00
      49004F004E004500010000000000200000005400310030003500430041005500
      530041004C0045005F004F005200490047000100000000001C00000054003100
      3000350056004500520053004F005F004F005200490047000100000000002600
      00005400310030003500520049004C0045005600410054004F00520045005F00
      4F005200490047000100000000001E00000054003100300035004D004F005400
      4900560041005A0049004F004E0045000100000000001A000000540031003000
      350045004C00410042004F005200410054004F00010000000000100000005400
      3800350030004900540045005200010000000000180000005400380035003000
      43004F0044005F0049005400450052000100000000000C000000540038003500
      3000490044000100000000001200000054003800350030005300540041005400
      4F000100000000001000000054003800350030004E004F005400450001000000
      00002400000054003800350030005400490050004F005F005200490043004800
      490045005300540041000100000000002E000000540038003500300041005500
      54004F00520049005A005A005F004100550054004F004D004100540049004300
      41000100000000001A0000005400380035003000490044005F00520045005600
      4F00430041000100000000001E0000005400380035003000490044005F005200
      450056004F004300410054004F00010000000000}
    Left = 96
    Top = 16
    object selVT105T850ITER: TStringField
      FieldName = 'T850ITER'
      Required = True
      Visible = False
      Size = 10
    end
    object selVT105PROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selVT105T850COD_ITER: TStringField
      DisplayLabel = 'Struttura'
      DisplayWidth = 15
      FieldName = 'T850COD_ITER'
    end
    object selVT105T850ID: TFloatField
      DisplayLabel = 'ID'
      FieldName = 'T850ID'
      Required = True
    end
    object selVT105T850DATA: TDateTimeField
      DisplayLabel = 'Data richiesta'
      FieldName = 'T850DATA'
    end
    object selVT105T850RICHIEDENTE: TStringField
      DisplayLabel = 'Richiedente'
      DisplayWidth = 20
      FieldName = 'T850RICHIEDENTE'
      Size = 30
    end
    object selVT105EMAIL: TStringField
      DisplayLabel = 'e-mail'
      DisplayWidth = 20
      FieldName = 'EMAIL'
      Size = 200
    end
    object selVT105T850STATO: TStringField
      DisplayLabel = 'Autorizzato'
      FieldName = 'T850STATO'
      Size = 1
    end
    object selVT105T850AUTORIZZ_AUTOMATICA: TStringField
      DisplayLabel = 'Autorizz. autom.'
      FieldName = 'T850AUTORIZZ_AUTOMATICA'
      Size = 1
    end
    object selVT105T850TIPO_RICHIESTA: TStringField
      DisplayLabel = 'Tipo rich.'
      FieldName = 'T850TIPO_RICHIESTA'
      Size = 1
    end
    object selVT105T850ID_REVOCA: TFloatField
      FieldName = 'T850ID_REVOCA'
      Visible = False
    end
    object selVT105T850ID_REVOCATO: TFloatField
      FieldName = 'T850ID_REVOCATO'
      Visible = False
    end
    object selVT105T850NOTE: TStringField
      DisplayLabel = 'Note'
      DisplayWidth = 20
      FieldName = 'T850NOTE'
      Size = 2000
    end
    object selVT105T850CONDIZ_ALLEGATI: TStringField
      DisplayLabel = 'Condiz. allegati'
      FieldName = 'T850CONDIZ_ALLEGATI'
      Size = 1
    end
    object selVT105T105DATA: TDateTimeField
      DisplayLabel = 'Data timb.'
      DisplayWidth = 10
      FieldName = 'T105DATA'
    end
    object selVT105T105ORA: TStringField
      DisplayLabel = 'Ora'
      FieldName = 'T105ORA'
      Size = 5
    end
    object selVT105T105VERSO: TStringField
      DisplayLabel = 'Verso'
      FieldName = 'T105VERSO'
      Size = 1
    end
    object selVT105T105CAUSALE: TStringField
      DisplayLabel = 'Causale'
      FieldName = 'T105CAUSALE'
      Size = 5
    end
    object selVT105T105RILEVATORE_RICH: TStringField
      DisplayLabel = 'Rilevatore'
      FieldName = 'T105RILEVATORE_RICH'
      Size = 2
    end
    object selVT105T105OPERAZIONE: TStringField
      DisplayLabel = 'Operazione'
      FieldName = 'T105OPERAZIONE'
      Size = 1
    end
    object selVT105T105CAUSALE_ORIG: TStringField
      DisplayLabel = 'Cusale orig.'
      FieldName = 'T105CAUSALE_ORIG'
      Size = 5
    end
    object selVT105T105VERSO_ORIG: TStringField
      DisplayLabel = 'Verso orig.'
      FieldName = 'T105VERSO_ORIG'
      Size = 1
    end
    object selVT105T105RILEVATORE_ORIG: TStringField
      DisplayLabel = 'Rilevatore orig.'
      FieldName = 'T105RILEVATORE_ORIG'
      Size = 2
    end
    object selVT105T105MOTIVAZIONE: TStringField
      DisplayLabel = 'Motivazione'
      FieldName = 'T105MOTIVAZIONE'
      Size = 5
    end
    object selVT105T105ELABORATO: TStringField
      DisplayLabel = 'Elaborato'
      FieldName = 'T105ELABORATO'
      Size = 1
    end
    object selVT105T853FILE_ALLEGATO: TStringField
      DisplayLabel = 'Allegato'
      FieldName = 'T853FILE_ALLEGATO'
      Size = 1
    end
  end
  object selVM140: TOracleDataSet
    SQL.Strings = (
      
        'select VM140.*, decode(T853F_NUMALLEGATI(VM140.T850ID),0,'#39'N'#39','#39'S'#39 +
        ') T853FILE_ALLEGATO, I060F_EMAIL(I090F_GETAZIENDACORRENTE, VM140' +
        '.PROGRESSIVO) EMAIL'
      '  from VM140_ITER_RICHIESTE_MISSIONI VM140'
      ' where 1 = 1'
      '       :FILTRO'
      ' order by VM140.T850ID desc')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A00460049004C00540052004F00010000000000
      000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000190000001E0000004D00310034003000500052004F00470052004500
      53005300490056004F000100000000002A0000004D0031003400300046004C00
      410047005F00440045005300540049004E0041005A0049004F004E0045000100
      00000000240000004D0031003400300046004C00410047005F00490053005000
      450054005400490056004100010000000000140000004D003100340030004400
      41005400410044004100010000000000120000004D0031003400300044004100
      540041004100010000000000120000004D003100340030004F00520041004400
      4100010000000000100000004D003100340030004F0052004100410001000000
      00001C0000004D00310034003000500052004F0054004F0043004F004C004C00
      4F000100000000002C0000004D0031003400300046004C00410047005F005400
      490050004F00410043004300520045004400490054004F000100000000001800
      00004D00310034003000440045004C0045004700410054004F00010000000000
      2A0000004D003100340030005400490050004F00520045004700490053005400
      520041005A0049004F004E004500010000000000200000004D00310034003000
      41004E004E0055004C004C0041004D0045004E0054004F000100000000002200
      00004D0031003400300046004C00410047005F0050004500520043004F005200
      53004F000100000000002A0000004D003100340030004D004900530053004900
      4F004E0045005F00520049004100500045005200540041000100000000002C00
      00004D00310034003000430041005000490054004F004C004F005F0054005200
      4100530046004500520054004100010000000000100000005400380035003000
      490054004500520001000000000018000000540038003500300043004F004400
      5F0049005400450052000100000000000C000000540038003500300049004400
      0100000000001000000054003800350030004400410054004100010000000000
      12000000540038003500300053005400410054004F0001000000000010000000
      54003800350030004E004F005400450001000000000024000000540038003500
      30005400490050004F005F005200490043004800490045005300540041000100
      000000002E00000054003800350030004100550054004F00520049005A005A00
      5F004100550054004F004D00410054004900430041000100000000001A000000
      5400380035003000490044005F005200450056004F0043004100010000000000
      1E0000005400380035003000490044005F005200450056004F00430041005400
      4F00010000000000}
    Left = 160
    Top = 16
    object selVM140T850ITER: TStringField
      FieldName = 'T850ITER'
      Required = True
      Visible = False
      Size = 10
    end
    object selVM140PROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selVM140T850COD_ITER: TStringField
      DisplayLabel = 'Struttura'
      DisplayWidth = 15
      FieldName = 'T850COD_ITER'
    end
    object selVM140T850ID: TFloatField
      DisplayLabel = 'ID'
      FieldName = 'T850ID'
      Required = True
    end
    object selVM140T850DATA: TDateTimeField
      DisplayLabel = 'Data richiesta'
      FieldName = 'T850DATA'
    end
    object selVM140T850RICHIEDENTE: TStringField
      DisplayLabel = 'Richiedente'
      DisplayWidth = 20
      FieldName = 'T850RICHIEDENTE'
      Size = 30
    end
    object selVM140EMAIL: TStringField
      DisplayLabel = 'e-mail'
      DisplayWidth = 20
      FieldName = 'EMAIL'
      Size = 200
    end
    object selVM140T850STATO: TStringField
      DisplayLabel = 'Autorizzato'
      FieldName = 'T850STATO'
      Size = 1
    end
    object selVM140T850AUTORIZZ_AUTOMATICA: TStringField
      DisplayLabel = 'Autoriz. autom.'
      FieldName = 'T850AUTORIZZ_AUTOMATICA'
      Size = 1
    end
    object selVM140T850TIPO_RICHIESTA: TStringField
      DisplayLabel = 'Tipo rich.'
      FieldName = 'T850TIPO_RICHIESTA'
      Size = 1
    end
    object selVM140T850ID_REVOCA: TFloatField
      FieldName = 'T850ID_REVOCA'
      Visible = False
    end
    object selVM140T850ID_REVOCATO: TFloatField
      FieldName = 'T850ID_REVOCATO'
      Visible = False
    end
    object selVM140T850NOTE: TStringField
      DisplayLabel = 'Note'
      DisplayWidth = 20
      FieldName = 'T850NOTE'
      Size = 2000
    end
    object selVM140T850CONDIZ_ALLEGATI: TStringField
      DisplayLabel = 'Condiz. allegati'
      FieldName = 'T850CONDIZ_ALLEGATI'
      Size = 1
    end
    object selVM140M140FLAG_DESTINAZIONE: TStringField
      DisplayLabel = 'Destinazione'
      FieldName = 'M140FLAG_DESTINAZIONE'
      Required = True
      Size = 1
    end
    object selVM140M140FLAG_ISPETTIVA: TStringField
      DisplayLabel = 'Ispettiva'
      FieldName = 'M140FLAG_ISPETTIVA'
      Required = True
      Size = 1
    end
    object selVM140M140DATADA: TDateTimeField
      DisplayLabel = 'Dal'
      DisplayWidth = 10
      FieldName = 'M140DATADA'
    end
    object selVM140M140DATAA: TDateTimeField
      DisplayLabel = 'Al'
      DisplayWidth = 10
      FieldName = 'M140DATAA'
    end
    object selVM140M140ORADA: TStringField
      DisplayLabel = 'Dalle'
      FieldName = 'M140ORADA'
      Size = 5
    end
    object selVM140M140ORAA: TStringField
      DisplayLabel = 'Alle'
      FieldName = 'M140ORAA'
      Size = 5
    end
    object selVM140M140PROTOCOLLO: TStringField
      DisplayLabel = 'Protocollo'
      FieldName = 'M140PROTOCOLLO'
      Size = 10
    end
    object selVM140M140FLAG_TIPOACCREDITO: TStringField
      DisplayLabel = 'Tipo accredito'
      FieldName = 'M140FLAG_TIPOACCREDITO'
      Size = 1
    end
    object selVM140M140DELEGATO: TStringField
      DisplayLabel = 'Delegato'
      DisplayWidth = 10
      FieldName = 'M140DELEGATO'
      Size = 100
    end
    object selVM140M140TIPOREGISTRAZIONE: TStringField
      DisplayLabel = 'Tipo registrazione'
      FieldName = 'M140TIPOREGISTRAZIONE'
      Size = 5
    end
    object selVM140M140ANNULLAMENTO: TStringField
      DisplayLabel = 'Annullamento'
      DisplayWidth = 10
      FieldName = 'M140ANNULLAMENTO'
      Size = 100
    end
    object selVM140M140FLAG_PERCORSO: TStringField
      DisplayLabel = 'Percorso'
      FieldName = 'M140FLAG_PERCORSO'
      Size = 10
    end
    object selVM140M140MISSIONE_RIAPERTA: TStringField
      DisplayLabel = 'Riaperta'
      FieldName = 'M140MISSIONE_RIAPERTA'
      Size = 1
    end
    object selVM140M140CAPITOLO_TRASFERTA: TStringField
      DisplayLabel = 'Capitolo'
      DisplayWidth = 10
      FieldName = 'M140CAPITOLO_TRASFERTA'
    end
    object selVM140T853FILE_ALLEGATO: TStringField
      DisplayLabel = 'Allegato'
      FieldName = 'T853FILE_ALLEGATO'
      Size = 1
    end
  end
  object selVT065: TOracleDataSet
    SQL.Strings = (
      
        'select VT065.*, decode(T853F_NUMALLEGATI(VT065.T850ID),0,'#39'N'#39','#39'S'#39 +
        ') T853FILE_ALLEGATO, I060F_EMAIL(I090F_GETAZIENDACORRENTE, VT065' +
        '.PROGRESSIVO) EMAIL'
      '  from VT065_ITER_RICHIESTESTRAORD VT065'
      ' where 1 = 1'
      '       :FILTRO'
      ' order by VT065.T850ID desc')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A00460049004C00540052004F00010000000000
      000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000160000001E0000005400300036003500500052004F00470052004500
      53005300490056004F0001000000000010000000540030003600350044004100
      540041000100000000001000000054003000360035005400490050004F000100
      00000000220000005400300036003500490044005F0043004F004E0047005500
      410047004C0049004F000100000000002400000054003000360035004F005200
      45005F00450043004300450044005F00430041004C0043000100000000002200
      000054003000360035004F00520045005F004500430043004500440045004E00
      540049000100000000002800000054003000360035004F00520045005F004400
      410043004F004D00500045004E00530041005200450001000000000026000000
      54003000360035004F00520045005F00440041004C0049005100550049004400
      4100520045000100000000001600000054003000360035004300410055005300
      41004C0045000100000000002800000054003000360035004F00520045005F00
      430041005500530041004C0049005A005A004100540045000100000000002E00
      000054003000360035004D0049004E005F004F00520045005F00440041004C00
      4900510055004900440041005200450001000000000030000000540030003600
      35004D0049004E005F004F00520045005F004400410043004F004D0050004500
      4E00530041005200450001000000000010000000540038003500300049005400
      4500520001000000000018000000540038003500300043004F0044005F004900
      5400450052000100000000000C00000054003800350030004900440001000000
      0000100000005400380035003000440041005400410001000000000012000000
      540038003500300053005400410054004F000100000000001000000054003800
      350030004E004F00540045000100000000002400000054003800350030005400
      490050004F005F00520049004300480049004500530054004100010000000000
      2E00000054003800350030004100550054004F00520049005A005A005F004100
      550054004F004D00410054004900430041000100000000001A00000054003800
      35003000490044005F005200450056004F00430041000100000000001E000000
      5400380035003000490044005F005200450056004F004300410054004F000100
      00000000}
    Left = 40
    Top = 72
    object selVT065T850ITER: TStringField
      FieldName = 'T850ITER'
      Required = True
      Visible = False
      Size = 10
    end
    object selVT065PROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selVT065T850COD_ITER: TStringField
      DisplayLabel = 'Struttura'
      DisplayWidth = 15
      FieldName = 'T850COD_ITER'
    end
    object selVT065T850ID: TFloatField
      DisplayLabel = 'ID'
      FieldName = 'T850ID'
      Required = True
    end
    object selVT065T850DATA: TDateTimeField
      DisplayLabel = 'Data richiesta'
      FieldName = 'T850DATA'
    end
    object selVT065T850RICHIEDENTE: TStringField
      DisplayLabel = 'Richiedente'
      DisplayWidth = 20
      FieldName = 'T850RICHIEDENTE'
      Size = 30
    end
    object selVT065EMAIL: TStringField
      DisplayLabel = 'e-mail'
      DisplayWidth = 20
      FieldName = 'EMAIL'
      Size = 200
    end
    object selVT065T850STATO: TStringField
      DisplayLabel = 'Autorizzato'
      FieldName = 'T850STATO'
      Size = 1
    end
    object selVT065T850AUTORIZZ_AUTOMATICA: TStringField
      DisplayLabel = 'Autoriz. autom.'
      FieldName = 'T850AUTORIZZ_AUTOMATICA'
      Size = 1
    end
    object selVT065T850TIPO_RICHIESTA: TStringField
      DisplayLabel = 'Tipo rich.'
      FieldName = 'T850TIPO_RICHIESTA'
      Size = 1
    end
    object selVT065T850ID_REVOCA: TFloatField
      FieldName = 'T850ID_REVOCA'
      Visible = False
    end
    object selVT065T850ID_REVOCATO: TFloatField
      FieldName = 'T850ID_REVOCATO'
      Visible = False
    end
    object selVT065T850NOTE: TStringField
      DisplayLabel = 'Note'
      DisplayWidth = 20
      FieldName = 'T850NOTE'
      Size = 2000
    end
    object selVT065T850CONDIZ_ALLEGATI: TStringField
      DisplayLabel = 'Condiz. allegati'
      FieldName = 'T850CONDIZ_ALLEGATI'
      Size = 1
    end
    object selVT065T065DATA: TDateTimeField
      DisplayLabel = 'Data straord.'
      DisplayWidth = 10
      FieldName = 'T065DATA'
    end
    object selVT065T065TIPO: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'T065TIPO'
      Size = 1
    end
    object selVT065T065ID_CONGUAGLIO: TIntegerField
      DisplayLabel = 'ID conguaglio'
      FieldName = 'T065ID_CONGUAGLIO'
    end
    object selVT065T065ORE_ECCED_CALC: TStringField
      DisplayLabel = 'Ore ecced. calc.'
      FieldName = 'T065ORE_ECCED_CALC'
      Size = 6
    end
    object selVT065T065ORE_ECCEDENTI: TStringField
      DisplayLabel = 'Ore eccedenti'
      FieldName = 'T065ORE_ECCEDENTI'
      Size = 6
    end
    object selVT065T065ORE_DACOMPENSARE: TStringField
      DisplayLabel = 'Ore da compensare'
      FieldName = 'T065ORE_DACOMPENSARE'
      Size = 6
    end
    object selVT065T065ORE_DALIQUIDARE: TStringField
      DisplayLabel = 'Ore da liquidare'
      FieldName = 'T065ORE_DALIQUIDARE'
      Size = 6
    end
    object selVT065T065CAUSALE: TStringField
      DisplayLabel = 'Causale'
      FieldName = 'T065CAUSALE'
      Size = 5
    end
    object selVT065T065ORE_CAUSALIZZATE: TStringField
      DisplayLabel = 'Ore causalizzate'
      FieldName = 'T065ORE_CAUSALIZZATE'
      Size = 6
    end
    object selVT065T065MIN_ORE_DALIQUIDARE: TStringField
      DisplayLabel = 'Min. ore da liquidare'
      FieldName = 'T065MIN_ORE_DALIQUIDARE'
      Size = 6
    end
    object selVT065T065MIN_ORE_DACOMPENSARE: TStringField
      DisplayLabel = 'Min. ore da compensare'
      FieldName = 'T065MIN_ORE_DACOMPENSARE'
      Size = 6
    end
    object selVT065T853FILE_ALLEGATO: TStringField
      DisplayLabel = 'Allegato'
      FieldName = 'T853FILE_ALLEGATO'
      Size = 1
    end
  end
  object selVT860: TOracleDataSet
    SQL.Strings = (
      
        'select VT860.*, decode(T853F_NUMALLEGATI(VT860.T850ID),0,'#39'N'#39','#39'S'#39 +
        ') T853FILE_ALLEGATO, I060F_EMAIL(I090F_GETAZIENDACORRENTE, VT860' +
        '.PROGRESSIVO) EMAIL'
      '  from VT860_ITER_STAMPACARTELLINI VT860'
      ' where 1 = 1'
      '       :FILTRO'
      ' order by VT860.T850ID desc')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A00460049004C00540052004F00010000000000
      000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000D0000001E0000005400380036003000500052004F00470052004500
      53005300490056004F000100000000002600000054003800360030004D004500
      530045005F00430041005200540045004C004C0049004E004F00010000000000
      1000000054003800350030004900540045005200010000000000180000005400
      38003500300043004F0044005F0049005400450052000100000000000C000000
      5400380035003000490044000100000000001000000054003800350030004400
      4100540041000100000000001E00000054003800350030005200490043004800
      49004500440045004E0054004500010000000000120000005400380035003000
      53005400410054004F000100000000001000000054003800350030004E004F00
      540045000100000000002400000054003800350030005400490050004F005F00
      5200490043004800490045005300540041000100000000002E00000054003800
      350030004100550054004F00520049005A005A005F004100550054004F004D00
      410054004900430041000100000000001A000000540038003500300049004400
      5F005200450056004F00430041000100000000001E0000005400380035003000
      490044005F005200450056004F004300410054004F00010000000000}
    Left = 160
    Top = 72
    object selVT860T850ITER: TStringField
      FieldName = 'T850ITER'
      Required = True
      Visible = False
      Size = 10
    end
    object selVT860PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selVT860T850COD_ITER: TStringField
      DisplayLabel = 'Struttura'
      DisplayWidth = 15
      FieldName = 'T850COD_ITER'
    end
    object selVT860T850ID: TFloatField
      DisplayLabel = 'ID'
      FieldName = 'T850ID'
      Required = True
    end
    object selVT860T850DATA: TDateTimeField
      DisplayLabel = 'Data richiesta'
      FieldName = 'T850DATA'
    end
    object selVT860T850RICHIEDENTE: TStringField
      DisplayLabel = 'Richiedente'
      DisplayWidth = 20
      FieldName = 'T850RICHIEDENTE'
      Size = 30
    end
    object selVT860EMAIL: TStringField
      DisplayLabel = 'e-mail'
      DisplayWidth = 20
      FieldName = 'EMAIL'
      Size = 200
    end
    object selVT860T850STATO: TStringField
      DisplayLabel = 'Autorizzato'
      FieldName = 'T850STATO'
      Size = 1
    end
    object selVT860T850AUTORIZZ_AUTOMATICA: TStringField
      DisplayLabel = 'Autoriz. autom.'
      FieldName = 'T850AUTORIZZ_AUTOMATICA'
      Size = 1
    end
    object selVT860T850TIPO_RICHIESTA: TStringField
      DisplayLabel = 'Tipo rich.'
      FieldName = 'T850TIPO_RICHIESTA'
      Size = 1
    end
    object selVT860T850ID_REVOCA: TFloatField
      FieldName = 'T850ID_REVOCA'
      Visible = False
    end
    object selVT860T850ID_REVOCATO: TFloatField
      FieldName = 'T850ID_REVOCATO'
      Visible = False
    end
    object selVT860T850NOTE: TStringField
      DisplayLabel = 'Note'
      DisplayWidth = 20
      FieldName = 'T850NOTE'
      Size = 2000
    end
    object selVT860T850CONDIZ_ALLEGATI: TStringField
      DisplayLabel = 'Condiz. allegati'
      FieldName = 'T850CONDIZ_ALLEGATI'
      Size = 1
    end
    object selVT860T860MESE_CARTELLINO: TDateTimeField
      DisplayLabel = 'Mese cartellino'
      DisplayWidth = 10
      FieldName = 'T860MESE_CARTELLINO'
      Required = True
    end
    object selVT860T853FILE_ALLEGATO: TStringField
      DisplayLabel = 'Allegato'
      FieldName = 'T853FILE_ALLEGATO'
      Size = 1
    end
  end
  object selVT085: TOracleDataSet
    SQL.Strings = (
      
        'select VT085.*, decode(T853F_NUMALLEGATI(VT085.T850ID),0,'#39'N'#39','#39'S'#39 +
        ') T853FILE_ALLEGATO, I060F_EMAIL(I090F_GETAZIENDACORRENTE, VT085' +
        '.PROGRESSIVO) EMAIL'
      '  from VT085_ITER_RICHIESTECAMBIORARI VT085'
      ' where 1 = 1'
      '       :FILTRO'
      ' order by VT085.T850ID desc')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A00460049004C00540052004F00010000000000
      000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000120000001E0000005400300038003500500052004F00470052004500
      53005300490056004F000100000000001E000000540030003800350044004100
      540041005F004F0052004100520049004F000100000000001C00000054003000
      380035005400490050004F00470049004F0052004E004F000100000000001400
      00005400300038003500470049004F0052004E004F000100000000001C000000
      540030003800350044004100540041005F0049004E0056004500520001000000
      00002800000054003000380035005400490050004F00470049004F0052004E00
      4F005F0049004E00560045005200010000000000200000005400300038003500
      4F0052004100520049004F005F0049004E005600450052000100000000001A00
      0000540030003800350053004F004C004F005F004E004F005400450001000000
      0000100000005400380035003000490054004500520001000000000018000000
      540038003500300043004F0044005F0049005400450052000100000000000C00
      0000540038003500300049004400010000000000100000005400380035003000
      4400410054004100010000000000120000005400380035003000530054004100
      54004F000100000000001000000054003800350030004E004F00540045000100
      000000002400000054003800350030005400490050004F005F00520049004300
      4800490045005300540041000100000000002E00000054003800350030004100
      550054004F00520049005A005A005F004100550054004F004D00410054004900
      430041000100000000001A0000005400380035003000490044005F0052004500
      56004F00430041000100000000001E0000005400380035003000490044005F00
      5200450056004F004300410054004F00010000000000}
    Left = 96
    Top = 72
    object selVT085T850ITER: TStringField
      FieldName = 'T850ITER'
      Required = True
      Visible = False
      Size = 10
    end
    object selVT085PROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selVT085T850COD_ITER: TStringField
      DisplayLabel = 'Struttura'
      DisplayWidth = 15
      FieldName = 'T850COD_ITER'
    end
    object selVT085T850ID: TFloatField
      DisplayLabel = 'ID'
      FieldName = 'T850ID'
      Required = True
    end
    object selVT085T850DATA: TDateTimeField
      DisplayLabel = 'Data richiesta'
      FieldName = 'T850DATA'
    end
    object selVT085T850RICHIEDENTE: TStringField
      DisplayLabel = 'Richiedente'
      DisplayWidth = 20
      FieldName = 'T850RICHIEDENTE'
      Size = 30
    end
    object selVT085EMAIL: TStringField
      DisplayLabel = 'e-mail'
      DisplayWidth = 20
      FieldName = 'EMAIL'
      Size = 200
    end
    object selVT085T850STATO: TStringField
      DisplayLabel = 'Autorizzato'
      FieldName = 'T850STATO'
      Size = 1
    end
    object selVT085T850AUTORIZZ_AUTOMATICA: TStringField
      DisplayLabel = 'Autoriz. autom.'
      FieldName = 'T850AUTORIZZ_AUTOMATICA'
      Size = 1
    end
    object selVT085T850TIPO_RICHIESTA: TStringField
      DisplayLabel = 'Tipo rich.'
      FieldName = 'T850TIPO_RICHIESTA'
      Size = 1
    end
    object selVT085T850ID_REVOCATO: TFloatField
      FieldName = 'T850ID_REVOCATO'
      Visible = False
    end
    object selVT085T850ID_REVOCA: TFloatField
      FieldName = 'T850ID_REVOCA'
      Visible = False
    end
    object selVT085T850NOTE: TStringField
      DisplayLabel = 'Note'
      DisplayWidth = 20
      FieldName = 'T850NOTE'
      Size = 2000
    end
    object selVT085T850CONDIZ_ALLEGATI: TStringField
      DisplayLabel = 'Condiz. allegati'
      FieldName = 'T850CONDIZ_ALLEGATI'
      Size = 1
    end
    object selVT085T085DATA_ORARIO: TDateTimeField
      DisplayLabel = 'Data orario'
      DisplayWidth = 10
      FieldName = 'T085DATA_ORARIO'
    end
    object selVT085T085TIPOGIORNO: TStringField
      DisplayLabel = 'Tipo giorno'
      FieldName = 'T085TIPOGIORNO'
      Size = 1
    end
    object selVT085T085GIORNO: TStringField
      DisplayLabel = 'Giorno'
      FieldName = 'T085GIORNO'
      Size = 5
    end
    object selVT085T085DATA_INVER: TDateTimeField
      DisplayLabel = 'Data inver.'
      DisplayWidth = 10
      FieldName = 'T085DATA_INVER'
    end
    object selVT085T085TIPOGIORNO_INVER: TStringField
      DisplayLabel = 'Giorno inver.'
      FieldName = 'T085TIPOGIORNO_INVER'
      Size = 1
    end
    object selVT085T085ORARIO_INVER: TStringField
      DisplayLabel = 'Orario inver.'
      FieldName = 'T085ORARIO_INVER'
      Size = 5
    end
    object selVT085T085SOLO_NOTE: TStringField
      DisplayLabel = 'Solo note'
      FieldName = 'T085SOLO_NOTE'
      Size = 1
    end
    object selVT085T853FILE_ALLEGATO: TStringField
      DisplayLabel = 'Allegato'
      FieldName = 'T853FILE_ALLEGATO'
      Size = 1
    end
  end
  object selVT251: TOracleDataSet
    SQL.Strings = (
      
        'select VT251.*, decode(T853F_NUMALLEGATI(VT251.T850ID),0,'#39'N'#39','#39'S'#39 +
        ') T853FILE_ALLEGATO, I060F_EMAIL(I090F_GETAZIENDACORRENTE, VT251' +
        '.PROGRESSIVO) EMAIL'
      '  from VT251_ITER_RICHIESTESCIOPERI VT251'
      ' where 1 = 1'
      '       :FILTRO'
      ' order by VT251.T850ID desc')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A00460049004C00540052004F00010000000000
      000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000160000000E0000005600540032003500310049004400010000000000
      2000000056005400320035003100500052004F00470052004500530053004900
      56004F0001000000000024000000560054003200350031004400410054004100
      5F005300430049004F005000450052004F000100000000001800000056005400
      320035003100490044005F005400320035003000010000000000180000005600
      5400320035003100430041005500530041004C0045000100000000001C000000
      5600540032003500310044005F00430041005500530041004C00450001000000
      00001C000000560054003200350031005400490050004F004700490055005300
      54000100000000001400000056005400320035003100440041004F0052004500
      010000000000120000005600540032003500310041004F005200450001000000
      00003200000056005400320035003100530045004C0045005A0049004F004E00
      45005F0041004E00410047005200410046004900430041000100000000001600
      0000560054003200350031004D0049004E0049004D004F000100000000000C00
      0000540038003500300049004400010000000000100000005400380035003000
      44004100540041000100000000001E0000005400380035003000520049004300
      480049004500440045004E005400450001000000000010000000540038003500
      30004E004F005400450001000000000012000000540038003500300053005400
      410054004F000100000000002400000054003800350030005400490050004F00
      5F005200490043004800490045005300540041000100000000002E0000005400
      3800350030004100550054004F00520049005A005A005F004100550054004F00
      4D00410054004900430041000100000000001A00000054003800350030004900
      44005F005200450056004F00430041000100000000001E000000540038003500
      3000490044005F005200450056004F004300410054004F000100000000001000
      0000540038003500300049005400450052000100000000001800000054003800
      3500300043004F0044005F004900540045005200010000000000}
    Left = 40
    Top = 120
    object selVT251T850ITER: TStringField
      FieldName = 'T850ITER'
      Required = True
      Visible = False
      Size = 10
    end
    object selVT251PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selVT251T850COD_ITER: TStringField
      DisplayLabel = 'Struttura'
      DisplayWidth = 15
      FieldName = 'T850COD_ITER'
    end
    object selVT251T850ID: TFloatField
      DisplayLabel = 'ID'
      FieldName = 'T850ID'
      Required = True
    end
    object selVT251T850DATA: TDateTimeField
      DisplayLabel = 'Data richiesta'
      FieldName = 'T850DATA'
    end
    object selVT251T850RICHIEDENTE: TStringField
      DisplayLabel = 'Richiedente'
      DisplayWidth = 20
      FieldName = 'T850RICHIEDENTE'
      Size = 30
    end
    object selVT251EMAIL: TStringField
      DisplayLabel = 'e-mail'
      DisplayWidth = 20
      FieldName = 'EMAIL'
      Size = 200
    end
    object selVT251T850STATO: TStringField
      DisplayLabel = 'Stato'
      FieldName = 'T850STATO'
      Size = 1
    end
    object selVT251T850AUTORIZZ_AUTOMATICA: TStringField
      DisplayLabel = 'Autoriz. autom.'
      FieldName = 'T850AUTORIZZ_AUTOMATICA'
      Size = 1
    end
    object selVT251T850TIPO_RICHIESTA: TStringField
      DisplayLabel = 'Tipo rich.'
      FieldName = 'T850TIPO_RICHIESTA'
      Size = 1
    end
    object selVT251T850ID_REVOCA: TFloatField
      FieldName = 'T850ID_REVOCA'
      Visible = False
    end
    object selVT251T850ID_REVOCATO: TFloatField
      FieldName = 'T850ID_REVOCATO'
      Visible = False
    end
    object selVT251T850NOTE: TStringField
      DisplayLabel = 'Note'
      DisplayWidth = 20
      FieldName = 'T850NOTE'
      Size = 2000
    end
    object selVT251T850CONDIZ_ALLEGATI: TStringField
      DisplayLabel = 'Condiz. allegati'
      FieldName = 'T850CONDIZ_ALLEGATI'
      Size = 1
    end
    object selVT251VT251DATA_SCIOPERO: TDateTimeField
      DisplayLabel = 'Data sciopero'
      DisplayWidth = 10
      FieldName = 'VT251DATA_SCIOPERO'
      Required = True
    end
    object selVT251VT251ID_T250: TFloatField
      DisplayLabel = 'ID T250'
      DisplayWidth = 6
      FieldName = 'VT251ID_T250'
      Required = True
    end
    object selVT251VT251CAUSALE: TStringField
      DisplayLabel = 'Causale'
      FieldName = 'VT251CAUSALE'
      Size = 5
    end
    object selVT251VT251D_CAUSALE: TStringField
      DisplayLabel = 'Desc. causale'
      DisplayWidth = 20
      FieldName = 'VT251D_CAUSALE'
      Size = 40
    end
    object selVT251VT251TIPOGIUST: TStringField
      DisplayLabel = 'Tipo giust.'
      FieldName = 'VT251TIPOGIUST'
      Size = 1
    end
    object selVT251VT251DAORE: TStringField
      DisplayLabel = 'Dalle'
      FieldName = 'VT251DAORE'
      Size = 5
    end
    object selVT251VT251AORE: TStringField
      DisplayLabel = 'Alle'
      FieldName = 'VT251AORE'
      Size = 5
    end
    object selVT251VT251SELEZIONE_ANAGRAFICA: TStringField
      DisplayLabel = 'Selezione anag.'
      DisplayWidth = 20
      FieldName = 'VT251SELEZIONE_ANAGRAFICA'
      Size = 2000
    end
    object selVT251VT251MINIMO: TIntegerField
      DisplayLabel = 'Minimo'
      DisplayWidth = 5
      FieldName = 'VT251MINIMO'
    end
    object selVT251T853FILE_ALLEGATO: TStringField
      DisplayLabel = 'Allegato'
      FieldName = 'T853FILE_ALLEGATO'
      Size = 1
    end
  end
  object selVT325_EU: TOracleDataSet
    SQL.Strings = (
      
        'select VT325.*, decode(T853F_NUMALLEGATI(VT325.T850ID),0,'#39'N'#39','#39'S'#39 +
        ') T853FILE_ALLEGATO, I060F_EMAIL(I090F_GETAZIENDACORRENTE, VT325' +
        '.PROGRESSIVO) EMAIL'
      '  from VT325_ITER_RICHIESTESTR_GG_EU VT325'
      ' where 1 = 1'
      '       :FILTRO'
      ' order by VT325.T850ID desc')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A00460049004C00540052004F00010000000000
      000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000280000001800000056005400330032003500490044005F0054003300
      3200350001000000000012000000560054003300320035004400410054004100
      0100000000002000000056005400330032003500500052004F00470052004500
      53005300490056004F000100000000001E000000560054003300320035005400
      49004D0042005200410054005500520045000100000000001C00000056005400
      3300320035004F00520045005F004C004F005200440045000100000000002800
      0000560054003300320035004F00520045005F0043004F004E00540045004700
      4700490041005400450001000000000016000000560054003300320035004400
      45004200490054004F000100000000001E000000560054003300320035004400
      4500540052005F004D0045004E00530041000100000000001800000056005400
      3300320035005200490054004100520044004F00010000000000200000005600
      54003300320035004D004F0054004900560041005A0049004F004E0045000100
      0000000016000000560054003300320035005400490050004F005F0045000100
      0000000020000000560054003300320035004500430043004500440045004E00
      5A0041005F004500010000000000160000005600540033003200350053005000
      45005A005F004500010000000000240000005600540033003200350053005000
      45005A005F00440041004C004C00450031005F00450001000000000022000000
      560054003300320035005300500045005A005F0041004C004C00450031005F00
      4500010000000000180000005600540033003200350043004100550053003100
      5F00450001000000000020000000560054003300320035004300410055005300
      5F004F005200490047005F0045000100000000002A0000005600540033003200
      35004100550054004F00520049005A005A0041005A0049004F004E0045005F00
      450001000000000024000000560054003300320035004D004F00540049005600
      41005A0049004F004E0045005F00450001000000000016000000560054003300
      320035005400490050004F005F00550001000000000020000000560054003300
      320035004500430043004500440045004E005A0041005F005500010000000000
      16000000560054003300320035005300500045005A005F005500010000000000
      24000000560054003300320035005300500045005A005F00440041004C004C00
      450031005F005500010000000000220000005600540033003200350053005000
      45005A005F0041004C004C00450031005F005500010000000000180000005600
      5400330032003500430041005500530031005F00550001000000000020000000
      5600540033003200350043004100550053005F004F005200490047005F005500
      0100000000002A000000560054003300320035004100550054004F0052004900
      5A005A0041005A0049004F004E0045005F005500010000000000240000005600
      54003300320035004D004F0054004900560041005A0049004F004E0045005F00
      5500010000000000180000005600540033003200350052004F00570049004400
      5F0055000100000000000C000000540038003500300049004400010000000000
      1000000054003800350030004400410054004100010000000000100000005400
      3800350030004E004F0054004500010000000000120000005400380035003000
      53005400410054004F0001000000000024000000540038003500300054004900
      50004F005F005200490043004800490045005300540041000100000000002E00
      000054003800350030004100550054004F00520049005A005A005F0041005500
      54004F004D00410054004900430041000100000000001A000000540038003500
      3000490044005F005200450056004F00430041000100000000001E0000005400
      380035003000490044005F005200450056004F004300410054004F0001000000
      0000100000005400380035003000490054004500520001000000000018000000
      540038003500300043004F0044005F0049005400450052000100000000001E00
      00005400380035003000520049004300480049004500440045004E0054004500
      010000000000}
    Left = 96
    Top = 120
    object selVT325_EUT850ITER: TStringField
      FieldName = 'T850ITER'
      Required = True
      Visible = False
      Size = 10
    end
    object selVT325_EUPROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selVT325_EUT850COD_ITER: TStringField
      DisplayLabel = 'Struttura'
      DisplayWidth = 15
      FieldName = 'T850COD_ITER'
    end
    object selVT325_EUT850ID: TFloatField
      DisplayLabel = 'ID'
      FieldName = 'T850ID'
      Required = True
    end
    object selVT325_EUT850DATA: TDateTimeField
      DisplayLabel = 'Data richiesta'
      FieldName = 'T850DATA'
    end
    object selVT325_EUT850RICHIEDENTE: TStringField
      DisplayLabel = 'Richiedente'
      DisplayWidth = 20
      FieldName = 'T850RICHIEDENTE'
      Size = 30
    end
    object selVT325_EUEMAIL: TStringField
      DisplayLabel = 'e-mail'
      DisplayWidth = 20
      FieldName = 'EMAIL'
      Size = 200
    end
    object selVT325_EUT850STATO: TStringField
      DisplayLabel = 'Autorizzato'
      FieldName = 'T850STATO'
      Size = 1
    end
    object selVT325_EUT850AUTORIZZ_AUTOMATICA: TStringField
      DisplayLabel = 'Autoriz. autom.'
      FieldName = 'T850AUTORIZZ_AUTOMATICA'
      Size = 1
    end
    object selVT325_EUT850TIPO_RICHIESTA: TStringField
      DisplayLabel = 'Tipo rich.'
      FieldName = 'T850TIPO_RICHIESTA'
      Size = 1
    end
    object selVT325_EUT850ID_REVOCA: TFloatField
      FieldName = 'T850ID_REVOCA'
      Visible = False
    end
    object selVT325_EUT850ID_REVOCATO: TFloatField
      FieldName = 'T850ID_REVOCATO'
      Visible = False
    end
    object selVT325_EUVT325ID_T325: TFloatField
      FieldName = 'VT325ID_T325'
      Required = True
    end
    object selVT325_EUT850NOTE: TStringField
      DisplayLabel = 'Note'
      FieldName = 'T850NOTE'
    end
    object selVT325_EUT850CONDIZ_ALLEGATI: TStringField
      DisplayLabel = 'Condiz. allegati'
      FieldName = 'T850CONDIZ_ALLEGATI'
      Size = 1
    end
    object selVT325_EUVT325DATA: TDateTimeField
      DisplayLabel = 'Data ecced.'
      DisplayWidth = 10
      FieldName = 'VT325DATA'
    end
    object selVT325_EUVT325TIMBRATURE: TStringField
      DisplayLabel = 'Timbrature'
      DisplayWidth = 10
      FieldName = 'VT325TIMBRATURE'
      Size = 1000
    end
    object selVT325_EUVT325ORE_LORDE: TStringField
      DisplayLabel = 'Ore lorde'
      FieldName = 'VT325ORE_LORDE'
      Size = 6
    end
    object selVT325_EUVT325ORE_CONTEGGIATE: TStringField
      DisplayLabel = 'Ore conteggiate'
      FieldName = 'VT325ORE_CONTEGGIATE'
      Size = 6
    end
    object selVT325_EUVT325DEBITO: TStringField
      DisplayLabel = 'Debito'
      FieldName = 'VT325DEBITO'
      Size = 5
    end
    object selVT325_EUVT325DETR_MENSA: TStringField
      DisplayLabel = 'Detrazione mensa'
      FieldName = 'VT325DETR_MENSA'
      Size = 5
    end
    object selVT325_EUVT325RITARDO: TStringField
      DisplayLabel = 'Ritardo'
      FieldName = 'VT325RITARDO'
      Size = 5
    end
    object selVT325_EUVT325MOTIVAZIONE: TStringField
      DisplayLabel = 'Motivazione'
      FieldName = 'VT325MOTIVAZIONE'
      Size = 5
    end
    object selVT325_EUVT325TIPO_E: TStringField
      DisplayLabel = '(E)Tipo'
      FieldName = 'VT325TIPO_E'
      Size = 1
    end
    object selVT325_EUVT325ECCEDENZA_E: TStringField
      DisplayLabel = '(E)Eccedenza'
      FieldName = 'VT325ECCEDENZA_E'
      Size = 5
    end
    object selVT325_EUVT325SPEZ_E: TStringField
      DisplayLabel = '(E)Spezzone'
      FieldName = 'VT325SPEZ_E'
      Size = 11
    end
    object selVT325_EUVT325SPEZ_DALLE1_E: TStringField
      DisplayLabel = '(E)Dalle'
      FieldName = 'VT325SPEZ_DALLE1_E'
      Size = 5
    end
    object selVT325_EUVT325SPEZ_ALLE1_E: TStringField
      DisplayLabel = '(E)Alle'
      FieldName = 'VT325SPEZ_ALLE1_E'
      Size = 5
    end
    object selVT325_EUVT325CAUS1_E: TStringField
      DisplayLabel = '(E)Causale'
      FieldName = 'VT325CAUS1_E'
      Size = 5
    end
    object selVT325_EUVT325CAUS_ORIG_E: TStringField
      DisplayLabel = '(E)Causale orig.'
      FieldName = 'VT325CAUS_ORIG_E'
      Size = 5
    end
    object selVT325_EUVT325AUTORIZZAZIONE_E: TStringField
      DisplayLabel = '(E)Autoriz.'
      FieldName = 'VT325AUTORIZZAZIONE_E'
      Size = 1
    end
    object selVT325_EUVT325MOTIVAZIONE_E: TStringField
      DisplayLabel = '(E)Motivazione'
      FieldName = 'VT325MOTIVAZIONE_E'
      Size = 5
    end
    object selVT325_EUVT325TIPO_U: TStringField
      DisplayLabel = '(U)Tipo'
      FieldName = 'VT325TIPO_U'
      Size = 1
    end
    object selVT325_EUVT325ECCEDENZA_U: TStringField
      DisplayLabel = '(U)Eccedenza'
      FieldName = 'VT325ECCEDENZA_U'
      Size = 5
    end
    object selVT325_EUVT325SPEZ_U: TStringField
      DisplayLabel = '(U)Spezzone uscita'
      FieldName = 'VT325SPEZ_U'
      Size = 11
    end
    object selVT325_EUVT325SPEZ_DALLE1_U: TStringField
      DisplayLabel = '(U)Spezzone dalle'
      FieldName = 'VT325SPEZ_DALLE1_U'
      Size = 5
    end
    object selVT325_EUVT325SPEZ_ALLE1_U: TStringField
      DisplayLabel = '(U)Spezzone alle'
      FieldName = 'VT325SPEZ_ALLE1_U'
      Size = 5
    end
    object selVT325_EUVT325CAUS1_U: TStringField
      DisplayLabel = '(U)Causale'
      FieldName = 'VT325CAUS1_U'
      Size = 5
    end
    object selVT325_EUVT325CAUS_ORIG_U: TStringField
      DisplayLabel = '(U)Causale orig.'
      FieldName = 'VT325CAUS_ORIG_U'
      Size = 5
    end
    object selVT325_EUVT325AUTORIZZAZIONE_U: TStringField
      DisplayLabel = '(U)Autorizzazione'
      FieldName = 'VT325AUTORIZZAZIONE_U'
      Size = 1
    end
    object selVT325_EUVT325MOTIVAZIONE_U: TStringField
      DisplayLabel = '(U)Motivazione'
      FieldName = 'VT325MOTIVAZIONE_U'
      Size = 5
    end
    object selVT325_EUT853FILE_ALLEGATO: TStringField
      DisplayLabel = 'Allegato'
      FieldName = 'T853FILE_ALLEGATO'
      Size = 1
    end
  end
  object selVT325: TOracleDataSet
    SQL.Strings = (
      
        'select VT325.*, decode(T853F_NUMALLEGATI(VT325.T850ID),0,'#39'N'#39','#39'S'#39 +
        ') T853FILE_ALLEGATO, I060F_EMAIL(I090F_GETAZIENDACORRENTE, VT325' +
        '.PROGRESSIVO) EMAIL'
      '  from VT325_ITER_RICHIESTESTR_GG VT325'
      ' where 1 = 1'
      '       :FILTRO'
      ' order by VT325.T850ID desc')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A00460049004C00540052004F00010000000000
      000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000220000001400000056005400330032003500490044005F0049004400
      0100000000002000000056005400330032003500500052004F00470052004500
      53005300490056004F0001000000000012000000560054003300320035004400
      4100540041000100000000001E00000056005400330032003500540049004D00
      42005200410054005500520045000100000000001C0000005600540033003200
      35004F00520045005F004C004F00520044004500010000000000280000005600
      54003300320035004F00520045005F0043004F004E0054004500470047004900
      4100540045000100000000001600000056005400330032003500440045004200
      490054004F000100000000001E00000056005400330032003500440045005400
      52005F004D0045004E0053004100010000000000180000005600540033003200
      35005200490054004100520044004F0001000000000012000000560054003300
      320035005400490050004F000100000000001C00000056005400330032003500
      4500430043004500440045004E005A0041000100000000001200000056005400
      3300320035005300500045005A000100000000001C0000005600540033003200
      350043004100550053005F004F00520049004700010000000000200000005600
      54003300320035005300500045005A005F00440041004C004C00450031000100
      000000001E000000560054003300320035005300500045005A005F0041004C00
      4C00450031000100000000001400000056005400330032003500430041005500
      5300310001000000000020000000560054003300320035005300500045005A00
      5F00440041004C004C00450032000100000000001E0000005600540033003200
      35005300500045005A005F0041004C004C004500320001000000000014000000
      5600540033003200350043004100550053003200010000000000200000005600
      54003300320035005300500045005A005F00440041004C004C00450033000100
      000000001E000000560054003300320035005300500045005A005F0041004C00
      4C00450033000100000000001400000056005400330032003500430041005500
      5300330001000000000020000000560054003300320035004D004F0054004900
      560041005A0049004F004E0045000100000000000C0000005400380035003000
      4900440001000000000010000000540038003500300044004100540041000100
      000000001E000000540038003500300052004900430048004900450044004500
      4E00540045000100000000001000000054003800350030004E004F0054004500
      01000000000012000000540038003500300053005400410054004F0001000000
      00002400000054003800350030005400490050004F005F005200490043004800
      490045005300540041000100000000002E000000540038003500300041005500
      54004F00520049005A005A005F004100550054004F004D004100540049004300
      41000100000000001A0000005400380035003000490044005F00520045005600
      4F00430041000100000000001E0000005400380035003000490044005F005200
      450056004F004300410054004F00010000000000100000005400380035003000
      490054004500520001000000000018000000540038003500300043004F004400
      5F004900540045005200010000000000}
    Left = 160
    Top = 120
    object selVT325T850ITER: TStringField
      FieldName = 'T850ITER'
      Required = True
      Visible = False
      Size = 10
    end
    object selVT325PROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selVT325T850COD_ITER: TStringField
      DisplayLabel = 'Struttura'
      DisplayWidth = 15
      FieldName = 'T850COD_ITER'
    end
    object selVT325T850ID: TFloatField
      DisplayLabel = 'ID'
      FieldName = 'T850ID'
      Required = True
    end
    object selVT325T850DATA: TDateTimeField
      DisplayLabel = 'Data richiesta'
      FieldName = 'T850DATA'
    end
    object selVT325T850RICHIEDENTE: TStringField
      DisplayLabel = 'Richiedente'
      DisplayWidth = 20
      FieldName = 'T850RICHIEDENTE'
      Size = 30
    end
    object selVT325EMAIL: TStringField
      DisplayLabel = 'e-mail'
      DisplayWidth = 20
      FieldName = 'EMAIL'
      Size = 200
    end
    object selVT325T850STATO: TStringField
      DisplayLabel = 'Autorizzato'
      FieldName = 'T850STATO'
      Size = 1
    end
    object selVT325T850AUTORIZZ_AUTOMATICA: TStringField
      DisplayLabel = 'Autoriz. autom.'
      FieldName = 'T850AUTORIZZ_AUTOMATICA'
      Size = 1
    end
    object selVT325T850TIPO_RICHIESTA: TStringField
      DisplayLabel = 'Tipo rich.'
      FieldName = 'T850TIPO_RICHIESTA'
      Size = 1
    end
    object selVT325T850ID_REVOCA: TFloatField
      FieldName = 'T850ID_REVOCA'
      Visible = False
    end
    object selVT325T850ID_REVOCATO: TFloatField
      FieldName = 'T850ID_REVOCATO'
      Visible = False
    end
    object selVT325T850NOTE: TStringField
      DisplayLabel = 'Note'
      DisplayWidth = 20
      FieldName = 'T850NOTE'
      Size = 2000
    end
    object selVT325T850CONDIZ_ALLEGATI: TStringField
      DisplayLabel = 'Condiz. allegati'
      FieldName = 'T850CONDIZ_ALLEGATI'
      Size = 1
    end
    object selVT325VT325ID_ID: TFloatField
      DisplayLabel = 'ID T325'
      FieldName = 'VT325ID_T325'
      Required = True
    end
    object selVT325VT325DATA: TDateTimeField
      DisplayLabel = 'Data ecced.'
      DisplayWidth = 10
      FieldName = 'VT325DATA'
    end
    object selVT325VT325TIMBRATURE: TStringField
      DisplayLabel = 'Timbrature'
      DisplayWidth = 10
      FieldName = 'VT325TIMBRATURE'
      Size = 1000
    end
    object selVT325VT325ORE_LORDE: TStringField
      DisplayLabel = 'Ore lorde'
      FieldName = 'VT325ORE_LORDE'
      Size = 6
    end
    object selVT325VT325ORE_CONTEGGIATE: TStringField
      DisplayLabel = 'Ore conteggiate'
      FieldName = 'VT325ORE_CONTEGGIATE'
      Size = 6
    end
    object selVT325VT325DEBITO: TStringField
      DisplayLabel = 'Debito'
      FieldName = 'VT325DEBITO'
      Size = 5
    end
    object selVT325VT325DETR_MENSA: TStringField
      DisplayLabel = 'Detrazione mensa'
      FieldName = 'VT325DETR_MENSA'
      Size = 5
    end
    object selVT325VT325RITARDO: TStringField
      DisplayLabel = 'Ritardo'
      FieldName = 'VT325RITARDO'
      Size = 5
    end
    object selVT325VT325TIPO: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'VT325TIPO'
      Required = True
      Size = 1
    end
    object selVT325VT325ECCEDENZA: TStringField
      DisplayLabel = 'Eccedenza'
      FieldName = 'VT325ECCEDENZA'
      Size = 5
    end
    object selVT325VT325SPEZ: TStringField
      DisplayLabel = 'Spezzoni'
      FieldName = 'VT325SPEZ'
      Required = True
      Size = 11
    end
    object selVT325VT325CAUS_ORIG: TStringField
      DisplayLabel = 'Causale orig.'
      FieldName = 'VT325CAUS_ORIG'
      Size = 5
    end
    object selVT325VT325SPEZ_DALLE1: TStringField
      DisplayLabel = 'Spezzone dalle 1'
      FieldName = 'VT325SPEZ_DALLE1'
      Size = 5
    end
    object selVT325VT325SPEZ_ALLE1: TStringField
      DisplayLabel = 'Spezzone alle 1'
      FieldName = 'VT325SPEZ_ALLE1'
      Size = 5
    end
    object selVT325VT325CAUS1: TStringField
      DisplayLabel = 'Causale 1'
      FieldName = 'VT325CAUS1'
      Size = 5
    end
    object selVT325VT325SPEZ_DALLE2: TStringField
      DisplayLabel = 'Spezzone dalle 2'
      FieldName = 'VT325SPEZ_DALLE2'
      Size = 5
    end
    object selVT325VT325SPEZ_ALLE2: TStringField
      DisplayLabel = 'Spezzone alle 2'
      FieldName = 'VT325SPEZ_ALLE2'
      Size = 5
    end
    object selVT325VT325CAUS2: TStringField
      DisplayLabel = 'Causale 2'
      FieldName = 'VT325CAUS2'
      Size = 5
    end
    object selVT325VT325SPEZ_DALLE3: TStringField
      DisplayLabel = 'Spezzone delle 3'
      FieldName = 'VT325SPEZ_DALLE3'
      Size = 5
    end
    object selVT325VT325SPEZ_ALLE3: TStringField
      DisplayLabel = 'Spezzone alle 3'
      FieldName = 'VT325SPEZ_ALLE3'
      Size = 5
    end
    object selVT325VT325CAUS3: TStringField
      DisplayLabel = 'Causale 3'
      FieldName = 'VT325CAUS3'
      Size = 5
    end
    object selVT325VT325MOTIVAZIONE: TStringField
      DisplayLabel = 'Motivazione'
      FieldName = 'VT325MOTIVAZIONE'
      Size = 5
    end
    object selVT325T853FILE_ALLEGATO: TStringField
      DisplayLabel = 'Allegato'
      FieldName = 'T853FILE_ALLEGATO'
      Size = 1
    end
  end
  object dsrT851DettIter: TDataSource
    Left = 232
    Top = 16
  end
  object selI095: TOracleDataSet
    SQL.Strings = (
      'select COD_ITER '
      'from MONDOEDP.I095_ITER_AUT'
      'where AZIENDA = :AZIENDA'
      'and ITER = :ITER'
      'order by 1')
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      00000000000000000A0000003A00490054004500520005000000000000000000
      0000}
    Left = 40
    Top = 168
  end
  object dsrI095: TDataSource
    DataSet = selI095
    Left = 40
    Top = 216
  end
  object selVSG230: TOracleDataSet
    SQL.Strings = (
      
        'select VSG230.*, decode(T853F_NUMALLEGATI(VSG230.T850ID),0,'#39'N'#39','#39 +
        'S'#39') T853FILE_ALLEGATO, I060F_EMAIL(I090F_GETAZIENDACORRENTE, VSG' +
        '230.PROGRESSIVO) EMAIL'
      '  from VSG230_ITER_T850CERTIFICAZIONI VSG230'
      ' where 1 = 1'
      '       :FILTRO'
      ' order by VSG230.T850ID desc')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A00460049004C00540052004F00010000000000
      000000000000}
    Filtered = True
    OnFilterRecord = selVSG230FilterRecord
    Left = 160
    Top = 176
    object selVSG230T850ITER: TStringField
      FieldName = 'T850ITER'
      Visible = False
      Size = 10
    end
    object selVSG230PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selVSG230T850COD_ITER: TStringField
      DisplayLabel = 'Struttura'
      DisplayWidth = 15
      FieldName = 'T850COD_ITER'
    end
    object selVSG230T850ID: TFloatField
      DisplayLabel = 'ID'
      FieldName = 'T850ID'
    end
    object selVSG230T850DATA: TDateTimeField
      DisplayLabel = 'Data richiesta'
      FieldName = 'T850DATA'
    end
    object selVSG230T850RICHIEDENTE: TStringField
      DisplayLabel = 'Richiedente'
      DisplayWidth = 20
      FieldName = 'T850RICHIEDENTE'
      Size = 30
    end
    object selVSG230EMAIL: TStringField
      DisplayLabel = 'e-mail'
      DisplayWidth = 20
      FieldName = 'EMAIL'
      Size = 200
    end
    object selVSG230T850STATO: TStringField
      DisplayLabel = 'Stato'
      FieldName = 'T850STATO'
      Size = 1
    end
    object selVSG230T850AUTORIZZ_AUTOMATICA: TStringField
      DisplayLabel = 'Autoriz. autom.'
      FieldName = 'T850AUTORIZZ_AUTOMATICA'
      Size = 1
    end
    object selVSG230T850TIPO_RICHIESTA: TStringField
      DisplayLabel = 'Tipo rich.'
      FieldName = 'T850TIPO_RICHIESTA'
      Size = 1
    end
    object selVSG230T850ID_REVOCA: TFloatField
      FieldName = 'T850ID_REVOCA'
      Visible = False
    end
    object selVSG230T850ID_REVOCATO: TFloatField
      FieldName = 'T850ID_REVOCATO'
      Visible = False
    end
    object selVSG230T850NOTE: TStringField
      DisplayLabel = 'Note'
      DisplayWidth = 20
      FieldName = 'T850NOTE'
      Size = 2000
    end
    object selVSG230T850CONDIZ_ALLEGATI: TStringField
      DisplayLabel = 'Condiz. allegati'
      FieldName = 'T850CONDIZ_ALLEGATI'
      Size = 1
    end
    object selVSG230ID_CERTIFICAZIONE: TFloatField
      DisplayLabel = 'ID Mod.'
      FieldName = 'SG230ID_CERTIFICAZIONE'
    end
    object selVSG230COD_MODELLO: TStringField
      DisplayLabel = 'Codice Mod.'
      FieldName = 'SG230COD_MODELLO'
      Size = 10
    end
    object selVSG230DESC_MODELLO: TStringField
      DisplayLabel = 'Descrizione Mod.'
      DisplayWidth = 80
      FieldName = 'SG230DESC_MODELLO'
      Size = 2000
    end
    object selVSG230AL: TDateTimeField
      DisplayLabel = 'Al'
      FieldName = 'SG230AL'
    end
    object selVSG230DAL: TDateTimeField
      DisplayLabel = 'Dal'
      FieldName = 'SG230DAL'
    end
    object selVSG230SG230DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'SG230DESCRIZIONE'
      Size = 80
    end
  end
  object selVT960: TOracleDataSet
    SQL.Strings = (
      
        'select VT960.*, decode(T853F_NUMALLEGATI(VT960.T850ID),0,'#39'N'#39','#39'S'#39 +
        ') T853FILE_ALLEGATO, I060F_EMAIL(I090F_GETAZIENDACORRENTE, VT960' +
        '.PROGRESSIVO) EMAIL'
      '  from VT960_ITER_DOCUMENTALE VT960'
      ' where 1 = 1'
      '       :FILTRO'
      ' order by VT960.T850ID desc')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A00460049004C00540052004F00010000000000
      000000000000}
    Left = 96
    Top = 176
    object selVT960T850ITER: TStringField
      FieldName = 'T850ITER'
      Visible = False
      Size = 10
    end
    object selVT960PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selVT960T850COD_ITER: TStringField
      DisplayLabel = 'Struttura'
      DisplayWidth = 15
      FieldName = 'T850COD_ITER'
    end
    object selVT960T850ID: TFloatField
      DisplayLabel = 'ID'
      FieldName = 'T850ID'
    end
    object selVT960T850DATA: TDateTimeField
      DisplayLabel = 'Data richiesta'
      FieldName = 'T850DATA'
    end
    object selVT960T850RICHIEDENTE: TStringField
      DisplayLabel = 'Richiedente'
      DisplayWidth = 20
      FieldName = 'T850RICHIEDENTE'
      Size = 30
    end
    object selVT960EMAIL: TStringField
      DisplayLabel = 'e-mail'
      DisplayWidth = 20
      FieldName = 'EMAIL'
      Size = 200
    end
    object selVT960T850STATO: TStringField
      DisplayLabel = 'Stato'
      FieldName = 'T850STATO'
      Size = 1
    end
    object selVT960T850AUTORIZZ_AUTOMATICA: TStringField
      DisplayLabel = 'Autoriz. autom.'
      FieldName = 'T850AUTORIZZ_AUTOMATICA'
      Size = 1
    end
    object selVT960T850TIPO_RICHIESTA: TStringField
      DisplayLabel = 'Tipo rich.'
      FieldName = 'T850TIPO_RICHIESTA'
      Size = 1
    end
    object selVT960T850ID_REVOCA: TFloatField
      FieldName = 'T850ID_REVOCA'
      Visible = False
    end
    object selVT960T850ID_REVOCATO: TFloatField
      FieldName = 'T850ID_REVOCATO'
      Visible = False
    end
    object selVT960T850NOTE: TStringField
      DisplayLabel = 'Note'
      DisplayWidth = 20
      FieldName = 'T850NOTE'
      Size = 2000
    end
    object selVT960T850CONDIZ_ALLEGATI: TStringField
      DisplayLabel = 'Condiz. allegati'
      FieldName = 'T850CONDIZ_ALLEGATI'
      Size = 1
    end
    object selVT960T960NOME_FILE: TStringField
      DisplayLabel = 'Nome file'
      DisplayWidth = 50
      FieldName = 'T960NOME_FILE'
      Size = 240
    end
    object selVT960T960DIMENSIONE: TFloatField
      DisplayLabel = 'Dimensione'
      FieldName = 'T960DIMENSIONE'
      OnGetText = selVT960T960DIMENSIONEGetText
    end
    object selVT960T960PERIODO_DAL: TDateTimeField
      DisplayLabel = 'Inizio periodo'
      FieldName = 'T960PERIODO_DAL'
    end
    object selVT960T960PERIODO_AL: TDateTimeField
      DisplayLabel = 'Fine periodo'
      FieldName = 'T960PERIODO_AL'
    end
    object selVT960T960CF_FAMILIARE: TStringField
      DisplayLabel = 'CF Familiare'
      DisplayWidth = 18
      FieldName = 'T960CF_FAMILIARE'
      Size = 16
    end
    object selVT960T960TIPOLOGIA: TStringField
      DisplayLabel = 'Tipologia'
      DisplayWidth = 30
      FieldName = 'T960TIPOLOGIA'
      Size = 105
    end
    object selVT960T960ACCESSO_RESPONSABILE: TStringField
      DisplayLabel = 'Visualizzabile dai resp.'
      FieldName = 'T960ACCESSO_RESPONSABILE'
      Size = 1
    end
    object selVT960T960NOTE_DOCUMENTO: TStringField
      DisplayLabel = 'Note documento'
      DisplayWidth = 30
      FieldName = 'T960NOTE_DOCUMENTO'
      Size = 2000
    end
  end
  object selT326: TOracleDataSet
    SQL.Strings = (
      'select  T326.*, T326.ROWID'
      'from    T326_RICHIESTESTR_SPEZ T326, T325_RICHIESTESTR_GG T325'
      'where   1=1 --T325.DATA between :DATA1 and :DATA2'
      'and     T325.PROGRESSIVO = :PROGRESSIVO'
      'and     T325.ID = T326.ID'
      'and     T326.ID_T850 = :ID_T850'
      'order by T326.ID, T326.TIPO')
    ReadBuffer = 200
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A00490044005F0054003800
      35003000030000000000000000000000}
    SequenceField.Field = 'ID_T850'
    SequenceField.Sequence = 'T850_ID'
    QBEDefinition.QBEFieldDefs = {
      050000000D00000016000000500052004F004700520045005300530049005600
      4F000100000000000E000000430041005500530041004C004500010000000000
      06000000440041004C000100000000000400000041004C000100000000001200
      00005400490050004F00470049005500530054000100000000001C0000004100
      550054004F00520049005A005A0041005A0049004F004E004500010000000000
      1800000052004500530050004F004E0053004100420049004C00450001000000
      00000E00000044004100540041004E0041005300010000000000120000004E00
      55004D00450052004F004F005200450001000000000004000000520049000100
      0000000010000000500055004C00530041004E00540045000100000000001200
      00004D00410054005200490043004F004C004100010000000000140000004E00
      4F004D0049004E0041005400490056004F00010000000000}
    CommitOnPost = False
    Left = 332
    Top = 17
    object selT326ID: TFloatField
      FieldName = 'ID'
    end
    object selT326TIPO: TStringField
      FieldName = 'TIPO'
      Size = 1
    end
    object selT326ECCEDENZA: TStringField
      FieldName = 'ECCEDENZA'
      Size = 5
    end
    object selT326SPEZ: TStringField
      FieldName = 'SPEZ'
      Size = 11
    end
    object selT326CAUS_ORIG: TStringField
      FieldName = 'CAUS_ORIG'
      Size = 11
    end
    object selT326AUTORIZZAZIONE: TStringField
      FieldName = 'AUTORIZZAZIONE'
      Size = 1
    end
    object selT326SPEZ_DALLE1: TStringField
      FieldName = 'SPEZ_DALLE1'
      Size = 5
    end
    object selT326SPEZ_ALLE1: TStringField
      FieldName = 'SPEZ_ALLE1'
      Size = 5
    end
    object selT326CAUS1: TStringField
      FieldName = 'CAUS1'
      Size = 5
    end
    object selT326SPEZ_DALLE2: TStringField
      FieldName = 'SPEZ_DALLE2'
      Size = 5
    end
    object selT326SPEZ_ALLE2: TStringField
      FieldName = 'SPEZ_ALLE2'
      Size = 5
    end
    object selT326CAUS2: TStringField
      FieldName = 'CAUS2'
      Size = 5
    end
    object selT326SPEZ_DALLE3: TStringField
      FieldName = 'SPEZ_DALLE3'
      Size = 5
    end
    object selT326SPEZ_ALLE3: TStringField
      FieldName = 'SPEZ_ALLE3'
      Size = 5
    end
    object selT326CAUS3: TStringField
      FieldName = 'CAUS3'
      Size = 5
    end
    object selT326ID_T850: TFloatField
      FieldName = 'ID_T850'
    end
    object selT326DATA_SPEZ: TDateTimeField
      FieldName = 'DATA_SPEZ'
    end
    object selT326MOTIVAZIONE: TStringField
      FieldName = 'MOTIVAZIONE'
      Size = 5
    end
  end
  object insT320: TOracleQuery
    SQL.Strings = (
      'insert into t320_pianlibprofessione'
      '  (progressivo, data, dalle, alle, causale, id_richiesta)'
      'values'
      '  (:PROGRESSIVO, :DATA, :DALLE, :ALLE, :CAUSALE, :ID_RICHIESTA)'
      '')
    Optimize = False
    Variables.Data = {
      0400000006000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      000000000000000000000C0000003A00440041004C004C004500050000000000
      0000000000000A0000003A0041004C004C004500050000000000000000000000
      100000003A00430041005500530041004C004500050000000000000000000000
      1A0000003A00490044005F005200490043004800490045005300540041000300
      00000000000000000000}
    Left = 335
    Top = 74
  end
  object selVT700: TOracleDataSet
    SQL.Strings = (
      
        'select VT700.*, decode(T853F_NUMALLEGATI(VT700.T850ID),0,'#39'N'#39','#39'S'#39 +
        ') T853FILE_ALLEGATO'
      '  from VT700_ITER_BUDGETANNO VT700'
      ' where 1 = 1'
      '       :FILTRO'
      ' order by VT700.T850ID desc')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A00460049004C00540052004F00010000000000
      000000000000}
    Left = 160
    Top = 232
    object selVT700T850ITER: TStringField
      FieldName = 'T850ITER'
      Visible = False
      Size = 10
    end
    object selVT700T850COD_ITER: TStringField
      DisplayLabel = 'Struttura'
      DisplayWidth = 15
      FieldName = 'T850COD_ITER'
    end
    object selVT700T850ID: TFloatField
      DisplayLabel = 'ID'
      FieldName = 'T850ID'
    end
    object selVT700T850DATA: TDateTimeField
      DisplayLabel = 'Data richiesta'
      FieldName = 'T850DATA'
    end
    object selVT700T850RICHIEDENTE: TStringField
      DisplayLabel = 'Richiedente'
      DisplayWidth = 20
      FieldName = 'T850RICHIEDENTE'
      Size = 30
    end
    object selVT700T850STATO: TStringField
      DisplayLabel = 'Stato'
      FieldName = 'T850STATO'
      Size = 1
    end
    object selVT700T850AUTORIZZ_AUTOMATICA: TStringField
      DisplayLabel = 'Autoriz. autom.'
      FieldName = 'T850AUTORIZZ_AUTOMATICA'
      Size = 1
    end
    object selVT700T850TIPO_RICHIESTA: TStringField
      DisplayLabel = 'Tipo rich.'
      FieldName = 'T850TIPO_RICHIESTA'
      Size = 1
    end
    object selVT700T850ID_REVOCA: TFloatField
      FieldName = 'T850ID_REVOCA'
      Visible = False
    end
    object selVT700T850ID_REVOCATO: TFloatField
      FieldName = 'T850ID_REVOCATO'
      Visible = False
    end
    object selVT700T850NOTE: TStringField
      DisplayLabel = 'Note'
      DisplayWidth = 20
      FieldName = 'T850NOTE'
      Size = 2000
    end
    object selVT700T850CONDIZ_ALLEGATI: TStringField
      DisplayLabel = 'Condiz. allegati'
      FieldName = 'T850CONDIZ_ALLEGATI'
      Size = 1
    end
    object selVT700T700CODGRUPPO: TStringField
      DisplayLabel = 'Gruppo'
      FieldName = 'T700CODGRUPPO'
      Size = 10
    end
    object selVT700T700TIPO: TStringField
      DisplayLabel = 'Tipo'
      DisplayWidth = 10
      FieldName = 'T700TIPO'
      Size = 5
    end
    object selVT700T700DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'T700DECORRENZA'
    end
    object selVT700T700ORE: TStringField
      DisplayLabel = 'Ore'
      FieldName = 'T700ORE'
      Size = 10
    end
    object selVT700T700IMPORTO: TFloatField
      DisplayLabel = 'Importo'
      FieldName = 'T700IMPORTO'
    end
  end
  object updT713: TOracleQuery
    SQL.Strings = (
      'update T713_BUDGETANNO T'
      '   set T.ORE = :ORE,'
      '       T.IMPORTO = :IMPORTO'
      ' where T.CODGRUPPO = :CODGRUPPO'
      '   and T.TIPO = :TIPO'
      '   and T.DECORRENZA = :DECORRENZA')
    Optimize = False
    Variables.Data = {
      0400000005000000080000003A004F0052004500050000000000000000000000
      100000003A0049004D0050004F00520054004F00040000000000000000000000
      140000003A0043004F004400470052005500500050004F000500000000000000
      000000000A0000003A005400490050004F000500000000000000000000001600
      00003A004400450043004F005200520045004E005A0041000C00000000000000
      00000000}
    Left = 334
    Top = 135
  end
  object selT713: TOracleDataSet
    SQL.Strings = (
      
        '--legge da T713 i dati da salvare su T852 per eventuale ripristi' +
        'no'
      'select ORE, IMPORTO'
      '  from T713_BUDGETANNO T'
      ' where T.CODGRUPPO = :CODGRUPPO'
      '   and T.TIPO = :TIPO'
      '   and T.DECORRENZA = :DECORRENZA')
    Optimize = False
    Variables.Data = {
      0400000003000000140000003A0043004F004400470052005500500050004F00
      0500000000000000000000000A0000003A005400490050004F00050000000000
      000000000000160000003A004400450043004F005200520045004E005A004100
      0C0000000000000000000000}
    Left = 336
    Top = 192
  end
  object dsrT265T275: TDataSource
    AutoEdit = False
    DataSet = selT265T275
    Left = 415
    Top = 64
  end
  object selT265T275: TOracleDataSet
    SQL.Strings = (
      '  select CODICE, DESCRIZIONE, '#39'A'#39' TIPOCAUS'
      '    from T265_CAUASSENZE'
      '   union'
      '  select CODICE, DESCRIZIONE, '#39'P'#39' TIPOCAUS'
      '    from T275_CAUPRESENZE'
      '   where 1=:CAUPRESENZE'
      'order by CODICE')
    ReadBuffer = 200
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00430041005500500052004500530045004E00
      5A004500030000000000000000000000}
    Filtered = True
    OnFilterRecord = selT265T275FilterRecord
    Left = 415
    Top = 20
  end
  object selVT600: TOracleDataSet
    SQL.Strings = (
      
        'select VT600.*, decode(T853F_NUMALLEGATI(VT600.T850ID),0,'#39'N'#39','#39'S'#39 +
        ') T853FILE_ALLEGATO, I060F_EMAIL(I090F_GETAZIENDACORRENTE, VT600' +
        '.PROGRESSIVO) EMAIL'
      '  from VT600_ITER_RICHIESTEDISPTURNI VT600'
      ' where 1 = 1'
      '       :FILTRO'
      ' order by VT600.T850ID desc')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A00460049004C00540052004F00010000000000
      000000000000}
    Left = 216
    Top = 232
    object selVT600T850ITER: TStringField
      FieldName = 'T850ITER'
      Visible = False
      Size = 10
    end
    object selVT600T850COD_ITER: TStringField
      DisplayLabel = 'Struttura'
      DisplayWidth = 15
      FieldName = 'T850COD_ITER'
    end
    object selVT600T850ID: TFloatField
      DisplayLabel = 'ID'
      FieldName = 'T850ID'
    end
    object selVT600T850DATA: TDateField
      DisplayLabel = 'Data richiesta'
      DisplayWidth = 18
      FieldName = 'T850DATA'
    end
    object selVT600T850RICHIEDENTE: TStringField
      DisplayLabel = 'Richiedente'
      DisplayWidth = 20
      FieldName = 'T850RICHIEDENTE'
      Size = 30
    end
    object selVT600EMAIL: TStringField
      DisplayLabel = 'e-mail'
      DisplayWidth = 20
      FieldName = 'EMAIL'
      Size = 200
    end
    object selVT600T850STATO: TStringField
      DisplayLabel = 'Stato'
      FieldName = 'T850STATO'
      Size = 1
    end
    object selVT600T850AUTORIZZ_AUTOMATICA: TStringField
      DisplayLabel = 'Autoriz. autom.'
      FieldName = 'T850AUTORIZZ_AUTOMATICA'
      Size = 1
    end
    object selVT600T850TIPO_RICHIESTA: TStringField
      DisplayLabel = 'Tipo rich.'
      FieldName = 'T850TIPO_RICHIESTA'
      Size = 1
    end
    object selVT600T850ID_REVOCA: TFloatField
      FieldName = 'T850ID_REVOCA'
      Visible = False
    end
    object selVT600T850ID_REVOCATO: TFloatField
      FieldName = 'T850ID_REVOCATO'
      Visible = False
    end
    object selVT600T850NOTE: TStringField
      DisplayLabel = 'Note'
      DisplayWidth = 20
      FieldName = 'T850NOTE'
      Size = 2000
    end
    object selVT600T850CONDIZ_ALLEGATI: TStringField
      DisplayLabel = 'Condiz. allegati'
      FieldName = 'T850CONDIZ_ALLEGATI'
      Size = 1
    end
    object selVT600T600DATA: TDateField
      DisplayLabel = 'Data'
      FieldName = 'T600DATA'
    end
    object selVT600T600DAORE: TStringField
      DisplayLabel = 'Da ore'
      FieldName = 'T600DAORE'
      Size = 5
    end
    object selVT600T600AORE: TStringField
      DisplayLabel = 'A ore'
      FieldName = 'T600AORE'
      Size = 5
    end
    object selVT600T600SQUADRE: TStringField
      DisplayLabel = 'Squadre'
      DisplayWidth = 20
      FieldName = 'T600SQUADRE'
      Size = 1000
    end
  end
end
