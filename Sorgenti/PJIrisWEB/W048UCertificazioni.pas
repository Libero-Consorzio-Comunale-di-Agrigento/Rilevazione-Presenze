unit W048UCertificazioni;

interface

uses
  A000UCostanti, A000USessione, A000UInterfaccia, A000UMessaggi, W000UMessaggi,
  A023UTimbratureMW, A023UAllTimbMW, R010UPaginaWeb, R012UWebAnagrafico, R013UIterBase,
  W005UCartellinoFM, W048UCertificazioniDM,
  C018UIterAutDM, C180FunzioniGenerali, C190FunzioniGeneraliWeb,
  IWApplication, IWAppForm, SysUtils, Classes, Graphics, Controls, Math, StrUtils,
  IWControl, IWHTMLControls, IWCompListbox, IWCompEdit,
  OracleData, IWCompCheckbox, DatiBloccati, IWDBGrids, Variants,
  IWVCLBaseControl, meIWCheckBox, Forms, IWVCLBaseContainer, IWContainer,
  meIWGrid, DB, IWCompMemo, Oracle, ActnList, meIWMemo, DBClient,
  meTIWAdvRadioGroup, medpIWDBGrid, medpIWMessageDlg, meIWImageFile, meIWButton,
  meIWEdit, meIWLabel, meIWComboBox, IWCompGrids, IWCompExtCtrls, meIWLink,
  IWCompButton, Menus, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompLabel, IWBaseControl, IWBaseHTMLControl,
  IW.Browser.InternetExplorer, medpIWMultiColumnComboBox, IWHTMLContainer, IWHTML40Container, IWRegion, meIWRegion, System.Generics.Collections;

type
  TCertificazioni = record
    ID: Integer;
    Codice:String;
    Valore:String;
  end;

  TRecordRichiesta = record
    Operazione:String;
    Data,Dal,Al: TDateTime;
    Descrizione:String;
    IDCertificazione: Integer;
    Definitiva: Boolean;
    DatiPers: TDictionary<String,TDatoPersonalizzato>;
  end;

  TAutorizza = record
    Rowid:String;
    Checked:Boolean;
    Caption:TCaption;
    Operazione:String;
  end;

  TW048FCertificazioni = class(TR013FIterBase)
    dsrSG230: TDataSource;
    cdsSG230: TClientDataSet;
    rgDettaglio: TmeIWRegion;
    grdDati: TmeIWGrid;
    tpDettaglio: TIWTemplateProcessorHTML;
    lblDescCert: TmeIWLabel;
    lblFiltroModello: TmeIWLabel;
    cmbFiltroModello: TmeIWComboBox;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure grdRichiesteAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure grdRichiesteRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure chkAutorizzazioneClick(Sender: TObject);
  private
    FData: TDateTime;
    FArrCertificazioni: array of TCertificazioni;
    FAutorizza: TAutorizza;
    FRichiesta: TRecordRichiesta;
    FStileCella1: String;
    FStileCella2: String;
    //FFiltroModello: String;
    W048DM: TW048FCertificazioniDM;
    FDatiTimb: TDatiRichiestaTimb;
    function ControlliOK(FN:String): Boolean;
    function ControlliPeriodo(FN: string; pQ: integer; pUM: Char): Boolean;
    function CtrlSalvaDatiPersonalizzati: TResCtrl;
    function IDCertificazione(pLIWCmb: TmeIWComboBox): Integer;
    function RimuoviTagHTML(pStr: string): String;
    function VerificaEsistenza(pRowID: String): Boolean;
    function VerificaEsistenzaModello(pRowID: String): Boolean;
    procedure actCancRichiesta(const FN: String);
    procedure actInsRichiesta(FN: String);
    procedure actModRichiesta(FN: String);
    procedure ConfermaInsRichiesta;
    procedure ConfermaModRichiesta;
    procedure AutorizzazioneOK;
    procedure Autocertificazione;
    procedure CaricaDatiPersonalizzati;
    procedure cmbCertificazioneChange(Sender: TObject);
    procedure GetDatiTabellari;
    procedure grdRichiesteColumnClick(ASender: TObject; const AValue: string);
    procedure imgAllegClick(Sender: TObject);
    procedure imgAnnullaClick(Sender: TObject);
    procedure imgCancellaClick(Sender: TObject);
    procedure imgConfermaClick(Sender: TObject);
    procedure imgInserisciClick(Sender: TObject);
    procedure imgIterClick(Sender: TObject);
    procedure imgModificaClick(Sender:TObject);
    procedure PosizionamentoMultiColumnText(PCmb: TMedpIWMultiColumnComboBox; const PValore: String; const PCodLen: Integer);
    procedure SchemaDatiPersonalizzati(pID: Integer; rIter: Integer = 0);
    procedure SetAutorizzazione(Sender: TObject);
    procedure TrasformaComponenti(const FN:String);
    procedure VariabiliQueryValore(DS:TOracleDataset);
    procedure W018AutorizzaTutto(Sender: TObject; var Ok: Boolean);
    procedure W048ApplicaFiltro(Sender: TObject);
  protected
    procedure RefreshPage; override;
    procedure GetDipendentiDisponibili(Data:TDateTime); override;
    procedure VisualizzaDipendenteCorrente; override;
    procedure DistruggiOggetti; override;
  public
    function  InizializzaAccesso:Boolean; override;
  end;

implementation

{$R *.DFM}

function TW048FCertificazioni.InizializzaAccesso:Boolean;
const
  FUNZIONE = 'InizializzaAccesso';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  Result:=True;
  GetDipendentiDisponibili(FData);
  selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]);

  if WR000DM.Responsabile then
  begin
    // seleziona l'item "tutti i dipendenti" (o l'unico della lista)
    cmbDipendentiDisponibili.ItemIndex:=0;
    medpAutorizzaMultiplo:=True;
    OnAutorizzaTutto:=W018AutorizzaTutto;

    btnTuttiSi.Caption:='Valida tutto';
    btnTuttiSi.Confirmation:='Validare tutte le schede informative?';
    btnTuttiNo.Caption:='Nega tutto';
    btnTuttiNo.Confirmation:='Negare la validazione a tutte le schede informative?';
  end
  else
  begin
    // se data filtro è specificata -> funzione chiamata dal cartellino
    if ParametriForm.DataFiltro = 0 then
      ParametriForm.DataFiltro:=Date;
  end;

  GetDatiTabellari;

  cmbFiltroModello.Items.BeginUpdate;
  cmbFiltroModello.Items.Add('');
  cmbFiltroModello.ItemIndex:=0;
  with W048DM.selSG235c do
  begin
    First;
    while not Eof do
    begin
      cmbFiltroModello.Items.Add(FieldByName('CODICE').AsString);
      Next;
    end;
  end;
  cmbFiltroModello.Items.EndUpdate;

  OnApplicaFiltro:=W048ApplicaFiltro;

  C018.TipoRichiestaCaption[trDaAutorizzare]:=A000TraduzioneStringhe('da validare');
  C018.TipoRichiestaCaption[trAutorizzate]:=A000TraduzioneStringhe('validate');

  // visualizza i dati del dipendente selezionato
  VisualizzaDipendenteCorrente;

  grdDati.RowCount:=0;
  lblDescCert.Caption:='';

  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW048FCertificazioni.VariabiliQueryValore(DS:TOracleDataset);
var lstVariabili:TStringList;
    i:Integer;
begin
  lstVariabili:=FindVariables(DS.SQL.Text, False);
  try
    for i:=0 to lstVariabili.Count - 1 do
    begin
      if W048DM.selSG230.FindField(lstVariabili[i]) = nil then
        Continue;
      if W048DM.selSG230.FindField(lstVariabili[i]) is TDateTimeField then
        DS.DeclareVariable(lstVariabili[i],otDate)
      else if W048DM.selSG230.FindField(lstVariabili[i]) is TIntegerField then
        DS.DeclareVariable(lstVariabili[i],otInteger)
      else
        DS.DeclareVariable(lstVariabili[i],otString);
      if grdRichieste.medpStato = msInsert then
      begin
        if lstVariabili[i].ToUpper = 'PROGRESSIVO' then
          DS.SetVariable(lstVariabili[i],selAnagrafeW.FieldByName('PROGRESSIVO').Value)
      end
      else
        DS.SetVariable(lstVariabili[i],W048DM.selSG230.FieldByName(lstVariabili[i]).Value);
    end;
  finally
    FreeAndNil(lstVariabili);
  end;
end;

procedure TW048FCertificazioni.SchemaDatiPersonalizzati(pID: Integer; rIter: Integer = 0);  //pId = SG235.ID della certificazione
//Prepara i campi input dei dati personalizzati
var
  Codice, Descrizione, Categoria, CategoriaPrec, Valori, DatoAnagrafico, QueryValore, ElencoFisso,
  Tabella, TabCodice, TabStorico, WidthCss, HintCampo, StileCampo, S,
  ValoreDefault, TestoSQLQueryValore, Valore, SQLValidazione: String;
  LFormato: Char;
  rDato, LungMax, FaseCorr, FaseLiv, MinFaseMod, MaxFaseMod, Righe: Integer;
  Obbligatorio, PrimaRottura, Elenco, ElencoTabellare, AbilRiga: Boolean;
  DatoPers: TDatoPersonalizzato;
  IWLbl: TmeIWLabel;
  IWC: TIWCustomControl;
  LIWCmb: TMedpIWMultiColumnComboBox;
  DSValori: TOracleDataSet;
  strHTML:string;
  IWChb: TmeIWCheckBox;
  DefDAL, DefAL : String;  //Date DAL-AL di default da campo PERIODO SG235
  LIWEdtDAL,LIWEdtAL: TmeIWEdit;
  LIWChbDef: TmeIWCheckBox;
const
  DATI_PERS_MAXWIDTH_CHAR = 40;   // num. max di caratteri per la width del dato personalizzato (la max-length rimane invariata!)
  DATI_PERS_MAXLENGTH     = 2000; // num. max di caratteri su database per i dati personalizzati
