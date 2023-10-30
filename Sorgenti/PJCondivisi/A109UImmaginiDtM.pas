unit A109UImmaginiDtM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R004UGESTSTORICODTM, Db, Oracle, OracleData,
  A000UCostanti, A000USessione,A000UInterfaccia, A109UImmaginiMW,
  C180FUNZIONIGENERALI, (*Midaslib,*) Crtl, DBClient, Provider, Variants;

type
  TA109FImmaginiDtM = class(TR004FGestStoricoDtM)
    selT004: TOracleDataSet;
    selT004CODICE: TStringField;
    selT004DESCRIZIONE: TStringField;
    selT004DECORRENZA: TDateTimeField;
    selT004DECORRENZA_FINE: TDateTimeField;
    selT004IMMAGINE: TBlobField;
    selT004LARGHEZZA_CEDOLINO: TIntegerField;
    selT004FMT_BLOB: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure selT004IMMAGINEGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure selT004AfterEdit(DataSet: TDataSet);
  private
    { Private declarations }
    A109FImmaginiMW:TA109FImmaginiMW;
  public
    { Public declarations }
  end;

var
  A109FImmaginiDtM: TA109FImmaginiDtM;

implementation

uses A109UImmagini;

{$R *.DFM}

procedure TA109FImmaginiDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InterfacciaR004:=A109FImmagini.InterfacciaR004;
  InizializzaDataSet(selT004,[evBeforeEdit,
                              evBeforeInsert,
                              evBeforePost,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost,
                              evOnNewRecord,
                              evOnTranslateMessage]);
  A109FImmaginiMW:=TA109FImmaginiMW.Create(nil);
  A109FImmagini.DButton.DataSet:=selT004;
  InterfacciaR004.OttimizzaStorico:=False;
  selT004.Open;
end;

procedure TA109FImmaginiDtM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  A109FImmaginiMW.BeforeDelete(DataSet);
end;

procedure TA109FImmaginiDtM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(A109FImmaginiMW);
  inherited;
end;

procedure TA109FImmaginiDtM.selT004AfterEdit(DataSet: TDataSet);
begin
  inherited;
  A109FImmagini.CaricaImmagine;
end;

procedure TA109FImmaginiDtM.selT004IMMAGINEGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  inherited;
  if (selT004.State = dsInsert) or (selT004.State = dsEdit) then
    Text:='Cambia immagine...'
  else
    Text:='';
end;

end.


