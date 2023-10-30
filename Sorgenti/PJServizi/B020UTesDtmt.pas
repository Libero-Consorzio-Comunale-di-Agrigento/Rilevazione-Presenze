unit B020UTesDtmt;

interface

uses
  SysUtils, Classes,
  Windows, Oracle, OracleData, StrUtils, Contnrs, Forms, StdCtrls, Graphics, Math, DB,
  RpCon, RpConDS, RpBase, RpSystem, RpDefine, RpRave, RVCsStd, RVCsData, RVData,
  RvDirectDataView, RpRender, RpRenderPDF, RVClass, RVProj, RVCsDraw,
  R400UCartellinoDtm;

type
  TB020FTestDtm = class(TDataModule)
    selT070: TOracleDataSet;
    selAnagrafeW: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    Matricola,Dal,Al:String;
    procedure LeggiIntestazione;
    function Alignment2Justify(A:TAlignment):TPrintJustify;
    procedure EsecuzioneStampa;
    procedure DistruggiLstRaveComp;
    procedure GestioneSeparatoriBande;
    procedure GestioneSeparatoriColonne;
    procedure GetFont(Lista:TStringList; Sender:String; Banda:TRaveFontMaster);
    procedure GetLabels(Lista:TStringList; Sender:String; Banda:TRaveComponent);
    procedure Allinea_bndNote;
    procedure ChiusuraQuery(Sender:TComponent);
  public
    { Public declarations }
    rvSystem:TRVSystem;
    rvDWRiepilogo,rvDWDettaglio,rvDWPresenze,rvDWAssenze,rvDWSettimana:TRaveDataView;
    rvProject:TRVProject;
    rvPage:TRaveComponent;
    rvBand:TRaveComponent;
    rvFontMaster:TRaveFontMaster;
    rvRenderPDF:TRvRenderPDF;
    connRiepilogo:TRVDataSetConnection;
    connDettaglio:TRVDataSetConnection;
    connSettimana:TRVDataSetConnection;
    connPresenze:TRVDataSetConnection;
    connAssenze:TRVDataSetConnection;
    //selAnagrafe:TOracleDataSet;
    R400FCartellinoDtM:TR400FCartellinoDtM;
    lstRaveComp:TObjectList;
    CodiceT950,DatiIntestazione:String;
    ScalaStampa:Real;
    function CartellinoPDF(SessioneOracleB020:TOracleSession; const pMatricola,pDal,pAl,Parametrizzazione,FilePdf: WideString): WideString;
  end;

var
  B020FTestDtm: TB020FTestDtm;

implementation

{$R *.dfm}

uses A000UInterfaccia, A027UCostanti, C180FunzioniGenerali;

function TB020FTestDtm.CartellinoPDF(SessioneOracleB020:TOracleSession; const pMatricola,pDal,pAl,Parametrizzazione,FilePdf: WideString): WideString;
var DataI,DataF:TDateTime;
    A,M,G,A2,M2,G2,MCorr,ACorr:Word;
    iSQL:Integer;
    S,SQLText:String;
    lst:TStringList;
    procedure CalcoloCartellini;
    var xx,yy:Integer;
        i:Byte;
    begin
      R180AppendFile('c:\IrisWIN\B020\B020.log','CalcoloCartellini');
      MCorr:=M;
      ACorr:=A;
      while ((ACorr < A2) and (MCorr <= 12)) or ((ACorr = A2) and (MCorr <= M2)) do
      begin
        try
          repeat
            for xx:=1 to MaxRighe do for yy:=1 to MaxColonne do R400FCartellinoDtM.MatDettStampa[xx,yy]:='';
            for i:=1 to High(R400FCartellinoDtM.VetDomenica) do R400FCartellinoDtM.VetDomenica[i]:= -1;
            for xx:=Low(R400FCartellinoDtM.TotSett) to High(R400FCartellinoDtM.TotSett) do
            begin
              R400FCartellinoDtM.TotSett[xx].Data:=0;
              R400FCartellinoDtM.TotSett[xx].Debito:='';
              R400FCartellinoDtM.TotSett[xx].OreRese:='';
              R400FCartellinoDtM.TotSett[xx].Saldo:='';
            end;
            R400FCartellinoDtM.NumGiorniCartolina:=0;
            //Se devo ciclare per più mesi allora calcolo il numero di
            //giorni di ciascun mese
            if (M <> M2) or (A <> A2) then
              G2:=R180GiorniMese(EncodeDate(ACorr,MCorr,1));
            R400FCartellinoDtM.DipInser1:='si';
            (*
            if Parametri.WEBCartelliniChiusi = 'S' then
            begin
              selT070.Close;
              selT070.SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
              selT070.SetVariable('DATA',EncodeDate(ACorr,MCorr,1));
              selT070.Open;
              if selT070.FieldByName('NUM').AsInteger = 0 then
              begin
                R400FCartellinoDtM.DipInser1:='no';
                //if cmbDipendentiDisponibili.ItemIndex > 0 then
                //  Result:=Format('Scheda riepilogativa del mese di %s %d non esistente!',[R180NomeMese(MCorr),ACorr]);
                  //lblCommentoCorrente.Css:='segnalazione';
              end;
              selT070.Close;
            end;
            *)
            if R400FCartellinoDtM.DipInser1 = 'si' then
            begin
              R180AppendFile('c:\IrisWIN\B020\B020.log','R400FCartellinoDtM.CartolinaDipendente');
              R400FCartellinoDtM.CartolinaDipendente(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,ACorr,MCorr,G,G2);
              R180AppendFile('c:\IrisWIN\B020\B020.log','R400FCartellinoDtM.FineCartolinaDipendente');
              //Registrazione log per verificare chi stampa dal Web
              RegistraLog.SettaProprieta('C','T070_SCHEDARIEPIL',Copy(Self.Name,1,4),nil,True);
              RegistraLog.InserisciDato('PROGRESSIVO','',selAnagrafeW.FieldByName('PROGRESSIVO').AsString);
              RegistraLog.InserisciDato('DA_DATA','',DateToStr(DataI));
              RegistraLog.InserisciDato('A_DATA','',DateToStr(DataF));
              RegistraLog.RegistraOperazione;
            end;
            if R400FCartellinoDtM.DipInser1 = 'no' then
            begin
              inc(MCorr);
              if MCorr > 12 then
              begin
                inc(ACorr);
                MCorr:=1;
              end;
            end
            else //if Sender = btnStampa then
              R400FCartellinoDtM.CaricaClientDataSet(EncodeDate(ACorr,MCorr,G),EncodeDate(ACorr,MCorr,G2));
          until (R400FCartellinoDtM.DipInSer1 = 'si') or (ACorr > A2) or ((ACorr = A2) and (MCorr > M2));
          if R400FCartellinoDtM.DipInSer1 = 'no' then
            Break;
        except
          //on E:Exception do W000RegistraLog('Errore',Format('%s;%s;%s',[Copy(Self.Name,1,4),GGetWebApplicationThreadVar.AppID,E.Message]));
        end;
        inc(MCorr);
        if MCorr > 12 then
        begin
          inc(ACorr);
          MCorr:=1;
        end;
      end;
    end;
