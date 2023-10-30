unit W011UNotificheElaborazioni;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R012UWEBANAGRAFICO, IWVCLBaseContainer, IWContainer,
  RegistrazioneLog, IWApplication,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompLabel, IWVCLBaseControl, IWBaseControl,
  C190FunzioniGeneraliWeb, Oracle, OracleData,
  A000UInterfaccia, C180FunzioniGenerali,
  IWCompMemo, DB, R010UPAGINAWEB,IWVCLComponent, DBClient,
  IWDBGrids, medpIWDBGrid, IWCompGrids, IWCompExtCtrls, meIWLabel,
  meIWLink, meIWMemo, meIWImageFile,
  IWBaseHTMLControl, IWControl, IWHTMLControls, IWCompButton, meIWButton, IWCompListbox, meIWComboBox;

type
  TW011FNotificheElaborazioni = class(TR012FWebAnagrafico)
    memLog: TmeIWMemo;
    memTesto: TmeIWMemo;
    grdMessaggi: TmedpIWDBGrid;
    dsrT280: TDataSource;
    cdsT280: TClientDataSet;
    lblFiltroTipologia: TmeIWLabel;
    cmbFiltroTipologia: TmeIWComboBox;
    procedure IWAppFormCreate(Sender: TObject);
    procedure btnCancellaClick(Sender: TObject);
    procedure grdMessaggiRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure grdMessaggiAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure cmbFiltroTipologiaChange(Sender: TObject);
  private
    procedure GetMessaggi;
    procedure DBGridColumnClick(ASender: TObject; const AValue: string);
  protected
    procedure GetDipendentiDisponibili(Data:TDateTime);
    procedure VisualizzaDipendenteCorrente; override;
    procedure RefreshPage; override;
    procedure DistruggiOggetti; override;
  public
    function  InizializzaAccesso:Boolean; override;
  end;

implementation

{$R *.dfm}

function TW011FNotificheElaborazioni.InizializzaAccesso:Boolean;
begin
  Result:=True;
  GetDipendentiDisponibili(Parametri.DataLavoro);
  selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]);
  VisualizzaDipendenteCorrente;
end;

procedure TW011FNotificheElaborazioni.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.ini
  grdMessaggi.medpRighePagina:=GetRighePaginaTabella;
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.fine
  grdMessaggi.medpDataSet:=WR000DM.selT280;
  grdMessaggi.medpTestoNoRecord:='Nessun messaggio';
end;

procedure TW011FNotificheElaborazioni.RefreshPage;
begin
  VisualizzaDipendenteCorrente;
end;

procedure TW011FNotificheElaborazioni.GetDipendentiDisponibili(Data:TDateTime);
begin
  ElementoTuttiDip:=True;
  inherited;
end;

procedure TW011FNotificheElaborazioni.VisualizzaDipendenteCorrente;
begin
  inherited;
  // salva parametri
  ParametriForm.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;

  // estrae l'elenco dei messaggi
  GetMessaggi;

  // popola la tabella dei messaggi
  // se ci sono messaggi, seleziona automaticamente la prima riga
  if WR000DM.selT280.RecordCount = 0 then
  begin
    memLog.Text:='';
    memTesto.Text:='';
  end
  else
  begin
    DBGridColumnClick(grdMessaggi,cdsT280.FieldByName('DBG_ROWID').AsString)
  end;
end;

procedure TW011FNotificheElaborazioni.GetMessaggi;
var Filtro:String;
begin
  // estrazione messaggi
  with WR000DM.selT280 do
  begin
    Close;
    if TuttiDipSelezionato then
      Filtro:='exists (select PROGRESSIVO from ' + QVistaOracle + CRLF + WR000DM.FiltroRicerca + CRLF + 'and T030A.PROGRESSIVO = T030.PROGRESSIVO)'
    else
      Filtro:='T030A.PROGRESSIVO = ' + selAnagrafeW.FieldByName('PROGRESSIVO').AsString;

    //Filtro:=StringReplace(Filtro,':DataLavoro','''' + FormatDateTime('dd/mm/yyyy',Parametri.DataLavoro) + '''',[rfIgnoreCase,rfReplaceAll]);
    if VariableIndex('DATALAVORO') >= 0 then
      DeleteVariable('DATALAVORO');
    if Pos(':DATALAVORO',UpperCase(Filtro)) > 0 then
      DeclareAndSet('DATALAVORO',otDate,Parametri.DataLavoro);

    if cmbFiltroTipologia.Items.ValueFromIndex[cmbFiltroTipologia.ItemIndex] <> 'T' then
      Filtro:=Filtro + CRLF + Format('and T280.FLAG = ''%s''',[cmbFiltroTipologia.Items.ValueFromIndex[cmbFiltroTipologia.ItemIndex]]);

    SetVariable('FILTRO_ANAG',Filtro);
    Open;
  end;

  grdMessaggi.medpCreaCDS;
  grdMessaggi.medpEliminaColonne;
  grdMessaggi.medpAggiungiColonna('DBG_COMANDI','','',nil);
  grdMessaggi.medpAggiungiColonna('FLAG','Tipologia','',nil);
  grdMessaggi.medpAggiungiColonna('MATRICOLA','Matricola','',nil);
  grdMessaggi.medpAggiungiColonna('NOMINATIVO','Nominativo','',nil);
  grdMessaggi.medpAggiungiColonna('MITTENTE','Mittente','',nil);
  grdMessaggi.medpAggiungiColonna('DATA','Data','',nil);
  grdMessaggi.medpAggiungiColonna('TITOLO','Titolo','',nil);
  grdMessaggi.medpAggiungiRowClick('DBG_ROWID',DBGridColumnClick);
  grdMessaggi.medpColonna('MATRICOLA').Visible:=TuttiDipSelezionato;
  grdMessaggi.medpColonna('NOMINATIVO').Visible:=TuttiDipSelezionato;

  grdMessaggi.medpInizializzaCompGriglia;
  if not SolaLettura then
    grdMessaggi.medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','CANCELLA','null','null');
  grdMessaggi.medpCaricaCDS;
