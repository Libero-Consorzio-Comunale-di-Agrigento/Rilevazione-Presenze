unit WA172USchedeQuantIndividualiDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompEdit, IWDBStdCtrls,
  meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompLabel, meIWLabel, WA172USchedeQuantIndividualiDM,
  medpIWMultiColumnComboBox, meIWDBLabel, IWCompExtCtrls, meIWImageFile, DB,
  C180FunzioniGenerali, A000UInterfaccia, IWCompCheckbox, meIWDBCheckBox,
  IWCompListbox, meIWDBLookupComboBox, meIWEdit, A172USchedeQuantIndividualiMW,
  IWCompGrids, meIWGrid, StrUtils, C190FunzioniGeneraliWeb, medpIWImageButton,
  A000UCostanti, WR100UBase;
type
  TWA172FSchedeQuantIndividualiDettFM = class(TWR205FDettTabellaFM)
    lblAnno: TmeIWLabel;
    dedtAnno: TmeIWDBEdit;
    lblCodice: TmeIWLabel;
    dedtCodice: TmeIWDBEdit;
    lblDescrizione: TmeIWLabel;
    dedtDescrizione: TmeIWDBEdit;
    lblDataRif: TmeIWLabel;
    dedtDataRif: TmeIWDBEdit;
    lblStato: TmeIWLabel;
    lblTipoQuota: TmeIWLabel;
    cmbTipoQuota: TMedpIWMultiColumnComboBox;
    lblDescTipoQuota: TmeIWDBLabel;
    lblFiltroAnagrafe: TmeIWLabel;
    dedtFiltroAnagrafe: TmeIWDBEdit;
    imgC700SelezioneAnagrafe: TmeIWImageFile;
    lblTolleranza: TmeIWLabel;
    dedtTolleranza: TmeIWDBEdit;
    dchkSupervisore: TmeIWDBCheckBox;
    dCmbSupervisore: TmeIWDBLookupComboBox;
    edtNumOreTotale: TmeIWEdit;
    lblNumOreTotale: TmeIWLabel;
    edtImpTotale: TmeIWEdit;
    lblImpTotale: TmeIWLabel;
    lblTotOreAssegn: TmeIWLabel;
    edtMaxOre: TmeIWEdit;
    lblTotAssegn: TmeIWLabel;
    edtMaxImp: TmeIWEdit;
    lblTotOreAccett: TmeIWLabel;
    edtTotOreAccett: TmeIWEdit;
    lblTotAccett: TmeIWLabel;
    edtTotAccett: TmeIWEdit;
    lblPagamenti: TmeIWLabel;
    grdPagamenti: TmeIWGrid;
    btnAnomalie: TmedpIWImageButton;
    procedure dedtAnnoAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure cmbTipoQuotaAsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure imgC700SelezioneAnagrafeClick(Sender: TObject);
    procedure dchkSupervisoreAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
  private
    procedure ResultSelAnagrafe(Sender: TObject; Result: Boolean);
    procedure CaricaGrdPagamenti;
  public
    function AggiornaTotali: TTotali;
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
    procedure AbilitaComponenti; override;
    procedure CaricaMultiColumnCombobox; override;
  end;

implementation
uses WA172USchedeQuantIndividuali;

{$R *.dfm}

procedure TWA172FSchedeQuantIndividualiDettFM.DataSet2Componenti;
var
  c: Integer;
  r: Integer;
begin
  inherited;
  with (WR302DM AS TWA172FSchedeQuantIndividualiDM) do
  begin
    lblStato.Caption:=A172FSchedeQuantIndividualiMW.DescrizioneStato;
    cmbTipoQuota.Text:=SelTabella.FieldByName('CODTIPOQUOTA').AsString;

    for c:=1 to 12 do
    begin
      r:=0;
      inc(r);
      with (grdPagamenti.Cell[r,c].Control as TmeIWEdit) do
      begin
        Text:=SelTabella.FieldByName('PAG' + IntToStr(c) +'_MAX').AsString;
      end;
      inc(r);
      with (grdPagamenti.Cell[r,c].Control as TmeIWEdit) do
      begin
        Text:=IfThen(SelTabella.FieldByName('PAG' + IntToStr(c) + '_PERC').AsFloat = -1,'',SelTabella.FieldByName('PAG' + IntToStr(c) + '_PERC').AsString);
      end;
    end;
  end;
end;

procedure TWA172FSchedeQuantIndividualiDettFM.Componenti2DataSet;
var
  i: Integer;
