unit WA177UFerieSolidaliDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, WR100UBase,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, DB, IWCompLabel, meIWLabel,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompExtCtrls,
  IWDBExtCtrls, meIWDBRadioGroup, medpIWMultiColumnComboBox, IWHTMLControls,
  meIWLink, IWCompEdit, IWDBStdCtrls, meIWDBEdit, meIWDBLabel, IWCompButton, OracleData,
  meIWButton, meIWEdit, C180FunzioniGenerali, StrUtils, Math, A000UMessaggi, WC015USelEditGridFM;

type
  TWA177FFerieSolidaliDettFM = class(TWR205FDettTabellaFM)
    drgpUMisura: TmeIWDBRadioGroup;
    lblUMisura: TmeIWLabel;
    drgpTipo: TmeIWDBRadioGroup;
    lblTipo: TmeIWLabel;
    lblDescRaggruppamento: TmeIWLabel;
    lblDecorrenza: TmeIWLabel;
    lblScadenza: TmeIWLabel;
    dedtDecorrenza: TmeIWDBEdit;
    dedtScadenza: TmeIWDBEdit;
    lnkRaggruppamento: TmeIWLink;
    cmbRaggruppamento: TMedpIWMultiColumnComboBox;
    dedtAnno: TmeIWDBEdit;
    lblAnno: TmeIWLabel;
    lblIDRichiesta: TmeIWLabel;
    dedtIDRichiesta: TmeIWDBEdit;
    dedtDescrizione: TmeIWDBEdit;
    lblDescrizione: TmeIWLabel;
    btnIDRichiesta: TmeIWButton;
    lblDescCausale: TmeIWLabel;
    cmbCausale: TMedpIWMultiColumnComboBox;
    lnkCausale: TmeIWLink;
    dedtQuantitaRichiesta: TmeIWDBEdit;
    lblQuantitaRichiesta: TmeIWLabel;
    dedtQuantitaOttenuta: TmeIWDBEdit;
    lblQuantitaOttenuta: TmeIWLabel;
    dedtQuantitaOfferta: TmeIWDBEdit;
    lblQuantitaOfferta: TmeIWLabel;
    dedtQuantitaAccettata: TmeIWDBEdit;
    lblQuantitaAccettata: TmeIWLabel;
    lblTotOfferte: TmeIWLabel;
    edtTotOfferte: TmeIWEdit;
    btnVisOfferte: TmeIWButton;
    drgpStato: TmeIWDBRadioGroup;
    lblStato: TmeIWLabel;
    dedtTermineDiritto: TmeIWDBEdit;
    lblTermineDiritto: TmeIWLabel;
    dedtQuantitaRestituita: TmeIWDBEdit;
    lblQuantitaRestituita: TmeIWLabel;
    procedure drgpTipoClick(Sender: TObject);
    procedure lnkRaggruppamentoClick(Sender: TObject);
    procedure lnkCausaleClick(Sender: TObject);
    procedure cmbRaggruppamentoChange(Sender: TObject; Index: Integer);
    procedure cmbCausaleChange(Sender: TObject; Index: Integer);
    procedure btnVisOfferteClick(Sender: TObject);
    procedure btnIDRichiestaClick(Sender: TObject);
    procedure drgpUMisuraClick(Sender: TObject);
  private
    { Private declarations }
    procedure ImpostaMask;
    procedure DatoSelezionato(Sender: TObject; Result: Boolean);
  public
    { Public declarations }
    procedure AbilitaComponenti; override;
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
    procedure CaricaMultiColumnCombobox; override;
  end;

implementation

{$R *.dfm}

uses WA177UFerieSolidali, WA177UFerieSolidaliDM;

{ TWA177FFerieSolidaliDettFM }

