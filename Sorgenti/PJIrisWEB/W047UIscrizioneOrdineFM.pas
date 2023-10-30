unit W047UIscrizioneOrdineFM;

interface

uses
  SysUtils, Classes, Controls, Forms, IWAppForm,
  IWVCLBaseContainer, IWContainer, IWRegion, IWHTMLContainer,
  IWHTML40Container, IWCompButton, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWTypes, DBClient, IWDBGrids,
  DB, Oracle, StrUtils, Variants, OracleData, WR010UBase,
  A000UInterfaccia, C180FunzioniGenerali, C190FunzioniGeneraliWeb, R010UPAGINAWEB,
  W047UIscrizioneOrdineDM,
  medpIWDBGrid, meIWMemo, medpIWMessageDlg, meIWButton, IWCompJQueryWidget, meIWImageFile,
  IWCompGrids, IWCompLabel, meIWLabel, IWCompEdit, meIWEdit, IWCompMemo,
  IWDBStdCtrls, meIWDBEdit, meIWDBMemo, IWApplication, IWCompExtCtrls,
  medpIWImageButton, TypInfo, WR200UBaseFM;

type
  W047AbilitaJQ = procedure(Val:Boolean) of object;

  TW047FIscrizioneOrdineFM = class(TWR200FBaseFM)
    lblDal: TmeIWLabel;
    dedtDal: TmeIWDBEdit;
    lblCodOrdine: TmeIWLabel;
    dedtCodOrdine: TmeIWDBEdit;
    btnSelComune: TmeIWButton;
    lblNote: TmeIWLabel;
    dmemNote: TmeIWDBMemo;
    DataSourceIsc: TDataSource;
    btnModifica: TmedpIWImageButton;
    btnConferma: TmedpIWImageButton;
    btnAnnulla: TmedpIWImageButton;
    btnChiudi: TmedpIWImageButton;
    lblProvincia: TmeIWLabel;
    dedtProvincia: TmeIWDBEdit;
    lblCodIscrizione: TmeIWLabel;
    dedtCodIscrizione: TmeIWDBEdit;
    dedtPEC: TmeIWDBEdit;
    lblPEC: TmeIWLabel;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure btnModificaClick(Sender: TObject);
    procedure btnConfermaClick(Sender: TObject);
    procedure btnAnnullaClick(Sender: TObject);
    procedure btnChiudiClick(Sender: TObject);
  private
    IncaricoAttuale: Boolean;
    procedure CercaOrdineProf;
    procedure ImpostaLabel;
    procedure AbilitaComponenti;
    procedure OnConfermaOrdine(Sender: TObject; ModalResult: TmeIWModalResult; KeyID: String);
  public
    DataSetIsc:TOracleDataSet;
    ReadOnly: Boolean;
    W047DM2:TW047FIscrizioneOrdineDM;
    AzioneRichiamo,ValoreV430a:String;
    evtAbilitaJQ: W047AbilitaJQ;
    procedure Apri;
    procedure Visualizza;
  end;

implementation

uses W047UIscrizioneOrdine;

{$R *.dfm}

procedure TW047FIscrizioneOrdineFM.IWFrameRegionCreate(Sender: TObject);
begin
  Self.Parent:=TIWAppForm(Self.Owner);
end;

procedure TW047FIscrizioneOrdineFM.Apri;
begin
  DataSourceIsc.DataSet:=DataSetIsc;
  if AzioneRichiamo = 'M' then
    DataSetIsc.Edit
  else if AzioneRichiamo = 'I' then
    DataSetIsc.Append;
  ImpostaLabel;
  AbilitaComponenti;
end;

procedure TW047FIscrizioneOrdineFM.ImpostaLabel;
begin
  lblDal.Caption:=DataSetIsc.FieldByName('DATA_ISCRIZIONE').DisplayLabel;
  lblCodOrdine.Caption:=DataSetIsc.FieldByName('COD_ORDINE').DisplayLabel;
  lblProvincia.Caption:=DataSetIsc.FieldByName('COD_PROVINCIA').DisplayLabel;
  lblCodIscrizione.Caption:=DataSetIsc.FieldByName('COD_ISCRIZIONE').DisplayLabel;
  lblNote.Caption:=DataSetIsc.FieldByName('NOTE').DisplayLabel;
  lblPEC.Caption:=DataSetIsc.FieldByName('EMAIL_PEC').DisplayLabel;
end;

procedure TW047FIscrizioneOrdineFM.AbilitaComponenti;
begin
  AbilitaComponentiRegion(IWFrameRegion,DataSetIsc);

  btnModifica.Visible:=not ReadOnly and (DataSetIsc.State = dsBrowse);
  if btnModifica.Visible then
    btnModifica.Enabled:=True;
  btnConferma.Visible:=DataSetIsc.State <> dsBrowse;
  if btnConferma.Visible then
    btnConferma.Enabled:=True;
  btnAnnulla.Visible:=DataSetIsc.State <> dsBrowse;
  if btnAnnulla.Visible then
    btnAnnulla.Enabled:=True;
  btnChiudi.Visible:=DataSetIsc.State = dsBrowse;
  if btnChiudi.Visible then
    btnChiudi.Enabled:=True;

  evtAbilitaJQ(DataSetIsc.State <> dsBrowse);
