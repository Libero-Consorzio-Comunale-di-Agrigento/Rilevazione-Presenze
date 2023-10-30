unit A016UCausAssenzeStorico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R004UGestStorico, System.Actions,
  Vcl.ActnList, Vcl.ImgList, Data.DB, Vcl.Menus, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.Mask, Vcl.DBCtrls, Vcl.Buttons,
  A000USessione, Vcl.ExtCtrls, C012UVisualizzaTesto, C013UCheckList, OracleData, System.ImageList;

type
  TA016FCausAssenzeStorico = class(TR004FGestStorico)
    PageControl1: TPageControl;
    Panel1: TPanel;
    lblDescrizione: TLabel;
    lblCodice: TLabel;
    lblDescCausale: TLabel;
    dedtCodice: TDBEdit;
    dedtDescrizione: TDBEdit;
    dedtDescCausale: TDBEdit;
    tabCartellino: TTabSheet;
    lblValorGiorOre: TLabel;
    lblValorGiorOreComp: TLabel;
    lblHMAssenza: TLabel;
    drgpValorGior: TDBRadioGroup;
    dedtValorGiorOre: TDBEdit;
    drgpValorGiorComp: TDBRadioGroup;
    dedtValorGiorOreComp: TDBEdit;
    dchkValorGiorOrePropPT: TDBCheckBox;
    dedtHMAssenza: TDBEdit;
    dchkHMAssenzaPropPT: TDBCheckBox;
    grpFruizAbilSP: TGroupBox;
    dchkFruizAbilSPGiorni: TDBCheckBox;
    dchkFruizAbilSPOre: TDBCheckBox;
    grpPausaMensa: TGroupBox;
    dchkTimbPM: TDBCheckBox;
    dchkTimbPMDetraz: TDBCheckBox;
    dchkTimbPMH: TDBCheckBox;
    dchkPesoGiorDaOrario: TDBCheckBox;
    tabRegoleInserimento: TTabSheet;
    lblCausaliCompatibili: TLabel;
    lblCausaliCheckComp: TLabel;
    lblVisualComp: TLabel;
    lblCausaleFruizOre: TLabel;
    lblCausaleHMAssenza: TLabel;
    dedtCausaliCompatibili: TDBEdit;
    btnCausaliCompatibili: TButton;
    drgpStatoCompatibilta: TDBRadioGroup;
    dedtCausaliCheckComp: TDBEdit;
    btnCausaliCheckComp: TButton;
    dcmbVisualCompetenze: TDBComboBox;
    dcmbCausaleFruizOre: TDBLookupComboBox;
    dcmbCausaleHMAssenza: TDBLookupComboBox;
    dchkCheckSoloCompetenze: TDBCheckBox;
    GroupBox1: TGroupBox;
    lblCausCheckNoCompI: TLabel;
    dedtCausCheckNoCompI: TDBEdit;
    btnCausCheckNoCompI: TButton;
    lblCausCheckNoCompM: TLabel;
    dedtCausCheckNoCompM: TDBEdit;
    btnCausCheckNoCompM: TButton;
    lblCausCheckNoCompN: TLabel;
    dedtCausCheckNoCompN: TDBEdit;
    btnCausCheckNoCompN: TButton;
    lblCausCheckNoCompD: TLabel;
    dedtCausCheckNoCompD: TDBEdit;
    btnCausCheckNoCompD: TButton;
    dchkGiustDaARecupFlex: TDBCheckBox;
    dchkAbbatteStrInd: TDBCheckBox;
    drgpConteggioTimbInterna: TDBRadioGroup;
    drgpIntersezioneTimbrature: TDBRadioGroup;
    dchkSceltaOrario: TDBCheckBox;
    dchkIndPresenza: TDBCheckBox;
    dchkIndTurno: TDBCheckBox;
    dchkFruizInternaPN: TDBCheckBox;
    tabRegoleCumuloFruizione: TTabSheet;
    lblCMCausPresIncluse: TLabel;
    dedtCMCausPresIncluse: TDBEdit;
    btnCMCausPresIncluse: TButton;
    dchkCompetenzePersonalizzate: TDBCheckBox;
    dchkArrotCompetenze: TDBCheckBox;
    dchkArrotResidui: TDBCheckBox;
    ppmnuProcPers: TPopupMenu;
    Accedi1: TMenuItem;
    drgpCondizioneAllegati: TDBRadioGroup;
    grpGEDAP: TGroupBox;
    dCmbCausaleGEDAP: TDBComboBox;
    dGrpTipoGEDAP: TDBRadioGroup;
    lblCausale: TLabel;
    dchkIndPresenzaSuFestivo: TDBCheckBox;
    procedure TCancClick(Sender: TObject);
    procedure SelezioneCausali(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure drgpValorGiorChange(Sender: TObject);
    procedure drgpValorGiorCompChange(Sender: TObject);
    procedure OnDBEditOraChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DButtonStateChange(Sender: TObject);
    procedure TAnnullaClick(Sender: TObject);
    procedure dchkTimbPMClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure drgpIntersezioneTimbratureChange(Sender: TObject);
    procedure btnCMCausPresIncluseClick(Sender: TObject);
    procedure ppmnuProcPersPopup(Sender: TObject);
    procedure Accedi1Click(Sender: TObject);
    procedure dCmbCausaleGEDAPDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure dchkIndPresenzaClick(Sender: TObject);
  private
    procedure ImpostaEnabledCampi;
  public
    // Periodo attuale, viene prevalorizzato prima dello show
    // e utilizzato prima del destroy per sincronizzare con il form chiamante
    A016StoricoDataLavoro:TDateTime;
    procedure PopolaComboVisualCompetenze;
  end;

var
  A016FCausAssenzeStorico: TA016FCausAssenzeStorico;

implementation

uses A000UMessaggi ,A016UCausAssenzeStoricoDM, C180FunzioniGenerali;

{$R *.dfm}

procedure TA016FCausAssenzeStorico.Accedi1Click(Sender: TObject);
begin
  inherited;
  {selVSource viene aperto e letto sull'evento onPopUp del popupmenù}
  with A016FCausAssenzeStoricoDM.A016FCausAssenzeStoricoMW do
    OpenC012VisualizzaTesto(selVSource.GetVariable('SNAME'),'',lstSourceSQL);
end;

procedure TA016FCausAssenzeStorico.btnCMCausPresIncluseClick(Sender: TObject);
var S:String;
  procedure CaricaLista;
  begin
    with A016FCausAssenzeStoricoDM.A016FCausAssenzeStoricoMW.selT275 do
    begin
      Filtered:=False;
      Open;
      First;
      C013FCheckList.clbListaDati.Items.Clear;
      C013FCheckList.clbListaDati.Items.Add((Format('%-5s %s',['<*>','Causali standard'])));
      while not Eof do
      begin
        C013FCheckList.clbListaDati.Items.Add(Format('%-5s %s',[FieldByName('Codice').AsString,FieldByName('Descrizione').AsString]));
        Next;
      end;
    end;
  end;
begin
  if not(DButton.State in [dsEdit,dsInsert]) then exit;

  C013FCheckList:=TC013FCheckList.Create(nil);
  with C013FCheckList do
  try
    Caption:='<C013> Causali di presenza da conteggiare';
    S:=dedtCMCausPresIncluse.Field.AsString;
    CaricaLista;
    R180PutCheckList(S,5,C013FCheckList.clbListaDati);
    if ShowModal = mrOK then
      dedtCMCausPresIncluse.Field.AsString:=R180GetCheckList(5,C013FCheckList.clbListaDati);
  finally
    Release;
  end;
end;

procedure TA016FCausAssenzeStorico.DButtonDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  ImpostaEnabledCampi;
  if (Field <> nil) and ((Field.FieldName = 'CAUSALI_CHECKCOMPETENZE') or (Field.FieldName = 'CAUSALI_VISUALCOMPETENZE')) then
    PopolaComboVisualCompetenze;
end;

procedure TA016FCausAssenzeStorico.OnDBEditOraChange(Sender: TObject);
var
  DBEditSender:TDBEdit;
begin
  if DButton.State in [dsInsert,dsEdit] then
  begin
    DBEditSender:=(Sender as TDBEdit);
    if (Trim(DBEditSender.Text) = '.') then
      DBEditSender.Field.Clear;
  end;
end;

procedure TA016FCausAssenzeStorico.DButtonStateChange(Sender: TObject);
begin
  inherited;
  dcmbVisualCompetenze.Enabled:=DButton.DataSet.State in [dsEdit, dsInsert];
  PopolaComboVisualCompetenze;
end;

procedure TA016FCausAssenzeStorico.dchkIndPresenzaClick(Sender: TObject);
begin
  inherited;
  dchkIndPresenzaSuFestivo.Enabled:=dchkIndPresenza.Checked;
end;

procedure TA016FCausAssenzeStorico.dchkTimbPMClick(Sender: TObject);
begin
  inherited;
  dchkTimbPMDetraz.Enabled:=dchkTimbPM.Checked;
end;

procedure TA016FCausAssenzeStorico.dCmbCausaleGEDAPDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  inherited;
  (Control as TDBComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,A016FCausAssenzeStoricoDM.A016FCausAssenzeStoricoMW.D_CausaleGEDAP[Index].Item);
end;

procedure TA016FCausAssenzeStorico.drgpIntersezioneTimbratureChange(Sender: TObject);
begin
  inherited;
  ImpostaEnabledCampi;
end;

procedure TA016FCausAssenzeStorico.drgpValorGiorChange(Sender: TObject);
begin
  ImpostaEnabledCampi;
end;

procedure TA016FCausAssenzeStorico.drgpValorGiorCompChange(Sender: TObject);
begin
  ImpostaEnabledCampi;
end;

procedure TA016FCausAssenzeStorico.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  A016StoricoDataLavoro:=StrToDate(cmbDateDecorrenza.Text);
  inherited;
end;

procedure TA016FCausAssenzeStorico.FormCreate(Sender: TObject);
begin
  inherited;
  PageControl1.ActivePage:=tabCartellino;
  R180SetComboItemsValues(dCmbCausaleGEDAP.Items,A016FCausAssenzeStoricoDM.A016FCausAssenzeStoricoMW.D_CausaleGEDAP,'V');
end;

procedure TA016FCausAssenzeStorico.FormShow(Sender: TObject);
var
  DataLavoroInizialeStr:String;
begin
  inherited;
  btnCMCausPresIncluse.Enabled:=VarToStr(A016FCausAssenzeStoricoDM.A016FCausAssenzeStoricoMW.selT265.Lookup('ID',A016FCausAssenzeStoricoDM.A016FCausAssenzeStoricoMW.selT230.FieldByName('ID').AsInteger,'TIPOCUMULO')) = 'M';

  dcmbCausaleFruizOre.ListSource:=A016FCausAssenzeStoricoDM.A016FCausAssenzeStoricoMW.dsrT265;
  dcmbCausaleFruizOre.KeyField:='CODICE';
  dcmbCausaleFruizOre.ListField:='CODICE;DESCRIZIONE';
  dcmbCausaleFruizOre.DropDownWidth:=300;
  dcmbCausaleHMAssenza.ListSource:=A016FCausAssenzeStoricoDM.A016FCausAssenzeStoricoMW.dsrT265;
  dcmbCausaleHMAssenza.KeyField:='CODICE';
  dcmbCausaleHMAssenza.ListField:='CODICE;DESCRIZIONE';
  dcmbCausaleHMAssenza.DropDownWidth:=300;

  DataLavoroInizialeStr:=DateToStr(A016StoricoDataLavoro);
  cmbDateDecorrenza.ItemIndex:=cmbDateDecorrenza.Items.IndexOf(DataLavoroInizialeStr);
  cmbDateDecorrenzaChange(nil);
end;

procedure TA016FCausAssenzeStorico.ImpostaEnabledCampi;
begin
  dedtValorGiorOre.Enabled:=(drgpValorGior.ItemIndex = 5);
  lblValorGiorOre.Enabled:=(drgpValorGior.ItemIndex = 5);
  {if not dedtValorGiorOre.Enabled then
    dedtValorGiorOre.Text:='00.00';}
  dedtValorGiorOreComp.Enabled:=(drgpValorGiorComp.ItemIndex = 6);
  lblValorGiorOreComp.Enabled:=(drgpValorGiorComp.ItemIndex = 6);
  {if not dedtValorGiorOreComp.Enabled then
    dedtValorGiorOreComp.Text:='00.00';}
  dchkValorGiorOrePropPT.Enabled:=(drgpValorGior.ItemIndex = 5) or (drgpValorGiorComp.ItemIndex = 6);
  dchkTimbPMDetraz.Enabled:=dchkTimbPM.Checked;
  drgpConteggioTimbInterna.Enabled:=drgpIntersezioneTimbrature.ItemIndex = 1;
  dchkIndPresenzaSuFestivo.Enabled:=dchkIndPresenza.Checked;
end;

procedure TA016FCausAssenzeStorico.SelezioneCausali(Sender: TObject);
var
  IdCausaleCorrente:Integer;
  TestoCausale,VecchioValore,NuovoValore:String;
  selT230,selT265:TOracleDataSet;
begin
  if not(DButton.State in [dsEdit,dsInsert]) then
    Exit;
  if (Sender <> btnCausaliCompatibili) and
     (Sender <> btnCausaliCheckComp) and
     (Sender <> btnCausCheckNoCompI) and
     (Sender <> btnCausCheckNoCompM) and
     (Sender <> btnCausCheckNoCompN) and
     (Sender <> btnCausCheckNoCompD)
  then
    Exit;
  selT265:=A016FCausAssenzeStoricoDM.A016FCausAssenzeStoricoMW.selT265;
  selT230:=A016FCausAssenzeStoricoDM.A016FCausAssenzeStoricoMW.selT230;
  C013FCheckList:=TC013FCheckList.Create(nil);
  try
    IdCausaleCorrente:=selT230.FieldByName('ID').AsInteger;
    selT265.Filtered:=False;
    selT265.Filter:='(ID <> ' + IntToStr(IdCausaleCorrente) + ')';
    if Sender <> btnCausaliCompatibili then
      selT265.Filter:=selT265.Filter + ' and (TIPOCUMULO <> ''H'')';
    selT265.Filtered:=True;
    selT265.First;
    while not selT265.Eof do
    begin
      TestoCausale:=Format('%-5s - %s',[
                                      A016FCausAssenzeStoricoDM.A016FCausAssenzeStoricoMW.selT265.FieldByName('CODICE').AsString,
                                      A016FCausAssenzeStoricoDM.A016FCausAssenzeStoricoMW.selT265.FieldByName('DESCRIZIONE').AsString
                                     ]);
      C013FCheckList.clbListaDati.Items.Add(TestoCausale);
      selT265.Next;
    end;

    if Sender = btnCausaliCompatibili then
      VecchioValore:=selT230.FieldByName('CAUSALI_COMPATIBILI').AsString
    else if Sender = btnCausaliCheckComp then
      VecchioValore:=selT230.FieldByName('CAUSALI_CHECKCOMPETENZE').AsString
    else if Sender = btnCausCheckNoCompI then
      VecchioValore:=selT230.FieldByName('CAUS_CHECKNOCOMP_I').AsString
    else if Sender = btnCausCheckNoCompM then
      VecchioValore:=selT230.FieldByName('CAUS_CHECKNOCOMP_M').AsString
    else if Sender = btnCausCheckNoCompN then
      VecchioValore:=selT230.FieldByName('CAUS_CHECKNOCOMP_N').AsString
    else if Sender = btnCausCheckNoCompD then
      VecchioValore:=selT230.FieldByName('CAUS_CHECKNOCOMP_D').AsString;

    R180PutCheckList(VecchioValore,5,C013FCheckList.clbListaDati);

    if C013FCheckList.ShowModal = mrOK then
    begin
      NuovoValore:=R180GetCheckList(5,C013FCheckList.clbListaDati);
      if Sender = btnCausaliCompatibili then
        selT230.FieldByName('CAUSALI_COMPATIBILI').AsString:=NuovoValore
      else if Sender = btnCausaliCheckComp then
      begin
        selT230.FieldByName('CAUSALI_CHECKCOMPETENZE').AsString:=NuovoValore;
        PopolaComboVisualCompetenze;
        if dcmbVisualCompetenze.ItemIndex = -1 then
          DButton.DataSet.FieldByName('CAUSALE_VISUALCOMPETENZE').AsString:='';
      end
      else if Sender = btnCausCheckNoCompI then
        selT230.FieldByName('CAUS_CHECKNOCOMP_I').AsString:=NuovoValore
      else if Sender = btnCausCheckNoCompM then
        selT230.FieldByName('CAUS_CHECKNOCOMP_M').AsString:=NuovoValore
      else if Sender = btnCausCheckNoCompN then
        selT230.FieldByName('CAUS_CHECKNOCOMP_N').AsString:=NuovoValore
      else if Sender = btnCausCheckNoCompD then
        selT230.FieldByName('CAUS_CHECKNOCOMP_D').AsString:=NuovoValore;
    end;
  finally
    selT265.Filter:='';
    selT265.Filtered:=False;
    FreeAndNil(C013FCheckList);
  end;
end;

procedure TA016FCausAssenzeStorico.TAnnullaClick(Sender: TObject);
begin
  inherited;
  PopolaComboVisualCompetenze;
end;

procedure TA016FCausAssenzeStorico.TCancClick(Sender: TObject);
begin
  if DButton.DataSet.RecordCount < 2 then
  begin
    R180MessageBox(A000MSG_A016_MSG_NO_ELIMINA_STOR,ESCLAMA,Self.Caption);
    Exit;
  end;
  inherited;
end;

procedure TA016FCausAssenzeStorico.PopolaComboVisualCompetenze;
var
  CausaliCheckComp:String;
  CausaliCheckCompSplit:TArray<String>;
  CausaleCorr:String;
begin
  dcmbVisualCompetenze.Items.Clear;
  dcmbVisualCompetenze.Items.Add('');
  CausaliCheckComp:=DButton.DataSet.FieldByName('CAUSALI_CHECKCOMPETENZE').AsString;
  if (Trim(CausaliCheckComp) <> '') then
  begin
    CausaliCheckCompSplit:=CausaliCheckComp.Split([',']);
    for CausaleCorr in CausaliCheckCompSplit do
    begin
      dcmbVisualCompetenze.Items.Add(CausaleCorr);
    end;
    CausaleCorr:=DButton.DataSet.FieldByName('CAUSALE_VISUALCOMPETENZE').AsString;
    dcmbVisualCompetenze.ItemIndex:=dcmbVisualCompetenze.Items.IndexOf(CausaleCorr);
  end;
end;

procedure TA016FCausAssenzeStorico.ppmnuProcPersPopup(Sender: TObject);
begin
  inherited;
  with A016FCausAssenzeStoricoDM.A016FCausAssenzeStoricoMW do
  begin
    if ppmnuProcPers.PopupComponent = dchkCompetenzePersonalizzate then
      GetSourceSQL('T265P_GETCOMPETENZE')
    else if ppmnuProcPers.PopupComponent = dchkArrotCompetenze then
      GetSourceSQL('T265P_ARROTCOMPETENZE')
    else if ppmnuProcPers.PopupComponent = dchkArrotResidui then
      GetSourceSQL('T265P_ARROTRESIDUI');
  end;
end;

end.
