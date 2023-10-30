unit WA105UStoricoGiustificativi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR100UBase, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompButton, meIWButton, IWCompGrids, meIWGrid,
  medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink, IWCompEdit, meIWEdit, IWCompLabel,
  meIWLabel, IWCompListbox, meIWComboBox, IWCompCheckbox, meIWCheckBox,
  meIWImageFile, medpIWImageButton, IWTMSCheckList, meTIWCheckListBox,
  A105UStoricoGiustificativiMW, medpIWC700NavigatorBar, C180FunzioniGenerali, StrUtils,
  A000UInterfaccia, A000UMessaggi, A000USessione, WC013UCheckListFM, IWCompJQueryWidget,
  C190FunzioniGeneraliWeb, Data.DB, Datasnap.DBClient, Datasnap.Win.MConnect, DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF}
  Vcl.Menus, A000UCostanti, ActiveX;

type
  TWA105FStoricoGiustificativi = class(TWR100FBase)
    lblDaData: TmeIWLabel;
    edtDaData: TmeIWEdit;
    lblAData: TmeIWLabel;
    edtAData: TmeIWEdit;
    cmbCampo: TmeIWComboBox;
    lblCampo: TmeIWLabel;
    lblStatoElab: TmeIWLabel;
    btnStatoElab: TmeIWButton;
    chkRecordFisici: TmeIWCheckBox;
    chkAssenzeInserite: TmeIWCheckBox;
    chkAssenzeCancellate: TmeIWCheckBox;
    chkDettaglioGiornaliero: TmeIWCheckBox;
    chkDettaglioPeriodico: TmeIWCheckBox;
    chkDatiIndividuali: TmeIWCheckBox;
    chkSaltoPaginaIndividuale: TmeIWCheckBox;
    chkSaltoPaginaRaggr: TmeIWCheckBox;
    chkTotaliIndividuali: TmeIWCheckBox;
    btnGeneraPDF: TmedpIWImageButton;
    lblDefinizionePeriodo: TmeIWLabel;
    lblPeriodoDal: TmeIWLabel;
    edtPeriodoDal: TmeIWEdit;
    lblPeriodoAl: TmeIWLabel;
    edtPeriodoAl: TmeIWEdit;
    chkDefinizioneDataRegistrazione: TmeIWCheckBox;
    chkImpostaAssElab: TmeIWCheckBox;
    chkRegistrazioneInserimenti: TmeIWCheckBox;
    chkRegistrazioneCancellazioni: TmeIWCheckBox;
    chkEliminazioneAssenze: TmeIWCheckBox;
    lblDataRegistrazione: TmeIWLabel;
    edtDataRegistrazione: TmeIWEdit;
    btnEsegui: TmedpIWImageButton;
    clbCausali: TmeTIWCheckListBox;
    lblCausali: TmeIWLabel;
    chkTotaliRaggr: TmeIWCheckBox;
    chkTotaliGenerali: TmeIWCheckBox;
    JQuery: TIWJQueryWidget;
    DCOMConnection: TDCOMConnection;
    pmnAzioni: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure edtADataAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure cmbCampoAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure chkDettaglioGiornalieroAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure chkDettaglioPeriodicoAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure chkDatiIndividualiAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure chkDefinizioneDataRegistrazioneAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure btnStatoElabClick(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure btnGeneraPDFClick(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
  private
    { Private declarations }
    A105MW:TA105FStoricoGiustificativiMW;
    WC013:TWC013FCheckListFM;
    sCausaliSelezionate:String;
    Registra:Boolean;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure cklistStatoElabResult(Sender: TObject; Result:Boolean);
    procedure CallDCOMPrinter;
    function CreateJSonString: String;
  public
    { Public declarations }
  protected
    procedure ImpostazioniWC700; override;
    procedure InizioElaborazione; override;
    function TotalRecordsElaborazione: Integer; override;
    function CurrentRecordElaborazione: Integer; override;
    procedure ElaboraElemento; override;
    function ElementoSuccessivo: Boolean; override;
    procedure FineCicloElaborazione; override;
    function ElaborazioneTerminata: String; override;
  end;

implementation

{$R *.dfm}

procedure TWA105FStoricoGiustificativi.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  //attivazione gestione Tab JQuery
  JQuery.OnReady.Text:=Format(W000JQ_Tabs,[Name]);

  A105MW:=TA105FStoricoGiustificativiMW.Create(Self);
  grdC700:=TmedpIWC700NavigatorBar.Create(Self);//Danilo: creato prima di AttivaGestioneC700 per impostare le altre proprietà non standard
  grdC700.AttivaBrowse:=False;
  A105MW.selAnagrafe:=grdC700.selAnagrafe;
  AttivaGestioneC700;
  edtDaData.Text:=FormatDateTime('dd/mm/yyyy',R180InizioMese(Parametri.DataLavoro));
  edtAData.Text:=FormatDateTime('dd/mm/yyyy',R180FineMese(Parametri.DataLavoro));
  edtPeriodoDal.Text:=FormatDateTime('dd/mm/yyyy',R180InizioMese(Parametri.DataLavoro));
  edtPeriodoAl.Text:=FormatDateTime('dd/mm/yyyy',R180FineMese(Parametri.DataLavoro));
  edtDataRegistrazione.Text:=FormatDateTime('dd/mm/yyyy',Parametri.DataLavoro);
  cmbCampo.Items.Clear;
  with A105MW.selI010 do
  begin
    First;
    while not Eof do
    begin
      cmbCampo.Items.add(FieldByName('NOME_LOGICO').AsString + '=' + FieldByName('NOME_CAMPO').AsString);
      Next;
    end;
  end;
  clbCausali.Items.Clear;
  with A105MW.Q265 do
  begin
    First;
    while not Eof do
    begin
      clbCausali.Items.Add(Format('%-5s %s',[FieldByName('Codice').AsString,FieldByName('Descrizione').AsString]));
      Next;
    end;
  end;
  GetParametriFunzione;
  btnEsegui.Enabled:=not SolaLettura; //Lorena 28/08/2006
end;

procedure TWA105FStoricoGiustificativi.IWAppFormDestroy(Sender: TObject);
begin
  PutParametriFunzione;
  inherited;
end;

procedure TWA105FStoricoGiustificativi.ImpostazioniWC700;
begin
  inherited;
  with grdC700.WC700FM do
  begin
    C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
    C700DataLavoro:=Parametri.DataLavoro;
  end;
end;

procedure TWA105FStoricoGiustificativi.GetParametriFunzione;
{Leggo i parametri della form}
var x, y, i,r:integer;
    e: boolean;
    svalore, snome, selemento:string;
begin
  chkAssenzeInserite.Checked:=C004DM.GetParametro('ASSENZEINSERITE','S') = 'S';
  chkAssenzeCancellate.Checked:=C004DM.GetParametro('ASSENZECANCELLATE','S') = 'S';
  chkRecordFisici.Checked:=C004DM.GetParametro('RECORDFISICI','N') = 'S';
  chkTotaliIndividuali.Checked:=C004DM.GetParametro('TOTINDIVIDUALI','N') = 'S';
  chkTotaliRaggr.Checked:=C004DM.GetParametro('TOTGRUPPO','N') = 'S';
  chkTotaliGenerali.Checked:=C004DM.GetParametro('TOTGENERALI','N') = 'S';
  chkSaltoPaginaIndividuale.Checked:=C004DM.GetParametro('SALTOPAGINAIND','N') = 'S';
  chkSaltoPaginaRaggr.Checked:=C004DM.GetParametro('SALTOPAGINAGRUPPO','N') = 'S';
  chkDettaglioGiornaliero.Checked:=C004DM.GetParametro('DETTAGLIO','N') = 'S';
  chkDettaglioPeriodico.Checked:=C004DM.GetParametro('PERIODICO','N') = 'S';
  chkDatiIndividuali.Checked:=C004DM.GetParametro('DATIINDIVIDUALI','N') = 'S';
  cmbCampo.ItemIndex:=cmbCampo.Items.IndexOf(C004DM.GetParametro('CAMPORAGGRUPPA','')+'='+VarToStr(A105MW.selI010.Lookup('NOME_LOGICO',C004DM.GetParametro('CAMPORAGGRUPPA',''),'NOME_CAMPO')));
  chkDefinizioneDataRegistrazione.Checked:=C004DM.GetParametro('DEFDATAREGISTRAZ','N') = 'S';
  edtDataRegistrazione.Enabled:=not(chkDefinizioneDataRegistrazione.Checked);
  chkRegistrazioneInserimenti.Checked:=C004DM.GetParametro('REGISTRAINS','S') = 'S';
  chkRegistrazioneCancellazioni.Checked:=C004DM.GetParametro('REGISTRACAN','S') = 'S';
  chkEliminazioneAssenze.Checked:=C004DM.GetParametro('ELIMINAMOVIMENTI','N') = 'S';
  chkDettaglioGiornaliero.Enabled:=not(chkDettaglioPeriodico.Checked);
  chkDettaglioPeriodico.Enabled:=not(chkDettaglioGiornaliero.Checked);
  if cmbCampo.Text = '' then
  begin
    chkTotaliRaggr.Enabled:=False;
    chkTotaliRaggr.Checked:=False;
    chkSaltoPaginaRaggr.Enabled:=False;
    chkSaltoPaginaRaggr.Checked:=False;
  end;
  // lettura causali selezionate
  x:=0; //contatore di paramento
  snome:='LISTACAUSALI';
  repeat
  // ciclo sui parametri LISTACAUSALI0,LISTACAUSALI1,ecc.
    svalore:=C004DM.GetParametro(snome+IntToStr(x),'');
    y:=0; // contatore di elementi nel parametro
    if svalore<>'' then
      begin
      repeat
      // ciclo sugli elementi nel parametro max 16 per parametro
        selemento:=Copy(svalore,(y*5)+1,5);
        if selemento<>'' then
          begin
          i:=0;
          e:=true;
          r:=clbCausali.Items.Count;
          while (i<r) and (e) do
            begin
            if Copy(clbCausali.Items[i],1,5)=selemento then
               begin
               clbCausali.Selected[i]:=true;
               e:=false;
               end
            else
               if Copy(clbCausali.Items[i],1,5)>selemento then
                  e:=false;
            inc(i);
            end;
          inc(y);
          end;
      until selemento = '';
      inc(x);
    end;
  until svalore = '';
end;

procedure TWA105FStoricoGiustificativi.PutParametriFunzione;
{Scrivo i parametri della forma}
var i,x,y,r:integer;
    svalore,snome:string;
begin
  SessioneOracle.Rollback;
  C004DM.Cancella001;
  if chkAssenzeInserite.Checked then
    C004DM.PutParametro('ASSENZEINSERITE','S')
  else
    C004DM.PutParametro('ASSENZEINSERITE','N');
  if chkAssenzeCancellate.Checked then
    C004DM.PutParametro('ASSENZECANCELLATE','S')
  else
    C004DM.PutParametro('ASSENZECANCELLATE','N');
  if chkRecordFisici.Checked then
    C004DM.PutParametro('RECORDFISICI','S')
  else
    C004DM.PutParametro('RECORDFISICI','N');
  if chkTotaliIndividuali.Checked then
    C004DM.PutParametro('TOTINDIVIDUALI','S')
  else
    C004DM.PutParametro('TOTINDIVIDUALI','N');
  if chkTotaliRaggr.Checked then
    C004DM.PutParametro('TOTGRUPPO','S')
  else
    C004DM.PutParametro('TOTGRUPPO','N');
  if chkTotaliGenerali.Checked then
    C004DM.PutParametro('TOTGENERALI','S')
  else
    C004DM.PutParametro('TOTGENERALI','N');
  if chkSaltoPaginaIndividuale.Checked then
    C004DM.PutParametro('SALTOPAGINAIND','S')
  else
    C004DM.PutParametro('SALTOPAGINAIND','N');
  if chkSaltoPaginaRaggr.Checked then
    C004DM.PutParametro('SALTOPAGINAGRUPPO','S')
  else
    C004DM.PutParametro('SALTOPAGINAGRUPPO','N');
  if chkDettaglioGiornaliero.Checked then
    C004DM.PutParametro('DETTAGLIO','S')
  else
    C004DM.PutParametro('DETTAGLIO','N');
  if chkDettaglioPeriodico.Checked then
    C004DM.PutParametro('PERIODICO','S')
  else
    C004DM.PutParametro('PERIODICO','N');
  if chkDatiIndividuali.Checked then
    C004DM.PutParametro('DATIINDIVIDUALI','S')
  else
    C004DM.PutParametro('DATIINDIVIDUALI','N');
  C004DM.PutParametro('CAMPORAGGRUPPA',cmbCampo.Text);
  if chkDefinizioneDataRegistrazione.Checked then
    C004DM.PutParametro('DEFDATAREGISTRAZ','S')
  else
    C004DM.PutParametro('DEFDATAREGISTRAZ','N');
  if chkRegistrazioneInserimenti.Checked then
    C004DM.PutParametro('REGISTRAINS','S')
  else
    C004DM.PutParametro('REGISTRAINS','N');
  if chkRegistrazioneCancellazioni.Checked then
    C004DM.PutParametro('REGISTRACAN','S')
  else
    C004DM.PutParametro('REGISTRACAN','N');
  if chkEliminazioneAssenze.Checked then
    C004DM.PutParametro('ELIMINAMOVIMENTI','S')
  else
    C004DM.PutParametro('ELIMINAMOVIMENTI','N');
  // salvo l'elenco delle causali selezionate
  x:=0; //contatore parametri causali
  y:=0; //contatore elementi per parametro
  svalore:='';
  snome:='LISTACAUSALI';
  r:=clbCausali.Items.Count;
  For i:=1 to r do
    begin
    if clbCausali.Selected[i-1] then
       begin
       svalore:=svalore+Copy(clbCausali.Items[i-1],1,5);
       inc(y);
       if y=16 then
          begin
          C004DM.PutParametro(snome+IntToStr(x),svalore);
          inc(x);
          y:=0;
          svalore:='';
          end;
       end;
    end;
  C004DM.PutParametro(snome+IntToStr(x),svalore);

  try SessioneOracle.Commit; except end;
end;

procedure TWA105FStoricoGiustificativi.edtADataAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  try
    grdC700.WC700FM.C700DataLavoro:=StrToDate(edtAData.Text);
  except
    grdC700.WC700FM.C700DataLavoro:=Parametri.DataLavoro;
  end;
end;

procedure TWA105FStoricoGiustificativi.cmbCampoAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  if cmbCampo.Text = '' then
  begin
    chkTotaliRaggr.Enabled:=False;
    chkTotaliRaggr.Checked:=False;
    chkSaltoPaginaRaggr.Enabled:=False;
    chkSaltoPaginaRaggr.Checked:=False;
  end
  else
  begin
    chkTotaliRaggr.Enabled:=True;
    chkSaltoPaginaRaggr.Enabled:=True;
  end;
end;

procedure TWA105FStoricoGiustificativi.chkDettaglioGiornalieroAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  if chkDettaglioGiornaliero.Checked then
  begin
    chkDettaglioPeriodico.Checked:=false;
    chkDettaglioPeriodico.Enabled:=false;
  end
  else
    chkDettaglioPeriodico.Enabled:=True;
end;

procedure TWA105FStoricoGiustificativi.chkDettaglioPeriodicoAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  if chkDettaglioPeriodico.Checked then
  begin
    chkDettaglioGiornaliero.Checked:=False;
    chkDettaglioGiornaliero.Enabled:=false;
  end
  else
    chkDettaglioGiornaliero.Enabled:=True;
end;

procedure TWA105FStoricoGiustificativi.chkDatiIndividualiAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  chkTotaliIndividuali.Enabled:=chkDatiIndividuali.Checked;
  chkSaltoPaginaIndividuale.Enabled:=chkDatiIndividuali.Checked;
  chkDettaglioGiornaliero.Enabled:=chkDatiIndividuali.Checked;
  chkDettaglioPeriodico.Enabled:=chkDatiIndividuali.Checked;
  if not chkDatiIndividuali.Checked then
  begin
    chkTotaliIndividuali.Checked:=False;
    chkSaltoPaginaIndividuale.Checked:=False;
    chkDettaglioGiornaliero.Checked:=false;
    chkDettaglioPeriodico.Checked:=false;
  end;
end;

procedure TWA105FStoricoGiustificativi.chkDefinizioneDataRegistrazioneAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  edtDataRegistrazione.Enabled:=not(chkDefinizioneDataRegistrazione.Checked);
end;

procedure TWA105FStoricoGiustificativi.btnStatoElabClick(Sender: TObject);
var i:Integer;
begin
  inherited;
  WC013:=TWC013FCheckListFM.Create(Self.Parent);
  with WC013 do
  begin
    ResultEvent:=cklistStatoElabResult;
    ckList.Items.Clear;
    for i:=0 to A105MW.ListaDati.Count - 1 do
    begin
      ckList.Items.Add(A105MW.ListaDati[i]);
      ckList.Values.Add(Copy(A105MW.ListaDati[i],1,1));
    end;
    C190PutCheckList(StringReplace(A105MW.StatoPaghe,'''','',[rfReplaceAll]),1,ckList);
    Visualizza;
  end;
end;

procedure TWA105FStoricoGiustificativi.cklistStatoElabResult(Sender: TObject; Result:Boolean);
begin
  if Result then
    A105MW.StatoPaghe:='' + StringReplace(C190GetCheckList(1,WC013.ckList),',',''',''',[rfReplaceAll]) + '';
end;

procedure TWA105FStoricoGiustificativi.Invertiselezione1Click(Sender: TObject);
var i:Integer;
begin
  with (pmnAzioni.PopupComponent as TmeTIWCheckListBox) do
    for i:=0 to Items.Count - 1 do
      if Sender = SelezionaTutto1 then
        Selected[i]:=True
      else if Sender = DeselezionaTutto1 then
        Selected[i]:=False
      else if Sender = InvertiSelezione1 then
        Selected[i]:=not Selected[i];
end;

procedure TWA105FStoricoGiustificativi.btnGeneraPDFClick(Sender: TObject);
var i:Integer;
begin
  A105MW.ElencoCausali:='';
  for i:=0 to clbCausali.Items.Count - 1 do
    if clbCausali.Selected[i] then
    begin
      if A105MW.ElencoCausali <> '' then
        A105MW.ElencoCausali:=A105MW.ElencoCausali + ',';
      A105MW.ElencoCausali:=A105MW.ElencoCausali + Trim(Copy(clbCausali.Items[i],1,5));
    end;
  if A105MW.ElencoCausali = '' then
  begin
    Msgbox.MessageBox(A000MSG_A105_ERR_NO_CAUSALE,INFORMA);
    exit;
  end;
  CallDCOMPrinter;
  if not FileExists(DCOMNomeFile) then
    raise Exception.Create(A000MSG_ERR_FILE_NON_CREATO);
  if FileExists(DCOMNomeFile) then
  begin
    NomeFileGenerato:=DCOMNomeFile;
    InviaFileGenerato;
  end;
end;

procedure TWA105FStoricoGiustificativi.CallDCOMPrinter;
var DettaglioLog:OleVariant;
    DatiUtente: String;
begin
  //Chiamo Servizio COM B028 per creare il pdf su server
  DCOMNomeFile:=GetNomeFile('pdf');
  ForceDirectories(ExtractFileDir(DCOMNomeFile));
  DatiUtente:=CreateJSonString;
  if (not IsLibrary) and
     (Pos(INI_PAR_NO_COINITIALIZE,W000ParConfig.ParametriAvanzati) = 0) then // gestione parametri di configurazione su file
    CoInitialize(nil);
  if not DCOMConnection.Connected then
    DCOMConnection.Connected:=True;
  try
    A000SessioneWEB.AnnullaTimeOut;
    DCOMConnection.AppServer.PrintA105(grdC700.selAnagrafe.SubstitutedSQL,
                                       DCOMNomeFile,
                                       Parametri.Operatore,
                                       Parametri.Azienda,
                                       WR000DM.selAnagrafe.Session.LogonDataBase,
                                       DatiUtente,
                                       DettaglioLog);
  finally
    DCOMConnection.Connected:=False;
    A000SessioneWEB.RipristinaTimeOut;
  end;
end;

function TWA105FStoricoGiustificativi.CreateJSonString: String;
var json: TJSONObject;
begin
  json:=TJSONObject.Create;
  try
    //Popolo il json con i valori necessari al B028 per creare il PDF per la stampa
    json.AddPair('StandardPrinter',IfThen(Pos(INI_PAR_USE_STANDARD_PRINTER,W000ParConfig.ParametriAvanzati) > 0,'S','N'));
    C190Comp2JsonString(edtDaData,json);
    C190Comp2JsonString(edtAData,json);

    C190Comp2JsonString(cmbCampo,json,'dcmbCampo');
    json.AddPair('StatoPaghe',TJSONString.Create(A105MW.StatoPaghe));
    C190Comp2JsonString(chkRecordFisici,json);
    C190Comp2JsonString(chkAssenzeInserite,json);
    C190Comp2JsonString(chkAssenzeCancellate,json);
    C190Comp2JsonString(chkDettaglioGiornaliero,json);
    C190Comp2JsonString(chkDettaglioPeriodico,json);
    C190Comp2JsonString(chkDatiIndividuali,json);
    C190Comp2JsonString(chkSaltoPaginaIndividuale,json);
    C190Comp2JsonString(chkSaltoPaginaRaggr,json);
    C190Comp2JsonString(chkTotaliIndividuali,json);
    C190Comp2JsonString(chkTotaliRaggr,json);
    C190Comp2JsonString(chkTotaliGenerali,json);

    json.AddPair('clbCausali',TJSONString.Create(A105MW.ElencoCausali));

    Result:=json.ToString;
  finally
    FreeAndNil(json);
  end;
end;

procedure TWA105FStoricoGiustificativi.btnEseguiClick(Sender: TObject);
var i:Integer;
begin
  sCausaliSelezionate:='';
  for i:=0 to clbCausali.Items.Count - 1 do
    if clbCausali.Selected[i] then
    begin
      if sCausaliSelezionate <> '' then
        sCausaliSelezionate:=sCausaliSelezionate + ',';
      sCausaliSelezionate:=sCausaliSelezionate + Trim(Copy(clbCausali.Items[i],1,5));
    end;
  if sCausaliSelezionate = '' then
    raise Exception.Create(A000MSG_A105_ERR_NO_CAUSALE);
  sCausaliSelezionate:='''' + StringReplace(sCausaliSelezionate,',',''',''',[rfReplaceAll]) + '''';
  Registra:=chkRegistrazioneInserimenti.Checked or chkRegistrazioneCancellazioni.Checked;
  if chkRegistrazioneInserimenti.Checked or chkRegistrazioneCancellazioni.Checked or chkEliminazioneAssenze.Checked then
    StartElaborazioneCiclo((Sender as TmedpIWImageButton).HTMLName);
end;

procedure TWA105FStoricoGiustificativi.InizioElaborazione;
begin
  grdC700.SelAnagrafe.First;
end;

function TWA105FStoricoGiustificativi.TotalRecordsElaborazione: Integer;
begin
  Result:=grdC700.selAnagrafe.RecordCount;
end;

function TWA105FStoricoGiustificativi.CurrentRecordElaborazione: Integer;
begin
  Result:=grdC700.selAnagrafe.RecNO;
end;

procedure TWA105FStoricoGiustificativi.ElaboraElemento;
begin
  if Registra then
    A105MW.Registrazione(StrToDate(edtPeriodoDal.Text),
                         StrToDate(edtPeriodoAl.Text),
                         StrToDate(edtDataRegistrazione.Text),
                         IfThen(chkDefinizioneDataRegistrazione.Checked,'S','N'),
                         IfThen(chkRegistrazioneInserimenti.Checked,'S','N'),
                         IfThen(chkRegistrazioneCancellazioni.Checked,'S','N'),
                         IfThen(chkImpostaAssElab.Checked,'S','N'),
                         sCausaliSelezionate)
  else
    A105MW.Cancellazione(StrToDate(edtPeriodoDal.Text),
                         StrToDate(edtPeriodoAl.Text));
  SessioneOracle.Commit;
end;

function TWA105FStoricoGiustificativi.ElementoSuccessivo: Boolean;
begin
  grdC700.selAnagrafe.Next;
  Result:=not grdC700.selAnagrafe.EOF;
end;

procedure TWA105FStoricoGiustificativi.FineCicloElaborazione;
begin
  AggiornaAnagr;
end;

function TWA105FStoricoGiustificativi.ElaborazioneTerminata: String;
begin
  SessioneOracle.Commit;
  if Registra and chkEliminazioneAssenze.Checked then
  begin
    Result:='';
    Registra:=False;
    RipartiElaborazione:=True;
  end
  else
    Result:=inherited;
end;

end.
