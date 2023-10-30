unit WA047UDialogStampaFM;

interface

uses
  Winapi.Windows, ActiveX,Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR200UBaseFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompButton, meIWButton, IWCompLabel, meIWLabel,
  IWCompEdit, meIWEdit, IWCompCheckbox, meIWCheckBox, IWCompExtCtrls,
  meIWRadioGroup, IWAdvCheckGroup, meTIWAdvCheckGroup, A000USessione, C180FunzioniGenerali,
  meIWImageFile, medpIWImageButton, A000UMessaggi,
  A000UInterfaccia,medpIWMessageDlg, WC013UCheckListFM, Data.DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF} C190FUnzioniGeneraliWeb,
  A000UCostanti,Datasnap.Win.MConnect, Data.DB, Datasnap.DBClient,StrUtils,
  Vcl.Menus;

type
  TWA047FDialogStampaFM = class(TWR200FBaseFM)
    btnChiudi: TmeIWButton;
    lblDaData: TmeIWLabel;
    lblAData: TmeIWLabel;
    eDaData: TmeIWEdit;
    eAData: TmeIWEdit;
    chkDatiIndividuali: TmeIWCheckBox;
    chkDettaglioGiornaliero: TmeIWCheckBox;
    chkTotaliIndividuali: TmeIWCheckBox;
    chkSaltoPaginaIndividuale: TmeIWCheckBox;
    chkTimbraturePresenza: TmeIWCheckBox;
    chkTimbraturePresenzaCausalizzate: TmeIWCheckBox;
    chkGiustificativiAssenza: TmeIWCheckBox;
    chkAnomalie: TmeIWCheckBox;
    chkNominativi: TmeIWCheckBox;
    chkRilevatori: TmeIWCheckBox;
    chkCausale: TmeIWCheckBox;
    chkSaltoPagina: TmeIWCheckBox;
    rgpTipoStampa: TmeIWRadioGroup;
    lblTipoStampa: TmeIWLabel;
    chkDistinzioneCausale: TmeIWCheckBox;
    chkPranzoCena: TmeIWCheckBox;
    edtRaggr: TmeIWEdit;
    btnRaggr: TmeIWButton;
    chkSaltoPaginaRaggr: TmeIWCheckBox;
    btnGeneraPDF: TmedpIWImageButton;
    cgpOrologi: TmeTIWAdvCheckGroup;
    pmnAzioni: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    procedure btnChiudiClick(Sender: TObject);
    procedure chkDatiAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure rgpTipoStampaAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure btnGeneraPDFClick(Sender: TObject);
    procedure btnRaggrClick(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Deselezionatutto1Click(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
  private
    DataI, DataF: TDateTime;
    WC013: TWC013FCheckListFM;
    procedure AbilitazioneDatiIndividuali;
    procedure AbilComponentiDip(enab: boolean);
    procedure AbilComponentiGiorn(enab: boolean);
    procedure GetParametriFunzione;
    procedure AbilTipoStampa;
    procedure GetOrologi;
    procedure RaggrStampaResult(Sender: TObject; Result: Boolean);
    procedure PutParametriFunzione;
    procedure CheckAllOrologi(Val: Boolean);
  public
    procedure Visualizza(Data: TDateTime);
    function CreateJSonString: String;
  end;

implementation
uses WA047UTimbMensa;
{$R *.dfm}

procedure TWA047FDialogStampaFM.btnChiudiClick(Sender: TObject);
begin
  inherited;
  PutParametriFunzione;
  ReleaseOggetti;
  Free;
end;

procedure TWA047FDialogStampaFM.btnGeneraPDFClick(Sender: TObject);
begin
  inherited;
  if eDaData.Text = ''then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_MSG_DATA_INIZIO]),mtError,[mbOk],nil,'');
    exit;
  end;

  if not TryStrToDate(eDadATA.Text,DataI) then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_DATA_NON_VALIDA,[A000MSG_MSG_DATA_INIZIO]),mtError,[mbOk],nil,'');
    exit;
  end;

  if eAData.Text = ''then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_MSG_DATA_FINE]),mtError,[mbOk],nil,'');
    exit;
  end;

  if not TryStrToDate(eAData.Text,DataF) then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_DATA_NON_VALIDA,[A000MSG_MSG_DATA_FINE]),mtError,[mbOk],nil,'');
    exit;
  end;

  if DataI > DataF then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_PERIODO_ERRATO,mtError,[mbOk],nil,'');
    Exit;
  end;

  With (Self.Parent as TWA047FTimbMensa) do
  begin
    StartElaborazioneServer(btnGeneraPDF.HTMLName);
  end;
