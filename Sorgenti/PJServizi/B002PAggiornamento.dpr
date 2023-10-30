program B002PAggiornamento;

uses
  Forms,
  B002UAggiornamento in 'B002UAggiornamento.pas' {B002FAggiornamento},
  B002USorgente in 'B002USorgente.pas' {Form1},
  B002UDestinatario in 'B002UDestinatario.pas' {Form2},
  B002UCampiChiave in 'B002UCampiChiave.pas' {B002FCampiChiave},
  B002UQuery in 'B002UQuery.pas' {B002FQuery},
  B002UMappatura in 'B002UMappatura.pas' {B002FMappatura},
  B002UDataStorici in 'B002UDataStorici.pas' {B002FDataStorici},
  B002UTranscodifica in 'B002UTranscodifica.pas' {B002FTranscodifica};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TB002FAggiornamento, B002FAggiornamento);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TB002FCampiChiave, B002FCampiChiave);
  Application.CreateForm(TB002FQuery, B002FQuery);
  Application.CreateForm(TB002FMappatura, B002FMappatura);
  Application.CreateForm(TB002FDataStorici, B002FDataStorici);
  Application.CreateForm(TB002FTranscodifica, B002FTranscodifica);
  Application.Run;
end.
