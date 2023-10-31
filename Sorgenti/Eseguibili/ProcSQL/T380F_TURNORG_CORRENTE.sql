create or replace function T380F_TURNORG_CORRENTE(P_PROGRESSIVO in integer, P_DATA in date := sysdate) return varchar2 as
  wData date := trunc(P_DATA);
  wDalle integer;
  wAlle integer;
  wReperibilita varchar2(1000) := null;
  result varchar2(1000) := null;

  cursor cT380 is
    select 
      T380.DATA,
      decode(T380.TIPOLOGIA,'R','REPERIBILITA''','G','GUARDIA') TIPOLOGIA,
      T380.TURNO,
      T350.DESCRIZIONE,
      to_char(T350.ORAINIZIO,'sssss')/60 DALLE,
      to_char(T350.ORAFINE,'sssss')/60   ALLE
    from T350_REGREPERIB T350,
         (
         select T380.TIPOLOGIA,T380.DATA,T380.TURNO1 TURNO from T380_PIANIFREPERIB T380
         where T380.PROGRESSIVO = P_PROGRESSIVO  
         and T380.DATA between wData - 1 and wData
         and T380.TURNO1 is not null
         union
         select T380.TIPOLOGIA,T380.DATA,T380.TURNO2 from T380_PIANIFREPERIB T380
          where T380.PROGRESSIVO = P_PROGRESSIVO  
         and T380.DATA between wData - 1 and wData
         and T380.TURNO2 is not null
         union
         select T380.TIPOLOGIA,T380.DATA,T380.TURNO3 from T380_PIANIFREPERIB T380
         where T380.PROGRESSIVO = P_PROGRESSIVO  
         and T380.DATA between wData - 1 and wData
         and T380.TURNO3 is not null) T380
    where  T380.TURNO = T350.CODICE
    and (T380.DATA = wData or to_char(T350.ORAINIZIO,'sssss') >= to_char(T350.ORAFINE,'sssss'));
    
begin
  for t1 in cT380 loop
    wDalle:=t1.Dalle;
    wAlle:=t1.Alle;
    if t1.DATA = wData - 1 then
      if wDalle = 0 then 
         exit;
      else
        wDalle:=0;
      end if;
    end if;
    if wDalle >= wAlle then
      wAlle:=wAlle + 1440;
    end if;  
    
    if to_char(P_DATA,'sssss')/60 between wDalle and wAlle then
      wReperibilita:='"tipologia='||t1.TIPOLOGIA||'",'||
                     '"dalle='||minutiore(wDalle)||'",'||
                     '"alle='||minutiore(wAlle)||'",'||
                     '"turno='||t1.TURNO||'('||t1.DESCRIZIONE||')"';
      exit;
    end if;
  end loop;

  result:=wReperibilita;
  return result;
end;
/