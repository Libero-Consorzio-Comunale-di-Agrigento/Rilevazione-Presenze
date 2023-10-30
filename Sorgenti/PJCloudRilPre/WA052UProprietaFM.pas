unit WA052UProprietaFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR200UBaseFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompButton, meIWButton, WR100UBase,
  IWCompCheckbox, IWDBStdCtrls, meIWDBCheckBox, WA052UParCarDM, IWCompLabel,
  meIWLabel, meIWCheckBox, StrUtils, IWCompExtCtrls, meIWRadioGroup,A027UCostanti,
  IWCompEdit, meIWEdit, WC013UCheckListFM, R500Lin;

type
  TWA052FProprietaFM = class(TWR200FBaseFM)
    btnChiudi: TmeIWButton;
    btnConferma: TmeIWButton;
    lblGiorniMese: TmeIWLabel;
    chkFestivo: TmeIWCheckBox;
    chkNonLav: TmeIWCheckBox;
    chkGrassetto: TmeIWCheckBox;
    rgpGiustificativi: TmeIWRadioGroup;
    lblGiustificativi: TmeIWLabel;
    lblTimbrature: TmeIWLabel;
    chkOrologio: TmeIWCheckBox;
    chkTimbratureManuali: TmeIWCheckBox;
    lblAnomOrologio: TmeIWLabel;
    edtAnomOrologio: TmeIWEdit;
    rgpCausale: TmeIWRadioGroup;
    lblCausale: TmeIWLabel;
    rgpTurno: TmeIWRadioGroup;
    lblTurno: TmeIWLabel;
    chkTotali: TmeIWCheckBox;
    lblCauPresEscluse: TmeIWLabel;
    edtCauPresEscluse: TmeIWEdit;
    btnCauPresEscluse: TmeIWButton;
    btnAnomalie2: TmeIWButton;
    btnAnomalie3: TmeIWButton;
    procedure btnChiudiClick(Sender: TObject);
    procedure btnCauPresEscluseClick(Sender: TObject);
    procedure btnAnomalie2Click(Sender: TObject);
    procedure btnAnomalie3Click(Sender: TObject);
  private
    WC013: TWC013FCheckListFM;
    FTag: Integer;
    procedure CauPresEscluseResult(Sender: TObject; Result: Boolean);
    procedure Anom2Result(Sender: TObject; Result: Boolean);
    function getIdsAnomalieSelezionate: String;
    procedure Anom3Result(Sender: TObject; Result: Boolean);
  public
    ResultProprieta: TProc<Integer>;
    procedure Visualizza(CampoVisualizzato:String;Tag:Integer);
  end;

implementation

{$R *.dfm}

procedure TWA052FProprietaFM.Visualizza(CampoVisualizzato:String;Tag:Integer);
var
  titolo: String;
