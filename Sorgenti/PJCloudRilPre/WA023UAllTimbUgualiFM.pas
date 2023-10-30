unit WA023UAllTimbUgualiFM;

interface

uses
  A000UInterfaccia, A023UAllTimbMW, C180FunzioniGenerali, DateUtils, A000UMessaggi,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR200UBaseFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompEdit, meIWEdit,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompLabel,
  meIWLabel, IWCompExtCtrls, meIWImageFile, medpIWImageButton, System.Actions,
  Vcl.ActnList, IWCompGrids, IWDBGrids, medpIWDBGrid, Vcl.Menus, Data.DB,
  IWCompButton, meIWButton, OracleData;

type
  TWA023FAllTimbUgualiFM = class(TWR200FBaseFM)
    lblPeriodo: TmeIWLabel;
    lblDal: TmeIWLabel;
    edtDal: TmeIWEdit;
    lblAl: TmeIWLabel;
    edtAl: TmeIWEdit;
    imbOK: TmedpIWImageButton;
    imbCancel: TmedpIWImageButton;
    lblMese: TmeIWLabel;
    lblTimbrature: TmeIWLabel;
    grdTimbUguali: TmedpIWDBGrid;
    pmnAzioniTabella: TPopupMenu;
    mnuScambiaTimbrature: TMenuItem;
    btnAggiornaTabella: TmeIWButton;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure mnuScambiaTimbratureClick(Sender: TObject);
    procedure imbOKClick(Sender: TObject);
    procedure grdTimbUgualiRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure edtDalAsyncExit(Sender: TObject; EventParams: TStringList);
    procedure btnAggiornaTabellaClick(Sender: TObject);
    procedure edtAlAsyncExit(Sender: TObject; EventParams: TStringList);
  private
    DataInizio, DataFine: TDateTime;
    A023FAllTimbMW: TA023FAllTimbMW;
    procedure AggiornaVistaTimbrature(const PDataInizio, PDataFine: TDateTime);
  public
    ScambiManualiEffettuati: Boolean;
    ResultEvent: TProc<TObject,Boolean>;
    procedure CaricaDatiIniziali(PDataRif: TDateTime);
    procedure Visualizza;
    procedure ReleaseOggetti; override;
  end;

implementation

uses WR100UBase, WA023UTimbrature, IWApplication;

{$R *.dfm}

{ TWA023FAllTimbUgualiFM }

procedure TWA023FAllTimbUgualiFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;

  A023FAllTimbMW:=TA023FAllTimbMW.Create(nil);
  A023FAllTimbMW.Q100.Session:=SessioneOracle;
  A023FAllTimbMW.Q100Upd.Session:=SessioneOracle;

  // imposta visibilità campi cdsT100
  with A023FAllTimbMW.cdsT100 do
  begin
    FieldByName('AUTOMATICO').Visible:=True;
    FieldByName('MATRICOLA').Visible:=False;
    FieldByName('D_NOMINATIVO').Visible:=False;
    FieldByName('ORA1').Visible:=False;
    FieldByName('VERSO1').Visible:=False;
    FieldByName('FLAG1').Visible:=False;
    FieldByName('CAUSALE1').Visible:=False;
    FieldByName('ROWID1').Visible:=False;
    FieldByName('ORA2').Visible:=False;
    FieldByName('VERSO2').Visible:=False;
    FieldByName('FLAG2').Visible:=False;
    FieldByName('CAUSALE2').Visible:=False;
    FieldByName('ROWID2').Visible:=False;
  end;

  // variabile per indicare scambi timbrature manuali
  ScambiManualiEffettuati:=False;
end;

procedure TWA023FAllTimbUgualiFM.ReleaseOggetti;
begin
  FreeAndNil(A023FAllTimbMW);
end;

procedure TWA023FAllTimbUgualiFM.btnAggiornaTabellaClick(Sender: TObject);
begin
  // rilegge le timbrature uguali e aggiorna la vista
  AggiornaVistaTimbrature(DataInizio,DataFine);
  grdTimbUguali.medpCaricaCDS;
end;

procedure TWA023FAllTimbUgualiFM.CaricaDatiIniziali(PDataRif: TDateTime);
begin
  // imposta interfaccia
  lblMese.Caption:=R180Capitalize(FormatDateTime('mmmm yyyy',PDataRif));
  edtDal.Text:=R180Giorno(PDataRif).ToString;
  edtAl.Text:=edtDal.Text;

  // carica timbrature uguali in tabella
  AggiornaVistaTimbrature(PDataRif,PDataRif);
  grdTimbUguali.medpAttivaGrid(A023FAllTimbMW.cdsT100,False,False,False);
end;

procedure TWA023FAllTimbUgualiFM.edtDalAsyncExit(Sender: TObject;
  EventParams: TStringList);
begin
  try
    DataInizio:=RecodeDay(DataInizio,StrToInt(edtDal.Text));
  except
    GGetWebApplicationThreadVar.ShowMessage(A000MSG_ERR_DATA_ERRATA);
    Exit;
  end;

  // mantiene coerente il periodo
  if DataInizio > DataFine then
  begin
    DataFine:=DataInizio;
    edtAl.Text:=edtDal.Text;
  end;

  //Devo forzare un submit perchè la griglia non si carica in async
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[btnAggiornaTabella.HTMLName]));
end;

