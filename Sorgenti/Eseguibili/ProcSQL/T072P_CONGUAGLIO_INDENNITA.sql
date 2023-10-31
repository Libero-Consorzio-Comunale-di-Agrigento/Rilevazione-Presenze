create or replace procedure T072P_CONGUAGLIO_INDENNITA (P_PROGRESSIVO in integer, P_DATA in date) as
  type t_turni_rec_type is table of number index by pls_integer;
  type t_indennita_rec_type is record (data date,
                                       codice varchar2(5),
                                       codice2 varchar2(5),
                                       regola2 varchar2(1),
                                       stato   varchar2(1),
                                       tipo varchar2(1),
                                       arrotondamento varchar2(1),
                                       indpres number,
                                       totturni number,
                                       turni t_turni_rec_type,
                                       minimi t_turni_rec_type,
                                       residui t_turni_rec_type,
                                       recuperi t_turni_rec_type
                                       );
  type t_indennita_tab_type is table of t_indennita_rec_type index by pls_integer;
  indennita_tab t_indennita_tab_type;

  i integer;
  t integer;
  j integer;
  num integer; --numero righe di indennita_tab
  x number;
  wCodice varchar2(5);
  idxneg integer;

  cursor c1 is
    select distinct
      add_months(trunc(P_DATA,'mm'),-mod(to_char(add_months(trunc(P_DATA,'mm'),-1),'mm'),T162.NMESI_EQUITURNI)) DAL,
      add_months(add_months(trunc(P_DATA,'mm'),-mod(to_char(add_months(trunc(P_DATA,'mm'),-1),'mm'),T162.NMESI_EQUITURNI)),T162.NMESI_EQUITURNI - 1) AL, 
      T162.CODICE, T162.CODICE2, T162.TIPO, T162.NMESI_EQUITURNI, T162.TURNO1, T162.TURNO2, T162.TURNO3, T162.TURNO4
    from T172_INDPRES_EQUITURNI T172, T162_INDENNITA T162
    where T172.PROGRESSIVO = P_PROGRESSIVO
    and T172.DATA between 
          add_months(trunc(P_DATA,'mm'),-mod(to_char(add_months(trunc(P_DATA,'mm'),-1),'mm'),T162.NMESI_EQUITURNI))
          and
          add_months(add_months(trunc(P_DATA,'mm'),-mod(to_char(add_months(trunc(P_DATA,'mm'),-1),'mm'),T162.NMESI_EQUITURNI)),T162.NMESI_EQUITURNI - 1)
    and T162.CODICE = T172.CODINDPRES
    and T162.TIPO in (/*'A','B',*/'P')
    and T162.CONGUAGLIO_EQUITURNI = 'S';

  cursor c1b is
    select distinct
      add_months(trunc(P_DATA,'mm'),-mod(to_char(add_months(trunc(P_DATA,'mm'),-1),'mm'),T162.NMESI_EQUITURNI)) DAL,
      add_months(add_months(trunc(P_DATA,'mm'),-mod(to_char(add_months(trunc(P_DATA,'mm'),-1),'mm'),T162.NMESI_EQUITURNI)),T162.NMESI_EQUITURNI - 1) AL, 
      T162.TIPO, T162.NMESI_EQUITURNI, decode(nvl(T162.TURNO1,0),0,0,1) TURNO1, decode(nvl(T162.TURNO2,0),0,0,1) TURNO2, decode(nvl(T162.TURNO3,0),0,0,1) TURNO3, decode(nvl(T162.TURNO4,0),0,0,1) TURNO4
    from T172_INDPRES_EQUITURNI T172, T162_INDENNITA T162
    where T172.PROGRESSIVO = P_PROGRESSIVO
    and T172.DATA between 
          add_months(trunc(P_DATA,'mm'),-mod(to_char(add_months(trunc(P_DATA,'mm'),-1),'mm'),T162.NMESI_EQUITURNI))
          and
          add_months(add_months(trunc(P_DATA,'mm'),-mod(to_char(add_months(trunc(P_DATA,'mm'),-1),'mm'),T162.NMESI_EQUITURNI)),T162.NMESI_EQUITURNI - 1)
    and T162.CODICE = T172.CODINDPRES
    and T162.TIPO in (/*'A','B',*/'P')
    and T162.CONGUAGLIO_EQUITURNI = 'S';

  cursor c2(P_DAL date, P_AL date, P_TIPO varchar2, P_NMESI_EQUITURNI number, P_TURNO1 number, P_TURNO2 number, P_TURNO3 number, P_TURNO4 number) is
    select
      T070.DATA,
      T070.TURNI1,T070.TURNI2,T070.TURNI3,T070.TURNI4,
      T070.TURNI1 + T070.TURNI2 + T070.TURNI3 + T070.TURNI4 TOT_TURNI,
      T172.INDPRES,
      T162.CODICE, T162.CODICE2, T162.TIPO, T162.ARROTONDAMENTO,
      T162.TURNO1 MIN1,
      T162.TURNO2 MIN2,
      T162.TURNO3 MIN3,
      T162.TURNO4 MIN4
    from T070_SCHEDARIEPIL T070, T172_INDPRES_EQUITURNI T172, T162_INDENNITA T162
    where T070.PROGRESSIVO = P_PROGRESSIVO
    and T070.DATA between P_DAL and P_AL
    and T172.PROGRESSIVO = T070.PROGRESSIVO
    and T172.DATA = T070.DATA
    and T162.CODICE = T172.CODINDPRES
    and T162.TIPO = P_TIPO
    and T162.NMESI_EQUITURNI = P_NMESI_EQUITURNI
    and T162.CONGUAGLIO_EQUITURNI = 'S'
    and decode(nvl(T162.TURNO1,0),0,0,1) = decode(nvl(P_TURNO1,0),0,0,1)
    and decode(nvl(T162.TURNO2,0),0,0,1) = decode(nvl(P_TURNO2,0),0,0,1)
    and decode(nvl(T162.TURNO3,0),0,0,1) = decode(nvl(P_TURNO3,0),0,0,1)
    and decode(nvl(T162.TURNO4,0),0,0,1) = decode(nvl(P_TURNO4,0),0,0,1)
   order by data,indpres desc;

  function GetIdxMenoNeg(p_regola integer) return integer is
    result integer;
    i integer;
    t integer;
    wTotNeg number;
    wMenoNeg number;
  begin
    result:=0;
    wMenoNeg:=-999;
    for i in 1..num loop
      wTotNeg:=0;
      if (p_regola = 1 and indennita_tab(i).codice is null) or (p_regola = 2 and indennita_tab(i).codice2 is null) then
        indennita_tab(i).stato:='0';
      end if;
      if indennita_tab(i).stato is null then
        for t in 1..4 loop
          if indennita_tab(i).residui(t) < 0 then
            wTotNeg:=wTotNeg + indennita_tab(i).residui(t);
          end if;
        end loop;
        if (wTotNeg < 0) and (wTotNeg > wMenoNeg) then
          result:=i;
          wMenoNeg:=wTotNeg;
        end if;
      end if;
    end loop;
    if result > 0 then
      indennita_tab(result).stato:='-';
    end if;
    return result;
  end;

  procedure EseguiConguaglio(p_regola integer) is
  begin
    --ricerca della riga con meno negativi (ed eventualmente altri criteri più sofisticati)
    idxneg:=GetIdxMenoNeg(p_regola);
    while idxneg <> 0 loop
      --distribuzione dei turni per coprire le carenze della prima regola
      for t in 1..4 loop
        if indennita_tab(idxneg).residui(t) < 0 then
          for j in 1..num loop
            if indennita_tab(j).residui(t) > 0 then
              x:=least(indennita_tab(j).residui(t),abs(indennita_tab(idxneg).residui(t)));
              indennita_tab(j).residui(t):=indennita_tab(j).residui(t) - x;
              indennita_tab(j).turni(t):=indennita_tab(j).turni(t) - x;
              indennita_tab(j).recuperi(t):=x;
              indennita_tab(idxneg).residui(t):=indennita_tab(idxneg).residui(t) + x;
            end if;
          end loop;
        end if;
      end loop;
      for j in 1..num loop
        for t in 1..4 loop
          if (indennita_tab(idxneg).residui(1) < 0) or (indennita_tab(idxneg).residui(2) < 0) or (indennita_tab(idxneg).residui(3) < 0) or (indennita_tab(idxneg).residui(4) < 0) then
            indennita_tab(j).residui(t):=indennita_tab(j).residui(t) + indennita_tab(j).recuperi(t);
            indennita_tab(j).turni(t):=indennita_tab(j).turni(t) + indennita_tab(j).recuperi(t);
            indennita_tab(idxneg).residui(t):=indennita_tab(idxneg).residui(t) - indennita_tab(j).recuperi(t);
          end if;
          indennita_tab(j).recuperi(t):=0;
        end loop;
      end loop;
      --ricerca della riga con meno negativi (ed eventualmente altri criteri più sofisticati)
      idxneg:=GetIdxMenoNeg(p_regola);
    end loop;

    --ricerco le righe ancora negative e cerco di recuperarle con altre righe negative
    for i in 1..num loop
      if indennita_tab(i).stato <> '+' then
        indennita_tab(i).stato:=null;
      end if;
    end loop;

    --ricerca della riga con meno negativi (ed eventualmente altri criteri più sofisticati)
    idxneg:=GetIdxMenoNeg(p_regola);
    while idxneg <> 0 loop
      --distribuzione dei turni per coprire le carenze della prima regola
      for t in 1..4 loop
        if indennita_tab(idxneg).residui(t) < 0 then
          for j in 1..num loop
            if (j <> idxneg) and (indennita_tab(j).turni(t) > 0) and
               ((indennita_tab(j).residui(1) < 0) or (indennita_tab(j).residui(2) < 0) or (indennita_tab(j).residui(3) < 0) or (indennita_tab(j).residui(4) < 0))
            then
              x:=least(indennita_tab(j).turni(t),abs(indennita_tab(idxneg).residui(t)));
              indennita_tab(j).recuperi(t):=x;
              indennita_tab(j).turni(t):=indennita_tab(j).turni(t) - x;
              indennita_tab(j).residui(t):=indennita_tab(j).residui(t) - x;
              indennita_tab(idxneg).residui(t):=indennita_tab(idxneg).residui(t) + x;
            end if;
          end loop;
        end if;
      end loop;
      for j in 1..num loop
        for t in 1..4 loop
          if (indennita_tab(idxneg).residui(1) < 0) or (indennita_tab(idxneg).residui(2) < 0) or (indennita_tab(idxneg).residui(3) < 0) or (indennita_tab(idxneg).residui(4) < 0) then
            indennita_tab(j).turni(t):=indennita_tab(j).turni(t) + indennita_tab(j).recuperi(t);
            indennita_tab(j).residui(t):=indennita_tab(j).residui(t) + indennita_tab(j).recuperi(t);
            indennita_tab(idxneg).residui(t):=indennita_tab(idxneg).residui(t) - indennita_tab(j).recuperi(t);
          end if;
          indennita_tab(j).recuperi(t):=0;
        end loop;
      end loop;
      --ricerca della riga con meno negativi (ed eventualmente altri criteri più sofisticati)
      idxneg:=GetIdxMenoNeg(p_regola);
    end loop;
  end;
