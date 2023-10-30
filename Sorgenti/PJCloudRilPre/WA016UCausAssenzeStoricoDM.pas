unit WA016UCausAssenzeStoricoDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB,
  OracleData, A000UMessaggi;

type
  TWA016FCausAssenzeStoricoDM = class(TWR302FGestTabellaDM)
    selTabellaID: TIntegerField;
    selTabellaCODICE: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaVALORGIOR: TStringField;
    selTabellaVALORGIOR_ORE: TStringField;
    selTabellaVALORGIOR_COMP: TStringField;
    selTabellaVALORGIOR_ORECOMP: TStringField;
    selTabellaVALORGIOR_ORE_PROPPT: TStringField;
    selTabellaHMASSENZA: TStringField;
    selTabellaHMASSENZA_PROPPT: TStringField;
    selTabellaCAUSALI_COMPATIBILI: TStringField;
    selTabellaSTATO_COMPATIBILITA: TStringField;
    selTabellaCAUSALI_CHECKCOMPETENZE: TStringField;
    selT265: TOracleDataSet;
    selTabellaDESC_CAUSALE: TStringField;
    selTabellaDECORRENZA: TDateTimeField;
    selTabellaDECORRENZA_FINE: TDateTimeField;
    selTabellaCAUSALE_VISUALCOMPETENZE: TStringField;
    selTabellaSCARICOPAGHE_FRUIZ_GG: TStringField;
    selTabellaSCARICOPAGHE_FRUIZ_ORE: TStringField;
    selTabellaCAUSALE_FRUIZORE: TStringField;
    selTabellaCAUSALE_HMASSENZA: TStringField;
    selTabellaCHECK_SOLOCOMPETENZE: TStringField;
    selTabellaTIMB_PM: TStringField;
    selTabellaTIMB_PM_H: TStringField;
    selTabellaTIMB_PM_DETRAZ: TStringField;
    selTabellaPESOGIOR_DAORARIO: TStringField;
    selTabellaCAUS_CHECKNOCOMP_I: TStringField;
    selTabellaCAUS_CHECKNOCOMP_M: TStringField;
    selTabellaCAUS_CHECKNOCOMP_N: TStringField;
    selTabellaCAUS_CHECKNOCOMP_D: TStringField;
    selTabellaGIUST_DAA_RECUP_FLEX: TStringField;
    selTabellaABBATTE_STRIND: TStringField;
    selTabellaCONTEGGIO_TIMB_INTERNA: TStringField;
    selTabellaINTERSEZIONE_TIMBRATURE: TStringField;
    selTabellaSCELTA_ORARIO: TStringField;
    selTabellaINDPRES: TStringField;
    selTabellaINDTURNO: TStringField;
    selTabellaFRUIZ_INTERNA_PN: TStringField;
    selTabellaCM_CAUSPRES_INCLUSE: TStringField;
    selTabellaCOMPETENZE_PERSONALIZZATE: TStringField;
    selTabellaARROT_COMPETENZE: TStringField;
    selTabellaARROT_RESIDUI: TStringField;
    selTabellaCONDIZIONE_ALLEGATI: TStringField;
    selTabellaGEDAP_CAUSALE: TStringField;
    selTabellaGEDAP_TIPO: TStringField;
    selTabellaINDPRES_FESTIVO: TStringField;
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure ValidaCampoOrario(Sender: TField);
    procedure BeforePost(DataSet: TDataSet); override;
    procedure dsrTabellaStateChange(Sender: TObject);
    procedure selTabellaCAUSALI_COMPATIBILIGetText(Sender: TField;
      var Text: string; DisplayText: Boolean);
    procedure dsrTabellaDataChange(Sender: TObject; Field: TField);
  private

  public
    IDCausale:Integer;
    procedure Inizializza;
  end;

implementation

uses C180FunzioniGenerali,WA016UCausAssenzeStorico,WA016UCausAssenzeStoricoDettFM,
     A016UCausAssenzeStoricoMW;

{$R *.dfm}

