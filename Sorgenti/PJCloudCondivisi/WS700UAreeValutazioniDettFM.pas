unit WS700UAreeValutazioniDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, IWCompEdit,
  IWDBStdCtrls, meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompLabel, meIWLabel, IWCompExtCtrls, IWDBExtCtrls, meIWDBRadioGroup, IWCompCheckbox,
  meIWDBCheckBox, IWCompMemo, meIWDBMemo, IWCompButton, meIWButton, A000UCostanti,
  WC013UCheckListFM, C180FunzioniGenerali, IWAdvRadioGroup, meTIWAdvRadioGroup, DB,
  C190FunzioniGeneraliWeb, meIWImageFile, Math, meIWEdit, A000UMessaggi;

type
  TWS700FAreeValutazioniDettFM = class(TWR205FDettTabellaFM)
    lblCodiceArea: TmeIWLabel;
    dedtCodArea: TmeIWDBEdit;
    lblDescrizione: TmeIWLabel;
    dedtDescrizione: TmeIWDBEdit;
    lblPesoPercentuale: TmeIWLabel;
    lblPesoPercMin: TmeIWLabel;
    lblPesoPercMax: TmeIWLabel;
    dedtPesoPercentuale: TmeIWDBEdit;
    dedtPesoPercMin: TmeIWDBEdit;
    dedtPesoPercMax: TmeIWDBEdit;
    lblTipoPesoPercentuale: TmeIWLabel;
    drgpTipoPesoPercentuale: TmeIWDBRadioGroup;
    lblTipoCollegamentoEsterno: TmeIWLabel;
    lblItemPersonalizzati: TmeIWLabel;
    lblItemPersonalizzatiMin: TmeIWLabel;
    lblItemPersonalizzatiMax: TmeIWLabel;
    dedtItemPersonalizzatiMin: TmeIWDBEdit;
    dedtItemPersonalizzatiMax: TmeIWDBEdit;
    lblPesoItems: TmeIWLabel;
    dchkPesoVariabileItems: TmeIWDBCheckBox;
    dchkPesoEquoItems: TmeIWDBCheckBox;
    dchkItemTuttiValutabili: TmeIWDBCheckBox;
    dchkPunteggiSoloItemValutabili: TmeIWDBCheckBox;
    lblTipoPunteggioItems: TmeIWLabel;
    drgpTipoPunteggioItems: TmeIWDBRadioGroup;
    lblTestoItemPersonalizzati: TmeIWLabel;
    dmemTestoItemPersonalizzati: TmeIWDBMemo;
    lblStatiAvanzamento: TmeIWLabel;
    lblStatiAbilitatiElementi: TmeIWLabel;
    lblStatiAbilitatiPunteggi: TmeIWLabel;
    dedtStatiAbilitatiElementi: TmeIWDBEdit;
    btnStatiAbilitatiElementi: TmeIWButton;
    dedtStatiAbilitatiPunteggi: TmeIWDBEdit;
    btnStatiAbilitatiPunteggi: TmeIWButton;
    rgpAdvTipoLinkItem: TmeTIWAdvRadioGroup;
    procedure btnStatiAbilitatiPunteggiClick(Sender: TObject);
    procedure dedtItemPersonalizzatiMinAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure dedtItemPersonalizzatiMaxAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure dchkPesoVariabileItemsAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure dedtItemPersonalizzatiMaxAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure drgpTipoPesoPercentualeClick(Sender: TObject);
    procedure dedtPesoPercentualeAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure dchkPesoEquoItemsClick(Sender: TObject);
    procedure IWFrameRegionRender(Sender: TObject);
    procedure rgpAdvTipoLinkItemClick(Sender: TObject);
    procedure drgpTipoPunteggioItemsClick(Sender: TObject);
  private
    WC013: TWC013FCheckListFM;
    StatiAbilitatiPunteggi: boolean;
    function EstraiElencoStatiAbilitati(Sender: TObject):TElencoValoriCheckList;
    procedure ResultStatiAbilitati(Sender: TObject; Result:Boolean);
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
    procedure ControlloPercentuale;
    procedure imgCodClick(Sender: TObject);
    procedure imgCodResult(Sender: TObject; Result: Boolean);
  public
    procedure AbilitaComponenti; override;
  end;

implementation

uses WS700UAreeValutazioniDM, WS700UElementiFM, WR102UGestTabella, WS700UAreeValutazioni;

