unit meTIWMultiColumnComboBox;

interface

uses
  SysUtils, Classes, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompEdit, IWMultiColumnComboBox,
  IWHTMLTag, IWXMLTag, IWMarkupLanguageTag, IWColor, Graphics,
  Forms, Windows, IWTypes, IWCompButton,
  IWCompLabel, IWCompCheckbox, {$IFDEF TMSIW121}IWCompExtCtrls{$ELSE}IWExtCtrls{$ENDIF}, IWCompListbox,
  IWCompRectangle, IWTMSBase, IWTMSImg, IWFont, IWForm,Menus;

type
  TmeTIWMultiColumnComboBox = class(TTIWMultiColumnComboBox)
  private
    FContextMenu: TPopupMenu;
    function  GetContextMenu: TPopupMenu;
    procedure SetContextMenu(const Val: TPopupMenu);
  protected

  public
    constructor Create(AOwner: TComponent); override;
    function RenderHTML(AContext: TIWBaseComponentContext): TIWHTMLTag; override;
    function RenderAsync(AContext: TIWBaseHTMLComponentContext): TIWXMLTag; override;
  published
    property medpContextMenu: TPopupMenu read GetContextMenu write SetContextMenu;
  end;


implementation

uses
  ImgList, ShellAPI, CommCtrl,
  IWApplication, IWServerControllerBase,IWResourceStrings,
  IWAppForm, TypInfo
  {$IFDEF TMSIW121}
  , IWStrings, IW.Common.System
  {$ELSE}
  , SWStrings, SWSystem
  {$ENDIF}
  ;


constructor TmeTIWMultiColumnComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  RenderSize:=False;
  Font.Enabled:=False;
  with StyleRenderOptions do
  begin
    RenderAbsolute:=False;
    RenderFont:=False;
    RenderPosition:=False;
    RenderSize:=False;
    RenderStatus:=True;
    RenderVisibility:=True;
    RenderZIndex:=False;
  end;
  DropDownDisplay:=ddOnFocus;
  LookupMethod:=lmSelect;
  Css:='medpMultiColCmb';
  NonEditableAsLabel:=False;
end;

function TmeTIWMultiColumnComboBox.GetContextMenu: TPopupMenu;
begin
  Result:=FContextMenu;
end;

procedure TmeTIWMultiColumnComboBox.SetContextMenu(const Val: TPopupMenu);
begin
  FContextMenu:=Val;
end;

//{$IFDEF TMSIW6}
function TmeTIWMultiColumnComboBox.RenderHTML(AContext: TIWBaseComponentContext): TIWHTMLTag;
var
  HTMLText:string;
  Index1:Integer;
  Index2:Integer;
  Temp, Part1, Part2, Part3:string;

  function addToShowDiv():string;
  begin
(*
    Result:='function ' + HTMLName + 'showdiv(obj) { '+ #13#10 +
             ' var ldiv; var tdiv; var elemTx; var elemCh; var chWidth; var txWidth; var txHeight; var chHeight;' + #13#10 +
             ' elemTx=document.getElementById("'+HTMLName+'"); ' + #13#10+
             ' txWidth=elemTx.offsetWidth; txHeight=elemTx.offsetHeight; tdiv=txHeight' + #13#10 +
             ' ldiv=elemTx.offsetLeft; ' + #13#10 +
             ' do { ldiv += elemTx.offsetLeft; tdiv += elemTx.offsetTop; } ' +#13#10 +
             ' while ((elemTx = elemTx.offsetParent)); ' + #13#10 +
             ' elemCh=document.getElementById("'+HTMLName+'checklist"); ' + #13#10 +
             ' if (elemCh.style.display == "") {' +
             ' chWidth=elemCh.offsetWidth;' +
             ' } ' +
             ' else {' +
             ' elemCh.style.display = ""; ' +
             ' chWidth=elemCh.offsetWidth; ' +
             ' chHeight=elemCh.offsetHeight; ' +
             ' elemCh.style.display = "none"; ' +
             '} '+ #13#10 +
             ' if ( ( ldiv + chWidth) > document.body.clientWidth && ldiv > chWidth) { ldiv=ldiv-(chWidth-txWidth); } '+ #13#10 +
             ' if ( ( tdiv + chHeight) > document.body.clientHeight && tdiv > chHeight) { tdiv=tdiv-(chHeight+txHeight); } '+ #13#10 +
             ' elemCh.style.left=ldiv+ "px";  elemCh.style.top=tdiv + "px"; '+ #13#10 +
             ' document.body.appendChild(elemCh); ';
*)

