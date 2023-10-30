unit WA002UAnagrafe;

interface

uses
  A000UCostanti,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, A000UInterfaccia, WR102UGestTabella, ActnList, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  medpIWTabControl, IWCompLabel, meIWLabel, IWCompGrids, meIWGrid,
  medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, Menus,
  IWControl, IWHTMLControls, meIWLink,WA002UAnagrafeDM,WA002UAnagrafeBrowseFM,
  DB,WA002UCercaCampoFM, WA082UCdcPercent, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWCompButton, meIWButton,
  System.Actions, meIWImageFile, IWCompEdit, meIWEdit, Oracle;

type
  TWA002FAnagrafe = class(TWR102FGestTabella)
    actCercaCampo: TAction;
    actCdcPercent: TAction;
    actAnagraficaStipendi: TAction;
    actLoginDipendente: TAction;
    actFotoDipendente: TAction;
    procedure IWAppFormCreate(Sender: TObject);
    procedure actCercaCampoExecute(Sender: TObject);
    procedure actCdcPercentExecute(Sender: TObject);
    procedure actAnagraficaStipendiExecute(Sender: TObject);
    procedure actModificaExecute(Sender: TObject);
    procedure actLoginDipendenteExecute(Sender: TObject);
    procedure actFotoDipendenteExecute(Sender: TObject);
  private
    FCambioStruttura: Boolean;
  protected
    procedure SalvaValoriOriginali; override;
    procedure RipristinaValoriOriginali; override;
  public
    function  VerificaSelezioneC700 : boolean; override;
    procedure AttivaGestioneC700; override;
    procedure RefreshPage; override;
    procedure CambioDataDecorrenza; override;
    procedure SpostaStorico (Decorrenza: TDateTime);
    procedure WC700CambioProgressivo(Sender: TObject); override;
    property CambioStruttura:Boolean read FCambioStruttura write FCambioStruttura;
  end;

implementation

uses
  WA002UAnagrafeDettFM;

{$R *.dfm}

{ TWA002FAnagrafe }

procedure TWA002FAnagrafe.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  FCambioStruttura:=False;
  //IMPOSTARE CAMPODECORRENZA PRIMA DI CREAZIONE DATAMODULO PER CORRETTA GESTIONE CAMPI CHIAVE
  InterfacciaWR102.GestioneStoricizzata:=true;
  InterfacciaWR102.CampoDecorrenza:='DATADECORRENZA';
  InterfacciaWR102.CampoDecorrenzaFine:='DATAFINE';
  InterfacciaWR102.PosStoricoCorrenteSuCambioProg:=True;
  WR302DM:=TWA002FAnagrafeDM.Create(Self);
  WBrowseFM:=TWA002FAnagrafeBrowseFM.Create(Self);
  AttivaGestioneC700;
  WDettaglioFM:=TWA002FAnagrafeDettFM.Create(Self);
  // MONDOEDP - commessa.ini MAN/08 SVILUPPO#161.ini
  TabBrowseCaption:='Elenco periodi storici';
  // MONDOEDP - commessa.ini MAN/08 SVILUPPO#161.fine
  CreaTabDefault;
  TWA002FAnagrafeDM(WR302DM).dsrTabellaStateChange(nil);//Abilitazione azioni in base a permessi utente
end;

procedure TWA002FAnagrafe.AttivaGestioneC700;
begin
  inherited;
  //Devo sincronizzare selT030 con selTabella.
  //necessario per la corretta impostazione all'avvio
  with TWA002FAnagrafeDM(WR302DM).selT030 do
  begin
    Close;
    SetVariable('PROGRESSIVO',grdC700.selAnagrafe.FieldByName('Progressivo').Value);
    Open;
  end;
  CercaStoricoCorrente(Parametri.DataLavoro);
end;

procedure TWA002FAnagrafe.CambioDataDecorrenza;
begin
  TWA002FAnagrafeDettFM(WDettaglioFM).CambioDataDecorrenza;
end;

//procedura richiamata dall storicizzazione
//devo salvare oltre ai campi di selTabella anche quelli di selT030
procedure TWA002FAnagrafe.SalvaValoriOriginali;
var i : Integer;
begin
  inherited;
  with TWA002FAnagrafeDM(WR302DM).selT030 do
  begin
    for i:=0 to FieldDefs.Count - 1 do
    try
      if FindField(FieldDefs[i].Name) <> nil then
        InterfacciaWR102.LValoriOriginali.Add(FieldDefs[i].Name + '=' + FieldByName(FieldDefs[i].Name).AsString)
    except
    end;
  end;
