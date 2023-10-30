unit A037UStampaRep;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, quickrpt, Qrctrls, C180FunzioniGenerali, OracleData,
  C700USelezioneAnagrafe, Variants;

type
  TA037FStampaRep = class(TForm)
    QRep: TQuickRep;
    DettReperib: TQRBand;
    PageHeaderBand1: TQRBand;
    IntReperib: TQRBand;
    TotReperib: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRNumPag: TQRLabel;
    LAzienda: TQRLabel;
    QRTitolo: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    LTurni: TQRLabel;
    LTurniCSI: TQRLabel;
    QRLabel6: TQRLabel;
    LMaggCSI: TQRLabel;
    QRLabel7: TQRLabel;
    LNonMaggCSI: TQRLabel;
    QRLabel8: TQRLabel;
    QRDBText1: TQRDBText;
    QRData: TQRLabel;
    QRLabel9: TQRLabel;
    QRTurni: TQRLabel;
    QRMagg: TQRLabel;
    QRNonMagg: TQRLabel;
    TurniNonMagg: TQRLabel;
    QRNome: TQRLabel;
    QRLabel1: TQRLabel;
    QRDBText3: TQRDBText;
    QRDContratto: TQRLabel;
    QRNOrd: TQRLabel;
    DettStraord: TQRChildBand;
    QRDBText4: TQRDBText;
    QRNome2: TQRLabel;
    QRNOrd2: TQRLabel;
    QRData2: TQRLabel;
    IntStraord: TQRChildBand;
    QRLabel2: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    TotStraord: TQRChildBand;
    QRLabel14: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLDatoLibero: TQRDBText;
    QRLDatoLibero2: TQRDBText;
    TurniMagg: TQRLabel;
    TurniInteri: TQRLabel;
    procedure QRepNeedData(Sender: TObject; var MoreData: Boolean);
    procedure QRepBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure DettReperibBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure TotReperibBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRepStartPage(Sender: TCustomQuickRep);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DettStraordBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure TotStraordBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
    NumPagine,NumPagOld,NumOrd:Word;
    PrimoRecord:Boolean;
    TotTurni,TotMagg,TotNonMagg:LongInt;
    procedure GetDatiRep;
    procedure GetDatiStraord;
    function GetContratto(C:String):String;
    function Inserisci(S1,S2:String):String;
  public
    { Public declarations }
    LInt,LDett,LTot:TList;
    TotStrFasce:Array[0..27] of Integer;
    procedure SvuotaListe;
    procedure CreaFasce(C:String);
  end;

var
  A037FStampaRep: TA037FStampaRep;

implementation

uses A037UScaricoPagheDtM1, A037UScaricoPaghe, A037UDialogStampa;

{$R *.DFM}

procedure TA037FStampaRep.FormCreate(Sender: TObject);
begin
  QRep.useQR5Justification:=True;
  LInt:=TList.Create;
  LDett:=TList.Create;
  LTot:=TList.Create;
end;

procedure TA037FStampaRep.QRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
var xx:Integer;
begin
  with A037FScaricoPagheDtM1 do
    begin
    C700SelAnagrafe.First;
    GetValoriEsistenti(C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,'NULL');
    if A037FDialogStampa.TipoStampa = 0 then
      GetDatiRep
    else
      GetDatiStraord;
    QRDContratto.Caption:=GetContratto(C700SelAnagrafe.FieldByName('T430CONTRATTO').AsString);
    end;
  TotTurni:=0;
  TotMagg:=0;
  TotNonMagg:=0;
  for xx:=Low(TotStrFasce) to High(TotStrFasce) do TotStrFasce[xx]:=0;
  NumPagOld:=NumPagine;
  QRNumPag.Caption:='/ ' + IntToStr(NumPagOld);
  NumPagine:=0;
  NumOrd:=0;
end;

procedure TA037FStampaRep.QRepStartPage(Sender: TCustomQuickRep);
begin
  inc(NumPagine);
end;

procedure TA037FStampaRep.QRepNeedData(Sender: TObject;
  var MoreData: Boolean);
var C:String;
    Q:TOracleDataSet;
