create procedure MONDOEDP.I300P_GETFREESPACE as
begin
  delete from MONDOEDP.I300_TABLESPACE_FREESPACE;

  insert into MONDOEDP.I300_TABLESPACE_FREESPACE 
    (tablespace, spazio_libero,spazio_libero_stringa)
  select /*+ ALL_ROWS*/
     s.tablespace_name Tablespace,
     sum(s.bytes) / 1024 / 1024 Spazio_libero,
     to_char(sum(s.bytes) / 1024 / 1024,'fm999g999g999g999g990d00') Spazio_libero_stringa
  from user_free_space s
  group by s.tablespace_name
  having tablespace_name in (
    select distinct TABLESPACE_NAME from USER_SEGMENTS
    union
    select TSLAVORO from MONDOEDP.I090_ENTI
    union
    select TSINDICI from MONDOEDP.I090_ENTI
  );
end/*--NOLOG--*/;
/
