unit S030UProvved;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, Menus, Buttons, ExtCtrls, ComCtrls, DBCtrls, StdCtrls, Grids, DBGrids,
  Mask, C001UFiltroTabelleDtM, C001UFiltroTabelle, C001UScegliCampi,
  C005UDatiAnagrafici, C006UStoriaDati, C006UStoriaDip, C180FunzioniGenerali,
  C700USelezioneAnagrafe, R600, A000UCostanti, A000USessione,A000UInterfaccia,A003UDataLavoroBis,
  A002UInterfacciaSt, R001UGESTTAB, L001Call, OracleData, ActnList, ImgList,
  ToolWin, SelAnagrafe, Variants, S028UMotivazioni, A083UMsgElaborazioni,
  System.Actions, A000UMessaggi, System.ImageList;

type                                                                                    
  TS030FProvved = class(TR001FGestTab)
    Panel3: TPanel;
    dGrdProvvedimenti: TDBGrid;
    PopupMenu1: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    Panel4: TPanel;
    dmemTestoVar: TDBMemo;
    frmSelAnagrafe: TfrmSelAnagrafe;
    rgpModalita: TRadioGroup;
    btnAnomalie: TBitBtn;
    ToolButton2: TToolButton;
    ProgressBar1: TProgressBar;
    Panel2: TPanel;
    lblDato: TLabel;
    lblDataDecor: TLabel;
    lblDataRegistr: TLabel;
    lblMotivazione: TLabel;
    lblAutorita: TLabel;
    lblTipoAtto: TLabel;
    lblNumAtto: TLabel;
    lblDataAtto: TLabel;
    lblDataEsec: TLabel;
    lblTestoVar: TLabel;
    dEdtDataDecor: TDBEdit;
    dCmbMotivazione: TDBLookupComboBox;
    dedtNumAtto: TDBEdit;
    dEdtDataRegistr: TDBEdit;
    dedtDataAtto: TDBEdit;
    dedtDataEsec: TDBEdit;
    dCmbDato: TDBLookupComboBox;
    btnDataDecor: TButton;
    dRgpTipo: TDBRadioGroup;
    dlblDescDato: TDBText;
    dEdtDataFine: TDBEdit;
    lblDataFine: TLabel;
    lblSede: TLabel;
    dlblDescSede: TDBText;
    dCmbSede: TDBLookupComboBox;
    rgpVisualizza: TRadioGroup;
    dlblDescMotivazione: TDBText;
    Splitter1: TSplitter;
    dcmbTipoAtto: TDBComboBox;
    btnDataFine: TButton;
    btnDataRegistr: TButton;
    btnDataAtto: TButton;
    btnDataEsec: TButton;
    pmnNumAtto: TPopupMenu;
    miNuovoNumero: TMenuItem;
    btnDettaglio: TBitBtn;
    dcmbAutorita: TDBComboBox;
    Panel5: TPanel;
    dmemNote: TDBMemo;
    Panel6: TPanel;
    lblNote: TLabel;
    Splitter2: TSplitter;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure rgpVisualizzaClick(Sender: TObject);
    procedure rgpModalitaClick(Sender: TObject);
    procedure TInserClick(Sender: TObject);
    procedure TRegisClick(Sender: TObject);
    procedure TCancClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure dRgpTipoChange(Sender: TObject);
    procedure dCmbDatoCloseUp(Sender: TObject);
    procedure dCmbDatoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dCmbDatoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnDataRegistrClick(Sender: TObject);
    procedure btnDataDecorClick(Sender: TObject);
    procedure btnDataFineClick(Sender: TObject);
    procedure dCmbMotivazioneCloseUp(Sender: TObject);
    procedure dCmbMotivazioneKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure dcmbTipoAttoEnter(Sender: TObject);
    procedure miNuovoNumeroClick(Sender: TObject);
    procedure btnDataAttoClick(Sender: TObject);
    procedure btnDataEsecClick(Sender: TObject);
    procedure dcmbAutoritaEnter(Sender: TObject);
    procedure dCmbSedeCloseUp(Sender: TObject);
    procedure dCmbSedeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnDettaglioClick(Sender: TObject);
  private
    { Private declarations }
    procedure CambiaProgressivo;
    procedure AbilitaComponenti;
  public
    { Public declarations }
    CampoProvv:String;
    procedure ImpostaCodiceDato;
    procedure VisualizzaDescDato;
    procedure VisualizzaDescMotivazione;
    procedure VisualizzaDescSede;
  end;

var
  S030FProvved: TS030FProvved;

