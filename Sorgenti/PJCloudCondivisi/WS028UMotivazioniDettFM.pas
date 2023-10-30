unit WS028UMotivazioniDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompEdit, IWDBStdCtrls, meIWDBEdit,
  IWCompLabel, meIWLabel, IWCompCheckbox, meIWDBCheckBox, IWCompButton,
  meIWButton, WC013UCheckListFM, C190FunzioniGeneraliWeb, meTIWAdvCheckGroup;

type
  TWS028FMotivazioniDettFM = class(TWR205FDettTabellaFM)
    dEdtCodice: TmeIWDBEdit;
    dEdtDescrizione: TmeIWDBEdit;
    dEdtDescAgg: TmeIWDBEdit;
    dedtNumeriPrec: TmeIWDBEdit;
    dedtNumeriSucc: TmeIWDBEdit;
    dChkBoxStampaFamiliari: TmeIWDBCheckBox;
    lblCodice: TmeIWLabel;
    lblDescrizione: TmeIWLabel;
    lblDescAgg: TmeIWLabel;
    lblNumeriPrec: TmeIWLabel;
    lblNumeriSucc: TmeIWLabel;
    btnNumeriPrec: TmeIWButton;
    btnNumeriSucc: TmeIWButton;
    procedure btnNumeriPrecClick(Sender: TObject);
    procedure btnNumeriSuccClick(Sender: TObject);
    procedure IWFrameRegionRender(Sender: TObject);
  private
    { Private declarations }
    WC013: TWC013FCheckListFM;
    procedure ReleaseOggetti; override;
    procedure ResultFlussiPrec(Sender: TObject; Result: Boolean);
    procedure ResultFlussiSucc(Sender: TObject; Result: Boolean);
    procedure CaricaChkListFlussi(var ChkList:TmeTIWAdvCheckGroup);
  protected
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
  public
    { Public declarations }
  end;

implementation

uses
  WS028UMotivazioniDM;

{$R *.dfm}

procedure TWS028FMotivazioniDettFM.Notification(AComponent: TComponent;  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if (AComponent is TWC013FCheckListFM) and (AComponent = WC013) then
      WC013:=nil
    (*else if (AComponent is TWC015FSelEditGridFM) and (AComponent = WC015FSelEditGridFM) then
      WC015FSelEditGridFM:=nil
    *)
    ;
  end;
end;

procedure TWS028FMotivazioniDettFM.ReleaseOggetti;
begin
  if WC013 <> nil then
    FreeAndNil(WC013);
end;

procedure TWS028FMotivazioniDettFM.CaricaChkListFlussi(var ChkList:TmeTIWAdvCheckGroup);
begin
  (WR302DM as TWS028FMotivazioniDM).S028MW.selP660.Open;
  try
    (WR302DM as TWS028FMotivazioniDM).S028MW.selP660.First;
    while not (WR302DM as TWS028FMotivazioniDM).S028MW.selP660.Eof do
    begin
      ChkList.Items.Add(Format('%-4s %s',[(WR302DM as TWS028FMotivazioniDM).S028MW.selP660.FieldByName('NUMERO').AsString,
                                         (WR302DM as TWS028FMotivazioniDM).S028MW.selP660.FieldByName('DESCRIZIONE').AsString]));
      ChkList.Values.Add((WR302DM as TWS028FMotivazioniDM).S028MW.selP660.FieldByName('NUMERO').AsString);
      (WR302DM as TWS028FMotivazioniDM).S028MW.selP660.Next;
    end;
  finally
    (WR302DM as TWS028FMotivazioniDM).S028MW.selP660.Close;
  end;
end;

procedure TWS028FMotivazioniDettFM.IWFrameRegionRender(Sender: TObject);
begin
  inherited;
  (WR302DM as TWS028FMotivazioniDM).S028MW.selP660.Open;
  C190VisualizzaElemento(JQuery,'provvedimenti',(WR302DM as TWS028FMotivazioniDM).S028MW.selP660.RecordCount > 0);
  (WR302DM as TWS028FMotivazioniDM).S028MW.selP660.Close;
end;

procedure TWS028FMotivazioniDettFM.ResultFlussiSucc(Sender: TObject; Result: Boolean);
begin
  if Result then
  begin
    WR302DM.selTabella.FieldByName(dedtNumeriSucc.DataField).AsString:=C190GetCheckList(4,WC013.ckList);
  end;
end;

procedure TWS028FMotivazioniDettFM.ResultFlussiPrec(Sender: TObject; Result: Boolean);
begin
  if Result then
  begin
    WR302DM.selTabella.FieldByName(dedtNumeriPrec.DataField).AsString:=C190GetCheckList(4,WC013.ckList);
  end;
end;

procedure TWS028FMotivazioniDettFM.btnNumeriPrecClick(Sender: TObject);
begin
  inherited;
  WC013:=TWC013FCheckListFM.Create(Self.Parent);
  CaricaChkListFlussi(WC013.ckList);
  C190PutCheckList(dedtNumeriPrec.Text,4,WC013.ckList);
  WC013.ResultEvent:=ResultFlussiPrec;
  WC013.Visualizza;
end;

procedure TWS028FMotivazioniDettFM.btnNumeriSuccClick(Sender: TObject);
begin
  inherited;
  WC013:=TWC013FCheckListFM.Create(Self.Parent);
  CaricaChkListFlussi(WC013.ckList);
  C190PutCheckList(dedtNumeriSucc.Text,4,WC013.ckList);
  WC013.ResultEvent:=ResultFlussiSucc;
  WC013.Visualizza;
end;

end.
