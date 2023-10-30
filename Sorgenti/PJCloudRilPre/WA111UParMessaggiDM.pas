unit WA111UParMessaggiDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR303UGestMasterDetailDM, Data.DB, OracleData, A111UParMessaggiMW;

type
  TWA111FParMessaggiDM = class(TWR303FGestMasterDetailDM)
    selTabellaCODICE: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaTIPO_FILE: TStringField;
    selTabellaNOME_FILE: TStringField;
    selTabellaDATA_FILE: TStringField;
    selTabellaDEFAULT_FILE: TStringField;
    selTabellaNUM_RIPET_MSG: TFloatField;
    selTabellaNUM_GGVAL_MSG: TFloatField;
    selTabellaNUM_MMIND_CONS: TFloatField;
    selTabellaFILTRO_ANAGR: TStringField;
    selTabellaTIPO_FILTRO: TStringField;
    selTabellaREGISTRA_MSG: TStringField;
    selTabellaTIPO_REGISTRAZIONE: TStringField;
    selTabellaNUM_MMIND_VALID: TIntegerField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure AfterCancel(DataSet: TDataSet); override;
    procedure AfterDelete(DataSet: TDataSet); override;
    procedure AfterEdit(DataSet: TDataSet);
    procedure AfterInsert(DataSet: TDataSet);
    procedure AfterPost(DataSet: TDataSet); override;
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure BeforeCancel(DataSet: TDataSet);
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure selTabellaCODICEChange(Sender: TField);
  private
    { Private declarations }
    procedure RelazionaTabelleFiglie;override;
  public
    { Public declarations }
    A111MW: TA111FParMessaggiMW;
  end;

implementation

uses WA111UParMessaggi, WA111UParMessaggiDettFM;

{$R *.dfm}

procedure TWA111FParMessaggiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY CODICE');
  A111MW:=TA111FParMessaggiMW.Create(Self);
  A111MW.selT291:=SelTabella;
  inherited;
end;

procedure TWA111FParMessaggiDM.RelazionaTabelleFiglie;
begin
  inherited;
  A111MW.AfterScroll;
end;

procedure TWA111FParMessaggiDM.AfterCancel(DataSet: TDataSet);
begin
  A111MW.AfterCancel;
  inherited;
end;

procedure TWA111FParMessaggiDM.AfterDelete(DataSet: TDataSet);
begin
  A111MW.AfterDelete;
  inherited;
end;

procedure TWA111FParMessaggiDM.AfterEdit(DataSet: TDataSet);
begin
  A111MW.AfterEdit(((Self.Owner as TWA111FParMessaggi).WDettaglioFM as TWA111FParMessaggiDettFM).dEdtCodice.Text);
end;

procedure TWA111FParMessaggiDM.AfterInsert(DataSet: TDataSet);
begin
  A111MW.AfterInsert(((Self.Owner as TWA111FParMessaggi).WDettaglioFM as TWA111FParMessaggiDettFM).dEdtCodice.Text);
end;

procedure TWA111FParMessaggiDM.AfterPost(DataSet: TDataSet);
begin
  A111MW.AfterPostStep1;
  A111MW.AfterPostStep2;
  inherited;
end;

procedure TWA111FParMessaggiDM.AfterScroll(DataSet: TDataSet);
begin
  inherited;
  A111MW.AfterScroll;
  if (Self.Owner as TWA111FParMessaggi).WDettaglioFM <> nil then
    with (Self.Owner as TWA111FParMessaggi) do
    begin
      (WDettaglioFM as TWA111FParMessaggiDettFM).LblProva.Caption:=' ';
      if (WR302DM as TWA111FParMessaggiDM).A111MW.selT291.FieldByName('TIPO_FILTRO').AsString = '0' then
        (WDettaglioFM as TWA111FParMessaggiDettFM).dCmbFiltroAnagr.ListSource:=(WR302DM as TWA111FParMessaggiDM).A111MW.dsrT003
      else
        (WDettaglioFM as TWA111FParMessaggiDettFM).dCmbFiltroAnagr.ListSource:=(WR302DM as TWA111FParMessaggiDM).A111MW.dsrT002;
    end;
end;

procedure TWA111FParMessaggiDM.BeforeCancel(DataSet: TDataSet);
begin
  A111MW.BeforeCancel;
end;

procedure TWA111FParMessaggiDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  A111MW.BeforeDelete;
end;

procedure TWA111FParMessaggiDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  A111MW.BeforePost;
  inherited;
end;

procedure TWA111FParMessaggiDM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  A111MW.OnNewRecord;
end;

procedure TWA111FParMessaggiDM.selTabellaCODICEChange(Sender: TField);
begin
  A111MW.CODICEChange;
end;

end.