begin
  JavaScript.Clear;
  JavaScript:=TStringList.Create;

  // tabella dei dati personalizzati
  grdDati.RowCount:=1;
  CategoriaPrec:='';
  PrimaRottura:=True;

  with W048DM.selSG235b do
  begin
    Close;
    SetVariable('ID', pID);
    Open;
    W048DM.selSG235.Locate('ID',pID,[]); //selSG235 deve essere allineato a selSG235b!
    if RecordCount > 0 then
    begin
      //Gestione della descrizione della certificazione
      lblDescCert.Caption:=FieldByName('Descrizione').AsString.Replace(sLineBreak, '<br>');
      //Gestione del periodo di default (la riga di inserimento è sempre la 0)
      LIWEdtDAL:=(grdRichieste.medpCompCella(rIter,grdRichieste.medpIndexColonna('DAL'),0) as TmeIWEdit);
      LIWEdtAL:=(grdRichieste.medpCompCella(rIter,grdRichieste.medpIndexColonna('AL'),0) as TmeIWEdit);
      if assigned(LIWEdtDAL) and assigned(LIWEdtAL) and
         not (grdRichieste.medpValoreColonna(rIter,'TIPO_RICHIESTA') = 'D') then
      begin
        if rIter = 0 then  //Nuova certificazione -> pulisce i campi DAL-AL
        begin
          LIWEdtDAL.Text := '';
          LIWEdtAL.Text := '';
        end;
        if (LIWEdtDAL.Text = '') and (LIWEdtAL.Text = '')
           and (FieldByName('PERIODO').AsString <> '') then
        try
          W048DM.selQueryPeriodo.SetVariable('PERIODO', FieldByName('PERIODO').AsString);
          W048DM.selQueryPeriodo.Execute;
          LIWEdtDAL.Text:=W048DM.selQueryPeriodo.FieldAsString(0);
          if W048DM.selQueryPeriodo.FieldCount = 1 then
            LIWEdtAL.Text:=W048DM.selQueryPeriodo.FieldAsString(0)
          else
            LIWEdtAL.Text:=W048DM.selQueryPeriodo.FieldAsString(1);
        except
          on E:Exception do
          begin
            R180MessageBox('Lettura del periodo di default fallita: ' + E.Message,ESCLAMA);
          end;
        end;

        //Campi DAL-AL bloccati
        LIWEdtDAL.Enabled:=(FieldByName('PERIODO_MODIFICABILE').AsString = 'S') and not (grdRichieste.medpValoreColonna(rIter,'TIPO_RICHIESTA') = 'D');
        LIWEdtAL.Enabled:=LIWEdtDAL.Enabled;
      end;

      //GESTIONE CAMPO 'D_TIPO_RICHIESTA' ABILITATO SI/NO
      if grdRichieste.medpIndexColonna('D_TIPO_RICHIESTA') >= 0 then
      begin
        LIWChbDef:=(grdRichieste.medpCompCella(rIter,grdRichieste.medpIndexColonna('D_TIPO_RICHIESTA'),0) as TmeIWCheckBox);
        if assigned(LIWChbDef) then
        begin
          W048DM.selSG237CampiInput.SetVariable('ID', IntToStr(pID));
          W048DM.selSG237CampiInput.Execute;
          //Se non ci sono campi di input la richiesta è subito definitiva e bloccata
          LIWChbDef.Checked:=(W048DM.selSG237CampiInput.FieldAsInteger(0) = 0) or ((LIWChbDef.Checked) and (rIter > 0));
          LIWChbDef.Enabled:=not (W048DM.selSG237CampiInput.FieldAsInteger(0) = 0);
        end;
      end;
    end
    else
      lblDescCert.Caption:='';
  end;
  rDato:=0;
  with W048DM.selSG236SG237 do
  begin
    Close;
    SetVariable('ID',pID);
    Open;

    while not Eof do
    begin
      Codice:=FieldByName('COD_DATO').AsString;
      Descrizione:=FieldByName('DESC_DATO').AsString;
      Categoria:=FieldByName('COD_CAT').AsString;

      // dati personalizzati
      DSValori:=nil;

      // gestione rottura di categoria
      if Categoria <> CategoriaPrec then
      begin
        // 1/3 bordo superiore (esclude prima rottura di categoria)
        if not PrimaRottura then
        begin
          grdDati.Cell[rDato,0].Css:='riga_bianca bordo_top_categoria';
          grdDati.Cell[rDato,0].Text:='';
          grdDati.Cell[rDato,1].Css:='riga_bianca bordo_top_categoria';
          grdDati.Cell[rDato,1].Text:=' ';
          grdDati.RowCount:=grdDati.RowCount + 1;
          inc(rDato);
        end;

        // 2/3 riga di descrizione della categoria
        grdDati.Cell[rDato,0].Css:='riga_categoria';
        grdDati.Cell[rDato,0].Text:='<div style="position:relative; height:100%; text-align:center">' +
                                 FieldByName('DESC_CAT').AsString.Replace(sLineBreak, '<br>') +
                                 '</div>';
        grdDati.Cell[rDato,0].RawText:=True;
        grdDati.Cell[rDato,1].Css:='riga_categoria';
        grdDati.Cell[rDato,1].Text:=' ';
        grdDati.RowCount:=grdDati.RowCount + 1;

        if Trim(FieldByName('DESC_CAT').AsString) <> '' then
        begin //Imposta il Javascript per unire le colonne della riga "Categoria" (solo se il testo non è nullo)
          if JavaScript.Count = 0 then
            JavaScript.Add('$(document).ready(function(){');
          JavaScript.Add('$("#TBLGRDDATI").find("tr:nth-child(' + IntToStr(rDato+1) + ')").find("td:first").attr("colspan", "2")');
          JavaScript.Add('$("#TBLGRDDATI").find("tr:nth-child(' + IntToStr(rDato+1) + ')").find("td:nth-child(2)").remove()');
        end;
        inc(rDato);

        // 3/3 bordo inferiore
        grdDati.Cell[rDato,0].Css:='riga_bianca bordo_sx_categoria lineHeight0_5em';
        grdDati.Cell[rDato,0].Text:='';
        grdDati.Cell[rDato,1].Css:='riga_bianca bordo_dx_categoria lineHeight0_5em';
        grdDati.Cell[rDato,1].Text:=' ';
        grdDati.RowCount:=grdDati.RowCount + 1;
        inc(rDato);

        PrimaRottura:=False;
      end;

      // informazioni sul dato
      Valori:=FieldByName('VALORI').AsString.Replace(sLineBreak, '<br>');
      Obbligatorio:=FieldByName('OBBLIGATORIO').AsString = 'S';
      LFormato:=R180CarattereDef(FieldByName('FORMATO').AsString);
      Righe:=1;
      if LFormato = 'S' then
        Righe:=FieldByName('RIGHE').AsInteger;
      LungMax:=FieldByName('LUNG_MAX').AsInteger;
      DatoAnagrafico:=FieldByName('DATO_ANAGRAFICO').AsString;
      QueryValore:=FieldByName('QUERY_VALORE').AsString;
      ElencoFisso:=FieldByName('ELENCO_FISSO').AsString;
      ValoreDefault:=FieldByName('VALORE_DEFAULT').AsString;
      HintCampo:=FieldByName('HINT').AsString;
      Elenco:=(QueryValore <> '') or (DatoAnagrafico <> '') or (Valori <> '');    //indica se il dato è selezionabile da elenco oppure no
      SQLValidazione:=FieldByName('Validazione').AsString;

      // cerca di capire se il dato è tabellare (codice + descrizione) o meno
      ElencoTabellare:=False;
      if QueryValore <> '' then
      begin
        // elenco valori estratto da interrogazione di servizio
        W048DM.selQueryValore.SetVariable('NOME',QueryValore);
        try
          W048DM.selQueryValore.Execute;
          TestoSQLQueryValore:=W048DM.selQueryValore.FieldAsString(0);
        except
          TestoSQLQueryValore:='';
        end;

        if TestoSQLQueryValore <> '' then
        begin
          // crea e imposta proprietà dataset
          DSValori:=TOracleDataSet.Create(Self);
          DSValori.Session:=SessioneOracle;
          DSValori.ReadBuffer:=50;
          DSValori.ReadOnly:=True;

          // imposta testo e variabili sql
          DSValori.Close;
          DSValori.SQL.Text:=TestoSQLQueryValore;
          // gestione variabili
          DSValori.ClearVariables;
          DSValori.DeleteVariables;

          VariabiliQueryValore(DSValori);

          try
            DSValori.Open;
            ElencoTabellare:=DSValori.FieldCount >= 1;
          except
            raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_W032_ERR_FMT_QUERY_VALORE),
                                          [FieldByName('DESCRIZIONE').AsString,QueryValore]));
          end;
        end;
      end
      else if DatoAnagrafico <> '' then
      begin
        // elenco valori estratto da dato anagrafico
        A000GetTabella(DatoAnagrafico,Tabella,TabCodice,TabStorico);
        ElencoTabellare:=(Tabella <> '') and (Tabella.ToUpper <> 'T430_STORICO');
      end;

      // imposta l'oggetto da associare all'elemento dell'interfaccia come medpTag
      if LFormato in ['M','T','U'] then
      begin
        DatoPers:=nil;
      end
      else
      begin
        DatoPers:=TDatoPersonalizzato.Create;
        DatoPers.Codice:=Codice;
        DatoPers.Descrizione:=Descrizione;
        DatoPers.Obbligatorio:=Obbligatorio;
        DatoPers.Formato:=LFormato;
        DatoPers.LungMax:=LungMax;
        DatoPers.DatoAnagrafico:=DatoAnagrafico;
        DatoPers.QueryValore:=QueryValore;
        DatoPers.Elenco:=Elenco;
        DatoPers.ElencoTabellare:=ElencoTabellare;
        DatoPers.LungCodice:=0;
        DatoPers.ElencoFisso:=ElencoFisso;
        DatoPers.ValoreDefault:=ValoreDefault;
        DatoPers.CodCategoria:=Categoria;
        DatoPers.Hint:=HintCampo;
        DatoPers.AbilitaModifica:=True;  //Modifica sempre possibile per ora
        DatoPers.ValoreStr:='';
        DatoPers.SQLValidazione:=SQLValidazione;
      end;

      //imposta stili campo in base al formato
      WidthCss:=C190GetCssWidthChr(IfThen(LungMax = 0,DATI_PERS_MAXWIDTH_CHAR,LungMax));
      case LFormato of
      // messaggio
      'M': begin
             StileCampo:=WidthCss;
             //HintCampo:='formato: messaggio';
           end;
      // stringa
      'S': begin
             StileCampo:=WidthCss + IfThen(Righe > 1,Format(' height%d',[Righe]));
             //HintCampo:=HintCampo + 'formato: alfanumerico' + Format(' (%d righe) (max %d caratteri)',[Righe,IfThen(LungMax = 0,2000,LungMax)]);
           end;
      // numero
      'N': begin
             case LungMax of
                   0: StileCampo:='input_num_generic';                        // 0   : input_num_generic  (cifre intere, 2 decimali)
                1..5: StileCampo:='input_num_' + StringOfChar('n',LungMax);   // 1..5: input_num_n..nnnnn (n cifre intere, 0 decimali)
             else     StileCampo:='input_integer_15';                            // >5  : input_integer      (cifre intere, 0 decimali), limitato da codice
             end;
             StileCampo:=WidthCss + ' ' + StileCampo;
             //HintCampo:=HintCampo + 'formato: numerico ' + IfThen(LungMax = 0,'decimale',Format('intero (max %d cifre)',[LungMax]));
           end;
      // data dd/mm/yyyy
      'D': begin
             StileCampo:='input_data_dmy';
             //HintCampo:=HintCampo + 'formato: data (gg/mm/aaaa)';
           end;
      // link
      'U': begin
             StileCampo:='';
             //HintCampo:='';
           end;
      // testo su entrambe le colonne - incompleto!
      'T': begin
             StileCampo:=WidthCss;
             //HintCampo:='formato: messaggio';
           end;
      //Checkbox
      'C': begin
             StileCampo:='';
             //HintCampo:='';
           end;
      else
        raise Exception.Create(Format('Formato del dato personalizzato non previsto: %s',[LFormato]));
      end;
      //HintCampo:=HintCampo + '<br>';

      //COMPONENTI DI INPUT
      if LFormato in ['M','T'] then
        strHTML:=Valori
      else if LFormato = 'U' then
        strHTML:='<a href="' + copy(Valori,Valori.IndexOf(',')+2, Valori.Length-Valori.IndexOf(',')) + '" target="_blank">'
                 + copy(Valori,0, Valori.IndexOf(',')) + '</a>'
      else if LFormato = 'C' then
      begin
        IWC:=C190DBGridCreaChkBox(Self,Self,DatoPers.Codice,Valori);
        IWChb:=(IWC as TmeIWCheckBox);
        IWChb.Checked:=DatoPers.ValoreDefault='S';
        IWChb.medpTag:=DatoPers;
      end
      else if Elenco then
      begin
        // dato selezionabile da un elenco fisso: combobox con elenco di valori
        IWC:=C190DBGridCreaMedpMultiColCombo(Self,Self,DatoPers.Codice,WidthCss + IfThen(ElencoTabellare,' fontcourier'),'1');
        LIWCmb:=(IWC as TMedpIWMultiColumnComboBox);
        LIWCmb.medpTag:=DatoPers;
        LIWCmb.ColCount:=1;
        LIWCmb.CodeColumn:=0;
        if ElencoTabellare then
          LIWCmb.CssPopup:='fontcourier';
        LIWCmb.CustomElement:=ElencoFisso = 'N';

        if QueryValore <> '' then
        begin
          // gestione query valore
          if TestoSQLQueryValore = '' then
          begin
            //HintCampo:=HintCampo + Format('tipo: query_valore [%s] [NON INDICATA]',[QueryValore]);
          end
          else
          begin
            //HintCampo:=HintCampo + Format('tipo: query_valore [%s] [%s]',[QueryValore,IfThen(ElencoTabellare,'tabellare','semplice')]);
            // popola multicolumn con valori
            // nota: il dataset è già stato aperto per determinare se il dato è tabellare
            if (DSValori <> nil) and (DSValori.Active) then
            begin
              // determina lunghezza codice se dato tabellare
              if ElencoTabellare then
              begin
                DatoPers.LungCodice:=DSValori.Fields[0].Size;
                // se Size = 0 lo leggo esplicitamente
                if DatoPers.LungCodice = 0 then
                begin
                  DSValori.First;
                  while not DSValori.Eof do
                  begin
                    if DSValori.Fields[0].AsString.Length > DatoPers.LungCodice then
                      DatoPers.LungCodice:=DSValori.Fields[0].AsString.Length;
                    DSValori.Next;
                  end;
                end;
                //HintCampo:=HintCampo + Format(', lung. codice = %d',[DatoPers.LungCodice]);
              end;
              // popolamento combobox
              DSValori.First;
              while not DSValori.Eof do
              begin
                if ElencoTabellare then
                begin
                  if DSValori.FieldCount > 1 then
                    LIWCmb.AddRow(Format('%-*s - %s',[DatoPers.LungCodice,DSValori.Fields[0].AsString,DSValori.Fields[1].AsString]))
                  else
                    LIWCmb.AddRow(Format('%-*s',[DatoPers.LungCodice,DSValori.Fields[0].AsString]))
                end
                else
                  LIWCmb.AddRow(DSValori.Fields[0].AsString);
                DSValori.Next;
              end;
            end;
          end;
        end
        else if DatoAnagrafico <> '' then
        begin
          // dato anagrafico
          //HintCampo:=HintCampo + Format('tipo: dato_anagrafico [%s] [%s]',[DatoAnagrafico,IfThen(ElencoTabellare,'tabellare','semplice')]);

          // se è indicato il dato anagrafico estrae l'elenco di valori in base a questo
          if A000LookupTabella(DatoAnagrafico,WR000DM.selDatoLibero) then
          begin
            // popola multicolumn con valori
            if WR000DM.selDatoLibero.VariableIndex('DECORRENZA') >= 0 then
              WR000DM.selDatoLibero.SetVariable('DECORRENZA',R180FineMese(Parametri.DataLavoro));
            WR000DM.selDatoLibero.Open;
            if ElencoTabellare then
            begin
              DatoPers.LungCodice:=WR000DM.selDatoLibero.Fields[0].Size;
              //HintCampo:=HintCampo + Format(', lung. codice = %d',[DatoPers.LungCodice]);
            end;
            WR000DM.selDatoLibero.First;
            // ciclo di popolamento della combo
            if R180In(Valori, ['C','P']) then
            begin
              // valori assunti dal dato anagrafico per il richiedente
              W048DM.selT430.SetVariable('PROGRESSIVO', ParametriForm.Progressivo);
              W048DM.selT430.SetVariable('DATO', DatoAnagrafico);
              W048DM.selT430.SetVariable('CORRENTE', IfThen(Valori = 'C','S','N'));
              W048DM.selT430.Open;
              while not W048DM.selT430.Eof do
              begin
                if ElencoTabellare then
                  LIWCmb.AddRow(Format('%-*s - %s',[DatoPers.LungCodice,W048DM.selT430.FieldByName('DATO').AsString,VarToStr(WR000DM.selDatoLibero.Lookup('CODICE',W048DM.selT430.FieldByName('DATO').AsString,'DESCRIZIONE'))]))
                else
                  LIWCmb.AddRow(W048DM.selT430.FieldByName('DATO').AsString);
                W048DM.selT430.Next;
              end;
              W048DM.selT430.Close;
            end
            else
            begin
              while not WR000DM.selDatoLibero.Eof do
              begin
                if ElencoTabellare then
                  LIWCmb.AddRow(Format('%-*s - %s',[DatoPers.LungCodice,WR000DM.selDatoLibero.FieldByName('CODICE').AsString,WR000DM.selDatoLibero.FieldByName('DESCRIZIONE').AsString]))
                else
                  LIWCmb.AddRow(WR000DM.selDatoLibero.FieldByName('CODICE').AsString);
                WR000DM.selDatoLibero.Next;
              end;
            end;
            WR000DM.selDatoLibero.Close;
          end;
        end
        else
        begin
          // elenco di valori fissi
          //HintCampo:=HintCampo + 'tipo: elenco valori fissi';

          // popola multicolumn con valori
          for S in Valori.Split([',']) do
            LIWCmb.AddRow(S);
        end;
        //HintCampo:=HintCampo + Format('<br>valore default: %s<br>custom element: %s',[IfThen(DatoPers.ValoreDefault = '','[non definito]',DatoPers.ValoreDefault),IfThen(LIWCmb.CustomElement,'sì','no')]);

        // se è presente un solo elemento nella combobox, questa viene eliminata
        // e sostituita da un edit
        if LIWCmb.Items.Count = 1 then
        begin
          LIWCmb.Text:=LIWCmb.Items[0].RowData[0];
          (*
          // salva il valore del dato e distrugge la combobox
          Valore:=LIWCmb.Items[0].RowData[0];
          LIWCmb.medpTag:=nil; // pulisce il puntatore all'oggetto medpTag in modo che non venga distrutto dalla free successiva
          FreeAndNil(IWC);

          // crea un edit
          IWC:=C190DBGridCreaEdit(Self,Self,DatoPers.Codice,StileCampo,'');

          // maxlength per campi alfanumerici
          // non impostare per campi numerici: problemi con il plugin autonumeric!
          if DatoPers.Formato = 'S' then
            TmeIWEdit(IWC).MaxLength:=IfThen(LungMax = 0,DATI_PERS_MAXLENGTH,LungMax);
          TmeIWEdit(IWC).medpTag:=DatoPers;
          TmeIWEdit(IWC).Text:=Valore;
          *)
        end
        else if DatoPers.ValoreDefault <> '' then
          LIWCmb.Text:=DatoPers.ValoreDefault
        else
        begin
          LIWCmb.Text:='';
          LIWCmb.ItemIndex:=-1;
        end;
      end
      else
      begin
        // dato personalizzato: edit / memo
        //HintCampo:=HintCampo + 'tipo: dato personalizzato';
        if Righe = 1 then
        begin
          // 1 riga: crea un edit
          IWC:=C190DBGridCreaEdit(Self,Self,DatoPers.Codice,StileCampo,'');
          // maxlength per campi alfanumerici
          // non impostare per campi numerici: problemi con il plugin autonumeric!
          if DatoPers.Formato = 'S' then
            TmeIWEdit(IWC).MaxLength:=IfThen(LungMax = 0,DATI_PERS_MAXLENGTH,LungMax);
          TmeIWEdit(IWC).medpTag:=DatoPers;
        end
        else
        begin
          // n>1 righe: crea un memo
          IWC:=TmeIWMemo.Create(Self);
          TmeIWMemo(IWC).Parent:=rgDettaglio; // bug TIWMemo -> non impostare il Parent = Self (form): per funzionare deve essere impostata = alla region di dettaglio
          TmeIWMemo(IWC).Css:=StileCampo;
          TmeIWMemo(IWC).Font.Enabled:=False;
          TmeIWMemo(IWC).FriendlyName:=DatoPers.Descrizione;
          TmeIWMemo(IWC).medpTag:=DatoPers;
          TmeIWMemo(IWC).RenderSize:=False;
          TmeIWMemo(IWC).Tag:=1;
        end;
        //HintCampo:=HintCampo + Format('<br>valore default: %s',[IfThen(DatoPers.ValoreDefault = '','[non definito]',DatoPers.ValoreDefault)]);
      end;

      // imposta label e css per cella sx
      IWLbl:=C190DBGridCreaLabel(Self,Self,Codice);
      //Sostituisce carattere "a capo"
      IWLbl.Caption:=IfThen(Obbligatorio,'(*) ') + FieldByName('DESC_DATO').AsString.Replace(sLineBreak, '<br>');
      //Interpreta il codice html contenuto
      IWLbl.RawText:=True;

      IWLbl.Css:='intestazione';
      IWLbl.ForControl:=IWC;
      {$WARN SYMBOL_PLATFORM OFF}
      IWLbl.Hint:=IfThen(DebugHook <> 0,'<html>' + HintCampo);
      IWLbl.ShowHint:=(DebugHook <> 0);
      {$WARN SYMBOL_PLATFORM ON}

      if HintCampo <> '' then
      begin
        IWLbl.Hint:='<html>' + HintCampo + '<br>';
        IWLbl.ShowHint:=True;
      end
      else
        IWLbl.ShowHint:=False;

      if not (LFormato in ['M','U', 'T']) then
      begin
        // abilitazione dei componenti nella riga
        AbilRiga:=(grdRichieste.medpStato <> msBrowse) and (DatoPers.AbilitaModifica) and
                  ((cdsSG230.FieldByName('TIPO_RICHIESTA').AsString <> 'D') or (WR000DM.Responsabile and C018.IterModificaValori and (grdRichieste.medpStato = msEdit)));

        AbilitazioneComponente(IWLbl,AbilRiga);
        AbilitazioneComponente(IWC,AbilRiga);
      end;


      if LFormato <> 'T' then
      begin
        // imposta tabella
        // cella sx: label con nome dato
        // cella dx: input per il dato
        // 1/2. nome del dato
        grdDati.Cell[rDato,0].Css:='intestazione align_top bordo_sx_categoria';
        grdDati.Cell[rDato,0].Control:=IWLbl;
        grdDati.Cell[rDato,0].Text:='';

        // 2/2. imposta componente e css per cella dx
        grdDati.Cell[rDato,1].Css:='bordo_dx_categoria';
        if LFormato in ['M','U'] then
          grdDati.Cell[rDato,1].Text:=strHTML
        else
          grdDati.Cell[rDato,1].Control:=IWC;
      end
      else
      begin //LFormato = 'T' --> unisce le due colonne
        //Imposta il Javascript
        if JavaScript.Count = 0 then
          JavaScript.Add('$(document).ready(function(){');
        JavaScript.Add('$("#TBLGRDDATI").find("tr:nth-child(' + IntToStr(rDato+1) + ')").find("td:first").attr("colspan", "2")');
        JavaScript.Add('$("#TBLGRDDATI").find("tr:nth-child(' + IntToStr(rDato+1) + ')").find("td:nth-child(2)").remove()');
        grdDati.Cell[rDato,0].Css:='intestazione align_top bordo_sx_categoria bordo_dx_categoria';
        grdDati.Cell[rDato,0].Control:=IWLbl;
      end;
      // salva categoria precedente
      CategoriaPrec:=Categoria;

      // aggiunge una riga alla tabella
      grdDati.RowCount:=grdDati.RowCount + 1;
      inc(rDato);
      Next;
    end;
  end;

  if JavaScript.Count > 0 then
    JavaScript.Add('});');

  // visibilità tabella
  grdDati.Visible:=(grdDati.RowCount > 1);

  // gestione tabella dati personalizzati
  if grdDati.RowCount > 1 then
  begin
    // ultima riga con bordo top per chiudere la tabella
    grdDati.Cell[grdDati.RowCount - 1,0].Css:='bordo_top_categoria';
    grdDati.Cell[grdDati.RowCount - 1,1].Css:='bordo_top_categoria';
  end
  else
  begin
    grdDati.Cell[0,0].Css:='';
    grdDati.Cell[0,0].Text:='';
    grdDati.Cell[0,1].Css:='';
    grdDati.Cell[0,1].Text:='';
  end;