procedure OpenS030Provvedimento(Campo:String; Prog:Integer);

implementation

uses S030UProvvedimentiDtM, S030UDettaglio;

{$R *.DFM}

procedure OpenS030Provvedimento(Campo:String; Prog:Integer);
begin
  if Prog <= 0 then
  begin
    ShowMessage(A000MSG_ERR_NO_DIP);
    exit;
  end;
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenS030Provvedimento') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  S030FProvved:=TS030FProvved.Create(nil);
  with S030FProvved do
    try
      CampoProvv:=Campo;
      C700Progressivo:=Prog;
      S030FProvvedimentiDtM:=TS030FProvvedimentiDtM.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      S030FProvvedimentiDtM.Free;
      Free;
    end;
end;

procedure TS030FProvved.FormShow(Sender: TObject);
begin
  inherited;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(S030FProvvedimentiDtM.S030MW,SessioneOracle,StatusBar,2,True);
  if DButton.State = dsBrowse then
    rgpVisualizzaClick(nil);
  btnAnomalie.Enabled:=False;
  if Parametri.CampiRiferimento.C14_ProvvSede <> '' then
  begin
    lblSede.Enabled:=True;
    lblSede.Caption:=UpperCase(Copy(Parametri.CampiRiferimento.C14_ProvvSede,1,1)) + LowerCase(Copy(Parametri.CampiRiferimento.C14_ProvvSede,2,Length(Parametri.CampiRiferimento.C14_ProvvSede)-1));
  end;
end;

procedure TS030FProvved.FormDestroy(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TS030FProvved.frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
begin
  inherited;
  C005DataVisualizzazione:=Parametri.DataLavoro;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TS030FProvved.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  inherited;
  C700Datalavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TS030FProvved.CambiaProgressivo;
begin
  S030FProvvedimentiDtM.S030MW.CambiaProgressivo(CampoProvv);
  NumRecords;
end;

procedure TS030FProvved.DButtonStateChange(Sender: TObject);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TS030FProvved.rgpVisualizzaClick(Sender: TObject);
begin
  inherited;
  S030FProvvedimentiDtM.S030MW.FiltroProvvedimenti(rgpVisualizza.ItemIndex);
end;

procedure TS030FProvved.rgpModalitaClick(Sender: TObject);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TS030FProvved.AbilitaComponenti;
begin
  //Abilitazione pulsanti
  TPrimo.Enabled:=(DButton.State = dsBrowse) and (rgpModalita.ItemIndex = 0);
  TPrec.Enabled:=(DButton.State = dsBrowse) and (rgpModalita.ItemIndex = 0);
  TSucc.Enabled:=(DButton.State = dsBrowse) and (rgpModalita.ItemIndex = 0);
  TUltimo.Enabled:=(DButton.State = dsBrowse) and (rgpModalita.ItemIndex = 0);
  TCerca.Enabled:=(DButton.State = dsBrowse) and (rgpModalita.ItemIndex = 0);
  btnRefresh.Enabled:=(DButton.State = dsBrowse) and (rgpModalita.ItemIndex = 0);
  TModif.Enabled:=(DButton.State = dsBrowse) and (rgpModalita.ItemIndex = 0) and (not SolaLettura);
  TStampa.Enabled:=(DButton.State = dsBrowse) and (rgpModalita.ItemIndex = 0);
  //Abilitazione selezione anagrafiche e modalità collettiva-singola
  frmSelAnagrafe.Enabled:=DButton.State = dsBrowse;
  rgpModalita.Enabled:=DButton.State = dsBrowse;
  btnDataDecor.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnDataFine.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnDataRegistr.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnDataAtto.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnDataEsec.Enabled:=DButton.State in [dsEdit,dsInsert];
  //Abilitazione pulsante Anomalie
  btnAnomalie.Enabled:=(DButton.State = dsBrowse) and (RegistraMsg.ContieneTipoA or RegistraMsg.ContieneTipoB);
  //Abilitazione griglia Provvedimenti
  dGrdProvvedimenti.Enabled:=DButton.State = dsBrowse;
  rgpVisualizza.Enabled:=DButton.State = dsBrowse;
  miNuovoNumero.Enabled:=(DButton.State in [dsEdit,dsInsert]) and (Trim(DButton.DataSet.FieldByName('NumAtto').AsString) = '');
  btnDettaglio.Enabled:=(DButton.State = dsBrowse) and (rgpModalita.ItemIndex = 0);
end;

procedure TS030FProvved.TInserClick(Sender: TObject);
begin
  if C700Progressivo <= 0 then
    raise exception.create(A000MSG_ERR_NO_DIP);
  dCmbDato.SetFocus;
  inherited;
end;

procedure TS030FProvved.TRegisClick(Sender: TObject);
begin
  if rgpModalita.ItemIndex = 0 then
    //Modalità singola
    inherited
  else
  begin
    //Modalità collettiva
    S030FProvvedimentiDtM.evtRichiesta(S030FProvvedimentiDtM.S030MW.RecuperaTestoDomandaCollettiva('I'),'');
    //Disabilito l'evento scatenato al cambiamento del progressivo...
    frmSelAnagrafe.OnCambiaProgressivo:=nil;
    dCmbDato.SetFocus; //Forzo il posizionamento su dCmbDato perchè altrimenti non legge correttamente il memo NOTE
    S030FProvvedimentiDtM.S030MW.Inserimento;
    //Riabilito l'evento disabilitato in precedenza
    frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
    btnAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);
    if btnAnomalie.Enabled then
    begin
      if R180MessageBox(A000MSG_DLG_ELAB_ANOMALIE_VIS,DOMANDA) = mrYes then
        btnAnomalieClick(nil);
    end
    else
      R180MessageBox(A000MSG_MSG_ELABORAZIONE_TERMINATA,INFORMA);
  end;