end;

procedure TWA047FDialogStampaFM.btnRaggrClick(Sender: TObject);
var
  LstCodRaggr,
  LstDescRaggr,
  LstRaggrSelezionati: TStringList;
begin
  WC013:=TWC013FCheckListFM.Create(Self.Owner);
  try
    LstCodRaggr:=TStringList.Create();
    LstDescRaggr:=TStringList.Create();
    With (Self.Parent as TWA047FTimbMensa).WA047FTimbMensaDM.A047FTimbMensaMW do
    begin
      SelI010.First;
      while not SelI010.Eof do
      begin
        LstCodRaggr.add(selI010.FieldByName('NOME_LOGICO').AsString);
        LstDescRaggr.add(selI010.FieldByName('NOME_LOGICO').AsString);
        SelI010.Next;
      end;
    end;

    WC013.CaricaLista(LstDescRaggr, LstCodRaggr);
  finally
    FreeAndNil(LstCodRaggr);
    FreeAndNil(LstDescRaggr);
  end;
  try
    LstRaggrSelezionati:=TStringList.Create;
    LstRaggrSelezionati.StrictDelimiter:=true;
    LstRaggrSelezionati.CommaText:=edtRaggr.Text;
    WC013.ImpostaValoriSelezionati(LstRaggrSelezionati);
  finally
    FreeAndNil(LstRaggrSelezionati);
  end;

  WC013.ResultEvent:=RaggrStampaResult;
  WC013.Visualizza(0,0,'<WC013> Raggruppamenti stampa');
end;

procedure TWA047FDialogStampaFM.RaggrStampaResult(Sender: TObject; Result: Boolean);
var lst: TStringList;
  s: String;
begin
  if Result then
  begin
    edtRaggr.Text:='';
    lst:=WC013.LeggiValoriSelezionati;
    for s in lst do
    begin
      if edtRaggr.Text <> '' then
        edtRaggr.Text:=edtRaggr.Text + ',';
      edtRaggr.Text:=edtRaggr.Text +  s;
    end;
    FreeAndNil(lst);
    AbilitazioneDatiIndividuali;
  end;
end;

procedure TWA047FDialogStampaFM.chkDatiAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  AbilitazioneDatiIndividuali;
end;

procedure TWA047FDialogStampaFM.rgpTipoStampaAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  AbilTipoStampa;
end;

procedure TWA047FDialogStampaFM.Selezionatutto1Click(Sender: TObject);
begin
  inherited;
  CheckAllOrologi(True);
end;

procedure TWA047FDialogStampaFM.CheckAllOrologi(Val: Boolean);
var
  i: Integer;
begin
  for i:=0 to cgpOrologi.Items.Count - 1 do
    cgpOrologi.IsChecked[i]:=Val;
  cgpOrologi.AsyncUpdate;
end;

procedure TWA047FDialogStampaFM.AbilTipoStampa;
begin
  AbilComponentiDip(rgpTipoStampa.ItemIndex = 0);
  AbilComponentiGiorn(rgpTipoStampa.ItemIndex = 1);

  if rgpTipoStampa.ItemIndex = 0 then
    AbilitazioneDatiIndividuali;
end;

