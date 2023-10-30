unit B016USetupSelez;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, StrUtils, Math,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList, Vcl.CheckLst, Vcl.Menus;

type
  TB016FSetupSelez = class(TForm)
    Panel1: TPanel;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    lstPath: TListBox;
    chkPath: TCheckListBox;
    btnSelectAll: TBitBtn;
    btnDeselectAll: TBitBtn;
    pmnFiltroDati: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    Splitter1: TSplitter;
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure lstPathClick(Sender: TObject);
    procedure chkPathClickCheck(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure btnSelectAllClick(Sender: TObject);
  private
    { Private declarations }
    _LstTool: TStringList;
    _LstIrisWin: TStringList;
    _LstServizi: TStringList;
		_LstIrisWeb: TStringList;
    _LstIrisWebSSO: TStringList;
    _LstIrisCloud: TStringList;
    _LstIrisApp: TStringList;
    _LstWebPrint: TStringList;
    function SetLstCommaText(Value: string): string;
    function GetLst(pLst: TStringList): String;
    function GetLstTool: string;
    function GetLstIrisWin: string;
    function GetLstServizi: string;
		function GetLstIrisWeb: string;
		function GetLstIrisWebSSO: string;
		function GetLstIrisCloud: string;
		function GetLstIrisApp: string;
		function GetLstWebPrint: string;
    procedure SetLst(var pLst: TStringList; const pDesc, pValue: string);
    procedure SetLstTool(const Value: String);
    procedure SetLstIrisWin(const Value: String);
    procedure SetLstServizi(const Value: String);
    procedure SetLstIrisWeb(const Value: String);
    procedure SetLstIrisWebSSO(const Value: String);
    procedure SetLstIrisCloud(const Value: String);
    procedure SetLstIrisApp(const Value: String);
    procedure SetLstWebPrint(const Value: String);
  public
    { Public declarations }
    function SaltaGestione: Boolean;
    property LstTool: String read GetLstTool write SetLstTool;
    property LstIrisWin: String read GetLstIrisWin write SetLstIrisWin;
    property LstServizi: String read GetLstServizi write SetLstServizi;
		property LstIrisWeb: String read GetLstIrisWeb write SetLstIrisWeb;
		property LstIrisWebSSO: String read GetLstIrisWebSSO write SetLstIrisWebSSO;
		property LstIrisCloud: String read GetLstIrisCloud write SetLstIrisCloud;
		property LstIrisApp: String read GetLstIrisApp write SetLstIrisApp;
		property LstWebPrint: String read GetLstWebPrint write SetLstWebPrint;
  end;

const Tool = 'Tool di amministrazione';
      IrisWin = 'IrisWIN';
      Servizi = 'Servizi';
      IrisWeb = 'IrisWEB';
      IrisWebSSO = 'IrisWEB SSO';
      IrisCloud = 'IrisCloud';
      IrisApp = 'IrisApp';
      WebPrint = 'Web/Print Services';

implementation

{$R *.dfm}

{ TB016FSetupSelez }

procedure TB016FSetupSelez.btnCancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TB016FSetupSelez.btnOkClick(Sender: TObject);
  function VerificaSelezione(pLst: TStringList): Boolean;
    var
      i: integer;
  begin
    Result:=False;
    if Assigned(pLst) then
    begin
      for i:=0 to pLst.Count-1 do
      begin
        Result:=pLst.ValueFromIndex[i] = '1';
        if Result then
          Break;
      end;
    end
    else Result:=True;
  end;
begin
  try
    if not VerificaSelezione(_LstTool) then
      raise Exception.Create(Tool);
    if not VerificaSelezione(_LstIrisWin) then
      raise Exception.Create(IrisWin);
    if not VerificaSelezione(_LstServizi) then
      raise Exception.Create(Servizi);
    if not VerificaSelezione(_LstIrisWeb) then
      raise Exception.Create(IrisWeb);
    if not VerificaSelezione(_LstIrisWebSSO) then
      raise Exception.Create(IrisWebSSO);
    if not VerificaSelezione(_LstIrisCloud) then
      raise Exception.Create(IrisCloud);
    if not VerificaSelezione(_LstIrisApp) then
      raise Exception.Create(IrisApp);
    if not VerificaSelezione(_LstWebPrint) then
      raise Exception.Create(WebPrint);
  except
    on E:Exception do
    begin
      lstPath.Selected[lstPath.Items.IndexOf(E.Message)]:=True;
      lstPathClick(lstPath);
      raise Exception.Create('Selezionare almeno un percorso per "' + E.Message +'"');
    end;
  end;
  ModalResult:=mrOk;
end;

procedure TB016FSetupSelez.btnSelectAllClick(Sender: TObject);
var
  i,p: integer;
  Lst: TStringList;
  val:string;
begin
  val:=IfThen(Sender = btnSelectAll,'1','0');

  for i:=0 to lstPath.Count-1 do
  begin
    Lst:=TStringList(lstPath.Items.Objects[i]);
    for p:=0 to Lst.Count-1 do
      Lst.ValueFromIndex[p]:=val;
  end;
  lstPathClick(lstPath);
end;

procedure TB016FSetupSelez.chkPathClickCheck(Sender: TObject);
var
  Lst: TStringList;
begin
  Lst:=TStringList(lstPath.Items.Objects[LstPath.ItemIndex]);
  Lst.ValueFromIndex[chkPath.ItemIndex]:=IfThen(chkPath.Checked[chkPath.ItemIndex], '1','0');
end;

procedure TB016FSetupSelez.Selezionatutto1Click(Sender: TObject);
var i:Integer;
    Lst: TStringList;
begin
  Lst:=TStringList(lstPath.Items.Objects[LstPath.ItemIndex]);
  with (pmnFiltroDati.PopupComponent as TCheckListBox) do
    for i:=0 to Items.Count - 1 do
    begin
      if Header[i] then
        Continue;
      if Sender = SelezionaTutto1 then
        Checked[i]:=True
      else if Sender = DeselezionaTutto1 then
        Checked[i]:=False
      else if Sender = InvertiSelezione1 then
        Checked[i]:=not Checked[i];
      Lst.ValueFromIndex[i]:=IfThen(chkPath.Checked[i], '1','0');
    end;
end;

procedure TB016FSetupSelez.FormShow(Sender: TObject);
begin
  lstPath.Selected[0]:=True;
  lstPathClick(lstPath);
end;

procedure TB016FSetupSelez.lstPathClick(Sender: TObject);
var
  Lst: TStringList;
  i: integer;
begin
  if LstPath.ItemIndex >= 0 then
  begin
    chkPath.Items.Clear;
    Lst:=TStringList(lstPath.Items.Objects[LstPath.ItemIndex]);
    for i:=0 to Lst.Count-1 do
    begin
      chkPath.Items.Add(Lst.Names[i]);
      chkPath.Checked[i]:=Lst.ValueFromIndex[i] = '1';
    end;
  end;
end;

function TB016FSetupSelez.SaltaGestione: Boolean;
begin //Se è passato un solo percorso per ogni applicativo la gestione è inutile e deve essere saltata
  Result:=lstPath.Items.Count = 0;
end;

function TB016FSetupSelez.GetLst(pLst: TStringList): String;
var
  i: integer;
begin
  Result:='';
  if Assigned(pLst) then
  begin
    for i:=0 to pLst.Count-1 do
    begin
      if pLst.ValueFromIndex[i] = '1' then
        Result:=Result + pLst.Names[i] + ';';
    end;
    if (Result.Length > 0) and (RightStr(Result, 1) = ';') then
      Result:=Result.Substring(0, Result.Length - 1);
  end;
end;

procedure TB016FSetupSelez.SetLst(var pLst: TStringList; const pDesc, pValue: string);
begin
  if pLst = nil then
  begin
    pLst:=TStringList.Create;
    pLst.StrictDelimiter:=True;
  end;
  pLst.CommaText:=SetLstCommaText(pValue);
  if Assigned(pLst) and (pLst.Count > 1) then
    lstPath.AddItem(pDesc, pLst);
end;

function TB016FSetupSelez.SetLstCommaText(Value: string): string;
begin
  Result:='';
  if Trim(Value) = '' then
    exit;
  if Value[Value.Length]=';' then
    Value:=Value.Substring(0,Value.Length - 1);
  Result:=Value.Replace(';','=1,',[rfReplaceAll]) + '=1';
end;

function TB016FSetupSelez.GetLstTool: String;
begin
  Result:=GetLst(_LstTool);
end;

procedure TB016FSetupSelez.SetLstTool(const Value: String);
begin
  SetLst(_LstTool,Tool,Value);
end;

function TB016FSetupSelez.GetLstIrisWin: String;
begin
  Result:=GetLst(_LstIrisWin);
end;

procedure TB016FSetupSelez.SetLstIrisWin(const Value: String);
begin
  SetLst(_LstIrisWin,IrisWin,Value);
end;

function TB016FSetupSelez.GetLstServizi: String;
begin
  Result:=GetLst(_LstServizi);
end;

procedure TB016FSetupSelez.SetLstServizi(const Value: String);
begin
  SetLst(_LstServizi,Servizi,Value);
end;

function TB016FSetupSelez.GetLstIrisWeb: String;
begin
  Result:=GetLst(_LstIrisWeb);
end;

procedure TB016FSetupSelez.SetLstIrisWeb(const Value: String);
begin
  SetLst(_LstIrisWeb,IrisWeb,Value);
end;

function TB016FSetupSelez.GetLstIrisWebSSO: String;
begin
  Result:=GetLst(_LstIrisWebSSO);
end;

procedure TB016FSetupSelez.SetLstIrisWebSSO(const Value: String);
begin
  SetLst(_LstIrisWebSSO,IrisWebSSO,Value);
end;

function TB016FSetupSelez.GetLstIrisCloud: String;
begin
  Result:=GetLst(_LstIrisCloud);
end;

procedure TB016FSetupSelez.SetLstIrisCloud(const Value: String);
begin
  SetLst(_LstIrisCloud,IrisCloud,Value);
end;

function TB016FSetupSelez.GetLstIrisApp: String;
begin
  Result:=GetLst(_LstIrisApp);
end;

procedure TB016FSetupSelez.SetLstIrisApp(const Value: String);
begin
  SetLst(_LstIrisApp,IrisApp,Value);
end;

function TB016FSetupSelez.GetLstWebPrint: String;
begin
  Result:=GetLst(_LstWebPrint);
end;

procedure TB016FSetupSelez.SetLstWebPrint(const Value: String);
begin
  SetLst(_LstWebPrint,WebPrint,Value);
end;

end.
