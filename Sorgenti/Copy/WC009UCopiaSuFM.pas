unit WC009UCopiaSuFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR200UBaseFM, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  IWCompButton, meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, meIWGrid, A000UCostanti, A000USessione, A000UInterfaccia, DB, Oracle, OracleData, WR100UBase,
  medpIWMessageDlg, C180FunzioniGenerali, C190FunzioniGeneraliWeb, meIWEdit,
  IWCompGrids, IWCompJQueryWidget,A000UMessaggi, WR302UGestTabellaDM, IWAppForm;

type
  TWC009FCopiaSuFM = class(TWR200FBaseFM)
    grdChiaveElemento: TmeIWGrid;
    btnChiudi: TmeIWButton;
    btnEsegui: TmeIWButton;
    selID: TOracleDataSet;
    InsRec: TOracleQuery;
    DataSource1: TDataSource;
    selDati: TOracleDataSet;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure btnChiudiClick(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure grdChiaveElementoRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
  private
    iPuntCodVoceSpec:Integer;
    LChiavePrimaria:TStringList;
    LValoriOriginali:TStringList;
    LValoriNuovi:TStringList;
    CodContrattoOri,CodVoceOri,CodVoceSpecialeOri,DecorrenzaOri: String;
    CodContrattoDes,CodVoceDes,CodVoceSpecialeDes,DecorrenzaDes: String;
    NomeTabella: String;
    procedure ValoriChiavePrimaria;
    procedure ScaricaGriglia;
    procedure InserisciNuovoRecord;
    procedure DuplicazioneArchiviVoci;
    procedure ResultDuplicazioneArchiviVoci(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure DuplicazioneFondi;
    procedure InserimentoArchiviVoci(sRowId:String);
    procedure DuplicazioneVociIntPaghe;
    function NomiColonne:String;
    function ValoriColonne:String;
    function SostituisciValoriChiave(S:String):String;
    procedure RefreshFiltro(S2:String);
    procedure RegistraLogCopia;
    procedure EseguiCopiaSu(Sender: TObject);
  public
    LCampiPredefiniti:TStringList;
    LValoriPredefiniti:TStringList;
    ODS,ODSatt:TOracleDataSet;
    ArrayODS:array of TOracleDataSet;
    sMsgAnomalie,CopiaSuTabella,CopiaSuChiave,CopiaSuChiaveInput,CopiaSuCampi:String;
    OperazioniDopoCopia:TWR102OperazioniDopoCopia;
    Storicizzazione,Eseguito:Boolean;
    procedure SetODS(const a:array of TOracleDataSet);
    procedure Visualizza;
    procedure CreaNuovaCausale(Tipo:String);
    procedure CreaNuovoContratto;
    procedure CreaNuovaIntPaghe;
    procedure CreaNuovoCartellino(CodiceDa,CodiceA:String);
    procedure CreaNuovaParMessaggi;
  end;

implementation

uses WR102UGestTabella;

{$R *.dfm}

procedure TWC009FCopiaSuFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  LCampiPredefiniti:=TStringList.Create;
  LValoriPredefiniti:=TStringList.Create;
  Storicizzazione:=False;
  Eseguito:=False;
end;

procedure TWC009FCopiaSuFM.Visualizza;
var
  i:Integer;
  Titolo:String;
begin
  LChiavePrimaria:=TStringList.Create;
  LValoriOriginali:=TStringList.Create;
  LValoriNuovi:=TStringList.Create;
  InsRec.Session:=ODS.Session;
  selDati.Session:=ODS.Session;
  selID.Session:=ODS.Session;
  if CopiaSuTabella <> '' then
    NomeTabella:=CopiaSuTabella
  else
    NomeTabella:=R180Query2NomeTabella(ODS);
  if CopiaSuChiave = '' then
    A000GetChiavePrimaria(ODS.Session,NomeTabella,LChiavePrimaria)
  else
    LChiavePrimaria.CommaText:=CopiaSuChiave;
  if not Storicizzazione and (NomeTabella = 'T190_INTERFACCIAPAGHE') then
  begin
    LChiavePrimaria.Clear;
    LChiavePrimaria.Add('CODICE');//Duplico tutto a livello di Interfaccia, non anche di CodInterno
  end;
  ValoriChiavePrimaria;

  grdChiaveElemento.RowCount:=LChiavePrimaria.Count + 1;
  grdChiaveElemento.ColumnCount:=2;

  grdChiaveElemento.Cell[0,0].Width:='20%';
  grdChiaveElemento.Cell[0,1].Width:='25%';
  grdChiaveElemento.Cell[0,0].Text:='Nome campo';
  grdChiaveElemento.Cell[0,1].Text:='Valore';

  for i:=0 to LChiavePrimaria.Count - 1 do
  begin
    grdChiaveElemento.Cell[i + 1,0].Text:=ODS.FieldByName(LChiavePrimaria[i]).DisplayLabel;
    grdChiaveElemento.Cell[i + 1,0].Hint:=LChiavePrimaria[i];

    grdChiaveElemento.Cell[i + 1,1].Text:='';
    grdChiaveElemento.Cell[i + 1,1].Control:=TmeIWEdit.Create(Self);
    TmeIWEdit(grdChiaveElemento.Cell[i + 1,1].Control).Css:='input_perc90 nomargin';
    TmeIWEdit(grdChiaveElemento.Cell[i + 1,1].Control).Text:=LValoriOriginali[i];

    if not Storicizzazione or (UpperCase(grdChiaveElemento.Cell[i + 1,0].Hint) = 'DECORRENZA') then
      TmeIWEdit(grdChiaveElemento.Cell[i + 1,1].Control).Enabled:=True
    else
      TmeIWEdit(grdChiaveElemento.Cell[i + 1,1].Control).Enabled:=False;

    if CopiaSuChiaveInput <> '' then
      if Pos(',' + UpperCase(LChiavePrimaria[i]) + ',',',' + UpperCase(CopiaSuChiaveInput) + ',') = 0 then
        TmeIWEdit(grdChiaveElemento.Cell[i + 1,1].Control).Enabled:=False;
  end;

  if Storicizzazione then
    Titolo:='Storicizza elemento'
  else
    Titolo:='Duplica elemento';
  TWR100FBase(Self.Parent).VisualizzaJQMessaggio(jQuery,400,-1,EM2PIXEL *30,Titolo,'#wc009_container',False,True);
end;

procedure TWC009FCopiaSuFM.btnEseguiClick(Sender: TObject);
begin
  StartThreadElaborazione(EseguiCopiaSu,Sender);
end;

procedure TWC009FCopiaSuFM.EseguiCopiaSu(Sender: TObject);
var i:Integer;
    S2,NomeFormOwner,CodiceDa,CodiceA:String;
    LInterfacciaWR102:TInterfacciaWR102;  // locale
begin
  NomeFormOwner:='';
  sMsgAnomalie:='';
  ScaricaGriglia;

  // Commit così da poter effettuare rollback in caso di errori.
  SessioneOracle.Commit;

  LInterfacciaWR102:=nil;
  if (Self.Owner <> nil) then
  begin
    NomeFormOwner:=(Self.Owner as TIWAppForm).Name;
    if (Self.Owner is TWR102FGestTabella) and
       ((Self.Owner as TWR102FGestTabella).InterfacciaWR102 <> nil) then
    begin
      LInterfacciaWR102:=(Self.Owner as TWR102FGestTabella).InterfacciaWR102;
      LInterfacciaWR102.CopiaInCorso:=True;
    end;
  end;

  try
    try
      if NomeFormOwner = 'WA020FCausPresenze' then
      begin
        CreaNuovaCausale('PRESENZA');
        ODSAtt:=ODS;
        InserisciNuovoRecord;
        SessioneOracle.Commit;
      end
      else if NomeFormOwner = 'WA016FCausAssenze' then
      begin
        CreaNuovaCausale('ASSENZA');
        ODSAtt:=ODS;
        InserisciNuovoRecord;
        SessioneOracle.Commit;
      end
      else if NomeFormOwner = 'WA021FCausGiustif' then
      begin
        CreaNuovaCausale('GIUSTIFICAZIONE');
        ODSAtt:=ODS;
        InserisciNuovoRecord;
        SessioneOracle.Commit;
      end
      else if NomeFormOwner = 'WA022FContratti' then
      begin
        CreaNuovoContratto;
        ODSAtt:=ODS;
        InserisciNuovoRecord;
        SessioneOracle.Commit;
      end
      else if NomeFormOwner = 'WA034FIntPaghe' then
      begin
        CreaNuovaIntPaghe;
        SessioneOracle.Commit;
      end
      else if NomeFormOwner = 'WA052FParCar' then
      begin
        CodiceDa:=ODS.FieldByName('CODICE').AsString;
        CodiceA:=LValoriNuovi[LChiavePrimaria.IndexOf('CODICE')];
        if CodiceA.Trim = '' then
          raise Exception.Create(A000MSG_ERR_CODICE_VUOTO);
        ODSAtt:=ODS;
        InserisciNuovoRecord;
        CreaNuovoCartellino(CodiceDa,CodiceA);
        SessioneOracle.Commit;
        ODS.Locate('CODICE',CodiceA,[]);
      end
      else if NomeFormOwner = 'WA111FParMessaggi' then
      begin
        CreaNuovaParMessaggi;
        ODSAtt:=ODS;
        InserisciNuovoRecord;
        SessioneOracle.Commit;
      end
      else
      begin
        for i:=0 to High(ArrayODS) do
        begin
          ODSatt:=ArrayODS[i];
          //Ad ogni ciclo devo committare la sessione per poter fare rollback successivamente in caso di errore
          //Attenzione! tutte le eventuali transazioni non committate vengono committate ora.
          SessioneOracle.Commit;
          LCampiPredefiniti.Clear;
          InserisciNuovoRecord;
        end;
        if sMsgAnomalie <> '' then
          MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_ELAB_ANOM,[CHR(10) + sMsgAnomalie]) ,mtInformation,[mbOK],nil,'');
        Eseguito:=True;
      end;
    except
      on E:Exception do
      begin
        SessioneOracle.Rollback;
        if not (E is EAbort) then
          MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_ERRORE_GRAVE_COPIA,[E.Message]),
                               mtError,[mbOK],nil,'');
        Abort;
      end;
    end;

    /////in IrisWin viene fatto nella form principale
    if Storicizzazione and TWR102FGestTabella(Self.Parent).InterfacciaWR102.GestioneDecorrenzaFine and (@TWR102FGestTabella(Self.Parent).InterfacciaWR102.AllineaDecorrenzaFine <> nil) then
      TWR102FGestTabella(Self.Parent).InterfacciaWR102.AllineaDecorrenzaFine;
    S2:=TmeIWEdit(grdChiaveElemento.Cell[1,1].Control).Text;
    if NomeTabella.ToUpper = 'T020_ORARI' then
      A000AggiornaFiltroDizionario('MODELLI ORARIO','',S2)
    else if NomeTabella.ToUpper = 'T220_PROFILIORARI' then
      A000AggiornaFiltroDizionario('PROFILI ORARIO','',S2)
    else if NomeTabella.ToUpper = 'T265_CAUASSENZE' then
      A000AggiornaFiltroDizionario('CAUSALI ASSENZA','',S2)
    else if NomeTabella.ToUpper = 'T275_CAUPRESENZE' then
      A000AggiornaFiltroDizionario('CAUSALI PRESENZA','',S2)
    else if NomeTabella.ToUpper = 'T950_STAMPACARTELLINO' then
      A000AggiornaFiltroDizionario('PARAMETRIZZAZIONI CARTELLINO','',S2)
    else if NomeTabella.ToUpper = 'T002_QUERYPERSONALIZZATE' then
      A000AggiornaFiltroDizionario('INTERROGAZIONI DI SERVIZIO','',S2)
    else if NomeTabella.ToUpper = 'M011_TIPOMISSIONE' then
      A000AggiornaFiltroDizionario('TIPOLOGIA TRASFERTA','',S2)
    else if NomeTabella.ToUpper = 'M020_TIPIRIMBORSI' then
      A000AggiornaFiltroDizionario('RIMBORSI MISSIONI','',S2)
    else if NomeTabella.ToUpper = 'T010_CALENDIMPOSTAZ' then
      A000AggiornaFiltroDizionario('CALENDARI','',S2)
    else if NomeTabella.ToUpper = 'T260_RAGGRASSENZE' then
      A000AggiornaFiltroDizionario('RAGGRUPPAMENTI ASSENZA','',S2)
    else if NomeTabella.ToUpper = 'T270_RAGGRPRESENZE' then
      A000AggiornaFiltroDizionario('RAGGRUPPAMENTI PRESENZA','',S2)
    else if NomeTabella.ToUpper = 'T910_RIEPILOGO' then
      A000AggiornaFiltroDizionario('GENERATORE DI STAMPE','',S2)
    else if NomeTabella.ToUpper = 'P214_TIPOACCORPAMENTOVOCI' then
      A000AggiornaFiltroDizionario('TIPO ACCORPAMENTO VOCI','',S2)
    else if NomeTabella.ToUpper = 'P590_CONTABREGOLE' then
      A000AggiornaFiltroDizionario('REGOLE CONTABILITA','',S2);

    RefreshFiltro(S2);
    //TWR100FBase(Self.Parent).R010PagGridSeleziona(TWR102FGestTabella(Self.Parent).WBrowseFM.grdTabella);
    TWR102FGestTabella(Self.Parent).WBrowseFM.grdTabella.medpAggiornaCDS;

    if Assigned(OperazioniDopoCopia) then
      OperazioniDopoCopia;

    if Storicizzazione then
      TWR102FGestTabella(Self.Parent).actModificaExecute(nil);
    btnChiudiClick(nil);
    //Free;
  finally
    if LInterfacciaWR102 <> nil then
      LInterfacciaWR102.CopiaInCorso:=False;
  end;
