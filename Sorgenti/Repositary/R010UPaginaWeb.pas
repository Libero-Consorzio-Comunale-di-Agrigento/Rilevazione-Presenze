unit R010UPaginaWeb;

interface

uses
  WR010UBase, WC501UMenuIrisWebFM,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb, IWApplication,
  A000UInterfaccia, A000UCostanti, A000USessione, L021Call, Forms,
  StrUtils, OracleData, IWCompEdit, IWCompListBox, IWCompCheckbox,
  IWCompGrids, IWDBGrids, Menus, IWCompButton, IWCompMemo,
  meIWLink, IWCompLabel, meIWLabel, meIWImageFile, IW.Browser.InternetExplorer,
  SysUtils, Variants, Classes, ActnList, IWCompExtCtrls,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWHTMLControls, Controls, IWGlobal, meIWButton,
  Vcl.Graphics, meIWImage, meIWEdit, meIWGrid;

type
  TParametriForm = record
    Progressivo: Integer;
    Dal,
    Al,
    DataFiltro: TDateTime;
    Tooltip,
    Chiamante,
    Matricola,
    CaptionIndietro,
    Causale:String;
    Completa,Singolo:Boolean;
  end;

  TR010FPaginaWeb = class(TWR010FBase)
    lblCommentoCorrente: TmeIWLabel;
    procedure IWAppFormCreate(Sender: TObject);
    procedure TemplateProcessorUnknownTag(const AName: string; var VValue: string);
    procedure IWAppFormDestroy(Sender: TObject);
  private
    function IsMenuVisibile: Boolean;
    procedure CreaIconeAccessoRapido;
    procedure ImpostaNotificheIconeAccessoRapido(const PImg: TmeIWImageFile = nil);
    procedure DistruggiIconeAccessoRapido;
  protected
    Responsabile: Boolean;
    procedure GestioneMenu; override;
    procedure NascondiMenu; override;
    procedure AggiornaIconeAccessoRapido; override;
    procedure AggiornaIconaAccessoRapido; override;
    function  GetInfoDebug: String; override;
    function  GetNomeFunzione: String; override;
    function  GetProgressivo: Integer; override;
    procedure AbilitazioneComponente(Componente:TIWCustomControl; Abilita:Boolean);
  public
    ParametriForm: TParametriForm;
    OldTag,
    OldArrInd: Integer;
    OldNewForm: Boolean;
    procedure SetParam(const Chiave, Valore: String); override;
    function  IsLoginForm: Boolean; override;
    procedure MessaggioStatus(const PTipo,PTesto,PTestoPopup: String; const PDurataPopup: Integer = 5000; const PDurataTesto: Integer = -1); override;
  end;

implementation

{$R *.dfm}

uses W001UIrisWebDtM, W001ULogin;

procedure TR010FPaginaWeb.IWAppFormCreate(Sender: TObject);
begin
  inherited;

  lblCommentoCorrente.Caption:='';

  // inizializzazione parametri
  ParametriForm.Progressivo:=-1;
  ParametriForm.Matricola:='';
  ParametriForm.Tooltip:='';
  ParametriForm.Dal:=0;
  ParametriForm.Al:=0;
  ParametriForm.DataFiltro:=0;
  ParametriForm.Chiamante:='';
  ParametriForm.CaptionIndietro:='';
  ParametriForm.Completa:=False;
  ParametriForm.Singolo:=False;
  ParametriForm.Causale:='';
end;

procedure TR010FPaginaWeb.IWAppFormDestroy(Sender: TObject);
begin
  try
    if WR000DM <> nil then
      WR000DM.NotificheAttivita.AttivaRefresh(Tag);
  except
  end;
  try DistruggiIconeAccessoRapido; except end;
  inherited;
end;

procedure TR010FPaginaWeb.SetParam(const Chiave, Valore: String);
var
  Par: String;
