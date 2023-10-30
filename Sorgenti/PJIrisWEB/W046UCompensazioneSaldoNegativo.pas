unit W046UCompensazioneSaldoNegativo;

interface

uses
  System.SysUtils, System.Classes, R012UWebAnagrafico, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompLabel, meIWLabel, IWCompEdit, meIWEdit,
  IWCompGrids, meIWGrid, IWCompButton, meIWButton, Vcl.Controls, IWCompJQueryWidget,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, OracleData, Math, StrUtils, Variants, Data.DB, IWCompExtCtrls, meIWRadioGroup,
  A000UCostanti, A000UInterfaccia, C180FunzioniGenerali, C190FunzioniGeneraliWeb, R450,
  Datasnap.DBClient, IWDBGrids, medpIWDBGrid, meIWImageFile, W000UMessaggi;

type
  TW046FCompensazioneSaldoNegativo = class(TR012FWebAnagrafico)
    lblTitoloMese: TmeIWLabel;
    selT070: TOracleDataSet;
    JQuery: TIWJQueryWidget;
    grdMesiCSN: TmedpIWDBGrid;
    cdsMesiCSN: TClientDataSet;
    dsrMesiCSN: TDataSource;
    selMesiCSN: TClientDataSet;
    procedure IWAppFormCreate(Sender: TObject);
    procedure grdMesiCSNRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure grdMesiCSNAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
  private
    { Private declarations }
    DataScheda,GGIni,GGFin:TDateTime;
    Progressivo:Integer;
    SaldoComplSchedaAnno,SaldoComplSceltaAnno,SaldoComplSimulaAnno,OreRecDispSchedaAnno,OreRecDispSceltaAnno,OreRecDispSimulaAnno,CompMaxSchedaAnno,CompEffSceltaAnno:String;
    ColCompEffSceltaAnno,ColSaldoComplSchedaAnno,ColOreRecDispSchedaAnno:Integer;
    OreScelta:String;
    R450DtM1: TR450DtM1;
    selT077:TselT077;
    StileCella1,StileCella2,StileCella3: String;
    procedure imgSimulaClick(Sender: TObject);
    procedure imgAnnullaClick(Sender: TObject);
    procedure imgConfermaClick(Sender: TObject);
  protected
    procedure VisualizzaDipendenteCorrente; override;
    procedure DistruggiOggetti; override;
  public
    { Public declarations }
    function  InizializzaAccesso:Boolean; override;
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TW046FCompensazioneSaldoNegativo.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  //Lavoro sul mese precedente alla data corrente
  DataScheda:=R180AddMesi(R180InizioMese(R180SysDate(SessioneOracle)),-1);

  //DataScheda:=EncodeDate(2019,1,1);//SOLO PER TEST

  lblTitoloMese.Caption:='Mese di ' + FormatDateTime('mmmm yyyy',DataScheda);
  if not TryEncodeDate(R180Anno(Date),R180Mese(Date),StrToIntDef(Parametri.CampiRiferimento.C90_W026UtilizzoDal,1),GGIni) then
    GGIni:=R180InizioMese(Date);
  if not TryEncodeDate(R180Anno(Date),R180Mese(Date),StrToIntDef(Parametri.CampiRiferimento.C90_W026UtilizzoAl,31),GGFin) then
    GGFin:=R180FineMese(Date);
  lblTitoloMese.Caption:=lblTitoloMese.Caption + ' - Periodo di richiesta/autorizzazione dal ' + IntToStr(StrToIntDef(Parametri.CampiRiferimento.C90_W026UtilizzoDal,1)) + ' al ' + FormatDateTime('dd mmmm yyyy',GGFin);

  selT070.Session:=SessioneOracle;
  R450DtM1:=TR450DtM1.Create(nil);
  selT077:=TselT077.Create(Self);
  selT077.Session:=SessioneOracle;
end;

function TW046FCompensazioneSaldoNegativo.InizializzaAccesso:Boolean;
begin
  Result:=True;
  GetDipendentiDisponibili(Parametri.DataLavoro);
  selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]);
  VisualizzaDipendenteCorrente;
end;

procedure TW046FCompensazioneSaldoNegativo.VisualizzaDipendenteCorrente;
var i,nMesi:Integer;
    MeseCorr:TDateTime;