begin
  Matricola:=pMatricola;
  Dal:=pDal;
  Al:=pAl;
  DataI:=StrToDate(Dal);
  DataF:=StrToDate(Al);
  if DataF < DataI then
  begin
    Result:='Date non corrette!';
    exit;
  end;
  //SessioneOracle.LogonDatabase:='IRIS9.WORLD';
  //SessioneOracle.LogonUserName:='MONDOEDP';
  //SessioneOracle.LogonPassword:='TIMOTEO';
  //SessioneOracle.LogOn;
  selAnagrafeW.Session:=SessioneOracleB020;
  selT070.Session:=SessioneOracleB020;
  if R180Anno(DataI) <> R180Anno(DataF) then
  begin
    Result:='Le date devono essere riferite allo stesso anno!';
    exit;
  end;
  (*if DataI < Parametri.WEBCartelliniDataMin then
  begin
    Result:=Format('Non è possibile elaborare il cartellino prima del %s!',[DateToStr(Parametri.WEBCartelliniDataMin)]);
    exit;
  end;
  if (Parametri.WEBCartelliniMMPrec >= 0) and (R180AddMesi(R180InizioMese(DataI),Parametri.WEBCartelliniMMPrec) < R180InizioMese(Date)) then
  begin
    Result:=Format('Non è possibile elaborare il cartellino antecedente di %d mesi!',[Parametri.WEBCartelliniMMPrec]);
    exit;
  end;
  if (Parametri.WEBCartelliniMMSucc >= 0) and (R180InizioMese(DataF) > R180AddMesi(R180InizioMese(Date),Parametri.WEBCartelliniMMSucc)) then
  begin
    Result:=Format('Non è possibile elaborare il cartellino successivo a %d mesi!',[Parametri.WEBCartelliniMMSucc]);
    exit;
  end;
  *)
  //SQLText:=selAnagrafeW.SQL.Text;
  CodiceT950:=Parametrizzazione;
  DecodeDate(DataI,A,M,G);
  DecodeDate(DataF,A2,M2,G2);
  //Se le date differiscono di mese o di anno, allora i giorni vanno
  //da 1 all'ultimo del mese
  if (M <> M2) or (A <> A2) then
  begin
    G:=1;
    G2:=R180GiorniMese(DataF);
    DataI:=EncodeDate(A,M,G);
    DataF:=EncodeDate(A2,M2,G2);
    Dal:=DateToStr(DataI);
    Al:=DateToStr(DataF);
  end;
  try
    //R400FCartellinoDtM:=TR400FCartellinoDtM.Create(Self);
    R400FCartellinoDtM:=TR400FCartellinoDtM.Create(SessioneOracleB020);
  except
    exit;
  end;
  //RegistraMsg.IniziaMessaggio('W009');
  (*if chkAggiornamentoBuoniPasto.Checked then
  begin
    R400FCartellinoDtM.RiepilogoBuoniPasto:=True;
    R400FCartellinoDtM.R350DtM:=TR350FCalcoloBuoniDtM.Create(Self);
    R400FCartellinoDtM.R350DtM.RMCampoRagg:='';
    R400FCartellinoDtM.R350DtM.RMStampa:=False;
    R400FCartellinoDtM.R350DtM.RMIgnoraAnomalie:=True;
    R400FCartellinoDtM.R350DtM.RMRegistrazione:=True;
  end;
  if chkAggiornamentoAccessiMensa.Checked then
  begin
    R400FCartellinoDtM.RiepilogoAccessiMensa:=True;
    R400FCartellinoDtM.R300DtM:=TR300FAccessiMensaDtM.Create(Self);
    R400FCartellinoDtM.R300DtM.SettaPeriodo(DataI,DataF);
    R400FCartellinoDtM.R300DtM.FiltroRilevatori:='';
  end;*)
  try
  try
    R180AppendFile('c:\IrisWIN\B020\B020.log','R400FCartellinoDtM.Q950Int');
    with R400FCartellinoDtM.Q950Int do
    begin
      Close;
      SetVariable('Codice',CodiceT950);
      Open;
    end;
    R180AppendFile('c:\IrisWIN\B020\B020.log','R400FCartellinoDtM');
    R400FCartellinoDtM.selDatiBloccati.Close;
    R400FCartellinoDtM.SoloAggiornamento:=False;//Sender = btnAggiornamento;
    R400FCartellinoDtM.AggiornamentoScheda:=False;//chkAggiornamentoScheda.Checked;
    R400FCartellinoDtM.AutoGiustificazione:=False;//chkAutoGiustificazione.Checked;
    R400FCartellinoDtM.CalcoloCompetenze:=False;
    R400FCartellinoDtM.lstDettaglio.Clear;
    R400FCartellinoDtM.lstRiepilogo.Clear;
    R400FCartellinoDtM.LeggiDatiRichiesti('Intestazione');
    R400FCartellinoDtM.LeggiDatiRichiesti('Dettaglio');
    R400FCartellinoDtM.LeggiDatiRichiesti('Riepilogo');
    selAnagrafeW.SetVariable('DATALAVORO',DataF);
    selAnagrafeW.SetVariable('MATRICOLA',Matricola);
    selAnagrafeW.Close;
    if (Pos(R400FCartellinoDtM.CampiIntestazione,SelAnagrafeW.SQL.Text) = 0) and
       ((Pos('T030.*',SelAnagrafeW.SQL.Text) = 0) or (Pos('V430.*',SelAnagrafeW.SQL.Text) = 0)) then
    begin
      S:=SelAnagrafeW.SQL.Text;
      iSQL:=Pos('FROM',S);
      if iSQL > 0 then
        Insert(',' + R400FCartellinoDtM.CampiIntestazione + ' ',S,iSQL);
      SelAnagrafeW.SQL.Text:=S;
    end;
    R180AppendFile('c:\IrisWIN\B020\B020.log','selAnagrafeW.Open;');
    selAnagrafeW.Open;
    //if Sender = btnStampa then
    begin
      lst:=TStringList.Create;
      with R400FCartellinoDtM do
      try
        SetLength(VetDatiLiberiSQL,0);
        selT951.Close;
        selT951.SetVariable('Codice',Q950Int.FieldByName('CODICE').AsString);
        selT951.Open;
        while not selT951.Eof do
        begin
          lst.Add(Trim(selT951.FieldByName('RIGA').AsString));
          selT951.Next;
        end;
        selT951.Close;
        GetLabels(lst,'Riepilogo2001',nil);
        //Devo già avere l'elenco dei dati liberi 2001
        CreaClientDataSet(selAnagrafeW);
      finally
        lst.Free;
      end;
    end;
    R400FCartellinoDtM.A027SelAnagrafe:=selAnagrafeW;
    //Gestione Stampa singola o per tutti i dipendenti
    (*if cmbDipendentiDisponibili.ItemIndex = 0 then
      while not selAnagrafeW.Eof do
      begin
        CalcoloCartellini;
        selAnagrafeW.Next;
      end
    else*)
    begin
      //Posizionamento sulla matricola correntemente selezionata
      //Mat:=Trim(Copy(StringReplace(cmbDipendentiDisponibili.Text,SPAZIO,' ',[rfReplaceAll]),1,8));
      if selAnagrafeW.SearchRecord('MATRICOLA',Matricola,[srFromBeginning]) then
      begin
        CalcoloCartellini;
      end
      else
      begin
        //GetDipendentiDisponibili(DataF);
        Result:='Anagrafico non disponibile!';
        Abort;
      end;
    end;
    ChiusuraQuery(R400FCartellinoDtM);
    with R400FCartellinoDtM do
    begin
      //Chiudo subito le query e le unit dei conteggi, salvo Q950Int che serve in stampa
      Q950Int.Open;
      ChiusuraQuery(R450DtM1);
      FreeAndNil(R400FCartellinoDtM.R450DtM1);
      FreeAndNil(R400FCartellinoDtM.R600DtM1);
    end;
    //if Sender = btnStampa then
    begin
      try
       if R400FCartellinoDtM.cdsRiepilogo.RecordCount > 0 then
          EsecuzioneStampa
        else
          Result:='Nessun cartellino disponibile nel periodo specificato!';
      except
        on E:Exception do
          Result:=E.Message;
      end;
      with R400FCartellinoDtM do
      begin
        cdsRiepilogo.Close;
        cdsDettaglio.Close;
        cdsSettimana.Close;
        cdsAssenze.Close;
        cdsPresenze.Close;
        Q950Int.CloseAll;
      end;
    end;
  finally
    R400FCartellinoDtM.Q950Int.CloseAll;
    selAnagrafeW.CloseAll;
    //selAnagrafeW.SQL.Text:=SQLText;
    if R400FCartellinoDtM <> nil then
    begin
      R400FCartellinoDtM.Q950Int.CloseAll;
      R400FCartellinoDtM.A027SelAnagrafe:=nil;
      if R400FCartellinoDtM.R300DtM <> nil then
        FreeAndNil(R400FCartellinoDtM.R300DtM);
      if R400FCartellinoDtM.R350DtM <> nil then
        FreeAndNil(R400FCartellinoDtM.R350DtM);
      FreeAndNil(R400FCartellinoDtM);
    end;
    selAnagrafeW.Close;
    DistruggiLstRaveComp;
  end;
  except
    on E:Exception do
      Result:=E.Message;
  end;
