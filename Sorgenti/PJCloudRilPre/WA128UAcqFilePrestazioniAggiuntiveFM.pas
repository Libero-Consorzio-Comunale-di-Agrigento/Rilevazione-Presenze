unit WA128UAcqFilePrestazioniAggiuntiveFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR200UBaseFM, IWCompJQueryWidget, IWVCLComponent, IWApplication,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWCompEdit, meIWEdit,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompLabel,
  meIWLabel, IWCompExtCtrls, meIWImageFile, medpIWImageButton,
  A000UCostanti, A000UInterfaccia, A000UMessaggi, IWCompFileUploader,
  meIWFileUploader, IWCompCheckbox, meIWCheckBox;

type
  TWA128FAcqFilePrestazioniAggiuntiveFM = class(TWR200FBaseFM)
    lblInizioAcquisizione: TmeIWLabel;
    edtInizioAcquisizione: TmeIWEdit;
    lblFineAcquisizione: TmeIWLabel;
    edtFineAcquisizione: TmeIWEdit;
    lblNomeFileInput: TmeIWLabel;
    lblGrigliaTracciato: TmeIWLabel;
    lblPosizione: TmeIWLabel;
    lblLunghezza: TmeIWLabel;
    lblMatricola: TmeIWLabel;
    lblGiorno: TmeIWLabel;
    lblMese: TmeIWLabel;
    lblAnno: TmeIWLabel;
    lblTurno1: TmeIWLabel;
    edtMatricolaPos: TmeIWEdit;
    edtGiornoPos: TmeIWEdit;
    edtMesePos: TmeIWEdit;
    edtAnnoPos: TmeIWEdit;
    edtTurno1Pos: TmeIWEdit;
    edtMatricolaLun: TmeIWEdit;
    edtGiornoLun: TmeIWEdit;
    edtMeseLun: TmeIWEdit;
    edtAnnoLun: TmeIWEdit;
    edtTurno1Lun: TmeIWEdit;
    btnAnomalie: TmedpIWImageButton;
    btnAcquisizione: TmedpIWImageButton;
    lblParametriAcquisizione: TmeIWLabel;
    fileUpload: TmeIWFileUploader;
    edtTurno2Pos: TmeIWEdit;
    edtTurno2Lun: TmeIWEdit;
    lblTurno2: TmeIWLabel;
    edtOraInizioTurno1Pos: TmeIWEdit;
    edtOraInizioTurno1Lun: TmeIWEdit;
    edtOraFineTurno1Pos: TmeIWEdit;
    edtOraFineTurno1Lun: TmeIWEdit;
    edtOraInizioTurno2Lun: TmeIWEdit;
    edtOraInizioTurno2Pos: TmeIWEdit;
    edtOraFineTurno2Pos: TmeIWEdit;
    edtOraFineTurno2Lun: TmeIWEdit;
    lblInizioTurno1: TmeIWLabel;
    lblFineTurno1: TmeIWLabel;
    lblInizioTurno2: TmeIWLabel;
    lblFineTurno2: TmeIWLabel;
    chkSovrascriviEsistenti: TmeIWCheckBox;
    procedure btnAcquisizioneClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure IWFrameRegionRender(Sender: TObject);
  private
    procedure CaricaParametriFile;
    procedure RecuperaFile;
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses WA128UPianPrestazioniAggiuntive, WA128UPianPrestazioniAggiuntiveDM, WR100UBase;

{$R *.dfm}

procedure TWA128FAcqFilePrestazioniAggiuntiveFM.btnAcquisizioneClick(Sender: TObject);
begin
  try
    StrToDate(edtInizioAcquisizione.Text);
    StrToDate(edtFineAcquisizione.Text);
  except
    raise exception.Create(A000MSG_ERR_PERIODO_ERRATO);
  end;
  CaricaParametriFile;
  RecuperaFile;
  (Self.Parent as TWR100FBase).StartElaborazioneCiclo((Sender as TmedpIWImageButton).HTMLName);
end;

