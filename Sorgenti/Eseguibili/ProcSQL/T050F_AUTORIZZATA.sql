create or replace function T050F_AUTORIZZATA(pID integer) return varchar2 is
  Result varchar2(1);
begin
  Result:=null;
  begin
    select
      decode (VT050.TIPO_RICHIESTA,
              'P',decode(nvl(T265.CUMULA_RICHIESTE_WEB,T275.CUMULA_RICHIESTE_WEB),'R',nvl(T851F_STATO_INTERMEDIO('T050',pID),'S'),'A',nvl(T851F_STATO_INTERMEDIO('T050',pID),'N'),'N'),
              decode(nvl(T265.CUMULA_RICHIESTE_WEB,T275.CUMULA_RICHIESTE_WEB),'R',nvl(VT050.STATO,'S'),'A',nvl(VT050.STATO,'N'),'N')
             ) into Result
    from 
      VT050_RICHIESTEASSENZA VT050, T265_CAUASSENZE T265, T275_CAUPRESENZE T275
    where VT050.ID = pID
    and VT050.CAUSALE = T265.CODICE (+)
    and VT050.CAUSALE = T275.CODICE (+);
  exception
    when no_data_found then
      null;
  end;
  return(Result);
end T050F_AUTORIZZATA;
/

create or replace view VT050_RICHIESTE_SENZAREVOCA as
select 
  VT050.T050ROWID,
  VT050.ID,
  VT050.PROGRESSIVO,
  VT050.CAUSALE,
  VT050.TIPOGIUST,
  VT050.DAL,
  VT050.AL,
  VT050.NUMEROORE,
  VT050.AORE,
  VT050.DATANAS,
  VT050.NUMEROORE_PREV,
  VT050.AORE_PREV,
  VT050.ELABORATO,
  VT050.NOTE_GIUSTIFICATIVO,  
  VT050.DATA,
  VT050.NOTE,
  VT050.STATO,
  VT050.TIPO_RICHIESTA,
  VT050.AUTORIZZ_AUTOMATICA,
  VT050.ID_REVOCA,
  VT050.ID_REVOCATO,
  VT050.ITER,
  VT050.COD_ITER
from   VT050_RICHIESTEASSENZA VT050,
   T050_RICHIESTEASSENZA T050R
where  VT050.TIPO_RICHIESTA in ('P','D')
and    VT050.ID_REVOCA = T050R.ID(+)
and    nvl(T050R.ELABORATO,'N') <> 'S'
and    exists (select 'x' from dual where nvl(T050F_AUTORIZZATA(T050R.ID),'N') <> 'S');
