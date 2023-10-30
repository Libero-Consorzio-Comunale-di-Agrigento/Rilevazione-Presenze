unit WP656UElaborazioneFluper;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR100UBase, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton,
  meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWHTMLControls, meIWLink, IWCompLabel, meIWLabel, IWCompEdit, meIWEdit,
  IWCompCheckbox, meIWCheckBox, meIWRadioGroup, meIWImageFile, medpIWImageButton,
  C180FunzioniGenerali, A000UInterfaccia, A000UMessaggi, WP656UElaborazioneFluperDM,
  medpIWMessageDlg, P946UCalcoloFLUPERDtm, StrUtils, A000UCostanti, IWApplication;

type
  TWP656FElaborazioneFluper = class(TWR100FBase)
    edtMeseDa: TmeIWEdit;
    lblMeseDa: TmeIWLabel;
    edtMeseA: TmeIWEdit;
    lblMeseA: TmeIWLabel;
    chkElaboraDatiFLUSSOA: TmeIWCheckBox;
    chkElaboraDatiFLUSSOB36: TmeIWCheckBox;
    chkElaboraDatiFLUSSOB37: TmeIWCheckBox;
    rgpStatoCedolini: TmeIWRadioGroup;
    lblStatoCedolini: TmeIWLabel;
    chkAnnullaFLUPER: TmeIWCheckBox;
    chkChiusura: TmeIWCheckBox;
    chkEsportazioneFile: TmeIWCheckBox;
    rgpFlusso: TmeIWRadioGroup;
    edtDataChiusura: TmeIWEdit;
    lblDataChiusura: TmeIWLabel;
    edtNomeFileOutput: TmeIWEdit;
    lblNomeFileOutput: TmeIWLabel;
    btnVisualizzaFile: TmedpIWImageButton;
    btnAnomalie: TmedpIWImageButton;
    btnEsegui: TmedpIWImageButton;
    procedure IWAppFormCreate(Sender: TObject);
    procedure chkAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure btnVisualizzaFileClick(Sender: TObject);
  private
    DataInizio,DataFine,dMyData: TDateTime;
    bElaborazioneDipendenti, bEsportazioneFile: Boolean;
    F:TextFile;
    currRecElab: Integer;
    DatiFLUP946: TDatiFlup946;
    sPvParteAK:String;
    WP656FElaborazioneFluperDM: TWP656FElaborazioneFluperDM;
    procedure AbilitazioneComponenti;
    procedure GetParametriFunzione;
    procedure ResultConfermaStart(Sender: TObject; Res: TmeIWModalResult;
      KeyID: String);
    procedure ChiusuraFornitura;
    procedure ResultConfermaChiusura(Sender: TObject; Res: TmeIWModalResult;
      KeyID: String);
    procedure VerificaEsportazione;
    procedure ResultConfermaFile(Sender: TObject; Res: TmeIWModalResult;
      KeyID: String);
    procedure VerificaFile;
    procedure PutParametriFunzione;
  protected
    procedure ImpostazioniWC700; override;
    procedure WC700AperturaSelezione(Sender: TObject); override;
    procedure ElaboraElemento; override;
    procedure FineCicloElaborazione; override;
    function ElaborazioneTerminata:String; override;
    procedure DistruzioneOggettiElaborazione(Errore: Boolean); override;
    procedure InizioElaborazione; override;
    function CurrentRecordElaborazione: Integer; override;
    function TotalRecordsElaborazione: Integer; override;
    function ElementoSuccessivo: Boolean; override;
  end;

implementation

{$R *.dfm}

procedure TWP656FElaborazioneFluper.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WP656FElaborazioneFluperDM:=TWP656FElaborazioneFluperDM.Create(Self);
  AttivaGestioneC700;
  WP656FElaborazioneFluperDM.P656FElaborazioneFluperMW.selAnagrafe:=grdC700.selAnagrafe;
  GetParametriFunzione;
  AbilitazioneComponenti;

  sPvParteAK:=WP656FElaborazioneFluperDM.P656FElaborazioneFluperMW.VerificaAlternativaParteAK(StrToDate('01/'+edtMeseDa.Text));
  if sPvParteAK = 'K' then
  begin
    chkElaboraDatiFLUSSOA.Caption:='Calcola dati Flusso Kpmg';
    chkElaboraDatiFLUSSOB36.Visible:=False;
    chkElaboraDatiFLUSSOB37.Visible:=False;
    chkElaboraDatiFLUSSOB36.Checked:=False;
    chkElaboraDatiFLUSSOB37.Checked:=False;
  end;
