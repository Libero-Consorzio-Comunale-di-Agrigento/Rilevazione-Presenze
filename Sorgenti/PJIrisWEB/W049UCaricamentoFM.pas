unit W049UCaricamentoFM;

interface

uses
  System.SysUtils, System.Classes, WR200UBaseFM, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, Vcl.Controls, Vcl.Forms,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, IWCompEdit, IWDBStdCtrls, Strutils,
  meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompLabel, IWAppForm, WR010UBase,
  meIWLabel, meIWComboBox, DB, Oracle, OracleData, C190FunzioniGeneraliWeb, W000UMessaggi, A000UInterfaccia, C180FunzioniGenerali,
  W049UAutocertificazioneDatiGiuridiciDM, IWCompExtCtrls, meIWImageFile, medpIWImageButton, IWCompListbox, meIWDBComboBox, meIWDBLabel, IWCompMemo, meIWDBMemo;

type
  TMyProc = procedure of object;  //Notifica di chiusura form

  TW049FCaricamentoFM = class(TWR200FBaseFM)
    lblAzienda: TmeIWLabel;
    dedtAzienda: TmeIWDBEdit;
    DataSourceCar: TDataSource;
    lblDataI: TmeIWLabel;
    dedtDataI: TmeIWDBEdit;
    lblDataF: TmeIWLabel;
    dedtDataF: TmeIWDBEdit;
    lblQualifica: TmeIWLabel;
    lblDisciplina: TmeIWLabel;
    lblPRapporto: TmeIWLabel;
    lblRapporto: TmeIWLabel;
    dcmbParttime: TmeIWDBComboBox;
    btnChiudi: TmedpIWImageButton;
    btnAnnulla: TmedpIWImageButton;
    btnConferma: TmedpIWImageButton;
    btnModifica: TmedpIWImageButton;
    lblParttime: TmeIWLabel;
    dlblTipoParttime: TmeIWDBLabel;
    lblTipoPartTime: TmeIWLabel;
    dcmbAzienza: TmeIWDBComboBox;
    dcmbQualifica: TmeIWDBComboBox;
    dcmbDisciplina: TmeIWDBComboBox;
    dcmbTipoRapporto: TmeIWDBComboBox;
    dmemNote: TmeIWDBMemo;
    lblPRapportoValue: TmeIWDBLabel;
    lblNote: TmeIWLabel;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure btnChiudiClick(Sender: TObject);
    procedure btnAnnullaClick(Sender: TObject);
    procedure dcmbParttimeAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure btnModificaClick(Sender: TObject);
    procedure btnConfermaClick(Sender: TObject);
  private
    DataI, DataF: TDateTime; //Conservano le date di inizio-fine periodo in modifica per verificare sia mantenuta la validità dei periodi di aspettativa
    { Private declarations }
    procedure AbilitaComponenti;
    procedure PreparaDCmb(pCmb: TmeIWDBComboBox; pDs: TOracleDataSet; pOpzionale:Boolean);
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

procedure TW049FCaricamentoFM.Apri;
begin
  DataSetCar:=W049DM2.A202MW.selT425;
  DataSourceCar.DataSet:=DataSetCar;

  if AzioneRichiamo = 'I' then
  begin
    DataSetCar.ReadOnly:=False;
    DataSetCar.Append;
    DataI:=0;
    DataF:=0;
  end
  else
  begin
    DataSetCar.ReadOnly:=True;
    DataI:=DataSetCar.FieldByName('INIZIO').AsDateTime;
    DataF:=DataSetCar.FieldByName('FINE').AsDateTime;
  end;
  //ImpostaValoriCombo;
  AbilitaComponenti;

  //GESTIONE DEL CAMPO ENTE
  PreparaDCmb(dcmbAzienza, W049DM2.A202MW.selEnte, False);

  //GESTIONE DEL TIPO RAPPORTO
  PreparaDCmb(dcmbTipoRapporto, W049DM2.A202MW.selT450, False);

  //GESTIONE CMB PART TIME
  PreparaDCmb(dcmbParttime, W049DM2.A202MW.selT460, True);

  //GESTIONE DEL CAMPO QUALIFICA
  PreparaDCmb(dcmbQualifica, W049DM2.A202MW.selQualifica, True);

  //GESTIONE DEL CAMPO DISCIPLINA
  PreparaDCmb(dcmbDisciplina, W049DM2.A202MW.selDisciplina, True);

