unit WA202URapportiLavoroBrowseFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR204UBrowseTabellaFM, Vcl.Menus, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompGrids, IWDBGrids, IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  C190FunzioniGeneraliWeb, meIWMemo, medpIWDBGrid, medpIWMultiColumnComboBox, meIWLabel,
  medpIWMessageDlg, C180FunzioniGenerali, A000UMessaggi, A000UInterfaccia, IWCompButton, IWCompLabel;

type
  TWA202FRapportiLavoroBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
  private
    { Private declarations }
    procedure CaricaComboTipoRapporto(cmb:TMedpIWMultiColumnComboBox);
    procedure cmbRapportoGrdAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
  public
    { Public declarations }
    AggiornaDetailsPA: procedure of object;
  end;

implementation

uses WA202URapportiLavoroDM;

{$R *.dfm}

procedure TWA202FRapportiLavoroBrowseFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('NOTE'),0,DBG_MEMO,'30','','null','','S');

  //Combo Codice + Descrizione TipoRapporto
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('TIPORAPPORTO'),0,DBG_MECMB,'10','2','null','','S');
  //Descrizione del TipoRapporto
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('D_TIPORAPPORTO'),0,DBG_LBL,'30','','null','','S');
  //TipoRapporto decodificata (Ruolo, Supplente, Incaricato...)
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('D_TIPO'),0,DBG_LBL,'30','','null','','S');
end;

procedure TWA202FRapportiLavoroBrowseFM.CaricaComboTipoRapporto(cmb:TMedpIWMultiColumnComboBox);
begin
  //Carico cmbTipoRapporto
  with TWA202FRapportiLavoroDM(WR302DM).A202MW.selT450 do
  begin
    First;
    while not Eof do
    begin
      cmb.AddRow(FieldByName('CODICE').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
  end;
end;

procedure TWA202FRapportiLavoroBrowseFM.cmbRapportoGrdAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
var
  Row: Integer;
begin
  Row:=(Sender as TmedpIWMultiColumnComboBox).Tag;

  //Combo Codice + Descrizione TipoRapporto
  grdTabella.medpDataSet.FieldByName('TIPORAPPORTO').AsString:=(Sender as TmedpIWMultiColumnComboBox).Text;

  //Descrizione del TipoRapporto
  TmeIWLabel(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_TIPORAPPORTO'),0)).Caption:=grdTabella.medpDataSet.FieldByName('D_TIPORAPPORTO').AsString;

  //TipoRapporto decodificata (Ruolo, Supplente, Incaricato...)
  TmeIWLabel(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_TIPO'),0)).Caption:=grdTabella.medpDataSet.FieldByName('D_TIPO').AsString;
end;

procedure TWA202FRapportiLavoroBrowseFM.grdTabellaDataSet2Componenti(Row: Integer);
begin
  inherited;
  with WR302DM.selTabella do
  begin
    CaricaComboTipoRapporto(TMedpIWMultiColumnComboBox(grdTabella.medpCompCella(Row, grdTabella.medpIndexColonna('TIPORAPPORTO'),0)));
    with TMedpIWMultiColumnComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TIPORAPPORTO'),0)) do
    begin
      Tag:=Row; //uso il campo Tag per recuperare la row nel cmbRapportoGrdAsyncChange
      OnAsyncChange:=cmbRapportoGrdAsyncChange; //Associo l'evento alla combo
    end;
  end;
end;

end.
