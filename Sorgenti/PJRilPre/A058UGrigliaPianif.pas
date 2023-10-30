unit A058UGrigliaPianif;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, ExtCtrls, C180FunzioniGenerali, Menus, StdCtrls, Buttons,
  ComCtrls, DB, RegistrazioneLog, OracleData, Oracle, DatiBloccati,
  C700USelezioneAnagrafe, A000UCostanti, A000USessione, A000UInterfaccia, A000UMessaggi, R600,
  Variants, A004UGiustifAssPres, A040UPianifRep, A083UMsgElaborazioni,
  C001StampaLib, C020UVisualizzaDataSet, C013UCheckList, A058ULegenda,
  StrUtils, Math, Clipbrd, A058UPianifTurniDtM1;

const
  ALTEZZA_RIGA = 15;

type
  TA058FGrigliaPianif = class(TForm)
    Panel1: TPanel;
    GVista: TStringGrid;
    BRegistrazione: TBitBtn;
    BitBtn3: TBitBtn;
    PopupMenu1: TPopupMenu;
    Modifica1: TMenuItem;
    PGVista: TProgressBar;
    BCancellazione: TBitBtn;
    btnAnteprima: TBitBtn;
    Panel2: TPanel;
    btnTurno1: TSpeedButton;
    btnAnomalie: TBitBtn;
    BOperativa: TBitBtn;
    LblModificaRapida: TLabel;
    N1: TMenuItem;
    Visualizzadebito1: TMenuItem;
    Visualizzacopertura1: TMenuItem;
    Visualizzaturni: TMenuItem;
    Visualizzaassenze: TMenuItem;
    CompetenzeResiduiassenza1: TMenuItem;
    Visualizzadettaglioorariogiornaliero1: TMenuItem;
    N2: TMenuItem;
    VisualizzaRiposiFestivi: TMenuItem;
    VisualizzaLimitiMinMax1: TMenuItem;
    VisualizzaCoperturaSquadre1: TMenuItem;
    LblOPerazioni: TLabel;
    Copiapianificazione1: TMenuItem;
    InsCancGiust1: TMenuItem;
    ValidaCausale1: TMenuItem;
    VisualizzaAssenze1: TMenuItem;
    N3: TMenuItem;
    Visualizzacolonnamatricola1: TMenuItem;
    Visualizzazionesintetica1: TMenuItem;
    Reperibilit1: TMenuItem;
    popmnuModificaRapida: TPopupMenu;
    mnuFastPrimoturno: TMenuItem;
    mnuFastPrimaassenza: TMenuItem;
    mnuFastOrario: TMenuItem;
    btnAssenza1: TSpeedButton;
    btnOrario: TSpeedButton;
    btnAntincendio: TSpeedButton;
    chkElaborazioneAnnuale: TCheckBox;
    N4: TMenuItem;
    Visualizzaassenzemezzagiorn1: TMenuItem;
    Visualizzaassenzeadore1: TMenuItem;
    btnFiltroAnomalie: TBitBtn;
    Visualizzaprogressividiturnazione1: TMenuItem;
    CopiainExcel1: TMenuItem;
    Panel3: TPanel;
    Panel4: TPanel;
    btnLegenda: TButton;
    btnSblocca1: TSpeedButton;
    btnBlocca1: TSpeedButton;
    lblBlocca: TLabel;
    RicercaSostituti1: TMenuItem;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure VisualizzaLimitiMinMax1Click(Sender: TObject);
    procedure VisualizzaRiposiFestiviClick(Sender: TObject);
    procedure GVistaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure GVistaClick(Sender: TObject);
    procedure Visualizzadettaglioorariogiornaliero1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GVistaDrawCell(Sender: TObject; Col, Row: Integer; Rect: TRect; State: TGridDrawState);
    procedure GVistaMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Modifica1Click(Sender: TObject);
    procedure BRegistrazioneClick(Sender: TObject);
    procedure BCancellazioneClick(Sender: TObject);
    procedure btnAnteprimaClick(Sender: TObject);
    procedure GVistaKeyPress(Sender: TObject; var Key: Char);
    procedure btnTurno1Click(Sender: TObject);
    procedure GVistaSelectCell(Sender: TObject; Col, Row: Integer; var CanSelect: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAnomalieClick(Sender: TObject);
    procedure BOperativaClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Visualizzadebito1Click(Sender: TObject);
    procedure Visualizzacopertura1Click(Sender: TObject);
    procedure VisualizzaturniClick(Sender: TObject);
    procedure VisualizzaassenzeClick(Sender: TObject);
    procedure CompetenzeResiduiassenza1Click(Sender: TObject);
    procedure VisualizzaCoperturaSquadre1Click(Sender: TObject);
    procedure GVistaDblClick(Sender: TObject);
    procedure Copiapianificazione1Click(Sender: TObject);
    procedure InsCancGiust1Click(Sender: TObject);
    procedure ValidaCausale1Click(Sender: TObject);
    procedure VisualizzaAssenze1Click(Sender: TObject);
    procedure Visualizzacolonnamatricola1Click(Sender: TObject);
    procedure Visualizzazionesintetica1Click(Sender: TObject);
    procedure Reperibilit1Click(Sender: TObject);
    procedure mnuModificaRapidaClick(Sender: TObject);
    procedure Visualizzaassenzemezzagiorn1Click(Sender: TObject);
    procedure Visualizzaassenzeadore1Click(Sender: TObject);
    procedure btnFiltroAnomalieClick(Sender: TObject);
    procedure Visualizzaprogressividiturnazione1Click(Sender: TObject);
    procedure CopiainExcel1Click(Sender: TObject);
    procedure btnLegendaClick(Sender: TObject);
    procedure btnBloccaSbloccaClick(Sender: TObject);
  private
    { Private declarations }
    FastGiust,TastoPremuto:String;
    ColSelectCel, RowSelectCel: Integer;
    AssenzeAbilitate,ReperibilitaAbilitata,PianifNonOperativa,AbilitazioneA126 :Boolean;
    A058FLegenda:TA058FLegenda;
    procedure DisegnaElementoCella(ElementoCellaUI:TElementoCellaUI;CellaSelezionata:Boolean); overload;
    procedure DisegnaElementoCella(ElementoCellaUI:TElementoCellaUI;CellaSelezionata:Boolean;Area:String); overload;
    procedure PreparaLeggiValoriCella(iDipendente:Integer = -1;iGiorno:Integer = -1);
    procedure procProgressBarInizio;
    procedure procProgressBarNext;
    procedure procProgressBarFine;
  public
    { Public declarations }
    DatoModificato:Boolean;
    nRigheBloccate:integer;
    nColonneBloccate:integer;
    procedure ImpostaAltezzaRiga(iDip:Integer);
  end;

var
  A058FGrigliaPianif: TA058FGrigliaPianif;

implementation

uses
  A058UPianifTurni, A058UModPianif,
  A058UDettaglioGiornata, A058UDettaglioTipiOperatori,
  A058UCoperturaSquadra,A058UCopiaPianificazione, A058UTabellone,
  A058UValidaAssenze, A058UStampaAssenze;

{$R *.DFM}

procedure TA058FGrigliaPianif.FormCreate(Sender: TObject);
var
  AbilitaA058:Boolean;
begin
  Application.HintHidePause:=10000;
  chkElaborazioneAnnuale.Visible:=DebugHook = 1;
  nRigheBloccate:=2;
  nColonneBloccate:=6;
  FreeAndNil(A058FDettaglioGiornata);
  FreeAndNil(A058FDettaglioTipiOperatori);
  A058FLegenda:=TA058FLegenda.Create(Self);

  try
    A058FPianifTurniDtM1.selT530.Open;
    if A058FPianifTurniDtM1.selT530.RecordCount = 0 then
      if Not A058FPianifTurni.bVisualizzaSintetica then
      begin
        GVista.DefaultColWidth:=80;
        GVista.Font.Size:=8;
      end
      else
      begin
        GVista.DefaultColWidth:=58;
        GVista.Font.Size:=8;
      end
    else
    begin
      GVista.DefaultColWidth:=100;
      GVista.Font.Size:=8;
    end;
  except
  end;
  LblModificaRapida.Caption:='';
  GVista.RowHeights[0]:=30;
  GVista.ColWidths[0]:=-1;
  GVista.RowHeights[1]:=-1;
  GVista.ColWidths[1]:=80;
  GVista.ColWidths[2]:=-1;
  GVista.ColWidths[3]:=-1;
  GVista.ColWidths[4]:=-1;
  GVista.ColWidths[5]:=-1;
  GVista.Cells[0,0]:='Matricola';
  GVista.Cells[1,0]:='Nome';
  GVista.Cells[2,0]:='Situazione ore';
  GVista.Cells[3,0]:='Tot.turni';
  GVista.Cells[4,0]:='Caus. Fat/Res';
  DatoModificato:=False;

  PianifNonOperativa:=(A058FPianifTurniDtM1.selT082.fieldByName('MODALITA_LAVORO').AsString = 'N') and
                              {(A058FPianifTurniDtm1.TipoPianif = 0) and}
                              (Parametri.CampiRiferimento.C11_PianifOrariProg = 'S');
  AbilitazioneA126:=(A000GetInibizioni('Funzione','OpenA126BloccoRiepiloghi') = 'S') and   //(Tag: 59)
                    (A058FPianifTurniDtm1.DataInizio = R180InizioMese(A058FPianifTurniDtm1.DataInizio)) and
                    (A058FPianifTurniDtm1.DataFine = R180FineMese(A058FPianifTurniDtm1.DataFine));
  btnBlocca1.Visible:=PianifNonOperativa and AbilitazioneA126; // :=False;
  btnSblocca1.Visible:=PianifNonOperativa and AbilitazioneA126; // :=False;
  lblBlocca.Visible:=False;

  if A058FPianifTurniDtm1.selT082.fieldByName('MODALITA_LAVORO').AsString = 'O' then
  begin
    BRegistrazione.Enabled:=Parametri.A058_PianifOperativa <> 'N';
    BCancellazione.Enabled:=Parametri.A058_PianifOperativa = 'S';
    btnTurno1.Visible:=Parametri.A058_PianifOperativa <> 'N';
    btnAssenza1.Visible:=Parametri.A058_PianifOperativa <> 'N';
    btnOrario.Visible:=Parametri.A058_PianifOperativa <> 'N';
    btnAntincendio.Visible:=Parametri.A058_PianifOperativa <> 'N';
  end
  else if A058FPianifTurniDtm1.selT082.fieldByName('MODALITA_LAVORO').AsString = 'N' then
  begin
    BRegistrazione.Enabled:=Parametri.A058_PianifNonOperativa <> 'N';
    BCancellazione.Enabled:=Parametri.A058_PianifNonOperativa = 'S';
    BOperativa.Enabled:=(Parametri.A058_PianifOperativa <> 'N') and (Parametri.A058_PianifNonOperativa <> 'N');
    btnTurno1.Enabled:=Parametri.A058_PianifNonOperativa <> 'N';
    btnAssenza1.Visible:=Parametri.A058_PianifNonOperativa <> 'N';
    btnOrario.Visible:=Parametri.A058_PianifNonOperativa <> 'N';
    btnAntincendio.Visible:=Parametri.A058_PianifNonOperativa <> 'N';
  end;
  //PIANIFICAZIONE PROGRESSIVA
  if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
  begin
    //PIANIFICAZIONE OPERATIVA
    with A058FPianifTurniDtm1 do
    begin
      if (A058FPianifTurni.RgpTipo.ItemIndex = 0) and (selT082.FieldByName('GENERAZIONE').AsString = 'N') or
         (A058FPianifTurni.RgpTipo.ItemIndex = 0) and (selT082.FieldByName('INIZIALE').AsString = 'N') or
         (A058FPianifTurni.RgpTipo.ItemIndex = 1) and (selT082.FieldByName('CORRENTE').AsString = 'N') then
      begin
        BRegistrazione.Enabled:=False;
        btnTurno1.Enabled:=False;
        btnAssenza1.Enabled:=False;
        btnOrario.Enabled:=False;
        btnAntincendio.Enabled:=False;
        BCancellazione.Enabled:=False;
      end;
      //BOperativa.Visible:=(selT082.fieldByName('MODALITA_LAVORO').AsString = 'O') and (selT082.FieldByName('GENERAZIONE').AsString = 'S');
      BOperativa.Visible:=(selT082.fieldByName('MODALITA_LAVORO').AsString = 'N') and (A058FPianifTurni.RgpTipo.ItemIndex = 1) and
                          (selT082.FieldByName('RENDI_OPERATIVA').AsString = 'S');
    end;

    {if A058FPianifTurniDtm1.selT082.fieldByName('MODALITA_LAVORO').AsString = 'O' then
    begin
      if not A058FPianifTurniDtm1.NuovaPianif then
      begin
        BRegistrazione.Enabled:=False;
        SpeedButton1.Enabled:=False;
      end;
    end;
    //PIANIFICAZIONE NON OPERATIVA
    //INIZIALE - non si può modificare... si può solo vedere
    if A058FPianifTurni.RgpTipo.ItemIndex = 0 then
    begin
      BRegistrazione.Enabled:=False;
      BCancellazione.Enabled:=False;
      SpeedButton1.Enabled:=False;
    end
    else
    //CORRENTE - si può solo registrare o rendere operativa
    begin
      BOperativa.Visible:=True;
      BCancellazione.Enabled:=False;
    end}
  end
  else if SolaLettura then
  begin
    Copiapianificazione1.Enabled:=False;
    BRegistrazione.Enabled:=False;
    BCancellazione.Enabled:=False;
    btnTurno1.Enabled:=False;
    btnAssenza1.Enabled:=False;
    btnOrario.Enabled:=False;
    btnAntincendio.Enabled:=False;
    BOperativa.Visible:=False;
    btnBlocca1.Visible:=False;
    btnSblocca1.Visible:=False;
  end;

  AbilitaA058:=SolaLettura;
  AssenzeAbilitate:=A000GetInibizioni('Funzione','OpenA004GiustifAssPres') = 'S';
  //SolaLettura:=AbilitaA058;

  //AbilitaA058:=SolaLettura;
  ReperibilitaAbilitata:=A000GetInibizioni('Funzione','OpenA040PianifRep') = 'S';
  SolaLettura:=AbilitaA058;
end;

procedure TA058FGrigliaPianif.GVistaDblClick(Sender: TObject);
begin
  Modifica1Click(nil);
end;

procedure TA058FGrigliaPianif.DisegnaElementoCella(ElementoCellaUI:TElementoCellaUI;CellaSelezionata:Boolean);
var
  StileElementoCella:TStileElementoCellaUI;
  TestoDisegno:String;
begin
  if (ElementoCellaUI.WinProprieta.Invisibile) then
    Exit;
  // Leggo lo stile
  StileElementoCella:=STILI_ELEMENTO_CELLA[ElementoCellaUI.TipoStileElementoCellaUI];
  // Imposto il testo
  TestoDisegno:=IfThen(not A058FPianifTurni.bVisualizzaSintetica,ElementoCellaUI.WinProprieta.Testo,ElementoCellaUI.WinProprieta.TestoSintetico);
  // Colore del testo
  if (CellaSelezionata) then
    GVista.Canvas.Font.Color:=clWhite
  else
    GVista.Canvas.Font.Color:=StileElementoCella.StileWin.ColoreTesto;

  // Stile del carattere
  GVista.Canvas.Font.Style:=ElementoCellaUI.WinProprieta.StiliCarattere;

  // Fill con lo sfondo, se diverso da trasparente
  if (StileElementoCella.StileWin.ColoreSfondo <> clNone) then
  begin
    GVista.Canvas.Brush.Color:=StileElementoCella.StileWin.ColoreSfondo;
    GVista.Canvas.FillRect(ElementoCellaUI.WinProprieta.RectDisegno);
  end;
  GVista.Canvas.TextRect(ElementoCellaUI.WinProprieta.RectDisegno,
                         ElementoCellaUI.WinProprieta.RectDisegno.Left + 3,
                         ElementoCellaUI.WinProprieta.RectDisegno.Top,
                         TestoDisegno);
end;

procedure TA058FGrigliaPianif.DisegnaElementoCella(ElementoCellaUI: TElementoCellaUI; CellaSelezionata: Boolean; Area: String);
var
  StileElementoCella:TStileElementoCellaUI;
  TestoDisegno:String;
begin
  if (ElementoCellaUI.WinProprieta.Invisibile) then
    Exit;
  // Leggo lo stile
  StileElementoCella:=STILI_ELEMENTO_CELLA[ElementoCellaUI.TipoStileElementoCellaUI];
  with A058FPianifTurniDtM1 do
  begin
    if (Area <> '') and
       (selT651.SearchRecord('CODICE_AREA',Area,[srFromBeginning])) then
      if (selT651.FieldByName('COLORE').AsString <> '') then
      // modifico lo stile della cella se il tipo è tsecSiglaArea
        StileElementoCella.StileWin.ColoreSfondo:=getColoreCellaWIN(selT651.FieldByName('COLORE').AsString);
  end;

  // Imposto il testo
  TestoDisegno:=IfThen(not A058FPianifTurni.bVisualizzaSintetica,ElementoCellaUI.WinProprieta.Testo,ElementoCellaUI.WinProprieta.TestoSintetico);
  // Colore del testo
  if (CellaSelezionata) then
    GVista.Canvas.Font.Color:=clWhite
  else
    GVista.Canvas.Font.Color:=StileElementoCella.StileWin.ColoreTesto;

  // Stile del carattere
  GVista.Canvas.Font.Style:=ElementoCellaUI.WinProprieta.StiliCarattere;

  // Fill con lo sfondo, se diverso da trasparente
  if (StileElementoCella.StileWin.ColoreSfondo <> clNone) then
  begin
    GVista.Canvas.Brush.Color:=StileElementoCella.StileWin.ColoreSfondo;
    GVista.Canvas.FillRect(ElementoCellaUI.WinProprieta.RectDisegno);
  end;
  GVista.Canvas.TextRect(ElementoCellaUI.WinProprieta.RectDisegno,
                         ElementoCellaUI.WinProprieta.RectDisegno.Left + 3,
                         ElementoCellaUI.WinProprieta.RectDisegno.Top,
                         TestoDisegno);
end;

procedure TA058FGrigliaPianif.GVistaDrawCell(Sender: TObject; Col, Row: Integer; Rect: TRect; State: TGridDrawState);
{Disegno della griglia con colori differenti a seconda del tipo di pianificazione}
var
  ColVistaGiorni,idxCol,xx1,xx2,RectTop,iSgOp,iOpDip,iSgDip,iBG:Integer;
  Rect2,Rect3,Rect4,Rect5,RectRep:TRect;
  A1,A2,sDep,sDep2,TestoDisegno,TipoOpeBG,ListaTipoOpeBG,ListaTipoOpeBGDiff:String;
  dDataCella:TDateTime;
  WinUITabellaInfo:TWinUITabellaInfo;
  CellaSelezionata:Boolean;
  CellaUIOpzioni:TGetCellaUIOpzioni;
  CellaUI:TCellaUI;
  ElementoCellaUI,SottoElementoCellaUI:TElementoCellaUI;
  IndicatoreCellaUI:TIndicatoreCellaUI;
  StileElementoCella:TStileElementoCellaUI;
  procedure DrawMinMax(TipoOperatore,SiglaTurno:String; RectX: TRect);
  var LimiteMin,LimiteMax,Totale:Integer;
      MaxMinFormat:String;
      MaxMin:TMaxMin;
  begin
    if not A058FPianifTurni.bVisualizzaSintetica then
      MaxMinFormat:='%3s%'
    else
      MaxMinFormat:='%2s%';

    MaxMin:=A058FPianifTurniDtM1.GetConteggioTurni(dDataCella,TipoOperatore,SiglaTurno);
    LimiteMin:=MaxMin.Min;
    LimiteMax:=MaxMin.Max;
    Totale:=MaxMin.Totale;

    if Totale < LimiteMin then
      GVista.Canvas.Font.Color:=clRed
    else if Totale > LimiteMax then
      GVista.Canvas.Font.Color:=clBlue
    else
      GVista.Canvas.Font.Color:=clGreen;
    GVista.Canvas.TextRect(RectX,RectX.Left + 1,RectX.Top,
                           Format(MaxMinFormat,[IfThen(LimiteMin > 0,LimiteMin.ToString,'')]) + ' ' +
                           Format(MaxMinFormat,[IfThen((Totale > 0) or (LimiteMin > 0) or (LimiteMax > 0),Totale.ToString,'')]) + ' ' +
                           Format(MaxMinFormat,[IfThen((LimiteMax > 0) and (LimiteMax < 99),LimiteMax.ToString,'')]));
  end;
begin
  with A058FPianifTurni do
  begin
    if A058FPianifTurniDtM1.Vista.Count = 0 then
      exit;

    with A058FPianifTurniDtM1 do
      //Solo per le colonne bloccate delle righe dei dipendenti
      if (Row >= nRigheBloccate) and (Col <= 5) then
      begin
        //Determino i diversi tipo operatore
        for iBG:=0 to Vista.Count - 1 do
        begin
          TipoOpeBG:=IfThen(Vista[iBG].TipoOpe = '','#null#',Vista[iBG].TipoOpe);
          if not R180InConcat(TipoOpeBG,ListaTipoOpeBG) then
            ListaTipoOpeBG:=ListaTipoOpeBG + TipoOpeBG + ',';
        end;
        //Determino lo sfondo alternando i tipo operatore
        iBG:=1;
        while Pos(',',ListaTipoOpeBG) > 0 do
        begin
          if iBG mod 2 = 0 then
            ListaTipoOpeBGDiff:=ListaTipoOpeBGDiff + Copy(ListaTipoOpeBG,1,Pos(',',ListaTipoOpeBG) - 1) + ',';
          iBG:=iBG + 1;
          ListaTipoOpeBG:=Copy(ListaTipoOpeBG,Pos(',',ListaTipoOpeBG) + 1);
        end;
        //Coloro lo sfondo in base al tipo operatore del dipendente
        TipoOpeBG:=IfThen(Vista[Row - nRigheBloccate].TipoOpe = '','#null#',Vista[Row - nRigheBloccate].TipoOpe);
        if R180InConcat(TipoOpeBG,ListaTipoOpeBGDiff) then
        begin
          GVista.Canvas.Brush.Color:=clSilver;
          GVista.Canvas.FillRect(Rect);
        end;
      end;

    //dDataCella:=StrToDate(GVista.Cells[col,0]);
    idxCol:=max(0,Col - nColonneBloccate);
    ColVistaGiorni:=idxCol + A058FPianifTurniDtM1.OffsetVista;  //Alberto 18/06/2007
    dDataCella:=A058FPianifTurniDtM1.DataInizio + idxCol;

    if Row = 0 then
    begin
      if Col = 0 then
      begin
        //Scrivo "matricola"
        GVista.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top,'Matricola');
        exit;
      end
      else if Col = 1 then
      begin
        //Scrivo su due righe la dicitura "cognome/nome"
        Rect2:=Rect;
        Rect2.Top:=Rect.Top + ((Rect.Bottom - Rect.Top) div 2);
        //Scrivo "cognome" prima riga
        GVista.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top,'Cognome');
        //Scrivo "nome" nella seconda riga...
        GVista.Canvas.TextRect(Rect2,Rect2.Left+2,Rect2.Top-2,'Nome');
        exit;
      end
      else if Col = 2 then
      begin
        //Scrivo su due righe la dicitura "Situazione ore"
        Rect2:=Rect;
        Rect2.Top:=Rect.Top + ((Rect.Bottom - Rect.Top) div 2);
        //Scrivo "situazione" prima riga
        GVista.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top,'Situazione');
        //Scrivo "ore" nella seconda riga...
        GVista.Canvas.TextRect(Rect2,Rect2.Left+2,Rect2.Top-2,'ore');
        exit;
      end
      else if Col = 3 then
      begin
        //Scrivo su due righe la dicitura "Tot.turni"
        Rect2:=Rect;
        Rect2.Top:=Rect.Top + ((Rect.Bottom - Rect.Top) div 2);
        //Scrivo "Tot." prima riga
        GVista.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top,'Tot.');
        //Scrivo "turni" nella seconda riga...
        GVista.Canvas.TextRect(Rect2,Rect2.Left+2,Rect2.Top-2,'turni');
        exit;
      end
      else if Col = 4 then
      begin
        //Scrivo su due righe la dicitura "Riepil.Assenze"
        Rect2:=Rect;
        Rect2.Top:=Rect.Top + ((Rect.Bottom - Rect.Top) div 2);
        //Scrivo "Riepil.Assenze" prima riga
        GVista.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top,'Riepil.Assenze');
        //Scrivo "Caus. Fat/Res" nella seconda riga...
        GVista.Canvas.TextRect(Rect2,Rect2.Left+2,Rect2.Top-2,'Caus. Fat./Res.');
        exit;
      end
      else if Col = 5 then
      begin
        //Scrivo su due righe la dicitura "Riposi/Festiv.lavorate"
        Rect2:=Rect;
        Rect2.Top:=Rect.Top + ((Rect.Bottom - Rect.Top) div 2);
        //Scrivo "Riposi" prima riga
        GVista.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top,'Riposi');
        //Scrivo "Fest.lavorate" nella seconda riga...
        GVista.Canvas.TextRect(Rect2,Rect2.Left+2,Rect2.Top-2,'Fest.lavorate');
        exit;
      end;
      Rect2:=Rect;
      Rect2.Top:=Rect.Top + ((Rect.Bottom - Rect.Top) div 2);
      //Se il giorno è festivo lo coloro di rosso (leggo il calendario del primo dipendente)
      {
      with A058FPianifTurniDtM1.GetCalend do
      begin
        SetVariable('PROG',A058FPianifTurniDtM1.Vista[0].Prog);
        SetVariable('D',dDataCella);
        Execute;
        if (VarToStr(GetVariable('F')) = 'S') or (DayOfWeek(dDataCella) = 1) then
          GVista.Canvas.Font.Color:=clRed;
      end;
      }
      if A058FPianifTurniDtM1.Vista.Count > 0 then
        if A058FPianifTurniDtM1.Vista[0].Giorni[ColVistaGiorni].GGFestivo or (DayOfWeek(dDataCella) = 1) then
          GVista.Canvas.Font.Color:=clRed;
      //Scrivo la data nella prima riga
      sDep2:=A058FPianifTurniDtM1.GetTipoGiornoServizio(dDataCella);
      if sDep2 <> '' then
        sDep2:='(' + sDep2 + ')';
      sDep2:=GVista.Cells[col,row] + sDep2;
      GVista.Canvas.TextRect(Rect,Rect.Left,Rect.Top,ifThen(Not bVisualizzaSintetica,'   ',' ') + sDep2);
      //Scrivo il nome del giorno nella seconda riga... centrandolo...
      sDep:=R180NomeGiorno(dDataCella);
      if bVisualizzaSintetica then
        sDep:=copy(sDep,1,3);
      //sDep:=UpperCase(Copy(sDep,1,1)) + Copy(sDep,2,length(sDep));
      sDep:=Format('%' + IntToStr(Length(sDep)+Round((Length(sDep2) + 3 + ifThen(Not bVisualizzaSintetica,3,0) - Length(sDep))/2)) + 's%',[sDep]);
      GVista.Canvas.TextRect(Rect2,Rect2.Left + 1,Rect2.Top - 2,sDep);
      exit;
    end
    else if Row = 1 then
    begin
      if Col = 1 then //Inserisco l'elenco delle sigle per ogni operatore
      begin
        with A058FPianifTurniDtM1 do
        begin
          AggiornaTotPagGio(0,Trunc(DataFine - DataInizio)); //necessario per il successivo richiamo a GetSimboloOperatore
          GVista.Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top, Format('%-5s %-5s',['Oper.','Sigle']));
          RectTop:=Rect.Top + (ALTEZZA_RIGA - 3) + 2; //per la prima sigla
          for iSgOp:=Low(TotTabGio) to High(TotTabGio) do
            if not TotTabGio[iSgOp].TotaleOperatore then
            begin
              RectRep:=TRect.Create(Rect.Left,Rect.Top,Rect.Right,Rect.Bottom);
              RectRep:=Rect;
              RectRep.Top:=RectTop;
              RectTop:=RectRep.Top + (ALTEZZA_RIGA - 3); //per la sigla successiva
              GVista.Canvas.TextRect(RectRep,RectRep.Left + 2,RectRep.Top, Format('%-5s %-5s',[TotTabGio[iSgOp].Operatore,TotTabGio[iSgOp].Sigla + GetSimboloOperatore(TotTabGio[iSgOp].Operatore,TotTabGio[iSgOp].Sigla,TotTabGio)]));
            end;
        end;
        exit;
      end;
      if Col = 3 then //Inserisco il totale delle sigle per ogni operatore
      begin
        GVista.Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top, Format('%6s',['Asseg.']));
        RectTop:=Rect.Top + (ALTEZZA_RIGA - 3) + 2; //per la prima sigla
        with A058FPianifTurniDtM1 do
          for iSgOp:=Low(TotTabGio) to High(TotTabGio) do
            if not TotTabGio[iSgOp].TotaleOperatore then
            begin
              RectRep:=TRect.Create(Rect.Left,Rect.Top,Rect.Right,Rect.Bottom);
              RectRep:=Rect;
              RectRep.Top:=RectTop;
              RectTop:=RectRep.Top + (ALTEZZA_RIGA - 3); //per la sigla successiva
              GVista.Canvas.TextRect(RectRep,RectRep.Left + 2,RectRep.Top, Format('%6s',[IntToStr(TotTabGio[iSgOp].Totale)]));
            end;
        exit;
      end;
      if Col < nColonneBloccate then
        exit;
      //Scrivo l'intestazione nella prima riga... (MIN/ASS/MAX)
      if not bVisualizzaSintetica then
        GVista.Canvas.TextRect(Rect,Rect.Left + 1,Rect.Top, Format('%3s%',['MIN']) + ' ' + Format('%3s%',['ASS']) + ' ' + Format('%3s%',['MAX']))
      else
        GVista.Canvas.TextRect(Rect,Rect.Left + 1,Rect.Top, Format('%2s%',['mn']) + ' ' + Format('%2s%',['As']) + ' ' + Format('%2s%',['MX']));

      //Ciclo sulle sigle usate per tipo operatore
      //Per ogni sigla creo un Rectx, gli assegno Rect, imposto il Top e richiamo DrawMinMax con il codice della sigla
      RectTop:=Rect.Top + (ALTEZZA_RIGA - 3) + 2; //per la prima sigla
      with A058FPianifTurniDtM1 do
        for iSgOp:=Low(TotTabGio) to High(TotTabGio) do
          if not TotTabGio[iSgOp].TotaleOperatore then
          begin
            RectRep:=TRect.Create(Rect.Left,Rect.Top,Rect.Right,Rect.Bottom);
            RectRep:=Rect;
            RectRep.Top:=RectTop;
            RectTop:=RectRep.Top + (ALTEZZA_RIGA - 3); //per la sigla successiva
            DrawMinMax(TotTabGio[iSgOp].Operatore,TotTabGio[iSgOp].Sigla,RectRep);
          end;
      exit;
    end
    else if Col = 0 then //Inserisco la matricola
    begin
      GVista.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top, A058FPianifTurniDtM1.Vista[Row - nRigheBloccate].Matricola);
      exit;
    end
    else if Col = 1 then //Inserisco il cognome ed il nome su due righe...
    begin
      Rect2:=Rect;
      //Rect2.Top:=Rect.Top + (Rect.Bottom - Rect.Top) div 3;
      Rect2.Top:=Rect.Top + ALTEZZA_RIGA;
      Rect3:=Rect;
      //Rect3.Top:=Rect2.Top + (Rect.Bottom - Rect.Top) div 3;
      Rect3.Top:=Rect2.Top + ALTEZZA_RIGA;
      GVista.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top, A058FPianifTurniDtM1.Vista[Row - nRigheBloccate].Cognome);
      GVista.Canvas.TextRect(Rect2,Rect2.Left+2,Rect2.Top, A058FPianifTurniDtM1.Vista[Row - nRigheBloccate].Nome);
      GVista.Canvas.TextRect(Rect3,Rect3.Left+2,Rect3.Top, A058FPianifTurniDtM1.Vista[Row - nRigheBloccate].TipoOpe);
      exit;
    end
    else if Col = 2 then //Inserisco il debito/assegnato/scostamento su 3 righe...
    begin
      Rect2:=Rect;
      Rect2.Top:=Rect.Top + ALTEZZA_RIGA;//(Rect.Bottom - Rect.Top) div 3;
      Rect3:=Rect;
      Rect3.Top:=Rect2.Top + ALTEZZA_RIGA;//(Rect.Bottom - Rect.Top) div 3;
      with A058FPianifTurniDtM1.Vista[Row - nRigheBloccate] do
      begin
        //Scrivo il debito nella prima riga
        GVista.Canvas.TextRect(Rect,Rect.Left+1,Rect.Top, Format('%-8s%-7s',['Deb.con.',R180MinutiOre(Debito)]));
        //Scrivo l'assegnato nella seconda riga
        GVista.Canvas.TextRect(Rect2,Rect2.Left+1,Rect2.Top, Format('%-8s%-7s',['Pianif.',R180MinutiOre(Assegnato)]));
        //Scrivo lo scostamento nella terza riga
        GVista.Canvas.TextRect(Rect3,Rect3.Left+1,Rect3.Top, Format('%-8s%-7s',['Scost.',R180MinutiOre(Assegnato - Debito)]));
      end;
      exit;
    end
    else if Col = 3 then //Inserisco il totale dei turni fatti da ogni dipendente nel periodo
    begin
      RectTop:=Rect.Top; //per la prima sigla
      with A058FPianifTurniDtM1 do
      begin
        AggiornaTotPagDip(Vista[Row - nRigheBloccate],0,Trunc(DataFine - DataInizio)); //necessario per il successivo richiamo a GetSimboloOperatore
        for iSgOp:=Low(TotTabGio) to High(TotTabGio) do
          if not TotTabGio[iSgOp].TotaleOperatore then
            for iOpDip:=Low(Vista[Row - nRigheBloccate].TotDip.Operatori) to High(Vista[Row - nRigheBloccate].TotDip.Operatori) do
              if Vista[Row - nRigheBloccate].TotDip.Operatori[iOpDip].Operatore = TotTabGio[iSgOp].Operatore then
                for iSgDip:=Low(Vista[Row - nRigheBloccate].TotDip.Operatori[iOpDip].Sigle) to High(Vista[Row - nRigheBloccate].TotDip.Operatori[iOpDip].Sigle) do
                  if Vista[Row - nRigheBloccate].TotDip.Operatori[iOpDip].Sigle[iSgDip].Sigla = TotTabGio[iSgOp].Sigla then
                    if Vista[Row - nRigheBloccate].TotDip.Operatori[iOpDip].Sigle[iSgDip].Totale > 0 then
                    begin
                      RectRep:=TRect.Create(Rect.Left,Rect.Top,Rect.Right,Rect.Bottom);
                      RectRep:=Rect;
                      RectRep.Top:=RectTop;
                      RectTop:=RectRep.Top + (ALTEZZA_RIGA - 4); //per la sigla successiva
                      GVista.Canvas.TextRect(RectRep,RectRep.Left + 1,RectRep.Top - 2,Format('%-3s%3d',[TotTabGio[iSgOp].Sigla + IfThen(TotTabGio[iSgOp].Operatore <> Vista[Row - nRigheBloccate].TipoOpe.Replace('(','').Replace(')','').Trim,GetSimboloOperatore(TotTabGio[iSgOp].Operatore,TotTabGio[iSgOp].Sigla,TotPagDip)),Vista[Row - nRigheBloccate].TotDip.Operatori[iOpDip].Sigle[iSgDip].Totale]));
                      Break;
                    end;
      end;
      exit;
    end
    else if Col = 4 then //Inserisco il fatto/residuo di ferie/malattia/recuperi
    begin
      //DA GESTIRE PER PESCARA: PER ADESSO LASCIATO IN SOSPESO
      exit;
    end
    else if Col = 5 then //Inserisco i riposi/festività lavorate fatte da inizio anno al mese precedente la pianificazione
    begin
      Rect2:=Rect;
      Rect2.Top:=Rect.Top + ALTEZZA_RIGA;//((Rect.Bottom - Rect.Top) div 3);
      Rect3:=Rect;
      Rect3.Top:=Rect2.Top + ALTEZZA_RIGA;//(Rect.Bottom - Rect.Top) div 3;
      GVista.Canvas.TextRect(Rect,Rect.Left+1,Rect.Top,'Riposi: ' + Format('%d+%d',[A058FPianifTurniDtM1.Vista[Row - nRigheBloccate].TotDip.Riposi,A058FPianifTurniDtM1.Vista[Row - nRigheBloccate].RiposiPrec]));
      sDep:=Format('F.l.corr.:%3s',[IntToStr(A058FPianifTurniDtM1.Vista[Row - nRigheBloccate].FestiviLavMeseCorr)]);
      GVista.Canvas.TextRect(Rect2,Rect2.Left+1,Rect2.Top-2,sDep);
      sDep:= FormatDateTime('mm/yy',A058FPianifTurniDtM1.DataInizio - 1);
      sDep:=Format('F.l.%s:%3s',[sDep,IntToStr(A058FPianifTurniDtM1.Vista[Row - nRigheBloccate].FestiviLavMesePrec)]);
      GVista.Canvas.TextRect(Rect3,Rect3.Left+1,Rect3.Top-2,sDep);
      (*
      if (R180Mese(A058FPianifTurniDtM1.DataInizio) = 1) and (R180Giorno(A058FPianifTurniDtM1.DataInizio) = 1) then
        sDep2:= '12/' + Copy(IntToStr(R180Anno(A058FPianifTurniDtM1.DataInizio) - 2),3,2)
      else
        sDep2:= '12/' + Copy(IntToStr(R180Anno(A058FPianifTurniDtM1.DataInizio) - 1),3,2);
      *)
      (*
      sDep2:='F.l.' + sDep2 + ':' + Format('%3s',[IntToStr(A058FPianifTurniDtM1.Vista[Row - nRigheBloccate].FestiviLavAnnoPrec)]);
      GVista.Canvas.TextRect(Rect3,Rect3.Left+1,Rect3.Top-2,sDep2);
      *)
      exit;
    end;
    // "Svuoto" la cella
    GVista.Canvas.Brush.Color:=clWhite;
    GVista.Canvas.FillRect(Rect);
    // La cella è selezionabile e selezionata?
    CellaSelezionata:=Not(gdFixed in State) and (gdFocused in State);
    CellaUIOpzioni:=[];
    if A058FPianifTurni.bVisualizzaAssenzeMezzaGiornata then Include(CellaUIOpzioni, coIncludiAssMezzGior);
    if A058FPianifTurni.bVisualizzaAssenzeAdOre then Include(CellaUIOpzioni, coIncludiAssOrarie);
    WinUITabellaInfo:=TWinUITabellaInfo.Create(Rect,ALTEZZA_RIGA,GVista.RowHeights[Row],GVista.ColWidths[Col]);
    CellaUI:=nil;
    try
      CellaUI:=A058FPianifTurniDtM1.GetCellaUI(Row - nRigheBloccate,ColVistaGiorni,CellaUIOpzioni,WinUITabellaInfo);
      //Colore di sfondo di tutta la cella
      if CellaSelezionata then
        GVista.Canvas.Brush.Color:=clHighlight
      else
        GVista.Canvas.Brush.Color:=CellaUI.SfondoWin;
      GVista.Canvas.FillRect(Rect);
      // Elementi della cella
      for ElementoCellaUI in CellaUI.Elementi do
      begin
        //Resetto brush al colore di sfondo della cella
        if CellaSelezionata then
          GVista.Canvas.Brush.Color:=clHighlight
        else
          GVista.Canvas.Brush.Color:=CellaUI.SfondoWin;

        if (not ElementoCellaUI.TipoComplesso) then
        begin
          DisegnaElementoCella(ElementoCellaUI,CellaSelezionata);
        end
        else
        begin
          for SottoElementoCellaUI in ElementoCellaUI.ListaSottoElementi do
          begin
            if SottoElementoCellaUI.TipoStileElementoCellaUI <> tsecSiglaArea then
              DisegnaElementoCella(SottoElementoCellaUI,CellaSelezionata)
            else
              DisegnaElementoCella(SottoElementoCellaUI,CellaSelezionata,A058FPianifTurniDtM1.Vista[Row - nRigheBloccate].Giorni[ColVistaGiorni].Area);
          end;
        end;
      end;
      // Indicatori della cella
      for IndicatoreCellaUI in CellaUI.Indicatori do
      begin
        GVista.Canvas.Brush.Color:=STILI_INDICATORE_CELLA[IndicatoreCellaUI.TipoStileIndicatoreCellaUI].ColoreWin;
        GVista.Canvas.Polygon(IndicatoreCellaUI.VerticiWin);
      end;
    finally
      FreeAndNil(WinUITabellaInfo);
      if (CellaUI <> nil) then
        FreeAndNil(CellaUI);
    end;
    if DayOfWeek(dDataCella) = 1 then
    begin
      GVista.Canvas.Pen.Color:=clRed;
      GVista.Canvas.Polyline([Rect.TopLeft,Point(Rect.Left,Rect.Bottom)]);
      GVista.Canvas.Polyline([Point(Rect.Right-1,Rect.Top),Point(Rect.Right-1,Rect.Bottom)]);
    end;
  end;