begin
  inherited SetParam(Chiave,Valore);

  // gestione parametri speciali
  Par:=UpperCase(Chiave);

  if Par = 'PROGRESSIVO' then
    ParametriForm.Progressivo:=StrToInt(Valore)
  else if Par = 'MATRICOLA' then
    ParametriForm.Matricola:=Valore
  else if Par = 'DAL' then
    ParametriForm.Dal:=StrToDate(Valore)
  else if Par = 'AL' then
    ParametriForm.Al:=StrToDate(Valore)
  else if Par = 'SINGOLO' then
    ParametriForm.Singolo:=StrToBool(Valore)
  else if Par = 'DATA_FILTRO' then
    ParametriForm.DataFiltro:=StrToDate(Valore)
  else if Par = 'CAPTION_INDIETRO' then
    ParametriForm.CaptionIndietro:=Valore
  else if Par = 'COMPLETA' then
    ParametriForm.Completa:=StrToBool(Valore)
  else if Par = 'CHIAMANTE' then
    ParametriForm.Chiamante:=Valore
  else if Par = 'CAUSALE' then
    ParametriForm.Causale:=Valore;
end;

function TR010FPaginaWeb.IsMenuVisibile:Boolean;
// determina se il menu deve essere visualizzato
begin
  Result:=False;

  // menu nascosto se form di login / progetto X001
  if IsLoginForm or (medpCodiceForm = 'X001') then
  begin
    Log('Traccia','Menu principale nascosto: form ' + medpCodiceForm);
    Exit;
  end;

  // menu nascosto se "Elenco anagrafe" non è presente nella history
  if WR000DM.History.FormByTag(-2) = nil then
  begin
    Log('Traccia','Menu principale nascosto: "Elenco anagrafe" non presente nella history - form ' + medpCodiceForm);
    Exit;
  end;

  // menu nascosto se pagina singola
  if (WR000DM.PaginaSingola <> '') and (WR000DM.PaginaSingola = WR000DM.PaginaIniziale) then
  begin
    Log('Traccia','Menu principale nascosto: Pagina singola ' + WR000DM.PaginaSingola);
    Exit;
  end;

  if Tag = -1 then
  begin
    Log('Traccia','Menu principale nascosto: "Ricerca anagrafe"');
    Exit;
  end;

  // il menu è visualizzabile
  Result:=True;
end;

procedure TR010FPaginaWeb.GestioneMenu;
// N.B.: override
// qesta procedure viene richiamata nella WR010UBase
begin
  // form di login -> menu non creato
  if IsLoginForm then
    Exit;

  // se necessario, crea il menu
  if WMenuFM = nil then
  begin
    WMenuFM:=TWC501FMenuIrisWebFM.Create(Self);
    TraduzioneElementi(WMenuFM);
  end;

  // icone di accesso rapido
  if Length(IconeAccessoRapidoArr) = 0 then
    CreaIconeAccessoRapido;

  if not IsMenuVisibile then
  begin
    NascondiMenu;
    Exit;
  end;
end;

procedure TR010FPaginaWeb.NascondiMenu;
var
  i: Integer;
begin
  inherited;

  // icone di accesso rapido
  for i:=Low(IconeAccessoRapidoArr) to High(IconeAccessoRapidoArr) do
    try IconeAccessoRapidoArr[i].Visible:=False except end;
end;

procedure TR010FPaginaWeb.CreaIconeAccessoRapido;
// creazione delle icone di accesso rapido alle funzioni
// N.B.: la visibilità delle icone è determinata in WR010UBase.AbilitaFunzioni
var
  i, x, f: Integer;
  UrlImg, Code, FunzDesc: String;
  TmpMenu: TWC501FMenuIrisWebFM;
  Azione: TAction;
  ImgList: TStringList;
  FunzAbil: Boolean;
