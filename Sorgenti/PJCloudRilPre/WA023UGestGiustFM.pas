unit WA023UGestGiustFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR200UBaseFM, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompButton, meIWButton, WR100UBase,
  IWAdvRadioGroup, meTIWAdvRadioGroup, IWCompEdit, meIWEdit, IWCompLabel,
  meIWLabel, medpIWMultiColumnComboBox, OracleData, R600, C180FunzioniGenerali,
  A000USessione, StrUtils, A000UInterfaccia, A000UMessaggi, A000UCostanti,
  medpIWMessageDlg;

type
  // AOSTA_REGIONE - chiamata 85647.ini
  TDatiCausale = record
    Codice: String;
    VisitaFiscale: String;
  end;
  // AOSTA_REGIONE - chiamata 85647.fine

  TWA023FGestGiustFM = class(TWR200FBaseFM)
    btnChiudi: TmeIWButton;
    btnConferma: TmeIWButton;
    rgpTipoCausale: TmeTIWAdvRadioGroup;
    rgpTipoGiust: TmeTIWAdvRadioGroup;
    lblDaOre: TmeIWLabel;
    edtDaOre: TmeIWEdit;
    edtAOre: TmeIWEdit;
    lblAOre: TmeIWLabel;
    lblCausale: TmeIWLabel;
    cmbCausale: TMedpIWMultiColumnComboBox;
    cmbFamiliari: TMedpIWMultiColumnComboBox;
    lblFamiliari: TmeIWLabel;
    lblDescCausale: TmeIWLabel;
    lblData: TmeIWLabel;
    procedure btnChiudiClick(Sender: TObject);
    procedure rgpTipoGiustAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure cmbCausaleAsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure rgpTipoCausaleAsyncClick(Sender: TObject;
      EventParams: TStringList);
  private
    bAssenza: boolean;
    DataOperazione: TDateTime;
    NumGiustificativo: Integer;
    OldGiustif,NewGiustif: TGiustificativo;
    OldValidata: String;
    OldDataNas, NewDataNas:TDateTime;
    ProgCausOrig:Word;
    TipoGiust:Char;
    Ricarica: Boolean;
    Ng1,Ng2:Integer;
    StrOldDataNas,StrNewDataNas :String;
    // AOSTA_REGIONE - chiamata 85647.ini
    CausOrig: TDatiCausale;
    // AOSTA_REGIONE - chiamata 85647.fine
    procedure caricaComboCausale;
    procedure RefreshSelSG101;
    function GetCausale: String;
    function GetData: String;
    procedure AbilitaTipoFruizione;
    function Modificato: Boolean;
    procedure CompetenzeGiustifFuturi;
    procedure DistruzioneFrame;
    procedure RegistraB021;
    procedure ResultConfermaDati(Sender: TObject; Res: TmeIWModalResult;
      KeyID: String);
    procedure ResultAllineaCompetenzeGiustif(Sender: TObject;
      Res: TmeIWModalResult; KeyID: String);
    function VerificaDati: String;
    procedure ConfermaDati(Sender: TObject);
  public
    function ModificaGiustificativo(Data: TDateTime; Num: Integer): Boolean;
    procedure Visualizza;
  end;

implementation
uses WA023UTimbrature,A023UTimbratureMW;

{$R *.dfm}

function TWA023FGestGiustFM.ModificaGiustificativo(Data:TDateTime; Num:Integer): Boolean;
var Giustificativo: TGiustificativi;
  TipoCaus: String;
