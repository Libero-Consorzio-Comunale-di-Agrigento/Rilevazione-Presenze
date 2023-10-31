unit A177UFerieSolidaliDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R004UGestStoricoDTM, Data.DB, OracleData, Math, StrUtils,
  Oracle, C700USelezioneAnagrafe, A000USessione, A000UInterfaccia, A000UMessaggi, C180FunzioniGenerali,
  A177UFerieSolidaliMW;

type
  TA177FFerieSolidaliDM = class(TR004FGestStoricoDtM)
    selT254: TOracleDataSet;
    selT254PROGRESSIVO: TIntegerField;
    selT254TIPO: TStringField;
    selT254CODRAGGR: TStringField;
    selT254ANNO: TFloatField;
    selT254DECORRENZA: TDateTimeField;
    selT254ID_RICHIESTA: TFloatField;
    selT254DESCRIZIONE: TStringField;
    selT254DECORRENZA_FINE: TDateTimeField;
    selT254TERMINE_DIRITTO: TDateTimeField;
    selT254STATO: TStringField;
    selT254UMISURA: TStringField;
    selT254QUANTITA_RICHIESTA: TStringField;
    selT254QUANTITA_OFFERTA: TStringField;
    selT254QUANTITA_OTTENUTA: TStringField;
    selT254QUANTITA_ACCETTATA: TStringField;
    selT254QUANTITA_RESTITUITA: TStringField;
    selT254CAUSALE: TStringField;
    selT254DESCR_OFFERTA: TStringField;
    selT254DESCR_RAGGR: TStringField;
    selT254Vis: TOracleDataSet;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    FloatField1: TFloatField;
    DateTimeField1: TDateTimeField;
    DateTimeField2: TDateTimeField;
    FloatField2: TFloatField;
    StringField2: TStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    StringField5: TStringField;
    StringField6: TStringField;
    StringField7: TStringField;
    StringField8: TStringField;
    StringField9: TStringField;
    StringField10: TStringField;
    StringField11: TStringField;
    StringField12: TStringField;
    DateTimeField3: TDateTimeField;
    StringField13: TStringField;
    dsrT254Vis: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT254NewRecord(DataSet: TDataSet);
    procedure selT254AfterScroll(DataSet: TDataSet);
    procedure selT254QUANTITA_RICHIESTAValidate(Sender: TField);
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure AfterDelete(DataSet: TDataSet); override;
    procedure selT254BeforePost(DataSet: TDataSet);
    procedure selT254AfterPost(DataSet: TDataSet);
    procedure selT254CalcFields(DataSet: TDataSet);
    procedure selT254VisAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    A177MW:TA177FFerieSolidaliMW;
  end;

var
  A177FFerieSolidaliDM: TA177FFerieSolidaliDM;

implementation

{$R *.dfm}

uses A177UFerieSolidali;

procedure TA177FFerieSolidaliDM.AfterDelete(DataSet: TDataSet);
begin
  inherited;
  A177MW.selT254AfterDelete;
end;

procedure TA177FFerieSolidaliDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  A177MW.selT254BeforeDelete;
  if (selT254.FieldByName('TIPO').AsString = 'O') and (selT254.FieldByName('ID_RICHIESTA').AsInteger = -1) then
  begin
    //Attenzione: verranno cancellate anche tutte le offerte collegate. Continuare comunque?
    if R180MessageBox(A000MSG_A177_DLG_CANC_OFFERTA,'DOMANDA') <> mrYes then
      Abort;
    A177MW.CancellaOfferte;
  end;
end;

procedure TA177FFerieSolidaliDM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selT254,[evBeforeEdit,
                           evBeforeInsert,
//                           evBeforePostNoStorico,  non lo utilizzo perchè fa casino in quanto sulla tabella c'è il campo Decorrenza pur non essendo storicizzata
                           evBeforeDelete,
                           evAfterDelete,
//                           evAfterPost,
                           evOnTranslateMessage]);
  A177MW:=TA177FFerieSolidaliMW.Create(Self);
  A177MW.selT254:=selT254;
  selT254.Open;
end;

procedure TA177FFerieSolidaliDM.selT254AfterPost(DataSet: TDataSet);
begin
  inherited;
  A177MW.selT254AfterPost;
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;//Per committare registrazione log e altre operazioni eventuali
end;