begin
  FTag:=Tag;
  with (WR302DM AS TWA052FParCarDM) do
  begin
    titolo:='Proprietà del dato ' + CampoVisualizzato;
    //componenti da db
    chkFestivo.checked:=selTabella.FieldByName('FESTIVO').AsString = 'S';
    chkNonLav.checked:=selTabella.FieldByName('NONLAV').AsString = 'S';
    chkGrassetto.checked:=selTabella.FieldByName('GRASSETTO').AsString = 'S';
    chkTimbratureManuali.Checked:=selTabella.FieldByName('TIMBRATURE_MANUALI').AsString = 'S';
    edtAnomOrologio.Text:=selTabella.FieldByName('ANOMALIA').AsString;

    //abilitazioni
    lblGiorniMese.Enabled:=A052FParCarMW.EnableGiorniMese(FTag);
    chkFestivo.Enabled:=A052FParCarMW.EnableGiorniMese(FTag);
    chkNonLav.Enabled:=A052FParCarMW.EnableGiorniMese(FTag);
    chkGrassetto.Enabled:=A052FParCarMW.EnableGiorniMese(FTag);

    rgpGiustificativi.Enabled:=A052FParCarMW.EnableGiustificativi(FTag);
    chkOrologio.Enabled:=A052FParCarMW.EnableTimbrature(FTag);
    lblAnomOrologio.Enabled:=A052FParCarMW.EnableTimbrature(FTag);
    edtAnomOrologio.Enabled:=A052FParCarMW.EnableTimbrature(FTag);
    lblCausale.Enabled:=A052FParCarMW.EnableTimbrature(FTag);
    rgpCausale.Enabled:=A052FParCarMW.EnableTimbrature(FTag);
    chkTimbratureManuali.Enabled:=A052FParCarMW.EnableTimbrature(FTag);
    lblTurno.Enabled:=A052FParCarMW.EnableTurno(FTag);
    rgpTurno.Enabled:=A052FParCarMW.EnableTurno(FTag);
    chkTotali.Enabled:=A052FParCarMW.EnableTotali(FTag);

    if A052FParCarMW.CausaliDaVisualizzare(FTag) then
    begin
      lblCauPresEscluse.Caption:='Causali di presenza da visualizzare';
      edtCauPresEscluse.Text:=selTabella.FieldByName('CAUPRES').AsString;
    end
    else
    begin
      lblCauPresEscluse.Caption:='Causali di presenza da non visualizzare';
      edtCauPresEscluse.Text:=selTabella.FieldByName('CAUPRES_ESCLUSE').AsString;
    end;

    //impostazioni
    if A052FParCarMW.EnableGiustificativi(FTag) then
      rgpGiustificativi.ItemIndex:=A052FParCarMW.GetItemIndexGiustificativi(FTag);

    if A052FParCarMW.EnableTimbrature(FTag) then
    begin
      chkOrologio.Checked:=A052FParCarMW.GetCheckedOrologio(FTag);
      rgpCausale.ItemIndex:=A052FParCarMW.GetItemIndexCausale(FTag);
    end;
    if A052FParCarMW.EnableTurno(FTag) then
      rgpTurno.ItemIndex:=A052FParCarMW.getItemIndexTurno(FTag);

    if A052FParCarMW.EnableTotali(FTag) then
      chkTotali.Checked:=A052FParCarMW.GetCheckedTotali(FTag);
  end;
  TWR100FBase(Self.Parent).VisualizzaJQMessaggio(jQuery,515,405,405, titolo,'#wa052proprieta_container',False,False);
end;

procedure TWA052FProprietaFM.btnAnomalie2Click(Sender: TObject);
var
  s: String;
  i: Integer;
begin
  inherited;
  WC013:=TWC013FCheckListFM.Create(Self.Parent);
  with WC013 do
  begin
    ckList.Items.BeginUpdate;
    ckList.Items.Clear;
    for i:=1 to High(tdescanom2) do
      WC013.ckList.Items.Add(tdescanom2[i].D);
    ckList.Items.EndUpdate;

    for s in WR302DM.selTabella.FieldByName('ANOMALIE2').AsString.Split([',']) do
      try
        WC013.ckList.IsChecked[s.ToInteger]:=True;
      except
      end;
    ResultEvent:=Anom2Result;
    WC013.Visualizza(0,0,'<WC013> Anomalie di 2° livello');
  end;
end;

procedure TWA052FProprietaFM.btnAnomalie3Click(Sender: TObject);
var
  s: String;
  i: Integer;
begin
  inherited;
  WC013:=TWC013FCheckListFM.Create(Self.Parent);
  with WC013 do
  begin
    ckList.Items.BeginUpdate;
    ckList.Items.Clear;
    for i:=1 to High(tdescanom3) do
      WC013.ckList.Items.Add(tdescanom3[i].D);
    ckList.Items.EndUpdate;

    for s in WR302DM.selTabella.FieldByName('ANOMALIE3').AsString.Split([',']) do
      try
        WC013.ckList.IsChecked[s.ToInteger]:=True;
      except
      end;
    ResultEvent:=Anom3Result;
    WC013.Visualizza(0,0,'<WC013> Anomalie di 3° livello');
  end;
end;

procedure TWA052FProprietaFM.btnCauPresEscluseClick(Sender: TObject);
var
  LstCodCausali,
  LstDescCausali,
  LstCausaliSelezionate: TStringList;
