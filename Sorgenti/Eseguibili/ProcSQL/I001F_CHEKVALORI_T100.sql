create or replace function I001F_CHEKVALORI_T100(P_ID in integer, P_DATA in date, P_ORA in varchar2, P_VERSO in varchar2, P_FLAG in varchar2) return varchar2 as
  result varchar2(1);
  valore varchar2(100);

  cursor c1(P_ID integer) is
    select colonna, valore_old, valore_new
    from   i001_logdati
    where  id = P_ID;

begin
  result:='S';
  for t1 in c1(P_ID) loop
    valore:=nvl(t1.valore_old,t1.valore_new);
    if t1.colonna = 'DATA' then
      valore:=to_char(P_DATA,'dd/mm/yyyy');
    elsif t1.colonna = 'ORA' then
      if length(nvl(t1.valore_old,t1.valore_new)) = 4 then
        valore:=replace(substr(P_ORA,12,5),'.','');
      else
        valore:=P_ORA;
      end if;
    elsif t1.colonna = 'VERSO' then
      valore:=P_VERSO;
    elsif t1.colonna = 'FLAG' then
      valore:=P_FLAG;
    end if;

    if nvl(valore,'<null>') <> nvl(nvl(t1.valore_old,t1.valore_new),'<null>') and
       nvl(valore,'<null>') <> nvl(nvl(t1.valore_new,t1.valore_old),'<null>') then
      result:='N';
      return result;
    end if;  

    if t1.colonna in ('DAL - AL','RIPRISTINO DAL - AL') then
      result:='N';
      return result;
    end if;

  end loop;

  return result;
end;
/
