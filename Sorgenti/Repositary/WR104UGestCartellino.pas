unit WR104UGestCartellino;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR100UBase, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompGrids, meIWGrid, medpIWStatusBar,
  meIWImageFile, IWCompButton, meIWButton, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, meIWEdit,
  A000UCostanti,A000USessione, R500Lin, StrUtils, C180FunzioniGenerali,
  System.Actions, Vcl.ActnList, IWCompEdit, A000UInterfaccia, A000UMessaggi,
  medpIWMEssageDlg, IWApplication, C190FunzioniGeneraliWeb,WC010UMemoEditFM,
  IWCompLabel, meIWLabel,WC024ULegendaFM, OracleData, Vcl.Menus, Data.DB;

type
  TprocSender = procedure(Sender: TObject) of object;

  TGiorniCartellino = record
    Data:TDateTime;
    NonImpostato:Boolean;
    Lavorativo:Boolean;
    Festivo:Boolean;
    Domenica:Boolean;
  end;

  TWR104FGestCartellino = class(TWR100FBase)
    grdComandi: TmeIWGrid;
    actLstComandi: TActionList;
    actMesePrec: TAction;
    edtMese: TmeIWEdit;
    actMese: TAction;
    actMeseSucc: TAction;
    actConteggi: TAction;
    actAnomalie: TAction;
    lblCartellinoCaption: TmeIWLabel;
    lnkLegenda: TmeIWLink;
    grdCartellino: TmeIWGrid;
    pmnNuovaTimbratura: TPopupMenu;
    pmnTimbratura: TPopupMenu;
    btnModificaTimb: TmeIWButton;
    btnNuovaTimb: TmeIWButton;
    pmnNuovoGiustificativo: TPopupMenu;
    pmnGiustificativo: TPopupMenu;
    btnModificaGiust: TmeIWButton;
    btnNuovoGiust: TmeIWButton;
    btnVisualizza: TmeIWButton;
    procedure actMesePrecExecute(Sender: TObject);
    procedure edtMeseAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure IWAppFormCreate(Sender: TObject);
    procedure actMeseSuccExecute(Sender: TObject);
    procedure actConteggiExecute(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure actAnomalieExecute(Sender: TObject);
    procedure lnkLegendaClick(Sender: TObject);
    procedure grdCartellinoRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure btnModificaTimbClick(Sender: TObject);
    procedure btnNuovaTimbClick(Sender: TObject);
    procedure btnModificaGiustClick(Sender: TObject);
    procedure btnNuovoGiustClick(Sender: TObject);
    procedure btnVisualizzaClick(Sender: TObject);
  private
    procedure imgComandiClick(Sender: TObject);
    procedure lnkCausaleClick(Sender: TObject);
    function DescrizioneCausale(Causale: String): String;
    procedure edtTimbraturaAsyncDoubleClick(Sender: TObject;
      EventParams: TStringList);
    procedure CreaToolbarComandi(actlst: TActionList; grdToolbar: TmeIWGrid;_onClick: TProcSender);
    procedure CambiaMese(bSuccessivo: Boolean);
    procedure LnkRilevatoreClick(Sender: TObject);
    procedure ImpostaEditTimbratura(var edt: TmeIWEdit;Timbratura: TTimbrature; day, nTimb: Integer);
    procedure ImpostaGrdTimbratureGiorno(var grd: TmeIWGrid;var NumTimbrature: Integer; day:Integer);
    function NomeGiorni(Data: TDateTime): String;
    procedure ImpostaGrdGiustifiviGiorno(var grd: TmeIWGrid;
      var NumGiustificativi: Integer; day: Integer);
    procedure ImpostaEditGiustificativo(var edt: TmeIWEdit;
      Giustificativo: TGiustificativi; day, nGiust: Integer);
    function FormGiustWeb(Giustificativo: TGiustificativi): String;
    function ColoreGiustif(Tipo: String): String;
    procedure edtGiustificativoAsyncDoubleClick(Sender: TObject;
      EventParams: TStringList);
  protected
    Cartellino: Array of TGiorniCartellino;
    NumeroElemento: Integer;
    DataCorr,
    DataOperazione: TDateTime;
    TimbXRow: Integer;
    GiustXRow: Integer;
    LstAnomalie: TStringList;
    bCanNuovaTimbratura,
    bCanNuovoGiustificativo,
    bCanCancellaTimbratura: Boolean;
    function EstraiColonnaElemento(Nome, Prefisso: String): Integer;
    function  CssSfondoGiorno(giorno: TGiorniCartellino): String;
    procedure ImpostaLinkGiorno(var lnkGiorno: TmeIWLink; giorno: TGiorniCartellino);
    function ColoreCausale(Causale, Validata, Tipo: String): String;
    procedure CreaGrdGiustificativi(day, c: Integer);
    procedure CreaGrdTimbrature(day, c: Integer);
    procedure AttivaConteggi; virtual; abstract;
    procedure ApriGestTimb(Modifica: Boolean); virtual; abstract;
    procedure ApriGestGiust(Modifica: Boolean); virtual; abstract;
    procedure ImpostaLinkRilevatore(var lnk: TmeIWLink; Rilevatore:String);
    procedure ImpostaLinkCausale(var lnk: TmeIWLink; edtTimbratura: TmeIWEdit; Causale: String);
  public
    QRilevatori,
    QCausAss,
    QCausPres,
    QCausGiust:TOracleDataset; //usati per decodifiche e WR208FGestTimb
    DsrTimbrature: TDataSource; //usato da WR208FGestTimb
    procedure CaricaCartellino; virtual; abstract;
    procedure CaricaGrid; virtual; abstract;
    function getTimbratura(day,i:Integer):TTimbrature;virtual; abstract;
    function getNumeroTimbrature(day:Integer):Byte ;virtual; abstract;
    function getGustificativo(day,i:Integer):TGiustificativi;virtual; abstract;
    function getNumeroGiustificativi(day:Integer):Byte ;virtual; abstract;
  end;

  const
    NOMETIMBR: String = 'Timbr';
    NOMEGIUST: String = 'Giust';
    NOMEDAY: String = 'day';

implementation

{$R *.dfm}

procedure TWR104FGestCartellino.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  AddScrollBarManager('divscrollable');
  LstAnomalie:=TStringList.Create;
  CreaToolbarComandi(actlstComandi,grdComandi,imgComandiClick);
  TimbXRow:=6;
  GiustXRow:=2;
end;

function TWR104FGestCartellino.FormGiustWeb(Giustificativo: TGiustificativi):String;
{Costruisco descrizione giustificativo per web
 giornata e mezza giornata indicati da sfondo e non riportati nel testo}
var Tipo:Char;
begin
  Result:=Giustificativo.Causale;
  Tipo:=R180CarattereDef(Giustificativo.Tipo,1,#0);
  case Tipo of
    'M':begin
        if Giustificativo.DaOre <> 0 then
          Result:=Result + ' ' + FormatDateTime('hh:mm',Giustificativo.DaOre) ;
        end;
    'N':Result:=Result + ' ' + FormatDateTime('hh:mm',Giustificativo.DaOre);
    'D':Result:=Result + ' ' + FormatDateTime('hh:mm',Giustificativo.DaOre)+
        '-' +FormatDateTime('hh:mm',Giustificativo.AOre);
  end;
end;

function TWR104FGestCartellino.ColoreGiustif(Tipo: String): String;
begin
  Result:='';
  if Tipo = 'I' then Result:='giustifGiorn';
  if Tipo = 'M' then Result:='giustifMezzaG';
end;

procedure TWR104FGestCartellino.ImpostaEditGiustificativo(var edt: TmeIWEdit;Giustificativo: TGiustificativi; day, nGiust: Integer);
begin
  with edt do
  begin
    FriendlyName:=NOMEGIUST + IntToStr(nGiust) + NOMEDAY + IntToStr(day);
    Name:=FriendlyName;
    Tag:=day;
    Text:=FormGiustWeb(Giustificativo); {Costruisco la descrizione del giustificativo}
    Css:='width15chr ' + ColoreGiustif(Giustificativo.Tipo) + ' ' +
    ColoreCausale(Trim(Giustificativo.Causale), Giustificativo.Validata,Giustificativo.Tipo);
    ReadOnly:=True;
    if pmnGiustificativo.Items.count > 0 then
    begin
      medpContextMenu:=pmnGiustificativo;
      OnAsyncDoubleClick:=edtGiustificativoAsyncDoubleClick;
    end;
    //note le metto come hint
    Hint:='';
    if Giustificativo.Note <> '' then
      Hint:=Hint + '[' + Giustificativo.Note + ']';
    if Giustificativo.NuovoPeriodo and
       R180In(VarToStr(QCausAss.Lookup('CODICE',Giustificativo.Causale,'TIPOCUMULO')),['I','O']) then
      Hint:=Hint + '(np)';
  end;
end;

procedure TWR104FGestCartellino.ImpostaGrdGiustifiviGiorno (var grd: TmeIWGrid; var NumGiustificativi: Integer;day:Integer);
var
  ng: Integer;
begin
  with grd do
  begin
    Css:='gridComandi';
    FriendlyName:='ListaGiustificativi' + IntToStr(day);
    Name:=FriendlyName;
    if MaxGiustif  < NumGiustificativi then
      NumGiustificativi:=MaxGiustif;
      //calcolo colonne: 2 giustificativi per riga + 2 componenti(edit per nuovo giustificativo e cella vuota per allineamento)
      ng:=NumGiustificativi;
      if ng > GIUSTXROW then
        ng:=GIUSTXROW;

      ColumnCount:=ng + 1; //+ 1 per elemento vuoto di allineamento
      if bCanNuovoGiustificativo then
        ColumnCount:=ColumnCount + 1; //elemento per nuovo giustificativo
      //una riga sempre presente. poi si aggiungono righe in base al numero di giustificativi
      RowCount:=1 + ((NumGiustificativi - 1) div GIUSTXROW );
  end;
end;

procedure TWR104FGestCartellino.CreaGrdGiustificativi(day,c:Integer);
var
  grdGiustificativiGiorno: TmeIWGrid;
  NumGiustificativi,
  colControl,
  rowControl,
  j: Integer;
  Giustificativo: TGiustificativi;
  tmpEdt: TmeIWEdit;
begin
  grdCartellino.Cell[day,c].css:='riga_bianca';
  if (getNumeroGiustificativi(day) > 0) or (bCanNuovoGiustificativo) then
  begin
    grdGiustificativiGiorno:=TmeIWGrid.Create(Self);
    grdCartellino.Cell[day,c].Control:=grdGiustificativiGiorno;
    NumGiustificativi:=getNumeroGiustificativi(day);
    ImpostaGrdGiustifiviGiorno(grdGiustificativiGiorno,NumGiustificativi,day);

    colControl:=0;
    rowControl:=0;
    for j:=0 to NumGiustificativi - 1 do
    begin
      Giustificativo:=getGustificativo(day,j + 1);
      // componente edit per giustificativo
      with grdGiustificativiGiorno.Cell[rowControl,colControl] do
      begin
        tmpEdt:=TmeIWEdit.Create(Self);
        Control:=tmpEdt;
        Css:='width15chr';
      end;
        ImpostaEditGiustificativo(tmpEdt,Giustificativo,day, j+1);
        inc(colControl);
        //se non sono sull'ultima riga, le ultine celle (per inserimento e vuota per allineamento non vengono considerate
        if (rowControl < grdGiustificativiGiorno.rowCount - 1 ) and (colControl > GIUSTXROW - 1) then
        begin
          colControl:=0;
          inc(rowControl);
        end;
      end;
      if bCanNuovoGiustificativo then
      begin
        //Componente edit per nuovo giustif
        with grdGiustificativiGiorno.Cell[rowControl,colControl] do
        begin
          Control:=TmeIWEdit.Create(Self);
          Css:='width3chr';
        end;
        with (grdGiustificativiGiorno.Cell[rowControl,colControl].Control as TmeIWEdit) do
        begin
          FriendlyName:=NOMEGIUST + IntToStr(NumGiustificativi + 1) + NOMEDAY + IntToStr(day);
          Name:=FriendlyName;
          Tag:=day;
          Text:='';
          Css:='width3chr';
          Hint:='Nuovo giustificativo';
          ReadOnly:=True;
          if pmnNuovoGiustificativo.Items.count > 0 then
          begin
            medpContextMenu:=pmnNuovoGiustificativo;
            onAsyncDoubleClick:=edtGiustificativoAsyncDoubleClick;
          end;
          RenderSize:=False;
          Font.Enabled:=False;
        end;
      end;
    end;
end;

//il nome contiene l'indice della timbratura/giustificativo del giorno
function TWR104FGestCartellino.EstraiColonnaElemento(Nome,Prefisso: String): Integer;
var p,p2: Integer;
begin
  p:=length(Prefisso) + 1;
  p2:=Pos(NOMEDAY,Nome);
  Result:=StrToInt(copy(Nome,p,p2-p));
end;

function TWR104FGestCartellino.DescrizioneCausale(Causale:String): String;
begin
  Result:='';
  if QCausAss.Locate('Codice',Causale,[]) then
    Result:=QCausAss.FieldByName('Descrizione').AsString
  else if QCausPres.Locate('Codice',Causale,[]) then
    Result:=QCausPres.FieldByName('Descrizione').AsString
  else if QCausGiust.Locate('Codice',Causale,[]) then
    Result:=QCausGiust.FieldByName('Descrizione').AsString
end;

function TWR104FGestCartellino.ColoreCausale(Causale, Validata,Tipo:String):String;
{Rosso = Assenza; Verde = Presenza; Blu = Giustificativo; clAqua = Ass.Validata}
begin
  Result:='fontGray';

  if QCausAss.Locate('Codice',Causale,[]) then //Q265
  begin
    if Validata = 'N' then
      Result:='fontAcqua'
    else
      if (Tipo = 'I') or (Tipo = 'M') then //in caso di assenza giornata o mezza giornata lo sfondo è rosso. cambio il font in nero
        Result:='fontBlack'
      else
        Result:='fontRed';
   end
   else if QCausPres.Locate('Codice',Causale,[]) then Result:='fontGreen'   //Q275
   else if QCausGiust.Locate('Codice',Causale,[]) then Result:='fontBlu'; //Q305
end;

procedure TWR104FGestCartellino.lnkCausaleClick(Sender: TObject);
var Params: String;
    Tag: Integer;
begin
  Tag:=(Sender as TmeIWLink).Tag;
  Params:='CODICE=' + (Sender as TmeIWLink).Caption;
  //se causale di presenza aprro WA020 altrimenti WA021
  AccediForm(Tag,Params,False)
end;

procedure TWR104FGestCartellino.ImpostaLinkCausale(var lnk: TmeIWLink; edtTimbratura: TmeIWEdit; Causale:String);
var
  tmpTag: String;
begin
  with lnk do
  begin
    Css:='font11';
    Text:=Causale;
    //per accessi mensa * indica senza causale
    if Text = '*' then
      Text:='';

    if Text = '' then
    begin
      Text:='--';
      Hint:='Causale';
    end
    else
    begin
      Css:=Css + ' ' + ColoreCausale(Causale, '','');
      Hint:=DescrizioneCausale(Causale);
      //imposto hint anche su edit orario
      if edtTimbratura <> nil then
        edtTimbratura.Hint:=Hint;

      //caratto 18/03/2014 Utente: MONDOEDP Chiamata: 82153 link solo se abilitato
      if QCausPres.Locate('Codice',Text,[]) then
        tmpTag:='107'
      else
        tmpTag:='109';
      //usato su click del link per accedi
      lnk.Tag:=tmpTag.toInteger;
      if A000GetInibizioni('Tag',tmpTag) <> 'N'  then
        OnClick:=lnkCausaleClick;
    end;
  end;
end;

procedure TWR104FGestCartellino.ImpostaLinkRilevatore(var lnk: TmeIWLink;Rilevatore:String);
begin
  with lnk do
  begin
    Text:=Trim(Rilevatore);
    if Text = '' then
    begin
      Text:='--';
      Hint:='';
    end
    else
    begin
      QRilevatori.SearchRecord('CODICE',Trim(Rilevatore),[srFromBeginning]);
      Hint:=QRilevatori.FieldByName('DESCRIZIONE').AsString;
      //caratto 18/03/2014 Utente: MONDOEDP Chiamata: 82153 link solo se abilitato
      if A000GetInibizioni('Tag','124') <> 'N'  then
        OnClick:=lnkRilevatoreClick;
    end;
    Css:='font11';
  end;
end;

procedure TWR104FGestCartellino.IWAppFormDestroy(Sender: TObject);
begin
  FreeAndNil(LstAnomalie);
  inherited;
end;

procedure TWR104FGestCartellino.lnkLegendaClick(Sender: TObject);
var WA024FLegendaFM: TWC024FLegendaFM;
begin
  inherited;
  WA024FLegendaFM:=TWC024FLegendaFM.Create(Self);
  WA024FLegendaFM.Visualizza;
end;

procedure TWR104FGestCartellino.imgComandiClick(Sender: TObject);
begin
  MessaggioStatus(INFORMA,'');
  TAction(actlstComandi.Actions[TmeIWImageFile(Sender).Tag]).Execute;
end;

procedure TWR104FGestCartellino.lnkRilevatoreClick(Sender: TObject);
var Params : String;
begin
  Params:='CODICE=' + (Sender as TmeIWLink).Text;
  AccediForm(124,Params,False);
end;

procedure TWR104FGestCartellino.ImpostaGrdTimbratureGiorno (var grd: TmeIWGrid; var NumTimbrature: Integer;day:Integer);
var
  nt: Integer;
begin
  with grd do
  begin
    Css:='gridComandi';
    FriendlyName:='ListaTimbrature' + IntToStr(day);
    Name:=FriendlyName;

    if MaxTimbrature  < NumTimbrature then
      NumTimbrature:=MaxTimbrature;
    //calcolo colonne: massimo TIMBXROW timbrature per riga + 2 componenti(edit per nuova timbratura e cella vuota per allineamento)
    nt:=NumTimbrature;
    if nt > TimbXRow then
      nt:=TimbXRow;

    //Ogni timbratura ha 3 elementi (ora, rilevatore e causale) e una cella finale per allineamento a sx
    ColumnCount:=(nt * 3) + 1;
    //La cella nuova timbratura ha solo 1 edit
    if bCanNuovaTimbratura then
      ColumnCount:=ColumnCount + 1;
    //una riga sempre presente. poi si aggiungono righe in base al numero di giustificativi
    RowCount:=1 + ((NumTimbrature - 1) div TIMBXROW );
  end;
end;

function TWR104FGestCartellino.NomeGiorni(Data: TDateTime): String;
begin
  case DayOfWeek(Data) of
    1:Result:='Dom';
    2:Result:='Lun';
    3:Result:='Mar';
    4:Result:='Mer';
    5:Result:='Gio';
    6:Result:='Ven';
    7:Result:='Sab';
  end;
end;

procedure TWR104FGestCartellino.ImpostaEditTimbratura(var edt:TmeIWEdit; Timbratura: TTimbrature;day,nTimb:Integer);
begin
  with edt do
  begin
    //metto nel name il numero della timbratura. serve quando si va in modifica per sapere la timbratura da modificare
    FriendlyName:=NOMETIMBR + IntToStr(nTimb) + NOMEDAY + IntToStr(day);
    Name:=FriendlyName;
    Tag:=day;
    Text:=FormatDateTime('hh:mm',Timbratura.Ora);
    ReadOnly:=True;
    Css:='width3chr font11' + ' ' + IfThen(Timbratura.Verso = 'E','bg_lime','bg_aqua');

    if Timbratura.Flag = 'O' then
      Css:=Css + ' ' + 'font_rosso'; // timb. originale
    RenderSize:=False;
    Font.Enabled:=False;
    edt.onAsyncDoubleClick:=edtTimbraturaAsyncDoubleClick;
    if pmnTimbratura.Items.Count > 0  then
      edt.medpContextMenu:=pmnTimbratura;
  end;
end;

procedure TWR104FGestCartellino.actMeseSuccExecute(Sender: TObject);
begin
  inherited;
  CambiaMese(True);
end;

procedure TWR104FGestCartellino.btnModificaGiustClick(Sender: TObject);
begin
  ApriGestGiust(True);
end;

procedure TWR104FGestCartellino.btnModificaTimbClick(Sender: TObject);
begin
  ApriGestTimb(True);
end;

procedure TWR104FGestCartellino.btnNuovaTimbClick(Sender: TObject);
begin
  ApriGestTimb(False);
end;

procedure TWR104FGestCartellino.btnNuovoGiustClick(Sender: TObject);
begin
  inherited;
  ApriGestGiust(False);
end;

procedure TWR104FGestCartellino.btnVisualizzaClick(Sender: TObject);
begin
  if TryStrToDate('01/'+edtMese.Text,DataCorr) then
    CaricaCartellino
  else
    MsgBox.WebMessageDlg(A000MSG_ERR_DATA_ERRATA,mtError,[mbOk],nil,'');
end;

procedure TWR104FGestCartellino.CambiaMese(bSuccessivo: Boolean);
begin
  if TryStrToDate('01/'+edtMese.Text,DataCorr) then
  begin
    if bSuccessivo then
      DataCorr:=R180AddMesi(DataCorr,1)
    else
      DataCorr:=R180AddMesi(DataCorr,-1);
    edtMese.Text:=FormatDateTime('mm/yyyy',DataCorr);
    CaricaCartellino;
  end;
end;

procedure TWR104FGestCartellino.actAnomalieExecute(Sender: TObject);
var i:Word;
    WC010FMemoEditFM: TWC010FMemoEditFM;
begin

  WC010FMemoEditFM:=TWC010FMemoEditFM.Create(Self);

  if LstAnomalie.Count > 0 then
  begin
    WC010FMemoEditFM.memValore.Lines.Clear;
    for I:=0 to LstAnomalie.Count - 1 do
      WC010FMemoEditFM.memValore.Lines.Add(LstAnomalie[i]);
  end;
  WC010FMemoEditFM.Width:=600;
  WC010FMemoEditFM.Height:=350;
  WC010FMemoEditFM.Visualizza('Anomalie');
end;

procedure TWR104FGestCartellino.actConteggiExecute(Sender: TObject);
begin
  inherited;
  ActConteggi.Checked:=not ActConteggi.Checked;

  if ActConteggi.Checked then
  begin
    //Apro le tabelle dei conteggi estraendo i dati del mese su cui sono posizionato
    ActConteggi.Hint:='Conteggi on';
    AttivaConteggi;
  end
  else
    //Chiudo i conteggi
    Hint:='Conteggi off';
  LstAnomalie.Clear;

  if Length(Cartellino) > 0 then
    CaricaGrid;
  AggiornaToolBar(grdComandi,actlstComandi);
end;

procedure TWR104FGestCartellino.actMesePrecExecute(Sender: TObject);
begin
  inherited;
  CambiaMese(False);
end;

function TWR104FGestCartellino.cssSfondoGiorno(giorno: TGiorniCartellino): String;
begin
  Result:='widht5chr';
  if (not giorno.NonImpostato) then
  begin
    if giorno.Festivo and (not giorno.Lavorativo) then
      Result:=Result + ' bg_aqua'
    else if giorno.Festivo then
      Result:=Result + ' bg_giallo'
    else if (not giorno.Lavorativo) then
      Result:=Result + ' bg_lime';
  end;
end;

procedure TWR104FGestCartellino.edtMeseAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  //Devo forzare un submit perchè la griglia non si carica in async
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[btnVisualizza.HTMLName]));
end;