begin
  Result:=True;
  DataOperazione:=Data;
  NumGiustificativo:=Num;
  with (Self.Parent as TWA023FTimbrature).WA023FTimbratureDM.A023FTimbratureMW do
  begin
    Giustificativo:=A000FGestioneTimbraGiustMW.FGiustificativi[R180Giorno(DataOperazione),NumGiustificativo];

    TipoCaus:=IfThen(Q275.Locate('Codice',Giustificativo.Causale,[]),'P','A');
    if (TipoCaus = 'A') and (not A000FiltroDizionario('CAUSALI ASSENZA',Giustificativo.Causale)) then
    begin
      Result:=False;
      Exit;
    end;

    if (TipoCaus = 'P') and (not A000FiltroDizionario('CAUSALI PRESENZA',Giustificativo.Causale)) then
    begin
      Result:=False;
      Exit;
    end;
    if not(Q040.Locate('Data;Causale;ProgrCausale',VarArrayOf([Data,Giustificativo.Causale,Giustificativo.ProgCaus]),[])) then
    begin
      Result:=False;
      Exit;
    end;

    R600DtM1:=TR600DtM1.Create(Self);

    LblData.Caption:=FormatDateTime('dd/mm/yyyy',Data);
    if TipoCaus = 'P' then
    begin
      bAssenza:=True;
      rgpTipoCausale.ItemIndex:=0;
    end
    else
    begin
      bAssenza:=False;
      rgpTipoCausale.ItemIndex:=1;
    end;
    rgpTipoCausaleAsyncClick(nil,nil);
    cmbCausale.Text:=Giustificativo.Causale;
    if cmbCausale.ItemIndex > -1 then
      lblDescCausale.Caption:=cmbCausale.Items[cmbCausale.ItemIndex].RowData[1];
    RefreshSelSG101;
    AbilitaTipoFruizione;

    if Giustificativo.Tipo = 'I' then
    begin
      rgpTipoGiust.ItemIndex:=0;
    end
    else if Giustificativo.Tipo = 'M' then
    begin
      rgpTipoGiust.ItemIndex:=1;
      if (R180OreMinuti(Giustificativo.DaOre) > 0) then
        edtDaOre.Text:=FormatDateTime('hh.mm',Giustificativo.DaOre);
    end
    else if Giustificativo.Tipo = 'N' then
    begin
      rgpTipoGiust.ItemIndex:=2;
      EdtDaOre.Text:=FormatDateTime('hh.mm',Giustificativo.DaOre);
    end
    else if Giustificativo.Tipo = 'D' then
    begin
      rgpTipoGiust.ItemIndex:=3;
      EdtDaOre.Text:=FormatDateTime('hh.mm',Giustificativo.DaOre);
      EdtAOre.Text:=FormatDateTime('hh.mm',Giustificativo.AOre);
    end;
    rgpTipoGiustAsyncClick(nil,nil);

    //Solo per assenze:Imposto i dati in OldGiustif
    OldGiustif.Inserimento:=False;
    case rgpTipoGiust.ItemIndex of
      0:OldGiustif.Modo:='I';
      1:OldGiustif.Modo:='M';
      2:OldGiustif.Modo:='N';
      3:OldGiustif.Modo:='D';
    end;
    OldGiustif.Causale:=cmbCausale.Text;
    OldGiustif.DaOre:=EdtDaOre.Text;
    OldGiustif.AOre:=EdtAOre.Text;
    OldDataNas:=Giustificativo.DataNas;
    ProgCausOrig:=Q040.FieldByName('ProgrCausale').AsInteger;

    // parte nuova da considerare
    ImpostaProgressivoSG101;

    getDataGestGiustif:=GetData;
    getCausaleGestGiustif:=GetCausale;
    R600DtM1.selSG101.OnFilterRecord:=selSG101FilterRecord;

    R600DtM1.selSG101.Open;
    RefreshSelSG101;
    cmbFamiliari.Text:='';
    if Giustificativo.DataNas <> 0 then
      cmbFamiliari.Text:=DateToStr(Giustificativo.DataNas);
    OldValidata:=IfThen(Giustificativo.Validata = 'S','V','');

    // TORINO_ASLTO2 - 2013/044 - INT_TECN 4 - controllo inizio catena.ini
    CausOrig.Codice:=cmbCausale.Text;
    // TORINO_ASLTO2.fine
    // AOSTA_REGIONE - chiamata 85647.fine
    // salva il valore del flag visita fiscale
    CausOrig.VisitaFiscale:=VarToStr((Self.Parent as TWA023FTimbrature).WA023FTimbratureDM.A023FTimbratureMW.Q265.Lookup('CODICE',CausOrig.Codice,'VISITA_FISCALE'));
    // AOSTA_REGIONE - chiamata 85647.fine

    Q265.Filtered:=True;
    Q275.Filtered:=True;
    AbilitaTipoFruizione;
  end;
end;

