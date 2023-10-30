unit WA050UOrologiDettFM;

interface

uses
  Windows, OracleData,Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR205UDettTabellaFM, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWDBExtCtrls, IWCompEdit,
  IWDBStdCtrls, meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompLabel, meIWDBRadioGroup, IWCompCheckbox, meIWDBCheckBox,
  IWAdvRadioGroup, meTIWAdvRadioGroup, IWCompListbox, meIWDBLookupComboBox,
  Oracle, Db,IWCompExtCtrls, UIntfWebT480,
  IWCompJQueryWidget, meIWImageFile,meIWLabel, IWCompButton, meIWButton, meIWEdit,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb, WC015USelEditGridFM,
  A000UInterfaccia, IWHTMLControls, meIWLink,
  WR100UBase,WA011UEntiLocali, medpIWMultiColumnComboBox, System.StrUtils;

type
  TWA050FOrologiDettFM = class(TWR205FDettTabellaFM)
    dedtCodice: TmeIWDBEdit;
    lblCodice: TmeIWLabel;
    dedtDescrizione: TmeIWDBEdit;
    lblDescrizione: TmeIWLabel;
    lblIndirizzo: TmeIWLabel;
    dedtIndirizzo: TmeIWDBEdit;
    rgpFunzione: TmeTIWAdvRadioGroup;
    dchkPausaMensa: TmeIWDBCheckBox;
    lblDescTimbratureMensa: TmeIWLabel;
    lblVersoTimbratura: TmeIWLabel;
    drgpVersoTimbratura: TmeIWDBRadioGroup;
    rgpTipologiaLocalita: TmeTIWAdvRadioGroup;
    lblRilevatore: TmeIWLabel;
    dedtRilevatore: TmeIWDBEdit;
    lblPostazione: TmeIWLabel;
    dedtPostazione: TmeIWDBEdit;
    lblMessaggi: TmeIWLabel;
    lblIndirizzoTerm: TmeIWLabel;
    dedtIndirizzoTerm: TmeIWDBEdit;
    lblIndirizzoIP: TmeIWLabel;
    dedtIndirizzoIP: TmeIWDBEdit;
    dchkRicezioneMessaggi: TmeIWDBCheckBox;
    edtDescComune: TmeIWEdit;
    btnComuni: TmeIWButton;
    cmbDescrizioneLocalita: TmeIWDBLookupComboBox;
    cmbScarico: TmeIWDBLookupComboBox;
    lnkDescrizioneLocalita: TmeIWLink;
    dedtComune: TmeIWDBEdit;
    lnkScarico: TmeIWLink;
    lnkTimbratureMensa: TmeIWLink;
    cmbTimbratureMensa: TMedpIWMultiColumnComboBox;
    lblPosizioneRilevatore: TmeIWLabel;
    lblLat: TmeIWLabel;
    dedtLat: TmeIWDBEdit;
    lblLng: TmeIWLabel;
    dedtLng: TmeIWDBEdit;
    imgCercaPosizione: TmeIWImageFile;
    lblRaggioValidita: TmeIWLabel;
    dedtRaggioValidita: TmeIWDBEdit;
    lblRaggioValiditaMetri: TmeIWLabel;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure rgpFunzioneAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure rgpTipologiaLocalitaClick(Sender: TObject);
    procedure cmbTimbratureMensaAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure lnkDescrizioneLocalitaClick(Sender: TObject);
    procedure lnkScaricoClick(Sender: TObject);
    procedure lnkTimbratureMensaClick(Sender: TObject);
    (*procedure imgCercaPosizioneClick(Sender: TObject);*)
    procedure imgCercaPosizioneAsyncClick(Sender: TObject; EventParams: TStringList);
  private
    IntfWebT480:TIntfWebT480;
    WC015:TWC015FSelEditGridFM;
    procedure CaricaComboLocalita;
  public
    procedure DataSet2Componenti; override;
    procedure AbilitaComponenti; override;
    procedure Componenti2DataSet; override;
    procedure CaricaMultiColumnCombobox; override;
  end;

implementation

uses WA050UOrologi, WA050UOrologiDM, WA021UCausGiustif,
     WA031UParScarico, IWApplication;

{$R *.dfm}

procedure TWA050FOrologiDettFM.IWFrameRegionCreate(Sender: TObject);
var
  LPosRilVisible: Boolean;
