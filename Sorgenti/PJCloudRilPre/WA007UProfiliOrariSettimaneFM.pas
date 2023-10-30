unit WA007UProfiliOrariSettimaneFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR203UGestDetailFM, ActnList, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWDBGrids, medpIWDBGrid, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, meIWGrid,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  C190FunzioniGeneraliWeb, meIWLabel, meIWImageFile, WC011UListBoxFM,
  A000UInterfaccia, OracleData, Db, meIWEdit, medpIWMessageDlg, Math,
  IWCompJQueryWidget, IWCompGrids, System.Actions, Vcl.Menus;

type
  TWA007FProfiliOrariSettimaneFM = class(TWR203FGestDetailFM)
    pmnModelloOrario: TPopupMenu;
    mnuAccedi: TMenuItem;
    mnuModelliOrarioGrid: TMenuItem;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure grdTabellaComponenti2DataSet(Row: Integer);
    procedure mnuAccediClick(Sender: TObject);
    procedure mnuModelliOrarioGridClick(Sender: TObject);
  private
    Row,Col:Integer;
    ListModelli:TStringList;
    WC011:TWC011FListBoxFM;
    procedure imgModelliOrarioClick(Sender: TObject);
    procedure validaOrario(DataSet: TDataSet;orarioLunedi:string);
    procedure lstModelloResult(Sender: TObject; DialogResult: Boolean; ResultValue: string);
    function OrarioOk:String;
  public
    procedure CaricaDettaglio(DataSet:TDataSet;DataSource:TDataSource); override;
    procedure CaricaListModelli;
    procedure ReleaseOggetti; override;
  end;

implementation

uses WA007UProfiliOrariDM, WA007UProfiliOrari, WR100UBase;

{$R *.dfm}

procedure TWA007FProfiliOrariSettimaneFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  ListModelli:=TStringList.Create;
  CaricaListModelli;
end;

procedure TWA007FProfiliOrariSettimaneFM.CaricaListModelli;
begin
  with TWA007FProfiliOrariDM(TWA007FProfiliOrari(Self.Parent).WR302DM) do
  begin
    ListModelli.Clear;
    selT020.Refresh;
    selT020.First;
    while not selT020.Eof do
    begin
      ListModelli.Add(Format('%-5s %s',[selT020.FieldByName('CODICE').AsString,selT020.FieldByName('DESCRIZIONE').AsString]));
      selT020.Next;
    end;
  end;
end;

procedure TWA007FProfiliOrariSettimaneFM.mnuAccediClick(Sender: TObject);
var Params: String;
begin
  Params:='CODICE=' + (pmnModelloOrario.PopupComponent as TmeIWEdit).Text;
  (Self.Owner as TWA007FProfiliOrari).accediForm(103,Params,False);
end;

procedure TWA007FProfiliOrariSettimaneFM.mnuModelliOrarioGridClick(Sender: TObject);
var Params: String;
begin
  Params:='CODICE=' + grdTabella.DatasOURCE.DataSet.FieldByName('LUNEDI').AsString;
  (Self.Owner as TWA007FProfiliOrari).accediForm(103,Params,False);
end;

procedure TWA007FProfiliOrariSettimaneFM.CaricaDettaglio(DataSet:TDataSet;DataSource:TDataSource);
begin
  inherited;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('Lunedi'),1,DBG_IMG,'','CAMBIADATO','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('Martedi'),1,DBG_IMG,'','CAMBIADATO','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('Mercoledi'),1,DBG_IMG,'','CAMBIADATO','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('Giovedi'),1,DBG_IMG,'','CAMBIADATO','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('Venerdi'),1,DBG_IMG,'','CAMBIADATO','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('Sabato'),1,DBG_IMG,'','CAMBIADATO','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('Domenica'),1,DBG_IMG,'','CAMBIADATO','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('NonLav'),1,DBG_IMG,'','CAMBIADATO','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('Festivo'),1,DBG_IMG,'','CAMBIADATO','','','S');
end;

function TWA007FProfiliOrariSettimaneFM.OrarioOk:String;
{Controllo la validità degli orari introdotti}
{Non possono esserci due giorni con lo stesso orario}
var Nomi:Array [0..8] of String;
    CodOra:Array [0..8,0..50] of String;
    num,i,j,x:ShortInt;
    StateEdit:Boolean;
    RigaNulla:boolean;
procedure OrarioNullo(StateEdit:Boolean);
{procedura per gestire il caso di 'buco' negli orari}
var i1,j1,x1,Ind1,Ind2:ShortInt;
begin
  //Ricerca e annullamento orari ripetuti nello stesso giorno
  for i1:=0 to 8 do
    for x1:=0 to Num - 1 do
      if Trim(CodOra[i1,x1]) <> '' then
      begin
        Ind2:=x1;
        j1:=x1 + 1;
        while (j1 <= Num) and (Trim(CodOra[i1,j1]) <> Trim(CodOra[i1,x1])) do inc(j1);
        if j1 <= Num then
          CodOra[i1,j1]:=''
      end;
  //Copertura buchi
  for i1:=0 to 8 do
    for x1:=0 to Num - 1 do
      if (Trim(CodOra[i1,x1]) = '') then
      begin
        Ind2:=x1;
        j1:=x1 + 1;
        while (j1 <= Num) and (Trim(CodOra[i1,j1]) = '') do inc(j1);
        if j1 <= Num then
          for Ind1:=j1 to Num do
          begin
            CodOra[i1,Ind2]:=CodOra[i1,Ind1];
            CodOra[i1,Ind1]:='';
            inc(Ind2);
          end;
      end
