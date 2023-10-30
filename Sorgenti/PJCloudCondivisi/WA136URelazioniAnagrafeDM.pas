unit WA136URelazioniAnagrafeDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR302UGestTabellaDM, DBClient, DB, OracleData, A136URelazioniAnagrafeMW,
  WR100UBase, A000UMessaggi, C180FunzioniGenerali,A000UInterfaccia;

type
  TWA136FRelazioniAnagrafeDM = class(TWR302FGestTabellaDM)
    selTabellaTABELLA: TStringField;
    selTabellaCOLONNA: TStringField;
    selTabellaDECORRENZA: TDateTimeField;
    selTabellaDECORRENZA_FINE: TDateTimeField;
    selTabellaORDINE: TIntegerField;
    selTabellaTIPO: TStringField;
    selTabellaD_TIPO: TStringField;
    selTabellaTAB_ORIGINE: TStringField;
    selTabellaCOL_ORIGINE: TStringField;
    procedure selTabellaCalcFields(DataSet: TDataSet);
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure BeforePost(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure AfterPost(DataSet: TDataSet); override;
  private
  public
    A136FRelazioniAnagrafeMW: TA136FRelazioniAnagrafeMW;
    DettaglioRelazione: TStringList;
  end;

implementation

uses WA136URelazioniAnagrafe;

{$R *.dfm}

procedure TWA136FRelazioniAnagrafeDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;

  if not A136FRelazioniAnagrafeMW.VerificaCampiAbilitati((Self.Owner as TWA136FRelazioniAnagrafe).SolaLettura) then
  begin
    MsgBox.MessageBox(A000MSG_A136_ERR_UTENTE_NO_CAMPO,ERRORE);
    Abort;
  end;
end;

procedure TWA136FRelazioniAnagrafeDM.BeforePost(DataSet: TDataSet);
var
  bFound: Boolean;
  i: Integer;
begin
  inherited;

  if selTabella.FieldByName('TABELLA').AsString = '' then
  begin
    MsgBox.MessageBox(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,['Tabella']),ERRORE);
    Abort;
  end;

  if selTabella.FieldByName('COLONNA').AsString ='' then
  begin
    MsgBox.MessageBox(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,['Colonna']),ERRORE);
    Abort;
  end;

  A136FRelazioniAnagrafeMW.SelCols.Close;
  A136FRelazioniAnagrafeMW.SelCols.SetVariable('TABELLA',selTabella.FieldByName('TABELLA').AsString);
  A136FRelazioniAnagrafeMW.SelCols.SetVariable('PILOTA','S');
  A136FRelazioniAnagrafeMW.SelCols.Open;

  if VarToStr(A136FRelazioniAnagrafeMW.SelCols.Lookup('COLUMN_NAME',selTabella.FieldByName('COLONNA').AsString,'COLUMN_NAME')) <> selTabella.FieldByName('COLONNA').AsString then
  begin
    MsgBox.MessageBox(Format(A000MSG_ERR_FMT_DATO_ELEM_LISTA,['Colonna']),ERRORE);
    Abort;
  end;

  if not A136FRelazioniAnagrafeMW.VerificaCampiAbilitati((Self.Owner as TWA136FRelazioniAnagrafe).SolaLettura) then
  begin
    MsgBox.MessageBox(A000MSG_A136_ERR_UTENTE_NO_CAMPO,ERRORE);
    Abort;
  end;
  bFound:=False;
  for i:=0 to Length(A136FRelazioniAnagrafeMW.TipiRelazione) - 1 do
    if selTabella.FieldByName('TIPO').AsString = A136FRelazioniAnagrafeMW.TipiRelazione[i] then
      bFound:=True;

  if not bFound then
  begin
    MsgBox.MessageBox(Format(A000MSG_ERR_FMT_DATO_ELEM_LISTA,['Tipo']),ERRORE);
    Abort;
  end;

  if (selTabella.FieldByName('TIPO').AsString = 'F') and
     (selTabella.FieldByName('TABELLA').AsString <> selTabella.FieldByName('TAB_ORIGINE').AsString) then
  begin
    MsgBox.MessageBox(A000MSG_A136_ERR_TAB_DIVERSE,ERRORE);
    Abort;
  end;

  //Eliminazione record collegati su I035
  if selTabella.State = dsEdit then
    A136FRelazioniAnagrafeMW.CancellaI035;
end;

procedure TWA136FRelazioniAnagrafeDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY I030.TABELLA, I030.ORDINE, I030.COLONNA, I030.DECORRENZA, I030.TIPO');
  A136FRelazioniAnagrafeMW:=TA136FRelazioniAnagrafeMW.Create(Self);
  A136FRelazioniAnagrafeMW.selI030_Funzioni:=selTabella;
  inherited;
end;

procedure TWA136FRelazioniAnagrafeDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  inherited;
  selTabella.FieldByName('D_TIPO').AsString:=A136FRelazioniAnagrafeMW.DescrizioneTipo(selTabella.FieldByName('TIPO').AsString);
  A136FRelazioniAnagrafeMW.ImpostaColonnaOrigine;
  //verifica campi abiltiati. richiama funzione ImpostaMsgWarning in caso le colonne non siano definite
  A136FRelazioniAnagrafeMW.VerificaCampiAbilitati((Self.Owner as TWA136FRelazioniAnagrafe).SolaLettura);
end;

procedure TWA136FRelazioniAnagrafeDM.AfterPost(DataSet: TDataSet);
begin
  A136FRelazioniAnagrafeMW.InserisciI035(DettaglioRelazione);
  A136FRelazioniAnagrafeMW.SettaselI035;
  DettaglioRelazione:=A136FRelazioniAnagrafeMW.LeggiI035;
  inherited;
  (Self.Owner as TWA136FRelazioniAnagrafe).SegnalaAnomaliaOrdine; //Quando confermo un intervento sulla relazione
end;

procedure TWA136FRelazioniAnagrafeDM.AfterScroll(DataSet: TDataSet);
begin
  //sincronizzazione selI035 con selTabella
  A136FRelazioniAnagrafeMW.SettaselI035;
  DettaglioRelazione:=A136FRelazioniAnagrafeMW.LeggiI035;
  inherited;
end;

end.