begin
  MoreData:=True;
  with A037FScaricoPagheDtM1 do
    begin
    if A037FDialogStampa.TipoStampa = 0 then
      Q:=QDatiReper
    else
      Q:=QOreLavFasce;
    //Leggo i dati di reperibilità
    if not PrimoRecord then  //Gestisco il primo record
      Q.Next;
    if PrimoRecord then
      PrimoRecord:=False;
    //Se ho finito di leggerli passo al dipendente successivo
    if Q.Eof then
      begin
      C:=C700SelAnagrafe.FieldByName('T430CONTRATTO').AsString;
      C700SelAnagrafe.Next;
      if C700SelAnagrafe.Eof then
        //Se ho finito i dipendenti chiudo la stampa
        MoreData:=False
      else
        begin
        GetValoriEsistenti(C700SelAnagrafe.FieldByName('Progressivo').AsInteger,'NULL');
        if A037FDialogStampa.TipoStampa = 0 then
          GetDatiRep
        else
          GetDatiStraord;
        PrimoRecord:=False;
        if C700SelAnagrafe.FieldByName('T430Contratto').AsString <> C then
          begin
          QRDContratto.Caption:=GetContratto(C700SelAnagrafe.FieldByName('T430Contratto').AsString);
          QRep.NewColumn;
          end;
        end;
      end;
    end;
end;

function TA037FStampaRep.GetContratto(C:String):String;
begin
  Result:='';
  with A037FScaricoPagheDtM1.Q200 do
    begin
    Close;
    SetVariable('Codice',C);
    Open;
    if RecordCount > 0 then
      Result:=FieldByName('Descrizione').AsString;
    end;
end;

procedure TA037FStampaRep.GetDatiRep;
begin
  with A037FScaricoPagheDtM1 do
    begin
    QDatiReper.Close;
    QDatiReper.SetVariable('Progressivo',C700SelAnagrafe.FieldByName('Progressivo').AsInteger);
    QDatiReper.SetVariable('Data1',A037FScaricoPaghe.DataIndietro);
    QDatiReper.SetVariable('Data2',A037FScaricoPaghe.Data);
    QDatiReper.Open;
    PrimoRecord:=True;
    end;
end;

procedure TA037FStampaRep.GetDatiStraord;
begin
  with A037FScaricoPagheDtM1 do
    begin
    QOreLavFasce.Close;
    QOreLavFasce.SetVariable('Progressivo',C700SelAnagrafe.FieldByName('Progressivo').AsInteger);
    QOreLavFasce.SetVariable('Data1',A037FScaricoPaghe.DataIndietro);
    QOreLavFasce.SetVariable('Data2',A037FScaricoPaghe.Data);
    QOreLavFasce.Open;
    PrimoRecord:=True;
    end;
end;

