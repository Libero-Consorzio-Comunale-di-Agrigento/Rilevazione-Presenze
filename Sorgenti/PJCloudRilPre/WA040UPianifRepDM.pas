unit WA040UPianifRepDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR302UGestTabellaDM, DB, OracleData, medpIWMessageDlg, StrUtils,
  A000UInterfaccia, A000UMessaggi, A040UPianifRepMW, Oracle;

type
  TWA040FPianifRepDM = class(TWR302FGestTabellaDM)
    selTabellaPROGRESSIVO: TFloatField;
    selTabellaDATA: TDateTimeField;
    selTabellaTURNO1: TStringField;
    selTabellaPRIORITA1: TIntegerField;
    selTabellaTURNO2: TStringField;
    selTabellaPRIORITA2: TIntegerField;
    selTabellaTURNO3: TStringField;
    selTabellaPRIORITA3: TIntegerField;
    selTabellaDATOLIBERO: TStringField;
    selTabellaTIPOLOGIA: TStringField;
    selTabellaMATRICOLA: TStringField;
    selTabellaNOMINATIVO: TStringField;
    selTabellaRECAPITO1: TStringField;
    selTabellaRECAPITO2: TStringField;
    selTabellaRECAPITO3: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure AfterPost(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure BeforeInsert(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure selTabellaDATAValidate(Sender: TField);
    procedure TURNOSetText(Sender: TField; const Text: String);
    procedure TURNOValidate(Sender: TField);
    procedure selTabellaDATOLIBEROSetText(Sender: TField; const Text: string);
    procedure selTabellaDATOLIBEROValidate(Sender: TField);
  private
    { Private declarations }
    procedure evtMessaggio(Msg:String);
    procedure evtRichiesta(Msg,Chiave:String);
    procedure ResultEvtRichiesta(Sender: TObject; R: TmeIWModalResult; KI: String);
    (*procedure evtTurniIntersecati(Msg,Chiave:String);
    procedure ResultEvtTurniIntersecati(Sender: TObject; R: TmeIWModalResult; KI: String);*)
    procedure evtRichiestaRefresh(Msg,Chiave:String);
    procedure ResultEvtRichiestaRefresh(Sender: TObject; R: TmeIWModalResult; KI: String);
    function evtGiornataAssenza(Msg:String):Boolean;
    procedure ResultEvtGiornataAssenza(Sender: TObject; R: TmeIWModalResult; KI: String);
    function evtTurnoNonInserito(Msg:String):Boolean;
    procedure ResultEvtTurnoNonInserito(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure evtRaggrAbilitati(Msg,Chiave:String);
    procedure ResultEvtRaggrAbilitati(Sender: TObject; R: TmeIWModalResult; KI: String);
    function evtKeyCtrl(Chiave:String):Boolean;
    procedure evtClearKeys;
    procedure evtMergeSelAnagrafe(ODS:TOracleDataSet);
  public
    A040MW: TA040FPianifRepMW;
  end;

implementation

uses WA040UPianifRep, WA040UPianifRepBrowseFM;

{$R *.dfm}

procedure TWA040FPianifRepDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY T380.DATA,T030.COGNOME,T030.NOME,MATRICOLA');
  A040MW:=TA040FPianifRepMW.Create(Self);
  A040MW.selT380:=SelTabella;
  A040MW.evtMessaggio:=evtMessaggio;
  A040MW.evtRichiesta:=evtRichiesta;
  (*A040MW.evtTurniIntersecati:=evtTurniIntersecati;*)
  A040MW.evtRichiestaRefresh:=evtRichiestaRefresh;
  A040MW.evtGiornataAssenza:=evtGiornataAssenza;
  A040MW.evtTurnoNonInserito:=evtTurnoNonInserito;
  A040MW.evtRaggrAbilitati:=evtRaggrAbilitati;
  A040MW.evtKeyCtrl:=evtKeyCtrl;
  A040MW.evtClearKeys:=evtClearKeys;
  A040MW.evtMergeSelAnagrafe:=evtMergeSelAnagrafe;
  inherited;
end;

procedure TWA040FPianifRepDM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  A040MW.AfterPost;
  (Self.Owner as TWA040FPianifRep).AbilitaComponenti(True);
  (Self.Owner as TWA040FPianifRep).WBrowseFM.grdTabella.medpAggiornaCDS(True);
end;

procedure TWA040FPianifRepDM.BeforeDelete(DataSet: TDataSet);
begin
  A040MW.BeforeDelete;
  inherited;
end;

procedure TWA040FPianifRepDM.BeforeInsert(DataSet: TDataSet);
begin
  A040MW.BeforeInsert;
  inherited;
end;

procedure TWA040FPianifRepDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  A040MW.NonContDipPian:=(Self.Owner as TWA040FPianifRep).chkNonContDipPian.Checked;
  A040MW.BeforePost;
  A040MW.PulisciVariabili;
  inherited;
end;

procedure TWA040FPianifRepDM.OnNewRecord(DataSet: TDataSet);
begin
  with (Self.Owner as TWA040FPianifRep) do
    A040MW.NewRecord(EncodeDate(StrToIntDef(edtAnno.Text,0),StrToIntDef(edtMese.Text,0),1));
  inherited;
end;

procedure TWA040FPianifRepDM.selTabellaDATAValidate(Sender: TField);
begin
  A040MW.selT380ValidaData;
end;

procedure TWA040FPianifRepDM.selTabellaDATOLIBEROSetText(Sender: TField; const Text: string);
begin
  A040MW.selT380ImpostaTesto(Sender,Text,20);
end;

procedure TWA040FPianifRepDM.selTabellaDATOLIBEROValidate(Sender: TField);
begin
  A040MW.selT380ValidaDatoLibero;
end;

procedure TWA040FPianifRepDM.TURNOSetText(Sender:TField;const Text:String);
begin
  A040MW.selT380ImpostaTesto(Sender,Text,5);
end;

procedure TWA040FPianifRepDM.TURNOValidate(Sender:TField);
begin
  A040MW.selT380ValidaTurno(Sender);
end;

procedure TWA040FPianifRepDM.evtMessaggio(Msg:String);
begin
  MsgBox.WebMessageDlg(Msg,mtInformation,[mbYes],nil,'');
end;

procedure TWA040FPianifRepDM.evtRichiesta(Msg,Chiave:String);
begin
  if not MsgBox.KeyExists(Chiave) then
  begin
    MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultEvtRichiesta,Chiave);
    Abort;
  end;
end;

procedure TWA040FPianifRepDM.ResultEvtRichiesta(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
    case A040MW.ProceduraChiamante of
      0: SelTabella.Post;
      1: A040MW.InserisciGestioneMensile;
      2: A040MW.CancellaGestioneMensile;
      3: (Self.Owner as TWA040FPianifRep).EseguiStampa;
    end
  else
  begin
    A040MW.PulisciVariabili;
    (Self.Owner as TWA040FPianifRep).AbilitaComponenti(True);
    (Self.Owner as TWA040FPianifRep).WBrowseFM.grdTabella.medpAggiornaCDS(True);
  end;
end;

(*procedure TWA040FPianifRepDM.evtTurniIntersecati(Msg,Chiave:String);
begin
  A040MW.BloccaFlusso:=Chiave;
  if not MsgBox.KeyExists(Chiave) then
  begin
    MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultEvtTurniIntersecati,Chiave);
    Abort;
  end;
end;

procedure TWA040FPianifRepDM.ResultEvtTurniIntersecati(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
    A040MW.BloccaFlusso:='';
  case A040MW.ProceduraChiamante of
    0: SelTabella.Post;
    1: A040MW.InserisciGestioneMensile;
    2: A040MW.CancellaGestioneMensile;
  end
end;*)

procedure TWA040FPianifRepDM.evtRichiestaRefresh(Msg,Chiave:String);
begin
  if not MsgBox.KeyExists(Chiave) then
  begin
    MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultEvtRichiestaRefresh,Chiave);
    Abort;
  end;
end;

procedure TWA040FPianifRepDM.ResultEvtRichiestaRefresh(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
    case A040MW.ProceduraChiamante of
      0: SelTabella.Post;
      1: A040MW.InserisciGestioneMensile;
      2: A040MW.CancellaGestioneMensile;
    end
  else
  begin
    A040MW.PulisciVariabili;
    A040MW.RefreshT380;
    (Self.Owner as TWA040FPianifRep).AbilitaComponenti(True);
    (Self.Owner as TWA040FPianifRep).WBrowseFM.grdTabella.medpAggiornaCDS(True);
  end;
end;

function TWA040FPianifRepDM.evtGiornataAssenza(Msg:String):Boolean;
begin
  MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultEvtGiornataAssenza,'');
  Abort;
end;

procedure TWA040FPianifRepDM.ResultEvtGiornataAssenza(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  A040MW.sGiornataAssenza:=IfThen(R = mrYes,'S','N');
  case A040MW.ProceduraChiamante of
    0: SelTabella.Post;
    1: A040MW.InserisciGestioneMensile;
    2: A040MW.CancellaGestioneMensile;
  end
end;

function TWA040FPianifRepDM.evtTurnoNonInserito(Msg:String):Boolean;
begin
  MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultEvtTurnoNonInserito,'');
  Abort;
end;

procedure TWA040FPianifRepDM.ResultEvtTurnoNonInserito(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  A040MW.sTurnoNonInserito:=IfThen(R = mrYes,'S','N');
  case A040MW.ProceduraChiamante of
    0: SelTabella.Post;
    1: A040MW.InserisciGestioneMensile;
    2: A040MW.CancellaGestioneMensile;
  end
end;

procedure TWA040FPianifRepDM.evtRaggrAbilitati(Msg,Chiave:String);
begin
  if not MsgBox.KeyExists(Chiave) then
  begin
    MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultEvtRaggrAbilitati,Chiave);
    Abort;
  end;
end;

procedure TWA040FPianifRepDM.ResultEvtRaggrAbilitati(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
    case A040MW.ProceduraChiamante of
      0: SelTabella.Post;
      1: A040MW.InserisciGestioneMensile;
      2: A040MW.CancellaGestioneMensile;
    end
  else
  begin
    A040MW.PulisciVariabili;
    raise exception.Create(A000MSG_MSG_ELABORAZIONE_INTERROTTA);
  end;
end;

function TWA040FPianifRepDM.evtKeyCtrl(Chiave:String):Boolean;
begin
  Result:=MsgBox.KeyExists(Chiave);
end;

procedure TWA040FPianifRepDM.evtClearKeys;
begin
  MsgBox.ClearKeys;
end;

procedure TWA040FPianifRepDM.evtMergeSelAnagrafe(ODS:TOracleDataSet);
begin
  (Self.Owner as TWA040FPianifRep).grdC700.WC700FM.C700MergeSelAnagrafe(ODS);
  (Self.Owner as TWA040FPianifRep).grdC700.WC700FM.C700MergeSettaPeriodo(ODS,Parametri.DataLavoro,Parametri.DataLavoro);
end;

end.