end;

procedure TB020FTestDtm.GetFont(Lista:TStringList; Sender:String; Banda:TRaveFontMaster);
var i:Integer;
    S,App,Suff:String;
begin
  if Sender = 'Intestazione' then
    Suff:=''
  else
    Suff:=Sender;
  //Impostazioni del Font
  i:=Lista.IndexOf(Format('[FONT%s]',[Suff]));
  if i = -1 then
    exit;
  S:=Lista[i + 1];
  //Leggo il colore del Font
  if R180Getvalore(S,'[C]','[F]',App) then
    Banda.Font.Color:=StrToInt(App);
  //Leggo il nome del Font
  if R180Getvalore(S,'[F]','[S]',App) then
    Banda.Font.Name:=App;
  //Leggo il Size del Font
  if R180Getvalore(S,'[S]','[ST]',App) then
    Banda.Font.Size:=StrToInt(App);
  //Leggo lo Style del Font
  if R180Getvalore(S,'[ST]','',App) then
    Banda.Font.Style:=R180GetFontStyle(App);
end;

function TB020FTestDtm.Alignment2Justify(A:TAlignment):TPrintJustify;
begin
  Result:=pjLeft;
  if A = taLeftJustify then
    Result:=pjLeft
  else if A = taRightJustify then
    Result:=pjRight
  else if A = taCenter then
    Result:=pjCenter
end;

procedure TB020FTestDtm.Allinea_bndNote;
{Sposto i dati liberi all'inizio della banda poichè, leggendo dal gruppo di
 riepilogo, le coordinate sono riferite a tutti i dati riepilogativi (Riepilogo)}
var i:Integer;
    Min:Real;
    Banda:TRaveContainerControl;
begin
  Banda:=(RVProject.ProjMan.FindRaveComponent('bndNote',rvPage) as TRaveContainerControl);
  Min:=9999;
  for i:=0 to lstRaveComp.Count - 1 do
    if (TRaveComponent(lstRaveComp[i]).Parent = Banda) and (lstRaveComp[i] is TRaveCustomText) then
      if TRaveCustomText(lstRaveComp[i]).Top < Min then
        Min:=TRaveCustomText(lstRaveComp[i]).Top;
  for i:=0 to lstRaveComp.Count - 1 do
    if (TRaveComponent(lstRaveComp[i]).Parent = Banda) and (lstRaveComp[i] is TRaveCustomText) then
        TRaveCustomText(lstRaveComp[i]).Top:=TRaveCustomText(lstRaveComp[i]).Top - Min + 4 * ScalaStampa;
  Banda.Height:=Banda.Height - Min + 4 * ScalaStampa;
end;

