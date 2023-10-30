unit WA100UDettaglioGGFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR203UGestDetailFM, System.Actions,
  Vcl.ActnList, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompGrids, meIWGrid, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion,OracleData, DB, C190FunzioniGeneraliWeb,
  meIWEdit, Vcl.Menus, medpIWMultiColumnComboBox, A000UInterfaccia;

type
  TWA100FDettaglioGGFM = class(TWR203FGestDetailFM)
    pmnGrdTabellaDettFiglio: TPopupMenu;
    actEseguiOpzione: TMenuItem;
    Aggiornagiustificatividaserviziattivi2: TMenuItem;
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure grdTabellaComponenti2DataSet(Row: Integer);
    procedure Aggiornagiustificativi1Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure CaricaDettaglio(DataSet:TDataSet;DataSource:TDataSource); override;
  end;

implementation

uses
  WA100UMissioniDM;

{$R *.dfm}

{ TWA100FDettaglioGGFM }

procedure TWA100FDettaglioGGFM.Aggiornagiustificativi1Click(Sender: TObject);
begin
  inherited;
  with (WR302DM as TWA100FMissioniDM).A100FMissioniMW do
  begin
    AggGiustServiziAttivi;
    if USR_M043P_CARICA_GIUST.GetVariable('AGGIORNA') <> 'E' then
      MsgBox.AddMessage('I giustificativi sul cartellino sono stati aggiornati.')
    else
      MsgBox.AddMessage('I giustificativi sul cartellino non sono stati aggiornati in quanto bloccati o per anomalia della funzione di aggiornamento.');
  end;
  MsgBox.ShowMessages;
end;

procedure TWA100FDettaglioGGFM.CaricaDettaglio(DataSet: TDataSet; DataSource: TDataSource);
begin
  inherited;
  // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#1.ini
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('TIPO'),0,DBG_MECMB,'1','2','null','','S');
  // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#1.fine
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('DATA'),0,DBG_EDT,'DATA','10','null','','S');
end;

procedure TWA100FDettaglioGGFM.grdTabellaComponenti2DataSet(Row: Integer);
begin
  inherited;
  // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#1.ini
  with (WR302DM as TWA100FMissioniDM).A100FMissioniMW do
  begin
    // tipo
    selM043.FieldByName('TIPO').AsString:=(grdTabella.medpCompCella(Row,'TIPO',0) as TmedpIWMultiColumnComboBox).Text;
  end;
  // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#1.fine
end;

procedure TWA100FDettaglioGGFM.grdTabellaDataSet2Componenti(Row: Integer);
begin
  inherited;

  // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#1.ini
  // tipo
  with (grdTabella.medpCompCella(Row,'TIPO',0) as TmedpIWMultiColumnComboBox) do
  begin
    Tag:=Row;
    Items.Clear;
    AddRow(Format('%s;%s',['S','Servizio attivo']));
    AddRow(Format('%s;%s',['V','Ore di viaggio']));
    Text:=grdTabella.medpValoreColonna(Row,'TIPO');
  end;
  // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#1.fine

  //Data
  with(grdTabella.medpCompCella(Row,'DATA',0) as TmeIWEdit) do
  begin
    ReadOnly:=WR302DM.selTabella.FieldByName('DATADA').AsDateTime = WR302DM.selTabella.FieldByName('DATAA').AsDateTime;
  end;
end;

end.
