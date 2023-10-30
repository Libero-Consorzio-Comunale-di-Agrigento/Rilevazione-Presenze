unit A064UBudgetStraordinarioDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  CheckLst, Dialogs, DB, OracleData, Oracle, StrUtils, Math,
  R004UGESTSTORICODTM, C180FunzioniGenerali, A064UBudgetStraordinarioMW,
  A000UCostanti, A000UInterfaccia, A000UMessaggi, A000USessione;

type
  TA064FBudgetStraordinarioDtM = class(TR004FGestStoricoDtM)
    selT713: TOracleDataSet;
    selT714: TOracleDataSet;
    dsrT714: TDataSource;
    selT713CODGRUPPO: TStringField;
    selT713DESCRIZIONE: TStringField;
    selT713FILTRO_ANAGRAFE: TStringField;
    selT713TIPO: TStringField;
    selT713ANNO: TFloatField;
    selT713DECORRENZA: TDateTimeField;
    selT713DECORRENZA_FINE: TDateTimeField;
    selT713ORE: TStringField;
    selT713IMPORTO: TFloatField;
    selT714CODGRUPPO: TStringField;
    selT714TIPO: TStringField;
    selT714DECORRENZA: TDateTimeField;
    selT714MESE: TFloatField;
    selT714ORE: TStringField;
    selT714IMPORTO: TFloatField;
    selT714ORE_FRUITO: TStringField;
    selT714IMPORTO_FRUITO: TFloatField;
    selT714ORE_AUTO: TStringField;
    selT714IMPORTO_AUTO: TFloatField;
    selT714ORE_RESIDUO: TStringField;
    selT714IMPORTO_RESIDUO: TFloatField;
    selT714ORE_RESIDUO_AUTO: TStringField;
    selT714IMPORTO_RESIDUO_AUTO: TFloatField;
    procedure DataModuleCreate(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure AfterPost(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure AfterDelete(DataSet: TDataSet); override;
    procedure selT713AfterScroll(DataSet: TDataSet);
    procedure selT713NewRecord(DataSet: TDataSet);
    procedure selT713AfterCancel(DataSet: TDataSet);
    procedure selT713FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selT713CODGRUPPOValidate(Sender: TField);
    procedure selT713DECORRENZAValidate(Sender: TField);
    procedure selT713DECORRENZA_FINEValidate(Sender: TField);
    procedure selT713FILTRO_ANAGRAFEValidate(Sender: TField);
    procedure selT714BeforeInsert(DataSet: TDataSet);
    procedure selT714BeforeDelete(DataSet: TDataSet);
    procedure selT714BeforePost(DataSet: TDataSet);
    procedure selT714AfterPost(DataSet: TDataSet);
    procedure selT714CalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    procedure evtRichiesta(Msg,Chiave:String);
    procedure evtMessaggio(Msg,Chiave:String);
    procedure evtAumentaProgressBar;
  public
    { Public declarations }
    A064MW: TA064FBudgetStraordinarioMW;
    procedure CaricaListaAnni(AnnoNew:String);
  end;

var
  A064FBudgetStraordinarioDtM: TA064FBudgetStraordinarioDtM;

implementation

uses A064UBudgetStraordinario;

{$R *.dfm}

procedure TA064FBudgetStraordinarioDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  A064FBudgetStraordinario.DButton.DataSet:=selT713;
  InizializzaDataSet(selT713,[evBeforePostNoStorico,
                              evBeforeDelete,
                              evBeforeInsert,
                              evAfterDelete,
                              evAfterPost]);
  InterfacciaR004.LChiavePrimaria.Add('DECORRENZA');
  selT713.Filtered:=Trim(Parametri.Inibizioni.Text) <> '';
  A064MW:=TA064FBudgetStraordinarioMW.Create(Self);
  A064MW.selT713:=selT713;
  A064MW.selT714:=selT714;
  selT714ORE.OnValidate:=A064MW.selT714OREValidate;
  A064MW.evtRichiesta:=evtRichiesta;
  A064MW.evtMessaggio:=evtMessaggio;
  A064MW.evtAumentaProgressBar:=evtAumentaProgressBar;
  CaricaListaAnni(IntToStr(R180Anno(Parametri.DataLavoro)));
end;

procedure TA064FBudgetStraordinarioDtM.CaricaListaAnni(AnnoNew:String);
var i:Integer;
  AnnoOld:String;
begin
  with A064FBudgetStraordinario do
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

procedure TA064FBudgetStraordinarioDtM.BeforePostNoStorico(DataSet: TDataSet);
var
  i:Integer;
begin
  with A064MW do
  begin
    bFiltroAnnoDisallineato:=False;
    if Trim(selT713.FieldByName('ANNO').AsString) <> '' then
      for i:=0 to A064FBudgetStraordinario.cmbFiltroAnno.Items.Count - 1 do
        if (Trim(selT713.FieldByName('ANNO').AsString) = A064FBudgetStraordinario.cmbFiltroAnno.Items[i])
        and (A064FBudgetStraordinario.cmbFiltroAnno.Text <> A064FBudgetStraordinario.cmbFiltroAnno.Items[i]) then
          bFiltroAnnoDisallineato:=True;
    selT713BeforePostNoStoricoInizio;
    try
      Screen.Cursor:=crHourGlass;
      A064FBudgetStraordinario.ProgressBar1.Max:=7;
      A064FBudgetStraordinario.StatusBar.Panels[2].Text:=A000MSG_MSG_SALVATAGGIO_IN_CORSO;
      A064FBudgetStraordinario.StatusBar.Repaint;
      selT713BeforePostNoStoricoSalvaPrima;
      inherited;
      selT713BeforePostNoStoricoSalvaDopo;
    finally
      Screen.Cursor:=crDefault;
      A064FBudgetStraordinario.ProgressBar1.Position:=0;
      A064FBudgetStraordinario.StatusBar.Panels[2].Text:='';
      A064FBudgetStraordinario.StatusBar.Repaint;
    end;
    selT713BeforePostNoStoricoFine;
  end;
end;

procedure TA064FBudgetStraordinarioDtM.AfterPost(DataSet: TDataSet);
var
  i:Integer;
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
    for i:=0 to lstOperatoriSel.Count - 1 do
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
    A064FBudgetStraordinarioDtM.A064MW.ResponsabileAutorizzatore:=False;
    A064FBudgetStraordinario.edtOperatori.Text:=CaricaOperatori;
    A064FBudgetStraordinarioDtM.A064MW.ResponsabileAutorizzatore:=True;
    A064FBudgetStraordinario.edtAutorizzatori.Text:=CaricaOperatori;
  end;
  inherited;
  CaricaListaAnni(IntToStr(A064MW.wAnno));
  A064MW.selT713AfterPost;
end;

procedure TA064FBudgetStraordinarioDtM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  A064MW.selT713BeforeDelete;
end;

procedure TA064FBudgetStraordinarioDtM.AfterDelete(DataSet: TDataSet);
begin
  CaricaListaAnni(IntToStr(A064MW.wAnno));
  A064MW.selT713AfterDelete;
end;

procedure TA064FBudgetStraordinarioDtM.selT713AfterScroll(DataSet: TDataSet);
begin
  inherited;
  A064FBudgetStraordinario.cmbDalMese.Text:=IntToStr(R180Mese(selT713.FieldByName('DECORRENZA').AsDateTime));
  A064FBudgetStraordinario.cmbAlMese.Text:=IntToStr(R180Mese(selT713.FieldByName('DECORRENZA_FINE').AsDateTime));
  A064MW.selT713AfterScroll;
  A064FBudgetStraordinario.btnDipendenti.Enabled:=selT713.FieldByName('FILTRO_ANAGRAFE').AsString <> '';
  A064FBudgetStraordinario.AbilitaAzioni;
  A064FBudgetStraordinarioDtM.A064MW.ResponsabileAutorizzatore:=False;
  A064FBudgetStraordinario.edtOperatori.Text:=A064MW.CaricaOperatori;
  A064FBudgetStraordinarioDtM.A064MW.ResponsabileAutorizzatore:=True;
  A064FBudgetStraordinario.edtAutorizzatori.Text:=A064MW.CaricaOperatori;
end;



procedure TA064FBudgetStraordinarioDtM.selT713NewRecord(DataSet: TDataSet);
begin
  inherited;
  A064MW.selT713NewRecord(A064FBudgetStraordinario.cmbFiltroAnno.Text);
end;

procedure TA064FBudgetStraordinarioDtM.selT713AfterCancel(DataSet: TDataSet);
begin
  inherited;
  A064FBudgetStraordinario.cmbDalMese.Text:=IntToStr(R180Mese(selT713.FieldByName('DECORRENZA').AsDateTime));
  A064FBudgetStraordinario.cmbAlMese.Text:=IntToStr(R180Mese(selT713.FieldByName('DECORRENZA_FINE').AsDateTime));
  A064FBudgetStraordinario.btnDipendenti.Enabled:=selT713.FieldByName('FILTRO_ANAGRAFE').AsString <> '';
  A064MW.selT713AfterCancel;
  A064FBudgetStraordinarioDtM.A064MW.ResponsabileAutorizzatore:=False;
  A064FBudgetStraordinario.edtOperatori.Text:=A064MW.CaricaOperatori;
  A064FBudgetStraordinarioDtM.A064MW.ResponsabileAutorizzatore:=True;
  A064FBudgetStraordinario.edtAutorizzatori.Text:=A064MW.CaricaOperatori;
end;

procedure TA064FBudgetStraordinarioDtM.selT713FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
  A064MW.selT713FilterRecord(Accept);
end;

procedure TA064FBudgetStraordinarioDtM.selT713CODGRUPPOValidate(Sender: TField);
begin
  inherited;
  A064MW.selT713CODGRUPPOValidate;
end;

procedure TA064FBudgetStraordinarioDtM.selT713DECORRENZAValidate(Sender: TField);
begin
  inherited;
  A064MW.selT713DECORRENZAValidate;
end;

procedure TA064FBudgetStraordinarioDtM.selT713DECORRENZA_FINEValidate(Sender: TField);
begin
  inherited;
  A064MW.selT713DECORRENZA_FINEValidate;
end;

procedure TA064FBudgetStraordinarioDtM.selT713FILTRO_ANAGRAFEValidate(Sender: TField);
begin
  inherited;
  A064FBudgetStraordinario.btnDipendenti.Enabled:=A064MW.selT713FILTRO_ANAGRAFEValidate;
end;

procedure TA064FBudgetStraordinarioDtM.selT714BeforeInsert(DataSet: TDataSet);
begin
  inherited;
  A064MW.selT714BeforeInsert;
end;

procedure TA064FBudgetStraordinarioDtM.selT714BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  A064MW.selT714BeforeDelete;
end;

procedure TA064FBudgetStraordinarioDtM.selT714BeforePost(DataSet: TDataSet);
begin
  inherited;
  A064MW.selT714BeforePost;
end;

procedure TA064FBudgetStraordinarioDtM.selT714AfterPost(DataSet: TDataSet);
begin
  with selT714 do
    try
      AfterPost:=nil;
      BeforePost:=nil;
      A064MW.selT714AfterPost;
      if A064MW.A064MWMsg <> '' then
      begin
        ShowMessage(A064MW.A064MWMsg);
        A064MW.A064MWMsg:='';
      end;
    finally
      AfterPost:=selT714AfterPost;
      BeforePost:=selT714BeforePost;
    end;
end;

procedure TA064FBudgetStraordinarioDtM.selT714CalcFields(DataSet: TDataSet);
begin
  A064MW.selT714CalcFields;
end;

procedure TA064FBudgetStraordinarioDtM.evtRichiesta(Msg,Chiave:String);
begin
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
    A064MW.AggiornaPeriodo:=True;
end;

procedure TA064FBudgetStraordinarioDtM.evtMessaggio(Msg,Chiave:String);
begin
  ShowMessage(Msg);
end;

procedure TA064FBudgetStraordinarioDtM.evtAumentaProgressBar;
begin
  A064FBudgetStraordinario.ProgressBar1.StepBy(1);
end;

end.
