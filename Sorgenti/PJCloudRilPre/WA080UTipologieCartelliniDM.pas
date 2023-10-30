unit WA080UTipologieCartelliniDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData, Oracle,
  A000UInterfaccia, WR302UGestTabellaDM, WR300UBaseDM, DBClient,
  A000UCostanti, A000USessione, medpIWMessageDlg,C180FunzioniGenerali, Math,A000UMessaggi;

type
  TWA080FTipologieCartelliniDM = class(TWR302FGestTabellaDM)
    Q026: TOracleDataSet;
    Q026CODICE: TStringField;
    Q026ANNO_RIF: TIntegerField;
    Q026MESE_RIF: TIntegerField;
    Q026MESE_ABBATT: TIntegerField;
    D026: TDataSource;
    selT275EsclNorm: TOracleDataSet;
    dsrT275EsclNorm: TDataSource;
    selT265: TOracleDataSet;
    dsrT265: TDataSource;
    insT026: TOracleQuery;
    selT950: TOracleDataSet;
    dsrT950: TDataSource;
    selT265RNF: TOracleDataSet;
    selTipiRichStraord: TOracleDataSet;
    dsrTipiRichStraord: TDataSource;
    selTabellaCODICE: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaCARTELLINO: TStringField;
    selTabellaISTITUTI: TStringField;
    selTabellaSCOSTSETT: TStringField;
    selTabellaINDENNITA: TStringField;
    selTabellaINDPRESENZA: TStringField;
    selTabellaCONTEGGIO: TIntegerField;
    selTabellaCOMPPREC: TIntegerField;
    selTabellaLIQPREC: TIntegerField;
    selTabellaCOMPATT: TIntegerField;
    selTabellaLIQATT: TIntegerField;
    selTabellaMESISALDOPREC: TIntegerField;
    selTabellaLIQUIDDISTRIBUITA: TStringField;
    selTabellaTIPOLIMITECOMPA: TStringField;
    selTabellaLIMITECOMPA: TStringField;
    selTabellaRECUPERO_SERBATOI: TStringField;
    selTabellaBANCAORE: TStringField;
    selTabellaABBATTIMENTO_LIQUIDABILE: TStringField;
    selTabellaRECUPERODEBITO: TIntegerField;
    selTabellaRECUPERODEBITO_MAX: TStringField;
    selTabellaPERIODICITA_ABBATTIMENTO: TStringField;
    selTabellaABBATTIMENTO_MOBILE_MAX: TStringField;
    selTabellaABBATTIMENTO_MOBILE_SALDI: TStringField;
    selTabellaCAUSALI_COMPENSABILI: TStringField;
    selTabellaLIMITE_MM_ECCLIQ_TIPO: TStringField;
    selTabellaLIMITE_MM_ECCLIQ_DEFAULT: TStringField;
    selTabellaLIMITE_MM_ECCRES_TIPO: TStringField;
    selTabellaLIMITE_MM_ECCRES_DEFAULT: TStringField;
    selTabellaTRASF_SUPERO_LIQANN: TStringField;
    selTabellaSOGLIA_COMP_LIQ: TStringField;
    selTabellaSALDO_NEGATIVO_MINIMO: TStringField;
    selTabellaBANCAORE_RESID: TStringField;
    selTabellaABBATT_MOBILE_RIFERIMENTO: TStringField;
    selTabellaBANCA_ORE_LIMITATA_SALDO_COMP: TStringField;
    selTabellaBANCA_ORE_LIMITATA_STR_LIQ: TStringField;
    selTabellaARR_SOGLIA_COMP_LIQ: TStringField;
    selTabellaRIPOSO_NONFRUITO: TStringField;
    selTabellaARRREC_COMPPREC: TStringField;
    selTabellaARRREC_LIQPREC: TStringField;
    selTabellaARRREC_COMPATT: TStringField;
    selTabellaARRREC_LIQATT: TStringField;
    selTabellaBANCA_ORE_ESCLUSA_ABBATT: TStringField;
    selTabellaRECUP_STRAORD_PREC: TStringField;
    selTabellaRIPOSO_RECUPLIQUID: TStringField;
    selTabellaRECUPERODEBITO_TIPO: TStringField;
    selTabellaTIPOLIMITECOMPP: TStringField;
    selTabellaBANCA_ORE_RESID_ANNOPREC: TStringField;
    selTabellaBANCA_ORE_MENS_ARR: TStringField;
    selTabellaSALDO_NEGATIVO_MINIMO_TIPO: TStringField;
    selTabellaARRREC_SCOSTNEG: TStringField;
    selTabellaPA_LIMITE: TStringField;
    selTabellaPA_LIMITESALDOATT: TStringField;
    selTabellaPA_LIMITESALDOPREC: TStringField;
    selTabellaPA_AZZERAMENTOPERIODICO: TStringField;
    selTabellaPA_TIPORESIDUO: TStringField;
    selTabellaBANCA_ORE_ABBATTIBILE: TStringField;
    selTabellaABBATT_RIF_COMPENSABILE: TStringField;
    selTabellaABBATT_RIF_LIQUIDABILE: TStringField;
    selTabellaABBATTIMENTO_FISSO_RECUPERO: TStringField;
    selTabellaCAUSRIPCOM_FASCE: TStringField;
    selTabellaD_RIPOSO_NONFRUITO: TStringField;
    selTabellaD_CAUSRIPCOM_FASCE: TStringField;
    selTabellaDEBAGG_RAPP_ANNO: TStringField;
    selTabellaDEBAGG_CONSIDERA_OREPREC: TStringField;
    selTabellaPAR_CARTELLINO: TStringField;
    selTabellaD_PAR_CARTELLINO: TStringField;
    selTabellaBANCA_ORE_CONTR_LIQUIDAZ: TStringField;
    selTabellaRNF_ASSENZE_TOLLERATE: TStringField;
    selTabellaRNF_FILTRO: TStringField;
    selTabellaABBATT_RIF_RECUPERO: TStringField;
    selTabellaITER_AUTORIZZATIVO_STR: TStringField;
    selTabellaBANCA_ORE_ESCLUSA_SALDI: TStringField;
    selTabellaTIPOLIMITECOMP_NOREC: TStringField;
    selTabellaRECDEBITO_MAXTOLLERATO: TStringField;
    selTabellaCAUS_RIENTRIOBBL: TStringField;
    selTabellaPA_RAGGR_LIMITE: TStringField;
    selTabellaPA_RAGGR_LIMITESALDOATT: TStringField;
    selTabellaPA_RAGGR_LIMITESALDOPREC: TStringField;
    selT260: TOracleDataSet;
    selTabellaITER_ECCGG_CHECKSALDO: TStringField;
    selTabellaCAUSALI_COMPENSABILI_MENSILI: TStringField;
    selTabellaLIMITE_MM_ECCRES_CAUSALI: TStringField;
    selT275LimiteCaus: TOracleDataSet;
    selTabellaCAUSALI_COMP_MENS_SALDO: TStringField;
    selTabellaCAUSALI_COMP_ANN_ADDEB_PAGHE: TStringField;
    selTabellaRIPCOM_INCLUSI_SALDO: TStringField;
    selTabellaCAUSALI_COMP_ANN_SALDO: TStringField;
    selT275Lookup: TOracleDataSet;
    selTabellaITER_AUTSTR_CAUSALE: TStringField;
    selTabellaITER_AUTSTR_MINIMO_LIQ: TStringField;
    selTabellaITER_AUTSTR_ARROT_LIQ: TStringField;
    selTabellaITER_AUTSTR_ARROT_ECC: TStringField;
    selTabellaXPARAM: TStringField;
    selTabellaITER_AUTSTR_ARROT_LIQ_FASCE: TStringField;
    selTabellaRECUPERODEBITO_PERIODICITA: TStringField;
    selTabellaGGVUOTO_TURNISTA: TStringField;
    selTabellaRIEPASS_COMPENSABILI_ANNO: TStringField;
    selTabellaCAUSALI_COMP_MESE_RECNEG: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure selTabellaCalcFields(DataSet: TDataSet);
    procedure AfterPost(DataSet: TDataSet); override;
    procedure Q026NewRecord(DataSet: TDataSet);
  private
    procedure CheckBeforePost_selTabella(Sender: TObject; Res: TmeIWModalResult; KeyID: String);

  public
  end;

