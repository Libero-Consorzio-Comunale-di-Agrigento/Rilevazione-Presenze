unit WA005UDatiLiberi;

interface

uses
  WA005UDatiLiberiBrowseFM,
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWControl,
  Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWCompEdit, IWHTMLControls, meIWLink,
  ActnList, Menus, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompMenu, IWCompLabel,
  A000UInterfaccia, A000UCostanti, A000USessione, WR100UBase,
  IWCompTabControl, Forms, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion,
  WA005UDatiLiberiDM, IWCompButton, WR102UGestTabella, C190FunzioniGeneraliWeb,
  IWDBStdCtrls, meIWLabel, WR302UGestTabellaDM, meIWButton, meIWDBNavigator,
  meIWGrid, medpIWTabControl, medpIWStatusBar,
  IWCompListbox, meIWComboBox, Oracle, OracleData, medpIWMessageDlg, StrUtils,
  meIWEdit, meIWDBEdit, IWCompGrids,A000UMessaggi, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, System.Actions,
  meIWImageFile;

type
  TTabelleDatiStorici = record
    Storico:Boolean;
    NomeTabelle:String;
    NomeCampo:String;
    Accesso:String;
    Scadenza:String;
  end;

  TWA005FDatiLiberi = class(TWR102FGestTabella)
    lblDatoAnagrafico: TmeIWLabel;
    cmbDatoLibero: TmeIWComboBox;
    procedure IWAppFormCreate(Sender: TObject);
    procedure cmbDatoLiberoChange(Sender: TObject);
  protected
    procedure imgNuovaStoricizzazioneClick(Sender: TObject); override;
  private
    WA115SolaLettura:Boolean;
    chiudi:Boolean;
    procedure CaricaDatiLiberi;
    function  InizializzaAccesso:Boolean; override;
    procedure InizializzaBrowseFM;
  public
    TabelleDatiStorici:array of TTabelleDatiStorici;
    NCNuovoElemento,CodNuovoElemento: String;
    bStoricizza:Boolean;
  end;

implementation

{$R *.dfm}

function TWA005FDatiLiberi.InizializzaAccesso: Boolean;
var
  i: Integer;
begin
  Result:=False;
  CodNuovoElemento:=GetParam('CODICE');
  NCNuovoElemento:=GetParam('NOMECAMPO');
  WA115SolaLettura:=SolaLettura;

  for i:=0 to Length(TabelleDatiStorici) - 1 do
  if TabelleDatiStorici[i].NomeCampo = NCNuovoElemento then
  begin
    cmbDatoLibero.ItemIndex:=i;
    break;
  end;
  if cmbDatoLibero.ItemIndex = -1 then
    cmbDatoLibero.ItemIndex:=0;
  cmbDatoLiberoChange(nil);

  if WBrowseFM = nil then
    WBrowseFM:=TWA005FDatiLiberiBrowseFM.Create(Self);

  InizializzaBrowseFM;

  CodNuovoElemento:='';
  Result:=True;
end;

procedure TWA005FDatiLiberi.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.GestioneStoricizzata:=True;
  InterfacciaWR102.DettaglioFM:=False;
  InterfacciaWR102.TemplateAutomatico:=False;

  WR302DM:=TWA005FDatiLiberiDM.Create(Self);
  CaricaDatiLiberi;

//  WBrowseFM.grdTabella.Caption:='Elenco codici ' + cmbDatoLibero.Text;

end;

procedure TWA005FDatiLiberi.CaricaDatiLiberi;
var
  i: Integer;
begin
  SetLength(TabelleDatiStorici,0);
  i:=0;
  with TWA005FDatiLiberiDM(WR302DM).selI500 do
  begin
    Close;
    SetVariable('Nome',Parametri.Layout);
    Open;
    while not Eof do
    begin
      SetLength(TabelleDatiStorici,i + 1);
      TabelleDatiStorici[i].Storico:=FieldByName('STORICO').AsString = 'S';
      TabelleDatiStorici[i].NomeTabelle:='I501' + FieldByName('NOMECAMPO').AsString;
      TabelleDatiStorici[i].NomeCampo:=FieldByName('NOMECAMPO').AsString;
      TabelleDatiStorici[i].Accesso:=FieldByName('ACCESSO').AsString;
      cmbDatoLibero.Items.Add(UpperCase(FieldByName('CAPTION').AsString));
      TabelleDatiStorici[i].Scadenza:=FieldByName('SCADENZA').AsString;
      i:=i + 1;
      Next;
    end;
  end;
  chiudi:=i = 0;
  if chiudi then
  begin
    MsgBox.WebMessageDlg(A000MSG_A005_ERR_NO_DATI,mtError,[mbOk],nil,'');
    exit;
  end;