end;
begin
  Result:='';
  StateEdit:=grdTabella.medpDataSet.State = dsEdit;
  Nomi[0]:='Lunedì';Nomi[1]:='Martedì';Nomi[2]:='Mercoledì';
  Nomi[3]:='Giovedì';Nomi[4]:='Venerdì';Nomi[5]:='Sabato';
  Nomi[6]:='Domenica';Nomi[7]:='Non lavorativo';Nomi[8]:='Festivo';
  for i:=0 to 8 do
    for j:=0 to 50 do CodOra[i,j]:='';
  with grdTabella.medpClientDataSet do
  begin
    Num:=RecordCount - 2;
    First;
    Next;
    j:=0;
    while not Eof do
    begin
      for i:=0 to 8 do
        CodOra[i,j]:=Fields[FieldByName('LUNEDI').Index + i].AsString;
      Next;
      inc(j);
    end;
    //Se sono in inserimento, aggiungo la prima riga del client dataset
    if not StateEdit then
    begin
      inc(Num);
      First;
      for i:=0 to 8 do
        CodOra[i,j]:=TmeIWEdit(grdTabella.medpCompCella(0,grdTabella.medpIndexColonna('lunedi')+i,0)).Text;
    end;
  end;
  //Gestisco i 'buchi' negli orari e orari ripetuti nello stesso giorno
  OrarioNullo(StateEdit);
  //Verifico completezza prima settimana
  for i:=0 to 8 do
    if Trim(CodOra[i,0]) = '' then
    begin
      Result:='Prima settimana incompleta!';
      Break;
    end;
  if Result <> '' then
    exit;
 end;

procedure TWA007FProfiliOrariSettimaneFM.ReleaseOggetti;
begin
  FreeAndNil(ListModelli);
  inherited;
end;

procedure TWA007FProfiliOrariSettimaneFM.imgModelliOrarioClick(Sender: TObject);
begin
  Row:=grdTabella.medpRigaDiCompGriglia(TmeIWImageFile(Sender).FriendlyName);
  Col:=TmeIWImageFile(Sender).Tag;
  WC011:=TWC011FListBoxFM.Create(Self.Parent);
  WC011.lstValori.Items.AddStrings(ListModelli);
  WC011.lstValori.ItemIndex:=WC011.lstValori.Items.IndexOf(TmeIWEdit(grdTabella.medpCompCella(Row,Col,0)).Text);
  WC011.lstValori.Css:=WC011.lstValori.Css + ' fontcourierImp';
  WC011.ResultEvent:=lstModelloResult;
  WC011.Visualizza('Selezione modelli orario');
end;

procedure TWA007FProfiliOrariSettimaneFM.lstModelloResult(Sender: TObject; DialogResult: Boolean; ResultValue: string);
begin
  if DialogResult then
  begin
    TmeIWEdit(grdTabella.medpCompCella(Row,Col,0)).Text:=Trim(Copy(ResultValue,1,5));
    validaOrario(grdTabella.medpClientDataSet,Trim(Copy(ResultValue,1,5)));
  end;
end;

procedure TWA007FProfiliOrariSettimaneFM.grdTabellaComponenti2DataSet(Row: Integer);
var S:string;
begin
  S:=OrarioOk;
  if S <> '' then
    raise Exception.Create(S);
  inherited;
 end;

