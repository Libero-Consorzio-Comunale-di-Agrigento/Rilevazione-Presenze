create or replace function I001F_CHEKVALORI_T040(P_ID in integer, P_DATA in date, P_CAUSALE in varchar2, P_TIPOGIUST in varchar2, P_DAORE in varchar2, P_AORE in varchar2, P_DATANAS in date) return varchar2 as
  result varchar2(1);
  valore varchar2(100);
  wExistsData      boolean :=false;
  wExistsCausale   boolean :=false;
  wExistsTipoGiust boolean :=false;

  cursor c1(P_ID integer) is
    select colonna, valore_old, valore_new
    from   i001_logdati
    where  id = P_ID;

begin
  result:='S';
  
  for t1 in c1(P_ID) loop
    valore:=nvl(t1.valore_old,t1.valore_new);
    if t1.colonna = 'DATA' then
      wExistsData:=True;
      valore:=to_char(P_DATA,'dd/mm/yyyy');
    elsif t1.colonna = 'CAUSALE' then
      wExistsCausale:=True;
      valore:=P_CAUSALE;
    elsif t1.colonna = 'TIPOGIUST' then
      wExistsTipoGiust:=True; 
      valore:=P_TIPOGIUST;
    elsif t1.colonna = 'DAORE' then
      valore:=P_DAORE;
    elsif t1.colonna = 'AORE' then
      valore:=P_AORE;
    elsif t1.colonna = 'DATANAS' then
      if P_DATANAS = trunc(P_DATANAS) then
        valore:=to_char(P_DATANAS,'dd/mm/yyyy');
      else
        valore:=to_char(P_DATANAS,'dd/mm/yyyy hh24.mi.ss');
      end if;
    end if;

    if nvl(valore,'<null>') <> nvl(nvl(t1.valore_old,t1.valore_new),'<null>') and
       nvl(valore,'<null>') <> nvl(nvl(t1.valore_new,t1.valore_old),'<null>') then
      result:='N';
      return result;
    end if;

  end loop;

  if result = 'S' then
    if not wExistsData or not wExistsCausale or not wExistsTipoGiust then 
      result:='N';
    end if;  
  end if;  
  
  return result;
end;
/