begin
  inherited;
  IntfWebT480:=TIntfWebT480.Create(Self.Parent);
  with IntfWebT480 do
  begin
    DataSource:=(WR302DM as TWA050FOrologiDM).dselLocalita;
    edtCitta:=edtDescComune;
    dedtCodice:=dedtComune;
    btnLookup:=btnComuni;
  end;

  with TWA050FOrologiDM(WR302DM) do
  begin
    selI100.First;
    while not selI100.Eof do
    begin
      selI100.Next;
    end;

    if selTabella.FieldByName('TIPO_LOCALITA').AsString = 'C' then
    begin
      edtDescComune.Visible:=true;
      btnComuni.Visible:=true;
      cmbDescrizioneLocalita.Visible:=false;
    end
    else
    begin
      edtDescComune.Visible:=false;
      btnComuni.Visible:=false;
      cmbDescrizioneLocalita.Visible:=true;
    end;
  end;

  // visibilità dati di posizione rilevatore
  LPosRilVisible:=Parametri.ModuloInstallato['BOLLATRICE_VIRTUALE'];
  lblPosizioneRilevatore.Visible:=LPosRilVisible;
  lblLat.Visible:=LPosRilVisible;
  dedtLat.Visible:=LPosRilVisible;
  lblLng.Visible:=LPosRilVisible;
  dedtLng.Visible:=LPosRilVisible;
  imgCercaPosizione.Visible:=LPosRilVisible;
  lblRaggioValidita.Visible:=LPosRilVisible;
  dedtRaggioValidita.Visible:=LPosRilVisible;
  lblRaggioValiditaMetri.Visible:=LPosRilVisible;
  C190VisualizzaElemento(JQuery,'wa050PosizioneRilevatore',LPosRilVisible);
end;

procedure TWA050FOrologiDettFM.lnkDescrizioneLocalitaClick(Sender: TObject);
begin
  inherited;
  if WR302DM.selTabella.FieldByName('TIPO_LOCALITA').AsString = 'C' then
    TWR100FBase(Self.Parent).AccediForm(530,'CODICE='+ TWA050FOrologiDM(WR302DM).selLocalita.FieldByName('CODICE').AsString)
  else
  begin
    WC015:=TWC015FSelEditGridFM.Create(Self.Parent);
    WC015.medpSearchField:='DESCRIZIONE';
    WC015.Visualizza('Località trasferta',TWA050FOrologiDM(WR302DM).selM042);
  end;
end;

procedure TWA050FOrologiDettFM.lnkScaricoClick(Sender: TObject);
begin
  inherited;
  TWA050FOrologi(Self.Parent).AccediForm(119,'SCARICO=' + TWA050FOrologiDM(WR302DM).selTabellaSCARICO.AsString)
end;

procedure TWA050FOrologiDettFM.lnkTimbratureMensaClick(Sender: TObject);
begin
  inherited;
  TWA050FOrologi(Self.Parent).AccediForm(109,'CODICE=' + TWA050FOrologiDM(WR302DM).selTabellaCAUSMENSA.AsString)
end;

procedure TWA050FOrologiDettFM.CaricaComboLocalita;
begin
  //Chiudo e riapro sempre selLocalità per leggere i valori aggiornati
  if WR302DM.selTabella.FieldByName('TIPO_LOCALITA').AsString = 'C' then
  begin
    if TWA050FOrologiDM(WR302DM).selLocalita.SQL.Text.Trim <> 'SELECT CODICE, CITTA FROM T480_COMUNI :ORDERBY' then
    begin
      TWA050FOrologiDM(WR302DM).selLocalita.SQL.Text:='SELECT CODICE, CITTA FROM T480_COMUNI :ORDERBY';
      TWA050FOrologiDM(WR302DM).selLocalita.SetVariable('ORDERBY','ORDER BY CITTA');
      TWA050FOrologiDM(WR302DM).selLocalita.Close;
    end;
  end
  else
  begin
    if TWA050FOrologiDM(WR302DM).selLocalita.SQL.Text.Trim <> 'SELECT CODICE, DESCRIZIONE CITTA, ROWID FROM M042_LOCALITA :ORDERBY' then
    begin
      TWA050FOrologiDM(WR302DM).selLocalita.SQL.Text:='SELECT CODICE, DESCRIZIONE CITTA, ROWID FROM M042_LOCALITA :ORDERBY';
      TWA050FOrologiDM(WR302DM).selLocalita.SetVariable('ORDERBY','ORDER BY DESCRIZIONE');
      TWA050FOrologiDM(WR302DM).selLocalita.Close;
    end;
  end;
  TWA050FOrologiDM(WR302DM).selLocalita.Open;
end;

procedure TWA050FOrologiDettFM.CaricaMultiColumnComboBox;
begin
  TWA050FOrologiDM(WR302DM).Q305.Refresh;
  TWA050FOrologiDM(WR302DM).Q305.First;
  while not TWA050FOrologiDM(WR302DM).Q305.Eof do
  begin
    cmbTimbratureMensa.AddRow(TWA050FOrologiDM(WR302DM).Q305.FieldByName('CODICE').AsString + ';' + TWA050FOrologiDM(WR302DM).Q305.FieldByName('DESCRIZIONE').AsString);
    TWA050FOrologiDM(WR302DM).Q305.Next;
  end;
