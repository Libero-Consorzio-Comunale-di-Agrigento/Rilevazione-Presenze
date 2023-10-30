unit WA046UTerMensaDM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Variants, DB, OracleData, Oracle,
  A000UMessaggi, A000UCostanti, A000USessione, A000UInterfaccia, C180FunzioniGenerali, ControlloVociPaghe, RegistrazioneLog,
  medpIWMessageDlg, WR100UBase, WR302UGestTabellaDM;

type
  TWA046FTerMensaDM = class(TWR302FGestTabellaDM)
    selInterfaccia: TOracleDataSet;
    dsrInterfaccia: TDataSource;
    selTabellaCODICE: TStringField;
    selTabellaD_CODICE: TStringField;
    selTabellaNUMTIMBPASTO: TStringField;
    selTabellaINTERVALLO: TStringField;
    selTabellaPAUSAMENSAGESTITA: TStringField;
    selTabellaPRESENZAMINIMA: TStringField;
    selTabellaVOCEPAGHE1: TStringField;
    selTabellaVOCEPAGHE2: TStringField;
    selTabellaORARIOSPEZZATO: TStringField;
    selTabellaCAUSALE: TStringField;
    selTabellaCENA_DALLE: TStringField;
    selTabellaCENA_ALLE: TStringField;
    selTabellaORE_MINIME: TStringField;
    selTabellaMENSA_STIMBRATA_INTERO: TStringField;
    selTabellaMENSA_NON_STIMBRATA_INTERO: TStringField;
    selTabellaTIMBANTECENTRATA_INTERO: TStringField;
    selTabellaTIMBDOPOUSCITA_INTERO: TStringField;
    selTabellaCONTROLLOPRESENZA_INTERO: TStringField;
    selTabellaORARIOSPEZZATO_INTERO: TStringField;
    selTabellaPAUSAMENSAGESTITA_INTERO: TStringField;
    selTabellaPRESENZAMINIMA_INTERO: TStringField;
    selTabellaINTERVALLO_INTERO: TStringField;
    selTabellaORE_MINIME_INTERO: TStringField;
    selTabellaALIMENTA_BUONIPASTO: TStringField;
    selTabellaMATURA_BUONO: TStringField;
    selTabellaMATURA_BUONO_INTERO: TStringField;
    selTabellaMENSA_DALLE: TStringField;
    selTabellaMENSA_ALLE: TStringField;
    selTabellaINTERVALLO_PM_INTERO: TStringField;
    SelTabellaDIFFTRA2TIMB: TDateTimeField;
    procedure AfterCancel(DataSet: TDataSet);override;
    procedure AfterDelete(DataSet: TDataSet);override;
    procedure AfterPost(DataSet: TDataSet);override;
    procedure BeforeEdit(DataSet: TDataSet);override;
    procedure BeforePostNoStorico(DataSet: TDataSet);override;
    procedure selTabellaCalcFields(DataSet: TDataSet);
    procedure OnNewRecord(DataSet: TDataSet);override;
    procedure SelTabellaDIFFTRA2TIMBGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure BDESelTabellaDIFFTRA2TIMBSetText(Sender: TField; const Text: string);
    procedure Q360TerMensaDIFFTRA2TIMBGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure SelTabellaDIFFTRA2TIMBSetText(Sender: TField; const Text: string);
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
  private
    selControlloVociPaghe:TControlloVociPaghe;
    procedure CheckVocePaghe1(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure CheckVocePaghe2(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure controlloOre;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TWA046FTerMensaDM.IWUserSessionBaseCreate(Sender: TObject);
  var i:Integer;
begin
  NonAprireSelTabella:=True;
  inherited;
  if A000LookupTabella(Parametri.CampiRiferimento.C18_AccessiMensa,selInterfaccia) then
  begin
    if selInterfaccia.VariableIndex('DECORRENZA') >= 0 then
      selInterfaccia.SetVariable('DECORRENZA',EncodeDate(3999,12,31));
    selInterfaccia.Open;
  end;
  selTabella.Open;

  selControlloVociPaghe:=TControlloVociPaghe.Create(Self,'');
end;

procedure TWA046FTerMensaDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(selControlloVociPaghe);
end;

procedure TWA046FTerMensaDM.AfterCancel(DataSet: TDataSet);
begin
  inherited;
  MsgBox.ClearKeys;
end;

procedure TWA046FTerMensaDM.AfterDelete(DataSet: TDataSet);
begin
  inherited;
  MsgBox.ClearKeys;
end;

procedure TWA046FTerMensaDM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  MsgBox.ClearKeys;
end;

procedure TWA046FTerMensaDM.BDESelTabellaDIFFTRA2TIMBSetText(Sender: TField; const Text: string);
begin
  {$I CampoOra}
end;

procedure TWA046FTerMensaDM.BeforeEdit(DataSet: TDataSet);
begin
  inherited;
  if (selInterfaccia.Active) and (trim(selTabella.FieldByName('CODICE').AsString)='') then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,['Codice']),mtError,[mbOk],nil,'');
    Abort;
  end;