implementation

uses WR100UBase, WA080UTipologieCartellini, WA080UTipologieCartelliniDettFM;

{$R *.dfm}

procedure TWA080FTipologieCartelliniDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  NonAprireSelTabella:=True;
  selTabella.SetVariable('ORDERBY','ORDER BY CODICE');
  inherited;
  selT265.Open;
  selT265.FieldByName('CODICE').DisplayWidth:=7;
  selT275EsclNorm.Open;
  selTabella.Open;
  selTipiRichStraord.Open;
  selT260.Open;
  selT275Lookup.Open;
end;

procedure TWA080FTipologieCartelliniDM.Q026NewRecord(DataSet: TDataSet);
begin
  inherited;
  Q026.FieldByName('Codice').AsString:=SelTabella.FieldByName('Codice').AsString;
end;

procedure TWA080FTipologieCartelliniDM.AfterPost(DataSet: TDataSet);
begin
  MsgBox.ClearKeys;
  inherited;
end;

procedure TWA080FTipologieCartelliniDM.BeforePostNoStorico(DataSet: TDataSet);
var V:array[0..4] of Byte;
    i:Byte;
    L1,L2:String;
  LArrotLiq: string;
  LMinutiArrotLiq: Integer;
  LMinimoLiq: String;
  LMinutiMinimoLiq: Integer;
