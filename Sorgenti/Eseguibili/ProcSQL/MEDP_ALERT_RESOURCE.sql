create or replace procedure MEDP_ALERT_RESOURCE(p_to in varchar2) is
  p_message varchar2(2000);
  p_message_risorse varchar2(2000);
  p_message_tablespace varchar2(2000);
  p_subject varchar2(200);
  p_send boolean;
  p_send_risorse boolean;
  p_send_tablespace boolean;

  cursor utilizzo is
    select upper(T.RESOURCE_NAME) NOME, T.CURRENT_UTILIZATION CORRENTE, T.MAX_UTILIZATION MASSIMO, T.LIMIT_VALUE LIMITE
    from V$RESOURCE_LIMIT T
    where upper(RESOURCE_NAME) in ('PROCESSES','SESSIONS')
    and (LIMIT_VALUE - CURRENT_UTILIZATION) < (LIMIT_VALUE*0.05);
            
  cursor spazio_libero is
    select * from MONDOEDP.I300_TABLESPACE_FREESPACE I300 
    where I300.TABLESPACE in (select distinct TABLESPACE_NAME from DBA_DATA_FILES where AUTOEXTENSIBLE <> 'YES')
    and (SPAZIO_LIBERO) < 100; 
       
begin  
  p_subject:='IrisWIN - Criticita'' utilizzo risorse';  
  p_message:='';
  p_message_risorse:='>> Utilizzo delle risorse: ';
  p_message_tablespace:='>> Spazio libero nei tablespace Oracle in esaurimento: ';
  p_send:=false;
  p_send_risorse:=false;
  p_send_tablespace:=false;

  for tt in utilizzo loop
     if p_send_risorse then
        p_message_risorse:=p_message_risorse || ' ' || UTL_TCP.crlf || '---------------------------' ;
     else
        p_message_risorse:=p_message_risorse || ' ' || UTL_TCP.crlf;
     end if;
     p_send_risorse:=True;
     p_message_risorse:=p_message_risorse || ' ' || UTL_TCP.crlf || 'RESOURCE_NAME:   ' || tt.NOME;
     p_message_risorse:=p_message_risorse || ' ' || UTL_TCP.crlf || 'CURR_UTILIZATION:' || tt.CORRENTE;
     p_message_risorse:=p_message_risorse || ' ' || UTL_TCP.crlf || 'MAX_UTILIZATION: ' || tt.MASSIMO;
     p_message_risorse:=p_message_risorse || ' ' || UTL_TCP.crlf || 'LIMIT_VALUE:     ' || TRIM(tt.LIMITE);
  end loop;
    
  for ii in spazio_libero loop
     if p_send_tablespace then
        p_message_tablespace:=p_message_tablespace || ' ' || UTL_TCP.crlf || '---------------------------' ;
     else
        p_message_tablespace:=p_message_tablespace || ' ' || UTL_TCP.crlf;
     end if;
     p_send_tablespace:=True;
     p_message_tablespace:=p_message_tablespace || ' ' || UTL_TCP.crlf || 'TABLESPACE:      ' || ii.TABLESPACE;
     p_message_tablespace:=p_message_tablespace || ' ' || UTL_TCP.crlf || 'SPAZIO_LIBERO:   ' || TRUNC(ii.SPAZIO_LIBERO) || ' MB';
     p_message_tablespace:=p_message_tablespace || ' ' || UTL_TCP.crlf || 'LIMITE_MINIMO:   ' || '100 MB';
  end loop;
  
  p_send:=p_send_risorse or p_send_tablespace;
  
  if p_send_risorse and p_send_tablespace then    
     p_message:=p_message_risorse || UTL_TCP.crlf || UTL_TCP.crlf || p_message_tablespace;
  elsif p_send_risorse then
     p_message:=p_message_risorse;
  elsif p_send_tablespace then
     p_message:=p_message_tablespace;
  end if;
  
  if p_send then
    insert into t280_messaggiweb 
       (progressivo, data, mittente, testo, titolo, flag, log, email, email_cc, email_ccn, categoria) 
    values 
       (null, sysdate(), 'MEDP_ALERT_RESOURCE', p_message, p_subject, '3', null, p_to, null, null, 'alert resource');
    commit;
  end if;
end MEDP_ALERT_RESOURCE/*--NOLOG--*/;
/