end;

procedure TWA046FTerMensaDM.BeforePostNoStorico(DataSet: TDataSet);
var VoceOld:String;
begin
  inherited;
  if not MsgBox.KeyExists('PUNTO_1') then
  begin
    if (selInterfaccia.Active) and (trim(selTabella.FieldByName('CODICE').AsString)='') then
    begin
      MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,['Codice']),mtError,[mbOk],nil,'');
      Abort;
    end;
    controlloOre;
    if (not selTabellaCENA_DALLE.IsNull) or (not selTabellaCENA_ALLE.IsNull) then
      if R180OreMinutiExt(SelTabella.FieldByName('Cena_Dalle').AsString) > R180OreMinutiExt(SelTabella.FieldByName('Cena_Alle').AsString) then
        raise Exception.Create('L''intervallo della Cena non è corretto!');
    //Controllo voci paghe
    if (DataSet.State = dsInsert) or (SelTabella.FieldByName('VOCEPAGHE1').medpOldValue = null) then
      VoceOld:=''
    else
      VoceOld:=SelTabella.FieldByName('VOCEPAGHE1').medpOldValue;
    if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,SelTabella.FieldByName('VOCEPAGHE1').AsString) then
    begin
      MsgBox.webMessageDlg(selControlloVociPaghe.MessaggioLog,mtConfirmation,[mbYes,mbNo],CheckVocePaghe1,'PUNTO_1');
      Abort;
    end;
  end;

  if not MsgBox.KeyExists('PUNTO_2') then
  begin
  if (DataSet.State = dsInsert) or (SelTabella.FieldByName('VOCEPAGHE2').medpOldValue = null) then
    VoceOld:=''
  else
    VoceOld:=SelTabella.FieldByName('VOCEPAGHE2').medpOldValue;
  if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,SelTabella.FieldByName('VOCEPAGHE2').AsString) then
     begin
      MsgBox.webMessageDlg(selControlloVociPaghe.MessaggioLog,mtConfirmation,[mbYes,mbNo],CheckVocePaghe2,'PUNTO_2');
      Abort;
    end;
  end;

  if not selInterfaccia.Active then
    SelTabella.FieldByName('CODICE').AsString:='<UNICA>';
end;

procedure TWA046FTerMensaDM.CheckVocePaghe1(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrYes then
  begin
    selControlloVociPaghe.ValutaInserimentoVocePaghe(SelTabella.FieldByName('VOCEPAGHE1').AsString);
    selTabella.Post;
  end
  else
    MsgBox.clearKeys;
end;

procedure TWA046FTerMensaDM.CheckVocePaghe2(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrYes then
  begin
    selControlloVociPaghe.ValutaInserimentoVocePaghe(SelTabella.FieldByName('VOCEPAGHE2').AsString);
    selTabella.Post;
  end
  else
    MsgBox.clearKeys;
end;

procedure TWA046FTerMensaDM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  SelTabella.FieldByName('DIFFTRA2TIMB').AsDateTime:=0;
end;

procedure TWA046FTerMensaDM.Q360TerMensaDIFFTRA2TIMBGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if Sender.IsNull then Text:='' else Text:=FormatDateTime('hh:nn',Sender.AsDateTime);
end;

procedure TWA046FTerMensaDM.SelTabellaDIFFTRA2TIMBSetText(Sender: TField; const Text: string);
begin
  {$I CampoOra}
end;

procedure TWA046FTerMensaDM.SelTabellaDIFFTRA2TIMBGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if Sender.IsNull then Text:='' else Text:=FormatDateTime('hh:nn',Sender.AsDateTime);
end;

procedure TWA046FTerMensaDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  if selInterfaccia.Active then
    SelTabella.FieldByName('D_CODICE').AsString:=varToStr(selInterfaccia.Lookup('CODICE',SelTabella.FieldByName('CODICE').AsString,'DESCRIZIONE'))
  else
    SelTabella.FieldByName('D_CODICE').AsString:='<INTERFACCIA UNICA>';
end;

procedure TWA046FTerMensaDM.controlloOre;
begin
  if not SelTabella.FieldByname('INTERVALLO').IsNull then
    R180OraValidate(SelTabella.FieldByname('INTERVALLO').AsString);
  if not SelTabella.FieldByname('MENSA_DALLE').IsNull then
    R180OraValidate(SelTabella.FieldByname('MENSA_DALLE').AsString);
  if not SelTabella.FieldByname('MENSA_ALLE').IsNull then
    R180OraValidate(SelTabella.FieldByname('MENSA_ALLE').AsString);
  if not SelTabella.FieldByname('CENA_DALLE').IsNull then
    R180OraValidate(SelTabella.FieldByname('CENA_DALLE').AsString);
  if not SelTabella.FieldByname('CENA_ALLE').IsNull then
    R180OraValidate(SelTabella.FieldByname('CENA_ALLE').AsString);
  if not SelTabella.FieldByname('ORE_MINIME').IsNull then
    R180OraValidate(SelTabella.FieldByname('ORE_MINIME').AsString);
end;

end.
