unit B009UPuntoInformativo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, qrprntr, A000UCostanti, A000USessione,A000UInterfaccia, C180FunzioniGenerali, C001StampaLib,
  Buttons, C004UParamForm, Variants;

type
  TB009FPuntoInformativo = class(TForm)
    LblNumeroBadge: TLabel;
    PnlNumeroBadge: TPanel;
    EdtNumeroBadge: TEdit;
    LblElaborazione: TLabel;
    Panel1: TPanel;
    Image1: TImage;
    Timer1: TTimer;
    PnlBottoni: TPanel;
    SpbA: TSpeedButton;
    SpbB: TSpeedButton;
    SpbC: TSpeedButton;
    Label4: TLabel;
    LblB: TLabel;
    Label2: TLabel;
    LblA: TLabel;
    LblC: TLabel;
    StatusBar1: TStatusBar;
    procedure EdtNumeroBadgeKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    nPv_Progressivo:integer;
    dPv_DataMesePrec:TDateTime;
    bPv_FormShow:boolean;
    procedure EseguiAnteprimaStampa;
  public
    { Public declarations }
  end;

var
  B009FPuntoInformativo: TB009FPuntoInformativo;

implementation

uses  B009UPuntoInformativoDtM1, B009UDialogBox,
      A027UCarMen, A027UStampaTimb, B009UAnteprima, B009UImpostazioniBadge;

{$R *.DFM}

procedure TB009FPuntoInformativo.EdtNumeroBadgeKeyPress(Sender: TObject;
  var Key: Char);
var
  nKey:integer;
begin
  nKey:=Ord(Key);
  //In corrispondenza del carattere "INVIO", inizia l'elaborazione della stampa
  if nKey = 13 then
  begin
    If trim(EdtNumeroBadge.Text)='' then
    begin
      EdtNumeroBadge.Text:='';
      abort;
    end;

    PnlNumeroBadge.Enabled:=false;
    Timer1.Enabled:=false;
    LblElaborazione.visible:=false;

    EseguiAnteprimaStampa;

    PnlNumeroBadge.Enabled:=true;
    EdtNumeroBadge.clear;
    Timer1.Enabled:=true;
    EdtNumeroBadge.SetFocus;

  end
  else
    //Accetto solo valori numerici + backspace...
    If ((nKey < 48) or (nKey > 57)) and (nKey <> 8) then
     abort;
end;

procedure TB009FPuntoInformativo.EseguiAnteprimaStampa;
var
  dDataDa, dDataA:TDateTime;
  sBadge:string;
  sPosizione, sLunghezza :string;
begin
  try
    nPv_Progressivo:=0;
    //Verifico le impostazioni del badge...
    CreaC004(SessioneOracle,'B009',0);
    sPosizione:=C004FParamForm.GetParametro('Posizione','');
    sLunghezza:=C004FParamForm.GetParametro('Lunghezza','');
    C004FParamForm.Free;
    If (sLunghezza = '') or (sPosizione = '') then
    begin
      B009UDialogBox.OpenB009FDialogBox('Caricare le impostazioni per il riconoscimento del badge.', 'Impossibile proseguire', 'ESCLAMA');
      try
        Application.CreateForm(TB009FImpostazioniBadge, B009FImpostazioniBadge);
        B009FImpostazioniBadge.ShowModal;
      finally
        B009FImpostazioniBadge.free;
      end;
      exit;
    end;
    sBadge:=trim(EdtNumeroBadge.text);
    if length(sBadge) < ((strtoint(sPosizione) + strtoint(sLunghezza)) - 1) then
    begin
      B009UDialogBox.OpenB009FDialogBox('Il tracciato del badge è inferiore a quello previsto dalle impostazioni per il riconoscimento del badge.', 'Impossibile proseguire', 'ESCLAMA');
      try
        Application.CreateForm(TB009FImpostazioniBadge, B009FImpostazioniBadge);
        B009FImpostazioniBadge.ShowModal;
      finally
        B009FImpostazioniBadge.free;
      end;
      exit;
    end;
    //---- Fine verifica delle impostazioni

    sBadge:=Copy(sBadge, strtoint(sPosizione), strtoint(sLunghezza));

    with B009FPuntoInformativoDtM1 do
    begin
      SelT430.Close;
      SelT430.SetVariable('BADGEIN', strtoFloat(sBadge));
      SelT430.SetVariable('DECORRENZA', parametri.datalavoro);
      SelT430.Open;
      If SelT430.Eof then
      begin
        B009UDialogBox.OpenB009FDialogBox('Nessun dipendente corrisponde al badge ' + sBadge, 'Tracciato banda: ' + trim(EdtNumeroBadge.text), 'INFORMA');
        exit;
      end;
      
      nPv_Progressivo:= SelT430.FieldbyName('PROGRESSIVO').AsInteger;
      if SpbA.Down then  //Mese in corso...
      begin
        dDataDa:=R180InizioMese(Parametri.DataLavoro);
        dDataA:=Parametri.DataLavoro;
      end
      else if SpbB.Down then  //Mese precedente
      begin
        dDataDa:=dPv_DataMesePrec;
        dDataA:=R180FineMese(dPv_DataMesePrec);
      end
      else if SpbC.Down then
      begin
        SelT070.Close;
        SelT070.SetVariable('PROGRESSIVO',nPv_Progressivo);
        SelT070.SetVariable('DATA', Parametri.DataLavoro);
        SelT070.Open;
        SelT070.First;
        if SelT070.FieldByName('DATA').asString = '' then
        begin
          B009UDialogBox.OpenB009FDialogBox('Non esiste alcuna scheda riepilogativa chiusa, antecedente al ' + Datetostr(Parametri.datalavoro) + ', associata al dipendente in oggetto.', 'Attenzione!!!', 'INFORMA');
          exit;
        end;
        dDataDa:=R180InizioMese(SelT070.FieldByName('DATA').asDateTime);
        dDataA:=R180FineMese(SelT070.FieldByName('DATA').asDateTime);
      end;

    end;

    try
      Application.CreateForm(TA027FCarMen, A027FCarMen);
      //Application.CreateForm(TA027FCarMenDtM1, A027FCarMenDtM1);
      A027FCarMen.FormShow(nil);
      A027FCarMen.frmSelAnagrafe.SelezionaProgressivo(nPv_progressivo);
      A027FCarMen.EDaData.Text:=datetostr(dDataDa);
      A027FCarMen.EAData.Text:=datetostr(dDataA);      
      A027FCarMen.NomeStampa.KeyValue:='PINFO';
      A027FCarMen.BitBtn1Click(A027FCarMen.BitBtn3);
    finally
      //A027FCarMenDtM1.Free;
      A027FCarMen.Free;
    end;

  except
    on E:Exception do
    begin
      B009UDialogBox.OpenB009FDialogBox(E.Message, 'Errore', 'ERRORE');
      PnlNumeroBadge.Enabled:=true;
      EdtNumeroBadge.clear;
      Timer1.Enabled:=true;
      EdtNumeroBadge.SetFocus;
    end;
  end;

