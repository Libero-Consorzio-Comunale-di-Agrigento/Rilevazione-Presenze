unit WR206UMenuFM;

interface

uses
  Graphics, Jpeg, pngimage,
  A000UInterfaccia, A000UCostanti, A000USessione,
  medpIWMessageDlg, meIWImageFile, meIWImage, meIWLink, OracleData,
  SysUtils, Classes, Controls, Forms, IWAppForm, Menus,
  IWVCLBaseContainer, IWColor, IWContainer, IWRegion, IWHTMLContainer,
  IWHTML40Container, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompMenu, ImgList, meIWImageList, IWImageList, ActnList, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWApplication, IWTemplateProcessorHTML, meIWMenu, System.Actions, WR010UBase,
  Generics.Collections;

(*
  WR206UMenuFM (componenti + eventi comuni)
   -->WC501UMenuIrisWebFM
   -->WR207UMenuWebPJFM (funzioni generiche di webpj)
       -->WC502..504
*)
type
  TCategoriaAzioniRapide = class
    public
      Nome:String;
      ModuloAccessorio:Boolean;
      Azioni:array of TAction;
      constructor Create(Nome:String);
      procedure AggiungiAzione(Azione:TAction);
  end;

  TCategorieAzioniRapide = class(TObjectList<TCategoriaAzioniRapide>)
  public
    constructor Create;
  end;

  TWR206FMenuFM = class(TFrame)
    IWFrameRegion: TIWRegion;
    TemplateProcessor: TIWTemplateProcessorHTML;
    IWMainMenu: TmeIWMenu;
    ActionList: TActionList;
    MainMenu: TMainMenu;
    JQuery: TIWJQueryWidget;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure actExecute(Sender: TObject); virtual;
    procedure IWFrameRegionRender(Sender: TObject);
  private
    procedure GestSeparatori;
    procedure AssociaActionImmagini;
    function FigliVisibili(itmParent: TMenuItem): boolean;
    procedure GestioneSeparatori(itmParent: TMenuItem);
  protected
    OldTag,
    OldArrInd,
    FTag: Integer;
    F: TWR010FBase;
    NewForm,
    OldNewForm,
    ReloadForm,
    OldReloadForm: Boolean;
    function GetCategorieAzioniRapide:TCategorieAzioniRapide;
  public
    A000App: TIWApplication;
  end;

implementation

uses IWGlobal, L021Call, C180FunzioniGenerali, Generics.Defaults;

{$R *.dfm}

{ TCategoriaAzioni }
constructor TCategoriaAzioniRapide.Create(Nome:String);
begin
  Self.Nome:=Nome;
  Self.ModuloAccessorio:=False;
  SetLength(Self.Azioni,0);
end;

procedure TCategoriaAzioniRapide.AggiungiAzione(Azione:TAction);
begin
  SetLength(Self.Azioni,Length(Self.Azioni) + 1);
  Self.Azioni[Length(Self.Azioni) - 1]:=Azione; // Puntatore all'azione
end;

{ TCategorieAzioni }
constructor TCategorieAzioniRapide.Create;
begin
  inherited Create(True);
end;



// verifica se è possibile passare ad un'altra funzione
// considera anche il caso in cui si stia passando ad un altro tab
// per effetto della chiusura della funzione

procedure TWR206FMenuFM.actExecute(Sender: TObject);
var
  CambiaTab: Boolean;
  Conferma: String;
  MyForm: TWR010FBase;
