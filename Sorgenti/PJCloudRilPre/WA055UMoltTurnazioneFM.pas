unit WA055UMoltTurnazioneFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, StrUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR203UGestDetailFM, System.Actions,
  Vcl.ActnList, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, OracleData, DB,
  IWCompGrids, meIWGrid, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, C190FunzioniGeneraliWeb,
  medpIWMultiColumnComboBox, meIWLabel, medpIWMessageDlg, meIWImageFile,
  meIWEdit, Vcl.Menus;

type
  TWA055FMoltTurnazioneFM = class(TWR203FGestDetailFM)
    procedure grdTabellaComponenti2DataSet(Row: Integer);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure actConfermaExecute(Sender: TObject);Override;
  private
    procedure PreparaComponenti;
    procedure ResultDelete(Sender: TObject; R: TmeIWModalResult; KI: String);Override;
    procedure CaricaDettaglio(DataSet: TDataSet; DataSource: TDataSource);override;
    procedure imgCicliClick(Sender: TObject);
  public
    { Public declarations }
  end;

implementation

uses WA055UTurnazioniDM, WA055UTurnazioni;

{$R *.dfm}

procedure TWA055FMoltTurnazioneFM.actConfermaExecute(Sender: TObject);
begin
  inherited;
  (WR302DM as TWA055FTurnazioniDM).RiordinaGiorni;
  grdTabella.medpAggiornaCDS(True);
end;

procedure TWA055FMoltTurnazioneFM.ResultDelete(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  inherited;
  if R = mrYes then
  begin
    (WR302DM as TWA055FTurnazioniDM).RiordinaGiorni;
    grdTabella.medpAggiornaCDS(True);
  end;
end;

procedure TWA055FMoltTurnazioneFM.CaricaDettaglio(DataSet: TDataSet; DataSource: TDataSource);
begin
  grdTabella.medpEditMultiplo:=False;
  inherited;
  PreparaComponenti;
end;

procedure TWA055FMoltTurnazioneFM.grdTabellaComponenti2DataSet(Row: Integer);
begin
  inherited;
  with (WR302DM as TWA055FTurnazioniDM).A055MW.Q641 do
  begin
    FieldByName('CICLO1').AsString:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CICLO1'),0) as TmedpIWMultiColumnComboBox).Text;
    FieldByName('CICLO2').AsString:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CICLO2'),0) as TmedpIWMultiColumnComboBox).Text;
    FieldByName('CICLO3').AsString:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CICLO3'),0) as TmedpIWMultiColumnComboBox).Text;
    FieldByName('CICLO4').AsString:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CICLO4'),0) as TmedpIWMultiColumnComboBox).Text;
    FieldByName('CICLO5').AsString:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CICLO5'),0) as TmedpIWMultiColumnComboBox).Text;
    //FieldByName('ORDINE').AsString:=IfThen((State = dsInsert),IntToStr((WR302DM as TWA055FTurnazioniDM).MaxOrdineTurno+1),FieldByName('ORDINE').AsString);
    FieldByName('ORDINE').AsString:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('ORDINE'),0) as TmeIWEdit).Text;
  end;
end;