procedure TWA007FProfiliOrariSettimaneFM.grdTabellaDataSet2Componenti(Row: Integer);
begin
  inherited;
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('Lunedi'),0) as TmeIWEdit) do
  begin
    Hint:=grdTabella.medpValoreColonna(Row, 'DLunedi');
    medpContextMenu:=pmnModelloOrario;
  end;
  TmeIWImageFile(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('Lunedi'),1)).Tag:=grdTabella.medpIndexColonna('Lunedi');
  TmeIWImageFile(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('Lunedi'),1)).OnClick:=imgModelliOrarioClick;
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('Martedi'),0) as TmeIWEdit) do
  begin
    Hint:=grdTabella.medpValoreColonna(Row, 'DMartedi');
    medpContextMenu:=pmnModelloOrario;
  end;
  TmeIWImageFile(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('Martedi'),1)).Tag:=grdTabella.medpIndexColonna('Martedi');
  TmeIWImageFile(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('Martedi'),1)).OnClick:=imgModelliOrarioClick;
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('Mercoledi'),0) as TmeIWEdit) do
  begin
    Hint:=grdTabella.medpValoreColonna(Row, 'DMercoledi');
    medpContextMenu:=pmnModelloOrario;
  end;
  TmeIWImageFile(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('Mercoledi'),1)).Tag:=grdTabella.medpIndexColonna('Mercoledi');
  TmeIWImageFile(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('Mercoledi'),1)).OnClick:=imgModelliOrarioClick;
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('Giovedi'),0) as TmeIWEdit) do
  begin
    Hint:=grdTabella.medpValoreColonna(Row, 'DGiovedi');
    medpContextMenu:=pmnModelloOrario;
  end;
  TmeIWImageFile(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('Giovedi'),1)).Tag:=grdTabella.medpIndexColonna('Giovedi');
  TmeIWImageFile(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('Giovedi'),1)).OnClick:=imgModelliOrarioClick;
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('Venerdi'),0) as TmeIWEdit) do
  begin
    Hint:=grdTabella.medpValoreColonna(Row, 'DVenerdi');
    medpContextMenu:=pmnModelloOrario;
  end;
  TmeIWImageFile(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('Venerdi'),1)).Tag:=grdTabella.medpIndexColonna('Venerdi');
  TmeIWImageFile(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('Venerdi'),1)).OnClick:=imgModelliOrarioClick;
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('Sabato'),0) as TmeIWEdit) do
  begin
    Hint:=grdTabella.medpValoreColonna(Row, 'DSabato');
    medpContextMenu:=pmnModelloOrario;
  end;
  TmeIWImageFile(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('Sabato'),1)).Tag:=grdTabella.medpIndexColonna('Sabato');
  TmeIWImageFile(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('Sabato'),1)).OnClick:=imgModelliOrarioClick;
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('Domenica'),0) as TmeIWEdit) do
  begin
    Hint:=grdTabella.medpValoreColonna(Row, 'DDomenica');
    medpContextMenu:=pmnModelloOrario;
  end;
  TmeIWImageFile(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('Domenica'),1)).Tag:=grdTabella.medpIndexColonna('Domenica');
  TmeIWImageFile(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('Domenica'),1)).OnClick:=imgModelliOrarioClick;
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('NonLav'),0) as TmeIWEdit) do
  begin
    Hint:=grdTabella.medpValoreColonna(Row, 'DNonLav');
    medpContextMenu:=pmnModelloOrario;
  end;
  TmeIWImageFile(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('NonLav'),1)).Tag:=grdTabella.medpIndexColonna('NonLav');
  TmeIWImageFile(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('NonLav'),1)).OnClick:=imgModelliOrarioClick;
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('Festivo'),0) as TmeIWEdit) do
  begin
    Hint:=grdTabella.medpValoreColonna(Row, 'DFestivo');
    medpContextMenu:=pmnModelloOrario;
  end;
  TmeIWImageFile(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('Festivo'),1)).Tag:=grdTabella.medpIndexColonna('Festivo');
  TmeIWImageFile(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('Festivo'),1)).OnClick:=imgModelliOrarioClick;
end;

procedure TWA007FProfiliOrariSettimaneFM.validaOrario(DataSet: TDataSet;orarioLunedi:string);
  procedure AssegnaOrarioLunedi(Giorno:String);
  begin
   if TmeIWEdit(grdTabella.medpCompCella(0,grdTabella.medpIndexColonna(Giorno),0)).Text = '' then
      TmeIWEdit(grdTabella.medpCompCella(0,grdTabella.medpIndexColonna(Giorno),0)).Text:=orarioLunedi;
  end;
  procedure ControllaOrario(Giorno:String);
  begin
    with TmeIWEdit(grdTabella.medpCompCella(0,grdTabella.medpIndexColonna(Giorno),0)) do
    begin
      if ((Giorno = 'NONLAV') or (Giorno = 'FESTIVO')) and (Text = ':GGST') then
        exit;
      if (Text <> '') and (not TWA007FProfiliOrariDM(TWA007FProfiliOrari(Self.Parent).WR302DM).selT020.SearchRecord('CODICE',Text,[srFromBeginning])) then
        raise Exception.Create('Codice "' + Text + '" nel giorno ' + Giorno + ' inesistente!');
    end;
  end;
begin
  if grdTabella.medpStatoInterno <> msiNone then
    exit;
  if (DataSet.FieldByName('DBG_ROWID').AsString = '*') and (DataSet.RecordCount = 1) then
    if (orarioLunedi <> '') then
    begin
      AssegnaOrarioLunedi('MARTEDI');
      AssegnaOrarioLunedi('MERCOLEDI');
      AssegnaOrarioLunedi('GIOVEDI');
      AssegnaOrarioLunedi('VENERDI');
      AssegnaOrarioLunedi('SABATO');
      AssegnaOrarioLunedi('DOMENICA');
      AssegnaOrarioLunedi('NONLAV');
      AssegnaOrarioLunedi('FESTIVO');
    end;

  ControllaOrario('LUNEDI');
  ControllaOrario('MARTEDI');
  ControllaOrario('MERCOLEDI');
  ControllaOrario('GIOVEDI');
  ControllaOrario('VENERDI');
  ControllaOrario('SABATO');
  ControllaOrario('DOMENICA');
  ControllaOrario('NONLAV');
  ControllaOrario('FESTIVO');
end;


end.
