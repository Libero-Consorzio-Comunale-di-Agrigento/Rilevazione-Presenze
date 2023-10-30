unit WA021UAssestamentoAnnuoFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  WR200UBaseFM, C190FunzioniGeneraliWeb,
  IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  IWCompButton, meIWButton, IWCompListbox, meIWListbox, IWCompLabel,
  meIWLabel, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompCheckbox, meIWCheckBox, IWCompExtCtrls,
  IWCompJQueryWidget, meIWImageFile;

type
  TWA021ModalResultEvents = procedure(Sender: TObject; Result: Boolean;Assestamento:Boolean; Ordine:String) of object;

  TWA021FAssestamentoAnnuoFM = class(TWR200FBaseFM)
    lblOrdineAbbattimento: TmeIWLabel;
    lstOrdine: TmeIWListbox;
    btnOk: TmeIWButton;
    btnAnnulla: TmeIWButton;
    imgSpostaSu: TmeIWImageFile;
    imgSpostaGiu: TmeIWImageFile;
    chkAssestamentoAnnuo: TmeIWCheckBox;
    procedure btnClick(Sender: TObject);
    procedure imgSpostaSuAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure imgSpostaGiuAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure chkAssestamentoAnnuoAsyncClick(Sender: TObject;
      EventParams: TStringList);
  private
    { Private declarations }
  public
    ResultEvent:TWA021ModalResultEvents;
    OrderValue:String;
    procedure Visualizza;
  end;

implementation

uses WR100UBase;

{$R *.dfm}

procedure TWA021FAssestamentoAnnuoFM.Visualizza;
  var L:TStringList;
    i:Integer;
begin
  lstOrdine.Items.Clear;

  L:=TStringList.Create;
  try
    L.CommaText:=OrderValue;
    for i:=0 to L.Count - 1 do
    begin
      if L[i] = 'CP' then
        lstOrdine.Items.Values['Compensabile anno prec.']:='CP'
      else if L[i] = 'LP' then
        lstOrdine.Items.Values['Liquidabile anno prec.']:='LP'
      else if L[i] = 'CA' then
        lstOrdine.Items.Values['Compensabile anno att.']:='CA'
      else if L[i] = 'LA' then
        lstOrdine.Items.Values['Liquidabile anno att.']:='LA';
    end;
  finally
    L.Free;
  end;

  lstOrdine.ItemIndex:=0;
  lstOrdine.Enabled:=chkAssestamentoAnnuo.Checked;
  imgSpostaSu.Enabled:=chkAssestamentoAnnuo.Checked;
  imgSpostaGiu.Enabled:=chkAssestamentoAnnuo.Checked;

  TWR100FBase(Self.Parent).VisualizzaJQMessaggio(jQuery,230,-1,EM2PIXEL * 15,'Assestamento annuo','#wa021_container',False,True);
end;

procedure TWA021FAssestamentoAnnuoFM.btnClick(Sender: TObject);
var
  Result:Boolean;
  ResultValue:String;
  i: Integer;
begin
  ResultValue:='';
  if Sender = btnOk then
  begin
    Result:=True;

    if chkAssestamentoAnnuo.Checked then
    begin
      for i := 0 to lstOrdine.Items.Count - 1 do
      begin
        ResultValue:=ResultValue + lstOrdine.Items.ValueFromIndex[i] + ' ';
      end;
      ResultValue:=Trim(ResultValue);
      ResultValue:=StringReplace(ResultValue,' ',',',[rfReplaceAll]);
    end;
  end
  else     //btnAnnulla
    Result:=False;

  if Assigned(ResultEvent) then
  try
    ResultEvent(Self,Result,chkAssestamentoAnnuo.Checked,ResultValue);
  except
    on E: EAbort do;
    on E: Exception do
      raise;
  end;

  ReleaseOggetti;
  Free;
end;

procedure TWA021FAssestamentoAnnuoFM.chkAssestamentoAnnuoAsyncClick(
  Sender: TObject; EventParams: TStringList);
begin
  lstOrdine.Enabled:=chkAssestamentoAnnuo.Checked;
  imgSpostaSu.Enabled:=chkAssestamentoAnnuo.Checked;
  imgSpostaGiu.Enabled:=chkAssestamentoAnnuo.Checked;
end;

procedure TWA021FAssestamentoAnnuoFM.imgSpostaGiuAsyncClick(Sender: TObject;
  EventParams: TStringList);
var
  Temp,Val:String;
begin
  if lstOrdine.ItemIndex <> lstOrdine.Items.Count -1 then
  begin
    Temp:=lstOrdine.Items[lstOrdine.ItemIndex+1];
    Val:=lstOrdine.Items.ValueFromIndex[lstOrdine.ItemIndex+1];
    lstOrdine.Items[lstOrdine.ItemIndex+1]:=lstOrdine.Items[lstOrdine.ItemIndex];
    lstOrdine.Items.ValueFromIndex[lstOrdine.ItemIndex+1]:=lstOrdine.Items.ValueFromIndex[lstOrdine.ItemIndex];
    lstOrdine.Items[lstOrdine.ItemIndex]:=Temp;
    lstOrdine.Items.ValueFromIndex[lstOrdine.ItemIndex]:=Val;
    lstOrdine.Selected[lstOrdine.ItemIndex+1]:=True;
    lstOrdine.Selected[lstOrdine.ItemIndex]:=False;
    lstOrdine.ItemIndex:=lstOrdine.ItemIndex+1;
  end;
end;

procedure TWA021FAssestamentoAnnuoFM.imgSpostaSuAsyncClick(Sender: TObject;
  EventParams: TStringList);
var
  Temp,Val:String;
begin
  if lstOrdine.ItemIndex <> 0 then
  begin
    Temp:=lstOrdine.Items[lstOrdine.ItemIndex-1];
    Val:=lstOrdine.Items.ValueFromIndex[lstOrdine.ItemIndex-1];
    lstOrdine.Items[lstOrdine.ItemIndex-1]:=lstOrdine.Items[lstOrdine.ItemIndex];
    lstOrdine.Items.ValueFromIndex[lstOrdine.ItemIndex-1]:=lstOrdine.Items.ValueFromIndex[lstOrdine.ItemIndex];
    lstOrdine.Items[lstOrdine.ItemIndex]:=Temp;
    lstOrdine.Items.ValueFromIndex[lstOrdine.ItemIndex]:=Val;
    lstOrdine.Selected[lstOrdine.ItemIndex-1]:=True;
    lstOrdine.Selected[lstOrdine.ItemIndex]:=False;
    lstOrdine.ItemIndex:=lstOrdine.ItemIndex-1;
  end;
end;

end.
