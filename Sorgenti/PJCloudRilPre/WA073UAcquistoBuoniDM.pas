unit WA073UAcquistoBuoniDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DB, OracleData,
  A000UInterfaccia, WR302UGestTabellaDM, A073UAcquistoBuoniMW, medpIWMessageDlg, medpIWDBGrid;

type
  TWA073FAcquistoBuoniDM = class(TWR302FGestTabellaDM)
    Q690PROGRESSIVO: TIntegerField;
    selTabellaNOTE: TStringField;
    selTabellaBUONIPASTO: TIntegerField;
    selTabellaBUONI_AUTO: TIntegerField;
    selTabellaBUONI_RECUPERATI: TIntegerField;
    selTabellaTICKET: TIntegerField;
    selTabellaTICKET_AUTO: TIntegerField;
    selTabellaTICKET_RECUPERATI: TIntegerField;
    selTabellaDATA_MAGAZZINO: TDateTimeField;
    selTabellaDATA: TDateTimeField;
    selTabellaID_BLOCCHETTI: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure selTabellaDATAValidate(Sender: TField);
    procedure selTabellaID_BLOCCHETTIValidate(Sender: TField);
    procedure BeforeDelete(DataSet: TDataSet);override;
    procedure BeforePostNoStorico(DataSet: TDataSet);override;
    procedure OnNewRecord(DataSet: TDataSet);override;
  private
    procedure ResultMessaggio(Sender: TObject; R: TmeIWModalResult; KI: String);
  public
    A073MW:TA073FAcquistoBuoniMW;
  end;

implementation

uses WA073UAcquistoBuoni;

{$R *.dfm}

procedure TWA073FAcquistoBuoniDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  A073MW:=TA073FAcquistoBuoniMW.Create(nil);
  A073MW.Q690:=SelTabella;
  A073MW.InizializzaQ690;
  SelTabella.SetVariable('ORDERBY','ORDER BY DATA DESC');
  inherited;
end;

procedure TWA073FAcquistoBuoniDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(A073MW);
end;

procedure TWA073FAcquistoBuoniDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  if A073MW.selDatiBloccati.DatoBloccato(TWA073FAcquistoBuoni(Self.Owner).grdC700.selAnagrafe.FieldByName('Progressivo').AsInteger,A073MW.Q690.FieldByName('Data').AsDateTime,'T690') then
    raise Exception.Create(A073MW.selDatiBloccati.MessaggioLog);
end;

procedure TWA073FAcquistoBuoniDM.BeforePostNoStorico(DataSet: TDataSet);
//var Messaggio:String;
begin
  inherited;
  with A073MW do
  begin
    if selDatiBloccati.DatoBloccato(TWA073FAcquistoBuoni(Self.Owner).grdC700.selAnagrafe.FieldByName('Progressivo').AsInteger,Q690.FieldByName('Data').AsDateTime,'T690') then
      raise Exception.Create(selDatiBloccati.MessaggioLog);
    Messaggio:=Q690BeforePost;
    if (not MsgBox.KeyExists('Q690')) and (Messaggio <> '') then
    begin
      MsgBox.WebMessageDlg(Messaggio,mtConfirmation,[mbYes,mbNo],ResultMessaggio,'Q690');
      Abort;
    end;
  end;
end;

procedure TWA073FAcquistoBuoniDM.ResultMessaggio(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
  begin
    selTabella.Post;
    MsgBox.ClearKeys;
    TmedpIWDBGrid(TWA073FAcquistoBuoni(Self.Owner).WBrowseFM.grdTabella).medpAggiornaCDS;
  end
  else
    MsgBox.ClearKeys;
end;

procedure TWA073FAcquistoBuoniDM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  selTabella.FieldByName('PROGRESSIVO').AsInteger:=TWA073FAcquistoBuoni(Self.Owner).grdC700.selAnagrafe.FieldByName('Progressivo').AsInteger;
  selTabella.FieldByName('DATA').AsDateTime:=Parametri.DataLavoro;
end;

procedure TWA073FAcquistoBuoniDM.selTabellaDATAValidate(Sender: TField);
begin
  A073MW.Q690DATAValidate(Sender);
end;

procedure TWA073FAcquistoBuoniDM.selTabellaID_BLOCCHETTIValidate(Sender: TField);
begin
  A073MW.Q690ID_BLOCCHETTIValidate(Sender);
end;

end.
