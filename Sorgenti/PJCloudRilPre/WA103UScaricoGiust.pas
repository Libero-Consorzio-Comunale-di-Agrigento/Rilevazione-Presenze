unit WA103UScaricoGiust;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR100UBase, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, OracleData,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, meIWImageFile, medpIWImageButton,
  IWCompCheckbox, meIWCheckBox, IWCompLabel, meIWLabel, IWCompListbox, meIWComboBox, A000UInterfaccia,
  R250UScaricoGiustificativiDtM, IWDBStdCtrls, meIWDBLabel, meIWDBCheckBox, IWCompEdit,
  medpIWMultiColumnComboBox, medpIWMessageDlg, A000UCostanti ;

type
  TWA103FScaricoGiust = class(TWR100FBase)
    cmbScarico: TmeIWComboBox;
    chkScarichiAuto: TmeIWCheckBox;
    btnScarico: TmedpIWImageButton;
    btnLogAcquisizione: TmedpIWImageButton;
    lnkScarico: TmeIWLink;
    procedure IWAppFormCreate(Sender: TObject);
    procedure lnkScaricoClick(Sender: TObject);
    procedure btnScaricoClick(Sender: TObject);
    procedure btnLogAcquisizioneClick(Sender: TObject);
  private
    R250DM:TR250FScaricoGiustificativiDtM;
    procedure CaricaComboBox;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TWA103FScaricoGiust.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  R250DM:=TR250FScaricoGiustificativiDtM.Create(Self);
  R250DM.SessioneOracleB015:=SessioneOracle;
  R250DM.ConnettiDataBase(SessioneOracle.LogonDatabase);
  with R250DM do
  begin
    if Parametri.Azienda <> 'AZIN' then
    begin
      selI150.Filter:='AZIENDA = ''' + Parametri.Azienda + '''';
      selI150.Filtered:=True;
    end;
    cmbScarico.Text:=selI150.FieldByName('CODICE').AsString;
    selI150.Filtered:=False;
  end;
  cmbScarico.Text:=C004DM.GetParametro('NOME_SCARICO',cmbScarico.Text);
  chkScarichiAuto.Checked:=C004DM.GetParametro('SCARICHI_AUTO','N') = 'S';
  cmbScarico.Enabled:=not chkScarichiAuto.Checked;
  btnLogAcquisizione.Enabled:=False;
  CaricaComboBox;
end;

procedure TWA103FScaricoGiust.lnkScaricoClick(Sender: TObject);
begin
  inherited;
  AccediForm(159,'CODICE='+cmbScarico.Text); //A102ParScaricoGiust
  with R250DM.SelI150 do
  begin
    DisableControls;
    Refresh;
    EnableControls;
  end;
end;

procedure TWA103FScaricoGiust.btnLogAcquisizioneClick(Sender: TObject);
var
  Params: String;
begin
  Params:='AZIENDA=' + Parametri.Azienda + ParamDelimiter +
          'OPERATORE=' + Parametri.Operatore + ParamDelimiter +
          'MASCHERA='+ medpCodiceForm + ParamDelimiter +
          'ID=' + IntToStr(RegistraMsg.ID);
  accediForm(201,Params,False);
end;

procedure TWA103FScaricoGiust.btnScaricoClick(Sender: TObject);
begin
  if not chkScarichiAuto.Checked then
    R250DM.selI150.SearchRecord('CODICE',cmbScarico.Text,[srFromBeginning]);
  RegistraMsg.IniziaMessaggio(medpCodiceForm);
  R250DM.Scarico(not chkScarichiAuto.Checked,False);
  MsgBox.WebMessageDlg('Scarico terminato',mtInformation,[mbOk],nil,'');
  //if (RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB) then
  btnLogAcquisizione.Enabled:=True;
end;

procedure TWA103FScaricoGiust.CaricaComboBox;
begin
  with R250DM.selI150 do
  begin
    Open;
    First;
    while not Eof do
    begin
      cmbScarico.Items.Add(FieldByName('CODICE').AsString);
      Next;
    end;
  end;
end;

end.