procedure TA037FStampaRep.DettReperibBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
{Calcolo i totali e non stampo la banda se i valori sono tutti a 0}
var T1,T2,T3:LongInt;
begin
  with A037FScaricoPagheDtM1 do
    begin
    T1:=QDatiReperTurniInteri.AsInteger;
    T2:=R180OreMinutiExt(QDatiReperOreMagg.AsString);
    T3:=R180OreMinutiExt(QDatiReperOreNonMagg.AsString);
    with A037FScaricoPaghe do
      begin
      A037FScaricoPaghe.VettCI[1].CodicePaghe:=LTurniCSI.Caption;
      A037FScaricoPaghe.VettCI[1].CodiceInterno:='260';
      A037FScaricoPaghe.VettCI[1].Riferimento:=QDatiReperData.AsDateTime;
      A037FScaricoPaghe.VettCI[1].Anno:=R180Anno(QDatiReperData.AsDateTime);
      A037FScaricoPaghe.VettCI[1].Mese:=R180Mese(QDatiReperData.AsDateTime);
      A037FScaricoPaghe.VettCI[1].Dal:=R180InizioMese(QDatiReperData.AsDateTime);
      A037FScaricoPaghe.VettCI[1].Al:=R180FineMese(QDatiReperData.AsDateTime);
      A037FScaricoPaghe.VettCI[1].MisuraInterna:='N';
      A037FScaricoPaghe.VettCI[1].Valore:=T1;
      EliminaSingolaVoce(C700SelAnagrafe.FieldByName('Progressivo').AsInteger,1);
      GetValore(C700SelAnagrafe.FieldByName('Progressivo').AsInteger,1);
      T1:=Trunc(A037FScaricoPaghe.VettCI[1].Valore);
      A037FScaricoPaghe.VettCI[1].CodicePaghe:=LMaggCSI.Caption;
      A037FScaricoPaghe.VettCI[1].CodiceInterno:='280';
      A037FScaricoPaghe.VettCI[1].Riferimento:=QDatiReperData.AsDateTime;
      A037FScaricoPaghe.VettCI[1].Anno:=R180Anno(QDatiReperData.AsDateTime);
      A037FScaricoPaghe.VettCI[1].Mese:=R180Mese(QDatiReperData.AsDateTime);
      A037FScaricoPaghe.VettCI[1].Dal:=R180InizioMese(QDatiReperData.AsDateTime);
      A037FScaricoPaghe.VettCI[1].Al:=R180FineMese(QDatiReperData.AsDateTime);
      A037FScaricoPaghe.VettCI[1].MisuraInterna:='H';
      A037FScaricoPaghe.VettCI[1].Valore:=T2;
      EliminaSingolaVoce(C700SelAnagrafe.FieldByName('Progressivo').AsInteger,1);
      GetValore(C700SelAnagrafe.FieldByName('Progressivo').AsInteger,1);
      T2:=Trunc(A037FScaricoPaghe.VettCI[1].Valore);
      A037FScaricoPaghe.VettCI[1].CodicePaghe:=LNonMaggCSI.Caption;
      A037FScaricoPaghe.VettCI[1].CodiceInterno:='290';
      A037FScaricoPaghe.VettCI[1].Riferimento:=QDatiReperData.AsDateTime;
      A037FScaricoPaghe.VettCI[1].Anno:=R180Anno(QDatiReperData.AsDateTime);
      A037FScaricoPaghe.VettCI[1].Mese:=R180Mese(QDatiReperData.AsDateTime);
      A037FScaricoPaghe.VettCI[1].Dal:=R180InizioMese(QDatiReperData.AsDateTime);
      A037FScaricoPaghe.VettCI[1].Al:=R180FineMese(QDatiReperData.AsDateTime);
      A037FScaricoPaghe.VettCI[1].MisuraInterna:='H';
      A037FScaricoPaghe.VettCI[1].Valore:=T3;
      EliminaSingolaVoce(C700SelAnagrafe.FieldByName('Progressivo').AsInteger,1);
      GetValore(C700SelAnagrafe.FieldByName('Progressivo').AsInteger,1);
      T3:=Trunc(A037FScaricoPaghe.VettCI[1].Valore);
      end;
    PrintBand:=(T1 <> 0) or (T2 <> 0) or (T3 <> 0);
    if PrintBand then
      begin
      TurniInteri.Caption:=IntToStr(T1);
      inc(TotTurni,T1);
      inc(TotMagg,T2);
      inc(TotNonMagg,T3);
      QRNome.Caption:=Trim(C700SelAnagrafe.FieldByName('Cognome').AsString) + ' ' + Trim(C700SelAnagrafe.FieldByName('Nome').AsString);
      QRData.Caption:=FormatDateTime('mmmm yyyy',QDatiReperData.AsDateTime);
      if T2 <> 0 then
        TurniMagg.Caption:=R180Centesimi(T2)
      else
        TurniMagg.Caption:='';
      if T3 <> 0 then
        TurniNonMagg.Caption:=R180Centesimi(T3)
      else
        TurniNonMagg.Caption:='';
      inc(NumOrd);
      QRNOrd.Caption:=IntToStr(NumOrd);
      end;
    end;
end;

procedure TA037FStampaRep.DettStraordBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
{Calcolo i totali e non stampo la banda se i valori sono tutti a 0}
var T:Array[0..27] of Integer;
    S:Array[0..27] of String;
    i,j,xx,Somma:Integer;
    DOld:TDateTime;
    MaggOld:Integer;
begin
  PrimoRecord:=True;  //Lo scorrimento delle fasce avviene qui e non su NeedData
  with A037FScaricoPagheDtM1 do
    begin
    DOld:=QOreLavFasceData.AsDateTime;
    i:=0;
    Somma:=0;
    for xx:=Low(T) to High(T) do
    begin
      T[xx]:=0;
      S[xx]:='';
    end;
    MaggOld:=0;
    while (not QOreLavFasce.Eof) and (DOld = QOreLavFasceData.AsDateTime) do
      begin
      if QOreLavFasceMaggiorazione.AsInteger = MaggOld then
        dec(i);
      MaggOld:=QOreLavFasceMaggiorazione.AsInteger;
      T[i]:=T[i] + R180OreMinutiExt(QOreLavFasceLiquidNelMese.AsString);
      S[i]:=QOreLavFascePStr_Nel_Mese.AsString;
      QOreLavFasce.Next;
      inc(i);
      end;
    for j:=0 to i - 1 do
      with A037FScaricoPaghe do
        begin
        VettCI[1].CodicePaghe:=S[j];
        VettCI[1].CodiceInterno:='060';
        VettCI[1].Riferimento:=DOld;
        VettCI[1].Anno:=R180Anno(DOld);
        VettCI[1].Mese:=R180Mese(DOld);
        VettCI[1].Dal:=R180InizioMese(DOld);
        VettCI[1].Al:=R180FineMese(DOld);
        VettCI[1].MisuraInterna:='H';
        VettCI[1].Valore:=T[j];
        EliminaSingolaVoce(C700SelAnagrafe.FieldByName('Progressivo').AsInteger,1);
        GetValore(C700SelAnagrafe.FieldByName('Progressivo').AsInteger,1);
        T[j]:=Trunc(VettCI[1].Valore);
        inc(Somma,T[j]);
        inc(TotStrFasce[j],T[j]);
        if T[j] = 0 then
          TQRLabel(LDett[j]).Caption:=''
        else
          TQRLabel(LDett[j]).Caption:=R180Centesimi(T[j]);
        end;
    PrintBand:=Somma <> 0;
    if PrintBand then
      begin
      QRNome2.Caption:=Trim(C700SelAnagrafe.FieldByName('Cognome').AsString) + ' ' + Trim(C700SelAnagrafe.FieldByName('Nome').AsString);
      QRData2.Caption:=FormatDateTime('mmmm yyyy',DOld);
      inc(NumOrd);
      QRNOrd2.Caption:=IntToStr(NumOrd);
      end;
    end;