{$R *.dfm}

procedure TWS700FAreeValutazioniDettFM.btnStatiAbilitatiPunteggiClick(Sender: TObject);
var
  ElencoStatiAbilitati: TElencoValoriChecklist;
  LstSel: TStringList;
  WC013: TWC013FCheckListFM;
begin
  WC013:=TWC013FCheckListFM.Create(Self.Owner);
  ElencoStatiAbilitati:=EstraiElencoStatiAbilitati(Sender);
  WC013.CaricaLista(ElencoStatiAbilitati.lstDescrizione, ElencoStatiAbilitati.lstCodice);
  FreeAndNil(ElencoStatiAbilitati);
  LstSel:=TStringList.Create;
  if Sender = btnStatiAbilitatiPunteggi then
    StatiAbilitatiPunteggi:=true
  else
    StatiAbilitatiPunteggi:=false;
  if StatiAbilitatiPunteggi then
    LstSel.CommaText:=dedtStatiAbilitatiPunteggi.Text
  else
    LstSel.CommaText:=dedtStatiAbilitatiElementi.Text;
  WC013.ImpostaValoriSelezionati(LstSel);
  FreeAndNil(LstSel);
  WC013.ResultEvent:=ResultStatiAbilitati;
  WC013.Visualizza(0,0,'<WC013> Elenco pagine');
end;

function TWS700FAreeValutazioniDettFM.EstraiElencoStatiAbilitati(Sender: TObject): TElencoValoriCheckList;
var codRegola, codice, descrizione, codiceComposto: String;
begin
  Result:=TElencoValoriChecklist.Create;
    with (WR302DM AS TWS700FAreeValutazioniDM).S700FAreeValutazioniMW.selSG746 do
    begin
      SetVariable('DECORRENZA',WR302DM.selTabella.FieldByName('DECORRENZA').AsDateTime);
      SetVariable('DECORRENZA_FINE',WR302DM.selTabella.FieldByName('DECORRENZA_FINE').AsDateTime);
      Open;
      while not Eof do
      begin
        codRegola:=FieldByName('CODREGOLA').AsString;
        codice:=IntToStr(FieldByName('CODICE').AsInteger);
        descrizione:=FieldByName('DESCRIZIONE').AsString;
        codiceComposto:=codRegola + '.' + codice;
        Result.lstCodice.add(codiceComposto);
        Result.lstDescrizione.Add(Format('%-2s %s',[codiceComposto,descrizione]));
        Next;
      end;
      Close;
    end;
end;

procedure TWS700FAreeValutazioniDettFM.IWFrameRegionRender(Sender: TObject);
begin
  inherited;
  //AbilitaComponenti;
end;

procedure TWS700FAreeValutazioniDettFM.ResultStatiAbilitati(Sender: TObject; Result:Boolean);
var
  lstTemp: TStringList;
begin
  if Result then
  begin
    lstTemp:=(Sender as TWC013FCheckListFM).LeggiValoriSelezionati;
    if StatiAbilitatiPunteggi then
      WR302DM.selTabella.FieldByName('STATI_ABILITATI_PUNTEGGI').AsString:=lstTemp.CommaText
    else
      WR302DM.selTabella.FieldByName('STATI_ABILITATI_ELEMENTI').AsString:=lstTemp.CommaText;
    FreeAndNil(lstTemp);
  end;
end;

