unit W049UCaricamentoAspettativaFM;

interface

uses
  System.SysUtils, System.Classes, WR200UBaseFM, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, Vcl.Controls, Vcl.Forms,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, IWCompEdit, IWDBStdCtrls, Strutils,
  meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompLabel, IWAppForm, WR010UBase, C180FunzioniGenerali,
  meIWLabel, meIWComboBox, DB, Oracle, OracleData, C190FunzioniGeneraliWeb, W000UMessaggi, A000UMessaggi, A000UInterfaccia,
  W049UAutocertificazioneDatiGiuridiciDM, IWCompExtCtrls, meIWImageFile, medpIWImageButton, IWCompListbox, meIWDBComboBox, meIWDBLabel, IWCompMemo, meIWDBMemo;

type
  TMyProc = procedure of object;  //Notifica di chiusura form

  TW049FCaricamentoAspettativaFM = class(TWR200FBaseFM)
    DataSourceCar: TDataSource;
    lblDataI: TmeIWLabel;
    dedtDataI: TmeIWDBEdit;
    lblDataF: TmeIWLabel;
    dedtDataF: TmeIWDBEdit;
    lblCausale: TmeIWLabel;
    dcmbCausale: TmeIWDBComboBox;
    btnConferma: TmedpIWImageButton;
    btnAnnulla: TmedpIWImageButton;
    btnModifica: TmedpIWImageButton;
    btnChiudi: TmedpIWImageButton;
    lblNote: TmeIWLabel;
    dmemNote: TmeIWDBMemo;
    procedure btnConfermaClick(Sender: TObject);
    procedure btnAnnullaClick(Sender: TObject);
    procedure btnChiudiClick(Sender: TObject);
    procedure btnModificaClick(Sender: TObject);
  private
    { Private declarations }
    procedure PreparaDCmb(pCmb: TmeIWDBComboBox; pDs: TOracleDataSet);
    procedure AbilitaComponenti;
    procedure ControllaDati;
  public
    { Public declarations }
    DataSetCar:TOracleDataSet;
    ReadOnly: Boolean;
    W049DM2:TW049FAutocertificazioneDatiGiuridiciDM;
    AzioneRichiamo:String;
    NotificaChiusura: TMyProc;
    procedure Apri;
    procedure Visualizza;
  end;

implementation

uses W049UAutocertificazioneDatiGiuridici;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}
procedure TW049FCaricamentoAspettativaFM.Apri;
begin
  DataSetCar:=W049DM2.A202MW.selT055;
  DataSourceCar.DataSet:=DataSetCar;

  if AzioneRichiamo = 'I' then
  begin
    DataSetCar.ReadOnly:=False;
    DataSetCar.Append;
  end
  else
    DataSetCar.ReadOnly:=True;

  //ImpostaValoriCombo;
  AbilitaComponenti;

  //GESTIONE CMB PART CAUSALE
  PreparaDCmb(dcmbCausale, W049DM2.A202MW.selT265);
end;

procedure TW049FCaricamentoAspettativaFM.btnAnnullaClick(Sender: TObject);
begin
  DataSetCar.Cancel;
  DataSetCar.ReadOnly:=True;
  if AzioneRichiamo = 'I' then
    btnChiudiClick(nil)
  else
    AbilitaComponenti;
end;

