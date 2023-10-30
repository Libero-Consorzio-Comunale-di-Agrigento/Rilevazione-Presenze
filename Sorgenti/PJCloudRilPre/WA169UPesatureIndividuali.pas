unit WA169UPesatureIndividuali;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR103UGestMasterDetail, System.Actions, Vcl.ActnList, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel, meIWLabel,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton, meIWButton, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, A169UCalcoloDtM, A000UMessaggi;

type
  TWA169FPesatureIndividuali = class(TWR103FGestMasterDetail)
  procedure IWAppFormCreate(Sender: TObject);
  private
    A169FCalcoloDTM: TA169FCalcoloDTM;
  public
    function Aggiorna(Msg,Blocca:Boolean):String;
  protected
  end;

implementation

uses WA169UPesatureIndividualiDM, WA169UPesatureIndividualiBrowseFM, WA169UPesatureFM, WA169UPesatureIndividualiDettFM;

{$R *.dfm}

procedure TWA169FPesatureIndividuali.IWAppFormCreate(Sender: TObject);
var
  Detail:TWA169FPesatureFM;
begin
  inherited;
  WR302DM:=TWA169FPesatureIndividualiDM.Create(Self);
  A169FCalcoloDTM:=TWA169FPesatureIndividualiDM(WR302DM).A169FPesatureIndividualiMW.A169FCalcoloDTM;

  WR100LinkWC700:=False;
  AttivaGestioneC700;
  WBrowseFM:=TWA169FPesatureIndividualiBrowseFM.Create(Self);

  Detail:=TWA169FPesatureFM.Create(Self);
  AggiungiDetail(Detail);
  Detail.CaricaDettaglio(TWA169FPesatureIndividualiDM(WR302DM).A169FPesatureIndividualiMW.selT774,TWA169FPesatureIndividualiDM(WR302DM).A169FPesatureIndividualiMW.dsrT774);

  WDettaglioFM:=TWA169FPesatureIndividualiDettFM.Create(Self);
  CreaTabDefault;

  Aggiorna(True,False);

end;