procedure TB020FTestDtm.GetLabels(Lista:TStringList; Sender:String; Banda:TRaveComponent);
var i,j,i2:Integer;
    MaxTop,MaxTop2,HbndAssenze,HbndPresenze,LunCapt:Real;
    S,Nome,Capt,X,Y,H,W,Suff,Posiz:String;
    rvComp:TRaveComponent;
    procedure CreaLab_DBLab;{1}
    //banda bndIntestazione
    begin
    if Trim(Capt) <> '' then
    begin
      //Creo la caption se è specificata
      rvComp:=TRaveText.Create(rvPage);
      lstRaveComp.Add(rvComp);
      with (rvComp as TRaveText) do
      begin
        Parent:=Banda;
        Top:=StrToInt(Y) * ScalaStampa;
        Left:=StrToInt(X) * ScalaStampa;
        Height:=StrToInt(H) * ScalaStampa;
        with TLabel.Create(Self) do
        try
          Font.Assign(rvFontMaster.Font);
          Caption:=Capt;
          AutoSize:=True;
          LunCapt:=Width * ScalaStampa * 1.15;
          if UpperCase(Font.Name) = 'ARIAL NARROW' then
            LunCapt:=LunCapt * 1.15;
        finally
          Free;
        end;
        Width:=LunCapt;
        Tag:=StrToInt(Posiz);
        FontMirror:=rvFontMaster;
        Truncate:=True;
        Text:=Capt;
        //LunCapt:=Width;
        if Top + Height > MaxTop then
          MaxTop:=Top + Height;
      end;
    end;
    //Creo il DataText collegato a C700SelAnagrafe
    rvComp:=TRaveDataText.Create(rvPage);
    lstRaveComp.Add(rvComp);
    with (rvComp as TRaveDataText) do
    begin
      Parent:=Banda;
      Top:=StrToInt(Y) * ScalaStampa;
      Left:=(StrToInt(X) * ScalaStampa) + LunCapt;
      Height:=StrToInt(H) * ScalaStampa;
      Width:=(StrToInt(W) * ScalaStampa) - LunCapt;
      FontMirror:=rvFontMaster;
      Truncate:=True;
      DataView:=rvDWRiepilogo;
      DataField:=Nome;
      if Top + Height > MaxTop then
        MaxTop:=Top + Height;
    end;
    if Pos(Nome,DatiIntestazione) = 0 then
      DatiIntestazione:=DatiIntestazione + ',' + Nome;
    end;
    procedure CreaLab_Dett;{2}
    //banda bndDettaglio, bndColonne, bndTotali
    begin
      if Trim(Capt) <> '' then
      //Creo il dato in bndColonne
      begin
        if DatiDett[A027GetPosDett(StrToInt(Posiz))].F then
        begin
          rvComp:=TRaveDataMemo.Create(rvPage);
          lstRaveComp.Add(rvComp);
          (rvComp as TRaveDataMemo).DataView:=rvDWRiepilogo;
          (rvComp as TRaveDataMemo).DataField:='''' + Capt + #13 + '''&FASCE_CARTELLINO';
        end
        else
        begin
          rvComp:=TRaveText.Create(rvPage);
          lstRaveComp.Add(rvComp);
          (rvComp as TRaveText).Text:=Capt;
          (rvComp as TRaveText).Truncate:=True;
        end;
        with (rvComp as TRaveCustomText) do
        begin
          Parent:=RVProject.ProjMan.FindRaveComponent('bndColonne',rvPage);
          Top:=StrToInt(Y) * ScalaStampa;
          Left:=StrToInt(X) * ScalaStampa;
          Height:=StrToInt(H) * ScalaStampa;
          Width:=StrToInt(W) * ScalaStampa;
          Tag:=StrToInt(Posiz);
          FontMirror:=rvFontMaster;
          FontJustify:=Alignment2Justify(DatiDett[A027GetPosDett(Tag)].A);
          if Top + Height > MaxTop then
            MaxTop:=(Top + Height);
        end;
      end;
      //Creo il dato in bndDettaglio
      rvComp:=TRaveDataText.Create(rvPage);
      lstRaveComp.Add(rvComp);
      with (rvComp as TRaveDataText) do
      begin
        Parent:=Banda;
        Top:=StrToInt(Y) * ScalaStampa;
        Left:=StrToInt(X) * ScalaStampa;
        Height:=StrToInt(H) * ScalaStampa;
        Width:=StrToInt(W) * ScalaStampa;
        Tag:=StrToInt(Posiz);
        FontMirror:=rvFontMaster;
        FontJustify:=Alignment2Justify(DatiDett[A027GetPosDett(Tag)].A);
        Truncate:=True;
        DataView:=rvDWDettaglio;
        DataField:='Campo' + Posiz;
        //Hint:=H;
        if Top + Height > MaxTop2 then
          MaxTop2:=Top + Height;
        if Tag in C_TOTALI_SI then
        begin
          //creo il dato in bndTotali
          //(RVProject.ProjMan.FindRaveComponent('bndTotali',rvPage) as TRaveContainerControl).Enabled:=True;
          rvComp:=TRaveDataText.Create(rvPage);
          lstRaveComp.Add(rvComp);
          with (rvComp as TRaveDataText) do
          begin
            Parent:=(RVProject.ProjMan.FindRaveComponent('bndTotali',rvPage) as TRaveContainerControl);
            Top:=(StrToInt(Y) + 2) * ScalaStampa;
            Left:=StrToInt(X) * ScalaStampa;
            Height:=StrToInt(H) * ScalaStampa;
            Width:=StrToInt(W) * ScalaStampa;
            Font.Assign(rvFontMaster.Font);
            Font.Style:=[fsBold];
            FontJustify:=Alignment2Justify(DatiDett[A027GetPosDett(StrToInt(Posiz))].A);
            Truncate:=True;
            Tag:=A027GetIdxTotMese(StrToInt(Posiz));
            DataView:=rvDWRiepilogo;
            DataField:='TotGG' + IntToStr(Tag);
          end;
        end;
      end;
    end;
    procedure CreaMemo_Dett;{3}
    //banda bndDettaglio su più righe (Timbrature, Giustificativi, Anomalie, Timb.Mensa)
    begin
      if Trim(Capt) <> '' then
      begin
        //Creo la label di intestazione
        rvComp:=TRaveText.Create(rvPage);
        lstRaveComp.Add(rvComp);
        with (rvComp as TRaveText) do
        begin
          Parent:=RVProject.ProjMan.FindRaveComponent('bndColonne',rvPage);
          Top:=StrToInt(Y) * ScalaStampa;
          Left:=StrToInt(X) * ScalaStampa;
          Height:=StrToInt(H) * ScalaStampa;
          Width:=StrToInt(W) * ScalaStampa;
          Tag:=StrToInt(Posiz);
          FontMirror:=rvFontmaster;
          FontJustify:=Alignment2Justify(DatiDett[A027GetPosDett(Tag)].A);
          Truncate:=True;
          Text:=Capt;
          //Hint:=Capt;  //Memorizzo la caption per i dati con fasce (Eccedenze)
          if (Top + Height) > MaxTop then
            MaxTop:=(Top + Height);
        end;
      end;
      //Imposto il RichText
      rvComp:=TRaveDataMemo.Create(rvPage);
      lstRaveComp.Add(rvComp);
      with (rvComp as TRaveDataMemo) do
      begin
        Parent:=Banda;
        Top:=StrToInt(Y) * ScalaStampa;
        Left:=StrToInt(X) * ScalaStampa;
        Height:=StrToInt(H) * ScalaStampa;
        Width:=StrToInt(W) * ScalaStampa;
        Tag:=StrToInt(Posiz);
        Font.Assign(rvFontmaster.Font);
        FontJustify:=Alignment2Justify(DatiDett[A027GetPosDett(Tag)].A);
        //Truncate:=True;
        DataView:=rvDWDettaglio;
        DataField:='Campo' + Posiz;
        if Tag in [C_TI1..C_TI8] then
          case Tag of
            C_TI1:R400FCartellinoDtM.LungTimb:=6;
            C_TI2:R400FCartellinoDtM.LungTimb:=7;
            C_TI3:R400FCartellinoDtM.LungTimb:=8;
            C_TI4:R400FCartellinoDtM.LungTimb:=12;
            C_TI5:R400FCartellinoDtM.LungTimb:=9;
            C_TI6:R400FCartellinoDtM.LungTimb:=10;
            C_TI7:R400FCartellinoDtM.LungTimb:=11;
            C_TI8:R400FCartellinoDtM.LungTimb:=15;
          end;
        if Trim(R400FCartellinoDtM.Q950Int.FieldByName('Anomalia').AsString) <> '' then
          inc(R400FCartellinoDtM.LungTimb,1);
        if (Top + Height) > MaxTop2 then
          MaxTop2:=Top + Height;
      end;
    end;
    procedure CreaLab_Riep;{7}
    //banda bndRiepilogo (caption + dato) - per dato libero 2 (tag=2000) solo caption
    begin
      if (Trim(Capt) <> '') and (StrToInt(Posiz) <> 2001) then
      begin
        //Creo la caption se è specificata
        rvComp:=TRaveText.Create(rvPage);
        lstRaveComp.Add(rvComp);
        with (rvComp as TRaveText) do
        begin
          Parent:=Banda;
          Top:=StrToInt(Y) * ScalaStampa;
          Left:=StrToInt(X) * ScalaStampa;
          Height:=StrToInt(H) * ScalaStampa;
          with TLabel.Create(Self) do
          try
            Font.Assign(rvFontMaster.Font);
            Caption:=Capt;
            AutoSize:=True;
            LunCapt:=Width * ScalaStampa;
          finally
            Free;
          end;
          Width:=LunCapt;
          Tag:=StrToInt(Posiz);
          FontMirror:=rvFontMaster;
          FontJustify:=pjLeft;//Alignment2Justify(DatiDett[GetPosDett(Tag)].A);
          Truncate:=True;
          Tag:=0;
          Text:=Capt;
          if (Top + Height) > MaxTop then
            MaxTop:=(Top + Height);
        end;
      end;
      //Creo la label contenente il valore
      if StrToInt(Posiz) <> 2000 then
      begin
        rvComp:=TRaveDataText.Create(rvPage);
        lstRaveComp.Add(rvComp);
        with (rvComp as TRaveDataText) do
        begin
          Parent:=Banda;
          Top:=StrToInt(Y) * ScalaStampa;
          Left:=StrToInt(X) * ScalaStampa + LunCapt;
          Height:=StrToInt(H) * ScalaStampa;
          Width:=Max(0,StrToInt(W) * ScalaStampa - LunCapt);
          Tag:=StrToInt(Posiz);
          if StrToInt(Posiz) = 2001 then
            Tag:=R400FCartellinoDtM.GetTagDatoLiberoSQL(Capt);
          FontMirror:=rvFontMaster;
          if (StrToInt(Posiz) = 21) or (StrToInt(Posiz) = 23) then
            FontJustify:=pjLeft
          else
            FontJustify:=pjRight;
          Truncate:=True;
          DataView:=rvDWRiepilogo;
          //DataField:='Campo' + Posiz;
          DataField:='Campo' + IntToStr(Tag);
          if (Top + Height) > MaxTop then
            MaxTop:=(Top + Height);
        end;
      end;
    end;
    procedure CreaLabel;{8}
    //banda bndNote (Dato libero descrittivo)
    begin
      rvComp:=TRaveText.Create(rvPage);
      lstRaveComp.Add(rvComp);
      with (rvComp as TRaveText) do
      begin
        Parent:=Banda;
        Top:=StrToInt(Y) * ScalaStampa;
        Left:=StrToInt(X) * ScalaStampa;
        Height:=StrToInt(H) * ScalaStampa;
        Width:=StrToInt(W) * ScalaStampa;//rvFontMaster.Font.Size * ScalaStampa * Length(Capt) * 0.8;
        Tag:=StrToInt(Posiz);
        FontMirror:=rvFontMaster;
        Truncate:=True;
        Text:=Capt;
        if (Top + Height + 4 * ScalaStampa) > (Banda as TRaveContainerControl).Height then
          (Banda as TRaveContainerControl).Height:=Top + Height + 4 * ScalaStampa;
      end;
    end;
    procedure CreaLab_Assenze;{9}
    //banda bndAssenze, bndColAssenze
    begin
      if Trim(Capt) <> '' then
      //Creo il dato in bndColAssenze
      begin
        rvComp:=TRaveText.Create(rvPage);
        lstRaveComp.Add(rvComp);
        with (rvComp as TRaveText) do
        begin
          Parent:=RVProject.ProjMan.FindRaveComponent('bndColAssenze',rvPage);
          Top:=2 * ScalaStampa;
          Left:=StrToInt(X) * ScalaStampa;
          Height:=StrToInt(H) * ScalaStampa;
          Width:=StrToInt(W) * ScalaStampa;
          Tag:=StrToInt(Posiz);
          FontMirror:=rvFontMaster;
          FontJustify:=Alignment2Justify(DatiDett[A027GetPosDett(Tag)].A);
          Truncate:=True;
          Text:=Capt;
        end;
      end;
      //Creo il dato in bndAssenze
      rvComp:=TRaveDataText.Create(rvPage);
      lstRaveComp.Add(rvComp);
      with (rvComp as TRaveDataText) do
      begin
        Parent:=Banda;
        Top:=2 * ScalaStampa;
        Left:=StrToInt(X) * ScalaStampa;
        Height:=StrToInt(H) * ScalaStampa;
        Width:=StrToInt(W) * ScalaStampa;
        Tag:=StrToInt(Posiz);
        FontMirror:=rvFontMaster;
        FontJustify:=Alignment2Justify(DatiDett[A027GetPosDett(Tag)].A);
        Truncate:=True;
        DataView:=rvDWAssenze;
        DataField:='Campo' + Posiz;
        if Top + Height > HbndAssenze then
          HbndAssenze:=Top + Height;
      end;
    end;
    procedure CreaLab_Presenze;{10}
    //banda bndPresenze, bndColPresenze
    begin
      if Trim(Capt) <> '' then
      //Creo il dato in bndColPresenze
      begin
        rvComp:=TRaveText.Create(rvPage);
        lstRaveComp.Add(rvComp);
        with (rvComp as TRaveText) do
        begin
          Parent:=RVProject.ProjMan.FindRaveComponent('bndColPresenze',rvPage);
          Top:=2 * ScalaStampa;
          Left:=StrToInt(X) * ScalaStampa;
          Height:=StrToInt(H) * ScalaStampa;
          Width:=StrToInt(W) * ScalaStampa;
          Tag:=StrToInt(Posiz);
          FontMirror:=rvFontMaster;
          FontJustify:=Alignment2Justify(DatiDett[A027GetPosDett(Tag)].A);
          Truncate:=True;
          Text:=Capt;
        end;
      end;
      //Creo il dato in bndPresenze
      rvComp:=TRaveDataText.Create(rvPage);
      lstRaveComp.Add(rvComp);
      with (rvComp as TRaveDataText) do
      begin
        Parent:=Banda;
        Top:=2 * ScalaStampa;
        Left:=StrToInt(X) * ScalaStampa;
        Height:=StrToInt(H) * ScalaStampa;
        Width:=StrToInt(W) * ScalaStampa;
        Tag:=StrToInt(Posiz);
        FontMirror:=rvFontMaster;
        FontJustify:=Alignment2Justify(DatiDett[A027GetPosDett(Tag)].A);
        Truncate:=True;
        DataView:=rvDWPresenze;
        DataField:='Campo' + Posiz;
        if Top + Height > HbndPresenze then
          HbndPresenze:=Top + Height;
      end;
    end;
