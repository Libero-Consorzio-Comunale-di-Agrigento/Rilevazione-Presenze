unit WA146UFotoDipendenteDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompExtCtrls, meIWImage, IWCompEdit, meIWEdit,
  meIWRadioGroup, IWCompLabel, meIWLabel, IWDBStdCtrls, meIWDBEdit,
  IWCompButton, meIWButton, WA146UFotoDipendente, WA146UFotoDipendenteDM, A000UMessaggi, JPeg,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWApplication, IWGlobal, A000UInterfaccia;

type
  TWA146FFotoDipendenteDettFM = class(TWR205FDettTabellaFM)
    rgpRisorsa: TmeIWRadioGroup;
    edtPercorso: TmeIWDBEdit;
    Image1: TmeIWImage;
    lblDimensione: TmeIWLabel;

    procedure IWFrameRegionCreate(Sender: TObject);
    procedure OnFileUploadDialogResult(FileDialog: TObject;Conferma: Boolean;NomeFile: String);
    procedure rgpRisorsaClick(Sender: TObject);
  private

  public
    procedure SetRadioGroup;
    procedure CaricaImmagine;
    procedure AggiornaDimensione;
    procedure ScaricaDaDB(nomeFile: String);
  end;

implementation

{$R *.dfm}

procedure TWA146FFotoDipendenteDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  edtPercorso.DataSource:=WR302DM.dsrTabella;
  SetRadioGroup;
  CaricaImmagine;
end;

procedure TWA146FFotoDipendenteDettFM.SetRadioGroup;
begin
  with WR302DM do
    if (selTabella.Active) and (selTabella.RecordCount > 0) then
    begin
      if Not selTabella.FieldByName('FOTO').IsNull then
        rgpRisorsa.ItemIndex:=0
      else
        rgpRisorsa.ItemIndex:=1;
    end
    else
      rgpRisorsa.ItemIndex:=1;
end;

procedure TWA146FFotoDipendenteDettFM.rgpRisorsaClick(Sender: TObject);
begin
  inherited;
  (Owner as TWA146FFotoDipendente).actApri.Enabled:=rgpRisorsa.Enabled and (rgpRisorsa.ItemIndex = 0);
  edtPercorso.Enabled:=rgpRisorsa.Enabled and (rgpRisorsa.ItemIndex = 1);
  CaricaImmagine;
  AggiornaDimensione;
  (Owner as TWA146FFotoDipendente).actApri.Enabled:=rgpRisorsa.ItemIndex=0;
  (Owner as TWA146FFotoDipendente).AggiornaToolBar((Owner as TWA146FFotoDipendente).grdNavigatorBar,(Owner as TWA146FFotoDipendente).actlstNavigatorBar);
end;

procedure TWA146FFotoDipendenteDettFM.AggiornaDimensione;
begin
  if Image1.Picture.Width + Image1.Picture.Height > 0 then
    lblDimensione.Text:='Dimensione foto (pixel): ' + IntToStr(Image1.Picture.Width) + 'x' + IntToStr(Image1.Picture.Height)
  else
    lblDimensione.Text:='';
end;

procedure TWA146FFotoDipendenteDettFM.OnFileUploadDialogResult(FileDialog: TObject;Conferma: Boolean;NomeFile: String);
begin
  try
    if Conferma then
    begin
      Image1.Picture.LoadFromFile(NomeFile);
      (WR302DM as TWA146FFotoDipendenteDM).selTabellaPROGRESSIVO.AsInteger:=(Owner as TWA146FFotoDipendente).grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
      (WR302DM as TWA146FFotoDipendenteDM).selTabellaFILE_FOTO.Clear;
      (WR302DM as TWA146FFotoDipendenteDM).selTabellaFOTO.Assign(Image1.Picture.Graphic);
      AggiornaDimensione;
    end;
  except
    on E:Exception do
      raise Exception.Create(Format(A000MSG_ERR_FMT_ERRORE,['upload fallito']));
  end;
end;

procedure TWA146FFotoDipendenteDettFM.ScaricaDaDB(nomeFile: String);
var stream: TMemoryStream;
    estensione: String;
begin
  stream:=TMemoryStream.Create;

  if Image1.Picture.graphic is TJPEGimage then
  begin
    estensione:='jpg';
  end
  else
  begin
    estensione:='bmp';
  end;

  Image1.Picture.SaveToStream(stream);
  if stream.Size <> 0 then
    GGetWebApplicationThreadVar.SendStream(stream, True,'application/x-download', nomeFile + '.' + estensione)
  else
    FreeAndNil(stream);
  TA000FInterfaccia(gSC).SegnaSessioneAttiva;
end;

procedure TWA146FFotoDipendenteDettFM.CaricaImmagine;
var JpegImage: TJpegImage;
begin
  with (WR302DM as TWA146FFotoDipendenteDM) do
  begin
    if selTabella.RecordCount > 0 then
    begin
        if (rgpRisorsa.ItemIndex = 0) and (Not selTabella.FieldByName('FOTO').IsNull) then
        begin
          Image1.Picture.Assign(selTabellaFOTO);
        end
        else if (rgpRisorsa.ItemIndex = 1) and (Not selTabella.FieldByName('FILE_FOTO').IsNull) then
        begin
          Image1.Picture.LoadFromFile(selTabellaFILE_FOTO.AsString);
          edtPercorso.Text:=selTabellaFILE_FOTO.AsString;
        end
        else
          Image1.Picture.Assign(nil);

        AggiornaDimensione;
    end
    else
      Image1.Picture.Assign(nil);
  end;
end;

end.
