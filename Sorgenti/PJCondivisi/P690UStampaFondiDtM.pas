unit P690UStampaFondiDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, Oracle, DBClient, P690UStampaFondiMW;

type
  TP690FStampaFondiDtM = class(TR004FGestStoricoDtM)
    selP688: TOracleDataSet;
    TabStampaRis: TClientDataSet;
    selP688Dett: TOracleDataSet;
    TabStampaDest: TClientDataSet;
    selP686: TOracleDataSet;
    procedure selP688AfterScroll(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    P690MW: TP690FStampaFondiMW;
  end;

var
  P690FStampaFondiDtM: TP690FStampaFondiDtM;

implementation

uses P690UStampaFondi;

{$R *.dfm}

procedure TP690FStampaFondiDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  P690MW:=TP690FStampaFondiMW.Create(Self);
end;

procedure TP690FStampaFondiDtM.selP688AfterScroll(DataSet: TDataSet);
begin
  inherited;
  if P690FStampaFondi.chkRaggruppa.Checked then
  begin
    TabStampaRis.Filter:='(FONDO = ''' + selP688.FieldByName('COD_FONDO_RAGGR').AsString + ''') AND (DEC = ''' +
       selP688.FieldByName('DECORRENZA_DA').AsString + ''')';
    TabStampaRis.Filtered:=True;
    TabStampaDest.Filter:='(FONDO = ''' + selP688.FieldByName('COD_FONDO_RAGGR').AsString + ''') AND (DEC = ''' +
       selP688.FieldByName('DECORRENZA_DA').AsString + ''')';
    TabStampaDest.Filtered:=True;
  end
  else
  begin
    TabStampaRis.Filter:='(FONDO = ''' + selP688.FieldByName('COD_FONDO').AsString + ''') AND (DEC = ''' +
       selP688.FieldByName('DECORRENZA_DA').AsString + ''')';
    TabStampaRis.Filtered:=True;
    TabStampaDest.Filter:='(FONDO = ''' + selP688.FieldByName('COD_FONDO').AsString + ''') AND (DEC = ''' +
       selP688.FieldByName('DECORRENZA_DA').AsString + ''')';
    TabStampaDest.Filtered:=True;
  end;
end;

end.
