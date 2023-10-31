create or replace function MEDPF_HTTP_POST(P_URL in varchar2, P_CONTENT in clob, P_CONTENT_TYPE in varchar2) return clob is
  V_REQUEST         UTL_HTTP.req;
  V_RESPONSE        UTL_HTTP.resp;
  V_CONTENT_LENGTH  number;
  V_REQBUFFER       varchar2(32767);
  V_RESBUFFER       varchar2(32767);
  V_AMOUNT          number:=25000;
  V_OFFSET          number:=1;
  RESULT            clob;
/*Per utilizzarla:
-- la prima volta grant + creazione access control list
grant execute on utl_http to mondoedp;
grant execute on dbms_lock to mondoedp;
 
BEGIN
  DBMS_NETWORK_ACL_ADMIN.create_acl (
    acl          => 'local_sx_acl_file.xml', 
    description  => 'MEDPF_HTTP_POST',
    principal    => 'MONDOEDP',
    is_grant     => TRUE, 
    privilege    => 'connect',
    start_date   => SYSTIMESTAMP,
    end_date     => NULL);
end;
 
/ 
-- poi abilitare l'accesso ai singoli host + porta all'interno della acl creata
begin
  DBMS_NETWORK_ACL_ADMIN.assign_acl (
    acl         => 'local_sx_acl_file.xml',
    host        => '172.18.253.20', 
    lower_port  => 8080,
    upper_port  => NULL);    
end;

/
*/  
begin
  V_CONTENT_LENGTH:=DBMS_LOB.getlength(P_CONTENT);

  UTL_HTTP.set_response_error_check(enable => true);
  UTL_HTTP.set_detailed_excp_support(enable => true);

  V_REQUEST:=UTL_HTTP.begin_request(P_URL, 'POST');

  UTL_HTTP.set_header(r => V_REQUEST, name => 'Content-Type', value => P_CONTENT_TYPE);
  -- UTL_HTTP.SET_BODY_CHARSET('UTF-8');

  if V_CONTENT_LENGTH<=32767 then      --If Message data under 32kb limit
    UTL_HTTP.set_header(V_REQUEST, 'Content-Length', V_CONTENT_LENGTH);
    UTL_HTTP.write_text(V_REQUEST, P_CONTENT);
  elsif V_CONTENT_LENGTH > 32767 then  -- If Message data more than 32kb
    UTL_HTTP.set_header (V_REQUEST , 'Transfer-Encoding', 'chunked');

    while (V_OFFSET < V_CONTENT_LENGTH) loop
      DBMS_LOB.read(P_CONTENT, V_AMOUNT, V_OFFSET, V_REQBUFFER);
      UTL_HTTP.write_text (V_REQUEST, V_REQBUFFER);
      V_OFFSET:=V_OFFSET + V_AMOUNT;
    end loop;
  end if;

  V_RESPONSE:=UTL_HTTP.get_response(V_REQUEST);
  DBMS_LOB.createtemporary(RESULT, false);
  begin
    loop
      UTL_HTTP.read_text(V_RESPONSE, V_RESBUFFER, 32000);
      DBMS_LOB.writeappend(RESULT, length(V_RESBUFFER), V_RESBUFFER);
    end loop;
  exception
    when UTL_HTTP.end_of_body then
      UTL_HTTP.end_response(V_RESPONSE);
  end;

  return(RESULT);
end MEDPF_HTTP_POST/*--NOLOG--*/;
/