function TWA169FPesatureIndividuali.Aggiorna(Msg,Blocca:Boolean):String;
begin
  A169FCalcoloDTM.AggiornaTotali( WR302DM.selTabella.FieldByName('ANNO').AsInteger,
                     WR302DM.selTabella.FieldByName('CODGRUPPO').AsString,
                     WR302DM.selTabella.FieldByName('CODTIPOQUOTA').AsString );
  (WDettaglioFM as TWA169FPesatureIndividualiDettFM).edtTotPesi.Text:=FloatToStr(A169FCalcoloDTM.TotalePesi);
  (WDettaglioFM as TWA169FPesatureIndividualiDettFM).edtTotPesi.css:=StringReplace((WDettaglioFM as TWA169FPesatureIndividualiDettFM).edtTotPesi.css,'font_rossoImp','font_neroImp',[rfReplaceAll]);
  (WDettaglioFM as TWA169FPesatureIndividualiDettFM).lblTotPesi.css:=StringReplace((WDettaglioFM as TWA169FPesatureIndividualiDettFM).edtTotPesi.css,'font_rossoImp','font_neroImp',[rfReplaceAll]);
  (WDettaglioFM as TWA169FPesatureIndividualiDettFM).edtTotPesiCalc.Text:=FloatToStr(A169FCalcoloDTM.TotalePesiCalc);
  (WDettaglioFM as TWA169FPesatureIndividualiDettFM).edtTotPesiCalc.css:=StringReplace((WDettaglioFM as TWA169FPesatureIndividualiDettFM).edtTotPesiCalc.css,'font_rossoImp','font_neroImp',[rfReplaceAll]);
  (WDettaglioFM as TWA169FPesatureIndividualiDettFM).lblTotPesiCalc.css:=StringReplace((WDettaglioFM as TWA169FPesatureIndividualiDettFM).edtTotPesiCalc.css,'font_rossoImp','font_neroImp',[rfReplaceAll]);
  (WDettaglioFM as TWA169FPesatureIndividualiDettFM).edtTotQuote.Text:=FloatToStr(A169FCalcoloDTM.TotaleQuote);
  (WDettaglioFM as TWA169FPesatureIndividualiDettFM).edtTotQuote.css:=StringReplace((WDettaglioFM as TWA169FPesatureIndividualiDettFM).edtTotQuote.css,'font_rossoImp','font_neroImp',[rfReplaceAll]);
  (WDettaglioFM as TWA169FPesatureIndividualiDettFM).lblTotQuote.css:=StringReplace((WDettaglioFM as TWA169FPesatureIndividualiDettFM).edtTotQuote.css,'font_rossoImp','font_neroImp',[rfReplaceAll]);
  (WDettaglioFM as TWA169FPesatureIndividualiDettFM).edtTotQuoteCalc.Text:=FloatToStr(A169FCalcoloDTM.TotaleQuoteCalc);
  (WDettaglioFM as TWA169FPesatureIndividualiDettFM).edtTotQuoteCalc.css:=StringReplace((WDettaglioFM as TWA169FPesatureIndividualiDettFM).edtTotQuoteCalc.css,'font_rossoImp','font_neroImp',[rfReplaceAll]);
  (WDettaglioFM as TWA169FPesatureIndividualiDettFM).lblTotQuoteCalc.css:=StringReplace((WDettaglioFM as TWA169FPesatureIndividualiDettFM).edtTotQuoteCalc.css,'font_rossoImp','font_neroImp',[rfReplaceAll]);
  if (TWA169FPesatureIndividualiDM(WR302DM).selTabella.FieldByName('PESO_TOTALE').AsFloat <> 0) and
     (A169FCalcoloDTM.TotalePesi > WR302DM.selTabella.FieldByName('PESO_TOTALE').AsFloat) then
  begin
    (WDettaglioFM as TWA169FPesatureIndividualiDettFM).edtTotPesi.css:=StringReplace((WDettaglioFM as TWA169FPesatureIndividualiDettFM).edtTotPesi.css,'font_neroImp','font_rossoImp',[rfReplaceAll]);
    (WDettaglioFM as TWA169FPesatureIndividualiDettFM).lblTotPesi.css:=StringReplace((WDettaglioFM as TWA169FPesatureIndividualiDettFM).edtTotPesi.css,'font_neroImp','font_rossoImp',[rfReplaceAll]);
    (WDettaglioFM as TWA169FPesatureIndividualiDettFM).edtTotPesi.Text:=FloatToStr(A169FCalcoloDTM.TotalePesi);
    if Msg then
      if Blocca then
        raise exception.Create(A000MSG_A169_ERR_PESI_BASE)
      else
        Result:=A000MSG_A169_ERR_PESI_BASE;
  end;
  if (TWA169FPesatureIndividualiDM(WR302DM).selTabella.FieldByName('PESO_TOTALE').AsFloat <> 0) and
     (A169FCalcoloDTM.TotalePesiCalc > WR302DM.selTabella.FieldByName('PESO_TOTALE').AsFloat) then
  begin
    (WDettaglioFM as TWA169FPesatureIndividualiDettFM).edtTotPesiCalc.css:=StringReplace((WDettaglioFM as TWA169FPesatureIndividualiDettFM).edtTotPesiCalc.css,'font_neroImp','font_rossoImp',[rfReplaceAll]);
    (WDettaglioFM as TWA169FPesatureIndividualiDettFM).lblTotPesiCalc.css:=StringReplace((WDettaglioFM as TWA169FPesatureIndividualiDettFM).lblTotPesiCalc.css,'font_neroImp','font_rossoImp',[rfReplaceAll]);
    (WDettaglioFM as TWA169FPesatureIndividualiDettFM).edtTotPesiCalc.Text:=FloatToStr(A169FCalcoloDTM.TotalePesiCalc);
    if Msg then
      if Blocca then
        raise exception.Create(A000MSG_A169_ERR_PESI_CALCOLATI)
      else
        Result:=A000MSG_A169_ERR_PESI_CALCOLATI;
  end;
  if (TWA169FPesatureIndividualiDM(WR302DM).selTabella.FieldByName('QUOTA_TOTALE').AsFloat <> 0) and
     (A169FCalcoloDTM.TotaleQuote > WR302DM.selTabella.FieldByName('QUOTA_TOTALE').AsFloat) then
  begin
    (WDettaglioFM as TWA169FPesatureIndividualiDettFM).edtTotQuote.css:=StringReplace((WDettaglioFM as TWA169FPesatureIndividualiDettFM).edtTotQuote.css,'font_neroImp','font_rossoImp',[rfReplaceAll]);
    (WDettaglioFM as TWA169FPesatureIndividualiDettFM).lblTotQuote.css:=StringReplace((WDettaglioFM as TWA169FPesatureIndividualiDettFM).lblTotQuote.css,'font_neroImp','font_rossoImp',[rfReplaceAll]);
    (WDettaglioFM as TWA169FPesatureIndividualiDettFM).edtTotQuote.Text:=FloatToStr(A169FCalcoloDTM.TotaleQuote);
    if Msg then
      if Blocca then
        raise exception.Create(A000MSG_A169_ERR_QUOTE_ASSEGNATE)
      else
        Result:=A000MSG_A169_ERR_QUOTE_ASSEGNATE;
  end;
  if (TWA169FPesatureIndividualiDM(WR302DM).selTabella.FieldByName('QUOTA_TOTALE').AsFloat <> 0) and
   (A169FCalcoloDTM.TotaleQuoteCalc > WR302DM.selTabella.FieldByName('QUOTA_TOTALE').AsFloat) then
  begin
    (WDettaglioFM as TWA169FPesatureIndividualiDettFM).edtTotQuoteCalc.css:=StringReplace((WDettaglioFM as TWA169FPesatureIndividualiDettFM).edtTotQuoteCalc.css,'font_neroImp','font_rossoImp',[rfReplaceAll]);
    (WDettaglioFM as TWA169FPesatureIndividualiDettFM).lblTotQuoteCalc.css:=StringReplace((WDettaglioFM as TWA169FPesatureIndividualiDettFM).lblTotQuoteCalc.css,'font_neroImp','font_rossoImp',[rfReplaceAll]);
    (WDettaglioFM as TWA169FPesatureIndividualiDettFM).edtTotQuoteCalc.Text:=FloatToStr(A169FCalcoloDTM.TotaleQuoteCalc);
    if Msg then
      if Blocca then
        raise exception.Create(A000MSG_A169_ERR_QUOTE_CALCOLATE)
      else
        Result:=A000MSG_A169_ERR_QUOTE_CALCOLATE;
  end;
end;

end.