end;

procedure TS030FProvved.TCancClick(Sender: TObject);
begin
  if rgpModalita.ItemIndex = 0 then
    //Modalità singola
    inherited
  else
  begin
    //Modalità collettiva
    S030FProvvedimentiDtM.evtRichiesta(S030FProvvedimentiDtM.S030MW.RecuperaTestoDomandaCollettiva('C'),'');
    //Disabilito l'evento scatenato al cambiamento del progressivo...
    frmSelAnagrafe.OnCambiaProgressivo:=nil;
    S030FProvvedimentiDtM.S030MW.Cancellazione;
    //Riabilito l'evento disabilitato in precedenza
    frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
    btnAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);
    if btnAnomalie.Enabled then
    begin
      if R180MessageBox(A000MSG_DLG_ELAB_ANOMALIE_VIS,DOMANDA) = mrYes then
        btnAnomalieClick(nil);
    end
    else
      R180MessageBox(A000MSG_MSG_ELABORAZIONE_TERMINATA,INFORMA);
  end;
end;

procedure TS030FProvved.btnAnomalieClick(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'S030','');
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe;
end;

procedure TS030FProvved.dRgpTipoChange(Sender: TObject);
begin
  inherited;
  ImpostaCodiceDato;
  VisualizzaDescDato;
end;

procedure TS030FProvved.ImpostaCodiceDato;
begin
  if dRgpTipo.ItemIndex = 0 then
  begin
    lblDato.Caption:='Dato storico';
    dCmbDato.ListSource:=S030FProvvedimentiDtM.S030MW.dsrI010;
    dlblDescDato.DataSource:=S030FProvvedimentiDtM.S030MW.dsrI010;
  end
  else if dRgpTipo.ItemIndex = 1 then
  begin
    lblDato.Caption:='Causale assenza';
    dCmbDato.ListSource:=S030FProvvedimentiDtM.S030MW.dsrT265;
    dlblDescDato.DataSource:=S030FProvvedimentiDtM.S030MW.dsrT265;
  end;
  dGrdProvvedimenti.Columns[1].Title.Caption:=lblDato.Caption;
  if (DButton.State in [dsEdit,dsInsert]) and (dlblDescDato.DataSource.Dataset.RecordCount = 1) then
  begin
    dCmbDato.KeyValue:=dlblDescDato.DataSource.Dataset.FieldByName('CODICE').AsString;
    S030FProvvedimentiDtM.S030MW.selSG100.FieldByName('NOMECAMPO').AsString:=dlblDescDato.DataSource.Dataset.FieldByName('CODICE').AsString;
  end;
end;

procedure TS030FProvved.dCmbDatoCloseUp(Sender: TObject);
begin
  inherited;
  VisualizzaDescDato;
end;

procedure TS030FProvved.dCmbDatoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  VisualizzaDescDato;
end;

procedure TS030FProvved.VisualizzaDescDato;
begin
  dlblDescDato.Visible:=Trim(dcmbDato.Text) <> '';
end;