begin
  inherited;

  if selMesiCSN.Active then
    selMesiCSN.EmptyDataSet
  else
    selMesiCSN.CreateDataSet;

  nMesi:=Min(GetRighePaginaTabella,12);
  for i:=0 to nMesi - 1 do
  begin
    MeseCorr:=R180AddMesi(DataScheda,-i);

    selMesiCSN.Append;
    selMesiCSN.FieldByName('MESE').AsString:=FormatDateTime('mm/yyyy',MeseCorr);

    //Inizializzo variabili
    Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
    SaldoComplSchedaAnno:='';
    OreRecDispSchedaAnno:='';
    CompMaxSchedaAnno:='';
    SaldoComplSceltaAnno:='';
    OreRecDispSceltaAnno:='';
    CompEffSceltaAnno:='';

    //Cerco la scheda riepilogativa
    selT070.Close;
    selT070.SetVariable('PROGRESSIVO',Progressivo);
    selT070.SetVariable('DATA',MeseCorr);
    selT070.Open;
    //Recupero dati
    if (selT070.RecordCount > 0) and WR000DM.selDatiBloccati.DatoBloccato(Progressivo,MeseCorr,'T070') then
      try
        //Dati atipici (Ultima scelta effettuata)
        selT077.Progressivo:=Progressivo;
        selT077.Data:=MeseCorr;
        if selT077.LeggiValore(I011CSN_SALDO_ANNO) <> '' then
          SaldoComplSceltaAnno:=R180MinutiOre(StrToIntDef(selT077.LeggiValore(I011CSN_SALDO_ANNO),0));
        if selT077.LeggiValore(I011CSN_OREDISPONIBILI_ANNO) <> '' then
          OreRecDispSceltaAnno:=R180MinutiOre(StrToIntDef(selT077.LeggiValore(I011CSN_OREDISPONIBILI_ANNO),0));
        if selT077.LeggiValore(I011CSN_COMPENSAZIONE_ANNO) <> '' then
          CompEffSceltaAnno:=R180MinutiOre(StrToIntDef(selT077.LeggiValore(I011CSN_COMPENSAZIONE_ANNO),0));
        if R180OreMinuti(CompEffSceltaAnno) = 0 then
        begin
          SaldoComplSceltaAnno:='';
          OreRecDispSceltaAnno:='';
          CompEffSceltaAnno:='';
        end;
        //Dati attuali
        if MeseCorr = DataScheda then
        begin
          R450DtM1.selT070.Close;
          R450DtM1.ConteggiMese('Generico',R180Anno(MeseCorr),R180Mese(MeseCorr),Progressivo);
          //Saldo complessivo
          SaldoComplSchedaAnno:=R180MinutiOre(R450DtM1.salannoatt);
          //Ore a recupero disponibili
          OreRecDispSchedaAnno:=R180MinutiOre(R450DtM1.RiepassCompensazioneDisponibile['ANNO']);
        end
        else
        begin
          if CompEffSceltaAnno <> '' then
          begin
            SaldoComplSchedaAnno:=R180MinutiOre(R180OreMinuti(SaldoComplSceltaAnno) + R180OreMinuti(CompEffSceltaAnno));
            OreRecDispSchedaAnno:=R180MinutiOre(R180OreMinuti(OreRecDispSceltaAnno) - R180OreMinuti(CompEffSceltaAnno));
          end;
        end;
        //Compensazione massima
        CompMaxSchedaAnno:=R180MinutiOre(0);
        if ((R180OreMinuti(SaldoComplSchedaAnno) - R180OreMinuti(CompEffSceltaAnno)) < 0)
        and ((R180OreMinuti(OreRecDispSchedaAnno) + R180OreMinuti(CompEffSceltaAnno)) > 0) then
          CompMaxSchedaAnno:=R180MinutiOre(Min(Abs(R180OreMinuti(SaldoComplSchedaAnno) - R180OreMinuti(CompEffSceltaAnno)),(R180OreMinuti(OreRecDispSchedaAnno) + R180OreMinuti(CompEffSceltaAnno))));
      except
        on E:Exception do
          raise exception.Create(Format(A000MSG_W046_ERR_FMT_ERRORE_CONTEGGI,[E.Message]));
      end;

    selMesiCSN.FieldByName('SALDOCOMPL_ORIG').AsString:=SaldoComplSceltaAnno;
    selMesiCSN.FieldByName('ORERECDISP_ORIG').AsString:=OreRecDispSceltaAnno;
    selMesiCSN.FieldByName('COMPEFF_ORIG').AsString:=CompEffSceltaAnno;
    selMesiCSN.FieldByName('COMPMAX_ATT').AsString:=CompMaxSchedaAnno;
    selMesiCSN.FieldByName('SALDOCOMPL_ATT').AsString:=SaldoComplSchedaAnno;
    selMesiCSN.FieldByName('ORERECDISP_ATT').AsString:=OreRecDispSchedaAnno;

    //Visualizzo eventuale messaggio incongruenza
    if (selT070.RecordCount = 0) or not WR000DM.selDatiBloccati.DatoBloccato(Progressivo,MeseCorr,'T070') then
      selMesiCSN.FieldByName('MESSAGGI').AsString:=A000MSG_W046_MSG_NO_DATI_DISP
    else if WR000DM.selDatiBloccati.DatoBloccato(Progressivo,MeseCorr,'T820') then
    begin
      selMesiCSN.FieldByName('MESSAGGI').AsString:=A000MSG_W046_MSG_NO_DATI_MOD
    end
    else if MeseCorr = DataScheda then
    begin
      if not R180Between(Date,GGIni,GGFin) then
        selMesiCSN.FieldByName('MESSAGGI').AsString:=A000MSG_W046_MSG_NO_PERIODO
      else
      begin
        if R180OreMinuti(SaldoComplSchedaAnno) > 0 then
          selMesiCSN.FieldByName('MESSAGGI').AsString:=selMesiCSN.FieldByName('MESSAGGI').AsString + A000MSG_W046_MSG_SALDO_POSITIVO;
        if R180OreMinuti(OreRecDispSchedaAnno) < 0 then
          selMesiCSN.FieldByName('MESSAGGI').AsString:=selMesiCSN.FieldByName('MESSAGGI').AsString + A000MSG_W046_MSG_ORE_RECUPERO_NEGATIVE;
        if R180OreMinuti(CompEffSceltaAnno) > R180OreMinuti(CompMaxSchedaAnno) then
          selMesiCSN.FieldByName('MESSAGGI').AsString:=selMesiCSN.FieldByName('MESSAGGI').AsString + A000MSG_W046_MSG_SUPERO_COMP_MAX;
      end;
    end;

    selMesiCSN.FieldByName('MODIFICABILE').AsString:=IfThen(not SolaLettura //utente abilitato alla modifica
                                                            and (MeseCorr = DataScheda) //mese oggetto di modifica
                                                            and (selT070.RecordCount > 0) //scheda esistente
                                                            and R180Between(Date,GGIni,GGFin) //giorno attuale compreso nella finestra temporale mensile parametrizzata
                                                            and WR000DM.selDatiBloccati.DatoBloccato(Progressivo,MeseCorr,'T070') //scheda chiusa
                                                            and (not WR000DM.selDatiBloccati.DatoBloccato(Progressivo,MeseCorr,'T820')) // scheda non bloccata
                                                            and (   (R180OreMinuti(CompEffSceltaAnno) > 0)  //scelta annuale annullabile
                                                                 or (R180OreMinuti(CompMaxSchedaAnno) > 0)) //scelta annuale effettuabile
                                                            ,'S','N');
    selMesiCSN.Post;
  end;

  grdMesiCSN.medpRighePagina:=nMesi;
  grdMesiCSN.medpDataSet:=selMesiCSN;
  grdMesiCSN.medpBrowse:=True;
  grdMesiCSN.medpStato:=msBrowse;
  //Creazione ClientDataSet con stessa struttura del DataSet di partenza
  grdMesiCSN.medpCreaCDS;
  //Impostazione delle colonne da visualizzare sulla DBGrid
  grdMesiCSN.medpEliminaColonne;
  grdMesiCSN.medpAggiungiColonna('MESE','Mese','',nil);
  grdMesiCSN.medpAggiungiColonna('SALDOCOMPL_ORIG','Saldo complessivo precedente','',nil);
  grdMesiCSN.medpAggiungiColonna('ORERECDISP_ORIG','Ore a recupero disponibili precedenti','',nil);
  grdMesiCSN.medpAggiungiColonna('COMPEFF_ORIG','Compensazione effettuata','',nil);
  grdMesiCSN.medpAggiungiColonna('COMPMAX_ATT','Compensazione massima effettuabile','',nil);
  grdMesiCSN.medpAggiungiColonna('SALDOCOMPL_ATT','Saldo complessivo attuale','',nil);
  grdMesiCSN.medpAggiungiColonna('ORERECDISP_ATT','Ore a recupero disponibili attuali','',nil);
  grdMesiCSN.medpAggiungiColonna('MESSAGGI','Messaggi','',nil);
  grdMesiCSN.medpInizializzaCompGriglia;
  ColCompEffSceltaAnno:=grdMesiCSN.medpIndexColonna('COMPEFF_ORIG');
  ColSaldoComplSchedaAnno:=grdMesiCSN.medpIndexColonna('SALDOCOMPL_ATT');
  ColOreRecDispSchedaAnno:=grdMesiCSN.medpIndexColonna('ORERECDISP_ATT');
  grdMesiCSN.medpPreparaComponenteGenerico('R',ColCompEffSceltaAnno,0,DBG_EDT,'width4chr input_hour_hhhmm2','','','','D');
  grdMesiCSN.medpPreparaComponenteGenerico('R',ColCompEffSceltaAnno,1,DBG_IMG,'','ELENCO','Simula','','');
  grdMesiCSN.medpPreparaComponenteGenerico('R',ColCompEffSceltaAnno,2,DBG_IMG,'','ANNULLA','Annulla','','');
  grdMesiCSN.medpPreparaComponenteGenerico('R',ColCompEffSceltaAnno,3,DBG_IMG,'','CONFERMA','Conferma','','');
  grdMesiCSN.medpPreparaComponenteGenerico('R',ColSaldoComplSchedaAnno,0,DBG_LBL,'width4chr','','','','');
  grdMesiCSN.medpPreparaComponenteGenerico('R',ColOreRecDispSchedaAnno,0,DBG_LBL,'width4chr','','','','');
  grdMesiCSN.medpCaricaCDS;
