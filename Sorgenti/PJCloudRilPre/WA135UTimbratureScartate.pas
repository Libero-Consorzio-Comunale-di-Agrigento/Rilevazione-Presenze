unit WA135UTimbratureScartate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR103UGestMasterDetail, ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWHTMLControls, meIWLink, IWCompEdit, meIWEdit, WA135UTimbratureFM, C180FunzioniGenerali,
  System.Actions, meIWImageFile;

type
  TWA135FTimbratureScartate = class(TWR103FGestMasterDetail)
    lblMese: TmeIWLabel;
    lblAnno: TmeIWLabel;
    edtMese: TmeIWEdit;
    edtAnno: TmeIWEdit;
    procedure IWAppFormCreate(Sender: TObject);
    procedure MeseAnnoChange(Sender: TObject);
    procedure edtMeseAsyncChange(Sender: TObject; EventParams: TStringList);
  private
    WA135DetailFM:TWA135FTimbratureFM;
    InizioMese,FineMese:TDateTime;
    Giorno,Mese,Anno:Word;
    procedure CaricaDati;
  public
    {Public declaration}
  end;


implementation

uses WA135UTimbratureScartateBrowseFM,WA135UTimbratureScartateDM;

{$R *.dfm}

procedure TWA135FTimbratureScartate.edtMeseAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  MeseAnnoChange(Sender);
end;

procedure TWA135FTimbratureScartate.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR100LinkWC700:=True;
  InterfacciaWR102.DettaglioFM:=False;
  WR302DM:=TWA135FTimbratureScartateDM.Create(Self);
  AttivaGestioneC700;
  WBrowseFM:=TWA135FTimbratureScartateBrowseFM.Create(Self);
  WA135DetailFM:=TWA135FTimbratureFM.Create(Self);
  AggiungiDetail(WA135DetailFM);
  WA135DetailFM.CaricaDettaglio((WR302DM as TWA135FTimbratureScartateDM).selT100,(WR302DM as TWA135FTimbratureScartateDM).dsrT100);
  DecodeDate(Date,Anno,Mese,Giorno);
  edtMese.Text:=IntToStr(Mese);
  edtAnno.Text:=IntToStr(Anno);
  InizioMese:=EncodeDate(Anno,Mese,1);
  FineMese:=R180FineMese(InizioMese);
  CaricaDati;
end;

procedure TWA135FTimbratureScartate.MeseAnnoChange(Sender: TObject);
begin
  if Sender = edtMese then
    begin
    if edtMese.Text <> IntToStr(Mese) then
      begin
      Mese:=StrToInt(edtMese.Text);
      end;
    end
  else
    begin
    if edtAnno.Text <> IntToStr(Anno) then
      begin
      Anno:=StrToInt(edtAnno.Text);
      end;
    end;
  InizioMese:=EncodeDate(Anno,Mese,1);
  FineMese:=R180FineMese(InizioMese);
  CaricaDati;
end;

procedure TWA135FTimbratureScartate.CaricaDati;
begin
  with (WR302DM as TWA135FTimbratureScartateDM).selTabella do
  begin
    Close;
    SetVariable('PROGRESSIVO',grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    SetVariable('DATAINIZIO',InizioMese);
    SetVariable('DATAFINE',FineMese);
    Open;
  end;
  with (WR302DM as TWA135FTimbratureScartateDM).selT100 do
  begin
    Close;
    SetVariable('PROGRESSIVO',grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    SetVariable('DATAGIORNO',(WR302DM as TWA135FTimbratureScartateDM).selTabella.FieldByName('DATA').AsDateTime);
    Open;
  end;
  (WBrowseFM as TWA135FTimbratureScartateBrowseFM).grdTabella.medpAggiornaCDS;
  (WA135DetailFM as TWA135FTimbratureFM).grdTabella.medpAggiornaCDS;
end;

end.
