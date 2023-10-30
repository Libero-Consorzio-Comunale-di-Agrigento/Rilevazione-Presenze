unit A109UImmagini;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R004UGESTSTORICO, Grids, DBGrids, ExtCtrls, Menus, DBCtrls, ImgList, Db,
  ComCtrls, ToolWin, StdCtrls, Mask, Buttons, Jpeg,
  A000UCostanti, A000UMessaggi, A000USessione,A000UInterfaccia, A002UInterfacciaSt,
  C001UFiltroTabelle, C001UFiltroTabelleDtM, C001UScegliCampi, C180FunzioniGenerali,
  OracleData, ActnList, SelAnagrafe, Variants, System.Actions, Vcl.ExtDlgs, System.ImageList;

type
  TA109FImmagini = class(TR004FGestStorico)
    ScrollBox1: TScrollBox;
    PopupMenu1: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    OpenPictureDialog: TOpenPictureDialog;
    dgrdElenco: TDBGrid;
    Splitter1: TSplitter;
    dimgImmagine: TDBImage;
    procedure dgrdElencoEditButtonClick(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
    JpegImage: TJpegImage;
    ImageX: TImage;
    procedure TestoStatus;
  public
    { Public declarations }
    procedure CaricaImmagine;
  end;

var
  A109FImmagini: TA109FImmagini;

procedure OpenA109Immagini(Cod:String);

implementation

uses A109UImmaginiDtM;

{$R *.DFM}

procedure OpenA109Immagini(Cod:String);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA109Immagini') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A109FImmagini:=TA109FImmagini.Create(nil);
  with A109FImmagini do
  try
    A109FImmaginiDtM:=TA109FImmaginiDtM.Create(nil);
    A109FImmaginiDtM.selT004.Locate('Codice',Cod,[]);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A109FImmaginiDtM.Free;
    Free;
  end;
end;

procedure TA109FImmagini.DButtonDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  if (A109FImmaginiDtM <> nil) and (A109FImmaginiDtM.selT004 <> nil) then
    TestoStatus;
end;

procedure TA109FImmagini.dgrdElencoEditButtonClick(Sender: TObject);
{ Apre la finestra di dialogo di selezione dell'immagine }
begin
  if DButton.State = dsBrowse then
    exit;
  OpenPictureDialog.Title:='Seleziona immagine';
  if OpenPictureDialog.Execute then
  begin
    try
      if Pos('.BMP',UpperCase(OpenPictureDialog.FileName)) = 0 then
      begin
        R180MessageBox(A000MSG_A109_MSG_IMMAGINE_NON_VALIDA, ESCLAMA);
        Exit;
      end;
      dimgImmagine.Picture.LoadFromFile(OpenPictureDialog.FileName);
      TestoStatus;
    except
      // niente jpg, perché non viene visualizzato correttamente
      R180MessageBox(A000MSG_A109_MSG_IMMAGINE_NON_VALIDA, ESCLAMA);
      TestoStatus;
      Exit;
    end;
  end;
end;

procedure TA109FImmagini.TestoStatus;
{ Imposta il testo della statusbar }
var Picture:TPicture;
begin
  try
    if A109FImmaginiDtM.selT004Immagine.IsNull then
      StatusBar.Panels[4].Text:='Nessuna immagine'
    else
    with TPicture.Create do
    try
      Assign(A109FImmaginiDtM.selT004Immagine);
      if Width + Height > 0 then
        StatusBar.Panels[4].Text:='Risoluzione immagine: ' + IntToStr(Width) + ' x ' + IntToStr(Height)
      else
        StatusBar.Panels[4].Text:='';
    finally
      Free;
    end;
    StatusBar.Repaint;
  except
    StatusBar.Panels[4].Text:='Nessuna immagine';
    StatusBar.Repaint;
  end;
end;

procedure TA109FImmagini.CaricaImmagine;
var AOwner: TComponent;
begin
  ImageX:=TImage.Create(AOwner);

  //provo ad aprire il blob come bitmap, se c'è un errore nel tipo di formato
  //allora provo ad aprirlo come jpeg in un oggetto tJpegImage e se l'apertura
  //riesce allora assegno tale immagine all'oggetto ImageX.

  with A109FImmaginiDtM do
  begin
    if A109FImmaginiDtM.selT004.RecordCount > 0 then
    begin
      try
        if Not selT004.FieldByName('IMMAGINE').IsNull then
        begin
          ImageX.Picture.Assign(selT004IMMAGINE);
          if selT004.State in [dsEdit,dsInsert] then
          begin
            selT004IMMAGINE.Assign(ImageX.Picture.Graphic);
            selT004FMT_BLOB.AsString:='S';
          end;
        end
        else
          ImageX.Picture.Assign(nil);
        TestoStatus;
      except
        try
          JpegImage:=TJpegImage.Create;
          if Not selT004.FieldByName('IMMAGINE').IsNull then
            JpegImage.Assign(A109FImmaginiDtM.selT004IMMAGINE)
          else
            ImageX.Picture.Assign(nil);
          ImageX.Picture.Assign(JpegImage);
          if selT004.State in [dsEdit,dsInsert] then
          begin
            selT004IMMAGINE.Assign(ImageX.Picture.Graphic);
            selT004FMT_BLOB.AsString:='S';
          end;
          TestoStatus;
        finally
          JpegImage.Destroy;
        end;
      end;
    end
    else
      ImageX.Picture.Assign(nil);
  end;
  ImageX.Destroy;

end;

end.