begin
  if Sender = 'Intestazione' then
  begin
    Suff:='';
    DatiIntestazione:='';
  end
  else if Sender = 'Riepilogo2001' then
    Suff:='Riepilogo'   
  else
    Suff:=Sender;
  //Impostazioni delle Labels
  MaxTop:=0;
  MaxTop2:=0;
  HbndAssenze:=0;
  HbndPresenze:=0;
  i:=Lista.IndexOf(Format('[LABELS%s]',[Suff]));
  if i = -1 then
    exit;
  //Cerco la fine delle impostazioni del gruppo (Intestazione/Dettaglio/Riepilogo)
  i2:=Lista.IndexOf('[FONTDettaglio]');
  if i2 < i then
  begin
    i2:=Lista.IndexOf('[FONTRiepilogo]');
    if i2 < i then
      i2:=Lista.Count;
  end;
  for j:=i + 1 to i2 - 1 do
  begin
    S:=Lista[j];
    //Leggo il Nome della labels
    if not R180Getvalore(S,'[N]','[C]',Nome) then
      Continue;
    if not R180Getvalore(S,'[C]','[T]',Capt) then
      Continue;
    if not R180Getvalore(S,'[T]','[L]',Y) then
      Continue;
    if not R180Getvalore(S,'[L]','[H]',X) then
      Continue;
    if not R180Getvalore(S,'[H]','[W]',H) then
      Continue;
    if not R180Getvalore(S,'[W]','[G]',W) then
      Continue;
    if not R180Getvalore(S,'[G]','',Posiz) then
      Posiz:='0';
    LunCapt:=0;
    //Creazione labels per intestazione
    if Sender = 'Intestazione' then
      CreaLab_DBLab;
    //Creazione labels per dettaglio
    if Sender = 'Dettaglio' then
      case StrToInt(Posiz) of
        C_TI1..C_TI8,C_GI1..C_GI2,C_TM1,C_ANM:CreaMemo_Dett
      else
        CreaLab_Dett;
      end;
    //Creazione label per il riepilogo
    if Sender = 'Riepilogo' then
      case StrToInt(Posiz) of
        0..899,2000,2001://Dati riepilogativi + Dato libero 2 + Dato libero SQL
        begin
          Banda:=RVProject.ProjMan.FindRaveComponent('bndRiepilogo',rvPage);
          CreaLab_Riep;
        end;
        901..949://Riepilogo assenze
        begin
          Banda:=RVProject.ProjMan.FindRaveComponent('bndAssenze',rvPage);
          CreaLab_Assenze;
        end;
        951..999://Riepilogo presenze
        begin
          Banda:=RVProject.ProjMan.FindRaveComponent('bndPresenze',rvPage);
          CreaLab_Presenze;
        end;
        1000://Dato libero
        begin
          Banda:=RVProject.ProjMan.FindRaveComponent('bndNote',rvPage);
          CreaLabel;
        end;
      end;
    if (Sender = 'Riepilogo2001') and (StrToInt(Posiz) = 2001) then
      R400FCartellinoDtM.GetTagDatoLiberoSQL(Capt);
  end;
  if Sender = 'Intestazione' then
    (Banda as TRaveContainerControl).Height:=MaxTop;
  if Sender = 'Dettaglio' then
  begin
    (RVProject.ProjMan.FindRaveComponent('bndColonne',rvPage) as TRaveContainerControl).Height:=MaxTop + 2 * ScalaStampa;
    (Banda as TRaveContainerControl).Height:=MaxTop2 + 2 * ScalaStampa;
    (RVProject.ProjMan.FindRaveComponent('bndTotali',rvPage) as TRaveContainerControl).Height:=MaxTop2 + 2 * ScalaStampa;
    (RVProject.ProjMan.FindRaveComponent('bndSettimana',rvPage) as TRaveContainerControl).Height:=MaxTop2 + 2 * ScalaStampa;
    //Registro l'altezza della banda di dettaglio per gestire timbr. & giustif.
    Banda.Tag:=Trunc(MaxTop2 * 100000) + 2;
  end;
  if Sender = 'Riepilogo' then
  begin
    //(Banda as TRaveContainerControl).Height:=MaxTop;
    (RVProject.ProjMan.FindRaveComponent('bndRiepilogo',rvPage) as TRaveContainerControl).Height:=MaxTop;
    (RVProject.ProjMan.FindRaveComponent('bndColPresenze',rvPage) as TRaveContainerControl).Height:=HbndPresenze + ScalaStampa;
    (RVProject.ProjMan.FindRaveComponent('bndColAssenze',rvPage) as TRaveContainerControl).Height:=HbndAssenze + ScalaStampa;
    (RVProject.ProjMan.FindRaveComponent('bndPresenze',rvPage) as TRaveContainerControl).Height:=HbndPresenze + ScalaStampa;
    (RVProject.ProjMan.FindRaveComponent('bndAssenze',rvPage) as TRaveContainerControl).Height:=HbndAssenze + ScalaStampa;
  end;
