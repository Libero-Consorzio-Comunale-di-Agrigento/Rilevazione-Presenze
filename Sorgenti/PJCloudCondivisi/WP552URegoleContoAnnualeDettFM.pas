unit WP552URegoleContoAnnualeDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompEdit, IWDBStdCtrls,
  meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompLabel, meIWLabel, IWCompMemo, meIWDBMemo, IWCompExtCtrls, IWDBExtCtrls,
  meIWDBRadioGroup, IWCompListbox, meIWDBLookupComboBox, meIWComboBox, meIWMemo,
  meIWImageFile, Data.DB, A000UInterfaccia, medpIWImageButton, IWCompCheckbox,
  meIWDBCheckBox, A000UMessaggi, medpIWMessageDlg;

type
  TWP552FRegoleContoAnnualeDettFM = class(TWR205FDettTabellaFM)
    lblAnno: TmeIWLabel;
    dedtAnno: TmeIWDBEdit;
    lblCodTabella: TmeIWLabel;
    dedtCodTabella: TmeIWDBEdit;
    Descrizione: TmeIWLabel;
    dmemDescrizione: TmeIWDBMemo;
    drgpTipologia: TmeIWDBRadioGroup;
    lblTipologia: TmeIWLabel;
    lblDatoLibero: TmeIWLabel;
    lblFunzioneOracle: TmeIWLabel;
    cmbDatoLibero: TmeIWComboBox;
    memFunzioneOracle: TmeIWMemo;
    lblFiltroDipendenti: TmeIWLabel;
    imgC700SelezioneAnagrafe: TmeIWImageFile;
    dmemFiltroDipendenti: TmeIWDBMemo;
    btnRipristina: TmedpIWImageButton;
    lblRegolaManuale: TmeIWLabel;
    dchkRegolaModif: TmeIWDBCheckBox;
    dmemRegolaManuale: TmeIWDBMemo;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure drgpTipologiaClick(Sender: TObject);
    procedure imgC700SelezioneAnagrafeClick(Sender: TObject);
    procedure dchkRegolaModifAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure btnRipristinaClick(Sender: TObject);
  private
    procedure ImpostaComponentiVisible;
    procedure ResultSelAnagrafe(Sender: TObject; Result: Boolean);
    procedure AbilitaRegolaRipristina;
    procedure ResultRipristino(Sender: TObject; R: TmeIWModalResult; KI: String);
  public
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
    procedure AbilitaComponenti; override;
  end;

implementation

uses
  WP552uRegoleContoAnnualeDM, WP552URegoleContoAnnuale;

{$R *.dfm}

procedure TWP552FRegoleContoAnnualeDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  with (WR302DM AS TWP552FRegoleContoAnnualeDM).P552FRegoleContoAnnualeMW do
  begin
    cmbDatoLibero.Items.Clear;
    selI010.First;
    while not selI010.eof do
    begin
      cmbDatoLibero.Items.Add(Format('%s=%s',[seli010.FieldByName('NOME_LOGICO').AsString,seli010.FieldByName('NOME_CAMPO').AsString]));
      selI010.Next;
    end;
  end;
end;

procedure TWP552FRegoleContoAnnualeDettFM.DataSet2Componenti;
var
  i: Integer;
begin
  inherited;
  with WR302DM do
  begin
    if selTabella.FieldByName('TIPO_TABELLA_RIGHE').AsString = '1' then
    begin
      for i:=0 to cmbDatoLibero.Items.Count - 1 do
      begin
        if cmbDatoLibero.Items.ValueFromIndex[i] = selTabella.FieldByName('VALORE_COSTANTE').AsString then
        begin
          cmbDatoLibero.ItemIndex:=i;
          Break;
        end;
      end;
    end
    else
    begin
      cmbDatoLibero.ItemIndex:=-1;
    end;
    if selTabella.FieldByName('TIPO_TABELLA_RIGHE').AsString = '3' then
    begin
      memFunzioneOracle.Text:=selTabella.FieldByName('VALORE_COSTANTE').AsString;
    end
    else
    begin
      memFunzioneOracle.Text:='';
    end;
  end;
  ImpostaComponentiVisible;
end;

