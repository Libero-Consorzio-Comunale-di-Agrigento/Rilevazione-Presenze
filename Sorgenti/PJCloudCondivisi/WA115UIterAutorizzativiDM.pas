unit WA115UIterAutorizzativiDM;

interface

uses
  Data.DB,
  Datasnap.DBClient,
  OracleData,
  System.Classes,
  System.SysUtils,
  System.Variants,
  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.Forms,
  Vcl.Graphics,
  Winapi.Messages,
  Winapi.Windows,
  A000UCostanti,
  A000UInterfaccia,
  A000USessione,
  A115UIterAutorizzativiMW,
  C180FunzioniGenerali,
  RegistrazioneLog,
  WR302UGestTabellaDM,
  WR303UGestMasterDetailDM;

type
  TWA115FIterAutorizzativiDM = class(TWR303FGestMasterDetailDM)
    selI095: TOracleDataSet;
    selI095AZIENDA: TStringField;
    selI095ITER: TStringField;
    selI095COD_ITER: TStringField;
    selI095DESCRIZIONE: TStringField;
    selI095FILTRO_RICHIESTA: TStringField;
    selI095CONDIZ_AUTORIZZ_AUTOMATICA: TStringField;
    selI095MAX_LIV_AUTORIZZ_AUTOMATICA: TIntegerField;
    selI095FILTRO_INTERFACCIA: TStringField;
    selI095VALIDITA_ITER_AUT2: TFloatField;
    selI095VALIDITA_ITER_AUT: TStringField;
    selI095MAX_LIV_NOTE_MODIFICABILI: TIntegerField;
    selI095CONDIZIONE_ALLEGATI: TStringField;
    selI095ALLEGATI_MODIFICABILI: TStringField;
    dsrI095: TDataSource;
    dsrI096: TDataSource;
    selI096: TOracleDataSet;
    selI096AZIENDA: TStringField;
    selI096ITER: TStringField;
    selI096COD_ITER: TStringField;
    selI096LIVELLO: TIntegerField;
    selI096DESC_LIVELLO: TStringField;
    selI096FASE: TIntegerField;
    selI096OBBLIGATORIO: TStringField;
    selI096AVVISO: TStringField;
    selI096VALORI_POSSIBILI: TStringField;
    selI096AUTORIZZ_INTERMEDIA: TStringField;
    selI096DATI_MODIFICABILI: TStringField;
    selI096INVIO_EMAIL: TStringField;
    selI096CONDIZ_AUTORIZZ_AUTOMATICA: TStringField;
    selI096SCRIPT_AUTORIZZ: TStringField;
    selI096ALLEGATI_OBBLIGATORI: TStringField;
    selI096ALLEGATI_VISIBILI: TStringField;
    selTabellaAZIENDA: TStringField;
    selTabellaD_iter: TStringField;
    selTabellaITER: TStringField;
    selTabellaREVOCABILE: TStringField;
    selTabellaMAIL_OGGETTO_DIP: TStringField;
    selTabellaMAIL_CORPO_DIP: TStringField;
    selTabellaMAIL_OGGETTO_RESP: TStringField;
    selTabellaMAIL_CORPO_RESP: TStringField;
    selTabellaEXPR_PERIODO_VISUAL: TStringField;
    selTabellaCHKDATI_ITER_AUT: TFloatField;
    selTabellaC_CHKDATI_ITER_AUT: TStringField;
    selTabellaMSG_NOTIFICA: TStringField;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure BeforeInsert(DataSet: TDataSet);
    procedure AfterPost(DataSet: TDataSet); override;
    procedure selTabellaCalcFields(DataSet: TDataSet);
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure selI095AfterOpen(DataSet: TDataSet);
    procedure selI095AfterScroll(DataSet: TDataSet);
    procedure selI095BeforeDelete(DataSet: TDataSet);
    procedure selI095BeforeInsert(DataSet: TDataSet);
    procedure selI095BeforePost(DataSet: TDataSet);
    procedure selI095CalcFields(DataSet: TDataSet);
    procedure selI095NewRecord(DataSet: TDataSet);
    procedure selI095BeforeCancel(DataSet: TDataSet);
    procedure selI096BeforeDelete(DataSet: TDataSet);
    procedure selI096BeforeInsert(DataSet: TDataSet);
    procedure selI096BeforePost(DataSet: TDataSet);
    procedure selI096NewRecord(DataSet: TDataSet);
    procedure selI095AfterPost(DataSet: TDataSet);
    procedure selI096AfterPost(DataSet: TDataSet);
    procedure selI095BeforeEdit(DataSet: TDataSet);
  private
  protected
    procedure RelazionaTabelleFiglie; override;
  public
    A115MW:TA115FIterAutorizzativiMW;
    procedure InizializzaDataModulo(Azienda:String);
  end;

implementation

{$R *.dfm}

uses
  WA115UIterAutorizzativiBrowseFM,
  WA115UIterAutorizzativi;

procedure TWA115FIterAutorizzativiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY ITER');
  NonAprireSelTabella:=True;

  InterfacciaWR102.NomeTabella:='MONDOEDP.I093_BASE_ITER_AUT';
  InterfacciaWR102.AliasNomeTabella:='I093';

  inherited;
end;

procedure TWA115FIterAutorizzativiDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  inherited;
  if A115MW <> nil then
    FreeAndNil(A115MW);
end;

