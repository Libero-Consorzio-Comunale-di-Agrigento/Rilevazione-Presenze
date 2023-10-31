create or replace function MEDPF_VERSW2NUM(P_VERSW in varchar2) return number as
  result number :=0;
  wVerSw varchar2(10);
  wPos1 integer;
  wPos2 integer;
  wStr1 varchar2(50);
  wStr2 varchar2(50);
  wStr3 varchar2(50);
begin
  wVerSw:=translate(upper(P_VERSW),'@ABCDEFGHKIJLMNOPQRSTUVWXYZ','0');
  wPos1:=instr(wVerSw,'.');
  if wPos1 = 0 then
    wPos1:=2;
    wVerSw:=substr(wVerSw,1,1)||'.'||substr(wVerSw,2);
  end if;
  wStr1:=substr(wVerSw,1,wPos1 - 1);
  wStr2:=substr(wVerSw,wPos1 + 1);
  wPos2:=instr(wStr2,'.');
  if wPos2 = 0 then
    wPos2:=instr(wStr2,'(');
  end if;
  if wPos2 > 0 then
    wStr3:=substr(wStr2,wPos2 + 1);
    wStr3:=replace(wStr3,')','');
    wStr3:=replace(wStr3,'(','');
    wStr2:=substr(wStr2,1,wPos2 - 1);
  end if;
  
  --return wStr1||'-'||wStr2||'-'||wStr3;
  result:=wStr1*1000 + nvl(wStr2,0) + (nvl(wStr3,0)/1000);
  return result;
exception
  when others then
    return -1;
end;
/