procedure TWA023FGestGiustFM.caricaComboCausale;
var Ods:TOracleDataset;
begin
  cmbCausale.Items.Clear;
  with (Self.Parent as TWA023FTimbrature).WA023FTimbratureDM.A023FTimbratureMW do
    if rgpTipoCausale.ItemIndex = 0 then
      Ods:=Q275
    else
      Ods:=Q265;
  Ods.First;
  while not Ods.Eof do
  begin
    cmbCausale.AddRow(Ods.FieldByName('CODICE').AsString + ';' + Ods.FieldByName('DESCRIZIONE').AsString);
    Ods.Next;
  end;
end;

procedure TWA023FGestGiustFM.cmbCausaleAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  if cmbCausale.ItemIndex > -1 then
    lblDescCausale.Caption:=cmbCausale.Items[cmbCausale.ItemIndex].RowData[1]
  else
    lblDescCausale.Caption:='';
  RefreshSelSG101;
  AbilitaTipoFruizione;
end;

procedure TWA023FGestGiustFM.RefreshSelSG101;
var DN:TDateTime;
begin
  with (Self.Parent as TWA023FTimbrature).WA023FTimbratureDM.A023FTimbratureMW do
  begin
    if not R600DtM1.selSG101.Active then
      Exit;
    if cmbFamiliari.Text <> '' then
      Dn:=StrToDate(cmbFamiliari.Text)
    else
      Dn:=0;

    R600DtM1.selSG101.Filtered:=False;
    R600DtM1.selSG101.Filtered:=True;

    cmbFamiliari.Items.Clear;
    R600DtM1.selSG101.First;
    while not R600DtM1.selSG101.Eof do
    begin
      cmbFamiliari.AddRow(R600DtM1.selSG101.FieldByName('DATA').AsString + ';' + R600DtM1.selSG101.FieldByName('NOME').AsString);
      R600DtM1.selSG101.Next;
    end;

    if R600DtM1.selSG101.RecordCount = 1 then
      cmbFamiliari.Text:=cmbFamiliari.Items[0].RowData[0]
    else if R600DtM1.selSG101.SearchRecord('DATA',DN,[srFromBeginning]) then
      cmbFamiliari.Text:=DateToStr(DN)
    else
      cmbFamiliari.Text:='';
  end;
end;

procedure TWA023FGestGiustFM.rgpTipoCausaleAsyncClick(Sender: TObject;
  EventParams: TStringList);
var Ricarica: Boolean;
begin
  Ricarica:=False;
  if (rgpTipoCausale.ItemIndex = 0) and (bAssenza) then
  begin
    rgpTipoGiust.EnabledItems[0]:=0;
    rgpTipoGiust.EnabledItems[1]:=0;
    if (rgpTipoGiust.ItemIndex = 0) or (rgpTipoGiust.ItemIndex = 1) then
      rgpTipoGiust.ItemIndex:=2;
    rgpTipoGiust.Invalidate;
    Ricarica:=True;
    bAssenza:=False;
  end;
  if (rgpTipoCausale.ItemIndex = 1) and (not bAssenza) then
  begin
    rgpTipoGiust.EnabledItems[0]:=1;
    rgpTipoGiust.EnabledItems[1]:=1;
    rgpTipoGiust.Invalidate;
    Ricarica:=True;
    bAssenza:=True;
  end;

  if Ricarica then
  begin
    caricaComboCausale;
    cmbCausale.Text:='';
    lblDescCausale.Caption:='';
    RefreshSelSG101;
    AbilitaTipoFruizione;
  end;

  cmbFamiliari.Enabled:=bAssenza;
  rgpTipoGiustAsyncClick(nil,nil);
end;

procedure TWA023FGestGiustFM.rgpTipoGiustAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  edtDaOre.Enabled:=rgpTipoGiust.ItemIndex > 0;
  edtAOre.Enabled:=rgpTipoGiust.ItemIndex = 3;
  lblDaOre.Enabled:=edtDaOre.Enabled;
  lblAOre.Enabled:=edtAOre.Enabled;
  if not edtDaOre.Enabled then
    edtDaOre.Text:='';

  if not edtAOre.Enabled then
    edtAOre.Text:='';

  case rgpTipoGiust.ItemIndex of
    0:TipoGiust:='I';
    1:TipoGiust:='M';
    2:TipoGiust:='N';
    3:TipoGiust:='D';
  end;
