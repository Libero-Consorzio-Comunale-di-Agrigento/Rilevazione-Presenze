unit WP553URisorseResidueContoAnnualeDM;

interface

uses
  P553URisorseResidueContoAnnualeMW, C180FunzioniGenerali,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData;

type
  TWP553FRisorseResidueContoAnnualeDM = class(TWR302FGestTabellaDM)
    selTabellaANNO: TIntegerField;
    selTabellaCOD_TABELLA: TStringField;
    selTabellaCOLONNA_RIGA: TIntegerField;
    selTabellaMACRO_CATEG: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaIMPORTO_RESIDUO: TFloatField;
    selTabellaCOD_TABELLA_QUOTE: TStringField;
    selTabellaCOLONNA_QUOTE: TIntegerField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure dsrTabellaStateChange(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
  public
    P553MW: TP553FRisorseResidueContoAnnualeMW;
  end;

implementation

{$R *.dfm}

uses WP553URisorseResidueContoAnnuale,
     WP553URisorseResidueContoAnnualeDettFM;

procedure TWP553FRisorseResidueContoAnnualeDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','order by anno,cod_tabella');
  inherited;
  P553MW:=TP553FRisorseResidueContoAnnualeMW.Create(Self);
  P553MW.SelT553_Funzioni:=selTabella;
  P553MW.selT470.Open;
end;

procedure TWP553FRisorseResidueContoAnnualeDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(P553MW);
  inherited;
end;

procedure TWP553FRisorseResidueContoAnnualeDM.AfterScroll(DataSet: TDataSet);
var i:Integer;
begin
  inherited;

  if (Self.Owner <> nil) and
     ((Self.Owner as TWP553FRisorseResidueContoAnnuale).WDettaglioFM <> nil) then
  begin
    with ((Self.Owner as TWP553FRisorseResidueContoAnnuale).WDettaglioFM as TWP553FRisorseResidueContoAnnualeDettFM) do
    begin
      CaricaComboTabelle;
      i:=R180IndexOf(CmbTabella.Items,Dataset.FieldByName('COD_TABELLA').AsString,10);
      { //***
      if i >= 0 then
        CmbTabella.Text:=Format('%-10s',[Dataset.FieldByName('COD_TABELLA').AsString]) + '-' +
                                    Copy(CmbTabella.Items[i],12,Length(CmbTabella.Items[i])-11)
      else
        CmbTabella.Text:='';
      }
      cmbTabella.ItemIndex:=i; //***
      cmbTabellaChange(nil);

      i:=R180IndexOf(CmbColonnaRiga.Items,Dataset.FieldByName('COLONNA_RIGA').AsString,3);
      {//***
      if i >= 0 then
        CmbColonnaRiga.Text:=Format('%-3s',[Dataset.FieldByName('COLONNA_RIGA').AsString]) + '-' +
                                    Copy(CmbColonnaRiga.Items[i],5,Length(CmbColonnaRiga.Items[i])-4)
      else
        CmbColonnaRiga.Text:='';
      }
      cmbColonnaRiga.ItemIndex:=i; //***

      i:=R180IndexOf(CmbTabellaColonna.Items,Dataset.FieldByName('COD_TABELLA_QUOTE').AsString,10);
      {//***
      if i >= 0 then
        CmbTabellaColonna.Text:=Format('%-10s',[Dataset.FieldByName('COD_TABELLA_QUOTE').AsString]) + '-' +
                                    Copy(CmbTabellaColonna.Items[i],12,Length(CmbTabellaColonna.Items[i])-11)
      else
        CmbTabellaColonna.Text:='';
      }
      CmbTabellaColonna.ItemIndex:=i; //***
      cmbTabellaColonnaChange(nil);

      i:=R180IndexOf(CmbColonna.Items,Dataset.FieldByName('COLONNA_QUOTE').AsString,3);

      { //***
      if i >= 0 then
        CmbColonna.Text:=Format('%-3s',[Dataset.FieldByName('COLONNA_QUOTE').AsString]) + '-' +
                                    Copy(CmbColonna.Items[i],5,Length(CmbColonna.Items[i])-4)
      else
        CmbColonna.Text:='';
      }
      CmbColonna.ItemIndex:=i; //***
    end;
  end;
end;

procedure TWP553FRisorseResidueContoAnnualeDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  if (DataSet.FieldByName('IMPORTO_RESIDUO').IsNull) or (DataSet.FieldByName('IMPORTO_RESIDUO').AsFloat = 0) then
    raise exception.Create('Specificare un importo residuo diverso da zero!');
  with ((Self.Owner as TWP553FRisorseResidueContoAnnuale).WDettaglioFM as TWP553FRisorseResidueContoAnnualeDettFM) do
  begin
    DataSet.FieldByName('COD_TABELLA').AsString:=TrimRight(Copy(CmbTabella.Text,1,10));
    DataSet.FieldByName('COLONNA_RIGA').AsString:=TrimRight(Copy(CmbColonnaRiga.Text,1,3));
    DataSet.FieldByName('COD_TABELLA_QUOTE').AsString:='';
    DataSet.FieldByName('COLONNA_QUOTE').AsString:='';
    if GrpColonnaCalcoloVisibile then
    begin
      DataSet.FieldByName('COD_TABELLA_QUOTE').AsString:=TrimRight(Copy(CmbTabellaColonna.Text,1,10));
      DataSet.FieldByName('COLONNA_QUOTE').AsString:=TrimRight(Copy(CmbColonna.Text,1,3));
    end;
  end;
end;

procedure TWP553FRisorseResidueContoAnnualeDM.dsrTabellaStateChange(Sender: TObject);
begin
  inherited;

  if (Self.Owner <> nil) and
     ((Self.Owner as TWP553FRisorseResidueContoAnnuale).WDettaglioFM <> nil) then
  begin
    with ((Self.Owner as TWP553FRisorseResidueContoAnnuale).WDettaglioFM as TWP553FRisorseResidueContoAnnualeDettFM) do
    begin
      cmbTabella.Enabled:=dsrTabella.State in [dsEdit,dsInsert];
      cmbTabellaColonna.Enabled:=dsrTabella.State in [dsEdit,dsInsert];
      cmbColonnaRiga.Enabled:=dsrTabella.State in [dsEdit,dsInsert];
      cmbColonna.Enabled:=dsrTabella.State in [dsEdit,dsInsert];
    end;
  end;
end;

end.
