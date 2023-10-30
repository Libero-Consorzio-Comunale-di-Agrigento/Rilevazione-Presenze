unit W042UCaricamentoFM;

interface

uses
  SysUtils, Classes, Controls, Forms, IWAppForm,
  IWVCLBaseContainer, IWContainer, IWRegion, IWHTMLContainer,
  IWHTML40Container, IWCompButton, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWTypes, DBClient, IWDBGrids,
  DB, Oracle, StrUtils, Math, Variants, OracleData, WR010UBase,
  A000UInterfaccia, C180FunzioniGenerali, C190FunzioniGeneraliWeb, R010UPAGINAWEB,
  W042UDatiConiugeDM,
  medpIWDBGrid, meIWMemo, medpIWMessageDlg, meIWButton, IWCompJQueryWidget, meIWImageFile,
  IWCompGrids, IWCompLabel, meIWLabel, IWCompEdit, meIWEdit, IWCompMemo,
  IWDBStdCtrls, meIWDBEdit, meIWDBMemo, IWApplication, IWCompExtCtrls,
  medpIWImageButton, TypInfo, WR200UBaseFM, UIntfWebT480, IWCompListbox,
  meIWComboBox, meIWDBComboBox, meIWDBLabel, W000UMessaggi;

type
  TW042FCaricamentoFM = class(TWR200FBaseFM)
    btnModifica: TmedpIWImageButton;
    btnConferma: TmedpIWImageButton;
    btnAnnulla: TmedpIWImageButton;
    btnChiudi: TmedpIWImageButton;
    cmbSesso: TmeIWComboBox;
    cmbMotivoEsclusione: TmeIWComboBox;
    lblCognome: TmeIWLabel;
    lblNome: TmeIWLabel;
    lblSesso: TmeIWLabel;
    lblDataNascita: TmeIWLabel;
    lblCodiceFiscale: TmeIWLabel;
    lblDataMatrimonio: TmeIWLabel;
    lblDataEsclusione: TmeIWLabel;
    lblMotivoEsclusione: TmeIWLabel;
    lblComuneNascita: TmeIWLabel;
    edtComuneNascita: TmeIWEdit;
    lblDProvincia: TmeIWLabel;
    edtDProvincia: TmeIWEdit;
    btnSelComune: TmeIWButton;
    DataSourceCar: TDataSource;
    dedtCognome: TmeIWDBEdit;
    dedtNome: TmeIWDBEdit;
    dedtDataNascita: TmeIWDBEdit;
    dedtDataMatrimonio: TmeIWDBEdit;
    dedtDataEsclusione: TmeIWDBEdit;
    dedtCodiceFiscale: TmeIWDBEdit;
    dlblDataReg: TmeIWDBLabel;
    dlblInfoAnomalie: TmeIWDBLabel;
    lblDataReg: TmeIWLabel;
    btnConfermaDiretta: TmedpIWImageButton;
    dlblSituazione: TmeIWDBLabel;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure btnModificaClick(Sender: TObject);
    procedure btnConfermaClick(Sender: TObject);
    procedure btnAnnullaClick(Sender: TObject);
    procedure btnChiudiClick(Sender: TObject);
    procedure edtComuneNascitaAsyncExit(Sender: TObject; EventParams: TStringList);
    procedure AssegnaValori(Sender: TObject; EventParams: TStringList);
    procedure DataSourceCarDataChange(Sender: TObject; Field: TField);
  private
    IntfWebT480:TIntfWebT480;
    procedure ImpostaLabel;
    procedure ImpostaValoriCombo;
    procedure AbilitaComponenti;
    procedure ResultComune;
  public
    DataSetCar:TOracleDataSet;
    ReadOnly: Boolean;
    W042DM2:TW042FDatiConiugeDM;
    AzioneRichiamo:String;
    procedure Apri;
    procedure Visualizza;
  end;

implementation

uses W042UDatiConiuge;

{$R *.dfm}

procedure TW042FCaricamentoFM.IWFrameRegionCreate(Sender: TObject);
begin
  Self.Parent:=TIWAppForm(Self.Owner);
end;

procedure TW042FCaricamentoFM.Apri;
begin
  IntfWebT480:=TIntfWebT480.Create(Self.Parent);
  with IntfWebT480 do
  begin
    DataSource:=W042DM2.dsrQ480;
    edtCitta:=edtComuneNascita;
    edtProvincia:=edtDProvincia;
    btnLookup:=btnSelComune;
    CustomResultLookup:=ResultComune;
  end;
  DataSourceCar.DataSet:=DataSetCar;
  if AzioneRichiamo = 'M' then
    DataSetCar.Edit
  else if AzioneRichiamo = 'I' then
    DataSetCar.Append;
  ImpostaLabel;
  ImpostaValoriCombo;
  AbilitaComponenti;
end;