end;

procedure TWA023FGestGiustFM.Visualizza;
begin
  (Self.Parent as TWR100FBase).VisualizzaJQMessaggio(jQuery,425,385,385, 'Modifica Giustificativo','#wa023gestgiust_container',False,True);
end;

//usate da A023FTimbratureMW.selSG101FilterRecord
function TWA023FGestGiustFM.GetData: String;
begin
  Result:=LblData.Caption;
end;

function TWA023FGestGiustFM.GetCausale: String;
begin
  Result:=cmbCausale.Text;
end;

procedure TWA023FGestGiustFM.AbilitaTipoFruizione;
var
  i: Integer;
begin
  with (Self.Parent as TWA023FTimbrature).WA023FTimbratureDM.A023FTimbratureMW do
  begin
    if cmbCausale.Text = '' then
    begin
      rgpTipoGiust.EnabledItems[0]:=0;
      rgpTipoGiust.EnabledItems[1]:=0;
      rgpTipoGiust.EnabledItems[2]:=0;
      rgpTipoGiust.EnabledItems[3]:=0;
    end
    else
    begin
      // ciclo di abilitazione dei tipi fruizione
      if rgpTipoCausale.ItemIndex = 0 then
      begin
        // causali di presenza
        if not Q275.SearchRecord('CODICE',cmbCausale.Text,[srFromBeginning]) then
        begin
          cmbCausale.Text:='';
          rgpTipoGiust.EnabledItems[0]:=0;
          rgpTipoGiust.EnabledItems[1]:=0;
          rgpTipoGiust.EnabledItems[2]:=0;
          rgpTipoGiust.EnabledItems[3]:=0;
        end
        else
        begin
          if Q275.FieldByName('UM_INSERIMENTO_H').AsString = 'S' then
            rgpTipoGiust.EnabledItems[2]:=1
          else
            rgpTipoGiust.EnabledItems[2]:=0;

          if Q275.FieldByName('UM_INSERIMENTO_D').AsString = 'S' then
            rgpTipoGiust.EnabledItems[3]:=1
          else
            rgpTipoGiust.EnabledItems[3]:=0;
        end;
      end
      else
      begin
        // causali di assenza
        if not Q265.SearchRecord('CODICE',cmbCausale.Text,[srFromBeginning]) then
        begin
          cmbCausale.Text:='';
          rgpTipoGiust.EnabledItems[0]:=0;
          rgpTipoGiust.EnabledItems[1]:=0;
          rgpTipoGiust.EnabledItems[2]:=0;
          rgpTipoGiust.EnabledItems[3]:=0;
        end
        else
        begin
          if Q265.FieldByName('UM_INSERIMENTO').AsString = 'S' then
            rgpTipoGiust.EnabledItems[0]:=1
          else
            rgpTipoGiust.EnabledItems[0]:=0;

          if Q265.FieldByName('UM_INSERIMENTO_MG').AsString = 'S' then
            rgpTipoGiust.EnabledItems[1]:=1
          else
            rgpTipoGiust.EnabledItems[1]:=0;

          if Q265.FieldByName('UM_INSERIMENTO_H').AsString = 'S' then
            rgpTipoGiust.EnabledItems[2]:=1
          else
            rgpTipoGiust.EnabledItems[2]:=0;

          if Q265.FieldByName('UM_INSERIMENTO_D').AsString = 'S' then
            rgpTipoGiust.EnabledItems[3]:=1
          else
            rgpTipoGiust.EnabledItems[3]:=0;
        end;
      end;
    end;
  end;
  // verifica che l'item attualmente selezionato sia abilitato
  if rgpTipoGiust.ItemIndex > -1 then
  begin
    i:=-1;
    while (rgpTipoGiust.EnabledItems[rgpTipoGiust.ItemIndex] = 0) do
    begin
      inc(i);
      if (i = rgpTipoGiust.Items.Count) then       //Tutti Disabilitati
      begin
        rgpTipoGiust.ItemIndex:=-1;
        Break;
      end;
      rgpTipoGiust.ItemIndex:=i;
    end;
  end;
  rgpTipoGiust.Invalidate;
  rgpTipoGiustAsyncClick(nil,nil);