end;

procedure TW011FNotificheElaborazioni.grdMessaggiAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var i:Integer;
begin
  if not SolaLettura then
  begin
    // imposta evento per gestire cancellazione messaggio
    for i:=0 to High(grdMessaggi.medpCompGriglia) do
    begin
      (grdMessaggi.medpCompCella(i,0,0) as TmeIWImageFile).OnClick:=btnCancellaClick;
    end;
  end;
end;

procedure TW011FNotificheElaborazioni.grdMessaggiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna,FlagMsg: Integer;
  Campo: String;
begin
  if not (ACell.Grid as TmedpIWDBGrid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  // assegnazione componenti
  if (ARow > 0) and (ARow <= High(grdMessaggi.medpCompGriglia) + 1) then
  begin
    if grdMessaggi.medpCompGriglia[ARow - 1].CompColonne[AColumn] <> nil then
    begin
      ACell.Text:='';
      ACell.Control:=grdMessaggi.medpCompGriglia[ARow - 1].CompColonne[AColumn];
    end
    else
    begin
      ACell.ShowHint:=True;
      NumColonna:=grdMessaggi.medpNumColonna(AColumn);
      Campo:=grdMessaggi.medpColonna(NumColonna).DataField;
      if Campo = 'FLAG' then
      begin
        ACell.Css:=ACell.Css + ' align_center';
        FlagMsg:=StrToInt(grdMessaggi.medpValoreColonna(ARow - 1,'FLAG'));
        case FlagMsg of
          0: ACell.Text:='Elaborazione OK';//ACell.Hint:='Elaborazione OK';
          1: begin
               ACell.Text:='Elaborazione FALLITA';//ACell.Hint:='Elaborazione FALLITA';
               ACell.Css:=ACell.Css + ' font_grassetto font_rosso';
             end;
          2: begin
               ACell.Text:='Richiesta non autorizzata';//ACell.Hint:='Richiesta non autorizzata';
               ACell.Css:=ACell.Css + ' font_grassetto font_rosso';
             end;
          3: ACell.Text:='Messaggi per email';//ACell.Hint:='Messaggi per email';
          4: ACell.Text:='Elaborazione OK (richiesta compensata)';//ACell.Hint:='Elaborazione OK (richiesta compensata)';
         end;
      end
      else if (Campo = 'MITTENTE') or (Campo = 'DATA') then
      begin
        ACell.Css:=ACell.Css + ' align_center';
      end
      else if Campo = 'TITOLO' then
      begin
        ACell.Css:=ACell.Css + ' fontcourier';
      end
    end;
  end;
end;

procedure TW011FNotificheElaborazioni.cmbFiltroTipologiaChange(Sender: TObject);
begin
  inherited;
  GetMessaggi;
end;

procedure TW011FNotificheElaborazioni.DBGridColumnClick(ASender: TObject; const AValue: string);
begin
  inherited;
  cdsT280.Locate('DBG_ROWID',AValue,[]);
  memLog.Lines.Clear;
  memTesto.Lines.Clear;
  memLog.FriendlyName:=AValue;
  memLog.Lines.Add(cdsT280.FieldByName('LOG').AsString);
  memTesto.Lines.Add(cdsT280.FieldByName('TESTO').AsString);
end;

procedure TW011FNotificheElaborazioni.btnCancellaClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  with WR000DM.selT280 do
  begin
    if SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      DBGridColumnClick(Sender,FN);
      Edit;
      FieldByName('FLAG').AsString:='';
      try
        RegistraLog.SettaProprieta('C','T280_MESSAGGIWEB',medpCodiceForm,WR000DM.selT280,True);
        Post;
        RegistraLog.RegistraOperazione;
      except
        Cancel;
      end;
      SessioneOracle.Commit;
    end;
  end;
  VisualizzaDipendenteCorrente;
end;

procedure TW011FNotificheElaborazioni.DistruggiOggetti;
begin
  if (GGetWebApplicationThreadVar <> nil) and
     (GGetWebApplicationThreadVar.Data <> nil) then
  begin
    try WR000DM.selT280.CloseAll; except end;
  end;
end;

end.