procedure TWS700FAreeValutazioniDettFM.AbilitaComponenti;
begin
  if not (WR302DM AS TWS700FAreeValutazioniDM).S700FAreeValutazioniMW.selSG700.Active then
    exit;
  lblPesoPercentuale.Enabled:=not ((drgpTipoPesoPercentuale.ItemIndex = 0) and ((WR302DM AS TWS700FAreeValutazioniDM).S700FAreeValutazioniMW.selSG700.RecordCount > 0)) or dchkPesoEquoItems.Checked;
  dedtPesoPercentuale.Enabled:=lblPesoPercentuale.Enabled;
  lblPesoPercMin.Enabled:=(drgpTipoPesoPercentuale.ItemIndex = 0) and (dchkPesoVariabileItems.Checked);
  dedtPesoPercMin.Enabled:=lblPesoPercMin.Enabled;
  lblPesoPercMax.Enabled:=lblPesoPercMin.Enabled;
  dedtPesoPercMax.Enabled:=lblPesoPercMin.Enabled;
  rgpAdvTipoLinkItem.Enabled:=(WR302DM AS TWS700FAreeValutazioniDM).S700FAreeValutazioniMW.selSG700.RecordCount = 0;
  rgpAdvTipoLinkItem.EnabledItems[0]:=rgpAdvTipoLinkItem.Enabled.ToInteger;
  rgpAdvTipoLinkItem.EnabledItems[1]:=( rgpAdvTipoLinkItem.Enabled and (drgpTipoPesoPercentuale.ItemIndex = 1) ).ToInteger;
  rgpAdvTipoLinkItem.EnabledItems[2]:=rgpAdvTipoLinkItem.Enabled.ToInteger;
  lblItemPersonalizzati.Enabled:=not R180In(rgpAdvTipoLinkItem.ItemIndex,[1,2]);
  lblItemPersonalizzatiMin.Enabled:=lblItemPersonalizzati.Enabled;
  dedtItemPersonalizzatiMin.Enabled:=lblItemPersonalizzati.Enabled;
  lblItemPersonalizzatiMax.Enabled:=lblItemPersonalizzati.Enabled;
  dedtItemPersonalizzatiMax.Enabled:=lblItemPersonalizzati.Enabled;
  dchkPesoVariabileItems.Enabled:=(rgpAdvTipoLinkItem.ItemIndex <> 1) and ( (WR302DM.selTabella.FieldByName('PESO_EQUO_ITEMS').AsString='N') or (StrToIntDef(dedtItemPersonalizzatiMax.Text,0) > 0));
  dchkPesoEquoItems.Enabled:=(rgpAdvTipoLinkItem.ItemIndex <> 1) and ((WR302DM.selTabella.FieldByName('PESO_VARIABILE_ITEMS').AsString='N') or (StrToIntDef(dedtItemPersonalizzatiMax.Text,0) > 0));
  dchkItemTuttiValutabili.Enabled:=(rgpAdvTipoLinkItem.ItemIndex <> 1)
                                    and not (((WR302DM.selTabella.FieldByName('PESO_PERCENTUALE').AsFloat = 0)
                                    and not dchkPesoVariabileItems.Checked
                                    and ((StrToIntDef(dedtItemPersonalizzatiMax.Text,0) > 0)
                                          or ((WR302DM AS TWS700FAreeValutazioniDM).S700FAreeValutazioniMW.selSG700.RecordCount > 0))));
  dchkPunteggiSoloItemValutabili.Enabled:=rgpAdvTipoLinkItem.ItemIndex <> 1;
  drgpTipoPunteggioItems.Enabled:=not R180In(rgpAdvTipoLinkItem.ItemIndex,[1,2]);
  lblTestoItemPersonalizzati.Enabled:=StrToIntDef(dedtItemPersonalizzatiMax.Text,0) > 0;
  dmemTestoItemPersonalizzati.Enabled:=lblTestoItemPersonalizzati.Enabled;
  btnStatiAbilitatiElementi.Enabled:=(WR302DM.selTabella.State in [dsEdit,dsInsert])
                                      and (WR302DM.selTabella.RecordCount > 0)
                                      and (rgpAdvTipoLinkItem.ItemIndex <> 1);
  btnStatiAbilitatiPunteggi.Enabled:=(WR302DM.selTabella.State in [dsEdit,dsInsert])
                                      and (WR302DM.selTabella.RecordCount > 0)
                                      and not R180In(rgpAdvTipoLinkItem.ItemIndex,[1,2]);
  if (Self.Owner as TWS700FAreeValutazioni).Detail <> nil then
  begin
    ((Self.Owner as TWS700FAreeValutazioni).Detail).grdTabella.medpCancellaRigaWR102;
    ((Self.Owner as TWS700FAreeValutazioni).Detail).grdTabella.medpPreparaComponentiDefault;
    ((Self.Owner as TWS700FAreeValutazioni).Detail).grdTabella.medpPreparaComponenteGenerico('WR102',((Self.Owner as TWS700FAreeValutazioni).Detail).grdTabella.medpIndexColonna('COD_AREA_LINK'),1,DBG_IMG,'','PUNTINI','','','');
    ((Self.Owner as TWS700FAreeValutazioni).Detail).grdTabella.medpPreparaComponenteGenerico('WR102',((Self.Owner as TWS700FAreeValutazioni).Detail).grdTabella.medpIndexColonna('COD_VALUTAZIONE_LINK'),1,DBG_IMG,'','PUNTINI','','','');
    ((Self.Owner as TWS700FAreeValutazioni).Detail).grdTabella.medpPreparaComponenteGenerico('WR102',((Self.Owner as TWS700FAreeValutazioni).Detail).grdTabella.medpIndexColonna('DESCRIZIONE_LINK'),0,DBG_LBL,'','','','','');
    ((Self.Owner as TWS700FAreeValutazioni).Detail).grdTabella.medpPreparaComponenteGenerico('WR102',((Self.Owner as TWS700FAreeValutazioni).Detail).grdTabella.medpIndexColonna('DESCRIZIONI_PUNTEGGI'),0,DBG_MEMO,'2000','','','','');
    ((Self.Owner as TWS700FAreeValutazioni).Detail).grdTabella.medpColonna('PESO_PERCENTUALE').Visible:=(WR302DM.selTabella.FieldByName('PESO_EQUO_ITEMS').AsString='N');
    ((Self.Owner as TWS700FAreeValutazioni).Detail).grdTabella.medpColonna('COD_AREA_LINK').Visible:=R180In(WR302DM.selTabella.FieldByName('TIPO_LINK_ITEM').AsInteger,[1,2]);
    ((Self.Owner as TWS700FAreeValutazioni).Detail).grdTabella.medpColonna('COD_VALUTAZIONE_LINK').Visible:=R180In(WR302DM.selTabella.FieldByName('TIPO_LINK_ITEM').AsInteger,[1,2]);
    ((Self.Owner as TWS700FAreeValutazioni).Detail).grdTabella.medpColonna('DESCRIZIONE_LINK').Visible:=R180In(WR302DM.selTabella.FieldByName('TIPO_LINK_ITEM').AsInteger,[1,2]);
    ((Self.Owner as TWS700FAreeValutazioni).Detail).grdTabella.medpColonna('DESCRIZIONI_PUNTEGGI').Visible:=WR302DM.selTabella.FieldByName('TIPO_PUNTEGGIO_ITEMS').AsInteger = 0;
    ((Self.Owner as TWS700FAreeValutazioni).Detail).grdTabella.medpAggiornaCDS(true);
    ((Self.Owner as TWS700FAreeValutazioni).Detail as TWS700FElementiFM).AssegnaMenuDett;
  end;
