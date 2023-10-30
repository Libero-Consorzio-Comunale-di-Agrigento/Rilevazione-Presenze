unit WA028USc;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR100UBase, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, medpIWTabControl, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, meIWRegion, A028UScMW, IWCompCheckbox,
  meIWCheckBox, IWCompEdit, meIWEdit, IWCompLabel, meIWLabel, meIWImageFile,
  medpIWImageButton, A000UInterfaccia, A000UMessaggi, medpIWMessageDlg,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb,R500Lin, IWDBGrids, medpIWDBGrid;

type
  TWA028FSc = class(TWR100FBase)
    grdTabDetail: TmedpIWTabControl;
    WA028DatiRiassuntiviRG: TmeIWRegion;
    lblAnomalia: TmeIWLabel;
    lblNumTimb: TmeIWLabel;
    grdNumTimb: TmeIWGrid;
    TemplateDatiRiassuntiviRG: TIWTemplateProcessorHTML;
    lblData: TmeIWLabel;
    edtData: TmeIWEdit;
    chkRichiesteWeb: TmeIWCheckBox;
    imgConteggi: TmedpIWImageButton;
    imgReset: TmedpIWImageButton;
    grdTimbratureCon: TmeIWGrid;
    LblTimbratureCon: TmeIWLabel;
    lblNumTimbNom: TmeIWLabel;
    grdTimbNom: TmeIWGrid;
    lblNumGiusDaA: TmeIWLabel;
    grdGiusDaA: TmeIWGrid;
    lblNumGiusOre: TmeIWLabel;
    grdGiusNumOre: TmeIWGrid;
    lblMezzaAss: TmeIWLabel;
    LblMGCaus: TmeIWLabel;
    LblGiorniAss: TmeIWLabel;
    LblGGCaus: TmeIWLabel;
    LblValGiornoAss: TmeIWLabel;
    LblFasce: TmeIWLabel;
    grdFasce: TmeIWGrid;
    WA028AnomalieRG: TmeIWRegion;
    TemplateAnomalieRG: TIWTemplateProcessorHTML;
    lblAnomalie2: TmeIWLabel;
    grdAnomalie2: TmeIWGrid;
    lblAnomalie3: TmeIWLabel;
    grdAnomalie3: TmeIWGrid;
    lblPresenze: TmeIWLabel;
    grdPresenze: TmeIWGrid;
    lblAssenze: TmeIWLabel;
    grdAssenze: TmeIWGrid;
    WA028DettaglioDatiRG: TmeIWRegion;
    TemplateDettaglioDatiRG: TIWTemplateProcessorHTML;
    grdConteggi: TmedpIWDBGrid;
    lblStaccoMensa: TmeIWLabel;
    grdStaccoMensa: TmeIWGrid;
    lblTimbMensa: TmeIWLabel;
    grdTimbMensa: TmeIWGrid;
    lblFascePaghe: TmeIWLabel;
    grdFascePaghe: TmeIWGrid;
    lblRilevatori: TmeIWLabel;
    grdRilevatori: TmeIWGrid;
    lblGettoni: TmeIWLabel;
    grdGettoni: TmeIWGrid;
    WA028DettaglioTimbratureRG: TmeIWRegion;
    TemplateDettaglioTimbratureRG: TIWTemplateProcessorHTML;
    lblEntrate: TmeIWLabel;
    grdEntrate: TmeIWGrid;
    lblUscite: TmeIWLabel;
    grdUscite: TmeIWGrid;
    meIWLabel1: TmeIWLabel;
    lblDipendente: TmeIWLabel;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure imgConteggiClick(Sender: TObject);
    procedure grdRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure grdRenderCellConIntestazione(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure grdConteggiRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure imgResetAsyncClick(Sender: TObject; EventParams: TStringList);
  private
    procedure CaricaDati(Data: TDateTime);
    procedure VisualizzaGrdTabDetail(Vis: Boolean);
    procedure DatiRiassuntivi;
    procedure Anomalie;
    procedure DettaglioDati(Data: TDateTime);
    procedure DettaglioTimbrature;
    { Private declarations }
  public
    A028FScMW : TA028FScMW;
    function InizializzaAccesso:Boolean; override;
  end;

implementation

uses Rp502Pro;

{$R *.dfm}

procedure TWA028FSc.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  A028FScMW:=TA028FScMW.Create(nil);

  WR100LinkWC700:=False;
  AttivaGestioneC700;

  grdTabDetail.AggiungiTab('Dati Riassuntivi',WA028DatiRiassuntiviRG);
  grdTabDetail.AggiungiTab('Anomalie - Riepilogo presenze/assenze',WA028AnomalieRG);
  grdTabDetail.AggiungiTab('Dettaglio dati',WA028DettaglioDatiRG);
  grdTabDetail.AggiungiTab('Dettaglio timbrature',WA028DettaglioTimbratureRG);

  grdTabDetail.HasFiller:=True;
  grdTabDetail.ActiveTab:=WA028DatiRiassuntiviRG;
  VisualizzaGrdTabDetail(False);
end;

function TWA028FSc.InizializzaAccesso: Boolean;
var
  Progressivo: Integer;
  Data: TDateTime;
begin
  Progressivo:=StrToIntDef(GetParam('PROGRESSIVO'),0);

  if Progressivo <> 0 then //Imposto progressivo selezionato. Si opera solo su quel progressivo
    grdC700.WC700FM.C700Progressivo:=Progressivo;

  with grdC700.selAnagrafe do
    lblDipendente.Caption:=FieldByName('PROGRESSIVO').AsString + ' ' +
                           FieldByName('MATRICOLA').AsString + ' ' +
                           FieldByName('COGNOME').AsString + ' ' +
                           FieldByName('NOME').AsString;

  EdtData.Text:='';
  if GetParam('DATA') <> '' then
  begin
    Data:=StrToDate(GetParam('DATA'));
    EdtData.Text:=FormatDateTime('dd/mm/yyyy',Data);
  end;

  if (GetParam('DATA') <> '') and (Progressivo <> 0) then
    imgConteggiClick(imgConteggi);

  Result:=True;
end;

procedure TWA028FSc.VisualizzaGrdTabDetail(Vis: Boolean);
begin
  if Vis = False then
  begin //rendo tutte le region invisibili
    grdTabDetail.Visible:=Vis;
    WA028DatiRiassuntiviRG.Visible:=Vis;
    WA028AnomalieRG.Visible:=Vis;
    WA028DettaglioDatiRG.Visible:=Vis;
    WA028DettaglioTimbratureRG.Visible:=Vis;
  end
  else
  begin
    //rendo visibile solo la region attiva
    grdTabDetail.Visible:=Vis;
    grdTabDetail.ActiveTab.Visible:=Vis;
  end;
end;

procedure TWA028FSc.grdRenderCellConIntestazione(ACell: TIWGridCell; const ARow,
  AColumn: Integer);
begin
  inherited;
  if not C190RenderCell(ACell,ARow,AColumn,True,False,False) then
    Exit;
end;

procedure TWA028FSc.grdConteggiRenderCell(ACell: TIWGridCell; const ARow,
  AColumn: Integer);
begin
  inherited;
  grdConteggi.medpRenderCell(Acell,ARow,AColumn,False,False,False);
  if pos('*** ', grdConteggi.medpClientDataSet.FieldByName('DATO').AsString ) > 0 then
    ACell.Css:=ACell.Css + ' bg_aqua';
end;

procedure TWA028FSc.grdRenderCell(ACell: TIWGridCell; const ARow,
  AColumn: Integer);
begin
  inherited;
  if not C190RenderCell(ACell,ARow,AColumn,False,False,False) then
    Exit;
end;

procedure TWA028FSc.imgConteggiClick(Sender: TObject);
var Data: TDateTime;
begin
  inherited;
  if not TryStrToDate(edtData.Text,Data) then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_DATA_ERRATA,mtError,[mbOk],nil,'');
    Abort;
  end;
  CaricaDati(Data);
