unit P684UDettaglioDestin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin,
  StdCtrls, ExtCtrls, C600USelAnagrafe, DBCtrls, Buttons, Mask,
  A000UCostanti, A000USessione, A000UInterfaccia, A003UDataLavoroBis, C180FunzioniGenerali,
  Oracle, OracleData, C013UCheckList, System.Actions, System.ImageList, A000UMessaggi;

type
  TP684FDettaglioDestin = class(TR001FGestTab)
    Panel3: TPanel;
    lblAnno: TLabel;
    lblFondo: TLabel;
    lblCodTabella: TLabel;
    edtFondo: TEdit;
    edtDecorrenza: TEdit;
    Panel2: TPanel;
    lblCodVoceDett: TLabel;
    Label1: TLabel;
    dedtCodVoceGen: TDBEdit;
    dcmbCodVoceGen: TDBLookupComboBox;
    lblCodVoceGen: TLabel;
    dtxtCodVoceGen: TDBText;
    lblCodAccorpamento: TLabel;
    lblFiltroDipendenti: TLabel;
    dedtCodAccorpamento: TDBEdit;
    btnCodAccorpamento: TBitBtn;
    dmemFiltroDipendenti: TDBMemo;
    C600frmSelAnagrafe: TC600frmSelAnagrafe;
    Label2: TLabel;
    Label3: TLabel;
    dedtImportoSpeso: TDBEdit;
    dcmbArrotSpeso: TDBLookupComboBox;
    btnVisDettaglio: TBitBtn;
    dmemDescrizione: TDBMemo;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dcmbCodVoceGenKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dcmbCodVoceGenKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dcmbCodVoceGenCloseUp(Sender: TObject);
    procedure dcmbArrotSpesoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dcmbArrotSpesoCloseUp(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure btnCodAccorpamentoClick(Sender: TObject);
    procedure btnVisDettaglioClick(Sender: TObject);
    procedure C600frmSelAnagrafebtnSelezioneClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  P684FDettaglioDestin: TP684FDettaglioDestin;

  procedure OpenP684DettaglioDestin(Fondo:String;Dec:TDateTime);

implementation

uses P684UDefinizioneFondiDtM, P684UGrigliaDett;

{$R *.dfm}

procedure OpenP684DettaglioDestin(Fondo:String;Dec:TDateTime);
begin
  Application.CreateForm(TP684FDettaglioDestin,P684FDettaglioDestin);
  with P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW do
  try
    DataElabDettDes:=Dec;
    FondoElabDettDes:=Fondo;
    P684FDettaglioDestin.ShowModal;
  finally
    FreeAndNil(P684FDettaglioDestin);
  end;
end;

procedure TP684FDettaglioDestin.FormShow(Sender: TObject);
begin
  inherited;
  dcmbCodVoceGen.ListSource:=P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW.dsrP686D;
  dtxtCodVoceGen.DataSource:=P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW.dsrP686D;
  dcmbArrotSpeso.ListSource:=P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW.dsrP050;
  C600frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,nil,0,False);
  C600frmSelAnagrafe.C600FSelezioneAnagrafe.OpenC600SelAnagrafe:=False;
  with P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW do
  begin
    DButton.DataSet:=selP688D;
    edtDecorrenza.Text:=DateToStr(DataElabDettDes);
    edtFondo.Text:=FondoElabDettDes;
    lblFondo.Caption:=VarToStr(selP684.Lookup('DECORRENZA_DA;COD_FONDO',VarArrayOf([DataElabDettDes,FondoElabDettDes]),'DESCRIZIONE'));
  end;
  P684FDefinizioneFondiDtM.selP688DAfterScroll(nil);
end;

procedure TP684FDettaglioDestin.FormDestroy(Sender: TObject);
begin
  inherited;
  C600frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TP684FDettaglioDestin.dcmbCodVoceGenKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TP684FDettaglioDestin.dcmbCodVoceGenKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  dcmbCodVoceGenCloseUp(nil);
end;

procedure TP684FDettaglioDestin.dcmbCodVoceGenCloseUp(Sender: TObject);
begin
  inherited;
  dtxtCodVoceGen.Visible:=Trim(dcmbCodVoceGen.Text) <> '';
end;