end;

procedure TB020FTestDtM.EsecuzioneStampa;
var
  rvComp:TRaveComponent;
  L:TStringList;
  URL_Stampa,S,NomeFile,Orientamento:String;
  dconnRiepilogo,dconnDettaglio,dconnSettimana,dconnAssenze,dconnPresenze:TRaveDataConnection;
begin
  R180AppendFile('c:\IrisWIN\B020\B020.log','TB020FTestDtM.EsecuzioneStampa');
  //W000RegistraLog('Traccia',Format('%s;%s;%s',[Copy(Self.Name,1,4),GGetWebApplicationThreadVar.AppID,'Creazione stampa pdf']));
  try
    //CSStampa.Enter;
    rvSystem:=TRVSystem.Create(Self);
    rvProject:=TRVProject.Create(Self);
    connRiepilogo:=TRVDataSetConnection.Create(Self);
    connDettaglio:=TRVDataSetConnection.Create(Self);
    connSettimana:=TRVDataSetConnection.Create(Self);
    connPresenze:=TRVDataSetConnection.Create(Self);
    connAssenze:=TRVDataSetConnection.Create(Self);
    rvRenderPDF:=TRvRenderPDF.Create(Self);
    L:=TStringList.Create;
    try
      rvProject.Engine:=RvSystem;
      rvRenderPDF.Active:=True;
      rvProject.ProjectFile:='c:\IrisWIN\W009StampaCartellino.rav';//GGetWebApplicationThreadVar.ApplicationPath + 'W009StampaCartellino.rav';
      connRiepilogo.Name:='connRiepilogo';
      connRiepilogo.DataSet:=R400FCartellinoDtM.cdsRiepilogo;
      connDettaglio.Name:='connDettaglio';
      connDettaglio.DataSet:=R400FCartellinoDtM.cdsDettaglio;
      connSettimana.Name:='connSettimana';
      connSettimana.DataSet:=R400FCartellinoDtM.cdsSettimana;
      connPresenze.Name:='connPresenze';
      connPresenze.DataSet:=R400FCartellinoDtM.cdsPresenze;
      connAssenze.Name:='connAssenze';
      connAssenze.DataSet:=R400FCartellinoDtM.cdsAssenze;
      rvProject.Open;
      rvProject.GetReportList(L,True);
      rvProject.SelectReport(L[0],True);
      rvDWRiepilogo:=(RVProject.ProjMan.FindRaveComponent('dwRiepilogo',nil) as TRaveDataView);
      rvDWDettaglio:=(RVProject.ProjMan.FindRaveComponent('dwDettaglio',nil) as TRaveDataView);
      rvDWSettimana:=(RVProject.ProjMan.FindRaveComponent('dwSettimana',nil) as TRaveDataView);
      rvDWPresenze:=(RVProject.ProjMan.FindRaveComponent('dwPresenze',nil) as TRaveDataView);
      rvDWAssenze:=(RVProject.ProjMan.FindRaveComponent('dwAssenze',nil) as TRaveDataView);
      //Impostazioni dei campi di Dettaglio
      dconnDettaglio:=CreateDataCon(connDettaglio);
      rvDWDettaglio.ConnectionName:=dconnDettaglio.Name;
      rvDWDettaglio.DataCon:=dconnDettaglio;
      CreateFields(rvDWDettaglio,nil,nil,True);
      //Impostazioni dei campi di Settimana
      dconnSettimana:=CreateDataCon(connSettimana);
      rvDWSettimana.ConnectionName:=dconnSettimana.Name;
      rvDWSettimana.DataCon:=dconnSettimana;
      CreateFields(rvDWSettimana,nil,nil,True);
      //Impostazioni dei campi del riepilogo Presenze
      dconnPresenze:=CreateDataCon(connPresenze);
      rvDWPresenze.ConnectionName:=dconnPresenze.Name;
      rvDWPresenze.DataCon:=dconnPresenze;
      CreateFields(rvDWPresenze,nil,nil,True);
      //Impostazioni dei campi del riepilogo Assenze
      dconnAssenze:=CreateDataCon(connAssenze);
      rvDWAssenze.ConnectionName:=dconnAssenze.Name;
      rvDWAssenze.DataCon:=dconnAssenze;
      CreateFields(rvDWAssenze,nil,nil,True);
      rvPage:=RVProject.ProjMan.FindRaveComponent('W009.Page',nil);
      // orientamento
      Orientamento:=R400FCartellinoDtM.Q950Int.FieldByName('ORIENTAMENTO').AsString;
      if Orientamento = 'V' then
        TRavePage(rvPage).Orientation:=RpDefine.poPortrait
      else if Orientamento = 'O' then
        TRavePage(rvPage).Orientation:=RpDefine.poLandscape
      else
        TRavePage(rvPage).Orientation:=RpDefine.poDefault;
      //Impostazioni della banda bndTitolo
      //rvBand:=RVProject.ProjMan.FindRaveComponent('bndTitolo',rvPage);
      rvComp:=RVProject.ProjMan.FindRaveComponent('bmpLogo',rvPage);
      (rvComp as TRaveBitmap).Height:=0;
      (rvComp as TRaveBitmap).Width:=0;
      rvComp:=RVProject.ProjMan.FindRaveComponent('lblAzienda',rvPage);
      (rvComp as TRaveText).Text:=Parametri.RagioneSociale;
      S:='''RILEVAZIONE DEL MESE DI '' & DATA_CARTELLINO';
      if R400FCartellinoDtM.AggiornamentoScheda then
        S:=S + ' & '' CON AGGIORNAMENTO DELLA SCHEDA RIEPILOGATIVA''';
      rvComp:=RVProject.ProjMan.FindRaveComponent('lblTitolo',rvPage);
      (rvComp as TRaveDataText).DataField:=S;
      //Impostazioni della banda bndIntestazione
      ScalaStampa:=0.2 / 18;
      LeggiIntestazione;
      //Impostazioni dei campi di Riepilogo
      dconnRiepilogo:=CreateDataCon(connRiepilogo);
      rvDWRiepilogo.ConnectionName:=dconnRiepilogo.Name;
      rvDWRiepilogo.DataCon:=dconnRiepilogo;
      CreateFields(rvDWRiepilogo,nil,nil,True);
      //Generazione del file PDF
      rvSystem.SystemSetups:=RVSystem.SystemSetups - [ssAllowSetup];
      rvSystem.DefaultDest := rdFile;
      rvSystem.DoNativeOutput := False;
      rvSystem.RenderObject := RvRenderPDF;
      rvSystem.SystemFiler.StreamMode := smTempFile;
      NomeFile:=Matricola + FormatDateTime('hhnnss',Now) + '.pdf';
      rvSystem.OutputFileName:='c:\IrisWIN\B020\' + NomeFile;
      ForceDirectories(ExtractFileDir(rvSystem.OutputFileName));
      //W000RegistraLog('Traccia',Format('%s;%s;%s',[Copy(Self.Name,1,4),GGetWebApplicationThreadVar.AppID,'Produzione stampa pdf']));
      rvProject.Execute;
      //W000RegistraLog('Traccia',Format('%s;%s;%s',[Copy(Self.Name,1,4),GGetWebApplicationThreadVar.AppID,'Stampa pdf prodotta']));
    finally
      //W000RegistraLog('Traccia',Format('%s;%s;%s',[Copy(Self.Name,1,4),GGetWebApplicationThreadVar.AppID,'Distruzione componenti per stampa pdf']));
      try L.Free; except end;
      try DistruggiLstRaveComp; except end;
      try rvProject.Close; except end;
      try dconnRiepilogo.Free; except end;
      try dconnDettaglio.Free; except end;
      try dconnSettimana.Free; except end;
      try dconnPresenze.Free; except end;
      try dconnAssenze.Free; except end;
      try FreeAndNil(rvSystem); except end;
      try FreeAndNil(rvRenderPDF); except end;
      try FreeAndNil(rvProject); except end;
      try FreeAndNil(connRiepilogo); except end;
      try FreeAndNil(connDettaglio); except end;
      try FreeAndNil(connSettimana); except end;
      try FreeAndNil(connPresenze); except end;
      try FreeAndNil(connAssenze); except end;
      //CSStampa.Leave;
    end;
  except
    on E:Exception do //W000RegistraLog('Errore',Format('%s;%s;%s',[Copy(Self.Name,1,4),GGetWebApplicationThreadVar.AppID,E.Message]));
  end;
  //W000RegistraLog('Traccia',Format('%s;%s;%s',[Copy(Self.Name,1,4),GGetWebApplicationThreadVar.AppID,'Fine stampa pdf']));
