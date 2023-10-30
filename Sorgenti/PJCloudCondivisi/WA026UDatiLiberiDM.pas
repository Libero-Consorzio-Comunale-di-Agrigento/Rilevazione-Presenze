unit WA026UDatiLiberiDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData, Oracle, C180FunzioniGenerali,
  A000UInterfaccia, A026UDatiLiberiMW, WR302UGestTabellaDM, WR300UBaseDM, DBClient, meIWEdit,
  medpIWMessageDlg, A000UMessaggi;

type
  TWA026FDatiLiberiDM = class(TWR302FGestTabellaDM)
    selTabellaNomeCampo: TStringField;
    selTabellaProgressivo: TFloatField;
    selTabellaTABELLA: TStringField;
    selTabellaLUNGHEZZA: TFloatField;
    selTabellaFORMATO: TStringField;
    selTabellaSTORICO: TStringField;
    selTabellaLUNG_DESC: TFloatField;
    selTabellaSCADENZA: TStringField;
    selT033: TOracleDataSet;
    selTabellaSTORICIZZABILE: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure AfterDelete(DataSet: TDataSet); override;
    procedure AfterPost(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure IWUserSessionBaseDestroy(Sender: TObject);
  private
    procedure CheckBeforePost_selTabella(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure CheckBeforeDelete_selTabella(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
  public
    A026FDatiLiberiMW:TA026FDatiLiberiMW;
    Ricostruzione:Boolean;
  end;

implementation

uses WA026UDatiLiberi, WA026UDatiLiberiDettFM, WR100UBase;

{$R *.dfm}

procedure TWA026FDatiLiberiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY NOMECAMPO');
  inherited;
  A026FDatiLiberiMW:=TA026FDatiLiberiMW.Create(Owner);
  A026FDatiLiberiMW.ScriviStatusBar:=nil;
  A026FDatiLiberiMW.ResettaProgressBar:=nil;
  A026FDatiLiberiMW.IncrementaProgressBar:=nil;
  A026FDatiLiberiMW.MaxProgressBar:=nil;
  A026FDatiLiberiMW.DS:=selTabella;
end;

procedure TWA026FDatiLiberiDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A026FDatiLiberiMW);
  inherited;
end;

procedure TWA026FDatiLiberiDM.AfterDelete(DataSet: TDataSet);
begin
  inherited;
  MsgBox.WebMessageDlg(A000MSG_MSG_CANCELLAZIONE_AVVENUTA,mtInformation,[mbOk],nil,'');
  MsgBox.ClearKeys;
  A026FDatiLiberiMW.CostruisciV430;
  Ricostruzione:=True;
end;

procedure TWA026FDatiLiberiDM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  MsgBox.ClearKeys;
  A026FDatiLiberiMW.CostruisciV430;
  Ricostruzione:=True;
end;

procedure TWA026FDatiLiberiDM.BeforeDelete(DataSet: TDataSet);
begin
  if not MsgBox.KeyExists('PUNTO_1') then
  begin
    MsgBox.WebMessageDlg(A000MSG_A026_DLG_CANCELLA,
             mtConfirmation,[mbYes,mbNo],CheckBeforeDelete_selTabella,'PUNTO_1');
    Abort;
  end;

  if not MsgBox.KeyExists('PUNTO_2') then
  begin
    try
      A026FDatiLiberiMW.selI091.Close;
      A026FDatiLiberiMW.selI091.SetVariable('AZIENDA',Parametri.Azienda);
      A026FDatiLiberiMW.selI091.Open;
    except
    end;
    if A026FDatiLiberiMW.selI091.Active and A026FDatiLiberiMW.selI091.SearchRecord('DATO',selTabella.FieldByName('NomeCampo').AsString,[srFromBeginning]) then
    begin
      MsgBox.WebMessageDlg(Format(A000MSG_A026_DLG_FMT_CANCELLA,[A026FDatiLiberiMW.selI091.FieldByName('TIPO').AsString]),
               mtConfirmation,[mbYes,mbNo],CheckBeforeDelete_selTabella,'PUNTO_2');
      Abort;
    end;
  end;

  if not MsgBox.KeyExists('PUNTO_3') then
  begin
    A026FDatiLiberiMW.EliminaDatoLibero;
    MsgBox.ClearKeys;
    inherited;
  end;
end;

procedure TWA026FDatiLiberiDM.CheckBeforeDelete_selTabella(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  case Res of
    mrYes: TWA026FDatiLiberi(Self.Owner).EseguiDelete;//selTabella.Delete;
    mrNo:  MsgBox.ClearKeys;
  end;
end;

procedure TWA026FDatiLiberiDM.BeforePostNoStorico(DataSet: TDataSet);
begin

  inherited;
{ TODO : Verificare funzionamento. In modifica da sempre errore }
  if not IsValidIdent(selTabella.FieldByName('NOMECAMPO').AsString) then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_CARATTERI_SPECIALI,['nome dato']),mtError,[mbOk],nil,'');
    Abort;
  end;

  if selTabella.State = dsInsert then
    A026FDatiLiberiMW.VerificaNomeCampoAnagrafico;

  if not MsgBox.KeyExists('PUNTO_1') then
  begin
    inherited;
    if selTabella.FieldByName('LUNGHEZZA').AsInteger < 1 then //Lorena 17/05/2005
      raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,['dimensione del dato']));
    if Trim(TWA026FDatiLiberiDettFM(TWA026FDatiLiberi(Self.Owner).WDettaglioFM).cmbNOMEPAGINA.Text) = '' then
      raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,['nome pagina']));
    if A026FDatiLiberiMW.DatoObbligatorio and A026FDatiLiberiMW.DatoDefault.IsEmpty then
      raise Exception.Create('Se il dato è obbligatorio è richiesto un valore di default valido!');
    //Se sto modificando i collegamenti eseguo una procedura a parte
    A026FDatiLiberiMW.selT033B.Close;
    A026FDatiLiberiMW.selT033B.SetVariable('CampoDb',selTabellaNomeCampo.AsString);
    A026FDatiLiberiMW.selT033B.Open;
    //Se il campo non è tabellare annullo la lunghezza della descrizione
    if selTabella.FieldByName('TABELLA').AsString = 'N' then
      selTabella.FieldByName('LUNG_DESC').AsInteger:=0
    else
      if selTabella.FieldByName('LUNG_DESC').AsInteger <= 0 then
        raise Exception.Create(Format(A000MSG_ERR_FMT_MAGGIORE_ZERO,['descrizione del dato']));

    //MODIFICA - INIZIO
    if selTabella.State = dsEdit then
    begin
      if (selTabella.FieldByName('Formato').AsString = 'S') and
         (selTabella.FieldByName('Lunghezza').medpOldValue > selTabella.FieldByName('Lunghezza').Value) then
      begin
        MsgBox.WebMessageDlg(A000MSG_A026_DLG_DIMINIZ,mtConfirmation,[mbYes,mbNo],CheckBeforePost_selTabella,'PUNTO_1');
        Abort;
      end;
    end;
  end;

  if (selTabella.State = dsEdit) and (not MsgBox.KeyExists('PUNTO_2')) then
  begin
    if selTabella.FieldByName('LUNG_DESC').medpOldValue > selTabella.FieldByName('LUNG_DESC').Value then
    begin
      MsgBox.WebMessageDlg(A000MSG_A026_DLG_DIMINIZ_DESC,mtConfirmation,[mbYes,mbNo],CheckBeforePost_selTabella,'PUNTO_2');
      Abort;
    end;
  end;

  if (selTabella.State = dsEdit) and (not MsgBox.KeyExists('PUNTO_3')) then
  begin
    if selTabella.FieldByName('Tabella').medpOldValue <> selTabella.FieldByName('Tabella').Value then
      A026FDatiLiberiMW.ModificaTabellare(selTabella.FieldByName('NOMECAMPO').AsString,selTabella.FieldByName('Tabella').AsString);

    if (selTabella.FieldByName('Formato').AsString = 'S') and
       (selTabella.FieldByName('Lunghezza').medpOldValue <> selTabella.FieldByName('Lunghezza').Value) then
      A026FDatiLiberiMW.ModificaColonna(selTabella.FieldByName('NOMECAMPO').AsString,selTabella.FieldByName('Lunghezza').AsInteger);

    if (selTabella.FieldByName('TABELLA').AsString = 'S') and
       (selTabella.FieldByName('LUNG_DESC').medpOldValue <> selTabella.FieldByName('LUNG_DESC').Value) then
      A026FDatiLiberiMW.ModificaLungDesc;

    if A026FDatiLiberiMW.DatoDefault <> A026FDatiLiberiMW.GetDatoDefault(selTabella.FieldByName('NOMECAMPO').AsString) then
      A026FDatiLiberiMW.EditDatoDefault;
    //Modifica dato default
    if A026FDatiLiberiMW.DatoObbligatorio <> A026FDatiLiberiMW.GetDatoObbligatorio(selTabella.FieldByName('NOMECAMPO').AsString) then
      A026FDatiLiberiMW.EditDatoObbligatorio;

    A026FDatiLiberiMW.ModificaPagina;

    MsgBox.ClearKeys;

    if A026FDatiLiberiMW.ModificaLinkStorico then
    begin
      SessioneOracle.Commit;
      Exit;
    end
    else
    begin
      SessioneOracle.Rollback;
      raise Exception.Create(Format(A000MSG_ERR_FMT_MODIFICHE_FALLITE,['Errore oracle']));
    end;
  end;
  //MODIFICA - FINE

  //INSERIMENTO - INIZIO
  if (selTabella.State = dsInsert) and (not MsgBox.KeyExists('PUNTO_1')) then
  begin
    MsgBox.WebMessageDlg(A000MSG_DLG_INSERIMENTO,mtConfirmation,[mbYes,mbNo],CheckBeforePost_selTabella,'PUNTO_1');
    Abort;
  end;

  if not MsgBox.KeyExists('PUNTO_4') then
  try
    A026FDatiLiberiMW.InserisciDatoLibero;
    if not A026FDatiLiberiMW.DatoDefault.IsEmpty  then
      A026FDatiLiberiMW.EditDatoDefault;
    //Modifica dato default
    if A026FDatiLiberiMW.DatoObbligatorio then
      A026FDatiLiberiMW.EditDatoObbligatorio;
  finally
    MsgBox.ClearKeys;
  end;
  //INSERIMENTO - FINE
end;

procedure TWA026FDatiLiberiDM.CheckBeforePost_selTabella(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  case Res of
    mrYes: selTabella.Post;
    mrNo:  MsgBox.ClearKeys;
  end;
end;

end.