procedure TP684FDettaglioDestin.dcmbArrotSpesoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  dcmbArrotSpesoCloseUp(nil);
end;

procedure TP684FDettaglioDestin.dcmbArrotSpesoCloseUp(Sender: TObject);
begin
  inherited;
  if (DButton.State <> dsEdit) and (DButton.State <> dsInsert) then
    exit;
  P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW.ArrotImporto('D');
end;

procedure TP684FDettaglioDestin.DButtonStateChange(Sender: TObject);
begin
  inherited;
  btnCodAccorpamento.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnVisDettaglio.Enabled:=DButton.State = dsBrowse;
  C600frmSelAnagrafe.btnSelezione.Enabled:=DButton.State in [dsEdit,dsInsert];
end;

procedure TP684FDettaglioDestin.btnCodAccorpamentoClick(Sender: TObject);
var S:String;
  ElencoAccorpamenti: TElencoValoriCheckList;
begin
  inherited;
  // richiamo C013 per esplodere lista
  C013FCheckList:=TC013FCheckList.Create(nil);
  C013FCheckList.Caption:='Elenco accorpamenti';
  with C013FCheckList do
    try
      ElencoAccorpamenti:=P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW.ElencoAccorpamenti;
      clbListaDati.Items.Assign(ElencoAccorpamenti.lstDescrizione);
      FreeAndNil(ElencoAccorpamenti);
      S:=Trim(dButton.Dataset.FieldByName('CODICI_ACCORPAMENTOVOCI').AsString);
      S:=StringReplace(Copy(S,5,Length(S)-6),''',''',',',[rfReplaceAll]);
      R180PutCheckList(S,21,clbListaDati);
      if ShowModal = mrOK then
      begin
        S:=R180GetCheckList(21,clbListaDati);
        if Trim(S) <> '' then
          S:='IN(''' + StringReplace(S,',',''',''',[rfReplaceAll]) + ''')';
        if Length(S) > 500 then  //Attenzione: la stringa degli accorpamenti supera la massima lunghezza consentita (500 caratteri). Il dato viene comunque salvato.
          R180MessageBox(A000MSG_P684_MSG_ACCORPAMENTI + ' ' + A000MSG_P000_MSG_DATO_SALVATO,'INFORMA');
        dButton.Dataset.FieldByName('CODICI_ACCORPAMENTOVOCI').AsString:=S;
      end;
    finally
      Free;
    end;
end;

procedure TP684FDettaglioDestin.btnVisDettaglioClick(Sender: TObject);
var Imp:Real;
begin
  inherited;
  with P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW do
  begin
    if LetturaDettaglioImportoSpeso(selP688D.FieldByName('COD_FONDO').AsString,selP688D.FieldByName('DECORRENZA_DA').AsDateTime,Imp) then
      R180MessageBox(A000MSG_P684_MSG_IMPORTO_SPESO,'INFORMA');
    OpenP684GrigliaDett(selP688D.FieldByName('COD_FONDO').AsString,selP688D.FieldByName('COD_VOCE_GEN').AsString,
      selP688D.FieldByName('COD_VOCE_DET').AsString,selP688D.FieldByName('DECORRENZA_DA').AsDateTime);
  end;
end;

procedure TP684FDettaglioDestin.C600frmSelAnagrafebtnSelezioneClick(Sender: TObject);
var S:String;
begin
  inherited;
  with P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW do
  begin
    if selP688D.FieldByName('DECORRENZA_DA').IsNull then
      C600frmSelAnagrafe.C600DataLavoro:=Date
    else
      C600frmSelAnagrafe.C600DataLavoro:=selP688D.FieldByName('DECORRENZA_DA').AsDateTime;
    C600frmSelAnagrafe.btnSelezioneClick(Sender);
    if C600frmSelAnagrafe.C600ModalResult = mrOK then
    begin
      S:=Trim(C600frmSelAnagrafe.C600FSelezioneAnagrafe.SQLCreato.Text);
      if Pos('ORDER BY',UpperCase(S)) > 0 then
        S:=Copy(S,1,Pos('ORDER BY',UpperCase(S)) - 1);
      selP688D.FieldByName('FILTRO_DIPENDENTI').AsString:=TrasformaV430(S);
    end;
  end;
end;

end.