procedure TWA177FFerieSolidaliDettFM.AbilitaComponenti;
var TotOfferte:Real;
begin
  inherited;
  with (Self.Owner as TWA177FFerieSolidali), (WR302DM as TWA177FFerieSolidaliDM) do
  begin
    drgpStato.Enabled:=False;
    dedtTermineDiritto.Enabled:=False;
    dedtQuantitaRestituita.Enabled:=False;
    drgpUMisura.Enabled:=False;
    dedtQuantitaOttenuta.Enabled:=False;
    dedtQuantitaAccettata.Enabled:=False;
    edtTotOfferte.Enabled:=False;

    actModifica.Enabled:=(not SolaLettura) and (selTabella.State = dsBrowse) and (selTabella.FieldByName('ID_RICHIESTA').AsInteger <> -1) and (selTabella.FieldByName('STATO').AsString = 'A');
    actElimina.Enabled:=(not SolaLettura) and (selTabella.State = dsBrowse) and (selTabella.FieldByName('STATO').AsString = 'A');
    AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
    lblDescCausale.Caption:='';
    lblDescRaggruppamento.Caption:='';
    lblDescrizione.Caption:='';

    drgpTipo.Enabled:=selTabella.State = dsInsert;
    dedtAnno.Enabled:=selTabella.State = dsInsert;
    dedtDecorrenza.Enabled:=selTabella.State = dsInsert;
    cmbRaggruppamento.Enabled:=selTabella.State = dsInsert;
    cmbCausale.Enabled:=selTabella.State = dsInsert;
    dRgpUMisura.Enabled:=selTabella.State = dsInsert;

    lblScadenza.Visible:=selTabella.FieldByName('TIPO').AsString = 'R'; //Richiesta
    dedtScadenza.Visible:=selTabella.FieldByName('TIPO').AsString = 'R'; //Richiesta
    dedtDescrizione.Visible:=selTabella.FieldByName('TIPO').AsString = 'R'; //Richiesta
    lblQuantitaRichiesta.Visible:=selTabella.FieldByName('TIPO').AsString = 'R'; //Richiesta
    dedtQuantitaRichiesta.Visible:=selTabella.FieldByName('TIPO').AsString = 'R'; //Richiesta
    lblQuantitaOttenuta.Visible:=selTabella.FieldByName('TIPO').AsString = 'R'; //Richiesta
    dedtQuantitaOttenuta.Visible:=selTabella.FieldByName('TIPO').AsString = 'R'; //Richiesta
    lblTotOfferte.Visible:=selTabella.FieldByName('TIPO').AsString = 'R'; //Richiesta
    edtTotOfferte.Visible:=selTabella.FieldByName('TIPO').AsString = 'R'; //Richiesta
    btnVisOfferte.Visible:=selTabella.FieldByName('TIPO').AsString = 'R'; //Richiesta
    btnVisOfferte.Enabled:=selTabella.State = dsBrowse;

    btnIDRichiesta.Visible:=selTabella.FieldByName('TIPO').AsString = 'O'; //Offerta
    btnIDRichiesta.Enabled:=selTabella.State = dsInsert;
    lblQuantitaOfferta.Visible:=selTabella.FieldByName('TIPO').AsString = 'O'; //Offerta
    dedtQuantitaOfferta.Visible:=selTabella.FieldByName('TIPO').AsString = 'O'; //Offerta
    lblQuantitaAccettata.Visible:=selTabella.FieldByName('TIPO').AsString = 'O'; //Offerta
    dedtQuantitaAccettata.Visible:=selTabella.FieldByName('TIPO').AsString = 'O'; //Offerta

    with A177MW do
    begin
      if selTabella.FieldByName('TIPO').AsString = 'R' then  //Se richiesta propongo raggruppamenti 'Ferie solidali'
      begin
        lblDescrizione.Font.Color:=clBlue;
        lblDescrizione.Caption:='Descrizione';
        //Conteggio il totale delle offerte legate a questo ID_Richiesta
        TotOfferte:=0;
        R180SetVariable(selT254a,'ID_RICHIESTA',selT254.FieldByName('ID_RICHIESTA').AsInteger);
        R180SetVariable(selT254a,'ORDINAMENTO','T030.COGNOME, T030.NOME, T030.MATRICOLA, T254.DECORRENZA, T254.CODRAGGR');
        R180SetVariable(selT254a,'DATI','');
        selT254a.Open;
        selT254a.Refresh;
        selT254a.First;
        while not selT254a.Eof do
        begin
          if selT254a.FieldByName('UMISURA').AsString = 'G' then
            TotOfferte:=TotOfferte + StrToFloat(selT254a.FieldByName('QUANTITA_OFFERTA').AsString)
          else
            TotOfferte:=TotOfferte + R180OreMinutiExt(selT254a.FieldByName('QUANTITA_OFFERTA').AsString);
          selT254a.Next;
        end;
        edtTotOfferte.Text:=IfThen(selT254.FieldByName('UMISURA').AsString = 'G',FloatToStr(TotOfferte),R180MinutiOre(Trunc(TotOfferte)));
      end
      else  //Se offerta propongo raggruppamenti 'Congedo ordinario' e 'Festività soppresse'
      begin
        lblDescrizione.Font.Color:=clBlack;
        lblDescrizione.Caption:=selT254.FieldByName('DESCR_OFFERTA').AsString;
      end;
    end;
    cmbRaggruppamentoChange(nil,0);
    cmbCausaleChange(nil,0);

    chkAggiornaQuantita.Enabled:=(not SolaLettura) and (selTabella.FieldByName('TIPO').AsString = 'R') and (selTabella.State = dsBrowse) and (selTabella.FieldByName('STATO').AsString = 'A'); //Richiesta-Aperta
    if not chkAggiornaQuantita.Enabled then
      chkAggiornaQuantita.Checked:=False;
    chkAzzeraQuantita.Enabled:=(not SolaLettura) and (selTabella.FieldByName('TIPO').AsString = 'R') and (selTabella.State = dsBrowse) and (selTabella.FieldByName('STATO').AsString = 'C'); //Richiesta-Chiusa
    if not chkAzzeraQuantita.Enabled then
      chkAzzeraQuantita.Checked:=False;
    chkAggiornaProfili.Enabled:=(not SolaLettura) and (selTabella.FieldByName('TIPO').AsString = 'R') and (selTabella.State = dsBrowse) and (selTabella.FieldByName('STATO').AsString = 'C'); //Richiesta-Chiusa
    if not chkAggiornaProfili.Enabled then
      chkAggiornaProfili.Checked:=False;
    chkImpostaTermine.Enabled:=(not SolaLettura) and (selTabella.FieldByName('TIPO').AsString = 'R') and (selTabella.State = dsBrowse) and (selTabella.FieldByName('STATO').AsString = 'F') and (selTabella.FieldByName('TERMINE_DIRITTO').IsNull); //Richiesta-Fruibile
    if not chkImpostaTermine.Enabled then
      chkImpostaTermine.Checked:=False;
    btnEsegui.Enabled:=chkAggiornaQuantita.Checked or chkAzzeraQuantita.Checked or chkAggiornaProfili.Checked or chkImpostaTermine.Checked;
  end;
