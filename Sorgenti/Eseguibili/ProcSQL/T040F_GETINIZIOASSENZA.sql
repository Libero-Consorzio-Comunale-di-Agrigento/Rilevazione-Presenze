CREATE OR REPLACE FUNCTION T040F_GETINIZIOASSENZA (PROG IN NUMBER, D IN DATE, CAUS IN VARCHAR2) return date is
  Result DATE;
  wcr varchar2(5);
  wcc1 varchar2(2000);
  wd date;
  bdata varchar2(1);
begin
  select CODRAGGR,CODCAU1 into wcr,wcc1 from T265_CAUASSENZE where CODICE = CAUS;
  wcc1:=','||wcc1||',';
  select max(DATA) into wd from T040_GIUSTIFICATIVI
  where PROGRESSIVO = prog
  and   DATA <= D
  and   CAUSALE in
     (select CODICE from T265_CAUASSENZE where CODRAGGR = wcr or instr(wcc1,','||CODICE||',') > 0);
  getinizioassenza(prog,wd,caus,Result,bdata);
  return(Result);
exception
  when others then
    return(null);
end;
/