end;

procedure TW048FCertificazioni.GetDatiTabellari;
// Popolamento strutture dati di supporto per i dati tabellari
var
  i: Integer;
const
  FUNZIONE = 'GetDatiTabellari';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  // array per le certificazioni della richiesta
  W048DM.selSG231.First;
  SetLength(FArrCertificazioni,W048DM.selSG231.RecordCount);
  i:=0;
  while not W048DM.selSG231.Eof do
  begin
    FArrCertificazioni[i].Codice:=W048DM.selSG231.FieldByName('CODICE').AsString;
    FArrCertificazioni[i].Valore:=W048DM.selSG231.FieldByName('VALORE').AsString;
    W048DM.selSG231.Next;
    i:=i + 1;
  end;

  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW048FCertificazioni.IWAppFormCreate(Sender: TObject);
const
  FUNZIONE = 'IWAppFormCreate';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  Tag:=IfThen(WR000DM.Responsabile,456,455);
  inherited;
  W048DM:=TW048FCertificazioniDM.Create(Self);
  Iter:=ITER_CERTIFICAZIONI;

  FDatiTimb:=TDatiRichiestaTimb.Create;
  W048DM.C018:=C018;
  if WR000DM.Responsabile then
    C018.PreparaDataSetIter(W048DM.selSG230,tiAutorizzazione)
  else
    C018.PreparaDataSetIter(W048DM.selSG230,tiRichiesta);

  Self.HelpKeyWord:=IfThen(WR000DM.Responsabile,'W048P1','W048P0');
  FData:=Parametri.DataLavoro;

  // tabella delle richieste
  grdRichieste.medpRighePagina:=GetRighePaginaTabella;
  grdRichieste.medpDataSet:=W048DM.selSG230;
  grdRichieste.medpTestoNoRecord:=A000TraduzioneStringhe(A000MSG_MSG_NESSUNA_RICHIESTA);

  if Parametri.AccessibilitaNonVedenti = 'N' then
    grdDati.Summary:='';

  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW048FCertificazioni.RefreshPage;
const
  FUNZIONE = 'RefreshPage';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  WR000DM.Responsabile:=Tag = 456;
  VisualizzaDipendenteCorrente;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW048FCertificazioni.IWAppFormRender(Sender: TObject);
const
  FUNZIONE = 'IWAppFormRender';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  inherited;
  BloccaGestione:=grdRichieste.medpStato <> msBrowse;

  // autorizza / nega tutto
  if medpAutorizzaMultiplo then
  begin
    if btnTuttiSi.Visible then
      btnTuttiSi.Visible:=(W048DM.selSG230.RecordCount > 0) and (FAutorizza.Operazione = '');
    btnTuttiNo.Visible:=btnTuttiSi.Visible;
  end;

  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW048FCertificazioni.GetDipendentiDisponibili(Data:TDateTime);
const
  FUNZIONE = 'GetDipendentiDisponibili';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  ElementoTuttiDip:=WR000DM.Responsabile;
  inherited;

  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW048FCertificazioni.VisualizzaDipendenteCorrente;
var
  FiltroAnag: String;
  i:Integer;
