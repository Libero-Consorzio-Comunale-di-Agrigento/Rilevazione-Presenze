unit A037UDialogStampa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, C001StampaLib, A000UCostanti, A000USessione,A000UInterfaccia, DBCtrls, OracleData,
  C700USelezioneAnagrafe, C180FunzioniGenerali, Variants;

type
  TA037FDialogStampa = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Label1: TLabel;
    Edit1: TEdit;
    PrinterSetupDialog1: TPrinterSetupDialog;
    Label2: TLabel;
    DatoLibero: TDBLookupComboBox;
    BitBtn4: TBitBtn;
    procedure DatoLiberoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
    function GetCodPaghe(CodInt:String):String;
  public
    { Public declarations }
    TipoStampa:Byte;  //0 = Reperibilità  1 = Straordinario
  end;

var
  A037FDialogStampa: TA037FDialogStampa;

implementation

uses A037UStampaRep, A037UScaricoPagheDtM1, A037UScaricoPaghe;

{$R *.DFM}

procedure TA037FDialogStampa.FormCreate(Sender: TObject);
begin
  A037FStampaRep:=TA037FStampaRep.Create(nil);
  C001SettaQuickReport(A037FStampaRep.QRep);
  Edit1.Text:=Parametri.DAzienda;
  A000SettaVariabiliAmbiente;
  A037FScaricoPagheDtM1.selI010A.Open;
end;

procedure TA037FDialogStampa.BitBtn1Click(Sender: TObject);
begin
  if PrinterSetupDialog1.Execute then
    C001SettaQuickReport(A037FStampaRep.QRep);
end;

procedure TA037FDialogStampa.BitBtn2Click(Sender: TObject);
{Preparazione della stampa}
var S:String;
    P:Integer;
    DL:Boolean;
    D:TDateTime;
