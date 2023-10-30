unit WA067URepSostB;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR100UBase, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, IWCompLabel, meIWLabel, medpIWMultiColumnComboBox, IWCompEdit, meIWEdit,
  medpIWC700NavigatorBar, StrUtils,
  A000UInterfaccia, A000UMessaggi, A067URepSostBMW, C180FunzioniGenerali, Rp502Pro,
  meIWImageFile;

type
  TWA067FRepSostB = class(TWR100FBase)
    edtDaData: TmeIWEdit;
    edtAData: TmeIWEdit;
    cmbCausale: TMedpIWMultiColumnComboBox;
    lblDaData: TmeIWLabel;
    lblAData: TmeIWLabel;
    lblCausale: TmeIWLabel;
    btnInserisci: TmeIWButton;
    btnElimina: TmeIWButton;
    procedure IWAppFormCreate(Sender: TObject);
    procedure edtDaDataAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure edtADataAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure btnInserisciClick(Sender: TObject);
  private
    A067MW: TA067FRepSostBMW;
    R502ProDtM1:TR502ProDtM1;
    Inizio,Fine,Corrente:TDateTime;
    Tipo:String;
    procedure DistruggiOggetti; override;
  public
    { Public declarations }
    function InizializzaAccesso: Boolean; override;
  protected
    procedure ImpostazioniWC700; override;
    procedure InizioElaborazione; override;
    function TotalRecordsElaborazione: Integer; override;
    function CurrentRecordElaborazione: Integer; override;
    procedure ElaboraElemento; override;
    function ElementoSuccessivo: Boolean; override;
    procedure FineCicloElaborazione; override;
  end;

implementation

{$R *.dfm}

procedure TWA067FRepSostB.IWAppFormCreate(Sender: TObject);
begin
  A067MW:=TA067FRepSostBMW.Create(Self);
  inherited;
  grdC700:=TmedpIWC700NavigatorBar.Create(Self);//Danilo: creato prima di AttivaGestioneC700 per impostare le altre proprietà non standard
  grdC700.AttivaBrowse:=False;
  A067MW.selAnagrafe:=grdC700.selAnagrafe;
  AttivaGestioneC700;
  with A067MW.Q265 do
    while not Eof do
    begin
      cmbCausale.AddRow(FieldByName('CODICE').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
end;

function TWA067FRepSostB.InizializzaAccesso: Boolean;
begin
  Result:=AccessoAbilitato and (not SolaLettura);
end;

procedure TWA067FRepSostB.ImpostazioniWC700;
begin
  inherited;
  with grdC700.WC700FM do
  begin
    C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
    C700DataLavoro:=Parametri.DataLavoro;
  end;
end;

procedure TWA067FRepSostB.edtDaDataAsyncChange(Sender: TObject; EventParams: TStringList);
var D:TDateTime;
    A,M,G:Word;
begin
  try
    D:=StrToDate(edtDaData.Text);
    DecodeDate(D,A,M,G);
    try
      if D > StrToDate(edtAData.Text) then
        edtAData.Text:=FormatDateTime('dd/mm/yyyy',EncodeDate(A,M,R180GiorniMese(D)));
    except
      edtAData.Text:=FormatDateTime('dd/mm/yyyy',EncodeDate(A,M,R180GiorniMese(D)));
    end;
  except
  end;
  try
    grdC700.WC700FM.C700DataLavoro:=StrToDate(edtAData.Text);
  except
    grdC700.WC700FM.C700DataLavoro:=Parametri.DataLavoro;
  end;
end;


procedure TWA067FRepSostB.edtADataAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  try
    grdC700.WC700FM.C700DataLavoro:=StrToDate(edtAData.Text);
  except
    grdC700.WC700FM.C700DataLavoro:=Parametri.DataLavoro;
  end;
end;

procedure TWA067FRepSostB.btnInserisciClick(Sender: TObject);
begin
  Tipo:=IfThen(Sender = btnInserisci,'I','E');
  try
    Inizio:=StrToDate(edtDaData.Text);
    Fine:=StrToDate(edtAData.Text);
  except
    raise Exception.Create(A000MSG_ERR_DATE_RIFERIMENTO);
  end;
  if Inizio > Fine then
    raise Exception.Create(A000MSG_ERR_DATE_INVERTITE);
  if cmbCausale.Text = '' then
    raise Exception.Create(A000MSG_A067_ERR_NO_CAUSALE);
  if VarToStr(A067MW.Q265.Lookup('CODICE',cmbCausale.Text,'CODICE')) = '' then
    raise Exception.Create(Format(A000MSG_ERR_FMT_ELEM_LISTA,[lblCausale.Caption]));
  StartElaborazioneCiclo((Sender as TmeIWButton).HTMLName);
end;

procedure TWA067FRepSostB.InizioElaborazione;
begin
  R502ProDtM1:=TR502ProDtM1.Create(nil);
  R502ProDtM1.PeriodoConteggi(Inizio,Fine);
  R180SetVariable(grdC700.SelAnagrafe,'DataLavoro',Fine);
  grdC700.SelAnagrafe.Open;
  grdC700.SelAnagrafe.First;
  A067MW.ApriQ040(cmbCausale.Text,grdC700.SelAnagrafe.FieldByName('Progressivo').AsInteger,Inizio,Fine);
  Corrente:=Inizio;
end;

function TWA067FRepSostB.TotalRecordsElaborazione: Integer;
begin
  Result:=grdC700.selAnagrafe.RecordCount * Trunc(Fine - Inizio + 1);
end;

function TWA067FRepSostB.CurrentRecordElaborazione: Integer;
begin
  Result:=((grdC700.selAnagrafe.RecNO - 1) * Trunc(Fine - Inizio + 1)) + Trunc(Corrente - Inizio + 1);
end;

procedure TWA067FRepSostB.DistruggiOggetti;
begin
  inherited;
  FreeAndNil(R502ProDtM1);
end;

procedure TWA067FRepSostB.ElaboraElemento;
var i:Integer;
begin
  R502ProDtM1.Conteggi('Anomalie',grdC700.SelAnagrafe.FieldByName('Progressivo').AsInteger,Corrente);
  if R502ProDtM1.Blocca = 0 then
    //Controllo le anomalie di terzo livello
    for i:=1 to R502ProDtM1.n_anom3 do
      if R502ProDtM1.tanom3riscontrate[i].ta3puntdesc = 4 then
        A067MW.CorreggiAnomalia(Tipo,cmbCausale.Text,grdC700.SelAnagrafe.FieldByName('Progressivo').AsInteger,Corrente,R502ProDtM1.tanom3riscontrate[i].ta3timb);
  Corrente:=Corrente + 1;
end;

function TWA067FRepSostB.ElementoSuccessivo: Boolean;
begin
  Result:=Corrente <= Fine;
  if not Result then
  begin
    grdC700.selAnagrafe.Next;
    if not grdC700.selAnagrafe.EOF then
    begin
      Result:=True;
      A067MW.ApriQ040(cmbCausale.Text,grdC700.SelAnagrafe.FieldByName('Progressivo').AsInteger,Inizio,Fine);
      Corrente:=Inizio;
    end;
  end;
end;

procedure TWA067FRepSostB.FineCicloElaborazione;
begin
  FreeAndNil(R502ProDtM1);
  AggiornaAnagr;
end;

end.