end;

procedure TWP656FElaborazioneFluper.AbilitazioneComponenti;
var
  bAttiva: Boolean;
//Imposto abilitazioni iniziali per i componenti
begin
  chkAnnullaFLUPER.Enabled:=not(chkElaboraDatiFlussoA.Checked or chkElaboraDatiFlussoB36.Checked or chkElaboraDatiFLUSSOB37.Checked or
                            chkEsportazioneFile.Checked or chkChiusura.Checked);
  chkElaboraDatiFlussoA.Enabled:=not (chkAnnullaFLUPER.Checked or chkEsportazioneFile.Checked or chkChiusura.Checked);
  chkElaboraDatiFlussoB36.Enabled:=not (chkAnnullaFLUPER.Checked or chkEsportazioneFile.Checked or chkChiusura.Checked);
  chkElaboraDatiFLUSSOB37.Enabled:=not (chkAnnullaFLUPER.Checked or chkEsportazioneFile.Checked or chkChiusura.Checked);
  chkChiusura.Enabled:=not (chkAnnullaFLUPER.Checked or chkElaboraDatiFlussoA.Checked or chkElaboraDatiFlussoB36.Checked or chkElaboraDatiFLUSSOB37.Checked);
  edtDataChiusura.Enabled:=chkChiusura.Checked;
  chkEsportazioneFile.Enabled:=not (chkAnnullaFLUPER.Checked or chkElaboraDatiFlussoA.Checked or chkElaboraDatiFlussoB36.Checked or chkElaboraDatiFLUSSOB37.Checked);
  rgpFlusso.Enabled:=chkEsportazioneFile.Enabled;
  edtNomeFileOutput.Enabled:=chkEsportazioneFile.Checked;
  btnVisualizzaFile.Enabled:=chkEsportazioneFile.Checked;
  if not chkElaboraDatiFlussoA.Enabled then chkElaboraDatiFlussoA.Checked:=False;
  if not chkElaboraDatiFlussoB36.Enabled then chkElaboraDatiFlussoB36.Checked:=False;
  if not chkElaboraDatiFLUSSOB37.Enabled then chkElaboraDatiFLUSSOB37.Checked:=False;
  if not chkEsportazioneFile.Enabled then
    chkEsportazioneFile.Checked:=False;
  if not chkAnnullaFLUPER.Enabled then
    chkAnnullaFLUPER.Checked:=False;
  if not chkChiusura.Enabled then
    chkChiusura.Checked:=False;
  btnEsegui.Enabled:=((not SolaLettura) and (chkElaboraDatiFlussoA.Checked or chkElaboraDatiFlussoB36.Checked or chkElaboraDatiFlussoB37.Checked or
                     chkAnnullaFluper.Checked or chkChiusura.Checked or chkEsportazioneFile.Checked)) or
                     (SolaLettura and (not chkChiusura.Checked) and chkEsportazioneFile.Checked);
  bAttiva:=chkAnnullaFLUPER.Checked or chkElaboraDatiFlussoA.Checked or chkElaboraDatiFlussoB36.Checked or chkElaboraDatiFLUSSOB37.Checked or chkEsportazioneFile.Checked;
  grdc700.AbilitaToolbar(bAttiva);
end;

procedure TWP656FElaborazioneFluper.btnAnomalieClick(Sender: TObject);
var Params: String;
begin
  Params:='AZIENDA=' + Parametri.Azienda + ParamDelimiter +
          'OPERATORE=' + Parametri.Operatore + ParamDelimiter +
          'MASCHERA=' + medpCodiceForm + ParamDelimiter +
          'ID=' + IntToStr(RegistraMsg.ID) + ParamDelimiter +
          'TIPO=A,B,I';
  accediForm(201,Params,True);
end;

procedure TWP656FElaborazioneFluper.btnEseguiClick(Sender: TObject);
var
  Msg: String;
  bSelezioneAnagrafica: Boolean;
  dTmp: TDateTime;