end;

procedure TW049FCaricamentoFM.ControllaDati;
var strInt: string;
    test: Boolean;
    strLst: TStringList;
    i: integer;
begin
  try
    if DataSetCar.FieldByName('INIZIO').IsNull then
      raise exception.Create('Data di inizio periodo non valida');

    if DataSetCar.FieldByName('FINE').IsNull then
      raise exception.Create('Data di fine periodo non valida');

    if DataSetCar.FieldByName('FINE').AsDateTime <= DataSetCar.FieldByName('INIZIO').AsDateTime then
      raise exception.Create('Periodo non valido');

    if DataSetCar.FieldByName('ENTE').IsNull then
      raise exception.Create('Azienda non valida');

    if dcmbTipoRapporto.ItemIndex < 0 then
      raise exception.Create('Indicare il tipo di rapporto');

    //Controllo sui campi standard T430 INIZIO-FINE e sui campi aziendali INIZIO-FINE RAPPORTO GIURIDIC
    strLst:=W049DM2.A202MW.IntersezioneDate;

    DataSetCar.FieldByName('VALIDAZIONE').AsString:='N';  //Valore di default

    if strLst.Count > 0 then
    begin
      strInt:=strLst.Strings[1];

      if strLst.Strings[0] = '-A' then
      begin  //Controlla se tutte le intersezioni sono su periodi di tipo "Altro"
        i:=0;
        strInt:='';
        while i < strLst.Count-1 do
        begin
          if strLst[i] <> '-A' then
          begin
            strInt:=strLst.Strings[i+1];
            break;
          end
          else
            i:=i + 2;
        end;
        if strInt = '' then
          DataSetCar.FieldByName('VALIDAZIONE').AsString:='A';
      end
      else if strLst.Strings[0] <> 'D' then //Le intersezioni su T425 con validazione 'D' non devono essere comunque accettate
      begin  //Controlla se le intersezioni sono su periodi di aspettativa ->
        R180SetVariable(W049DM2.selT040T055Durata,'DAL',DataSetCar.FieldByName('INIZIO').AsDateTime);
        R180SetVariable(W049DM2.selT040T055Durata,'AL',DataSetCar.FieldByName('FINE').AsDateTime);
        R180SetVariable(W049DM2.selT040T055Durata,'PROGRESSIVO',W049DM2.selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);

        W049DM2.selT040T055Durata.Open;
        if (DataSetCar.FieldByName('FINE').AsDateTime - DataSetCar.FieldByName('INIZIO').AsDateTime + 1) =
            W049DM2.selT040T055Durata.FieldByName('GG_ASPETTATIVA').AsInteger then
        begin
          //Il periodo giuridico che si sta inserendo è interno a un periodo di aspettativa inserito e deve essere accettato
          strInt:='';
          DataSetCar.FieldByName('VALIDAZIONE').AsString:='D';
        end;
      end;
    end;

    //Controllo che la modifica delle date non lasci scoperto un periodo di aspettativa (solo per modifica)
    if not (AzioneRichiamo = 'I') and (DataSetCar.FieldByName('VALIDAZIONE').AsString <> 'D')
    and ((DataI <> DataSetCar.FieldByName('INIZIO').AsDateTime) or (DataF <> DataSetCar.FieldByName('FINE').AsDateTime)) then
    begin
      with W049DM2.A202MW.selT055 do
      begin
        First;
        Test:=True;
        while not Eof do
        begin
          Test:=False;
          //1-Aspettativa a cavallo del periodo giuridico -> le date del periodo giuridico
          //non possono cambiare perchè si creerebbero delle discontinuità rispetto ad altri periodi
          if (FieldByName('DAL').AsDateTime <= DataI) and (FieldByName('AL').AsDateTime >= DataF) then
            if (DataI <> DataSetCar.FieldByName('INIZIO').AsDateTime)
            or (DataF <> DataSetCar.FieldByName('FINE').AsDateTime) then
              break;
          //2-Aspettativa a cavallo della data di inizio del periodo -> Data inizio non deve cambiare e
              //Data Fine deve restare superiore alla fine del periodo di aspettativa
          if (FieldByName('DAL').AsDateTime <= DataI) and (FieldByName('AL').AsDateTime >= DataI) then
            if (DataSetCar.FieldByName('INIZIO').AsDateTime > DataI)
            or (DataSetCar.FieldByName('FINE').AsDateTime < FieldByName('AL').AsDateTime) then
              break;
          //3-Aspettativa a cavallo della data di fine del periodo -> Data fine non deve cambiare e
              //Data Inizio deve restare inferiore all'inizio del periodo di aspettativa
          if (FieldByName('DAL').AsDateTime <= DataF) and (FieldByName('AL').AsDateTime >= DataF) then
            if (DataSetCar.FieldByName('FINE').AsDateTime < DataF)
            or (DataSetCar.FieldByName('INIZIO').AsDateTime > FieldByName('AL').AsDateTime) then
              break;
          //4-Aspettativa interna la periodo giuridico -> deve restare interna
          if (FieldByName('DAL').AsDateTime >= DataI)
          and (FieldByName('AL').AsDateTime <= DataF) then
            if not (FieldByName('DAL').AsDateTime > DataSetCar.FieldByName('INIZIO').AsDateTime)
            or not (FieldByName('AL').AsDateTime < DataSetCar.FieldByName('FINE').AsDateTime) then
              break;

          Test:=True;
          Next;
        end;
        if not Test then
          strInt:=('La modifica del periodo giuridico non è compatibile con il periodo di aspettativa dal ' + FieldByName('DAL').AsString + ' al ' + FieldByName('AL').AsString);
      end;
    end;

    if strInt <> '' then
      raise exception.Create(strInt);
  finally
    if Assigned(strLst) then
      FreeAndNil(strLst);
  end;