//Aggiunta gestione scrollLeft e scrollTop per region con scrollbar. IN TESTING
    Result:='function ' + HTMLName + 'showdiv(obj) { '+ #13#10 +
             ' var ldiv; var tdiv; var elemTx; var elemCh; var chWidth; var txWidth; var txHeight; var chHeight; ' + #13#10 +
             ' elemTx=document.getElementById("'+HTMLName+'"); ' + #13#10+
             ' txWidth=elemTx.offsetWidth; txHeight=elemTx.offsetHeight; tdiv=txHeight; ' + #13#10 +
             ' ldiv=elemTx.offsetLeft; ' + #13#10 +
             ' do { ldiv += (elemTx.offsetLeft-elemTx.scrollLeft ); ' + #13#10 +
             '  tdiv += (elemTx.offsetTop - elemTx.scrollTop); ' + #13#10 +
             ' } ' + #13#10 +
             ' while (elemTx = elemTx.offsetParent); ' + #13#10 +
             ' elemCh=document.getElementById("'+HTMLName+'checklist"); ' + #13#10 +
             ' if (elemCh.style.display == "") {' +
             ' chWidth=elemCh.offsetWidth;' +
             ' } ' +
             ' else {' +
             ' elemCh.style.display = ""; ' +
             ' chWidth=elemCh.offsetWidth; ' +
             ' chHeight=elemCh.offsetHeight; ' +
             ' elemCh.style.display = "none"; ' +
             '} '+ #13#10 +
             ' if ( ( ldiv + chWidth) > document.body.clientWidth && ldiv > chWidth) { ldiv=ldiv-(chWidth-txWidth); } '+ #13#10 +
             ' if ( ( tdiv + chHeight) > document.body.clientHeight && tdiv > chHeight) { tdiv=tdiv-(chHeight+txHeight); } '+ #13#10 +
             ' elemCh.style.left=ldiv+ "px";  elemCh.style.top=tdiv + "px"; '+ #13#10 +
             ' document.body.appendChild(elemCh); ';


  end;

begin

  Result:=inherited;

  HTMLText:=Result.Contents[0].Render;
  (*Caratto 1/8/2012
    il div di drop down non si posiziona correttamente nei frame.
    aggiunto come figlio di document e fatto in modo che compaia verso sx
    o in alto nel caso l'elenco elementi sforasse le dimensioni del document
  *)
   HTMLText:=Stringreplace(HTMLText,'function ' + HTMLName + 'showdiv(obj) {',addToShowDiv,[rfReplaceAll]);
  (*Caratto 2/8/2012
  Il Pulsante del dropdown non ha un id html. lo devo impostare perchè serve nel
  renderAsync poichè non cambia lo stato di enabled dei componenti negli eventi asincroni
  *)
  HTMLText:=Stringreplace(HTMLText,'<BUTTON', '<BUTTON id="'+ HTMLName + 'button"',[rfReplaceAll]);
  Index1:=Pos('id="' + HTMLName +'popup"',HTMLText);
  Temp:=Copy(HTMLText,Index1,Length(HTMLText) - Index1);
  Index2:=Pos('<table width="100%" style',Temp) + Index1;

  Part1:=Copy(HTMLText,0,Index1 - 1);
  Part2:=Copy(HTMLText,Index1,Index2 - Index1);

  //Part2:=Stringreplace(Part2,'style="overflow:auto;','style="overflow:auto;display:block;',[rfReplaceAll]);
  Part2:=Stringreplace(Part2,'style="overflow:auto;','style="overflow-x:scroll;overflow-y:auto;display:block;',[rfReplaceAll]);
  if PopUpHeight > 0 then
    Part2:=Stringreplace(Part2,'height:'+inttostr(PopUpHeight)+'px;','height:'+inttostr(PopUpHeight)+'em;',[rfReplaceAll]);
  if PopUpWidth > 0 then
    Part2:=Stringreplace(Part2,'width:'+inttostr(PopUpWidth)+'px;','width:'+inttostr(PopUpWidth)+'em;',[rfReplaceAll]);

  Part3:=Copy(HTMLText,Index2, Length(HTMLText));

  TIWTextElement(Result.Contents[0]).Text:=Part1 + Part2 + Part3;

end;


function TmeTIWMultiColumnComboBox.RenderAsync(AContext: TIWBaseHTMLComponentContext): TIWXMLTag;
var
  Disab : String;
begin
  (*Caratto 4/10/2012
    Se la multicolumn è in una region non visibile viene richiamato comunque il render Async
    Esiste un bug per cui testa if (htmlname obj) ma l'oggetto non è definito e va in errore javascript.
    Ridefinisco la variabile in caso sia undefined
  *)

  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(' var '+ HTMLName +'obj =  typeof '+HTMLName +'obj === "undefined" ? null : ' + HTMLname +'obj; ' +#13#10);

  Result:=inherited;

  (*Caratto 2/8/2012
    non cambia lo stato di enabled dei componenti negli eventi asincroni.
    aggiunto abilitazione/disabilitazione della text e del pulsante
  *)
  if (Self.Enabled) and not (Self.ReadOnly) then
    Disab:='false'
  else
    Disab:='true';
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA (' var el=document.getElementById("'+HTMLName+'"); if (el) {el.disabled='+ Disab +';} var elb=document.getElementById("'+HTMLName+'button"); if (elb) {elb.disabled='+ Disab +';} ');
end;

end.