procedure TWA047FDialogStampaFM.AbilComponentiGiorn(enab:boolean);
begin
  chkDistinzioneCausale.Enabled:=enab;
  chkPranzoCena.Enabled:=enab;
end;

procedure TWA047FDialogStampaFM.AbilComponentiDip(enab:boolean);
begin
  chkDatiIndividuali.Enabled:=enab;
  chkDettaglioGiornaliero.Enabled:=enab;
  chkTotaliIndividuali.Enabled:=enab;
  chkSaltoPaginaIndividuale.Enabled:=enab;
  chkTimbraturePresenza.Enabled:=enab;
  chkTimbraturePresenzaCausalizzate.Enabled:=enab;
  chkGiustificativiAssenza.Enabled:=enab;
  chkAnomalie.Enabled:=enab;
  chkNominativi.Enabled:=enab;
  chkRilevatori.Enabled:=enab;
  chkCausale.Enabled:=enab;
  chkSaltoPagina.Enabled:=enab;
  edtRaggr.Enabled:=enab;
  btnRaggr.Enabled:=enab;
  chkSaltoPaginaRaggr.Enabled:=enab;
end;

procedure TWA047FDialogStampaFM.Visualizza(Data:TDateTime);
begin
  inherited;
  edtRaggr.ReadOnly:=True;
  DataI:=R180InizioMese(Data);
  DataF:=R180InizioMese(Data);
  eDaData.Text:=DateToStr(DataI);
  eAData.Text:=DateToStr(DataF);

  TWA047FTimbMensa(Self.Parent).VisualizzaJQMessaggio(jQuery,500,455,455, 'Stampa','#'+Self.Name,False,True);
end;

procedure TWA047FDialogStampaFM.AbilitazioneDatiIndividuali;
begin
  chkDatiIndividuali.Enabled:=not chkNominativi.Checked;
  if not chkDatiIndividuali.Enabled then
    chkDatiIndividuali.Checked:=False;
  chkDettaglioGiornaliero.Enabled:=chkDatiIndividuali.Enabled;
  chkDettaglioGiornaliero.Checked:=chkDatiIndividuali.Checked;
  chkTotaliIndividuali.Enabled:=(chkDatiIndividuali.Checked) and not (chkRilevatori.Checked or chkCausale.Checked);
  if not chkTotaliIndividuali.Enabled then
    chkTotaliIndividuali.Checked:=False;
  chkSaltoPaginaIndividuale.Enabled:=(chkDatiIndividuali.Checked) and not (chkRilevatori.Checked or chkCausale.Checked)
                                     and (edtRaggr.Text = '');
  if not chkSaltoPaginaIndividuale.Enabled then
    chkSaltoPaginaIndividuale.Checked:=False;
  chkTimbraturePresenza.Enabled:=(chkDatiIndividuali.Checked) and not (chkRilevatori.Checked or chkCausale.Checked);
  if not chkTimbraturePresenza.Enabled then
    chkTimbraturePresenza.Checked:=False;
  chkTimbraturePresenzaCausalizzate.Enabled:=chkTimbraturePresenza.Checked;
  chkGiustificativiAssenza.Enabled:=(chkDatiIndividuali.Checked) and not (chkRilevatori.Checked or chkCausale.Checked);
  if not chkGiustificativiAssenza.Enabled then
    chkGiustificativiAssenza.Checked:=False;
  chkAnomalie.Enabled:=(chkDatiIndividuali.Checked) and not (chkRilevatori.Checked or chkCausale.Checked);
  if not chkAnomalie.Enabled then
    chkAnomalie.Checked:=False;

  chkNominativi.Enabled:=(not chkDatiIndividuali.Checked)(* and (High(MyCampiRaggr) < 0)*);
  if not chkNominativi.Enabled then
    chkNominativi.Checked:=False;
  chkSaltoPagina.Enabled:=chkNominativi.Checked or chkRilevatori.Checked or chkCausale.Checked;
  if not chkSaltoPagina.Enabled then
    chkSaltoPagina.Checked:=False;

  //edtRaggr.Enabled:=(not chkNominativi.Checked) and (not chkRilevatori.Checked) and (not chkCausale.Checked);
  btnRaggr.Enabled:=edtRaggr.Enabled;
  chkSaltoPaginaRaggr.Enabled:=edtRaggr.Enabled and (edtRaggr.Text <> '');
  if not chkSaltoPaginaRaggr.Enabled then
    chkSaltoPaginaRaggr.Checked:=False;