const
  FUNZIONE = 'VisualizzaDipendenteCorrente';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  inherited;

  // salva parametri form
  ParametriForm.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;

  FRichiesta.Operazione:='';
  FAutorizza.Operazione:='';
  grdRichieste.medpBrowse:=True;

  // apre il dataset delle richieste di certificazione
  with W048DM.selSG230 do
  begin
    // determina filtri
    FiltroAnag:=IfThen(TuttiDipSelezionato,
                       WR000DM.FiltroRicerca,
                       FiltroSingoloAnagrafico);
    Close;
    SetVariable('DATALAVORO',Parametri.DataLavoro);
    (*
    if WR000DM.Responsabile then
      FiltroAnag:=FiltroAnag + ' and T850.TIPO_RICHIESTA = ''D'''; //Visibili solo le certificazioni definitive
    *)
    SetVariable('FILTRO_ANAG',FiltroAnag);
    SetVariable('FILTRO_PERIODO',C018.Periodo.Filtro);
    SetVariable('FILTRO_VISUALIZZAZIONE',C018.FiltroRichieste);
    SetVariable('FILTRO_STRUTTURA',C018.FiltroStruttura);
    SetVariable('FILTRO_ALLEGATI',C018.FiltroAllegati);

    R013Open(W048DM.selSG230);
  end;

  with W048DM.selSG235 do  //usato per la scelta dei certificati da creare o la valutazione se modifica consentita
  begin
    Close;
    SetVariable('PROGRESSIVO', selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    Open;
    //Locate('ID',pID,[]);
  end;

  grdRichieste.medpCreaCDS;
  grdRichieste.medpEliminaColonne;
  if WR000DM.Responsabile then
  begin
    grdRichieste.medpAggiungiColonna('D_AUTORIZZAZIONE','Val.','',nil);
    if C018.IterModificaValori then
      grdRichieste.medpAggiungiColonna('DBG_COMANDI','Modifica','',nil);
    grdRichieste.medpAggiungiColonna(DBG_ITER,'Dettagli','',nil);
    if C018.EsisteGestioneAllegati then
      grdRichieste.medpAggiungiColonna(DBG_ALLEG,DBG_ALLEG_TITLE,'',nil);
  end
  else
  begin
    grdRichieste.medpAggiungiColonna('DBG_COMANDI','','',nil);
  end;
  grdRichieste.medpAggiungiColonna('MATRICOLA','Matricola','',nil);
  grdRichieste.medpAggiungiColonna('NOMINATIVO','Nominativo','',nil);
  grdRichieste.medpColonna('MATRICOLA').Visible:=TuttiDipSelezionato;
  grdRichieste.medpColonna('NOMINATIVO').Visible:=TuttiDipSelezionato;
  if WR000DM.Responsabile then
  begin
    grdRichieste.medpAggiungiColonna('MSGAUT_SI','Msg val SI','',nil);
    grdRichieste.medpAggiungiColonna('MSGAUT_NO','Msg val NO','',nil);
    grdRichieste.medpColonna('MSGAUT_SI').Visible:=False;
    grdRichieste.medpColonna('MSGAUT_NO').Visible:=False;
  end;
  grdRichieste.medpAggiungiColonna('DATA_RICHIESTA','Richiesta','',nil);

  if not WR000DM.Responsabile then
  begin
    grdRichieste.medpAggiungiColonna('TIPO_RICHIESTA','TIPO_RICHIESTA','',nil);
    grdRichieste.medpColonna('TIPO_RICHIESTA').Visible:=False;
    grdRichieste.medpAggiungiColonna('D_TIPO_RICHIESTA','Stato','',nil);
  end;

  grdRichieste.medpAggiungiColonna('DAL','Dal','',nil);
  grdRichieste.medpAggiungiColonna('AL','Al','',nil);

  grdRichieste.medpAggiungiColonna('COD_MODELLO','Modello scheda informativa','',nil);
  //grdRichieste.medpAggiungiColonna('DESC_MODELLO','Modello certificazione','',nil);
  grdRichieste.medpAggiungiColonna('DESCRIZIONE','Note al documento','',nil);

  if not WR000DM.Responsabile then
  begin
    grdRichieste.medpAggiungiColonna('D_STATO','Validazione','',nil); //era: D_AUTORIZZAZIONE
    grdRichieste.medpAggiungiColonna('D_RESPONSABILE','Responsabile','',nil);

    grdRichieste.medpAggiungiColonna(DBG_ITER,'Dettagli','',nil);
    if C018.EsisteGestioneAllegati then
      grdRichieste.medpAggiungiColonna(DBG_ALLEG,DBG_ALLEG_TITLE,'',nil);
  end;
  grdRichieste.medpAggiungiRowClick('DBG_ROWID',grdRichiesteColumnClick);
  grdRichieste.medpInizializzaCompGriglia;
  grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna(DBG_ITER),0,DBG_IMG,'','ELENCO','','');
  if C018.EsisteGestioneAllegati then
    grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna(DBG_ALLEG),0,DBG_IMG,'','ALLEGATI','','');
  if (not SolaLettura) then
  begin
    if not WR000DM.Responsabile then
    begin
      //Riga inserimento
      grdRichieste.medpPreparaComponenteGenerico('I',0,0,DBG_IMG,'','INSERISCI','null','','S');
      grdRichieste.medpPreparaComponenteGenerico('I',0,1,DBG_IMG,'','ANNULLA','null','','S');
      grdRichieste.medpPreparaComponenteGenerico('I',0,2,DBG_IMG,'','CONFERMA','null','','D');

      // righe dettaglio
      grdRichieste.medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','CANCELLA','Elimina la scheda informativa','Eliminare la scheda informativa selezionata?','S');
      grdRichieste.medpPreparaComponenteGenerico('R',0,1,DBG_IMG,'','MODIFICA','Modifica la scheda informativa','','D');
      grdRichieste.medpPreparaComponenteGenerico('R',0,2,DBG_IMG,'','ANNULLA','Annulla la modifica della scheda informativa','','S');
      grdRichieste.medpPreparaComponenteGenerico('R',0,3,DBG_IMG,'','CONFERMA','Conferma la modifica della scheda informativa','','D');
    end
    else
    begin
      // autorizzazione
      grdRichieste.medpPreparaComponenteGenerico('R',0,0,DBG_CHK,'','Si','','');
      grdRichieste.medpPreparaComponenteGenerico('R',0,1,DBG_CHK,'','No','','');
      // modifica dati
      if C018.IterModificaValori then
      begin
        i:=grdRichieste.medpIndexColonna('DBG_COMANDI');
        grdRichieste.medpPreparaComponenteGenerico('R',i,0,DBG_IMG,'','MODIFICA','Modifica la scheda informativa','','');
        grdRichieste.medpPreparaComponenteGenerico('R',i,1,DBG_IMG,'','ANNULLA','Annulla la modifica della scheda informativa','','S');
        grdRichieste.medpPreparaComponenteGenerico('R',i,2,DBG_IMG,'','CONFERMA','Conferma la modifica della scheda informativa','','D');
      end;
    end;
  end;
  grdRichieste.medpCaricaCDS;

  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW048FCertificazioni.TrasformaComponenti(const FN:String);
// trasforma i componenti della riga indicata da text a control e viceversa per la grid
//Richiama la preparazione dello schema dei dati personalizzati (grdDati)
var
  LDaTestoAControlli: Boolean;
  r,c:Integer;
  LIWEdtData: TmeIWEdit;
  LIWChb: TmeIWCheckBox;
  LIWCmb: TmeIWComboBox;
  LIWGrd: TmeIWGrid;
  blnDef: Boolean;
begin
  r:=grdRichieste.medpRigaDiCompGriglia(FN);
  LDaTestoAControlli:=grdRichieste.medpStato <> msBrowse;

  blnDef:=grdRichieste.medpValoreColonna(r,'TIPO_RICHIESTA') = 'D';  //Certificazione definitiva

  // gestione icone comandi
  LIWGrd:=(grdRichieste.medpCompGriglia[r].CompColonne[grdRichieste.medpIndexColonna('DBG_COMANDI')] as TmeIWGrid);
  if not WR000DM.Responsabile then
  begin
    LIWGrd.Cell[0,0].Css:=IfThen(LDaTestoAControlli,'invisibile','align_left');
    if r = 0 then
    begin
      // riga di inserimento
      LIWGrd.Cell[0,1].Css:=IfThen(LDaTestoAControlli,FStileCella1,'invisibile');
      LIWGrd.Cell[0,2].Css:=IfThen(LDaTestoAControlli,FStileCella2,'invisibile');
    end
    else
    begin
      // righe di dettaglio
      LIWGrd.Cell[0,1].Css:=IfThen(LDaTestoAControlli,'invisibile','align_right');
      LIWGrd.Cell[0,2].Css:=IfThen(LDaTestoAControlli,FStileCella1,'invisibile');
      LIWGrd.Cell[0,3].Css:=IfThen(LDaTestoAControlli,FStileCella2,'invisibile');
    end;
  end
  else
  begin
    // righe di dettaglio
    LIWGrd.Cell[0,0].Css:=IfThen(LDaTestoAControlli,'invisibile','align_center');
    LIWGrd.Cell[0,1].Css:=IfThen(LDaTestoAControlli,FStileCella1,'invisibile');
    LIWGrd.Cell[0,2].Css:=IfThen(LDaTestoAControlli,FStileCella2,'invisibile');

    LIWGrd:=(grdRichieste.medpCompGriglia[r].CompColonne[grdRichieste.medpIndexColonna('D_AUTORIZZAZIONE')] as TmeIWGrid);
    for c:=0 to LIWGrd.ColumnCount-1 do
      LIWGrd.Cell[0,c].Css:=IfThen(LDaTestoAControlli,'invisibile','gridComandi');
  end;

  //Combo certificazione-descrizione
  if LDaTestoAControlli then
  begin
    grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_CMB,'40','','','','S');
    c:=grdRichieste.medpIndexColonna('COD_MODELLO');
    grdRichieste.medpCreaComponenteGenerico(r,c,grdRichieste.Componenti);
    LIWCmb:=(grdRichieste.medpCompCella(r,c,0) as TmeIWComboBox);
    LIWCmb.NoSelectionText:='--';
    LIWCmb.ItemsHaveValues:=True;
    with W048DM.selSG235 do
    begin
      Close;
      SetVariable('PROGRESSIVO', selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
      Open;
      while not eof do
      begin
        LIWCmb.Items.Add(FieldByName('CODICE').AsString + '=' + FieldByName('ID').AsString);
        Next;
      end;
      First; //mi posiziono sul primo per gestire l'ordinamento
    end;

    if (grdRichieste.medpStato = msInsert) then
    begin
      if W048DM.selSG235.RecordCount = 1 then
        LIWCmb.ItemIndex:=0       //seleziono il solo modello presente
      else
        LIWCmb.ItemIndex:=-1;     //non seleziono nulla
    end
    else
    begin
      LIWCmb.ItemIndex:=max(0,R180IndexFromValue(LIWCmb.Items,grdRichieste.medpValoreColonna(r,'ID_CERTIFICAZIONE')));
      LIWCmb.Enabled:=False;
    end;

    LIWCmb.OnChange:=cmbCertificazioneChange;

    //Descrizione
    grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'80','','','','S');
    c:=grdRichieste.medpIndexColonna('DESCRIZIONE');
    grdRichieste.medpCreaComponenteGenerico(r,c,grdRichieste.Componenti);
    LIWEdtData:=(grdRichieste.medpCompCella(r,c,0) as TmeIWEdit);
    LIWEdtData.Enabled:=(not blnDef) or	((WR000DM.Responsabile) and (grdRichieste.medpStato = msEdit) and C018.IterModificaValori);
    if grdRichieste.medpStato = msInsert then
      LIWEdtData.Text:=''
    else
      LIWEdtData.Text:=grdRichieste.medpValoreColonna(r,'DESCRIZIONE');

    //Data DAL
    grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'DATA','','','','S');
    c:=grdRichieste.medpIndexColonna('DAL');
    grdRichieste.medpCreaComponenteGenerico(r,c,grdRichieste.Componenti);
    LIWEdtData:=(grdRichieste.medpCompCella(r,c,0) as TmeIWEdit);
    LIWEdtData.Css:='input_data_dmy';
    LIWEdtData.Enabled:=(not blnDef) or	((WR000DM.Responsabile) and (grdRichieste.medpStato = msEdit) and C018.IterModificaValori);
    if grdRichieste.medpStato = msInsert then
      LIWEdtData.Text:=''  //Il periodo di default DAL-AL è gestito in cmbCertificazioneChange
    else
      LIWEdtData.Text:=IfThen(grdRichieste.medpValoreColonna(r,'DAL')<>'', grdRichieste.medpValoreColonna(r,'DAL'),'') ;

    //Data AL
    grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'DATA','','','','S');
    c:=grdRichieste.medpIndexColonna('AL');
    grdRichieste.medpCreaComponenteGenerico(r,c,grdRichieste.Componenti);
    LIWEdtData:=(grdRichieste.medpCompCella(r,c,0) as TmeIWEdit);
    LIWEdtData.Css:='input_data_dmy';
    LIWEdtData.Enabled:=(not blnDef) or	((WR000DM.Responsabile) and (grdRichieste.medpStato = msEdit) and C018.IterModificaValori);
    if grdRichieste.medpStato = msInsert then
      LIWEdtData.Text:=''  //Il periodo di default DAL-AL è gestito in cmbCertificazioneChange
    else
      LIWEdtData.Text:=IfThen(grdRichieste.medpValoreColonna(r,'AL')<>'', grdRichieste.medpValoreColonna(r,'AL'),'');

    //Richiesta definitiva Sì/No
    grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_CHK,'','','','','C');
    c:=grdRichieste.medpIndexColonna('D_TIPO_RICHIESTA');
    if c > -1 then
    begin
      grdRichieste.medpCreaComponenteGenerico(r,c,grdRichieste.Componenti);
      LIWChb:=(grdRichieste.medpCompCella(r,c,0) as TmeIWCheckBox);
      LIWChb.Caption:='Definitiva';
      LIWChb.Checked:=blnDef;
    end;

    //Visualizza i dati della certificazione selezionata
    SchemaDatiPersonalizzati(IDCertificazione(LIWCmb), r);

    LIWCmb.SetFocus;
  end;
end;

function TW048FCertificazioni.IDCertificazione(pLIWCmb: TmeIWComboBox): Integer;
var
  strID: string;
begin
  strID:=VarToStr(pLIWCmb.Items.ValueFromIndex[pLIWCmb.ItemIndex]);
  result:=IfThen(strID <> '',StrToIntDef(strID,-99999),0);
end;

procedure TW048FCertificazioni.grdRichiesteAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
const
  FUNZIONE = 'grdRichiesteAfterCaricaCDS';
var
  r,c, c_cmd: integer;
  IWImg: TmeIWImageFile;
  LIWGrd: TmeIWGrid;
