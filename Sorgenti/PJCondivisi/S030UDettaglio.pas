unit S030UDettaglio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin,
  Grids, DBGrids, ExtCtrls, StdCtrls, Buttons, C180FunzioniGenerali,
  A000UCostanti, A000USessione, A000UInterfaccia, A000UMessaggi,
  Oracle, OracleData, EKRtf, C004UParamForm, System.Actions, ShellAPI;

type
  TS030FDettaglio = class(TR001FGestTab)
    Panel2: TPanel;
    dgrdDettaglioProvvedimenti: TDBGrid;
    lblMatricola: TLabel;
    edtDataDecorrenza: TEdit;
    lblDataDecorrenza: TLabel;
    edtMotivazione: TEdit;
    lblMotivazione: TLabel;
    edtTipoAtto: TEdit;
    lblTipoAtto: TLabel;
    edtMatricola: TEdit;
    lblNumAtto: TLabel;
    edtNumAtto: TEdit;
    lblDipendente: TLabel;
    lblDescMotivazione: TLabel;
    OpenDialog1: TOpenDialog;
    Panel3: TPanel;
    btnElabora: TBitBtn;
    btnStampa: TBitBtn;
    btnChiudi: TBitBtn;
    ProgressBar1: TProgressBar;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnElaboraClick(Sender: TObject);
    procedure btnStampaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  S030FDettaglio: TS030FDettaglio;

implementation

uses S030UProvvedimentiDtM;

{$R *.dfm}

procedure TS030FDettaglio.FormShow(Sender: TObject);
begin
  inherited;
  DButton.DataSet:=S030FProvvedimentiDtM.S030MW.selSG095;
  actInserisci.Visible:=False;
  actModifica.Visible:=False;
  actCancella.Visible:=False;
  actConferma.Visible:=False;
  actAnnulla.Visible:=False;
  actGomma.Visible:=False;
  actRefresh.Visible:=False;
  CreaC004(SessioneOracle,'S030',Parametri.ProgOper);
  btnElabora.Enabled:=not SolaLettura;
  with S030FProvvedimentiDtM.S030MW do
  begin
    edtMatricola.Text:=SelAnagrafe.FieldByName('MATRICOLA').AsString;
    lblDipendente.Caption:=SelAnagrafe.FieldByName('COGNOME').AsString + ' ' + SelAnagrafe.FieldByName('NOME').AsString;
    edtMotivazione.Text:=selSG100.FieldByName('CAUSALE').AsString;
    lblDescMotivazione.Caption:=selSG100.FieldByName('D_CAUSALI').AsString;
    edtDataDecorrenza.Text:=selSG100.FieldByName('DATADECOR').AsString;
    edtTipoAtto.Text:=selSG100.FieldByName('TIPOATTO').AsString;
    edtNumAtto.Text:=selSG100.FieldByName('NUMATTO').AsString;
    ApriDettaglioProvvedimento;
    if not CercaMotivazione then
      R180MessageBox(Format(A000MSG_S030_MSG_FMT_MOTIVAZIONE,[selSG100.FieldByName('CAUSALE').AsString]),'ERRORE');
  end;
end;

procedure TS030FDettaglio.FormDestroy(Sender: TObject);
begin
  inherited;
  C004FParamForm.Free;
end;

procedure TS030FDettaglio.btnElaboraClick(Sender: TObject);
var i:Integer;
begin
  inherited;
  with S030FProvvedimentiDtM.S030MW do
  begin
    if selSG095.RecordCount > 0 then
      S030FProvvedimentiDtM.evtRichiesta(A000MSG_S030_DLG_CANCELLA_DETTAGLIO,'');
    S030FProvvedimentiDtM.evtRichiesta(Format(A000MSG_S030_DLG_FMT_ELABORA_DETTAGLIO,[SelAnagrafe.FieldByName('COGNOME').AsString + ' ' + SelAnagrafe.FieldByName('NOME').AsString,selSG100.FieldByName('DATADECOR').AsString]),'');
    try
      Screen.Cursor:=crHourGlass;
      selSG095.DisableControls;
      //Cancello tutto per pulire la tabella
      Elaborazione_Cancella;
      //Carico i valori precedenti risultanti dalle query di P660 a Decorrenza-1
      ProgressBar1.Position:=0;
      ProgressBar1.Max:=lstNumeriPrec.Count;
      for i:=0 to lstNumeriPrec.Count - 1 do
      begin
        ProgressBar1.StepBy(1);
        Elaborazione_InserisciPrec(lstNumeriPrec.Strings[i]);
      end;
      SessioneOracle.Commit;
      selSG095.Refresh;
      //Carico i valori successivi risultanti dalle query di P660 a Decorrenza
      ProgressBar1.Position:=0;
      ProgressBar1.Max:=lstNumeriPrec.Count;
      for i:=0 to lstNumeriSucc.Count - 1 do
      begin
        ProgressBar1.StepBy(1);
        Elaborazione_InserisciSucc(lstNumeriSucc.Strings[i]);
      end;
      SessioneOracle.Commit;
      selSG095.Refresh;
      selSG095.First;
    finally
      selSG095.EnableControls;
      Screen.Cursor:=crDefault;
      ProgressBar1.Position:=0;
    end;
    R180MessageBox(A000MSG_MSG_ELAB_OK,'INFORMA');
  end;
end;

procedure TS030FDettaglio.btnStampaClick(Sender: TObject);
var ModuloRtf: TEKRtf;
  j:Integer;
  (*TempPath,*)NomeFile:String;
begin
  inherited;
  with S030FProvvedimentiDtM.S030MW do
  begin
    OpenDialog1.Title:='Scelta del modello .rtf da stampare';
    NomeModello:=C004FParamForm.GetParametro('NOMECERT','');
    if Trim(NomeModello) <> '' then
      OpenDialog1.InitialDir:=R180GetFilePath(NomeModello)
    else
      OpenDialog1.InitialDir:=R180GetFilePath(Application.ExeName);
    if OpenDialog1.Execute then
      NomeModello:=OpenDialog1.FileName
    else
      Exit;
    try
      CreaStampaRTF;
    finally
      C004FParamForm.Cancella001;
      C004FParamForm.PutParametro('NOMECERT',NomeModello);
      try SessioneOracle.Commit; except end;
    end;
  end;
end;

end.
