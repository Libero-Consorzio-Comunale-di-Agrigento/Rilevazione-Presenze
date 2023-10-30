unit WA054UCicliGiornalieriFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, StrUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR203UGestDetailFM, System.Actions, OracleData, DB,
  Vcl.ActnList, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompGrids, meIWGrid, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, meIWLabel,
  IWControl, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer, meIWEdit,
  IWHTMLContainer, IWHTML40Container, IWRegion, meIWImageFile, medpIWMultiColumnComboBox, meIWComboBox,
  C190FunzioniGeneraliWeb, IWCompEdit, medpIWMessageDlg, Vcl.Menus;

type
  TWA054FCicliGiornalieriFM = class(TWR203FGestDetailFM)
    procedure grdTabellaComponenti2DataSet(Row: Integer);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure actConfermaExecute(Sender: TObject);Override;
  private
    procedure PreparaComponenti;
    procedure imgCausAssenzeClick(Sender: TObject);
    procedure imgModelliOrarioClick(Sender: TObject);
    procedure cmbOrarioChange(Sender: TObject; Index: Integer);
    procedure cmbCausaleChange(Sender: TObject; Index: Integer);
    procedure cmbTurno1Change(Sender: TObject; Index: Integer);
    procedure cmbTurno2Change(Sender: TObject; Index: Integer);
    procedure ResultDelete(Sender: TObject; R: TmeIWModalResult; KI: String);Override;
    procedure CaricaDettaglio(DataSet:TDataSet;DataSource:TDataSource); override;
    procedure SalvaTurniEU(Row: Integer);
  public
    { Public declarations }
  end;

implementation

uses WA054UCicliTurniDM,WA054UCicliTurni, A000UInterfaccia;

{$R *.dfm}

procedure TWA054FCicliGiornalieriFM.actConfermaExecute(Sender: TObject);
begin
  inherited;
  (WR302DM as TWA054FCicliTurniDM).RiordinaGiorni;
  grdTabella.medpAggiornaCDS(True);
end;

procedure TWA054FCicliGiornalieriFM.ResultDelete(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  inherited;
  if R = mrYes then
  begin
    (WR302DM as TWA054FCicliTurniDM).RiordinaGiorni;
    grdTabella.medpAggiornaCDS(True);
  end;
end;

procedure TWA054FCicliGiornalieriFM.CaricaDettaglio(DataSet: TDataSet; DataSource: TDataSource);
begin
  grdTabella.medpEditMultiplo:=False;
  inherited;
  PreparaComponenti;
end;

procedure TWA054FCicliGiornalieriFM.PreparaComponenti;
begin 
  grdTabella.medpPreparaComponentiDefault;
  with (WR302DM as TWA054FCicliTurniDM).A054MW.Q611 do
  begin
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('giorno'),0,DBG_EDT,'2','','null','','S');
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('numturno1'),0,DBG_LBL,'10','','null','','S');
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('siglaturno1'),0,DBG_LBL,'10','','null','','S');
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('entrata1'),0,DBG_LBL,'10','','null','','S');
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('uscita1'),0,DBG_LBL,'10','','null','','S');
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('numturno2'),0,DBG_LBL,'10','','null','','S');
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('siglaturno2'),0,DBG_LBL,'10','','null','','S');
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('entrata2'),0,DBG_LBL,'10','','null','','S');
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('uscita2'),0,DBG_LBL,'10','','null','','S');

    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('ORARIO'),0,DBG_MECMB,'10','2','null','','S');
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('CAUSALE'),0,DBG_MECMB,'10','2','null','','S');
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('TURNO1'),0,DBG_MECMB,'10','2','null','','S');

    if not FieldByName('TURNO2').ReadOnly then
    begin
      grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('TURNO2'),0,DBG_MECMB,'10','2','null','','S');
      grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('TURNO2EU'),0,DBG_CMB,'10','','','','S');
    end;
    if not FieldByName('TURNO1EU').ReadOnly then
      grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('TURNO1EU'),0,DBG_CMB,'10','','','','S');
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('ORARIO'),1,DBG_IMG,'','ACCEDI','','','');
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('CAUSALE'),1,DBG_IMG,'','ACCEDI','','','');
  end;
end;

