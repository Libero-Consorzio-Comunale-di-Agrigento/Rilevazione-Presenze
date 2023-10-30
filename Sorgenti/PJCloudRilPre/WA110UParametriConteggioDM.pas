unit WA110UParametriConteggioDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR303UGestMasterDetailDM, DB, OracleData, A110UParametriConteggioMW,
  A000UInterfaccia, medpIWMessageDlg, WR302UGestTabellaDM, A000USessione;

type
  TWA110FParametriConteggioDM = class(TWR303FGestMasterDetailDM)
    selTabellaCODICE: TStringField;
    selTabellaTIPO_MISSIONE: TStringField;
    selTabellaDECORRENZA: TDateTimeField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaM010OREMINIMEPERINDENNITA: TStringField;
    selTabellaLIMITEORERETRIBUITEINTERE: TStringField;
    selTabellaARROTONDAMENTOORE: TFloatField;
    selTabellaPERCRETRIBSUPEROORE: TFloatField;
    selTabellaMAXGIORNIRETRMESE: TFloatField;
    selTabellaPERCRETRIBSUPEROGG: TFloatField;
    selTabellaARROTTARIFFADOPORIDUZIONE: TStringField;
    selTabellaARROTTOTIMPORTIDATIPAGHE: TStringField;
    selTabellaRIDUZIONE_PASTO: TStringField;
    selTabellaPERCRETRIBPASTO: TFloatField;
    selTabellaTARIFFAINDENNITA: TFloatField;
    selTabellaTIPO_TARIFFA: TStringField;
    selTabellaTIPO: TStringField;
    selTabellaCODVOCEPAGHEINTERA: TStringField;
    selTabellaCODVOCEPAGHESUPHH: TStringField;
    selTabellaCODVOCEPAGHESUPGG: TStringField;
    selTabellaCODVOCEPAGHESUPHHGG: TStringField;
    selTabellaORERIMBORSOPASTO: TStringField;
    selTabellaTARIFFARIMBORSOPASTO: TFloatField;
    selTabellaORERIMBORSOPASTO2: TStringField;
    selTabellaTARIFFARIMBORSOPASTO2: TFloatField;
    selTabellaCODICI_INDENNITAKM: TStringField;
    selTabellaCODICI_RIMBORSI: TStringField;
    selTabellaCalcArrotTariffaDopoRiduzione: TStringField;
    selTabellaCalcArrotImportiDatiPaghe: TStringField;
    selTabellaMAXMESIRIMB: TFloatField;
    selTabellaDATARIF_VOCEPAGHE: TStringField;
    selTabellaIND_DA_TAB_TARIFFE: TStringField;
    selTabellaCAUSALE_MISSIONE: TStringField;
    selTabellaCalcCausale: TStringField;
    selTabellaGIUSTIF_HHMAX: TStringField;
    selTabellaGIUSTIF_COPRE_DEBITOGG: TStringField;
    selTabellaTIPO_RIMBORSOPASTO: TStringField;
    selTabelladesc_codice: TStringField;
    selTabelladesc_tipomissione: TStringField;
    selTabellaRIMB_KM_AUTO: TStringField;
    selTabellaIND_KM_AUTO: TStringField;
    selTabellaDESC_IND_KM_AUTO: TStringField;
    selTabellaRIMB_KM_AUTO_MINIMO: TIntegerField;
    selTabellaCODRIMBORSOPASTO: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure selTabellaCalcFields(DataSet: TDataSet);
    procedure selTabellaAfterOpen(DataSet: TDataSet);
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure selTabellaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure BeforePost(DataSet: TDataSet); override;
    procedure AfterPost(DataSet: TDataSet); override;
  private
    CampoCodPaghe,
    OldCodice: String;
    procedure resultVerificaCodPaghe(Sender: TObject; Res: TmeIWModalResult;
      KeyID: String);
    procedure resultVerificaRegole(Sender: TObject; Res: TmeIWModalResult;
      KeyID: String);
    function DataDecorrenzaSoglieRimborsiInput: String;
  protected
    procedure RelazionaTabelleFiglie; override;
  public
    A110FParametriConteggioMW: TA110FParametriConteggioMW;
  end;

implementation
uses WA110UParametriConteggio, WA110UParametriConteggioDettFM, WA110USoglieRimborsiPastoFM;
{$R *.dfm}

procedure TWA110FParametriConteggioDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  NonAprireSelTabella:=True;
  inherited;
  A110FParametriConteggioMW:=TA110FParametriConteggioMW.Create(Self);
  A110FParametriConteggioMW.selM010_Funzioni:=selTabella;
  A110FParametriConteggioMW.DataSogliaRimborsiInput:=DataDecorrenzaSoglieRimborsiInput;
  //tempdario
  A110FParametriConteggioMW.selM013_2.ReadOnly:=False;
  selTabella.FieldByName('desc_codice').LookupDataSet:=A110FParametriConteggioMW.QSource;
  selTabella.FieldByName('desc_tipomissione').LookupDataSet:=A110FParametriConteggioMW.selM011;
  // CUNEO_ASLCN1 - commessa 2013/107 SVILUPPO#1.ini
  // descrizione codice indennità km automatico
  selTabella.FieldByName('DESC_IND_KM_AUTO').LookupDataSet:=A110FParametriConteggioMW.selM021;
  // CUNEO_ASLCN1 - commessa 2013/107 SVILUPPO#1.fine
  selTabella.Open;
  //non relazionare. nel duplica e nella storicizzazione non vanno replicate le tabelle figlie
  //SetTabelleRelazionate([selTabella,A110FParametriConteggioMW.selM013_2]);
