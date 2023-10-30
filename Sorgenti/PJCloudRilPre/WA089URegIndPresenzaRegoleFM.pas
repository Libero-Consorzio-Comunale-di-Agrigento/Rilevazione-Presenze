unit WA089URegIndPresenzaRegoleFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR203UGestDetailFM, ActnList, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWDBGrids, medpIWDBGrid, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl,  meIWGrid,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  C180FunzioniGenerali,C190FunzioniGeneraliWeb, meIWLabel, meIWImageFile,
  A000UInterfaccia, OracleData, Db,DBClient, meIWEdit, medpIWMessageDlg, Math,
  meIWcomboBox, IWCompJQueryWidget, IWCompGrids,medpIWMultiColumnComboBox,
  System.Actions, Vcl.Menus;

type
    TWA089FRegIndPresenzaRegoleFM = class(TWR203FGestDetailFM)
    actVisCorrente: TAction;
    procedure grdTabellaComponenti2DataSet(Row: Integer);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure grdTabellaAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure actVisCorrenteExecute(Sender: TObject);
  private
    procedure imgSelAnagrafeClick(Sender: TObject);
    procedure resultSelAnagrafe(Sender: TObject; Result: Boolean);
    procedure createImgSelAnagrafe(DBG_ROWID: string);
  public
    procedure CaricaDettaglio(DataSet:TDataSet;DataSource:TDataSource); override;
 end;

implementation

uses WA089URegIndPResenzaDM, WA089URegIndPresenza, WR100UBase;

{$R *.dfm}

procedure TWA089FRegIndPresenzaRegoleFM.actVisCorrenteExecute(Sender: TObject);
begin
  inherited;
  actVisCorrente.Checked:=Not actVisCorrente.Checked;
  with grdTabella.medpDataSet do
  begin
    Filter:='(' + FloatToStr(Parametri.DataLavoro) + ' >= DECORRENZA) and (' + FloatToStr(Parametri.DataLavoro) + ' <= SCADENZA)';
    Filtered:=actVisCorrente.Checked;
  end;
  actAggiorna.Execute;
  TWR100FBase(Self.Parent).AggiornaToolBar(grdDetailNavBar,actlstDetailNavBar);
end;

procedure TWA089FRegIndPresenzaRegoleFM.CaricaDettaglio(DataSet:TDataSet;DataSource:TDataSource);
begin
  grdTabella.medpComandiCustom:=True;
  inherited;
  grdTabella.medpPreparaComponenteGenerico('WR102-R',grdTabella.medpIndexColonna('DBG_COMANDI'),0,DBG_IMG,'','SELANAGRAFE','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('TIPO_ASSOCIAZIONE'),0,DBG_CMB,'15','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('DECORRENZA'),0,DBG_EDT,'DATA','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('SCADENZA'),0,DBG_EDT,'DATA','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('ESPRESSIONE'),0,DBG_EDT,'40','','null','','S');
end;

procedure TWA089FRegIndPresenzaRegoleFM.grdTabellaAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
begin
  inherited;
  createImgSelAnagrafe(DBG_ROWID);
end;

procedure TWA089FRegIndPresenzaRegoleFM.createImgSelAnagrafe(DBG_ROWID: string);
var r : Integer;
    img : TmeIWImageFile;
begin
  for r := ifthen(grdTabella.medpDataSet.state in [dsInsert],0,1) to High(grdTabella.medpCompGriglia) do
    if grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('DBG_COMANDI'),0) <> nil then
    begin
      img:=TmeIWImageFile(grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('DBG_COMANDI'),0));
      img.OnClick:=imgSelAnagrafeClick;
    end;
end;

procedure TWA089FRegIndPresenzaRegoleFM.imgSelAnagrafeClick(Sender: TObject);
var tmpStato:TDataSetState;
begin
  if grdTabella.medpDataSet.State in [dsEdit,dsInsert] then
  begin
    with grdTabella.medpDataSet do
    begin
      tmpStato:=State;
      grdTabella.medpColumnClick(Sender,TmeIWImageFile(Sender).FriendlyName);
      if tmpStato = dsEdit then
        Edit
      else
        Insert;
    end;
    with TWA089FRegIndPresenza(Self.Owner).grdC700 do
    begin
      WC700FM.ResultEvent:=resultSelAnagrafe;
      actSelezioneAnagraficheExecute(nil);
    end;
  end;
end;

procedure TWA089FRegIndPresenzaRegoleFM.resultSelAnagrafe(Sender: TObject; Result: Boolean);
var S:string;
  function TrasformaV430(X:String):String;
    var Apice:Boolean;
        i:Integer;
    begin
      Result:='';
      i:=1;
      Apice:=False;
      while i <= Length(X) do
      begin
        if X[i] = '''' then
          Apice:=not Apice;
        if (not Apice) and (Copy(X,i,5) = 'V430.') then
        begin
          X:=Copy(X,1,i - 1) + Copy(X,i + 5,4) + '.' + Copy(X,i + 9,Length(X));
          inc(i,5);
        end;
        inc(i);
      end;
      Result:=EliminaRitornoACapo(Trim(X));
    end;
begin
  if result then
  begin
    S:=Trim(TWA089FRegIndPresenza(Self.Owner).grdC700.WC700FM.SQLCreato.Text);
    if Pos('ORDER BY',UpperCase(S)) > 0 then
      S:=Copy(S,1,Pos('ORDER BY',UpperCase(S)) - 1);
    TmeIWEdit(grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('ESPRESSIONE'),0)).Text:=TrasformaV430(S);
  end;
end;

procedure TWA089FRegIndPresenzaRegoleFM.grdTabellaComponenti2DataSet(Row: Integer);
var i:Integer;
begin
   if TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TIPO_ASSOCIAZIONE'),0)).Text = 'Aggiunge' then
    grdTabella.medpDataSet.FieldByName('TIPO_ASSOCIAZIONE').AsString:='A'
  else
    grdTabella.medpDataSet.FieldByName('TIPO_ASSOCIAZIONE').AsString:='E';
end;

procedure TWA089FRegIndPresenzaRegoleFM.grdTabellaDataSet2Componenti(Row: Integer);
begin
  inherited;
  with TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TIPO_ASSOCIAZIONE'),0)) do
  begin
    Items.Add('Aggiunge');
    Items.Add('Esclude');
    if grdTabella.medpValoreColonna(Row, 'TIPO_ASSOCIAZIONE') = 'A' then
      ItemIndex:=0
    else
      ItemIndex:=1;
  end;

  grdTabella.medpCreaComponenteGenerico(Row,grdTabella.medpIndexColonna('DBG_COMANDI'),grdTabella.medpDescCompGriglia.RigaWR102R[0]);
  createImgSelAnagrafe(IntToStr(Row));
 end;

end.
