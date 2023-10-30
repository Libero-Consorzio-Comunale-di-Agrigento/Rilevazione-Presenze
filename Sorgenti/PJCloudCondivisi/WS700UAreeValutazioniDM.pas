unit WS700UAreeValutazioniDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR303UGestMasterDetailDM, WR302UGestTabellaDM, Data.DB, OracleData, WR205UDettTabellaFM,
  S700UAreeValutazioniMW, A000UInterfaccia, medpIWMessageDlg;

type
  TWS700FAreeValutazioniDM = class(TWR303FGestMasterDetailDM)
    selTabellaCOD_AREA: TStringField;
    selTabellaDECORRENZA: TDateTimeField;
    selTabellaDECORRENZA_FINE: TDateTimeField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaPESO_PERCENTUALE: TFloatField;
    selTabellaPESO_PERC_MIN: TFloatField;
    selTabellaPESO_PERC_MAX: TFloatField;
    selTabellaPESO_VARIABILE_ITEMS: TStringField;
    selTabellaTIPO_PUNTEGGIO_ITEMS: TStringField;
    selTabellaITEM_TUTTI_VALUTABILI: TStringField;
    selTabellaITEM_PERSONALIZZATI_MIN: TIntegerField;
    selTabellaTIPO_PESO_PERCENTUALE: TStringField;
    selTabellaTIPO_LINK_ITEM: TStringField;
    selTabellaSTATI_ABILITATI_PUNTEGGI: TStringField;
    selTabellaSTATI_ABILITATI_ELEMENTI: TStringField;
    selTabellaTESTO_ITEM_PERSONALIZZATI: TStringField;
    selTabellaPESO_EQUO_ITEMS: TStringField;
    selTabellaPUNTEGGI_SOLO_ITEM_VALUTABILI: TStringField;
    dsrSG700: TDataSource;
    selTabellaITEM_PERSONALIZZATI_MAX: TIntegerField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure BeforePost(DataSet: TDataSet); override;
    procedure selTabellaAfterPost(DataSet: TDataSet);
    procedure selTabellaBeforeDelete(DataSet: TDataSet);
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure selTabellaNewRecord(DataSet: TDataSet);
    procedure AfterScroll(DataSet: TDataSet);
    procedure selTabellaPESO_PERCENTUALEValidate(Sender: TField);
  private
    procedure AfterPostRecall;
    procedure ControllaSchedeEsistenti;
  protected
    procedure RelazionaTabelleFiglie; override;
  public
    S700FAreeValutazioniMW: TS700FAreeValutazioniMW;
  end;

implementation

{$R *.dfm}

uses WR103UGestMasterDetail, WS700UAreeValutazioniDettFM;

procedure TWS700FAreeValutazioniDM.RelazionaTabelleFiglie;
begin
  S700FAreeValutazioniMW.AfterScroll;
end;

procedure TWS700FAreeValutazioniDM.selTabellaAfterPost(DataSet: TDataSet);
begin
  inherited;
  try
    S700FAreeValutazioniMW.RicalcolaPesoArea(((Self.Owner as TWR103FGestMasterDetail).WDettaglioFM  as TWS700FAreeValutazioniDettFM).dedtPesoPercMin.Enabled, false);
  except
    on E:exception do
    begin
      MsgBox.WebMessageDlg(E.Message,mtInformation,[mbOk],nil,'');
      {§S700FAreeValutazioni.frmToolbarFiglio.actTFModificaExecute(S700FAreeValutazioni.frmToolbarFiglio.actTFModifica);}
    end;
  end;
end;

procedure TWS700FAreeValutazioniDM.selTabellaBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  ControllaSchedeEsistenti;
end;

procedure TWS700FAreeValutazioniDM.selTabellaNewRecord(DataSet: TDataSet);
begin
  inherited;
  S700FAreeValutazioniMW.OnNewRecord;
  ((Self.Owner as TWR103FGestMasterDetail).WDettaglioFM  as TWS700FAreeValutazioniDettFM).AbilitaComponenti;
end;

procedure TWS700FAreeValutazioniDM.selTabellaPESO_PERCENTUALEValidate(Sender: TField);
begin
  inherited;
  {
  if (Sender.AsInteger < 0)
  or (Sender.AsInteger > 100) then
    raise exception.create('Il valore del campo ' + Sender.DisplayLabel + ' deve essere compreso tra 0 e 100!');
  ((Self.Owner as TWR103FGestMasterDetail).WDettaglioFM  as TWS700FAreeValutazioniDettFM).AbilitaComponenti;
  }
