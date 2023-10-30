unit B028UTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, MConnect, StdCtrls, ActiveX;

const
  MAXPRINTERBUFFER = 8000;
  MAXPRINTERNAME = 500;
  MAXPRINTERINFO = 50;

type
  TPrinterBuffer = array[0..MAXPRINTERBUFFER - 1] of char;

  TB028FTest = class(TForm)
    Button1: TButton;
    DCOMConnection1: TDCOMConnection;
    btnPrinters: TButton;
    ListBox1: TListBox;
    btnSetPrinter: TButton;
    Label1: TLabel;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    Button18: TButton;
    Button19: TButton;
    Button20: TButton;
    Button21: TButton;
    Button22: TButton;
    Button23: TButton;
    Button24: TButton;
    Button25: TButton;
    Button26: TButton;
    Button27: TButton;
    Button28: TButton;
    Button29: TButton;
    Button30: TButton;
    Button31: TButton;
    Button32: TButton;
    Button33: TButton;
    Button34: TButton;
    Button35: TButton;
    Button36: TButton;
    Button37: TButton;
    Button38: TButton;
    Button39: TButton;
    Button40: TButton;
    Button41: TButton;
    Button42: TButton;
    procedure Button1Click(Sender: TObject);
    procedure btnPrintersClick(Sender: TObject);
    procedure btnSetPrinterClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure Button20Click(Sender: TObject);
    procedure Button21Click(Sender: TObject);
    procedure Button22Click(Sender: TObject);
    procedure Button23Click(Sender: TObject);
    procedure Button24Click(Sender: TObject);
    procedure Button25Click(Sender: TObject);
    procedure Button26Click(Sender: TObject);
    procedure Button27Click(Sender: TObject);
    procedure Button28Click(Sender: TObject);
    procedure Button29Click(Sender: TObject);
    procedure Button30Click(Sender: TObject);
    procedure Button31Click(Sender: TObject);
    procedure Button32Click(Sender: TObject);
    procedure Button33Click(Sender: TObject);
    procedure Button34Click(Sender: TObject);
    procedure Button35Click(Sender: TObject);
    procedure Button36Click(Sender: TObject);
    procedure Button37Click(Sender: TObject);
    procedure Button38Click(Sender: TObject);
    procedure Button39Click(Sender: TObject);
    procedure Button40Click(Sender: TObject);
    procedure Button41Click(Sender: TObject);
    procedure Button42Click(Sender: TObject);
  private
    { Private declarations }
    printerNames: TStringList;
    defaultPrinter: integer;
    function  SetPrinter(const PrinterName: String): boolean;
    procedure GetPrinterNames;
    function  ParseNames(const namebuffer: TPrinterBuffer; var startPos: integer): string;
  public
    { Public declarations }
  end;

var
  B028FTest: TB028FTest;

implementation

uses Strutils, C180FunzioniGenerali, B028UTestDM, B028UPrintServerDM;

{$R *.dfm}