procedure TWA023FAllTimbUgualiFM.edtAlAsyncExit(Sender: TObject;
  EventParams: TStringList);
begin
  try
    DataFine:=RecodeDay(DataFine,StrToInt(edtAl.Text));
  except
    GGetWebApplicationThreadVar.ShowMessage(A000MSG_ERR_DATA_ERRATA);
    Exit;
  end;

  // mantiene coerente il periodo
  if DataFine < DataInizio then
  begin
    DataInizio:=DataFine;
    edtAl.Text:=edtDal.Text;
  end;

  //Devo forzare un submit perchè la griglia non si carica in async
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[btnAggiornaTabella.HTMLName]));
end;

procedure TWA023FAllTimbUgualiFM.grdTimbUgualiRenderCell(ACell: TIWGridCell;
  const ARow, AColumn: Integer);
begin
  if not grdTimbUguali.medpRenderCell(ACell,ARow,AColumn,True,True,True) then
    Exit;
end;

procedure TWA023FAllTimbUgualiFM.Visualizza;
begin
  (Self.Parent as TWR100FBase).VisualizzaJQMessaggio(jQuery,560,-1,450,'Allineamento timbrature uguali','#' + Self.Name,False,True);
end;

procedure TWA023FAllTimbUgualiFM.imbOKClick(Sender: TObject);
var
  Res: Boolean;
begin
  inherited;

  Res:=Sender = imbOK;
  if Res then
  begin
    // Scambio automatico -> effettua allineamento nel periodo indicato
    (Self.Parent as TWA023FTimbrature).WA023FTimbratureDM.A023FTimbratureMW.AllineamentoTimbraturePeriodo(DataInizio,DataFine);
  end
  else
  begin
    // Chiudi -> valorizza Res a True se sono stati effettuati degli scambi manuali
    Res:=ScambiManualiEffettuati;
  end;

  if Assigned(ResultEvent) then
  try
    ResultEvent(Self,Res);
  except
    on E: EAbort do;
    on E: Exception do
      raise;
  end;

  ReleaseOggetti;
  Free;
end;

procedure TWA023FAllTimbUgualiFM.AggiornaVistaTimbrature(const PDataInizio, PDataFine: TDateTime);
var
  LSelAnag: TOracleDataSet;
  DatiAnag: TDatiAnag;
begin
  DataInizio:=PDataInizio;
  DataFine:=PDataFine;

  // aggiorna dataset timbrature
  LSelAnag:=(Self.Owner as TWA023FTimbrature).grdC700.WC700DM.selAnagrafe;
  DatiAnag:=TA023FAllTimbMW.GetDatiAnag(LSelAnag.FieldByName('PROGRESSIVO').AsInteger,
                                        LSelAnag.FieldByName('COGNOME').AsString,
                                        LSelAnag.FieldByName('NOME').AsString,
                                        LSelAnag.FieldByName('MATRICOLA').AsString);
  A023FAllTimbMW.LeggiTimbratureUguali(DatiAnag,PDataInizio,PDataFine,True);
end;

procedure TWA023FAllTimbUgualiFM.mnuScambiaTimbratureClick(Sender: TObject);
var
  T1, T2: TTimbratura;
  BM: TBookMark;
  OraNew: TDateTime;
begin
  // legge gli estremi della coppia di timbrature selezionate per scambiarle
  with A023FAllTimbMW.cdsT100 do
  begin
    if not Active then
    begin
      GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_A023_ERR_COMANDO_ALLTIMB));
      Exit;
    end;

    if RecordCount = 0 then
    begin
      GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_A023_ERR_NO_TIMB_DA_SCAMBIARE));
      Exit;
    end;

    T1:=A023FAllTimbMW.Timbratura(FieldByName('DATA').AsDateTime,
                                  FieldByName('ORA1').AsDateTime,
                                  FieldByName('VERSO1').AsString,
                                  FieldByName('FLAG1').AsString,
                                  FieldByName('CAUSALE1').AsString,
                                  FieldByName('ROWID1').AsString);
    T2:=A023FAllTimbMW.Timbratura(FieldByName('DATA').AsDateTime,
                                  FieldByName('ORA2').AsDateTime,
                                  FieldByName('VERSO2').AsString,
                                  FieldByName('FLAG2').AsString,
                                  FieldByName('CAUSALE2').AsString,
                                  FieldByName('ROWID2').AsString);
  end;

  // salva il bookmark
  BM:=A023FAllTimbMW.cdsT100.GetBookmark;
  try
    // effettua lo scambio delle timbrature
    OraNew:=A023FAllTimbMW.ScambiaTimbrature(T1,T2,False);

    // se lo scambio è avvenuto aggiorna la visualizzazione
    if OraNew <> DATE_NULL then
    begin
      ScambiManualiEffettuati:=True;
      AggiornaVistaTimbrature(DataInizio,DataFine);
    end
    else
      MsgBox.MessageBox('Non è stato possibile effettuare lo scambio delle timbrature selezionate!',INFORMA);

    // ripristina il bookmark
    if A023FAllTimbMW.cdsT100.BookmarkValid(BM) then
      A023FAllTimbMW.cdsT100.GotoBookmark(BM);

    // ricarica grid
    grdTimbUguali.medpCaricaCDS;
  finally
    A023FAllTimbMW.cdsT100.FreeBookmark(BM);
  end;
end;

end.
