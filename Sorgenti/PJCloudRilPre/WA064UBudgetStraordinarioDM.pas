unit WA064UBudgetStraordinarioDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR303UGestMasterDetailDM, Data.DB, medpIWMessageDlg,
  OracleData, A000UInterfaccia, A000UMessaggi, A000USessione, A064UBudgetStraordinarioMW, C180FunzioniGenerali;

type
  T063FBudget = procedure(Gruppo,Tipo: string; Decorrenza: TDateTime) of object;

  TWA064FBudgetStraordinarioDM = class(TWR303FGestMasterDetailDM)
    selT714: TOracleDataSet;
    selT714CODGRUPPO: TStringField;
    selT714TIPO: TStringField;
    selT714DECORRENZA: TDateTimeField;
    selT714MESE: TFloatField;
    selT714ORE_AUTO: TStringField;
    selT714ORE: TStringField;
    selT714ORE_FRUITO: TStringField;
    selT714ORE_RESIDUO_AUTO: TStringField;
    selT714ORE_RESIDUO: TStringField;
    selT714IMPORTO_AUTO: TFloatField;
    selT714IMPORTO: TFloatField;
    selT714IMPORTO_FRUITO: TFloatField;
    selT714IMPORTO_RESIDUO_AUTO: TFloatField;
    selT714IMPORTO_RESIDUO: TFloatField;
    dsrT714: TDataSource;
    selTabellaCODGRUPPO: TStringField;
    selTabellaTIPO: TStringField;
    selTabellaDECORRENZA: TDateTimeField;
    selTabellaDECORRENZA_FINE: TDateTimeField;
    selTabellaANNO: TFloatField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaFILTRO_ANAGRAFE: TStringField;
    selTabellaORE: TStringField;
    selTabellaIMPORTO: TFloatField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure AfterPost(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure AfterDelete(DataSet: TDataSet); override;
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure AfterCancel(DataSet: TDataSet); override;
    procedure selTabellaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selTabellaCODGRUPPOValidate(Sender: TField);
    procedure selTabellaDECORRENZAValidate(Sender: TField);
    procedure selTabellaDECORRENZA_FINEValidate(Sender: TField);
    procedure selTabellaFILTRO_ANAGRAFEValidate(Sender: TField);
    procedure selT714BeforeInsert(DataSet: TDataSet);
    procedure selT714BeforeDelete(DataSet: TDataSet);
    procedure selT714BeforePost(DataSet: TDataSet);
    procedure selT714AfterPost(DataSet: TDataSet);
    procedure selT714CalcFields(DataSet: TDataSet);
    procedure dsrTabellaStateChange(Sender: TObject);
  private
    { Private declarations }
    procedure evtRichiesta(Msg,Chiave:String);
    procedure ResultEvtRichiesta(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure evtMessaggio(Msg,Chiave:String);
  public
    { Public declarations }
    A064MW: TA064FBudgetStraordinarioMW;
    CallT063: T063FBudget;
    procedure RelazionaTabelleFiglie; override;
    procedure CaricaListaAnni(AnnoNew:String);
  end;

implementation

uses WA064UBudgetStraordinario, WA064UBudgetStraordinarioDettFM;

{$R *.dfm}

procedure TWA064FBudgetStraordinarioDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY T713.CODGRUPPO, T713.DECORRENZA, T713.TIPO');
  selT714.SetVariable('ORDERBY','ORDER BY T714.MESE');
  A064MW:=TA064FBudgetStraordinarioMW.Create(Self);
  A064MW.selT713:=selTabella;
  A064MW.selT714:=selT714;
  A064MW.evtRichiesta:=evtRichiesta;
  A064MW.evtMessaggio:=evtMessaggio;
  //A064MW.evtAumentaProgressBar:=evtAumentaProgressBar;
  selT714ORE.OnValidate:=A064MW.selT714OREValidate;
  inherited;
  selT714.Open;
  SetTabelleRelazionate([selTabella,selT714]);
  CaricaListaAnni(IntToStr(R180Anno(Parametri.DataLavoro)));
end;

procedure TWA064FBudgetStraordinarioDM.RelazionaTabelleFiglie;
begin
  inherited;
  selT714.DisableControls;
  A064MW.AperturaDettaglio;
  selT714.EnableControls;
end;

procedure TWA064FBudgetStraordinarioDM.CaricaListaAnni(AnnoNew:String);
var i:Integer;
  AnnoOld:String;
begin
  with (Self.Owner as TWA064FBudgetStraordinario) do
  begin
    AnnoOld:=cmbFiltroAnno.Text;
    cmbFiltroAnno.Items.Clear;
    A064MW.seleT713.Close;
    A064MW.seleT713.Open;
    while not A064MW.seleT713.Eof do
    begin
      cmbFiltroAnno.Items.Add(A064MW.seleT713.FieldByName('ANNO').AsString);
      A064MW.seleT713.Next;
    end;
    for i:=0 to cmbFiltroAnno.Items.Count - 1 do
      if cmbFiltroAnno.Items[i] = AnnoNew then
        cmbFiltroAnno.ItemIndex:=i;
    if (cmbFiltroAnno.ItemIndex = -1)
    and (cmbFiltroAnno.Items.Count > 0) then
    begin
      cmbFiltroAnno.ItemIndex:=0;
      AnnoNew:=cmbFiltroAnno.Text;
    end;
    if AnnoOld <> AnnoNew then
      cmbFiltroAnnoChange(nil);
  end;
end;

procedure TWA064FBudgetStraordinarioDM.dsrTabellaStateChange(Sender: TObject);
begin
  inherited;
  if (Self.Owner as TWA064FBudgetStraordinario).WDettaglioFM <> nil then
    with (Self.Owner as TWA064FBudgetStraordinario),(WDettaglioFM as TWA064FBudgetStraordinarioDettFM) do
    begin
      dedtAnno.ReadOnly:=not (dsrTabella.State in [dsInsert]);
      cmbDalMese.Enabled:=dsrTabella.State in [dsEdit,dsInsert];
      cmbAlMese.Enabled:=dsrTabella.State in [dsEdit,dsInsert];
      with A064MW do
      begin
        if dsrTabella.State in [dsEdit] then
        begin
          DecIniOld:=selT713.FieldByName('DECORRENZA').AsDateTime;
          DecFinOld:=selT713.FieldByName('DECORRENZA_FINE').AsDateTime;
        end;
        selT713.FieldByName('CODGRUPPO').ReadOnly:=not (dsrTabella.State in [dsInsert]);
        selT713.FieldByName('TIPO').ReadOnly:=not (dsrTabella.State in [dsInsert]);
        selT713.FieldByName('DECORRENZA').ReadOnly:=not (dsrTabella.State in [dsInsert]);
        selT713.FieldByName('DECORRENZA_FINE').ReadOnly:=not (dsrTabella.State in [dsInsert]);
      end;
      AbilitaAzioni;
    end;
end;

procedure TWA064FBudgetStraordinarioDM.BeforePostNoStorico(DataSet: TDataSet);
var i:Integer;
begin
  with A064MW do
  begin
    bFiltroAnnoDisallineato:=False;
    if Trim(selT713.FieldByName('ANNO').AsString) <> '' then
      for i:=0 to (Self.Owner as TWA064FBudgetStraordinario).cmbFiltroAnno.Items.Count - 1 do
        if (Trim(selT713.FieldByName('ANNO').AsString) = (Self.Owner as TWA064FBudgetStraordinario).cmbFiltroAnno.Items[i])
        and ((Self.Owner as TWA064FBudgetStraordinario).cmbFiltroAnno.Text <> (Self.Owner as TWA064FBudgetStraordinario).cmbFiltroAnno.Items[i]) then
          bFiltroAnnoDisallineato:=True;
    if (not AggiornaPeriodo) and (not AggiornaFA) and (not AggiornaOre) and (not AggiornaImp) then
      selT713BeforePostNoStoricoInizio;
    try
      (*TODO
      Screen.Cursor:=crHourGlass;
      (Self.Owner as TWA064FBudgetStraordinario).ProgressBar1.Max:=7;
      (Self.Owner as TWA064FBudgetStraordinario).StatusBar.Panels[2].Text:=A000MSG_MSG_SALVATAGGIO_IN_CORSO;
      (Self.Owner as TWA064FBudgetStraordinario).StatusBar.Repaint;*)
      selT713BeforePostNoStoricoSalvaPrima;
      inherited;
      selT713BeforePostNoStoricoSalvaDopo;
    finally
      (*TODO
      Screen.Cursor:=crDefault;
      (Self.Owner as TWA064FBudgetStraordinario).ProgressBar1.Position:=0;
      (Self.Owner as TWA064FBudgetStraordinario).StatusBar.Panels[2].Text:='';
      (Self.Owner as TWA064FBudgetStraordinario).StatusBar.Repaint;*)
    end;
    selT713BeforePostNoStoricoFine;
  end;
end;

procedure TWA064FBudgetStraordinarioDM.AfterPost(DataSet: TDataSet);
var i:Integer;
begin
  with A064MW do
  begin
    delT715.SetVariable('CODGRUPPO',selT713.FieldByName('CODGRUPPO').AsString);
    delT715.SetVariable('TIPO',selT713.FieldByName('TIPO').AsString);
    delT715.SetVariable('DECORRENZA',selT713.FieldByName('DECORRENZA').AsDateTime);
    delT715.Execute;

    insT715.SetVariable('CODGRUPPO',selT713.FieldByName('CODGRUPPO').AsString);
    insT715.SetVariable('TIPO',selT713.FieldByName('TIPO').AsString);
    insT715.SetVariable('DECORRENZA',selT713.FieldByName('DECORRENZA').AsDateTime);
    insT715.SetVariable('AUTORIZZATORE','N');
    for i:=0 to lstOperatoriSel.Count-1 do
    begin
      insT715.SetVariable('PROGRESSIVO',lstOperatoriSel.Strings[i]);
      insT715.Execute;
    end;
    insT715.SetVariable('AUTORIZZATORE','S');
    for i:=0 to lstAutorizzatoriSel.Count - 1 do
    begin
      insT715.SetVariable('PROGRESSIVO',lstAutorizzatoriSel.Strings[i]);
      insT715.Execute;
    end;

    if Assigned((Self.Owner as TWA064FBudgetStraordinario).WDettaglioFM) then
    begin
      ResponsabileAutorizzatore:=False;
      ((Self.Owner as TWA064FBudgetStraordinario).WDettaglioFM as TWA064FBudgetStraordinarioDettFM).edtOperatori.Text:=CaricaOperatori;
      ResponsabileAutorizzatore:=True;
      ((Self.Owner as TWA064FBudgetStraordinario).WDettaglioFM as TWA064FBudgetStraordinarioDettFM).edtAutorizzatori.Text:=CaricaOperatori;
    end;
  end;
  inherited;
  CaricaListaAnni(IntToStr(A064MW.wAnno));

  A064MW.selT713AfterPost;

  A064MW.AggiornaPeriodo:=False;
  A064MW.AggiornaFA:=False;
  A064MW.AggiornaOre:=False;
  A064MW.AggiornaImp:=False;
end;

procedure TWA064FBudgetStraordinarioDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  A064MW.selT713BeforeDelete;
end;

procedure TWA064FBudgetStraordinarioDM.AfterDelete(DataSet: TDataSet);
begin
  CaricaListaAnni(IntToStr(A064MW.wAnno));
  A064MW.selT713AfterDelete;
end;

procedure TWA064FBudgetStraordinarioDM.AfterScroll(DataSet: TDataSet);
begin
  inherited;
  if (Self.Owner as TWA064FBudgetStraordinario).WDettaglioFM = nil then
    exit;
  with TWA064FBudgetStraordinarioDettFM(TWA064FBudgetStraordinario(Self.Owner).WDettaglioFM) do
  begin
    cmbDalMese.ItemIndex:=cmbDalMese.Items.IndexOf(R180NomeMese(R180Mese(A064MW.selT713.FieldByName('DECORRENZA').AsDateTime)));
    cmbAlMese.ItemIndex:=cmbAlMese.Items.IndexOf(R180NomeMese(R180Mese(A064MW.selT713.FieldByName('DECORRENZA_FINE').AsDateTime)));
    A064MW.selT713AfterScroll;
    btnDipendenti.Enabled:=A064MW.selT713.FieldByName('FILTRO_ANAGRAFE').AsString <> '';
  end;
  TWA064FBudgetStraordinario(Self.Owner).AbilitaAzioni;
  A064MW.ResponsabileAutorizzatore:=False;
  TWA064FBudgetStraordinarioDettFM(TWA064FBudgetStraordinario(Self.Owner).WDettaglioFM).edtOperatori.Text:=A064MW.CaricaOperatori;
  A064MW.ResponsabileAutorizzatore:=True;
  TWA064FBudgetStraordinarioDettFM(TWA064FBudgetStraordinario(Self.Owner).WDettaglioFM).edtAutorizzatori.Text:=A064MW.CaricaOperatori;
end;

procedure TWA064FBudgetStraordinarioDM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  A064MW.selT713NewRecord((Self.Owner as TWA064FBudgetStraordinario).cmbFiltroAnno.Text);
end;

procedure TWA064FBudgetStraordinarioDM.AfterCancel(DataSet: TDataSet);
begin
  inherited;
  with ((Self.Owner as TWA064FBudgetStraordinario).WDettaglioFM as TWA064FBudgetStraordinarioDettFM) do
  begin
    cmbDalMese.ItemIndex:=cmbDalMese.Items.IndexOf(R180NomeMese(R180Mese(A064MW.selT713.FieldByName('DECORRENZA').AsDateTime)));
    cmbAlMese.ItemIndex:=cmbAlMese.Items.IndexOf(R180NomeMese(R180Mese(A064MW.selT713.FieldByName('DECORRENZA_FINE').AsDateTime)));
    btnDipendenti.Enabled:=A064MW.selT713.FieldByName('FILTRO_ANAGRAFE').AsString <> '';
  end;
  A064MW.selT713AfterCancel;
  A064MW.ResponsabileAutorizzatore:=False;
  TWA064FBudgetStraordinarioDettFM(TWA064FBudgetStraordinario(Self.Owner).WDettaglioFM).edtOperatori.Text:=A064MW.CaricaOperatori;
  A064MW.ResponsabileAutorizzatore:=True;
  TWA064FBudgetStraordinarioDettFM(TWA064FBudgetStraordinario(Self.Owner).WDettaglioFM).edtAutorizzatori.Text:=A064MW.CaricaOperatori;
end;

procedure TWA064FBudgetStraordinarioDM.selTabellaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
  A064MW.selT713FilterRecord(Accept);
end;

procedure TWA064FBudgetStraordinarioDM.selTabellaCODGRUPPOValidate(Sender: TField);
begin
  inherited;
  A064MW.selT713CODGRUPPOValidate;
end;

procedure TWA064FBudgetStraordinarioDM.selTabellaDECORRENZAValidate(Sender: TField);
begin
  inherited;
  A064MW.selT713DECORRENZAValidate;
end;

procedure TWA064FBudgetStraordinarioDM.selTabellaDECORRENZA_FINEValidate(Sender: TField);
begin
  inherited;
  A064MW.selT713DECORRENZA_FINEValidate;
end;

procedure TWA064FBudgetStraordinarioDM.selTabellaFILTRO_ANAGRAFEValidate(Sender: TField);
begin
  inherited;
  ((Self.Owner as TWA064FBudgetStraordinario).WDettaglioFM as TWA064FBudgetStraordinarioDettFM).btnDipendenti.Enabled:=A064MW.selT713FILTRO_ANAGRAFEValidate;
end;

procedure TWA064FBudgetStraordinarioDM.selT714BeforeInsert(DataSet: TDataSet);
begin
  inherited;
  A064MW.selT714BeforeInsert;
end;

procedure TWA064FBudgetStraordinarioDM.selT714BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  A064MW.selT714BeforeDelete;
end;

procedure TWA064FBudgetStraordinarioDM.selT714BeforePost(DataSet: TDataSet);
begin
  inherited;
  A064MW.selT714BeforePost;
end;

procedure TWA064FBudgetStraordinarioDM.selT714AfterPost(DataSet: TDataSet);
begin
  with selT714 do
    try
      AfterPost:=nil;
      BeforePost:=nil;
      A064MW.selT714AfterPost;
      if A064MW.A064MWMsg <> '' then
      begin
        MsgBox.WebMessageDlg(A064MW.A064MWMsg,mtInformation,[mbOk],nil,'');
        A064MW.A064MWMsg:='';
      end;
    finally
      AfterPost:=selT714AfterPost;
      BeforePost:=selT714BeforePost;
    end;
end;

procedure TWA064FBudgetStraordinarioDM.selT714CalcFields(DataSet: TDataSet);
begin
  A064MW.selT714CalcFields;
end;

procedure TWA064FBudgetStraordinarioDM.ResultEvtRichiesta(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R <> mrYes then
  begin
    if KI = 'RichiamoA063' then
      evtMessaggio(A000MSG_A064_MSG_CONTROLLO_FA_MANUALE,KI)
    else
      abort;
  end
  else if KI = 'RichiamoA063' then
  begin
    if assigned(CallT063) then
      CallT063(selTabella.FieldByName('CODGRUPPO').AsString,selTabella.FieldByName('TIPO').AsString,selTabella.FieldByName('DECORRENZA').AsDateTime);
  end
  else if KI = 'Aggiornamenti' then
  begin
    A064MW.CaricaAggiornamenti;
    selTabella.Post;
  end
  else if KI = 'FADiversiTipiGruppo' then
    A064MW.AggiornaFA:=True
  else if KI = 'PeriodiDiversiTipiGruppo' then
  begin
    A064MW.AllineaDecorrenze;
    A064MW.AggiornaPeriodo:=True;
  end
  else if KI = 'PeriodoModificato' then
    A064MW.AggiornaPeriodo:=True;
end;

procedure TWA064FBudgetStraordinarioDM.evtRichiesta(Msg,Chiave:String);
begin
  if not MsgBox.KeyExists(Chiave) then
  begin
    MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultEvtRichiesta,Chiave);
    if Chiave = 'Aggiornamenti' then
      abort;
  end;
(*TODO
  if R180MessageBox(Msg,'DOMANDA') <> mrYes then
  begin
    if Chiave = 'RichiamoA063' then
      evtMessaggio(A000MSG_A064_MSG_CONTROLLO_FA_MANUALE,Chiave)
    else
      abort;
  end
  else if Chiave = 'RichiamoA063' then
  begin
    evtMessaggio(A000MSG_A064_MSG_CONTROLLO_FA_AUTOMATICO,Chiave);
    A064FBudgetStraordinario.actAccediAllineamentoBudgetExecute(nil);
  end
  else if Chiave = 'Aggiornamenti' then
    A064MW.CaricaAggiornamenti
  else if Chiave = 'FADiversiTipiGruppo' then
    A064MW.AggiornaFA:=True
  else if Chiave = 'PeriodiDiversiTipiGruppo' then
  begin
    A064MW.AllineaDecorrenze;
    A064MW.AggiornaPeriodo:=True;
  end
  else if Chiave = 'PeriodoModificato' then
    A064MW.AggiornaPeriodo:=True;*)
end;

procedure TWA064FBudgetStraordinarioDM.evtMessaggio(Msg,Chiave:String);
begin
  MsgBox.WebMessageDlg(Msg,mtInformation,[mbOk],nil,'');
end;

end.