begin
  // PRE: Length(IconeMenuArr) = 0;

  // esce subito se il menu non è creato
  if IsLoginForm or (not Assigned(WMenuFM)) then
    Exit;

  // ciclo su ActionList per riportare le icone
  ImgList:=TStringList.Create;
  TmpMenu:=(WMenuFM as TWC501FMenuIrisWebFM);
  for i:=0 to TmpMenu.ActionList.ActionCount - 1 do
  begin
    Azione:=(TmpMenu.ActionList.Actions[i] as TAction);
    UrlImg:='';

    // se l'azione è legata ad un'immagine determina l'abilitazione
    // della funzione e e crea l'icona corrispondente
    if Azione.ImageIndex > -1 then
    begin
      // determina se la funzione è abilitata (S/R) oppure no
      FunzAbil:=False;
      for f:=0 to High(Parametri.AbilitazioniFunzioni) do
      begin
        if Parametri.AbilitazioniFunzioni[f].Tag = Azione.Tag then
        begin
          FunzAbil:=(Parametri.AbilitazioniFunzioni[f].Inibizione = 'S') or
                    (Parametri.AbilitazioniFunzioni[f].Inibizione = 'R');
          FunzDesc:=Azione.Caption;
          // in alcuni casi particolari l'abilitazione della funzione viene *COMPLETAMENTE* bypassata
          case Azione.Tag of
            421: // cambio profilo: abilitato se l'utente ha più profili disponibili
              begin
                FunzAbil:=False;
                if (WR000DM <> nil) and (WR000DM.TipoUtente <> 'Supervisore') then
                begin
                  FunzAbil:=WR000DM.IsCambioProfiloAbilitato;
                end;
              end;
            453: // cambio azienda
              begin
                FunzAbil:=WR000DM.IsCambioAziendaAbilitato;
              end;
          end;

          // disabilita funzioni legate a iter autorizzativi in caso di accesso operatore
          if FunzAbil and
             (WR000DM <> nil) and
             (WR000DM.TipoUtente = 'Supervisore') and
             ((Pos('Autorizzazione',FunzDesc) = 1) or
              (FunzDesc = 'Validazione cartellino')) then
            FunzAbil:=False;
          Break;
        end;
      end;

      if FunzAbil then
      begin
        // crea una nuova icona e la aggiunge all'array
        x:=Length(IconeAccessoRapidoArr);
        SetLength(IconeAccessoRapidoArr,x + 1);

        IconeAccessoRapidoArr[x]:=TmeIWImageFile.Create(Self);
        IconeAccessoRapidoArr[x].Name:=Format('imgIcona%.2d',[x + 1]); // es. "imgIcona01"
        IconeAccessoRapidoArr[x].Parent:=Self;
        IconeAccessoRapidoArr[x].AltText:=Azione.Caption;
        IconeAccessoRapidoArr[x].Cacheable:=True;
        IconeAccessoRapidoArr[x].Css:='icona_sez3';
        IconeAccessoRapidoArr[x].Hint:=Azione.Hint;
        IconeAccessoRapidoArr[x].FriendlyName:=Azione.Hint;
        if Azione.Tag > -1 then
        begin
          UrlImg:=WR000DM.IWImageList.ExtractImageToCache(Azione.ImageIndex);
          IconeAccessoRapidoArr[x].ImageFile.URL:=UrlImg;
          ImgList.Add(UrlImg);
        end;
        IconeAccessoRapidoArr[x].Tag:=Azione.Tag;
        IconeAccessoRapidoArr[x].OnClick:=TmpMenu.actExecute;
      end;
    end;
  end;

  // utilizza una funzione js per precaricare le immagini
  if ImgList.Count > 0 then
  begin
    Code:=// funzione javascript per precaricare le immagini
          'try {                  '#13#10 +
          '  preloadImgVar("%s"); '#13#10 +
          '}                      '#13#10 +
          'catch(err) {}          '#13#10;
    Code:=Format(Code.Trim,[ImgList.CommaText]);
    AddToInitProc(Code);
  end;
  FreeAndNil(ImgList);
