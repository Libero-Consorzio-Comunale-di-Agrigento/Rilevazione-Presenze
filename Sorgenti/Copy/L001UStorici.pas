unit L001UStorici;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, QueryStorico,
  DB, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, A000UCostanti, A000USessione, RegistrazioneLog, A000UInterfaccia,
  OracleData, Oracle, Variants;

type
  TL001FStorici = class(TForm)
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    DataSource1: TDataSource;
    Table1: TOracleDataSet;
    Table1DESCRIZIONE: TStringField;
    Query1: TOracleDataSet;
    Table1CODICE: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure Table1BeforeInsert(DataSet: TDataSet);
    procedure Table1AfterPost(DataSet: TDataSet);
  private
    { Private declarations }
    DStorici:array of String;
    Inserimento:Boolean;
  public
    { Public declarations }
  end;

var
  L001FStorici: TL001FStorici;

implementation

{$R *.DFM}

procedure TL001FStorici.FormCreate(Sender: TObject);
{Carico le descrizioni di default leggendo anche i dati liberi}
var i,j:word;
begin
  Inserimento:=False;
  Table1.Session:=SessioneOracle;
  Query1.Session:=SessioneOracle;
  Table1.Open;
  Query1.Open;
  SetLength(DStorici,NumStorici + 1);
  DStorici[1]:='Badge';
  DStorici[2]:='Ediz.Badge';
  DStorici[3]:='Indirizzo';
  DStorici[4]:='Com.res.';
  DStorici[5]:='CAP res.';
  DStorici[6]:='Telefono';
  DStorici[7]:='Assunzione';
  DStorici[8]:='Cessazione';
  DStorici[9]:='Squadra';
  DStorici[10]:='Tipo oper.';
  DStorici[11]:='Terminali abil.';
  DStorici[12]:='Abil.straord.';
  DStorici[13]:='Str.prima entrata';
  DStorici[14]:='Str.ultima uscita';
  DStorici[15]:='Str.entrate succ.';
  DStorici[16]:='Contratto';
  DStorici[17]:='Ore settimanali';
  DStorici[18]:='Ore teoriche';
  DStorici[19]:='Tipo cartellino';
  DStorici[20]:='Tipo gestione';
  DStorici[21]:='Plus orario';
  DStorici[22]:='Calendario';
  DStorici[23]:='Ind.presenza';
  DStorici[24]:='Prof.orario';
  DStorici[25]:='Prof.assenze';
  DStorici[26]:='Assenze abilitate';
  DStorici[27]:='Presenze abilitate';
  DStorici[28]:='Tipo rapporto';
  DStorici[29]:='Part time';
  DStorici[30]:='Str.uscite prec.';
  DStorici[31]:='Docente';
  i:=31;
  with Query1 do
    begin
    First;
    while not Eof do
      begin
      inc(i);
      SetLength(DStorici,NumStorici + i + 1);
      DStorici[i]:=FieldByName('NOMECAMPO').AsString;
      Next;
      end;
    Close;
    end;
  with Table1 do
    begin
    FieldByName('Codice').ReadOnly:=False;
    Inserimento:=True;
    for j:=1 to i do
      if not Locate('Codice',j,[]) then
        InsertRecord([j,DStorici[j]]);
    FieldByName('Codice').ReadOnly:=True;
    Inserimento:=False;
    end;
end;

procedure TL001FStorici.Table1BeforeInsert(DataSet: TDataSet);
begin
  if not Inserimento then Abort; 
end;

procedure TL001FStorici.Table1AfterPost(DataSet: TDataSet);
begin
  if not Inserimento then
  begin
    RegistraLog.SettaProprieta('M','T431_DATISTORICI',Copy(Name,1,4),Table1,True);
    RegistraLog.RegistraOperazione;
    RegistraLog.Session.Commit;
  end;
end;

end.