begin
  MyForm:=(Self.Parent as TWR010FBase);
  F:=nil;

  if Sender <> nil then
  begin
    // se l'accesso è da menu / icona di accesso rapido crea sempre una nuova form, (solo per IrisWEB, WEBPJ ricicla la form)
    // se l'accesso è da link (history) verifica se la form richiesta è già nella lista per riutilizzarla
    if (Sender is TMenuItem) or (Sender is TAction) or (Sender is TmeIWImageFile) then
    begin
      // menu principale / icone di accesso rapido
      if Sender is TMenuItem then
      begin
        // menu item
        MyForm.Log('Traccia',Format('WMenuFM.actExecuteClick: menu item "%s" (tag = %d)',[(Sender as TMenuItem).Caption,(Sender as TMenuItem).Tag]));
        FTag:=(Sender as TMenuItem).Tag;
      end
      else if Sender is TAction then
      begin
        // action
        MyForm.Log('Traccia',Format('WMenuFM.actExecuteClick: action "%s" (tag = %d)',[(Sender as TAction).Caption,(Sender as TAction).Tag]));
        FTag:=(Sender as TAction).Tag;
      end
      else
      begin
        // icona
        MyForm.Log('Traccia',Format('WMenuFM.actExecuteClick: icona "%s" (tag = %d)',[(Sender as TmeIWImageFile).Caption,(Sender as TmeIWImageFile).Tag]));
        FTag:=(Sender as TmeIWImageFile).Tag;
      end;

      // ricerca il tag della funzione chiamata nella history
      // se il tag è legato a una form fissa, utilizza questa, altrimenti prevede la creazione di una nuova form
      F:=(WR000DM.History.FormByTag(FTag) as TWR010FBase);
      {$IFNDEF WEBPJ}
      if Pos(INI_PAR_IRISWEB_ENABLE_MULTISCHEDA,W000ParConfig.ParametriAvanzati) > 0 then
      begin
        // Se è consentita l'apertura di schede multiple, possiamo impostare a nil puntatore all'istanza
        // del form nella history. In questo modo verrà imposto di reistanziarne un'altro.
        if F <> nil then
          if not TWR010FBase(F).medpFissa then
            F:=nil;
      end;
      {$ENDIF}
      ReloadForm:=True;
      NewForm:=(F = nil);
    end
    else if Sender is TmeIWLink then
    begin
      // tab della history
      MyForm.Log('Traccia',Format('WMenuFM.actExecuteClick: tab "%s" (tag = %d)',[(Sender as TmeIWLink).Caption,(Sender as TmeIWLink).Tag]));
      NewForm:=False;
      F:=(WR000DM.History.FormByIndex((Sender as TmeIWLink).Tag) as TWR010FBase);
      FTag:=F.Tag;
      ReloadForm:=False;
    end
    else if Sender is {TIWAppForm}TWR010FBase then // le form devono discendere da TWR010FBase
    begin
      // dopo actLinkClose di una form
      MyForm.Log('Traccia',Format('WMenuFM.actExecuteClick: tab "%s" (tag = %d)',[(Sender as TWR010FBase).Title,(Sender as TWR010FBase).Tag]));
      // (seleziona una form attiva)
      NewForm:=False;
      F:=(Sender as TWR010FBase);
      FTag:=F.Tag;
      // assegna il componente history alla form attuale
      WR000DM.History.Assegna(F);
      WR000DM.History.SetHighlighted(F);
      ReloadForm:=False;
    end
    else
      Abort;
  end
  else
  begin
    // variabili impostate dal messaggio di conferma
    MyForm.Log('Traccia','WMenuFM.actExecuteClick: dopo messaggio conferma');
    FTag:=OldTag;
    NewForm:=OldNewForm;
    ReloadForm:=OldReloadForm;

    if (not NewForm) and (OldArrInd > -1) then
      F:=(WR000DM.History.FormByIndex(OldArrInd) as TWR010FBase)
    else
      F:=nil;
  end;

  // verifica se è possibile passare ad un'altra funzione
  // considera anche il caso in cui si stia passando ad un altro tab
  // per effetto della chiusura della funzione
  if (not MsgBox.KeyExists('TAB_CHANGING')) and
     (not MyForm.IsPageClosing) then
  begin
    CambiaTab:=True;
    Conferma:='';
    MyForm.OnTabChanging(CambiaTab,Conferma);
    if not CambiaTab then //passaggio tab inibito
    begin
      if Conferma <> '' then
        MsgBox.WebMessageDlg(Conferma,mtWarning,[mbOk],nil,'');
      Abort;
    end
    else
    begin
      if Conferma <> '' then
      begin
        // chiede conferma
        OldTag:=FTag;
        OldNewForm:=NewForm;
        OldReloadForm:=ReloadForm;
        if (not NewForm) and (Sender is TmeIWLink) then
          OldArrInd:=(Sender as TmeIWLink).Tag
        else
          OldArrInd:=-1;
        MsgBox.WebMessageDlg(Conferma,mtConfirmation,[mbYes,mbNo],MyForm.OnConfermaTabAction,'TAB_CHANGING');
        Abort;
      end;
    end;
  end;

  // se si sta eseguendo un passaggio di tab, nasconde la form corrente per decrementare il numero di form attive
  // non funziona lo stesso...
  {
  if not NewForm then
    MyForm.Hide;
  }
end;

procedure TWR206FMenuFM.IWFrameRegionCreate(Sender: TObject);
var
  i: Integer;