end;

procedure TR010FPaginaWeb.AggiornaIconeAccessoRapido;
// aggiorna le icone di accesso rapido:
//   verifica alcune abilitazioni e aggiorna i contatori delle notifiche
var
  LImgW026Rich, LImgW026Aut: TmeIWImageFile;
  i: Integer;
begin
  // l'aggiornamento è effettuato solo se il menu è visibile
  if not IsMenuVisibile then
    Exit;

  // disabilita icona di accesso rapido "autorizzazione ecced. giornaliere"
  // in base a parametro aziendale C90_W026TipoRichiesta
  // cfr. WC501UMenuIrisWebFM.actExecute
  if Parametri.CampiRiferimento.C90_W026TipoRichiesta = 'A' then
  begin
    LImgW026Rich:=nil;
    LImgW026Aut:=nil;
    for i:=Low(IconeAccessoRapidoArr) to High(IconeAccessoRapidoArr) do
    begin
      case IconeAccessoRapidoArr[i].Tag of
        432: LImgW026Rich:=IconeAccessoRapidoArr[i];
        433: LImgW026Aut:=IconeAccessoRapidoArr[i];
      end;

      // se entrambe le icone sono state trovate esce, termina
      if (LImgW026Rich <> nil) and (LImgW026Aut <> nil) then
        Break;
    end;

    // nasconde l'icona di autorizzazione ecced. gg.
    // e modifica il tooltip e l'immagine dell'icona di richiesta
    if (LImgW026Rich <> nil) and
       (LImgW026Rich.Visible) and
       (LImgW026Aut <> nil) and
       (LImgW026Aut.Visible) then
    begin
      LImgW026Aut.Visible:=False;
      LImgW026Rich.Hint:=LImgW026Aut.Hint;
      LImgW026Rich.ImageFile.URL:=LImgW026Aut.ImageFile.URL;
    end;
  end;

  // aggiorna contatore notifiche
  ImpostaNotificheIconeAccessoRapido;
end;

procedure TR010FPaginaWeb.AggiornaIconaAccessoRapido;
// imposta le notifiche sull'icona di accesso rapido associata a questa maschera
var
  i: Integer;
  IWImg: TmeIWImageFile;
  T1: TDateTime;
const
  FUNZIONE = 'R010.AggiornaIconaAccessoRapido';
begin
  // l'aggiornamento è effettuato solo se il menu è visibile
  if not IsMenuVisibile then
    Exit;

  // gestione legata ad un parametro aziendale
  if Parametri.CampiRiferimento.C90_NotificatoreAttivita <> 'S' then
    Exit;

  // cronometro
  T1:=Now;

  for i:=Low(IconeAccessoRapidoArr) to High(IconeAccessoRapidoArr) do
  begin
    IWImg:=IconeAccessoRapidoArr[i];
    if IWImg.Tag = Self.Tag then
    begin
      ImpostaNotificheIconeAccessoRapido(IWImg);
      Break;
    end;
  end;

//  LogConsoleTime(FUNZIONE,T1);
end;

procedure TR010FPaginaWeb.ImpostaNotificheIconeAccessoRapido(const PImg: TmeIWImageFile = nil);
// PImg
//   =  nil -> tutte le icone
//   <> nil -> solo l'icona indicata
var
  i: Integer;
  // LTestoLog: String;
  T1, T2: TDateTime;
  LIWImg: TmeIWImageFile;
  LNotifiche: TNotificaAttivita;
const
  FUNZIONE = 'R010.ImpostaNotificheIconeAccessoRapido';
  IMG_DATA_ATTRIBUTE_FMT = 'data-notification-counter=%s';
  DATO_ERR               = '?';
