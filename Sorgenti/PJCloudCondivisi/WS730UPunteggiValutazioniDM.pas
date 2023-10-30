unit WS730UPunteggiValutazioniDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData,
  S730UPunteggiValutazioniMW, A000UInterfaccia, medpIWMessageDlg;

type
  TWS730FPunteggiValutazioniDM = class(TWR302FGestTabellaDM)
    selTabellaDATO1: TStringField;
    selTabellaDECORRENZA: TDateTimeField;
    selTabellaDECORRENZA_FINE: TDateTimeField;
    selTabellaCODICE: TStringField;
    selTabellaPUNTEGGIO: TFloatField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaCALCOLO_PFP: TStringField;
    selTabellaGIUSTIFICA: TStringField;
    selTabellaITEM_GIUDICABILE: TStringField;
    selTabellaDESC_DATO1: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure BeforePost(DataSet: TDataSet); override;
    procedure AfterPost(DataSet: TDataSet); override;
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure selTabellaAfterOpen(DataSet: TDataSet);
  private
    procedure ResultCalcoloPFP(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
  public
    S730FPunteggiValutazioniMW: TS730FPunteggiValutazioniMW;
  end;

implementation

{$R *.dfm}

uses
  WR102UGestTabella, WS730UPunteggiValutazioniDettFM;

procedure TWS730FPunteggiValutazioniDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  try
    selTabella.SetVariable('ORDERBY','ORDER BY SG730.DATO1, SG730.CODICE, SG730.DECORRENZA');
    NonAprireSelTabella:=True;
    inherited;
    S730FPunteggiValutazioniMW:=TS730FPunteggiValutazioniMW.Create(Self);
    S730FPunteggiValutazioniMW.selSG730:=selTabella;
    S730FPunteggiValutazioniMW.selSG730OldValues.SetDataSet(selTabella);
    S730FPunteggiValutazioniMW.SetCampiLookup;
  except
    on E:Exception do
      MsgBox.WebMessageDlg(E.Message,mtError,[mbOK],nil,'');
  end;
end;

procedure TWS730FPunteggiValutazioniDM.selTabellaAfterOpen(
  DataSet: TDataSet);
begin
  S730FPunteggiValutazioniMW.selSG730OldValues.CreaStruttura;
end;

procedure TWS730FPunteggiValutazioniDM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  S730FPunteggiValutazioniMW.OnNewRecord;
end;

procedure TWS730FPunteggiValutazioniDM.AfterScroll(DataSet: TDataSet);
begin
  inherited;
  S730FPunteggiValutazioniMW.selSG730OldValues.Aggiorna;
  if (Self.Owner as TWR102FGestTabella).WDettaglioFM <> nil then
    ((Self.Owner as TWR102FGestTabella).WDettaglioFM as TWS730FPunteggiValutazioniDettFM).AbilitaComponenti;
end;

procedure TWS730FPunteggiValutazioniDM.BeforePost(DataSet: TDataSet);
var
  Msg: String;
begin
  if not MsgBox.KeyExists('PUNTO_1') then
  begin
    Msg:=S730FPunteggiValutazioniMW.BeforePost;
    if Msg <> '' then
    begin
      with ((Self.Owner as TWR102FGestTabella).WDettaglioFM as TWS730FPunteggiValutazioniDettFM) do
      begin
        Msg:=Msg + 'Deselezionando il campo ' + dchkCalcoloPFP.Caption +
                   ' saranno svuotati tutti i valori indicati in ' + lblPunteggio.Caption +
                   ' per tutti i Codici assegnati al valore ' + selTabella.FieldByName('DATO1').AsString +
                   ' del dato ' + lblDato1.Caption + ' su tutte le decorrenze. Proseguire?';
        MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultCalcoloPFP,'PUNTO_1');
        Abort;
      end;
    end;
  end;
  S730FPunteggiValutazioniMW.ControlloDate;
  inherited;
end;

procedure TWS730FPunteggiValutazioniDM.ResultCalcoloPFP(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  case Res of
    mrOK,mrYes: selTabella.Post;
    mrNo:  MsgBox.ClearKeys;
  end;
end;

procedure TWS730FPunteggiValutazioniDM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  S730FPunteggiValutazioniMW.AfterPost;
end;

end.
