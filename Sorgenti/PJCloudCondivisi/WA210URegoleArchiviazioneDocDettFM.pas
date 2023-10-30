unit WA210URegoleArchiviazioneDocDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompCheckbox, IWDBStdCtrls,
  meIWDBCheckBox, IWCompEdit, meIWDBEdit, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompLabel, meIWLabel, OracleData,
  IWCompExtCtrls, IWDBExtCtrls, meIWDBRadioGroup, IWCompListbox,
  meIWDBLookupComboBox, Data.DB;

type
  TWA210FRegoleArchiviazioneDocDettFM = class(TWR205FDettTabellaFM)
    lblDTipoDocumento: TmeIWLabel;
    lblCampiXml: TmeIWLabel;
    lblFileXml: TmeIWLabel;
    lblFilePdf: TmeIWLabel;
    lblPathFile: TmeIWLabel;
    dedtDTipoDocumento: TmeIWDBEdit;
    dedtPathFile: TmeIWDBEdit;
    dedtFilePdf: TmeIWDBEdit;
    dedtCampiXml: TmeIWDBEdit;
    dedtFileXml: TmeIWDBEdit;
    dchkSostituzioneFile: TmeIWDBCheckBox;
    dchkSvuotaCartella: TmeIWDBCheckBox;
    lblTabHeaderLocale: TmeIWLabel;
    lblTabHeaderRemota: TmeIWLabel;
    lblServerSFTP: TmeIWLabel;
    lblDirArch: TmeIWLabel;
    lblUsername: TmeIWLabel;
    lblPassword: TmeIWLabel;
    lblPathPSCP: TmeIWLabel;
    dedtServerSFTP: TmeIWDBEdit;
    dedtDirArch: TmeIWDBEdit;
    dedtUsername: TmeIWDBEdit;
    dedtPassword: TmeIWDBEdit;
    dedtPathPSCP: TmeIWDBEdit;
    lblDataUltimaArch: TmeIWLabel;
    dedtDataRifUltimaElab: TmeIWDBEdit;
    lblBucketId: TmeIWLabel;
    dedtBucketId: TmeIWDBEdit;
    rgpTipoMetadati: TmeIWDBRadioGroup;
    lblTipoMetadati: TmeIWLabel;
    dcmbTipologiaDocumenti: TmeIWDBLookupComboBox;
    lblTipologiaDocumenti: TmeIWLabel;
    procedure dchkSvuotaCartellaAsyncClick(Sender: TObject; EventParams: TStringList);
  private
    procedure GestioneCheckboxArchLocale;
  public
    selI210:TOracleDataSet;

    procedure AfterScroll(DataSet: TDataset);
  end;

implementation

{$R *.dfm}

procedure TWA210FRegoleArchiviazioneDocDettFM.GestioneCheckboxArchLocale;
begin
  dchkSostituzioneFile.Enabled:=not dchkSvuotaCartella.Checked;
  if dchkSvuotaCartella.Checked then
    selI210.FieldByName('SOSTITUZIONE_FILE').AsString:='N';
end;

procedure TWA210FRegoleArchiviazioneDocDettFM.dchkSvuotaCartellaAsyncClick(
  Sender: TObject; EventParams: TStringList);
begin
  GestioneCheckboxArchLocale;
end;

procedure TWA210FRegoleArchiviazioneDocDettFM.AfterScroll(DataSet: TDataset);
begin
  lblTipologiaDocumenti.Enabled:=DataSet.FieldByName('TIPO_DOCUMENTO').AsString = 'CAR';
  dcmbTipologiaDocumenti.Enabled:=lblTipologiaDocumenti.Enabled;
end;

end.