end;

function TWA023FGestGiustFM.VerificaDati: String;
begin
  Result:='';
  if cmbCausale.Text = '' then
  begin
    MsgBox.WebMessageDlg(A000MSG_A023_ERR_NO_CAUS,mtError,[mbOk],nil,'');
    Abort;
  end
  else if cmbCausale.ItemIndex = -1 then
  begin
    MsgBox.WebMessageDlg(A000MSG_A023_ERR_CAUS_NO_ELENCO,mtError,[mbOk],nil,'');
    Abort;
  end;

  // AOSTA_REGIONE - chiamata 85647.ini
  // controlli per causale di assenza
  if rgpTipoCausale.ItemIndex = 1 then
  begin
    // se la causale originale NON ha la gestione visite fiscali
    // e quella modificata sì, si impedisca la modifica della causale
    if (CausOrig.VisitaFiscale = 'N') then
    begin
      if VarToStr((Self.Parent as TWA023FTimbrature).WA023FTimbratureDM.A023FTimbratureMW.Q265.Lookup('CODICE',cmbCausale.Text,'VISITA_FISCALE')) = 'S' then
        raise Exception.Create(A000TraduzioneStringhe(A000MSG_A023_ERR_MOD_VISITA_FISCALE_N_S));
    end;

    if ((Self.Parent as TWA023FTimbrature).WA023FTimbratureDM.A023FTimbratureMW.GetValStrT230(cmbCausale.Text,'CAUSALI_CHECKCOMPETENZE',DataOperazione) <> '') or
       ((Self.Parent as TWA023FTimbrature).WA023FTimbratureDM.A023FTimbratureMW.GetValStrT230(cmbCausale.Text,'CAUSALE_FRUIZORE',DataOperazione) <> '') or
       ((Self.Parent as TWA023FTimbrature).WA023FTimbratureDM.A023FTimbratureMW.GetValStrT230(cmbCausale.Text,'CAUSALE_HMASSENZA',DataOperazione) <> '')
    then
    begin
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_A023_ERR_NO_MOD_GIUST));
    end;
  end;
  // AOSTA_REGIONE - chiamata 85647.fine
  if rgpTipoGiust.ItemIndex = -1 then
  begin
    MsgBox.WebMessageDlg(A000MSG_A023_ERR_TIPO_GIUST,mtError,[mbOk],nil,'');
    Abort;
  end;

  if rgpTipoGiust.ItemIndex > 1 then
  begin
    try
      StrToTime(EdtDaOre.Text);
    except
      EdtDaOre.SetFocus;
      MsgBox.WebMessageDlg(A000MSG_A023_ERR_DAORE,mtError,[mbOk],nil,'');
      Abort;
    end;
  end;
  if rgpTipoGiust.ItemIndex = 3 then
  begin
    try
      StrToTime(EdtAOre.Text);
    except
      EdtAOre.SetFocus;
      MsgBox.WebMessageDlg(A000MSG_A023_ERR_AORE,mtError,[mbOk],nil,'');
      Abort;
    end;
    if (StrToTime(EdtDaOre.Text) > StrToTime(EdtAOre.Text)) and (R180OreMinutiExt(EdtAOre.Text) <> 0) then
    begin
      EDTAOre.SetFocus;
      MsgBox.WebMessageDlg(A000MSG_A023_ERR_PERIODO,mtError,[mbOk],nil,'');
      Abort;
    end;
  end;
end;

//Procedura richiamata da Thread Elaborazione ( per gestione MsgBox)
procedure TWA023FGestGiustFM.ConfermaDati(Sender: TObject);
var Msg,sCausale,DaOre,AOre: String;
  AssenzaOK,L133GGModif: boolean;
