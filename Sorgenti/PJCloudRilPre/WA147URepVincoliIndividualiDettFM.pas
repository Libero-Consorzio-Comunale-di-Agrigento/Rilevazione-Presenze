unit WA147URepVincoliIndividualiDettFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWCompLabel, meIWLabel, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWCompEdit, IWDBStdCtrls,
  meIWDBEdit, IWCompListbox, meIWComboBox, IWCompExtCtrls, IWDBExtCtrls,
  meIWDBRadioGroup, IWCompButton, meIWButton,
  WC013UCheckListFM, C180FunzioniGenerali, C190FunzioniGeneraliWeb;

type
  TWA147FRepVincoliIndividualiDettFM = class(TWR205FDettTabellaFM)
    dedtDecorrenza: TmeIWDBEdit;
    lblDecorrenza: TmeIWLabel;
    dedtScadenza: TmeIWDBEdit;
    lblScadenza: TmeIWLabel;
    cmbGiorno: TmeIWComboBox;
    lblGiorno: TmeIWLabel;
    drgpDisponibile: TmeIWDBRadioGroup;
    lblDisponibile: TmeIWLabel;
    drgpBloccaPianif: TmeIWDBRadioGroup;
    lblBloccaPianif: TmeIWLabel;
    lblTurni: TmeIWLabel;
    dedtTurni: TmeIWDBEdit;
    btnTurni: TmeIWButton;
    procedure btnTurniClick(Sender: TObject);
    procedure IWFrameRegionCreate(Sender: TObject);
  private
    WC013:TWC013FCheckListFM;
    procedure ResultTurni(Sender: TObject; Result: Boolean);
  public
    { Public declarations }
  end;

implementation

uses WA147URepVincoliIndividuali, WA147URepVincoliIndividualiDM;

{$R *.dfm}

procedure TWA147FRepVincoliIndividualiDettFM.btnTurniClick(Sender: TObject);
begin
  inherited;

  WC013:=TWC013FCheckListFM.Create(Self.Parent);

  with WC013 do
  begin
    ckList.Items.Clear;
    with ((Self.Owner as TWA147FRepVincoliIndividuali).WR302DM as TWA147FRepVincoliIndividualiDM).A147MW, selT350 do
    begin
      Close;
      SetVariable('TIPO',CodTipologia);
      Open;
      First;
      while not Eof do
      begin
        ckList.Items.Add(Format('%-5s %s',[FieldByName('Codice').AsString,FieldByName('Descrizione').AsString]));
        ckList.Values.Add(Trim(FieldByName('CODICE').AsString));
        Next;
      end;
    end;
    ResultEvent:=ResultTurni;
    C190PutCheckList(dedtTurni.Text,5,ckList);
    WC013.Visualizza;
  end;
end;

procedure TWA147FRepVincoliIndividualiDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  R180SetComboItemsValues(cmbGiorno.Items,(WR302DM as TWA147FRepVincoliIndividualiDM).A147MW.D_Giorno,'V');
end;

procedure TWA147FRepVincoliIndividualiDettFM.ResultTurni(Sender: TObject; Result:Boolean);
begin
  if Result then
    WR302DM.selTabella.FieldByName(dedtTurni.DataField).AsString:=C190GetCheckList(5,WC013.ckList);
end;

end.
