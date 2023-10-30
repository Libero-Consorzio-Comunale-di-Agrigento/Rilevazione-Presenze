unit WP552uRegoleContoAnnualeDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR303UGestMasterDetailDM, Data.DB, C180FunzioniGenerali,
  P552URegoleContoAnnualeMW, OracleData, A000UMessaggi, A000UInterfaccia;

type
  TWP552FRegoleContoAnnualeDM = class(TWR303FGestMasterDetailDM)
    selTabellaANNO: TIntegerField;
    selTabellaCOD_TABELLA: TStringField;
    selTabellaRIGA: TIntegerField;
    selTabellaCOLONNA: TIntegerField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaVALORE_COSTANTE: TStringField;
    selTabellaTIPO_TABELLA_RIGHE: TStringField;
    selTabellaCOD_ARROTONDAMENTO: TStringField;
    selTabellaCODICI_ACCORPAMENTOVOCI: TStringField;
    selTabellaREGOLA_CALCOLO_AUTOMATICA: TStringField;
    selTabellaREGOLA_CALCOLO_MANUALE: TStringField;
    selTabellaREGOLA_MODIFICABILE: TStringField;
    selTabellaNUMERO_TREDCORR: TStringField;
    selTabellaNUMERO_TREDPREC: TStringField;
    selTabellaNUMERO_ARRCORR: TStringField;
    selTabellaNUMERO_ARRPREC: TStringField;
    selTabellaDATA_ACCORPAMENTO: TStringField;
    selTabellaFILTRO_DIPENDENTI: TStringField;
    selTabellaDESC_TIPO_TABELLA_RIGHE: TStringField;
    selTabellaSCRIPT_INIZIALE: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
  private
    procedure selP552RigheColonneBeforePost(DataSet: TDataSet);
    procedure selP551BeforePost(DataSet: TDataSet);
  protected
    procedure RelazionaTabelleFiglie; override;
  public
    DettaglioRegole: TDettaglioRegole;
    P552FRegoleContoAnnualeMW: TP552FRegoleContoAnnualeMW;
  end;

implementation

uses
  WP552URegoleContoAnnuale, WP552URegoleContoAnnualeDettFM;

{$R *.dfm}

procedure TWP552FRegoleContoAnnualeDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','order by p552.anno, p552.cod_tabella');
  P552FRegoleContoAnnualeMW:=TP552FRegoleContoAnnualeMW.Create(Self);
  P552FRegoleContoAnnualeMW.SelP552_Funzioni:=selTabella;
  P552FRegoleContoAnnualeMW.selP552Righe.BeforePost:=selP552RigheColonneBeforePost;
  P552FRegoleContoAnnualeMW.selP552Colonne.BeforePost:=selP552RigheColonneBeforePost;
  P552FRegoleContoAnnualeMW.selP551.BeforePost:=selP551BeforePost;

  P552FRegoleContoAnnualeMW.bLogRigheColone:=False; //log operazione fatto da actexecute e eactdelete dei pannelli WR203
  inherited;
end;

procedure TWP552FRegoleContoAnnualeDM.AfterScroll(DataSet: TDataSet);
begin
  P552FRegoleContoAnnualeMW.selP552AfterScroll;
  inherited;
  with (Self.Owner as TWP552FRegoleContoAnnuale) do
    if grdTabControl.TabByIndex(2) <> nil then
      grdTabControl.TabByIndex(2).LinkVisible:=not Dataset.FieldByName('SCRIPT_INIZIALE').IsNull;
end;

procedure TWP552FRegoleContoAnnualeDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  P552FRegoleContoAnnualeMW.selP552BeforePost;
  if VarToStr(P552FRegoleContoAnnualeMW.selCheckAnagrafe.Field(0)) = 'E' then
    MsgBox.MessageBox(A000MSG_P552_MSG_FILTRO_DIP + #13#10 + A000MSG_P000_MSG_DATO_SALVATO,INFORMA);
end;

procedure TWP552FRegoleContoAnnualeDM.RelazionaTabelleFiglie;
begin
  P552FRegoleContoAnnualeMW.ImpostaSelP552Righe;
  P552FRegoleContoAnnualeMW.ImpostaSelP552Colonne;
  //rendo invisibile perchè nella grid risulta invadente a livello grafico
  P552FRegoleContoAnnualeMW.selP552Righe.FieldByName('REGOLA_CALCOLO_MANUALE').Visible:=False;
  P552FRegoleContoAnnualeMW.selP552Colonne.FieldByName('REGOLA_CALCOLO_MANUALE').Visible:=False;

  P552FRegoleContoAnnualeMW.ImpostaSelP551;
  inherited;
end;

procedure TWP552FRegoleContoAnnualeDM.selP552RigheColonneBeforePost(DataSet: TDataSet);
begin
  inherited;
  P552FRegoleContoAnnualeMW.selP552RigheColonneBeforePost(Dataset,DettaglioRegole);
end;

procedure TWP552FRegoleContoAnnualeDM.selP551BeforePost(DataSet: TDataSet);
begin
  with P552FRegoleContoAnnualeMW.selP551 do
  begin
    if Trim(FieldByName('NUM_CAMPO').AsString) = '' then
    begin
      raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,['Num. campo']));
    end;

    if Trim(FieldByName('TIPO_CAMPO').AsString) = '' then
    begin
      raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,['Tipo campo']));
    end;

    if Trim(FieldByName('FORMATO').AsString) = '' then
    begin
      raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,['Formato']));
    end;

    if Trim(FieldByName('LUNGHEZZA').AsString) = '' then
    begin
      raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,['Lunghezza']));
    end;

    if (FieldByName('TIPO_CAMPO').AsString = 'FORMULA') and
       (Trim(FieldByName('FORMULA').AsString) = '') then
    begin
      raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,['Formula']));
    end;
  end;
end;

procedure TWP552FRegoleContoAnnualeDM.OnNewRecord(DataSet: TDataSet);
begin
  with (Self.Owner as TWP552FRegoleContoAnnuale).WDettaglioFM as  TWP552FRegoleContoAnnualeDettFM do
  begin
    P552FRegoleContoAnnualeMW.selP552NewRecord(StrToIntDef(dedtAnno.Text,1900));
  end;
  inherited;
end;

procedure TWP552FRegoleContoAnnualeDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(P552FRegoleContoAnnualeMW);
  inherited;
end;

end.