end;

procedure TA058FGrigliaPianif.GVistaMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
{Gestisco la selezione della cella col tasto destro del mouse}
var
  R,C:Integer;
begin
  if Button = mbRight then
  begin
    GVista.MouseToCell(X,Y,C,R);
    Modifica1.Visible:=(R >= nRigheBloccate) and (C >= nColonneBloccate);
    CopiaPianificazione1.Visible:=(R >= nRigheBloccate);
    if (R < nRigheBloccate) or (C < nColonneBloccate) then
      exit;
    GVista.Row:=R;
    GVista.Col:=C;
  end;
end;

procedure TA058FGrigliaPianif.Modifica1Click(Sender: TObject);
{Finestra di dialogo per modificare i dati della pianificazione}
var
  i,j,k,xx,GVistaRow:Integer;
  O,A1,A2:String;
  D,DCorr:TDateTime;
  //Giorno:TGiorno;
  ModificaAbilitata, RiepBloccato:Boolean;

  function GiornoSignificativo(Caus:String):Boolean;
  var
    GS:String;
  begin
    GS:=VarToStr(A058FPianifTurniDtM1.Q265.Lookup('CODICE',Caus,'GSIGNIFIC'));
    Result:=False;
    if GS = '' then
      exit;
    if (GS = 'GT') and (A058FPianifTurniDtm1.Vista[i].Giorni[xx].T1.Trim = '0') then
      exit;
    if (GS = 'GL') and (DayOfWeek(DCorr) in [1,7]) then
      exit;
    if (GS = 'G6') and (DayOfWeek(DCorr) in [1]) then
      exit;
    Result:=True;
  end;

