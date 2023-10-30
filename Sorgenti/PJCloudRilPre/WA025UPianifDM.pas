unit WA025UPianifDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR302UGestTabellaDM, DB, OracleData,
  A000UInterfaccia, A000USessione, A025UPianifMW, A000UMessaggi,
  C180FunzioniGenerali;

type
  TWA025FPianifDM = class(TWR302FGestTabellaDM)
    selTabellaPROGRESSIVO: TFloatField;
    selTabellaDATA: TDateTimeField;
    selTabellaORARIO: TStringField;
    selTabellaD_ORARIO: TStringField;
    selTabellaTURNO1: TStringField;
    selTabellaTURNO1EU: TStringField;
    selTabellaTURNO2: TStringField;
    selTabellaTURNO2EU: TStringField;
    selTabellaVALORGIOR: TStringField;
    selTabellaFLAGAGG: TStringField;
    selTabellaINDPRESENZA: TStringField;
    selTabellaD_INDENNITA: TStringField;
    selTabellaDATOLIBERO: TStringField;
    selTabellaD_DATOLIBERO: TStringField;
    selTabellaMOTIVAZIONE: TStringField;
    selTabellaD_MOTIVAZIONE: TStringField;
    selTabellaNOTE: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure BeforeDelete(DataSet: TDataSet);Override;
    procedure BeforePostNoStorico(DataSet: TDataSet);Override;
    procedure OnNewRecord(DataSet: TDataSet);Override;
    procedure selTabellaORARIOSetText(Sender: TField; const Text: string);
    procedure selTabellaORARIOValidate(Sender: TField);
    procedure selTabellaTURNO1Validate(Sender: TField);
    procedure selTabellaTURNO1EUValidate(Sender: TField);
    procedure selTabellaTURNO2Validate(Sender: TField);
    procedure selTabellaTURNO2EUValidate(Sender: TField);
    procedure Q080INDPRESENZASetText(Sender: TField; const Text: string);
    procedure Q080INDPRESENZAValidate(Sender: TField);
    procedure Q080DATOLIBEROSetText(Sender: TField; const Text: string);
    procedure Q080DATOLIBEROValidate(Sender: TField);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure dsrTabellaStateChange(Sender: TObject);
  private
    function CalcolaDataA: TDateTime;
    function CalcolaDataDa: TDateTime;
    function CampoOrarioVisibile: boolean;
  public
    DatoLiberoPickList, IndPresenzaPickList, OrarioPickList: TStrings;
    //Turno1EuPickList, Turno2EuPickList: Tstrings;
    A025MW: TA025FPianifMW;
  end;

implementation

uses WA025UPianif, WA025UPianifBrowseFM;

{$R *.dfm}

procedure TWA025FPianifDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  NonAprireSelTabella:=True;
  SelTabella.SetVariable('ORDERBY','order by DATA');
  inherited;
  DatoLiberoPickList:=TStringList.Create;
  IndPresenzaPickList:=TStringList.Create;
  OrarioPickList:=TStringList.Create;
  //Utente: AOSTA_REGIONE Chiamata: 92165. controllo E/U. le due TStrings non servono
  //Turno1EuPickList:=TStringList.Create;
  //Turno2EuPickList:=TStringList.Create;
  A025MW:=TA025FPianifMW.Create(Self);
  A025MW.SelT080:=SelTabella;
  A025MW.CalcolaDataDa:=CalcolaDataDa;
  A025MW.CalcolaDataA:=CalcolaDataA;
  A025MW.CampoOrarioVisibile:=CampoOrarioVisibile;
  A025MW.Inizializza;

  selTabella.FieldByName('D_ORARIO').LookupDataSet:=A025MW.Q020;
  selTabella.FieldByName('D_INDENNITA').LookupDataSet:=A025MW.Q163;
  selTabella.FieldByName('D_DATOLIBERO').LookupDataSet:=A025MW.selDatoLibero;
  selTabella.FieldByName('D_MOTIVAZIONE').LookupDataSet:=A025MW.cdsMotivazione;

  if A000LookupTabella(Parametri.CampiRiferimento.C3_DatoPianificabile,A025MW.selDatoLibero) then
  begin
    if Parametri.CampiRiferimento.C3_DatoPianificabile = 'COMUNE' then
      SelTabella.FieldbyName('D_DATOLIBERO').Tag:=999;
    if A025MW.selDatoLibero.VariableIndex('DECORRENZA') >= 0 then
      A025MW.selDatoLibero.SetVariable('DECORRENZA',R180FineMese(Parametri.DataLavoro));
      SelTabella.FieldByName('DATOLIBERO').Visible:=True;
  end
  else
  begin
    A025MW.selDatoLibero.SQL.Clear;
    A025MW.selDatoLibero.SQL.Add('SELECT NULL CODICE, NULL DESCRIZIONE FROM DUAL');
    SelTabella.FieldByName('DATOLIBERO').Visible:=False;
  end;
  A025MW.selDatoLibero.Open;
  A025MW.SetSelT080;