begin
  with (Self.Parent as TWA023FTimbrature).WA023FTimbratureDM.A023FTimbratureMW do
  begin
    if rgpTipoCausale.ItemIndex = 1 then
    begin
      Q265.SearchRecord('CODICE',cmbCausale.Text,[srFromBeginning]);
      if (cmbFamiliari.Text <> '') and
         (Q265.FieldByName('CUMULO_FAMILIARI').AsString = 'N') and
         (Q265.FieldByName('FRUIZIONE_FAMILIARI').AsString = 'N') then
        cmbFamiliari.Text:='';
    end
    else
    begin
      Q275.SearchRecord('CODICE',cmbCausale.Text,[srFromBeginning]);
      cmbFamiliari.Text:='';
    end;

    DaOre:=edtDaOre.Text;
    AOre:=edtAOre.Text;
    Msg:=VerificaCausaleTipoGiust(rgpTipoCausale.ItemIndex,DataOperazione,TipoGiust,cmbCausale.Text,CausOrig.Codice,(cmbFamiliari.Text <> ''),DaOre,AOre);
    if Msg <> '' then
    begin
      MsgBox.WebMessageDlg(Msg,mtError,[mbOk],nil,'');
      Abort;
    end;
    edtDaOre.Text:=DaOre;
    edtAOre.Text:=AOre;

    sCausale:=cmbCausale.Text;
    //Carico i dati della causale modificata
    NewGiustif.Inserimento:=True;
    NewGiustif.Modo:=TipoGiust;
    NewGiustif.Causale:=sCausale;//ECausale.Text;
    NewGiustif.DaOre:=EdtDaOre.Text;
    NewGiustif.AOre:=EdtAOre.Text;
    NewDataNas:=0;

    if cmbFamiliari.Text <> '' then
      NewDataNas:=StrToDateTime(cmbFamiliari.Text);
    //Controllo se il giustificativo è stato modificato
    if Modificato then
    begin
      (Self.Parent as TWA023FTimbrature).WA023FTimbratureDM.A023FTimbratureMW.ConfermaModifica(rgpTipoCausale.ItemIndex,
                                                                                               DataOperazione,
                                                                                               NewDataNas,
                                                                                               OldDataNas,
                                                                                               OldGiustif,
                                                                                               NewGiustif,
                                                                                               TipoGiust,
                                                                                               ProgCausOrig,
                                                                                               OldValidata,
                                                                                               NumGiustificativo,
                                                                                               L133GGModif);
      CompetenzeGiustifFuturi;
      RegistraB021;
      with (Self.Parent as TWA023FTimbrature).WA023FTimbratureDM.A023FTimbratureMW do
      begin
        Q040.Close;
        Q040.Open;
        R502ProDtM1.Q320.Close;
        if Ricarica then
          (Self.Parent as TWA023FTimbrature).CaricaCartellino
        else
          (Self.Parent as TWA023FTimbrature).CaricaGrid;
      end;
    end;
  end;
  //Riesame del 15/10/2013 su ativita WA023
  (Self.Parent as TWA023FTimbrature).grdCartellino.Visible:=True;
  DistruzioneFrame;
end;

procedure TWA023FGestGiustFM.CompetenzeGiustifFuturi;
var MsgCaus: String;
  Res: TmeIWModalResult;
begin
  // controllo competenze giustificativi futuri relativi alla causale vecchia e a quella nuova
  if Parametri.CampiRiferimento.C23_ContrCompetenze = 'S' then
  begin
    if OldDataNas = 0 then
      StrOldDataNas:=''
    else
      StrOldDataNas:=DateTimeToStr(OldDataNas);
    if NewDataNas = 0 then
      StrNewDataNas:=''
    else
      StrNewDataNas:=DateTimeToStr(NewDataNas);
    with (Self.Parent as TWA023FTimbrature).WA023FTimbratureDM.A023FTimbratureMW do
    begin
      Ng1:=R600DtM1.ContaGiustifAssFuturi(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,DataOperazione,OldGiustif,StrOldDataNas);
      if (OldGiustif.Causale <> NewGiustif.Causale) or (OldDataNas <>  NewDataNas) then
        Ng2:=R600DtM1.ContaGiustifAssFuturi(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,DataOperazione,NewGiustif,StrNewDataNas)
      else
        Ng2:=0;
      if (Ng1 + Ng2 > 0) then
      begin
        MsgCaus:=Format(A000MSG_A023_MSG_FMT_NCAUS,[IntToStr(Ng1),OldGiustif.Causale]);
        if (OldGiustif.Causale <> NewGiustif.Causale) then
          MsgCaus:=MsgCaus + Format(A000MSG_A023_MSG_FMT_NCAUS,[IntToStr(Ng2),NewGiustif.Causale]);

        //Utente: MONDOEDP - Chiamata: 94319: Gestione ThreadElaborazione
        if ThreadElaborazione = nil then
        begin
          MsgBox.WebMessageDlg(Format(A000MSG_A023_DLG_FMT_RIALLINEA,[MsgCaus]),mtConfirmation,[mbYes, mbNo],ResultAllineaCompetenzeGiustif,'');
          Abort;
        end
        else
        begin
          Res:=MsgBox.WebMessageDlg(Format(A000MSG_A023_DLG_FMT_RIALLINEA,[MsgCaus]),mtConfirmation,[mbYes, mbNo],nil,'');
          ResultAllineaCompetenzeGiustif(Self,Res,'');
        end;

      end;
    end;
  end;
