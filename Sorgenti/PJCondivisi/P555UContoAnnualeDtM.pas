unit P555UContoAnnualeDtM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, A000UCostanti, A000USessione, A000UInterfaccia,  RegistrazioneLog, OracleData, Oracle,
  R004UGestStoricoDtM, C700USelezioneAnagrafe,P999UGenerale, Variants,
  C180FunzioniGenerali, DBClient, P555UContoAnnualeMW;

type
  TP555FContoAnnualeDtM = class(TR004FGestStoricoDtM)
    selP554: TOracleDataSet;
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure DataModuleCreate(Sender: TObject);
    procedure selP554AfterScroll(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
  private
    procedure ApplyP555(Sender: TOracleDataSet; Action: Char);
    { Private declarations }
  public
    P555FContoAnnualeMW: TP555FContoAnnualeMW;
  end;

var
  P555FContoAnnualeDtM: TP555FContoAnnualeDtM;

implementation

uses P555UContoAnnuale;

{$R *.DFM}

procedure TP555FContoAnnualeDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selP554,[evBeforeDelete,
                              evAfterDelete]);
  P555FContoAnnualeMW:=TP555FContoAnnualeMW.Create(Self);
  P555FContoAnnualeMW.SelP554_Funzioni:=selP554;
  P555FContoAnnualeMW.bSelAnagrafe:=P555FContoAnnuale.rgpTipoDati.ItemIndex = 0;
  P555FContoAnnualeMW.ApplyP555:=ApplyP555;
  selP554.Open;
  P555FContoAnnualeMW.PosizionaSelP554(C700Progressivo);
end;

procedure TP555FContoAnnualeDtM.selP554AfterScroll(DataSet: TDataSet);
begin
  inherited;
  P555FContoAnnualeMW.SelP554AfterScroll;
  P555FContoAnnuale.cmbRicerca.KeyValue:=selP554.FieldByName('COD_TABELLA').AsString;

  if P555FContoAnnuale.rgpTipoDati.ItemIndex = 2 then
    P555FContoAnnuale.AggiornaRiepTabellari
  else
    P555FContoAnnualeMW.Aggiorna;

  P555FContoAnnuale.AbilitazioniComponenti;
end;

procedure TP555FContoAnnualeDtM.ApplyP555(Sender: TOracleDataSet;Action: Char);
begin
 case Action of
    'D':RegistraLog.SettaProprieta('C',R180Query2NomeTabella(Sender),Copy(Name,1,4),Sender,True);
    'I':RegistraLog.SettaProprieta('I',R180Query2NomeTabella(Sender),Copy(Name,1,4),Sender,True);
    'U':RegistraLog.SettaProprieta('M',R180Query2NomeTabella(Sender),Copy(Name,1,4),Sender,True);
  end;
  if Action in ['D','I','U'] then
    RegistraLog.RegistraOperazione;
end;

procedure TP555FContoAnnualeDtM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  P555FContoAnnualeMW.SelP554BeforeDelete;
end;

procedure TP555FContoAnnualeDtM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(P555FContoAnnualeMW);
  inherited;
end;

end.

