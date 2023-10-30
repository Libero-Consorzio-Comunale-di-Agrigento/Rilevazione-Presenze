unit WA107UInsAssAutoRegoleDM;

interface

uses WR302UGestTabellaDM, DB, Classes, OracleData, A107UInsAssAutoRegoleMW;

type
  TWA107FInsAssAutoRegoleDM = class(TWR302FGestTabellaDM)
    selTabellaCAUSALI: TStringField;
    selTabellaDEBITO: TStringField;
    selTabellaGIORNI_VUOTI: TStringField;
    selTabellaORE_MAX: TStringField;
    selTabellaELIMINA_GIUSTIFICATIVI: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure AfterCancel(DataSet: TDataSet);Override;
    procedure BeforePostNoStorico(DataSet: TDataSet);Override;
    procedure selTabellaORE_MAXValidate(Sender: TField);
  private
    { Private declarations }
  public
    A107MW: TA107FInsAssAutoRegoleMW;
  end;

implementation

uses WA107UInsAssAutoRegole, WA107UInsAssAutoRegoleDettFM;

{$R *.dfm}

procedure TWA107FInsAssAutoRegoleDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','');
  A107MW:=TA107FInsAssAutoRegoleMW.Create(Self);
  A107MW.SelT045:=SelTabella;
  inherited;
end;

procedure TWA107FInsAssAutoRegoleDM.AfterCancel(DataSet: TDataSet);
begin
  inherited;
  with ((Self.Owner as TWA107FInsAssAutoRegole).WDettaglioFM as TWA107FInsAssAutoRegoleDettFM) do
  begin
    lstCausali.Items.CommaText:=selTabella.FieldByName('CAUSALI').AsString;
    if lstCausali.ItemIndex > lstCausali.Items.Count - 1 then
      lstCausali.ItemIndex:=lstCausali.Items.Count - 1;
  end;
end;

procedure TWA107FInsAssAutoRegoleDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  A107MW.BeforePost(((Self.Owner as TWA107FInsAssAutoRegole).WDettaglioFM as TWA107FInsAssAutoRegoleDettFM).lstCausali.Items.CommaText);
  inherited;
end;

procedure TWA107FInsAssAutoRegoleDM.selTabellaORE_MAXValidate(Sender: TField);
begin
  A107MW.ValidaOre(Sender);
end;

end.
