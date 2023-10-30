unit WA151UGrigliaRisultatoFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR200UBaseFM, IWCompJQueryWidget, A000UMessaggi,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, StrUtils, WR100UBase,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWApplication,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompGrids, IWDBGrids, medpIWDBGrid, A000UInterfaccia,
  IWCompLabel, meIWLabel, IWCompListbox, meIWComboBox, IWCompEdit, meIWEdit,
  IWCompExtCtrls, meIWImageFile, medpIWImageButton, Vcl.Menus, WR010UBase, C180FunzioniGenerali;

type
  TWA151FGrigliaRisultatoFM = class(TWR200FBaseFM)
    dgrdRisultato: TmedpIWDBGrid;
    cmbIdMittente: TmeIWComboBox;
    lblIdMittente: TmeIWLabel;
    lblDescIdMittente: TmeIWLabel;
    lblIdUfficio: TmeIWLabel;
    cmbIdUfficio: TmeIWComboBox;
    lblDescIdUfficio: TmeIWLabel;
    edtUsername: TmeIWEdit;
    edtCodiceEnte: TmeIWEdit;
    lblUsername: TmeIWLabel;
    lblCodiceEnte: TmeIWLabel;
    lblEsportazioneXML: TmeIWLabel;
    btnAnomalie: TmedpIWImageButton;
    btnEsegui: TmedpIWImageButton;
    pmnGrid: TPopupMenu;
    actScaricaRisultatoInExcel: TMenuItem;
    lblURLWS: TmeIWLabel;
    edtURLWS: TmeIWEdit;
    actScaricaRisultatoInCSV: TMenuItem;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure IWFrameRegionRender(Sender: TObject);
    procedure dgrdRisultatoRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure actScaricaRisultatoInExcelClick(Sender: TObject);
    procedure cmbIdMittenteChange(Sender: TObject);
    procedure cmbIdUfficioChange(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure actScaricaRisultatoInCSVClick(Sender: TObject);
  private
    IndL104,IndDip,IndData:Integer;
  public
  end;

var
  WA151FGrigliaRisultatoFM: TWA151FGrigliaRisultatoFM;

implementation

uses WA151UAssenteismo, WA151UAssenteismoDM, WA151UAssenteismoDettFM;

{$R *.dfm}

procedure TWA151FGrigliaRisultatoFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  with ((Self.Owner as TWA151FAssenteismo).WR302DM as TWA151FAssenteismoDM).A151MW do
  begin
    if cmbIDMittente.Items.Count = 0 then
    begin
      cmbIDMittente.Items.Add('');
      selI010.First;
      while not selI010.Eof do
      begin
        cmbIDMittente.Items.Add(selI010.FieldByName('NOME_CAMPO').AsString);
        selI010.Next;
      end;
    end;
    if cmbIDUfficio.Items.Count = 0 then
    begin
      cmbIDUfficio.Items.Add('');
      selI010B.First;
      while not selI010B.Eof do
      begin
        cmbIDUfficio.Items.Add(selI010B.FieldByName('NOME_CAMPO').AsString);
        selI010B.Next;
      end;
    end;
  end;
end;

procedure TWA151FGrigliaRisultatoFM.IWFrameRegionRender(Sender: TObject);
begin
  inherited;
  with ((Self.Owner as TWA151FAssenteismo).WR302DM as TWA151FAssenteismoDM).A151MW do
  begin
    lblEsportazioneXML.Caption:=IfThen(EsportaTassiAss,'Esporta tassi assenza in .XML',IfThen(EsportaLegge104,'Invio permessi legge 104/1992 tramite WebService'));

    lblEsportazioneXML.Enabled:=EsportaTassiAss or EsportaLegge104;
    btnEsegui.Enabled:=EsportaTassiAss or EsportaLegge104;
    btnAnomalie.Enabled:=False;

    lblIDMittente.Visible:=EsportaTassiAss;
    cmbIDMittente.Visible:=EsportaTassiAss;
    lblDescIDMittente.Visible:=EsportaTassiAss;
    lblIDUfficio.Visible:=EsportaTassiAss;
    cmbIDUfficio.Visible:=EsportaTassiAss;
    lblDescIDUfficio.Visible:=EsportaTassiAss;

    lblUsername.Visible:=EsportaLegge104;
    edtUsername.Visible:=EsportaLegge104;
    lblCodiceEnte.Visible:=EsportaLegge104;
    edtCodiceEnte.Visible:=EsportaLegge104;
    lblURLWS.Visible:=EsportaLegge104;
    edtURLWS.Visible:=EsportaLegge104;

    if EsportaLegge104 then
    begin
      edtUsername.Text:=UserNameText;
      edtCodiceEnte.Text:=CodEnteText;
      edtURLWS.Text:=URLWSText;
    end;
  end;
end;

procedure TWA151FGrigliaRisultatoFM.cmbIdMittenteChange(Sender: TObject);
var Campo:String;
begin
  inherited;
  Campo:=VarToStr(cmbIdMittente.Items[cmbIdMittente.ItemIndex]);
  lblDescIdMittente.Visible:=Campo <> '';
  if lblDescIdMittente.Visible then
    with ((Self.Owner as TWA151FAssenteismo).WR302DM as TWA151FAssenteismoDM).A151MW do
    begin
      lblDescIdMittente.Caption:=VarToStr(selI010.Lookup('NOME_CAMPO',Campo,'NOME_LOGICO'));
      if cdsRisultato.FieldByName(Campo).DisplayLabel <> lblDescIdMittente.Caption then
        lblDescIdMittente.Caption:=lblDescIdMittente.Caption + IfThen(lblDescIdMittente.Caption='','',' (Colonna ') + cdsRisultato.FieldByName(Campo).DisplayLabel + IfThen(lblDescIdMittente.Caption='','',')');
    end;
end;

procedure TWA151FGrigliaRisultatoFM.cmbIdUfficioChange(Sender: TObject);
var Campo:String;
begin
  inherited;
  Campo:=VarToStr(cmbIdUfficio.Items[cmbIdUfficio.ItemIndex]);
  lblDescIdUfficio.Visible:=Campo <> '';
  if lblDescIdUfficio.Visible then
    with ((Self.Owner as TWA151FAssenteismo).WR302DM as TWA151FAssenteismoDM).A151MW do
    begin
      lblDescIdUfficio.Caption:=VarToStr(selI010B.Lookup('NOME_CAMPO',Campo,'NOME_LOGICO'));
      if cdsRisultato.FieldByName(Campo).DisplayLabel <> lblDescIdUfficio.Caption then
        lblDescIdUfficio.Caption:=lblDescIdUfficio.Caption + IfThen(lblDescIdUfficio.Caption='','',' (Colonna ') + cdsRisultato.FieldByName(Campo).DisplayLabel + IfThen(lblDescIdUfficio.Caption='','',')');
    end;
end;

procedure TWA151FGrigliaRisultatoFM.dgrdRisultatoRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var NumColonna: Integer;
begin
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;
  if ARow = 0 then
    Exit;

  NumColonna:=dgrdRisultato.medpNumColonna(AColumn);

  //Evidenzio le colonne del dipendente
  if NumColonna = dgrdRisultato.medpNumColonna(dgrdRisultato.medpIndexColonna('COGNOME')) then
    IndDip:=NumColonna;
  //Evidenzio le colonne del giustificativo
  if NumColonna = dgrdRisultato.medpNumColonna(dgrdRisultato.medpIndexColonna('DATAGIUSTIF')) then
    IndData:=NumColonna;
  //Evidenzio le colonne tipiche della legge 104
  if NumColonna = dgrdRisultato.medpNumColonna(dgrdRisultato.medpIndexColonna('TIPO_DISABILITA')) then
    IndL104:=NumColonna;
  if ((IndL104 > 0) and (NumColonna >= IndL104)) or
     ((IndDip > 0) and (NumColonna >= IndDip) and (NumColonna <= IndDip + 3)) or
     ((IndData > 0) and (NumColonna >= IndData) and (NumColonna <= IndData + 1)) then
  begin
    ACell.Css:=StringReplace(ACell.Css,'riga_bianca','bg_aqua',[rfReplaceAll]);
    ACell.Css:=StringReplace(ACell.Css,'riga_colorata','bg_aqua',[rfReplaceAll]);
  end;
end;

procedure TWA151FGrigliaRisultatoFM.btnEseguiClick(Sender: TObject);
begin
  inherited;
  with ((Self.Owner as TWA151FAssenteismo).WR302DM as TWA151FAssenteismoDM).A151MW do
  begin
    IdUfficioText:=cmbIdUfficio.Text;
    IdUfficioValue:=VarToStr(cmbIdUfficio.Items[cmbIdUfficio.ItemIndex]);
    IdMittenteText:=cmbIdMittente.Text;
    IdMittenteValue:=VarToStr(cmbIdMittente.Items[cmbIdMittente.ItemIndex]);
    DettDip:=selT151.FieldByName('DETTAGLIO_DIP').AsString = 'S';//((Self.Owner as TWA151FAssenteismo).WDettaglioFM as TWA151FAssenteismoDettFM).dchkDettaglioDip.Checked;
    DettGG:=selT151.FieldByName('ASS_DETTAGLIO').AsString = 'S';//((Self.Owner as TWA151FAssenteismo).WDettaglioFM as TWA151FAssenteismoDettFM).dchkDettaglioGiustificativi.Checked;
    DettFam:=selT151.FieldByName('ASS_FAMILIARI').AsString = 'S';//((Self.Owner as TWA151FAssenteismo).WDettaglioFM as TWA151FAssenteismoDettFM).dchkDettaglioFamiliari.Checked;
    if EsportaTassiAss then
      ControlliGeneraXmlTassiAss
    else if EsportaLegge104 then
      ControlliGeneraXmlLegge104;
    cdsRisultato.DisableControls;
    cdsRisultato.First;
    try
      //Esportazione in xml
      RegistraMsg.IniziaMessaggio('WA151');//Posizionato dopo le domande dei controlli
      if EsportaTassiAss then
        try
          GeneraXmlTassiAss;
        finally
          (Self.Owner as TWR010FBase).InviaFile('AssenteismoEForzaLavoro.xml',XMLGenerato.XML.Text);
          XMLGenerato.Active:=False;
          cdsRisultato.First;
          cdsRisultato.EnableControls;
        end
      else if EsportaLegge104 then
        try
          WSLegge104;
        finally
          cdsRisultato.First;
          cdsRisultato.EnableControls;
        end;
    finally //gestito in caso di abort in WSLegge104
      btnAnomalie.Enabled:=RegistraMsg.ContieneTipoA;
      (Self.Owner as TWA151FAssenteismo).evtClearKeys;
      if RegistraMsg.ContieneTipoA then
        Msgbox.MessageBox(A000MSG_MSG_ELABORAZIONE_ANOMALIE,INFORMA)
      else
        Msgbox.MessageBox(A000MSG_MSG_ELABORAZIONE_TERMINATA,INFORMA);
    end;
  end;
end;

procedure TWA151FGrigliaRisultatoFM.actScaricaRisultatoInCSVClick(Sender: TObject);
begin
  if not Assigned(Sender) then
    (Self.Owner as TWR010FBase).csvDownload:=dgrdRisultato.ToCsv
  else
    (Self.Owner as TWR010FBase).InviaFile('AssenteismoEForzaLavoro.xls',(Self.Owner as TWR010FBase).csvDownload);
end;

procedure TWA151FGrigliaRisultatoFM.actScaricaRisultatoInExcelClick(Sender: TObject);
begin
  if not Assigned(Sender) then
    (Self.Owner as TWR010FBase).streamDownload:=dgrdRisultato.ToXlsx
  else
    (Self.Owner as TWR010FBase).InviaFile('AssenteismoEForzaLavoro.xlsx',(Self.Owner as TWR010FBase).streamDownload);
end;

end.
