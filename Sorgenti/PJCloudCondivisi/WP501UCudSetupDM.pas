unit WP501UCudSetupDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR302UGestTabellaDM, DB, OracleData, A000UInterfaccia, P501UCudSetupMW,
  Oracle;

type
  TWP501FCudSetupDM = class(TWR302FGestTabellaDM)
    selTabellaANNO: TIntegerField;
    selTabellaCOD_FISCALE: TStringField;
    selTabellaDENOMINAZIONE: TStringField;
    selTabellaCOMUNE: TStringField;
    selTabellaCOD_COMUNE: TStringField;
    selTabellaPROVINCIA: TStringField;
    selTabellaCAP: TStringField;
    selTabellaINDIRIZZO: TStringField;
    selTabellaTELEFONO: TStringField;
    selTabellaFAX: TStringField;
    selTabellaE_MAIL: TStringField;
    selTabellaCOD_VALUTA: TStringField;
    selTabellaD_VALUTA: TStringField;
    selTabellaCODICE_ATTIVITA: TStringField;
    selTabellaFIRMATARIO: TStringField;
    selTabellaWEB_STAMPA: TStringField;
    selTabellaWEB_DATA_STAMPA: TDateTimeField;
    selTabellaWEB_PATH_ISTRUZIONI: TStringField;
    selTabellaWEB_ANNOTAZIONI: TStringField;
    selTabellaTIPO_FORNITORE: TStringField;
    selTabellaSTATO_ENTE: TStringField;
    selTabellaNATURA_GIURIDICA: TStringField;
    selTabellaSITUAZIONE_ENTE: TStringField;
    selTabellaCOD_FISCALE_DICASTERO: TStringField;
    selTabellaCOD_FISCALE_SW_DMA: TStringField;
    selTabellaDATA_VERS_IRPEF01: TDateTimeField;
    selTabellaDATA_VERS_IRPEF02: TDateTimeField;
    selTabellaDATA_VERS_IRPEF03: TDateTimeField;
    selTabellaDATA_VERS_IRPEF04: TDateTimeField;
    selTabellaDATA_VERS_IRPEF05: TDateTimeField;
    selTabellaDATA_VERS_IRPEF06: TDateTimeField;
    selTabellaDATA_VERS_IRPEF07: TDateTimeField;
    selTabellaDATA_VERS_IRPEF08: TDateTimeField;
    selTabellaDATA_VERS_IRPEF09: TDateTimeField;
    selTabellaDATA_VERS_IRPEF10: TDateTimeField;
    selTabellaDATA_VERS_IRPEF11: TDateTimeField;
    selTabellaDATA_VERS_IRPEF12: TDateTimeField;
    selTabellaCODICE_FORNITURA_DMA: TStringField;
    selTabellaTIPO_FORNITORE_DMA: TStringField;
    selTabellaCODICE_ATECO_DMA: TStringField;
    selTabellaCODICE_FORMA_GIUR_DMA: TStringField;
    selTabellaCODICE_COMPARTO_DMA: TStringField;
    selTabellaCODICE_SOTTOCOMPARTO_DMA: TStringField;
    selTabellaFIRMA_DENUNCIA_DMA: TStringField;
    selTabellaMATRICOLA_INPS: TStringField;
    selTabellaSEDE_INPS: TStringField;
    selTabellaCOD_FISCALE_MITT_EMENS: TStringField;
    selTabellaCODICE_ISTAT_EMENS: TStringField;
    selTabellaCODICE_INPDAP_DMA: TStringField;
    selTabellaCODICE_FORMA_GIUR_DMA2: TStringField;
    selTabellaCOD_CONTRATTO_DMA2: TStringField;
    selTabellaCODICE_AZIENDA_INPGI: TStringField;
    selTabellaCODICE_AZIENDA_ENPAM: TStringField;
    selTabellaCOD_FISCALE_FIRMA: TStringField;
    selTabellaSESSO_FIRMA: TStringField;
    selTabellaCOGNOME_FIRMA: TStringField;
    selTabellaNOME_FIRMA: TStringField;
    selTabellaCOMUNE_NASCITA_FIRMA: TStringField;
    selTabellaPROVINCIA_NASCITA_FIRMA: TStringField;
    selTabellaDATA_NASCITA_FIRMA: TDateTimeField;
    selTabellaCOMUNE_RESIDENZA_FIRMA: TStringField;
    selTabellaPROVINCIA_RESIDENZA_FIRMA: TStringField;
    selTabellaCAP_RESIDENZA_FIRMA: TStringField;
    selTabellaINDIRIZZO_FIRMA: TStringField;
    selTabellaTELEFONO_FIRMA: TStringField;
    selTabellaCODICE_CARICA_FIRMA: TStringField;
    selTabellaDECORRENZA_CARICA_FIRMA: TDateTimeField;
    selTabellaCOD_SIA: TStringField;
    selTabellaCOD_ABI: TStringField;
    selTabellaCOD_CAB: TStringField;
    selTabellaCONTO_CORRENTE: TStringField;
    selTabellaID_ABBONATO_POSTEL: TStringField;
    selTabellaTIPOLOGIA_INVIO_POSTEL: TStringField;
    selTabellaCOLORE_POSTEL: TStringField;
    selTabellaPROCEDURA_POSTEL: TStringField;
    selTabellaTRATTAMENTO_POSTEL: TStringField;
    selTabellaCENTRO_COSTO_POSTEL: TStringField;
    selTabellaIND_DOM_POSTEL: TStringField;
    selTabellaCAP_DOM_POSTEL: TStringField;
    selTabellaCOM_DOM_POSTEL: TStringField;
    selTabellaPRV_DOM_POSTEL: TStringField;
    selTabellaSEDE_SERVIZIO_CED: TStringField;
    selTabellaUNITA_OP_CED: TStringField;
    selTabellaQUALIFICA_CED: TStringField;
    selTabellaDATA_INIZIO_CED: TStringField;
    selTabellaPIVA_CED: TStringField;
    selTabellaPATH_FILEPDF_CED: TStringField;
    selTabellaFAM_DATA_DA: TDateTimeField;
    selTabellaFAM_DATA_A: TDateTimeField;
    selTabellaFAM_STATO_CIVILE: TStringField;
    selTabellaFAM_PATH_ISTRUZIONI: TStringField;
    selTabellaFAM_NOTE: TStringField;
    selTabellaCOD_IBAN: TStringField;
    selTabellaNOME_FILEPDF_CED: TStringField;
    selTabellaCOD_AZIENDA_BASE: TStringField;
    selTabellaD_AZIENDA_BASE: TStringField;
    selTabellaE_MAIL_PEC: TStringField;
    selTabellaCODICE_AZIENDA_ONAOSI: TStringField;
    selTabellaNOMIN_RESP_UO_ONAOSI: TStringField;
    selTabellaTELEFONO_RESP_UO_ONAOSI: TStringField;
    selTabellaE_MAIL_RESP_UO_ONAOSI: TStringField;
    selTabellaNOMIN_RESP_PROC_ONAOSI: TStringField;
    selTabellaTELEFONO_RESP_PROC_ONAOSI: TStringField;
    selTabellaE_MAIL_RESP_PROC_ONAOSI: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure dsrTabellaDataChange(Sender: TObject; Field: TField);
    procedure dsrTabellaStateChange(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet);Override;
    procedure OnNewRecord(DataSet: TDataSet);Override;
  private
    procedure VisualizzaTab (Nometab: String);
  public
    P501FCudSetupMW: TP501FCudSetupMW;
  end;