begin
  if Self.Owner <> nil then
  begin
    if Self.Owner is TIWAppForm then
    begin
      Self.Parent:=(Self.Owner as TIWAppForm);
      A000App:=GGetWebApplicationThreadVar;
    end
    else if Self.Owner is TIWApplication then
    begin
      A000App:=(Self.Owner as TIWApplication);
      Self.Parent:=(A000App.ActiveForm as TIWAppForm);
    end;
  end;

  // assegnazione hint alle azioni (se non impostato)
  for i:=0 to ComponentCount - 1 do
  begin
    if (Components[i] is TAction) and ((Components[i] as TAction).Hint = '') then
      (Components[i] as TAction).Hint:=(Components[i] as TAction).Caption;
  end;

  //Massimo 13/01/2014 - caricamento immagini menù
  AssociaActionImmagini;
end;

procedure TWR206FMenuFM.AssociaActionImmagini;
var
  Azione: TAction;
  i: Integer;
begin
  // associa le immagini alle action in base al tag
  MainMenu.Images:=WR000DM.IWImageList;
  ActionList.Images:=WR000DM.IWImageList;
  for i:=0 to ActionList.ActionCount - 1 do
  begin
    Azione:=(ActionList.Actions[i] as TAction);
    // cerca l'imageindex corretto e lo associa
    if Azione.Tag < 0 then
      Azione.ImageIndex:=-1
    else
      Azione.ImageIndex:=WR000DM.TagList.IndexOf(IntToStr(Azione.Tag));
  end;
end;

procedure TWR206FMenuFM.IWFrameRegionRender(Sender: TObject);
begin
  // gestione dei separatori di menu
  GestSeparatori;
end;

function TWR206FMenuFM.FigliVisibili(itmParent: TMenuItem): boolean;
var
  i:Integer;
  itm: TMenuItem;
begin
  if itmParent.Count = 0 then
  begin
    Result:=True;
    exit;
  end;
  Result:=False;
  for i:=0 to itmParent.Count - 1 do
  begin
    itm:=itmParent.Items[i];

    if not itm.IsLine then
    begin
      // voce di menu
      if itm.Visible then
      begin
        if not FigliVisibili(itm) then //se ha figli e sono tutti invisibili nascondo l'item
          itm.Visible:=False
        else
          Result:=True; // voce di livello superiore visibile se almeno una voce di livello 2 è visibile
      end;
    end;
  end;
end;

procedure TWR206FMenuFM.GestioneSeparatori(itmParent: TMenuItem);
var
  i,j:Integer;
  itm: TMenuItem;
  bPrimoElementoVisibile,
  ElementoSuccessivo: boolean;
begin
  bPrimoElementoVisibile:=True;
  for i:=0 to itmParent.Count - 1 do
  begin
    itm:=itmParent.Items[i];
    if itm.Visible then
    begin
      if itm.IsLine then
      begin
        if bPrimoElementoVisibile then  //se il separatore è il primo elemento visibile lo nascondo
        begin
          itm.Visible:=False;
        end
        else
        begin
          //cerca un elemento (non separatore) visibile successivo all'elemento corrente
          ElementoSuccessivo:=False;
          for j:=i+1 to itmParent.Count - 1 do
          begin
            if (itmParent.Items[j].visible) then
            begin
              if itmParent.Items[j].isLine then //se c'è una altro separatore dopo devo nascondere quello prima
                ElementoSuccessivo:=False
              else
                ElementoSuccessivo:=True;

              Break;
            end;
          end;
          if not ElementoSuccessivo then
            itm.Visible:=False;
        end;
      end
      else
        GestioneSeparatori(itm);
      if itm.Visible then //Se ancora visibile, posso averlo nascosto
        bPrimoElementoVisibile:=False;
    end;

  end;
end;

procedure TWR206FMenuFM.GestSeparatori;
// gestione automatica della visualizzazione dei separatori di menu
var
  i: Integer;
  itm: TMenuItem;
begin
  //nascondo voci senza figli visibili
  for i:=0 to MainMenu.Items.Count - 1 do
  begin
    itm:=(MainMenu.Items[i] as TMenuItem);
    if itm.Count = 0 then  //menu senza item figli
      itm.Visible:=False
    else
    begin
      if not FigliVisibili(itm) then
        itm.Visible:=False;
    end;
  end;
  //nascondo separatori doppi
  for i:=0 to MainMenu.Items.Count - 1 do
  begin
    itm:=(MainMenu.Items[i] as TMenuItem);
    if itm.Visible then
      GestioneSeparatori(itm);
  end;