begin
  inherited;

  if not MsgBox.KeyExists('PUNTO_1') then
  begin
    if (selTabella.FieldByName('CONTEGGIO').AsString = '4') then
    begin
      for i:=1 to 4 do V[i]:=0;
      inc(V[selTabella.FieldByName('COMPPREC').AsInteger],1);
      inc(V[selTabella.FieldByName('LIQPREC').AsInteger],1);
      inc(V[selTabella.FieldByName('COMPATT').AsInteger],1);

      for i:=1 to 4 do
        if V[i] > 1 then
        begin
          MsgBox.WebMessageDlg(A000MSG_A080_ERR_ORDINE_SERBATOI,mtError,[mbOk],nil,'');
          Abort;
        end;

      if ((selTabella.FieldByName('LIMITE_MM_ECCLIQ_TIPO').AsString = 'EG') and (selTabella.FieldByName('LIMITE_MM_ECCRES_TIPO').AsString <> 'EG') or
         (selTabella.FieldByName('LIMITE_MM_ECCRES_TIPO').AsString = 'EG') and (selTabella.FieldByName('LIMITE_MM_ECCLIQ_TIPO').AsString <> 'EG')) then
      begin
        MsgBox.WebMessageDlg(A000MSG_A080_ERR_TIPI_APPLICAZIONE,mtError,[mbOk],nil,'');
        Abort;
      end;

      if not selTabella.FieldByName('PA_LIMITE').IsNull then
      begin
        L1:=Trim(StringReplace(selTabella.FieldByName('PA_LIMITESALDOATT').AsString,'.','',[]));
        L2:=Trim(StringReplace(selTabella.FieldByName('PA_LIMITESALDOPREC').AsString,'.','',[]));
        if R180OreMinutiExt(selTabella.FieldByName('PA_LIMITE').AsString) <
           min(IfThen(L1 = '',R180OreMinutiExt('9999.59'),R180OreMinutiExt(selTabella.FieldByName('PA_LIMITESALDOATT').AsString)),
               IfThen(L2 = '',R180OreMinutiExt('9999.59'),R180OreMinutiExt(selTabella.FieldByName('PA_LIMITESALDOPREC').AsString))) then
        begin
          MsgBox.WebMessageDlg(A000MSG_A080_ERR_RESID_INFERIORE_LIMITE,mtError,[mbOk],nil,'');
          Abort;
        end;

        if R180OreMinutiExt(selTabella.FieldByName('PA_LIMITE').AsString) >
           IfThen(L1 = '',R180OreMinutiExt('9999.59'),R180OreMinutiExt(selTabella.FieldByName('PA_LIMITESALDOATT').AsString)) +
           IfThen(L2 = '',R180OreMinutiExt('9999.59'),R180OreMinutiExt(selTabella.FieldByName('PA_LIMITESALDOPREC').AsString)) then
        begin
          MsgBox.WebMessageDlg(A000MSG_A080_ERR_RESID_SUPERIORE_LIMITE,mtError,[mbOk],nil,'');
          Abort;
        end;
      end;

      if selTabella.FieldByName('ITER_AUTORIZZATIVO_STR').AsString = '' then
        selTabella.FieldByName('ITER_AUTORIZZATIVO_STR').AsString:='0';

      if selTabella.FieldByName('BANCA_ORE_ESCLUSA_SALDI').AsString = 'S' then
      begin
        selTabella.FieldByName('BANCA_ORE_ESCLUSA_ABBATT').ASString:='N';
        selTabella.FieldByName('BANCA_ORE_ABBATTIBILE').ASString:='N';
        selTabella.FieldByName('BANCA_ORE_LIMITATA_SALDO_COMP').ASString:='N';
      end;

      //Alberto 28/03/2007
      if (selTabella.FieldByName('RECUPERODEBITO').AsInteger > 1) and
         ((selTabella.FieldByName('PERIODICITA_ABBATTIMENTO').AsString <> 'M') or (selTabella.FieldByName('MESISALDOPREC').AsInteger < 0)) then
      begin
        MsgBox.WebMessageDlg(A000MSG_A080_DLG_NO_SALDI_MOBILI,mtConfirmation,[mbYes,mbNo],CheckBeforePost_selTabella,'PUNTO_1');
        Abort;
      end;

      if selTabella.FieldByName('LIMITE_MM_ECCRES_TIPO').AsString <> 'EG' then
      begin
        selTabella.FieldByName('LIMITE_MM_ECCRES_CAUSALI').Clear;
      end;
    end;

    // verifica dati tipo iter straordinari
    if selTabella.FieldByName('ITER_AUTORIZZATIVO_STR').AsString = TTipoRichStrRec.StraordAnnuoCausPagComp then
    begin
      // arrotondamento liquidabile specifico
      LArrotLiq:=selTabella.FieldByName('ITER_AUTSTR_ARROT_LIQ').AsString;
      if LArrotLiq = '' then
        LMinutiArrotLiq:=1
      else
        LMinutiArrotLiq:=R180OreMinutiExt(LArrotLiq);

      // arrotondamento deve essere >= 1 minuto
      if (LArrotLiq <> '') and (LMinutiArrotLiq <= 0) then
      begin
        MsgBox.MessageBox(A000MSG_A080_ERR_ARRLIQ_POSITIVO,ERRORE);
        Abort;
      end;

      // minimo liquidabile
      LMinimoLiq:=selTabella.FieldByName('ITER_AUTSTR_MINIMO_LIQ').AsString;
      LMinutiMinimoLiq:=R180OreMinutiExt(LMinimoLiq);

      // il minimo liquidabile deve essere multiplo del valore di arrotondamento
      if not ((LMinutiMinimoLiq mod LMinutiArrotLiq) = 0) then
      begin
        MsgBox.MessageBox(Format(A000MSG_A080_ERR_FMT_MINLIQ_MOD_ARRLIQ,[LMinimoLiq,LArrotLiq]),ERRORE);
        Abort;
      end;
    end;
  end;
end;

procedure TWA080FTipologieCartelliniDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  selTabella.FieldByName('D_RIPOSO_NONFRUITO').AsString:=VarToStr(selT265.Lookup('CODICE',selTabella.FieldByName('RIPOSO_NONFRUITO').AsString,'DESCRIZIONE'));
  selTabella.FieldByName('D_CAUSRIPCOM_FASCE').AsString:=VarToStr(selT275EsclNorm.Lookup('CODICE',selTabella.FieldByName('CAUSRIPCOM_FASCE').AsString,'DESCRIZIONE'));
end;

procedure TWA080FTipologieCartelliniDM.CheckBeforePost_selTabella(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  case Res of
    mrYes: selTabella.Post;
    mrNo:  MsgBox.ClearKeys;
  end;
end;

end.