begin
  --cancellazione indennità pre-esistenti
  for t1 in c1 loop
    for t2 in c2(t1.DAL,T1.AL,t1.TIPO,t1.NMESI_EQUITURNI,t1.TURNO1,t1.TURNO2,t1.TURNO3,t1.TURNO4) loop
      delete from T072_SCHEDAINDPRES where PROGRESSIVO = P_PROGRESSIVO and DATA between t1.DAL and t1.AL and CODINDPRES in (t2.CODICE,t2.CODICE2) and TIPO_RECORD = 'A';
    end loop;
  end loop;

  --lettura indennità di base presenti nel periodo
  for t1 in c1b loop
    --conguaglio indennità  nel periodo
    indennita_tab.delete;
    i:=0;
    num:=0;
    for t2 in c2(t1.DAL,t1.AL,t1.TIPO,t1.NMESI_EQUITURNI,t1.TURNO1,t1.TURNO2,t1.TURNO3,t1.TURNO4) loop
      --considero solo una riga per mese, non sono ammesse più indennità simili nello stesso mese (dovute a storicizzazioni)
      if (i >= 1) and (t2.DATA = indennita_tab(i).data) then 
        null;--exit;
      end if;  
      i:=i + 1;
      num:=i;
      indennita_tab(i).data:=t2.DATA;
      indennita_tab(i).codice:=t2.CODICE;
      indennita_tab(i).codice2:=t2.CODICE2;
      indennita_tab(i).regola2:='N';
      indennita_tab(i).stato:='+';
      indennita_tab(i).tipo:=t2.TIPO;
      indennita_tab(i).arrotondamento:=t2.ARROTONDAMENTO;
      indennita_tab(i).indpres:=replace(t2.INDPRES,' ','');
      indennita_tab(i).totturni:=t2.TOT_TURNI;
      indennita_tab(i).turni(1):=t2.TURNI1;
      indennita_tab(i).turni(2):=t2.TURNI2;
      indennita_tab(i).turni(3):=t2.TURNI3;
      indennita_tab(i).turni(4):=t2.TURNI4;
      indennita_tab(i).minimi(1):=t2.MIN1;
      indennita_tab(i).minimi(2):=t2.MIN2;
      indennita_tab(i).minimi(3):=t2.MIN3;
      indennita_tab(i).minimi(4):=t2.MIN4;
      if t2.TIPO = 'P' then
        indennita_tab(i).residui(1):=t2.TOT_TURNI * t2.MIN1 / 100;
        indennita_tab(i).residui(2):=t2.TOT_TURNI * t2.MIN2 / 100;
        indennita_tab(i).residui(3):=t2.TOT_TURNI * t2.MIN3 / 100;
        indennita_tab(i).residui(4):=t2.TOT_TURNI * t2.MIN4 / 100;
        for j in 1..4 loop
          if t2.ARROTONDAMENTO = 'P' then
            indennita_tab(i).residui(j):=round(indennita_tab(i).residui(j));
          elsif t2.ARROTONDAMENTO = 'E' then
            indennita_tab(i).residui(j):=ceil(indennita_tab(i).residui(j));
          elsif t2.ARROTONDAMENTO = 'D' then
            indennita_tab(i).residui(j):=floor(indennita_tab(i).residui(j));
          end if;
        end loop;
        indennita_tab(i).residui(1):=t2.TURNI1 - indennita_tab(i).residui(1);
        indennita_tab(i).residui(2):=t2.TURNI2 - indennita_tab(i).residui(2);
        indennita_tab(i).residui(3):=t2.TURNI3 - indennita_tab(i).residui(3);
        indennita_tab(i).residui(4):=t2.TURNI4 - indennita_tab(i).residui(4);
        indennita_tab(i).recuperi(1):=0;
        indennita_tab(i).recuperi(2):=0;
        indennita_tab(i).recuperi(3):=0;
        indennita_tab(i).recuperi(4):=0;
        if (indennita_tab(i).residui(1) < 0) or (indennita_tab(i).residui(2) < 0) or (indennita_tab(i).residui(3) < 0) or (indennita_tab(i).residui(4) < 0) then
          indennita_tab(i).stato:=null;
        end if;
      end if;
    end loop;

    EseguiConguaglio(1);

    --applicazione della seconda regola: ricerca dei turni negativi e lettura regole della seconda indennità  
    for i in 1..num loop
      if (indennita_tab(i).codice2 is not null) and
         ((indennita_tab(i).residui(1) < 0) or (indennita_tab(i).residui(2) < 0) or (indennita_tab(i).residui(3) < 0) or (indennita_tab(i).residui(4) < 0)) then
        begin
          wCodice:=indennita_tab(i).codice;
          select T162.CODICE, T162.TIPO, T162.ARROTONDAMENTO, T162.TURNO1, T162.TURNO2, T162.TURNO3, T162.TURNO4
          into indennita_tab(i).codice, indennita_tab(i).tipo, indennita_tab(i).arrotondamento, indennita_tab(i).minimi(1), indennita_tab(i).minimi(2), indennita_tab(i).minimi(3), indennita_tab(i).minimi(4)
          from T162_INDENNITA T162
          where CODICE = indennita_tab(i).codice2;
          indennita_tab(i).codice2:=wCodice;
          indennita_tab(i).regola2:='S';
          indennita_tab(i).stato:='+';
          if indennita_tab(i).tipo = 'P' then
            indennita_tab(i).residui(1):=indennita_tab(i).totturni * indennita_tab(i).minimi(1) / 100;
            indennita_tab(i).residui(2):=indennita_tab(i).totturni * indennita_tab(i).minimi(2) / 100;
            indennita_tab(i).residui(3):=indennita_tab(i).totturni * indennita_tab(i).minimi(3) / 100;
            indennita_tab(i).residui(4):=indennita_tab(i).totturni * indennita_tab(i).minimi(4) / 100;
            for j in 1..4 loop
              if indennita_tab(i).arrotondamento = 'P' then
                indennita_tab(i).residui(j):=round(indennita_tab(i).residui(j));
              elsif indennita_tab(i).arrotondamento = 'E' then
                indennita_tab(i).residui(j):=ceil(indennita_tab(i).residui(j));
              elsif indennita_tab(i).arrotondamento = 'D' then
                indennita_tab(i).residui(j):=floor(indennita_tab(i).residui(j));
              end if;
            end loop;
            indennita_tab(i).residui(1):=indennita_tab(i).turni(1) - indennita_tab(i).residui(1);
            indennita_tab(i).residui(2):=indennita_tab(i).turni(2) - indennita_tab(i).residui(2);
            indennita_tab(i).residui(3):=indennita_tab(i).turni(3) - indennita_tab(i).residui(3);
            indennita_tab(i).residui(4):=indennita_tab(i).turni(4) - indennita_tab(i).residui(4);
            indennita_tab(i).recuperi(1):=0;
            indennita_tab(i).recuperi(2):=0;
            indennita_tab(i).recuperi(3):=0;
            indennita_tab(i).recuperi(4):=0;
            if (indennita_tab(i).residui(1) < 0) or (indennita_tab(i).residui(2) < 0) or (indennita_tab(i).residui(3) < 0) or (indennita_tab(i).residui(4) < 0) then
              indennita_tab(i).stato:=null;
            end if;
          end if;
        exception
          when others then
            indennita_tab(i).codice:=null;
            indennita_tab(i).codice2:=null;
        end;
      else
        indennita_tab(i).stato:='+';
      end if;
    end loop;

    EseguiConguaglio(2);

    --scrittura delle indennità maturate
    for i in 1..num loop
      begin
        if (indennita_tab(i).residui(1) >= 0) and (indennita_tab(i).residui(2) >= 0) and (indennita_tab(i).residui(3) >= 0) and (indennita_tab(i).residui(4) >= 0) then
        begin
          insert into T072_SCHEDAINDPRES (PROGRESSIVO,DATA,CODINDPRES,INDPRES,TIPO_RECORD/*,STATO,REGOLA2*/)
          values (P_PROGRESSIVO,indennita_tab(i).data,indennita_tab(i).codice,indennita_tab(i).indpres,'A'/*,'I',indennita_tab(i).regola2*/);
        exception
          when dup_val_on_index then
            update T072_SCHEDAINDPRES
            set INDPRES = INDPRES + indennita_tab(i).indpres
            where PROGRESSIVO = P_PROGRESSIVO
            and DATA = indennita_tab(i).data
            and CODINDPRES = indennita_tab(i).codice
            and TIPO_RECORD = 'A';
        end;
        end if;
      end;
    end loop;
  end loop;
end;
/