begin
  if A058FDettaglioGiornata <> nil then
    FreeAndNil(A058FDettaglioGiornata);
  PreparaLeggiValoriCella;
  GVistaRow:=GVista.Row;
  i:=GVista.Row - nRigheBloccate;
  j:=GVista.Col - nColonneBloccate + A058FPianifTurniDtm1.OffsetVista;
  with A058FPianifTurniDtM1 do
  begin
    RiepBloccato:=PianifNonOperativa and PianifBloccata(Vista[i].Prog,DataInizio + j);
  end;
  ModificaAbilitata:=BRegistrazione.Enabled and
                    (not RiepBloccato) and
                    (A058FPianifTurniDtm1.Vista[i].Giorni[j].Squadra = A058FPianifTurniDtm1.SquadraRiferimento);
  if not ModificaAbilitata then
    exit;

  A058FPianifTurniDtM1.RicercaSostituti:=Sender = RicercaSostituti1;

  D:=A058FPianifTurniDtm1.DataInizio + j;
  O:=A058FPianifTurniDtm1.Vista[i].Giorni[j].Ora;
  A1:=A058FPianifTurniDtm1.Vista[i].Giorni[j].Ass1;
  A2:=A058FPianifTurniDtm1.Vista[i].Giorni[j].Ass2;
  A058FPianifTurniDtm1.Q021.Filter:='';
  A058FPianifTurniDtm1.Q021.Filtered:=False;
  A058FPianifTurniDtm1.Q021.SetVariable('DECORRENZA',D);
  A058FPianifTurniDtm1.Q021.Close;
  A058FPianifTurniDtm1.Q021.Open;
  A058FPianifTurniDtm1.ImpostaFiltroOrariSquadra(D);
  A058FPianifTurniDtm1.Q020.Filtered:=True;
  A058FPianifTurniDtm1.GetAreeAfferenza(A058FPianifTurniDtm1.Vista[i].Giorni[j].Squadra,A058FPianifTurniDtm1.Vista[i].Giorni[j].Oper);
  A058FModPianif:=TA058FModPianif.Create(nil);
  try
    A058FModPianif.ProgressivoOrigine:=A058FPianifTurniDtm1.Vista[i].Prog;
    A058FModPianif.Caption:=A058FModPianif.Caption +
      IfThen(A058FPianifTurniDtM1.RicercaSostituti,
             ' del ' + DateToStr(D) + ' di ' + A058FPianifTurniDtm1.Vista[i].Matricola + ' ' + A058FPianifTurniDtm1.Vista[i].Cognome + ' ' + A058FPianifTurniDtm1.Vista[i].Nome + ' per ricerca sostituto');
    //Se c'è la possibilità di inserire una causale come nuova filtro i dataset
    A058FPianifTurniDtm1.Q265.Filtered:=A1 = '';
    A058FPianifTurniDtm1.Q265B.Filtered:=A2 = '';
    //Preparo i dati
    {Se il dato non è nel filtro dizionario, ne impedisco la modifica, altrimenti
     filtro il contenuto della combobox orari}
    if not A000FiltroDizionario('MODELLI ORARIO',O) and (not O.IsEmpty) then
    begin
      A058FPianifTurniDtm1.Q020.Filtered:=False;
      A058FModPianif.EOrario.Enabled:=False;
    end
    else
    begin
      A058FPianifTurniDtm1.Q020.Filtered:=True;
      A058FModPianif.EOrario.Enabled:=True;
    end;
    A058FModPianif.EOrario.KeyValue:=O;
    A058FModPianif.DBText1.Visible:=O <> '';
    A058FModPianif.EAssenza1.KeyValue:=A1;
    A058FModPianif.DBText2.Visible:=A1 <> '';
    A058FModPianif.EAssenza2.KeyValue:=A2;
    A058FModPianif.DBText3.Visible:=A2 <> '';
    A058FModPianif.MOD_T1:=Trim(A058FPianifTurniDtm1.Vista[i].Giorni[j].T1);
    A058FModPianif.MOD_SiglaT1:=Trim(A058FPianifTurniDtm1.Vista[i].Giorni[j].SiglaT1);
    A058FModPianif.MOD_NTurno1:=Trim(A058FPianifTurniDtm1.Vista[i].Giorni[j].NumTurno1);
    A058FModPianif.MOD_T1EU:=A058FPianifTurniDtm1.Vista[i].Giorni[j].T1EU;
    if not A058FPianifTurniDtM1.RicercaSostituti then
    begin
      A058FModPianif.MOD_T2:=Trim(A058FPianifTurniDtm1.Vista[i].Giorni[j].T2);
      A058FModPianif.MOD_SiglaT2:=Trim(A058FPianifTurniDtm1.Vista[i].Giorni[j].SiglaT2);
      A058FModPianif.MOD_NTurno2:=Trim(A058FPianifTurniDtm1.Vista[i].Giorni[j].NumTurno2);
      A058FModPianif.MOD_T2EU:=A058FPianifTurniDtm1.Vista[i].Giorni[j].T2EU;
    end;
    A058FModPianif.MOD_Assenza1:=A058FPianifTurniDtm1.Vista[i].Giorni[j].Ass1;
    A058FModPianif.MOD_Assenza2:=A058FPianifTurniDtm1.Vista[i].Giorni[j].Ass2;
    A058FModPianif.MOD_Area:=A058FPianifTurniDtm1.Vista[i].Giorni[j].Area;
    A058FModPianif.MOD_dArea:=A058FPianifTurniDtm1.Vista[i].Giorni[j].DArea;
    A058FModPianif.dcmbArea.KeyValue:=A058FPianifTurniDtm1.Vista[i].Giorni[j].Area;
    A058FModPianif.dtxtArea.Visible:=A058FPianifTurniDtm1.Vista[i].Giorni[j].Area <> '';

    if (A000GetInibizioni('Funzione','OpenA004GiustifAssPres') <> 'S') and
     (A058FPianifTurniDtm1.selT082.fieldByName('MODALITA_LAVORO').AsString <> 'N') then
    begin
      A058FModPianif.EAssenza1.Enabled:=False;
      A058FModPianif.EAssenza2.Enabled:=False;
    end
    else
    begin
      A058FModPianif.EAssenza1.Enabled:=A058FPianifTurniDtm1.Vista[i].Giorni[j].Ass1Modif;
      if A058FModPianif.MOD_Assenza1 <> '' then
        A058FModPianif.EAssenza1.Enabled:= A058FModPianif.EAssenza1.Enabled and
                                           A000FiltroDizionario('CAUSALI ASSENZA', A058FModPianif.MOD_Assenza1);
      A058FModPianif.EAssenza2.Enabled:=A058FPianifTurniDtm1.Vista[i].Giorni[j].Ass2Modif;
      if A058FModPianif.MOD_Assenza2 <> '' then
        A058FModPianif.EAssenza2.Enabled:=A058FModPianif.EAssenza2.Enabled and
                                          A000FiltroDizionario('CAUSALI ASSENZA', A058FModPianif.MOD_Assenza2);
    end;
    R180AbilitaOggetti(A058FModPianif.frmInputPeriodo, A058FPianifTurniDtm1.selT082.fieldByName('MODALITA_LAVORO').AsString = 'N');
    A058FModPianif.DataI:=A058FPianifTurniDtm1.DataInizio + j;
    A058FModPianif.DataF:=A058FPianifTurniDtm1.DataInizio + j;
    A058FModPianif.MOD_Antincendio:=A058FPianifTurniDtm1.Vista[i].Giorni[j].Antincendio;
    A058FModPianif.MOD_Note:=A058FPianifTurniDtm1.Vista[i].Giorni[j].Note;
    A058FModPianif.MOD_Referente:=A058FPianifTurniDtm1.Vista[i].Giorni[j].Referente;
    A058FModPianif.MOD_RichiestoDaTurnista:=A058FPianifTurniDtm1.Vista[i].Giorni[j].RichiestoDaTurnista;
    if A058FPianifTurniDtM1.RicercaSostituti then
      A058FModPianif.cmbTipoOpe.KeyValue:=A058FPianifTurniDtm1.Vista[i].Giorni[j].Oper;

    if A058FModPianif.ShowModal = mrOK then
    begin
      A058FModPianif.CmbTurno1.Text:=Trim(A058FModPianif.CmbTurno1.Text);
      A058FModPianif.CmbTurno2.Text:=Trim(A058FModPianif.CmbTurno2.Text);
      if (A058FModPianif.CmbTurno1EU.Text <> '') and
         ((A058FModPianif.CmbTurno1.Text = '') or (A058FModPianif.CmbTurno1.Text < '1') or (A058FModPianif.CmbTurno1.Text > '99')) then
        A058FModPianif.CmbTurno1EU.Text:='';
      if (A058FModPianif.CmbTurno2EU.Text <> '') and
         ((A058FModPianif.CmbTurno2.Text = '') or (A058FModPianif.CmbTurno2.Text < '1') or (A058FModPianif.CmbTurno2.Text > '99')) then
        A058FModPianif.CmbTurno2EU.Text:='';

      if A058FPianifTurniDtM1.RicercaSostituti then
      begin
        //Cancello la pianificazione del dipendente di partenza
        if Format('%2s',[A058FModPianif.CmbTurno1.Text]) = A058FPianifTurniDtm1.Vista[i].Giorni[j].T2 then
        begin
          A058FPianifTurniDtm1.Vista[i].Giorni[j].T2:='';
          A058FPianifTurniDtm1.Vista[i].Giorni[j].T2EU:='';
          A058FPianifTurniDtm1.Vista[i].Giorni[j].Modificato:=True; //Setto il flag che indica che la cella è stata modificata
        end
        else if Format('%2s',[A058FModPianif.CmbTurno1.Text]) = A058FPianifTurniDtm1.Vista[i].Giorni[j].T1 then
        begin
          A058FPianifTurniDtm1.Vista[i].Giorni[j].T1:=A058FPianifTurniDtm1.Vista[i].Giorni[j].T2;
          A058FPianifTurniDtm1.Vista[i].Giorni[j].T1EU:=A058FPianifTurniDtm1.Vista[i].Giorni[j].T2EU;
          A058FPianifTurniDtm1.Vista[i].Giorni[j].T2:='';
          A058FPianifTurniDtm1.Vista[i].Giorni[j].T2EU:='';
          A058FPianifTurniDtm1.Vista[i].Giorni[j].Modificato:=True; //Setto il flag che indica che la cella è stata modificata
        end;
        if A058FPianifTurniDtm1.Vista[i].Giorni[j].Modificato then
        begin
          //Se non ci sono turni pianificati significativi, cancello anche gli altri dati
          if (Trim(A058FPianifTurniDtm1.Vista[i].Giorni[j].T1) = '')
          and (Trim(A058FPianifTurniDtm1.Vista[i].Giorni[j].T2) = '') then
          begin
            A058FPianifTurniDtm1.Vista[i].Giorni[j].Ora:='';
            A058FPianiFturniDtm1.Vista[i].Giorni[j].Antincendio:='N';
            A058FPianiFturniDtm1.Vista[i].Giorni[j].Referente:='';
            A058FPianiFturniDtm1.Vista[i].Giorni[j].RichiestoDaTurnista:='';
            A058FPianiFturniDtm1.Vista[i].Giorni[j].Note:='';
          end;
          A058FPianifTurniDtm1.EseguiPianificazione(i,D);
          A058FPianifTurniDtM1.AnomalieXDipendente(A058FPianifTurniDtm1.Vista[i]);
          A058FPianifTurniDtM1.Vista.Controllo_TurnoAntincendio(A058FPianifTurniDtm1.Vista[i].Giorni[j].Data,
                                                                A058FPianifTurniDtm1.Vista[i].Giorni[j].Data);
          A058FPianifTurniDtM1.Vista.Controllo_Referente(A058FPianifTurniDtm1.Vista[i].Giorni[j].Data,
                                                         A058FPianifTurniDtm1.Vista[i].Giorni[j].Data);
          A058FPianifTurniDtM1.ConteggiGiornalieri(A058FPianifTurniDtm1.DataInizio + j,A058FPianifTurniDtm1.Vista[i],j);
          A058FPianifTurniDtm1.DebitoDipendente(A058FPianifTurniDtm1.Vista[i],0,Trunc(A058FPianifTurniDtm1.DataFine - A058FPianifTurniDtm1.DataInizio));
          A058FPianifTurniDtm1.AggiornaContatoriTurni(i,j);
          ImpostaAltezzaRiga(i);
          A058FPianifTurniDtm1.Vista[i].Giorni[j].Modificato:=False; //Setto il flag che indica che la cella è stata registrata
        end;
        //Inserisco il cambio squadra della persona selezionata se non è già pianificata e se squadra/operatore sono diversi da quelli di riferimento
        if not A058FPianifTurniDtM1.DipSostituto.Pianificato
        and (   (A058FPianifTurniDtM1.DipSostituto.Squadra <> A058FPianifTurniDtm1.SquadraRiferimento)
             or (A058FPianifTurniDtM1.DipSostituto.TipoOpe <> A058FModPianif.cmbTipoOpe.Text)) then
          //Inserisco il cambio squadra
          with A058FPianifTurniDtm1.scrT630 do
          begin
            SetVariable('PROGRESSIVO',A058FPianifTurniDtM1.DipSostituto.Progressivo);
            SetVariable('DATA',D);
            SetVariable('SQUADRA',A058FPianifTurniDtm1.SquadraRiferimento);
            SetVariable('ORARIO',A058FModPianif.EOrario.Text);
            SetVariable('COD_TIPOOPE',A058FModPianif.cmbTipoOpe.Text);
            Execute; //La commit viene effettuata più avanti in EseguiPianificazione
          end;
        i:=-1;
        //Recupero l'indice della persona selezionata
        for k:=0 to A058FPianifTurniDtm1.Vista.Count - 1 do
          if A058FPianifTurniDtm1.Vista[k].Prog = A058FPianifTurniDtM1.DipSostituto.Progressivo then
            i:=k;
        //Leggo la pianificazione del sostituto se non era già presente nella griglia aggiungendo una riga a Vista e GVista
        if i = -1 then
        begin
          A058FPianifTurniDtm1.LeggiPianificazione(A058FPianifTurniDtM1.DipSostituto.Progressivo,A058FPianifTurniDtm1.DataInizio,A058FPianifTurniDtm1.DataFine); //adeguarlo in modo che non legga i dati dalla selezione anagrafica richiama CreaDipendente
          for k:=0 to A058FPianifTurniDtm1.Vista.Count - 1 do
            if A058FPianifTurniDtm1.Vista[k].Prog = A058FPianifTurniDtM1.DipSostituto.Progressivo then
              i:=k;
          GVista.RowCount:=GVista.RowCount + 1;
        end;
        PreparaLeggiValoriCella(i,j);
        GVistaRow:=i + nRigheBloccate;
      end;

      //Modifico i dati in Vista e GVista
      A058FPianifTurniDtm1.Vista[i].Giorni[j].Area:=A058FModPianif.MOD_Area;
      A058FPianifTurniDtm1.Vista[i].Giorni[j].DArea:=A058FModPianif.MOD_dArea;
      A058FPianifTurniDtm1.Vista[i].Giorni[j].Antincendio:=IfThen(A058FModPianif.chkAntincendio.Checked,'S','N');
      A058FPianiFturniDtm1.Vista[i].Giorni[j].Referente:=IfThen(A058FModPianif.chkReferente.Checked,'S','');
      A058FPianiFturniDtm1.Vista[i].Giorni[j].RichiestoDaTurnista:=IfThen(A058FModPianif.chkRichiestoDaTurnista.Checked,'S','');
      A058FPianifTurniDtm1.Vista[i].Giorni[j].Ora:=A058FModPianif.EOrario.Text;
      if A058FPianifTurniDtM1.RicercaSostituti then
      begin
        A058FPianifTurniDtm1.Vista[i].Giorni[j].Squadra:=A058FPianifTurniDtm1.SquadraRiferimento;
        A058FPianifTurniDtm1.Vista[i].Giorni[j].Oper:=A058FModPianif.cmbTipoOpe.Text;
        A058FPianifTurniDtm1.Vista[i].Giorni[j].Ass1Modif:=True; //necessario per far diventare gialla la cella quando prima era di un altro colore
        A058FPianifTurniDtm1.Vista[i].Giorni[j].Ass2Modif:=True;
        if R180In(Trim(A058FPianifTurniDtm1.Vista[i].Giorni[j].T1),['','0']) then
        begin
          A058FPianifTurniDtm1.Vista[i].Giorni[j].T1EU:=A058FModPianif.CmbTurno1EU.Text;
          A058FPianifTurniDtm1.Vista[i].Giorni[j].T1:=Format('%2s',[A058FModPianif.CmbTurno1.Text]);
        end
        else //se primo turno già occupato...
        begin
          A058FPianifTurniDtm1.Vista[i].Giorni[j].T2EU:=A058FModPianif.CmbTurno1EU.Text;
          A058FPianifTurniDtm1.Vista[i].Giorni[j].T2:=Format('%2s',[A058FModPianif.CmbTurno1.Text]); //non è CmbTurno2 perché faccio specificare solo un turno da sostituire
        end;
      end
      else
      begin
        A058FPianifTurniDtm1.Vista[i].Giorni[j].T1EU:=A058FModPianif.CmbTurno1EU.Text;
        A058FPianifTurniDtm1.Vista[i].Giorni[j].T2EU:=A058FModPianif.CmbTurno2EU.Text;
        A058FPianifTurniDtm1.Vista[i].Giorni[j].T1:=Format('%2s',[A058FModPianif.CmbTurno1.Text]);
        A058FPianifTurniDtm1.Vista[i].Giorni[j].T2:=Format('%2s',[A058FModPianif.CmbTurno2.Text]);
      end;
      if (A058FPianifTurniDtm1.Vista[i].Giorni[j].Ass1 <> A058FModPianif.EAssenza1.Text) then
        A058FPianifTurniDtm1.Vista[i].Giorni[j].Ass1Competenza:=caPianificazione;
      if (A058FPianifTurniDtm1.Vista[i].Giorni[j].Ass2 <> A058FModPianif.EAssenza2.Text) then
        A058FPianifTurniDtm1.Vista[i].Giorni[j].Ass2Competenza:=caPianificazione;
      if (Trim(A058FPianifTurniDtm1.Vista[i].Giorni[j].T1) = '') and (A058FModPianif.EOrario.Text <> '') then
        A058FPianifTurniDtm1.Vista[i].Giorni[j].T1:=' M';
      if A058FPianifTurniDtm1.selT082.fieldByName('MODALITA_LAVORO').AsString = 'O' then
      begin
        //Se è specificato solo l'orario senza turni imposto il turno a 'M'
        A058FPianifTurniDtm1.Vista[i].Giorni[j].ValorGior:='';
        A058FPianifTurniDtm1.Vista[i].Giorni[j].Ass1:=A058FModPianif.EAssenza1.Text;
        A058FPianifTurniDtm1.Vista[i].Giorni[j].Ass2:=A058FModPianif.EAssenza2.Text;
        if A058FPianifTurniDtm1.Vista[i].Giorni[j].Ass1 = '' then
        //Prima assenza nulla e seconda assenza valida
        begin
          A058FPianifTurniDtm1.Vista[i].Giorni[j].Ass1:=A058FModPianif.EAssenza2.Text;
          A058FPianifTurniDtm1.Vista[i].Giorni[j].Ass2:='';
        end;
        //Se le 2 assenze sono uguali elimino la seconda
        if A058FPianifTurniDtm1.Vista[i].Giorni[j].Ass1 = A058FPianifTurniDtm1.Vista[i].Giorni[j].Ass2 then
          A058FPianifTurniDtm1.Vista[i].Giorni[j].Ass2:='';
        //Se è specificata solo l'assenza imposto il turno ad 'A'
        if ((Trim(A058FPianifTurniDtm1.Vista[i].Giorni[j].T1) = '') or (A058FPianifTurniDtm1.Vista[i].Giorni[j].T1 = ' M'))
           and (A058FPianifTurniDtm1.Vista[i].Giorni[j].Ass1 <> '') then
          A058FPianifTurniDtm1.Vista[i].Giorni[j].T1:=' A';
        //Se è pianificato il turno ma manca l'orario lo ricerco nello storico
        if (A058FModPianif.EOrario.Text = '') and (Trim(A058FPianifTurniDtm1.Vista[i].Giorni[j].T1) <> '') then
          A058FPianifTurniDtm1.Vista[i].Giorni[j].Ora:=A058FPianifTurniDtM1.GetOrarioStorico(D,A058FPianifTurniDtm1.Vista[i].Prog);
        GVista.Cells[GVista.Col,GVistaRow]:=
        Format('%-2s%-3s%-1s%-2s%-3s%-1s%s',[A058FPianifTurniDtm1.Vista[i].Giorni[j].T1, A058FPianifTurniDtm1.Vista[i].Giorni[j].SiglaT1,
                                             A058FPianifTurniDtm1.Vista[i].Giorni[j].T1EU, A058FPianifTurniDtm1.Vista[i].Giorni[j].T2,
                                             A058FPianifTurniDtm1.Vista[i].Giorni[j].SiglaT2, A058FPianifTurniDtm1.Vista[i].Giorni[j].T2EU,
                                             R180DimLung(A058FPianifTurniDtm1.Vista[i].Giorni[j].Ora,5)]);
        {Bruno: 31/10/2017
        if Giorno.T1 <> '' then}
        if not A058FPianifTurniDtm1.Vista[i].Giorni[j].T1.IsEmpty then
        begin
          A058FPianifTurniDtm1.Vista[i].Giorni[j].Flag:='M';
        end;
      end
      else
      begin
        DCorr:=A058FModPianif.DataI;
        while DCorr <= A058FModPianif.DataF do
        begin
          if (DCorr >= A058FPianifTurniDtm1.DataInizio) and (DCorr <= A058FPianifTurniDtm1.DataFine) then
          begin
            xx:=Trunc(DCorr - A058FPianifTurniDtm1.DataInizio);
            if (A058FModPianif.EAssenza1.Text = '') or GiornoSignificativo(A058FModPianif.EAssenza1.Text) then
            begin
              if A058FPianifTurniDtm1.Vista[i].Giorni[xx].Ass1 <> A058FModPianif.EAssenza1.Text then
              begin
                A058FPianifTurniDtm1.Vista[i].Giorni[xx].Modificato:=True;
                A058FPianifTurniDtm1.Vista[i].Giorni[xx].Ass1Competenza:=caPianificazione;
              end;
              A058FPianifTurniDtm1.Vista[i].Giorni[xx].Ass1:=A058FModPianif.EAssenza1.Text;
            end;
            if (A058FModPianif.EAssenza2.Text = '') or GiornoSignificativo(A058FModPianif.EAssenza2.Text) then
            begin
              if A058FPianifTurniDtm1.Vista[i].Giorni[xx].Ass2 <> A058FModPianif.EAssenza2.Text then
              begin
                A058FPianifTurniDtm1.Vista[i].Giorni[xx].Modificato:=True;
                A058FPianifTurniDtm1.Vista[i].Giorni[xx].Ass2Competenza:=caPianificazione;
              end;
              A058FPianifTurniDtm1.Vista[i].Giorni[xx].Ass2:=A058FModPianif.EAssenza2.Text;
            end;
            if A058FPianifTurniDtm1.Vista[i].Giorni[xx].Ass1 = '' then
            //Prima assenza nulla e seconda assenza valida
            begin
              A058FPianifTurniDtm1.Vista[i].Giorni[xx].Ass1:=A058FModPianif.EAssenza2.Text;
              A058FPianifTurniDtm1.Vista[i].Giorni[xx].Ass2:='';
            end;
            //Se le 2 assenze sono uguali elimino la seconda
            if A058FPianifTurniDtm1.Vista[i].Giorni[xx].Ass1 = A058FPianifTurniDtm1.Vista[i].Giorni[xx].Ass2 then
              A058FPianifTurniDtm1.Vista[i].Giorni[xx].Ass2:='';
            //Se è specificata solo l'assenza imposto il turno ad 'A'
            if ((Trim(A058FPianifTurniDtm1.Vista[i].Giorni[xx].T1) = '') or (A058FPianifTurniDtm1.Vista[i].Giorni[xx].T1 = ' A')) and
              (A058FPianifTurniDtm1.Vista[i].Giorni[xx].Ora <> '')
            then
                A058FPianifTurniDtm1.Vista[i].Giorni[xx].T1:=' M';
            if ((Trim(A058FPianifTurniDtm1.Vista[i].Giorni[xx].T1) = '') or (A058FPianifTurniDtm1.Vista[i].Giorni[xx].T1 = ' M'))
                 and (A058FPianifTurniDtm1.Vista[i].Giorni[xx].Ass1 <> '') then
              A058FPianifTurniDtm1.Vista[i].Giorni[xx].T1:=' A';
          end;
          DCorr:=DCorr + 1;
        end;
      end;
      if (Trim(A058FPianifTurniDtm1.Vista[i].Giorni[j].T1) < '1') or (Trim(A058FPianifTurniDtm1.Vista[i].Giorni[j].T1) > '99') then
        A058FPianifTurniDtm1.Vista[i].Giorni[j].T1EU:='';
      if (Trim(A058FPianifTurniDtm1.Vista[i].Giorni[j].T2) < '1') or (Trim(A058FPianifTurniDtm1.Vista[i].Giorni[j].T2) > '99') then
        A058FPianifTurniDtm1.Vista[i].Giorni[j].T2EU:='';
      if (A058FModPianif.EOrario.Text = '') and (Trim(A058FPianifTurniDtm1.Vista[i].Giorni[j].T1) <> '') then
        A058FPianifTurniDtm1.Vista[i].Giorni[j].Ora:=A058FPianifTurniDtM1.GetOrarioStorico(D,A058FPianifTurniDtm1.Vista[i].Prog);
      {Bruno: 31/10/2017
      if Giorno.T1 <> '' then}
      if not A058FPianifTurniDtm1.Vista[i].Giorni[j].T1.IsEmpty then
      begin
        A058FPianifTurniDtm1.Vista[i].Giorni[j].Flag:='M';
      end;
      // Le note vanno impostate solo se il modello orario è diverso da stringa vuota. In caso contrario le svuoto.
      if A058FPianifTurniDtm1.Vista[i].Giorni[j].Ora <> '' then
        A058FPianifTurniDtm1.Vista[i].Giorni[j].Note:=A058FModPianif.memoNote.Lines.Text.Trim
      else
        A058FPianifTurniDtm1.Vista[i].Giorni[j].Note:='';
      GVista.Cells[GVista.Col,GVistaRow]:=Format('%-2s%-3s%-1s%-2s%-3s%-1s%s',
                                           [A058FPianifTurniDtm1.Vista[i].Giorni[j].T1, A058FPianifTurniDtm1.Vista[i].Giorni[j].SiglaT1,
                                            A058FPianifTurniDtm1.Vista[i].Giorni[j].T1EU, A058FPianifTurniDtm1.Vista[i].Giorni[j].T2,
                                            A058FPianifTurniDtm1.Vista[i].Giorni[j].SiglaT2, A058FPianifTurniDtm1.Vista[i].Giorni[j].T2EU,
                                            R180DimLung(A058FPianifTurniDtm1.Vista[i].Giorni[j].Ora,5)]);
      if A058FPianifTurniDtM1.RicercaSostituti then
        A058FPianifTurniDtm1.EseguiPianificazione(i,D)
      else if
         (A058FPianifTurniDtm1.xValoreOrigine.T1 <> A058FPianifTurniDtm1.Vista[i].Giorni[j].T1) or
         (A058FPianifTurniDtm1.xValoreOrigine.T2 <> A058FPianifTurniDtm1.Vista[i].Giorni[j].T2) or
         (A058FPianifTurniDtm1.xValoreOrigine.SiglaT1 <> A058FPianifTurniDtm1.Vista[i].Giorni[j].SiglaT1) or
         (A058FPianifTurniDtm1.xValoreOrigine.SiglaT2 <> A058FPianifTurniDtm1.Vista[i].Giorni[j].SiglaT2) or
         (A058FPianifTurniDtm1.xValoreOrigine.T1EU <> A058FPianifTurniDtm1.Vista[i].Giorni[j].T1EU) or
         (A058FPianifTurniDtm1.xValoreOrigine.T2EU <> A058FPianifTurniDtm1.Vista[i].Giorni[j].T2EU) or
         (A058FPianifTurniDtm1.xValoreOrigine.Ora <> A058FPianifTurniDtm1.Vista[i].Giorni[j].Ora) or
         (A058FPianifTurniDtm1.xValoreOrigine.ValorGior <> A058FPianifTurniDtm1.Vista[i].Giorni[j].ValorGior) or
         (A058FPianifTurniDtm1.xValoreOrigine.Ass1 <> A058FPianifTurniDtm1.Vista[i].Giorni[j].Ass1) or
         (A058FPianifTurniDtm1.xValoreOrigine.Ass2 <> A058FPianifTurniDtm1.Vista[i].Giorni[j].Ass2) or
         (A058FPianifTurniDtm1.xValoreOrigine.Flag <> A058FPianifTurniDtm1.Vista[i].Giorni[j].Flag) or
         (A058FPianifTurniDtm1.xValoreOrigine.Squadra <> A058FPianifTurniDtm1.Vista[i].Giorni[j].Squadra) or
         (A058FPianifTurniDtm1.xValoreOrigine.DSquadra <> A058FPianifTurniDtm1.Vista[i].Giorni[j].DSquadra) or
         (A058FPianifTurniDtm1.xValoreOrigine.Oper <> A058FPianifTurniDtm1.Vista[i].Giorni[j].Oper) or
         (A058FPianifTurniDtm1.xValoreOrigine.Area <> A058FPianifTurniDtm1.Vista[i].Giorni[j].Area) or
         (A058FPianifTurniDtm1.xValoreOrigine.DArea <> A058FPianifTurniDtm1.Vista[i].Giorni[j].DArea) or
         (A058FPianifTurniDtm1.xValoreOrigine.Note <> A058FPianifTurniDtm1.Vista[i].Giorni[j].Note) or
         (A058FPianifTurniDtm1.xValoreOrigine.Antincendio <> A058FPianifTurniDtm1.Vista[i].Giorni[j].Antincendio) or
         (A058FPianifTurniDtm1.xValoreOrigine.Referente <> A058FPianifTurniDtm1.Vista[i].Giorni[j].Referente) or
         (A058FPianifTurniDtm1.xValoreOrigine.RichiestoDaTurnista <> A058FPianifTurniDtm1.Vista[i].Giorni[j].RichiestoDaTurnista) then
      begin
        A058FPianifTurniDtm1.Vista[i].Giorni[j].Modificato:=True; //Setto il flag che indica che la cella è stata modificata
        DatoModificato:=True;
      end;
      A058FPianifTurniDtM1.AnomalieXDipendente(A058FPianifTurniDtm1.Vista[i]);
      A058FPianifTurniDtM1.Vista.Controllo_TurnoAntincendio(A058FPianifTurniDtm1.Vista[i].Giorni[j].Data,
                                                            A058FPianifTurniDtm1.Vista[i].Giorni[j].Data);
      A058FPianifTurniDtM1.Vista.Controllo_Referente(A058FPianifTurniDtm1.Vista[i].Giorni[j].Data,
                                                     A058FPianifTurniDtm1.Vista[i].Giorni[j].Data);
      A058FPianifTurniDtM1.ConteggiGiornalieri(A058FPianifTurniDtm1.DataInizio + j,A058FPianifTurniDtm1.Vista[i],j);
      A058FPianifTurniDtm1.DebitoDipendente(A058FPianifTurniDtm1.Vista[i],0,Trunc(A058FPianifTurniDtm1.DataFine - A058FPianifTurniDtm1.DataInizio));
      A058FPianifTurniDtm1.AggiornaContatoriTurni(i,j);
      ImpostaAltezzaRiga(i);
      if A058FPianifTurniDtM1.RicercaSostituti then
        A058FPianifTurniDtm1.Vista[i].Giorni[j].Modificato:=False; //Setto il flag che indica che la cella è stata registrata
      GVista.Repaint;
    end;
  finally
    A058FPianifTurniDtM1.PulisciDipSostituto;
    A058FPianifTurniDtM1.RicercaSostituti:=False;
    A058FModPianif.Release;
    A058FPianifTurniDtM1.Q265.Filtered:=False;
    A058FPianifTurniDtM1.Q265B.Filtered:=False;
    A058FPianifTurniDtM1.Q020.Filtered:=False;
  end;
