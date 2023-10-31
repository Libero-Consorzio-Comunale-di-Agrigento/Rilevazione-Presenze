create or replace trigger T065_AFTERDEL
  after delete on T065_RICHIESTESTRAORDINARI
  for each row
begin
  delete T850_ITER_RICHIESTE where ITER = 'T065' and ID = :old.ID and STATO is null;
end;
/