begin
  inherited;
  WC013:=TWC013FCheckListFM.Create(Self.Owner);
  try
    LstCodCausali:=TStringList.Create();
    LstDescCausali:=TStringList.Create();
    with (WR302DM as TWA052FParCarDM).A052FParCarMW do
    begin
      selT275.First;
      while not selT275.Eof do
      begin
        LstCodCausali.add(selT275.FieldByName('CODICE').AsString);
        LstDescCausali.add(Format('%-5s %-40s',[selT275.FieldByName('CODICE').AsString,selT275.FieldByName('DESCRIZIONE').AsString]));
        selT275.Next;
      end;
    end;

    WC013.CaricaLista(LstDescCausali, LstCodCausali);
    LstCausaliSelezionate:=TStringList.Create;
    LstCausaliSelezionate.CommaText:=edtCauPresEscluse.Text;
    WC013.ImpostaValoriSelezionati(LstCausaliSelezionate);
    WC013.ResultEvent:=CauPresEscluseResult;
  finally
    FreeAndNil(LstCausaliSelezionate);
    FreeAndNil(LstDescCausali);
    FreeAndNil(LstCodCausali);
  end;
  WC013.Visualizza(0,0,'<WC013> ' + lblCauPresEscluse.Caption);
end;

procedure TWA052FProprietaFM.CauPresEscluseResult(Sender: TObject; Result: Boolean);
var
  lstTmp: TStringList;
begin
  if Result then
  begin
    lstTmp:=WC013.LeggiValoriSelezionati;
    edtCauPresEscluse.Text:=lstTmp.CommaText;
    FreeAndNil(lstTmp);
  end;
end;

function TWA052FProprietaFM.getIdsAnomalieSelezionate: String;
var
  i: integer;
begin
  Result:='';
  for i:=0 to WC013.ckList.Items.Count - 1 do
  begin
    if WC013.ckList.isChecked[i] then
    begin
      if Result <> '' then
        Result:=Result + ',';
      Result:=Result + i.ToString;
    end;
  end;
end;

procedure TWA052FProprietaFM.Anom2Result(Sender: TObject; Result: Boolean);
begin
  if Result then
    WR302DM.selTabella.FieldByName('ANOMALIE2').AsString:=getIdsAnomalieSelezionate;
end;

procedure TWA052FProprietaFM.Anom3Result(Sender: TObject; Result: Boolean);
begin
  if Result then
    WR302DM.selTabella.FieldByName('ANOMALIE3').AsString:=getIdsAnomalieSelezionate;
end;

procedure TWA052FProprietaFM.btnChiudiClick(Sender: TObject);
var
  newTag: Integer;
begin
  inherited;
  if sender = btnConferma then
  begin
    with (WR302DM AS TWA052FParCarDM) do
    begin
      selTabella.FieldByName('FESTIVO').AsString:=IfThen(chkFestivo.checked,'S','N');
      selTabella.FieldByName('NONLAV').AsString:=IfThen(chkNonLav.checked,'S','N');
      selTabella.FieldByName('GRASSETTO').AsString:=IfThen(chkGrassetto.checked,'S','N');
      selTabella.FieldByName('TIMBRATURE_MANUALI').AsString:=IfThen(chkTimbratureManuali.checked,'S','N');
      selTabella.FieldByName('ANOMALIA').AsString:=edtAnomOrologio.Text;
      if A052FParCarMW.CausaliDaVisualizzare(FTag) then
        selTabella.FieldByName('CAUPRES').AsString:=edtCauPresEscluse.Text
      else
        selTabella.FieldByName('CAUPRES_ESCLUSE').AsString:=edtCauPresEscluse.Text;

      //Giustificativi
      if rgpGiustificativi.Enabled then
        newTag:=A052FParCarMW.GetTagGiustificativi(rgpGiustificativi.ItemIndex);
      //Timbrature
      if A052FParCarMW.EnableTimbrature(FTag) then
      begin
        newTag:=A052FParCarMW.GetTagCausale(rgpCausale.ItemIndex);
        newTag:=A052FParCarMW.getTagOrologio(chkOrologio.Checked, newTag);
      end;
      if A052FParCarMW.EnableTurno(FTag) then
        newTag:=A052FParCarMW.GetTagTurno(rgpTurno.ItemIndex);

      if A052FParCarMW.EnableTotali(FTag) then
        newTag:=A052FParCarMW.GetTagTotali(chkTotali.Checked,FTag);
    end;
    //reimposta tag su su cds
    if Assigned(ResultProprieta) then
      ResultProprieta(newTag);
  end;

  ReleaseOggetti;
  Free;
end;

end.