end;

procedure TWA028FSc.imgResetAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  A028FScMW.ResettaConteggi;
  VisualizzaGrdTabDetail(False);
end;

procedure TWA028FSc.CaricaDati(Data: TDateTime);
begin
  VisualizzaGrdTabDetail(True);
  with A028FScMW do
  begin
    SettaConteggi(Data,Data,chkRichiesteWeb.Checked);
    EseguiConteggi(grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger ,Data);
    InzializzaCdsConteggi;

    DatiRiassuntivi;
    Anomalie;
    DettaglioDati(Data);
    DettaglioTimbrature;
  end;
end;

procedure TWA028FSc.DettaglioTimbrature;
var i: Integer;
begin
  with A028FScMW.R502ProDtM1 do
  begin
    LblEntrate.Caption:='___ ENTRATE complete dipendente ___' + IntToStr(n_timbrdip);
    GrdEntrate.Clear;
    GrdEntrate.RowCount:=10;
    GrdEntrate.ColumnCount:=1;
    GrdEntrate.Cell[0,0].Text:='hhmm';
    GrdEntrate.Cell[1,0].Text:='Rilevatore';
    GrdEntrate.Cell[2,0].Text:='Causale';
    GrdEntrate.Cell[3,0].Text:='Tipo/Raggrupp.';
    GrdEntrate.Cell[4,0].Text:='Cont./Ripart. ';
    GrdEntrate.Cell[5,0].Text:='Incl./Riepil. ';
    GrdEntrate.Cell[6,0].Text:='Arrotondamento';
    GrdEntrate.Cell[7,0].Text:='Minuti in piu'' ';
    GrdEntrate.Cell[8,0].Text:='Abilitazione  ';
    GrdEntrate.Cell[9,0].Text:='Arrotondata   ';
    LblUscite.Caption:='___ USCITE complete dipendente ___';
    GrdUscite.Clear;
    GrdUscite.RowCount:=10;
    GrdUscite.ColumnCount:=1;
    GrdUscite.Cell[0,0].Text:='hhmm';
    GrdUscite.Cell[1,0].Text:='Rilevatore';
    GrdUscite.Cell[2,0].Text:='Causale';
    GrdUscite.Cell[3,0].Text:='Tipo/Raggrupp.';
    GrdUscite.Cell[4,0].Text:='Cont./Ripart. ';
    GrdUscite.Cell[5,0].Text:='Incl./Riepil. ';
    GrdUscite.Cell[6,0].Text:='Arrotondamento';
    GrdUscite.Cell[7,0].Text:='Minuti in piu'' ';
    GrdUscite.Cell[8,0].Text:='Abilitazione  ';
    GrdUscite.Cell[9,0].Text:='Arrotondata   ';
    GrdEntrate.ColumnCount:=n_timbrdip + 1;
    GrdUscite.ColumnCount:=n_timbrdip + 1;
    for i:=1 to n_timbrdip do
      with TTimbratureDip[i] do
      begin
        GrdEntrate.Cell[0,i].Text:=R180MinutiOre(tminutid_e);
        GrdEntrate.Cell[1,i].Text:=trilev_e;
        GrdEntrate.Cell[2,i].Text:=tcausale_e.tcaus;
        GrdEntrate.Cell[3,i].Text:=tcausale_e.tcaustip + ' ' + tcausale_e.tcausrag;
        GrdEntrate.Cell[4,i].Text:=tcausale_e.tcauscon + ' ' + tcausale_e.tcausrip;
        GrdEntrate.Cell[5,i].Text:=tcausale_e.tcausioe + ' ' + tcausale_e.tcausrpl;
        GrdEntrate.Cell[6,i].Text:=IntToStr(tcausale_e.tcausarr);
        GrdEntrate.Cell[7,i].Text:=R180MinutiOre(tcausale_e.tcauspiu);
        GrdEntrate.Cell[8,i].Text:=tcausale_e.tcausabi;
        GrdEntrate.Cell[9,i].Text:=tflagarr_e;
        GrdUscite.Cell[0,i].Text:=R180MinutiOre(tminutid_u);
        GrdUscite.Cell[1,i].Text:=trilev_u;
        GrdUscite.Cell[2,i].Text:=tcausale_u.tcaus;
        GrdUscite.Cell[3,i].Text:=tcausale_u.tcaustip + ' ' + tcausale_u.tcausrag;
        GrdUscite.Cell[4,i].Text:=tcausale_u.tcauscon + ' ' + tcausale_u.tcausrip;
        GrdUscite.Cell[5,i].Text:=tcausale_u.tcausioe + ' ' + tcausale_u.tcausrpl;
        GrdUscite.Cell[6,i].Text:=IntToStr(tcausale_u.tcausarr);
        GrdUscite.Cell[7,i].Text:=R180MinutiOre(tcausale_u.tcauspiu);
        GrdUscite.Cell[8,i].Text:=tcausale_u.tcausabi;
        GrdUscite.Cell[9,i].Text:=tflagarr_u;
      end;
  end;
