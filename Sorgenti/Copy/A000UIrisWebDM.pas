unit A000UIrisWebDM;

interface

uses
  WR000UBaseDM,
  DBClient, Windows, Messages, SysUtils, StrUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, OracleData, Oracle, Variants, Math,
  IWInit, IdMessage, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase,
  IdSMTP, IWAppForm, IWApplication,
  A000UCostanti, A000USessione, A001UPasswordDtM1, C180FunzioniGenerali,
  L021Call, USelI010, meIWLink, Xml.xmldom, Xml.XMLIntf, Vcl.ImgList, IWImageList, meIWImageList, Xml.Win.msxmldom, Xml.XMLDoc,
  System.ImageList, meIWImageListCache;

type
   TCampo = record
    FieldName: String;
    DisplayLabel: String;
    AsString: String;
    Clickable: Boolean;
    HasDesc: Boolean;
    DescAsString: String;
  end;

  TA000FIrisWebDM = class(TWR000FBaseDM)
    cdsT950Int: TClientDataSet;
    IdSMTP: TIdSMTP;
    IdMessage: TIdMessage;
    selI081: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
  private
    FVisualizzaCessati: Boolean;
    function CampoDaEscludere(const Campo: String; SchedaCompleta: Boolean): Boolean;
    procedure SetVisualizzaCessati(const Value: Boolean);
  public
    FiltroRicerca,OrdinamentoRicerca,NomeForm,AccessoDirettoValutatore,LogoutUrl:String;
    RefreshT003:Boolean;
    TipoValutazione: String;
    DataSetCorsi:TOracleDataSet;
    lstAnomalieT380:TStringList;
//DEFINITO sul padre    selI010:TselI010;
    BookmarkIP:TBookMark;
    CampoArr: array of TCampo;
    function AccessoValutatore:String;
    procedure GetDatiAnagrafici(var Row:Integer;SchedaCompleta:Boolean);
    property  VisualizzaCessati:Boolean read FVisualizzaCessati write SetVisualizzaCessati;
  end;

implementation

uses A000UInterfaccia, WR100UBase, WR101ULogin;

{$R *.DFM}

procedure TA000FIrisWebDM.DataModuleCreate(Sender: TObject);
begin
  DebugToFile(GGetWebApplicationThreadVar,'TA000FIrisWebDM.DataModuleCreate - inherited');
  inherited;
  DebugToFile(GGetWebApplicationThreadVar,'TA000FIrisWebDM.DataModuleCreate - variabili');
  RefreshT003:=False;
  AccessoDirettoValutatore:='N';
  FVisualizzaCessati:=True;
  DebugToFile(GGetWebApplicationThreadVar,'TA000FIrisWebDM.DataModuleCreate - end');
end;

function TA000FIrisWebDM.AccessoValutatore:String;
begin
  //Sempre N per IrisCloud
  Result:='N';
end;

function TA000FIrisWebDM.CampoDaEscludere(const Campo: String; SchedaCompleta: Boolean): Boolean;
var
  v: Variant;
  NomeCampo,Accesso: string;
  Posizione: Integer;
begin
  // campo progressivo -> escluso
  Result:=(Campo = 'PROGRESSIVO') or
          (Campo = 'T430PROGRESSIVO');
  if Result then
    Exit;

  // campo descrittivo (di decodifica) -> escluso
  Result:=(Copy(Campo,1,6) = 'T430D_') and
          (Campo <> 'T430D_PROVINCIA'); // dicitura fissa per "provincia di residenza"
  if Result then
    Exit;

  // estrae dati da tabella I010
  v:=cdsI010.Lookup('NOME_CAMPO',Campo,'NOME_CAMPO;ACCESSO;POSIZIONE');

  // campo non trovato -> escluso
  Result:=VarIsNull(v);
  if Result then
    Exit;

  // salva dati in variabili di appoggio
  NomeCampo:=VarToStr(v[0]);
  Accesso:=VarToStr(v[1]);
  Posizione:=StrToIntDef(VarToStr(v[2]),-1);

  // accesso 'N' oppure non indicato -> escluso
  Result:=(Accesso = 'N') or (Accesso = '');
  if Result then
    Exit;

  // scheda non completa e posizione < 0 -> escluso
  Result:=(not SchedaCompleta) and
          (Posizione < 0);
end;

procedure TA000FIrisWebDM.GetDatiAnagrafici(var Row:Integer; SchedaCompleta:Boolean);
var i:Integer;
    F:TField;
begin
  SetLength(CampoArr,0);
  Row:=0;
  for i:=0 to cdsAnagrafe.FieldCount - 1 do
  begin
    if CampoDaEscludere(cdsAnagrafe.Fields[i].FieldName, SchedaCompleta) then
      Continue;

    // inserisce i dati nell'array
    SetLength(CampoArr,Row + 1);
    CampoArr[Row].FieldName:=cdsAnagrafe.Fields[i].FieldName;
    CampoArr[Row].DisplayLabel:=cdsAnagrafe.Fields[i].DisplayLabel;
    CampoArr[Row].AsString:=cdsAnagrafe.Fields[i].AsString;
    CampoArr[Row].Clickable:=False;
    CampoArr[Row].HasDesc:=False;
    if Copy(CampoArr[Row].FieldName,1,4) = 'T430' then
    begin
      CampoArr[Row].Clickable:=True;
      F:=cdsAnagrafe.FindField(StringReplace(CampoArr[Row].FieldName,'T430','T430D_',[]));
      if F <> nil then
      begin
        CampoArr[Row].HasDesc:=True;
        CampoArr[Row].DescAsString:=F.AsString;
      end;
    end;

    inc(Row);
  end;
end;

procedure TA000FIrisWebDM.SetVisualizzaCessati(const Value: Boolean);
var S:String;
begin
  if FVisualizzaCessati <> Value then
  begin
    FVisualizzaCessati:=Value;
    if not FVisualizzaCessati then
    begin
      S:=Format(QDipInServizio,[IntToStr(Parametri.ValiditaCessati)]);
      if Trim(Parametri.Inibizioni.Text) <> '' then
        S:='AND ' + S;
      Parametri.Inibizioni.Add(S);
    end
    else
      Parametri.Inibizioni.Delete(Parametri.Inibizioni.Count - 1);
  end;
end;

end.