end;

procedure TB009FPuntoInformativo.FormActivate(Sender: TObject);
var
  nAnno, nMese:integer;
begin
  if not bPv_FormShow then
  begin
    //Imposto il mese attuale
    nMese:=strtoint(FormatDateTime('mm',parametri.datalavoro));
    nAnno:= strtoint(FormatDateTime('yyyy',parametri.datalavoro));
    LblA.Caption:= LblA.Caption + ' ' + R180NomeMese(nMese) + ' ' + inttostr(nAnno);
    //Calcolo il mese precedente...
    nMese:=nMese - 1;
    if nMese <= 0 then
    begin
      nMese:=12;
      nAnno:=nAnno - 1;
    end;
    dPv_DataMesePrec:=encodedate(nAnno,nMese,1);
    LblB.Caption:= LblB.Caption + ' ' + R180NomeMese(nMese) + ' ' + inttostr(nAnno);
    bPv_FormShow:=true;
  end;

  //----- Poziono in modo centrale tutti i controlli sul form...
  LblElaborazione.width:=screen.Width;
  LblNumeroBadge.Width:=screen.Width;
  PnlNumeroBadge.Left:=trunc((screen.Width - PnlNumeroBadge.Width)/2);
  PnlBottoni.Left:=trunc((screen.Width - PnlBottoni.Width)/2);
  //---- Fine posizionamento
  try
    PnlNumeroBadge.Enabled:=true;
    EdtNumeroBadge.clear;
    Timer1.Enabled:=true;
    EdtNumeroBadge.SetFocus;
  except
  end;
end;

procedure TB009FPuntoInformativo.Timer1Timer(Sender: TObject);
begin
  lblElaborazione.Visible:= not lblElaborazione.Visible;
end;

procedure TB009FPuntoInformativo.FormCreate(Sender: TObject);
begin
  RegisterPreviewClass(TQRMDIPreviewInterface);
  bPv_FormShow:=false;
end;

procedure TB009FPuntoInformativo.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  //Gestisco la pressione dei tasti A,B,C
  case Key of
    65: SpbA.Down:=true;
    66: SpbB.Down:=true;
    67: SpbC.Down:=true;
  end;
  //Gestisco la visualizzazione della form per la gestione del badge...
  if (ssAlt in Shift) and (ssShift in Shift) and (Key = 13) then
  begin
    try
      Application.CreateForm(TB009FImpostazioniBadge, B009FImpostazioniBadge);
      B009FImpostazioniBadge.ShowModal;
    finally
      B009FImpostazioniBadge.free;
    end;
    Key:=0;
  end;
end;

procedure TB009FPuntoInformativo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if B009UAnteprima.PreviewInCorso then
    Action:=caNone;
end;

end.
