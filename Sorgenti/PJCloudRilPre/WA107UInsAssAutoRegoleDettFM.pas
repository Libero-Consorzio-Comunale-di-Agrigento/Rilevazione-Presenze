unit WA107UInsAssAutoRegoleDettFM;

interface

uses WR205UDettTabellaFM, IWCompExtCtrls, meIWImageFile, IWCompEdit,
  IWDBStdCtrls, meIWDBEdit, IWCompCheckbox, meIWDBCheckBox, IWDBExtCtrls,
  meIWDBRadioGroup, IWCompListbox, meIWListbox, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompLabel, meIWLabel, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, Classes, Controls, Forms, SysUtils,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion;

type
  TWA107FInsAssAutoRegoleDettFM = class(TWR205FDettTabellaFM)
    lblCausaliUtilizzabili: TmeIWLabel;
    lblCausaliDisponibili: TmeIWLabel;
    lstCausali: TmeIWListbox;
    lblDebito: TmeIWLabel;
    drgpDebito: TmeIWDBRadioGroup;
    dchkEliminaGiustificativi: TmeIWDBCheckBox;
    dchkGiorniVuoti: TmeIWDBCheckBox;
    lblOreMax: TmeIWLabel;
    dedtOreMax: TmeIWDBEdit;
    imgSpostaSx: TmeIWImageFile;
    imgSpostaDx: TmeIWImageFile;
    lstCausaliDisponibili: TmeIWListbox;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure imgSpostaSxClick(Sender: TObject);
    procedure imgSpostaDxClick(Sender: TObject);
  private
  public
    procedure AbilitaComponenti(Abilita:Boolean);
  end;

implementation

uses WA107UInsAssAutoRegole, WA107UInsAssAutoRegoleDM;

{$R *.dfm}

procedure TWA107FInsAssAutoRegoleDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  with ((Self.Owner as TWA107FInsAssAutoRegole).WR302DM as TWA107FInsAssAutoRegoleDM).A107MW do
  begin
    lstCausali.Items.CommaText:=selT045.FieldByName('CAUSALI').AsString;
    lstCausali.ItemIndex:=0;
    with selT265 do
      while not Eof do
      begin
        lstCausaliDisponibili.Items.Add(Format('%-5s %s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
        Next;
      end;
    lstCausaliDisponibili.ItemIndex:=0;
  end;
end;

procedure TWA107FInsAssAutoRegoleDettFM.imgSpostaSxClick(Sender: TObject);
var Causale:String;
begin
  Causale:=Trim(Copy(lstCausaliDisponibili.Items[lstCausaliDisponibili.ItemIndex],1,5));
  if lstCausali.Items.IndexOf(Causale) = -1 then
    lstCausali.Items.Add(Causale);
  lstCausali.ItemIndex:=lstCausali.Items.IndexOf(Causale);
end;

procedure TWA107FInsAssAutoRegoleDettFM.AbilitaComponenti(Abilita: Boolean);
begin
  imgSpostaSx.Enabled:=Abilita;
  imgSpostaDx.Enabled:=Abilita;
end;

procedure TWA107FInsAssAutoRegoleDettFM.imgSpostaDxClick(Sender: TObject);
begin
  if lstCausali.ItemIndex >= 0 then
    lstCausali.Items.Delete(lstCausali.ItemIndex);
  if lstCausali.ItemIndex > lstCausali.Items.Count - 1 then
    lstCausali.ItemIndex:=lstCausali.Items.Count - 1;
end;

end.
