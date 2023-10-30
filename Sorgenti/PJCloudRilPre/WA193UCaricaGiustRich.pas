unit WA193UCaricaGiustRich;

interface

uses
  A004UGiustifAssPresMW, WR100UBase, WR102UGestTabella,
  A000UInterfaccia, A000UCostanti, A000UMessaggi,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  medpIWTabControl, IWCompLabel, meIWLabel, IWCompButton, meIWButton, StrUtils,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, IWCompEdit, meIWEdit,
  IWCompCheckbox, meIWCheckBox, meIWRadioGroup, IWDBGrids, medpIWDBGrid,
  meIWImageFile, medpIWImageButton, medpIWMessageDlg, Oracle, OracleData,
  System.Actions, IWVCLComponent, IWVCLBaseControl, WC027UInfoDatiFM;

type
  TWA193FCaricaGiustRich = class(TWR102FGestTabella)
    rgpModalita: TmeIWRadioGroup;
    chkAnomalie: TmeIWCheckBox;
    lblPeriodoDal: TmeIWLabel;
    edtPeriodoDal: TmeIWEdit;
    lblPeriodoAl: TmeIWLabel;
    edtPeriodoAl: TmeIWEdit;
    lblInizioDal: TmeIWLabel;
    edtInizioDal: TmeIWEdit;
    lblInizioAl: TmeIWLabel;
    edtInizioAl: TmeIWEdit;
    lblFineDal: TmeIWLabel;
    edtFineDal: TmeIWEdit;
    lblFineAl: TmeIWLabel;
    edtFineAl: TmeIWEdit;
    btnVisualizzaLog: TmedpIWImageButton;
    btnImporta: TmedpIWImageButton;
    lblPeriodo: TmeIWLabel;
    lblModalita: TmeIWLabel;
    rgpAllegato: TmeIWRadioGroup;
    rgpCondizAllegato: TmeIWRadioGroup;
    lblAllegato: TmeIWLabel;
    lblCondizAllegato: TmeIWLabel;
    procedure IWAppFormCreate(Sender: TObject);
    procedure btnVisualizzaLogClick(Sender: TObject);
    procedure rgpModalitaClick(Sender: TObject);
    procedure btnImportaClick(Sender: TObject);
    procedure actAggiornaExecute(Sender: TObject);
    procedure rgpAllegatoClick(Sender: TObject);
    procedure rgpCondizAllegatoClick(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
  private
    procedure AggiornaFiltroPeriodo;
    procedure Importazione(Sender: TObject);
    procedure ResultWC700(Sender: TObject; Result: Boolean);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    WC027:TWC027FInfoDatiFM;
    procedure Elaborazione(Sender: TObject);
    procedure ApriWC027(ID:Integer);
  end;

const
  // item del filtro messaggi
  ITEM_NUOVE     = 0;
  ITEM_ELABORATE = 1;

implementation

uses WA193UCaricaGiustRichDM, WA193UCaricaGiustRichBrowseFM;

{$R *.dfm}

procedure TWA193FCaricaGiustRich.IWAppFormCreate(Sender: TObject);
var
  i: Integer;
begin
  // nasconde gestione tabella (edit e conferma dati)
  for i:=0 to actlstNavigatorBar.ActionCount - 1 do
  begin
    if (actlstNavigatorBar.Actions[i].Category = 'Edit') or
       (actlstNavigatorBar.Actions[i].Category = 'Validazione') then
    begin
      (actlstNavigatorBar.Actions[i] as TAction).Visible:=False;
    end;
  end;

  inherited;

  // impostazioni di interfaccia
  InterfacciaWR102.TemplateAutomatico:=False;
  InterfacciaWR102.DettaglioFM:=False;

  // imposta la gestione automatica della selezione del periodo
  AssegnaGestPeriodo(edtPeriodoDal,edtPeriodoAl);
  AssegnaGestPeriodo(edtInizioDal,edtInizioAl);
  AssegnaGestPeriodo(edtFineDal,edtFineAl);

  // creazione datamodule (impostazioni sel. anagrafe effettuate successivamente)
  WR302DM:=TWA193FCaricaGiustRichDM.Create(Self);

  // impostazioni per selezione anagrafica
  AttivaGestioneC700;
  grdC700.AttivaBrowse:=False;
  grdC700.AttivaLabel:=False;
  grdC700.WC700FM.ResultEvent:=ResultWC700;

  // impostazioni sel. anagrafe
  (WR302DM as TWA193FCaricaGiustRichDM).AfterCreate;

  WBrowseFM:=TWA193FCaricaGiustRichBrowseFM.Create(Self);
  CreaTabDefault;

  // imposta il filtro richieste e il filtro periodo
  rgpModalitaClick(nil);

  WC027:=nil;
end;

procedure TWA193FCaricaGiustRich.ResultWC700(Sender: TObject; Result: Boolean);
begin
  // se Result è True, significa che è stata modificata la selezione anagrafica
  if Result then
  begin
    // reimposta il filtro anagrafe
    WR302DM.selTabella.Close;
    grdC700.WC700FM.C700MergeSelAnagrafe(WR302DM.selTabella,False);
    grdC700.WC700FM.C700MergeSettaPeriodo(WR302DM.selTabella,Parametri.DataLavoro,Parametri.DataLavoro);
    WR302DM.selTabella.Open;

    // aggiorna tabella
    WBrowseFM.grdTabella.medpCaricaCDS;
  end;
end;

procedure TWA193FCaricaGiustRich.rgpAllegatoClick(Sender: TObject);
begin
  inherited;
  (WR302DM as TWA193FCaricaGiustRichDM).A004MW.selT050FiltroAllegati(rgpAllegato.Items[rgpAllegato.ItemIndex].ToLower.Trim);
  // apre il dataset e aggiorna la grid
  WR302DM.selTabella.Open;
  WBrowseFM.grdTabella.medpCaricaCDS;
end;

procedure TWA193FCaricaGiustRich.rgpCondizAllegatoClick(Sender: TObject);
begin
  inherited;
  (WR302DM as TWA193FCaricaGiustRichDM).A004MW.selT050FiltroFiltroCondizAllegati(rgpCondizAllegato.Items[rgpCondizAllegato.ItemIndex].ToLower.Trim);
  // apre il dataset e aggiorna la grid
  WR302DM.selTabella.Open;
  WBrowseFM.grdTabella.medpCaricaCDS;
end;

procedure TWA193FCaricaGiustRich.rgpModalitaClick(Sender: TObject);
var
  Elab: String;
begin
  if rgpModalita.ItemIndex = ITEM_NUOVE then
  begin
    // richieste nuove: cancella periodo intersezione
    edtPeriodoDal.Clear;
    edtPeriodoAl.Clear;
  end
  else
  begin
    // richieste già elaborate: imposta default per periodo di intersezione
    if edtPeriodoDal.Text = '' then
      edtPeriodoDal.Text:=FormatDateTime('dd/mm/yyyy',Date);
    if edtPeriodoAl.Text = '' then
      edtPeriodoAl.Text:=FormatDateTime('dd/mm/yyyy',Date);
  end;

  // pulisce periodo inizio - fine
  edtInizioDal.Clear;
  edtInizioAl.Clear;
  edtFineDal.Clear;
  edtFineAl.Clear;

  // imposta filtro modalità
  Elab:=IfThen(rgpModalita.ItemIndex = ITEM_NUOVE,'N','E');
  R180SetVariable(WR302DM.selTabella,'FILTRO_MODALITA',Format('and t050.elaborato = ''%s''',[Elab]));

  // imposta filtro periodo
  AggiornaFiltroPeriodo;

  // apre il dataset e aggiorna la grid
  WR302DM.selTabella.Open;
  WBrowseFM.grdTabella.medpCaricaCDS;
end;

procedure TWA193FCaricaGiustRich.actAggiornaExecute(Sender: TObject);
var
  ID: String;
begin
  AggiornaFiltroPeriodo;

  if WR302DM.selTabella.Active then
  begin
    WR302DM.selTabella.Refresh;
  end
  else
  begin
    ID:=WR302DM.selTabella.RowID;
    WR302DM.selTabella.Open;
    if ID <> '' then
      WR302DM.selTabella.Locate('RowID',ID,[]);
  end;

  inherited;

  WBrowseFM.grdTabella.medpCaricaCDS;
end;

procedure TWA193FCaricaGiustRich.AggiornaFiltroPeriodo;
var
  IntersezDal,IntersezAl,
  InizioDal,InizioAl,
  FineDal,FineAl: TDateTime;
  IntersezPeriodo,InizioPeriodo,FinePeriodo,Periodo: String;
  function IsDataNulla(const PData: String): Boolean;
  begin
    Result:=(Trim(PData) = '') or (PData = '  /  /    ');
  end;
begin
  // periodo 1/3: intersezione dal - al
  if IsDataNulla(edtPeriodoDal.Text) and IsDataNulla(edtPeriodoAl.Text) then
  begin
    // periodo vuoto
    IntersezPeriodo:='';
  end
  else
  begin
    // una delle date è indicata
    if not TryStrToDate(edtPeriodoDal.Text,IntersezDal) then
      raise Exception.Create('Data inizio del periodo di intersezione non valida!');
    if not TryStrToDate(edtPeriodoAl.Text,IntersezAl) then
      raise Exception.Create('Data fine del periodo di intersezione non valida!');
    if IntersezDal > IntersezAl then
      raise Exception.Create('Il periodo di intersezione indicato non è valido!');
    IntersezPeriodo:=Format('and t050.al >= to_date(''%s'',''dd/mm/yyyy'') and t050.dal <= to_date(''%s'',''dd/mm/yyyy'')',[FormatDateTime('dd/mm/yyyy',IntersezDal),FormatDateTime('dd/mm/yyyy',IntersezAl)]);
  end;

  // periodo 2/3: inizio richieste
  if IsDataNulla(edtInizioDal.Text) and IsDataNulla(edtInizioAl.Text) then
  begin
    // periodo vuoto
    InizioPeriodo:='';
  end
  else
  begin
    // una delle date è indicata
    if not TryStrToDate(edtInizioDal.Text,InizioDal) then
      raise Exception.Create('Data di "Inizio dal" non valida!');
    if not TryStrToDate(edtInizioAl.Text,InizioAl) then
      raise Exception.Create('Data di "Inizio al" non valida!');
    if InizioDal > InizioAl then
      raise Exception.Create('Il periodo di inizio indicato non è valido!');
    InizioPeriodo:=Format('and t050.dal between to_date(''%s'',''dd/mm/yyyy'') and to_date(''%s'',''dd/mm/yyyy'')',[FormatDateTime('dd/mm/yyyy',InizioDal),FormatDateTime('dd/mm/yyyy',InizioAl)]);
  end;

  // periodo 3/3: fine richieste
  if IsDataNulla(edtFineDal.Text) and IsDataNulla(edtFineAl.Text) then
  begin
    // periodo vuoto
    FinePeriodo:='';
  end
  else
  begin
    // una delle date è indicata
    if not TryStrToDate(edtFineDal.Text,FineDal) then
      raise Exception.Create('Data di "Fine dal" non valida!');
    if not TryStrToDate(edtFineAl.Text,FineAl) then
      raise Exception.Create('Data di "Fine al" non valida!');
    if FineDal > FineAl then
      raise Exception.Create('Il periodo di fine indicato non è valido!');
    FinePeriodo:=Format('and t050.al between to_date(''%s'',''dd/mm/yyyy'') and to_date(''%s'',''dd/mm/yyyy'')',[FormatDateTime('dd/mm/yyyy',FineDal),FormatDateTime('dd/mm/yyyy',FineAl)]);
  end;

  // compone il filtro periodo complessivo
  Periodo:=Trim(IntersezPeriodo + ' ' + InizioPeriodo + ' ' + FinePeriodo);

  // la modalità rielaborazione richiede che sia specificato almeno un filtro
  if (rgpModalita.ItemIndex = ITEM_ELABORATE) and (Periodo = '') then
    raise Exception.Create('E'' necessario specificare almeno un filtro sul periodo per la rielaborazione delle richieste');

  R180SetVariable(WR302DM.selTabella,'FILTRO_PERIODO',Periodo);
end;

procedure TWA193FCaricaGiustRich.btnImportaClick(Sender: TObject);
// importazione di tutte le richieste
begin
  Elaborazione(btnImporta);
end;

procedure TWA193FCaricaGiustRich.btnVisualizzaLogClick(Sender: TObject);
var
  Params: String;
begin
  Params:='AZIENDA=' + Parametri.Azienda + ParamDelimiter +
          'OPERATORE=' + Parametri.Operatore + ParamDelimiter +
          'MASCHERA=' + medpCodiceForm + ParamDelimiter +
          'ID=' + IntToStr(RegistraMsg.ID) + ParamDelimiter +
          'TIPO=A,B,I';

  AccediForm(201,Params,True);
end;

procedure TWA193FCaricaGiustRich.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent,Operation);
  if (AComponent = WC027) and (Operation = opRemove) then
    WC027:=nil;