end;

procedure TB020FTestDtM.LeggiIntestazione;
{Leggo i dati parametrizzati creando i controlli RaveReport appropriati col font richiesto}
var ListaSettaggi:TStringlist;
begin
  (RVProject.ProjMan.FindRaveComponent('bndTotali',rvPage) as TRaveContainerControl).Height:=0;
  (RVProject.ProjMan.FindRaveComponent('bndRiepilogo',rvPage) as TRaveContainerControl).Height:=0;
  (RVProject.ProjMan.FindRaveComponent('bndPresenze',rvPage) as TRaveContainerControl).Height:=0;
  (RVProject.ProjMan.FindRaveComponent('bndAssenze',rvPage) as TRaveContainerControl).Height:=0;
  (RVProject.ProjMan.FindRaveComponent('bndNote',rvPage) as TRaveContainerControl).Height:=0;
  DistruggiLstRaveComp;
  ListaSettaggi:=TStringList.Create;
  with R400FCartellinoDtM do
    try
      SetLength(VetDatiLiberiSQL,0);
      ListaSettaggi.Clear;
      selT951.Close;
      selT951.SetVariable('Codice',R400FCartellinoDtM.Q950Int.FieldByName('CODICE').AsString);
      selT951.Open;
      while not selT951.Eof do
      begin
        ListaSettaggi.Add(Trim(selT951.FieldByName('RIGA').AsString));
        selT951.Next;
      end;
      selT951.Close;
      //configurazione Intestazione
      rvFontMaster:=(RVProject.ProjMan.FindRaveComponent('fontIntestazione',rvPage) as TRaveFontMaster);
      if rvFontMaster <> nil then
        GetFont(ListaSettaggi,'Intestazione',rvFontMaster);
      rvBand:=RVProject.ProjMan.FindRaveComponent('bndIntestazione',rvPage);
      GetLabels(ListaSettaggi,'Intestazione',rvBand);
      //configurazione Dettaglio
      rvFontMaster:=(RVProject.ProjMan.FindRaveComponent('fontDettaglio',rvPage) as TRaveFontMaster);
      if rvFontMaster <> nil then
        GetFont(ListaSettaggi,'Dettaglio',rvFontMaster);
      rvBand:=RVProject.ProjMan.FindRaveComponent('bndDettaglio',rvPage);
      GetLabels(ListaSettaggi,'Dettaglio',rvBand);
      //configurazione Riepilogo
      rvFontMaster:=(RVProject.ProjMan.FindRaveComponent('fontRiepilogo',rvPage) as TRaveFontMaster);
      if rvFontMaster <> nil then
        GetFont(ListaSettaggi,'Riepilogo',rvFontMaster);
      rvBand:=RVProject.ProjMan.FindRaveComponent('bndRiepilogo',rvPage);
      GetLabels(ListaSettaggi,'Riepilogo',rvBand);
      Allinea_bndNote;
      GestioneSeparatoriBande;
      if R400FCartellinoDtM.Q950Int.FieldByName('SeparaDati').AsString = 'S' then
        GestioneSeparatoriColonne;
    finally
      ListaSettaggi.Free;
    end;
