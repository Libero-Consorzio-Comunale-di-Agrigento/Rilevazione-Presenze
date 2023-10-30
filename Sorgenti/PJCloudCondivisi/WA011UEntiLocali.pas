unit WA011UEntiLocali;

interface

uses
  WA011UEntiLocaliBrowseFM, WA011UEntiLocaliDM,
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWControl,
  Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWCompEdit, IWHTMLControls, meIWLink,
  ActnList, Menus, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompMenu, IWCompLabel,
  A000UInterfaccia, A000UCostanti, A000USessione, WR100UBase,
  IWCompTabControl, Forms, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion,
  IWCompButton, WR102UGestTabella, C190FunzioniGeneraliWeb,
  IWDBStdCtrls, meIWLabel, WR302UGestTabellaDM, meIWButton, meIWDBNavigator,
  meIWGrid, medpIWTabControl, medpIWStatusBar, IWAdvRadioGroup,
  IWCompListbox, meIWComboBox, Oracle, ORacleData, medpIWMessageDlg, StrUtils,
  meIWEdit, meTIWAdvRadioGroup, IWCompGrids, DB,
  IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, System.Actions, meIWImageFile;


type
  TWA011FEntiLocali = class(TWR102FGestTabella)
    lblElenco: TmeIWLabel;
    cmbElenco: TmeIWComboBox;
    rgpTipoSelezione: TmeTIWAdvRadioGroup;
    procedure IWAppFormCreate(Sender: TObject);
    procedure cmbElencoChange(Sender: TObject);
    procedure rgpTipoSelezioneClick(Sender: TObject);
  private
    function InizializzaAccesso:Boolean; override;
  public
    TipoTabella,CodTabella: String;
    procedure selTabellaStateChange(Dataset:TDataset); override;
  end;

implementation

{$R *.dfm}

procedure TWA011FEntiLocali.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.GestioneStoricizzata:=False;
  InterfacciaWR102.DettaglioFM:=False;
  InterfacciaWR102.TemplateAutomatico:=False;
  InterfacciaWR102.ChiaveReadOnly:=True;
  WR302DM:=TWA011FEntiLocaliDM.Create(Self);
  cmbElenco.ItemIndex:=0;
  cmbElencoChange(nil);
  rgpTipoSelezioneClick(nil);
  WBrowseFM:=TWA011FEntiLocaliBrowseFM.Create(Self);
  TWA011FEntiLocaliBrowseFM(WBrowseFM).PreparaComponenti(cmbElenco.Text);
end;

function TWA011FEntiLocali.InizializzaAccesso: Boolean;
var TipoComune: String;
begin
  Result:=False;
  TipoTabella:=GetParam('TIPOARCHIVIO');
  CodTabella:=GetParam('CODICE');
  TipoComune:=GetParam('TIPOCOMUNE');
  with TWA011FEntiLocaliDM(WR302DM) do
  begin
    if TipoTabella = 'R' then
    begin
      cmbElenco.ItemIndex:=2;
      cmbElencoChange(nil);
      selTabella.SearchRecord('COD_REGIONE',CodTabella,[srFromBeginning]);
    end
    else if TipoTabella = 'P' then
    begin
      cmbElenco.ItemIndex:=1;
      cmbElencoChange(nil);
      selTabella.SearchRecord('COD_PROVINCIA',CodTabella,[srFromBeginning]);
    end
    else if TipoTabella = 'N' then
    begin
      cmbElenco.ItemIndex:=3;
      cmbElencoChange(nil);
      selTabella.SearchRecord('COD_NAZIONE',CodTabella,[srFromBeginning]);
    end
    else
    begin
      if (TipoComune = '') or (TipoComune = 'R') then
      begin
        rgpTipoSelezione.ItemIndex:=0;
        WR302DM.selTabella.SetVariable('TipoSelezione','R');
      end
      else
      begin
        rgpTipoSelezione.ItemIndex:=1;
        WR302DM.selTabella.SetVariable('TipoSelezione','T');
      end;
      cmbElenco.ItemIndex:=0;
      cmbElencoChange(nil);
      selTabella.SearchRecord('CODICE',CodTabella,[srFromBeginning]);
    end;
  end;
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  Result:=True;
end;

procedure TWA011FEntiLocali.rgpTipoSelezioneClick(Sender: TObject);
var Cod,TipoSelezione: String;
begin
  with TWA011FEntiLocaliDM(WR302DM) do
  begin
    Cod:=selTabella.FieldByName('CODICE').AsString;
    if rgpTipoSelezione.ItemIndex = 0 then
      TipoSelezione:='R'
    else
      TipoSelezione:='T';
    if selTabella.GetVariable('TipoSelezione') <> TipoSelezione then
    begin
      selTabella.SetVariable('TipoSelezione',TipoSelezione);
      selTabella.Close;
      selTabella.Open;
      selTabella.SearchRecord('CODICE',Cod,[srFromBeginning]);
    end;
  end;
  if WBrowseFM <> nil then
    WBrowseFM.grdTabella.medpAggiornaCDS(True);
end;

procedure TWA011FEntiLocali.selTabellaStateChange;
begin
  inherited;
  if (TWA011FEntiLocaliDM(WR302DM)) <> nil then
    with (TWA011FEntiLocaliDM(WR302DM)) do
    begin
      cmbElenco.Enabled:=not (selTabella.State in [dsEdit,dsInsert]);
      rgpTipoSelezione.Enabled:=not (selTabella.State in [dsEdit,dsInsert]);
    end;
end;

procedure TWA011FEntiLocali.cmbElencoChange(Sender: TObject);
begin
  with TWA011FEntiLocaliDM(WR302DM) do
  begin
    if cmbElenco.Text = 'COMUNI' then
    begin
      selTabella:=T480;
      selTabella.SetVariable('ORDERBY','ORDER BY CITTA');
      rgpTipoSelezione.Visible:=True;
    end
    else if cmbElenco.Text = 'PROVINCE' then
    begin
      selTabella:=T481;
      selTabella.SetVariable('ORDERBY','ORDER BY COD_PROVINCIA');
      rgpTipoSelezione.Visible:=False;
    end
    else if cmbElenco.Text = 'NAZIONI' then
    begin
      selTabella:=T483;
      selTabella.SetVariable('ORDERBY','ORDER BY COD_NAZIONE');
      rgpTipoSelezione.Visible:=False;
    end
    else
    begin
      selTabella:=T482;
      selTabella.SetVariable('ORDERBY','ORDER BY COD_REGIONE');
      rgpTipoSelezione.Visible:=False;
    end;

    selTabella.Close;
    selTabella.Open;
    InizializzaDataSet(InterfacciaWR102.Eventi);
    A011FEntiLocaliMW.selEnte:=selTabella;
    if WBrowseFM <> nil then
    begin
      TWA011FEntiLocaliBrowseFM(WBrowseFM).grdTabella.medpDataSet:=selTabella;
      TWA011FEntiLocaliBrowseFM(WBrowseFM).grdTabella.medpInizializzaCompGriglia(True);
      TWA011FEntiLocaliBrowseFM(WBrowseFM).grdTabella.medpCreaColonne;
      TWA011FEntiLocaliBrowseFM(WBrowseFM).PreparaComponenti(cmbElenco.Text);
    end;
  end;
end;

end.
