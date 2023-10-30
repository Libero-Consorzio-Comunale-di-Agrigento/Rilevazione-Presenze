unit W010UCancPeriodoFM;

interface

uses
  A000UMessaggi, W000UMessaggi, W010URichiestaAssenzeDM, R010UPaginaWeb, C018UIterAutDM,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb, Variants,
  SysUtils, Classes, Controls, Forms, IWApplication, IWAppForm, IWTypes,
  IWVCLBaseContainer, IWContainer, IWRegion,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompButton,
  IWHTMLContainer, IWHTML40Container, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompEdit, meIWEdit, IWCompLabel, meIWLabel, meIWButton,
  IWCompJQueryWidget, DB, OracleData;

type
  TactInsRevoca = procedure(const PTipoRichiesta: String; const PDal, PAl: TDateTime) of object;

  TW010FCancPeriodoFM = class(TFrame)
    IWFrameRegion: TIWRegion;
    IWTemplateProcessorFrame: TIWTemplateProcessorHTML;
    jQVisFrame: TIWJQueryWidget;
    lblRichiestaOrig: TmeIWLabel;
    lblErrore: TmeIWLabel;
    btnConferma: TmeIWButton;
    btnAnnulla: TmeIWButton;
    lblDal: TmeIWLabel;
    edtDal: TmeIWEdit;
    lblAl: TmeIWLabel;
    edtAl: TmeIWEdit;
    lblPeriodo: TmeIWLabel;
    jqPeriodo: TIWJQueryWidget;
    lblPeriodoOrig: TmeIWLabel;
    lblCausaleOrig: TmeIWLabel;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure btnConfermaClick(Sender: TObject);
    procedure btnAnnullaClick(Sender: TObject);
  private
    Progressivo: Integer;
    CausOrig: String;
    DescCausOrig: String;
    DalOrig, AlOrig: TDateTime;
    Dal, Al: TDateTime;
  public
    IdOrig: Integer;
    DataProposta: TDateTime;
    C018: TC018FIterAutDM;
    W010DM: TW010FRichiestaAssenzeDM;
    actInsRevoca: TactInsRevoca;
    procedure Visualizza;
  end;

implementation

{$R *.dfm}

uses A000UInterfaccia, W010URichiestaAssenze, W033UProspettoAssenze;

procedure TW010FCancPeriodoFM.IWFrameRegionCreate(Sender: TObject);
begin
  Self.Parent:=(Self.Owner as TIWAppForm);
  W010DM:=nil;
  C018:=nil;
  IdOrig:=0;
  DataProposta:=DATE_NULL;
  CausOrig:='';
  DescCausOrig:='';
  DalOrig:=DATE_NULL;
  AlOrig:=DATE_NULL;
  Dal:=DATE_NULL;
  Al:=DATE_NULL;
end;

procedure TW010FCancPeriodoFM.Visualizza;
var
  Titolo: String;
begin
  // posiziona il dataset sulla richiesta per cui occorre cancellare il periodo
  with W010DM.selT050 do
  begin
    Close;
    SetVariable('DATALAVORO',Parametri.DataLavoro);
    SetVariable('FILTRO_ANAG','');
    SetVariable('FILTRO_PERIODO','');
    SetVariable('FILTRO_VISUALIZZAZIONE',Format('and T_ITER.ID = %d',[IdOrig]));
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
    SetVariable('FILTRO_STRUTTURA','');
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine
    // MONDOEDP - commessa MAN/07.ini
    SetVariable('FILTRO_ALLEGATI',C018.FiltroAllegati);
    // MONDOEDP - commessa MAN/07.fine
    Open;

    if RecordCount <> 1 then
    begin
      //Distruggo il frame per tornare subito alla pagina chiamante
      Self.Free;
      raise Exception.Create(Format(A000TraduzioneStringhe('Richiesta originale %d non trovata!'),[IdOrig]));
    end;

    Progressivo:=FieldByName('PROGRESSIVO').AsInteger;
    DalOrig:=FieldByName('DAL').AsDateTime;
    AlOrig:=FieldByName('AL').AsDateTime;
    CausOrig:=FieldByName('CAUSALE').AsString;
    DescCausOrig:=FieldByName('D_CAUSALE').AsString;
  end;

  // dati richiesta originale
  lblCausaleOrig.Caption:=Format('%s (%s)',[CausOrig,DescCausOrig]);
  lblPeriodoOrig.Caption:=Format(A000TraduzioneStringhe(A000MSG_MSG_FMT_DALAL),[FormatDateTime('dd/mm/yyyy',DalOrig),FormatDateTime('dd/mm/yyyy',AlOrig)]);

  // periodo di default
  if (DataProposta <> DATE_NULL) and (DataProposta >= DalOrig) and (DataProposta <= AlOrig) then
  begin
    // data proposta valorizzata e coerente con il periodo: utilizza questa
    edtDal.Text:=FormatDateTime('dd/mm/yyyy',DataProposta);
    edtAl.Text:=edtDal.Text;
  end
  else
  begin
    // primo gg della richiesta
    edtDal.Text:=FormatDateTime('dd/mm/yyyy',DalOrig);
    edtAl.Text:=edtDal.Text;
  end;

  Titolo:=A000TraduzioneStringhe(A000MSG_W010_MSG_CANC_PERIODO);
  jqPeriodo.OnReady.Text:=Format(jqPeriodo.OnReady.Text,
                                 [R180Anno(DalOrig),R180Mese(DalOrig) - 1,R180Giorno(DalOrig),
                                  R180Anno(AlOrig),R180Mese(AlOrig)- 1,R180Giorno(AlOrig),
                                  edtDal.HTMLName,
                                  edtAl.HTMLName]);

  if (DalOrig = DATE_NULL) or (AlOrig = DATE_NULL) then
    raise Exception.Create(A000TraduzioneStringhe('Date di riferimento della richiesta non impostate!'));
  if (DalOrig > AlOrig) then
    raise Exception.Create(A000TraduzioneStringhe('Date di riferimento della richiesta non impostate correttamente!'));
  if (DalOrig = AlOrig) then
    raise Exception.Create(A000TraduzioneStringhe('La funzione di cancellazione periodo non è disponibile per un periodo di un giorno singolo!'));

  btnAnnulla.SetFocus;
  TR010FPaginaWeb(Self.Parent).VisualizzajQMessaggio(jQVisFrame,300,-1,EM2PIXEL * 10,Titolo,'#' + Name,False,True)