end;

procedure TWA047FDialogStampaFM.GetParametriFunzione;
begin
  with (Self.Parent as TWA047FTimbMensa).C004DM do
  begin
    rgpTipoStampa.ItemIndex:=StrToInt(GetParametro('TIPOSTAMPA','0'));
    chkDatiIndividuali.Checked:=GetParametro('DATIINDIVIDUALI','S') = 'S';
    chkDettaglioGiornaliero.Checked:=GetParametro('DETTAGLIOGIORNALIERO','S') = 'S';
    chkSaltoPaginaIndividuale.Checked:=GetParametro('SALTOPAGINAIND','N') = 'S';
    chkTimbraturePresenza.Checked:=GetParametro('TIMBRATUREPRESENZA','N') = 'S';
    chkTimbraturePresenzaCausalizzate.Checked:=GetParametro('TIMBRATUREPRESCAUS','N') = 'S';
    chkGiustificativiAssenza.Checked:=GetParametro('GIUSTIFICATIVI','N') = 'S';
    chkTotaliIndividuali.Checked:=GetParametro('TOTALIINDIVIDUALI','N') = 'S';
    chkNominativi.Checked:=GetParametro('NOMINATIVI','N') = 'S';
    chkRilevatori.Checked:=GetParametro('RILEVATORI','N') = 'S';
    chkCausale.Checked:=GetParametro('CAUSALE','N') = 'S';
    chkSaltoPagina.Checked:=GetParametro('SALTOPAGINA','N') = 'S';
    chkAnomalie.Checked:=GetParametro('ANOMALIE','N') = 'S';
    chkPranzoCena.Checked:=GetParametro('PRANZOCENA','N') = 'S';
    chkDistinzioneCausale.Checked:=GetParametro('DISTINZIONECAUSALE','N') = 'S';
    chkSaltoPaginaRaggr.Checked:=GetParametro('SALTOPAGINAGRUPPO','N') = 'S';
    edtRaggr.Text:=GetParametro(UpperCase(edtRaggr.Name),'');
    AbilTipoStampa;
    AbilitazioneDatiIndividuali;
  end;
end;

procedure TWA047FDialogStampaFM.PutParametriFunzione;
begin
  with (Self.Parent as TWA047FTimbMensa).C004DM do
  begin
    Cancella001;
    PutParametro('TIPOSTAMPA',IntToStr(rgpTipoStampa.ItemIndex));
    PutParametro('DATIINDIVIDUALI',IfThen(chkDatiIndividuali.Checked,'S','N'));
    PutParametro('DETTAGLIOGIORNALIERO',IfThen(chkDettaglioGiornaliero.Checked,'S','N'));
    PutParametro('SALTOPAGINAIND',IfThen(chkSaltoPaginaIndividuale.Checked,'S','N'));
    PutParametro('TIMBRATUREPRESENZA',IfThen(chkTimbraturePresenza.Checked,'S','N'));
    PutParametro('TIMBRATUREPRESCAUS',IfThen(chkTimbraturePresenzaCausalizzate.Checked,'S','N'));
    PutParametro('GIUSTIFICATIVI',IfThen(chkGiustificativiAssenza.Checked,'S','N'));
    PutParametro('TOTALIINDIVIDUALI',IfThen(chkTotaliIndividuali.Checked,'S','N'));
    PutParametro('NOMINATIVI',IfThen(chkNominativi.Checked,'S','N'));
    PutParametro('RILEVATORI',IfThen(chkRilevatori.Checked,'S','N'));
    PutParametro('CAUSALE',IfThen(chkCausale.Checked,'S','N'));
    PutParametro('SALTOPAGINA',IfThen(chkSaltoPagina.Checked,'S','N'));
    PutParametro('ANOMALIE',IfThen(chkAnomalie.Checked,'S','N'));
    PutParametro('PRANZOCENA',IfThen(chkPranzoCena.Checked,'S','N'));
    PutParametro('DISTINZIONECAUSALE',IfThen(chkDistinzioneCausale.Checked,'S','N'));
    PutParametro('SALTOPAGINAGRUPPO',IfThen(chkSaltoPaginaRaggr.Checked,'S','N'));
    PutParametro(UpperCase(edtRaggr.Name),edtRaggr.Text);
    try SessioneOracle.Commit; except end;
    selT001.Refresh;
  end;
