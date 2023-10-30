unit P552URegoleContoAnnualeDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, Oracle, C180FunzioniGenerali,
  USelI010, A000UCostanti, A000USessione, A000UInterfaccia, A000UMessaggi,
  P552URegoleContoAnnualeMW;

type
  TP552FRegoleContoAnnualeDtM = class(TR004FGestStoricoDtM)
    selP552: TOracleDataSet;
    dsrP552Ricerca: TDataSource;
    procedure DataModuleDestroy(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure selP552AfterScroll(DataSet: TDataSet);
    procedure selP552NewRecord(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure selP552RigheAfterScroll(DataSet: TDataSet);
    procedure selP552RigheBeforePost(DataSet: TDataSet);
    procedure selP551AfterScroll(DataSet: TDataSet);
    procedure selP551BeforePost(DataSet: TDataSet);
  public
     P552FRegoleContoAnnualeMW: TP552FRegoleContoAnnualeMW;
  end;

var
  P552FRegoleContoAnnualeDtM: TP552FRegoleContoAnnualeDtM;

implementation

uses P552URegoleContoAnnuale, P552UDettaglioRegoleContoAnn,
  P552UEsportazioneFile;

{$R *.dfm}

procedure TP552FRegoleContoAnnualeDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selP552,[evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost]);
  P552FRegoleContoAnnualeMW:=TP552FRegoleContoAnnualeMW.Create(Self);
  P552FRegoleContoAnnualeMW.SelP552_Funzioni:=selP552;
  dsrP552Ricerca.DataSet:=P552FRegoleContoAnnualeMW.selP552Ricerca;

  P552FRegoleContoAnnualeMW.selP552Righe.AfterScroll:=selP552RigheAfterScroll;
  P552FRegoleContoAnnualeMW.selP552Colonne.AfterScroll:=selP552RigheAfterScroll;
  P552FRegoleContoAnnualeMW.selP552Righe.BeforePost:=selP552RigheBeforePost;
  P552FRegoleContoAnnualeMW.selP552Colonne.BeforePost:=selP552RigheBeforePost;
  P552FRegoleContoAnnualeMW.selP551.AfterScroll:=selP551AfterScroll;
  P552FRegoleContoAnnualeMW.selP551.BeforePost:=selP551BeforePost;

  selP552.AfterScroll:=nil;
  selP552.Open;
  selP552.AfterScroll:=selP552AfterScroll;
end;

procedure TP552FRegoleContoAnnualeDtM.selP552NewRecord(DataSet: TDataSet);
begin
  inherited;
  P552FRegoleContoAnnualeMW.selP552NewRecord(StrToIntDef(P552FRegoleContoAnnuale.edtAnno.Text,1900));
end;

procedure TP552FRegoleContoAnnualeDtM.selP552AfterScroll(DataSet: TDataSet);
begin
  inherited;
  P552FRegoleContoAnnualeMW.selP552AfterScroll;
  P552FRegoleContoAnnuale.drdgTipologiaClick(nil);
  P552FRegoleContoAnnuale.tabScriptIniziale.TabVisible:=not Dataset.FieldByName('SCRIPT_INIZIALE').IsNull;
end;

procedure TP552FRegoleContoAnnualeDtM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  P552FRegoleContoAnnualeMW.selP552BeforePost;
  if VarToStr(P552FRegoleContoAnnualeMW.selCheckAnagrafe.Field(0)) = 'E' then
    ShowMessage(A000MSG_P552_MSG_FILTRO_DIP + #13#10 + A000MSG_P000_MSG_DATO_SALVATO);
end;

procedure TP552FRegoleContoAnnualeDtM.selP552RigheAfterScroll(DataSet: TDataSet);
var i:Integer;
  App:String;
begin
  inherited;
  if P552FDettaglioRegoleContoAnn <> nil then
    with P552FDettaglioRegoleContoAnn do
    begin
      if Dataset.FieldByName('NUMERO_TREDCORR').AsString = 'NC' then
      begin
        CmbTabTredicesimaAC.Text:=Format('%-10s',['NC']) + '-' + 'Non conteggiare';
        cmbTabTredicesimaACChange(nil);
        CmbRigheTredicesimaAC.Text:='';
      end
      else
      begin
        App:=Copy(Dataset.FieldByName('NUMERO_TREDCORR').AsString,1,Pos('.',Dataset.FieldByName('NUMERO_TREDCORR').AsString)-1);
        i:=R180IndexOf(CmbTabTredicesimaAC.Items,App,10);
        if i >= 0 then
          CmbTabTredicesimaAC.Text:=Format('%-10s',[App]) + '-' +
                                    Copy(CmbTabTredicesimaAC.Items[i],12,Length(CmbTabTredicesimaAC.Items[i])-11)
        else
          CmbTabTredicesimaAC.Text:='';
        cmbTabTredicesimaACChange(nil);
        App:=Copy(Dataset.FieldByName('NUMERO_TREDCORR').AsString, Pos('.',Dataset.FieldByName('NUMERO_TREDCORR').AsString)+1,
             Length(Dataset.FieldByName('NUMERO_TREDCORR').AsString)-Pos('.',Dataset.FieldByName('NUMERO_TREDCORR').AsString));
        i:=R180IndexOf(CmbRigheTredicesimaAC.Items,App,3);
        if i >= 0 then
          CmbRigheTredicesimaAC.Text:=Format('%-3s',[App]) + '-' +
                                      Copy(CmbRigheTredicesimaAC.Items[i],5,Length(CmbRigheTredicesimaAC.Items[i])-4)
        else
          CmbRigheTredicesimaAC.Text:='';
      end;
      if Dataset.FieldByName('NUMERO_TREDPREC').AsString = 'NC' then
      begin
        CmbTabTredicesimaAP.Text:=Format('%-10s',['NC']) + '-' + 'Non conteggiare';
        CmbRigheTredicesimaAP.Text:='';
      end
      else
      begin
        App:=Copy(Dataset.FieldByName('NUMERO_TREDPREC').AsString,1,Pos('.',Dataset.FieldByName('NUMERO_TREDPREC').AsString)-1);
        i:=R180IndexOf(CmbTabTredicesimaAP.Items,App,10);
        if i >= 0 then
          CmbTabTredicesimaAP.Text:=Format('%-10s',[App]) + '-' +
                                    Copy(CmbTabTredicesimaAP.Items[i],12,Length(CmbTabTredicesimaAP.Items[i])-11)
        else
          CmbTabTredicesimaAP.Text:='';
        cmbTabTredicesimaAPChange(nil);
        App:=Copy(Dataset.FieldByName('NUMERO_TREDPREC').AsString, Pos('.',Dataset.FieldByName('NUMERO_TREDPREC').AsString)+1,
             Length(Dataset.FieldByName('NUMERO_TREDPREC').AsString)-Pos('.',Dataset.FieldByName('NUMERO_TREDPREC').AsString));
        i:=R180IndexOf(CmbRigheTredicesimaAP.Items,App,3);
        if i >= 0 then
          CmbRigheTredicesimaAP.Text:=Format('%-3s',[App]) + '-' +
                                      Copy(CmbRigheTredicesimaAP.Items[i],5,Length(CmbRigheTredicesimaAP.Items[i])-4)
        else
          CmbRigheTredicesimaAP.Text:='';
      end;
      if Dataset.FieldByName('NUMERO_ARRCORR').AsString = 'NC' then
      begin
        CmbTabArretratiAC.Text:=Format('%-10s',['NC']) + '-' + 'Non conteggiare';
        CmbRigheArretratiAC.Text:='';
      end
      else
      begin
        App:=Copy(Dataset.FieldByName('NUMERO_ARRCORR').AsString,1,Pos('.',Dataset.FieldByName('NUMERO_ARRCORR').AsString)-1);
        i:=R180IndexOf(CmbTabArretratiAC.Items,App,10);
        if i >= 0 then
          CmbTabArretratiAC.Text:=Format('%-10s',[App]) + '-' +
                                  Copy(CmbTabArretratiAC.Items[i],12,Length(CmbTabArretratiAC.Items[i])-11)
        else
          CmbTabArretratiAC.Text:='';
        CmbTabArretratiACChange(nil);
        App:=Copy(Dataset.FieldByName('NUMERO_ARRCORR').AsString, Pos('.',Dataset.FieldByName('NUMERO_ARRCORR').AsString)+1,
             Length(Dataset.FieldByName('NUMERO_ARRCORR').AsString)-Pos('.',Dataset.FieldByName('NUMERO_ARRCORR').AsString));
        i:=R180IndexOf(CmbRigheArretratiAC.Items,App,3);
        if i >= 0 then
          CmbRigheArretratiAC.Text:=Format('%-3s',[App]) + '-' +
                                      Copy(CmbRigheArretratiAC.Items[i],5,Length(CmbRigheArretratiAC.Items[i])-4)
        else
          CmbRigheArretratiAC.Text:='';
      end;
      if Dataset.FieldByName('NUMERO_ARRPREC').AsString = 'NC' then
      begin
        CmbTabArretratiAP.Text:=Format('%-10s',['NC']) + '-' + 'Non conteggiare';
        CmbRigheArretratiAP.Text:='';
      end
      else
      begin
        App:=Copy(Dataset.FieldByName('NUMERO_ARRPREC').AsString,1,Pos('.',Dataset.FieldByName('NUMERO_ARRPREC').AsString)-1);
        i:=R180IndexOf(CmbTabArretratiAP.Items,App,10);
        if i >= 0 then
          CmbTabArretratiAP.Text:=Format('%-10s',[App]) + '-' +
                                  Copy(CmbTabArretratiAP.Items[i],12,Length(CmbTabArretratiAP.Items[i])-11)
        else
          CmbTabArretratiAP.Text:='';
        CmbTabArretratiAPChange(nil);
        App:=Copy(Dataset.FieldByName('NUMERO_ARRPREC').AsString, Pos('.',Dataset.FieldByName('NUMERO_ARRPREC').AsString)+1,
             Length(Dataset.FieldByName('NUMERO_ARRPREC').AsString)-Pos('.',Dataset.FieldByName('NUMERO_ARRPREC').AsString));
        i:=R180IndexOf(CmbRigheArretratiAP.Items,App,3);
        if i >= 0 then
          CmbRigheArretratiAP.Text:=Format('%-3s',[App]) + '-' +
                                      Copy(CmbRigheArretratiAP.Items[i],5,Length(CmbRigheArretratiAP.Items[i])-4)
        else
          CmbRigheArretratiAP.Text:='';
        dedtCodAccorpamento.Hint:=Dataset.FieldByName('CODICI_ACCORPAMENTOVOCI').AsString;
      end;
      drdgModalitaClick(nil);
      dchkRegolaModifClick(nil);
  end;
end;

procedure TP552FRegoleContoAnnualeDtM.selP552RigheBeforePost(DataSet: TDataSet);
var
  DettaglioRegole: TDettaglioRegole;
begin
  inherited;
  with P552FDettaglioRegoleContoAnn do
  begin
    DettaglioRegole.TabTredicesimaAC:=CmbTabTredicesimaAC.Text;
    DettaglioRegole.RigheTredicesimaAC:=CmbRigheTredicesimaAC.Text;
    DettaglioRegole.TabTredicesimaAP:=CmbTabTredicesimaAP.Text;
    DettaglioRegole.RigheTredicesimaAP:=CmbRigheTredicesimaAP.Text;
    DettaglioRegole.TabArretratiAC:=CmbTabArretratiAC.Text;
    DettaglioRegole.RigheArretratiAC:=CmbRigheArretratiAC.Text;
    DettaglioRegole.TabArretratiAP:=CmbTabArretratiAP.Text;
    DettaglioRegole.RigheArretratiAP:=CmbRigheArretratiAP.Text;
    DettaglioRegole.TabElab:=TabElab;
    DettaglioRegole.AnnoElab:=StrToIntDef(AnnoElab,0);
    DettaglioRegole.bAccorpamento:=dedtCodAccorpamento.Visible;
    DettaglioRegole.bTabSostitutive:=gpbTabSostitutive.Visible;
    P552FRegoleContoAnnualeMW.selP552RigheColonneBeforePost(Dataset,DettaglioRegole);

    case DataSet.State of
      dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
      dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    end;
  end;
end;

procedure TP552FRegoleContoAnnualeDtM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(P552FRegoleContoAnnualeMW);
  inherited;
end;

procedure TP552FRegoleContoAnnualeDtM.selP551AfterScroll(DataSet: TDataSet);
begin
  if P552FEsportazioneFile = nil then
    Exit;
  with P552FEsportazioneFile do
  begin
    edtNumCampo.Value:=P552FRegoleContoAnnualeMW.selP551.FieldByName('NUM_CAMPO').AsInteger;
    cmbFormato.Text:=cmbFormato.Items[R180IndexOf(cmbFormato.Items,P552FRegoleContoAnnualeMW.selP551.FieldByName('FORMATO').AsString,3)];
    cmbTipoCampo.Text:=cmbTipoCampo.Items[R180IndexOf(cmbTipoCampo.Items,P552FRegoleContoAnnualeMW.selP551.FieldByName('TIPO_CAMPO').AsString,10)];
  end;
end;

procedure TP552FRegoleContoAnnualeDtM.selP551BeforePost(DataSet: TDataSet);
begin
  inherited;
  if P552FEsportazioneFile = nil then
    Exit;
  with P552FEsportazioneFile do
  begin
    if R180IndexOf(cmbTipoCampo.Items,Copy(cmbTipoCampo.Text,1,10),10) < 0 then
    begin
      cmbTipoCampo.SetFocus;
      raise exception.Create('Attenzione: tipo campo non previsto!');
    end;
    if R180IndexOf(cmbFormato.Items,Copy(cmbFormato.Text,1,10),10) < 0 then
    begin
      cmbFormato.SetFocus;
      raise exception.Create('Attenzione: formato non previsto!');
    end;
    if (TrimRight(Copy(cmbTipoCampo.Text,1,10)) = 'FORMULA') and (Trim(P552FRegoleContoAnnualeMW.selP551.FieldByName('FORMULA').AsString) = '') then
    begin
      dedtFormula.SetFocus;
      raise exception.Create('Attenzione: specificare il dato formula!');
    end;
    P552FRegoleContoAnnualeMW.selP551.FieldByName('NUM_CAMPO').AsInteger:=edtNumCampo.Value;
    P552FRegoleContoAnnualeMW.selP551.FieldByName('FORMATO').AsString:=TrimRight(Copy(cmbFormato.Text,1,3));
    P552FRegoleContoAnnualeMW.selP551.FieldByName('TIPO_CAMPO').AsString:=TrimRight(Copy(cmbTipoCampo.Text,1,10));
  end;
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

end.