end;

procedure TWA050FOrologiDettFM.DataSet2Componenti;
begin
  inherited;
  with TWA050FOrologiDM(WR302DM) do
  begin
    cmbTimbratureMensa.ItemIndex:=-1;
    cmbTimbratureMensa.Text:=selTabella.FieldByName('CAUSMENSA').AsString;
    lblDescTimbratureMensa.Caption:=VarToStr(TWA050FOrologiDM(WR302DM).Q305.LookUp('CODICE', selTabella.FieldByName('CAUSMENSA').AsString, 'DESCRIZIONE'));
    CaricaComboLocalita;

    if selTabella.FieldByName('TIPO_LOCALITA').AsString = 'C' then
    begin
      edtDescComune.Text:=selTabella.FieldByName('D_LOCALITA').AsString;
      rgpTipologiaLocalita.ItemIndex:=0;
      edtDescComune.Visible:=true;
      btnComuni.Visible:=true;
      cmbDescrizioneLocalita.Visible:=false;
    end
    else if selTabella.FieldByName('TIPO_LOCALITA').AsString = 'P' then
    begin
      rgpTipologiaLocalita.ItemIndex:=1;
      edtDescComune.Visible:=false;
      btnComuni.Visible:=false;
      cmbDescrizioneLocalita.Visible:=true;
    end;

    if selTabella.FieldByName('FUNZIONE').AsString = 'P' then
      rgpFunzione.ItemIndex:=0
    else if selTabella.FieldByName('FUNZIONE').AsString = 'M' then
      rgpFunzione.ItemIndex:=1
    else if selTabella.FieldByName('FUNZIONE').AsString = 'E' then
      rgpFunzione.ItemIndex:=2;
  end;
end;

procedure TWA050FOrologiDettFM.imgCercaPosizioneAsyncClick(Sender: TObject;  EventParams: TStringList);
var
  LJsCode: String;
  LFmtSettings: TFormatSettings;
  LEditMode: Boolean;
begin
  LEditMode:=WR302DM.selTabella.State in [dsInsert,dsEdit];

  LFmtSettings:=TFormatSettings.Create;
  LFmtSettings.DecimalSeparator:='.';

  LJsCode:=Format(
            'setInitialData("%s - %s", %s, %g, %g, %d); '#13#10,
            [WR302DM.selTabella.FieldByName('CODICE').AsString,
             WR302DM.selTabella.FieldByName('DESCRIZIONE').AsString,
             IfThen(LEditMode,'true','false'),
             WR302DM.selTabella.FieldByName('LAT').AsFloat,
             WR302DM.selTabella.FieldByName('LNG').AsFloat,
             WR302DM.selTabella.FieldByName('RAGGIO_VALIDITA').AsInteger],
            LFmtSettings);
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(LJsCode);
end;

(*
procedure TWA050FOrologiDettFM.imgCercaPosizioneClick(Sender: TObject);
var
  LJsCode: String;
  LFmtSettings: TFormatSettings;
  LEditMode: Boolean;
begin
  (Self.Parent as TWR100FBase).VisualizzaJQMessaggio(jQuery,1300,800,EM2PIXEL * 80, 'Ricerca posizione', '#WA050_modalRicercaPosizione', True, True, -1, '', ''{, 'btnConferma'});

  // modifica alcune impostazioni della dialog
  LEditMode:=WR302DM.selTabella.State in [dsInsert,dsEdit];
  if LEditMode then
  begin
    jQuery.OnReady.Text:=jQuery.OnReady.Text.Replace(
      '  closeOnEscape: false,',
      '  closeOnEscape: false,                                    '#13#10 +
      '  buttons:  [                                              '#13#10 +
      '    {                                                      '#13#10 +
      '       text: "OK",                                         '#13#10 +
      '       class: "pulsante",                                  '#13#10 +
      '       click: function() {                                 '#13#10 +
      '         confirmPosition();                                '#13#10 +
      '         $(this).dialog("close");                          '#13#10 +
      '       }                                                   '#13#10 +
      '    },                                                     '#13#10 +
      '    {                                                      '#13#10 +
      '       text: "Annulla",                                    '#13#10 +
      '       class: "pulsante",                                  '#13#10 +
      '       click: function() {                                 '#13#10 +
      '         $(this).dialog("close");                          '#13#10 +
      '       }                                                   '#13#10 +
      '    }                                                      '#13#10 +
      '  ],                                                       '#13#10,
      []
    );
  end;

  LFmtSettings:=TFormatSettings.Create;
  LFmtSettings.DecimalSeparator:='.';

  LJsCode:=Format('setInitialData("%s - %s", "%s", %g, %g, %d); ',
                  [WR302DM.selTabella.FieldByName('CODICE').AsString,
                   WR302DM.selTabella.FieldByName('DESCRIZIONE').AsString,
                   IfThen(LEditMode,'true','false'),
                   WR302DM.selTabella.FieldByName('LAT').AsFloat,
                   WR302DM.selTabella.FieldByName('LNG').AsFloat,
                   WR302DM.selTabella.FieldByName('RAGGIO_VALIDITA').AsInteger],
                  LFmtSettings);
  (Self.Parent as TWR100FBase).AddToInitProc(LJsCode);
end;
*)

