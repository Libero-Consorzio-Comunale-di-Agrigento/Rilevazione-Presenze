unit P690UStampaFondiMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, Data.DB, OracleData;

type
  TP690FStampaFondiMW = class(TR005FDataModuleMW)
    selP684: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ListaFondi:TStringList;
    function FondiDisponibili(pDal,pAl:TDateTime):Boolean;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TP690FStampaFondiMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  ListaFondi:=TStringList.Create;
end;

procedure TP690FStampaFondiMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  ListaFondi.Free;
end;

function TP690FStampaFondiMW.FondiDisponibili(pDal,pAl:TDateTime):Boolean;
begin
  Result:=False;
  if (pDal <> selP684.GetVariable('INIZIO')) or
     (pAl <> selP684.GetVariable('FINE')) then
  begin
    Result:=True;
    ListaFondi.Clear;
    selP684.Close;
    selP684.SetVariable('INIZIO',pDal);
    selP684.SetVariable('FINE',pAl);
    selP684.Open;
    while not selP684.Eof do
    begin
      ListaFondi.Add(selP684.FieldByName('COD_FONDO').AsString + ' - ' + selP684.FieldByName('DESCRIZIONE').AsString);
      selP684.Next;
    end;
  end;
end;

end.
