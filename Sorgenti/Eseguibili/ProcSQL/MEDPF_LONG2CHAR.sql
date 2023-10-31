create or replace function MEDPF_LONG2CHAR(P_TAB varchar2, P_COL varchar2) return varchar2 as
  result varchar2(4000);
begin
  select DATA_DEFAULT into result
  from COLS
  where TABLE_NAME = P_TAB and COLUMN_NAME = P_COL; 
  
  result:=replace(result,'''','');
  result:=replace(result,chr(10),'');
  result:=replace(result,'null','');
  return trim(result);  
  
exception
  when no_data_found then
    return null;
end;  
/