procedure TW042FCaricamentoFM.ImpostaLabel;
begin
  lblCognome.Caption:=DataSetCar.FieldByName('COGNOME').DisplayLabel;
  lblNome.Caption:=DataSetCar.FieldByName('NOME').DisplayLabel;
  lblSesso.Caption:=DataSetCar.FieldByName('SESSO').DisplayLabel;
  lblDataNascita.Caption:=DataSetCar.FieldByName('DATANAS').DisplayLabel;
  lblComuneNascita.Caption:=DataSetCar.FieldByName('D_COMUNE').DisplayLabel;
  lblDProvincia.Caption:=DataSetCar.FieldByName('D_PROVINCIA').DisplayLabel;
  lblCodiceFiscale.Caption:=DataSetCar.FieldByName('CODFISCALE').DisplayLabel;
  lblDataMatrimonio.Caption:=DataSetCar.FieldByName('DATAMAT').DisplayLabel;
  lblDataEsclusione.Caption:=DataSetCar.FieldByName('DATASEP').DisplayLabel;
  lblMotivoEsclusione.Caption:=DataSetCar.FieldByName('MOTIVO_ESCLUSIONE').DisplayLabel;
  lblDataReg.Caption:=DataSetCar.FieldByName('DATA_REG').DisplayLabel + ':';
end;

procedure TW042FCaricamentoFM.ImpostaValoriCombo;
begin
  cmbSesso.ItemIndex:=IfThen(DataSetCar.FieldByName('SESSO').AsString = 'M',0,1);
  cmbMotivoEsclusione.ItemIndex:=IfThen(DataSetCar.FieldByName('MOTIVO_ESCLUSIONE').AsString = '1',1,
                                 IfThen(DataSetCar.FieldByName('MOTIVO_ESCLUSIONE').AsString = '2',0,-1));
end;

procedure TW042FCaricamentoFM.AbilitaComponenti;
var StatoInsMod,CarONuc,ConiugeDip:Boolean;
begin
  //AbilitaComponentiRegion(IWFrameRegion,DataSetCar);
  StatoInsMod:=DataSetCar.State in [dsEdit,dsInsert];
  ConiugeDip:=not DataSetCar.FieldByName('MATRICOLA').IsNull;
  CarONuc:=(DataSetCar.FieldByName('ACARICO_STORIA').AsString = 'S') or (DataSetCar.FieldByName('NUCLEO_STORIA').AsString = 'S');
  //Dati anagrafici
  dedtCognome.Enabled:=StatoInsMod and not ConiugeDip and not CarONuc;
  dedtNome.Enabled:=StatoInsMod and not ConiugeDip and not CarONuc;
  cmbSesso.Enabled:=StatoInsMod and not ConiugeDip and not CarONuc;
  dedtDataNascita.Enabled:=StatoInsMod and not ConiugeDip and not CarONuc and (DataSetCar.FieldByName('GIUSTIFICATIVI').AsString <> 'S');
  edtComuneNascita.Enabled:=StatoInsMod and not ConiugeDip and not CarONuc;
  edtDProvincia.Enabled:=False;
  dedtCodiceFiscale.Enabled:=StatoInsMod and not ConiugeDip and not CarONuc;
  dedtDataMatrimonio.Enabled:=StatoInsMod and not CarONuc;
  dedtDataEsclusione.Enabled:=StatoInsMod and not CarONuc;
  cmbMotivoEsclusione.Enabled:=StatoInsMod and not CarONuc;
  //Pulsanti
  btnConfermaDiretta.Visible:=not ReadOnly and not StatoInsMod and (DataSetCar.FieldByName('INSERIMENTO_CU').AsString = 'N') and (DataSetCar.FieldByName('ACARICO_OGGI').AsString <> 'S') and DataSetCar.FieldByName('ANOMALIE').IsNull;
  if btnConfermaDiretta.Visible then
    btnConfermaDiretta.Enabled:=True;
  btnModifica.Visible:=not ReadOnly and not StatoInsMod and not CarONuc;
  if btnModifica.Visible then
    btnModifica.Enabled:=True;
  btnConferma.Visible:=StatoInsMod;
  if btnConferma.Visible then
    btnConferma.Enabled:=True;
  btnAnnulla.Visible:=StatoInsMod;
  if btnAnnulla.Visible then
    btnAnnulla.Enabled:=True;
  btnChiudi.Visible:=not StatoInsMod;
  if btnChiudi.Visible then
    btnChiudi.Enabled:=True;
  btnChiudi.Confirmation:=IfThen(not btnConfermaDiretta.Visible and not btnModifica.Visible,'',//non chiedo quando non posso intervenire
                          IfThen(not DataSetCar.FieldByName('ANOMALIE').IsNull,'Si desidera uscire ignorando le anomalie segnalate?',
                          IfThen(DataSetCar.FieldByName('INSERIMENTO_CU').AsString = 'N','Si desidera uscire senza confermare i dati?')));
  //Segnalazioni
  lblDataReg.Visible:=not StatoInsMod and not DataSetCar.FieldByName('DATA_REG').IsNull and not btnConfermaDiretta.Visible;
  dlblDataReg.Visible:=lblDataReg.Visible;
  dlblInfoAnomalie.Css:='font_grassetto' + IfThen(DataSetCar.FieldByName('ANOMALIE').AsString <> '',' font_rosso',
                                           IfThen(StatoInsMod,' invisibile',
                                           IfThen(DataSetCar.FieldByName('INFOW').AsString <> '',' font_blu',' font_verde')));
  dlblSituazione.Css:='font_grassetto' + IfThen(DataSetCar.FieldByName('ANOMALIE').AsString <> '',' font_rosso',
                                         IfThen(DataSetCar.FieldByName('ACARICO_OGGI').AsString = 'S',' font_verde',''));
  //Aggiorno descrizioni non data-aware
  edtComuneNascita.Text:=DataSetCar.FieldByName('D_COMUNE').AsString;
  edtDProvincia.Text:=DataSetCar.FieldByName('D_PROVINCIA').AsString;