end;

procedure TA037FStampaRep.TotReperibBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  QRTurni.Caption:=IntToStr(TotTurni);
  QRMagg.Caption:=R180Centesimi(TotMagg);
  QRNonMagg.Caption:=R180Centesimi(TotNonMagg);
end;

procedure TA037FStampaRep.TotStraordBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var i:Integer;
begin
  for i:=0 to LTot.Count - 1 do
    TQRLabel(LTot[i]).Caption:=R180Centesimi(TotStrFasce[i]);
end;

procedure TA037FStampaRep.CreaFasce(C:String);
{Creo i componenti TQRLabel sulla base delle fasce del contratto}
var L:Word;
    AppQR:TQRLabel;
    MaggOld:Integer;
begin
  SvuotaListe;
  with A037FScaricoPagheDtM1.Q210 do
    begin
    //Leggo i dati delle fasce
    Close;
    SetVariable('Codice',C);
    Open;
    L:=368;
    MaggOld:=0;
    while not Eof do
      begin
      if MaggOld = FieldByName('Maggiorazione').AsInteger then
        begin
        //Creo una colonna sola per più fasce di maggiorazione uguali (30%)
        TQRLabel(LInt[LInt.Count - 2]).Caption:=Inserisci(FieldByName('Codice').AsString,TQRLabel(LInt[LInt.Count - 2]).Caption);
        Next;
        Continue;
        end;
      MaggOld:=FieldByName('Maggiorazione').AsInteger;
      //Nome_fascia(Magg.%)
      AppQR:=TQRLabel(IntStraord.AddPrintable(TQRLabel));
      LInt.Add(AppQR);
      AppQR.Left:=L;
      AppQR.Top:=4;
      AppQR.Caption:=Format('%s(%s%%)',[FieldByName('Codice').AsString,FieldByName('Maggiorazione').AsString]);
      //Voce paghe della fascia
      AppQR:=TQRLabel(IntStraord.AddPrintable(TQRLabel));
      LInt.Add(AppQR);
      AppQR.Left:=L;
      AppQR.Top:=20;
      AppQR.Caption:=FieldByName('PStr_Nel_Mese').AsString;
      //Valore del dettaglio
      AppQR:=TQRLabel(DettStraord.AddPrintable(TQRLabel));
      LDett.Add(AppQR);
      AppQR.Left:=L;
      AppQR.Top:=2;
      //Totale
      AppQR:=TQRLabel(TotStraord.AddPrintable(TQRLabel));
      LTot.Add(AppQR);
      AppQR.Left:=L;
      AppQR.Top:=4;
      inc(L,80);
      Next;
      end;
    end;
end;

procedure TA037FStampaRep.SvuotaListe;
var i:Integer;
begin
  for i:=LDett.Count - 1 downto 0 do
    begin
    TQRLabel(LDett[i]).Free;
    LDett.Delete(i);
    TQRLabel(LTot[i]).Free;
    LTot.Delete(i);
    end;
  for i:=LInt.Count - 1 downto 0 do
    begin
    TQRLabel(LInt[i]).Free;
    LInt.Delete(i);
    end;
end;

function TA037FStampaRep.Inserisci(S1,S2:String):String;
var P:Integer;
begin
  P:=Pos('(',S2);
  if P > 0 then
    Insert('-' + S1,S2,P);
  Result:=S2;
end;

procedure TA037FStampaRep.FormDestroy(Sender: TObject);
begin
  SvuotaListe;
  LInt.Free;
  LDett.Free;
  LTot.Free;
end;

end.