end;

procedure TWA110FParametriConteggioDM.AfterPost(DataSet: TDataSet);
begin
  A110FParametriConteggioMW.M010AfterPost;
  inherited;
end;

procedure TWA110FParametriConteggioDM.AfterScroll(DataSet: TDataSet);
begin
  A110FParametriConteggioMW.OpenselM021RimbAuto; // CUNEO_ASLCN1 - commessa 2013/107 SVILUPPO#1
  A110FParametriConteggioMW.OpenselM013;
  inherited;
end;

procedure TWA110FParametriConteggioDM.BeforePost(DataSet: TDataSet);
var Msg: String;
  Assenza: boolean;
begin
  inherited;
  Msg:=A110FParametriConteggioMW.ControlliFormali;
  if Msg <> '' then
  begin
    MsgBox.WebMessageDlg(Msg,mtInformation,[mbOK],nil,'');
    Abort;
  end;

  //Controllo voci paghe
  if not MsgBox.KeyExists('PUNTO_1') then
  begin
    CampoCodPaghe:='CODVOCEPAGHEINTERA';
    Msg:=A110FParametriConteggioMW.VerificaVociPaghe(CampoCodPaghe);
    if Msg <> '' then
    begin
      MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],resultVerificaCodPaghe,'PUNTO_1');
      Abort;
    end;
  end;

  if not MsgBox.KeyExists('PUNTO_2') then
  begin
    CampoCodPaghe:='CODVOCEPAGHESUPHH';
    Msg:=A110FParametriConteggioMW.VerificaVociPaghe(CampoCodPaghe);
    if Msg <> '' then
    begin
      MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],resultVerificaCodPaghe,'PUNTO_2');
      Abort;
    end;
  end;

  if not MsgBox.KeyExists('PUNTO_3') then
  begin
    CampoCodPaghe:='CODVOCEPAGHESUPGG';
    Msg:=A110FParametriConteggioMW.VerificaVociPaghe(CampoCodPaghe);
    if Msg <> '' then
    begin
      MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],resultVerificaCodPaghe,'PUNTO_3');
      Abort;
    end;
  end;

  if not MsgBox.KeyExists('PUNTO_4') then
  begin
    CampoCodPaghe:='CODVOCEPAGHESUPHHGG';
    Msg:=A110FParametriConteggioMW.VerificaVociPaghe(CampoCodPaghe);
    if Msg <> '' then
    begin
      MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],resultVerificaCodPaghe,'PUNTO_4');
      Abort;
    end;
  end;

  if not MsgBox.KeyExists('PUNTO_5') then
  begin
    Msg:=A110FParametriConteggioMW.VerificaAltreRegole;
    if Msg <> '' then
    begin
      MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],resultVerificaRegole,'PUNTO_5');
      Abort;
    end;
  end;
  Assenza:=((Self.Owner as TWA110FParametriConteggio).WDettaglioFM as TWA110FParametriConteggioDettFM).rgpCausali.ItemIndex = 1;
  A110FParametriConteggioMW.ImpostaCampiGiustif(Assenza);
end;

procedure TWA110FParametriConteggioDM.resultVerificaCodPaghe(Sender: TObject;
  Res: TmeIWModalResult; KeyID: String);
begin
  case Res of
    mrYes:
    begin
      A110FParametriConteggioMW.InserisciVocePaghe(CampoCodPaghe);
      selTabella.Post;
    end;
    mrNo:  MsgBox.ClearKeys;
  end;
end;

procedure TWA110FParametriConteggioDM.resultVerificaRegole(Sender: TObject;
  Res: TmeIWModalResult; KeyID: String);
begin
  case Res of
    mrYes: selTabella.Post;
    mrNo:  MsgBox.ClearKeys;
  end;
end;

procedure TWA110FParametriConteggioDM.OnNewRecord(DataSet: TDataSet);
begin
  A110FParametriConteggioMW.OpenselM013;
  inherited;
end;

procedure TWA110FParametriConteggioDM.RelazionaTabelleFiglie;
begin
  inherited;
  A110FParametriConteggioMW.OpenSelDistM013;
end;

procedure TWA110FParametriConteggioDM.selTabellaAfterOpen(DataSet: TDataSet);
begin
  inherited;
  A110FParametriConteggioMW.OpenselM013;
  if selTabella.RecordCount = 0 then
    AfterScroll(selTabella);
end;

procedure TWA110FParametriConteggioDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  inherited;
  A110FParametriConteggioMW.M010CalcFields(DataSet);
end;

procedure TWA110FParametriConteggioDM.selTabellaFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  A110FParametriConteggioMW.FiltroDizionarioM010(DataSet,Accept);
end;

function TWA110FParametriConteggioDM.DataDecorrenzaSoglieRimborsiInput: String;
begin
  with ((Self.Owner as TWA110FParametriConteggio).WA110FSoglieRimborsiPastoFM as TWA110FSoglieRimborsiPastoFM) do
  begin
    if edtDecorrenza.Visible then
      Result:=edtDecorrenza.Text
    else
      Result:=cmbDecorrenza.Text;
  end;
end;

procedure TWA110FParametriConteggioDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A110FParametriConteggioMW);
  inherited;
end;

end.