end;

procedure TW049FCaricamentoFM.PreparaDCmb(pCmb: TmeIWDBComboBox; pDs: TOracleDataSet; pOpzionale: Boolean);
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
    if pOpzionale and (DataSetCar.FieldByName(strField).AsString <> '') then
      pCmb.Items.Add('' + '=' + '');
    with pDs do
    begin
      first;
      for i:=0 to RecordCount-1 do
      begin
        pCmb.Items.Add(FieldByName('DESCRIZIONE').AsString + '=' + FieldByName('CODICE').AsString);
        Next;
      end;
    end;
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

procedure TW049FCaricamentoFM.btnAnnullaClick(Sender: TObject);
begin
  DataSetCar.Cancel;
  DataSetCar.ReadOnly:=True;
  if AzioneRichiamo = 'I' then
    btnChiudiClick(nil)
  else
    AbilitaComponenti;
end;

procedure TW049FCaricamentoFM.btnChiudiClick(Sender: TObject);
begin
  if Assigned(NotificaChiusura) then
    NotificaChiusura;
  Free;
end;

procedure TW049FCaricamentoFM.btnConfermaClick(Sender: TObject);
begin
  ControllaDati;
  DataSetCar.Post;
  DataSetCar.ReadOnly:=True;
  if AzioneRichiamo = 'I' then
    btnChiudiClick(nil)
  else
    AbilitaComponenti;
end;

procedure TW049FCaricamentoFM.btnModificaClick(Sender: TObject);
begin
  DataSetCar.ReadOnly:=False;
  DataSetCar.Edit;
  AbilitaComponenti;
end;

procedure TW049FCaricamentoFM.dcmbParttimeAsyncChange(Sender: TObject; EventParams: TStringList);
var LTipo: String;
begin
  inherited;
  DataSetCar.OnCalcFields(DataSetCar);
end;

procedure TW049FCaricamentoFM.IWFrameRegionCreate(Sender: TObject);
begin
  Self.Parent:=TIWAppForm(Self.Owner);
end;

procedure TW049FCaricamentoFM.AbilitaComponenti;
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

procedure TW049FCaricamentoFM.Visualizza;
var Titolo:String;
begin
  Titolo:=IfThen(DataSetCar.State = dsInsert,'Inserimento ',IfThen(DataSetCar.State = dsEdit,'Modifica','Visualizzazione'))
          + ' periodi giuridici';
  (Self.Parent as TWR010FBase).VisualizzajQMessaggio(JQuery,600,-1,EM2PIXEL * 24,Titolo,'#' + Self.Name,False,True);
end;

end.
