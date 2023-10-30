unit WA121UOrganizzSindacaliDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, DB,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompExtCtrls, meIWImageFile,
  medpIWMultiColumnComboBox, IWCompButton, meIWButton, IWCompEdit, meIWEdit,
  IWCompCheckbox, IWDBStdCtrls, meIWDBCheckBox, meIWDBEdit, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWCompLabel, meIWLabel,
  WC013UCheckListFM, C190FunzioniGeneraliWeb, C180FunzioniGenerali, A000UInterfaccia, A000UCostanti;

type
  TWA121FOrganizzSindacaliDettFM = class(TWR205FDettTabellaFM)
    lblCodice: TmeIWLabel;
    dedtCodice: TmeIWDBEdit;
    dedtCodMinisteriale: TmeIWDBEdit;
    lblCodMinisteriale: TmeIWLabel;
    dedtVocePaghe: TmeIWDBEdit;
    lblVocePaghe: TmeIWLabel;
    lblDescrizione: TmeIWLabel;
    dedtDescrizione: TmeIWDBEdit;
    chkRsu: TmeIWDBCheckBox;
    chkRaggruppamento: TmeIWDBCheckBox;
    lblSindacati: TmeIWLabel;
    edtSindacati: TmeIWEdit;
    btnSindacati: TmeIWButton;
    dedtFiltro: TmeIWDBEdit;
    lblFiltro: TmeIWLabel;
    lblCausaleCompetenze: TmeIWLabel;
    cmbCausaleCompetenze: TMedpIWMultiColumnComboBox;
    cmbCausaleCompetenzeNo: TMedpIWMultiColumnComboBox;
    lblCausaleCompetenzeNo: TmeIWLabel;
    imgSelezione: TmeIWImageFile;
    dedtSindacati: TmeIWDBEdit;
    lblDescrCausaleCompetenze: TmeIWLabel;
    lblDescrCausaleCompetenzeNo: TmeIWLabel;
    lblCodRegionale: TmeIWLabel;
    dedtCodRegionale: TmeIWDBEdit;
    procedure chkRaggruppamentoClick(Sender: TObject);
    procedure chkRsuAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure btnSindacatiClick(Sender: TObject);
    procedure imgSelezioneClick(Sender: TObject);
    procedure cmbCausaleCompetenzeAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
  private
    WC013: TWC013FCheckListFM;
    procedure CaricaMultiColumnCombobox; override;
    procedure DataSet2Componenti; override;
    procedure AggiornaDescrizioni;
    procedure resultSelAnagrafe(Sender: TObject; Result: Boolean);
    procedure cklistSindacati(Sender: TObject; Result: Boolean);
  public
    { Public declarations }
  end;

implementation

uses WA121UOrganizzSindacali, WA121UOrganizzSindacaliDM;

{$R *.dfm}

procedure TWA121FOrganizzSindacaliDettFM.chkRsuAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  chkRaggruppamento.Enabled:=not chkRsu.Checked;
  edtSindacati.Enabled:=not chkRsu.Checked;
  lblSindacati.Enabled:=not chkRsu.Checked;
  if chkRsu.Checked then
    chkRaggruppamento.Checked:=False;
end;

procedure TWA121FOrganizzSindacaliDettFM.cmbCausaleCompetenzeAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  AggiornaDescrizioni;
end;

procedure TWA121FOrganizzSindacaliDettFM.DataSet2Componenti;
begin
  inherited;
  chkRaggruppamentoClick(nil);
end;

procedure TWA121FOrganizzSindacaliDettFM.imgSelezioneClick(Sender: TObject);
begin
  with (WR302DM as TWA121FOrganizzSindacaliDM).selTabella do
  begin
  if State in [dsEdit,dsInsert] then
    with (Self.Owner as TWA121FOrganizzSindacali).grdC700 do
    begin
      WC700FM.ResultEvent:=resultSelAnagrafe;
      actSelezioneAnagraficheExecute(nil);
    end;
  end;
end;

