unit WA132UControlloFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,OracleData,
  Dialogs, WR200UBaseFM, IWCompExtCtrls, meIWImageFile, medpIWImageButton, IWCompEdit, meIWEdit, IWCompListbox, IWDBStdCtrls, meIWDBLookupComboBox, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompLabel, meIWLabel, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, meIWComboBox;

type
  TWA132FControlloFM = class(TWR200FBaseFM)
    lblRiepilogoComplessivoDal: TmeIWLabel;
    lblRiepilogoComplessivoAl: TmeIWLabel;
    dedtDaData: TmeIWEdit;
    dedtAData: TmeIWEdit;
    lblRiepilogoFornitura: TmeIWLabel;
    btnRiepilogoComplessivo: TmedpIWImageButton;
    btnRiepilogoFornitura: TmedpIWImageButton;
    lblBuoniPasto: TmeIWLabel;
    lblTicket: TmeIWLabel;
    lblBuoniAcquistati: TmeIWLabel;
    lblBuoniAssegnati: TmeIWLabel;
    lblBuoniResidui: TmeIWLabel;
    lblBuoniScaduti: TmeIWLabel;
    lblTicketAcquistati: TmeIWLabel;
    lblTicketAssegnati: TmeIWLabel;
    lblTicketResidui: TmeIWLabel;
    lblTicketScaduti: TmeIWLabel;
    edtBuoniAcq: TmeIWEdit;
    edtBuoniAss: TmeIWEdit;
    edtBuoniRes: TmeIWEdit;
    edtBuoniScad: TmeIWEdit;
    edtTicketAcq: TmeIWEdit;
    edtTicketAss: TmeIWEdit;
    edtTicketRes: TmeIWEdit;
    edtTicketScad: TmeIWEdit;
    cmbDataAcquisto: TmeIWComboBox;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure btnRiepilogoComplessivoClick(Sender: TObject);
    procedure cmbDataAcquistoChange(Sender: TObject);
  private
    {private declaration}
  public
     procedure RefrehCmbDataAcquisto;
  end;

implementation

uses WA132UMagazzinoBuoniPasto, WA132UMagazzinoBuoniPastoDM;

{$R *.dfm}

procedure TWA132FControlloFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  DedtDaData.Text:='01/01/1900';
  DedtAData.Text:=FormatDateTime('dd/mm/yyyy',Date);
  RefrehCmbDataAcquisto;
end;

procedure TWA132FControlloFM.btnRiepilogoComplessivoClick(Sender: TObject);
begin
  with TWA132FMagazzinoBuoniPastoDM(TWA132FMagazzinoBuoniPasto(Self.Owner).WR302DM).A132MW do
  begin
    BuoniAcquistati:=0;
    BuoniAssegnati:=0;
    BuoniScaduti:=0;
    TicketAcquistati:=0;
    TicketAssegnati:=0;
    TicketScaduti:=0;
    CalcolaRiepilogoComplessivo:=(Sender = btnRiepilogoComplessivo);
    try
      DataDa:=StrToDate(dedtDaData.Text);
      DataA:=StrToDate(dedtAData.Text);
      if DataDa > DataA then
        Abort;
    except
      raise Exception.Create('Periodo errato');
    end;
    DataAcquisto:=StrToDate(cmbDataAcquisto.Text);
    CalcolaRiepilogo;
    edtBuoniAcq.Text:=IntToStr(BuoniAcquistati);
    edtBuoniAss.Text:=IntToStr(BuoniAssegnati);
    edtBuoniRes.Text:=IntToStr(BuoniResidui);
    edtBuoniScad.Text:=IntToStr(BuoniScaduti);
    edtTicketAcq.Text:=IntToStr(TicketAcquistati);
    edtTicketAss.Text:=IntToStr(TicketAssegnati);
    edtTicketRes.Text:=IntToStr(TicketResidui);
    edtTicketScad.Text:=IntToStr(TicketScaduti);
  end;
end;

procedure TWA132FControlloFM.cmbDataAcquistoChange(Sender: TObject);
begin
  with TWA132FMagazzinoBuoniPasto(Self.Owner) do
  begin
    WR302DM.SelTabella.SearchRecord('DATA_ACQUISTO',StrToDate(cmbDataAcquisto.Text),[srFromBeginning]);
    WBrowseFM.grdTabella.medpAggiornaCDS;
  end;
end;

procedure TWA132FControlloFM.RefrehCmbDataAcquisto;
begin
  cmbDataAcquisto.Items.Clear;
  with TWA132FMagazzinoBuoniPasto(Self.Owner).WR302DM.SelTabella do
  begin
    Refresh;
    First;
    while not Eof do
    begin
      cmbDataAcquisto.Items.Add(FieldByName('DATA_ACQUISTO').AsString);
      Next;
    end;
    Last;
    cmbDataAcquisto.ItemIndex:=cmbDataAcquisto.Items.IndexOf(FieldByName('DATA_ACQUISTO').AsString);
  end;
end;

end.