end;

procedure TWA028FSc.DettaglioDati(Data: TDateTime);
var i: Integer;
begin
  with A028FScMW do
  begin
    CaricaCdsConteggi;
    grdConteggi.medpAttivaGrid(cdsconteggi,False,False,False);
    //staccoMensa
    grdStaccoMensa.Clear;
    grdStaccoMensa.RowCount:=0;
    if High(R502ProDtM1.TimbratureMensa) >= 0 then
      grdStaccoMensa.RowCount:=High(R502ProDtM1.TimbratureMensa) + 1;
    grdStaccoMensa.ColumnCount:=2;
    for i:=0 to High(R502ProDtM1.TimbratureMensa) do
    begin
      grdStaccoMensa.Cell[i,0].Text:=R180MinutiOre(R502ProDtM1.TimbratureMensa[i].I);
      grdStaccoMensa.Cell[i,1].Text:=R180MinutiOre(R502ProDtM1.TimbratureMensa[i].F);
    end;
    //timb mensa
    GrdTimbMensa.Clear;
    GrdTimbMensa.RowCount:=0;
    GrdTimbMensa.ColumnCount:=0;
    if R502ProDtM1.Q370.Locate('Data',Data,[]) then
    begin
      while not R502ProDtM1.Q370.Eof do
      begin
        if R502ProDtM1.Q370.FieldByName('Data').AsDateTime <> Data then
          Break;
        GrdTimbMensa.RowCount:=GrdTimbMensa.RowCount + 1;
        GrdTimbMensa.Cell[GrdTimbMensa.RowCount - 1,0].Text:=FormatDateTime('hh.nn',R502ProDtM1.Q370.FieldByName('Ora').AsDateTime);
        R502ProDtM1.Q370.Next;
      end;
    end;
    //Fasce paghe
    GrdFascePaghe.Clear;
    GrdFascePaghe.ColumnCount:=2;
    GrdFascePaghe.RowCount:=0;
    for i:=0 to High(R502ProDtM1.FascePaghe276) do
    begin
      if R502ProDtM1.FascePaghe276[i].VocePaghe <> '' then
      begin
        GrdFascePaghe.RowCount:=i + 1;
        GrdFascePaghe.Cell[i,0].Text:=R502ProDtM1.FascePaghe276[i].VocePaghe;
        GrdFascePaghe.Cell[i,1].Text:=R180MinutiOre(R502ProDtM1.FascePaghe276[i].Ore);
      end
      else
        Break;
    end;
    //Ore rilevatore
    grdRilevatori.Clear;
    grdRilevatori.RowCount:=Length(R502ProDtM1.trieprilev);
    grdRilevatori.ColumnCount:=2;
    if Length(R502ProDtM1.trieprilev) > 0 then
    begin
      for i:=0 to grdRilevatori.ColumnCount - 1 do grdRilevatori.Cell[0,i].Text:='';
      for i:=0 to High(R502ProDtM1.trieprilev) do
      begin
        grdRilevatori.Cell[i,0].Text:=R502ProDtM1.trieprilev[i].rilevatore;
        grdRilevatori.Cell[i,1].Text:=R180MinutiOre(R502ProDtM1.trieprilev[i].tminprestot);
      end;
    end;

    //gettoni
    grdGettoni.Clear;
    grdGettoni.RowCount:=Length(R502ProDtM1.Gettoni);
    grdGettoni.ColumnCount:=2;
    if Length(R502ProDtM1.Gettoni) > 0 then
    begin
      for i:=0 to grdGettoni.ColumnCount - 1 do grdGettoni.Cell[0,i].Text:='';
      for i:=0 to High(R502ProDtM1.Gettoni) do
      begin
        grdGettoni.Cell[i,0].Text:=R502ProDtM1.Gettoni[i].Causale;
        grdGettoni.Cell[i,1].Text:=R180MinutiOre(R502ProDtM1.Gettoni[i].Minuti);
      end;
    end;
  end;
