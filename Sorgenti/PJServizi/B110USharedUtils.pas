unit B110USharedUtils;

interface

uses
  B110USharedTypes,
  C200UWebServicesTypes,
  System.Classes,
  System.SysUtils,
  IdHashSHA;

type

  TB110FSharedUtils = class
  public
    class function SHA1Encrypt(const PStr: String): String; static;
    class function TruncateString(const PStr: String; const PLength: Integer): String; static; inline;
  end;

implementation

{ TB110FSharedUtils }

class function TB110FSharedUtils.SHA1Encrypt(const PStr: String): String;
// funzione per cifrare una stringa con l'algoritmo sha-1
// importante: utilizza librerie open source per effettuare la cifratura
var
  SHA1: TIdHashSHA1;
begin
  SHA1:=TIdHashSHA1.Create;
  try
    Result:=SHA1.HashStringAsHex(PStr);
  finally
    SHA1.Free;
  end;
end;

class function TB110FSharedUtils.TruncateString(const PStr: String; const PLength: Integer): String;
// tronca la stringa passata alla lunghezza indicata, aggiungendo se necessario tre puntini di sospensione
const
  PUNTINI = '...';
begin
  if PLength <= 0 then
    raise Exception.CreateFmt('Lunghezza della stringa troncata non valida: %d',[PLength]);

  Result:=PStr;
  if Result.Length > PLength then
    Result:=Result.Substring(0,PLength - PUNTINI.Length).Trim + PUNTINI;
end;

end.
