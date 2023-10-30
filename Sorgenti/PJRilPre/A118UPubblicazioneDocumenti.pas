unit A118UPubblicazioneDocumenti;

interface

uses
  A118UPubblicazioneDocumentiMW, A000UCostanti, A000USessione, A000UInterfaccia,
  C180FunzioniGenerali, Oracle,
  StrUtils, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin,
  ExtCtrls, StdCtrls, Buttons, Mask, DBCtrls, Grids, DBGrids,
  FileCtrl, System.Actions, System.IOUtils, System.Math;

type
  TA118FPubblicazioneDocumenti = class(TR001FGestTab)
    pnlI200: TPanel;
    pnlInfoComuni: TPanel;
    lblCodice: TLabel;
    dedtCodice: TDBEdit;
    lblDescrizione: TLabel;
    dedtDescrizione: TDBEdit;
    lblFiltro: TLabel;
    dedtFiltro: TDBEdit;
    btnCheckFiltro: TSpeedButton;
    pnlInfoSorgente: TPanel;
    pnlDocumentale: TPanel;
    lblTipologiaDocumenti: TLabel;
    dcmbTipologiaDocumenti: TDBLookupComboBox;
    pnlCartella: TPanel;
    lblRoot: TLabel;
    dedtRoot: TDBEdit;
    btnScegliRoot: TBitBtn;
    grpLivelli: TGroupBox;
    dgrdLivelli: TDBGrid;
    Splitter1: TSplitter;
    grpCampi: TGroupBox;
    dgrdCampi: TDBGrid;
    pnlTest: TPanel;
    btnTest: TSpeedButton;
    lblTest: TLabel;
    edtTest: TEdit;
    dcmbSorgenteDocumenti: TDBLookupComboBox;
    lblSorgenteDocumenti: TLabel;
    pnlUrlWS: TPanel;
    lblUrlWS: TLabel;
    dedtUrlWS: TDBEdit;
    procedure FormShow(Sender: TObject);
    procedure btnCheckFiltroClick(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
    procedure dedtFiltroChange(Sender: TObject);
    procedure dgrdCampiExit(Sender: TObject);
    procedure dgrdLivelliExit(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure edtTestChange(Sender: TObject);
    procedure btnScegliRootClick(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
  private
    function TestImpostazioni(const PStr: String; var RElencoValori: String): TResCtrl;
    procedure ImpostaPannelloInfoSorgente;
  public
    procedure OnI200AfterScroll;
  end;

var
  A118FPubblicazioneDocumenti: TA118FPubblicazioneDocumenti;

procedure OpenA118PubblicazioneDocumenti;

implementation

uses A118UPubblicazioneDocumentiDtM;

{$R *.dfm}

procedure OpenA118PubblicazioneDocumenti;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA118PubblicazioneDocumenti') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A118FPubblicazioneDocumenti:=TA118FPubblicazioneDocumenti.Create(nil);
  with A118FPubblicazioneDocumenti do
  try
    A118FPubblicazioneDocumentiDtM:=TA118FPubblicazioneDocumentiDtM.Create(nil);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A118FPubblicazioneDocumentiDtM.Free;
    Free;
  end;
end;

procedure TA118FPubblicazioneDocumenti.FormShow(Sender: TObject);
begin
  inherited;
  DButton.DataSet:=A118FPubblicazioneDocumentiDtM.selI200;
  dcmbSorgenteDocumenti.ListSource:=A118FPubblicazioneDocumentiDtM.A118MW.dsrI200Sorgente;
  OnI200AfterScroll;
end;

procedure TA118FPubblicazioneDocumenti.btnCheckFiltroClick(Sender: TObject);
var
  LResCtrl: TResCtrl;
begin
  LResCtrl:=A118FPubblicazioneDocumentiDtM.A118MW.CheckFiltroDocumenti(dedtFiltro.Text);
  if LResCtrl.Ok then
    R180MessageBox('Il filtro di visualizzazione documento è sintatticamente corretto!',INFORMA)
  else
  begin
    if LResCtrl.Messaggio = '' then
      R180MessageBox('Il filtro di visualizzazione documento è sintatticamente corretto, ma non è possibile determinarne il risultato!',INFORMA)
    else
      R180MessageBox(Format('Il filtro di visualizzazione documento è errato:'#13#10'%s',[LResCtrl.Messaggio]),ESCLAMA);
  end;
end;

procedure TA118FPubblicazioneDocumenti.btnScegliRootClick(Sender: TObject);
var
  LNewDir: String;
begin
  if FileCtrl.SelectDirectory('Directory base documenti','',LNewDir,[sdNewFolder,sdShowEdit,sdShowShares,sdNewUI,sdShowFiles,sdValidateDir]) then
    dedtRoot.Field.AsString:=LNewDir;
end;

procedure TA118FPubblicazioneDocumenti.btnTestClick(Sender: TObject);
var
  LElencoValori: String;
  LMsg: String;
  LResCtrl: TResCtrl;
begin
  if Trim(edtTest.Text) = '' then
  begin
    R180MessageBox('Indicare il nome di file / directory da testare',INFORMA);
  end
  else
  begin
    LResCtrl:=TestImpostazioni(edtTest.Text,LElencoValori);
    if LResCtrl.Ok then
      LMsg:='Sintassi del nome OK!'
    else
      LMsg:=Format('Sintassi del nome errata:'#13#10'%s',[LResCtrl.Messaggio]);
    LMsg:=Format('%s'#13#10#13#10'Verificare i valori dei campi, ignorando il dato %s:'#13#10'%s',
                 [LMsg,VAR_FILLER,LElencoValori]);
    R180MessageBox(LMsg,IfThen(LResCtrl.Ok,INFORMA,ESCLAMA));
  end;
end;

procedure TA118FPubblicazioneDocumenti.OnI200AfterScroll;
begin
  if (A118FPubblicazioneDocumentiDtM = nil) or
     (A118FPubblicazioneDocumentiDtM.selI200 = nil) then
    Exit;

  btnCheckFiltro.Enabled:=A118FPubblicazioneDocumentiDtM.selI200.FieldByName('FILTRO').AsString <> '';

  // visualizza dati in base alla sorgente dei documenti
  ImpostaPannelloInfoSorgente;
end;

procedure TA118FPubblicazioneDocumenti.ImpostaPannelloInfoSorgente;
var
  LSorg: String;
begin
  LSorg:=A118FPubblicazioneDocumentiDtM.selI200.FieldByName('SORGENTE_DOCUMENTI').AsString;
  grpLivelli.Visible:=(LSorg = SORGENTE_FS_EXT);
  grpLivelli.Top:=0;
  grpLivelli.Realign;

  pnlUrlWS.Visible:=(LSorg = SORGENTE_WS_ENGI_CU) or (LSorg = SORGENTE_WS_ENGI_CEDOL);
  pnlUrlWS.Top:=0;
  pnlUrlWS.Realign;

  pnlDocumentale.Visible:=(LSorg = SORGENTE_T960);
  pnlDocumentale.Top:=0;
  pnlDocumentale.Realign;

  pnlCartella.Visible:=(LSorg = SORGENTE_FS_EXT);
  pnlCartella.Top:=0;
  pnlCartella.Realign;

  grpCampi.Visible:=(LSorg = SORGENTE_FS_EXT);
  grpCampi.Realign;
end;

procedure TA118FPubblicazioneDocumenti.DButtonDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  ImpostaPannelloInfoSorgente;
end;

procedure TA118FPubblicazioneDocumenti.DButtonStateChange(Sender: TObject);
begin
  inherited;

  dedtCodice.ReadOnly:=(DButton.State = dsEdit);
  btnScegliRoot.Enabled:=(DButton.State <> dsBrowse);
  dcmbSorgenteDocumenti.Enabled:=(DButton.State <> dsBrowse);
end;

procedure TA118FPubblicazioneDocumenti.dedtFiltroChange(Sender: TObject);
begin
  btnCheckFiltro.Enabled:=Trim(dedtFiltro.Text) <> '';
end;

procedure TA118FPubblicazioneDocumenti.dgrdCampiExit(Sender: TObject);
begin
  if dgrdCampi.DataSource.Dataset.State in [dsInsert,dsEdit] then
    dgrdCampi.DataSource.Dataset.Post;
end;

procedure TA118FPubblicazioneDocumenti.dgrdLivelliExit(Sender: TObject);
begin
  if dgrdLivelli.DataSource.Dataset.State in [dsInsert,dsEdit] then
    dgrdLivelli.DataSource.Dataset.Post;
end;

procedure TA118FPubblicazioneDocumenti.edtTestChange(Sender: TObject);
begin
  btnTest.Enabled:=Trim(edtTest.Text) <> '';
end;

function TA118FPubblicazioneDocumenti.TestImpostazioni(const PStr: String; var RElencoValori: String): TResCtrl;
var
  LNome: String;
  LExt: String;
  LValore: String;
  LLiv: Integer;
  LIsLivelloFile: Boolean;
  LLivObj: TLivello;
  LA118MW: TA118FPubblicazioneDocumentiMW;
begin
  Result.Ok:=False;
  Result.Messaggio:='';
  RElencoValori:='';

  LA118MW:=TA118FPubblicazioneDocumentiMW.Create(nil);
  try
    // aggiunge il livello alla struttura dati
    LLiv:=A118FPubblicazioneDocumentiDtM.selI201.FieldByName('LIVELLO').AsInteger;
    LIsLivelloFile:=not A118FPubblicazioneDocumentiDtM.selI201.FieldByName('EXT').IsNull;
    LA118MW.AddLivello(LLiv,
                      A118FPubblicazioneDocumentiDtM.selI201.FieldByName('NOME').AsString,
                      A118FPubblicazioneDocumentiDtM.selI201.FieldByName('EXT').AsString,
                      A118FPubblicazioneDocumentiDtM.selI201.FieldByName('SEPARATORE').AsString,
                      A118FPubblicazioneDocumentiDtM.selI201.FieldByName('FILTRO').AsString);

    // filtra la struttura dei campi sul livello attuale
    LLivObj:=LA118MW.Livello[0];
    A118FPubblicazioneDocumentiDtM.selI202.First;
    while not A118FPubblicazioneDocumentiDtM.selI202.Eof do
    begin
      LExt:=IfThen(LIsLivelloFile,LLivObj.ExtFile,'');
      LLivObj.AddStrutturaCampo(A118FPubblicazioneDocumentiDtM.selI202.FieldByName('CAMPO').AsString,
                               A118FPubblicazioneDocumentiDtM.selI202.FieldByName('DAL').AsInteger,
                               A118FPubblicazioneDocumentiDtM.selI202.FieldByName('LUNG').AsInteger,
                               'N',LExt);
      A118FPubblicazioneDocumentiDtM.selI202.Next;
    end;
    A118FPubblicazioneDocumentiDtM.selI202.First;

    // salva il livello massimo delle directory
    if LIsLivelloFile then
      LA118MW.LivFile:=LLiv
    else if LLiv > LA118MW.LivMaxDir then
      LA118MW.LivMaxDir:=LLiv;

    // verifica se il nome file rispecchia formalmente la struttura definita per il livello
    LLivObj.NomeFile:=PStr;
    Result:=LLivObj.MatchNome(TTipoTest.Formale);

    // visualizza i valori associati ai campi
    A118FPubblicazioneDocumentiDtM.selI202.DisableControls;
    A118FPubblicazioneDocumentiDtM.selI202.BeforePost:=nil;
    A118FPubblicazioneDocumentiDtM.selI202.First;
    while not A118FPubblicazioneDocumentiDtM.selI202.Eof do
    begin
      LNome:=A118FPubblicazioneDocumentiDtM.selI202.FieldByName('CAMPO').AsString.ToUpper;
      if LNome.StartsWith(PREFISSO_VAR) then
      begin
        LNome:=LNome.Substring(PREFISSO_VAR.Length);
        LValore:=LLivObj.GetCampo(LNome).Valore;
      end
      else
        LValore:=LNome;
      RElencoValori:=RElencoValori + #13#10 + Format('%s = "%s"',[LNome,LValore]);
      A118FPubblicazioneDocumentiDtM.selI202.Next;
    end;
    // estensione
    if LA118MW.LivFile > 0 then
    begin
      try
        RElencoValori:=RElencoValori + #13#10'---'#13#10 + Format('Estensione = "%s"',[LLivObj.ExtFile]);
      except
      end;
    end;
    if RElencoValori <> '' then
      RElencoValori:=RElencoValori.Substring(Length(#13#10));
    A118FPubblicazioneDocumentiDtM.selI202.BeforePost:=A118FPubblicazioneDocumentiDtM.selI202BeforePost;
    A118FPubblicazioneDocumentiDtM.selI202.First;
    A118FPubblicazioneDocumentiDtM.selI202.EnableControls;
  finally
    FreeAndNil(LA118MW);
  end;
end;

end.