procedure TWA115FIterAutorizzativiDM.InizializzaDataModulo(Azienda:String);
begin
  if Azienda = '' then
    Abort;

  if A115MW <> nil then
    FreeAndNil(A115MW);

  A115MW:=TA115FIterAutorizzativiMW.Create(Self);
  A115MW.selI093:=selTabella;
  A115MW.selI095:=selI095;
  A115MW.selI096:=selI096;

  A115MW.AziendaCorrente:=Azienda;
  A115MW.ModuloIterAutorizzativi:=A000ModuloAbilitato(SessioneOracle,'ITER_AUTORIZZATIVI',
                                                     A115MW.AziendaCorrente);

  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
  // visibilità colonne allegati
  begin
    selI095.FieldByName('CONDIZIONE_ALLEGATI').Visible:=A115MW.ModuloIterAutorizzativi;
    selI095.FieldByName('ALLEGATI_MODIFICABILI').Visible:=A115MW.ModuloIterAutorizzativi;
    selI096.FieldByName('ALLEGATI_OBBLIGATORI').Visible:=A115MW.ModuloIterAutorizzativi;
    selI096.FieldByName('ALLEGATI_VISIBILI').Visible:=A115MW.ModuloIterAutorizzativi;
  end;
  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine

  selTabella.OnApplyRecord:=A115MW.ApplyRecordRegistraLog;
  selI095.OnApplyRecord:=A115MW.ApplyRecordRegistraLog;
  selI096.OnApplyRecord:=A115MW.ApplyRecordRegistraLog;

  A115MW.AggiornaI093_I095_I096;
  A115MW.OpenSelI093;
end;

{ selI093 }

procedure TWA115FIterAutorizzativiDM.BeforeInsert(DataSet: TDataSet);
begin
  A115MW.selI093BeforeInsert;
end;

procedure TWA115FIterAutorizzativiDM.AfterPost(DataSet: TDataSet);
begin
  SessioneOracle.ApplyUpdates([A115MW.selI094],True);
  inherited;
end;

procedure TWA115FIterAutorizzativiDM.AfterScroll(DataSet: TDataSet);
begin
  A115MW.selI093AfterScroll;
  inherited;
end;

procedure TWA115FIterAutorizzativiDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  A115MW.selI093BeforeDelete;
  A115MW.selI094.CancelUpdates;
end;

procedure TWA115FIterAutorizzativiDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  A115MW.selI093BeforePost;
end;

{ selI095 }

procedure TWA115FIterAutorizzativiDM.selI095AfterOpen(DataSet: TDataSet);
begin
  A115MW.selI095AfterOpen;
end;

procedure TWA115FIterAutorizzativiDM.selI095AfterScroll(DataSet: TDataSet);
begin
  A115MW.selI095AfterScroll;
end;

procedure TWA115FIterAutorizzativiDM.selI095BeforeCancel(DataSet: TDataSet);
begin
  A115MW.selI097.CancelUpdates;
end;

procedure TWA115FIterAutorizzativiDM.selI095BeforeDelete(DataSet: TDataSet);
begin
  A115MW.selI095BeforeDelete;
end;

procedure TWA115FIterAutorizzativiDM.selI095BeforeEdit(DataSet: TDataSet);
begin
  A115MW.selI095.FieldByName('COD_ITER').ReadOnly:=True;
end;

procedure TWA115FIterAutorizzativiDM.selI095BeforeInsert(DataSet: TDataSet);
begin
  A115MW.selI095BeforeInsert;
  A115MW.selI095.FieldByName('COD_ITER').ReadOnly:=False;
end;

procedure TWA115FIterAutorizzativiDM.selI095AfterPost(DataSet: TDataSet);
begin
  SessioneOracle.ApplyUpdates([A115MW.selI097],True);
  A115MW.AggiornaI093_I095_I096;
  selI095AfterScroll(A115MW.selI095);
  A115MW.check_I095;
end;

procedure TWA115FIterAutorizzativiDM.selI095BeforePost(DataSet: TDataSet);
begin
  A115MW.selI095BeforePost;
end;

procedure TWA115FIterAutorizzativiDM.selI095CalcFields(DataSet: TDataSet);
begin
  A115MW.selI095CalcFields;
end;

procedure TWA115FIterAutorizzativiDM.selI095NewRecord(DataSet: TDataSet);
begin
  A115MW.selI095NewRecord;
end;

{ selI096 }

procedure TWA115FIterAutorizzativiDM.selI096AfterPost(DataSet: TDataSet);
begin
  A115MW.selI096AfterPost;
end;

procedure TWA115FIterAutorizzativiDM.selI096BeforeDelete(DataSet: TDataSet);
begin
  A115MW.selI096BeforeDelete;
end;

procedure TWA115FIterAutorizzativiDM.selI096BeforeInsert(DataSet: TDataSet);
begin
  A115MW.selI096BeforeInsert;
end;

procedure TWA115FIterAutorizzativiDM.selI096BeforePost(DataSet: TDataSet);
begin
  A115MW.selI096BeforePost;
end;

procedure TWA115FIterAutorizzativiDM.selI096NewRecord(DataSet: TDataSet);
begin
  A115MW.selI096NewRecord;
end;

procedure TWA115FIterAutorizzativiDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  inherited;
  A115MW.selI093CalcFields;
end;

{ Altro }

procedure TWA115FIterAutorizzativiDM.RelazionaTabelleFiglie;
begin
  // RelazionaTabelleFiglie
end;

end.