procedure TWA054FCicliGiornalieriFM.grdTabellaComponenti2DataSet(Row: Integer);
begin
  inherited;
  with (WR302DM as TWA054FCicliTurniDM).A054MW.Q611 do
  begin
    FieldByName('TURNO1').AsString:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO1'),0) as TmedpIWMultiColumnComboBox).Text;
    FieldByName('CAUSALE').AsString:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CAUSALE'),0) as TmedpIWMultiColumnComboBox).Text;
    if grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('ORARIO'),0) is TmedpIWMultiColumnComboBox then
      FieldByName('ORARIO').AsString:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('ORARIO'),0) as TmedpIWMultiColumnComboBox).Text;
    if grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO2'),0) is TmedpIWMultiColumnComboBox then
      FieldByName('TURNO2').AsString:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO2'),0) as TmedpIWMultiColumnComboBox).Text;
    if grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO1EU'),0) is TmeIWComboBox then
      FieldByName('TURNO1EU').AsString:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO1EU'),0) as TmeIWComboBox).Text;
    if grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO2EU'),0) is TmeIWComboBox then
      FieldByName('TURNO2EU').AsString:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO2EU'),0) as TmeIWComboBox).Text;
    FieldByName('GIORNO').AsString:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('GIORNO'),0) as TmeIWEdit).Text;
  end;
end;

procedure TWA054FCicliGiornalieriFM.imgModelliOrarioClick(Sender: TObject);
var r: Integer;
begin
  r:=grdTabella.medpRigaDiCompGriglia(TmeIWImageFile(Sender).FriendlyName);
  (Self.Owner as TWA054FCicliTurni).AccediForm(103,'CODICE='+ (grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('ORARIO'),0) as TmedpIWMultiColumnComboBox).Text);
end;

procedure TWA054FCicliGiornalieriFM.imgCausAssenzeClick(Sender: TObject);
var r: Integer;
begin
  r:=grdTabella.medpRigaDiCompGriglia(TmeIWImageFile(Sender).FriendlyName);
  (Self.Owner as TWA054FCicliTurni).AccediForm(105,'CODICE='+ (grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('CAUSALE'),0) as TmedpIWMultiColumnComboBox).Text);
end;

procedure TWA054FCicliGiornalieriFM.grdTabellaDataSet2Componenti(Row: Integer);
var ITurno: Integer;
    MCCB:TmedpIWMultiColumnComboBox;
