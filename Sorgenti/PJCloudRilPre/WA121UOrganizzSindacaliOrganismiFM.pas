unit WA121UOrganizzSindacaliOrganismiFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR203UGestDetailFM, System.Actions,
  Vcl.ActnList, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompGrids, meIWGrid, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, Vcl.Menus, Math, StrUtils,
  meIWLabel, meIWComboBox, medpIWMultiColumnComboBox, C190FunzioniGeneraliWeb,
  IWCompListbox, Data.DB;

type
  TWA121FOrganizzSindacaliOrganismiFM = class(TWR203FGestDetailFM)
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure grdTabellaComponenti2DataSet(Row: Integer);
  private
    procedure SelT245FruizionePermessiAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure AbilitaComponentiOrg(Row: Integer);
  public
    procedure InizializzaComponenti;
  end;

implementation

uses WA121UOrganizzSindacali, WA121UOrganizzSindacaliDM;

{$R *.dfm}

procedure TWA121FOrganizzSindacaliOrganismiFM.InizializzaComponenti;
begin
  inherited;
  grdTabella.RigaInserimento:=True;
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('D_FRUIZIONE_PERMESSI'),0,DBG_CMB,'2','2','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('D_PARTECIPAZIONE_RICHIESTA'),0,DBG_CMB,'2','2','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('D_RETRIBUITO'),0,DBG_CMB,'2','2','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('D_STATUTARIO'),0,DBG_CMB,'2','2','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('D_ABBATTE_COMPETENZE_ORG'),0,DBG_LBL,'2','1','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('CAUSALE'),0,DBG_MECMB,'5','2','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('D_CAUSALE'),0,DBG_LBL,'40','1','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('SIGLA_GEDAP'),0,DBG_LBL,'3','1','','','S');
end;

