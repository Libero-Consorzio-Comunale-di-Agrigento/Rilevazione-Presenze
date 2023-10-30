unit A058UTabellone;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, Qrctrls, ExtCtrls, C180FunzioniGenerali, Printers, Variants, Math,
  StdCtrls, ComCtrls, QRExport, A000UInterfaccia, C700USelezioneAnagrafe,
  QRWebFilt, QRPDFFilt, USelI010, Generics.Collections, OracleData, StrUtils,
  A058UPianifTurniDtM1, QRPrntr;

type
  TA058FTabellone = class(TForm)
    QRep: TQuickRep;
    bndTitolo: TQRBand;
    bndSquadra: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRTitolo: TQRLabel;
    QRData: TQRLabel;
    bndGruppo: TQRGroup;
    bndDettaglio: TQRBand;
    bndTotLiquidabile: TQRBand;
    bndAssenze: TQRChildBand;
    QRMatricola: TQRDBText;
    QRNome: TQRDBText;
    QROp: TQRDBText;
    bndOrari: TQRChildBand;
    bndFirme: TQRChildBand;
    QRNota: TQRLabel;
    QRDesc1: TQRLabel;
    QRDesc2: TQRLabel;
    QRMAssenze: TQRMemo;
    QRLAssenze: TQRLabel;
    QRLOrari: TQRLabel;
    QRMOrari: TQRMemo;
    bndTotTurni: TQRChildBand;
    QRLTurniTotali: TQRLabel;
    QRLMinMax: TQRLabel;
    QrLblDebito: TQRLabel;
    QRLblAssegnato: TQRLabel;
    QRLblScostamento: TQRLabel;
    QRLblSituazione: TQRLabel;
    QrLblTotTurno1: TQRLabel;
    QrLblTotTurno2: TQRLabel;
    QRLblTemp: TQRLabel;
    bndGiorni: TQRChildBand;
    QRLMatricola: TQRLabel;
    QRLNome: TQRLabel;
    QRLOp: TQRLabel;
    LblAssegnato: TQRLabel;
    LblDebito: TQRLabel;
    LblScostamento: TQRLabel;
    QrTotale: TQRLabel;
    QrTurno: TQRLabel;
    QRSquadra: TQRDBText;
    QRDSquadra: TQRDBText;
    QRTextFilter1: TQRTextFilter;
    QRRTFFilter1: TQRRTFFilter;
    QRPDFFilter1: TQRPDFFilter;
    QRHTMLFilter1: TQRHTMLFilter;
    QRExcelFilter1: TQRExcelFilter;
    bndTotOrario: TQRChildBand;
    QRLTotali: TQRLabel;
    QRMTotali: TQRMemo;
    qlblTotLiquid: TQRLabel;
    bndTotGenerali: TQRChildBand;
    qrLblTotGen: TQRLabel;
    QrLblDatoLibero: TQRLabel;
    QRLTotaliTurno: TQRLabel;
    QRLTotaliPagina: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure QRepBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure bndTitoloBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure bndGiorniBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure bndGruppoBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure bndDettaglioBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure MyInfoTimbOnPrint(Sender: TObject;var Value: string);
    procedure bndDettaglioAfterPrint(Sender: TQRCustomBand; BandPrinted: Boolean);
    procedure bndTotLiquidabileBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure bndTotOrarioBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure bndTotTurniBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure bndTotGeneraliBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure bndOrariBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure bndAssenzeBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
  private
    { Private declarations }
    nLeftIniGiorni:Integer;
    LstLabelTotOperatori:TObjectList<TQRLabel>;
    DataInizioPrec:TDateTime;
    procedure InizializzaStampa;
    function HC:Integer;
    procedure TurniXXOnPrint(sender: TObject;var Value: string);
    procedure CreaDataIntestazione;
    procedure ScriviSaldiOre;
    procedure ScriviTotaliDipendente(NDip:Integer);
    procedure ScriviOrariEAssenze;
    procedure PutOrario(Ora:String);
    procedure PutAssenza(Ass:String);
  public
    { Public declarations }
    LAssenze,LOrari:TStringList;
    SaveDettaglioHeight:Integer;
    procedure DistruggiOggetti99(inComp:TComponent);
  end;

var
  A058FTabellone: TA058FTabellone;

implementation

uses A058UPianifTurni;

{$R *.DFM}

procedure TA058FTabellone.FormCreate(Sender: TObject);
begin
  QRep.useQR5Justification:=True;
  LAssenze:=TStringList.Create;
  LOrari:=TStringList.Create;
end;

procedure TA058FTabellone.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Self.Destroy;
end;

procedure TA058FTabellone.FormDestroy(Sender: TObject);
begin
  FreeAndNil(LAssenze);
  FreeAndNil(LOrari);
  if LstLabelTotOperatori <> nil then
    FreeAndNil(lstLabelTotOperatori);
end;

procedure TA058FTabellone.DistruggiOggetti99(InComp:TComponent);
var i:Integer;
begin
  for i:=Self.ComponentCount - 1 downto 0 do
    if Self.Components[i].Tag = 99 then
      if (Self.Components[i] is TQRShape)
      or (Self.Components[i] is TQRLabel)
      or (Self.Components[i] is TQRDBText) then
        if (InComp = nil) or (TQRShape(Self.Components[i]).Parent = InComp) then
          Self.Components[i].Free;
end;

procedure TA058FTabellone.QRepBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  DataInizioPrec:=0;
  if A058FPianifTurniDtM1.T058Stampa.RecordCount > 0 then
    InizializzaStampa;
end;

procedure TA058FTabellone.InizializzaStampa;
{Proporziono il carattere e le dimensioni dei componenti in base alla larghezza
 della pagina e al numero di giorni da stampare}
var
  S,LC,LCS,PosCampo,iSgOp,
  nGG,L,i:Integer;
  sCodGG:String;