end;

procedure TWC009FCopiaSuFM.RefreshFiltro(S2:String);
var S1:String;
begin
  if (UpperCase(Self.Parent.Name) = 'WA006FMODELLIORARIO') or
     (UpperCase(Self.Parent.Name) = 'WA007PROFILIORARI') then
    if WR302DM.selTabella.FieldByName('CODICE').AsString <> S2 then
    begin
      S1:=WR302DM.selTabella.FieldByName('CODICE').AsString;
      WR302DM.selTabella.Refresh;
      if not WR302DM.selTabella.Locate('CODICE',S2,[]) then
        WR302DM.selTabella.Locate('CODICE',S1,[]);
    end;
end;

procedure TWC009FCopiaSuFM.SetODS(const a:array of TOracleDataSet);
var i:Integer;
begin
  SetLength(ArrayODS,Length(a));
  for i:=0 to High(a) do
    ArrayODS[i]:=a[i];
end;

procedure TWC009FCopiaSuFM.ValoriChiavePrimaria;
//Carica stringlist con i valori dei campi che costituiscono chiave primaria
var
  i,j:Integer;
begin
  //Tra tutti i campi ricerco quelli che sono in chiave e ne estraggo i valori
  LValoriOriginali.Clear;
  for i:=0 to LChiavePrimaria.Count - 1 do
  begin
    for j:=0 to ODS.FieldCount - 1 do
      if UpperCase(LChiavePrimaria[i]) = UpperCase(ODS.Fields[j].FieldName) then
      begin
        LValoriOriginali.Add(ODS.Fields[j].AsString);
        break;
      end;
  end;