end;

procedure TWA025FPianifDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(DatoLiberoPickList);
  FreeAndNil(IndPresenzaPickList);
  FreeAndNil(OrarioPickList);
  //Utente: AOSTA_REGIONE Chiamata: 92165. controllo E/U. le due TStrings non servono
  //FreeAndNil(Turno1EuPickList);
  //FreeAndNil(Turno2EuPickList);
  inherited;
end;

procedure TWA025FPianifDM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  SelTabella.FieldByName('PROGRESSIVO').AsInteger:=(Self.Owner as TWA025FPianif).grdC700.SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
end;

procedure TWA025FPianifDM.Q080DATOLIBEROSetText(Sender: TField; const Text: string);
begin
  Sender.AsString:=Trim(Copy(Text,1,20));
end;

procedure TWA025FPianifDM.Q080DATOLIBEROValidate(Sender: TField);
begin
  if SelTabella.FieldByName('DATOLIBERO').AsString <> '' then
    if R180IndexOf(DatoLiberoPickList,SelTabella.FieldByName('DATOLIBERO').AsString,20) = -1 then
      raise Exception.Create('Codice ' +  SelTabella.FieldByName('DATOLIBERO').DisplayLabel + ' non valido!');
end;

procedure TWA025FPianifDM.Q080INDPRESENZASetText(Sender: TField; const Text: string);
begin
  Sender.AsString:=Trim(Copy(Text,1,5));
end;

procedure TWA025FPianifDM.Q080INDPRESENZAValidate(Sender: TField);
begin
  if SelTabella.FieldByName('INDPRESENZA').AsString <> '' then
    if R180IndexOf(IndPresenzaPickList,SelTabella.FieldByName('INDPRESENZA').AsString,5) = -1 then
      raise Exception.Create(A000MSG_A025_ERR_COD_INDENNITA);
end;

procedure TWA025FPianifDM.selTabellaORARIOSetText(Sender: TField; const Text: string);
begin
  Sender.AsString:=Trim(Copy(Text,1,5));
end;

procedure TWA025FPianifDM.selTabellaORARIOValidate(Sender: TField);
begin
  if Trim(SelTabella.FieldByName('ORARIO').AsString) <> '' then
    if R180IndexOf(OrarioPickList,SelTabella.FieldByName('ORARIO').AsString,5) = -1 then
      raise Exception.Create(A000MSG_A025_ERR_COD_ORARIO);
end;

procedure TWA025FPianifDM.selTabellaTURNO1EUValidate(Sender: TField);
begin
  //Utente: AOSTA_REGIONE Chiamata: 92165. controllo E/U. In Win controllo necessario perchè la picklist consente
  //di inserire valori non presenti nella lista. in cloud la combobox consente solo la selezione degli elementi presenti e quindi
  //controllo non necessario. Perdipiù il controllo era errato perchè controllava su Turno1EuPickList che non era valorizzata con la lista
  (*
  if Trim(SelTabella.FieldByName('TURNO1EU').AsString) <> '' then
    if R180IndexOf(Turno1EuPickList,SelTabella.FieldByName('TURNO1EU').AsString,1) = -1 then
      raise Exception.Create(A000MSG_A025_ERR_TURNO1EU)
  *)