end;

procedure TWS700FAreeValutazioniDettFM.dchkPesoEquoItemsClick(Sender: TObject);
begin
  inherited;
    with WR302DM.selTabella do
    if State in [dsInsert,dsEdit] then
      if (StrToIntDef(dedtItemPersonalizzatiMax.Text,0) > 0) then
      begin
        if dchkPesoEquoItems.Checked then
          FieldByName('PESO_VARIABILE_ITEMS').AsString:='N'
        else
          FieldByName('PESO_VARIABILE_ITEMS').AsString:='S';
      end;
  AbilitaComponenti;
end;

procedure TWS700FAreeValutazioniDettFM.dchkPesoVariabileItemsAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  with WR302DM.selTabella do
    if State in [dsEdit,dsInsert] then
      if dchkPesoVariabileItems.Checked then
        FieldByName('PESO_EQUO_ITEMS').AsString:='N'
      else
      begin
        FieldByName('PESO_PERC_MIN').AsString:=FieldByName('PESO_PERCENTUALE').AsString;
        FieldByName('PESO_PERC_MAX').AsString:=FieldByName('PESO_PERCENTUALE').AsString;
        if (StrToIntDef(dedtItemPersonalizzatiMax.Text,0) > 0) then
          FieldByName('PESO_EQUO_ITEMS').AsString:='S';
        if (FieldByName('PESO_PERCENTUALE').AsFloat = 0)
        and ((StrToIntDef(dedtItemPersonalizzatiMax.Text,0) > 0)
             or ((WR302DM AS TWS700FAreeValutazioniDM).S700FAreeValutazioniMW.selSG700.Active
                 and ((WR302DM AS TWS700FAreeValutazioniDM).S700FAreeValutazioniMW.selSG700.RecordCount > 0))) then
          FieldByName('ITEM_TUTTI_VALUTABILI').AsString:='S';
      end;
  AbilitaComponenti;
end;