procedure TWP552FRegoleContoAnnualeDettFM.dchkRegolaModifAsyncClick(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  AbilitaRegolaRipristina;
end;

procedure TWP552FRegoleContoAnnualeDettFM.AbilitaComponenti;
var
  bEdit: Boolean;
begin
  bEdit:=WR302DM.selTabella.State in [dsEdit, dsInsert];
  if bEdit then
  begin
    AbilitaRegolaRipristina;
  end;
end;

procedure TWP552FRegoleContoAnnualeDettFM.AbilitaRegolaRipristina;
begin
  dMemRegolaManuale.Enabled:=(WR302DM.selTabella.FieldByName('REGOLA_MODIFICABILE').AsString = 'S');
  btnRipristina.Enabled:=dMemRegolaManuale.Enabled;
end;

procedure TWP552FRegoleContoAnnualeDettFM.btnRipristinaClick(Sender: TObject);
begin
  MsgBox.WebMessageDlg(A000MSG_P552_DLG_RIPRISTINO_REGOLA,mtConfirmation,[mbYes,mbNo],ResultRipristino,'');
end;

procedure TWP552FRegoleContoAnnualeDettFM.ResultRipristino(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
  begin
    WR302DM.selTabella.FieldByName('REGOLA_CALCOLO_MANUALE').AsString:=WR302DM.selTabella.FieldByName('REGOLA_CALCOLO_AUTOMATICA').AsString;
  end;
end;

procedure TWP552FRegoleContoAnnualeDettFM.drgpTipologiaClick(Sender: TObject);
begin
  ImpostaComponentiVisible;
end;

procedure TWP552FRegoleContoAnnualeDettFM.imgC700SelezioneAnagrafeClick(
  Sender: TObject);
var
  dDataSelAnagrafe: TDateTime;
begin
  if WR302DM.selTabella.State in [dsEdit,dsInsert] then
  begin
    with (Self.Owner as TWP552FRegoleContoAnnuale).grdC700 do
    begin
      dDataSelAnagrafe:=Parametri.DataLavoro;
      if not WR302DM.selTabella.FieldByName('ANNO').IsNull then
        dDataSelAnagrafe:=EncodeDate(WR302DM.selTabella.FieldByName('ANNO').AsInteger,12,31);
      WC700FM.C700DataLavoro:=dDataSelAnagrafe;
      WC700FM.C700DataDal:=dDataSelAnagrafe;
      if WC700FM.C700SettaPeriodoSelAnagrafe(dDataSelAnagrafe,dDataSelAnagrafe) then
        SelAnagrafe.CloseAll;
      SelAnagrafe.Open;
      WC700FM.ResultEvent:=ResultSelAnagrafe;
      actSelezioneAnagraficheExecute(nil);
    end;
  end;
end;

procedure TWP552FRegoleContoAnnualeDettFM.ResultSelAnagrafe(Sender: TObject; Result: Boolean);
var S:string;
begin
  if Result then
  begin
    S:=Trim((Self.Owner as TWP552FRegoleContoAnnuale).grdC700.WC700FM.SQLCreato.Text);
    if Pos('ORDER BY',UpperCase(S)) > 0 then
      S:=Copy(S,1,Pos('ORDER BY',UpperCase(S)) - 1);
    WR302DM.selTabella.FieldByName('FILTRO_DIPENDENTI').AsString:=(WR302DM AS TWP552FRegoleContoAnnualeDM).P552FRegoleContoAnnualeMW.TrasformaV430(S);
  end;
end;

procedure TWP552FRegoleContoAnnualeDettFM.ImpostaComponentiVisible;
begin
  lblDatoLibero.Visible:=WR302DM.selTabella.FieldByName('TIPO_TABELLA_RIGHE').AsString = '1';
  CmbDatoLibero.Visible:=lblDatoLibero.Visible;
  lblFunzioneOracle.Visible:=WR302DM.selTabella.FieldByName('TIPO_TABELLA_RIGHE').AsString = '3';
  memFunzioneOracle.Visible:=lblFunzioneOracle.Visible;
end;

procedure TWP552FRegoleContoAnnualeDettFM.Componenti2DataSet;
begin
  with WR302DM do
  begin
    if selTabella.FieldByName('TIPO_TABELLA_RIGHE').AsString = '1' then
    begin
      if cmbDatoLibero.ItemIndex > -1 then
        selTabella.FieldByName('VALORE_COSTANTE').AsString:=cmbDatoLibero.Items.ValueFromIndex[cmbDatoLibero.ItemIndex]
      else
        selTabella.FieldByName('VALORE_COSTANTE').AsString:='';
    end;
    if selTabella.FieldByName('TIPO_TABELLA_RIGHE').AsString = '3' then
    begin
      selTabella.FieldByName('VALORE_COSTANTE').AsString:=memFunzioneOracle.Text;
    end;
  end;
end;
end.