end;

// Fornisce un elenco delle azioni rapide raggruppato per categoria. Considera solo
// le azioni con proprietà Visible = True, quindi le abilitazioni devono essere già state
// eseguite!
function TWR206FMenuFM.GetCategorieAzioniRapide:TCategorieAzioniRapide;
var
  DizionarioCategorie:TDictionary<String,TCategoriaAzioniRapide>;
  DizionarioCategorieEnumerator:TDictionary<String,TCategoriaAzioniRapide>.TValueEnumerator;
  LocCategorieAzioniRapide:TCategorieAzioniRapide;
  CategorieComparer:IComparer<TCategoriaAzioniRapide>;
  Azione:TAction;
  i:Integer;
begin
  // Uso un dizionario per accelerare l'accesso alle categorie già esistenti
  DizionarioCategorie:=TDictionary<String,TCategoriaAzioniRapide>.Create;
  LocCategorieAzioniRapide:=TCategorieAzioniRapide.Create;
  DizionarioCategorieEnumerator:=nil;
  try
    try
      for i:=0 to Self.ActionList.ActionCount - 1 do
      begin
        Azione:=(Self.ActionList.Actions[i] as TAction);
        if (Azione.ImageIndex > -1) and (Azione.Tag > -1) and (Azione.Visible)  then
        begin
          if not DizionarioCategorie.ContainsKey(Azione.Category) then
          begin
            DizionarioCategorie.Add(Azione.Category,TCategoriaAzioniRapide.Create(Azione.Category));
            if Copy(Azione.Category,1,7) = 'Modulo ' then
              DizionarioCategorie.Items[Azione.Category].ModuloAccessorio:=True;
          end;
          DizionarioCategorie.Items[Azione.Category].AggiungiAzione(Azione);
        end;
      end;
      // Riverso le categorie in una lista (TCategorieAzioniRapide)
      DizionarioCategorieEnumerator:=DizionarioCategorie.Values.GetEnumerator;
      while DizionarioCategorieEnumerator.MoveNext do
        LocCategorieAzioniRapide.Add(DizionarioCategorieEnumerator.Current);

      // Ordino la lista ponendo prima le funzioni standard, poi i moduli accessori.
      // Gli elementi dello stesso tipo sono ordinati in ordine alfabetico.
      CategorieComparer:=TDelegatedComparer<TCategoriaAzioniRapide>.Create(
        function(const Left, Right: TCategoriaAzioniRapide): Integer
        begin
          if (Left.ModuloAccessorio) and (not Right.ModuloAccessorio) then
            Result:=1
          else if (not Left.ModuloAccessorio) and (Right.ModuloAccessorio) then
            Result:=-1
          else
            Result:=CompareText(Left.Nome,Right.Nome);
        end
      );
      LocCategorieAzioniRapide.Sort(CategorieComparer);
      Result:=LocCategorieAzioniRapide;
    except
      on E:Exception do
      begin
        // Se qualcosa non funziona ci assicuriamo di liberare il TCategorieAzioniRapide.
        // E' un ObjectList, effettua in automatico la free() dei propri elementi
        // (oggetti di tipo TCategoriaAzioniRapide, hanno i puntatori alle azioni ma queste
        // NON vengono dellocate).
        FreeAndNil(LocCategorieAzioniRapide);
        // Proviamo a liberiamo il contenuto del dizionario, potrebbero esserci
        // oggetti TCategoriaAzioniRapide che non siamo riusciti a copiare nella lista.
        if DizionarioCategorieEnumerator <> nil then
          FreeAndNil(DizionarioCategorieEnumerator);
        DizionarioCategorieEnumerator:=DizionarioCategorie.Values.GetEnumerator;
        while DizionarioCategorieEnumerator.MoveNext do
        begin
          try DizionarioCategorieEnumerator.Current.Destroy; except end;
        end;
        FreeAndNil(DizionarioCategorieEnumerator);
        DizionarioCategorieEnumerator:=nil;
        Result:=nil;
      end;
    end;
  finally
    if DizionarioCategorieEnumerator <> nil then
      FreeAndNil(DizionarioCategorieEnumerator);
    // Il dizionario non si occupa di effettuare la free() dei puntatori alle categorie
    FreeAndNil(DizionarioCategorie);
    // Il comparer non va deallocato.
  end;
end;

end.