unit WA171UXMLVisiteFiscaliDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData,
  A171UXMLVisiteFiscaliMW, C004UParamForm;

type
  TWA171FXMLVisiteFiscaliDM = class(TWR302FGestTabellaDM)
    selTabellaPROGRESSIVO: TIntegerField;
    selTabellaCOGNOME: TStringField;
    selTabellaNOME: TStringField;
    selTabellaCODFISCALE: TStringField;
    selTabellaCODCATASTALE_REP: TStringField;
    selTabellaCAP_REP: TStringField;
    selTabellaVIA_REP: TStringField;
    selTabellaCOGNOME_REP: TStringField;
    selTabellaORA_RICHIESTA: TStringField;
    selTabellaCONFERMA_AMB: TStringField;
    selTabellaACCETTA_ATTI_MED: TStringField;
    selTabellaTIPO_AMB_DOM: TStringField;
    selTabellaORARIO_VISITA: TStringField;
    selTabellaOBBLIGO_ORARIO: TStringField;
    selTabellaMALATTIA_FERIE: TStringField;
    selTabellaELABORATO: TStringField;
    selTabellaDATA_RICHIESTA: TDateTimeField;
    selTabellaDATA_VISITA: TDateTimeField;
    selTabellaINIZIO_MAL: TDateTimeField;
    selTabellaFINE_MAL: TDateTimeField;
    selTabellaIndComuneCAP: TStringField;
    selTabellaDataUltimaVisita: TDateTimeField;
    selTabellaDescComuneRep: TStringField;
    selTabellaD_DETTAGLI_INDIRIZZO_REP: TStringField;
    selTabellaDETTAGLI_INDIRIZZO: TStringField;
    selTabellaD_DETTAGLI_INDIRIZZO: TStringField;
    selTabellaTELEFONO: TStringField;
    selTabellaD_TELEFONO: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure selTabellaCalcFields(DataSet: TDataSet);
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure dsrTabellaStateChange(Sender: TObject);
    procedure BeforeEdit(DataSet: TDataSet); override;
  private
    { Private declarations }
  public
    { Public declarations }
    A171MW:TA171FXMLVisiteFiscaliMW;
  end;

implementation

uses WA171UXMLVisiteFiscali, WA171UXMLVisiteFiscaliDettFM;

{$R *.dfm}

procedure TWA171FXMLVisiteFiscaliDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  NonAprireSelTabella:=True;
  A171MW:=TA171FXMLVisiteFiscaliMW.Create(Self);
  A171MW.selT049:=selTabella;
  inherited;
  A171MW.OpenSelT049;
end;

procedure TWA171FXMLVisiteFiscaliDM.dsrTabellaStateChange(Sender: TObject);
begin
  inherited;
  if (Self.Owner as TWA171FXMLVisiteFiscali) <> nil then
    with (Self.Owner as TWA171FXMLVisiteFiscali) do
    begin
      actCaricaVisite.Enabled:=Not (dsrTabella.State in [dsInsert,dsEdit]);
      actCancellaVisite.Enabled:=Not (dsrTabella.State in [dsInsert,dsEdit]);
//      pnlAzioni.Enabled:=Not (dsrTabella.State in [dsInsert,dsEdit]);
      btnGeneraXML.Enabled:=Not (dsrTabella.State in [dsInsert,dsEdit]);
      AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
    end;
  if (Self.Owner as TWA171FXMLVisiteFiscali).WDettaglioFM <> nil then
  begin
    ((Self.Owner as TWA171FXMLVisiteFiscali).WDettaglioFM as TWA171FXMLVisiteFiscaliDettFM).btnCopiaConfig.Enabled:=Not (dsrTabella.State in [dsInsert,dsEdit]);
    ((Self.Owner as TWA171FXMLVisiteFiscali).WDettaglioFM as TWA171FXMLVisiteFiscaliDettFM).dRgpTipoAmbDom.Enabled:=False;
  end;
end;

procedure TWA171FXMLVisiteFiscaliDM.AfterScroll(DataSet: TDataSet);
begin
  inherited;
  if (Self.Owner as TWA171FXMLVisiteFiscali).WDettaglioFM <> nil then
  begin
    ((Self.Owner as TWA171FXMLVisiteFiscali).WDettaglioFM as TWA171FXMLVisiteFiscaliDettFM).lblNominativo.Caption:=
      Format('Nominativo: %s %s',[selTabella.FieldByName('COGNOME').AsString,selTabella.FieldByName('NOME').AsString]);
  end;
  A171MW.selAnagrafe.SearchRecord('PROGRESSIVO',selTabella.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]);
(*    if C700SelAnagrafe.SearchRecord('PROGRESSIVO',selT049.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]) then
      (Self.Owner as TWA171FXMLVisiteFiscali).frmSelAnagrafe.VisualizzaDipendente
    else
      (Self.Owner as TWA171FXMLVisiteFiscali).frmSelAnagrafe.lblDipendente.Caption:='';*)
end;

procedure TWA171FXMLVisiteFiscaliDM.BeforeEdit(DataSet: TDataSet);
begin
  inherited;
  A171MW.BeforeEditSelT049;
end;

procedure TWA171FXMLVisiteFiscaliDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  A171MW.BeforePostSelT049;
end;

procedure TWA171FXMLVisiteFiscaliDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A171MW);
  inherited;
end;

procedure TWA171FXMLVisiteFiscaliDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  A171MW.CalcFieldSelT049;
end;

end.