end;

procedure TA058FGrigliaPianif.BRegistrazioneClick(Sender: TObject);
{Pianificazione operativa}
var
  i:integer;
begin
  if A058FDettaglioGiornata <> nil then
    FreeAndNil(A058FDettaglioGiornata);
  if (Parametri.CampiRiferimento.C11_PianifOrariProg = 'S') and (A058FPianifTurniDtm1.selT082.fieldByName('MODALITA_LAVORO').AsString = 'O') then
    if R180MessageBox(A000MSG_A058_DLG_REG_PIANIF, DOMANDA) <> mrYes then
      exit;
  RegistraMsg.IniziaMessaggio('A058');
  PGVista.Position:=0;
  PGVista.Max:=A058FPianifTurniDtm1.Vista.Count;
  //Scorro Vista (elenco dipendenti)
  for i:=0 to A058FPianifTurniDtm1.Vista.Count - 1 do
  begin
    PGVista.Position:=PGVista.Position + 1;
    A058FPianifTurniDtm1.EseguiPianificazione(i,-1);
  end;
  A058FPianifTurniDtm1.A058PCKT080TURNO.CopiaTurnazione;
  PGVista.Position:=0;
  DatoModificato:=False;
  A058FPianifTurniDtm1.Vista.ResetModifica;
  GVista.Repaint;
