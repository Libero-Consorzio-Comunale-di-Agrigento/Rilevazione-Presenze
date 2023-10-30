unit WA141URegoleRiposiDettFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Menus, Dialogs,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWAppForm,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWDBExtCtrls, IWCompEdit,
  IWDBStdCtrls, meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompLabel, meIWDBRadioGroup, IWCompCheckbox, meIWDBCheckBox, IWAdvCheckGroup,
  meTIWAdvCheckGroup, A000UInterfaccia, A000UCostanti, A000USessione, Db,
  IWAdvRadioGroup, meTIWAdvRadioGroup, meIWLabel, meIWImageFile, IWCompExtCtrls,
  IWCompJQueryWidget, IWHTMLControls,
  WR100UBase, WR102UGestTabella, WR205UDettTabellaFM,
  meIWLink, medpIWMultiColumnComboBox;

type
  TWA141FRegoleRiposiDettFM = class(TWR205FDettTabellaFM)
    dedtDescrizione: TmeIWDBEdit;
    lblDescrizione: TmeIWLabel;
    dchkPulisciGiustif: TmeIWDBCheckBox;
    drgpInsSmontoNotte: TmeIWDBRadioGroup;
    lblInsSmontoNotte: TmeIWLabel;
    dchkInsPersonaleNonTurnista: TmeIWDBCheckBox;
    dchkInsGgNonLav: TmeIWDBCheckBox;
    dchkInsGgVuoti: TmeIWDBCheckBox;
    dchkInsRipComp: TmeIWDBCheckBox;
    lblParametriInserimento: TmeIWLabel;
    dchkDomenica: TmeIWDBCheckBox;
    dchkGiorniNonLavorativi: TmeIWDBCheckBox;
    dchkGiorniFestivi: TmeIWDBCheckBox;
    dchkSoloSignificativo: TmeIWDBCheckBox;
    cgpInsGiorniTimbrCaus: TmeTIWAdvCheckGroup;
    lblNoInsGgGiustificati: TmeIWLabel;
    cgpNoInsGgGiustificati: TmeTIWAdvCheckGroup;
    lblDescFestivita: TmeIWLabel;
    lblDescRiposoComp: TmeIWLabel;
    lblDescRiposoMesePrec: TmeIWLabel;
    lblDescRiposoLavorato: TmeIWLabel;
    imgDeselezionaTuttoInsGiorniTimbrCaus: TmeIWImageFile;
    imgInvertiSelezioneInsGiorniTimbrCaus: TmeIWImageFile;
    imgSelezionaTuttoNoInsGgGiustificati: TmeIWImageFile;
    imgInvertiSelezioneNoInsGgGiustificati: TmeIWImageFile;
    imgDeselezionaTuttoNoInsGgGiustificati: TmeIWImageFile;
    drgpTipo: TmeTIWAdvRadioGroup;
    lblCodice: TmeIWLabel;
    lblNomeCampoCodice: TmeIWLabel;
    lblDescCodice: TmeIWLabel;
    lblInsGiorniTimbrCaus: TmeIWLabel;
    imgSelezionaTuttoInsGiorniTimbrCaus: TmeIWImageFile;
    lnkFestivita: TmeIWLink;
    lnkRiposoComp: TmeIWLink;
    lnkRiposoMesePrec: TmeIWLink;
    lnkRiposoLavorato: TmeIWLink;
    pmnAzioniNoInsGgGiustificati: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    pmnAzioniInsGiorniTimbrCaus: TPopupMenu;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    cmbCodice: TMedpIWMultiColumnComboBox;
    cmbFestivita: TMedpIWMultiColumnComboBox;
    cmbRiposoComp: TMedpIWMultiColumnComboBox;
    cmbRiposoMesePrec: TMedpIWMultiColumnComboBox;
    cmbRiposoLavorato: TMedpIWMultiColumnComboBox;
    lnkRiposoCompNeg: TmeIWLink;
    cmbRiposoCompNeg: TMedpIWMultiColumnComboBox;
    lblDescRiposoCompNeg: TmeIWLabel;
    dChkPrioritaFestivi: TmeIWDBCheckBox;
    dChkRichNonElab: TmeIWDBCheckBox;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure cmbCodiceAsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure cmbFestivitaAsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure cmbRiposoCompAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbRiposoMesePrecAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbRiposoLavoratoAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure dchkInsPersonaleNonTurnistaAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure dchkInsRipCompAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure imgSelezionaTuttoInsGiorniTimbrCaus2AsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure imgSelezionaTuttoNoInsGgGiustificatiAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure imgDeselezionaTuttoInsGiorniTimbrCausAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure imgDeselezionaTuttoNoInsGgGiustificatiAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure imgInvertiSelezioneInsGiorniTimbrCausAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure imgInvertiSelezioneNoInsGgGiustificatiAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure drgpTipoClick(Sender: TObject);
    procedure imgSelezionaTuttoInsGiorniTimbrCausAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure lnkOpenWA016(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure cmbRiposoCompNegAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
  private
    procedure ImpostaLblFestivita;
    procedure DeselezionatuttoClick(Sender: TObject; CheckGroup: TmeTIWAdvCheckGroup);
    procedure InvertiselezioneClick(Sender: TObject; CheckGroup: TmeTIWAdvCheckGroup);
    procedure SelezionatuttoClick(Sender: TObject; CheckGroup: TmeTIWAdvCheckGroup);
  public
    procedure AbilitaComponenti; override;
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
    procedure CaricaMultiColumnComboBox; override;
  end;

implementation

uses WA141URegoleRiposiDM;

{$R *.dfm}

procedure TWA141FRegoleRiposiDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  cmbCodice.medpAutoResetItems:=False;
  Self.Parent:=(Self.Owner as TIWAppForm);
  WR302DM:=(Self.Parent as TWR102FGestTabella).WR302DM;
  with TWA141FRegoleRiposiDM(WR302DM) do
  begin
    selInterfaccia.SQL.Clear;
    if A000LookupTabella(Parametri.CampiRiferimento.C16_INSRIPOSI,selInterfaccia) then
    begin
      if selInterfaccia.VariableIndex('DECORRENZA') >= 0 then
        selInterfaccia.SetVariable('DECORRENZA',EncodeDate(3999,12,31));
      selInterfaccia.Open;
      selInterfaccia.First;
      while not selInterfaccia.Eof do
      begin
        cmbCodice.AddRow(selInterfaccia.FieldByName('CODICE').AsString + ';' + selInterfaccia.FieldByName('DESCRIZIONE').AsString);;
        selInterfaccia.Next;
      end;
      lblNomeCampoCodice.Caption:=Parametri.CampiRiferimento.C16_INSRIPOSI;
    end
    else
    begin
      lblDescCodice.Caption:='<INTERFACCIA UNICA>';
      lblNomeCampoCodice.Caption:='';
    end;


    selT275.First;
    while not selT275.Eof do
    begin
      cgpInsGiorniTimbrCaus.Items.Add(Format('%-5s %s',[selT275.FieldByName('CODICE').AsString,selT275.FieldByName('DESCRIZIONE').AsString]));
      selT275.Next;
    end;

    selT265.First;
    while not selT265.Eof do
    begin
      cgpNoInsGgGiustificati.Items.Add(Format('%-5s %s',[selT265.FieldByName('CODICE').AsString,selT265.FieldByName('DESCRIZIONE').AsString]));
      selT265.Next;
    end;
  end;
  inherited;
end;

procedure TWA141FRegoleRiposiDettFM.lnkOpenWA016(Sender: TObject);
begin
  // TODO WA016 DA SVILUPPARE
  TWR100FBase(Self.Parent).AccediForm(105,'CODICE=' + TWA141FRegoleRiposiDM(WR302DM).selTabella.FieldByName('CODICE').AsString );
end;

procedure TWA141FRegoleRiposiDettFM.MenuItem1Click(Sender: TObject);
begin
  inherited;
  SelezionatuttoClick(Sender,cgpNoInsGgGiustificati);
end;

procedure TWA141FRegoleRiposiDettFM.MenuItem2Click(Sender: TObject);
begin
  inherited;
  DeselezionatuttoClick(Sender,cgpNoInsGgGiustificati);
end;

procedure TWA141FRegoleRiposiDettFM.MenuItem3Click(Sender: TObject);
begin
  inherited;
  InvertiSelezioneClick(Sender,cgpNoInsGgGiustificati);
end;

procedure TWA141FRegoleRiposiDettFM.MenuItem4Click(Sender: TObject);
begin
  inherited;
  SelezionatuttoClick(Sender,cgpInsGiorniTimbrCaus);
end;

procedure TWA141FRegoleRiposiDettFM.MenuItem5Click(Sender: TObject);
begin
  inherited;
  DeselezionatuttoClick(Sender,cgpInsGiorniTimbrCaus);
end;

procedure TWA141FRegoleRiposiDettFM.MenuItem6Click(Sender: TObject);
begin
  inherited;
  InvertiSelezioneClick(Sender,cgpInsGiorniTimbrCaus);
end;

procedure TWA141FRegoleRiposiDettFM.DataSet2Componenti;
var i:Integer;
  lstAppoggio:TStringList;
begin
  lstAppoggio:=TStringList.Create;
  with TWA141FRegoleRiposiDM(WR302DM) do
  begin
    if selTabella.FieldByName('TIPO_CAUSALE').AsString = 'R' then
      drgpTipo.ItemIndex:=0
    else if selTabella.FieldByName('TIPO_CAUSALE').AsString = 'F' then
      drgpTipo.ItemIndex:=1
    else if selTabella.FieldByName('TIPO_CAUSALE').AsString = 'I' then
      drgpTipo.ItemIndex:=2;

    ImpostaLblFestivita;

    lstAppoggio.Clear;
    lstAppoggio.CommaText:=selTabella.FieldByName('CAUS_PRESENZA_TOLLERATE').AsString;
    for i:=0 to cgpInsGiorniTimbrCaus.Items.Count - 1 do
      cgpInsGiorniTimbrCaus.IsChecked[i]:=False;
    for i:=0 to cgpInsGiorniTimbrCaus.Items.Count - 1 do
    begin
      if lstAppoggio.IndexOf(Trim(Copy(cgpInsGiorniTimbrCaus.Items[i],1,5))) >= 0 then
        cgpInsGiorniTimbrCaus.IsChecked[i]:=True;
    end;
    lstAppoggio.Clear;
    lstAppoggio.CommaText:=selTabella.FieldByName('CAUS_ASSENZA_NONTOLLERATE').AsString;
    for i:=0 to cgpNoInsGgGiustificati.Items.Count - 1 do
      cgpNoInsGgGiustificati.IsChecked[i]:=False;
    for i:=0 to cgpNoInsGgGiustificati.Items.Count - 1 do
    begin
      if lstAppoggio.IndexOf(Trim(Copy(cgpNoInsGgGiustificati.Items[i],1,5))) >= 0 then
        cgpNoInsGgGiustificati.IsChecked[i]:=True;
    end;

    if A000LookupTabella(Parametri.CampiRiferimento.C16_INSRIPOSI,selInterfaccia) then
    begin
      cmbCodice.ItemIndex:=-1;
      cmbCodice.Text:=selTabella.FieldByName('CODICE').AsString;
      lblDescCodice.Caption:=VarToStr(selInterfaccia.LookUp('CODICE', selTabella.FieldByName('CODICE').AsString, 'DESCRIZIONE'));
    end
    else
      lblDescCodice.Caption:='<INTERFACCIA UNICA>';

    cmbFestivita.ItemIndex:=-1;
    cmbFestivita.Text:=selTabella.FieldByName('RIPOSO_ORDINARIO').AsString;
    lblDescFestivita.Caption:=VarToStr(QCausale1.LookUp('T265CODICE', selTabella.FieldByName('RIPOSO_ORDINARIO').AsString, 'T265DESCRIZIONE'));

    cmbRiposoComp.ItemIndex:=-1;
    cmbRiposoComp.Text:=selTabella.FieldByName('RIPOSO_COMPENSATIVO').AsString;
    lblDescRiposoComp.Caption:=VarToStr(QCausale2.LookUp('T265CODICE', selTabella.FieldByName('RIPOSO_COMPENSATIVO').AsString, 'T265DESCRIZIONE'));

    cmbRiposoCompNeg.ItemIndex:=-1;
    cmbRiposoCompNeg.Text:=selTabella.FieldByName('RIPOSO_COMPENSATIVO_SALDONEG').AsString;
    lblDescRiposoCompNeg.Caption:=VarToStr(QCausaleNeg.LookUp('T265CODICE', selTabella.FieldByName('RIPOSO_COMPENSATIVO_SALDONEG').AsString, 'T265DESCRIZIONE'));

    cmbRiposoMesePrec.ItemIndex:=-1;
    cmbRiposoMesePrec.Text:=selTabella.FieldByName('RIPOSO_MESEPREC').AsString;
    lblDescRiposoMesePrec.Caption:=VarToStr(QCausale3.LookUp('T265CODICE', selTabella.FieldByName('RIPOSO_MESEPREC').AsString, 'T265DESCRIZIONE'));

    cmbRiposoLavorato.ItemIndex:=-1;
    cmbRiposoLavorato.Text:=selTabella.FieldByName('RIPOSO_LAVORATO').AsString;
    lblDescRiposoLavorato.Caption:=VarToStr(QCausale4.LookUp('T265CODICE', selTabella.FieldByName('RIPOSO_LAVORATO').AsString, 'T265DESCRIZIONE'));
  end;
  FreeAndNil(lstAppoggio);
end;

procedure TWA141FRegoleRiposiDettFM.AbilitaComponenti;
begin
  inherited;
  if (WR302DM.selTabella.State in [dsEdit,dsInsert]) then
  begin
    with TWA141FRegoleRiposiDM(WR302DM) do
    begin
      ImpostaLblFestivita;

      lnkRiposoComp.Enabled:=drgpTipo.ItemIndex = 0;
      cmbRiposoComp.Enabled:=drgpTipo.ItemIndex = 0;
      if not cmbRiposoComp.Enabled then
        cmbRiposoComp.ItemIndex:=-1;

      lnkRiposoCompNeg.Enabled:=drgpTipo.ItemIndex = 0;
      cmbRiposoCompNeg.Enabled:=drgpTipo.ItemIndex = 0;
      if not cmbRiposoCompNeg.Enabled then
        cmbRiposoCompNeg.ItemIndex:=-1;

      lnkRiposoMesePrec.Enabled:=drgpTipo.ItemIndex = 0;
      cmbRiposoMesePrec.Enabled:=drgpTipo.ItemIndex = 0;
      if not cmbRiposoMesePrec.Enabled then
        cmbRiposoComp.ItemIndex:=-1;

      drgpInsSmontoNotte.Enabled:=drgpTipo.ItemIndex <> 2;
      if (not drgpInsSmontoNotte.Enabled) then
        selTabella.FieldByName('SMONTO_NOTTE').AsString:='N';

      dchkInsPersonaleNonTurnista.Enabled:=(drgpTipo.ItemIndex <> 2) and not dchkInsRipComp.Checked;
      if (not dchkInsPersonaleNonTurnista.Enabled) then
        selTabella.FieldByName('PERSONALE_NON_TURNISTA').AsString:='N';
      dchkInsGgNonLav.Enabled:=drgpTipo.ItemIndex <> 2;
      if (not dchkInsGgNonLav.Enabled)then
        selTabella.FieldByName('GGNONLAV_CON_TIMBRATURE').AsString:='N';
      dchkInsGgVuoti.Enabled:=drgpTipo.ItemIndex <> 2;
      if (not dchkInsGgVuoti.Enabled)then
        selTabella.FieldByName('SOLO_SE_NON_REPERIBILE').AsString:='N';
      dchkInsRipComp.Enabled:=drgpTipo.ItemIndex = 0;
      if (not dchkInsRipComp.Enabled)then
        selTabella.FieldByName('LIMITE_SALDO').AsString:='N';

      lnkRiposoLavorato.Enabled:=(drgpTipo.ItemIndex = 0) and dchkInsPersonaleNonTurnista.Checked and (not dchkInsGgNonLav.Checked);
      cmbRiposoLavorato.Enabled:=lnkRiposoLavorato.Enabled;
      if not cmbRiposoLavorato.Enabled then
        cmbRiposoLavorato.ItemIndex:=-1;

      lblDescRiposoLavorato.Enabled:=lnkRiposoLavorato.Enabled;
      dchkDomenica.Enabled:=drgpTipo.ItemIndex <> 2;
      if (not dchkDomenica.Enabled)then
        selTabella.FieldByName('DOMENICA_GIUSTIFICATA').AsString:='N';

      dchkGiorniNonLavorativi.Enabled:=drgpTipo.ItemIndex <> 2;
      if (not dchkGiorniNonLavorativi.Enabled) then
        selTabella.FieldByName('GGNONLAV_GIUSTIFICATO').AsString:='N';

      dchkGiorniFestivi.Enabled:=drgpTipo.ItemIndex <> 2;
      if (not dchkGiorniFestivi.Enabled) then
        selTabella.FieldByName('GGFEST_GIUSTIFICATO').AsString:='N';

      dchkSoloSignificativo.Enabled:=drgpTipo.ItemIndex <> 2;
      if (not dchkSoloSignificativo.Enabled) then
        selTabella.FieldByName('GGCALEND_GIUSTIFICATO').AsString:='N';

      cgpInsGiorniTimbrCaus.Enabled:=drgpTipo.ItemIndex <> 2;
      if drgpTipo.ItemIndex = 2 then
      begin
        imgSelezionaTuttoInsGiorniTimbrCaus.Enabled:=False;
        imgDeselezionaTuttoInsGiorniTimbrCaus.Enabled:=False;
        imgInvertiSelezioneInsGiorniTimbrCaus.Enabled:=False;

        imgSelezionaTuttoNoInsGgGiustificati.Enabled:=False;
        imgDeselezionaTuttoNoInsGgGiustificati.Enabled:=False;
        imgInvertiSelezioneNoInsGgGiustificati.Enabled:=False;
      end;

      cgpNoInsGgGiustificati.Enabled:=drgpTipo.ItemIndex <> 2;
    end;
  end;
end;

procedure TWA141FRegoleRiposiDettFM.Componenti2DataSet;
var
  i           : Integer;
  lstAppoggio : TStringList;
begin
  lstAppoggio:=TStringList.Create;

  with TWA141FRegoleRiposiDM(WR302DM) do
  begin
    if drgpTipo.ItemIndex = 0 then
      selTabella.FieldByName('TIPO_CAUSALE').AsString:='R'
    else if drgpTipo.ItemIndex = 1 then
      selTabella.FieldByName('TIPO_CAUSALE').AsString:='F'
    else if drgpTipo.ItemIndex = 2 then
      selTabella.FieldByName('TIPO_CAUSALE').AsString:='I';
    lstAppoggio.Clear;
    for i:=0 to cgpInsGiorniTimbrCaus.Items.Count - 1 do
    begin
      if cgpInsGiorniTimbrCaus.IsChecked[i] then
        lstAppoggio.Add(Trim(Copy(cgpInsGiorniTimbrCaus.Items[i],1,5)));
    end;
    selTabella.FieldByName('CAUS_PRESENZA_TOLLERATE').AsString:=lstAppoggio.CommaText;

    lstAppoggio.Clear;
    for i:=0 to cgpNoInsGgGiustificati.Items.Count - 1 do
    begin
      if cgpNoInsGgGiustificati.IsChecked[i] then
        lstAppoggio.Add(Trim(Copy(cgpNoInsGgGiustificati.Items[i],1,5)));
    end;
    selTabella.FieldByName('CAUS_ASSENZA_NONTOLLERATE').AsString:=lstAppoggio.CommaText;

    if A000LookupTabella(Parametri.CampiRiferimento.C16_INSRIPOSI,selInterfaccia) then
      selTabella.FieldByName('CODICE').AsString:=cmbCodice.Text
    else
      selTabella.FieldByName('CODICE').AsString:='<UNICA>';

    selTabella.FieldByName('RIPOSO_ORDINARIO').AsString:=cmbFestivita.Text;
    selTabella.FieldByName('RIPOSO_COMPENSATIVO').AsString:=cmbRiposoComp.Text;
    selTabella.FieldByName('RIPOSO_COMPENSATIVO_SALDONEG').AsString:=cmbRiposoCompNeg.Text;
    selTabella.FieldByName('RIPOSO_MESEPREC').AsString:=cmbRiposoMesePrec.Text;
    selTabella.FieldByName('RIPOSO_LAVORATO').AsString:=cmbRiposoLavorato.Text;
  end;
  FreeAndNil(lstAppoggio);
end;

procedure TWA141FRegoleRiposiDettFM.CaricaMultiColumnComboBox;
begin
  inherited;
  with TWA141FRegoleRiposiDM(WR302DM).QCausale1 do
  begin
    Refresh;
    First;
    while not Eof do
    begin
      cmbFestivita.AddRow(FieldByName('T265CODICE').AsString + ';' + FieldByName('T265DESCRIZIONE').AsString);
      Next;
    end;
  end;

  with TWA141FRegoleRiposiDM(WR302DM).QCausale2 do
  begin
    Refresh;
    First;
    while not Eof do
    begin
      cmbRiposoComp.AddRow(FieldByName('T265CODICE').AsString + ';' + FieldByName('T265DESCRIZIONE').AsString);
      Next;
    end;
  end;

  with TWA141FRegoleRiposiDM(WR302DM).QCausale3 do
  begin
    Refresh;
    First;
    while not Eof do
    begin
      cmbRiposoMesePrec.AddRow(FieldByName('T265CODICE').AsString + ';' + FieldByName('T265DESCRIZIONE').AsString);
      Next;
    end;
  end;

  with TWA141FRegoleRiposiDM(WR302DM).QCausale4 do
  begin
    Refresh;
    First;
    while not Eof do
    begin
      cmbRiposoLavorato.AddRow(FieldByName('T265CODICE').AsString + ';' + FieldByName('T265DESCRIZIONE').AsString);
      Next;
    end;
  end;

  with TWA141FRegoleRiposiDM(WR302DM).QCausaleNeg do
  begin
    Refresh;
    First;
    while not Eof do
    begin
      cmbRiposoCompNeg.AddRow(FieldByName('T265CODICE').AsString + ';' + FieldByName('T265DESCRIZIONE').AsString);
      Next;
    end;
  end;
end;

procedure TWA141FRegoleRiposiDettFM.cmbCodiceAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  with TWA141FRegoleRiposiDM(WR302DM) do
  begin
    if Index <> -1 then
    begin
      selTabella.FieldByName('CODICE').AsString:=cmbCodice.Text; //nel caso si lanci l'accedi
      lblDescCodice.Caption:=cmbCodice.Items[Index].RowData[1];
    end
    else
    begin
      selTabella.FieldByName('CODICE').AsString:='';
      lblDescCodice.Caption:='';
    end;
  end;
end;

procedure TWA141FRegoleRiposiDettFM.cmbFestivitaAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  with TWA141FRegoleRiposiDM(WR302DM) do
  begin
    if Index <> -1 then
    begin
      selTabella.FieldByName('RIPOSO_ORDINARIO').AsString:=cmbFestivita.Text; //nel caso si lanci l'accedi
      lblDescFestivita.Caption:=cmbFestivita.Items[Index].RowData[1];
    end
    else
    begin
      selTabella.FieldByName('RIPOSO_ORDINARIO').AsString:='';
      lblDescFestivita.Caption:='';
    end;
  end;

end;

procedure TWA141FRegoleRiposiDettFM.cmbRiposoCompAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  with TWA141FRegoleRiposiDM(WR302DM) do
  begin
    if Index <> -1 then
    begin
      selTabella.FieldByName('RIPOSO_COMPENSATIVO').AsString:=cmbRiposoComp.Text; //nel caso si lanci l'accedi
      lblDescRiposoComp.Caption:=cmbRiposoComp.Items[Index].RowData[1];
    end
    else
    begin
      selTabella.FieldByName('RIPOSO_COMPENSATIVO').AsString:='';
      lblDescRiposoComp.Caption:='';
    end;
  end;
end;

procedure TWA141FRegoleRiposiDettFM.cmbRiposoCompNegAsyncChange(
  Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  with TWA141FRegoleRiposiDM(WR302DM) do
  begin
    if Index <> -1 then
    begin
      selTabella.FieldByName('RIPOSO_COMPENSATIVO_SALDONEG').AsString:=cmbRiposoCompNeg.Text; //nel caso si lanci l'accedi
      lblDescRiposoCompNeg.Caption:=cmbRiposoCompNeg.Items[Index].RowData[1];
    end
    else
    begin
      selTabella.FieldByName('RIPOSO_COMPENSATIVO_SALDONEG').AsString:='';
      lblDescRiposoCompNeg.Caption:='';
    end;
  end;
end;

procedure TWA141FRegoleRiposiDettFM.cmbRiposoLavoratoAsyncChange(
  Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  with TWA141FRegoleRiposiDM(WR302DM) do
  begin
    if Index <> -1 then
    begin
      selTabella.FieldByName('RIPOSO_LAVORATO').AsString:=cmbRiposoLavorato.Text; //nel caso si lanci l'accedi
      lblDescRiposoLavorato.Caption:=cmbRiposoLavorato.Items[Index].RowData[1];
    end
    else
    begin
      selTabella.FieldByName('RIPOSO_LAVORATO').AsString:='';
      lblDescRiposoLavorato.Caption:='';
    end;
  end;
end;

procedure TWA141FRegoleRiposiDettFM.cmbRiposoMesePrecAsyncChange(
  Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  with TWA141FRegoleRiposiDM(WR302DM) do
  begin
    if Index <> -1 then
    begin
      selTabella.FieldByName('RIPOSO_MESEPREC').AsString:=cmbRiposoMesePrec.Text; //nel caso si lanci l'accedi
      lblDescRiposoMesePrec.Caption:=cmbRiposoMesePrec.Items[Index].RowData[1];
    end
    else
    begin
      selTabella.FieldByName('RIPOSO_MESEPREC').AsString:='';
      lblDescRiposoMesePrec.Caption:='';
    end;
  end;
end;

procedure TWA141FRegoleRiposiDettFM.dchkInsPersonaleNonTurnistaAsyncClick(
  Sender: TObject; EventParams: TStringList);
begin
  AbilitaComponenti;
end;

procedure TWA141FRegoleRiposiDettFM.dchkInsRipCompAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  AbilitaComponenti;
end;

procedure TWA141FRegoleRiposiDettFM.drgpTipoClick(Sender: TObject);
begin
  AbilitaComponenti;
end;

procedure TWA141FRegoleRiposiDettFM.imgDeselezionaTuttoInsGiorniTimbrCausAsyncClick(
  Sender: TObject; EventParams: TStringList);
var
  i:Integer;
begin
  inherited;
  for i:=0 to cgpInsGiorniTimbrCaus.Items.Count - 1 do
    cgpInsGiorniTimbrCaus.IsChecked[i]:=False;
  cgpInsGiorniTimbrCaus.AsyncUpdate;
end;

procedure TWA141FRegoleRiposiDettFM.imgDeselezionaTuttoNoInsGgGiustificatiAsyncClick(
  Sender: TObject; EventParams: TStringList);
var
  i:Integer;
begin
  inherited;
  for i:=0 to cgpNoInsGgGiustificati.Items.Count - 1 do
    cgpNoInsGgGiustificati.IsChecked[i]:=False;
  cgpNoInsGgGiustificati.AsyncUpdate;
end;

procedure TWA141FRegoleRiposiDettFM.imgInvertiSelezioneInsGiorniTimbrCausAsyncClick(
  Sender: TObject; EventParams: TStringList);
var
  i:Integer;
begin
  inherited;
  for i:=0 to cgpInsGiorniTimbrCaus.Items.Count - 1 do
    cgpInsGiorniTimbrCaus.IsChecked[i]:=not cgpInsGiorniTimbrCaus.IsChecked[i];
  cgpInsGiorniTimbrCaus.AsyncUpdate;
end;

procedure TWA141FRegoleRiposiDettFM.imgInvertiSelezioneNoInsGgGiustificatiAsyncClick(
  Sender: TObject; EventParams: TStringList);
var
  i:Integer;
begin
  inherited;
  for i:=0 to cgpNoInsGgGiustificati.Items.Count - 1 do
    cgpNoInsGgGiustificati.IsChecked[i]:=not cgpNoInsGgGiustificati.IsChecked[i];
  cgpNoInsGgGiustificati.AsyncUpdate;
end;

procedure TWA141FRegoleRiposiDettFM.imgSelezionaTuttoInsGiorniTimbrCaus2AsyncClick(
  Sender: TObject; EventParams: TStringList);
var
 i:Integer;
begin
  inherited;
  for i:=0 to cgpInsGiorniTimbrCaus.Items.Count - 1 do
    cgpInsGiorniTimbrCaus.IsChecked[i]:=True;
  cgpInsGiorniTimbrCaus.AsyncUpdate;
end;

procedure TWA141FRegoleRiposiDettFM.imgSelezionaTuttoInsGiorniTimbrCausAsyncClick(
  Sender: TObject; EventParams: TStringList);
var
  i:Integer;
begin
  for i:=0 to cgpInsGiorniTimbrCaus.Items.Count - 1 do
    cgpInsGiorniTimbrCaus.IsChecked[i]:=True;
  cgpInsGiorniTimbrCaus.AsyncUpdate;
end;

procedure TWA141FRegoleRiposiDettFM.imgSelezionaTuttoNoInsGgGiustificatiAsyncClick(
  Sender: TObject; EventParams: TStringList);
var
  i:Integer;
begin
  inherited;
  for i:=0 to cgpNoInsGgGiustificati.Items.Count - 1 do
    cgpNoInsGgGiustificati.IsChecked[i]:=True;
  cgpNoInsGgGiustificati.AsyncUpdate;
end;

procedure TWA141FRegoleRiposiDettFM.impostaLblFestivita;
begin
  if drgpTipo.ItemIndex = 0 then
    lnkFestivita.Caption:='Riposo'
  else if drgpTipo.ItemIndex = 1 then
    lnkFestivita.Caption:='Festività'
  else if drgpTipo.ItemIndex = 2 then
    lnkFestivita.Caption:='Festivi infrasett.';
end;

procedure TWA141FRegoleRiposiDettFM.SelezionatuttoClick(Sender: TObject;CheckGroup: TmeTIWAdvCheckGroup);
var
 i:Integer;
begin
  inherited;
  for i:=0 to CheckGroup.Items.Count - 1 do
    CheckGroup.IsChecked[i]:=True;
  CheckGroup.AsyncUpdate;
end;

procedure TWA141FRegoleRiposiDettFM.DeselezionatuttoClick(Sender: TObject;CheckGroup: TmeTIWAdvCheckGroup);
var
  i:Integer;
begin
  inherited;
  for i:=0 to CheckGroup.Items.Count - 1 do
    CheckGroup.IsChecked[i]:=False;
  CheckGroup.AsyncUpdate;
end;

procedure TWA141FRegoleRiposiDettFM.InvertiselezioneClick(Sender: TObject;CheckGroup: TmeTIWAdvCheckGroup);
var
  i:Integer;
begin
  inherited;
  for i:=0 to CheckGroup.Items.Count - 1 do
    CheckGroup.IsChecked[i]:=not CheckGroup.IsChecked[i];
  CheckGroup.AsyncUpdate;
end;

end.