end;

procedure TW042FCaricamentoFM.Visualizza;
var Titolo:String;
begin
  Titolo:=IfThen(DataSetCar.State = dsInsert,'Inserimento ',IfThen(DataSetCar.State = dsEdit,'Modifica ','Visualizzazione '))
        + 'coniuge di '
        + W042DM2.selAnagrafeW.FieldByName('COGNOME').AsString + ' '
        + W042DM2.selAnagrafeW.FieldByName('NOME').AsString + ' ('
        + W042DM2.selAnagrafeW.FieldByName('MATRICOLA').AsString + ')';
  (Self.Parent as TWR010FBase).VisualizzajQMessaggio(JQuery,580,-1,EM2PIXEL * 24,Titolo,'#' + Self.Name,False,True);
end;

procedure TW042FCaricamentoFM.edtComuneNascitaAsyncExit(Sender: TObject; EventParams: TStringList);
begin
  if edtComuneNascita.Text <> DataSetCar.FieldByName('D_COMUNE').AsString then
    GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[btnSelComune.HTMLName]));
end;

procedure TW042FCaricamentoFM.ResultComune;
begin
  DataSetCar.FieldByName('COMNAS').AsString:=IntfWebT480.ValoreChiave;
  AbilitaComponenti;
end;

procedure TW042FCaricamentoFM.btnModificaClick(Sender: TObject);
begin
  DataSetCar.Edit;
  AbilitaComponenti;
end;

procedure TW042FCaricamentoFM.DataSourceCarDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TW042FCaricamentoFM.AssegnaValori(Sender: TObject; EventParams: TStringList);
begin
  //Fa scattare il CalcFields e quindi vengono aggiornati i messaggi
  DataSetCar.FieldByName('COGNOME').AsString:=Trim(UpperCase(DataSetCar.FieldByName('COGNOME').AsString));
  DataSetCar.FieldByName('NOME').AsString:=Trim(UpperCase(DataSetCar.FieldByName('NOME').AsString));
  DataSetCar.FieldByName('SESSO').AsString:=IfThen(cmbSesso.ItemIndex = 0,'M','F');
  DataSetCar.FieldByName('CODFISCALE').AsString:=Trim(UpperCase(DataSetCar.FieldByName('CODFISCALE').AsString));
  DataSetCar.FieldByName('MOTIVO_ESCLUSIONE').AsString:=IfThen(cmbMotivoEsclusione.ItemIndex = 0,'2',
                                                        IfThen(cmbMotivoEsclusione.ItemIndex = 1,'1'));
end;

procedure TW042FCaricamentoFM.btnConfermaClick(Sender: TObject);
begin
  AbilitaComponenti;
  if not DataSetCar.FieldByName('ANOMALIE').IsNull then
    raise exception.Create(A000MSG_W042_ERR_ANOMALIE);
  W042DM2.Registrazione(IfThen(DataSetCar.State = dsInsert,'I','U'));
  //Chiudo il dataset corrente per refresh
  DataSetCar.Close;
  (Self.Owner as TW042FDatiConiuge).GetConiugi;
  btnChiudiClick(nil);
end;

procedure TW042FCaricamentoFM.btnAnnullaClick(Sender: TObject);
begin
  DataSetCar.Cancel;
  ImpostaValoriCombo;
  if AzioneRichiamo = 'A' then
    AbilitaComponenti
  else
    btnChiudiClick(nil);
end;

procedure TW042FCaricamentoFM.btnChiudiClick(Sender: TObject);
begin
  FreeAndNil(IntfWebT480);
  Free;
end;

end.