end;

procedure TA058FGrigliaPianif.BCancellazioneClick(Sender: TObject);
var i:Integer;
begin
  if A058FDettaglioGiornata <> nil then
    FreeAndNil(A058FDettaglioGiornata);
  if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
  begin
    if R180MessageBox(A000MSG_A058_DLG_CANC_PIANIF_PROG, DOMANDA) <> mrYES then
      exit;
  end
  else
  begin
    if R180MessageBox(A000MSG_A058_DLG_CANC_PIANIF, DOMANDA) <> mrYes then
      exit;
  end;
  RegistraMsg.IniziaMessaggio('A058');
  PGVista.Position:=0;
  with A058FPianifTurniDtm1 do
  begin
    PGVista.Max:=Vista.Count;
    //Scorro Vista (elenco dipendenti)
    for i:=0 to Vista.Count - 1 do
    begin
      PGVista.Position:=PGVista.Position + 1;
      CancellaPianificazione(Vista[i].Prog);
    end;
  end;
  PGVista.Position:=0;
  Close;
end;

procedure TA058FGrigliaPianif.btnAnteprimaClick(Sender: TObject);
{Richiamo finestra di dialogo per stampa tabellone turni}
begin
  if A058FDettaglioGiornata <> nil then
    FreeAndNil(A058FDettaglioGiornata);
  A058FPianifTurni.Anteprima_Stampa(True);
end;

procedure TA058FGrigliaPianif.btnBloccaSbloccaClick(Sender: TObject);
var Operazione,dOperazione:String; // 'B' Blocca; 'S' Sblocca
    abilitaBlocca,abilitaSblocca:Boolean;
begin
  if Sender = btnBlocca1 then
  begin
    Operazione:='B';
    dOperazione:='BLOCCATI';
  end
  else
  begin
    Operazione:='S';
    dOperazione:='SBLOCCATI';
  end;

  if R180MessageBox(Format(A000MSG_A058_DLG_BLOCCA_SBLOCCA,[dOperazione]), DOMANDA) <> mrYes then
  begin
    btnBlocca1.Down:=False;
    btnSblocca1.Down:=False;
    exit;
  end;

  A058FPianifTurniDtm1.EseguiBloccaSblocca(Operazione);

  btnBlocca1.Down:=False;
  btnSblocca1.Down:=False;
  //---
  with A058FPianifTurniDtM1 do
  begin
    AbilitaBloccaSblocca(abilitaBlocca,abilitaSblocca);
    btnBlocca1.Enabled:=PianifNonOperativa and AbilitazioneA126 and abilitaBlocca;
    btnSblocca1.Enabled:=PianifNonOperativa and AbilitazioneA126 and abilitaSblocca;
    lblBlocca.Visible:=PianifBloccata(Vista[RowSelectCel].Prog,DataInizio + ColSelectCel);
  end;
end;

procedure TA058FGrigliaPianif.btnFiltroAnomalieClick(Sender: TObject);
var
  ChkListAnomalie:TC013FCheckList;
  i:TTipiAnomalie;
  j:integer;