procedure TWS700FAreeValutazioniDettFM.dedtItemPersonalizzatiMaxAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  with WR302DM.selTabella do
    if State in [dsInsert,dsEdit] then
    begin
      if (StrToIntDef(dedtItemPersonalizzatiMax.Text,0) > 0)
      and not dchkPesoVariabileItems.Checked
      and not dchkPesoEquoItems.Checked then
        FieldByName('PESO_VARIABILE_ITEMS').AsString:='S';
      if (StrToIntDef(dedtItemPersonalizzatiMax.Text,0) > 0)
      and not dchkPesoVariabileItems.Checked
      and (FieldByName('PESO_PERCENTUALE').AsFloat = 0) then
        FieldByName('ITEM_TUTTI_VALUTABILI').AsString:='S';
    end;
  AbilitaComponenti;
end;

procedure TWS700FAreeValutazioniDettFM.dedtItemPersonalizzatiMaxAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TWS700FAreeValutazioniDettFM.dedtItemPersonalizzatiMinAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TWS700FAreeValutazioniDettFM.dedtPesoPercentualeAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  with WR302DM.selTabella do
    if State in [dsInsert,dsEdit] then
      if not dedtPesoPercMin.Enabled
      or (dedtPesoPercMin.Text = dedtPesoPercMax.Text) then
      begin
        FieldByName('PESO_PERC_MIN').AsString:=FieldByName('PESO_PERCENTUALE').AsString;
        FieldByName('PESO_PERC_MAX').AsString:=FieldByName('PESO_PERCENTUALE').AsString;
      end;
    ControlloPercentuale;
end;

procedure TWS700FAreeValutazioniDettFM.rgpAdvTipoLinkItemClick(Sender: TObject);
begin
  inherited;
  TWS700FAreeValutazioniDM(WR302DM).selTabella.FieldByName('TIPO_LINK_ITEM').AsInteger:=rgpAdvTipoLinkItem.ItemIndex;
  with WR302DM.selTabella do
    if State in [dsInsert,dsEdit] then
    begin
      if rgpAdvTipoLinkItem.ItemIndex = 1 then
      begin
        FieldByName('ITEM_PERSONALIZZATI_MIN').AsInteger:=0;
        FieldByName('ITEM_PERSONALIZZATI_MAX').AsInteger:=0;
        FieldByName('ITEM_TUTTI_VALUTABILI').AsString:='S';
        FieldByName('PUNTEGGI_SOLO_ITEM_VALUTABILI').AsString:='S';
        FieldByName('PESO_VARIABILE_ITEMS').AsString:='N';
        FieldByName('PESO_EQUO_ITEMS').AsString:='S';
        FieldByName('TIPO_PUNTEGGIO_ITEMS').AsString:='1';
        FieldByName('TESTO_ITEM_PERSONALIZZATI').AsString:='';
        FieldByName('STATI_ABILITATI_ELEMENTI').AsString:='';
        FieldByName('STATI_ABILITATI_PUNTEGGI').AsString:='';
      end
      else if rgpAdvTipoLinkItem.ItemIndex = 2 then
      begin
        FieldByName('ITEM_PERSONALIZZATI_MIN').AsInteger:=0;
        FieldByName('ITEM_PERSONALIZZATI_MAX').AsInteger:=0;
        FieldByName('TIPO_PUNTEGGIO_ITEMS').AsString:='1';
        FieldByName('TESTO_ITEM_PERSONALIZZATI').AsString:='';
        FieldByName('STATI_ABILITATI_PUNTEGGI').AsString:='';
      end;
    end;
  AbilitaComponenti;
end;

procedure TWS700FAreeValutazioniDettFM.drgpTipoPesoPercentualeClick(Sender: TObject);
begin
  inherited;
  with WR302DM.selTabella do
    if State in [dsInsert,dsEdit] then
    begin
      if drgpTipoPesoPercentuale.ItemIndex = 0 then
      begin
        if FieldByName('TIPO_LINK_ITEM').AsString = '1' then
          FieldByName('TIPO_LINK_ITEM').AsString:='0';
        rgpAdvTipoLinkItem.ItemIndex:=FieldByName('TIPO_LINK_ITEM').AsInteger;
      end
      else
      begin
        FieldByName('PESO_PERC_MIN').AsString:=FieldByName('PESO_PERCENTUALE').AsString;
        FieldByName('PESO_PERC_MAX').AsString:=FieldByName('PESO_PERCENTUALE').AsString;
      end;
    end;
  AbilitaComponenti;
