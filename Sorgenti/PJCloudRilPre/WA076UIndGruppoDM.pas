unit WA076UIndGruppoDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR302UGestTabellaDM, DB, OracleData, A076UIndGruppoMW;

type
  TWA076FIndGruppoDM = class(TWR302FGestTabellaDM)
    selTabellaCODICE: TStringField;
    selTabellaCODICE2: TStringField;
    selTabellaINDENNITA: TStringField;
    selTabellaD_INDENNITA: TStringField;
    selTabellaDECORRENZA: TDateTimeField;
    selTabellaD_DescCodice: TStringField;
    selTabellaD_DescCodice2: TStringField;
    selTabellaD_CodiceInd: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure selTabellaCODICEValidate(Sender: TField);
    procedure selTabellaINDENNITAValidate(Sender: TField);
  private
    { Private declarations }
  public
    A076MW:TA076FIndGruppoMW;
  end;

implementation

{$R *.dfm}

procedure TWA076FIndGruppoDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  NonAprireSelTabella:=True;
  selTabella.SetVariable('ORDERBY','order by T161.CODICE, T161.CODICE2');
  inherited;
  A076MW:=TA076FIndGruppoMW.Create(Self);
  A076MW.Q161:=SelTabella;
  A076MW.InizializzaTabella;
  selTabella.Open;
end;

procedure TWA076FIndGruppoDM.selTabellaCODICEValidate(Sender: TField);
begin
  A076MW.Q161CODICEValidate(Sender);
end;

procedure TWA076FIndGruppoDM.selTabellaINDENNITAValidate(Sender: TField);
begin
  A076MW.BDEQ161INDENNITAValidate(Sender);
end;

end.
