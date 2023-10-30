unit WA168UIncentiviMaturati;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR103UGestMasterDetail, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, A168UIncentiviMaturatiMW, IWCompCheckbox, meIWCheckBox, IWCompEdit,
  meIWEdit, WC013UCheckListFM, C190FunzioniGeneraliWeb, WR010UBase, C180FunzioniGenerali;

type
  TWA168FIncentiviMaturati = class(TWR103FGestMasterDetail)
    chkVisIntere: TmeIWCheckBox;
    chkVisProporzionate: TmeIWCheckBox;
    chkVisNette: TmeIWCheckBox;
    chkVisNetteRisp: TmeIWCheckBox;
    chkVisQuantitative: TmeIWCheckBox;
    chkVisAssenze: TmeIWCheckBox;
    edtQuote: TmeIWEdit;
    btnQuote: TmeIWButton;
    Quote: TmeIWLabel;
  procedure IWAppFormCreate(Sender: TObject);
    procedure chkVisIntereClick(Sender: TObject);
    procedure btnQuoteClick(Sender: TObject);
  private
    WC013: TWC013FCheckListFM;
    procedure chklstQuoteResult(Sender: TObject; Result: Boolean);
  public
    A168FIncentiviMaturatiMW: TA168FIncentiviMaturatiMW;
  end;

implementation

uses WA168UIncentiviMaturatiDM, WA168UIncentiviMaturatiBrowseFM, WA168UAbbattimentiFM;

{$R *.dfm}

procedure TWA168FIncentiviMaturati.btnQuoteClick(Sender: TObject);
var
  LstCodice, LstDescrizione, LstCausaliSelezionate: TStringList;
begin
  inherited;
  LstCodice:=TStringList.Create;
  LstDescrizione:=TStringList.Create;
  LstCausaliSelezionate:=TStringList.Create;
  try
    WC013:=TWC013FCheckListFM.Create(Self);
    with WC013 do
    begin
      with (WR302DM as TWA168FIncentiviMaturatiDM).A168FIncentiviMaturatiMW.selT765 do
      begin
        First;
        while not Eof do
        begin
          LstCodice.Add(FieldByName('CODICE').AsString);
          LstDescrizione.Add(Format('%-5s',[FieldByName('CODICE').AsString]) + ' - ' + FieldByName('DESCRIZIONE').AsString);
          Next;
        end;
      end;
      CaricaLista(LstDescrizione, LstCodice);
      LstCausaliSelezionate.Commatext:=edtQuote.Text;
      ImpostaValoriSelezionati(LstCausaliSelezionate);
      ResultEvent:=chklstQuoteResult;
      WC013.Visualizza(0,0);
    end;
  finally
    FreeAndNil(LstCodice);
    FreeAndNil(LstDescrizione);
    FreeAndNil(LstCausaliSelezionate);
  end;
end;

procedure TWA168FIncentiviMaturati.chklstQuoteResult(Sender: TObject; Result:Boolean);
var
  lstTmp: TStringList;
begin
  if Result then
  begin
    lstTmp:=(Sender as TWC013FCheckListFM).LeggiValoriSelezionati;
    edtQuote.Text:=lstTmp.CommaText;
    FreeAndNil(lstTmp);
    chkVisIntereClick(nil);
  end;
end;

procedure TWA168FIncentiviMaturati.chkVisIntereClick(Sender: TObject);
begin
  inherited;
  (WR302DM as TWA168FIncentiviMaturatiDM).A168FIncentiviMaturatiMW.bVisIntere:=chkVisIntere.Checked;
  (WR302DM as TWA168FIncentiviMaturatiDM).A168FIncentiviMaturatiMW.bVisProporzionate:=chkVisProporzionate.Checked;
  (WR302DM as TWA168FIncentiviMaturatiDM).A168FIncentiviMaturatiMW.bVisNette:=chkVisNette.Checked;
  (WR302DM as TWA168FIncentiviMaturatiDM).A168FIncentiviMaturatiMW.bVisNetteRisp:=chkVisNetteRisp.Checked;
  (WR302DM as TWA168FIncentiviMaturatiDM).A168FIncentiviMaturatiMW.bVisQuantitative:=chkVisQuantitative.Checked;
  (WR302DM as TWA168FIncentiviMaturatiDM).A168FIncentiviMaturatiMW.bVisAssenze:=chkVisAssenze.Checked;
  (WR302DM as TWA168FIncentiviMaturatiDM).A168FIncentiviMaturatiMW.sQuote:=edtQuote.Text;
  (WR302DM as TWA168FIncentiviMaturatiDM).A168FIncentiviMaturatiMW.AggiornaB;
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
end;

procedure TWA168FIncentiviMaturati.IWAppFormCreate(Sender: TObject);
var
  Detail:TWA168FAbbattimentiFM;
begin
  inherited;
  InterfacciaWR102.DettaglioFM:=False;
  WR302DM:=TWA168FIncentiviMaturatiDM.Create(Self);
  InterfacciaWR102.TemplateAutomatico:=False;
  AttivaGestioneC700;
  (WR302DM as TWA168FIncentiviMaturatiDM).A168FIncentiviMaturatiMW.SelAnagrafe:=grdC700.selAnagrafe;
  WBrowseFM:=TWA168FIncentiviMaturatiBrowseFM.Create(Self);
  Detail:=TWA168FAbbattimentiFM.Create(Self);
  AggiungiDetail(Detail);
  Detail.CaricaDettaglio(TWA168FIncentiviMaturatiDM(WR302DM).A168FIncentiviMaturatiMW.selT763,TWA168FIncentiviMaturatiDM(WR302DM).dsrT763);
  CreaTabDefault;
end;

end.