end;

procedure TWA002FAnagrafe.SpostaStorico(Decorrenza: TDateTime);
begin
  CercaStoricoCorrente(Decorrenza);
end;

procedure TWA002FAnagrafe.WC700CambioProgressivo(Sender: TObject);
begin
  inherited;
  TWA002FAnagrafeDM(WR302DM).dsrTabellaStateChange(nil);//Abilitazione azioni in base a permessi utente
end;

function TWA002FAnagrafe.VerificaSelezioneC700: boolean;
begin
  //inibisce controllo dipendente selezionato
  Result:=True;
end;

procedure TWA002FAnagrafe.RefreshPage;
var
  bDettaglioActive: Boolean;
begin
  inherited;

  bDettaglioActive:=grdTabControl.ActiveTab = WDettaglioFM;
  if FCambioStruttura then
  begin
    FCambioStruttura:=False;
    //Devo Ricostruire la struttura perchè può essere cambiata da WA026
    //distruzione dettaglio
    grdTabControl.EliminaTab(WDettaglioFM);
    WDettaglioFM.ReleaseOggetti;
    FreeAndNil(WDettaglioFM);

    TWA002FAnagrafeDM(WR302DM).ReloadDatiLiberi;
    WDettaglioFM:=TWA002FAnagrafeDettFM.Create(Self);
    grdTabControl.AggiungiTab('Dettaglio',WDettaglioFM);
  end
  else //Ricarico le combo
    TWA002FAnagrafeDettFM(WDettaglioFM).CaricaTutteCombo(False);

  //Refresh relazioni
  with (WR302DM as TWA002FAnagrafeDM).A002FAnagrafeMW do
  begin
    selI030.Refresh;
    selI035.Refresh;
    selI030.First;
    RefreshVSQLAppoggio;
  end;
  (WDettaglioFM as TWA002FAnagrafeDettFM).EseguiRelazioni('');

  if bDettaglioActive then
    grdTabControl.ActiveTab:=WDettaglioFM
  else
    grdTabControl.ActiveTab:=WBrowseFM;
end;

procedure TWA002FAnagrafe.RipristinaValoriOriginali;
var i : Integer;
begin
  with TWA002FAnagrafeDM(WR302DM).selT030 do
  begin
    if State in [dsInsert,dsEdit] then
      for i:=0 to FieldDefs.Count - 1 do
      try
        if FieldByName(FieldDefs[i].Name).FieldKind = fkData then
          FieldByName(FieldDefs[i].Name).AsString:=InterfacciaWR102.LValoriOriginali.Values[FieldDefs[i].Name];
      except
      end;
  end;
  inherited;
end;

procedure TWA002FAnagrafe.actAnagraficaStipendiExecute(Sender: TObject);
var
  Params: String;
begin
  Params:='PROGRESSIVO=' + grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsString;
  AccediForm(503,Params,True);
end;

procedure TWA002FAnagrafe.actCdcPercentExecute(Sender: TObject);
var
  Progressivo: Integer;
begin
  Progressivo:=grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
  AccediForm(162,'PROGRESSIVO='+IntToStr(Progressivo),True);
end;

procedure TWA002FAnagrafe.actCercaCampoExecute(Sender: TObject);
begin
  with TWA002FCercaCampoFM.Create(Self) do
  begin
    Visualizza;
  end;
end;

procedure TWA002FAnagrafe.actFotoDipendenteExecute(Sender: TObject);
var
  Params: String;
begin
  Params:='PROGRESSIVO=' + grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsString;
  AccediForm(67,Params,True);
end;

procedure TWA002FAnagrafe.actLoginDipendenteExecute(Sender: TObject);
var
  LParams: String;
begin
  LParams:=Format('PROGRESSIVO=%d%sMODALITA_VISUALIZZAZIONE=TRUE',
                  [grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,
                   ParamDelimiter]);
  AccediForm(209,LParams,True);
end;

procedure TWA002FAnagrafe.actModificaExecute(Sender: TObject);
begin
  inherited;
  (WDettaglioFM as TWA002FAnagrafeDettFM).DataSet2Componenti;
end;

end.
