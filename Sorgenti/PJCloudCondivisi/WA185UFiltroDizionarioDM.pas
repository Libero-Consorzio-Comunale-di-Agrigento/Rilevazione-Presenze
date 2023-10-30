unit WA185UFiltroDizionarioDM;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData, Oracle, C180FunzioniGenerali,
  A000UInterfaccia, WR302UGestTabellaDM, WR300UBaseDM, DBClient,
  A000UCostanti, A000USessione, L021Call, QueryPK, IWCompListBox, A000UMessaggi,
  A185UFiltroDizionarioMW;

type
  TWA185FFiltroDizionarioDM = class(TWR302FGestTabellaDM)
    selI074: TOracleDataSet;
    dsrI074: TDataSource;
    selDizionario: TOracleDataSet;
    DbIris008B: TOracleSession;
    D090: TDataSource;
    QI090: TOracleDataSet;
    selPermessi: TOracleDataSet;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure selTabellaAfterOpen(DataSet: TDataSet);
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure dsrI074StateChange(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure selDizionarioBeforeOpen(DataSet: TDataSet);
  private
    VecchiaAzienda:String;
    A185MW:TA185FFiltroDizionarioMW;
  public
    procedure PutFiltroDizionario;
    function ProfiloUtilizzato:Boolean;
  end;

implementation

uses
  WA185UFiltroDizionario, WA185UFiltroDizionarioDettFM;

{$R *.dfm}

procedure TWA185FFiltroDizionarioDM.dsrI074StateChange(Sender: TObject);
begin
  inherited;

  if TWA185FFiltroDizionarioDettFM(TWA185FFiltroDizionario(Self.Owner).WDettaglioFM) <> nil then
    with TWA185FFiltroDizionarioDettFM(TWA185FFiltroDizionario(Self.Owner).WDettaglioFM)do
    begin
      abilitaAllComponenti(selI074);
      TWA185FFiltroDizionario(Self.Owner).selTabellaStateChange(selI074);
    end;

end;

procedure TWA185FFiltroDizionarioDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY AZIENDA,PROFILO');
  NonAprireSelTabella:=True;
  VecchiaAzienda:='';
  inherited;

  A185MW:=TA185FFiltroDizionarioMW.Create(nil);
  if Parametri.Applicazione = '' then
    Parametri.Applicazione:='RILPRE';
  if Parametri.Azienda <> 'AZIN' then
  begin
    selTabella.Filter:='AZIENDA = ''' + Parametri.Azienda + '''';
    selTabella.Filtered:=True;
    QI090.Filter:='AZIENDA = ''' + Parametri.Azienda + '''';
    QI090.Filtered:=True;
  end;
  QI090.Open;
  selTabella.Open;
  if selTabella.RecordCount = 0 then
    selTabella.AfterScroll(selTabella);
end;


procedure TWA185FFiltroDizionarioDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(A185MW);
end;

procedure TWA185FFiltroDizionarioDM.AfterScroll(DataSet: TDataSet);
begin
  selI074.Close;
  selI074.SetVariable('AZIENDA',selTabella.FieldByName('AZIENDA').AsString);
  selI074.SetVariable('PROFILO',selTabella.FieldByName('PROFILO').AsString);
  selI074.Open;

  //Apertura del database indicato dall'Azienda
  if selTabella.FieldByName('AZIENDA').AsString <> VecchiaAzienda then
  begin
    VecchiaAzienda:=selTabella.FieldByName('AZIENDA').AsString;
    if QI090.SearchRecord('AZIENDA',selTabella.FieldByName('AZIENDA').AsString,[srFromBeginning]) then
      with DbIris008B do
      begin
        if (not Connected) or
           (UpperCase(LogonUserName) <> UpperCase(QI090.FieldByName('UTENTE').AsString)) then
        begin
          Logoff;
          LogonDataBase:=Parametri.Database;
          LogonUserName:=QI090.FieldByName('UTENTE').AsString;
          LogonPassword:=R180Decripta(QI090.FieldByName('PAROLACHIAVE').AsString,21041974);
          Preferences.UseOCI7:=False;
          BytesPerCharacter:=bc1Byte;
        end;
        {$IFDEF IRISWEB}
          ThreadSafe:=True;
        {$ENDIF}
        Logon;
        TWA185FFiltroDizionario(Self.Owner).MessaggioStatus(INFORMA,'');
        selDizionario.Open;
      end;
  end;

  inherited;
end;

procedure TWA185FFiltroDizionarioDM.PutFiltroDizionario;
{Registrazione dei codici di dizionari selezionati}
var i:Integer;
    Azienda, Profilo:String;
    State:TDataSetState;
    Inserito,ControlloChiave:Boolean;
begin
  if TWA185FFiltroDizionarioDettFM(TWA185FFiltroDizionario(Self.Owner).WDettaglioFM) <> nil then
    with TWA185FFiltroDizionarioDettFM(TWA185FFiltroDizionario(Self.Owner).WDettaglioFM)do
    begin
      Azienda:=selI074.FieldByName('AZIENDA').Value;
      Profilo:=selI074.FieldByName('PROFILO').Value;

      State:=selI074.State;

      ControlloChiave:=(selI074.State = dsInsert) or
                       ((selI074.State = dsEdit) and ((Azienda <> selTabella.FieldByName('AZIENDA').AsString) or (Profilo <> selTabella.FieldByName('PROFILO').AsString)));
      if ControlloChiave then
        with TQueryPK.Create(Self) do
        try
          Session:=SessioneOracle;
          if EsisteChiave('MONDOEDP.I074_FILTRODIZIONARIO','',State,['AZIENDA','PROFILO'],[Azienda,Profilo]) then
            raise Exception.Create(A000MSG_ERR_CHIAVE_DUPLICATA);
        finally
          Free;
        end;

      if (selI074.State = dsEdit) and ((Azienda <> selTabella.FieldByName('AZIENDA').AsString) or (Profilo <> selTabella.FieldByName('PROFILO').AsString)) then
        if ProfiloUtilizzato then
          raise Exception.Create(A000MSG_ERR_MODIFICA_PROFILO);

      A185MW.GetI074(A185MW.selI074Before,
                     Azienda,
                     Profilo,
                     cmbDizionario.Text);

      if State <> dsInsert then
      begin
        selI074.First;
        while not selI074.Eof do
          if selI074.FieldByName('TABELLA').AsString = cmbDizionario.Text then
            selI074.Delete
          else
            if (selI074.FieldByName('PROFILO').AsString <> Profilo)
            or (selI074.FieldByName('AZIENDA').AsString <> Azienda) then
            begin
              selI074.Edit;
              selI074.FieldByName('AZIENDA').AsString:=Azienda;
              selI074.FieldByName('PROFILO').AsString:=Profilo;
              selI074.Post;
            end
            else
              selI074.Next;
      end
      else
      begin
        selI074.Cancel;
        selI074.Append;
        selI074.FieldByName('AZIENDA').AsString:=Azienda;
        selI074.FieldByName('PROFILO').AsString:=Profilo;
        selI074.FieldByName('TABELLA').AsString:='DIZIONARIO';
        selI074.FieldByName('CODICE').AsString:='DIZIONARIO';
        selI074.Post;
      end;

      Inserito:=False;
      for i:=0 to cgpDizionario.Items.Count - 1 do
        if cgpDizionario.IsChecked[i] then
        begin
        (*CARATTO.
          se insert nella insert precendete fa cancel e append.
          quindi devo rifare append altrimenti dataset non in edit
        *)
//          if State <> dsInsert then
          Inserito:=True;
          selI074.Append;
          selI074.FieldByName('AZIENDA').AsString:=Azienda;
          selI074.FieldByName('PROFILO').AsString:=Profilo;
          selI074.FieldByName('TABELLA').AsString:=cmbDizionario.Text;
          {if cmbDizionario.text <> 'ANOMALIE DEI CONTEGGI' then
            selI074.FieldByName('CODICE').AsString:=cgpDizionario.Items[i]
          else
            selI074.FieldByName('CODICE').AsString:=Trim(Copy(cgpDizionario.Items[i],1,5));}
          if cmbDizionario.text = 'ANOMALIE DEI CONTEGGI' then
            selI074.FieldByName('CODICE').AsString:=Trim(Copy(cgpDizionario.Items[i],1,5))
          else if cmbDizionario.text = 'ITER AUTORIZZATIVI' then
            selI074.FieldByName('CODICE').AsString:=A000GetCodIter(cgpDizionario.Items[i])
          else
            selI074.FieldByName('CODICE').AsString:=cgpDizionario.Items[i];
          if rgpModalitaFiltro.ItemIndex = 0 then
            selI074.FieldByName('ABILITATO').AsString:='S'
          else
            selI074.FieldByName('ABILITATO').AsString:='N';
          selI074.Post;
        end;
      if (not Inserito) and (rgpModalitaFiltro.ItemIndex = 0) then
      begin
        selI074.Append;
        selI074.FieldByName('AZIENDA').AsString:=Azienda;
        selI074.FieldByName('PROFILO').AsString:=Profilo;
        selI074.FieldByName('TABELLA').AsString:=cmbDizionario.Text;
        selI074.FieldByName('CODICE').AsString:='DIZIONARIO DISABILITATO';
        selI074.FieldByName('ABILITATO').AsString:='S';
        selI074.Post;
      end;
      A185MW.GetI074(A185MW.selI074After,
                     Azienda,
                     Profilo,
                     cmbDizionario.Text);
      A185MW.ConfrontaFiltroDizionario('WA185');
      SessioneOracle.Commit;
    end;
end;

procedure TWA185FFiltroDizionarioDM.selDizionarioBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  selDizionario.SQL.Text:='select * from (' + A000selDizionario + A000selDizionarioDatiAziendali(selDizionario.Session) + A000selDizionarioSicurezzaRiepiloghi;
  selDizionario.SQL.Add(') ORDER BY TABELLA, upper(CODICE)');
end;

procedure TWA185FFiltroDizionarioDM.selTabellaAfterOpen(DataSet: TDataSet);
begin
  inherited;
  selTabella.FieldByName('AZIENDA').Index:=0;
  selTabella.FieldByName('PROFILO').Index:=1;
  selTabella.FieldByName('DIZIONARI_IMPOSTATI').Index:=2;
  selTabella.FieldByName('AZIENDA').DisplayLabel:='Azienda';
  selTabella.FieldByName('PROFILO').DisplayLabel:='Profilo';
  selTabella.FieldByName('DIZIONARI_IMPOSTATI').DisplayLabel:='Dizionari impostati';
end;


function TWA185FFiltroDizionarioDM.ProfiloUtilizzato:Boolean;
begin
  with selPermessi do
  begin
    Close;
    SetVariable('AZIENDA',selTabella.FieldByName('AZIENDA').AsString);
    SetVariable('PROFILO',selTabella.FieldByName('PROFILO').AsString);
    Open;
    Result:=RecordCount > 0;
    Close;
  end;
end;

end.
