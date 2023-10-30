unit WA124UPermessiSindacaliDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData,
  A124UPermessiSindacaliMW, medpIWMessageDlg, A000UInterfaccia, StrUtils;

type
  TWA124FPermessiSindacaliDM = class(TWR302FGestTabellaDM)
    selTabellaPROGRESSIVO: TIntegerField;
    selTabellaTIPO_PERMESSO: TStringField;
    selTabellaDATA: TDateTimeField;
    selTabellaNUMERO_PROT: TStringField;
    selTabellaDATA_PROT: TDateTimeField;
    selTabellaDALLE: TStringField;
    selTabellaALLE: TStringField;
    selTabellaORE: TStringField;
    selTabellaABBATTE_COMPETENZE: TStringField;
    selTabellaCOD_SINDACATO: TStringField;
    selTabellaCOD_ORGANISMO: TStringField;
    selTabellaSTATO: TStringField;
    selTabellaPROT_MODIFICA: TStringField;
    selTabellaDATA_MODIFICA: TDateTimeField;
    selTabellaPROG_PERMESSO: TFloatField;
    selTabellaDATA_DA: TDateTimeField;
    selTabellaABBATTE_COMPETENZE_ORG: TStringField;
    selTabellaD_SINDACATO: TStringField;
    selTabellaCOD_MINISTERIALE: TStringField;
    selTabellaD_ORGANISMO: TStringField;
    selTabellaINSERITO_GEDAP: TStringField;
    selTabellaRSU: TStringField;
    selTabellaRAGGRUPPAMENTO: TStringField;
    selTabellaRETRIBUITO: TStringField;
    selTabellaSTATUTARIO: TStringField;
    selTabellaSIGLA_GEDAP: TStringField;
    selTabellaD_ABBATTE_COMPETENZE_ORG: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure selTabellaDALLEValidate(Sender: TField);
    procedure AfterScroll(DataSet: TDataSet);override;
    procedure BeforeDelete(DataSet: TDataSet);override;
    procedure BeforePostNoStorico(DataSet: TDataSet);override;
    procedure AfterPost(DataSet: TDataSet);override;
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure selTabellaCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    procedure evtRichiesta(Msg,Chiave:String);
    procedure ResultEvtRichiesta(Sender: TObject; R: TmeIWModalResult; KI: String);
  public
    A124MW: TA124FPermessiSindacaliMW;
  end;

implementation

{$R *.dfm}

uses WA124UPermessiSindacali, WA124UPermessiSindacaliDettFM;

procedure TWA124FPermessiSindacaliDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','order by data desc, data_da desc, cod_sindacato, cod_organismo');
  NonAprireSelTabella:=True;
  selTabella.FieldByName('INSERITO_GEDAP').Visible:=Parametri.CampiRiferimento.C40_InvioGedap = 'S';
  inherited;
  A124MW:=TA124FPermessiSindacaliMW.Create(Self);
  A124MW.A004MW.Chiamante:='WA124';
  A124MW.selT248:=selTabella;
  (*A124MW.selT248Canc.AfterDelete:=selTabella.AfterDelete;
  A124MW.selT248Canc.AfterPost:=selTabella.AfterPost;
  A124MW.selT248Canc.AfterScroll:=selTabella.AfterScroll;
  A124MW.selT248Canc.BeforeDelete:=selTabella.BeforeDelete;
  A124MW.selT248Canc.BeforePost:=selTabella.BeforePost;
  A124MW.selT248Canc.OnNewRecord:=selTabella.OnNewRecord;*)
  A124MW.evtRichiesta:=evtRichiesta;
  selTabella.Open;
  A124MW.DataSetInUso:=A124MW.selT248;
end;

procedure TWA124FPermessiSindacaliDM.AfterScroll(DataSet: TDataSet);
begin
  inherited;
  A124MW.selT248AfterScroll;
  if (Self.Owner as TWA124FPermessiSindacali).WDettaglioFM <> nil then
    ((Self.Owner as TWA124FPermessiSindacali).WDettaglioFM as TWA124FPermessiSindacaliDettFM).AbilitaComponenti;
end;

procedure TWA124FPermessiSindacaliDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  A124MW.selT248BeforeDelete(DataSet);
  if (Self.Owner as TWA124FPermessiSindacali).WDettaglioFM <> nil then
    ((Self.Owner as TWA124FPermessiSindacali).WDettaglioFM as TWA124FPermessiSindacaliDettFM).AbilitaComponenti;
end;

procedure TWA124FPermessiSindacaliDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  if not MsgBox.KeyExists('EsistePermesso') then
    if DataSet.State = dsInsert then
      A124MW.ControlloProgInterno;
  MsgBox.ClearKeys;
  if (DataSet.State = dsInsert) and (Parametri.CampiRiferimento.C40_InvioGedap = 'S') then
    A124MW.ControlliGeneraXmlGEDAP;
  if A124MW.Azione <> 'C' then
    inherited;
  A124MW.selT248BeforePostNoStorico(DataSet);
end;

procedure TWA124FPermessiSindacaliDM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  RegistraMsg.IniziaMessaggio((Self.Owner as TWA124FPermessiSindacali).medpCodiceForm);
  A124MW.selT248AfterPost(DataSet);
  if (Self.Owner as TWA124FPermessiSindacali).WDettaglioFM <> nil then
    ((Self.Owner as TWA124FPermessiSindacali).WDettaglioFM as TWA124FPermessiSindacaliDettFM).AbilitaComponenti;
end;

procedure TWA124FPermessiSindacaliDM.OnNewRecord(DataSet: TDataSet);
begin
  A124MW.selT248NewRecord;
  inherited;
end;

procedure TWA124FPermessiSindacaliDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  inherited;
  A124MW.selT248CalcFields(DataSet);
  selTabella.FieldByName('D_ABBATTE_COMPETENZE_ORG').AsString:=IfThen(selTabella.FieldByName('ABBATTE_COMPETENZE_ORG').AsString = 'S','Si','No');
end;

procedure TWA124FPermessiSindacaliDM.selTabellaDALLEValidate(Sender: TField);
begin
  inherited;
  A124MW.validaOre(Sender);
end;

procedure TWA124FPermessiSindacaliDM.evtRichiesta(Msg,Chiave:String);
begin
  if not MsgBox.KeyExists(Chiave) then
  begin
    MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultEvtRichiesta,Chiave);
    Abort;
  end;
end;

procedure TWA124FPermessiSindacaliDM.ResultEvtRichiesta(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
    case A124MW.ProceduraChiamante of
      0: (Self.Owner as TWA124FPermessiSindacali).actConfermaExecute(nil);
      1: (Self.Owner as TWA124FPermessiSindacali).actEliminaExecute(nil);
    end
  else
    MsgBox.ClearKeys;
end;

end.