end;

function TWA023FGestGiustFM.Modificato:Boolean;
begin
  Result:=False;
  if OldGiustif.Causale <> NewGiustif.Causale then Result:=True;
  if OldGiustif.Modo <> NewGiustif.Modo then Result:=True;
  if OldGiustif.DaOre <> NewGiustif.DaOre then Result:=True;
  if OldGiustif.AOre <> NewGiustif.AOre then Result:=True;
  if (OldDataNas <> NewDataNas) and (rgpTipoCausale.ItemIndex = 1) then
    Result:=True;
end;
procedure TWA023FGestGiustFM.btnChiudiClick(Sender: TObject);
var msg: String;
begin
  inherited;
  Ricarica:=False;
  if Sender = btnConferma then
  begin
    msg:=VerificaDati;

    if Msg <> '' then
    begin
      MsgBox.WebMessageDlg(Msg,mtError,[mbOk],ResultConfermaDati,'');
      Abort;
    end;
    StartThreadElaborazione(ConfermaDati,Self);
  end
  else
  begin
    //Riesame del 15/10/2013 su ativita WA023
    (Self.Parent as TWA023FTimbrature).grdCartellino.Visible:=True;
    DistruzioneFrame;
  end;
end;

procedure TWA023FGestGiustFM.ResultConfermaDati(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  CompetenzeGiustifFuturi;
  RegistraB021;
  DistruzioneFrame;
end;

procedure TWA023FGestGiustFM.ResultAllineaCompetenzeGiustif(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  with (Self.Parent as TWA023FTimbrature).WA023FTimbratureDM.A023FTimbratureMW do
  begin
    if Res = mrYes then
    begin
      if Ng1 > 0 then
        R600DtM1.GestioneGiustifAssFuturi(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,DataOperazione - 1,OldGiustif,StrOldDataNas);
      if Ng2 > 0 then
        R600DtM1.GestioneGiustifAssFuturi(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,DataOperazione - 1,NewGiustif,StrNewDataNas);
      Ricarica:=True;
    end;
  end;
  //Utente: MONDOEDP - Chiamata: 94319: Gestione ThreadElaborazione
  if ThreadElaborazione = nil then
  begin
    RegistraB021;
    DistruzioneFrame;
  end;

end;

procedure TWA023FGestGiustFM.RegistraB021;
begin
  with (Self.Parent as TWA023FTimbrature).WA023FTimbratureDM.A023FTimbratureMW do
  begin
    B021FWebSvcClientDtM.ResetRecordT040;
    B021FWebSvcClientDtM.RegistraRecordT040('I',Q040,rgpTipoCausale.ItemIndex,'');//Per successiva chiamata al web sevice (Firlab)
    if B021FWebSvcClientDtM.EsisteRecordT040 then
    begin
      B021FWebSvcClientDtM.WebSvcRecordT040;
    end;
  end;
end;

procedure TWA023FGestGiustFM.DistruzioneFrame;
begin
  with (Self.Parent as TWA023FTimbrature).WA023FTimbratureDM.A023FTimbratureMW do
  begin
    FreeAndNil(R600DtM1);
    getDataGestGiustif:=nil;
    getCausaleGestGiustif:=nil;
    Q265.Filtered:=False;
    Q275.Filtered:=False;
  end;
  ReleaseOggetti;
  Free;
end;

end.