procedure TA177FFerieSolidaliDM.selT254AfterScroll(DataSet: TDataSet);
begin
  inherited;
  A177FFerieSolidali.Abilitazioni;
end;

procedure TA177FFerieSolidaliDM.selT254BeforePost(DataSet: TDataSet);
var QOfferta:Real;
begin
  inherited;
  A177MW.selT254BeforePost;
  if selT254.FieldByName('TIPO').AsString = 'O' then
  begin
    if selT254.FieldByName('UMISURA').AsString = 'G' then
    begin
      QOfferta:=StrToFloat(selT254.FieldByName('QUANTITA_OFFERTA').AsString);
      //La quantità offerta non può essere superiore a x giorni ()!
      if QOfferta > A177MW.MaxOfferta then
      begin
        selT254.FieldByName('QUANTITA_OFFERTA').FocusControl;
        R180MessageBox(Format(A000MSG_A177_ERR_FMT_QUANTITA,['offerta',FloatToStr(A177MW.MaxOfferta) + ' giorni. Il dato viene comunque salvato.']),'INFORMA')
      end;
      //La quantità offerta non può essere superiore a x giorni residui!
      if QOfferta > A177MW.ResiduoOfferta then
      begin
        selT254.FieldByName('QUANTITA_OFFERTA').FocusControl;
        if R180MessageBox(Format(A000MSG_A177_DLG_QUANTITA_RES,[FloatToStr(A177MW.ResiduoOfferta)+ ' giorni residui']),'DOMANDA') <> mrYes then
          Abort;
      end;
    end
    else if selT254.FieldByName('UMISURA').AsString = 'O' then
    begin
      QOfferta:=R180OreMinutiExt(selT254.FieldByName('QUANTITA_OFFERTA').AsString);
      //La quantità offerta non può essere superiore a x ore ()!
      if QOfferta > A177MW.MaxOffertaHH then
      begin
        selT254.FieldByName('QUANTITA_OFFERTA').FocusControl;
        R180MessageBox(Format(A000MSG_A177_ERR_FMT_QUANTITA,['offerta',R180MinutiOre(A177MW.MaxOffertaHH) + ' ore. Il dato viene comunque salvato.']),'INFORMA')
      end;
      //La quantità offerta non può essere superiore a x ore residue!
      if QOfferta > A177MW.ResiduoOffertaHH then
      begin
        selT254.FieldByName('QUANTITA_OFFERTA').FocusControl;
        if R180MessageBox(Format(A000MSG_A177_DLG_QUANTITA_RES,[R180MinutiOre(A177MW.ResiduoOffertaHH)+' ore residue']),'DOMANDA') <> mrYes then
          Abort;
      end;
    end;
  end;
  //Registrazione log
  case DataSet.State of
    dsInsert:begin
      InterfacciaR004.StatoBeforePost:='I';
      RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    end;
    dsEdit:begin
      InterfacciaR004.StatoBeforePost:='M';
      RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    end;
  end;
end;

procedure TA177FFerieSolidaliDM.selT254CalcFields(DataSet: TDataSet);
begin
  inherited;
  A177MW.selT254CalcFields(Dataset);
end;

procedure TA177FFerieSolidaliDM.selT254NewRecord(DataSet: TDataSet);
begin
  inherited;
  A177MW.selT254NewRecord('R');
end;

procedure TA177FFerieSolidaliDM.selT254QUANTITA_RICHIESTAValidate(Sender: TField);
begin
  inherited;
  {Controllo sui dati quantità: i giorni possono avere la parte decimale .5
  e le ore possono avere i minuti < 60}
  if Sender.IsNull then
    exit;
  if selT254.FieldByName('UMisura').AsString = 'G' then
  begin
//    if ((Copy(Sender.AsString,5,1) <> '5')) and ((Trim(Copy(Sender.AsString,5,1)) <> '')) then
//      Raise Exception.Create('E'' ammesso solo .5 come parte decimale dei giorni');
  end
  else
    OreMinutiValidate(Sender.AsString);
end;

procedure TA177FFerieSolidaliDM.selT254VisAfterScroll(DataSet: TDataSet);
begin
  inherited;
  selT254.SearchRecord('ROWID',selT254Vis.RowId,[srFromBeginning]);
end;

end.