procedure TWA121FOrganizzSindacaliDettFM.resultSelAnagrafe(Sender: TObject; Result: Boolean);
  function TrasformaV430(X:String):String;
    var Apice:Boolean;
        i:Integer;
    begin
      Result:='';
      i:=1;
      Apice:=False;
      while i <= Length(X) do
      begin
        if X[i] = '''' then
          Apice:=not Apice;
        if (not Apice) and (Copy(X,i,5) = 'V430.') then
        begin
          X:=Copy(X,1,i - 1) + Copy(X,i + 5,4) + '.' + Copy(X,i + 9,Length(X));
          inc(i,5);
        end;
        inc(i);
      end;
      Result:=EliminaRitornoACapo(Trim(X));
    end;
var S:string;
begin
  if result then
  begin
    S:=Trim((Self.Owner as TWA121FOrganizzSindacali).grdC700.WC700FM.SQLCreato.Text);
    if Pos('ORDER BY',UpperCase(S)) > 0 then
      S:=Copy(S,1,Pos('ORDER BY',UpperCase(S)) - 1);
    (WR302DM as TWA121FOrganizzSindacaliDM).selTabella.FieldByName('FILTRO').AsString:=TrasformaV430(S);
  end;
end;

procedure TWA121FOrganizzSindacaliDettFM.btnSindacatiClick(Sender: TObject);
begin
  (WR302DM as TWA121FOrganizzSindacaliDM).A121MW.PreparaListaSindacati;
  WC013:=TWC013FCheckListFM.Create(Self.Parent);
  with WC013 do
  begin
    ckList.Items.Assign((WR302DM as TWA121FOrganizzSindacaliDM).A121MW.ListaSindacati);
    while not (WR302DM as TWA121FOrganizzSindacaliDM).A121MW.selT240A.Eof do
    begin
      ckList.Values.Add(Trim((WR302DM as TWA121FOrganizzSindacaliDM).A121MW.selT240A.FieldByName('CODICE').AsString));
      (WR302DM as TWA121FOrganizzSindacaliDM).A121MW.selT240A.Next;
    end;
    (WR302DM as TWA121FOrganizzSindacaliDM).A121MW.selT240A.Close;
    ResultEvent:=cklistSindacati;
    C190PutCheckList(dedtSindacati.Text,5,ckList);
    WC013.Visualizza(0,0,'Elenco sindacati');
  end;
end;

procedure TWA121FOrganizzSindacaliDettFM.cklistSindacati(Sender: TObject; Result: Boolean);
begin
  if Result then
    (WR302DM as TWA121FOrganizzSindacaliDM).selTabella.FieldByName('SINDACATI_RAGGRUPPATI').AsString:=Trim(C190GetCheckList(10,WC013.ckList));
end;

procedure TWA121FOrganizzSindacaliDettFM.CaricaMultiColumnCombobox;
begin
  inherited;
  with (WR302DM as TWA121FOrganizzSindacaliDM).A121MW.selT265 do
  begin
    First;
    cmbCausaleCompetenze.Items.Clear;
    cmbCausaleCompetenzeNo.Items.Clear;
    while not Eof do
    begin
      cmbCausaleCompetenze.AddRow(FieldByName('CODICE').Asstring+';'+FieldByName('DESCRIZIONE').Asstring);
      cmbCausaleCompetenzeNo.AddRow(FieldByName('CODICE').Asstring+';'+FieldByName('DESCRIZIONE').Asstring);
      Next;
    end;
  end;
  AggiornaDescrizioni;
end;

procedure TWA121FOrganizzSindacaliDettFM.chkRaggruppamentoClick(Sender: TObject);
begin
  chkRsu.Enabled:=not chkRaggruppamento.Checked;
  dEdtSindacati.Enabled:=chkRaggruppamento.Checked;
  dEdtSindacati.Visible:=chkRaggruppamento.Checked;
  edtSindacati.Enabled:=(not chkRaggruppamento.Checked) and (not chkRsu.Checked);
  edtSindacati.Visible:=(not chkRaggruppamento.Checked);
  edtSindacati.ReadOnly:=True;
  if dEdtSindacati.Enabled then
  begin
    btnSindacati.Enabled:=(WR302DM as TWA121FOrganizzSindacaliDM).selTabella.State in [dsInsert, dsEdit];
    lblSindacati.Caption:='Sindacati raggruppati';
  end
  else
  begin
    btnSindacati.Enabled:=False;
    lblSindacati.Caption:='Raggruppato in';
  end;
  lblSindacati.Enabled:=(chkRaggruppamento.Checked) or ((lblSindacati.Caption = 'Raggruppato in')and (not chkRsu.Checked));
end;

procedure TWA121FOrganizzSindacaliDettFM.AggiornaDescrizioni;
begin
  lblDescrCausaleCompetenze.Caption:='';
  lblDescrCausaleCompetenzeNo.Caption:='';
  if Trim(cmbCausaleCompetenze.Text) <> '' then
    lblDescrCausaleCompetenze.Caption:=(WR302DM as TWA121FOrganizzSindacaliDM).A121MW.selT265.Lookup('CODICE',Trim(cmbCausaleCompetenze.Text),'DESCRIZIONE');
  if Trim(cmbCausaleCompetenzeNo.Text) <> '' then
    lblDescrCausaleCompetenzeNo.Caption:=(WR302DM as TWA121FOrganizzSindacaliDM).A121MW.selT265.Lookup('CODICE',Trim(cmbCausaleCompetenzeNo.Text),'DESCRIZIONE');
end;


end.