procedure TWA121FOrganizzSindacaliOrganismiFM.grdTabellaDataSet2Componenti(Row: Integer);
begin
  inherited;
  with grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_FRUIZIONE_PERMESSI'),0) as TmeIWComboBox do
  begin
    Items.Clear;
    Items.Add('Si');
    Items.Add('No');
    if grdTabella.medpDataSet.State in [dsInsert] then
      ItemIndex:=IfThen(grdTabella.medpDataSet.FieldByName('FRUIZIONE_PERMESSI').AsString = 'S',0,1)
    else
      ItemIndex:=IfThen(grdTabella.medpValoreColonna(Row,'FRUIZIONE_PERMESSI') = 'S',0,1);
    OnAsyncChange:=SelT245FruizionePermessiAsyncChange;
  end;
  with grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_PARTECIPAZIONE_RICHIESTA'),0) as TmeIWComboBox do
  begin
    Items.Clear;
    Items.Add('Si');
    Items.Add('No');
    if grdTabella.medpDataSet.State in [dsInsert] then
      ItemIndex:=IfThen(grdTabella.medpDataSet.FieldByName('PARTECIPAZIONE_RICHIESTA').AsString = 'S',0,1)
    else
      ItemIndex:=IfThen(grdTabella.medpValoreColonna(Row,'PARTECIPAZIONE_RICHIESTA') = 'S',0,1);
    OnAsyncChange:=SelT245FruizionePermessiAsyncChange;
  end;
  with grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_RETRIBUITO'),0) as TmeIWComboBox do
  begin
    Items.Clear;
    Items.Add('Si');
    Items.Add('No');
    if grdTabella.medpDataSet.State in [dsInsert] then
      ItemIndex:=IfThen(grdTabella.medpDataSet.FieldByName('RETRIBUITO').AsString = 'S',0,1)
    else
      ItemIndex:=IfThen(grdTabella.medpValoreColonna(Row,'RETRIBUITO') = 'S',0,1);
    OnAsyncChange:=SelT245FruizionePermessiAsyncChange;
  end;
  with grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_STATUTARIO'),0) as TmeIWComboBox do
  begin
    Items.Clear;
    Items.Add('Si');
    Items.Add('No');
    if grdTabella.medpDataSet.State in [dsInsert] then
      ItemIndex:=IfThen(grdTabella.medpDataSet.FieldByName('STATUTARIO').AsString = 'S',0,1)
    else
      ItemIndex:=IfThen(grdTabella.medpValoreColonna(Row,'STATUTARIO') = 'S',0,1);
    OnAsyncChange:=SelT245FruizionePermessiAsyncChange;
  end;
  //Causale
  with (WR302DM as TWA121FOrganizzSindacaliDM).A121MW.selT265 do
  begin
    First;
    while not Eof do
    begin
      (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CAUSALE'),0) as TmedpIWMultiColumnComboBox).AddRow(Format('%s;%s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
      Next;
    end;
    First;
    (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CAUSALE'),0) as TmedpIWMultiColumnComboBox).NonEditableAsLabel:=True;
    (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CAUSALE'),0) as TmedpIWMultiColumnComboBox).Text:=grdTabella.medpValoreColonna(Row, 'CAUSALE');
  end;
  AbilitaComponentiOrg(Row);
end;

procedure TWA121FOrganizzSindacaliOrganismiFM.grdTabellaComponenti2DataSet(Row: Integer);
begin
  inherited;
  with (WR302DM as TWA121FOrganizzSindacaliDM).A121MW.selT245 do
  begin
    FieldByName('FRUIZIONE_PERMESSI').AsString:=IfThen((grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_FRUIZIONE_PERMESSI'),0) as TmeIWComboBox).ItemIndex = 0,'S','N');
    FieldByName('PARTECIPAZIONE_RICHIESTA').AsString:=IfThen((grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_PARTECIPAZIONE_RICHIESTA'),0) as TmeIWComboBox).ItemIndex = 0,'S','N');
    FieldByName('RETRIBUITO').AsString:=IfThen((grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_RETRIBUITO'),0) as TmeIWComboBox).ItemIndex = 0,'S','N');
    FieldByName('STATUTARIO').AsString:=IfThen((grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_STATUTARIO'),0) as TmeIWComboBox).ItemIndex = 0,'S','N');
    FieldByName('CAUSALE').AsString:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CAUSALE'),0) as TmedpIWMultiColumnComboBox).Text;
  end;
end;

procedure TWA121FOrganizzSindacaliOrganismiFM.SelT245FruizionePermessiAsyncChange(Sender: TObject; EventParams: TStringList);
var iRow:Integer;
begin
  iRow:=grdTabella.medpRigaDiCompGriglia((Sender as TmeIWComboBox).FriendlyName);
  with (WR302DM as TWA121FOrganizzSindacaliDM).A121MW.selT245 do
  begin
    FieldByName('FRUIZIONE_PERMESSI').AsString:=IfThen((grdTabella.medpCompCella(iRow,grdTabella.medpIndexColonna('D_FRUIZIONE_PERMESSI'),0) as TmeIWComboBox).ItemIndex = 0,'S','N');
    FieldByName('PARTECIPAZIONE_RICHIESTA').AsString:=IfThen((grdTabella.medpCompCella(iRow,grdTabella.medpIndexColonna('D_PARTECIPAZIONE_RICHIESTA'),0) as TmeIWComboBox).ItemIndex = 0,'S','N');
    FieldByName('RETRIBUITO').AsString:=IfThen((grdTabella.medpCompCella(iRow,grdTabella.medpIndexColonna('D_RETRIBUITO'),0) as TmeIWComboBox).ItemIndex = 0,'S','N');
    FieldByName('STATUTARIO').AsString:=IfThen((grdTabella.medpCompCella(iRow,grdTabella.medpIndexColonna('D_STATUTARIO'),0) as TmeIWComboBox).ItemIndex = 0,'S','N');
  end;
  AbilitaComponentiOrg(iRow);
  (grdTabella.medpCompCella(iRow,grdTabella.medpIndexColonna('D_ABBATTE_COMPETENZE_ORG'),0) as TmeIWLabel).Text:=(WR302DM as TWA121FOrganizzSindacaliDM).A121MW.selT245.FieldByName('D_ABBATTE_COMPETENZE_ORG').AsString;
  (grdTabella.medpCompCella(iRow,grdTabella.medpIndexColonna('SIGLA_GEDAP'),0) as TmeIWLabel).Text:=(WR302DM as TWA121FOrganizzSindacaliDM).A121MW.selT245.FieldByName('SIGLA_GEDAP').AsString;
end;

procedure TWA121FOrganizzSindacaliOrganismiFM.AbilitaComponentiOrg(Row: Integer);
var bFruizionePermessi:Boolean;
begin
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_CAUSALE'),0) as TmeIWLabel).Text:='';
  bFruizionePermessi:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_FRUIZIONE_PERMESSI'),0) as TmeIWComboBox).ItemIndex = 0;
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CAUSALE'),0) as TmedpIWMultiColumnComboBox).Enabled:=bFruizionePermessi;
  if not bFruizionePermessi then
  begin
    (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_PARTECIPAZIONE_RICHIESTA'),0) as TmeIWComboBox).ItemIndex:=1;
    (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_RETRIBUITO'),0) as TmeIWComboBox).ItemIndex:=0;
    (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_STATUTARIO'),0) as TmeIWComboBox).ItemIndex:=1;
    (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CAUSALE'),0) as TmedpIWMultiColumnComboBox).Text:='';
  end;
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_PARTECIPAZIONE_RICHIESTA'),0) as TmeIWComboBox).Editable:=bFruizionePermessi;
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_RETRIBUITO'),0) as TmeIWComboBox).Editable:=bFruizionePermessi and not ((grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_STATUTARIO'),0) as TmeIWComboBox).ItemIndex = 0);
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_STATUTARIO'),0) as TmeIWComboBox).Editable:=bFruizionePermessi and ((grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_RETRIBUITO'),0) as TmeIWComboBox).ItemIndex = 0);
end;

end.