end;

procedure TW046FCompensazioneSaldoNegativo.grdMesiCSNAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var i:Integer;
    LIWLbl: TmeIWLabel;
    LIWEdt: TmeIWEdit;
    LIWGrd: TmeIWGrid;
begin
  inherited;
  //Righe dati
  for i:=0 to High(grdMesiCSN.medpCompGriglia) do
  begin
    if grdMesiCSN.medpCompGriglia[i].CompColonne[ColCompEffSceltaAnno] <> nil then
    begin
      if grdMesiCSN.medpValoreColonna(i,'MODIFICABILE') = 'S' then
      begin
        LIWEdt:=(grdMesiCSN.medpCompCella(i,ColCompEffSceltaAnno,0) as TmeIWEdit);
        LIWEdt.Text:=R180MinutiOre(R180OreMinuti(grdMesiCSN.medpValoreColonna(i,'COMPEFF_ORIG')));
        LIWEdt.NonEditableAsLabel:=True;
        if StileCella2 = '' then
          StileCella2:=LIWEdt.Css;
        (grdMesiCSN.medpCompCella(i,ColCompEffSceltaAnno,1) as TmeIWImageFile).OnClick:=imgSimulaClick;
        (grdMesiCSN.medpCompCella(i,ColCompEffSceltaAnno,2) as TmeIWImageFile).OnClick:=imgAnnullaClick;
        (grdMesiCSN.medpCompCella(i,ColCompEffSceltaAnno,3) as TmeIWImageFile).OnClick:=imgConfermaClick;
        LIWGrd:=(grdMesiCSN.medpCompGriglia[i].CompColonne[ColCompEffSceltaAnno] as TmeIWGrid);
        LIWGrd.Cell[0,0].Css:='align_right width67pc';
        if StileCella3 = '' then
          StileCella3:=LIWGrd.Cell[0,1].Css;
        LIWGrd.Cell[0,2].Css:='invisibile';
        LIWGrd.Cell[0,3].Css:='invisibile';
      end
      else
        FreeAndNil(grdMesiCSN.medpCompGriglia[i].CompColonne[ColCompEffSceltaAnno]);
    end;
    if grdMesiCSN.medpCompGriglia[i].CompColonne[ColSaldoComplSchedaAnno] <> nil then
    begin
      LIWLbl:=(grdMesiCSN.medpCompCella(i,ColSaldoComplSchedaAnno,0) as TmeIWLabel);
      LIWLbl.Caption:=grdMesiCSN.medpValoreColonna(i,'SALDOCOMPL_ATT');
      if StileCella1 = '' then
        StileCella1:=LIWLbl.Css;
    end;
    if grdMesiCSN.medpCompGriglia[i].CompColonne[ColOreRecDispSchedaAnno] <> nil then
    begin
      LIWLbl:=(grdMesiCSN.medpCompCella(i,ColOreRecDispSchedaAnno,0) as TmeIWLabel);
      LIWLbl.Caption:=grdMesiCSN.medpValoreColonna(i,'ORERECDISP_ATT');
    end;
  end;
