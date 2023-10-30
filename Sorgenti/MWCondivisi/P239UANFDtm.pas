unit P239UANFDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, QueryStorico, A000UInterfaccia, C180FUNZIONIGENERALI,
  DB, OracleData;

type
  TDatiOutP239 = record
    Blocca:String;
    DataCalc:TDateTime;
    DipInServizio:Boolean;
    CodTabella:String;
    DescTabella:String;
    RedditoLavDip:Real;
    RedditoAltro:Real;
    RichiedenteInabile:Integer;
    NucleoPiuTreFigli:Boolean;
    Coniuge:Integer;
    ConiugeInabile:Integer;
    FigliMin:Integer;
    FigliMinInabili:Integer;
    FigliMagInabili:Integer;
    FratSorNip:Integer;
    FratSorNipInabili:Integer;
    NumComponenti:Integer;
    NumComponentiInabili:Integer;
    NumComponentiNoFigliMag:Integer;
    Importo:Real;
    Messaggio:String;
  end;

type
  TP239FANFDtM = class(TR004FGestStoricoDtM)
    selP430: TOracleDataSet;
    selSG101: TOracleDataSet;
    selP238: TOracleDataSet;
    selP450: TOracleDataSet;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    //Decorrenza assegno unico per i figli 2022
    DataDecAssUnicoFigli2022:TDateTime;
    DipInSer:TDipendenteInServizio;
  public
    { Public declarations }
    function CalcoloANF(Chiamante:String; Progressivo:Integer; DataCalcolo:TDateTime):TDatiOutP239;
    function MaggNucleiOltreMax(Importo,PercMagg,CompMagg:Real; NumComp,NumCompMax:Integer):Real;
    function RiduzFratSorNip(Importo,Riduz1,Riduz2:Real; DatiNucleo:P239UANFDtM.TDatiOutP239):Real;
  end;
{$IFNDEF IRISWEB}
var
  P239FANFDtM: TP239FANFDtM;
{$ENDIF}
implementation

{$R *.dfm}

procedure TP239FANFDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  DipInSer:=TDipendenteInServizio.Create(nil);
  DipInSer.Session:=SessioneOracle;
end;

procedure TP239FANFDtM.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  DipInSer.Free;
end;

function TP239FANFDtM.CalcoloANF(Chiamante:String; Progressivo:Integer; DataCalcolo:TDateTime):TDatiOutP239;
var DatiOut:P239UANFDtM.TDatiOutP239;
    SommaReddito:Boolean;