begin
  inherited;
  btnAnomalie.Enabled:=False;
  if edtMeseDa.Text = '' then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_MSG_MESE_DA]),mtError,[mbOk],nil,'');
    exit;
  end;

  if not TryStrToDate('01/' + edtMeseDa.Text,DataInizio) then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_DATA_NON_VALIDA,[A000MSG_MSG_MESE_DA]),mtError,[mbOk],nil,'');
    exit;
  end;

  if edtMeseA.Text = '' then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_MSG_MESE_A]),mtError,[mbOk],nil,'');
    exit;
  end;

  if not TryStrToDate('01/' + edtMeseA.Text,DataFine) then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_DATA_NON_VALIDA,[A000MSG_MSG_MESE_A]),mtError,[mbOk],nil,'');
    exit;
  end;

  DataInizio:=R180InizioMese(DataInizio);
  DataFine:=R180FineMese(DataFine);
  if R180Anno(DataInizio) <> R180Anno(DataFine) then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_MESE_STESSO_ANNO,mtError,[mbOk],nil,'');
    Exit;
  end;
  if R180Mese(DataFine) < R180Mese(DataInizio) then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_MESE_DA_A,mtError,[mbOk],nil,'');
    Exit;
  end;

  bSelezioneAnagrafica:=chkAnnullaFLUPER.Checked or chkElaboraDatiFlussoA.Checked or chkElaboraDatiFlussoB36.Checked or chkElaboraDatiFLUSSOB37.Checked or chkEsportazioneFile.Checked;
  if (bSelezioneAnagrafica) and (grdC700.selAnagrafe.RecordCount = 0) then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_NO_DIP,mtError,[mbOk],nil,'');
    Exit;
  end;

  bElaborazioneDipendenti:=False;
  bEsportazioneFile:=False;
  //Elaborazione o Annullamento del Flusso
  if chkElaboraDatiFlussoA.Checked or
     chkElaboraDatiFlussoB36.Checked or
     chkElaboraDatiFLUSSOB37.Checked or
     chkAnnullaFLUPER.Checked then
  begin
    bElaborazioneDipendenti:=True;
    //Verifico se esiste fornitura precedente non chiusa dandone segnalazione
    Msg:=WP656FElaborazioneFluperDM.P656FElaborazioneFluperMW.VerificaFornitureAnte(DataFine);
    if Msg <> '' then
    begin
      MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultConfermaStart,'');
      exit;
    end;
  end
  else
  begin
    if chkChiusura.Checked then
    begin
      if edtDataChiusura.Text = '' then
      begin
        MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_MSG_DATA_CHIUSURA]),mtError,[mbOk],nil,'');
        exit;
      end;

      if not TryStrToDate(edtDataChiusura.Text,dTmp) then
      begin
        MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_DATA_NON_VALIDA,[A000MSG_MSG_DATA_CHIUSURA]),mtError,[mbOk],nil,'');
        exit;
      end;

      MsgBox.WebMessageDlg(A000MSG_P656_DLG_CHIUSURA,mtConfirmation,[mbYes,mbNo],ResultConfermaChiusura,'');
      exit;
    end;
    //Esportazione dati su file sequenziale
    if chkEsportazioneFile.Checked then
    begin
      bEsportazioneFile:=True;
      VerificaEsportazione;
    end;
  end;

  StartElaborazioneCiclo(btnEsegui.HTMLName);
end;

procedure TWP656FElaborazioneFluper.btnVisualizzaFileClick(Sender: TObject);
begin
  if FileExists(edtNomeFileOutput.Text) then
    GGetWebApplicationThreadVar.SendFile(edtNomeFileOutput.Text,true,'application/x-download',ExtractFileName(edtNomeFileOutput.Text))
  else
    MsgBox.WebMessageDlg(A000MSG_ERR_FILE_INESISTENTE,mtInformation,[mbOk],nil,'');
end;

procedure TWP656FElaborazioneFluper.ResultConfermaChiusura(Sender: TObject;
  Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrYes then
  begin
    ChiusuraFornitura;
  end;
  //si può fare chiusura e esportazione assieme. se dice no a chiusura, l'esportazione va comunque fatta
  if chkEsportazioneFile.Checked then
  begin
    bEsportazioneFile:=True;
    VerificaEsportazione;
    StartElaborazioneCiclo(btnEsegui.HTMLName);
  end;
end;

procedure TWP656FElaborazioneFluper.ResultConfermaFile(Sender: TObject;
  Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrYes then
  begin
    VerificaFile;
    StartElaborazioneCiclo(btnEsegui.HTMLName);
  end;
end;

procedure TWP656FElaborazioneFluper.VerificaEsportazione;
var
  Msg: String;
begin
  Msg:=WP656FElaborazioneFluperDM.P656FElaborazioneFluperMW.VerificaEstrazione(DataInizio,DataFine);
  if Msg <> '' then
  begin
    MsgBox.WebMessageDlg(Msg,mtError,[mbOk],nil,'');
    Abort; //devo interrompere
  end;

  if Trim(edtNomeFileOutput.Text) = '' then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,['File di esportazione']),mtError,[mbOk],nil,'');
    Abort; //devo interrompere
  end;

  if FileExists(edtNomeFileOutput.Text) then
  begin
    MsgBox.WebMessageDlg(A000MSG_DLG_SOSTITUIRE,mtConfirmation,[mbYes,mbNo],ResultConfermaFile,'');
    Abort; //devo interrompere
  end;

  VerificaFile;