begin
  inherited;
  with (WR302DM AS TWA172FSchedeQuantIndividualiDM) do
  begin
    for i:=1 to 12 do
    begin
      with (grdPagamenti.Cell[1,i].Control as TmeIWEdit) do
      begin
        selTabella.FieldByName('PAG' + IntToStr(i) + '_MAX').AsString:=Trim(Text);
      end;
      with (grdPagamenti.Cell[2,i].Control as TmeIWEdit) do
      begin
        selTabella.FieldByName('PAG' + IntToStr(i) + '_PERC').AsFloat:=StrToFloatDef(Text,-1);
      end;
    end;
  end;
end;

procedure TWA172FSchedeQuantIndividualiDettFM.AbilitaComponenti;
var
  bEdit: Boolean;
begin
  inherited;
  with WR302DM.selTabella do
  begin
    bEdit:=state in [dsEdit,dsInsert];
    if bEdit then
    begin
      dcmbSupervisore.Enabled:=FieldByName('SUPERVISIONE').AsString = 'S';
      if FieldByName('SUPERVISIONE').AsString <> 'S' then
        FieldByName('PROG_SUPERVISORE').AsInteger:=0;
    end;
    edtNumOreTotale.ReadOnly:=True;
    edtImpTotale.ReadOnly:=True;
    edtMaxOre.ReadOnly:=True;
    edtMaxImp.ReadOnly:=True;
    edtTotOreAccett.ReadOnly:=True;
    edtTotAccett.ReadOnly:=True;
    btnAnomalie.Enabled:=False;
  end;
end;

procedure TWA172FSchedeQuantIndividualiDettFM.CaricaMultiColumnCombobox;
begin
  inherited;
  with (WR302DM AS TWA172FSchedeQuantIndividualiDM).A172FSchedeQuantIndividualiMW do
  begin
    cmbTipoQuota.Items.Clear;
    selT765.First;
    while not selT765.Eof do
    begin
      cmbTipoQuota.AddRow(Format('%s;%s',[selT765.FieldByName('CODICE').AsString,selT765.FieldByName('DESCRIZIONE').AsString]));
      selT765.Next;
    end;
  end;
end;