end;

procedure TB020FTestDtM.GestioneSeparatoriBande;
var Banda,Regione:TRaveContainerControl;
    l:TRaveHLine;
begin
  Regione:=(RVProject.ProjMan.FindRaveComponent('Region1',rvPage) as TRaveContainerControl);
  with (RVProject.ProjMan.FindRaveComponent('lineColonne1',rvPage) as TRaveHLine) do
  begin
    Top:=0;
    Width:=Regione.Width;
  end;
  Banda:=(RVProject.ProjMan.FindRaveComponent('bndColonne',rvPage) as TRaveContainerControl);
  with (RVProject.ProjMan.FindRaveComponent('lineColonne2',rvPage) as TRaveHLine) do
  begin
    Top:=Banda.Height;
    Width:=Regione.Width;
  end;
  with (RVProject.ProjMan.FindRaveComponent('lineSettimana1',rvPage) as TRaveHLine) do
  begin
    Top:=0;
    Width:=Regione.Width;
  end;
  Banda:=(RVProject.ProjMan.FindRaveComponent('bndSettimana',rvPage) as TRaveContainerControl);
  with (RVProject.ProjMan.FindRaveComponent('lineSettimana2',rvPage) as TRaveHLine) do
  begin
    Top:=Banda.Height;
    Width:=Regione.Width;
  end;
  with (RVProject.ProjMan.FindRaveComponent('lineTotali',rvPage) as TRaveHLine) do
  begin
    Top:=0;
    Width:=Regione.Width;
  end;
  with (RVProject.ProjMan.FindRaveComponent('lineRiepilogo',rvPage) as TRaveHLine) do
  begin
    Top:=0;
    Width:=Regione.Width;
  end;
  with (RVProject.ProjMan.FindRaveComponent('linePresenze',rvPage) as TRaveHLine) do
  begin
    Top:=0;
    Width:=Regione.Width;
  end;
  with (RVProject.ProjMan.FindRaveComponent('lineAssenze',rvPage) as TRaveHLine) do
  begin
    Top:=0;
    Width:=Regione.Width;
  end;
  with (RVProject.ProjMan.FindRaveComponent('lineNote',rvPage) as TRaveHLine) do
  begin
    Top:=0;
    Width:=Regione.Width;
  end;
  if R400FCartellinoDtM.Q950Int.FieldByName('SeparaRighe').AsString = 'S' then
  begin
    Banda:=(RVProject.ProjMan.FindRaveComponent('bndDettaglio',rvPage) as TRaveContainerControl);
    with (RVProject.ProjMan.FindRaveComponent('lineDettaglio',rvPage) as TRaveHLine) do
    begin
      Top:=Banda.Height;
      Width:=Regione.Width;
    end;
  end
  else
  begin
    l:=(RVProject.ProjMan.FindRaveComponent('lineDettaglio',rvPage) as TRaveHLine);
    l.Width:=0;
  end;
end;

procedure TB020FTestDtM.GestioneSeparatoriColonne;
var i:Integer;
    Banda:TRaveContainerControl;
    rvComp:TRaveVLine;
begin
  Banda:=(RVProject.ProjMan.FindRaveComponent('bndDettaglio',rvPage) as TRaveContainerControl);
  i:=0;
  while i < lstRaveComp.Count do
  begin
    if (TRaveComponent(lstRaveComp[i]).Parent = Banda) and (lstRaveComp[i] is TRaveCustomText) then
    begin
      rvComp:=TRaveVLine.Create(rvPage);
      lstRaveComp.Add(rvComp);
      with rvComp do
      begin
        Parent:=Banda;
        Top:=0;
        Left:=TRaveCustomText(lstRaveComp[i]).Left + TRaveCustomText(lstRaveComp[i]).Width + ScalaStampa;
        Height:=Banda.Height;
        Anchor:=48; //Vertical: Stretch - Orizontal: Left
      end;
    end;
    inc(i);
  end;
end;

procedure TB020FTestDtm.DataModuleCreate(Sender: TObject);
begin
  lstRaveComp:=TObjectList.Create;
  lstRaveComp.OwnsObjects:=False;
end;

procedure TB020FTestDtm.DataModuleDestroy(Sender: TObject);
begin
  try FreeAndNil(lstRaveComp); except end;
end;

procedure TB020FTestDtM.DistruggiLstRaveComp;
var i:Integer;
    rc:TObject;
begin
  for i:=lstRaveComp.Count - 1 downto 0 do
  begin
    rc:=lstRaveComp[i];
    if (rc is TRaveComponent) then
      (rc as TRaveComponent).Free
    else if (rc is TObject) then
      (rc as TObject).Free
    else if (rc is TRaveText) then
      (rc as TRaveText).Free
    else if (rc is TRaveDataText) then
      (rc as TRaveDataText).Free;
  end;
  lstRaveComp.Clear;
end;

procedure TB020FTestDtM.ChiusuraQuery(Sender:TComponent);
var i:Integer;
begin
  if Sender = nil then
    exit;
  for i:=0 to Sender.ComponentCount - 1 do
  begin
    try
      if Sender.Components[i] is TOracleDataSet then
        TOracleDataSet(Sender.Components[i]).CloseAll
      else if Sender.Components[i] is TDataModule then
        ChiusuraQuery(Sender.Components[i]);
    except
      //on E:Exception do W000RegistraLog('Errore',Format('%s;%s;%s',[Copy(Self.Name,1,4),GGetWebApplicationThreadVar.AppID,E.Message]));
    end;
  end;
end;

end.