end;

procedure TWP656FElaborazioneFluper.VerificaFile;
begin
  if FileExists(edtNomeFileOutput.Text) then
  begin
    if DeleteFile(edtNomeFileOutput.Text)=False then
    begin
      MsgBox.WebMessageDlg(A000MSG_P656_ERR_DEL_FILE,mtError,[mbOk],nil,'');
      Abort;
    end;
  end;
  AssignFile(F,edtNomeFileOutput.Text);
  try
    Rewrite(F);
  except
    MsgBox.WebMessageDlg(A000MSG_P656_ERR_SCRIT_FILE,mtError,[mbOk],nil,'');
    Abort;
  end;
end;

procedure TWP656FElaborazioneFluper.ChiusuraFornitura;
//Chiusura della fornitura mensile
var
  dMyData:TDateTime;
  Msg: string;
  DataChiusura: TDateTime;
  Id_FLUSSO_Aperto: Integer;
begin
  dMyData:=R180FineMese(DataInizio);
  DataChiusura:=StrToDate(edtDataChiusura.Text);
  while dMyData <= DataFine do
  begin
    with WP656FElaborazioneFluperDM.P656FElaborazioneFluperMW do
    begin
      //Leggo la testa per impostare Id_FLUSSO_Aperto
      Id_FLUSSO_Aperto:=TestataFLUPER(dMyData,(chkElaboraDatiFlussoA.Checked) or (chkElaboraDatiFlussoB36.Checked) or (chkElaboraDatiFLUSSOB37.Checked));
      Msg:=VerificaIdFlusso(Id_FLUSSO_Aperto,dMyData);
      if Msg <> '' then
      begin
        SessioneOracle.Rollback;
        raise Exception.Create(msg);
      end;
      ChiudiFornitura(Id_FLUSSO_Aperto,DataChiusura);

      dMyData:=R180FineMese(R180AddMesi(dMyData,1));
    end;
  end;
  SessioneOracle.Commit;
end;