end;

procedure TW010FCancPeriodoFM.btnConfermaClick(Sender: TObject);
begin
  lblErrore.Caption:='';

  // controlli generali sul periodo
  if Trim(edtDal.Text) = '' then
  begin
    lblErrore.Caption:=A000TraduzioneStringhe('Indicare la data iniziale');
    Exit;
  end;
  if Trim(edtAl.Text) = '' then
  begin
    lblErrore.Caption:=A000TraduzioneStringhe('Indicare la data finale');
    Exit;
  end;
  if not TryStrToDate(edtDal.Text,Dal) then
  begin
    lblErrore.Caption:=A000TraduzioneStringhe('La data iniziale non è corretta');
    Exit;
  end;
  if not TryStrToDate(edtAl.Text,Al) then
  begin
    lblErrore.Caption:=A000TraduzioneStringhe('La data finale non è corretta');
    Exit;
  end;
  if Dal > Al then
  begin
    lblErrore.Caption:=A000TraduzioneStringhe(A000MSG_W010_MSG_DATA_FINE_MAGG_INIZIO);
    Exit;
  end;

  // periodo da cancellare interno al periodo originale
  if Dal < DalOrig then
  begin
    lblErrore.Caption:=A000TraduzioneStringhe('La data iniziale non è compresa nel periodo della richiesta');
    Exit;
  end;
  if Al > AlOrig then
  begin
    lblErrore.Caption:=A000TraduzioneStringhe('La data finale non è compresa nel periodo della richiesta');
    Exit;
  end;
  if (Dal = DalOrig) and (Al = AlOrig) then
  begin
    lblErrore.Caption:=A000TraduzioneStringhe('Per cancellare l''intero periodo è necessario utilizzare la funzione di revoca');
    Exit;
  end;

  // intersezione con altra cancellazione
  with W010DM.selCancInt do
  begin
    Close;
    SetVariable('PROGRESSIVO',Progressivo);
    SetVariable('DAL',Dal);
    SetVariable('AL',Al);
    Open;
    if RecordCount > 0 then
    begin
      if FieldByName('DAL').AsDateTime = FieldByName('AL').AsDateTime then
        lblErrore.Caption:=Format(A000TraduzioneStringhe('Il periodo indicato è già compreso nella richiesta di cancellazione per il giorno %s.'),
                                  [FieldByName('DAL').AsString])
      else
        lblErrore.Caption:=Format(A000TraduzioneStringhe('Il periodo indicato è già compreso nella richiesta di cancellazione dal %s al %s.'),
                                  [FieldByName('DAL').AsString,FieldByName('AL').AsString]);
      Exit;
    end;
  end;

  // Se arriviamo fin qui tutti i controlli sono stati superati.

  //Alberto 09/04/2019:
  //si usa il metodo 'ufficiale' TW010FRichiestaAssenze.actInsRevoca
  //Prima veniva eseguito l'inserimento della richiesta con codice duplicato, che però non gestiva l'acquisizione automatica.
  actInsRevoca('C',Dal,Al);
end;

procedure TW010FCancPeriodoFM.btnAnnullaClick(Sender: TObject);
begin
  Free;  //Chiudo il messaggio
end;

end.