procedure TWR104FGestCartellino.grdCartellinoRenderCell(ACell: TIWGridCell;
  const ARow, AColumn: Integer);
begin
  inherited;
  C190RenderCell(ACell,ARow,AColumn,True,False,True);
end;

procedure TWR104FGestCartellino.CreaToolbarComandi(actlst: TActionList; grdToolbar: TmeIWGrid; _onClick: TProcSender);
var
  i, k:Integer;
  PrecCategory: String;
begin
  grdToolbar.RowCount:=1;
  grdToolbar.ColumnCount:=actlst.ActionCount;

  if actlst.ActionCount > 0 then
    PrecCategory:=TAction(actlst.Actions[0]).Category;

  k:=0;
  for i:=0 to actlst.ActionCount - 1 do
  begin
    if PrecCategory <> TAction(actlst.Actions[i]).Category  then
    begin
      grdToolbar.Cell[0,k].Css:='x';
      grdToolbar.Cell[0,k].Text:='';
      k:=k + 1;
      grdToolbar.ColumnCount:=grdToolbar.ColumnCount + 1;
      PrecCategory:=TAction(actlst.Actions[i]).Category;
    end;

    if (actlst.Actions[i] as TAction).Name = 'actMese' then
    begin
      grdToolbar.Cell[0,k].Css:='x';
      grdToolbar.Cell[0,k].Control:=edtMese;
    end
    else
    begin
      grdToolbar.Cell[0,k].Control:=TmeIWImageFile.Create(Self);
      with TmeIWImageFile(grdToolbar.Cell[0,k].Control) do
      begin
        Name:=C190CreaNomeComponente(TAction(actlst.Actions[i]).Name,Self);
        OnClick:=_onClick;
        Tag:=i;
      end;

      grdToolbar.Cell[0,k].Css:='x';
      grdToolbar.Cell[0,k].Text:='';
    end;
    k:=k + 1;
  end;
  AggiornaToolBar(grdToolbar,actlst);