end;

procedure TWA028FSc.DatiRiassuntivi;
var i: Integer;
begin
  with A028FScMW do
  begin
    lblAnomalia.Caption:=GetAnomalia;
    lblAnomalia.Visible:=lblAnomalia.Caption <> '';

    //Timbrature dip
    lblNumTimb.Caption:='Timbrature dip: ' + IntToStr(R502ProDtM1.n_timbrdip);
    grdNumTimb.Clear;
    grdNumTimb.ColumnCount:=R502ProDtM1.n_timbrdip;
    if R502ProDtM1.n_timbrdip > 0 then
      grdNumTimb.RowCount:=3
    else
      grdNumTimb.RowCount:=0;

    for i:=1 to R502ProDtM1.n_timbrdip do
    begin
      grdNumTimb.Cell[0,i - 1].Text:=R180MinutiOre(R502ProDtM1.ttimbraturedip[i].tminutid_e);
      grdNumTimb.Cell[1,i - 1].Text:=R180MinutiOre(R502ProDtM1.ttimbraturedip[i].tminutid_u);
      grdNumTimb.Cell[2,i - 1].Text:=IntToStr(R502ProDtM1.ttimbraturedip[i].tpuntnomin);
    end;
    //Timbrature con
    grdTimbratureCon.Clear;
    grdTimbratureCon.ColumnCount:=R502ProDtM1.n_timbrcon;
    if R502ProDtM1.n_timbrcon > 0 then
      grdTimbratureCon.RowCount:=3
    else
      grdTimbratureCon.RowCount:=0;
    for i:=1 to R502ProDtM1.n_timbrcon do
    begin
      grdTimbratureCon.Cell[0,i - 1].Text:=R180MinutiOre(R502ProDtM1.ttimbraturecon[i].tminutic_e);
      grdTimbratureCon.Cell[1,i - 1].Text:=R180MinutiOre(R502ProDtM1.ttimbraturecon[i].tminutic_u);
      grdTimbratureCon.Cell[2,i - 1].Text:=IntToStr(R502ProDtM1.ttimbraturecon[i].tpuntatore);
      if R502ProDtM1.ttimbraturecon[i].tinclcaus <> #0 then
        grdTimbratureCon.Cell[2,i - 1].Text:=grdTimbratureCon.Cell[2,i - 1].Text + '(' + R502ProDtM1.ttimbraturecon[i].tinclcaus + ')';
    end;
    //Timbrature nom
    LblNumTimbNom.Caption:='Timbrature nominali: '  + IntToStr(R502ProDtM1.n_timbrnom);
    grdTimbNom.Clear;
    grdTimbNom.ColumnCount:=R502ProDtM1.n_timbrnom;
    if R502ProDtM1.n_timbrnom > 0 then
      grdTimbNom.RowCount:=4
    else
      grdTimbNom.RowCount:=0;

    for i:=1 to R502ProDtM1.n_timbrnom do
    begin
      grdTimbNom.Cell[0,i - 1].Text:=R180MinutiOre(R502ProDtM1.TTimbratureNom[i].tminutin_e);
      grdTimbNom.Cell[1,i - 1].Text:=IntToStr(R502ProDtM1.TTimbratureNom[i].tpuntre);
      grdTimbNom.Cell[2,i - 1].Text:=R180MinutiOre(R502ProDtM1.TTimbratureNom[i].tminutin_u);
      grdTimbNom.Cell[3,i - 1].Text:=IntToStr(R502ProDtM1.TTimbratureNom[i].tpuntru);
    end;
    //Giustificativi da a
    lblNumGiusDaA.Caption:='Giust. da - a: ' + IntToStr(R502ProDtM1.n_giusdaa);
    grdGiusDaA.Clear;
    grdGiusDaA.ColumnCount:=R502ProDtM1.n_giusdaa;
    if R502ProDtM1.n_giusdaa > 0 then
      grdGiusDaA.RowCount:=3
    else
      grdGiusDaA.RowCount:=0;

    for i:=1 to R502ProDtM1.n_giusdaa do
    begin
      grdGiusDaA.Cell[0,i - 1].Text:=R180MinutiOre(R502ProDtM1.tgius_dallealle[i].tminutida);
      grdGiusDaA.Cell[1,i - 1].Text:=R180MinutiOre(R502ProDtM1.tgius_dallealle[i].tminutia);
      grdGiusDaA.Cell[2,i - 1].Text:=R502ProDtM1.tgius_dallealle[i].tcausdaa;
    end;

    //Giustificativi ore
    lblNumGiusOre.Caption:='Giust. num. ore: ' + IntToStr(R502ProDtM1.n_giusore);
    grdGiusNumOre.Clear;
    grdGiusNumOre.ColumnCount:=R502ProDtM1.n_giusore;
     if R502ProDtM1.n_giusore > 0 then
      grdGiusNumOre.RowCount:=2
    else
      grdGiusNumOre.RowCount:=0;

    for i:=1 to R502ProDtM1.n_giusore do
    begin
      grdGiusNumOre.Cell[0,i - 1].Text:=R180MinutiOre(R502ProDtM1.tgius_min[i].tmin);
      grdGiusNumOre.Cell[1,i - 1].Text:=R502ProDtM1.tgius_min[i].tcausore;
    end;
    //_________
    LblMezzaAss.Caption:='Mezza gg assenza: ' + IntToStr(R502ProDtM1.n_giusmga);
    LblMGCaus.Caption:=getCausMgAss;
    LblGiorniAss.Caption:='gg assenza: ' + IntToStr(R502ProDtM1.n_giusgga);
    LblGGCaus.Caption:='';
    for i:=1 to R502ProDtM1.n_giusgga do
      if i > 2 then break
      else LblGGCaus.Caption:=LblGGCaus.Caption + R502ProDtM1.tgius_ggass[i].tcausggass + ' ';
    LblValGiornoAss.Caption:='';
    if (R502ProDtM1.n_giusmga > 0) or (R502ProDtM1.n_giusgga > 0) then
      LblValGiornoAss.Caption:='Val. gg assenza: ' + R180MinutiOre(R502ProDtM1.valggass);

    //Fasce
    LblFasce.Caption:=GetDescFasce;
    GrdFasce.Clear;
    GrdFasce.ColumnCount:=7;
    GrdFasce.RowCount:=R502ProDtM1.n_fasce + 1;

    GrdFasce.Cell[0,0].Text:='Codice';
    GrdFasce.Cell[0,1].Text:='%';
    GrdFasce.Cell[0,2].Text:='Dalle';
    GrdFasce.Cell[0,3].Text:='Alle';
    GrdFasce.Cell[0,4].Text:='';
    GrdFasce.Cell[0,5].Text:='Ore lav.';
    GrdFasce.Cell[0,6].Text:='Ore str.';
    for i:=1 to R502ProDtM1.n_fasce do
    begin
      GrdFasce.Cell[i,0].Text:=R502ProDtM1.tfasceorarie[i].tcodfasc;
      GrdFasce.Cell[i,1].Text:=IntToStr(R502ProDtM1.tfasceorarie[i].tpercfasc);
      GrdFasce.Cell[i,2].Text:=R180MinutiOre(R502ProDtM1.tfasceorarie[i].tiniz1fasc) + '-' + R180MinutiOre(R502ProDtM1.tfasceorarie[i].tfine1fasc);
      GrdFasce.Cell[i,3].Text:=R180MinutiOre(R502ProDtM1.tfasceorarie[i].tiniz2fasc) + '-' + R180MinutiOre(R502ProDtM1.tfasceorarie[i].tfine2fasc);
      GrdFasce.Cell[i,4].Text:='(' + IntToStr(R502ProDtM1.tfasceorarie[i].ttipofasc) + ')';
      GrdFasce.Cell[i,5].Text:=R180MinutiOre(R502ProDtM1.tminlav[i]);
      GrdFasce.Cell[i,6].Text:=R180MinutiOre(R502ProDtM1.tminstrgio[i]);
    end;
  end;