begin
  // l'aggiornamento è effettuato solo se il menu è visibile
  if not IsMenuVisibile then
    Exit;

  // gestione legata ad un parametro aziendale
  if Parametri.CampiRiferimento.C90_NotificatoreAttivita <> 'S' then
    Exit;

  // LTestoLog:=Format('%-*s',[60,'[delphi] ' + FUNZIONE + '...']);
  // LogConsole(LTestoLog);

  // cronometro
  T1:=Now;

  // imposta le notifiche su ogni icona associata ad una funzione
  for i:=Low(IconeAccessoRapidoArr) to High(IconeAccessoRapidoArr) do
  begin
    LIWImg:=IconeAccessoRapidoArr[i];

    if (PImg = nil) or (PImg = LIWImg) then
    begin
      // notifiche funzione
      T2:=Now;
      //LNotifiche:=(WMenuFM as TWC501FMenuIrisWebFM).GetNotificheAttivitaByTag(IWImg.Tag);
      LNotifiche:=WR000DM.GetNotificheAttivitaByTag(LIWImg.Tag);
      // LogConsoleTime(Format('     |_ [%s]',[L021SiglaByTag(LIWImg.Tag)]),T2);
      LIWImg.ExtraTagParams.Text:='';
      LIWImg.Hint:=LIWImg.FriendlyName;

      // se sono presenti notifiche imposta un data-attribute sul tag <img>
      // se il numero di notifiche è negativo, indica che c'è stato un errore durante il calcolo
      if LNotifiche.Contatore <> 0 then
      begin
        if LNotifiche.Contatore > 0 then
        begin
          // contatore
          LIWImg.ExtraTagParams.Text:=Format(IMG_DATA_ATTRIBUTE_FMT,[LNotifiche.Contatore.ToString]);
          LIWImg.Hint:=Format('%s<br/>%s',[LIWImg.FriendlyName,LNotifiche.Messaggio]);
        end
        else
        begin
          // situazione di errore
          LIWImg.ExtraTagParams.Text:=Format(IMG_DATA_ATTRIBUTE_FMT,[DATO_ERR]);
          LIWImg.Hint:=Format('%s<br/><span class=''segnalazione''>(%s)</span>',[LIWImg.FriendlyName,LNotifiche.Messaggio]);
        end;
      end;
    end;
  end;

  // LogConsoleTime('     |_ TOTALE ----------------------------->',T1);
end;

procedure TR010FPaginaWeb.DistruggiIconeAccessoRapido;
// distruzione icone di accesso rapido
var
  i: Integer;
begin
  for i:=Low(IconeAccessoRapidoArr) to High(IconeAccessoRapidoArr) do
    try FreeAndNil(IconeAccessoRapidoArr[i]); except end;

  SetLength(IconeAccessoRapidoArr,0);
end;

function TR010FPaginaWeb.IsLoginForm: Boolean;
begin
  Result:=medpCodiceForm = 'W001';
end;

procedure TR010FPaginaWeb.TemplateProcessorUnknownTag(const AName: string; var VValue: string);
begin
  if (WR000DM = nil) or (WR000DM.lstCompInvisibili = nil) then
    Exit;

  if WR000DM.lstCompInvisibili.IndexOf(Format('<%s>',[UpperCase(AName)])) >= 0 then
    Exit;

  inherited TemplateProcessorUnknownTag(AName,VValue);
end;

function TR010FPaginaWeb.GetInfoDebug: String;
var
  Info: String;
  i: Integer;
  DsAperti: Boolean;
