unit WA128UPianPrestazioniAggiuntiveDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR302UGestTabellaDM, DB, OracleData, medpIWMessageDlg,
  A000UInterfaccia, A128UPianPrestazioniAggiuntiveMW;

type
  TWA128FPianPrestazioniAggiuntiveDM = class(TWR302FGestTabellaDM)
    selTabellaPROGRESSIVO: TFloatField;
    selTabellaDATA: TDateTimeField;
    selTabellaTURNO1: TStringField;
    selTabellaTURNO2: TStringField;
    selTabellaMATRICOLA: TStringField;
    selTabellaNOMINATIVO: TStringField;
    selTabellaORAINIZIO_TURNO1: TStringField;
    selTabellaORAFINE_TURNO1: TStringField;
    selTabellaORAINIZIO_TURNO2: TStringField;
    selTabellaORAFINE_TURNO2: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure AfterPost(DataSet: TDataSet); override;
    procedure BeforeInsert(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure selTabellaDATAValidate(Sender: TField);
    procedure selTabellaTURNOSetText(Sender: TField; const Text: string);
    procedure selTabellaTURNOValidate(Sender: TField);
    procedure selTabellaORAChange(Sender: TField);
    procedure selTabellaORASetText(Sender: TField; const Text: string);
    procedure selTabellaORAValidate(Sender: TField);
    procedure selTabellaTURNOChange(Sender: TField);
  private
    procedure evtRichiesta(Msg,Chiave:String);
    procedure ResultEvtRichiesta(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure evtClearKeys;
  public
    A128MW: TA128FPianPrestazioniAggiuntiveMW;
  end;

implementation

uses WA128UPianPrestazioniAggiuntive;

{$R *.dfm}

procedure TWA128FPianPrestazioniAggiuntiveDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY T332.DATA,T030.COGNOME,T030.NOME,MATRICOLA');
  A128MW:=TA128FPianPrestazioniAggiuntiveMW.Create(Self);
  A128MW.selT332:=SelTabella;
  A128MW.evtRichiesta:=evtRichiesta;
  A128MW.evtClearKeys:=evtClearKeys;
  inherited;
end;

procedure TWA128FPianPrestazioniAggiuntiveDM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  A128MW.AfterPost;
  (Self.Owner as TWA128FPianPrestazioniAggiuntive).AbilitaComponenti(True);
  (Self.Owner as TWA128FPianPrestazioniAggiuntive).WBrowseFM.grdTabella.medpAggiornaCDS(True);
end;

procedure TWA128FPianPrestazioniAggiuntiveDM.BeforeInsert(DataSet: TDataSet);
begin
  A128MW.BeforeInsert;
  inherited;
end;

procedure TWA128FPianPrestazioniAggiuntiveDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  A128MW.BeforePost;
  A128MW.PulisciVariabili;
  inherited;
end;

procedure TWA128FPianPrestazioniAggiuntiveDM.OnNewRecord(DataSet: TDataSet);
begin
  A128MW.NewRecord;
  inherited;
end;

procedure TWA128FPianPrestazioniAggiuntiveDM.selTabellaDATAValidate(Sender: TField);
begin
  A128MW.ValidaData;
end;

procedure TWA128FPianPrestazioniAggiuntiveDM.selTabellaORAChange(Sender: TField);
begin
  A128MW.AzzeraTurni(Sender);
end;

procedure TWA128FPianPrestazioniAggiuntiveDM.selTabellaORAValidate(Sender: TField);
begin
  A128MW.ValidaOrario(Sender);
end;

procedure TWA128FPianPrestazioniAggiuntiveDM.selTabellaORASetText(Sender: TField; const Text: string);
begin
  A128MW.ImpostaTesto(Sender,Text);
end;

procedure TWA128FPianPrestazioniAggiuntiveDM.selTabellaTURNOChange(Sender: TField);
begin
  A128MW.AzzeraOrario(Sender);
end;

procedure TWA128FPianPrestazioniAggiuntiveDM.selTabellaTURNOSetText(Sender: TField; const Text: string);
begin
  A128MW.ImpostaTesto(Sender,Text);
end;

procedure TWA128FPianPrestazioniAggiuntiveDM.selTabellaTURNOValidate(Sender: TField);
begin
  A128MW.ValidaTurno(Sender);
end;

procedure TWA128FPianPrestazioniAggiuntiveDM.evtRichiesta(Msg,Chiave:String);
begin
  if not MsgBox.KeyExists(Chiave) then
  begin
    MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultEvtRichiesta,Chiave);
    Abort;
  end;
end;

procedure TWA128FPianPrestazioniAggiuntiveDM.ResultEvtRichiesta(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
    case A128MW.ProceduraChiamante of
      0: SelTabella.Post;
      1: A128MW.InserisciGestioneMensile;
      2: A128MW.CancellaGestioneMensile;
    end
  else
  begin
    A128MW.PulisciVariabili;
    (Self.Owner as TWA128FPianPrestazioniAggiuntive).AbilitaComponenti(True);
    (Self.Owner as TWA128FPianPrestazioniAggiuntive).WBrowseFM.grdTabella.medpAggiornaCDS(True);
  end;
end;

procedure TWA128FPianPrestazioniAggiuntiveDM.evtClearKeys;
begin
  MsgBox.ClearKeys;
end;

end.