end;

procedure TWR104FGestCartellino.ImpostaLinkGiorno(var lnkGiorno:TmeIWLink; giorno:TGiorniCartellino);
begin
  lnkGiorno.Css:='giornoCartellino ' + IfThen(giorno.Domenica,'font_rosso','comandi');
  lnkGiorno.Text:=NomeGiorni(giorno.Data) + ' ' + FormatDateTime('dd',giorno.Data);
  lnkGiorno.ShowHint:=False;
  lnkGiorno.Tag:=R180Giorno(giorno.Data);
end;

procedure TWR104FGestCartellino.CreaGrdTimbrature(day,c: Integer);
var
  NumTimbrature,
  colControl,
  rowControl,
  j: Integer;
  Timbratura: TTimbrature;
  tmpEdt: TmeIWEdit;
  tmpLnk: TmeIWLink;
  grdTimbratureGiorno: TmeIWGrid;
begin
  //Timbrature
  NumTimbrature:=0;
  grdCartellino.Cell[day,c].css:='riga_bianca';
  if (getNumeroTimbrature(day) > 0) or (bCanNuovaTimbratura) then
  begin
    grdTimbratureGiorno:=TmeIWGrid.Create(Self);
    grdCartellino.Cell[day,c].Control:=grdTimbratureGiorno;
    NumTimbrature:=getNumeroTimbrature(day);
    //Imposta grid che contiene le timbrature
    ImpostaGrdTimbratureGiorno (grdTimbratureGiorno,
                                NumTimbrature,      //NumTImbrature var
                                day);
    // timbrature
    colControl:=0;
    rowControl:=0;
    for j:=0 to NumTimbrature - 1 do
    begin
      Timbratura:=getTimbratura(day,j + 1);
      // componente edit per ora timbratura
      with grdTimbratureGiorno.Cell[rowControl,colControl] do
      begin
        tmpEdt:=TmeIWEdit.Create(Self);
        Control:=tmpEdt;
        Css:='width3chr';
      end;
      ImpostaEditTimbratura(tmpEdt, Timbratura,day,j+1);
      inc(ColControl);

      //componente label per rilevatore
      with grdTimbratureGiorno.Cell[rowControl,colControl] do
      begin
        tmpLnk:=TmeIWLink.Create(Self);
        Control:=tmpLnk;
        Css:='cellaRil';
      end;
      ImpostaLinkRilevatore(tmpLnk,Timbratura.Rilevatore);
      inc(ColControl);

      //componente label per causale
      with grdTimbratureGiorno.Cell[rowControl,colControl] do
      begin
        tmpLnk:=TmeIWLink.Create(Self);
        Control:=tmpLnk;
        Css:='cellaCausale';
      end;
      tmpEdt:=(grdTimbratureGiorno.Cell[0,colControl-2].Control as TmeIWEdit);
      ImpostaLinkCausale(tmpLnk, tmpEdt, Trim(Timbratura.Causale));
      inc(ColControl);
      if (rowControl < grdTimbratureGiorno.rowCount - 1 ) and (colControl > (TIMBXROW * 3) - 1) then
      begin
        colControl:=0;
        inc(rowControl);
      end;
    end;
    if bCanNuovaTimbratura then
    begin
      // componente edit
      with grdTimbratureGiorno.Cell[rowControl,colControl] do
      begin
        Control:=TmeIWEdit.Create(Self);
        Css:='width3chr';
      end;
      with (grdTimbratureGiorno.Cell[rowControl,colControl].Control as TmeIWEdit) do
      begin
        FriendlyName:=NOMETIMBR + IntToStr(NumTimbrature+1) + NOMEDAY + IntToStr(day);
        Name:=FriendlyName;
        Tag:=day;
        Text:='';
        Css:='width3chr font11';
        Hint:='Nuova timbratura';
        ReadOnly:=True;
        onAsyncDoubleClick:=edtTimbraturaAsyncDoubleClick;
        medpContextMenu:=pmnNuovaTimbratura;
        RenderSize:=False;
        Font.Enabled:=False;
      end;
    end;
  end;