begin
  inherited;
  with (WR302DM as TWA054FCicliTurniDM).A054MW.Q611 do
  begin
    if not(state in [dsInsert]) then
      (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('GIORNO'),0) as TmeIWEdit).Enabled:=False;
    (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('GIORNO'),0) as TmeIWEdit).Text:=FieldByName('GIORNO').AsString;
    (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('NUMTURNO1'),0) as TmeIWLabel).Caption:=FieldByName('NUMTURNO1').AsString;
    (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('SIGLATURNO1'),0) as TmeIWLabel).Caption:=FieldByName('SIGLATURNO1').AsString;
    (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('ENTRATA1'),0) as TmeIWLabel).Caption:=FieldByName('ENTRATA1').AsString;
    (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('USCITA1'),0) as TmeIWLabel).Caption:=FieldByName('USCITA1').AsString;
    (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('NUMTURNO2'),0) as TmeIWLabel).Caption:=FieldByName('NUMTURNO2').AsString;
    (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('SIGLATURNO2'),0) as TmeIWLabel).Caption:=FieldByName('SIGLATURNO2').AsString;
    (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('ENTRATA2'),0) as TmeIWLabel).Caption:=FieldByName('ENTRATA2').AsString;
    (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('USCITA2'),0) as TmeIWLabel).Caption:=FieldByName('USCITA2').AsString;
  end;

  //Creo img accedi ai modelli orario
  if grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('ORARIO'),1) is TmeIWImageFile then
    with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('ORARIO'),1) as TmeIWImageFile) do
    begin
      Hint:='Accedi a Modelli orario';
      OnClick:=imgModelliOrarioClick;
    end;
  //Creo img accedi a profilo
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CAUSALE'),1) as TmeIWImageFile) do
  begin
    Hint:='Accedi a Causali assenze';
    OnClick:=imgCausAssenzeClick;
  end;
  // Carico combo Orario
  if grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('ORARIO'),0) is TmedpIWMultiColumnComboBox then
    with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('ORARIO'),0) as TmedpIWMultiColumnComboBox) do
    begin
      Tag:=Row;
      items.Clear;
      OnChange:=cmbOrarioChange;
      if (Trim(Text) = '') or ((WR302DM as TWA054FCicliTurniDM).A054MW.Q611.FieldByName('ORARIO').AsString <> Trim(Text))  then
        Text:=ifthen(((WR302DM as TWA054FCicliTurniDM).A054MW.Q611.FieldByName('ORARIO').AsString <>''),(WR302DM as TWA054FCicliTurniDM).A054MW.Q611.FieldByName('ORARIO').AsString,'');
      with (WR302DM as TWA054FCicliTurniDM).A054MW do
      begin
        Q020.First;
        while not Q020.Eof do
        begin
          AddRow(Q020.FieldByName('CODICE').AsString + ';' + Q020.FieldByName('DESCRIZIONE').AsString);
          Q020.Next;
        end;
      end;
    end;
  // Carico combo Causale
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CAUSALE'),0) as TmedpIWMultiColumnComboBox) do
  begin
    Tag:=Row;
    items.Clear;
    OnChange:=cmbCausaleChange;
    if (Trim(Text) = '') or ((WR302DM as TWA054FCicliTurniDM).A054MW.Q611.FieldByName('CAUSALE').AsString <> Trim(Text))  then
      Text:=ifthen(((WR302DM as TWA054FCicliTurniDM).A054MW.Q611.FieldByName('CAUSALE').AsString <>''),(WR302DM as TWA054FCicliTurniDM).A054MW.Q611.FieldByName('CAUSALE').AsString,'');
    with (WR302DM as TWA054FCicliTurniDM).A054MW do
    begin
      Q265.First;
      while not Q265.Eof do
      begin
        AddRow(Q265.FieldByName('CODICE').AsString + ';' + Q265.FieldByName('DESCRIZIONE').AsString);
        Q265.Next;
      end;
    end;
  end;
  // Carico combo Turno1
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO1'),0) as TmedpIWMultiColumnComboBox) do
  begin
    Tag:=Row;
    items.Clear;
    OnChange:=cmbTurno1Change;
    if (Trim(Text) = '') or ((WR302DM as TWA054FCicliTurniDM).A054MW.Q611.FieldByName('TURNO1').AsString <> Trim(Text)) then
      Text:=ifthen(((WR302DM as TWA054FCicliTurniDM).A054MW.Q611.FieldByName('TURNO1').AsString <>''),(WR302DM as TWA054FCicliTurniDM).A054MW.Q611.FieldByName('TURNO1').AsString,'');
    with (WR302DM as TWA054FCicliTurniDM).A054MW do
    begin
      ITurno:=1;
      if Q021.SearchRecord('CODICE',Q611.FieldByName('ORARIO').AsString,[srFromBeginning]) then
      begin
        AddRow('M;Solo orario');
        AddRow('A;Assenza');
        AddRow('0;Riposo');
        repeat
          AddRow(IntToStr(ITurno)+'; ');
          inc(ITurno);
        until Not Q021.SearchRecord('CODICE',Q611.FieldByName('ORARIO').AsString,[]);
      end;
    end;
  end;
  // Carico combo Turno2
  if grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO2'),0) is TmedpIWMultiColumnComboBox then
    with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO2'),0) as TmedpIWMultiColumnComboBox) do
    begin
      Tag:=Row;
      items.Clear;
      OnChange:=cmbTurno2Change;
      if (Trim(Text) = '') or ((WR302DM as TWA054FCicliTurniDM).A054MW.Q611.FieldByName('TURNO2').AsString <> Trim(Text))  then
        Text:=ifthen(((WR302DM as TWA054FCicliTurniDM).A054MW.Q611.FieldByName('TURNO2').AsString <>''),(WR302DM as TWA054FCicliTurniDM).A054MW.Q611.FieldByName('TURNO2').AsString,'');
      with (WR302DM as TWA054FCicliTurniDM).A054MW do
      begin
        ITurno:=1;
        if Q021.SearchRecord('CODICE',Q611.FieldByName('ORARIO').AsString,[srFromBeginning]) then
        begin
          AddRow('M;Solo orario');
          AddRow('A;Assenza');
          AddRow('0;Riposo');
          repeat
            AddRow(IntToStr(ITurno)+'; ');
            inc(ITurno);
          until Not Q021.SearchRecord('CODICE',Q611.FieldByName('ORARIO').AsString,[]);
        end;
      end;
    end;
  //Carico combo Turno1EU
  if grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO1EU'),0) is TmeIWComboBox then
    with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO1EU'),0) as TmeIWComboBox) do
    begin
      Items.Clear;
      RequireSelection:=False;
      NoSelectionText:=' ';
      Items.Add('E');
      Items.Add('U');
      ItemIndex:=Items.IndexOf((WR302DM as TWA054FCicliTurniDM).A054MW.Q611.FieldByName('TURNO1EU').AsString);
    end;
  //Carico combo Turno2EU
  if grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO2EU'),0) is TmeIWComboBox then
    with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO2EU'),0) as TmeIWComboBox) do
    begin
      Items.Clear;
      RequireSelection:=False;
      NoSelectionText:=' ';
      Items.Add('E');
      Items.Add('U');
      ItemIndex:=Items.IndexOf((WR302DM as TWA054FCicliTurniDM).A054MW.Q611.FieldByName('TURNO2EU').AsString);
    end;
  //Giorno Essegno il css per forzare inserimento solo numeri
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('GIORNO'),0) as TmeIWEdit).Css:=
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('GIORNO'),0) as TmeIWEdit).Css + ' input_num_nn';
end;

