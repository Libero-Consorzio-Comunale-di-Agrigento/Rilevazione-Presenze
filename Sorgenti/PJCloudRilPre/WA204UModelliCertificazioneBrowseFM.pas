unit WA204UModelliCertificazioneBrowseFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR204UBrowseTabellaFM, Vcl.Menus, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompGrids, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  meIWEdit, meIWImageFile, C190FunzioniGeneraliWeb, medpIWMultiColumnComboBox;

type
  TWA204FModelliCertificazioneBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure IWFrameRegionCreate(Sender: TObject);
  private
    { Private declarations }
    procedure CreaBtnSelAnagrafe(pCampoColonna: string; pRow: integer);
    procedure imgSelAnagrafeClick(Sender: TObject);
    procedure resultSelAnagrafe(Sender: TObject; Result: Boolean);
  public
    { Public declarations }
  end;

implementation

uses
  WA204UModelliCertificazione, WA204UModelliCertificazioneDM,
  Data.DB, C180FunzioniGenerali, meIWLabel;
{$R *.dfm}

procedure TWA204FModelliCertificazioneBrowseFM.imgSelAnagrafeClick(Sender: TObject);
begin
  inherited;
  TWA204FModelliCertificazione(Self.Owner).AttivaGestioneC700L;

  with TWA204FModelliCertificazioneDM(WR302DM).selTabella do
  begin
  if State in [dsEdit,dsInsert] then
    with TWA204FModelliCertificazione(Self.Owner).grdC700 do
    begin
      WC700FM.ResultEvent:=resultSelAnagrafe;
      WC700FM.Tag:=((Sender as TmeIWImageFile).medpTag as TImgRow).NumRow;
      actSelezioneAnagraficheExecute(nil);
    end;
  end;
end;

procedure TWA204FModelliCertificazioneBrowseFM.grdTabellaDataSet2Componenti(Row: Integer);
begin
  inherited;

  TWA204FModelliCertificazione(Self.Owner).CreaBtnTesto(grdTabella, TWA204FModelliCertificazioneDM(WR302DM).selTabella, 'DESCRIZIONE',Row);
  TWA204FModelliCertificazione(Self.Owner).CreaBtnTesto(grdTabella, TWA204FModelliCertificazioneDM(WR302DM).selTabella, 'PERIODO',Row);
  CreaBtnSelAnagrafe('SELEZIONE_ANAGRAFE',Row);

  TmeIWEdit(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('INIZIO_VALIDITA'),0)).Css:='input_data_dmyhhmm';
  TmeIWEdit(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('FINE_VALIDITA'),0)).Css:='input_data_dmyhhmm';

  // Autocertificazione: combobox con valori [S | N]
  with (grdTabella.medpCompCella(Row,'AUTOCERTIFICAZIONE',0) as TMedpIWMultiColumnComboBox) do
  begin
    PopUpHeight:=3;
    Items.Clear;
    AddRow('S;Sì');
    AddRow('N;No');
    Text:=grdTabella.medpValoreColonna(Row,'AUTOCERTIFICAZIONE');
  end;

  // Unità di misura della quantità: combobox con valori [D | W | M | Y]
  with (grdTabella.medpCompCella(Row,'UM',0) as TMedpIWMultiColumnComboBox) do
  begin
    PopUpHeight:=5;
    Items.Clear;
    AddRow('D;Giorni');
    AddRow('W;Settimane');
    AddRow('M;Mesi');
    AddRow('Y;Anni');
    Text:=grdTabella.medpValoreColonna(Row,'UM');
  end;

  // Periodo modificabile: combobox con valori [S | N]
  with (grdTabella.medpCompCella(Row,'PERIODO_MODIFICABILE',0) as TMedpIWMultiColumnComboBox) do
  begin
    PopUpHeight:=3;
    Items.Clear;
    AddRow('S;Sì');
    AddRow('N;No');
    Text:=grdTabella.medpValoreColonna(Row,'PERIODO_MODIFICABILE');
  end;
end;

procedure TWA204FModelliCertificazioneBrowseFM.CreaBtnSelAnagrafe(pCampoColonna: string; pRow: integer);
var
  img:TmeIWImageFile;
begin
  if grdTabella.medpCompCella(pRow,grdTabella.medpIndexColonna(pCampoColonna),1) <> nil then
  begin
    img:=TmeIWImageFile(grdTabella.medpCompCella(pRow,grdTabella.medpIndexColonna(pCampoColonna),1));
    img.OnClick:=imgSelAnagrafeClick;
    img.medpTag:=TImgRow.Create;
    (img.medpTag as TImgRow).NumRow:=pRow;
    (img.medpTag as TImgRow).NomeCampo:=pCampoColonna;
  end;
end;

procedure TWA204FModelliCertificazioneBrowseFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('AUTOCERTIFICAZIONE'),0,DBG_MECMB,'1','1','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('UM'),0,DBG_MECMB,'1','1','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('PERIODO_MODIFICABILE'),0,DBG_MECMB,'1','1','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102','DESCRIZIONE',0,DBG_LBL,'50','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102','DESCRIZIONE',1,DBG_IMG,'','PUNTINI','','','D');
  grdTabella.medpPreparaComponenteGenerico('WR102','PERIODO',0,DBG_LBL,'50','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102','PERIODO',1,DBG_IMG,'','PUNTINI','','','D');
  grdTabella.medpPreparaComponenteGenerico('WR102','SELEZIONE_ANAGRAFE',0,DBG_LBL,'50','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102','SELEZIONE_ANAGRAFE',1,DBG_IMG,'','PUNTINI','','','D');
end;

procedure TWA204FModelliCertificazioneBrowseFM.resultSelAnagrafe(Sender: TObject; Result: Boolean);
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
var
  S:string;
  lblSelAnagrafe: TmeIWLabel;
begin
  if result then
  begin
    S:=Trim(TWA204FModelliCertificazione(Self.Owner).grdC700.WC700FM.SQLCreato.Text);
    if Pos('ORDER BY',UpperCase(S)) > 0 then
      S:=Copy(S,1,Pos('ORDER BY',UpperCase(S)) - 1);
    //Aggiorna il dataset
    TWA204FModelliCertificazioneDM(WR302DM).selTabella.FieldByName('SELEZIONE_ANAGRAFE').AsString:=TrasformaV430(S);
    //Aggiorna la label
    lblSelAnagrafe:=grdTabella.medpCompCella(TWA204FModelliCertificazione(Self.Owner).grdC700.WC700FM.Tag,'SELEZIONE_ANAGRAFE',0) as TmeIWLabel;
    lblSelAnagrafe.Caption:=TWA204FModelliCertificazioneDM(WR302DM).selTabella.FieldByName('SELEZIONE_ANAGRAFE').AsString
  end;
  FreeAndNil(TWA204FModelliCertificazione(Self.Owner).grdC700);
end;

end.
