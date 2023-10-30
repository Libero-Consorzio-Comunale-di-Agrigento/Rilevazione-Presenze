unit WA177UFerieSolidaliDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData, A177UFerieSolidaliMW,
  Oracle, medpIWMessageDlg, C180FunzioniGenerali, A000UMessaggi, A000UInterfaccia, A000USessione;

type
  TWA177FFerieSolidaliDM = class(TWR302FGestTabellaDM)
    selT254PROGRESSIVO: TIntegerField;
    selT254TIPO: TStringField;
    selT254ANNO: TFloatField;
    selT254DECORRENZA: TDateTimeField;
    selT254DECORRENZA_FINE: TDateTimeField;
    selT254ID_RICHIESTA: TFloatField;
    selT254DESCRIZIONE: TStringField;
    selT254DESCR_OFFERTA: TStringField;
    selT254STATO: TStringField;
    selT254CODRAGGR: TStringField;
    selT254DESCR_RAGGR: TStringField;
    selT254CAUSALE: TStringField;
    selT254UMISURA: TStringField;
    selTabellaQUANTITA_RICHIESTA: TStringField;
    selTabellaQUANTITA_OTTENUTA: TStringField;
    selTabellaQUANTITA_OFFERTA: TStringField;
    selTabellaQUANTITA_ACCETTATA: TStringField;
    selTabellaTERMINE_DIRITTO: TDateTimeField;
    selTabellaQUANTITA_RESTITUITA: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure selTabellaCalcFields(DataSet: TDataSet);
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure AfterDelete(DataSet: TDataSet); override;
    procedure AfterPost(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
  private
    { Private declarations }
    procedure SuperoResiduo(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure SuperoOfferta(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure Cancellazione(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
  public
    { Public declarations }
    A177MW: TA177FFerieSolidaliMW;
  end;

implementation

{$R *.dfm}

uses WA177UFerieSolidali, WA177UFerieSolidaliDettFM;

procedure TWA177FFerieSolidaliDM.AfterDelete(DataSet: TDataSet);
begin
  inherited;
  A177MW.selT254AfterDelete;
end;

procedure TWA177FFerieSolidaliDM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  A177MW.selT254AfterPost;
end;

procedure TWA177FFerieSolidaliDM.AfterScroll(DataSet: TDataSet);
begin
  inherited;
  if ((Self.Owner as TWA177FFerieSolidali).WDettaglioFM as TWA177FFerieSolidaliDettFM) <> nil then
  with (Self.Owner as TWA177FFerieSolidali) do
  begin
    (WDettaglioFM as TWA177FFerieSolidaliDettFM).AbilitaComponenti;
  end;
end;

procedure TWA177FFerieSolidaliDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  if ((Self.Owner as TWA177FFerieSolidali).WDettaglioFM as TWA177FFerieSolidaliDettFM) <> nil then
    ((Self.Owner as TWA177FFerieSolidali).WDettaglioFM as TWA177FFerieSolidaliDettFM).Componenti2Dataset;
  A177MW.selT254BeforeDelete;
  if not MsgBox.KeyExists('PUNTO_1') then
  begin
    if (selTabella.FieldByName('TIPO').AsString = 'O') and (selTabella.FieldByName('ID_RICHIESTA').AsInteger = -1) then
    begin
      //Attenzione: verranno cancellate anche tutte le offerte collegate. Continuare comunque?
      MsgBox.WebMessageDlg(A000MSG_A177_DLG_CANC_OFFERTA,mtConfirmation,[mbYes,mbNo],Cancellazione,'PUNTO_1');
      Abort;
    end;
  end;
end;

procedure TWA177FFerieSolidaliDM.Cancellazione(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrYes then
  begin
    A177MW.CancellaOfferte;
    selTabella.Refresh;
    (Self.Owner as TWA177FFerieSolidali).EseguiDelete;
  end
  else
    MsgBox.ClearKeys;
end;

procedure TWA177FFerieSolidaliDM.BeforePostNoStorico(DataSet: TDataSet);
var QOfferta:Real;
begin
  inherited;
  A177MW.selT254BeforePost;
  //La quantità offerta non può essere superiore a x giorni ()!
  if selTabella.FieldByName('TIPO').AsString = 'O' then
  begin
    if selTabella.FieldByName('UMISURA').AsString = 'G' then
    begin
      QOfferta:=StrToFloat(selTabella.FieldByName('QUANTITA_OFFERTA').AsString);
      if not MsgBox.KeyExists('PUNTO_1') then
      begin
        if QOfferta > A177MW.MaxOfferta then
        begin
          selTabella.FieldByName('QUANTITA_OFFERTA').FocusControl;
          MsgBox.WebMessageDlg(Format(A000MSG_A177_ERR_FMT_QUANTITA,['offerta',FloatToStr(A177MW.MaxOfferta) + ' giorni. Il dato viene comunque salvato.']),mtInformation,[mbOk],SuperoOfferta,'PUNTO_1');
          Abort;
        end;
      end;
      //La quantità offerta non può essere superiore a x giorni residui!
      if not MsgBox.KeyExists('PUNTO_2') then
      begin
        if QOfferta > A177MW.ResiduoOfferta then
        begin
          selTabella.FieldByName('QUANTITA_OFFERTA').FocusControl;
          MsgBox.WebMessageDlg(Format(A000MSG_A177_DLG_QUANTITA_RES,[FloatToStr(A177MW.ResiduoOfferta)+ ' giorni residui']),mtConfirmation,[mbYes,mbNo],SuperoResiduo,'PUNTO_2');
          Abort;
        end;
      end;
    end
    else if selTabella.FieldByName('UMISURA').AsString = 'O' then
    begin
      QOfferta:=R180OreMinutiExt(selTabella.FieldByName('QUANTITA_OFFERTA').AsString);
      //La quantità offerta non può essere superiore a x ore ()!
      if not MsgBox.KeyExists('PUNTO_1') then
      begin
        if QOfferta > A177MW.MaxOffertaHH then
        begin
          selTabella.FieldByName('QUANTITA_OFFERTA').FocusControl;
          MsgBox.WebMessageDlg(Format(A000MSG_A177_ERR_FMT_QUANTITA,['offerta',R180MinutiOre(A177MW.MaxOffertaHH) + ' ore. Il dato viene comunque salvato.']),mtInformation,[mbOk],SuperoOfferta,'PUNTO_1');
          Abort;
        end;
      end;
      //La quantità offerta non può essere superiore a x ore residue!
      if not MsgBox.KeyExists('PUNTO_2') then
      begin
        if QOfferta > A177MW.ResiduoOffertaHH then
        begin
          selTabella.FieldByName('QUANTITA_OFFERTA').FocusControl;
          MsgBox.WebMessageDlg(Format(A000MSG_A177_DLG_QUANTITA_RES,[R180MinutiOre(A177MW.ResiduoOffertaHH)+ ' ore residue']),mtConfirmation,[mbYes,mbNo],SuperoResiduo,'PUNTO_2');
          Abort;
        end;
      end;
    end;
  end;
end;

procedure TWA177FFerieSolidaliDM.SuperoOfferta(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  (Self.Owner as TWA177FFerieSolidali).actConfermaExecute(nil);
end;

procedure TWA177FFerieSolidaliDM.SuperoResiduo(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrYes then
    (Self.Owner as TWA177FFerieSolidali).actConfermaExecute(nil)
  else
    MsgBox.ClearKeys;
end;

procedure TWA177FFerieSolidaliDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY DECORRENZA DESC, ID_RICHIESTA, CODRAGGR');
  A177MW:=TA177FFerieSolidaliMW.Create(Self);
  A177MW.selT254:=selTabella;
  inherited;
end;

procedure TWA177FFerieSolidaliDM.OnNewRecord(DataSet: TDataSet);
begin
  A177MW.selT254NewRecord('R');
  inherited;
end;

procedure TWA177FFerieSolidaliDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  inherited;
  A177MW.selT254CalcFields(Dataset);
end;

end.