procedure TWA055FMoltTurnazioneFM.grdTabellaDataSet2Componenti(Row: Integer);
var i:Integer;
begin
  inherited;
  // Carico combo
  for i := 1 to 5 do
    with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CICLO'+IntToStr(i)),0) as TmedpIWMultiColumnComboBox) do
    begin
      Tag:=Row;
      items.Clear;
      if (Trim(Text) = '') or ((WR302DM as TWA055FTurnazioniDM).A055MW.Q641.FieldByName('CICLO'+IntToStr(i)).AsString <> Trim(Text))  then
        Text:=IfThen(((WR302DM as TWA055FTurnazioniDM).A055MW.Q641.FieldByName('CICLO'+IntToStr(i)).AsString <>''),(WR302DM as TWA055FTurnazioniDM).A055MW.Q641.FieldByName('CICLO'+IntToStr(i)).AsString,'');
    end;
  with (WR302DM as TWA055FTurnazioniDM).A055MW do
  begin
    if not(Q641.State in [dsInsert]) then
      (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('ORDINE'),0) as TmeIWEdit).Enabled:=False;
    Q610.First;
    while not Q610.Eof do
    begin
      (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CICLO1'),0) as TmedpIWMultiColumnComboBox).AddRow(Q610.FieldByName('CODICE').AsString + ';' + Q610.FieldByName('DESCRIZIONE').AsString);
      (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CICLO2'),0) as TmedpIWMultiColumnComboBox).AddRow(Q610.FieldByName('CODICE').AsString + ';' + Q610.FieldByName('DESCRIZIONE').AsString);
      (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CICLO3'),0) as TmedpIWMultiColumnComboBox).AddRow(Q610.FieldByName('CODICE').AsString + ';' + Q610.FieldByName('DESCRIZIONE').AsString);
      (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CICLO4'),0) as TmedpIWMultiColumnComboBox).AddRow(Q610.FieldByName('CODICE').AsString + ';' + Q610.FieldByName('DESCRIZIONE').AsString);
      (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CICLO5'),0) as TmedpIWMultiColumnComboBox).AddRow(Q610.FieldByName('CODICE').AsString + ';' + Q610.FieldByName('DESCRIZIONE').AsString);
      Q610.Next;
    end;
  end;
  //Creo img accedi ai cicli 1
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CICLO1'),1) as TmeIWImageFile) do
  begin
    Tag:=grdTabella.medpIndexColonna('CICLO1');
    Hint:='Accedi ai Cicli';
    OnClick:=imgCicliClick;
  end;
  //Creo img accedi ai cicli 2
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CICLO2'),1) as TmeIWImageFile) do
  begin
    Tag:=grdTabella.medpIndexColonna('CICLO2');
    Hint:='Accedi ai Cicli';
    OnClick:=imgCicliClick;
  end;
  //Creo img accedi ai cicli 3
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CICLO3'),1) as TmeIWImageFile) do
  begin
    Tag:=grdTabella.medpIndexColonna('CICLO3');
    Hint:='Accedi ai Cicli';
    OnClick:=imgCicliClick;
  end;
  //Creo img accedi ai cicli 4
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CICLO4'),1) as TmeIWImageFile) do
  begin
    Tag:=grdTabella.medpIndexColonna('CICLO4');
    Hint:='Accedi ai Cicli';
    OnClick:=imgCicliClick;
  end;
  //Creo img accedi ai cicli 5
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CICLO5'),1) as TmeIWImageFile) do
  begin
    Tag:=grdTabella.medpIndexColonna('CICLO5');
    Hint:='Accedi ai Cicli';
    OnClick:=imgCicliClick;
  end;
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('ORDINE'),1) as TmeIWEdit).Css:=
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('ORDINE'),1) as TmeIWEdit).Css + ' input_num_nn';
end;

procedure TWA055FMoltTurnazioneFM.imgCicliClick(Sender: TObject);
var r: Integer;
begin
  r:=grdTabella.medpRigaDiCompGriglia((Sender as TmeIWImageFile).FriendlyName);
  (Self.Owner as TWA055FTurnazioni).AccediForm(126,'CODICE='+ (grdTabella.medpCompCella(r,(Sender as TmeIWImageFile).Tag,0) as TmedpIWMultiColumnComboBox).Text);
end;

procedure TWA055FMoltTurnazioneFM.PreparaComponenti;
begin
  grdTabella.medpPreparaComponentiDefault;
  with (WR302DM as TWA055FTurnazioniDM).A055MW.Q641 do
  begin
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('CICLO1'),0,DBG_MECMB,'10','2','null','','S');
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('CICLO2'),0,DBG_MECMB,'10','2','null','','S');
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('CICLO3'),0,DBG_MECMB,'10','2','null','','S');
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('CICLO4'),0,DBG_MECMB,'10','2','null','','S');
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('CICLO5'),0,DBG_MECMB,'10','2','null','','S');
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('CICLO1'),1,DBG_IMG,'','ACCEDI','','','');
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('CICLO2'),1,DBG_IMG,'','ACCEDI','','','');
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('CICLO3'),1,DBG_IMG,'','ACCEDI','','','');
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('CICLO4'),1,DBG_IMG,'','ACCEDI','','','');
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('CICLO5'),1,DBG_IMG,'','ACCEDI','','','');
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('ORDINE'),0,DBG_EDT,'10','','null','','S');
  end;
end;


end.