procedure TWA128FAcqFilePrestazioniAggiuntiveFM.CaricaParametriFile;
var c: Integer;
begin
  with ((Self.Owner as TWA128FPianPrestazioniAggiuntive).WR302DM as TWA128FPianPrestazioniAggiuntiveDM).A128MW do
  begin
    Mappa[1].Pos:=StrToIntDef(edtMatricolaPos.Text,0);
    Mappa[1].Lun:=StrToIntDef(edtMatricolaLun.Text,0);
    Mappa[2].Pos:=StrToIntDef(edtGiornoPos.Text,0);
    Mappa[2].Lun:=StrToIntDef(edtGiornoLun.Text,0);
    Mappa[3].Pos:=StrToIntDef(edtMesePos.Text,0);
    Mappa[3].Lun:=StrToIntDef(edtMeseLun.Text,0);
    Mappa[4].Pos:=StrToIntDef(edtAnnoPos.Text,0);
    Mappa[4].Lun:=StrToIntDef(edtAnnoLun.Text,0);
    Mappa[5].Pos:=StrToIntDef(edtTurno1Pos.Text,0);
    Mappa[5].Lun:=StrToIntDef(edtTurno1Lun.Text,0);
    Mappa[6].Pos:=StrToIntDef(edtTurno2Pos.Text,0);
    Mappa[6].Lun:=StrToIntDef(edtTurno2Lun.Text,0);
    Mappa[7].Pos:=StrToIntDef(edtOraInizioTurno1Pos.Text,0);
    Mappa[7].Lun:=StrToIntDef(edtOraInizioTurno1Lun.Text,0);
    Mappa[8].Pos:=StrToIntDef(edtOraFineTurno1Pos.Text,0);
    Mappa[8].Lun:=StrToIntDef(edtOraFineTurno1Lun.Text,0);
    Mappa[9].Pos:=StrToIntDef(edtOraInizioTurno2Pos.Text,0);
    Mappa[9].Lun:=StrToIntDef(edtOraInizioTurno2Lun.Text,0);
    Mappa[10].Pos:=StrToIntDef(edtOraFineTurno2Pos.Text,0);
    Mappa[10].Lun:=StrToIntDef(edtOraFineTurno2Lun.Text,0);

    for c:=1 to 10 do
    begin
      // Controllo che il campo sia positivo (>= 0)
      if (Mappa[c].Pos < 0) or (Mappa[c].Lun < 0) then
        raise Exception.Create(Format(A000MSG_A128_ERR_FMT_DATO_NEGATIVO,[IntToStr(c)]));
      // Se l'utente ha azzerato la posizione ma non la lunghezza allora correggo il valore
      if (Mappa[c].Pos = 0) and (Mappa[c].Lun > 0) then
        Mappa[c].Lun:=0;
      // Se l'utente ha azzerato la lunghezza ma non la posizione allora correggo il valore
      if (Mappa[c].Lun = 0) and (Mappa[c].Pos > 0) then
        Mappa[c].Pos:=0;
    end;

    ControlloParametriFile;
  end;
end;

procedure TWA128FAcqFilePrestazioniAggiuntiveFM.IWFrameRegionRender(
  Sender: TObject);
begin
  inherited;
  fileUpload.Ripristina;
end;

procedure TWA128FAcqFilePrestazioniAggiuntiveFM.RecuperaFile;
var NFCorrente:String;
begin
 { DONE : TEST IW 14 OK }
  if not fileUpload.IsPresenteFileUploadato then
    raise Exception.Create(Format(A000MSG_A128_ERR_FMT_PATH_ERRATO,['''']));
  try
    // path e nome per il salvataggio su file system
    NFCorrente:=GGetWebApplicationThreadVar.UserCacheDir + fileUpload.NomeFile;
    // se esiste già un file con lo stesso nome lo cancella
    if FileExists(NFCorrente) then
      DeleteFile(NFCorrente);
    fileUpload.SalvaSuFile(NFCorrente);
    fileUpload.Ripristina;
  except
    on E:Exception do
    begin
      fileUpload.Ripristina;
      raise Exception.Create(Format(A000MSG_ERR_FMT_ERRORE,['upload fallito']));
    end;
  end;

  with ((Self.Owner as TWA128FPianPrestazioniAggiuntive).WR302DM as TWA128FPianPrestazioniAggiuntiveDM).A128MW do
  begin
    ApriFile(NFCorrente);
    RecuperaTotaleRigheFile;
    ApriFile(NFCorrente);
  end;
end;

procedure TWA128FAcqFilePrestazioniAggiuntiveFM.btnAnomalieClick(Sender: TObject);
var Params: String;
begin
  inherited;
  Params:='AZIENDA=' + Parametri.Azienda + ParamDelimiter +
          'OPERATORE=' + Parametri.Operatore + ParamDelimiter +
          'MASCHERA=' + (Self.Parent as TWR100FBase).medpCodiceForm + ParamDelimiter +
          'ID=' + IntToStr(RegistraMsg.ID) + ParamDelimiter +
          'TIPO=A,B';
  (Self.Parent as TWR100FBase).accediForm(201,Params,False);
end;

end.
