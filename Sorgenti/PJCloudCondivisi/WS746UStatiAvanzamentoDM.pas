unit WS746UStatiAvanzamentoDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM,
  Data.DB, OracleData, S746UStatiAvanzamentoMW, A000UInterfaccia;

type
  TWS746FStatiAvanzamentoDM = class(TWR302FGestTabellaDM)
    selTabellaDECORRENZA: TDateTimeField;
    selTabellaDECORRENZA_FINE: TDateTimeField;
    selTabellaCODICE: TIntegerField;
    selTabellaCODREGOLA: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaMODIFICABILE: TStringField;
    selTabellaCODSTAMPA: TIntegerField;
    selTabellaDATA_DA: TDateTimeField;
    selTabellaDATA_A: TDateTimeField;
    selTabellaDATA_DA_RICHIESTA_VISIONE: TDateTimeField;
    selTabellaDATA_A_RICHIESTA_VISIONE: TDateTimeField;
    selTabellaVAL_INTERM_MODIFICABILE: TStringField;
    selTabellaVAL_INTERM_OBBLIGATORIA: TStringField;
    selTabellaCREA_AUTOVALUTAZIONE: TStringField;
    selTabellaDESCCODREGOLA: TStringField;
    selTabellaDESCCODSTAMPA: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure selTabellaCODICEValidate(Sender: TField);
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure BeforePost(DataSet: TDataSet); override;
    procedure selTabellaDECORRENZAValidate(Sender: TField);
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure selTabellaAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    S746FStatiAvanzamentoMW: TS746FStatiAvanzamentoMW;
  end;

implementation

{$R *.dfm}
uses
  WR102UGestTabella, WS746UStatiAvanzamentoDettFM;

procedure TWS746FStatiAvanzamentoDM.AfterScroll(DataSet: TDataSet);
begin
  S746FStatiAvanzamentoMW.RecuperaListaRegole;
  S746FStatiAvanzamentoMW.RecuperaListaStampa;
  inherited;
  S746FStatiAvanzamentoMW.SG746OldValues.Aggiorna;
  if (Self.Owner as TWR102FGestTabella).WDettaglioFM <> nil then
    ((Self.Owner as TWR102FGestTabella).WDettaglioFM as TWS746FStatiAvanzamentoDettFM).AbilitaComponenti;
end;

procedure TWS746FStatiAvanzamentoDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  S746FStatiAvanzamentoMW.SG746BeforeDelete;
end;

procedure TWS746FStatiAvanzamentoDM.BeforePost(DataSet: TDataSet);
var msg:String;
begin
  inherited;
  msg:=S746FStatiAvanzamentoMW.BeforePost(DataSet.State = dsEdit);
  if msg <> '' then
    begin
      MsgBox.AddMessage(msg);
      MsgBox.ShowMessages;
    end;
end;

procedure TWS746FStatiAvanzamentoDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY CODREGOLA, CODICE, DECORRENZA');
  S746FStatiAvanzamentoMW:=TS746FStatiAvanzamentoMW.Create(Self);
  S746FStatiAvanzamentoMW.SG746:=selTabella;
  S746FStatiAvanzamentoMW.SG746OldValues.SetDataSet(selTabella);
  selTabella.FieldByName('DESCCODREGOLA').LookupDataSet:=S746FStatiAvanzamentoMW.selSG741;
  selTabella.FieldByName('DESCCODSTAMPA').LookupDataSet:=S746FStatiAvanzamentoMW.selSG746;
  InterfacciaWR102.OttimizzaDecorrenzaFine:=False;
  InterfacciaWR102.AllineaSoloDecorrenzeIntersecanti:=True;
  inherited;
end;

procedure TWS746FStatiAvanzamentoDM.selTabellaAfterOpen(DataSet: TDataSet);
begin
  S746FStatiAvanzamentoMW.SG746OldValues.CreaStruttura;
end;

procedure TWS746FStatiAvanzamentoDM.selTabellaCODICEValidate(Sender: TField);
begin
  inherited;
  S746FStatiAvanzamentoMW.SG746CODICEValidate;
  ((Self.Owner as TWR102FGestTabella).WDettaglioFM as TWS746FStatiAvanzamentoDettFM).CaricaMultiColumnCombobox;
end;

procedure TWS746FStatiAvanzamentoDM.selTabellaDECORRENZAValidate(Sender: TField);
begin
  inherited;
  S746FStatiAvanzamentoMW.SG746DECORRENZAValidate;
  ((Self.Owner as TWR102FGestTabella).WDettaglioFM as TWS746FStatiAvanzamentoDettFM).CaricaMultiColumnCombobox;
end;

procedure TWS746FStatiAvanzamentoDM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  S746FStatiAvanzamentoMW.SG746NewRecord;
end;

end.