begin
  with A058FPianifTurniDtm1 do
  begin
    //Assegnazione del font size
    S:=selT082.FieldByName('DIMENSIONE_FONT').AsInteger;
    if (QRep.qrprinter.destination = qrdPrinter) or QRep.Exporting then
      S:=S - 1;
    bndSquadra.Font.Size:=S + 2;
    bndGiorni.Font.Size:=S;
    bndDettaglio.Font.Size:=S;
    bndTotLiquidabile.Font.Size:=S;
    bndTotOrario.Font.Size:=S;
    bndTotTurni.Font.Size:=S;
    bndTotGenerali.Font.Size:=S;
    bndOrari.Font.Size:=S;
    bndAssenze.Font.Size:=S;
    bndFirme.Font.Size:=S;

    //Inizializzazioni
    T058Stampa.First;
    QRep.Page.LeftMargin:=selT082.FieldByName('MARGINE_SX').AsInteger;
    LC:=QRep.TextWidth(bndDettaglio.Font,' ') - 1; //Lunghezza carattere ridotta di un punto
    LCS:=QRep.TextWidth(QRSquadra.Font,' ') - 1; //Lunghezza carattere ridotta di un punto

    //Intestazione e Gruppo SQUADRA
    QRSquadra.Height:=(S + 2) * 2 - 1;
    QRSquadra.Width:=LCS * 15;  //Lung. Cod.Squadra
    QRDSquadra.Height:=QRSquadra.Height;
    QRDSquadra.Left:=QRSquadra.Left + QRSquadra.Width + 3;
    bndSquadra.Height:=QRSquadra.Top + QRSquadra.Height + 2;
    bndGruppo.Height:=0;

    //Intestazione Giorni
    bndGiorni.Height:=(HC * 2) + 3;
    if selT082.FieldByName('COMPATTA_RIGHE_DIP').AsString = 'N' then
      bndGiorni.Height:=bndGiorni.Height + HC;

    //Intestazione dato libero del dipendente
    with TSelI010.create(Self) do
      try
        Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO',
             'NOME_CAMPO = ''' + selT082.FieldByName('DATO_ANAGRAFICO').AsString + '''',
             'NOME_LOGICO');
        qrlblDatoLibero.Caption:=FieldByName('NOME_LOGICO').AsString;
      finally
        Free;
      end;
    qrlblDatoLibero.Left:=0;
    qrlblDatoLibero.Top:=1;
    qrlblDatoLibero.Font:=bndGiorni.Font;
    qrlblDatoLibero.Font.Size:=bndGiorni.Font.Size;

    //Separatore righe Dettaglio
    bndDettaglio.Frame.DrawBottom:=selT082.FieldByName('SEPARATORE_RIGHE').AsString = 'S';

    //Altezza Dettaglio...
    bndDettaglio.Height:=(HC * IfThen(selT082.FieldByName('COMPATTA_RIGHE_DIP').AsString = 'S',2,3)) + 1;
    //...con riga Reperibilità
    if selT082.FieldByName('REPERIBILITA').AsString = 'S' then
      bndDettaglio.Height:=bndDettaglio.Height + HC;

    //Dettaglio Matricola
    QRMatricola.Height:=HC;
    QRMatricola.Width:=LC * 8;
    //Intestazione Matricola
    QRLMatricola.Height:=HC;
    QRLMatricola.Left:=QRMatricola.Left;
    PosCampo:=Max(QRMatricola.Left + QRMatricola.Width,QRLMatricola.Left + QRLMatricola.Width);

    //Dettaglio Nome
    if (selT082.FieldByName('COMPATTA_RIGHE_DIP').AsString = 'S') or (selT082.FieldByName('RIGHE_NOME').AsString = 'N') then
      QRNome.Width:=LC * 25
    else
      QRNome.Width:=LC * 15;
    QRNome.Top:=QRMatricola.Top + QRMatricola.Height - 1;
    QRNome.Height:=bndDettaglio.Height - QrNome.Top;
    //Intestazione Nome
    QRLNome.Height:=HC;
    QRLNome.Left:=QRNome.Left;
    QRLNome.Top:=QRLMatricola.Top + QRLMatricola.Height - 1;

    //Dettaglio Operatore
    QROp.Height:=HC;
    QROp.Top:=QRMatricola.Top;
    QROp.Left:=PosCampo + (LC * 2);
    QROp.Width:=LC * 5 + 1;//Lung. 'Oper.'
    PosCampo:=Max(QRNome.Left + QRNome.Width,QROp.Left + QROp.Width);
    //Intestazione Operatore
    QRLOp.Height:=HC;
    QRLOp.Left:=QROp.Left;

    //Saldi ore su righe non compresse
    LblDebito.Left:=PosCampo; //mi serve impostarlo anche se not Enabled perché punto di riferimento per il posizionamento di altri campi
    //LblDebito.Width:=0;
    LblDebito.Enabled:=(selT082.FieldByName('SALDI_ORE').AsString = 'S') and (selT082.FieldByName('COMPATTA_RIGHE_DIP').AsString = 'N');
    LblAssegnato.Enabled:=LblDebito.Enabled;
    LblScostamento.Enabled:=LblDebito.Enabled;
    QRLblDebito.Enabled:=LblDebito.Enabled;
    QRLblAssegnato.Enabled:=LblDebito.Enabled;
    QRLblScostamento.Enabled:=LblDebito.Enabled;
    if LblDebito.Enabled then
    begin
      //Intestazione saldi ore
      LblDebito.Height:=HC;
      LblDebito.Left:=PosCampo + (LC * 2);
      PosCampo:=LblDebito.Left + LblDebito.Width;
      LblAssegnato.Height:=HC;
      LblAssegnato.Left:=LblDebito.Left;
      LblAssegnato.Top:=LblDebito.Top + HC - 1;
      LblScostamento.Height:=HC;
      LblScostamento.Left:=LblAssegnato.Left;
      LblScostamento.Top:=LblAssegnato.Top + HC - 1;
      //Dettaglio saldi ore
      QRLblDebito.Height:=HC;
      QRLblDebito.Left:=LblDebito.Left + Trunc((LblDebito.Width - QRLblDebito.Width) / 2) + 1;
      QRLblDebito.Width:=LC * 6 + 1;
      QRLblAssegnato.Height:=HC;
      QRLblAssegnato.Left:=QRLblDebito.Left;
      QRLblAssegnato.Top:=LblAssegnato.Top;
      QRLblAssegnato.Width:=LC * 6 + 1;
      QRLblScostamento.Height:=HC;
      QRLblScostamento.Left:=QRLblDebito.Left;
      QRLblScostamento.Top:=LblScostamento.Top;
      QRLblScostamento.Width:=LC * 6 + 1;
    end;

    //Dettaglio Turni nel mese e Saldi ore su righe compresse
    QRLblTotTurno1.Left:=PosCampo; //mi serve impostarlo anche se not Enabled perché punto di riferimento per il posizionamento di altri campi
    QRLblTotTurno2.Left:=QRLblTotTurno1.Left;
    QRLblTotTurno1.Height:=HC;
    QRLblTotTurno2.Height:=QRLblTotTurno1.Height;
    QRLblTotTurno2.Top:=QRLblTotTurno1.Top + QRLblTotTurno1.Height - 1;
    QRLblTotTurno2.Width:=0;
    QRLblTotTurno2.Width:=QRLblTotTurno1.Width;
    QrLblTotTurno1.Enabled:=(selT082.FieldByName('COMPATTA_RIGHE_DIP').AsString = 'S') and (selT082.FieldByName('TOT_TURNI_MESE').AsString = 'S');
    QrLblTotTurno2.Enabled:=(selT082.FieldByName('COMPATTA_RIGHE_DIP').AsString = 'S') and (selT082.FieldByName('SALDI_ORE').AsString = 'S');
    if (selT082.FieldByName('TOT_TURNI_MESE').AsString = 'S') or QrLblTotTurno2.Enabled then
    begin
      QRLblTotTurno1.Left:=QRLblTotTurno1.Left + (LC * 2);
      QRLblTotTurno2.Left:=QRLblTotTurno1.Left;
    end;
    //Intestazione Turni nel mese e Saldi ore su righe compresse
    QRTotale.Enabled:=selT082.FieldByName('TOT_TURNI_MESE').AsString = 'S';
    QRTotale.Height:=HC;
    QRTotale.Left:=QRLblTotTurno1.Left;
    QRTotale.Caption:='';
    if selT082.FieldByName('TOT_TURNI_MESE').AsString = 'S' then
    begin
      if selT082.FieldByName('COMPATTA_RIGHE_DIP').AsString = 'S' then
        QRTotale.Left:=QRTotale.Left - LC * 5(*Tot. *) + 1 //Arretro dei primi 5 caratteri
      else
        QRTotale.Caption:='Totale';
    end;
    QRTurno.Enabled:=((selT082.FieldByName('COMPATTA_RIGHE_DIP').AsString = 'N') and (selT082.FieldByName('TOT_TURNI_MESE').AsString = 'S')) or
                     ((selT082.FieldByName('COMPATTA_RIGHE_DIP').AsString = 'S') and (selT082.FieldByName('SALDI_ORE').AsString = 'S'));
    QRTurno.Height:=HC;
    QRTurno.Left:=QRLblTotTurno1.Left;
    QRTurno.Top:=QRTotale.Top + QRTotale.Height - 1;
    QRTurno.Caption:='';
    if (selT082.FieldByName('COMPATTA_RIGHE_DIP').AsString = 'S') and (selT082.FieldByName('SALDI_ORE').AsString = 'S') then
      QRTurno.Caption:='Debito \ Asseg.'
    else if (selT082.FieldByName('COMPATTA_RIGHE_DIP').AsString = 'N') and (selT082.FieldByName('TOT_TURNI_MESE').AsString = 'S') then
      QrTurno.Caption:='turni';

    (*obsoleto
    //bndTotOrario
    QRLTotali.Height:=HC;
    QRLTotali.Width:=LC * 6;   //'Totali'
    QRMTotali.Height:=HC;
    QRMTotali.Left:=QRLblTotTurno1.Left + QRLblTotTurno1.Width + (LC * 2) - (LC * 9);
    bndTotOrario.Height:=QRLTotali.Top + QRLTotali.Height + 2;*)

    //bndOrari
    QRLOrari.Height:=HC;
    QRLOrari.Width:=LC * 9;   //Lung. 'Assenze: '
    QRMOrari.Height:=HC;
    QRMOrari.Left:=QRLOrari.Width + 1;
    bndOrari.Height:=QRLOrari.Top + QRLOrari.Height + 2;

    //bndAssenze
    QRLAssenze.Height:=HC;
    QRLAssenze.Width:=LC * 9;   //Lung. 'Assenze: '
    QRMAssenze.Height:=HC;
    QRMAssenze.Left:=QRLOrari.Width + 1;
    bndAssenze.Height:=QRLAssenze.Top + QRLAssenze.Height + 2;
  end;
end;

function TA058FTabellone.HC:Integer;
var S:integer;
begin
  S:=A058FPianifTurniDtM1.selT082.FieldByName('DIMENSIONE_FONT').AsInteger;
  if (QRep.qrprinter.destination = qrdPrinter) or QRep.Exporting then
    S:=S - 1;
  //Limito la dimensione entro valori accettabili
  if S > 9 then
  begin
    S:=9;
  end;
  if S < 6 then
  begin
    S:=6;
  end;
  //Altezza di una riga
  Result:=S * 2 - 1;
end;

procedure TA058FTabellone.TurniXXOnPrint(Sender: TObject; var Value: string);
var idx:Integer;
begin
  with TQRDBText(Sender) do
  begin
    Font.Color:=clBlack;
    Font.Style:=[];
    idx:=StrToIntDef(DataField.Replace('TURNI','',[rfIgnoreCase]),-1);
    if (idx >= 0) and (DataSet.FieldByName('Antincendio' + idx.ToString).AsString = 'S') then
    begin
      Font.Color:=clWebOrangeRed;
      Font.Style:=[fsBold];
    end;
  end;
end;

procedure TA058FTabellone.bndTitoloBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  QRData.Caption:='dal ' + A058FPianifTurniDtM1.T058Stampa.FieldByName('DataInizio').AsString + ' al ' + A058FPianifTurniDtM1.T058Stampa.FieldByName('DataFine').AsString;
  QRLblSituazione.Caption:='';
  if A058FPianifTurniDtM1.selT082.FieldByName('TIPO_STAMPA').AsString = 'C' then
    QRLblSituazione.Caption:='(situazione consuntiva)'
  else
  begin
    if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
    begin
      if A058FPianifTurniDtm1.selT082.FieldByName('MODALITA_LAVORO').AsString = 'S' then
        QRLblSituazione.Caption:='(pianificazione operativa)'
      else
      begin
        if A058FPianifTurni.RgpTipo.ItemIndex = 0 then
          QRLblSituazione.Caption:='(pianificazione non operativa iniziale)'
        else
          QRLblSituazione.Caption:='(pianificazione non operativa corrente)'
      end;
    end;
  end;
end;

procedure TA058FTabellone.bndGiorniBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var LC,iSgOp,nSgOp:Integer;
    sCodGG:String;
    i,nGG:Integer;
    nLeft,L:Real;
    xQRShape:TQRShape;
    LblGiorni1,LblGiorni2:TQRLabel;
    LDettaglio,LTotLiquid,LTotTurni:Integer;
begin
  //Aggiorno le misure LC
  nLeft:=0;
  LC:=QRep.TextWidth(bndDettaglio.Font,' ') - 1; //Lunghezza carattere ridotta di un punto
  with A058FPianifTurniDtm1 do
  begin
    L:=QRep.TextWidth(bndDettaglio.Font,R180Spaces('',selT082.FieldByName('GG_PAGINA').AsInteger * LungCella)) div selT082.FieldByName('GG_PAGINA').AsInteger;

    if T058Stampa.FieldByName('DataInizio').AsDateTime <> DataInizioPrec then
    begin
      //Aggiorno i totali giornalieri della pagina in stampa
      AggiornaTotPagGio(Trunc(T058Stampa.FieldByName('DataInizio').AsDateTime - DataInizio),Trunc(T058Stampa.FieldByName('DataFine').AsDateTime - T058Stampa.FieldByName('DataInizio').AsDateTime));
      nSgOp:=0;
      if selT082.FieldByName('TOT_TURNI_MESE').AsString = 'S' then
        if selT082.FieldByName('COMPATTA_RIGHE_DIP').AsString = 'S' then
        begin
          QrTotale.Caption:='Tot. ';
          for iSgOp:=Low(TotPagGio) to High(TotPagGio) do
            if not TotPagGio[iSgOp].TotaleOperatore then
            begin
              QrTotale.Caption:=QrTotale.Caption + Format('%-4s',[TotPagGio[iSgOp].Sigla + GetSimboloOperatore(TotPagGio[iSgOp].Operatore,TotPagGio[iSgOp].Sigla,TotPagGio)]);
              inc(nSgOp);
            end;
        end;

      //Lunghezza dati fissi di Dettaglio
      QRLblTotTurno1.Width:=LC * IfThen(selT082.FieldByName('COMPATTA_RIGHE_DIP').AsString = 'S',
                                        IfThen(selT082.FieldByName('TOT_TURNI_MESE').AsString = 'S',
                                               Max(nSgOp * 4 - 1, (*elenco quantità per ogni sigla in QRLblTotTurno1*)
                                                   IfThen(selT082.FieldByName('SALDI_ORE').AsString = 'S',
                                                          15, (*debito / asseg. in QRLblTotTurno2*)
                                                          0)), (*solo totali, no saldi*)
                                               IfThen(selT082.FieldByName('SALDI_ORE').AsString = 'S',
                                                      15, (*debito / asseg. in QRLblTotTurno2*)
                                                      0)), (*né totali né saldi*)
                                        IfThen(selT082.FieldByName('TOT_TURNI_MESE').AsString = 'S',
                                               7, (*sigla,simbolo e quantità*)
                                               0) (*no totali, altro non interessa*)
                                        ) + 1;
      QRLblTotTurno2.Width:=QRLblTotTurno1.Width;
      LDettaglio:=QrLblTotTurno1.Left + QrLblTotTurno1.Width;

      //Lunghezza dati fissi di bndTotLiquidabile
      LTotLiquid:=0;
      if selT082.FieldByName('TOT_LIQUIDABILE').AsString = 'S' then
        LTotLiquid:=qlblTotLiquid.Left + qlblTotLiquid.Width;

      //Lunghezza dati fissi di bndTotTurni
      LTotTurni:=0;
      if selT082.FieldByName('TOT_TURNO').AsString = 'S' then
      begin
        //Recupero i diversi tipi giorno per i massimi e i minimi
        sCodGG:='';
        R180SetVariable(selT606a,'PROGRESSIVO',-1); //Non individuale
        R180SetVariable(selT606a,'COD_SQUADRA',SquadraRiferimento);
        R180SetVariable(selT606a,'COD_ORARIO','*'); //Tutti gli orari
        R180SetVariable(selT606a,'COD_CONDIZIONE','00001'); //Numero teste
        if (not selT606a.Active) or (not R180Between(T058Stampa.FieldByName('DataFine').AsDateTime,selT606a.FieldByName('DECORRENZA').AsDateTime,selT606a.FieldByName('DECORRENZA_FINE').AsDateTime)) then
          R180SetVariable(selT606a,'DATA',T058Stampa.FieldByName('DataFine').AsDateTime);
        selT606a.Open;
        selT606a.First;
        while not selT606a.Eof do
        begin
          if Pos(selT606a.FieldByName('COD_GIORNO').AsString,sCodGG) = 0 then
            sCodGG:=sCodGG + selT606a.FieldByName('COD_GIORNO').AsString;
          selT606a.Next;
        end;
        LTotTurni:=QRLTurniTotali.Left + LC * (5(*operatore*) + 1(*spazio*) + 2(*sigla*) + 1(*simbolo*) + 2(*spazio*) + 4(*totale*) + 2(*spazio*) + Max(Length(sCodGG),1)(*n. giorni*) * 5(*car. min-max*));
      end;

      //Posizione iniziale della griglia coi giorni
      nLeftIniGiorni:=Max(Max(LDettaglio,LTotLiquid),LTotTurni) + LC * 2 - 1;

      DistruggiOggetti99(bndGiorni);
      for nGG:=0 to Min(selT082.FieldByName('GG_PAGINA').AsInteger - 1,Trunc(T058Stampa.FieldByName('DataFine').AsDateTime - T058Stampa.FieldByName('DataInizio').AsDateTime)) do
      begin
        if nLeft = 0 then
          nLeft:=nLeftIniGiorni
        else
          nLeft:=nLeft + L;

        //Separatore colonne a sinistra
        if selT082.FieldByName('SEPARATORE_COL').AsString = 'S' then
        begin
          //Separatore colonne di intestazione
          xQRShape:=TQRShape(bndGiorni.AddPrintable(TQRShape));
          xQRShape.Tag:=99;
          xQRShape.QRPrinter:=QRep.QRPrinter;//necessario per TQRShape creati dopo il QRepBeforePrint, altrimenti va in errore
          xQRShape.Parent:=bndGiorni;
          xQRShape.Shape:=qrsVertLine;
          xQRShape.Top:=0;
          xQRShape.Height:=bndGiorni.Height;
          xQRShape.Width:=1;
          xQRShape.Left:=Trunc(nLeft);
        end;

        //Intestazione del giorno
        LblGiorni1:=TQRLabel(bndGiorni.AddPrintable(TQRLabel));
        LblGiorni1.Tag:=99;
        LblGiorni1.Parent:=bndGiorni;
        LblGiorni1.ParentFont:=True;
        LblGiorni1.Font:=bndGiorni.Font;
        LblGiorni1.Font.Size:=bndGiorni.Font.Size;
        LblGiorni1.Left:=Trunc(nLeft + 2);
        LblGiorni1.Top:=1;
        LblGiorni1.Caption:=' ';
        LblGiorni1.Name:='lblDD' + IntToStr(nGG);

        LblGiorni2:=TQRLabel(bndGiorni.AddPrintable(TQRLabel));
        LblGiorni2.Tag:=99;
        LblGiorni2.Parent:=bndGiorni;
        LblGiorni2.ParentFont:=True;
        LblGiorni2.Font:=bndGiorni.Font;
        LblGiorni2.Font.Size:=bndGiorni.Font.Size;
        LblGiorni2.Left:=Trunc(nLeft + 2);
        LblGiorni2.Top:=LblGiorni1.Top + LblGiorni1.Height;
        LblGiorni2.Name:='lblGG' + IntToStr(nGG);
      end;

      //Sistemo l'intestazione del giorno
      CreaDataIntestazione;

      //Separatore colonne finali a destra
      if selT082.FieldByName('SEPARATORE_COL').AsString = 'S' then
      begin
        //Separatore colonne di intestazione
        xQRShape:=TQRShape(bndGiorni.AddPrintable(TQRShape));
        xQRShape.Tag:=99;
        xQRShape.QRPrinter:=QRep.QRPrinter;//necessario per TQRShape creati dopo il QRepBeforePrint, altrimenti va in errore
        xQRShape.Parent:=bndGiorni;
        xQRShape.Shape:=qrsVertLine;
        xQRShape.Height:=bndGiorni.Height;
        xQRShape.Width:=1;
        xQRShape.Left:=Trunc(nLeft + L);
      end;

      //Titolo dato libero
      qrlblDatoLibero.Left:=Trunc(nLeft + L + 3);
    end;
    DataInizioPrec:=T058Stampa.FieldByName('DataInizio').AsDateTime;
  end;

  //Porto in primo piano le linee per non farle rimanere sotto le etichette
  for i:=A058FTabellone.ComponentCount - 1 downto 0 do
    if A058FTabellone.Components[i] is TQRShape then
      if TQRShape(A058FTabellone.Components[i]).Parent = bndGiorni then
        TQRShape(A058FTabellone.Components[i]).BringToFront;
end;

procedure TA058FTabellone.CreaDataIntestazione;
{Genero l'intestazione dei giorni}
const
  Giorni:Array[1..7] of String = ('Do','Lu','Ma','Me','Gi','Ve','Sa');
var
  DataCorr:TDateTime;
  i:Integer;
begin
  for i:=0 to bndGiorni.ControlCount - 1 do
    if (bndGiorni.Controls[i].Tag = 99) and (bndGiorni.Controls[i] is TQRLabel) then
    begin
      (bndGiorni.Controls[i] as TQRLabel).Caption:='';
      DataCorr:=A058FPianifTurniDtM1.T058Stampa.FieldByName('DataInizio').AsDateTime +
                StrToIntDef(Copy((bndGiorni.Controls[i] as TQRLabel).Name,6,3),-1);
      if (DataCorr >= A058FPianifTurniDtM1.T058Stampa.FieldByName('DataInizio').AsDateTime) and
         (DataCorr <= A058FPianifTurniDtM1.T058Stampa.FieldByName('DataFine').AsDateTime) then
      begin
        if Copy((bndGiorni.Controls[i] as TQRLabel).Name,1,5) = 'lblDD' then
          (bndGiorni.Controls[i] as TQRLabel).Caption:=R180DimLung(FormatDateTime('dd',DataCorr),A058FPianifTurniDtm1.LungCella)
        else
          (bndGiorni.Controls[i] as TQRLabel).Caption:=Format('%-' + inttostr(A058FPianifTurniDtm1.LungCella) + 's',[Giorni[DayOfWeek(DataCorr)]]);
        with A058FPianifTurniDtm1.GetCalend, A058FPianifTurni do
        begin
          SetVariable('PROG',A058FPianifTurniDtM1.T058Stampa.FieldByName('Progressivo').AsInteger);
          SetVariable('D',DataCorr);
          Execute;
          if (VarToStr(GetVariable('F')) = 'S') or (DayOfWeek(DataCorr) = 1) then
          begin
            (bndGiorni.Controls[i] as TQRLabel).Font.Color:=clRed;
            (bndGiorni.Controls[i] as TQRLabel).Font.Style:=[fsBold,fsItalic];
          end
          else
          begin
            (bndGiorni.Controls[i] as TQRLabel).Font.Color:=clBlack;
            (bndGiorni.Controls[i] as TQRLabel).Font.Style:=[];
          end;
        end;
      end;
    end;
end;

procedure TA058FTabellone.bndGruppoBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var MyStrList:TStringList;
begin
  LAssenze.Clear;
  LOrari.Clear;
  QRMAssenze.Lines.Clear;
  QRMOrari.Lines.Clear;
  MyStrList:=TStringList.Create;
  try
    MyStrList.Assign(A058FTabellone.QRMOrari.Lines);
    MyStrList.Sorted:=False;
    A058FTabellone.QRMOrari.Lines.Assign(MyStrList);
  finally
    FreeAndNil(MyStrList);
  end;
  (*obsoleto
  QRMTotali.Lines.Clear;*)
end;

procedure TA058FTabellone.bndDettaglioBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var TxtOrario,TxtTurno,TxtRepSigla1,TxtNumTimb,TxtDatoLibero:TQRDBText;
    i,nGG:Integer;
    nLeft,L:Real;
    xQRShape:TQRShape;
begin
  DistruggiOggetti99(bndDettaglio);

  //Salvo l'altezza normale della banda
  SaveDettaglioHeight:=bndDettaglio.Height;

  //Aggiorno le misure
  nLeft:=0;
  with A058FPianifTurniDtm1 do
    L:=QRep.TextWidth(bndDettaglio.Font,R180Spaces('',selT082.FieldByName('GG_PAGINA').AsInteger * LungCella)) div selT082.FieldByName('GG_PAGINA').AsInteger;

  for nGG:=0 to Min(A058FPianifTurniDtm1.selT082.FieldByName('GG_PAGINA').AsInteger - 1,Trunc(A058FPianifTurniDtm1.T058Stampa.FieldByName('DataFine').AsDateTime - A058FPianifTurniDtm1.T058Stampa.FieldByName('DataInizio').AsDateTime)) do
  begin
    if nLeft = 0 then
      nLeft:=nLeftIniGiorni
    else
      nLeft:=nLeft + L;

    //Separatore colonne a sinistra
    if A058FPianifTurniDtm1.selT082.FieldByName('SEPARATORE_COL').AsString = 'S' then
    begin
      //Separatore colonne di dettaglio
      xQRShape:=TQRShape(bndDettaglio.AddPrintable(TQRShape));
      xQRShape.Tag:=99;
      xQRShape.QRPrinter:=QRep.QRPrinter;//necessario per TQRShape creati dopo il QRepBeforePrint, altrimenti va in errore
      xQRShape.Parent:=bndDettaglio;
      xQRShape.Shape:=qrsVertLine;
      xQRShape.Top:=0;
      xQRShape.Height:=bndDettaglio.Height;
      xQRShape.Width:=1;
      xQRShape.Left:=Trunc(nLeft);
    end;

    //Dettaglio del giorno
    //Riga Orario
    TxtOrario:=TQRDBText(bndDettaglio.AddPrintable(TQRDBText));
    TxtOrario.Tag:=99;
    TxtOrario.Parent:=bndDettaglio;
    TxtOrario.ParentFont:=True;
    TxtOrario.Font:=bndDettaglio.Font;
    TxtOrario.Font.Size:=bndDettaglio.Font.Size;
    TxtOrario.Left:=Trunc(nLeft + 3);
    TxtOrario.Top:=0;
    TxtOrario.DataSet:=A058FPianifTurniDtM1.T058Stampa;
    TxtOrario.DataField:='Orari' + IntToStr(nGG);
    TxtOrario.Caption:=A058FPianifTurniDtM1.T058Stampa.FieldByName(TxtOrario.DataField).AsString;//Forzo la caption perché altrimenti solo sul primo record non vengono mostrati i valori del record corrente del dataset
    if A058FPianifTurniDtM1.selT082.FieldByName('DETT_STAMPA').AsString = 'D' then
      TxtOrario.AutoSize:=True
    else
    begin
      TxtOrario.AutoSize:=False;
      TxtOrario.Width:=0;
    end;
    //Riga Turni
    TxtTurno:=TQRDBText(bndDettaglio.AddPrintable(TQRDBText));
    TxtTurno.Tag:=99;
    TxtTurno.Parent:=bndDettaglio;
    TxtTurno.ParentFont:=True;
    TxtTurno.Font:=bndDettaglio.Font;
    TxtTurno.Font.Size:=bndDettaglio.Font.Size;
    TxtTurno.Left:=Trunc(nLeft + 3);
    TxtTurno.Top:=TxtOrario.Top + TxtOrario.Height;
    TxtTurno.Height:=bndDettaglio.Height - TxtTurno.Top - IfThen(A058FPianifTurniDtM1.selT082.FieldByName('REPERIBILITA').AsString = 'S',HC);
    TxtTurno.DataSet:=A058FPianifTurniDtM1.T058Stampa;
    TxtTurno.DataField:='Turni' + IntToStr(nGG);
    TxtTurno.Caption:=A058FPianifTurniDtM1.T058Stampa.FieldByName(TxtTurno.DataField).AsString;//Forzo la caption perché altrimenti solo sul primo record non vengono mostrati i valori del record corrente del dataset
    TxtTurno.OnPrint:=TurniXXOnPrint;
    //Riga Reperibilità
    if (A058FPianifTurniDtM1.selT082.FieldByName('REPERIBILITA').asString = 'S') and
       not A058FPianifTurniDtM1.T058Stampa.FieldByName('RepSigla1_' + nGG.ToString).IsNull then
    begin
      TxtRepSigla1:=TQRDBText(bndDettaglio.AddPrintable(TQRDBText));
      TxtRepSigla1.Tag:=99;
      TxtRepSigla1.Parent:=bndDettaglio;
      TxtRepSigla1.Left:=Trunc(nLeft + 3);
      TxtRepSigla1.AutoSize:=True;
      TxtRepSigla1.Font:=bndDettaglio.Font;
      TxtRepSigla1.Font.Size:=6;
      TxtRepSigla1.Height:=HC;
      TxtRepSigla1.Top:=TxtTurno.Top + TxtTurno.Height;
      TxtRepSigla1.DataSet:=A058FPianifTurniDtM1.T058Stampa;
      TxtRepSigla1.DataField:='RepSigla1_' + nGG.ToString;
      TxtRepSigla1.Caption:=A058FPianifTurniDtM1.T058Stampa.FieldByName(TxtRepSigla1.DataField).AsString;//Forzo la caption perché altrimenti solo sul primo record non vengono mostrati i valori del record corrente del dataset
      TxtRepSigla1.Font.Style:=[fsBold];
    end;
    //Numero Timbrature
    if A058FPianifTurniDtM1.selT082.FieldByName('TIPO_STAMPA').AsString = 'C' then
    begin
      TxtNumTimb:=TQRDBText(bndDettaglio.AddPrintable(TQRDBText));
      TxtNumTimb.Tag:=99;
      TxtNumTimb.Parent:=bndDettaglio;
      TxtNumTimb.DataSet:=A058FPianifTurniDtM1.T058Stampa;
      TxtNumTimb.DataField:='NTIMBTURNO_' + IntToStr(nGG);
      TxtNumTimb.Caption:=A058FPianifTurniDtM1.T058Stampa.FieldByName(TxtNumTimb.DataField).AsString;//Forzo la caption perché altrimenti solo sul primo record non vengono mostrati i valori del record corrente del dataset
      TxtNumTimb.Left:=Trunc(nLeft + (L / 3) * 2);
      TxtNumTimb.ParentFont:=False;
      TxtNumTimb.Font:=bndDettaglio.Font;
      TxtNumTimb.Font.Color:=clRed;
      TxtNumTimb.Font.Size:=bndDettaglio.Font.Size - 1;
      TxtNumTimb.Top:=(bndDettaglio.Height div 3) * 2;
      TxtNumTimb.OnPrint:=MyInfoTimbOnPrint;
    end;
  end;

  //Separatore colonne finali a destra
  if A058FPianifTurniDtm1.selT082.FieldByName('SEPARATORE_COL').AsString = 'S' then
  begin
    //Separatore colonne di dettaglio
    xQRShape:=TQRShape(bndDettaglio.AddPrintable(TQRShape));
    xQRShape.Tag:=99;
    xQRShape.QRPrinter:=QRep.QRPrinter;//necessario per TQRShape creati dopo il QRepBeforePrint, altrimenti va in errore
    xQRShape.Parent:=bndDettaglio;
    xQRShape.Shape:=qrsVertLine;
    xQRShape.Height:=bndDettaglio.Height;
    xQRShape.Width:=1;
    xQRShape.Left:=Trunc(nLeft + L);
  end;

  //Dettaglio dato libero del dipendente
  if not A058FPianifTurniDtm1.selT082.FieldByName('DATO_ANAGRAFICO').IsNull and
     (bndDettaglio.Width > Trunc(nLeft + L + 3)){Verifico se c'è spazio per stampare il dato altrimenti, non stampo nulla} then
  begin
    TxtDatoLibero:=TQRDBText(bndDettaglio.AddPrintable(TQRDBText));
    TxtDatoLibero.Tag:=99;
    TxtDatoLibero.Parent:=bndDettaglio;
    TxtDatoLibero.AutoSize:=False;
    TxtDatoLibero.AutoStretch:=False;
    TxtDatoLibero.ParentFont:=True;
    TxtDatoLibero.Font:=bndDettaglio.Font;
    TxtDatoLibero.Font.Size:=bndDettaglio.Font.Size;
    TxtDatoLibero.DataSet:=A058FPianifTurniDtM1.T058Stampa;
    TxtDatoLibero.DataField:='DatoAnag';
    TxtDatoLibero.Caption:=A058FPianifTurniDtM1.T058Stampa.FieldByName(TxtDatoLibero.DataField).AsString;//Forzo la caption perché altrimenti solo sul primo record non vengono mostrati i valori del record corrente del dataset
    TxtDatoLibero.WordWrap:=True;
    TxtDatoLibero.Left:=Trunc(nLeft + L + 3);
    TxtDatoLibero.Top:=QRLMatricola.Top;
    TxtDatoLibero.Width:=bndDettaglio.Width - Trunc(nLeft + L + 3);
    TxtDatoLibero.Height:=bndDettaglio.Height - QRLMatricola.Top - 1;
  end;

  ScriviSaldiOre;
  ScriviTotaliDipendente(QRep.DataSet.FieldByName('Progressivo').AsInteger);
  ScriviOrariEAssenze;

  //Porto in primo piano le linee per non farle rimanere sotto le etichette
  for i:=A058FTabellone.ComponentCount - 1 downto 0 do
    if A058FTabellone.Components[i] is TQRShape then
      if TQRShape(A058FTabellone.Components[i]).Parent = bndDettaglio then
        TQRShape(A058FTabellone.Components[i]).BringToFront;
end;

procedure TA058FTabellone.MyInfoTimbOnPrint(Sender: TObject;var Value: string);
begin
  with TQRDBText(Sender) do
    if DataSet.FieldByName(DataField).AsInteger = 0 then
      Value:='';
end;

procedure TA058FTabellone.ScriviSaldiOre;
begin
  with A058FPianifTurniDtM1 do
  begin
    if selT082.FieldByName('SALDI_ORE').AsString = 'N' then
      exit;
    with T058Stampa do
      if selT082.FieldByName('COMPATTA_RIGHE_DIP').AsString = 'S' then
        QrLblTotTurno2.Caption:=Format('%-6s \ %-6s',[R180MinutiOre(FieldByName('Debito').AsInteger),R180MinutiOre(FieldByName('Assegnato').AsInteger)])
      else
      begin
        QrLblDebito.Caption:=Format('%7s',[R180MinutiOre(FieldByName('Debito').AsInteger)]);
        QRLblAssegnato.Caption:=Format('%7s',[R180MinutiOre(FieldByName('Assegnato').AsInteger)]);
        QRLblScostamento.Caption:=Format('%7s',[R180MinutiOre(FieldByName('Assegnato').AsInteger - FieldByName('Debito').AsInteger)]);
      end;
  end;
end;

procedure TA058FTabellone.ScriviTotaliDipendente(NDip:Integer);
var
  i,iSgOp,iSg,LblTop:Integer;
  sTotSigla:String;
begin
  with A058FPianifTurniDtM1 do
  begin
    if selT082.FieldByName('TOT_TURNI_MESE').AsString = 'N' then
      exit;
    //Mi posiziono sul record Vista del dipendente (sicuramente lo trovo)
    for i:=0 to Vista.Count - 1 do
      if Vista[i].Prog = NDip then
        Break;
    AggiornaTotPagDip(Vista[i],Trunc(T058Stampa.FieldByName('DataInizio').AsDateTime - DataInizio),Trunc(T058Stampa.FieldByName('DataFine').AsDateTime - T058Stampa.FieldByName('DataInizio').AsDateTime));
    if selT082.FieldByName('COMPATTA_RIGHE_DIP').AsString = 'S' then
    begin
      //Creo la nuova lista di sigle del dipendente sulla nuova banda di dettaglio
      QrLblTotTurno1.Caption:='';
      for iSgOp:=Low(TotPagGio) to High(TotPagGio) do
        if not TotPagGio[iSgOp].TotaleOperatore then
        begin
          sTotSigla:='';
          for iSg:=Low(TotPagDip) to High(TotPagDip) do
            if (TotPagDip[iSg].Operatore = TotPagGio[iSgOp].Operatore)
            and (TotPagDip[iSg].Sigla = TotPagGio[iSgOp].Sigla) then
            begin
              if TotPagDip[iSg].Totale > 0 then
                sTotSigla:=IntToStr(TotPagDip[iSg].Totale);
              Break; //esce dal ciclo delle sigle
            end;
          QrLblTotTurno1.Caption:=QrLblTotTurno1.Caption + Format('%-4s',[sTotSigla]);
        end;
    end
    else
    begin
      //Creo la nuova lista di sigle del dipendente sulla nuova banda di dettaglio
      LblTop:=QRLblTotTurno1.Top;
      for iSgOp:=Low(TotPagGio) to High(TotPagGio) do
        if not TotPagGio[iSgOp].TotaleOperatore then
          for iSg:=Low(TotPagDip) to High(TotPagDip) do
            if (TotPagDip[iSg].Operatore = TotPagGio[iSgOp].Operatore)
            and (TotPagDip[iSg].Sigla = TotPagGio[iSgOp].Sigla) then
            begin
              if TotPagDip[iSg].Totale > 0 then
                with TQRLabel(bndDettaglio.AddPrintable(TQRLabel)) do
                begin
                  Tag:=99;
                  Parent:=bndDettaglio;
                  Font:=QRLblTotTurno1.Font;
                  Font.Size:=QRLblTotTurno1.Font.Size;
                  Top:=LblTop;
                  Left:=QRLblTotTurno1.Left;
                  Height:=QRLblTotTurno1.Height;
                  Width:=QRLblTotTurno1.Width;
                  LblTop:=LblTop + Height - 1;
                  Alignment:=taLeftJustify;
                  Caption:=Format('%-3s %-3s',[TotPagGio[iSgOp].Sigla + IfThen(TotPagGio[iSg].Operatore <> T058Stampa.FieldByName('Operatore').AsString,GetSimboloOperatore(TotPagGio[iSgOp].Operatore,TotPagGio[iSgOp].Sigla,TotPagDip)),IntToStr(TotPagDip[iSg].Totale)]);
                end;
              Break; //esce dal ciclo delle sigle
            end;
      //Estendo l'altezza della banda e delle linee verticali
      bndDettaglio.Height:=Max(bndDettaglio.Height,LblTop + 1);
      if SaveDettaglioHeight <> bndDettaglio.Height then
        for i:=A058FTabellone.ComponentCount - 1 downto 0 do
          if A058FTabellone.Components[i] is TQRShape then
            if TQRShape(A058FTabellone.Components[i]).Shape = qrsVertLine then
              if TQRShape(A058FTabellone.Components[i]).Parent = bndDettaglio then
                TQRShape(A058FTabellone.Components[i]).Height:=bndDettaglio.Height;
    end;
  end;
end;

procedure TA058FTabellone.ScriviOrariEAssenze;
{Scrivo la descrizione degli orari e delle assenze sul piè di pagina}
var i:Integer;
begin
  with A058FPianifTurniDtM1.T058Stampa do
    for i:=0 to FieldCount - 1 do
      if Pos('CodOrari',Fields[i].FieldName) > 0 then
        PutOrario(Fields[i].AsString)
      else if Pos('CodAssenze',Fields[i].FieldName) > 0 then
        PutAssenza(Fields[i].AsString);
end;

procedure TA058FTabellone.PutOrario(Ora:String);
{Scrivo la descrizione degli orari nel riepilogo}
var
  S,ST:String;
  i:Integer;
begin
  with A058FPianifTurniDtM1 do
    if (A058FTabellone.LOrari.IndexOf(Ora) = -1) and (Q020.Locate('Codice',Ora,[])) then
    begin
      A058FTabellone.LOrari.Add(Ora);
      S:=R180DimLung(Q020.FieldByName('Codice').AsString,6) + R180DimLung(Q020.FieldByName('Descrizione').AsString,41);
      A058FTabellone.QRMOrari.Lines.Add(S);
      i:=A058FTabellone.QRMOrari.Lines.Count - 1;
      Q020Turni.Close;
      Q020Turni.SetVariable('COD',Q020.FieldByName('Codice').AsString);
      Q020Turni.SetVariable('DATA',Q020.FieldByName('DECORRENZA').AsDateTime);
      Q020Turni.Open;
      while not Q020Turni.Eof do
      begin
        if Q020Turni.FieldByName('SIGLATURNI').AsString = '' then
          ST:='[' + Q020Turni.FieldByName('NumTurno').AsString + ']'
        else
          ST:='(' + Q020Turni.FieldByName('SIGLATURNI').AsString + ')';
        S:='  ' + ST + ' = ' + Q020Turni.FieldByName('Entrata').AsString + ' - ' + Q020Turni.FieldByName('Uscita').AsString;
        A058FTabellone.QRLblTemp.Caption:=A058FTabellone.QRMOrari.Lines[i] + S;
        if A058FTabellone.QRMOrari.Left + A058FTabellone.QRLblTemp.Width >= (A058FTabellone.bndOrari.Width - 50) then
        begin
          //Creo una nuova riga...
          A058FTabellone.QRMOrari.Lines.Add(R180DimLung(Q020.FieldByName('Codice').AsString,6) + R180DimLung(Q020.FieldByName('Descrizione').AsString,41));
          i:=A058FTabellone.QRMOrari.Lines.Count - 1;
        end;
        A058FTabellone.QRMOrari.Lines[i]:=A058FTabellone.QRMOrari.Lines[i] + S;
        A058FTabellone.QRLblTemp.Caption:='';
        Q020Turni.Next;
      end;
    end;
end;

procedure TA058FTabellone.PutAssenza(Ass:String);
{Scrivo la descrizione delle assenze nel riepilogo}
var
  P:Integer;
  S:String;
begin
  with A058FPianifTurniDtM1.Q265 do
    if (A058FTabellone.LAssenze.IndexOf(Ass) = -1) and (Locate('Codice',Ass,[])) then
    begin
      A058FTabellone.LAssenze.Add(Ass);
      S:=R180DimLung(FieldByName('Codice').AsString,6) + R180DimLung(FieldByName('Descrizione').AsString,41);
      P:=A058FTabellone.QRMAssenze.Lines.Count;
      if P = 0 then
        A058FTabellone.QRMAssenze.Lines.Add(S)
      else
        if Length(A058FTabellone.QRMAssenze.Lines[P - 1]) > 50 then
          A058FTabellone.QRMAssenze.Lines.Add(S)
        else
          A058FTabellone.QRMAssenze.Lines[P - 1]:=A058FTabellone.QRMAssenze.Lines[P - 1] + S;
    end;
end;

procedure TA058FTabellone.bndDettaglioAfterPrint(Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  //Ripristino l'altezza normale della banda
  if SaveDettaglioHeight <> bndDettaglio.Height then
    bndDettaglio.Height:=SaveDettaglioHeight;
end;

procedure TA058FTabellone.bndTotLiquidabileBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var i,iGG,nGG,TotLiquid:Integer;
    nLeft,L:Real;
    xQRShape:TQRShape;
    xQRLabel:TQRLabel;
begin
  if A058FPianifTurniDtM1.selT082.FieldByName('TOT_LIQUIDABILE').AsString = 'N' then
  begin
    PrintBand:=False;
    exit;
  end;
  DistruggiOggetti99(bndTotLiquidabile);
  //Aggiorno le misure
  nLeft:=0;
  with A058FPianifTurniDtm1 do
    L:=QRep.TextWidth(bndDettaglio.Font,R180Spaces('',selT082.FieldByName('GG_PAGINA').AsInteger * LungCella)) div selT082.FieldByName('GG_PAGINA').AsInteger;
  TotLiquid:=0;

  for nGG:=0 to Min(A058FPianifTurniDtm1.selT082.FieldByName('GG_PAGINA').AsInteger - 1,Trunc(A058FPianifTurniDtm1.T058Stampa.FieldByName('DataFine').AsDateTime - A058FPianifTurniDtm1.T058Stampa.FieldByName('DataInizio').AsDateTime)) do
  begin
    if nLeft = 0 then
      nLeft:=nLeftIniGiorni
    else
      nLeft:=nLeft + L;

    //Separatori colonne a sinistra
    if A058FPianifTurniDtm1.selT082.FieldByName('SEPARATORE_COL').AsString = 'S' then
    begin
      //Separatore colonne di bndTotLiquidabile
      xQRShape:=TQRShape(bndTotLiquidabile.AddPrintable(TQRShape));
      xQRShape.Tag:=99;
      xQRShape.QRPrinter:=QRep.QRPrinter;//necessario per TQRShape creati dopo il QRepBeforePrint, altrimenti va in errore
      xQRShape.Parent:=bndTotLiquidabile;
      xQRShape.Left:=Trunc(nLeft);
      xQRShape.Top:=0;
      xQRShape.Shape:=qrsVertLine;
      xQRShape.Height:=bndTotLiquidabile.Height;
      xQRShape.Width:=1;
    end;

    //Liquidabile del giorno
    iGG:=Trunc(A058FPianifTurniDtM1.T058Stampa.FieldByName('DataInizio').AsDateTime - A058FPianifTurniDtM1.OldInizio) + nGG;
    xQRLabel:=TQRLabel(bndTotLiquidabile.AddPrintable(TQRLabel));
    xQRLabel.Tag:=99;
    xQRLabel.Parent:=bndTotLiquidabile;
    xQRLabel.Left:=Trunc(nLeft + 3);
    xQRLabel.Font:=bndTotLiquidabile.Font;
    xQRLabel.Font.Size:=bndTotLiquidabile.Font.Size - 2;
    xQRLabel.Top:=5;
    xQRLabel.AutoSize:=True;
    xQRLabel.Caption:=R180MinutiOre(A058FPianifTurniDtM1.TotGio[iGG].OreLiquid);
    TotLiquid:=TotLiquid + A058FPianifTurniDtM1.TotGio[iGG].OreLiquid;
  end;

  //Liquidabile del periodo
  qlblTotLiquid.Caption:=Copy(qlblTotLiquid.Caption,1,Pos(':',qlblTotLiquid.Caption) + 2) + R180MinutiOre(TotLiquid);

  //Separatori colonne finali a destra
  if A058FPianifTurniDtm1.selT082.FieldByName('SEPARATORE_COL').AsString = 'S' then
  begin
    xQRShape:=TQRShape(bndTotLiquidabile.AddPrintable(TQRShape));
    xQRShape.Tag:=99;
    xQRShape.QRPrinter:=QRep.QRPrinter;//necessario per TQRShape creati dopo il QRepBeforePrint, altrimenti va in errore
    xQRShape.Parent:=bndTotLiquidabile;
    xQRShape.Left:=Trunc(nLeft + L);
    xQRShape.Top:=0;
    xQRShape.Shape:=qrsVertLine;
    xQRShape.Height:=bndTotLiquidabile.Height;
    xQRShape.Width:=1;
  end;

  //Porto in primo piano le linee per non farle rimanere sotto le etichette
  for i:=A058FTabellone.ComponentCount - 1 downto 0 do
    if A058FTabellone.Components[i] is TQRShape then
      if TQRShape(A058FTabellone.Components[i]).Parent = bndTotLiquidabile then
        TQRShape(A058FTabellone.Components[i]).BringToFront;
end;

procedure TA058FTabellone.bndTotOrarioBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:=False;
end;

procedure TA058FTabellone.bndTotTurniBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var LC,nLeft,L,nGG,i,iLbl,iSgOp,iGG,iOp,iSg,HCTotTurni:Integer;
    sTotSigla:String;
    SgOpTrov:Boolean;
    xQRShape:TQRShape;
    xQRLabel:TQRLabel;

  procedure CreaTotaliSigleEMinMax;
  var iSgOp,IndLabel,nLeftMinMax,iCodGGOrd:Integer;
      sCodGG,sMinMax:String;
  const sCodGGOrd:String = '*1234567PF';
  begin
    with A058FPianifTurniDtM1 do
    begin
      //Recupero i massimi e i minimi
      sCodGG:='';
      selT606a.First;
      while not selT606a.Eof do
      begin
        if Pos(selT606a.FieldByName('COD_GIORNO').AsString,sCodGG) = 0 then
          sCodGG:=sCodGG + selT606a.FieldByName('COD_GIORNO').AsString;
        selT606a.Next;
      end;

      for iSgOp:=Low(TotPagGio) to High(TotPagGio) do
        if not TotPagGio[iSgOp].TotaleOperatore or (selT082.FieldByName('TOT_OPE_TURNO').AsString = 'S') then
        begin
          //Separatore di riga tra operatori
          if (iSgOp > 0) and (TotPagGio[iSgOp].Operatore <> TotPagGio[iSgOp - 1].Operatore) then
          begin
            xQRShape:=TQRShape(bndTotTurni.AddPrintable(TQRShape));
            xQRShape.Tag:=99;
            xQRShape.QRPrinter:=QRep.QRPrinter;//necessario per TQRShape creati dopo il QRepBeforePrint, altrimenti va in errore
            xQRShape.Parent:=bndTotTurni;
            xQRShape.Shape:=qrsHorLine;
            xQRShape.Pen.Style:=psDot;
            xQRShape.Top:=HCTotTurni - 2;
            xQRShape.Height:=1;
            xQRShape.Width:=bndTotTurni.Width;
            xQRShape.Left:=QRLTurniTotali.Left;
          end;

          //Etichetta di riepilogo per ogni sigla
          xQRLabel:=TQRLabel(bndTotTurni.AddPrintable(TQRLabel));
          //xQRLabel.Tag:=99; //non deve avere il tag 99 perché viene distrutta con LstLabelTotOperatori
          xQRLabel.Parent:=bndTotTurni;
          xQRLabel.Height:=HC;
          xQRLabel.Top:=HCTotTurni;
          xQRLabel.Left:=QRLTurniTotali.Left;
          xQRLabel.Caption:=Format('%5s %-3s',[TotPagGio[iSgOp].Operatore,IfThen(TotPagGio[iSgOp].TotaleOperatore,'Tot',TotPagGio[iSgOp].Sigla + GetSimboloOperatore(TotPagGio[iSgOp].Operatore,TotPagGio[iSgOp].Sigla,TotPagGio))]);
          if TotPagGio[iSgOp].TotaleOperatore then
            xQRLabel.Font.Color:=clBlue;
          IndLabel:=LstLabelTotOperatori.Add(xQRLabel);

          //Etichette dei titoli dei totali per sigla e generali
          QRLTotaliTurno.Left:=LstLabelTotOperatori[IndLabel].Left + LstLabelTotOperatori[IndLabel].Width + LC * 2;
          QRLTotaliPagina.Left:=QRLTotaliTurno.Left;

          //Etichetta del totale della sigla
          xQRLabel:=TQRLabel(bndTotTurni.AddPrintable(TQRLabel));
          xQRLabel.Parent:=bndTotTurni;
          xQRLabel.Height:=HC;
          xQRLabel.Top:=HCTotTurni;
          xQRLabel.Left:=QRLTotaliTurno.Left;
          xQRLabel.Caption:=Format('%-4s',[IntToStr(TotPagGio[iSgOp].Totale)]);
          xQRLabel.Tag:=99;
          nLeftMinMax:=xQRLabel.Left + xQRLabel.Width + LC * 2;
          if TotPagGio[iSgOp].TotaleOperatore then
            xQRLabel.Font.Color:=clBlue;

          QRLMinMax.Left:=nLeftMinMax;
          //Scrivo secondo un certo ordine i limiti min-max per ogni tipo giorno configurato
          for iCodGGOrd:=1 to sCodGGOrd.Length do
            if Pos(sCodGGOrd[iCodGGOrd],sCodGG) > 0 then
            begin
              if (iSgOp = 0) and (iCodGGOrd > 1) then
              begin
                //Titolo tipo giorno
                xQRLabel:=TQRLabel(bndTotTurni.AddPrintable(TQRLabel));
                xQRLabel.Parent:=bndTotTurni;
                xQRLabel.Height:=HC;
                xQRLabel.Top:=QRLMinMax.Top;
                xQRLabel.Left:=nLeftMinMax;
                xQRLabel.Caption:=Format('%2s%1s%2s',['',sCodGGOrd[iCodGGOrd],'']);
                xQRLabel.Tag:=99;
              end;
              //Limiti min-max
              xQRLabel:=TQRLabel(bndTotTurni.AddPrintable(TQRLabel));
              xQRLabel.Parent:=bndTotTurni;
              xQRLabel.Height:=HC;
              xQRLabel.Top:=HCTotTurni;
              xQRLabel.Left:=nLeftMinMax;
              sMinMax:='';
              if selT606a.SearchRecord('COD_TIPOOPE;SIGLA_TURNO;COD_GIORNO',VarArrayOf([TotPagGio[iSgOp].Operatore,TotPagGio[iSgOp].Sigla,sCodGGOrd[iCodGGOrd]]),[srFromBeginning]) then
                sMinMax:=Format('%2s-%-2s',[selT606a.FieldByName('MINIMO').AsString,selT606a.FieldByName('MASSIMO').AsString]);
              xQRLabel.Caption:=Format('%5s',[sMinMax]);
              xQRLabel.Tag:=99;
              if TotPagGio[iSgOp].TotaleOperatore then
                xQRLabel.Font.Color:=clBlue;
              nLeftMinMax:=nLeftMinMax + xQRLabel.Width + 1;
            end;

          HCTotTurni:=HCTotTurni + HC;
        end;
    end;
  end;

begin
  if A058FPianifTurniDtM1.selT082.FieldByName('TOT_TURNO').AsString = 'N' then
  begin
    PrintBand:=False;
    exit;
  end;

  if LstLabelTotOperatori <> nil then
    FreeAndNil(LstLabelTotOperatori);
  DistruggiOggetti99(bndTotTurni);

  //bndTotTurni
  HCTotTurni:=HC;
  QRLTurniTotali.Height:=HCTotTurni;
  QRLTotaliTurno.Height:=HCTotTurni;
  QRLMinMax.Height:=HCTotTurni;
  //Totali giornalieri
  LstLabelTotOperatori:=TObjectList<TQRLabel>.Create;
  LstLabelTotOperatori.OwnsObjects:=True;

  LC:=QRep.TextWidth(bndDettaglio.Font,' ') - 1; //Lunghezza carattere ridotta di un punto
  CreaTotaliSigleEMinMax;
  bndTotTurni.Height:=HCTotTurni;

  //Aggiorno le misure LC
  nLeft:=0;
  with A058FPianifTurniDtm1 do
  begin
    L:=QRep.TextWidth(bndDettaglio.Font,R180Spaces('',selT082.FieldByName('GG_PAGINA').AsInteger * LungCella)) div selT082.FieldByName('GG_PAGINA').AsInteger;

    for nGG:=0 to Min(selT082.FieldByName('GG_PAGINA').AsInteger - 1,Trunc(T058Stampa.FieldByName('DataFine').AsDateTime - T058Stampa.FieldByName('DataInizio').AsDateTime)) do
    begin
      if nLeft = 0 then
        nLeft:=nLeftIniGiorni
      else
        nLeft:=nLeft + L;

      //Separatori colonne a sinistra
      if selT082.FieldByName('SEPARATORE_COL').AsString = 'S' then
      begin
        //Separatore colonne di bndTotTurni
        xQRShape:=TQRShape(bndTotTurni.AddPrintable(TQRShape));
        xQRShape.Tag:=99;
        xQRShape.QRPrinter:=QRep.QRPrinter;//necessario per TQRShape creati dopo il QRepBeforePrint, altrimenti va in errore
        xQRShape.Parent:=bndTotTurni;
        xQRShape.Shape:=qrsVertLine;
        xQRShape.Top:=0;
        xQRShape.Left:=Trunc(nLeft);
        xQRShape.Height:=bndTotTurni.Height;
        xQRShape.Width:=1;
      end;

      iLbl:=0;
      for iSgOp:=Low(TotPagGio) to High(TotPagGio) do
        if not TotPagGio[iSgOp].TotaleOperatore or (selT082.FieldByName('TOT_OPE_TURNO').AsString = 'S') then
        begin
          xQRLabel:=TQRLabel(bndTotTurni.AddPrintable(TQRLabel));
          xQRLabel.Tag:=99;
          xQRLabel.Parent:=bndTotTurni;
          xQRLabel.Font:=LstLabelTotOperatori[iLbl].Font;
          xQRLabel.Font.Size:=LstLabelTotOperatori[iLbl].Font.Size;
          xQRLabel.Font.Color:=LstLabelTotOperatori[iLbl].Font.Color;
          xQRLabel.Top:=LstLabelTotOperatori[iLbl].Top;
          xQRLabel.Left:=Trunc(nLeft + 2);
          xQRLabel.Height:=LstLabelTotOperatori[iLbl].Height;
          xQRLabel.Alignment:=taLeftJustify;
          xQRLabel.Font.Style:=[];
          if TotPagGio[iSgOp].TotaleOperatore then
            sTotSigla:='0'
          else
            sTotSigla:='';
          SgOpTrov:=False;
          iGG:=Trunc(T058Stampa.FieldByName('DataInizio').AsDateTime - OldInizio) + nGG;
          for iOp:=Low(TotGio[iGG].Operatori) to High(TotGio[iGG].Operatori) do
            if TotGio[iGG].Operatori[iOp].Operatore = TotPagGio[iSgOp].Operatore then
            begin
              if TotPagGio[iSgOp].TotaleOperatore then
                sTotSigla:=Format('%-3s',[IntToStr(TotGio[iGG].Operatori[iOp].Totale)])
              else
                for iSg:=Low(TotGio[iGG].Operatori[iOp].Sigle) to High(TotGio[iGG].Operatori[iOp].Sigle) do
                  with TotGio[iGG].Operatori[iOp].Sigle[iSg] do
                    if Sigla = TotPagGio[iSgOp].Sigla then
                    begin
                      if (Totale > 0) or TotPagGio[iSgOp].VisualizzaSempre then
                      begin
                        sTotSigla:=Format('%-3s',[IntToStr(Totale)]);
                        if (Min <> '-') and (Max <> '-') then
                          if (Totale < StrToInt(Min)) or (Totale > StrToInt(Max)) then
                            xQRLabel.Font.Style:=[fsBold];
                      end;
                      SgOpTrov:=True;
                      Break; //esce dal ciclo delle sigle
                    end;
              if SgOpTrov then
                Break; //esce dal ciclo degli operatori
            end;
          xQRLabel.Caption:=sTotSigla;
          inc(iLbl);
        end;
    end;

    //Separatori colonne finali a destra
    if selT082.FieldByName('SEPARATORE_COL').AsString = 'S' then
    begin
      //Separatore colonne di bndTotTurni
      xQRShape:=TQRShape(bndTotTurni.AddPrintable(TQRShape));
      xQRShape.Tag:=99;
      xQRShape.QRPrinter:=QRep.QRPrinter;//necessario per TQRShape creati dopo il QRepBeforePrint, altrimenti va in errore
      xQRShape.Parent:=bndTotTurni;
      xQRShape.Shape:=qrsVertLine;
      xQRShape.Top:=0;
      xQRShape.Left:=Trunc(nLeft + L);
      xQRShape.Height:=bndTotTurni.Height;
      xQRShape.Width:=1;
    end;
  end;

  //Porto in primo piano le linee per non farle rimanere sotto le etichette
  for i:=A058FTabellone.ComponentCount - 1 downto 0 do
    if A058FTabellone.Components[i] is TQRShape then
      if TQRShape(A058FTabellone.Components[i]).Parent = bndTotTurni then
        TQRShape(A058FTabellone.Components[i]).BringToFront;
end;

procedure TA058FTabellone.bndTotGeneraliBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var nLeft,L,nGG,i,iSgOp,iGG,iOp,iSg,nTotGiorno:Integer;
    xQRLabel:TQRLabel;
    xQRShape:TQRShape;
begin
  if A058FPianifTurniDtM1.selT082.FieldByName('TOT_GENERALI').AsString = 'N' then
  begin
    PrintBand:=False;
    exit;
  end;
  DistruggiOggetti99(bndTotGenerali);

  nTotGiorno:=0;
  with A058FPianifTurniDtm1 do
    for iSgOp:=Low(TotPagGio) to High(TotPagGio) do
      if TotPagGio[iSgOp].TotaleOperatore then
        inc(nTotGiorno,TotPagGio[iSgOp].Totale);
  QRLTotaliPagina.Caption:=Format('%-4s',[IntToStr(nTotGiorno)]);

  nLeft:=0;
  with A058FPianifTurniDtm1 do
  begin
    L:=QRep.TextWidth(bndDettaglio.Font,R180Spaces('',selT082.FieldByName('GG_PAGINA').AsInteger * LungCella)) div selT082.FieldByName('GG_PAGINA').AsInteger;

    for nGG:=0 to Min(selT082.FieldByName('GG_PAGINA').AsInteger - 1,Trunc(T058Stampa.FieldByName('DataFine').AsDateTime - T058Stampa.FieldByName('DataInizio').AsDateTime)) do
    begin
      if nLeft = 0 then
        nLeft:=nLeftIniGiorni
      else
        nLeft:=nLeft + L;

      //Separatori colonne a sinistra
      if selT082.FieldByName('SEPARATORE_COL').AsString = 'S' then
      begin
        //Separatore colonne di bndTotGenerali
        xQRShape:=TQRShape(bndTotGenerali.AddPrintable(TQRShape));
        xQRShape.Tag:=99;
        xQRShape.QRPrinter:=QRep.QRPrinter;//necessario per TQRShape creati dopo il QRepBeforePrint, altrimenti va in errore
        xQRShape.Parent:=bndTotGenerali;
        xQRShape.Shape:=qrsVertLine;
        xQRShape.Top:=0;
        xQRShape.Left:=Trunc(nLeft);
        xQRShape.Height:=bndTotGenerali.Height;
        xQRShape.Width:=1;
      end;

      xQRLabel:=TQRLabel(bndTotGenerali.AddPrintable(TQRLabel));
      xQRLabel.Tag:=99;
      xQRLabel.Parent:=bndTotGenerali;
      xQRLabel.ParentFont:=True;
      xQRLabel.Font:=bndTotGenerali.Font;
      xQRLabel.Font.Size:=bndTotGenerali.Font.Size;
      xQRLabel.Top:=qrLblTotGen.Top;
      xQRLabel.AutoSize:=True;
      xQRLabel.Left:=Trunc(nLeft + 2);
      xQRLabel.Height:=HC;
      xQRLabel.Alignment:=taLeftJustify;
      nTotGiorno:=0;
      iGG:=Trunc(T058Stampa.FieldByName('DataInizio').AsDateTime - OldInizio) + nGG;
      for iOp:=Low(TotGio[iGG].Operatori) to High(TotGio[iGG].Operatori) do
        for iSg:=Low(TotGio[iGG].Operatori[iOp].Sigle) to High(TotGio[iGG].Operatori[iOp].Sigle) do
          nTotGiorno:=nTotGiorno + TotGio[iGG].Operatori[iOp].Sigle[iSg].Totale;
      xQRLabel.Caption:=Format('%-3s',[IntToStr(nTotGiorno)]);
    end;

    //Separatori colonne finali a destra
    if selT082.FieldByName('SEPARATORE_COL').AsString = 'S' then
    begin
      //Separatore colonne di bndTotGenerali
      xQRShape:=TQRShape(bndTotGenerali.AddPrintable(TQRShape));
      xQRShape.Tag:=99;
      xQRShape.QRPrinter:=QRep.QRPrinter;//necessario per TQRShape creati dopo il QRepBeforePrint, altrimenti va in errore
      xQRShape.Parent:=bndTotGenerali;
      xQRShape.Shape:=qrsVertLine;
      xQRShape.Top:=0;
      xQRShape.Left:=Trunc(nLeft + L);
      xQRShape.Height:=bndTotGenerali.Height;
      xQRShape.Width:=1;
    end;
  end;

  //Porto in primo piano le linee per non farle rimanere sotto le etichette
  for i:=A058FTabellone.ComponentCount - 1 downto 0 do
    if A058FTabellone.Components[i] is TQRShape then
      if TQRShape(A058FTabellone.Components[i]).Parent = bndTotGenerali then
        TQRShape(A058FTabellone.Components[i]).BringToFront;
end;

procedure TA058FTabellone.bndOrariBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var L:TStringList;
begin
  if A058FPianifTurniDtM1.selT082.FieldByName('DETT_ORARI').asString = 'N' then
  begin
    PrintBand:=False;
    exit;
  end;
  QRLblTemp.Caption:='';
  //Ordino il memo orari
  L:=TStringList.Create;
  try
    L.Assign(QRMOrari.Lines);
    L.Sorted:=True;
    QRMOrari.Lines.Assign(L);
  finally
    L.Free;
  end;
end;

procedure TA058FTabellone.bndAssenzeBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if A058FPianifTurniDtM1.selT082.FieldByName('ASSENZE').asString = 'N' then
  begin
    PrintBand:=False;
    exit;
  end;
end;

end.
