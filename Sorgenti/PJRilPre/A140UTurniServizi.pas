unit A140UTurniServizi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin, Grids,
  DBGrids, A140UTurniServiziDTM, A000UCostanti, A000USessione, StdCtrls, Mask, DBCtrls, Buttons,
  C010USelezioneDaElenco, OracleData;

type
  TA140FTurniServizi = class(TR001FGestTab)
    ColorDialog: TColorDialog;
    PageControl1: TPageControl;
    tabServizi: TTabSheet;
    tabTipiTurno: TTabSheet;
    dgrdT540: TDBGrid;
    dgrdT545: TDBGrid;
    tabParametriGenerali: TTabSheet;
    Label1: TLabel;
    dedtAlternanzaFest: TDBEdit;
    dedtAlternanzaGGLav: TDBEdit;
    Label2: TLabel;
    dedtGGChiusura: TDBEdit;
    Label3: TLabel;
    btnDataPrimoFestivo: TSpeedButton;
    Label4: TLabel;
    btnDataPrimoFeriale: TSpeedButton;
    Label5: TLabel;
    dedtPrimoGGFest: TDBEdit;
    dedtPrimoGGLav: TDBEdit;
    Label6: TLabel;
    dedtCalendario: TDBLookupComboBox;
    DBText1: TDBText;
    procedure dgrdT540EditButtonClick(Sender: TObject);
    procedure dgrdT540DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure PageControl1Changing(Sender: TObject; var AllowChange: Boolean);
    procedure PageControl1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure CambiaDButton(C:TWinControl; DS:TDataSource);
  public
    { Public declarations }
    procedure NumRecords; 
  end;

var
  A140FTurniServizi: TA140FTurniServizi;

procedure OpenA140TurniServizi;

implementation

{$R *.dfm}

procedure OpenA140TurniServizi;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA140TurniServizi') of
    'N':
    begin
      ShowMessage('Funzione non abilitata!');
      Exit;
    end;
    'R':SolaLettura:=True;
  end;
  A140FTurniServizi:=TA140FTurniServizi.Create(nil);
  with A140FTurniServizi do
    try
      A140FTurniServiziDTM:=TA140FTurniServiziDTM.Create(nil);
      A140FTurniServizi.ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      FreeAndNil(A140FTurniServiziDtm);
      FreeAndNil(A140FTurniServizi);
    end;
end;

procedure TA140FTurniServizi.FormCreate(Sender: TObject);
begin
  inherited;
  pagctrDataSetSingolo:=False;
end;

procedure TA140FTurniServizi.FormShow(Sender: TObject);
begin
  inherited;
  PageControl1.ActivePage:=tabParametriGenerali;
  PageControl1Change(nil);
end;

procedure TA140FTurniServizi.NumRecords;
begin
  inherited;
end;

procedure TA140FTurniServizi.DButtonStateChange(Sender: TObject);
begin
  inherited;
  btnDataPrimoFestivo.Enabled:=DButton.State in [dsInsert,dsEdit];
  btnDataPrimoFeriale.Enabled:=DButton.State in [dsInsert,dsEdit];
end;

procedure TA140FTurniServizi.dgrdT540DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  if ((Column = dgrdT540.Columns[2]) or (Column = dgrdT540.Columns[3])) then
  begin
    try
      dgrdT540.Canvas.Brush.Color:=StringToColor(A140FTurniServiziDTM.selT540.FieldByName('COLORE').AsString);
    except
      dgrdT540.Canvas.Brush.Color:=clWhite;
    end;
    try
      dgrdT540.Canvas.Font.Color:=StringToColor(A140FTurniServiziDTM.selT540.FieldByName('COLOREFONT').AsString);
    except
      dgrdT540.Canvas.Font.Color:=clBlack;
    end;
    dgrdT540.Canvas.FillRect(Rect);
    dgrdT540.Canvas.TextRect(Rect,Rect.Left,Rect.Top,Column.Field.AsString);
  end;
end;