procedure TWA016FCausAssenzeStoricoDM.AfterScroll(DataSet: TDataSet);
var
  FormPrincipale:TWA016FCausAssenzeStorico;
  DettaglioFM:TWA016FCausAssenzeStoricoDettFM;
begin
  inherited;
  FormPrincipale:=(Owner as TWA016FCausAssenzeStorico);
  DettaglioFM:=(FormPrincipale.WDettaglioFM as TWA016FCausAssenzeStoricoDettFM);
  if DettaglioFM <> nil then
  begin
    DettaglioFM.PopolaComboVisualCompetenze;
  end;
end;

procedure TWA016FCausAssenzeStoricoDM.BeforePost(
  DataSet: TDataSet);
var
  FormPrincipale:TWA016FCausAssenzeStorico;
  DettaglioFM:TWA016FCausAssenzeStoricoDettFM;
  CampoControllo,FocusJS:String;
begin
  FormPrincipale:=(Owner as TWA016FCausAssenzeStorico);
  DettaglioFM:=(FormPrincipale.WDettaglioFM as TWA016FCausAssenzeStoricoDettFM);
  CampoControllo:=TA016FCausAssenzeStoricoMW.ControllaCampiObbligatori(DataSet);
  if (CampoControllo <> '') then
  begin
    if (CampoControllo = 'VALORGIOR_ORE') then
      FocusJS:=DettaglioFM.dedtValorGiorOre.HTMLName
    else
      FocusJS:=DettaglioFM.dedtValorGiorOreComp.HTMLName;
    FocusJS:='$("#' + FocusJS + '").focus();';
    FormPrincipale.WA016FCausAssenze.AddToInitProc(FocusJS);
    raise Exception.Create(A000MSG_A016_ERR_VALORGIOR_ORE_FISSE);
  end;
  R180OraValidate(DataSet.FieldByName('VALORGIOR_ORE').AsString);
  R180OraValidate(DataSet.FieldByName('VALORGIOR_ORECOMP').AsString);
  R180OraValidate(DataSet.FieldByName('HMASSENZA').AsString);
  inherited;
end;

procedure TWA016FCausAssenzeStoricoDM.dsrTabellaDataChange(Sender: TObject;
  Field: TField);
var
  FormPrincipale:TWA016FCausAssenzeStorico;
  DettaglioFM:TWA016FCausAssenzeStoricoDettFM;
begin
  inherited;
  FormPrincipale:=(Owner as TWA016FCausAssenzeStorico);
  DettaglioFM:=(FormPrincipale.WDettaglioFM as TWA016FCausAssenzeStoricoDettFM);
  if DettaglioFM <> nil then
  begin
    if (Field <> nil) and ((Field.FieldName = 'CAUSALI_CHECKCOMPETENZE') or (Field.FieldName = 'CAUSALI_VISUALCOMPETENZE')) then
      DettaglioFM.PopolaComboVisualCompetenze;
  end;
end;

procedure TWA016FCausAssenzeStoricoDM.dsrTabellaStateChange(
  Sender: TObject);
var
  FormPrincipale:TWA016FCausAssenzeStorico;
  DettaglioFM:TWA016FCausAssenzeStoricoDettFM;
begin
  inherited;
  FormPrincipale:=(Owner as TWA016FCausAssenzeStorico);
  DettaglioFM:=(FormPrincipale.WDettaglioFM as TWA016FCausAssenzeStoricoDettFM);
end;

procedure TWA016FCausAssenzeStoricoDM.Inizializza;
begin
  selTabella.SetVariable('ID',IDCausale);
  selT265.Open;
  selTabella.Open;
end;

procedure TWA016FCausAssenzeStoricoDM.selTabellaCAUSALI_COMPATIBILIGetText(
  Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if Sender.AsString <> '' then
    Text:=Sender.AsString
  else
    Text:=A000MSG_A016_MSG_NO_CAUSALI_COMP;
end;

procedure TWA016FCausAssenzeStoricoDM.ValidaCampoOrario(Sender: TField);
var
  StringFieldSender:TStringField;
begin
  StringFieldSender:=(Sender as TStringField);
  R180OraValidate(StringFieldSender.AsString);
end;

end.