end;

procedure TWS700FAreeValutazioniDM.BeforePost(DataSet: TDataSet);
var res: String;
begin
  ((Self.Owner as TWR103FGestMasterDetail).WDettaglioFM  as TWS700FAreeValutazioniDettFM).dedtCodArea.SetFocus;
  //Controlli sulla testata
  try
    S700FAreeValutazioniMW.VerificaPercentuali
  Except
    on E: Exception do
    begin
      if ((Self.Owner as TWR103FGestMasterDetail).WDettaglioFM  as TWS700FAreeValutazioniDettFM).dedtPesoPercentuale.Enabled then
      ((Self.Owner as TWR103FGestMasterDetail).WDettaglioFM  as TWS700FAreeValutazioniDettFM).dedtPesoPercentuale.SetFocus;
      raise;
    end;
  end;
  if ((Self.Owner as TWR103FGestMasterDetail).WDettaglioFM  as TWS700FAreeValutazioniDettFM).dedtPesoPercMin.Enabled then
  begin
    try
      S700FAreeValutazioniMW.VerificaPeso
    Except
      on E: Exception do
      begin
        if ((Self.Owner as TWR103FGestMasterDetail).WDettaglioFM  as TWS700FAreeValutazioniDettFM).dedtPesoPercentuale.Enabled then
          ((Self.Owner as TWR103FGestMasterDetail).WDettaglioFM  as TWS700FAreeValutazioniDettFM).dedtPesoPercentuale.SetFocus;
        raise;
      end;
    end;
  end;
  try
    S700FAreeValutazioniMW.VerificaItemPersonalizzatiMin
  Except
    on E: Exception do
    begin
      ((Self.Owner as TWR103FGestMasterDetail).WDettaglioFM  as TWS700FAreeValutazioniDettFM).dedtItemPersonalizzatiMin.SetFocus;
      raise;
    end;
  end;
  res:='';
  res:=S700FAreeValutazioniMW.VerificaItemPersonalizzatiMax;
  if res <> '' then
    begin
      ((Self.Owner as TWR103FGestMasterDetail).WDettaglioFM  as TWS700FAreeValutazioniDettFM).dmemTestoItemPersonalizzati.SetFocus;
      raise exception.Create(res + ((Self.Owner as TWR103FGestMasterDetail).WDettaglioFM  as TWS700FAreeValutazioniDettFM).lblTestoItemPersonalizzati.Caption + '!');
    end;
  if (S700FAreeValutazioniMW.selSG700.State in [dsInsert]) or InterfacciaWR102.StoricizzazioneInCorso then
    ControllaSchedeEsistenti;
  inherited;
  ((Self.Owner as TWR103FGestMasterDetail).WDettaglioFM  as TWS700FAreeValutazioniDettFM).AbilitaComponenti;
end;

procedure TWS700FAreeValutazioniDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','order by cod_area, decorrenza, descrizione');
  S700FAreeValutazioniMW:=TS700FAreeValutazioniMW.Create(Self);
  S700FAreeValutazioniMW.SG701_Funzioni:=selTabella;
  dsrSG700.DataSet:=S700FAreeValutazioniMW.selSG700;
  S700FAreeValutazioniMW.AfterPostRecall:=AfterPostRecall;
  inherited;
end;

procedure TWS700FAreeValutazioniDM.AfterPostRecall;
begin
  selTabella.AfterPost:=AfterPost;
end;

procedure TWS700FAreeValutazioniDM.AfterScroll(DataSet: TDataSet);
begin
  inherited;
  S700FAreeValutazioniMW.AfterScroll;
  ((Self.Owner as TWR103FGestMasterDetail).WDettaglioFM  as TWS700FAreeValutazioniDettFM).AbilitaComponenti;
end;

procedure TWS700FAreeValutazioniDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  ControllaSchedeEsistenti;
end;

procedure TWS700FAreeValutazioniDM.ControllaSchedeEsistenti;
var res:String;
begin
  res:=S700FAreeValutazioniMW.ControllaSchedeEsistenti;
  if res <> '' then
    MsgBox.WebMessageDlg(res,mtInformation,[mbOk],nil,'');
end;

end.
