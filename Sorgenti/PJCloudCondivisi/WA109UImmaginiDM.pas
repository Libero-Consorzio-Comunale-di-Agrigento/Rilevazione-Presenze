unit WA109UImmaginiDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData, Oracle,
  A000UInterfaccia, A109UImmaginiMW, WR302UGestTabellaDM, WR300UBaseDM, DBClient;

type
  TWA109FImmaginiDM = class(TWR302FGestTabellaDM)
    selTabellaCODICE: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaDECORRENZA: TDateTimeField;
    selTabellaDECORRENZA_FINE: TDateTimeField;
    selTabellaIMMAGINE: TBlobField;
    selTabellaLARGHEZZA_CEDOLINO: TIntegerField;
    selTabellaCOLONNA_AZIONI: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure selTabellaCOLONNA_AZIONIGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    { Private declarations }
    A109FImmaginiMW:TA109FImmaginiMW;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TWA109FImmaginiDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  A109FImmaginiMW.BeforeDelete(DataSet);
end;

procedure TWA109FImmaginiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY T004.CODICE, T004.DECORRENZA');
  inherited;
  A109FImmaginiMW:=TA109FImmaginiMW.Create(Self);
end;

procedure TWA109FImmaginiDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A109FImmaginiMW);
  inherited;
end;

procedure TWA109FImmaginiDM.selTabellaCOLONNA_AZIONIGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text:='';
end;

end.
