unit P684UGenerale;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, StdCtrls, ExtCtrls, ActnList, ImgList, DB, Menus,
  ComCtrls, ToolWin, DBCtrls, Mask, System.Actions, System.ImageList;

type
  TP684FGenerale = class(TR001FGestTab)
    Panel3: TPanel;
    lblAnno: TLabel;
    lblFondo: TLabel;
    lblCodTabella: TLabel;
    edtFondo: TEdit;
    edtDecorrenza: TEdit;
    Panel2: TPanel;
    lblCodVoce: TLabel;
    Label1: TLabel;
    dedtCodVoceGen: TDBEdit;
    dedtOrdineStampa: TDBEdit;
    Label2: TLabel;
    dcmbTipoVoce: TDBComboBox;
    lblTipoVoce: TLabel;
    dmemDescrizione: TDBMemo;
    procedure FormShow(Sender: TObject);
    procedure TInserClick(Sender: TObject);
    procedure TRegisClick(Sender: TObject);
  private
    { Private declarations }
    procedure CaricadcmbTipoVoce;
  public
    { Public declarations }
  end;

var
  P684FGenerale: TP684FGenerale;

  procedure OpenP684Generale(Tipo,Fondo:String;Dec:TDateTime);


implementation

uses P684UDefinizioneFondiDtM;

{$R *.dfm}

procedure OpenP684Generale(Tipo,Fondo:String;Dec:TDateTime);
begin
  Application.CreateForm(TP684FGenerale,P684FGenerale);
  with P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW do
  try
    TipoElabGen:=Tipo;
    DataElabGen:=Dec;
    FondoElabGen:=Fondo;
    P684FGenerale.ShowModal;
  finally
    FreeAndNil(P684FGenerale);
  end;
end;

procedure TP684FGenerale.FormShow(Sender: TObject);
begin
  inherited;
  with P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW do
  begin
    edtDecorrenza.Text:=DateToStr(DataElabGen);
    edtFondo.Text:=FondoElabGen;
    lblFondo.Caption:=VarToStr(selP684.Lookup('DECORRENZA_DA;COD_FONDO',VarArrayOf([DataElabGen,FondoElabGen]),'DESCRIZIONE'));
    if TipoElabGen = 'R' then
    begin
      DButton.DataSet:=selP686R;
      P684FGenerale.Caption:='<P684> Risorse generali';
      P684FGenerale.lblTipoVoce.Caption:='Tipo risorsa';
      P684FGenerale.HelpContext:=3684100;
    end
    else
    begin
      DButton.DataSet:=selP686D;
      P684FGenerale.Caption:='<P684> Destinazioni generali';
      P684FGenerale.lblTipoVoce.Caption:='Tipo destinazione';
      P684FGenerale.HelpContext:=3684300;
    end;
    CaricadcmbTipoVoce;
  end;
end;

procedure TP684FGenerale.TInserClick(Sender: TObject);
begin
  inherited;
  dedtCodVoceGen.SetFocus;
end;

procedure TP684FGenerale.TRegisClick(Sender: TObject);
begin
  inherited;
  CaricadcmbTipoVoce;
end;

procedure TP684FGenerale.CaricadcmbTipoVoce;
begin
  with P684FDefinizioneFondiDtM.P684FDefinizioneFondiMW do
  begin
    selP686Tipo.Close;
    selP686Tipo.SetVariable('CLASS',TipoElabGen);
    selP686Tipo.Open;
    dcmbTipoVoce.Items.Clear;
    while not selP686Tipo.Eof do
    begin
      dcmbTipoVoce.Items.Add(selP686Tipo.FieldByName('TIPO_VOCE').AsString);
      selP686Tipo.Next;
    end;
  end;
end;

end.