begin
  Log('Traccia',FUNZIONE + ': inizio');
  if not WR000DM.Responsabile then
  begin
    if (not SolaLettura) then
    begin
      //Riga di inserimento
      if grdRichieste.medpRigaInserimento then
      begin
        if FStileCella1 = '' then
        begin
          with (grdRichieste.medpCompGriglia[0].CompColonne[0] as TmeIWGrid) do
          begin
            FStileCella1:=Cell[0,0].Css;
            FStileCella2:=Cell[0,2].Css;
          end;
        end;
        //Riga di inserimento
        (grdRichieste.medpCompCella(0,0,0) as TmeIWImageFile).OnClick:=imgInserisciClick;
        (grdRichieste.medpCompCella(0,0,1)as TmeIWImageFile).OnClick:=imgAnnullaClick;
        (grdRichieste.medpCompCella(0,0,2)as TmeIWImageFile).OnClick:=imgConfermaClick;
        with (grdRichieste.medpCompGriglia[0].CompColonne[0] as TmeIWGrid) do
        begin
          Cell[0,1].Css:='invisibile';
          Cell[0,2].Css:='invisibile';
        end;
      end;

      for r:=IfThen(grdRichieste.medpRigaInserimento,1,0) to High(grdRichieste.medpCompGriglia) do
      begin
        // iter autorizzativo
        C018.Id:=StrToIntDef(VarToStr(grdRichieste.medpValoreColonna(r,'ID')),-1);
        C018.CodIter:=VarToStr(grdRichieste.medpValoreColonna(r,'COD_ITER'));

        // dettaglio iter
        IWImg:=(grdRichieste.medpCompCella(r,DBG_ITER,0) as TmeIWImageFile);
        IWImg.OnClick:=imgIterClick;
        IWImg.Hint:=C018.LeggiNoteComplete;
        IWImg.ImageFile.FileName:=IfThen(C018.NoteIndicate,fileImgElencoHighlight,fileImgElenco);

        // dettaglio allegati
        if C018.EsisteGestioneAllegati then
        begin
          (*Attenzione!
            C018.SetIconaAllegati effettua spostamenti sul dataset selTabellaIter (selSG230)
            e in questo caso (W048) scatena l'evento onCalcField che cambia i dati di C018
            Per mantenere la situazione uniforme ci si sposta subito sul record di selSG230 corrispondente all'id corrente
            in modo che il contesto C018 non si disallinei
          *)
          if W048DM.selSG230.SearchRecord('ROWID',IWImg.FriendlyName,[srFromBeginning]) then
          begin
            IWImg:=(grdRichieste.medpCompCella(r,DBG_ALLEG,0) as TmeIWImageFile);
            if C018.SetIconaAllegati(IWImg) then
              IWImg.OnClick:=imgAllegClick;
           end;
        end;

        if (grdRichieste.medpCompGriglia[r].CompColonne[0] <> nil) then
        begin
          // cancella
          IWImg:=(grdRichieste.medpCompCella(r,0,0) as TmeIWImageFile);
          IWImg.Hint:='Elimina la scheda informativa';
          IWImg.OnClick:=imgCancellaClick;
          IWImg.Confirmation:='Eliminare la scheda informativa "' + grdRichieste.medpValoreColonna(r,'DESCRIZIONE') + '"?';

          // modifica
          IWImg:=(grdRichieste.medpCompCella(r,0,1) as TmeIWImageFile);
          IWImg.Hint:='Modifica la scheda informativa';
          IWImg.OnClick:=imgModificaClick;

          // annulla
          IWImg:=(grdRichieste.medpCompCella(r,0,2) as TmeIWImageFile);
          IWImg.Hint:='Annulla le modifiche';
          IWImg.OnClick:=imgAnnullaClick;

          // applica
          IWImg:=(grdRichieste.medpCompCella(r,0,3) as TmeIWImageFile);
          IWImg.Hint:='Applica le modifiche';
          IWImg.OnClick:=imgConfermaClick;

          // abilitazione azioni
          LIWGrd:=(grdRichieste.medpCompGriglia[r].CompColonne[0] as TmeIWGrid);
          //aggiungere gestione Css in base a fase, modifica, responsabile....
          for c:=2 to LIWGrd.ColumnCount-1 do  //restano visibili modifica-elimina
            LIWGrd.Cell[0,c].Css:='invisibile';

          //Se non ci sono campi di input la richiesta non è modificabile
          W048DM.selSG237CampiInput.SetVariable('ID', '(select b.ID from sg235_modelli_certificazioni b where b.codice=''' + grdRichieste.medpValoreColonna(r,'COD_MODELLO') + ''')');
          W048DM.selSG237CampiInput.Execute;
          if W048DM.selSG237CampiInput.FieldAsInteger(0) = 0 then
           LIWGrd.Cell[0,1].Css:='invisibile';

          //La certificazione è scaduta quindi non può più essere modificata
          if not W048DM.selSG235.Locate('CODICE', grdRichieste.medpValoreColonna(r,'COD_MODELLO'),[]) then
            LIWGrd.Cell[0,1].Css:='invisibile';

          //Tolgo i componenti se non ci sono le condizioni per la cancellazione
          if (not WR000DM.Responsabile) and
             ((grdRichieste.medpValoreColonna(r,'AUTORIZZAZIONE') <> '') or
              (grdRichieste.medpValoreColonna(r,'REVOCABILE') <> 'CANC')) then
            FreeAndNil(grdRichieste.medpCompGriglia[r].CompColonne[0]);
        end;
      end;
    end;
  end
  else
  begin
    if (not SolaLettura) then
    begin
      for r:=0 to High(grdRichieste.medpCompGriglia) do
      begin
        // iter autorizzativo
        C018.Id:=StrToIntDef(VarToStr(grdRichieste.medpValoreColonna(r,'ID')),-1);
        C018.CodIter:=VarToStr(grdRichieste.medpValoreColonna(r,'COD_ITER'));

        // dettaglio iter
        IWImg:=(grdRichieste.medpCompCella(r,DBG_ITER,0) as TmeIWImageFile);
        IWImg.OnClick:=imgIterClick;
        IWImg.Hint:=C018.LeggiNoteComplete;
        IWImg.ImageFile.FileName:=IfThen(C018.NoteIndicate,fileImgElencoHighlight,fileImgElenco);

        // dettaglio allegati
        if C018.EsisteGestioneAllegati then
        begin
          (*Attenzione!
            C018.SetIconaAllegati effettua spostamenti sul dataset selTabellaIter (selSG230)
            e in questo caso (W048) scatena l'evento onCalcField che cambia i dati di C018
            Per mantenere la situazione uniforme ci si sposta subito sul record di selSG230 corrispondente all'id corrente
            in modo che il contesto C018 non si disallinei
          *)
          if W048DM.selSG230.SearchRecord('ROWID',IWImg.FriendlyName,[srFromBeginning]) then
          begin
            IWImg:=(grdRichieste.medpCompCella(r,DBG_ALLEG,0) as TmeIWImageFile);
            if C018.SetIconaAllegati(IWImg) then
              IWImg.OnClick:=imgAllegClick;
           end;
        end;

        if grdRichieste.medpCompGriglia[r].CompColonne[0] <> nil then
          C018.SetValoriAut(grdRichieste,r,0,0,1,chkAutorizzazioneClick);

        if C018.IterModificaValori then
        begin
          c_cmd:=grdRichieste.medpIndexColonna('DBG_COMANDI');
          if (grdRichieste.medpCompGriglia[r].CompColonne[c_cmd] <> nil) then
          begin
            // modifica
            IWImg:=(grdRichieste.medpCompCella(r,c_cmd,0) as TmeIWImageFile);
            IWImg.Hint:='Modifica la scheda informativa';
            IWImg.OnClick:=imgModificaClick;

            // annulla
            IWImg:=(grdRichieste.medpCompCella(r,c_cmd,1) as TmeIWImageFile);
            IWImg.Hint:='Annulla le modifiche';
            IWImg.OnClick:=imgAnnullaClick;

            // applica
            IWImg:=(grdRichieste.medpCompCella(r,c_cmd,2) as TmeIWImageFile);
            IWImg.Hint:='Applica le modifiche';
            IWImg.OnClick:=imgConfermaClick;

            // abilitazione azioni
            LIWGrd:=(grdRichieste.medpCompGriglia[r].CompColonne[c_cmd] as TmeIWGrid);
            //aggiungere gestione Css in base a fase, modifica, responsabile....
            for c:=1 to LIWGrd.ColumnCount-1 do  //resta visibile solo modifica
              LIWGrd.Cell[0,c].Css:='invisibile';

            //Se non ci sono campi di input la richiesta non è modificabile
            W048DM.selSG237CampiInput.SetVariable('ID', '(select b.ID from sg235_modelli_certificazioni b where b.codice=''' + grdRichieste.medpValoreColonna(r,'COD_MODELLO') + ''')');
            W048DM.selSG237CampiInput.Execute;
            if W048DM.selSG237CampiInput.FieldAsInteger(0) = 0 then
              LIWGrd.Cell[0,0].Css:='invisibile';

            //La certificazione è scaduta quindi non può più essere modificata
            if not W048DM.selSG235.Locate('CODICE', grdRichieste.medpValoreColonna(r,'COD_MODELLO'),[]) then
              LIWGrd.Cell[0,0].Css:='invisibile';
          end;
        end;
      end;
    end;
  end;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW048FCertificazioni.grdRichiesteRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  LNumColonna: Integer;
  LCampo: String;
begin
  inherited;
  if not grdRichieste.medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  LNumColonna:=grdRichieste.medpNumColonna(AColumn);
  LCampo:=grdRichieste.medpColonna(LNumColonna).DataField;

  // assegnazione stili
  if R180In(LCampo,['D_CERTIFICAZIONE','TESTO']) then
    ACell.Wrap:=True;

  if (ARow > 0) and (Length(grdRichieste.medpCompGriglia) > 0) then
  begin
    if R180In(LCampo,['DATA','D_STATO','DATO']) then
      ACell.Css:=ACell.Css + ' align_center';
    if LCampo = 'D_AUTORIZZAZIONE' then
    begin
      ACell.Css:=ACell.Css + ' font_grassetto align_center';
      if grdRichieste.medpValoreColonna(ARow - 1,'AUTORIZZAZIONE') = 'N' then
        ACell.Css:=ACell.Css + ' font_rosso';
    end;

    if (ARow = 1) and (FRichiesta.Operazione = 'I') then
    begin
      if LCampo = 'TESTO' then
        ACell.Text:=VarToStr(W048DM.selSG231.Lookup('ID',W048DM.selSG230.FieldByName('ID_CERTIFICAZIONE').AsInteger,'TESTO'));
    end;
  end;

  // assegnazione componenti
  if (ARow > 0) and (ARow <= High(grdRichieste.medpCompGriglia) + 1) and (grdRichieste.medpCompGriglia[ARow - 1].CompColonne[LNumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdRichieste.medpCompGriglia[ARow - 1].CompColonne[LNumColonna];
  end;
end;

procedure TW048FCertificazioni.grdRichiesteColumnClick(ASender: TObject; const AValue: string);
const
  FUNZIONE = 'grdRichiesteColumnClick';
var
  LIdRiga: Integer;
begin
  Log('Traccia',FUNZIONE + ': inizio');
  inherited;

  grdDati.RowCount:=0;
  lblDescCert.Caption:='';

  if (AValue = '*') and (grdRichieste.medpStato <> msInsert) then
    Exit;

  //CONTROLLI PER VERIFICA DELL'EFFETTIVA PRESENZA DELLA RIGA SELEZIONATA SUL DB
  // prova la locate prima con rowid, quindi con id richiesta
  if not cdsSG230.Locate('DBG_ROWID',AValue,[]) then
  begin
    if TryStrToInt(AValue,LIdRiga) then
    begin
      if not cdsSG230.Locate('ID',LIdRiga,[]) then
        Exit;
    end
    else
      Exit;
  end;

  // posizionamento dataset
  if (W048DM.selSG230.SearchRecord('ROWID', cdsSG230.FieldByName('DBG_ROWID').AsString, [srFromBeginning])) then
  begin
    // carica grid dei dati personalizzati + checkgroup motivazioni e ipotesi trasferte estere
    SchemaDatiPersonalizzati(cdsSG230.FieldByName('ID_CERTIFICAZIONE').AsInteger);

    if AValue <> '*' then //Inserimento
      CaricaDatiPersonalizzati;

    // nominativo
    if TuttiDipSelezionato then
    begin
      selAnagrafeW.SearchRecord('MATRICOLA',cdsSG230.FieldByName('MATRICOLA').AsString,[srFromBeginning]);
      lnkDipendente.Caption:=FormattaInfoDipendenteCorrente;
    end;
  end;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW048FCertificazioni.CaricaDatiPersonalizzati;
//Popola i controlli dei dati personalizzati
const
  FUNZIONE = 'CaricaDatiPersonalizzati';
var
  i:integer;
  LDatoPers: TDatoPersonalizzato;
  LIWC: TIWCustomControl;
  LIWCmb: TMedpIWMultiColumnComboBox;
  LIWChb: TmeIWCheckBox;
begin
  Log('Traccia',FUNZIONE + ': inizio');
  with W048DM.selSG231 do
  begin
    Close;
    SetVariable('ID',cdsSG230.FieldByName('ID').AsInteger);
    Open;
    for i:=0 to grdDati.RowCount - 1 do
    begin
      // componente di input
      LIWC:=grdDati.Cell[i,1].Control;
      if Assigned(LIWC) then
      begin
        if LIWC is TmeIWEdit then
        begin
          // valore libero (su una riga)
          LDatoPers:=((LIWC as TmeIWEdit).medpTag as TDatoPersonalizzato);
          if SearchRecord('CODICE',LDatoPers.Codice,[srFromBeginning]) then
            TmeIWEdit(LIWC).Text:=FieldByName('VALORE').AsString
          else
            TmeIWEdit(LIWC).Clear;
        end
        else if LIWC is TmeIWMemo then
        begin
          // valore libero (su più righe)
          LDatoPers:=(TmeIWMemo(LIWC).medpTag as TDatoPersonalizzato);
          if SearchRecord('CODICE',LDatoPers.Codice,[srFromBeginning]) then
            TmeIWMemo(LIWC).Text:=FieldByName('VALORE').AsString
          else
            TmeIWMemo(LIWC).Clear;
        end
        else if LIWC is TMedpIWMultiColumnComboBox then
        begin
          // lista di valori
          LIWCmb:=TMedpIWMultiColumnComboBox(LIWC);
          LDatoPers:=(LIWCmb.medpTag as TDatoPersonalizzato);
          if SearchRecord('CODICE',LDatoPers.Codice,[srFromBeginning]) then
          begin
            if LDatoPers.ElencoTabellare then
              PosizionamentoMultiColumnText(LIWCmb,FieldByName('VALORE').AsString,LDatoPers.LungCodice)
            else
              LIWCmb.Text:=FieldByName('VALORE').AsString;
          end
          else
          begin
            // codice non presente
            LIWCmb.Text:='';
          end;
        end
        else if LIWC is TmeIWCheckBox then
        begin
          LIWChb:=TmeIWCheckBox(LIWC);
          LDatoPers:=(LIWChb.medpTag as TDatoPersonalizzato);
          if SearchRecord('CODICE',LDatoPers.Codice,[srFromBeginning]) then
            LIWChb.Checked:=FieldByName('VALORE').AsString = 'S';
        end;
      end;
    end;
  end;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW048FCertificazioni.imgInserisciClick(Sender: TObject);
// Crea i controlli per la riga di inserimento
var
  FN: string;
const
  FUNZIONE = 'imgInserisciClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  if FRichiesta.Operazione <> '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage('E'' necessario completare oppure annullare' + CRLF +
                               'l''operazione in corso prima di procedere!');
    Exit;
  end;

  FN:=(Sender as TmeIWImageFile).FriendlyName;
  grdRichieste.medpStato:=msInsert;
  grdRichiesteColumnClick(Sender,FN);
  FRichiesta.Operazione:='I';
  grdRichieste.medpBrowse:=False;
  lblFiltroModello.Enabled:=False;
  cmbFiltroModello.Enabled:=False;

  TrasformaComponenti(FN);

  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW048FCertificazioni.imgConfermaClick(Sender: TObject);
var
  FN: String;
const
  FUNZIONE = 'imgConfermaClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  // effettua controlli bloccanti
  if not ControlliOK(FN) then
    Exit;

  // inserimento / aggiornamento
  if grdRichieste.medpStato = msInsert then
    actInsRichiesta(FN)
  else
    actModRichiesta(FN);

  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW048FCertificazioni.imgAnnullaClick(Sender: TObject);
const
  FUNZIONE = 'imgAnnullaClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  lblFiltroModello.Enabled:=True;
  cmbFiltroModello.Enabled:=True;

  VisualizzaDipendenteCorrente;

  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW048FCertificazioni.imgIterClick(Sender: TObject);
var
  FN: String;
const
  FUNZIONE = 'imgIterClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  with W048DM.selSG230 do
  begin
    if not SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      VisualizzaDipendenteCorrente;
      MsgBox.MessageBox('La richiesta selezionata non è più disponibile!',INFORMA);
      Exit;
    end;
  end;
  VisualizzaDettagli(Sender);
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW048FCertificazioni.imgAllegClick(Sender: TObject);
var
  FN: String;
const
  FUNZIONE = 'imgAllegClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  with W048DM.selSG230 do
  begin
    if not SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      VisualizzaDipendenteCorrente;
      MsgBox.MessageBox('La scheda informativa selezionata non è più disponibile!',INFORMA);
      Exit;
    end;
  end;
  VisualizzaAllegati(Sender);
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW048FCertificazioni.cmbCertificazioneChange(Sender: TObject);
begin
  inherited;
  SchemaDatiPersonalizzati(IDCertificazione(Sender as TmeIWComboBox));
end;

function TW048FCertificazioni.ControlliOK(FN:String): Boolean;
// Effettua i controlli e imposta i dati per l'aggiornamento
var
  r,c: Integer;
  IWEdt: TmeIWEdit;
  IWChb: TmeIWCheckBox;
  LResCtrl: TResCtrl;
  Quantita: integer;  //Durata del periodo entro cui non deve ripetersi la certificazione
  UM: Char;         //Unità di misura del periodo (D = giorni, W = settimane, M = mesi, Y = anni)
const
  FUNZIONE = 'ControlliOK';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  Result:=False;
  r:=grdRichieste.medpRigaDiCompGriglia(FN);

  FRichiesta.Dal:=0;
  FRichiesta.Al:=0;
  // imposta variabili per inserimento / aggiornamento
  // certificazione
  c:=grdRichieste.medpIndexColonna('COD_MODELLO');
  FRichiesta.IDCertificazione:=IDCertificazione(grdRichieste.medpCompCella(r,c,0) as TmeIWComboBox);
  if FRichiesta.Operazione = 'I' then
  begin
    if FRichiesta.IDCertificazione < 1 then
    begin
      MsgBox.MessageBox('Selezionare una scheda informativa dall''elenco!',INFORMA);
      ActiveControl:=grdRichieste.medpCompCella(r,c,0) as TmeIWComboBox;
      Exit;
    end;
  end;

  //Data DAL
  FRichiesta.Dal:=0;
  IWEdt:=(grdRichieste.medpCompCella(r,'DAL',0) as TmeIWEdit);
  if (IWEdt.Text <> '') and (not TryStrToDate(IWEdt.Text,FRichiesta.Dal)) then
  begin
    MsgBox.MessageBox('Indicare una data di inizio valida!',INFORMA);
    ActiveControl:=IWEdt;
    Exit;
  end;

  //Data AL
  FRichiesta.Al:=0;
  IWEdt:=(grdRichieste.medpCompCella(r,'AL',0) as TmeIWEdit);
  if (IWEdt.Text <> '') and (not TryStrToDate(IWEdt.Text,FRichiesta.Al)) then
  begin
    MsgBox.MessageBox('Indicare una data di fine valida!',INFORMA);
    ActiveControl:=IWEdt;
    Exit;
  end;

  //Date incomplete
  if ((FRichiesta.Al > 0) and (FRichiesta.Dal <= 0)) or
     ((FRichiesta.Al <= 0) and (FRichiesta.Dal > 0)) then
  begin
    MsgBox.MessageBox('Indicare un periodo completo o nessuna data',INFORMA);
    ActiveControl:=IWEdt;
    Exit;
  end;

  //Intervallo non valido
  if FRichiesta.Al < FRichiesta.Dal then
  begin
    MsgBox.MessageBox('La data di inizio deve essere precedente alla data di fine',INFORMA);
    ActiveControl:=IWEdt;
    Exit;
  end;

  //Descrizione
  IWEdt:=(grdRichieste.medpCompCella(r,'DESCRIZIONE',0) as TmeIWEdit);
  FRichiesta.Descrizione:=IWEdt.Text;

  //Definitiva
  if not WR000DM.Responsabile then
  begin
    IWChb:=(grdRichieste.medpCompCella(r,'D_TIPO_RICHIESTA',0) as TmeIWCheckBox);
    FRichiesta.Definitiva:=IWChb.Checked;
  end
  else
    FRichiesta.Definitiva:=True;

  //Data richiesta
  if grdRichieste.medpValoreColonna(r,'DATA_RICHIESTA') <> '' then
    TryStrToDateTime(grdRichieste.medpValoreColonna(r,'DATA_RICHIESTA'), FRichiesta.Data)
  else
    FRichiesta.Data:=Now;

  //Controlli periodo
  //il cursore di selSG235 è già posizionato sul record corretto
  with W048DM.selSG235 do
  begin
    Quantita:=FieldByName('QUANTITA').AsInteger;
    UM:=R180CarattereDef(FieldByName('UM').AsString);
    if (UM in ['D','W','M','Y']) and (Quantita > 0) then
      if not ControlliPeriodo(FN, Quantita, UM) then
        Exit;
  end;

  //CONTROLLI DATI PERSONALIZZATI
  LResCtrl:=CtrlSalvaDatiPersonalizzati;
  if not LResCtrl.Ok then
  begin
    MsgBox.MessageBox(LResCtrl.Messaggio,ERRORE);
    Exit;
  end;

  // controlli ok
  Result:=True;
  Log('Traccia',FUNZIONE + ': fine');
end;

function TW048FCertificazioni.ControlliPeriodo(FN: string; pQ: integer; pUM: Char): Boolean;
//Controlla che la certificazione in inserimento non rispetti la regola di unicità nel periodo
var
  strErr, strInfo: string;
  Dal, Al: TDateTime;
  DataI, DataF : String;
  DATA_IMin, DATA_IMax: String;
  cntCert: integer;
begin
  strErr:='';
  strInfo:='(Scheda informativa non ripetibile entro ';
  //Controllo intersezione periodo
  Dal:=IfThen(FRichiesta.Dal>0,FRichiesta.Dal,FRichiesta.Data);
  Al:=IfThen(FRichiesta.Al>0,FRichiesta.Al,FRichiesta.Data);
  DataI:= 'to_date(''' + DateToStr(Dal) + ''', ''dd/mm/yyyy'')';
  DataF:= 'to_date(''' + DateToStr(Al) + ''', ''dd/mm/yyyy'')';

  //Controllo distanza da inizio period
  case pUM of
    'D': begin
    DATA_IMin:='to_date(''' + DateToStr(Dal-pQ) + ''', ''dd/mm/yyyy'')';
    DATA_IMax:='to_date(''' + DateToStr(Dal+pQ) + ''', ''dd/mm/yyyy'')';
    strInfo:=strInfo + IntToStr(pQ) + ' giorni)';
    end;

    'W': begin
    DATA_IMin:='to_date(''' + DateToStr(Dal-pQ*7) + ''', ''dd/mm/yyyy'')';
    DATA_IMax:='to_date(''' + DateToStr(Dal+pQ*7) + ''', ''dd/mm/yyyy'')';
    strInfo:=strInfo + IntToStr(pQ) + ' settimane)';
    end;

    'M': begin
    DATA_IMin:='Add_months(to_date(''' + DateToStr(Dal) + ''', ''dd/mm/yyyy''),- ' + IntToStr(pQ)+ ')';
    DATA_IMax:='Add_months(to_date(''' + DateToStr(Dal) + ''', ''dd/mm/yyyy''), ' + IntToStr(pQ)+ ')';
    strInfo:=strInfo + IntToStr(pQ) + ' mesi)';
    end;

    'Y': begin
    DATA_IMin:='Add_months(to_date(''' + DateToStr(Dal) + ''', ''dd/mm/yyyy''),- ' + IntToStr(pQ*12)+ ')';
    DATA_IMax:='Add_months(to_date(''' + DateToStr(Dal) + ''', ''dd/mm/yyyy''), ' + IntToStr(pQ*12)+ ')';
    strInfo:=strInfo + IntToStr(pQ) + ' anni)';
    end;

    else begin
    Result:=False;
    Exit;
    end;
  end;
  with W048DM.selQueryVSG230 do
  begin
    SetVariable('DATA_I',DataI);
    SetVariable('DATA_F',DataF);
    SetVariable('DATA_IMin',DATA_IMin);
    SetVariable('DATA_IMax',DATA_IMax);

    if FN <> '*' then
      SetVariable('ROWID_T', ' and T.ROWID_T <> ' + '''' + FN + '''')
    else
      SetVariable('ROWID_T', '');
    SetVariable('ID',FRichiesta.IDCertificazione);
    SetVariable('PROGR', selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    Execute;
    if RowCount > 0 then
    begin
      cntCert:=0;
      while not (eof) and (cntCert < 100) do //Controllo di uscita su cntCert per sicurezza
      begin
        if cntCert < 3 then
        begin
          strErr:=strErr + CRLF + '- ' + FieldAsString(0);
          strErr:=strErr + ' del ' + FieldAsString(1);
          if (FieldAsString(2) <> '') and (FieldAsString(3) <> '') then
          strErr:=strErr + ' valida dal ' + FieldAsString(2) + ' al ' + FieldAsString(3);
        end
        else if cntCert = 3 then
          strErr:=strErr + CRLF + '-  .....';
        inc(cntCert);
        Next;
      end;
      strErr:=strErr + CRLF + strInfo;
      MsgBox.MessageBox('Scheda informativa non ammessa perchè ripetuta nel periodo di ' + IntToStr(RowCount) + ' scheda informative:'  + strErr ,INFORMA);

      Result:=False;
    end
    else
      Result:=True;
  end;
end;

function TW048FCertificazioni.CtrlSalvaDatiPersonalizzati: TResCtrl;
// funzione di controllo dei dati personalizzati della certificazione
// - verifica i dati (obbligatorietà, formato, ecc...)
// - memorizza le informazioni nella struttura dati TRichiesta passata come parametro
// restituisce True se i controlli sono andati a buon fine, False altrimenti
var
  i,v: Integer;
  lstVar:TStringList;
  LValore: String;
  LDate:TDateTime;
  LNumber:Extended;
  LIWC: TIWCustomControl;
  LIWCmb: TMedpIWMultiColumnComboBox;
  LIWChb: TmeIWCheckBox;
  LDatoPers: TDatoPersonalizzato;
begin
  Result.Ok:=False;
  Result.Messaggio:='';

  if FRichiesta.DatiPers <> nil then
    FreeAndNil(FRichiesta.DatiPers);
  FRichiesta.DatiPers:=TDictionary<String,TDatoPersonalizzato>.Create;

  for i:=0 to grdDati.RowCount - 1 do
  begin
    // estrae il componente di input da analizzare
    LIWC:=grdDati.Cell[i,1].Control;
    if Assigned(LIWC) then
    begin
      LDatoPers:=nil;
      if LIWC is TmeIWEdit then
      begin
        // valore libero (su una riga)
        LValore:=Trim((LIWC as TmeIWEdit).Text);
        LDatoPers:=((LIWC as TmeIWEdit).medpTag as TDatoPersonalizzato);
      end
      else if LIWC is TmeIWMemo then
      begin
        // valore libero (su più righe)
        LValore:=Trim((LIWC as TmeIWMemo).Text);
        LDatoPers:=((LIWC as TmeIWMemo).medpTag as TDatoPersonalizzato);
      end
      else if LIWC is TMedpIWMultiColumnComboBox then
      begin
        // combo di selezione valori
        LIWCmb:=(LIWC as TMedpIWMultiColumnComboBox);
        LDatoPers:=(LIWCmb.medpTag as TDatoPersonalizzato);
        // salva il valore
        if LDatoPers.ElencoTabellare then
          LValore:=LIWCmb.Text.Substring(0,LDatoPers.LungCodice).Trim
        else
          LValore:=LIWCmb.Text.Trim;
      end
      else if LIWC is TmeIWCheckBox then
      begin
        LIWChb:=(LIWC as TmeIWCheckBox);
        LDatoPers:=(LIWChb.medpTag as TDatoPersonalizzato);
        LValore:=IfThen(LIWChb.Checked,'S','N');
        //controllo dato obbligatorio (check = true)
        if (LDatoPers.Obbligatorio) and (LValore = 'N') then
        begin
          Result.Messaggio:=Format('E'' necessario accettare la condizione ' + CRLF + '"%s"!',[RimuoviTagHTML(LDatoPers.Descrizione)]);
          LIWChb.SetFocus;
          Exit;
        end;
      end;

      if LDatoPers.Obbligatorio then
      begin
        if LValore = '' then
        begin
          Result.Messaggio:=Format('L''indicazione del dato ' + CRLF + '"%s"! è obbligatoria!',[RimuoviTagHTML(LDatoPers.Descrizione)]);
          LIWC.SetFocus;
          Exit;
        end;
      end;
      if (LDatoPers.LungMax > 0) and
         (LValore.Length > LDatoPers.LungMax) then
      begin
        Result.Messaggio:=Format('Il dato' + CRLF + '"%s"' + CRLF + 'può contenere al massimo %d caratteri!' + CRLF + '(lunghezza corrente: %d)',[RimuoviTagHTML(LDatoPers.Descrizione),LDatoPers.LungMax,LValore.Length]);
        LIWC.SetFocus;
        Exit;
      end;
      if (LDatoPers.Formato = 'D') and (LValore <> '') and not TryStrToDate(LValore,LDate) then
      begin
        Result.Messaggio:=Format('Il dato' + CRLF + '"%s"' + CRLF + 'non contiene una data valida!',[RimuoviTagHTML(LDatoPers.Descrizione)]);
        LIWC.SetFocus;
        Exit;
      end;
      if (LDatoPers.Formato = 'N') and (LValore <> '') and not TryStrToFloat(LValore,LNumber) then
      begin
        Result.Messaggio:=Format('Il dato' + CRLF + '"%s"' + CRLF + 'non contiene un numero valido!',[RimuoviTagHTML(LDatoPers.Descrizione)]);
        LIWC.SetFocus;
        Exit;
      end;
      if LDatoPers.SQLValidazione <> '' then
      begin
        with C018.selDualExprRichiesta do
        begin
          SQL.Text:=Format('select count(*) TOT from DUAL where %s',[LDatoPers.SQLValidazione]);
          ClearVariables;
          DeleteVariables;
          lstVar:=FindVariables(SQL.Text, False);
          try
            for v:=0 to lstVar.Count - 1 do
            begin
              if lstVar[v] = 'VALORE' then
              begin
                if LDatoPers.Formato = 'N' then
                  DeclareAndSet('VALORE',otFloat,LValore)
                else if LDatoPers.Formato = 'D' then
                  DeclareAndSet('VALORE',otDate,LValore)
                else if LDatoPers.Formato = 'S' then
                  DeclareAndSet('VALORE',otString,LValore);
              end
              else if lstVar[v] = 'PROGRESSIVO' then
                DeclareAndSet('PROGRESSIVO',otInteger,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger)
              else if lstVar[v] = 'ID_CERTIFICAZIONE' then
                DeclareAndSet('ID_CERTIFICAZIONE',otInteger,FRichiesta.IDCertificazione)
              else if lstVar[v] = 'DAL' then
                DeclareAndSet('DAL',otDate,FRichiesta.Dal)
              else if lstVar[v] = 'AL' then
                DeclareAndSet('AL',otDate,FRichiesta.Al)
              else if lstVar[v] = 'NOME_UTENTE' then
                DeclareAndSet('NOME_UTENTE',otString,Parametri.Operatore)
              else if lstVar[v] = 'PROFILO_UTENTE' then
                DeclareAndSet('PROFILO_UTENTE',otString,Parametri.ProfiloWEB);
            end;
          finally
            lstVar.Free;
          end;
          try
            Execute;
            if FieldAsInteger('TOT') = 0 then
            begin
              Result.Messaggio:=Format('"%s"' + CRLF + 'non è un valore valido per il dato:' + CRLF + '"%s"',[LValore, RimuoviTagHTML(LDatoPers.Descrizione)]);
              LIWC.SetFocus;
              Exit;
            end;
          except
            on E:Exception do
            begin
              Result.Messaggio:=Format('Controllo di validità del dato' + CRLF + '"%s"' + CRLF + 'fallita!' + CRLF + E.Message,[RimuoviTagHTML(LDatoPers.Descrizione)]);
              LIWC.SetFocus;
              Exit;
            end;
          end;
        end;
      end;

      LDatoPers.ValoreStr:=LValore;
      // aggiunge le meta informazioni al dictionary dei dati personalizzati
      if LDatoPers <> nil then
        FRichiesta.DatiPers.Add(LDatoPers.Codice,LDatoPers);
    end;
  end;

  // controlli ok
  Result.Ok:=True;
end;

function TW048FCertificazioni.RimuoviTagHTML(pStr: string): string;
var inizio, fine: integer;
begin
  inizio:=pStr.IndexOf('<');
  fine:=pStr.IndexOf('>');
  while (inizio > 0) and (fine > 0) do
  begin
    pStr:=Copy(pStr,0, inizio) + Copy(pStr, fine+2, pStr.Length-fine-1);
    inizio:=pStr.IndexOf('<');
    fine:=pStr.IndexOf('>');
  end;
  Result:=pStr;
end;

procedure TW048FCertificazioni.actCancRichiesta(const FN: String);
// cancellazione richiesta missione
begin
  // elimina il record di testata della richiesta
  C018.CodIter:=W048DM.selSG230.FieldByName('COD_ITER').AsString;
  C018.Id:=W048DM.selSG230.FieldByName('ID').AsInteger;
  C018.EliminaIter;

  // elimina la certificazione
  RegistraMsg.InserisciMessaggio('I',Format('ID = %d; actCancRichiesta.delT850',[C018.Id]),Parametri.Azienda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);

  W048DM.delT850.SetVariable('ID',C018.Id);
  W048DM.delT850.Execute;

  SessioneOracle.Commit;

  VisualizzaDipendenteCorrente;
end;

procedure TW048FCertificazioni.actInsRichiesta(FN: String);
begin
  with W048DM.selSG230 do
  begin
    Append;
    FieldByName('PROGRESSIVO').AsInteger:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
    //FieldByName('DATA_RICHIESTA').AsDateTime:=FRichiesta.Data;
    FieldByName('ID_CERTIFICAZIONE').AsInteger:=FRichiesta.IDCertificazione;
    FieldByName('DESCRIZIONE').AsString:=FRichiesta.Descrizione;
    If FRichiesta.Dal > 0 then
      FieldByName('DAL').AsDateTime:=FRichiesta.Dal;
    If FRichiesta.Al>0 then
      FieldByName('AL').AsDateTime:=FRichiesta.Al;
  end;

  if not C018.WarningRichiesta then
    Messaggio('Conferma',C018.MessaggioOperazione + CRLF + 'Vuoi continuare?',ConfermaInsRichiesta,nil)
  else
    ConfermaInsRichiesta;
end;

procedure TW048FCertificazioni.actModRichiesta(FN: String);
// modifica certificazione
begin
  grdRichieste.medpRigaDiCompGriglia(FN);
  with W048DM.selSG230 do
  begin
    Edit;
    FieldByName('PROGRESSIVO').AsInteger:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
    FieldByName('DESCRIZIONE').AsString:=FRichiesta.Descrizione;
    If FRichiesta.Dal > 0 then
      FieldByName('DAL').AsDateTime:=FRichiesta.Dal
    else
      FieldByName('DAL').Clear;
    If FRichiesta.Al>0 then
      FieldByName('AL').AsDateTime:=FRichiesta.Al
    else
      FieldByName('AL').Clear;
    //Post;
    //IdIns:=RowId;
  end;

  C018.Id:=W048DM.selSG230.FieldByName('ID').AsInteger;
  C018.CodIter:=W048DM.selSG230.FieldByName('COD_ITER').AsString;
  C018.SetTipoRichiesta(IfThen(FRichiesta.Definitiva,'D',''));
  SessioneOracle.Commit;
  if not C018.ValiditaRichiesta then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Inserimento delle modifiche fallito!' + CRLF + 'Motivo: ' + C018.MessaggioOperazione);
    Exit;
  end;
  if not C018.WarningRichiesta then
  begin
    Messaggio('Conferma',C018.MessaggioOperazione + CRLF + 'Vuoi continuare?',ConfermaModRichiesta,nil);
    Exit;
  end;
  ConfermaModRichiesta;
end;

procedure TW048FCertificazioni.ConfermaModRichiesta;
var
  LCodice, LValore: string;
  LLivAut:Integer;
  IdIns: String;
begin
  try
    W048DM.selSG230.Post;
    IdIns:=W048DM.selSG230.RowId;
    with W048DM.selSG231 do
    begin
      Close;
      SetVariable('ID',W048DM.selSG230.FieldByName('ID').AsInteger);
      Filtered:=True;
      Open;
      for LCodice in FRichiesta.DatiPers.Keys do
      begin
        LValore:=FRichiesta.DatiPers[LCodice].ValoreStr;
        if (LValore = '') and (Locate('CODICE',LCodice, [])) then
        begin
          Delete;
          Open;
        end
        else
        begin
          if Locate('CODICE',LCodice, []) then
            Edit
          else
            Append;
          FieldByName('ID').AsInteger:=W048DM.selSG230.FieldByName('ID').AsInteger;
          FieldByName('CODICE').AsString:=LCodice;
          FieldByName('VALORE').AsString:=LValore;
          Post;
        end;
      end;
    end;
    SessioneOracle.Commit;
  except
    on E:Exception do
    begin
      SessioneOracle.Commit;
      GGetWebApplicationThreadVar.ShowMessage('Inserimento della scheda informativa fallito!' + CRLF + 'Motivo: ' + E.Message);
      exit;
    end;
  end;

  if FRichiesta.Definitiva then
  begin
    LLivAut:=C018.VerificaRichiestaEsistente('');
     if (W048DM.selSG235.FieldByName('AUTOCERTIFICAZIONE').AsString = 'S') and
        (LLivAut < C018.LivMaxObb) then
       Autocertificazione;
  end;

  //aggiorna visualizzazione
  grdRichieste.medpResetOffset;
  VisualizzaDipendenteCorrente;

  //posizionamento su riga appena inserita
  grdRichieste.medpDataSet.Refresh;
  grdRichieste.medpDataSet.Locate('ROWID',IdIns,[]);
  grdRichieste.medpAggiornaCDS(False);
  lblFiltroModello.Enabled:=True;
  cmbFiltroModello.Enabled:=True;
end;

procedure TW048FCertificazioni.Autocertificazione;
const
  FUNZIONE = 'Autocertificazione';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  with W048DM.selSG230 do
  begin
    try
      C018.InsAutorizzazione(C018.LivMaxObb,C018SI,C018AUTOMATICO,'N','Autocertificazione');
      SessioneOracle.Commit;
      if C018.MessaggioOperazione <> '' then
        raise Exception.Create(C018.MessaggioOperazione);
    except
      on E: Exception do
      begin
        SessioneOracle.Commit;
        GGetWebApplicationThreadVar.ShowMessage('Impostazione della validazione fallita!' + CRLF +
                                   'Motivo: ' + E.Message);
      end;
    end;
  end;

  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW048FCertificazioni.ConfermaInsRichiesta;
var IdIns:String;
    LCodice, LValore: string;
    LLivAut:Integer;
begin
  with W048DM.selSG230 do
  begin
    try
      LLivAut:=C018.InsRichiesta(IfThen(FRichiesta.Definitiva,'D',''),'','');
      if C018.MessaggioOperazione <> '' then
      begin
        Cancel;
        raise Exception.Create(C018.MessaggioOperazione);
      end;
      IdIns:=RowId;
      SessioneOracle.Commit;
    except
      on E:Exception do
      begin
        SessioneOracle.Commit;
        GGetWebApplicationThreadVar.ShowMessage('Inserimento della scheda informativa fallito!' + CRLF + 'Motivo: ' + E.Message);
        exit;
      end;
    end;
  end;

  with W048DM.selSG231 do
  begin
    try
      for LCodice in FRichiesta.DatiPers.Keys do
      begin
        LValore:=FRichiesta.DatiPers[LCodice].ValoreStr;
        if LValore <> '' then
        begin
          Append;
          FieldByName('ID').AsInteger:=W048DM.selSG230.FieldByName('ID').AsInteger;
          FieldByName('CODICE').AsString:=LCodice;
          FieldByName('VALORE').AsString:=LValore;
          Post;
        end;
      end;

      SessioneOracle.Commit;
    except
      on E:Exception do
      begin
        SessioneOracle.Commit;
        GGetWebApplicationThreadVar.ShowMessage('Inserimento della scheda informativa fallito!' + CRLF + 'Motivo: ' + E.Message);
        exit;
      end;
    end;
  end;

  if (W048DM.selSG235.FieldByName('AUTOCERTIFICAZIONE').AsString = 'S') and
     FRichiesta.Definitiva and
     (LLivAut < C018.LivMaxObb) then
    Autocertificazione;

  //aggiorna visualizzazione
  grdRichieste.medpResetOffset;
  VisualizzaDipendenteCorrente;

  //posizionamento su riga appena inserita
  grdRichieste.medpDataSet.Refresh;
  grdRichieste.medpDataSet.Locate('ROWID',IdIns,[]);
  grdRichieste.medpAggiornaCDS(False);
  lblFiltroModello.Enabled:=True;
  cmbFiltroModello.Enabled:=True;
end;

procedure TW048FCertificazioni.W048ApplicaFiltro(Sender: TObject);
var codModello: String;
begin
  //imposta l'eventuale filtro sul modello delle richieste visualizzate
  codModello:=cmbFiltroModello.Items[cmbFiltroModello.ItemIndex];
  if codModello = '' then
    W048DM.selSG230.Filter:=''
  else
    W048DM.selSG230.Filter:=Format('COD_MODELLO=''%s''', [codModello]);

  VisualizzaDipendenteCorrente;