procedure TWP656FElaborazioneFluper.ResultConfermaStart(Sender: TObject;
  Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrYes then
    StartElaborazioneCiclo(btnEsegui.HTMLName);
end;

procedure TWP656FElaborazioneFluper.chkAsyncClick(
  Sender: TObject; EventParams: TStringList);
begin
  AbilitazioneComponenti;
end;

procedure TWP656FElaborazioneFluper.GetParametriFunzione;
{Leggo i parametri della form}
begin
  edtMeseDa.Text:=C004DM.GetParametro('edtMeseDa',FormatDateTime('mm/yyyy',R180AddMesi(Parametri.DataLavoro,-4)));
  edtMeseA.Text:=C004DM.GetParametro('edtMeseA',FormatDateTime('mm/yyyy',R180AddMesi(Parametri.DataLavoro,-2)));
  chkElaboraDatiFlussoA.Checked:=(C004DM.GetParametro('chkElaboraDatiFlussoA','') = 'S');
  chkElaboraDatiFlussoB36.Checked:=(C004DM.GetParametro('chkElaboraDatiFlussoB1_36','') = 'S');
  chkElaboraDatiFLUSSOB37.Checked:=(C004DM.GetParametro('chkElaboraDatiFLUSSOB37','') = 'S');
  chkAnnullaFLUPER.Checked:=(C004DM.GetParametro('chkAnnullaFLUPER','') = 'S');
  chkChiusura.Checked:=(C004DM.GetParametro('chkChiusura','') = 'S');
  chkEsportazioneFile.Checked:=(C004DM.GetParametro('chkEsportazioneFile','') = 'S');

  rgpFlusso.ItemIndex:=StrToInt(C004DM.GetParametro('rgpFlusso','0'));
  edtNomeFileOutput.Text:=C004DM.GetParametro('edtNomeFileOutput','');
  edtDataChiusura.Text:=FormatDateTime('dd/mm/yyyy',Parametri.DataLavoro);
end;

procedure TWP656FElaborazioneFluper.ImpostazioniWC700;
begin
  inherited;
  grdc700.WC700FM.C700SelezionePeriodica:=True;
end;

procedure TWP656FElaborazioneFluper.WC700AperturaSelezione(Sender: TObject);
var
  D: TDateTime;
begin
  inherited;
  if TryStrToDate('01/'+ edtMeseDa.Text,D) then
    grdC700.WC700FM.C700DataDal:=R180InizioMese(D);

  if TryStrToDate('01/'+ edtMeseA.Text,D) then
    grdC700.WC700FM.C700DataLavoro:=R180FineMese(D);
end;

//Elaborazione
procedure TWP656FElaborazioneFluper.InizioElaborazione;
begin
  inherited;
  PutParametriFunzione;
  if bElaborazioneDipendenti then
  begin
    dMyData:=R180FineMese(DataInizio);
    if grdC700.WC700FM.C700SettaPeriodoSelAnagrafe(R180InizioMese(dMyData), R180FineMese(dMyData)) then
      grdC700.selAnagrafe.Close;
    grdC700.selAnagrafe.Open;
    grdC700.selAnagrafe.First;

    currRecElab:=1;
    WP656FElaborazioneFluperDM.P656FElaborazioneFluperMW.InizializzaConteggi(DataInizio,DataFine);
    DatiFLUP946.ElaboraDatiFLUSSOA:=chkElaboraDatiFLUSSOA.Checked;
    DatiFLUP946.ElaboraDatiFLUSSOB1_36:=chkElaboraDatiFLUSSOB36.Checked;
    DatiFLUP946.ElaboraDatiFLUSSOB37:=chkElaboraDatiFLUSSOB37.Checked;
    case rgpStatoCedolini.ItemIndex of
      0:DatiFLUP946.StatoCedolini:='''S''';
      1:DatiFLUP946.StatoCedolini:='''S'',''N''';
      2:DatiFLUP946.StatoCedolini:='''N''';
    end;
    DatiFLUP946.ParteAK:=sPvParteAK;
  end
  else if bEsportazioneFile then
  begin
    dMyData:=R180FineMese(DataInizio);
    currRecElab:=1;
  end;
end;

function TWP656FElaborazioneFluper.CurrentRecordElaborazione: Integer;
begin
  Result:=currRecElab;
end;

function TWP656FElaborazioneFluper.TotalRecordsElaborazione: Integer;
var
  nMesi: Integer;
begin
  Result:=0;
  if bElaborazioneDipendenti then
  begin
    //La selezione anagrafe viene reimpostata al cambiamento di mese ,pertanto di mese in mese
    // il numero di dipendenti può variare. il numero totale è indicativo e serve solamente
    //per la progressBar; gli elementi elaborati sono sempre la selezione anagrafica del mese
    nMesi:=(R180Mese(DataFine) - R180Mese(DataInizio)) + 1;
    Result:=nMesi * grdC700.selAnagrafe.RecordCount;
  end
  else if bEsportazioneFile then       
  begin
    Result:=(R180Mese(DataFine) - R180Mese(DataInizio)) + 1;
  end;
end;

function TWP656FElaborazioneFluper.ElementoSuccessivo: Boolean;
begin
  Result:=False;
  if bElaborazioneDipendenti then
  begin
    currRecElab:=currRecElab + 1;
    Result:=False;
    grdC700.SelAnagrafe.Next;
    if not grdC700.SelAnagrafe.EOF then
      Result:=True
    else //ciclo su selAnagrafe finito; incremento la data
    begin
      WP656FElaborazioneFluperDM.P656FElaborazioneFluperMW.FineElabTestata(DatiFLUP946);
      dMyData:=R180FineMese(R180AddMesi(dMyData,1));
      if grdC700.WC700FM.C700SettaPeriodoSelAnagrafe(R180InizioMese(dMyData), R180FineMese(dMyData)) then
        grdC700.selAnagrafe.Close;
      grdC700.selAnagrafe.Open;
      grdC700.selAnagrafe.First;

      Result:=(dMyData <= DataFine);
    end;
  end
  else if bEsportazioneFile then
  begin
    currRecElab:=currRecElab + 1;
    dMyData:=R180FineMese(R180AddMesi(dMyData,1));
    Result:=(dMyData <= DataFine);
  end;
end;

procedure TWP656FElaborazioneFluper.ElaboraElemento;
var
  Id_FLUSSO_Aperto: Integer;
  Msg:String;
begin
  inherited;
  if bElaborazioneDipendenti then
  begin
    DatiFLUP946.DataElaborazione:=dMyData;
    //Leggo la testa per impostare Id_FLUSSO_Aperto
    Id_FLUSSO_Aperto:=WP656FElaborazioneFluperDM.P656FElaborazioneFluperMW.TestataFLUPER(DatiFLUP946.DataElaborazione,(chkElaboraDatiFlussoA.Checked) or (chkElaboraDatiFlussoB36.Checked) or (chkElaboraDatiFLUSSOB37.Checked));

    Msg:=WP656FElaborazioneFluperDM.P656FElaborazioneFluperMW.VerificaIdFlusso(Id_FLUSSO_Aperto,dMyData);
    if Msg <> '' then
    begin
      raise Exception.Create(msg);
    end;

    //Configuro variabili per calcolo fluper
    DatiFLUP946.ID_FLUPER:=Id_FLUSSO_Aperto;
    try
      WP656FElaborazioneFluperDM.P656FElaborazioneFluperMW.ElaboraDipendente(DatiFLUP946, chkAnnullaFLUPER.checked);
    except
      SessioneOracle.Rollback;
      raise;
    end;
  end
  else if bEsportazioneFile then
  begin
    if grdC700.WC700FM.C700SettaPeriodoSelAnagrafe(R180InizioMese(dMyData), R180FineMese(dMyData)) then
      grdC700.selAnagrafe.Close;
    grdC700.selAnagrafe.Open;

    with WP656FElaborazioneFluperDM.P656FElaborazioneFluperMW do
    begin
      grdC700.WC700FM.C700MergeSelAnagrafe(selP663,False);
      ElaboraEstrazione(dMyData, (rgpFlusso.ItemIndex = 0),F);
    end;
  end;
end;

procedure TWP656FElaborazioneFluper.FineCicloElaborazione;
begin
  inherited;
  btnAnomalie.Enabled:=(RegistraMsg.ContieneTipoA);
end;

function TWP656FElaborazioneFluper.ElaborazioneTerminata: String;
begin
  if btnAnomalie.Enabled then
    Result:=A000MSG_MSG_ELABORAZIONE_ANOMALIE
  else
    Result:=inherited;
end;

procedure TWP656FElaborazioneFluper.DistruzioneOggettiElaborazione(Errore: Boolean);
begin
  inherited;
  if bEsportazioneFile then
  begin
    CloseFile(F);
  end;
end;

procedure TWP656FElaborazioneFLUPER.PutParametriFunzione;
{Scrivo i parametri della forma}
begin
  C004DM.Cancella001;
  C004DM.PutParametro('edtMeseDa',edtMeseDa.Text);
  C004DM.PutParametro('edtMeseA',edtMeseA.Text);
  C004DM.PutParametro('chkElaboraDatiFlussoA',IfThen(chkElaboraDatiFlussoA.Checked,'S','N'));
  C004DM.PutParametro('chkElaboraDatiFlussoB1_36',IfThen(chkElaboraDatiFLUSSOB36.Checked,'S','N'));
  C004DM.PutParametro('chkElaboraDatiFLUSSOB37',IfThen(chkElaboraDatiFLUSSOB37.Checked,'S','N'));
  C004DM.PutParametro('chkAnnullaFLUPER',IfThen(chkAnnullaFLUPER.Checked,'S','N'));
  C004DM.PutParametro('chkChiusura',IfThen(chkChiusura.Checked,'S','N'));
  C004DM.PutParametro('chkEsportazioneFile',IfThen(chkEsportazioneFile.Checked,'S','N'));
  C004DM.PutParametro('rgpFlusso',rgpFlusso.ItemIndex.ToString());
  C004DM.PutParametro('edtNomeFileOutput',edtNomeFileOutput.Text);

  try SessioneOracle.Commit; except end;
end;

procedure TWP656FElaborazioneFluper.IWAppFormDestroy(Sender: TObject);
begin
  PutParametriFunzione;
  FreeAndNil(WP656FElaborazioneFluperDM);
  inherited;
end;

end.