end;

procedure TW046FCompensazioneSaldoNegativo.grdMesiCSNRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var NumColonna: Integer;
begin
  inherited;
  NumColonna:=grdMesiCSN.medpNumColonna(AColumn);
  if not grdMesiCSN.medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;
  ACell.Wrap:=(ARow = 0) or (AColumn = grdMesiCSN.medpIndexColonna('MESSAGGI'));
  //Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(grdMesiCSN.medpCompGriglia) + 1) and (grdMesiCSN.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdMesiCSN.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

procedure TW046FCompensazioneSaldoNegativo.imgSimulaClick(Sender: TObject);
var FN: String;
    i,h: Integer;
    LIWLbl: TmeIWLabel;
    LIWEdt: TmeIWEdit;
    LIWGrd: TmeIWGrid;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  i:=grdMesiCSN.medpRigaDiCompGriglia(FN);

  CompEffSceltaAnno:=grdMesiCSN.medpValoreColonna(i,'COMPEFF_ORIG');
  LIWEdt:=(grdMesiCSN.medpCompCella(i,ColCompEffSceltaAnno,0) as TmeIWEdit);
  OreScelta:=LIWEdt.Text;
  if not TryStrToInt(StringReplace(OreScelta,'.','',[]),h) then
    raise exception.Create(A000MSG_W046_ERR_ORE_COMP);
  OreMinutiValidate(OreScelta);
  if R180OreMinuti(CompEffSceltaAnno) = R180OreMinuti(OreScelta) then
    raise exception.Create(A000MSG_W046_ERR_ORE_COMP_OLD);
  if R180OreMinuti(OreScelta) < 0 then
    raise exception.Create(A000MSG_W046_ERR_ORE_COMP_NEG);
  CompMaxSchedaAnno:=grdMesiCSN.medpValoreColonna(i,'COMPMAX_ATT');
  if R180OreMinuti(OreScelta) > R180OreMinuti(CompMaxSchedaAnno) then
    raise exception.Create(A000MSG_W046_ERR_ORE_COMP_OLTRE_MAX);

  LIWEdt.Editable:=False;
  LIWEdt.Text:=R180MinutiOre(R180OreMinuti(grdMesiCSN.medpValoreColonna(i,'COMPEFF_ORIG'))) + ' ' + #8594 + ' ' + OreScelta;
  LIWEdt.Css:=LIWEdt.Css + ' riga_evidenziata';

  LIWGrd:=(grdMesiCSN.medpCompGriglia[i].CompColonne[ColCompEffSceltaAnno] as TmeIWGrid);
  LIWGrd.Cell[0,1].Css:='invisibile';
  LIWGrd.Cell[0,2].Css:=StileCella3;
  LIWGrd.Cell[0,3].Css:=StileCella3;

  SaldoComplSchedaAnno:=grdMesiCSN.medpValoreColonna(i,'SALDOCOMPL_ATT');
  SaldoComplSimulaAnno:=R180MinutiOre(R180OreMinuti(SaldoComplSchedaAnno) - R180OreMinuti(CompEffSceltaAnno) + R180OreMinuti(OreScelta));
  LIWLbl:=(grdMesiCSN.medpCompCella(i,ColSaldoComplSchedaAnno,0) as TmeIWLabel);
  LIWLbl.Caption:=R180MinutiOre(R180OreMinuti(grdMesiCSN.medpValoreColonna(i,'SALDOCOMPL_ATT'))) + ' ' + #8594 + ' ' + SaldoComplSimulaAnno;
  LIWLbl.Css:=LIWLbl.Css + ' riga_evidenziata';

  OreRecDispSchedaAnno:=grdMesiCSN.medpValoreColonna(i,'ORERECDISP_ATT');
  OreRecDispSimulaAnno:=R180MinutiOre(R180OreMinuti(OreRecDispSchedaAnno) + R180OreMinuti(CompEffSceltaAnno) - R180OreMinuti(OreScelta));
  LIWLbl:=(grdMesiCSN.medpCompCella(i,ColOreRecDispSchedaAnno,0) as TmeIWLabel);
  LIWLbl.Caption:=R180MinutiOre(R180OreMinuti(grdMesiCSN.medpValoreColonna(i,'ORERECDISP_ATT'))) + ' ' + #8594 + ' ' + OreRecDispSimulaAnno;
  LIWLbl.Css:=LIWLbl.Css + ' riga_evidenziata';
