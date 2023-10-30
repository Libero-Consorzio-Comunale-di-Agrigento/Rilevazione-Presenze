inherited P553FRisorseResidueContoAnnualeDtM: TP553FRisorseResidueContoAnnualeDtM
  OldCreateOrder = True
  Height = 105
  Width = 113
  object selP553: TOracleDataSet
    SQL.Strings = (
      'select t.*,t.rowid from P553_CONTOANNRISORRES t'
      'order by anno,cod_tabella')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000080000000800000041004E004E004F00010000000000160000004300
      4F0044005F0054004100420045004C004C004100010000000000180000004300
      4F004C004F004E004E0041005F00520049004700410001000000000016000000
      4D004100430052004F005F004300410054004500470001000000000016000000
      4400450053004300520049005A0049004F004E0045000100000000001E000000
      49004D0050004F00520054004F005F005200450053004900440055004F000100
      000000002200000043004F0044005F0054004100420045004C004C0041005F00
      510055004F00540045000100000000001A00000043004F004C004F004E004E00
      41005F00510055004F0054004500010000000000}
    BeforePost = BeforePostNoStorico
    AfterScroll = selP553AfterScroll
    Left = 24
    Top = 16
    object selP553ANNO: TIntegerField
      FieldName = 'ANNO'
      Required = True
    end
    object selP553COD_TABELLA: TStringField
      FieldName = 'COD_TABELLA'
      Required = True
      Size = 10
    end
    object selP553COLONNA_RIGA: TIntegerField
      FieldName = 'COLONNA_RIGA'
      Required = True
    end
    object selP553MACRO_CATEG: TStringField
      FieldName = 'MACRO_CATEG'
      Required = True
      Size = 10
    end
    object selP553DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 100
    end
    object selP553IMPORTO_RESIDUO: TFloatField
      FieldName = 'IMPORTO_RESIDUO'
    end
    object selP553COD_TABELLA_QUOTE: TStringField
      FieldName = 'COD_TABELLA_QUOTE'
      Size = 10
    end
    object selP553COLONNA_QUOTE: TIntegerField
      FieldName = 'COLONNA_QUOTE'
    end
  end
end