begin
  Info:='[ Data e ora webserver ]' + CRLF + FormatDateTime('dd/mm/yyyy hhhh.mm.ss',Now) + CRLF + CRLF;
  try
    if WR000DM = nil then
      Exit;

    // parametri utente
    Info:=Info + '[ Dati utente ]' + CRLF;
    if IsLoginForm then
      Info:=Info + 'Utente non loggato' + CRLF
    else
      Info:=Info + 'TipoUtente: ' + WR000DM.TipoUtente + CRLF +
            'Responsabile: ' + IfThen(WR000DM.Responsabile,'S','N') + CRLF +
            'Inibizione individuale: ' + IfThen(Parametri.InibizioneIndividuale,'S','N') + CRLF +
            'AccessoDirettoValutatore: ' + WR000DM.AccessoDirettoValutatore + CRLF;

    // parametri aziendali
    Info:=Info + CRLF + '[ Parametri generici ]' + CRLF +
          'Num. righe tabella: ' + IfThen(Parametri.CampiRiferimento.C90_WebRighePag = '','-',Parametri.CampiRiferimento.C90_WebRighePag) + CRLF +
          'LogoutUrl: ' + IfThen(WR000DM.LogoutUrl = '','-',WR000DM.LogoutUrl) + CRLF;

    // form array
    if WR000DM.History <> nil then
    begin
      Info:=Info + Format('FormArray num. elem: %d'#13#10'GGetWebApplicationThreadVar.ActiveFormCount: %d',
                          [WR000DM.History.Count,GGetWebApplicationThreadVar.ActiveFormCount]) + CRLF;
    end;

    // parametri form
    Info:=Info + CRLF +
          '[ Parametri form ]' + CRLF +
          'Chiamante: ' + IfThen(ParametriForm.Chiamante = '','-',ParametriForm.Chiamante) + CRLF +
          'Progressivo: ' + IfThen(ParametriForm.Progressivo < 0,'-',IntToStr(ParametriForm.Progressivo)) + CRLF +
          'Dal: ' + IfThen(ParametriForm.Dal = 0,'-',DateToStr(ParametriForm.Dal)) + ' / ' +
          'Al: ' + IfThen(ParametriForm.Al = 0,'-',DateToStr(ParametriForm.Al)) + CRLF +
          'DataFiltro: ' + IfThen(ParametriForm.DataFiltro = 0,'-',DateToStr(ParametriForm.DataFiltro)) + CRLF +
          'Matricola: ' + IfThen(ParametriForm.Matricola = '','-',ParametriForm.Matricola) + CRLF;

    // dataset anagrafico
    Info:=Info + CRLF + '[ Dataset anagrafico ]' + CRLF;
    with WR000DM.cdsI010 do
    begin
      if Active then
        Info:=Info + Format('cdsI010.Filtered: %s'#13#10'cdsI010.RecordCount: %d',
                            [IfThen(Filtered,'True','False'),
                             RecordCount]) + CRLF
      else
        Info:=Info + 'cdsI010.Active: False' + CRLF;
    end;

    // jquery widget
    Info:=Info + CRLF + '[ jQuery widget ]' + CRLF +
          'jqPublicIP.Enabled: ' + IfThen(jqPublicIP.Enabled,'True','False') + CRLF;

    // database
    DsAperti:=False;
    Info:=Info + CRLF + '[ Dataset condivisi aperti ]' + CRLF;
    for i:=0 to WR000DM.ComponentCount - 1 do
    begin
      if WR000DM.Components[i] is TOracleDataSet then
      begin
        with (WR000DM.Components[i] as TOracleDataSet) do
        begin
          if Active then
          begin
            Info:=Info + Format('%s: Tag = %d Recordcount = %d',
                         [Name,Tag,RecordCount]) + CRLF;
            DsAperti:=True;
          end;
        end
      end;
    end;
    if not DsAperti then
      Info:=Info + 'Nessun dataset' + CRLF;

    // filtro dipendenti
    {
    Info:=Info + CRLF + '[ Selezione anagrafica principale ]' + CRLF;
    if IsLoginForm then
      Info:=Info + 'Nessuna selezione'
    else
      Info:=Info + 'FiltroRicerca:' + CRLF + WR000DM.FiltroRicerca + CRLF +
            'OrdinamentoRicerca:' + CRLF + WR000DM.OrdinamentoRicerca;
    }
  except
    on E: Exception do
      Log('Errore','Errore durante lettura informazioni debug',E);
  end;

  Result:=Info;