end;

procedure TWA028FSc.Anomalie;
var i,icom : Integer;
begin
  with A028FScMW do
  begin
    //Anomalie 2 livello
    LblAnomalie2.Caption:='Anomalie 2° livello: ' + IntToStr(R502ProDtM1.n_anom2);
    GrdAnomalie2.Clear;
    GrdAnomalie2.ColumnCount:=2;
    GrdAnomalie2.RowCount:=R502ProDtM1.n_anom2 + 1;
    for i:=0 to High(R502ProDtM1.tanom2riscontrate) do
    begin
      if tdescanom2[R502ProDtM1.tanom2riscontrate[i].ta2puntdesc].F = 1 then
        GrdAnomalie2.Cell[i,0].Text:=R502ProDtM1.tanom2riscontrate[i].ta2caus
      else
        GrdAnomalie2.Cell[i,0].Text:='';

      GrdAnomalie2.Cell[i,1].Text:=R502ProDtM1.tanom2riscontrate[i].ta2testo;//tdescanom2[R502ProDtM1.tanom2riscontrate[i].ta2puntdesc].D;
    end;
    //Anomalie 3 livello
    LblAnomalie3.Caption:='Anomalie 3° livello: ' + IntToStr(R502ProDtM1.n_anom3);
    GrdAnomalie3.Clear;
    GrdAnomalie3.ColumnCount:=2;
    GrdAnomalie3.RowCount:=R502ProDtM1.n_anom3 + 1;
    for i:=0 to High(R502ProDtM1.tanom3riscontrate) do
    begin
      GrdAnomalie3.Cell[i,0].Text:=IfThen(R502ProDtM1.tanom3riscontrate[i].ta3timb >= 0,R180MinutiOre(R502ProDtM1.tanom3riscontrate[i].ta3timb));
      GrdAnomalie3.Cell[i,1].Text:=R502ProDtM1.tanom3riscontrate[i].ta3testo;//tdescanom3[R502ProDtM1.tanom3riscontrate[i].ta3puntdesc].D;
    end;
    //Presenze
    LblPresenze.Caption:='Riepilogo presenze: ' + IntToStr(R502ProDtM1.n_rieppres);
    GrdPresenze.RowCount:=R502ProDtM1.n_rieppres + 1;
    GrdPresenze.ColumnCount:=R502ProDtM1.n_fasce + 2;
    GrdPresenze.Cell[0,0].Text:='Caus.';
    GrdPresenze.Cell[0,1].Text:='Raggr.';
    //display 'Caus.  Raggr.'    line rig position 1.
    for i:=1 to R502ProDtM1.n_fasce do
      GrdPresenze.Cell[0,i + 1].Text:='F.' + R502ProDtM1.tfasceorarie[i].tcodfasc;

    for i:=1 to R502ProDtM1.n_rieppres do
    begin
      GrdPresenze.Cell[i,0].Text:=R502ProDtM1.triepgiuspres[i].tcauspres;
      GrdPresenze.Cell[i,1].Text:=R502ProDtM1.triepgiuspres[i].traggpres;
      for icom:=1 to R502ProDtM1.n_fasce do
        GrdPresenze.Cell[i,icom + 1].Text:=R180MinutiOre(R502ProDtM1.triepgiuspres[i].tminpres[icom]);
    end;
    //Assenze
    LblAssenze.Caption:='Riepilogo assenze: ' + IntToStr(R502ProDtM1.n_riepasse);
    GrdAssenze.Clear;
    GrdAssenze.RowCount:=R502ProDtM1.n_riepasse + 1;
    GrdAssenze.ColumnCount:=8;
    GrdAssenze.Cell[0,0].Text:='Caus.';
    GrdAssenze.Cell[0,1].Text:='Ragg.';
    GrdAssenze.Cell[0,2].Text:='GG';
    GrdAssenze.Cell[0,3].Text:='MG';
    GrdAssenze.Cell[0,4].Text:='hhmm';
    GrdAssenze.Cell[0,5].Text:='hhmm val.';
    GrdAssenze.Cell[0,6].Text:='hhmm ass.';
    GrdAssenze.Cell[0,7].Text:='hhmm rese';
    for i:=1 to R502ProDtM1.n_riepasse do
    begin
      GrdAssenze.Cell[i,0].Text:=R502ProDtM1.triepgiusasse[i].tcausasse;
      GrdAssenze.Cell[i,1].Text:=R502ProDtM1.triepgiusasse[i].traggasse;
      GrdAssenze.Cell[i,2].Text:=IntToStr(R502ProDtM1.triepgiusasse[i].tggasse);
      GrdAssenze.Cell[i,3].Text:=IntToStr(R502ProDtM1.triepgiusasse[i].tmezggasse);
      GrdAssenze.Cell[i,4].Text:=R180MinutiOre(R502ProDtM1.triepgiusasse[i].tminasse);
      GrdAssenze.Cell[i,5].Text:=R180MinutiOre(R502ProDtM1.triepgiusasse[i].tminvalasse);
      GrdAssenze.Cell[i,6].Text:=R180MinutiOre(R502ProDtM1.triepgiusasse[i].thhmmasse);
      GrdAssenze.Cell[i,7].Text:=R180MinutiOre(R502ProDtM1.triepgiusasse[i].tminresasse);
      if R502ProDtM1.triepgiusasse[i].tfiniretr = 1 then
        GrdAssenze.Cell[i,7].Text:='Ininf.fini ret.';
    end;
  end;
end;

procedure TWA028FSc.IWAppFormDestroy(Sender: TObject);
begin
  FreeAndNil(A028FScMW);
  inherited;
end;

end.