end;

procedure TW046FCompensazioneSaldoNegativo.imgAnnullaClick(Sender: TObject);
var FN: String;
    i: Integer;
    LIWLbl: TmeIWLabel;
    LIWEdt: TmeIWEdit;
    LIWGrd: TmeIWGrid;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  i:=grdMesiCSN.medpRigaDiCompGriglia(FN);

  LIWEdt:=(grdMesiCSN.medpCompCella(i,ColCompEffSceltaAnno,0) as TmeIWEdit);
  LIWEdt.Editable:=True;
  LIWEdt.Text:=R180MinutiOre(R180OreMinuti(grdMesiCSN.medpValoreColonna(i,'COMPEFF_ORIG')));
  LIWEdt.Css:=StileCella2;

  LIWGrd:=(grdMesiCSN.medpCompGriglia[i].CompColonne[ColCompEffSceltaAnno] as TmeIWGrid);
  LIWGrd.Cell[0,1].Css:=StileCella3;
  LIWGrd.Cell[0,2].Css:='invisibile';
  LIWGrd.Cell[0,3].Css:='invisibile';

  LIWLbl:=(grdMesiCSN.medpCompCella(i,ColSaldoComplSchedaAnno,0) as TmeIWLabel);
  LIWLbl.Caption:=grdMesiCSN.medpValoreColonna(i,'SALDOCOMPL_ATT');
  LIWLbl.Css:=StileCella1;

  LIWLbl:=(grdMesiCSN.medpCompCella(i,ColOreRecDispSchedaAnno,0) as TmeIWLabel);
  LIWLbl.Caption:=grdMesiCSN.medpValoreColonna(i,'ORERECDISP_ATT');
  LIWLbl.Css:=StileCella1;
