create procedure T040P_TRIGGER_BEFORE(
  P_Scarico in varchar2,
  P_Progressivo in integer,
  P_Causale in varchar2, P_TipoGiust in varchar2,
  P_DaData in date,P_AData in date,
  P_DaOre in varchar2,P_AOre in varchar2,P_Familiare in date,
  P_Valida in out varchar2) as
begin
  P_Valida:='S';  
end T040P_TRIGGER_BEFORE;
/