procedure TWA050FOrologiDettFM.AbilitaComponenti;
begin
  inherited;
  if (WR302DM.selTabella.State in [dsInsert,dsEdit]) then
  begin
    CaricaComboLocalita;

    if WR302DM.selTabella.FieldByName('FUNZIONE').AsString <> 'E' then
      WR302DM.selTabella.FieldByName('CAUSMENSA').Clear;

    cmbTimbratureMensa.Enabled:=WR302DM.selTabella.FieldByName('FUNZIONE').AsString = 'E';
    lnkTimbratureMensa.Enabled:=cmbTimbratureMensa.Enabled;
    lblDescTimbratureMensa.Enabled:=cmbTimbratureMensa.Enabled;
    dchkPausaMensa.Enabled:=(WR302DM.selTabella.FieldByName('FUNZIONE').AsString = 'P') or (WR302DM.selTabella.FieldByName('FUNZIONE').AsString = 'E');
  end;
  imgCercaPosizione.Enabled:=True;
end;

procedure TWA050FOrologiDettFM.Componenti2DataSet;
begin
  inherited;
  with TWA050FOrologiDM(WR302DM) do
  begin
    selTabella.FieldByName('CAUSMENSA').AsString:=cmbTimbratureMensa.Text;

   if (rgpTipologiaLocalita.ItemIndex = 0) then
      selTabella.FieldByName('TIPO_LOCALITA').AsString:='C'
    else if (rgpTipologiaLocalita.ItemIndex = 1) then
      selTabella.FieldByName('TIPO_LOCALITA').AsString:='P'
    else
      selTabella.FieldByName('TIPO_LOCALITA').AsString:='';

    if rgpFunzione.ItemIndex = 0 then
      selTabella.FieldByName('FUNZIONE').AsString:='P'
    else if rgpFunzione.ItemIndex = 1 then
      selTabella.FieldByName('FUNZIONE').AsString:='M'
    else if rgpFunzione.ItemIndex = 2 then
      selTabella.FieldByName('FUNZIONE').AsString:='E'
  end;
end;

procedure TWA050FOrologiDettFM.cmbTimbratureMensaAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  with TWA050FOrologiDM(WR302DM) do
  begin
    if Index <> -1 then
    begin
      selTabella.FieldByName('CAUSMENSA').AsString:=cmbTimbratureMensa.Text;
      lblDescTimbratureMensa.Caption:=cmbTimbratureMensa.Items[Index].RowData[1];
    end
    else
    begin
      selTabella.FieldByName('CAUSMENSA').AsString:='';
      lblDescTimbratureMensa.Caption:='';
    end;
  end;
end;

procedure TWA050FOrologiDettFM.rgpFunzioneAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  if rgpFunzione.ItemIndex = 0 then
    TWA050FOrologiDM(WR302DM).selTabella.FieldByName('FUNZIONE').AsString:='P'
  else if rgpFunzione.ItemIndex = 1 then
    TWA050FOrologiDM(WR302DM).selTabella.FieldByName('FUNZIONE').AsString:='M'
  else if rgpFunzione.ItemIndex = 2 then
    TWA050FOrologiDM(WR302DM).selTabella.FieldByName('FUNZIONE').AsString:='E';

  abilitaComponenti;
end;

procedure TWA050FOrologiDettFM.rgpTipologiaLocalitaClick(Sender: TObject);
begin
  inherited;
  with TWA050FOrologiDM(WR302DM) do
  begin
    if rgpTipologiaLocalita.ItemIndex = 0 then
    begin
      selTabella.FieldByName('TIPO_LOCALITA').AsString:='C';
      edtDescComune.Visible:=true;
      btnComuni.Visible:=true;
      cmbDescrizioneLocalita.Visible:=false;
    end
    else if rgpTipologiaLocalita.ItemIndex = 1  then
    begin
      selTabella.FieldByName('TIPO_LOCALITA').AsString:='P';
      edtDescComune.Visible:=false;
      btnComuni.Visible:=false;
      cmbDescrizioneLocalita.Visible:=true;
    end;
    //Ripulisco tutti i campi
    selTabella.FieldByName('D_LOCALITA').AsString:='';
    selTabella.FieldByName('COD_LOCALITA').AsString:='';
    selTabella.FieldByName('CAUSMENSA').AsString:='';
    dataSet2Componenti;
    abilitaComponenti;
  end;
end;

end.
