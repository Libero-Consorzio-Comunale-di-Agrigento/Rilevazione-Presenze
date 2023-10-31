unit A138UTurniApparati;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGestStorico, ActnList, ImgList, DB, Menus, StdCtrls, ComCtrls,
  ToolWin, Mask, DBCtrls, Buttons, A138UTurniApparatiDTM, Grids, DBGrids,
  ExtCtrls, CheckLst, OracleData, A000UInterfaccia, C180FunzioniGenerali,
  A000UCostanti, A000USessione;

type
  TA138FTurniApparati = class(TR004FGestStorico)
    PageControl1: TPageControl;
    tabApparati: TTabSheet;
    tabTipoApparati: TTabSheet;
    DGrdTApparati: TDBGrid;
    PopMenuFiltro1: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Annullatutto1: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    Label3: TLabel;
    DEdtDesc: TDBEdit;
    GroupStato: TDBRadioGroup;
    DEdtCodice: TDBEdit;
    DLbl: TDBText;
    DCmbCodApparato: TDBLookupComboBox;
    Label1: TLabel;
    Label2: TLabel;
    GrpBoxFiltro1: TGroupBox;
    ChkFiltro1: TCheckListBox;
    GrpBoxFiltro2: TGroupBox;
    ChkFiltro2: TCheckListBox;
    GrpBoxFiltroServizi: TGroupBox;
    ChkFiltroServizi: TCheckListBox;
    dchkRadio: TDBCheckBox;
    procedure DCmbCodApparatoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PageControl1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure Annullatutto1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure PageControl1Changing(Sender: TObject; var AllowChange: Boolean);
  private
    { Private declarations }
    procedure CaricaChkList(var ChkList:TCheckListBox;var Dts:TOracleDataSet;campo:string);
  public
    { Public declarations }
  end;

var
  A138FTurniApparati: TA138FTurniApparati;

procedure OpenA138TurniApparati;

implementation

{$R *.dfm}

procedure OpenA138TurniApparati;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA138TurniApparati') of
    'N':
    begin
      ShowMessage('Funzione non abilitata!');
      Exit;
    end;
    'R':SolaLettura:=True;
  end;
  A138FTurniApparati:=TA138FTurniApparati.Create(nil);
  with A138FTurniApparati do
    try
      A138FTurniApparatiDTM:=TA138FTurniApparatiDTM.Create(nil);
      A138FTurniApparati.ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      FreeAndNil(A138FTurniApparatiDtm);
      FreeAndNil(A138FTurniApparati);
    end;
end;

procedure TA138FTurniApparati.DButtonStateChange(Sender: TObject);
begin
  inherited;
  ChkFiltro1.Enabled:=DButton.State in [dsInsert,dsEdit];
  ChkFiltro2.Enabled:=DButton.State in [dsInsert,dsEdit];
  ChkFiltroServizi.Enabled:=DButton.State in [dsInsert,dsEdit];
end;

procedure TA138FTurniApparati.DCmbCodApparatoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA138FTurniApparati.Annullatutto1Click(Sender: TObject);
var i:integer;
begin
  inherited;
  for i:=0 to TCheckListBox(PopMenuFiltro1.PopupComponent).Items.Count - 1 do
    TCheckListBox(PopMenuFiltro1.PopupComponent).Checked[i]:=Sender = SelezionaTutto1;
end;

procedure TA138FTurniApparati.CaricaChkList(var ChkList:TCheckListBox;var Dts:TOracleDataSet;campo:string);
var Length:Integer;
begin
  with A138FTurniApparatiDTM do
  begin
    Length:=WidthCodice(Campo);

    ChkList.Items.Clear;
    if Not Dts.Active then
      Dts.Open;
    Dts.First;
    while Not(Dts.Eof) do
    begin
      ChkList.Items.Add(Format('%-*s %-40s',[Length,Dts.FieldByName('CODICE').AsString,Dts.FieldByName('DESCRIZIONE').AsString]));
      Dts.Next;
    end;
  end;
end;

procedure TA138FTurniApparati.FormResize(Sender: TObject);
var width:Integer;
begin
  inherited;
  if A138FTurniApparati <> nil then
  begin
    width:=Trunc(A138FTurniApparati.Width / 3)-5;
    GrpBoxFiltro1.Width:=width;
    GrpBoxFiltro2.Width:=width;
    GrpBoxFiltroServizi.Width:=width;
  end;
end;

procedure TA138FTurniApparati.FormShow(Sender: TObject);
begin
  inherited;
  with A138FTurniApparatiDTM do
  begin
    GrpBoxFiltro1.Caption:=Copy(Parametri.CampiRiferimento.C22_PianServLiv1,1,1) + LowerCase(Copy(Parametri.CampiRiferimento.C22_PianServLiv1,2,50));
    GrpBoxFiltro2.Caption:=Copy(Parametri.CampiRiferimento.C22_PianServLiv2,1,1) + LowerCase(Copy(Parametri.CampiRiferimento.C22_PianServLiv2,2,50));

    CaricaChkList(ChkFiltro1,selFiltro1,Parametri.CampiRiferimento.C22_PianServLiv1);
    CaricaChkList(ChkFiltro2,selFiltro2,Parametri.CampiRiferimento.C22_PianServLiv2);
    CaricaChkList(ChkFiltroServizi,selT540,'');

    R180PutCheckList(selT550.FieldByName('FILTRO1').AsString,WidthCodice(Parametri.CampiRiferimento.C22_PianServLiv1),ChkFiltro1);
    R180PutCheckList(selT550.FieldByName('FILTRO2').AsString,WidthCodice(Parametri.CampiRiferimento.C22_PianServLiv2),ChkFiltro2);
    R180PutCheckList(selT550.FieldByName('FILTRO_SERVIZI').AsString,WidthCodice('T540_SERVIZI'),ChkFiltroServizi);
  end;
end;

procedure TA138FTurniApparati.PageControl1Change(Sender: TObject);
begin
  inherited;
  ToolBar1.Enabled:=PageControl1.TabIndex = 0;
  grbDecorrenza.Enabled:=PageControl1.TabIndex = 0;
end;

procedure TA138FTurniApparati.PageControl1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
  inherited;
  AllowChange:=(A138FTurniApparatiDtM.selT550.State = dsBrowse) and (A138FTurniApparatiDtM.selT555.State = dsBrowse);
end;

end.
