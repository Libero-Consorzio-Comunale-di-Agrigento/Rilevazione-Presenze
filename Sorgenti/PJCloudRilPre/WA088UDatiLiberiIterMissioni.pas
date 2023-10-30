unit WA088UDatiLiberiIterMissioni;

interface

uses
  WR103UGestMasterDetail, A000UMessaggi,
  WA088UDatiLiberiIterMissioniDM, WA088UDatiLiberiIterMissioniBrowseFM,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, meIWImageFile,
  IWCompButton, meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink;

type
  TWA088FDatiLiberiIterMissioni = class(TWR103FGestMasterDetail)
    procedure IWAppFormCreate(Sender: TObject);
    procedure actCopiaSuExecute(Sender: TObject);
  end;

implementation

{$R *.dfm}

uses
  A000UInterfaccia,
  WA088UDatiLiberiIterMissioniDettFM;

procedure TWA088FDatiLiberiIterMissioni.actCopiaSuExecute(Sender: TObject);
begin
  // le categorie di sistema (ordine 0) non sono duplicabili
  if WR302DM.selTabella.FieldByName('ORDINE').AsInteger = 0 then
    raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_A088_ERR_FMT_DUP_CAT0),[WR302DM.selTabella.FieldByName('DESCRIZIONE').AsString]));

  inherited;
end;

procedure TWA088FDatiLiberiIterMissioni.IWAppFormCreate(Sender: TObject);
var
  Detail: TWA088FDatiLiberiIterMissioniDettFM;
begin
  inherited;
  InterfacciaWR102.DettaglioFM:=False;
  WR302DM:=TWA088FDatiLiberiIterMissioniDM.Create(Self);
  WBrowseFM:=TWA088FDatiLiberiIterMissioniBrowseFM.Create(Self);

  Detail:=TWA088FDatiLiberiIterMissioniDettFM.Create(Self);
  AggiungiDetail(Detail);
  Detail.CaricaDettaglio(TWA088FDatiLiberiIterMissioniDM(WR302DM).selM025,TWA088FDatiLiberiIterMissioniDM(WR302DM).dsrM025);

  CreaTabDefault;
end;

end.