end;

procedure TW048FCertificazioni.W018AutorizzaTutto(Sender: TObject; var Ok: Boolean);
// Effettua l'autorizzazione positiva / negativa di tutte le richieste
// ancora da autorizzare visibili a video.
var
  Aut: String;
  ErrModCan: Boolean;
const
  FUNZIONE = 'W018AutorizzaTutto';
  function FormattaDatiRichiesta: String;
  var
    Modello, Descrizione: string;
    Dal, Al: String;
    Data: String;
  begin
    with W048DM.selSG230 do
    begin
      Modello:=FieldByName('COD_MODELLO').AsString; //Modello certificazione
      Descrizione:=FieldByName('DESCRIZIONE').AsString;
      Data:=FieldByName('DATA_RICHIESTA').AsString;
      if (FieldByName('DAL').AsFloat > 0) and (FieldByName('AL').AsFloat > 0) then
      begin
        dal:=FieldByName('DAL').AsString;
        al:=FieldByName('AL').AsString;
      end
      else
      begin
        dal:='';
        al:='';
      end;
      Result:=Format('Richiesta %s "%s" effettuata il %s',
                     [Modello,
                      Descrizione,
                      FieldByName('MATRICOLA').AsString]) + CRLF +
              Format('in data: %s',
                     [Data]) +
              IfThen(dal <> '',CRLF + 'valida dal ' + dal + ' al ' + al, '');
    end;
  end;