end;

procedure TWR104FGestCartellino.edtTimbraturaAsyncDoubleClick(Sender: TObject;
  EventParams: TStringList);
var btnName: String;
begin
  try
    if (not SolaLettura) then
    begin
      DataOperazione:=StrToDate(IntToStr((Sender as TmeIWEdit).Tag) + '/' + edtMese.Text);
      NumeroElemento:=EstraiColonnaElemento((Sender as TmeIWEdit).Name,NOMETIMBR);
      if NumeroElemento > getNumeroTimbrature((Sender as TmeIWEdit).Tag) then //Nuova timbratura
        btnName:=btnNuovaTimb.HTMLName
      else
      begin
        btnName:=btnModificaTimb.HTMLName
      end;
      //Devo forzare un submit perchè non posso creare frame in async. Non esiste l'evento DoubleClick non in async
      GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[btnName]));
    end;
  except
  end;
end;

procedure TWR104FGestCartellino.edtGiustificativoAsyncDoubleClick(Sender: TObject;
  EventParams: TStringList);
var btnName: String;
begin
  try
    if bCanNuovoGiustificativo then
    begin
      DataOperazione:=StrToDate(IntToStr((Sender as TmeIWEdit).Tag) + '/' + edtMese.Text);
      NumeroElemento:=EstraiColonnaElemento((Sender as TmeIWEdit).Name,NOMEGIUST);
      if NumeroElemento > getNumeroGiustificativi((Sender as TmeIWEdit).Tag) then //Nuovo giustificativo
        btnName:=btnNuovoGiust.HTMLName
      else
      begin
        btnName:=btnModificaGiust.HTMLName
      end;
      //Devo forzare un submit perchè non posso creare frame in async. Non esiste l'evento DoubleClick non in async
      GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[btnName]));
    end;
  except
  end;
end;

end.