begin
  A037FScaricoPaghe.DataCassa:=R180InizioMese(A037FScaricoPaghe.DataFile);
  with TOracleDataSet.Create(nil) do
  try
    Session:=SessioneOracle;
    SQL.Add('SELECT MAX(DATA_CASSA) FROM T195_VOCIVARIABILI');
    Open;
    D:=Fields[0].AsDateTime;
  finally
    Free;
  end;
  if A037FScaricoPaghe.DataCassa < D then
    raise Exception.Create('La data di scarico non può essere precedente a ' + UpperCase(FormatDateTime('mmmm yyyy',D)) + ', mese dell''ultimo scarico');
  DL:=False;
  A037FStampaRep.QRLabel12.Enabled:=False;
  A037FStampaRep.QRLabel13.Enabled:=False;
  A037FStampaRep.QRLDatoLibero.Enabled:=False;
  A037FStampaRep.QRLDatoLibero2.Enabled:=False;
  with A037FScaricoPagheDtM1 do
  begin
    if DatoLibero.Text <> '' then
    begin
      C700SelAnagrafe.Close;
      S:=C700SelAnagrafe.SQL.Text;
      P:=Pos('FROM',S);
      Insert(',' + selI010A.FieldByName('Nome_Campo').AsString + ' ',S,P);
      C700SelAnagrafe.SQL.Text:=S;
      C700SelAnagrafe.FieldDefs.Update;
      C700SelAnagrafe.Open;
      DL:=True;
      A037FStampaRep.QRLabel12.Enabled:=True;
      A037FStampaRep.QRLabel13.Enabled:=True;
      A037FStampaRep.QRLDatoLibero.Enabled:=True;
      A037FStampaRep.QRLDatoLibero2.Enabled:=True;
      A037FStampaRep.QRLabel12.Caption:=DatoLibero.Text;
      A037FStampaRep.QRLabel13.Caption:=DatoLibero.Text;
      A037FStampaRep.QRLDatoLibero.DataSet:=C700SelAnagrafe;
      A037FStampaRep.QRLDatoLibero2.DataSet:=C700SelAnagrafe;
      A037FStampaRep.QRDbText1.DataSet:=C700SelAnagrafe;
      A037FStampaRep.QRDbText3.DataSet:=C700SelAnagrafe;
      A037FStampaRep.QRDbText4.DataSet:=C700SelAnagrafe;
      A037FStampaRep.QRLDatoLibero.DataField:=selI010A.FieldByName('Nome_Campo').AsString;
      A037FStampaRep.QRLDatoLibero2.DataField:=selI010A.FieldByName('Nome_Campo').AsString;
    end;
    C700SelAnagrafe.First;
  end;
  with A037FScaricoPaghe, A037FStampaRep do
    begin
    LAzienda.Caption:=Edit1.Text;
    //Abilito le bande corrette
    IntReperib.Enabled:=TipoStampa = 0;
    DettReperib.Enabled:=TipoStampa = 0;
    TotReperib.Enabled:=TipoStampa = 0;
    IntStraord.Enabled:=TipoStampa = 1;
    DettStraord.Enabled:=TipoStampa = 1;
    TotStraord.Enabled:=TipoStampa = 1;
    if TipoStampa = 0 then
      //Reperibilità
      begin
      QRTitolo.Caption:='Pronta disponibilità';
      //Leggo il contratto e la descrizione dell'interfaccia paghe per estrarre i codici della reperibilità
      //Nando: 31.10.2005 spostato in procedure TA037FScaricoPaghe.acReperibStraordClick(....
      //      ApriQueryIntPaghe(C700SelAnagrafe.FieldByName('T430Contratto').AsString);
      A037FStampaRep.LTurniCSI.Caption:=GetCodPaghe('260');
      A037FStampaRep.LMaggCSI.Caption:=GetCodPaghe('280');
      A037FStampaRep.LNonMaggCSI.Caption:=GetCodPaghe('290');
      end
    else
      //Straordinario
      begin
      IntReperib.Enabled:=True;
      IntReperib.Height:=0;
      QRTitolo.Caption:='Liquidazione ore lavoro straordinario';
      CreaFasce(C700SelAnagrafe.FieldByName('T430Contratto').AsString);
      end;
    if Sender = BitBtn4 then
      begin
      QRep.Prepare;
      QRep.Preview;
      end
    else
      begin
      QRep.Prepare;
      QRep.Print;
      end;
    end;
  SessioneOracle.Commit;
  with A037FScaricoPagheDtM1 do
    if DL then
      begin
      //Elimino il campo creato a run-time
      C700SelAnagrafe.CloseAll;
      //C700SelAnagrafe.Fields[C700SelAnagrafe.FieldCount - 1].Free;
      S:=C700SelAnagrafe.SQL.Text;
      P:=Pos(',' + selI010A.FieldByName('Nome_Campo').AsString + ' ',S);
      Delete(S,P,Length(',' + selI010A.FieldByName('Nome_Campo').AsString + ' '));
      C700SelAnagrafe.SQL.Text:=S;
      C700SelAnagrafe.Open;
      end;
end;

function TA037FDialogStampa.GetCodPaghe(CodInt:String):String;
{Restituisce il codice paghe corrispondente al codice interno specificato}
begin
  Result:='';
  with A037FScaricoPagheDtM1 do
    if selT190.SearchRecord('CodInterno',VarArrayOf([CodInt]),[srFromBeginning]) then
      Result:=selT190.FieldByName('Voce_Paghe').AsString;
end;

procedure TA037FDialogStampa.FormDestroy(Sender: TObject);
begin
  A037FScaricoPagheDtM1.QDatiReper.Close;
  A037FScaricoPagheDtM1.selI010A.Close;
  A037FStampaRep.Release;
end;

procedure TA037FDialogStampa.DatoLiberoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null; 
    if (Sender as TDBLookupComboBox).Field <> nil then
      //if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then 
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

end.