procedure TWA054FCicliGiornalieriFM.cmbOrarioChange(Sender: TObject; Index: Integer);
var r: Integer;
begin
  inherited;
  r:=grdTabella.medpRigaDiCompGriglia((Sender as TmedpIWMultiColumnComboBox).FriendlyName);
  with (WR302DM as TWA054FCicliTurniDM).A054MW.Q611 do
    if grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('ORARIO'),0) is TmedpIWMultiColumnComboBox then
      FieldByName('ORARIO').AsString:=(grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('ORARIO'),0) as TmedpIWMultiColumnComboBox).Text;
  SalvaTurniEU(r);
  grdTabella.medpResetComponenti(r);
  PreparaComponenti;
  grdTabella.DataSet2Componenti(r);
end;

procedure TWA054FCicliGiornalieriFM.cmbCausaleChange(Sender: TObject; Index: Integer);
var r: Integer;
begin
  inherited;
  r:=grdTabella.medpRigaDiCompGriglia((Sender as TmedpIWMultiColumnComboBox).FriendlyName);
  with (WR302DM as TWA054FCicliTurniDM).A054MW.Q611 do
    if grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('CAUSALE'),0) is TmedpIWMultiColumnComboBox then
      FieldByName('CAUSALE').AsString:=(grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('CAUSALE'),0) as TmedpIWMultiColumnComboBox).Text;
  SalvaTurniEU(r);
  grdTabella.medpResetComponenti(r);
  PreparaComponenti;
  grdTabella.DataSet2Componenti(r);
end;

procedure TWA054FCicliGiornalieriFM.cmbTurno1Change(Sender: TObject; Index: Integer);
var r: Integer;
begin
  inherited;
  r:=grdTabella.medpRigaDiCompGriglia((Sender as TmedpIWMultiColumnComboBox).FriendlyName);
  with (WR302DM as TWA054FCicliTurniDM).A054MW.Q611 do
    if grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('TURNO1'),0) is TmedpIWMultiColumnComboBox then
      FieldByName('TURNO1').AsString:=(grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('TURNO1'),0) as TmedpIWMultiColumnComboBox).Text;
  SalvaTurniEU(r);
  grdTabella.medpResetComponenti(r);
  PreparaComponenti;
  grdTabella.DataSet2Componenti(r);
end;

procedure TWA054FCicliGiornalieriFM.cmbTurno2Change(Sender: TObject; Index: Integer);
var r: Integer;
begin
  inherited;
  r:=grdTabella.medpRigaDiCompGriglia((Sender as TmedpIWMultiColumnComboBox).FriendlyName);
  with (WR302DM as TWA054FCicliTurniDM).A054MW.Q611 do
    if grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('TURNO2'),0) is TmedpIWMultiColumnComboBox then
      FieldByName('TURNO2').AsString:=(grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('TURNO2'),0) as TmedpIWMultiColumnComboBox).Text;
  SalvaTurniEU(r);
  grdTabella.medpResetComponenti(r);
  PreparaComponenti;
  grdTabella.DataSet2Componenti(r);
end;

procedure TWA054FCicliGiornalieriFM.SalvaTurniEU(Row: Integer);
begin
  with (WR302DM as TWA054FCicliTurniDM).A054MW.Q611 do
  begin
    if grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('GIORNO'),0) is TmeIWEdit then
      FieldByName('GIORNO').AsString:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('GIORNO'),0) as TmeIWEdit).Text;
    if grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO1EU'),0) is TmeIWComboBox then
      FieldByName('TURNO1EU').AsString:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO1EU'),0) as TmeIWComboBox).Text;
    if grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO2EU'),0) is TmeIWComboBox then
      FieldByName('TURNO2EU').AsString:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNO2EU'),0) as TmeIWComboBox).Text;
  end;
end;

end.