end;

procedure TWC009FCopiaSuFM.ScaricaGriglia;
//Scarica la griglia con i nuovi valori
var
  i:Integer;
begin
  LValoriNuovi.Clear;
  for i:=0 to LChiavePrimaria.Count - 1 do
//    LValoriNuovi.Add(grdChiaveElemento.Cells[1,i + 1]);  //Lorena 10/09/2008
    LValoriNuovi.Add(StringReplace(TmeIWEdit(grdChiaveElemento.Cell[i + 1,1].Control).Text,'''','''''',[rfReplaceAll]));
end;

procedure TWC009FCopiaSuFM.InserisciNuovoRecord;
var
  i,j:Integer;
  CampiChiave,S,ClassOri,ClassDes: String;
  ValoreChiave:Variant;
  CK,VK:array of String;
begin
  if CopiaSuTabella <> '' then
    NomeTabella:=CopiaSuTabella
  else
    NomeTabella:=UpperCase(R180EstraiNomeTabella(ODSatt.SQL.Text));
  //LCampiPredefiniti.Clear;
  if R180In(NomeTabella,['SG509_DETTAGLIOSTAMPA','SG510_DATISTAMPAPIANTA','SG511_STAMPAVALORI']) then
    for i:=0 to LChiavePrimaria.Count - 1 do
      if LChiavePrimaria[i] = 'CODICE' then
        LChiavePrimaria[i]:='CODICE_STAMPA';//Perché il campo chiave dei figli si chiama diversamente rispetto al padre (SG508_STAMPAPIANTA)
  if not Storicizzazione then
  begin
    SetLength(CK,LValoriNuovi.Count);
    SetLength(VK,LValoriNuovi.Count);
    j:=0;
    for i:=0 to LValoriNuovi.Count - 1 do
    begin
      if UpperCase(LChiavePrimaria[i]) = 'DECORRENZA' then
      begin
        SetLength(CK,LValoriNuovi.Count - 1);
        SetLength(VK,LValoriNuovi.Count - 1);
      end
      else
      begin
        CK[j]:=LChiavePrimaria[i];
        VK[j]:=LValoriNuovi[i];
        inc(j);
      end;
    end;
    try
      if Length(CK) > 0 then
        with (ODSatt as TOracleDataSet) do
          if QueryPK1.EsisteChiave(NomeTabella,RowID,dsBrowse,CK,VK) then
            raise Exception.Create(A000MSG_ERR_CHIAVE_DUPLICATA);
    finally
      SetLength(CK,0);
      SetLength(VK,0);
    end;
  end;
  try
    if NomeTabella = 'P200_VOCI' then //Duplico il record delle voci che vengono trattate a parte
      DuplicazioneArchiviVoci
    else if NomeTabella = 'P684_FONDI' then //Duplico i record dei fondi che vengono trattati a parte
      DuplicazioneFondi
    else
    //Duplico il record per tutte le tabelle dove prevista la funzione CopiaSu
    begin
      if NomeTabella = 'P688_RISDESTDET' then //Controllo particolare su CLASS_VOCE e poi proseguo
      begin
        for i:=0 to LChiavePrimaria.Count - 1 do
        begin
          if LChiavePrimaria[i] = 'CLASS_VOCE' then
          begin
            ClassOri:=Trim(LValoriOriginali[i]);
            ClassDes:=Trim(LValoriNuovi[i]);
          end
        end;
        if ClassOri <> ClassDes then
          raise exception.Create('impossibile cambiare CLASS_VOCE!');
      end;
      with InsRec do
      begin
        Close;
        SQL.Clear;
        SQL.Add('INSERT INTO ' + NomeTabella);
        if CopiaSuCampi = '' then
        begin
          SQL.Add('(' + NomiColonne + ')');
          SQL.Add('SELECT ' + ValoriColonne);
        end
        else
        begin
          SQL.Add('(' + CopiaSuCampi + ')');
          SQL.Add('SELECT ' + SostituisciValoriChiave(CopiaSuCampi));
        end;
        //SQL.Add('FROM ' + NomeTabella + ' WHERE ' + NomeTabella + '.RowId = ''' + ODSatt.RowId + '''');
        //Alberto 27/06/2003: riferimento alle colonne piuttosto che al RowID
        SQL.Add('FROM ' + NomeTabella + ' WHERE ');
        for i:=0 to LChiavePrimaria.Count - 1 do
        begin
          S:=LChiavePrimaria[i] + ' = ''' + AggiungiApice(LValoriOriginali[i]) + '''';
          if i < LChiavePrimaria.Count - 1 then S:=S + ' AND ';
          SQL.Add(S);
        end;
        Execute;
        //Registrazione sui log della copia effetuata
        if ODSatt = ODS then
          RegistraLogCopia;
        if not Storicizzazione and (NomeTabella = 'T190_INTERFACCIAPAGHE') then
          DuplicazioneVociIntPaghe;
      end;
    end;
    ODSatt.Refresh;
    ValoreChiave:=VarArrayCreate([0,LChiavePrimaria.Count - 1],VarVariant);
    CampiChiave:='';
    for i:=0 to LChiavePrimaria.Count - 1 do
    begin
      if CampiChiave <> '' then CampiChiave:=CampiChiave + ';';
      CampiChiave:=CampiChiave + LChiavePrimaria[i];
    end;
    for i:=0 to LValoriNuovi.Count - 1 do
      ValoreChiave[i]:=LValoriNuovi[i];
    ODSatt.SearchRecord(CampiChiave,ValoreChiave,[srFromBeginning]);
    InsRec.Session.Commit;
  except
    on e:exception do
    begin
      MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_DUPLICAZIONE,[e.Message]),mtError,[mbOK],nil,'');
      InsRec.Session.Rollback;
      Abort;
    end;
  end;
end;

procedure TWC009FCopiaSuFM.RegistraLogCopia;
var i,j:Integer;
    S,v:String;
begin
  RegistraLog.SettaProprieta('I',NomeTabella,Copy(TWR102FGestTabella(Self.Parent).Name,1,5),nil,True);
  for i:=0 to ODSatt.FieldCount - 1 do
  begin
    if ODSatt.Fields[i].FieldKind = fkData then
    begin
      S:=UpperCase(ODSatt.Fields[i].FieldName);
      V:=ODSatt.Fields[i].AsString;
      for j:=0 to LChiavePrimaria.Count - 1 do
        if UpperCase(LChiavePrimaria[j]) = S then
        begin
          V:=LValoriNuovi[j];
          Break;
        end;
      RegistraLog.InserisciDato(S,'',V);
      end;
  end;
  RegistraLog.RegistraOperazione;
  RegistraLog.Session.Commit;
end;

procedure TWC009FCopiaSuFM.DuplicazioneArchiviVoci;
//Duplicazione archivio voci
var
  i:Integer;
begin
  iPuntCodVoceSpec:=0;
  for i:=0 to LChiavePrimaria.Count - 1 do
  begin
    if LChiavePrimaria[i] = 'COD_CONTRATTO' then
    begin
      CodContrattoOri:=Trim(LValoriOriginali[i]);
      CodContrattoDes:=Trim(LValoriNuovi[i]);
    end
    else if LChiavePrimaria[i] = 'COD_VOCE' then
    begin
      CodVoceOri:=Trim(LValoriOriginali[i]);
      CodVoceDes:=Trim(LValoriNuovi[i]);
    end
    else if LChiavePrimaria[i] = 'COD_VOCE_SPECIALE' then
    begin
      CodVoceSpecialeOri:=Trim(LValoriOriginali[i]);
      CodVoceSpecialeDes:=Trim(LValoriNuovi[i]);
      iPuntCodVoceSpec:=i;
    end
    else if LChiavePrimaria[i] = 'DECORRENZA' then
    begin
      DecorrenzaOri:=Trim(LValoriOriginali[i]);
      DecorrenzaDes:=Trim(LValoriNuovi[i]);
    end;
  end;
  if CodVoceSpecialeDes = '' then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_A009_DLG_FMT_DUPLIC,[CodContrattoOri,CodVoceOri]),mtConfirmation,[mbYes,mbNo],ResultDuplicazioneArchiviVoci,'');
  end
  else
    InserimentoArchiviVoci(ODS.RowId);
end;

procedure TWC009FCopiaSuFM.ResultDuplicazioneArchiviVoci(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
    with selDati do
      begin
        Close;
        DeleteVariables;
        SQL.Clear;
        DeclareVariable('CodContratto',otString);
        DeclareVariable('CodVoce',otString);
        DeclareVariable('Decorrenza',otDate);
        SQL.Add('SELECT COD_VOCE_SPECIALE,ROWID FROM P200_VOCI WHERE COD_CONTRATTO = :CodContratto ');
        SQL.Add('AND COD_VOCE = :CodVoce AND DECORRENZA = :Decorrenza');
        SetVariable('CodContratto',CodContrattoOri);
        SetVariable('CodVoce',CodVoceOri);
        SetVariable('Decorrenza',DecorrenzaOri);
        Open;
        while not selDati.Eof do
        begin
          CodVoceSpecialeOri:=FieldByName('COD_VOCE_SPECIALE').AsString;
          CodVoceSpecialeDes:=CodVoceSpecialeOri;
          LValoriNuovi[iPuntCodVoceSpec]:=CodVoceSpecialeOri;
          InserimentoArchiviVoci(ROWID);
          Next;
        end;
      end;
end;

procedure TWC009FCopiaSuFM.InserimentoArchiviVoci(sRowId:String);
//Inserimento records di P200_VOCI e delle tabelle collegate:P201_ASSOGGETTAMENTI, P205_QUOTE e P232_SCAGLIONI
var
  sIdVoce,sOldCod: String;
begin
  LCampiPredefiniti.Clear;
  LValoriPredefiniti.Clear;
  LCampiPredefiniti.Add('ID_VOCE');
  with selID do
  begin
    Close;
    DeleteVariables;
    SQL.Clear;
    SQL.Add('SELECT P200_ID_VOCE.NEXTVAL FROM DUAL');
    Open;
    sIdVoce:=FieldByName('NEXTVAL').AsString;
    LValoriPredefiniti.Add(sIdVoce);
  end;
  with InsRec do
  begin
    //Inserimento tabella P200_VOCI
    SQL.Clear;
    SQL.Add('INSERT INTO ' + NomeTabella);
    SQL.Add('(' + NomiColonne + ')');
    SQL.Add('SELECT ' + ValoriColonne);
    SQL.Add('FROM ' + NomeTabella + ' WHERE ' + NomeTabella + '.RowId = ''' + sRowId + '''');
    Execute;
    //Modifico il codice voce da stampare facendo una replace del vecchio cod.voce con il nuovo
    SQL.Clear;
    SQL.Add('SELECT COD_VOCE ');
    SQL.Add('FROM ' + NomeTabella + ' WHERE ' + NomeTabella + '.RowId = ''' + sRowId + '''');
    Execute;
    sOldCod:=FieldAsString(0);
    SQL.Clear;
    SQL.Add('UPDATE  ' + NomeTabella);
    SQL.Add('SET COD_VOCE_STAMPA = REPLACE(COD_VOCE_STAMPA,''' + sOldCod + ''',COD_VOCE) WHERE ID_VOCE = ' + sIdVoce);
    Execute;
    //Svuoto il codice beneficiario perché è sempre inutile duplicarlo
    SQL.Clear;
    SQL.Add('UPDATE  ' + NomeTabella);
    SQL.Add('SET COD_BENEFICIARIO = NULL WHERE ID_VOCE = ' + sIdVoce);
    Execute;
    //Forzo voce copiata a non protetta
//    SQL.Clear;
//    SQL.Add('UPDATE  ' + NomeTabella);
//    SQL.Add('SET PROTETTA = ''N'' WHERE ID_VOCE = ' + sIdVoce);
//    Execute;
    //Inserimento tabella P201_ASSOGGETTAMENTI
    SQL.Clear;
    SQL.Add('INSERT INTO P201_ASSOGGETTAMENTI ');
    SQL.Add('(COD_CONTRATTO, COD_VOCE_PADRE, COD_VOCE_SPECIALE_PADRE, DECORRENZA, ');
    SQL.Add('COD_VOCE_FIGLIO, COD_VOCE_SPECIALE_FIGLIO, ASSOGGETTAMENTO, ASSOGGETTAMENTO13A, DECORRENZA_FINE) ');
    SQL.Add('SELECT ''' + CodContrattoDes + ''', ''' + CodVoceDes + ''', ''' + CodVoceSpecialeDes + ''', ');
    SQL.Add('DECORRENZA, COD_VOCE_FIGLIO, COD_VOCE_SPECIALE_FIGLIO, ASSOGGETTAMENTO, ASSOGGETTAMENTO13A, DECORRENZA_FINE ');
    SQL.Add('FROM P201_ASSOGGETTAMENTI WHERE COD_CONTRATTO = ''' + CodContrattoOri + ''' AND ');
    SQL.Add('COD_VOCE_PADRE = ''' + CodVoceOri + ''' AND COD_VOCE_SPECIALE_PADRE = ''' + CodVoceSpecialeOri + '''');
    Execute;
    //Inserimento tabella P205_QUOTE
    SQL.Clear;
    SQL.Add('INSERT INTO P205_QUOTE ');
    SQL.Add('(COD_CONTRATTO, COD_VOCE_DA_QUOTARE, COD_VOCE_SPECIALE_DA_QUOTARE, DECORRENZA, ');
    SQL.Add('COD_VOCE_IN_QUOTA, COD_VOCE_SPECIALE_IN_QUOTA, ACCUMULO, ACCUMULO_RATEO, COD_VOCE_SPECIALE_DETTAGLIO, COD_VOCE_SPECIALE_DETTAGLIO13A) ');
    SQL.Add('SELECT ''' + CodContrattoDes + ''', ''' + CodVoceDes + ''', ''' + CodVoceSpecialeDes + ''', ');
    SQL.Add('DECORRENZA, COD_VOCE_IN_QUOTA, COD_VOCE_SPECIALE_IN_QUOTA, ACCUMULO, ACCUMULO_RATEO, COD_VOCE_SPECIALE_DETTAGLIO, COD_VOCE_SPECIALE_DETTAGLIO13A ');
    SQL.Add('FROM P205_QUOTE WHERE COD_CONTRATTO = ''' + CodContrattoOri + ''' AND ');
    SQL.Add('COD_VOCE_DA_QUOTARE = ''' + CodVoceOri + ''' AND COD_VOCE_SPECIALE_DA_QUOTARE = ''' + CodVoceSpecialeOri + '''');
    Execute;
    //Inserimento tabella P206_ASSENZEINPDAP
    SQL.Clear;
    SQL.Add('INSERT INTO P206_ASSENZEINPDAP ');
    SQL.Add('(COD_CONTRATTO, COD_VOCE, COD_VOCE_SPECIALE, DECORRENZA, ELIMINA_SEZIONE, ');
    SQL.Add('ABBATTE_GGUTILI, COD_TIPOSERVIZIO, COD_GESTASSIC_NONCOPERTE, COD_CAUSASOSPENSIONE, ');
    SQL.Add(' PERC_ASP_SINDACALE, PERC_RETRIBUZIONE, NOTE, DECORRENZA_FINE, SPEZZA_PERIODO)');
    SQL.Add('SELECT ''' + CodContrattoDes + ''', ''' + CodVoceDes + ''', ''' + CodVoceSpecialeDes + ''', ');
    SQL.Add('DECORRENZA, ELIMINA_SEZIONE, ABBATTE_GGUTILI, COD_TIPOSERVIZIO ,COD_GESTASSIC_NONCOPERTE, COD_CAUSASOSPENSIONE,');
    SQL.Add(' PERC_ASP_SINDACALE, PERC_RETRIBUZIONE, NOTE, DECORRENZA_FINE, SPEZZA_PERIODO ');
    SQL.Add('FROM P206_ASSENZEINPDAP WHERE COD_CONTRATTO = ''' + CodContrattoOri + ''' AND ');
    SQL.Add('COD_VOCE = ''' + CodVoceOri + ''' AND COD_VOCE_SPECIALE = ''' + CodVoceSpecialeOri + '''');
    Execute;
    //Inserimento tabella P216_ACCORPAMENTOVOCI
    SQL.Clear;
    SQL.Add('INSERT INTO P216_ACCORPAMENTOVOCI ');
    SQL.Add('(COD_CONTRATTO, COD_VOCE, COD_VOCE_SPECIALE, COD_TIPOACCORPAMENTOVOCI, COD_CODICIACCORPAMENTOVOCI,');
    SQL.Add('DECORRENZA, PERCENTUALE, IMPORTO_COLONNA, DECORRENZA_FINE) ');
    SQL.Add('SELECT ''' + CodContrattoDes + ''', ''' + CodVoceDes + ''', ''' + CodVoceSpecialeDes + ''', ');
    SQL.Add('COD_TIPOACCORPAMENTOVOCI, COD_CODICIACCORPAMENTOVOCI,');
    SQL.Add('DECORRENZA, PERCENTUALE, IMPORTO_COLONNA, DECORRENZA_FINE ');
    SQL.Add('FROM P216_ACCORPAMENTOVOCI WHERE COD_CONTRATTO = ''' + CodContrattoOri + ''' AND ');
    SQL.Add('COD_VOCE = ''' + CodVoceOri + ''' AND COD_VOCE_SPECIALE = ''' + CodVoceSpecialeOri + '''');
    Execute;
    //Inserimento tabella P232_SCAGLIONI
    SQL.Clear;
    SQL.Add('INSERT INTO P232_SCAGLIONI ');
    SQL.Add('(COD_CONTRATTO, COD_VOCE, COD_VOCE_SPECIALE, DECORRENZA, ID_SCAGLIONE, TIPO_IMPORTO, TIPO_RITENUTA, ');
    SQL.Add('TIPO_APPLICAZIONE, CONGUAGLIO_ANNUALE, CONGUAGLIO_FINE_RAPPORTO, CONGUAGLIO_DOPO_FINE_RAPPORTO, ');
    SQL.Add('COD_VOCE_CONGUAGLIO, COD_VOCE_SPECIALE_CONGUAGLIO, MENSILITA_ANNUE, MASSIMALE1, MASSIMALE2, ');
    SQL.Add('COD_VOCE_PESO1, COD_VOCE_SPECIALE_PESO1, COD_VOCE_PESO2, COD_VOCE_SPECIALE_PESO2, COD_VOCE_CONGUAGLIO2, ');
    SQL.Add('COD_VOCE_SPECIALE_CONGUAGLIO2, RITENUTA_PROGRESSIVA_SCAGLIONI) ');
    SQL.Add('SELECT ''' + CodContrattoDes + ''', ''' + CodVoceDes + ''', ''' + CodVoceSpecialeDes + ''', ');
    SQL.Add('DECORRENZA, P233_ID_SCAGLIONE.NEXTVAL, TIPO_IMPORTO, TIPO_RITENUTA, ');
    SQL.Add('TIPO_APPLICAZIONE, CONGUAGLIO_ANNUALE, CONGUAGLIO_FINE_RAPPORTO, CONGUAGLIO_DOPO_FINE_RAPPORTO, ');
    SQL.Add('COD_VOCE_CONGUAGLIO, COD_VOCE_SPECIALE_CONGUAGLIO, MENSILITA_ANNUE, MASSIMALE1, MASSIMALE2, ');
    SQL.Add('COD_VOCE_PESO1, COD_VOCE_SPECIALE_PESO1, COD_VOCE_PESO2, COD_VOCE_SPECIALE_PESO2, COD_VOCE_CONGUAGLIO2, ');
    SQL.Add('COD_VOCE_SPECIALE_CONGUAGLIO2, RITENUTA_PROGRESSIVA_SCAGLIONI ');
    SQL.Add('FROM P232_SCAGLIONI WHERE COD_CONTRATTO = ''' + CodContrattoOri + ''' AND ');
    SQL.Add('COD_VOCE = ''' + CodVoceOri + ''' AND COD_VOCE_SPECIALE = ''' + CodVoceSpecialeOri + '''');
    Execute;
    //Inserimento tabella P233_SCAGLIONIFASCE
    SQL.Clear;
    SQL.Add('DECLARE');
    SQL.Add('CURSOR C1 IS SELECT ID_SCAGLIONE, DECORRENZA FROM P232_SCAGLIONI WHERE ');
    SQL.Add('COD_CONTRATTO =''' + CodContrattoOri + ''' AND COD_VOCE = ''' + CodVoceOri + ''' AND ');
    SQL.Add('COD_VOCE_SPECIALE = ''' + CodVoceSpecialeOri + ''';');
    SQL.Add('NewIdSscaglione NUMBER;');
    SQL.Add('P NUMBER;');
    SQL.Add('BEGIN');
    SQL.Add('FOR T1 IN C1 LOOP');
    SQL.Add('BEGIN');
    SQL.Add('SELECT ID_SCAGLIONE INTO NewIdSscaglione FROM P232_SCAGLIONI WHERE ');
    SQL.Add('COD_CONTRATTO = ''' + CodContrattoDes + ''' AND COD_VOCE = ''' + CodVoceDes + ''' AND ');
    SQL.Add('COD_VOCE_SPECIALE = ''' + CodVoceSpecialeDes + ''' AND DECORRENZA = T1.DECORRENZA;');
    SQL.Add('INSERT INTO P233_SCAGLIONIFASCE');
    SQL.Add('(ID_SCAGLIONE, IMPORTO_DA, IMPORTO_A, PERC_IMP)');
    SQL.Add('(SELECT NewIdSscaglione, IMPORTO_DA, IMPORTO_A, PERC_IMP ');
    SQL.Add('FROM P233_SCAGLIONIFASCE WHERE ID_SCAGLIONE = T1.ID_SCAGLIONE);');
    SQL.Add('EXCEPTION');
    SQL.Add('WHEN NO_DATA_FOUND THEN');
    SQL.Add('P:=0;');
    SQL.Add('END;');
    SQL.Add('END LOOP;');
    SQL.Add('END;');
    Execute;
    //Inserimento tabella P230_MINIMALI
    SQL.Clear;
    SQL.Add('INSERT INTO P230_MINIMALI ');
    SQL.Add('(COD_CONTRATTO, COD_VOCE, COD_VOCE_SPECIALE, DECORRENZA, IMPORTO_TEMPO_PIENO, IMPORTO_PART_TIME, ');
    SQL.Add('TIPO_IMPORTO, TIPO_INTEGRAZIONE, COD_VOCE_INTEGRAZIONE, COD_VOCE_SPECIALE_INTEGRAZIONE) ');
    SQL.Add('SELECT ''' + CodContrattoDes + ''', ''' + CodVoceDes + ''', ''' + CodVoceSpecialeDes + ''', ');
    SQL.Add('DECORRENZA, IMPORTO_TEMPO_PIENO, IMPORTO_PART_TIME, ');
    SQL.Add('TIPO_IMPORTO, TIPO_INTEGRAZIONE, COD_VOCE_INTEGRAZIONE, COD_VOCE_SPECIALE_INTEGRAZIONE ');
    SQL.Add('FROM P230_MINIMALI WHERE COD_CONTRATTO = ''' + CodContrattoOri + ''' AND ');
    SQL.Add('COD_VOCE = ''' + CodVoceOri + ''' AND COD_VOCE_SPECIALE = ''' + CodVoceSpecialeOri + '''');
    Execute;
  end;
end;

procedure TWC009FCopiaSuFM.DuplicazioneVociIntPaghe;
begin
  with InsRec do
  begin
    SQL.Clear;
    SQL.Add('INSERT INTO T193_VOCIPAGHE_PARAMETRI');
    SQL.Add('(COD_INTERFACCIA, VOCE_PAGHE, DECORRENZA, VOCE_PAGHE_CEDOLINO, VOCE_PAGHE_NEGATIVA, DESCRIZIONE, DAL, AL, AUTOINC_DAL, AUTOINC_AL, ARROTONDAMENTO, FORMULA, SPOSTA_VALIMP, VOCE_PAGHE_SECONDARIA, VOCE_PAGHE_SECONDH, VOCE_PAGHE_ATTRIBUTO, STATO_PER_SCARICO)');
    SQL.Add('SELECT ''' + LValoriNuovi[0] + ''', VOCE_PAGHE, DECORRENZA, VOCE_PAGHE_CEDOLINO, VOCE_PAGHE_NEGATIVA, DESCRIZIONE, DAL, AL, AUTOINC_DAL, AUTOINC_AL, ARROTONDAMENTO, FORMULA, SPOSTA_VALIMP, VOCE_PAGHE_SECONDARIA, VOCE_PAGHE_SECONDH, VOCE_PAGHE_ATTRIBUTO, STATO_PER_SCARICO');
    SQL.Add('FROM T193_VOCIPAGHE_PARAMETRI WHERE COD_INTERFACCIA = ''' + AggiungiApice(LValoriOriginali[0]) + '''');
    Execute;
  end;
end;

procedure TWC009FCopiaSuFM.DuplicazioneFondi;
var i:Integer;
  CodFondoOri,CodFondoDes,DecOri,DecDes:String;
begin
  for i:=0 to LChiavePrimaria.Count - 1 do
  begin
    if LChiavePrimaria[i] = 'COD_FONDO' then
    begin
      CodFondoOri:=Trim(LValoriOriginali[i]);
      CodFondoDes:=Trim(LValoriNuovi[i]);
    end
    else if LChiavePrimaria[i] = 'DECORRENZA_DA' then
    begin
      DecOri:=Trim(LValoriOriginali[i]);
      DecDes:=Trim(LValoriNuovi[i]);
    end;
  end;
  with InsRec do
  begin
    //Controllo eventuali intersezioni
    SQL.Clear;
    SQL.Add('select count(*) conta from ' + NomeTabella);
    SQL.Add('where cod_fondo = ''' + CodFondoDes + '''');
    SQL.Add('  and decorrenza_da <= TO_DATE(''31/12/' + Copy(DecDes,7,4) + ''',''DD/MM/YYYY'')');
    SQL.Add('  and decorrenza_a >= TO_DATE(''' + DecDes + ''',''DD/MM/YYYY'')');
    Execute;
    if StrToIntDef(VarToStr(Field(0)),0) > 0 then
      raise exception.Create(A000MSG_ERR_PERIODI_INTERSECANTI);
    //Inserimento tabella P684_FONDI
    SQL.Clear;
    SQL.Add('INSERT INTO ' + NomeTabella);
    SQL.Add('(cod_fondo,decorrenza_da,decorrenza_a,');
    SQL.Add(' descrizione,cod_macrocateg,cod_raggr,data_costituz,filtro_dipendenti)');
    SQL.Add('SELECT ''' + CodFondoDes + ''',TO_DATE(''' + DecDes + ''',''DD/MM/YYYY''),TO_DATE(''31/12/' + Copy(DecDes,7,4) + ''',''DD/MM/YYYY''),');
    SQL.Add(' descrizione,cod_macrocateg,cod_raggr,data_costituz,filtro_dipendenti');
    SQL.Add('FROM ' + NomeTabella + ' WHERE COD_FONDO = ''' + CodFondoOri + ''' AND DECORRENZA_DA = TO_DATE(''' + DecOri + ''',''DD/MM/YYYY'')');
    Execute;
    SQL.Clear;
    SQL.Add('INSERT INTO P686_RISDESTGEN');
    SQL.Add('(cod_fondo,Decorrenza_da,class_voce,cod_voce_gen,descrizione,tipo_voce,ordine_stampa)');
    SQL.Add('SELECT ''' + CodFondoDes + ''',TO_DATE(''' + DecDes + ''',''DD/MM/YYYY''),class_voce,cod_voce_gen,descrizione,tipo_voce,ordine_stampa');
    SQL.Add('FROM P686_RISDESTGEN WHERE COD_FONDO = ''' + CodFondoOri + ''' AND DECORRENZA_DA = TO_DATE(''' + DecOri + ''',''DD/MM/YYYY'')');
    Execute;
    SQL.Clear;
    SQL.Add('INSERT INTO P688_RISDESTDET');
    SQL.Add('(cod_fondo,Decorrenza_da,class_voce,cod_voce_gen,cod_voce_det,');
    SQL.Add(' descrizione,data_riferimento,quantita,datobase,moltiplicatore,');
    SQL.Add(' importo,cod_arrotondamento,filtro_dipendenti,codici_accorpamentovoci)');
    SQL.Add('SELECT ''' + CodFondoDes + ''',TO_DATE(''' + DecDes + ''',''DD/MM/YYYY''),class_voce,cod_voce_gen,cod_voce_det,');
    SQL.Add('  descrizione,data_riferimento,quantita,datobase,moltiplicatore,');
    SQL.Add('  DECODE(CLASS_VOCE,''D'',0,importo),cod_arrotondamento,filtro_dipendenti,codici_accorpamentovoci');
    SQL.Add('FROM P688_RISDESTDET WHERE COD_FONDO = ''' + CodFondoOri + ''' AND DECORRENZA_DA = TO_DATE(''' + DecOri + ''',''DD/MM/YYYY'')');
    Execute;
  end;
end;

procedure TWC009FCopiaSuFM.grdChiaveElementoRenderCell(ACell: TIWGridCell;
  const ARow, AColumn: Integer);
var
  CssTemp:String;
begin
  if ARow = 0 then
    CssTemp:=CssTemp + ' riga_intestazione'
  else if AColumn = 0 then
  begin
    CssTemp:=CssTemp + ' riga_grigia';
    CssTemp:=CssTemp + ' font_rosso';
  end;
  //Disabilito il campo edit
  //else if Storicizzazione and (UpperCase(TmeIWEdit(grdChiaveElemento.Cell[ARow,1].Control).Text) != 'DECORRENZA') then
  //  ACell.Control.Css:=ACell.Control.Css + ' font_rosso';

  ACell.Css:=Trim(CssTemp);
end;

function TWC009FCopiaSuFM.NomiColonne:String;
var i:Integer;
begin
  Result:='';
  for i:=0 to ODSatt.FieldCount - 1 do
  begin
    //Salto la copia dei campi tipo long
    if ODSatt.Fields[i] is TMemoField then
    begin
      if not(ODSatt.Fields[i].IsNull ) then
      begin
        sMsgAnomalie:=sMsgAnomalie + 'Il campo ' + ODSatt.Fields[i].FieldName + ' non è stato copiato'+ CHR(10);
      end;
    end
    else
    begin
      if (ODSatt.Fields[i].FieldKind = fkData) and (ODSatt.Fields[i].FieldName <> 'ROWNUM') and (not ODSatt.Fields[i].Calculated) and (not ODSatt.Fields[i].Lookup) then
      begin
        if Result <> '' then Result:=Result + ',';
        Result:=Result + ODSatt.Fields[i].FieldName;
      end;
    end;
  end;
end;

function TWC009FCopiaSuFM.ValoriColonne:String;
var
  i,j:Integer;
  Assegnato:boolean;
begin
  Result:='';
  for i:=0 to ODSatt.FieldCount - 1 do
  begin
    if (ODSatt.Fields[i].FieldKind = fkData) and
       (ODSatt.Fields[i].FieldName <> 'ROWNUM') and
       (not ODSatt.Fields[i].Calculated) and
       (not ODSatt.Fields[i].Lookup) and
       not(ODSatt.Fields[i] is TMemoField) then
    begin
      if Result <> '' then Result:=Result + ',';
      Assegnato:=False;
      //Scartare dalla duplicazione i campi in chiave
      for j:=0 to LChiavePrimaria.Count - 1 do
        if UpperCase(LChiavePrimaria[j]) = UpperCase(ODSatt.Fields[i].FieldName) then
        begin
          if LValoriNuovi[j] = '' then
            Result:=Result + 'NULL'
          else
            Result:=Result + '''' + LValoriNuovi[j] + '''';
          Assegnato:=True;
          break;
        end;
      if not Assegnato then
      begin
        //Controllo se si tratta di valore predefinito
        for j:=0 to LCampiPredefiniti.Count - 1 do
          if UpperCase(LCampiPredefiniti[j]) = UpperCase(ODSatt.Fields[i].FieldName) then
          begin
            if LValoriPredefiniti[j] = '' then
              Result:=Result + 'NULL'
            else
              Result:=Result + '''' + LValoriPredefiniti[j] + '''';
            Assegnato:=True;
            break;
          end
      end;
      if not Assegnato then
      begin
        Result:=Result + ODSatt.Fields[i].FieldName;
      end;
    end;
  end;
end;

function TWC009FCopiaSuFM.SostituisciValoriChiave(S:String):String;
var
  i,j:Integer;
begin
  Result:=S;
  with TStringList.Create do
  try
    CommaText:=S;
    for i:=0 to Count - 1 do
      for j:=0 to LChiavePrimaria.Count - 1 do
        if UpperCase(LChiavePrimaria[j]) = UpperCase(Strings[i]) then
        begin
          Strings[j]:='''' + LValoriNuovi[j] + '''';
          Break;
        end;
     Result:=CommaText;
  finally
    Free;
  end;
end;

procedure TWC009FCopiaSuFM.CreaNuovaCausale(Tipo:String);
var Q:TOracleQuery;
    S,S1,S2:String;
    NuovoID:String;
begin
  LCampiPredefiniti.Clear;
  LValoriPredefiniti.Clear;

  // Leggo il nuovo codice causale
  S:=LValoriNuovi[LChiavePrimaria.IndexOf('CODICE')];
  if S.Trim = '' then
    raise Exception.Create(A000MSG_ERR_CODICE_VUOTO);

  Q:=TOracleQuery.Create(nil);
  try
    Q.Session:=SessioneOracle;
    Q.SQL.Clear;
    if Tipo = 'ASSENZA' then
    begin
      S1:='T275_CAUPRESENZE';
      S2:='T305_CAUGIUSTIF';
    end
    else if Tipo = 'PRESENZA' then
    begin
      S1:='T265_CAUASSENZE';
      S2:='T305_CAUGIUSTIF';
    end
    else
    begin
      S1:='T265_CAUASSENZE';
      S2:='T275_CAUPRESENZE';
    end;
    Q.SQL.Add(Format('SELECT COUNT(*) CONTA FROM (SELECT CODICE FROM %s WHERE CODICE = ''%s'' UNION SELECT CODICE FROM %s WHERE CODICE = ''%s'')',[S1,S,S2,S]));
    Q.Execute;
    if Q.FieldAsInteger('CONTA') > 0 then
      raise exception.Create(A000MSG_ERR_CODICE_ESISTE_GIA);
    if Tipo = 'PRESENZA' then
    begin
      Q.SQL.Clear;
      Q.SQL.Add('DELETE FROM T276_VOCIPAGHEPRESENZA WHERE CODICE = ''' + S + '''');
      Q.Execute;
      Q.SQL.Clear;
      Q.SQL.Add('INSERT INTO T276_VOCIPAGHEPRESENZA');
      Q.SQL.Add('(codice,tipogiorno,dalle,alle,limite,vocepaghe)');
      Q.SQL.Add('SELECT ''' + S + ''',tipogiorno,dalle,alle,limite,vocepaghe');
      Q.SQL.Add('FROM T276_VOCIPAGHEPRESENZA WHERE CODICE = ''' + ODS.FieldByName('CODICE').AsString + '''');
      Q.Execute;
      Q.SQL.Clear;
      Q.SQL.Add('DELETE FROM T277_CAUFASCEABILITATE WHERE CODICE = ''' + S + '''');
      Q.Execute;
      Q.SQL.Clear;
      Q.SQL.Add('INSERT INTO T277_CAUFASCEABILITATE');
      Q.SQL.Add('(codice,tipo_giorno,dalle,alle)');
      Q.SQL.Add('SELECT ''' + S + ''',tipo_giorno,dalle,alle');
      Q.SQL.Add('FROM T277_CAUFASCEABILITATE WHERE CODICE = ''' + ODS.FieldByName('CODICE').AsString + '''');
      Q.Execute;
    end;

    if Tipo = 'ASSENZA' then
    begin
      Q.SQL.Clear;
      Q.SQL.Text:='select T265_ID.NEXTVAL from DUAL';
      Q.Execute;
      NuovoID:=Q.FieldAsString('NEXTVAL');
      LCampiPredefiniti.Add('ID');
      LValoriPredefiniti.Add(NuovoID);
    end
    else if Tipo = 'PRESENZA' then
    begin
      Q.SQL.Clear;
      Q.SQL.Text:='select T275_ID.NEXTVAL from DUAL';
      Q.Execute;
      NuovoID:=Q.FieldAsString('NEXTVAL');
      LCampiPredefiniti.Add('ID');
      LValoriPredefiniti.Add(NuovoID);
    end;

  finally
    Q.Free;
  end;

end;

procedure TWC009FCopiaSuFM.CreaNuovoContratto;
var
  S:String;
  Q:TOracleQuery;
begin
   // Leggo il nuovo codice contratto
  S:=LValoriNuovi[LChiavePrimaria.IndexOf('CODICE')];
  if S.Trim = '' then
    raise Exception.Create(A000MSG_ERR_CODICE_VUOTO);

  Q:=TOracleQuery.Create(nil);
  try
    Q.Session:=SessioneOracle;
    Q.SQL.Clear;
    Q.SQL.Add('DELETE FROM T201_MAGGIORAZIONI WHERE CODICE = ''' + S + '''');
    Q.Execute;
    Q.SQL.Clear;
    Q.SQL.Add('INSERT INTO T201_MAGGIORAZIONI');
    Q.SQL.Add('(codice,giorno,fasciada1,fasciada2,fasciada3,fasciada4,fasciaa1,fasciaa2,fasciaa3,fasciaa4,maggior1,maggior2,maggior3,maggior4)');
    Q.SQL.Add('SELECT ''' + S + ''',giorno,fasciada1,fasciada2,fasciada3,fasciada4,fasciaa1,fasciaa2,fasciaa3,fasciaa4,maggior1,maggior2,maggior3,maggior4');
    Q.SQL.Add('FROM T201_MAGGIORAZIONI WHERE CODICE = ''' + ODS.FieldByName('CODICE').AsString + '''');
    Q.Execute;
  finally
    Q.Free;
  end;
end;

procedure TWC009FCopiaSuFM.CreaNuovaIntPaghe;
var Q:TOracleQuery;
    S,NT:String;
begin
  // Leggo il codice contratto su cui copiare l'interfaccia
  S:=LValoriNuovi[LChiavePrimaria.IndexOf('CODICE')];
  if S.Trim = '' then
    raise Exception.Create(A000MSG_ERR_CODICE_VUOTO);

  NT:=R180EstraiNomeTabella(ODS.SQL.Text);
  ODSAtt:=ODS;
  Q:=TOracleQuery.Create(nil);
  try
    Q.Session:=SessioneOracle;
    Q.SQL.Clear;
    Q.SQL.Add('DELETE FROM ' + NT);
    Q.SQL.Add('WHERE CODICE = ''' + S + '''');
    Q.Execute;
    Q.SQL.Clear;
    Q.SQL.Add('INSERT INTO ' + NT);
    Q.SQL.Add('(' + NomiColonne + ')');
    Q.SQL.Add('SELECT ' + ValoriColonne);
    Q.SQL.Add('FROM ' + NT + ' WHERE CODICE = ''' + ODS.FieldByName('CODICE').AsString+ '''');
    Q.Execute;
    Q.SQL.Clear;
    Q.SQL.Add('INSERT INTO T193_VOCIPAGHE_PARAMETRI');
    Q.SQL.Add('(COD_INTERFACCIA, VOCE_PAGHE, DECORRENZA, VOCE_PAGHE_CEDOLINO, VOCE_PAGHE_NEGATIVA, DESCRIZIONE, DAL, AL, AUTOINC_DAL, AUTOINC_AL, ARROTONDAMENTO, FORMULA, SPOSTA_VALIMP, VOCE_PAGHE_SECONDARIA, VOCE_PAGHE_SECONDH, VOCE_PAGHE_ATTRIBUTO, STATO_PER_SCARICO)');
    Q.SQL.Add('SELECT ''' + S + ''', VOCE_PAGHE, DECORRENZA, VOCE_PAGHE_CEDOLINO, VOCE_PAGHE_NEGATIVA, DESCRIZIONE, DAL, AL, AUTOINC_DAL, AUTOINC_AL, ARROTONDAMENTO, FORMULA, SPOSTA_VALIMP, VOCE_PAGHE_SECONDARIA, VOCE_PAGHE_SECONDH, VOCE_PAGHE_ATTRIBUTO, STATO_PER_SCARICO');
    Q.SQL.Add('FROM T193_VOCIPAGHE_PARAMETRI WHERE COD_INTERFACCIA = ''' + ODS.FieldByName('CODICE').AsString + '''');
    Q.Execute;
    ODS.Refresh;
    ODS.Locate('CODICE',S,[]);
  finally
    Q.Free;
  end;
end;

procedure TWC009FCopiaSuFM.CreaNuovoCartellino(CodiceDa,CodiceA:String);
var
  Q:TOracleQuery;
begin
  Q:=TOracleQuery.Create(nil);
  try
    Q.Session:=SessioneOracle;
    Q.SQL.Clear;
    Q.SQL.Add('DELETE FROM T951_STAMPACARTELLINO_DATI WHERE CODICE = ''' + CodiceA + '''');
    Q.Execute;
    Q.SQL.Clear;
    Q.SQL.Add('INSERT INTO T951_STAMPACARTELLINO_DATI');
    Q.SQL.Add('(CODICE,NUMRIGA,RIGA)');
    Q.SQL.Add('SELECT ''' + CodiceA + ''',NUMRIGA,RIGA');
    Q.SQL.Add('FROM T951_STAMPACARTELLINO_DATI WHERE CODICE = ''' + CodiceDa + '''');
    Q.Execute;
  finally
    Q.Free;
  end;
end;

procedure TWC009FCopiaSuFM.CreaNuovaParMessaggi;
var
  Q:TOracleQuery;
  S:String;
begin
  S:=LValoriNuovi[LChiavePrimaria.IndexOf('CODICE')];
  if S.Trim = '' then
    raise Exception.Create(A000MSG_ERR_CODICE_VUOTO);

  Q:=TOracleQuery.Create(nil);
  try
    Q.Session:=SessioneOracle;
    Q.SQL.Add(Format('SELECT COUNT(*) CODICE FROM T292_PARMESSAGGIDATI WHERE CODICE = ''%s''',[S]));
    Q.Execute;
    if Q.FieldAsInteger('CODICE') > 0 then
      raise exception.Create('Codice già esistente!')
    else
    begin
      Q.SQL.Clear;
      Q.SQL.Add('DELETE FROM T292_PARMESSAGGIDATI WHERE CODICE = ''' + S + '''');
      Q.Execute;
      Q.SQL.Clear;
      Q.SQL.Add('INSERT INTO T292_PARMESSAGGIDATI');
      Q.SQL.Add('(codice,tipo_record,numero_record,tipo,posizione,lunghezza,nome_colonna,formato,valore_default,codice_dato,chiave)');
      Q.SQL.Add('SELECT ''' + S + ''',tipo_record,numero_record,tipo,posizione,lunghezza,nome_colonna,formato,valore_default,codice_dato,chiave');
      Q.SQL.Add('FROM T292_PARMESSAGGIDATI WHERE CODICE = ''' + ODS.FieldByName('CODICE').AsString + '''');
      Q.Execute;
    end;
  finally
    Q.Free;
  end;
end;


procedure TWC009FCopiaSuFM.btnChiudiClick(Sender: TObject);
begin
  inherited;
  FreeAndNil(LChiavePrimaria);//.Free;
  FreeAndNil(LValoriOriginali);//.Free;
  FreeAndNil(LValoriNuovi);//.Free;
  FreeAndNil(LCampiPredefiniti);//.Free;
  FreeAndNil(LValoriPredefiniti);//.Free;
  Free;
end;

end.
