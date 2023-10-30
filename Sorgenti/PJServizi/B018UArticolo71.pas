unit B018UArticolo71;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, DBCtrls, StdCtrls, Spin, ComCtrls, DB, Menus, Math,

  checklst,A000UCostanti, A000USessione,A000UInterfaccia, C700USelezioneAnagrafe, RegistrazioneLog,
  C180FunzioniGenerali, ExtCtrls, A003UDataLavoroBis, SelAnagrafe, C004UParamForm, C012UVisualizzaTesto,
  C015UElencoValori, C005UDatiAnagrafici, Grids, DBGrids, OracleData, Variants, C013UCheckList, Provider;

type
  TTabelle = record
    Nome,Desc:String;
    Peri: Char;
    Campi:String;
    Indiv,Dipe,Log:Boolean;
  end;
  TCampi=TStringList;
  TB018FArticolo71 = class(TForm)
    ProgressBar: TProgressBar;
    StatusBar: TStatusBar;
    Panel1: TPanel;
    btnEsegui: TBitBtn;
    btnChiudi: TBitBtn;
    frmSelAnagrafe: TfrmSelAnagrafe;
    Panel2: TPanel;
    LblDaData: TLabel;
    LblAData: TLabel;
    TBBDaData: TBitBtn;
    TBBAData: TBitBtn;
    btnLog: TBitBtn;
    BitBtn1: TBitBtn;
    PageControl1: TPageControl;
    tbsPagina1: TTabSheet;
    tbsPagina2: TTabSheet;
    Label2: TLabel;
    edtCodOrigine1: TEdit;
    btnCodOrigine1: TButton;
    lblDescOrigine1: TLabel;
    edtCodOrigine2: TEdit;
    btnCodOrigine2: TButton;
    lblDescOrigine2: TLabel;
    edtCodOrigine3: TEdit;
    btnCodOrigine3: TButton;
    lblDescOrigine3: TLabel;
    edtCodOrigine4: TEdit;
    btnCodOrigine4: TButton;
    lblDescOrigine4: TLabel;
    edtCodOrigine5: TEdit;
    btnCodOrigine5: TButton;
    lblDescOrigine5: TLabel;
    edtCodOrigine6: TEdit;
    btnCodOrigine6: TButton;
    lblDescOrigine6: TLabel;
    edtCodOrigine7: TEdit;
    btnCodOrigine7: TButton;
    lblDescOrigine7: TLabel;
    edtCodOrigine8: TEdit;
    btnCodOrigine8: TButton;
    lblDescOrigine8: TLabel;
    edtCodOrigine9: TEdit;
    btnCodOrigine9: TButton;
    lblDescOrigine9: TLabel;
    btnCodOrigine10: TButton;
    edtCodOrigine10: TEdit;
    lblDescOrigine10: TLabel;
    edtCodDest10: TEdit;
    btnCodDest10: TButton;
    lblDescDest10: TLabel;
    edtCodDest9: TEdit;
    edtCodDest8: TEdit;
    edtCodDest7: TEdit;
    edtCodDest6: TEdit;
    edtCodDest5: TEdit;
    edtCodDest4: TEdit;
    edtCodDest3: TEdit;
    edtCodDest2: TEdit;
    edtCodDest1: TEdit;
    btnCodDest1: TButton;
    btnCodDest2: TButton;
    btnCodDest3: TButton;
    btnCodDest4: TButton;
    btnCodDest5: TButton;
    btnCodDest6: TButton;
    btnCodDest7: TButton;
    btnCodDest8: TButton;
    btnCodDest9: TButton;
    lblDescDest9: TLabel;
    lblDescDest8: TLabel;
    lblDescDest7: TLabel;
    lblDescDest6: TLabel;
    lblDescDest5: TLabel;
    lblDescDest4: TLabel;
    lblDescDest3: TLabel;
    lblDescDest2: TLabel;
    lblDescDest1: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    edtCodOrigine11: TEdit;
    btnCodOrigine11: TButton;
    lblDescOrigine11: TLabel;
    edtCodOrigine12: TEdit;
    btnCodOrigine12: TButton;
    lblDescOrigine12: TLabel;
    edtCodOrigine13: TEdit;
    btnCodOrigine13: TButton;
    lblDescOrigine13: TLabel;
    edtCodOrigine14: TEdit;
    btnCodOrigine14: TButton;
    lblDescOrigine14: TLabel;
    edtCodOrigine15: TEdit;
    btnCodOrigine15: TButton;
    lblDescOrigine15: TLabel;
    edtCodOrigine16: TEdit;
    btnCodOrigine16: TButton;
    lblDescOrigine16: TLabel;
    edtCodOrigine17: TEdit;
    btnCodOrigine17: TButton;
    lblDescOrigine17: TLabel;
    edtCodOrigine18: TEdit;
    btnCodOrigine18: TButton;
    lblDescOrigine18: TLabel;
    edtCodOrigine19: TEdit;
    btnCodOrigine19: TButton;
    lblDescOrigine19: TLabel;
    btnCodOrigine20: TButton;
    edtCodOrigine20: TEdit;
    lblDescOrigine20: TLabel;
    edtCodDest20: TEdit;
    btnCodDest20: TButton;
    lblDescDest20: TLabel;
    edtCodDest19: TEdit;
    edtCodDest18: TEdit;
    edtCodDest17: TEdit;
    edtCodDest16: TEdit;
    edtCodDest15: TEdit;
    edtCodDest14: TEdit;
    edtCodDest13: TEdit;
    edtCodDest12: TEdit;
    edtCodDest11: TEdit;
    btnCodDest11: TButton;
    btnCodDest12: TButton;
    btnCodDest13: TButton;
    btnCodDest14: TButton;
    btnCodDest15: TButton;
    btnCodDest16: TButton;
    btnCodDest17: TButton;
    btnCodDest18: TButton;
    btnCodDest19: TButton;
    lblDescDest19: TLabel;
    lblDescDest18: TLabel;
    lblDescDest17: TLabel;
    lblDescDest16: TLabel;
    lblDescDest15: TLabel;
    lblDescDest14: TLabel;
    lblDescDest13: TLabel;
    lblDescDest12: TLabel;
    lblDescDest11: TLabel;
    Label24: TLabel;
    procedure dcmbKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnEseguiClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TBBDaDataClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure btnLogClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnCodOrigine1Click(Sender: TObject);
    procedure TBBADataClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodOrigine1Change(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure PageControl1Changing(Sender: TObject; var AllowChange: Boolean);
  Private
    { Private declarations }
    InterrompiElaborazione:boolean;
    FileLog:String;
    CodOrigine, CodDest:array[1..20] of String;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure RicodificaGiustificativi;
    procedure ImpostaDescCaus;
  Public
    { Public declarations }
    AllaData:TDateTime;
    DallaData:TDateTime;
    Badge,Nome:String;
end;

var
  B018FArticolo71: TB018FArticolo71;

implementation

uses B018UArticolo71DtM1;

{$R *.DFM}

procedure TB018FArticolo71.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not btnChiudi.Enabled then
    Action:=caNone
  else
  begin
    PutParametriFunzione;
    C004FParamForm.Free;
  end;
end;

procedure TB018FArticolo71.FormCreate(Sender: TObject);
begin
  {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortDateFormat:='dd/mm/yyyy';
end;

procedure TB018FArticolo71.FormShow(Sender: TObject);
begin
  CreaC004(SessioneOracle,'B018',Parametri.ProgOper);
  GetParametriFunzione;
  AllaData:=Parametri.DataLavoro;
  DallaData:=Parametri.DataLavoro;
  LblAData.Caption:=FormatDateTime('dd MMM yyyy',AllaData);
  LblDaData.Caption:=FormatDateTime('dd MMM yyyy',DallaData);
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase + ', T430INIZIO, T430FINE';
  C700DataLavoro:=Parametri.DataLavoro;
  C700DataDal:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,StatusBar,0,True);
  frmSelAnagrafe.SoloPersonaleInterno:=False;
  frmSelAnagrafe.SelezionePeriodica:=True;
  FileLog:=ExtractFilePath(Application.ExeName) + 'Archivi\Temp\B018_' + Parametri.Operatore + '.log';
  ImpostaDescCaus;
end;

procedure TB018FArticolo71.GetParametriFunzione;
{Leggo i parametri della form}
begin
  edtCodOrigine1.Text:=C004FParamForm.GetParametro('edtCodOrigine1','');
  edtCodOrigine2.Text:=C004FParamForm.GetParametro('edtCodOrigine2','');
  edtCodOrigine3.Text:=C004FParamForm.GetParametro('edtCodOrigine3','');
  edtCodOrigine4.Text:=C004FParamForm.GetParametro('edtCodOrigine4','');
  edtCodOrigine5.Text:=C004FParamForm.GetParametro('edtCodOrigine5','');
  edtCodOrigine6.Text:=C004FParamForm.GetParametro('edtCodOrigine6','');
  edtCodOrigine7.Text:=C004FParamForm.GetParametro('edtCodOrigine7','');
  edtCodOrigine8.Text:=C004FParamForm.GetParametro('edtCodOrigine8','');
  edtCodOrigine9.Text:=C004FParamForm.GetParametro('edtCodOrigine9','');
  edtCodOrigine10.Text:=C004FParamForm.GetParametro('edtCodOrigine10','');
  edtCodOrigine11.Text:=C004FParamForm.GetParametro('edtCodOrigine11','');
  edtCodOrigine12.Text:=C004FParamForm.GetParametro('edtCodOrigine12','');
  edtCodOrigine13.Text:=C004FParamForm.GetParametro('edtCodOrigine13','');
  edtCodOrigine14.Text:=C004FParamForm.GetParametro('edtCodOrigine14','');
  edtCodOrigine15.Text:=C004FParamForm.GetParametro('edtCodOrigine15','');
  edtCodOrigine16.Text:=C004FParamForm.GetParametro('edtCodOrigine16','');
  edtCodOrigine17.Text:=C004FParamForm.GetParametro('edtCodOrigine17','');
  edtCodOrigine18.Text:=C004FParamForm.GetParametro('edtCodOrigine18','');
  edtCodOrigine19.Text:=C004FParamForm.GetParametro('edtCodOrigine19','');
  edtCodOrigine20.Text:=C004FParamForm.GetParametro('edtCodOrigine20','');

  edtCodDest1.Text:=C004FParamForm.GetParametro('edtCodDest1','');
  edtCodDest2.Text:=C004FParamForm.GetParametro('edtCodDest2','');
  edtCodDest3.Text:=C004FParamForm.GetParametro('edtCodDest3','');
  edtCodDest4.Text:=C004FParamForm.GetParametro('edtCodDest4','');
  edtCodDest5.Text:=C004FParamForm.GetParametro('edtCodDest5','');
  edtCodDest6.Text:=C004FParamForm.GetParametro('edtCodDest6','');
  edtCodDest7.Text:=C004FParamForm.GetParametro('edtCodDest7','');
  edtCodDest8.Text:=C004FParamForm.GetParametro('edtCodDest8','');
  edtCodDest9.Text:=C004FParamForm.GetParametro('edtCodDest9','');
  edtCodDest10.Text:=C004FParamForm.GetParametro('edtCodDest10','');
  edtCodDest11.Text:=C004FParamForm.GetParametro('edtCodDest11','');
  edtCodDest12.Text:=C004FParamForm.GetParametro('edtCodDest12','');
  edtCodDest13.Text:=C004FParamForm.GetParametro('edtCodDest13','');
  edtCodDest14.Text:=C004FParamForm.GetParametro('edtCodDest14','');
  edtCodDest15.Text:=C004FParamForm.GetParametro('edtCodDest15','');
  edtCodDest16.Text:=C004FParamForm.GetParametro('edtCodDest16','');
  edtCodDest17.Text:=C004FParamForm.GetParametro('edtCodDest17','');
  edtCodDest18.Text:=C004FParamForm.GetParametro('edtCodDest18','');
  edtCodDest19.Text:=C004FParamForm.GetParametro('edtCodDest19','');
  edtCodDest20.Text:=C004FParamForm.GetParametro('edtCodDest20','');
end;

procedure TB018FArticolo71.PageControl1Changing(Sender: TObject;
  var AllowChange: Boolean);
var
  Abilita: Boolean;
begin
  if ((Sender as TPageControl).ActivePage = tbsPagina1) then
    Abilita:=(edtCodOrigine1.Text <> '') and
             (edtCodOrigine2.Text <> '') and
             (edtCodOrigine3.Text <> '') and
             (edtCodOrigine4.Text <> '') and
             (edtCodOrigine5.Text <> '') and
             (edtCodOrigine6.Text <> '') and
             (edtCodOrigine7.Text <> '') and
             (edtCodOrigine8.Text <> '') and
             (edtCodOrigine9.Text <> '') and
             (edtCodOrigine10.Text <> '')
  else
    Abilita:=True;

  // avviso se i codici non sono tutti compilati in pagina 1
  if not Abilita then
    R180MessageBox('E'' consigliabile compilare per intero la prima pagina di codici' + #13#10 +
                   'prima di procedere con la seconda.', INFORMA);

  // abilita comunque il passaggio al secondo tab
  AllowChange:=True;
end;

procedure TB018FArticolo71.PutParametriFunzione;
{Scrivo i parametri della form}
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('edtCodOrigine1',edtCodOrigine1.Text);
  C004FParamForm.PutParametro('edtCodOrigine2',edtCodOrigine2.Text);
  C004FParamForm.PutParametro('edtCodOrigine3',edtCodOrigine3.Text);
  C004FParamForm.PutParametro('edtCodOrigine4',edtCodOrigine4.Text);
  C004FParamForm.PutParametro('edtCodOrigine5',edtCodOrigine5.Text);
  C004FParamForm.PutParametro('edtCodOrigine6',edtCodOrigine6.Text);
  C004FParamForm.PutParametro('edtCodOrigine7',edtCodOrigine7.Text);
  C004FParamForm.PutParametro('edtCodOrigine8',edtCodOrigine8.Text);
  C004FParamForm.PutParametro('edtCodOrigine9',edtCodOrigine9.Text);
  C004FParamForm.PutParametro('edtCodOrigine10',edtCodOrigine10.Text);
  C004FParamForm.PutParametro('edtCodOrigine11',edtCodOrigine11.Text);
  C004FParamForm.PutParametro('edtCodOrigine12',edtCodOrigine12.Text);
  C004FParamForm.PutParametro('edtCodOrigine13',edtCodOrigine13.Text);
  C004FParamForm.PutParametro('edtCodOrigine14',edtCodOrigine14.Text);
  C004FParamForm.PutParametro('edtCodOrigine15',edtCodOrigine15.Text);
  C004FParamForm.PutParametro('edtCodOrigine16',edtCodOrigine16.Text);
  C004FParamForm.PutParametro('edtCodOrigine17',edtCodOrigine17.Text);
  C004FParamForm.PutParametro('edtCodOrigine18',edtCodOrigine18.Text);
  C004FParamForm.PutParametro('edtCodOrigine19',edtCodOrigine19.Text);
  C004FParamForm.PutParametro('edtCodOrigine20',edtCodOrigine20.Text);

  C004FParamForm.PutParametro('edtCodDest1',edtCodDest1.Text);
  C004FParamForm.PutParametro('edtCodDest2',edtCodDest2.Text);
  C004FParamForm.PutParametro('edtCodDest3',edtCodDest3.Text);
  C004FParamForm.PutParametro('edtCodDest4',edtCodDest4.Text);
  C004FParamForm.PutParametro('edtCodDest5',edtCodDest5.Text);
  C004FParamForm.PutParametro('edtCodDest6',edtCodDest6.Text);
  C004FParamForm.PutParametro('edtCodDest7',edtCodDest7.Text);
  C004FParamForm.PutParametro('edtCodDest8',edtCodDest8.Text);
  C004FParamForm.PutParametro('edtCodDest9',edtCodDest9.Text);
  C004FParamForm.PutParametro('edtCodDest10',edtCodDest10.Text);
  C004FParamForm.PutParametro('edtCodDest11',edtCodDest11.Text);
  C004FParamForm.PutParametro('edtCodDest12',edtCodDest12.Text);
  C004FParamForm.PutParametro('edtCodDest13',edtCodDest13.Text);
  C004FParamForm.PutParametro('edtCodDest14',edtCodDest14.Text);
  C004FParamForm.PutParametro('edtCodDest15',edtCodDest15.Text);
  C004FParamForm.PutParametro('edtCodDest16',edtCodDest16.Text);
  C004FParamForm.PutParametro('edtCodDest17',edtCodDest17.Text);
  C004FParamForm.PutParametro('edtCodDest18',edtCodDest18.Text);
  C004FParamForm.PutParametro('edtCodDest19',edtCodDest19.Text);
  C004FParamForm.PutParametro('edtCodDest20',edtCodDest20.Text);
end;

procedure TB018FArticolo71.TBBDaDataClick(Sender: TObject);
begin
  DallaData:=DataOut(DallaData,'Dalla data:','G');
  if DallaData < Encodedate(2008,06,25) then
  begin
    R180MessageBox('Il periodo non può essere antecedente al 25/06/2008 come previsto dal D.L.','ERRORE');
    DallaData:=Encodedate(2008,06,25);
  end;
  LblDaData.Caption:=FormatDateTime('dd mmm yyyy',DallaData);
end;

procedure TB018FArticolo71.TBBADataClick(Sender: TObject);
begin
  AllaData:=DataOut(AllaData,'Alla data:','G');
  LblAData.Caption:=FormatDateTime('dd mmm yyyy',AllaData);
end;

procedure TB018FArticolo71.edtCodOrigine1Change(Sender: TObject);
begin
  ImpostaDescCaus;
end;

procedure TB018FArticolo71.BitBtn1Click(Sender: TObject);
begin
  R180MessageBox('Nella colonna di sinistra vanno inseriti tutti i codici di '
    + 'malattia che servono per individuare il periodo dei primi 10 giorni.' + CHR(13)
    + 'Sulla colonna di destra, per ogni causale che deve essere trasformata, '
    + 'indicare il corrispondente codice che applica la riduzione; se non '
    + 'viene indicato nessun valore la causale non viene convertita.' + CHR(13)
    + CHR(13)
    + 'Nel caso di errore nella ricodifica di un codice, è '
    + 'possibile rimettere il codice originale, impostando nella colonna di '
    + 'sinistra il codice della riduzione e sulla corrispondente colonna di '
    + 'destra il codice originale.'
    + CHR(13)
    + 'Il periodo di applicazione non può essere antecedente al 25/06/2008 e '
    +'la conversione viene effettuata anche per le malattie in corso a quella data.' + CHR(13)
    + CHR(13)
    + 'Si può rielaborare anche più volte lo stesso periodo.'
  ,'INFORMA');
end;

procedure TB018FArticolo71.btnCodOrigine1Click(Sender: TObject);
var
  Ret:Variant;
  S:String;
begin
  with B018FArticolo71DtM1 do
  begin
    S:=B018FArticolo71DtM1.selQ265.SQL.Text;
    OpenC015FElencoValori('T265_CAUASSENZE','<B018> Ricodifica malattia Art.71 D.L.112/08',S,'CODICE',Ret,selQ265);
    if not VarIsClear(Ret) then
    begin
      if sender = btnCodOrigine1 then
        edtCodOrigine1.Text:=VarToStr(Ret[0])
      else if sender = btnCodOrigine2 then
        edtCodOrigine2.Text:=VarToStr(Ret[0])
      else if sender = btnCodOrigine3 then
        edtCodOrigine3.Text:=VarToStr(Ret[0])
      else if sender = btnCodOrigine4 then
        edtCodOrigine4.Text:=VarToStr(Ret[0])
      else if sender = btnCodOrigine5 then
        edtCodOrigine5.Text:=VarToStr(Ret[0])
      else if sender = btnCodOrigine6 then
        edtCodOrigine6.Text:=VarToStr(Ret[0])
      else if sender = btnCodOrigine7 then
        edtCodOrigine7.Text:=VarToStr(Ret[0])
      else if sender = btnCodOrigine8 then
        edtCodOrigine8.Text:=VarToStr(Ret[0])
      else if sender = btnCodOrigine9 then
        edtCodOrigine9.Text:=VarToStr(Ret[0])
      else if sender = btnCodOrigine10 then
        edtCodOrigine10.Text:=VarToStr(Ret[0])
      else if sender = btnCodOrigine11 then
        edtCodOrigine11.Text:=VarToStr(Ret[0])
      else if sender = btnCodOrigine12 then
        edtCodOrigine12.Text:=VarToStr(Ret[0])
      else if sender = btnCodOrigine13 then
        edtCodOrigine13.Text:=VarToStr(Ret[0])
      else if sender = btnCodOrigine14 then
        edtCodOrigine14.Text:=VarToStr(Ret[0])
      else if sender = btnCodOrigine15 then
        edtCodOrigine15.Text:=VarToStr(Ret[0])
      else if sender = btnCodOrigine16 then
        edtCodOrigine16.Text:=VarToStr(Ret[0])
      else if sender = btnCodOrigine17 then
        edtCodOrigine17.Text:=VarToStr(Ret[0])
      else if sender = btnCodOrigine18 then
        edtCodOrigine18.Text:=VarToStr(Ret[0])
      else if sender = btnCodOrigine19 then
        edtCodOrigine19.Text:=VarToStr(Ret[0])
      else if sender = btnCodOrigine20 then
        edtCodOrigine20.Text:=VarToStr(Ret[0])
      else if sender = btnCodDest1 then
        edtCodDest1.Text:=VarToStr(Ret[0])
      else if sender = btnCodDest2 then
        edtCodDest2.Text:=VarToStr(Ret[0])
      else if sender = btnCodDest3 then
        edtCodDest3.Text:=VarToStr(Ret[0])
      else if sender = btnCodDest4 then
        edtCodDest4.Text:=VarToStr(Ret[0])
      else if sender = btnCodDest5 then
        edtCodDest5.Text:=VarToStr(Ret[0])
      else if sender = btnCodDest6 then
        edtCodDest6.Text:=VarToStr(Ret[0])
      else if sender = btnCodDest7 then
        edtCodDest7.Text:=VarToStr(Ret[0])
      else if sender = btnCodDest8 then
        edtCodDest8.Text:=VarToStr(Ret[0])
      else if sender = btnCodDest9 then
        edtCodDest9.Text:=VarToStr(Ret[0])
      else if sender = btnCodDest10 then
        edtCodDest10.Text:=VarToStr(Ret[0])
      else if sender = btnCodDest11 then
        edtCodDest11.Text:=VarToStr(Ret[0])
      else if sender = btnCodDest12 then
        edtCodDest12.Text:=VarToStr(Ret[0])
      else if sender = btnCodDest13 then
        edtCodDest13.Text:=VarToStr(Ret[0])
      else if sender = btnCodDest14 then
        edtCodDest14.Text:=VarToStr(Ret[0])
      else if sender = btnCodDest15 then
        edtCodDest15.Text:=VarToStr(Ret[0])
      else if sender = btnCodDest16 then
        edtCodDest16.Text:=VarToStr(Ret[0])
      else if sender = btnCodDest17 then
        edtCodDest17.Text:=VarToStr(Ret[0])
      else if sender = btnCodDest18 then
        edtCodDest18.Text:=VarToStr(Ret[0])
      else if sender = btnCodDest19 then
        edtCodDest19.Text:=VarToStr(Ret[0])
      else if sender = btnCodDest20 then
        edtCodDest20.Text:=VarToStr(Ret[0]);
    end;
  end;
  ImpostaDescCaus;
end;

procedure TB018FArticolo71.ImpostaDescCaus;
begin
  with B018FArticolo71DtM1 do
  begin
    if selQ265.SearchRecord('CODICE',VarArrayOf([edtCodOrigine1.Text]),[srFromBeginning]) then
      lblDescOrigine1.Caption:=selQ265.FieldByName('DESCRIZIONE').AsString
    else
      lblDescOrigine1.Caption:='';
    if selQ265.SearchRecord('CODICE',VarArrayOf([edtCodOrigine2.Text]),[srFromBeginning]) then
      lblDescOrigine2.Caption:=selQ265.FieldByName('DESCRIZIONE').AsString
    else
      lblDescOrigine2.Caption:='';
    if selQ265.SearchRecord('CODICE',VarArrayOf([edtCodOrigine3.Text]),[srFromBeginning]) then
      lblDescOrigine3.Caption:=selQ265.FieldByName('DESCRIZIONE').AsString
    else
      lblDescOrigine3.Caption:='';
    if selQ265.SearchRecord('CODICE',VarArrayOf([edtCodOrigine4.Text]),[srFromBeginning]) then
      lblDescOrigine4.Caption:=selQ265.FieldByName('DESCRIZIONE').AsString
    else
      lblDescOrigine4.Caption:='';
    if selQ265.SearchRecord('CODICE',VarArrayOf([edtCodOrigine5.Text]),[srFromBeginning]) then
      lblDescOrigine5.Caption:=selQ265.FieldByName('DESCRIZIONE').AsString
    else
      lblDescOrigine5.Caption:='';
    if selQ265.SearchRecord('CODICE',VarArrayOf([edtCodOrigine6.Text]),[srFromBeginning]) then
      lblDescOrigine6.Caption:=selQ265.FieldByName('DESCRIZIONE').AsString
    else
      lblDescOrigine6.Caption:='';
    if selQ265.SearchRecord('CODICE',VarArrayOf([edtCodOrigine7.Text]),[srFromBeginning]) then
      lblDescOrigine7.Caption:=selQ265.FieldByName('DESCRIZIONE').AsString
    else
      lblDescOrigine7.Caption:='';
    if selQ265.SearchRecord('CODICE',VarArrayOf([edtCodOrigine8.Text]),[srFromBeginning]) then
      lblDescOrigine8.Caption:=selQ265.FieldByName('DESCRIZIONE').AsString
    else
      lblDescOrigine8.Caption:='';
    if selQ265.SearchRecord('CODICE',VarArrayOf([edtCodOrigine9.Text]),[srFromBeginning]) then
      lblDescOrigine9.Caption:=selQ265.FieldByName('DESCRIZIONE').AsString
    else
      lblDescOrigine9.Caption:='';
    if selQ265.SearchRecord('CODICE',VarArrayOf([edtCodOrigine10.Text]),[srFromBeginning]) then
      lblDescOrigine10.Caption:=selQ265.FieldByName('DESCRIZIONE').AsString
    else
      lblDescOrigine10.Caption:='';
    if selQ265.SearchRecord('CODICE',VarArrayOf([edtCodOrigine11.Text]),[srFromBeginning]) then
      lblDescOrigine11.Caption:=selQ265.FieldByName('DESCRIZIONE').AsString
    else
      lblDescOrigine11.Caption:='';
    if selQ265.SearchRecord('CODICE',VarArrayOf([edtCodOrigine12.Text]),[srFromBeginning]) then
      lblDescOrigine12.Caption:=selQ265.FieldByName('DESCRIZIONE').AsString
    else
      lblDescOrigine12.Caption:='';
    if selQ265.SearchRecord('CODICE',VarArrayOf([edtCodOrigine13.Text]),[srFromBeginning]) then
      lblDescOrigine13.Caption:=selQ265.FieldByName('DESCRIZIONE').AsString
    else
      lblDescOrigine13.Caption:='';
    if selQ265.SearchRecord('CODICE',VarArrayOf([edtCodOrigine14.Text]),[srFromBeginning]) then
      lblDescOrigine14.Caption:=selQ265.FieldByName('DESCRIZIONE').AsString
    else
      lblDescOrigine14.Caption:='';
    if selQ265.SearchRecord('CODICE',VarArrayOf([edtCodOrigine15.Text]),[srFromBeginning]) then
      lblDescOrigine15.Caption:=selQ265.FieldByName('DESCRIZIONE').AsString
    else
      lblDescOrigine15.Caption:='';
    if selQ265.SearchRecord('CODICE',VarArrayOf([edtCodOrigine16.Text]),[srFromBeginning]) then
      lblDescOrigine16.Caption:=selQ265.FieldByName('DESCRIZIONE').AsString
    else
      lblDescOrigine16.Caption:='';
    if selQ265.SearchRecord('CODICE',VarArrayOf([edtCodOrigine17.Text]),[srFromBeginning]) then
      lblDescOrigine17.Caption:=selQ265.FieldByName('DESCRIZIONE').AsString
    else
      lblDescOrigine17.Caption:='';
    if selQ265.SearchRecord('CODICE',VarArrayOf([edtCodOrigine18.Text]),[srFromBeginning]) then
      lblDescOrigine18.Caption:=selQ265.FieldByName('DESCRIZIONE').AsString
    else
      lblDescOrigine18.Caption:='';
    if selQ265.SearchRecord('CODICE',VarArrayOf([edtCodOrigine19.Text]),[srFromBeginning]) then
      lblDescOrigine19.Caption:=selQ265.FieldByName('DESCRIZIONE').AsString
    else
      lblDescOrigine19.Caption:='';
    if selQ265.SearchRecord('CODICE',VarArrayOf([edtCodOrigine20.Text]),[srFromBeginning]) then
      lblDescOrigine20.Caption:=selQ265.FieldByName('DESCRIZIONE').AsString
    else
      lblDescOrigine20.Caption:='';

      
    if selQ265.SearchRecord('CODICE',VarArrayOf([edtCodDest1.Text]),[srFromBeginning]) then
      lblDescDest1.Caption:=selQ265.FieldByName('DESCRIZIONE').AsString
    else
      lblDescDest1.Caption:='';
    if selQ265.SearchRecord('CODICE',VarArrayOf([edtCodDest2.Text]),[srFromBeginning]) then
      lblDescDest2.Caption:=selQ265.FieldByName('DESCRIZIONE').AsString
    else
      lblDescDest2.Caption:='';
    if selQ265.SearchRecord('CODICE',VarArrayOf([edtCodDest3.Text]),[srFromBeginning]) then
      lblDescDest3.Caption:=selQ265.FieldByName('DESCRIZIONE').AsString
    else
      lblDescDest3.Caption:='';
    if selQ265.SearchRecord('CODICE',VarArrayOf([edtCodDest4.Text]),[srFromBeginning]) then
      lblDescDest4.Caption:=selQ265.FieldByName('DESCRIZIONE').AsString
    else
      lblDescDest4.Caption:='';
    if selQ265.SearchRecord('CODICE',VarArrayOf([edtCodDest5.Text]),[srFromBeginning]) then
      lblDescDest5.Caption:=selQ265.FieldByName('DESCRIZIONE').AsString
    else
      lblDescDest5.Caption:='';
    if selQ265.SearchRecord('CODICE',VarArrayOf([edtCodDest6.Text]),[srFromBeginning]) then
      lblDescDest6.Caption:=selQ265.FieldByName('DESCRIZIONE').AsString
    else
      lblDescDest6.Caption:='';
    if selQ265.SearchRecord('CODICE',VarArrayOf([edtCodDest7.Text]),[srFromBeginning]) then
      lblDescDest7.Caption:=selQ265.FieldByName('DESCRIZIONE').AsString
    else
      lblDescDest7.Caption:='';
    if selQ265.SearchRecord('CODICE',VarArrayOf([edtCodDest8.Text]),[srFromBeginning]) then
      lblDescDest8.Caption:=selQ265.FieldByName('DESCRIZIONE').AsString
    else
      lblDescDest8.Caption:='';
    if selQ265.SearchRecord('CODICE',VarArrayOf([edtCodDest9.Text]),[srFromBeginning]) then
      lblDescDest9.Caption:=selQ265.FieldByName('DESCRIZIONE').AsString
    else
      lblDescDest9.Caption:='';
    if selQ265.SearchRecord('CODICE',VarArrayOf([edtCodDest10.Text]),[srFromBeginning]) then
      lblDescDest10.Caption:=selQ265.FieldByName('DESCRIZIONE').AsString
    else
      lblDescDest10.Caption:='';
    if selQ265.SearchRecord('CODICE',VarArrayOf([edtCodDest11.Text]),[srFromBeginning]) then
      lblDescDest11.Caption:=selQ265.FieldByName('DESCRIZIONE').AsString
    else
      lblDescDest11.Caption:='';
    if selQ265.SearchRecord('CODICE',VarArrayOf([edtCodDest12.Text]),[srFromBeginning]) then
      lblDescDest12.Caption:=selQ265.FieldByName('DESCRIZIONE').AsString
    else
      lblDescDest12.Caption:='';
    if selQ265.SearchRecord('CODICE',VarArrayOf([edtCodDest13.Text]),[srFromBeginning]) then
      lblDescDest13.Caption:=selQ265.FieldByName('DESCRIZIONE').AsString
    else
      lblDescDest13.Caption:='';
    if selQ265.SearchRecord('CODICE',VarArrayOf([edtCodDest14.Text]),[srFromBeginning]) then
      lblDescDest14.Caption:=selQ265.FieldByName('DESCRIZIONE').AsString
    else
      lblDescDest14.Caption:='';
    if selQ265.SearchRecord('CODICE',VarArrayOf([edtCodDest15.Text]),[srFromBeginning]) then
      lblDescDest15.Caption:=selQ265.FieldByName('DESCRIZIONE').AsString
    else
      lblDescDest15.Caption:='';
    if selQ265.SearchRecord('CODICE',VarArrayOf([edtCodDest16.Text]),[srFromBeginning]) then
      lblDescDest16.Caption:=selQ265.FieldByName('DESCRIZIONE').AsString
    else
      lblDescDest16.Caption:='';
    if selQ265.SearchRecord('CODICE',VarArrayOf([edtCodDest17.Text]),[srFromBeginning]) then
      lblDescDest17.Caption:=selQ265.FieldByName('DESCRIZIONE').AsString
    else
      lblDescDest17.Caption:='';
    if selQ265.SearchRecord('CODICE',VarArrayOf([edtCodDest18.Text]),[srFromBeginning]) then
      lblDescDest18.Caption:=selQ265.FieldByName('DESCRIZIONE').AsString
    else
      lblDescDest18.Caption:='';
    if selQ265.SearchRecord('CODICE',VarArrayOf([edtCodDest19.Text]),[srFromBeginning]) then
      lblDescDest19.Caption:=selQ265.FieldByName('DESCRIZIONE').AsString
    else
      lblDescDest19.Caption:='';
    if selQ265.SearchRecord('CODICE',VarArrayOf([edtCodDest20.Text]),[srFromBeginning]) then
      lblDescDest20.Caption:=selQ265.FieldByName('DESCRIZIONE').AsString
    else
      lblDescDest20.Caption:='';
  end;
end;

procedure TB018FArticolo71.btnLogClick(Sender: TObject);
begin
  try
    OpenC012VisualizzaTesto('<B018> Ricodifica malattia Art.71 D.L.112/08',FileLog,nil);
  except
    raise Exception.Create('Impossibile visualizzare il file. File inesistente.');
  end;
end;

procedure TB018FArticolo71.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    if R180MessageBox('Si desidera interrompere l''operazione?','DOMANDA') = mrYes then
      InterrompiElaborazione:=True;
  end;
end;

procedure TB018FArticolo71.FormDestroy(Sender: TObject);
begin
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TB018FArticolo71.BtnEseguiClick(Sender: TObject);
var
  sLog: String;
  procedure ControlloDipendenti;
  // aggiornamento C700Selanagrafe
  //e controllo che ci sia almeno un dipendente selezionato
  begin
    if frmSelAnagrafe.SettaPeriodoSelAnagrafe(DallaData,AllaData) then
      C700SelAnagrafe.Close;
    C700SelAnagrafe.Open;
    if C700SelAnagrafe.RecordCount = 0 then
      raise exception.Create('Nessun dipendente selezionato');
  end;
begin
  ProgressBar.Position:=0;
  StatusBar.Panels[1].Text:='';
  ProgressBar.Max:=C700SelAnagrafe.RecordCount;
  if DallaData > AllaData then
  begin
    R180MessageBox('Periodo errato: data fine inferiore alla data inizio! Correggere! ','ERRORE');
    exit;
  end;
  //Cancello il file di log delle operazioni
  if FileExists(FileLog) then
    if not(DeleteFile(FileLog)) then
      raise exception.create('Impossibile registrare log delle operazioni sul file ''' + FileLog + '''.' + chr(13) + 'Verificare che il file non sia in uso.');
  //Registra Log delle operazioni effettuate su file
  //Intestazione riga su file
  sLog:='Progressivo; Matricola; Cognome                       ; Nome                          ; Cuas.origine ; Caus.dest. ; Data      ;';
  R180AppendFile(FileLog,sLog);
  RicodificaGiustificativi;
  R180MessageBox('Operazione terminata.','INFORMA');
  ProgressBar.Position:=0;
end;

procedure TB018FArticolo71.RicodificaGiustificativi;
  var
    dDataElab: TDateTime;
    i: Integer;
    sCodOrigine, sCausPeriodi, sLog: String;
begin
  //Richiesta conferma ricodifica
  if R180MessageBox('Confermi la ricodifica dei giustificativi indicati per il periodo dal ' +
     FormatDateTime('dd/mm/yyyy',DallaData) + ' al ' + FormatDateTime('dd/mm/yyyy',AllaData) +
     ' per numero  ' + IntToStr(C700SelAnagrafe.RecordCount) + '  dipendenti selezionati?','DOMANDA') <> mrYes then
    Exit;
  //Carica codici originali da modificare
  CodOrigine[1]:=edtCodOrigine1.Text;
  CodOrigine[2]:=edtCodOrigine2.Text;
  CodOrigine[3]:=edtCodOrigine3.Text;
  CodOrigine[4]:=edtCodOrigine4.Text;
  CodOrigine[5]:=edtCodOrigine5.Text;
  CodOrigine[6]:=edtCodOrigine6.Text;
  CodOrigine[7]:=edtCodOrigine7.Text;
  CodOrigine[8]:=edtCodOrigine8.Text;
  CodOrigine[9]:=edtCodOrigine9.Text;
  CodOrigine[10]:=edtCodOrigine10.Text;
  CodOrigine[11]:=edtCodOrigine11.Text;
  CodOrigine[12]:=edtCodOrigine12.Text;
  CodOrigine[13]:=edtCodOrigine13.Text;
  CodOrigine[14]:=edtCodOrigine14.Text;
  CodOrigine[15]:=edtCodOrigine15.Text;
  CodOrigine[16]:=edtCodOrigine16.Text;
  CodOrigine[17]:=edtCodOrigine17.Text;
  CodOrigine[18]:=edtCodOrigine18.Text;
  CodOrigine[19]:=edtCodOrigine19.Text;
  CodOrigine[20]:=edtCodOrigine20.Text;
  //Carica codici destinazione
  CodDest[1]:=edtCodDest1.Text;
  CodDest[2]:=edtCodDest2.Text;
  CodDest[3]:=edtCodDest3.Text;
  CodDest[4]:=edtCodDest4.Text;
  CodDest[5]:=edtCodDest5.Text;
  CodDest[6]:=edtCodDest6.Text;
  CodDest[7]:=edtCodDest7.Text;
  CodDest[8]:=edtCodDest8.Text;
  CodDest[9]:=edtCodDest9.Text;
  CodDest[10]:=edtCodDest10.Text;
  CodDest[11]:=edtCodDest11.Text;
  CodDest[12]:=edtCodDest12.Text;
  CodDest[13]:=edtCodDest13.Text;
  CodDest[14]:=edtCodDest14.Text;
  CodDest[15]:=edtCodDest15.Text;
  CodDest[16]:=edtCodDest16.Text;
  CodDest[17]:=edtCodDest17.Text;
  CodDest[18]:=edtCodDest18.Text;
  CodDest[19]:=edtCodDest19.Text;
  CodDest[20]:=edtCodDest20.Text;

  sCodOrigine:='';
  sCausPeriodi:='';
  for i:=1 to 20 do
  begin
    //Imposto codici origine da sostituire con malattia primi 10 giorni
    if (CodOrigine[i] <> '') and (CodDest[i] <> '') then
    begin
      if sCodOrigine = '' then
        sCodOrigine:='''' + CodOrigine[i] + ''''
      else
        sCodOrigine:=sCodOrigine + ',''' + CodOrigine[i] + '''';
    end;
    //Imposto codici per determinare periodo consecutivo di 10 giorni
    if CodOrigine[i] <> '' then
    begin
      if sCausPeriodi = '' then
        sCausPeriodi:='''' + CodOrigine[i] + ''''
      else
        sCausPeriodi:=sCausPeriodi + ',''' + CodOrigine[i] + '''';
    end;
    if CodDest[i] <> '' then
    begin
      if sCausPeriodi = '' then
        sCausPeriodi:='''' + CodDest[i] + ''''
      else
        sCausPeriodi:=sCausPeriodi + ',''' + CodDest[i] + '''';
    end;
  end;
  if (sCodOrigine = '') or (sCausPeriodi = '') then
  begin
    R180MessageBox('Nessun codice da sostituire. Operazione senza esito.','ERRORE');
    exit;
  end;
  with B018FArticolo71DtM1 do
  begin
    C700SelAnagrafe.First;
    while not C700SelAnagrafe.Eof do
    begin
      Application.ProcessMessages;
      frmSelAnagrafe.VisualizzaDipendente;
      dDataElab:=DallaData;
      while dDataElab <= AllaData do
      begin
        selT040.SetVariable('Progressivo',C700Progressivo);
        selT040.SetVariable('DataElaborazione',dDataElab);
        selT040.SetVariable('CodOrigine',sCodOrigine);
        selT040.SetVariable('CausPeriodi',sCausPeriodi);
        selT040.Close;
        selT040.Open;
        if not selT040.Eof then
        begin
          for i:=1 to 20 do
          begin
            //Imposto codici origine da sostituire con malattia primi 10 giorni
            if (selT040.FieldByName('CAUSALE').AsString = CodOrigine[i]) and (CodDest[i] <> '') then
            begin
              selT040.Edit;
              selT040.FieldByName('CAUSALE').AsString:=CodDest[i];
              selT040.Post;
              //Cancellazione Periodi Assenza con vecchio codice
              PeriodiAssenza.SetVariable('OPER','C' );
              PeriodiAssenza.SetVariable('CAUS',CodOrigine[i]);
              PeriodiAssenza.SetVariable('PROG',C700Progressivo);
              PeriodiAssenza.SetVariable('INIZIO',dDataElab);
              PeriodiAssenza.SetVariable('FINE',dDataElab);
              PeriodiAssenza.SetVariable('TG',selT040.FieldByName('TIPOGIUST').AsString);
              PeriodiAssenza.SetVariable('DALLE','');
              PeriodiAssenza.SetVariable('ALLE','');
              PeriodiAssenza.Execute;
              //Inserimento Periodi Assenza con nuovo codice
              PeriodiAssenza.SetVariable('OPER','I' );
              PeriodiAssenza.SetVariable('CAUS',CodDest[i]);
              PeriodiAssenza.Execute;
              //Scrittura Log su file
              sLog:=Format('%-11.11s',[IntToStr(C700Progressivo)]) +'; ';
              sLog:=sLog + Format('%-9.9s',[C700SelAnagrafe.FieldByName('Matricola').AsString]) +'; ';
              sLog:=sLog + Format('%-30.30s',[C700SelAnagrafe.FieldByName('Cognome').AsString]) +'; ';
              sLog:=sLog + Format('%-30.30s',[C700SelAnagrafe.FieldByName('Nome').AsString]) +'; ';
              sLog:=sLog + Format('%-13.13s',[CodOrigine[i]]) +'; ';
              sLog:=sLog + Format('%-11.11s',[CodDest[i]]) +'; ';
              sLog:=sLog + Format('%-10.10s',[DateToStr(dDataElab)]) +'; ';
              R180AppendFile(FileLog,sLog);
              btnLog.Enabled:=True;
            end;
          end;
        end;
        dDataElab:=dDataElab + 1;
      end;
      ProgressBar.StepBy(1);
      C700SelAnagrafe.Next;
    end;
  end;
end;

procedure TB018FArticolo71.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  C700DataDal:=DallaData;
  C700DataLavoro:=AllaData;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TB018FArticolo71.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  C005DataVisualizzazione:=AllaData;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TB018FArticolo71.dcmbKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

end.

