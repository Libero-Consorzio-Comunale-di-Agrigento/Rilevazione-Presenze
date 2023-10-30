unit C200UWebServicesServerUtils;

interface

uses
  C200UWebServicesTypes, A000UCostanti,
  System.Classes, System.SysUtils, Datasnap.DSSession;

type

  TC200FWebServicesServerUtils = class
  end;

var
  CSC200StampaRave: TmedpCriticalSection;

implementation

{ TC200FWebServicesServerUtils }

initialization
  CSC200StampaRave:=TMedpCriticalSection.Create;

finalization
  FreeAndNil(CSC200StampaRave);

end.