end;

procedure TW047FIscrizioneOrdineFM.Visualizza;
var Titolo:String;
begin
  Titolo:=IfThen(DataSetIsc.State = dsInsert,'Inserimento ',IfThen(DataSetIsc.State = dsEdit,'Modifica ','Visualizzazione '))
        + 'Ordine professionale di '
        + W047DM2.selAnagrafeW.FieldByName('COGNOME').AsString + ' '
        + W047DM2.selAnagrafeW.FieldByName('NOME').AsString + ' ('
        + W047DM2.selAnagrafeW.FieldByName('MATRICOLA').AsString + ')';

  if AzioneRichiamo = 'I' then
    CercaOrdineProf;

  (Self.Parent as TWR010FBase).VisualizzajQMessaggio(JQuery,690,-1,EM2PIXEL * 24,Titolo,'#' + Self.Name,False,True);
end;

procedure TW047FIscrizioneOrdineFM.btnModificaClick(Sender: TObject);
begin
  DataSetIsc.Edit;
  AbilitaComponenti;
end;

procedure TW047FIscrizioneOrdineFM.CercaOrdineProf;
var codReperito:String;
begin
  codReperito:=W047DM2.CercaOrdineProf(ValoreV430a);
  if not codReperito.IsEmpty then
    DataSetIsc.FieldByName('COD_ORDINE').AsString:=codReperito;
end;

procedure TW047FIscrizioneOrdineFM.btnConfermaClick(Sender: TObject);
var Inserimento:Boolean;
    codReperito,Messaggio:String;
begin
  DataSetIsc.FieldByName('NOTE').AsString:=Copy(R180SostituisciCaratteriSpeciali(Trim(DataSetIsc.FieldByName('NOTE').AsString)),1,4000);
  Inserimento:=DataSetIsc.State = dsInsert;
  codReperito:=W047DM2.CercaOrdineProf(ValoreV430a);

  try  //gestione codici provincia-ordine non validi
    with W047DM2.selT481_GetCodProv do
    begin
      Close;
      SetVariable('PROV',DataSetIsc.FieldByName('COD_PROVINCIA').AsString);
      Open;
      if RecordCount = 0 then
      begin
        MsgBox.MessageBox(Format('"%s" non è una provincia valida', [DataSetIsc.FieldByName('COD_PROVINCIA').AsString]),INFORMA);
        Exit;
      end
      else
        DataSetIsc.FieldByName('COD_PROVINCIA').AsString:=FieldByName('COD_PROVINCIA').AsString;
    end;

    with W047DM2.selSG221_GetCodOrdine do
    begin
      Close;
      SetVariable('CODICE',DataSetIsc.FieldByName('COD_ORDINE').AsString);
      Open;
      if RecordCount = 0 then
      begin
        MsgBox.MessageBox(Format('"%s" non è un Ordine Professionale valido', [DataSetIsc.FieldByName('COD_ORDINE').AsString]),INFORMA);
        Exit;
      end
      else
        DataSetIsc.FieldByName('COD_ORDINE').AsString:=FieldByName('COD_ORDINE').AsString;
    end;
  finally
    W047DM2.selT481_GetCodProv.Close;
    W047DM2.selSG221_GetCodOrdine.Close;
  end;

  if (not codReperito.IsEmpty) and (codReperito <> DataSetIsc.FieldByName('COD_ORDINE').AsString) then
  begin
    Messaggio:='E'' stato inserito un Ordine Professionale (' + DataSetIsc.FieldByName('COD_ORDINE').AsString +
               ') non legato alla propria qualifica (' + codReperito + ').' + CRLF +
               'Il dato viene comunque salvato, assicurarsi della sua correttezza e nel caso variarlo.';
    MsgBox.WebMessageDlg(Messaggio,mtInformation,[mbOK],OnConfermaOrdine,'','',mbOk);
  end
  else
    OnConfermaOrdine(Sender,mrOK,'');
end;

procedure TW047FIscrizioneOrdineFM.OnConfermaOrdine(Sender: TObject; ModalResult: TmeIWModalResult; KeyID: String);
begin
  DataSetIsc.Post;
  //Chiudo e riapo il dataset corrente per refresh
  DataSetIsc.Close;
  (Self.Owner as TW047FIscrizioneOrdine).GetIscrizione;
  btnChiudiClick(nil);
end;

procedure TW047FIscrizioneOrdineFM.btnAnnullaClick(Sender: TObject);
begin
  DataSetIsc.Cancel;
  if AzioneRichiamo = 'A' then
    AbilitaComponenti
  else
    btnChiudiClick(nil);
end;

procedure TW047FIscrizioneOrdineFM.btnChiudiClick(Sender: TObject);
begin
  Free;
end;

end.
