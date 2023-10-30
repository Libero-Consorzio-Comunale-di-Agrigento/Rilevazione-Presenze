unit S130UOrdiniProfessionaliDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGestTab, Oracle, DB, OracleData,
  C180FunzioniGenerali, S130UOrdiniProfessionaliMW, A000UMessaggi, A000UInterfaccia, R004UGestStoricoDTM;

type
  TS130FOrdiniProfessionaliDtM = class(TR004FGestStoricoDtM)
    selSG221: TOracleDataSet;
    selSG221COD_ORDINE: TStringField;
    selSG221DESCRIZIONE: TStringField;
    selSG221QUALIFICHE_COLLEGATE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure selSG221BeforeOpen(DataSet: TDataSet);
  private
  public
    S130MW: TS130FOrdiniProfessionaliMW;
  end;

var
  S130FOrdiniProfessionaliDtM: TS130FOrdiniProfessionaliDtM;

implementation

uses S130UOrdiniProfessionali;

{$R *.dfm}

procedure TS130FOrdiniProfessionaliDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selSG221,[evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost]);
  S130FOrdiniProfessionali.DButton.DataSet:=selSG221;
  S130MW:=TS130FOrdiniProfessionaliMW.Create(Self);
  S130MW.selSG221:=selSG221;
  selSG221.Open;
  selSG221QUALIFICHE_COLLEGATE.DisplayLabel:='Valori ' + Parametri.CampiRiferimento.C36_OrdProfSanCodice+' collegati';
  S130FOrdiniProfessionali.grdOrdiniProf.Columns[2].Title.Caption:='Valori ' + Parametri.CampiRiferimento.C36_OrdProfSanCodice+' collegati';

end;

procedure TS130FOrdiniProfessionaliDtM.selSG221BeforeOpen(DataSet: TDataSet);
begin
  inherited;
  S130MW.selSG221BeforeOpen;
end;

end.
