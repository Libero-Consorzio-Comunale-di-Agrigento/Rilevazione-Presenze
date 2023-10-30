unit S030UProvvedimentiDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, C700USelezioneAnagrafe, Oracle,
  A000UCostanti, A000USessione,A000UInterfaccia, DBClient,
  C180FunzioniGenerali, S030UProvvedimentiMW;

type
  TS030FProvvedimentiDtM = class(TR004FGestStoricoDtM)
    selSG100: TOracleDataSet;
    selSG100PROGRESSIVO: TFloatField;
    selSG100NOMECAMPO: TStringField;
    selSG100DATADECOR: TDateTimeField;
    selSG100DATAREGISTR: TDateTimeField;
    selSG100CAUSALE: TStringField;
    selSG100AUTORITA: TStringField;
    selSG100TIPOATTO: TStringField;
    selSG100NUMATTO: TStringField;
    selSG100DATAATTO: TDateTimeField;
    selSG100DATAESEC: TDateTimeField;
    selSG100NOTE: TStringField;
    selSG100D_CAUSALI: TStringField;
    selSG100TIPO_PROVV: TStringField;
    selSG100DATAFINE: TDateTimeField;
    selSG100SEDE: TStringField;
    selSG100TESTOVAR: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selSG100AfterScroll(DataSet: TDataSet);
    procedure selSG100NewRecord(DataSet: TDataSet);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure AfterPost(DataSet: TDataSet); override;
    procedure selSG100DATAREGISTRGetText(Sender: TField; var Text: string; DisplayText: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    S030MW: TS030FProvvedimentiMW;
    procedure evtRichiesta(Msg,Chiave:String);
  end;

var
  S030FProvvedimentiDtM: TS030FProvvedimentiDtM;

implementation

uses S030UProvved;

{$R *.dfm}

procedure TS030FProvvedimentiDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selSG100,[evBeforePostNoStorico,
                               evBeforeDelete,
                               evAfterDelete,
                               evAfterPost]);
  S030MW:=TS030FProvvedimentiMW.Create(Self);
  S030MW.evtRichiesta:=evtRichiesta;
  selSG100.FieldByName('D_CAUSALI').LookupDataSet:=S030MW.selSG104;
  S030MW.selSG100:=selSG100;
  S030FProvved.DButton.DataSet:=selSG100;
  S030FProvved.dCmbSede.ListSource:=S030MW.dsrSede;
  S030FProvved.dlblDescSede.DataSource:=S030MW.dsrSede;
  S030FProvved.dCmbMotivazione.ListSource:=S030MW.dsrSG104;
  S030MW.ApriDataSetSede;
end;

procedure TS030FProvvedimentiDtM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(S030MW);
  inherited;
end;

procedure TS030FProvvedimentiDtM.selSG100AfterScroll(DataSet: TDataSet);
begin
  inherited;
  with S030FProvved do
  begin
    ImpostaCodiceDato;
    VisualizzaDescDato;
    VisualizzaDescMotivazione;
    VisualizzaDescSede;
    S030MW.selSG100AfterScroll;
    btnDettaglio.Visible:=S030MW.VisualizzaDettaglio;
  end;
end;

procedure TS030FProvvedimentiDtM.selSG100NewRecord(DataSet: TDataSet);
begin
  inherited;
  S030MW.selSG100NewRecord(S030FProvved.rgpVisualizza.ItemIndex);
end;

procedure TS030FProvvedimentiDtM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  S030MW.selSG100BeforePost(S030FProvved.dRgpTipo.ItemIndex);
end;

procedure TS030FProvvedimentiDtM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  S030MW.selSG100AfterPost;
  S030FProvved.btnDettaglio.Visible:=S030MW.VisualizzaDettaglio;
end;

procedure TS030FProvvedimentiDtM.selSG100DATAREGISTRGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text:=S030MW.selSG100DataRegistrGetText;
end;

procedure TS030FProvvedimentiDtM.evtRichiesta(Msg,Chiave:String);
begin
  if R180MessageBox(Msg,'DOMANDA') <> mrYes then
    Abort;
end;

end.