end;

procedure TWA177FFerieSolidaliDettFM.btnIDRichiestaClick(Sender: TObject);
var WC015: TWC015FSelEditGridFM;
begin
  inherited;
  with (WR302DM as TWA177FFerieSolidaliDM).A177MW do
  begin
    //Proporre elenco di tutte le richieste valide (decorrenza offerta between decorrenza-scadenza richiesta) che non sono ancora state caricate sul dip.corrente
    //Proporre opzione 'TUTTE' di modo che si possa indicare che l'offerta è valida per tutte le richieste (ID_RICHIESTA sarà -1)
    R180SetVariable(selT254Rich,'DEC_OFFERTA',StrToDate(dedtDecorrenza.Text));
    R180SetVariable(selT254Rich,'PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    R180SetVariable(selT254Rich,'UMISURA',drgpUMisura.Values[drgpUMisura.ItemIndex]);
    selT254Rich.Open;
    selT254Rich.Refresh;
    if selT254Rich.RecordCount <= 1 then   //1 record c'è per id_richiesta -1 (tutte) quindi deve essercene almeno un'altra
    begin
      selT254.FieldByName('UMISURA').FocusControl;
      raise Exception.Create(A000MSG_A177_ERR_OFF_UMISURA);  //Alla decorrenza specificata, non sono presenti richieste aperte valide con questa unità di misura!
    end;
    WC015:=TWC015FSelEditGridFM.Create(Self.Owner);
    selT254Rich.First;
    WC015.medpSearchKind:=skContent;
    WC015.medpSearchField:='ID_RICHIESTA';
    WC015.ResultEvent:=DatoSelezionato;
    WC015.Visualizza('Scelta richiesta ferie solidali',selT254Rich,False,False,True,500);
  end;
end;

procedure TWA177FFerieSolidaliDettFM.DatoSelezionato(Sender: TObject; Result: Boolean);
begin
  //Ritorna il codice voce selezionato
  with (WR302DM as TWA177FFerieSolidaliDM) do
    if Result then
    begin
      selTabella.FieldByName('ID_RICHIESTA').AsInteger:=A177MW.selT254Rich.FieldByName('ID_RICHIESTA').AsInteger;
      lblDescrizione.Caption:=A177MW.selT254Rich.FieldByName('DESCRIZIONE').AsString;
    end;
end;

procedure TWA177FFerieSolidaliDettFM.btnVisOfferteClick(Sender: TObject);
var WC015: TWC015FSelEditGridFM;
begin
  inherited;
  WC015:=TWC015FSelEditGridFM.Create(Self.Owner);
  with (WR302DM as TWA177FFerieSolidaliDM).A177MW do
  begin
    //Visualizzo elenco di tutte le offerte legate a questa richiesta
    R180SetVariable(selT254a,'ID_RICHIESTA',selT254.FieldByName('ID_RICHIESTA').AsInteger);
    R180SetVariable(selT254a,'ORDINAMENTO','T030.COGNOME, T030.NOME, T030.MATRICOLA, T254.DECORRENZA, T254.CODRAGGR');
    R180SetVariable(selT254a,'DATI','');
    selT254a.Open;
    selT254a.Refresh;
    WC015.Visualizza('Elenco offerte',selT254a,False,False,True,800);
  end;
end;

procedure TWA177FFerieSolidaliDettFM.CaricaMultiColumnComboBox;
begin
  inherited;
  with (WR302DM as TWA177FFerieSolidaliDM).A177MW do
  begin
    cmbRaggruppamento.Items.Clear;
    if selT254.FieldByName('TIPO').AsString = 'R' then  //Se richiesta propongo raggruppamenti 'Ferie solidali'
    begin
      selT260.First;
      while not selT260.Eof do
      begin
        cmbRaggruppamento.AddRow(selT260.FieldByName('CODICE').AsString + ';' + selT260.FieldByName('DESCRIZIONE').AsString);
        selT260.Next;
      end;
    end
    else
    begin
      R180SetVariable(selT262,'ANNO',dedtAnno.Text);
      R180SetVariable(selT262,'PROGRESSIVO',selAnagrafe.FieldByName('Progressivo').AsInteger);
      selT262.Open;
      selT262.First;
      while not selT262.Eof do
      begin
        cmbRaggruppamento.AddRow(selT262.FieldByName('CODICE').AsString + ';' + selT262.FieldByName('DESCRIZIONE').AsString);
        selT262.Next;
      end;
    end;
  end;
end;

procedure TWA177FFerieSolidaliDettFM.cmbCausaleChange(Sender: TObject; Index: Integer);
begin
  inherited;
  with WR302DM as TWA177FFerieSolidaliDM do
  begin
    selTabella.FieldByName('CAUSALE').AsString:=cmbCausale.Text;
    lblDescCausale.Caption:='';
    A177MW.selSQL.SQL.Text:='SELECT DESCRIZIONE FROM T265_CAUASSENZE WHERE CODICE = ''' + cmbCausale.Text + '''';
    A177MW.selSQL.Execute;
    if A177MW.selSQL.RowsProcessed > 0 then
      lblDescCausale.Caption:=VarToStr(A177MW.selSQL.Field(0));
  end;
end;

procedure TWA177FFerieSolidaliDettFM.cmbRaggruppamentoChange(Sender: TObject; Index: Integer);
begin
  inherited;
  with WR302DM as TWA177FFerieSolidaliDM do
  begin
    selTabella.FieldByName('CODRAGGR').AsString:=cmbRaggruppamento.Text;
    lblDescRaggruppamento.Caption:='';
    lblDescCausale.Caption:='';
    A177MW.selSQL.SQL.Text:='SELECT DESCRIZIONE FROM T260_RAGGRASSENZE WHERE CODICE = ''' + cmbRaggruppamento.Text + '''';
    A177MW.selSQL.Execute;
    if A177MW.selSQL.RowsProcessed > 0 then
      lblDescRaggruppamento.Caption:=VarToStr(A177MW.selSQL.Field(0));
    if selTabella.FieldByName('TIPO').AsString = 'R' then  //Richiesta
    begin
      A177MW.ImpostaCausale(cmbRaggruppamento.Text,selTabella.FieldByName('UMISURA').AsString);
    end
    else if selTabella.FieldByName('TIPO').AsString = 'O' then //Offerta
    begin
      if selTabella.State in [dsInsert] then
      begin
        if A177MW.selT262.SearchRecord('CODICE',cmbRaggruppamento.Text,[srFromBeginning]) then
          selTabella.FieldByName('UMISURA').AsString:=A177MW.selT262.FieldByName('UMISURA').AsString;
        dRgpUMisuraClick(nil);
      end;
      A177MW.ImpostaCausale(cmbRaggruppamento.Text,'');
    end;
    Dataset2Componenti;
    //Carico combo causale
    if A177MW.selT265.Active then
    begin
      cmbCausale.Items.Clear;
      A177MW.selT265.First;
      while not A177MW.selT265.Eof do
      begin
        cmbCausale.AddRow(A177MW.selT265.FieldByName('CODICE').AsString + ';' + A177MW.selT265.FieldByName('DESCRIZIONE').AsString);
        A177MW.selT265.Next;
      end;
    end;
  end;
end;

procedure TWA177FFerieSolidaliDettFM.Componenti2DataSet;
begin
  inherited;
  with WR302DM as TWA177FFerieSolidaliDM do
  begin
    if Trim(cmbRaggruppamento.Text) <> '' then
      selTabella.FieldByName('CODRAGGR').AsString:=cmbRaggruppamento.Text
    else
      selTabella.FieldByName('CODRAGGR').AsString:=EmptyStr;
    if Trim(cmbCausale.Text) <> '' then
      selTabella.FieldByName('CAUSALE').AsString:=cmbCausale.Text
    else
      selTabella.FieldByName('CAUSALE').AsString:=EmptyStr;
  end;
end;

procedure TWA177FFerieSolidaliDettFM.DataSet2Componenti;
begin
  inherited;
  with WR302DM as TWA177FFerieSolidaliDM do
  begin
    //Raggruppamento assenza
    cmbRaggruppamento.ItemIndex:=-1;
    cmbRaggruppamento.Text:=selTabella.FieldByName('CODRAGGR').AsString;
    lblDescRaggruppamento.Caption:='';
    if not selTabella.FieldByName('CODRAGGR').IsNull then
    begin
      A177MW.selSQL.SQL.Text:='SELECT DESCRIZIONE FROM T260_RAGGRASSENZE WHERE CODICE = ''' + cmbRaggruppamento.Text + '''';
      A177MW.selSQL.Execute;
      if A177MW.selSQL.RowsProcessed > 0 then
        lblDescRaggruppamento.Caption:=VarToStr(A177MW.selSQL.Field(0));
    end;
    //Causale assenza
    cmbCausale.ItemIndex:=-1;
    cmbCausale.Text:=selTabella.FieldByName('CAUSALE').AsString;
    cmbCausaleChange(nil,0);
  end;
  ImpostaMask;
end;

procedure TWA177FFerieSolidaliDettFM.drgpTipoClick(Sender: TObject);
begin
  inherited;
  with (WR302DM as TWA177FFerieSolidaliDM) do
    if selTabella.State in [dsInsert] then
    begin
      A177MW.selT254NewRecord(selTabella.FieldByName('TIPO').AsString);
      Dataset2Componenti;
    end;
  CaricaMultiColumnComboBox;
  AbilitaComponenti;
end;

procedure TWA177FFerieSolidaliDettFM.drgpUMisuraClick(Sender: TObject);
begin
  inherited;
  with (WR302DM as TWA177FFerieSolidaliDM) do
  begin
    ImpostaMask;
    if (selTabella.State in [dsInsert]) and (selTabella.FieldByName('TIPO').AsString = 'R') then
    begin
      edtTotOfferte.Text:='0'; //Forzo sempre zero anche in caso di ore
      selTabella.FieldByName('QUANTITA_RICHIESTA').AsString:=IfThen(selTabella.FieldByName('UMISURA').AsString='O', R180MinutiOre(A177MW.ValenzaGiornata * 30),'30');
      A177MW.ImpostaCausale(cmbRaggruppamento.Text,selTabella.FieldByName('UMISURA').AsString);
      DataSet2Componenti;
    end;
  end;
end;

procedure TWA177FFerieSolidaliDettFM.ImpostaMask;
begin
  with (WR302DM as TWA177FFerieSolidaliDM) do
  begin
    if selTabella.FieldByName('UMISURA').AsString = 'G' then
    begin
      ImpostaCss(dedtQuantitaRichiesta, 'input_num_nnnd width5chr');
      ImpostaCss(dedtQuantitaOttenuta, 'input_num_nnnd width5chr');
      ImpostaCss(dedtQuantitaOfferta, 'input_num_nnnd width5chr');
      ImpostaCss(dedtQuantitaAccettata, 'input_num_nnnd width5chr');
      ImpostaCss(dedtQuantitaRestituita, 'input_num_nnnd width5chr');
      ImpostaCss(edtTotOfferte, 'input_num_nnnd width5chr');
    end
    else
    begin
      ImpostaCss(dedtQuantitaRichiesta, 'input_hour_hhhhmm width5chr');
      ImpostaCss(dedtQuantitaOttenuta, 'input_hour_hhhhmm width5chr');
      ImpostaCss(dedtQuantitaOfferta, 'input_hour_hhhhmm width5chr');
      ImpostaCss(dedtQuantitaAccettata, 'input_hour_hhhhmm width5chr');
      ImpostaCss(dedtQuantitaRestituita, 'input_hour_hhhhmm width5chr');
      ImpostaCss(edtTotOfferte, 'input_hour_hhhhmm width5chr');
    end;
  end;
 end;

procedure TWA177FFerieSolidaliDettFM.lnkCausaleClick(Sender: TObject);
begin
  inherited;
  (Self.Owner as TWR100FBase).AccediForm(105,'CODICE=' + cmbCausale.Text);
end;

procedure TWA177FFerieSolidaliDettFM.lnkRaggruppamentoClick(Sender: TObject);
begin
  inherited;
  (Self.Owner as TWR100FBase).AccediForm(106,'CODICE=' + cmbRaggruppamento.Text);
end;

end.
