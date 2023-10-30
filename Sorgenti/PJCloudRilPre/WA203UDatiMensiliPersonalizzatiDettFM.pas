unit WA203UDatiMensiliPersonalizzatiDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, IWCompEdit, IWDBStdCtrls, meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompLabel,
  meIWLabel, IWCompMemo, meIWDBMemo, System.ImageList, Vcl.ImgList, IWImageList, meIWImageList, IWCompButton, meIWButton, medpIWMultiColumnComboBox, Data.DB,
  C190FunzioniGeneraliWeb, C180FunzioniGenerali, IWCompExtCtrls, IWDBExtCtrls, meIWDBRadioGroup, meIWImageFile;

type
  TWA203FDatiMensiliPersonalizzatiDettFM = class(TWR205FDettTabellaFM)
    lblDato: TmeIWLabel;
    dedtDato: TmeIWDBEdit;
    meIWLabel1: TmeIWLabel;
    meIWDBEdit1: TmeIWDBEdit;
    lblCodiceVoce: TmeIWLabel;
    dedtOrdinamento: TmeIWDBEdit;
    lblOrdinamento: TmeIWLabel;
    desdDesc: TmeIWDBEdit;
    lblDescrizione: TmeIWLabel;
    lblEspressione: TmeIWLabel;
    dmemoEspressione: TmeIWDBMemo;
    lblDescVocePaghe: TmeIWLabel;
    lblSelezioniAnagrafiche: TmeIWLabel;
    dedtSelezioneAnagrafiche: TmeIWDBEdit;
    cmbVocePaghe: TMedpIWMultiColumnComboBox;
    drgpTipo: TmeIWDBRadioGroup;
    lblTipo: TmeIWLabel;
    imgApplicaAnagrafiche: TmeIWImageFile;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure cmbVocePagheAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure imgApplicaAnagraficheClick(Sender: TObject);
  private
    { Private declarations }
    procedure CaricaMultiColumnComboBox; override;
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
    procedure resultSelAnagrafe(Sender: TObject; Result: Boolean);
    procedure AggiornaLblVoce;
  public
    { Public declarations }
    procedure EvtStateChange;
  end;

implementation

uses WA203UDatiMensiliPersonalizzatiDM, WA203UDatiMensiliPersonalizzati;

{$R *.dfm}
procedure TWA203FDatiMensiliPersonalizzatiDettFM.cmbVocePagheAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with TWA203FDatiMensiliPersonalizzatiDM(WR302DM) do
  begin
    if Index <> -1 then
    begin
      selTabella.FieldByName('VOCEPAGHE').AsString:=cmbVocePaghe.Text;
      lblDescVocePaghe.Caption:=VarToStr(A203MW.selP200.LookUp('COD_VOCE', selTabella.FieldByName('VOCEPAGHE').AsString, 'DESCRIZIONE'));
    end
    else
    begin
      selTabella.FieldByName('VOCEPAGHE').AsString:='';
      lblDescVocePaghe.Caption:='';
    end;
  end;
end;

procedure TWA203FDatiMensiliPersonalizzatiDettFM.CaricaMultiColumnComboBox;
begin
  //load cmbVocePaghe
  with (WR302DM as TWA203FDatiMensiliPersonalizzatiDM).A203MW.selP200 do
  begin
    First;
    while not Eof do
    begin
      cmbVocePaghe.AddRow(FieldByName('COD_VOCE').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
  end;
end;

procedure TWA203FDatiMensiliPersonalizzatiDettFM.AggiornaLblVoce;
begin
  with (WR302DM as TWA203FDatiMensiliPersonalizzatiDM) do
  begin
    lblDescVocePaghe.Caption:=A203MW.strDescVocePaghe;
  end;
end;

procedure TWA203FDatiMensiliPersonalizzatiDettFM.DataSet2Componenti;
begin
  inherited;
  with (WR302DM as TWA203FDatiMensiliPersonalizzatiDM) do
  begin
    cmbVocePaghe.Text:=SelTabella.FieldByName('VOCEPAGHE').AsString;
    AggiornaLblVoce;
    //lblDescVocePaghe.Caption:=A203MW.strDescVocePaghe;
  end;
end;

procedure TWA203FDatiMensiliPersonalizzatiDettFM.Componenti2DataSet;
begin
  inherited;
  with (WR302DM as TWA203FDatiMensiliPersonalizzatiDM) do
  begin
    selTabella.FieldByName('VocePaghe').AsString:=cmbVocePaghe.Text;
  end;
end;

procedure TWA203FDatiMensiliPersonalizzatiDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  lblDescVocePaghe.Caption:='';
  inherited;
  DataSet2Componenti;
  with (WR302DM as TWA203FDatiMensiliPersonalizzatiDM) do
  begin
    A203MW.NotificaAfterScroll:=AggiornaLblVoce;
  end;
end;

procedure TWA203FDatiMensiliPersonalizzatiDettFM.EvtStateChange;
begin
  with (WR302DM as TWA203FDatiMensiliPersonalizzatiDM) do
  begin
    cmbVocePaghe.Enabled:=(SelTabella.State in [dsInsert,dsEdit]);// and (A016MW.selP200.RecordCount > 0);
    //EvtDataChange;
  end;
end;

procedure TWA203FDatiMensiliPersonalizzatiDettFM.imgApplicaAnagraficheClick(Sender: TObject);
begin
  inherited;
  TWA203FDatiMensiliPersonalizzati(Self.Owner).AttivaGestioneC700L;

  with TWA203FDatiMensiliPersonalizzatiDM(WR302DM).selTabella do
  begin
  if State in [dsEdit,dsInsert] then
    with TWA203FDatiMensiliPersonalizzati(Self.Owner).grdC700 do
    begin
      WC700FM.ResultEvent:=resultSelAnagrafe;
      actSelezioneAnagraficheExecute(nil);
    end;
  end;

end;

procedure TWA203FDatiMensiliPersonalizzatiDettFM.resultSelAnagrafe(Sender: TObject; Result: Boolean);
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
    S:=Trim(TWA203FDatiMensiliPersonalizzati(Self.Owner).grdC700.WC700FM.SQLCreato.Text);
    if Pos('ORDER BY',UpperCase(S)) > 0 then
      S:=Copy(S,1,Pos('ORDER BY',UpperCase(S)) - 1);
    TWA203FDatiMensiliPersonalizzatiDM(WR302DM).selTabella.FieldByName('SELEZIONE_ANAGRAFE').AsString:=TrasformaV430(S);
  end;
  FreeAndNil(TWA203FDatiMensiliPersonalizzati(Self.Owner).grdC700);
end;

end.
