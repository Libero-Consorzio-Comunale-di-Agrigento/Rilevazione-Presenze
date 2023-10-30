unit WA061UDettAssenze;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR100UBase, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWApplication,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl,OracleData,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, medpIWC700NavigatorBar, IWCompEdit,
  meIWEdit, IWCompLabel, meIWLabel, IWCompCheckbox, meIWCheckBox, meIWRadioGroup, medpIWMultiColumnComboBox,
  IWCompTreeview, meIWTreeView, meIWImageFile, medpIWImageButton, IWDBStdCtrls, meIWDBLabel,
  A000USessione,A000UInterfaccia,A061UDettAssenzeMW,C180FunzioniGenerali,DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF}
  C190FunzioniGeneraliWeb, DB, DBClient, MConnect, IWAdvCheckGroup, meTIWAdvCheckGroup, Menus, IWCompListbox,
  meIWDBLookupComboBox, A000UMessaggi, A000UCostanti, ActiveX, C004UParamForm, Generics.Collections,
  WC015USelEditGridFM, medpIWMessageDlg;

type
  TWA061FDettAssenze = class(TWR100FBase)
    lblDaData: TmeIWLabel;
    edtDaData: TmeIWEdit;
    lblAData: TmeIWLabel;
    edtAData: TmeIWEdit;
    chkSoloAssRegSucc: TmeIWCheckBox;
    lblRegStamp: TmeIWLabel;
    lblDaRegStamp: TmeIWLabel;
    edtDaRegStamp: TmeIWEdit;
    lblARegStamp: TmeIWLabel;
    edtARegStamp: TmeIWEdit;
    chkSalvaUltRegStamp: TmeIWCheckBox;
    lblAssenzeConsiderate: TmeIWLabel;
    rgpAssenzeConsiderate: TmeIWRadioGroup;
    lblDati: TmeIWLabel;
    chkDatiIndividuali: TmeIWCheckBox;
    chkStampaNominativo: TmeIWCheckBox;
    chkStampaMatricola: TmeIWCheckBox;
    chkStampaBadge: TmeIWCheckBox;
    chkDettGiorn: TmeIWCheckBox;
    chkDettPer: TmeIWCheckBox;
    rgpOrdinamento: TmeIWRadioGroup;
    lblOrdinamento: TmeIWLabel;
    lblCampo: TmeIWLabel;
    chkSaltoPagRaggrup: TmeIWCheckBox;
    chkSaltoPagIndividuale: TmeIWCheckBox;
    lblValidate: TmeIWLabel;
    rgpValidate: TmeIWRadioGroup;
    lblConteggi: TmeIWLabel;
    chkConiuge: TmeIWCheckBox;
    chkRiduzioni: TmeIWCheckBox;
    chkSoloRiduzioni: TmeIWCheckBox;
    chkConteggiGG: TmeIWCheckBox;
    chkGiorniSignificativi: TmeIWCheckBox;
    lblGGMinCont: TmeIWLabel;
    edtGGMinCont: TmeIWEdit;
    chkCausaliCumulate: TmeIWCheckBox;
    chkPeriodoServizio: TmeIWCheckBox;
    lblTotali: TmeIWLabel;
    chkTotIndividuali: TmeIWCheckBox;
    chkTotFam: TmeIWCheckBox;
    chkTotRaggrup: TmeIWCheckBox;
    chkTotGenerali: TmeIWCheckBox;
    cmbTipoAcc: TMedpIWMultiColumnComboBox;
    lblCodAcc: TmeIWLabel;
    lblCodCau: TmeIWLabel;
    btnGeneraPDF: TmedpIWImageButton;
    DCOMConnection: TDCOMConnection;
    lstCodAcc: TmeTIWAdvCheckGroup;
    LstCausali: TmeTIWAdvCheckGroup;
    pmnAzioniCodAccorp: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    pmnAzioniCodCausali: TPopupMenu;
    SelezionaTutto2: TMenuItem;
    DeselezionaTutto2: TMenuItem;
    InvertiSelezione2: TMenuItem;
    lnkTipoAcc: TmeIWLink;
    cmbCampo: TMedpIWMultiColumnComboBox;
    lblTipoAcc: TmeIWLabel;
    btnVisStampa: TmedpIWImageButton;
    chkStampaDatiAnagrafici: TmeIWCheckBox;
    procedure IWAppFormCreate(Sender: TObject);
    procedure cmbTipoAccChange(Sender: TObject; Index: Integer);
    procedure chkDatiIndividualiAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure chkDettGiornAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure chkDettPerAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure chkTotIndividualiAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure btnGeneraPDFClick(Sender: TObject);
    procedure lstCodAccAsyncItemClick(Sender: TObject; EventParams: TStringList; Index: Integer);
    procedure LstCausaliAsyncItemClick(Sender: TObject; EventParams: TStringList; Index: Integer);
    procedure pmnAzioniCodAccorpClick(Sender: TObject);
    procedure InvertiSelezione2Click(Sender: TObject);
    procedure chkSoloAssRegSuccClick(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure cmbCampoChange(Sender: TObject; Index: Integer);
    procedure edtADataAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
    procedure lnkTipoAccClick(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure edtDaDataAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure edtADataAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure edtDaRegStampAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure edtARegStampAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure btnVisStampaClick(Sender: TObject);
    procedure chkStampaDatiAnagraficiAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure chkStampaNominativoAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure chkStampaMatricolaAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure chkStampaBadgeAsyncClick(Sender: TObject; EventParams: TStringList);
  private
    A061MW: TA061FDettAssenzaMW;
    WC015:TWC015FSelEditGridFM;
    DaData,AData,DataNas,DaRegStamp,ARegStamp:TDateTime;
    CampoRagg,NomeCampo,ElencoCausali,OldCausale,Coniuge,DCOMNomeFile:String;
    NumFamiliari:Word;
    SelTutto,SelAcc:Boolean;
    FElabSenderHTMLName: String;
    procedure ConvChkLstToLst(MyLista:TList<TRecCodDesc>);
    procedure CaricaListaAccorpamenti;
    procedure CaricaListaCausali;
    procedure GetParametriFunzione;
    procedure CaricaComboBox;
    procedure AbilitaAccorpamenti;
    procedure AbilitaAss;
    procedure ImpostaVariabiliA061MW;
    procedure CallDCOMPrinter;
    procedure PutParametriFunzione;
    procedure VisualizzaGruppoComponenti(Id: String; Visualizza: Boolean);
    function CreateJSonString: String;
    procedure ResultTotFruizioniConiuge(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure EseguiStampa;
  protected
    procedure WC700AperturaSelezione(Sender: Tobject); override;
    procedure InizializzaMsgElaborazione; override;
    function ElementoSuccessivo:boolean; override;
    procedure ImpostazioniWC700; override;
    procedure InizioElaborazione; override;
    procedure ElaboraElemento; override;
    function TotalRecordsElaborazione: Integer; override;
    procedure AfterElaborazione; override;
  end;

implementation

{$R *.dfm}

procedure TWA061FDettAssenze.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  AttivaGestioneC700;
  A061MW:=TA061FDettAssenzaMW.Create(Self);
  A061MW.SelAnagrafe:=grdC700.selAnagrafe;
  DaData:=R180InizioMese(Parametri.DataLavoro);
  AData:=R180FineMese(Parametri.DataLavoro);
  edtDaData.Text:=FormatDateTime('dd/mm/yyyy',DaData);
  edtAData.Text:=FormatDateTime('dd/mm/yyyy',AData);

  CaricaComboBox;
  CaricaListaAccorpamenti; //necessario per avere la lista completa
  GetParametriFunzione;

  CaricaListaAccorpamenti; //necessario per aggiornare i dati dopo il caricamento dei parametri
  AbilitaAss;
  AbilitaAccorpamenti;
end;

procedure TWA061FDettAssenze.ConvChkLstToLst(MyLista:TList<TRecCodDesc>);
var
  i:integer;
  TempRec:TRecCodDesc;
begin
  MyLista.Clear;
  for i:=0 to LstCausali.Items.Count - 1 do
    if LstCausali.isChecked[i] then
    begin
      TempRec.Codice:=Trim(Copy(LstCausali.Items[i],1,5));
      TempRec.Descrizione:=Trim(Copy(LstCausali.Items[i],7,40));
      MyLista.Add(TempRec);
    end;
end;

procedure TWA061FDettAssenze.ImpostaVariabiliA061MW;
begin
  A061MW.PeriodoServizioChecked:=chkPeriodoServizio.Checked;
  A061MW.SoloAssRegSuccChecked:=chkSoloAssRegSucc.Checked;
  A061MW.DettGiornChecked:=chkDettGiorn.Checked;
  A061MW.RiduzioniChecked:=chkRiduzioni.Checked;
  A061MW.SoloRiduzioniChecked:=chkSoloRiduzioni.Checked;
  A061MW.ConteggiGGChecked:=chkConteggiGG.Checked;
  A061MW.GiorniSignificativiChecked:=ChkGiorniSignificativi.Checked;
  A061MW.CausaliCumulateChecked:=ChkCausaliCumulate.Checked;
  A061MW.ConiugeChecked:=chkConiuge.Checked;
  A061MW.AssenzeConsiderateItemIndex:=RgpAssenzeConsiderate.ItemIndex;
  A061MW.ValidateItemIndex:=RgpValidate.ItemIndex;
  A061MW.OrdinamentoItemIndex:=RgpOrdinamento.ItemIndex;
  A061MW.DaRegStamp:=DaRegStamp;
  A061MW.ARegStamp:=ARegStamp;
  A061MW.GGMinCont:=edtGGMinCont.Text;
  A061MW.CampoRagg:=CampoRagg;
  A061MW.StampaDatiAnagrafici:=chkStampaDatiAnagrafici.Checked;
  A061MW.StampaNominativo:=chkStampaNominativo.Checked;
  A061MW.StampaMatricola:=chkStampaMatricola.Checked;
  A061MW.StampaBadge:=chkStampaBadge.Checked;
end;

function TWA061FDettAssenze.ElementoSuccessivo:boolean;
begin
  grdC700.selAnagrafe.Next;
  Result:=not grdC700.selAnagrafe.Eof;
end;

function TWA061FDettAssenze.TotalRecordsElaborazione: Integer;
begin
  Result:=grdC700.selAnagrafe.RecordCount;
end;

procedure TWA061FDettAssenze.ElaboraElemento;
var
  GGMinCont: String;
begin
  //PeriodoConteggi(DaData,AData);  Commentato già prima di MW
  GGMinCont:=edtGGMinCont.Text;
  if chkConteggiGG.Checked then
    A061MW.R502ProDtM1.PeriodoConteggi(DaData,AData);
  //ImpostaVariabiliA061MW;
  grdC700.WC700FM.C700ValuesDatiVisualizzati(A061MW.ValuesDatiAnagrafici);
  //A061MW.DatiAnagrafici:=grdC700.WC700FM.C700ValueDatiVisualizzati(True).Replace('Cognome: ','').Replace('Nome: ', '');
  A061MW.ImpostaQueryGiustificativi(DaData,AData);
end;

procedure TWA061FDettAssenze.InizioElaborazione;
var
  App, S:string;
begin
  App:=cmbCampo.Text;
  if not App.IsEmpty then
  begin
    NomeCampo:=cmbCampo.Items[cmbCampo.ItemIndex].RowData[1];
    CampoRagg:=App;
    S:=grdC700.SelAnagrafe.SQL.Text;
    if R180InserisciColonna(S,App) then
    begin
      grdC700.SelAnagrafe.Close;
      grdC700.SelAnagrafe.SQL.Text:=S;
    end;
  end;
  if not chkSoloAssRegSucc.Checked then
  begin
    if grdC700.WC700FM.C700SettaPeriodoSelAnagrafe(DaData,AData) then
      grdC700.SelAnagrafe.Close;
  end
  else
  begin
    if grdC700.WC700FM.C700SettaPeriodoSelAnagrafe(DaRegStamp,ARegStamp) then
      grdC700.SelAnagrafe.Close;
  end;
  grdC700.SelAnagrafe.Open;
  grdC700.SelAnagrafe.First;
  ImpostaVariabiliA061MW;
  A061MW.StructDatiAnagrafici.Clear;
  if A061MW.StampaDatiAnagrafici then
    grdC700.WC700FM.C700StructDatiVisualizzati(A061MW.StructDatiAnagrafici);
  A061MW.CreaTabellaStampa;
  A061MW.CreaSqlGiustificativi(ElencoCausali);
end;

procedure TWA061FDettAssenze.AfterElaborazione;
begin
  inherited;
  if FElabSenderHTMLName = btnVisStampa.HTMLName then
  begin
    WC015:=TWC015FSelEditGridFM.Create(Self);
    WC015.Visualizza('Dettaglio assenze individuali',A061MW.TabellaStampa,False,False,False,1000);
  end;
end;

procedure TWA061FDettAssenze.InizializzaMsgElaborazione;
begin
  if FElabSenderHTMLName = btnGeneraPDF.HTMLName then
  begin
    WC022FMsgElaborazioneFM.Messaggio:=A000MSG_MSG_ELABORAZIONE_PDF_IN_CORSO;
    WC022FMsgElaborazioneFM.Titolo:=A000MSG_MSG_ELABORAZIONE;
    WC022FMsgElaborazioneFM.ImgFileName:=WC022FMsgElaborazioneFM.IMG_FILENAME_PDF;
  end
  else
  begin
    WC022FMsgElaborazioneFM.Messaggio:=A000MSG_MSG_ELABORAZIONE_IN_CORSO;
    WC022FMsgElaborazioneFM.Titolo:=A000MSG_MSG_ELABORAZIONE;
    WC022FMsgElaborazioneFM.ImgFileName:=WC022FMsgElaborazioneFM.IMG_FILENAME_ELABORAZIONE;
  end;
end;

procedure TWA061FDettAssenze.WC700AperturaSelezione(Sender: Tobject);
begin
  if chkSoloAssRegSucc.Checked then
  begin
    grdC700.WC700FM.C700DataDal:=DARegStamp;
    grdC700.WC700FM.C700DataLavoro:=ARegStamp;
  end
  else
  begin
    grdC700.WC700FM.C700DataDal:=DaData;
    grdC700.WC700FM.C700DataLavoro:=AData;
  end;
end;

procedure TWA061FDettAssenze.IWAppFormDestroy(Sender: TObject);
begin
  PutParametriFunzione;
  if chkSalvaUltRegStamp.Checked then
  begin
    //Memorizzo sulla tabella di log se c'é stata memorizzazione della data di ultima registrazione stampata
    RegistraLog.SettaProprieta('M','T044_STORICOGIUSTIFICATIVI',Copy(Self.Name,1,5),nil,True);
    RegistraLog.InserisciDato(' DATA ULTIMA REGISTRAZIONE STAMPATA ','',Format('%s',[DateToStr(ARegStamp)]));
    RegistraLog.RegistraOperazione;
  end;
  inherited;
end;

procedure TWA061FDettAssenze.IWAppFormRender(Sender: TObject);
begin
  inherited;
  AbilitaAss;
  AbilitaAccorpamenti;
end;

procedure TWA061FDettAssenze.pmnAzioniCodAccorpClick(Sender: TObject);
var i:Integer;
begin
  with (pmnAzioniCodAccorp.PopupComponent as TmeTIWAdvCheckGroup) do
    for i:=0 to Items.Count - 1 do
      if Sender = SelezionaTutto1 then
        IsChecked[i]:=True
      else if Sender = DeselezionaTutto1 then
        IsChecked[i]:=False
      else if Sender = InvertiSelezione1 then
        IsChecked[i]:=not IsChecked[i];
  SelTutto:=True;
  CaricaListaCausali;
end;

procedure TWA061FDettAssenze.InvertiSelezione2Click(Sender: TObject);
var i:Integer;
begin
  with (pmnAzioniCodCausali.PopupComponent as TmeTIWAdvCheckGroup) do
    for i:=0 to Items.Count - 1 do
      if Sender = SelezionaTutto2 then
        IsChecked[i]:=True
      else if Sender = DeselezionaTutto2 then
        IsChecked[i]:=False
      else if Sender = InvertiSelezione2 then
        IsChecked[i]:=not IsChecked[i];
  AbilitaAss;
end;

procedure TWA061FDettAssenze.lnkTipoAccClick(Sender: TObject);
begin
  //WA150 Accorpamento causali
  AccediForm(196,'CODICE=' + cmbTipoAcc.Text);
  A061MW.selT255.Refresh;
  AbilitaAccorpamenti;
  SelTutto:=False;
  CaricaListaAccorpamenti;
end;

procedure TWA061FDettAssenze.LstCausaliAsyncItemClick(Sender: TObject; EventParams: TStringList; Index: Integer);
begin
  AbilitaAss;
end;

procedure TWA061FDettAssenze.lstCodAccAsyncItemClick(Sender: TObject; EventParams: TStringList; Index: Integer);
begin
  SelAcc:=lstCodAcc.IsChecked[Index];
  CaricaListaCausali;
end;

procedure TWA061FDettAssenze.AbilitaAss;
var i:Integer;
begin
  rgpValidate.Enabled:=False;
  for i:=0 to LstCausali.Items.Count - 1 do
    if LstCausali.IsChecked[i] then
      if VarToStr(A061MW.Q265.Lookup('CODICE',Trim(Copy(LstCausali.Items[i],1,5)),'VALIDAZIONE')) = 'S' then
        rgpValidate.Enabled:=True;
  if Not rgpValidate.Enabled then
    rgpValidate.ItemIndex:=2;
end;

procedure TWA061FDettAssenze.CaricaComboBox;
begin
  with A061MW.selT255 do
  begin
    Close;
    Open;
    First;
    while not Eof do
    begin
      cmbTipoAcc.AddRow(FieldByName('cod_tipoaccorpcausali').AsString+';'+FieldByName('descrizione').AsString);
      Next;
    end;
    First;
    cmbTipoAcc.Text:=FieldByName('cod_tipoaccorpcausali').AsString;
  end;
  with A061MW.selI010 do
  begin
    First;
    while not Eof do
    begin
      cmbCampo.AddRow(FieldByName('NOME_CAMPO').AsString+';'+FieldByName('NOME_LOGICO').AsString);
      Next;
    end;
    First;
    cmbCampo.Text:=FieldByName('NOME_CAMPO').AsString;
  end;
end;

procedure TWA061FDettAssenze.CaricaListaAccorpamenti;
var S:String;
    i:Integer;
begin
  S:=',';
  for i:=0 to lstCodAcc.Items.Count - 1 do
    if lstCodAcc.IsChecked[i] then
      S:=S + Copy(lstCodAcc.Items[i],1,5) + ',';

  lstCodAcc.Items.Clear;
  with A061MW.selT256 do
  begin
    Close;
    SetVariable('TIPO_ACC',VarToStr(cmbTipoAcc.Text));
    Open;
    First;
    while not Eof do
    begin
      lstCodAcc.Items.add(Format('%-5s %s',[FieldByName('Cod_codiciaccorpcausali').AsString,FieldByName('Descrizione').AsString]));
      Next;
    end;
  end;
  for i:=0 to lstCodAcc.Items.Count - 1 do
    if SelTutto or (Pos(',' + Copy(lstCodAcc.Items[i],1,5) + ',',S) > 0) then
      lstCodAcc.IsChecked[i]:=True;
  CaricaListaCausali;
end;

procedure TWA061FDettAssenze.CaricaListaCausali;
var S,S2,C:String;
    i:Integer;
    Valori: TStringList;
begin
  S:=',';
  for i:=0 to LstCausali.Items.Count - 1 do
    if LstCausali.IsChecked[i] then
      S:=S + Copy(LstCausali.Items[i],1,5) + ',';
  S2:=',';
  for i:=0 to LstCausali.Items.Count - 1 do
    S2:=S2 + Copy(LstCausali.Items[i],1,5) + ',';
  LstCausali.Items.Clear;
  Valori:= TStringList.Create;
  try
    with A061MW.Q265 do
    begin
      Close;
      SetVariable('TIPO_ACC',VarToStr(cmbTipoAcc.Text));
      for i:=0 to lstCodAcc.Items.Count - 1 do
        if lstCodAcc.IsChecked[i] then
          C:=C + IfThen(C <> '',',') + '''' + Trim(Copy(lstCodAcc.Items[i],1,5)) + '''';
      SetVariable('COD_ACC',IfThen(C <> '',C,''''''));
      Open;
      First;
      while not Eof do
      begin
        Valori.Add(Format('%-5s %s',[FieldByName('Codice').AsString,FieldByName('Descrizione').AsString]));
        Next;
      end;
      LstCausali.Items.Assign(Valori);
    end;
  finally
    FreeAndNil(Valori);
  end;
  for i:=0 to LstCausali.Items.Count - 1 do
    if SelTutto
    or (Pos(',' + Copy(LstCausali.Items[i],1,5) + ',',S) > 0)
    or (SelAcc and (Pos(',' + Copy(LstCausali.Items[i],1,5) + ',',S2) = 0)) then
      LstCausali.IsChecked[i]:=True;
  SelTutto:=False;
  SelAcc:=False;
  AbilitaAss;

  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[lstCausali.HTMLName]));
end;

procedure TWA061FDettAssenze.chkDatiIndividualiAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  chkTotIndividuali.Enabled:=chkDatiIndividuali.Checked;
  chkSaltoPagIndividuale.Enabled:=chkDatiIndividuali.Checked;
  chkConiuge.Enabled:=chkDatiIndividuali.Checked;
  chkTotFam.Enabled:=chkDatiIndividuali.Checked;
  ChkRiduzioni.Enabled:=chkDatiIndividuali.Checked;
  ChkSoloRiduzioni.Enabled:=chkDatiIndividuali.Checked;
  chkStampaDatiAnagrafici.Enabled:=chkDatiIndividuali.Checked;
  chkStampaNominativo.Enabled:=chkDatiIndividuali.Checked;
  chkStampaMatricola.Enabled:=chkDatiIndividuali.Checked;
  chkStampaBadge.Enabled:=chkDatiIndividuali.Checked;
  if not chkDatiIndividuali.Checked then
  begin
    ChkRiduzioni.Checked:=False;
    ChkSoloRiduzioni.Checked:=False;
    chkTotIndividuali.Checked:=False;
    chkSaltoPagIndividuale.Checked:=False;
    chkConiuge.Checked:=False;
    chkTotFam.Checked:=False;
  end;
  chkConteggiGG.Enabled:=(chkDatiIndividuali.Checked) and (not chkSoloAssRegSucc.Checked);
  if not chkConteggiGG.Enabled then
    chkConteggiGG.Checked:=False;
  chkDettGiorn.Enabled:=(chkDatiIndividuali.Checked);
  if not chkDettGiorn.Enabled then
    chkDettGiorn.Checked:=False;
  chkDettPer.Enabled:=(chkDatiIndividuali.Checked);
  if not chkDettPer.Enabled then
    chkDettPer.Checked:=False;
  chkGiorniSignificativi.Enabled:=chkDettPer.Checked;
  if not chkGiorniSignificativi.Enabled then
    chkGiorniSignificativi.Checked:=False;
  edtGGMinCont.Enabled:=chkDettPer.Checked;
  if not edtGGMinCont.Enabled then
    edtGGMinCont.Text:='';
  lblGGMinCont.Enabled:=chkDettPer.Checked;
  chkCausaliCumulate.Enabled:=chkDettPer.Checked;
  if not chkCausaliCumulate.Enabled then
    chkCausaliCumulate.Checked:=False;
  ChkSoloRiduzioni.Enabled:=ChkRiduzioni.Checked;
  if not ChkRiduzioni.Checked then
    ChkSoloRiduzioni.Checked:=False;
  chkTotFam.Enabled:=chkTotIndividuali.Checked;
  if not chkTotFam.Enabled then
    chkTotFam.Checked:=False;
end;

procedure TWA061FDettAssenze.chkDettGiornAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  if chkDettGiorn.Checked then
    chkDettPer.Checked:=False;
  chkTotIndividualiAsyncClick(nil,nil);
end;

procedure TWA061FDettAssenze.chkDettPerAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  if chkDettPer.Checked then
    chkDettGiorn.Checked:=False;
  chkTotIndividualiAsyncClick(nil,nil);
end;

procedure TWA061FDettAssenze.chkSoloAssRegSuccClick(Sender: TObject);
begin
  rgpAssenzeConsiderate.Enabled:=chkSoloAssRegSucc.Checked;
  lblDaData.Enabled:=not chkSoloAssRegSucc.Checked;
  edtDaData.Enabled:=not chkSoloAssRegSucc.Checked;
  lblAData.Enabled:=not chkSoloAssRegSucc.Checked;
  edtAData.Enabled:=not chkSoloAssRegSucc.Checked;
  chkConteggiGG.Enabled:=not chkSoloAssRegSucc.Checked;
  if not chkConteggiGG.Enabled then
    chkConteggiGG.Checked:=False;
  lblDaRegStamp.Enabled:=chkSoloAssRegSucc.Checked;
  edtDaRegStamp.Enabled:=chkSoloAssRegSucc.Checked;
  lblARegStamp.Enabled:=chkSoloAssRegSucc.Checked;
  edtARegStamp.Enabled:=chkSoloAssRegSucc.Checked;
  chkSalvaUltRegStamp.Enabled:=chkSoloAssRegSucc.Checked;
//chkConiuge.Enabled:=not(chkSoloAssRegSucc.Checked);   Commento presente già prima di MW
end;

procedure TWA061FDettAssenze.chkStampaBadgeAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  if chkStampaBadge.Checked then
    chkStampaDatiAnagrafici.Checked:=False;
end;

procedure TWA061FDettAssenze.chkStampaDatiAnagraficiAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  if chkStampaDatiAnagrafici.Checked then
  begin
    chkStampaNominativo.Checked:=False;
    chkStampaMatricola.Checked:=False;
    chkStampaBadge.Checked:=False;
  end;
end;

procedure TWA061FDettAssenze.chkStampaMatricolaAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  if chkStampaMatricola.Checked then
    chkStampaDatiAnagrafici.Checked:=False;
end;

procedure TWA061FDettAssenze.chkStampaNominativoAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  if chkStampaNominativo.Checked then
    chkStampaDatiAnagrafici.Checked:=False;
end;

procedure TWA061FDettAssenze.chkTotIndividualiAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  chkTotIndividuali.Enabled:=chkDatiIndividuali.Checked;
  chkSaltoPagIndividuale.Enabled:=chkDatiIndividuali.Checked;
  chkConiuge.Enabled:=chkDatiIndividuali.Checked;
  chkTotFam.Enabled:=chkDatiIndividuali.Checked;
  ChkRiduzioni.Enabled:=chkDatiIndividuali.Checked;
  ChkSoloRiduzioni.Enabled:=chkDatiIndividuali.Checked;
  chkStampaNominativo.Enabled:=chkDatiIndividuali.Checked;
  chkStampaMatricola.Enabled:=chkDatiIndividuali.Checked;
  chkStampaBadge.Enabled:=chkDatiIndividuali.Checked;
  if not chkDatiIndividuali.Checked then
  begin
    ChkRiduzioni.Checked:=False;
    ChkSoloRiduzioni.Checked:=False;
    chkTotIndividuali.Checked:=False;
    chkSaltoPagIndividuale.Checked:=False;
    chkConiuge.Checked:=False;
    chkTotFam.Checked:=False;
  end;
  chkConteggiGG.Enabled:=(chkDatiIndividuali.Checked) and (not chkSoloAssRegSucc.Checked);
  if not chkConteggiGG.Enabled then
    chkConteggiGG.Checked:=False;
  chkDettGiorn.Enabled:=(chkDatiIndividuali.Checked);
  if not chkDettGiorn.Enabled then
    chkDettGiorn.Checked:=False;
  chkDettPer.Enabled:=(chkDatiIndividuali.Checked);
  if not chkDettPer.Enabled then
    chkDettPer.Checked:=False;
  chkGiorniSignificativi.Enabled:=chkDettPer.Checked;
  if not chkGiorniSignificativi.Enabled then
    chkGiorniSignificativi.Checked:=False;
  edtGGMinCont.Enabled:=chkDettPer.Checked;
  if not edtGGMinCont.Enabled then
    edtGGMinCont.Text:='';
  lblGGMinCont.Enabled:=chkDettPer.Checked;
  chkCausaliCumulate.Enabled:=chkDettPer.Checked;
  if not chkCausaliCumulate.Enabled then
    chkCausaliCumulate.Checked:=False;
  ChkSoloRiduzioni.Enabled:=ChkRiduzioni.Checked;
  if not ChkRiduzioni.Checked then
    ChkSoloRiduzioni.Checked:=False;
  chkTotFam.Enabled:=chkTotIndividuali.Checked;
  if not chkTotFam.Enabled then
    chkTotFam.Checked:=False;
end;

procedure TWA061FDettAssenze.cmbCampoChange(Sender: TObject; Index: Integer);
begin
  if cmbCampo.Text = '' then
  begin
    //dcmbCampo.KeyValue:=null;
    chkTotRaggrup.Enabled:=False;
    chkTotRaggrup.Checked:=False;
    chkSaltoPagRaggrup.Enabled:=False;
    chkSaltoPagRaggrup.Checked:=False;
  end
  else
  begin
    chkTotRaggrup.Enabled:=True;
    chkSaltoPagRaggrup.Enabled:=True;
  end;
end;

procedure TWA061FDettAssenze.cmbTipoAccChange(Sender: TObject; Index: Integer);
begin
  inherited;
  A061MW.selT255.SearchRecord('cod_tipoaccorpcausali',cmbTipoAcc.Text,[srFromBeginning]);
  AbilitaAccorpamenti;
  CaricaListaAccorpamenti;
end;

procedure TWA061FDettAssenze.edtADataAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  if not TryStrToDate(edtAData.Text,AData) then
    AData:=DATE_NULL;
end;

procedure TWA061FDettAssenze.edtADataAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
begin
  edtAData.Text:=DateToStr(R180FineMese(StrToDate(edtDaData.Text)));
end;

procedure TWA061FDettAssenze.edtARegStampAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  if not TryStrToDate(edtARegStamp.Text,ARegStamp) then
    ARegStamp:=DATE_NULL;
end;

procedure TWA061FDettAssenze.edtDaDataAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  if not TryStrToDate(edtDaData.Text,DaData) then
    DaData:=DATE_NULL;
end;

procedure TWA061FDettAssenze.edtDaRegStampAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin

  if not TryStrToDate(edtDaRegStamp.Text,DaRegStamp) then
    DaRegStamp:=DATE_NULL;
end;

procedure TWA061FDettAssenze.AbilitaAccorpamenti;
begin
  lstCodAcc.Visible:=cmbTipoAcc.Text <> '';
  lblCodAcc.Visible:=cmbTipoAcc.Text <> '';
  VisualizzaGruppoComponenti('lstCodAcc',lstCodAcc.Visible);
  lblTipoAcc.Visible:=cmbTipoAcc.Text <> '';
  if lblTipoAcc.Visible then
    lblTipoAcc.Text:=VarToStr(A061MW.selT255.Lookup('cod_tipoaccorpcausali',cmbTipoAcc.Text,'DESCRIZIONE'));
  SelTutto:=cmbTipoAcc.Text <> '';
end;

procedure TWA061FDettAssenze.GetParametriFunzione;
{Leggo i parametri della form}
var x, y, i,r:integer;
    e: boolean;
    svalore, snome, selemento:string;
    LstAccorpSelezionati:TStringList;
    C004DMGen: TC004FParamForm;
begin
  //Leggo la data ultima registrazione stampata dai parametri con progressivo operatore -1
  try
    try
      C004DMGen:=CreaC004(SessioneOracle,medpcodiceForm,-1);
      DaRegStamp:=StrToDate(C004DMGen.GetParametro('DATAULTREGSTAMP',FormatDateTime('dd/mm/yyyy',Parametri.DataLavoro))) + 1;
      edtDaRegStamp.Text:=FormatDateTime('dd/mm/yyyy',DaRegStamp);
      ARegStamp:=Parametri.DataLavoro;
      edtARegStamp.Text:=FormatDateTime('dd/mm/yyyy',ARegStamp);
    except
    end;
  finally
    if C004DMGen <> nil then
      FreeAndNil(C004DMGen);
  end;

  //CreaC004(SessioneOracle,'A061',Parametri.ProgOper);
  cmbTipoAcc.Text:=C004DM.GetParametro('TIPOACCORPAMENTO',cmbTipoAcc.Text);
  chkSoloAssRegSucc.Checked:=C004DM.GetParametro('SOLOASSREGSUCC','N') = 'S';
  chkSalvaUltRegStamp.Checked:=C004DM.GetParametro('SALVAULTREGSTAMP','N') = 'S';
  rgpAssenzeConsiderate.ItemIndex:=StrToInt(C004DM.GetParametro('ASSENZECONSIDERATE','0'));
  chkTotIndividuali.Checked:=C004DM.GetParametro('TOTINDIVIDUALI','N') = 'S';
  chkTotRaggrup.Checked:=C004DM.GetParametro('TOTGRUPPO','N') = 'S';
  chkTotGenerali.Checked:=C004DM.GetParametro('TOTGENERALI','N') = 'S';
  chkDatiIndividuali.Checked:=C004DM.GetParametro('DATIINDIVIDUALI','N') = 'S';
  chkStampaDatiAnagrafici.Checked:=C004DM.GetParametro('STAMPADATIANAGRAFICI','S') = 'S';
  chkStampaNominativo.Checked:=C004DM.GetParametro('STAMPANOMINATIVO','S') = 'S';
  chkStampaMatricola.Checked:=C004DM.GetParametro('STAMPAMATRICOLA','S') = 'S';
  chkStampaBadge.Checked:=C004DM.GetParametro('STAMPABADGE','S') = 'S';
  chkDettPer.Checked:=C004DM.GetParametro('PERIODICO','N') = 'S';
  chkDettGiorn.Checked:=C004DM.GetParametro('DETTAGLIO','N') = 'S';
  chkSaltoPagIndividuale.Checked:=C004DM.GetParametro('SALTOPAGINAIND','N') = 'S';
  cmbCampo.Text:=C004DM.GetParametro('CAMPORAGGRUPPA',VarToStr(cmbCampo.Text));
  chkSaltoPagRaggrup.Checked:=C004DM.GetParametro('SALTOPAGINAGRUPPO','N') = 'S';
  rgpValidate.ItemIndex:=StrToInt(C004DM.GetParametro(UpperCase(rgpValidate.Name),'0'));
  chkGiorniSignificativi.Checked:=C004DM.GetParametro('GGSIGNIFICATIVI','S') = 'S';
  edtGGMinCont.Text:=C004DM.GetParametro('GGMINCONT','0');
  chkCausaliCumulate.Checked:=C004DM.GetParametro('CAUSALICUMULATE','N') = 'S';
  chkPeriodoServizio.Checked:=C004DM.GetParametro('PERIODOSERVIZIO','N') = 'S';
  //CRiduzioni.Checked:=C004DM.GetParametro('CALCOLARIDUZIONI','N') = 'S';
  //CSoloRiduzioni.Checked:=C004DM.GetParametro('SOLORIDUZIONI','N') = 'S';
  chkConteggiGG.Checked:=C004DM.GetParametro('CONTEGGIGG','N') = 'S';
  chkConiuge.Checked:=C004DM.GetParametro('CONTCONIUGE','N') = 'S';
  chkTotFam.Checked:=C004DM.GetParametro('TOTFAMILIARE','N') = 'S';
  rgpOrdinamento.ItemIndex:=StrToInt(C004DM.GetParametro(UpperCase(rgpOrdinamento.Name),'0'));

  rgpAssenzeConsiderate.Enabled:=chkSoloAssRegSucc.Checked;
  lblDaData.Enabled:=not chkSoloAssRegSucc.Checked;
  edtDaData.Enabled:=not chkSoloAssRegSucc.Checked;
  //sbtDaData.Enabled:=not chkSoloAssRegSucc.Checked;
  lblAData.Enabled:=not chkSoloAssRegSucc.Checked;
  edtAData.Enabled:=not chkSoloAssRegSucc.Checked;
  //sbtAData.Enabled:=not chkSoloAssRegSucc.Checked;
  lblDaRegStamp.Enabled:=chkSoloAssRegSucc.Checked;
  edtDaRegStamp.Enabled:=chkSoloAssRegSucc.Checked;
  //sbtDaRegStamp.Enabled:=chkSoloAssRegSucc.Checked;
  lblARegStamp.Enabled:=chkSoloAssRegSucc.Checked;
  edtARegStamp.Enabled:=chkSoloAssRegSucc.Checked;
  //sbtARegStamp.Enabled:=chkSoloAssRegSucc.Checked;
  chkSalvaUltRegStamp.Enabled:=chkSoloAssRegSucc.Checked;

  CaricaListaAccorpamenti;
  CaricaListaCausali;

  if cmbCampo.Text = '' then
  begin
    //dcmbCampo.KeyValue:=null;
    chkTotRaggrup.Enabled:=False;
    chkTotRaggrup.Checked:=False;
    chkSaltoPagRaggrup.Enabled:=False;
    chkSaltoPagRaggrup.Checked:=False;
  end;
  // lettura accorpamenti selezionati
  x:=0; //contatore di paramento
  snome:='LISTAACCORP';
  repeat
  // ciclo sui parametri LISTAACCORP0,LISTAACCORP1,ecc.
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
          r:=lstCodAcc.Items.Count;
          while (i<r) and (e) do
            begin
            if Copy(lstCodAcc.Items[i],1,5)=selemento then
               begin
               lstCodAcc.isChecked[i]:=true;
               e:=false;
               end
            else
               if Copy(lstCodAcc.Items[i],1,5)>selemento then
                  e:=false;
            inc(i);
            end;
          inc(y);
          end;
      until selemento = '';
      inc(x);
    end;
  until svalore = '';
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
        if selemento <> '' then
          begin
          i:=0;
          e:=true;
          r:=LstCausali.Items.Count;
          while (i < r) and (e) do
            begin
            if Copy(LstCausali.Items[i],1,5)=selemento then
               begin
               LstCausali.isChecked[i]:=true;
               e:=false;
               end
            else
               if Copy(LstCausali.Items[i],1,5)>selemento then
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

procedure TWA061FDettAssenze.btnGeneraPDFClick(Sender: TObject);
begin
  FElabSenderHTMLName:=btnGeneraPDF.HTMLName;
  ConvChkLstToLst(A061MW.A061MW_LstCausali);
  ElencoCausali:=A061MW.GetCausali;
  A061MW.ControlliBloccanti(ElencoCausali,chkDatiIndividuali.Checked,chkTotGenerali.Checked);
  if chkConiuge.Checked and (chkTotIndividuali.Checked or chkTotRaggrup.Checked or chkTotGenerali.Checked) then
    MsgBox.WebMessageDlg(A000MSG_A061_DLG_TOT_FRUIZIONI_CONIUGE,mtConfirmation,[mbYes,mbNo],ResultTotFruizioniConiuge,'')
  else
    EseguiStampa;
end;

procedure TWA061FDettAssenze.ResultTotFruizioniConiuge(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
    EseguiStampa;
end;

procedure TWA061FDettAssenze.EseguiStampa;
begin
  CallDCOMPrinter;
  if FileExists(DCOMNomeFile) then
  begin
    NomeFileGenerato:=DCOMNomeFile;
    InviaFileGenerato;
  end
  else
    raise Exception.Create(A000MSG_ERR_FILE_NON_CREATO);
end;

procedure TWA061FDettAssenze.btnVisStampaClick(Sender: TObject);
begin
  inherited;

  FElabSenderHTMLName:=btnVisStampa.HTMLName;
  ConvChkLstToLst(A061MW.A061MW_LstCausali);
  ElencoCausali:=A061MW.GetCausali;
  A061MW.ControlliBloccanti(ElencoCausali,chkDatiIndividuali.Checked,chkTotGenerali.Checked);

  //ElaborazioneCicloServer;
  StartElaborazioneCicloServer(btnSendFile.HTMLName,True);

  // blocco spostato nel metodo AfterElaborazione
  // WC015:=TWC015FSelEditGridFM.Create(Self.Parent);
  // WC015.Visualizza('Dettaglio assenze individuali',A061MW.TabellaStampa,False,False,False,1000);
end;

{Scrivo i parametri della form}
procedure TWA061FDettAssenze.PutParametriFunzione;
var
  i,x,y,r:integer;
  svalore,snome:string;
  C004DMGen: TC004FParamForm;
begin
  //Se necessario memorizzo la data ultima registrazione stampata nei parametri con progressivo operatore -1
  if chkSalvaUltRegStamp.Checked then
  begin
    try
      try
        C004DMGen:=CreaC004(SessioneOracle,medpcodiceForm,-1);
        C004DMGen.Cancella001;
        C004DMGen.PutParametro('DATAULTREGSTAMP',FormatDateTime('dd/mm/yyyy',ARegStamp));
      except
      end;
    finally
      if C004DMGen <> nil then
        FreeAndNil(C004DMGen);
    end;
  end;

  C004DM.Cancella001;
  C004DM.PutParametro('TIPOACCORPAMENTO',VarToStr(cmbTipoAcc.Text));
  if chkTotIndividuali.Checked then
    C004DM.PutParametro('TOTINDIVIDUALI','S')
  else
    C004DM.PutParametro('TOTINDIVIDUALI','N');
  if chkTotRaggrup.Checked then
    C004DM.PutParametro('TOTGRUPPO','S')
  else
    C004DM.PutParametro('TOTGRUPPO','N');
  if chkTotGenerali.Checked then
    C004DM.PutParametro('TOTGENERALI','S')
  else
    C004DM.PutParametro('TOTGENERALI','N');
  if chkSaltoPagIndividuale.Checked then
    C004DM.PutParametro('SALTOPAGINAIND','S')
  else
    C004DM.PutParametro('SALTOPAGINAIND','N');
  if chkSaltoPagRaggrup.Checked then
    C004DM.PutParametro('SALTOPAGINAGRUPPO','S')
  else
    C004DM.PutParametro('SALTOPAGINAGRUPPO','N');
  if chkDettGiorn.Checked then
    C004DM.PutParametro('DETTAGLIO','S')
  else
    C004DM.PutParametro('DETTAGLIO','N');
  if chkDettPer.Checked then
    C004DM.PutParametro('PERIODICO','S')
  else
    C004DM.PutParametro('PERIODICO','N');
  if chkGiorniSignificativi.Checked then
    C004DM.PutParametro('GGSIGNIFICATIVI','S')
  else
    C004DM.PutParametro('GGSIGNIFICATIVI','N');
  C004DM.PutParametro('DATIINDIVIDUALI',IfThen(chkDatiIndividuali.Checked,'S','N'));
  C004DM.PutParametro('STAMPADATIANAGRAFICI',IfThen(chkStampaDatiAnagrafici.Checked,'S','N'));
  C004DM.PutParametro('STAMPANOMINATIVO',IfThen(chkStampaNominativo.Checked,'S','N'));
  C004DM.PutParametro('STAMPAMATRICOLA',IfThen(chkStampaMatricola.Checked,'S','N'));
  C004DM.PutParametro('STAMPABADGE',IfThen(chkStampaBadge.Checked,'S','N'));
  if chkRiduzioni.Checked then
    C004DM.PutParametro('CALCOLARIDUZIONI','S')
  else
    C004DM.PutParametro('CALCOLARIDUZIONI','N');
  if chkSoloRiduzioni.Checked then
    C004DM.PutParametro('SOLORIDUZIONI','S')
  else
    C004DM.PutParametro('SOLORIDUZIONI','N');
  if chkConteggiGG.Checked then
    C004DM.PutParametro('CONTEGGIGG','S')
  else
    C004DM.PutParametro('CONTEGGIGG','N');
  if chkSalvaUltRegStamp.Checked then
    C004DM.PutParametro('SALVAULTREGSTAMP','S')
  else
    C004DM.PutParametro('SALVAULTREGSTAMP','N');
  if chkSoloAssRegSucc.Checked then
    C004DM.PutParametro('SOLOASSREGSUCC','S')
  else
    C004DM.PutParametro('SOLOASSREGSUCC','N');
  C004DM.PutParametro(UpperCase(rgpValidate.Name),IntToStr(rgpValidate.ItemIndex));
  C004DM.PutParametro('ASSENZECONSIDERATE',IntToStr(rgpAssenzeConsiderate.ItemIndex));
  C004DM.PutParametro('CAMPORAGGRUPPA',VarToStr(cmbCampo.Text));
  C004DM.PutParametro('GGMINCONT',edtGGMinCont.Text);
  if chkCausaliCumulate.Checked then
    C004DM.PutParametro('CAUSALICUMULATE','S')
  else
    C004DM.PutParametro('CAUSALICUMULATE','N');
  if chkPeriodoServizio.Checked then
    C004DM.PutParametro('PERIODOSERVIZIO','S')
  else
    C004DM.PutParametro('PERIODOSERVIZIO','N');
  if chkConiuge.Checked then
    C004DM.PutParametro('CONTCONIUGE','S')
  else
    C004DM.PutParametro('CONTCONIUGE','N');
  if chkTotFam.Checked then
    C004DM.PutParametro('TOTFAMILIARE','S')
  else
    C004DM.PutParametro('TOTFAMILIARE','N');
  C004DM.PutParametro(UpperCase(rgpOrdinamento.Name),IntToStr(rgpOrdinamento.ItemIndex));
  // salvo l'elenco degli accorpamenti selezionati
  x:=0; //contatore parametri accorpamenti
  y:=0; //contatore elementi per parametro
  svalore:='';
  snome:='LISTAACCORP';
  r:=lstCodAcc.Items.Count;
  for i:=1 to r do
  begin
    if lstCodAcc.IsChecked[i-1] then
    begin
       svalore:=svalore+Copy(lstCodAcc.Items[i-1],1,5);
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
  // salvo l'elenco delle causali selezionate
  x:=0; //contatore parametri causali
  y:=0; //contatore elementi per parametro
  svalore:='';
  snome:='LISTACAUSALI';
  r:=LstCausali.Items.Count;
  for i:=1 to r do
  begin
    if LstCausali.IsChecked[i-1] then
    begin
       svalore:=svalore+Copy(LstCausali.Items[i-1],1,5);
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

procedure TWA061FDettAssenze.CallDCOMPrinter;
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
    DCOMConnection.AppServer.PrintA061(grdC700.selAnagrafe.SubstitutedSQL,
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

function TWA061FDettAssenze.CreateJSonString: String;
var json: TJSONObject;
    i: Integer;
begin
  json:=TJSONObject.Create;
  try
    //Popolo il json con i valori necessari al B028 per creare il PDF per la stampa
    json.AddPair('StandardPrinter',IfThen(Pos(INI_PAR_USE_STANDARD_PRINTER,W000ParConfig.ParametriAvanzati) > 0,'S','N'));
    C190Comp2JsonString(edtDaData,json);
    C190Comp2JsonString(edtAData,json);
    C190Comp2JsonString(edtDaRegStamp,json);
    C190Comp2JsonString(edtARegStamp,json);
    C190Comp2JsonString(edtGGMinCont,json);

    C190Comp2JsonString(rgpAssenzeConsiderate,json);
    C190Comp2JsonString(rgpValidate,json);
    C190Comp2JsonString(rgpOrdinamento,json);

    C190Comp2JsonString(chkSoloAssRegSucc,json);
    C190Comp2JsonString(chkSalvaUltRegStamp,json);
    C190Comp2JsonString(chkDatiIndividuali,json);
    C190Comp2JsonString(chkStampaDatiAnagrafici,json);
    C190Comp2JsonString(chkStampaNominativo,json);
    C190Comp2JsonString(chkStampaMatricola,json);
    C190Comp2JsonString(chkStampaBadge,json);
    C190Comp2JsonString(chkDettGiorn,json);
    C190Comp2JsonString(chkDettPer,json);
    C190Comp2JsonString(chkSaltoPagRaggrup,json);
    C190Comp2JsonString(chkSaltoPagIndividuale,json);
    C190Comp2JsonString(chkConiuge,json);
    C190Comp2JsonString(chkRiduzioni,json);
    C190Comp2JsonString(chkSoloRiduzioni,json);
    C190Comp2JsonString(chkConteggiGG,json);
    C190Comp2JsonString(chkGiorniSignificativi,json);
    C190Comp2JsonString(chkCausaliCumulate,json);
    C190Comp2JsonString(chkPeriodoServizio,json);
    C190Comp2JsonString(chkTotIndividuali,json);
    C190Comp2JsonString(chkTotRaggrup,json);
    C190Comp2JsonString(chkTotFam,json);
    C190Comp2JsonString(chkTotGenerali,json);

    json.AddPair('LstCausali',TJSONString.Create(C190GetCheckList(5,LstCausali)));
    json.AddPair('LstCodAcc',TJSONString.Create(C190GetCheckList(5,LstCodAcc)));

    C190Comp2JsonString(cmbTipoAcc,json,'dcmbTipoAcc');
    C190Comp2JsonString(cmbCampo,json,'dcmbCampo');
    Result:=json.ToString;
  finally
    FreeAndNil(json);
  end;
end;

procedure TWA061FDettAssenze.ImpostazioniWC700;
begin
  grdC700.WC700FM.C700SelezionePeriodica:=True;
end;


procedure TWA061FDettAssenze.VisualizzaGruppoComponenti(Id: String; Visualizza: Boolean);
begin
  if Visualizza then
    AddToInitProc('$(''.'+Id+'Obj'').show();')
  else
    AddToInitProc('$(''.'+Id+'Obj'').hide();');
end;

end.