end;

procedure TWA005FDatiLiberi.cmbDatoLiberoChange(Sender: TObject);
begin
  with TWA005FDatiLiberiDM(WR302DM) do
  begin
    InterfacciaWR102.GestioneStoricizzata:=TabelleDatiStorici[cmbDatoLibero.ItemIndex].Storico;
    if selTabella.VariableIndex('DECORRENZA') >= 0 then
      selTabella.DeleteVariable('DECORRENZA');
    selTabella.Close;
    selTabella.SQL.Clear;
    selTabella.SQL.Add('SELECT I501.*,I501.ROWID FROM ' + TabelleDatiStorici[cmbDatoLibero.ItemIndex].NomeTabelle + ' I501');
    selTabella.SQL.Add('WHERE CODICE <> ''*''');
    //BugFix: PALERMO_POLICLINICO - 160085
    //if TabelleDatiStorici[cmbDatoLibero.ItemIndex].Storico then
    selTabella.SQL.Add(':ORDERBY');
    if TabelleDatiStorici[cmbDatoLibero.ItemIndex].Storico then
      selTabella.SetVariable('ORDERBY','ORDER BY CODICE, DECORRENZA')
    else
      selTabella.SetVariable('ORDERBY','ORDER BY CODICE');

    selTabella.ReadBuffer:=100;
    (*
    SolaLettura:=TabelleDatiStorici[cmbDatoLibero.ItemIndex].Accesso = 'R';
    //Se tutta la funzione è in sola lettura impongo questa condizione indipendentemente dal tipo dato
    if WA115SolaLettura then
      SolaLettura:=WA115SolaLettura;
    selTabella.ReadOnly:=SolaLettura;
    *)
    InterfacciaWR102.AliasNomeTabella:='<I501>';
    // gestione scadenza
    InterfacciaWR102.AllineaSoloDecorrenzeIntersecanti:=TabelleDatiStorici[cmbDatoLibero.ItemIndex].Storico and (TabelleDatiStorici[cmbDatoLibero.ItemIndex].Scadenza = 'S');
    InizializzaDataSet(InterfacciaWR102.Eventi);

    SolaLettura:=TabelleDatiStorici[cmbDatoLibero.ItemIndex].Accesso = 'R';
    //Se tutta la funzione è in sola lettura impongo questa condizione indipendentemente dal tipo dato
    if WA115SolaLettura or (InterfacciaWR102.LChiavePrimaria.Count = 0) then
      SolaLettura:=True;
    selTabella.ReadOnly:=SolaLettura;

    selTabella.Open;

    if TabelleDatiStorici[cmbDatoLibero.ItemIndex].Storico then
    begin
      AttivaGestioneStoricizzazione;
      grdToolBarStorico.Cell[0,0].Css:='invisibile';
      dEdtDataDecorrenza.Css:='invisible';
      grdToolBarStorico.Cell[0,1].Css:='invisibile';
    end
    else
      DisattivaGestioneStoricizzazione;

    InizializzaBrowseFM;

    if actVisioneCorrente.Checked and InterfacciaWR102.GestioneStoricizzata then
    begin
      actVisioneCorrente.Checked:=False;
      actVisioneCorrenteExecute(nil);
    end;
  end;
end;

procedure TWA005FDatiLiberi.imgNuovaStoricizzazioneClick(Sender: TObject);
begin
  inherited;
  bStoricizza:=True;
end;

procedure TWA005FDatiLiberi.InizializzaBrowseFM;
begin
  if WBrowseFM <> nil then
  begin
    //Ricreo ClientDataset e dbgrid
    WBrowseFM.grdTabella.medpCreaColonne;
    TWA005FDatiLiberiDM(WR302DM).selTabella.SearchRecord('CODICE',CodNuovoElemento,[srFromBeginning]);
    if InterfacciaWR102.GestioneStoricizzata then
      CercaStoricoCorrente(Parametri.DataLavoro);
    WBrowseFM.grdTabella.Caption:='Elenco codici ' + cmbDatoLibero.Text;
    WBrowseFM.grdTabella.medpAggiornaCDS(True);
    AggiornaRecord;
  end;
end;

end.
