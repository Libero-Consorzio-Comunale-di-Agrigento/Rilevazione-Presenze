unit WA154UGestioneDocumentaleBrowseFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR204UBrowseTabellaFM, Vcl.Menus,
  IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent, System.Math,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompGrids,
  IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion;

type
  TWA154FGestioneDocumentaleBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure grdTabellaRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  LIMITE_CARATTERI_NOTE   = 100;  // limite di caratteri per le note da visualizzare in tabella
  LIMITE_RIGHE_NOTE       = 4;    // limite di ritorni a capo per le note da visualizzare in tabella

implementation

{$R *.dfm}

procedure TWA154FGestioneDocumentaleBrowseFM.grdTabellaRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
  Campo: String;
begin
  inherited;

  NumColonna:=grdTabella.medpNumColonna(AColumn);
  Campo:=grdTabella.medpColonna(NumColonna).DataField;

  if ARow > IfThen(grdTabella.medpRigaInserimento,1,0) then
  begin
    if Campo = 'NOTE' then
    begin
      // se il testo supera certe soglie (lunghezza o ritorni a capo)
      // lo riduce inserendo dei puntini di sospensione
      // per evitare che la riga ecceda un'altezza accettabile
      if Length(ACell.Text) > LIMITE_CARATTERI_NOTE then
        ACell.Text:=Format('%s...',[Copy(ACell.Text,1,LIMITE_CARATTERI_NOTE)]);
      if ACell.RawText then
        ACell.Text:=Format('<div style="overflow-y: hidden; text-overflow: ellipsis; max-height: %dem;">%s</div>',[LIMITE_RIGHE_NOTE,ACell.Text]);
    end;
  end;
end;

end.