procedure TB028FTest.Button1Click(Sender: TObject);
begin
  //Set TQuickRep.PrinterSettings.PrinterIndex to set the printer number. Then, TQuickRep.Print to print the report.

  //You can solve this problem by creating a new dword UserSelectedDefault with the value: 1 in HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Windows\SessionDefaultDevices\Session_ID
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.ProvaStampa('c:\temp\B028.pdf');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TB028FTest.Button20Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
 (*   DCOMConnection1.AppServer.PrintA145('SELECT /*+ ordered */ T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO FROM' + #$D#$A +
                                        'T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480' + #$D#$A +
                                        'WHERE T030.Progressivo = V430.T430Progressivo AND' + #$D#$A +
                                        'T030.ComuneNas = T480.Codice(+) AND' + #$D#$A +
                                        ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine' + #$D#$A +
                                        'AND :DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)' + #$D#$A +
                                        'AND T030.PROGRESSIVO = 0' + #$D#$A,
                                        '',
                                         'SYSMAN',
                                         'CN1',
                                         'IRIS',
                                         '{"edtDataElaborazione":"28/01/2015","cmbMedicineLegali":"","chkIns":"N","chkProl":"N","chkSoloCont":"N","chkCanc":"N","chkAggiorna":"N",' +
                                         '"chkAnnulla":"S","chkEsenzioneAutomatica":"N","edtNumeroMinimoEventi":"","edtMaxGiorniContinuativi":"","edtMesiVerificaEventi":"","rgpTipoStampa":"0",' +
                                         '"chkPeriodiComunicati":"N","chkFiltroDataComun":"N","edtDataDa":"","edtDataA":"","chkStampaAssMal":"N","chkNote":"N","chkLogo":"N","edtLogoLarg":"","chkNumProt":"N",' +
                                         '"edtNumProt":"","chkLuogo":"N","edtLuogo":"","memDato1":"","memDato2":"","memFirma":"","lstElementiDettaglio":""}',
                                         '');  *)
    DCOMConnection1.AppServer.PrintA145('SELECT T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO,T430AZIENDA_BASE,T430D_AZIENDA_BASE ,V430.T430ABCAUSALE1 FROM' + #$D#$A +
                                        'T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480' + #$D#$A +
                                        'WHERE T030.Progressivo = V430.T430Progressivo AND' + #$D#$A +
                                        'T030.ComuneNas = T480.Codice(+) AND' + #$D#$A +
                                        ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine' + #$D#$A +
                                        'AND' + #$D#$A +
                                        '/*I072*/' + #$D#$A +
                                        '/*A000*/:DataLavoro BETWEEN T430INIZIO AND ADD_MONTHS(LAST_DAY(NVL(T430FINE,TO_DATE(''31123999'',''DDMMYYYY''))),2)/*\A000*/' + #$D#$A +
                                        '/*\I072*/' + #$D#$A +
                                        'AND T030.TIPO_PERSONALE = ''I''' + #$D#$A + 'ORDER BY T030.COGNOME, T030.NOME, T030.MATRICOLA',
                                        'c:\testa045.pdf',
                                        'TESTR',
                                        'TESTR',
                                        'IRIS',
                                         '{"StandardPrinter":"N","edtDataElaborazione":"01/07/2021","cmbMedicineLegali":"","chkIns":"S","chkProl":"S","chkSoloCont":"N","chkCanc":"S","chkAggiorna":"N",' +
                                         '"chkAnnulla":"N","chkEsenzioneAutomatica":"N","edtNumeroMinimoEventi":"","edtMaxGiorniContinuativi":"","edtMesiVerificaEventi":"","rgpTipoStampa":"0",' +
                                         '"chkPeriodiComunicati":"N","chkFiltroDataComun":"N","edtDataDa":"","edtDataA":"","chkStampaAssMal":"N","chkNote":"N","chkLogo":"N","edtLogoLarg":"","chkNumProt":"N",' +
                                         '"edtNumProt":"","chkLuogo":"N","edtLuogo":"","memDato1":"","memDato2":"","memFirma":"","lstElementiDettaglio":"COGNOME"}',
                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TB028FTest.Button21Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try

    DCOMConnection1.AppServer.Prints715('SELECT  T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO FROM' + #$D#$A +
                                        'T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480' + #$D#$A +
                                        'WHERE T030.Progressivo = V430.T430Progressivo AND' + #$D#$A +
                                        'T030.ComuneNas = T480.Codice(+) AND' + #$D#$A +
                                        ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine' + #$D#$A +
                                        'AND :DATALAVORO BETWEEN T430INIZIO AND NVL(T430FINE,:DATALAVORO)' + #$D#$A +
                                        'AND T030.TIPO_PERSONALE = ''I''' + #$D#$A +
                                        //'AND'#$D#$A'((T030.COGNOME BETWEEN ''A%'' AND ''D%''))' + #$D#$A +
                                        'AND'#$D#$A'((T030.MATRICOLA = ''6519''))' + #$D#$A +
                                        'ORDER BY T030.COGNOME, T030.NOME',
                                         'c:\temp\TestS715.pdf',
                                        'SYSMAN',
                                        'RAVDA',
                                        'DBCLIENTI',
                                        '{"edtDataDa":"01/01/2017","edtDataA":"01/01/2019","rgpTipoValutazione":"2","rgpTipoChiusura":"3","rgpStatoAvanzamento":"1",' +
                                        '"edtStatoAvanzamento":"A.1,A.2,B.1,B.2,C.1,C.2","rgpDipValutabile":"2","rgpPresaVisione":"3","rgpSchedeProtocollo":"2","chkControllaRegola":"N","chkAggiornaPunteggi":"N",' +
                                        '"chkAvanzaStato":"N","chkChiudiScheda":"N","chkRiapriScheda":"N","chkRetrocediStato":"N","chkAggiornaIncentivi":"N","chkStampa":"S","chkFilePDF":"N",'+
                                        '"chkProtocolla":"N","chkSostituisciRegola":"N","chkAssegnaValutatore":"N","chkLegendaPunteggi":"N","chkPresaVisione":"N"}',
                                         '',
                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TB028FTest.Button2Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try

    DCOMConnection1.AppServer.PrintA045('SELECT T030.*,T480.CITTA,T480.PROVINCIA,V430.T430BADGE,V430.T430INIZIO,V430.T430FINE,V430.T430DATADECORRENZA,V430.T430DATAFINE' + CRLF +
                                         'FROM T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480' + CRLF +
                                         'WHERE T030.Progressivo = V430.T430Progressivo AND T030.ComuneNas = T480.Codice(+) AND :DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine' + CRLF +
                                         'AND :DATALAVORO BETWEEN T430INIZIO AND NVL(LAST_DAY(T430FINE),:DATALAVORO) --AND (T030.COGNOME = ''ROSSI'')' + CRLF +
                                         'ORDER BY T030.COGNOME,T030.NOME,T030.MATRICOLA',

                                         'c:\temp\TestA045.xls',
                                         'SYSMAN',
                                         'AZIN',
                                         'MEDP_ORCL',

                                         '{"edtDaData":"01/01/2012","edtCausali":"0001,001","edtAData":"31/12/2012","rgpArrotondamentoQualifica":"1","rgpTipoArrotondamentoQualifica":"2",'+
                                         '"rgpArrotondamentoAssenza":"0","rgpTipoArrotondamentoAssenza":"2","rgpArrotondamentoTotale":"0","rgpTipoArrotondamentoTotale":"2","chkGGLavorativi":"S",'+
                                         '"ChkAssTutte":"S","ChkPartOr":"N","ChkAssTutte":"S","chkSantoPatrono":"S","LstListaCausali":"000001,A11030,S16020,T11008,T13660","LstListaTipiRapporto":'+
                                         '"ALTRO,CD0R,CD0TI,CD101,CD1TI,CD2TI,CD3TI,CD4TI,CG0TI,CG1TI,CG2TI,EE0TI,GP0TI,GP1TI,GP2TI,GP3TI,I,PA0P,PA0R,PA10T,PA11T,PA1P,PA1R,PA2P,PA2R,PA3P,PA3R,PA4P,'+
                                         'PA4R,PA9TI,PB0I,PB0TI,R,SI,TD"}',

                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TB028FTest.Button3Click(Sender: TObject);
//var DettaglioLog, MessaggioAggiuntivo: OleVariant;
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintA061('SELECT T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO,T430AZIENDA_BASE,T430D_AZIENDA_BASE FROM T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480' +
                                        ' WHERE T030.Progressivo = V430.T430Progressivo AND T030.ComuneNas = T480.Codice(+) AND :DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine AND ' +
                                        '/*I072*/ :DataLavoro BETWEEN T430INIZIO AND ADD_MONTHS(LAST_DAY(NVL(T430FINE,TO_DATE(''31123999'',''DDMMYYYY''))),10) /*\I072*/ AND T030.TIPO_PERSONALE = ''I'' AND T030.PROGRESSIVO = 41 AND T030.PROGRESSIVO = 41',

                                         'c:\temp\TestA061.pdf',
                                         '8156',
                                         'AZIN',
                                         'PARMA_COMUNE',

                                         '{"edtDaData":"01/01/2016","edtAData":"31/03/2016",' +
                                           '"edtDaRegStamp":"01/03/2016","edtARegStamp":"29/02/2016",' +
                                           '"edtGGMinCont":"","rgpAssenzeConsiderate":"0","rgpValidate":"2","rgpOrdinamento":"0",' +
                                           '"chkSoloAssRegSucc":"N","chkSalvaUltRegStamp":"N","chkDatiIndividuali":"S","chkStampaNominativo":"S",' +
                                           '"chkStampaMatricola":"S","chkStampaBadge":"S","chkDettGiorn":"S","chkDettPer":"N","chkSaltoPagRaggrup":"N",' +
                                           '"chkSaltoPagIndividuale":"N","chkConiuge":"N","chkRiduzioni":"N","chkSoloRiduzioni":"N",' +
                                           '"chkConteggiGG":"N","chkGiorniSignificativi":"N","chkCausaliCumulate":"N","chkPeriodoServizio":"N",' +
                                           '"chkTotIndividuali":"N","chkTotRaggrup":"N","chkTotFam":"N","chkTotGenerali":"N",' +
                                           '"LstCausali":"31,M100,M100D","LstCodAcc":"","dcmbTipoAcc":"","dcmbCampo":""}',

                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;
  (*
  with TB028PrintServer.Create(nil) do
  try
    PrintA061('SELECT T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO,T430AZIENDA_BASE,T430D_AZIENDA_BASE FROM T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480' +
                                        ' WHERE T030.Progressivo = V430.T430Progressivo AND T030.ComuneNas = T480.Codice(+) AND :DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine AND ' +
                                        '/*I072*/ :DataLavoro BETWEEN T430INIZIO AND ADD_MONTHS(LAST_DAY(NVL(T430FINE,TO_DATE(''31123999'',''DDMMYYYY''))),10) /*\I072*/ AND T030.TIPO_PERSONALE = ''I'' AND T030.PROGRESSIVO = 41 AND T030.PROGRESSIVO = 41',

                                         'c:\temp\TestA061.pdf',
                                         '8156',
                                         'AZIN',
                                         'IRIS',

                                         '{"edtDaData":"01/01/2016","edtAData":"31/03/2016",' +
                                           '"edtDaRegStamp":"01/03/2016","edtARegStamp":"29/02/2016",' +
                                           '"edtGGMinCont":"","rgpAssenzeConsiderate":"0","rgpValidate":"2","rgpOrdinamento":"0",' +
                                           '"chkSoloAssRegSucc":"N","chkSalvaUltRegStamp":"N","chkDatiIndividuali":"S","chkStampaNominativo":"S",' +
                                           '"chkStampaMatricola":"S","chkStampaBadge":"S","chkDettGiorn":"S","chkDettPer":"N","chkSaltoPagRaggrup":"N",' +
                                           '"chkSaltoPagIndividuale":"N","chkConiuge":"N","chkRiduzioni":"N","chkSoloRiduzioni":"N",' +
                                           '"chkConteggiGG":"N","chkGiorniSignificativi":"N","chkCausaliCumulate":"N","chkPeriodoServizio":"N",' +
                                           '"chkTotIndividuali":"N","chkTotRaggrup":"N","chkTotFam":"N","chkTotGenerali":"N",' +
                                           '"LstCausali":"31,M100,M100D","LstCodAcc":"","dcmbTipoAcc":"","dcmbCampo":""}',
                                           DettaglioLog
                                         );
  finally
    Free;
  end;
  *)
end;

procedure TB028FTest.Button40Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintA049('SELECT  T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO,T430AZIENDA_BASE,T430D_AZIENDA_BASE FROM ' +
                                        'T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480 ' +
                                        'WHERE T030.Progressivo = V430.T430Progressivo AND ' +
                                        'T030.ComuneNas = T480.Codice(+) AND ' +
                                        ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine ' +
                                        '/*I072*/ /*\I072*/ AND T030.TIPO_PERSONALE = ''I'' ' +
                                        'AND T030.PROGRESSIVO = 33544 ' +
                                        'AND ((T030.COGNOME = ''MELLANO'')) ' +
                                        'ORDER BY T030.COGNOME, T030.NOME, T030.MATRICOLA',
                                        'c:\temp\TestA049.pdf',
                                        'TESTR',
                                        'TESTR',
                                        'IRIS',
                                        '{"edtInizio":"01/01/2020","edtFine":"31/01/2021","dcmbRaggruppamento":"T430BADGE","chkSaltoPagina":"S","chkDettaglio":"S","CkBAggiorna":"N"}',
                                        '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TB028FTest.Button41Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintP314('SELECT  T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO,T430AZIENDA_BASE,T430D_AZIENDA_BASE FROM' + #$D#$A +
                                        'T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480' + #$D#$A +
                                        'WHERE T030.Progressivo = V430.T430Progressivo AND' + #$D#$A +
                                        'T030.ComuneNas = T480.Codice(+) AND' + #$D#$A +
                                        ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine' + #$D#$A +
                                        'AND :DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)' + #$D#$A +
                                        'AND T030.TIPO_PERSONALE = ''I''' + #$D#$A +
                                        'AND' + #$D#$A +
                                        '((T030.COGNOME BETWEEN ''AGOSTIN%'' AND ''AGOSTINO%''))' + #$D#$A +
                                        'ORDER BY T030.COGNOME, T030.NOME',
                                         'C:\Temp\TestP314.pdf',
                                        'SYSMAN',
                                        'AO1',
                                        'CL',
                                        '{"rgpStatoModelli":"1","chkUltimoTFR1":"N","chkUsaDataLavoro":"N","chkStampaEredi":"N"}',
                                         '',
                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TB028FTest.Button4Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintA043('SELECT /*+ ordered */ T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO FROM ' + CRLF +
                                        'T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480' + CRLF +
                                        'WHERE T030.Progressivo = V430.T430Progressivo AND' + CRLF +
                                        'T030.ComuneNas = T480.Codice(+) AND' + CRLF + ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine' + CRLF +
                                        'AND :DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)' + CRLF +
                                        'AND T030.TIPO_PERSONALE = ''I''' + CRLF + 'AND' + CRLF + '((T030.MATRICOLA LIKE ''12304''))' + CRLF + 'ORDER BY T030.COGNOME, T030.NOME',

                                         'c:\temp\TestA043.pdf',
                                         'NANDO',
                                         'CN1',
                                         'DBCLIENTI',

                                         '{"edtAnno":"2013","cmbMese":"5","edtDa":"1","edtA":"30","chkSalva":"N","chkIgnoraAnomalie":"N","chkSpezzoniMese":"N","chkCumula":"N","chkSoloAnomalie":"N","chkSaltoPagina":"S","rgpTipoStampa":"0","dcmbCampo":"","SoloAgg":"N"}',
                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TB028FTest.Button5Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintA074('SELECT  T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO FROM'#$D#$A'T030_Anagrafico '+
                                        'T030, V430_Storico V430, T480_Comuni T480'#$D#$A'WHERE T030.Progressivo = V430.T430Progressivo AND'#$D#$A'T030.ComuneNas = T480.Codice(+) '+
                                        'AND'#$D#$A':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine'#$D#$A'AND T030.TIPO_PERSONALE = ''I'' and COGNOME like ''DIPENDENTE%'''#$D#$A'ORDER BY T030.COGNOME, T030.NOME'
                                         ,

                                         'c:\temp\TestA074.pdf',
                                         'SYSMAN',
                                         'CORSO',
                                         'MEDP_ORCL',

                                         '{"ActiveTab":"0","edtDa":"01/08/2013","edtA":"31/08/2013","ChkDettaglio":"S","ChkAcquisto":"N","ChkInizioAnno":"N","ChkSaltoPagina":"N","ChkAggiorna":"N",' +
                                         '"ChkIgnoraAnomalie":"N","edtDataAcquisto":"10/2013","edtUltimoAcquisto":"ottobre 2013","chkAcqDatiIndividuali":"S","chkAcqSaltoPagina":"N",' +
                                         '"chkAcqAggiornamento":"N","chkFileSequenziale":"N","chkScaricoPaghe":"N","edtFileSequenziale":"","edtPwdFileSequenziale":"","dcmbParametrizzazione":"","dcmbRaggrAnagrafico":"T430ABCAUSALE1"}',

                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;

end;

procedure TB028FTest.Button6Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintA042('SELECT  T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO FROM'#$D#$A'T030_Anagrafico '+
                                        'T030, V430_Storico V430, T480_Comuni T480'#$D#$A'WHERE T030.Progressivo = V430.T430Progressivo AND'#$D#$A'T030.ComuneNas = T480.Codice(+) '+
                                        'AND'#$D#$A':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine'#$D#$A'AND T030.TIPO_PERSONALE = ''I'''#$D#$A'ORDER BY T030.COGNOME, T030.NOME'
                                         ,

                                         'c:\temp\TestA042.pdf',
                                         'SYSMAN',
                                         'AZIN',
                                         'IRIS',

                                         '{"edtDaData":"01/10/2010","edtAData":"31/10/2013","edtDaOra":"15.00","edtAOra":"18.00","rgpTipoStampa":"3","LstIntestazione":"BADGE,CAP,CITTA",'+
                                         '"LstDettaglio":"CODICE FISCALE,COMUNE","chkGiornoCorrente":"N","chkDescrizioneAssenze":"N","chkTurnista":"N","chkTabellare":"N","chkRaggData":"N",'+
                                         '"chkTotaliData":"N","chkSaltoPaginaData":"N","chkTotali":"N","chkTotaliGruppo":"N","chkSaltoPagina":"N","edtTitoloGrafico":"test","chkVisLineeV":"N","chkVisLineeH":"N"}'
                                         ,

                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TB028FTest.Button7Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintA092('SELECT  T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO FROM'#$D#$A'T030_Anagrafico '+
                                        'T030, V430_Storico V430, T480_Comuni T480'#$D#$A'WHERE T030.Progressivo = V430.T430Progressivo AND'#$D#$A'T030.ComuneNas = T480.Codice(+) '+
                                        'AND'#$D#$A':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine'#$D#$A'AND T030.TIPO_PERSONALE = ''I'''#$D#$A'ORDER BY T030.COGNOME, T030.NOME'
                                         ,

                                         'c:\temp\TestA092.pdf',
                                         'SYSMAN',
                                         'AZIN',
                                         'IRIS',

                                         '{"edtDaData":"02/10/2013","edtAData":"02/10/2013","rgpOrdinamento":"0","CgpAnagra":"BADGE,CAP,CELLULARE AZIENDALE","chkVariazioni":"N","chkSaltoPagina":"S"}',

                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TB028FTest.Button8Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintA081('SELECT  T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO FROM'#$D#$A'T030_Anagrafico '+
                                        'T030, V430_Storico V430, T480_Comuni T480'#$D#$A'WHERE T030.Progressivo = V430.T430Progressivo AND'#$D#$A'T030.ComuneNas = T480.Codice(+) '+
                                        'AND'#$D#$A':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine'#$D#$A'AND T030.TIPO_PERSONALE = ''I'''#$D#$A'ORDER BY T030.COGNOME, T030.NOME'
                                         ,

                                         'c:\temp\TestA081.pdf',
                                         'SYSMAN',
                                         'AZIN',
                                         'IRIS',

                                         '{"edtDaData":"01/10/2013","edtAData":"31/10/2013","chkTotGenerale":"S","chkTotRaggr":"S","chkTotCaus":"N","chkTotData":"N","chkStampaDett":"S","chkSaltoRaggr":"N","chkSaltoCaus":"N","CgpListaCausali":"0ASS+,1S,1SC","dcmbCampoRaggr":"CAPNAS"}',

                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TB028FTest.Button9Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintA090('SELECT  T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO FROM'#$D#$A'T030_Anagrafico '+
                                        'T030, V430_Storico V430, T480_Comuni T480'#$D#$A'WHERE T030.Progressivo = V430.T430Progressivo AND'#$D#$A'T030.ComuneNas = T480.Codice(+) '+
                                        'AND'#$D#$A':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine'#$D#$A'AND T030.TIPO_PERSONALE = ''I'''#$D#$A'ORDER BY T030.COGNOME, T030.NOME'
                                         ,

                                         'c:\temp\TestA090.pdf',
                                         'SYSMAN',
                                         'AZIN',
                                         'IRIS9',

                                         '{"edtDaAnno":"2009","edtDaMese":"9","edtAMese":"9","edtTitolo":"Stampa situazione assenze dal <DAL> al <AL>","edtFirma":"Il Responsabile","edtCaratteri":"***","edtLogoLarghezza":"271","edtLogoAltezza":"86","chkSegnalazPresenza":"S",'+
                                         '"chkSecCausaleAss":"S","chkRigaValoriz":"S","chkTotIndiv":"S","chkRiepilogoCompetenze":"N","chkSaltoPag":"S","chkStampaAllDip":"S","chkGGSett":"N","chkIntestazione":"S","chkData":"S",'+
                                         '"chkNumPagina":"S","chkAzienda":"S","CgpListaAnagr":"BADGE,CALEN,CAP,CAP N,CELLU,CELLU,CELLU,CENTR,CENTR,CENTR,CITTA,COD P,COD P,COD P,COD P,COD Q,COD Q,COD Q,'+
                                         'COD R,COD R,COD S,COD S,COD S,COD S,COD S,COD S,COD S,COD T,COD T,CODIC,COGNO,COMUN,COMUN,CONTR,CREDI,DATA,DATA,DATA,DATO,DIPAR,DISCI,DISTR,DOCEN,DOMIC,D_PAS,'+
                                         'D_PRO,INIZI,INIZI,MATRI,NOME,PART,POSIZ,PRESI,PROFE,PROGR,PROVI,QUAL,QUALI,QUALI,QUAL_,RAPPO,SCAD.,SESSO,SQUAD,STRUT,T430A,T430A,T430A,T430A,T430B,T430C,T430C,'+
                                         'T430C,T430C,T430C,T430C,T430C,T430C,T430C,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,'+
                                         'T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,'+
                                         'T430D,T430E,T430E,T430E,T430E,T430E,T430E,T430F,T430F,T430F,T430H,T430I,T430I,T430I,T430I,T430I,T430L,T430M,T430M,T430M,T430M,T430N,T430O,T430P,T430P,T430P,T430P,'+
                                         'T430P,T430P,T430P,T430P,T430P,T430P,T430P,T430P,T430P,T430P,T430P,T430Q,T430R,T430R,T430S,T430S,T430S,T430S,T430S,T430T,T430T,T430T,T430T,T430T,T430T,T430T,T430U,'+
                                         'T430U,T430U,TELEF","CgpListaCausali":"00FER,00M10,00RIP,018,034,09999,0CGA,0FERI,0M100,0M10B,0REF,0RIP,1028,1028A,1029,1029A,10FER,10M10,10RIP,11,14,15,150,16,16P,'+
                                         '17,18,19,1CGA,1FERI,1M100,1REF,20,20FER,23,2FERI,49,4AFAC,4_AGG,50,51,52,54,55,A11,ALL,AMF,APP01,BV010,BV051,BV0RD,BV0RE,BV104,BVFSF,BVRSC,C000,C000P,C030,C1,C100,'+
                                         'C1050,C1090,C1100,C15,C2,C2050,C2090,C2100,CD0M0,CDFM3,CDM1,CDM1B,CDM5,CDM5B,CDM9,CDM9B,CPDR,EE0*P,EE0*R,EE0A0,EE0E0,EE0F0,EE0F8,EE0M0,EE0MA,EE0OS,EE0P0,EE0P1,EE0P2,'+
                                         'EE0P3,EE0R0,EE1*P,EE1A0,EE1F0,EE1P0,EE2*P,EE2F0,EE2P0,EE3P0,F30,FERI2,FERI3,FERIE,FFF,FSV1,FSV2,FSV3,FSV4,GP010,GP020,GP021,GP031,GP039,GP040,GP041,GP042,GP043,GP055,'+
                                         'GP110,GP121,GP140,GP141,GP155,GP1OR,GP210,GP221,GP241,GREP,H42,ITCAL,L104,LICM,LS01,LS02,M0,M000,M050,M090,M100,M100B,M50,M50B,M90,M90B,MAL,MALAT,MALF3,MAR,MN010,MOI,'+
                                         'MR100,MR50,MR90,MRNR,OSP,PA0*P,PA0*R,PA0A0,PA0AF,PA0AG,PA0AR,PA0CN,PA0CO,PA0E0,PA0F0,PA0F1,PA0F4,PA0F5,PA0F6,PA0F7,PA0F8,PA0F9,PA0FE,PA0FS,PA0LU,PA0M0,PA0M1,PA0M2,'+
                                         'PA0MA,PA0OS,PA0P0,PA0P1,PA0PE,PA0R0,PA0RE,PA0RI,PA0RP,PA0V0,PA0X0,PA1*P,PA1A0,PA1AG,PA1E0,PA1F0,PA1F1,PA1F6,PA1FE,PA1M1,PA1P0,PA1RE,PA1RI,PA1RP,PA2*P,PA2F0,PA2P0,'+
                                         'PA2RE,PA2RI,PA3P0,PA4P0,PB0*P,PB0*R,PB002,PB010,PB051,PB070,PB091,PB092,PB0A0,PB0CS,PB0E0,PB0F0,PB0F7,PB0F8,PB0F9,PB0FS,PB0M1,PB0M2,PB0MA,PB0P0,PB0R,PB0R0,PB0RI,'+
                                         'PB0SA,PB1*P,PB1*R,PB101,PB109,PB110,PB111,PB170,PB191,PB193,PB1E0,PB1F0,PB1F7,PB1F8,PB1MA,PB1P0,PB1R0,PB210,PB270,PB293,PB2A0,PB2E0,PB2F0,PB2P0,PB310,PB370,PB390,'+
                                         'PB3E0,PB410,PB470,PB510,PB570,PB610,PB690,PB710,PB810,PB910,PRET,PRMF,PRO,PROVA,PT,PTV,R,R01,RANN,RASTI,RCH,RED,REF,RIP,RIPF,RIPFS,RIPOS,ROS,RPA,RPA_,RPP,T,X-001,X-002,X-003,X-004,X-005,X-006,X-007,X-008,X-009,ZZFER"}'
                                         ,

                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TB028FTest.Button10Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintA116('SELECT T030.*,T480.CITTA,T480.PROVINCIA,V430.T430BADGE,V430.T430INIZIO,V430.T430FINE,V430.T430DATADECORRENZA,V430.T430DATAFINE' + CRLF +
                                         'FROM T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480' + CRLF +
                                         'WHERE T030.Progressivo = V430.T430Progressivo AND T030.ComuneNas = T480.Codice(+) AND :DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine' + CRLF +
                                         'AND :DATALAVORO BETWEEN T430INIZIO AND NVL(LAST_DAY(T430FINE),:DATALAVORO) AND (T030.COGNOME LIKE ''CASA%'')' + CRLF +
                                         'ORDER BY T030.COGNOME,T030.NOME,T030.MATRICOLA',

                                         'c:\temp\TestA116.pdf',
                                         'SYSMAN',
                                         'AZIN',
                                         'IRIS9',

                                         '{"edtAnno":"2012","edtData":"10/2013","edtMaxLiq":"00.00","edtArrotLiq":"0","chkAbbattimentoOre":"S","chkSaltoPag":"S","chkTotaliRaggr":"S","chkTotaliGen":"S","chkCessati":"S",' +
                                         '"cgpIntestazione":"CAP,CELLULARE AZIENDALE,CELLULARE PERSONALE3","cgpDettaglio":"CALENDARIO,CAP NASCITA,CELLULARE PERSONALE 2","SoloAgg":"N"}',

                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TB028FTest.Button11Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintA077((*'SELECT  T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO ,V430.T430BADGE,V430.T430INIZIO,V430.T430FINE,'+
                                         'V430.T430DATADECORRENZA,V430.T430DATAFINE FROM T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480 WHERE '+
                                         'T030.Progressivo = V430.T430Progressivo AND T030.ComuneNas = T480.Codice(+) AND :DataLavoro BETWEEN V430.T430DataDecorrenza '+
                                         'AND V430.T430DataFine AND T030.TIPO_PERSONALE = ''I'' AND ((T030.MATRICOLA LIKE ''4444'')) ORDER BY T030.COGNOME,'+
                                         ' T030.NOME'*)
                                         'SELECT  T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO ,V430.T430BADGE,V430.T430INIZIO,V430.T430FINE,'+
                                         'V430.T430DATADECORRENZA,V430.T430DATAFINE FROM T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480 WHERE '+
                                         'T030.Progressivo = V430.T430Progressivo AND T030.ComuneNas = T480.Codice(+) AND :DataLavoro BETWEEN V430.T430DataDecorrenza '+
                                         'AND V430.T430DataFine AND T030.PROGRESSIVO IN (   SELECT /*+  UNNEST */ PROGRESSIVO FROM T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480 '+
                                         'WHERE T030.Progressivo = V430.T430Progressivo AND T030.ComuneNas = T480.Codice(+) '+
                                         'AND :DATALAVORO >= T430DATADECORRENZA AND :C700DATADAL <= T430DATAFINE AND :DATALAVORO >= T430INIZIO AND :C700DATADAL <= NVL(T430FINE,:DATALAVORO) '+
                                         'AND T030.TIPO_PERSONALE = ''I'' AND (T030.COGNOME IN (''ABD EL KRIEM'')) ) ORDER BY T030.COGNOME, T030.NOME'
                                         ,

                                         'c:\temp\TestA077.pdf',
                                         'MONDOEDP',
                                         'SGIULIANO_MI',
                                         'SGIULIANO_MI.WORLD',

                                         '{"edtDal":"01/04/2015","edtAl":"30/04/2015","CodiceStampa":"_ASSPRES"}',

                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TB028FTest.Button12Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintA059( 'c:\temp\TestA059.pdf',
                                         'SYSMAN',
                                         'DEMO',
                                         'DBCLIENTI',
                                         '{"edtDataDa":"01/01/2018","edtDataA":"31/01/2018","cmbCodSquadraDa":"A","cmbCodSquadraA":"PROVAPROVA","rgpModalita":"0","rgpTipo":"0"}',
                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TB028FTest.Button13Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintA068('SELECT  T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO,T430SQUADRA,'+
                                        'T430D_SQUADRA FROM T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480 WHERE T030.Progressivo = V430.T430Progressivo '+
                                        'AND T030.ComuneNas = T480.Codice(+) AND :DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine AND T030.TIPO_PERSONALE '+
                                        '= ''I'' ORDER BY T030.COGNOME, T030.NOME'
                                         ,

                                         'c:\temp\TestA068.pdf',
                                         'SYSMAN',
                                         'AZIN',
                                         'IRIS',

                                         '{"edtData":"11/11/2013","edtIntestazione":"Settore test","rgpTPianif":"1"}',

                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TB028FTest.Button14Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintA058(  'SELECT  T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO,T430AZIENDA_BASE,T430D_AZIENDA_BASE  FROM' + CRLF +
                                          'T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480' + CRLF +
                                          'WHERE T030.Progressivo = V430.T430Progressivo AND' + CRLF +
                                          'T030.ComuneNas = T480.Codice(+) AND' + CRLF +
                                          ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine' + CRLF +
                                          'AND :DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)' + CRLF +
                                          'AND (((' + CRLF +
                                          '/*I072*/' + CRLF +
                                          '1 = 1' + CRLF +
                                          '/*\I072*/' + CRLF +
                                          'AND T030.TIPO_PERSONALE = ''I''' + CRLF +
                                          'AND' + CRLF +
                                          '((V430.T430SQUADRA LIKE ''CARDI''))' + CRLF +
                                          ')' + CRLF +
                                          ' or exists (select ''X''' + CRLF +
                                          '              from T630_SPOSTSQUADRA T630' + CRLF +
                                          '             where T630.PROGRESSIVO = T030.PROGRESSIVO' + CRLF +
                                          '               and T630.DATA between :A058DATADA and :A058DATAA' + CRLF +
                                          '               and T630.SQUADRA = :A058SQUADRA)' + CRLF +
                                          '))' + CRLF + CRLF +
                                          'order by V430.T430SQUADRA, V430.T430TIPOOPE, T030.COGNOME, T030.NOME' + CRLF
                                         ,

                                         'c:\temp\TestA058.pdf',
                                         'SYSMAN',
                                         'DEMO',
                                         'DBCLIENTI',
                                         '{"StandardPrinter":"N","edtDataDa":"01/05/2017","edtDataA":"31/05/2017","rgpTipo":"1","dcmbsquadra":"CARDI","chkIncludiDipCS":"S","dcmbProfili":"02"}',
                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TB028FTest.Button15Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintA105('SELECT T030.*,T480.CITTA,T480.PROVINCIA,V430.T430BADGE,V430.T430INIZIO,V430.T430FINE,V430.T430DATADECORRENZA,V430.T430DATAFINE' + CRLF +
                                         'FROM T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480' + CRLF +
                                         'WHERE T030.Progressivo = V430.T430Progressivo AND T030.ComuneNas = T480.Codice(+) AND :DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine' + CRLF +
                                         'AND :DATALAVORO BETWEEN T430INIZIO AND NVL(LAST_DAY(T430FINE),:DATALAVORO) AND ((T030.MATRICOLA IN (''2'',''1968'')))' + CRLF +
                                         'ORDER BY T030.COGNOME,T030.NOME,T030.MATRICOLA',

                                         'c:\temp\TestA105.pdf',
                                         'SYSMAN',
                                         'AZIN',
                                         'IRIS9',

                                         '{"edtDaData":"01/11/2010","edtAData":"30/11/2013","dcmbCampo":"","StatoPaghe":"",'+
                                         '"chkRecordFisici":"S","chkAssenzeInserite":"S","chkAssenzeCancellate":"S","chkDettaglioGiornaliero":"N","chkDettaglioPeriodico":"S","chkDatiIndividuali":"S",'+
                                         '"chkSaltoPaginaIndividuale":"S","chkSaltoPaginaRaggr":"N","chkTotaliIndividuali":"S","chkTotaliRaggr":"N","chkTotaliGenerali":"S",'+
                                         '"clbCausali":"14,16P,APP01,MAL,CDM5"}',

                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TB028FTest.Button16Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintA051('SELECT T030.*,T480.CITTA,T480.PROVINCIA,V430.T430BADGE,V430.T430INIZIO,V430.T430FINE,V430.T430DATADECORRENZA,V430.T430DATAFINE' + CRLF +
                                         'FROM T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480' + CRLF +
                                         'WHERE T030.Progressivo = V430.T430Progressivo AND T030.ComuneNas = T480.Codice(+) AND :DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine' + CRLF +
                                         'AND :DATALAVORO BETWEEN T430INIZIO AND NVL(LAST_DAY(T430FINE),:DATALAVORO) AND ((T030.MATRICOLA IN (''2'',''1968'')))' + CRLF +
                                         'ORDER BY T030.COGNOME,T030.NOME,T030.MATRICOLA',

                                         'c:\temp\TestA051.pdf',
                                         'SYSMAN',
                                         'AZIN',
                                         'IRIS',

                                         '{"edtAnno":"2014","cmbMese":"1","edtDa":"01","edtA":"28","chkSaltoPagina":"S","rgpTimbrature":"0","dcmbCampoRaggr":"CITTA"}',

                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;


procedure TB028FTest.Button17Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintA104('SELECT T030.*,T480.CITTA,T480.PROVINCIA,V430.T430BADGE,V430.T430INIZIO,V430.T430FINE,V430.T430DATADECORRENZA,V430.T430DATAFINE' + CRLF +
                                         'FROM T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480' + CRLF +
                                         'WHERE T030.Progressivo = V430.T430Progressivo AND T030.ComuneNas = T480.Codice(+) AND :DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine' + CRLF +
                                         'AND :DATALAVORO BETWEEN T430INIZIO AND NVL(LAST_DAY(T430FINE),:DATALAVORO)' + CRLF +
                                         'ORDER BY T030.COGNOME,T030.NOME,T030.MATRICOLA',

                                         'c:\prova_s.txt',
                                         'SYSMAN',
                                         'AZIN',
                                         'IRIS',
                                         '{"TXT":"S","edtMeseScaricoDa":"01/2014","edtMeseScaricoA":"12/2014","edtStato":"D,S","ChkSaltoPagina":"S","EdtTitolo":"RIEPILOGO LIQUIDAZIONI MENSILI"}',
                                         '');
    (*DCOMConnection1.AppServer.PrintA104('SELECT T030.*,T480.CITTA,T480.PROVINCIA,V430.T430BADGE,V430.T430INIZIO,V430.T430FINE,V430.T430DATADECORRENZA,V430.T430DATAFINE' + CRLF +
                                         'FROM T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480' + CRLF +
                                         'WHERE T030.Progressivo = V430.T430Progressivo AND T030.ComuneNas = T480.Codice(+) AND :DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine' + CRLF +
                                         'AND :DATALAVORO BETWEEN T430INIZIO AND NVL(LAST_DAY(T430FINE),:DATALAVORO) AND ((T030.MATRICOLA IN (''2'',''1968'')))' + CRLF +
                                         'ORDER BY T030.COGNOME,T030.NOME,T030.MATRICOLA',

                                         'c:\temp\TestA051.pdf',
                                         'SYSMAN',
                                         'AZIN',
                                         'IRIS',
                                         '{"edtMeseScaricoDa":"02/2014","edtMeseScaricoA":"02/2014","edtStato":"D,S","ChkSaltoPagina":"S","EdtTitolo":"RIEPILOGO LIQUIDAZIONI MENSILI"}',
                                         ''); *)
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TB028FTest.Button18Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintA047('SELECT T030.*,T480.CITTA,T480.PROVINCIA,V430.T430BADGE,V430.T430INIZIO,V430.T430FINE,V430.T430DATADECORRENZA,V430.T430DATAFINE' + CRLF +
                                         'FROM T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480' + CRLF +
                                         'WHERE T030.Progressivo = V430.T430Progressivo AND T030.ComuneNas = T480.Codice(+) AND :DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine' + CRLF +
                                         'AND :DATALAVORO BETWEEN T430INIZIO AND NVL(LAST_DAY(T430FINE),:DATALAVORO) --AND (T030.COGNOME = ''ROSSI'')' + CRLF +
                                         'ORDER BY T030.COGNOME,T030.NOME,T030.MATRICOLA',

                                         'c:\temp\TestA047.pdf',
                                         'SYSMAN',
                                         'AZIN',
                                         'IRIS',
                                         '{"eDaData":"01/01/2010","eAData":"30/04/2014","rgpTipoStampa":"0","chkDatiIndividuali":"S","chkDettaglioGiornaliero":"S","chkTotaliIndividuali":"N",'+
                                         '"chkSaltoPaginaIndividuale":"N","chkTimbraturePresenza":"N","chkTimbraturePresenzaCausalizzate":"N","chkGiustificativiAssenza":"N","chkAnomalie":"N",'+
                                         '"chkNominativi":"N","chkRilevatori":"N","chkCausale":"N","chkSaltoPagina":"N","chkDistinzioneCausale":"N","chkPranzoCena":"N","edtRaggr":"COD POSIZIONE FUNZIONALE,COD PROFESSIONE","chkSaltoPaginaRaggr":"N","LstOrologi":"12,17"}',
                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TB028FTest.Button19Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintA167('SELECT  T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO ,V430.T430BADGE,V430.T430INIZIO,V430.T430FINE,'+
                                         'V430.T430DATADECORRENZA,V430.T430DATAFINE FROM T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480 WHERE '+
                                         'T030.Progressivo = V430.T430Progressivo AND T030.ComuneNas = T480.Codice(+) AND :DataLavoro BETWEEN V430.T430DataDecorrenza '+
                                         'AND V430.T430DataFine AND T030.TIPO_PERSONALE = ''I'' AND ((T030.MATRICOLA LIKE ''4444'')) ORDER BY T030.COGNOME,'+
                                         ' T030.NOME',
                                         'c:\temp\TestA167.pdf',
                                         'SYSMAN',
                                         'AZIN',
                                         'IRIS',
                                         '{"edtDaData":"01/2014","edtAData":"12/2014","edtMeseCompMax":"12/2014","cmbTipoCalcolo":"A",' +
                                         '"edtQuote":"1,3,5,6","cmbCampoAnag":"","chkSaltoPagina":"N","chkDettaglio":"S","rgpTipoDati":"0","cgpColonne":"Quota intera [1],Quota netta + Risp. [4]","chkAggiorna":"N","chkAnnulla":"N","SoloAgg":"N"}',
                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TB028FTest.Button22Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintA065('',
                                        'c:\temp\TestA065.pdf',
                                        'SYSMAN',
                                        'AZIN',
                                        'IRIS9',
                                        '{"sedtAnno":"2011","cmbDaMese":"0","cmbAMese":"10","dcmbTipo":"#LIQ#","clbGruppi":"a          #LIQ# 01-09,a          #LIQ# 11-12","rgpTipoBudget":"0"' +
                                        '"chkSaltoPagina":"S","chkAggiornaFruito":"S","chkDettaglioDipendenti":"S","chkTotMese":"S","chkCostoInMoneta":"S","chkTotGruppo":"S","chkTotGenerale":"S"}',
                                        '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TB028FTest.Button23Click(Sender: TObject);
var
 sql, json: string;
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    {sql:='SELECT  T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO,T430AZIENDA_BASE,T430D_AZIENDA_BASE,T030.COGNOME||'' ''||T030.NOME NOMINATIVO, T430CONTRATTO, T430D_CONTRATTO,T430SQUADRA,CODFISCALE FROM'#$D#$A'T030_Anagrafico T030, ' +
         'V430_Storico V430, T480_Comuni T480'#$D#$A'WHERE T030.Progressivo = V430.T430Progressivo AND'#$D#$A'T030.ComuneNas = T480.Codice(+) AND'#$D#$A':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine'#$D#$A'/*I072*/'#$D#$A'/*\I072*/'#$D#$A'AND ' +
         'T030.TIPO_PERSONALE = ''I'''#$D#$A'ORDER BY T030.COGNOME, T030.NOME, T030.MATRICOLA';}

    sql:='SELECT /*+ ordered */ T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO,T430AZIENDA_BASE,T430D_AZIENDA_BASE,T030.COGNOME||'' ''||T030.NOME NOMINATIVO, T430CONTRATTO, T430D_CONTRATTO FROM ' +
         'T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480 ' +
         'WHERE T030.Progressivo = V430.T430Progressivo AND ' +
         'T030.ComuneNas = T480.Codice(+) AND ' +
         ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine ' +
         'AND :DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO) ' +
         'AND ' +
         '/*I072*/ ' +
         '(T430COORDINATORE_CS = ''gfuoco'' ' +
         ') ' +
         'AND /*A000*/:DataLavoro BETWEEN T430INIZIO AND ADD_MONTHS(LAST_DAY(NVL(T430FINE,TO_DATE(''31123999'',''DDMMYYYY''))),0)/*\A000*/ ' +
         '/*\I072*/ ' +
         'AND T030.TIPO_PERSONALE = ''I'' ' +
         'AND ' +
         '((T030.COGNOME LIKE ''AMATO'')) ' +
         'ORDER BY T030.COGNOME, T030.NOME, T030.MATRICOLA';
         //TEST PROSPETTO DIP DA WEB
    sql:='SELECT T030.*,T480.CITTA,T480.PROVINCIA,V430.T430BADGE FROM ' +
         'T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480 ' +
         'WHERE T030.Progressivo = V430.T430Progressivo AND ' +
         'T030.ComuneNas = T480.Codice(+) AND ' +
         ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine ' +
         'AND ((:DATALAVORO BETWEEN T430INIZIO AND NVL(LAST_DAY(T430FINE),:DATALAVORO)) OR (EXISTS (SELECT ''X'' ' +
         'FROM   VT050_ITER_RICHIESTEASSENZA WHERE PROGRESSIVO = T030.PROGRESSIVO AND T850STATO IS NULL AND T850DATA >= T430INIZIO))) ' +
         'AND ' +
         '/*I072*/ ' +
         '(NOT T030.MATRICOLA IS NULL ' +
         ') ' +
         '/*\I072*/ ' +
         ' ORDER BY T030.COGNOME,T030.NOME,T030.MATRICOLA';
         //TEST PROSPETTO DIP DA CLOUD
    sql:='SELECT  T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO,T430AZIENDA_BASE,T430D_AZIENDA_BASE,T030.COGNOME||'' ''||T030.NOME NOMINATIVO, T430CONTRATTO, T430D_CONTRATTO,T430SQUADRA,CODFISCALE FROM ' +
         'T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480 ' +
         'WHERE T030.Progressivo = V430.T430Progressivo AND ' +
         'T030.ComuneNas = T480.Codice(+) AND ' +
         ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine ' +
         '/*I072*/ ' +
         '/*\I072*/ ' +
         'AND T030.TIPO_PERSONALE = ''I'' ' +
         'AND ' +
         '((T030.MATRICOLA IN (''2'',''25''))) ' +
         'ORDER BY T030.MATRICOLA, T030.COGNOME, T030.NOME';

    sql:='SELECT T030.*,T480.CITTA,T480.PROVINCIA,V430.T430BADGE FROM ' +
         'T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480 ' +
         'WHERE T030.Progressivo = V430.T430Progressivo AND ' +
         'T030.ComuneNas = T480.Codice(+) AND ' +
         ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine ' +
         'AND :DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO) ' +
         'AND :DATALAVORO BETWEEN T430INIZIO AND NVL(LAST_DAY(T430FINE),:DATALAVORO) ' +
         'AND ' +
         '/*I072*/ ' +
         '(''michele.fasciana'' =  V430.T430WEB_RESP ' +
         ') ' +
         '/*\I072*/ ' +
         ' ORDER BY T030.COGNOME,T030.NOME,T030.MATRICOLA';

    sql:='SELECT T030.*,T480.CITTA,T480.PROVINCIA,V430.T430BADGE FROM ' +
         'T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480 ' +
         'WHERE T030.Progressivo = V430.T430Progressivo AND ' +
         'T030.ComuneNas = T480.Codice(+) AND ' +
         ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine ' +
         'AND ((:DATALAVORO BETWEEN T430INIZIO AND NVL(LAST_DAY(T430FINE),:DATALAVORO)) OR (EXISTS (SELECT ''X'' FROM VT050_ITER_RICHIESTEASSENZA WHERE PROGRESSIVO = T030.PROGRESSIVO AND T850STATO IS NULL AND T850DATA >= T430INIZIO))) ' +
         'AND ' +
         '/*I072*/ ' +
         '(NOT T030.MATRICOLA IS NULL ' +
         ') ' +
         '/*\I072*/ ' +
         ' ORDER BY T030.COGNOME,T030.NOME,T030.MATRICOLA';

    json:='{"StandardPrinter":"N","CodTipologia":"R","edtAnno":"2021","edtMese":"4","rgpTipoStampa":"1","edtDataDa":"01/04/2021","edtDataA":"30/04/2021","edtTitolo":"TITOLOTITOLOTITOLOOOOO","dcmbCampoRaggr":"T430D_CALENDARIO",';
    json:=json + '"chkSaltoPagina":"N","rgpSelTurni":"0","edtTurni":"11,115","';
    json:=json + 'dcmbCampoConNom":"MATRICOLA","chkNomeCompleto":"N","chkIncludiNonPianif":"S","chkLegenda":"N","chkCodice":"S","chkSigla":"N","chkPriorita":"N","chkOrario":"S","chkOrarioInRiga":"N","chkDatoLibero":"S",';
    json:=json + '"chkDatiAggiuntivi":"N","chkDatiAggInRiga":"N","rgpDatiAssenza":"0","edtSiglaAssenza":';
    json:=json + '"","dcmbCampoDett":"","cmbFontName":"Comic Sans MS","cmbFontSize":"8","cmbOrientamentoPag":"Verticale","cmbFormatoPag":"17","cmbFontTitoloSize":"21","chkTitoloBold":"N","chkTitoloUnderline":"S"}';

    json:='{"StandardPrinter":"N","CodTipologia":"R","edtAnno":"2021","edtMese":"4","rgpTipoStampa":"1","edtDataDa":"01/04/2021","edtDataA":"30/04/2021","edtTitolo":"TITOLOTITOLOTITOLO","dcmbCampoRaggr":"T430D_CALENDARIO",';
    json:=json + '"chkSaltoPagina":"N","rgpSelTurni":"0","edtTurni":"009,09,1,11,115,120,17,2,20,21,24H,409,F,GET1,PAR2,X","';
    json:=json + 'dcmbCampoConNom":"MATRICOLA","chkNomeCompleto":"N","chkIncludiNonPianif":"S","chkLegenda":"N","chkCodice":"S","chkSigla":"N","chkPriorita":"N","chkOrario":"S","chkOrarioInRiga":"N","chkDatoLibero":"S",';
    json:=json + '"chkDatiAggiuntivi":"N","chkDatiAggInRiga":"N","rgpDatiAssenza":"0","edtSiglaAssenza":"","dcmbCampoDett":"",';
    json:=json + '"cmbFontName":"Cambria","cmbFontSize":"8","cmbOrientamentoPag":"Orizzontale","cmbFormatoPag":"10","cmbFontTitoloSize":"14","chkTitoloBold":"S","chkTitoloUnderline":"S"}';

    json:='{"StandardPrinter":"N","CodTipologia":"R","edtAnno":"2021","edtMese":"4","rgpTipoStampa":"2","edtDataDa":"01/04/2021","edtDataA":"30/04/2021","edtTitolo":"Turni di reperibilità","dcmbCampoRaggr":"",';
    json:=json + '"chkSaltoPagina":"N","rgpSelTurni":"0","edtTurni":"CA02,CA06,R072,R075","dcmbCampoConNom":"","chkNomeCompleto":"N","chkIncludiNonPianif":"N","chkLegenda":"N","chkCodice":"N","chkSigla":"N",';
    json:=json + '"chkPriorita":"N","chkOrario":"N","chkOrarioInRiga":"N","chkDatoLibero":"N","chkDatiAggiuntivi":"N","chkDatiAggInRiga":"N","rgpDatiAssenza":"0","edtSiglaAssenza":"","dcmbCampoDett":"",';
    json:=json + '"cmbFontName":"Courier New","cmbFontSize":"8","cmbOrientamentoPag":"Orizzontale","cmbFormatoPag":"10","cmbFontTitoloSize":"10","chkTitoloBold":"S","chkTitoloUnderline":"N"}';

    json:='{"StandardPrinter":"N","CodTipologia":"R","edtAnno":"2021","edtMese":"4","rgpTipoStampa":"2","edtDataDa":"01/04/2021","edtDataA":"30/04/2021","edtTitolo":"Turni di reperibilità","dcmbCampoRaggr":"",';
    json:=json + '"chkSaltoPagina":"N","rgpSelTurni":"0","edtTurni":"CA02,CA06,R072,R075","dcmbCampoConNom":"","chkNomeCompleto":"N","chkIncludiNonPianif":"N","chkLegenda":"N","chkCodice":"N","chkSigla":"N","chkPriorita":"';
    json:=json + 'N","chkOrario":"N","chkOrarioInRiga":"N","chkDatoLibero":"N","chkDatiAggiuntivi":"N","chkDatiAggInRiga":"N","rgpDatiAssenza":"0","edtSiglaAssenza":"","dcmbCampoDett":"","cmbFontName":"Courier New","cmbFont';
    json:=json + 'Size":"8","cmbOrientamentoPag":"Orizzontale","cmbFormatoPag":"10","cmbFontTitoloSize":"10","chkTitoloBold":"S","chkTitoloUnderline":"N","rgpCampoDettaglio":"1"}';

    //RECAPITO ALTERNATIVO
    json:='{"StandardPrinter":"N","CodTipologia":"R","edtAnno":"2021","edtMese":"4","rgpTipoStampa":"2","edtDataDa":"01/04/2021","edtDataA":"30/04/2021","edtTitolo":"Turni di reperibilità","dcmbCampoRaggr":"",';
    json:=json + '"chkSaltoPagina":"N","rgpSelTurni":"0","edtTurni":"CA02,CA06,R072,R075","dcmbCampoConNom":"","chkNomeCompleto":"N","chkIncludiNonPianif":"N","chkLegenda":"N","chkCodice":"N","chkSigla":"N","chkPriorita":"N",';
    json:=json + '"chkOrario":"N","chkOrarioInRiga":"N","chkDatoLibero":"N","chkDatiAggiuntivi":"N","chkDatiAggInRiga":"N","rgpDatiAssenza":"0","edtSiglaAssenza":"","dcmbCampoDett":"CODFISCALE","cmbFontName":"Courier New",';
    json:=json + '"cmbFontSize":"8","cmbOrientamentoPag":"Orizzontale","cmbFormatoPag":"10","cmbFontTitoloSize":"10","chkTitoloBold":"S","chkTitoloUnderline":"N","rgpCampoDettaglio":"1"}';


    //DATO ANAGRAFICO (COD FISCALE)
    //json:='{"StandardPrinter":"N","CodTipologia":"R","edtAnno":"2021","edtMese":"4","rgpTipoStampa":"2","edtDataDa":"01/04/2021","edtDataA":"30/04/2021","edtTitolo":"Turni di reperibilità","dcmbCampoRaggr":"",';
    //json:=json + '"chkSaltoPagina":"N","rgpSelTurni":"0","edtTurni":"CA02,CA06,R072,R075","dcmbCampoConNom":"","chkNomeCompleto":"N","chkIncludiNonPianif":"N","chkLegenda":"N","chkCodice":"N","chkSigla":"N","chkPriorita":"N",';
    //json:=json + '"chkOrario":"N","chkOrarioInRiga":"N","chkDatoLibero":"N","chkDatiAggiuntivi":"N","chkDatiAggInRiga":"N","rgpDatiAssenza":"0","edtSiglaAssenza":"","dcmbCampoDett":"CODFISCALE","cmbFontName":"Courier New",';
    //json:=json + '"cmbFontSize":"8","cmbOrientamentoPag":"Orizzontale","cmbFormatoPag":"10","cmbFontTitoloSize":"10","chkTitoloBold":"S","chkTitoloUnderline":"N","rgpCampoDettaglio":"1"}';

    //JSON PROSP DIP DA WEB
    json:='{"StandardPrinter":"N","CodTipologia":"R","edtAnno":"2021","edtMese":"5","rgpTipoStampa":"2","edtDataDa":"01/05/2021","edtDataA":"31/05/2021","edtTitolo":"","dcmbCampoRaggr":"MATRICOLA",';
    json:=json + '"chkSaltoPagina":"N","rgpSelTurni":"0","edtTurni":"1,11,120,24H","dcmbCampoConNom":"","chkNomeCompleto":"S","chkIncludiNonPianif":"S","chkLegenda":"N","chkCodice":"N","chkSigla":"N",';
    json:=json + '"chkPriorita":"N","chkOrario":"N","chkOrarioInRiga":"N","chkDatoLibero":"N","chkDatiAggiuntivi":"N","chkDatiAggInRiga":"N","rgpDatiAssenza":"0","edtSiglaAssenza":"ASS","dcmbCampoDett":';
    json:=json + '"","cmbFontName":"Courier New","cmbFontSize":"8","cmbOrientamentoPag":"(non impostato)","cmbFormatoPag":"0","cmbFontTitoloSize":"10","chkTitoloBold":"S","chkTitoloUnderline":"N",';
    json:=json + '"rgpCampoDettaglio":"0"}';
    //JSON PROSP DIP DA CLOUD
    json:='{"StandardPrinter":"N","CodTipologia":"R","edtAnno":"2021","edtMese":"5","rgpTipoStampa":"2","edtDataDa":"01/05/2021","edtDataA":"31/05/2021","edtTitolo":"Prospetto per dipendente",';
    json:=json + '"dcmbCampoRaggr":"MATRICOLA","chkSaltoPagina":"N","rgpSelTurni":"0","edtTurni":"1,2,24H,09","dcmbCampoConNom":"MATRICOLA","chkNomeCompleto":"S","chkIncludiNonPianif":"S","chkLegenda":"S",';
    json:=json + '"chkCodice":"S","chkSigla":"N","chkPriorita":"N","chkOrario":"S","chkOrarioInRiga":"S","chkDatoLibero":"N","chkDatiAggiuntivi":"N","chkDatiAggInRiga":"N","rgpDatiAssenza":"0",';
    json:=json + '"edtSiglaAssenza":"","dcmbCampoDett":"","cmbFontName":"Courier New","cmbFontSize":"8","cmbOrientamentoPag":"(non impostato)","cmbFormatoPag":"0","cmbFontTitoloSize":"10",';
    json:=json + '"chkTitoloBold":"N","chkTitoloUnderline":"N","rgpCampoDettaglio":"1"}';

    json:='{"StandardPrinter":"N","CodTipologia":"R","edtAnno":"2022","edtMese":"4","rgpTipoStampa":"2","edtDataDa":"01/04/2022","edtDataA":"30/04/2022","edtTitolo":"","dcmbCampoRaggr":"MATRICOLA",';
    json:=json + '"chkSaltoPagina":"N","rgpSelTurni":"0","edtTurni":"","dcmbCampoConNom":"MATRICOLA","chkNomeCompleto":"S","chkIncludiNonPianif":"S","chkLegenda":"N","chkCodice":"N","chkSigla":"N",';
    json:=json + '"chkPriorita":"N","chkOrario":"N","chkOrarioInRiga":"N","chkDatoLibero":"N","chkDatiAggiuntivi":"N","chkDatiAggInRiga":"N","rgpDatiAssenza":"0","edtSiglaAssenza":"ASS",';
    json:=json + '"dcmbCampoDett":"","cmbFontName":"Courier New","cmbFontSize":"8","cmbOrientamentoPag":"(non impostato)","cmbFormatoPag":"0","cmbFontTitoloSize":"10","chkTitoloBold":"S",';
    json:=json + '"chkTitoloUnderline":"N","rgpCampoDettaglio":"0"}';

    json:='{"StandardPrinter":"N","CodTipologia":"R","edtAnno":"2022","edtMese":"3","rgpTipoStampa":"2","edtDataDa":"01/03/2022","edtDataA":"31/03/2022","edtTitolo":"","dcmbCampoRaggr":"MATRICOLA",';
    json:=json + '"chkSaltoPagina":"N","rgpSelTurni":"0","edtTurni":"009,09,17","dcmbCampoConNom":"MATRICOLA","chkNomeCompleto":"S","chkIncludiNonPianif":"S","chkLegenda":"N","chkCodice":"N","chkSigla":"N",';
    json:=json + '"chkPriorita":"N","chkOrario":"N","chkOrarioInRiga":"N","chkDatoLibero":"N","chkDatiAggiuntivi":"N","chkDatiAggInRiga":"N","rgpDatiAssenza":"0","edtSiglaAssenza":"ASS",';
    json:=json + '"dcmbCampoDett":"","cmbFontName":"Courier New","cmbFontSize":"8","cmbOrientamentoPag":"(non impostato)","cmbFormatoPag":"0","cmbFontTitoloSize":"10","chkTitoloBold":"S",';
    json:=json + '"chkTitoloUnderline":"N","rgpCampoDettaglio":"0"}';

    DCOMConnection1.AppServer.PrintA040(sql,
                                        'c:\temp\TestA040.pdf',
                                        'davide.cerroni', //'MEDP_TEST',//'SYSMAN',
                                        'AZIN', //'TOCS',
                                        'IRIS', //'DBCLIENTI',
                                        json,
                                        '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TB028FTest.Button24Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintS404('SELECT  T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO,T430AZIENDA_BASE,T430D_AZIENDA_BASE ,V430.T430CAP ,V430.T430D_COMUNE ,V430.T430CELLULARE_AZ ,V430.T430D_QUALIFICA FROM'#$D#$A +
                                        'T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480'#$D#$A'WHERE T030.Progressivo = V430.T430Progressivo AND'#$D#$A'T030.ComuneNas = T480.Codice(+) AND'#$D#$A':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine'#$D#$A +
                                        'AND'#$D#$A'/*I072*/'#$D#$A':DataLavoro BETWEEN T430INIZIO AND ADD_MONTHS(LAST_DAY(NVL(T430FINE,TO_DATE(''31123999'',''DDMMYYYY''))),0)'#$D#$A'/*\I072*/'#$D#$A'AND T030.TIPO_PERSONALE = ''I'''#$D#$A'AND'#$D#$A'((T030.COGNOME LIKE ''A%''))'#$D#$A'ORDER BY T030.COGNOME, T030.NOME',
                                        'c:\temp\Tests404.pdf',
                                        'SYSMAN',
                                        'AZIN',
                                        'IRIS',
                                        '{"edtDaData":"01/01/1900","edtAData":"31/12/3999","chkVariazioni":"S","chkSaltoPagina":"S","chkLIntestazione":"CAP,COMUNE","chkLDettaglio":"CELLULARE AZIENDALE,QUALIFICA"}',
                                        '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TB028FTest.Button25Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintP077('SELECT  T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO,T430AZIENDA_BASE,T430D_AZIENDA_BASE ,V430.T430BADGE,V430.T430INIZIO,V430.T430FINE,V430.T430DATADECORRENZA,V430.T430DATAFINE FROM'+ #$D#$A +
                                        'T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480'+ #$D#$A +
                                        'WHERE T030.Progressivo = V430.T430Progressivo AND'+ #$D#$A +
                                        'T030.ComuneNas = T480.Codice(+) AND'+ #$D#$A +
                                        ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine'+ #$D#$A +
                                        'AND :DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)'+ #$D#$A +
                                        '/*I072*/'+ #$D#$A +
                                        '/*\I072*/'+ #$D#$A +
                                        'AND :DATALAVORO BETWEEN T430INIZIO AND NVL(T430FINE,:DATALAVORO)'+ #$D#$A +
                                        'AND T030.TIPO_PERSONALE = ''I'''+ #$D#$A +
                                        'AND'+ #$D#$A +
                                        '((T030.COGNOME LIKE ''QUINSON''))'+ #$D#$A +
                                        'ORDER BY T030.COGNOME, T030.NOME',
                                         'c:\temp\TestP077.pdf',
                                         'SYSMAN',
                                         'AO1',
                                         'DBCLIENTI',
                                         '{"edtDal":"01/12/2016","edtAl":"31/12/2016","CodiceStampa":"CEDOL Det","DropTabelleTemp":"N"}',
                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TB028FTest.Button26Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintP500('SELECT  T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO,DATANAS,P430RETRIB_MESE_PREC,T430AZIENDA_BASE FROM ' + #13#10 +
                                        'T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480' + #13#10 +
                                        'WHERE T030.Progressivo = V430.T430Progressivo AND' + #13#10 +
                                        'T030.ComuneNas = T480.Codice(+) AND' + #13#10 +
                                        ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine' + #13#10 +
                                        'AND :DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)' + #13#10 +
                                        'AND :DATALAVORO BETWEEN T430INIZIO AND NVL(T430FINE,:DATALAVORO)' + #13#10+
                                        'AND T030.TIPO_PERSONALE = ''I''' + #13#10 +
                                        'AND substr(T030.COGNOME,1,4) between ''BARA'' and ''BARG'' '+
                                        'ORDER BY T030.COGNOME, T030.NOME',
                                         'c:\temp\TestP500.pdf',
                                        'SYSMAN',
                                         'AO1',
                                         'DBCLIENTI',
                                         '{"edtDataCedolino":"12/2016","edtDataRetribuzione":"12/2016","edtDataEmissione":"","rgpTipoCedolino":"0","chkPrecalcolo":"N",' +
                                         '"chkCalcolo":"N","edtDataCambioValuta":"15/12/2016","chkStampa":"S","chkStampaPDF":"N","rgpStatoCedolini":"0","chkFilePDF":"N","chkArchiviazioneDoc":"N",'+
                                         '"chkStampaDataStampa":"N","chkStampaDataChiusuraAut":"S","chkOmettiAzienda":"N","chkStampaIndirizzo":"N","chkIndSedeServizio":"N","chkIndPrimaPagina":"N",' +
                                         '"edtDistanzaIndirizzo":"119","chkCodiciDescrizioni":"N","chkCumuloVociArretrate":"N",' +
                                         '"chkStampaOrigine":"N","chkEscludiImportiZero":"N","chkAnnullaPC":"N","chkBloccaPC":"N","chkSbloccaPC":"N","chkChiusura":"N"}',
                                         '',
                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TB028FTest.Button27Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintP273('SELECT  T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO,T430AZIENDA_BASE,T430D_AZIENDA_BASE FROM' + #$D#$A +
                                        'T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480' + #$D#$A +
                                        'WHERE T030.Progressivo = V430.T430Progressivo AND' + #$D#$A +
                                        'T030.ComuneNas = T480.Codice(+) AND' + #$D#$A +
                                        ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine' + #$D#$A +
                                        'AND :DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)' + #$D#$A +
                                        'AND :DATALAVORO BETWEEN T430INIZIO AND NVL(T430FINE,:DATALAVORO)' + #$D#$A +
                                        'AND T030.TIPO_PERSONALE = ''I''' + #$D#$A +
                                        'AND' + #$D#$A +
                                        '((T030.COGNOME BETWEEN ''BAB%'' AND ''BAG%''))' + #$D#$A +
                                        'ORDER BY T030.COGNOME, T030.NOME',
                                         'C:\Temp\TestP273.pdf',
                                        'SYSMAN',
                                        'AO1',
                                        'DBCLIENTI',
                                        '{"chkUltimoPeriodo":"N","chkDettaglioInquadr":"N","edtDallaData":"01/01/2016","edtAllaData":"18/04/2017",' +
                                        '"rgpImporto":"0","rgpMensilita":"0","dcmbCodTipoAccorp":"","filtro":""}',
                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TB028FTest.Button28Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintP700('SELECT  T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO,T430AZIENDA_BASE,T430D_AZIENDA_BASE FROM'+#$D#$A +
                                        'T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480'+#$D#$A +
                                        'WHERE T030.Progressivo = V430.T430Progressivo AND'+#$D#$A +
                                        'T030.ComuneNas = T480.Codice(+) AND'+#$D#$A +
                                        ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine'+#$D#$A +
                                        'AND :DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)'+#$D#$A +
                                        '/*I072*/'+#$D#$A +
                                        '/*\I072*/'+#$D#$A +
                                        'AND :DATALAVORO BETWEEN T430INIZIO AND NVL(T430FINE,:DATALAVORO)'+#$D#$A +
                                        'AND T030.TIPO_PERSONALE = ''I'''+#$D#$A +
                                        'AND'+#$D#$A +
                                        '((T030.COGNOME BETWEEN ''BARA%'' AND ''BARG%''))'+#$D#$A +
                                        'ORDER BY T030.COGNOME, T030.NOME',
                                        'C:\Temp\TestP700.pdf',
                                        'SYSMAN',
                                        'AO1',
                                        'DBCLIENTI.WORLD',
                                        '{"rgpTipoStampa":"0","edtMeseElab":"12/2016","rgpStatoCedolini":"0","ChkVariazioniGGINPS":"N",' +
                                        '"chkStampaPartite":"N","edtAccorpVociRif":"UNIEM","edtCodAccorpamento":"","sPv_CodiciInpsSelezionati":"''271'', ''249'', ''262''",' +
                                        '"sPv_CodiciInpsDeSelezionati":"","sPv_CodiciDM10Selezionati":"''D271'', ''D249'', ''D262''","sPv_CodiciDM10DeSelezionati":""}',
                                        '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TB028FTest.Button29Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintP710('SELECT  T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO,DATANAS,P430RETRIB_MESE_PREC,T430AZIENDA_BASE FROM ' + #13#10 +
                                        'T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480' + #13#10 +
                                        'WHERE T030.Progressivo = V430.T430Progressivo AND' + #13#10 +
                                        'T030.ComuneNas = T480.Codice(+) AND' + #13#10 +
                                        ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine' + #13#10 +
                                        'AND :DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)' + #13#10 +
                                        'AND :DATALAVORO BETWEEN T430INIZIO AND NVL(T430FINE,:DATALAVORO)' + #13#10+
                                        'AND T030.TIPO_PERSONALE = ''I''' + #13#10 +
                                        'ORDER BY T030.COGNOME, T030.NOME',
                                        'C:\Temp\TestP710.pdf',
                                        'SYSMAN',
                                        'SS1',
                                        'DBCLIENTI',
                                        '{"rgpTipoStampa":"0","edtMeseDa":"01/2015","edtMeseA":"12/2015",' +
                                        '"sPv_CodiciINAILSelezionati":"''51'', ''52'', ''54'', ''55'', ''56'', ''61'', ''62'', ''63'', ''71'', ''72'', ''73'', ''74'', ''75'', ''81'', ''82''",' +
                                        '"sPv_CodiciINAILDeSelezionati":"","sPv_CodiciPosizioniSelezionati":"''87016812/93'', ''92871357/65''","sPv_CodiciPosizioniDeSelezionati":""}',
                                        '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TB028FTest.Button30Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintA083('SELECT T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO,T430AZIENDA_BASE,T430D_AZIENDA_BASE FROM'+#$D#$A +
                                        'T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480'+#$D#$A +
                                        'WHERE T030.Progressivo = V430.T430Progressivo AND'+#$D#$A +
                                        'T030.ComuneNas = T480.Codice(+) AND'+#$D#$A +
                                        ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine'+#$D#$A +
                                        'AND :DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)'+#$D#$A +
                                        '/*I072*/'+#$D#$A +
                                        '/*\I072*/'+#$D#$A +
                                        'AND :DATALAVORO BETWEEN T430INIZIO AND NVL(T430FINE,:DATALAVORO)'+#$D#$A +
                                        'AND T030.TIPO_PERSONALE = ''I'''+#$D#$A +
                                        'AND T030.COGNOME = ''TESIO'''+#$D#$A +
                                        'ORDER BY T030.COGNOME, T030.NOME',
                                        'C:\Temp\TestA083.pdf',
                                        'SYSMAN',
                                        'CN1',
                                        'DBCLIENTI.WORLD',
                                        '{"StandardPrinter":"N","edtDataDa":"01/07/2017","edtDataA":"28/07/2017","chkSelAnagrafe":"S","chkDettaglioCompleto":"N","chkUltimoMovimento":"N",' +
                                        '"sApplicazione":"RILPRE","sAziendeChecked":"''CN1''","sOperatoriChecked":"","sMaschereChecked":"","sOperazioniChecked":"''A'', ''I'', ''B''","sCampiChecked":"1,2,4,5,6,7,8"}',
                                        '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TB028FTest.Button31Click(Sender: TObject);
var DettaglioLog: OleVariant;
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintA097('SELECT T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO,T430AZIENDA_BASE,T430D_AZIENDA_BASE,upper(T030.CODFISCALE) CODFISCALE  FROM T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480' +
                                        ' WHERE T030.Progressivo = V430.T430Progressivo AND T030.ComuneNas = T480.Codice(+) AND :DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine AND ' +
                                        '/*I072*/ :DataLavoro BETWEEN T430INIZIO AND ADD_MONTHS(LAST_DAY(NVL(T430FINE,TO_DATE(''31123999'',''DDMMYYYY''))),10) /*\I072*/ AND T030.TIPO_PERSONALE = ''I'' AND T030.CODFISCALE = ''MLLFNC57R16D005R''',

                                         'D:\SVN\Sviluppo\Eseguibili\Archivi\Cache\01bevv65n5\user\1hykpwv12vemjj0zsbgdq1jxurwn\LP_2016_con_cf_medico.xlsx',
                                         'SYSMAN',
                                         'TO2',
                                         'DBCLIENTI',

                                         '{"edtDataDa":"01/01/2016","edtDataA":"31/12/2016","rgpGestioneProfilo":"2"}',

                                         DettaglioLog);
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TB028FTest.Button32Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintS304('SELECT  T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO,T430AZIENDA_BASE,T430D_AZIENDA_BASE ,V430.T430CAP ,V430.T430D_COMUNE ,V430.T430CELLULARE_AZ ,V430.T430D_QUALIFICA FROM'#$D#$A +
                                        'T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480'#$D#$A'WHERE T030.Progressivo = V430.T430Progressivo AND'#$D#$A'T030.ComuneNas = T480.Codice(+) AND'#$D#$A':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine'#$D#$A +
                                        'AND'#$D#$A'/*I072*/'#$D#$A':DataLavoro BETWEEN T430INIZIO AND ADD_MONTHS(LAST_DAY(NVL(T430FINE,TO_DATE(''31123999'',''DDMMYYYY''))),0)'#$D#$A'/*\I072*/'#$D#$A'AND T030.TIPO_PERSONALE = ''I'''#$D#$A'AND'#$D#$A'((T030.COGNOME LIKE ''A%''))'#$D#$A'ORDER BY T030.COGNOME, T030.NOME',
                                        'c:\temp\Test304.pdf',
                                        'SYSMAN',
                                        'CN1',
                                        'DBCLIENTI',
                                        '{"edtDataElab":"01/01/2018", "sCodice": "DINCUO"}',
                                        '');
  finally
    DCOMConnection1.Connected:=False;
  end;

end;

procedure TB028FTest.Button33Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintS203((*'SELECT T030.*,T480.CITTA,T480.PROVINCIA,V430.T430BADGE FROM'#$D#$A'T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480'#$D#$A'WHERE T030.Progressivo = V430.T430Progressivo AND'#$D#$A +
                                        'T030.ComuneNas = T480.Codice(+) AND'#$D#$A':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine'#$D#$A'AND :DATALAVORO BETWEEN T430INIZIO AND NVL(LAST_DAY(T430FINE),:DATALAVORO)'#$D#$A +
                                        'AND '#$D#$A'(T030.COGNOME LIKE ''B%'') ORDER BY T030.COGNOME,T030.NOME,T030.MATRICOLA'*)
                                        'SELECT  T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO,T430AZIENDA_BASE,T430D_AZIENDA_BASE FROM'#$D#$A +
                                        'T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480'#$D#$A'WHERE T030.Progressivo = V430.T430Progressivo AND'#$D#$A'T030.ComuneNas = T480.Codice(+) AND'#$D#$A':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine'#$D#$A'/*I072*/'#$D#$A'/*\I072*/'#$D#$A +
                                        'AND T030.PROGRESSIVO = 0'#$D#$A
                                        ,
                                        'c:\temp\TestS203.pdf',
                                        'SYSMAN',
                                        'RAVDA',
                                        'DBCLIENTI',
                                        '{"StandardPrinter":"S","chkSelAnagrafe":"N","edtData":"17/07/2019","CodiceStampa":"1/6/15_COM","C700SqlCreato":"T030.PROGRESSIVO = 0"}',
                                        //'{"chkSelAnagrafe":"S","edtData":"31/08/2017","CodiceStampa":"1/6/15_ORG","C700SqlCreato":"(T030.COGNOME LIKE ''B%'') ORDER BY T030.COGNOME,T030.NOME,T030.MATRICOLA"}',
                                        '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TB028FTest.Button34Click(Sender: TObject);
var
  PrintDM:TB028PrintServer;
  ABC:OleVariant;
begin
 if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintA027('SELECT  T030.*,T480.CITTA,T480.PROVINCIA,V430.T430BADGE,V430.T430AZIENDA_BASE,V430.T430D_AZIENDA_BASE,V430.T430INIZIO,V430.T430FINE FROM T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480 ' +
                                        'WHERE T030.Progressivo = V430.T430Progressivo AND T030.ComuneNas = T480.Codice(+) AND :DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine AND ((:DATALAVORO BETWEEN T430INIZIO AND NVL(LAST_DAY(T430FINE),' +
                                        ':DATALAVORO)) OR (EXISTS (SELECT ''X''         FROM   VT050_ITER_RICHIESTEASSENZA         WHERE  PROGRESSIVO = T030.PROGRESSIVO         AND    T850STATO IS NULL         AND    T850DATA >= T430INIZIO))) AND  /*I072*/ /*\I072*/' +
                                        ' (((T030.COGNOME BETWEEN ''CAPRA'' AND ''MARRONE'')) AND (V430.T430SQUADRA IN (''26002'')) OR T030.COGNOME = ''CASA'') and T030.MATRICOLA in (''GM001'') ORDER BY V430.T430SQUADRA, T030.COGNOME, T030.NOME',
                                        'C:\temp\TestA027.pdf',
                                        'SYSMAN',
                                        'AZIN',
                                        'IRIS',
                                        '{"StandardPrinter":"N","NomeStampa":"ACCI","EDaData":"01/01/2019","EAData":"31/01/2019","chkAutoGiustificazione":"N","CAggiornamento":"N","chkAccessiMensa":"S","chkBuoniPasto":"S","chkInserimentoRiposi":"N"}',
                                        '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TB028FTest.Button35Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintS201('c:\temp\TestS201.pdf',
                                        'SYSMAN',
                                        'RAVDA',
                                        'DBCLIENTI',
                                        '{"DataInizio":"01/01/2019","DataFine":"31/12/2019","StrutturaVisualizzazione":"Pianta organica della Regione Valle d''Aosta","LstAttiPrevisti":"[437] 01/09/2018 - Assunzione Dagnes Nicole presso altro ufficio","LstAttiCopertura":" ","chkNumPostiVal":"S"}',
                                        '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TB028FTest.Button36Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintA202({'SELECT  T030.*,T480.CITTA,T480.PROVINCIA,V430.T430BADGE,V430.T430AZIENDA_BASE,V430.T430D_AZIENDA_BASE ' +
                                        'FROM T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480 ' +
                                        'WHERE T030.Progressivo = V430.T430Progressivo ' +
                                        'AND T030.ComuneNas = T480.Codice(+) ' +
                                        'AND :DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine ' +
                                        'AND ((:DATALAVORO BETWEEN T430INIZIO AND NVL(LAST_DAY(T430FINE),:DATALAVORO)) ' +
                                        '  OR (EXISTS (SELECT ''X'' FROM VT050_ITER_RICHIESTEASSENZA ' +
                                        '        WHERE PROGRESSIVO = T030.PROGRESSIVO ' +
                                        '        AND T850STATO IS NULL ' +
                                        '        AND T850DATA >= T430INIZIO))) ' +
                                        'AND /*I072*/ /*\I072*/ (T030.MATRICOLA = ''25'') ORDER BY T030.COGNOME,T030.NOME,T030.MATRICOLA ',}
                                        'SELECT  T030.*,T480.CITTA,T480.PROVINCIA,V430.T430BADGE,V430.T430AZIENDA_BASE,V430.T430D_AZIENDA_BASE ' +
                                        'FROM T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480 ' +
                                        'WHERE T030.Progressivo = V430.T430Progressivo ' +
                                        'AND T030.ComuneNas = T480.Codice(+) ' +
                                        'AND :DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine ' +
                                        'AND ((:DATALAVORO BETWEEN T430INIZIO AND NVL(LAST_DAY(T430FINE),:DATALAVORO)) ' +
                                        '  OR (EXISTS (SELECT ''X'' FROM VT050_ITER_RICHIESTEASSENZA ' +
                                        '        WHERE PROGRESSIVO = T030.PROGRESSIVO ' +
                                        '        AND T850STATO IS NULL ' +
                                        '        AND T850DATA >= T430INIZIO))) ' +
                                        'AND /*I072*/ /*\I072*/ (T030.MATRICOLA = ''0081115'') ORDER BY T030.COGNOME,T030.NOME,T030.MATRICOLA ',
                                        {'SELECT  T030.*,T480.CITTA,T480.PROVINCIA,V430.T430BADGE,V430.T430INIZIO,V430.T430FINE,V430.T430DATADECORRENZA,V430.T430DATAFINE '+
                                           ' FROM T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480'+
                                           ' WHERE T030.Progressivo = V430.T430Progressivo' +
                                           ' AND T030.ComuneNas = T480.Codice(+)' +
                                           ' AND :DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine' +
                                           ' AND T030.PROGRESSIVO' +
                                           ' = 40009' +
                                           ' ORDER BY T030.COGNOME,T030.NOME,T030.MATRICOLA',}
                                        'c:\temp\TestA202_01.pdf',
                                        'SYSMAN',
                                        'ASLTO', //'AZIN',
                                        'DBCLIENTI', //'IRIS',
                                        '{"StandardPrinter":"N","StampaDal":"01/01/1900","StampaAl":"31/12/3999"}',
                                        '');
  finally
    DCOMConnection1.Connected:=False;

  end;
end;

procedure TB028FTest.Button37Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintP715((*'SELECT  T030.*,T430INIZIO,T430FINE,T480.CITTA,T480.PROVINCIA,V430.T430BADGE,V430.T430AZIENDA_BASE,V430.T430D_AZIENDA_BASE FROM' + #$D#$A +
                                        'T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480' + #$D#$A +
                                        'WHERE T030.Progressivo = V430.T430Progressivo AND' + #$D#$A +
                                        'T030.ComuneNas = T480.Codice(+) AND' + #$D#$A +
                                        ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine' + #$D#$A +
                                        'AND :DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)' + #$D#$A + #$D#$A +
                                        'AND '#$D#$A'/*I072*/'#$D#$A'/*\I072*/'#$D#$A +
                                        '(T030.COGNOME = ''SALA'')  AND ((T030.PROGRESSIVO = 6515))',*)
                                        'SELECT  T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO,T430AZIENDA_BASE,T430D_AZIENDA_BASE,T030.CODFISCALE FROM' + #$D#$A +
                                        'T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480' + #$D#$A +
                                        'WHERE T030.Progressivo = V430.T430Progressivo AND' + #$D#$A +
                                        'T030.ComuneNas = T480.Codice(+) AND' + #$D#$A +
                                        ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine' + #$D#$A +
                                        'AND :DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)' + #$D#$A +
                                        '/*I072*/' + #$D#$A + '/*\I072*/' + #$D#$A +
                                        'AND T030.TIPO_PERSONALE = ''I''' + #$D#$A +
                                        //'AND T030.PROGRESSIVO = 6515' + #$D#$A +
                                        //'AND' + #$D#$A + 'T030.PROGRESSIVO = 6515' + #$D#$A,
                                        'AND' + #$D#$A + '((T030.COGNOME = ''SALA''))' + #$D#$A,
                                        '',//'c:\temp\TestP715.pdf',
                                        'SYSMAN',
                                        'AO1',
                                        'DBCLIENTI',
                                        //'{"StandardPrinter":"N","edtAnno":"2019","edtDataFirma":"02/03/2020","rgpStatoCU":"0","chkPagNominativo":"S","chkScheda":"S","chkRiepilogativo":"N",' +
                                        //'"chkAnteprima":"S","edtNumCopie":"1","chkStampaPDF":"N","edtNomeFileOutput":"","chkFilePDF":"N","chkArchiviazioneDoc":"N","memAnnotazione":"PIPPO'#$D#$A'"}',
                                        //'{"StandardPrinter":"N","edtAnno":"2020","edtDataFirma":"02/03/2020","rgpStatoCU":"0","chkPagNominativo":"S","chkScheda":"S","chkRiepilogativo":"N",' +
                                        //'"chkAnteprima":"S","edtNumCopie":"1","chkStampaPDF":"N","edtNomeFileOutput":"","chkFilePDF":"N","chkArchiviazioneDoc":"N","memAnnotazione":""}',
                                        '{"StandardPrinter":"N","edtAnno":"2019","edtDataFirma":"02/03/2020","rgpStatoCU":"0","chkPagNominativo":"S","chkScheda":"S","chkRiepilogativo":"N",' +
                                        '"chkAnteprima":"N","edtNumCopie":"1","chkStampaPDF":"N","edtNomeFileOutput":"C:\\temp\\P715_Stampa_cloud.pdf","chkFilePDF":"N","chkArchiviazioneDoc":"S","memAnnotazione":""}',
                                        '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TB028FTest.Button38Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintP690('c:\temp\TestP690.pdf',
                                        'SYSMAN',
                                        'CN1',
                                        'DBCLIENTI',
                                        '{"edtDecorrenzaDa":"01/01/2019","edtDecorrenzaA":"31/12/2019","chkRaggruppa":"S","chkDettRisorse":"S","chkDettDestinazioni":"S","ListaFondiSel":"1A_POSIZ,2B_ACCES_S,3B_PREM_FASCE"}',
                                        '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TB028FTest.Button39Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintP461('SELECT  T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO,T430AZIENDA_BASE,T430D_AZIENDA_BASE,T030.CODFISCALE FROM' + #$D#$A +
                                        'T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480' + #$D#$A +
                                        'WHERE T030.Progressivo = V430.T430Progressivo AND' + #$D#$A +
                                        'T030.ComuneNas = T480.Codice(+) AND' + #$D#$A +
                                        ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine' + #$D#$A +
                                        'AND :DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)' + #$D#$A +
                                        '/*I072*/' + #$D#$A + '/*\I072*/' + #$D#$A +
                                        'AND T030.TIPO_PERSONALE = ''I''' + #$D#$A +
                                        'AND T030.PROGRESSIVO = 20001' + #$D#$A,
                                        'c:\temp\TestP461.pdf',
                                        'SYSMAN',
                                        'CN1',
                                        'DBCLIENTI',
                                        '{"StandardPrinter":"N","edtDataCompetenza":"10/2021","rgpTipoSanConv":"0","rgpTipoRecord":"0","rgpTipoFile":"1","rgpZoneDisagiate":"0",' +
                                        '"chkDettaglioMesiCompetenza":"N","edtMesiRitardo":"1","dcmbIdSanitConvenz":"T430MATR_SANCONV","rgpTipoAcquisizione":"2",' +
                                        '"edtMinutiArrotondamento":"1","edtMinutiMinimi":"1","edtCausaliAssenza":"ANR","cmbCausalePresenza":"RET","chkAzzeraSaldoNegativo":"N",' +
                                        '"edtNomeFile":"C:\\SVN\\Sviluppo\\Eseguibili\\Archivi\\Cache\\01d1jhtfy7\\user\\YCjK1Y4JVKYXQdhBRgSZ0q\\0906quote.txt","edtNomeFileStranieri":"",' +
                                        '"sCodCausaleRecupero1":"","sCodCausaleRecupero2":"","sCodCausaleRecupero3":"","iMaxMesiRecupero1":"0","iMaxMesiRecupero2":"0","iMaxMesiRecupero3":"0",' +
                                        '"bStampaIndirizzo":"N","bStampaSedeServizio":"N","bStampaSoloPrimaPagina":"N","bStampaSoloTotali":"S","iDistanzaIndirizzoDaTitolo":"132"}',
                                        '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TB028FTest.Button42Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintP283('SELECT  T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO,T430AZIENDA_BASE,T430D_AZIENDA_BASE FROM' + #$D#$A +
                                        'T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480' + #$D#$A +
                                        'WHERE T030.Progressivo = V430.T430Progressivo AND' + #$D#$A +
                                        'T030.ComuneNas = T480.Codice(+) AND' + #$D#$A +
                                        ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine' + #$D#$A +
                                        'AND :DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)' + #$D#$A +
                                        'AND T030.TIPO_PERSONALE = ''I''' + #$D#$A +
                                        'AND' + #$D#$A +
                                        '((T030.PROGRESSIVO=2285))' + #$D#$A +
                                        'ORDER BY T030.COGNOME, T030.NOME',
                                         'C:\Temp\TestP283.pdf',
                                        'SYSMAN',
                                        'ASLTO',
                                        'CL',
                                        '{"edtDallaData":"01/01/2000","edtAllaData":"31/12/2022","rgpStatoPeriodi":"0","rgpImporto":"0",' +
                                        '"chkAccorpaVoci":"N","chkDettaglioPeriodo":"N","filtro":""}',
                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TB028FTest.btnSetPrinterClick(Sender: TObject);
var
  x : integer;
begin
  try
  for x := 0 to printerNames.Count -1 do begin
    If ListBox1.Selected[x] then begin
      if (SetPrinter(ListBox1.Items.Strings[x]))
      then label1.Caption := 'Printer set to ' + ListBox1.Items.Strings[x]
      else label1.Caption := 'Printer not set';
    end;
  end;
  except
    label1.Caption := 'An error occured while setting the printer';
  end;
end;

procedure TB028FTest.GetPrinterNames;
var
  buffer: TPrinterBuffer;
  currPos: integer;
  printerName: string;
begin
  printerNames.Free;
  printerNames := TStringList.Create;
  if GetProfileString(PChar('PrinterPorts'), nil, '', buffer, MAXPRINTERBUFFER) > 0 then
  begin
    currPos := 0;
    while (true) do
      begin
        printerName := ParseNames(buffer, currPos);
        if printerName <> '' then
        printerNames.Add(printerName)
    else
      break;
    end;
  end;
end;

function TB028FTest.ParseNames(const namebuffer: TPrinterBuffer; var startPos: integer): string;
var
  i, j, NameLength: integer;
  str: string;
begin
  result := '';
  if (startPos > High(namebuffer)) or (namebuffer[startPos] = Chr(0))

  then
    exit;
  for i := startPos to High(namebuffer) do begin
    if namebuffer[i] = Chr(0)

    then begin
      nameLength := i - startPos;
      SetLength(str, nameLength);
      for j := 0 to nameLength - 1 do
      str[j+1] := namebuffer[startPos + j];
      result := str;
      startPos := i + 1;
      break;
    end;
  end;
end;

function TB028FTest.SetPrinter(const PrinterName: String): boolean;
var
  s2 : string;
  dum1 : Pchar;
  xx, qq : integer;
const
  cs1 : pchar = 'Windows';
  cs2 : pchar = 'Device';
  cs3 : pchar = 'Devices';
  cs4 : pchar = #0;

begin
  xx := 254;
  GetMem( dum1, xx);
  Result := False;
  try
    qq := GetProfileString( cs3, pchar( printerName ), #0, dum1, xx);
    if (qq > 0) and (trim( strpas( dum1 )) <> '')

   then begin
      s2 := PrinterName + ',' + strpas( dum1 );
      while GetProfileString( cs1, cs2, cs4, dum1, xx) > 0 do
        WriteProfileString( cs1, cs2, #0);
      WriteProfileString( cs1, cs2, pchar( s2 ));
      case Win32Platform of
       VER_PLATFORM_WIN32_NT :
        // SendMessage( HWND_BROADCAST, WM_WININICHANGE, 0, LongInt(cs1));
        // VER_PLATFORM_WIN32_WINDOWS :
        // SendMessage( HWND_BROADCAST, WM_SETTINGCHANGE, 0, LongInt(cs1));
     end;
  Result := True;
end;
finally
  FreeMem( dum1 );
end;
end;

procedure TB028FTest.btnPrintersClick(Sender: TObject);
begin
  GetPrinterNames;
  Listbox1.Items.AddStrings(PrinterNames);
end;
end.