procedure TS030FProvved.dCmbDatoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TS030FProvved.btnDataRegistrClick(Sender: TObject);
begin
  inherited;
  with S030FProvvedimentiDtM.S030MW do
  begin
    if selSG100.FieldByName('DATAREGISTR').IsNull then
      selSG100.FieldByName('DATAREGISTR').AsDateTime:=Parametri.DataLavoro;
    selSG100.FieldByName('DATAREGISTR').AsDateTime:=DataOut(selSG100.FieldByName('DATAREGISTR').AsDateTime,'Data registrazione','G');
  end;
end;

procedure TS030FProvved.btnDataDecorClick(Sender: TObject);
var i:Integer;
begin
  if dRgpTipo.ItemIndex = 0 then //Variaz. storiche
  begin
    C006FStoriaDati:=TC006FStoriaDati.Create(nil);
    try
      C006FStoriaDati.GetStoriaDato(C700Progressivo,S030FProvvedimentiDtM.S030MW.selSG100.FieldByName('NomeCampo').AsString);
      C006FStoriaDip:=TC006FStoriaDip.Create(Application);
      try
        C006FStoriaDip.Caption:='Selezione periodo storico';
        with C006FStoriaDip do
        begin
          AbilitaMenu:=True;
          Grid.RowCount:=C006FStoriaDati.StoriaDipendente.Count + 1;
          for i:=0 to C006FStoriaDati.StoriaDipendente.Count - 1 do
          begin
            //Alberto 13/02/2013: visulizzazione periodi storici in ordine decrescente
            Grid.Cells[0,Grid.RowCount - i - 1]:=S030FProvvedimentiDtM.S030MW.selSG100.FieldByName('NomeCampo').AsString;
            Grid.Cells[1,Grid.RowCount - i - 1]:=RecStoria(C006FStoriaDati.StoriaDipendente[i]).DataDec;
            Grid.Cells[2,Grid.RowCount - i - 1]:=RecStoria(C006FStoriaDati.StoriaDipendente[i]).DataFine;
            Grid.Cells[3,Grid.RowCount - i - 1]:=RecStoria(C006FStoriaDati.StoriaDipendente[i]).Valore;
            Grid.Cells[4,Grid.RowCount - i - 1]:=RecStoria(C006FStoriaDati.StoriaDipendente[i]).Descrizione;
          end;
          ShowModal;
          if SpostaStorico then
          begin
            S030FProvvedimentiDtM.S030MW.selSG100.FieldByName('DataDecor').AsString:=Grid.Cells[1,Grid.Row];
            S030FProvvedimentiDtM.S030MW.selSG100.FieldByName('DataFine').AsString:=Grid.Cells[2,Grid.Row];
          end;
        end;
      finally
        FreeAndNil(C006FStoriaDip);
      end;
    finally
      C006FStoriaDati.Free;
    end;
  end
  else //Giustif. assenza
    with S030FProvvedimentiDtM.S030MW do
    begin
      R600DtM.Progressivo:=C700Progressivo;
      R600DtM.GetPeriodiAssenza(selSG100.FieldByName('NomeCampo').AsString);
      C006FStoriaDip:=TC006FStoriaDip.Create(Application);
      try
        C006FStoriaDip.Caption:='Selezione periodo assenza';
        with C006FStoriaDip do
        begin
          AbilitaMenu:=True;
          Grid.FixedCols:=0;
          Grid.RowCount:=R600DtM.cdsPeriodiAssenza.RecordCount + 1;
          R600DtM.cdsPeriodiAssenza.First;
          for i:=0 to R600DtM.cdsPeriodiAssenza.RecordCount - 1 do
          begin
            Grid.Cells[0,i + 1]:='Giorni: ' + R600DtM.cdsPeriodiAssenza.FieldByName('TOTALEGG').AsString;
            Grid.Cells[1,i + 1]:=R600DtM.cdsPeriodiAssenza.FieldByName('DATAINIZIO').AsString;
            Grid.Cells[2,i + 1]:=R600DtM.cdsPeriodiAssenza.FieldByName('DATAFINE').AsString;
            Grid.Cells[3,i + 1]:=R600DtM.cdsPeriodiAssenza.FieldByName('CAUSALE').AsString;
            Grid.Cells[4,i + 1]:=R600DtM.cdsPeriodiAssenza.FieldByName('DESCRIZIONE').AsString;
            R600DtM.cdsPeriodiAssenza.Next;
          end;
          if R600DtM.cdsPeriodiAssenza.RecordCount > 0 then
          begin
            ShowModal;
            if SpostaStorico then
            begin
              selSG100.FieldByName('DataDecor').AsString:=Grid.Cells[1,Grid.Row];
              selSG100.FieldByName('DataFine').AsString:=Grid.Cells[2,Grid.Row];
            end;
          end;
        end;
      finally
        FreeAndNil(C006FStoriaDip);
      end;
    end;