procedure TA140FTurniServizi.dgrdT540EditButtonClick(Sender: TObject);
begin
  inherited;
  if DButton.State = dsBrowse then
    exit;
  if dgrdT540.SelectedField = A140FTurniServiziDTM.selT540COLORE then
    if ColorDialog.Execute then
      A140FTurniServiziDTM.selT540.FieldByName('COLORE').AsString:=ColorToString(ColorDialog.Color);
  if dgrdT540.SelectedField = A140FTurniServiziDTM.selT540COLOREFONT then
    if ColorDialog.Execute then
      A140FTurniServiziDTM.selT540.FieldByName('COLOREFONT').AsString:=ColorToString(ColorDialog.Color);
  if (dgrdT540.SelectedField = A140FTurniServiziDTM.selT540PADRE) and Not(A140FTurniServiziDTM.selT540PADRE.ReadOnly) then
  begin
    C010FSelezioneDaElenco:=TC010FSelezioneDaElenco.Create(nil);
    A140FTurniServiziDTM.selT540SelPadre.Open;
    try
      C010FSelezioneDaElenco.Caption:='Elenco codici rimborsi';
      C010FSelezioneDaElenco.ODS:=A140FTurniServiziDTM.selT540SelPadre;
      C010FSelezioneDaElenco.DselDati.DataSet:=C010FSelezioneDaElenco.ODS;
      C010FSelezioneDaElenco.ODS.First;
      C010FSelezioneDaElenco.ODS.SearchRecord('CODICE',A140FTurniServiziDTM.selT540.FieldByName('PADRE').AsString,[srFromBeginning]);
      if (C010FSelezioneDaElenco.ShowModal = mrOK) and (A140FTurniServiziDTM.selT540.State in [dsInsert,dsEdit]) then
        A140FTurniServiziDTM.selT540.FieldByName('PADRE').AsString:=A140FTurniServiziDTM.selT540SelPadre.FieldByName('CODICE').AsString;
    finally
      FreeAndNil(C010FSelezioneDaElenco);
    end;
    A140FTurniServiziDTM.selT540SelPadre.Close;
  end;
end;

procedure TA140FTurniServizi.CambiaDButton(C:TWinControl; DS:TDataSource);
var i:Integer;
begin
  for i:=0 to C.ControlCount - 1 do
  begin
    if C.Controls[i] is TDBEdit then
      (C.Controls[i] as TDBEdit).DataSource:=DS
    else if C.Controls[i] is TDBLookupComboBox then
      (C.Controls[i] as TDBLookupComboBox).DataSource:=DS
    else if C.Controls[i] is TDBText then
      (C.Controls[i] as TDBText).DataSource:=DS
    else if C.Controls[i] is TDBGrid then
      (C.Controls[i] as TDBGrid).DataSource:=DS;
  end;
end;

procedure TA140FTurniServizi.PageControl1Change(Sender: TObject);
begin
  inherited;
  if PageControl1.ActivePage = tabParametriGenerali then
  begin
    //dgrdT540.DataSource:=nil;
    //dgrdT545.DataSource:=nil;
    CambiaDButton(tabServizi,nil);
    CambiaDButton(tabTipiTurno,nil);
    //DButton.DataSet:=A140FTurniServiziDtM.selT530;
    A140FTurniServiziDtM.CambiaInizializzaDataSet(A140FTurniServiziDtM.selT530);
    CambiaDButton(tabParametriGenerali,DButton);
  end
  else if PageControl1.ActivePage = tabServizi then
  begin
    //A140FTurniServiziDtM.selT530.DisableControls;
    //dgrdT545.DataSource:=nil;
    CambiaDButton(tabParametriGenerali,nil);
    CambiaDButton(tabTipiTurno,nil);
    //DButton.DataSet:=A140FTurniServiziDtM.selT540;
    A140FTurniServiziDtM.CambiaInizializzaDataSet(A140FTurniServiziDtM.selT540);
    CambiaDButton(tabServizi,DButton);
  end
  else if PageControl1.ActivePage = tabTipiTurno then
  begin
    //A140FTurniServiziDtM.selT530.DisableControls;
    //dgrdT540.DataSource:=nil;
    CambiaDButton(tabParametriGenerali,nil);
    CambiaDButton(tabServizi,nil);
    //DButton.DataSet:=A140FTurniServiziDtM.selT545;
    A140FTurniServiziDtM.CambiaInizializzaDataSet(A140FTurniServiziDtM.selT545);
    CambiaDButton(tabTipiTurno,DButton);
  end;
  NumRecords;
end;

procedure TA140FTurniServizi.PageControl1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
  inherited;
  AllowChange:=DButton.State = dsBrowse;
end;

end.
