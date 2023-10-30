unit S700UAreeValutazioniDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, Oracle, OracleData, C700USelezioneAnagrafe,
  C180FunzioniGenerali, A000UCostanti, A000USessione, A000UInterfaccia, Math,
  S700UAreeValutazioniMW, A000UMessaggi;

type
  TS700FAreeValutazioniDtM = class(TR004FGestStoricoDtM)
    selSG701: TOracleDataSet;
    dsrSG700: TDataSource;
    selSG701COD_AREA: TStringField;
    selSG701DECORRENZA: TDateTimeField;
    selSG701DECORRENZA_FINE: TDateTimeField;
    selSG701DESCRIZIONE: TStringField;
    selSG701PESO_PERCENTUALE: TFloatField;
    selSG701PESO_VARIABILE_ITEMS: TStringField;
    selSG701TIPO_PUNTEGGIO_ITEMS: TStringField;
    selSG701STATI_ABILITATI_PUNTEGGI: TStringField;
    selSG701TIPO_PESO_PERCENTUALE: TStringField;
    selSG701ITEM_PERSONALIZZATI_MIN: TIntegerField;
    selSG701ITEM_PERSONALIZZATI_MAX: TIntegerField;
    selSG701ITEM_TUTTI_VALUTABILI: TStringField;
    selSG701TIPO_LINK_ITEM: TStringField;
    selSG701STATI_ABILITATI_ELEMENTI: TStringField;
    selSG701TESTO_ITEM_PERSONALIZZATI: TStringField;
    selSG701PESO_EQUO_ITEMS: TStringField;
    selSG701PESO_PERC_MIN: TFloatField;
    selSG701PESO_PERC_MAX: TFloatField;
    selSG701PUNTEGGI_SOLO_ITEM_VALUTABILI: TStringField;

    procedure AfterPost(DataSet: TDataSet); override;
    procedure BeforePost(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure selSG701AfterScroll(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure selSG701PESO_PERCENTUALEValidate(Sender: TField);
  private
    { Private declarations }
    procedure ControllaSchedeEsistenti;
    procedure selSG700PESO_PERCENTUALE_Validate(Sender: TField);
    procedure AfterPostRecall;
  public
    { Public declarations }
    S700FAreeValutazioniMW: TS700FAreeValutazioniMW;
    procedure RicalcolaPesoArea;
  end;

var
  S700FAreeValutazioniDtM: TS700FAreeValutazioniDtM;

implementation

uses S700UAreeValutazioni;

{$R *.dfm}

procedure TS700FAreeValutazioniDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InterfacciaR004:=S700FAreeValutazioni.InterfacciaR004;
  InizializzaDataSet(selSG701,[evBeforeEdit,
                               evBeforeInsert,
                               evBeforePost,
                               evBeforeDelete,
                               evAfterDelete,
                               evAfterPost,
                               evOnTranslateMessage,
                               evOnNewRecord]);
  S700FAreeValutazioniMW:=TS700FAreeValutazioniMW.Create(Self);
  S700FAreeValutazioniMW.SG701_Funzioni:=selSG701;
  S700FAreeValutazioniMW.selSG700.FieldByName('PESO_PERCENTUALE').OnValidate:=selSG700PESO_PERCENTUALE_Validate;
  S700FAreeValutazioniMW.AfterPostRecall:=AfterPostRecall;
  S700fAreeValutazioni.DButton.Dataset:=selSG701;
  selSG701.Open;
  selSG701PESO_PERCENTUALE.EditMask:='!990,00;1;_';
  dsrSG700.DataSet:=S700FAreeValutazioniMW.selSG700;
end;

procedure TS700FAreeValutazioniDtM.selSG701AfterScroll(DataSet: TDataSet);
begin
  inherited;
  S700FAreeValutazioniMW.AfterScroll;
  if S700FAreeValutazioni.Visible then
    S700FAreeValutazioni.frmToolbarFiglio.AbilitaAzioniTF(nil);
  S700FAreeValutazioni.AbilitaComponenti;
end;

procedure TS700FAreeValutazioniDtM.selSG701PESO_PERCENTUALEValidate(Sender: TField);
begin
  inherited;
  if (Sender.AsInteger < 0)
  or (Sender.AsInteger > 100) then
    raise exception.create(Format(A000MSG_S700_ERR_FMT_VAL_COMPRESO,[Sender.DisplayLabel]));
  S700FAreeValutazioni.AbilitaComponenti;
end;

procedure TS700FAreeValutazioniDtM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  ControllaSchedeEsistenti;
end;

procedure TS700FAreeValutazioniDtM.selSG700PESO_PERCENTUALE_Validate(Sender: TField);
begin
  if (S700FAreeValutazioniMW.selSG700.FieldByName('PESO_PERCENTUALE').AsInteger < 0)
  or (S700FAreeValutazioniMW.selSG700.FieldByName('PESO_PERCENTUALE').AsInteger > 100) then
    raise exception.create(Format(A000MSG_S700_ERR_FMT_VAL_COMPRESO,['Peso %']));
  S700FAreeValutazioni.AbilitaComponenti; //PER IL CLOUD non serve
end;

procedure TS700FAreeValutazioniDtM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  S700FAreeValutazioniMW.OnNewRecord;
  S700FAreeValutazioni.AbilitaComponenti;
end;

procedure TS700FAreeValutazioniDtM.BeforePost(DataSet: TDataSet);
var res: String;
begin
  S700FAreeValutazioni.dedtCodArea.SetFocus;
  //Controlli sulla testata
  try
    S700FAreeValutazioniMW.VerificaPercentuali
  Except
    on E: Exception do
    begin
      if S700FAreeValutazioni.dedtPesoPercentuale.Enabled then
      S700FAreeValutazioni.dedtPesoPercentuale.SetFocus;
      raise;
    end;
  end;
  if S700FAreeValutazioni.dedtPesoPercMin.Enabled then
  begin
    try
      S700FAreeValutazioniMW.VerificaPeso
    Except
      on E: Exception do
      begin
        if S700FAreeValutazioni.dedtPesoPercentuale.Enabled then
          S700FAreeValutazioni.dedtPesoPercentuale.SetFocus;
        raise;
      end;
    end;
  end;
  try
    S700FAreeValutazioniMW.VerificaItemPersonalizzatiMin
  Except
    on E: Exception do
    begin
      S700FAreeValutazioni.dedtItemPersonalizzatiMin.SetFocus;
      raise;
    end;
  end;
  res:='';
  res:=S700FAreeValutazioniMW.VerificaItemPersonalizzatiMax;
  if res <> '' then
    begin
      S700FAreeValutazioni.dmemTestoItemPersonalizzati.SetFocus;
      raise exception.Create(res + S700FAreeValutazioni.lblTestoItemPersonalizzati.Caption + '!');
    end;
  if (S700FAreeValutazioniMW.selSG700.State in [dsInsert]) or InterfacciaR004.StoricizzazioneInCorso then
    ControllaSchedeEsistenti;
  inherited;
  S700FAreeValutazioni.AbilitaComponenti;
end;

procedure TS700FAreeValutazioniDtM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  try
    RicalcolaPesoArea;
  except
    on E:exception do
    begin
      ShowMessage(E.Message);
      S700FAreeValutazioni.frmToolbarFiglio.actTFModificaExecute(S700FAreeValutazioni.frmToolbarFiglio.actTFModifica);
    end;
  end;
end;

procedure TS700FAreeValutazioniDtM.ControllaSchedeEsistenti;
var res:String;
begin
  res:=S700FAreeValutazioniMW.ControllaSchedeEsistenti;
  if res <> '' then
    ShowMessage(res);
end;

procedure TS700FAreeValutazioniDtM.RicalcolaPesoArea;
begin
  inherited;
  S700FAreeValutazioniMW.RicalcolaPesoArea(S700FAreeValutazioni.dedtPesoPercMin.Enabled, true);
end;

procedure TS700FAreeValutazioniDtM.AfterPostRecall;
begin
  selSG701.AfterPost:=AfterPost;
end;

end.