end;

procedure TWA047FDialogStampaFM.Invertiselezione1Click(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  for i:=0 to cgpOrologi.Items.Count - 1 do
    cgpOrologi.IsChecked[i]:=not cgpOrologi.IsChecked[i];
  cgpOrologi.AsyncUpdate;
end;

procedure TWA047FDialogStampaFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  GetOrologi;
  GetParametriFunzione;
end;

procedure TWA047FDialogStampaFM.GetOrologi;
begin
  cgpOrologi.Items.Clear;
  with (Self.Parent as TWA047FTimbMensa).WA047FTimbMensaDM.A047FTimbMensaMW.QOrologi do
  begin
    First;
    while not Eof do
    begin
      if A000FiltroDizionario('OROLOGI DI TIMBRATURA',FieldByName('CODICE').AsString) then
        cgpOrologi.Items.Add(Format('%-2s %s',[FieldByName('Codice').AsString,FieldByName('Descrizione').AsString]));
      Next;
    end;
  end;
end;

function TWA047FDialogStampaFM.CreateJSonString: String;
var json: TJSONObject;
    s: TJSONString;
begin
  try
  
    json:=TJSONObject.Create;

    //Popolo il json con i valori necessari al B028 per creare il PDF per la stampa
    json.AddPair('StandardPrinter',IfThen(Pos(INI_PAR_USE_STANDARD_PRINTER,W000ParConfig.ParametriAvanzati) > 0,'S','N'));
    C190Comp2JsonString(eDaData,json);
    C190Comp2JsonString(eAData,json);
    C190Comp2JsonString(rgpTipoStampa,json);
    C190Comp2JsonString(chkDatiIndividuali,json);
    C190Comp2JsonString(chkDettaglioGiornaliero,json);
    C190Comp2JsonString(chkTotaliIndividuali,json);
    C190Comp2JsonString(chkSaltoPaginaIndividuale,json);
    C190Comp2JsonString(chkTimbraturePresenza,json);
    C190Comp2JsonString(chkTimbraturePresenzaCausalizzate,json);
    C190Comp2JsonString(chkGiustificativiAssenza,json);
    C190Comp2JsonString(chkAnomalie,json);
    C190Comp2JsonString(chkNominativi,json);
    C190Comp2JsonString(chkRilevatori,json);
    C190Comp2JsonString(chkCausale,json);
    C190Comp2JsonString(chkSaltoPagina,json);

    C190Comp2JsonString(chkDistinzioneCausale,json);
    C190Comp2JsonString(chkPranzoCena,json);

    C190Comp2JsonString(edtRaggr,json);
    C190Comp2JsonString(chkSaltoPaginaRaggr,json);

    s:=TJSONString.Create(C190GetCheckList(2,cgpOrologi));
    json.AddPair('LstOrologi',s); 

    Result:=json.ToString;
  finally
    FreeAndNil(json);
  end;
end;
procedure TWA047FDialogStampaFM.Deselezionatutto1Click(Sender: TObject);
begin
  inherited;
  CheckAllOrologi(False);
end;

end.