begin
  DataDecAssUnicoFigli2022:=StrToDate('01/03/2022');
  with DatiOut do
  begin
    Blocca:='';
    DataCalc:=DataCalcolo;
    DipInServizio:=False;
    CodTabella:='';
    DescTabella:='';
    RedditoLavDip:=0;
    RedditoAltro:=0;
    RichiedenteInabile:=0;
    NucleoPiuTreFigli:=False;
    Coniuge:=0;
    ConiugeInabile:=0;
    FigliMin:=0;
    FigliMinInabili:=0;
    FigliMagInabili:=0;
    FratSorNip:=0;
    FratSorNipInabili:=0;
    NumComponenti:=0;
    NumComponentiInabili:=0;
    NumComponentiNoFigliMag:=0;
    Importo:=0;
    Messaggio:='';
  end;
  if Chiamante = 'Calcolo' then
  begin
    //L'assegno è calcolato solo se il dipendente è in servizio almeno un giorno nel mese
    DatiOut.DipInServizio:=DipInser.DipendenteInServizio(Progressivo,R180InizioMese(DataCalcolo),DataCalcolo);
    if DatiOut.DipInServizio = False then
    begin
      Result:=DatiOut;
      exit;
    end;
  end;
  //Lettura dati del richiedente
  selP430.SetVariable('Progressivo',Progressivo);
  selP430.SetVariable('Decorrenza',DataCalcolo);
  selP430.Close;
  selP430.Open;
  //L'assegno è calcolato solo se esiste un reddito totale sul richiedente
  DatiOut.RedditoLavDip:=selP430.FieldByName('REDDITO_ANF').AsFloat;
  DatiOut.RedditoAltro:=selP430.FieldByName('REDDITO_ALTRO_ANF').AsFloat;
  if (DatiOut.RedditoLavDip + DatiOut.RedditoAltro) <= 0 then
  begin
    Result:=DatiOut;
    exit;
  end;
  //L'assegno è calcolato solo se la data fine è successiva al mese di calcolo
  if selP430.FieldByName('SCADENZA_ANF').AsDateTime < DataCalcolo then
  begin
      Result:=DatiOut;
      exit;
  end;
  if Chiamante = 'Calcolo' then
  begin
    //Se nel mese esiste il numero giorni diritto assegno per il nucleo familiare
    //l'assegno è calcolato solo se il numero stesso è maggiore di 0
    selP450.SetVariable('Progressivo',Progressivo);
    selP450.SetVariable('Data_Retribuzione',DataCalcolo);
    selP450.Close;
    selP450.Open;
    if not selP450.Eof then
      if selP450.FieldByName('VALORE').AsInteger <= 0 then
      begin
        DatiOut.Messaggio:='Assegno non spettante poichè non sono maturati giorni per ANF';
        Result:=DatiOut;
        exit;
      end;
  end;
  //Verifica se richiedente inabile
  if selP430.FieldByName('INABILE_ANF').AsString = 'S' then
    DatiOut.RichiedenteInabile:=1;
  //Lettura nucleo familiare
  selSG101.SetVariable('Progressivo',Progressivo);
  selSG101.SetVariable('InizioMese',R180InizioMese(DataCalcolo));
  selSG101.SetVariable('FineMese',DataCalcolo);
  selSG101.Close;
  selSG101.Open;
  //Verifica se nucleo familiare con più di 3 figli di età inferiore a 26 anni
  selSG101.Filtered:=False;
  selSG101.Filter:='(GRADOPAR = ''FG'')AND (MESI_NASCITA < 313)';
  selSG101.Filtered:=True;
  if selSG101.RecordCount > 3 then
    DatiOut.NucleoPiuTreFigli:=True;
  selSG101.Filtered:=False;
  selSG101.First;
  //Analisi dettagliata del nucleo familiare
  with DatiOut do
  begin
    while not selSG101.Eof do
    begin
      SommaReddito:=False;
      if selSG101.FieldByName('GRADOPAR').AsString = 'CG' then
      begin
        //Coniuge oppure unito civilmente oppure convivente di fatto
        Coniuge:=Coniuge + 1;
        SommaReddito:=True;
        if selSG101.FieldByName('INABILE_ANF').AsString = 'S' then
          ConiugeInabile:=ConiugeInabile + 1;
      end
      else if (selSG101.FieldByName('GRADOPAR').AsString = 'FG')
               or
               ((selSG101.FieldByName('GRADOPAR').AsString = 'NF')
                 and (selSG101.FieldByName('MESI_NASCITA').AsInteger < 217)
               ) then
      begin
        //Figlio o nipote minore equiparato a figlio
        if (selSG101.FieldByName('MESI_NASCITA').AsInteger < 217)
            or
            ((NucleoPiuTreFigli = True) and (selSG101.FieldByName('MESI_NASCITA').AsInteger < 253)
              and (selSG101.FieldByName('SPECIALE_ANF').AsString = 'S')
            ) then
          begin
            //Minorenne o minore di 21 anni studente/apprendista di nucleo familiare con più di 3 figli
            FigliMin:=FigliMin + 1;
            SommaReddito:=True;
            if selSG101.FieldByName('INABILE_ANF').AsString = 'S' then
              FigliMinInabili:=FigliMinInabili + 1;
          end
        else if selSG101.FieldByName('INABILE_ANF').AsString = 'S' then
          begin
            //Maggiorenne inabile
            FigliMagInabili:=FigliMagInabili + 1;
            SommaReddito:=True;
          end;
      end
      else if (selSG101.FieldByName('GRADOPAR').AsString = 'FR') or (selSG101.FieldByName('GRADOPAR').AsString = 'NP') then
      begin
        //Fratello, sorella o nipote
        if selSG101.FieldByName('INABILE_ANF').AsString = 'S' then
          begin
            //Inabile
            FratSorNip:=FratSorNip + 1;
            FratSorNipInabili:=FratSorNipInabili + 1;
            if selSG101.FieldByName('MESI_NASCITA').AsInteger >= 217 then
              NumComponentiNoFigliMag:=NumComponentiNoFigliMag + 1;
            SommaReddito:=True;
          end
        else if selSG101.FieldByName('MESI_NASCITA').AsInteger < 217 then
          begin
            //Minorenne
            FratSorNip:=FratSorNip + 1;
            SommaReddito:=True;
          end
      end;
      if SommaReddito then
      begin
        RedditoLavDip:=RedditoLavDip + selSG101.FieldByName('REDDITO_ANF').AsFloat;
        RedditoAltro:=RedditoAltro + selSG101.FieldByName('REDDITO_ALTRO_ANF').AsFloat;
      end;
      selSG101.Next;
    end;
  end;
  if (DataCalcolo >= DataDecAssUnicoFigli2022) and (DatiOut.FigliMin + DatiOut.FigliMagInabili > 0) then
  begin
    DatiOut.Blocca:='Presenza di figli all''interno del nucleo familiare successivamente al ' + FormatDateTime('dd/mm/yyyy',DataDecAssUnicoFigli2022);
    DatiOut.Messaggio:=DatiOut.Blocca;
    Result:=DatiOut;
    exit;
  end;
  if DatiOut.RedditoLavDip / (DatiOut.RedditoLavDip + DatiOut.RedditoAltro) < 0.7 then
  begin
    //Reddito da lavoro dipendente inferiore al 70% del complessivo
    DatiOut.Messaggio:='Assegno non spettante poichè reddito da lavoro dipendente inferiore al 70% del complessivo';
    Result:=DatiOut;
    exit;
  end;
  with DatiOut do
  begin
    //Numero componenti del nucleo familiare
    NumComponenti:=1 + Coniuge + FigliMin + FigliMagInabili + FratSorNip;
    //Numero componenti inabili del nucleo familiare
    NumComponentiInabili:=RichiedenteInabile + ConiugeInabile + FigliMinInabili + FigliMagInabili + FratSorNipInabili;
    //Numero componenti maggiorenni del nucleo familiare escludendo i figli
    NumComponentiNoFigliMag:=1 + Coniuge + NumComponentiNoFigliMag;
    if selP430.FieldByName('COD_TABELLAANF').AsString <> ''  then
      //Tabella da anagrafica stipendiale
      CodTabella:=selP430.FieldByName('COD_TABELLAANF').AsString
    else
    begin
      //Calcolo tabella in base al nucleo familiare
      if (DataCalcolo >= DataDecAssUnicoFigli2022) and
         (NumComponentiInabili = NumComponenti) and
         (NumComponentiInabili = NumComponentiNoFigliMag) then
        CodTabella:='19'
      else if Coniuge > 0 then
        if FigliMin > 0 then
          if NumComponentiInabili > 0 then
            //Presenti coniuge, figli minori e inabili
            CodTabella:='14'
          else
            //Presente coniuge, figli minori e assenti inabili
            CodTabella:='11'
        else if FigliMagInabili > 0 then
            //Presente coniuge, assenti figli minori e presenti figli maggiorenni inabili
            if R180Anno(DataCalcolo) < 2008 then
              CodTabella:='17'
            else
              CodTabella:='14'
        else if FratSorNipInabili > 0 then
            //Presente coniuge, assenti figli e presenti fratelli, sorelle o nipoti inabili
            CodTabella:='20A'
        else if (RichiedenteInabile + ConiugeInabile) > 0 then
            //Presente coniuge, assenti figli e presenti richiedente o coniuge inabili
            CodTabella:='21C'
        else
            //Presente coniuge, assenti figli e inabili
            CodTabella:='21A'
      else
        if FigliMin > 0 then
          if NumComponentiInabili > 0 then
            //Assente coniuge, presenti figli minori e inabili
            CodTabella:='15'
          else
            //Assente coniuge, presenti figli minori e assenti inabili
            CodTabella:='12'
        else if FigliMagInabili > 0 then
            //Assente coniuge e figli minori e presenti figli maggiorenni inabili
            if R180Anno(DataCalcolo) < 2008 then
              CodTabella:='18'
            else
              CodTabella:='15'
        else if FratSorNipInabili > 0 then
            //Assente coniuge e figli e presenti fratelli, sorelle o nipoti inabili
            CodTabella:='20B'
        else if RichiedenteInabile > 0 then
            //Assente coniuge e figli e presente richiedente inabile
            CodTabella:='21D'
        else
            //Assente coniuge, figli e inabili
            CodTabella:='21B';
    end;
    //Lettura importo dell'assegno
    selP238.SetVariable('Decorrenza',DataCalcolo);
    selP238.SetVariable('CodTabellaANF',CodTabella);
    selP238.SetVariable('Reddito',(RedditoLavDip + RedditoAltro));
    if NumComponenti <= 6 then
      selP238.SetVariable('NumComponenti',NumComponenti)
    else if CodTabella = '12' then
      selP238.SetVariable('NumComponenti',6)
    else
      selP238.SetVariable('NumComponenti',7);
    selP238.Close;
    selP238.Open;
    if not selP238.Eof then
    begin
      DescTabella:=selP238.FieldByName('DESCRIZIONE').AsString;
      Importo:=selP238.FieldByName('IMPORTO').AsFloat;
    end;
    if Importo > 0 then
    begin
      //Eventuali maggiorazioni per nuclei familiari con componenti oltre la soglia massima
      if CodTabella = '11' then
        Importo:=MaggNucleiOltreMax(Importo,15,55,NumComponenti,7)
      else if CodTabella = '12' then
        Importo:=MaggNucleiOltreMax(Importo,15,55,NumComponenti,6);
      //Eventuali riduzioni per nuclei familiari con fratelli, sorelle o nipoti
      if (CodTabella = '11') or (CodTabella = '12') then
        Importo:=RiduzFratSorNip(Importo,10.42,54.17,DatiOut);
      if R180Anno(DataCalcolo) < 2008 then
      begin
        //Eventuali maggiorazioni per nuclei familiari con componenti oltre la soglia massima
        if (CodTabella = '13') or (CodTabella = '14') or (CodTabella = '15') or (CodTabella = '16') or
                (CodTabella = '17') or (CodTabella = '18') or (CodTabella = '19') then
          Importo:=MaggNucleiOltreMax(Importo,10,61.77,NumComponenti,7);
        //Eventuali riduzioni per nuclei familiari con fratelli, sorelle o nipoti
        if (CodTabella = '14') or (CodTabella = '15') or
                (CodTabella = '17') or (CodTabella = '18') then
          Importo:=RiduzFratSorNip(Importo,11.88,61.77,DatiOut);
      end
      else
      begin
        //Eventuali maggiorazioni per nuclei familiari con componenti oltre la soglia massima
        if (CodTabella = '13') or (CodTabella = '16') or (CodTabella = '19') then
          Importo:=MaggNucleiOltreMax(Importo,10,67.95,NumComponenti,7)
        else if (CodTabella = '14') or (CodTabella = '15') then
          Importo:=MaggNucleiOltreMax(Importo,15,62.50,NumComponenti,7);
        //Eventuali riduzioni per nuclei familiari con fratelli, sorelle o nipoti
        if (CodTabella = '14') or (CodTabella = '15') then
          Importo:=RiduzFratSorNip(Importo,11.00,60.83,DatiOut);
      end;
      if Importo <= 0 then
        Importo:=0;
      if Importo > 0 then
        if ((R180Anno(DataCalcolo) = 2021) and (R180Mese(DataCalcolo) >= 7)) or
           ((R180Anno(DataCalcolo) = 2022) and (R180Mese(DataCalcolo) <= 2)) then
          //Eventuali maggiorazioni figli secondo semestre 2021 e primo bimestre 2022
          if (FigliMin + FigliMagInabili) <= 2 then
            Importo:=Importo + (FigliMin + FigliMagInabili) * 37.5
          else
            Importo:=Importo + (FigliMin + FigliMagInabili) * 55;
    end;
  end;
  Result:=DatiOut;
end;

function TP239FANFDtM.MaggNucleiOltreMax(Importo,PercMagg,CompMagg:Real; NumComp,NumCompMax:Integer):Real;
//Eventuali maggiorazioni per nuclei familiari con componenti oltre la soglia massima
begin
  if NumComp <= NumCompMax then
    Result:=Importo
  else
  begin
    Importo:=Importo * (1 + (NumComp - NumCompMax) * PercMagg / 100);
    Importo:=Importo + (NumComp - NumCompMax) * CompMagg;
    Result:=R180Arrotonda(Importo,0.01,'P');
  end;
end;

function TP239FANFDtM.RiduzFratSorNip(Importo,Riduz1,Riduz2:Real; DatiNucleo:P239UANFDtM.TDatiOutP239):Real;
//Eventuali riduzioni per nuclei familiari con fratelli, sorelle o nipoti
begin
  with DatiNucleo do
  begin
    if FratSorNip = 0 then
      Result:=Importo
    else if (FigliMin + FigliMagInabili) = 1 then
      Result:=Importo - Riduz1 - (FratSorNip - 1) * Riduz2
    else
      Result:=Importo - FratSorNip * Riduz2;
  end;
end;

end.