end;

procedure TS030FProvved.btnDataFineClick(Sender: TObject);
begin
  inherited;
  with S030FProvvedimentiDtM.S030MW do
  begin
    if selSG100.FieldByName('DATAFINE').IsNull then
      selSG100.FieldByName('DATAFINE').AsDateTime:=Parametri.DataLavoro;
    selSG100.FieldByName('DATAFINE').AsDateTime:=DataOut(selSG100.FieldByName('DATAFINE').AsDateTime,'Data fine','G');
  end;
end;

procedure TS030FProvved.dCmbMotivazioneCloseUp(Sender: TObject);
begin
  inherited;
  VisualizzaDescMotivazione;
end;

procedure TS030FProvved.dCmbMotivazioneKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  VisualizzaDescMotivazione;
end;

procedure TS030FProvved.VisualizzaDescMotivazione;
begin
  dlblDescMotivazione.Visible:=Trim(dcmbMotivazione.Text) <> '';
end;

procedure TS030FProvved.Nuovoelemento1Click(Sender: TObject);
begin
  OpenS028Motivazioni(dCmbMotivazione.Text);
  S030FProvvedimentiDtM.S030MW.selSG104.Close;
  S030FProvvedimentiDtM.S030MW.selSG104.Open;
end;

procedure TS030FProvved.dcmbTipoAttoEnter(Sender: TObject);
var i:Integer;
begin
  inherited;
  dcmbTipoAtto.Items.Clear;
  S030FProvvedimentiDtM.S030MW.CaricaListaTipoAtto;
  with S030FProvvedimentiDtM.S030MW.lstTipoAtto do
    for i:=0 to Count - 1 do
      dcmbTipoAtto.Items.Add(Strings[i]);
end;

procedure TS030FProvved.miNuovoNumeroClick(Sender: TObject);
begin
  inherited;
  //Propongo il nuovo numero atto se vuoto
  dedtNumAtto.Text:=S030FProvvedimentiDtM.S030MW.NuovoNumeroAtto;
end;

procedure TS030FProvved.btnDataAttoClick(Sender: TObject);
begin
  inherited;
  with S030FProvvedimentiDtM.S030MW do
  begin
    if selSG100.FieldByName('DATAATTO').IsNull then
      selSG100.FieldByName('DATAATTO').AsDateTime:=Parametri.DataLavoro;
    selSG100.FieldByName('DATAATTO').AsDateTime:=DataOut(selSG100.FieldByName('DATAATTO').AsDateTime,'Data atto','G');
  end;
end;

procedure TS030FProvved.btnDataEsecClick(Sender: TObject);
begin
  inherited;
  with S030FProvvedimentiDtM.S030MW do
  begin
    if selSG100.FieldByName('DATAESEC').IsNull then
      selSG100.FieldByName('DATAESEC').AsDateTime:=Parametri.DataLavoro;
    selSG100.FieldByName('DATAESEC').AsDateTime:=DataOut(selSG100.FieldByName('DATAESEC').AsDateTime,'Data esecutività atto','G');
  end;
end;

procedure TS030FProvved.dcmbAutoritaEnter(Sender: TObject);
var i:Integer;
begin
  inherited;
  dcmbAutorita.Items.Clear;
  S030FProvvedimentiDtM.S030MW.CaricaListaAutorita;
  with S030FProvvedimentiDtM.S030MW.lstAutorita do
    for i:=0 to Count - 1 do
      dcmbAutorita.Items.Add(Strings[i]);
end;

procedure TS030FProvved.dCmbSedeCloseUp(Sender: TObject);
begin
  inherited;
  VisualizzaDescSede;
end;

procedure TS030FProvved.dCmbSedeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  VisualizzaDescSede;
end;

procedure TS030FProvved.VisualizzaDescSede;
begin
  dlblDescSede.Visible:=Trim(dcmbSede.Text) <> '';
end;

procedure TS030FProvved.btnDettaglioClick(Sender: TObject);
begin
  inherited;
  if Trim(S030FProvvedimentiDtM.S030MW.selSG100.FieldByName('CAUSALE').AsString) = '' then
    raise Exception.Create(A000MSG_S030_ERR_NO_MOTIVAZIONE);
  try
    S030FDettaglio:=TS030FDettaglio.Create(nil);
    S030FDettaglio.ShowModal;
  finally
    FreeAndNil(S030FDettaglio);
  end;
end;

end.
