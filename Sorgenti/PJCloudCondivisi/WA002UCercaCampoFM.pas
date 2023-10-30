unit WA002UCercaCampoFM;

interface

uses
  Windows, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR200UBaseFM, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompButton, meIWButton,WR100UBase, IWCompEdit,
  meIWEdit, IWCompLabel, meIWLabel, meIWLink,StrUtils,A000UInterfaccia,
  IWCompGrids, meIWGrid, IWDBGrids, meIWDBGrid,DB, medpIWDBGrid,A000UMessaggi,
  medpIWMessageDlg,IWApplication;

type
  TWA002FCercaCampoFM = class(TWR200FBaseFM)
    btnChiudi: TmeIWButton;
    lblNomeCampo: TmeIWLabel;
    edtNomeCampo: TmeIWEdit;
    btnCerca: TmeIWButton;
    grdElenco: TmedpIWDBGrid;
    procedure btnChiudiClick(Sender: TObject);
    procedure btnCercaAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdElencoRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure edtNomeCampoSubmit(Sender: TObject);
  private
    IdComponenteEvidenzia: Integer;
    InibisciClick: Boolean;
    procedure DBGridElencoClick(ASender: TObject; const AValue: string);
  public
    procedure Visualizza;
  end;

implementation  uses WA002UAnagrafe, WA002UAnagrafeDettFM,WA002UAnagrafeDM;

{$R *.dfm}

