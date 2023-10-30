unit B013UIntegrazioneEMKDtM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, A000UCostanti, A000USessione,A000UInterfaccia, C180FunzioniGenerali, Oracle,
  OracleData, Variants;

type
  TB013FIntegrazioneEMKDtM = class(TDataModule)
    DbIris032: TOracleSession;
    Aggiorna: TOracleQuery;
    selI103: TOracleDataSet;
    Dsel103: TDataSource;
    selI103ORA: TStringField;
    delEMKTimb: TOracleQuery;
    AggiornaMicr: TOracleQuery;
    delMicrTimb: TOracleQuery;
    selMicr: TOracleDataSet;
    procedure selI103ORAValidate(Sender: TField);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    TabelleMicr:String;
    procedure Scarico(Automatico:Boolean);
  end;

var
  B013FIntegrazioneEMKDtM: TB013FIntegrazioneEMKDtM;

implementation

uses B013UIntegrazioneEMK;

{$R *.DFM}

procedure TB013FIntegrazioneEMKDtM.DataModuleCreate(Sender: TObject);
var L:TStringList;
begin
  DBIris032.LogOff;
  DBIris032.LogonDatabase:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B013','Database','IRIS');
  DBIris032.LogonUserName:='MONDOEDP';
  L:=TStringList.Create;
  try
    L.LoadFromFile('IrisWIN.INI');
    DBIris032.LogonPassword:=R180Decripta(L[0],20111972);
  except
    DBIris032.LogonPassword:=A000PasswordFissa;
  end;
  L.Free;
  try
    DBIris032.Logon;
    selI103.Session:=DBIris032;
    Aggiorna.Session:=DBIris032;
    AggiornaMicr.Session:=DBIris032;
    delEMKTimb.Session:=DBIris032;
    delMicrTimb.Session:=DBIris032;
    selMicr.Session:=DBIris032;
    //RegistraMsg.Session:=DBIris032; // verificare!
    RegistraMsg.SessioneOracleApp:=DBIris032; // verificare!
    selI103.Open;
  except
  end;
  try
    selMicr.Open;
    TabelleMicr:='S';
  except
    TabelleMicr:='N';
  end;
end;

procedure TB013FIntegrazioneEMKDtM.Scarico(Automatico:Boolean);
//Eseguo l'integrazione con tabelle DC di EMK
begin
  RegistraMsg.IniziaMessaggio('B013');
  RegistraMsg.InserisciMessaggio('I',FormatDateTime('dd/mm/yyyy hh.nn ',Now) + '- INIZIO INTEGRAZIONE DATI -');
  //Allinemanento tabelle EMK
  try
    Aggiorna.SetVariable('AbMensa',B013FIntegrazioneEMK.edtAbMensa.Text);
    Aggiorna.Execute;
    RegistraMsg.InserisciMessaggio('I',' Allineamento tabelle EMK avvenuto con successo');
  except
    on E:Exception do
    begin
      RegistraMsg.InserisciMessaggio('I',' Allineamento tabelle EMK fallito ' + E.Message);
    end;
  end;
  //Se esistono le tabelle allinemanento tabelle Microntel
  if TabelleMicr = 'S' then
  begin
    try
      AggiornaMicr.SetVariable('AbMensa',B013FIntegrazioneEMK.edtAbMensa.Text);
      AggiornaMicr.Execute;
      RegistraMsg.InserisciMessaggio('I',' Allineamento tabelle Microntel avvenuto con successo');
    except
      on E:Exception do
      begin
        RegistraMsg.InserisciMessaggio('I',' Allineamento tabelle Microntel fallito ' + E.Message);
      end;
    end;
  end;
end;

procedure TB013FIntegrazioneEMKDtM.selI103ORAValidate(Sender: TField);
begin
 if not Sender.IsNull then
   R180OraValidate(Sender.Asstring);
end;

end.