end;

procedure TWA025FPianifDM.selTabellaTURNO1Validate(Sender: TField);
begin
  if Trim(SelTabella.FieldByName('TURNO1').AsString) <> '' then
    if StrToIntDef(Trim(SelTabella.FieldByName('TURNO1').AsString),-1) = -1 then
      raise Exception.Create(A000MSG_A025_ERR_TURNO1);
end;

procedure TWA025FPianifDM.selTabellaTURNO2EUValidate(Sender: TField);
begin
  //Utente: AOSTA_REGIONE Chiamata: 92165. controllo E/U. In Win controllo necessario perchè la picklist consente
  //di inserire valori non presenti nella lista. in cloud la combobox consente solo la selezione degli elementi presenti e quindi
  //controllo non necessario. Perdipiù il controllo era errato perchè controllava su Turno2EuPickList che non era valorizzata con la lista
  (*
  if Trim(SelTabella.FieldByName('TURNO2EU').AsString) <> '' then
    if R180IndexOf(Turno2EuPickList,SelTabella.FieldByName('TURNO2EU').AsString,1) = -1 then
      raise Exception.Create(A000MSG_A025_ERR_TURNO2EU);
  *)
end;

procedure TWA025FPianifDM.selTabellaTURNO2Validate(Sender: TField);
begin
  if Trim(SelTabella.FieldByName('TURNO2').AsString) <> '' then
    if StrToIntDef(Trim(SelTabella.FieldByName('TURNO2').AsString),-1) = -1 then
      raise Exception.Create(A000MSG_A025_ERR_TURNO2);
end;

procedure TWA025FPianifDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  A025MW.SelT080BeforeDelete;
end;

procedure TWA025FPianifDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  A025MW.DatoLiberoCaption:=SelTabella.FieldByName('DATOLIBERO').DisplayLabel;
  A025MW.SelT080BeforePost;
  inherited;
end;

function TWA025FPianifDM.CalcolaDataA: TDateTime;
begin
  try
    if ((Self.Owner as TWA025FPianif).WBrowseFM as TWA025FPianifBrowseFM) <> nil then
      with  ((Self.Owner as TWA025FPianif).WBrowseFM as TWA025FPianifBrowseFM).edtDataA do
      begin
        if Trim(Text) = '' then
          Text:=DateToStr(Date);
        Result:=StrToDate(Text);
      end
    else
      Result:=Date;
  except
    Result:=StrToDate('31/12/3999');
  end;
end;

function TWA025FPianifDM.CalcolaDataDa: TDateTime;
begin
  try
    if ((Self.Owner as TWA025FPianif).WBrowseFM as TWA025FPianifBrowseFM) <> nil then
      with ((Self.Owner as TWA025FPianif).WBrowseFM as TWA025FPianifBrowseFM).edtDataDa do
      begin
        if Trim(Text) = '' then
          Text:=DateToStr(Date);
        Result:=StrToDate(Text);
      end
    else
      Result:=Date;
  except
    Result:=StrToDate('01/01/1900');
  end;
end;

function TWA025FPianifDM.CampoOrarioVisibile: boolean;
begin
  Result:=SelTabella.FieldByName('DATOLIBERO').Visible;
end;

procedure TWA025FPianifDM.dsrTabellaStateChange(Sender: TObject);
begin
  inherited;
(*TEMPDARIO
  if ((Self.Owner as TWA025FPianif).WBrowseFM as TWA025FPianifBrowseFM) <> nil then
    ((Self.Owner as TWA025FPianif).WBrowseFM as TWA025FPianifBrowseFM).ControllaCheckInsPeriodo;
*)
end;

end.