procedure TW049FCaricamentoAspettativaFM.ControllaDati;
var strInizio, strFine: string;
//blnCheck430: boolean;
begin
  if DataSetCar.FieldByName('DAL').IsNull then
    raise exception.Create('Data di inizio periodo non valida');

  if DataSetCar.FieldByName('AL').IsNull then
    raise exception.Create('Data di fine periodo non valida');

  if DataSetCar.FieldByName('AL').AsDateTime <= DataSetCar.FieldByName('DAL').AsDateTime then
    raise exception.Create(Format(A000MSG_A202_ERR_FMT_PERIODO,[DataSetCar.FieldByName('DAL').AsString,DataSetCar.FieldByName('AL').AsString]));

  if dcmbCausale.ItemIndex < 0 then
    raise exception.Create('Causale non valida');


  //1- Controlla assenza di intersezioni con T055
  with W049DM2.selT055Copy do
  begin
    First;
    while not Eof do
    begin
      // escludo stesso record
      if FieldByName('IDRIGA').AsString <> DataSetCar.FieldByName('IDRIGA').AsString then
      begin
        if ((DataSetCar.FieldByName('DAL').AsDateTime >= FieldByName('DAL').AsDateTime) and
            (DataSetCar.FieldByName('DAL').AsDateTime <= FieldByName('AL').AsDateTime)) or
           ((DataSetCar.FieldByName('AL').AsDateTime >= FieldByName('DAL').AsDateTime) and
            (DataSetCar.FieldByName('AL').AsDateTime <= FieldByName('AL').AsDateTime)) then
          raise exception.Create(Format(A000MSG_A202_MSG_INTERSEZIONE,[FieldByName('DAL').AsString,FieldByName('AL').AsString]));
      end;
      Next;
    end;
  end;

  //2- Controlla che non ci siano assenze T040 interne al periodo indicato
  R180SetVariable(W049DM2.selT040,'INIZIO',DataSetCar.FieldByName('DAL').AsDateTime);
  R180SetVariable(W049DM2.selT040,'FINE',DataSetCar.FieldByName('AL').AsDateTime);

  W049DM2.selT040.Open;

  if W049DM2.selT040.RecordCount > 0 then
    raise exception.Create('Nel periodo indicato sono già stati caricati ' + IntToStr(W049DM2.selT040.RecordCount) + ' giustificativi');
  W049DM2.selT040.Close;

  //3- Controlla che l'aspettativa sia interna ad uno o più periodi giuridici contigui confrondando la durata dell'aspettativa con il
  //il numero di giorni di servizio
  R180SetVariable(W049DM2.selT425T430Durata,'DAL',DataSetCar.FieldByName('DAL').AsDateTime);
  R180SetVariable(W049DM2.selT425T430Durata,'AL',DataSetCar.FieldByName('AL').AsDateTime);
  R180SetVariable(W049DM2.selT425T430Durata,'PROGRESSIVO',W049DM2.selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);

  strInizio:=IfThen(Parametri.CampiRiferimento.C22_InizioRapGiuridico <> '', Parametri.CampiRiferimento.C22_InizioRapGiuridico, 'INIZIO');
  strFine:=IfThen(Parametri.CampiRiferimento.C22_FineRapGiuridico <> '', Parametri.CampiRiferimento.C22_FineRapGiuridico, 'FINE');

  R180SetVariable(W049DM2.selT425T430Durata,'INIZIO_GIUR',strInizio);
  //R180SetVariable(W049DM2.selT425T430Durata,'FINE_GIUR',strFine);

  W049DM2.selT425T430Durata.Open;
  if W049DM2.selT425T430Durata.FieldByName('GG_SERVIZIO').AsInteger <>
      W049DM2.selT425T430Durata.FieldByName('GG_ASPETTATIVA').AsInteger then
  begin
    if Parametri.CampiRiferimento.C22_InizioRapGiuridico <> '' then
    begin
      W049DM2.selPeriodo.SetVariable('P_PROGRESSIVO',W049DM2.selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
      W049DM2.selPeriodo.SetVariable('P_DAL',DataSetCar.FieldByName('DAL').AsDateTime);
      W049DM2.selPeriodo.SetVariable('P_AL',DataSetCar.FieldByName('AL').AsDateTime);
      W049DM2.selPeriodo.SetVariable('P_INIZIOG',Parametri.CampiRiferimento.C22_InizioRapGiuridico);
      W049DM2.selPeriodo.SetVariable('P_FINEG',Parametri.CampiRiferimento.C22_FineRapGiuridico);
      W049DM2.selPeriodo.Execute;
      if W049DM2.selPeriodo.GetVariable('RESULT') <> 1 then
        raise exception.Create('L''aspettiva deve essere inclusa in un periodo giuridico caricato');
    end
    else
      raise exception.Create('L''aspettiva deve essere inclusa in un periodo giuridico caricato');
  end;

  {//3- Controlla che l'aspettativa sia interna ad un periodo della T425
  blnCheck430:=True;
  with W049DM2.A202MW.selT425 do
  begin
    First;
    while not Eof do
    begin
      if (FieldByName('INIZIO').AsDateTime <= DataSetCar.FieldByName('DAL').AsDateTime)
      and (FieldByName('FINE').AsDateTime >= DataSetCar.FieldByName('AL').AsDateTime) then
        begin
          blnCheck430:=False;
          break;
        end;
      Next;
    end;
  end;

  //4- Se non ha trovato un periodo che includa l'aspettativa nella T425 controlla nella T030
  if blnCheck430 then
  begin
    if Parametri.CampiRiferimento.C22_InizioRapGiuridico <> '' then
    begin
      strInizio:='INIZIO_RAPGIUR';
      strFine:='FINE_RAPGIUR';
    end
    else
    begin
      strInizio:='INIZIO';
      strFine:='FINE';
    end;

    with W049DM2.A202MW.selT430 do
    begin
      First;
      while not Eof do
      begin
        if (FieldByName(strInizio).AsDateTime <= DataSetCar.FieldByName('DAL').AsDateTime)
        and (FieldByName(strFine).AsDateTime >= DataSetCar.FieldByName('AL').AsDateTime) then
        begin
          blnCheck430:=False;
          break;
        end;
        Next;
      end;
    end;
  end;

  if blnCheck430 then
    raise exception.Create('L''aspettiva deve essere inclusa in un periodo giuridico caricato');}
end;

procedure TW049FCaricamentoAspettativaFM.btnConfermaClick(Sender: TObject);
begin
  ControllaDati;
  DataSetCar.Post;
  DataSetCar.ReadOnly:=True;
  if AzioneRichiamo = 'I' then
    btnChiudiClick(nil)
  else
    AbilitaComponenti;
end;

procedure TW049FCaricamentoAspettativaFM.btnModificaClick(Sender: TObject);
begin
  DataSetCar.ReadOnly:=False;
  DataSetCar.Edit;
  AbilitaComponenti;
end;

procedure TW049FCaricamentoAspettativaFM.btnChiudiClick(Sender: TObject);
begin
  if Assigned(NotificaChiusura) then
    NotificaChiusura;
  Free;
end;

procedure TW049FCaricamentoAspettativaFM.AbilitaComponenti;
var i: Integer;
    StatoInsMod: Boolean;
begin
  StatoInsMod:=not DataSetCar.ReadOnly;
  for i:=0 to self.ComponentCount-1 do
  begin
    if Components[i] is TmeIWDBEdit then
      TmeIWDBEdit(Components[i]).Enabled:=StatoInsMod
    else if Components[i] is TmeIWComboBox then
      TmeIWComboBox(Components[i]).Enabled:=StatoInsMod
    else if Components[i] is TmeIWDBComboBox then
      TmeIWDBComboBox(Components[i]).Enabled:=StatoInsMod
    else if Components[i] is TmeIWDBMemo then
      TmeIWDBMemo(Components[i]).Enabled:=StatoInsMod;
  end;

  btnModifica.Visible:=(not StatoInsMod) and (AzioneRichiamo <> 'L');
  btnChiudi.Visible:=not StatoInsMod;
  btnConferma.Visible:=StatoInsMod;
  btnAnnulla.Visible:=StatoInsMod;
end;

procedure TW049FCaricamentoAspettativaFM.PreparaDCmb(pCmb: TmeIWDBComboBox; pDs: TOracleDataSet);
var strField: string;
    i: integer;
    lbl: TmeIWLabel;
    dedt: TmeIWDBEdit;
begin
  strField:=pCmb.DataField;
  lbl:=nil;
  dedt:=nil;

  //cerca lbl associata per nome
  for i:=0 to self.ComponentCount-1 do
  begin
    if Components[i] is TmeIWLabel then
      if Uppercase(Components[i].Name).IndexOf(strField) > 0 then
      begin
        lbl:=TmeIWLabel(Components[i]);
        break;
      end;
  end;

  //cerca edt associato per datafield
  for i:=0 to self.ComponentCount-1 do
  begin
    if Components[i] is TmeIWDBEdit then
      if TmeIWDBEdit(Components[i]).DataField=pCmb.DataField then
      begin
        dedt:=TmeIWDBEdit(Components[i]);
        break;
      end;
  end;

  if DataSetCar.FieldByName('d_' + strField).Visible then
  begin
    if assigned(lbl) then
      lbl.Visible:=True;

    if assigned(dedt) then
    begin
      dedt.DataField:='';
      dedt.DataSource:=nil;
      dedt.Visible:=False;
    end;

    pCmb.Visible:=True;
    pCmb.Items.Clear;
    //pCmb.Items.Add('' + '=' + '');
    with pDs do
    begin
      first;
      for i:=0 to RecordCount-1 do
      begin
        pCmb.Items.Add(FieldByName('DESCRIZIONE').AsString + '=' + FieldByName('CODICE').AsString);
        Next;
      end;
    end;
    pCmb.ItemIndex:=0;
  end
  else
  begin
    pCmb.DataField:='';
    pCmb.DataSource:=nil;
    pCmb.Visible:=False;

    if (assigned(lbl)) and (not assigned(dedt)) then
      lbl.Visible:=False;

    if assigned(dedt) then
      dedt.Visible:=True;
  end;
end;

procedure TW049FCaricamentoAspettativaFM.Visualizza;
var Titolo:String;
begin
  Titolo:=IfThen(DataSetCar.State = dsInsert,'Inserimento',IfThen(DataSetCar.State = dsEdit,'Modifica','Visualizzazione'))
          + ' aspettativa';
  (Self.Parent as TWR010FBase).VisualizzajQMessaggio(JQuery,440,-1,EM2PIXEL * 24,Titolo,'#' + Self.Name,False,True);
end;

end.