end;

function TR010FPaginaWeb.GetNomeFunzione: String;
var
  x: Integer;
begin
  // gestione casi particolari
  Result:='';

  // traduzione in lingua inglese
  //if (Parametri.CampiRiferimento.C1_CedoliniConValuta = 'S') and
  if (Parametri.CampiRiferimento.C90_Lingua <> '') and
     (WR000DM.cdsI015.Active) then
  begin
    // filtro del clientdataset sui componenti della maschera attuale + comp. ereditati
    with WR000DM do
    begin
      cdsI015.Filtered:=False;
      cdsI015.Filter:=Format('(MASCHERA = ''%s'') and (COMPONENTE = ''Title'')',[medpNomeForm]);
      cdsI015.Filtered:=True;
      if cdsI015.RecordCount > 0 then
      begin
        // verifica caption del tipo "(W000) Titolo form"
        x:=Pos(')',cdsI015.FieldByName('CAPTION').AsString);
        if x = 0 then
          Result:=cdsI015.FieldByName('CAPTION').AsString
        else
          Result:=Copy(cdsI015.FieldByName('CAPTION').AsString,x + 2,MaxInt);
      end;
    end;
  end;

  // nessuna traduzione per l'elemento: gestione normale
  if Result = '' then
  begin
    if (Tag = 432) and
       (Parametri.CampiRiferimento.C90_W026TipoRichiesta = 'A') then
    begin
      // caso particolare delle eccedenze giornaliere
      Result:='Autorizzazione ecced. giornaliere';
    end
    else
    begin
      Result:=inherited GetNomeFunzione;
    end;
  end;
end;

function TR010FPaginaWeb.GetProgressivo: Integer;
begin
  Result:=-1;
  if WR000DM <> nil then
    if WR000DM.cdsAnagrafe.Active then
      Result:=WR000DM.cdsAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
end;

procedure TR010FPaginaWeb.AbilitazioneComponente(Componente:TIWCustomControl; Abilita:Boolean);
// abilita / disabilita il componente specificato
var
  r,c:Integer;
begin
  if Componente is TIWCustomLabel then
  begin
    // label: simula abilitazione via css (cfr. meIWLabel)
    with TIWCustomLabel(Componente) do
    begin
      Enabled:=Abilita;
    end;
  end
  else if Componente is TIWGrid then
  begin
    // grid: ciclo sui componenti relativi
    with Componente as TIWGrid do
    begin
      for r:=0 to RowCount - 1 do
      begin
        for c:=0 to ColumnCount - 1 do
        begin
          if not Abilita then
            Cell[r,c].Clickable:=False;
          if Assigned(Cell[r,c].Control) then
            AbilitazioneComponente(Cell[r,c].Control,Abilita);
        end;
      end;
    end;
  end
  else if Componente is TIWRadioGroup then
  begin
    // radio group
    with TIWRadioGroup(Componente) do
    begin
      Editable:=Abilita;
      Enabled:=Abilita;
    end;
  end
  else if Componente is TIWCustomComboBox then
  begin
    // combobox
    with (Componente as TIWCustomComboBox) do
    begin
      Enabled:=Abilita;
    end;
  end
  else if Componente is TIWCustomCheckBox then
  begin
    // checkbox
    with (Componente as TIWCustomCheckBox) do
    begin
      Editable:=Abilita;
      Enabled:=Abilita;
    end;
  end
  else if Componente is TIWCustomEdit then
  begin
    // edit
    with (Componente as TIWCustomEdit) do
    begin
      Editable:=Abilita;
      Enabled:=Abilita;
    end;
  end
  else if Componente is TIWCustomMemo then
  begin
    // memo
    with (Componente as TIWCustomMemo) do
    begin
      Editable:=Abilita;
      Enabled:=Abilita;
    end;
  end
  else
  begin
    // altro tipo di componente
    Componente.Enabled:=Abilita;
  end;
