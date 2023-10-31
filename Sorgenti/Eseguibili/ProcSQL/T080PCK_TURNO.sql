create or replace package T080PCK_TURNO is

  function GETORARIO(INPROG in integer,INDATA in DATE,INTIPO in varchar2) return varchar2;  
  function GETNTURNO(INPROG in integer,INDATA in DATE,INTIPO in varchar2) return varchar2;
  function COPIATURNO(PROGORIG in integer, PROGDEST in integer, DATAINIZIO in date, DATAFINE in date) return varchar2;
  procedure GETDATO_GENERICO(INPROG in integer,INDATA in DATE);
  function GETPARTENZA return number;
  function GETTIPOGIORNO(P_PROGRESSIVO in integer, P_DATA in DATE, P_DOMENICA_FESTIVA in varchar2 :='S') return varchar2;

end T080PCK_TURNO;
/