implementation

uses WP501UCudSetup, WP501UCudSetupDettFM;

{$R *.dfm}

procedure TWP501FCudSetupDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  P501FCudSetupMW:=TP501FCudSetupMW.Create(Self);
  P501FCudSetupMW.selP500:=selTabella;
  P501FCudSetupMW.VisualizzaTab:=VisualizzaTab;
  selTabella.SetVariable('ORDERBY','ORDER BY ANNO DESC');
  selTabella.FieldByName('D_VALUTA').LookupDataSet:=P501FCudSetupMW.selP030;
  selTabella.FieldByName('D_AZIENDA_BASE').LookupDataSet:=P501FCudSetupMW.selT440;
  selTabella.FieldByName('COD_AZIENDA_BASE').Visible:=P501FCudSetupMW.selT440.RecordCount > 1;
  selTabella.FieldByName('D_AZIENDA_BASE').Visible:=P501FCudSetupMW.selT440.RecordCount > 1;
  inherited;
end;

procedure TWP501FCudSetupDM.dsrTabellaDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  if (Self.Owner as TWP501FCudSetup).WDettaglioFM <> nil then
    ((Self.Owner as TWP501FCudSetup).WDettaglioFM as TWP501FCudSetupDettFM).AbilitazioniMultiAzienda;
end;

procedure TWP501FCudSetupDM.dsrTabellaStateChange(Sender: TObject);
begin
  inherited;
  if (Self.Owner as TWP501FCudSetup).WDettaglioFM <> nil then
    ((Self.Owner as TWP501FCudSetup).WDettaglioFM as TWP501FCudSetupDettFM).cmbCodAziendaBase.Enabled:=dsrTabella.State <> dsEdit;
end;

procedure TWP501FCudSetupDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  P501FCudSetupMW.BeforePost;
end;

procedure TWP501FCudSetupDM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  P501FCudSetupMW.ImpostaAnno;
end;

procedure TWP501FCudSetupDM.VisualizzaTab(Nometab: String);
begin
  with ((Self.Owner as TWP501FCudSetup).WDettaglioFM as TWP501FCudSetupDettFM) do
  begin
    if Nometab = P501FCudSetupMW.tabFamiliari then
      grdTabDetail.ActiveTab:=WP501FamiliariRG
    else if Nometab = P501FCudSetupMW.tabCedolino then
      grdTabDetail.ActiveTab:=WP501CedolinoRG;
  end;
end;

end.