procedure TWA172FSchedeQuantIndividualiDettFM.dchkSupervisoreAsyncClick(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TWA172FSchedeQuantIndividualiDettFM.dedtAnnoAsyncChange(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  if (dedtAnno.Text <> '') and (WR302DM.selTabella.FieldByName('DATARIF').IsNull) then
    WR302DM.selTabella.FieldByName('DATARIF').AsDateTime:=StrToDate('31/12/' + dedtAnno.Text);
  (WR302DM as TWA172FSchedeQuantIndividualiDM).A172FSchedeQuantIndividualiMW.SettaDatasetValutatori;
  dCmbSupervisore.Invalidate;
end;

procedure TWA172FSchedeQuantIndividualiDettFM.imgC700SelezioneAnagrafeClick(
  Sender: TObject);
var
  dDataSelAnagrafe: TDateTime;
begin
  inherited;

  if WR302DM.selTabella.State in [dsEdit,dsInsert] then
  begin
    with (Self.Owner as TWA172FSchedeQuantIndividuali).grdC700 do
    begin
      dDataSelAnagrafe:=Parametri.DataLavoro;
      if WR302DM.selTabella.FieldByName('DATARIF').AsDateTime <> DATE_NULL then
        dDataSelAnagrafe:=WR302DM.selTabella.FieldByName('DATARIF').AsDateTime;
      WC700FM.C700DataLavoro:=dDataSelAnagrafe;
      WC700FM.C700DataDal:=dDataSelAnagrafe;
      if WC700FM.C700SettaPeriodoSelAnagrafe(dDataSelAnagrafe,dDataSelAnagrafe) then
        SelAnagrafe.CloseAll;
      SelAnagrafe.Open;
      WC700FM.ResultEvent:=ResultSelAnagrafe;
      actSelezioneAnagraficheExecute(nil);
    end;
  end;
end;

procedure TWA172FSchedeQuantIndividualiDettFM.IWFrameRegionCreate(
  Sender: TObject);
begin
  CaricaGrdPagamenti;
  inherited;
  dCmbSupervisore.ListSource:=(WR302DM as TWA172FSchedeQuantIndividualiDM).A172FSchedeQuantIndividualiMW.dsrValutatori;
  btnAnomalie.Enabled:=False;
end;

procedure TWA172FSchedeQuantIndividualiDettFM.CaricaGrdPagamenti;
var
  r,c: Integer;
begin
  // Deallocazione controlli della griglia e pulizia dati
  C190PulisciIWGrid(grdPagamenti,True);

  //Caricamento Grid
  grdPagamenti.RowCount:=3;
  grdPagamenti.ColumnCount:=13;

  c:=0;
  grdPagamenti.Cell[1,c].Text:='Max.ore';
  grdPagamenti.Cell[2,c].Text:='% ore';

  for c:=1 to 12 do
  begin
    r:=0;
    grdPagamenti.Cell[r,c].Text:=R180NomeMese(c);
    inc(r);
    grdPagamenti.Cell[r,c].Control:=TmeIWEdit.Create(Self);
    grdPagamenti.Cell[r,c].Control.Parent:=IWFrameRegion;
    with (grdPagamenti.Cell[r,c].Control as TmeIWEdit) do
    begin
      Css:='input_hour_hhhmm width5chr';
      Text:='';
    end;
    inc(r);
    grdPagamenti.Cell[r,c].Control:=TmeIWEdit.Create(Self);
    grdPagamenti.Cell[r,c].Control.Parent:=IWFrameRegion;
    with (grdPagamenti.Cell[r,c].Control as TmeIWEdit) do
    begin
      Css:='input_num_nnndd width5chr';
      Text:='';
    end;
  end;
end;

function TWA172FSchedeQuantIndividualiDettFM.AggiornaTotali: TTotali;
var
  Totali: TTotali;
begin
  Totali:=(WR302DM as TWA172FSchedeQuantIndividualiDM).A172FSchedeQuantIndividualiMW.CalcolaTotali;
  edtNumOreTotale.Text:=R180MinutiOre(Totali.TotaleOreAssegn);
  edtImpTotale.Text:=Trim(Format('%15.2n',[Totali.TotaleAssegn]));
  edtMaxOre.Text:=R180MinutiOre(Totali.MaxOre);
  edtMaxImp.Text:=Trim(Format('%15.2n',[Totali.MaxImp]));

  edtTotOreAccett.Text:=R180MinutiOre(Totali.TotaleOreAccett);
  if (Totali.MaxOre <> 0) and
     (Totali.TotaleOreAccett > Totali.MaxOre) then
  begin
    lblTotOreAccett.css:=StringReplace(lblTotOreAccett.css,'font_neroImp','font_rossoImp',[rfReplaceAll]);
    edtTotOreAccett.css:=StringReplace(edtTotOreAccett.css,'font_neroImp','font_rossoImp',[rfReplaceAll]);
  end
  else
  begin
    lblTotOreAccett.css:=StringReplace(lblTotOreAccett.css,'font_rossoImp','font_neroImp',[rfReplaceAll]);
    edtTotOreAccett.css:=StringReplace(edtTotOreAccett.css,'font_rossoImp','font_neroImp',[rfReplaceAll]);
  end;

  edtTotAccett.Text:=Trim(Format('%15.2n',[Totali.TotaleAccett]));

  if (Totali.MaxImp <> 0) and
     (R180AzzeraPrecisione(Totali.MaxImp - Totali.TotaleAccett,2) < 0) then
  begin
    lblTotAccett.css:=StringReplace(lblTotAccett.css,'font_neroImp','font_rossoImp',[rfReplaceAll]);
    edtTotAccett.css:=StringReplace(edtTotAccett.css,'font_neroImp','font_rossoImp',[rfReplaceAll]);
  end
  else
  begin
    lblTotAccett.css:=StringReplace(lblTotAccett.css,'font_rossoImp','font_neroImp',[rfReplaceAll]);
    edtTotAccett.css:=StringReplace(edtTotAccett.css,'font_rossoImp','font_neroImp',[rfReplaceAll]);
  end;

  Result:=Totali;
end;

procedure TWA172FSchedeQuantIndividualiDettFM.btnAnomalieClick(Sender: TObject);
var
  Params: String;
begin
  inherited;
  Params:='AZIENDA=' + Parametri.Azienda + ParamDelimiter +
          'OPERATORE=' + Parametri.Operatore + ParamDelimiter +
          'MASCHERA=' + (Self.parent as TWR100FBase).medpCodiceForm + ParamDelimiter +
          'ID=' + IntToStr(RegistraMsg.ID) + ParamDelimiter +
          'TIPO=A,B,I';
  (Self.parent as TWR100FBase).accediForm(201,Params,True);
end;

procedure TWA172FSchedeQuantIndividualiDettFM.cmbTipoQuotaAsyncChange(
  Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  WR302DM.selTabella.FieldByName('CODTIPOQUOTA').AsString:=cmbTipoQuota.Text;
end;

procedure TWA172FSchedeQuantIndividualiDettFM.ResultSelAnagrafe(Sender: TObject; Result: Boolean);
var S:string;
begin
  if Result then
  begin
    S:=Trim((Self.Owner as TWA172FSchedeQuantIndividuali).grdC700.WC700FM.SQLCreato.Text);
    if Pos('ORDER BY',UpperCase(S)) > 0 then
      S:=Copy(S,1,Pos('ORDER BY',UpperCase(S)) - 1);
    WR302DM.selTabella.FieldByName('FILTRO_ANAGRAFE').AsString:=S.Replace(#13#10,' ',[rfReplaceAll]);
  end;
end;
end.