end;

procedure TWS700FAreeValutazioniDettFM.drgpTipoPunteggioItemsClick(Sender: TObject);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TWS700FAreeValutazioniDettFM.DataSet2Componenti;
begin
  inherited;
  rgpAdvTipoLinkItem.ItemIndex:=(WR302DM AS TWS700FAreeValutazioniDM).selTabella.FieldByName('TIPO_LINK_ITEM').AsInteger;
  drgpTipoPunteggioItems.ItemIndex:=(WR302DM AS TWS700FAreeValutazioniDM).selTabella.FieldByName('TIPO_PUNTEGGIO_ITEMS').AsInteger;
//Cfr la parte su WS700UElementiFM
//  if (Self.Owner as TWS700FAreeValutazioni).Detail <> nil then
//  begin
//    //((Self.Owner as TWS700FAreeValutazioni).Detail).grdTabella.medpCancellaRigaWR102;
//    //for r := ifthen(grdCausTollerate.medpDataSet.state in [dsInsert],0,1) to High(grdCausTollerate.medpCompGriglia) do
//    for r := ifthen(((Self.Owner as TWS700FAreeValutazioni).Detail).grdTabella.medpDataSet.state in [dsInsert],0,1) to High(((Self.Owner as TWS700FAreeValutazioni).Detail).grdTabella.medpCompGriglia) do
//    if ((Self.Owner as TWS700FAreeValutazioni).Detail).grdTabella.medpCompCella(r,((Self.Owner as TWS700FAreeValutazioni).Detail).grdTabella.medpIndexColonna('COD_AREA_LINK'),1) <> nil then
//    begin
//      img:=TmeIWImageFile(((Self.Owner as TWS700FAreeValutazioni).Detail).grdTabella.medpCompCella(r,((Self.Owner as TWS700FAreeValutazioni).Detail).grdTabella.medpIndexColonna('COD_AREA_LINK'),1));
//      img.OnClick:=imgCodClick;
//    end;
//  end;
end;

procedure TWS700FAreeValutazioniDettFM.Componenti2DataSet;
begin
  TWS700FAreeValutazioniDM(WR302DM).selTabella.FieldByName('TIPO_LINK_ITEM').AsInteger:=rgpAdvTipoLinkItem.ItemIndex;
  TWS700FAreeValutazioniDM(WR302DM).selTabella.FieldByName('TIPO_PUNTEGGIO_ITEMS').AsInteger:=drgpTipoPunteggioItems.ItemIndex;
end;

procedure TWS700FAreeValutazioniDettFM.ControlloPercentuale;
begin
  try
  if (StrToFloat(dedtPesoPercentuale.Text) < 0)
    or (StrToFloat(dedtPesoPercentuale.Text) > 100) then
    raise exception.create(Format(A000MSG_S700_ERR_FMT_VAL_COMPRESO,['Peso %']));
    except
  on Exception : EConvertError do
    ShowMessage(Exception.Message);
  end;
end;

//Cfr WS700UElemetniFM
procedure TWS700FAreeValutazioniDettFM.imgCodClick(Sender: TObject);
begin
  WC013:=TWC013FCheckListFM.Create(Self.Owner);
  with WC013 do
  begin
    ResultEvent:=imgCodResult;
    C190PutCheckList(TmeIWEdit(((Self.Owner as TWS700FAreeValutazioni).Detail).grdTabella.medpCompCella(((Self.Owner as TWS700FAreeValutazioni).Detail).grdTabella.medpClientDataSet.RecNo-1,((Self.Owner as TWS700FAreeValutazioni).Detail).grdTabella.medpIndexColonna('TIPO_LINK_ITEM'),0)).Text,5,ckList);
    Visualizza;
  end;
end;

procedure TWS700FAreeValutazioniDettFM.imgCodResult(Sender: TObject; Result:Boolean);
begin
  if Result then
    TmeIWEdit(((Self.Owner as TWS700FAreeValutazioni).Detail).grdTabella.medpCompCella(((Self.Owner as TWS700FAreeValutazioni).Detail).grdTabella.medpClientDataSet.RecNo-1,((Self.Owner as TWS700FAreeValutazioni).Detail).grdTabella.medpIndexColonna('TIPO_LINK_ITEM'),0)).Text:=Trim(C190GetCheckList(5,WC013.ckList));
end;
end.