{ TWA002FCercaCampoFM }
procedure TWA002FCercaCampoFM.IWFrameRegionCreate(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  with TWA002FAnagrafeDM(TWA002FAnagrafe(Self.Owner).WR302DM) do
  begin
    cdsElencoCampi.CreateDataSet;
    cdsElencoCampi.LogChanges:=False;
    cdsElencoCampi.IndexDefs.Clear;
    cdsElencoCampi.IndexDefs.Add('Ordina',('IDPAGINA;NOMEDATO'),[ixPrimary,ixUnique]);
    cdsElencoCampi.IndexName:='Ordina';
    grdElenco.medpRowIdField:='IDCOMPONENTE';
    grdElenco.DataSource:=cdsrGridCercaCampo;
    grdElenco.medpDataSet:=cdsElencoCampi;
  end;
  //inizializzazione tabella
  grdElenco.medpBrowse:=True;
  grdElenco.medpCreaCDS;
  //Impostazione delle colonne da visualizzare sulla DBGrid
  grdElenco.medpEliminaColonne;

  for i:=0 to grdElenco.medpDataSet.FieldCount - 1 do
  begin
    grdElenco.medpAggiungiColonna(grdElenco.medpDataSet.Fields[i].FieldName,grdElenco.medpDataSet.Fields[i].DisplayLabel,'',nil,nil);
    grdElenco.medpColonna(grdElenco.medpDataSet.Fields[i].FieldName).Visible:=grdElenco.medpDataSet.Fields[i].Visible;
  end;

  grdElenco.medpAggiungiRowClick('DBG_ROWID',DBGridElencoClick);
  
  grdElenco.medpInizializzaCompGriglia;
  grdElenco.RigaInserimento:=False;
end;

procedure TWA002FCercaCampoFM.Visualizza;
begin
  //inizializzazione
  idComponenteEvidenzia:=-1;
  //Uso il css per rendere invisibile la grid
  grdElenco.css:='invisibile';
  InibisciClick:=True;
  TWR100FBase(Self.Parent).VisualizzaJQMessaggio(jQuery,600,150,500, 'Ricerca per testo contenuto','#wa002_container',False,True,-1);
end;

procedure TWA002FCercaCampoFM.btnCercaAsyncClick(Sender: TObject;
  EventParams: TStringList);
var
  i,
  NewHeight: Integer;
  DatoSearch,
  Etichetta,
  NomeCampo,
  Ridefinito: String;
begin
  DatoSearch:=UpperCase(Trim(edtNomeCampo.Text));
  with TWA002FAnagrafeDM(TWA002FAnagrafe(Self.Owner).WR302DM).cdsElencoCampi do
  begin
    Open;
    Append;
    EmptyDataSet;
  end;

  with TWA002FAnagrafeDettFM(TWA002FAnagrafe(Self.owner).WDettaglioFM) do
  begin
    for i:=0 to Length(ComponentiLayout) -1 do
    begin
      if ComponentiLayout[i].Componenti[0].Visible then
      begin
        //Per ogni campo visibile, prendo i dati necessari
        if (ComponentiLayout[i].EtichettaComponente <> nil) then
          Etichetta:=TIWBaseHTMLControl(ComponentiLayout[i].EtichettaComponente ).Caption
        else
          Etichetta:=TIWBaseHTMLControl(ComponentiLayout[i].Componenti[0]).Caption;

        NomeCampo:=IfThen(ComponentiLayout[i].isT430,'T430','') + ComponentiLayout[i].NomeCampo;
        Ridefinito:=VarToStr(WR000DM.cdsI010.Lookup('NOME_CAMPO',NomeCampo,'NOME_LOGICO'));

        if (Pos(DatoSearch,UpperCase(Etichetta)) > 0) or
           (Pos(DatoSearch,UpperCase(NomeCampo)) > 0) or
           (Pos(DatoSearch,UpperCase(Ridefinito)) > 0) then
        begin
          with TWA002FAnagrafeDM(TWA002FAnagrafe(Self.Owner).WR302DM).cdsElencoCampi do
          begin
            Append;
            FieldByName('ETICHETTA').AsString:=Etichetta;
            FieldByName('NOMEDATO').AsString:=NomeCampo;
            FieldByName('RIDEFINITO').AsString:=Ridefinito;
            FieldByName('PAGINA').AsString:=ComponentiLayout[i].NomePagina;
            FieldByName('IDPAGINA').AsInteger:=getIdPagina(ComponentiLayout[i].NomePagina);
            FieldByName('IDCOMPONENTE').AsInteger:=i;
            Post;
          end;
        end;
      end;
    end;
  end;

  with TWA002FAnagrafeDM(TWA002FAnagrafe(Self.Owner).WR302DM) do
  begin
    if (cdsElencoCampi.RecordCount = 0) then
      //A000App.ShowMessage(Format(A000MSG_A002_ERR_FMT_CERCA_NO_CAMPO,[DatoSearch]))
      GGetWebApplicationThreadVar.ShowMessage(Format(A000MSG_A002_ERR_FMT_CERCA_NO_CAMPO,[DatoSearch]))
    else if (cdsElencoCampi.RecordCount = 1) then
    begin
      cdsElencoCampi.First;
      idComponenteEvidenzia:=cdsElencoCampi.FieldByName('IDCOMPONENTE').AsInteger;
      if GGetWebApplicationThreadVar.IsCallBack then
        GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecute('SubmitClick("'+btnChiudi.HTMLName+'", "", true);')
      else
        btnChiudiClick(nil);
    end
    else
    begin
      cdsElencoCampi.Close;
      cdsElencoCampi.Open;
      //Carica grid selezione
      //Uso il css per rendere visibile la grid
      grdElenco.css:='grid';
      //WorkAround. la proprietà visible serve solo per far si che sugli eventi ajax
      //intraweb capisca che deve resituire anche le proprietà della grid
      grdElenco.Visible:=True;
      InibisciClick:=True;
      grdElenco.medpCaricaCDS;
      InibisciClick:=False;

      NewHeight:=150 + (cdsElencoCampi.RecordCount * 20);
      if NewHeight > 400 then
        NewHeight:=400;

      if GGetWebApplicationThreadVar.IsCallBack then
        GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA('$("#wa002_container" ).dialog( "option", "height", ' + IntToStr(NewHeight) + ' );')
      else
        (Self.Parent as TWR100FBase).AddToInitProc('$("#wa002_container" ).dialog( "option", "height", ' + IntToStr(NewHeight) + ' );')
    end;
  end;
end;

procedure TWA002FCercaCampoFM.btnChiudiClick(Sender: TObject);
var
  evidenzia: String;
begin
  (* evidenzia campo trovato.
  il cambio della classe css deve avvenire via javascript per poter essere annullato da una successiva operazione.
  se cambio css del componente un successivo render della pagina manterrebbe il css modificato e non quello originale.
  Eseguito sul chiudi perchè dopo asyn è necessario submitclick per chiusura che annulla il javascript nella init
  *)
  if idComponenteEvidenzia >=0 then
  begin
    with TWA002FAnagrafeDettFM(TWA002FAnagrafe(Self.owner).WDettaglioFM) do
    begin
      //Seleziono tab dettaglio
      TWA002FAnagrafe(Self.owner).grdTabControl.ActiveTab:=TWA002FAnagrafe(Self.owner).WDettaglioFM;
      //Seleziono tab padre
      grdTabDetail.ActiveTab:=ComponentiLayout[idComponenteEvidenzia].Componenti[0].Parent;
      //evidenzio etichetta
      if (ComponentiLayout[idComponenteEvidenzia].EtichettaComponente <> nil) then
        evidenzia:=TIWBaseHTMLControl(ComponentiLayout[idComponenteEvidenzia].EtichettaComponente).HTMLName
      else
        evidenzia:=TIWBaseHTMLControl (ComponentiLayout[idComponenteEvidenzia].Componenti[0]).HTMLName;
      //EVIDENZA
      TWA002FAnagrafe(Self.owner).addToInitProc('$("#'+evidenzia +'").addClass("shadow");');
    end;
  end;
  with TWA002FAnagrafeDM(TWA002FAnagrafe(Self.Owner).WR302DM).cdsElencoCampi do
  begin
    EmptyDataset;
    Close();
  end;
  ReleaseOggetti;
  Free;
end;

procedure TWA002FCercaCampoFM.DBGridElencoClick(ASender: TObject;
  const AValue: string);
begin
  grdElenco.medpClientDataSet.Locate('DBG_ROWID',AValue,[]);
  if InibisciClick then
    exit;
  idComponenteEvidenzia:=grdElenco.medpClientDataSet.FieldByName('IDCOMPONENTE').AsInteger;
  btnChiudiClick(nil);
end;

procedure TWA002FCercaCampoFM.edtNomeCampoSubmit(Sender: TObject);
begin
  btnCercaAsyncClick(nil,nil);
end;

procedure TWA002FCercaCampoFM.grdElencoRenderCell(ACell: TIWGridCell;
  const ARow, AColumn: Integer);
begin
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,False) then
    Exit;
end;

end.