end;

procedure TR010FPaginaWeb.MessaggioStatus(const PTipo,PTesto, PTestoPopup: String; const PDurataPopup: Integer = 5000; const PDurataTesto: Integer = -1);
var
  Stile,S,SPop,TestoJS,TestoJSPopup,
  ObjName,DurataTestoStr: String;
const
  // costanti di tempo per effetti - valori espressi in millisecondi
  HIGHLIGHT_TIME      = 1200; // durata evidenziazione testo
  FADE_IN_TIME_TESTO  = 1200; // durata dissolvenza in entrata del testo
  FADE_IN_TIME_POPUP  = 1500; // durata dissolvenza in entrata del popup
  FADE_OUT_TIME_TESTO = 1500; // durata dissolvenza in uscita del testo
  FADE_OUT_TIME_POPUP = 4000; // ms per effetto di dissolvenza in uscita del popup
begin
  // determina stile messaggio in base al tipo
  if PTipo = INFORMA then
    Stile:='informazione'
  else if PTipo = ESCLAMA then
    Stile:='esclamazione'
  else if PTipo = ERRORE then
    Stile:='segnalazione'
  else
    raise Exception.Create('Parametri errati per la funzione TR010FPaginaWeb.MessaggioStatus');

  lblCommentoCorrente.Css:=Stile;
  if not jQAlert.Enabled then
  begin
    // visualizzazione messaggio statico
    lblCommentoCorrente.Caption:=PTesto;
    lblCommentoCorrente.Hint:=PTestoPopup;
  end
  else
  begin
    // visualizzazione messaggio con effetti jquery
    // rimuove e sostituisce caratteri pericolosi dal testo per visualizzazione via javascript
    if PTesto = '' then
      TestoJS:=''
    else
      TestoJS:=C190EscapeJS(PTesto);
    if PTestoPopup = '' then
      TestoJSPopup:=''
    else
      TestoJSPopup:=C190EscapeJS(PTestoPopup);

    // prepara codice javascript
    jqAlert.OnReady.Clear;
    ObjName:=lblCommentoCorrente.HTMLName;

    // testo messaggio
    S:='$("#int_sez4").hide().attr("class","%s"); ' +
       '$("#%s").text("%s"); ' +
       '$("#int_sez4").animate({opacity: "toggle", height: "toggle"},%d).delay(1000).effect("highlight",%d)%s';

    if PDurataTesto > 0 then
      DurataTestoStr:=Format('.delay(%d).effect("highlight",%d).hide("slide",{direction: "up"},%d)',[PDurataTesto,HIGHLIGHT_TIME,FADE_OUT_TIME_TESTO])
    else
      DurataTestoStr:='';
    S:=Format(S,[Stile,ObjName,TestoJS,FADE_IN_TIME_TESTO,HIGHLIGHT_TIME,DurataTestoStr]);

    // testo del popup a scomparsa (elemento div in primo piano)
    if (TestoJSPopup <> '') and (PDurataPopup > 0) then
    begin
      if PTipo = ERRORE then
        TestoJSPopup:='Attenzione! Si è verificato il seguente errore:\r\n' + TestoJSPopup;

      if GetBrowser is TInternetExplorer then
        SPop:='$("#avviso").attr("class","").attr("class","%s")'
      else
        SPop:='$("#avviso").attr("class","").addClass("%s")';
      SPop:=SPop + '.hide().text("%s").fadeIn(%d)' +
                   '.delay(%d).effect("transfer",{to: "#int_sez4",className: "ui-effects-transfer"},1000)' +
                   '.fadeOut(100,function(){ %s' +
                   '});';
      S:=Format(Spop,[Stile,TestoJSPopup,FADE_IN_TIME_POPUP,PDurataPopup,S]);
      jqAlert.OnReady.Add(S);
    end
    else
    begin
      jqAlert.OnReady.Add(S);
    end;
  end;
end;

end.