begin
  Log('Traccia',FUNZIONE + ': inizio');
  // inizializzazione variabili
  ErrModCan:=False;
  Aut:=IfThen(Sender = btnTuttiSi,C018SI,C018NO);

  // autorizzazione richieste
  with W048DM.selSG230 do
  begin
    // niente refresh: autorizza solo ciò che è visualizzato nella pagina
    First;
    while not Eof do
    begin
      try
        if //(FieldByName('ELABORATO').AsString = 'N') and
           (FieldByName('ID_REVOCA').IsNull) and
           (FieldByName('AUTORIZZ_AUTOMATICA').AsString <> 'S') and
           (FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger > 0) then
        begin
          try
            C018.CodIter:=FieldByName('COD_ITER').AsString;
            C018.Id:=FieldByName('ID').AsInteger;
            try
              C018.InsAutorizzazione(FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger,Aut,Parametri.Operatore,'','',True);
              SessioneOracle.Commit;
              if C018.MessaggioOperazione <> '' then
                raise Exception.Create(C018.MessaggioOperazione);
            except
              on E: Exception do
              begin
                SessioneOracle.Commit;
                // messaggio bloccante
                MsgBox.MessageBox('Impostazione della validazione fallita!' + CRLF +
                                  'Motivo: ' + E.Message + CRLF + CRLF +
                                  FormattaDatiRichiesta,ESCLAMA);
                Exit;
              end;
            end;
          except
            // errore probabilmente dovuto a record modificato / cancellato da altro utente
            on E:Exception do
            begin
              ErrModCan:=True;
            end;
          end;
        end;
      finally
        Next;
      end;
    end;
  end;
  if ErrModCan then
    MsgBox.MessageBox('Alcune schede informative non sono state considerate per l''autorizzazione in quanto modificate nel frattempo o non più disponibili.',INFORMA);
  Ok:=True;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW048FCertificazioni.chkAutorizzazioneClick(Sender: TObject);