end;

procedure TWA193FCaricaGiustRich.Elaborazione(Sender: TObject);
begin
  // utilizza il thread separato per l'importazione delle richieste
  // per via dei controlli sui giustificativi
  StartThreadElaborazione(Importazione,Sender);
end;

procedure TWA193FCaricaGiustRich.Importazione(Sender: TObject);
var
  Singola,Ok: Boolean;
  Errore,Msg: String;
  NumScartate: Integer;
begin
  // acquisizione delle richieste di giustificativo su cartellino
  Singola:=Sender <> btnImporta;

  if not Singola then
  begin
    if MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_A193_DLG_IMPORTA_RICH),DOMANDA) = mrNo then
      Exit;
  end;

  Errore:='';
  Ok:=(WR302DM as TWA193FCaricaGiustRichDM).A004MW.AcquisizioneRichiesteWeb(Singola,chkAnomalie.Checked,Errore,NumScartate,rgpModalita.ItemIndex = ITEM_NUOVE);

  // riapre il dataset delle richieste
  WR302DM.selTabella.Close;
  WR302DM.selTabella.Open;
  WBrowseFM.grdTabella.medpCaricaCDS;

  // messaggio di fine elaborazione
  if Ok then
  begin
    // elaborazione ok / warning
    if Errore = '' then
      Msg:='Elaborazione terminata correttamente'
    else
      Msg:='Elaborazione terminata con avvertimenti:'#13#10 + Errore;

    if NumScartate > 0 then
    begin
      Msg:=Msg + #13#10'Alcune richieste non sono state considerate'#13#10'perché sono state già importate in precedenza';
    end;
    MsgBox.MessageBox(Msg,INFORMA);
  end
  else
  begin
    // anomalie durante elaborazione
    if MsgBox.MessageBox('Elaborazione terminata con errori.'#13#10'Si desidera visualizzarli?',DOMANDA) = mrYes then
      btnVisualizzaLogClick(nil);
  end;
end;

procedure TWA193FCaricaGiustRich.ApriWC027(ID:Integer);
begin
  if WC027 <> nil then
  begin
    try
      WC027.btnChiudiClick(nil);
    except
    end;
  end;
  WC027:=TWC027FInfoDatiFM.Create(Self);
  WC027.FreeNotification(Self);
  WC027.MostraInfoRichiesta(ID);
end;

procedure TWA193FCaricaGiustRich.IWAppFormDestroy(Sender: TObject);
begin
  if WC027 <> nil then
  begin
    try
      WC027.btnChiudiClick(nil);
    except
    end;
    WC027:=nil;
  end;
  inherited;
end;

end.
