unit WA187UAccessiDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData, Oracle, C180FunzioniGenerali, DBClient, IWCompListBox,
  A000UCostanti, A000USessione, A000UInterfaccia,
  WR300UBaseDM, WR302UGestTabellaDM, WR303UGestMasterDetailDM,
  L021Call, medpIWMessageDlg;

type
  TWA187FAccessiDM = class(TWR303FGestMasterDetailDM)
    dsrVSESSION: TDataSource;
    selVSESSION: TOracleDataSet;
    selVSESSIONSID: TFloatField;
    selVSESSIONSERIAL: TFloatField;
    selVSESSIONSTATUS: TStringField;
    selVSESSIONUSERNAME: TStringField;
    selVSESSIONOSUSER: TStringField;
    selVSESSIONMACHINE: TStringField;
    selVSESSIONTERMINAL: TStringField;
    selVSESSIONPROGRAM: TStringField;
    OperSQL: TOracleQuery;
    cdsVSESSION: TClientDataSet;
    selTabellaAZIENDA: TStringField;
    selTabellaUTENTE: TStringField;
    selTabellaACCESSO_NEGATO: TStringField;
    selTabellaPROGRESSIVO: TIntegerField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
  protected
    procedure RelazionaTabelleFiglie; override;
  private
  public
  end;

implementation

{$R *.dfm}

procedure TWA187FAccessiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY AZIENDA,UTENTE');
  selVSESSION.SetVariable('ORDERBY','ORDER BY OSUSER,MACHINE,TERMINAL,PROGRAM');
  if Parametri.Applicazione = '' then
    Parametri.Applicazione:='RILPRE';
  if Parametri.Azienda <> 'AZIN' then
  begin
    selTabella.Filter:='AZIENDA = ''' + Parametri.Azienda + '''';
    selTabella.Filtered:=True;
    selVSESSION.Filter:='USERNAME = ''' + Parametri.Username + '''';
    selVSESSION.Filtered:=True;
  end;
  inherited;
  try
    selVSESSION.Open;
  except
    selVSESSION.SQL.Clear;
    selVSESSION.SQL.Add('select SID,SERIAL#,STATUS,USERNAME,OSUSER,MACHINE,TERMINAL,PROGRAM');
    selVSESSION.SQL.Add('from');
    selVSESSION.SQL.Add('(select to_number(null) SID,to_number(null) SERIAL#,to_char(null) STATUS,to_char(null) USERNAME,to_char(null) OSUSER,to_char(null) MACHINE,to_char(null) TERMINAL,to_char(null) PROGRAM from dual)');
    selVSESSION.SQL.Add(':ORDERBY');
    selVSESSION.Open;
  end;
end;

procedure TWA187FAccessiDM.RelazionaTabelleFiglie;
begin
end;

end.