begin
  ChkListAnomalie:=TC013FCheckList.Create(nil);
  try
    for i:=TTipiAnomalie.ta11Ore to TTipiAnomalie.taReferente do
    begin
      ChkListAnomalie.clbListaDati.Items.Add(i.toString);
    end;
    R180PutCheckList(A058FPianifTurniDtM1.Vista.PropElencoAnomalie.GetAnomalieAttive,100,ChkListAnomalie.clbListaDati,',');
    ChkListAnomalie.ShowModal;
    A058FPianifTurniDtM1.Vista.PropElencoAnomalie.SetAnomalieAttive(R180GetCheckList(100,ChkListAnomalie.clbListaDati,','));
    for j:=0 to A058FPianifTurniDtM1.Vista.Count - 1 do
    begin
      A058FPianifTurniDtM1.AnomalieXDipendente(A058FPianifTurniDtM1.Vista[j]);
    end;
    A058FPianifTurniDtM1.Vista.Controllo_TurnoAntincendio(A058FPianifTurniDtM1.Vista[0].Giorni[0].Data,
                                                          A058FPianifTurniDtM1.Vista[0].Giorni[A058FPianifTurniDtM1.Vista[0].Giorni.Count - 1].Data);
    A058FPianifTurniDtM1.Vista.Controllo_Referente(A058FPianifTurniDtM1.Vista[0].Giorni[0].Data,
                                                   A058FPianifTurniDtM1.Vista[0].Giorni[A058FPianifTurniDtM1.Vista[0].Giorni.Count - 1].Data);
    btnFiltroAnomalie.Hint:=Format('Elenco anomalie attive: %s %s',[#13#10,A058FPianifTurniDtM1.Vista.PropElencoAnomalie.GetAnomalieAttive]);
  finally
    FreeAndNil(ChkListAnomalie);
    GVista.Repaint;
  end;
end;

procedure TA058FGrigliaPianif.btnLegendaClick(Sender: TObject);
begin
  A058FLegenda.ShowModal;
end;

procedure TA058FGrigliaPianif.GVistaKeyPress(Sender: TObject; var Key: Char);
var
  i,j:Integer;
  D:TDateTime;
  //Giorno:TGiorno;
  bSoloOrario:boolean;
begin
  if FastGiust = '' then
    exit;
  i:=GVista.Row - nRigheBloccate;
  j:=GVista.Col - nColonneBloccate + A058FPianifTurniDtm1.OffsetVista;
  bSoloOrario:=False;
  Key:=UpCase(Key);
  D:=A058FPianifTurniDtm1.DataInizio + j;
  TastoPremuto:=Trim(TastoPremuto);
  with A058FPianifTurniDtm1 do
  begin
    if Ord(Key) in [VK_ESCAPE] then
    begin
      Vista[i].Giorni[j].T1:=xValoreOrigine.T1;
      Vista[i].Giorni[j].T2:=xValoreOrigine.T2;
      Vista[i].Giorni[j].SiglaT1:=xValoreOrigine.SiglaT1;
      Vista[i].Giorni[j].NumTurno1:=xValoreOrigine.NumTurno1;
      Vista[i].Giorni[j].SiglaT2:=xValoreOrigine.SiglaT2;
      Vista[i].Giorni[j].NumTurno2:=xValoreOrigine.NumTurno2;
      Vista[i].Giorni[j].T1EU:=xValoreOrigine.T1EU;
      Vista[i].Giorni[j].T2EU:=xValoreOrigine.T2EU;
      Vista[i].Giorni[j].Ora:=xValoreOrigine.Ora;
      Vista[i].Giorni[j].ValorGior:=xValoreOrigine.ValorGior;
      Vista[i].Giorni[j].Ass1:=xValoreOrigine.Ass1;
      Vista[i].Giorni[j].Ass2:=xValoreOrigine.Ass2;
      Vista[i].Giorni[j].Ass1Competenza:=xValoreOrigine.Ass1Competenza;
      Vista[i].Giorni[j].Ass2Competenza:=xValoreOrigine.Ass2Competenza;
      Vista[i].Giorni[j].Flag:=xValoreOrigine.Flag;
      Vista[i].Giorni[j].Squadra:=xValoreOrigine.Squadra;
      Vista[i].Giorni[j].DSquadra:=xValoreOrigine.DSquadra;
      Vista[i].Giorni[j].Oper:=xValoreOrigine.Oper;
      Vista[i].Giorni[j].Area:=xValoreOrigine.Area;
      Vista[i].Giorni[j].DArea:=xValoreOrigine.DArea;
      Vista[i].Giorni[j].Antincendio:=xValoreOrigine.Antincendio;
      Vista[i].Giorni[j].Referente:=xValoreOrigine.Referente;
      Vista[i].Giorni[j].RichiestoDaTurnista:=xValoreOrigine.RichiestoDaTurnista;
      Vista[i].Giorni[j].Note:=xValoreOrigine.Note;
      Vista[i].Giorni[j].Modificato:=xValoreOrigine.Modificato;
      Key:=#0;
      TastoPremuto:='';
      ConteggiGiornalieri(A058FPianifTurniDtm1.DataInizio + j,Vista[i],j);
      DebitoDipendente(Vista[i],0,Trunc(A058FPianifTurniDtm1.DataFine - A058FPianifTurniDtm1.DataInizio));
      AggiornaContatoriTurni(i,j);
      GVista.Repaint;
      exit;
    end;
    if Ord(Key) in [VK_BACK] then
    begin
      TastoPremuto:=Copy(TastoPremuto,1,Length(TastoPremuto) - 1);
      Key:=#0;
      if Trim(Vista[i].Giorni[j].T1) = ' M' then
        bSoloOrario:=True;
    end;
    if Copy(FastGiust,1,1) = 'T' then
    begin
      if (Key <> #0) and
         ((StrToIntDef(Key,-1) < 0) or (StrToIntDef(Key,-1) > 99)) and
         ((Key <> 'E') and (Key <> 'U')) then
         exit;
      if (Length(TastoPremuto)>=3) and
         (Key in ['0'..'9']) then
        TastoPremuto:='  ' + Copy(TastoPremuto,3,1)
      else if (Pos('E',TastoPremuto)=0) and
         (Pos('U',TastoPremuto)=0) and
         (Key in ['0'..'9']) and
         (Length(TastoPremuto)>=2) then
        TastoPremuto:='';
    end
    else if R180In(FastGiust,['A1','A2','O']) then
    begin
      if (Key <> #0) and (not (Key in ['A'..'Z','a'..'z','0'..'9',#0])) then
        exit;
      if Length(TastoPremuto) >= 5 then
        TastoPremuto:='';
    end
    else if FastGiust = 'AI' then
    begin
      if (Key <> #0) and not (Key in ['S','s','N','n',#0]) then
        exit;
      if Length(TastoPremuto) >= 1 then
        TastoPremuto:='';
    end;
    if (Key <> #0) then
    begin
      if Copy(FastGiust,1,1) = 'T' then
      begin
        if ((Key = 'E')or(Key = 'U')) then
        begin
          if Pos('E',TastoPremuto)>0 then
            TastoPremuto:=StringReplace(TastoPremuto,'E',Key,[rfReplaceAll])
          else if Pos('U',TastoPremuto)>0 then
            TastoPremuto:=StringReplace(TastoPremuto,'U',Key,[rfReplaceAll])
          else if trim(TastoPremuto) <> '' then
            TastoPremuto:=TastoPremuto + Key;
        end
        else if Length(TastoPremuto) = 1 then
          TastoPremuto:=TastoPremuto + Key
        else
          TastoPremuto:=Copy(TastoPremuto,1,1) + Key + Copy(TastoPremuto,Length(TastoPremuto),1);
      end
      else if R180In(FastGiust,['A1','A2','AI','O']) then
        TastoPremuto:=TastoPremuto + Key;
    end;

    if FastGiust = 'T1' then
    begin
      if (Key = #0) and (trim(TastoPremuto) = '') then
      begin
        Vista[i].Giorni[j].T1:='  ';
        Vista[i].Giorni[j].T1EU:=' ';
      end
      else
        if (Key in ['E','U']) then
          Vista[i].Giorni[j].T1EU:=Key
        else
        begin
          if Vista[i].Giorni[j].Ora.Trim <> '' then
          begin
            A058FPianifTurniDtM1.RefreshQ021(A058FPianifTurniDtm1.DataInizio + GVista.Col - nColonneBloccate + A058FPianifTurniDtm1.OffsetVista);
            A058FPianifTurniDtM1.Q021.Filter:='CODICE = ''' + Vista[i].Giorni[j].Ora + '''';
            A058FPianifTurniDtM1.Q021.Filtered:=True;
            if StrToIntDef(Copy(TastoPremuto,1,2),999) <= A058FPianifTurniDtM1.Q021.RecordCount then
              Vista[i].Giorni[j].T1:=Format('%2s',[Copy(TastoPremuto,1,2)])
            else if StrToIntDef(Copy(Key,1,2),999) <= A058FPianifTurniDtM1.Q021.RecordCount then
              Vista[i].Giorni[j].T1:=Format('%2s',[Copy(Key,1,2)])
          end
          else
            Vista[i].Giorni[j].T1:=Format('%2s',[Copy(TastoPremuto,1,2)]);
          if (Pos('E',TastoPremuto) = 0) and (Pos('U',TastoPremuto) = 0) then
            Vista[i].Giorni[j].T1EU:=' ';
        end;
    end
    else if (FastGiust = 'T2') and (Trim(Vista[i].Giorni[j].T1) <> '') then
    begin
      if (Key = #0) and (Trim(TastoPremuto) = '') then
      begin
        Vista[i].Giorni[j].T2:='  ';
        Vista[i].Giorni[j].T2EU:=' '
      end
      else
        if (Key in ['E','U']) then
          Vista[i].Giorni[j].T2EU:=Key
        else
        begin
          Vista[i].Giorni[j].T2:=Format('%2s',[Copy(TastoPremuto,1,2)]);
          if (Pos('E',TastoPremuto)=0) and (Pos('U',TastoPremuto)=0) then
            Vista[i].Giorni[j].T2EU:=' ';
        end;
    end
    else if FastGiust = 'A1' then
    begin
      if not Vista[i].Giorni[j].Ass1Modif then
        Key:=#0
      else if (Key = #0) and (Trim(TastoPremuto) = '') then
      begin
        Vista[i].Giorni[j].Ass1:='';
        Vista[i].Giorni[j].Ass1Competenza:=caVuota;
      end
      else
      begin
        //Se la causale non esiste non devo far scrivere nulla
        A058FPianifTurniDtM1.EscludiTipoCumulo:=(A058FPianifTurniDtm1.selT082.fieldByName('MODALITA_LAVORO').AsString = 'O') or A058FPianifTurniDtM1.AssenzeOperative;
        A058FPianifTurniDtM1.Q265.Filtered:=True;
        if A058FPianifTurniDtM1.Q265.Locate('Codice',TastoPremuto,[loCaseInsensitive,loPartialKey]) then
        begin
          Vista[i].Giorni[j].Ass1:=A058FPianifTurniDtM1.Q265.FieldByName('CODICE').AsString;
          Vista[i].Giorni[j].Ass1Competenza:=caPianificazione;
        end
        else
        begin
          TastoPremuto:=Copy(TastoPremuto,1,Length(TastoPremuto)-1);
          if A058FPianifTurniDtM1.Q265.Locate('Codice',TastoPremuto,[loCaseInsensitive,loPartialKey]) then
          begin
            Vista[i].Giorni[j].Ass1:=A058FPianifTurniDtM1.Q265.FieldByName('CODICE').AsString;
            Vista[i].Giorni[j].Ass1Competenza:=caPianificazione;
          end;
          Key:=#0;
        end;
        A058FPianifTurniDtM1.Q265.Filtered:=False;
        A058FPianifTurniDtM1.EscludiTipoCumulo:=False;
      end;
    end
    else if FastGiust = 'A2' then
    begin
      if not Vista[i].Giorni[j].Ass2Modif then
        Key:=#0
      else if (Key = #0) and (Trim(TastoPremuto) = '') then
        Vista[i].Giorni[j].Ass2:=''
      else
      begin
        //Se la causale non esiste non devo far scrivere nulla
        A058FPianifTurniDtM1.EscludiTipoCumulo:=(A058FPianifTurniDtm1.selT082.fieldByName('MODALITA_LAVORO').AsString = 'O') or A058FPianifTurniDtM1.AssenzeOperative;
        A058FPianifTurniDtM1.Q265.Filtered:=True;
        if A058FPianifTurniDtM1.Q265.Locate('Codice',TastoPremuto,[loCaseInsensitive,loPartialKey]) then
        begin
          Vista[i].Giorni[j].Ass2:=A058FPianifTurniDtM1.Q265.FieldByName('CODICE').AsString;
          Vista[i].Giorni[j].Ass2Competenza:=caPianificazione;
        end
        else
        begin
          TastoPremuto:=Copy(TastoPremuto,1,Length(TastoPremuto)-1);
          if A058FPianifTurniDtM1.Q265.Locate('Codice',TastoPremuto,[loCaseInsensitive,loPartialKey]) then
          begin
            Vista[i].Giorni[j].Ass2:=A058FPianifTurniDtM1.Q265.FieldByName('CODICE').AsString;
            Vista[i].Giorni[j].Ass2Competenza:=caPianificazione;
          end;
          Key:=#0;
        end;
        A058FPianifTurniDtM1.Q265.Filtered:=False;
        A058FPianifTurniDtM1.EscludiTipoCumulo:=False;
      end
    end
    else if FastGiust = 'O' then
    begin
      if (Key = #0) and (Trim(TastoPremuto) = '') then
      begin
        if bSoloOrario then
          Vista[i].Giorni[j].T1:='';
        Vista[i].Giorni[j].Ora:='';
      end
      else
      begin
        //Lello
        //Se la causale non esiste non devo far scrivere nulla
        A058FPianifTurniDtm1.ImpostaFiltroOrariSquadra(D);
        A058FPianifTurniDtM1.Q020.Filtered:=True;
        if A058FPianifTurniDtM1.Q020.Locate('Codice',TastoPremuto,[loCaseInsensitive,loPartialKey]) then
          Vista[i].Giorni[j].Ora:=A058FPianifTurniDtM1.Q020.FieldByName('CODICE').AsString
        else
        begin
          TastoPremuto:=Copy(TastoPremuto,1,Length(TastoPremuto)-1);
          if A058FPianifTurniDtM1.Q020.Locate('Codice',TastoPremuto,[loCaseInsensitive,loPartialKey]) then
            Vista[i].Giorni[j].Ora:=A058FPianifTurniDtM1.Q020.FieldByName('CODICE').AsString;
          Key:=#0;
        end;
        A058FPianifTurniDtM1.Q020.Filtered:=False;
      end;
    end
    else if FastGiust = 'AI' then
    begin
      if (Key = #0) and (Trim(TastoPremuto) = '') then
        Vista[i].Giorni[j].Antincendio:='N'
      else
        Vista[i].Giorni[j].Antincendio:=TastoPremuto;
    end;

    if ((Trim(Vista[i].Giorni[j].T1) = '') or (Trim(Vista[i].Giorni[j].T1) = 'A')) and (Trim(Vista[i].Giorni[j].T2) <> '') then
    begin
      Vista[i].Giorni[j].T1:=Vista[i].Giorni[j].T2;
      Vista[i].Giorni[j].T2:='';
      btnTurno1.Down:=True;
      btnTurno1Click(nil);
      //FastGiust:='T1';
      //LblModificaRapida.Caption:='Modifica rapida ''PRIMO TURNO''';
    end;
    (*Alberto 22/04/2016: eliminata gestione di scambio di Ass1 con Ass2: Ass2 non è MAI modificabile dalla modifica rapida
    if (Trim(Ass1) = '') and (Trim(Ass2) <> '') then
    begin
      Ass1:=Ass2;
      Ass2:='';
      if FastGiust='A2' then
      begin
        FastGiust:='A1';
        LblModificaRapida.Caption:='Modifica rapida ''PRIMA ASSENZA''';
      end;
    end;
    *)
    if (Trim(Vista[i].Giorni[j].Ass1) <> '') and (Trim(Vista[i].Giorni[j].T1)='') then
      Vista[i].Giorni[j].T1:=' A';
    if (Trim(Vista[i].Giorni[j].Ora) <> '') and ((Trim(Vista[i].Giorni[j].T1) = '') or (Trim(Vista[i].Giorni[j].T1) = ' M')) and (bSoloOrario=False) then
      if Trim(Vista[i].Giorni[j].T2)<>'' then
      begin
        Vista[i].Giorni[j].T1:=Vista[i].Giorni[j].T2;
        Vista[i].Giorni[j].T2:='';
      end
      else if Trim(Vista[i].Giorni[j].Ass1)<>'' then
        Vista[i].Giorni[j].T1:=' A'
      else
        Vista[i].Giorni[j].T1:=' M';
    if (Trim(Vista[i].Giorni[j].T1) = 'A') and Vista[i].Giorni[j].Ass1Modif and (Trim(Vista[i].Giorni[j].Ass1) = '') then
      Vista[i].Giorni[j].T1:=' M';
    if (Trim(Vista[i].Giorni[j].T1) = '') and (Vista[i].Giorni[j].Ora <> '') then
    begin
      Vista[i].Giorni[j].T1:='';
      Vista[i].Giorni[j].Ora:='';
      TastoPremuto:='';
    end;
    if (Trim(Vista[i].Giorni[j].T1) < '1') or (Trim(Vista[i].Giorni[j].T1) > '99') then
      Vista[i].Giorni[j].T1EU:='';
    //Se è pianificato il turno ma manca l'orario lo ricerco nello storico
    if (Trim(Vista[i].Giorni[j].Ora) = '') and (Trim(Vista[i].Giorni[j].T1) <> '') then
      Vista[i].Giorni[j].Ora:=A058FPianifTurniDtM1.GetOrarioStorico(D,Vista[i].Prog);

    if (xValoreOrigine.T1 <> Vista[i].Giorni[j].T1) or (xValoreOrigine.T2 <> Vista[i].Giorni[j].T2) or
       (xValoreOrigine.SiglaT1 <> Vista[i].Giorni[j].SiglaT1) or (xValoreOrigine.SiglaT2 <> Vista[i].Giorni[j].SiglaT2) or
       (xValoreOrigine.T1EU <> Vista[i].Giorni[j].T1EU) or (xValoreOrigine.T2EU <> Vista[i].Giorni[j].T2EU) or
       (xValoreOrigine.Ora <> Vista[i].Giorni[j].Ora) or (xValoreOrigine.ValorGior <> Vista[i].Giorni[j].ValorGior) or
       (xValoreOrigine.Ass1 <> Vista[i].Giorni[j].Ass1) or (xValoreOrigine.Ass2 <> Vista[i].Giorni[j].Ass2) or
       (xValoreOrigine.Flag <> Vista[i].Giorni[j].Flag) or (xValoreOrigine.Squadra <> Vista[i].Giorni[j].Squadra) or
       (xValoreOrigine.DSquadra <> Vista[i].Giorni[j].DSquadra) or (xValoreOrigine.Oper <> Vista[i].Giorni[j].Oper) or
       (xValoreOrigine.Area <> Vista[i].Giorni[j].Area) or (xValoreOrigine.DArea <> Vista[i].Giorni[j].DArea) or
       (xValoreOrigine.Antincendio <> Vista[i].Giorni[j].Antincendio) or (xValoreOrigine.Note <> Vista[i].Giorni[j].Note) or
       (xValoreOrigine.Referente <> Vista[i].Giorni[j].Referente) or (xValoreOrigine.RichiestoDaTurnista <> Vista[i].Giorni[j].RichiestoDaTurnista)
    then
    begin
      Vista[i].Giorni[j].Modificato:=True; //Setto il flag che indica che la cella è stata modificat
      DatoModificato:=True;
    end;

    //Fine lettura sigla dei turni
    //GVista.Cells[j + 5,i + 2]:=Format('%-2s%-3s%-1s%s',[T1, SiglaT1, T1EU,R180DimLung(Ora,5)]);
    AnomalieXDipendente(Vista[i]);
    Vista.Controllo_TurnoAntincendio(Vista[i].Giorni[j].Data,Vista[i].Giorni[j].Data);
    ConteggiGiornalieri(A058FPianifTurniDtm1.DataInizio + j,Vista[i], j);
    DebitoDipendente(Vista[i],0,Trunc(A058FPianifTurniDtm1.DataFine - A058FPianifTurniDtm1.DataInizio));
    AggiornaContatoriTurni(i,j);
    GVista.Repaint;
  end;
end;

procedure TA058FGrigliaPianif.btnTurno1Click(Sender: TObject);
begin
  if btnTurno1.Down then
  begin
    //SpeedButton1.PopupMenu:=popmnuModificarapida;
    GVista.OnKeyPress:=GVistaKeyPress;
    (*
    SpeedButton1.Hint:='Premere ''Ctrl'' + ''T'' per pianificare il Primo Turno' + #$A#$D +
                       'Premere ''Ctrl'' + ''Numero'' per pianificare il Secondo Turno' + #$A#$D +
                       'Premere ''Ctrl'' + ''A'' per pianificare la Prima Assenza' + #$A#$D +
                       'Premere ''Ctrl'' + ''O'' per pianificare l''orario';
    *)
    FastGiust:='T1';
    LblModificaRapida.Caption:='Modifica rapida ''PRIMO TURNO''';
  end
  else if btnAssenza1.Down then
  begin
    FastGiust:='A1';
    LblModificaRapida.Caption:='Modifica rapida ''PRIMA ASSENZA''';
  end
  else if btnOrario.Down then
  begin
    FastGiust:='O';
    LblModificaRapida.Caption:='Modifica rapida ''ORARIO''';
  end
  else if btnAntincendio.Down then
  begin
    FastGiust:='AI';
    LblModificaRapida.Caption:='Modifica rapida ''RESPONSABILI ANTINCENDIO''';
  end
  else
  begin
    //SpeedButton1.PopupMenu:=nil;
    GVista.OnKeyPress:=nil;
    //SpeedButton1.Hint:='Modifica rapida';
    FastGiust:='';
    LblModificaRapida.Caption:='';
    TastoPremuto:='';
  end;
end;

procedure TA058FGrigliaPianif.GVistaSelectCell(Sender: TObject; Col,Row: Integer; var CanSelect: Boolean);
var
  i,j,iRep:integer;
  RefreshGrid,RiepBloccato:Boolean;
  strHint:String;
begin
  TastoPremuto:='';
  i:=Row - nRigheBloccate;
  j:=Col - nColonneBloccate + A058FPianifTurniDtm1.OffsetVista;
  // salvo le coordinate della cella selezionata per reperire i dati utili a Blocca/Sblocca
  RowSelectCel:=i;
  ColSelectCel:=j;
  GVista.Hint:='';
  with A058FPianifTurniDtm1 do
  begin
    if Vista.Count = 0 then
      Exit;
    // abilito pulsanti di blocca sblocca in base all'abilitazione dell'utente ed alla situazione del riepilogo
    if PianifNonOperativa then
    begin
      RiepBloccato:=PianifBloccata(Vista[i].Prog,DataInizio + j);
      lblBlocca.Visible:=RiepBloccato;
    end;
    //Salvo i dati della cella appena selezionata in una struttura di appoggio
    with Vista[i].Giorni[j] do
    begin
      btnTurno1.Enabled:=Squadra = SquadraRiferimento;
      btnAssenza1.Enabled:=btnTurno1.Enabled;
      btnOrario.Enabled:=btnTurno1.Enabled;
      btnAntincendio.Enabled:=btnTurno1.Enabled;
      RefreshGrid:=xValoreOrigine.Oper <> Oper;
      xValoreOrigine.ParentDipendente:=ParentDipendente;
      xValoreOrigine.Ora:=Ora;
      xValoreOrigine.T1:=T1;
      xValoreOrigine.T2:=T2;
      xValoreOrigine.SiglaT1:=SiglaT1;
      xValoreOrigine.NumTurno1:=NumTurno1;
      xValoreOrigine.SiglaT2:=SiglaT2;
      xValoreOrigine.NumTurno2:=NumTurno2;
      xValoreOrigine.T1EU:=T1EU;
      xValoreOrigine.T2EU:=T2EU;
      xValoreOrigine.ValorGior:=ValorGior;
      xValoreOrigine.Ass1:=Ass1;
      xValoreOrigine.Ass2:=Ass2;
      xValoreOrigine.Ass1Competenza:=Ass1Competenza;
      xValoreOrigine.Ass2Competenza:=Ass2Competenza;
      xValoreOrigine.Flag:=Flag;
      xValoreOrigine.Squadra:=Squadra;
      xValoreOrigine.DSquadra:=DSquadra;
      xValoreOrigine.Oper:=Oper;
      xValoreOrigine.Area:=Area;
      xValoreOrigine.DArea:=DArea;
      xValoreOrigine.Antincendio:=Antincendio;
      xValoreOrigine.Referente:=Referente;
      xValoreOrigine.RichiestoDaTurnista:=RichiestoDaTurnista;
      xValoreOrigine.Note:=Note;
      xValoreOrigine.Modificato:=Modificato;

      strHint:=Format('%s: %s',['Orario',IfThen(Ora <> '',Ora,'(non assegnato)')]);
      if (T1.Trim <> '') and (T1.Trim <> 'M') and (T1.Trim <> 'A') then
        strHint:=strHint + CRLF + Format('%s: %s%s%s %s-%s',['Turno1',T1,T1EU,SiglaT1,R180MinutiOre(MinutiEntrata1),R180MinutiOre(MinutiUscita1)]);
      if T2.Trim <> '' then
        strHint:=strHint + CRLF + Format('%s: %s%s%s %s-%s',['Turno2',T2,T2EU,SiglaT2,R180MinutiOre(MinutiEntrata2),R180MinutiOre(MinutiUscita2)]);
      if Area <> '' then
        strHint:=strHint + CRLF + Format('%s: (%s) %s',['Area', GetSiglaArea(Area), dArea]);
      if Antincendio = 'S' then
        strHint:=strHint + CRLF + Format('%s',['Responsabile Antincendio']);
      if Referente = 'S' then
        strHint:=strHint + CRLF + Format('%s',['Referente']);
      if RichiestoDaTurnista = 'S' then
        strHint:=strHint + CRLF + Format('%s',['Richiesto da turnista']);
      if Ass1 <> '' then
        strHint:=strHint + CRLF + Format('%s: %s',['Assenze a giornata',Ass1]);
        if Ass2 <> '' then
          strHint:=strHint + ' ' + Ass2;
      if AssOre <> nil then
      begin
        if AssOre.Count > 0 then
        begin
          for i:=0 to (AssOre.Count - 1) do
          begin
            if (i = 0) then
              strHint:=strHint + CRLF + 'Altre assenze:';
            strHint:=strHInt + CRLF + ' ' + Format('%s %s',[AssOre[i].Causale,AssOre[i].Orario]);
          end;
        end;
      end;
      for iRep:=Low(TurniRep) to High(TurniRep) do
      begin
        if TurniRep[iRep].Turno <> '' then
        begin
          if iRep = Low(TurniRep) then
            strHint:=strHint + CRLF + Format('%s:',['Reperibile']);
          strHint:=strHint + CRLF + Format(' %s %s-%s',[TurniRep[iRep].Sigla{Turno},TurniRep[iRep].OraInizio,TurniRep[iRep].OraFine]);
        end;
      end;
      if Note.Trim <> '' then
        strHint:=strHint + CRLF + Format('Note:' + CRLF + '%s',[Note]);
      if Anomalie.TextAnomalie.Trim <> '' then
        strHint:=strHint + CRLF + Format('Anomalie:' + CRLF + '%s',[Anomalie.TextAnomalie]);
      GVista.Hint:=strHint;
    end;
  end;
  if RefreshGrid then
  begin
    GVista.Col:=Col;
    GVista.Row:=Row;
    GVista.Refresh;
  end;
end;

procedure TA058FGrigliaPianif.InsCancGiust1Click(Sender: TObject);
var
  PData: TDateTime;
  PCausale:String;
  PProg, IGiorno:Integer;
begin
  //with A058FPianifTurniDtm1 do
  begin
    if A058FPianifTurniDtm1.Vista.Modificato then
      raise Exception.Create(A000MSG_A058_ERR_MODIFICHE_PENDENTI);

    PProg:=GVista.Row - nRigheBloccate;
    IGiorno:=GVista.Col - nColonneBloccate + A058FPianifTurniDtm1.OffsetVista;
    PData:=A058FPianifTurniDtM1.DataInizio + IGiorno;

    PCausale:=A058FPianifTurniDtm1.Vista[PProg].Giorni[IGiorno].Ass1;
    if PCausale = '' then
    begin
      PCausale:=A058FPianifTurniDtm1.Vista[PProg].Giorni[IGiorno].Ass2;
    end;

    A058FPianifTurni.frmSelAnagrafe.SalvaC00SelAnagrafe;
    C700Distruzione;
    OpenA004GiustifAssPres(A058FPianifTurniDtm1.Vista[PProg].Prog,DateToStr(PData),'','','',PCausale,0,True);
    C700DatiSelezionati:=C700CampiBase;
    C700Creazione(SessioneOracle);
    C700OldProgressivo:=-1;
    A058FPianifTurni.frmSelAnagrafe.RipristinaC00SelAnagrafe;
    A058FPianifTurniDtm1.RefreshAssenze(A058FPianifTurniDtm1.DataInizio,A058FPianifTurniDtm1.DataFine);
    //Controllo anomalie turni
    A058FPianifTurniDtm1.AnomalieXDipendente(A058FPianifTurniDtm1.Vista[PProg]);
    A058FPianifTurniDtm1.Vista.Controllo_TurnoAntincendio(PData,PData);
    A058FPianifTurniDtm1.Vista.Controllo_Referente(PData,PData);
    //************************
    A058FPianifTurniDtm1.ConteggiGiornalieri(StrToDate(GVista.Cells[GVista.Col,0]),A058FPianifTurniDtm1.Vista[PProg],IGiorno);
    A058FPianifTurniDtm1.DebitoDipendente(A058FPianifTurniDtm1.Vista[PProg],A058FPianifTurniDtm1.OffsetVista,
                     A058FPianifTurniDtm1.OffsetVista + Trunc(A058FPianifTurniDtm1.DataFine - A058FPianifTurniDtm1.DataInizio));
    ImpostaAltezzaRiga(PProg);
    GVista.Repaint;
  end;
end;

procedure TA058FGrigliaPianif.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  A058FPianifTurniDtM1.AnomaliePianif:=False;
  if A058FDettaglioGiornata <> nil then
    FreeAndNil(A058FDettaglioGiornata);
  if DatoModificato then
    if Application.MessageBox('Le modifiche apportate non sono state salvate!' + #13 +
       'Uscire comunque?' ,'',MB_YESNO) = IDNO then
      Action:=caNone
    else
    begin
      SessioneOracle.Rollback; //annulla le modifiche in sospeso, es. scrT630
    end;
  FreeAndNil(A058FLegenda);
  Application.HintHidePause:=2500;
end;

procedure TA058FGrigliaPianif.btnAnomalieClick(Sender: TObject);
begin
  if A058FDettaglioGiornata <> nil then
    FreeAndNil(A058FDettaglioGiornata);
  Self.Cursor:=crHourGlass;
  Self.Enabled:=False;
  GVista.OnDrawCell:=nil;
  A058FPianifTurniDtM1.ControlloAnnualeAnomalie:=chkElaborazioneAnnuale.Checked;
  try
    A058FPianifTurniDtM1.VerificaPianificazione(A058FPianifTurniDtm1.DataInizio,A058FPianifTurniDtm1.DataFine);
  finally
    GVista.OnDrawCell:=GVistaDrawCell;
    Self.Enabled:=True;
    Self.Cursor:=crDefault;
    GVista.Repaint;
  end;
  A058FPianifTurni.frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A058','A,B');
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  A058FPianifTurni.frmSelAnagrafe.RipristinaC00SelAnagrafe;
  A058FPianifTurniDtM1.SelAnagrafeA058:=C700SelAnagrafe;
end;

procedure TA058FGrigliaPianif.BOperativaClick(Sender: TObject);
var
  i:Integer;
begin
  if A058FDettaglioGiornata <> nil then
    FreeAndNil(A058FDettaglioGiornata);
  if DatoModificato then
    raise exception.Create(A000MSG_A058_ERR_REGISTRA_MODIFICHE);
  if R180MessageBox(A000MSG_A058_DLG_RENDI_OPERATIVA, DOMANDA) <> mrYes then
    exit;
  PGVista.Position:=0;
  with A058FPianifTurniDtm1 do
  begin
    PGVista.Max:=Vista.Count;
    //Scorro Vista (elenco dipendenti)
    for i:=0 to Vista.Count - 1 do
    begin
      PGVista.Position:=PGVista.Position + 1;
      RendiOperativa(i);
    end;
  end;
  PGVista.Position:=0;
end;

procedure TA058FGrigliaPianif.PopupMenu1Popup(Sender: TObject);
var
  Ind, PProg:Integer;
begin
  Ind:=GVista.Col - nColonneBloccate + A058FPianifTurniDtm1.OffsetVista;
  PProg:=GVista.Row - nRigheBloccate;
  //Function per disabilitare modifica
  //Modifica1.Enabled:=A058FPianifTurniDtm1.Vista[PProg].Giorni[Ind].Squadra = VarToStr(A058FPianifTurni.dCmbSquadra.KeyValue);
  VisualizzaRiposiFestivi.Caption:= 'Visualizza colonna riposi/fest.lav. da inizio anno';
  Modifica1.Enabled:=BRegistrazione.Enabled and
    (A058FPianifTurniDtm1.Vista[PProg].Giorni[Ind].Squadra = A058FPianifTurniDtm1.SquadraRiferimento);
  CopiaPianificazione1.Enabled:=BRegistrazione.Enabled;
  RicercaSostituti1.Enabled:=Modifica1.Enabled and A058FPianifTurniDtM1.IncludiDipCambioSquadra and not DatoModificato and
    (A058FPianifTurniDtm1.Vista[PProg].Giorni[Ind].Ass1 = '') and not R180In(A058FPianifTurniDtm1.Vista[PProg].Giorni[Ind].NumTurno1,['','0']);
  ValidaCausale1.Enabled:=(A058FPianifTurniDtm1.Vista[PProg].Giorni[Ind].VAss = 'S') and (Parametri.T040_Validazione = 'S');
  InsCancGiust1.Enabled:=AssenzeAbilitate and ((A058FPianifTurniDtm1.selT082.fieldByName('MODALITA_LAVORO').AsString = 'O') or A058FPianifTurniDtM1.AssenzeOperative);
end;

procedure TA058FGrigliaPianif.procProgressBarInizio;
begin
  PGVista.Position:=0;
  PGVista.Max:=A058FPianifTurniDtm1.Vista.Count;
end;

procedure TA058FGrigliaPianif.procProgressBarNext;
begin
  PGVista.Position:=PGVista.Position + 1;
end;

procedure TA058FGrigliaPianif.procProgressBarFine;
begin
  PGVista.Position:=0;
  GVista.Repaint;
end;

procedure TA058FGrigliaPianif.mnuModificaRapidaClick(Sender: TObject);
begin
  (*
  if Sender = mnuFastPrimoTurno then
  begin
    FastGiust:='T1';
    LblModificaRapida.Caption:='Modifica rapida ''PRIMO TURNO''';
  end
  else if Sender = mnuFastPrimaAssenza then
  begin
    FastGiust:='A1';
    LblModificaRapida.Caption:='Modifica rapida ''PRIMA ASSENZA''';
  end
  else if Sender = mnuFastOrario then
  begin
    FastGiust:='O';
    LblModificaRapida.Caption:='Modifica rapida ''ORARIO''';
  end;
  *)
end;

procedure TA058FGrigliaPianif.Reperibilit1Click(Sender: TObject);
var
  PData:TDateTime;
  PProg,Ind:Integer;
begin
  with A058FPianifTurniDtm1 do
  begin
    PProg:=GVista.Row - nRigheBloccate;
    //PData:=StrToDate(GVista.Cells[GVista.Col,0]);
    Ind:=GVista.Col - nColonneBloccate + A058FPianifTurniDtm1.OffsetVista;
    PData:=A058FPianifTurniDtM1.DataInizio + Ind;
    A058FPianifTurni.frmSelAnagrafe.SalvaC00SelAnagrafe;
    C700Distruzione;
    //OpenA040PianifRep(Vista[PProg].Prog,PData,'','','',PCausale,0,True);
    OpenA040PianifRep(Vista[PProg].Prog,'REPERIB',PData);
    C700DatiSelezionati:=C700CampiBase;
    C700Creazione(SessioneOracle);
    C700OldProgressivo:=-1;
    A058FPianifTurni.frmSelAnagrafe.RipristinaC00SelAnagrafe;
    A058FPianifTurniDtM1.SelAnagrafeA058:=C700SelAnagrafe;
    A058FPianifTurniDtM1.RefreshReperibilità;
    //Scorrere Vista[].Giorni[] e aggiornare TurnRep da selT380 refreshato per ogni progressivo
    //A058FPianifTurniDtm1.selT380.Refresh;
    AnomalieXDipendente(Vista[PProg]);
    ImpostaAltezzaRiga(PProg);
    GVista.Repaint;
  end;
end;

procedure TA058FGrigliaPianif.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  (*
  if FastGiust <> '' then
  begin
    if (ssCtrl in Shift) and (Key = 84) then  //Se premo il tasto "T" cambio la pianificazione dei turni
    begin
      TastoPremuto:='';
      begin
        FastGiust:='T1';
        LblModificaRapida.Caption:='Modifica rapida ''PRIMO TURNO''';
      end;
    end
    else if (ssCtrl in Shift) and (Key = 65) and (AssenzeAbilitate) then  //Se premo il tasto "A" cambio la pianificazione delle ASSENZE
    begin
      TastoPremuto:='';
      begin
        FastGiust:='A1';
        LblModificaRapida.Caption:='Modifica rapida ''PRIMA ASSENZA''';
      end;
    end
    else if (ssCtrl in Shift) and (Key = 79) then  //Se premo il tasto "O" cambio la pianificazione degli ORARI
    begin
      TastoPremuto:='';
      if FastGiust <> 'O' then
      begin
        FastGiust:='O';
        LblModificaRapida.Caption:='Modifica rapida ''ORARIO''';
      end;
    end
  end;
  *)
end;

procedure TA058FGrigliaPianif.Visualizzadebito1Click(Sender: TObject);
var i,j:Integer;
    NGiorni:Integer;
begin
  //Alberto (Pescara)
  with A058FPianifTurniDtm1, A058FPianifTurni do
  begin
    ConteggiaDebito:=not Visualizzadebito1.Checked;
    if not(Visualizzadebito1.Checked) then
    begin
      Screen.Cursor:=crHourGlass;
      NGiorni:=Trunc(DataFine - DataInizio);
      for i:=0 to Vista.Count - 1 do
      begin
        if not Vista[i].ConteggiSingoliGiorniAggiornati then
        begin
          for j:=0 to NGiorni do
            A058FPianifTurniDtM1.ConteggiGiornalieri(DataInizio + j,Vista[i],A058FPianifTurniDtm1.OffsetVista + j);
          DebitoDipendente(Vista[i],A058FPianifTurniDtm1.OffsetVista,A058FPianifTurniDtm1.OffsetVista + NGiorni);
        end;
      end;
      Screen.Cursor:=crDefault;
    end;
    if Visualizzadebito1.Checked then
      GVista.ColWidths[2]:=-1
    else
      GVista.ColWidths[2]:=110;
    Visualizzadebito1.Checked:=not Visualizzadebito1.Checked;
    bVisualizzaCompetenze:=Visualizzadebito1.Checked;
  end;
end;

procedure TA058FGrigliaPianif.Visualizzacolonnamatricola1Click(Sender: TObject);
begin
  if Visualizzacolonnamatricola1.Checked then
    GVista.ColWidths[0]:=67
  else
    GVista.ColWidths[0]:=-1;
  A058FPianifTurni.bVisualizzaMatricola:=Visualizzacolonnamatricola1.Checked;
end;

procedure TA058FGrigliaPianif.Visualizzacopertura1Click(Sender: TObject);
var nSgOp,iSgOp:Integer;
begin
  if Visualizzacopertura1.Checked then
    GVista.RowHeights[1]:=-1
  else
    with A058FPianifTurniDtm1 do
    begin
      nSgOp:=0;
      for iSgOp:=Low(TotTabGio) to High(TotTabGio) do
        if not TotTabGio[iSgOp].TotaleOperatore then
          inc(nSgOp);
      GVista.RowHeights[1]:=(nSgOp + 1) * (ALTEZZA_RIGA - 3) + 4;
    end;
  Visualizzacopertura1.Checked:=Not Visualizzacopertura1.Checked;
  A058FPianifTurni.bVisualizzaCopertura:=Visualizzacopertura1.Checked;
end;

procedure TA058FGrigliaPianif.VisualizzaCoperturaSquadre1Click(Sender: TObject);
var Ind:integer;
    ParData:TDateTime;
begin
  try
    Ind:=GVista.Col - nColonneBloccate + A058FPianifTurniDtm1.OffsetVista;
    //ParData:=StrToDate(GVista.Cells[GVista.Col,0]);
    ParData:=A058FPianifTurniDtM1.DataInizio + Ind;
    OpenA058CoperturaSquadra(Ind,ParData);
  except
    Abort;
  end;
end;

procedure TA058FGrigliaPianif.VisualizzaturniClick(Sender: TObject);
begin
  if Visualizzaturni.Checked then
    GVista.ColWidths[3]:=-1
  else
    GVista.ColWidths[3]:=45;
  Visualizzaturni.Checked:=not Visualizzaturni.Checked;
  A058FPianifTurni.bVisualizzaTurni:=Visualizzaturni.Checked;
end;

procedure TA058FGrigliaPianif.Visualizzazionesintetica1Click(Sender: TObject);
begin
  Visualizzazionesintetica1.Checked:=not Visualizzazionesintetica1.Checked;
  A058FPianifTurni.bVisualizzaSintetica:=Visualizzazionesintetica1.Checked;
  if A058FPianifTurniDtM1.selT530.RecordCount = 0 then
    if Not Visualizzazionesintetica1.Checked then
    begin
      GVista.DefaultColWidth:=80;
      GVista.Font.Size:=8;
    end
    else
    begin
      GVista.DefaultColWidth:=58;
      GVista.Font.Size:=8;
    end
  else
  begin
    GVista.DefaultColWidth:=100;
    GVista.Font.Size:=8;
  end;
  //Ridefinizione delle colonne nascoste, perchè dopo il ridimensionamento della larghezza di default
  //tornano a dimensione originale
  GVista.ColWidths[1]:=80;
  if Visualizzacolonnamatricola1.Checked then
    GVista.ColWidths[0]:=67
  else
    GVista.ColWidths[0]:=-1;
  if not Visualizzadebito1.Checked then
    GVista.ColWidths[2]:=-1
  else
    GVista.ColWidths[2]:=110;
  if not Visualizzaturni.Checked then
    GVista.ColWidths[3]:=-1
  else
    GVista.ColWidths[3]:=45;
  if not Visualizzaassenze.Checked then
    GVista.ColWidths[4]:=-1
  else
    GVista.ColWidths[4]:=110;
  if not VisualizzaRiposiFestivi.Checked then
    GVista.ColWidths[5]:=-1
  else
    GVista.ColWidths[5]:=95;
  if Sender <> nil then
    GVista.Repaint;
end;

procedure TA058FGrigliaPianif.ValidaCausale1Click(Sender: TObject);
var DataDa, DataA:TDateTime;
    Ind,PProg:Integer;
    Caus1, Caus2:String;
begin
  try
    PProg:=GVista.Row - nRigheBloccate;
    Ind:=GVista.Col - nColonneBloccate + A058FPianifTurniDtm1.OffsetVista;
    DataDa:=A058FPianifTurniDtM1.DataInizio + Ind;
    //DataDa:=StrToDate(GVista.Cells[GVista.Col,0]);
    DataA:=DataDa;
    if Ind >= 0 then
    begin
      Caus1:=A058FPianifTurniDtm1.Vista[PProg].Giorni[Ind].Ass1;
      Caus2:=A058FPianifTurniDtm1.Vista[PProg].Giorni[Ind].Ass2;
    end;
    if (A058FPianifTurniDtm1.Vista[PProg].Giorni[Ind].VAss = 'S') and
       (Ind >= 0) and (PProg >= 0) then
      OpenA058ValidaAssenze(PProg,DataDa,DataA,Caus1,Caus2);
    A058FPianifTurniDtM1.RefreshAssenze(A058FPianifTurniDtm1.DataInizio,A058FPianifTurniDtm1.DataFine);
    ImpostaAltezzaRiga(PProg);
    GVista.Repaint;
  except
    Abort;
  end;
end;

procedure TA058FGrigliaPianif.VisualizzaAssenze1Click(Sender: TObject);
begin
  A058FStampaAssenze:=TA058FStampaAssenze.Create(nil);
  try
    C001SettaQuickReport(A058FStampaAssenze.QRep);
    A058FPianifTurniDtM1.CreaTabStampaAss;
    A058FPianifTurniDtM1.CaricaTabStampaAss;
    A058FStampaAssenze.LEnte.Caption:=Parametri.RagioneSociale;
    A058FStampaAssenze.LTitolo.Caption:='Stampa assenze non validate';
    A058FStampaAssenze.QRep.Preview;
  finally
    A058FStampaAssenze.Free;
  end;
end;

procedure TA058FGrigliaPianif.Visualizzaassenzeadore1Click(Sender: TObject);
var
  i:Integer;
begin
  Visualizzaassenzeadore1.Checked:=not Visualizzaassenzeadore1.Checked;
  A058FPianifTurni.bVisualizzaAssenzeAdOre:=Visualizzaassenzeadore1.Checked;
  for i:=0 to A058FPianifTurniDtM1.Vista.Count - 1 do
    ImpostaAltezzaRiga(i);
  if Sender <> nil then
    GVista.Repaint;
end;

procedure TA058FGrigliaPianif.Visualizzaassenzemezzagiorn1Click(
  Sender: TObject);
var
  i:Integer;
begin
  Visualizzaassenzemezzagiorn1.Checked:=not Visualizzaassenzemezzagiorn1.Checked;
  A058FPianifTurni.bVisualizzaAssenzeMezzaGiornata:=Visualizzaassenzemezzagiorn1.Checked;
  for i:=0 to A058FPianifTurniDtM1.Vista.Count - 1 do
    ImpostaAltezzaRiga(i);
  if Sender <> nil then
    GVista.Repaint;
end;


procedure TA058FGrigliaPianif.VisualizzaassenzeClick(Sender: TObject);
begin
  if Visualizzaassenze.Checked then
    GVista.ColWidths[4]:=-1
  else
    GVista.ColWidths[4]:=110;
  Visualizzaassenze.Checked:=not Visualizzaassenze.Checked;
  A058FPianifTurni.bVisualizzaAssenze:=Visualizzaassenze.Checked;
end;

procedure TA058FGrigliaPianif.VisualizzaRiposiFestiviClick(Sender: TObject);
begin
  if VisualizzaRiposiFestivi.Checked then
    GVista.ColWidths[5]:=-1
  else
    GVista.ColWidths[5]:=95;
  VisualizzaRiposiFestivi.Checked:=not VisualizzaRiposiFestivi.Checked;
  A058FPianifTurni.bVisualizzaRiposiFestivi:=VisualizzaRiposiFestivi.Checked;
end;

procedure TA058FGrigliaPianif.CompetenzeResiduiassenza1Click(Sender: TObject);
{Visualizzazione Competenze/Residui della causale specificata}
var Data:TDateTime;
    i,j:Integer;
    Giustif:TGiustificativo;
    R600DtM1:TR600DtM1;
begin
  with A058FPianifTurniDtm1 do
  begin
    i:=GVista.Row - nRigheBloccate;
    j:=GVista.Col - nColonneBloccate + A058FPianifTurniDtm1.OffsetVista;
    if Vista[i].Giorni[j].Ass1 = '' then
    begin
      R180MessageBox('Nessun giustificativo di assenza trovato nel giorno corrente.',ESCLAMA);
      exit;
    end;
    Data:=A058FPianifTurniDtm1.DataInizio + j;
    Giustif.Modo:='I';
    Giustif.Causale:=Vista[i].Giorni[j].Ass1;//'FERIE';
    Giustif.DaOre:='';
    Giustif.AOre:='';
    R600DtM1:=TR600Dtm1.Create(Self);
    R600DtM1.VisualizzaAssenze(Vista[i].Prog,Data,Giustif);
    FreeAndNil(R600DtM1);
  end;
end;

procedure TA058FGrigliaPianif.CopiainExcel1Click(Sender: TObject);
var
  VistaInCSV:String;
begin
  Clipboard.Clear;
  VistaInCSV:=A058FPianifTurniDtM1.GetVistaInCSV(A058FPianifTurni.bVisualizzaSintetica);
  Clipboard.AsText:=VistaInCSV;
end;

procedure TA058FGrigliaPianif.Copiapianificazione1Click(Sender: TObject);
var i1,i2,i,k,OffSetCopia:Integer;
    D1,D2:TDateTime;
begin
  A058FCopiaPianificazione:=TA058FCopiaPianificazione.Create(nil);
  with A058FCopiaPianificazione, A058FPianifTurniDtm1 do
  try
    cdsAnagrafiche.Edit;
    cdsAnagrafiche.FieldByName('PROGRESSIVO1').AsInteger:=Vista[GVista.Row - nRigheBloccate].Prog;
    cdsAnagrafiche.FieldByName('PROGRESSIVO2').AsInteger:=Vista[GVista.Row - nRigheBloccate].Prog;
    cdsAnagrafiche.Post;
    DataI:=A058FPianifTurniDtm1.DataInizio;
    DataF:=A058FPianifTurniDtm1.DataFine;
    sedtOffsetCopiaChange(nil);
    if ShowModal = mrOK then
    begin
      i1:=-1;
      i2:=-1;
      D1:=DataI;
      D2:=DataF;
      OffSetCopia:=sedtOffsetCopia.Value;
      //Inizializzazione variabili di copia
      if chkRendiDefinitive.Checked then
        A058PCKT080TURNO.SetVariabiliCopiaTurnazione(cdsAnagrafiche.FieldByName('PROGRESSIVO1').AsInteger,
                                                     cdsAnagrafiche.FieldByName('PROGRESSIVO2').AsInteger,
                                                     D1,D2);
      for i:=0 to Vista.Count - 1 do
      begin
        if Vista[i].Prog = cdsAnagrafiche.FieldByName('PROGRESSIVO1').AsInteger then
          i1:=i;
        if Vista[i].Prog = cdsAnagrafiche.FieldByName('PROGRESSIVO2').AsInteger then
          i2:=i;
        if (i1 >= 0) and (i2 >= 0) then
          Break;
      end;
      if (i1 >= 0) and (i2 >= 0) then
      begin
        DatoModificato:=True;
        for i:=0 to Trunc(A058FPianifTurniDtm1.DataFine - A058FPianifTurniDtm1.DataInizio) do
        begin
          k:=i + OffSetCopia;
          if  (A058FPianifTurniDtm1.DataInizio + i >= D1)
          and (A058FPianifTurniDtm1.DataInizio + i <= D2)
          and (A058FPianifTurniDtm1.DataInizio + k >= A058FPianifTurniDtm1.DataInizio)
          and (A058FPianifTurniDtm1.DataInizio + k <= A058FPianifTurniDtm1.DataFine)
          then
          begin
            PreparaLeggiValoriCella(i2,k);
            Vista[i2].Giorni[k].T1:=Vista[i1].Giorni[i].T1;
            Vista[i2].Giorni[k].T2:=Vista[i1].Giorni[i].T2;
            Vista[i2].Giorni[k].SiglaT1:=Vista[i1].Giorni[i].SiglaT1;
            Vista[i2].Giorni[k].SiglaT2:=Vista[i1].Giorni[i].SiglaT2;
            Vista[i2].Giorni[k].NumTurno1:=Vista[i1].Giorni[i].NumTurno1;
            Vista[i2].Giorni[k].NumTurno2:=Vista[i1].Giorni[i].NumTurno2;
            Vista[i2].Giorni[k].T1EU:=Vista[i1].Giorni[i].T1EU;
            Vista[i2].Giorni[k].T2EU:=Vista[i1].Giorni[i].T2EU;
            Vista[i2].Giorni[k].Ora:=Vista[i1].Giorni[i].Ora;
            Vista[i2].Giorni[k].Antincendio:=Vista[i1].Giorni[i].Antincendio;
            Vista[i2].Giorni[k].Referente:=Vista[i1].Giorni[i].Referente;
            Vista[i2].Giorni[k].RichiestoDaTurnista:=Vista[i1].Giorni[i].RichiestoDaTurnista;
            Vista[i2].Giorni[k].Note:=Vista[i1].Giorni[i].Note;
            Vista[i2].Giorni[k].Modificato:=True;
            A058FPianifTurniDtM1.ConteggiGiornalieri(A058FPianifTurniDtm1.DataInizio + k,Vista[i2],k);
            DebitoDipendente(Vista[i2],0,Trunc(A058FPianifTurniDtm1.DataFine - A058FPianifTurniDtm1.DataInizio));
            AggiornaContatoriTurni(i2,k);
          end;
        end;
        ImpostaAltezzaRiga(i2);
        GVista.Repaint;
      end;
    end;
  finally
    Release;
  end;
end;

procedure TA058FGrigliaPianif.Visualizzadettaglioorariogiornaliero1Click(Sender: TObject);
begin
  if A058FDettaglioGiornata <> nil then
    exit;
  A058FDettaglioGiornata:=TA058FDettaglioGiornata.Create(nil);
  GVistaClick(nil);
  A058FDettaglioGiornata.Show;
end;

procedure TA058FGrigliaPianif.GVistaClick(Sender: TObject);
var i,j:Integer;
    O:String;
    D:TDateTime;
begin
  i:=GVista.Row - nRigheBloccate;
  j:=GVista.Col - nColonneBloccate + A058FPianifTurniDtm1.OffsetVista;
  D:=A058FPianifTurniDtm1.DataInizio + j;
  with A058FPianifTurniDtm1 do
  begin
    O:=Vista[i].Giorni[j].Ora;
    if A058FDettaglioGiornata <> nil then
    begin
      Q021.Filter:='CODICE = ''' + O + '''';
      Q021.Filtered:=True;
      RefreshQ021(D);
      begin
        if O <> '' then
          A058FDettaglioGiornata.Caption:='Dettaglio orario ''' + O + ''''
        else
          A058FDettaglioGiornata.Caption:='Nessun orario pianificato';
      end;
    end;
  end;
end;

procedure TA058FGrigliaPianif.FormShow(Sender: TObject);
var
  bCanSelect,abilitaBlocca,abilitaSblocca:boolean;
begin
  //Nascosto per ristrutturazione pianificazione turni. Se nessuno lo reclama, eliminare
  VisualizzaAssenze1.Visible:=False;
  ValidaCausale1.Visible:=False;
  Visualizzadettaglioorariogiornaliero1.Visible:=False;
  VisualizzaLimitiMinMax1.Visible:=False;
  VisualizzaCoperturaSquadre1.Visible:=False;
  //Nascosto per ristrutturazione pianificazione turni. Se nessuno lo reclama, eliminare

  A058FPianifTurniDtM1.procProgressBarInizio:=procProgressBarInizio;
  A058FPianifTurniDtM1.procProgressBarNext:=procProgressBarNext;
  A058FPianifTurniDtM1.procProgressBarFine:=procProgressBarFine;
  bCanSelect:=True;
  btnFiltroAnomalie.ShowHint:=True;
  btnFiltroAnomalie.Hint:=Format('Elenco anomalie attive: %s %s',[#13#10,A058FPianifTurniDtM1.Vista.PropElencoAnomalie.GetAnomalieAttive]);
  Visualizzacolonnamatricola1.Checked:=A058FPianifTurni.bVisualizzaMatricola;
  GVistaSelectCell(nil,nColonneBloccate,nRigheBloccate,bCanSelect);
  A058FPianifTurniDtM1.AbilitaBloccaSblocca(abilitaBlocca,abilitaSblocca);
  btnBlocca1.Enabled:=AbilitazioneA126 and abilitaBlocca;
  btnSblocca1.Enabled:=AbilitazioneA126 and abilitaSblocca;
  if A058FPianifTurni.bVisualizzaCopertura then
    Visualizzacopertura1Click(nil);
  if A058FPianifTurni.bVisualizzaCompetenze then
    Visualizzadebito1Click(nil);
  if A058FPianifTurni.bVisualizzaTurni then
    VisualizzaturniClick(nil);
  if A058FPianifTurni.bVisualizzaRiposiFestivi then
    VisualizzaRiposiFestiviClick(nil);
  if A058FPianifTurni.bVisualizzaMatricola then
    Visualizzacolonnamatricola1Click(nil);
  if A058FPianifTurni.bVisualizzaSintetica then
    Visualizzazionesintetica1Click(nil);
  if A058FPianifTurni.bVisualizzaAssenzeMezzaGiornata then
    Visualizzaassenzemezzagiorn1Click(nil);
  if A058FPianifTurni.bVisualizzaAssenzeAdOre then
    Visualizzaassenzeadore1Click(nil);
  // Chiamando i metodi sopra passando nil non effettuo al loro interno il refresh della griglia.
  GVista.Repaint;
end;

procedure TA058FGrigliaPianif.GVistaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if FastGiust = '' then
    exit;
  PreparaLeggiValoriCella;
end;

procedure TA058FGrigliaPianif.PreparaLeggiValoriCella(iDipendente:Integer = -1;iGiorno:Integer = -1);
begin
  if (iDipendente = -1) or (iGiorno = -1) then
  begin
    iDipendente:=GVista.Row - nRigheBloccate;
    iGiorno:=GVista.Col - nColonneBloccate + A058FPianifTurniDtm1.OffsetVista;
  end;
  A058FPianifTurniDtm1.LeggiValoriCella(iDipendente,iGiorno);
end;

procedure TA058FGrigliaPianif.VisualizzaLimitiMinMax1Click(Sender: TObject);
var Ind:Integer;
begin
  if A058FDettaglioTipiOperatori <> nil then
    exit;
  A058FDettaglioTipiOperatori:=TA058FDettaglioTipiOperatori.Create(nil);
  Ind:=GVista.Col - nColonneBloccate + A058FPianifTurniDtm1.OffsetVista;
  A058FDettaglioTipiOperatori.DataRif:=A058FPianifTurniDtM1.DataInizio + Ind;
  A058FDettaglioTipiOperatori.Show;
end;

procedure TA058FGrigliaPianif.Visualizzaprogressividiturnazione1Click(Sender: TObject);
var Ind:integer;
    ParData:TDateTime;
begin
  try
    GVistaClick(nil);
    Ind:=GVista.Col - nColonneBloccate + A058FPianifTurniDtm1.OffsetVista;
    ParData:=A058FPianifTurniDtM1.DataInizio + Ind;
    Screen.Cursor:=crHourGlass;
    try
      A058FPianifTurniDtM1.EstraiTurnazioni(ParData);
    finally
      Screen.Cursor:=crDefault;
    end;
    OpenC020VisualizzaDataSet('Turnazioni riconosciute al ' + DateToStr(ParData), A058FPianifTurniDtM1.cdsT611, 660, 440);
  finally
    A058FPianifTurniDtM1.cdsT611.EmptyDataSet;
    A058FPianifTurniDtM1.cdsT611.Close;
  end;
end;

procedure TA058FGrigliaPianif.FormKeyPress(Sender: TObject; var Key: Char);
begin
  //ESC funziona solo se ho cliccato su Verifica Turni
  if (Key = #27) and (not Self.Enabled) then
    if MessageDlg('Interrompere l''elaborazione?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
      A058FPianifTurniDtM1.ElaborazioneInterrotta:=True;
end;

procedure TA058FGrigliaPianif.ImpostaAltezzaRiga(iDip:Integer);
var
  CellaUI:TCellaUI;
  j,h,iOpDip,iSgOp,nSgOp:Integer;
  CellaUIOpzioni:TGetCellaUIOpzioni;
begin
  // Imposto l'altezza della riga della copertura dei turni in base al numero di sigle del tabellone
  if Visualizzacopertura1.Checked then
  begin
    nSgOp:=0;
    with A058FPianifTurniDtm1 do
    begin
      for iSgOp:=Low(TotTabGio) to High(TotTabGio) do
        if not TotTabGio[iSgOp].TotaleOperatore then
          inc(nSgOp);
    end;
    GVista.RowHeights[1]:=(nSgOp + 1) * (ALTEZZA_RIGA - 3) + 4;
  end;
  // Imposto l'altezza di default della riga del dipendente
  GVista.RowHeights[iDip + nRigheBloccate]:=GVista.DefaultRowHeight;
  // Imposto l'altezza della riga in base al numero di sigle per il dipendente
  h:=0;
  for iOpDip:=Low(A058FPianifTurniDtm1.Vista[iDip].TotDip.Operatori) to High(A058FPianifTurniDtm1.Vista[iDip].TotDip.Operatori) do
    h:=h + (ALTEZZA_RIGA - 4) * Length(A058FPianifTurniDtm1.Vista[iDip].TotDip.Operatori[iOpDip].Sigle);
  if (h > GVista.RowHeights[iDip + nRigheBloccate]) then
    GVista.RowHeights[iDip + nRigheBloccate]:=h;
  // Imposto l'altezza della riga in base al numero di righe nella cella
  CellaUIOpzioni:=[];
  if A058FPianifTurni.bVisualizzaAssenzeMezzaGiornata then Include(CellaUIOpzioni, coIncludiAssMezzGior);
  if A058FPianifTurni.bVisualizzaAssenzeAdOre then Include(CellaUIOpzioni, coIncludiAssOrarie);
  for j:=0 to A058FPianifTurniDtm1.Vista[iDip].Giorni.Count - 1 do
  begin
    CellaUI:=A058FPianifTurniDtm1.GetCellaUI(iDip,j,CellaUIOpzioni);
    h:=ALTEZZA_RIGA * CellaUI.NumRigheElementiWin;
    FreeAndNil(CellaUI);
    if (h > GVista.RowHeights[iDip + nRigheBloccate]) then
      GVista.RowHeights[iDip + nRigheBloccate]:=h;
  end;
end;

end.