end;

procedure TW046FCompensazioneSaldoNegativo.imgConfermaClick(Sender: TObject);
begin
  Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  //Registro dati atipici
  selT077.Progressivo:=Progressivo;
  selT077.Data:=DataScheda;
  selT077.ScriviValore(I011CSN_SALDO_ANNO,IntToStr(R180OreMinuti(SaldoComplSchedaAnno) - R180OreMinuti(CompEffSceltaAnno)));
  selT077.ScriviValore(I011CSN_OREDISPONIBILI_ANNO,IntToStr(R180OreMinuti(OreRecDispSchedaAnno) + R180OreMinuti(CompEffSceltaAnno)));
  selT077.ScriviValore(I011CSN_COMPENSAZIONE_ANNO,IntToStr(R180OreMinuti(OreScelta)));
  //Registrare in campo specifico della scheda riepilogativa il valore che va ad abbattere il saldo complessivo e a ridurre le ore disponibili per la compensazione
  selT070.Close;
  selT070.SetVariable('PROGRESSIVO',Progressivo);
  selT070.SetVariable('DATA',DataScheda);
  selT070.Open;
  selT070.Edit;
  selT070.FieldByName('RIEPASS_COMPENSATE_ANNO').AsString:=R180MinutiOre(R180OreMinuti(OreScelta));
  selT070.Post;
  SessioneOracle.Commit;
  VisualizzaDipendenteCorrente;
end;

procedure TW046FCompensazioneSaldoNegativo.DistruggiOggetti;
begin
  selMesiCSN.EmptyDataSet;
  selMesiCSN.Close;
  FreeAndNil(selT077);
  FreeAndNil(R450DtM1);
end;

end.
