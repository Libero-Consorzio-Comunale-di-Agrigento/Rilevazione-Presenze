unit WA034UIntPagheDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR302UGestTabellaDM, DB, OracleData,A034UIntPagheMW,medpIWMessageDlg,
  A000UInterfaccia, A000UCostanti, A000UMessaggi, WR102UGestTabella;

type
  TWA034FIntPagheDM = class(TWR302FGestTabellaDM)
    selTabellacodice: TStringField;
    selTabellacodinterno: TStringField;
    selTabelladescrizione: TStringField;
    selTabellaflag: TStringField;
    selTabellavoce_paghe: TStringField;
    selTabellaum: TStringField;
    selTabellaordine: TIntegerField;
    procedure selTabellaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure selTabellaCalcFields(DataSet: TDataSet);
    procedure selTabellaflagValidate(Sender: TField);
    procedure ResultControlloVociPaghe(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
  private
    { Private declarations }
  public
    A034FIntPagheMW: TA034FIntPagheMW;
  end;

implementation

{$R *.dfm}

procedure TWA034FIntPagheDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  NonAprireSelTabella:=True;
  inherited;
  A034FIntPagheMW:=TA034FIntPagheMW.Create(Self);
  A034FIntPagheMW.selT190_Funzioni:=selTabella;
  A034FIntPagheMW.ImpostaSelC9ScaricoPaghe;

  SelTabella.SetVariable('ORDERBY','order by CODICE,ORDINE');
  SelTabella.Open;
  A034FIntPagheMW.AllineaCodici;
  SelTabella.Refresh;
end;

procedure TWA034FIntPagheDM.BeforePostNoStorico(DataSet: TDataSet);
var
  idxVettore, j: Integer;
  VoceOld: String;
begin
  inherited;

  if not MsgBox.KeyExists('PUNTO_1') then
  begin
    idxVettore:=0;
    for j:=1 to High(VettConst) do
      if selTabella.FieldByName('CodInterno').AsString = VettConst[j].CodInt then
      begin
        idxVettore:=j;
        Break;
      end;

    if idxVettore > 0 then
    begin
      if Trim(VettConst[idxVettore].VocePaghe) = 'S' then
      begin
        if (selTabella.FieldByName('Flag').AsString = 'S') and
           (selTabella.FieldByName('Voce_Paghe').AsString = '') then
        begin
          MsgBox.WebMessageDlg(A000MSG_A034_ERR_NO_CODICE_PAGHE,mtError,[mbOK],nil,'');
          Abort;
        end;

        //Controllo voci paghe
        if (selTabella.State = dsInsert) or 
		   (selTabella.FieldByName('Voce_Paghe').medpOldValue = null)
        then
          VoceOld:=''
        else
          VoceOld:=selTabella.FieldByName('Voce_Paghe').medpOldValue;

        if not A034FIntPagheMW.selControlloVociPaghe.ControlloVociPaghe(VoceOld,selTabella.FieldByName('Voce_Paghe').AsString) then
        begin
          MsgBox.WebMessageDlg(A034FIntPagheMW.selControlloVociPaghe.MessaggioLog,mtConfirmation,[mbYes,MbNo],ResultControlloVociPaghe,'PUNTO_1');
          Abort;
        end;
      end
      else
        selTabella.FieldByName('Voce_Paghe').Clear;
    end;
  end;
  MsgBox.ClearKeys;
end;

procedure TWA034FIntPagheDM.ResultControlloVociPaghe(Sender: TObject;
  Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrNo then
    MsgBox.ClearKeys
  else
  begin
    A034FIntPagheMW.selControlloVociPaghe.ValutaInserimentoVocePaghe(selTabella.FieldByName('Voce_Paghe').AsString);
    //Deve richiamare di nuovo actCOnferma e non direttamente selTabella.post altrimenti i controlli sulla grid non vengono rimossi
    TWR102FGestTabella(Self.Owner).actConfermaExecute(nil);
  end;
end;

procedure TWA034FIntPagheDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  inherited;
  A034FIntPagheMW.CalcFieldsT190;
end;

procedure TWA034FIntPagheDM.selTabellaFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=A034FIntPagheMW.AcceptFilterT190;
end;

procedure TWA034FIntPagheDM.selTabellaflagValidate(Sender: TField);
begin
  inherited;
  if (Sender.AsString <> 'S') and (Sender.AsString <> 'N') then
    raise Exception.Create('Valori amessi: S/N');
end;

end.