// autorizzazione - v1
const
  FUNZIONE = 'chkAutorizzazioneClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  SetAutorizzazione(Sender);
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW048FCertificazioni.SetAutorizzazione(Sender: TObject);
// conferma l'autorizzazione indicata sulla richiesta
begin
  FAutorizza.Rowid:=(Sender as TmeIWCheckBox).FriendlyName;
  FAutorizza.Checked:=(Sender as TmeIWCheckBox).Checked;
  FAutorizza.Caption:=(Sender as TmeIWCheckBox).Caption;

  // esegue l'autorizzazione della richiesta
  AutorizzazioneOK;
end;

procedure TW048FCertificazioni.AutorizzazioneOK;
// Importante: può essere richiamato anche da eventi async
var
  Aut,Resp: String;
const
  FUNZIONE = 'AutorizzazioneOK';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  Aut:='';
  Resp:='';
  // autorizzazione richiesta
  with W048DM.selSG230 do
  begin
    // verifica presenza record
    //Refresh;
    if (not SearchRecord('ROWID',FAutorizza.RowId,[srFromBeginning])) or
       (not CheckRecord(FAutorizza.RowId)) then
    begin
      if GGetWebApplicationThreadVar.IsCallBack then
      begin
        GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W009_MSG_RICH_NON_DISPONIBILE2));
      end
      else
      begin
        VisualizzaDipendenteCorrente;
        MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W009_MSG_RICH_NON_DISPONIBILE2),INFORMA);
      end;
      Exit;
    end;
    // imposta i dati di autorizzazione
    Resp:=Parametri.Operatore;
    if FAutorizza.Checked and (FAutorizza.Caption = 'Si') then
      // autorizzazione SI
      Aut:=C018SI
    else if FAutorizza.Checked and (FAutorizza.Caption = 'No') then
      // autorizzazione NO
      Aut:=C018NO
    else if not FAutorizza.Checked then
      // autorizzazione non impostata
      Aut:='';
    // salva i dati di autorizzazione
    try
      C018.CodIter:=FieldByName('COD_ITER').AsString;
      C018.Id:=FieldByName('ID').AsInteger;
      C018.InsAutorizzazione(FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger,Aut,Parametri.Operatore,'','',True);
      SessioneOracle.Commit;
      if C018.MessaggioOperazione <> '' then
        raise Exception.Create(C018.MessaggioOperazione);
      if not GGetWebApplicationThreadVar.IsCallBack then
      begin
        Refresh;
        grdRichieste.medpCaricaCDS;
      end;
    except
      on E: Exception do
      begin
        SessioneOracle.Commit;
        GGetWebApplicationThreadVar.ShowMessage('Impostazione della validazione fallita!' + CRLF +
                                   'Motivo: ' + E.Message);
      end;
    end;
  end;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW048FCertificazioni.DistruggiOggetti;
const
  FUNZIONE = 'DistruggiOggetti';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  // dealloca componenti creati
  FreeAndNil(FDatiTimb);
  FreeAndNil(W048DM);

  SetLength(FArrCertificazioni,0);

  inherited;

  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW048FCertificazioni.PosizionamentoMultiColumnText(PCmb: TMedpIWMultiColumnComboBox; const PValore: String; const PCodLen: Integer);
var
  i: Integer;
begin
  // se il valore è vuoto termina subito impostando Text =''
  if PValore.Trim = '' then
  begin
    // imposta il testo vuoto
    PCmb.Text:='';
  end
  else
  begin
    PCmb.Text:=PValore;
    // effettua ricerca parziale per valore (primi caratteri del testo)
    for i:=0 to PCmb.Items.Count - 1 do
    begin
      if PValore = PCmb.Items[i].RowData[0].Substring(0,PCodLen).Trim then
      begin
        PCmb.ItemIndex:=i;
        Break;
      end;
    end;
  end;
end;

function TW048FCertificazioni.VerificaEsistenza(pRowID: String): Boolean;
begin
  // verifica presenza richiesta
  W048DM.selSG230.Refresh;
  if not W048DM.selSG230.SearchRecord('ROWID',pRowID,[srFromBeginning]) then
  begin
    VisualizzaDipendenteCorrente;
    MsgBox.MessageBox('La scheda informativa non è più disponibile!',INFORMA,'Scheda informativa eliminata');
    Result:=False;
  end
  else
    Result:=True;
end;

function TW048FCertificazioni.VerificaEsistenzaModello(pRowID: String): Boolean;
//Controlla che il modello di certificazione sia ancora esistente e in validità
var r: integer;
begin
  r:=grdRichieste.medpRigaDiCompGriglia(pRowID);
  with W048DM.selSG235 do
  begin
    Close;
    SetVariable('PROGRESSIVO', selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    Open;
    Result:=W048DM.selSG235.Locate('ID',grdRichieste.medpValoreColonna(r,'ID_CERTIFICAZIONE'),[]);
  end;
end;

procedure TW048FCertificazioni.imgCancellaClick(Sender: TObject);
var
  FN: String;
  i: Integer;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  // verifica presenza richiesta
  If not VerificaEsistenza(FN) then
    Exit;

  grdRichieste.medpStato:=msEdit;
  // posizionamento dataset datagrid
  if not cdsSG230.Locate('DBG_ROWID',FN,[]) then
  begin
    if TryStrToInt(FN,i) then
    begin
      if not cdsSG230.Locate('ID',i,[]) then
        Exit;
    end
    else
      Exit;
  end;
  //grdRichiesteColumnClick(Sender,FN);
  FRichiesta.Operazione:='E';
  grdRichieste.medpBrowse:=False;

  actCancRichiesta(FN);
end;

procedure TW048FCertificazioni.imgModificaClick(Sender:TObject);
var
  FN: String;
  i: Integer;
begin
  // modifica
  if grdRichieste.medpStato <> msBrowse then
  begin
    MsgBox.MessageBox('E'' necessario completare oppure annullare l''operazione di ' +
                      IfThen(grdRichieste.medpStato = msInsert,'inserimento','variazione') +
                      ' in corso prima di procedere!',INFORMA,'Operazione in corso');
    Exit;
  end;

  FN:=(Sender as TmeIWImageFile).FriendlyName;

  // verifica presenza richiesta
  If not VerificaEsistenza(FN) then
    Exit;
  //Verifica disponibilità del modello di certificazione
  If not VerificaEsistenzaModello(FN) then
  begin
    MsgBox.MessageBox('Il modello di informativa non è stato trovato o è scaduto. ' +
                      'Impossibile modificare.',ESCLAMA,'Avviso');
    Exit;
  end;

  grdRichieste.medpStato:=msEdit;
  // posizionamento dataset datagrid
  if not cdsSG230.Locate('DBG_ROWID',FN,[]) then
  begin
    if TryStrToInt(FN,i) then
    begin
      if not cdsSG230.Locate('ID',i,[]) then
        Exit;
    end
    else
      Exit;
  end;
  // porta la riga in modifica: trasforma i componenti
  grdRichieste.medpBrowse:=False;
  lblFiltroModello.Enabled:=False;
  cmbFiltroModello.Enabled:=False;

  TrasformaComponenti(FN);

  CaricaDatiPersonalizzati;
end;

end.

